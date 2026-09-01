Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404A1C61DD3
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:34:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB39240EAB;
	Tue,  1 Sep 2026 22:33:27 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 7D2DA40EDC
 for <dev@dpdk.org>; Tue,  1 Sep 2026 22:33:26 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-84864086bfeso252302b3a.1
 for <dev@dpdk.org>; Tue, 01 Sep 2026 13:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788294806;
 x=1788899606; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9yWkiULgQgrU8fN7ws2Sa8Np1REBtKoMIOKwR+cg9EU=;
 b=WaBwDmUkuwrOWlxqWRU3Pjd8/XB5zBBBO2LzQyi3kv2Tsu0GbuXeZ62qdzYh3PWjfY
 k14NNp3JHttMk3Z7gatarEm2BW0P9mH6vbBOERxp2sNXFx2UxCOO6crsTLJ2sh3v+g1f
 CB//mH8+9OgDVLvdYfbGSjCJoyW86rQOBDDcat/dRMVBFi4CMIvgIz2zzpQLNgjqMJ46
 Rd7Bq+iv00YGf8LzHxDieN5zgfvoCc3w25iwOJNXRx7dsmGdZwmjgUqLqK7pQF3EYBpT
 pQpgsx705bQmpcgVdUWUoYBmrdR8JVRhjhJ0EU2K8icls6zPMFpKhdxdmK5iUretnySz
 rHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294806; x=1788899606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9yWkiULgQgrU8fN7ws2Sa8Np1REBtKoMIOKwR+cg9EU=;
 b=ETN7mTPq3QS4eq67pToKZ/p3Z42ql0XuzxhIodVUhh/P7HM8BIjg4d0LhGQg3o95Zm
 oV7O3m5LVYa1nHnYSDboDbc8J9xpeuPlw1RfLP9Z7QQ05U6oprv1dXaDWtvaHB5DIx+f
 G7qa5ZIg730j28r4M2IVR2gpTLp/a6rJzQOk/cpoLbJT88vLVD69qOu32Ua8uUFhTow1
 AoY2mxSGd+q0KKbca4neXv9PUzW4LdM1+avFfpAHegDhepp1qHvG4uhWEjLGcwytxndy
 /xBjg9INvBdX/j0rVcWCTZ5TnqAFPR8K0udpMOpnemGX0Y6rEOORlMTzN8t5b9dW5hcG
 HUbA==
X-Gm-Message-State: AFuF++llCueRKzpWzOY/CJPbjDfvag8tiIPApsflWBBcwwxf8im3N2r1
 PE12CkV9cjQ8nia4qh0/Ni1Fwu7vUXD8XZuzQ6ubox0OMEOjd2NUNc9S2js2hD982zFaBTASofE
 aYntu
X-Gm-Gg: AR+sD13OAeW+ms/ABWyE+wIRttvLw/Qdwgayl4fJTQdSFebcHYGkhWw3ibMipVPYVLu
 2JT4l/YQKJe6hwRaXTevgYGf9Uj84AWiApb90srWaAktpKZftXRp0u1lyTopjNoBbPLnR3WYxvu
 KcZ5/aJeFnh+IP3Bc/Yo0fL4KUYYXnF4dmTM8xlAvbkMWBmZg1cgXP3Tjg2XJr/rsgiisJ72rBs
 dhnOXeQD5OlPFfS8uaMDJS6YQJv4ymRqilYP8dmdj2Qs5CCav9hm9njazoVnXGchGXfBLjZLiTm
 XwIszbxZ/uHf2n/fUU8B+d+7ScHB5URoGw6GgHDuzJdxPqVT4FYcQIPCKADkupzS5D5irwuzueO
 NzY/mT578w90Nsa1/lmqyTulurLpdbyCGZwYNhAoA4MtowZZWIB4pykBdTR+GfSUTN5boWbhnu7
 z0Fk973Xf7olzE0gK0dVjWvXuEIi3O8i3Ye63Ky6PTgUHYmo2W90ksv2bkleGVBE5vulfJUcr9l
 06YvsY9KXBQNZKshQRLAvvvaUHse3coVJPKhQ==
X-Received: by 2002:a05:6a00:9090:b0:851:fb36:a701 with SMTP id
 d2e1a72fcca58-85ed23dea91mr623757b3a.7.1788294805600; 
 Tue, 01 Sep 2026 13:33:25 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc0bffbc1sm323980b3a.48.2026.09.01.13.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:33:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 15/22] ethdev: promote IP reassembly offload API to stable
Date: Tue,  1 Sep 2026 13:23:14 -0700
Message-ID: <20260901203217.1485915-16-stephen@networkplumber.org>
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

The IP reassembly offload configuration was added in v22.03 and the
three functions are unchanged since.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  3 +++
 lib/ethdev/rte_ethdev.c                |  6 +++---
 lib/ethdev/rte_ethdev.h                | 12 ------------
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 477139a2a1..7d36e10794 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -130,6 +130,9 @@ API Changes
   * congestion management:
     ``rte_eth_cman_config_init``, ``rte_eth_cman_config_set``,
     ``rte_eth_cman_config_get`` and ``rte_eth_cman_info_get``
+  * ip reassembly:
+    ``rte_eth_ip_reassembly_capability_get``, ``rte_eth_ip_reassembly_conf_get`` and
+    ``rte_eth_ip_reassembly_conf_set``
 
 
 ABI Changes
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 6fda1468f9..337babe793 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -7205,7 +7205,7 @@ rte_eth_rx_metadata_negotiate(uint16_t port_id, uint64_t *features)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_ip_reassembly_capability_get, 22.03)
+RTE_EXPORT_SYMBOL(rte_eth_ip_reassembly_capability_get)
 int
 rte_eth_ip_reassembly_capability_get(uint16_t port_id,
 		struct rte_eth_ip_reassembly_params *reassembly_capa)
@@ -7241,7 +7241,7 @@ rte_eth_ip_reassembly_capability_get(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_ip_reassembly_conf_get, 22.03)
+RTE_EXPORT_SYMBOL(rte_eth_ip_reassembly_conf_get)
 int
 rte_eth_ip_reassembly_conf_get(uint16_t port_id,
 		struct rte_eth_ip_reassembly_params *conf)
@@ -7275,7 +7275,7 @@ rte_eth_ip_reassembly_conf_get(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_ip_reassembly_conf_set, 22.03)
+RTE_EXPORT_SYMBOL(rte_eth_ip_reassembly_conf_set)
 int
 rte_eth_ip_reassembly_conf_set(uint16_t port_id,
 		const struct rte_eth_ip_reassembly_params *conf)
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 2b40340004..d67a3bbe28 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -5850,9 +5850,6 @@ struct rte_eth_ip_reassembly_params {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice
- *
  * Get IP reassembly capabilities supported by the PMD. This is the first API
  * to be called for enabling the IP reassembly offload feature. PMD will return
  * the maximum values of parameters that PMD can support and user can call
@@ -5869,14 +5866,10 @@ struct rte_eth_ip_reassembly_params {
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
@@ -5894,14 +5887,10 @@ int rte_eth_ip_reassembly_capability_get(uint16_t port_id,
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
@@ -5927,7 +5916,6 @@ int rte_eth_ip_reassembly_conf_get(uint16_t port_id,
  *               successfully by the PMD.
  *   - (0) on success.
  */
-__rte_experimental
 int rte_eth_ip_reassembly_conf_set(uint16_t port_id,
 		const struct rte_eth_ip_reassembly_params *conf);
 
-- 
2.53.0

