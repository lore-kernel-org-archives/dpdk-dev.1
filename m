Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7286FE92FE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 21:36:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C836540677;
	Mon, 29 Dec 2025 22:35:45 +0100 (CET)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id D04F240431;
 Mon, 29 Dec 2025 22:35:40 +0100 (CET)
Received: from localhost.localdomain (unknown [78.109.70.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 330D6E1B6E;
 Tue, 30 Dec 2025 01:35:40 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 330D6E1B6E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1767044140;
 bh=PYYm1TmFwuX8kRutNyZIMeJYZ8OBIfS/DjoULUgB+4M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sCcztAFJEvC8hh2oga/Y2YcmS1BmqJY1tarkKY926M8s5tsnF0aPcus5vukfV6con
 4rd3swsxX9/pDKGCOxuDw3P/IGq/Oc3TiwQqP0CWW9jqIUAzWmq0lQxr1RZ/i+DF8f
 B/OVR93yRjug6IQW12v2FO4GpPVXshREGJYCV+/CbwLtMY1r+kH2ZruvIMubI2XU6a
 i3zZaEMECHmE+Cr8J9sPlS0uJndbwrS0dP6DRgRwJEv7mL8ndSCr6oXKEJA2XE6yOA
 eh1Up0nUNR1cUR1BwIu97S0dZfWcOCtKch9h7CihaAte0D3J0ITcSMYg567p0yYXnT
 axPEGgyF/v0sw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 stable@dpdk.org
Subject: [PATCH 7/9] net/sfc: rework the capability check that is done on FEC
 set
Date: Tue, 30 Dec 2025 01:35:25 +0400
Message-ID: <20251229213527.37907-8-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251229213527.37907-1-ivan.malov@arknetworks.am>
References: <20251229213527.37907-1-ivan.malov@arknetworks.am>
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

The current code that sets new FEC mode does not consult capabilities when
the ethdev is not started. This leads to accepting FEC flags that the last
configured link speed cannot handle. This is shown in 'testpmd' as follows:

port stop all
port config 0 speed 10000 duplex full
port start 0
port stop 0
set port 0 fec_mode rs

In the case of X4 adaptors, RS FEC cannot be supported for such low speeds
and the last command should print 'Function not implemented' error message,
but it doesn't. To fix this, enforce the proper checks in every port state.

Fixes: 5efa8fc1cfc0 ("net/sfc: support FEC feature")
Cc: stable@dpdk.org

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/net/sfc/sfc_ethdev.c | 96 ++++++++++++++++++++++--------------
 1 file changed, 59 insertions(+), 37 deletions(-)

diff --git a/drivers/net/sfc/sfc_ethdev.c b/drivers/net/sfc/sfc_ethdev.c
index 6d2349a999..fc759f52fe 100644
--- a/drivers/net/sfc/sfc_ethdev.c
+++ b/drivers/net/sfc/sfc_ethdev.c
@@ -7,6 +7,8 @@
  * for Solarflare) and Solarflare Communications, Inc.
  */
 
+#include <stdbool.h>
+
 #include <dev_driver.h>
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
@@ -14,6 +16,7 @@
 #include <bus_pci_driver.h>
 #include <rte_errno.h>
 #include <rte_string_fns.h>
+#include <rte_bitops.h>
 #include <rte_ether.h>
 
 #include "efx.h"
@@ -2496,6 +2499,10 @@ sfc_rx_metadata_negotiate(struct rte_eth_dev *dev, uint64_t *features)
 	return 0;
 }
 
+/*
+ * When adding support for new speeds/capabilities, make sure to adjust
+ * validity checks conducted by 'sfc_fec_capa_check' for user input.
+ */
 static unsigned int
 sfc_fec_get_capa_speed_to_fec(uint32_t supported_caps,
 			      struct rte_eth_fec_capa *speed_fec_capa)
@@ -2721,60 +2728,75 @@ sfc_fec_get(struct rte_eth_dev *dev, uint32_t *fec_capa)
 	return -rc;
 }
 
+/*
+ * When adding checks for new speeds and/or capabilities, keep that consistent
+ * with capabilities that 'sfc_fec_get_capa_speed_to_fec' reports to the user.
+ */
 static int
 sfc_fec_capa_check(struct rte_eth_dev *dev, uint32_t fec_capa,
 		   uint32_t supported_caps)
 {
-	struct rte_eth_fec_capa *speed_fec_capa;
-	struct rte_eth_link current_link;
-	bool is_supported = false;
-	unsigned int num_entries;
-	bool auto_fec = false;
-	unsigned int i;
-
 	struct sfc_adapter *sa = sfc_adapter_by_eth_dev(dev);
-
-	if (sa->state != SFC_ETHDEV_STARTED)
-		return 0;
+	unsigned int ncaps = rte_popcount32(fec_capa);
+	/* Set by 'sfc_phy_cap_from_link_speeds'. */
+	uint32_t speeds_cur = sa->port.phy_adv_cap;
+	uint32_t speeds_baser = 0;
+	uint32_t speeds_rs = 0;
 
 	if (fec_capa & RTE_ETH_FEC_MODE_TO_CAPA(RTE_ETH_FEC_AUTO)) {
-		auto_fec = true;
-		fec_capa &= ~RTE_ETH_FEC_MODE_TO_CAPA(RTE_ETH_FEC_AUTO);
+		if (ncaps == 1) {
+			/* Let the FW choose a best-effort setting. */
+			return 0;
+		} else {
+			/*
+			 * Each requested FEC capability must be supported in
+			 * general and at least one speed that supports this
+			 * FEC mode must be currently advertised/configured.
+			 */
+		}
+	} else if (ncaps != 1) {
+		/*
+		 * Fixed FEC mode does not allow for multiple capabilities.
+		 * Empty mask is invalid, as No-FEC has a capability bit.
+		 */
+		return EINVAL;
+	} else if (fec_capa & RTE_ETH_FEC_MODE_TO_CAPA(RTE_ETH_FEC_NOFEC)) {
+		/* No-FEC is assumed to be always acceptable. */
+		return 0;
 	}
 
-	/*
-	 * If only the AUTO bit is set, the decision on which FEC
-	 * mode to use will be made by HW/FW or driver.
-	 */
-	if (auto_fec && fec_capa == 0)
-		return 0;
+	/* 25G BASE-R is accounted for separately below. */
+	speeds_baser |= (1U << EFX_PHY_CAP_50000FDX);
+	speeds_baser |= (1U << EFX_PHY_CAP_40000FDX);
+	speeds_baser |= (1U << EFX_PHY_CAP_10000FDX);
 
-	sfc_dev_get_rte_link(dev, 1, &current_link);
+	speeds_rs |= (1U << EFX_PHY_CAP_200000FDX);
+	speeds_rs |= (1U << EFX_PHY_CAP_100000FDX);
+	speeds_rs |= (1U << EFX_PHY_CAP_50000FDX);
+	speeds_rs |= (1U << EFX_PHY_CAP_25000FDX);
 
-	num_entries = sfc_fec_get_capa_speed_to_fec(supported_caps, NULL);
-	if (num_entries == 0)
-		return ENOTSUP;
+	if (fec_capa & RTE_ETH_FEC_MODE_TO_CAPA(RTE_ETH_FEC_BASER)) {
+		bool supported = false;
 
-	speed_fec_capa = rte_calloc("fec_capa", num_entries,
-				    sizeof(*speed_fec_capa), 0);
-	num_entries = sfc_fec_get_capa_speed_to_fec(supported_caps,
-						    speed_fec_capa);
+		if ((supported_caps & EFX_PHY_CAP_FEC_BIT(25G_BASER_FEC)) &&
+		    (speeds_cur & (1U << EFX_PHY_CAP_25000FDX)))
+			supported = true;
 
-	for (i = 0; i < num_entries; i++) {
-		if (speed_fec_capa[i].speed == current_link.link_speed) {
-			if ((fec_capa & speed_fec_capa[i].capa) != 0)
-				is_supported = true;
+		if ((supported_caps & EFX_PHY_CAP_FEC_BIT(BASER_FEC)) &&
+		    (speeds_cur & speeds_baser))
+			supported = true;
 
-			break;
-		}
+		if (!supported)
+			return ENOTSUP;
 	}
 
-	rte_free(speed_fec_capa);
-
-	if (is_supported)
-		return 0;
+	if (fec_capa & RTE_ETH_FEC_MODE_TO_CAPA(RTE_ETH_FEC_RS)) {
+		if ((supported_caps & EFX_PHY_CAP_FEC_BIT(RS_FEC)) == 0 ||
+		    (speeds_cur & speeds_rs) == 0)
+			return ENOTSUP;
+	}
 
-	return ENOTSUP;
+	return 0;
 }
 
 static int
-- 
2.47.3

