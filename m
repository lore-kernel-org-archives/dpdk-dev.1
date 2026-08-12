Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC04C5B572
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 17:08:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC29E40A8A;
	Wed, 12 Aug 2026 19:08:46 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 9FF1440264;
 Wed, 12 Aug 2026 19:08:44 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id A6764E0BA6;
 Wed, 12 Aug 2026 21:08:43 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am A6764E0BA6
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786554524;
 bh=lBBmUCedjEVlrvRMYBPzNpu9y+GIY3b7wFHSvWjd2p0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DSa6NMkvRrtai8WWHl2sAJFAt0MBkamk29vEEqyxf/eKTqsmOUf9v+NcV6g8ggtGI
 Y1rIjYWWF5F6Yje8e8F1yc6f6dTUu/x6n+JIrhFOzXUhZ14V/3LAjP4Gq4Ad/El9Kc
 S0jXs8gLrK2EhsB4GMP0RbtE7HYNlaN0Bjh0vHYY3jWzzRf88zmfkkKaY5uxkYvLpr
 fHngIUOQMIOONFrnGau6WQGoUJP5hpEY5/WQh7izrJ1dW2QfytB4O+cyusGinMsDb+
 KU5QdpZbquotU5QZE97zia6XW655qjimO5royQHByJCFYHBTQVbSaIs+LZVu/H68Qb
 z4kffV5dprRBQ==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH v2 01/14] common/sfc_efx/base: reduce stack in RSS context
 table write
Date: Wed, 12 Aug 2026 21:08:21 +0400
Message-ID: <20260812170834.8443-2-ivan.malov@arknetworks.am>
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

Code analysis reports an error for excessive stack consumption
(over 1KB). Use a heap allocated payload buffer instead.

Fixes: e7ea5f304f0f ("common/sfc_efx/base: support selecting RSS table entry count")
Cc: stable@dpdk.org

Signed-off-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
---
 drivers/common/sfc_efx/base/ef10_rx.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/common/sfc_efx/base/ef10_rx.c b/drivers/common/sfc_efx/base/ef10_rx.c
index afc9cf025f..ed9943dc2c 100644
--- a/drivers/common/sfc_efx/base/ef10_rx.c
+++ b/drivers/common/sfc_efx/base/ef10_rx.c
@@ -394,11 +394,10 @@ efx_mcdi_rss_context_write_table(
 	__in			unsigned int nentries)
 {
 	const efx_nic_cfg_t *encp = efx_nic_cfg_get(enp);
+	uint8_t *payload = NULL;
 	efx_mcdi_req_t req;
-	EFX_MCDI_DECLARE_BUF(payload,
-	     MC_CMD_RSS_CONTEXT_WRITE_TABLE_IN_LENMAX_MCDI2,
-	     MC_CMD_RSS_CONTEXT_WRITE_TABLE_OUT_LEN);
 	unsigned int i;
+	size_t size;
 	int rc;
 
 	if (nentries >
@@ -413,6 +412,15 @@ efx_mcdi_rss_context_write_table(
 		goto fail2;
 	}
 
+	size = MAX(MC_CMD_RSS_CONTEXT_WRITE_TABLE_IN_LEN(nentries),
+	    MC_CMD_RSS_CONTEXT_WRITE_TABLE_OUT_LEN);
+
+	EFSYS_KMEM_ALLOC(enp->en_esip, size, payload);
+	if (payload == NULL) {
+		rc = ENOMEM;
+		goto fail3;
+	}
+
 	req.emr_cmd = MC_CMD_RSS_CONTEXT_WRITE_TABLE;
 	req.emr_in_buf = payload;
 	req.emr_in_length = MC_CMD_RSS_CONTEXT_WRITE_TABLE_IN_LEN(nentries);
@@ -425,7 +433,7 @@ efx_mcdi_rss_context_write_table(
 	for (i = 0; i < nentries; ++i) {
 		if (table[i] >= encp->enc_rx_scale_indirection_max_nqueues) {
 			rc = EINVAL;
-			goto fail3;
+			goto fail4;
 		}
 
 		MCDI_IN_POPULATE_INDEXED_DWORD_2(req,
@@ -437,13 +445,17 @@ efx_mcdi_rss_context_write_table(
 	efx_mcdi_execute(enp, &req);
 	if (req.emr_rc != 0) {
 		rc = req.emr_rc;
-		goto fail4;
+		goto fail5;
 	}
 
+	EFSYS_KMEM_FREE(enp->en_esip, size, payload);
 	return (0);
 
+fail5:
+	EFSYS_PROBE(fail5);
 fail4:
 	EFSYS_PROBE(fail4);
+	EFSYS_KMEM_FREE(enp->en_esip, size, payload);
 fail3:
 	EFSYS_PROBE(fail3);
 fail2:
-- 
2.47.3

