Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F48BC369CB
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 16:01:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E55C9406B7;
	Wed, 23 Apr 2025 18:00:26 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id CC1A140666
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:00:21 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.72.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id B6C5EE0329;
 Wed, 23 Apr 2025 20:00:20 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am B6C5EE0329
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1745424021;
 bh=3EqBaRAbbFyAor70hj5U5YDlMpxIYEAObo7FsTSc2C0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kNEBBPVao6S0ELiPT0UaqXdSTLE1ZebQV6djpkbc+y1K4a9J82474sckspOansTHj
 Io6weIRXsZ+7mdYYG6j7HoRiLdGSoQuHi6RQyKSry57nDAOUWRaIs/78tj2fJ/5Pkl
 zzRNWiTPgx8dsk0IYUxuX65jrYznpybkoC4lhH/qR0s2d0Wo4Vek1n/sFH19NN2VTG
 ya3Vf9dqVXVfz680JadXZgJApdErzkBOqysTvZwkcW+HvWChSOBtcCIuZsOMIPDoZs
 HnwQRPZhXGsOuocjciXlhwobSMeI2XIgDhudbgm+lJTZaMWjEEmL0MnPMKjU+tZ5u9
 Z23wl5Dnlc6Hw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>
Subject: [PATCH v2 12/45] common/sfc_efx/base: add Medford4 support to Tx
 module
Date: Wed, 23 Apr 2025 19:59:29 +0400
Message-Id: <20250423160002.35706-13-ivan.malov@arknetworks.am>
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

Define and use Medford4 specific method table.

Signed-off-by: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/base/efx_tx.c | 33 ++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/common/sfc_efx/base/efx_tx.c b/drivers/common/sfc_efx/base/efx_tx.c
index 6f61f937a1..d1021dea82 100644
--- a/drivers/common/sfc_efx/base/efx_tx.c
+++ b/drivers/common/sfc_efx/base/efx_tx.c
@@ -233,6 +233,33 @@ static const efx_tx_ops_t	__efx_tx_rhead_ops = {
 #endif /* EFSYS_OPT_RIVERHEAD */
 
 
+#if EFSYS_OPT_MEDFORD4
+static const efx_tx_ops_t	__efx_tx_medford4_ops = {
+	ef10_tx_init,				/* etxo_init */
+	ef10_tx_fini,				/* etxo_fini */
+	ef10_tx_qcreate,			/* etxo_qcreate */
+	ef10_tx_qdestroy,			/* etxo_qdestroy */
+	ef10_tx_qpost,				/* etxo_qpost */
+	ef10_tx_qpush,				/* etxo_qpush */
+	ef10_tx_qpace,				/* etxo_qpace */
+	ef10_tx_qflush,				/* etxo_qflush */
+	ef10_tx_qenable,			/* etxo_qenable */
+	NULL,					/* etxo_qpio_enable */
+	NULL,					/* etxo_qpio_disable */
+	NULL,					/* etxo_qpio_write */
+	NULL,					/* etxo_qpio_post */
+	ef10_tx_qdesc_post,			/* etxo_qdesc_post */
+	ef10_tx_qdesc_dma_create,		/* etxo_qdesc_dma_create */
+	NULL,					/* etxo_qdesc_tso_create */
+	ef10_tx_qdesc_tso2_create,		/* etxo_qdesc_tso2_create */
+	ef10_tx_qdesc_vlantci_create,		/* etxo_qdesc_vlantci_create */
+	ef10_tx_qdesc_checksum_create,		/* etxo_qdesc_checksum_create */
+#if EFSYS_OPT_QSTATS
+	ef10_tx_qstats_update,			/* etxo_qstats_update */
+#endif
+};
+#endif /* EFSYS_OPT_MEDFORD4 */
+
 	__checkReturn	efx_rc_t
 efx_tx_init(
 	__in		efx_nic_t *enp)
@@ -284,6 +311,12 @@ efx_tx_init(
 		break;
 #endif /* EFSYS_OPT_RIVERHEAD */
 
+#if EFSYS_OPT_MEDFORD4
+	case EFX_FAMILY_MEDFORD4:
+		etxop = &__efx_tx_medford4_ops;
+		break;
+#endif /* EFSYS_OPT_MEDFORD4 */
+
 	default:
 		EFSYS_ASSERT(0);
 		rc = ENOTSUP;
-- 
2.39.5

