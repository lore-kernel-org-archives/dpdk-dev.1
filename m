Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7896CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 21:55:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 795994068A;
	Fri, 24 Oct 2025 23:55:12 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id 6704340652
 for <dev@dpdk.org>; Fri, 24 Oct 2025 23:55:07 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-77f67ba775aso3230724b3a.3
 for <dev@dpdk.org>; Fri, 24 Oct 2025 14:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761342906;
 x=1761947706; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bzX2+4zwc/W4SYw5qrvZgh1SeceNBqkHGO3r7por6/E=;
 b=Gtj6mQxn0+7uB3G9G9O+wE60R+XjNrjEytUFlSiPU+BgwJPrzD5+UcpvQ+NVze2iOT
 YS3cLN6x4IAtzDKMMxuhyp9ogIuGXrCXT4WAZiOz0CyCO/SoD1VIbcSpppCPIhaeApMe
 BLyrvV20FYDhbTRyjOOQq6KisyDkT0fQVEW6YdN392w7b3bUx5pKG24dIyJeUdI0dGfN
 1vE3kzevVxjFQiq++5EOg1tW+g5SU/aJfGf4cqvpWfTo2QyoI0ISgXXjPXiHdkkLiUZU
 NVeQBMv+SOXCa22kqlJZMVMfJ4bsOIRqWpsNTcgBHGIRpPRneLwsjdiW/yNoysIWZKke
 Rpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761342906; x=1761947706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bzX2+4zwc/W4SYw5qrvZgh1SeceNBqkHGO3r7por6/E=;
 b=nwlTtKekNI6uMmZ0DaVyvXu/PluZy5z+LDMUEz4CONZzaR0WVrU/KSbN+CtPanZruB
 ++8IQsp6LcuO6eb7OiALvUUYeMy5B+CHdOqaioz9dFUv66qPsb/5+JzBfun00+o+gvin
 kAlkUgF2kK/pBScE/n5T/F7X495TtQElb0F0Y9k70pTpyRQHQnXSm9IJVj1bMX/KVtme
 8T2CvdirYRtzfjGZhxOMCDrNhHdPBnPTAuFvlXgkFZbEzxrLFRXRKbQhRuGbgys3HEVY
 heke0Y6XrLie37iIwuWMHea5uYoWG1VwPZT/Lhi9/lmY7L4/Ro9aQ7EiSkY6d7XdR4n9
 LKYQ==
X-Gm-Message-State: AOJu0YwhZEQmobRoTLkdUQkgtZr38SqECiZuQ4gKGPPqI2OtNQqrMQcY
 7jRFeYNqQlZ9GZsPAlwoRy33Tg4jbyMuqd1auLo/TsXbBB4Anl+fnMh6JVXCYogulMUzqwOtZL0
 R1uAI
X-Gm-Gg: ASbGncveF4DRFgvIgaY/7RYn7gBSXGryxwqrz/mQmniGjB1UBSGQeYeknoTmwUXxARa
 QLQ5/vqf7/DqCoQazFXuM/Z8dKbpioNQ/rw93PBmEtuY8f8RACWD4/BxHOEmuZbZ5H8OwkhIePW
 J0Oar2w7r+EjfgcairUQm3EBhiER+rVd/TvlKgJfrw1x9cDMIRVFAa02z+ZeHac0dYdZ3YKQ0FR
 jFi6pLsZbp8eLLXiPrAf/7CFjw3c+s2Zj6eQTbWpwmCVn08NuMnCLODWIptMTtM0qrAo4E+pJ3c
 felmad1bIkBnMgnf6S6dAYHrjPVUWbyufXYBQ0k1kipLTVeeibktCTNVQuUDYjvAWxu7isJNhzM
 Biern//QeRwKDAimt3hDCj9rQ1ETE4J/qwsf0T4cbrlPa+VajZ2cD/8pi9NidKJ2IP/+zw1gBrT
 iD6LhL9Rjey89FCqcvx34nGawvWrz8RE9pkXnYJy0=
X-Google-Smtp-Source: AGHT+IEoJBTSzR7lfuw/p2DHB7lRfA/X7mSfjpWy/+D+CV9QW577IAnWzjmtW13UghDb/qL0rOwgGg==
X-Received: by 2002:a05:6a20:914b:b0:334:a462:d299 with SMTP id
 adf61e73a8af0-334a8528703mr43517431637.3.1761342906421; 
 Fri, 24 Oct 2025 14:55:06 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a414012de3sm252530b3a.2.2025.10.24.14.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 14:55:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v5 8/8] doc: update documentation on pdump library
Date: Fri, 24 Oct 2025 14:54:03 -0700
Message-ID: <20251024215456.282171-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024215456.282171-1-stephen@networkplumber.org>
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251024215456.282171-1-stephen@networkplumber.org>
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

The documentation was missing some of the API, and had some
awkward wording. With the help of ChatGPT, update it and make
it more concise.

Add a release note

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 doc/guides/prog_guide/img/pdump_overview.svg | 135 ++++++++++++++
 doc/guides/prog_guide/pdump_lib.rst          | 183 ++++++++++++-------
 doc/guides/rel_notes/release_25_11.rst       |   5 +
 3 files changed, 255 insertions(+), 68 deletions(-)
 create mode 100644 doc/guides/prog_guide/img/pdump_overview.svg

diff --git a/doc/guides/prog_guide/img/pdump_overview.svg b/doc/guides/prog_guide/img/pdump_overview.svg
new file mode 100644
index 0000000000..537de49669
--- /dev/null
+++ b/doc/guides/prog_guide/img/pdump_overview.svg
@@ -0,0 +1,135 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- SPDX-License-Identifier: BSD-3-Clause -->
+<!-- Copyright (c) 2025 Stephen Hemminger -->
+<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
+<!-- Created with ChatGPT  -->
+
+<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="1080" viewBox="0 0 1200 1080">
+  <defs>
+    <marker id="arrowBlue" markerWidth="12" markerHeight="8" refX="10" refY="4" orient="auto">
+      <polygon points="0,0 12,4 0,8" fill="#0066cc"/>
+    </marker>
+    <marker id="arrowThinBlue" markerWidth="10" markerHeight="6" refX="9" refY="3" orient="auto">
+      <polygon points="0,0 10,3 0,6" fill="#3399ff"/>
+    </marker>
+    <marker id="arrowRed" markerWidth="12" markerHeight="8" refX="10" refY="4" orient="auto">
+      <polygon points="0,0 12,4 0,8" fill="#cc0000"/>
+    </marker>
+    <marker id="arrowThinRed" markerWidth="10" markerHeight="6" refX="9" refY="3" orient="auto">
+      <polygon points="0,0 10,3 0,6" fill="#ff3333"/>
+    </marker>
+    <style>
+      .lane-title { font: 700 20px system-ui, sans-serif; fill: #234; }
+      .lifeline { stroke: #9db3cc; stroke-dasharray: 6 6; stroke-width: 2; }
+      .step { fill: #fff; stroke: #517fa4; stroke-width: 1.5; rx: 8; ry: 8; }
+      .step text, .note text { font: 13px ui-monospace, monospace; fill: #102030; }
+      .note { fill: #fff9e6; stroke: #d9b54a; stroke-width: 1.2; rx: 8; ry: 8; }
+      .msg-blue { stroke: #0066cc; stroke-width: 2.2; marker-end: url(#arrowBlue); fill: none; }
+      .msg-thin-blue { stroke: #3399ff; stroke-width: 2; marker-end: url(#arrowThinBlue); fill: none; }
+      .msg-red { stroke: #cc0000; stroke-width: 2.2; marker-end: url(#arrowRed); fill: none; }
+      .msg-thin-red { stroke: #ff3333; stroke-width: 2; marker-end: url(#arrowThinRed); fill: none; }
+      .label { font: 14px ui-monospace, monospace; fill: #0d2238; }
+      .small { font-size: 12px; fill: #334b63; }
+    </style>
+  </defs>
+
+  <!-- Lanes -->
+  <rect x="30" y="20" width="340" height="1040" fill="#e6f0ff" stroke="#8aa4c2" stroke-width="2" rx="20" ry="20"/>
+  <text class="lane-title" x="200" y="52" text-anchor="middle">Capture Process</text>
+  <rect x="430" y="20" width="340" height="1040" fill="#e8f8e8" stroke="#8aa4c2" stroke-width="2" rx="20" ry="20"/>
+  <text class="lane-title" x="600" y="52" text-anchor="middle">Primary Process</text>
+  <rect x="830" y="20" width="340" height="1040" fill="#f9f9f9" stroke="#8aa4c2" stroke-width="2" rx="20" ry="20"/>
+  <text class="lane-title" x="1000" y="52" text-anchor="middle">Secondary Processes</text>
+
+  <!-- Lifelines -->
+  <line class="lifeline" x1="200" y1="70" x2="200" y2="1040"/>
+  <line class="lifeline" x1="600" y1="70" x2="600" y2="1040"/>
+  <line class="lifeline" x1="1000" y1="70" x2="1000" y2="1040"/>
+
+  <!-- Startup -->
+  <g transform="translate(80,90)">
+    <rect class="step" x="0" y="0" width="240" height="40"/>
+    <text x="12" y="25" class="label">rte_eal_init()</text>
+    <rect class="step" x="0" y="52" width="240" height="40"/>
+    <text x="12" y="77" class="label">rte_pdump_init()</text>
+  </g>
+  <g transform="translate(480,90)">
+    <rect class="step" x="0" y="0" width="240" height="40"/>
+    <text x="12" y="25" class="label">rte_eal_init()</text>
+    <rect class="step" x="0" y="52" width="240" height="40"/>
+    <text x="12" y="77" class="label">rte_pdump_init()</text>
+  </g>
+  <g transform="translate(880,90)">
+    <rect class="step" x="0" y="0" width="240" height="40"/>
+    <text x="12" y="25" class="label">rte_eal_init()</text>
+    <rect class="step" x="0" y="52" width="240" height="40"/>
+    <text x="12" y="77" class="label">rte_pdump_init()</text>
+  </g>
+
+  <!-- Enable sequence (Blue) -->
+  <line class="msg-blue" x1="200" y1="220" x2="600" y2="220"/>
+  <text class="label" x="400" y="212" text-anchor="middle">rte_pdump_enable()</text>
+  <rect class="note" x="260" y="230" width="280" height="36"/>
+  <text x="274" y="253" class="small">uses rte_mp_request() to message primary</text>
+
+  <g transform="translate(480,280)">
+    <rect class="step" x="0" y="0" width="240" height="96"/>
+    <text x="12" y="24" class="label">pdump_server()</text>
+    <text x="20" y="46" class="small">• enable RX/TX callbacks</text>
+    <text x="20" y="64" class="small">• send ACK to capture</text>
+    <text x="20" y="82" class="small">• forward request to all secondaries</text>
+  </g>
+  <line class="msg-thin-blue" x1="600" y1="330" x2="200" y2="330"/>
+  <text class="label" x="400" y="322" text-anchor="middle">ACK</text>
+  <line class="msg-blue" x1="600" y1="380" x2="1000" y2="380"/>
+  <text class="label" x="800" y="372" text-anchor="middle">forward enable request</text>
+
+  <g transform="translate(880,420)">
+    <rect class="step" x="0" y="0" width="240" height="78"/>
+    <text x="12" y="22" class="label">pdump_server()</text>
+    <text x="20" y="42" class="small">• register RX/TX callbacks</text>
+    <text x="20" y="60" class="small">• send response</text>
+  </g>
+  <line class="msg-thin-blue" x1="1000" y1="520" x2="600" y2="520"/>
+  <text class="label" x="800" y="512" text-anchor="middle">response</text>
+
+  <g transform="translate(480,560)">
+    <rect class="step" x="0" y="0" width="240" height="56"/>
+    <text x="12" y="24" class="label">collect responses</text>
+    <text x="12" y="44" class="small">from secondary processes</text>
+  </g>
+
+  <!-- Packet capture running -->
+  <g transform="translate(480,640)">
+    <rect class="step" x="-300" y="0" width="840" height="50"/>
+    <text x="120" y="30" class="label" text-anchor="middle">Packet capture in progress...</text>
+  </g>
+
+  <!-- Shutdown sequence (Red) -->
+  <line class="msg-red" x1="200" y1="720" x2="600" y2="720"/>
+  <text class="label" x="400" y="712" text-anchor="middle">rte_pdump_disable()</text>
+
+  <g transform="translate(480,760)">
+    <rect class="step" x="0" y="0" width="240" height="80"/>
+    <text x="12" y="24" class="label">pdump_server()</text>
+    <text x="20" y="46" class="small">• remove RX/TX callbacks</text>
+    <text x="20" y="64" class="small">• forward disable to secondaries</text>
+  </g>
+
+  <line class="msg-red" x1="600" y1="820" x2="1000" y2="820"/>
+  <text class="label" x="800" y="812" text-anchor="middle">forward disable request</text>
+
+  <g transform="translate(880,860)">
+    <rect class="step" x="0" y="0" width="240" height="60"/>
+    <text x="12" y="24" class="label">pdump_server()</text>
+    <text x="20" y="46" class="small">• remove RX/TX callbacks</text>
+  </g>
+
+  <line class="msg-thin-red" x1="1000" y1="940" x2="600" y2="940"/>
+  <text class="label" x="800" y="932" text-anchor="middle">response</text>
+
+  <g transform="translate(480,980)">
+    <rect class="step" x="0" y="0" width="240" height="40"/>
+    <text x="12" y="25" class="label">collect disable responses</text>
+  </g>
+</svg>
diff --git a/doc/guides/prog_guide/pdump_lib.rst b/doc/guides/prog_guide/pdump_lib.rst
index 07b9f39d09..5183756d9e 100644
--- a/doc/guides/prog_guide/pdump_lib.rst
+++ b/doc/guides/prog_guide/pdump_lib.rst
@@ -4,90 +4,137 @@
 Packet Capture Library
 ======================
 
-The DPDK ``pdump`` library provides a framework for packet capturing in DPDK.
-The library does the complete copy of the Rx and Tx mbufs to a new mempool and
-hence it slows down the performance of the applications, so it is recommended
-to use this library for debugging purposes.
+The DPDK ``pdump`` library provides a framework for capturing packets within DPDK applications.
+It enables a **secondary process** to monitor packets being processed by both
+**primary** or **secondary** processes.
 
-The library uses a generic multi process channel to facilitate communication
-between primary and secondary process for enabling/disabling packet capture on
-ports.
+Overview
+--------
 
-The library provides the following APIs to initialize the packet capture framework, to enable
-or disable the packet capture, and to uninitialize it.
+The library uses a  multi-process channel to facilitate communication
+between the primary and secondary processes. This mechanism allows enabling
+or disabling packet capture on specific ports or queues.
 
-* ``rte_pdump_init()``:
-  This API initializes the packet capture framework.
+.. _figure_pdump_overview:
 
-* ``rte_pdump_enable()``:
-  This API enables the packet capture on a given port and queue.
+.. figure:: img/pdump_overview.*
 
-* ``rte_pdump_enable_bpf()``
-  This API enables the packet capture on a given port and queue.
-  It also allows setting an optional filter using DPDK BPF interpreter
-  and setting the captured packet length.
+   Packet Capture enable and disable sequence
 
-* ``rte_pdump_enable_by_deviceid()``:
-  This API enables the packet capture on a given device id (``vdev name or pci address``) and queue.
+API Reference
+-------------
 
-* ``rte_pdump_enable_bpf_by_deviceid()``
-  This API enables the packet capture on a given device id (``vdev name or pci address``) and queue.
-  It also allows setting an optional filter using DPDK BPF interpreter
-  and setting the captured packet length.
+The library exposes APIs for:
 
-* ``rte_pdump_disable()``:
-  This API disables the packet capture on a given port and queue.
+* Initializing and uninitializing the packet capture framework.
+* Enabling and disabling packet capture.
+* Applying optional filters and limiting captured packet length.
 
-* ``rte_pdump_disable_by_deviceid()``:
-  This API disables the packet capture on a given device id (``vdev name or pci address``) and queue.
 
-* ``rte_pdump_uninit()``:
-  This API uninitializes the packet capture framework.
+.. function:: int rte_pdump_init(void)
 
+   Initialize the packet capture framework.
+
+.. function:: int rte_pdump_enable(uint16_t port_id, uint16_t queue, uint32_t flags)
+
+   Enable packet capture on the specified port and queue.
+
+.. function:: int rte_pdump_enable_bpf(uint16_t port_id, uint16_t queue, const struct rte_bpf_program *bpf, uint32_t snaplen)
+
+   Enable packet capture on the specified port and queue with an optional
+   BPF packet filter and a limit on the captured packet length.
+
+.. function:: int rte_pdump_enable_by_deviceid(const char *device_id, uint16_t queue, uint32_t flags)
+
+   Enable packet capture on the specified device ID (``vdev`` name or PCI address)
+   and queue.
+
+.. function:: int rte_pdump_enable_bpf_by_deviceid(const char *device_id, uint16_t queue, const struct rte_bpf_program *bpf, uint32_t snaplen)
+
+   Enable packet capture on the specified device ID (``vdev`` name or PCI address)
+   and queue, with optional filtering and captured packet length limit.
+
+.. function:: int rte_pdump_disable(uint16_t port_id, uint16_t queue)
+
+   Disable packet capture on the specified port and queue.
+   This applies to the current process and all other processes.
+
+.. function:: int rte_pdump_disable_by_deviceid(const char *device_id, uint16_t queue)
+
+   Disable packet capture on the specified device ID (``vdev`` name or PCI address)
+   and queue.
+
+.. function:: int rte_pdump_uninit(void)
+
+   Uninitialize the packet capture framework for this process.
+
+.. function:: int rte_pdump_stats(uint16_t port_id, struct rte_dump_stats *stats)
+
+   Reports the number of packets captured, filtered, and missed.
+   Packets maybe missed due to mbuf pool being exhausted or the ring being full.
 
 Operation
 ---------
 
-The primary process using ``librte_pdump`` is responsible for initializing the packet
-capture framework. The packet capture framework, as part of its initialization, creates the
-multi process channel to facilitate communication with secondary process, so the
-secondary process ``app/pdump`` tool is responsible for enabling and disabling the packet capture on ports.
+All processes using ``librte_pdump`` must initialize the packet capture framework
+before use. This initialization is required in both the primary and secondary processes.
+
+DPDK provides the following utilities that use this library:
+
+* ``app/dpdk-dumpcap``
+* ``app/pdump``
 
 Implementation Details
 ----------------------
 
-The library API ``rte_pdump_init()``, initializes the packet capture framework by creating the multi process
-channel using ``rte_mp_action_register()`` API. The primary process will listen to secondary process requests
-to enable or disable the packet capture over the multi process channel.
-
-The library APIs ``rte_pdump_enable()`` and ``rte_pdump_enable_by_deviceid()`` enables the packet capture.
-For the calls to these APIs from secondary process, the library creates the "pdump enable" request and sends
-the request to the primary process over the multi process channel. The primary process takes this request
-and enables the packet capture by registering the Ethernet RX and TX callbacks for the given port or device_id
-and queue combinations. Then the primary process will mirror the packets to the new mempool and enqueue them to
-the rte_ring that secondary process have passed to these APIs.
-
-The packet ring supports one of two formats.
-The default format enqueues copies of the original packets into the rte_ring.
-If the ``RTE_PDUMP_FLAG_PCAPNG`` is set, the mbuf data is extended
-with header and trailer to match the format of Pcapng enhanced packet block.
-The enhanced packet block has meta-data such as the timestamp, port and queue
-the packet was captured on.
-It is up to the application consuming the packets from the ring
-to select the format desired.
-
-The library APIs ``rte_pdump_disable()`` and ``rte_pdump_disable_by_deviceid()`` disables the packet capture.
-For the calls to these APIs from secondary process, the library creates the "pdump disable" request and sends
-the request to the primary process over the multi process channel. The primary process takes this request and
-disables the packet capture by removing the Ethernet RX and TX callbacks for the given port or device_id and
-queue combinations.
-
-The library API ``rte_pdump_uninit()``, uninitializes the packet capture framework by calling ``rte_mp_action_unregister()``
-function.
-
-
-Use Case: Packet Capturing
---------------------------
-
-The DPDK ``app/dpdk-dumpcap`` utility uses this library
-to capture packets in DPDK.
+``rte_pdump_init()`` creates the multi-process channel by calling
+``rte_mp_action_register()``.
+
+The primary process listens for requests from secondary processes to
+enable or disable packet capture over the multi-process channel.
+
+When a secondary process calls ``rte_pdump_enable()`` or
+``rte_pdump_enable_by_deviceid()``, the library sends a "pdump enable" request
+to the primary process. The primary process then:
+
+1. Receives the request over the multi-process channel.
+2. Registers Ethernet Rx and Tx callbacks for the specified port.
+3. Forwards the request to other secondary processes (if any)
+
+
+FAQ
+---
+
+* What is the performance impact of pdump?
+
+Setting up pdump with ``rte_pdump_init`` has no impact,
+there are no changes in the fast path.
+When pdump is enabled, the Tx and Rx fast path functions
+callbacks make a copy of the mbufs and enqueue them. This will impact
+performance. The effect can be reduced by filtering to only
+see the packets of interest and using the snaplen parameter
+to only copy the needed headers.
+
+* What happens if process does not call pdump init?
+
+If application does not call ``rte_pdump_init`` then the request
+to enable (in the capture command) will timeout and an error is returned.
+
+* Where do packets go?
+
+Packets captured are placed in the ring passed in ``rte_pdump_enable``.
+The capture application must dequeue these mbuf's and free them.
+
+* Why is copy required?
+
+A copy is used instead of incrementing the reference count because
+on transmit the device maybe using fast free which does not use refcounts;
+and on receive the application may modify the incoming packet.
+
+* What about offloads?
+
+The offload flags of the original mbuf are copied to the ring.
+It is up to the capture application to handle flags like VLAN stripping
+as necessary. Packets are captured before passing to driver and hardware
+so the actual packet on the wire maybe segmented or encapsulated based
+on the offload flags.
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index c5ba335cfc..5dfdb5ff1e 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -167,6 +167,11 @@ New Features
   The built-in help text function is available as a public function which can be reused by custom functions,
   if so desired.
 
+* **Added packet capture (pdump) for secondary process.**
+
+  Added multi-process support to allow packets sent and received by secondary
+  process to be visible in packet capture.
+
 
 Removed Items
 -------------
-- 
2.51.0

