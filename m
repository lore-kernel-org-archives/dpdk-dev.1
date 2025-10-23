Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEE0CCD193
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 17:28:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08D1640695;
	Thu, 23 Oct 2025 19:28:08 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1298640648
 for <dev@dpdk.org>; Thu, 23 Oct 2025 19:28:05 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3ck2b021882
 for <dev@dpdk.org>; Thu, 23 Oct 2025 10:28:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=X
 wU/pNSUY+ujC0mmeUsTusYc0ve6rzw5CzzEcpM3cns=; b=K7UT8SAVgutSLUw+0
 e+XvY4Uiea8R6jIyg76z+6VNTKrxHPInjYKNShRiJbTrC1QdDlJDioJz9en2y3Cl
 kxddk2tIjzbnGSMJjFhIrOYrpk2Fjxeaha7hWsU3RuRHUKNn+T5WT1t1y+HbvMJe
 IuWQKLSolyhmcjMQsXY1L9mOMBIhfYYgwhzb8URv1A5VvfrX44EuO39+kp5Kdxit
 +GQUgBtgC8/J/ztcY0ytp2QVTJa8ZwVodCtnjgt6zhpWvAwRT8zE7TMjP1k2Tnhv
 X4SOqq7sWSiP7JdHbNJB4rA1vTLcQEAKWt5O6NxxL4srPI1xCHoOYzRFs9sIFOCL
 ND6Ow==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49ycmr1w80-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 23 Oct 2025 10:28:05 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 10:28:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 10:28:13 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 333B73F7068;
 Thu, 23 Oct 2025 10:28:01 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v3 11/19] common/cnxk: add API to configure backpressure on
 pool
Date: Thu, 23 Oct 2025 22:57:19 +0530
Message-ID: <20251023172728.770661-11-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023172728.770661-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251023172728.770661-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FTeNciK0VCNF5dQ9vbEoPIUu4GHyylHS
X-Proofpoint-GUID: FTeNciK0VCNF5dQ9vbEoPIUu4GHyylHS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDAzMCBTYWx0ZWRfX4+dTXANWfT1S
 QJvFVfCVm2VjLenLXBZCKfk4hLx2Ia9eM8M1KLgnx315WpyYwvpSH+3eogGJ03Hr5nwdjX1WH7I
 EbuYe4Ln2iRXXHIwRHUHzVITbiEUmSs/XGHaycBPdbj9G9vfeewung5xVTbYvxfQlA2pEON7lzA
 78q0AWn74SJqw/m1bP1nCMG8cyneHtdpH8dZ2gSupZQJUidnjvC8geDakO7cY8BchMHEhcNtfA+
 9o8VMrLEALJvK7oYpK/SzjH2QfArkn1BbQOhKUlIT/7YNfvM32FcDrTUC7XeKtSGqOZEXU90s1j
 kP4vwUP6T6WTDGpJAGs0FRC3cMvjMBViqDpabJqCZ1ZsnHctOG1LllYqi8i9WjBif/vhtxFKTkx
 v/T8LdxcyV+QhutYBZuaOd69Ua6QWw==
X-Authority-Analysis: v=2.4 cv=CtSys34D c=1 sm=1 tr=0 ts=68fa65a5 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=03JoLBskd-D1nsHkPrkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
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

From: Sunil Kumar Kori <skori@marvell.com>

On CN20K platform, backpressure can be configured for eight
different traffic classes per pool along with threshold and
BPIDs.

RoC API is added to configure the same.

Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
---
 drivers/common/cnxk/roc_nix.h                 |   1 +
 drivers/common/cnxk/roc_nix_fc.c              |  60 +++++++
 drivers/common/cnxk/roc_npa.c                 | 155 +++++++++++++++++-
 drivers/common/cnxk/roc_npa.h                 |   2 +
 drivers/common/cnxk/roc_npa_priv.h            |   5 +-
 .../common/cnxk/roc_platform_base_symbols.c   |   1 +
 6 files changed, 222 insertions(+), 2 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index e070db1baa..274ece68a9 100644
--- a/drivers/common/cnxk/roc_nix.h
+++ b/drivers/common/cnxk/roc_nix.h
@@ -507,6 +507,7 @@ struct roc_nix {
 	uint16_t rep_cnt;
 	uint16_t rep_pfvf_map[MAX_PFVF_REP];
 	bool reass_ena;
+	bool use_multi_bpids;
 	TAILQ_ENTRY(roc_nix) next;
 
 #define ROC_NIX_MEM_SZ (6 * 1112)
diff --git a/drivers/common/cnxk/roc_nix_fc.c b/drivers/common/cnxk/roc_nix_fc.c
index e35c993f96..ddabd15a5d 100644
--- a/drivers/common/cnxk/roc_nix_fc.c
+++ b/drivers/common/cnxk/roc_nix_fc.c
@@ -549,6 +549,61 @@ nix_rx_chan_multi_bpid_cfg(struct roc_nix *roc_nix, uint8_t chan, uint16_t bpid,
 
 #define NIX_BPID_INVALID 0xFFFF
 
+static void
+nix_fc_npa_multi_bp_cfg(struct roc_nix *roc_nix, uint64_t pool_handle, uint8_t ena, uint8_t force,
+			uint8_t tc, uint64_t drop_percent)
+{
+	uint32_t pool_id = roc_npa_aura_handle_to_aura(pool_handle);
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	struct npa_lf *lf = idev_npa_obj_get();
+	struct npa_aura_attr *aura_attr;
+	uint8_t bp_thresh, bp_ena;
+	uint16_t bpid;
+	int i;
+
+	if (!lf)
+		return;
+
+	aura_attr = &lf->aura_attr[pool_id];
+
+	bp_thresh = NIX_RQ_AURA_BP_THRESH(drop_percent, aura_attr->limit, aura_attr->shift);
+	bpid = aura_attr->nix0_bpid;
+	bp_ena = aura_attr->bp_ena;
+
+	/* BP is already enabled. */
+	if ((bp_ena & (0x1 << tc)) && ena) {
+		if (bp_thresh != aura_attr->bp_thresh[tc]) {
+			if (roc_npa_pool_bp_configure(pool_id, nix->bpid[0], bp_thresh, tc, true))
+				plt_err("Enabling backpressue failed on pool 0x%" PRIx32, pool_id);
+		} else {
+			aura_attr->ref_count++;
+		}
+
+		return;
+	}
+
+	if (ena) {
+		if (roc_npa_pool_bp_configure(pool_id, nix->bpid[0], bp_thresh, tc, true))
+			plt_err("Enabling backpressue failed on pool 0x%" PRIx32, pool_id);
+		else
+			aura_attr->ref_count++;
+	} else {
+		bool found = !!force;
+
+		/* Don't disable if existing BPID is not within this port's list */
+		for (i = 0; i < nix->chan_cnt; i++)
+			if (bpid == nix->bpid[i])
+				found = true;
+		if (!found)
+			return;
+		else if ((aura_attr->ref_count > 0) && --(aura_attr->ref_count))
+			return;
+
+		if (roc_npa_pool_bp_configure(pool_id, 0, 0, 0, false))
+			plt_err("Disabling backpressue failed on pool 0x%" PRIx32, pool_id);
+	}
+}
+
 void
 roc_nix_fc_npa_bp_cfg(struct roc_nix *roc_nix, uint64_t pool_id, uint8_t ena, uint8_t force,
 		      uint8_t tc, uint64_t drop_percent)
@@ -567,6 +622,11 @@ roc_nix_fc_npa_bp_cfg(struct roc_nix *roc_nix, uint64_t pool_id, uint8_t ena, ui
 	if (!lf)
 		return;
 
+	if (roc_model_is_cn20k() && roc_nix->use_multi_bpids) {
+		nix_fc_npa_multi_bp_cfg(roc_nix, pool_id, ena, force, tc, drop_percent);
+		return;
+	}
+
 	aura_attr = &lf->aura_attr[aura_id];
 
 	bp_intf = 1 << nix->is_nix1;
diff --git a/drivers/common/cnxk/roc_npa.c b/drivers/common/cnxk/roc_npa.c
index d5ebfbfc11..f9824f6656 100644
--- a/drivers/common/cnxk/roc_npa.c
+++ b/drivers/common/cnxk/roc_npa.c
@@ -172,10 +172,47 @@ npa_aura_init(struct mbox *m_box, uint32_t aura_id, struct npa_aura_s *aura)
 	return rc;
 }
 
+static inline void
+npa_pool_multi_bp_reset(struct npa_cn20k_aq_enq_req *pool_req)
+{
+	pool_req->pool.bp_0 = 0;
+	pool_req->pool.bp_1 = 0;
+	pool_req->pool.bp_2 = 0;
+	pool_req->pool.bp_3 = 0;
+	pool_req->pool.bp_4 = 0;
+	pool_req->pool.bp_5 = 0;
+	pool_req->pool.bp_6 = 0;
+	pool_req->pool.bp_7 = 0;
+	pool_req->pool.bp_ena_0 = 0;
+	pool_req->pool.bp_ena_1 = 0;
+	pool_req->pool.bp_ena_2 = 0;
+	pool_req->pool.bp_ena_3 = 0;
+	pool_req->pool.bp_ena_4 = 0;
+	pool_req->pool.bp_ena_5 = 0;
+	pool_req->pool.bp_ena_6 = 0;
+	pool_req->pool.bp_ena_7 = 0;
+	pool_req->pool_mask.bp_0 = ~(pool_req->pool_mask.bp_0);
+	pool_req->pool_mask.bp_1 = ~(pool_req->pool_mask.bp_1);
+	pool_req->pool_mask.bp_2 = ~(pool_req->pool_mask.bp_2);
+	pool_req->pool_mask.bp_3 = ~(pool_req->pool_mask.bp_3);
+	pool_req->pool_mask.bp_4 = ~(pool_req->pool_mask.bp_4);
+	pool_req->pool_mask.bp_5 = ~(pool_req->pool_mask.bp_5);
+	pool_req->pool_mask.bp_6 = ~(pool_req->pool_mask.bp_6);
+	pool_req->pool_mask.bp_7 = ~(pool_req->pool_mask.bp_7);
+	pool_req->pool_mask.bp_ena_0 = ~(pool_req->pool_mask.bp_ena_0);
+	pool_req->pool_mask.bp_ena_1 = ~(pool_req->pool_mask.bp_ena_1);
+	pool_req->pool_mask.bp_ena_2 = ~(pool_req->pool_mask.bp_ena_2);
+	pool_req->pool_mask.bp_ena_3 = ~(pool_req->pool_mask.bp_ena_3);
+	pool_req->pool_mask.bp_ena_4 = ~(pool_req->pool_mask.bp_ena_4);
+	pool_req->pool_mask.bp_ena_5 = ~(pool_req->pool_mask.bp_ena_5);
+	pool_req->pool_mask.bp_ena_6 = ~(pool_req->pool_mask.bp_ena_6);
+	pool_req->pool_mask.bp_ena_7 = ~(pool_req->pool_mask.bp_ena_7);
+}
+
 static int
 npa_aura_pool_fini(struct mbox *m_box, uint32_t aura_id, uint64_t aura_handle)
 {
-	struct npa_cn20k_aq_enq_req *aura_req_cn20k, *pool_req_cn20k;
+	struct npa_cn20k_aq_enq_req *aura_req_cn20k, *pool_req_cn20k = NULL;
 	struct npa_aq_enq_req *aura_req, *pool_req;
 	struct npa_aq_enq_rsp *aura_rsp, *pool_rsp;
 	struct mbox_dev *mdev = &m_box->dev[0];
@@ -201,6 +238,10 @@ npa_aura_pool_fini(struct mbox *m_box, uint32_t aura_id, uint64_t aura_handle)
 	}
 	if (pool_req == NULL)
 		goto exit;
+
+	/* Disable backpressure on pool on CN20K */
+	if (roc_model_is_cn20k())
+		npa_pool_multi_bp_reset(pool_req_cn20k);
 	pool_req->aura_id = aura_id;
 	pool_req->ctype = NPA_AQ_CTYPE_POOL;
 	pool_req->op = NPA_AQ_INSTOP_WRITE;
@@ -983,6 +1024,118 @@ roc_npa_zero_aura_handle(void)
 	return 0;
 }
 
+int
+roc_npa_pool_bp_configure(uint64_t aura_handle, uint16_t bpid, uint8_t bp_thresh, uint8_t bp_class,
+			  bool enable)
+{
+	uint32_t pool_id = roc_npa_aura_handle_to_aura(aura_handle);
+	struct npa_lf *lf = idev_npa_obj_get();
+	struct npa_cn20k_aq_enq_req *aq;
+	uint8_t bp, bp_ena;
+	struct mbox *mbox;
+	int rc = 0;
+
+	plt_npa_dbg("Setting BPID %u BP_CLASS %u enable %u on pool %" PRIx64, bpid, bp_class,
+		    bp_thresh, aura_handle);
+
+	if (lf == NULL)
+		return NPA_ERR_PARAM;
+
+	mbox = mbox_get(lf->mbox);
+	aq = mbox_alloc_msg_npa_cn20k_aq_enq(mbox);
+	if (aq == NULL) {
+		rc = -ENOSPC;
+		goto fail;
+	}
+
+	aq->aura_id = pool_id;
+	aq->ctype = NPA_AQ_CTYPE_POOL;
+	aq->op = NPA_AQ_INSTOP_WRITE;
+
+	if (enable) {
+		aq->pool.bpid_0 = bpid;
+		aq->pool_mask.bpid_0 = ~(aq->pool_mask.bpid_0);
+
+		bp = bp_thresh;
+	} else {
+		bp = 0;
+	}
+
+	switch (bp_class) {
+	case 0:
+		aq->pool.bp_0 = bp;
+		aq->pool_mask.bp_0 = ~(aq->pool_mask.bp_0);
+		aq->pool.bp_ena_0 = enable;
+		aq->pool_mask.bp_ena_0 = ~(aq->pool_mask.bp_ena_0);
+		break;
+	case 1:
+		aq->pool.bp_1 = bp;
+		aq->pool_mask.bp_1 = ~(aq->pool_mask.bp_1);
+		aq->pool.bp_ena_1 = enable;
+		aq->pool_mask.bp_ena_1 = ~(aq->pool_mask.bp_ena_1);
+		break;
+	case 2:
+		aq->pool.bp_2 = bp;
+		aq->pool_mask.bp_2 = ~(aq->pool_mask.bp_2);
+		aq->pool.bp_ena_2 = enable;
+		aq->pool_mask.bp_ena_2 = ~(aq->pool_mask.bp_ena_2);
+		break;
+	case 3:
+		aq->pool.bp_3 = bp;
+		aq->pool_mask.bp_3 = ~(aq->pool_mask.bp_3);
+		aq->pool.bp_ena_3 = enable;
+		aq->pool_mask.bp_ena_3 = ~(aq->pool_mask.bp_ena_3);
+		break;
+	case 4:
+		aq->pool.bp_4 = bp;
+		aq->pool_mask.bp_4 = ~(aq->pool_mask.bp_4);
+		aq->pool.bp_ena_4 = enable;
+		aq->pool_mask.bp_ena_4 = ~(aq->pool_mask.bp_ena_4);
+		break;
+	case 5:
+		aq->pool.bp_5 = bp;
+		aq->pool_mask.bp_5 = ~(aq->pool_mask.bp_5);
+		aq->pool.bp_ena_5 = enable;
+		aq->pool_mask.bp_ena_5 = ~(aq->pool_mask.bp_ena_5);
+		break;
+	case 6:
+		aq->pool.bp_6 = bp;
+		aq->pool_mask.bp_6 = ~(aq->pool_mask.bp_6);
+		aq->pool.bp_ena_6 = enable;
+		aq->pool_mask.bp_ena_6 = ~(aq->pool_mask.bp_ena_6);
+		break;
+	case 7:
+		aq->pool.bp_7 = bp;
+		aq->pool_mask.bp_7 = ~(aq->pool_mask.bp_7);
+		aq->pool.bp_ena_7 = enable;
+		aq->pool_mask.bp_ena_7 = ~(aq->pool_mask.bp_ena_7);
+		break;
+	default:
+		rc = -EINVAL;
+		goto fail;
+	}
+
+	rc = mbox_process(mbox);
+	if (rc)
+		goto fail;
+
+	bp_ena = lf->aura_attr[pool_id].bp_ena;
+	bp_ena &= ~(1 << bp_class);
+	bp_ena |= (enable << bp_class);
+
+	if (enable && !lf->aura_attr[pool_id].bp_ena)
+		lf->aura_attr[pool_id].nix0_bpid = bpid;
+	else if (!enable && !lf->aura_attr[pool_id].bp_ena)
+		lf->aura_attr[pool_id].nix0_bpid = 0;
+
+	lf->aura_attr[pool_id].bp_ena = bp_ena;
+	lf->aura_attr[pool_id].bp_thresh[bp_class] = bp;
+
+fail:
+	mbox_put(mbox);
+	return rc;
+}
+
 int
 roc_npa_aura_bp_configure(uint64_t aura_handle, uint16_t bpid, uint8_t bp_intf, uint8_t bp_thresh,
 			  bool enable)
diff --git a/drivers/common/cnxk/roc_npa.h b/drivers/common/cnxk/roc_npa.h
index 853c0fed43..336a43f95c 100644
--- a/drivers/common/cnxk/roc_npa.h
+++ b/drivers/common/cnxk/roc_npa.h
@@ -816,6 +816,8 @@ uint64_t __roc_api roc_npa_buf_type_mask(uint64_t aura_handle);
 uint64_t __roc_api roc_npa_buf_type_limit_get(uint64_t type_mask);
 int __roc_api roc_npa_aura_bp_configure(uint64_t aura_id, uint16_t bpid, uint8_t bp_intf,
 					uint8_t bp_thresh, bool enable);
+int __roc_api roc_npa_pool_bp_configure(uint64_t pool_id, uint16_t bpid, uint8_t bp_thresh,
+					uint8_t bp_class, bool enable);
 
 /* Init callbacks */
 typedef int (*roc_npa_lf_init_cb_t)(struct plt_pci_device *pci_dev);
diff --git a/drivers/common/cnxk/roc_npa_priv.h b/drivers/common/cnxk/roc_npa_priv.h
index 060df9ab04..0223e4a438 100644
--- a/drivers/common/cnxk/roc_npa_priv.h
+++ b/drivers/common/cnxk/roc_npa_priv.h
@@ -55,7 +55,10 @@ struct npa_aura_attr {
 	uint64_t shift;
 	uint64_t limit;
 	uint8_t bp_ena;
-	uint8_t bp;
+	union {
+		uint8_t bp;	      /* CN9K, CN10K */
+		uint8_t bp_thresh[8]; /* CN20K */
+	};
 };
 
 struct dev;
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index 5f75d11e24..f8d6fdd8df 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -427,6 +427,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_op_range_set)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_op_range_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pool_op_pc_reset)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_drop_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pool_bp_configure)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pool_create)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_create)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_limit_modify)
-- 
2.34.1

