Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA9FD3567F
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 06:04:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 420E7402E5;
	Wed, 28 Jan 2026 07:04:01 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1B44F402E5
 for <dev@dpdk.org>; Wed, 28 Jan 2026 07:03:58 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60S1MwJf3583354 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:03:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=/
 fqijtmtZi78GsUuH2dmoJYK0103oMixKCGl7ivu9ns=; b=P7bdbZWHeLJpPM2to
 u95/gmBTSk4jwfHrmNYaFXoqoOUO/8LoUAXhQ+BeA0bEA6iKJ0QDxZJkYGkJaL7y
 Y71WnFcBCi6jskD7B0LuLguxt4sC1MOew3xBTC8HtZXe+Df6dni8ZsBkJXZfQsvX
 F80GWsiQCjb0VktxPe/YDW7ISkOlly6NLQ1VFzLFe4zDhQCapGXo41qeHO57FUyC
 B3TDauDgzKSdj2U5yuC2Jax9b9S+TPJQMXbLhmumYdaCS9Maai3KbZvzF+plBs1O
 pWkd4kxmsxXg/LPX1B0vkoshkJnEzakbjOqXZd7EBBXTM0mC88CI3yVf9k101YO7
 varug==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4by8r68f0h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:03:57 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 22:03:56 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 22:03:56 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id A972E3F706F;
 Tue, 27 Jan 2026 22:03:53 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 05/18] common/cnxk: update inline profile ID for cn20k
Date: Wed, 28 Jan 2026 11:33:03 +0530
Message-ID: <20260128060316.3967610-5-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128060316.3967610-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Ka/fcAYD c=1 sm=1 tr=0 ts=6979a6cd cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=pEjzAy1FaGkatut210AA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA0NiBTYWx0ZWRfX+YyzXVMnvwNf
 7aSggT5GLfo3cCtd/Ev0lrKSvMkGUi5FZt1nNbx6uVoCYRDb+7Bis1AKiX08Kl4tOK+yWSy59lM
 U0c/+eF3JMiA/rllC51Ehz2Otu6qs+tUMw2/IFMpyIkMyx/h6sKtLCKfzaq2hI143nkp6thzY//
 ujovpCguItDWqTthnOLJFBBBVXxF+Yc0jlDUrG6JfGbBs8Kswo2OYdGsYYzltG1sDyDFN63TNqp
 EimoVVmtZta6nDkj33Z1C6xw/vAPvLx4rdxQA7ZDTVfeDPemGUk3NFAmnmLELWNjOOGpH8Mq5+Y
 RGAbwoZWkOQcsHyA/yVMolC+0NUDpKyFRLsiO9hapYjeFsHhzpwqtAIeiK5AEM17tGy5xOm2ulY
 DOy1qyEsItXvg8VouWLCD65tm0U4vF7eYhs88k2O82LkxkQ/eZx+PB1gG5pmh32pFm4emx26imK
 lNywjclj5kMDSVe60Dg==
X-Proofpoint-GUID: mxLvDdNxlcM7Dr8-aVu8-SCmPyYw0qDY
X-Proofpoint-ORIG-GUID: mxLvDdNxlcM7Dr8-aVu8-SCmPyYw0qDY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
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

Update inline IPsec profile ID in nix_spi_to_sa_add mbox
as required by ROC_NPC_SEC_ACTION_ALG4 for cn20k.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/roc_npc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/common/cnxk/roc_npc.c b/drivers/common/cnxk/roc_npc.c
index 56e0e05b63..7846913417 100644
--- a/drivers/common/cnxk/roc_npc.c
+++ b/drivers/common/cnxk/roc_npc.c
@@ -491,6 +491,7 @@ npc_parse_spi_to_sa_action(struct roc_npc *roc_npc, const struct roc_npc_action
 			   struct roc_npc_flow *flow, uint8_t *has_spi_to_sa_action)
 {
 	const struct roc_npc_sec_action *sec_action;
+	struct roc_nix *roc_nix = roc_npc->roc_nix;
 	struct nix_spi_to_sa_add_req *req;
 	struct nix_spi_to_sa_add_rsp *rsp;
 	struct nix_inl_dev *inl_dev;
@@ -546,6 +547,9 @@ npc_parse_spi_to_sa_action(struct roc_npc *roc_npc, const struct roc_npc_action
 		req->spi_index = plt_be_to_cpu_32(flow->spi_to_sa_info.spi);
 		req->match_id = flow->match_id;
 		req->valid = true;
+		if (roc_model_is_cn20k())
+			req->inline_profile_id =
+				roc_nix_inl_inb_ipsec_profile_id_get(roc_nix, true);
 		rc = mbox_process_msg(mbox, (void *)&rsp);
 		if (rc)
 			return rc;
-- 
2.34.1

