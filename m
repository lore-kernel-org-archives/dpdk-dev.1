Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D37E784BE
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 20:19:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C64D4065B;
	Sun, 28 Dec 2025 21:19:39 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id E61C740651
 for <dev@dpdk.org>; Sun, 28 Dec 2025 21:19:32 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso67606025e9.0
 for <dev@dpdk.org>; Sun, 28 Dec 2025 12:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766953172;
 x=1767557972; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/1PWFyurYOZ/StCT2ahbxSndTGeMa64DSOh4/RhA+k=;
 b=F7qFtylORSAH3njoUEg57XfRgl5r/+jnGrUxxjqmEfPm3rrgK60cFqFsloACXITLo+
 eRVqs4CEVTQxccklTukimrrYNg2CSTpReklBHuJoCjM2Tn536dWB+ONO1AzUKcdtXM15
 VE4gddLnBqS4yuErgo1tfFbO1XBQEEfrKc9bN+9gFvCdNnf6GUfo7WFLa/+8bBavUgjL
 S8poxZIHztCd50Nh1GLeDfyOrspWVNorDGB7sNJws7igCCFxgN5+0r13obc0LrPk7t/8
 0IHaXvpx20t7RLUSleVZ7+WgLYAuvIaXHgYI4EBDk3uRs5Pwf9Y9JEZ3cuSXLAUs8cs+
 Rixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766953172; x=1767557972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e/1PWFyurYOZ/StCT2ahbxSndTGeMa64DSOh4/RhA+k=;
 b=BhEhDV6eK/MyRsoYJwHXpwn/kewNciXWeWvxu5TQAgZ/tOQKNLmeIzgZyKcyOHGfyM
 WHAozkPJKKJVl81i8D33znNgXdTKSpTFHBXIsu4k9L24lRdOeyWhNCqsLtostE3oa/uq
 RmVH78f+G9BaWaG3s/0b6W21re7qehg5gJQSFzbx8q7mmu6oB8NwTQSAlpA1sOrlOl/5
 t+NWmopZglBCjNZwtoy7BARJhAEmJ11m5g9S+swjyGL3Ilh4Mu2XEbb43ih1igk+kgvI
 F8cFaDLCAMkIiA7w2njoVCmX1HXMbt7lPtir5CyQ4wzRazuHwr/voMIz9iLvLPa6uU4v
 ZOQw==
X-Gm-Message-State: AOJu0YxF6HZ92XgKMlqveJjV7TsmbZS7DG0yd1aHPXe3ICVVNngVb3N2
 xmTD+i48GWmrcrgYZ0I4xfQJcdNQYg+5hatZcGI1uSPZ7GkSF5wuFic3ayHcwJXqGzxpjcXR9Ki
 j+h4NbNA=
X-Gm-Gg: AY/fxX4I1/91FwIldMyUwOvXlBjJ5xHNt1OaD5Hm1G1Q9cdELfuCvUywHtKhBOX+Msa
 HhYAZsGkpro0NvQEPrXHf/mL1b7K9kW8ZBwJlS/A7/VFZYA2HArcl/fZvJt4nGT5r0+e5i65A+s
 JKisKgYGj58oorBsfhEZzkE6rAagsuPWGdO9d5aHHltbhynsVHFo4VkjYnrSQ0R1BskZHBbnSdB
 tLY61O8bv8HjGLaOFGDuMWoYr7bciqxO7RTJIGUPp3U0eRpYf4Lyq1lNfDv2AoknHIMsUoPIRTr
 xj1SxSzb4N7UMwxj7ANUUykVO/qlwaZjj+va4mpRI4bq/NNfCs/CmMFVtYRIs5k89qc2SwYowIX
 vvSHsFQY46S8kpW1+hoqpEmuj3hHFY3R0SRsvI4o9Yx6Vxv6Zq+8WEgftGIj42EyfXDpgq2qk1C
 RAWLyZGVAn0LXYeuvVsnfzckWDQZs7DORzT4Op0DpMfJ+UIYPESg==
X-Google-Smtp-Source: AGHT+IEheWBrQSBYbGgjm7e+QAAHlWMti3PUOmYwttooXDN4vUmawG9xBeASsFWBwYI6/YiMPIYhRQ==
X-Received: by 2002:a05:600c:19ca:b0:477:a289:d854 with SMTP id
 5b1f17b1804b1-47d18b98f87mr335296105e9.5.1766953172503; 
 Sun, 28 Dec 2025 12:19:32 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3964226sm240319655e9.0.2025.12.28.12.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 12:19:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v8 02/18] hash: add checks for hash name length
Date: Sun, 28 Dec 2025 10:56:05 -0800
Message-ID: <20251228201236.547268-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228201236.547268-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251228201236.547268-1-stephen@networkplumber.org>
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
index 5791fd7f4c..0b608a3d74 100644
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
+	params.socket_id = RTE_MAX_NUMA_NODES + 1;
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
index 15dabee7a1..a12bd41e86 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -84,6 +84,9 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* hash: Added name length validation to hash creation.
+  The hash name in hash parameters is now checked against RTE_HASH_NAMESIZE.
+
 
 ABI Changes
 -----------
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
index 4aebffd8bf..cea59127fe 100644
--- a/lib/hash/rte_fbk_hash.h
+++ b/lib/hash/rte_fbk_hash.h
@@ -348,6 +348,7 @@ void rte_fbk_hash_free(struct rte_fbk_hash_table *ht);
  *    - ENOSPC - the maximum number of memzones has already been allocated
  *    - EEXIST - a memzone with the same name already exists
  *    - ENOMEM - no appropriate memory area found in which to create memzone
+ *    - ENAMETOOLONG - name is parameters exceeds RTE_FBK_HASH_NAMESIZE
  */
 struct rte_fbk_hash_table *
 rte_fbk_hash_create(const struct rte_fbk_hash_params *params)
-- 
2.51.0

