Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B027C369C2
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:04:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2516E427A3;
	Wed, 16 Apr 2025 16:01:01 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id B0FC94275D
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:00:54 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 08F00E11AD;
 Wed, 16 Apr 2025 18:00:53 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 08F00E11AD
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812054;
 bh=GGCszyF5GZ2HGGwCVl6LtftHhwmJ7EE0l4PEpzcZp80=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uRv2UTYufXWIRscQy0EUwqy+w1pDV1sf1KOOAhuPOLgqYqut1fAbs9r264GIHGBnF
 MNM9+wSM+goga6hE9QMrKhIOHmmiRgfEAZZC0SHwSxH3A1CSDXRB8wEchf6NXBX+Xf
 L8uCr+XURzE6zOMW+dvbsx2W+j3x56hedfJmMrwmFVZrUua05/c8rIolYs0FBv/827
 JG7NTBbHlrL0LIC5HTF+7u2OW1eNa9CCRY5ySExjSo76m2wXauOoy/xbO56vSe0bAY
 0ZKyC3Ad5bS3sX4FxNQL8xf743QzXKWk4PzDOU0kSbvpo9LvKZG3X5atPcpFbsNZwS
 qWO3txv/0Kj4w==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 28/46] common/sfc_efx/base: refactor EF10 link mode decoding
 helper
Date: Wed, 16 Apr 2025 17:59:58 +0400
Message-Id: <20250416140016.36127-29-ivan.malov@arknetworks.am>
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

Future patches will use this change for netport MCDI support.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/common/sfc_efx/base/ef10_impl.h | 13 +++++++++++
 drivers/common/sfc_efx/base/ef10_phy.c  | 31 ++++++++++++++++++-------
 2 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/common/sfc_efx/base/ef10_impl.h b/drivers/common/sfc_efx/base/ef10_impl.h
index 3476f274ce..b872ec626c 100644
--- a/drivers/common/sfc_efx/base/ef10_impl.h
+++ b/drivers/common/sfc_efx/base/ef10_impl.h
@@ -801,6 +801,19 @@ ef10_phy_stats_update(
 
 #endif	/* EFSYS_OPT_PHY_STATS */
 
+LIBEFX_INTERNAL
+extern				void
+mcdi_phy_decode_link_mode(
+	__in			efx_nic_t *enp,
+	__in			boolean_t fd,
+	__in			boolean_t up,
+	__in			unsigned int speed,
+	__in			unsigned int fcntl,
+	__in			uint32_t fec,
+	__out			efx_link_mode_t *link_modep,
+	__out			unsigned int *fcntlp,
+	__out			efx_phy_fec_type_t *fecp);
+
 #if EFSYS_OPT_BIST
 
 LIBEFX_INTERNAL
diff --git a/drivers/common/sfc_efx/base/ef10_phy.c b/drivers/common/sfc_efx/base/ef10_phy.c
index 49babdecd5..d458199c7a 100644
--- a/drivers/common/sfc_efx/base/ef10_phy.c
+++ b/drivers/common/sfc_efx/base/ef10_phy.c
@@ -92,10 +92,21 @@ mcdi_phy_decode_cap(
 	*maskp = mask;
 }
 
-static			void
+static				void
+mcdi_phy_decode_link_up_duplex(
+	__in			uint32_t link_flags,
+	__out			boolean_t *fdp,
+	__out			boolean_t *upp)
+{
+	*fdp = !!(link_flags & (1U << MC_CMD_GET_LINK_OUT_FULL_DUPLEX_LBN));
+	*upp = !!(link_flags & (1U << MC_CMD_GET_LINK_OUT_LINK_UP_LBN));
+}
+
+			void
 mcdi_phy_decode_link_mode(
 	__in		efx_nic_t *enp,
-	__in		uint32_t link_flags,
+	__in		boolean_t fd,
+	__in		boolean_t up,
 	__in		unsigned int speed,
 	__in		unsigned int fcntl,
 	__in		uint32_t fec,
@@ -103,11 +114,6 @@ mcdi_phy_decode_link_mode(
 	__out		unsigned int *fcntlp,
 	__out		efx_phy_fec_type_t *fecp)
 {
-	boolean_t fd = !!(link_flags &
-		    (1 << MC_CMD_GET_LINK_OUT_FULL_DUPLEX_LBN));
-	boolean_t up = !!(link_flags &
-		    (1 << MC_CMD_GET_LINK_OUT_LINK_UP_LBN));
-
 	_NOTE(ARGUNUSED(enp))
 
 	if (!up)
@@ -179,6 +185,8 @@ ef10_phy_link_ev(
 	unsigned int ev_fcntl;
 	unsigned int ev_speed;
 	uint32_t lp_cap_mask;
+	boolean_t fd;
+	boolean_t up;
 
 	if (ev_is_v2) {
 		link_flags = (1 << MC_CMD_GET_LINK_OUT_FULL_DUPLEX_LBN);
@@ -226,7 +234,8 @@ ef10_phy_link_ev(
 		break;
 	}
 
-	mcdi_phy_decode_link_mode(enp, link_flags, speed, ev_fcntl,
+	mcdi_phy_decode_link_up_duplex(link_flags, &fd, &up);
+	mcdi_phy_decode_link_mode(enp, fd, up, speed, ev_fcntl,
 				    MC_CMD_FEC_NONE, &link_mode,
 				    &fcntl, &fec);
 	mcdi_phy_decode_cap(ev_lp_cap, &lp_cap_mask);
@@ -281,6 +290,8 @@ ef10_phy_get_link(
 	uint32_t fec;
 	EFX_MCDI_DECLARE_BUF(payload, MC_CMD_GET_LINK_IN_LEN,
 		MC_CMD_GET_LINK_OUT_V2_LEN);
+	boolean_t fd;
+	boolean_t up;
 	efx_rc_t rc;
 
 	req.emr_cmd = MC_CMD_GET_LINK;
@@ -311,7 +322,9 @@ ef10_phy_get_link(
 	else
 		fec = MCDI_OUT_DWORD(req, GET_LINK_OUT_V2_FEC_TYPE);
 
-	mcdi_phy_decode_link_mode(enp, MCDI_OUT_DWORD(req, GET_LINK_OUT_FLAGS),
+	mcdi_phy_decode_link_up_duplex(MCDI_OUT_DWORD(req, GET_LINK_OUT_FLAGS),
+				    &fd, &up);
+	mcdi_phy_decode_link_mode(enp, fd, up,
 			    MCDI_OUT_DWORD(req, GET_LINK_OUT_LINK_SPEED),
 			    MCDI_OUT_DWORD(req, GET_LINK_OUT_FCNTL),
 			    fec, &elsp->epls.epls_link_mode,
-- 
2.39.5

