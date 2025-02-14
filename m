Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637BCC02198
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 17:42:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED7E040696;
	Fri, 14 Feb 2025 18:42:41 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 3BF524067D
 for <dev@dpdk.org>; Fri, 14 Feb 2025 18:42:39 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2f9d3d0f55dso3500449a91.1
 for <dev@dpdk.org>; Fri, 14 Feb 2025 09:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739554958;
 x=1740159758; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YrmGWTYNW3qwZzf7tftBfp3r9ML2uHuOnUX2EvQUexQ=;
 b=Gv3+f2HNtjZS1QH/hGKj2P4iEHHWiu5XvRLd2hRwDKRtX+Tw8cuA3ktvSdYC4XyBS1
 FnRrsZWiG/PF/piintLTjUkZoPNYzDU29afwPQj7SOwQfajh3DVeKzRtmGqBFJ/1B+h1
 +RrzRols9OZeWZ0ECTyhZPV/GOsddON3pXJT6s2ktAaoWCHIYrjGPKvrHyxNBrU3KGG0
 z+ZMKYLZP8IAC6G7NUcYzvt2NYJ+MJOQu1zpUBfYfuAogLJfmV76Uae71NF6JMX25owU
 m66WGqXDd2j35xWloCYeXFJSqhkOIoqCfy284MOtIaUZsMPBxRzEad2Y84D6qzrhEzC8
 RjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739554958; x=1740159758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YrmGWTYNW3qwZzf7tftBfp3r9ML2uHuOnUX2EvQUexQ=;
 b=l8J2+7fqQpzv6KPYzEB0VghRZJhNgkyt19vytNhGSB1iXBPc26tOVxfZdTKmS9b7CP
 Y62qQFc6FWB7NkySw8p/W+NZG0AVVBk0yKiNdgkimOtutsVRxDfkXjrEBellDv3m1/o7
 adNscZrlOZDugSsVZ9ta3xg/w9tOa2+5jXrqXS1x5DLcJYrgV2z6HqQf6MEChwwo1s+H
 HZcveaCe+fXugmU2a1FhKFCUijwR4AiMGW398ZVfQByZNTII9plO57NfvqTy4NngW2I7
 ivSBVAkzWwgRfZJs6X+EUZ34rygJaY9G7vdrLge9vJ9vZ0ShIX3zt3ocSkBl67UG7LU3
 ofww==
X-Gm-Message-State: AOJu0YygyRNcADgryLbe1W5vo6dGZpKAhToZVelY8Js4l/SZtZR9CzKc
 frQjsKKVTjgUp1B9yoExgSoyIQIclAZk7ZBQ1uY3WrAlrpHXgrpyC5LzjIaMyqPdNcy14AMxsf8
 XVoM=
X-Gm-Gg: ASbGncuAyRet4OvR41uGWoq6uQ1N9nK4r1NpajH/l5ueehMNH26ron2EPsih1ZUFFHM
 giIq5ltON4U9zp1qcPVIf2N5Gqin7CZMJUyH5Snb5t7dWzlTogwrmspf5SftnUCaSgDaM5eIK0P
 JKdO71p4NweqF5qLxYagEEFnrjOB893l8AQ8Q0cNvVrsIf6BOdYIihcOSpspWhX6uGFGMytggoc
 3Bnfg94brG9c0bav5FL6c0FE1Ks4BK/tsVd4A5zpEsSPtxNDpqHZpPUH4Qf17Y7JdKdLtr4ht3X
 3DUrSvF++3amePKxpvDCQtwekVGBML7KetaI9h7SOEerqcwgMBm88beCR5g52ZUpnckr
X-Google-Smtp-Source: AGHT+IGsYlRzOglah0ZXelce0FO22hVpF5UbKOqAVOn5boL6fHKXj5yPewjd6FlhPBSuo4XF/QlKOQ==
X-Received: by 2002:a17:90a:d88c:b0:2ef:2d9f:8e55 with SMTP id
 98e67ed59e1d1-2fbf5c0f4fdmr21162970a91.17.1739554958426; 
 Fri, 14 Feb 2025 09:42:38 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98f48eesm5449852a91.22.2025.02.14.09.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 09:42:37 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 3/6] net/dpaa: remove unnecessary deferred start check
Date: Fri, 14 Feb 2025 09:38:56 -0800
Message-ID: <20250214174224.79142-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250214174224.79142-1-stephen@networkplumber.org>
References: <20241213214929.817688-1-stephen@networkplumber.org>
 <20250214174224.79142-1-stephen@networkplumber.org>
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

This check is now done in ethdev layer.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/dpaa/dpaa_ethdev.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index e8d34e5898..ce4bbbb8f0 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -1089,11 +1089,6 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		return -rte_errno;
 	}
 
-	/* Rx deferred start is not supported */
-	if (rx_conf->rx_deferred_start) {
-		DPAA_PMD_ERR("%p:Rx deferred start not supported", (void *)dev);
-		return -EINVAL;
-	}
 	rxq->nb_desc = UINT16_MAX;
 	rxq->offloads = rx_conf->offloads;
 
@@ -1399,11 +1394,6 @@ int dpaa_eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 
 	PMD_INIT_FUNC_TRACE();
 
-	/* Tx deferred start is not supported */
-	if (tx_conf->tx_deferred_start) {
-		DPAA_PMD_ERR("%p:Tx deferred start not supported", (void *)dev);
-		return -EINVAL;
-	}
 	txq->nb_desc = UINT16_MAX;
 	txq->offloads = tx_conf->offloads;
 
-- 
2.47.2

