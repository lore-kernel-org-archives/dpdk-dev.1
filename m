Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B86E92FE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 21:36:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05B1A4068E;
	Mon, 29 Dec 2025 22:35:47 +0100 (CET)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 9E29240653;
 Mon, 29 Dec 2025 22:35:41 +0100 (CET)
Received: from localhost.localdomain (unknown [78.109.70.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id E6090E1B6F;
 Tue, 30 Dec 2025 01:35:40 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am E6090E1B6F
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1767044141;
 bh=oqi89DUfSMc5VRkfkFSNb12d3v1dYKhPsaW7N711ALE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UuesJOzAonrxRUFgPqSZgy6eB+gRRwhhorT9HQvoH5gMcRJ1n+ZRiX3CRSvJXzu7H
 Een6Ocjtu16tRasw1AuluykOOwpo/5friaZwVN7mW5WBwGnJMz86abuL3PIQlBmHj/
 dKgvTYZ2DifWk/DDD4dHJ03yWOIu5UI4k84tstDNR4i8hzRDHMc6zNM9kkMa8tXTTU
 W+7bRPlH51cT5U/OjJaLf5bb2WX4qNxtCnzDUf/I0+4KC4prAjIFtAdQP62NSOotM9
 8abPB+uo1MIVyopLp9N1+qip6/z72OZ3Gt6t6134VuQN+f7U0Lwlvx5rY+jH85ppfT
 ZNA8FeBVttFkg==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 stable@dpdk.org
Subject: [PATCH 8/9] net/sfc: drop AUTO from FEC capabilities and fix the
 comment
Date: Tue, 30 Dec 2025 01:35:26 +0400
Message-ID: <20251229213527.37907-9-ivan.malov@arknetworks.am>
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

AUTO is not a capability. It is rather a special value. Do not indicate it.
Also, improve the comment to explain this change and the overall principle.

Fixes: b526903f308e ("net/sfc: offer support for 200G link ability on new adaptors")
Fixes: 5efa8fc1cfc0 ("net/sfc: support FEC feature")
Cc: stable@dpdk.org

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/net/sfc/sfc_ethdev.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/net/sfc/sfc_ethdev.c b/drivers/net/sfc/sfc_ethdev.c
index fc759f52fe..7c2abaab6b 100644
--- a/drivers/net/sfc/sfc_ethdev.c
+++ b/drivers/net/sfc/sfc_ethdev.c
@@ -2517,18 +2517,20 @@ sfc_fec_get_capa_speed_to_fec(uint32_t supported_caps,
 		rs = true;
 
 	/*
-	 * NOFEC and AUTO FEC modes are always supported.
-	 * FW does not provide information about the supported
-	 * FEC modes per the link speed.
-	 * Supported FEC depends on supported link speeds and
-	 * supported FEC modes by a device.
+	 * NOFEC can always be requested, but if the link technology for the
+	 * intended speed mandates FEC, doing so will not bring the link up.
+	 *
+	 * FW cannot report supported FEC modes per speed/link technology,
+	 * so use best-effort approximation to fill in the capabilities.
+	 *
+	 * Do not indicate 'AUTO'. This bit is reserved for user
+	 * input. It has nothing to do with capability reporting.
 	 */
 	if (supported_caps & (1u << EFX_PHY_CAP_10000FDX)) {
 		if (speed_fec_capa != NULL) {
 			speed_fec_capa[num].speed = RTE_ETH_SPEED_NUM_10G;
 			speed_fec_capa[num].capa =
-				RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC) |
-				RTE_ETH_FEC_MODE_CAPA_MASK(AUTO);
+				RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC);
 			if (baser) {
 				speed_fec_capa[num].capa |=
 					RTE_ETH_FEC_MODE_CAPA_MASK(BASER);
@@ -2540,8 +2542,7 @@ sfc_fec_get_capa_speed_to_fec(uint32_t supported_caps,
 		if (speed_fec_capa != NULL) {
 			speed_fec_capa[num].speed = RTE_ETH_SPEED_NUM_25G;
 			speed_fec_capa[num].capa =
-				RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC) |
-				RTE_ETH_FEC_MODE_CAPA_MASK(AUTO);
+				RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC);
 			if (baser) {
 				speed_fec_capa[num].capa |=
 					RTE_ETH_FEC_MODE_CAPA_MASK(BASER);
@@ -2557,8 +2558,7 @@ sfc_fec_get_capa_speed_to_fec(uint32_t supported_caps,
 		if (speed_fec_capa != NULL) {
 			speed_fec_capa[num].speed = RTE_ETH_SPEED_NUM_40G;
 			speed_fec_capa[num].capa =
-				RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC) |
-				RTE_ETH_FEC_MODE_CAPA_MASK(AUTO);
+				RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC);
 			if (baser) {
 				speed_fec_capa[num].capa |=
 					RTE_ETH_FEC_MODE_CAPA_MASK(BASER);
@@ -2570,8 +2570,7 @@ sfc_fec_get_capa_speed_to_fec(uint32_t supported_caps,
 		if (speed_fec_capa != NULL) {
 			speed_fec_capa[num].speed = RTE_ETH_SPEED_NUM_50G;
 			speed_fec_capa[num].capa =
-				RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC) |
-				RTE_ETH_FEC_MODE_CAPA_MASK(AUTO);
+				RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC);
 			if (baser) {
 				speed_fec_capa[num].capa |=
 					RTE_ETH_FEC_MODE_CAPA_MASK(BASER);
@@ -2587,8 +2586,7 @@ sfc_fec_get_capa_speed_to_fec(uint32_t supported_caps,
 		if (speed_fec_capa != NULL) {
 			speed_fec_capa[num].speed = RTE_ETH_SPEED_NUM_100G;
 			speed_fec_capa[num].capa =
-				RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC) |
-				RTE_ETH_FEC_MODE_CAPA_MASK(AUTO);
+				RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC);
 			if (rs) {
 				speed_fec_capa[num].capa |=
 					RTE_ETH_FEC_MODE_CAPA_MASK(RS);
@@ -2600,8 +2598,7 @@ sfc_fec_get_capa_speed_to_fec(uint32_t supported_caps,
 		if (speed_fec_capa != NULL) {
 			speed_fec_capa[num].speed = RTE_ETH_SPEED_NUM_200G;
 			speed_fec_capa[num].capa =
-				RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC) |
-				RTE_ETH_FEC_MODE_CAPA_MASK(AUTO);
+				RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC);
 			if (rs) {
 				speed_fec_capa[num].capa |=
 					RTE_ETH_FEC_MODE_CAPA_MASK(RS);
-- 
2.47.3

