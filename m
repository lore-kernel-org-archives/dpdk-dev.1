Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D58CD8C92
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 16:14:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4E98406A2;
	Mon,  8 Jun 2026 18:14:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 572F14069F
 for <dev@dpdk.org>; Mon,  8 Jun 2026 18:14:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780935261; x=1812471261;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3B8uGynd+QITGU/KQXOD04V9+bzhD+MKmw4GhIhYuQg=;
 b=XDLV11DKuLT5RYeBCSncmczcWiPNOjEEIW3EljgU7p8so3nxB1BQI+fy
 cW6H0Utjfy+dR0CR9iK8O7311EYRLMnt0YzQf3B++yyWTv8pNKhyRlv2s
 cUAtGtRDNhlNyxmoAXJBUk3lRBiaZrbgAxcWLxB6xfflSj//rdntQHpz4
 67Mn0VtFAJ1GjD9mmA3TdM0mXVq87KbqaN98njZIjWGTMHoMYRXEbeIL1
 9aTG/ZMMOdBxMLa07ycbsnh863bHxISTnwoKXyMbtBrwLoiFWCOrrihC1
 3ltjsrxXWIjYs6j2QCFQvyGpVMPiyz9EPH8afhqEHCOq5TcXLQnjSU7u6 g==;
X-CSE-ConnectionGUID: O4D4GpiJTRWdrfiy7Z7ERQ==
X-CSE-MsgGUID: BmiiUghZT3eUDuFsq9/fmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="80809572"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="80809572"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 09:14:20 -0700
X-CSE-ConnectionGUID: tUc2wFGPRpGrwQBH8wZAqg==
X-CSE-MsgGUID: 7gFrQBR5QUOiTZPImxg/Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="245457455"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by orviesa008.jf.intel.com with ESMTP; 08 Jun 2026 09:14:18 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com,
 vladimir.medvedkin@intel.com, bruce.richardson@intel.com,
 anatoly.burakov@intel.com, reshma.pattan@intel.com,
 stephen@networkplumber.org, Marek Kasiewicz <marek.kasiewicz@intel.com>,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH 5/7] net/iavf: disable runtime queue setup capability
Date: Mon,  8 Jun 2026 12:40:57 -0400
Message-ID: <20260608164059.65420-6-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608164059.65420-1-dawid.wesierski@intel.com>
References: <20260608164059.65420-1-dawid.wesierski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

From: Marek Kasiewicz <marek.kasiewicz@intel.com>

Remove the advertisement of RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP
and RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP capabilities from the
iavf VF driver.

Runtime queue setup on E810 VFs causes queue state corruption when
queues are dynamically reconfigured while the hardware rate limiter
is actively pacing TX queues. Queue configuration messages to the PF
via virtchnl can race with ongoing TX operations, leading to undefined
behavior.

By not advertising these capabilities, all queues are configured at
port start and remain stable throughout the port lifecycle.


Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index a8031e23a5..4f6325ef78 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1159,9 +1159,6 @@ iavf_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->reta_size = vf->vf_res->rss_lut_size;
 	dev_info->flow_type_rss_offloads = IAVF_RSS_OFFLOAD_ALL;
 	dev_info->max_mac_addrs = IAVF_NUM_MACADDR_MAX;
-	dev_info->dev_capa =
-		RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP |
-		RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;
 	dev_info->rx_offload_capa =
 		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
 		RTE_ETH_RX_OFFLOAD_QINQ_STRIP |
-- 
2.47.3

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

