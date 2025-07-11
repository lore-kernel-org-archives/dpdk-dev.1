Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B56C83F1B
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Jul 2025 14:44:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D37D140B8C;
	Fri, 11 Jul 2025 16:44:01 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id B8631406B7
 for <dev@dpdk.org>; Fri, 11 Jul 2025 16:43:59 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.90])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 16F28E0F97;
 Fri, 11 Jul 2025 18:43:59 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 16F28E0F97
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1752245039;
 bh=nX/en78EUxjgTh3PZW0r1KilzXIQoSQvi2dM1fT7UxA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=zspibfCpjAfmdz77IwqSfhiDZs1+i6MMGNB/EEuNVGYAkwMdRHBWI80u0pf1lUDSK
 t7yVhazsaSdCGXgPx/UypNy3EnJyiVvyiRDCsfA7Ca1h/KZNjl3E40dvzXtYoNMhDZ
 +7/UN0p60wEpeSkhUl6pTP6/OFgNy1ZLPJL4Tm/wAtYrvRIfSVqRsllozml/SA4bQH
 kMj1CPzsaawTais6AybNh2hmQhgBDWfMRXSXS0Az3VNltpwmjKcgUus+XjwLhZxf4j
 zDjuZ8Jq7z4PMZ4efZInQWA599/2d6jGatF0f7BvEwpWdfdNGY2JbNVKpOGP18hKkz
 6io/og1JI3Tzw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 2/3] common/sfc_efx/base: fix compiler warnings in PHY link
 setup
Date: Fri, 11 Jul 2025 18:43:48 +0400
Message-Id: <20250711144349.9236-3-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250711144349.9236-1-ivan.malov@arknetworks.am>
References: <20250711144349.9236-1-ivan.malov@arknetworks.am>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Fixes: 8e79cd30230d ("common/sfc_efx/base: implement PHY link control for Medford4")

Suggested-by: Andy Moreton <andy.moreton@amd.com>
Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/base/efx_np.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 798fcce26c..222d81c12e 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -1185,7 +1185,6 @@ efx_np_cap_sw_mask_to_hw_enum(
 	__out_opt			uint16_t *enum_hwp)
 {
 	unsigned int sw_nflags_req = 0;
-	unsigned int sw_nflags_sup = 0;
 	uint32_t sw_check_mask = 0;
 	unsigned int i;
 
@@ -1288,7 +1287,6 @@ efx_np_link_ctrl(
 	uint16_t cap_enum_hw;
 	boolean_t supported;
 	efx_mcdi_req_t req;
-	boolean_t phy_an;
 	efx_rc_t rc;
 	uint8_t fec;
 
@@ -1385,7 +1383,7 @@ efx_np_link_ctrl(
 	}
 
 	EFSYS_ASSERT(cap_enum_hw <= UINT8_MAX);
-	fec = cap_enum_hw;
+	fec = (uint8_t)cap_enum_hw;
 
 	MCDI_IN_SET_WORD(req, LINK_CTRL_IN_LINK_TECHNOLOGY, link_tech);
 	MCDI_IN_SET_DWORD(req, LINK_CTRL_IN_CONTROL_FLAGS, flags);
-- 
2.39.5

