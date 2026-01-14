Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED58FD3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:26:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2164E410E4;
	Wed, 14 Jan 2026 23:25:27 +0100 (CET)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67]) by mails.dpdk.org (Postfix) with ESMTP id 0BE20410F6
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:26 +0100 (CET)
Received: by mail-wm1-f67.google.com with SMTP id
 5b1f17b1804b1-47ee937ecf2so2017025e9.0
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429526;
 x=1769034326; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xiDQClF9UcYFRRRt4bjjyiggGlmJ3pUWKnqWbHbMxBs=;
 b=IK6ResDJu13L3L79OIAaaIu09cmQC5t6cXQfg9wNlq622qj44hIkZvmejhRJmGS4N1
 mII1bmt22PwSUrBGO/5axI4eJPZOsSMcoaCqEL/nJldkWLyPPbMPdg6AmbGGU8tWvSmA
 YSCtu06rxxDcr3n1HEWnt9VQp/Hjg2qlCuuAk7XLjSiCagnfKlK1udQin5qU0FZ/1dcn
 zL+nX2rAXO6GBzB/YY17iqIqj3jOfAhRtqVCrStdbBCakGEGOPmZ2WKKo5D3EOmS/cNx
 aqx9F1l5D30Y/nSreBsgO1oH4J+hNDfqwxlBIDyStPDu9FEhgw6Bh+J511+qwng9JOTY
 psnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429526; x=1769034326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xiDQClF9UcYFRRRt4bjjyiggGlmJ3pUWKnqWbHbMxBs=;
 b=QQvgnvPsF7Ll4XLTCEeJtHsDcDAZ1nvUBxi0Pz4sR3eWLIFiPyF1YVXdXJD8LE0CJ/
 Jq49B2WSF7jgZ1yPVfG1tQ9ELHmqzDqEjpUw+p746RQUa6GmRdc7GpA6Ec4k/OGFNQ0D
 9G1cBY+heFr4FPnIE0ZYcBHw0A+GY5WTnhnJbTFlkWSUE1x3gYr81vAdplcz2ch4zziu
 zR1UdOTOk5ss1aLxRhMgCwaAM+Q2VsZ/SJtEdoMSQkDM5GbGLZQ/kR+9XcnhEGJ+tkKw
 IIrB3NzRPZYK2cpuciQFx5LO5Omd8Vf0ODAvNZGhaE4EghfUZlQX7klub2Ge4sePhlcv
 NNqA==
X-Gm-Message-State: AOJu0Yzvv2/IMfZ6ZYFyGc2AkCjRLWPUDvSFO31xfNk1tlX/CyXDfs1R
 D/WsZKjMbMWI0azhX7F1eG2COT1e2toE5iBoDMdntPA7XZOYUcmHurkax4QHFcyOwbFSiwMYChh
 j1+f/SNM=
X-Gm-Gg: AY/fxX7rBLTHYZ8e/v/GyMJS8tUEMLrtvY6lLH4cd7WSbKnVqTyAsE+q40H4ne4vTEM
 mRQ105AMacMVZj3/HYGPw4e5hxgjmFCYp6xwbWn9FeUEJIk2mKR6ocQd4CMRDGXXuisrInHUIoR
 94/9CQSvlOEcV+eHZvSjw9FZjQABSedJr2tmiVpG+Q4B97+NZsmeiLfju0Uz2kV6paGoo1eHsiz
 NkI8mFkLxd7WNStKZ7aTE0WCSxvx7oRVBXCFU9ygBmTuWMESUCdY+nRoZLcwcHPxsFaZBWi5yko
 X6scYWoOFOMp2k6GoWDZfFwbJ20vHMVOiJLqivcLgQpZXhrLqkc6eO04qzuZ6wtQ6uiP3T+6SC+
 U0xJ+im+7QhwR4UvwEnW8TRsfl+CZC3y5AZk75h4m33UIoMP5QrtIocw9gUNCAyJl2tPnnrmCDM
 +2zj0gQGZWs9gxYU8w9mEjNWRgPsLPHkztwohnXu2HOBE79VABcw==
X-Received: by 2002:a05:600c:3785:b0:47e:e0b3:2437 with SMTP id
 5b1f17b1804b1-47f428ae03cmr6487075e9.5.1768429525510; 
 Wed, 14 Jan 2026 14:25:25 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:25 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 13/29] examples/ptpclient: improve sample application
 documentation
Date: Wed, 14 Jan 2026 14:21:54 -0800
Message-ID: <20260114222458.87119-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114222458.87119-1-stephen@networkplumber.org>
References: <20260114222458.87119-1-stephen@networkplumber.org>
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

Rewrite the PTP client documentation for clarity and correctness.

Structural changes:
- Add Overview section with note about PTP purpose
- Add reference to IEEE 1588 standard
- Demote Limitations and How the Application Works to subsections
- Rename Code Explanation to Explanation for consistency

Technical corrections:
- Use standard PTP message names: Follow_Up, Delay_Req, Delay_Resp
- Document use of IEEE 1588g-2022 alternative terminology
  (time transmitter/receiver instead of master/slave)
- Clarify T1-T4 timestamp exchange sequence

Style improvements:
- Capitalize "Linux" consistently
- Use imperative mood for instructions
- Replace informal language ("we", "And than we") with formal style
- Add missing commas and articles

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/ptpclient.rst | 139 +++++++++++++------------
 1 file changed, 74 insertions(+), 65 deletions(-)

diff --git a/doc/guides/sample_app_ug/ptpclient.rst b/doc/guides/sample_app_ug/ptpclient.rst
index 0df465bcb4..1940f6e29f 100644
--- a/doc/guides/sample_app_ug/ptpclient.rst
+++ b/doc/guides/sample_app_ug/ptpclient.rst
@@ -4,31 +4,44 @@
 PTP Client Sample Application
 =============================
 
-The PTP (Precision Time Protocol) client sample application is a simple
-example of using the DPDK IEEE1588 API to communicate with a PTP time transmitter
-to synchronize the time on the NIC and, optionally, on the Linux system.
+Overview
+--------
 
-Note, PTP is a time syncing protocol and cannot be used within DPDK as a
-time-stamping mechanism. See the following for an explanation of the protocol:
+The PTP (Precision Time Protocol) client sample application demonstrates
+the DPDK IEEE1588 API for synchronizing time with a PTP time transmitter.
+The application synchronizes the NIC clock and optionally the Linux system clock.
+
+.. note::
+
+   PTP is a time synchronization protocol and cannot serve as a
+   timestamping mechanism within DPDK.
+
+For an explanation of the protocol, see
 `Precision Time Protocol
 <https://en.wikipedia.org/wiki/Precision_Time_Protocol>`_.
 
+This application uses the IEEE 1588g-2022 alternative terminology
+("time transmitter" and "time receiver" instead of "master" and "slave").
+For the official standard, see the
+`IEEE 1588 Standard
+<https://standards.ieee.org/ieee/1588/6825/>`_.
+
 
 Limitations
------------
+~~~~~~~~~~~
 
-The PTP sample application is intended as a simple reference implementation of
+The PTP sample application provides a simple reference implementation of
 a PTP client using the DPDK IEEE1588 API.
-In order to keep the application simple the following assumptions are made:
+To keep the application simple, it makes the following assumptions:
 
-* The first discovered time transmitter is the main for the session.
-* Only L2 PTP packets are supported.
-* Only the PTP v2 protocol is supported.
-* Only the time receiver clock is implemented.
+* The first discovered time transmitter becomes the session's primary transmitter.
+* The application supports only L2 PTP packets.
+* The application supports only PTP v2 protocol.
+* The application implements only the time receiver clock.
 
 
 How the Application Works
--------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
 .. _figure_ptpclient_highlevel:
 
@@ -38,62 +51,61 @@ How the Application Works
 
 The PTP synchronization in the sample application works as follows:
 
-* Time transmitter sends *Sync* message - the time receiver saves it as T2.
-* Time transmitter sends *Follow Up* message and sends time of T1.
-* Time receiver sends *Delay Request* frame to PTP time transmitter and stores T3.
-* Time transmitter sends *Delay Response* T4 time which is time of received T3.
+* The time transmitter sends a *Sync* message; the time receiver saves the arrival time as T2.
+* The time transmitter sends a *Follow_Up* message containing T1 (the *Sync* transmission time).
+* The time receiver sends a *Delay_Req* message to the time transmitter and records T3.
+* The time transmitter replies with a *Delay_Resp* message containing T4 (when it received the *Delay_Req*).
 
-The adjustment for time receiver can be represented as:
+The time receiver calculates the adjustment as:
 
    adj = -[(T2-T1)-(T4 - T3)]/2
 
-If the command line parameter ``-T 1`` is used the application also
-synchronizes the PTP PHC clock with the Linux kernel clock.
+If you specify the command line parameter ``-T 1``, the application also
+synchronizes the Linux kernel clock with the PTP PHC clock.
 
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
-The application is located in the ``ptpclient`` sub-directory.
+The application source resides in the ``ptpclient`` sub-directory.
 
 
 Running the Application
 -----------------------
 
-To run the example in a ``linux`` environment:
+To run the example in a Linux environment:
 
 .. code-block:: console
 
     ./<build_dir>/examples/dpdk-ptpclient -l 1 -- -p 0x1 -T 0
 
-Refer to *DPDK Getting Started Guide* for general information on running
+Refer to the *DPDK Getting Started Guide* for general information on running
 applications and the Environment Abstraction Layer (EAL) options.
 
 * ``-p portmask``: Hexadecimal portmask.
 * ``-T 0``: Update only the PTP time receiver clock.
-* ``-T 1``: Update the PTP time receiver clock and synchronize the Linux Kernel to the PTP clock.
+* ``-T 1``: Update the PTP time receiver clock and synchronize the Linux kernel clock to it.
 
 
-Code Explanation
-----------------
+Explanation
+-----------
 
-The following sections provide an explanation of the main components of the
-code.
+The following sections explain the main components of the code.
 
-All DPDK library functions used in the sample code are prefixed with ``rte_``
-and are explained in detail in the *DPDK API Documentation*.
+All DPDK library functions used in the sample code have the ``rte_`` prefix.
+The *DPDK API Documentation* explains these functions in detail.
 
 
 The Main Function
 ~~~~~~~~~~~~~~~~~
 
-The ``main()`` function performs the initialization and calls the execution
+The ``main()`` function initializes the application and launches execution
 threads for each lcore.
 
-The first task is to initialize the Environment Abstraction Layer (EAL).  The
-``argc`` and ``argv`` arguments are provided to the ``rte_eal_init()``
-function. The value returned is the number of parsed arguments:
+The first task initializes the Environment Abstraction Layer (EAL). The
+``rte_eal_init()`` function receives the ``argc`` and ``argv`` arguments
+and returns the number of parsed arguments:
 
 .. literalinclude:: ../../../examples/ptpclient/ptpclient.c
     :language: c
@@ -101,7 +113,7 @@ function. The value returned is the number of parsed arguments:
     :end-before: >8 End of initialization of EAL.
     :dedent: 1
 
-And than we parse application specific arguments
+Next, the application parses application-specific arguments:
 
 .. literalinclude:: ../../../examples/ptpclient/ptpclient.c
     :language: c
@@ -109,8 +121,8 @@ And than we parse application specific arguments
     :end-before: >8 End of parsing specific arguments.
     :dedent: 1
 
-The ``main()`` also allocates a mempool to hold the mbufs (Message Buffers)
-used by the application:
+The ``main()`` function also allocates a mempool to hold the mbufs (Message Buffers)
+that the application uses:
 
 .. literalinclude:: ../../../examples/ptpclient/ptpclient.c
     :language: c
@@ -118,11 +130,11 @@ used by the application:
     :end-before:  >8 End of a new mempool in memory to hold the mbufs.
     :dedent: 1
 
-Mbufs are the packet buffer structure used by DPDK. They are explained in
-detail in the "Mbuf Library" section of the *DPDK Programmer's Guide*.
+Mbufs provide the packet buffer structure that DPDK uses. The "Mbuf Library"
+section of the *DPDK Programmer's Guide* explains them in detail.
 
-The ``main()`` function also initializes all the ports using the user defined
-``port_init()`` function with portmask provided by user:
+The ``main()`` function also initializes all ports using the user-defined
+``port_init()`` function with the user-provided portmask:
 
 .. literalinclude:: ../../../examples/ptpclient/ptpclient.c
     :language: c
@@ -131,24 +143,23 @@ The ``main()`` function also initializes all the ports using the user defined
     :dedent: 1
 
 
-Once the initialization is complete, the application is ready to launch a
-function on an lcore. In this example ``lcore_main()`` is called on a single
-lcore.
+After initialization completes, the application launches a function on an lcore.
+In this example, ``main()`` calls ``lcore_main()`` on a single lcore.
 
 .. code-block:: c
 
 	lcore_main();
 
-The ``lcore_main()`` function is explained below.
+The next section explains the ``lcore_main()`` function.
 
 
 The Lcores Main
 ~~~~~~~~~~~~~~~
 
-As we saw above the ``main()`` function calls an application function on the
+As shown above, the ``main()`` function calls an application function on the
 available lcores.
 
-The main work of the application is done within the loop:
+The application performs its main work within the loop:
 
 .. literalinclude:: ../../../examples/ptpclient/ptpclient.c
     :language: c
@@ -156,11 +167,11 @@ The main work of the application is done within the loop:
     :end-before: >8 End of read packets from RX queues.
     :dedent: 2
 
-Packets are received one by one on the RX ports and, if required, PTP response
-packets are transmitted on the TX ports.
+The loop receives packets one by one on the RX ports and, when required,
+transmits PTP response packets on the TX ports.
 
-If the offload flags in the mbuf indicate that the packet is a PTP packet then
-the packet is parsed to determine which type:
+If the mbuf offload flags indicate a PTP packet, the code parses the packet
+to determine its type:
 
 .. literalinclude:: ../../../examples/ptpclient/ptpclient.c
     :language: c
@@ -169,30 +180,28 @@ the packet is parsed to determine which type:
     :dedent: 3
 
 
-All packets are freed explicitly using ``rte_pktmbuf_free()``.
+The code frees all packets explicitly using ``rte_pktmbuf_free()``.
 
-The forwarding loop can be interrupted and the application closed using
-``Ctrl-C``.
+Press ``Ctrl-C`` to interrupt the forwarding loop and close the application.
 
 
 PTP parsing
 ~~~~~~~~~~~
 
-The ``parse_ptp_frames()`` function processes PTP packets, implementing time receiver
-PTP IEEE1588 L2 functionality.
+The ``parse_ptp_frames()`` function processes PTP packets, implementing the
+PTP IEEE1588 L2 time receiver functionality.
 
 .. literalinclude:: ../../../examples/ptpclient/ptpclient.c
     :language: c
     :start-after: Parse ptp frames. 8<
     :end-before:  >8 End of function processes PTP packets.
 
-There are 3 types of packets on the RX path which we must parse to create a minimal
-implementation of the PTP time receiver client:
+A minimal PTP time receiver client must parse three packet types on the RX path:
 
-* SYNC packet.
-* FOLLOW UP packet
-* DELAY RESPONSE packet.
+* *Sync* packet
+* *Follow_Up* packet
+* *Delay_Resp* packet
 
-When we parse the *FOLLOW UP* packet we also create and send a *DELAY_REQUEST* packet.
-Also when we parse the *DELAY RESPONSE* packet, and all conditions are met
-we adjust the PTP time receiver clock.
+When the code parses the *Follow_Up* packet, it also creates and sends a
+*Delay_Req* packet. When it parses the *Delay_Resp* packet and all
+conditions are met, it adjusts the PTP time receiver clock.
-- 
2.51.0

