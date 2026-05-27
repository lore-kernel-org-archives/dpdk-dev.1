Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24CECD5BD5
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 14:44:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA42A4027D;
	Wed, 27 May 2026 16:44:12 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 009944026C
 for <dev@dpdk.org>; Wed, 27 May 2026 16:44:11 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-30455f77e0eso2085268eec.0
 for <dev@dpdk.org>; Wed, 27 May 2026 07:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779893051;
 x=1780497851; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Pn2jzuo7q+V3z3GItXIdTMto3kpijvxl2eewrAz18ak=;
 b=kTnD1ikgzKd0PYHn/wTnkQKKWgbEmH0DeTBnCDV/U5dRGtbUdYwWqqo8raDxbbG9FK
 bDUcmAHYZPkoiVOIxuDApuOCJVdxWtJUuUfI1U8ylvIvgMUCFWeIOkipEmtAX914TWXS
 9ZVIzPrGoBuTvj4KSKnWaGM0b+mZSdMd6m/jLESSoiG+6QMVp1UjkrmUUJB8x0Cd85Ko
 Zx40k9udVTjNBwH2h1jFTNGvqjfvivGunVjcjxiZ+r7wZzdA15t1Z9cL/jN19iv9qMkY
 1Z91Pqt8eueAF8NMPqmEEv4NIRZ1b+G0gzOMw2dBYYiOrKGNj7NAv4XisNIXylJBMbjt
 3yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779893051; x=1780497851;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pn2jzuo7q+V3z3GItXIdTMto3kpijvxl2eewrAz18ak=;
 b=JMmGbGR+rZl8dpSg/a+IUzZKG/lR0JM9Un34FU3Bo0CExOV4LX/xY66Rhj/krO2JJz
 2eRBin56nW+/LHX+J4F0YeFzzxkdyBEWWWiOJ6rFBEfiIM9oH+Rcnx2a4I16f6rv/g1E
 GBMjKpto5XkPnL+2GTePMGzVQhlpYycHB3RhCnLZPOiMqpWKJZ24onnJoOTj8OeKhsIv
 lbl9aXHcX28BR8/mE0hQVhyagdbNWM/8zyIR+2l7dzm9kk8joGklTWw9iBMl4HVgSCgn
 sN34KOqV8jiRKNohcKxc1tiuHhr9WeUJlOr1eGCYnbwHNk3XsPVrbUDkpwk3rgm5CFE6
 8R+g==
X-Gm-Message-State: AOJu0YxnNWA47vLNiY1FZNS12OFIFvdqiN5fbicp7OnG8rBvqwQntx/l
 HE6miaUOG0yrdyGNzt1QhaNTklSi0byMntZ0KCECGpjOmSK/QfYT31Cw2shitJKPJuYGIrJflYd
 VDpU4
X-Gm-Gg: Acq92OFdjGbcCb8aPRp/VlHRuKfUGjiMKzFlwjFQkAwVhAvuWwMMXS9xoX2Zd4a3pjf
 V1Ah52LVA8Ivs1EGJ1YvsO/n6NJ3IAwdPl6sPMrFuHHcEaWk1hWpRLkh0croRxb/zv9iG7ZxI0I
 yGJAMtr46xM8bg2zqLi9bxrWXKZwovJY1mPVMAQj2y6c8t0XCzsTDZx1JXavl7CktyfL19E8mYs
 O3X3pFUmvx8e/PJI9BPTbNMu72EUpbL3dW0OUcsXjCHDdMj3H9+ugTm/9xHzpUsOAMO4OK+byY7
 jMmMdC7PK8jndkUIOxKrwivhnxQltXIB+mVdmABmSskRFfx6TdzLATcHqq5Y5aw3x1P4VEy2csR
 +jbKzYQvCfPwlcNs+oMgYJP5jwJ2mqMLQDuCxjUxlWvXyaSQkYxVBrEKpQ8we1F74vES22ee3SH
 FuD8eQQTRnHCTJYHOSC9kkj2HXZ8uOcxSHGk921RF4mzSpRXvBQ0PgcQHv6+obnw==
X-Received: by 2002:a05:7301:19a5:b0:2df:919f:ce59 with SMTP id
 5a478bee46e88-30449149c79mr11452857eec.19.1779893050319; 
 Wed, 27 May 2026 07:44:10 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3045225b7b6sm17459308eec.25.2026.05.27.07.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 07:44:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH] ethdev: promote experimental API's to stable
Date: Wed, 27 May 2026 07:44:07 -0700
Message-ID: <20260527144407.160830-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Several API's in ethdev have been marked as experimental
(some as old as 19.11). There is no firm policy but any API
that has been experimental for since the last LTS is good candidate
to be stable.

APIs added in 25.11 or later are left as experimental for
another release cycle.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_07.rst |  55 ++++++
 lib/ethdev/rte_ethdev.c                |  88 +++++-----
 lib/ethdev/rte_ethdev.h                | 233 -------------------------
 lib/ethdev/rte_ethdev_cman.c           |   8 +-
 4 files changed, 103 insertions(+), 281 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 1eac84895b..d1b1c0abc5 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -111,6 +111,61 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* **ethdev: promoted several APIs from experimental to stable.**
+
+  The following ethdev APIs are no longer marked experimental:
+
+  * ``rte_eth_buffer_split_get_supported_hdr_ptypes``
+  * ``rte_eth_cman_config_get``
+  * ``rte_eth_cman_config_init``
+  * ``rte_eth_cman_config_set``
+  * ``rte_eth_cman_info_get``
+  * ``rte_eth_dev_capability_name``
+  * ``rte_eth_dev_conf_get``
+  * ``rte_eth_dev_count_aggr_ports``
+  * ``rte_eth_dev_get_module_eeprom``
+  * ``rte_eth_dev_get_module_info``
+  * ``rte_eth_dev_get_reg_info_ext``
+  * ``rte_eth_dev_hairpin_capability_get``
+  * ``rte_eth_dev_map_aggr_tx_affinity``
+  * ``rte_eth_dev_priority_flow_ctrl_queue_configure``
+  * ``rte_eth_dev_priority_flow_ctrl_queue_info_get``
+  * ``rte_eth_dev_priv_dump``
+  * ``rte_eth_dev_rss_algo_name``
+  * ``rte_eth_fec_get``
+  * ``rte_eth_fec_get_capability``
+  * ``rte_eth_fec_set``
+  * ``rte_eth_find_rss_algo``
+  * ``rte_eth_get_monitor_addr``
+  * ``rte_eth_hairpin_bind``
+  * ``rte_eth_hairpin_get_peer_ports``
+  * ``rte_eth_hairpin_unbind``
+  * ``rte_eth_ip_reassembly_capability_get``
+  * ``rte_eth_ip_reassembly_conf_get``
+  * ``rte_eth_ip_reassembly_conf_set``
+  * ``rte_eth_link_speed_to_str``
+  * ``rte_eth_link_to_str``
+  * ``rte_eth_macaddrs_get``
+  * ``rte_eth_read_clock``
+  * ``rte_eth_recycle_mbufs``
+  * ``rte_eth_recycle_rx_queue_info_get``
+  * ``rte_eth_representor_info_get``
+  * ``rte_eth_rx_avail_thresh_query``
+  * ``rte_eth_rx_avail_thresh_set``
+  * ``rte_eth_rx_descriptor_dump``
+  * ``rte_eth_rx_hairpin_queue_setup``
+  * ``rte_eth_rx_queue_is_valid``
+  * ``rte_eth_speed_lanes_get``
+  * ``rte_eth_speed_lanes_get_capability``
+  * ``rte_eth_speed_lanes_set``
+  * ``rte_eth_timesync_adjust_freq``
+  * ``rte_eth_tx_descriptor_dump``
+  * ``rte_eth_tx_hairpin_queue_setup``
+  * ``rte_eth_tx_queue_count``
+  * ``rte_eth_tx_queue_is_valid``
+  * ``rte_eth_xstats_query_state``
+  * ``rte_eth_xstats_set_counter``
+
 
 ABI Changes
 -----------
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 2edc7a362e..9ba84a6e5e 100644
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
@@ -1171,7 +1171,7 @@ eth_dev_offload_names(uint64_t bitmask, char *buf, size_t size,
 	return buf;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_capability_name, 21.11)
+RTE_EXPORT_SYMBOL(rte_eth_dev_capability_name)
 const char *
 rte_eth_dev_capability_name(uint64_t capability)
 {
@@ -1929,7 +1929,7 @@ rte_eth_dev_set_link_down(uint16_t port_id)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_speed_lanes_get, 24.11)
+RTE_EXPORT_SYMBOL(rte_eth_speed_lanes_get)
 int
 rte_eth_speed_lanes_get(uint16_t port_id, uint32_t *lane)
 {
@@ -1943,7 +1943,7 @@ rte_eth_speed_lanes_get(uint16_t port_id, uint32_t *lane)
 	return eth_err(port_id, dev->dev_ops->speed_lanes_get(dev, lane));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_speed_lanes_get_capability, 24.11)
+RTE_EXPORT_SYMBOL(rte_eth_speed_lanes_get_capability)
 int
 rte_eth_speed_lanes_get_capability(uint16_t port_id,
 				   struct rte_eth_speed_lanes_capa *speed_lanes_capa,
@@ -1970,7 +1970,7 @@ rte_eth_speed_lanes_get_capability(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_speed_lanes_set, 24.11)
+RTE_EXPORT_SYMBOL(rte_eth_speed_lanes_set)
 int
 rte_eth_speed_lanes_set(uint16_t port_id, uint32_t speed_lanes_capa)
 {
@@ -2498,7 +2498,7 @@ rte_eth_rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 	return eth_err(port_id, ret);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_hairpin_queue_setup, 19.11)
+RTE_EXPORT_SYMBOL(rte_eth_rx_hairpin_queue_setup)
 int
 rte_eth_rx_hairpin_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 			       uint16_t nb_rx_desc,
@@ -2716,7 +2716,7 @@ rte_eth_tx_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
 		       tx_queue_id, nb_tx_desc, socket_id, &local_conf));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_tx_hairpin_queue_setup, 19.11)
+RTE_EXPORT_SYMBOL(rte_eth_tx_hairpin_queue_setup)
 int
 rte_eth_tx_hairpin_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
 			       uint16_t nb_tx_desc,
@@ -2816,7 +2816,7 @@ rte_eth_tx_hairpin_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_hairpin_bind, 20.11)
+RTE_EXPORT_SYMBOL(rte_eth_hairpin_bind)
 int
 rte_eth_hairpin_bind(uint16_t tx_port, uint16_t rx_port)
 {
@@ -2844,7 +2844,7 @@ rte_eth_hairpin_bind(uint16_t tx_port, uint16_t rx_port)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_hairpin_unbind, 20.11)
+RTE_EXPORT_SYMBOL(rte_eth_hairpin_unbind)
 int
 rte_eth_hairpin_unbind(uint16_t tx_port, uint16_t rx_port)
 {
@@ -2872,7 +2872,7 @@ rte_eth_hairpin_unbind(uint16_t tx_port, uint16_t rx_port)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_hairpin_get_peer_ports, 20.11)
+RTE_EXPORT_SYMBOL(rte_eth_hairpin_get_peer_ports)
 int
 rte_eth_hairpin_get_peer_ports(uint16_t port_id, uint16_t *peer_ports,
 			       size_t len, uint32_t direction)
@@ -3200,7 +3200,7 @@ rte_eth_link_get_nowait(uint16_t port_id, struct rte_eth_link *eth_link)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_link_speed_to_str, 20.11)
+RTE_EXPORT_SYMBOL(rte_eth_link_speed_to_str)
 const char *
 rte_eth_link_speed_to_str(uint32_t link_speed)
 {
@@ -3267,7 +3267,7 @@ rte_eth_link_speed_to_str(uint32_t link_speed)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_link_to_str, 20.11)
+RTE_EXPORT_SYMBOL(rte_eth_link_to_str)
 int
 rte_eth_link_to_str(char *str, size_t len, const struct rte_eth_link *eth_link)
 {
@@ -3946,7 +3946,7 @@ rte_eth_xstats_reset(uint16_t port_id)
 	return rte_eth_stats_reset(port_id);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_xstats_set_counter, 25.03)
+RTE_EXPORT_SYMBOL(rte_eth_xstats_set_counter)
 int
 rte_eth_xstats_set_counter(uint16_t port_id, uint64_t id, int on_off)
 {
@@ -3976,7 +3976,7 @@ rte_eth_xstats_set_counter(uint16_t port_id, uint64_t id, int on_off)
 }
 
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_xstats_query_state, 25.03)
+RTE_EXPORT_SYMBOL(rte_eth_xstats_query_state)
 int
 rte_eth_xstats_query_state(uint16_t port_id, uint64_t id)
 {
@@ -4145,7 +4145,7 @@ rte_eth_dev_info_get(uint16_t port_id, struct rte_eth_dev_info *dev_info)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_conf_get, 21.11)
+RTE_EXPORT_SYMBOL(rte_eth_dev_conf_get)
 int
 rte_eth_dev_conf_get(uint16_t port_id, struct rte_eth_conf *dev_conf)
 {
@@ -4306,7 +4306,7 @@ rte_eth_dev_set_ptypes(uint16_t port_id, uint32_t ptype_mask,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_macaddrs_get, 21.11)
+RTE_EXPORT_SYMBOL(rte_eth_macaddrs_get)
 int
 rte_eth_macaddrs_get(uint16_t port_id, struct rte_ether_addr *ma,
 	unsigned int num)
@@ -4805,7 +4805,7 @@ validate_tx_pause_config(struct rte_eth_dev_info *dev_info, uint8_t tc_max,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_priority_flow_ctrl_queue_info_get, 22.03)
+RTE_EXPORT_SYMBOL(rte_eth_dev_priority_flow_ctrl_queue_info_get)
 int
 rte_eth_dev_priority_flow_ctrl_queue_info_get(uint16_t port_id,
 		struct rte_eth_pfc_queue_info *pfc_queue_info)
@@ -4833,7 +4833,7 @@ rte_eth_dev_priority_flow_ctrl_queue_info_get(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_priority_flow_ctrl_queue_configure, 22.03)
+RTE_EXPORT_SYMBOL(rte_eth_dev_priority_flow_ctrl_queue_configure)
 int
 rte_eth_dev_priority_flow_ctrl_queue_configure(uint16_t port_id,
 		struct rte_eth_pfc_queue_conf *pfc_queue_conf)
@@ -5147,7 +5147,7 @@ rte_eth_dev_rss_hash_conf_get(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_rss_algo_name, 23.11)
+RTE_EXPORT_SYMBOL(rte_eth_dev_rss_algo_name)
 const char *
 rte_eth_dev_rss_algo_name(enum rte_eth_hash_function rss_algo)
 {
@@ -5162,7 +5162,7 @@ rte_eth_dev_rss_algo_name(enum rte_eth_hash_function rss_algo)
 	return name;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_find_rss_algo, 24.03)
+RTE_EXPORT_SYMBOL(rte_eth_find_rss_algo)
 int
 rte_eth_find_rss_algo(const char *name, uint32_t *algo)
 {
@@ -5280,7 +5280,7 @@ rte_eth_led_off(uint16_t port_id)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_fec_get_capability, 20.11)
+RTE_EXPORT_SYMBOL(rte_eth_fec_get_capability)
 int
 rte_eth_fec_get_capability(uint16_t port_id,
 			   struct rte_eth_fec_capa *speed_fec_capa,
@@ -5308,7 +5308,7 @@ rte_eth_fec_get_capability(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_fec_get, 20.11)
+RTE_EXPORT_SYMBOL(rte_eth_fec_get)
 int
 rte_eth_fec_get(uint16_t port_id, uint32_t *fec_capa)
 {
@@ -5334,7 +5334,7 @@ rte_eth_fec_get(uint16_t port_id, uint32_t *fec_capa)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_fec_set, 20.11)
+RTE_EXPORT_SYMBOL(rte_eth_fec_set)
 int
 rte_eth_fec_set(uint16_t port_id, uint32_t fec_capa)
 {
@@ -5694,7 +5694,7 @@ int rte_eth_set_queue_rate_limit(uint16_t port_id, uint16_t queue_idx,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_avail_thresh_set, 22.07)
+RTE_EXPORT_SYMBOL(rte_eth_rx_avail_thresh_set)
 int rte_eth_rx_avail_thresh_set(uint16_t port_id, uint16_t queue_id,
 			       uint8_t avail_thresh)
 {
@@ -5727,7 +5727,7 @@ int rte_eth_rx_avail_thresh_set(uint16_t port_id, uint16_t queue_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_avail_thresh_query, 22.07)
+RTE_EXPORT_SYMBOL(rte_eth_rx_avail_thresh_query)
 int rte_eth_rx_avail_thresh_query(uint16_t port_id, uint16_t *queue_id,
 				 uint8_t *avail_thresh)
 {
@@ -6413,7 +6413,7 @@ rte_eth_tx_queue_info_get(uint16_t port_id, uint16_t queue_id,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_recycle_rx_queue_info_get, 23.11)
+RTE_EXPORT_SYMBOL(rte_eth_recycle_rx_queue_info_get)
 int
 rte_eth_recycle_rx_queue_info_get(uint16_t port_id, uint16_t queue_id,
 		struct rte_eth_recycle_rxq_info *recycle_rxq_info)
@@ -6504,7 +6504,7 @@ rte_eth_tx_burst_mode_get(uint16_t port_id, uint16_t queue_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_get_monitor_addr, 21.02)
+RTE_EXPORT_SYMBOL(rte_eth_get_monitor_addr)
 int
 rte_eth_get_monitor_addr(uint16_t port_id, uint16_t queue_id,
 		struct rte_power_monitor_cond *pmc)
@@ -6675,7 +6675,7 @@ rte_eth_timesync_adjust_time(uint16_t port_id, int64_t delta)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_adjust_freq, 24.11)
+RTE_EXPORT_SYMBOL(rte_eth_timesync_adjust_freq)
 int
 rte_eth_timesync_adjust_freq(uint16_t port_id, int64_t ppm)
 {
@@ -6746,7 +6746,7 @@ rte_eth_timesync_write_time(uint16_t port_id, const struct timespec *timestamp)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_read_clock, 19.08)
+RTE_EXPORT_SYMBOL(rte_eth_read_clock)
 int
 rte_eth_read_clock(uint16_t port_id, uint64_t *clock)
 {
@@ -6802,7 +6802,7 @@ rte_eth_dev_get_reg_info(uint16_t port_id, struct rte_dev_reg_info *info)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_get_reg_info_ext, 24.11)
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_reg_info_ext)
 int
 rte_eth_dev_get_reg_info_ext(uint16_t port_id, struct rte_dev_reg_info *info)
 {
@@ -6909,7 +6909,7 @@ rte_eth_dev_set_eeprom(uint16_t port_id, struct rte_dev_eeprom_info *info)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_get_module_info, 18.05)
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_module_info)
 int
 rte_eth_dev_get_module_info(uint16_t port_id,
 			    struct rte_eth_dev_module_info *modinfo)
@@ -6936,7 +6936,7 @@ rte_eth_dev_get_module_info(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_get_module_eeprom, 18.05)
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_module_eeprom)
 int
 rte_eth_dev_get_module_eeprom(uint16_t port_id,
 			      struct rte_dev_eeprom_info *info)
@@ -7051,7 +7051,7 @@ rte_eth_dev_adjust_nb_rx_tx_desc(uint16_t port_id,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_hairpin_capability_get, 19.11)
+RTE_EXPORT_SYMBOL(rte_eth_dev_hairpin_capability_get)
 int
 rte_eth_dev_hairpin_capability_get(uint16_t port_id,
 				   struct rte_eth_hairpin_cap *cap)
@@ -7106,7 +7106,7 @@ rte_eth_dev_pool_ops_supported(uint16_t port_id, const char *pool)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_representor_info_get, 21.05)
+RTE_EXPORT_SYMBOL(rte_eth_representor_info_get)
 int
 rte_eth_representor_info_get(uint16_t port_id,
 			     struct rte_eth_representor_info *info)
@@ -7162,7 +7162,7 @@ rte_eth_rx_metadata_negotiate(uint16_t port_id, uint64_t *features)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_ip_reassembly_capability_get, 22.03)
+RTE_EXPORT_SYMBOL(rte_eth_ip_reassembly_capability_get)
 int
 rte_eth_ip_reassembly_capability_get(uint16_t port_id,
 		struct rte_eth_ip_reassembly_params *reassembly_capa)
@@ -7198,7 +7198,7 @@ rte_eth_ip_reassembly_capability_get(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_ip_reassembly_conf_get, 22.03)
+RTE_EXPORT_SYMBOL(rte_eth_ip_reassembly_conf_get)
 int
 rte_eth_ip_reassembly_conf_get(uint16_t port_id,
 		struct rte_eth_ip_reassembly_params *conf)
@@ -7232,7 +7232,7 @@ rte_eth_ip_reassembly_conf_get(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_ip_reassembly_conf_set, 22.03)
+RTE_EXPORT_SYMBOL(rte_eth_ip_reassembly_conf_set)
 int
 rte_eth_ip_reassembly_conf_set(uint16_t port_id,
 		const struct rte_eth_ip_reassembly_params *conf)
@@ -7273,7 +7273,7 @@ rte_eth_ip_reassembly_conf_set(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_priv_dump, 22.03)
+RTE_EXPORT_SYMBOL(rte_eth_dev_priv_dump)
 int
 rte_eth_dev_priv_dump(uint16_t port_id, FILE *file)
 {
@@ -7292,7 +7292,7 @@ rte_eth_dev_priv_dump(uint16_t port_id, FILE *file)
 	return eth_err(port_id, dev->dev_ops->eth_dev_priv_dump(dev, file));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_descriptor_dump, 22.11)
+RTE_EXPORT_SYMBOL(rte_eth_rx_descriptor_dump)
 int
 rte_eth_rx_descriptor_dump(uint16_t port_id, uint16_t queue_id,
 			   uint16_t offset, uint16_t num, FILE *file)
@@ -7319,7 +7319,7 @@ rte_eth_rx_descriptor_dump(uint16_t port_id, uint16_t queue_id,
 		       dev->dev_ops->eth_rx_descriptor_dump(dev, queue_id, offset, num, file));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_tx_descriptor_dump, 22.11)
+RTE_EXPORT_SYMBOL(rte_eth_tx_descriptor_dump)
 int
 rte_eth_tx_descriptor_dump(uint16_t port_id, uint16_t queue_id,
 			   uint16_t offset, uint16_t num, FILE *file)
@@ -7346,7 +7346,7 @@ rte_eth_tx_descriptor_dump(uint16_t port_id, uint16_t queue_id,
 		       dev->dev_ops->eth_tx_descriptor_dump(dev, queue_id, offset, num, file));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_buffer_split_get_supported_hdr_ptypes, 22.11)
+RTE_EXPORT_SYMBOL(rte_eth_buffer_split_get_supported_hdr_ptypes)
 int
 rte_eth_buffer_split_get_supported_hdr_ptypes(uint16_t port_id, uint32_t *ptypes, int num)
 {
@@ -7386,7 +7386,7 @@ rte_eth_buffer_split_get_supported_hdr_ptypes(uint16_t port_id, uint32_t *ptypes
 	return j;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_count_aggr_ports, 23.03)
+RTE_EXPORT_SYMBOL(rte_eth_dev_count_aggr_ports)
 int rte_eth_dev_count_aggr_ports(uint16_t port_id)
 {
 	struct rte_eth_dev *dev;
@@ -7404,7 +7404,7 @@ int rte_eth_dev_count_aggr_ports(uint16_t port_id)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_map_aggr_tx_affinity, 23.03)
+RTE_EXPORT_SYMBOL(rte_eth_dev_map_aggr_tx_affinity)
 int rte_eth_dev_map_aggr_tx_affinity(uint16_t port_id, uint16_t tx_queue_id,
 				     uint8_t affinity)
 {
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 0d8e2d0236..0381f8317a 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -1061,9 +1061,6 @@ struct rte_eth_txmode {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice.
- *
  * A structure used to configure an Rx packet segment to split.
  *
  * If RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT flag is set in offloads field,
@@ -1139,9 +1136,6 @@ struct rte_eth_rxseg_split {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice.
- *
  * A common structure used to describe Rx packet segment properties.
  */
 union rte_eth_rxseg {
@@ -1230,9 +1224,6 @@ struct rte_eth_txconf {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * A structure used to return the Tx or Rx hairpin queue capabilities.
  */
 struct rte_eth_hairpin_queue_cap {
@@ -1252,9 +1243,6 @@ struct rte_eth_hairpin_queue_cap {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * A structure used to return the hairpin capabilities that are supported.
  */
 struct rte_eth_hairpin_cap {
@@ -1272,9 +1260,6 @@ struct rte_eth_hairpin_cap {
 #define RTE_ETH_MAX_HAIRPIN_PEERS 32
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * A structure used to hold hairpin peer data.
  */
 struct rte_eth_hairpin_peer {
@@ -1283,9 +1268,6 @@ struct rte_eth_hairpin_peer {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * A structure used to configure hairpin binding.
  */
 struct rte_eth_hairpin_conf {
@@ -1426,9 +1408,6 @@ struct rte_eth_pfc_conf {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * A structure used to retrieve information of queue based PFC.
  */
 struct rte_eth_pfc_queue_info {
@@ -1441,9 +1420,6 @@ struct rte_eth_pfc_queue_info {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * A structure used to configure Ethernet priority flow control parameters for
  * ethdev queues.
  *
@@ -1748,9 +1724,6 @@ struct rte_eth_switch_info {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice.
- *
  * Ethernet device Rx buffer segmentation capabilities.
  */
 struct rte_eth_rxseg_capa {
@@ -1777,9 +1750,6 @@ enum rte_eth_representor_type {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this enumeration may change without prior notice.
- *
  * Ethernet device error handling mode.
  */
 enum rte_eth_err_handle_mode {
@@ -1918,9 +1888,6 @@ struct __rte_cache_min_aligned rte_eth_txq_info {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice.
- *
  * Ethernet device Rx queue information structure for recycling mbufs.
  * Used to retrieve Rx queue information when Tx queue reusing mbufs and moving
  * them into Rx mbuf ring.
@@ -2384,9 +2351,6 @@ const char *rte_eth_dev_rx_offload_name(uint64_t offload);
 const char *rte_eth_dev_tx_offload_name(uint64_t offload);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Get RTE_ETH_DEV_CAPA_* flag name.
  *
  * @param capability
@@ -2394,7 +2358,6 @@ const char *rte_eth_dev_tx_offload_name(uint64_t offload);
  * @return
  *   Capability name or 'UNKNOWN' if the flag cannot be recognized.
  */
-__rte_experimental
 const char *rte_eth_dev_capability_name(uint64_t capability);
 
 /**
@@ -2518,9 +2481,6 @@ int rte_eth_rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 		struct rte_mempool *mb_pool);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Allocate and set up a hairpin receive queue for an Ethernet device.
  *
  * The function set up the selected queue to be used in hairpin.
@@ -2544,7 +2504,6 @@ int rte_eth_rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
  *   - (-EINVAL) if bad parameter.
  *   - (-ENOMEM) if unable to allocate the resources.
  */
-__rte_experimental
 int rte_eth_rx_hairpin_queue_setup
 	(uint16_t port_id, uint16_t rx_queue_id, uint16_t nb_rx_desc,
 	 const struct rte_eth_hairpin_conf *conf);
@@ -2602,9 +2561,6 @@ int rte_eth_tx_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
 		const struct rte_eth_txconf *tx_conf);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Allocate and set up a transmit hairpin queue for an Ethernet device.
  *
  * @param port_id
@@ -2626,15 +2582,11 @@ int rte_eth_tx_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
  *   - (-EINVAL) if bad parameter.
  *   - (-ENOMEM) if unable to allocate the resources.
  */
-__rte_experimental
 int rte_eth_tx_hairpin_queue_setup
 	(uint16_t port_id, uint16_t tx_queue_id, uint16_t nb_tx_desc,
 	 const struct rte_eth_hairpin_conf *conf);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Get all the hairpin peer Rx / Tx ports of the current port.
  * The caller should ensure that the array is large enough to save the ports
  * list.
@@ -2657,14 +2609,10 @@ int rte_eth_tx_hairpin_queue_setup
  *   - (-ENOTSUP) if hardware doesn't support.
  *   - Others detailed errors from PMDs.
  */
-__rte_experimental
 int rte_eth_hairpin_get_peer_ports(uint16_t port_id, uint16_t *peer_ports,
 				   size_t len, uint32_t direction);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Bind all hairpin Tx queues of one port to the Rx queues of the peer port.
  * It is only allowed to call this function after all hairpin queues are
  * configured properly and the devices are in started state.
@@ -2683,13 +2631,9 @@ int rte_eth_hairpin_get_peer_ports(uint16_t port_id, uint16_t *peer_ports,
  *   - (-ENOTSUP) if hardware doesn't support.
  *   - Others detailed errors from PMDs.
  */
-__rte_experimental
 int rte_eth_hairpin_bind(uint16_t tx_port, uint16_t rx_port);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Unbind all hairpin Tx queues of one port from the Rx queues of the peer port.
  * This should be called before closing the Tx or Rx devices, if the bind
  * function is called before.
@@ -2710,13 +2654,9 @@ int rte_eth_hairpin_bind(uint16_t tx_port, uint16_t rx_port);
  *   - (-ENOTSUP) if hardware doesn't support.
  *   - Others detailed errors from PMDs.
  */
-__rte_experimental
 int rte_eth_hairpin_unbind(uint16_t tx_port, uint16_t rx_port);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  *  Get the number of aggregated ports of the DPDK port (specified with port_id).
  *  It is used when multiple ports are aggregated into a single one.
  *
@@ -2728,13 +2668,9 @@ int rte_eth_hairpin_unbind(uint16_t tx_port, uint16_t rx_port);
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
  *  it allows to choose which port to use for Tx via a queue.
@@ -2758,7 +2694,6 @@ int rte_eth_dev_count_aggr_ports(uint16_t port_id);
  * @return
  *   Zero if successful. Non-zero otherwise.
  */
-__rte_experimental
 int rte_eth_dev_map_aggr_tx_affinity(uint16_t port_id, uint16_t tx_queue_id,
 				     uint8_t affinity);
 
@@ -2788,9 +2723,6 @@ int rte_eth_dev_socket_id(uint16_t port_id);
 int rte_eth_dev_is_valid_port(uint16_t port_id);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice.
- *
  * Check if Rx queue is valid.
  * If the queue has been setup, it is considered valid.
  *
@@ -2803,13 +2735,9 @@ int rte_eth_dev_is_valid_port(uint16_t port_id);
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
@@ -2822,7 +2750,6 @@ int rte_eth_rx_queue_is_valid(uint16_t port_id, uint16_t queue_id);
  *   - -EINVAL: if queue_id is out of range or queue has not been setup.
  *   - 0 if Tx queue is valid.
  */
-__rte_experimental
 int rte_eth_tx_queue_is_valid(uint16_t port_id, uint16_t queue_id);
 
 /**
@@ -3129,9 +3056,6 @@ int rte_eth_link_get_nowait(uint16_t port_id, struct rte_eth_link *link)
 	__rte_warn_unused_result;
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * The function converts a link_speed to a string. It handles all special
  * values like unknown or none speed.
  *
@@ -3141,13 +3065,9 @@ int rte_eth_link_get_nowait(uint16_t port_id, struct rte_eth_link *link)
  *   Link speed in textual format. It's pointer to immutable memory.
  *   No free is required.
  */
-__rte_experimental
 const char *rte_eth_link_speed_to_str(uint32_t link_speed);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * This function converts an Ethernet link type to a string.
  *
  * @param link_connector
@@ -3159,9 +3079,6 @@ __rte_experimental
 const char *rte_eth_link_connector_to_str(enum rte_eth_link_connector link_connector);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * The function converts a rte_eth_link struct representing a link status to
  * a string.
  *
@@ -3176,14 +3093,10 @@ const char *rte_eth_link_connector_to_str(enum rte_eth_link_connector link_conne
  * @return
  *   Number of bytes written to str array or -EINVAL if bad parameter.
  */
-__rte_experimental
 int rte_eth_link_to_str(char *str, size_t len,
 			const struct rte_eth_link *eth_link);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Get Active lanes.
  *
  * @param port_id
@@ -3200,13 +3113,9 @@ int rte_eth_link_to_str(char *str, size_t len,
  *   - (-EIO) if device is removed.
  *   - (-ENODEV)  if *port_id* invalid.
  */
-__rte_experimental
 int rte_eth_speed_lanes_get(uint16_t port_id, uint32_t *lanes);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Set speed lanes supported by the NIC.
  *
  * @param port_id
@@ -3224,13 +3133,9 @@ int rte_eth_speed_lanes_get(uint16_t port_id, uint32_t *lanes);
  *   - (-ENODEV)  if *port_id* invalid.
  *   - (-EINVAL)  if *lanes* count not in speeds capability list.
  */
-__rte_experimental
 int rte_eth_speed_lanes_set(uint16_t port_id, uint32_t speed_lanes);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Get speed lanes supported by the NIC.
  *
  * @param port_id
@@ -3249,7 +3154,6 @@ int rte_eth_speed_lanes_set(uint16_t port_id, uint32_t speed_lanes);
  *   - (-ENODEV)  if *port_id* invalid.
  *   - (-EINVAL)  if *speed_lanes* invalid
  */
-__rte_experimental
 int rte_eth_speed_lanes_get_capability(uint16_t port_id,
 				       struct rte_eth_speed_lanes_capa *speed_lanes_capa,
 				       unsigned int num);
@@ -3447,7 +3351,6 @@ int rte_eth_xstats_get_id_by_name(uint16_t port_id, const char *xstat_name,
  *    - (-EPERM) enabling this counter is not permitted
  *    - (-ENOSPC) no resources
  */
-__rte_experimental
 int rte_eth_xstats_set_counter(uint16_t port_id, uint64_t id, int on_off);
 
 /**
@@ -3461,7 +3364,6 @@ int rte_eth_xstats_set_counter(uint16_t port_id, uint64_t id, int on_off);
  *    - (-ENOTSUP) enable/disabling is not implemented
  *    - (-EINVAL) xstat id is invalid
  */
-__rte_experimental
 int rte_eth_xstats_query_state(uint16_t port_id, uint64_t id);
 
 /**
@@ -3539,9 +3441,6 @@ int rte_eth_dev_set_rx_queue_stats_mapping(uint16_t port_id,
 int rte_eth_macaddr_get(uint16_t port_id, struct rte_ether_addr *mac_addr);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice
- *
  * Retrieve the Ethernet addresses of an Ethernet device.
  *
  * @param port_id
@@ -3558,7 +3457,6 @@ int rte_eth_macaddr_get(uint16_t port_id, struct rte_ether_addr *mac_addr);
  *   - (-ENODEV) if *port_id* invalid.
  *   - (-EINVAL) if bad parameter.
  */
-__rte_experimental
 int rte_eth_macaddrs_get(uint16_t port_id, struct rte_ether_addr *ma,
 	unsigned int num);
 
@@ -3585,9 +3483,6 @@ int rte_eth_dev_info_get(uint16_t port_id, struct rte_eth_dev_info *dev_info)
 	__rte_warn_unused_result;
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Retrieve the configuration of an Ethernet device.
  *
  * @param port_id
@@ -3599,7 +3494,6 @@ int rte_eth_dev_info_get(uint16_t port_id, struct rte_eth_dev_info *dev_info)
  *   - (-ENODEV) if *port_id* invalid.
  *   - (-EINVAL) if bad parameter.
  */
-__rte_experimental
 int rte_eth_dev_conf_get(uint16_t port_id, struct rte_eth_conf *dev_conf)
 	__rte_warn_unused_result;
 
@@ -3848,9 +3742,6 @@ int rte_eth_dev_get_vlan_offload(uint16_t port_id);
 int rte_eth_dev_set_vlan_pvid(uint16_t port_id, uint16_t pvid, int on);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Set Rx queue available descriptors threshold.
  *
  * @param port_id
@@ -3872,14 +3763,10 @@ int rte_eth_dev_set_vlan_pvid(uint16_t port_id, uint16_t pvid, int on);
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
@@ -3902,7 +3789,6 @@ int rte_eth_rx_avail_thresh_set(uint16_t port_id, uint16_t queue_id,
  *   - (-ENOTSUP) if operation is not supported.
  *   - (-EIO) if device is removed.
  */
-__rte_experimental
 int rte_eth_rx_avail_thresh_query(uint16_t port_id, uint16_t *queue_id,
 				 uint8_t *avail_thresh);
 
@@ -4474,9 +4360,6 @@ int  rte_eth_led_on(uint16_t port_id);
 int  rte_eth_led_off(uint16_t port_id);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Get Forward Error Correction(FEC) capability.
  *
  * @param port_id
@@ -4501,15 +4384,11 @@ int  rte_eth_led_off(uint16_t port_id);
  *   - (-ENODEV)  if *port_id* invalid.
  *   - (-EINVAL)  if *num* or *speed_fec_capa* invalid
  */
-__rte_experimental
 int rte_eth_fec_get_capability(uint16_t port_id,
 			       struct rte_eth_fec_capa *speed_fec_capa,
 			       unsigned int num);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Get current Forward Error Correction(FEC) mode.
  * If link is down and AUTO is enabled, AUTO is returned, otherwise,
  * configured FEC mode is returned.
@@ -4526,13 +4405,9 @@ int rte_eth_fec_get_capability(uint16_t port_id,
  *   - (-EIO) if device is removed.
  *   - (-ENODEV)  if *port_id* invalid.
  */
-__rte_experimental
 int rte_eth_fec_get(uint16_t port_id, uint32_t *fec_capa);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Set Forward Error Correction(FEC) mode.
  *
  * @param port_id
@@ -4552,7 +4427,6 @@ int rte_eth_fec_get(uint16_t port_id, uint32_t *fec_capa);
  *   - (-EIO) if device is removed.
  *   - (-ENODEV)  if *port_id* invalid.
  */
-__rte_experimental
 int rte_eth_fec_set(uint16_t port_id, uint32_t fec_capa);
 
 /**
@@ -4629,9 +4503,6 @@ int rte_eth_dev_mac_addr_add(uint16_t port_id, struct rte_ether_addr *mac_addr,
 				uint32_t pool);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Retrieve the information for queue based PFC.
  *
  * @param port_id
@@ -4645,14 +4516,10 @@ int rte_eth_dev_mac_addr_add(uint16_t port_id, struct rte_ether_addr *mac_addr,
  *   - (-ENODEV) if *port_id* invalid.
  *   - (-EINVAL) if bad parameter.
  */
-__rte_experimental
 int rte_eth_dev_priority_flow_ctrl_queue_info_get(uint16_t port_id,
 		struct rte_eth_pfc_queue_info *pfc_queue_info);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Configure the queue based priority flow control for a given queue
  * for Ethernet device.
  *
@@ -4672,7 +4539,6 @@ int rte_eth_dev_priority_flow_ctrl_queue_info_get(uint16_t port_id,
  *   - (-EINVAL)  if bad parameter
  *   - (-EIO)     if flow control setup queue failure
  */
-__rte_experimental
 int rte_eth_dev_priority_flow_ctrl_queue_configure(uint16_t port_id,
 		struct rte_eth_pfc_queue_conf *pfc_queue_conf);
 
@@ -4854,9 +4720,6 @@ rte_eth_dev_rss_hash_conf_get(uint16_t port_id,
 			      struct rte_eth_rss_conf *rss_conf);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice.
- *
  *  Get the name of RSS hash algorithm.
  *
  * @param rss_algo
@@ -4865,14 +4728,10 @@ rte_eth_dev_rss_hash_conf_get(uint16_t port_id,
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
@@ -4885,7 +4744,6 @@ rte_eth_dev_rss_algo_name(enum rte_eth_hash_function rss_algo);
  *   - (0) if successful.
  *   - (-EINVAL) if not found.
  */
-__rte_experimental
 int
 rte_eth_find_rss_algo(const char *name, uint32_t *algo);
 
@@ -5164,9 +5022,6 @@ int rte_eth_tx_queue_info_get(uint16_t port_id, uint16_t queue_id,
 	struct rte_eth_txq_info *qinfo);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Retrieve information about given ports's Rx queue for recycling mbufs.
  *
  * @param port_id
@@ -5183,7 +5038,6 @@ int rte_eth_tx_queue_info_get(uint16_t port_id, uint16_t queue_id,
  *   - -ENOTSUP: routine is not supported by the device PMD.
  *   - -EINVAL:  The queue_id is out of range.
  */
-__rte_experimental
 int rte_eth_recycle_rx_queue_info_get(uint16_t port_id,
 		uint16_t queue_id,
 		struct rte_eth_recycle_rxq_info *recycle_rxq_info);
@@ -5231,9 +5085,6 @@ int rte_eth_tx_burst_mode_get(uint16_t port_id, uint16_t queue_id,
 	struct rte_eth_burst_mode *mode);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Retrieve the monitor condition for a given receive queue.
  *
  * @param port_id
@@ -5250,7 +5101,6 @@ int rte_eth_tx_burst_mode_get(uint16_t port_id, uint16_t queue_id,
  *   -EINVAL: Invalid parameters.
  *   -ENODEV: Invalid port ID.
  */
-__rte_experimental
 int rte_eth_get_monitor_addr(uint16_t port_id, uint16_t queue_id,
 		struct rte_power_monitor_cond *pmc);
 
@@ -5280,7 +5130,6 @@ int rte_eth_get_monitor_addr(uint16_t port_id, uint16_t queue_id,
  *   - (-EIO) if device is removed.
  *   - others depends on the specific operations implementation.
  */
-__rte_experimental
 int rte_eth_dev_get_reg_info_ext(uint16_t port_id, struct rte_dev_reg_info *info);
 
 /**
@@ -5355,9 +5204,6 @@ int rte_eth_dev_get_eeprom(uint16_t port_id, struct rte_dev_eeprom_info *info);
 int rte_eth_dev_set_eeprom(uint16_t port_id, struct rte_dev_eeprom_info *info);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Retrieve the type and size of plugin module EEPROM
  *
  * @param port_id
@@ -5372,15 +5218,11 @@ int rte_eth_dev_set_eeprom(uint16_t port_id, struct rte_dev_eeprom_info *info);
  *   - (-EIO) if device is removed.
  *   - others depends on the specific operations implementation.
  */
-__rte_experimental
 int
 rte_eth_dev_get_module_info(uint16_t port_id, struct rte_eth_dev_module_info *modinfo)
 	__rte_warn_unused_result;
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Retrieve the data of plugin module EEPROM
  *
  * @param port_id
@@ -5396,7 +5238,6 @@ rte_eth_dev_get_module_info(uint16_t port_id, struct rte_eth_dev_module_info *mo
  *   - (-EIO) if device is removed.
  *   - others depends on the specific operations implementation.
  */
-__rte_experimental
 int
 rte_eth_dev_get_module_eeprom(uint16_t port_id, struct rte_dev_eeprom_info *info)
 	__rte_warn_unused_result;
@@ -5550,7 +5391,6 @@ int rte_eth_timesync_adjust_time(uint16_t port_id, int64_t delta);
  *   - -EIO: if device is removed.
  *   - -ENOTSUP: The function is not supported by the Ethernet driver.
  */
-__rte_experimental
 int rte_eth_timesync_adjust_freq(uint16_t port_id, int64_t ppm);
 
 /**
@@ -5591,9 +5431,6 @@ int rte_eth_timesync_read_time(uint16_t port_id, struct timespec *time);
 int rte_eth_timesync_write_time(uint16_t port_id, const struct timespec *time);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Read the current clock counter of an Ethernet device
  *
  * This returns the current raw clock value of an Ethernet device. It is
@@ -5635,7 +5472,6 @@ int rte_eth_timesync_write_time(uint16_t port_id, const struct timespec *time);
  *   - -ENOTSUP: The function is not supported by the Ethernet driver.
  *   - -EINVAL: if bad parameter.
  */
-__rte_experimental
 int
 rte_eth_read_clock(uint16_t port_id, uint64_t *clock);
 
@@ -5726,9 +5562,6 @@ void *
 rte_eth_dev_get_sec_ctx(uint16_t port_id);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Query the device hairpin capabilities.
  *
  * @param port_id
@@ -5740,14 +5573,10 @@ rte_eth_dev_get_sec_ctx(uint16_t port_id);
  *   - (-ENOTSUP) if hardware doesn't support.
  *   - (-EINVAL) if bad parameter.
  */
-__rte_experimental
 int rte_eth_dev_hairpin_capability_get(uint16_t port_id,
 				       struct rte_eth_hairpin_cap *cap);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice.
- *
  * Ethernet device representor ID range entry
  */
 struct rte_eth_representor_range {
@@ -5765,9 +5594,6 @@ struct rte_eth_representor_range {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice.
- *
  * Ethernet device representor information
  */
 struct rte_eth_representor_info {
@@ -5801,7 +5627,6 @@ struct rte_eth_representor_info {
  *   - (-EIO) if device is removed.
  *   - (>=0) number of available representor range entries.
  */
-__rte_experimental
 int rte_eth_representor_info_get(uint16_t port_id,
 				 struct rte_eth_representor_info *info);
 
@@ -5881,9 +5706,6 @@ struct rte_eth_ip_reassembly_params {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice
- *
  * Get IP reassembly capabilities supported by the PMD. This is the first API
  * to be called for enabling the IP reassembly offload feature. PMD will return
  * the maximum values of parameters that PMD can support and user can call
@@ -5900,14 +5722,10 @@ struct rte_eth_ip_reassembly_params {
  *   - (-EINVAL) if device is not configured or *capa* passed is NULL.
  *   - (0) on success.
  */
-__rte_experimental
 int rte_eth_ip_reassembly_capability_get(uint16_t port_id,
 		struct rte_eth_ip_reassembly_params *capa);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice
- *
  * Get IP reassembly configuration parameters currently set in PMD.
  * The API will return error if the configuration is not already
  * set using rte_eth_ip_reassembly_conf_set() before calling this API or if
@@ -5925,14 +5743,10 @@ int rte_eth_ip_reassembly_capability_get(uint16_t port_id,
  *              configuration is not set using rte_eth_ip_reassembly_conf_set().
  *   - (0) on success.
  */
-__rte_experimental
 int rte_eth_ip_reassembly_conf_get(uint16_t port_id,
 		struct rte_eth_ip_reassembly_params *conf);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice
- *
  * Set IP reassembly configuration parameters if the PMD supports IP reassembly
  * offload. User should first call rte_eth_ip_reassembly_capability_get() to
  * check the maximum values supported by the PMD before setting the
@@ -5958,7 +5772,6 @@ int rte_eth_ip_reassembly_conf_get(uint16_t port_id,
  *               successfully by the PMD.
  *   - (0) on success.
  */
-__rte_experimental
 int rte_eth_ip_reassembly_conf_set(uint16_t port_id,
 		const struct rte_eth_ip_reassembly_params *conf);
 
@@ -5982,9 +5795,6 @@ typedef struct {
 } rte_eth_ip_reassembly_dynfield_t;
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Dump private info from device to a file. Provided data and the order depends
  * on the PMD.
  *
@@ -5999,13 +5809,9 @@ typedef struct {
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
@@ -6025,14 +5831,10 @@ int rte_eth_dev_priv_dump(uint16_t port_id, FILE *file);
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
@@ -6052,7 +5854,6 @@ int rte_eth_rx_descriptor_dump(uint16_t port_id, uint16_t queue_id,
  *   - On success, zero.
  *   - On failure, a negative value.
  */
-__rte_experimental
 int rte_eth_tx_descriptor_dump(uint16_t port_id, uint16_t queue_id,
 			       uint16_t offset, uint16_t num, FILE *file);
 
@@ -6071,9 +5872,6 @@ enum rte_eth_cman_obj {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change, or be removed, without prior notice
- *
  * A structure used to retrieve information of ethdev congestion management.
  */
 struct rte_eth_cman_info {
@@ -6095,9 +5893,6 @@ struct rte_eth_cman_info {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this structure may change, or be removed, without prior notice
- *
  * A structure used to configure the ethdev congestion management.
  */
 struct rte_eth_cman_config {
@@ -6139,9 +5934,6 @@ struct rte_eth_cman_config {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Retrieve the information for ethdev congestion management
  *
  * @param port_id
@@ -6155,13 +5947,9 @@ struct rte_eth_cman_config {
  *   - (-ENODEV) if *port_id* invalid.
  *   - (-EINVAL) if bad parameter.
  */
-__rte_experimental
 int rte_eth_cman_info_get(uint16_t port_id, struct rte_eth_cman_info *info);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Initialize the ethdev congestion management configuration structure with default values.
  *
  * @param port_id
@@ -6175,13 +5963,9 @@ int rte_eth_cman_info_get(uint16_t port_id, struct rte_eth_cman_info *info);
  *   - (-ENODEV) if *port_id* invalid.
  *   - (-EINVAL) if bad parameter.
  */
-__rte_experimental
 int rte_eth_cman_config_init(uint16_t port_id, struct rte_eth_cman_config *config);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Configure ethdev congestion management
  *
  * @param port_id
@@ -6194,13 +5978,9 @@ int rte_eth_cman_config_init(uint16_t port_id, struct rte_eth_cman_config *confi
  *   - (-ENODEV) if *port_id* invalid.
  *   - (-EINVAL) if bad parameter.
  */
-__rte_experimental
 int rte_eth_cman_config_set(uint16_t port_id, const struct rte_eth_cman_config *config);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Retrieve the applied ethdev congestion management parameters for the given port.
  *
  * @param port_id
@@ -6217,7 +5997,6 @@ int rte_eth_cman_config_set(uint16_t port_id, const struct rte_eth_cman_config *
  *   - (-ENODEV) if *port_id* invalid.
  *   - (-EINVAL) if bad parameter.
  */
-__rte_experimental
 int rte_eth_cman_config_get(uint16_t port_id, struct rte_eth_cman_config *config);
 
 #ifdef __cplusplus
@@ -6949,9 +6728,6 @@ rte_eth_tx_buffer(uint16_t port_id, uint16_t queue_id,
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Recycle used mbufs from a transmit queue of an Ethernet device, and move
  * these mbufs into a mbuf ring for a receive queue of an Ethernet device.
  * This can bypass mempool path to save CPU cycles.
@@ -7001,7 +6777,6 @@ rte_eth_tx_buffer(uint16_t port_id, uint16_t queue_id,
  * @return
  *   The number of recycling mbufs.
  */
-__rte_experimental
 static inline uint16_t
 rte_eth_recycle_mbufs(uint16_t rx_port_id, uint16_t rx_queue_id,
 		uint16_t tx_port_id, uint16_t tx_queue_id,
@@ -7076,9 +6851,6 @@ rte_eth_recycle_mbufs(uint16_t rx_port_id, uint16_t rx_queue_id,
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice
- *
  * Get supported header protocols to split on Rx.
  *
  * When a packet type is announced to be split,
@@ -7103,14 +6875,10 @@ rte_eth_recycle_mbufs(uint16_t rx_port_id, uint16_t rx_queue_id,
  *   - (-ENODEV) if *port_id* invalid.
  *   - (-EINVAL) if bad parameter.
  */
-__rte_experimental
 int rte_eth_buffer_split_get_supported_hdr_ptypes(uint16_t port_id, uint32_t *ptypes, int num)
 	__rte_warn_unused_result;
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice.
- *
  * Get the number of used descriptors of a Tx queue.
  *
  * This function retrieves the number of used descriptors of a transmit queue.
@@ -7141,7 +6909,6 @@ int rte_eth_buffer_split_get_supported_hdr_ptypes(uint16_t port_id, uint32_t *pt
  * If the use case only involves checking the status of a specific descriptor slot,
  * opt for rte_eth_tx_descriptor_status() instead.
  */
-__rte_experimental
 static inline int
 rte_eth_tx_queue_count(uint16_t port_id, uint16_t queue_id)
 {
diff --git a/lib/ethdev/rte_ethdev_cman.c b/lib/ethdev/rte_ethdev_cman.c
index a8460e6977..3a62432bf0 100644
--- a/lib/ethdev/rte_ethdev_cman.c
+++ b/lib/ethdev/rte_ethdev_cman.c
@@ -12,7 +12,7 @@
 #include "ethdev_trace.h"
 
 /* Get congestion management information for a port */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_cman_info_get, 22.11)
+RTE_EXPORT_SYMBOL(rte_eth_cman_info_get)
 int
 rte_eth_cman_info_get(uint16_t port_id, struct rte_eth_cman_info *info)
 {
@@ -41,7 +41,7 @@ rte_eth_cman_info_get(uint16_t port_id, struct rte_eth_cman_info *info)
 }
 
 /* Initialize congestion management structure with default values */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_cman_config_init, 22.11)
+RTE_EXPORT_SYMBOL(rte_eth_cman_config_init)
 int
 rte_eth_cman_config_init(uint16_t port_id, struct rte_eth_cman_config *config)
 {
@@ -70,7 +70,7 @@ rte_eth_cman_config_init(uint16_t port_id, struct rte_eth_cman_config *config)
 }
 
 /* Configure congestion management on a port */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_cman_config_set, 22.11)
+RTE_EXPORT_SYMBOL(rte_eth_cman_config_set)
 int
 rte_eth_cman_config_set(uint16_t port_id, const struct rte_eth_cman_config *config)
 {
@@ -98,7 +98,7 @@ rte_eth_cman_config_set(uint16_t port_id, const struct rte_eth_cman_config *conf
 }
 
 /* Retrieve congestion management configuration of a port */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_cman_config_get, 22.11)
+RTE_EXPORT_SYMBOL(rte_eth_cman_config_get)
 int
 rte_eth_cman_config_get(uint16_t port_id, struct rte_eth_cman_config *config)
 {
-- 
2.53.0

