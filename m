Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C2BC369D1
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 16:00:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 325AE40651;
	Wed, 23 Apr 2025 18:00:19 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 050DD402F0
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:00:15 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.72.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 3FB23E02AA;
 Wed, 23 Apr 2025 20:00:14 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 3FB23E02AA
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1745424014;
 bh=hyBbtZdzgwn9cuVDrBgTU7v4f4Hdlf00yAtyE1AUFTA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VJuWA7wqF0gdDe4XqKU3xuQupF9sgcJf0XgVgOFngAzEpraZbncPy4LlKpsX9xRB9
 O8K/1lBbeII8bkmimf72X2fMNWYid9Fq7XNU5snJ9U5eGF5tuuU3RrmsQM5ARxVDF/
 aYFzwk3gckhc+iuUOLJQhJp0W9GwuZQLBcQyqu8msoyGHZs8jV9XzoxeP12xMGlaDT
 34DqCyocRU+jbnHq1pZLnW771F43bkxjqUigN9LO0blCqSyaoyM9DXQAhTATvI6NDB
 m5RWLgu4+UYmpJ/OlL90oqyHlp7RalVZGJlrQCsyIX+jhC43T8GreHyWQSBuCtjTVg
 l9avHFXdIm15A==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>
Subject: [PATCH v2 04/45] common/sfc_efx/base: add Medford4 support to EV
 module
Date: Wed, 23 Apr 2025 19:59:21 +0400
Message-Id: <20250423160002.35706-5-ivan.malov@arknetworks.am>
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
 drivers/common/sfc_efx/base/efx_ev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/common/sfc_efx/base/efx_ev.c b/drivers/common/sfc_efx/base/efx_ev.c
index 4808f8ddfc..13159a10f4 100644
--- a/drivers/common/sfc_efx/base/efx_ev.c
+++ b/drivers/common/sfc_efx/base/efx_ev.c
@@ -173,6 +173,12 @@ efx_ev_init(
 		break;
 #endif /* EFSYS_OPT_RIVERHEAD */
 
+#if EFSYS_OPT_MEDFORD4
+	case EFX_FAMILY_MEDFORD4:
+		eevop = &__efx_ev_ef10_ops;
+		break;
+#endif /* EFSYS_OPT_MEDFORD4 */
+
 	default:
 		EFSYS_ASSERT(0);
 		rc = ENOTSUP;
-- 
2.39.5

