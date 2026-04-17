Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D94FB44C1
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Apr 2026 07:06:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A87E40279;
	Fri, 24 Apr 2026 09:05:51 +0200 (CEST)
Received: from send127.i.mail.ru (send127.i.mail.ru [89.221.237.222])
 by mails.dpdk.org (Postfix) with ESMTP id 59F80402A7;
 Fri, 17 Apr 2026 06:57:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
 To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
 X-Cloud-Ids:Disposition-Notification-To;
 bh=MSohjiOHAkOmAEzpwfqafntHHWJ0ntRz/SILxgb9iMY=; t=1776401825; x=1776491825; 
 b=Y996F3UTLnZlqSSRc6osbZEVVDkVK2q6pv5KQjLYDRSE68RSZVmpaz6BWQJPQaNaLTDaulSKvVN
 dgN99zXXfluNsvWseUNVUdID2D/ml1x4cTidj9ogpr8vJOZ2InV1RrTesVErdu+fvYVjjxwdncuSA
 T92TB7YcxLIobF0zLiP7sEPG7+M/mG5PCBp5BDeyk+Mixs+taUwiBM1FGNUABrj8DUSdAbUq3NxD6
 ccnzMiURRIrJigq8WijmMEo2WkalIdE1UQpgjxheEzHLp/KJc4AyXqB+pBrkwBc+dsiAMIdtQT0Qj
 hkO2gIc4xjrdbOcTmD7W3L0+kbL+nHQNjS6Q==;
Received: by exim-smtp-5c94f89c8c-zbf5h with esmtpa (envelope-from
 <lyulin.2003@mail.ru>)
 id 1wDbGJ-00000000Ckp-4Apf; Fri, 17 Apr 2026 07:57:04 +0300
From: Denis Lyulin <lyulin.2003@mail.ru>
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Denis Lyulin <lyulin.2003@mail.ru>
Subject: [PATCH 1/1] net/bnxt: fix string bounds checks and format specifiers
Date: Fri, 17 Apr 2026 07:56:40 +0300
Message-Id: <20260417045640.2217188-1-lyulin.2003@mail.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: exim-smtp-5c94f89c8c-zbf5h;
 auth=pass smtp.auth=lyulin.2003@mail.ru
 smtp.mailfrom=lyulin.2003@mail.ru
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD933EB536A6C38181627B29B63D3F79977216B5071BA23A618182A05F5380850404683CA09B035FDDB3DE06ABAFEAF6705EC9A1B93B08424D3FE3128867CF42871906DE0852CB239E4
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7793F2E9FD365C60AEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375663BEDCB502AD08FC071EC60F884721DA1FB232D3EE2DCFC3C81790E900794AF758EEF46B7454FC60B9742502CCDD46D0D1D471462564A2E19F6B57BC7E64490618DEB871D839B73339E8FC8737B5C2249A0EE70D6C4970CA7A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520B1593CA6EC85F86DF04B652EEC242312D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE042285CD7A5C321FD7C2347B1D03E769D8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE3CBD0204554ED7BDE040F9FF01DFDA4A8C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F79006379B9AD1D11E1099BBEFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A55F1507035303EAC15002B1117B3ED69604A6ACE71ED8578E3D2BBC1EF78EDEBE823CB91A9FED034534781492E4B8EEAD2739D626790C8313C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659B78A3B3F333A6DF833AC233FC4063CD4E5C77228B822E4A626C4820AB67170B08708B61DB3D8883CB8341EE9D5BE9A0A432E4ADE8DD858AAC5EAF9352878C67B7C5C17CAAC3FA0F8DABE3362BFED2FD64C41F94D744909CE5DDE6AB186FA14AA15C35E0BAFFE8D415811D22EBD454E4C3FCF178C6DD14203
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVbj/KpoGcZALfxpVkAxCIW8=
X-Mailru-Sender: C0FC423AA8FD9F6963CC77E2AC28C4C9D888F2C303653174B951B70A5BD4BD8ED549A7EE64DEA616454AC7A746402307CFB1E98417576B9F6EFAE8183A2EAE0DD521319575DF8831E3C55DE776B662A175379CF7CCB93CA93DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-Mailman-Approved-At: Fri, 24 Apr 2026 09:05:46 +0200
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

Some strings, primarily for memory zone names, could
exceed their buffer of size 32 (RTE_MEMZONE_NAMESIZE),
because PCI_PRI_FMT format string is not strictly limited in size.
This commit adds bounds checking via using snprintf instead
of sprintf. It also adds use of appropriate format specifiers,
which take width of integers in account.

Fixes: 02a95625fe9c ("net/bnxt: add flow stats in extended stats")
Cc: somnath.kotur@broadcom.com
Cc: stable@dpdk.org

Signed-off-by: Denis Lyulin <lyulin.2003@mail.ru>
---
 drivers/net/bnxt/bnxt_ethdev.c | 34 +++++++++++++++++++---------------
 drivers/net/bnxt/bnxt_hwrm.c   | 16 +++++++++-------
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index b677f9491d..bb02a2579b 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -652,8 +652,9 @@ static int bnxt_init_fc_ctx_mem(struct bnxt *bp)
 
 	max_fc = bp->flow_stat->max_fc;
 
-	sprintf(type, "bnxt_rx_fc_in_" PCI_PRI_FMT, pdev->addr.domain,
-		pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
+	snprintf(type, RTE_MEMZONE_NAMESIZE, "bnxt_rx_fc_in_" PCI_PRI_FMT,
+		pdev->addr.domain, pdev->addr.bus,
+		pdev->addr.devid, pdev->addr.function);
 	/* 4 bytes for each counter-id */
 	rc = bnxt_alloc_ctx_mem_buf(bp, type,
 				    max_fc * 4,
@@ -661,8 +662,9 @@ static int bnxt_init_fc_ctx_mem(struct bnxt *bp)
 	if (rc)
 		return rc;
 
-	sprintf(type, "bnxt_rx_fc_out_" PCI_PRI_FMT, pdev->addr.domain,
-		pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
+	snprintf(type, RTE_MEMZONE_NAMESIZE, "bnxt_rx_fc_out_" PCI_PRI_FMT,
+		pdev->addr.domain, pdev->addr.bus,
+		pdev->addr.devid, pdev->addr.function);
 	/* 16 bytes for each counter - 8 bytes pkt_count, 8 bytes byte_count */
 	rc = bnxt_alloc_ctx_mem_buf(bp, type,
 				    max_fc * 16,
@@ -670,8 +672,9 @@ static int bnxt_init_fc_ctx_mem(struct bnxt *bp)
 	if (rc)
 		return rc;
 
-	sprintf(type, "bnxt_tx_fc_in_" PCI_PRI_FMT, pdev->addr.domain,
-		pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
+	snprintf(type, RTE_MEMZONE_NAMESIZE, "bnxt_tx_fc_in_" PCI_PRI_FMT,
+		pdev->addr.domain, pdev->addr.bus,
+		pdev->addr.devid, pdev->addr.function);
 	/* 4 bytes for each counter-id */
 	rc = bnxt_alloc_ctx_mem_buf(bp, type,
 				    max_fc * 4,
@@ -679,8 +682,9 @@ static int bnxt_init_fc_ctx_mem(struct bnxt *bp)
 	if (rc)
 		return rc;
 
-	sprintf(type, "bnxt_tx_fc_out_" PCI_PRI_FMT, pdev->addr.domain,
-		pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
+	snprintf(type, RTE_MEMZONE_NAMESIZE, "bnxt_tx_fc_out_" PCI_PRI_FMT,
+		pdev->addr.domain, pdev->addr.bus,
+		pdev->addr.devid, pdev->addr.function);
 	/* 16 bytes for each counter - 8 bytes pkt_count, 8 bytes byte_count */
 	rc = bnxt_alloc_ctx_mem_buf(bp, type,
 				    max_fc * 16,
@@ -3252,7 +3256,7 @@ bnxt_fw_version_get(struct rte_eth_dev *dev, char *fw_version, size_t fw_size)
 	uint8_t fw_rsvd = bp->fw_ver & 0xff;
 	int ret;
 
-	ret = snprintf(fw_version, fw_size, "%d.%d.%d.%d",
+	ret = snprintf(fw_version, fw_size, "%hhu.%hhu.%hhu.%hhu",
 			fw_major, fw_minor, fw_updt, fw_rsvd);
 	if (ret < 0)
 		return -EINVAL;
@@ -5199,13 +5203,13 @@ static int bnxt_alloc_ctx_mem_blk(struct bnxt *bp,
 		RTE_ALIGN_MUL_CEIL(mem_size, BNXT_PAGE_SIZE) / BNXT_PAGE_SIZE;
 	rmem->page_size = BNXT_PAGE_SIZE;
 
-	snprintf(name, RTE_MEMZONE_NAMESIZE, "bnxt_ctx_pg_arr%s_%x_%d",
+	snprintf(name, RTE_MEMZONE_NAMESIZE, "bnxt_ctx_pg_arr%s_%hx_%hu",
 		 suffix, idx, bp->eth_dev->data->port_id);
 	ctx_pg->ctx_pg_arr = rte_zmalloc(name, sizeof(void *) * rmem->nr_pages, 0);
 	if (ctx_pg->ctx_pg_arr == NULL)
 		return -ENOMEM;
 
-	snprintf(name, RTE_MEMZONE_NAMESIZE, "bnxt_ctx_dma_arr%s_%x_%d",
+	snprintf(name, RTE_MEMZONE_NAMESIZE, "bnxt_ctx_dma_arr%s_%hx_%hu",
 		 suffix, idx, bp->eth_dev->data->port_id);
 	ctx_pg->ctx_dma_arr = rte_zmalloc(name, sizeof(rte_iova_t *) * rmem->nr_pages, 0);
 	if (ctx_pg->ctx_dma_arr == NULL)
@@ -5219,7 +5223,7 @@ static int bnxt_alloc_ctx_mem_blk(struct bnxt *bp,
 
 	if (rmem->nr_pages > 1) {
 		snprintf(name, RTE_MEMZONE_NAMESIZE,
-			 "bnxt_ctxpgtbl%s_%x_%d",
+			 "bnxt_ctxpgtbl%s_%hx_%hu",
 			 suffix, idx, bp->eth_dev->data->port_id);
 		name[RTE_MEMZONE_NAMESIZE - 1] = 0;
 		mz = rte_memzone_lookup(name);
@@ -5244,7 +5248,7 @@ static int bnxt_alloc_ctx_mem_blk(struct bnxt *bp,
 		rmem->pg_tbl_mz = mz;
 	}
 
-	snprintf(name, RTE_MEMZONE_NAMESIZE, "bnxt_ctx_%s_%x_%d",
+	snprintf(name, RTE_MEMZONE_NAMESIZE, "bnxt_ctx_%s_%hx_%hu",
 		 suffix, idx, bp->eth_dev->data->port_id);
 	mz = rte_memzone_lookup(name);
 	if (!mz) {
@@ -5393,7 +5397,7 @@ int bnxt_alloc_ctx_pg_tbls(struct bnxt *bp)
 		for (i = 0; i < w && rc == 0; i++) {
 			char name[RTE_MEMZONE_NAMESIZE] = {0};
 
-			sprintf(name, "_%d_%d", i, type);
+			snprintf(name, RTE_MEMZONE_NAMESIZE, "_%d_%hu", i, type);
 
 			if (ctxm->entry_multiple)
 				entries = bnxt_roundup(ctxm->max_entries,
@@ -6977,7 +6981,7 @@ static int bnxt_rep_port_probe(struct rte_pci_device *pci_dev,
 		}
 
 		/* representor port net_bdf_port */
-		snprintf(name, sizeof(name), "net_%s_representor_%d",
+		snprintf(name, sizeof(name), "net_%s_representor_%hu",
 			 pci_dev->device.name, eth_da->representor_ports[i]);
 
 		if (rte_eth_dev_allocated(name) != NULL) {
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 0c82935de9..5c51108b65 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -1693,7 +1693,8 @@ int bnxt_hwrm_ver_get(struct bnxt *bp, uint32_t timeout)
 	     (dev_caps_cfg &
 	      HWRM_VER_GET_OUTPUT_DEV_CAPS_CFG_SHORT_CMD_REQUIRED)) ||
 	    bp->hwrm_max_ext_req_len > HWRM_MAX_REQ_LEN) {
-		sprintf(type, "bnxt_hwrm_short_" PCI_PRI_FMT,
+		snprintf(type, RTE_MEMZONE_NAMESIZE,
+			"bnxt_hwrm_short_" PCI_PRI_FMT,
 			bp->pdev->addr.domain, bp->pdev->addr.bus,
 			bp->pdev->addr.devid, bp->pdev->addr.function);
 
@@ -3526,8 +3527,9 @@ int bnxt_alloc_hwrm_resources(struct bnxt *bp)
 	struct rte_pci_device *pdev = bp->pdev;
 	char type[RTE_MEMZONE_NAMESIZE];
 
-	sprintf(type, "bnxt_hwrm_" PCI_PRI_FMT, pdev->addr.domain,
-		pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
+	snprintf(type, RTE_MEMZONE_NAMESIZE, "bnxt_hwrm_" PCI_PRI_FMT,
+		pdev->addr.domain, pdev->addr.bus,
+		pdev->addr.devid, pdev->addr.function);
 	bp->max_resp_len = BNXT_PAGE_SIZE;
 	bp->hwrm_cmd_resp_addr = rte_malloc(type, bp->max_resp_len, 0);
 	if (bp->hwrm_cmd_resp_addr == NULL)
@@ -6573,7 +6575,7 @@ static int bnxt_alloc_all_ctx_pg_info(struct bnxt *bp)
 		if (ctxm->instance_bmap)
 			n = hweight32(ctxm->instance_bmap);
 
-		sprintf(name, "bnxt_ctx_pgmem_%d_%d",
+		snprintf(name, RTE_MEMZONE_NAMESIZE, "bnxt_ctx_pgmem_%hu_%hu",
 			bp->eth_dev->data->port_id, type);
 		ctxm->pg_info = rte_malloc(name, sizeof(*ctxm->pg_info) * n,
 					   RTE_CACHE_LINE_SIZE);
@@ -7535,7 +7537,7 @@ int bnxt_hwrm_cfa_pair_exists(struct bnxt *bp, struct bnxt_representor *rep_bp)
 	}
 
 	HWRM_PREP(&req, HWRM_CFA_PAIR_INFO, BNXT_USE_CHIMP_MB);
-	snprintf(req.pair_name, sizeof(req.pair_name), "%svfr%d",
+	snprintf(req.pair_name, sizeof(req.pair_name), "%svfr%hu",
 		 bp->eth_dev->data->name, rep_bp->vf_id);
 	req.flags =
 		rte_cpu_to_le_32(HWRM_CFA_PAIR_INFO_INPUT_FLAGS_LOOKUP_TYPE);
@@ -7564,7 +7566,7 @@ int bnxt_hwrm_cfa_pair_alloc(struct bnxt *bp, struct bnxt_representor *rep_bp)
 
 	HWRM_PREP(&req, HWRM_CFA_PAIR_ALLOC, BNXT_USE_CHIMP_MB);
 	req.pair_mode = HWRM_CFA_PAIR_FREE_INPUT_PAIR_MODE_REP2FN_TRUFLOW;
-	snprintf(req.pair_name, sizeof(req.pair_name), "%svfr%d",
+	snprintf(req.pair_name, sizeof(req.pair_name), "%svfr%hu",
 		 bp->eth_dev->data->name, rep_bp->vf_id);
 
 	req.pf_b_id = rep_bp->parent_pf_idx;
@@ -7609,7 +7611,7 @@ int bnxt_hwrm_cfa_pair_free(struct bnxt *bp, struct bnxt_representor *rep_bp)
 	}
 
 	HWRM_PREP(&req, HWRM_CFA_PAIR_FREE, BNXT_USE_CHIMP_MB);
-	snprintf(req.pair_name, sizeof(req.pair_name), "%svfr%d",
+	snprintf(req.pair_name, sizeof(req.pair_name), "%svfr%hu",
 		 bp->eth_dev->data->name, rep_bp->vf_id);
 	req.pf_b_id = rep_bp->parent_pf_idx;
 	req.pair_mode = HWRM_CFA_PAIR_FREE_INPUT_PAIR_MODE_REP2FN_TRUFLOW;
-- 
2.34.1

