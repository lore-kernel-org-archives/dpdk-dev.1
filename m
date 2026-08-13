Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC26C5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 18:04:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C99642E5B;
	Thu, 13 Aug 2026 20:04:29 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id BBB4B42E15
 for <dev@dpdk.org>; Thu, 13 Aug 2026 20:04:27 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so166489a91.0
 for <dev@dpdk.org>; Thu, 13 Aug 2026 11:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786644267;
 x=1787249067; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7AxFmUcGxix1vMn+PXUzjSr+UBJcOAMb6q9tg+CsvQg=;
 b=SGM65/YhRIuqCtyKmcbOA+6gCQN2hwA5WP6W9eIAQpX4xvFrQ0XdIO/LdWM+c+Ol04
 iCAsuHcfdNu3x0yjBh0Y5SxG/33+DaKnv896N3o0hY8OpEaAfPQyZGoUsPoWpM7JbolE
 EWI8OlyDCuz/gUDyJh7ANPebqJ4On1HiF2A98R3QhhjIyE04zaHHZCJginyGDPOxNZ5k
 TrTCJTMmq3Dp/XS8cL9FkuQHfDBrFC5NLMNBQXIlQg2L5003QLP3Wl3M2B1VG+VCLHrF
 7cb9tb1vRX1fR6MiKH75eQK4orqyDHW78q3cGcbF1P2xqNqffmQbY7rD+VpEbdMD/bbA
 c7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786644267; x=1787249067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7AxFmUcGxix1vMn+PXUzjSr+UBJcOAMb6q9tg+CsvQg=;
 b=a5S5q1FZ3cQG4A1bkPExeNbW5p6e4IvKXLQPqtYGc+yer/shm43kncqLd71qL39/qK
 eQDiMJVvwDnipcF4x+0wldYShZ98vXsdOPE/EoT8k15HgGD1D7vjqkeXQQqr3aHq0rkv
 58VzNsQ4fH41iERJ3jQ/Ay6Xrj1EG8g/5ifQfjj26rJttCxI1KBCeOU6mRof/Sok+Dky
 tp+qnGVGdowmLwlopaRwWTlFkC9O3+ZPUpjFBiFVon6UgX8Xo8ig3BgCxgodYDPbByIT
 jMqYDkKNVIWaYh2/nSUq3iWC/4uakJGi6sJUNBOG6tAiF+PxEEWS6PRZ8j8RRC9mYOAE
 YZbg==
X-Gm-Message-State: AOJu0Yy/gv1ZBNx/NMcdAy6iTQbItjn/hPcJnk8J4b4CBwnAczWl9bbd
 Ev6GorakeKJ9QC++RakJAgMMcJbeeUb8TvHeQKav1nLujFnE5ve5P2hc2XQTNJWgKgib8GBW7Cz
 7fo3m
X-Gm-Gg: AR+sD10CDy/A2hMsj+8mXiwSGufApK5pf1F6NnqdH5SE75I/7Yk/2AXGNOs7xQlW5Sr
 opT/84u3kAsjMoub3nlMRolnYhTO00aXhOusMjMwMLMNIxE8rSC72/OUyn3lmLvaFT0aP0luRjr
 9OEBp2xkeU7npCmDApdQrZriDx8Sn0bR9Iua0BrdZEjne50nolr60EpYo3ITN5DiDSXaRijm8RY
 qS4TRUm2Q5szCz09XQCcBMO8QKyUrhmrR87E4fv7OygaFt1LIKe0qKGpusD5k0RnrHMMInimzK9
 ZpXw9QeZjWp2oPCPyZKUFHe1PQEYskLl72UwPChE6dhtfYzVGHdjYUHLhhNrtEJmXKs4ud2vbvu
 d4ZWWM1gJES7tVPaVfjYoNFm34taq/cilQX+WBewqtNxkxd5lsNB4AVgn8kUsx72xHPWIPN0m9f
 FPYvaO1Xl46+w0MRw3H3FxrH9SuZ1yIoDwsSaxk4W2EMwf8l7dlJQA+q7MmCFQ3SjN/Ft1r7tzs
 UFCHE79JySHrKdJ9mfHghODN10=
X-Received: by 2002:a17:90b:5203:b0:381:6c5:3f63 with SMTP id
 98e67ed59e1d1-3931e03d800mr8880345a91.6.1786644266880; 
 Thu, 13 Aug 2026 11:04:26 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31f7c8018cdsm3658930eec.13.2026.08.13.11.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 11:04:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 04/16] net/cnxk: fix Tx drops added to Rx queue errors
Date: Thu, 13 Aug 2026 10:55:03 -0700
Message-ID: <20260813180402.622784-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813180402.622784-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260813180402.622784-1-stephen@networkplumber.org>
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

q_errors counts received packets dropped, and is reported as the
rx_qN_errors xstat. The Tx branch assigns the Tx drop count and the Rx
branch adds to it, so rx_qN_errors reports both. Stat indexes with only
a Tx mapping hold Tx drops alone.

Tx drops are already counted in oerrors, so drop the assignment and
store the Rx drop count directly.

Fixes: 58ae74244c90 ("ethdev: remove queue stats from basic stats structure")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/cnxk/cnxk_stats.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_stats.c b/drivers/net/cnxk/cnxk_stats.c
index d57659ef51..6c812bd732 100644
--- a/drivers/net/cnxk/cnxk_stats.c
+++ b/drivers/net/cnxk/cnxk_stats.c
@@ -45,7 +45,6 @@ cnxk_nix_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats,
 					goto exit;
 				qstats->q_opackets[i] = qstats_data.tx_pkts;
 				qstats->q_obytes[i] = qstats_data.tx_octs;
-				qstats->q_errors[i] = qstats_data.tx_drop_pkts;
 			}
 
 			if (dev->rxq_stat_map[i] & (1U << 31)) {
@@ -55,7 +54,7 @@ cnxk_nix_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats,
 					goto exit;
 				qstats->q_ipackets[i] = qstats_data.rx_pkts;
 				qstats->q_ibytes[i] = qstats_data.rx_octs;
-				qstats->q_errors[i] += qstats_data.rx_drop_pkts;
+				qstats->q_errors[i] = qstats_data.rx_drop_pkts;
 			}
 		}
 	}
-- 
2.53.0

