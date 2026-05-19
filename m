Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F365CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 16:09:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2162540697;
	Tue, 19 May 2026 18:08:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 0771C40676
 for <dev@dpdk.org>; Tue, 19 May 2026 18:08:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779206925; x=1810742925;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=W4Xo0LVduyV0RyH4EpP+2JyGOeSe9aYrMUomUXQOUVQ=;
 b=QoAPvw4vzlz1466N7/UEFjJ70SNvvHyyWxm0S27I3u6hw5kmQsi/9AHE
 PFbR3iWuIwkpGsXmaFABFfve45CsPgYNqTGLZAymrWPv6RsZJ+SwKUS7f
 sRNEzavU2lq5B/N4MRZTmSsnTr1NCjGYlaTQuqtC0SXtttsGrxvjzVGOw
 P0q+aWc09H8IRtodE+jsL3WO3o1VhWPWQtbCGBkC58teizofoDy7IZXlt
 nzYLg8/59HI+QLt3YMcE2xvBnVhAH/ct+AWS0lDOk8/Q7Je+BB1OQY+t2
 DxKAeusORkR5KSHEOmcHMBDBXaCdh3HAbV1zOVZYmm427sur2We5Mv1J9 g==;
X-CSE-ConnectionGUID: dD1ZZgtRTEWy04y4uwZReg==
X-CSE-MsgGUID: Dy8oqNpGTU6NyzuU+pLn4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80070069"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="80070069"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 09:08:44 -0700
X-CSE-ConnectionGUID: 05YFrCHlTdCHQKPYVbzZAw==
X-CSE-MsgGUID: nx0ehLr/QWinNYnMDlILBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="244784800"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.20.224.247])
 by orviesa005.jf.intel.com with ESMTP; 19 May 2026 09:08:43 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 8/8] net/ipn3ke: replace use of DPDK-specific memcpy
 function
Date: Tue, 19 May 2026 16:06:05 +0000
Message-ID: <20260519160823.1004973-9-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260519160823.1004973-1-bruce.richardson@intel.com>
References: <20260519160823.1004973-1-bruce.richardson@intel.com>
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

The driver use of memcpy is for control path work, for example, flow
configuration and so is fine using the standard libc memcpy function in
place of the DPDK-specific rte_memcpy version.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ipn3ke/ipn3ke_ethdev.h      |  1 -
 drivers/net/intel/ipn3ke/ipn3ke_flow.c        | 26 +++++++++----------
 drivers/net/intel/ipn3ke/ipn3ke_representor.c |  8 +++---
 drivers/net/intel/ipn3ke/ipn3ke_tm.c          |  6 ++---
 4 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/net/intel/ipn3ke/ipn3ke_ethdev.h b/drivers/net/intel/ipn3ke/ipn3ke_ethdev.h
index 4b93d2649e..0105fc9056 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_ethdev.h
+++ b/drivers/net/intel/ipn3ke/ipn3ke_ethdev.h
@@ -18,7 +18,6 @@
 #include <ethdev_driver.h>
 #include <ethdev_vdev.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <bus_vdev_driver.h>
 #include <rte_kvargs.h>
 #include <rte_spinlock.h>
diff --git a/drivers/net/intel/ipn3ke/ipn3ke_flow.c b/drivers/net/intel/ipn3ke/ipn3ke_flow.c
index a2f76268b5..941d2921fb 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_flow.c
+++ b/drivers/net/intel/ipn3ke/ipn3ke_flow.c
@@ -100,7 +100,7 @@ ipn3ke_pattern_vxlan(const struct rte_flow_item patterns[],
 		case RTE_FLOW_ITEM_TYPE_ETH:
 			eth = item->spec;
 
-			rte_memcpy(&parser->key[0],
+			memcpy(&parser->key[0],
 					eth->hdr.src_addr.addr_bytes,
 					RTE_ETHER_ADDR_LEN);
 			break;
@@ -108,7 +108,7 @@ ipn3ke_pattern_vxlan(const struct rte_flow_item patterns[],
 		case RTE_FLOW_ITEM_TYPE_VXLAN:
 			vxlan = item->spec;
 
-			rte_memcpy(&parser->key[6], vxlan->hdr.vni, 3);
+			memcpy(&parser->key[6], vxlan->hdr.vni, 3);
 			break;
 
 		default:
@@ -164,7 +164,7 @@ ipn3ke_pattern_mac(const struct rte_flow_item patterns[],
 		case RTE_FLOW_ITEM_TYPE_ETH:
 			eth = item->spec;
 
-			rte_memcpy(parser->key,
+			memcpy(parser->key,
 					eth->hdr.src_addr.addr_bytes,
 					RTE_ETHER_ADDR_LEN);
 			break;
@@ -369,13 +369,13 @@ ipn3ke_pattern_ip_tcp(const struct rte_flow_item patterns[],
 		case RTE_FLOW_ITEM_TYPE_IPV4:
 			ipv4 = item->spec;
 
-			rte_memcpy(&parser->key[0], &ipv4->hdr.src_addr, 4);
+			memcpy(&parser->key[0], &ipv4->hdr.src_addr, 4);
 			break;
 
 		case RTE_FLOW_ITEM_TYPE_TCP:
 			tcp = item->spec;
 
-			rte_memcpy(&parser->key[4], &tcp->hdr.src_port, 2);
+			memcpy(&parser->key[4], &tcp->hdr.src_port, 2);
 			break;
 
 		default:
@@ -434,13 +434,13 @@ ipn3ke_pattern_ip_udp(const struct rte_flow_item patterns[],
 		case RTE_FLOW_ITEM_TYPE_IPV4:
 			ipv4 = item->spec;
 
-			rte_memcpy(&parser->key[0], &ipv4->hdr.src_addr, 4);
+			memcpy(&parser->key[0], &ipv4->hdr.src_addr, 4);
 			break;
 
 		case RTE_FLOW_ITEM_TYPE_UDP:
 			udp = item->spec;
 
-			rte_memcpy(&parser->key[4], &udp->hdr.src_port, 2);
+			memcpy(&parser->key[4], &udp->hdr.src_port, 2);
 			break;
 
 		default:
@@ -502,19 +502,19 @@ ipn3ke_pattern_ip_nvgre(const struct rte_flow_item patterns[],
 		case RTE_FLOW_ITEM_TYPE_IPV4:
 			ipv4 = item->spec;
 
-			rte_memcpy(&parser->key[0], &ipv4->hdr.src_addr, 4);
+			memcpy(&parser->key[0], &ipv4->hdr.src_addr, 4);
 			break;
 
 		case RTE_FLOW_ITEM_TYPE_UDP:
 			udp = item->spec;
 
-			rte_memcpy(&parser->key[4], &udp->hdr.src_port, 2);
+			memcpy(&parser->key[4], &udp->hdr.src_port, 2);
 			break;
 
 		case RTE_FLOW_ITEM_TYPE_NVGRE:
 			nvgre = item->spec;
 
-			rte_memcpy(&parser->key[6], nvgre->tni, 3);
+			memcpy(&parser->key[6], nvgre->tni, 3);
 			break;
 
 		default:
@@ -576,19 +576,19 @@ ipn3ke_pattern_vxlan_ip_udp(const struct rte_flow_item patterns[],
 		case RTE_FLOW_ITEM_TYPE_VXLAN:
 			vxlan = item->spec;
 
-			rte_memcpy(&parser->key[0], vxlan->hdr.vni, 3);
+			memcpy(&parser->key[0], vxlan->hdr.vni, 3);
 			break;
 
 		case RTE_FLOW_ITEM_TYPE_IPV4:
 			ipv4 = item->spec;
 
-			rte_memcpy(&parser->key[3], &ipv4->hdr.src_addr, 4);
+			memcpy(&parser->key[3], &ipv4->hdr.src_addr, 4);
 			break;
 
 		case RTE_FLOW_ITEM_TYPE_UDP:
 			udp = item->spec;
 
-			rte_memcpy(&parser->key[7], &udp->hdr.src_port, 2);
+			memcpy(&parser->key[7], &udp->hdr.src_port, 2);
 			break;
 
 		default:
diff --git a/drivers/net/intel/ipn3ke/ipn3ke_representor.c b/drivers/net/intel/ipn3ke/ipn3ke_representor.c
index cd34d08055..281c025820 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_representor.c
+++ b/drivers/net/intel/ipn3ke/ipn3ke_representor.c
@@ -137,7 +137,7 @@ ipn3ke_rpst_dev_start(struct rte_eth_dev *dev)
 
 	if (hw->retimer.mac_type == IFPGA_RAWDEV_RETIMER_MAC_TYPE_10GE_XFI) {
 		/* Set mac address */
-		rte_memcpy(((char *)(&val)),
+		memcpy(((char *)(&val)),
 			(char *)&dev->data->mac_addrs->addr_bytes[0],
 			sizeof(uint32_t));
 		(*hw->f_mac_write)(hw,
@@ -145,7 +145,7 @@ ipn3ke_rpst_dev_start(struct rte_eth_dev *dev)
 				IPN3KE_MAC_PRIMARY_MAC_ADDR0,
 				rpst->port_id,
 				0);
-		rte_memcpy(((char *)(&val)),
+		memcpy(((char *)(&val)),
 			(char *)&dev->data->mac_addrs->addr_bytes[4],
 			sizeof(uint16_t));
 		(*hw->f_mac_write)(hw,
@@ -2746,13 +2746,13 @@ ipn3ke_rpst_mac_addr_set(struct rte_eth_dev *ethdev,
 		rte_ether_addr_copy(&mac_addr[0], &rpst->mac_addr);
 
 		/* Set mac address */
-		rte_memcpy(((char *)(&val)), &mac_addr[0], sizeof(uint32_t));
+		memcpy(((char *)(&val)), &mac_addr[0], sizeof(uint32_t));
 		(*hw->f_mac_write)(hw,
 				val,
 				IPN3KE_MAC_PRIMARY_MAC_ADDR0,
 				rpst->port_id,
 				0);
-		rte_memcpy(((char *)(&val)), &mac_addr[4], sizeof(uint16_t));
+		memcpy(((char *)(&val)), &mac_addr[4], sizeof(uint16_t));
 		(*hw->f_mac_write)(hw,
 				val,
 				IPN3KE_MAC_PRIMARY_MAC_ADDR0,
diff --git a/drivers/net/intel/ipn3ke/ipn3ke_tm.c b/drivers/net/intel/ipn3ke/ipn3ke_tm.c
index 04677138e1..47b7734d4f 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_tm.c
+++ b/drivers/net/intel/ipn3ke/ipn3ke_tm.c
@@ -814,7 +814,7 @@ ipn3ke_tm_shaper_profile_add(struct rte_eth_dev *dev,
 				rte_strerror(EINVAL));
 	} else {
 		sp->valid = 1;
-		rte_memcpy(&sp->params, profile, sizeof(sp->params));
+		memcpy(&sp->params, profile, sizeof(sp->params));
 	}
 
 	tm->h.n_shaper_profiles++;
@@ -960,7 +960,7 @@ ipn3ke_tm_tdrop_profile_add(struct rte_eth_dev *dev,
 			IPN3KE_TDROP_TH2_MASK);
 	tp->th1 = th1;
 	tp->th2 = th2;
-	rte_memcpy(&tp->params, profile, sizeof(tp->params));
+	memcpy(&tp->params, profile, sizeof(tp->params));
 
 	/* Add to list */
 	tm->h.n_tdrop_profiles++;
@@ -1308,7 +1308,7 @@ ipn3ke_tm_node_add(struct rte_eth_dev *dev,
 		n->tdrop_profile = ipn3ke_hw_tm_tdrop_profile_search(hw,
 			params->leaf.wred.wred_profile_id);
 
-	rte_memcpy(&n->params, params, sizeof(n->params));
+	memcpy(&n->params, params, sizeof(n->params));
 
 	return 0;
 }
-- 
2.51.0

