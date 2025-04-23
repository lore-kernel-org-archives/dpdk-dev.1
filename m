Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461E9C369D1
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 16:00:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 136784065A;
	Wed, 23 Apr 2025 18:00:20 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id C87A940430
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:00:15 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.72.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 13BFAE02EB;
 Wed, 23 Apr 2025 20:00:15 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 13BFAE02EB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1745424015;
 bh=fLUe+xpTuE9gOEwb0Y1rmKT2U+L8CPisYIchQRqywxQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YYl1xOb7i6vukV84y9ZgPUbfTkEZ8reitGxAPWU2mbV/DRC/FLTKVvBaINxl72GFM
 /HXVRnHwc2x0TjtQJ4hV8/0Aeiak5a+ccwy6XVB6ixlZl5/uCeGwVv5SRmLkSKmmEN
 VwykeKlza4yvaYgW4kcmllL+xSRgnXXLZ7ZgzKYWKDeZHTqFZY85oFZjHZhPNT4/20
 xlDzw4InCeFMNUDhHdGPwVJLYbiwyawVJ/HlyhPU343vQAjsTGj61capLT7eoLmwjf
 WAITU/OF1ZIDNmjumKLUox2Wne0ubza24pR2hSxO7vCDgp4pYDTKVq+wjX+dRoWcAY
 sa/FW5ZzRRRiw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>
Subject: [PATCH v2 05/45] common/sfc_efx/base: add Medford4 support to FILTER
 module
Date: Wed, 23 Apr 2025 19:59:22 +0400
Message-Id: <20250423160002.35706-6-ivan.malov@arknetworks.am>
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
 drivers/common/sfc_efx/base/efx_filter.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/common/sfc_efx/base/efx_filter.c b/drivers/common/sfc_efx/base/efx_filter.c
index 2c8c7bdc33..551db58fdd 100644
--- a/drivers/common/sfc_efx/base/efx_filter.c
+++ b/drivers/common/sfc_efx/base/efx_filter.c
@@ -201,6 +201,12 @@ efx_filter_init(
 		break;
 #endif /* EFSYS_OPT_RIVERHEAD */
 
+#if EFSYS_OPT_MEDFORD4
+	case EFX_FAMILY_MEDFORD4:
+		efop = &__efx_filter_ef10_ops;
+		break;
+#endif /* EFSYS_OPT_MEDFORD4 */
+
 	default:
 		EFSYS_ASSERT(0);
 		rc = ENOTSUP;
-- 
2.39.5

