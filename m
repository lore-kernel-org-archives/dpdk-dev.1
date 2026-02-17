Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFF9E83856
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 05:44:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 847A740677;
	Tue, 17 Feb 2026 06:44:15 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 57CD84066C
 for <dev@dpdk.org>; Tue, 17 Feb 2026 06:44:14 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61H0vhmw1398908 for <dev@dpdk.org>; Mon, 16 Feb 2026 21:44:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=p
 1IDgwiI0wPNNdtD+h/jBS7KfyqhQRBArAoK4Q8rMJA=; b=knksXFUA7z6yQFfov
 u5OLTC5B6Kxr4oD5CEVCfKjKu8xYX6AsHmF3WJrz9vqClbTXUQdKAoylys/gT6Nq
 8xfeXG+HXmMjjjpMVcMOAGR8ufunvi71uWfypKuclHrtnsOlSIvusiQGE3//nvjY
 c7ijT614dIUVy0mFF3ttutMaqVpOpeFbR5wO0mmo38GP0d0cf30QEhq8vPNiQ00A
 JI3tvMslPZfatNF6C4ela9H1dy8+A7Ajv7iksbKVXDSOo8R1dQht+jtIe3/65OiQ
 6WMIRrZRjo6PU/ZsLinPt1HVb2lW4CoJlgoG6vz4QTbQg51ahF3wxa6BkSwAnnsQ
 X1T0g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cbe6ck1jx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 16 Feb 2026 21:44:13 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Feb 2026 21:44:29 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 16 Feb 2026 21:44:29 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 88B435B696D;
 Mon, 16 Feb 2026 21:44:09 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 05/18] common/cnxk: update inline profile ID for cn20k
Date: Tue, 17 Feb 2026 11:13:32 +0530
Message-ID: <20260217054345.2759687-5-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217054345.2759687-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
 <20260217054345.2759687-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=KO9XzVFo c=1 sm=1 tr=0 ts=6994002d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8 a=J18aacAWlIc8EQhHbf8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: SArkl8bSkJyURFf0tEUGVRuDZ96JWYZJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0NSBTYWx0ZWRfX8oZeXCs9UssW
 EM3JW/8Lz4Ysfit8BpKXSISSJ82OmZO0Jf4pXkMtYgXyKCawWFN6GiIow6IuHSVP1pMs49QxCVT
 kTfckS2+nAWxYejxgN6er1qIQLFQPRXJ6CLFVaAczH0+A/jkVm6AOSjRlL9/+Qi072hpSU/YDHw
 XYU+H+9Aw6Dla3V8Z3a7ooyI9OrwpXKLiXHrxE8mNbOejzeG39jr7SPqr44HaqnranyhkhXya5q
 BX9aA01w1LtMmXkJIMYNOdJvDqTUfLsLPvk1XxEfwwPftUX/o4iMHSpGX13KgA/sL08PJK+b3KR
 t07n25JuSSwSYbAKORDu0OWgBZjiwLtJqUVHhtuIY4BvU5YgMYqxBKkBsC+bk3EXQNFyGmefYoo
 oovkyQ09Bz940J3acAvBNQvKh4LKVPBKQPwn1yqMTvpM7vr4bF8FIf8nD6cpWtN5wxbJPzT0Oz2
 fX0IpuwP0ksc0VRSjIw==
X-Proofpoint-GUID: SArkl8bSkJyURFf0tEUGVRuDZ96JWYZJ
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

Update inline IPsec profile ID in nix_spi_to_sa_add mbox
as required by ROC_NPC_SEC_ACTION_ALG4 for cn20k.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v2: No change.

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

