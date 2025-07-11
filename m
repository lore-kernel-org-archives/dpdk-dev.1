Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5402CC83F1B
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Jul 2025 14:44:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6B0540B95;
	Fri, 11 Jul 2025 16:44:02 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 795AA406B7
 for <dev@dpdk.org>; Fri, 11 Jul 2025 16:44:00 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.90])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id C0694E0FAE;
 Fri, 11 Jul 2025 18:43:59 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am C0694E0FAE
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1752245040;
 bh=d5eV5/xMmGW9l1IL8crCcPf12DJw4spIjP/6uhWwnIY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=wegUU38BrJNaDfvJFoHp3NWZTihapL5f8xBR2hXzAIqMSf5R0oYrqESdfY+uvqzTe
 AtM/2kJzT8HOG69V6srknFk/nk9WOY2EuH1txj0tmEyuj1amNRo0H2t1Ar+6NN8LhX
 xE/NRBX9zTRBRZtmSO4ZH9uqwgkLCJOhynrvipqtaSIs7kvQf9rOq35t6xNWY6BfhS
 p0jGvpdJsszjsgrNPXZdshKTlL5R2pIaKYWQVqYnrNuP7vdlJ8l4Hn0YaNHBGynExs
 C9QRL8KeUp75Zp23kr+17SCz80y1N7BzY2oAtEDMaCtcDNBVRbmjlH+68Jwy/n49pu
 Kwe2hTLbBi3Ew==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 3/3] common/sfc_efx/base: fix compiler warning in PHY link
 getter
Date: Fri, 11 Jul 2025 18:43:49 +0400
Message-Id: <20250711144349.9236-4-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250711144349.9236-1-ivan.malov@arknetworks.am>
References: <20250711144349.9236-1-ivan.malov@arknetworks.am>
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

Fixes: 2a5cf77e6de8 ("common/sfc_efx/base: provide PHY link get method on Medford4")

Suggested-by: Andy Moreton <andy.moreton@amd.com>
Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/base/medford4_phy.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/common/sfc_efx/base/medford4_phy.c b/drivers/common/sfc_efx/base/medford4_phy.c
index 9ba6dfbc10..16e6dd2d84 100644
--- a/drivers/common/sfc_efx/base/medford4_phy.c
+++ b/drivers/common/sfc_efx/base/medford4_phy.c
@@ -34,7 +34,6 @@ medford4_phy_get_link(
 	efx_np_handle_t nph = enp->en_port.ep_np_handle;
 	efx_np_link_state_t ls;
 	efx_np_mac_state_t ms;
-	uint32_t fcntl;
 	efx_rc_t rc;
 
 	rc = efx_np_link_state(enp, nph, &ls);
-- 
2.39.5

