Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0718C369BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:05:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE499427DC;
	Wed, 16 Apr 2025 16:01:10 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id B69A8427A7
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:01:01 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 08D69E11C0;
 Wed, 16 Apr 2025 18:01:00 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 08D69E11C0
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812061;
 bh=iG6IXzmef+/nQ3kx2BR+RfMC6ahZBNekNuCuBXIB5/E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vJ8cVlcRgiqLIM7SKDsRNafiaBxJD7DNry81BEaVnXLgeksXy3/asHLpaNWWULY53
 A7+8JpGZGF0kqAsRbj++FNqJ2XhM+2lymSBsQb9z7ZLmqbWh9kc1VCAoyXWRsnUSoV
 So/DqX2sY6D2KNAhj/xaJJcIX56+V3SpffIq6pgfuqW9gceMagorvgeJZc14/Pmlpt
 yrHkGo+nDztqKMRDoXxnd+m8D/5DaKUBbuXCvvFYFhObSPSTKp8pMojfhXqebVQl5s
 9M7OVRTmCtpjAKMt2v1zjBpwsRAxTLK7PDF13EWvCQFHDHnJFokkAJsuN03BqJZStV
 rXhWKvS3Bn7Zg==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 37/46] common/sfc_efx/base: correct MAC PDU calculation on
 Medford4
Date: Wed, 16 Apr 2025 18:00:07 +0400
Message-Id: <20250416140016.36127-38-ivan.malov@arknetworks.am>
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

For managing MAC PDU (max. frame size), client drivers apply
EFX macros to switch between PDU and SDU forms. These macros
include a workaround for a bug that dates back to Siena NICs.

Starting with Medford4, the bug is no longer there and it is
wrong to use the macros, so provide users with a replacement.
The new APIs will either include the said workaround or omit
it, depending on whether support for netport MCDI is present.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/common/sfc_efx/base/efx.h         | 25 +++++++++++++++++++++++
 drivers/common/sfc_efx/base/efx_mac.c     | 19 +++++++++++++++--
 drivers/common/sfc_efx/base/efx_nic.c     |  3 +++
 drivers/common/sfc_efx/sfc_base_symbols.c |  1 +
 4 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx.h b/drivers/common/sfc_efx/base/efx.h
index 6ca108cffe..73dc38f84e 100644
--- a/drivers/common/sfc_efx/base/efx.h
+++ b/drivers/common/sfc_efx/base/efx.h
@@ -668,24 +668,45 @@ typedef enum efx_link_mode_e {
 
 #define	EFX_MAC_SDU_MAX	9202
 
+/*
+ * NOTE: the PDU macros implement an obsolete workaround that is needed for
+ * MC_CMD_SET_MAC; do not use the PDU macros for the netport MCDI commands,
+ * which do not use the workaround.
+ */
+
 #define	EFX_MAC_PDU_ADJUSTMENT					\
 	(/* EtherII */ 14					\
 	    + /* VLAN */ 4					\
 	    + /* CRC */ 4					\
 	    + /* bug16011 */ 16)				\
 
+/* NOTE: this macro is deprecated; use efx_mac_pdu_from_sdu(). */
 #define	EFX_MAC_PDU(_sdu)					\
 	EFX_P2ROUNDUP(size_t, (_sdu) + EFX_MAC_PDU_ADJUSTMENT, 8)
 
 /*
  * Due to the EFX_P2ROUNDUP in EFX_MAC_PDU(), EFX_MAC_SDU_FROM_PDU() may give
  * the SDU rounded up slightly.
+ *
+ * NOTE: do not use this macro in new code as it is
+ * incorrect for the netport MCDI commands.
  */
 #define	EFX_MAC_SDU_FROM_PDU(_pdu)	((_pdu) - EFX_MAC_PDU_ADJUSTMENT)
 
 #define	EFX_MAC_PDU_MIN	60
+
+/* NOTE: this macro is deprecated; use encp->enc_mac_pdu_max. */
 #define	EFX_MAC_PDU_MAX	EFX_MAC_PDU(EFX_MAC_SDU_MAX)
 
+/*
+ * For use with efx_mac_pdu_set(), convert the given SDU value to its PDU form.
+ */
+LIBEFX_API
+extern			size_t
+efx_mac_pdu_from_sdu(
+	__in		efx_nic_t *enp,
+	__in		size_t sdu);
+
 LIBEFX_API
 extern	__checkReturn	efx_rc_t
 efx_mac_pdu_get(
@@ -1729,6 +1750,10 @@ typedef struct efx_nic_cfg_s {
 	efx_nic_dma_mapping_t	enc_dma_mapping;
 	/* Physical ports shared by PFs */
 	efx_port_usage_t	enc_port_usage;
+	/* Minimum MAC PDU value to use with efx_mac_pdu_set() */
+	uint32_t		enc_mac_pdu_min;
+	/* Maximum MAC PDU value to use with efx_mac_pdu_set() */
+	uint32_t		enc_mac_pdu_max;
 } efx_nic_cfg_t;
 
 #define	EFX_PCI_VF_INVALID 0xffff
diff --git a/drivers/common/sfc_efx/base/efx_mac.c b/drivers/common/sfc_efx/base/efx_mac.c
index 8712d7c5ef..606164bcf9 100644
--- a/drivers/common/sfc_efx/base/efx_mac.c
+++ b/drivers/common/sfc_efx/base/efx_mac.c
@@ -114,6 +114,20 @@ static const efx_mac_ops_t	__efx_mac_medford4_ops = {
 };
 #endif /* EFSYS_OPT_MEDFORD4 */
 
+			size_t
+efx_mac_pdu_from_sdu(
+	__in		efx_nic_t *enp,
+	__in		size_t sdu)
+{
+	if (efx_np_supported(enp) != B_FALSE) {
+		/* PDU size for netport MCDI capable adaptors. */
+		return sdu + 14 /* ETH */ + 4 /* VLAN */ + 4 /* FCS */;
+	} else {
+		/* PDU size for legacy MC_CMD_SET_MAC command. */
+		return EFX_MAC_PDU(sdu);
+	}
+}
+
 	__checkReturn			efx_rc_t
 efx_mac_pdu_set(
 	__in				efx_nic_t *enp,
@@ -121,6 +135,7 @@ efx_mac_pdu_set(
 {
 	efx_port_t *epp = &(enp->en_port);
 	const efx_mac_ops_t *emop = epp->ep_emop;
+	efx_nic_cfg_t *encp = &(enp->en_nic_cfg);
 	uint32_t old_pdu;
 	efx_rc_t rc;
 
@@ -128,12 +143,12 @@ efx_mac_pdu_set(
 	EFSYS_ASSERT3U(enp->en_mod_flags, &, EFX_MOD_PORT);
 	EFSYS_ASSERT(emop != NULL);
 
-	if (pdu < EFX_MAC_PDU_MIN) {
+	if (pdu < encp->enc_mac_pdu_min) {
 		rc = EINVAL;
 		goto fail1;
 	}
 
-	if (pdu > EFX_MAC_PDU_MAX) {
+	if (pdu > encp->enc_mac_pdu_max) {
 		rc = EINVAL;
 		goto fail2;
 	}
diff --git a/drivers/common/sfc_efx/base/efx_nic.c b/drivers/common/sfc_efx/base/efx_nic.c
index 1ec684da40..1c25270792 100644
--- a/drivers/common/sfc_efx/base/efx_nic.c
+++ b/drivers/common/sfc_efx/base/efx_nic.c
@@ -491,6 +491,9 @@ efx_nic_probe(
 
 	encp->enc_features = enp->en_features;
 
+	encp->enc_mac_pdu_max = efx_mac_pdu_from_sdu(enp, EFX_MAC_SDU_MAX);
+	encp->enc_mac_pdu_min = EFX_MAC_PDU_MIN;
+
 	if ((rc = efx_phy_probe(enp)) != 0)
 		goto fail2;
 
diff --git a/drivers/common/sfc_efx/sfc_base_symbols.c b/drivers/common/sfc_efx/sfc_base_symbols.c
index ae6605632d..0e74034031 100644
--- a/drivers/common/sfc_efx/sfc_base_symbols.c
+++ b/drivers/common/sfc_efx/sfc_base_symbols.c
@@ -59,6 +59,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_trigger)
 RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_status_line)
 RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_status_message)
 RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_fatal)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_pdu_from_sdu)
 RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_pdu_set)
 RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_pdu_get)
 RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_addr_set)
-- 
2.39.5

