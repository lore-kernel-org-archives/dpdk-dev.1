Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA44AC61DD3
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:34:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FEB840E2F;
	Tue,  1 Sep 2026 22:33:36 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id 472EC40281
 for <dev@dpdk.org>; Tue,  1 Sep 2026 22:33:35 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cc1a4c62804so329912a12.3
 for <dev@dpdk.org>; Tue, 01 Sep 2026 13:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788294814;
 x=1788899614; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zRND7uY4/EYkaWlrn1lLEKbRv5XlqaJeUZ5AD+B7BlA=;
 b=WrcBkcvaPf6JBO9iOsreFXtAGmkH0+BAJQmb/9ee//0lKdK/2c/ka/GWlQBQgXUKxc
 BHBjniz8vzUVgLGP9WRqNKmhlppEasXHDoxGPvo0a05xwayAwJ79jjGkwrLrt1OtlGQf
 tUvTAtKbrFiGWHh3qyVpiNeUAUsk3xNxnaD78mlF4g89b6GOcE6dIu5s+dFLKZ4wUJoG
 0cUkqa6WcOiSsC74clWTZwgFUPRI8qcI0IROCuEcLPMdaFIu3YzjZpJ+b9ob9SMozvl8
 3pSfue0VQ8VFd5e2Thsy1jCaqnFuDCwGxLKRhN9YUaehhlMnhqABUG+4m6oij5zD1g8U
 RrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294814; x=1788899614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zRND7uY4/EYkaWlrn1lLEKbRv5XlqaJeUZ5AD+B7BlA=;
 b=ZBY0AYtZ1VQlCrRZt0ev+mj0yXoQki2EaE0qCLeq6aN+uFNlNif+lIZY6KvM8UkqTv
 eJyRS1UnV8FDICJQvztK4bkiOgkCrPhMLnFSYI4tjEj/gfjxyOhJkCdTrMm6jjQWvmzS
 6ppoJpbUXpS38a5C5eHvoj1Ii6NtbWOGGpAOlRMMPcjPYjjcAUTSi3IiwrbKAvn4VjKn
 4pHJy2EFP7QDCB7fINZNkQrAv9H4mPaVUOn5zHR7kR/pgX+lTEZcL5hsWl0K+xXjFlYU
 CRMlDaXdy7/iON3AmmWTYA5qsAsLc5K7L3Bmv5HCMb3At6ftSJLjV9wfQPfFb33qfqmO
 zcgg==
X-Gm-Message-State: AFuF++n7IVvnsTSWVWQn7Sq2rE4R+fePs+tsKJl/auTkz/P6wP8zMxfY
 Rp7dLnQwvu3FEj+Mxj5FscV/pkZzq1vosj3itVP8rGTQGsOjfxOQQixRC4MezfFQqHBrrIoS2Fu
 BIoo6
X-Gm-Gg: AR+sD12It/HaUNLUrnRTDc7YmrOCL46CufmldjVQP6zlfHnSJxFOnQ+ndaIQ4LsCR9s
 NUeEs298aGhP8vaSzDXK7o8xPFzdXtwtdJdngILRG7AfZERB1L4vXxNkVgDT+AGAdH+5NagcKa0
 iZfXHVzOPbZ7AZ+TTLvRAs0r7ZxwbBGC0kon13QihaoQ783FfbABYx+JohNr3iqlv7VsOlXWlsR
 gRaFr1EqJ/J8kAtYa3PvbiS2VuLOTptXuF4gd22p9fjfD2WbZISeNiLRGaO+WvFXSI6B7j9Fddu
 mjwam9pRjTRuj5luHaGLCBxT7PRWazqIT78v6CWMF/JEq6ZzjNkRtI2khG0bc1AocBhwlpZJB3C
 CusLiarNuz9noWv0DugknHXu/29kvsErIwQQdlELQqN2lYHcEGZ2CnE2Q4S+loGvYPyeaOHL75y
 kk2995n3zPjmuxhI7tCmvfvvBRwxCy2WxR1Bqjgn7pM9ZXJPmhnVuPgezIhhHwuBEIk2A1ns+Nq
 +0uKVy8ron6ehMkov6El7nLDnpf
X-Received: by 2002:a05:6a00:600b:b0:846:de21:3da4 with SMTP id
 d2e1a72fcca58-85ed71580c0mr520793b3a.3.1788294814320; 
 Tue, 01 Sep 2026 13:33:34 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc0bffbc1sm323980b3a.48.2026.09.01.13.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:33:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 16/22] ethdev: promote per-queue priority flow control to
 stable
Date: Tue,  1 Sep 2026 13:23:15 -0700
Message-ID: <20260901203217.1485915-17-stephen@networkplumber.org>
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

rte_eth_dev_priority_flow_ctrl_queue_configure() and
rte_eth_dev_priority_flow_ctrl_queue_info_get() were added in v22.03
to configure PFC on a per queue basis. Neither has changed since.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  3 +++
 lib/ethdev/rte_ethdev.c                |  4 ++--
 lib/ethdev/rte_ethdev.h                | 14 --------------
 3 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 7d36e10794..e0c8afdb04 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -133,6 +133,9 @@ API Changes
   * ip reassembly:
     ``rte_eth_ip_reassembly_capability_get``, ``rte_eth_ip_reassembly_conf_get`` and
     ``rte_eth_ip_reassembly_conf_set``
+  * priority flow:
+    ``rte_eth_dev_priority_flow_ctrl_queue_configure`` and
+    ``rte_eth_dev_priority_flow_ctrl_queue_info_get``
 
 
 ABI Changes
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 337babe793..b4f36a9b1b 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -4813,7 +4813,7 @@ validate_tx_pause_config(struct rte_eth_dev_info *dev_info, uint8_t tc_max,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_priority_flow_ctrl_queue_info_get, 22.03)
+RTE_EXPORT_SYMBOL(rte_eth_dev_priority_flow_ctrl_queue_info_get)
 int
 rte_eth_dev_priority_flow_ctrl_queue_info_get(uint16_t port_id,
 		struct rte_eth_pfc_queue_info *pfc_queue_info)
@@ -4841,7 +4841,7 @@ rte_eth_dev_priority_flow_ctrl_queue_info_get(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_priority_flow_ctrl_queue_configure, 22.03)
+RTE_EXPORT_SYMBOL(rte_eth_dev_priority_flow_ctrl_queue_configure)
 int
 rte_eth_dev_priority_flow_ctrl_queue_configure(uint16_t port_id,
 		struct rte_eth_pfc_queue_conf *pfc_queue_conf)
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index d67a3bbe28..4eea5b990d 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -1424,9 +1424,6 @@ struct rte_eth_pfc_conf {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * A structure used to retrieve information of queue based PFC.
  */
 struct rte_eth_pfc_queue_info {
@@ -1439,9 +1436,6 @@ struct rte_eth_pfc_queue_info {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * A structure used to configure Ethernet priority flow control parameters for
  * ethdev queues.
  *
@@ -4590,9 +4584,6 @@ int rte_eth_dev_mac_addr_add(uint16_t port_id, struct rte_ether_addr *mac_addr,
 				uint32_t pool);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Retrieve the information for queue based PFC.
  *
  * @param port_id
@@ -4606,14 +4597,10 @@ int rte_eth_dev_mac_addr_add(uint16_t port_id, struct rte_ether_addr *mac_addr,
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
@@ -4633,7 +4620,6 @@ int rte_eth_dev_priority_flow_ctrl_queue_info_get(uint16_t port_id,
  *   - (-EINVAL)  if bad parameter
  *   - (-EIO)     if flow control setup queue failure
  */
-__rte_experimental
 int rte_eth_dev_priority_flow_ctrl_queue_configure(uint16_t port_id,
 		struct rte_eth_pfc_queue_conf *pfc_queue_conf);
 
-- 
2.53.0

