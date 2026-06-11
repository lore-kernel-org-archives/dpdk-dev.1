Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08547CD98C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 21:22:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB07C433E7;
	Thu, 11 Jun 2026 23:21:38 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id D60A2433DD
 for <dev@dpdk.org>; Thu, 11 Jun 2026 23:21:34 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-307d0405e07so507091eec.1
 for <dev@dpdk.org>; Thu, 11 Jun 2026 14:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781212894;
 x=1781817694; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=okcEtnp2its2cLegQSk3aN3hnTv436Q9fG0mpHSYejU=;
 b=H/VXuZ2rLlHqLR/gIXWTw+BgYiBt9cwb5CX5w2vL4q18YdPH9H2vDvE0JMpKgzM8lF
 yDpeaL1M4d7dGbHF47bLmjZ1hUNJbi9XcPITkiPJ7B7PXXbhGkS2Oz8YkiypaLe3HQxL
 ckc2a8UjLmqhjU3F2OBCEAGNJcxKOJ6rCewPQjYnLoHgrpWP5Rhoyf9c+YCuPSNlPx/B
 VrPGRcQGeQgehwKfp5Ews1kUXQdLcI/dvHoiuLz2YSOL9LLAdXiU/6yDhL+DE5V1sSnC
 ZnS9gs+uQUQ6DWJFZrernhARvHk0BvCTa7sqmH5dEmsNElkRGBMeG+qnNlBPbIzly2H/
 MbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212894; x=1781817694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=okcEtnp2its2cLegQSk3aN3hnTv436Q9fG0mpHSYejU=;
 b=ogw8mKzmbF4ZtMFTNcosZABqFOLRD7BvlH1bzsKd1bOxyPPJ3QCjmD4aRWaxWGvo1U
 dvRvci8lBm0EbvCWkYWSFvq9x48aKz1M3/X6e1ueSZBdvmXR5wpJk8oVIHDGuaUXRtB6
 r0gE/Wema3oMyOgCBtuQEJR/kmnPshjEOm93dqozY6EyaMfGk77rA2qr8fCRAByuou0z
 xBIhA02hSG8ZfVpppmwRPf6Csgui/w/Oo7l+0VxfMsNTwsN5i0P7SPly3a9ilZ3Gn9VL
 jjV+dZq0JQMb/ZZV47G0e1MpO+oU6eh7FnHZ7p1+LLvF/E2wjwF15GgooQwoC8NYnogB
 jz9g==
X-Gm-Message-State: AOJu0YzM2Z14o/0a/Yj5aLyI1G3oeMupijDYseTyShj92975Ov1zKZUb
 1E1H6LE4G0X1P4a2tWsp5UeqTDNH05cY17X6UoATd75GBD119TZdqKQR+piimhMZvSQ9awQQsFN
 Gy0t0
X-Gm-Gg: Acq92OFJ4PcUr2O8T3ETDOf6jOM+WMjBocdsu6AwS2LSZkBPEo3o5qSUnCqQ9f2nRje
 EsBcnx/qg+BYU6zuXRnq6XOUQR0JNzxvfcmpopulnWzgj+78qejyeGxt3k68U0bqI0reWRSaRWC
 hSBZdAi60wwLWDo9inYByB/XjndZRS08x/uiuqAcZRj/M352uglZOR+RgYU4+MQbHFYaprjG22s
 yasS2WOrDPE2mm6Mk/XxP0QWwIGnW0vOfUL8tKoEH4drJT93Px2gIA4CWouIgv9rVw759AIR0u1
 VpbrbVXI7WFePV2xA7WnYpINw2ILiekOJrE1MRlARvlOecavVRTziGTNQY7GazlqXpQuDWDDjBd
 UOOFw48OckA8P3Ei911eOmGSKhabXCdv6FyqauGVSTV0Ci1uzeFOssenO4eGrbj9cO+Inn8tnmL
 0XOocPB3vQZuWid9w7mKJlFn9c477b+Hhcw19C8nfq+o9IU2Qe2P/YnGrq3BiwOS1qlv+YiOEr
X-Received: by 2002:a05:7300:8b85:b0:2f2:6dde:df54 with SMTP id
 5a478bee46e88-308200e18a9mr18448eec.33.1781212893669; 
 Thu, 11 Jun 2026 14:21:33 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb95450sm546238eec.28.2026.06.11.14.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 14:21:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Volodymyr Fialko <vfialko@marvell.com>
Subject: [PATCH 11/15] doc: enhance multi-process, NTB, ordering,
 and PTP guides
Date: Thu, 11 Jun 2026 14:18:50 -0700
Message-ID: <20260611212119.1026721-12-stephen@networkplumber.org>
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

Improved documentation for various sample applications:

multi_process.rst:
- Clarified primary/secondary process model
- Enhanced shared memory descriptions
- Improved command-line examples

ntb.rst:
- Minor formatting fix

packet_ordering.rst:
- Improved packet reordering algorithm descriptions
- Enhanced worker thread explanations
- Fixed formatting consistency

pipeline.rst:
- Clarified pipeline stage configurations
- Improved table action descriptions

ptpclient.rst:
- Enhanced PTP synchronization explanations
- Improved timestamp handling descriptions
- Fixed formatting in configuration examples

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/multi_process.rst   | 47 ++++++++++---------
 doc/guides/sample_app_ug/ntb.rst             |  2 +-
 doc/guides/sample_app_ug/packet_ordering.rst | 42 +++++++++--------
 doc/guides/sample_app_ug/pipeline.rst        | 26 ++++++-----
 doc/guides/sample_app_ug/ptpclient.rst       | 49 +++++++++++---------
 5 files changed, 89 insertions(+), 77 deletions(-)

diff --git a/doc/guides/sample_app_ug/multi_process.rst b/doc/guides/sample_app_ug/multi_process.rst
index 1bd858bfb5..e9e5809a92 100644
--- a/doc/guides/sample_app_ug/multi_process.rst
+++ b/doc/guides/sample_app_ug/multi_process.rst
@@ -42,9 +42,10 @@ passing at least two cores in the corelist:
 
     ./<build_dir>/examples/dpdk-simple_mp -l 0-1 --proc-type=primary
 
-For the first DPDK process run, the proc-type flag can be omitted or set to auto,
-since all DPDK processes will default to being a primary instance,
-meaning they have control over the hugepage shared memory regions.
+For the first DPDK process run, the proc-type flag can be omitted or set to auto
+since all DPDK processes will default to being a primary instance
+(meaning, they have control over the hugepage shared memory regions).
+
 The process should start successfully and display a command prompt as follows:
 
 .. code-block:: console
@@ -99,7 +100,7 @@ At any stage, either process can be terminated using the quit command.
     The secondary process can be stopped and restarted without affecting the primary process.
 
 How the Application Works
-^^^^^^^^^^^^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
 This application uses two queues and a single memory pool created in the primary process.
 The secondary process then uses lookup functions to attach to these objects.
@@ -141,7 +142,7 @@ Each process writes outgoing packets to a different Tx queue on each port.
 Running the Application
 ^^^^^^^^^^^^^^^^^^^^^^^
 
-The first instance of the ``symmetric_mp`` process is the primary instance, with the EAL arguments:
+The first instance of the ``symmetric_mp`` process becomes the primary instance, with the following application arguments:
 
 ``-p <portmask>``
   The ``portmask`` is a hexadecimal bitmask of what ports on the system are to be used.
@@ -155,7 +156,7 @@ The first instance of the ``symmetric_mp`` process is the primary instance, with
 ``--proc-id <n>``
   Where ``n`` is a numeric value in the range ``0 <= n < N``
   (number of processes, specified above).
-  This identifies which ``symmetric_mp`` instance is being run,
+  This identifies which ``symmetric_mp`` instance is running,
   so that each process can read a unique receive queue on each network port.
 
 The secondary instance must be started with similar EAL parameters.
@@ -173,7 +174,7 @@ Example:
    In the above example, ``auto`` is used so the first instance becomes the primary process.
 
 How the Application Works
-^^^^^^^^^^^^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The primary instance creates the memory pool and initializes the network ports.
 
@@ -183,8 +184,8 @@ The primary instance creates the memory pool and initializes the network ports.
         :end-before: >8 End of primary instance initialization.
         :dedent: 1
 
-The secondary instance gets the port information and exported by the primary process.
-The memory pool is accessed by doing a lookup for it by name:
+The secondary instance gets the port information exported by the primary process.
+The memory pool is accessed by looking it up by name:
 
 .. code-block:: c
 
@@ -198,7 +199,7 @@ Each process reads from each port using the queue corresponding to its proc-id p
 and writes to the corresponding transmit queue on the output port.
 
 Client-Server Multi-process Example
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+-----------------------------------
 
 The example multi-process application demonstrates a client-server type multi-process design.
 A single server process receives a set of packets from the ports
@@ -216,22 +217,22 @@ The following diagram shows the data-flow through the application, using two cli
 
 
 Running the Application
-^^^^^^^^^^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~~~~~~~~~~
 
-The server process must be run as the primary process to set up all memory structures.
+The server process must run as the primary process to set up all memory structures.
 In addition to the EAL parameters, the application-specific parameters are:
 
-*   -p <portmask >, where portmask is a hexadecimal bitmask of what ports on the system are to be used.
-    For example: -p 3 to use ports 0 and 1 only.
+*   ``-p <portmask>``, where portmask is a hexadecimal bitmask of what ports on the system are to be used.
+    For example: ``-p 3`` to use ports 0 and 1 only.
 
-*   -n <num-clients>, where the num-clients parameter is the number of client processes that will process the packets received
+*   ``-n <num-clients>``, where the num-clients parameter is the number of client processes that will process the packets received
     by the server application.
 
 .. note::
 
-   In the server process, has a single thread using the lowest numbered lcore
-   in the corelist, performs all packet I/O.
-   If corelist parameter specifies with more than a single lcore,
+   In the server process, a single thread using the lowest numbered lcore
+   in the corelist performs all packet I/O.
+   If the corelist parameter specifies more than a single lcore,
    an additional lcore will be used for a thread to print packet count periodically.
 
 The server application stores configuration data in shared memory,
@@ -251,14 +252,14 @@ the commands are:
 
     If the server application dies and needs to be restarted, all client applications also need to be restarted,
     as there is no support in the server application for it to run as a secondary process.
-    Any client processes that need restarting can be restarted without affecting the server process.
+    Client processes can be restarted without affecting the server process.
 
 How the Application Works
-^^^^^^^^^^^^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The server (primary) process performs the initialization of network port and data structure
+The server (primary) process performs the initialization of network ports and data structures
 and stores its port configuration data in a memory zone in hugepage shared memory.
-The client process does not need the portmask parameter passed in via the command line.
+The client processes do not need the portmask parameter passed in via the command line.
 The server process is the primary process, and the client processes are secondary processes.
 
 The server operates by reading packets from each network port
@@ -266,4 +267,4 @@ and distributing those packets to the client queues.
 The client reads from the ring and routes the packet to a different network port.
 The routing used is very simple: all packets received on the first NIC port
 are transmitted back out on the second port and vice versa.
-Similarly, packets are routed between the 3rd and 4th network ports and so on.
+Similarly, packets are routed between the third and fourth network ports and so on.
diff --git a/doc/guides/sample_app_ug/ntb.rst b/doc/guides/sample_app_ug/ntb.rst
index f54de6cecd..ca0ff54757 100644
--- a/doc/guides/sample_app_ug/ntb.rst
+++ b/doc/guides/sample_app_ug/ntb.rst
@@ -12,7 +12,7 @@ This sample supports 4 types of packet forwarding mode.
 
 * ``file-trans``: transmit files between two systems. The sample will
   be polling to receive files from the peer and save the file as
-  ``ntb_recv_file[N]``, [N] represents the number of received file.
+  ``ntb_recv_file[N]``, where [N] represents the number of received files.
 * ``rxonly``: NTB receives packets but doesn't transmit them.
 * ``txonly``: NTB generates and transmits packets without receiving any.
 * ``iofwd``: iofwd between NTB device and ethdev.
diff --git a/doc/guides/sample_app_ug/packet_ordering.rst b/doc/guides/sample_app_ug/packet_ordering.rst
index f96c0ad697..2082f49ad1 100644
--- a/doc/guides/sample_app_ug/packet_ordering.rst
+++ b/doc/guides/sample_app_ug/packet_ordering.rst
@@ -4,29 +4,30 @@
 Packet Ordering Application
 ============================
 
-The Packet Ordering sample app simply shows the impact of reordering a stream.
-It's meant to stress the library with different configurations for performance.
+The Packet Ordering sample application demonstrates packet reordering
+functionality and its impact on stream processing.
+It stresses the library with different configurations for performance.
 
 Overview
 --------
 
 The application uses at least three CPU cores:
 
-* RX core (main core) receives traffic from the NIC ports and feeds Worker
+* The RX core (main core) receives traffic from the NIC ports and feeds worker
   cores with traffic through SW queues.
 
-* Worker (worker core) basically do some light work on the packet.
-  Currently it modifies the output port of the packet for configurations with
-  more than one port enabled.
+* Worker cores perform lightweight processing on each packet.
+  For configurations with more than one port enabled, it swaps the destination
+  port of the packet.
 
-* TX Core (worker core) receives traffic from Worker cores through software queues,
+* The TX core receives traffic from worker cores through software queues,
   inserts out-of-order packets into reorder buffer, extracts ordered packets
-  from the reorder buffer and sends them to the NIC ports for transmission.
+  from the reorder buffer, and sends them to the NIC ports for transmission.
 
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``packet_ordering`` sub-directory.
 
@@ -36,6 +37,9 @@ Running the Application
 Refer to *DPDK Getting Started Guide* for general information on running applications
 and the Environment Abstraction Layer (EAL) options.
 
+Explanation
+-----------
+
 Application Command Line
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -46,16 +50,16 @@ The application execution command line is:
     ./<build_dir>/examples/dpdk-packet_ordering [EAL options] -- -p PORTMASK /
     [--disable-reorder] [--insight-worker]
 
-The -l EAL corelist option has to contain at least 3 CPU cores.
-The first CPU core in the core mask is the main core and would be assigned to
-RX core, the last to TX core and the rest to Worker cores.
+The ``-l`` EAL corelist option must contain at least 3 CPU cores.
+The first CPU core in the corelist is assigned to the RX core (main core),
+the last to the TX core, and the remaining cores to worker cores.
 
-The PORTMASK parameter must contain either 1 or even enabled port numbers.
-When setting more than 1 port, traffic would be forwarded in pairs.
-For example, if we enable 4 ports, traffic from port 0 to 1 and from 1 to 0,
-then the other pair from 2 to 3 and from 3 to 2, having [0,1] and [2,3] pairs.
+The ``PORTMASK`` parameter must specify either 1 port or an even number of ports.
+When setting more than 1 port, traffic is forwarded in pairs.
+For example, if 4 ports are enabled, traffic flows between port 0 and port 1,
+and between port 2 and port 3 (forming port pairs [0,1] and [2,3]).
 
-The disable-reorder long option does, as its name implies, disable the reordering
-of traffic, which should help evaluate reordering performance impact.
+The ``--disable-reorder`` option disables packet reordering, which allows
+evaluation of the performance impact of reordering.
 
-The insight-worker long option enables output the packet statistics of each worker thread.
+The ``--insight-worker`` long option enables outputting packet statistics for each worker thread.
diff --git a/doc/guides/sample_app_ug/pipeline.rst b/doc/guides/sample_app_ug/pipeline.rst
index 2d7c977068..2e8f5b7f24 100644
--- a/doc/guides/sample_app_ug/pipeline.rst
+++ b/doc/guides/sample_app_ug/pipeline.rst
@@ -4,10 +4,10 @@
 Pipeline Application
 ====================
 
-Application overview
---------------------
+Overview
+--------
 
-This application showcases the features of the Software Switch (SWX) pipeline that is aligned with the P4 language.
+This application showcases the features of the Software Switch (SWX) pipeline that aligns with the P4 language.
 
 Each pipeline is created using a specification file that can either be manually developed or generated using a P4 compiler.
 
@@ -78,7 +78,7 @@ To run remote client (e.g. telnet) to communicate with the application:
 
     $ telnet 0.0.0.0 8086
 
-When running a telnet client as above, command prompt is displayed:
+When running a telnet client as above, the command prompt is displayed:
 
 .. code-block:: console
 
@@ -90,23 +90,25 @@ When running a telnet client as above, command prompt is displayed:
 
     pipeline>
 
-Once application and telnet client start running, messages can be sent from client to application.
+Once the application and telnet client start running, you can send messages from the client to the application.
 
 
-Application stages
-------------------
+Explanation
+-----------
+
+Here is a description of the various stages of the application.
 
 Initialization
 ~~~~~~~~~~~~~~
 
-During this stage, EAL layer is initialised and application specific arguments are parsed. Furthermore, the data structures
-for application objects are initialized. In case of any initialization error, an error message is displayed and the application
-is terminated.
+During this stage, EAL layer is initialized and application specific arguments are parsed.
+Furthermore, the data structures for application objects are initialized.
+In case of any initialization error, an error message is displayed and the application is terminated.
 
 Run-time
 ~~~~~~~~
 
-The main thread is creating and managing all the application objects based on CLI input.
+The main thread creates and manages all the application objects based on CLI input.
 
 Each data plane thread runs one or several pipelines previously assigned to it in round-robin order. Each data plane thread
 executes two tasks in time-sharing mode:
@@ -114,5 +116,5 @@ executes two tasks in time-sharing mode:
 #. *Packet processing task*: Process bursts of input packets read from the pipeline input ports.
 
 #. *Message handling task*: Periodically, the data plane thread pauses the packet processing task and polls for request
-   messages send by the main thread. Examples: add/remove pipeline to/from current data plane thread, add/delete rules
+   messages sent by the main thread. Examples: add/remove pipeline to/from current data plane thread, add/delete rules
    to/from given table of a specific pipeline owned by the current data plane thread, read statistics, etc.
diff --git a/doc/guides/sample_app_ug/ptpclient.rst b/doc/guides/sample_app_ug/ptpclient.rst
index 0df465bcb4..28007604a0 100644
--- a/doc/guides/sample_app_ug/ptpclient.rst
+++ b/doc/guides/sample_app_ug/ptpclient.rst
@@ -5,14 +5,19 @@ PTP Client Sample Application
 =============================
 
 The PTP (Precision Time Protocol) client sample application is a simple
-example of using the DPDK IEEE1588 API to communicate with a PTP time transmitter
+example of using the DPDK IEEE1588 API to communicate with a PTP timeTransmitter
 to synchronize the time on the NIC and, optionally, on the Linux system.
 
-Note, PTP is a time syncing protocol and cannot be used within DPDK as a
+Note, PTP is a time synchronization protocol and cannot be used within DPDK as a
 time-stamping mechanism. See the following for an explanation of the protocol:
 `Precision Time Protocol
 <https://en.wikipedia.org/wiki/Precision_Time_Protocol>`_.
 
+.. note::
+
+   This documentation uses PTPv3 (IEEE 1588-2019) terminology where timeTransmitter/timeReceiver
+   replace the older master/slave terms from PTPv2.
+
 
 Limitations
 -----------
@@ -21,10 +26,10 @@ The PTP sample application is intended as a simple reference implementation of
 a PTP client using the DPDK IEEE1588 API.
 In order to keep the application simple the following assumptions are made:
 
-* The first discovered time transmitter is the main for the session.
+* The first discovered timeTransmitter is used for the session.
 * Only L2 PTP packets are supported.
 * Only the PTP v2 protocol is supported.
-* Only the time receiver clock is implemented.
+* Only the timeReceiver clock is implemented.
 
 
 How the Application Works
@@ -36,18 +41,18 @@ How the Application Works
 
    PTP Synchronization Protocol
 
-The PTP synchronization in the sample application works as follows:
+The PTP synchronization in the sample application (timeReceiver mode) works as follows:
 
-* Time transmitter sends *Sync* message - the time receiver saves it as T2.
-* Time transmitter sends *Follow Up* message and sends time of T1.
-* Time receiver sends *Delay Request* frame to PTP time transmitter and stores T3.
-* Time transmitter sends *Delay Response* T4 time which is time of received T3.
+* TimeTransmitter sends *Sync* message - the timeReceiver saves the receive time as T2.
+* TimeTransmitter sends *Follow Up* message containing the transmit time T1.
+* TimeReceiver sends *Delay Request* frame to the PTP timeTransmitter and stores the transmit time as T3.
+* TimeTransmitter sends *Delay Response* containing T4, the time it received the Delay Request.
 
-The adjustment for time receiver can be represented as:
+The clock adjustment for the timeReceiver can be calculated as:
 
    adj = -[(T2-T1)-(T4 - T3)]/2
 
-If the command line parameter ``-T 1`` is used the application also
+If the command line parameter ``-T 1`` is used, the application also
 synchronizes the PTP PHC clock with the Linux kernel clock.
 
 Compiling the Application
@@ -61,7 +66,7 @@ The application is located in the ``ptpclient`` sub-directory.
 Running the Application
 -----------------------
 
-To run the example in a ``linux`` environment:
+To run the example in a Linux environment:
 
 .. code-block:: console
 
@@ -71,8 +76,8 @@ Refer to *DPDK Getting Started Guide* for general information on running
 applications and the Environment Abstraction Layer (EAL) options.
 
 * ``-p portmask``: Hexadecimal portmask.
-* ``-T 0``: Update only the PTP time receiver clock.
-* ``-T 1``: Update the PTP time receiver clock and synchronize the Linux Kernel to the PTP clock.
+* ``-T 0``: Update only the PTP timeReceiver clock.
+* ``-T 1``: Update the PTP timeReceiver clock and synchronize the Linux kernel clock to the PTP clock.
 
 
 Code Explanation
@@ -101,7 +106,7 @@ function. The value returned is the number of parsed arguments:
     :end-before: >8 End of initialization of EAL.
     :dedent: 1
 
-And than we parse application specific arguments
+Then we parse application-specific arguments:
 
 .. literalinclude:: ../../../examples/ptpclient/ptpclient.c
     :language: c
@@ -178,8 +183,8 @@ The forwarding loop can be interrupted and the application closed using
 PTP parsing
 ~~~~~~~~~~~
 
-The ``parse_ptp_frames()`` function processes PTP packets, implementing time receiver
-PTP IEEE1588 L2 functionality.
+The ``parse_ptp_frames()`` function processes PTP packets, implementing
+PTP IEEE1588 L2 timeReceiver functionality.
 
 .. literalinclude:: ../../../examples/ptpclient/ptpclient.c
     :language: c
@@ -187,12 +192,12 @@ PTP IEEE1588 L2 functionality.
     :end-before:  >8 End of function processes PTP packets.
 
 There are 3 types of packets on the RX path which we must parse to create a minimal
-implementation of the PTP time receiver client:
+implementation of the PTP timeReceiver:
 
 * SYNC packet.
-* FOLLOW UP packet
+* FOLLOW UP packet.
 * DELAY RESPONSE packet.
 
-When we parse the *FOLLOW UP* packet we also create and send a *DELAY_REQUEST* packet.
-Also when we parse the *DELAY RESPONSE* packet, and all conditions are met
-we adjust the PTP time receiver clock.
+When we parse the *FOLLOW UP* packet, we also create and send a *DELAY REQUEST* packet.
+When we parse the *DELAY RESPONSE* packet, and all conditions are met,
+we adjust the PTP timeReceiver clock.
-- 
2.53.0

