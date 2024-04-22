import 'package:flutter/material.dart';

class DeliveryOrder extends StatefulWidget {
  const DeliveryOrder({super.key});

  @override
  State<DeliveryOrder> createState() => DeliveryOrderState();
}

class DeliveryOrderState extends State<DeliveryOrder> {
  int _type = 1;
  void _handleRadio(Object? e) => setState(() {
        _type = e as int;
      });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String grab = "Grab";
    String gojek = "GoJek";
    String driver = "Manual Driver";

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Delivery Order",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                const Text(
                  "Pilih Metode Delivery Order",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: size.width,
                  height: 55,
                  decoration: BoxDecoration(
                    border: _type == 1
                        ? Border.all(
                            width: 1,
                            color: Colors.black,
                          )
                        : Border.all(
                            width: 0.3,
                            color: Colors.grey,
                          ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 1,
                                groupValue: _type,
                                onChanged: _handleRadio,
                                activeColor: Colors.black,
                              ),
                              Text(
                                grab,
                                style: _type == 1
                                    ? const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      )
                                    : const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                              ),
                            ],
                          ),
                          Image.asset(
                            "assets/images/grab.png",
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: size.width,
                  height: 55,
                  decoration: BoxDecoration(
                    border: _type == 2
                        ? Border.all(
                            width: 1,
                            color: Colors.black,
                          )
                        : Border.all(
                            width: 0.3,
                            color: Colors.grey,
                          ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 2,
                                groupValue: _type,
                                onChanged: _handleRadio,
                                activeColor: Colors.black,
                              ),
                              Text(
                                gojek,
                                style: _type == 2
                                    ? const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      )
                                    : const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                              ),
                            ],
                          ),
                          Image.asset(
                            "assets/images/gojek.png",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: size.width,
                  height: 55,
                  decoration: BoxDecoration(
                    border: _type == 3
                        ? Border.all(
                            width: 1,
                            color: Colors.black,
                          )
                        : Border.all(
                            width: 0.3,
                            color: Colors.grey,
                          ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 3,
                                groupValue: _type,
                                onChanged: _handleRadio,
                                activeColor: Colors.black,
                              ),
                              Text(
                                driver,
                                style: _type == 3
                                    ? const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      )
                                    : const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                              ),
                            ],
                          ),
                          Image.asset(
                            "assets/images/logo_asakami.png",
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                if (_type == 1)
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Grab",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (_type == 2)
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 57, 238, 66),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "GoJek",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Manual Driver",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
