Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFB6C87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 17:36:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18F7740A75;
	Thu,  7 Aug 2025 19:35:17 +0200 (CEST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 2E67F40A7D
 for <dev@dpdk.org>; Thu,  7 Aug 2025 19:35:15 +0200 (CEST)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-459e1338565so12157715e9.2
 for <dev@dpdk.org>; Thu, 07 Aug 2025 10:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754588115;
 x=1755192915; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ep/qsXzNqDl3sFktIpWYBVBIlVf4IsIslGwuy1BwA5w=;
 b=FfAtL2ypwDS9JgR0N2wJXLz0BBZZzihlLLEoMToI5gpofjU88VCmT69lIAfQFKnv9t
 x5ev/6KUACuSVK9ck3Fwdu/0RO6CnMlqzgR+yupdu9csyU76sqdJFhCabbD8f2WikkrD
 KjMfxr0S2ya9k3ueMdHHzoFT4WulEKvX+uTTt1KgkOLDEvuzbeG9uGvNIDyjrS3l0rll
 J3WxOclwk9N8SajCazqwaHXALD3A2MM4KFaeUynn7SwDRbTK4NVcJ607WaoYJzHb83qq
 luQU8yx/eviRmoFRwA1BymZY3sW7+rCJDYU66qehgNimI/FMW8tPGduAivGgPbSS0fsD
 LZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754588115; x=1755192915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ep/qsXzNqDl3sFktIpWYBVBIlVf4IsIslGwuy1BwA5w=;
 b=vAhgR2UKAyJcfUJ98ZoXpT9Yk5cKx0cR/qc4sLpEgi2JcXvhqU4FJUkL+ZvOLGKHCJ
 MKp/wKM6vnX5YgDx4rBD9rUKy8ivtmxo9BXvfZMhC7DeWe1rP5GCQsf48h5xJ9dpLeRC
 VyBmlqkARxy6aeNGb+Q2qZqyv7x5p2dktVp0WLzJzrpqUHsN1yzNXmPr4VejmalROlXF
 FXuRGs1UY9zJtHWWNzvY7XcoLPtrX21AwuN01z3nqg+tNVRQQ4v8BDLK+gELJzWDOMJu
 kuzMvkF1ypA2AxKdbNkBSyvqqAITzmUh/yH1rPzNHbr5wY4iJffdoGYIDn0N6Z5AnIMv
 RKLg==
X-Gm-Message-State: AOJu0YxvrUrNLMRcZlAAFveCYr+UymGo+gBHe/Qdi787LXJIa3OBss6y
 jG+aHYnqfosWJC0smtzkh2PEyaNXmK6/GalOF1wAKeCZ1VZ25w/IklUx0EXxgQtuxASfzIYxUka
 ZNYqe
X-Gm-Gg: ASbGnctrR0GERZl0AGpifUH3/Kj1tcpHvDkG7s7yxjPafZGH3wrr3vPIIQfvkQXPxLH
 Dyj4jr9+8vPQzcGVRuOe+O2QOu85MBt8ju8ICl/Oj9g7uxPBACCM/3wNLU+C5A/nV7Orhf8g8pc
 PGtaM4BIi8SdMCtslh2L+Uxgu4a25njL9uEEx5ZY6PpgLdCcg9wCVnjw2t8O0z/LJWs2Iz4xymi
 +0H1RoKp67uwN0uUcqWW+FmSJUVs5yKu/M2xJ42BKSBTXrMh5U2hSUIK7Gfm967LtbqzWcC59jy
 MrWhK+/SXHX2L6fPiS0Bnmfq5J5r9KUgcoWqrQ4hMlF+xe38wBX6XFYkQxo3RRTR5TUR0jfoFIx
 MoTeX7t1WJLwv8ZreDg0NH+NY9vRzwoxpHlCyEywdHGR6pdP5YM2L4/DRNOIT4aUkAywJ/4GQ9U
 HFRD4o0qE=
X-Google-Smtp-Source: AGHT+IGKsoKOuSsk6Sk2+wW7oNNpNxQchNR5dYCiCRgyv7RGRDGUA5hedCkCquZ6/fFIQmN9B+a1kw==
X-Received: by 2002:a05:6000:288b:b0:3b5:f0aa:b1e5 with SMTP id
 ffacd0b85a97d-3b900b4dac6mr67981f8f.19.1754588114679; 
 Thu, 07 Aug 2025 10:35:14 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e9464f46sm13242838f8f.19.2025.08.07.10.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 10:35:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v10 14/14] doc: add documentation for port mirroring
Date: Thu,  7 Aug 2025 10:33:28 -0700
Message-ID: <20250807173437.11442-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250807173437.11442-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250807173437.11442-1-stephen@networkplumber.org>
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

