Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18CEE92FE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 21:36:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A473D4066D;
	Mon, 29 Dec 2025 22:35:44 +0100 (CET)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 1EA8A402B3;
 Mon, 29 Dec 2025 22:35:40 +0100 (CET)
Received: from localhost.localdomain (unknown [78.109.70.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 71F75E15BA;
 Tue, 30 Dec 2025 01:35:39 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 71F75E15BA
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1767044140;
 bh=BpTnWdFOpLFU5Ux+BxFz5YXdaupQygiGmgvz//m4dDg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iMPF4u+D5p3txy2FIACra9Tf85t21JJrYhDZyRmkcEOBVKU81KpDLp3QFl24z2CC1
 v6LyobrD9CvuzN8DPiDt8nbfeNaVvJjHzBwvwb0NE5WnGnzN7ZkG544jSKeSLjyC0V
 1bTd5010qggzhBz/JA3rnqfQjf/IK+wlu26zChVqHobBR5XhBb5/ln2JEHKGdNxHE6
 cchLFNpmslioFyNeR301w2VHe9we0m9NA+JdBK7023JbUIW/ldNeAF9wsKkZglswyQ
 LcrYix07Wk3sACKibJgTBjpdXLpL1MekHONn1GEcPKSdn/9jF1O7MQ0YcgeIH4ln8d
 EZ+QyO3mfmhYA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 stable@dpdk.org
Subject: [PATCH 6/9] net/sfc: avoid speed reset when setting FEC in started
 state
Date: Tue, 30 Dec 2025 01:35:24 +0400
Message-ID: <20251229213527.37907-7-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251229213527.37907-1-ivan.malov@arknetworks.am>
References: <20251229213527.37907-1-ivan.malov@arknetworks.am>
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

The 'current' mask of PHY capabilities in libefx indicates autonegotiation
regardless of whether the last invocation of 'efx_phy_adv_cap_set' enabled
or disabled it. The port start code is aware of this and pays attention to
preserve the existing setting when making 'efx_phy_adv_cap_set' invocation.

FEC set method uses the 'current' mask as a base for the new value and may
thus reset fixed speed to autonegotiated. Fix it to keep the speed setting.

Fixes: 5efa8fc1cfc0 ("net/sfc: support FEC feature")
Cc: stable@dpdk.org

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/net/sfc/sfc_ethdev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/sfc/sfc_ethdev.c b/drivers/net/sfc/sfc_ethdev.c
index 99141bdda5..6d2349a999 100644
--- a/drivers/net/sfc/sfc_ethdev.c
+++ b/drivers/net/sfc/sfc_ethdev.c
@@ -2857,8 +2857,13 @@ sfc_fec_set(struct rte_eth_dev *dev, uint32_t fec_capa)
 	if (sa->state == SFC_ETHDEV_STARTED) {
 		efx_phy_adv_cap_get(sa->nic, EFX_PHY_CAP_CURRENT,
 				    &updated_caps);
-		updated_caps = updated_caps & ~EFX_PHY_CAP_FEC_MASK;
-		updated_caps |= efx_fec_caps;
+
+		/* Keep pause capabilities set by efx_mac_fcntl_set(). */
+		updated_caps = (updated_caps & EFX_PHY_CAP_PAUSE_MASK) |
+			       (port->phy_adv_cap & ~EFX_PHY_CAP_PAUSE_MASK);
+
+		updated_caps = (updated_caps & ~EFX_PHY_CAP_FEC_MASK) |
+			       (efx_fec_caps & EFX_PHY_CAP_FEC_MASK);
 
 		rc = efx_phy_adv_cap_set(sa->nic, updated_caps);
 		if (rc != 0)
-- 
2.47.3

