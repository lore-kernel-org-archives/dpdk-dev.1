Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9DEC5B56A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 17:49:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2613427D3;
	Tue, 11 Aug 2026 19:48:45 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id F0381427A2;
 Tue, 11 Aug 2026 19:48:38 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 37119E0F09;
 Tue, 11 Aug 2026 21:48:38 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 37119E0F09
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786470518;
 bh=TnpxNVL7UxXUPdv1Qq+2VUpmxSKr67WDxst5TNYJ81s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ohscGKh8LbWfBcoj7skG7pNrp4VtEE1vRYELEQIfJ5P2fYJeb/vrS+88hWKjIPDBv
 go0K+w5vW2TOsZ9GgEM5WFkCTSrSR0tfygVcm7RyZOnjdz8wxbrTh0haOpuFKsS9t7
 vv52jDGwGqKLUbSTAWRmWeJbuD58xqsJ1LoJ8tI6EFLk8l5dJOrOy7dVcQJjKu32rF
 umNjoNJONxvRnRd6fTymO5ACmgiF8d6CmV45gQLGy2K/TYJSdtgvKO4qeyOHI4UzgO
 vQA3RFGdLYCxfOOAYNuiUm5J4J8XgdGYpeF+6jFvdCqqR8v5Lr1pESvCTiVHL0Gjlm
 x1pBss77gsezw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH 11/14] common/sfc_efx/base: fix flex array in netport stat
 describe
Date: Tue, 11 Aug 2026 21:48:18 +0400
Message-ID: <20260811174821.8930-12-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260811174821.8930-1-ivan.malov@arknetworks.am>
References: <20260811174821.8930-1-ivan.malov@arknetworks.am>
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

Code analysis reported returning uninitialised memory at *lut and
*nprocessedp. Refactor to ensure these parameters are only used
when non-NULL.

This function should also be using the ENTRY_COUNT field for the
number of descriptors returned, as the descriptor size is not
known statically (they are extensible). Also use the MORE_ENTRIES
flag to determine if all of the descriptors have been fetched.

Fixes: f2f77453cb9f ("common/sfc_efx/base: fill in software LUT for MAC statistics")
Cc: stable@dpdk.org

Signed-off-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
---
 drivers/common/sfc_efx/base/efx_np.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 86e5d11506..af06c10ecc 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -783,10 +783,11 @@ efx_np_stats_describe(
 	__out_opt			uint32_t *nstats_maxp)
 {
 	uint8_t *payload = NULL;
-	uint32_t nprocessed;
 	efx_mcdi_req_t req;
 	uint8_t *entries;
 	uint32_t stride;
+	uint32_t count;
+	uint32_t more;
 	unsigned int i;
 	size_t out_sz;
 	size_t size;
@@ -829,25 +830,28 @@ efx_np_stats_describe(
 		    sizeof (efx_qword_t);
 	}
 
-	if (lut_nentries == 0 || lut == NULL || nprocessedp == NULL)
-		goto out;
-
 	stride = MCDI_OUT_DWORD(req, MAC_STATISTICS_DESCRIPTOR_OUT_ENTRY_SIZE);
-	nprocessed = MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_ENTRIES_NUM(out_sz);
-	if (nprocessed == 0) {
+	count = MCDI_OUT_DWORD(req, MAC_STATISTICS_DESCRIPTOR_OUT_ENTRY_COUNT);
+	more = MCDI_OUT_DWORD(req, MAC_STATISTICS_DESCRIPTOR_OUT_MORE_ENTRIES);
+
+	if ((count == 0) && (more != 0)) {
 		rc = EMSGSIZE;
 		goto fail4;
 	}
 
-	entries = MCDI_OUT2(req, uint8_t,
-	    MAC_STATISTICS_DESCRIPTOR_OUT_ENTRIES);
+	if (lut != NULL) {
+		entries = MCDI_OUT2(req, uint8_t,
+		    MAC_STATISTICS_DESCRIPTOR_OUT_ENTRIES);
 
-	for (i = 0; i < nprocessed; ++i)
-		efx_np_stat_describe(entries + i * stride, lut_nentries, lut);
+		for (i = 0; i < count; ++i) {
+			efx_np_stat_describe(entries + i * stride,
+			    lut_nentries, lut);
+		}
+	}
 
-	*nprocessedp = nprocessed;
+	if (nprocessedp != NULL)
+		*nprocessedp = count;
 
-out:
 	EFSYS_KMEM_FREE(enp->en_esip, size, payload);
 
 	return (0);
-- 
2.47.3

