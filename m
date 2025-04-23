Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A56C369D1
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 16:00:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2923C40649;
	Wed, 23 Apr 2025 18:00:18 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 4CB40402E1
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:00:14 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.72.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 6E64DE02A8;
 Wed, 23 Apr 2025 20:00:13 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 6E64DE02A8
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1745424014;
 bh=CuPjPEBe4l1Gf6USRCvaeBxz43Y5ZMzz6+aaoIRv5Lk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YWasDrDmjYuGHnDCPTKCTUjYxZPFxKN7RNuDm/G3+1JxGVOZ6DEobeemGKtILwEti
 vrxzoQOWuhhKs4bGQW33MUlHpHr4oKcURBHL+aW4YnIrisuQmzhBvcJWWjfbGwoNaK
 9mzRI6lZmuiI6j5rPUHYWogAtCaIpCM5SLEiEFparOIKWXGeqRBDkQ469tCkSzLF9Q
 wugPRwDEwy2wPW+f+QY0UnEmg4L7T0OdUZ+5nQsW4mMgMyrAYRKDMH9qGtgQ5CQut6
 UiHswsZQmiRAQsGazrAzVSk1LogHeYplDPxxxlRZVaAHrczE3SOT/Ds4lgzl7XGGSB
 WY4SoKVWH83eA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>
Subject: [PATCH v2 03/45] common/sfc_efx/base: add Medford4 support to NIC
 module
Date: Wed, 23 Apr 2025 19:59:20 +0400
Message-Id: <20250423160002.35706-4-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250423160002.35706-1-ivan.malov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
 <20250423160002.35706-1-ivan.malov@arknetworks.am>
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

From: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>

Implement NIC family discovery and minimum probe support.

Signed-off-by: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>
Signed-off-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/base/ef10_nic.c | 32 +++++++++++++++-
 drivers/common/sfc_efx/base/efx.h      |  1 +
 drivers/common/sfc_efx/base/efx_impl.h |  7 +++-
 drivers/common/sfc_efx/base/efx_nic.c  | 52 ++++++++++++++++++++++++++
 4 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/drivers/common/sfc_efx/base/ef10_nic.c b/drivers/common/sfc_efx/base/ef10_nic.c
index 79d596b5ef..9bff68f054 100644
--- a/drivers/common/sfc_efx/base/ef10_nic.c
+++ b/drivers/common/sfc_efx/base/ef10_nic.c
@@ -1422,7 +1422,7 @@ ef10_get_datapath_caps(
 
 	/*
 	 * Check if firmware reports the VI window mode.
-	 * Medford2 has a variable VI window size (8K, 16K or 64K).
+	 * Medford2 and Medford4 have a variable VI window size (8K, 16K or 64K).
 	 * Medford and Huntington have a fixed 8K VI window size.
 	 */
 	if (req.emr_out_length_used >= MC_CMD_GET_CAPABILITIES_V3_OUT_LEN) {
@@ -1479,6 +1479,7 @@ ef10_get_datapath_caps(
 
 		switch (enp->en_family) {
 		case EFX_FAMILY_MEDFORD2:
+		case EFX_FAMILY_MEDFORD4:
 			encp->enc_rx_scale_hash_alg_mask =
 			    (1U << EFX_RX_HASHALG_TOEPLITZ);
 			break;
@@ -1922,6 +1923,35 @@ static struct ef10_external_port_map_s {
 		(1U << TLV_PORT_MODE_1x1_1x1),			/* mode 2 */
 		{ 0, 1, EFX_EXT_PORT_NA, EFX_EXT_PORT_NA }
 	},
+	/*
+	 * Modes that on Medford4 allocate 2 adjacent port numbers to cage 1
+	 * and the rest to cage 2.
+	 *	port 0 -> cage 1
+	 *	port 1 -> cage 1
+	 *	port 2 -> cage 2
+	 *	port 3 -> cage 2
+	 */
+	{
+		EFX_FAMILY_MEDFORD4,
+		(1U << TLV_PORT_MODE_2x1_2x1) |			/* mode 5 */
+		(1U << TLV_PORT_MODE_2x1_1x4) |			/* mode 7 */
+		(1U << TLV_PORT_MODE_2x2_NA) |			/* mode 13 */
+		(1U << TLV_PORT_MODE_2x1_1x2),			/* mode 18 */
+		{ 0, 2, EFX_EXT_PORT_NA, EFX_EXT_PORT_NA }
+	},
+	/*
+	 * Modes that on Medford4 allocate up to 4 adjacent port numbers
+	 * to cage 1.
+	 *	port 0 -> cage 1
+	 *	port 1 -> cage 1
+	 *	port 2 -> cage 1
+	 *	port 3 -> cage 1
+	 */
+	{
+		EFX_FAMILY_MEDFORD4,
+		(1U << TLV_PORT_MODE_4x1_NA),			/* mode 4 */
+		{ 0, EFX_EXT_PORT_NA, EFX_EXT_PORT_NA, EFX_EXT_PORT_NA }
+	},
 };
 
 static	__checkReturn	efx_rc_t
diff --git a/drivers/common/sfc_efx/base/efx.h b/drivers/common/sfc_efx/base/efx.h
index 635b44ab37..a9ed3f423f 100644
--- a/drivers/common/sfc_efx/base/efx.h
+++ b/drivers/common/sfc_efx/base/efx.h
@@ -196,6 +196,7 @@ efx_family_probe_bar(
 /* FIXME Fix it when memory bar is fixed in FPGA image. It must be 0. */
 #define	EFX_MEM_BAR_RIVERHEAD			2
 
+#define	EFX_MEM_BAR_MEDFORD4			2
 
 /* Error codes */
 
diff --git a/drivers/common/sfc_efx/base/efx_impl.h b/drivers/common/sfc_efx/base/efx_impl.h
index 662a21e90c..9d1f361c5d 100644
--- a/drivers/common/sfc_efx/base/efx_impl.h
+++ b/drivers/common/sfc_efx/base/efx_impl.h
@@ -972,7 +972,8 @@ struct efx_nic_s {
 };
 
 #define	EFX_FAMILY_IS_EF10(_enp) \
-	((_enp)->en_family == EFX_FAMILY_MEDFORD2 || \
+	((_enp)->en_family == EFX_FAMILY_MEDFORD4 || \
+	 (_enp)->en_family == EFX_FAMILY_MEDFORD2 || \
 	 (_enp)->en_family == EFX_FAMILY_MEDFORD || \
 	 (_enp)->en_family == EFX_FAMILY_HUNTINGTON)
 
@@ -1128,6 +1129,10 @@ struct efx_txq_s {
 			rev = 'G';					\
 			break;						\
 									\
+		case EFX_FAMILY_MEDFORD4:				\
+			rev = 'H';					\
+			break;						\
+									\
 		default:						\
 			rev = '?';					\
 			break;						\
diff --git a/drivers/common/sfc_efx/base/efx_nic.c b/drivers/common/sfc_efx/base/efx_nic.c
index 172488e083..1ec684da40 100644
--- a/drivers/common/sfc_efx/base/efx_nic.c
+++ b/drivers/common/sfc_efx/base/efx_nic.c
@@ -79,6 +79,21 @@ efx_family(
 			return (0);
 #endif /* EFSYS_OPT_MEDFORD2 */
 
+#if EFSYS_OPT_MEDFORD4
+		case EFX_PCI_DEVID_MEDFORD4_PF_UNINIT:
+			/*
+			 * Hardware default for PF0 of uninitialised Medford4.
+			 * manftest must be able to cope with this device id.
+			 */
+		case EFX_PCI_DEVID_MEDFORD4:
+		case EFX_PCI_DEVID_MEDFORD4_VF:
+		case EFX_PCI_DEVID_MEDFORD4_NO_LL:
+		case EFX_PCI_DEVID_MEDFORD4_NO_LL_VF:
+			*efp = EFX_FAMILY_MEDFORD4;
+			*membarp = EFX_MEM_BAR_MEDFORD4;
+			return (0);
+#endif /* EFSYS_OPT_MEDFORD4 */
+
 		case EFX_PCI_DEVID_FALCON:	/* Obsolete, not supported */
 		default:
 			break;
@@ -251,6 +266,27 @@ static const efx_nic_ops_t	__efx_nic_riverhead_ops = {
 
 #endif	/* EFSYS_OPT_RIVERHEAD */
 
+#if EFSYS_OPT_MEDFORD4
+
+static const efx_nic_ops_t	__efx_nic_medford4_ops = {
+	ef10_nic_probe,			/* eno_probe */
+	medford2_board_cfg,		/* eno_board_cfg */
+	ef10_nic_set_drv_limits,	/* eno_set_drv_limits */
+	ef10_nic_reset,			/* eno_reset */
+	ef10_nic_init,			/* eno_init */
+	ef10_nic_get_vi_pool,		/* eno_get_vi_pool */
+	ef10_nic_get_bar_region,	/* eno_get_bar_region */
+	ef10_nic_hw_unavailable,	/* eno_hw_unavailable */
+	ef10_nic_set_hw_unavailable,	/* eno_set_hw_unavailable */
+#if EFSYS_OPT_DIAG
+	ef10_nic_register_test,		/* eno_register_test */
+#endif	/* EFSYS_OPT_DIAG */
+	ef10_nic_fini,			/* eno_fini */
+	ef10_nic_unprobe,		/* eno_unprobe */
+};
+
+#endif	/* EFSYS_OPT_MEDFORD4 */
+
 
 	__checkReturn	efx_rc_t
 efx_nic_create(
@@ -363,6 +399,22 @@ efx_nic_create(
 		break;
 #endif	/* EFSYS_OPT_RIVERHEAD */
 
+#if EFSYS_OPT_MEDFORD4
+	case EFX_FAMILY_MEDFORD4:
+		enp->en_enop = &__efx_nic_medford4_ops;
+		enp->en_features =
+		    EFX_FEATURE_IPV6 |
+		    EFX_FEATURE_LINK_EVENTS |
+		    EFX_FEATURE_PERIODIC_MAC_STATS |
+		    EFX_FEATURE_MCDI |
+		    EFX_FEATURE_MAC_HEADER_FILTERS |
+		    EFX_FEATURE_MCDI_DMA |
+		    EFX_FEATURE_FW_ASSISTED_TSO_V2 |
+		    EFX_FEATURE_PACKED_STREAM |
+		    EFX_FEATURE_TXQ_CKSUM_OP_DESC;
+		break;
+#endif	/* EFSYS_OPT_MEDFORD4 */
+
 	default:
 		rc = ENOTSUP;
 		goto fail2;
-- 
2.39.5

