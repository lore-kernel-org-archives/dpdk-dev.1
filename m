Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E46CD98CF
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 09:39:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B6A740298;
	Tue, 16 Jun 2026 11:39:19 +0200 (CEST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 636E840298
 for <dev@dpdk.org>; Tue, 16 Jun 2026 11:39:18 +0200 (CEST)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-490ae94a89eso38283525e9.1
 for <dev@dpdk.org>; Tue, 16 Jun 2026 02:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781602758; x=1782207558; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=/jNfazvuMmaiE80lDjBcAzAiJpiDDMBdcJ7a59H+zsE=;
 b=qvSl2AGtOhpahLtbrT2aEwmmlparKaU2Y4KF1Q9sid7WK9RmWVviWtOSi6v3kyipev
 NY9E9sLfHSnhZD2qMAOarZ9emBX9ilke+ZN07Af+sQq0tvqbDLx5HMHk8X/vzjL7hW1a
 OdH7G9HHBMZk2cJJHeGHE3fu2fW0wavcdE6kTRSk+FSCMSe1V+yvhIDJmvGKwy4IQ2SW
 RY/akTigzfqKtg4to/uQHj2bWFDWplphhh6nwTULSRgStI6J3YKFa7M6zOn0JVw4y645
 EBlGcZeHpCwC7KCsUkmyFZ1FRv3BGARGDCSU9SlIzVHQFzE3LNlExxX7gWdKDuLWi0yK
 ugTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781602758; x=1782207558;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/jNfazvuMmaiE80lDjBcAzAiJpiDDMBdcJ7a59H+zsE=;
 b=ldvKs4qS/LI2BoteKjvsV0raferbANnsC3AnlGEJ4nAG/9v8eKaPcEtRL8gQ3PVsQr
 IlkTYExzZ9dbhy5+2W7oIfLaRV63XlzuMApbONwhabxpVCKh6lT+zoYTNutFUW0GCSEa
 ptmiY2o+s5GeNnlBy4qHcSCYpLnCWy/aX45AF+Xv69xXNWPBY6sGaTk/drnTWqvKLfbk
 FAQY/0syYKuCm/dcqqhZWHFCsnSZsLC35L2Sl+q5lKb5rqPNTsPRCwq7w7eCAQsAzhMB
 qMNNenyWt/9vWaHF1WJ9knp0tFKEGL6H9CDq5h7oXTpP/S+NUnrbwFf+l0Wt5VZvd+To
 AAEg==
X-Gm-Message-State: AOJu0Yyr00ZGsPKbAXFEtLnmsAI+KfOeQYg48wnvL0a4B0uGe40+YLHR
 n4iQBDVAStywSPO2glT1/I5ECUW33FTQRoX54VM4pvEGdMRfHiUs01sOx3lHGeli
X-Gm-Gg: Acq92OHPSCcJ8lPwIo3SwebRmGH3WgcBZlstIL74k7Gipk3fdMDuMwfaJMfkagLWEdA
 eorB4cgT1X/oJGT4RAkLUC0AYEu849A64CbuD4hBEfVzYOlKbCPbGyQWjsve1TpuaIeQcRtvBnO
 TKRhBqp6XeKUlGEEE4AlF20Y4yrH293eJIzFgRwhHqn7hi+AkUVM3S8LonavtL2uV3sTTIvuv6Y
 UW72xJ7kfhG/6eFwnzOxmo3fXNZrpy7hFc3hrrntnB5ugbvMcsvdSLL++BQgPbNFdjdNEeCfuLB
 SSPBmvvw0rppF6ZxSv+Rwxn4HR+sOZzH/cYJXTN0YxnR0ZB4pkIkuIAlIZJShvFIYuMdir4S4TS
 DCGZAL8V3ostigQknMDjT105TKGif9x2NOTecxo4077wZ+pEJIUFl1lyE1LExB16CwuxdUvZrUT
 NJ2RleIt7hJIY4sly69XecMeJ8xJnki09EceD2J0KbYlseQ87uZn0OAPsEVUaZ91o=
X-Received: by 2002:a05:600c:c0c3:10b0:490:c024:2ec8 with SMTP id
 5b1f17b1804b1-4921fcb3ffemr155439345e9.0.1781602757543; 
 Tue, 16 Jun 2026 02:39:17 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa890d8sm72639155e9.10.2026.06.16.02.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 02:39:17 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org,
 Aman Singh <aman.deep.singh@intel.com>, Heqing Zhu <heqing.zhu@intel.com>,
 Jijiang Liu <jijiang.liu@intel.com>, Helin Zhang <helin.zhang@intel.com>,
 Cunming Liang <cunming.liang@intel.com>, Jing Chen <jing.d.chen@intel.com>
Subject: [PATCH] app/testpmd: include IP fields in UDP RSS option
Date: Tue, 16 Jun 2026 11:39:12 +0200
Message-ID: <20260616093912.685791-1-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
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

The --rss-udp option is documented as enabling IPv4/IPv6 + UDP RSS, but it
currently sets the RSS hash functions to RTE_ETH_RSS_UDP only.

On PMDs that translate this directly to L4 port extracts, this can build a
L4-only RSS key. Add RTE_ETH_RSS_IP when --rss-udp is selected so the
configured key matches the documented IPv4/IPv6 + UDP behavior.

Make --rss-ip additive as well, so combining --rss-ip and --rss-udp is
order-independent.

Fixes: 8a387fa85f02 ("ethdev: more RSS flags")
Cc: stable@dpdk.org
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 app/test-pmd/parameters.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index 337d8fc8ac..0032ea4e25 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -1286,10 +1286,10 @@ launch_args_parse(int argc, char** argv)
 			set_pkt_forwarding_mode(optarg);
 			break;
 		case TESTPMD_OPT_RSS_IP_NUM:
-			rss_hf = RTE_ETH_RSS_IP;
+			rss_hf |= RTE_ETH_RSS_IP;
 			break;
 		case TESTPMD_OPT_RSS_UDP_NUM:
-			rss_hf = RTE_ETH_RSS_UDP;
+			rss_hf |= RTE_ETH_RSS_IP | RTE_ETH_RSS_UDP;
 			break;
 		case TESTPMD_OPT_RSS_LEVEL_INNER_NUM:
 			rss_hf |= RTE_ETH_RSS_LEVEL_INNERMOST;
-- 
2.43.0

