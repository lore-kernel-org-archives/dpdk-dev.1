Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763BEC5B572
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 17:50:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C418427D3;
	Tue, 11 Aug 2026 19:50:33 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id BD768415D7
 for <dev@dpdk.org>; Tue, 11 Aug 2026 19:50:29 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 12109E05C7;
 Tue, 11 Aug 2026 21:50:29 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 12109E05C7
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786470629;
 bh=Cti1xiNNzq0zl6tNOo/0Dn6OT2aKBVYwGcbIiu4cIJc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=n9f/jkyxrl5Gs7+79UnNthQX3Q4pwjTf+EpcQsyKKqTfVVFbm2lqcfx5BBSREsQca
 DWRHx8awT1D5VQg1N8/g3Bf1lGmSMxe3WsdyV5NKVejHmrX8Jtpof8UNAMiybs2mOo
 I0+B3174EMYE8DjwbddetQ2qQCAUmviRyASACOjUq3BX5evBvmgHyR9wIadEAASEvv
 xzYQfGqXMeEPi85d8Gr6J89rLXz+nCTrNJZrOmnoP3sfer/4wkgmnOOpO7DHJgKZVj
 Q5HUF2UQIjBvZ+/2+6XNVy5Z+l879phla+pTPYLf1KeNbpsWHoXyLy6MMnZe4Iqr5e
 WNnedAHYqZx6w==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 3/6] common/sfc_efx/base: skip netport event subscriptions on
 VFs
Date: Tue, 11 Aug 2026 21:50:22 +0400
Message-ID: <20260811175025.9019-4-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260811175025.9019-1-ivan.malov@arknetworks.am>
References: <20260811175025.9019-1-ivan.malov@arknetworks.am>
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
index e05e2cb487..1563fbae37 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -1005,6 +1005,7 @@ efx_np_set_event_mask(
 	__in		efx_np_handle_t nph,
 	__in		boolean_t want_linkchange_events)
 {
+	const efx_nic_cfg_t *encp = &enp->en_nic_cfg;
 	EFX_MCDI_DECLARE_BUF(payload,
 	    MC_CMD_SET_NETPORT_EVENTS_MASK_IN_LEN,
 	    MC_CMD_SET_NETPORT_EVENTS_MASK_OUT_LEN);
@@ -1012,6 +1013,10 @@ efx_np_set_event_mask(
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

