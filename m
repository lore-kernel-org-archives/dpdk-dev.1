Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4863C83F1B
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Jul 2025 14:44:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6A7740A77;
	Fri, 11 Jul 2025 16:44:00 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 26CD040689
 for <dev@dpdk.org>; Fri, 11 Jul 2025 16:43:59 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.90])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 61265E0C9A;
 Fri, 11 Jul 2025 18:43:58 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 61265E0C9A
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1752245038;
 bh=FQtuaHdklISlqZZUvnlnCLijBhstK2m4YduLtyMLqKE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VJKTdAMQluSbz/V3BTotF/3LGkxTvsMiCNfCXWySNCcq9WJAX6MeQlEsmqjrga62u
 6msUc+yZAajsKDmEZvXuNm5voqxKqXJ8YJewGDoFBU/hZimbU7uLs3VAqpgfThHVoW
 pQ+yLYhopTcmpUTekolJ4q179Bxw9jCG1w8X3Ndbi3ObrZOH3n145WwJPXxKRT3tbA
 vF3kwcmaiHLamm8WhpKNd7+pe7VyRxHJBWC8ViFAkD4Noe1f+mvUT5C6h9BQu0X0HF
 20LGKmlTuaqZKdb8Kd3+oQ1ixpEFhTzEvTGoTwNBSI7k69Fp+Pz/cExmPWUEJv5X+4
 e7OhtnnuUtFew==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 1/3] common/sfc_efx/base: fix compiler warnings in statistic
 code
Date: Fri, 11 Jul 2025 18:43:47 +0400
Message-Id: <20250711144349.9236-2-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250711144349.9236-1-ivan.malov@arknetworks.am>
References: <20250711144349.9236-1-ivan.malov@arknetworks.am>
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

Fixes: f2f77453cb9f ("common/sfc_efx/base: fill in software LUT for MAC statistics")

Suggested-by: Andy Moreton <andy.moreton@amd.com>
Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/base/efx_np.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index a19c986691..798fcce26c 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -750,7 +750,7 @@ efx_np_stat_describe(
 	return;
 
 found:
-	if (sw_id >= lut_nentries) {
+	if ((unsigned int)sw_id >= lut_nentries) {
 		/*
 		 * Static mapping size and the size of lookup
 		 * table are out-of-sync. Should never happen.
@@ -782,7 +782,6 @@ efx_np_stats_describe(
 	EFX_MCDI_DECLARE_BUF(payload,
 	    MC_CMD_MAC_STATISTICS_DESCRIPTOR_IN_LEN,
 	    MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_LENMAX_MCDI2);
-	efx_port_t *epp = &(enp->en_port);
 	uint32_t nprocessed;
 	efx_mcdi_req_t req;
 	uint8_t *entries;
-- 
2.39.5

