Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09B5EFD20F
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 08:57:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C33314021E;
	Wed, 25 Feb 2026 09:57:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id CAD33400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 09:57:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772009821; x=1803545821;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WnltfNKhc37cPmLxegsv7FH8DCLaTqbEcQuTeFmHhv0=;
 b=j2eLi5TKs5HbMA3WiY1ucY9OC4mEu58dssCNtO8nVxvgcigPC+kt8hXZ
 tIrHIlsEqmITC9J3rmk9VVUxKICBOoVz24VQN9ULoPr5hPMRedOon4D6i
 Fux4ltyPZZ2ipuiTOw2bQsxg8NWnYWD+XAd+zRTGicxtTH39MmbNn9Bku
 YwrxaDw20lDe185lr4zyNa8aoS3VgQ1JhI3yaoI4xHIxJG9O91flO3Eth
 LENG+rh63DiZXY4gxrqIwF5vU9Vv9G1nirxtHkppGl98D3dajFkXXNr+z
 Yb7tjYMP6GCPKsGj6c16MmsoDpT9glVupCqpW6eMxPweQT5vGhlewzLyW g==;
X-CSE-ConnectionGUID: gm6z4ai+SLuAKRiCmyfe3Q==
X-CSE-MsgGUID: HqAmITpkR1W/aN8Q1nN56w==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="75650426"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="75650426"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 00:57:00 -0800
X-CSE-ConnectionGUID: Apyv/wRiRt2cc3ztqlVJ5A==
X-CSE-MsgGUID: qZ0x5lK8R16GB60Wn4Ki9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="221171517"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by orviesa005.jf.intel.com with ESMTP; 25 Feb 2026 00:56:59 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH] net/idpf: fix typo in CQ scan threshold macro name
Date: Wed, 25 Feb 2026 14:23:33 +0530
Message-Id: <20260225085333.2740447-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
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

Fix the misspelled macro IDPD_TXQ_SCAN_CQ_THRESH to
IDPF_TXQ_SCAN_CQ_THRESH in the header and its usage
in the AVX512 split queue Tx path.

Fixes: e528d7c74819 ("common/idpf: add AVX512 data path for split queue model")
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/idpf/idpf_common_rxtx.h        | 2 +-
 drivers/net/intel/idpf/idpf_common_rxtx_avx512.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index 914cab0f25..5e9e9c1d6d 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -52,7 +52,7 @@
 #define IDPF_VPMD_TX_MAX_BURST		32
 #define IDPF_VPMD_DESCS_PER_LOOP	4
 #define IDPF_RXQ_REARM_THRESH		64
-#define IDPD_TXQ_SCAN_CQ_THRESH	64
+#define IDPF_TXQ_SCAN_CQ_THRESH	64
 
 /* MTS */
 #define GLTSYN_CMD_SYNC_0_0	(PF_TIMESYNC_BASE + 0x0)
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index fe870617bc..54efe66401 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -1166,7 +1166,7 @@ idpf_splitq_scan_cq_ring(struct ci_tx_queue *cq)
 
 	cq_qid = cq->tx_tail;
 
-	for (i = 0; i < IDPD_TXQ_SCAN_CQ_THRESH; i++) {
+	for (i = 0; i < IDPF_TXQ_SCAN_CQ_THRESH; i++) {
 		if (cq_qid == cq->nb_tx_desc) {
 			cq_qid = 0;
 			cq->expected_gen_id ^= 1;
-- 
2.34.1

