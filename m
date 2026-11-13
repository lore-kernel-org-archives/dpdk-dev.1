Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3944F606B2E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YoaVoS8B
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54F0042B71;
	Fri, 13 Nov 2026 17:05:56 +0100 (CET)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTPS id 6A8F94028E
 for <dev@dpdk.org>; Fri, 13 Nov 2026 15:35:30 +0100 (CET)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-8a05b210703so480450b3a.0
 for <dev@dpdk.org>; Fri, 13 Nov 2026 06:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794580528; x=1795185328; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5V39OEfNfEtcNwAgSSnA2TzNhX7wCJ9OLb73SFAIqXk=;
 b=YoaVoS8BO2hZWQbVQQZWOQd/tyXTIh5mQEUNQrBJ2Zh9knlY4cYQs9A7lX2hL0hezV
 pptRe45qsszOpLSfH8iuSF7DM39/a/EQi1wDxy22cSOECBAc8qpTFfMo4oyiNuQA5wV7
 kXHG5OmLFSYor94M9EhBF+s0L8XbwoaJrSRQE1dbQYuTQw+CTthDJiPN/G1xmXBpNWrP
 KbWBMS9wju1OuMe2/uWR5t2rew/ywnKtTUn1GCWjP6XB4hlq20Oul+tok7huHIOoci3R
 9u7sCmfGcKBMkrwUEjrK+TpDTQJJQHY9P8YHBaAiKy795CGwkSLQ/sx1JJv/D3MQghAi
 axjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794580528; x=1795185328;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5V39OEfNfEtcNwAgSSnA2TzNhX7wCJ9OLb73SFAIqXk=;
 b=QqiHzZzSMTetozjorNgtxKoxeS5Vob2CNyrOw0Pd534MIjC2TQj6pvQbYMVH9S7vPQ
 DkuBQWp3Di5OVSDget8fCDihQ4Ns3LnuCw1NLduJ9yo8IqL9r0VrSzgzqe7zGV3X9Dmk
 YnGUZLsZEXi0ghP+NBKPRnbnCYlQ7BG4zcG/0EB0pv81/BcwR5sw2/Oayu4QzFkLmg9M
 G+/E7SkT768OWOAFy6FCxjBs6P3GtGJUDvwJxQlDF2pRnAXAuTz2D+fz6tpvs/YyhSf4
 R23UxkpYk1DbyWRJKxBQISrQO4CZ+3NvsW6ucFlmFE88nAtrfkA1hWtGHEF8uJUfWYcB
 SyjA==
X-Gm-Message-State: APuU4Z/6RYc0v3rGPDUopuxgamqNg9N+ZUoS6y4cS0GwyirdCnId2mMe
 NFD8LWPFkO7IalO3Emp7YnZJGHP9acksu/wNzl7NrBNq9+1T/fN7Aer3
X-Gm-Gg: AYBFou3nFNKsNUXfbEzQgBH6Jw6YEyyN1CPnqLtKGms5vJqUuo4uqlMB+xUZWUBj+xe
 dy45UlHxO+bPZbsQr9YEkZemIt3CtQTy/byCXCkBqj8hfm1UmY+DppRU6EnNdsTzzGVpush7atT
 dtk9XqfK3RXWOZzRBVZu1aTMHJ0kZnCZ0llvlqgzogLMkhn++ySg73HQrTaAN5bR142BMNKvdVn
 0j0LiwA073kkSRfx/g79jwP17ur974Q6QNyVa4ds1DddJOLr9KxthZ1C8GriuGB1Z3Y45kcYB71
 EEMMMIFlceMxWvhSok0JWbvUQY1V1VZyiLubbED4mh71aKl6TUWOHLEmXkKeLs532hA1pSi/Aes
 pjLboN8H9Jzl/9yFRTz4II9eA+qmo6NeyDqaLq2x1RblCyNqUvm83YxA3EwlofagE04Pz8TOnjr
 cVEhsgaQzrStF2GsVMmTD96hBwGVerlPAI4nvnc9VA0ggr/aS36k1lz/bKeTQ8d8rAJmnZX8y1U
 nM7F7d0nAlZ2MaxQ2peEkN21/QHMQ++8NwVc/cuNYz9/Y/ywFuhJzGPk5txBcdvFR31WLGmkqro
 4wcThL3FV/F6u/6FOg32R62XdTHWs0iYT9FJTgcBTIG6T63M
X-Received: by 2002:a05:6a20:939b:b0:3e2:a0a4:8ab2 with SMTP id
 adf61e73a8af0-3f7a4dbfc2amr2295667637.2.1794580528455; 
 Fri, 13 Nov 2026 06:35:28 -0800 (PST)
Received: from localhost.localdomain ([85.172.76.155])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cddc18c800esm1313706a12.29.2026.11.13.06.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 06:35:27 -0800 (PST)
From: Bulatov Mark <ms.bulatov7@gmail.com>
To: Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Mark Bulatov <ms.bulatov7@gmail.com>
Subject: [PATCH 25.11] table: fix no cast overflow
Date: Fri, 13 Nov 2026 17:34:29 +0300
Message-Id: <20261113143429.6366-1-ms.bulatov7@gmail.com>
X-Mailer: git-send-email 2.39.5
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Nov 2026 17:05:48 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mark Bulatov <ms.bulatov7@gmail.com>

The sum p->n_buckets + n_buckets_ext fits within the bounds of a uint32_t.
However, multiplying this result by bucket_size causes an overflow.

Fix this by using type casting.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: fc972a1305 ("table: rework 16-byte key hash tables")
Fixes: ea31510376 ("table: rework 32-byte key hash tables")
Fixes: 36842d0aee ("table: rework 8-byte key hash tables")
Cc: stable@dpdk.org

Signed-off-by: Mark Bulatov <ms.bulatov7@gmail.com>
---
 lib/table/rte_table_hash_key16.c | 2 +-
 lib/table/rte_table_hash_key32.c | 2 +-
 lib/table/rte_table_hash_key8.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/table/rte_table_hash_key16.c b/lib/table/rte_table_hash_key16.c
index 5b69106dd7..99ccf3f549 100644
--- a/lib/table/rte_table_hash_key16.c
+++ b/lib/table/rte_table_hash_key16.c
@@ -394,7 +394,7 @@ rte_table_hash_create_key16_ext(void *params,
 		KEYS_PER_BUCKET * entry_size);
 	stack_size = RTE_CACHE_LINE_ROUNDUP(n_buckets_ext * sizeof(uint32_t));
 	total_size = sizeof(struct rte_table_hash) +
-		(p->n_buckets + n_buckets_ext) * bucket_size + stack_size;
+		(uint64_t)(p->n_buckets + n_buckets_ext) * bucket_size + stack_size;
 	if (total_size > SIZE_MAX) {
 		TABLE_LOG(ERR, "%s: Cannot allocate %" PRIu64 " bytes "
 			"for hash table %s",
diff --git a/lib/table/rte_table_hash_key32.c b/lib/table/rte_table_hash_key32.c
index 0963f57828..1b359bbeb8 100644
--- a/lib/table/rte_table_hash_key32.c
+++ b/lib/table/rte_table_hash_key32.c
@@ -403,7 +403,7 @@ rte_table_hash_create_key32_ext(void *params,
 		KEYS_PER_BUCKET * entry_size);
 	stack_size = RTE_CACHE_LINE_ROUNDUP(n_buckets_ext * sizeof(uint32_t));
 	total_size = sizeof(struct rte_table_hash) +
-		(p->n_buckets + n_buckets_ext) * bucket_size + stack_size;
+		(uint64_t)(p->n_buckets + n_buckets_ext) * bucket_size + stack_size;
 	if (total_size > SIZE_MAX) {
 		TABLE_LOG(ERR, "%s: Cannot allocate %" PRIu64 " bytes "
 			"for hash table %s",
diff --git a/lib/table/rte_table_hash_key8.c b/lib/table/rte_table_hash_key8.c
index 5e9dcf10ee..8fd80edafc 100644
--- a/lib/table/rte_table_hash_key8.c
+++ b/lib/table/rte_table_hash_key8.c
@@ -379,7 +379,7 @@ rte_table_hash_create_key8_ext(void *params, int socket_id, uint32_t entry_size)
 		KEYS_PER_BUCKET * entry_size);
 	stack_size = RTE_CACHE_LINE_ROUNDUP(n_buckets_ext * sizeof(uint32_t));
 	total_size = sizeof(struct rte_table_hash) +
-		(p->n_buckets + n_buckets_ext) * bucket_size + stack_size;
+		(uint64_t)(p->n_buckets + n_buckets_ext) * bucket_size + stack_size;
 
 	if (total_size > SIZE_MAX) {
 		TABLE_LOG(ERR, "%s: Cannot allocate %" PRIu64 " bytes "
-- 
2.39.5

