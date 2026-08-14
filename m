Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31947C5CFDB
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:55:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAEC740430;
	Fri, 14 Aug 2026 14:54:51 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id EB7314013F;
 Fri, 14 Aug 2026 14:54:48 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.78.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 0F92AE0B4D;
 Fri, 14 Aug 2026 16:54:47 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 0F92AE0B4D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786712088;
 bh=+DnakMyPuK91KpTROk1l/FIoFLRB294NU+iLUiVJuR0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rT7Ua4nVaziqVINIY90/7zYiPEq/+1Kaeq81kjQrnIRaLh90ThLyvasH0RQeIj5lZ
 DJxyq8OwfJ7mZbeEkM8Hnyb38YaMTcwe36HpLZ6sLofFqV8QiphCD5XlydNutiNgWO
 SH6xo0hdB4JkzaKRLXizBm9fww69QI1dSmukO+KkJohVl0ea4n0WhheahFTL1wivZC
 DTtRVO9Nlb1/OdRMq/mJV2t+Vj+5I31o7JadSfJO77uMe08dCscQSfy29SmimeWT9Q
 GVqAWLaKqjDUCznG3uhQjur8tD/QnBwmtakiNHpPyZKdGOAt5IloWWDKjEq51TQBf4
 qTfhsXpKYeqTw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH v3 02/14] common/sfc_efx/base: reduce stack in get addr
 regions MCDI
Date: Fri, 14 Aug 2026 16:54:26 +0400
Message-ID: <20260814125438.13283-3-ivan.malov@arknetworks.am>
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
 drivers/common/sfc_efx/base/efx_mcdi.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_mcdi.c b/drivers/common/sfc_efx/base/efx_mcdi.c
index 670b0d5cda..4be736dcb9 100644
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
 
+	size = EFX_MCDI_BUF_SIZE(MC_CMD_GET_DESC_ADDR_REGIONS_IN_LEN,
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

