Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E29CD37AC
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 May 2026 23:55:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 289E2402B6;
	Thu, 14 May 2026 01:55:51 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 04F634025E
 for <dev@dpdk.org>; Thu, 14 May 2026 01:55:49 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 5143320B7166; Wed, 13 May 2026 16:55:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5143320B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1778716546;
 bh=eFTjRStRlTuTjUSKBiLQbaHz/uynV1gYbAms7x9iQq4=;
 h=From:To:Cc:Subject:Date:From;
 b=Lg3EajcYgJtutoqHaL9YDBQnWwqa5GuSHQlk42Tvj0W4MTaeMVJcrSRmrn/eRHUN0
 lT3RGLzoInkB531hn1z0nwmaPuna9DGtLJjdbUfN+CzvwbooQaRrWLRVcuQGZqXhI9
 kUf/1ZRx3ocYvzTBdsFwTgU3Z462K+su66ZILZM4=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Cc: dev@dpdk.org, Gena Tertychnyi <genter@microsoft.com>,
 Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] Windows: fix core count on NUMA with more than 64 cores per
 node
Date: Wed, 13 May 2026 16:55:18 -0700
Message-ID: <20260513235518.408895-1-andremue@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
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

From: Gena Tertychnyi <genter@microsoft.com>

Fix specific to Windows NUMA machines with more than 64 cores per node
(e.g. 2 NUMAs with 128 cores each):

- NumaNode.GroupMasks[] array is used instead of NumaNode.GroupMask.
- RelationAll is used instead of RelationNumaNode when calling
GetLogicalProcessorInformationEx because RelationAll returns the full
multi-group NUMA affinity as RelationNumaNode returns only the NUMA
node's primary group.

Signed-off-by: Gena Tertychnyi <genter@microsoft.com>
Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/eal/windows/eal_lcore.c | 68 +++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 17 deletions(-)

diff --git a/lib/eal/windows/eal_lcore.c b/lib/eal/windows/eal_lcore.c
index a498044620..d2a2c2d091 100644
--- a/lib/eal/windows/eal_lcore.c
+++ b/lib/eal/windows/eal_lcore.c
@@ -17,13 +17,27 @@
 /** Number of logical processors (cores) in a processor group (32 or 64). */
 #define EAL_PROCESSOR_GROUP_SIZE (sizeof(KAFFINITY) * CHAR_BIT)
 
+/*
+ * NUMA_NODE_RELATIONSHIP layout differs:
+ *  - MSVC + modern SDK: GroupCount + GroupMasks[]
+ *  - MinGW-w64: only GroupMask (MinGW headers lag behind Windows SDK ABI changes)
+ */
+#ifdef RTE_TOOLCHAIN_GCC
+#define EAL_NUMA_GROUP_COUNT(numa) (RTE_SET_USED(numa), 1)
+#define EAL_NUMA_GROUP_MASKS(numa) (&((numa).GroupMask))
+#else
+#define EAL_NUMA_GROUP_COUNT(numa) ((numa).GroupCount)
+#define EAL_NUMA_GROUP_MASKS(numa) ((numa).GroupMasks)
+#endif
+
 struct lcore_map {
-	uint8_t socket_id;
-	uint8_t core_id;
+	unsigned int socket_id;
+	unsigned int core_id;
 };
 
 struct socket_map {
 	uint16_t node_id;
+	unsigned int lcore_count;
 };
 
 struct cpu_map {
@@ -112,11 +126,15 @@ static bool
 eal_create_lcore_map(const SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX *info)
 {
 	const unsigned int node_id = info->NumaNode.NodeNumber;
-	const GROUP_AFFINITY *cores = &info->NumaNode.GroupMask;
+	const GROUP_AFFINITY *group_masks = EAL_NUMA_GROUP_MASKS(info->NumaNode);
 	struct lcore_map *lcore;
 	unsigned int socket_id;
+	unsigned int group_count;
+	unsigned int group_no;
 	unsigned int i;
 
+	group_count = EAL_NUMA_GROUP_COUNT(info->NumaNode);
+
 	/*
 	 * NUMA node may be reported multiple times if it includes
 	 * cores from different processor groups, e. g. 80 cores
@@ -132,20 +150,33 @@ eal_create_lcore_map(const SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX *info)
 			return true;
 
 		cpu_map.sockets[socket_id].node_id = node_id;
+		cpu_map.sockets[socket_id].lcore_count = 0;
 		cpu_map.socket_count++;
 	}
 
-	for (i = 0; i < EAL_PROCESSOR_GROUP_SIZE; i++) {
-		if ((cores->Mask & ((KAFFINITY)1 << i)) == 0)
-			continue;
+	/* Old Windows versions report NUMA nodes with GroupCount == 0 */
+	if (group_count == 0) {
+		group_count = 1;
+		group_masks = &info->NumaNode.GroupMask;
+	}
 
-		if (cpu_map.lcore_count == RTE_DIM(cpu_map.lcores))
-			return true;
+	for (group_no = 0; group_no < group_count; group_no++) {
+		const GROUP_AFFINITY *cores = &group_masks[group_no];
+		for (i = 0; i < EAL_PROCESSOR_GROUP_SIZE; i++) {
+			if ((cores->Mask & ((KAFFINITY)1 << i)) == 0)
+				continue;
+
+			if (cpu_map.lcore_count == RTE_DIM(cpu_map.lcores))
+				return true;
 
-		lcore = &cpu_map.lcores[cpu_map.lcore_count];
-		lcore->socket_id = socket_id;
-		lcore->core_id = cores->Group * EAL_PROCESSOR_GROUP_SIZE + i;
-		cpu_map.lcore_count++;
+			lcore = &cpu_map.lcores[cpu_map.lcore_count];
+			lcore->socket_id = socket_id;
+
+			/* core_id within the socket */
+			lcore->core_id = cpu_map.sockets[socket_id].lcore_count;
+			cpu_map.sockets[socket_id].lcore_count++;
+			cpu_map.lcore_count++;
+		}
 	}
 	return false;
 }
@@ -160,8 +191,9 @@ eal_create_cpu_map(void)
 
 	infos = NULL;
 	infos_size = 0;
+	/* RelationAll is needed to get full multi-group NUMA affinity */
 	if (!GetLogicalProcessorInformationEx(
-			RelationNumaNode, NULL, &infos_size)) {
+			RelationAll, NULL, &infos_size)) {
 		DWORD error = GetLastError();
 		if (error != ERROR_INSUFFICIENT_BUFFER) {
 			log_early("Cannot get NUMA node info size, error %lu\n",
@@ -181,7 +213,7 @@ eal_create_cpu_map(void)
 	}
 
 	if (!GetLogicalProcessorInformationEx(
-			RelationNumaNode, infos, &infos_size)) {
+			RelationAll, infos, &infos_size)) {
 		log_early("Cannot get NUMA node information, error %lu\n",
 			GetLastError());
 		rte_errno = EINVAL;
@@ -191,9 +223,11 @@ eal_create_cpu_map(void)
 
 	info = infos;
 	while ((uint8_t *)info - (uint8_t *)infos < infos_size) {
-		if (eal_create_lcore_map(info)) {
-			full = true;
-			break;
+		if (info->Relationship == RelationNumaNode) {
+			if (eal_create_lcore_map(info)) {
+				full = true;
+				break;
+			}
 		}
 
 		info = (SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX *)(
-- 
2.53.0.vfs.0.7

