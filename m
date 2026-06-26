Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D97FC43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 14:25:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8B5E40272;
	Fri, 26 Jun 2026 16:25:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id EBA5440264
 for <dev@dpdk.org>; Fri, 26 Jun 2026 16:25:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782483958; x=1814019958;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9t8cIps5SD01Mcuyhs5Wh4Z7GPYm+awxl/wMtesHRkk=;
 b=HFe2e7srEw48AVNuuMl4lm1ei431o659puR2wgmbtp8LsK37tsLxNAmO
 exhHnwlFDGT4eG2iSwnMOxTZIGYjW9NjKCll3NsKhK1QcyVqivXQTE0YS
 k6WlgGJAyYFWWaHnVcr9gJLXcEpycATNFiY7frQ3piSGXhHInFkddZdP4
 U9dYV3dpA+d+ZNDH6yAjmNn+cArG5V2lF5HA7hs9W1x9u1nP4D9tdomI1
 Usnedw2NPV4+7ezqTgwoCGItpkqhXUEcYgiB1HYQLP09JtjY5zlTvSci4
 yUPq/nzKAHhjuxGXs0kzevm8AD/c2QvsL0XQWuCBxQAAU4l+TMqF/lz1/ g==;
X-CSE-ConnectionGUID: v3SfoWxsQ9W0Qs0DpU3xfg==
X-CSE-MsgGUID: w/PrteqSRSuvsDuSZ9Bzxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="93630167"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="93630167"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 07:25:57 -0700
X-CSE-ConnectionGUID: 0UFcGakpR7KUgMJKICw7QQ==
X-CSE-MsgGUID: nUWwpQgNTSKjgbbNIox59g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="256238387"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 26 Jun 2026 07:25:56 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 1/1] net/iavf: workaround for IRQ map size mismatch
Date: Fri, 26 Jun 2026 15:25:54 +0100
Message-ID: <e6169c680b13cffce0ae58a4c14a90d860b63df1.1782483946.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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

Some out-of-tree ICE kernel driver versions have a known issue where they
expect size of IRQ queue vector map command to be bigger than needed, and
because the driver rejects the correct size as invalid, a workaround is
needed to send down a "wrong" size and configure the IRQ maps.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 30 ++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 0643a835d5..408ff31aa5 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -1566,7 +1566,8 @@ iavf_config_irq_map(struct iavf_adapter *adapter)
 static int
 iavf_config_irq_map_lv_chunk(struct iavf_adapter *adapter,
 		uint16_t chunk_sz,
-		uint16_t chunk_start)
+		uint16_t chunk_start,
+		bool wrong_size)
 {
 	struct {
 		struct virtchnl_queue_vector_maps map_info;
@@ -1593,9 +1594,19 @@ iavf_config_irq_map_lv_chunk(struct iavf_adapter *adapter,
 		qv_maps->vector_id = vf->qv_map[chunk_start + i].vector_id;
 	}
 
-	/* for some reason PF side checks for buffer being too big, so adjust it down */
-	buf_len = sizeof(struct virtchnl_queue_vector_maps) +
-		  sizeof(struct virtchnl_queue_vector) * (chunk_sz - 1);
+	/*
+	 * in out-of-tree kernel driver versions 2.6.4 and 2.6.6 there is a
+	 * known issue where the PF side expects the buffer size to be bigger
+	 * than necessary. this is a workaround for that issue.
+	 */
+	if (wrong_size)
+		/* send N+1 instead of N to workaround PF side bug */
+		buf_len = sizeof(struct virtchnl_queue_vector_maps) +
+			sizeof(struct virtchnl_queue_vector) * (chunk_sz);
+	else
+		/* virtchnl_queue_vector_maps already contains 1 queue_vector */
+		buf_len = sizeof(struct virtchnl_queue_vector_maps) +
+			sizeof(struct virtchnl_queue_vector) * (chunk_sz - 1);
 
 	args.ops = VIRTCHNL_OP_MAP_QUEUE_VECTOR;
 	args.in_args = (u8 *)map_info;
@@ -1609,12 +1620,21 @@ iavf_config_irq_map_lv_chunk(struct iavf_adapter *adapter,
 int
 iavf_config_irq_map_lv(struct iavf_adapter *adapter, uint16_t num)
 {
+	static bool wrong_size;
 	uint16_t c;
 	int err;
 
 	for (c = 0; c < num; c += IAVF_CFG_Q_NUM_PER_BUF) {
 		uint16_t chunk_sz = RTE_MIN(num - c, IAVF_CFG_Q_NUM_PER_BUF);
-		err = iavf_config_irq_map_lv_chunk(adapter, chunk_sz, c);
+		err = iavf_config_irq_map_lv_chunk(adapter, chunk_sz, c, wrong_size);
+		if (err) {
+			/* try workaround for a known issue */
+			err = iavf_config_irq_map_lv_chunk(adapter, chunk_sz, c, true);
+			if (err == 0) {
+				PMD_DRV_LOG(DEBUG, "Using workaround for IRQ map");
+				wrong_size = true;
+			}
+		}
 		if (err) {
 			PMD_DRV_LOG(ERR, "Failed to configure irq map chunk [%u, %u)",
 					c, c + chunk_sz);
-- 
2.47.3

