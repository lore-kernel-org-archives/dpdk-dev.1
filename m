Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80212C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 04:00:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 593124065D;
	Tue, 27 May 2025 06:00:49 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id DB4B840667
 for <dev@dpdk.org>; Tue, 27 May 2025 06:00:47 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QNUDg5005419
 for <dev@dpdk.org>; Mon, 26 May 2025 21:00:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=x
 jyLGklTWpZ0lHw3qYnRtT1a1/kYKvz78gpraBxYSJI=; b=hGCoh9zvaVyBtZN0r
 5i6S4EoVyjh2Q2A2NcH3h4HNyCymPm4FKEQpvBL1N+sAwD5E0SMNG02c9bbN1zpK
 Ksg1hcrPYTT2ZqFERQvJU7vzHZN9QqVz3WJ2QKja2njDRpv3kfaXAL7DDUCYRVPv
 eh6kxfT/Yx6v9YxGookNG2I+MlFdzYU+g9QFqMA5wV7fymyc4SJPyIHr+eRh4zdi
 BAKPFzvahmNOIwX2zt5LwTkwdPw68gQSnCq/ldt0+Rn8h8KjS3PRdHmEfOBWvlK0
 bSVQH3QGRqn4Xqw7sJOdTsdkhW5GZt22/Y3wqF/cZaN4LmjmPgVW7k1+alDRxMmk
 2AwIA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46w2148bud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 21:00:46 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 21:00:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 21:00:45 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 079163F7060;
 Mon, 26 May 2025 21:00:42 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Aakash Sasidharan
 <asasidharan@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 2/6] crypto/cnxk: add lookaside IPsec CPT LF stats
Date: Tue, 27 May 2025 09:30:32 +0530
Message-ID: <20250527040036.2280893-3-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250527040036.2280893-1-ktejasree@marvell.com>
References: <20250527040036.2280893-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: -dZeJnzO8G94nXgSGB4iBvgnI9JiTuie
X-Authority-Analysis: v=2.4 cv=a+gw9VSF c=1 sm=1 tr=0 ts=683538ee cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=bryrBbE1vg0dnyMRpVgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: -dZeJnzO8G94nXgSGB4iBvgnI9JiTuie
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDAyOSBTYWx0ZWRfXyx4VbIUrVIys
 VgzoeKmJhmWTO1UP0cRSVDVStbi4ewXZaHUDuj+HNrCL6nwvwCuV2Mz/2GhTsxQvFzP9ejTxV6Z
 mhW8bvKbD2S/SCoJn+nRZJpDKnu+6QkGiBsOnYMSDvA5JW1Ldxz6ULeOpmxGKU4Mrmy2aAeE7F6
 ycaJYK74M/enuQCBbjSeVZjIDjXlhb0P8aN/BRNQoZDC5nufLsjPpg3jJOH4mnKK+wI3NZ9WWjc
 3Rr8b/mzm94X7zTeoFtX4uSqA3iB2AxPpjzBnbs92rIBi4lZfSIy0cvyu784YihxtvTCkkOoehN
 lMqXLlz0Ts5fmQs6todgyJZ9Q6awRPzkFx8/HpvQ89AVtBb5QHxAaKIkEr5/PshQcTrfwX1Iznq
 CuGZwHVRd9nxJ6b4xti1FYv2lwMyrgIObllIJK/SFimoz1UHkv1ezuXR6iwtgD58nTX+UWMa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_02,2025-05-26_02,2025-03-28_01
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

