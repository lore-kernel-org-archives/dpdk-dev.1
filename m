Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58F5C54F2E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:52:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2D7340B94;
	Fri, 23 May 2025 15:52:19 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5D25F40B8F
 for <dev@dpdk.org>; Fri, 23 May 2025 15:52:18 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NBl8Rp006690
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=x
 jyLGklTWpZ0lHw3qYnRtT1a1/kYKvz78gpraBxYSJI=; b=eDrrirMU+schBoXGO
 g/9KhaL5VIqMjAoDTCK8XRGHC+ZQZ8EZQPCuwI7Dde8ymDb2IHq6Mzce/MPhAzlO
 RBTBNFlX8+elnWr9/HkaGv24eNqsT9D/BQw6hW1syyZDLRq64P44WepZd+0fQek6
 gf0NgoMbSkllL8fvHoryy5kMCiU9tS9XybNyLkbETokz5K02p09VwMh2cExQidkv
 KrJFQrVZYimLDueQCMA4NlLnAJBlsLiCHV5m83Sy6sfjWoXNi0G6p/KfweXQKLU3
 oq5Zeb0YyFTuaXI+Yfxx9XPgz8q7ZCY3pQDBA0y31yrn2iT/ZJvVaGMRU7vS9awb
 eI13w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46tdnksh52-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:15 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:51:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:51:21 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 1D5C73F7041;
 Fri, 23 May 2025 06:51:18 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Aakash Sasidharan
 <asasidharan@marvell.com>,
 Nithinsen Kaithakadan <nkaithakadan@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 02/40] crypto/cnxk: add lookaside IPsec CPT LF stats
Date: Fri, 23 May 2025 19:20:33 +0530
Message-ID: <20250523135111.2178408-3-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfX2jmfx2A4XXDB
 PqjLvy4pBiqhwXzoY7LkLc+zawA4kkq91ZZLyEpKOl1He2UKXck18ZESualr9TeM7GddGWY7hQS
 u5dWlEQuSQE7ws16wLi9vofmy24D+UnWOIGJFj7B16XaEoBx+Jmn/MEzy52tjRPNigxDDqnHqkY
 RvzmNa/rBfZbw2QsoTyc5kj2nHqSI83tA/4+nBlIR1zKQuSOmC2Ic/H8K9FenXc1OEHUD6yP27P
 2c/erhtUJSMnfrHMPSySDstng7VU4Ehlkmkz/PXKnOF1iqwXZXVM6FLLLlZY+lYhe/oRZNe5nPX
 1oFQ1nUh/Nu/Zmy1PcpCTTJWI3eM6WLjD37asTJUMNqHHPjhJD287p24N3nzqGmgAWZPJVKZ08t
 /mVyq9eIXCMFPBEXnWMosYv5ZtT2eAwr3/MgiuetLraBdLKsm1XGlDb36dHdr8Aj946P4KI2
X-Authority-Analysis: v=2.4 cv=Hst2G1TS c=1 sm=1 tr=0 ts=68307d8f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=bryrBbE1vg0dnyMRpVgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: WBfeQMf1UVY-7rGoH3_8zBzVonIn1xju
X-Proofpoint-ORIG-GUID: WBfeQMf1UVY-7rGoH3_8zBzVonIn1xju
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_04,2025-05-22_01,2025-03-28_01
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

Adding global CPT LF stats for lookaside IPsec.

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/crypto/cnxk/cn10k_ipsec.c        | 4 ++++
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/crypto/cnxk/cn10k_ipsec.c b/drivers/crypto/cnxk/cn10k_ipsec.c
index 33ffda0a4c..ae0482d0fe 100644
--- a/drivers/crypto/cnxk/cn10k_ipsec.c
+++ b/drivers/crypto/cnxk/cn10k_ipsec.c
@@ -117,6 +117,8 @@ cn10k_ipsec_outb_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 		/* Enable mib counters */
 		sa_dptr->w0.s.count_mib_bytes = 1;
 		sa_dptr->w0.s.count_mib_pkts = 1;
+		sa_dptr->w0.s.count_glb_pkts = 1;
+		sa_dptr->w0.s.count_glb_octets = 1;
 	}
 
 	memset(out_sa, 0, sizeof(struct roc_ot_ipsec_outb_sa));
@@ -221,6 +223,8 @@ cn10k_ipsec_inb_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 		/* Enable mib counters */
 		sa_dptr->w0.s.count_mib_bytes = 1;
 		sa_dptr->w0.s.count_mib_pkts = 1;
+		sa_dptr->w0.s.count_glb_pkts = 1;
+		sa_dptr->w0.s.count_glb_octets = 1;
 	}
 
 	memset(in_sa, 0, sizeof(struct roc_ot_ipsec_inb_sa));
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index c3a0a58c8f..613ce11ec1 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -953,6 +953,7 @@ cnxk_cpt_dump_on_err(struct cnxk_cpt_qp *qp)
 
 	plt_print("");
 	roc_cpt_afs_print(qp->lf.roc_cpt);
+	roc_cpt_lfs_print(qp->lf.roc_cpt);
 }
 
 int
-- 
2.25.1

