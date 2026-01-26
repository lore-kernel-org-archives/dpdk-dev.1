Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC03D19523
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 23:24:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBC0340A6D;
	Tue, 27 Jan 2026 00:24:40 +0100 (CET)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id 1C14140A6B
 for <dev@dpdk.org>; Tue, 27 Jan 2026 00:24:39 +0100 (CET)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-435a517be33so3082959f8f.0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 15:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769469879;
 x=1770074679; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QM0b6oOHmBaA/xeKyV95PaGvwk71NgzvuV3AEDvsABM=;
 b=r+VCXIeipap/bkY3HzeohbWRDS0LuZ1V1eDtRB+Wp7KIcih8xtvavd3h8Z3Kf1d/hT
 BMD8j/7GFNix6cG+eUS0epkeoGmoi4mIgE+vofNB0Nf+2MF+GrS8FUj+znv30v131FQV
 ObZ46IVb37Xjho+hmg19gKxecH+x0Hdn2x7otf9LoX/wv9xT+dDd0jJyd5eXjsG/c/G/
 X4lFgyWqciWzzhKdN9znK3EH2s4X3nRpIfmiEuO/z/7RSoym2YnwO1n+qUUd/WsTs8Sz
 fQA8N7B1yFiOp62dZXGKOgzp/EtjCAv0IQiJAlWQtDAIJrtCWMlwXR/KpgZAagKJQVUa
 DuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769469879; x=1770074679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QM0b6oOHmBaA/xeKyV95PaGvwk71NgzvuV3AEDvsABM=;
 b=b0/TH46DgWu98VsJsrfCUkOGwQ3qyFm31utkOxUY6aw3Ls7po262jgVsSmTaNURoeG
 SKrx9LJxbfW8sHfz9LsjtqbG2Ur5gN9jCA1hrZfrGQ2aMvtcJJBcsVJL+vq248xDRX2C
 TGvIxE1imCw8/4eOiAToiRLXVPmmvu7a6rPsqQb+q7KchTvP0lQ//iXe9jeYRx1OSL4j
 RAbqxOAGk62Recg0yVcn4sH/dmQACP2iVrj1yFZNtdUFvShrixjktuZM2m8lehRjVWrt
 Xv/FXqKz+nCS5lJN+dw1am4mC99WHv1ZWO24K+7/9+woNzVp1vriwJsTbCSOclV554c9
 SN2g==
X-Gm-Message-State: AOJu0YwvTFDKmNobD7XWeNQqPLmVNyOxWFd9WV2HxiwwRb4E+bWB/u0/
 z4nxvN1XvDV3zH+S4U0PD7MnLA9OrmvIjEcoTis32nA7KU/bUnoN+PIeCOqiTogqRjPJ/0ZWvhN
 7hur+
X-Gm-Gg: AZuq6aJIbCMSalUcWJMcWI+hRid1DSIVn1vhWIY78W2eIeZvXruMxYSIqYMZFXGkb4k
 LXq32I1INUsM7qyQD/5Oy9Tm45wTU8fKBthi9wyM0GIDSHAJgOfdAdRG2/tESl4IPnbmeOFbLWo
 IbzOca+16c4gdzNynlgu8tEzdoHX2FpXp+OIKBNxq+8cOlwz4rNiw4FKuKnJ45o92fnjgeNVJPF
 waO8tm4c8IFa587PSjHPeLkatq1Lm7njBkVxDbaylJXGqJIsg68dn9X6mlC0v7k7GmZWiFXLWMc
 +3e+aCgTBa+GjyWZxMBEuDuf92qHpVqveJjhW8CZ877z3vEK4YYrjwT79P++UNeEkqADa8M60Dn
 fZ6S7eC6KPR3paX+VZwqpsGyjS+fprM/a3LUPFqCbcQhntS4EO5sAmuwzwc1buvq0T+XBIiDoEy
 PYkPAk6HLT/Uiaaew49NS2ruwGG6c4CaxTVp3Eec/5R8MTdU7Cng==
X-Received: by 2002:a05:6000:430c:b0:431:8f8:7f1a with SMTP id
 ffacd0b85a97d-435ca188832mr9630565f8f.31.1769469878630; 
 Mon, 26 Jan 2026 15:24:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24a6fsm33711846f8f.16.2026.01.26.15.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 15:24:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v12 02/17] hash: add checks for hash name length
Date: Mon, 26 Jan 2026 15:22:10 -0800
Message-ID: <20260126232428.276534-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126232428.276534-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260126232428.276534-1-stephen@networkplumber.org>
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

Add a missing check to the API that the name is within the current
defined maximum name size. This name is then used internally to
create ring names, those names could get truncated; if a name
is truncated add message to log.

If ring creation fails it might be because of name conflict,
so change the log message to decode error value.

Add additional tests as well.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_hash.c                   | 21 +++++++++++++
 doc/guides/rel_notes/release_26_03.rst |  3 ++
 lib/hash/rte_cuckoo_hash.c             | 41 ++++++++++++++++++--------
 lib/hash/rte_fbk_hash.c                | 12 ++++++--
 lib/hash/rte_fbk_hash.h                |  1 +
 5 files changed, 63 insertions(+), 15 deletions(-)

diff --git a/app/test/test_hash.c b/app/test/test_hash.c
index a70e2620c0..3fb3d96d05 100644
--- a/app/test/test_hash.c
+++ b/app/test/test_hash.c
@@ -1120,6 +1120,14 @@ fbk_hash_unit_test(void)
 		.socket_id = RTE_MAX_NUMA_NODES + 1, /* invalid socket */
 	};
 
+	/* try and create hash with an excessively long name */
+	struct rte_fbk_hash_params invalid_params_long_name = {
+		.name = "four_byte_key_hash_name_length_32",
+		.entries = 4,
+		.entries_per_bucket = 2,
+		.socket_id = 0,
+	};
+
 	/* try to create two hashes with identical names
 	 * in this case, trying to create a second one will not
 	 * fail but will simply return pointer to the existing
@@ -1201,6 +1209,9 @@ fbk_hash_unit_test(void)
 	handle = rte_fbk_hash_create(&invalid_params_7);
 	RETURN_IF_ERROR_FBK(handle != NULL, "fbk hash creation should have failed");
 
+	handle = rte_fbk_hash_create(&invalid_params_long_name);
+	RETURN_IF_ERROR_FBK(handle != NULL, "fbk hash creation should have failed");
+
 	if (rte_eal_has_hugepages()) {
 		handle = rte_fbk_hash_create(&invalid_params_8);
 		RETURN_IF_ERROR_FBK(handle != NULL,
@@ -1439,6 +1450,16 @@ static int test_hash_creation_with_bad_parameters(void)
 		return -1;
 	}
 
+	memcpy(&params, &ut_params, sizeof(params));
+	params.name = "hash_creation_with_too_long_name";
+	params.socket_id = SOCKET_ID_ANY;
+	handle = rte_hash_create(&params);
+	if (handle != NULL) {
+		rte_hash_free(handle);
+		printf("Impossible creating hash successfully with long name\n");
+		return -1;
+	}
+
 	/* test with same name should fail */
 	memcpy(&params, &ut_params, sizeof(params));
 	params.name = "same_name";
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 13f753abe8..b966ce7b49 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -84,12 +84,15 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+
 * **Added additional length checks for name parameter lengths.**
 
   Several library functions now have additional name length checks
   instead of silently truncating.
 
   * lpm: name must be less than RTE_LPM_NAMESIZE.
+  * hash: name parameter must be less than RTE_HASH_NAMESIZE.
+
 
 
 ABI Changes
diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index 2c92c51624..f9c4a0e302 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -170,7 +170,6 @@ rte_hash_create(const struct rte_hash_parameters *params)
 	void *buckets = NULL;
 	void *buckets_ext = NULL;
 	char ring_name[RTE_RING_NAMESIZE];
-	char ext_ring_name[RTE_RING_NAMESIZE];
 	unsigned num_key_slots;
 	unsigned int hw_trans_mem_support = 0, use_local_cache = 0;
 	unsigned int ext_table_support = 0;
@@ -222,6 +221,13 @@ rte_hash_create(const struct rte_hash_parameters *params)
 		return NULL;
 	}
 
+	if (strlen(params->name) >= RTE_HASH_NAMESIZE) {
+		rte_errno = ENAMETOOLONG;
+		HASH_LOG(ERR, "%s() name '%s' exceeds maximum length %d",
+			 __func__, params->name, RTE_HASH_NAMESIZE);
+		return NULL;
+	}
+
 	/* Validate correct usage of extra options */
 	if ((params->extra_flag & RTE_HASH_EXTRA_FLAGS_RW_CONCURRENCY) &&
 	    (params->extra_flag & RTE_HASH_EXTRA_FLAGS_RW_CONCURRENCY_LF)) {
@@ -272,12 +278,16 @@ rte_hash_create(const struct rte_hash_parameters *params)
 	else
 		num_key_slots = params->entries + 1;
 
-	snprintf(ring_name, sizeof(ring_name), "HT_%s", params->name);
+	/* Ring name may get truncated, conflict detected on ring creation */
+	if (snprintf(ring_name, sizeof(ring_name), "HT_%s", params->name)
+	    >= (int)sizeof(ring_name))
+		HASH_LOG(NOTICE, "ring name truncated to '%s'", ring_name);
+
 	/* Create ring (Dummy slot index is not enqueued) */
 	r = rte_ring_create_elem(ring_name, sizeof(uint32_t),
 			rte_align32pow2(num_key_slots), params->socket_id, 0);
 	if (r == NULL) {
-		HASH_LOG(ERR, "memory allocation failed");
+		HASH_LOG(ERR, "ring creation failed: %s", rte_strerror(rte_errno));
 		goto err;
 	}
 
@@ -286,20 +296,25 @@ rte_hash_create(const struct rte_hash_parameters *params)
 
 	/* Create ring for extendable buckets. */
 	if (ext_table_support) {
-		snprintf(ext_ring_name, sizeof(ext_ring_name), "HT_EXT_%s",
-								params->name);
+		char ext_ring_name[RTE_RING_NAMESIZE];
+
+		if (snprintf(ext_ring_name, sizeof(ext_ring_name),
+			     "HT_EXT_%s", params->name) >= (int)sizeof(ext_ring_name))
+			HASH_LOG(NOTICE, "external ring name truncated to '%s'", ext_ring_name);
+
 		r_ext = rte_ring_create_elem(ext_ring_name, sizeof(uint32_t),
 				rte_align32pow2(num_buckets + 1),
 				params->socket_id, 0);
-
 		if (r_ext == NULL) {
-			HASH_LOG(ERR, "ext buckets memory allocation "
-								"failed");
+			HASH_LOG(ERR, "ext buckets ring create failed: %s",
+				 rte_strerror(rte_errno));
 			goto err;
 		}
 	}
 
-	snprintf(hash_name, sizeof(hash_name), "HT_%s", params->name);
+	if (snprintf(hash_name, sizeof(hash_name), "HT_%s", params->name)
+	    >= (int)sizeof(hash_name))
+		HASH_LOG(NOTICE, "%s() hash name truncated to '%s'", __func__, hash_name);
 
 	rte_mcfg_tailq_write_lock();
 
@@ -1606,8 +1621,9 @@ rte_hash_rcu_qsbr_add(struct rte_hash *h, struct rte_hash_rcu_config *cfg)
 		/* No other things to do. */
 	} else if (cfg->mode == RTE_HASH_QSBR_MODE_DQ) {
 		/* Init QSBR defer queue. */
-		snprintf(rcu_dq_name, sizeof(rcu_dq_name),
-					"HASH_RCU_%s", h->name);
+		if (snprintf(rcu_dq_name, sizeof(rcu_dq_name),
+			     "HASH_RCU_%s", h->name) >= (int)sizeof(rcu_dq_name))
+			HASH_LOG(NOTICE, "HASH defer queue name truncated to: %s", rcu_dq_name);
 		params.name = rcu_dq_name;
 		params.size = cfg->dq_size;
 		if (params.size == 0)
@@ -1623,7 +1639,8 @@ rte_hash_rcu_qsbr_add(struct rte_hash *h, struct rte_hash_rcu_config *cfg)
 		h->dq = rte_rcu_qsbr_dq_create(&params);
 		if (h->dq == NULL) {
 			rte_free(hash_rcu_cfg);
-			HASH_LOG(ERR, "HASH defer queue creation failed");
+			HASH_LOG(ERR, "HASH defer queue creation failed: %s",
+				 rte_strerror(rte_errno));
 			return 1;
 		}
 	} else {
diff --git a/lib/hash/rte_fbk_hash.c b/lib/hash/rte_fbk_hash.c
index 38b15a14d1..45d4a13427 100644
--- a/lib/hash/rte_fbk_hash.c
+++ b/lib/hash/rte_fbk_hash.c
@@ -5,6 +5,7 @@
 #include <stdint.h>
 #include <stdio.h>
 #include <string.h>
+#include <stdlib.h>
 #include <errno.h>
 #include <sys/queue.h>
 
@@ -83,7 +84,7 @@ rte_fbk_hash_create(const struct rte_fbk_hash_params *params)
 {
 	struct rte_fbk_hash_table *ht = NULL;
 	struct rte_tailq_entry *te;
-	char hash_name[RTE_FBK_HASH_NAMESIZE];
+	char hash_name[RTE_FBK_HASH_NAMESIZE + sizeof("FBK_")];
 	const uint32_t mem_size =
 			sizeof(*ht) + (sizeof(ht->t[0]) * params->entries);
 	uint32_t i;
@@ -96,6 +97,7 @@ rte_fbk_hash_create(const struct rte_fbk_hash_params *params)
 	/* Error checking of parameters. */
 	if ((!rte_is_power_of_2(params->entries)) ||
 			(!rte_is_power_of_2(params->entries_per_bucket)) ||
+			(params->name == NULL) ||
 			(params->entries == 0) ||
 			(params->entries_per_bucket == 0) ||
 			(params->entries_per_bucket > params->entries) ||
@@ -105,6 +107,11 @@ rte_fbk_hash_create(const struct rte_fbk_hash_params *params)
 		return NULL;
 	}
 
+	if (strlen(params->name) >= RTE_FBK_HASH_NAMESIZE) {
+		rte_errno = ENAMETOOLONG;
+		return NULL;
+	}
+
 	snprintf(hash_name, sizeof(hash_name), "FBK_%s", params->name);
 
 	rte_mcfg_tailq_write_lock();
@@ -128,8 +135,7 @@ rte_fbk_hash_create(const struct rte_fbk_hash_params *params)
 	}
 
 	/* Allocate memory for table. */
-	ht = rte_zmalloc_socket(hash_name, mem_size,
-			0, params->socket_id);
+	ht = rte_zmalloc_socket(hash_name, mem_size, 0, params->socket_id);
 	if (ht == NULL) {
 		HASH_LOG(ERR, "Failed to allocate fbk hash table");
 		rte_free(te);
diff --git a/lib/hash/rte_fbk_hash.h b/lib/hash/rte_fbk_hash.h
index 4aebffd8bf..6b70cfaa0b 100644
--- a/lib/hash/rte_fbk_hash.h
+++ b/lib/hash/rte_fbk_hash.h
@@ -348,6 +348,7 @@ void rte_fbk_hash_free(struct rte_fbk_hash_table *ht);
  *    - ENOSPC - the maximum number of memzones has already been allocated
  *    - EEXIST - a memzone with the same name already exists
  *    - ENOMEM - no appropriate memory area found in which to create memzone
+ *    - ENAMETOOLONG - name in parameters exceeds RTE_FBK_HASH_NAMESIZE
  */
 struct rte_fbk_hash_table *
 rte_fbk_hash_create(const struct rte_fbk_hash_params *params)
-- 
2.51.0

