Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056F3E92FE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 21:35:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E8B740612;
	Mon, 29 Dec 2025 22:35:39 +0100 (CET)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 658D9402CA;
 Mon, 29 Dec 2025 22:35:37 +0100 (CET)
Received: from localhost.localdomain (unknown [78.109.70.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 90A7BE1407;
 Tue, 30 Dec 2025 01:35:36 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 90A7BE1407
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1767044137;
 bh=bhAcTgUwk9DPXCmjckQSCVIvlaow9D/SfnnJc2c8R/4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=3bEt6W4cf2/+2iItWRWjwm1ahP2vU9JQ8WA2rhwSu6PTT1huc611HAquJyAxRMe6+
 hTHWjETuePxSyqw1Awd55pgN/15/QknMKmMPBxIjjR7F5ovM55tiVwVYgtdLS8pPdX
 AlukxkN827xvoKLJm2lUkGukt+B293m+/wvhwRAy1N43/y0sU7jnYItC70bTdJZh8x
 lVG3RGfEFoRblwADcXOHGbI7Tsxg55gTU6zUdYD2twSvH8tMX7wuOR7aLT714PHpHJ
 4QAQPOgAJxIlZhD23z7PLPiok2czUiLVZ1tAWltuex/fGHd7ZsdSikupxblYqUsSCw
 +xcFm20DrfJHA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 stable@dpdk.org
Subject: [PATCH 2/9] common/sfc_efx/base: fix flow control setting on legacy
 MCDI
Date: Tue, 30 Dec 2025 01:35:20 +0400
Message-ID: <20251229213527.37907-3-ivan.malov@arknetworks.am>
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

On X2 adaptors, tests have shown a mismatch between the mode the user asks
for and the resulting one, given the partner is set to use autonegotiation.
For example, asking for 'RX_PAUSE' results in 'FULL' being actually in use.

As per 'SET_MAC' MCDI documentation (in 'efx_regs_mcdi.h'), it is wrong to
set 'FCNTL' field to 'AUTO' when the user wants a fixed mode. Correct this.

Fixes: e7cd430c864f ("net/sfc/base: import SFN7xxx family support")
Cc: stable@dpdk.org

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/base/ef10_mac.c | 35 ++++++++++++++++++++------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/common/sfc_efx/base/ef10_mac.c b/drivers/common/sfc_efx/base/ef10_mac.c
index bfc82b80c7..016bd88774 100644
--- a/drivers/common/sfc_efx/base/ef10_mac.c
+++ b/drivers/common/sfc_efx/base/ef10_mac.c
@@ -273,6 +273,7 @@ ef10_mac_reconfigure(
 	efx_mcdi_req_t req;
 	EFX_MCDI_DECLARE_BUF(payload, MC_CMD_SET_MAC_IN_LEN,
 		MC_CMD_SET_MAC_OUT_LEN);
+	uint32_t fcntl;
 	efx_rc_t rc;
 
 	req.emr_cmd = MC_CMD_SET_MAC;
@@ -299,13 +300,29 @@ ef10_mac_reconfigure(
 				    SET_MAC_IN_REJECT_UNCST, 0,
 				    SET_MAC_IN_REJECT_BRDCST, 0);
 
-	/*
-	 * Flow control, whether it is auto-negotiated or not,
-	 * is set via the PHY advertised capabilities.  When set to
-	 * automatic the MAC will use the PHY settings to determine
-	 * the flow control settings.
-	 */
-	MCDI_IN_SET_DWORD(req, SET_MAC_IN_FCNTL, MC_CMD_FCNTL_AUTO);
+	if (epp->ep_fcntl_autoneg != B_FALSE) {
+		fcntl = MC_CMD_FCNTL_AUTO;
+	} else {
+		switch (epp->ep_fcntl) {
+		case 0:
+			fcntl = MC_CMD_FCNTL_OFF;
+			break;
+		case EFX_FCNTL_RESPOND:
+			fcntl = MC_CMD_FCNTL_RESPOND;
+			break;
+		case EFX_FCNTL_GENERATE:
+			fcntl = MC_CMD_FCNTL_GENERATE;
+			break;
+		case EFX_FCNTL_RESPOND | EFX_FCNTL_GENERATE:
+			fcntl = MC_CMD_FCNTL_BIDIR;
+			break;
+		default:
+			rc = EINVAL;
+			goto fail1;
+		}
+	}
+
+	MCDI_IN_SET_DWORD(req, SET_MAC_IN_FCNTL, fcntl);
 
 	/* Include the Ethernet frame checksum in RX packets if it's required */
 	MCDI_IN_POPULATE_DWORD_1(req, SET_MAC_IN_FLAGS,
@@ -321,7 +338,7 @@ ef10_mac_reconfigure(
 		 */
 		if (req.emr_rc != EACCES) {
 			rc = req.emr_rc;
-			goto fail1;
+			goto fail2;
 		}
 	}
 
@@ -338,6 +355,8 @@ ef10_mac_reconfigure(
 
 	return (0);
 
+fail2:
+	EFSYS_PROBE(fail2);
 fail1:
 	EFSYS_PROBE1(fail1, efx_rc_t, rc);
 
-- 
2.47.3

