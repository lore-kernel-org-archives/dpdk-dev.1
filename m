Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD443C5B572
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 17:48:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BD484270A;
	Tue, 11 Aug 2026 19:48:35 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 85DAD4021E;
 Tue, 11 Aug 2026 19:48:31 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id A1537E0D23;
 Tue, 11 Aug 2026 21:48:30 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am A1537E0D23
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786470511;
 bh=lF4hXssdnhiwjhKTe93PwR2+ix6fNl7oMhUy9K1MQio=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=M+JcLOzmrlvToegcMNM2pA1EV5TYe1LuKD7uk9NmfptgeGOwhnO3VFY80XQqp8RDZ
 5F/rLcX3oZ2OabY6bsOV/wGCHqVkIB3UF494uBka1BTxyPOWcaAzgvpANgN4znM+9X
 2x0OCWnirEyn/eauKcT1dFwM0NleyG/11p+ZRt+OWaoqXju7eUutz+qgJE7UOhOiJJ
 h05/DfQBij0HAW1sZ+KLE4tzEWxYEw4LQ4DA9p+tV1Wknt6RfMb3jpHdm2xMX5iusM
 kLIIIglV2Z1VomGbPlTO/jVvb5QqQBEuv7LWl8Pl+6fK06PQHuJvLrnmkYL6FN6H7f
 xO4c73U6O/MMA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH 02/14] common/sfc_efx/base: reduce stack in get addr regions
 MCDI
Date: Tue, 11 Aug 2026 21:48:09 +0400
Message-ID: <20260811174821.8930-3-ivan.malov@arknetworks.am>
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

Fixes: 60fb370c7bc9 ("common/sfc_efx/base: support NIC DMA memory regions API")
Cc: stable@dpdk.org

Signed-off-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
---
 drivers/common/sfc_efx/base/efx_mcdi.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_mcdi.c b/drivers/common/sfc_efx/base/efx_mcdi.c
index 670b0d5cda..7dc58992be 100644
--- a/drivers/common/sfc_efx/base/efx_mcdi.c
+++ b/drivers/common/sfc_efx/base/efx_mcdi.c
@@ -3439,15 +3439,24 @@ efx_mcdi_get_nic_addr_regions(
 	__in		efx_nic_t *enp,
 	__out		efx_nic_dma_region_info_t *endrip)
 {
-	EFX_MCDI_DECLARE_BUF(payload, MC_CMD_GET_DESC_ADDR_REGIONS_IN_LEN,
-		MC_CMD_GET_DESC_ADDR_REGIONS_OUT_LENMAX_MCDI2);
+	uint8_t *payload = NULL;
 	efx_xword_t *regions;
 	efx_mcdi_req_t req;
+	size_t size;
 	efx_rc_t rc;
 	size_t alloc_size;
 	unsigned int nregions;
 	unsigned int i;
 
+	size = MAX(MC_CMD_GET_DESC_ADDR_REGIONS_IN_LEN,
+	    MC_CMD_GET_DESC_ADDR_REGIONS_OUT_LENMAX_MCDI2);
+
+	EFSYS_KMEM_ALLOC(enp->en_esip, size, payload);
+	if (payload == NULL) {
+		rc = ENOMEM;
+		goto fail1;
+	}
+
 	req.emr_cmd = MC_CMD_GET_DESC_ADDR_REGIONS;
 	req.emr_in_buf = payload;
 	req.emr_in_length = MC_CMD_GET_DESC_ADDR_REGIONS_IN_LEN;
@@ -3458,13 +3467,13 @@ efx_mcdi_get_nic_addr_regions(
 
 	if (req.emr_rc != 0) {
 		rc = req.emr_rc;
-		goto fail1;
+		goto fail2;
 	}
 
 	if (req.emr_out_length_used <
 	    MC_CMD_GET_DESC_ADDR_REGIONS_OUT_LENMIN) {
 		rc = EMSGSIZE;
-		goto fail2;
+		goto fail3;
 	}
 
 	nregions = MC_CMD_GET_DESC_ADDR_REGIONS_OUT_REGIONS_NUM(
@@ -3477,7 +3486,7 @@ efx_mcdi_get_nic_addr_regions(
 	alloc_size = nregions * sizeof(endrip->endri_regions[0]);
 	if (alloc_size / sizeof (endrip->endri_regions[0]) != nregions) {
 		rc = ENOMEM;
-		goto fail3;
+		goto fail4;
 	}
 
 	EFSYS_KMEM_ALLOC(enp->en_esip,
@@ -3485,7 +3494,7 @@ efx_mcdi_get_nic_addr_regions(
 	    endrip->endri_regions);
 	if (endrip->endri_regions == NULL) {
 		rc = ENOMEM;
-		goto fail4;
+		goto fail5;
 	}
 
 	endrip->endri_count = nregions;
@@ -3517,14 +3526,19 @@ efx_mcdi_get_nic_addr_regions(
 		        DESC_ADDR_REGION_TRGT_ADDR_ALIGN_LOG2);
 	}
 
+	EFSYS_KMEM_FREE(enp->en_esip, size, payload);
+
 	return (0);
 
+fail5:
+	EFSYS_PROBE(fail5);
 fail4:
 	EFSYS_PROBE(fail4);
 fail3:
 	EFSYS_PROBE(fail3);
 fail2:
 	EFSYS_PROBE(fail2);
+	EFSYS_KMEM_FREE(enp->en_esip, size, payload);
 fail1:
 	EFSYS_PROBE1(fail1, efx_rc_t, rc);
 
-- 
2.47.3

