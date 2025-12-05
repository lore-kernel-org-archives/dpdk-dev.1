Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D879FD2CDFE
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 02:30:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AB8F40A6E;
	Fri,  5 Dec 2025 03:30:05 +0100 (CET)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id 6F011406BC
 for <dev@dpdk.org>; Fri,  5 Dec 2025 03:30:01 +0100 (CET)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-4ee1fca7a16so13913231cf.3
 for <dev@dpdk.org>; Thu, 04 Dec 2025 18:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764901801;
 x=1765506601; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jgXk7GJc0szkgCLPkV6555v8oG+Eeho6NGFTnCQtHqw=;
 b=vdIydhuCu7O1fXuistPybASe9ys6qA2Fzbel0/UnbjYwCQeqxlgTRC+AB2LT/jDMf5
 2JjxKqpFFDt9V32EEUz8kcRSp4OczKZtommZcbqL/GzWuU13CNqspLnhj/lHYrG+2Pki
 gm+VqEefcfrYpN8vBDVXnh5Uz3hneArAWXUMI3xixME658iLQhwgauNl62nFP+TzoYdL
 fN0so4xYRoxfODp5DxnWcB/Gm0GwqWPSLhKP4yVv5nCVAxWZ4X4JFGv/2UvdSUEDHU/u
 qVkBG6bMYIvI5qtFxtA+PyUhZIS8s+wpLEUu/JMf+CeUEnkkWOhER6sk+Hezp5yxXM4F
 tyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764901801; x=1765506601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jgXk7GJc0szkgCLPkV6555v8oG+Eeho6NGFTnCQtHqw=;
 b=ht/q2fa1+AgDHPR9uSO/mKpsYpK4RlgZxQpQKIBapY9ETaScXt5VWxzGw/pQkgnMYS
 2RI3PaVrBtPNK3LRedTOExyEh4pFyWw7T3TlnLgxfi4YB9kTkJ7FdUcoMCYoE344r9df
 +MDm2A6583nBX/m43kUMsVXYvyk74yt1FgnLBM7QuLf2AtIgrNkU2e0NAKANizY+Vg7F
 7eejj/zsXSIDvaf4By3ruNE1H2CzTW2NT/ytXUphi6J5H38iZaEspQqwQZg1dMehOgwi
 OVuzjCTbJqsCbYUIXB4chLR8o5jFt1z9kJCXDticJSbWc+HFaqKlH7XuNfFtl3vbZtoT
 t55w==
X-Gm-Message-State: AOJu0YwrWjkwmoYUeeThUPZVH7FiRAEEZ1RRLjvdtdCO1ldyRQncrlU9
 pcM5YUfNBj51ZqJBVBDq/x4dkvFHveCNuG+VcqG5PDeT5UGJ0pTmTCUGIp0w3is16hQrWxYtJC9
 1cUGn
X-Gm-Gg: ASbGncuUl9e5sZwlt7lIsM9peNIj29T5GeUB/qCG6cAE1410tJYKzsDVaOcLs9NOlI2
 X01uvR79evlSdDc7hNpuQOPzdw+aSEQowqo0VAxvDxHZwC5t+5A7VUsrcfJmltyDzkSc0VmvY4U
 7603c+vhb04ik9kPR/BP384rEiye+2VG31xLShUmnz1BiUfnZs6RxnkfdHf2k8q9bpynPKb5F9E
 6LOYxh33hZ3qMLKqwMsvjN92a+cbZSTJV5I9VJjq1jk5tRRbvbaqDL44Of7Fhgi13gpSH2dt/Zg
 5+OAumKMvN9IHg+4Lm7V1+6nCHI/fm5k07AEUc/q8cv17TmIe13oA8EDUAeesZ9tzmN0L9uTs2B
 i7x0UryKGHjYGQgcHmwOdtUhhxRNNXd8bAY04jWYMJfkH3x+G1b2lEvO4lRE9FVKy3kvfOtbdLZ
 6I55Zm/PauBnaifJYEtm+0I/Wu9YQyIKW8nDK5uDeqMrdpM1tFKQ==
X-Google-Smtp-Source: AGHT+IGUHzLdF9GV5foCc3E9sjgLMIsMEV6mPlLYYn/tm5vCiMDnyHpsMQXblf7POMbiE/UcX2y05g==
X-Received: by 2002:ac8:5991:0:b0:4eb:a3fe:53d with SMTP id
 d75a77b69052e-4f023ad2615mr85648991cf.79.1764901800599; 
 Thu, 04 Dec 2025 18:30:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f02b7bd0b4sm15655861cf.22.2025.12.04.18.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 18:30:00 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC v2 08/14] ethdev: avoid possible overflow in xstat names
Date: Thu,  4 Dec 2025 18:28:17 -0800
Message-ID: <20251205022948.327743-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205022948.327743-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251205022948.327743-1-stephen@networkplumber.org>
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
Add a condition that will not happen to warn if it ever does;
maybe some day a new long named queue stat could be added.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/rte_ethdev.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index c6fe0d5165..20a6ce3450 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -3501,10 +3501,17 @@ eth_basic_stats_get_names(struct rte_eth_dev *dev,
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
 
@@ -3512,10 +3519,15 @@ eth_basic_stats_get_names(struct rte_eth_dev *dev,
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

