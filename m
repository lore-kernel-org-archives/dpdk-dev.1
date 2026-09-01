Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C953C61DD3
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:34:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3BE140E50;
	Tue,  1 Sep 2026 22:33:46 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id BDFEA40EE7
 for <dev@dpdk.org>; Tue,  1 Sep 2026 22:33:45 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-85339ed040aso243203b3a.1
 for <dev@dpdk.org>; Tue, 01 Sep 2026 13:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788294825;
 x=1788899625; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=94GqgBCc7cexA3BUPEHOWUXjFxeUGLDvRR7lwsNtrcY=;
 b=rF92N3V0lzlKN0daQkjnEj2hYJQ0ylaBIxmRz7J96iNPlwzvZlGePdfDr5D2t9T+BC
 rA040JuS0n8v6hOLGxmDFucWUuueBU1QVxODcwn4e+TKi/H93WY91KTs2lJu9tbsdxCZ
 ThEjBjRSyvuOcVICm4XmtSuUk4lWz1yLk8MAMJKPT2xauD7oZhxD/+Cg286FGZModEVO
 kbLkg1dgb2VqSNIeGDavGhKg2LXynY4knweiuKrRdvdG8aWC4GHiPR3xfzP5zF74dpdB
 vxe8iq/TGvxDV7lEvR+gEL51oXbtPGPTy2nRVqvpfJiBJB/VnkawTxk9cmOYP9cp7vn1
 w/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294825; x=1788899625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=94GqgBCc7cexA3BUPEHOWUXjFxeUGLDvRR7lwsNtrcY=;
 b=g8qRhCoc5h0NbP7Tf1Wk4Ybsbg3rSDyi6Akcsr42Xb6I9dRiKexFIKEYeDAMg7UZe/
 665d7MdUawZtuhXylS9JK/W5PPB0NRab+q1VAWrDBawlJ4dbwBsiqu11274wtAc2Ns9Y
 4GzivCbs0NjBSpCaS1rtjaLU0Ea+EAfKoeUvsN6Z3BTyMNra247Hpojp3TvpFtpiFl8W
 5S95aaH2+QfQIJs1UW1PATzFUtmCOlwBYmjfJJ7I3a/su0nwmBdjFfG+WigfAf2wQuzF
 8Aa2RjSeLyxf4PFNu1SshjwEaWewtQbMNR7X3ZMGz6Ns6xr32xhZ3Q/qqOaT0GcUs/0Y
 PGbg==
X-Gm-Message-State: AFuF++n4SY2O8CsUS460FW5sknQqsZTUFrw3//LerOAaUPrEz/AtpywN
 4JjCXvoe5s79caxJRb1o05V+0Q1ChdG79j2HrHGQs8L4vVNxb0qMGqJzU9bWesy+QE+ZmGDShlq
 33a2Z
X-Gm-Gg: AR+sD13IeNw1GlH1xXGfBuXYVsFoKqzt5F1NUNtLscLyM07QQTBZtbewPt6zqtdtl5m
 h210qbC1tEKC+BPl+JetMTg675QRY7lFS/N7U9OphXXQ3R8Im2ueP7nr1PI7S6UWoYHoOlKnDf+
 7up85UESPO6+EpUkFRAUowzJ7nzKiEZXVCncnEc4L9HM3Ta39ye5uTZgEK2irau2lpwCadrXqrd
 yYft95r/ibNtWVEDrogBN5tENrtZgM7nkDPaWDItI2FoVtDWHcZTd1nlE5dPfyGO8WStsM5u5bf
 RuJM/CzgYtKzseMBICucBMj7eAZYe+zEJzfEHR4slJhAeE/74SwKt9/8iL8lqPasoJqRGNuaS+j
 NgQzqtQVforPICipwK9leVBPFHIVbh7Cvee6J4TFilZpCioZnbkVKN54N2qTF4WzeRzzzADG40J
 3V7zxnGxgQLJqI6/PPlk+rLugCny69IOiYp1dky6MpQGNzazDmtz/Y6YcFKySIXzYc0wNBY7N/T
 C8MHeqWyaz/QU2XL3gln2KisJE=
X-Received: by 2002:a05:6a00:3697:b0:851:8baf:5b29 with SMTP id
 d2e1a72fcca58-85ed26e6e24mr633331b3a.10.1788294824854; 
 Tue, 01 Sep 2026 13:33:44 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc0bffbc1sm323980b3a.48.2026.09.01.13.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:33:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 19/22] ethdev: promote queue helpers and aggregated ports to
 stable
Date: Tue,  1 Sep 2026 13:23:18 -0700
Message-ID: <20260901203217.1485915-20-stephen@networkplumber.org>
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

  22.07  rte_eth_rx_avail_thresh_set, rte_eth_rx_avail_thresh_query
  23.03  rte_eth_dev_count_aggr_ports,
         rte_eth_dev_map_aggr_tx_affinity
  23.07  rte_eth_rx_queue_is_valid, rte_eth_tx_queue_is_valid
  23.11  rte_eth_recycle_rx_queue_info_get

None of these has changed since it was introduced.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  6 +++++
 lib/ethdev/rte_ethdev.c                | 14 ++++++------
 lib/ethdev/rte_ethdev.h                | 31 --------------------------
 3 files changed, 13 insertions(+), 38 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 01030cefe5..b23ffa6cb0 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -145,6 +145,12 @@ API Changes
   * speed lanes:
     ``rte_eth_speed_lanes_get``, ``rte_eth_speed_lanes_set`` and
     ``rte_eth_speed_lanes_get_capability``
+  * queue helpers:
+    ``rte_eth_rx_queue_is_valid``, ``rte_eth_tx_queue_is_valid``,
+    ``rte_eth_rx_avail_thresh_set``, ``rte_eth_rx_avail_thresh_query``,
+    ``rte_eth_recycle_rx_queue_info_get``,
+    ``rte_eth_dev_count_aggr_ports`` and
+    ``rte_eth_dev_map_aggr_tx_affinity``
 
 
 ABI Changes
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 783fb817c2..4c675f1f22 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -839,7 +839,7 @@ eth_dev_validate_tx_queue(const struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_queue_is_valid, 23.07)
+RTE_EXPORT_SYMBOL(rte_eth_rx_queue_is_valid)
 int
 rte_eth_rx_queue_is_valid(uint16_t port_id, uint16_t queue_id)
 {
@@ -851,7 +851,7 @@ rte_eth_rx_queue_is_valid(uint16_t port_id, uint16_t queue_id)
 	return eth_dev_validate_rx_queue(dev, queue_id);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_tx_queue_is_valid, 23.07)
+RTE_EXPORT_SYMBOL(rte_eth_tx_queue_is_valid)
 int
 rte_eth_tx_queue_is_valid(uint16_t port_id, uint16_t queue_id)
 {
@@ -5737,7 +5737,7 @@ int rte_eth_get_queue_rate_limit(uint16_t port_id, uint16_t queue_idx,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_avail_thresh_set, 22.07)
+RTE_EXPORT_SYMBOL(rte_eth_rx_avail_thresh_set)
 int rte_eth_rx_avail_thresh_set(uint16_t port_id, uint16_t queue_id,
 			       uint8_t avail_thresh)
 {
@@ -5770,7 +5770,7 @@ int rte_eth_rx_avail_thresh_set(uint16_t port_id, uint16_t queue_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_avail_thresh_query, 22.07)
+RTE_EXPORT_SYMBOL(rte_eth_rx_avail_thresh_query)
 int rte_eth_rx_avail_thresh_query(uint16_t port_id, uint16_t *queue_id,
 				 uint8_t *avail_thresh)
 {
@@ -6456,7 +6456,7 @@ rte_eth_tx_queue_info_get(uint16_t port_id, uint16_t queue_id,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_recycle_rx_queue_info_get, 23.11)
+RTE_EXPORT_SYMBOL(rte_eth_recycle_rx_queue_info_get)
 int
 rte_eth_recycle_rx_queue_info_get(uint16_t port_id, uint16_t queue_id,
 		struct rte_eth_recycle_rxq_info *recycle_rxq_info)
@@ -7429,7 +7429,7 @@ rte_eth_buffer_split_get_supported_hdr_ptypes(uint16_t port_id, uint32_t *ptypes
 	return j;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_count_aggr_ports, 23.03)
+RTE_EXPORT_SYMBOL(rte_eth_dev_count_aggr_ports)
 int rte_eth_dev_count_aggr_ports(uint16_t port_id)
 {
 	struct rte_eth_dev *dev;
@@ -7447,7 +7447,7 @@ int rte_eth_dev_count_aggr_ports(uint16_t port_id)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_map_aggr_tx_affinity, 23.03)
+RTE_EXPORT_SYMBOL(rte_eth_dev_map_aggr_tx_affinity)
 int rte_eth_dev_map_aggr_tx_affinity(uint16_t port_id, uint16_t tx_queue_id,
 				     uint8_t affinity)
 {
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index dfb9cfd614..d18afa20c6 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -1913,9 +1913,6 @@ struct __rte_cache_min_aligned rte_eth_txq_info {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice.
- *
  * Ethernet device Rx queue information structure for recycling mbufs.
  * Used to retrieve Rx queue information when Tx queue reusing mbufs and moving
  * them into Rx mbuf ring.
@@ -2685,9 +2682,6 @@ int rte_eth_hairpin_bind(uint16_t tx_port, uint16_t rx_port);
 int rte_eth_hairpin_unbind(uint16_t tx_port, uint16_t rx_port);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  *  Get the number of aggregated ports of the DPDK port (specified with port_id).
  *  It is used when multiple ports are aggregated into a single one.
  *
@@ -2699,13 +2693,9 @@ int rte_eth_hairpin_unbind(uint16_t tx_port, uint16_t rx_port);
  * @return
  *   - (>=0) the number of aggregated port if success.
  */
-__rte_experimental
 int rte_eth_dev_count_aggr_ports(uint16_t port_id);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  *  Map a Tx queue with an aggregated port of the DPDK port (specified with port_id).
  *  When multiple ports are aggregated into a single one,
  *  it allows choosing which port to use for Tx via a queue.
@@ -2729,7 +2719,6 @@ int rte_eth_dev_count_aggr_ports(uint16_t port_id);
  * @return
  *   Zero if successful. Non-zero otherwise.
  */
-__rte_experimental
 int rte_eth_dev_map_aggr_tx_affinity(uint16_t port_id, uint16_t tx_queue_id,
 				     uint8_t affinity);
 
@@ -2759,9 +2748,6 @@ int rte_eth_dev_socket_id(uint16_t port_id);
 int rte_eth_dev_is_valid_port(uint16_t port_id);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice.
- *
  * Check if Rx queue is valid.
  * If the queue has been setup, it is considered valid.
  *
@@ -2774,13 +2760,9 @@ int rte_eth_dev_is_valid_port(uint16_t port_id);
  *   - -EINVAL: if queue_id is out of range or queue has not been setup.
  *   - 0 if Rx queue is valid.
  */
-__rte_experimental
 int rte_eth_rx_queue_is_valid(uint16_t port_id, uint16_t queue_id);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice.
- *
  * Check if Tx queue is valid.
  * If the queue has been setup, it is considered valid.
  *
@@ -2793,7 +2775,6 @@ int rte_eth_rx_queue_is_valid(uint16_t port_id, uint16_t queue_id);
  *   - -EINVAL: if queue_id is out of range or queue has not been setup.
  *   - 0 if Tx queue is valid.
  */
-__rte_experimental
 int rte_eth_tx_queue_is_valid(uint16_t port_id, uint16_t queue_id);
 
 /**
@@ -3791,9 +3772,6 @@ int rte_eth_dev_get_vlan_offload(uint16_t port_id);
 int rte_eth_dev_set_vlan_pvid(uint16_t port_id, uint16_t pvid, int on);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Set Rx queue available descriptors threshold.
  *
  * @param port_id
@@ -3815,14 +3793,10 @@ int rte_eth_dev_set_vlan_pvid(uint16_t port_id, uint16_t pvid, int on);
  *   - (-ENOTSUP) if available Rx descriptors threshold is not supported.
  *   - (-EIO) if device is removed.
  */
-__rte_experimental
 int rte_eth_rx_avail_thresh_set(uint16_t port_id, uint16_t queue_id,
 			       uint8_t avail_thresh);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Find Rx queue with RTE_ETH_EVENT_RX_AVAIL_THRESH event pending.
  *
  * @param port_id
@@ -3845,7 +3819,6 @@ int rte_eth_rx_avail_thresh_set(uint16_t port_id, uint16_t queue_id,
  *   - (-ENOTSUP) if operation is not supported.
  *   - (-EIO) if device is removed.
  */
-__rte_experimental
 int rte_eth_rx_avail_thresh_query(uint16_t port_id, uint16_t *queue_id,
 				 uint8_t *avail_thresh);
 
@@ -5103,9 +5076,6 @@ int rte_eth_tx_queue_info_get(uint16_t port_id, uint16_t queue_id,
 	struct rte_eth_txq_info *qinfo);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Retrieve information about given ports's Rx queue for recycling mbufs.
  *
  * @param port_id
@@ -5122,7 +5092,6 @@ int rte_eth_tx_queue_info_get(uint16_t port_id, uint16_t queue_id,
  *   - -ENOTSUP: routine is not supported by the device PMD.
  *   - -EINVAL:  The queue_id is out of range.
  */
-__rte_experimental
 int rte_eth_recycle_rx_queue_info_get(uint16_t port_id,
 		uint16_t queue_id,
 		struct rte_eth_recycle_rxq_info *recycle_rxq_info);
-- 
2.53.0

