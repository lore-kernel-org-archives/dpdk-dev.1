Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C35D3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:25:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A833D40E3B;
	Wed, 14 Jan 2026 23:25:18 +0100 (CET)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65]) by mails.dpdk.org (Postfix) with ESMTP id 45B5A40ED8
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:17 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso605345e9.2
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429517;
 x=1769034317; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VJJDuhr4/n/ncUAVgZceeahoXW7gvkdv7nBpkFOyf68=;
 b=Gq6ii/XNk34zQ96CN4T53GXzxUjWed2HaceNHaKGuzfNvYdBq7LYuN61BSJofw+XBx
 qD/21utQNnj+n5NmuKR0xXD46Eu2w8N8YokKRTL8b/CEbOJaugpQ/onoP8QLTXLvxj+u
 iMwlgY/Gvf2KSUxP3Kwd3GeeUw3RSpQqJjy0S5ysRY2MwoLwn387m7U+N9n22i4ngkcM
 pRvapkOLyVT/9pEccgohFgiRPmb5pSFv1N4ip0q35PZSucqjfxQpGELXdVrTrEemWz2Y
 +pIPhFQQ6WTpwd8kgjc6MHdYs08n+TkK9S9MdYDEUPdLzcEvWkSObp8HZhXztFDtpNHw
 maoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429517; x=1769034317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VJJDuhr4/n/ncUAVgZceeahoXW7gvkdv7nBpkFOyf68=;
 b=i0Dpz+dbLguXDDBn/2QtdONizcTQiM1AD5JQHCxCBvHveM4uD/QiOviQ4s+aN37Zh1
 p9VJJ1HD9MBJUj12sA7O/yy2rfJBBPmXpGfKv6+XRlMD9ITE15/PWPtHHj+HGRwYS/LC
 3JlhaPKzr53Lqei2xGDBxgfSobyNctGzUs9Mjz+pwIHbtD1bIrssK06pYBMi9A533+RG
 VBGzKkasubRwljrWT1e+A7jX8g+8aP8vnrLrERyVklnw1r+5AVMkNi2/YA1zcv5ALMyn
 cH5k7LSB9UXylFHQv/IocvxL4by6G20CEJGsYIWSg3pF3C4OdXAc4w2RUI2x0rJljfBw
 rVHw==
X-Gm-Message-State: AOJu0YxR1RdQwvxHUZHUX9fT6Dmr+SG//fNlMF7XJh0w5JwyPKCKVVbS
 S4xSQJN6ILEoYe1fjExUi4uDy+eidn41J2MkAecFvtRDzTSFrpBuG4kntQ28yJB1vY5X6g5FKgl
 At0OZ1HM=
X-Gm-Gg: AY/fxX5KmSIJXJwh/5jZ7gcIc7BcYIkwnaGw7o5EZyeU+plpqF6qsZCemvUqjpR11JQ
 lQwx/pVjwa0bX8nzClHrteDeksrkvsECuJuZHBLKluu4tXkzV83mQjHb224rEr9yXcguPAvyJM4
 ZNhbRryAkbYnH7QdwhHVVbHjgeSxF/Cbxf1Jm6siA7ZO8zL0mkB3aAl3OqZOzQaVC3Hbb9MLT+N
 13KhxGv6f0bt8u1M2F3YCrofjsTfPyQluV52ughO84JDObZtsgAJFtXVP4L2O2TWnOHZmsu6I7k
 bjjARg2/Ny0OSaeLPPV4IHIAnCjR8QK5ED8NBXx5kmhfVTiaVmB6uIX6hEwmTsbizW/plZAzMRa
 l4OQNv+q9JTqxP/5+Q46MRsMH1QJHrDqxnePNMGG5nzvmeZuVxQ95aIpBSmLn1Of5XsOPDRwSXA
 TbJqvtVVNlM+wwiiP9WyMNJaV0BxTNAxtccfaMo3a/x5nRqT7ZXQ==
X-Received: by 2002:a05:600c:c4a1:b0:477:df7:b020 with SMTP id
 5b1f17b1804b1-47ee3391770mr48660105e9.18.1768429516842; 
 Wed, 14 Jan 2026 14:25:16 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:16 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 David Hunt <david.hunt@intel.com>
Subject: [PATCH 08/29] examples/distributor: correct documentation errors
Date: Wed, 14 Jan 2026 14:21:49 -0800
Message-ID: <20260114222458.87119-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114222458.87119-1-stephen@networkplumber.org>
References: <20260114222458.87119-1-stephen@networkplumber.org>
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

Address issues in distributor sample documentation:
- Capitalize "linux" to "Linux"
- Add missing space before function name in thread description
- Add missing article: "is done in same way" to
  "is done in the same way"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/dist_app.rst | 30 +++++++++++++--------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/doc/guides/sample_app_ug/dist_app.rst b/doc/guides/sample_app_ug/dist_app.rst
index 30b4184d40..f4a2de50d6 100644
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
 
@@ -49,7 +49,7 @@ Running the Application
    *   -p PORTMASK: Hexadecimal bitmask of ports to configure
    *   -c: Combines the RX core with distribution core
 
-#. To run the application in linux environment with 10 lcores, 4 ports,
+#. To run the application in a Linux environment with 10 lcores, 4 ports,
    issue the command:
 
    ..  code-block:: console
@@ -64,9 +64,9 @@ Explanation
 
 The distributor application consists of four types of threads: a receive
 thread (``lcore_rx()``), a distributor thread (``lcore_dist()``), a set of
-worker threads (``lcore_worker()``), and a transmit thread(``lcore_tx()``).
+worker threads (``lcore_worker()``), and a transmit thread (``lcore_tx()``).
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
@@ -143,11 +143,11 @@ Application. See :ref:`l2_fwd_app_cmd_arguments`.
 Mbuf pool initialization is done in the same way as it is done in the L2 Forwarding
 Sample Application. See :ref:`l2_fwd_app_mbuf_init`.
 
-Driver Initialization is done in same way as it is done in the L2 Forwarding Sample
+Driver Initialization is done in the same way as it is done in the L2 Forwarding Sample
 Application. See :ref:`l2_fwd_app_dvr_init`.
 
-RX queue initialization is done in the same way as it is done in the L2 Forwarding
+Rx queue initialization is done in the same way as it is done in the L2 Forwarding
 Sample Application. See :ref:`l2_fwd_app_rx_init`.
 
-TX queue initialization is done in the same way as it is done in the L2 Forwarding
+Tx queue initialization is done in the same way as it is done in the L2 Forwarding
 Sample Application. See :ref:`l2_fwd_app_tx_init`.
-- 
2.51.0

