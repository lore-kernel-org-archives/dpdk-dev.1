Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C092CC02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 01:34:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 083C0406B4;
	Thu,  6 Feb 2025 02:33:44 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 6B5D340666
 for <dev@dpdk.org>; Thu,  6 Feb 2025 02:33:37 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 9BF7B203F5A6; Wed,  5 Feb 2025 17:33:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9BF7B203F5A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738805616;
 bh=k7jdG7dFf2HwAk1Sk5hywytB3erCymZtHNKpmFOusg0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=q5kZG57q4MIdHVh7moStKiiwoRTFBVxxzV+tS9e1bMRsptm90BNygJHqzbdAyMku9
 /VGimiqEgRYst7Go+eQyGjCvC0WLlPZ1iV5rJSL/c54x3ILhNj08N1xQWIgmPJ/LUO
 LecySDcPIk2B3OPe/to42Dt2FvBrEHnUmOr475YM=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com
Subject: [PATCH v22 04/27] ethdev: remove use of VLAs for Windows built code
Date: Wed,  5 Feb 2025 17:33:07 -0800
Message-Id: <1738805610-17507-5-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738805610-17507-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738805610-17507-1-git-send-email-andremue@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Konstantin Ananyev <konstantin.ananyev@huawei.com>

1) ./lib/ethdev/rte_ethdev.c:3244:16
    : warning: ISO C90 forbids variable length array ‘xstats_names’
2) ./lib/ethdev/rte_ethdev.c:3345:17
    : warning: ISO C90 forbids variable length array ‘ids_copy’
3) ./lib/ethdev/rte_ethdev.c:3538:16
    : warning: ISO C90 forbids variable length array ‘xstats’
4) ./lib/ethdev/rte_ethdev.c:3554:17
    : warning: ISO C90 forbids variable length array ‘ids_copy’

For 1) and 3) - just replaced VLA with arrays allocated from heap.
As I understand xstats extraction belongs to control-path, so extra
calloc/free is hopefully acceptable.
Also ethdev xstats already doing that within
rte_eth_xstats_get_id_by_name().
For 2) and 4) changed the code to use fixed size array and call
appropriate devops function several times, if needed.

Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/ethdev/rte_ethdev.c | 183 +++++++++++++++++++++++++---------------
 1 file changed, 113 insertions(+), 70 deletions(-)

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 6413c54e3b..09cc4764c3 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -36,6 +36,8 @@
 #include "ethdev_trace.h"
 #include "sff_telemetry.h"
 
+#define ETH_XSTATS_ITER_NUM	0x100
+
 struct rte_eth_dev rte_eth_devices[RTE_MAX_ETHPORTS];
 
 /* public fast-path API */
@@ -3308,7 +3310,8 @@ int
 rte_eth_xstats_get_id_by_name(uint16_t port_id, const char *xstat_name,
 		uint64_t *id)
 {
-	int cnt_xstats, idx_xstat;
+	int cnt_xstats, idx_xstat, rc;
+	struct rte_eth_xstat_name *xstats_names;
 
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 
@@ -3334,26 +3337,33 @@ rte_eth_xstats_get_id_by_name(uint16_t port_id, const char *xstat_name,
 	}
 
 	/* Get id-name lookup table */
-	struct rte_eth_xstat_name xstats_names[cnt_xstats];
+	xstats_names = calloc(cnt_xstats, sizeof(xstats_names[0]));
+	if (xstats_names == NULL) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Can't allocate memory");
+		return -ENOMEM;
+	}
 
 	if (cnt_xstats != rte_eth_xstats_get_names_by_id(
 			port_id, xstats_names, cnt_xstats, NULL)) {
 		RTE_ETHDEV_LOG_LINE(ERR, "Cannot get xstats lookup");
+		free(xstats_names);
 		return -1;
 	}
 
+	rc = -EINVAL;
 	for (idx_xstat = 0; idx_xstat < cnt_xstats; idx_xstat++) {
 		if (!strcmp(xstats_names[idx_xstat].name, xstat_name)) {
 			*id = idx_xstat;
 
 			rte_eth_trace_xstats_get_id_by_name(port_id,
 							    xstat_name, *id);
-
-			return 0;
+			rc = 0;
+			break;
 		};
 	}
 
-	return -EINVAL;
+	free(xstats_names);
+	return rc;
 }
 
 /* retrieve basic stats names */
@@ -3399,6 +3409,38 @@ eth_basic_stats_get_names(struct rte_eth_dev *dev,
 	return cnt_used_entries;
 }
 
+static int
+eth_xstats_get_by_name_by_id(struct rte_eth_dev *dev, const uint64_t *ids,
+	struct rte_eth_xstat_name *xstats_names, uint32_t size,
+	uint32_t basic_count)
+{
+	int32_t rc;
+	uint32_t i, k, m, n;
+	uint64_t ids_copy[ETH_XSTATS_ITER_NUM];
+
+	m = 0;
+	for (n = 0; n != size; n += k) {
+
+		k = RTE_MIN(size - n, RTE_DIM(ids_copy));
+
+		/*
+		 * Convert ids to xstats ids that PMD knows.
+		 * ids known by user are basic + extended stats.
+		 */
+		for (i = 0; i < k; i++)
+			ids_copy[i] = ids[n + i] - basic_count;
+
+		rc = (*dev->dev_ops->xstats_get_names_by_id)(dev, ids_copy,
+					xstats_names + m, k);
+		if (rc < 0)
+			return rc;
+		m += rc;
+	}
+
+	return m;
+}
+
+
 /* retrieve ethdev extended statistics names */
 int
 rte_eth_xstats_get_names_by_id(uint16_t port_id,
@@ -3406,9 +3448,8 @@ rte_eth_xstats_get_names_by_id(uint16_t port_id,
 	uint64_t *ids)
 {
 	struct rte_eth_xstat_name *xstats_names_copy;
-	unsigned int no_basic_stat_requested = 1;
-	unsigned int no_ext_stat_requested = 1;
 	unsigned int expected_entries;
+	unsigned int nb_basic_stats;
 	unsigned int basic_count;
 	struct rte_eth_dev *dev;
 	unsigned int i;
@@ -3434,27 +3475,18 @@ rte_eth_xstats_get_names_by_id(uint16_t port_id,
 	if (ids && !xstats_names)
 		return -EINVAL;
 
-	if (ids && dev->dev_ops->xstats_get_names_by_id != NULL && size > 0) {
-		uint64_t ids_copy[size];
-
-		for (i = 0; i < size; i++) {
-			if (ids[i] < basic_count) {
-				no_basic_stat_requested = 0;
-				break;
-			}
-
-			/*
-			 * Convert ids to xstats ids that PMD knows.
-			 * ids known by user are basic + extended stats.
-			 */
-			ids_copy[i] = ids[i] - basic_count;
-		}
-
-		if (no_basic_stat_requested)
-			return (*dev->dev_ops->xstats_get_names_by_id)(dev,
-					ids_copy, xstats_names, size);
+	nb_basic_stats = 0;
+	if (ids != NULL) {
+		for (i = 0; i < size; i++)
+			nb_basic_stats += (ids[i] < basic_count);
 	}
 
+	/* no basic stats requested, devops function provided */
+	if (nb_basic_stats == 0 && ids != NULL && size != 0 &&
+			dev->dev_ops->xstats_get_names_by_id != NULL)
+		return eth_xstats_get_by_name_by_id(dev, ids, xstats_names,
+				size, basic_count);
+
 	/* Retrieve all stats */
 	if (!ids) {
 		int num_stats = rte_eth_xstats_get_names(port_id, xstats_names,
@@ -3473,17 +3505,8 @@ rte_eth_xstats_get_names_by_id(uint16_t port_id,
 		return -ENOMEM;
 	}
 
-	if (ids) {
-		for (i = 0; i < size; i++) {
-			if (ids[i] >= basic_count) {
-				no_ext_stat_requested = 0;
-				break;
-			}
-		}
-	}
-
 	/* Fill xstats_names_copy structure */
-	if (ids && no_ext_stat_requested) {
+	if (ids && nb_basic_stats == size) {
 		eth_basic_stats_get_names(dev, xstats_names_copy);
 	} else {
 		ret = rte_eth_xstats_get_names(port_id, xstats_names_copy,
@@ -3607,17 +3630,47 @@ eth_basic_stats_get(uint16_t port_id, struct rte_eth_xstat *xstats)
 	return count;
 }
 
+static int
+eth_xtats_get_by_id(struct rte_eth_dev *dev, const uint64_t *ids,
+	uint64_t *values, uint32_t size, uint32_t basic_count)
+{
+	int32_t rc;
+	uint32_t i, k, m, n;
+	uint64_t ids_copy[ETH_XSTATS_ITER_NUM];
+
+	m = 0;
+	for (n = 0; n != size; n += k) {
+
+		k = RTE_MIN(size - n, RTE_DIM(ids_copy));
+
+		/*
+		 * Convert ids to xstats ids that PMD knows.
+		 * ids known by user are basic + extended stats.
+		 */
+		for (i = 0; i < k; i++)
+			ids_copy[i] = ids[n + i] - basic_count;
+
+		rc = (*dev->dev_ops->xstats_get_by_id)(dev, ids_copy,
+					values + m, k);
+		if (rc < 0)
+			return rc;
+		m += rc;
+	}
+
+	return m;
+}
+
 /* retrieve ethdev extended statistics */
 int
 rte_eth_xstats_get_by_id(uint16_t port_id, const uint64_t *ids,
 			 uint64_t *values, unsigned int size)
 {
-	unsigned int no_basic_stat_requested = 1;
-	unsigned int no_ext_stat_requested = 1;
+	unsigned int nb_basic_stats;
 	unsigned int num_xstats_filled;
 	unsigned int basic_count;
 	uint16_t expected_entries;
 	struct rte_eth_dev *dev;
+	struct rte_eth_xstat *xstats;
 	unsigned int i;
 	int ret;
 
@@ -3628,7 +3681,6 @@ rte_eth_xstats_get_by_id(uint16_t port_id, const uint64_t *ids,
 	if (ret < 0)
 		return ret;
 	expected_entries = (uint16_t)ret;
-	struct rte_eth_xstat xstats[expected_entries];
 	basic_count = eth_dev_get_xstats_basic_count(dev);
 
 	/* Return max number of stats if no ids given */
@@ -3642,51 +3694,41 @@ rte_eth_xstats_get_by_id(uint16_t port_id, const uint64_t *ids,
 	if (ids && !values)
 		return -EINVAL;
 
-	if (ids && dev->dev_ops->xstats_get_by_id != NULL && size) {
-		unsigned int basic_count = eth_dev_get_xstats_basic_count(dev);
-		uint64_t ids_copy[size];
-
-		for (i = 0; i < size; i++) {
-			if (ids[i] < basic_count) {
-				no_basic_stat_requested = 0;
-				break;
-			}
-
-			/*
-			 * Convert ids to xstats ids that PMD knows.
-			 * ids known by user are basic + extended stats.
-			 */
-			ids_copy[i] = ids[i] - basic_count;
-		}
-
-		if (no_basic_stat_requested)
-			return (*dev->dev_ops->xstats_get_by_id)(dev, ids_copy,
-					values, size);
+	nb_basic_stats = 0;
+	if (ids != NULL) {
+		for (i = 0; i < size; i++)
+			nb_basic_stats += (ids[i] < basic_count);
 	}
 
-	if (ids) {
-		for (i = 0; i < size; i++) {
-			if (ids[i] >= basic_count) {
-				no_ext_stat_requested = 0;
-				break;
-			}
-		}
+	/* no basic stats requested, devops function provided */
+	if (nb_basic_stats == 0 && ids != NULL && size != 0 &&
+			dev->dev_ops->xstats_get_by_id != NULL)
+		return eth_xtats_get_by_id(dev, ids, values, size, basic_count);
+
+	xstats = calloc(expected_entries, sizeof(xstats[0]));
+	if (xstats == NULL) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Can't allocate memory");
+		return -ENOMEM;
 	}
 
 	/* Fill the xstats structure */
-	if (ids && no_ext_stat_requested)
+	if (ids && nb_basic_stats == size)
 		ret = eth_basic_stats_get(port_id, xstats);
 	else
 		ret = rte_eth_xstats_get(port_id, xstats, expected_entries);
 
-	if (ret < 0)
+	if (ret < 0) {
+		free(xstats);
 		return ret;
+	}
 	num_xstats_filled = (unsigned int)ret;
 
 	/* Return all stats */
 	if (!ids) {
 		for (i = 0; i < num_xstats_filled; i++)
 			values[i] = xstats[i].value;
+
+		free(xstats);
 		return expected_entries;
 	}
 
@@ -3694,14 +3736,15 @@ rte_eth_xstats_get_by_id(uint16_t port_id, const uint64_t *ids,
 	for (i = 0; i < size; i++) {
 		if (ids[i] >= expected_entries) {
 			RTE_ETHDEV_LOG_LINE(ERR, "Id value isn't valid");
-			return -1;
+			break;
 		}
 		values[i] = xstats[ids[i]].value;
 	}
 
 	rte_eth_trace_xstats_get_by_id(port_id, ids, values, size);
 
-	return size;
+	free(xstats);
+	return (i == size) ? (int32_t)size : -1;
 }
 
 int
-- 
2.47.2.vfs.0.1

