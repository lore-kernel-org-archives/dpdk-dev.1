Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B70C5B572
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Aug 2026 06:21:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D21CA40612;
	Sun, 16 Aug 2026 08:20:58 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 1CD3A4065A
 for <dev@dpdk.org>; Sun, 16 Aug 2026 08:20:54 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.77.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 92536E0883;
 Sun, 16 Aug 2026 10:20:52 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 92536E0883
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786861253;
 bh=gxQW29krNq68b2PH16JgOu3ktkaJdpijcMmg7Fd4lxw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kiSuwKTNtJ9AbkxyPJVj7Q4Mv2HZLMyTJh9iF3u25Fusn04r9egQ/HrCy5mV+UiFA
 6RmakhLd6se13FHrtZauf2HIxSCKq6OA5fuKvGTYx3TDJ3U/Zx+IWTulCAgofo1JCz
 O540sb8P5D1zpp7rfRBjQLoIqJKCCi3toT5kp1NFjSQKovddxGUFJCyvYLla86E8zc
 kFyjTjipA2PduWNo44cYww3osxX+9h20rtmny0zWYlfGXa3j6JU4OmCgp1C+tC2a6k
 +swGT/U06+w0L03rr96nFd++C60Y9aLjJCZWZHlxQo/wb6dPizJojPOxZIa0eb92+y
 0CMQym3cIb+Vw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v4 3/6] common/sfc_efx/base: skip netport event subscriptions
 on VFs
Date: Sun, 16 Aug 2026 10:20:37 +0400
Message-ID: <20260816062040.15562-4-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260816062040.15562-1-ivan.malov@arknetworks.am>
References: <20260811175025.9019-1-ivan.malov@arknetworks.am>
 <20260816062040.15562-1-ivan.malov@arknetworks.am>
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

Subscribing to netport events is not permitted on VFs.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/base/efx_np.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index bf0e639704..8853ce07c3 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -1009,6 +1009,7 @@ efx_np_set_event_mask(
 	__in		efx_np_handle_t nph,
 	__in		boolean_t want_linkchange_events)
 {
+	const efx_nic_cfg_t *encp = &enp->en_nic_cfg;
 	EFX_MCDI_DECLARE_BUF(payload,
 	    MC_CMD_SET_NETPORT_EVENTS_MASK_IN_LEN,
 	    MC_CMD_SET_NETPORT_EVENTS_MASK_OUT_LEN);
@@ -1016,6 +1017,10 @@ efx_np_set_event_mask(
 	efx_dword_t dword;
 	efx_rc_t rc;
 
+	/* VFs do not allow subscription to link change events. */
+	if (EFX_PCI_FUNCTION_IS_VF(encp))
+		return (0);
+
 	req.emr_out_length = MC_CMD_SET_NETPORT_EVENTS_MASK_OUT_LEN;
 	req.emr_in_length = MC_CMD_SET_NETPORT_EVENTS_MASK_IN_LEN;
 	req.emr_cmd = MC_CMD_SET_NETPORT_EVENTS_MASK;
@@ -1139,7 +1144,7 @@ efx_np_attach(
 	 */
 	epp->ep_np_prev_fec_ctrl = MC_CMD_FEC_AUTO;
 
-	/* Subscribe to link change events. */
+	/* Subscribe to link change events; a no-op on VFs. */
 	rc = efx_np_set_event_mask(enp, epp->ep_np_handle, B_TRUE);
 	if (rc != 0)
 		goto fail6;
-- 
2.47.3

