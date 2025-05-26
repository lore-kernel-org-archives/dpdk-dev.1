Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C618AC54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 16:58:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 324D44065D;
	Mon, 26 May 2025 18:58:34 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 587C34066D
 for <dev@dpdk.org>; Mon, 26 May 2025 18:58:32 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q9dpt3001452
 for <dev@dpdk.org>; Mon, 26 May 2025 09:58:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=x
 jyLGklTWpZ0lHw3qYnRtT1a1/kYKvz78gpraBxYSJI=; b=dOfcyS7ibzocZZXqs
 ZqBjYP8FH+TpmSUy75YMvTaEZuTa1G7rQHdL98XRf32A1OaP1eboMudVmVzibWeJ
 uTOXHTy4VVe6FHCfgPkHrmT7nN0P5tQRttj+97qjzCU9tkItiwuBmDXUbODgtg6R
 DRGBYfv5QbMkdcnW83nexcG4ChK3ItFvpMBZW1OgOTCBDqYmaiYkeHOqGU2fG/1R
 ito+vaOM23HQhu5ArN/ugQ66eQqqNHbknFNVqeiuZIohlvd1plZADxqLam8Z5TsI
 ekWlgJQVWDQiQ7E6Of8cAf5bpGHeK3V8aT03pAOjDADwBX2Z2Vq4iCuz7JnvCO2y
 kE7tA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46vnv1gsk6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 09:58:31 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 09:58:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 09:58:30 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id A69FD3F7063;
 Mon, 26 May 2025 09:58:27 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Aakash Sasidharan
 <asasidharan@marvell.com>,
 Nithinsen Kaithakadan <nkaithakadan@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 02/40] crypto/cnxk: add lookaside IPsec CPT LF stats
Date: Mon, 26 May 2025 22:27:41 +0530
Message-ID: <20250526165819.2197892-3-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526165819.2197892-1-ktejasree@marvell.com>
References: <20250526165819.2197892-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: JYZaoDWmeBVZk1q5JnwG9pwBPvy0E3QO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0MyBTYWx0ZWRfX+8ovx3/G2Mox
 5OtYjFCBqUUncRiLvLIJWinFDrGvfQr/YqgRAe7nQiya2eQqylL68190Zu3O5QH5UFnQL7UoGUI
 LctP1Q8wCRM2H89RFySs3L4LFmzgwTPmjp5Z/zYmO+oah93tqekujtV9+lWyMw07LOElqA7nJxW
 /9CXzP6P2W27C/hM49G2KtOBXJ1PKqA2EnJVKKDi3RflmY1mvxrqM9LLAKVKdcdYIj5ImBjWMJc
 jYHHeQ3xYRkWKC7Ed2BK99bZOfz9tvVFjloVStSHHD5pvf9K3fBHSNMh2z6G4cjh39UC67o+3Zm
 Uaqm4aByBqCS/zjBbZc7r8K8+QVpcbtZy0CO7lJUOzvh8gY1dBUeiL4R8kTFNUkfMdZlphszcvT
 lWsivUrugOdM11278fgPd2dEhAR8RobSuEGEE3HXH3fP3JVNGu1YqmiDLngZIdHdZuCDYnov
X-Proofpoint-ORIG-GUID: JYZaoDWmeBVZk1q5JnwG9pwBPvy0E3QO
X-Authority-Analysis: v=2.4 cv=PPgP+eqC c=1 sm=1 tr=0 ts=68349db7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=bryrBbE1vg0dnyMRpVgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_08,2025-05-26_02,2025-03-28_01
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

