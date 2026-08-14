Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4C6C5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:55:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 599A740B8C;
	Fri, 14 Aug 2026 14:55:00 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id EBDCB40647;
 Fri, 14 Aug 2026 14:54:54 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.78.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 29F5AE0F53;
 Fri, 14 Aug 2026 16:54:54 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 29F5AE0F53
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786712094;
 bh=xIXwG/5vlgKMJBFSx/XNXVHp+DQYcNfyHY+uwu1+EOw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NDfk0ilgwPs/m3PMQmIXNCE4UNI8YiCckKtx4A9uX64c7nOEHTNmyVH2xjOwJsTOq
 eT68PvLuSyNi9aWzQ8SfaiCjMan3mhIi4Iv5XATAOddLfBmuV6JqueRkZQJW27+UsL
 3rlapD1rR0J34WnckY0PXDeTxSRCd7IajlEIt82o3FX4YzHLtTnE3g98nRElUPD13l
 ko6wZxJper9gnArrkoJUHRPQ3pTiaLJ2U93D4om13XRVdQH9bNOAD9Mu9cQ0plfVhq
 QfJ7qb1AYMOVsjo5rq63wz34RScKHqNXmmDm7e/QxL0+Lf1wc5RbAhLgPswjyqbAkw
 5UTFy47RQGlVA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH v3 09/14] common/sfc_efx/base: fix annotations in SW-HW enum
 converter
Date: Fri, 14 Aug 2026 16:54:33 +0400
Message-ID: <20260814125438.13283-10-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260814125438.13283-1-ivan.malov@arknetworks.am>
References: <20260811174821.8930-1-ivan.malov@arknetworks.am>
 <20260814125438.13283-1-ivan.malov@arknetworks.am>
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
 drivers/common/sfc_efx/base/efx_np.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index da2a158142..fd4432a2a4 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -504,7 +504,7 @@ efx_np_sw_link_mode_to_cap(
 	return (0);
 }
 
-static					void
+__success(*supportedp != 0)	static	void
 efx_np_cap_enum_sw_to_hw(
 	__in_ecount(hw_sw_map_nentries)	const struct efx_np_cap_map *hw_sw_map,
 	__in				unsigned int hw_sw_map_nentries,
-- 
2.47.3

