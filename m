Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E77C369C2
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:05:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEBEC427B0;
	Wed, 16 Apr 2025 16:01:12 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 3D09842792
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:01:03 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 8AE74E11C3;
 Wed, 16 Apr 2025 18:01:02 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 8AE74E11C3
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812063;
 bh=lLtLqMGKVCDttQ2KjuLMjvO12VnS/Kr1HQtafnwpIIM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pIIGAts42QmjD+AZZ+S1K3ZdKTH24BOwNcRUadYSbEOihvdjpVrkj7yU1rg14q9qi
 kAjAeYqBNjQ71Pywrw+oe4I+eOSUroJ3CUVpVw8hXhbn77B55vpMN+mYjLzTh2XfYe
 WFSLbVsDr15oS/6ebG4QxO+VeAoKbEk8ET3/s9OGqp83qqkkvr9t7U7Y3et5mgz6td
 av+YLVICig6BmRqI2Q1MTSA93gpWdGA52h9Ua5AYNEFM+Q/5WWjI6A4MFXaHG1TK3Z
 pSsNmMlALuJjXo/InDY/8b060p6cYPvWk002A+lEgkBtRgF5moQRj2Yz2vXDgMh8bC
 0riAgeAKgv7vQ==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 39/46] common/sfc_efx/base: ignore legacy link events on new
 boards
Date: Wed, 16 Apr 2025 18:00:09 +0400
Message-Id: <20250416140016.36127-40-ivan.malov@arknetworks.am>
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

New adaptors (for instance, Medford4) come with netport MCDI
and also support new link change events, however, older ones
can also be generated. For consistency, ignore legacy events.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/common/sfc_efx/base/ef10_ev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/common/sfc_efx/base/ef10_ev.c b/drivers/common/sfc_efx/base/ef10_ev.c
index 011ef49de7..82a2284f2b 100644
--- a/drivers/common/sfc_efx/base/ef10_ev.c
+++ b/drivers/common/sfc_efx/base/ef10_ev.c
@@ -907,6 +907,16 @@ ef10_ev_mcdi(
 #endif /* EFSYS_OPT_MCDI_PROXY_AUTH_SERVER */
 
 	case MCDI_EVENT_CODE_LINKCHANGE_V2:
+		if (efx_np_supported(enp) != B_FALSE) {
+			/*
+			 * Netport MCDI capable NICs support new link change
+			 * events, but legacy LINKCHANGE_V2 events may still
+			 * show up should the firmware support them. For the
+			 * sake of consistency, ignore LINKCHANGE_V2 events.
+			 */
+			break;
+		}
+
 		ev_is_v2 = B_TRUE;
 		/* Fallthrough */
 	case MCDI_EVENT_CODE_LINKCHANGE: {
-- 
2.39.5

