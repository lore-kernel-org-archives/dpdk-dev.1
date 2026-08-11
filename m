Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716BBC5B56A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 17:51:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 598C442789;
	Tue, 11 Aug 2026 19:50:34 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 832D4427DC
 for <dev@dpdk.org>; Tue, 11 Aug 2026 19:50:30 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id CFDA3E0D23;
 Tue, 11 Aug 2026 21:50:29 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am CFDA3E0D23
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786470630;
 bh=hZ/FDa3ReYI281tygaovJwO7UFhU6XUKe5AQOsCL4GA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=zvPPJ2REL/Z6eirwnV3JWN9w+oo38C+YBjcJ0V4kR61peedMBTTHb/w8+/TAwKg79
 qd9EouS4n/0rgZ+/3yXOy0vJQNXpYmvrwuK0bcipIt4ORmCiIB4PW2mW3ZkWq87wkA
 1SkigNpOdpNKsd4DSDQVYdF0nFtucKsCtuMz7h3IofqQSu7llhn8xVGA5tuoUMuYBI
 /i+PTn9LyNAYd/jSwY6KEE/eEmGxj8p/q98jJh1mo4stIT8L/n9mZsRepmYyvq00aj
 E/jsa8v13acAQRbtKNUhZlXz7pSKHHuq8vbmd2trIyhK13/GfZcz8zpz5+2aAA+TTo
 elwAe3sHHvKgQ==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 4/6] common/sfc_efx/base: deny tuning FCS and flow control to
 VFs
Date: Tue, 11 Aug 2026 21:50:23 +0400
Message-ID: <20260811175025.9019-5-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260811175025.9019-1-ivan.malov@arknetworks.am>
References: <20260811175025.9019-1-ivan.malov@arknetworks.am>
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

Medford4 VFs can configure MAC settings via the netport MCDI,
but controlling FCS stripping and setting flow control mode
are off limits. Express all this in code to allow the DPDK
driver to start and forbid changes to FCS and flow control.

For what it's worth, changing MTU is allowed on VFs, but
the value must be less than or equal to the PF's MTU.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/base/efx_np.c | 41 +++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 1563fbae37..6d9c62fcda 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -1548,6 +1548,7 @@ efx_np_mac_ctrl(
 	__in		efx_np_handle_t nph,
 	__in		const efx_np_mac_ctrl_t *mc)
 {
+	const efx_nic_cfg_t *encp = &enp->en_nic_cfg;
 	EFX_MCDI_DECLARE_BUF(payload,
 	    MC_CMD_MAC_CTRL_IN_LEN,
 	    MC_CMD_MAC_CTRL_OUT_LEN);
@@ -1571,9 +1572,19 @@ efx_np_mac_ctrl(
 	if (mc->enmc_set_pdu_only != B_FALSE)
 		goto skip_full_reconfigure;
 
-	cfg |= 1U << MC_CMD_MAC_CONFIG_OPTIONS_CFG_INCLUDE_FCS;
-	if (mc->enmc_include_fcs != B_FALSE)
-		flags |= 1U << MC_CMD_MAC_FLAGS_FLAG_INCLUDE_FCS;
+	/* Only PFs can control FCS stripping. */
+	if (EFX_PCI_FUNCTION_IS_PF(encp)) {
+		cfg |= 1U << MC_CMD_MAC_CONFIG_OPTIONS_CFG_INCLUDE_FCS;
+		if (mc->enmc_include_fcs != B_FALSE)
+			flags |= 1U << MC_CMD_MAC_FLAGS_FLAG_INCLUDE_FCS;
+	} else if (mc->enmc_include_fcs != B_FALSE) {
+		/*
+		 * Assume that FCS stripping being enabled is the driver's
+		 * default expectation and deny disabling it to VFs.
+		 */
+		rc = ENOTSUP;
+		goto fail1;
+	}
 
 	MCDI_IN_SET_DWORD(req, MAC_CTRL_IN_FLAGS, flags);
 
@@ -1595,12 +1606,22 @@ efx_np_mac_ctrl(
 			break;
 		default:
 			rc = EINVAL;
-			goto fail1;
+			goto fail2;
 		}
 	}
 
-	cfg |= 1U << MC_CMD_MAC_CONFIG_OPTIONS_CFG_FCNTL;
-	MCDI_IN_SET_DWORD(req, MAC_CTRL_IN_FCNTL, fcntl);
+	/* Only PFs can change flow control settings. */
+	if (EFX_PCI_FUNCTION_IS_PF(encp)) {
+		cfg |= 1U << MC_CMD_MAC_CONFIG_OPTIONS_CFG_FCNTL;
+		MCDI_IN_SET_DWORD(req, MAC_CTRL_IN_FCNTL, fcntl);
+	} else if (fcntl != MC_CMD_FCNTL_AUTO) {
+		/*
+		 * Assume that flow control auto-negotiation is the driver's
+		 * default expectation and deny any attempts to override it.
+		 */
+		rc = ENOTSUP;
+		goto fail3;
+	}
 
 skip_full_reconfigure:
 	MCDI_IN_SET_DWORD(req, MAC_CTRL_IN_V2_CONTROL_FLAGS, cfg);
@@ -1609,11 +1630,17 @@ efx_np_mac_ctrl(
 
 	if (req.emr_rc != 0) {
 		rc = req.emr_rc;
-		goto fail2;
+		goto fail4;
 	}
 
 	return (0);
 
+fail4:
+	EFSYS_PROBE(fail4);
+
+fail3:
+	EFSYS_PROBE(fail3);
+
 fail2:
 	EFSYS_PROBE(fail2);
 
-- 
2.47.3

