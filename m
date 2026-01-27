Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F3CD340A2
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 16:33:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52EAA40E5E;
	Tue, 27 Jan 2026 17:33:10 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id B024540E54
 for <dev@dpdk.org>; Tue, 27 Jan 2026 17:33:08 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-435a517be33so3658387f8f.0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 08:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769531588;
 x=1770136388; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VS18PbzaXiY0cqOThK01jfpM1YzvKLR+Ml8ml/ATLwQ=;
 b=gEp7lddhg9Q+bSeharwKd7oyfJJ+skaaEFjNN+8Jm49duxrjRTh3JDBopMsFBeEcjw
 r4AMvbCerlZEh3zWC6pUaaJoGOXEk+pvYmSf2D8AY+v13qHn0x70uYlESFlf6H2lwSk3
 yK7Jrmt4dmLxMAgLREwk97l3anpGMq34QTd56IFpqxhwEACL3JYsKXWaFMieZ6CoNJ/P
 mZrkNc3Q8QpbqeZME8gBhue9N9pK0QVYAWA+fU44LjE28JQlOEUc3K3GA5jGJysZEUxC
 BQXyk3sj4+iYC1t8SBo1IuP0xulS0QT0Cr7iZPVU4m9EDvs4v5XWfRVR84d6OP+cqN8s
 e/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769531588; x=1770136388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VS18PbzaXiY0cqOThK01jfpM1YzvKLR+Ml8ml/ATLwQ=;
 b=BDHMxUBtwoOjt5olk0tQBMe329OODEqZMykhQiv67iTiuQWQU37xnDQFcEFzCJdIsi
 C+Fz7MsB8AHX0imwtil8K+17sltyc0cuX/ap984nJq/Ma39BN2lr1IQseVna1K/0wUH3
 Y+X+O95RZnFi1yqC3isz7FTi40AQAkfp/A/b/WZXoQgiTAN0l4kYxFIFVowfzTmituU2
 Cq1HzmABv0Ly1Ke8PJ45RG7V9vFfVDyaS/80vekFq+Tn/tuCBXcJFJKlxVH37IQXsWL7
 FGkdFscYQqis/4OpAaDrkPsIgIVlryLeKdT5IWfuwY4EfHsbHz+JlTvGKWr+UA5jzwGR
 dRTw==
X-Gm-Message-State: AOJu0YznhHB59QUo0YA6FYvFVKnXdB71arYOocj1O+lKhCm5IymHcr7O
 G6ziadeGZTKbULRevI5QjjH7cM6RZ2Ctemq3Qih1KehbcxCuHKAG0qVz7wZlDwUf4ZU4MJk2lQR
 hokHf
X-Gm-Gg: AZuq6aKInmdwdbkVV49GBV9gPI4g30DGKCUzF9z19JxmJikggZg724FTeMpEQ6XYLCm
 i+yJAW+27Vu38uFu5IhMDX9CruaEsvAzu4iOhte4U8fRYmeTMkOpP2CgbayISZSHRH5XyTT2u4B
 53BTxvfy+TF1XtbPAeURmMk/QI2GXbl4qcXapAv3oZ62mdLTm+UyKDLK4acLwNUHzYjsrvre7LS
 hI38/ByTeJPX2dmQhGW2cgiGBHZOxu33tKi5TV3gHoafUqXAAdu44QyOBcjqVhTS3DxjbuvH2bk
 Dmt9mVoHoxs7ZrkOjVgz/CUUt2FlbyYjQGA6UYk1xwtJSXCps/YG/449GTNDDV7KgSHx/DmAFfc
 7E41oUWe7zSAzmFCGJBTpCVtkHgGVVXVqXkzD3dGxALbU0ecgBcRUMqaLa72mPoJHjKsBoa7G71
 3W4UN1IAFTSiJkD5w55dNTGXBSySwMFypGEPzAL6dBeMZz66qN6g==
X-Received: by 2002:a05:6000:2383:b0:435:aecf:967d with SMTP id
 ffacd0b85a97d-435dd06f45amr3467629f8f.16.1769531588166; 
 Tue, 27 Jan 2026 08:33:08 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745dbsm39978513f8f.34.2026.01.27.08.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:33:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v13 02/17] hash: reject names that exceed maximum length
Date: Tue, 27 Jan 2026 08:30:16 -0800
Message-ID: <20260127163258.75566-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127163258.75566-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260127163258.75566-1-stephen@networkplumber.org>
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

Add missing length validation to rte_hash_create() and
rte_fbk_hash_create() that returns ENAMETOOLONG when the name
exceeds RTE_HASH_NAMESIZE or RTE_FBK_HASH_NAMESIZE respectively.
Previously these functions would silently truncate long names.

Also add truncation warnings for internally-generated ring names,
improve error messages to include the actual error code, and add
unit tests for the new validation.

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

