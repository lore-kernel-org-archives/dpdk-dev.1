Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB42CD98C5
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 16:26:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8793740695;
	Mon, 15 Jun 2026 18:26:47 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3325040695
 for <dev@dpdk.org>; Mon, 15 Jun 2026 18:26:46 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFbZig1123718; Mon, 15 Jun 2026 09:26:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=O
 8T2golSXZPTifoBFwydg+MR5iwk8uCtOUXrEOYCBWQ=; b=HxAE5jgMU73EbS1om
 f19AqrM5mkh2hDBew4q40zFR6z+/CxmOF1tkZPl7OVw97o2WJhjPHenIqQDvq+gZ
 f5RDMjmiOsWfs4yVZDpywIG2t98ruEBF2zvVw7vE+1xh4yqsmJ4za49fsGdH6RlU
 WTe9gox+ebru88qbNI74bBd5SvpdCAhNoRIiq5EucauQ82wn8twdBZVxPkCTxhW6
 dv4RPdQpIcG/VXz3goVgsjH2Kxs9N8dTKsYYIkNlLXRaMCZnx6dSYy27bNjaAdWI
 nZJ4CtchY1B5eV9SWDz+MAKL3v97TyqVoDb+PcTxP0q9TYZE3EQQ8YkC6Lk9xVWi
 DeIpg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4es4jk066d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 09:26:45 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 15 Jun 2026 09:26:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 15 Jun 2026 09:26:43 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id A11FC3F7063;
 Mon, 15 Jun 2026 09:26:40 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, "Stephen
 Hemminger" <stephen@networkplumber.org>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v3 10/20] common/cnxk: fix event type for soft expiry
Date: Mon, 15 Jun 2026 21:54:36 +0530
Message-ID: <20260615162446.578336-10-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260615162446.578336-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260615162446.578336-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: U2-_WM45eTblZmhFp8hz11Nf-AG5UcXP
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a3027c5 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=gDTjZsJq8AtFptEswDsA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX260WOotyq6Ka
 gQ7ZEs2vXNu7LYB7A7w0SXRKRtMrLetxwPdNXEG8bLCpuO23HgZ2YTE30FbN4q6574fS8yPgXCV
 IUFIP7jBSqkwc4CHJVRitA2DPANrAGw=
X-Proofpoint-GUID: U2-_WM45eTblZmhFp8hz11Nf-AG5UcXP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX7EhktOcK8ejY
 KOWH752XkB8GY5otgKm+7Zxdw45U7hYPaleXrwfmSq7zt8xlXKoeYrksd/zNxZh9dtsyHd+VArO
 Qnz+VZLV1ORrn7tSSKSCAAWiCFp0i+NZaAHRC8RicILNJoY09YrPH51/T+Uvn4cm5vSVOYzibkC
 hZBFWzeC6G1zmxnGRRXwSEDyi7IbHpG0SDN5qK6QAKn5y2MaA6Xkmr0lVbCNxwI3jocwalaWj0A
 znEd3fAz9HHBbg9c+BJV5toqWDGhwuPFzTUcdM5ouRn9G/1WzvgFo+kpI7SFVs9gV4wMfth+8mw
 a37zAz8QPXZ6x2HCyAE+6GgIVSZG75jOJZ59aL/gY0MBby3MvzK/HIucW0U7+s4RYrtoOqvx9cX
 2Wc/2dm4exf4LGVprZw5ey71oxC1c3ljq3bKclG3BVnU6w1n2Ic4ScZSRk9SKVQRHiZxdaWdpGC
 +o/S9vSZtMcyQ/pEzsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
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

Fix event type to default for inline soft expiry processing.

Fixes: 4a6154a7bd27 ("common/cnxk: fix array out-of-bounds")

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v3: No change.
Changes in v2: No change.

 drivers/common/cnxk/roc_nix_inl_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index 667209b8a0..bfdeef2688 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -1234,6 +1234,7 @@ inl_outb_soft_exp_poll(struct nix_inl_dev *inl_dev, uint32_t ring_idx)

 		if (sa != NULL) {
 			uint64_t tmp[2];
+			tmp[0] = ~0ULL;
 			inl_dev->work_cb(tmp, sa, NIX_INL_SOFT_EXPIRY_THRD, NULL, port_id);
 			__atomic_store_n(ring_base + tail_l + 1, 0ULL, __ATOMIC_RELAXED);
 			__atomic_fetch_add((uint32_t *)ring_base, 1, __ATOMIC_ACQ_REL);
--
2.34.1

