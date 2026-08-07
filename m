Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82B7C5AC7A
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 10:17:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDF2C40697;
	Fri,  7 Aug 2026 12:17:27 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id DE40440264;
 Fri,  7 Aug 2026 12:17:25 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6771ZPnQ1316138; Fri, 7 Aug 2026 03:17:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=bh7RJoc85q8BO+bWhdeGJra
 k07D1lf3ZzyXh9ulGxpU=; b=HZiuLXYk8gGs8p60y5JzNtzNvYE9eplDhRC5AcI
 IFvFVwOEPw2pIBJiatD+T5VRWdhsxEsw+LFN79K/sG4vrlCkLQr+dhB4Tot5SLKr
 K2aKcC4I6SZyYTUnA9CDiWs2QwP24gZyKid1ZPtRnvKtxKrEyubdOh5OftKbAffS
 JeKunKrfs208bxE/RZGgwoTQIhU54ysf4UGQoHbNG9BYQ5HeDqpeF4cl+bew5WJq
 LMdxVe5eNOUPaoB1LEBakEpP6X0oc2cr9QCvU2zyyjnMaI6k3dKkkSbD1A6uqEya
 nW8C+OMn/J6/W9R0SjDT0DzONEu0pon2bAEjys/IZepqpYw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fw5tys5jn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Aug 2026 03:17:24 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 7 Aug 2026 03:17:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 7 Aug 2026 03:17:24 -0700
Received: from cavium-SR1-T640.. (unknown [10.28.36.102])
 by maili.marvell.com (Postfix) with ESMTP id 7B8BF3F704F;
 Fri,  7 Aug 2026 03:17:21 -0700 (PDT)
From: Akhil Goyal <gakhil@marvell.com>
To: <dev@dpdk.org>
CC: <jpalider@marvell.com>, <tduszynski@marvell.com>, <jerinj@marvell.com>,
 <thomas@monjalon.net>, Akhil Goyal <gakhil@marvell.com>,
 <stable@dpdk.org>, Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH] raw/cnxk_bphy: fix missing doxygen comments
Date: Fri, 7 Aug 2026 15:47:18 +0530
Message-ID: <20260807101718.3571504-1-gakhil@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA3OCBTYWx0ZWRfX8hExSKix5D7J
 pU37k4lDK3K5DLW0r2fxHxgQm12o044Uh77ClapWQwgcVnf1Pm8meFMgPIka0uUmNA7J3ahL8mY
 WI0flQ96wU1UWMp+sB6280ohFTHIyED5YaAj1rq45Z54AvxL2BvW7oP454hrJfaZdKjnioC8hM4
 9tiPsIP+sD/mbCnO0nAayPSPr0p7NyMK1mXIfDjxkldSr0yudEh6sgQmcx7H9PD7+mjpal9+OTR
 rV3VHK4TODHBCj+ro0r2iUzN5tWw/pP171oOPfKbOtyTQyiFEvgNifBgh99MFT1Pky+IM50zYAm
 mGFosbbt9WfWnrjRblFVXjx0Xid7v/oahDwN1aDe9NzMKpFLlX5fgrUMQhpynkb3eebeecnq/aU
 +58FSl4T0PII9wdQVkAoB9uSP6CWR/KflcgCCGQIMj0R+FQqR8H3zH1ZSbCeOi6Uzfbg5fo+S+Z
 Aqy4q+QTU47/P+KHGbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA3OCBTYWx0ZWRfX2bMLdFjhD8Da
 ChXvCCavfEhiCvH2vNN7niWrlQT9o8u7qnYY3y6aSsyhN0sGWPKRxBFOLNMGaBLU4QBHFDWOQqJ
 Dr1TEpUsiu9d68HAEkl8k/rvBtxNsM0=
X-Proofpoint-ORIG-GUID: cSoCC-odAbCcBVITfTdShtcBUReCto10
X-Proofpoint-GUID: cSoCC-odAbCcBVITfTdShtcBUReCto10
X-Authority-Analysis: v=2.4 cv=LMRWhpW9 c=1 sm=1 tr=0 ts=6a75b0b5 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=8rWy6zfcAAAA:8 a=i0EeH86SAAAA:8 a=M5GUcnROAAAA:8
 a=V1_DYYl1hJua2h4WtLwA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
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

Documentation build for raw driver cnxk_bphy,
if included in `doc/api/doxy-api.conf.in`,
fails because of missing dozygen comments.
Added comments to fix the doc build.

Bugzilla ID: 1962
Fixes: 2e8bd307fae3 ("common/cnxk: support switching CPRI/ETH back and forth")
Fixes: bd2fd34ab86f ("common/cnxk: sync eth mode change command with firmware")
Cc: stable@dpdk.org

Reported-by: Marat Khalili <marat.khalili@huawei.com>
Signed-off-by: Akhil Goyal <gakhil@marvell.com>
---
 doc/api/doxy-api.conf.in             | 1 +
 drivers/raw/cnxk_bphy/rte_pmd_bphy.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/doc/api/doxy-api.conf.in b/doc/api/doxy-api.conf.in
index bedd944681..94096ee710 100644
--- a/doc/api/doxy-api.conf.in
+++ b/doc/api/doxy-api.conf.in
@@ -24,6 +24,7 @@ INPUT                   = @TOPDIR@/doc/api/doxy-api-index.md \
                           @TOPDIR@/drivers/net/intel/ixgbe \
                           @TOPDIR@/drivers/net/mlx5 \
                           @TOPDIR@/drivers/net/softnic \
+                          @TOPDIR@/drivers/raw/cnxk_bphy \
                           @TOPDIR@/drivers/raw/dpaa2_cmdif \
                           @TOPDIR@/drivers/raw/ifpga \
                           @TOPDIR@/lib/eal/include \
diff --git a/drivers/raw/cnxk_bphy/rte_pmd_bphy.h b/drivers/raw/cnxk_bphy/rte_pmd_bphy.h
index f668e6ea82..99504dc496 100644
--- a/drivers/raw/cnxk_bphy/rte_pmd_bphy.h
+++ b/drivers/raw/cnxk_bphy/rte_pmd_bphy.h
@@ -174,6 +174,7 @@ enum cnxk_bphy_cgx_eth_link_mode {
 	__CNXK_BPHY_CGX_ETH_LINK_MODE_MAX
 };
 
+/** Available CPRI modes */
 enum cnxk_bphy_cgx_eth_mode_cpri {
 	/** 2.4G Lane Rate */
 	CNXK_BPHY_CGX_ETH_MODE_CPRI_2_4G_BIT,
@@ -191,6 +192,7 @@ enum cnxk_bphy_cgx_eth_mode_cpri {
 	CNXK_BPHY_CGX_ETH_MODE_CPRI_24_3G_BIT,
 };
 
+/** Available mode groups */
 enum cnxk_bphy_cgx_mode_group {
 	/** ETH group */
 	CNXK_BPHY_CGX_MODE_GROUP_ETH,
-- 
2.43.0

