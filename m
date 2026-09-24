Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB79C98314
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 13:14:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EB6142FB2;
	Thu, 24 Sep 2026 15:14:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 97F2E400D7;
 Thu, 24 Sep 2026 15:14:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790255677; x=1821791677;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=09+OudvSO/YO++L1Mk5CebxkGlLqXm5ApRv9di1eXWE=;
 b=TZevDvvswC5JLyi+VPW8ERnJoRgxgJ7wWv2zjyje124TD+GIweWwZ/gt
 MMsAAKVnEkISMDNaDyn3THOp6O9j+2J4WwYBXAUegnfkTTvbDAxM3Gi45
 KkL/veOR7RjXfRYgWeoMJz20QZZHwdnDp2rK8NPK2MQxdrZz9owaVs4m1
 LHgsoG0O8nQRrOt3kKz7Mj30+eSsqY1mcwOLDnH+9vaMXJ4RH5t8R5/Cw
 XeexKcKO3qvidgvFgC6JxB47P+75ipjAVwG8Md7Nq7IwvCwZqYwwbmeSu
 JQGb7Fj8HPrQFe5Luwh558A5sPjdLatF2YKtxSwzqnQUKrUKIDogQYh/6 w==;
X-CSE-ConnectionGUID: Z38w9GUURnSFHkMIA4Wrdg==
X-CSE-MsgGUID: AKVnNZlsTJOqEiqdOn9koQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="93915424"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="93915424"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 06:14:36 -0700
X-CSE-ConnectionGUID: tjceWpIgSBypcponN66zaQ==
X-CSE-MsgGUID: z23kpcC6RlaK4/G6yBgy+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="273518520"
Received: from silpixa00401177.ir.intel.com (HELO vm-icx177..)
 ([10.20.224.214])
 by fmviesa007.fm.intel.com with ESMTP; 24 Sep 2026 06:14:34 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 2/6] net/ice: fix Rx vector path offload masks
Date: Thu, 24 Sep 2026 13:13:42 +0000
Message-ID: <20260924131346.100156-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924131346.100156-1-ciara.loftus@intel.com>
References: <20260924131346.100156-1-ciara.loftus@intel.com>
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

The offload RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM was advertised as available
on the plain (non-offload) AVX2/AVX512 Rx paths, however only the offload
versions of those paths compute checksum status flags. Move the flag to
the Rx vector offload path mask where it belongs.

Fixes: 872b571787 ("net/ice: use common Rx path selection infrastructure")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_rxtx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index b809c8b0e80..e58f1fab376 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -95,12 +95,12 @@
 /* basic vector paths */
 #define ICE_RX_VECTOR_OFFLOADS (				\
 			RTE_ETH_RX_OFFLOAD_KEEP_CRC |		\
-			RTE_ETH_RX_OFFLOAD_SCATTER |		\
-			RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM)
+			RTE_ETH_RX_OFFLOAD_SCATTER)
 /* vector offload paths */
 #define ICE_RX_VECTOR_OFFLOAD_OFFLOADS (	\
 		ICE_RX_VECTOR_OFFLOADS |	\
 		RTE_ETH_RX_OFFLOAD_CHECKSUM |	\
+		RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM |	\
 		RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM |	\
 		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |	\
 		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |\
-- 
2.43.0

