Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B804FCCFA16
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 18:10:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D61ED40A72;
	Tue,  4 Nov 2025 19:09:42 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 21C0F40A6F
 for <dev@dpdk.org>; Tue,  4 Nov 2025 19:09:41 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2955805b7acso693335ad.1
 for <dev@dpdk.org>; Tue, 04 Nov 2025 10:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762279780;
 x=1762884580; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bzX2+4zwc/W4SYw5qrvZgh1SeceNBqkHGO3r7por6/E=;
 b=HfN2QoO31EyRfAaH14myM8v3sZSA/gouGfmjUplyZQgrxcaLnJ2rrawiVARH83pvJb
 r6iVu07WWokOyR+Jhv4LZvaJWzi3xoniS5kjG66YM0xg/mQ0p0u6mRqaRl53k2c9KlXl
 axnsZT0yhZPJPW6+7jPIRH265J8JvHPrd1AonrEgfwGmbRi+1WcToc6IKyXySMw4EHDJ
 bXq5Am1P6gutSYQBwdh/CS7d6PC4Ef+zMpD5Afd8x3yjHIx2sPVK2L8IPsvTnxXQZQnH
 /h7Lamq8o8jSy8gVBNT2apXH9R/qW4w6f5Yg1TNle9Q1EV9Oue3wHPpMZv+O2z3G8qTu
 1k9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762279780; x=1762884580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bzX2+4zwc/W4SYw5qrvZgh1SeceNBqkHGO3r7por6/E=;
 b=wwMAkSpyyIuIEF+234QGshltr9AlPon1M9fw8sLwEOmXr2TL9KOZSRCIcckv9fKgSo
 ZPhVkB/qWqtdpR/wy7x4Td4HQcrY6eQ1p0hVa9DLkpl87sWbD8HyZtmdpw00i/0jRcnX
 02+q2pWaj5NdIujuHx5QfzYpkVDjhGMW6AoEew9PkHdb+m45DQXDuB50nNdXD94mdgGW
 f4Y3Qm2DGeh7H5N/G6nYCGrTj5YiSzkvjozy8f8T1OjQDPqLZ/EEL6ut8/FcJerTeBDe
 HmYS6kRdELvygNDP3ZrR7wVXFD1hhGZ0M+22dTAlchQAUE54OdShUvp87gD/AabKd6Q6
 55oA==
X-Gm-Message-State: AOJu0YzCk0fRm73KU5hM1TvxERhCJXHk44pCy/SP26J7y5LDd1ttDyEr
 TJEFuVQRCGGP4AeUJHdVVRsK4cvUi9YfXuGhCiE55KxedTejr1w0vqOywQURqmHL7wkQz1we0DG
 of+uf
X-Gm-Gg: ASbGncvFm396xoFCrTx0dZHNWGwTUHEjaiAwSB0OryDhy7WSYqPVL+3vn5RFaNH0lX3
 WeZ/ZyykbDULy9YcWcbNu8dARODn71xNI/9PxvoVvZ394hxBFHo/2f9SybUZfucYFv3ZDTR6Pws
 wb8So6Dw2RGNugCufERaXEaY7YekRHXv5VqdJuYdRGC2p9JWI81pR2rSFTu8OMrsKVbCKH3eHZC
 FiweIe1gXG9Wuxrpp6JE2VNTzv+0j87aGQrm1u49zpJYb/Cz9vx6XIHSvddqeacY/frNKoiWZ+b
 b6v8jelamDxYx//0AQJYr0+UzvNPpO386iW1g5he9Nsn3VLC9gHpl0Z5bn0L+w9vCUP6GmR/Jik
 tv56PW8Fv/+N14KgqHl0tQU7y1kAymml7Dpn1r0HzTvyOuoxKfrQSS7w2/RqS0TMGi6d4FNerkx
 ZNJNl3mC33XyvnXYbqxrG+F/FxJ9J92Jfq1ywlHLU=
X-Google-Smtp-Source: AGHT+IFs7JnwCZF3NlkjAe5AZMOsJEqpWtZWi4do689DUW1CWT4x6RCJVCXfNTgLWCAIqTz1hys/pg==
X-Received: by 2002:a17:903:2c04:b0:295:50f5:c0e3 with SMTP id
 d9443c01a7336-2962ada2f5emr7023675ad.14.1762279780173; 
 Tue, 04 Nov 2025 10:09:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ba1f86b0688sm3035988a12.28.2025.11.04.10.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 10:09:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v6 8/8] doc: update documentation on pdump library
Date: Tue,  4 Nov 2025 10:07:12 -0800
Message-ID: <20251104180927.403355-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104180927.403355-1-stephen@networkplumber.org>
References: <20250811213632.16023-1-stephen@networkplumber.org>
 <20251104180927.403355-1-stephen@networkplumber.org>
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

