Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5290CD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 14:21:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17C334326A;
	Thu, 11 Jun 2026 16:21:35 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E788B427CE
 for <dev@dpdk.org>; Thu, 11 Jun 2026 16:21:33 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCXVGv2190487; Thu, 11 Jun 2026 07:21:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
 uWm7e3vroL3vfTxjJXONP40JAdOk4+V3PRcj90mr8A=; b=dDz2IwiSUUb0MXHNQ
 skHBoWZNC1PejpHVMBAbzd61rHtFBQMVusp11FvlW+VrncPPm5AoqXmS7v5Nj4e8
 QVqPoTo5ZEFy1d5XSnfXcXrAV8i+7ZsQ4HNixOBrT0bhk33gD7hnS1ZovbeEzPK/
 +MyyzVC4OdrQ/cQJpuGegoKjbvDg7tWAvKYiyERQRuaqMWXliyrZQbqvVDYXzs0t
 mwsIyf+uW92YSPbBPaibqvDQEYTWlP/Cnjews9c5uS12AkBoVAy2+PtXSf+npE4c
 sd6VS1C10k3TvHgKtVjsoixHYDFUXm7t3HXvXBAsw/D5TepksD85R226WSAQD3oK
 Qu17w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5rb7x4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2026 07:21:33 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 07:21:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 07:21:32 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 5DCD05B6974;
 Thu, 11 Jun 2026 07:21:29 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, "Stephen
 Hemminger" <stephen@networkplumber.org>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 10/22] common/cnxk: fix event type for soft expiry
Date: Thu, 11 Jun 2026 19:50:17 +0530
Message-ID: <20260611142029.3351415-10-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611142029.3351415-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260611142029.3351415-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Zqnd7d7G c=1 sm=1 tr=0 ts=6a2ac46d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=gDTjZsJq8AtFptEswDsA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: mP0LM2C9TffUIG3C_nYaOVMrLkVfBXQ7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfX/ttcxsT+4Ixc
 zby0XVTd7ko4KXorpDYHL1RDjT3ytXDysSlVGa7ky6Qpwot6J1D7lvzSK+ELHQV8wRnQeWzlMLS
 +CPhCLDwlvM/YgtBS5ZU2jIqyL5upVo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfX2fgl7z/EcWwU
 4NzFc0UC2eqmYuEwjJX7oX9WkNLemUSHqIgfay0OAj2vUN/I1+NYyOHnxM8YtfGWIRcaLfD/fMS
 2oFSPicFn2hmesuqgIwx+kwMAXwUnGeeuWUMMrh86mqoI/B31gJpp5xAqBh45YRO65dWuJzUSPz
 nVUa1xzDFpNgdXeKTgDCWt7qsrxxMVsA3Ya0lbUbqap9Z7j8AIwobQiTPedhtVt1QdMPTaDvuep
 HKFY9N3+kCz9jA7P7eFebFzRnU6QyPSgwLzfTrx1FVfebiG6jcBvClpQfNIOZxSx+/3JVLaXzDw
 YtIS7eMOgfjDC2XQ/xTVllow8bDEhotUbvxPoMLa4YaY69eV5w4fctal03dNU1gfZSG7+TO8tm5
 b6MGnDHJjE0JEn5KYYcz5uYnmClRTCT1MM56OVFtAofCi/y0B46uhgN5JbJBQu0hHDFEoDdfgRm
 sTEaC7EhwsIunIJulAw==
X-Proofpoint-ORIG-GUID: mP0LM2C9TffUIG3C_nYaOVMrLkVfBXQ7
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

Fix event type to default for inline soft expiry processing.

Fixes: 4a6154a7bd27 ("common/cnxk: fix array out-of-bounds")

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
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

