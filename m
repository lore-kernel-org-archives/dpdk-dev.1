Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AE0CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 21:22:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17A07433E0;
	Thu, 11 Jun 2026 23:21:35 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 6F5F2433BF
 for <dev@dpdk.org>; Thu, 11 Jun 2026 23:21:31 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-3042a388168so798358eec.1
 for <dev@dpdk.org>; Thu, 11 Jun 2026 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781212890;
 x=1781817690; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSvf55c5XNE0xNj+ODPZ4oNPDwO/h7WzUcZmaDMbqmM=;
 b=dtV7XEKmIDIJAUzo0GuDXm61+BuLAJnct82il8L2iFXmn93re/I1SauvxqqrTONda1
 E6KFhhbWhFrDYooxEcthptRwhWajwshbyjoslDehDs8vDbjsc5tvsl50sNUH4YAHVW3q
 qBb+UbcQtvEzjWxxPs6LiyYlDwAHAUhXiUBUBBoWkCCk4VnH1z5gzdnTXTwLDKtPpeF2
 Kvilx0YYWXf/pZ5VjB3H66BdInKbw/Cxl3zVCEXJ/4Nr8Qp4BdA9y5B5TVWmu5wfh/1t
 qPBP70p8V2ZWKJ4rD0g4psKs9gPfkElvhP8y3Zx9ASQd63cE6l1SFBREfMWnjGfnbk7/
 LT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212890; x=1781817690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CSvf55c5XNE0xNj+ODPZ4oNPDwO/h7WzUcZmaDMbqmM=;
 b=Z5cESHKEHWKZeTv/HifVCzPfGhve8iQtFkmIw42DKssYkdlaCNUSuvX9f4AeEmqS2v
 rnnWPJnw4dzAfP+uBZ3ikJzOeIApiy3dF4oAn2nJYHyE18hZAkx3KrsWcq1/vJFz6uao
 TiG9PAmLveUu80wOegxXsKbPkno9Ftlode6TALGxxG3+w+P6e/R8TXirR45aCp0HZQyE
 CebJL7qN1X9vBkHsOO5y/5Aj9nch7UWnGyVq/AEnWbx4XkGPgmKF6lWvcVz4s2oFZz0Q
 52p0/YppfvURMlv010NLWcuYW+m/nAT4Ib4ApGTbBnETbGU8gUGU344wMlwMVri9QyUW
 EjjQ==
X-Gm-Message-State: AOJu0YwuX7I21RiOQgZhWvImTRlZXIpCjauEbGCXU6rh2sICrLm2MhxG
 3lO0bH5iYNuqqmdHvlYG/SUMClenPwRgUJZNu9X/K33f70BZUcorXJz//9aHJp1YcSlennzEXp4
 T/0RQ
X-Gm-Gg: Acq92OFya32cmF3HX0llW6gocxbnLXWX7RYYvWLohFV28NEoZlHughnyy8yL+e0VGiR
 2woVQeW07oKOg4sfh9BECzA5ZWy4CLc/6aXBgf1BuXC4WIf4UFubqm3dsqBO/rNOj4HMHLrlz2R
 cpxV6CX4UupjpCTDNJGdEwWViiF/2+1j/zUmCrZA1FM9UgwbJ4jm5ckdqbfJ15Jqb3XObzApUyA
 sZ7MoxHPhbzcuCPQRAUqYu5yWVeCKuh7n6RlxOUcyAeKxzFRVcQo2m2D1+VvNShlR1ll2HI6RLS
 xVGi49IxamtVdlkuNHCSuduKUgVadDHD3c9AnebOnmPJzbB7eJPnNPd+HWcZRcFTT1BSanDVDad
 xKq6qmlIQ4YHqffNmng6ccRJo/A29UJs8UF9NqdMmcqt/Fuw7mOBiZRv78rt66rcZY6xpWZxE2V
 ECUalr1poInCxjegccbRRP3ziPonmxF359KZ8cOcPNSMrodv6PJDIn6ZlLS2YQ/Q==
X-Received: by 2002:a05:7301:1e90:b0:307:286d:c14e with SMTP id
 5a478bee46e88-3081f070209mr204701eec.17.1781212890268; 
 Thu, 11 Jun 2026 14:21:30 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb95450sm546238eec.28.2026.06.11.14.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 14:21:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 08/15] doc: enhance hello_world, intro, IP frag and pipeline
Date: Thu, 11 Jun 2026 14:18:47 -0700
Message-ID: <20260611212119.1026721-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611212119.1026721-1-stephen@networkplumber.org>
References: <20250216230903.124496-1-nandinipersad361@gmail.com>
 <20260611212119.1026721-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Improved documentation across multiple sample applications:

hello_world.rst:
- Minor formatting and clarity improvements

intro.rst:
- Updated sample application descriptions for accuracy
- Fixed formatting and improved readability
- Clarified application purposes and use cases

ip_frag.rst:
- Enhanced command-line option descriptions
- Improved flow explanations
- Fixed terminology and formatting consistency

ip_pipeline.rst:
- Restructured pipeline configuration sections
- Improved CLI command descriptions
- Enhanced clarity of pipeline concepts

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/hello_world.rst |   6 +-
 doc/guides/sample_app_ug/intro.rst       |  34 +++----
 doc/guides/sample_app_ug/ip_frag.rst     |  46 +++++-----
 doc/guides/sample_app_ug/ip_pipeline.rst | 109 ++++++++++++-----------
 4 files changed, 103 insertions(+), 92 deletions(-)

diff --git a/doc/guides/sample_app_ug/hello_world.rst b/doc/guides/sample_app_ug/hello_world.rst
index b7167aa345..603a1d8767 100644
--- a/doc/guides/sample_app_ug/hello_world.rst
+++ b/doc/guides/sample_app_ug/hello_world.rst
@@ -9,7 +9,7 @@ Overview
 --------
 
 The Hello World sample application is an example of the simplest DPDK application that can be written.
-The application simply prints an "helloworld" message on every enabled lcore.
+The application simply prints a "helloworld" message on every enabled lcore.
 
 Compiling the Application
 -------------------------
@@ -21,7 +21,7 @@ The application is located in the ``helloworld`` sub-directory.
 Running the Application
 -----------------------
 
-To run the example in a linux environment:
+To run the example in a Linux environment:
 
 .. code-block:: console
 
@@ -50,7 +50,7 @@ This call finishes the initialization process that was started before main() is
 The argc and argv arguments are provided to the rte_eal_init() function.
 The value returned is the number of parsed arguments.
 
-Starting Application Unit Lcores
+Starting Application on Lcores
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Once the EAL is initialized, the application is ready to launch a function on an lcore.
diff --git a/doc/guides/sample_app_ug/intro.rst b/doc/guides/sample_app_ug/intro.rst
index a19c0b8c13..dfd0254b0c 100644
--- a/doc/guides/sample_app_ug/intro.rst
+++ b/doc/guides/sample_app_ug/intro.rst
@@ -4,9 +4,9 @@
 Introduction to the DPDK Sample Applications
 ============================================
 
-The DPDK Sample Applications are small standalone applications that
-demonstrate various features of DPDK. They can be considered as a cookbook of
-DPDK features. Users interested in getting started with DPDK can take the
+The DPDK sample applications are small standalone applications that
+demonstrate various features of DPDK. They serve as practical examples of
+DPDK functionality. Users interested in getting started with DPDK can take the
 applications, try out the features, and then extend them to fit their needs.
 
 
@@ -30,7 +30,7 @@ examples are highlighted below.
 
 
 * :doc:`Hello World<hello_world>`: As with most introductions to a
-  programming framework, a good place to start is with the Hello World
+  programming framework, a good place to start is the Hello World
   application. The Hello World example sets up the DPDK Environment Abstraction
   Layer (EAL), and prints a simple "Hello World" message to each of the DPDK
   enabled cores. This application doesn't do any packet forwarding, but it is a
@@ -38,32 +38,32 @@ examples are highlighted below.
 
 * :doc:`Basic Forwarding/Skeleton Application<skeleton>`: The Basic
   Forwarding/Skeleton contains the minimum amount of code required to enable
-  basic packet forwarding with DPDK. This allows you to test if your network
+  basic packet forwarding with DPDK. This allows you to test whether your network
   interfaces are working with DPDK.
 
 * :doc:`Network Layer 2 forwarding<l2_forward_real_virtual>`: The Network Layer 2
   forwarding, or ``l2fwd`` application does forwarding based on Ethernet MAC
   addresses like a simple switch.
 
-* :doc:`Network Layer 2 forwarding<l2_forward_event>`: The Network Layer 2
-  forwarding, or ``l2fwd-event`` application does forwarding based on Ethernet MAC
-  addresses like a simple switch. It demonstrates usage of poll and event mode
-  IO mechanism under a single application.
+* :doc:`Network Layer 2 forwarding with event mode<l2_forward_event>`: The
+  ``l2fwd-event`` application does forwarding based on Ethernet MAC addresses
+  like a simple switch. It demonstrates usage of poll and event mode IO
+  mechanisms under a single application.
 
-* :doc:`Network Layer 3 forwarding<l3_forward>`: The Network Layer3
+* :doc:`Network Layer 3 forwarding<l3_forward>`: The Network Layer 3
   forwarding, or ``l3fwd`` application does forwarding based on Internet
   Protocol, IPv4 or IPv6 like a simple router.
 
-* :doc:`Network Layer 3 forwarding Graph<l3_forward_graph>`: The Network Layer3
+* :doc:`Network Layer 3 forwarding Graph<l3_forward_graph>`: The Network Layer 3
   forwarding Graph, or ``l3fwd_graph`` application does forwarding based on IPv4
-  like a simple router with DPDK Graph framework.
+  like a simple router with the DPDK Graph framework.
 
 * :doc:`Hardware packet copying<dma>`: The Hardware packet copying,
-  or ``dmafwd`` application demonstrates how to use DMAdev library for
+  or ``dmafwd`` application demonstrates how to use the DMAdev library for
   copying packets between two threads.
 
 * :doc:`Packet Distributor<dist_app>`: The Packet Distributor
-  demonstrates how to distribute packets arriving on an Rx port to different
+  demonstrates how to distribute packets arriving on a receive port to different
   cores for processing and transmission.
 
 * :doc:`Multi-Process Application<multi_process>`: The
@@ -78,9 +78,9 @@ examples are highlighted below.
   and TX packet processing functions.
 
 * :doc:`IPsec Security Gateway<ipsec_secgw>`: The IPsec Security
-  Gateway application is a minimal example of something closer to a real world
-  example. This is also a good example of an application using the DPDK
-  Cryptodev framework.
+  Gateway application demonstrates a minimal implementation that is closer to
+  a real-world use case. This is also a good example of an application using
+  the DPDK Cryptodev framework.
 
 * :doc:`Precision Time Protocol (PTP) client<ptpclient>`: The PTP
   client is another minimal implementation of a real world application.
diff --git a/doc/guides/sample_app_ug/ip_frag.rst b/doc/guides/sample_app_ug/ip_frag.rst
index d2c66683e3..0d0a01ac0a 100644
--- a/doc/guides/sample_app_ug/ip_frag.rst
+++ b/doc/guides/sample_app_ug/ip_frag.rst
@@ -15,23 +15,28 @@ The application demonstrates the use of zero-copy buffers for packet fragmentati
 The initialization and run-time paths are very similar to those of the :doc:`l2_forward_real_virtual`.
 This guide highlights the differences between the two applications.
 
-There are three key differences from the L2 Forwarding sample application:
+Key differences from the L2 Forwarding sample application:
 
-*   The first difference is that the IP Fragmentation sample application makes use of indirect buffers.
+indirect buffers
+    The IP Fragmentation application uses indirect buffers for zero-copy packet fragmentation.
 
-*   The second difference is that the forwarding decision is taken
-    based on information read from the input packet's IP header.
+IP-based forwarding
+    Forwarding decisions are based on the destination IP address in the packet header,
+    using Longest Prefix Match (LPM) lookup.
 
-*   The third difference is that the application differentiates between
-    IP and non-IP traffic by means of offload flags.
+traffic classification
+    The application distinguishes IP traffic from non-IP traffic using packet offload flags.
 
-The Longest Prefix Match (LPM for IPv4, LPM6 for IPv6) table
+The application supports both IPv4 and IPv6 packet fragmentation.
+
+The Longest Prefix Match table (LPM for IPv4, LPM6 for IPv6)
 is used to store/lookup an outgoing port number associated with that IP address.
 Any unmatched packets are forwarded to the originating port.
 
 By default, input frame sizes up to 9.5 KB are supported.
 Before forwarding, the input IP packet is fragmented
-to fit into the "standard" Ethernet* v2 MTU (1500 bytes).
+to fit the standard Ethernet v2 MTU of 1500 bytes (the L3 payload size,
+excluding the Ethernet frame overhead).
 
 Compiling the Application
 -------------------------
@@ -43,10 +48,10 @@ The application is located in the ``ip_fragmentation`` sub-directory.
 Running the Application
 -----------------------
 
-The LPM object is created and loaded with the pre-configured entries read from
-global l3fwd_ipv4_route_array and l3fwd_ipv6_route_array tables.
-For each input packet, the packet forwarding decision
-(that is, the identification of the output interface for the packet) is taken as a result of LPM lookup.
+The application creates an LPM object and populates it with pre-configured routing entries
+from the global ``l3fwd_ipv4_route_array`` and ``l3fwd_ipv6_route_array`` tables.
+For each input packet, the forwarding decision (output interface selection)
+is determined by an LPM lookup on the destination IP address.
 If the IP packet size is greater than the default output MTU,
 then the input packet is fragmented and several fragments are sent via the output interface.
 
@@ -56,13 +61,13 @@ Application usage:
 
     ./<build_dir>/examples/dpdk-ip_fragmentation [EAL options] -- -p PORTMASK [-q NQ]
 
-where:
+where,
 
-*   -p PORTMASK is a hexadecimal bitmask of ports to configure
+*   ``-p PORTMASK``: hexadecimal bitmask of ports to configure
 
 *   -q NQ: Maximum number of queues per lcore (default is 1)
 
-To run the example in linux environment with 2 lcores (2,4) over 2 ports(0,2) with 1 RX queue per lcore:
+To run the example in a Linux environment with 2 lcores (2,4) over 2 ports (0,2) with 1 RX queue per lcore:
 
 .. code-block:: console
 
@@ -73,12 +78,12 @@ To run the example in linux environment with 2 lcores (2,4) over 2 ports(0,2) wi
     Skipping disabled port 1
     Initializing port 2 on lcore 4... Address:00:1B:21:5C:FF:54, rxq=0 txq=2,0 txq=4,1
     done: Link Up - speed 10000 Mbps - full-duplex
-    Skipping disabled port 3IP_FRAG: Socket 0: adding route 100.10.0.0/16 (port 0)
+    Skipping disabled port 3
+    IP_FRAG: Socket 0: adding route 100.10.0.0/16 (port 0)
     IP_FRAG: Socket 0: adding route 100.20.0.0/16 (port 1)
     ...
     IP_FRAG: Socket 0: adding route 0101:0101:0101:0101:0101:0101:0101:0101/48 (port 0)
     IP_FRAG: Socket 0: adding route 0201:0101:0101:0101:0101:0101:0101:0101/48 (port 1)
-    ...
     IP_FRAG: entering main loop on lcore 4
     IP_FRAG: -- lcoreid=4 portid=2
     IP_FRAG: entering main loop on lcore 2
@@ -108,10 +113,11 @@ The default l3fwd_ipv6_route_array table is:
     :end-before: >8 End of default l3fwd_ipv6_route_array table.
 
 For example, for the input IPv4 packet with destination address: 100.10.1.1 and packet length 9198 bytes,
-seven IPv4 packets will be sent out from port #0 to the destination address 100.10.1.1:
-six of those packets will have length 1500 bytes and one packet will have length 318 bytes.
+the application will fragment it into seven packets sent out from port 0:
+six fragments of 1500 bytes each (the MTU limit for L3 payload) and one final fragment of 318 bytes.
+
 IP Fragmentation sample application provides basic NUMA support
-in that all the memory structures are allocated on all sockets that have active lcores on them.
+in that all memory structures are allocated on all sockets that have active lcores on them.
 
 
 Refer to the *DPDK Getting Started Guide* for general information on running applications
diff --git a/doc/guides/sample_app_ug/ip_pipeline.rst b/doc/guides/sample_app_ug/ip_pipeline.rst
index f9e8caa0a8..1c8ad05061 100644
--- a/doc/guides/sample_app_ug/ip_pipeline.rst
+++ b/doc/guides/sample_app_ug/ip_pipeline.rst
@@ -4,15 +4,15 @@
 Internet Protocol (IP) Pipeline Application
 ===========================================
 
-Application overview
---------------------
+Overview
+--------
 
-The *Internet Protocol (IP) Pipeline* application is intended to be a vehicle for rapid development of packet processing
+The *Internet Protocol (IP) Pipeline* application is a vehicle for rapid development of packet processing
 applications on multi-core CPUs.
 
-Following OpenFlow and P4 design principles, the application can be used to create functional blocks called pipelines out
-of input/output ports, tables and actions in a modular way. Multiple pipelines can be inter-connected through packet queues
-to create complete applications (super-pipelines).
+Following OpenFlow and P4 design principles, the application can be used to create functional blocks called pipelines
+from input/output ports, tables and actions in a modular way. Multiple pipelines can be inter-connected through packet
+queues to create complete applications (super-pipelines).
 
 The pipelines are mapped to application threads, with each pipeline executed by a single thread and each thread able to run
 one or several pipelines. The possibilities of creating pipelines out of ports, tables and actions, connecting multiple
@@ -21,13 +21,14 @@ a true application generator.
 
 Pipelines are created and managed through Command Line Interface (CLI):
 
- * Any standard TCP client (e.g. telnet, netcat, custom script, etc) is typically able to connect to the application, send
+ * Any standard TCP client (e.g. telnet, netcat, custom script, etc.) is typically able to connect to the application, send
    commands through the network and wait for the response before pushing the next command.
 
  * All the application objects are created and managed through CLI commands:
-    * 'Primitive' objects used to create pipeline ports: memory pools, links (i.e. network interfaces), SW queues, traffic managers, etc.
-    * Action profiles: used to define the actions to be executed by pipeline input/output ports and tables.
-    * Pipeline components: input/output ports, tables, pipelines, mapping of pipelines to execution threads.
+
+   * 'Primitive' objects used to create pipeline ports: memory pools, links (i.e. network interfaces), SW queues, traffic managers, etc.
+   * Action profiles: used to define the actions to be executed by pipeline input/output ports and tables.
+   * Pipeline components: input/output ports, tables, pipelines, mapping of pipelines to execution threads.
 
 Running the application
 -----------------------
@@ -85,7 +86,7 @@ The application should start successfully and display as follows:
     EAL:   probe driver: 8086:10fb net_ixgbe
     ...
 
-To run remote client (e.g. telnet) to communicate with the ip pipeline application:
+To run a remote client (for example, telnet) to communicate with the IP pipeline application:
 
 .. code-block:: console
 
@@ -103,19 +104,21 @@ When running a telnet client as above, command prompt is displayed:
 
     pipeline>
 
-Once application and telnet client start running, messages can be sent from client to application.
-At any stage, telnet client can be terminated using the quit command.
+Once the application and telnet client start running, messages can be sent from the client to the application.
+At any stage, the telnet client can be terminated using the ``quit`` command.
 
 
-Application stages
-------------------
+Explanation
+-----------
+
+The following explains the stages of the application.
 
 Initialization
 ~~~~~~~~~~~~~~
 
-During this stage, EAL layer is initialised and application specific arguments are parsed. Furthermore, the data structures
-(i.e. linked lists) for application objects are initialized. In case of any initialization error, an error message
-is displayed and the application is terminated.
+During this stage, the EAL layer is initialized and application-specific arguments are parsed.
+Furthermore, the data structures (linked lists) for application objects are initialized.
+In case of any initialization error, an error message is displayed and the application is terminated.
 
 .. _ip_pipeline_runtime:
 
@@ -124,17 +127,18 @@ Run-time
 
 The main thread is creating and managing all the application objects based on CLI input.
 
-Each data plane thread runs one or several pipelines previously assigned to it in round-robin order. Each data plane thread
-executes two tasks in time-sharing mode:
+Each data plane thread runs one or more pipelines previously assigned to it in round-robin order.
+Each data plane thread executes two tasks in time-sharing mode:
 
 #. *Packet processing task*: Process bursts of input packets read from the pipeline input ports.
 
-#. *Message handling task*: Periodically, the data plane thread pauses the packet processing task and polls for request
-   messages send by the main thread. Examples: add/remove pipeline to/from current data plane thread, add/delete rules
-   to/from given table of a specific pipeline owned by the current data plane thread, read statistics, etc.
+#. *Message handling task*: Periodically, the data plane thread pauses the packet processing task and polls for
+   request messages sent by the main thread. Examples include adding or removing pipelines from the current
+   data plane thread, adding or deleting rules in a table of a specific pipeline owned by the current data
+   plane thread, reading statistics, and similar operations.
 
 Examples
---------
+~~~~~~~~
 
 .. _table_examples:
 
@@ -207,7 +211,7 @@ Link
 
  Link configuration ::
 
-   link <link_name>
+  link <link_name>
     dev <device_name>|port <port_id>
     rxq <n_queues> <queue_size> <mempool_name>
     txq <n_queues> <queue_size> promiscuous on | off
@@ -236,7 +240,7 @@ Software queue
 Traffic manager
 ~~~~~~~~~~~~~~~
 
- Add traffic manager subport profile ::
+Add traffic manager subport profile ::
 
   tmgr subport profile
    <tb_rate> <tb_size>
@@ -245,7 +249,7 @@ Traffic manager
    <tc9_rate> <tc10_rate> <tc11_rate> <tc12_rate>
    <tc_period>
 
- Add traffic manager pipe profile ::
+Add traffic manager pipe profile ::
 
   tmgr pipe profile
    <tb_rate> <tb_size>
@@ -256,7 +260,7 @@ Traffic manager
    <tc_ov_weight>
    <wrr_weight0..3>
 
- Create traffic manager port ::
+Create traffic manager port ::
 
   tmgr <tmgr_name>
    rate <rate>
@@ -266,16 +270,16 @@ Traffic manager
    mtu <mtu>
    cpu <cpu_id>
 
- Configure traffic manager subport ::
+Configure traffic manager subport ::
 
   tmgr <tmgr_name>
    subport <subport_id>
    profile <subport_profile_id>
 
- Configure traffic manager pipe ::
+Configure traffic manager pipe ::
 
   tmgr <tmgr_name>
-   subport <subport_id>
+  subport <subport_id>
    pipe from <pipe_id_first> to <pipe_id_last>
    profile <pipe_profile_id>
 
@@ -291,7 +295,7 @@ Tap
 Cryptodev
 ~~~~~~~~~
 
-  Create cryptodev port ::
+Create cryptodev port ::
 
    cryptodev <cryptodev_name>
     dev <DPDK Cryptodev PMD name>
@@ -300,13 +304,13 @@ Cryptodev
 Action profile
 ~~~~~~~~~~~~~~
 
- Create action profile for pipeline input port ::
+Create action profile for pipeline input port ::
 
   port in action profile <profile_name>
    [filter match | mismatch offset <key_offset> mask <key_mask> key <key_value> port <port_id>]
    [balance offset <key_offset> mask <key_mask> port <port_id0> ... <port_id15>]
 
- Create action profile for the pipeline table ::
+Create action profile for the pipeline table ::
 
   table action profile <profile_name>
    ipv4 | ipv6
@@ -389,18 +393,18 @@ Connect pipeline input port to table ::
 
   pipeline <pipeline_name> port in <port_id> table <table_id>
 
-Display statistics for specific pipeline input port, output port
+Display statistics for specific pipeline input port, output port,
 or table ::
 
   pipeline <pipeline_name> port in <port_id> stats read [clear]
   pipeline <pipeline_name> port out <port_id> stats read [clear]
   pipeline <pipeline_name> table <table_id> stats read [clear]
 
-Enable given input port for specific pipeline instance ::
+Enable given output port for specific pipeline instance ::
 
-  pipeline <pipeline_name> port out <port_id> disable
+  pipeline <pipeline_name> port out <port_id> enable
 
-Disable given input port for specific pipeline instance ::
+Disable given output port for specific pipeline instance ::
 
   pipeline <pipeline_name> port out <port_id> disable
 
@@ -408,9 +412,9 @@ Add default rule to table for specific pipeline instance ::
 
   pipeline <pipeline_name> table <table_id> rule add
      match
-        default
+       default
      action
-        fwd
+       fwd
            drop
            | port <port_id>
            | meta
@@ -484,9 +488,10 @@ Add bulk rules to table for specific pipeline instance ::
 
   pipeline <pipeline_name> table <table_id> rule add bulk <file_name> <n_rules>
 
-  Where:
-  - file_name = path to file
-  - File line format = match <match> action <action>
+Where:
+
+- ``file_name`` = path to file
+- File line format = ``match <match> action <action>``
 
 Delete table rule for specific pipeline instance ::
 
@@ -497,9 +502,9 @@ Delete default table rule for specific pipeline instance ::
 
   pipeline <pipeline_name> table <table_id> rule delete
      match
-        default
+       default
 
-Add meter profile to the table for specific pipeline instance ::
+Add meter profile to table for specific pipeline instance ::
 
   pipeline <pipeline_name> table <table_id> meter profile <meter_profile_id>
    add srtcm cir <cir> cbs <cbs> ebs <ebs>
@@ -512,24 +517,24 @@ Delete meter profile from the table for specific pipeline instance ::
 
 
 Update the dscp table for meter or traffic manager action for specific
-pipeline instance ::
+pipeline instance::
 
    pipeline <pipeline_name> table <table_id> dscp <file_name>
 
-   Where:
-      - file_name = path to file
-      - exactly 64 lines
-      - File line format = <tc_id> <tc_queue_id> <color>, with <color> as: g | y | r
+Where:
 
+- ``file_name`` = path to file
+- exactly 64 lines
+- File line format = ``<tc_id> <tc_queue_id> <color>``, with ``<color>`` as: g | y | r
 
 Pipeline enable/disable
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-   Enable given pipeline instance for specific data plane thread ::
+Enable given pipeline instance for specific data plane thread::
 
     thread <thread_id> pipeline <pipeline_name> enable
 
 
-   Disable given pipeline instance for specific data plane thread ::
+Disable given pipeline instance for specific data plane thread::
 
     thread <thread_id> pipeline <pipeline_name> disable
-- 
2.53.0

