Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E40CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 07:33:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 352E842ED2;
	Thu, 11 Jun 2026 09:33:36 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6046442EC8
 for <dev@dpdk.org>; Thu, 11 Jun 2026 09:33:34 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B0Qs9O1253731 for <dev@dpdk.org>; Thu, 11 Jun 2026 00:33:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=M
 MC52WPGzahwOh0jp/7Fvc+rJlDWyOlplZjWKoSnjH4=; b=ZFsSGY38ZeefCZEjd
 KlYj/Kr+lelZg0r8U+YYWBDhXRQnhM+mtpwONHFDbAaG/YbckUpFuGL42q75dOyl
 G9VNy1OLctWn8BEg6i6gbgJHpaJZcFE99WtbHui7td0aa9OppGRctzI4INNd24Wb
 ZMX0Wop04iBg5Nq1nqiGY+mMdz8qim7GzqzvBeZzlJAJPLdosNpZVDFQ5G8qnZIg
 zZ4sw6O27Qt/OvrZCecfpz6WVbmwCh7hoJZleCiaC5j/si0GVzLdUEncKKtlRcOf
 6kuxe+OjFLTY/r5m4wMsr4iQmlp7uTLTjlIBpvXrR/qakfaHf6OR25jH9sM2K2UI
 /ubHw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5vswng-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 11 Jun 2026 00:33:33 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 00:33:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 00:33:32 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id DF0175B6973;
 Thu, 11 Jun 2026 00:33:29 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 02/17] common/cnxk: add API of SA valid for cn20k platform
Date: Thu, 11 Jun 2026 13:02:56 +0530
Message-ID: <20260611073311.3129711-2-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611073311.3129711-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA3MyBTYWx0ZWRfX4EOejQgw8qlu
 4FlhIOzbr8NuWA9K9EvjnzBQBIJKxontXjkjs9WqpbaeOlf7CQPUMQh8b6CXBHo1J/UKUgFD/ov
 JFeGGyk9WjnTjYcRymaHQb9DtIJAeCQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA3MyBTYWx0ZWRfX7zNkKG1OfDmF
 kvBpFyFsYSUegmuBoeVva8b+E9PL8wF1BRq5KzOVycK7mP9smHgtqJ+v1D+qoXad0sqMPLGCGD5
 y7I8xUmcVqRSPSBz/dBadNGvyB+CscmakgxK557Q7uK/ZM/NuA9cZsc8RIBDx5ZanY/AR6fG6As
 9NN3Du/J1/pijnGqTKmHHoGeKldUMUYjisUOzBU8zUpKo+1ceDqj9FbSJBtpPv5GMQjK0OR2bBW
 pCeMf3deS4GQ1r/35W3Ad6WXN7ndVnB97C4zfU/Dqi/skihKxc3aqn7vyFXGo15HFa+DU/q0u6l
 y68Ud65sr7dd9gh0OygXKRdXGbmNBB3+YV0ifCcF25OAfXVIZomvVSCljQnoCpRUMWA8nvoF3NM
 l0ETM1jhaDonwhdfTXNPUSEjJqs7cRIdO/Pt0QUCXcBY8IiU/VIlEVxVobEzAAyFWh52P/Afrgx
 tcMaBH3p+rzqFizyY2w==
X-Authority-Analysis: v=2.4 cv=UPDt2ify c=1 sm=1 tr=0 ts=6a2a64cd cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=KtZkbCYgPt0tyzpBGWAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: xxZbwX2VXr1G6xZ_0Ih5ZAZowgtxmCTZ
X-Proofpoint-GUID: xxZbwX2VXr1G6xZ_0Ih5ZAZowgtxmCTZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
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

Add API to get SA valid configuration for cn20k platform.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/cnxk_security.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/common/cnxk/cnxk_security.c b/drivers/common/cnxk/cnxk_security.c
index 6b51055100..6f46ad3276 100644
--- a/drivers/common/cnxk/cnxk_security.c
+++ b/drivers/common/cnxk/cnxk_security.c
@@ -606,6 +606,20 @@ cnxk_ot_ipsec_outb_sa_valid(struct roc_ot_ipsec_outb_sa *sa)
 	return !!sa->w2.s.valid;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ow_ipsec_inb_sa_valid)
+bool
+cnxk_ow_ipsec_inb_sa_valid(struct roc_ow_ipsec_inb_sa *sa)
+{
+	return !!sa->w2.s.valid;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ow_ipsec_outb_sa_valid)
+bool
+cnxk_ow_ipsec_outb_sa_valid(struct roc_ow_ipsec_outb_sa *sa)
+{
+	return !!sa->w2.s.valid;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ipsec_ivlen_get)
 uint8_t
 cnxk_ipsec_ivlen_get(enum rte_crypto_cipher_algorithm c_algo,
-- 
2.34.1

