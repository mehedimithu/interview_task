import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:task/models/blogs.dart';
import 'package:task/pages/homepage.dart';
import 'package:task/repositories/blogs_api_client.dart';

class BlogsCatagories extends StatefulWidget {
  const BlogsCatagories({Key key}) : super(key: key);

  @override
  _BlogsCatagoriesState createState() => _BlogsCatagoriesState();
}

class _BlogsCatagoriesState extends State<BlogsCatagories> {
  Future<BlogsModel> blogsModel;

  @override
  void initState() {
    blogsModel = APIClient().getBlogs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: Text("Description"),
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
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
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ('No.${blog.id}'),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.deepOrange,
                                ),
                              ),
                              Text(
                                ('Title: ${blog.title}'),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                blog.description,
                                maxLines: 11,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 10),
                              Text(
                                ('Categories: ${blog.categories}'),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        hoverColor: Colors.grey,
                                        leading: CircleAvatar(
                                          radius: 33,
                                          backgroundImage:
                                          NetworkImage(blog.author.avatar),
                                        ),
                                        title: Text('Author: ${blog.author.name}'),
                                        subtitle: Text(
                                          ' ID: ${blog.author.id} \n Profession: ${blog.author.profession}',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
      ),
    );
  }
}
