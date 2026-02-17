Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2616E83856
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 05:44:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F7EE40689;
	Tue, 17 Feb 2026 06:44:27 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A99DA4069D
 for <dev@dpdk.org>; Tue, 17 Feb 2026 06:44:25 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61H1KJ4b798873 for <dev@dpdk.org>; Mon, 16 Feb 2026 21:44:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=E
 CrcmP/wyjV5VmfHSKVS9QZh6loleEtvzlyG+yU/hOA=; b=jZddUZwRY1+MHJ2Mn
 +cSkl3mYl7fYdYeCIRHnY5TSIPJXTqmUFbAccT7953PUmzGiAF1kI8pBgtVUu8SL
 byCaCw5JZE/IS/HzWDFUTaqZLuAXXVouoNJxayYAXJHRXQilt5jJ3FmZcpHp6JDU
 umwGBc/g6Wxep1m9QF+J5gHly9L1+158mEW0G1xOTpbAnZhFDPW0BanyZ1emq9MH
 sEaNYoPSg4rf/P0EqgsOUWuzI+W1/Fn+tZAGlaGIyRFbgGFA9BIdFxwTHFOeWUAk
 nVQK59kE0+2Z5jGVepO4RUNorD0yeEMn8w0jrZMGcoawy6jJvEyxZcZuoRx08VAZ
 4R2eQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cccxf8d1h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 16 Feb 2026 21:44:24 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Feb 2026 21:44:40 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 16 Feb 2026 21:44:40 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id B1A775B696D;
 Mon, 16 Feb 2026 21:44:20 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 08/18] net/cnxk: add CPT code check for soft expiry
Date: Tue, 17 Feb 2026 11:13:35 +0530
Message-ID: <20260217054345.2759687-8-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217054345.2759687-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
 <20260217054345.2759687-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=cdbfb3DM c=1 sm=1 tr=0 ts=69940038 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8 a=v69dt79VaSGfBV6H58AA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0NSBTYWx0ZWRfX2pnLzxsYOkc8
 DRL83sgoFfDOX1SGVAbnngy30iU/vtg/vK+UFZGHX4nsMtC8qfZvwlZ/uz19miH7z+SOA5lFTYD
 osHCmuRm6yJLMMSzJeY3/uqehzTNFSsucfWxyNb5/VjThAszb2kRni97GfERAdaHLuZ0oQjW5d3
 nm/jssjfgs5+jFaRkshl94+e1U6ErAe9rSncdRDGnfuA7KN3S7Z3ORib5mqjjsBwRFLZWSyMqTj
 1dhT98gzsEovPTjCU9H57gX/fP6trFA3/Tpm3QAUF35/gbK1T2aRvy0JnH3hA5cyyqK6+JJTWLJ
 MUMTt7gt/a3J7WHgt2QndaS1wejB7FKowXX3ASXVCgIkTcrvDeqCTCVP3tWiV0mtMPhCVehhYRC
 dJQHc9OniJJMNlriv5NaYCBq54c2Jw89LXoeAajFF1lhnumi9s6qceHpMZ6T6m2XRAO26iaP5al
 r5VafqgTw+CIQidibSw==
X-Proofpoint-ORIG-GUID: UhfhVjcI51HUN_5ABJLgS6EC95ql87in
X-Proofpoint-GUID: UhfhVjcI51HUN_5ABJLgS6EC95ql87in
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
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

Add CPT ucode 0xF2 check as well for soft expiry handling.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v2: No change.

 drivers/net/cnxk/cn20k_ethdev_sec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/cnxk/cn20k_ethdev_sec.c b/drivers/net/cnxk/cn20k_ethdev_sec.c
index baa3423e28..bddc02eb3b 100644
--- a/drivers/net/cnxk/cn20k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn20k_ethdev_sec.c
@@ -464,6 +464,7 @@ cn20k_eth_sec_post_event(struct rte_eth_dev *eth_dev, struct roc_ow_ipsec_outb_s
 			desc.subtype = RTE_ETH_EVENT_IPSEC_SA_BYTE_HARD_EXPIRY;
 		break;
 	case ROC_IE_OW_UCC_SUCCESS_SA_SOFTEXP_FIRST:
+	case ROC_IE_OW_UCC_SUCCESS_SA_SOFTEXP_AGAIN:
 		if (sa->w2.s.life_unit == ROC_IE_OW_SA_LIFE_UNIT_PKTS)
 			desc.subtype = RTE_ETH_EVENT_IPSEC_SA_PKT_EXPIRY;
 		else
--
2.34.1

