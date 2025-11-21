import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pix/l10n/app_localizations.dart';
import 'package:pix/ui/theme/theme.dart';
import 'package:pix/widgets/customAppBar.dart';
import 'package:pix/widgets/optimizedListView.dart';

class AdvancedSearchPage extends StatefulWidget {
  const AdvancedSearchPage({Key? key}) : super(key: key);

  static Route<T> getRoute<T>() {
    return MaterialPageRoute(
      builder: (_) => const AdvancedSearchPage(),
    );
  }

  @override
  State<AdvancedSearchPage> createState() => _AdvancedSearchPageState();
}

class _AdvancedSearchPageState extends State<AdvancedSearchPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  
  String _selectedFilter = 'all';
  String _selectedDateRange = 'all';
  bool _verifiedOnly = false;
  bool _hasMedia = false;
  
  List<String> _recentSearches = [];
  List<String> _trendingTopics = [
    '#Flutter',
    '#Pix',
    '#Technology',
    '#Programming',
    '#Mobile',
    '#Development',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadRecentSearches();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _loadRecentSearches() {
    // Load from SharedPreferences in real implementation
    setState(() {
      _recentSearches = [
        'Flutter development',
        'Mobile apps',
        'UI design',
        'Programming tips',
      ];
    });
  }

  void _performSearch(String query) {
    if (query.trim().isEmpty) return;
    
    // Add to recent searches
    setState(() {
      _recentSearches.remove(query);
      _recentSearches.insert(0, query);
      if (_recentSearches.length > 10) {
        _recentSearches = _recentSearches.take(10).toList();
      }
    });
    
    // Perform actual search here
    // Navigator.push(context, SearchResultsPage.getRoute(query, filters));
  }

  void _clearRecentSearches() {
    setState(() {
      _recentSearches.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        isBackButton: true,
        title: localizations.search,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).cardColor,
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  decoration: InputDecoration(
                    hintText: localizations.searchHint,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {});
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  onSubmitted: _performSearch,
                  onChanged: (value) => setState(() {}),
                ),
                const SizedBox(height: 12),
                // Quick Filters
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip(
                        localizations.all,
                        'all',
                        Icons.all_inclusive,
                      ),
                      _buildFilterChip(
                        localizations.people,
                        'people',
                        Icons.people,
                      ),
                      _buildFilterChip(
                        localizations.photos,
                        'photos',
                        Icons.photo,
                      ),
                      _buildFilterChip(
                        localizations.videos,
                        'videos',
                        Icons.video_library,
                      ),
                      _buildFilterChip(
                        localizations.verified,
                        'verified',
                        Icons.verified,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Tab Bar
          Container(
            color: Theme.of(context).cardColor,
            child: TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: localizations.recent),
                Tab(text: localizations.trending),
                Tab(text: localizations.people),
                Tab(text: localizations.media),
              ],
            ),
          ),
          
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildRecentTab(),
                _buildTrendingTab(),
                _buildPeopleTab(),
                _buildMediaTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value, IconData icon) {
    final isSelected = _selectedFilter == value;
    
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : Theme.of(context).iconTheme.color,
            ),
            const SizedBox(width: 4),
            Text(label),
          ],
        ),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedFilter = selected ? value : 'all';
          });
        },
        selectedColor: TwitterColor.dodgerBlue,
        backgroundColor: Theme.of(context).cardColor,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
    );
  }

  Widget _buildRecentTab() {
    final localizations = AppLocalizations.of(context)!;
    
    if (_recentSearches.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              localizations.noRecentSearches,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localizations.recentSearches,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: _clearRecentSearches,
                child: Text(localizations.clearAll),
              ),
            ],
          ),
        ),
        Expanded(
          child: OptimizedListViewBuilder(
            itemCount: _recentSearches.length,
            itemBuilder: (context, index) {
              final search = _recentSearches[index];
              return ListTile(
                leading: const Icon(Icons.history),
                title: Text(search),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _recentSearches.removeAt(index);
                    });
                  },
                ),
                onTap: () {
                  _searchController.text = search;
                  _performSearch(search);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingTab() {
    return OptimizedListViewBuilder(
      padding: const EdgeInsets.all(16),
      itemCount: _trendingTopics.length,
      itemBuilder: (context, index) {
        final topic = _trendingTopics[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: TwitterColor.dodgerBlue,
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              topic,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '${(index + 1) * 1234} posts',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            trailing: const Icon(Icons.trending_up),
            onTap: () {
              _searchController.text = topic;
              _performSearch(topic);
            },
          ),
        );
      },
    );
  }

  Widget _buildPeopleTab() {
    final localizations = AppLocalizations.of(context)!;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            localizations.searchForPeople,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaTab() {
    final localizations = AppLocalizations.of(context)!;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.perm_media_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            localizations.searchForMedia,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}