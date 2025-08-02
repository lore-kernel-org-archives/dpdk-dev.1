Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A793DC87FD2
	for <dpdk-dev@archiver.kernel.org>; Sat,  2 Aug 2025 04:30:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB83840A87;
	Sat,  2 Aug 2025 06:30:24 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id CECF24028F;
 Sat,  2 Aug 2025 06:30:21 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.78.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 31692E0E82;
 Sat,  2 Aug 2025 08:30:20 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 31692E0E82
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1754109020;
 bh=UKPBUCeYQt/zPEdsfe+3riJkSAiuuiJP8IVOK4U7hsI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vvdadHG9CsstlZVvtDU8NH5MIzCzyvlJv6OMgQxoTZ6OWVcPgUBzOXb5uE9CAJHU1
 7Lo4HvOFy66Z5vw30r5D9XoPPFUQ/SdD/v2gHoT72ymTw5Ynhm/H6hIj1feU+4xo2Z
 1P9QmKbT/iBc9PHQKEEZB5jkHQ4VO2Q1Hx1YMCooMM0Gyd50I2u0FaFmzzkZlBFXDm
 UwjJG/4fww2+LpSEa5yTM6T7iF+DG8DY33F8lEkWP4GRIbzfRt7g7mLe2o0zvRa7T7
 HO5jBfQH1VvHCy9pnSOD06kqOJhehmsDR8Z84u9IngjhcnCS+PFxgauO2o7oBKgX8Q
 oMcytPYidGwaQ==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 stable@dpdk.org
Subject: [PATCH v2 2/2] common/sfc_efx/base: clean up type-related compiler
 warnings
Date: Sat,  2 Aug 2025 08:30:10 +0400
Message-Id: <20250802043010.39134-3-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250802043010.39134-1-ivan.malov@arknetworks.am>
References: <20250711144349.9236-1-ivan.malov@arknetworks.am>
 <20250802043010.39134-1-ivan.malov@arknetworks.am>
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
Fixes: f2f77453cb9f ("common/sfc_efx/base: fill in software LUT for MAC statistics")
Cc: stable@dpdk.org

Suggested-by: Andy Moreton <andy.moreton@amd.com>
Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
---
 drivers/common/sfc_efx/base/efx_np.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index d7692fdba7..222d81c12e 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -750,7 +750,7 @@ efx_np_stat_describe(
 	return;
 
 found:
-	if (sw_id >= lut_nentries) {
+	if ((unsigned int)sw_id >= lut_nentries) {
 		/*
 		 * Static mapping size and the size of lookup
 		 * table are out-of-sync. Should never happen.
@@ -1383,7 +1383,7 @@ efx_np_link_ctrl(
 	}
 
 	EFSYS_ASSERT(cap_enum_hw <= UINT8_MAX);
-	fec = cap_enum_hw;
+	fec = (uint8_t)cap_enum_hw;
 
 	MCDI_IN_SET_WORD(req, LINK_CTRL_IN_LINK_TECHNOLOGY, link_tech);
 	MCDI_IN_SET_DWORD(req, LINK_CTRL_IN_CONTROL_FLAGS, flags);
-- 
2.39.5

