Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE82C5B572
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 17:48:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1CE24279F;
	Tue, 11 Aug 2026 19:48:37 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 16D5C40E18;
 Tue, 11 Aug 2026 19:48:33 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 52D62E0F03;
 Tue, 11 Aug 2026 21:48:32 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 52D62E0F03
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786470512;
 bh=CoRkKPdzIsmiPqS+CAQMyOH4WCIiR+tzEkWwyPmSiow=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PdxLz1HCacD3wqz67hDUpQUgxe1OLOvD+BDU/kLoanCk54280ZmIh/HHgbSlKmvkz
 KTtdjc5nTdMp54JxtFmb24DgfJfCZrTz0NW41S3ZBMH+/Rk0pkUAFNwdsooT9JAnRt
 JsBxXbRejBrDSv+Ibmq4F649fevAmgGtygyQUZLqt07hTQTtWeguBGnjwCmS48q7ck
 riNEaLAiKelF3RB+NgiivB+tfXMYX5FFYGV+4NpzxiKqu7QFkYpySFlWP1Nlfo8Mbg
 dGgRJXdlRRpOEcEZ+C4SaS0g40yxnR6LUKWxaqk70w/DkmP1YGY6nlG7JN1/xmC5aF
 FSS9obWKKe5Kg==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH 04/14] common/sfc_efx/base: reduce stack in netport stat
 describe
Date: Tue, 11 Aug 2026 21:48:11 +0400
Message-ID: <20260811174821.8930-5-ivan.malov@arknetworks.am>
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

Code analysis reports an error for excessive stack consumption
(over 1KB). Use a heap allocated payload buffer instead.

Fixes: f2f77453cb9f ("common/sfc_efx/base: fill in software LUT for MAC statistics")
Cc: stable@dpdk.org

Signed-off-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
---
 drivers/common/sfc_efx/base/efx_np.c | 37 +++++++++++++++++++---------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 45f3cd07ed..5044eabdd3 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -778,22 +778,30 @@ efx_np_stats_describe(
 	__out_opt			uint32_t *nprocessedp,
 	__out_opt			uint32_t *nstats_maxp)
 {
-	EFX_MCDI_DECLARE_BUF(payload,
-	    MC_CMD_MAC_STATISTICS_DESCRIPTOR_IN_LEN,
-	    MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_LENMAX_MCDI2);
+	uint8_t *payload = NULL;
 	uint32_t nprocessed;
 	efx_mcdi_req_t req;
 	uint8_t *entries;
 	uint32_t stride;
 	unsigned int i;
 	size_t out_sz;
+	size_t size;
 	efx_rc_t rc;
 
-	req.emr_out_length = MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_LENMAX_MCDI2;
-	req.emr_in_length = MC_CMD_MAC_STATISTICS_DESCRIPTOR_IN_LEN;
+	size = MAX(MC_CMD_MAC_STATISTICS_DESCRIPTOR_IN_LEN,
+	    MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_LENMAX_MCDI2);
+
+	EFSYS_KMEM_ALLOC(enp->en_esip, size, payload);
+	if (payload == NULL) {
+		rc = ENOMEM;
+		goto fail1;
+	}
+
 	req.emr_cmd = MC_CMD_MAC_STATISTICS_DESCRIPTOR;
-	req.emr_out_buf = payload;
 	req.emr_in_buf = payload;
+	req.emr_in_length = MC_CMD_MAC_STATISTICS_DESCRIPTOR_IN_LEN;
+	req.emr_out_buf = payload;
+	req.emr_out_length = MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_LENMAX_MCDI2;
 
 	MCDI_IN_SET_DWORD(req, MAC_STATISTICS_DESCRIPTOR_IN_PORT_HANDLE, nph);
 	MCDI_IN_SET_DWORD(req, MAC_STATISTICS_DESCRIPTOR_IN_OFFSET, req_ofst);
@@ -802,13 +810,13 @@ efx_np_stats_describe(
 
 	if (req.emr_rc != 0) {
 		rc = req.emr_rc;
-		goto fail1;
+		goto fail2;
 	}
 
 	out_sz = req.emr_out_length_used;
 	if (out_sz < MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_LENMIN) {
 		rc = EMSGSIZE;
-		goto fail2;
+		goto fail3;
 	}
 
 	if (nstats_maxp != NULL) {
@@ -818,13 +826,13 @@ efx_np_stats_describe(
 	}
 
 	if (lut_nentries == 0 || lut == NULL || nprocessedp == NULL)
-		return (0);
+		goto out;
 
 	stride = MCDI_OUT_DWORD(req, MAC_STATISTICS_DESCRIPTOR_OUT_ENTRY_SIZE);
 	nprocessed = MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_ENTRIES_NUM(out_sz);
 	if (nprocessed == 0) {
 		rc = EMSGSIZE;
-		goto fail3;
+		goto fail4;
 	}
 
 	entries = MCDI_OUT2(req, uint8_t,
@@ -834,14 +842,19 @@ efx_np_stats_describe(
 		efx_np_stat_describe(entries + i * stride, lut_nentries, lut);
 
 	*nprocessedp = nprocessed;
+
+out:
+	EFSYS_KMEM_FREE(enp->en_esip, size, payload);
+
 	return (0);
 
+fail4:
+	EFSYS_PROBE(fail4);
 fail3:
 	EFSYS_PROBE(fail3);
-
 fail2:
 	EFSYS_PROBE(fail2);
-
+	EFSYS_KMEM_FREE(enp->en_esip, size, payload);
 fail1:
 	EFSYS_PROBE1(fail1, efx_rc_t, rc);
 	return (rc);
-- 
2.47.3

