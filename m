Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED720C02198
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 23:09:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED39940151;
	Mon, 17 Feb 2025 00:09:20 +0100 (CET)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 2A45B400D6
 for <dev@dpdk.org>; Mon, 17 Feb 2025 00:09:18 +0100 (CET)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2fc32756139so3086023a91.1
 for <dev@dpdk.org>; Sun, 16 Feb 2025 15:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739747357; x=1740352157; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KgMuEZdboV3dYGdLmG0tBbWbzoHqpCEnLGQDnsPNWQY=;
 b=NLtMTf0qr+K22DejqLMhq9Amx0y2OQD0gONmmVqaBb8RI7s4UlfYhzb3HRoxuzO1zo
 mBAamy/XDfVLouZ4/xls3Vj245Uxb0mPRbertXu7aUwtntsjXG75B7tsn53eWhipT7FU
 EXfYbmoS38wwNRo3HEbUwv5ST8Om9uNofoEpTaipWbYFCIC67V8nD98m4IIhdReBM8d+
 pCFya/ccGm+Ppf21wzknssAbaFuIuaj15chq4zaQX/QzCeyyMJStCz84iRPrPmwlv/V0
 udkSuWAkyDqlNJIGpgC35VJpHUWrvv2u232AhnhlqxPZfxZwshOKDj5VY1E/IweHxRey
 yNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747357; x=1740352157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KgMuEZdboV3dYGdLmG0tBbWbzoHqpCEnLGQDnsPNWQY=;
 b=rP4vVgtaMi7EZcDbzsxrtX9hjQgB9YrBpia2YajpiPl7JvxJ89YCZXzTs8IKHGevFo
 eOGt6QBL0jTP0c1pY5I6cAb4yhgur0GzY/bhga/FCJbErBdNqQNt3Xrax6PxrzIjwhtq
 hYxbUaP68/K0j3Yj0BkB71dmT/weeVLOtUDxrcCU2AfuechtLwA9BttCYly96U/pDZIP
 MpQPQVbMIEHxgGxFpmbincZ44IvxyQ5Xxy/CZEyX6hst0cW2uKM6KoTOqN9L9IAu6KLM
 +DJO5Pu8LMFMzEntEZiHWCDIHFyQiM9AIfBLT28d05UmGV9GfSE8eWT6UjPtys8Orquz
 amGA==
X-Gm-Message-State: AOJu0Yws35gkYxypHBkaP7vqOkePD9AzkGEc38sIwORcewos4sSS5Fqi
 d8znAt8h5hUh1x+Kmq8BwWnWWI6nW85iZeuSd390dosGjoe7oSEwSTzZ0nY+
X-Gm-Gg: ASbGncsQtJ0k9bhnUmsI99F6mRyrSK528EAFEZvfrX+3JF0CQaX5LEfdBYm10ciIo2O
 sIA4a4qof7tj485ABYJhAnNBLkEO1j9UR79kgrEBZtIvBwZ9eTwfPMzJxPDhRvvYQFX0Cv/qSRK
 FTMugjmrBjhY6iykncC8JYJXks30ZQJzg6xPUm1M3/TafLqAuAb7qQKUotQPkw23r5LgTWJ90au
 nB6b7qZ1b0ffTdQdyF5hPqOWvhFCEvEBQZX+w/BZQdEVCU0b5/mvhVuPOUAS/YbwXcYWaERXtaa
 6yxbNCRl7QQ9aWaxnT5H13N0lULOBYhyWyHBx7Nf4evEb5JFZ8aMZ3eZ2uKltiI+DcVoek0Jx9m
 l1WUJuX1jw356rg==
X-Google-Smtp-Source: AGHT+IEXmocmtRgQHUN3TnnyN+EBjbtyA86lWMfSn8qrNd9YgbpyI1NpvgmSy8WviN+79mEEgcrIdA==
X-Received: by 2002:a05:6a00:198c:b0:730:8386:6070 with SMTP id
 d2e1a72fcca58-73261445ce1mr13460621b3a.0.1739747354019; 
 Sun, 16 Feb 2025 15:09:14 -0800 (PST)
Received: from localhost.localdomain (syn-076-032-089-124.res.spectrum.com.
 [76.32.89.124]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324276176bsm6827029b3a.154.2025.02.16.15.09.13
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:09:13 -0800 (PST)
From: Nandini Persad <nandinipersad361@gmail.com>
To: dev@dpdk.org
Subject: [PATCH v2] doc: reword sample application guides
Date: Sun, 16 Feb 2025 15:09:03 -0800
Message-Id: <20250216230903.124496-1-nandinipersad361@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127174743.24713-1-nandinipersad361@gmail.com>
References: <20250127174743.24713-1-nandinipersad361@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

I have revised these sections to suit the template, but also,
for punctuation, clarity, and removing repetition when necessary.

Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
---
 doc/guides/sample_app_ug/dist_app.rst         |  24 +--
 .../sample_app_ug/eventdev_pipeline.rst       |  20 +--
 doc/guides/sample_app_ug/fips_validation.rst  |  23 ++-
 doc/guides/sample_app_ug/ip_pipeline.rst      |  12 +-
 doc/guides/sample_app_ug/ipsec_secgw.rst      |  95 ++++++------
 doc/guides/sample_app_ug/multi_process.rst    |  64 ++++----
 doc/guides/sample_app_ug/packet_ordering.rst  |  19 ++-
 doc/guides/sample_app_ug/pipeline.rst         |  10 +-
 doc/guides/sample_app_ug/ptpclient.rst        |  56 +++----
 doc/guides/sample_app_ug/qos_metering.rst     |  11 +-
 doc/guides/sample_app_ug/qos_scheduler.rst    |  10 +-
 doc/guides/sample_app_ug/service_cores.rst    |  41 +++---
 doc/guides/sample_app_ug/test_pipeline.rst    |   2 +-
 doc/guides/sample_app_ug/timer.rst            |  13 +-
 doc/guides/sample_app_ug/vdpa.rst             |  39 ++---
 doc/guides/sample_app_ug/vhost.rst            |  51 ++++---
 doc/guides/sample_app_ug/vhost_blk.rst        |  21 +--
 doc/guides/sample_app_ug/vhost_crypto.rst     |  15 +-
 .../sample_app_ug/vm_power_management.rst     | 138 ++++++++----------
 .../sample_app_ug/vmdq_dcb_forwarding.rst     |  77 +++++-----
 doc/guides/sample_app_ug/vmdq_forwarding.rst  |  28 ++--
 21 files changed, 397 insertions(+), 372 deletions(-)

diff --git a/doc/guides/sample_app_ug/dist_app.rst b/doc/guides/sample_app_ug/dist_app.rst
index 5c80561187..7a841bff8a 100644
--- a/doc/guides/sample_app_ug/dist_app.rst
+++ b/doc/guides/sample_app_ug/dist_app.rst
@@ -4,7 +4,7 @@
 Distributor Sample Application
 ==============================
 
-The distributor sample application is a simple example of packet distribution
+The distributor sample application is an example of packet distribution
 to cores using the Data Plane Development Kit (DPDK). It also makes use of
 Intel Speed Select Technology - Base Frequency (Intel SST-BF) to pin the
 distributor to the higher frequency core if available.
@@ -31,7 +31,7 @@ generator as shown in the figure below.
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``distributor`` sub-directory.
 
@@ -66,7 +66,7 @@ The distributor application consists of four types of threads: a receive
 thread (``lcore_rx()``), a distributor thread (``lcore_dist()``), a set of
 worker threads (``lcore_worker()``), and a transmit thread(``lcore_tx()``).
 How these threads work together is shown in :numref:`figure_dist_app` below.
-The ``main()`` function launches  threads of these four types.  Each thread
+The ``main()`` function launches threads of these four types. Each thread
 has a while loop which will be doing processing and which is terminated
 only upon SIGINT or ctrl+C.
 
@@ -86,7 +86,7 @@ the distributor, doing a simple XOR operation on the input port mbuf field
 (to indicate the output port which will be used later for packet transmission)
 and then finally returning the packets back to the distributor thread.
 
-The distributor thread will then call the distributor api
+The distributor thread will then call the distributor API
 ``rte_distributor_returned_pkts()`` to get the processed packets, and will enqueue
 them to another rte_ring for transfer to the TX thread for transmission on the
 output port. The transmit thread will dequeue the packets from the ring and
@@ -105,7 +105,7 @@ final statistics to the user.
 
 
 Intel SST-BF Support
---------------------
+~~~~~~~~~~~~~~~~~~~~
 
 In DPDK 19.05, support was added to the power management library for
 Intel-SST-BF, a technology that allows some cores to run at a higher
@@ -114,20 +114,20 @@ and is entitled
 `Intel Speed Select Technology – Base Frequency - Enhancing Performance <https://builders.intel.com/docs/networkbuilders/intel-speed-select-technology-base-frequency-enhancing-performance.pdf>`_
 
 The distributor application was also enhanced to be aware of these higher
-frequency SST-BF cores, and when starting the application, if high frequency
+frequency SST-BF cores. When starting the application, if high frequency
 SST-BF cores are present in the core mask, the application will identify these
 cores and pin the workloads appropriately. The distributor core is usually
 the bottleneck, so this is given first choice of the high frequency SST-BF
-cores, followed by the rx core and the tx core.
+cores, followed by the Rx core and the Tx core.
 
 Debug Logging Support
----------------------
+~~~~~~~~~~~~~~~~~~~~~
 
 Debug logging is provided as part of the application; the user needs to uncomment
 the line "#define DEBUG" defined in start of the application in main.c to enable debug logs.
 
 Statistics
-----------
+~~~~~~~~~~
 
 The main function will print statistics on the console every second. These
 statistics include the number of packets enqueued and dequeued at each stage
@@ -135,7 +135,7 @@ in the application, and also key statistics per worker, including how many
 packets of each burst size (1-8) were sent to each worker thread.
 
 Application Initialization
---------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Command line parsing is done in the same way as it is done in the L2 Forwarding Sample
 Application. See :ref:`l2_fwd_app_cmd_arguments`.
@@ -146,8 +146,8 @@ Sample Application. See :ref:`l2_fwd_app_mbuf_init`.
 Driver Initialization is done in same way as it is done in the L2 Forwarding Sample
 Application. See :ref:`l2_fwd_app_dvr_init`.
 
-RX queue initialization is done in the same way as it is done in the L2 Forwarding
+Rx queue initialization is done in the same way as it is done in the L2 Forwarding
 Sample Application. See :ref:`l2_fwd_app_rx_init`.
 
-TX queue initialization is done in the same way as it is done in the L2 Forwarding
+Tx queue initialization is done in the same way as it is done in the L2 Forwarding
 Sample Application. See :ref:`l2_fwd_app_tx_init`.
diff --git a/doc/guides/sample_app_ug/eventdev_pipeline.rst b/doc/guides/sample_app_ug/eventdev_pipeline.rst
index 19ff53803e..103a8d7e84 100644
--- a/doc/guides/sample_app_ug/eventdev_pipeline.rst
+++ b/doc/guides/sample_app_ug/eventdev_pipeline.rst
@@ -10,7 +10,7 @@ application can configure a pipeline and assign a set of worker cores to
 perform the processing required.
 
 The application has a range of command line arguments allowing it to be
-configured for various numbers worker cores, stages,queue depths and cycles per
+configured for various numbers worker cores, stages, queue depths and cycles per
 stage of work. This is useful for performance testing as well as quickly testing
 a particular pipeline configuration.
 
@@ -18,7 +18,7 @@ a particular pipeline configuration.
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``examples`` sub-directory.
 
@@ -61,21 +61,21 @@ will print an error message:
           rx: 0
           tx: 1
 
-Configuration of the eventdev is covered in detail in the programmers guide,
-see the Event Device Library section.
+Configuration of the eventdev is covered in detail in the programmers guide.
+See the Event Device Library section.
 
 
 Observing the Application
--------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
-At runtime the eventdev pipeline application prints out a summary of the
-configuration, and some runtime statistics like packets per second. On exit the
+At runtime, the eventdev pipeline application prints out a summary of the
+configuration, and some runtime statistics like packets per second. On exit, the
 worker statistics are printed, along with a full dump of the PMD statistics if
 required. The following sections show sample output for each of the output
 types.
 
 Configuration
-~~~~~~~~~~~~~
+^^^^^^^^^^^^^
 
 This provides an overview of the pipeline,
 scheduling type at each stage, and parameters to options such as how many
@@ -101,7 +101,7 @@ for details:
         Stage 3, Type Atomic    Priority = 128
 
 Runtime
-~~~~~~~
+^^^^^^^
 
 At runtime, the statistics of the consumer are printed, stating the number of
 packets received, runtime in milliseconds, average mpps, and current mpps.
@@ -111,7 +111,7 @@ packets received, runtime in milliseconds, average mpps, and current mpps.
   # consumer RX= xxxxxxx, time yyyy ms, avg z.zzz mpps [current w.www mpps]
 
 Shutdown
-~~~~~~~~
+^^^^^^^^
 
 At shutdown, the application prints the number of packets received and
 transmitted, and an overview of the distribution of work across worker cores.
diff --git a/doc/guides/sample_app_ug/fips_validation.rst b/doc/guides/sample_app_ug/fips_validation.rst
index 613c5afd19..7c7e32d9bc 100644
--- a/doc/guides/sample_app_ug/fips_validation.rst
+++ b/doc/guides/sample_app_ug/fips_validation.rst
@@ -79,18 +79,17 @@ Application Information
 -----------------------
 
 If a ``.req`` is used as the input file after the application is finished
-running it will generate a response file or ``.rsp``. Differences between the
-two files are, the ``.req`` file has missing information for instance if doing
-encryption you will not have the cipher text and that will be generated in the
-response file. Also if doing decryption it will not have the plain text until it
-finished the work and in the response file it will be added onto the end of each
-operation.
-
-The application can be run with a ``.rsp`` file and what the outcome of that
-will be is it will add a extra line in the generated ``.rsp`` which should be
-the same as the ``.rsp`` used to run the application, this is useful for
-validating if the application has done the operation correctly.
-
+running, it will generate a response file or ``.rsp``. Differences between
+the two files are: the ``.req`` file has missing information (for instance,
+if performing encryption, you will not have the cipher text and that will be
+generated in the response file.), and, if performing decryption, it will not
+have plain text until it has finished the work. In the response file, it will
+be added onto the end of each operation.
+
+The application can be run with a ``.rsp`` file. The outcome of that is that
+an extra line in the generated ``.rsp`` will be added. This should be the same
+as the ``.rsp`` used to run the application. This is useful for validating if
+the application has done the operation correctly.
 
 Compiling the Application
 -------------------------
diff --git a/doc/guides/sample_app_ug/ip_pipeline.rst b/doc/guides/sample_app_ug/ip_pipeline.rst
index ff5ee67ec2..a0b8bf5ce1 100644
--- a/doc/guides/sample_app_ug/ip_pipeline.rst
+++ b/doc/guides/sample_app_ug/ip_pipeline.rst
@@ -4,8 +4,8 @@
 Internet Protocol (IP) Pipeline Application
 ===========================================
 
-Application overview
---------------------
+Overview
+--------
 
 The *Internet Protocol (IP) Pipeline* application is intended to be a vehicle for rapid development of packet processing
 applications on multi-core CPUs.
@@ -107,8 +107,10 @@ Once application and telnet client start running, messages can be sent from clie
 At any stage, telnet client can be terminated using the quit command.
 
 
-Application stages
-------------------
+Explanation
+-----------
+
+The following explains the stages of the application.
 
 Initialization
 ~~~~~~~~~~~~~~
@@ -134,7 +136,7 @@ executes two tasks in time-sharing mode:
    to/from given table of a specific pipeline owned by the current data plane thread, read statistics, etc.
 
 Examples
---------
+~~~~~~~~
 
 .. _table_examples:
 
diff --git a/doc/guides/sample_app_ug/ipsec_secgw.rst b/doc/guides/sample_app_ug/ipsec_secgw.rst
index 3686948833..3f1cd477d7 100644
--- a/doc/guides/sample_app_ug/ipsec_secgw.rst
+++ b/doc/guides/sample_app_ug/ipsec_secgw.rst
@@ -11,35 +11,30 @@ application using DPDK cryptodev framework.
 Overview
 --------
 
-The application demonstrates the implementation of a Security Gateway
-(not IPsec compliant, see the Constraints section below) using DPDK based on RFC4301,
-RFC4303, RFC3602 and RFC2404.
+This application demonstrates the implementation of a Security Gateway
+(not fully IPsec-compliant; see the Constraints section) using DPDK, based
+on RFC4301, RFC4303, RFC3602, and RFC2404.
 
-Internet Key Exchange (IKE) is not implemented, so only manual setting of
-Security Policies and Security Associations is supported.
+Currently, DPDK does not support Internet Key Exchange (IKE), so Security Policies
+(SP) and Security Associations (SA) must be configured manually. SPs are implemented
+as ACL rules, SAs are stored in a table, and routing is handled using LPM.
 
-The Security Policies (SP) are implemented as ACL rules, the Security
-Associations (SA) are stored in a table and the routing is implemented
-using LPM.
+The application classifies ports as *Protected* or *Unprotected*, with traffic
+received on Unprotected ports considered Inbound and traffic on Protected ports
+considered Outbound.
 
-The application classifies the ports as *Protected* and *Unprotected*.
-Thus, traffic received on an Unprotected or Protected port is consider
-Inbound or Outbound respectively.
+It supports full IPsec protocol offload to hardware (via crypto accelerators or
+Ethernet devices) as well as inline IPsec processing by supported Ethernet
+devices during transmission. These modes can be configured during SA creation.
 
-The application also supports complete IPsec protocol offload to hardware
-(Look aside crypto accelerator or using ethernet device). It also support
-inline ipsec processing by the supported ethernet device during transmission.
-These modes can be selected during the SA creation configuration.
+For full protocol offload, the hardware processes ESP and outer IP headers,
+so the application does not need to add or remove them during Outbound or
+Inbound processing.
 
-In case of complete protocol offload, the processing of headers(ESP and outer
-IP header) is done by the hardware and the application does not need to
-add/remove them during outbound/inbound processing.
-
-For inline offloaded outbound traffic, the application will not do the LPM
-lookup for routing, as the port on which the packet has to be forwarded will be
-part of the SA. Security parameters will be configured on that port only, and
-sending the packet on other ports could result in unencrypted packets being
-sent out.
+In the inline offload mode for Outbound traffic, the application skips the
+LPM lookup for routing, as the SA specifies the port for forwarding. Security
+parameters are configured only on the specified port, and sending packets
+through other ports may result in unencrypted packets being transmitted.
 
 The Path for IPsec Inbound traffic is:
 
@@ -64,25 +59,25 @@ The Path for the IPsec Outbound traffic is:
 
 The application supports two modes of operation: poll mode and event mode.
 
-* In the poll mode a core receives packets from statically configured list
+* In the poll mode, a core receives packets from statically configured list
   of eth ports and eth ports' queues.
 
-* In the event mode a core receives packets as events. After packet processing
-  is done core submits them back as events to an event device. This enables
-  multicore scaling and HW assisted scheduling by making use of the event device
-  capabilities. The event mode configuration is predefined. All packets reaching
-  given eth port will arrive at the same event queue. All event queues are mapped
-  to all event ports. This allows all cores to receive traffic from all ports.
-  Since the underlying event device might have varying capabilities, the worker
-  threads can be drafted differently to maximize performance. For example, if an
-  event device - eth device pair has Tx internal port, then application can call
-  rte_event_eth_tx_adapter_enqueue() instead of regular rte_event_enqueue_burst().
-  So a thread which assumes that the device pair has internal port will not be the
-  right solution for another pair. The infrastructure added for the event mode aims
-  to help application to have multiple worker threads by maximizing performance from
-  every type of event device without affecting existing paths/use cases. The worker
-  to be used will be determined by the operating conditions and the underlying device
-  capabilities.
+* In event mode, a core processes packets as events. After processing, the
+core submits the packets back to an event device, enabling multicore scaling
+and hardware-assisted scheduling by leveraging the capabilities of the event
+device. The event mode configuration is predefined, where all packets arriving
+at a specific Ethernet port are directed to the same event queue. All event
+queues are mapped to all event ports, allowing any core to receive traffic
+from any port. Since event devices can have varying capabilities, worker threads are designed
+differently to optimize performance. For instance, if an event device and Ethernet
+device pair includes a Tx internal port, the application can use `rte_event_eth_tx_adapter_enqueue`
+instead of the standard `rte_event_enqueue_burst`. A thread optimized for a device
+pair with an internal port may not work effectively with another pair. The infrastructure
+for event mode is designed to support multiple worker threads
+while maximizing the performance of each type of event device without impacting
+existing paths or use cases. The worker thread selection depends on the operating
+conditions and the capabilities of the underlying devices.
+
   **Currently the application provides non-burst, internal port worker threads.**
   It also provides infrastructure for non-internal port
   however does not define any worker threads.
@@ -99,7 +94,7 @@ The application supports two modes of operation: poll mode and event mode.
   ``RTE_EVENT_CRYPTO_ADAPTER_CAP_EVENT_VECTOR`` vector aggregation
   could also be enable using event-vector option.
 
-Additionally the event mode introduces two submodes of processing packets:
+Additionally, the event mode introduces two submodes of processing packets:
 
 * Driver submode: This submode has bare minimum changes in the application to support
   IPsec. There are no lookups, no routing done in the application. And for inline
@@ -115,7 +110,7 @@ Additionally the event mode introduces two submodes of processing packets:
   benchmark numbers.
 
 Constraints
------------
+~~~~~~~~~~~
 
 *  No IPv6 options headers.
 *  No AH mode.
@@ -127,7 +122,7 @@ Constraints
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``ipsec-secgw`` sub-directory.
 
@@ -377,11 +372,11 @@ For example, something like the following command line:
 
 
 Configurations
---------------
+~~~~~~~~~~~~~~
 
 The following sections provide the syntax of configurations to initialize
 your SP, SA, Routing, Flow and Neighbour tables.
-Configurations shall be specified in the configuration file to be passed to
+Configurations will be specified in the configuration file to be passed to
 the application. The file is then parsed by the application. The successful
 parsing will result in the appropriate rules being applied to the tables
 accordingly.
@@ -390,11 +385,11 @@ accordingly.
 Configuration File Syntax
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
-As mention in the overview, the Security Policies are ACL rules.
+As mentioned in the overview, the Security Policies are ACL rules.
 The application parsers the rules specified in the configuration file and
 passes them to the ACL table, and replicates them per socket in use.
 
-Following are the configuration file syntax.
+The following sections contains the configuration file syntax.
 
 General rule syntax
 ^^^^^^^^^^^^^^^^^^^
@@ -1142,7 +1137,7 @@ It then tries to perform some data transfer using the scheme described above.
 Usage
 ~~~~~
 
-In the ipsec-secgw/test directory run
+In the ipsec-secgw/test directory run:
 
 /bin/bash run_test.sh <options> <ipsec_mode>
 
@@ -1175,4 +1170,4 @@ Available options:
 *   ``-h`` Show usage.
 
 If <ipsec_mode> is specified, only tests for that mode will be invoked. For the
-list of available modes please refer to run_test.sh.
+list of available modes, please refer to run_test.sh.
diff --git a/doc/guides/sample_app_ug/multi_process.rst b/doc/guides/sample_app_ug/multi_process.rst
index c53331def3..9eecde119c 100644
--- a/doc/guides/sample_app_ug/multi_process.rst
+++ b/doc/guides/sample_app_ug/multi_process.rst
@@ -8,16 +8,14 @@ Multi-process Sample Application
 
 This chapter describes the example applications for multi-processing that are included in the DPDK.
 
-Example Applications
---------------------
 
-Building the Sample Applications
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-The multi-process example applications are built in the same way as other sample applications,
-and as documented in the *DPDK Getting Started Guide*.
+Compiling the Sample Applications
+---------------------------------
+The multi-process example applications are built in the same way as other sample applications
+as documented in the *DPDK Getting Started Guide*.
 
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The applications are located in the ``multi_process`` sub-directory.
 
@@ -27,14 +25,14 @@ The applications are located in the ``multi_process`` sub-directory.
     the final make command can be run just in that application's directory,
     rather than at the top-level multi-process directory.
 
-Basic Multi-process Example
-~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Basic Multi-Process Example
+---------------------------
 
 The examples/simple_mp folder in the DPDK release contains a basic example application to demonstrate how
 two DPDK processes can work together using queues and memory pools to share information.
 
 Running the Application
-^^^^^^^^^^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~~~~~~~~~~
 
 To run the application, start one copy of the simple_mp binary in one terminal,
 passing at least two cores in the coremask/corelist, as follows:
@@ -43,9 +41,10 @@ passing at least two cores in the coremask/corelist, as follows:
 
     ./<build_dir>/examples/dpdk-simple_mp -l 0-1 -n 4 --proc-type=primary
 
-For the first DPDK process run, the proc-type flag can be omitted or set to auto,
-since all DPDK processes will default to being a primary instance,
-meaning they have control over the hugepage shared memory regions.
+For the first DPDK process run, the proc-type flag can be omitted or set to auto
+since all DPDK processes will default to being a primary instance
+(meaning, they have control over the hugepage shared memory regions).
+
 The process should start successfully and display a command prompt as follows:
 
 .. code-block:: console
@@ -73,17 +72,18 @@ The process should start successfully and display a command prompt as follows:
     simple_mp >
 
 To run the secondary process to communicate with the primary process,
-again run the same binary setting at least two cores in the coremask/corelist:
+run the same binary setting again at least two cores in the coremask/corelist:
 
 .. code-block:: console
 
     ./<build_dir>/examples/dpdk-simple_mp -l 2-3 -n 4 --proc-type=secondary
 
-When running a secondary process such as that shown above, the proc-type parameter can again be specified as auto.
-However, omitting the parameter altogether will cause the process to try and start as a primary rather than secondary process.
+When running a secondary process such as that shown above, the proc-type parameter
+can again be specified as auto. However, omitting the parameter altogether will cause
+the process to try and start as a primary process, rather than secondary process.
 
-Once the process type is specified correctly,
-the process starts up, displaying largely similar status messages to the primary instance as it initializes.
+Once the process type is specified correctly, the process starts, displaying
+largely similar status messages to the primary instance as it initializes.
 Once again, you will be presented with a command prompt.
 
 Once both processes are running, messages can be sent between them using the send command.
@@ -106,7 +106,7 @@ At any stage, either process can be terminated using the quit command.
     The secondary process can be stopped and restarted without affecting the primary process.
 
 How the Application Works
-^^^^^^^^^^^^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The core of this example application is based on using two queues and a single memory pool in shared memory.
 These three objects are created at startup by the primary process,
@@ -130,14 +130,16 @@ Once a send command is issued by the user, a buffer is allocated from the memory
 then enqueued on the appropriate rte_ring.
 
 Symmetric Multi-process Example
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+-------------------------------
 
 The second example of DPDK multi-process support demonstrates how a set of processes can run in parallel,
-with each process performing the same set of packet- processing operations.
-(Since each process is identical in functionality to the others,
-we refer to this as symmetric multi-processing, to differentiate it from asymmetric multi- processing -
-such as a client-server mode of operation seen in the next example,
-where different processes perform different tasks, yet co-operate to form a packet-processing system.)
+with each process performing the same set of packet-processing operations.
+
+Since each process is identical in functionality to the others,
+we refer to this as symmetric multi-processing, to differentiate it from asymmetric multi-processing
+where different processes perform different tasks, yet co-operate to form a packet-processing system.
+The client-server mode of operation seen in the next example is a representation of this.
+
 The following diagram shows the data-flow through the application, using two processes.
 
 .. _figure_sym_multi_proc_app:
@@ -153,10 +155,10 @@ Each process reads a different RX queue on each port and so does not contend wit
 Similarly, each process writes outgoing packets to a different TX queue on each port.
 
 Running the Application
-^^^^^^^^^^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~~~~~~~~~~
 
 As with the simple_mp example, the first instance of the symmetric_mp process must be run as the primary instance,
-though with a number of other application- specific parameters also provided after the EAL arguments.
+though with a number of other application-specific parameters also provided after the EAL arguments.
 These additional parameters are:
 
 *   -p <portmask>, where portmask is a hexadecimal bitmask of what ports on the system are to be used.
@@ -199,7 +201,7 @@ the following commands can be used (assuming run as root):
     as auto-detection will detect no primary processes running and therefore attempt to re-initialize shared memory.)
 
 How the Application Works
-^^^^^^^^^^^^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The initialization calls in both the primary and secondary instances are the same for the most part,
 calling the rte_eal_init(), 1 G and 10 G driver initialization and then probing devices.
@@ -229,7 +231,7 @@ is exactly the same - each process reads from each port using the queue correspo
 and writes to the corresponding transmit queue on the output port.
 
 Client-Server Multi-process Example
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+-----------------------------------
 
 The third example multi-process application included with the DPDK shows how one can
 use a client-server type multi-process design to do packet processing.
@@ -248,7 +250,7 @@ The following diagram shows the data-flow through the application, using two cli
 
 
 Running the Application
-^^^^^^^^^^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~~~~~~~~~~
 
 The server process must be run initially as the primary process to set up all memory structures for use by the clients.
 In addition to the EAL parameters, the application- specific parameters are:
@@ -283,7 +285,7 @@ the following commands could be used:
     Any client processes that need restarting can be restarted without affecting the server process.
 
 How the Application Works
-^^^^^^^^^^^^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The server process performs the network port and data structure initialization much as the symmetric multi-process application does when run as primary.
 One additional enhancement in this sample application is that the server process stores its port configuration data in a memory zone in hugepage shared memory.
diff --git a/doc/guides/sample_app_ug/packet_ordering.rst b/doc/guides/sample_app_ug/packet_ordering.rst
index 1eb9a478aa..6d5a993712 100644
--- a/doc/guides/sample_app_ug/packet_ordering.rst
+++ b/doc/guides/sample_app_ug/packet_ordering.rst
@@ -4,29 +4,29 @@
 Packet Ordering Application
 ============================
 
-The Packet Ordering sample app simply shows the impact of reordering a stream.
-It's meant to stress the library with different configurations for performance.
+The Packet Ordering sample application shows the impact of reordering a stream.
+It is meant to stress the library with different configurations for performance.
 
 Overview
 --------
 
 The application uses at least three CPU cores:
 
-* RX core (main core) receives traffic from the NIC ports and feeds Worker
+* The RX core (main core) receives traffic from the NIC ports and feeds Worker
   cores with traffic through SW queues.
 
-* Worker (worker core) basically do some light work on the packet.
-  Currently it modifies the output port of the packet for configurations with
+* The Worker (worker core) does some light work on the packet.
+  Currently, it modifies the output port of the packet for configurations with
   more than one port enabled.
 
-* TX Core (worker core) receives traffic from Worker cores through software queues,
+* The TX Core (worker core) receives traffic from Worker cores through software queues,
   inserts out-of-order packets into reorder buffer, extracts ordered packets
   from the reorder buffer and sends them to the NIC ports for transmission.
 
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``packet_ordering`` sub-directory.
 
@@ -36,6 +36,9 @@ Running the Application
 Refer to *DPDK Getting Started Guide* for general information on running applications
 and the Environment Abstraction Layer (EAL) options.
 
+Explanation
+-----------
+
 Application Command Line
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -55,7 +58,7 @@ When setting more than 1 port, traffic would be forwarded in pairs.
 For example, if we enable 4 ports, traffic from port 0 to 1 and from 1 to 0,
 then the other pair from 2 to 3 and from 3 to 2, having [0,1] and [2,3] pairs.
 
-The disable-reorder long option does, as its name implies, disable the reordering
+The disable-reorder long option, as its name implies, disables the reordering
 of traffic, which should help evaluate reordering performance impact.
 
 The insight-worker long option enables output the packet statistics of each worker thread.
diff --git a/doc/guides/sample_app_ug/pipeline.rst b/doc/guides/sample_app_ug/pipeline.rst
index 58ed0d296a..e560f3fd48 100644
--- a/doc/guides/sample_app_ug/pipeline.rst
+++ b/doc/guides/sample_app_ug/pipeline.rst
@@ -4,8 +4,8 @@
 Pipeline Application
 ====================
 
-Application overview
---------------------
+Overview
+--------
 
 This application showcases the features of the Software Switch (SWX) pipeline that is aligned with the P4 language.
 
@@ -93,8 +93,10 @@ When running a telnet client as above, command prompt is displayed:
 Once application and telnet client start running, messages can be sent from client to application.
 
 
-Application stages
-------------------
+Explanation
+-----------
+
+Here is a description of the various stages of the application.
 
 Initialization
 ~~~~~~~~~~~~~~
diff --git a/doc/guides/sample_app_ug/ptpclient.rst b/doc/guides/sample_app_ug/ptpclient.rst
index d47e942738..4e99794c64 100644
--- a/doc/guides/sample_app_ug/ptpclient.rst
+++ b/doc/guides/sample_app_ug/ptpclient.rst
@@ -4,31 +4,37 @@
 PTP Client Sample Application
 =============================
 
-The PTP (Precision Time Protocol) client sample application is a simple
-example of using the DPDK IEEE1588 API to communicate with a PTP master clock
-to synchronize the time on the NIC and, optionally, on the Linux system.
+Overview
+--------
 
-Note, PTP is a time syncing protocol and cannot be used within DPDK as a
-time-stamping mechanism. See the following for an explanation of the protocol:
+The PTP (Precision Time Protocol) client sample application demonstrates
+the use of the DPDK IEEE1588 API to synchronize time with a PTP master clock.
+It synchronizes the time on the NIC and optionally on the Linux system.
+
+Note: PTP is a time syncing protocol and cannot be used within DPDK as a
+time-stamping mechanism.
+
+See the following for an explanation of the protocol:
 `Precision Time Protocol
 <https://en.wikipedia.org/wiki/Precision_Time_Protocol>`_.
 
 
 Limitations
------------
+~~~~~~~~~~~
 
 The PTP sample application is intended as a simple reference implementation of
 a PTP client using the DPDK IEEE1588 API.
+
 In order to keep the application simple the following assumptions are made:
 
-* The first discovered master is the main for the session.
+* The first discovered Master is the main for the session.
 * Only L2 PTP packets are supported.
 * Only the PTP v2 protocol is supported.
-* Only the slave clock is implemented.
+* Only the worker clock is implemented.
 
 
 How the Application Works
--------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
 .. _figure_ptpclient_highlevel:
 
@@ -38,12 +44,12 @@ How the Application Works
 
 The PTP synchronization in the sample application works as follows:
 
-* Master sends *Sync* message - the slave saves it as T2.
+* Master sends *Sync* message - the worker saves it as T2.
 * Master sends *Follow Up* message and sends time of T1.
-* Slave sends *Delay Request* frame to PTP Master and stores T3.
+* Worker sends *Delay Request* frame to PTP Master and stores T3.
 * Master sends *Delay Response* T4 time which is time of received T3.
 
-The adjustment for slave can be represented as:
+The adjustment for worker can be represented as:
 
    adj = -[(T2-T1)-(T4 - T3)]/2
 
@@ -53,7 +59,7 @@ synchronizes the PTP PHC clock with the Linux kernel clock.
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``ptpclient`` sub-directory.
 
@@ -71,12 +77,12 @@ Refer to *DPDK Getting Started Guide* for general information on running
 applications and the Environment Abstraction Layer (EAL) options.
 
 * ``-p portmask``: Hexadecimal portmask.
-* ``-T 0``: Update only the PTP slave clock.
-* ``-T 1``: Update the PTP slave clock and synchronize the Linux Kernel to the PTP clock.
+* ``-T 0``: Update only the PTP worker clock.
+* ``-T 1``: Update the PTP worker clock and synchronize the Linux Kernel to the PTP clock.
 
 
-Code Explanation
-----------------
+Explanation
+-----------
 
 The following sections provide an explanation of the main components of the
 code.
@@ -101,7 +107,7 @@ function. The value returned is the number of parsed arguments:
     :end-before: >8 End of initialization of EAL.
     :dedent: 1
 
-And than we parse application specific arguments
+Then, you parse application-specific arguments:
 
 .. literalinclude:: ../../../examples/ptpclient/ptpclient.c
     :language: c
@@ -145,7 +151,7 @@ The ``lcore_main()`` function is explained below.
 The Lcores Main
 ~~~~~~~~~~~~~~~
 
-As we saw above the ``main()`` function calls an application function on the
+As seen above, the ``main()`` function calls an application function on the
 available lcores.
 
 The main work of the application is done within the loop:
@@ -159,7 +165,7 @@ The main work of the application is done within the loop:
 Packets are received one by one on the RX ports and, if required, PTP response
 packets are transmitted on the TX ports.
 
-If the offload flags in the mbuf indicate that the packet is a PTP packet then
+If the offload flags in the mbuf indicate that the packet is a PTP packet, then
 the packet is parsed to determine which type:
 
 .. literalinclude:: ../../../examples/ptpclient/ptpclient.c
@@ -178,7 +184,7 @@ The forwarding loop can be interrupted and the application closed using
 PTP parsing
 ~~~~~~~~~~~
 
-The ``parse_ptp_frames()`` function processes PTP packets, implementing slave
+The ``parse_ptp_frames()`` function processes PTP packets, implementing worker
 PTP IEEE1588 L2 functionality.
 
 .. literalinclude:: ../../../examples/ptpclient/ptpclient.c
@@ -186,12 +192,12 @@ PTP IEEE1588 L2 functionality.
     :start-after: Parse ptp frames. 8<
     :end-before:  >8 End of function processes PTP packets.
 
-There are 3 types of packets on the RX path which we must parse to create a minimal
-implementation of the PTP slave client:
+There are 3 types of packets on the RX path which you must parse to create a minimal
+implementation of the PTP worker client:
 
 * SYNC packet.
 * FOLLOW UP packet
 * DELAY RESPONSE packet.
 
-When we parse the *FOLLOW UP* packet we also create and send a *DELAY_REQUEST* packet.
-Also when we parse the *DELAY RESPONSE* packet, and all conditions are met we adjust the PTP slave clock.
+When you parse the *FOLLOW UP* packet, you also create and send a *DELAY_REQUEST* packet.
+Also, when you parse the *DELAY RESPONSE* packet, and all conditions are met, you must adjust the PTP worker clock.
diff --git a/doc/guides/sample_app_ug/qos_metering.rst b/doc/guides/sample_app_ug/qos_metering.rst
index e7101559aa..b41567f3b0 100644
--- a/doc/guides/sample_app_ug/qos_metering.rst
+++ b/doc/guides/sample_app_ug/qos_metering.rst
@@ -4,7 +4,7 @@
 QoS Metering Sample Application
 ===============================
 
-The QoS meter sample application is an example that demonstrates the use of DPDK to provide QoS marking and metering,
+The QoS meter sample application demonstrates the use of DPDK to provide QoS marking and metering,
 as defined by RFC2697 for Single Rate Three Color Marker (srTCM) and RFC 2698 for Two Rate Three Color Marker (trTCM) algorithm.
 
 Overview
@@ -14,7 +14,8 @@ The application uses a single thread for reading the packets from the RX port,
 metering, marking them with the appropriate color (green, yellow or red) and writing them to the TX port.
 
 A policing scheme can be applied before writing the packets to the TX port by dropping or
-changing the color of the packet in a static manner depending on both the input and output colors of the packets that are processed by the meter.
+changing the color of the packet in a static manner. This would depend on both the input and output colors
+of the packets that are processed by the meter.
 
 The operation mode can be selected as compile time out of the following options:
 
@@ -126,11 +127,11 @@ There are four different actions:
 
 In this particular case:
 
-*   Every packet which input and output color are the same, keeps the same color.
+*   For every packet where the input and output color are the same, keep the same color.
 
-*   Every packet which color has improved is dropped (this particular case can't happen, so these values will not be used).
+*   For every packet where the color has improved is dropped (this particular case can't happen, so these values will not be used).
 
-*   For the rest of the cases, the color is changed to red.
+*   For the rest of the cases, the color is changes to red.
 
 .. note::
     * In color blind mode, first row GREEN color is only valid.
diff --git a/doc/guides/sample_app_ug/qos_scheduler.rst b/doc/guides/sample_app_ug/qos_scheduler.rst
index 9936b99172..a2d50b0a45 100644
--- a/doc/guides/sample_app_ug/qos_scheduler.rst
+++ b/doc/guides/sample_app_ug/qos_scheduler.rst
@@ -20,18 +20,20 @@ The architecture of the QoS scheduler application is shown in the following figu
 
 There are two flavors of the runtime execution for this application,
 with two or three threads per each packet flow configuration being used.
-The RX thread reads packets from the RX port,
+
+The RX thread reads packets from the RX port and
 classifies the packets based on the double VLAN (outer and inner) and
-the lower byte of the IP destination address and puts them into the ring queue.
+the lower byte of the IP destination address. It then puts them into the ring queue.
+
 The worker thread dequeues the packets from the ring and calls the QoS scheduler enqueue/dequeue functions.
 If a separate TX core is used, these are sent to the TX ring.
 Otherwise, they are sent directly to the TX port.
-The TX thread, if present, reads from the TX ring and write the packets to the TX port.
+The TX thread, if present, reads from the TX ring and writes the packets to the TX port.
 
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``qos_sched`` sub-directory.
 
diff --git a/doc/guides/sample_app_ug/service_cores.rst b/doc/guides/sample_app_ug/service_cores.rst
index 307a6c5fbb..5641740f2e 100644
--- a/doc/guides/sample_app_ug/service_cores.rst
+++ b/doc/guides/sample_app_ug/service_cores.rst
@@ -4,23 +4,26 @@
 Service Cores Sample Application
 ================================
 
-The service cores sample application demonstrates the service cores capabilities
-of DPDK. The service cores infrastructure is part of the DPDK EAL, and allows
-any DPDK component to register a service. A service is a work item or task, that
+Overview
+--------
+
+This sample application demonstrates the service core capabilities
+of DPDK. The service core infrastructure is part of the DPDK EAL and allows
+any DPDK component to register a service. A service is a work item or task that
 requires CPU time to perform its duty.
 
-This sample application registers 5 dummy services. These 5 services are used
-to show how the service_cores API can be used to orchestrate these services to
+This sample application registers 5 dummy services that are used
+to show how the service_cores API can orchestrate these services to
 run on different service lcores. This orchestration is done by calling the
-service cores APIs, however the sample application introduces a "profile"
-concept to contain the service mapping details. Note that the profile concept
-is application specific, and not a part of the service cores API.
+service cores APIs. However, the sample application introduces a "profile"
+concept to contain service mapping details. Note that the profile concept
+is application-specific, and not a part of the service cores API.
 
 
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``service_cores`` sub-directory.
 
@@ -39,8 +42,8 @@ pass a service core-mask as an EAL argument at startup time.
 Explanation
 -----------
 
-The following sections provide some explanation of code focusing on
-registering applications from an applications point of view, and modifying the
+The following sections provide explanation of the application code with focus on
+registering applications from an application's point of view and modifying the
 service core counts and mappings at runtime.
 
 
@@ -48,7 +51,7 @@ Registering a Service
 ~~~~~~~~~~~~~~~~~~~~~
 
 The following code section shows how to register a service as an application.
-Note that the service component header must be included by the application in
+Note: The service component header must be included by the application in
 order to register services: ``rte_service_component.h``, in addition
 to the ordinary service cores header ``rte_service.h`` which provides
 the runtime functions to add, remove and remap service cores.
@@ -80,7 +83,7 @@ Removing A Service Core
 ~~~~~~~~~~~~~~~~~~~~~~~
 
 To remove a service core, the steps are similar to adding but in reverse order.
-Note that it is not allowed to remove a service core if the service is running,
+Note: It is not allowed to remove a service core if the service is running,
 and the service-core is the only core running that service (see documentation
 for ``rte_service_lcore_stop`` function for details).
 
@@ -88,9 +91,11 @@ for ``rte_service_lcore_stop`` function for details).
 Conclusion
 ~~~~~~~~~~
 
-The service cores infrastructure provides DPDK with two main features. The first
-is to abstract away hardware differences: the service core can CPU cycles to
+The service cores infrastructure provides DPDK with two main features.
+
+The first is to abstract away hardware differences: the service core can CPU cycles to
 a software fallback implementation, allowing the application to be abstracted
-from the difference in HW / SW availability. The second feature is a flexible
-method of registering functions to be run, allowing the running of the
-functions to be scaled across multiple CPUs.
+from the difference in HW / SW availability.
+
+The second feature is a flexible method of registering functions to be run,
+allowing the running of the functions to be scaled across multiple CPUs.
diff --git a/doc/guides/sample_app_ug/test_pipeline.rst b/doc/guides/sample_app_ug/test_pipeline.rst
index d57d08fb2c..cf9f2dabac 100644
--- a/doc/guides/sample_app_ug/test_pipeline.rst
+++ b/doc/guides/sample_app_ug/test_pipeline.rst
@@ -30,7 +30,7 @@ The application uses three CPU cores:
 
 Compiling the Application
 -------------------------
-To compile the sample application see :doc:`compiling`
+To compile the sample application, see :doc:`compiling`
 
 The application is located in the ``dpdk/<build_dir>/app`` directory.
 
diff --git a/doc/guides/sample_app_ug/timer.rst b/doc/guides/sample_app_ug/timer.rst
index d8c6d9a656..6bef30b553 100644
--- a/doc/guides/sample_app_ug/timer.rst
+++ b/doc/guides/sample_app_ug/timer.rst
@@ -4,13 +4,16 @@
 Timer Sample Application
 ========================
 
-The Timer sample application is a simple application that demonstrates the use of a timer in a DPDK application.
-This application prints some messages from different lcores regularly, demonstrating the use of timers.
+Overview
+--------
+
+The Timer sample application demonstrates the use of a timer in a DPDK application.
+This application prints messages from different lcores regularly using timers.
 
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``timer`` sub-directory.
 
@@ -29,8 +32,6 @@ the Environment Abstraction Layer (EAL) options.
 Explanation
 -----------
 
-The following sections provide some explanation of the code.
-
 Initialization and Main Loop
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -76,7 +77,7 @@ This call to rte_timer_init() is necessary before doing any other operation on t
     :end-before: >8 End of init timer structures.
     :dedent: 1
 
-Then, the two timers are configured:
+Next, the two timers are configured:
 
 *   The first timer (timer0) is loaded on the main lcore and expires every second.
     Since the PERIODICAL flag is provided, the timer is reloaded automatically by the timer subsystem.
diff --git a/doc/guides/sample_app_ug/vdpa.rst b/doc/guides/sample_app_ug/vdpa.rst
index bc11242d03..d4eccaafc5 100644
--- a/doc/guides/sample_app_ug/vdpa.rst
+++ b/doc/guides/sample_app_ug/vdpa.rst
@@ -4,27 +4,30 @@
 Vdpa Sample Application
 =======================
 
-The vdpa sample application creates vhost-user sockets by using the
-vDPA backend. vDPA stands for vhost Data Path Acceleration which utilizes
-virtio ring compatible devices to serve virtio driver directly to enable
-datapath acceleration. As vDPA driver can help to set up vhost datapath,
-this application doesn't need to launch dedicated worker threads for vhost
+Overview
+--------
+
+The vDPA sample application creates vhost-user sockets by using the
+vDPA backend. vDPA (vhost Data Path Acceleration) utilizes
+virtio ring compatible devices to serve a virtio driver directly to enable
+datapath acceleration. A vDPA driver can help to set up vhost datapath.
+This application doesn't need to launch dedicated worker threads for vhost
 enqueue/dequeue operations.
 
-Testing steps
--------------
-
-This section shows the steps of how to start VMs with vDPA vhost-user
+This following shows the steps of how to start VMs with vDPA vhost-user
 backend and verify network connection & live migration.
 
-Build
-~~~~~
+Compiling the Application
+-------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``vdpa`` sub-directory.
 
-Start the vdpa example
+Running the Application
+-----------------------
+
+Start the vDPA example
 ~~~~~~~~~~~~~~~~~~~~~~
 
 .. code-block:: console
@@ -50,7 +53,7 @@ where
 
   #. quit: unregister vhost driver and exit the application
 
-Take IFCVF driver for example:
+Take IFCVF driver, for example:
 
 .. code-block:: console
 
@@ -65,7 +68,7 @@ Take IFCVF driver for example:
     * modprobe vfio-pci
     * ./usertools/dpdk-devbind.py -b vfio-pci 06:00.3 06:00.4
 
-Then we can create 2 vdpa ports in interactive cmdline.
+Then, we can create 2 vdpa ports in interactive cmdline.
 
 .. code-block:: console
 
@@ -100,9 +103,9 @@ network connection via ping or netperf.
 
 Live Migration
 ~~~~~~~~~~~~~~
-vDPA supports cross-backend live migration, user can migrate SW vhost backend
-VM to vDPA backend VM and vice versa. Here are the detailed steps. Assume A is
-the source host with SW vhost VM and B is the destination host with vDPA.
+vDPA supports cross-backend live migration. A user can migrate SW vhost backend
+VM to vDPA backend VM and vice versa. Here are the detailed steps.
+Assume A is the source host with SW vhost VM and B is the destination host with vDPA.
 
 #. Start vdpa sample and launch a VM with exact same parameters as the VM on A,
    in migration-listen mode:
diff --git a/doc/guides/sample_app_ug/vhost.rst b/doc/guides/sample_app_ug/vhost.rst
index 982e19214d..c76d1c15e2 100644
--- a/doc/guides/sample_app_ug/vhost.rst
+++ b/doc/guides/sample_app_ug/vhost.rst
@@ -4,6 +4,9 @@
 Vhost Sample Application
 ========================
 
+Overview
+--------
+
 The vhost sample application demonstrates integration of the Data Plane
 Development Kit (DPDK) with the Linux* KVM hypervisor by implementing the
 vhost-net offload API. The sample application performs simple packet
@@ -14,19 +17,19 @@ Machine Device Queues (VMDQ) and Data Center Bridging (DCB) features of
 the Intel® 82599 10 Gigabit Ethernet Controller.
 
 Testing steps
--------------
+~~~~~~~~~~~~~
 
-This section shows the steps how to test a typical PVP case with this
-dpdk-vhost sample, whereas packets are received from the physical NIC
+This section shows the steps for how to test a typical PVP case with this
+dpdk-vhost sample, where packets are received from the physical NIC
 port first and enqueued to the VM's Rx queue. Through the guest testpmd's
 default forwarding mode (io forward), those packets will be put into
 the Tx queue. The dpdk-vhost example, in turn, gets the packets and
 puts back to the same physical NIC port.
 
-Build
-~~~~~
+Compiling the Application
+-------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``vhost`` sub-directory.
 
@@ -64,24 +67,27 @@ Start the vswitch example
              -- --socket-file /tmp/sock0 --client \
              ...
 
-Check the `Parameters`_ section for the explanations on what do those
+Check the `Parameters`_ section for the explanations on what the
 parameters mean.
 
+Running the Application
+-----------------------
+
 .. _vhost_app_run_dpdk_inside_guest:
 
 Run testpmd inside guest
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
-Make sure you have DPDK built inside the guest. Also make sure the
+Ensure DPDK is built inside the guest and that the
 corresponding virtio-net PCI device is bond to a UIO driver, which
-could be done by:
+can be done by:
 
 .. code-block:: console
 
    modprobe vfio-pci
    dpdk/usertools/dpdk-devbind.py -b vfio-pci 0000:00:04.0
 
-Then start testpmd for packet forwarding testing.
+Then, start testpmd for packet forwarding testing.
 
 .. code-block:: console
 
@@ -91,13 +97,16 @@ Then start testpmd for packet forwarding testing.
 For more information about vIOMMU and NO-IOMMU and VFIO please refer to
 :doc:`/../linux_gsg/linux_drivers` section of the DPDK Getting started guide.
 
+Explanation
+-----------
+
 Inject packets
---------------
+~~~~~~~~~~~~~~
 
 While a virtio-net is connected to dpdk-vhost, a VLAN tag starts with
-1000 is assigned to it. So make sure configure your packet generator
-with the right MAC and VLAN tag, you should be able to see following
-log from the dpdk-vhost console. It means you get it work::
+1000 is assigned to it. Therefore, be sure to configure your packet generator
+with the right MAC and VLAN tag. You should be able to see following
+log from the dpdk-vhost console::
 
     VHOST_DATA: (0) mac 52:54:00:00:00:14 and vlan 1000 registered
 
@@ -105,7 +114,7 @@ log from the dpdk-vhost console. It means you get it work::
 .. _vhost_app_parameters:
 
 Parameters
-----------
+~~~~~~~~~~
 
 **--socket-file path**
 Specifies the vhost-user socket file path.
@@ -143,7 +152,7 @@ enabled by default.
 
 **--rx-retry-num num**
 The rx-retry-num option specifies the number of retries on an Rx burst, it
-takes effect only when rx retry is enabled.  The default value is 4.
+takes effect only when rx retry is enabled. The default value is 4.
 
 **--rx-retry-delay msec**
 The rx-retry-delay option specifies the timeout (in micro seconds) between
@@ -156,7 +165,7 @@ vhost APIs will be used when this option is given. It is disabled by default.
 
 **--dmas**
 This parameter is used to specify the assigned DMA device of a vhost device.
-Async vhost-user net driver will be used if --dmas is set. For example
+Async vhost-user net driver will be used if --dmas is set. For example,
 --dmas [txd0@00:04.0,txd1@00:04.1,rxd0@00:04.2,rxd1@00:04.3] means use
 DMA channel 00:04.0/00:04.2 for vhost device 0 enqueue/dequeue operation
 and use DMA channel 00:04.1/00:04.3 for vhost device 1 enqueue/dequeue
@@ -179,14 +188,14 @@ Disables/enables TX checksum offload.
 Port mask which specifies the ports to be used
 
 Common Issues
--------------
+~~~~~~~~~~~~~
 
-* QEMU fails to allocate memory on hugetlbfs, with an error like the
+* QEMU fails to allocate memory on hugetlbfs and shows an error like the
   following::
 
       file_ram_alloc: can't mmap RAM pages: Cannot allocate memory
 
-  When running QEMU the above error indicates that it has failed to allocate
+  When running QEMU, the above error indicates that it has failed to allocate
   memory for the Virtual Machine on the hugetlbfs. This is typically due to
   insufficient hugepages being free to support the allocation request. The
   number of free hugepages can be checked as follows:
@@ -200,7 +209,7 @@ Common Issues
 
 * Failed to build DPDK in VM
 
-  Make sure "-cpu host" QEMU option is given.
+  Make sure the "-cpu host" QEMU option is given.
 
 * Device start fails if NIC's max queues > the default number of 128
 
diff --git a/doc/guides/sample_app_ug/vhost_blk.rst b/doc/guides/sample_app_ug/vhost_blk.rst
index 788eef0d5f..f69b59baef 100644
--- a/doc/guides/sample_app_ug/vhost_blk.rst
+++ b/doc/guides/sample_app_ug/vhost_blk.rst
@@ -4,32 +4,35 @@
 Vhost_blk Sample Application
 =============================
 
-The vhost_blk sample application implemented a simple block device,
-which used as the  backend of Qemu vhost-user-blk device. Users can extend
-the exist example to use other type of block device(e.g. AIO) besides
+Overview
+--------
+
+The vhost_blk sample application implements a simple block device,
+used as the  backend of Qemu vhost-user-blk device. Users can extend
+the exist example to use other type of block device (e.g. AIO) besides
 memory based block device. Similar with vhost-user-net device, the sample
 application used domain socket to communicate with Qemu, and the virtio
 ring (split or packed format) was processed by vhost_blk sample application.
 
-The sample application reuse lots codes from SPDK(Storage Performance
+The sample application reuses codes from SPDK (Storage Performance
 Development Kit, https://github.com/spdk/spdk) vhost-user-blk target,
 for DPDK vhost library used in storage area, user can take SPDK as
 reference as well.
 
-Testing steps
--------------
-
 This section shows the steps how to start a VM with the block device as
 fast data path for critical application.
 
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``examples`` sub-directory.
 
-You will also need to build DPDK both on the host and inside the guest
+You will need to build DPDK both on the host and inside the guest.
+
+Running the Application
+-----------------------
 
 Start the vhost_blk example
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/doc/guides/sample_app_ug/vhost_crypto.rst b/doc/guides/sample_app_ug/vhost_crypto.rst
index 7ae7addac4..cab721425b 100644
--- a/doc/guides/sample_app_ug/vhost_crypto.rst
+++ b/doc/guides/sample_app_ug/vhost_crypto.rst
@@ -4,25 +4,28 @@
 Vhost_Crypto Sample Application
 ===============================
 
-The vhost_crypto sample application implemented a simple Crypto device,
-which used as the  backend of Qemu vhost-user-crypto device. Similar with
+Overview
+--------
+
+The vhost_crypto sample application implements a Crypto device used
+as the  backend of Qemu vhost-user-crypto device. Similar with
 vhost-user-net and vhost-user-scsi device, the sample application used
 domain socket to communicate with Qemu, and the virtio ring was processed
 by vhost_crypto sample application.
 
-Testing steps
--------------
-
 This section shows the steps how to start a VM with the crypto device as
 fast data path for critical application.
 
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``examples`` sub-directory.
 
+Running the Application
+-----------------------
+
 Start the vhost_crypto example
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/doc/guides/sample_app_ug/vm_power_management.rst b/doc/guides/sample_app_ug/vm_power_management.rst
index e0af729e66..4cc12c672a 100644
--- a/doc/guides/sample_app_ug/vm_power_management.rst
+++ b/doc/guides/sample_app_ug/vm_power_management.rst
@@ -4,20 +4,21 @@
 Virtual Machine Power Management Application
 ============================================
 
-Applications running in virtual environments have an abstract view of
-the underlying hardware on the host. Specifically, applications cannot
-see the binding of virtual components to physical hardware. When looking
-at CPU resourcing, the pinning of Virtual CPUs (vCPUs) to Physical CPUs
-(pCPUs) on the host is not apparent to an application and this pinning
-may change over time. In addition, operating systems on Virtual Machines
-(VMs) do not have the ability to govern their own power policy. The
-Machine Specific Registers (MSRs) for enabling P-state transitions are
-not exposed to the operating systems running on the VMs.
-
-The solution demonstrated in this sample application shows an example of
-how a DPDK application can indicate its processing requirements using
-VM-local only information (vCPU/lcore, and so on) to a host resident VM
-Power Manager. The VM Power Manager is responsible for:
+Overview
+--------
+
+Applications in virtual environments have a limited view of the host hardware.
+They cannot see how virtual components map to physical hardware, including the
+pinning of virtual CPUs (vCPUs) to physical CPUs (pCPUs), which may change over time.
+Additionally, virtual machine operating systems cannot manage their own power policies,
+as the necessary Machine Specific Registers (MSRs) for controlling P-state transitions
+are not accessible.
+
+This sample application demonstrates how a DPDK application can communicate its
+processing needs using local VM information (like vCPU or lcore details) to a
+host-based VM Power Manager.
+
+The VM Power Manager is responsible for:
 
 - **Accepting requests for frequency changes for a vCPU**
 - **Translating the vCPU to a pCPU using libvirt**
@@ -84,77 +85,64 @@ in the host.
   state, manually altering CPU frequency. Also allows for the changings
   of vCPU to pCPU pinning
 
-Sample Application Architecture Overview
-----------------------------------------
-
-The VM power management solution employs ``qemu-kvm`` to provide
-communications channels between the host and VMs in the form of a
-``virtio-serial`` connection that appears as a para-virtualised serial
-device on a VM and can be configured to use various backends on the
-host. For this example, the configuration of each ``virtio-serial`` endpoint
-on the host as an ``AF_UNIX`` file socket, supporting poll/select and
-``epoll`` for event notification. In this example, each channel endpoint on
-the host is monitored for ``EPOLLIN`` events using ``epoll``. Each channel
-is specified as ``qemu-kvm`` arguments or as ``libvirt`` XML for each VM,
-where each VM can have several channels up to a maximum of 64 per VM. In this
-example, each DPDK lcore on a VM has exclusive access to a channel.
-
-To enable frequency changes from within a VM, the VM forwards a
-``librte_power`` request over the ``virtio-serial`` channel to the host. Each
-request contains the vCPU and power command (scale up/down/min/max). The
-API for the host ``librte_power`` and guest ``librte_power`` is consistent
-across environments, with the selection of VM or host implementation
-determined automatically at runtime based on the environment. On
-receiving a request, the host translates the vCPU to a pCPU using the
-libvirt API before forwarding it to the host ``librte_power``.
+Sample Application Architecture
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
+The VM power management solution uses ``qemu-kvm`` to create communication
+channels between the host and VMs through a ``virtio-serial`` connection.
+This connection appears as a para-virtualized serial device on the VM
+and can use various backends on the host. In this example, each ``virtio-serial``
+endpoint is configured as an ``AF_UNIX`` file socket on the host, supporting
+event notifications via ``poll``, `select``, or ``epoll``. The host monitors
+each channel for ``EPOLLIN`` events using ``epoll``, with up to 64 channels per VM.
+Each DPDK lcore on a VM has exclusive access to a channel.
+
+To enable frequency scaling from within a VM, the VM sends a ``librte_power``
+request over the ``virtio-serial`` channel to the host. The request specifies
+the vCPU and desired power action (e.g., scale up, scale down, set to min/max).
+The ``librte_power`` API is consistent across environments, automatically selecting
+the appropriate VM or host implementation at runtime. Upon receiving a request,
+the host maps the vCPU to a pCPU using the libvirt API and forwards the command
+to the host’s ``librte_power`` for execution.
 
 .. _figure_vm_power_mgr_vm_request_seq:
 
 .. figure:: img/vm_power_mgr_vm_request_seq.*
 
-In addition to the ability to send power management requests to the
-host, a VM can send a power management policy to the host. In some
-cases, using a power management policy is a preferred option because it
-can eliminate possible latency issues that can occur when sending power
-management requests. Once the VM sends the policy to the host, the VM no
-longer needs to worry about power management, because the host now
-manages the power for the VM based on the policy. The policy can specify
-power behavior that is based on incoming traffic rates or time-of-day
-power adjustment (busy/quiet hour power adjustment for example). See
-:ref:`sending_policy` for more information.
-
-One method of power management is to sense how busy a core is when
-processing packets and adjusting power accordingly. One technique for
-doing this is to monitor the ratio of the branch miss to branch hits
-counters and scale the core power accordingly. This technique is based
-on the premise that when a core is not processing packets, the ratio of
-branch misses to branch hits is very low, but when the core is
-processing packets, it is measurably higher. The implementation of this
-capability is as a policy of type ``BRANCH_RATIO``.
-See :ref:`sending_policy` for more information on using the
-BRANCH_RATIO policy option.
-
-A JSON interface enables the specification of power management requests
-and policies in JSON format. The JSON interfaces provide a more
-convenient and more easily interpreted interface for the specification
-of requests and policies. See :ref:`power_man_requests` for more information.
+In addition to sending power management requests to the
+host, a VM can send a power management policy to the host.
+Using a policy is often preferred as it avoids potential
+latency issues from frequent requests. Once the policy is
+sent, the host manages the VM's power based on the policy,
+freeing the VM from further involvement. Policies can include
+rules like adjusting power based on traffic rates or setting
+power levels for busy and quiet hours. See :ref:`sending_policy`
+for more information.
+
+One power management method monitors core activity by tracking
+the ratio of branch misses to branch hits. When a core is idle,
+this ratio is low; when it’s busy processing packets, the ratio increases.
+This technique, implemented as a ``BRANCH_RATIO`` policy, adjusts core power
+dynamically based on workload. See :ref:`sending_policy` for more information
+on using the BRANCH_RATIO policy option.
+
+Power management requests and policies can also be defined using a JSON interface,
+which provides a simpler and more readable way to specify these configurations.
+For more details, see :ref:`power_man_requests` for more information.
 
 Performance Considerations
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-While the Haswell microarchitecture allows for independent power control
-for each core, earlier microarchitectures do not offer such fine-grained
-control. When deploying on pre-Haswell platforms, greater care must be
-taken when selecting which cores are assigned to a VM, for example, a
-core does not scale down in frequency until all of its siblings are
-similarly scaled down.
+The Haswell microarchitecture enables independent power control for each core,
+but earlier microarchitectures lack this level of precision. On pre-Haswell platforms,
+careful consideration is needed when assigning cores to a VM. For instance, a core cannot
+scale down its frequency until all its sibling cores are also scaled down.
 
 Configuration
--------------
+~~~~~~~~~~~~~
 
 BIOS
-~~~~
+^^^^
 
 To use the power management features of the DPDK, you must enable
 Enhanced Intel SpeedStep® Technology in the platform BIOS. Otherwise,
@@ -163,7 +151,7 @@ exist, and you cannot use CPU frequency-based power management. Refer to the
 relevant BIOS documentation to determine how to access these settings.
 
 Host Operating System
-~~~~~~~~~~~~~~~~~~~~~
+^^^^^^^^^^^^^^^^^^^^^
 
 The DPDK Power Management library can use either the ``acpi_cpufreq`` or
 the ``intel_pstate`` kernel driver for the management of core frequencies. In
@@ -183,7 +171,7 @@ On reboot, load the ``acpi_cpufreq`` module:
    ``modprobe acpi_cpufreq``
 
 Hypervisor Channel Configuration
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Configure ``virtio-serial`` channels using ``libvirt`` XML.
 The XML structure is as follows: 
@@ -324,7 +312,7 @@ comma-separated list of channel numbers to add. Specifying the keyword
 
    set_query {vm_name} enable|disable
 
-Manual control and inspection can also be carried in relation CPU frequency scaling:
+Manual control and inspection can also be carried in relation to CPU frequency scaling:
 
   Get the current frequency for each core specified in the mask:
 
@@ -479,7 +467,7 @@ correct directory using the following find command:
    /usr/lib/i386-linux-gnu/pkgconfig
    /usr/lib/x86_64-linux-gnu/pkgconfig
 
-Then use:
+Then, use:
 
 .. code-block:: console
 
diff --git a/doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst b/doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst
index 9638f51dec..8f3d5589f1 100644
--- a/doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst
+++ b/doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst
@@ -4,31 +4,34 @@
 VMDQ and DCB Forwarding Sample Application
 ==========================================
 
-The VMDQ and DCB Forwarding sample application is a simple example of packet processing using the DPDK.
-The application performs L2 forwarding using VMDQ and DCB to divide the incoming traffic into queues.
-The traffic splitting is performed in hardware by the VMDQ and DCB features of the Intel® 82599 and X710/XL710 Ethernet Controllers.
+The VMDQ and DCB Forwarding sample application shows L2 forwarding packet processing
+using VMDQ and DCB. It divides the incoming traffic into queues performed in hardware
+by the VMDQ and DCB features of the Intel® 82599 and X710/XL710 Ethernet Controllers.
 
 Overview
 --------
 
-This sample application can be used as a starting point for developing a new application that is based on the DPDK and
-uses VMDQ and DCB for traffic partitioning.
+This sample application can be used as a starting point for developing a new application
+that is based on the DPDK anduses VMDQ and DCB for traffic partitioning.
+
+The VMDQ and DCB filters work on MAC and VLAN traffic to divide the traffic into input queues
+on the basis of the Destination MAC address, VLAN ID and VLAN user priority fields.
 
-The VMDQ and DCB filters work on MAC and VLAN traffic to divide the traffic into input queues on the basis of the Destination MAC
-address, VLAN ID and VLAN user priority fields.
 VMDQ filters split the traffic into 16 or 32 groups based on the Destination MAC and VLAN ID.
 Then, DCB places each packet into one of queues within that group, based upon the VLAN user priority field.
 
-All traffic is read from a single incoming port (port 0) and output on port 1, without any processing being performed.
-With Intel® 82599 NIC, for example, the traffic is split into 128 queues on input, where each thread of the application reads from
-multiple queues. When run with 8 threads, that is, with the -c FF option, each thread receives and forwards packets from 16 queues.
+All traffic is read from a single incoming port (port 0) and output on port 1 without any processing being performed.
+
+Using Intel® 82599 NIC, the traffic is split into 128 queues on input, where each thread of the application reads from
+multiple queues. When run with 8 thread (with the -c FF option), each thread receives and forwards packets from 16 queues.
 
 As supplied, the sample application configures the VMDQ feature to have 32 pools with 4 queues each as indicated in :numref:`figure_vmdq_dcb_example`.
-The Intel® 82599 10 Gigabit Ethernet Controller NIC also supports the splitting of traffic into 16 pools of 8 queues. While the
-Intel® X710 or XL710 Ethernet Controller NICs support many configurations of VMDQ pools of 4 or 8 queues each. For simplicity, only 16
-or 32 pools is supported in this sample. And queues numbers for each VMDQ pool can be changed by setting RTE_LIBRTE_I40E_QUEUE_NUM_PER_VM
-in config/rte_config.h file.
-The nb-pools, nb-tcs and enable-rss parameters can be passed on the command line, after the EAL parameters:
+The Intel® 82599 10 Gigabit Ethernet Controller NIC also supports the splitting of traffic into 16 pools of 8 queues.
+The Intel® X710 or XL710 Ethernet Controller NICs support many configurations of VMDQ pools of 4 or 8 queues each.
+
+For simplicity, only 16 or 32 pools are supported in this sample. Queues numbers for each VMDQ pool
+can be changed by setting RTE_LIBRTE_I40E_QUEUE_NUM_PER_VM in config/rte_config.h file.
+The nb-pools, nb-tcs and enable-rss parameters can be passed on the command line after the EAL parameters:
 
 .. code-block:: console
 
@@ -43,11 +46,10 @@ where, NP can be 16 or 32, TC can be 4 or 8, rss is disabled by default.
    Packet Flow Through the VMDQ and DCB Sample Application
 
 
-In Linux* user space, the application can display statistics with the number of packets received on each queue.
-To have the application display the statistics, send a SIGHUP signal to the running application process.
+In a Linux* user space, the application can display statistics with the number of packets received on each queue.
+To have the application display statistics, send a SIGHUP signal to the running application process.
 
 The VMDQ and DCB Forwarding sample application is in many ways simpler than the L2 Forwarding application
-(see :doc:`l2_forward_real_virtual`)
 as it performs unidirectional L2 forwarding of packets from one port to a second port.
 No command-line options are taken by this application apart from the standard EAL command-line options.
 
@@ -59,9 +61,7 @@ No command-line options are taken by this application apart from the standard EA
 Compiling the Application
 -------------------------
 
-
-
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``vmdq_dcb`` sub-directory.
 
@@ -80,20 +80,20 @@ the Environment Abstraction Layer (EAL) options.
 Explanation
 -----------
 
-The following sections provide some explanation of the code.
+The following sections provide explanation of the code.
 
 Initialization
 ~~~~~~~~~~~~~~
 
 The EAL, driver and PCI configuration is performed largely as in the L2 Forwarding sample application,
 as is the creation of the mbuf pool.
-See :doc:`l2_forward_real_virtual`.
-Where this example application differs is in the configuration of the NIC port for RX.
+
+See :doc:`l2_forward_real_virtual`. This example application differs in the configuration of the NIC port for Rx.
 
 The VMDQ and DCB hardware feature is configured at port initialization time by setting the appropriate values in the
 rte_eth_conf structure passed to the rte_eth_dev_configure() API.
-Initially in the application,
-a default structure is provided for VMDQ and DCB configuration to be filled in later by the application.
+
+Initially in the application, a default structure is provided for VMDQ and DCB configuration to be filled in later by the application.
 
 .. literalinclude:: ../../../examples/vmdq_dcb/main.c
     :language: c
@@ -101,18 +101,21 @@ a default structure is provided for VMDQ and DCB configuration to be filled in l
     :end-before: >8 End of empty vmdq+dcb configuration structure.
 
 The get_eth_conf() function fills in an rte_eth_conf structure with the appropriate values,
-based on the global vlan_tags array,
-and dividing up the possible user priority values equally among the individual queues
-(also referred to as traffic classes) within each pool. With Intel® 82599 NIC,
-if the number of pools is 32, then the user priority fields are allocated 2 to a queue.
+based on the global vlan_tags array, and divides up the possible user priority values equally
+among the individual queues (also referred to as traffic classes) within each pool.
+
+With Intel® 82599 NIC, if the number of pools is 32, then the user priority fields are allocated 2 to a queue.
 If 16 pools are used, then each of the 8 user priority fields is allocated to its own queue within the pool.
-With Intel® X710/XL710 NICs, if number of tcs is 4, and number of queues in pool is 8,
-then the user priority fields are allocated 2 to one tc, and a tc has 2 queues mapping to it, then
-RSS will determine the destination queue in 2.
-For the VLAN IDs, each one can be allocated to possibly multiple pools of queues,
+
+With Intel® X710/XL710 NICs, if the number of tcs is 4, and number of queues in pool is 8,
+then the user priority fields are allocated 2 to one tc.
+
+If the tc has 2 queues mapping to it, then RSS will determine the destination queue in 2.
+For the VLAN IDs, each one can be allocated to multiple pools of queues,
 so the pools parameter in the rte_eth_vmdq_dcb_conf structure is specified as a bitmask value.
+
 For destination MAC, each VMDQ pool will be assigned with a MAC address. In this sample, each VMDQ pool
-is assigned to the MAC like 52:54:00:12:<port_id>:<pool_id>, that is,
+is assigned to the MAC like 52:54:00:12:<port_id>:<pool_id>, and
 the MAC of VMDQ pool 2 on port 1 is 52:54:00:12:01:02.
 
 .. literalinclude:: ../../../examples/vmdq_dcb/main.c
@@ -134,8 +137,8 @@ See :doc:`l2_forward_real_virtual` for more information.
 Statistics Display
 ~~~~~~~~~~~~~~~~~~
 
-When run in a linux environment,
-the VMDQ and DCB Forwarding sample application can display statistics showing the number of packets read from each RX queue.
+When run in a linux environment, the VMDQ and DCB Forwarding sample application can display
+statistics showing the number of packets read from each Rx queue.
 This is provided by way of a signal handler for the SIGHUP signal,
 which simply prints to standard output the packet counts in grid form.
 Each row of the output is a single pool with the columns being the queue number within that pool.
diff --git a/doc/guides/sample_app_ug/vmdq_forwarding.rst b/doc/guides/sample_app_ug/vmdq_forwarding.rst
index ed28525a15..b1b4d5a809 100644
--- a/doc/guides/sample_app_ug/vmdq_forwarding.rst
+++ b/doc/guides/sample_app_ug/vmdq_forwarding.rst
@@ -2,9 +2,9 @@
     Copyright(c) 2020 Intel Corporation.
 
 VMDq Forwarding Sample Application
-==========================================
+==================================
 
-The VMDq Forwarding sample application is a simple example of packet processing using the DPDK.
+The VMDq Forwarding sample application is an example of packet processing using the DPDK.
 The application performs L2 forwarding using VMDq to divide the incoming traffic into queues.
 The traffic splitting is performed in hardware by the VMDq feature of the Intel® 82599 and X710/XL710 Ethernet Controllers.
 
@@ -14,12 +14,12 @@ Overview
 This sample application can be used as a starting point for developing a new application that is based on the DPDK and
 uses VMDq for traffic partitioning.
 
-VMDq filters split the incoming packets up into different "pools" - each with its own set of RX queues - based upon
+VMDq filters split the incoming packets up into different "pools" (each with its own set of Rx queues) based upon
 the MAC address and VLAN ID within the VLAN tag of the packet.
 
 All traffic is read from a single incoming port and output on another port, without any processing being performed.
 With Intel® 82599 NIC, for example, the traffic is split into 128 queues on input, where each thread of the application reads from
-multiple queues. When run with 8 threads, that is, with the -c FF option, each thread receives and forwards packets from 16 queues.
+multiple queues. When run with 8 threads with the -c FF option, each thread receives and forwards packets from 16 queues.
 
 As supplied, the sample application configures the VMDq feature to have 32 pools with 4 queues each.
 The Intel® 82599 10 Gigabit Ethernet Controller NIC also supports the splitting of traffic into 16 pools of 2 queues.
@@ -34,8 +34,8 @@ The nb-pools and enable-rss parameters can be passed on the command line, after
 
 where, NP can be 8, 16 or 32, rss is disabled by default.
 
-In Linux* user space, the application can display statistics with the number of packets received on each queue.
-To have the application display the statistics, send a SIGHUP signal to the running application process.
+In a Linux* user space, the application can display statistics with the number of packets received on each queue.
+To have the application display statistics, send a SIGHUP signal to the running application process.
 
 The VMDq Forwarding sample application is in many ways simpler than the L2 Forwarding application
 (see :doc:`l2_forward_real_virtual`)
@@ -45,7 +45,7 @@ No command-line options are taken by this application apart from the standard EA
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``vmdq`` sub-directory.
 
@@ -64,20 +64,18 @@ the Environment Abstraction Layer (EAL) options.
 Explanation
 -----------
 
-The following sections provide some explanation of the code.
+The following sections provide explanation of the code.
 
 Initialization
 ~~~~~~~~~~~~~~
 
 The EAL, driver and PCI configuration is performed largely as in the L2 Forwarding sample application,
-as is the creation of the mbuf pool.
-See :doc:`l2_forward_real_virtual`.
-Where this example application differs is in the configuration of the NIC port for RX.
+as is the creation of the mbuf pool. See :doc:`l2_forward_real_virtual`.
+This example application differs in the configuration of the NIC port for Rx.
 
 The VMDq hardware feature is configured at port initialization time by setting the appropriate values in the
 rte_eth_conf structure passed to the rte_eth_dev_configure() API.
-Initially in the application,
-a default structure is provided for VMDq configuration to be filled in later by the application.
+Initially in the application, a default structure is provided for VMDq configuration to be filled in later by the application.
 
 .. literalinclude:: ../../../examples/vmdq/main.c
     :language: c
@@ -88,8 +86,8 @@ The get_eth_conf() function fills in an rte_eth_conf structure with the appropri
 based on the global vlan_tags array.
 For the VLAN IDs, each one can be allocated to possibly multiple pools of queues.
 For destination MAC, each VMDq pool will be assigned with a MAC address. In this sample, each VMDq pool
-is assigned to the MAC like 52:54:00:12:<port_id>:<pool_id>, that is,
-the MAC of VMDq pool 2 on port 1 is 52:54:00:12:01:02.
+is assigned to the MAC like 52:54:00:12:<port_id>:<pool_id>.
+The MAC of VMDq pool 2 on port 1 is 52:54:00:12:01:02.
 
 .. literalinclude:: ../../../examples/vmdq/main.c
     :language: c
-- 
2.34.1

