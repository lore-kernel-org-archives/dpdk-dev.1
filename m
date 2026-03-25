Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94355FEA807
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 05:18:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C89640613;
	Wed, 25 Mar 2026 06:18:08 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id B949940650
 for <dev@dpdk.org>; Wed, 25 Mar 2026 06:18:06 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OMBPO11306507 for <dev@dpdk.org>; Tue, 24 Mar 2026 22:18:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=xf3EV2XjUEMkAM2GhkQlVKG
 p0BFScBnB5phqVV2HVZQ=; b=BPXIImco9l1HJmLy/yMhFwVSabiu9QcUdIz5C4V
 yOLPK3Mj1P/kazeVva58914fFiAwUmdc3qbfpd/unytl08OMjU/Sz8dVWT9q40Ok
 D4gJ8+GwSROH0gsfarmq9WGaMPDuXu0h+U4g+3c/bRswED6z6IRG2TZKZcHZdpJW
 XUWNLY8u76t0gywfga6ZN7rLbg7UkJVeBzwjjrIdb+Zzytl1ZKCpMgBed6kgHx3D
 e5xuiVBouFl2TgDOhmegUu66zX65IkCZHXNz1q1+FCFPMAncZGyM7EFQXahUtQdt
 Wht+ik8lPBGo//RpS2xeObE8hiKhbgfAqvwCjNPonmifxjg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4d436bgt2x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 24 Mar 2026 22:18:05 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Mar 2026 22:18:04 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Mar 2026 22:18:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 24 Mar 2026 22:18:03 -0700
Received: from cavium-DT-30.. (unknown [10.28.36.108])
 by maili.marvell.com (Postfix) with ESMTP id AD5D43F7076;
 Tue, 24 Mar 2026 22:18:00 -0700 (PDT)
From: Nawal Kishor <nkishor@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <asekhar@marvell.com>, Nawal Kishor
 <nkishor@marvell.com>
Subject: [PATCH] common/cnxk: allow typecasting to CN20K NPA structuress
Date: Wed, 25 Mar 2026 10:47:52 +0530
Message-ID: <20260325051756.2588380-1-nkishor@marvell.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAzNCBTYWx0ZWRfXykzoZk2lFRG2
 p0ugTAtlFl4qMpPQeWtmcIvi8oTDmVERyDchxbwW49mhXOeSA3bAC9dY49VMXOyz3M9/pF2ZT15
 NW7aRjNiNVwyUJHoNksNsHQKC1LMa/UVBA4oqsdju8xTgAOGB9AhSjkJ6vn1AXAymBiPL4UgoQD
 4EJDTiR4f6+0iEdMPtAYh0wh6ISaK8gZccuvGv8/MLA8/7u4fJoy/GDGGc9ZBejiH/6G/1uO6Im
 rxKwmqqb6AgluY0CpcdGAUcmfXJA+VyFPx77SdkPkC4UA1c6ncy1NhnQHKX8jP3i0vVn+N6rED+
 8nAtGxX+SgQHWnNzoOt5RdvK+AUDOvSB8GqM5/pU00E3fqg8rLGoQiQ20y1Uz6qbzjEOMoEUMSt
 utTxORwbLcJYGKeWC6cqX/rMRYbPMtOs7y0DdpA/CZOGYIrUKchtNPcRCxspEDX6DfoH5Z1li3I
 EJ7qzVu5ZgOssYFGsQQ==
X-Proofpoint-GUID: pqzJFl60V1uYBt0vVpyJoX6Rk8ziZGDK
X-Proofpoint-ORIG-GUID: pqzJFl60V1uYBt0vVpyJoX6Rk8ziZGDK
X-Authority-Analysis: v=2.4 cv=M5dA6iws c=1 sm=1 tr=0 ts=69c3700e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=rRErOu2CI5SyagfKl2QA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_02,2026-03-24_01,2025-10-01_01
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

Add __attribute__((may_alias)) to the CN20K-specific NPA structures
(npa_cn20k_aura_s, npa_cn20k_pool_s, and npa_cn20k_halo_s) to allow
safe type punning when casting between these structures and their
base types (npa_aura_s and npa_pool_s).

This attribute tells the compiler that these structures may alias
with other types, which is necessary when casting pointers between
compatible hardware register structures that share the same memory
layout. Without this attribute, such casts violate strict aliasing
rules and can lead to incorrect compiler optimizations.

Signed-off-by: Nawal Kishor <nkishor@marvell.com>
---
 drivers/common/cnxk/hw/npa.h       | 8 +++++---
 drivers/common/cnxk/roc_platform.h | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/common/cnxk/hw/npa.h b/drivers/common/cnxk/hw/npa.h
index 8d6b6bbe8b..aea24b69da 100644
--- a/drivers/common/cnxk/hw/npa.h
+++ b/drivers/common/cnxk/hw/npa.h
@@ -5,6 +5,8 @@
 #ifndef __NPA_HW_H__
 #define __NPA_HW_H__
 
+#include "roc_platform.h"
+
 /* Register offsets */
 
 #define NPA_AF_BLK_RST		     (0x0ull)
@@ -389,7 +391,7 @@ struct npa_cn20k_aura_s {
 	uint64_t stream_ctx : 1;
 	uint64_t unified_ctx : 1;
 	uint64_t rsvd_511_448 : 64; /* W7 */
-};
+} __plt_may_alias;
 
 /* NPA pool context structure [CN20K] */
 struct npa_cn20k_pool_s {
@@ -465,7 +467,7 @@ struct npa_cn20k_pool_s {
 	uint64_t rsvd_895_832 : 64;  /* W13 */
 	uint64_t rsvd_959_896 : 64;  /* W14 */
 	uint64_t rsvd_1023_960 : 64; /* W15 */
-};
+} __plt_may_alias;
 
 /* NPA halo context structure [CN20K] */
 struct npa_cn20k_halo_s {
@@ -545,7 +547,7 @@ struct npa_cn20k_halo_s {
 	uint64_t reserved_895_832 : 64; /* W13 */
 	uint64_t reserved_959_896 : 64; /* W14 */
 	uint64_t reserved_1023_960 : 64; /* W15 */
-};
+} __plt_may_alias;
 
 /* NPA queue interrupt context hardware structure */
 struct npa_qint_hw_s {
diff --git a/drivers/common/cnxk/roc_platform.h b/drivers/common/cnxk/roc_platform.h
index e22a50d47a..73cc12e567 100644
--- a/drivers/common/cnxk/roc_platform.h
+++ b/drivers/common/cnxk/roc_platform.h
@@ -100,6 +100,7 @@
 #define __plt_packed_begin  __rte_packed_begin
 #define __plt_packed_end    __rte_packed_end
 #define __plt_unused	    __rte_unused
+#define __plt_may_alias	    __rte_may_alias
 #define __roc_api	    __rte_internal
 #define plt_iova_t	    rte_iova_t
 
-- 
2.48.1

