Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3FCC61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:34:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2411840E41;
	Tue,  1 Sep 2026 22:34:02 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id B567940ED9
 for <dev@dpdk.org>; Tue,  1 Sep 2026 22:34:00 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-853c947bfefso251458b3a.0
 for <dev@dpdk.org>; Tue, 01 Sep 2026 13:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788294840;
 x=1788899640; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yizQaFa4CEMxm5VkeDcPioJ3rxpHvDawx4Kr99ioJrc=;
 b=fi08vcLXPyMLik2iMgLaslhGhPdRdJMx3I/KihqYDpC5kAIItFp4SJbfIUeaHwyCj/
 +yK1l0jeqdH2qMbgFZZrNl6hrRRZ9TYfnpVeZpRZdvbwwEP7+EvhEm9oOO7N+SgCBLKM
 2uCHLEid6SL0UFieBKShMK19u7OcoV15Tef3eax4a6npQH271pviA4TYsE685o/577xR
 ravc/ijljqYjBiNr23u466tcGzGSr2Mth78ugmFTZ6LPjc2IvVlPlfGy/2lboiXryA/E
 f+QiDBpxZNYNsvLuMA2XEcW4SV2NhBV5OpBea+TUIQQxK8KTu9ILx55+ISgEtOhn7wgJ
 4FZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294840; x=1788899640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yizQaFa4CEMxm5VkeDcPioJ3rxpHvDawx4Kr99ioJrc=;
 b=mZoVa23oqG4u3ue2zMQBZoAfz0MHrVaIOo9gEg18OEeWyXliqcAc8d/gomsOW5tra/
 0tQv+x1fZMksuGhSp2+dNNmnU7BNI4bvWtv77rpMOCyH4YmhtM33beWNeKRZjZ/iqdJP
 jXnNbs7cUYQrv4kidkPtAE6qerudhZcirkWRyZNiLEVXz3eayQIiTJapbPW+1wuBxedy
 ZoTEGzdOG0zrpm+Q4GEd7RRV6r6QcldVHvPIYfunr2vsH1NYfszsM5aELXoB1YsZZk6z
 sQFfFGzRo6A+rggqMsME+8bC3J0vgiPRgylOLMPibs1TneF0Nm/Cq59yGF1NJKMzUi7I
 f5kw==
X-Gm-Message-State: AFuF++llSyIqxlCQ9WXpXynOBhbmejF1La0gJ12WsttGvLkqUmjhuwZ1
 T0Tu3pg+rUWudA3d2dKNGYDRiv6b3TBkmCQcmMZJUePd0De0GTHJx4qKQO8NbQUnlf4rcgnN6Io
 pR/rX
X-Gm-Gg: AR+sD12t9FURgD9+J6Qj9+HulBlLx6Ns3sjOW4i/i70OdV6hKU3HaZpvxMFq1RiDyyM
 YdwniRq9uYjhU01vkitKP3hBpsJ3TPJHAW+lPaAVx5zZMehtHaAa3wLbv876lwgUPIujLcRmGws
 ujED+yISGrO1aBT+KutSo+GY/ObO73jNG/diInyCgCzeU4IeCP0ZAHa2phVVKeUgQ42fTHDXci3
 aOohfbgyVo3VHI5nBPqNWNJyJKQVamqwEmrXeUi5Ru8JGhm5ZnOFmBjYHHdfjpo27AjfUoavkKI
 yHlc1QkcG3Cp1P50WdTe7ADiFFiozZv0Q9Y1dFrSc16+LmjG0i+P0xbrSm+6frY67sINMu9zHZa
 5I+xSRJzKAV2VPM777a6wm0z3u+WMXrUF9xAWODe+Mm1ajUczOV6M6FTsVov4qZ6utD6NkTrYLg
 ToPf27q9Zx+lOZVYMb5OQI0ZoQpZZQUOD/5+W7rBLlPEkZp7/Grgjwm6/Pa23G25lcYJsE4hw5J
 IE/qeLUye/oRsfq9/qNF0Vg12k=
X-Received: by 2002:a05:6a00:22c5:b0:851:8bde:7861 with SMTP id
 d2e1a72fcca58-85bc9572d54mr6245509b3a.1.1788294839524; 
 Tue, 01 Sep 2026 13:33:59 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc0bffbc1sm323980b3a.48.2026.09.01.13.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:33:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 21/22] ethdev: promote fast path inline helpers to stable
Date: Tue,  1 Sep 2026 13:23:20 -0700
Message-ID: <20260901203217.1485915-22-stephen@networkplumber.org>
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

The two remaining experimental fast path inline helpers are both at
least two years old:

  23.11  rte_eth_recycle_mbufs
  24.03  rte_eth_tx_queue_count

The trace point symbols these call are deliberately left experimental.
Trace infrastructure is intended to stay unstable, and promoting it
would add an ABI contract that is not wanted.

This does not affect users of the inline functions.
RTE_EXPORT_EXPERIMENTAL_SYMBOL only places the symbol in the
EXPERIMENTAL version node; it is not a __rte_experimental attribute on
the declaration, so it does not warn in application code built without
ALLOW_EXPERIMENTAL_API.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 2 ++
 lib/ethdev/rte_ethdev.h                | 8 --------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 7254ef585c..bf31d0dc6d 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -155,6 +155,8 @@ API Changes
     ``rte_eth_get_monitor_addr``, ``rte_eth_representor_info_get``,
     ``rte_eth_buffer_split_get_supported_hdr_ptypes``,
     ``rte_eth_timesync_adjust_freq`` and ``rte_tm_node_query``
+  * fast path inline funcs:
+    ``rte_eth_recycle_mbufs`` and ``rte_eth_tx_queue_count``
 
 
 ABI Changes
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 6f18878bc5..ed350ae1bd 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -6782,9 +6782,6 @@ rte_eth_tx_buffer(uint16_t port_id, uint16_t queue_id,
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Recycle used mbufs from a transmit queue of an Ethernet device, and move
  * these mbufs into a mbuf ring for a receive queue of an Ethernet device.
  * This can bypass mempool path to save CPU cycles.
@@ -6834,7 +6831,6 @@ rte_eth_tx_buffer(uint16_t port_id, uint16_t queue_id,
  * @return
  *   The number of recycling mbufs.
  */
-__rte_experimental
 static inline uint16_t
 rte_eth_recycle_mbufs(uint16_t rx_port_id, uint16_t rx_queue_id,
 		uint16_t tx_port_id, uint16_t tx_queue_id,
@@ -6937,9 +6933,6 @@ int rte_eth_buffer_split_get_supported_hdr_ptypes(uint16_t port_id, uint32_t *pt
 	__rte_warn_unused_result;
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice.
- *
  * Get the number of used descriptors of a Tx queue.
  *
  * This function retrieves the number of used descriptors of a transmit queue.
@@ -6970,7 +6963,6 @@ int rte_eth_buffer_split_get_supported_hdr_ptypes(uint16_t port_id, uint32_t *pt
  * If the use case only involves checking the status of a specific descriptor slot,
  * opt for rte_eth_tx_descriptor_status() instead.
  */
-__rte_experimental
 static inline int
 rte_eth_tx_queue_count(uint16_t port_id, uint16_t queue_id)
 {
-- 
2.53.0

