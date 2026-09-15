Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84E0C88E7F
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 15:05:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C40D540B91;
	Tue, 15 Sep 2026 17:05:10 +0200 (CEST)
Received: from rcdn-iport-8.cisco.com (rcdn-iport-8.cisco.com [173.37.86.79])
 by mails.dpdk.org (Postfix) with ESMTP id B381A40A6B
 for <dev@dpdk.org>; Tue, 15 Sep 2026 17:05:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=3158; q=dns/txt;
 s=iport01; t=1789484709; x=1790694309;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FnDhYBU+QluJ6Yl3CMF6vnEL4eD0dhqyDW1YEylXNf8=;
 b=Olayd34iyj/UZqpGWZYciNBG3ju+rZnRkzMmhKycgZilXL9CMh82lKly
 woe5323jGkRunfyReIKrbcrOnll9aX11jtMRnPHzaDVkuWBld166zMLxJ
 ELKrk6pW8bkWBEchZqs6JkzIRssyNrcLDsfxvOnfQfuXwYasoNJqRiMv8
 u219IpfhfUNUtHZt5s6mdIokOpqlavDMxFO7ep49wy4HGZIDDXWj2hJpb
 4jWha0G+kJ6zFsYizFgw8bT3Lu/+Xk5NOmalaRJj4Axx36yDze+s0pyfn
 ydI8Z60NzG/6A3Bup7OTifiBVrTzJabo50WrdMKunBjZbwKbdP+sW7GZQ w==;
X-CSE-ConnectionGUID: k75J3dR4SiiVcg0ZRR/j3Q==
X-CSE-MsgGUID: NpdvptfRRK+d9IPXfMvkjA==
X-IPAS-Result: =?us-ascii?q?A0BDAgAGXalq/5H/Ja1aglmCV4FWQkmiMZI3gX4PAQEBD?=
 =?us-ascii?q?1EEAQGEBAGBAAKOBwImNAkOAQIEAwIDAQEBAQEBAQEBAQEBCgEBBQEBAQIBB?=
 =?us-ascii?q?wWBDhOGXJATAgEDMgFGEFEgNhmDAoI7AzcDwXqCLIEBhH7YSw1ygWgBCxQBg?=
 =?us-ascii?q?TiIPoUjdkSEOCcVBoFJRIEVg2mCH4hpBIMug1eQVUiBHgNZLAFVEw0KCwcFg?=
 =?us-ascii?q?WYDNRIqFW4yHYEjPheBBxsGBYEdgSeCYiMZNnqBCV6BKylgARIXgQmCCAKCV?=
 =?us-ascii?q?IIBAgFJQw4HRVMJJ0EKEkwpIggSCQETGhcYDUgRLDcVGQQ+bgePKx+CXgGBD?=
 =?us-ascii?q?4Ixk2WyVXGEKJpWgQqFfBozhFGmHJkIkhORbSM3hGmBaDyBWU0jFYMiUxkPj?=
 =?us-ascii?q?i4W0BUoNT8HAgcPApNxAQE?=
IronPort-Data: A9a23:qEfaYaiImbIHjpS1Sh0Y/iBvX161LxEKZh0ujC45NGQN5FlHY01je
 htvXzyFOqrbYmD2fIhwYYzj9EgHvsSEytQwGQA4qCxmEnxjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FHwdOCn8ikkvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZeAULOZ82QsaDxMuvvf8EkHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqUbpbtVWm10q
 ccZKQ4GYUixvdjxwumCH7wEasQLdKEHPasFsX1miDWcBvE8TNWbE+PB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWZgp/5JEWxI9EglHlbzxTpXqepLE85C7YywkZPL3FbYOIK4HQGp4P9qqej
 kTe83rhHh8gDv/cxWukykKio/HMnwquDer+E5X9rJaGmma7ymENIBEOWVj9puO24maiW9VaI
 lc8/y0or6E280rtSNThNyBUu1aetRIaHt4VGOog5UTVmuzf4h2SAS4PSTsphMEaifLajAcCj
 jeh9+4FzxQ22FFJYRpxLoupkA4=
IronPort-HdrOrdr: A9a23:cGMBYa4LZ8WBHPB4wQPXwOjXdLJyesId70hD6qm+c3Bom6uj5q
 STdZsguyMc5Ax6ZJhko6HiBEDiewK4yXcK2+gs1N6ZNWGMhILrFvAB0WKI+VLd8kPFm9K1rZ
 0BT4FOTPvtEFN9kcH2pCO8E9om3Z271ZrAv5a485+oJjsaEp2JKGxCe2CmLnE=
X-Talos-CUID: =?us-ascii?q?9a23=3AZR3WsWredjom+sy5XxJcWWzmUcN6L1+GwE2MGE6?=
 =?us-ascii?q?5N21mEI+vcxiSo5oxxg=3D=3D?=
X-Talos-MUID: 9a23:naLzVQZCyfzp7+BTkSfgmil+Ov1SwOeiWWE1oZsjpcqGHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,103,1787011200"; d="scan'208";a="515952732"
Received: from rcdn-l-core-08.cisco.com ([173.37.255.145])
 by rcdn-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 15 Sep 2026 15:05:08 +0000
Received: from rtp-orb-10405.cisco.com (rtp-orb-10405.cisco.com [64.100.22.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by rcdn-l-core-08.cisco.com (Postfix) with ESMTPS id 3D6F418000450;
 Tue, 15 Sep 2026 15:05:08 +0000 (GMT)
From: Randy L Tice <rtice@cisco.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
	Randy L Tice <rtice@cisco.com>
Subject: [PATCH v2 1/1] eal: add API to get CPU socket ID
Date: Tue, 15 Sep 2026 11:05:07 -0400
Message-Id: <20260915150507.3-2-rtice@cisco.com>
X-Mailer: git-send-email 2.35.6
In-Reply-To: <20260915150507.3-1-rtice@cisco.com>
References: <178941409436.3.12421464753538796039@cisco.com>
 <20260915150507.3-1-rtice@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-Client-TLS: ANONYMOUS; rtp-orb-10405.cisco.com [64.100.22.53];
 TLSv1.3; TLS_AES_256_GCM_SHA384; 256
X-Outbound-SMTP-Client: 64.100.22.53, rtp-orb-10405.cisco.com
X-Outbound-Node: rcdn-l-core-08.cisco.com
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

Add experimental rte_cpu_socket_id() so applications can map an OS
logical CPU ID to its NUMA socket without requiring an EAL lcore ID.

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
 lib/eal/include/rte_lcore.h            | 18 ++++++++++++++++++
 4 files changed, 29 insertions(+)

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
index 87c7e81bde..b26e9fae88 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -95,6 +95,9 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* eal: Added experimental ``rte_cpu_socket_id()`` to map an OS logical
+  CPU ID to the NUMA socket containing that CPU.
+
 
 ABI Changes
 -----------
diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index b5f59a6380..b38285d642 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -130,6 +130,13 @@ rte_lcore_to_socket_id(unsigned int lcore_id)
 	return lcore_config[lcore_id].numa_id;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cpu_socket_id, 26.11)
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
index 10f965b4f0..e1e15581e8 100644
--- a/lib/eal/include/rte_lcore.h
+++ b/lib/eal/include/rte_lcore.h
@@ -160,6 +160,24 @@ rte_socket_id_by_idx(unsigned int idx);
 unsigned int
 rte_lcore_to_socket_id(unsigned int lcore_id);
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
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
+__rte_experimental
+unsigned int
+rte_cpu_socket_id(unsigned int cpu_id);
+
 /**
  * Return the id of the lcore on a socket starting from zero.
  *
-- 
2.35.6

