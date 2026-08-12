Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD0FC5B572
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 17:11:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6EFC427CC;
	Wed, 12 Aug 2026 19:11:09 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id AA6CE40E2D
 for <dev@dpdk.org>; Wed, 12 Aug 2026 19:11:07 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 00FB5E0BA6;
 Wed, 12 Aug 2026 21:11:06 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 00FB5E0BA6
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786554667;
 bh=KBFrCgjrMJygAwSFmZ2dxCBbt9vluEIg83H1YW89z0E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=xCIxtvY9N/5Zg9tq1E+SowT9s0K+zQz552KSJttv8eAAnuCo+NOUu/OwuPk2/2CYi
 CTsHUR4Jq955TmvKbTmQ5MvXU/NEcGfWu03fm73B2lVa4axQgQA1Q51XYc7EQpiQeC
 I4BgRtKJ/Im1HHamEUTl7tv1F9LU4zABONm7w/Jc9UGnDIpRz2n53AJc7/lVj91j+J
 wkbIeOkBT2qKt33a7E0R5jLqTGqkreNVPaXpukHuH16xui/1gzxlMK3UrXq3P2F0Dj
 F0J/6MlOnYUkNCmLpbGlSKyD6nxa91CbNKl36fHDFuAz1OHIQrc8eY+SJLahWjgCVg
 OtDV+3HXAhkOg==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 3/6] common/sfc_efx/base: skip netport event subscriptions
 on VFs
Date: Wed, 12 Aug 2026 21:11:00 +0400
Message-ID: <20260812171103.8553-4-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260812171103.8553-1-ivan.malov@arknetworks.am>
References: <20260811175025.9019-1-ivan.malov@arknetworks.am>
 <20260812171103.8553-1-ivan.malov@arknetworks.am>
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
 drivers/common/sfc_efx/base/efx_np.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 7a30567fe0..90a5944b85 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -989,6 +989,7 @@ efx_np_set_event_mask(
 	__in		efx_np_handle_t nph,
 	__in		boolean_t want_linkchange_events)
 {
+	const efx_nic_cfg_t *encp = &enp->en_nic_cfg;
 	EFX_MCDI_DECLARE_BUF(payload,
 	    MC_CMD_SET_NETPORT_EVENTS_MASK_IN_LEN,
 	    MC_CMD_SET_NETPORT_EVENTS_MASK_OUT_LEN);
@@ -996,6 +997,10 @@ efx_np_set_event_mask(
 	efx_dword_t dword;
 	efx_rc_t rc;
 
+	/* VFs do not allow subscription to link change events. */
+	if (EFX_PCI_FUNCTION_IS_VF(encp))
+		return (0);
+
 	req.emr_out_length = MC_CMD_SET_NETPORT_EVENTS_MASK_OUT_LEN;
 	req.emr_in_length = MC_CMD_SET_NETPORT_EVENTS_MASK_IN_LEN;
 	req.emr_cmd = MC_CMD_SET_NETPORT_EVENTS_MASK;
-- 
2.47.3

