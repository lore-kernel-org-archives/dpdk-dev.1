Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FAAC87FC9
	for <dpdk-dev@archiver.kernel.org>; Sat,  2 Aug 2025 04:30:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B0AE40A72;
	Sat,  2 Aug 2025 06:30:23 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 91B3D40298;
 Sat,  2 Aug 2025 06:30:20 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.78.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 6B02AE0B90;
 Sat,  2 Aug 2025 08:30:19 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 6B02AE0B90
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1754109019;
 bh=754NMxxSib5sj/O4HADLS4Q3v8xo5RihHW0wL9SvSAo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=xC2WtjmzOf/OytVaI4WxBD+Wdl0UzGDTZqP6lu0tr9KoLfgcbHNBHonGAhkHWQHOL
 OC7s+wZPXx6KpMookMTrjs43ZMcBwzKW5JkaGB0aIwX/M+uhkL7pB5mGGX/0EdTIvO
 PvbadAHD7PVewhjWC1QEdYp3fJNWcaqGE3FSXbFObyHnF5Kh+0pUwC5NTVGhkTvlDX
 sb/en2mozyKdGLtYEVwUG2YtqJuwn3i+XfgryAYo9G45CFEvKaIB8mFpPoihI+OeaD
 0mEiHAduNQ0+C7CMFtxp6r3IIGm7pT3F/FBktlIBCK6D/EPSQGJ5V+NJSLnl1Rx2wq
 dWEEw0otnWvAw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 stable@dpdk.org
Subject: [PATCH v2 1/2] common/sfc_efx/base: resolve warnings about unused
 variables
Date: Sat,  2 Aug 2025 08:30:09 +0400
Message-Id: <20250802043010.39134-2-ivan.malov@arknetworks.am>
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

Fixes: 2a5cf77e6de8 ("common/sfc_efx/base: provide PHY link get method on Medford4")
Fixes: 8e79cd30230d ("common/sfc_efx/base: implement PHY link control for Medford4")
Fixes: f2f77453cb9f ("common/sfc_efx/base: fill in software LUT for MAC statistics")
Cc: stable@dpdk.org

Suggested-by: Andy Moreton <andy.moreton@amd.com>
Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
---
 drivers/common/sfc_efx/base/efx_np.c       | 3 ---
 drivers/common/sfc_efx/base/medford4_phy.c | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index a19c986691..d7692fdba7 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -782,7 +782,6 @@ efx_np_stats_describe(
 	EFX_MCDI_DECLARE_BUF(payload,
 	    MC_CMD_MAC_STATISTICS_DESCRIPTOR_IN_LEN,
 	    MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_LENMAX_MCDI2);
-	efx_port_t *epp = &(enp->en_port);
 	uint32_t nprocessed;
 	efx_mcdi_req_t req;
 	uint8_t *entries;
@@ -1186,7 +1185,6 @@ efx_np_cap_sw_mask_to_hw_enum(
 	__out_opt			uint16_t *enum_hwp)
 {
 	unsigned int sw_nflags_req = 0;
-	unsigned int sw_nflags_sup = 0;
 	uint32_t sw_check_mask = 0;
 	unsigned int i;
 
@@ -1289,7 +1287,6 @@ efx_np_link_ctrl(
 	uint16_t cap_enum_hw;
 	boolean_t supported;
 	efx_mcdi_req_t req;
-	boolean_t phy_an;
 	efx_rc_t rc;
 	uint8_t fec;
 
diff --git a/drivers/common/sfc_efx/base/medford4_phy.c b/drivers/common/sfc_efx/base/medford4_phy.c
index 9ba6dfbc10..16e6dd2d84 100644
--- a/drivers/common/sfc_efx/base/medford4_phy.c
+++ b/drivers/common/sfc_efx/base/medford4_phy.c
@@ -34,7 +34,6 @@ medford4_phy_get_link(
 	efx_np_handle_t nph = enp->en_port.ep_np_handle;
 	efx_np_link_state_t ls;
 	efx_np_mac_state_t ms;
-	uint32_t fcntl;
 	efx_rc_t rc;
 
 	rc = efx_np_link_state(enp, nph, &ls);
-- 
2.39.5

