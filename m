Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B9FCA0EE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 12:36:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5B2D40A6F;
	Wed, 13 Aug 2025 14:36:39 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id CCBB840265;
 Wed, 13 Aug 2025 14:36:38 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.79.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id EC6A6E04CB;
 Wed, 13 Aug 2025 16:36:37 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am EC6A6E04CB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1755088598;
 bh=ax+5fMIsmdjlqiiKnlSxv+Unkc7cVWfczR5jWrmcI9o=;
 h=From:To:Cc:Subject:Date:From;
 b=axW2Rx5uaMeMnjq4sAaybuRMdL9DULG8T9zTsEnekkS349mY7q74CYQgoTMWvQi6i
 koTefCvLDZLtn8LfuDjdNvKnmqlFMep44vepcMO2bEtHcBrF3m9Exxl9HczN3ETugC
 ey7qZ8DG0r8EDKpcCjT8Zk8fE2YlP/1xkqASylKAaBwia2h/NXYW+F8kNif56UMC8V
 vKkdu2G3Jz8mtf3OOmeds4DJ++fMIZHRC4DFI6/l1RCb34bdGGm669jHA25HCYOKe+
 V6zVl9In9mVqj0uw7XPVDrE8BILGVZ9Q+tv7ZXO3waEdFSvQlXbM5P2LEezyHNugbd
 O2rPNSePeLqqA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 stable@dpdk.org
Subject: [PATCH 1/1] common/sfc_efx/base: revise legacy port controls on
 Medford4
Date: Wed, 13 Aug 2025 16:36:36 +0400
Message-ID: <20250813123636.16363-1-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.2
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

Theoretically, adaptor firmware may not support new netport API. Currently,
efx_np_supported() assumes Medford4 always supports the API, however, this
can be improved in the future by checking some capability bit during probe.

If efx_np_supported() returns B_FALSE, then one should not invoke Medford4
PHY and MAC methods that are inherently dependent on new netport API. Pick
EF10-generic PHY and MAC methods in this case to maintain legacy behaviour.

Fixes: 8dac31d073af ("common/sfc_efx/base: introduce Medford4 stub for MAC methods")
Fixes: d65a7129c413 ("common/sfc_efx/base: introduce Medford4 stub for PHY methods")
Cc: stable@dpdk.org

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/base/efx_mac.c | 6 +++++-
 drivers/common/sfc_efx/base/efx_phy.c | 5 ++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_mac.c b/drivers/common/sfc_efx/base/efx_mac.c
index 69f053ce44..9dc1eb23b9 100644
--- a/drivers/common/sfc_efx/base/efx_mac.c
+++ b/drivers/common/sfc_efx/base/efx_mac.c
@@ -1000,7 +1000,11 @@ efx_mac_select(
 
 #if EFSYS_OPT_MEDFORD4
 	case EFX_FAMILY_MEDFORD4:
-		emop = &__efx_mac_medford4_ops;
+		if (efx_np_supported(enp) != B_FALSE)
+			emop = &__efx_mac_medford4_ops;
+		else
+			emop = &__efx_mac_ef10_ops;
+
 		type = EFX_MAC_MEDFORD4;
 		break;
 #endif /* EFSYS_OPT_MEDFORD4 */
diff --git a/drivers/common/sfc_efx/base/efx_phy.c b/drivers/common/sfc_efx/base/efx_phy.c
index 1f99c72e62..6e5521db20 100644
--- a/drivers/common/sfc_efx/base/efx_phy.c
+++ b/drivers/common/sfc_efx/base/efx_phy.c
@@ -136,7 +136,10 @@ efx_phy_probe(
 
 #if EFSYS_OPT_MEDFORD4
 	case EFX_FAMILY_MEDFORD4:
-		epop = &__efx_phy_medford4_ops;
+		if (efx_np_supported(enp) != B_FALSE)
+			epop = &__efx_phy_medford4_ops;
+		else
+			epop = &__efx_phy_ef10_ops;
 	break;
 #endif	/* EFSYS_OPT_MEDFORD4 */
 
-- 
2.17.1

