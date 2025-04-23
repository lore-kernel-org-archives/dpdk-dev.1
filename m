Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B6AC369D1
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 16:01:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA9B540667;
	Wed, 23 Apr 2025 18:00:21 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 6ADBC40613
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:00:17 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.72.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id ACBAFE0159;
 Wed, 23 Apr 2025 20:00:16 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am ACBAFE0159
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1745424017;
 bh=HNTWVAI0Mg/6lBe25UqcUu9FWXz+Uaq81XVei0dG3j8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=1TSR7AlRFO+OldlhTjvAjdFDUg6NyQCKS4tR8NNtQCs9JXP2gRmotQzdXuCu6zc6q
 j5g8pTmSXd0lvVZizdcW3LHL8pvxQBW8RA0jq/NANAqEcOWqHBcxFv1LoLT3AEsThK
 3iIyeGlrCacQRPJuLPmnrZfuGkEb2XfK7cvOYTzkaiEuZmztFGg1Mk4GBteGoAoKcB
 Ot+8hB/Uo0D2srNcBOr7OZyOjSb47hajfb0NYoTz09z1D/eOLsP2qGTo7PO6xaEk4+
 6m+kOLHRJ1b88KmHEnaDVFfFJ8fO6CjCGW9UFBQIa7IbYTM8G+WOy6vte1olmjorFT
 GmRveVBTftp5A==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>
Subject: [PATCH v2 07/45] common/sfc_efx/base: add Medford4 support to MAC
 module
Date: Wed, 23 Apr 2025 19:59:24 +0400
Message-Id: <20250423160002.35706-8-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250423160002.35706-1-ivan.malov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
 <20250423160002.35706-1-ivan.malov@arknetworks.am>
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

From: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>

Use common EF10 method table for that.

Signed-off-by: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/base/efx_impl.h | 1 +
 drivers/common/sfc_efx/base/efx_mac.c  | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/common/sfc_efx/base/efx_impl.h b/drivers/common/sfc_efx/base/efx_impl.h
index 9d1f361c5d..89b7e0292e 100644
--- a/drivers/common/sfc_efx/base/efx_impl.h
+++ b/drivers/common/sfc_efx/base/efx_impl.h
@@ -79,6 +79,7 @@ typedef enum efx_mac_type_e {
 	EFX_MAC_MEDFORD,
 	EFX_MAC_MEDFORD2,
 	EFX_MAC_RIVERHEAD,
+	EFX_MAC_MEDFORD4,
 	EFX_MAC_NTYPES
 } efx_mac_type_t;
 
diff --git a/drivers/common/sfc_efx/base/efx_mac.c b/drivers/common/sfc_efx/base/efx_mac.c
index 13cac5a751..a2cbf02b46 100644
--- a/drivers/common/sfc_efx/base/efx_mac.c
+++ b/drivers/common/sfc_efx/base/efx_mac.c
@@ -953,6 +953,13 @@ efx_mac_select(
 		break;
 #endif /* EFSYS_OPT_RIVERHEAD */
 
+#if EFSYS_OPT_MEDFORD4
+	case EFX_FAMILY_MEDFORD4:
+		emop = &__efx_mac_ef10_ops;
+		type = EFX_MAC_MEDFORD4;
+		break;
+#endif /* EFSYS_OPT_MEDFORD4 */
+
 	default:
 		rc = EINVAL;
 		goto fail1;
-- 
2.39.5

