Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6EBC5CFDB
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:56:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52C5340DF6;
	Fri, 14 Aug 2026 14:55:04 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 91AD040A6C;
 Fri, 14 Aug 2026 14:54:57 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.78.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id C2A04E0ADB;
 Fri, 14 Aug 2026 16:54:56 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am C2A04E0ADB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786712097;
 bh=h/9wfxppFdaSqHfA7QhI7Rq+NxcgtkvlxFAQhS7rqHc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JZDOjmuYNapqwKrFpHY9InQnsECSW2qVxyXIvmYeCa+0o6TgCQCoXmC1Cqu8VADjr
 LDBDz9/+OnxiY+WrJfv/Uest3L4BDWWqClSBVC1Ng1ehHZ7ehVfxrSIs45jQQbnWKz
 qdHb66oplpJlyeI8pEocEutjelZwl1i+WKb8OfmjcYs5ZgYCnCwI7wbnW5gzn5Ijfj
 D2bN9ZiqTt+9VRAZg9egk87bZv2v4OUdaA598nXJHy5kpYou7AWLv5nLCV7IeZVBXU
 dvVLNk6tGL/O7nSvwnJz8sqGWBFSvH59ObguySGSbs6XTaJbNB/TuP8uUoJRjCKY+4
 /84JgByxqzKkQ==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH v3 12/14] common/sfc_efx/base: fix filter in SW-HW mask
 converter
Date: Fri, 14 Aug 2026 16:54:36 +0400
Message-ID: <20260814125438.13283-13-ivan.malov@arknetworks.am>
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

Code analysis reports that the optional filter_arg could be used to invoke
the callback, but that function has type efx_np_cap_filter_cb, where the
argument is required. Add a NULL check to ensure that the filter_arg
is valid when invoking the callback.

Fixes: b50ff442479c ("common/sfc_efx/base: support controls for netport lane count")
Cc: stable@dpdk.org

Signed-off-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
---
 drivers/common/sfc_efx/base/efx_np.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index ec76985054..6fc024e17b 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -1170,7 +1170,7 @@ efx_np_cap_mask_sw_to_hw(
 	__in				uint32_t mask_sw,
 	__in_opt			efx_np_cap_filter_cb *filter_cb,
 	__in_opt			void *filter_arg,
-	__out				uint8_t *mask_hwp)
+	__inout				uint8_t *mask_hwp)
 {
 	FOREACH_SUP_CAP(hw_sw_map, hw_sw_map_nentries,
 	    hw_cap_data, hw_cap_data_nbytes) {
@@ -1179,8 +1179,8 @@ efx_np_cap_mask_sw_to_hw(
 		if ((mask_sw & flag_sw) != flag_sw)
 			continue;
 
-		if (filter_cb != NULL &&
-		    filter_cb(hw_sw_map->encm_hw, filter_arg) == B_FALSE)
+		if ((filter_cb != NULL) && (filter_arg != NULL) &&
+		    (filter_cb(hw_sw_map->encm_hw, filter_arg) == B_FALSE))
 			continue;
 
 		mask_hwp[CAP_BYTE(hw_sw_map)] |= CAP_FLAG(hw_sw_map);
-- 
2.47.3

