Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B531C5B56A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 17:11:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D815F427DC;
	Wed, 12 Aug 2026 19:11:11 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 3ABAA427C5
 for <dev@dpdk.org>; Wed, 12 Aug 2026 19:11:09 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 86513E0872;
 Wed, 12 Aug 2026 21:11:08 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 86513E0872
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786554669;
 bh=qabrK9tHHYhOL06lsyO7JQgMwJY+phnRLSEYldI7MvE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kO3OI29hTaxKS5SwgvnNPhKOPgCsNtGIMp89nm7KxR1LAHv7xDmlToAbLiVcHEI95
 BsAkYDOBN5yF5gtgAVdCyniwIqzf3kr7s6Jby2W71vOpVuktLDX2sF+ZesgRviKavh
 0fUPgAIuYnIlRzd2oIGHymvGTqt7Ti1BkZjHcCLBDY5k3NrJ4wJUEJtrC9rkrkBZmi
 8t6t4XW8dV1A+nbyZoNhKQJ6huJCnKym2mO5uEwLk/8KeFdYsRq9vsXpfEW0T0laaD
 11+2F03vu3BjuxWabaYcGo/8Nd1yH9Zf2Mcrm+LffTYikSuj3SnbmUt+s/Wxec3RwK
 NPoZUVmcCyegw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 5/6] common/sfc_efx/base: deny periodic MAC stats delivery
 to VFs
Date: Wed, 12 Aug 2026 21:11:02 +0400
Message-ID: <20260812171103.8553-6-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260812171103.8553-1-ivan.malov@arknetworks.am>
References: <20260811175025.9019-1-ivan.malov@arknetworks.am>
 <20260812171103.8553-1-ivan.malov@arknetworks.am>
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

Currently, requesting periodic DMA results in an EACCES error being
returned, but the DPDK driver expects ENOTSUP to handle the
situation gracefully. Implement proper error indication.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/base/efx_np.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 9dbad2e9d1..a617c05dd2 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -1727,16 +1727,32 @@ efx_np_mac_stats(
 	efx_mcdi_execute(enp, &req);
 
 	if (req.emr_rc != 0) {
+		const efx_nic_cfg_t *encp = &enp->en_nic_cfg;
+
+		if (req.emr_rc == EACCES && (enable | events) &&
+		    EFX_PCI_FUNCTION_IS_VF(encp)) {
+			/*
+			 * VFs cannot request periodic DMAing of statistics.
+			 * Indicate 'ENOTSUP' for the DPDK driver to handle
+			 * this gracefully and stick with one-time uploads.
+			 */
+			rc = ENOTSUP;
+			goto fail3;
+		}
+
 		/* EF10: Expect ENOENT if no DMA queues are initialised */
 		if ((req.emr_rc != ENOENT) ||
 		    (enp->en_rx_qcount + enp->en_tx_qcount != 0)) {
 			rc = req.emr_rc;
-			goto fail3;
+			goto fail4;
 		}
 	}
 
 	return (0);
 
+fail4:
+	EFSYS_PROBE(fail4);
+
 fail3:
 	EFSYS_PROBE(fail3);
 
-- 
2.47.3

