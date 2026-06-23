Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3A2CDB470
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 08:55:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64F39402A2;
	Tue, 23 Jun 2026 10:55:44 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id A385040269;
 Tue, 23 Jun 2026 10:55:42 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N6grPG3389119; Tue, 23 Jun 2026 01:55:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=YlJ0vwng2Bd+io4oznq5cOS
 7IFmW4qYkYCdyRqWlY/8=; b=AOh0Wz4TiIWng24AIc+UBTh1pMMpfxuBUTK8KzI
 ZTQRkxOr7XfuhhM2pFozkft6l36sTgyC6sMUbz8uYQtNsxWjSxp3Bf708DRqliaY
 TWDDDJd4PAKL9/VCtdSAPqzpwf5ETntAAJk1fQiAVil2FRgmI1RHkIpe6M5ptoqr
 bhKPyMgikNvocxWnvsSImEMd2pMkPDZFZD2ui9Ao3BgOYfgA0fC5274kXUBwOub4
 w+I05tvFiIMT+1lgcxTn0ARhr1b1y0A8dWFafCl3m/PD/y10+hDPV+Jf7g84jhXm
 uKFtNzyd9Vj5qKDrsY7GlkpHNpB6hLi6LA+Zkz8i22lgumA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eyerdh7ec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 01:55:41 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 23 Jun 2026 01:55:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 23 Jun 2026 01:55:40 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.40.118])
 by maili.marvell.com (Postfix) with ESMTP id A9D7C3F7058;
 Tue, 23 Jun 2026 01:55:37 -0700 (PDT)
From: Aarnav JP <ajp@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, "Rakesh
 Kudurumalla" <rkudurumalla@marvell.com>
CC: <jerinj@marvell.com>, <rbhansali@marvell.com>, Aarnav JP
 <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH] common/cnxk: fix inline dev null dereference
Date: Tue, 23 Jun 2026 14:24:33 +0530
Message-ID: <20260623085433.3190541-1-ajp@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=IvYutr/g c=1 sm=1 tr=0 ts=6a3a4a0d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=PBtO6kZq_AsmdOXJb9gA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3MSBTYWx0ZWRfX71Pd6VPp0jps
 r6R3gl+5JOHM5pOKwunjXtBH0oMzFViAxHRQUK/0GH6jlAaJSLIE6fmdGiGzWdp7D9QUKz6rGrf
 AVu5trmI6LJ+P5we2uwefq2qC1EyHUrDytIlAez9FBglOrYTRipuaW3LEX7UqKBxiSbkdMxW5Th
 FPc6aSLgFIMTuKIK12LHKg9VTtN3y+fkf/QcDDrafxhjc+HYAh6xkxExUzkgOCsBVelq1hZ2DVG
 txZY3aZ///MZp/ld9ubQT9XilmiUxqDs1s13u346/4E4EgFw5HDWmnxR33jXw9mzE/LfKaXFWiQ
 e4eIBvCWQ93kphSRdzHLTh3aUAkGvIR8b6OESCeP81e/vTOW7soLT3YZZESblTCKt56VFUaek+2
 +rzjPVmLvwuWkS6DbWRVLrgI15IOUUTHpMoQJe8tepCgx2QQ1utiLoMxtf2FS5xejw4ZQmyDhFj
 Oenmm8ks9xVTEcZe59Q==
X-Proofpoint-GUID: WoBeo9sR5GOyujAba8qZzIbDwaQjTQ3H
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3MSBTYWx0ZWRfX8tnuQ2Mpk93C
 tSVKh8OsM7XvPDY9k2VjQyn89vO6vx2Vr7B007bu9HdKLjFPP8GW5vToX/ppyEp+Ap/r1OI3qnO
 iKQC32GtdHVXqS2+za/duR4AdiPgkek=
X-Proofpoint-ORIG-GUID: WoBeo9sR5GOyujAba8qZzIbDwaQjTQ3H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
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

inl_dev is initialized to NULL and only assigned within the
if (idev && idev->nix_inl_dev) block.
Move inl_dev->res_addr_offset and inl_dev->cpt_cq_ena
accesses inside this null-guarded block in
nix_inl_inb_ipsec_sa_tbl_setup() and nix_inl_reass_inb_sa_tbl_setup()
to avoid dereferencing a null pointer.

Fixes: 3fdf3e53f3c4 ("common/cnxk: enable CPT CQ for inline IPsec inbound")
Cc: stable@dpdk.org

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index db101e71a5..935dd37778 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -409,7 +409,7 @@ nix_inl_inb_ipsec_sa_tbl_setup(struct roc_nix *roc_nix)
 	struct nix_inl_dev *inl_dev = NULL;
 	uint64_t max_sa, i, sa_pow2_sz;
 	uint64_t sa_idx_w, lenm1_max;
-	uint64_t res_addr_offset;
+	uint64_t res_addr_offset = 0;
 	uint8_t profile_id = 0;
 	struct mbox *mbox;
 	size_t inb_sa_sz;
@@ -503,13 +503,12 @@ nix_inl_inb_ipsec_sa_tbl_setup(struct roc_nix *roc_nix)
 				def_cptq = 0;
 			else
 				def_cptq = inl_dev->nix_inb_qids[inl_dev->inb_cpt_lf_id];
+			res_addr_offset = (uint64_t)(inl_dev->res_addr_offset & 0xFF) << 48;
+			if (res_addr_offset)
+				res_addr_offset |= (1UL << 56);
+			cpt_cq_ena = (uint64_t)inl_dev->cpt_cq_ena << 63;
 		}
 
-		res_addr_offset = (uint64_t)(inl_dev->res_addr_offset & 0xFF) << 48;
-		if (res_addr_offset)
-			res_addr_offset |= (1UL << 56);
-
-		cpt_cq_ena = (uint64_t)inl_dev->cpt_cq_ena << 63;
 		lf_cfg->enable = 1;
 		lf_cfg->profile_id = profile_id; /* IPsec profile is 0th one */
 		lf_cfg->rx_inline_sa_base = (uintptr_t)nix->inb_sa_base[profile_id] | cpt_cq_ena;
-- 
2.43.0

