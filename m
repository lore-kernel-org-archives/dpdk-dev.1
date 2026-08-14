Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CECEC5CFDB
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:55:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5EED40664;
	Fri, 14 Aug 2026 14:54:52 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 92B21402D4;
 Fri, 14 Aug 2026 14:54:50 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.78.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id E3F5FE0F0C;
 Fri, 14 Aug 2026 16:54:48 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am E3F5FE0F0C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786712089;
 bh=b7eO4qX2M3e6r7NmSdoevvgl0x4OGt8TIrif8PrT1R0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=q59d86y60aui1vbWtEa8aNZNUNd1/2TRnJVQEH9NgG7zHtcu1cXZ9xuMff1U69Sno
 WNL/fp2dpHydy8KLvJx3d8TIDCF8nPvzqmgDcYr7WoABl10qaLVAXzjOgxDrFWXFtx
 vZvxSIgp+bSviIj/rGjxnrnsFU1+CEbcJ97vJM9cjR2mvWezUeuWPB+kU84jPAbuQr
 8hQV39O9fxp9FilBvGVeFPQtrN2iZmi5kFR8X8bs2VEek6dj5nrok3A5OqavAXCh2j
 hfKGJYrQAxVucmXLo5VPYbdY8JJPu+c+JcMP7dadCU3m3fx+gP4ZZcqKci4jCjCErT
 pmAlddoVNek3g==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH v3 03/14] common/sfc_efx/base: reduce stack in set addr
 regions MCDI
Date: Fri, 14 Aug 2026 16:54:27 +0400
Message-ID: <20260814125438.13283-4-ivan.malov@arknetworks.am>
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

Code analysis reports an error for excessive stack consumption
(over 1KB). Use a heap allocated payload buffer instead.

Fixes: 60fb370c7bc9 ("common/sfc_efx/base: support NIC DMA memory regions API")
Cc: stable@dpdk.org

Signed-off-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
---
 drivers/common/sfc_efx/base/efx_mcdi.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_mcdi.c b/drivers/common/sfc_efx/base/efx_mcdi.c
index 4be736dcb9..04f2c99c0b 100644
--- a/drivers/common/sfc_efx/base/efx_mcdi.c
+++ b/drivers/common/sfc_efx/base/efx_mcdi.c
@@ -3550,12 +3550,11 @@ efx_mcdi_set_nic_addr_regions(
 	__in		efx_nic_t *enp,
 	__in		const efx_nic_dma_region_info_t *endrip)
 {
-	EFX_MCDI_DECLARE_BUF(payload,
-		MC_CMD_SET_DESC_ADDR_REGIONS_IN_LENMAX_MCDI2,
-		MC_CMD_SET_DESC_ADDR_REGIONS_OUT_LEN);
 	efx_qword_t *trgt_addr_base;
+	uint8_t *payload = NULL;
 	efx_mcdi_req_t req;
 	unsigned int i;
+	size_t size;
 	efx_rc_t rc;
 
 	if (endrip->endri_count >
@@ -3564,6 +3563,16 @@ efx_mcdi_set_nic_addr_regions(
 		goto fail1;
 	}
 
+	size = EFX_MCDI_BUF_SIZE(
+	    MC_CMD_SET_DESC_ADDR_REGIONS_IN_LEN(endrip->endri_count),
+	    MC_CMD_SET_DESC_ADDR_REGIONS_OUT_LEN);
+
+	EFSYS_KMEM_ALLOC(enp->en_esip, size, payload);
+	if (payload == NULL) {
+		rc = ENOMEM;
+		goto fail2;
+	}
+
 	req.emr_cmd = MC_CMD_SET_DESC_ADDR_REGIONS;
 	req.emr_in_buf = payload;
 	req.emr_in_length =
@@ -3598,11 +3607,16 @@ efx_mcdi_set_nic_addr_regions(
 
 	if (req.emr_rc != 0) {
 		rc = req.emr_rc;
-		goto fail2;
+		goto fail3;
 	}
 
+	EFSYS_KMEM_FREE(enp->en_esip, size, payload);
+
 	return (0);
 
+fail3:
+	EFSYS_PROBE(fail3);
+	EFSYS_KMEM_FREE(enp->en_esip, size, payload);
 fail2:
 	EFSYS_PROBE(fail2);
 fail1:
-- 
2.47.3

