Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43224C61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:34:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 366B940E72;
	Tue,  1 Sep 2026 22:33:52 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id 0F94940E43
 for <dev@dpdk.org>; Tue,  1 Sep 2026 22:33:50 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-854f8068301so191553b3a.0
 for <dev@dpdk.org>; Tue, 01 Sep 2026 13:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788294829;
 x=1788899629; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JTHg3tOmduRjzCjNqtZqO+T2vhJKZfKLAoBFNUdod0Y=;
 b=Abak3r7bHDXeO1AfFzuBkezC8EOPjxb+gQ3mmSn6AH72+Din2Jp0bHLrCI+MEBEM0p
 VKh+QWol2BUjsndhe9BmPoETtiC/Nak+yueLuq7B+49GBmFqiNazK9NptXXoIeWikXMJ
 gMO9uAlWafAq6VEzSSO6LkqmKLwKfD45owjJhMUoKhL4i7niQH9zIRizjckv1Uej2OJ+
 jat4DI6tk+WROPijZ6LZisw+CJPscu3w4Rc1NcC3ym2zTSyianIFL+AOnaoxX96SGSbq
 U4nvhTAd1XhCX+noajV9xCg6rmnkLWwKqx7c3NlC8rX4CccX/kY+fVxAqeT5RvekaYnf
 IG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294829; x=1788899629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JTHg3tOmduRjzCjNqtZqO+T2vhJKZfKLAoBFNUdod0Y=;
 b=r9Nhs9/ZQZcbw7lFkBdEzhVDYHtLCNNbjvzk8KS1/LaCE8SQa/sFG2At9o53U+oaHS
 5pkdXWa69OI4HnUauM5/3iO4wyu/GEIDrpFOe39h/6gnG2POzyYrXEJcGB7Lcj2UGeZJ
 CMkqYyNM91CFNnhJDdH/pr5BppK7g9gPwjN3dnzuZKnrDWkcwGxB0KvPxgmz560FqEhd
 Fb7hNTdmJSmS1MKi4OQx+TiFG2UOfFO5ShNwhjVtvvGH0LIYcM2o78wXcdc/vG1iyJRB
 baIQ/aLM+KJ9+Cv1lFEJuYEf+TFAfg9XSY0v/rAycysXzs9J3/Gk0fDl1qzpOFKbfgnB
 lxGA==
X-Gm-Message-State: AFuF++nnyr7+G4BtdMIhIalLvz0En+vfBzZVrlur/7CAkam5caJcpQiu
 QD4UrDckvat/4QfL7kbW32ScqykySaB0RTzhZfHa5AKLLRVMJg1Nn2UZsU5tbIRaIDwB1OjgMuT
 x5S4C
X-Gm-Gg: AR+sD11VkuiFLmPnXAF/xrE37j89XmNpeJ/YIUf6hKfwCLm2FfBqoPEqkYdC83RFhJQ
 WEbLkpPllqKIb2bRkbnRIJfoST1Qlc9NSYgrkFWiHoZ6MukwpjOUB2v2o1gsFC5zp+Qb2RtmZZz
 /kbIqqQQTldvM5kLItY+O+BwI7YtSc46ssy2mSzQLlLST/rF8nYU+QB4OieQq+eVBajAsJWc1h7
 jGqZyIG5vzhXcpa5mOMR7BLpNntaxb6w8EO95rFLD4WsvsANrrMEMjzfmVgoH0NqlpyvqWVfpbZ
 3ERANo4s64tjynG+rpzbepyRxpjVu66bM1Uqjz2Q+zaJEHTlQmU17pAi6CBG58W+5tGy+siBbc+
 UJCJgh29OvqY6MiX1nWgu+aAEdJ8zFv6thWWwRO7DjsFN1JgUAMGmAWEEX0XCBoGAFW60r/pw/8
 2lxutggMQWjaC4nfgN13UgmAslDTu0CDgzl6gpuZ1ITmw4LPLL1OZ9ETJUvRiF5FEz9t7W0x75Q
 yrDn2U34A9eu8QkJIe7ODQm+1k=
X-Received: by 2002:a05:6a00:2d8d:b0:852:38ea:3fd with SMTP id
 d2e1a72fcca58-85ed24e8c0amr672037b3a.11.1788294828922; 
 Tue, 01 Sep 2026 13:33:48 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc0bffbc1sm323980b3a.48.2026.09.01.13.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:33:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 20/22] ethdev: promote remaining aged symbols to stable
Date: Tue,  1 Sep 2026 13:23:19 -0700
Message-ID: <20260901203217.1485915-21-stephen@networkplumber.org>
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

The last ethdev symbols that are at least two years old:

  21.02  rte_eth_get_monitor_addr
  21.05  rte_eth_representor_info_get
  22.11  rte_eth_buffer_split_get_supported_hdr_ptypes
  24.11  rte_eth_timesync_adjust_freq
  24.11  rte_tm_node_query

With this the only exported, non-inline experimental symbols left in
ethdev are from 25.03 and later. The inline helpers
rte_eth_recycle_mbufs() and rte_eth_tx_queue_count(), and the trace
point symbols, keep the experimental tag and are left for later.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  4 ++++
 lib/ethdev/rte_ethdev.c                |  8 ++++----
 lib/ethdev/rte_ethdev.h                | 16 ----------------
 lib/ethdev/rte_tm.c                    |  2 +-
 lib/ethdev/rte_tm.h                    |  1 -
 5 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index b23ffa6cb0..7254ef585c 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -151,6 +151,10 @@ API Changes
     ``rte_eth_recycle_rx_queue_info_get``,
     ``rte_eth_dev_count_aggr_ports`` and
     ``rte_eth_dev_map_aggr_tx_affinity``
+  * utility funcs:
+    ``rte_eth_get_monitor_addr``, ``rte_eth_representor_info_get``,
+    ``rte_eth_buffer_split_get_supported_hdr_ptypes``,
+    ``rte_eth_timesync_adjust_freq`` and ``rte_tm_node_query``
 
 
 ABI Changes
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 4c675f1f22..62e2c0dd07 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -6547,7 +6547,7 @@ rte_eth_tx_burst_mode_get(uint16_t port_id, uint16_t queue_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_get_monitor_addr, 21.02)
+RTE_EXPORT_SYMBOL(rte_eth_get_monitor_addr)
 int
 rte_eth_get_monitor_addr(uint16_t port_id, uint16_t queue_id,
 		struct rte_power_monitor_cond *pmc)
@@ -6718,7 +6718,7 @@ rte_eth_timesync_adjust_time(uint16_t port_id, int64_t delta)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_adjust_freq, 24.11)
+RTE_EXPORT_SYMBOL(rte_eth_timesync_adjust_freq)
 int
 rte_eth_timesync_adjust_freq(uint16_t port_id, int64_t ppm)
 {
@@ -7149,7 +7149,7 @@ rte_eth_dev_pool_ops_supported(uint16_t port_id, const char *pool)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_representor_info_get, 21.05)
+RTE_EXPORT_SYMBOL(rte_eth_representor_info_get)
 int
 rte_eth_representor_info_get(uint16_t port_id,
 			     struct rte_eth_representor_info *info)
@@ -7389,7 +7389,7 @@ rte_eth_tx_descriptor_dump(uint16_t port_id, uint16_t queue_id,
 		       dev->dev_ops->eth_tx_descriptor_dump(dev, queue_id, offset, num, file));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_buffer_split_get_supported_hdr_ptypes, 22.11)
+RTE_EXPORT_SYMBOL(rte_eth_buffer_split_get_supported_hdr_ptypes)
 int
 rte_eth_buffer_split_get_supported_hdr_ptypes(uint16_t port_id, uint32_t *ptypes, int num)
 {
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index d18afa20c6..6f18878bc5 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -5139,9 +5139,6 @@ int rte_eth_tx_burst_mode_get(uint16_t port_id, uint16_t queue_id,
 	struct rte_eth_burst_mode *mode);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Retrieve the monitor condition for a given receive queue.
  *
  * @param port_id
@@ -5158,7 +5155,6 @@ int rte_eth_tx_burst_mode_get(uint16_t port_id, uint16_t queue_id,
  *   -EINVAL: Invalid parameters.
  *   -ENODEV: Invalid port ID.
  */
-__rte_experimental
 int rte_eth_get_monitor_addr(uint16_t port_id, uint16_t queue_id,
 		struct rte_power_monitor_cond *pmc);
 
@@ -5449,7 +5445,6 @@ int rte_eth_timesync_adjust_time(uint16_t port_id, int64_t delta);
  *   - -EIO: if device is removed.
  *   - -ENOTSUP: The function is not supported by the Ethernet driver.
  */
-__rte_experimental
 int rte_eth_timesync_adjust_freq(uint16_t port_id, int64_t ppm);
 
 /**
@@ -5636,9 +5631,6 @@ int rte_eth_dev_hairpin_capability_get(uint16_t port_id,
 				       struct rte_eth_hairpin_cap *cap);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice.
- *
  * Ethernet device representor ID range entry
  */
 struct rte_eth_representor_range {
@@ -5656,9 +5648,6 @@ struct rte_eth_representor_range {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice.
- *
  * Ethernet device representor information
  */
 struct rte_eth_representor_info {
@@ -5692,7 +5681,6 @@ struct rte_eth_representor_info {
  *   - (-EIO) if device is removed.
  *   - (>=0) number of available representor range entries.
  */
-__rte_experimental
 int rte_eth_representor_info_get(uint16_t port_id,
 				 struct rte_eth_representor_info *info);
 
@@ -6921,9 +6909,6 @@ rte_eth_recycle_mbufs(uint16_t rx_port_id, uint16_t rx_queue_id,
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice
- *
  * Get supported header protocols to split on Rx.
  *
  * When a packet type is announced to be split,
@@ -6948,7 +6933,6 @@ rte_eth_recycle_mbufs(uint16_t rx_port_id, uint16_t rx_queue_id,
  *   - (-ENODEV) if *port_id* invalid.
  *   - (-EINVAL) if bad parameter.
  */
-__rte_experimental
 int rte_eth_buffer_split_get_supported_hdr_ptypes(uint16_t port_id, uint32_t *ptypes, int num)
 	__rte_warn_unused_result;
 
diff --git a/lib/ethdev/rte_tm.c b/lib/ethdev/rte_tm.c
index 66b8934c3b..675d6e146d 100644
--- a/lib/ethdev/rte_tm.c
+++ b/lib/ethdev/rte_tm.c
@@ -316,7 +316,7 @@ int rte_tm_node_add(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_tm_node_query, 24.11)
+RTE_EXPORT_SYMBOL(rte_tm_node_query)
 int rte_tm_node_query(uint16_t port_id,
 	uint32_t node_id,
 	uint32_t *parent_node_id,
diff --git a/lib/ethdev/rte_tm.h b/lib/ethdev/rte_tm.h
index c9dd760858..c393b86b3b 100644
--- a/lib/ethdev/rte_tm.h
+++ b/lib/ethdev/rte_tm.h
@@ -1638,7 +1638,6 @@ rte_tm_node_add(uint16_t port_id,
  *   -EINVAL - port or node id value is invalid
  *   -ENOENT - no node exists with the provided id on the provided port
  */
-__rte_experimental
 int
 rte_tm_node_query(uint16_t port_id,
 	uint32_t node_id,
-- 
2.53.0

