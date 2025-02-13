Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224A1C021A0
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 21:22:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33C6F402DD;
	Thu, 13 Feb 2025 22:22:08 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id ECB7E402C5
 for <dev@dpdk.org>; Thu, 13 Feb 2025 22:22:05 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-21f78b1fb7dso23405675ad.3
 for <dev@dpdk.org>; Thu, 13 Feb 2025 13:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739481725;
 x=1740086525; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iabywrl0u11YGh3Q3Dtu1Jk/vzT4tGJ0vMVH+hzkvQ0=;
 b=GeCtngkORSvoukbHq1WSof+Ei7Zbs99/4x0+4v1pMy80yiJyga5EvcRv0VRfK2QMnA
 JF2DnsjxJscHyENgBqQEXAaeptE0zBdFU8Qy8Giv3CNPN1L/c3PjRpsldKX0GPxleUxx
 9CRgYOF9CrVljKLnW9e3fv8nO3OjSn/NnOyxd3hNu/kEwXxzJ7aIepVZlmeAFed71ASZ
 z7eLVwYzKyUCoJMx41qM+U+gT5R6USQdbIgIeyhBQkvvwGCfsohoMI5S8lNwJp8nThsa
 TPeNVhhFtUeDR3c7dKcdpl6knHm3gT+nqGbyNamXzRWV+xrm+PLAKwQFrrgyX4h7Fb/L
 G1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739481725; x=1740086525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iabywrl0u11YGh3Q3Dtu1Jk/vzT4tGJ0vMVH+hzkvQ0=;
 b=qWenq+KlTLyGh8gNzTXVhzGtCEla6m8kZw1CNCJIj41pAfFdfkY5eReET8D9+rfF8X
 BKbWCg7LSCCzPY+Zcg1rK2M0sxB1SxtOsqJoPa7MU6wYcJYpLhT0G2N8HWykcULXugtY
 ckFT872diFjE2ObL5sOS2FyaqbvbWXp0ggeRdiARArr/k7HT4Gx3u5yg7ILe5rJVPuRv
 RdAvq3EoWmoySKSxWuWB292xovtwblLrdfSfFV0gMEi/sjc2pPpUmYkesmSkkeLYmWaC
 CLLc5+xQ2d1Sg79HfSDhp0ds6yjyIDif9aNNUwRJCkmWsp9dz0KV62mzOM1DyxkCwKT4
 4GeA==
X-Gm-Message-State: AOJu0YyrTetaqXLQ6VxCPIJDR+rfm5t1xu8nhERgA8bd4zJan1uSkDtk
 ZqRCk6Bigw0xHUoTLc/8imKxRFRqi3nto+pQg3Bb7zRHMdhfPxaOheoAhZ7b2cRJl35h5gmaYGx
 W
X-Gm-Gg: ASbGnculnta9AskdMRQ10mbLdOB5WrfAhjwVc12nq9HVHF1nUWl6wMMnv5hGPO2Qdud
 Tiu6pwOhwDc34HBbdu/3CCl8TPC7T9gDM/lmLQ0cTLkjS4l/EIvsXrTyQQIL7uulELXtjpsA2FS
 mHEFAtZbP5i0GjgE/ZCGyOpJIVJPa6gT2uSBLrRQj/pDfD+q+o7+8kjnXmo9Ic26ah+sAx+XZWm
 /c/pY5QV2DZd/GyYNqmy3q2lsRiJhsaOvpPQSYmW24bam2r8zeby34W5fsjyV6UHhtIGlYDUPvp
 UJdjGBk+ijtb8JwyBrSnsKu8sQ1ULxlEJ4gZE6T81KbHfmpKB7/Z7oE2FbS0LGywNX0Y
X-Google-Smtp-Source: AGHT+IHwd6NpUdbnrgK1EgtQ54zdTyOU7ebAssScAuV4up9LUf9k/40DL+yW6WjO9xuZUpcgIdrDhw==
X-Received: by 2002:a17:902:d50c:b0:220:be86:a42d with SMTP id
 d9443c01a7336-220be86a79amr120983235ad.21.1739481725095; 
 Thu, 13 Feb 2025 13:22:05 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb57c5de85sm1615822a12.10.2025.02.13.13.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 13:22:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v7 3/7] latencystats: fix log messages
Date: Thu, 13 Feb 2025 13:20:32 -0800
Message-ID: <20250213212151.1693506-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250213212151.1693506-1-stephen@networkplumber.org>
References: <20240408195036.182545-1-stephen@networkplumber.org>
 <20250213212151.1693506-1-stephen@networkplumber.org>
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

All messages that because of an error should be at log level
NOTICE or above. Do not break log messages across lines.
Reword message for the case where getting info about a port
fails and it is skipped.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Tyler Retzlaff <roretzla@linux.microsoft.com>
---
 lib/latencystats/rte_latencystats.c | 35 ++++++++++++++---------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
index b7a4e313ad..82c310da92 100644
--- a/lib/latencystats/rte_latencystats.c
+++ b/lib/latencystats/rte_latencystats.c
@@ -259,7 +259,7 @@ rte_latencystats_init(uint64_t app_samp_intvl,
 	latency_stats_index = rte_metrics_reg_names(ptr_strings,
 							NUM_LATENCY_STATS);
 	if (latency_stats_index < 0) {
-		LATENCY_STATS_LOG(DEBUG,
+		LATENCY_STATS_LOG(ERR,
 			"Failed to register latency stats names");
 		return -1;
 	}
@@ -279,8 +279,8 @@ rte_latencystats_init(uint64_t app_samp_intvl,
 
 		ret = rte_eth_dev_info_get(pid, &dev_info);
 		if (ret != 0) {
-			LATENCY_STATS_LOG(INFO,
-				"Error during getting device (port %u) info: %s",
+			LATENCY_STATS_LOG(NOTICE,
+				"Can not get info for device (port %u): %s",
 				pid, strerror(-ret));
 
 			continue;
@@ -291,18 +291,18 @@ rte_latencystats_init(uint64_t app_samp_intvl,
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
@@ -323,10 +323,9 @@ rte_latencystats_uninit(void)
 
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
 
@@ -334,17 +333,17 @@ rte_latencystats_uninit(void)
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

