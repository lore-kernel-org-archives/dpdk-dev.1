Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2065CCD193
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 17:29:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FA2E4066C;
	Thu, 23 Oct 2025 19:28:20 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2ACED40A75
 for <dev@dpdk.org>; Thu, 23 Oct 2025 19:28:18 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3d5Xw022686
 for <dev@dpdk.org>; Thu, 23 Oct 2025 10:28:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=1
 lHdbbUSqn2mUdoEWZ08p/248TCQtJ1k+pOWhzaFRH0=; b=UJ1iyb5JNsVsyflaG
 6fxP0gN84aam71/1fDJEGLOuVvmlz055KJ1ZmDpR/aSWRcMr8phRi1JSGEWzPWB/
 scCbPte2Pjq46/UKyQYSNRARwVGdIX0xmv/5pbV1kL+CYLzjvElokYpL2uA082Ep
 Fxn+0nvW8KBcositseCNCcyhbmMMXhjnLqjjjercyFfXI74IMKVguogNBpQ7Ryu8
 Jy4fzHB3g0+tBSNP576WGALenIO3j6avt/okEzmek9zSLqxG+azQ+PfIsGLCxa/o
 RLZx3KG7hYXgLAtbwgv2+eKQztuluIch26iAdn6kWtN+vNbHTwVWVOtP+FC93gL1
 JfqJQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49ycmr1w8h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 23 Oct 2025 10:28:17 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 10:28:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 10:28:25 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 243255C68F1;
 Thu, 23 Oct 2025 10:28:13 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: [PATCH v3 15/19] common/cnxk: resolve klocwork issues
Date: Thu, 23 Oct 2025 22:57:23 +0530
Message-ID: <20251023172728.770661-15-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023172728.770661-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251023172728.770661-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nDGF3NWzDVRaSbldSbBeeddvRYoIAas-
X-Proofpoint-GUID: nDGF3NWzDVRaSbldSbBeeddvRYoIAas-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDAzMCBTYWx0ZWRfX3qtA8CSnNa58
 dNQpbh5d8a0r65z51jezbv4oTcmBg2XgmmYgCmoHgzJIlbD49+UjnFl3Jy6/Kzlyn/4IVB5z6CA
 +FNFSczetRpUPJksIcoAeaFAWRPgOdE2pxTMqh3CIhmKtFLtiF3kIX/iLNA60FlV9EJD4SFRCNZ
 1/y61qH1q4PHF65dLuLzA7cp1CnpGdcqnWkzqCPrUz7n5KmeJ1/sXQNnIoi5w5xcT5qQIroM1tc
 +5jwfhXypQTQ9OoSchLHksNCQF1kiYN2opC2PiB4ObrNL2DiFqjCXU4ZQYoQZFNXg/MMK0+krW4
 SYjdL2HykCN/BsNsqLiHXo1+JV4w3DUrBqYpAjNFtlEersAQjIaVC79hgE6Z+BJZbnMYCYdPDgm
 CCBj4SuKHkiV+V7k6tMuzdpA+DCL5Q==
X-Authority-Analysis: v=2.4 cv=CtSys34D c=1 sm=1 tr=0 ts=68fa65b1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=G8DdwVB4TRNb03k8HkUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
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

From: Rakesh Kudurumalla <rkudurumalla@marvell.com>

Fix klockwork for NULL pointer dereference

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 drivers/common/cnxk/roc_nix_queue.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_queue.c b/drivers/common/cnxk/roc_nix_queue.c
index 2c7fce1067..c7e37abf32 100644
--- a/drivers/common/cnxk/roc_nix_queue.c
+++ b/drivers/common/cnxk/roc_nix_queue.c
@@ -112,6 +112,11 @@ roc_nix_sq_ena_dis(struct roc_nix_sq *sq, bool enable)
 {
 	int rc = 0;
 
+	if (!sq) {
+		rc = NIX_ERR_PARAM;
+		goto done;
+	}
+
 	rc = roc_nix_tm_sq_aura_fc(sq, enable);
 	if (rc)
 		goto done;
@@ -2163,9 +2168,9 @@ nix_sqb_mem_dyn_free(uint64_t aura_handle, uint16_t count)
 int
 roc_nix_sq_fini(struct roc_nix_sq *sq)
 {
-	struct roc_nix *roc_nix = sq->roc_nix;
-	bool sq_resize_ena = roc_nix->sq_resize_ena;
 	struct ndc_sync_op *ndc_req;
+	struct roc_nix *roc_nix;
+	bool sq_resize_ena;
 	struct mbox *mbox;
 	struct nix *nix;
 	uint16_t qid;
@@ -2174,6 +2179,9 @@ roc_nix_sq_fini(struct roc_nix_sq *sq)
 	if (sq == NULL)
 		return NIX_ERR_PARAM;
 
+	roc_nix = sq->roc_nix;
+	sq_resize_ena = roc_nix->sq_resize_ena;
+
 	nix = roc_nix_to_nix_priv(roc_nix);
 	mbox = (&nix->dev)->mbox;
 
@@ -2228,7 +2236,7 @@ sqb_aura_dyn_expand(struct roc_nix_sq *sq, uint16_t count)
 	int i;
 
 	blk_sz = nix->sqb_size;
-	sqbs = calloc(1, count * sizeof(uint64_t *));
+	sqbs = calloc(1, count * sizeof(uint64_t));
 	if (!sqbs)
 		return -ENOMEM;
 
@@ -2300,7 +2308,7 @@ sqb_aura_dyn_contract(struct roc_nix_sq *sq, uint16_t count)
 	cycles = (timeout * 10 * plt_tsc_hz()) / (uint64_t)1E6;
 	cycles += plt_tsc_cycles();
 
-	sqbs = calloc(1, count * sizeof(uint64_t *));
+	sqbs = calloc(1, count * sizeof(uint64_t));
 	if (!sqbs)
 		return -ENOMEM;
 
-- 
2.34.1

