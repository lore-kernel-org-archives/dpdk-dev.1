Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9FB606B240
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MO7ZGqF4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56794410FC;
	Tue,  3 Nov 2026 15:56:39 +0100 (CET)
Received: from mta0.migadu.com (out-249.mta0.migadu.com [91.218.175.249])
 by mails.dpdk.org (Postfix) with ESMTPS id DC79640430
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:56:38 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=Qc7bv1J03qvQnyM3h2kJDpzmVkMSsvk8jeQV8aUWZ8g=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717798; v=1; x=1794322598;
 b=MO7ZGqF4Woh3/p4mM6qjKoCUY7yvg7AQM0Jr+vfx9y0rAubuzzIjeQwNbj0QzHFJ0zXmnN2W
 MdvYWdlopLE/w75v6LOfUSNiv4vVN4qOGzJeOOKvjeYIY8EC+sM10RgmstENZuswk67zHYedv0u
 Ix/PYeZjwxNbIE7aTkif4tKM=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id bbf5ede8b48c4766;
 Tue, 03 Nov 2026 14:56:38 +0000
X-Mizu-Trace-ID: bbf5ede8b48c4766
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 020/227] efd: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:38 +0800
Message-ID: <20261103145306.487255-21-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, internal variables and comments to
the NUMA node terminology, and switch internal calls to
rte_zmalloc_numa(), rte_numa_id() and RTE_NUMA_ID_ANY.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/efd/rte_efd.c | 104 +++++++++++++++++++++++-----------------------
 lib/efd/rte_efd.h |  38 ++++++++---------
 2 files changed, 71 insertions(+), 71 deletions(-)

diff --git a/lib/efd/rte_efd.c b/lib/efd/rte_efd.c
index 4dfc0ec9a4..a578050f59 100644
--- a/lib/efd/rte_efd.c
+++ b/lib/efd/rte_efd.c
@@ -307,8 +307,8 @@ efd_get_bin_id(const struct rte_efd_table * const table,
  *
  * @param table
  *  EFD table to reference
- * @param socket_id
- *   Socket ID to use to look up existing values (ideally caller's socket id)
+ * @param numa_id
+ *   NUMA node ID to use to look up existing values (ideally caller's NUMA node)
  * @param chunk_id
  *   Chunk ID of bin to look up
  * @param bin_id
@@ -319,10 +319,10 @@ efd_get_bin_id(const struct rte_efd_table * const table,
  */
 static inline uint8_t
 efd_get_choice(const struct rte_efd_table * const table,
-		const unsigned int socket_id, const uint32_t chunk_id,
+		const unsigned int numa_id, const uint32_t chunk_id,
 		const uint32_t bin_id)
 {
-	struct efd_online_chunk *chunk = &table->chunks[socket_id][chunk_id];
+	struct efd_online_chunk *chunk = &table->chunks[numa_id][chunk_id];
 
 	/*
 	 * Grab the chunk (byte) that contains the choices
@@ -501,12 +501,12 @@ efd_search_hash(struct rte_efd_table * const table,
 RTE_EXPORT_SYMBOL(rte_efd_create)
 struct rte_efd_table *
 rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
-		uint64_t online_cpu_socket_bitmask, uint8_t offline_cpu_socket)
+		uint64_t online_cpu_numa_bitmask, uint8_t offline_cpu_numa)
 {
 	struct rte_efd_table *table = NULL;
 	uint8_t *key_array = NULL;
 	uint32_t num_chunks, num_chunks_shift;
-	uint8_t socket_id;
+	uint8_t numa_id;
 	struct rte_efd_list *efd_list = NULL;
 	struct rte_tailq_entry *te;
 	uint64_t offline_table_size;
@@ -516,8 +516,8 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 
 	efd_list = RTE_TAILQ_CAST(rte_efd_tailq.head, rte_efd_list);
 
-	if (online_cpu_socket_bitmask == 0) {
-		EFD_LOG(ERR, "At least one CPU socket must be enabled in the bitmask");
+	if (online_cpu_numa_bitmask == 0) {
+		EFD_LOG(ERR, "At least one CPU NUMA node must be enabled in the bitmask");
 		rte_errno = EINVAL;
 		return NULL;
 	}
@@ -574,20 +574,20 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 	}
 
 	/* Create a new EFD table management structure */
-	table = rte_zmalloc_socket(NULL,
+	table = rte_zmalloc_numa(NULL,
 			sizeof(struct rte_efd_table),
 			RTE_CACHE_LINE_SIZE,
-			offline_cpu_socket);
+			offline_cpu_numa);
 	if (table == NULL) {
 		EFD_LOG(ERR, "Allocating EFD table management structure"
-				" on socket %u failed",
-				offline_cpu_socket);
+				" on NUMA node %u failed",
+				offline_cpu_numa);
 		goto error_unlock_exit;
 	}
 
 
 	EFD_LOG(DEBUG, "Allocated EFD table management structure "
-			"on socket %u", offline_cpu_socket);
+			"on socket %u", offline_cpu_numa);
 
 	table->max_num_rules = num_chunks * EFD_TARGET_CHUNK_MAX_NUM_RULES;
 	table->num_rules = 0;
@@ -596,14 +596,14 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 	table->key_len = key_len;
 
 	/* key_array */
-	key_array = rte_zmalloc_socket(NULL,
+	key_array = rte_zmalloc_numa(NULL,
 			table->max_num_rules * table->key_len,
 			RTE_CACHE_LINE_SIZE,
-			offline_cpu_socket);
+			offline_cpu_numa);
 	if (key_array == NULL) {
 		EFD_LOG(ERR, "Allocating key array"
-				" on socket %u failed",
-				offline_cpu_socket);
+				" on NUMA node %u failed",
+				offline_cpu_numa);
 		goto error_unlock_exit;
 	}
 	table->keys = key_array;
@@ -614,8 +614,8 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 			num_chunks, table->max_num_rules);
 
 	/* Make sure all the allocatable table pointers are NULL initially */
-	for (socket_id = 0; socket_id < RTE_MAX_NUMA_NODES; socket_id++)
-		table->chunks[socket_id] = NULL;
+	for (numa_id = 0; numa_id < RTE_MAX_NUMA_NODES; numa_id++)
+		table->chunks[numa_id] = NULL;
 	table->offline_chunks = NULL;
 
 	/*
@@ -625,23 +625,23 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 	uint64_t online_table_size = num_chunks * sizeof(struct efd_online_chunk) +
 			EFD_NUM_CHUNK_PADDING_BYTES;
 
-	for (socket_id = 0; socket_id < RTE_MAX_NUMA_NODES; socket_id++) {
-		if ((online_cpu_socket_bitmask >> socket_id) & 0x01) {
+	for (numa_id = 0; numa_id < RTE_MAX_NUMA_NODES; numa_id++) {
+		if ((online_cpu_numa_bitmask >> numa_id) & 0x01) {
 			/*
 			 * Allocate all of the EFD table chunks (the online portion)
 			 * as a continuous block
 			 */
-			table->chunks[socket_id] =
-				rte_zmalloc_socket(
+			table->chunks[numa_id] =
+				rte_zmalloc_numa(
 				NULL,
 				online_table_size,
 				RTE_CACHE_LINE_SIZE,
-				socket_id);
-			if (table->chunks[socket_id] == NULL) {
+				numa_id);
+			if (table->chunks[numa_id] == NULL) {
 				EFD_LOG(ERR,
 						"Allocating EFD online table on "
 						"socket %u failed",
-						socket_id);
+						numa_id);
 				goto error_unlock_exit;
 			}
 			EFD_LOG(DEBUG,
@@ -650,7 +650,7 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 					online_table_size,
 					(float) online_table_size /
 						(1024.0F * 1024.0F),
-					socket_id);
+					numa_id);
 		}
 	}
 
@@ -685,13 +685,13 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 	 */
 	offline_table_size = num_chunks * sizeof(struct efd_offline_chunk_rules);
 	table->offline_chunks =
-			rte_zmalloc_socket(NULL,
+			rte_zmalloc_numa(NULL,
 			offline_table_size,
 			RTE_CACHE_LINE_SIZE,
-			offline_cpu_socket);
+			offline_cpu_numa);
 	if (table->offline_chunks == NULL) {
 		EFD_LOG(ERR, "Allocating EFD offline table on socket %u "
-				"failed", offline_cpu_socket);
+				"failed", offline_cpu_numa);
 		goto error_unlock_exit;
 	}
 
@@ -699,7 +699,7 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 			"Allocated EFD offline table of size %"PRIu64" bytes "
 			" (%.2f MB) on socket %u", offline_table_size,
 			(float) offline_table_size / (1024.0F * 1024.0F),
-			offline_cpu_socket);
+			offline_cpu_numa);
 
 	te->data = (void *) table;
 	TAILQ_INSERT_TAIL(efd_list, te, next);
@@ -711,7 +711,7 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 
 	/* Create ring (Dummy slot index is not enqueued) */
 	r = rte_ring_create(ring_name, rte_align32pow2(table->max_num_rules),
-			offline_cpu_socket, 0);
+			offline_cpu_numa, 0);
 	if (r == NULL) {
 		EFD_LOG(ERR, "ring creation failed: %s", rte_strerror(rte_errno));
 		rte_efd_free(table);
@@ -764,15 +764,15 @@ RTE_EXPORT_SYMBOL(rte_efd_free)
 void
 rte_efd_free(struct rte_efd_table *table)
 {
-	uint8_t socket_id;
+	uint8_t numa_id;
 	struct rte_efd_list *efd_list;
 	struct rte_tailq_entry *te, *temp;
 
 	if (table == NULL)
 		return;
 
-	for (socket_id = 0; socket_id < RTE_MAX_NUMA_NODES; socket_id++)
-		rte_free(table->chunks[socket_id]);
+	for (numa_id = 0; numa_id < RTE_MAX_NUMA_NODES; numa_id++)
+		rte_free(table->chunks[numa_id]);
 
 	efd_list = RTE_TAILQ_CAST(rte_efd_tailq.head, rte_efd_list);
 	rte_mcfg_tailq_write_lock();
@@ -800,7 +800,7 @@ rte_efd_free(struct rte_efd_table *table)
  *
  * @param table
  *   EFD table to reference
- * @param socket_id
+ * @param numa_id
  *   Socket ID to use to lookup existing values (ideally caller's socket id)
  * @param chunk_id
  *   Chunk index to update
@@ -814,13 +814,13 @@ rte_efd_free(struct rte_efd_table *table)
  *   Previously computed updated chunk/group entry
  */
 static inline void
-efd_apply_update(struct rte_efd_table * const table, const unsigned int socket_id,
+efd_apply_update(struct rte_efd_table * const table, const unsigned int numa_id,
 		const uint32_t chunk_id, const uint32_t group_id,
 		const uint32_t bin_id, const uint8_t new_bin_choice,
 		const struct efd_online_group_entry * const new_group_entry)
 {
 	int i;
-	struct efd_online_chunk *chunk = &table->chunks[socket_id][chunk_id];
+	struct efd_online_chunk *chunk = &table->chunks[numa_id][chunk_id];
 	uint8_t bin_index = bin_id / EFD_CHUNK_NUM_BIN_TO_GROUP_SETS;
 
 	/*
@@ -939,7 +939,7 @@ revert_groups(struct efd_offline_group_rules *previous_group,
  *
  * @param table
  *   EFD table to reference
- * @param socket_id
+ * @param numa_id
  *   Socket ID to use to lookup existing values (ideally caller's socket id)
  * @param key
  *   Key to insert
@@ -976,7 +976,7 @@ revert_groups(struct efd_offline_group_rules *previous_group,
  */
 static inline int
 efd_compute_update(struct rte_efd_table * const table,
-		const unsigned int socket_id, const void *key,
+		const unsigned int numa_id, const void *key,
 		const efd_value_t value, uint32_t * const chunk_id,
 		uint32_t * const group_id, uint32_t * const bin_id,
 		uint8_t * const new_bin_choice,
@@ -995,7 +995,7 @@ efd_compute_update(struct rte_efd_table * const table,
 			&table->offline_chunks[*chunk_id];
 	struct efd_offline_group_rules *new_group;
 
-	uint8_t current_choice = efd_get_choice(table, socket_id,
+	uint8_t current_choice = efd_get_choice(table, numa_id,
 			*chunk_id, *bin_id);
 	uint32_t current_group_id = efd_bin_to_group[current_choice][*bin_id];
 	struct efd_offline_group_rules * const current_group =
@@ -1179,14 +1179,14 @@ efd_compute_update(struct rte_efd_table * const table,
 
 RTE_EXPORT_SYMBOL(rte_efd_update)
 int
-rte_efd_update(struct rte_efd_table * const table, const unsigned int socket_id,
+rte_efd_update(struct rte_efd_table * const table, const unsigned int numa_id,
 		const void *key, const efd_value_t value)
 {
 	uint32_t chunk_id = 0, group_id = 0, bin_id = 0;
 	uint8_t new_bin_choice = 0;
 	struct efd_online_group_entry entry = {{0}};
 
-	int status = efd_compute_update(table, socket_id, key, value,
+	int status = efd_compute_update(table, numa_id, key, value,
 			&chunk_id, &group_id, &bin_id,
 			&new_bin_choice, &entry);
 
@@ -1196,14 +1196,14 @@ rte_efd_update(struct rte_efd_table * const table, const unsigned int socket_id,
 	if (status == RTE_EFD_UPDATE_FAILED)
 		return status;
 
-	efd_apply_update(table, socket_id, chunk_id, group_id, bin_id,
+	efd_apply_update(table, numa_id, chunk_id, group_id, bin_id,
 			new_bin_choice, &entry);
 	return status;
 }
 
 RTE_EXPORT_SYMBOL(rte_efd_delete)
 int
-rte_efd_delete(struct rte_efd_table * const table, const unsigned int socket_id,
+rte_efd_delete(struct rte_efd_table * const table, const unsigned int numa_id,
 		const void *key, efd_value_t * const prev_value)
 {
 	unsigned int i;
@@ -1215,7 +1215,7 @@ rte_efd_delete(struct rte_efd_table * const table, const unsigned int socket_id,
 	struct efd_offline_chunk_rules * const chunk =
 			&table->offline_chunks[chunk_id];
 
-	uint8_t current_choice = efd_get_choice(table, socket_id,
+	uint8_t current_choice = efd_get_choice(table, numa_id,
 			chunk_id, bin_id);
 	uint32_t current_group_id = efd_bin_to_group[current_choice][bin_id];
 	struct efd_offline_group_rules * const current_group =
@@ -1321,16 +1321,16 @@ efd_lookup_internal(const struct efd_online_group_entry * const group,
 RTE_EXPORT_SYMBOL(rte_efd_lookup)
 efd_value_t
 rte_efd_lookup(const struct rte_efd_table * const table,
-		const unsigned int socket_id, const void *key)
+		const unsigned int numa_id, const void *key)
 {
 	uint32_t chunk_id, group_id, bin_id;
 	uint8_t bin_choice;
 	const struct efd_online_group_entry *group;
-	const struct efd_online_chunk * const chunks = table->chunks[socket_id];
+	const struct efd_online_chunk * const chunks = table->chunks[numa_id];
 
 	/* Determine the chunk and group location for the given key */
 	efd_compute_ids(table, key, &chunk_id, &bin_id);
-	bin_choice = efd_get_choice(table, socket_id, chunk_id, bin_id);
+	bin_choice = efd_get_choice(table, numa_id, chunk_id, bin_id);
 	group_id = efd_bin_to_group[bin_choice][bin_id];
 	group = &chunks[chunk_id].groups[group_id];
 
@@ -1342,7 +1342,7 @@ rte_efd_lookup(const struct rte_efd_table * const table,
 
 RTE_EXPORT_SYMBOL(rte_efd_lookup_bulk)
 void rte_efd_lookup_bulk(const struct rte_efd_table * const table,
-		const unsigned int socket_id, const int num_keys,
+		const unsigned int numa_id, const int num_keys,
 		const void **key_list, efd_value_t * const value_list)
 {
 	int i;
@@ -1352,7 +1352,7 @@ void rte_efd_lookup_bulk(const struct rte_efd_table * const table,
 	uint32_t group_id_list[RTE_EFD_BURST_MAX];
 	struct efd_online_group_entry *group;
 
-	struct efd_online_chunk *chunks = table->chunks[socket_id];
+	struct efd_online_chunk *chunks = table->chunks[numa_id];
 
 	for (i = 0; i < num_keys; i++) {
 		efd_compute_ids(table, key_list[i], &chunk_id_list[i],
@@ -1361,7 +1361,7 @@ void rte_efd_lookup_bulk(const struct rte_efd_table * const table,
 	}
 
 	for (i = 0; i < num_keys; i++) {
-		bin_choice_list[i] = efd_get_choice(table, socket_id,
+		bin_choice_list[i] = efd_get_choice(table, numa_id,
 				chunk_id_list[i], bin_id_list[i]);
 		group_id_list[i] =
 				efd_bin_to_group[bin_choice_list[i]][bin_id_list[i]];
diff --git a/lib/efd/rte_efd.h b/lib/efd/rte_efd.h
index 89cb4a2483..c92e124b4d 100644
--- a/lib/efd/rte_efd.h
+++ b/lib/efd/rte_efd.h
@@ -117,7 +117,7 @@ typedef uint16_t efd_lookuptbl_t;
 typedef uint16_t efd_hashfunc_t;
 
 /**
- * Creates an EFD table with a single offline region and multiple per-socket
+ * Creates an EFD table with a single offline region and multiple per-NUMA-node
  * internally-managed copies of the online table used for lookups
  *
  * @param name
@@ -127,11 +127,11 @@ typedef uint16_t efd_hashfunc_t;
  *   Will be rounded up to the next smallest valid table size
  * @param key_len
  *   Length of the key
- * @param online_cpu_socket_bitmask
- *   Bitmask specifying which sockets should get a copy of the online table.
- *   LSB = socket 0, etc.
- * @param offline_cpu_socket
- *   Identifies the socket where the offline table will be allocated
+ * @param online_cpu_numa_bitmask
+ *   Bitmask specifying which NUMA nodes should get a copy of the online table.
+ *   LSB = NUMA node 0, etc.
+ * @param offline_cpu_numa
+ *   Identifies the NUMA node where the offline table will be allocated
  *   (and most efficiently accessed in the case of updates/insertions)
  *
  * @return
@@ -139,7 +139,7 @@ typedef uint16_t efd_hashfunc_t;
  */
 struct rte_efd_table *
 rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
-	uint64_t online_cpu_socket_bitmask, uint8_t offline_cpu_socket);
+	uint64_t online_cpu_numa_bitmask, uint8_t offline_cpu_numa);
 
 /**
  * Releases the resources from an EFD table
@@ -177,8 +177,8 @@ rte_efd_find_existing(const char *name);
  *
  * @param table
  *   EFD table to reference
- * @param socket_id
- *   Socket ID to use to lookup existing value (ideally caller's socket id)
+ * @param numa_id
+ *   NUMA node ID to use to lookup existing value (ideally caller's NUMA node)
  * @param key
  *   EFD table key to modify
  * @param value
@@ -198,7 +198,7 @@ rte_efd_find_existing(const char *name);
  *  0 - success
  */
 int
-rte_efd_update(struct rte_efd_table *table, unsigned int socket_id,
+rte_efd_update(struct rte_efd_table *table, unsigned int numa_id,
 	const void *key, efd_value_t value);
 
 /**
@@ -208,8 +208,8 @@ rte_efd_update(struct rte_efd_table *table, unsigned int socket_id,
  *
  * @param table
  *   EFD table to reference
- * @param socket_id
- *   Socket ID to use to lookup existing value (ideally caller's socket id)
+ * @param numa_id
+ *   NUMA node ID to use to lookup existing value (ideally caller's NUMA node)
  * @param key
  *   EFD table key to delete
  * @param prev_value
@@ -220,7 +220,7 @@ rte_efd_update(struct rte_efd_table *table, unsigned int socket_id,
  *   nonzero otherwise
  */
 int
-rte_efd_delete(struct rte_efd_table *table, unsigned int socket_id,
+rte_efd_delete(struct rte_efd_table *table, unsigned int numa_id,
 	const void *key, efd_value_t *prev_value);
 
 /**
@@ -235,8 +235,8 @@ rte_efd_delete(struct rte_efd_table *table, unsigned int socket_id,
  *
  * @param table
  *   EFD table to reference
- * @param socket_id
- *   Socket ID to use to lookup existing value (ideally caller's socket id)
+ * @param numa_id
+ *   NUMA node ID to use to lookup existing value (ideally caller's NUMA node)
  * @param key
  *   EFD table key to look up
  *
@@ -244,7 +244,7 @@ rte_efd_delete(struct rte_efd_table *table, unsigned int socket_id,
  *   Value associated with the key, or random junk if they key was never inserted
  */
 efd_value_t
-rte_efd_lookup(const struct rte_efd_table *table, unsigned int socket_id,
+rte_efd_lookup(const struct rte_efd_table *table, unsigned int numa_id,
 		const void *key);
 
 /**
@@ -259,8 +259,8 @@ rte_efd_lookup(const struct rte_efd_table *table, unsigned int socket_id,
  *
  * @param table
  *   EFD table to reference
- * @param socket_id
- *   Socket ID to use to lookup existing value (ideally caller's socket id)
+ * @param numa_id
+ *   NUMA node ID to use to lookup existing value (ideally caller's NUMA node)
  * @param num_keys
  *   Number of keys in the key_list array, must be less than RTE_EFD_BURST_MAX
  * @param key_list
@@ -269,7 +269,7 @@ rte_efd_lookup(const struct rte_efd_table *table, unsigned int socket_id,
  *   Array of size num_keys where lookup values will be stored
  */
 void
-rte_efd_lookup_bulk(const struct rte_efd_table *table, unsigned int socket_id,
+rte_efd_lookup_bulk(const struct rte_efd_table *table, unsigned int numa_id,
 		int num_keys, const void **key_list,
 		efd_value_t *value_list);
 
-- 
2.55.0

