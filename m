Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437CDC88E77
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 19:23:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2076142E95;
	Tue, 15 Sep 2026 21:23:02 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 958CB42EA0
 for <dev@dpdk.org>; Tue, 15 Sep 2026 21:23:00 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39b5b07ec78so87558a91.3
 for <dev@dpdk.org>; Tue, 15 Sep 2026 12:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789500180;
 x=1790104980; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AS+UvN4C9E6f+3BcbpOhjjb8sBlClM+wm4oO2ZUSW+E=;
 b=IsJ18iPiRIIkuS+HBNDirpf94fSeDlYvbj5+L6/fYOFaCDz/019leodsh/0SumsQBW
 uKLd0pUhJ8Y0F0dzdt0+ukNYGyCkdEfCyI09v52bVkvMQ09YbWgfNNYCnITJZ68rJasZ
 rmyUFjQxumsY32rHlgZKm1U69WGZYtKC7nt7/Lf7dVSSh6vazRRcKXCIX5EAhZp6QGPl
 jHhXOVuEq6r6bTiKVSBkOvs3iSrlRmqtLROyKybuGvkbjwY00u173nSFqYdREg+KgrOs
 PV+/qUXeyseLvszOwIrIYUgr5E+MWmk2eODp9QKgELg9DmgxBjRIcL4esxEUWnVaURk4
 zjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789500180; x=1790104980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AS+UvN4C9E6f+3BcbpOhjjb8sBlClM+wm4oO2ZUSW+E=;
 b=rP+D5l5hvPbcohyU5rKTb8+OgpK0LCrtuYwTSlrLBLq3/PsYAQOWDMqXLN+6FmpPDE
 DZa8RPhPtJvJBspSdn41McNz94HOnoApYKbOtAaqpa07Ic36wvG8YaXS4Io3NCfeStM4
 0zkYTJ89y3cvBv3J0grS4W3DiZvPHt/7FQgp/8pfObq26FRMQv6OoSRy20Ssrefc2sN5
 bLmG5CMGp7GMCtIbXcY1SGNZNtbcrnFbNdvsStdwCGbwKY/Bce/EZOrhpHeXyV/IMKT/
 zk4HaD7vTHxyo7GFflm0ctOxKZvp2Ao15ZOSZf+yRAt/KZKsFukTiY0N4ZLA3CkF3rrV
 ndDQ==
X-Gm-Message-State: AFuF++lNuinw5D2IR0NrMXJhfxbzYmbWTQPl+l4ZjpkkJk0YO3hDBMee
 WQRI5BSEARyACk344q5O/Dd8x1vnbGqZ5J30aZeKxWh+2UgkZnte5xIqruJ8G7XHS+0BvX/xzVm
 2dGfOoZx3MA==
X-Gm-Gg: AYBFou02Yuo4S4PNvYG/OvPThnqHvcnzp0lUyxkbMzhLorUHQZvsNjJWf8hH17awIz/
 tuG/SCK/NTT0qiDbkqW2a4RXtPKnR8mPlGWQYh31LELZ4TLEvJI0nERxOB58P2sMz57qdQrYRoy
 6reeGa5DHyJ6FDlt4QGjlkrD0ZQEbdRpjzcLr15hzTLDfbxX8Y48lefeWvKiClE1SZO0EwWmh1e
 QU1VLhm+T/dOs39MHZilG5n/c8uwgUjfuvWtRQjfh1DpXH5dtVl3Sh9W7mg81QftOvkwuGuE5ld
 bIPcCtgyRKkdEKc/mlkm5LMjBUX+ORD6pq10HeENOWnWcoOrP8sSw7JfvR/2Po/x70GAbygB3bv
 yXQBYKxmKA+HN1C1jDdk+XIKpavo0M3hPobLUMvIcgWzXcO2dzD6Un0Ta8gi8i+DTWjH2hCNwIn
 JOl0JcILvYkqe6E1Pq29rfrBPs2/T3QXZwK6z1dib/v/VN0Z61uIam/cf6WeB+8HCgtLV0tuRbd
 Y4gct5HKP8hxEk5H5TnPxnz3LMbtHX4O6ctpg==
X-Received: by 2002:a17:90b:4fcf:b0:39d:ecb6:8d40 with SMTP id
 98e67ed59e1d1-39e10c83490mr4429664a91.4.1789500179638; 
 Tue, 15 Sep 2026 12:22:59 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bbfdd49sm217535a91.11.2026.09.15.12.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 12:22:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Selwin Sebastian <selwin.sebastian@amd.com>,
 Julien Aube <julien_dpdk@jaube.fr>
Subject: [PATCH 13/18] drivers/net: use secure random for RSS key
Date: Tue, 15 Sep 2026 12:21:11 -0700
Message-ID: <20260915192207.3926217-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915192207.3926217-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
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

Both drivers built the default RSS key a word at a time from rte_rand().
That generator is a fast non-cryptographic PRNG whose state is
recoverable from its output, so the resulting key is predictable.

Use rte_random_bytes() which takes randomness from the operating
system, and report the error to the caller.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/axgbe/axgbe_dev.c | 16 +++++++++++-----
 drivers/net/bnx2x/bnx2x.c     | 11 +++++++----
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/axgbe/axgbe_dev.c b/drivers/net/axgbe/axgbe_dev.c
index 482d3d8062..37856fddd9 100644
--- a/drivers/net/axgbe/axgbe_dev.c
+++ b/drivers/net/axgbe/axgbe_dev.c
@@ -3,6 +3,8 @@
  *   Copyright(c) 2018 Synopsys, Inc. All rights reserved.
  */
 
+#include <rte_random.h>
+
 #include "axgbe_ethdev.h"
 #include "axgbe_common.h"
 #include "axgbe_phy.h"
@@ -931,13 +933,15 @@ static void axgbe_rss_options(struct axgbe_port *pdata)
 static int axgbe_config_rss(struct axgbe_port *pdata)
 {
 	uint32_t i;
+	int ret;
 
 	if (pdata->rss_enable) {
 		/* Initialize RSS hash key and lookup table */
-		uint32_t *key = (uint32_t *)pdata->rss_key;
-
-		for (i = 0; i < sizeof(pdata->rss_key) / 4; i++)
-			*key++ = (uint32_t)rte_rand();
+		ret = rte_random_bytes(pdata->rss_key, sizeof(pdata->rss_key));
+		if (ret != 0) {
+			PMD_DRV_LOG_LINE(ERR, "Error generating RSS hash key");
+			return ret;
+		}
 		for (i = 0; i < AXGBE_RSS_MAX_TABLE_SIZE; i++)
 			AXGMAC_SET_BITS(pdata->rss_table[i], MAC_RSSDR, DMCH,
 					i % pdata->eth_dev->data->nb_rx_queues);
@@ -1393,7 +1397,9 @@ static int axgbe_init(struct axgbe_port *pdata)
 	axgbe_config_tx_pbl_val(pdata);
 	axgbe_config_rx_pbl_val(pdata);
 	axgbe_config_rx_buffer_size(pdata);
-	axgbe_config_rss(pdata);
+	ret = axgbe_config_rss(pdata);
+	if (ret)
+		return ret;
 	axgbe_config_tso_mode(pdata);
 	wrapper_tx_desc_init(pdata);
 	ret = wrapper_rx_desc_init(pdata);
diff --git a/drivers/net/bnx2x/bnx2x.c b/drivers/net/bnx2x/bnx2x.c
index 8790c858d5..97ee95a1be 100644
--- a/drivers/net/bnx2x/bnx2x.c
+++ b/drivers/net/bnx2x/bnx2x.c
@@ -28,6 +28,7 @@
 #include <zlib.h>
 
 #include <rte_bitops.h>
+#include <rte_random.h>
 #include <rte_string_fns.h>
 
 #include "eal_firmware.h"
@@ -6643,7 +6644,7 @@ bnx2x_config_rss_pf(struct bnx2x_softc *sc, struct ecore_rss_config_obj *rss_obj
 		  uint8_t config_hash)
 {
 	struct ecore_config_rss_params params = { NULL };
-	uint32_t i;
+	int rc;
 
 	/*
 	 * Although RSS is meaningless when there is a single HW queue we
@@ -6675,9 +6676,11 @@ bnx2x_config_rss_pf(struct bnx2x_softc *sc, struct ecore_rss_config_obj *rss_obj
 			 sizeof(params.ind_table));
 
 	if (config_hash) {
-/* RSS keys */
-		for (i = 0; i < sizeof(params.rss_key) / 4; i++) {
-			params.rss_key[i] = (uint32_t) rte_rand();
+		/* RSS keys */
+		rc = rte_random_bytes(params.rss_key, sizeof(params.rss_key));
+		if (rc != 0) {
+			PMD_DRV_LOG(ERR, sc, "Error generating RSS hash key");
+			return rc;
 		}
 
 		rte_bit_relaxed_set32(ECORE_RSS_SET_SRCH, &params.rss_flags);
-- 
2.53.0

