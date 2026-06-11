Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D91CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 21:21:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFC6F433C4;
	Thu, 11 Jun 2026 23:21:28 +0200 (CEST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id 5FDF6433B2
 for <dev@dpdk.org>; Thu, 11 Jun 2026 23:21:26 +0200 (CEST)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-1363fe80fe8so425926c88.0
 for <dev@dpdk.org>; Thu, 11 Jun 2026 14:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781212885;
 x=1781817685; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UI9+j4VZk14/sNY8YQ3DlhEBwo/j7VQOaTVDDD5Tf2c=;
 b=rklQ9AuAHOl29ldAZgXoILFPs4QICEp0kNJyYH4yy+fHxqGtmAuoWxs3vNkXBv2zm0
 Y/wbtwDb0E+UhxtwfCOl9f23cyVuCKgQgKT+dSPv85kZqQaQU0XfRO0XzUijEKvym33K
 sYu/GMDpLXdQQLmo5SkAiGKV0wJYPuPjTdcowb6NXHfWLamAUicOp7IHME4oOfruY1nW
 ubRMwapT0EUJ08aml7AaE3bIn2YrvzNEMg4ujxDquG1U/vtM6OGfjPaMMHW8OeValJma
 59IOTbw2IOG8RFHfp48NO0m0peWV5/qOH76/obpym+eDyrvIHi3gFy+EIJv+EO+SFT5v
 Ha1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212885; x=1781817685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UI9+j4VZk14/sNY8YQ3DlhEBwo/j7VQOaTVDDD5Tf2c=;
 b=Ox5ynBsYJMzQuDSi09H1j0moFugu7uoUsfv/SZQdWYtkk1Z2foI8kZRnQbBJTYB031
 8dwBhsBRSwrV/zv2te8P/o0UvVAyM4XTaezHPEZ/L8r5+DiDYHutTTAYL8GN/yhPnR3b
 ulLkVcU+372n8UJEv23zaHvo7RYgCUPhBWnx1ZMllw0fz7+iyhOholOveBjmZa3PYwH2
 mmopZVvxBoumZ31tX7n8nh1DrSFt2Eh+2k3owJey6PZJdEOuckxxZupniMpbs1SVcZJG
 g8LXajRcBbP/rC2RLkvdtMI9RHYLN4e2PxoySagrRR29TD//8Gz1zdA0ioB+3OroO0pq
 kiZA==
X-Gm-Message-State: AOJu0YxNBMOpDCdtJ/aykxMNpclDI8dGir8C8gHwg+ZWeUijRPPMbv35
 +1Gx0isKfFD1/z+1kVk+bfYxOFxJ3ckvtfwL0krKKcZBkH6pohYVaVKXtBr4DTzo86HArUIzoTa
 1DmCO
X-Gm-Gg: Acq92OG5AF/sz25szDE5Qy/xVvdGNLWHIDNle6b/UI78GJf5EVBJHbY/vBIWspVfBNJ
 /ma9CQY2z3AkskxlwXHZ8VztilJEk6pHSNpAeKGGkUZVtOmc5dJaigDeRXJsjDpZksygoEV2Gn7
 fIl+rHt5JI+Auk+caSyjKFLyJNUE9sekxFvnxNrb+qu78kK3xNyawqkROi/3LgCuH8rlvoNKgl9
 vGNWXJoqBEN+BpzKUipZ1HyqKL3epQo2bqWXRoPUTUnIznsOSDBJ+t4okfQ2sGpOwKgMBpf5u7h
 4KSIXqHi9kh2KMF5BQOe4e0DKgoRpO1t3966km2dyAjMjZ1QjJmJVA22K8EHfC5jT/ASKLt5izP
 Z5V4q2jEyCBKdaFE8YdRAfG4L4DkIBLqS/+J/EItbQduPdaGmRNym45IKaAvShQIjRoNov7kVFT
 QPruekkQTo6X9J/qKctvP6RXm7THV1tPlBT8ZRx7rbJLwT+THKO/xNiPFZNmtLoA==
X-Received: by 2002:a05:693c:2c15:b0:304:bf07:f19e with SMTP id
 5a478bee46e88-30820096fb4mr18280eec.28.1781212885225; 
 Thu, 11 Jun 2026 14:21:25 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb95450sm546238eec.28.2026.06.11.14.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 14:21:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>
Subject: [PATCH 03/15] doc: cleanup the distribution sample application guide
Date: Thu, 11 Jun 2026 14:18:42 -0700
Message-ID: <20260611212119.1026721-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611212119.1026721-1-stephen@networkplumber.org>
References: <20250216230903.124496-1-nandinipersad361@gmail.com>
 <20260611212119.1026721-1-stephen@networkplumber.org>
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

Fix punctuation, clarity, and removing repetition when necessary.

Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/dist_app.rst | 52 +++++++++++++--------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/doc/guides/sample_app_ug/dist_app.rst b/doc/guides/sample_app_ug/dist_app.rst
index 30b4184d40..11496471ae 100644
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
@@ -64,19 +64,19 @@ Explanation
 
 The distributor application consists of four types of threads: a receive
 thread (``lcore_rx()``), a distributor thread (``lcore_dist()``), a set of
-worker threads (``lcore_worker()``), and a transmit thread(``lcore_tx()``).
+worker threads (``lcore_worker()``), and a transmit thread (``lcore_tx()``).
 How these threads work together is shown in :numref:`figure_dist_app` below.
-The ``main()`` function launches  threads of these four types.  Each thread
-has a while loop which will be doing processing and which is terminated
+The ``main()`` function launches threads of these four types. Each thread
+has a while loop that performs processing and is terminated
 only upon SIGINT or ctrl+C.
 
 The receive thread receives the packets using ``rte_eth_rx_burst()`` and will
-enqueue them to an rte_ring. The distributor thread will dequeue the packets
-from the ring and assign them to workers (using ``rte_distributor_process()`` API).
-This assignment is based on the tag (or flow ID) of the packet - indicated by
-the hash field in the mbuf. For IP traffic, this field is automatically filled
-by the NIC with the "usr" hash value for the packet, which works as a per-flow
-tag.  The distributor thread communicates with the worker threads using a
+enqueue them to an rte_ring. The distributor thread dequeues the packets
+from the ring and assigns them to workers using the ``rte_distributor_process()``
+API. This assignment is based on the tag (or flow ID) of the packet, indicated
+by the hash field in the mbuf. For IP traffic, this field is automatically
+filled by the NIC with the "user" hash value for the packet, which works as a
+per-flow tag. The distributor thread communicates with the worker threads using a
 cache-line swapping mechanism, passing up to 8 mbuf pointers at a time
 (one cache line) to each worker.
 
@@ -86,11 +86,11 @@ the distributor, doing a simple XOR operation on the input port mbuf field
 (to indicate the output port which will be used later for packet transmission)
 and then finally returning the packets back to the distributor thread.
 
-The distributor thread will then call the distributor api
-``rte_distributor_returned_pkts()`` to get the processed packets, and will enqueue
-them to another rte_ring for transfer to the TX thread for transmission on the
-output port. The transmit thread will dequeue the packets from the ring and
-transmit them on the output port specified in packet mbuf.
+The distributor thread will then call the distributor API
+``rte_distributor_returned_pkts()`` to get the processed packets and enqueue
+them to another rte_ring for transfer to the TX thread. The transmit thread
+dequeues the packets from the ring and transmits them on the output port
+specified in the packet mbuf.
 
 Users who wish to terminate the running of the application have to press ctrl+C
 (or send SIGINT to the app). Upon this signal, a signal handler provided
@@ -105,29 +105,29 @@ final statistics to the user.
 
 
 Intel SST-BF Support
---------------------
+~~~~~~~~~~~~~~~~~~~~
 
 In DPDK 19.05, support was added to the power management library for
-Intel-SST-BF, a technology that allows some cores to run at a higher
+Intel SST-BF, a technology that allows some cores to run at a higher
 frequency than others. An application note for Intel SST-BF is available,
 and is entitled
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
-- 
2.53.0

