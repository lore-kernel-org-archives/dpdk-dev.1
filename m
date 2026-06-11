Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13591CD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 14:20:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32FCF427D0;
	Thu, 11 Jun 2026 16:20:51 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D3233427CF
 for <dev@dpdk.org>; Thu, 11 Jun 2026 16:20:49 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCXbLC2628456 for <dev@dpdk.org>; Thu, 11 Jun 2026 07:20:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=H
 ZfysFgzhuID7ej2epml/Fwj7D8MWJ+8m/hTr6MqMb8=; b=ebbnQzj1hboa4tncc
 tGX3FZEMM4UIX4BOaMeF1kRgP5/sehw9uEH6ZTR+r/JHu4W1QjGD4VGKZ0krmQ1o
 ak8thxUaCPDdbU4ik5etOQ2v7juhw7tnzQLcYuwoD+EFnnOdxAaFxw0yXPWoYVlI
 e3p3tV/KznV+9U+Jjm6XybW74/WFXZn9hS4TJoHcV7bADiMxAL2Sp+r3duwKY2gV
 faNM75aEt9YHTd4sbOevPD1EwMmwFXOdnBVFkWsR0dBDrzvmFdOKO6CwoUDYZ+ab
 9zerNYtK5SkWm7/tAV8DANP/QwOt+nOkAsFESRR9pxjC3GmT9Mn5X2BeNjxBjva+
 8UcpQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5vu5mf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 11 Jun 2026 07:20:48 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 07:20:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 07:20:46 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 080125B6976;
 Thu, 11 Jun 2026 07:20:43 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 02/22] common/cnxk: add API of SA valid for cn20k platform
Date: Thu, 11 Jun 2026 19:50:09 +0530
Message-ID: <20260611142029.3351415-2-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611142029.3351415-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260611142029.3351415-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0MyBTYWx0ZWRfX98nAD9+d8MOD
 tQhQiv/xoUiLjJLrX8CIJbkS/wFYIDtCmVxRzNpwKgVzZm99CZDVrEe+5XB8bISzXJV80GY8Eyb
 7TQpPLx2CBtjZNwb35rQpgKzBr78U/E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0MyBTYWx0ZWRfXw5uukD0d6JpG
 M4nR4aWy7nA0OzoHp6pozJMxDtMCN1WMTeLCYGg8CLWFMaF6RkQ0qHN+1QWYGgcHkNsB3CGv7cr
 WO1tczFHEiEZWwW6aTQlVIF04wQubTRJYOU4rcXtgll1D3zkDxXJCl+dByBS+CrzHAQKkQHKSOW
 iQL2GK+Z5P++nVEFGKDmzKLgOjcfsjkqVAN7QMyCqIdDD6TjW+8ynbYcgaNr8u9+nzXOS5x9QAG
 VoJzJHA0cCLfnHsEhzYC5cH/zP+HA4YJSQQI3OgFmTWN2Y31MssG6jcHy0ek83KTtw6jHqwatu/
 Pz0VldYchicuf/8P7WRAfPLmt0/m+uFRjs82khZvvwczPpnRLiBzVQHW/qlUBIyfe5y/O5L/dmo
 WLt+udcLZBFQHbovtGkvt4iBAiqoW+upMjq/u7fXZYyqqVWt2fDdcoQZiire73IzsrF5Mpyn6Nr
 S5ItAsywaRshS30KR/w==
X-Authority-Analysis: v=2.4 cv=UPDt2ify c=1 sm=1 tr=0 ts=6a2ac440 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=fwZZ1n-ia9gD9N035NoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: JKT9GH1xJ6TTg0hzo7gMOVhH9Aw_37fj
X-Proofpoint-GUID: JKT9GH1xJ6TTg0hzo7gMOVhH9Aw_37fj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
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
Changes in v2: No change.

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

