Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1994BCA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 21:42:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CFA2427BB;
	Wed,  7 Oct 2026 23:41:32 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 45E3742830
 for <dev@dpdk.org>; Wed,  7 Oct 2026 23:41:29 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso27479615ad.3
 for <dev@dpdk.org>; Wed, 07 Oct 2026 14:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791409288;
 x=1792014088; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bh4QEo79bhJEFEyQ1rAExUHP51C4jdUQcBvev32mMrc=;
 b=VdzkKOC81TmexSKhl9rzRHnqqmzAnP48kbV0WhAdGHoEyDaiLgaYQGWiqngPDylKCl
 kwfc10gMaQyLvpG4Hu4CrGhWoXBjh5kn0JUAh3IGstsAqF7G2xHjO6hW/SgIcS8DDmPS
 WewGgGHx0/s8pwtQFzlSXXJ+1C9MC/YKUTMSS+E/IhavWK+sONZTDJE4I4W0LoQhKffw
 jQ1eDpMgOvbBDuF1KC1mAPQovJhVQMQ7AJeus3dlXhcJReiSsx1gqTtwmrLF6KUlQhWG
 r2HTgMMsltuggxkSG3EZw4pZNLBKwf3dPZJrxfnNnhIPHiYaom6u66xSNNV6WwQMLwYq
 af2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791409288; x=1792014088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bh4QEo79bhJEFEyQ1rAExUHP51C4jdUQcBvev32mMrc=;
 b=e0k/YJgzXi2kfhkb9zgCEz6l0EMuvCoKlu3YJ72f9HjmYNf7epByJegxnOrpxUWJcK
 kR64CmZSWqnpdKcO/5+yFTI9RwCNtTpJEX//8qgvM6nfbwvTouc6TEvbBTQpXmCL7gLc
 9Nwge3+VGEdUr0S53gi5w97eQ5D8BjqsFLEHlAubDGiylxwCYosZ0QZPVH8mlGg2dJD0
 h3g84N2ODUWBP2vIAwlYVvKgQ+oPnpczCl8CATjCN/uzGYjtKRFWdqJxp9XUqT65W/vD
 721Xadb0kg1djEEwnrlr+81GD4EQ0BX29xE/DNGj2A8YjePa6JeNSm2reZSBZCX9aiE+
 xUlw==
X-Gm-Message-State: AFq9FYJoeHxMAnBewxEjyIBouWfOw16NZmnOj4wvFnuoigRCGRS9Ib78
 i4MAXHU5ukf3ltgHt6abIMN29fYD4YkRcfHBlPzczzO/Wk+g8By36ekmA5JDe2YhKoFatXAnkmJ
 oKtFrRZM=
X-Gm-Gg: AYBFou134JP+/CvPBLTRWPi9wU+zj8ES5StvkdiOj7oouozWl4/J548gviO+wFVsFCq
 FG/7/xjLxO1+SdhlZ4OdzcJUsIeuuIvSGYHT1FACXtHvQ3/MVfCKfypABO3dVT2vz8PrDJomEGI
 aeX0bMoBbVJmcqgPtdeLENmRg5MvETBJGBGSrhkIiNT8tWAsFTJvB6wwYAS+rNKtbQVZEe/shjz
 HfgKPpHs7nXa6DZG5rA1S7MFcxoy2JdYYdCmaazrBBPh3B9yuXMu5TDFG1QpOqGb0/JHAkI59ie
 /afLnDt3UwaM/XKLaGRwU+dn74HZ05NDuER0pJD1s3sxW6dgFwWlJYvPFhp4Ar+SEAQxDs1YViR
 u33NmYa5ky8lkYeDt3d7Bh4JTRGTd0iuf3CIfU2KwYzCn/efkUbb5aze+BkbE/FsIBdHkfUxHXw
 qgHSQNxxLRadwrH1VnrVylwzfN4BOhfrY4s7rCRB2GLtD/D/GZKGSMH5iutOyUIZw88kIBLE4Ac
 iq9VRY0jqpT6RfIlCgMEy4ErsbgAsLHaKzVk/s=
X-Received: by 2002:a17:903:37cd:b0:2d9:56dd:f804 with SMTP id
 d9443c01a7336-2e600391102mr30961415ad.13.1791409288350; 
 Wed, 07 Oct 2026 14:41:28 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e60484ca89sm16573335ad.57.2026.10.07.14.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:41:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 09/20] table: promote SWX table API to stable
Date: Wed,  7 Oct 2026 14:39:39 -0700
Message-ID: <20261007214115.3092715-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007214115.3092715-1-stephen@networkplumber.org>
References: <20261007214115.3092715-1-stephen@networkplumber.org>
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

The SWX table symbols have been experimental since 20.11 (exact match),
21.05 (wildcard match), 21.08 (selector) and 21.11 (learner), with only
the learner timeout and rearm additions in 22.07 being more recent.

The interface has been unchanged for several releases and is the only
table API remaining now that the legacy rte_table_* API has been
removed, so promote it to stable.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/table/rte_swx_table_em.c       |  4 ++--
 lib/table/rte_swx_table_learner.c  | 20 ++++++++++----------
 lib/table/rte_swx_table_learner.h  | 12 ------------
 lib/table/rte_swx_table_selector.c | 12 ++++++------
 lib/table/rte_swx_table_selector.h |  8 --------
 lib/table/rte_swx_table_wm.c       |  2 +-
 6 files changed, 19 insertions(+), 39 deletions(-)

diff --git a/lib/table/rte_swx_table_em.c b/lib/table/rte_swx_table_em.c
index c408ea6fc3..ad49443389 100644
--- a/lib/table/rte_swx_table_em.c
+++ b/lib/table/rte_swx_table_em.c
@@ -646,7 +646,7 @@ table_footprint(struct rte_swx_table_params *params,
 	return memory_footprint;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_exact_match_unoptimized_ops, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_table_exact_match_unoptimized_ops)
 struct rte_swx_table_ops rte_swx_table_exact_match_unoptimized_ops = {
 	.footprint_get = table_footprint,
 	.mailbox_size_get = table_mailbox_size_get_unoptimized,
@@ -657,7 +657,7 @@ struct rte_swx_table_ops rte_swx_table_exact_match_unoptimized_ops = {
 	.free = table_free,
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_exact_match_ops, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_table_exact_match_ops)
 struct rte_swx_table_ops rte_swx_table_exact_match_ops = {
 	.footprint_get = table_footprint,
 	.mailbox_size_get = table_mailbox_size_get,
diff --git a/lib/table/rte_swx_table_learner.c b/lib/table/rte_swx_table_learner.c
index 3680bf26c1..633f9df2e2 100644
--- a/lib/table/rte_swx_table_learner.c
+++ b/lib/table/rte_swx_table_learner.c
@@ -273,7 +273,7 @@ table_entry_id_get(struct table *t, struct table_bucket *b, size_t bucket_key_po
 	return (bucket_id << TABLE_KEYS_PER_BUCKET_LOG2) + bucket_key_pos;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_footprint_get, 21.11)
+RTE_EXPORT_SYMBOL(rte_swx_table_learner_footprint_get)
 uint64_t
 rte_swx_table_learner_footprint_get(struct rte_swx_table_learner_params *params)
 {
@@ -285,7 +285,7 @@ rte_swx_table_learner_footprint_get(struct rte_swx_table_learner_params *params)
 	return status ? 0 : p.total_size;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_create, 21.11)
+RTE_EXPORT_SYMBOL(rte_swx_table_learner_create)
 void *
 rte_swx_table_learner_create(struct rte_swx_table_learner_params *params, int numa_node)
 {
@@ -309,7 +309,7 @@ rte_swx_table_learner_create(struct rte_swx_table_learner_params *params, int nu
 	return t;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_free, 21.11)
+RTE_EXPORT_SYMBOL(rte_swx_table_learner_free)
 void
 rte_swx_table_learner_free(void *table)
 {
@@ -321,7 +321,7 @@ rte_swx_table_learner_free(void *table)
 	env_free(t, t->params.total_size);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_timeout_update, 22.07)
+RTE_EXPORT_SYMBOL(rte_swx_table_learner_timeout_update)
 int
 rte_swx_table_learner_timeout_update(void *table,
 				     uint32_t key_timeout_id,
@@ -359,14 +359,14 @@ struct mailbox {
 	int state;
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_mailbox_size_get, 21.11)
+RTE_EXPORT_SYMBOL(rte_swx_table_learner_mailbox_size_get)
 uint64_t
 rte_swx_table_learner_mailbox_size_get(void)
 {
 	return sizeof(struct mailbox);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_lookup, 21.11)
+RTE_EXPORT_SYMBOL(rte_swx_table_learner_lookup)
 int
 rte_swx_table_learner_lookup(void *table,
 			     void *mailbox,
@@ -453,7 +453,7 @@ rte_swx_table_learner_lookup(void *table,
 	}
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_rearm, 22.07)
+RTE_EXPORT_SYMBOL(rte_swx_table_learner_rearm)
 void
 rte_swx_table_learner_rearm(void *table,
 			    void *mailbox,
@@ -477,7 +477,7 @@ rte_swx_table_learner_rearm(void *table,
 	b->time[bucket_key_pos] = (input_time + key_timeout) >> 32;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_rearm_new, 22.07)
+RTE_EXPORT_SYMBOL(rte_swx_table_learner_rearm_new)
 void
 rte_swx_table_learner_rearm_new(void *table,
 				void *mailbox,
@@ -502,7 +502,7 @@ rte_swx_table_learner_rearm_new(void *table,
 	b->key_timeout_id[bucket_key_pos] = (uint8_t)key_timeout_id;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_add, 21.11)
+RTE_EXPORT_SYMBOL(rte_swx_table_learner_add)
 uint32_t
 rte_swx_table_learner_add(void *table,
 			  void *mailbox,
@@ -579,7 +579,7 @@ rte_swx_table_learner_add(void *table,
 	return 1;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_delete, 21.11)
+RTE_EXPORT_SYMBOL(rte_swx_table_learner_delete)
 void
 rte_swx_table_learner_delete(void *table __rte_unused,
 			     void *mailbox)
diff --git a/lib/table/rte_swx_table_learner.h b/lib/table/rte_swx_table_learner.h
index 9a18be083d..92f1ed949e 100644
--- a/lib/table/rte_swx_table_learner.h
+++ b/lib/table/rte_swx_table_learner.h
@@ -45,8 +45,6 @@
 #include <stdint.h>
 #include <sys/types.h>
 
-#include <rte_compat.h>
-
 #include "rte_swx_hash_func.h"
 
 #ifdef __cplusplus
@@ -107,7 +105,6 @@ struct rte_swx_table_learner_params {
  * @return
  *   Table memory footprint in bytes.
  */
-__rte_experimental
 uint64_t
 rte_swx_table_learner_footprint_get(struct rte_swx_table_learner_params *params);
 
@@ -121,7 +118,6 @@ rte_swx_table_learner_footprint_get(struct rte_swx_table_learner_params *params)
  * @return
  *   Table mailbox footprint in bytes.
  */
-__rte_experimental
 uint64_t
 rte_swx_table_learner_mailbox_size_get(void);
 
@@ -135,7 +131,6 @@ rte_swx_table_learner_mailbox_size_get(void);
  * @return
  *   Table handle, on success, or NULL, on error.
  */
-__rte_experimental
 void *
 rte_swx_table_learner_create(struct rte_swx_table_learner_params *params, int numa_node);
 
@@ -152,7 +147,6 @@ rte_swx_table_learner_create(struct rte_swx_table_learner_params *params, int nu
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument(s).
  */
-__rte_experimental
 int
 rte_swx_table_learner_timeout_update(void *table,
 				     uint32_t key_timeout_id,
@@ -206,7 +200,6 @@ rte_swx_table_learner_timeout_update(void *table,
  *   0 when the table lookup operation is not yet completed, and 1 when the table lookup operation
  *   is completed. No other return values are allowed.
  */
-__rte_experimental
 int
 rte_swx_table_learner_lookup(void *table,
 			     void *mailbox,
@@ -239,7 +232,6 @@ rte_swx_table_learner_lookup(void *table,
  * @return
  *   0 on success, 1 or error (table full).
  */
-__rte_experimental
 uint32_t
 rte_swx_table_learner_add(void *table,
 			  void *mailbox,
@@ -261,7 +253,6 @@ rte_swx_table_learner_add(void *table,
  * @param[in] time
  *   Current time measured in CPU clock cycles.
  */
-__rte_experimental
 void
 rte_swx_table_learner_rearm(void *table,
 			    void *mailbox,
@@ -282,7 +273,6 @@ rte_swx_table_learner_rearm(void *table,
  * @param[in] key_timeout_id
  *   Key timeout ID.
  */
-__rte_experimental
 void
 rte_swx_table_learner_rearm_new(void *table,
 				void *mailbox,
@@ -301,7 +291,6 @@ rte_swx_table_learner_rearm_new(void *table,
  * @param[in] mailbox
  *   Mailbox for the current operation.
  */
-__rte_experimental
 void
 rte_swx_table_learner_delete(void *table,
 			     void *mailbox);
@@ -312,7 +301,6 @@ rte_swx_table_learner_delete(void *table,
  * @param[in] table
  *   Table handle.
  */
-__rte_experimental
 void
 rte_swx_table_learner_free(void *table);
 
diff --git a/lib/table/rte_swx_table_selector.c b/lib/table/rte_swx_table_selector.c
index d42f67f157..041fc70db5 100644
--- a/lib/table/rte_swx_table_selector.c
+++ b/lib/table/rte_swx_table_selector.c
@@ -171,7 +171,7 @@ struct table {
 	uint32_t n_members_per_group_max_log2;
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_selector_footprint_get, 21.08)
+RTE_EXPORT_SYMBOL(rte_swx_table_selector_footprint_get)
 uint64_t
 rte_swx_table_selector_footprint_get(uint32_t n_groups_max, uint32_t n_members_per_group_max)
 {
@@ -184,7 +184,7 @@ rte_swx_table_selector_footprint_get(uint32_t n_groups_max, uint32_t n_members_p
 	return sizeof(struct table) + group_table_size + members_size;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_selector_free, 21.08)
+RTE_EXPORT_SYMBOL(rte_swx_table_selector_free)
 void
 rte_swx_table_selector_free(void *table)
 {
@@ -262,7 +262,7 @@ group_set(struct table *t,
 	  uint32_t group_id,
 	  struct rte_swx_table_selector_group *group);
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_selector_create, 21.08)
+RTE_EXPORT_SYMBOL(rte_swx_table_selector_create)
 void *
 rte_swx_table_selector_create(struct rte_swx_table_selector_params *params,
 			      struct rte_swx_table_selector_group **groups,
@@ -532,7 +532,7 @@ group_set(struct table *t,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_selector_group_set, 21.08)
+RTE_EXPORT_SYMBOL(rte_swx_table_selector_group_set)
 int
 rte_swx_table_selector_group_set(void *table,
 				 uint32_t group_id,
@@ -547,14 +547,14 @@ struct mailbox {
 
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_selector_mailbox_size_get, 21.08)
+RTE_EXPORT_SYMBOL(rte_swx_table_selector_mailbox_size_get)
 uint64_t
 rte_swx_table_selector_mailbox_size_get(void)
 {
 	return sizeof(struct mailbox);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_selector_select, 21.08)
+RTE_EXPORT_SYMBOL(rte_swx_table_selector_select)
 int
 rte_swx_table_selector_select(void *table,
 			      void *mailbox __rte_unused,
diff --git a/lib/table/rte_swx_table_selector.h b/lib/table/rte_swx_table_selector.h
index ef29bdb6b0..d13f556803 100644
--- a/lib/table/rte_swx_table_selector.h
+++ b/lib/table/rte_swx_table_selector.h
@@ -13,8 +13,6 @@
 
 #include <stdint.h>
 
-#include <rte_compat.h>
-
 #include "rte_swx_table.h"
 
 #ifdef __cplusplus
@@ -83,7 +81,6 @@ struct rte_swx_table_selector_group {
  * @return
  *   Selector table memory footprint in bytes.
  */
-__rte_experimental
 uint64_t
 rte_swx_table_selector_footprint_get(uint32_t n_groups_max, uint32_t n_members_per_group_max);
 
@@ -97,7 +94,6 @@ rte_swx_table_selector_footprint_get(uint32_t n_groups_max, uint32_t n_members_p
  * @return
  *   Selector table mailbox footprint in bytes.
  */
-__rte_experimental
 uint64_t
 rte_swx_table_selector_mailbox_size_get(void);
 
@@ -115,7 +111,6 @@ rte_swx_table_selector_mailbox_size_get(void);
  * @return
  *   Table handle, on success, or NULL, on error.
  */
-__rte_experimental
 void *
 rte_swx_table_selector_create(struct rte_swx_table_selector_params *params,
 			      struct rte_swx_table_selector_group **groups,
@@ -135,7 +130,6 @@ rte_swx_table_selector_create(struct rte_swx_table_selector_params *params,
  *   -EINVAL: Invalid argument(s);
  *   -ENOSPC: Too many group members.
  */
-__rte_experimental
 int
 rte_swx_table_selector_group_set(void *table,
 				 uint32_t group_id,
@@ -177,7 +171,6 @@ rte_swx_table_selector_group_set(void *table,
  *   0 when the operation is not yet completed, and 1 when the operation is complete. No other
  *   return values are allowed.
  */
-__rte_experimental
 int
 rte_swx_table_selector_select(void *table,
 			      void *mailbox,
@@ -191,7 +184,6 @@ rte_swx_table_selector_select(void *table,
  * @param[in] table
  *   Selector table handle.
  */
-__rte_experimental
 void
 rte_swx_table_selector_free(void *table);
 
diff --git a/lib/table/rte_swx_table_wm.c b/lib/table/rte_swx_table_wm.c
index c57738dda3..626192341a 100644
--- a/lib/table/rte_swx_table_wm.c
+++ b/lib/table/rte_swx_table_wm.c
@@ -458,7 +458,7 @@ table_lookup(void *table,
 	return 1;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_wildcard_match_ops, 21.05)
+RTE_EXPORT_SYMBOL(rte_swx_table_wildcard_match_ops)
 struct rte_swx_table_ops rte_swx_table_wildcard_match_ops = {
 	.footprint_get = NULL,
 	.mailbox_size_get = table_mailbox_size_get,
-- 
2.53.0

