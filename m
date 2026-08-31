Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4ABC61DE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 10:26:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25DCD40678;
	Mon, 31 Aug 2026 12:26:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 1354E4042F;
 Mon, 31 Aug 2026 12:26:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788171990; x=1819707990;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Bg57EwTXi5P0j2jV6BSMiF6ImVYUTHYO5ETN3tt0JdA=;
 b=Z1Pqv6KvNpMmt2lqY/FJGAYlfF84Gz4kh2UN6trpH2dHQqAoFl6yp1b/
 hPvEFPlg3wFWZXp7TeDJfHUFjqW8QaMIQop3MeyiYL/RO/Bd8h7RcQMYN
 O6jAMJ15BMGLJMKJmU+QPLVRFhq7xVJHEreXN4bNGjV8xkx0YbhBB5jMS
 /UdnsMR1Nj/Dswii5u8F9lq7H0oagAcOjW+uSJv8/2Oag9V75fDgkOkok
 PJ5IrgxENpqRP80bzvnTwlrKaH45jMA9GNxuJBxqn48hQpGqbtIs00STO
 UHsSbfehj2HxPnilcZpORa3eEGLn1C7pEeqe65q3BPhMyNf13x3IgLS9O A==;
X-CSE-ConnectionGUID: SwPRA4FdR2+o2/ERxz36LQ==
X-CSE-MsgGUID: mrNXMjgpSHyRDJHnJW1Uxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88452416"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="88452416"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 03:26:29 -0700
X-CSE-ConnectionGUID: PYO9+L5HSzqtZZ+C4Loc+Q==
X-CSE-MsgGUID: Bqahd4jySXuoSQ8kQpD4aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="267424140"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 31 Aug 2026 03:26:28 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Radu Nicolau <radu.nicolau@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Abhijit Sinha <abhijit.sinha@intel.com>
Subject: [PATCH 1/7] net/iavf: disable broken QinQ strip on Rx
Date: Mon, 31 Aug 2026 11:26:14 +0100
Message-ID: <20260831102621.495759-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831102621.495759-1-bruce.richardson@intel.com>
References: <20260831102621.495759-1-bruce.richardson@intel.com>
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

When 2 VLANs are stripped from a packet, the iavf driver vector path
fails to handle them properly as it 'or's the two values together on the
assumption that only one is valid. Explicitly list the VLAN related
features supported by the vector path, rather than using the
"OFFLOAD_VLAN" group, thereby disabling advertising of QinQ stripping so
that a scalar path is used.

Fixes: 1e728b01120c ("net/iavf: rework Tx path")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 6f53d5805a..3ff49b94b4 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -105,7 +105,9 @@
 		IAVF_RX_VECTOR_OFFLOADS |		\
 		RTE_ETH_RX_OFFLOAD_CHECKSUM |		\
 		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |		\
-		RTE_ETH_RX_OFFLOAD_VLAN |		\
+		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |		\
+		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |	\
+		RTE_ETH_RX_OFFLOAD_VLAN_EXTEND |	\
 		RTE_ETH_RX_OFFLOAD_RSS_HASH)
 /* vector offload paths that use the flex rx desc */
 #define IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS (		\
--
2.53.0

