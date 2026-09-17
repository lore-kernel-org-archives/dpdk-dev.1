Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD64C982CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:15:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B5E1427C7;
	Thu, 17 Sep 2026 09:15:01 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C8D5B42D72
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:14:58 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H68ZEN086029 for <dev@dpdk.org>; Thu, 17 Sep 2026 00:14:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=t
 gz42Bt/G5s7/mHgNrbZrNpj7Am8qyBtdBVX6FsAUiA=; b=Ho9C5brP6dgjKr+jV
 QE6t4Qp6JaWkDVWPZ0qirBEkzT4MUX3KVTMipEkyjP86Kl+DNNddzYOdxMZHVelb
 gxzj7QBBCleYaasYCP+Uckl9sYqsaazKpFjH87+CubtGi+434ZxZOlQGAAcF4129
 UExG47hePr5jBwDROO3IkxjaYrN7ObJ2R7GNi64cIUsP40TH4+nDzO4PlY4b12HY
 S32K5VJBcw9lDhPWz+BrJDvAyUq/oCcGJJ6TjWKl66Hi1GEzNfDovtN4XzvvYbxb
 DrqzMbBNhoHtV4Qwucb2Zal87fE0t150gSpoHhvuMKjScJ6VOQZcfWuDbXF4+7oE
 qLlwA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gqqujq6w9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 17 Sep 2026 00:14:57 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Sep 2026 00:14:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 17 Sep 2026 00:14:56 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id E258E5C68E1;
 Thu, 17 Sep 2026 00:14:52 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Alok Mishra <almishra@marvell.com>
Subject: [PATCH 12/14] common/cnxk: update mode param for link speed
Date: Thu, 17 Sep 2026 12:40:14 +0530
Message-ID: <20260917071016.2366467-12-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917071016.2366467-1-rbhansali@marvell.com>
References: <20260917071016.2366467-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX6F5hjyo2HkN2
 y5SZ7hhUIDL3J9QXw7T/dqwS7pP1LOSXBvqi2L+E+8Za2zIXZ1EWL1TI6T9CVnMQKf2FxRXdnHV
 An3+fxpPldg7bbuUWRZIlmc/SHEjIBquZENRf2bKgCZyWFxaIK6SblqkEhBP9Gq/opfhmZRGJAh
 rFLUGwAeGIlUn24ZpzqjeU/Krr3P7A2tBxwwj/mX7jI4F5gj/9cm6yqjaewxMwkdznOuXbwYNXy
 BJLNOlCJy+vETrsQ4sQYv6pODJlEpruAAyj50I+AtzSK5muULFZHH39YwNypDs9Z3KnIvGN+UxN
 YV/6xMqwfeEBTDdHMChiSTx3rYAaxLZo+aNC6SeCKi+j5RStLBQ6XDyLdN5VHhXbkSnRiF2TAuZ
 h7Q/frBEJiOapFtLrK5gSKj3WTdyAfK6NI8RL9oVzLkIK+F6/+lmoaqNAaiWC74Wwe6W/pk+6yt
 xBMBm0QoGcUDibBE6SA==
X-Proofpoint-GUID: _w0Gqo4IFAnu2XqIECpHiKJLy8Drk4lK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX0WtvwQxeBn7c
 3jqSPfW9UYiJYsfTGWOn/ixIfhC4XRN479+HjE462AMx5hn+6JANerPRmXhhdCR8Eu14MsuqDFq
 SxuVcWAB/AJ0DS+HdsbOyPGXsHTcTGw=
X-Authority-Analysis: v=2.4 cv=F6LC5ahN c=1 sm=1 tr=0 ts=6aab9371 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=ooj0HbiI2Gb5U41gRCEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: _w0Gqo4IFAnu2XqIECpHiKJLy8Drk4lK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
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

From: Alok Mishra <almishra@marvell.com>

Populate mode for kernels that uses args.mode for link speed
update.

Signed-off-by: Alok Mishra <almishra@marvell.com>
---
 drivers/common/cnxk/roc_nix_mac.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_nix_mac.c b/drivers/common/cnxk/roc_nix_mac.c
index 4f856677e0..2c8c9a6443 100644
--- a/drivers/common/cnxk/roc_nix_mac.c
+++ b/drivers/common/cnxk/roc_nix_mac.c
@@ -316,6 +316,7 @@ roc_nix_mac_link_info_set(struct roc_nix *roc_nix,
 	struct dev *dev = &nix->dev;
 	struct mbox *mbox = mbox_get(dev->mbox);
 	struct cgx_set_link_mode_req *req;
+	struct cgx_set_link_mode_rsp *rsp;
 	int rc;
 
 	req = mbox_alloc_msg_cgx_set_link_mode(mbox);
@@ -329,8 +330,14 @@ roc_nix_mac_link_info_set(struct roc_nix *roc_nix,
 	req->args.duplex = link_info->full_duplex;
 	req->args.an = link_info->autoneg;
 
+	/* Populate mode for kernels that select it from args.mode. */
+	if (link_info->advertising)
+		req->args.mode = plt_ctz64(link_info->advertising);
+
 	/* Link mode changes takes more time. */
-	rc = mbox_process_tmo(mbox, mbox->rsp_tmo * 4);
+	rc = mbox_process_msg_tmo(mbox, (void **)&rsp, mbox->rsp_tmo * 4);
+	if (!rc)
+		rc = rsp->status;
 exit:
 	mbox_put(mbox);
 	return rc;
-- 
2.34.1

