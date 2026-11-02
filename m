Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0EC606AA28
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 12:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=Dej4OVJ1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB63840E3B;
	Mon,  2 Nov 2026 13:22:31 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 4E0EF4003C;
 Mon,  2 Nov 2026 13:22:29 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29FAs21925907; Mon, 2 Nov 2026 04:22:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
 4k6iH4JER2/itPxwJgwLcLElZivJGvjjrrKWS0riBY=; b=Dej4OVJ1pGnw2pbyF
 0CpX2akp/hNnz7UsG1ONCPS6blkuS1gd5YlZ5APa4I1iPi1EBdNt+QUEd/dV5gYB
 7M3DXJdDA0cmADWlMO9E8ZJ9S9nkeQa4tnt3z8kJ5tWxG/5Je9661mubHThB5l6M
 6rNSFDZ/ly3dz82crdl14JSYbGDYwEdEXVfE2twrk4W1qJiqH0L6l1+saIXURvsR
 zz63sdyMui8S0drpELS4mwOiqa1gBfDCBHA0M9AKkXIGTLzHhLHDb3sPwNmJZfF6
 RX7Ncnrkg+OBOxMEeaulrT4YiQzc93NCsT5qDpnqrwzhhLb6Xv4XNr/hLzYSMn+d
 YJmrA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hndpmnsae-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 04:22:27 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 2 Nov 2026 04:22:27 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 2 Nov 2026 04:22:27 -0800
Received: from cavium-System-Product-Name.. (unknown [10.28.40.118])
 by maili.marvell.com (Postfix) with ESMTP id 1FCD43F7078;
 Mon,  2 Nov 2026 04:22:23 -0800 (PST)
From: Aarnav JP <ajp@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <rbhansali@marvell.com>, Aarnav JP
 <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH 2/5] common/cnxk: fix TM schq alloc OOB write
Date: Mon, 2 Nov 2026 17:51:50 +0530
Message-ID: <20261102122154.2611710-2-ajp@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102122154.2611710-1-ajp@marvell.com>
References: <20261102122154.2611710-1-ajp@marvell.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=VOZIDNPX c=1 sm=1 tr=0 ts=6ae88083 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=zzUvz5twnary-Ko6D3kA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0OCBTYWx0ZWRfX12hAWsMROXFJ
 6ZBLyY9C4N30KOcNCT0aymCG8f9yw4d9T4Slyhy0S9nXbX9eqUHR9fD3SgFtzYslkzeleyZRezT
 GVqIHqucYl6px9dodfEy/XZJfM4NbaM=
X-Proofpoint-ORIG-GUID: PuOD4ET2hvtAy9XaYq8XDmrBoVL91yXn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0OCBTYWx0ZWRfXz2/YldzVZ5tX
 hdnsqieVPtG34MCOEzq8SMVmUWt2PT6xZH8QTr97eW2NKr6OJz1puVbpM9qzJLqhhdzy3YM/7xf
 2cRGudE251Q1k/u8RKtjnFi3Z44eKbLqnx4aobXOf5nFEkz9y3WGrFONe5zrzFS2op7+S78w+xm
 vGKMb+a4wTNyV6CDVhm8nj6fHy86+IdE5a1bkm/QldtsqlyN1tUUGFL59u88LnMF4cPD+HG7yZ+
 d9ehjMvzYvMkwIFXInV9VffYYeA/0+U3qpcI3t6hA8rDqnsiU7O00FFUOk4jQ538a4XHKNWqmGV
 cIXeb+4ggSK0cTVg13BoC04QtjbtMFT1NcR9Z//gcQlZanHbV/Ul/iefIhXwXOnbUaLAXZeHNED
 PtaFpwQNiLbPxKJ0wqkna7lBKSnAs8B9GurF4vbdctB98KPZlzgUTh1/fKRisAi7s1FhvyaW5E8
 EhiKrgoAnFJ7Gf4KPWQ==
X-Proofpoint-GUID: PuOD4ET2hvtAy9XaYq8XDmrBoVL91yXn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nix_tm_copy_rsp_to_nix() consumes the txsch alloc response verbatim.
The count rsp->schq[lvl] is not bounded to the 128-entry list, so a
large count over-reads schq_list[lvl][]; and the schq id is passed
to plt_bitmap_set() as the bit position without checking it against
NIX_TM_MAX_HW_TXSCHQ (2048). rte_bitmap_set() does not bound-check
pos, so an id >= 2048 writes outside the bitmap and corrupts memory.

Clamp the count to MAX_TXSCHQ_PER_FUNC and reject any id >=
NIX_TM_MAX_HW_TXSCHQ with -EINVAL, propagating the error out of
nix_tm_alloc_txschq() so setup fails cleanly. Applied to both the
discontiguous and contiguous lists.

Fixes: df405df95eeb ("common/cnxk: add NIX TM helper to alloc/free resource")
Cc: stable@dpdk.org

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
 drivers/common/cnxk/roc_nix_priv.h   |  2 +-
 drivers/common/cnxk/roc_nix_tm.c     | 37 ++++++++++++++++++++++------
 drivers/common/cnxk/roc_nix_tm_ops.c |  8 ++++--
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_priv.h b/drivers/common/cnxk/roc_nix_priv.h
index d4b3c7c1af..9779b336b0 100644
--- a/drivers/common/cnxk/roc_nix_priv.h
+++ b/drivers/common/cnxk/roc_nix_priv.h
@@ -421,7 +421,7 @@ int nix_tm_alloc_txschq(struct nix *nix, enum roc_nix_tm_tree tree);
 int nix_tm_assign_resources(struct nix *nix, enum roc_nix_tm_tree tree);
 int nix_tm_release_resources(struct nix *nix, uint8_t hw_lvl, bool contig,
 			     bool above_thresh);
-void nix_tm_copy_rsp_to_nix(struct nix *nix, struct nix_txsch_alloc_rsp *rsp);
+int nix_tm_copy_rsp_to_nix(struct nix *nix, struct nix_txsch_alloc_rsp *rsp);
 
 int nix_tm_txsch_reg_config(struct nix *nix, enum roc_nix_tm_tree tree);
 int nix_tm_update_parent_info(struct nix *nix, enum roc_nix_tm_tree tree);
diff --git a/drivers/common/cnxk/roc_nix_tm.c b/drivers/common/cnxk/roc_nix_tm.c
index 76c0f01884..2f38b042f9 100644
--- a/drivers/common/cnxk/roc_nix_tm.c
+++ b/drivers/common/cnxk/roc_nix_tm.c
@@ -1483,21 +1483,40 @@ nix_tm_assign_resources(struct nix *nix, enum roc_nix_tm_tree tree)
 	return 0;
 }
 
-void
+int
 nix_tm_copy_rsp_to_nix(struct nix *nix, struct nix_txsch_alloc_rsp *rsp)
 {
 	uint8_t lvl;
 	uint16_t i;
 
 	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
-		for (i = 0; i < rsp->schq[lvl]; i++)
-			plt_bitmap_set(nix->schq_bmp[lvl],
-				       rsp->schq_list[lvl][i]);
 
-		for (i = 0; i < rsp->schq_contig[lvl]; i++)
-			plt_bitmap_set(nix->schq_contig_bmp[lvl],
-				       rsp->schq_contig_list[lvl][i]);
+		uint16_t cnt = PLT_MIN(rsp->schq[lvl], (uint16_t)MAX_TXSCHQ_PER_FUNC);
+
+		for (i = 0; i < cnt; i++) {
+			uint16_t id = rsp->schq_list[lvl][i];
+
+			if (id >= NIX_TM_MAX_HW_TXSCHQ) {
+				plt_err("Invalid schq %u for lvl %u in alloc rsp", id, lvl);
+				return -EINVAL;
+			}
+			plt_bitmap_set(nix->schq_bmp[lvl], id);
+		}
+
+		cnt = PLT_MIN(rsp->schq_contig[lvl], (uint16_t)MAX_TXSCHQ_PER_FUNC);
+
+		for (i = 0; i < cnt; i++) {
+			uint16_t id = rsp->schq_contig_list[lvl][i];
+
+			if (id >= NIX_TM_MAX_HW_TXSCHQ) {
+				plt_err("Invalid contig schq %u for lvl %u in alloc rsp", id, lvl);
+				return -EINVAL;
+			}
+			plt_bitmap_set(nix->schq_contig_bmp[lvl], id);
+		}
 	}
+
+	return 0;
 }
 
 int
@@ -1563,8 +1582,10 @@ nix_tm_alloc_txschq(struct nix *nix, enum roc_nix_tm_tree tree)
 			goto alloc_err;
 		}
 
-		nix_tm_copy_rsp_to_nix(nix, rsp);
+		rc = nix_tm_copy_rsp_to_nix(nix, rsp);
 		mbox_put(mbox);
+		if (rc)
+			goto alloc_err;
 	} while (pend);
 
 	nix->tm_link_cfg_lvl = rsp->link_cfg_lvl;
diff --git a/drivers/common/cnxk/roc_nix_tm_ops.c b/drivers/common/cnxk/roc_nix_tm_ops.c
index 230e9b72f6..1086f471e6 100644
--- a/drivers/common/cnxk/roc_nix_tm_ops.c
+++ b/drivers/common/cnxk/roc_nix_tm_ops.c
@@ -778,8 +778,10 @@ roc_nix_tm_prealloc_res(struct roc_nix *roc_nix, uint8_t lvl,
 			return rc;
 		}
 
-		nix_tm_copy_rsp_to_nix(nix, rsp);
+		rc = nix_tm_copy_rsp_to_nix(nix, rsp);
 		mbox_put(mbox);
+		if (rc)
+			return rc;
 	}
 
 	/* Preallocate contiguous */
@@ -797,8 +799,10 @@ roc_nix_tm_prealloc_res(struct roc_nix *roc_nix, uint8_t lvl,
 			return rc;
 		}
 
-		nix_tm_copy_rsp_to_nix(nix, rsp);
+		rc = nix_tm_copy_rsp_to_nix(nix, rsp);
 		mbox_put(mbox);
+		if (rc)
+			return rc;
 	}
 
 	/* Save thresholds */
-- 
2.43.0

