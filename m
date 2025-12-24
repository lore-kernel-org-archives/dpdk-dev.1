Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F374E78498
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Dec 2025 22:14:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87B3340A71;
	Wed, 24 Dec 2025 23:13:52 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 07E4240655
 for <dev@dpdk.org>; Wed, 24 Dec 2025 23:13:51 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-42fb5810d39so3336514f8f.2
 for <dev@dpdk.org>; Wed, 24 Dec 2025 14:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766614430;
 x=1767219230; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ckPcxqjACKxECZIs8TWH87xa+KWpqiOYhGfkjwzJf+A=;
 b=e/Dqr9GdX8/EpjLOVE8AMddt58piqPYOjZfb+Md/e9JT3KWkb2MbOfg9XwFMPCUvoH
 24VljxXAghBgAtdGI6plMzRWRBpV9F5Nves4uZLWOPYjAkN/oDxGoPYgU8ITsp7YCAxQ
 jqmF0Fk8H7x5BFSAZoLgw8GBQq1R9/e4noJx1xPJzj4hCkDgKAUEtsHSlF/7h7aKNgTQ
 oBFd33hfhBmEQnNJoRY6plteVbHVCwsQYVntDkh88UemqERu6iNViGk74Dj+N2P9Ndrq
 uSNFxA3pHz/ezNseDwbu4mFHlMo9YUVrxMj54wXXoAstzFkATlrxJIhdO4OIPlBztxxk
 NY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766614430; x=1767219230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ckPcxqjACKxECZIs8TWH87xa+KWpqiOYhGfkjwzJf+A=;
 b=jebeztJ7SQjnXkd93TD1X9vdU3n9Gp73KltUto+DO7jg9Hcc9/20f7pr15O5S7NtA8
 vbELNK18L+Zkh/ESDs0QLzkQG9eQ8WjFCbjg7BcEKpqR1GvFo5cBw+xRP51XPglEYac7
 3Dwx1zK/nGBWrBL2uJ4PKwITVfNFNjbGOQX1eRzzCnlwh6qeouJZnpNupCCtEyUR5qLJ
 ZX2dITuPCATECrYWeDcozFqvN9wjwnHFh1FTKAn4tFj+QbljDGmu8yFsmDYWWofA7di2
 ivI66ZR81egRvJ1lyLca0L7A/4TX0GzEvn2UCGXrKWjVJNbHs7m+KWsuqTwuoNT+fuac
 BM+Q==
X-Gm-Message-State: AOJu0YyzyJagjimyRPflo9RcjpoLT8sYOM3BcTAiu/JfM74dK3lgEWbR
 f7HGfEREecSusPus+ML8MaciwS9lBGADpQs4ceQ9IPFjGvF5ZMUUgroWcIaYvMYTAzDnp9ZX59u
 RzqsD1lk=
X-Gm-Gg: AY/fxX4F2aKJUgGlOchqStNn6YipCPRCpo/n2k4ioMDU2laEqtY55guC5xoGh+ZVTiI
 c3vgNJVKj5VVoNkxmoePFO99St6RmvxM2+qK6kHV9qcr+H748/d277LKY5+kRUJs3ZbjrWCpMNF
 74I+ANpCAyeY8WT+sO9/ky7vm39ji0fNSflxUw7mKmyB2v1Vzinjb4E72V4HugTeyAydAa2nqft
 YKLVaCQC43jz2ygkT6n9y3bn/bvfSVheI8yfl9+9QhOETBZOXgDrkTCQYs0PJGBRU/SuoukGka6
 8Eq0yVV9/PvoO7THX7rvtiuq2fGhnXBpXEi3n3khB0vax8PNZSOGmVk/4zINHUX5jtuZcQZAU6R
 NJw/oWFtM1Fqg82nRzvSa/FvbRQm5+bFTc5+bpnaCnf+ATz0dkOOI+tuWg3FFUKMGdFf8pghbTM
 KxcXD5oSBMkS+ZYTjLgRUtanlD+rxasF3ekJI4fixS7YR+n/1izQ==
X-Google-Smtp-Source: AGHT+IFoPsWYJmiUqIbfmzvGSYZzkjtHORPjmMncHOEvEA0mNmlP/FCOP81BwgmSWsSLNwWXR6GdJQ==
X-Received: by 2002:a05:6000:40e1:b0:42f:7601:89ae with SMTP id
 ffacd0b85a97d-4324e4c6853mr19335505f8f.2.1766614430596; 
 Wed, 24 Dec 2025 14:13:50 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830fesm36796622f8f.20.2025.12.24.14.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 14:13:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v7 15/18] ethdev: avoid possible overflow in xstat names
Date: Wed, 24 Dec 2025 14:11:56 -0800
Message-ID: <20251224221301.52714-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224221301.52714-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251224221301.52714-1-stephen@networkplumber.org>
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

The compiler doesn't know that all the elements in the table
of queue stats are short enough to avoid overflowing the snprintf.
Add a condition to warn if it ever does;
maybe some day a new long named queue stat could be added.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/ethdev/rte_ethdev.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index c6fe0d5165..05de3335e5 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -3489,9 +3489,10 @@ eth_basic_stats_get_names(struct rte_eth_dev *dev,
 	uint16_t num_q;
 
 	for (idx = 0; idx < RTE_NB_STATS; idx++) {
-		strlcpy(xstats_names[cnt_used_entries].name,
-			eth_dev_stats_strings[idx].name,
-			sizeof(xstats_names[0].name));
+		if (strlcpy(xstats_names[cnt_used_entries].name, eth_dev_stats_strings[idx].name,
+			    sizeof(xstats_names[0].name)) >= sizeof(xstats_names[0].name))
+			RTE_ETHDEV_LOG_LINE(ERR, "statistic name '%s' will be truncated",
+					    xstats_names[cnt_used_entries].name);
 		cnt_used_entries++;
 	}
 
@@ -3501,10 +3502,17 @@ eth_basic_stats_get_names(struct rte_eth_dev *dev,
 	num_q = RTE_MIN(dev->data->nb_rx_queues, RTE_ETHDEV_QUEUE_STAT_CNTRS);
 	for (id_queue = 0; id_queue < num_q; id_queue++) {
 		for (idx = 0; idx < RTE_NB_RXQ_STATS; idx++) {
-			snprintf(xstats_names[cnt_used_entries].name,
-				sizeof(xstats_names[0].name),
-				"rx_q%u_%s",
-				id_queue, eth_dev_rxq_stats_strings[idx].name);
+			unsigned int cc;
+
+			cc = snprintf(xstats_names[cnt_used_entries].name,
+				      sizeof(xstats_names[0].name),
+				      "rx_q%u_%s",
+				      id_queue, eth_dev_rxq_stats_strings[idx].name);
+
+			/* could only happen if a long string was added */
+			if (cc >= sizeof(xstats_names[0].name))
+				RTE_ETHDEV_LOG_LINE(ERR, "truncated rxq stat string '%s'",
+						    eth_dev_rxq_stats_strings[idx].name);
 			cnt_used_entries++;
 		}
 
@@ -3512,10 +3520,15 @@ eth_basic_stats_get_names(struct rte_eth_dev *dev,
 	num_q = RTE_MIN(dev->data->nb_tx_queues, RTE_ETHDEV_QUEUE_STAT_CNTRS);
 	for (id_queue = 0; id_queue < num_q; id_queue++) {
 		for (idx = 0; idx < RTE_NB_TXQ_STATS; idx++) {
-			snprintf(xstats_names[cnt_used_entries].name,
-				sizeof(xstats_names[0].name),
-				"tx_q%u_%s",
-				id_queue, eth_dev_txq_stats_strings[idx].name);
+			unsigned int cc;
+
+			cc = snprintf(xstats_names[cnt_used_entries].name,
+				      sizeof(xstats_names[0].name),
+				      "tx_q%u_%s",
+				      id_queue, eth_dev_txq_stats_strings[idx].name);
+			if (cc >= sizeof(xstats_names[0].name))
+				RTE_ETHDEV_LOG_LINE(ERR, "truncated txq stat string '%s'",
+						    eth_dev_txq_stats_strings[idx].name);
 			cnt_used_entries++;
 		}
 	}
-- 
2.51.0

