Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B0EE9A02C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 00:34:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83225402C6;
	Thu, 19 Feb 2026 01:34:02 +0100 (CET)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50]) by mails.dpdk.org (Postfix) with ESMTP id 722F1402BD
 for <dev@dpdk.org>; Thu, 19 Feb 2026 01:34:01 +0100 (CET)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-89505dd3e24so4828166d6.1
 for <dev@dpdk.org>; Wed, 18 Feb 2026 16:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771461240;
 x=1772066040; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7TrucIVCw+i8/DuOh6Q6L2HQ8L70ymTXUqegkVBH6H4=;
 b=oJBtEuIrYyJAc0gFGdhcsGS4lt5T1L/zPSj4hCSG9wMRjXR99gn32eV+x0z/IgnW2Q
 9fnMId2NjDSqvU2wwpekMbN1SRBFEgk8XlTwpgWyUaUL9mQw5BN4lHGaf2iH81L7mjqj
 PkKo/uv93FQXPrfW4OQbJYLyDTs8S90Og64uWwnSSpWDCIPn4+9NaCe+mWMPkG+eZhPn
 yihnjpCynIraqzTqc4qQ+bFbWkiiA6kuTWhbbq5nyQA+UBQ1iJc4SbD3VM0nqYeBPJxZ
 4XyWgfz1GYz5CLSmo0NWtVT2kRYNFS0CTI+FsBMB7AYyhZPsfyyF76Kjp86QuxFRPvub
 Jjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771461240; x=1772066040;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7TrucIVCw+i8/DuOh6Q6L2HQ8L70ymTXUqegkVBH6H4=;
 b=XQra9+DDz12jz1BzuzeOz5nCO7LSGw1vlqNsZ0vo8/bLj7VreysqlBj4pb50XCfMWs
 1pPXpjF8mLHQ56oLgHgbOjZZ51fsb926lX5Wql28Ul+bVeN5MBLNpY3vQHHpkLkzdO8p
 sWg8bMUjIMq/uHMaWoB8XBof3y5lwzcc6fwrRaa81jLgfqKcFhf2WMUKb8cshjUnVDIr
 VMcjfOlp3p8Sl/BMBPY3rhYE4ZgrlFP2S6oI21whEHHp9mKtA2JFQ+itgENa2dH0c0QM
 eZXmWzsVvJU1IovcCGrOV1w4sJcHQ2coVS68wOvj8NwZPCYgnC9RN/OX1M+aVyDs528A
 NIpQ==
X-Gm-Message-State: AOJu0YyeYSpEq+QF85CVoV/a4TQygUaoCFT8lGLfdnNDHuy9DZwJzd9b
 eywtTGYfWEEtXXZgYxzzWszcoDM08mh9SgEy68hDY6qYtGLkwkBh7/CwwuBi4yTe3g/PRk0Gl89
 BEDvb
X-Gm-Gg: AZuq6aIXJKmaaVtuLtrXMIzETv5jagRgv+fcnAA77a2meVL1meBLfCHP/wIijOvOLJ0
 lnUtmwspo01VSLt5dLbo7HIltEp7rZ9WF/K2UpxtioOOXTE5Cfe/qkaKt02chyZSw3D6zT7ScuB
 7HPofsbeeTwXf54VByiFWq8otBnvgsE5mTAhPX5h66IrqrBai3uR3QnfCHToty+eeXMnFQGTY6s
 dLyXMG8E5w1cKj+boMZ1t2Fly4nLlbkiHn+7j2RUL3rsir2TaPNsFXv4wQSgJuoORR1IvaJqsF5
 os6JTQ3x0gFnk4aNlnpVoA/sCH/La7dC/zL2tHAOnOjt255yb6Z6vbDgFmbbvdfeaH3SM5VPLle
 HY+ifD5t9dN5Kj3XgKzwmSLPmCSHj6OsWtfQY1TC/Pq3t/jhE2VGlkVAmolhoG/AUbXhxkIjEy7
 KbN1b65tcArE5aRm0RbOKln7LYEiJaA0kQbPVxsFHbctd6dFCPG1RQVPLzzO85TLghD3rydnHG
X-Received: by 2002:a05:6214:f2c:b0:895:48b9:4fce with SMTP id
 6a1803df08f44-899580e83bdmr50503196d6.71.1771461240577; 
 Wed, 18 Feb 2026 16:34:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cdbd860sm201678236d6.46.2026.02.18.16.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 16:34:00 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Jingjing Wu <jingjing.wu@intel.com>, Helin Zhang <helin.zhang@intel.com>
Subject: [PATCH] examples/vmdq_dcb: initialize all configuration structures
Date: Wed, 18 Feb 2026 16:33:54 -0800
Message-ID: <20260219003354.83183-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

Replace field-by-field assignment of local configuration structures
with designated initializers. This ensures all fields, including
enable_loop_back and any padding, are zero-initialized.

The Coverity warning was always latent; the earlier use of
rte_memcpy() was hiding it from the analyzer.

Coverity issue: 501603
Fixes: 8cc72f2814dd ("examples/vmdq_dcb: support X710")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/vmdq_dcb/main.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/examples/vmdq_dcb/main.c b/examples/vmdq_dcb/main.c
index 6eccee086d..d6f7b632b9 100644
--- a/examples/vmdq_dcb/main.c
+++ b/examples/vmdq_dcb/main.c
@@ -132,23 +132,23 @@ static struct rte_ether_addr vmdq_ports_eth_addr[RTE_MAX_ETHPORTS];
 static inline int
 get_eth_conf(struct rte_eth_conf *eth_conf)
 {
-	struct rte_eth_vmdq_dcb_conf conf;
-	struct rte_eth_vmdq_rx_conf  vmdq_conf;
-	struct rte_eth_dcb_rx_conf   dcb_conf;
-	struct rte_eth_vmdq_dcb_tx_conf tx_conf;
+	struct rte_eth_vmdq_dcb_conf conf = {
+		.nb_queue_pools = (enum rte_eth_nb_pools)num_pools,
+		.nb_pool_maps = num_pools,
+	};
+	struct rte_eth_vmdq_rx_conf vmdq_conf = {
+		.nb_queue_pools = (enum rte_eth_nb_pools)num_pools,
+		.nb_pool_maps = num_pools,
+	};
+	struct rte_eth_dcb_rx_conf dcb_conf = {
+		.nb_tcs = (enum rte_eth_nb_tcs)num_tcs,
+	};
+	struct rte_eth_vmdq_dcb_tx_conf tx_conf = {
+		.nb_queue_pools = (enum rte_eth_nb_pools)num_pools,
+	};
 	uint8_t i;
 
-	conf.nb_queue_pools = (enum rte_eth_nb_pools)num_pools;
-	vmdq_conf.nb_queue_pools = (enum rte_eth_nb_pools)num_pools;
-	tx_conf.nb_queue_pools = (enum rte_eth_nb_pools)num_pools;
-	conf.nb_pool_maps = num_pools;
-	vmdq_conf.nb_pool_maps = num_pools;
-	conf.enable_default_pool = 0;
-	vmdq_conf.enable_default_pool = 0;
-	conf.default_pool = 0; /* set explicit value, even if not used */
-	vmdq_conf.default_pool = 0;
-
-	for (i = 0; i < conf.nb_pool_maps; i++) {
+	for (i = 0; i < num_pools; i++) {
 		conf.pool_map[i].vlan_id = vlan_tags[i];
 		vmdq_conf.pool_map[i].vlan_id = vlan_tags[i];
 		conf.pool_map[i].pools = 1UL << i;
@@ -159,7 +159,6 @@ get_eth_conf(struct rte_eth_conf *eth_conf)
 		dcb_conf.dcb_tc[i] = i % num_tcs;
 		tx_conf.dcb_tc[i] = i % num_tcs;
 	}
-	dcb_conf.nb_tcs = (enum rte_eth_nb_tcs)num_tcs;
 
 	*eth_conf = vmdq_dcb_conf_default;
 	eth_conf->rx_adv_conf.vmdq_dcb_conf = conf;
-- 
2.51.0

