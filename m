Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA24C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 14:14:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C69F842EF6;
	Tue, 10 Jun 2025 16:14:15 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id CDEC842EF4
 for <dev@dpdk.org>; Tue, 10 Jun 2025 16:14:14 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-7d20f799fe9so505211985a.2
 for <dev@dpdk.org>; Tue, 10 Jun 2025 07:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749564854;
 x=1750169654; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mfSdz8p+HgLonLtQOEnNakhUn47ksVzeUjsOCiiqQ3E=;
 b=WmqSu6ONXOmp12p3TGue3RI0dvs9PdOxnds548P09bo0Gi/ItgIvpTcA7QEQ3x8ohG
 sACS4eGibTMespYWFmFVF+T427qeoZ5lJMSk0gutHxXXRt7pmXq82vg07jAw+Qkv3B/z
 kzySVsVqnNA73UsuU1jAMp3WX5Pu4CRTIiI2dJDhQjmQr9TqjTV9Ly5090xSfrolFVlf
 C6Jewj48SLgUp0j9z8EvA1XE9j0CfEJgm2uTGJZBKZM3M40Tyn6yDvb1t084noSXK2zs
 +4x3fQ1XGjLqogKvho/CJCHa9Vx7Dd52XMLuh5qUNVgQi7yoGACqutF/87PfrFVk2565
 Vcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749564854; x=1750169654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mfSdz8p+HgLonLtQOEnNakhUn47ksVzeUjsOCiiqQ3E=;
 b=ltd4GiCvPoaOWWk5wIjy1RvVrXVRcMHn9PKAgsxJW4wDg2POLAU9gi4ThxpKjR/5Ws
 mdQ1l9SRc32AJFhvPoJtLuzZhS6+SiT9oAi8xp7r5+StinkM/HD74kcTgcMo+awd/ng+
 Gw/s9NUgvofJVFqkrGfEN5I43EmNZVqHIMufRFmrW/mtD8c8tMoU4YduQfO583Hsbq/g
 f1dlmS0tvxRhV36K7p2sCAroJyJznJj8hibYs1B4KpIIJ6kuC7DbWneL+/vS8cK6lVMd
 e9NLVRPbAckYzHzGPeA3rGgbqwVWTwnQcR8rgm856PMoMHj3S5KSgsK1S7eEgbj9ID5o
 4iHw==
X-Gm-Message-State: AOJu0YwGvkoo37+weE0NqyU5u8NpfR8poLEssQC8pK4Kkh8kvG98yKOX
 04idierGbc32/UJMlbUhAUE4HvYYR/DT1oRZ2jqXM7Xa6akXN90iHwB0c8f2N54EAB7lwsg2KhG
 5MBmN
X-Gm-Gg: ASbGncv264j+gjt3gWJyTKeNwy/kZNDUvXJ3MC481R+PIi1Hnxdv006lTt52RFwn/dt
 fW0V3TA696lbyqZncN00k9zjxPuaG9fKilXMF6dzHhuN/0Ii2MQvTuoo+jjVEWITUCnLDbcqzIo
 dRhTE0e34o0VekWlHgH1GX/WFlusov+Tnj4dTJZV2g4VbNMIWCVqsZQ72Ets9VjjhbgQ+TjlAiQ
 BT9PcQv3IMfY6Upl2w+Nfo1mnbXBwsLsijBeSzoLr5Nnmpmrxff532PLHb+0Ud9qhSTVX5omvDs
 /EmRFz9uQ3r9nNzHIFzod7fEAD8mpGShWLVorVbzm0xD455Iqn7D+AfzIVi7FpL8Qk13XXg6e7v
 d6HUHwKpjYTzqDVrRySMNa/6B4X8FA9CM8Lxa
X-Google-Smtp-Source: AGHT+IHGhH5cvvdfiN8a2xIOtemRj1ubV7jsKMrKNUk8ATxDWHXwyPJL8XXalELKpMWnmMrKQAstBg==
X-Received: by 2002:a05:620a:4484:b0:7d3:914b:abe6 with SMTP id
 af79cd13be357-7d3a7da9d77mr6060685a.23.1749564843124; 
 Tue, 10 Jun 2025 07:14:03 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d2669b573asm698525985a.110.2025.06.10.07.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 07:14:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v8 3/7] latencystats: fix log messages
Date: Tue, 10 Jun 2025 07:12:42 -0700
Message-ID: <20250610141355.91759-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610141355.91759-1-stephen@networkplumber.org>
References: <20240408195036.182545-1-stephen@networkplumber.org>
 <20250610141355.91759-1-stephen@networkplumber.org>
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

All messages occur because of an error should be at log level
NOTICE or above. Do not break log messages across lines.
Reword message for the case where getting info about a port
fails and it is skipped.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Tyler Retzlaff <roretzla@linux.microsoft.com>
---
 lib/latencystats/rte_latencystats.c | 35 ++++++++++++++---------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
index 9345f8c4de..50043aea72 100644
--- a/lib/latencystats/rte_latencystats.c
+++ b/lib/latencystats/rte_latencystats.c
@@ -261,7 +261,7 @@ rte_latencystats_init(uint64_t app_samp_intvl,
 	latency_stats_index = rte_metrics_reg_names(ptr_strings,
 							NUM_LATENCY_STATS);
 	if (latency_stats_index < 0) {
-		LATENCY_STATS_LOG(DEBUG,
+		LATENCY_STATS_LOG(ERR,
 			"Failed to register latency stats names");
 		return -1;
 	}
@@ -281,8 +281,8 @@ rte_latencystats_init(uint64_t app_samp_intvl,
 
 		ret = rte_eth_dev_info_get(pid, &dev_info);
 		if (ret != 0) {
-			LATENCY_STATS_LOG(INFO,
-				"Error during getting device (port %u) info: %s",
+			LATENCY_STATS_LOG(NOTICE,
+				"Can not get info for device (port %u): %s",
 				pid, strerror(-ret));
 
 			continue;
@@ -293,18 +293,18 @@ rte_latencystats_init(uint64_t app_samp_intvl,
 			cbs->cb = rte_eth_add_first_rx_callback(pid, qid,
 					add_time_stamps, user_cb);
 			if (!cbs->cb)
-				LATENCY_STATS_LOG(INFO, "Failed to "
-					"register Rx callback for pid=%d, "
-					"qid=%d", pid, qid);
+				LATENCY_STATS_LOG(NOTICE,
+					"Failed to register Rx callback for pid=%u, qid=%u",
+					pid, qid);
 		}
 		for (qid = 0; qid < dev_info.nb_tx_queues; qid++) {
 			cbs = &tx_cbs[pid][qid];
 			cbs->cb =  rte_eth_add_tx_callback(pid, qid,
 					calc_latency, user_cb);
 			if (!cbs->cb)
-				LATENCY_STATS_LOG(INFO, "Failed to "
-					"register Tx callback for pid=%d, "
-					"qid=%d", pid, qid);
+				LATENCY_STATS_LOG(NOTICE,
+					"Failed to register Tx callback for pid=%u, qid=%u",
+					pid, qid);
 		}
 	}
 	return 0;
@@ -326,10 +326,9 @@ rte_latencystats_uninit(void)
 
 		ret = rte_eth_dev_info_get(pid, &dev_info);
 		if (ret != 0) {
-			LATENCY_STATS_LOG(INFO,
-				"Error during getting device (port %u) info: %s",
+			LATENCY_STATS_LOG(NOTICE,
+				"Can not get info for device (port %u): %s",
 				pid, strerror(-ret));
-
 			continue;
 		}
 
@@ -337,17 +336,17 @@ rte_latencystats_uninit(void)
 			cbs = &rx_cbs[pid][qid];
 			ret = rte_eth_remove_rx_callback(pid, qid, cbs->cb);
 			if (ret)
-				LATENCY_STATS_LOG(INFO, "failed to "
-					"remove Rx callback for pid=%d, "
-					"qid=%d", pid, qid);
+				LATENCY_STATS_LOG(NOTICE,
+					"Failed to remove Rx callback for pid=%u, qid=%u",
+					pid, qid);
 		}
 		for (qid = 0; qid < dev_info.nb_tx_queues; qid++) {
 			cbs = &tx_cbs[pid][qid];
 			ret = rte_eth_remove_tx_callback(pid, qid, cbs->cb);
 			if (ret)
-				LATENCY_STATS_LOG(INFO, "failed to "
-					"remove Tx callback for pid=%d, "
-					"qid=%d", pid, qid);
+				LATENCY_STATS_LOG(NOTICE,
+					"Failed to remove Tx callback for pid=%u, qid=%u",
+					pid, qid);
 		}
 	}
 
-- 
2.47.2

