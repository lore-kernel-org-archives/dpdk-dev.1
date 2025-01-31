Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D29C0218D
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 08:08:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5F4842D7A;
	Fri, 31 Jan 2025 09:07:13 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0550542D45
 for <dev@dpdk.org>; Fri, 31 Jan 2025 09:07:11 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V7liao021192
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:07:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=l
 pHhMNywNfuj+572J2OKPpjkHbD/fC7NXjWjzAptkJs=; b=EKtNEwj/Al/jVBN8G
 rxINN6w79KvtIp9K4hm2iWJ2416QIouubt2WO2SXZ1NUbnp1Los6CrRe7B7TLNLN
 Iq3cXbAfgsrnY/v3X6Xgrkiru5xmtWqpRiAkZcSCD6SYbTDRDH2G8ywgGTIa8aBk
 h7ebJ6nOOBwBFhV/AZIXL0CaChRIyAQQWQHOtlWRCm7f0w4SxTvYhHVc1dFwDlp+
 Okcgd1dn2bjSnPvsTy4FwhmkfD4XZhxf9VAR1sMmgG0UockJ3yPq/gk/s0GkUKZG
 jKOzLASBU3mcGlFe3Vy7z6izQwQdSdRsWy68R9lxFDIpwmiYxJYI2s/UM1gKKNKu
 nS5WA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44gtenr139-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:07:11 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 31 Jan 2025 00:07:09 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 31 Jan 2025 00:07:09 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 3B0743F7045;
 Fri, 31 Jan 2025 00:07:06 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH 30/34] common/cnxk: fix inbound IPsec sa setup
Date: Fri, 31 Jan 2025 13:35:25 +0530
Message-ID: <20250131080530.3224977-30-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250131080530.3224977-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: WlsbgC7vE5IN7M8BQOAIr3-TycKXaROp
X-Proofpoint-ORIG-GUID: WlsbgC7vE5IN7M8BQOAIr3-TycKXaROp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_03,2025-01-30_01,2024-11-22_01
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

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 drivers/common/cnxk/cnxk_security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/cnxk_security.c b/drivers/common/cnxk/cnxk_security.c
index 1fe750049e..16191c3ecc 100644
--- a/drivers/common/cnxk/cnxk_security.c
+++ b/drivers/common/cnxk/cnxk_security.c
@@ -313,7 +313,7 @@ cnxk_ot_ipsec_inb_sa_fill(struct roc_ot_ipsec_inb_sa *sa,
 	/* Initialize the SA */
 	roc_ot_ipsec_inb_sa_init(sa);
 
-	w2.u64 = 0;
+	w2.u64 = sa->w2.u64;
 	rc = ot_ipsec_sa_common_param_fill(&w2, sa->cipher_key, sa->w8.s.salt,
 					   sa->hmac_opad_ipad, ipsec_xfrm,
 					   crypto_xfrm);
-- 
2.34.1

