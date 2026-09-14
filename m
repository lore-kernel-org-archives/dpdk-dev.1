Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1821EC88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 19:28:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84D5E40FB5;
	Mon, 14 Sep 2026 21:28:18 +0200 (CEST)
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
 by mails.dpdk.org (Postfix) with ESMTP id 6907740A7A
 for <dev@dpdk.org>; Mon, 14 Sep 2026 21:28:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=3004; q=dns/txt;
 s=iport01; t=1789414096; x=1790623696;
 h=from:to:cc:subject:date:in-reply-to:references:
 message-id:mime-version:content-transfer-encoding;
 bh=RejLbrVz7b9UtLH95piT0kaRDYsALgU62QTAa2aeqY4=;
 b=lGp/1WwqlIqJaQd3UYc7iJ5l4cQadrQnGSsd+4lsGPOHvvs/shpsEAmV
 9LXODOwPDQzJrNvMnmNQ3f1aKBBa2Wertx+MGVkvrbXV3nJUX48o996jF
 An6laNNe2SwET942EdQBk9qcI92ifiXwZT0GtK4keyPsvYdnLmdGyxuXj
 JGR6qSdYstb9lUf4HPgEFyc91/uTO9Rmu5j9y5O066es3GX7ute6HsNwf
 MV4DHjMXq0sBtj6ScNJomqFpv32HE2yYHoCcQZDZg1KxCKkCgiyFvZCFI
 19YSlCraaG5ZM8AtQXHJ7uHdUKInpuMUmQ4NlSw6c1h5Fylo2fFwUtF3m g==;
X-CSE-ConnectionGUID: KT6HlOPFQsqhfjjfVB9JRg==
X-CSE-MsgGUID: n46wlc7lRO6k+DQIfjEhTw==
X-IPAS-Result: =?us-ascii?q?A0D6AgDXSahq/5X/Ja1aHgEBCxIMggULgleBVkJJhFedW?=
 =?us-ascii?q?pI3gX4PAQEBD1EEAQGEBAF8AgICjgYCJjUIDgECBAMCAwEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QoBAQUBAQECAQcFgQ4ThlyQEwIBAyMPAUYQJQImAgIgNhmFPQM3A8UieoEyg?=
 =?us-ascii?q?QGEfthLDXKBaAELFAGBCi6IPiABhXhEhDgnFQaBSUSBFTKDN4IfgnGDDoJqB?=
 =?us-ascii?q?IMug1eQUEiBAhwDWSwBVRMNCgsHBYFmAzUSKhVuMh2BIz4XL1gbBgWBHYEng?=
 =?us-ascii?q?mIjGTZ6gQlegSspYAESF4EJgggCglSCAQIBSUMOB0VTCSdBChJMKSIIEgkBE?=
 =?us-ascii?q?xoPGA1IESw3FRkEPQFuB48nH4JfgQ+CMZNlslVxhCibYIYWM6ptmQiSE5JHh?=
 =?us-ascii?q?GmBaQE6gVlNIxV9BlaBSVMZD44uFtAVKDU/BwIHDwKTcQEB?=
IronPort-Data: A9a23:gt6WJq8ir23Ef+Lsloc0DrUDz3+TJUtcMsCJ2f8bNWPcYEJGY0x3n
 WZMDzjXb/uPYGGhKogga4ji9RgOsZeDm4cySAE5ryhEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmB4E/rbei5xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4mtyyHjEAX9gWAsYztIs/jrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2kVAdM4/sFPL1hV7
 PwWKjIDUDrSpdi5lefTpulE3qzPLeHxN48Z/3UlxjbDALN/G9bIQr7B4plT2zJYasJmRKmFI
 ZFGL2AyMVKZP0wn1lQ/UPrSmM+ymnj0fhVTqUmeouw85G27IAlZjeK2YIeMKoPVLSlTtkDE+
 H3C9Dv9ODZEN5+z8BuL8F+suvCayEsXX6pXTtVU7MVCjFCN7mALBB5QUkG0ydGlikm7Usl3L
 ksS+CMqqq508kG3JuQRRDWiq3KC+xpZUN1KHqhjskeGy7Hf5ECSAW1soiN9VeHKffQeHVQCv
 mJlVfuwbdCzmNV5kU6gy4o=
IronPort-HdrOrdr: A9a23:QsmXQqgsuzXqMBNGrXpqBdoJC3BQXvwji2hC6mlwRA09TyVXra
 yTdZMgpHjJYVcqKRUdcL+7VpVoLUm3yXcx2+gs1NSZLWzbURWTXeJfBOLZqlWKJ8S9zI5gPM
 xbHJSWZuecMbEDt7eZ3CCIV/A93dKA7Kekwc3az3trUEVWTpsI1XYeNu5eeXcGPDWvwvECZe
 Oh2vY=
X-Talos-CUID: =?us-ascii?q?9a23=3AIysep2jMBGMvj6iJnpb2IQJbvzJuUUGD7HP3G2G?=
 =?us-ascii?q?BEn9pRr+XR2G6qYFenJ87?=
X-Talos-MUID: 9a23:P68XKwR/gEE0LD0/RXTq2G99MMw3556JVkNOvawntcupNRBvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,103,1787011200"; d="scan'208";a="523851877"
Received: from rcdn-l-core-12.cisco.com ([173.37.255.149])
 by rcdn-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 14 Sep 2026 19:28:15 +0000
Received: from rtp-orb-10405.cisco.com (rtp-orb-10405.cisco.com [64.100.22.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by rcdn-l-core-12.cisco.com (Postfix) with ESMTPS id 20F2318000248;
 Mon, 14 Sep 2026 19:28:15 +0000 (GMT)
From: Randy L Tice <rtice@cisco.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Randy L Tice <rtice@cisco.com>
Subject: [PATCH 1/1] eal: add API to get CPU socket ID
Date: Mon, 14 Sep 2026 15:28:14 -0400
In-Reply-To: <178941409436.3.13205580340776837645@cisco.com>
References: <178941409436.3.13205580340776837645@cisco.com>
Message-Id: <178941409436.3.12421464753538796039@cisco.com>
X-Mailer: codex-smtplib
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Outbound-Client-TLS: ANONYMOUS; rtp-orb-10405.cisco.com [64.100.22.53];
 TLSv1.3; TLS_AES_256_GCM_SHA384; 256
X-Outbound-SMTP-Client: 64.100.22.53, rtp-orb-10405.cisco.com
X-Outbound-Node: rcdn-l-core-12.cisco.com
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

Add rte_cpu_socket_id() so applications can map an OS logical CPU
ID to its NUMA socket without requiring an EAL lcore ID.

Existing public socket APIs depend on EAL lcore configuration or the
calling thread's EAL state. They do not cover code that needs to look
up topology by OS CPU ID, such as building socket memory policy.

Reuse the existing per-OS EAL CPU socket lookup internally, while
keeping the eal_cpu_socket_id() helper private to EAL.

Signed-off-by: Randy L Tice <rtice@cisco.com>
---
 .mailmap                               |  1 +
 doc/guides/rel_notes/release_26_11.rst |  3 +++
 lib/eal/common/eal_common_lcore.c      |  7 +++++++
 lib/eal/include/rte_lcore.h            | 14 ++++++++++++++
 4 files changed, 25 insertions(+)

diff --git a/.mailmap b/.mailmap
index fcb3d1bb3f..2a8b54ea23 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1379,6 +1379,7 @@ Rakesh Kudurumalla <rkudurumalla@marvell.com> <rkudurumalla@caviumnetworks.com>
 Ralf Hoffmann <ralf.hoffmann@allegro-packets.com>
 Rami Rosen <ramirose@gmail.com> <rami.rosen@intel.com>
 Rami Rosen <ramirose@gmail.com> <roszenrami@gmail.com>
+Randy L Tice <rtice@cisco.com>
 Randy Schacher <stuart.schacher@broadcom.com>
 Rani Sharoni <ranish@nvidia.com>
 Ranjit Menon <ranjit.menon@intel.com>
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 87c7e81bde..6b037cdc73 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -95,6 +95,9 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* eal: Added ``rte_cpu_socket_id()`` to map an OS logical CPU ID to
+  the NUMA socket containing that CPU.
+
 
 ABI Changes
 -----------
diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index b5f59a6380..82927ce966 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -130,6 +130,13 @@ rte_lcore_to_socket_id(unsigned int lcore_id)
 	return lcore_config[lcore_id].numa_id;
 }
 
+RTE_EXPORT_SYMBOL(rte_cpu_socket_id)
+unsigned int
+rte_cpu_socket_id(unsigned int cpu_id)
+{
+	return eal_cpu_socket_id(cpu_id);
+}
+
 static int
 socket_id_cmp(const void *a, const void *b)
 {
diff --git a/lib/eal/include/rte_lcore.h b/lib/eal/include/rte_lcore.h
index 10f965b4f0..f4fbe33eef 100644
--- a/lib/eal/include/rte_lcore.h
+++ b/lib/eal/include/rte_lcore.h
@@ -160,6 +160,20 @@ rte_socket_id_by_idx(unsigned int idx);
 unsigned int
 rte_lcore_to_socket_id(unsigned int lcore_id);
 
+/**
+ * Get the ID of the NUMA node for a CPU.
+ *
+ * This function maps an OS logical CPU ID to the NUMA node containing
+ * that CPU.
+ *
+ * @param cpu_id
+ *   The OS logical CPU ID.
+ * @return
+ *   The ID of cpu_id's NUMA node, or 0 if unavailable.
+ */
+unsigned int
+rte_cpu_socket_id(unsigned int cpu_id);
+
 /**
  * Return the id of the lcore on a socket starting from zero.
  *
-- 
2.35.6
