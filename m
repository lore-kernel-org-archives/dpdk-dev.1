Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630F8C5CFDB
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:57:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 611F940B95;
	Fri, 14 Aug 2026 14:56:29 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 8FFE94028D
 for <dev@dpdk.org>; Fri, 14 Aug 2026 14:56:27 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.78.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id D832AE0ADB;
 Fri, 14 Aug 2026 16:56:26 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am D832AE0ADB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786712187;
 bh=shpB+sYdwP959siTtsTf8tU0YrnugcyAhRv9zfFbW/4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AJ/6gjlLITfeL5TtBv1bwgMggWprPhzzDgw/WJDu8KajKmjJ0za7csGHX62e9tMJ1
 4LIzJzhQaO0OmKsrt0npnRWlM+bQzWVQSEHrv60119yAnEGdSUK9/VAyb1NwFfU3TJ
 JS72ydtozxQ1xZQ9QweRsZ+4VoHZHYWA4lODclc7kzsFoWt+4Bg+kYTiWf5Z2ec2B/
 jk6+hGOo+0eA9w+43yccnMlUcnYZ7X9tJRHVRNcGrRrVKgYr723cip6AfEZ7fwbmiL
 gfLsBVd1LLr/55PU4xU9gD9UBtov3p0pn/Oz4AmEsrMVXLRihOYNfbtDmsfDFzKxop
 pCWm93CMIutrA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 1/6] common/sfc_efx/base: let Medford4 PF manage VFs
Date: Fri, 14 Aug 2026 16:56:19 +0400
Message-ID: <20260814125624.13372-2-ivan.malov@arknetworks.am>
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

When the user binds the PF to 'vfio-pci', enables SR-IOV
and instantiates a VF, looking to attach both the PF and
the VF to DPDK, the DPDK driver has to instantiate the
EVB switch on the PF. Wire the necessary methods into
the Medford4 EVB implementation in libefx.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/base/efx_evb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/common/sfc_efx/base/efx_evb.c b/drivers/common/sfc_efx/base/efx_evb.c
index 5933c5d883..79db77c635 100644
--- a/drivers/common/sfc_efx/base/efx_evb.c
+++ b/drivers/common/sfc_efx/base/efx_evb.c
@@ -107,6 +107,12 @@ efx_evb_init(
 		break;
 #endif /* EFSYS_OPT_RIVERHEAD */
 
+#if EFSYS_OPT_MEDFORD4
+	case EFX_FAMILY_MEDFORD4:
+		eeop = &__efx_evb_ef10_ops;
+		break;
+#endif /* EFSYS_OPT_MEDFORD4 */
+
 	default:
 		EFSYS_ASSERT(0);
 		rc = ENOTSUP;
-- 
2.47.3

