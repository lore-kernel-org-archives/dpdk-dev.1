Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DE4D6CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 04:30:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6B4B4027A;
	Fri, 23 Jan 2026 05:29:57 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id C54004021F
 for <dev@dpdk.org>; Fri, 23 Jan 2026 05:29:55 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-432d28870ddso959666f8f.3
 for <dev@dpdk.org>; Thu, 22 Jan 2026 20:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769142595;
 x=1769747395; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iqs2jG9P+2bV0vm8Ej4RPQzI4JH7fvY1VbTdH7yj5q0=;
 b=Yzwq8HQTC8l5bQ/Spm6Fa/pfYznksFMjPQSiJYE3lfffEBPMzYRMJx0pNckXPSa6Vs
 cKlxUGjfiE4KZ5+UzM1sEXzTbq0Zy9U1maOLORzLgFZ88Gox8X2Gt1Hs7tXFoPRxzfrq
 GcGPg4Ddi0x+s3zZ6IDgscgH1ukyxsuutlTt0prZqJSMwVOLoE+yjPdKjn40V9AB1sZB
 i3Wn2kdJoBxzmDBbSUkMhHgofcBPbo4gE1dFxyeYyLLU8sx96vKMUfchiu8jbJKX9x98
 TAuyehMf/nECc0V3cIw9XJbwn9nWWSMPmXEiVYnSgz+r+g3kIRF/L3kfaoaDdTe8r/2L
 McIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769142595; x=1769747395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iqs2jG9P+2bV0vm8Ej4RPQzI4JH7fvY1VbTdH7yj5q0=;
 b=f+QLOpKI/sE2BKmYAmlLogJmp0KvQHoFk67ceru1m6BOnSeKQ4bSfEbQytehakSajh
 kgh2gCOd/6G3rwVJTq1dEa/sAWA1LQ52woRBedGcfza8qy0ap51ZxEDpaLzpDxlTz6dk
 EvLctdLczgx+EPEBPXbROPJjKOxe3lozn9CbBQEpGL+0fPIzh03LLbnVICHH6If4HCMm
 aE+t8dClg7T6bUmNakW2I2DBIaqBDv8J+d1vIkBjtlgQXJC2lNJVFAIOpnk3fEIp0lsx
 feOBDDh7Tn77y+d9bAs/QNzvxMFN2bBKVcqAJ2i/GPXuKSzQfDlfi3AbnFKROuz5n+iS
 pPtA==
X-Gm-Message-State: AOJu0Yys97JGACYhVxyFMyZCQ/gFcaNS/N/vcIJfXxxW+vLuAE66sWG8
 nPUOailve2y2ee8RfrbmIai+kIvMuyJD58jHLkBe/iwnjW4n1sHlST8DAAHxo1lYrrvbnMr7NHq
 bXuMt
X-Gm-Gg: AZuq6aLNy5jmbUcf/H840BSpzt9Fzs+DIcR6YW9ZpxzgCS0D/zTpKR9iM+hyWiDNxzK
 Q5H1yH68D+AkpZ02v5RQ/LHwVYqlZNQH0f1S/Umc1g0/nu3909JRR7LwMhB3n612OLnE8NM//47
 vxWGcnDbwyi9Jg9bd8zw5rABb9mn0ihtXRbh9Clsz5Oes/3/Ck5PRVo3fcgpbRDP6SNaFS7wddk
 hv/LjO2IbwH7I59zcv1QaOOvSRerzr/Xa8aiC2HMpiCqOpArFrxXAsKOSP/+Kn7mB9GurJKkcd0
 rP4Bvt78uBgKoj+AsAGfsw3rKSrbad2Bw2lKb6+SCVz5N13UmErRhm4bO6wVIBY4JqJ31bz1qsK
 r1FqotBQlBG0f3DKzcZqj8YPetrXTaNfcc7oFwfggIz2zMLy/38ao3TygGXsExbOOWJBQEP1pUU
 25x0A2kPe9R5dr1LA15Gfdz7ECNbF53j8T3I5nZ83zFJwkkyJWV/c86ofVLPlx
X-Received: by 2002:a05:6000:26c5:b0:435:9ce0:f93c with SMTP id
 ffacd0b85a97d-435b967e20emr17508f8f.62.1769142595207; 
 Thu, 22 Jan 2026 20:29:55 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b41asm3603771f8f.39.2026.01.22.20.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 20:29:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v11 02/18] hash: add checks for hash name length
Date: Thu, 22 Jan 2026 20:28:00 -0800
Message-ID: <20260123042945.159075-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123042945.159075-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260123042945.159075-1-stephen@networkplumber.org>
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
index a70e2620c0..ad6cb8e422 100644
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

