Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D192C87FDA
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 17:00:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C5DE40B8C;
	Fri,  8 Aug 2025 18:59:19 +0200 (CEST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 021FB40BA0
 for <dev@dpdk.org>; Fri,  8 Aug 2025 18:59:17 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3b79bddd604so1352897f8f.0
 for <dev@dpdk.org>; Fri, 08 Aug 2025 09:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754672356;
 x=1755277156; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ep/qsXzNqDl3sFktIpWYBVBIlVf4IsIslGwuy1BwA5w=;
 b=HItU6WJtOWYwcgPp0NFZPrBpSQnnHC4pA9JN64jHH9jfnFm5C6KHZBcM4fiMOe/sqe
 77wzKZzFuV30OKy0v+RxDQ3nBOSPjltFE0M4IYVT2tCbPelV888XJIG4z5gZ7cM5z3Is
 KlraMiihOGWdfjsNRPY4pAgmpWaQ42rBMsoKP/PndRYHIfU2dapy15kNz7Ivr0hsQkZc
 posnkL55TkGAsDICMb3XVcqgn3dgL4I5Sel1CHCaKBg0i7PbPH74ZcTXR1Eoejpns7w/
 h2Pe9T77twWf++KfiiIYOFf2wNm9A/0bX8ngMXybSnx/FMcxtcFa+XF+Gh+BnGXzod2B
 LkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754672356; x=1755277156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ep/qsXzNqDl3sFktIpWYBVBIlVf4IsIslGwuy1BwA5w=;
 b=O9N4CFNsM4KnXpwH2Nwb6W1+DYn1atleiCP350P4+9Oa83G4KaJiLJVJedeSYvrEyi
 obudgtL76alAha2KzyEqqBtJB/BZllBguwzgnTOmjbWprSWaOJKTwZndOQgUGD4JduD2
 7q+rFmk33mxen94S77thxxvv0EDdezOC5gaBhsQTxcXRmlrSTry3Pe/ioqsQwquFJ7F2
 NcyTr/1IvZlAFwsh/XI0SBOZd66zVzi3V64qKVewM+SmPs4uy/Uk/clIFJoCcLDOmwUU
 ksg9xtf3oFuRIxL7C12Qqu1GUSSwA1UQdz8YfaUiC1001ZHSC7KBo4UD3vLiDcigJCtG
 rZEA==
X-Gm-Message-State: AOJu0Yxv3yvdVncva7oOhlcxIPbvlai3+p7hg6CaVqV7pptN1e4IFxEJ
 0+3Hl9VJept/wWAlJEatXJ/jMmBdDgBr9r6KlA0UsBZRHsL66zhYM0t9z4G+gFPpMHCrGMgHUEb
 lpJq5
X-Gm-Gg: ASbGncv3z+4lntgW+0JJi4PUiI6rgcsllujw0Uc09Adv2n4NobeftePFdtID/ctgRQW
 MuL0aPUWgvRjXqXyIlhZjSzvIGCoG9BtVHYwWiZiWpCvfaKauOEvKex0vlNEZmIJMxzCh/AIajd
 b6ybRx+b/6+XNpUgDo6Heqd1TEFlANZxUhth6Tp9Y3+LETOmZe4eicnNsFTKfhIRDKkb1IraWdY
 YPUDKOYtYuXY67WrpiH84DlccqSP4gGotWYG4S6sdVvZ+kLKKxryJvCYOHGgxImmPO6/cgIqAfN
 f2oT9ykoRRSMzOPiqoICDM7VoEqDVNAqmHFJuC3i35pTytaFQZKfYw4rR+1w/L5NBriF5vkpSnL
 4RgUDi3EQ9zqeefzlA6H1MhCjhhE5/hNrewyTYUc7sdIPQndaO4df+1OkEM55A0fkNfklKvQg
X-Google-Smtp-Source: AGHT+IFeR2KHrvvQz2cF5aORNglXX79Fc8AShxHmCDXQZvH6WcyVMDKJa002gTnrt/ep+S3I+V4Otw==
X-Received: by 2002:a5d:5f56:0:b0:3b7:8473:30a5 with SMTP id
 ffacd0b85a97d-3b90093f86fmr3152417f8f.8.1754672356546; 
 Fri, 08 Aug 2025 09:59:16 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac115sm30997531f8f.12.2025.08.08.09.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 09:59:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v11 14/14] doc: add documentation for port mirroring
Date: Fri,  8 Aug 2025 09:55:52 -0700
Message-ID: <20250808165843.39075-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808165843.39075-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250808165843.39075-1-stephen@networkplumber.org>
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

Add ethdev port mirror to documentation.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/bpf_lib.rst            |  2 +
 doc/guides/prog_guide/ethdev/index.rst       |  1 +
 doc/guides/prog_guide/ethdev/port_mirror.rst | 68 ++++++++++++++++++++
 doc/guides/rel_notes/deprecation.rst         |  5 ++
 doc/guides/rel_notes/release_25_11.rst       |  5 ++
 5 files changed, 81 insertions(+)
 create mode 100644 doc/guides/prog_guide/ethdev/port_mirror.rst

diff --git a/doc/guides/prog_guide/bpf_lib.rst b/doc/guides/prog_guide/bpf_lib.rst
index 8c820328b9..038da03360 100644
--- a/doc/guides/prog_guide/bpf_lib.rst
+++ b/doc/guides/prog_guide/bpf_lib.rst
@@ -1,6 +1,8 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2018 Intel Corporation.
 
+.. _bpf_library:
+
 Berkeley Packet Filter (BPF) Library
 ====================================
 
diff --git a/doc/guides/prog_guide/ethdev/index.rst b/doc/guides/prog_guide/ethdev/index.rst
index 392ced0a2e..cb905b92f1 100644
--- a/doc/guides/prog_guide/ethdev/index.rst
+++ b/doc/guides/prog_guide/ethdev/index.rst
@@ -12,4 +12,5 @@ Ethernet Device Library
     flow_offload
     traffic_metering_and_policing
     traffic_management
+    port_mirror
     qos_framework
diff --git a/doc/guides/prog_guide/ethdev/port_mirror.rst b/doc/guides/prog_guide/ethdev/port_mirror.rst
new file mode 100644
index 0000000000..f270fb6627
--- /dev/null
+++ b/doc/guides/prog_guide/ethdev/port_mirror.rst
@@ -0,0 +1,68 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2025 Stephen Hemminger
+
+Port Mirroring API
+==================
+
+
+Overview
+--------
+
+The Ethdev port mirror API is a feature usefel for passive network analysis
+and monitoring. `Port mirroring`_ is a common feature of network switches;
+it is known as SPAN (Switch Port Analyzer) on Cisco terminology.
+Mirroring is a feature in the ethdev layer that copies
+some or all of the packets passing through a port.
+
+Port mirroring can be used for analyze and debugging packets or
+traffic analysis.
+
+Mirroring is implemented in the ethdev layer and copies packets
+before they are seen by the network driver (PMD).
+On transmit packets are copied after the transmit callbacks and
+just before passing to the network driver.
+On Receive packets are copied when they are received from
+the network driver before any receive callbacks.
+
+
+Implementation
+--------------
+
+Creating a port mirror is done by the *rte_eth_add_mirror()* function.
+The ``struct rte_eth_mirror_conf`` controls the settings of the new
+mirror.
+
+.. code-block:: c
+
+  struct rte_eth_mirror_conf {
+        struct rte_mempool *mp; /**< Memory pool for copies, If NULL then cloned. */
+        struct rte_bpf_prm *filter; /**< Optional packet filter */
+        uint32_t snaplen;       /**< Upper limit on number of bytes to copy */
+        uint32_t flags;         /**< bitmask of RTE_ETH_MIRROR_XXX_FLAG's */
+        uint16_t target;        /**< Destination port */
+  };
+
+
+The ``target`` field is ethdev port which will be used as the output
+for the copied packets. The ``flags`` field is used to control whether
+packets are mirrored on transmit (egress), receive (ingress) or both.
+The ``filter`` is an optional BPF filter useful for selecting a subset
+of the packets to be mirrored.
+
+Limitations
+-----------
+
+There are some limitations to using port mirroring.
+
+- The port being used for mirroring should not be confused with active ports
+  used for other traffic. The port ownership API can be used to solve this.
+
+- There is some performance impact when using port mirroring. The overhead
+  of copying packets and sending on a the target port can be noticeable.
+
+- Some packets maybe lost if the target port can not keep up with the
+  mirrored traffic. This can be observed with the ``rte_eth_mirror_stats``.
+
+- The API restricts mirroring of target ports to prevent packet loops.
+
+.. _Port Mirroring: https://en.wikipedia.org/wiki/Port_mirroring
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index c91207cab2..7681ed93f2 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -175,3 +175,8 @@ Deprecation Notices
   without relying on flow API.
   Currently there is no alternative API
   providing the same functionality as with ``repr_matching_en`` set to 0.
+
+* pdump: The packet dump library is deprecated and will be removed
+  in 26.11 release. The pdump library uses callbacks and therefore
+  is unable to capture packets sent or received by a secondary process.
+  It is superseded by the port mirroring API.
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index ccad6d89ff..0348889fe3 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -56,6 +56,11 @@ New Features
      =======================================================
 
 
+* **Added port mirroring API.**
+
+  Added new API to ethdev to allow monitoring and collecting packets
+  using port mirroring.
+
 Removed Items
 -------------
 
-- 
2.47.2

