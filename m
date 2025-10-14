Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689D8CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 07:20:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E51C40658;
	Tue, 14 Oct 2025 09:20:10 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id D573E40288;
 Tue, 14 Oct 2025 08:00:46 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B7CEC201AFB;
 Tue, 14 Oct 2025 08:00:46 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 821A0201B0A;
 Tue, 14 Oct 2025 08:00:46 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A287A18000AF;
 Tue, 14 Oct 2025 14:00:45 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org,
	david.marchand@redhat.com
Cc: stable@dpdk.org
Subject: [PATCH 01/15] net/dpaa2: fix uninitialized variable issue
Date: Tue, 14 Oct 2025 11:30:31 +0530
Message-ID: <20251014060045.1304694-2-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014060045.1304694-1-prashant.gupta_3@nxp.com>
References: <20251014060045.1304694-1-prashant.gupta_3@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Tue, 14 Oct 2025 09:20:04 +0200
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

Initialize the kg_cfg structure before use in
rte_pmd_dpaa2_set_custom_hash(). This resolves an issue with
uninitialized memory access.

Fixes: 5f822962498e ("net/dpaa2: support custom hash key")
Cc: stable@dpdk.org

Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
---
 .mailmap                               | 1 +
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 0b043cb0c0..c260830f20 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1261,6 +1261,7 @@ Piotr Skajewski <piotrx.skajewski@intel.com>
 Potnuri Bharat Teja <bharat@chelsio.com>
 Pradeep Satyanarayana <pradeep@us.ibm.com>
 Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
+Prashant Gupta <prashant.gupta_3@nxp.com>
 Prashant Upadhyaya <prashant.upadhyaya@aricent.com> <praupadhyaya@gmail.com>
 Prateek Agarwal <prateekag@cse.iitb.ac.in>
 Prathisna Padmasanan <prathisna.padmasanan@intel.com>
diff --git a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
index b1d473429a..13825046d8 100644
--- a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
+++ b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2021,2023-2024 NXP
+ *   Copyright 2016-2021,2023-2025 NXP
  *
  */
 
@@ -60,6 +60,7 @@ rte_pmd_dpaa2_set_custom_hash(uint16_t port_id,
 		return -ENOMEM;
 	}
 
+	memset(&kg_cfg, 0, sizeof(struct dpkg_profile_cfg));
 	kg_cfg.extracts[0].type = DPKG_EXTRACT_FROM_DATA;
 	kg_cfg.extracts[0].extract.from_data.offset = offset;
 	kg_cfg.extracts[0].extract.from_data.size = size;
-- 
2.43.0

