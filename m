Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95559C369C2
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:05:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD8EE427CE;
	Wed, 16 Apr 2025 16:01:08 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 2B3AD4279B
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:01:00 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 71B8DE11AD;
 Wed, 16 Apr 2025 18:00:59 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 71B8DE11AD
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812060;
 bh=xfleO3wcSiKkvR5hYWCKYawWdOFIQHtFdqBKKsI3Rsg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oxF9yKJ8arvbJEUvMkKyBGl58CMGsCIeW3AEzQQ0ijCB66JmBwpLdDhcbKz3DIm2V
 d8/1mgSpgcxSnNIgeiSV2Rh2n9dFpwaEYRYAz8fnfOeOWaU3hoezACv8FYv16AGupf
 7fiIZhsqPzMcfBmjcE6o1delhNoPqQ9LsWR3lyAHJAnJ6N8nlcWFqjEomyatCTDJiW
 4nWqYoN6MH4Naz0HxJjZQflZymDUrq5VFc6aBbOgcJXoH5rhjTSol0p5Q9HINyBUEr
 XwbF8DEHnH+D6XuQyYY/UZr20MxXfaD0iOeAi++nhcPToNQ/jCm2Z8DWBHnpdTtgNd
 JAVCPccHuR9ZA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 35/46] common/sfc_efx/base: support MAC statistics on Medford4
 NICs
Date: Wed, 16 Apr 2025 18:00:05 +0400
Message-Id: <20250416140016.36127-36-ivan.malov@arknetworks.am>
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

Supply Medford4-specific methods to clear, upload and update
MAC statistics, as well as the method to toggle periodic DMA
updates. All of these leverage the same netport MCDI command.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/common/sfc_efx/base/ef10_nic.c      |   4 +-
 drivers/common/sfc_efx/base/efx_impl.h      |  11 ++
 drivers/common/sfc_efx/base/efx_mac.c       |   8 +-
 drivers/common/sfc_efx/base/efx_mcdi.c      |  12 +-
 drivers/common/sfc_efx/base/efx_np.c        |  89 +++++++++++++
 drivers/common/sfc_efx/base/medford4_impl.h |  27 ++++
 drivers/common/sfc_efx/base/medford4_mac.c  | 138 ++++++++++++++++++++
 7 files changed, 282 insertions(+), 7 deletions(-)

diff --git a/drivers/common/sfc_efx/base/ef10_nic.c b/drivers/common/sfc_efx/base/ef10_nic.c
index eb1b68b17e..31fcb361f2 100644
--- a/drivers/common/sfc_efx/base/ef10_nic.c
+++ b/drivers/common/sfc_efx/base/ef10_nic.c
@@ -2523,7 +2523,9 @@ ef10_nic_probe(
 
 #if EFSYS_OPT_MAC_STATS
 	/* Wipe the MAC statistics */
-	if ((rc = efx_mcdi_mac_stats_clear(enp)) != 0)
+
+	rc = efx_mcdi_mac_stats_clear(enp);
+	if (rc != 0)
 		goto fail6;
 #endif
 
diff --git a/drivers/common/sfc_efx/base/efx_impl.h b/drivers/common/sfc_efx/base/efx_impl.h
index aafb2bf998..7dbad601ff 100644
--- a/drivers/common/sfc_efx/base/efx_impl.h
+++ b/drivers/common/sfc_efx/base/efx_impl.h
@@ -1968,6 +1968,17 @@ efx_np_mac_ctrl(
 	__in		efx_np_handle_t nph,
 	__in		const efx_np_mac_ctrl_t *mc);
 
+#if EFSYS_OPT_MAC_STATS
+LIBEFX_INTERNAL
+extern	__checkReturn	efx_rc_t
+efx_np_mac_stats(
+	__in		efx_nic_t *enp,
+	__in		efx_np_handle_t nph,
+	__in		efx_stats_action_t action,
+	__in_opt	const efsys_mem_t *esmp,
+	__in		uint16_t period_ms);
+#endif /* EFSYS_OPT_MAC_STATS */
+
 #ifdef	__cplusplus
 }
 #endif
diff --git a/drivers/common/sfc_efx/base/efx_mac.c b/drivers/common/sfc_efx/base/efx_mac.c
index 6abe2046e8..f002cb838e 100644
--- a/drivers/common/sfc_efx/base/efx_mac.c
+++ b/drivers/common/sfc_efx/base/efx_mac.c
@@ -106,10 +106,10 @@ static const efx_mac_ops_t	__efx_mac_medford4_ops = {
 #endif	/* EFSYS_OPT_LOOPBACK */
 #if EFSYS_OPT_MAC_STATS
 	medford4_mac_stats_get_mask,		/* emo_stats_get_mask */
-	efx_mcdi_mac_stats_clear,		/* emo_stats_clear */
-	efx_mcdi_mac_stats_upload,		/* emo_stats_upload */
-	efx_mcdi_mac_stats_periodic,		/* emo_stats_periodic */
-	ef10_mac_stats_update			/* emo_stats_update */
+	medford4_mac_stats_clear,		/* emo_stats_clear */
+	medford4_mac_stats_upload,		/* emo_stats_upload */
+	medford4_mac_stats_periodic,		/* emo_stats_periodic */
+	medford4_mac_stats_update		/* emo_stats_update */
 #endif	/* EFSYS_OPT_MAC_STATS */
 };
 #endif /* EFSYS_OPT_MEDFORD4 */
diff --git a/drivers/common/sfc_efx/base/efx_mcdi.c b/drivers/common/sfc_efx/base/efx_mcdi.c
index 0bd56dd84d..20051c7da9 100644
--- a/drivers/common/sfc_efx/base/efx_mcdi.c
+++ b/drivers/common/sfc_efx/base/efx_mcdi.c
@@ -2244,10 +2244,18 @@ efx_mcdi_mac_stats(
 efx_mcdi_mac_stats_clear(
 	__in		efx_nic_t *enp)
 {
+	efx_port_t *epp = &(enp->en_port);
 	efx_rc_t rc;
 
-	if ((rc = efx_mcdi_mac_stats(enp, enp->en_vport_id, NULL,
-			EFX_STATS_CLEAR, 0)) != 0)
+	if (efx_np_supported(enp) != B_FALSE) {
+		rc = efx_np_mac_stats(enp, epp->ep_np_handle,
+			    EFX_STATS_CLEAR, NULL, 0);
+	} else {
+		rc = efx_mcdi_mac_stats(enp, enp->en_vport_id, NULL,
+				EFX_STATS_CLEAR, 0);
+	}
+
+	if (rc != 0)
 		goto fail1;
 
 	return (0);
diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index d4ee17ffb4..df836f09a6 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -1291,3 +1291,92 @@ efx_np_mac_ctrl(
 	EFSYS_PROBE1(fail1, efx_rc_t, rc);
 	return (rc);
 }
+
+#if EFSYS_OPT_MAC_STATS
+	__checkReturn	efx_rc_t
+efx_np_mac_stats(
+	__in		efx_nic_t *enp,
+	__in		efx_np_handle_t nph,
+	__in		efx_stats_action_t action,
+	__in_opt	const efsys_mem_t *esmp,
+	__in		uint16_t period_ms)
+{
+	EFX_MCDI_DECLARE_BUF(payload,
+	    MC_CMD_GET_NETPORT_STATISTICS_IN_LEN,
+	    MC_CMD_GET_NETPORT_STATISTICS_OUT_LENMIN);
+	int enable = (action == EFX_STATS_ENABLE_NOEVENTS);
+	int events = (action == EFX_STATS_ENABLE_EVENTS);
+	int disable = (action == EFX_STATS_DISABLE);
+	int upload = (action == EFX_STATS_UPLOAD);
+	int clear = (action == EFX_STATS_CLEAR);
+	efx_mcdi_req_t req;
+	efx_rc_t rc;
+
+	req.emr_out_length = MC_CMD_GET_NETPORT_STATISTICS_OUT_LENMIN;
+	req.emr_in_length = MC_CMD_GET_NETPORT_STATISTICS_IN_LEN;
+	req.emr_cmd = MC_CMD_GET_NETPORT_STATISTICS;
+	req.emr_out_buf = payload;
+	req.emr_in_buf = payload;
+
+	MCDI_IN_SET_DWORD(req, GET_NETPORT_STATISTICS_IN_PORT_HANDLE, nph);
+
+	MCDI_IN_POPULATE_DWORD_6(req, GET_NETPORT_STATISTICS_IN_CMD,
+	    GET_NETPORT_STATISTICS_IN_DMA, upload,
+	    GET_NETPORT_STATISTICS_IN_CLEAR, clear,
+	    GET_NETPORT_STATISTICS_IN_PERIODIC_CHANGE,
+		    enable | events | disable,
+	    GET_NETPORT_STATISTICS_IN_PERIODIC_ENABLE, enable | events,
+	    GET_NETPORT_STATISTICS_IN_PERIODIC_NOEVENT, !events,
+	    GET_NETPORT_STATISTICS_IN_PERIOD_MS,
+		    (enable | events) ? period_ms : 0);
+
+	if (enable || events || upload) {
+		const efx_nic_cfg_t *encp = &enp->en_nic_cfg;
+		uint32_t sz;
+
+		/* Periodic stats or stats upload require a DMA buffer */
+		if (esmp == NULL) {
+			rc = EINVAL;
+			goto fail1;
+		}
+
+		/* TODO: validate encp->enc_mac_stats_nstats */
+		sz = encp->enc_mac_stats_nstats * sizeof (efx_qword_t);
+
+		if (EFSYS_MEM_SIZE(esmp) < sz) {
+			/* DMA buffer too small */
+			rc = ENOSPC;
+			goto fail2;
+		}
+
+		MCDI_IN_SET_DWORD(req, GET_NETPORT_STATISTICS_IN_DMA_ADDR_LO,
+		    EFSYS_MEM_ADDR(esmp) & 0xffffffff);
+		MCDI_IN_SET_DWORD(req, GET_NETPORT_STATISTICS_IN_DMA_ADDR_HI,
+		    EFSYS_MEM_ADDR(esmp) >> 32);
+		MCDI_IN_SET_DWORD(req, GET_NETPORT_STATISTICS_IN_DMA_LEN, sz);
+	}
+
+	efx_mcdi_execute(enp, &req);
+
+	if (req.emr_rc != 0) {
+		/* EF10: Expect ENOENT if no DMA queues are initialised */
+		if ((req.emr_rc != ENOENT) ||
+		    (enp->en_rx_qcount + enp->en_tx_qcount != 0)) {
+			rc = req.emr_rc;
+			goto fail3;
+		}
+	}
+
+	return (0);
+
+fail3:
+	EFSYS_PROBE(fail3);
+
+fail2:
+	EFSYS_PROBE(fail2);
+
+fail1:
+	EFSYS_PROBE1(fail1, efx_rc_t, rc);
+	return (rc);
+}
+#endif /* EFSYS_OPT_MAC_STATS */
diff --git a/drivers/common/sfc_efx/base/medford4_impl.h b/drivers/common/sfc_efx/base/medford4_impl.h
index 2fbf1495d1..cc45431a81 100644
--- a/drivers/common/sfc_efx/base/medford4_impl.h
+++ b/drivers/common/sfc_efx/base/medford4_impl.h
@@ -63,6 +63,33 @@ medford4_mac_stats_get_mask(
 	__in			efx_nic_t *enp,
 	__inout_bcount(sz)	uint32_t *maskp,
 	__in			size_t sz);
+
+LIBEFX_INTERNAL
+extern	__checkReturn		efx_rc_t
+medford4_mac_stats_clear(
+	__in			efx_nic_t *enp);
+
+LIBEFX_INTERNAL
+extern	__checkReturn		efx_rc_t
+medford4_mac_stats_upload(
+	__in			efx_nic_t *enp,
+	__in			efsys_mem_t *esmp);
+
+LIBEFX_INTERNAL
+extern	__checkReturn		efx_rc_t
+medford4_mac_stats_periodic(
+	__in			efx_nic_t *enp,
+	__in			efsys_mem_t *esmp,
+	__in			uint16_t period_ms,
+	__in			boolean_t events);
+
+LIBEFX_INTERNAL
+extern	__checkReturn			efx_rc_t
+medford4_mac_stats_update(
+	__in				efx_nic_t *enp,
+	__in				efsys_mem_t *esmp,
+	__inout_ecount(EFX_MAC_NSTATS)	efsys_stat_t *stats,
+	__inout_opt			uint32_t *generationp);
 #endif /* EFSYS_OPT_MAC_STATS */
 
 #ifdef	__cplusplus
diff --git a/drivers/common/sfc_efx/base/medford4_mac.c b/drivers/common/sfc_efx/base/medford4_mac.c
index b8a5aade16..bc55604017 100644
--- a/drivers/common/sfc_efx/base/medford4_mac.c
+++ b/drivers/common/sfc_efx/base/medford4_mac.c
@@ -113,5 +113,143 @@ medford4_mac_stats_get_mask(
 	EFSYS_PROBE1(fail1, efx_rc_t, rc);
 	return (rc);
 }
+
+	__checkReturn		efx_rc_t
+medford4_mac_stats_clear(
+	__in			efx_nic_t *enp)
+{
+	efx_port_t *epp = &(enp->en_port);
+	efx_rc_t rc;
+
+	rc = efx_np_mac_stats(enp, epp->ep_np_handle, EFX_STATS_CLEAR, NULL, 0);
+	if (rc != 0)
+		goto fail1;
+
+	return (0);
+
+fail1:
+	EFSYS_PROBE1(fail1, efx_rc_t, rc);
+	return (rc);
+}
+
+	__checkReturn		efx_rc_t
+medford4_mac_stats_upload(
+	__in			efx_nic_t *enp,
+	__in			efsys_mem_t *esmp)
+{
+	efx_port_t *epp = &(enp->en_port);
+	efx_rc_t rc;
+
+	rc = efx_np_mac_stats(enp,
+		    epp->ep_np_handle, EFX_STATS_UPLOAD, esmp, 0);
+	if (rc != 0)
+		goto fail1;
+
+	return (0);
+
+fail1:
+	EFSYS_PROBE1(fail1, efx_rc_t, rc);
+	return (rc);
+}
+
+	__checkReturn		efx_rc_t
+medford4_mac_stats_periodic(
+	__in			efx_nic_t *enp,
+	__in			efsys_mem_t *esmp,
+	__in			uint16_t period_ms,
+	__in			boolean_t events)
+{
+	efx_port_t *epp = &(enp->en_port);
+	efx_rc_t rc;
+
+	if (period_ms == 0) {
+		rc = efx_np_mac_stats(enp, epp->ep_np_handle,
+			    EFX_STATS_DISABLE, NULL, 0);
+	} else if (events != B_FALSE) {
+		rc = efx_np_mac_stats(enp, epp->ep_np_handle,
+			    EFX_STATS_ENABLE_EVENTS, esmp, period_ms);
+	} else {
+		rc = efx_np_mac_stats(enp, epp->ep_np_handle,
+			    EFX_STATS_ENABLE_NOEVENTS, esmp, period_ms);
+	}
+
+	if (rc != 0)
+		goto fail1;
+
+	return (0);
+
+fail1:
+	EFSYS_PROBE1(fail1, efx_rc_t, rc);
+	return (rc);
+}
+
+#define	MEDFORD4_MAC_STAT_READ(_esmp, _field, _eqp)			\
+	EFSYS_MEM_READQ((_esmp), (_field) * sizeof (efx_qword_t), _eqp)
+
+	__checkReturn			efx_rc_t
+medford4_mac_stats_update(
+	__in				efx_nic_t *enp,
+	__in				efsys_mem_t *esmp,
+	__inout_ecount(EFX_MAC_NSTATS)	efsys_stat_t *stats,
+	__inout_opt			uint32_t *generationp)
+{
+	const efx_nic_cfg_t *encp = &enp->en_nic_cfg;
+	efx_port_t *epp = &(enp->en_port);
+	efx_qword_t generation_start;
+	efx_qword_t generation_end;
+	unsigned int i;
+	efx_rc_t rc;
+
+	/* TODO: validate encp->enc_mac_stats_nstats */
+	if (EFSYS_MEM_SIZE(esmp) <
+	    (encp->enc_mac_stats_nstats * sizeof (efx_qword_t))) {
+		/* DMA buffer too small */
+		rc = ENOSPC;
+		goto fail1;
+	}
+
+	/* Read END first so we don't race with the MC */
+	EFSYS_DMA_SYNC_FOR_KERNEL(esmp, 0, EFSYS_MEM_SIZE(esmp));
+	MEDFORD4_MAC_STAT_READ(esmp, (encp->enc_mac_stats_nstats - 1),
+	    &generation_end);
+	EFSYS_MEM_READ_BARRIER();
+
+	for (i = 0; i < EFX_ARRAY_SIZE(epp->ep_np_mac_stat_lut); ++i) {
+		efx_qword_t value;
+
+		if (epp->ep_np_mac_stat_lut[i].ens_valid == B_FALSE)
+			continue;
+
+		MEDFORD4_MAC_STAT_READ(esmp,
+		    epp->ep_np_mac_stat_lut[i].ens_dma_fld, &value);
+
+		EFSYS_STAT_SET_QWORD(&(stats[i]), &value);
+	}
+
+	/* TODO: care about VADAPTOR statistics */
+
+	/* Read START generation counter */
+	EFSYS_DMA_SYNC_FOR_KERNEL(esmp, 0, EFSYS_MEM_SIZE(esmp));
+	EFSYS_MEM_READ_BARRIER();
+
+	/* FIXME: we never parse marker descriptors; assume start is 0 offset */
+	MEDFORD4_MAC_STAT_READ(esmp, 0, &generation_start);
+
+	/* Check that we didn't read the stats in the middle of a DMA */
+	if (memcmp(&generation_start, &generation_end,
+		    sizeof (generation_start)) != 0)
+		return (EAGAIN);
+
+	if (generationp != NULL)
+		*generationp = EFX_QWORD_FIELD(generation_start, EFX_DWORD_0);
+
+	return (0);
+
+fail1:
+	EFSYS_PROBE1(fail1, efx_rc_t, rc);
+	return (rc);
+}
+
+#undef MEDFORD4_MAC_STAT_READ
 #endif /* EFSYS_OPT_MAC_STATS */
 #endif /* EFSYS_OPT_MEDFORD4 */
-- 
2.39.5

