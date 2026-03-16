Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF73AF53D80
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 17:28:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CECE40662;
	Mon, 16 Mar 2026 18:28:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id A48F740609
 for <dev@dpdk.org>; Mon, 16 Mar 2026 18:28:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773682082; x=1805218082;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ML2/3r56xzJiwSVAJ/de4YpyKM/ptx5M6d2tIR8Lvjo=;
 b=d30qCu5CgjsaWl3QGV72oO3oBkG+Qkfz0ekhR8tc3QsKobfdfYitWI5E
 OTyM1TAmRlDtN/z/axpoiTcFzHpPLAqLnC6SPwyhmVgB9Zu26vyKfWIWZ
 1fAHuFntIa5CUeofM1qGeFxDqrtQ4/CCJI7gem6EJg0D/RDn1a8A0S8at
 7VsD9v7vmDS3m5bhJK+yh8DkCgwpjFwpDA4DCLE1psSqPjRqwm8fenh0n
 tEV2MnD1K+EUFdy95jBNa6bRVRbU2KdZcPoiaHkQqCinozyCKFMXzQ/Cb
 gfNPDv29AXwZ5B7aSjskbuMvG1YQ7jw7mFG+RN4CY3kPfAcklLbOpZwmX w==;
X-CSE-ConnectionGUID: IdGDQ9phSNqKIfMEze0CHg==
X-CSE-MsgGUID: u6AL+DC1ReKDCqvXOCCCsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86059612"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="86059612"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 10:28:01 -0700
X-CSE-ConnectionGUID: KbiL05qSR3mYZUAUmTodCg==
X-CSE-MsgGUID: MD5CGQBlSzyDnhyGlaYOsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221228162"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 16 Mar 2026 10:28:00 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH v1 02/21] net/intel/common: add flow engines infrastructure
Date: Mon, 16 Mar 2026 17:27:30 +0000
Message-ID: <55b46a45aefd7aaccb6ac837fd9ba76dcf49c1fa.1773681364.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773681363.git.anatoly.burakov@intel.com>
References: 
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

Current implementation of flow engines in various drivers have a few issues
that need to be corrected.

For one, some of the are fundamentally incompatible with secondary
processes, because the flow engine registration and creation will
allocate structures in shared memory but use process-local pointers to
point to flow engines and pattern tables.

For another, a lot of them are needlessly complicated and rely on a
separation between patterns and parsing that is hard to reason about and
maintain: they do not define memory ownership model, they do not define the
way in which we approach parameter and pattern parsing, and they
occasionally do weird things like passing around pointers-to-void-pointers
or even using pointers as integer values.

These issues can be corrected, but because of how much code there is to the
current infrastructure and how tightly coupled it is, it would be easier to
just build new one from scratch, and gradually migrate all engines to use
it. This patch is intended as a first step towards that goal, and defines
both common data types to be used by all rte_flow parsers, as well as the
interaction model that is to be followed by all drivers.

We define a set of structures that will represent:

- Defined rte_flow parsing interaction model and code flow (ops struct)
- Defined memory allocation and ownership model for all engines
- Scratch space format for all engines (variably allocated typed struct)
- Flow rule format for all engines (variably allocated typed struct)
- Engine definitions that are compatible with secondary process model
- Reference implementations of common rte_flow operations
- Various supporting infrastructure for parser customization, e.g. hooks
- Support for using custom allocation (e.g. for mempool-based alloc)

The design intent is heavily documented right inside the header and is to
be considered authoritative design document for how to build rte_flow
parsers for Intel Ethernet drivers going forward.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/common/flow_engine.h | 1003 ++++++++++++++++++++++++
 1 file changed, 1003 insertions(+)
 create mode 100644 drivers/net/intel/common/flow_engine.h

diff --git a/drivers/net/intel/common/flow_engine.h b/drivers/net/intel/common/flow_engine.h
new file mode 100644
index 0000000000..14feabb3ce
--- /dev/null
+++ b/drivers/net/intel/common/flow_engine.h
@@ -0,0 +1,1003 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#ifndef _COMMON_INTEL_FLOW_ENGINE_H_
+#define _COMMON_INTEL_FLOW_ENGINE_H_
+
+#include <stddef.h>
+#include <sys/queue.h>
+
+#include <rte_malloc.h>
+
+#include <rte_flow.h>
+#include <rte_flow_graph.h>
+#include <rte_tailq.h>
+#include <rte_rwlock.h>
+
+/*
+ * This is a common header for Intel Ethernet drivers' flow engine
+ * implementations. It defines the interfaces and data structures required to
+ * implement flow rule engines that can be plugged into the drivers' flow
+ * handling logic.
+ *
+ * Design considerations:
+ *
+ * 1. Ease of implementation
+ *
+ * The flow engine interface is designed to be as simple as possible with
+ * obvious defaults (i.e. not specifying something leads to behavior that
+ * would've been the most obvious in context). The point is not to produce a
+ * monstrous driver-within-a-driver framework, but rather to make engine
+ * definitions follow semantic expectations of what the engine actually does.
+ *
+ * All the boilerplate (flow management, engine enablement tracking, etc.) is
+ * handled by the common flow infrastructure, so the engine implementation only
+ * needs to focus on the actual logic of parsing and installing/uninstalling
+ * flow rules, and defining each step of the process as it pertains to each flow
+ * engine.
+ *
+ * It is expected that drivers will use other utility functions from the common
+ * flow-related code where applicable (e.g. flow_util.h, flow_check.h, etc.),
+ * however this is obviously up to each individual driver to handle.
+ *
+ * Default implementations for rte_flow API functions are also provided, but
+ * they are not mandatory to use - drivers may implement their own versions if
+ * they so choose, this is just a reference implementation.
+ *
+ * 2. Full secondary process compatibility
+ *
+ * In order to support rte_flow operations in secondary processes, we need to
+ * store which engines are enabled for particular driver instance, and resolve
+ * them at runtime. Therefore, instead of relying on function pointers, each
+ * engine is expected to define an enum of engine type, which is then used as a
+ * bitshift-mask into a driver-specific 64-bit field of enabled engines. This
+ * way, the engine definitions can be stored in read-only memory, and referenced
+ * by both primary and secondary processes without issues.
+ *
+ * Note that this does not imply that all drivers are therefore able to support
+ * rte_flow-related operations in secondary processes - that is still up to each
+ * driver to implement. This just ensures that the flow engine framework does
+ * not prevent it.
+ *
+ * 3. No memory management by engines
+ *
+ * Engines are expected to only fill in the provided memory areas, and not
+ * allocate or free any memory on their own. The only exception is per-engine
+ * internal data where the engine is free to alloc/free any additional resources
+ * on init/uninit, as this cannot be reasonably generalized by the framework.
+ *
+ * 4. All rte_flow pattern parsing is implemented using rte_flow_graph
+ *
+ * The flow engine framework is designed to work hand-in-hand with the
+ * rte_flow_graph parsing infrastructure. Each engine may provide a pattern
+ * graph that is used to match the flow pattern, and extract relevant data
+ * into the engine context. This allows for cleaner separation of concerns,
+ * where the engine focuses on handling actions and attributes, while the
+ * graph parser deals with the pattern matching.
+ *
+ * If the graph is not provided, a default empty pattern graph is used that
+ * matches either empty patterns or patterns consisting solely of "any" items.
+ */
+
+/* forward declarations for flow engine data types */
+struct ci_flow_engine_ops;
+struct ci_flow_engine_ctx;
+struct ci_flow_engine;
+struct ci_flow_engine_list;
+struct ci_flow_engine_conf;
+struct ci_flow;
+
+/*
+ * Flow engine ops.
+ *
+ * Each flow engine must provide a set of operations to handle common operations,
+ * such as:
+ *
+ * - Check whether the engine is available for use (is_available)
+ * - Initialize and clean up engine resources (init/uninit)
+ * - Allocate memory for flow rules (flow_alloc)
+ * - Parse flow attributes and actions into engine-specific context (ctx_parse)
+ * - Pattern graph to use when parsing flow patterns (graph)
+ * - Validate the parsed attributes and actions against the data parsed from pattern (ctx_validate)
+ * - Build the actual flow rule structure from the parsed context (ctx_to_flow)
+ * - Add/remove the flow rule to/from hardware or driver's internal state (flow_install/flow_uninstall)
+ * - Query data for the flow rule (flow_query)
+ *
+ * The intended flow and semantics is as follows:
+ *
+ * - at init time:
+ *   [is_available] -> [init]
+ *
+ * - at rte_flow_validate time:
+ *   ctx_parse -> graph parser -> [ctx_validate] -> [ctx_to_flow]
+ *
+ * - at rte_flow_create time:
+ *   [flow_alloc] -> ctx_parse -> graph parser -> [ctx_validate] -> [ctx_to_flow -> [flow_install]]
+ *
+ * - at rte_flow_destroy/rte_flow_flush time:
+ *   [flow_uninstall] -> [flow_free]
+ *
+ * - at rte_flow_query time:
+ *   [flow_query]
+ *
+ * The engine availability must be checked by the driver at init time. The exact
+ * mechanics of this is left up to each individual driver - it may be hardware
+ * capability bits, PHY type check, devargs, or any other criteria that makes
+ * sense in the context of driver/adapter. If the availability callback is not
+ * implemented, the engine is assumed to be always available.
+ *
+ * The ctx_parse acts as the main gateway to parse flow actions and attributes,
+ * and so is mandatory. It is expected to fill the context structure.
+
+ * The init/uninit are optional resource lifecycle callbacks. If `priv_size` is
+ * non-zero, the framework allocates a zeroed private memory block and passes
+ * it to init/uninit.
+ *
+ * The flow_alloc is an optional allocator callback - if it is not defined, the
+ * engine will use rte_zmalloc with the provided flow_size to allocate memory
+ * for a flow rule. This callback will be useful for drivers who wish to e.g.
+ * allocate flow rules from a mempool, static memory, or any other custom memory
+ * management scheme. If allocation fails, fallback to default allocator will be
+ * used.
+ *
+ * Custom allocators only own their own engine-specific fields.
+ * The ci_flow common fields (engine_type, fallback_alloc, dev, node) are
+ * owned by the framework and will be initialised after the callback returns.
+ *
+ * The graph parser will take in the actual flow pattern, match it against the
+ * pattern graph, and put more data into the context structure. The engine may
+ * not provide a graph, in which case a default pattern graph is provided that
+ * will match the following:
+ *
+ * - empty patterns (start -> end)
+ * - "any" patterns (start -> any -> end)
+ *
+ * The ctx_validate is meant to perform any final checks on incongruity between
+ * the context data parsed from actions/attributes and the pattern graph. The
+ * engine may not provide this function, it is there purely to provide an avenue
+ * for cleaner logic separation where it makes sense.
+ *
+ * The ctx_to_flow uses the context data to fill in the actual flow structure.
+ *
+ * Finally, flow_install/flow_uninstall are meant to install/uninstall the flow
+ * and modify driver's internal structures and/or hardware state. The engine
+ * may not provide these functions if no internal state modification beyond
+ * storing the rule is required.
+ *
+ * The flow_free is an optional deallocator callback - if it is not defined,
+ * the engine will use rte_free to free memory for a flow rule. This callback
+ * must be present if flow_alloc is present.
+ *
+ * For querying data, the flow_query function is provided to query data for the
+ * flow rule. The engine may not provide this function, in which case
+ * any attempt to query the rule will result in failure when using reference
+ * implementation.
+ *
+ * If custom implementation for parts of the engine is used, take care to lock
+ * the config at appropriate times.
+ */
+struct ci_flow_engine_ops {
+	/* check whether engine is available - can be NULL */
+	bool (*is_available)(const struct ci_flow_engine *engine, const struct rte_eth_dev *dev);
+	/* init callback for engine-scoped resources - can be NULL */
+	int (*init)(const struct ci_flow_engine *engine,
+			struct rte_eth_dev *dev,
+			void *priv);
+	/* uninit callback for engine-scoped resources - can be NULL */
+	void (*uninit)(const struct ci_flow_engine *engine, void *priv);
+	/* allocation callback for flow rules - can be NULL */
+	struct ci_flow *(*flow_alloc)(const struct ci_flow_engine *engine, struct rte_eth_dev *dev);
+	/* deallocation callback for flow rules - can be NULL */
+	void (*flow_free)(struct ci_flow *flow);
+	/* initialize engine context from flow attr/actions - mandatory */
+	int (*ctx_parse)(const struct rte_flow_action actions[],
+			const struct rte_flow_attr *attr,
+			struct ci_flow_engine_ctx *ctx,
+			struct rte_flow_error *error);
+	/* final pass before converting context to flow - can be NULL */
+	int (*ctx_validate)(struct ci_flow_engine_ctx *ctx,
+			struct rte_flow_error *error);
+	/* initialize flow rule from parsed context - can be NULL */
+	int (*ctx_to_flow)(const struct ci_flow_engine_ctx *ctx,
+			struct ci_flow *flow,
+			struct rte_flow_error *error);
+	/* install a flow rule - can be NULL */
+	int (*flow_install)(struct ci_flow *flow,
+			struct rte_flow_error *error);
+	/* uninstall a flow rule - can be NULL */
+	int (*flow_uninstall)(struct ci_flow *flow,
+			struct rte_flow_error *error);
+	/* query flow - can be NULL */
+	int (*flow_query)(struct ci_flow *flow,
+			const struct rte_flow_action *action,
+			void *data,
+			struct rte_flow_error *error);
+};
+
+/*
+ * common definition for flow engine context.
+ * each engine will define its own context structure that
+ * *must* start with this base structure.
+ */
+struct ci_flow_engine_ctx {
+	/* ethernet device this context belongs to */
+	struct rte_eth_dev *dev;
+};
+
+/*
+ * Common definition for flow rule.
+ *
+ * For flow rules, there are three parts to consider:
+ *
+ * 1) Common data
+ * 2) Driver-specific data
+ * 3) Engine-specific data
+ *
+ * The common data is defined here as the `ci_flow` structure. It contains
+ * fields that are common to all flow rules, regardless of driver or engine.
+ * This includes a linked list node for managing flow rules in a list, a pointer
+ * to the device (driver instance) the flow belongs to, and the engine type
+ * that created the flow.
+ *
+ * With rte_flow API, each driver is meant to define its own rte_flow structure
+ * that contains driver-specific data. This structure must start with the
+ * `ci_flow` structure defined here, followed by driver-specific fields.
+ *
+ * Additionally, each *engine* may want to define its own flow rule structure
+ * that contains actual engine-specific data. This structure must start with the
+ * driver-wide `rte_flow` structure such that it contains everything before it,
+ * followed by engine-specific fields.
+ *
+ * IMPORTANT:
+ *
+ * All of these structures will be referred to by the same pointer and can be
+ * freely (and safely) cast between each other *as long as* each structure
+ * definition has the parent structure as its first member. E.g. the common flow
+ * struct is `ci_flow`, and the driver-specific `rte_flow` must be defined as
+ * follows:
+ *
+ * struct rte_flow {
+ *     struct ci_flow base;
+ *     ...any driver-specific fields...
+ * }
+ *
+ * If the engine needs to define its own flow structure, in turn it should be
+ * defined as follows:
+ *
+ * struct ixgbe_fdir_flow {
+ *     struct rte_flow base;
+ *     ...any engine-specific fields...
+ * }
+ *
+ * This ensures pointer conversion safety between all three types:
+ *
+ *     struct ci_flow *flow = ...;
+ *     struct rte_flow *rte_flow = (struct rte_flow *)flow;
+ *     struct ixgbe_fdir_flow *fdir_flow = (struct ixgbe_fdir_flow *)flow;
+ *
+ * The engine structure provides a `flow_size` field that indicates how much
+ * memory is required for a particular engine's flow structure. The driver must
+ * provide that value for each engine, as it will be used to size flow structure
+ * allocations. If the engine does not require any memory beyond the `rte_flow`
+ * structure, this value should be set to `sizeof(rte_flow)` for those engines.
+ */
+struct ci_flow {
+	TAILQ_ENTRY(ci_flow) node;
+	/* device this flow belongs to */
+	struct rte_eth_dev *dev;
+	/* engine this flow was created by */
+	size_t engine_type;
+	/* if the engine has custom allocator but fallback was used to allocate */
+	bool fallback_alloc;
+};
+
+/* flow engine definition */
+struct ci_flow_engine {
+	/* engine name */
+	const char *name;
+	/* engine type */
+	size_t type;
+	/* size of scratch space structure, can be 0 */
+	size_t ctx_size;
+	/* size of flow rule structure, must not be 0 */
+	size_t flow_size;
+	/* size of per-device engine private data, can be 0 */
+	size_t priv_size;
+	/* ops for this flow engine */
+	const struct ci_flow_engine_ops *ops;
+	/* pattern graph this engine supports - can be NULL to match empty patterns */
+	const struct rte_flow_graph *graph;
+};
+
+/* maximum number of engines is 63 + sentinel (NULL pointer) */
+#define CI_FLOW_ENGINE_MAX	62
+#define CI_FLOW_ENGINE_LIST_SIZE	64
+
+/* flow engine list definition */
+struct ci_flow_engine_list {
+	/* NULL-terminated array of flow engine pointers */
+	const struct ci_flow_engine *engines[CI_FLOW_ENGINE_LIST_SIZE];
+};
+
+/* flow engine configuration - each device must have its own instance */
+struct ci_flow_engine_conf {
+	/* lock to protect config */
+	rte_rwlock_t config_lock;
+	/* list of flows created on this device */
+	TAILQ_HEAD(ci_flow_list, ci_flow) flows;
+	/* bitmask of enabled engines */
+	uint64_t enabled_engines;
+	/* back-reference to device structure */
+	struct rte_eth_dev *dev;
+	/* per-engine private data pointers, indexed by engine type */
+	void *engine_priv[CI_FLOW_ENGINE_LIST_SIZE];
+};
+
+/* helper macro to iterate over list of engines */
+#define CI_FLOW_ENGINE_LIST_FOREACH(engine_ptr, engine_list)    \
+	for (size_t __i = 0;                                        \
+	     __i < CI_FLOW_ENGINE_MAX &&                            \
+	     ((engine_ptr) = (engine_list)->engines[__i]) != NULL;  \
+	     __i++)
+
+/* basic checks for flow engine validity */
+static inline bool
+ci_flow_engine_is_valid(const struct ci_flow_engine *engine)
+{
+	/* is the pointer valid? */
+	if (engine == NULL)
+		return false;
+	/* does the engine have a name? */
+	if (engine->name == NULL)
+		return false;
+	/* is the engine type within bounds? */
+	if (engine->type >= CI_FLOW_ENGINE_MAX)
+		return false;
+	/* does the engine have ops? */
+	if (engine->ops == NULL)
+		return false;
+	/* does the engine have mandatory ctx_parse op? */
+	if (engine->ops->ctx_parse == NULL)
+		return false;
+	/* flow size cannot be less than ci_flow */
+	if (engine->flow_size < sizeof(struct ci_flow))
+		return false;
+	/* alloc and free must both be defined or NULL */
+	if ((engine->ops->flow_alloc == NULL) != (engine->ops->flow_free == NULL))
+		return false;
+	/* engine looks valid */
+	return true;
+}
+
+/* helper to validate whether an engine can be enabled - thread-unsafe */
+static inline bool
+ci_flow_engine_is_supported(const struct ci_flow_engine *engine, const struct rte_eth_dev *dev)
+{
+	/* basic checks */
+	if (!ci_flow_engine_is_valid(engine))
+		return false;
+
+	/* does it have engine-specific validation? */
+	if (engine->ops->is_available != NULL) {
+		return engine->ops->is_available(engine, dev);
+	}
+	/* no specific validation required, allow by default */
+	return true;
+}
+
+/* helper to check whether an engine is enabled in the bitmask - thread-unsafe */
+static inline bool
+ci_flow_engine_enabled(const struct ci_flow_engine_conf *conf, const struct ci_flow_engine *engine)
+{
+	return (conf->enabled_engines & (1ULL << engine->type)) != 0;
+}
+
+/* helper to enable an engine in the bitmask - thread-unsafe */
+static inline void
+ci_flow_engine_enable(struct ci_flow_engine_conf *conf, const struct ci_flow_engine *engine)
+{
+	conf->enabled_engines |= (1ULL << engine->type);
+}
+
+/* find engine by flow type in the engine list - thread-unsafe */
+static inline const struct ci_flow_engine *
+ci_flow_engine_find(const struct ci_flow_engine_list *engine_list, const size_t type)
+{
+	const struct ci_flow_engine *engine;
+
+	CI_FLOW_ENGINE_LIST_FOREACH(engine, engine_list) {
+		if (engine->type == type)
+			return engine;
+	}
+	return NULL;
+}
+
+/* get per-device engine private data by engine type - thread-unsafe */
+static inline void *
+ci_flow_engine_priv(const struct ci_flow_engine_conf *engine_conf, const size_t type)
+{
+	return engine_conf->engine_priv[type];
+}
+
+static inline struct ci_flow *
+ci_flow_alloc(const struct ci_flow_engine *engine, struct rte_eth_dev *dev)
+{
+	struct ci_flow *flow = NULL;
+	bool fallback = false;
+
+	/* if engine has custom allocator, try it first */
+	if (engine->ops->flow_alloc != NULL) {
+		flow = engine->ops->flow_alloc(engine, dev);
+		/* erase the common parts */
+		if (flow != NULL)
+			*flow = (struct ci_flow){0};
+	}
+	/* if custom allocator is not defined or failed, fallback to default allocator */
+	if (flow == NULL) {
+		flow = rte_zmalloc(NULL, engine->flow_size, 0);
+
+		/* if we are here and we have a custom allocator, that means we fell back */
+		if (flow != NULL && engine->ops->flow_alloc != NULL)
+			fallback = true;
+	}
+	/* set the engine type to enable correct deallocation in case of failure */
+	if (flow != NULL) {
+		flow->fallback_alloc = fallback;
+		flow->engine_type = engine->type;
+	}
+	return flow;
+}
+
+static inline void
+ci_flow_free(const struct ci_flow_engine *engine, struct ci_flow *flow)
+{
+	if (engine->ops->flow_free != NULL && !flow->fallback_alloc)
+		engine->ops->flow_free(flow);
+	else
+		rte_free(flow);
+}
+
+/* allocate per-device engine private data and call init - thread-unsafe */
+static inline int
+ci_flow_engine_init(const struct ci_flow_engine *engine,
+		struct ci_flow_engine_conf *engine_conf)
+{
+	void *priv = NULL;
+	int ret;
+
+	if (engine->priv_size > 0) {
+		priv = rte_zmalloc(engine->name, engine->priv_size, 0);
+		if (priv == NULL) {
+			ret = -ENOMEM;
+			goto err;
+		}
+		engine_conf->engine_priv[engine->type] = priv;
+	}
+
+	if (engine->ops->init != NULL) {
+		ret = engine->ops->init(engine, engine_conf->dev,
+				engine_conf->engine_priv[engine->type]);
+		if (ret != 0)
+			goto err;
+	}
+	return 0;
+err:
+	if (priv != NULL) {
+		rte_free(priv);
+		engine_conf->engine_priv[engine->type] = NULL;
+	}
+	return ret;
+}
+
+/* call uninit and free per-device engine private data - thread-unsafe */
+static inline void
+ci_flow_engine_uninit(const struct ci_flow_engine *engine,
+		struct ci_flow_engine_conf *engine_conf)
+{
+	void *priv = engine_conf->engine_priv[engine->type];
+
+	/* ignore uninit errors */
+	if (engine->ops->uninit != NULL)
+		engine->ops->uninit(engine, priv);
+
+	if (priv != NULL) {
+		rte_free(priv);
+		engine_conf->engine_priv[engine->type] = NULL;
+	}
+}
+
+/* disable all engines for a specific driver instance - thread-safe */
+static inline void
+ci_flow_engine_conf_reset(struct ci_flow_engine_conf *engine_conf,
+		const struct ci_flow_engine_list *engine_list)
+{
+	const struct ci_flow_engine *engine;
+	struct ci_flow *flow, *tmp;
+
+	/* lock the config */
+	rte_rwlock_write_lock(&engine_conf->config_lock);
+
+	/* free all flows - shouldn't have any at this point */
+	RTE_TAILQ_FOREACH_SAFE(flow, &engine_conf->flows, node, tmp) {
+		engine = ci_flow_engine_find(engine_list, flow->engine_type);
+		ci_flow_free(engine, flow);
+		TAILQ_REMOVE(&engine_conf->flows, flow, node);
+	}
+
+	CI_FLOW_ENGINE_LIST_FOREACH(engine, engine_list) {
+		if (!ci_flow_engine_enabled(engine_conf, engine))
+			continue;
+		ci_flow_engine_uninit(engine, engine_conf);
+	}
+
+	/* disable all engines */
+	engine_conf->enabled_engines = 0;
+
+	/* erase device pointer */
+	engine_conf->dev = NULL;
+
+	/* unlock the config */
+	rte_rwlock_write_unlock(&engine_conf->config_lock);
+}
+
+/* enable all engines for a specific driver instance - thread-unsafe */
+static inline void
+ci_flow_engine_conf_init(struct ci_flow_engine_conf *engine_conf,
+		const struct ci_flow_engine_list *engine_list,
+		struct rte_eth_dev *dev)
+{
+	const struct ci_flow_engine *engine;
+
+	/* init the lock */
+	rte_rwlock_init(&engine_conf->config_lock);
+
+	/* store device pointer */
+	engine_conf->dev = dev;
+
+	/* init the flow list */
+	TAILQ_INIT(&engine_conf->flows);
+
+	/* enable all engines */
+	CI_FLOW_ENGINE_LIST_FOREACH(engine, engine_list) {
+		if (!ci_flow_engine_is_supported(engine, dev))
+			continue;
+
+		if (ci_flow_engine_init(engine, engine_conf) != 0)
+			continue;
+
+		ci_flow_engine_enable(engine_conf, engine);
+	}
+}
+
+/* validate whether a flow is valid for a specific engine configuration - thread-unsafe */
+static inline bool
+ci_flow_is_valid(const struct ci_flow *flow,
+		const struct ci_flow_engine_conf *engine_conf,
+		const struct ci_flow_engine_list *engine_list)
+{
+	const struct ci_flow_engine *engine;
+
+	/* is the pointer valid? */
+	if (flow == NULL)
+		return false;
+	/* does the flow belong to this device? */
+	if (flow->dev != engine_conf->dev)
+		return false;
+	/* can we find the engine that created this flow? */
+	engine = ci_flow_engine_find(engine_list, flow->engine_type);
+	if (engine == NULL)
+		return false;
+	/* engine must be valid */
+	if (!ci_flow_engine_is_valid(engine))
+		return false;
+	/* engine must be enabled */
+	if (!ci_flow_engine_enabled(engine_conf, engine))
+		return false;
+	/* flow looks valid */
+	return true;
+}
+
+/* default empty pattern graph definitions */
+enum ci_flow_empty_graph_node_id {
+	CI_FLOW_EMPTY_GRAPH_NODE_START = RTE_FLOW_NODE_FIRST,
+	CI_FLOW_EMPTY_GRAPH_NODE_ANY,
+	CI_FLOW_EMPTY_GRAPH_NODE_END,
+};
+
+static const struct rte_flow_graph ci_flow_empty_graph = {
+	.nodes = (struct rte_flow_graph_node []) {
+		[CI_FLOW_EMPTY_GRAPH_NODE_START] = {
+			.name = "START",
+		},
+		[CI_FLOW_EMPTY_GRAPH_NODE_ANY] = {
+			.name = "ANY",
+			.type = RTE_FLOW_ITEM_TYPE_ANY,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+		},
+		[CI_FLOW_EMPTY_GRAPH_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	},
+	.edges = (struct rte_flow_graph_edge []) {
+		[CI_FLOW_EMPTY_GRAPH_NODE_START] = {
+			.next = (const size_t []) {
+				CI_FLOW_EMPTY_GRAPH_NODE_ANY,
+				CI_FLOW_EMPTY_GRAPH_NODE_END,
+				RTE_FLOW_NODE_EDGE_END,
+			},
+		},
+		[CI_FLOW_EMPTY_GRAPH_NODE_ANY] = {
+			.next = (const size_t []) {
+				CI_FLOW_EMPTY_GRAPH_NODE_END,
+				RTE_FLOW_NODE_EDGE_END,
+			},
+		},
+	}
+};
+
+/* parse a flow using a specific engine - thread-unsafe */
+static inline int
+ci_flow_parse(const struct ci_flow_engine_conf *engine_conf,
+		const struct ci_flow_engine *engine,
+		const struct rte_flow_attr *attr,
+		const struct rte_flow_item pattern[],
+		const struct rte_flow_action actions[],
+		struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct ci_flow_engine_ctx *ctx;
+	int ret = 0;
+
+	/* engines that aren't enabled cannot be used for validation */
+	if (!ci_flow_engine_enabled(engine_conf, engine)) {
+		return rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Flow engine is not enabled");
+	}
+
+	/* allocate context */
+	ctx = calloc(1, RTE_MAX(engine->ctx_size, sizeof(struct ci_flow_engine_ctx)));
+	if (ctx == NULL) {
+		return rte_flow_error_set(error, ENOMEM,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Failed to allocate memory for rule engine context");
+	}
+	ctx->dev = engine_conf->dev;
+	flow->dev = engine_conf->dev;
+
+	/* parse flow parameters */
+	ret = engine->ops->ctx_parse(actions, attr, ctx, error);
+
+	/* context init failed - that means engine can't be used for this flow */
+	if (ret != 0)
+		goto free_ctx;
+
+	/* NULL pattern is allowed for engines that don't match any patterns */
+	if (pattern == NULL && engine->graph != NULL) {
+		ret = rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, NULL,
+				"Pattern cannot be NULL");
+		goto free_ctx;
+	} else if (pattern != NULL) {
+		const struct rte_flow_graph *graph = engine->graph;
+
+		/* if graph isn't provided, use empty graph */
+		if (graph == NULL)
+			graph = &ci_flow_empty_graph;
+
+		ret = rte_flow_graph_parse(graph, pattern, error, ctx);
+	}
+
+	/* if graph parsing failed, pattern didn't match */
+	if (ret != 0)
+		goto free_ctx;
+
+	/* final verification, if the operation is defined */
+	if (engine->ops->ctx_validate != NULL)
+		ret = engine->ops->ctx_validate(ctx, error);
+
+	/* finalization failed - mismatch between parsed data and context data */
+	if (ret != 0)
+		goto free_ctx;
+
+	/* if we need to build rules from context, do it */
+	if (engine->ops->ctx_to_flow != NULL) {
+		ret = engine->ops->ctx_to_flow(ctx, flow, error);
+
+		/* flow building failed - something wrong with context data */
+		if (ret != 0)
+			goto free_ctx;
+	}
+	/* success */
+	ret = 0;
+
+free_ctx:
+	free(ctx);
+	return ret;
+}
+
+/* uninstall a flow using its appropriate engine - thread-unsafe */
+static inline int
+ci_flow_uninstall(const struct ci_flow_engine_list *engine_list,
+		struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	const struct ci_flow_engine *engine;
+
+	/* find the engine that created this flow */
+	engine = ci_flow_engine_find(engine_list, flow->engine_type);
+	if (engine == NULL) {
+		return rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Flow engine that created this flow is not available");
+	}
+
+	/* uninstall the flow if required */
+	if (engine->ops->flow_uninstall != NULL) {
+		return engine->ops->flow_uninstall(flow, error);
+	}
+
+	return 0;
+}
+
+/*
+ * The following functions are designed to be called from the context of
+ * rte_flow API implementations and are meant to be used as reference/default
+ * implementations.
+ *
+ * Thread-safe.
+ */
+
+/* default implementation of rte_flow_create using flow engines */
+static inline struct rte_flow *
+ci_flow_create(struct ci_flow_engine_conf *engine_conf,
+		const struct ci_flow_engine_list *engine_list,
+		const struct rte_flow_attr *attr,
+		const struct rte_flow_item pattern[],
+		const struct rte_flow_action actions[],
+		struct rte_flow_error *error)
+{
+	const struct ci_flow_engine *engine;
+	struct ci_flow *flow = NULL;
+	int ret;
+
+	if (attr == NULL || actions == NULL) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ATTR, NULL,
+				"Attributes and actions cannot be NULL");
+		return NULL;
+	}
+
+	/* lock the config for writing */
+	rte_rwlock_write_lock(&engine_conf->config_lock);
+
+	/* find an engine that can handle this flow */
+	CI_FLOW_ENGINE_LIST_FOREACH(engine, engine_list) {
+		if (!ci_flow_engine_enabled(engine_conf, engine))
+			continue;
+
+		flow = ci_flow_alloc(engine, engine_conf->dev);
+		if (flow == NULL) {
+			rte_flow_error_set(error, ENOMEM,
+					RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+					"Failed to allocate memory for flow rule");
+			/* this is a serious error so don't continue */
+			goto unlock;
+		}
+
+		ret = ci_flow_parse(engine_conf, engine, attr, pattern,
+				actions, flow, error);
+
+		/* if successfully parsed, install */
+		if (ret == 0 && engine->ops->flow_install != NULL) {
+			ret = engine->ops->flow_install(flow, error);
+		}
+
+		if (ret == 0) {
+			/* success */
+			goto unlock;
+		}
+
+		/* parsing failed - free the flow and try next engine */
+		ci_flow_free(engine, flow);
+	}
+
+	/* no engine could handle this flow */
+	flow = NULL;
+	rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+			"No flow engine could handle the requested flow");
+unlock:
+	rte_rwlock_write_unlock(&engine_conf->config_lock);
+
+	return (struct rte_flow *)flow;
+}
+
+/* default implementation of rte_flow_validate using flow engines */
+static inline int
+ci_flow_validate(struct ci_flow_engine_conf *engine_conf,
+		const struct ci_flow_engine_list *engine_list,
+		const struct rte_flow_attr *attr,
+		const struct rte_flow_item pattern[],
+		const struct rte_flow_action actions[],
+		struct rte_flow_error *error)
+{
+	const struct ci_flow_engine *engine;
+	int ret;
+
+	if (attr == NULL || actions == NULL) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ATTR, NULL,
+				"Attributes and actions cannot be NULL");
+	}
+
+	/* lock the config for reading */
+	rte_rwlock_read_lock(&engine_conf->config_lock);
+
+	/* find an engine that can handle this flow */
+	CI_FLOW_ENGINE_LIST_FOREACH(engine, engine_list) {
+		struct ci_flow *flow;
+
+		if (!ci_flow_engine_enabled(engine_conf, engine))
+			continue;
+
+		/* use OS allocator as we're not keeping the flow */
+		flow = calloc(1, engine->flow_size);
+		if (flow == NULL) {
+			/* this is a serious error so don't continue */
+			ret = rte_flow_error_set(error, ENOMEM,
+					RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+					"Failed to allocate memory for flow rule");
+			goto unlock;
+		}
+		/* try to parse the flow with this engine */
+		ret = ci_flow_parse(engine_conf, engine, attr, pattern,
+				actions, flow, error);
+		free(flow);
+
+		if (ret == 0) {
+			/* success */
+			goto unlock;
+		}
+	}
+	/* no engine could handle this flow */
+	ret = rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+			"No flow engine could handle the requested flow");
+unlock:
+	rte_rwlock_read_unlock(&engine_conf->config_lock);
+	return ret;
+}
+
+/* default implementation of rte_flow_destroy using flow engines. */
+static inline int
+ci_flow_destroy(struct ci_flow_engine_conf *engine_conf,
+		const struct ci_flow_engine_list *engine_list,
+		struct rte_flow *rte_flow,
+		struct rte_flow_error *error)
+{
+	struct ci_flow *flow = (struct ci_flow *)rte_flow;
+	const struct ci_flow_engine *engine;
+	int ret = 0;
+
+	if (rte_flow == NULL) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Flow handle cannot be NULL");
+	}
+
+	/* lock the config for writing */
+	rte_rwlock_write_lock(&engine_conf->config_lock);
+
+	/* find the engine that created this flow */
+	engine = ci_flow_engine_find(engine_list, flow->engine_type);
+
+	/* validate the flow */
+	if (!ci_flow_is_valid(flow, engine_conf, engine_list) || engine == NULL) {
+		ret = rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Invalid flow handle");
+		goto unlock;
+	}
+
+	ret = ci_flow_uninstall(engine_list, flow, error);
+
+	if (ret != 0)
+		goto unlock;
+
+	/* remove the flow from the list and free it */
+	TAILQ_REMOVE(&engine_conf->flows, flow, node);
+	ci_flow_free(engine, flow);
+unlock:
+	rte_rwlock_write_unlock(&engine_conf->config_lock);
+
+	return ret;
+}
+
+/* default implementation of rte_flow_flush using flow engines */
+static inline int
+ci_flow_flush(struct ci_flow_engine_conf *engine_conf,
+		const struct ci_flow_engine_list *engine_list,
+		struct rte_flow_error *error)
+{
+	struct ci_flow *flow, *tmp;
+
+	/* lock the config for writing */
+	rte_rwlock_write_lock(&engine_conf->config_lock);
+
+	/* iterate over all flows and uninstall them */
+	RTE_TAILQ_FOREACH_SAFE(flow, &engine_conf->flows, node, tmp) {
+		const struct ci_flow_engine *engine;
+
+		/* find the engine that created this flow */
+		engine = ci_flow_engine_find(engine_list, flow->engine_type);
+		/* shouldn't happen */
+		if (engine == NULL)
+			continue;
+
+		/* ignore failures */
+		ci_flow_uninstall(engine_list, flow, error);
+
+		TAILQ_REMOVE(&engine_conf->flows, flow, node);
+		ci_flow_free(engine, flow);
+	}
+
+	rte_rwlock_write_unlock(&engine_conf->config_lock);
+
+	return 0;
+}
+
+/* default implementation of rte_flow_query using flow engines */
+static inline int
+ci_flow_query(struct ci_flow_engine_conf *engine_conf,
+		const struct ci_flow_engine_list *engine_list,
+		struct rte_flow *rte_flow,
+		const struct rte_flow_action *action,
+		void *data,
+		struct rte_flow_error *error)
+{
+	struct ci_flow *flow = (struct ci_flow *)rte_flow;
+	const struct ci_flow_engine *engine;
+	int ret;
+
+	if (action == NULL || data == NULL) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+				"Action or data cannot be NULL");
+	}
+
+	/* lock the config for reading */
+	rte_rwlock_read_lock(&engine_conf->config_lock);
+
+	/* validate the flow first */
+	if (!ci_flow_is_valid(flow, engine_conf, engine_list)) {
+		ret = rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Invalid flow handle");
+		goto unlock;
+	}
+	/* find the engine that created this flow */
+	engine = ci_flow_engine_find(engine_list, flow->engine_type);
+	if (engine == NULL) {
+		ret = rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Flow engine that created this flow is not available");
+		goto unlock;
+	}
+	/* query the flow if supported */
+	if (engine->ops->flow_query != NULL) {
+		ret = engine->ops->flow_query(flow, action, data, error);
+	} else {
+		ret = rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+			"Flow engine does not support querying");
+	}
+unlock:
+	rte_rwlock_read_unlock(&engine_conf->config_lock);
+
+	return ret;
+}
+
+#endif /* _COMMON_INTEL_FLOW_ENGINE_H_ */
-- 
2.47.3

