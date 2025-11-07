Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05731CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 10:50:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A56840B92;
	Fri,  7 Nov 2025 11:49:04 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 38A1940BA0
 for <dev@dpdk.org>; Fri,  7 Nov 2025 11:49:01 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A78OmWj3943008 for <dev@dpdk.org>; Fri, 7 Nov 2025 02:49:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=w
 xJWs8URC+e5GcRccWLcjRnhwDVT0Vx8LNgsQPTX7Vo=; b=iXWbN5HHr5UlvZNGR
 bb1QUqmhh7RWHciy1/3sNfEwG3nKPdwoT5DgHU/gWG3942X/AnEu0P/pbaM9j6IW
 Bk/B15omnQNnxrKnRPrz2cxTSkbiqQUmHYfKI45Y8GfB2almVS8epSPLRbLQxgwq
 EfyZgL9a5BIaqcdUseZhkACNqscTGbDnd5Wkl6tRx3XiMHPsmAfU5nA4GV20+7Vr
 giHqPIV8t0hDAAfDgtewFcfAJKVz2B8kAuiD287t1xQ6R68EmWoxlse5UZm3I/dP
 fzJi67bZGpAxrTQymVDWG6eBwEQh7A/q5uJvxs/bMuSdgnWTJlRgwuxiErSV/a1N
 FrFlA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a8pk65sq8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 07 Nov 2025 02:49:00 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 7 Nov 2025 02:48:59 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 7 Nov 2025 02:48:59 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id E4C483F70C7;
 Fri,  7 Nov 2025 02:48:51 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Aarnav JP <ajp@marvell.com>
Subject: [PATCH v4 20/23] common/cnxk: fix CPT res address config for inline
Date: Fri, 7 Nov 2025 16:17:44 +0530
Message-ID: <20251107104747.1131008-20-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107104747.1131008-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251107104747.1131008-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=IqYTsb/g c=1 sm=1 tr=0 ts=690dce9c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=qZSRG9XKnlCErq4bdN8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 6EPn2gPumDKGaCsK5NpMfb2CjZWv4Jh9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4NyBTYWx0ZWRfX/S1rLm/Sg7uR
 nydUcCR4Gq1YqxbM2Pt2y88HF0K2+ThvbrrIbiuBNmOxPs8+0PLcC21fcUBqBPSDqWKIGS85hmz
 YwOHXhn2wr4YglL57QKYs69OnlSdX6VyHIcolBW5BGwrx0q5t8+JX2pwzvHOjx+hleNECBmERnK
 F5a/eN3pXpr/mlwSBjy5N5Qtb/oJOAAy+0t3y53M5mheK5TwCiAXDz1IY+a0NUIse9V9vr77lpY
 PNKnm9st/lvqlyhvPx2EHvVpCRDfWLfKfAeUGEXx9izxmyR6uqvP8ZI+fgjA7h/vNWGLRPLIzBq
 /ynsaLNsxLw0IEhPUcqHUMbFaMI/jpLW6Uk76r1vjpane5koQMdff0xOUDSDmVo3LAJ+7A8JycB
 1gG8QnweXpjfAgCfEnouO78rqzz3TQ==
X-Proofpoint-ORIG-GUID: 6EPn2gPumDKGaCsK5NpMfb2CjZWv4Jh9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
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

From: Aarnav JP <ajp@marvell.com>

Fix CPT res address config logic to avoid garbage values
and trigger only when inline dev is present.

Fixes: 3c31a7485172 ("common/cnxk: config CPT result address for CN20K")
Signed-off-by: Aarnav JP <ajp@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index 6700f556a0..780f4cbbfc 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -581,7 +581,7 @@ nix_inl_reass_inb_sa_tbl_setup(struct roc_nix *roc_nix)
 	struct nix_inl_dev *inl_dev = NULL;
 	uint64_t max_sa = 1, sa_pow2_sz;
 	uint64_t sa_idx_w, lenm1_max;
-	uint64_t res_addr_offset;
+	uint64_t res_addr_offset = 0;
 	uint64_t def_cptq = 0;
 	size_t inb_sa_sz = 1;
 	uint8_t profile_id;
@@ -626,12 +626,11 @@ nix_inl_reass_inb_sa_tbl_setup(struct roc_nix *roc_nix)
 		inl_dev = idev->nix_inl_dev;
 		if (inl_dev->nb_inb_cptlfs)
 			def_cptq = inl_dev->nix_inb_qids[inl_dev->inb_cpt_lf_id];
+		res_addr_offset = (uint64_t)(inl_dev->res_addr_offset & 0xFF) << 48;
+		if (res_addr_offset)
+			res_addr_offset |= (1UL << 56);
 	}
 
-	res_addr_offset = (uint64_t)(inl_dev->res_addr_offset & 0xFF) << 48;
-	if (res_addr_offset)
-		res_addr_offset |= (1UL << 56);
-
 	lf_cfg->enable = 1;
 	lf_cfg->profile_id = profile_id;
 	lf_cfg->rx_inline_sa_base = (uintptr_t)nix->inb_sa_base[profile_id];
-- 
2.34.1

