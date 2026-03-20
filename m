Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746C31093177
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 06:54:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 631AC402B2;
	Fri, 20 Mar 2026 07:54:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 839EB40272;
 Fri, 20 Mar 2026 07:54:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773989660; x=1805525660;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Z5nmXtpMecmCZnsXwxSwhI3uTNUnRoUGRfEIEaWCzfo=;
 b=ZoTRpJ0qOfcdOhy0PEv2ab57FT1RsbVT2doRqIYHv5U04mnzxy0f31kW
 ngPzgNPZcvo3Vr/Eh34awOq/soaYktCOggKp2OpSueus30ltXZF2gD1J+
 Gs4P2dsT4Vg9r+OryL2w196jz+b4WcyPQBZkmvMjL+cMByXudYo7/Z52E
 ++9J9RsdyVXMHyrIKQLWBE7zZ8FKN7bLCbH5kc+26Axlqj/FKYO4Kn82D
 orRDnu53nUwnTRpX8OX36dA7Kw6UsUVeDVEyi0SG4t8jHZBe+MTE671Eb
 OA5CYDStcqeZUbdwUdgu+mpwIokdd/Tg8m9YqLT56+2xT1OiLXwFkEQ6o g==;
X-CSE-ConnectionGUID: pAgduAoxT+aCtQusbqz+zQ==
X-CSE-MsgGUID: w2ZeWrgxTcG4xdvoQQen3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="100528297"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="100528297"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 23:54:18 -0700
X-CSE-ConnectionGUID: qaGhv4jtTv6geh6VZabAZw==
X-CSE-MsgGUID: aOFdKzCqQNaBYf3AKOA0Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="228142643"
Received: from unknown (HELO srv13..) ([10.190.213.143])
 by orviesa005.jf.intel.com with ESMTP; 19 Mar 2026 23:54:16 -0700
From: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
To: dev@dpdk.org, bruce.richardson@intel.com, stephen@networkplumber.org,
 fengchengwen@huawei.com, aman.deep.singh@intel.com
Cc: shaiq.wani@intel.com,
 Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>, stable@dpdk.org
Subject: [PATCH v5] app/testpmd: fix DCB forwarding TC mismatch handling
Date: Fri, 20 Mar 2026 06:29:54 +0000
Message-ID: <20260320062954.2042887-1-chaitanyababux.talluri@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311083751.1107404-1-chaitanyababux.talluri@intel.com>
References: <20260311083751.1107404-1-chaitanyababux.talluri@intel.com>
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

Fix DCB forwarding failed when the number of TCs on ports is inconsistent.

When ports have asymmetric TC configurations (e.g. 2 ports, port0 has
4 TCs and port1 has 8 TCs), the forwarding logic iterates based only
on the Rx port TC count.
This can lead to accessing invalid Tx TC entries and incorrect queue
mapping, which will result in a SIGFPE exception.

Additionally, the existing VMDq pool guard in dcb_fwd_config_setup()
only checks RX queue counts and does not consider the case where the TX
port has no queues for a given pool/TC combination.

Fix this by:
1. Introducing an effective TC count using RTE_MIN() of Rx and Tx TC
   values, ensuring forwarding only operates on valid TCs supported by
   both ports.
2. Updating the loop condition to use the effective TC count instead of
   only the Rx TC count.
3. Extending the queue validation in dcb_fwd_config_setup() to ensure
   both Rx and Tx queues are valid for a given TC.

Testpmd command to reproduce:

x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 1-20 -n 4 \
-a 0000:31:00.0 -a 0000:4b:00.0 \
--file-prefix=testpmd1 -- -i --rxq=256 --txq=256 \
--nb-cores=16 --total-num-mbufs=600000

port stop all
port config 0 dcb vt off 8 pfc on
port config 1 dcb vt off 8 pfc on
port start all
port stop all
port config 0 dcb vt off 4 pfc on

This ensures correct queue mapping and avoids issues when switching
between different DCB configurations across ports.

Fixes: 1a572499beb6 ("app/testpmd: setup DCB forwarding based on traffic class")
Cc: stable@dpdk.org

Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---

v5:
* Updated commit message as per review comments.
* Added reproduction steps and SIGFPE explanation.
* Updated Fixes tag.

v4:
* Removed runtime update of dcb_fwd_tc_mask as per review comments.
* Used effective TC count (RTE_MIN of RX/TX) to handle asymmetric configs.
* Moved queue validation to dcb_fwd_check_cores_per_tc().

v3: Removed old email address.

v2:
* Used res->num_tcs to derive dcb_fwd_tc_mask.
* Removed redundant rte_eth_dev_get_dcb_info().
---
 app/test-pmd/config.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index f9f3c542a6..052e8b7c24 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -5377,6 +5377,7 @@ dcb_fwd_config_setup(void)
 	uint16_t nb_rx_queue, nb_tx_queue;
 	uint16_t i, j, k, sm_id = 0;
 	uint16_t sub_core_idx = 0;
+	uint8_t effective_nb_tcs;
 	uint16_t total_tc_num;
 	struct rte_port *port;
 	uint8_t tc = 0;
@@ -5442,6 +5443,7 @@ dcb_fwd_config_setup(void)
 	dcb_fwd_tc_update_dcb_info(&rxp_dcb_info);
 	(void)rte_eth_dev_get_dcb_info(fwd_ports_ids[txp], &txp_dcb_info);
 	dcb_fwd_tc_update_dcb_info(&txp_dcb_info);
+	effective_nb_tcs = RTE_MIN(rxp_dcb_info.nb_tcs, txp_dcb_info.nb_tcs);
 
 	for (lc_id = 0; lc_id < cur_fwd_config.nb_fwd_lcores; lc_id++) {
 		fwd_lcores[lc_id]->stream_nb = 0;
@@ -5450,7 +5452,8 @@ dcb_fwd_config_setup(void)
 			/* if the nb_queue is zero, means this tc is
 			 * not enabled on the POOL
 			 */
-			if (rxp_dcb_info.tc_queue.tc_rxq[i][tc].nb_queue == 0)
+			if (rxp_dcb_info.tc_queue.tc_rxq[i][tc].nb_queue == 0 ||
+			    txp_dcb_info.tc_queue.tc_txq[i][tc].nb_queue == 0)
 				break;
 			k = fwd_lcores[lc_id]->stream_nb +
 				fwd_lcores[lc_id]->stream_idx;
@@ -5480,7 +5483,7 @@ dcb_fwd_config_setup(void)
 
 		sub_core_idx = 0;
 		tc++;
-		if (tc < rxp_dcb_info.nb_tcs)
+		if (tc < effective_nb_tcs)
 			continue;
 		/* Restart from TC 0 on next RX port */
 		tc = 0;
@@ -5497,6 +5500,8 @@ dcb_fwd_config_setup(void)
 		dcb_fwd_tc_update_dcb_info(&rxp_dcb_info);
 		rte_eth_dev_get_dcb_info(fwd_ports_ids[txp], &txp_dcb_info);
 		dcb_fwd_tc_update_dcb_info(&txp_dcb_info);
+
+		effective_nb_tcs = RTE_MIN(rxp_dcb_info.nb_tcs, txp_dcb_info.nb_tcs);
 	}
 }
 
-- 
2.43.0

