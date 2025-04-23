Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC18C369D1
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 16:01:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFE034066E;
	Wed, 23 Apr 2025 18:00:22 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 419154064C
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:00:18 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.72.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 7EC28E013F;
 Wed, 23 Apr 2025 20:00:17 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 7EC28E013F
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1745424018;
 bh=aCvxDPkYdARJQCJGO72SfGeYsGcb2fczfZI6xJyXUk8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rN7W3fDQlGiyfq6fNRharm/o/E5ic1JkiHCidz6N12xNYKYJC9HHFFWikFqd+sLPk
 LLQGgWMAr6wl2+bxW/uritw3hTq3TdUAaRtnQ8K9IwZnsoLLaLW4NW38jrKesMO62z
 p4Puvw3j5FAyZHrpMWC+tQb3owRHlg3dbq9M9q4lOGP4P3mTD1qspN2uRzX/Bj6+p0
 TdHOHukSF1QI0iPFVuEiPf6U+TCsornblMLOMbPhvGYwAhk9ryzgx0ic0/7e0Lfa8e
 RIxuqT1+o8mXq6rCNK5JjRIPqi1mn7Tt2Bwkdz3OeNUfMN+o+lV1SR1FIz6kBqOBuU
 dEumPjrrNZoUw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>
Subject: [PATCH v2 08/45] common/sfc_efx/base: add Medford4 support to PHY
 module
Date: Wed, 23 Apr 2025 19:59:25 +0400
Message-Id: <20250423160002.35706-9-ivan.malov@arknetworks.am>
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
 drivers/common/sfc_efx/base/efx_phy.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/common/sfc_efx/base/efx_phy.c b/drivers/common/sfc_efx/base/efx_phy.c
index d55becae18..3d792f20b8 100644
--- a/drivers/common/sfc_efx/base/efx_phy.c
+++ b/drivers/common/sfc_efx/base/efx_phy.c
@@ -114,6 +114,12 @@ efx_phy_probe(
 		break;
 #endif	/* EFSYS_OPT_MEDFORD2 */
 
+#if EFSYS_OPT_MEDFORD4
+	case EFX_FAMILY_MEDFORD4:
+		epop = &__efx_phy_ef10_ops;
+	break;
+#endif	/* EFSYS_OPT_MEDFORD4 */
+
 	default:
 		rc = ENOTSUP;
 		goto fail1;
-- 
2.39.5

