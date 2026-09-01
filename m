Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B41C61DD3
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:34:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DD7440EDC;
	Tue,  1 Sep 2026 22:33:43 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id 7BA4D40281
 for <dev@dpdk.org>; Tue,  1 Sep 2026 22:33:42 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-852c481415fso380954b3a.3
 for <dev@dpdk.org>; Tue, 01 Sep 2026 13:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788294821;
 x=1788899621; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eZviucbEdXY6CT7QqimJb/DFt3of0uHOBAklQ6G7Mzc=;
 b=Q2zOAqrnsmycaN1FaoIgBXQxxo4rPPDpYlWE4kwhcHplaVQe8Z4aBep+ordCJHfsTq
 qivVyga9AhwISNEb/2eoOrMCZVOAnHeQJ+z7K1Zo+VbuVndTL9Fxx1R5Xq1SLgUd5nP2
 rspgcGxuIE/wK8xvLegznc2qOeVB7/GzFiDJaSlKb/exsILxIDLdGMqdYbQ/GOMl01Tq
 NZvQZxXNb7BsuO6So/wKEy2AGJ9JT9qwm2s/ESkLH75o8iFLI8MUfyM0UJQhzSag7qJg
 58ommfQtXn2lByp2tOKQ+4SsdT92SF0dcbFoBh4pYLB0DhHC3s1HzUT6xeUPwlpe5zbM
 6FQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294821; x=1788899621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eZviucbEdXY6CT7QqimJb/DFt3of0uHOBAklQ6G7Mzc=;
 b=ZF3+SrHcsFnjNfYvdpGXDicwl3Yh/NfMu3hYpMNUOw7GDOWAoaIHe/78YKqhmRm+C+
 Y8XHQ8EfU4s4GtLCoT5xJX3Hjyst7jG+VNx1UOhEFtjNJ2PXF/2T8G1KQNPTDNOOif8f
 j/JHv4ODSZ/L6Ep427t7Xzu2UL4FHHtmYsxVj/cc2UT1WB59syfm3NIW9Bc5uZ4SdYIs
 nwQ8p2mJwKJ8m2OV1A3Wn4m4CF6Ll02soJjfArj/uUMGhEwD5jBjoDseQ2+e2+17kZkn
 U7Iq+wwNwp6AO559fkKsGM5nu2VnJnbaBhiUI1BMqKHKBF8rrxwxpnwwTFigQp3qxmcs
 pW1Q==
X-Gm-Message-State: AFuF++m1yuOBbUBq1vlXaztZ2J/mri2fWDmqPlhWpzYRa4u1sBftg7K5
 asvjt1D74+BuQy0cRgf9nWExN92hVmrqhM4IdoeUDKVU/SPTY5PCEdKIe1EPcmRCh+muji9687D
 GcHYV
X-Gm-Gg: AR+sD11989a2z1Ieboguoq8iWPD9zlRZK8FdUXVpf/MNH5H4IItlGIYIp9+QiaN2dId
 jiDKTrfnAzPuJySZ5V30lmk0qC7S3gZJt1uoefgt9GyY20kQ3Lf/LhQZasUIFM6JNlPzrIjQUJp
 i7mXEq2un09lFPe9BO4v5BnBse7z3RrvzJxWvunNgUSohti+rfQ2uKoCw5fx3vClSHGvI9Cwf6J
 Eo8o325oLruTxPErJ4foEKLFw+u3uS/XW2g5YdWF3/vxXWm+DZczfNg6u8L3DyagPGL4zVQsEsU
 T9zb5cS2rKfMCxkxOj2hNKNvSUffujerqG9PdWHrPdz4q3H8iZRz0MGWrV6w0tshIWBGJ8TMkOL
 bq9tNJdz+twh4PPcbgqztoqsXeo3Zo16P5JMwARov8KPBrs7rXtNdV+l9UezIm3PF8eGgIOOdOD
 8JGpuIETZh4cCmRBaFCSRJ6Ow0+qcnf3WmaxuJhYg44nykfvLjIMNjN1Lyp8MjwaszWlBZiYjNZ
 Y/kSzO4qUxHqM0JfT4cWkWFtsk=
X-Received: by 2002:a05:6a00:4c85:b0:847:9aa8:d3bb with SMTP id
 d2e1a72fcca58-85ed92cbba5mr493376b3a.12.1788294821427; 
 Tue, 01 Sep 2026 13:33:41 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc0bffbc1sm323980b3a.48.2026.09.01.13.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:33:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 18/22] ethdev: promote speed lanes API to stable
Date: Tue,  1 Sep 2026 13:23:17 -0700
Message-ID: <20260901203217.1485915-19-stephen@networkplumber.org>
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

The speed lanes configuration was added in v24.11 to query and set
the number of lanes used by a link. The three functions are
unchanged since.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  3 +++
 lib/ethdev/rte_ethdev.c                |  6 +++---
 lib/ethdev/rte_ethdev.h                | 12 ------------
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 2b085dcd51..01030cefe5 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -142,6 +142,9 @@ API Changes
     ``rte_eth_rx_descriptor_dump``, ``rte_eth_tx_descriptor_dump``,
     ``rte_eth_dev_rss_algo_name``, ``rte_eth_find_rss_algo`` and
     ``rte_eth_dev_get_reg_info_ext``
+  * speed lanes:
+    ``rte_eth_speed_lanes_get``, ``rte_eth_speed_lanes_set`` and
+    ``rte_eth_speed_lanes_get_capability``
 
 
 ABI Changes
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 0dc7e3b5d2..783fb817c2 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
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
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index b75cd072d9..dfb9cfd614 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -3144,9 +3144,6 @@ int rte_eth_link_to_str(char *str, size_t len,
 			const struct rte_eth_link *eth_link);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Get Active lanes.
  *
  * @param port_id
@@ -3163,13 +3160,9 @@ int rte_eth_link_to_str(char *str, size_t len,
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
@@ -3187,13 +3180,9 @@ int rte_eth_speed_lanes_get(uint16_t port_id, uint32_t *lanes);
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
@@ -3212,7 +3201,6 @@ int rte_eth_speed_lanes_set(uint16_t port_id, uint32_t speed_lanes);
  *   - (-ENODEV)  if *port_id* invalid.
  *   - (-EINVAL)  if *speed_lanes* invalid
  */
-__rte_experimental
 int rte_eth_speed_lanes_get_capability(uint16_t port_id,
 				       struct rte_eth_speed_lanes_capa *speed_lanes_capa,
 				       unsigned int num);
-- 
2.53.0

