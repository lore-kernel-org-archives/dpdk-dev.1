Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02B1FC72C4
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Mar 2026 15:42:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 332C140662;
	Sun, 22 Mar 2026 16:42:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 4172C40656
 for <dev@dpdk.org>; Sun, 22 Mar 2026 16:42:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774194146; x=1805730146;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6Woqp2K3YRRDrPOMeRKaN9p8KES+38uIn8+Ho6OnTeg=;
 b=ni5cAak69F+W2ahk6XbnSvS9lPb+Eh2EtfccHBlUfJew5b34DV+rtSbN
 KGkfTY/ko8syMk48wJJ0csJsZ1PaIEio2jVBljf3LKdJogs9PaLClVB1k
 2QFyuu0CowuPkwuO7xaIKvgpp9BcdXI3PPr6jZU1zKJu49KBnhiv0WxiD
 PpunVSUKljuXuvIMEoYKPnP4lcB4ICdWiZ9aFo6jamyxBrQHlhyj9R3Xr
 XJCzVykqQtzO1iyDuYhdVYMOUot/GdisHlBs/P4dj+DJFkcp0xF1vA9lg
 D7AD0EvCDj0Sm3xUkCu0c+KntksChLQxCxfEXIrwyEnMI1hKR7kT+UY4U g==;
X-CSE-ConnectionGUID: 5XZqebtxTeGpjx9TMyRDIg==
X-CSE-MsgGUID: vdKuAfc/TWyEhEhnduKiUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="97832226"
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; d="scan'208";a="97832226"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2026 08:42:25 -0700
X-CSE-ConnectionGUID: AyHeRpE6Rx+Ru7nKwcgrYQ==
X-CSE-MsgGUID: E2Cd8mg+R4+vWu4t143nCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; d="scan'208";a="221020826"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by fmviesa008.fm.intel.com with ESMTP; 22 Mar 2026 08:42:23 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, nsaxena16@gmail.com, mb@smartsharesystems.com,
 adwivedi@marvell.com, jerinjacobk@gmail.com
Subject: [RFC PATCH 3/4] fib6: add multi-VRF support
Date: Sun, 22 Mar 2026 15:42:14 +0000
Message-ID: <20260322154215.3686528-4-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
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

Add VRF (Virtual Routing and Forwarding) support to the IPv6
FIB library, allowing multiple independent routing tables
within a single FIB instance.

Introduce max_vrfs and vrf_default_nh in rte_fib6_conf and
add four new experimental APIs:
- rte_fib6_vrf_add() and rte_fib6_vrf_delete() for per-VRF
  route management
- rte_fib6_vrf_lookup_bulk() for multi-VRF bulk lookups
- rte_fib6_vrf_get_rib() to retrieve a per-VRF RIB handle

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 lib/fib/rte_fib6.c    | 166 ++++++++++++++++++++++++++-----
 lib/fib/rte_fib6.h    |  88 ++++++++++++++++-
 lib/fib/trie.c        | 158 +++++++++++++++++++++--------
 lib/fib/trie.h        |  51 +++++++---
 lib/fib/trie_avx512.c | 225 ++++++++++++++++++++++++++++++++++++++----
 lib/fib/trie_avx512.h |  39 +++++++-
 6 files changed, 617 insertions(+), 110 deletions(-)

diff --git a/lib/fib/rte_fib6.c b/lib/fib/rte_fib6.c
index 770becdb61..0d2b2927d5 100644
--- a/lib/fib/rte_fib6.c
+++ b/lib/fib/rte_fib6.c
@@ -22,6 +22,8 @@
 #include "trie.h"
 #include "fib_log.h"
 
+#define FIB6_MAX_LOOKUP_BULK 64U
+
 TAILQ_HEAD(rte_fib6_list, rte_tailq_entry);
 static struct rte_tailq_elem rte_fib6_tailq = {
 	.name = "RTE_FIB6",
@@ -40,51 +42,61 @@ EAL_REGISTER_TAILQ(rte_fib6_tailq)
 struct rte_fib6 {
 	char			name[RTE_FIB6_NAMESIZE];
 	enum rte_fib6_type	type;	/**< Type of FIB struct */
-	struct rte_rib6		*rib;	/**< RIB helper datastructure */
-	void			*dp;	/**< pointer to the dataplane struct*/
-	rte_fib6_lookup_fn_t	lookup;	/**< FIB lookup function */
+	uint16_t		num_vrfs;	/**< Number of VRFs */
+	struct rte_rib6		**ribs;	/**< RIB helper datastructures per VRF */
+	void			*dp;	/**< pointer to the dataplane struct */
+	rte_fib6_lookup_fn_t	lookup;	/**< lookup function */
 	rte_fib6_modify_fn_t	modify; /**< modify FIB datastructure */
-	uint64_t		def_nh;
+	uint64_t		*def_nh;	/**< Per-VRF default next hop array */
 };
 
 static void
-dummy_lookup(void *fib_p, const struct rte_ipv6_addr *ips,
+dummy_lookup(void *fib_p, const uint16_t *vrf_ids,
+	const struct rte_ipv6_addr *ips,
 	uint64_t *next_hops, const unsigned int n)
 {
 	unsigned int i;
 	struct rte_fib6 *fib = fib_p;
 	struct rte_rib6_node *node;
+	struct rte_rib6 *rib;
 
 	for (i = 0; i < n; i++) {
-		node = rte_rib6_lookup(fib->rib, &ips[i]);
+		RTE_ASSERT(vrf_ids[i] < fib->num_vrfs);
+		rib = rte_fib6_vrf_get_rib(fib, vrf_ids[i]);
+		node = rte_rib6_lookup(rib, &ips[i]);
 		if (node != NULL)
 			rte_rib6_get_nh(node, &next_hops[i]);
 		else
-			next_hops[i] = fib->def_nh;
+			next_hops[i] = fib->def_nh[vrf_ids[i]];
 	}
 }
 
 static int
-dummy_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
-	uint8_t depth, uint64_t next_hop, int op)
+dummy_modify(struct rte_fib6 *fib, uint16_t vrf_id,
+	const struct rte_ipv6_addr *ip, uint8_t depth,
+	uint64_t next_hop, int op)
 {
 	struct rte_rib6_node *node;
+	struct rte_rib6 *rib;
 	if ((fib == NULL) || (depth > RTE_IPV6_MAX_DEPTH))
 		return -EINVAL;
+	rib = rte_fib6_vrf_get_rib(fib, vrf_id);
+	if (rib == NULL)
+		return -EINVAL;
 
-	node = rte_rib6_lookup_exact(fib->rib, ip, depth);
+	node = rte_rib6_lookup_exact(rib, ip, depth);
 
 	switch (op) {
 	case RTE_FIB6_ADD:
 		if (node == NULL)
-			node = rte_rib6_insert(fib->rib, ip, depth);
+			node = rte_rib6_insert(rib, ip, depth);
 		if (node == NULL)
 			return -rte_errno;
 		return rte_rib6_set_nh(node, next_hop);
 	case RTE_FIB6_DEL:
 		if (node == NULL)
 			return -ENOENT;
-		rte_rib6_remove(fib->rib, ip, depth);
+		rte_rib6_remove(rib, ip, depth);
 		return 0;
 	}
 	return -EINVAL;
@@ -113,7 +125,6 @@ init_dataplane(struct rte_fib6 *fib, __rte_unused int socket_id,
 	default:
 		return -EINVAL;
 	}
-	return 0;
 }
 
 RTE_EXPORT_SYMBOL(rte_fib6_add)
@@ -124,7 +135,7 @@ rte_fib6_add(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 	if ((fib == NULL) || (ip == NULL) || (fib->modify == NULL) ||
 			(depth > RTE_IPV6_MAX_DEPTH))
 		return -EINVAL;
-	return fib->modify(fib, ip, depth, next_hop, RTE_FIB6_ADD);
+	return fib->modify(fib, 0, ip, depth, next_hop, RTE_FIB6_ADD);
 }
 
 RTE_EXPORT_SYMBOL(rte_fib6_delete)
@@ -135,7 +146,7 @@ rte_fib6_delete(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 	if ((fib == NULL) || (ip == NULL) || (fib->modify == NULL) ||
 			(depth > RTE_IPV6_MAX_DEPTH))
 		return -EINVAL;
-	return fib->modify(fib, ip, depth, 0, RTE_FIB6_DEL);
+	return fib->modify(fib, 0, ip, depth, 0, RTE_FIB6_DEL);
 }
 
 RTE_EXPORT_SYMBOL(rte_fib6_lookup_bulk)
@@ -144,23 +155,72 @@ rte_fib6_lookup_bulk(struct rte_fib6 *fib,
 	const struct rte_ipv6_addr *ips,
 	uint64_t *next_hops, int n)
 {
+	static const uint16_t zero_vrf_ids[FIB6_MAX_LOOKUP_BULK];
+	unsigned int off = 0;
+	unsigned int total = (unsigned int)n;
+
 	FIB6_RETURN_IF_TRUE((fib == NULL) || (ips == NULL) ||
 		(next_hops == NULL) || (fib->lookup == NULL), -EINVAL);
-	fib->lookup(fib->dp, ips, next_hops, n);
+
+	while (off < total) {
+		unsigned int chunk = RTE_MIN(total - off,
+			FIB6_MAX_LOOKUP_BULK);
+		fib->lookup(fib->dp, zero_vrf_ids, ips + off,
+			next_hops + off, chunk);
+		off += chunk;
+	}
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib6_vrf_lookup_bulk, 26.07)
+int
+rte_fib6_vrf_lookup_bulk(struct rte_fib6 *fib, const uint16_t *vrf_ids,
+	const struct rte_ipv6_addr *ips, uint64_t *next_hops, int n)
+{
+	FIB6_RETURN_IF_TRUE((fib == NULL) || (vrf_ids == NULL) || (ips == NULL) ||
+		(next_hops == NULL) || (fib->lookup == NULL), -EINVAL);
+
+	fib->lookup(fib->dp, vrf_ids, ips, next_hops, (unsigned int)n);
+
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib6_vrf_add, 26.07)
+int
+rte_fib6_vrf_add(struct rte_fib6 *fib, uint16_t vrf_id,
+	const struct rte_ipv6_addr *ip, uint8_t depth, uint64_t next_hop)
+{
+	if ((fib == NULL) || (ip == NULL) || (fib->modify == NULL) ||
+			(depth > RTE_IPV6_MAX_DEPTH))
+		return -EINVAL;
+	return fib->modify(fib, vrf_id, ip, depth, next_hop, RTE_FIB6_ADD);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib6_vrf_delete, 26.07)
+int
+rte_fib6_vrf_delete(struct rte_fib6 *fib, uint16_t vrf_id,
+	const struct rte_ipv6_addr *ip, uint8_t depth)
+{
+	if ((fib == NULL) || (ip == NULL) || (fib->modify == NULL) ||
+			(depth > RTE_IPV6_MAX_DEPTH))
+		return -EINVAL;
+	return fib->modify(fib, vrf_id, ip, depth, 0, RTE_FIB6_DEL);
+}
+
 RTE_EXPORT_SYMBOL(rte_fib6_create)
 struct rte_fib6 *
 rte_fib6_create(const char *name, int socket_id, struct rte_fib6_conf *conf)
 {
 	char mem_name[RTE_FIB6_NAMESIZE];
+	char rib_name[RTE_FIB6_NAMESIZE];
 	int ret;
 	struct rte_fib6 *fib = NULL;
 	struct rte_rib6 *rib = NULL;
 	struct rte_tailq_entry *te;
 	struct rte_fib6_list *fib_list;
 	struct rte_rib6_conf rib_conf;
+	uint16_t num_vrfs;
+	uint16_t vrf;
 
 	/* Check user arguments. */
 	if ((name == NULL) || (conf == NULL) || (conf->max_routes < 0) ||
@@ -172,13 +232,41 @@ rte_fib6_create(const char *name, int socket_id, struct rte_fib6_conf *conf)
 	rib_conf.ext_sz = conf->rib_ext_sz;
 	rib_conf.max_nodes = conf->max_routes * 2;
 
-	rib = rte_rib6_create(name, socket_id, &rib_conf);
-	if (rib == NULL) {
-		FIB_LOG(ERR,
-			"Can not allocate RIB %s", name);
+	num_vrfs = (conf->max_vrfs == 0) ? 1 : conf->max_vrfs;
+
+	struct rte_rib6 **ribs = rte_zmalloc_socket("FIB6_RIBS",
+		num_vrfs * sizeof(*ribs), RTE_CACHE_LINE_SIZE, socket_id);
+	if (ribs == NULL) {
+		FIB_LOG(ERR, "FIB6 %s RIB array allocation failed", name);
+		rte_errno = ENOMEM;
+		return NULL;
+	}
+
+	uint64_t *def_nh = rte_zmalloc_socket("FIB6_DEF_NH",
+		num_vrfs * sizeof(*def_nh), RTE_CACHE_LINE_SIZE, socket_id);
+	if (def_nh == NULL) {
+		FIB_LOG(ERR, "FIB6 %s default nexthop array allocation failed", name);
+		rte_errno = ENOMEM;
+		rte_free(ribs);
 		return NULL;
 	}
 
+	for (vrf = 0; vrf < num_vrfs; vrf++) {
+		if (num_vrfs == 1)
+			snprintf(rib_name, sizeof(rib_name), "%s", name);
+		else
+			snprintf(rib_name, sizeof(rib_name), "%s_vrf%u", name, vrf);
+		rib = rte_rib6_create(rib_name, socket_id, &rib_conf);
+		if (rib == NULL) {
+			FIB_LOG(ERR, "Can not allocate RIB %s", rib_name);
+			rte_errno = ENOMEM;
+			goto free_ribs;
+		}
+		ribs[vrf] = rib;
+		def_nh[vrf] = (conf->vrf_default_nh != NULL) ?
+			conf->vrf_default_nh[vrf] : conf->default_nh;
+	}
+
 	snprintf(mem_name, sizeof(mem_name), "FIB6_%s", name);
 	fib_list = RTE_TAILQ_CAST(rte_fib6_tailq.head, rte_fib6_list);
 
@@ -214,15 +302,17 @@ rte_fib6_create(const char *name, int socket_id, struct rte_fib6_conf *conf)
 		goto free_te;
 	}
 
+	fib->num_vrfs = num_vrfs;
+	fib->ribs = ribs;
+	fib->def_nh = def_nh;
+
 	rte_strlcpy(fib->name, name, sizeof(fib->name));
-	fib->rib = rib;
 	fib->type = conf->type;
-	fib->def_nh = conf->default_nh;
 	ret = init_dataplane(fib, socket_id, conf);
 	if (ret < 0) {
 		FIB_LOG(ERR,
-			"FIB dataplane struct %s memory allocation failed",
-			name);
+			"FIB dataplane struct %s memory allocation failed with err %d",
+			name, ret);
 		rte_errno = -ret;
 		goto free_fib;
 	}
@@ -240,7 +330,12 @@ rte_fib6_create(const char *name, int socket_id, struct rte_fib6_conf *conf)
 	rte_free(te);
 exit:
 	rte_mcfg_tailq_write_unlock();
-	rte_rib6_free(rib);
+free_ribs:
+	for (vrf = 0; vrf < num_vrfs; vrf++)
+		rte_rib6_free(ribs[vrf]);
+
+	rte_free(def_nh);
+	rte_free(ribs);
 
 	return NULL;
 }
@@ -309,7 +404,13 @@ rte_fib6_free(struct rte_fib6 *fib)
 	rte_mcfg_tailq_write_unlock();
 
 	free_dataplane(fib);
-	rte_rib6_free(fib->rib);
+	if (fib->ribs != NULL) {
+		uint16_t vrf;
+		for (vrf = 0; vrf < fib->num_vrfs; vrf++)
+			rte_rib6_free(fib->ribs[vrf]);
+	}
+	rte_free(fib->ribs);
+	rte_free(fib->def_nh);
 	rte_free(fib);
 	rte_free(te);
 }
@@ -325,7 +426,18 @@ RTE_EXPORT_SYMBOL(rte_fib6_get_rib)
 struct rte_rib6 *
 rte_fib6_get_rib(struct rte_fib6 *fib)
 {
-	return (fib == NULL) ? NULL : fib->rib;
+	return (fib == NULL || fib->ribs == NULL) ? NULL : fib->ribs[0];
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib6_vrf_get_rib, 26.07)
+struct rte_rib6 *
+rte_fib6_vrf_get_rib(struct rte_fib6 *fib, uint16_t vrf_id)
+{
+	if (fib == NULL || fib->ribs == NULL)
+		return NULL;
+	if (vrf_id >= fib->num_vrfs)
+		return NULL;
+	return fib->ribs[vrf_id];
 }
 
 RTE_EXPORT_SYMBOL(rte_fib6_select_lookup)
diff --git a/lib/fib/rte_fib6.h b/lib/fib/rte_fib6.h
index 4527328bf0..864ec08c4e 100644
--- a/lib/fib/rte_fib6.h
+++ b/lib/fib/rte_fib6.h
@@ -55,11 +55,11 @@ enum rte_fib6_type {
 };
 
 /** Modify FIB function */
-typedef int (*rte_fib6_modify_fn_t)(struct rte_fib6 *fib,
+typedef int (*rte_fib6_modify_fn_t)(struct rte_fib6 *fib, uint16_t vrf_id,
 	const struct rte_ipv6_addr *ip, uint8_t depth,
 	uint64_t next_hop, int op);
 /** FIB bulk lookup function */
-typedef void (*rte_fib6_lookup_fn_t)(void *fib,
+typedef void (*rte_fib6_lookup_fn_t)(void *fib, const uint16_t *vrf_ids,
 	const struct rte_ipv6_addr *ips,
 	uint64_t *next_hops, const unsigned int n);
 
@@ -97,6 +97,10 @@ struct rte_fib6_conf {
 			uint32_t	num_tbl8;
 		} trie;
 	};
+	/** Number of VRFs to support (0 or 1 = single VRF for backward compat) */
+	uint16_t max_vrfs;
+	/** Per-VRF default nexthops (NULL = use default_nh for all) */
+	uint64_t *vrf_default_nh;
 };
 
 /** FIB RCU QSBR configuration structure. */
@@ -215,6 +219,70 @@ rte_fib6_lookup_bulk(struct rte_fib6 *fib,
 	const struct rte_ipv6_addr *ips,
 	uint64_t *next_hops, int n);
 
+/**
+ * Add a route to the FIB with VRF ID.
+ *
+ * @param fib
+ *   FIB object handle
+ * @param vrf_id
+ *   VRF ID (0 to max_vrfs-1)
+ * @param ip
+ *   IPv6 prefix address to be added to the FIB
+ * @param depth
+ *   Prefix length
+ * @param next_hop
+ *   Next hop to be added to the FIB
+ * @return
+ *   0 on success, negative value otherwise
+ */
+__rte_experimental
+int
+rte_fib6_vrf_add(struct rte_fib6 *fib, uint16_t vrf_id,
+	const struct rte_ipv6_addr *ip, uint8_t depth, uint64_t next_hop);
+
+/**
+ * Delete a rule from the FIB with VRF ID.
+ *
+ * @param fib
+ *   FIB object handle
+ * @param vrf_id
+ *   VRF ID (0 to max_vrfs-1)
+ * @param ip
+ *   IPv6 prefix address to be deleted from the FIB
+ * @param depth
+ *   Prefix length
+ * @return
+ *   0 on success, negative value otherwise
+ */
+__rte_experimental
+int
+rte_fib6_vrf_delete(struct rte_fib6 *fib, uint16_t vrf_id,
+	const struct rte_ipv6_addr *ip, uint8_t depth);
+
+/**
+ * Lookup multiple IP addresses in the FIB with per-packet VRF IDs.
+ *
+ * @param fib
+ *   FIB object handle
+ * @param vrf_ids
+ *   Array of VRF IDs corresponding to ips[] (0 to max_vrfs-1)
+ * @param ips
+ *   Array of IPv6s to be looked up in the FIB
+ * @param next_hops
+ *   Next hop of the most specific rule found for IP.
+ *   This is an array of eight byte values.
+ *   If the lookup for the given IP failed, then corresponding element would
+ *   contain default nexthop value configured for that VRF.
+ * @param n
+ *   Number of elements in vrf_ids/ips/next_hops arrays to lookup.
+ * @return
+ *   -EINVAL for incorrect arguments, otherwise 0
+ */
+__rte_experimental
+int
+rte_fib6_vrf_lookup_bulk(struct rte_fib6 *fib, const uint16_t *vrf_ids,
+	const struct rte_ipv6_addr *ips, uint64_t *next_hops, int n);
+
 /**
  * Get pointer to the dataplane specific struct
  *
@@ -228,7 +296,7 @@ void *
 rte_fib6_get_dp(struct rte_fib6 *fib);
 
 /**
- * Get pointer to the RIB6
+ * Get pointer to the RIB6 for VRF 0
  *
  * @param fib
  *   FIB object handle
@@ -239,6 +307,20 @@ rte_fib6_get_dp(struct rte_fib6 *fib);
 struct rte_rib6 *
 rte_fib6_get_rib(struct rte_fib6 *fib);
 
+/**
+ * Get the RIB for a specific VRF.
+ *
+ * @param fib
+ *   FIB object handle
+ * @param vrf_id
+ *   VRF ID (0 to max_vrfs-1)
+ * @return
+ *   RIB for the specified VRF or NULL on error.
+ */
+__rte_experimental
+struct rte_rib6 *
+rte_fib6_vrf_get_rib(struct rte_fib6 *fib, uint16_t vrf_id);
+
 /**
  * Set lookup function based on type
  *
diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index fa5d9ec6b0..2acc9d9526 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -30,22 +30,27 @@ enum edge {
 };
 
 static inline rte_fib6_lookup_fn_t
-get_scalar_fn(enum rte_fib_trie_nh_sz nh_sz)
+get_scalar_fn(const struct rte_trie_tbl *dp, enum rte_fib_trie_nh_sz nh_sz)
 {
+	bool single_vrf = dp->num_vrfs <= 1;
+
 	switch (nh_sz) {
 	case RTE_FIB6_TRIE_2B:
-		return rte_trie_lookup_bulk_2b;
+		return single_vrf ? rte_trie_lookup_bulk_2b :
+			rte_trie_lookup_bulk_vrf_2b;
 	case RTE_FIB6_TRIE_4B:
-		return rte_trie_lookup_bulk_4b;
+		return single_vrf ? rte_trie_lookup_bulk_4b :
+			rte_trie_lookup_bulk_vrf_4b;
 	case RTE_FIB6_TRIE_8B:
-		return rte_trie_lookup_bulk_8b;
+		return single_vrf ? rte_trie_lookup_bulk_8b :
+			rte_trie_lookup_bulk_vrf_8b;
 	default:
 		return NULL;
 	}
 }
 
 static inline rte_fib6_lookup_fn_t
-get_vector_fn(enum rte_fib_trie_nh_sz nh_sz)
+get_vector_fn(const struct rte_trie_tbl *dp, enum rte_fib_trie_nh_sz nh_sz)
 {
 #ifdef CC_AVX512_SUPPORT
 	if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) <= 0 ||
@@ -53,13 +58,40 @@ get_vector_fn(enum rte_fib_trie_nh_sz nh_sz)
 			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) <= 0 ||
 			rte_vect_get_max_simd_bitwidth() < RTE_VECT_SIMD_512)
 		return NULL;
+
+	if (dp->num_vrfs <= 1) {
+		switch (nh_sz) {
+		case RTE_FIB6_TRIE_2B:
+			return rte_trie_vec_lookup_bulk_2b;
+		case RTE_FIB6_TRIE_4B:
+			return rte_trie_vec_lookup_bulk_4b;
+		case RTE_FIB6_TRIE_8B:
+			return rte_trie_vec_lookup_bulk_8b;
+		default:
+			return NULL;
+		}
+	}
+
+	if (dp->num_vrfs >= 256) {
+		switch (nh_sz) {
+		case RTE_FIB6_TRIE_2B:
+			return rte_trie_vec_lookup_bulk_vrf_2b_large;
+		case RTE_FIB6_TRIE_4B:
+			return rte_trie_vec_lookup_bulk_vrf_4b_large;
+		case RTE_FIB6_TRIE_8B:
+			return rte_trie_vec_lookup_bulk_vrf_8b_large;
+		default:
+			return NULL;
+		}
+	}
+
 	switch (nh_sz) {
 	case RTE_FIB6_TRIE_2B:
-		return rte_trie_vec_lookup_bulk_2b;
+		return rte_trie_vec_lookup_bulk_vrf_2b;
 	case RTE_FIB6_TRIE_4B:
-		return rte_trie_vec_lookup_bulk_4b;
+		return rte_trie_vec_lookup_bulk_vrf_4b;
 	case RTE_FIB6_TRIE_8B:
-		return rte_trie_vec_lookup_bulk_8b;
+		return rte_trie_vec_lookup_bulk_vrf_8b;
 	default:
 		return NULL;
 	}
@@ -83,12 +115,12 @@ trie_get_lookup_fn(void *p, enum rte_fib6_lookup_type type)
 
 	switch (type) {
 	case RTE_FIB6_LOOKUP_TRIE_SCALAR:
-		return get_scalar_fn(nh_sz);
+		return get_scalar_fn(dp, nh_sz);
 	case RTE_FIB6_LOOKUP_TRIE_VECTOR_AVX512:
-		return get_vector_fn(nh_sz);
+		return get_vector_fn(dp, nh_sz);
 	case RTE_FIB6_LOOKUP_DEFAULT:
-		ret_fn = get_vector_fn(nh_sz);
-		return (ret_fn != NULL) ? ret_fn : get_scalar_fn(nh_sz);
+		ret_fn = get_vector_fn(dp, nh_sz);
+		return (ret_fn != NULL) ? ret_fn : get_scalar_fn(dp, nh_sz);
 	default:
 		return NULL;
 	}
@@ -310,19 +342,22 @@ recycle_root_path(struct rte_trie_tbl *dp, const uint8_t *ip_part,
 }
 
 static inline int
-build_common_root(struct rte_trie_tbl *dp, const struct rte_ipv6_addr *ip,
-	int common_bytes, void **tbl)
+build_common_root(struct rte_trie_tbl *dp, uint16_t vrf_id,
+	const struct rte_ipv6_addr *ip, int common_bytes, void **tbl)
 {
 	void *tbl_ptr = NULL;
 	uint64_t *cur_tbl;
 	uint64_t val;
 	int i, j, idx, prev_idx = 0;
+	uint64_t idx_tbl;
+	uint64_t tbl24_base = (uint64_t)vrf_id * TRIE_TBL24_NUM_ENT;
 
 	cur_tbl = dp->tbl24;
 	for (i = 3, j = 0; i <= common_bytes; i++) {
 		idx = get_idx(ip, prev_idx, i - j, j);
-		val = get_tbl_val_by_idx(cur_tbl, idx, dp->nh_sz);
-		tbl_ptr = get_tbl_p_by_idx(cur_tbl, idx, dp->nh_sz);
+		idx_tbl = (cur_tbl == dp->tbl24) ? idx + tbl24_base : (uint32_t)idx;
+		val = get_tbl_val_by_idx(cur_tbl, idx_tbl, dp->nh_sz);
+		tbl_ptr = get_tbl_p_by_idx(cur_tbl, idx_tbl, dp->nh_sz);
 		if ((val & TRIE_EXT_ENT) != TRIE_EXT_ENT) {
 			idx = tbl8_alloc(dp, val);
 			if (unlikely(idx < 0))
@@ -336,8 +371,11 @@ build_common_root(struct rte_trie_tbl *dp, const struct rte_ipv6_addr *ip,
 		j = i;
 		cur_tbl = dp->tbl8;
 	}
-	*tbl = get_tbl_p_by_idx(cur_tbl, prev_idx * TRIE_TBL8_GRP_NUM_ENT,
-		dp->nh_sz);
+
+	uint64_t final_idx = (cur_tbl == dp->tbl24) ?
+		(prev_idx * TRIE_TBL8_GRP_NUM_ENT + tbl24_base) :
+		(prev_idx * TRIE_TBL8_GRP_NUM_ENT);
+	*tbl = get_tbl_p_by_idx(cur_tbl, final_idx, dp->nh_sz);
 	return 0;
 }
 
@@ -385,7 +423,8 @@ write_edge(struct rte_trie_tbl *dp, const uint8_t *ip_part, uint64_t next_hop,
 #define TBL8_LEN	(RTE_IPV6_ADDR_SIZE - TBL24_BYTES)
 
 static int
-install_to_dp(struct rte_trie_tbl *dp, const struct rte_ipv6_addr *ledge,
+install_to_dp(struct rte_trie_tbl *dp, uint16_t vrf_id,
+	const struct rte_ipv6_addr *ledge,
 	const struct rte_ipv6_addr *r, uint64_t next_hop)
 {
 	void *common_root_tbl;
@@ -409,7 +448,7 @@ install_to_dp(struct rte_trie_tbl *dp, const struct rte_ipv6_addr *ledge,
 			break;
 	}
 
-	ret = build_common_root(dp, ledge, common_bytes, &common_root_tbl);
+	ret = build_common_root(dp, vrf_id, ledge, common_bytes, &common_root_tbl);
 	if (unlikely(ret != 0))
 		return ret;
 	/*first uncommon tbl8 byte idx*/
@@ -455,7 +494,7 @@ install_to_dp(struct rte_trie_tbl *dp, const struct rte_ipv6_addr *ledge,
 
 	uint8_t	common_tbl8 = (common_bytes < TBL24_BYTES) ?
 			0 : common_bytes - (TBL24_BYTES - 1);
-	ent = get_tbl24_p(dp, ledge, dp->nh_sz);
+	ent = get_tbl24_p(dp, vrf_id, ledge, dp->nh_sz);
 	recycle_root_path(dp, ledge->a + TBL24_BYTES, common_tbl8, ent);
 	return 0;
 }
@@ -482,9 +521,8 @@ get_nxt_net(struct rte_ipv6_addr *ip, uint8_t depth)
 }
 
 static int
-modify_dp(struct rte_trie_tbl *dp, struct rte_rib6 *rib,
-	const struct rte_ipv6_addr *ip,
-	uint8_t depth, uint64_t next_hop)
+modify_dp(struct rte_trie_tbl *dp, struct rte_rib6 *rib, uint16_t vrf_id,
+	const struct rte_ipv6_addr *ip, uint8_t depth, uint64_t next_hop)
 {
 	struct rte_rib6_node *tmp = NULL;
 	struct rte_ipv6_addr ledge, redge;
@@ -507,7 +545,7 @@ modify_dp(struct rte_trie_tbl *dp, struct rte_rib6 *rib,
 				get_nxt_net(&ledge, tmp_depth);
 				continue;
 			}
-			ret = install_to_dp(dp, &ledge, &redge, next_hop);
+			ret = install_to_dp(dp, vrf_id, &ledge, &redge, next_hop);
 			if (ret != 0)
 				return ret;
 			get_nxt_net(&redge, tmp_depth);
@@ -525,7 +563,7 @@ modify_dp(struct rte_trie_tbl *dp, struct rte_rib6 *rib,
 					!rte_ipv6_addr_is_unspec(&ledge))
 				break;
 
-			ret = install_to_dp(dp, &ledge, &redge, next_hop);
+			ret = install_to_dp(dp, vrf_id, &ledge, &redge, next_hop);
 			if (ret != 0)
 				return ret;
 		}
@@ -535,7 +573,8 @@ modify_dp(struct rte_trie_tbl *dp, struct rte_rib6 *rib,
 }
 
 int
-trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
+trie_modify(struct rte_fib6 *fib, uint16_t vrf_id,
+	const struct rte_ipv6_addr *ip,
 	uint8_t depth, uint64_t next_hop, int op)
 {
 	struct rte_trie_tbl *dp;
@@ -552,9 +591,11 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 		return -EINVAL;
 
 	dp = rte_fib6_get_dp(fib);
-	RTE_ASSERT(dp);
-	rib = rte_fib6_get_rib(fib);
-	RTE_ASSERT(rib);
+	rib = rte_fib6_vrf_get_rib(fib, vrf_id);
+	RTE_ASSERT((dp != NULL) && (rib != NULL));
+
+	if (vrf_id >= dp->num_vrfs)
+		return -EINVAL;
 
 	ip_masked = *ip;
 	rte_ipv6_addr_mask(&ip_masked, depth);
@@ -597,7 +638,7 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 			rte_rib6_get_nh(node, &node_nh);
 			if (node_nh == next_hop)
 				return 0;
-			ret = modify_dp(dp, rib, &ip_masked, depth, next_hop);
+			ret = modify_dp(dp, rib, vrf_id, &ip_masked, depth, next_hop);
 			if (ret == 0)
 				rte_rib6_set_nh(node, next_hop);
 			return 0;
@@ -616,7 +657,7 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 			if (par_nh == next_hop)
 				goto successfully_added;
 		}
-		ret = modify_dp(dp, rib, &ip_masked, depth, next_hop);
+		ret = modify_dp(dp, rib, vrf_id, &ip_masked, depth, next_hop);
 		if (ret != 0) {
 			rte_rib6_remove(rib, &ip_masked, depth);
 			return ret;
@@ -633,10 +674,11 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 			rte_rib6_get_nh(parent, &par_nh);
 			rte_rib6_get_nh(node, &node_nh);
 			if (par_nh != node_nh)
-				ret = modify_dp(dp, rib, &ip_masked, depth,
+				ret = modify_dp(dp, rib, vrf_id, &ip_masked, depth,
 					par_nh);
 		} else
-			ret = modify_dp(dp, rib, &ip_masked, depth, dp->def_nh);
+			ret = modify_dp(dp, rib, vrf_id, &ip_masked, depth,
+					dp->def_nh[vrf_id]);
 
 		if (ret != 0)
 			return ret;
@@ -656,9 +698,11 @@ trie_create(const char *name, int socket_id,
 {
 	char mem_name[TRIE_NAMESIZE];
 	struct rte_trie_tbl *dp = NULL;
-	uint64_t	def_nh;
 	uint32_t	num_tbl8;
 	enum rte_fib_trie_nh_sz	nh_sz;
+	uint16_t	num_vrfs;
+	uint16_t	vrf;
+	uint64_t	tbl24_sz;
 
 	if ((name == NULL) || (conf == NULL) ||
 			(conf->trie.nh_sz < RTE_FIB6_TRIE_2B) ||
@@ -673,21 +717,28 @@ trie_create(const char *name, int socket_id,
 		return NULL;
 	}
 
-	def_nh = conf->default_nh;
 	nh_sz = conf->trie.nh_sz;
 	num_tbl8 = conf->trie.num_tbl8;
+	num_vrfs = (conf->max_vrfs == 0) ? 1 : conf->max_vrfs;
+	tbl24_sz = (uint64_t)num_vrfs * TRIE_TBL24_NUM_ENT * (1 << nh_sz);
+
+	if (conf->vrf_default_nh != NULL) {
+		for (vrf = 0; vrf < num_vrfs; vrf++) {
+			if (conf->vrf_default_nh[vrf] > get_max_nh(nh_sz)) {
+				rte_errno = EINVAL;
+				return NULL;
+			}
+		}
+	}
 
 	snprintf(mem_name, sizeof(mem_name), "DP_%s", name);
-	dp = rte_zmalloc_socket(name, sizeof(struct rte_trie_tbl) +
-		TRIE_TBL24_NUM_ENT * (1 << nh_sz) + sizeof(uint32_t),
+	dp = rte_zmalloc_socket(name, sizeof(struct rte_trie_tbl) + tbl24_sz,
 		RTE_CACHE_LINE_SIZE, socket_id);
 	if (dp == NULL) {
 		rte_errno = ENOMEM;
 		return dp;
 	}
 
-	write_to_dp(&dp->tbl24, (def_nh << 1), nh_sz, 1 << 24);
-
 	snprintf(mem_name, sizeof(mem_name), "TBL8_%p", dp);
 	dp->tbl8 = rte_zmalloc_socket(mem_name, TRIE_TBL8_GRP_NUM_ENT *
 			(1ll << nh_sz) * (num_tbl8 + 1),
@@ -697,9 +748,32 @@ trie_create(const char *name, int socket_id,
 		rte_free(dp);
 		return NULL;
 	}
-	dp->def_nh = def_nh;
+
+	snprintf(mem_name, sizeof(mem_name), "DEF_NH_%p", dp);
+	dp->def_nh = rte_zmalloc_socket(mem_name,
+		num_vrfs * sizeof(*dp->def_nh),
+		RTE_CACHE_LINE_SIZE, socket_id);
+	if (dp->def_nh == NULL) {
+		rte_errno = ENOMEM;
+		rte_free(dp->tbl8);
+		rte_free(dp);
+		return NULL;
+	}
+
+	for (vrf = 0; vrf < num_vrfs; vrf++) {
+		uint64_t vrf_def = (conf->vrf_default_nh != NULL) ?
+			conf->vrf_default_nh[vrf] : conf->default_nh;
+		uint8_t *tbl24_ptr = (uint8_t *)dp->tbl24 +
+			((uint64_t)vrf * TRIE_TBL24_NUM_ENT << nh_sz);
+
+		dp->def_nh[vrf] = vrf_def;
+		write_to_dp((void *)tbl24_ptr, (vrf_def << 1), nh_sz,
+			TRIE_TBL24_NUM_ENT);
+	}
+
 	dp->nh_sz = nh_sz;
 	dp->number_tbl8s = num_tbl8;
+	dp->num_vrfs = num_vrfs;
 
 	snprintf(mem_name, sizeof(mem_name), "TBL8_idxes_%p", dp);
 	dp->tbl8_pool = rte_zmalloc_socket(mem_name,
@@ -707,6 +781,7 @@ trie_create(const char *name, int socket_id,
 			RTE_CACHE_LINE_SIZE, socket_id);
 	if (dp->tbl8_pool == NULL) {
 		rte_errno = ENOMEM;
+		rte_free(dp->def_nh);
 		rte_free(dp->tbl8);
 		rte_free(dp);
 		return NULL;
@@ -725,6 +800,7 @@ trie_free(void *p)
 	rte_rcu_qsbr_dq_delete(dp->dq);
 	rte_free(dp->tbl8_pool);
 	rte_free(dp->tbl8);
+	rte_free(dp->def_nh);
 	rte_free(dp);
 }
 
diff --git a/lib/fib/trie.h b/lib/fib/trie.h
index c34cc2c057..ef9a1d50c6 100644
--- a/lib/fib/trie.h
+++ b/lib/fib/trie.h
@@ -9,6 +9,7 @@
 #include <stdalign.h>
 
 #include <rte_common.h>
+#include <rte_debug.h>
 #include <rte_fib6.h>
 
 /**
@@ -32,18 +33,19 @@
 struct rte_trie_tbl {
 	uint32_t	number_tbl8s;	/**< Total number of tbl8s */
 	uint32_t	rsvd_tbl8s;	/**< Number of reserved tbl8s */
-	uint32_t	cur_tbl8s;	/**< Current cumber of tbl8s */
-	uint64_t	def_nh;		/**< Default next hop */
+	uint32_t	cur_tbl8s;	/**< Current number of tbl8s */
+	uint16_t	num_vrfs;	/**< Number of VRFs */
 	enum rte_fib_trie_nh_sz	nh_sz;	/**< Size of nexthop entry */
-	uint64_t	*tbl8;		/**< tbl8 table. */
-	uint32_t	*tbl8_pool;	/**< bitmap containing free tbl8 idxes*/
-	uint32_t	tbl8_pool_pos;
 	/* RCU config. */
 	enum rte_fib6_qsbr_mode rcu_mode; /**< Blocking, defer queue. */
 	struct rte_rcu_qsbr *v; /**< RCU QSBR variable. */
 	struct rte_rcu_qsbr_dq *dq; /**< RCU QSBR defer queue. */
+	uint64_t	*def_nh;	/**< Per-VRF default next hop array */
+	uint64_t	*tbl8;		/**< tbl8 table for all VRFs */
+	uint32_t	*tbl8_pool;	/**< bitmap containing free tbl8 idxes */
+	uint32_t	tbl8_pool_pos;
 	/* tbl24 table. */
-	alignas(RTE_CACHE_LINE_SIZE) uint64_t	tbl24[];
+	alignas(RTE_CACHE_LINE_SIZE) uint64_t tbl24[];
 };
 
 static inline uint32_t
@@ -53,12 +55,15 @@ get_tbl24_idx(const struct rte_ipv6_addr *ip)
 }
 
 static inline void *
-get_tbl24_p(struct rte_trie_tbl *dp, const struct rte_ipv6_addr *ip, uint8_t nh_sz)
+get_tbl24_p(struct rte_trie_tbl *dp, uint16_t vrf_id,
+	const struct rte_ipv6_addr *ip, uint8_t nh_sz)
 {
 	uint32_t tbl24_idx;
+	uint64_t base;
 
 	tbl24_idx = get_tbl24_idx(ip);
-	return (void *)&((uint8_t *)dp->tbl24)[tbl24_idx << nh_sz];
+	base = (uint64_t)vrf_id * TRIE_TBL24_NUM_ENT;
+	return (void *)&((uint8_t *)dp->tbl24)[(base + tbl24_idx) << nh_sz];
 }
 
 static inline uint8_t
@@ -110,17 +115,26 @@ is_entry_extended(uint64_t ent)
 	return (ent & TRIE_EXT_ENT) == TRIE_EXT_ENT;
 }
 
-#define LOOKUP_FUNC(suffix, type, nh_sz)				\
+#define LOOKUP_FUNC(suffix, type, is_vrf)				\
 static inline void rte_trie_lookup_bulk_##suffix(void *p,		\
-	const struct rte_ipv6_addr *ips,				\
+	const uint16_t *vrf_ids, const struct rte_ipv6_addr *ips,	\
 	uint64_t *next_hops, const unsigned int n)			\
-{									\
+{\
 	struct rte_trie_tbl *dp = (struct rte_trie_tbl *)p;		\
 	uint64_t tmp;							\
 	uint32_t i, j;							\
+	uint32_t tbl24_idx;						\
+	uint64_t base;						\
+									\
+	if (!is_vrf)						\
+		RTE_SET_USED(vrf_ids);					\
 									\
 	for (i = 0; i < n; i++) {					\
-		tmp = ((type *)dp->tbl24)[get_tbl24_idx(&ips[i])];	\
+		uint16_t vrf_id = is_vrf ? vrf_ids[i] : 0;		\
+		RTE_ASSERT(vrf_id < dp->num_vrfs);			\
+		base = (uint64_t)vrf_id * TRIE_TBL24_NUM_ENT;	\
+		tbl24_idx = get_tbl24_idx(&ips[i]);			\
+		tmp = ((type *)dp->tbl24)[base + tbl24_idx];	\
 		j = 3;							\
 		while (is_entry_extended(tmp)) {			\
 			tmp = ((type *)dp->tbl8)[ips[i].a[j++] +	\
@@ -129,9 +143,13 @@ static inline void rte_trie_lookup_bulk_##suffix(void *p,		\
 		next_hops[i] = tmp >> 1;				\
 	}								\
 }
-LOOKUP_FUNC(2b, uint16_t, 1)
-LOOKUP_FUNC(4b, uint32_t, 2)
-LOOKUP_FUNC(8b, uint64_t, 3)
+
+LOOKUP_FUNC(2b, uint16_t, false)
+LOOKUP_FUNC(4b, uint32_t, false)
+LOOKUP_FUNC(8b, uint64_t, false)
+LOOKUP_FUNC(vrf_2b, uint16_t, true)
+LOOKUP_FUNC(vrf_4b, uint32_t, true)
+LOOKUP_FUNC(vrf_8b, uint64_t, true)
 
 void
 trie_free(void *p);
@@ -144,7 +162,8 @@ rte_fib6_lookup_fn_t
 trie_get_lookup_fn(void *p, enum rte_fib6_lookup_type type);
 
 int
-trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
+trie_modify(struct rte_fib6 *fib, uint16_t vrf_id,
+	const struct rte_ipv6_addr *ip,
 	uint8_t depth, uint64_t next_hop, int op);
 
 int
diff --git a/lib/fib/trie_avx512.c b/lib/fib/trie_avx512.c
index f49482a95d..19cd69e69c 100644
--- a/lib/fib/trie_avx512.c
+++ b/lib/fib/trie_avx512.c
@@ -8,6 +8,12 @@
 #include "trie.h"
 #include "trie_avx512.h"
 
+enum vrf_scale {
+	VRF_SCALE_SINGLE = 0,
+	VRF_SCALE_SMALL = 1,
+	VRF_SCALE_LARGE = 2,
+};
+
 static __rte_always_inline void
 transpose_x16(const struct rte_ipv6_addr *ips,
 	__m512i *first, __m512i *second, __m512i *third, __m512i *fourth)
@@ -67,8 +73,9 @@ transpose_x8(const struct rte_ipv6_addr *ips,
 }
 
 static __rte_always_inline void
-trie_vec_lookup_x16x2(void *p, const struct rte_ipv6_addr *ips,
-	uint64_t *next_hops, int size)
+trie_vec_lookup_x16x2(void *p, const uint16_t *vrf_ids,
+	const struct rte_ipv6_addr *ips, uint64_t *next_hops, int size,
+	enum vrf_scale vrf_scale)
 {
 	struct rte_trie_tbl *dp = (struct rte_trie_tbl *)p;
 	const __m512i zero = _mm512_set1_epi32(0);
@@ -79,6 +86,7 @@ trie_vec_lookup_x16x2(void *p, const struct rte_ipv6_addr *ips,
 	__m512i first_2, second_2, third_2, fourth_2;
 	__m512i idxes_1, res_1;
 	__m512i idxes_2, res_2;
+	__m512i vrf32_1, vrf32_2;
 	__m512i shuf_idxes;
 	__m512i tmp_1, tmp2_1, bytes_1, byte_chunk_1;
 	__m512i tmp_2, tmp2_2, bytes_2, byte_chunk_2;
@@ -109,6 +117,24 @@ trie_vec_lookup_x16x2(void *p, const struct rte_ipv6_addr *ips,
 	idxes_1 = _mm512_shuffle_epi8(first_1, bswap.z);
 	idxes_2 = _mm512_shuffle_epi8(first_2, bswap.z);
 
+	if (vrf_scale == VRF_SCALE_SINGLE) {
+		RTE_SET_USED(vrf_ids);
+	} else {
+		uint32_t j;
+
+		for (j = 0; j < 32; j++)
+			RTE_ASSERT(vrf_ids[j] < dp->num_vrfs);
+
+		vrf32_1 = _mm512_cvtepu16_epi32(
+			_mm256_loadu_si256((const void *)vrf_ids));
+		vrf32_2 = _mm512_cvtepu16_epi32(
+			_mm256_loadu_si256((const void *)(vrf_ids + 16)));
+		idxes_1 = _mm512_add_epi32(idxes_1,
+			_mm512_slli_epi32(vrf32_1, 24));
+		idxes_2 = _mm512_add_epi32(idxes_2,
+			_mm512_slli_epi32(vrf32_2, 24));
+	}
+
 	/**
 	 * lookup in tbl24
 	 * Put it inside branch to make compiller happy with -O0
@@ -213,13 +239,15 @@ trie_vec_lookup_x16x2(void *p, const struct rte_ipv6_addr *ips,
 }
 
 static void
-trie_vec_lookup_x8x2_8b(void *p, const struct rte_ipv6_addr *ips,
-	uint64_t *next_hops)
+trie_vec_lookup_x8x2(void *p, const uint16_t *vrf_ids,
+	const struct rte_ipv6_addr *ips, uint64_t *next_hops, int size,
+	enum vrf_scale vrf_scale)
 {
 	struct rte_trie_tbl *dp = (struct rte_trie_tbl *)p;
 	const __m512i zero = _mm512_set1_epi32(0);
 	const __m512i lsb = _mm512_set1_epi32(1);
 	const __m512i three_lsb = _mm512_set1_epi32(7);
+	__m512i res_msk;
 	/* IPv6 eight byte chunks */
 	__m512i first_1, second_1;
 	__m512i first_2, second_2;
@@ -228,6 +256,7 @@ trie_vec_lookup_x8x2_8b(void *p, const struct rte_ipv6_addr *ips,
 	__m512i shuf_idxes, base_idxes;
 	__m512i tmp_1, bytes_1, byte_chunk_1;
 	__m512i tmp_2, bytes_2, byte_chunk_2;
+	__m512i vrf64_1, vrf64_2;
 	const __rte_x86_zmm_t bswap = {
 		.u8 = { 2, 1, 0, 255, 255, 255, 255, 255,
 			10, 9, 8, 255, 255, 255, 255, 255,
@@ -244,6 +273,11 @@ trie_vec_lookup_x8x2_8b(void *p, const struct rte_ipv6_addr *ips,
 	__mmask8 msk_ext_1, new_msk_1;
 	__mmask8 msk_ext_2, new_msk_2;
 
+	if (size == sizeof(uint16_t))
+		res_msk = _mm512_set1_epi64(UINT16_MAX);
+	else if (size == sizeof(uint32_t))
+		res_msk = _mm512_set1_epi64(UINT32_MAX);
+
 	transpose_x8(ips, &first_1, &second_1);
 	transpose_x8(ips + 8, &first_2, &second_2);
 
@@ -251,9 +285,39 @@ trie_vec_lookup_x8x2_8b(void *p, const struct rte_ipv6_addr *ips,
 	idxes_1 = _mm512_shuffle_epi8(first_1, bswap.z);
 	idxes_2 = _mm512_shuffle_epi8(first_2, bswap.z);
 
+	if (vrf_scale == VRF_SCALE_SINGLE) {
+		RTE_SET_USED(vrf_ids);
+	} else {
+		uint32_t j;
+
+		for (j = 0; j < 16; j++)
+			RTE_ASSERT(vrf_ids[j] < dp->num_vrfs);
+
+		vrf64_1 = _mm512_cvtepu16_epi64(
+			_mm_loadu_si128((const void *)vrf_ids));
+		vrf64_2 = _mm512_cvtepu16_epi64(
+			_mm_loadu_si128((const void *)(vrf_ids + 8)));
+		idxes_1 = _mm512_add_epi64(idxes_1,
+			_mm512_slli_epi64(vrf64_1, 24));
+		idxes_2 = _mm512_add_epi64(idxes_2,
+			_mm512_slli_epi64(vrf64_2, 24));
+	}
+
 	/* lookup in tbl24 */
-	res_1 = _mm512_i64gather_epi64(idxes_1, (const void *)dp->tbl24, 8);
-	res_2 = _mm512_i64gather_epi64(idxes_2, (const void *)dp->tbl24, 8);
+	if (size == sizeof(uint16_t)) {
+		res_1 = _mm512_i64gather_epi64(idxes_1, (const void *)dp->tbl24, 2);
+		res_2 = _mm512_i64gather_epi64(idxes_2, (const void *)dp->tbl24, 2);
+		res_1 = _mm512_and_epi64(res_1, res_msk);
+		res_2 = _mm512_and_epi64(res_2, res_msk);
+	} else if (size == sizeof(uint32_t)) {
+		res_1 = _mm512_i64gather_epi64(idxes_1, (const void *)dp->tbl24, 4);
+		res_2 = _mm512_i64gather_epi64(idxes_2, (const void *)dp->tbl24, 4);
+		res_1 = _mm512_and_epi64(res_1, res_msk);
+		res_2 = _mm512_and_epi64(res_2, res_msk);
+	} else {
+		res_1 = _mm512_i64gather_epi64(idxes_1, (const void *)dp->tbl24, 8);
+		res_2 = _mm512_i64gather_epi64(idxes_2, (const void *)dp->tbl24, 8);
+	}
 	/* get extended entries indexes */
 	msk_ext_1 = _mm512_test_epi64_mask(res_1, lsb);
 	msk_ext_2 = _mm512_test_epi64_mask(res_2, lsb);
@@ -278,10 +342,26 @@ trie_vec_lookup_x8x2_8b(void *p, const struct rte_ipv6_addr *ips,
 				shuf_idxes);
 		idxes_1 = _mm512_maskz_add_epi64(msk_ext_1, idxes_1, bytes_1);
 		idxes_2 = _mm512_maskz_add_epi64(msk_ext_2, idxes_2, bytes_2);
-		tmp_1 = _mm512_mask_i64gather_epi64(zero, msk_ext_1,
+		if (size == sizeof(uint16_t)) {
+			tmp_1 = _mm512_mask_i64gather_epi64(zero, msk_ext_1,
+				idxes_1, (const void *)dp->tbl8, 2);
+			tmp_2 = _mm512_mask_i64gather_epi64(zero, msk_ext_2,
+				idxes_2, (const void *)dp->tbl8, 2);
+			tmp_1 = _mm512_and_epi64(tmp_1, res_msk);
+			tmp_2 = _mm512_and_epi64(tmp_2, res_msk);
+		} else if (size == sizeof(uint32_t)) {
+			tmp_1 = _mm512_mask_i64gather_epi64(zero, msk_ext_1,
+				idxes_1, (const void *)dp->tbl8, 4);
+			tmp_2 = _mm512_mask_i64gather_epi64(zero, msk_ext_2,
+				idxes_2, (const void *)dp->tbl8, 4);
+			tmp_1 = _mm512_and_epi64(tmp_1, res_msk);
+			tmp_2 = _mm512_and_epi64(tmp_2, res_msk);
+		} else {
+			tmp_1 = _mm512_mask_i64gather_epi64(zero, msk_ext_1,
 				idxes_1, (const void *)dp->tbl8, 8);
-		tmp_2 = _mm512_mask_i64gather_epi64(zero, msk_ext_2,
+			tmp_2 = _mm512_mask_i64gather_epi64(zero, msk_ext_2,
 				idxes_2, (const void *)dp->tbl8, 8);
+		}
 		new_msk_1 = _mm512_test_epi64_mask(tmp_1, lsb);
 		new_msk_2 = _mm512_test_epi64_mask(tmp_2, lsb);
 		res_1 = _mm512_mask_blend_epi64(msk_ext_1 ^ new_msk_1, res_1,
@@ -306,40 +386,145 @@ trie_vec_lookup_x8x2_8b(void *p, const struct rte_ipv6_addr *ips,
 }
 
 void
-rte_trie_vec_lookup_bulk_2b(void *p, const struct rte_ipv6_addr *ips,
+rte_trie_vec_lookup_bulk_2b(void *p, const uint16_t *vrf_ids,
+	const struct rte_ipv6_addr *ips,
 	uint64_t *next_hops, const unsigned int n)
 {
 	uint32_t i;
+
 	for (i = 0; i < (n / 32); i++) {
-		trie_vec_lookup_x16x2(p, &ips[i * 32],
-				next_hops + i * 32, sizeof(uint16_t));
+		trie_vec_lookup_x16x2(p, vrf_ids + i * 32, &ips[i * 32],
+				next_hops + i * 32, sizeof(uint16_t),
+				VRF_SCALE_SINGLE);
 	}
-	rte_trie_lookup_bulk_2b(p, &ips[i * 32],
+	rte_trie_lookup_bulk_2b(p, vrf_ids + i * 32, &ips[i * 32],
 			next_hops + i * 32, n - i * 32);
 }
 
 void
-rte_trie_vec_lookup_bulk_4b(void *p, const struct rte_ipv6_addr *ips,
+rte_trie_vec_lookup_bulk_vrf_2b(void *p, const uint16_t *vrf_ids,
+	const struct rte_ipv6_addr *ips,
 	uint64_t *next_hops, const unsigned int n)
 {
 	uint32_t i;
+
 	for (i = 0; i < (n / 32); i++) {
-		trie_vec_lookup_x16x2(p, &ips[i * 32],
-				next_hops + i * 32, sizeof(uint32_t));
+		trie_vec_lookup_x16x2(p, vrf_ids + i * 32, &ips[i * 32],
+				next_hops + i * 32, sizeof(uint16_t),
+				VRF_SCALE_SMALL);
 	}
-	rte_trie_lookup_bulk_4b(p, &ips[i * 32],
+	rte_trie_lookup_bulk_vrf_2b(p, vrf_ids + i * 32, &ips[i * 32],
 			next_hops + i * 32, n - i * 32);
 }
 
 void
-rte_trie_vec_lookup_bulk_8b(void *p, const struct rte_ipv6_addr *ips,
+rte_trie_vec_lookup_bulk_vrf_2b_large(void *p, const uint16_t *vrf_ids,
+	const struct rte_ipv6_addr *ips,
 	uint64_t *next_hops, const unsigned int n)
 {
 	uint32_t i;
+
+	for (i = 0; i < (n / 16); i++) {
+		trie_vec_lookup_x8x2(p, vrf_ids + i * 16, &ips[i * 16],
+				next_hops + i * 16, sizeof(uint16_t),
+				VRF_SCALE_LARGE);
+	}
+	rte_trie_lookup_bulk_vrf_2b(p, vrf_ids + i * 16, &ips[i * 16],
+			next_hops + i * 16, n - i * 16);
+}
+
+void
+rte_trie_vec_lookup_bulk_4b(void *p, const uint16_t *vrf_ids,
+	const struct rte_ipv6_addr *ips,
+	uint64_t *next_hops, const unsigned int n)
+{
+	uint32_t i;
+
+	for (i = 0; i < (n / 32); i++) {
+		trie_vec_lookup_x16x2(p, vrf_ids + i * 32, &ips[i * 32],
+				next_hops + i * 32, sizeof(uint32_t),
+				VRF_SCALE_SINGLE);
+	}
+	rte_trie_lookup_bulk_4b(p, vrf_ids + i * 32, &ips[i * 32],
+			next_hops + i * 32, n - i * 32);
+}
+
+void
+rte_trie_vec_lookup_bulk_vrf_4b(void *p, const uint16_t *vrf_ids,
+	const struct rte_ipv6_addr *ips,
+	uint64_t *next_hops, const unsigned int n)
+{
+	uint32_t i;
+
+	for (i = 0; i < (n / 32); i++) {
+		trie_vec_lookup_x16x2(p, vrf_ids + i * 32, &ips[i * 32],
+				next_hops + i * 32, sizeof(uint32_t),
+				VRF_SCALE_SMALL);
+	}
+	rte_trie_lookup_bulk_vrf_4b(p, vrf_ids + i * 32, &ips[i * 32],
+			next_hops + i * 32, n - i * 32);
+}
+
+void
+rte_trie_vec_lookup_bulk_vrf_4b_large(void *p, const uint16_t *vrf_ids,
+	const struct rte_ipv6_addr *ips,
+	uint64_t *next_hops, const unsigned int n)
+{
+	uint32_t i;
+
+	for (i = 0; i < (n / 16); i++) {
+		trie_vec_lookup_x8x2(p, vrf_ids + i * 16, &ips[i * 16],
+				next_hops + i * 16, sizeof(uint32_t),
+				VRF_SCALE_LARGE);
+	}
+	rte_trie_lookup_bulk_vrf_4b(p, vrf_ids + i * 16, &ips[i * 16],
+			next_hops + i * 16, n - i * 16);
+}
+
+void
+rte_trie_vec_lookup_bulk_8b(void *p, const uint16_t *vrf_ids,
+	const struct rte_ipv6_addr *ips,
+	uint64_t *next_hops, const unsigned int n)
+{
+	uint32_t i;
+
+	for (i = 0; i < (n / 16); i++) {
+		trie_vec_lookup_x8x2(p, vrf_ids + i * 16, &ips[i * 16],
+				next_hops + i * 16, sizeof(uint64_t),
+				VRF_SCALE_SINGLE);
+	}
+	rte_trie_lookup_bulk_8b(p, vrf_ids + i * 16, &ips[i * 16],
+			next_hops + i * 16, n - i * 16);
+}
+
+void
+rte_trie_vec_lookup_bulk_vrf_8b(void *p, const uint16_t *vrf_ids,
+	const struct rte_ipv6_addr *ips,
+	uint64_t *next_hops, const unsigned int n)
+{
+	uint32_t i;
+
+	for (i = 0; i < (n / 16); i++) {
+		trie_vec_lookup_x8x2(p, vrf_ids + i * 16, &ips[i * 16],
+				next_hops + i * 16, sizeof(uint64_t),
+				VRF_SCALE_SMALL);
+	}
+	rte_trie_lookup_bulk_vrf_8b(p, vrf_ids + i * 16, &ips[i * 16],
+			next_hops + i * 16, n - i * 16);
+}
+
+void
+rte_trie_vec_lookup_bulk_vrf_8b_large(void *p, const uint16_t *vrf_ids,
+	const struct rte_ipv6_addr *ips,
+	uint64_t *next_hops, const unsigned int n)
+{
+	uint32_t i;
+
 	for (i = 0; i < (n / 16); i++) {
-		trie_vec_lookup_x8x2_8b(p, &ips[i * 16],
-				next_hops + i * 16);
+		trie_vec_lookup_x8x2(p, vrf_ids + i * 16, &ips[i * 16],
+				next_hops + i * 16, sizeof(uint64_t),
+				VRF_SCALE_LARGE);
 	}
-	rte_trie_lookup_bulk_8b(p, &ips[i * 16],
+	rte_trie_lookup_bulk_vrf_8b(p, vrf_ids + i * 16, &ips[i * 16],
 			next_hops + i * 16, n - i * 16);
 }
diff --git a/lib/fib/trie_avx512.h b/lib/fib/trie_avx512.h
index 1028a4899f..190a5c5aa4 100644
--- a/lib/fib/trie_avx512.h
+++ b/lib/fib/trie_avx512.h
@@ -10,15 +10,48 @@
 struct rte_ipv6_addr;
 
 void
-rte_trie_vec_lookup_bulk_2b(void *p, const struct rte_ipv6_addr *ips,
+rte_trie_vec_lookup_bulk_2b(void *p, const uint16_t *vrf_ids,
+	const struct rte_ipv6_addr *ips,
 	uint64_t *next_hops, const unsigned int n);
 
 void
-rte_trie_vec_lookup_bulk_4b(void *p, const struct rte_ipv6_addr *ips,
+rte_trie_vec_lookup_bulk_vrf_2b(void *p, const uint16_t *vrf_ids,
+	const struct rte_ipv6_addr *ips,
 	uint64_t *next_hops, const unsigned int n);
 
 void
-rte_trie_vec_lookup_bulk_8b(void *p, const struct rte_ipv6_addr *ips,
+rte_trie_vec_lookup_bulk_vrf_2b_large(void *p, const uint16_t *vrf_ids,
+	const struct rte_ipv6_addr *ips,
+	uint64_t *next_hops, const unsigned int n);
+
+void
+rte_trie_vec_lookup_bulk_4b(void *p, const uint16_t *vrf_ids,
+	const struct rte_ipv6_addr *ips,
+	uint64_t *next_hops, const unsigned int n);
+
+void
+rte_trie_vec_lookup_bulk_vrf_4b(void *p, const uint16_t *vrf_ids,
+	const struct rte_ipv6_addr *ips,
+	uint64_t *next_hops, const unsigned int n);
+
+void
+rte_trie_vec_lookup_bulk_vrf_4b_large(void *p, const uint16_t *vrf_ids,
+	const struct rte_ipv6_addr *ips,
+	uint64_t *next_hops, const unsigned int n);
+
+void
+rte_trie_vec_lookup_bulk_8b(void *p, const uint16_t *vrf_ids,
+	const struct rte_ipv6_addr *ips,
+	uint64_t *next_hops, const unsigned int n);
+
+void
+rte_trie_vec_lookup_bulk_vrf_8b(void *p, const uint16_t *vrf_ids,
+	const struct rte_ipv6_addr *ips,
+	uint64_t *next_hops, const unsigned int n);
+
+void
+rte_trie_vec_lookup_bulk_vrf_8b_large(void *p, const uint16_t *vrf_ids,
+	const struct rte_ipv6_addr *ips,
 	uint64_t *next_hops, const unsigned int n);
 
 #endif /* _TRIE_AVX512_H_ */
-- 
2.43.0

