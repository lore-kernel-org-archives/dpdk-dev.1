Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04135C5B572
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 17:09:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CD74427AF;
	Wed, 12 Aug 2026 19:08:55 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 1480240E34;
 Wed, 12 Aug 2026 19:08:51 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 51692E0BD3;
 Wed, 12 Aug 2026 21:08:50 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 51692E0BD3
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786554530;
 bh=CtLe/osfo1Nr1G/6/3SLEKit6p3nmmIn8u/EZoZedyQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GSWM+AbSPKpqzj+Z0OY8bsb/gr/MIZWWUx6eGkOnTpXHgC79Ecm1Jk7CjujiwDcz8
 W+8df4Sz4Esq89zJkUmTPWaG6IprWD+yYQFp8TCg0u3hbtW7hgNUo7Z31cWx4HdfQA
 2Jwp39i3qYg2bIRXGPQqUXXsZR4fug29RnDqjE167tB2LOC6INin4XpOifgIbYVK7i
 6Kl0fLoZgT+rbmjkFLzkLg+1w3Q4D+xYz9DXpcRzXtR/k7+aPkkiTM5N0uuon7ch0v
 rV9mPEbzdkIh7jOlELVbF//Z8nL+2WuwUtOk5Q6PRchpGXcid9lezVx+2KhZDNrYcV
 61VSnJl3VSECA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH v2 09/14] common/sfc_efx/base: fix annotations in SW-HW enum
 converter
Date: Wed, 12 Aug 2026 21:08:29 +0400
Message-ID: <20260812170834.8443-10-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260812170834.8443-1-ivan.malov@arknetworks.am>
References: <20260811174821.8930-1-ivan.malov@arknetworks.am>
 <20260812170834.8443-1-ivan.malov@arknetworks.am>
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

From: Andy Moreton <andy.moreton@amd.com>

Code analysis reports returning uninitialised memory in *enum_hwp.
Fix the annotations to show that the write only occurs on successful
return.

Fixes: 2be7d23f3fe6 ("common/sfc_efx/base: fill in loopback modes on netport probe")
Cc: stable@dpdk.org

Signed-off-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
---
 drivers/common/sfc_efx/base/efx_np.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 8b8e37c0e1..6cf5aeac11 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -504,6 +504,7 @@ efx_np_sw_link_mode_to_cap(
 	return (0);
 }
 
+__success(*supportedp != 0)
 static					void
 efx_np_cap_enum_sw_to_hw(
 	__in_ecount(hw_sw_map_nentries)	const struct efx_np_cap_map *hw_sw_map,
-- 
2.47.3

