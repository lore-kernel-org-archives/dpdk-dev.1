Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C823C021B2
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Feb 2025 02:43:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A1E4402CA;
	Sun, 23 Feb 2025 03:43:48 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id BD1A5400D6
 for <dev@dpdk.org>; Sun, 23 Feb 2025 03:43:46 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-220bfdfb3f4so75988755ad.2
 for <dev@dpdk.org>; Sat, 22 Feb 2025 18:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740278626;
 x=1740883426; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4dZ6OnjQkjkRkohtsHknfK7ZFpqKTDRPRX+ENrsy0Go=;
 b=LPtTc0kF1yebJCf5v7HjVUGgPaj0O9/paR1sUJsX0JTEBDWDp1dg/8ZaOfcGXv8Grc
 HPGBiP9cssxxX8B9VeQE3pVZeXYAeKVS4BH9iOj8cMg3LRQL9ssfM8gn9pQGZFqcY090
 dc6usMd7xue0K8rQkl/TloJstVI3r/3yxYaXwVQ3Orfr5vDzbASRSYJvGiQ11YfBkVl4
 UQW8V0RD3WyXRu6bHlc9CHl7B17hu0vo/bPnACwYnpaBZ+0rM780azN6JSxo6z63KZRv
 89bLn0nu6BrjyLOuu5CDUAfB71Ro4n3PLB5iCOYU7sjqAgk73Ci34giuG8lDlZ0KNjOl
 8CIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740278626; x=1740883426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4dZ6OnjQkjkRkohtsHknfK7ZFpqKTDRPRX+ENrsy0Go=;
 b=sXJVJchY9ZJGT2VD24r3Y85xgu9SSZ+rzHJYjKJ/EpaAIvsCNzBO9k+/Gk5u5oY3Le
 LuSEDFj6iolagDJH2bMJuYBN+xVWJJzcrQsv2NN3hyPKu7RfJ6qLht5xv7pzErwJr++T
 ppwatbQ0cDnhu0xb1kynkb7T6oSZMo6Eu0Y7IwoSWCXA9UFgiMbDjHzqn9HKlPGw7Nv6
 lZ35YLcoDVh2qd1T5q6e5wA6ewIVI1CyxKeCN/SdCm1yOi3oBGlQ8yeulpVePkcG35Vw
 juQ1XmOXxONLDfeh2cQtxKwQcGiUYPFQM9W1/Lhx9eV+2sAfzUjinCVZWRBPwKZTXJPK
 UqhA==
X-Gm-Message-State: AOJu0YwZRGqqZiOlalpOcRICySwIWs3EAYImCx26Ip21ek7y3rXLm8jP
 23P5JIRdzsy+4Fh60uajNJ/VMZbmPKqPY3cEabHABoQf7odgw2Dpnj6zXYkHVSimumRqhlcc1x1
 R
X-Gm-Gg: ASbGnctHfh6zTu1NsOpqJyldi11A6HapABGnbMfrg5UoqjxyJnIOMZZR7qxMD00vxyl
 +rQXyJhpnOZnSZMeWg9gB651/PDUaZA+cfZ3wkQCaGt/xnmJE7gbz4Oj7P/pVLvnpl6OWOdDhg9
 0xE61MuWWn16MGaLV0RS/wGqq52enm/O754LJAon5vnqyMlSHnqFSa+wjCfTNKS0iLKovJdzOys
 PyTzl2sgMBRdh5R+gLFBm5uzmNlIcUACAFo2qqVj3UWUAV8qC84c/gb6ci+6e5hsLRbXMoyFMR2
 1Ya/5J61w/+Eft/czV/8/MlxIIDmWLztgKn9SvcP3CcA5FKWavbd8ChUOpb/66desTZfoagXXD4
 SAtE=
X-Google-Smtp-Source: AGHT+IHQSSYA7lA9eEIOh78eEWF4tL1HPvevhdNpB179jd+NweqpnmF+XthE5dYXM46iO7ezPw6mwQ==
X-Received: by 2002:a17:902:ced0:b0:220:e792:8456 with SMTP id
 d9443c01a7336-2219ff311c3mr148764155ad.11.1740278625846; 
 Sat, 22 Feb 2025 18:43:45 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d536443fsm156112955ad.66.2025.02.22.18.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Feb 2025 18:43:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Junlong Wang <wang.junlong1@zte.com.cn>, Lijie Shan <shan.lijie@zte.com.cn>
Subject: [RFC 1/5] net/zxdh: remove __rte_unused from function prototypes
Date: Sat, 22 Feb 2025 18:42:20 -0800
Message-ID: <20250223024334.1216477-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250223024334.1216477-1-stephen@networkplumber.org>
References: <20250223024334.1216477-1-stephen@networkplumber.org>
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

The unused attribute needs to be used on the function definition
only. It is meaningless on function prototype.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/zxdh/zxdh_ethdev_ops.h | 10 ++++------
 drivers/net/zxdh/zxdh_mtr.h        |  4 ++--
 drivers/net/zxdh/zxdh_np.h         |  2 +-
 drivers/net/zxdh/zxdh_queue.h      |  4 ++--
 drivers/net/zxdh/zxdh_rxtx.h       |  6 ++----
 5 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/net/zxdh/zxdh_ethdev_ops.h b/drivers/net/zxdh/zxdh_ethdev_ops.h
index ead571067c..6c3fb83ea4 100644
--- a/drivers/net/zxdh/zxdh_ethdev_ops.h
+++ b/drivers/net/zxdh/zxdh_ethdev_ops.h
@@ -74,7 +74,7 @@ struct zxdh_hw_vqm_stats {
 
 int zxdh_dev_set_link_up(struct rte_eth_dev *dev);
 int zxdh_dev_set_link_down(struct rte_eth_dev *dev);
-int32_t zxdh_dev_link_update(struct rte_eth_dev *dev, int32_t wait_to_complete __rte_unused);
+int32_t zxdh_dev_link_update(struct rte_eth_dev *dev, int32_t wait_to_complete);
 int zxdh_dev_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr,
 		uint32_t index, uint32_t vmdq);
 int zxdh_dev_mac_addr_set(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr);
@@ -101,13 +101,11 @@ int zxdh_hw_np_stats_pf_reset(struct rte_eth_dev *dev, uint32_t stats_id);
 void zxdh_data_hi_to_lo(uint64_t *data);
 int32_t zxdh_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats, uint32_t n);
 int32_t zxdh_dev_xstats_get_names(struct rte_eth_dev *dev,
-			struct rte_eth_xstat_name *xstats_names,
-			__rte_unused unsigned int limit);
-int zxdh_dev_fw_version_get(struct rte_eth_dev *dev, char *fw_version,
-				 size_t fw_size __rte_unused);
+			struct rte_eth_xstat_name *xstats_names, unsigned int limit);
+int zxdh_dev_fw_version_get(struct rte_eth_dev *dev, char *fw_version, size_t fw_size);
 int zxdh_dev_get_module_info(struct rte_eth_dev *dev,
 			 struct rte_eth_dev_module_info *modinfo);
 int zxdh_dev_get_module_eeprom(struct rte_eth_dev *dev, struct rte_dev_eeprom_info *info);
-int zxdh_meter_ops_get(struct rte_eth_dev *dev __rte_unused, void *arg);
+int zxdh_meter_ops_get(struct rte_eth_dev *dev, void *arg);
 
 #endif /* ZXDH_ETHDEV_OPS_H */
diff --git a/drivers/net/zxdh/zxdh_mtr.h b/drivers/net/zxdh/zxdh_mtr.h
index 51ddc0840b..749ceb7479 100644
--- a/drivers/net/zxdh/zxdh_mtr.h
+++ b/drivers/net/zxdh/zxdh_mtr.h
@@ -100,8 +100,8 @@ struct zxdh_hw_mtr_stats {
 	uint32_t n_bytes_dropped_lo;
 };
 
-int zxdh_meter_ops_get(struct rte_eth_dev *dev __rte_unused, void *arg);
-void zxdh_mtr_release(struct rte_eth_dev *dev __rte_unused);
+int zxdh_meter_ops_get(struct rte_eth_dev *dev, void *arg);
+void zxdh_mtr_release(struct rte_eth_dev *dev);
 void zxdh_mtr_policy_res_free(struct rte_mempool *mtr_policy_mp, struct zxdh_meter_policy *policy);
 int zxdh_hw_profile_unref(struct rte_eth_dev *dev,
 		uint8_t car_type,
diff --git a/drivers/net/zxdh/zxdh_np.h b/drivers/net/zxdh/zxdh_np.h
index 63ebd12c18..3e2d99c9be 100644
--- a/drivers/net/zxdh/zxdh_np.h
+++ b/drivers/net/zxdh/zxdh_np.h
@@ -824,7 +824,7 @@ uint32_t
 zxdh_np_car_profile_id_add(uint32_t vport_id,
 			uint32_t flags,
 			uint64_t *p_profile_id);
-uint32_t zxdh_np_car_profile_cfg_set(__rte_unused uint32_t vport_id,
+uint32_t zxdh_np_car_profile_cfg_set(uint32_t vport_id,
 			uint32_t car_type,
 			uint32_t pkt_sign,
 			uint32_t profile_id,
diff --git a/drivers/net/zxdh/zxdh_queue.h b/drivers/net/zxdh/zxdh_queue.h
index 05f391f080..1a54e7cfc9 100644
--- a/drivers/net/zxdh/zxdh_queue.h
+++ b/drivers/net/zxdh/zxdh_queue.h
@@ -410,12 +410,12 @@ int32_t zxdh_get_queue_type(uint16_t vtpci_queue_idx);
 int32_t zxdh_dev_tx_queue_setup(struct rte_eth_dev *dev,
 			uint16_t queue_idx,
 			uint16_t nb_desc,
-			uint32_t socket_id __rte_unused,
+			uint32_t socket_id,
 			const struct rte_eth_txconf *tx_conf);
 int32_t zxdh_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			uint16_t queue_idx,
 			uint16_t nb_desc,
-			uint32_t socket_id __rte_unused,
+			uint32_t socket_id,
 			const struct rte_eth_rxconf *rx_conf,
 			struct rte_mempool *mp);
 int32_t zxdh_dev_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id);
diff --git a/drivers/net/zxdh/zxdh_rxtx.h b/drivers/net/zxdh/zxdh_rxtx.h
index 111c5bcf65..424048607e 100644
--- a/drivers/net/zxdh/zxdh_rxtx.h
+++ b/drivers/net/zxdh/zxdh_rxtx.h
@@ -73,9 +73,7 @@ struct __rte_cache_aligned zxdh_virtnet_tx {
 };
 
 uint16_t zxdh_xmit_pkts_packed(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
-uint16_t zxdh_xmit_pkts_prepare(void *tx_queue __rte_unused, struct rte_mbuf **tx_pkts,
-				uint16_t nb_pkts);
-uint16_t zxdh_recv_pkts_packed(void *rx_queue, struct rte_mbuf **rx_pkts,
-				uint16_t nb_pkts);
+uint16_t zxdh_xmit_pkts_prepare(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
+uint16_t zxdh_recv_pkts_packed(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
 
 #endif  /* ZXDH_RXTX_H */
-- 
2.47.2

