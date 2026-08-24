Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D030C5DF81
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 11:27:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C2044027C;
	Mon, 24 Aug 2026 13:26:59 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id B8EF840270
 for <dev@dpdk.org>; Mon, 24 Aug 2026 13:26:57 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.64.182])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id F1D11E0460;
 Mon, 24 Aug 2026 15:26:55 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am F1D11E0460
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1787570816;
 bh=RBhOYLWt8i4R6DorO71V12gIgt8qFfxrbd/SNrjK5rs=;
 h=From:To:Cc:Subject:Date:From;
 b=53H1L+NzPL5xAd5IHSOstd4rnL/K0xVyEmc2cRt8ByRbCxgNcsj/4t5hmIWndiO4j
 Sm6wimCvHvB/CBLQwusf7m3fTVGBgCZUqetQ2ZCieNSN9x9CYcu5sQeBKl8mv7uv0e
 H5zv48yu8dZEUY6de79jkLkd6+1+Wdb9TpR00VnHEAZbOGS+MQTV8jnOS+77L+GiE8
 2a/n/oqeDSETlu8B0qLEFn3xTxm0thEOi9kDsEP12qKALckKLpGWBhO1LX9wOGN2BU
 Wq/yJ6bijs0oqWij4EmM/6AFqvzMQOSpjwel0vGF2WSgZ6bKLGMgrpcIDvetPNHXbk
 RbiFG7+Hnq27g==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 1/1] common/sfc_efx/base: clear VADAPTER stats upon allocation
Date: Mon, 24 Aug 2026 15:26:47 +0400
Message-ID: <20260824112647.27146-1-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
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

The probe-time clear in 'ef10_nic_probe' runs before the VADAPTER is
allocated and so cannot zero its counters. Add a complementary clear
to the point at which the VADAPTER is already in place, so that
VADAPTER statistics begin at zero for both PFs and VFs.

This change affects only Medford4 NICs within the 26.11 release, where
Medford4 VADAPTER statistics have been added in the first place.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/base/ef10_nic.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/common/sfc_efx/base/ef10_nic.c b/drivers/common/sfc_efx/base/ef10_nic.c
index 9af4259d38..954409ec90 100644
--- a/drivers/common/sfc_efx/base/ef10_nic.c
+++ b/drivers/common/sfc_efx/base/ef10_nic.c
@@ -2868,10 +2868,30 @@ ef10_nic_init(
 		if ((rc = ef10_upstream_port_vadaptor_alloc(enp)) != 0)
 			goto fail5;
 	}
+
+#if EFSYS_OPT_MAC_STATS
+	/*
+	 * Clear MAC statistics for the freshly allocated VADAPTER.
+	 * The probe-time wipe in 'ef10_nic_probe' predates the
+	 * allocation and cannot reach vadaptor-scoped counters;
+	 * do it here while 'en_vport_id' holds a valid value.
+	 */
+	rc = efx_mcdi_mac_stats_clear(enp);
+	if (rc != 0)
+		goto fail6;
+#endif
 	enp->en_nic_cfg.enc_mcdi_max_payload_length = MCDI_CTL_SDU_LEN_MAX_V2;
 
 	return (0);
 
+#if EFSYS_OPT_MAC_STATS
+fail6:
+	EFSYS_PROBE(fail6);
+	if (alloc_vadaptor != B_FALSE) {
+		(void) efx_mcdi_vadaptor_free(enp, enp->en_vport_id);
+		enp->en_vport_id = EVB_PORT_ID_NULL;
+	}
+#endif
 fail5:
 	EFSYS_PROBE(fail5);
 fail4:
-- 
2.47.3

