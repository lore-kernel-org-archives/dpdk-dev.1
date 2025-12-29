Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A27E92FE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 21:36:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E01B94065B;
	Mon, 29 Dec 2025 22:35:42 +0100 (CET)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 6306C40616
 for <dev@dpdk.org>; Mon, 29 Dec 2025 22:35:39 +0100 (CET)
Received: from localhost.localdomain (unknown [78.109.70.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id BF06BE15B8;
 Tue, 30 Dec 2025 01:35:38 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am BF06BE15B8
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1767044139;
 bh=5w6j2DB7U1v1H4K7r53PlIKts987shqN1OG9DukdmOc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dLvUml5F7DiA/c8eZHL47gLUblq6jb5s6pexPAK2uFhyrGB1G1t/mFE/QaLGzGHpi
 hpkCM+0jho8OB44Ox9CfYGmd6fYfUHFlkK8RxCJcY9lhrOxNpiK4HtPjL4xULPtyDQ
 W2G4G8x52dbHRolIoDhmpuRGobYp5yfdNXOlUx1jttdxY840ljg6GavnM8h/Z2mrbX
 3e9HlwdN8GIDvfpkH0NvFR/9BgmsHW5K2fJ0Ny0j8ouTTZvKCIlYnNaird1B0xOcsM
 M0DTjEgUQDae2qWo5Hv5US2zkVXdtRypKafLlW7X0lcf0XXczP3h/hCnP5q2KjoRHu
 LkiVGpCANxH8A==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 5/9] common/sfc_efx/base: count Rx TRUNC ERR as CRC errors on
 X4
Date: Tue, 30 Dec 2025 01:35:23 +0400
Message-ID: <20251229213527.37907-6-ivan.malov@arknetworks.am>
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

From: Andy Moreton <andy.moreton@amd.com>

On X4 the MAC hardware reports both over-size packets and CRC errors
in the RX event flag RX_TRUNC_ERR. Over-size packets are only likely
as a result of a misconfigured network, so count the RX_TRUNC_ERR
events as CRC errors.
This workaround is only needed for the per-queue counters maintained
by the driver. The DMA statistics counters maintained by firmware
are not affected.

Signed-off-by: Andy Moreton <andy.moreton@amd.com>
Signed-off-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
---
 drivers/common/sfc_efx/base/ef10_ev.c | 41 +++++++++++++++++++++------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/common/sfc_efx/base/ef10_ev.c b/drivers/common/sfc_efx/base/ef10_ev.c
index a97c1bf43e..ea430d0d5f 100644
--- a/drivers/common/sfc_efx/base/ef10_ev.c
+++ b/drivers/common/sfc_efx/base/ef10_ev.c
@@ -418,6 +418,7 @@ ef10_ev_rx_packed_stream(
 	__in		const efx_ev_callbacks_t *eecp,
 	__in_opt	void *arg)
 {
+	efx_nic_t *enp = eep->ee_enp;
 	uint32_t label;
 	uint32_t pkt_count_lbits;
 	uint16_t flags;
@@ -466,10 +467,22 @@ ef10_ev_rx_packed_stream(
 
 	/* Check for errors that invalidate checksum and L3/L4 fields */
 	if (EFX_QWORD_FIELD(*eqp, ESF_DZ_RX_TRUNC_ERR) != 0) {
-		/* RX frame truncated */
-		EFX_EV_QSTAT_INCR(eep, EV_RX_FRM_TRUNC);
-		flags |= EFX_DISCARD;
-		goto deliver;
+		/*
+		 * X4 uses RX_TRUNC_ERR for packet size and CRC errors. Count
+		 * these as CRC errors (as over-size packets are only likely in
+		 * a misconfigured network).
+		 */
+		if (enp->en_family == EFX_FAMILY_MEDFORD4) {
+			/* Bad Ethernet frame CRC */
+			EFX_EV_QSTAT_INCR(eep, EV_RX_ETH_CRC_ERR);
+			flags |= EFX_DISCARD;
+			goto deliver;
+		} else {
+			/* RX frame truncated */
+			EFX_EV_QSTAT_INCR(eep, EV_RX_FRM_TRUNC);
+			flags |= EFX_DISCARD;
+			goto deliver;
+		}
 	}
 	if (EFX_QWORD_FIELD(*eqp, ESF_DZ_RX_ECRC_ERR) != 0) {
 		/* Bad Ethernet frame CRC */
@@ -630,10 +643,22 @@ ef10_ev_rx(
 
 	/* Check for errors that invalidate checksum and L3/L4 fields */
 	if (EFX_QWORD_FIELD(*eqp, ESF_DZ_RX_TRUNC_ERR) != 0) {
-		/* RX frame truncated */
-		EFX_EV_QSTAT_INCR(eep, EV_RX_FRM_TRUNC);
-		flags |= EFX_DISCARD;
-		goto deliver;
+		/*
+		 * X4 uses RX_TRUNC_ERR for packet size and CRC errors. Count
+		 * these as CRC errors (as over-size packets are only likely in
+		 * a misconfigured network).
+		 */
+		if (enp->en_family == EFX_FAMILY_MEDFORD4) {
+			/* Bad Ethernet frame CRC */
+			EFX_EV_QSTAT_INCR(eep, EV_RX_ETH_CRC_ERR);
+			flags |= EFX_DISCARD;
+			goto deliver;
+		} else {
+			/* RX frame truncated */
+			EFX_EV_QSTAT_INCR(eep, EV_RX_FRM_TRUNC);
+			flags |= EFX_DISCARD;
+			goto deliver;
+		}
 	}
 	if (EFX_QWORD_FIELD(*eqp, ESF_DZ_RX_ECRC_ERR) != 0) {
 		/* Bad Ethernet frame CRC */
-- 
2.47.3

