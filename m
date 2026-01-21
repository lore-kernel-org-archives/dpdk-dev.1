Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF260C44508
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 17:06:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1CD242E46;
	Wed, 21 Jan 2026 18:05:55 +0100 (CET)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67]) by mails.dpdk.org (Postfix) with ESMTP id BB4B942E4C
 for <dev@dpdk.org>; Wed, 21 Jan 2026 18:05:54 +0100 (CET)
Received: by mail-wm1-f67.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so694155e9.0
 for <dev@dpdk.org>; Wed, 21 Jan 2026 09:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769015154;
 x=1769619954; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKECzZtOT39UmIjh1DHHC51OgBCcQSgVSm5owuLpbSQ=;
 b=wis8lhI9OaM3fVBKg6MhXJyWwTUQZN9oF0suaDDtyW1kyrgu2hADzyz6bnLNOEqLmJ
 pqI23nLV88t8PjSYpkNepMEy+nzRpVKBfl6Zm+uQlz1Jnaf2HiwedVqGNwz43TcXMw46
 rkEhoEP6LJB3XIvCG6vJGg7mZpKWt3cCC1o6z+5BfVutuN8e4ViyqjUmJIHWPI3G4wYJ
 WU2hHlbjJ/Kly9eu59qUeaMrizqS0DCCVCiHzASIXWaU1+H/m+UTulCUZcwWuxFg9wiN
 fwggFzmPX3Fs+4A+m+x9hJ7Z/p+Ffupm8Ogwt77XktBhpr+ZlDhkVuhzyzUuy9Xn7ZbC
 qg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769015154; x=1769619954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sKECzZtOT39UmIjh1DHHC51OgBCcQSgVSm5owuLpbSQ=;
 b=JSf8BxRkjbl/lvohdXjJr9nRKdzgNCKMndeaYOVXQhspW4d8NuZgZc6Gxvy1yJxP8y
 jWHEX4YxW9EFa9pe0WHfZ+xQnTEQFet5iOlAispKIaanSII9lt2B/g8+2xM9KqMmFWU+
 Ty1MxcMpfm/FrZnAkE5Tc2+D5UZT2Oh7QV9QxHAT+PXD3LbIXRgR5EYTxFEJIVNIhkXK
 jrYlw+pbq0T0ApNdW4aHZbS9b6uH7RX0UV5UIdENIfiJAVV7q1TTHOj6QuldHtC74HT3
 MPWpm1H8yTTMX+1xEKJES6JdvSUtZCrSgiBvPLYqoYHaTTwwvUhqS2/A6BFGjhxi+8xj
 1Yuw==
X-Gm-Message-State: AOJu0YwNgjxJTzST8bTDCsqF08+dHh6+tuoAsYDRqDmellO7wiFlS7wH
 ijclAP3WvJtFQHsX7JfoVaJicKWj/7rPHNF8gP3Lpe6FeRaIwl92rygg52Z39Mom7a1hiPgVt1x
 vYqIoeoQ=
X-Gm-Gg: AZuq6aL82K+F4+WCg3TvRuxvAchNCu03cGailp3GmNdqcfB/bLs2vgicAVQoErzdqla
 X1TkppNJ8dmy+sbjGNqTtgToAEWIMuDPD2VgHuzGKemQefsevjSJvCJHj0HAFcSM9w1QUFBbkd0
 fGiTgATzVHBNsPxoAAiI3ACZNEEMCadRZUcJ0CYWieaFGqG5slpia3Erq/1GxWScVfeFL4F/zkS
 JaYO/vIdR/Tu/oqdkc4/mOr1+jGMfiGCB/6aliieoNpda7mSvFi10Q7X6qW/2cq/W3qOHKKaNoP
 3gtb5tUvyMzYNFnDGbbUqPbQZ4aoLaJqsiEMbqkoPLfKXMxpzwJEhEAWJXBsLrYmgESD3zMpEwU
 BN7m1p3cR3+hJuOXC/Qozg7CRMpLvaq7efk7MUzzQTDlC4oPCmQQrxUgm5YNPX5Qoqj+Defr263
 OzjO84fJ1gUvINYRe1hP18yE7WSS40cBrWk64X+Q8AA89U+IUPaw==
X-Received: by 2002:a05:600c:3509:b0:47a:94fc:d057 with SMTP id
 5b1f17b1804b1-4801eab54e2mr215791685e9.2.1769015152322; 
 Wed, 21 Jan 2026 09:05:52 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48042c1e381sm25653555e9.11.2026.01.21.09.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 09:05:51 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 3/4] examples/vmdq_dcb: replace memcpy with assignment
Date: Wed, 21 Jan 2026 09:04:56 -0800
Message-ID: <20260121170540.785735-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121170540.785735-1-stephen@networkplumber.org>
References: <20260121170540.785735-1-stephen@networkplumber.org>
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

Better to use structure assignment rather than memcpy.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/vmdq_dcb/main.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/examples/vmdq_dcb/main.c b/examples/vmdq_dcb/main.c
index 4ccc2fe4b0..6eccee086d 100644
--- a/examples/vmdq_dcb/main.c
+++ b/examples/vmdq_dcb/main.c
@@ -17,7 +17,6 @@
 #include <rte_common.h>
 #include <rte_log.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_eal.h>
 #include <rte_launch.h>
 #include <rte_cycles.h>
@@ -161,15 +160,13 @@ get_eth_conf(struct rte_eth_conf *eth_conf)
 		tx_conf.dcb_tc[i] = i % num_tcs;
 	}
 	dcb_conf.nb_tcs = (enum rte_eth_nb_tcs)num_tcs;
-	(void)(rte_memcpy(eth_conf, &vmdq_dcb_conf_default, sizeof(*eth_conf)));
-	(void)(rte_memcpy(&eth_conf->rx_adv_conf.vmdq_dcb_conf, &conf,
-			  sizeof(conf)));
-	(void)(rte_memcpy(&eth_conf->rx_adv_conf.dcb_rx_conf, &dcb_conf,
-			  sizeof(dcb_conf)));
-	(void)(rte_memcpy(&eth_conf->rx_adv_conf.vmdq_rx_conf, &vmdq_conf,
-			  sizeof(vmdq_conf)));
-	(void)(rte_memcpy(&eth_conf->tx_adv_conf.vmdq_dcb_tx_conf, &tx_conf,
-			  sizeof(tx_conf)));
+
+	*eth_conf = vmdq_dcb_conf_default;
+	eth_conf->rx_adv_conf.vmdq_dcb_conf = conf;
+	eth_conf->rx_adv_conf.dcb_rx_conf = dcb_conf;
+	eth_conf->rx_adv_conf.vmdq_rx_conf = vmdq_conf;
+	eth_conf->tx_adv_conf.vmdq_dcb_tx_conf = tx_conf;
+
 	if (rss_enable) {
 		eth_conf->rxmode.mq_mode = RTE_ETH_MQ_RX_VMDQ_DCB_RSS;
 		eth_conf->rx_adv_conf.rss_conf.rss_hf = RTE_ETH_RSS_IP |
-- 
2.51.0

