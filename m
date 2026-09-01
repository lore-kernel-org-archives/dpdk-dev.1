Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9109BC61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:33:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD60840E21;
	Tue,  1 Sep 2026 22:33:21 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 8ABD940E4A
 for <dev@dpdk.org>; Tue,  1 Sep 2026 22:33:19 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-84e0688b7e8so289912b3a.1
 for <dev@dpdk.org>; Tue, 01 Sep 2026 13:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788294799;
 x=1788899599; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tClG/NSoDTgwTk9qivPRBbs0Qio5cmOTbVWeBDNFNkI=;
 b=o7qpRBQhv4jCGtpREG2DwS7da1nHkQnDWGRPwQOUaoVwU0F/Rl3nq39Jj43xcCvwUY
 9faEgouVjo3xmCbO5Sf5XC11rbBTyidI7zjrIulRv6XxNzNQ9FSge8pkYpAfaphPVf7M
 7stCKTSiuJT9ICd7Of1D4GKdGOrPwD5he+Akhkefd9Z9DkTiw7oJAHGrzZo/zREu9U9h
 8CuuJCQsXtGLG0J6wsUXYEwqKYgMClbHvQ17LftjBXZQoYPdZ0DgKrsuDQOeTXkcTEnU
 MaU8P5GCoHXFPo0zj4yUenQYC/s0Blkk7rrCehRtw3UsppE8xAlaWHSKp2Fat0PWzEe6
 qIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294799; x=1788899599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tClG/NSoDTgwTk9qivPRBbs0Qio5cmOTbVWeBDNFNkI=;
 b=X408Sd0nQi/zGz7AfITrgR324bTMZ27cEc52kuoqG5Q6mPco91AgTSzpWnudTyRWmC
 aUPRTlkHop+/2m01bnIiRByLiKthT/sRcksmnQKNTSFziFFNAlwm/5svEqhvFhk60252
 JW9CLzTXyj6rFJMo6OUQktVDAtncR46RtL1Nr2Xcv5uClVW0wYksSzwXXBLeyZL8dKr3
 g3iDcaMjSFcFdFI13vRVhA5PG3HeDvo1UiXq1p+A0/5bstTJde3Mkz8SOt6FdSiCHgLj
 1fOIxWjeoEYqdDKB+a7zut/Fd0SLiHLACX2DGlM/i6bQe/9tJtg4vwHH6e6yh9/0p2Te
 40tA==
X-Gm-Message-State: AFuF++lSHFUwUOxeeMouENHel2jZZZ2OdDmvCYrmptQOIShnNBwMeaDF
 D/K300ClAzwyVJaaXou3YX5dusjYi4RivWDpfo3WrFxPDU2ynbev2K8DDjgnUCTq97MmDq5Ii8C
 Idg0V
X-Gm-Gg: AR+sD11GvvF6995suM1clMa+9biDpbrtkjpvfOMgBhQDcgegW/hBdeiIUn65jlUhBfa
 +9+KOFEZsta9IuYZJTjnKG34n44rxXBmJ0J0k4EHuz7+vxctxwTO4ujBXmm+8j9XnXib4wnnvcH
 i1NldjIequnRexP3FxOh9CVtd8Ac9Dk+UqXJgPrUgniaKk87L1JtIb7zy+eFkqxgFvtSDMAclSF
 sd5AP50l6jeRZq8wVVc68wMiMHXKWCjYM189hNu7R6s3vXYhMzNivbnz45VNDqKPnI3IobeGEqN
 MjpqYQ7DNKlFtSX4fVPizzDj9YvCaAFMFA/y/fvBW3nZ1GJvBosOVgPmMWa5L2b5UBkIEWSjo0/
 3aTJCyotWViczRVPq95lz8qQP9xBSwYnIZpLEwwjJxo4FJYN6BBFRHdxvguHtsJgFtngLeLLTIV
 3YbDHvWvgsaSTbaoGD6kTSCtzJydraC9eOdj1hrTZGuR6E5+1FJVudZMwYqLn/HutNN801Y0TVM
 LwX6+0nY2pMaA6Tz6/ViSFHrhU=
X-Received: by 2002:a05:6a00:181c:b0:848:77b3:579a with SMTP id
 d2e1a72fcca58-85ed850a409mr448375b3a.17.1788294798715; 
 Tue, 01 Sep 2026 13:33:18 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc0bffbc1sm323980b3a.48.2026.09.01.13.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:33:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Ori Kam <orika@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 13/22] ethdev: promote remaining aged flow helpers to stable
Date: Tue,  1 Sep 2026 13:23:12 -0700
Message-ID: <20260901203217.1485915-14-stephen@networkplumber.org>
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

The last aged experimental symbols of rte_flow:

  23.07  rte_flow_actions_update, rte_flow_restore_info_dynflag
  23.11  rte_flow_calc_table_hash, rte_flow_group_set_miss_actions
  24.03  rte_flow_calc_encap_hash

With this rte_flow.c has no experimental symbol left.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  3 +++
 lib/ethdev/rte_flow.c                  | 10 +++++-----
 lib/ethdev/rte_flow.h                  | 17 -----------------
 3 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 141ad134b0..6649a847ff 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -124,6 +124,9 @@ API Changes
     ``rte_flow_async_*``,
     ``rte_flow_push``, ``rte_flow_pull``
   * flow flex: ``rte_flow_flex_item_create`` and ``rte_flow_flex_item_release``
+  * remaining flow helpers: ``rte_flow_actions_update``, ``rte_flow_restore_info_dynflag``,
+    ``rte_flow_calc_table_hash``, ``rte_flow_group_set_miss_actions``,
+    and ``rte_flow_calc_encap_hash``
 
 
 ABI Changes
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 75e3e1f10f..1056cfd2c5 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -466,7 +466,7 @@ rte_flow_destroy(uint16_t port_id,
 				  NULL, rte_strerror(ENOSYS));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_actions_update, 23.07)
+RTE_EXPORT_SYMBOL(rte_flow_actions_update)
 int
 rte_flow_actions_update(uint16_t port_id,
 			struct rte_flow *flow,
@@ -1519,7 +1519,7 @@ static struct {
 	.desc = { .name = "RTE_MBUF_F_RX_RESTORE_INFO", },
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_restore_info_dynflag, 23.07)
+RTE_EXPORT_SYMBOL(rte_flow_restore_info_dynflag)
 uint64_t
 rte_flow_restore_info_dynflag(void)
 {
@@ -2062,7 +2062,7 @@ rte_flow_template_table_destroy(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_group_set_miss_actions, 23.11)
+RTE_EXPORT_SYMBOL(rte_flow_group_set_miss_actions)
 int
 rte_flow_group_set_miss_actions(uint16_t port_id,
 				uint32_t group_id,
@@ -2691,7 +2691,7 @@ rte_flow_async_action_list_handle_query_update(uint16_t port_id, uint32_t queue_
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_calc_table_hash, 23.11)
+RTE_EXPORT_SYMBOL(rte_flow_calc_table_hash)
 int
 rte_flow_calc_table_hash(uint16_t port_id, const struct rte_flow_template_table *table,
 			 const struct rte_flow_item pattern[], uint8_t pattern_template_index,
@@ -2713,7 +2713,7 @@ rte_flow_calc_table_hash(uint16_t port_id, const struct rte_flow_template_table
 	return flow_err(port_id, ret, error);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_calc_encap_hash, 24.03)
+RTE_EXPORT_SYMBOL(rte_flow_calc_encap_hash)
 int
 rte_flow_calc_encap_hash(uint16_t port_id, const struct rte_flow_item pattern[],
 			 enum rte_flow_encap_hash_field dest_field, uint8_t hash_len,
diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h
index 6fc6f750f1..f7523bdf8f 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -4726,7 +4726,6 @@ rte_flow_destroy(uint16_t port_id,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-__rte_experimental
 int
 rte_flow_actions_update(uint16_t port_id,
 			struct rte_flow *flow,
@@ -5293,7 +5292,6 @@ rte_flow_tunnel_match(uint16_t port_id,
  * @return
  *   The offload flag indicating rte_flow_get_restore_info() must be called.
  */
-__rte_experimental
 uint64_t
 rte_flow_restore_info_dynflag(void);
 
@@ -5964,9 +5962,6 @@ rte_flow_template_table_destroy(uint16_t port_id,
 		struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Set group miss actions.
  *
  * @param port_id
@@ -5984,7 +5979,6 @@ rte_flow_template_table_destroy(uint16_t port_id,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-__rte_experimental
 int
 rte_flow_group_set_miss_actions(uint16_t port_id,
 				uint32_t group_id,
@@ -6765,9 +6759,6 @@ rte_flow_async_action_list_handle_query_update(uint16_t port_id, uint32_t queue_
 					  struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Calculate the hash for a given pattern in a given table as
  * calculated by the HW.
  *
@@ -6790,16 +6781,12 @@ rte_flow_async_action_list_handle_query_update(uint16_t port_id, uint32_t queue_
  *   - (-ENODEV) if *port_id* invalid.
  *   - (-ENOTSUP) if underlying device does not support this functionality.
  */
-__rte_experimental
 int
 rte_flow_calc_table_hash(uint16_t port_id, const struct rte_flow_template_table *table,
 			 const struct rte_flow_item pattern[], uint8_t pattern_template_index,
 			 uint32_t *hash, struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Destination field type for the hash calculation, when encap action is used.
  * The encap field implies the size, meaning XXX_SRC_PORT hash len is 2 bytes,
  * while XXX_NVGRE_FLOW_ID hash len is 1 byte.
@@ -6814,9 +6801,6 @@ enum rte_flow_encap_hash_field {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Simulate HW hash calculation that is done when an encap action is being used.
  * This hash can be stored in tunnel outer header to improve packet distribution.
  *
@@ -6843,7 +6827,6 @@ enum rte_flow_encap_hash_field {
  *   - (-EINVAL) if *pattern* doesn't hold enough information to calculate the hash
  *               or the dest is not supported.
  */
-__rte_experimental
 int
 rte_flow_calc_encap_hash(uint16_t port_id, const struct rte_flow_item pattern[],
 			 enum rte_flow_encap_hash_field dest_field, uint8_t hash_len,
-- 
2.53.0

