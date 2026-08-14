Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E65C5CFDB
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:57:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 728C540B9A;
	Fri, 14 Aug 2026 14:56:15 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id E901440A76
 for <dev@dpdk.org>; Fri, 14 Aug 2026 14:56:11 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.78.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 37C37E0B4D;
 Fri, 14 Aug 2026 16:56:11 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 37C37E0B4D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786712171;
 bh=I8BTaqMTEFVE+qIAGF4YRnEywxVim0AUADjddoQV91c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HTWoYA2jQjeRkifX+/vBGAMfZYRbSiBQ6YXuD167qkoEc6SVRn9uUJtSd0ZS8NNma
 reIJ3sp15QAHHAMrvcOvjL5MYCUPby5CyMXHxMr+w7FuylGqBGJKeznBmz51YMILVO
 iGxMwhXmNGP8Rhpw6Arn363vNKH1+AL0cJBcw9mqnvDcs6RIcBs1+7v4eEnpa1fr9S
 Dl1BXi0gG46ub0dSyc29ENuHVeKUySqBPR/2ai6V6oHS/4NW18WLNoyBXrSmBMByew
 xYhIqzKHy+w6sYUSHiCe3E8DRVtQfNrSN51tl2dgamtCwE+PhJci3tZ4Je1Pts18zf
 8L1OUpuAh3wvw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 2/3] common/sfc_efx/base: add support for VADAPTER
 statistics IDs
Date: Fri, 14 Aug 2026 16:56:07 +0400
Message-ID: <20260814125608.13358-3-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260814125608.13358-1-ivan.malov@arknetworks.am>
References: <20260811174821.8930-1-ivan.malov@arknetworks.am>
 <20260814125608.13358-1-ivan.malov@arknetworks.am>
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

From: Andy Moreton <andy.moreton@amd.com>

Add netport VADAPTER statistics IDs for use with VFs.

Signed-off-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
---
 drivers/common/sfc_efx/base/efx_np.c | 45 ++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 6dba75f23d..56617c3a46 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -704,6 +704,51 @@ static const efx_np_stat_t efx_np_mac_stat_map[] = {
 
 #undef EFX_NP_STAT_MAC
 
+#define	EFX_NP_STAT_VADAPTER(_hw, _sw)				\
+	[EFX_MAC_##_sw] = {					\
+		.ens_hw_id = EFX_NP_HW_STAT_ID(VADAPTER, _hw),	\
+		.ens_valid = B_TRUE,				\
+	}
+
+	EFX_NP_STAT_VADAPTER(VADAPTER_RX_UNICAST_PACKETS,
+	    VADAPTER_RX_UNICAST_PACKETS),
+	EFX_NP_STAT_VADAPTER(VADAPTER_RX_UNICAST_BYTES,
+	    VADAPTER_RX_UNICAST_BYTES),
+	EFX_NP_STAT_VADAPTER(VADAPTER_RX_MULTICAST_PACKETS,
+	    VADAPTER_RX_MULTICAST_PACKETS),
+	EFX_NP_STAT_VADAPTER(VADAPTER_RX_MULTICAST_BYTES,
+	    VADAPTER_RX_MULTICAST_BYTES),
+	EFX_NP_STAT_VADAPTER(VADAPTER_RX_BROADCAST_PACKETS,
+	    VADAPTER_RX_BROADCAST_PACKETS),
+	EFX_NP_STAT_VADAPTER(VADAPTER_RX_BROADCAST_BYTES,
+	    VADAPTER_RX_BROADCAST_BYTES),
+	EFX_NP_STAT_VADAPTER(VADAPTER_RX_BAD_PACKETS,
+	    VADAPTER_RX_BAD_PACKETS),
+	EFX_NP_STAT_VADAPTER(VADAPTER_RX_BAD_BYTES,
+	    VADAPTER_RX_BAD_BYTES),
+	EFX_NP_STAT_VADAPTER(VADAPTER_RX_OVERFLOW,
+	    VADAPTER_RX_OVERFLOW),
+	EFX_NP_STAT_VADAPTER(VADAPTER_TX_UNICAST_PACKETS,
+	    VADAPTER_TX_UNICAST_PACKETS),
+	EFX_NP_STAT_VADAPTER(VADAPTER_TX_UNICAST_BYTES,
+	    VADAPTER_TX_UNICAST_BYTES),
+	EFX_NP_STAT_VADAPTER(VADAPTER_TX_MULTICAST_PACKETS,
+	    VADAPTER_TX_MULTICAST_PACKETS),
+	EFX_NP_STAT_VADAPTER(VADAPTER_TX_MULTICAST_BYTES,
+	    VADAPTER_TX_MULTICAST_BYTES),
+	EFX_NP_STAT_VADAPTER(VADAPTER_TX_BROADCAST_PACKETS,
+	    VADAPTER_TX_BROADCAST_PACKETS),
+	EFX_NP_STAT_VADAPTER(VADAPTER_TX_BROADCAST_BYTES,
+	    VADAPTER_TX_BROADCAST_BYTES),
+	EFX_NP_STAT_VADAPTER(VADAPTER_TX_BAD_PACKETS,
+	    VADAPTER_TX_BAD_PACKETS),
+	EFX_NP_STAT_VADAPTER(VADAPTER_TX_BAD_BYTES,
+	    VADAPTER_TX_BAD_BYTES),
+	EFX_NP_STAT_VADAPTER(VADAPTER_TX_OVERFLOW,
+	    VADAPTER_TX_OVERFLOW),
+
+#undef EFX_NP_STAT_VADAPTER
+
 #define	EFX_NP_STAT_PHY(_hw, _sw)				\
 	[EFX_MAC_##_sw] = {					\
 		.ens_hw_id = EFX_NP_HW_STAT_ID(PHY, _hw),	\
-- 
2.47.3

