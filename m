Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EE5C021B3
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 09:56:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A33440EE2;
	Mon, 24 Feb 2025 10:55:02 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0AE8C40E17;
 Mon, 24 Feb 2025 10:54:51 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O51DKW001315;
 Mon, 24 Feb 2025 01:54:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=B
 VwU61nggNtuq/8cIztxBINqZf87+6AtvBm+Ppw+/xo=; b=kW5l1Mfnsmruwuong
 ZORHG5qaR1SxwYqRv1eKNx79cTwm5DKQuJICQ1dR5HmfZMcGKYRt6augyoU2z8st
 OmcInBjyUb+/5ke7SrnC3Nc1h3KN8tZbyqx4HfrBf4bXLQ1c6fFNY/+4eXDEe4wj
 6/dnzINOcQA670EB0bz21pu3ymfNJvzE/I303mobVraVP4LzG46mC6ZATxi0wA2y
 pCI5sCBjRGB9iv6WaZCoIHcopeiNB82Lwp0rdzoFZHxJ3HH8OLH8qOinO56+ZIqP
 BHR2V3VR9/KawnRkszHzrh9o2TlvXou9lwFqHEFZ+82SiSjvtIuEqK5g4dxMjCUO
 J3joQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44ys85jh2x-12
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2025 01:54:50 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 01:54:35 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 01:54:35 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id C02E03F7067;
 Mon, 24 Feb 2025 01:54:32 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH v3 29/33] common/cnxk: fix inbound IPsec sa setup
Date: Mon, 24 Feb 2025 15:22:37 +0530
Message-ID: <20250224095241.1263700-29-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224095241.1263700-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
 <20250224095241.1263700-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Ib_v0OETNh4_N6TYfGjbtm9GALDuM1_E
X-Proofpoint-ORIG-GUID: Ib_v0OETNh4_N6TYfGjbtm9GALDuM1_E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_04,2025-02-24_01,2024-11-22_01
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

Make sure the w2 in inbound SA is set for inline IPsec have
L3 header on errors.

Fixes: 350b7a536a51 ("common/cnxk: enable L3 header write back in SA")
Cc: stable@dpdk.org

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 drivers/common/cnxk/cnxk_security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/cnxk_security.c b/drivers/common/cnxk/cnxk_security.c
index 3a747ed441..a3c06c1e88 100644
--- a/drivers/common/cnxk/cnxk_security.c
+++ b/drivers/common/cnxk/cnxk_security.c
@@ -315,7 +315,7 @@ cnxk_ot_ipsec_inb_sa_fill(struct roc_ot_ipsec_inb_sa *sa,
 	/* Initialize the SA */
 	roc_ot_ipsec_inb_sa_init(sa);
 
-	w2.u64 = 0;
+	w2.u64 = sa->w2.u64;
 	rc = ot_ipsec_sa_common_param_fill(&w2, sa->cipher_key, sa->w8.s.salt,
 					   sa->hmac_opad_ipad, ipsec_xfrm,
 					   crypto_xfrm);
-- 
2.34.1

