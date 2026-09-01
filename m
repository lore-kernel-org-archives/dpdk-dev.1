Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8B4C61DD3
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:34:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EAFD40E2A;
	Tue,  1 Sep 2026 22:33:40 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id ECD8740281
 for <dev@dpdk.org>; Tue,  1 Sep 2026 22:33:38 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-85339ed040aso243120b3a.1
 for <dev@dpdk.org>; Tue, 01 Sep 2026 13:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788294818;
 x=1788899618; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uXJx8lIYb85ruWhhgjsu0t/11gHDpXX/5sVNc9oSt24=;
 b=unlDpm1J5MqtLhgWLr77WmKkxoZC9OaUEgI9wM3A3ac3KodcwDLMpYS4qeziOCLMJP
 KJcV3RL+CwnT3VFWFTxIJD2+2rM7krScwnywFXiSvCdWIqjAD/9mQeJAWujeXndWIZNC
 Ca9zNPuhIKMf3V94+SMzO0KDBFZXqZAlnNUgcDyvZybnH3/iFsh4A84rXvxOQ3VZprPv
 Hod7zqq6OEgBucszk/w4ItTWsEfnyDwPnBHVMmKn3N6EAqWBmT2amv93DwpyKSfMEYRc
 abCAuEo3JLecVRD4A1i2zkfrECfx2m9escIh54UmX7+E6Nl8XSL5Ap58q8ByNBAIMaRp
 zoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294818; x=1788899618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uXJx8lIYb85ruWhhgjsu0t/11gHDpXX/5sVNc9oSt24=;
 b=TzGjpgO6PRaWUudBGfRf9rBEmY+Pq6ckHTBYn0oQrlmDJu2p1ehzP9M3W5smiD5G2H
 TEtivUxvsnxw4YxocX85NGtQ5oDWVycE/y3cJv7mBCzJhr2VWP+2lDEzjGTcAUZgHZ5T
 UeqYmSmuiW+Tf27oDNAzwQYNrEbZhFMKkkkxhSo9d9NJxEuBfWTk8twuiXdI4s13fqOb
 IANKjB+YxcVcGUIUU3k/hTfL0vJl85KCDinYWOt6w2N0NRKwrtjdy4BVIJSak0m1TS9X
 yMGKF9WlhBBep6o0ykDulEFX3FhhxvvYJYF6d/ZY//MRgTESNSHpzH12bPwN+gdTuv7d
 Mpcw==
X-Gm-Message-State: AFuF++n0IwV53lM6nQ6VbdCuiOdWXXp8btbZNNVFeGcRRXfUnNsAQajE
 SQoOPVL/pbFgJQJS6uz/1AovnDFugtv7GPIr+PYJbP9KSdkfUBwU2181b/+XshCYRX0rXrxdDcR
 PRLl9
X-Gm-Gg: AR+sD10XNi+70ws1y9to2psvp7A2eEBNKXyHKzkVYklwtd6KYGtuB3RHVM+eNuc9MWT
 MOTev/GSSSt4SUAAx2z5f+xT/f4iP+2vjoasTFp00d3PS+wVg4K1nblhC1Y7CO6einuS0j0N6fb
 bY/4nwZ7lqzBjx2L9hrwlIp5yQi+rtLljK76C9tUGDMU5QSQOvbQPQx/iXB9OTrHwnhHpzlWL5T
 ofZs5IQNWVDAnH8D/xIOjy2GDekI1hzQlgvRwYX3mvri61Oy224Ft1UMt4AcLJAUqeK/txIru1y
 eVyykUgdhPvodYM4M7dRlCEilCXrykyrfshfXO+SDKJlZZkTZGcLFje7/Jm6M1vZW8BTxGrFP6z
 jbJjBs0ZYh6JV3pAL+ctGGNkvHedDYqZGgWM/Q89i3Xwy97RMEKYkDwCKWKXCf0Vo6FNl0fUsjj
 Z2iSJWfRGPB92hM21s4SumvApphCh7QFhq9sc65Lr3nzAm1YC71mfxYUnHU76GBoDm14Ir9NuXV
 JK+BtFCgQGW8URRUXP0OboSgpNJ
X-Received: by 2002:a05:6a00:288a:b0:845:e440:d0ca with SMTP id
 d2e1a72fcca58-85ed26e524amr701723b3a.8.1788294817901; 
 Tue, 01 Sep 2026 13:33:37 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc0bffbc1sm323980b3a.48.2026.09.01.13.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:33:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 17/22] ethdev: promote device info and dump helpers to stable
Date: Tue,  1 Sep 2026 13:23:16 -0700
Message-ID: <20260901203217.1485915-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901203217.1485915-1-stephen@networkplumber.org>
References: <20260901203217.1485915-1-stephen@networkplumber.org>
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

A set of introspection helpers that have been stable for years:

  21.11  rte_eth_dev_capability_name, rte_eth_dev_conf_get,
         rte_eth_macaddrs_get
  22.03  rte_eth_dev_priv_dump
  22.11  rte_eth_rx_descriptor_dump, rte_eth_tx_descriptor_dump
  23.11  rte_eth_dev_rss_algo_name
  24.03  rte_eth_find_rss_algo
  24.11  rte_eth_dev_get_reg_info_ext

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  6 +++++
 lib/ethdev/rte_ethdev.c                | 18 +++++++-------
 lib/ethdev/rte_ethdev.h                | 33 --------------------------
 3 files changed, 15 insertions(+), 42 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index e0c8afdb04..2b085dcd51 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -136,6 +136,12 @@ API Changes
   * priority flow:
     ``rte_eth_dev_priority_flow_ctrl_queue_configure`` and
     ``rte_eth_dev_priority_flow_ctrl_queue_info_get``
+  * device info:
+    ``rte_eth_dev_capability_name``, ``rte_eth_dev_conf_get``,
+    ``rte_eth_macaddrs_get``, ``rte_eth_dev_priv_dump``,
+    ``rte_eth_rx_descriptor_dump``, ``rte_eth_tx_descriptor_dump``,
+    ``rte_eth_dev_rss_algo_name``, ``rte_eth_find_rss_algo`` and
+    ``rte_eth_dev_get_reg_info_ext``
 
 
 ABI Changes
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index b4f36a9b1b..0dc7e3b5d2 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -1171,7 +1171,7 @@ eth_dev_offload_names(uint64_t bitmask, char *buf, size_t size,
 	return buf;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_capability_name, 21.11)
+RTE_EXPORT_SYMBOL(rte_eth_dev_capability_name)
 const char *
 rte_eth_dev_capability_name(uint64_t capability)
 {
@@ -4153,7 +4153,7 @@ rte_eth_dev_info_get(uint16_t port_id, struct rte_eth_dev_info *dev_info)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_conf_get, 21.11)
+RTE_EXPORT_SYMBOL(rte_eth_dev_conf_get)
 int
 rte_eth_dev_conf_get(uint16_t port_id, struct rte_eth_conf *dev_conf)
 {
@@ -4314,7 +4314,7 @@ rte_eth_dev_set_ptypes(uint16_t port_id, uint32_t ptype_mask,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_macaddrs_get, 21.11)
+RTE_EXPORT_SYMBOL(rte_eth_macaddrs_get)
 int
 rte_eth_macaddrs_get(uint16_t port_id, struct rte_ether_addr *ma,
 	unsigned int num)
@@ -5155,7 +5155,7 @@ rte_eth_dev_rss_hash_conf_get(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_rss_algo_name, 23.11)
+RTE_EXPORT_SYMBOL(rte_eth_dev_rss_algo_name)
 const char *
 rte_eth_dev_rss_algo_name(enum rte_eth_hash_function rss_algo)
 {
@@ -5170,7 +5170,7 @@ rte_eth_dev_rss_algo_name(enum rte_eth_hash_function rss_algo)
 	return name;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_find_rss_algo, 24.03)
+RTE_EXPORT_SYMBOL(rte_eth_find_rss_algo)
 int
 rte_eth_find_rss_algo(const char *name, uint32_t *algo)
 {
@@ -6845,7 +6845,7 @@ rte_eth_dev_get_reg_info(uint16_t port_id, struct rte_dev_reg_info *info)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_get_reg_info_ext, 24.11)
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_reg_info_ext)
 int
 rte_eth_dev_get_reg_info_ext(uint16_t port_id, struct rte_dev_reg_info *info)
 {
@@ -7316,7 +7316,7 @@ rte_eth_ip_reassembly_conf_set(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_priv_dump, 22.03)
+RTE_EXPORT_SYMBOL(rte_eth_dev_priv_dump)
 int
 rte_eth_dev_priv_dump(uint16_t port_id, FILE *file)
 {
@@ -7335,7 +7335,7 @@ rte_eth_dev_priv_dump(uint16_t port_id, FILE *file)
 	return eth_err(port_id, dev->dev_ops->eth_dev_priv_dump(dev, file));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_descriptor_dump, 22.11)
+RTE_EXPORT_SYMBOL(rte_eth_rx_descriptor_dump)
 int
 rte_eth_rx_descriptor_dump(uint16_t port_id, uint16_t queue_id,
 			   uint16_t offset, uint16_t num, FILE *file)
@@ -7362,7 +7362,7 @@ rte_eth_rx_descriptor_dump(uint16_t port_id, uint16_t queue_id,
 		       dev->dev_ops->eth_rx_descriptor_dump(dev, queue_id, offset, num, file));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_tx_descriptor_dump, 22.11)
+RTE_EXPORT_SYMBOL(rte_eth_tx_descriptor_dump)
 int
 rte_eth_tx_descriptor_dump(uint16_t port_id, uint16_t queue_id,
 			   uint16_t offset, uint16_t num, FILE *file)
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 4eea5b990d..b75cd072d9 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -2379,9 +2379,6 @@ const char *rte_eth_dev_rx_offload_name(uint64_t offload);
 const char *rte_eth_dev_tx_offload_name(uint64_t offload);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Get RTE_ETH_DEV_CAPA_* flag name.
  *
  * @param capability
@@ -2389,7 +2386,6 @@ const char *rte_eth_dev_tx_offload_name(uint64_t offload);
  * @return
  *   Capability name or 'UNKNOWN' if the flag cannot be recognized.
  */
-__rte_experimental
 const char *rte_eth_dev_capability_name(uint64_t capability);
 
 /**
@@ -3506,9 +3502,6 @@ int rte_eth_dev_set_rx_queue_stats_mapping(uint16_t port_id,
 int rte_eth_macaddr_get(uint16_t port_id, struct rte_ether_addr *mac_addr);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice
- *
  * Retrieve the Ethernet addresses of an Ethernet device.
  *
  * @param port_id
@@ -3525,7 +3518,6 @@ int rte_eth_macaddr_get(uint16_t port_id, struct rte_ether_addr *mac_addr);
  *   - (-ENODEV) if *port_id* invalid.
  *   - (-EINVAL) if bad parameter.
  */
-__rte_experimental
 int rte_eth_macaddrs_get(uint16_t port_id, struct rte_ether_addr *ma,
 	unsigned int num);
 
@@ -3552,9 +3544,6 @@ int rte_eth_dev_info_get(uint16_t port_id, struct rte_eth_dev_info *dev_info)
 	__rte_warn_unused_result;
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Retrieve the configuration of an Ethernet device.
  *
  * @param port_id
@@ -3566,7 +3555,6 @@ int rte_eth_dev_info_get(uint16_t port_id, struct rte_eth_dev_info *dev_info)
  *   - (-ENODEV) if *port_id* invalid.
  *   - (-EINVAL) if bad parameter.
  */
-__rte_experimental
 int rte_eth_dev_conf_get(uint16_t port_id, struct rte_eth_conf *dev_conf)
 	__rte_warn_unused_result;
 
@@ -4825,9 +4813,6 @@ rte_eth_dev_rss_hash_conf_get(uint16_t port_id,
 			      struct rte_eth_rss_conf *rss_conf);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice.
- *
  *  Get the name of RSS hash algorithm.
  *
  * @param rss_algo
@@ -4836,14 +4821,10 @@ rte_eth_dev_rss_hash_conf_get(uint16_t port_id,
  * @return
  *   Hash algorithm name or 'UNKNOWN' if the rss_algo cannot be recognized.
  */
-__rte_experimental
 const char *
 rte_eth_dev_rss_algo_name(enum rte_eth_hash_function rss_algo);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice.
- *
  * Get RSS hash algorithm by its name.
  *
  * @param name
@@ -4856,7 +4837,6 @@ rte_eth_dev_rss_algo_name(enum rte_eth_hash_function rss_algo);
  *   - (0) if successful.
  *   - (-EINVAL) if not found.
  */
-__rte_experimental
 int
 rte_eth_find_rss_algo(const char *name, uint32_t *algo);
 
@@ -5251,7 +5231,6 @@ int rte_eth_get_monitor_addr(uint16_t port_id, uint16_t queue_id,
  *   - (-EIO) if device is removed.
  *   - others depends on the specific operations implementation.
  */
-__rte_experimental
 int rte_eth_dev_get_reg_info_ext(uint16_t port_id, struct rte_dev_reg_info *info);
 
 /**
@@ -5925,9 +5904,6 @@ typedef struct {
 } rte_eth_ip_reassembly_dynfield_t;
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Dump private info from device to a file. Provided data and the order depends
  * on the PMD.
  *
@@ -5942,13 +5918,9 @@ typedef struct {
  *   - (-ENOTSUP) if the device does not support this function.
  *   - (-EIO) if device is removed.
  */
-__rte_experimental
 int rte_eth_dev_priv_dump(uint16_t port_id, FILE *file);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Dump ethdev Rx descriptor info to a file.
  *
  * This API is used for debugging, not a dataplane API.
@@ -5968,14 +5940,10 @@ int rte_eth_dev_priv_dump(uint16_t port_id, FILE *file);
  *   - On success, zero.
  *   - On failure, a negative value.
  */
-__rte_experimental
 int rte_eth_rx_descriptor_dump(uint16_t port_id, uint16_t queue_id,
 			       uint16_t offset, uint16_t num, FILE *file);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Dump ethdev Tx descriptor info to a file.
  *
  * This API is used for debugging, not a dataplane API.
@@ -5995,7 +5963,6 @@ int rte_eth_rx_descriptor_dump(uint16_t port_id, uint16_t queue_id,
  *   - On success, zero.
  *   - On failure, a negative value.
  */
-__rte_experimental
 int rte_eth_tx_descriptor_dump(uint16_t port_id, uint16_t queue_id,
 			       uint16_t offset, uint16_t num, FILE *file);
 
-- 
2.53.0

