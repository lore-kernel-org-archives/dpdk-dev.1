Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654A7CD98CE
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Jun 2026 14:36:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B29A432F6;
	Fri, 12 Jun 2026 16:36:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id BCD9640279;
 Fri, 12 Jun 2026 16:36:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781274985; x=1812810985;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=eyG9t7NeHCshRLNOnwcFyWXEM2BDEEgQz0k2jZOP7I0=;
 b=Gy8KWH9+Ev9uC/Xa6bMm+bmg5U6FAXasmvcpcyc6Gl9P3zm2v94zwR9X
 hxWGG5CEYKs4VxOnFd4YfEoywWrTPQoe75i9MYr7ReJFCxV/+kPUiixKv
 vvozWUGGOEdlWoz+852r8MDkUIR5f6J/g/iDt072zqhpWLJBxnTiZQmpD
 uaXDLlqKupJAcbCkf6R5qfDLuxqjSzth5/OUGm7OyNrrtpFbW7/ZZdq6I
 ccSRtDOORerkllHoO/GDwS1Q+NKhBdMH2j/bJ6cfYNpcvVH6PG5apGZ2E
 SaOa4zqT78kensex1D1SLewKXbzngrh9PfAQWpQWTm9T/Vz3Xfp7gw/KI g==;
X-CSE-ConnectionGUID: H/JEC949SBy3v/GodSasew==
X-CSE-MsgGUID: ISkmG/w2Tj+iSGQhfiOd9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="92427578"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="92427578"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 07:36:24 -0700
X-CSE-ConnectionGUID: EpCg7Lm1SemqZdIwUX9qgA==
X-CSE-MsgGUID: n+KPDpfBRJixMgXBsnuvIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="250759881"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa003.jf.intel.com with ESMTP; 12 Jun 2026 07:35:58 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>, stable@dpdk.org,
 Declan Doherty <declan.doherty@intel.com>
Subject: [PATCH] net/iavf: fix scalar Rx path zero-length segment
Date: Fri, 12 Jun 2026 14:35:31 +0000
Message-ID: <20260612143531.2265914-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
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

When hardware CRC stripping is active, a frame whose on-wire size is an
exact multiple of the Rx buffer size can cause the NIC to fill the final
data descriptor and place the four CRC bytes into a separate trailing
descriptor. After hardware stripping, that descriptor carries zero bytes
of payload.

The existing CRC cleanup code only handles a zero-length trailing segment
when software CRC stripping is enabled. When hardware stripping is
active, the zero-length mbuf is silently chained to the reassembled
packet. Forwarding such a packet causes a zero-length Tx descriptor,
triggering a Malicious Driver Detection event on the PF and resetting
the VF.

Fix by adding logic to detect a zero-length final segment when hardware
CRC stripping is active, and freeing it.

Fixes: a2b29a7733ef ("net/avf: enable basic Rx Tx")
Fixes: b8b4c54ef9b0 ("net/iavf: support flexible Rx descriptor in normal path")
Cc: stable@dpdk.org

Signed-off-by: Declan Doherty <declan.doherty@intel.com>
Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index a57af7faed..86ebb2618d 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -1716,6 +1716,14 @@ iavf_recv_scattered_pkts_flex_rxd(void *rx_queue, struct rte_mbuf **rx_pkts,
 				rxm->data_len = (uint16_t)(rx_packet_len -
 							RTE_ETHER_CRC_LEN);
 			}
+		} else if (unlikely(rx_packet_len == 0)) {
+			/*
+			 * NIC split CRC bytes into a trailing segment which is
+			 * now empty after hardware CRC stripping. Free it.
+			 */
+			rte_pktmbuf_free_seg(rxm);
+			first_seg->nb_segs--;
+			last_seg->next = NULL;
 		}
 
 		first_seg->port = rxq->port_id;
@@ -1884,6 +1892,14 @@ iavf_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			} else
 				rxm->data_len = (uint16_t)(rx_packet_len -
 							RTE_ETHER_CRC_LEN);
+		} else if (unlikely(rx_packet_len == 0)) {
+			/*
+			 * NIC split CRC bytes into a trailing segment which is
+			 * now empty after hardware CRC stripping. Free it.
+			 */
+			rte_pktmbuf_free_seg(rxm);
+			first_seg->nb_segs--;
+			last_seg->next = NULL;
 		}
 
 		first_seg->port = rxq->port_id;
-- 
2.43.0

