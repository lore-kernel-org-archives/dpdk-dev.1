Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CA7C369C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:03:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44D5B415D7;
	Wed, 16 Apr 2025 16:00:51 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 4320E410D5
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:00:43 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 90710E0872;
 Wed, 16 Apr 2025 18:00:42 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 90710E0872
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812043;
 bh=tMRNyaJ1He6fsVHcFwDWIiaTrs3vwJPYhqc162rqfLM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZOxwXepV7dJ8XDZRXwlLP0YOlnRnpHObbk7JuVZXDBkvb/wKRqAOfysgcjH8wwKGH
 kbOR7UnEvuTky0BiB/d28sAcRNo3TJ96v8TxHniiE1ogFK6ZjSlnwRfNg5g6qQzKGU
 eTMFvEi4K1txbfuWqPIu3WCZrUAX9US7dNx4BQfU8ooZ6As10vn15fi17/lzIaEbJI
 Zgs4EcbmV/gXuKwN7AoMnQSHgIXbX+Ocgp17dBzpRO+2ELRT6Jlc4LbRnKSEsCC556
 0oEbWa7/cCkk/Svbxs2RNPtXyXvIqHLJHtkdZeLnUY8e15hOv7kYNV7Qz0iWx9pe9t
 xMN9GWHuTETHw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 20/46] common/sfc_efx/base: provide a stub for basic netport
 attach
Date: Wed, 16 Apr 2025 17:59:50 +0400
Message-Id: <20250416140016.36127-21-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250416140016.36127-1-ivan.malov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
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

New NICs (for instance, Medford4) offer new netport MCDI for
managing physical ports, which will supersede the legacy one.
Scope out the new interface initialisation on NIC probe path.
That will be augmented with the actual code by later patches.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/common/sfc_efx/base/ef10_nic.c  | 30 ++++++++++++++++++------
 drivers/common/sfc_efx/base/efx_impl.h  | 15 ++++++++++++
 drivers/common/sfc_efx/base/efx_np.c    | 31 +++++++++++++++++++++++++
 drivers/common/sfc_efx/base/meson.build |  1 +
 4 files changed, 70 insertions(+), 7 deletions(-)
 create mode 100644 drivers/common/sfc_efx/base/efx_np.c

diff --git a/drivers/common/sfc_efx/base/ef10_nic.c b/drivers/common/sfc_efx/base/ef10_nic.c
index e1e8de5396..eb1b68b17e 100644
--- a/drivers/common/sfc_efx/base/ef10_nic.c
+++ b/drivers/common/sfc_efx/base/ef10_nic.c
@@ -2221,6 +2221,9 @@ efx_mcdi_nic_board_cfg(
 
 	encp->enc_board_type = board_type;
 
+	if (efx_np_supported(enp) != B_FALSE)
+		goto skip_phy_props;
+
 	/* Fill out fields in enp->en_port and enp->en_nic_cfg from MCDI */
 	if ((rc = efx_mcdi_get_phy_cfg(enp)) != 0)
 		goto fail8;
@@ -2246,6 +2249,7 @@ efx_mcdi_nic_board_cfg(
 	epp->ep_default_adv_cap_mask = els.epls.epls_adv_cap_mask;
 	epp->ep_adv_cap_mask = els.epls.epls_adv_cap_mask;
 
+skip_phy_props:
 	/* Check capabilities of running datapath firmware */
 	if ((rc = ef10_get_datapath_caps(enp)) != 0)
 		goto fail10;
@@ -2499,6 +2503,10 @@ ef10_nic_probe(
 	if ((rc = ef10_nic_board_cfg(enp)) != 0)
 		goto fail4;
 
+	rc = efx_np_attach(enp);
+	if (rc != 0)
+		goto fail5;
+
 	/*
 	 * Set default driver config limits (based on board config).
 	 *
@@ -2516,36 +2524,41 @@ ef10_nic_probe(
 #if EFSYS_OPT_MAC_STATS
 	/* Wipe the MAC statistics */
 	if ((rc = efx_mcdi_mac_stats_clear(enp)) != 0)
-		goto fail5;
+		goto fail6;
 #endif
 
 #if EFSYS_OPT_LOOPBACK
-	if ((rc = efx_mcdi_get_loopback_modes(enp)) != 0)
-		goto fail6;
+	if (efx_np_supported(enp) == B_FALSE) {
+		rc = efx_mcdi_get_loopback_modes(enp);
+		if (rc != 0)
+			goto fail7;
+	}
 #endif
 
 #if EFSYS_OPT_MON_STATS
 	if ((rc = mcdi_mon_cfg_build(enp)) != 0) {
 		/* Unprivileged functions do not have access to sensors */
 		if (rc != EACCES)
-			goto fail7;
+			goto fail8;
 	}
 #endif
 
 	return (0);
 
 #if EFSYS_OPT_MON_STATS
+fail8:
+	EFSYS_PROBE(fail8);
+#endif
+#if EFSYS_OPT_LOOPBACK
 fail7:
 	EFSYS_PROBE(fail7);
 #endif
-#if EFSYS_OPT_LOOPBACK
+#if EFSYS_OPT_MAC_STATS
 fail6:
 	EFSYS_PROBE(fail6);
 #endif
-#if EFSYS_OPT_MAC_STATS
 fail5:
 	EFSYS_PROBE(fail5);
-#endif
 fail4:
 	EFSYS_PROBE(fail4);
 fail3:
@@ -3005,6 +3018,9 @@ ef10_nic_unprobe(
 #if EFSYS_OPT_MON_STATS
 	mcdi_mon_cfg_free(enp);
 #endif /* EFSYS_OPT_MON_STATS */
+
+	efx_np_detach(enp);
+
 	(void) efx_mcdi_drv_attach(enp, B_FALSE);
 }
 
diff --git a/drivers/common/sfc_efx/base/efx_impl.h b/drivers/common/sfc_efx/base/efx_impl.h
index 89b7e0292e..9ad973ded7 100644
--- a/drivers/common/sfc_efx/base/efx_impl.h
+++ b/drivers/common/sfc_efx/base/efx_impl.h
@@ -1880,6 +1880,21 @@ struct efx_virtio_vq_s {
 
 #endif /* EFSYS_OPT_VIRTIO */
 
+LIBEFX_INTERNAL
+extern			boolean_t
+efx_np_supported(
+	__in		efx_nic_t *enp);
+
+LIBEFX_INTERNAL
+extern	__checkReturn	efx_rc_t
+efx_np_attach(
+	__in		efx_nic_t *enp);
+
+LIBEFX_INTERNAL
+extern		void
+efx_np_detach(
+	__in	efx_nic_t *enp);
+
 #ifdef	__cplusplus
 }
 #endif
diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
new file mode 100644
index 0000000000..432185f311
--- /dev/null
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ *
+ * Copyright(c) 2025 Advanced Micro Devices, Inc.
+ */
+#include "efx.h"
+#include "efx_impl.h"
+
+			boolean_t
+efx_np_supported(
+	__in		efx_nic_t *enp)
+{
+	return (enp->en_family >= EFX_FAMILY_MEDFORD4) ? B_TRUE : B_FALSE;
+}
+
+	__checkReturn	efx_rc_t
+efx_np_attach(
+	__in		efx_nic_t *enp)
+{
+	if (efx_np_supported(enp) == B_FALSE)
+		return (0);
+
+	return (0);
+}
+
+		void
+efx_np_detach(
+	__in	efx_nic_t *enp)
+{
+	if (efx_np_supported(enp) == B_FALSE)
+		return;
+}
diff --git a/drivers/common/sfc_efx/base/meson.build b/drivers/common/sfc_efx/base/meson.build
index c8deb4555e..02d5b2fbb9 100644
--- a/drivers/common/sfc_efx/base/meson.build
+++ b/drivers/common/sfc_efx/base/meson.build
@@ -20,6 +20,7 @@ sources = [
         'efx_mcdi.c',
         'efx_mon.c',
         'efx_nic.c',
+        'efx_np.c',
         'efx_nvram.c',
         'efx_pci.c',
         'efx_phy.c',
-- 
2.39.5

