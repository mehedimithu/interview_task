import 'package:flutter/material.dart';
import 'package:task/models/blogs.dart';
import 'package:task/pages/blogs_categories.dart';
import 'package:task/repositories/blogs_api_client.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<BlogsModel> blogsModel;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    blogsModel = APIClient().getBlogs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 110,
        title: Text("Blogs"),
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: IconButton(
            icon: Icon(Icons.apps),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        elevation: 10,
        child: Container(
          width: 337,
          height: 896,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/shape.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                margin: EdgeInsets.all(1),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'INTERVIEW TASK',
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  '',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Md.Mehedi Hasan', style: TextStyle(color: Colors.white, fontSize: 14),),
                    SizedBox(height: 10),
                    Text('github.com/mehedimithu/task.git', style: TextStyle(color: Colors.white, fontSize: 13),),
                    SizedBox(height: 5),
                    Text('mhasan172036@mscse.uiu.ac.bd', style: TextStyle(color: Colors.white, fontSize: 14),),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            child: FutureBuilder<BlogsModel>(
              future: blogsModel,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.blogs.length,
                    itemBuilder: (context, index) {
                      var blog = snapshot.data.blogs[index];
                      return Container(
                        height: 100,
                        margin: const EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              InkWell(
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image.network(
                                      blog.coverPhoto,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BlogsCatagories()));
                                },
                              ),
                              SizedBox(width: 10),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${blog.id}',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.deepOrange,
                                      ),
                                    ),
                                    InkWell(
                                      child: Text(
                                        blog.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BlogsCatagories()));
                                      },
                                    ),
                                    Text(
                                      blog.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else
                  return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
