Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2913CD98DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 16:27:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9392640693;
	Mon, 15 Jun 2026 18:27:21 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 381E9406B4;
 Mon, 15 Jun 2026 18:27:20 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFbN2c279859; Mon, 15 Jun 2026 09:27:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=R
 1k1MzUPc45TnaELY0eG8LxEgBVihn2KOrDiKvRkiMY=; b=kQlvmr96RjKhMOUXe
 KzN3ZS2NbCzjQLMG7goLpH6ITGfVmb7cW2stW4w/npZDKH1YeJ1MgqgiNgLka7if
 6j93uQAk79Yoel9M4tLDymE77MeFfrmlQgQBroOBY1jeuPmHJeBYNztsZ2c+L/RW
 2G9YJ17cp2RvphWUrt1LDmeNxITp9aOuxNhEGwSUauzKHSLU774wJGCr2nvWvrhK
 0xgOv48v8EP/rqMm0Lt8IdyYV4GgvIhip9eIE2puQrmNvam/6fA6ZATscXtin0az
 153TCRBQ8o8vt/kt8bqBJxwyvwtxzsVLFcCAUHfkbApN33FnbqgyWAWlUHgFTUuk
 dUjDg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4esuf8vpr8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 09:27:18 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 15 Jun 2026 09:27:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 15 Jun 2026 09:27:17 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 388D43F7070;
 Mon, 15 Jun 2026 09:27:13 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Satheesh Paul
 <psatheesh@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>
CC: Aarnav JP <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v3 16/20] common/cnxk: fix Klocwork static analysis issues
Date: Mon, 15 Jun 2026 21:54:42 +0530
Message-ID: <20260615162446.578336-16-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260615162446.578336-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260615162446.578336-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX6YNKQ8tACi95
 xQYnw1LrwihtfQKEaRa3NRFGbvenym6/ul7bCHH8ugonll1lPr/R9WYGDP7oRYSBt1Nf+YTO8y3
 K5SFvK7ijDSAHhQiQiEcn0T62QgD0Fk0w7j20wOZAZ0L/0GNb4MkziPagTTNE3+6suklZDVwWms
 bkUsKKnkxHsl4PDTj6pQDuy2ZXLPZLZCDApuD/ZpJthrw2j+5+IyAbaozMbldMeelxC0hzA1CHO
 KZUjLwQRdPOGPM5eD5Ly2VRzcLmv2uV3FJX16o+BAr1PQ1iPr06VOnUUq7wjgfLB9yNLnGsI3uP
 l4Ex5+cHrxAGAiIwUA6EFv3NYDxyy0T0e+FkpQy4yiz9kG4bOjoACeRft5tEZJWnCUpMmaBbT0P
 QjSxjHgifMCWs1aYHqg3IBRiM+SrcZTXiwjs5nEy+rVSgQ9pVLhb8u4l2sAfszB+MLwOtXbTWCF
 nj//o4bciNbDe+hnwIA==
X-Proofpoint-ORIG-GUID: c0oYcXFEheweRz8IaYg70uu9XjLDu0jf
X-Proofpoint-GUID: c0oYcXFEheweRz8IaYg70uu9XjLDu0jf
X-Authority-Analysis: v=2.4 cv=KJZqylFo c=1 sm=1 tr=0 ts=6a3027e7 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=qwpVHXkZySjjlazszK4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX8+oOT/IC3zRn
 6zukFOReX2mb0iJ2QvbFNmJG306ACCZ03ZaR+Be53PXNR0/0USeI3brh0LXeLMCi9TFoLTaR6O7
 pz/PNsNqSmnUKwndNKzNI5/ka99F5Qk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
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

From: Aarnav JP <ajp@marvell.com>

Fix NULL pointer dereferences (roc_dev.c, roc_npa.c, roc_nix_inl.c),
resource leaks in error paths (roc_dev.c, roc_dpi.c, roc_ree.c,
roc_nix.c, roc_emdev.c), uninitialized variables (roc_npa_debug.c,
roc_emdev.c), array out-of-bounds access (roc_npc_utils.c, roc_emdev.c),
bitwise operand size mismatches (roc_mbox.h, roc_emdev_irq.c), and
format string type mismatches (roc_cpt_debug.c).

Fixes: 5d8ff275433a ("common/cnxk: fix race condition between up and down mailbox")
Fixes: 9a92937cf0c8 ("common/cnxk: fix possible out-of-bounds access")
Fixes: 7557e3f5b9fa ("common/cnxk: replace direct API usage in REE")
Fixes: 3fdf3e53f3c4 ("common/cnxk: enable CPT CQ for inline IPsec inbound")
Fixes: c758279fee32 ("common/cnxk: support debug dump to file")
Cc: stable@dpdk.org

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
Changes in v3: No change.
Changes in v2: No change.

 drivers/common/cnxk/roc_cpt_debug.c | 29 ++++++++++++++---------------
 drivers/common/cnxk/roc_dev.c       | 15 +++++++++++----
 drivers/common/cnxk/roc_mbox.h      |  4 ++--
 drivers/common/cnxk/roc_nix_inl.c   |  3 +--
 drivers/common/cnxk/roc_npa.c       |  3 +++
 drivers/common/cnxk/roc_npa_debug.c |  8 +++++++-
 drivers/common/cnxk/roc_npc_utils.c | 10 +++++++---
 drivers/common/cnxk/roc_ree.c       | 17 ++++++++++++-----
 8 files changed, 57 insertions(+), 32 deletions(-)

diff --git a/drivers/common/cnxk/roc_cpt_debug.c b/drivers/common/cnxk/roc_cpt_debug.c
index 3b3e678c20..3c1c052e50 100644
--- a/drivers/common/cnxk/roc_cpt_debug.c
+++ b/drivers/common/cnxk/roc_cpt_debug.c
@@ -33,7 +33,7 @@ cpt_cnxk_parse_hdr_dump(FILE *file, const struct cpt_parse_hdr_s *cpth)
 		 cpth->w0.num_frags, cpth->w0.pkt_out);

 	/* W1 */
-	cpt_dump(file, "W1: wqe_ptr \t0x%016lx\t", cpth->wqe_ptr);
+	cpt_dump(file, "W1: wqe_ptr \t0x%016" PRIx64 "\t", cpth->wqe_ptr);

 	/* W2 */
 	cpt_dump(file, "W2: pkt_inline \t0x%x\t\torig_pkt_aura \t0x%x", cpth->w2.pkt_inline,
@@ -135,29 +135,28 @@ cpt_cn10k_parse_hdr_dump(FILE *file, const struct cpt_cn10k_parse_hdr_s *cpth)
 	cpt_dump(file, "W0: cookie \t0x%x\t\tmatch_id \t0x%04x \t",
 		  cpth->w0.cookie, cpth->w0.match_id);
 	cpt_dump(file, "W0: err_sum \t%u \t", cpth->w0.err_sum);
-	cpt_dump(file, "W0: reas_sts \t0x%x\t\tet_owr \t%u\t\tpkt_fmt \t%u \t",
-		  cpth->w0.reas_sts, cpth->w0.et_owr, cpth->w0.pkt_fmt);
-	cpt_dump(file, "W0: pad_len \t%u\t\tnum_frags \t%u\t\tpkt_out \t%u \t",
-		  cpth->w0.pad_len, cpth->w0.num_frags, cpth->w0.pkt_out);
+	cpt_dump(file, "W0: reas_sts \t0x%x\t\tet_owr \t%u\t\tpkt_fmt \t%u \t", cpth->w0.reas_sts,
+		 cpth->w0.et_owr, cpth->w0.pkt_fmt);
+	cpt_dump(file, "W0: pad_len \t%u\t\tnum_frags \t%u\t\tpkt_out \t%u \t", cpth->w0.pad_len,
+		 cpth->w0.num_frags, cpth->w0.pkt_out);

 	/* W1 */
-	cpt_dump(file, "W1: wqe_ptr \t0x%016lx\t",
-			plt_be_to_cpu_64(cpth->wqe_ptr));
+	cpt_dump(file, "W1: wqe_ptr \t0x%016" PRIx64 "\t",
+		 (uint64_t)plt_be_to_cpu_64(cpth->wqe_ptr));

 	/* W2 */
-	cpt_dump(file, "W2: frag_age \t0x%x\t\torig_pf_func \t0x%04x",
-		  cpth->w2.frag_age, cpth->w2.orig_pf_func);
-	cpt_dump(file, "W2: il3_off \t0x%x\t\tfi_pad \t0x%x \t",
-		  cpth->w2.il3_off, cpth->w2.fi_pad);
+	cpt_dump(file, "W2: frag_age \t0x%x\t\torig_pf_func \t0x%04x", cpth->w2.frag_age,
+		 cpth->w2.orig_pf_func);
+	cpt_dump(file, "W2: il3_off \t0x%x\t\tfi_pad \t0x%x \t", cpth->w2.il3_off, cpth->w2.fi_pad);
 	cpt_dump(file, "W2: fi_offset \t0x%x \t", cpth->w2.fi_offset);

 	/* W3 */
-	cpt_dump(file, "W3: hw_ccode \t0x%x\t\tuc_ccode \t0x%x\t\tspi \t0x%08x",
-		  cpth->w3.hw_ccode, cpth->w3.uc_ccode, cpth->w3.spi);
+	cpt_dump(file, "W3: hw_ccode \t0x%x\t\tuc_ccode \t0x%x\t\tspi \t0x%08x", cpth->w3.hw_ccode,
+		 cpth->w3.uc_ccode, cpth->w3.spi);

 	/* W4 */
-	cpt_dump(file, "W4: esn \t%" PRIx64 " \t OR frag1_wqe_ptr \t0x%" PRIx64,
-		  cpth->esn, plt_be_to_cpu_64(cpth->frag1_wqe_ptr));
+	cpt_dump(file, "W4: esn \t%" PRIx64 " \t OR frag1_wqe_ptr \t0x%" PRIx64, cpth->esn,
+		 (uint64_t)plt_be_to_cpu_64(cpth->frag1_wqe_ptr));

 	/* offset of 0 implies 256B, otherwise it implies offset*8B */
 	offset = cpth->w2.fi_offset;
diff --git a/drivers/common/cnxk/roc_dev.c b/drivers/common/cnxk/roc_dev.c
index 32409f2ef3..61aa4b3075 100644
--- a/drivers/common/cnxk/roc_dev.c
+++ b/drivers/common/cnxk/roc_dev.c
@@ -1796,14 +1796,17 @@ dev_init(struct dev *dev, struct plt_pci_device *pci_dev)

 	rc = npa_lf_init(dev, pci_dev);
 	if (rc)
-		goto stop_msg_thrd;
+		goto vf_flr_unregister;

 	/* Setup LMT line base */
 	rc = dev_lmt_setup(dev);
 	if (rc)
-		goto stop_msg_thrd;
+		goto vf_flr_unregister;

 	return rc;
+vf_flr_unregister:
+	if (!is_vf)
+		dev_vf_flr_unregister_irqs(pci_dev, dev);
 stop_msg_thrd:
 	/* Exiting the mbox sync thread */
 	if (dev->sync.start_thread) {
@@ -1812,10 +1815,14 @@ dev_init(struct dev *dev, struct plt_pci_device *pci_dev)
 		plt_thread_join(dev->sync.pfvf_msg_thread, NULL);
 	}
 thread_fail:
-	pthread_mutex_destroy(&dev->sync.mutex);
-	pthread_cond_destroy(&dev->sync.pfvf_msg_cond);
+	if (pci_dev->max_vfs > 0) {
+		pthread_mutex_destroy(&dev->sync.mutex);
+		pthread_cond_destroy(&dev->sync.pfvf_msg_cond);
+	}
 iounmap:
 	dev_vf_mbase_put(pci_dev, vf_mbase);
+	mbox_fini(&dev->mbox_vfpf);
+	mbox_fini(&dev->mbox_vfpf_up);
 mbox_unregister:
 	dev_mbox_unregister_irq(pci_dev, dev);
 	if (dev->ops)
diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index 1158ff50a7..52ecde6563 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -47,8 +47,8 @@ struct mbox_msghdr {
 #define RVU_VF_VFPF_MBOX0 (0x0000)
 #define RVU_VF_VFPF_MBOX1 (0x0008)

-#define MBOX_DOWN_MSG 1
-#define MBOX_UP_MSG   2
+#define MBOX_DOWN_MSG 1ULL
+#define MBOX_UP_MSG   2ULL

 /* Mailbox message types */
 #define MBOX_MSG_MASK	 0xFFFF
diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index b515d52534..db101e71a5 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -638,9 +638,8 @@ nix_inl_reass_inb_sa_tbl_setup(struct roc_nix *roc_nix)
 		res_addr_offset = (uint64_t)(inl_dev->res_addr_offset & 0xFF) << 48;
 		if (res_addr_offset)
 			res_addr_offset |= (1UL << 56);
+		cpt_cq_ena = (uint64_t)inl_dev->cpt_cq_ena << 63;
 	}
-
-	cpt_cq_ena = (uint64_t)inl_dev->cpt_cq_ena << 63;
 	lf_cfg->enable = 1;
 	lf_cfg->profile_id = profile_id;
 	lf_cfg->rx_inline_sa_base = (uintptr_t)nix->inb_sa_base[profile_id] | cpt_cq_ena;
diff --git a/drivers/common/cnxk/roc_npa.c b/drivers/common/cnxk/roc_npa.c
index 88e328105a..4a3e96a97a 100644
--- a/drivers/common/cnxk/roc_npa.c
+++ b/drivers/common/cnxk/roc_npa.c
@@ -1113,6 +1113,9 @@ roc_npa_pool_destroy(uint64_t aura_handle)
 	struct npa_lf *lf = idev_npa_obj_get();
 	int rc = 0, aura_id;

+	if (lf == NULL)
+		return NPA_ERR_DEVICE_NOT_BOUNDED;
+
 	plt_npa_dbg("lf=%p aura_handle=0x%" PRIx64, lf, aura_handle);
 	aura_id = roc_npa_aura_handle_to_aura(aura_handle);

diff --git a/drivers/common/cnxk/roc_npa_debug.c b/drivers/common/cnxk/roc_npa_debug.c
index e64696730f..f978be9642 100644
--- a/drivers/common/cnxk/roc_npa_debug.c
+++ b/drivers/common/cnxk/roc_npa_debug.c
@@ -283,6 +283,9 @@ roc_npa_ctx_dump(void)
 		if (lf->aura_attr[q].halo) {
 			aq->ctype = NPA_AQ_CTYPE_HALO;
 			rc = mbox_process_msg(mbox, (void *)&rsp_cn20k);
+		} else if (roc_model_is_cn20k()) {
+			aq->ctype = NPA_AQ_CTYPE_AURA;
+			rc = mbox_process_msg(mbox, (void *)&rsp_cn20k);
 		} else {
 			aq->ctype = NPA_AQ_CTYPE_AURA;
 			rc = mbox_process_msg(mbox, (void *)&rsp);
@@ -323,7 +326,10 @@ roc_npa_ctx_dump(void)
 		aq->ctype = NPA_AQ_CTYPE_POOL;
 		aq->op = NPA_AQ_INSTOP_READ;

-		rc = mbox_process_msg(mbox, (void *)&rsp);
+		if (roc_model_is_cn20k())
+			rc = mbox_process_msg(mbox, (void *)&rsp_cn20k);
+		else
+			rc = mbox_process_msg(mbox, (void *)&rsp);
 		if (rc) {
 			plt_err("Failed to get pool(%d) context", q);
 			goto exit;
diff --git a/drivers/common/cnxk/roc_npc_utils.c b/drivers/common/cnxk/roc_npc_utils.c
index 3c05e46e1b..8e83b8662d 100644
--- a/drivers/common/cnxk/roc_npc_utils.c
+++ b/drivers/common/cnxk/roc_npc_utils.c
@@ -486,7 +486,7 @@ npc_process_ipv6_field_hash_o20k(const struct roc_npc_flow_item_ipv6 *ipv6_spec,
 	uint8_t hash_field[ROC_IPV6_ADDR_LEN];
 	struct npc_xtract_info *xinfo;
 	uint32_t hash = 0, mask;
-	int intf, i, rc = 0;
+	int intf, i, hash_idx = 0, rc = 0;

 	memset(hash_field, 0, sizeof(hash_field));

@@ -505,14 +505,18 @@ npc_process_ipv6_field_hash_o20k(const struct roc_npc_flow_item_ipv6 *ipv6_spec,
 		if (rc == 0)
 			continue;

-		rc = npc_ipv6_field_hash_get(pst->npc, (const uint32_t *)hash_field, intf, i,
-					     &hash);
+		if (hash_idx >= NPC_MAX_HASH)
+			break;
+
+		rc = npc_ipv6_field_hash_get(pst->npc, (const uint32_t *)hash_field, intf,
+					     hash_idx, &hash);
 		if (rc)
 			return rc;

 		mask = GENMASK(31, 0);
 		memcpy(pst->mcam_mask + xinfo->key_off, (uint8_t *)&mask, 4);
 		memcpy(pst->mcam_data + xinfo->key_off, (uint8_t *)&hash, 4);
+		hash_idx++;
 	}

 	return 0;
diff --git a/drivers/common/cnxk/roc_ree.c b/drivers/common/cnxk/roc_ree.c
index b6392658c3..923d9251ad 100644
--- a/drivers/common/cnxk/roc_ree.c
+++ b/drivers/common/cnxk/roc_ree.c
@@ -592,14 +592,15 @@ roc_ree_dev_init(struct roc_ree_vf *vf)
 	vf->block_address = ree_get_blkaddr(dev);
 	if (!vf->block_address) {
 		plt_err("Could not determine block PF number");
-		goto fail;
+		rc = -ENODEV;
+		goto dev_fini;
 	}

 	/* Get number of queues available on the device */
 	rc = roc_ree_available_queues_get(vf, &nb_queues);
 	if (rc) {
 		plt_err("Could not determine the number of queues available");
-		goto fail;
+		goto dev_fini;
 	}

 	/* Don't exceed the limits set per VF */
@@ -607,7 +608,8 @@ roc_ree_dev_init(struct roc_ree_vf *vf)

 	if (nb_queues == 0) {
 		plt_err("No free queues available on the device");
-		goto fail;
+		rc = -ENOSPC;
+		goto dev_fini;
 	}

 	vf->max_queues = nb_queues;
@@ -618,18 +620,23 @@ roc_ree_dev_init(struct roc_ree_vf *vf)
 	rc = roc_ree_max_matches_get(vf, &max_matches);
 	if (rc) {
 		plt_err("Could not determine the maximum matches supported");
-		goto fail;
+		goto dev_fini;
 	}
 	/* Don't exceed the limits set per VF */
 	max_matches = RTE_MIN(max_matches, REE_MAX_MATCHES_PER_VF);
 	if (max_matches == 0) {
 		plt_err("Could not determine the maximum matches supported");
-		goto fail;
+		rc = -EIO;
+		goto dev_fini;
 	}

 	vf->max_matches = max_matches;

 	plt_ree_dbg("Max matches supported by device: %d", vf->max_matches);
+
+	return 0;
+dev_fini:
+	dev_fini(dev, pci_dev);
 fail:
 	return rc;
 }
--
2.34.1

