Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76703C5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:57:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F54F402C8;
	Fri, 14 Aug 2026 14:56:32 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 1F7D840395
 for <dev@dpdk.org>; Fri, 14 Aug 2026 14:56:29 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.78.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 6AEB3E0B4D;
 Fri, 14 Aug 2026 16:56:28 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 6AEB3E0B4D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786712189;
 bh=ygkqq/F6n0f2EpaR9ct+sp8tl8Yt9P10S+y02es4GyE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=okbgGGSls0GTRkbbuhwFHsIhyW3EASo+Pw1k8rr/1+DZeK1VU/LHEQBM71ooIUnUX
 uI53qnZyXG0tlXvmD6GLMWk3TxyHgAJooM71cUCsvjoH5cSHYv242zzdfSSKPXJGGE
 v5JpkURpaJIlZTWlybyr7Hrgq6OwbRmqmwyf9Yto8v1XOyf7cLzRgMfGO7zFW6oc/9
 pWC+g1cFYAsGV9pSFefUUDIj2YuBetTA+uUtBan1bXGgP1KYNkAzsES+s5BVKD6s3r
 EE9fY2WsUpUeGAwcreVbMEi61XDhmEg9+ZSbLDMj6/YW+Y/VAdDUeYLShYsUdIweFD
 oEfb4SZhsMViQ==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 3/6] common/sfc_efx/base: skip netport event subscriptions
 on VFs
Date: Fri, 14 Aug 2026 16:56:21 +0400
Message-ID: <20260814125624.13372-4-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260814125624.13372-1-ivan.malov@arknetworks.am>
References: <20260811174821.8930-1-ivan.malov@arknetworks.am>
 <20260814125624.13372-1-ivan.malov@arknetworks.am>
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
index aea8a039fc..17bad8ef4f 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -997,6 +997,7 @@ efx_np_set_event_mask(
 	__in		efx_np_handle_t nph,
 	__in		boolean_t want_linkchange_events)
 {
+	const efx_nic_cfg_t *encp = &enp->en_nic_cfg;
 	EFX_MCDI_DECLARE_BUF(payload,
 	    MC_CMD_SET_NETPORT_EVENTS_MASK_IN_LEN,
 	    MC_CMD_SET_NETPORT_EVENTS_MASK_OUT_LEN);
@@ -1004,6 +1005,10 @@ efx_np_set_event_mask(
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

