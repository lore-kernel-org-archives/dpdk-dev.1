Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EB7C5B56A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 17:11:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D752427AE;
	Wed, 12 Aug 2026 19:10:44 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id C138340E6E
 for <dev@dpdk.org>; Wed, 12 Aug 2026 19:10:42 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 18A35E0AD0;
 Wed, 12 Aug 2026 21:10:42 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 18A35E0AD0
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786554642;
 bh=utb15CeTTwRCVo+cx4dHA3Qekh/AVlPgJb9wAVNjJDo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=byRXpY1VnBqryVexdDkcbMt0hhrpFB0KqRXRQgTQFPuyd4fQ5Vs/jpVHY1m4T/tqr
 jsR/D96H13drlcWrmr671y86wWPi4jK5utRx+TQOEbqhxoXpuhL3rFV4yMRJsOBacn
 5xj+OTggdaCAk6ZaeAfa3O8klvWbk6Qsy3Vs5Rg8El1iN2TZnwymkzehUPq2BwRs3/
 JVsAjKMxIU5V1n3SlpQO1E3ijwgozooTZr859VG8G+ZxKT5obZF8Hp0x0Qw9xCkPjy
 Jw8rggNBhVl4ZlHo3u9c70sqrRTjQzgZVTArQXmlPs/h1l9+VdOKvJd56hVRBOEaVu
 BFeAvAicbyQeg==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 2/3] common/sfc_efx/base: add support for VADAPTER
 statistics IDs
Date: Wed, 12 Aug 2026 21:10:38 +0400
Message-ID: <20260812171039.8538-3-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260812171039.8538-1-ivan.malov@arknetworks.am>
References: <20260811174949.8993-1-ivan.malov@arknetworks.am>
 <20260812171039.8538-1-ivan.malov@arknetworks.am>
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
index f35d6aaee1..ca6ae0a9b1 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -705,6 +705,51 @@ static const efx_np_stat_t efx_np_mac_stat_map[] = {
 
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

