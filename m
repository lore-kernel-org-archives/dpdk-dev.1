Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC17C982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 14:24:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 178D140299;
	Tue, 22 Sep 2026 16:24:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 1E487400D5;
 Tue, 22 Sep 2026 16:24:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790087065; x=1821623065;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7gOKzXQuieiWoQQozHTt7I+xf3wilXXbGFIcd7HQWec=;
 b=Nj0ncBPps9rOf7t1pWedBR9nL+I7Up8bzFlm3JXaSFhg7ydCSvzRepcm
 gmOCgnFULgsPfFj2s5Avw/MuYRLyUhZXUtM/VgjvhSkCPndzjwPJoWrG+
 uf8k1Zqk0Nr58I+SEq3PIL9Ikm8hqC5b5Prkom98sBOFPwT+lB706PZb4
 s0nkkwwJk/CqZvjWad4lOmlWgg6Tm80nDv55vRBVLf6zPuzUPXMYymIj/
 yxoytrYYAxtX/COhdvzGsUvoy2lOzkQ5qQykeii0BszS04EQU4xxHPFvi
 QBANuPAR89iowiXw/bhfkQ+OLMZkeqSZaV9M6Spgz/orvXXaDp/n41Qkf Q==;
X-CSE-ConnectionGUID: rVsryeFCTsqc7nb3hD0d+A==
X-CSE-MsgGUID: OLpz4ehKRGCDP2USB++WLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="94522369"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="94522369"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 07:24:24 -0700
X-CSE-ConnectionGUID: 5It5VaSgTWKltBYu039uvg==
X-CSE-MsgGUID: ioT4Jai4SZmSNoK0mZw86A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="272353104"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa010.fm.intel.com with ESMTP; 22 Sep 2026 07:24:23 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, Bruce Richardson <bruce.richardson@intel.com>,
 stable@dpdk.org
Subject: [PATCH v2] net/ring: remove internal devarg
Date: Tue, 22 Sep 2026 15:24:11 +0100
Message-ID: <20260922142411.2975581-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922113614.2952557-1-bruce.richardson@intel.com>
References: <20260922113614.2952557-1-bruce.richardson@intel.com>
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

The devarg "internal" was used to pass a pointer to the creation
function to reuse set parameters. However, this meant it could also be
used as a devarg on the commandline leading to incorrect behaviour.
Redesign the passing of the args parameters to use a per-thread global
instead. The wrapper function sets the global to a valid value before
calling the main creation function, skipping passing a devarg, before
resetting the pointer back to NULL when the function returns.

Bugzilla ID: 1687
Fixes: 96cb19521147 ("net/ring: use EAL APIs in PMD specific API")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
v2
* clear the args settings immediately after read, in case of a
  reentrant call
* minor comment cleanups
---
 drivers/net/ring/rte_eth_ring.c | 145 ++++++++++++--------------------
 1 file changed, 54 insertions(+), 91 deletions(-)

diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_ring.c
index b639544eab..3b476b8587 100644
--- a/drivers/net/ring/rte_eth_ring.c
+++ b/drivers/net/ring/rte_eth_ring.c
@@ -11,6 +11,7 @@
 #include <rte_malloc.h>
 #include <rte_memcpy.h>
 #include <rte_os_shim.h>
+#include <rte_per_lcore.h>
 #include <rte_string_fns.h>
 #include <bus_vdev_driver.h>
 #include <rte_kvargs.h>
@@ -20,12 +21,9 @@
 #define ETH_RING_ACTION_CREATE		"CREATE"
 #define ETH_RING_ACTION_ATTACH		"ATTACH"
 #define ETH_RING_ACTION_MAX_LEN		8 /* CREATE | ACTION */
-#define ETH_RING_INTERNAL_ARG		"internal"
-#define ETH_RING_INTERNAL_ARG_MAX_LEN	19 /* "0x..16chars..\0" */
 
 static const char *valid_arguments[] = {
 	ETH_RING_NUMA_NODE_ACTION_ARG,
-	ETH_RING_INTERNAL_ARG,
 	NULL
 };
 
@@ -35,9 +33,11 @@ struct ring_internal_args {
 	struct rte_ring * const *tx_queues;
 	const unsigned int nb_tx_queues;
 	const unsigned int numa_node;
-	void *addr; /* self addr for sanity check */
 };
 
+/* rte_eth_from_rings() stashes a pointer to its on-stack args here */
+static RTE_DEFINE_PER_LCORE(struct ring_internal_args *, eth_ring_internal_args);
+
 enum dev_action {
 	DEV_CREATE,
 	DEV_ATTACH
@@ -474,9 +474,7 @@ rte_eth_from_rings(const char *name, struct rte_ring *const rx_queues[],
 		.tx_queues = tx_queues,
 		.nb_tx_queues = nb_tx_queues,
 		.numa_node = numa_node,
-		.addr = &args,
 	};
-	char args_str[32];
 	char ring_name[RTE_RING_NAMESIZE];
 	uint16_t port_id = RTE_MAX_ETHPORTS;
 	int ret;
@@ -495,16 +493,16 @@ rte_eth_from_rings(const char *name, struct rte_ring *const rx_queues[],
 		return -1;
 	}
 
-	snprintf(args_str, sizeof(args_str), "%s=%p",
-		 ETH_RING_INTERNAL_ARG, &args);
-
 	ret = snprintf(ring_name, sizeof(ring_name), "net_ring_%s", name);
 	if (ret >= (int)sizeof(ring_name)) {
 		rte_errno = ENAMETOOLONG;
 		return -1;
 	}
 
-	ret = rte_vdev_init(ring_name, args_str);
+	/* mark this thread's pending request; consumed and cleared by probe */
+	RTE_PER_LCORE(eth_ring_internal_args) = &args;
+	ret = rte_vdev_init(ring_name, NULL);
+	RTE_PER_LCORE(eth_ring_internal_args) = NULL;
 	if (ret) {
 		rte_errno = EINVAL;
 		return -1;
@@ -649,36 +647,6 @@ static int parse_kvlist(const char *key __rte_unused,
 	return ret;
 }
 
-static int
-parse_internal_args(const char *key __rte_unused, const char *value,
-		void *data)
-{
-	struct ring_internal_args **internal_args = data;
-	void *args;
-	int ret, n;
-
-	/* make sure 'value' is valid pointer length */
-	if (strnlen(value, ETH_RING_INTERNAL_ARG_MAX_LEN) >=
-			ETH_RING_INTERNAL_ARG_MAX_LEN) {
-		PMD_LOG(ERR, "Error parsing internal args, argument is too long");
-		return -1;
-	}
-
-	ret = sscanf(value, "%p%n", &args, &n);
-	if (ret == 0 || (size_t)n != strlen(value)) {
-		PMD_LOG(ERR, "Error parsing internal args");
-
-		return -1;
-	}
-
-	*internal_args = args;
-
-	if ((*internal_args)->addr != args)
-		return -1;
-
-	return 0;
-}
-
 static int
 rte_pmd_ring_probe(struct rte_vdev_device *dev)
 {
@@ -711,6 +679,21 @@ rte_pmd_ring_probe(struct rte_vdev_device *dev)
 		return 0;
 	}
 
+	/* set only by rte_eth_from_rings() */
+	internal_args = RTE_PER_LCORE(eth_ring_internal_args);
+	if (internal_args != NULL) {
+		RTE_PER_LCORE(eth_ring_internal_args) = NULL;
+		ret = do_eth_dev_ring_create(name, dev,
+			internal_args->rx_queues,
+			internal_args->nb_rx_queues,
+			internal_args->tx_queues,
+			internal_args->nb_tx_queues,
+			internal_args->numa_node,
+			DEV_ATTACH,
+			&eth_dev);
+		return ret >= 0 ? 0 : ret;
+	}
+
 	if (params == NULL || params[0] == '\0') {
 		ret = eth_dev_ring_create(name, dev, rte_socket_id(), DEV_CREATE,
 				&eth_dev);
@@ -739,57 +722,37 @@ rte_pmd_ring_probe(struct rte_vdev_device *dev)
 			return ret;
 		}
 
-		if (rte_kvargs_count(kvlist, ETH_RING_INTERNAL_ARG) == 1) {
-			ret = rte_kvargs_process(kvlist, ETH_RING_INTERNAL_ARG,
-						 parse_internal_args,
-						 &internal_args);
-			if (ret < 0)
-				goto out_free;
-
-			ret = do_eth_dev_ring_create(name, dev,
-				internal_args->rx_queues,
-				internal_args->nb_rx_queues,
-				internal_args->tx_queues,
-				internal_args->nb_tx_queues,
-				internal_args->numa_node,
-				DEV_ATTACH,
-				&eth_dev);
-			if (ret >= 0)
-				ret = 0;
-		} else {
-			ret = rte_kvargs_count(kvlist, ETH_RING_NUMA_NODE_ACTION_ARG);
-			info = rte_zmalloc("struct node_action_list",
-					   sizeof(struct node_action_list) +
-					   (sizeof(struct node_action_pair) * ret),
-					   0);
-			if (!info)
-				goto out_free;
-
-			info->total = ret;
-			info->list = (struct node_action_pair *)(info + 1);
-
-			ret = rte_kvargs_process(kvlist, ETH_RING_NUMA_NODE_ACTION_ARG,
-						 parse_kvlist, info);
-
-			if (ret < 0)
-				goto out_free;
-
-			for (info->count = 0; info->count < info->total; info->count++) {
-				ret = eth_dev_ring_create(info->list[info->count].name,
-							  dev,
-							  info->list[info->count].node,
-							  info->list[info->count].action,
-							  &eth_dev);
-				if ((ret == -1) &&
-				    (info->list[info->count].action == DEV_CREATE)) {
-					PMD_LOG(INFO,
-						"Attach to pmd_ring for %s",
-						name);
-					ret = eth_dev_ring_create(name, dev,
-							info->list[info->count].node,
-							DEV_ATTACH,
-							&eth_dev);
-				}
+		ret = rte_kvargs_count(kvlist, ETH_RING_NUMA_NODE_ACTION_ARG);
+		info = rte_zmalloc("struct node_action_list",
+				   sizeof(struct node_action_list) +
+				   (sizeof(struct node_action_pair) * ret),
+				   0);
+		if (!info)
+			goto out_free;
+
+		info->total = ret;
+		info->list = (struct node_action_pair *)(info + 1);
+
+		ret = rte_kvargs_process(kvlist, ETH_RING_NUMA_NODE_ACTION_ARG,
+					 parse_kvlist, info);
+
+		if (ret < 0)
+			goto out_free;
+
+		for (info->count = 0; info->count < info->total; info->count++) {
+			ret = eth_dev_ring_create(info->list[info->count].name,
+						  dev,
+						  info->list[info->count].node,
+						  info->list[info->count].action,
+						  &eth_dev);
+			if (ret == -1 && info->list[info->count].action == DEV_CREATE) {
+				PMD_LOG(INFO,
+					"Attach to pmd_ring for %s",
+					name);
+				ret = eth_dev_ring_create(name, dev,
+						info->list[info->count].node,
+						DEV_ATTACH,
+						&eth_dev);
 			}
 		}
 	}
-- 
2.53.0

