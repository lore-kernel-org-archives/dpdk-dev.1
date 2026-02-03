Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE519E8B381
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 23:04:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 120B74028C;
	Wed,  4 Feb 2026 00:04:22 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
 by mails.dpdk.org (Postfix) with ESMTP id 8396C40275
 for <dev@dpdk.org>; Wed,  4 Feb 2026 00:04:20 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FC92p62OhOpHaMirfDN1XX+8A64+NtKeasCMvu+lmR4kTEAv9Ad8SHHtvBES+yCdg1rjqP5sW8EcSTLjxOApY/V/OOJMCl92YDp8tdRVueNiSPBVrtx2UkP2FMcm4ja+WYz5/Ftn7zAEcrDBe+L2VQndoPMviJEaHfuvZipEublGO05LYBN2V3l3pyzydRx6OwwogBWeT+d4pDRVfm7nh/th7xGAVf4e5xA32rxmxN8Rl9OOG/EVhTjxXc+uO8bUJprt7tNHtxZap5vmbZnBxDKWzFbF/avMiAaiIMNbNIBkK5dZV1e1Be9/CBJI5AfhF45zEaoyRsIUWe3CtbYocg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGCWrhsRAYvWSBjTiSHJVVA2F+EUSYnOtsdtO0TMJuk=;
 b=l9BiOPQzSHZpEVGDMUc1MaXO5C3J0T33kDu9Xt7Kgsb+TlgHOS7ANFO27tr2EXfwpSxUDT/tZynRl6fseK4Y+XRF3oLQ+ewp4TuqEjQQSTH+m/uB7CTOx1ps0Wmv2NSLCgE70oQ06E1cDKBzfuYpwnX8ZlUNl8LmYdgAAaJG6gaLjh9cjXntMthSlLv6DEBC2QAZf8ZTfC17hwbK3giiU7IHKg+DvVhLyaQHOwcSZhFFecGGomQoRtwWJEKuuBtg0FIIWgfFtt17UCAUA92LtNwUPLAZSB8PBpj+N7PgpAFM9TNe7Jt8J+eF2fxEIczmHh6MdakbnPIOb8CLjW/aDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGCWrhsRAYvWSBjTiSHJVVA2F+EUSYnOtsdtO0TMJuk=;
 b=MY8Il6LxolLO36xnATw/p5B9YJTXhtjXqiBsJX071YBOuYPtgEt2jof1TgjnjaMxTEZ3RMtkuQKaqlqqkxiQCFsx9dwCYroWXzCnAjJIJWWXL0OaQ03PiJDd0fULkKFmfycMfXZFmj+uv6DVb8fxETwN4ahZOapovMpYItWst/fLKpQDRSKS5QFcWGQeVswyzBRQ0dBLVaPjSgjmP34Q5rQ2TKXe1PLghXTiLR9ZP6fReTPnkEBBnOJ3FxejvxUH2nvnKzyfNOb1XDHqorer9oe9Nr/EIS7kiqkCXmVdL4CAG1pZO6ejtzl5RMmlSkBoTNNDCEIFGftnCpsoINVL5A==
Received: from CH0PR03CA0106.namprd03.prod.outlook.com (2603:10b6:610:cd::21)
 by CY8PR12MB8410.namprd12.prod.outlook.com (2603:10b6:930:6d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 23:04:14 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::26) by CH0PR03CA0106.outlook.office365.com
 (2603:10b6:610:cd::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 23:03:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 23:04:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 15:03:59 -0800
Received: from aerial-hp-5g-02.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 3 Feb 2026 15:03:59 -0800
From: Cliff Burdick <cburdick@nvidia.com>
To: <dev@dpdk.org>
CC: <anatoly.burakov@intel.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v3 1/2] eal: support dmabuf
Date: Tue, 3 Feb 2026 23:02:39 +0000
Message-ID: <20260203230338.1066297-2-cburdick@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203230338.1066297-1-cburdick@nvidia.com>
References: <20260203222836.2862414-1-cburdick@nvidia.com>
 <20260203230338.1066297-1-cburdick@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|CY8PR12MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c6382e6-9fcd-4da6-1a74-08de63788c78
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RWJoppgU4lVWGDixt0ka/5zoHtRtTEDAaKbcs3cjgjEm0FM4pwrMu/JPmdRW?=
 =?us-ascii?Q?16N3DW0ATs06QQLLamja8KaRqy9kEJqRFLGbWsfqUpm2Sq5OoX8E/KqXmMAG?=
 =?us-ascii?Q?9U7JwF1OcE9JUaMadjb9nDs6U5QKEJBx81alCijp/BtdJww+1PJ3aydlEUZQ?=
 =?us-ascii?Q?3FsJwu73z+UMjlPSXktVEbHMo4+Xxf1S76ajHeP3TIHs+vAJlDsK/GGZXQ64?=
 =?us-ascii?Q?+LdSBPZFmxXJtSgx3kGsaEiZyZEysZc7jol0bS16LPVGe4BKNEM/7yE3nbqv?=
 =?us-ascii?Q?cmicPL5KCFz3jfppYN4Ool/0Fqo2SH71s/xgtZ7qFwR7wcb6kGFhJL7tCPqF?=
 =?us-ascii?Q?A2YWNzS+oNa3BNDzjIr483Px5Fcvr5asinKmecrs73BeuW3BSw9DJPmXWYW4?=
 =?us-ascii?Q?yFXC+x6DhrTqduy8zjZfB/S+QW2LliqXPDo2YolG/RlHpRwnnnCKNJGAXKz5?=
 =?us-ascii?Q?ySma6pVi6REbWcvtgqF2e6ak7yLj1oRSdIY3eK6hWncnNMUWEUidFAsv70zY?=
 =?us-ascii?Q?BqudBZkXwF5dJcDqozwvc80JRyWuBzojkXFjJxbhcc0yj82IzE8QhHqc2Zd9?=
 =?us-ascii?Q?RffBXKK46KH3PLoC+eEsKnxUaDjyDBW+8MKRU6GRMSScHNzecETVHO9FWolb?=
 =?us-ascii?Q?YFE0zFa8BBTwN1g9gTJZIjYUjXdToO9urpQE6vf7b4ZAfWqoHSmvcyRrt402?=
 =?us-ascii?Q?ldMkUszNN1CKFPgTkLv0qG9bkqQ0wqlTbDVuNM8yRuMhppbZyc1fRHObQZxi?=
 =?us-ascii?Q?xwwiUhyGE8XpECCEWvhPEWs1SmUsIJC3N28eMMyWOLM8kv78YmKlMz3AhfLx?=
 =?us-ascii?Q?CWEZZKeyVLrJg3O2z/mBjyBw1T5A3YqtsgkFVBHJaXOvdGnnqOYLGCQwlg+k?=
 =?us-ascii?Q?1K7diJ1vHGiyD/kz6FyYRHOIEoAseGKdf/PxHx0ZbI1/F6t+HHzwHrmxaYkD?=
 =?us-ascii?Q?wLsIShcUaj7skNUi0N6b4pp82by2C+MIq5/NIDm1WNo/i6U8wLIY4MbXp/jL?=
 =?us-ascii?Q?gCE643SkOws6uHGhCGdaXJJtVwNcAibX8BSoIi3I/+jyJk+dKFqw8ssbyjmx?=
 =?us-ascii?Q?L1Cu8DElfrHVpVYm8R3U1OYX9hsAktseD0pQMV29tLWsOKy5lO9kZcsSmum0?=
 =?us-ascii?Q?/5iqHksFTl64TblZjOebaN/sjFLmJQWERzX9JfA14I9UIROOjabcS+NFm0Fa?=
 =?us-ascii?Q?hc5nNf3E60JGXt2RSoe6J0i63C8MnMz+oT2veuuj8r3DIkKEeQ8hnfp55tj7?=
 =?us-ascii?Q?Idys1v0RYOb2jwWqOumV+Im3JXJLwyV/bh1RinLduACB5JhemkeYY+vfI99y?=
 =?us-ascii?Q?V7wJaIppgYXlf4ZtrX6xosDFbxYQomaWWR7pyzFzyXRy3PU74/HSN11jzytR?=
 =?us-ascii?Q?5mhvmIQKyFYl2b0fCNNheXPYNW6PoEEfOaVHie8pWrHN9ITQrpEf5MEdTBSn?=
 =?us-ascii?Q?1Gi4Xlc8gxAnllGAy5uTENTjExF5No/pN8Iw5TrHX0K+xoF6+NhbUmxztXnM?=
 =?us-ascii?Q?PaaaIHo+aNq5ve+st3Ej0wxwpyfCfcN26ksdhaf9MqKDSpFVQcbsb80+K2c8?=
 =?us-ascii?Q?09QoO45cVNCuL0+FLEg0GG06F/B5PLjq2RsONxZWfJ3ZThPMBl5z/EIl/fyo?=
 =?us-ascii?Q?svDZJaz7vf1Uv6+ULhn/y0srUP0U6LKugRm0103+Z3ggJL9v8oFcrwqg/tVo?=
 =?us-ascii?Q?jgOUEQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hqyaKh7Amb7KUY4tf31GSkqWWpU6jlVVZt20bnB0O6S3DDLmpPAb1G5GhpR8zZivjXR//a1UB27E+Aypfv/WsH67sRturgy36aB+5ko3GuGMm5IgLFpYOtj2xk/zjbAs9C+GFvPvyW7fIDtwDAt8dhxy9O/nRPNqFroSYDKS5CvUVW1+YBdlIIfRrIC90ezFybrLtCCM1kZyzxm9bJMdbzRRZE09d0/q0q6ZKnh/PbCTTWq5EmqLtczDYxsdGoECc43HaADi7DL2yQcHfCg/4Q1am/c+icOE6xRS+WI29hXYD8qHyAS+qLtrPu8O9kiSkxSz9ZmVBHw9pTk0l7s3ixEf2CV82zC40mHk2bOpi6OitslIakkA1DaJCLEuP39VoHqlihvwbkCKQLY1Xc2VaTtZGPWCc1w8suchzf2ImkwtVCqVdZb5Ouivk9fnGqMh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 23:04:13.5452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6382e6-9fcd-4da6-1a74-08de63788c78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8410
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

dmabuf is a modern Linux kernel feature to allow DMA transfers between
two drivers. Common examples of usage are streaming video devices and
NIC to GPU transfers. Prior to dmabuf users had to load proprietary
drivers to expose the DMA mappings. With dmabuf the proprietary drivers
are no longer required.

A new api function rte_extmem_register_dmabuf is introduced to create
the mapping from a dmabuf file descriptor. dmabuf uses a file descriptor
and an offset that has been pre-opened with the kernel. The kernel uses
the file descriptor to map to a VA pointer. To avoid ABI changes, a
static struct is used inside of eal_common_memory.c, and lookups are
done on this struct rather than from the rte_memseg_list.

Ideally we would like to add both the dmabuf file descriptor and offset
to rte_memseg_list, but it's not clear if we can reuse existing fields
when using the dmabuf API.

We could rename the external flag to a more generic "properties" flag
where "external" is the lowest bit, then we can use the second bit to
indicate the presence of dmabuf. In the presence of the flag for
dmabuf we could reuse the base_va address field for the dmabuf offset,
and the socket_id for the file descriptor.

Signed-off-by: Cliff Burdick <cburdick@nvidia.com>
---
 .mailmap                               |   1 +
 doc/guides/rel_notes/release_26_03.rst |   6 +
 lib/eal/common/eal_common_memory.c     | 165 ++++++++++++++++++++++++-
 lib/eal/common/eal_memalloc.h          |  21 ++++
 lib/eal/common/malloc_heap.c           |  27 ++++
 lib/eal/common/malloc_heap.h           |   5 +
 lib/eal/include/rte_memory.h           | 145 ++++++++++++++++++++++
 7 files changed, 364 insertions(+), 6 deletions(-)

diff --git a/.mailmap b/.mailmap
index 2f089326ff..4c2b2f921d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -291,6 +291,7 @@ Cian Ferriter <cian.ferriter@intel.com>
 Ciara Loftus <ciara.loftus@intel.com>
 Ciara Power <ciara.power@intel.com>
 Claire Murphy <claire.k.murphy@intel.com>
+Cliff Burdick <cburdick@nvidia.com>
 Clemens Famulla-Conrad <cfamullaconrad@suse.com>
 Cody Doucette <doucette@bu.edu>
 Congwen Zhang <zhang.congwen@zte.com.cn>
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 15dabee7a1..56457d0382 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -55,6 +55,12 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added dma-buf-backed external memory support.**
+
+  Added EAL support for registering dma-buf-backed external memory with
+  ``rte_extmem_register_dmabuf``, and enabled mlx5 common code to consume
+  dma-buf mappings for device access.
+
 
 Removed Items
 -------------
diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index c62edf5e55..7415479fff 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -45,6 +45,15 @@
 static void *next_baseaddr;
 static uint64_t system_page_sz;
 
+/* Internal storage for dma-buf info, indexed by memseg list index.
+ * This keeps dma-buf metadata out of the public rte_memseg_list structure
+ * to preserve ABI compatibility.
+ */
+static struct {
+	int fd;          /**< dma-buf fd, -1 if not dma-buf backed */
+	uint64_t offset; /**< offset within dma-buf */
+} dmabuf_info[RTE_MAX_MEMSEG_LISTS];
+
 #define MAX_MMAP_WITH_DEFINED_ADDR_TRIES 5
 void *
 eal_get_virtual_area(void *requested_addr, size_t *size,
@@ -232,6 +241,10 @@ eal_memseg_list_init(struct rte_memseg_list *msl, uint64_t page_sz,
 {
 	char name[RTE_FBARRAY_NAME_LEN];
 
+	/* Initialize dma-buf info to "not dma-buf backed" */
+	dmabuf_info[type_msl_idx].fd = -1;
+	dmabuf_info[type_msl_idx].offset = 0;
+
 	snprintf(name, sizeof(name), MEMSEG_LIST_FMT, page_sz >> 10, socket_id,
 		 type_msl_idx);
 
@@ -930,10 +943,113 @@ rte_memseg_get_fd_offset(const struct rte_memseg *ms, size_t *offset)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_extmem_register)
+/* Internal dma-buf info functions */
 int
-rte_extmem_register(void *va_addr, size_t len, rte_iova_t iova_addrs[],
-		unsigned int n_pages, size_t page_sz)
+eal_memseg_list_set_dmabuf_info(int list_idx, int fd, uint64_t offset)
+{
+	if (list_idx < 0 || list_idx >= RTE_MAX_MEMSEG_LISTS)
+		return -EINVAL;
+
+	dmabuf_info[list_idx].fd = fd;
+	dmabuf_info[list_idx].offset = offset;
+	return 0;
+}
+
+int
+eal_memseg_list_get_dmabuf_fd(int list_idx)
+{
+	if (list_idx < 0 || list_idx >= RTE_MAX_MEMSEG_LISTS)
+		return -EINVAL;
+
+	return dmabuf_info[list_idx].fd;
+}
+
+int
+eal_memseg_list_get_dmabuf_offset(int list_idx, uint64_t *offset)
+{
+	if (list_idx < 0 || list_idx >= RTE_MAX_MEMSEG_LISTS || offset == NULL)
+		return -EINVAL;
+
+	*offset = dmabuf_info[list_idx].offset;
+	return 0;
+}
+
+/* Public dma-buf info API functions */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_memseg_list_get_dmabuf_fd_unsafe)
+int
+rte_memseg_list_get_dmabuf_fd_unsafe(const struct rte_memseg_list *msl)
+{
+	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	int msl_idx;
+
+	if (msl == NULL) {
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	msl_idx = msl - mcfg->memsegs;
+	if (msl_idx < 0 || msl_idx >= RTE_MAX_MEMSEG_LISTS) {
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	return dmabuf_info[msl_idx].fd;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_memseg_list_get_dmabuf_fd)
+int
+rte_memseg_list_get_dmabuf_fd(const struct rte_memseg_list *msl)
+{
+	int ret;
+
+	rte_mcfg_mem_read_lock();
+	ret = rte_memseg_list_get_dmabuf_fd_unsafe(msl);
+	rte_mcfg_mem_read_unlock();
+
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_memseg_list_get_dmabuf_offset_unsafe)
+int
+rte_memseg_list_get_dmabuf_offset_unsafe(const struct rte_memseg_list *msl,
+		uint64_t *offset)
+{
+	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	int msl_idx;
+
+	if (msl == NULL || offset == NULL) {
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	msl_idx = msl - mcfg->memsegs;
+	if (msl_idx < 0 || msl_idx >= RTE_MAX_MEMSEG_LISTS) {
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	*offset = dmabuf_info[msl_idx].offset;
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_memseg_list_get_dmabuf_offset)
+int
+rte_memseg_list_get_dmabuf_offset(const struct rte_memseg_list *msl,
+		uint64_t *offset)
+{
+	int ret;
+
+	rte_mcfg_mem_read_lock();
+	ret = rte_memseg_list_get_dmabuf_offset_unsafe(msl, offset);
+	rte_mcfg_mem_read_unlock();
+
+	return ret;
+}
+
+static int
+extmem_register(void *va_addr, size_t len,
+	int dmabuf_fd, uint64_t dmabuf_offset,
+	rte_iova_t iova_addrs[], unsigned int n_pages, size_t page_sz)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 	unsigned int socket_id, n;
@@ -967,10 +1083,19 @@ rte_extmem_register(void *va_addr, size_t len, rte_iova_t iova_addrs[],
 
 	/* we can create a new memseg */
 	n = len / page_sz;
-	if (malloc_heap_create_external_seg(va_addr, iova_addrs, n,
+	if (dmabuf_fd < 0) {
+		if (malloc_heap_create_external_seg(va_addr, iova_addrs, n,
 			page_sz, "extmem", socket_id) == NULL) {
-		ret = -1;
-		goto unlock;
+			ret = -1;
+			goto unlock;
+		}
+	} else {
+		if (malloc_heap_create_external_seg_dmabuf(va_addr, iova_addrs, n,
+			page_sz, "extmem_dmabuf", socket_id,
+			dmabuf_fd, dmabuf_offset) == NULL) {
+			ret = -1;
+			goto unlock;
+		}
 	}
 
 	/* memseg list successfully created - increment next socket ID */
@@ -980,6 +1105,34 @@ rte_extmem_register(void *va_addr, size_t len, rte_iova_t iova_addrs[],
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_extmem_register)
+int
+rte_extmem_register(void *va_addr, size_t len, rte_iova_t iova_addrs[],
+		unsigned int n_pages, size_t page_sz)
+{
+	return rte_extmem_register_dmabuf(va_addr, len, -1, 0, iova_addrs, n_pages, page_sz);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_extmem_register_dmabuf)
+int
+rte_extmem_register_dmabuf(void *va_addr, size_t len,
+		int dmabuf_fd, uint64_t dmabuf_offset,
+		rte_iova_t iova_addrs[], unsigned int n_pages, size_t page_sz)
+{
+	if (dmabuf_fd < 0) {
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	return extmem_register(va_addr,
+		len,
+		dmabuf_fd,
+		dmabuf_offset,
+		iova_addrs,
+		n_pages,
+		page_sz);
+}
+
 RTE_EXPORT_SYMBOL(rte_extmem_unregister)
 int
 rte_extmem_unregister(void *va_addr, size_t len)
diff --git a/lib/eal/common/eal_memalloc.h b/lib/eal/common/eal_memalloc.h
index 0c267066d9..e7e807ddcb 100644
--- a/lib/eal/common/eal_memalloc.h
+++ b/lib/eal/common/eal_memalloc.h
@@ -90,6 +90,27 @@ eal_memalloc_set_seg_list_fd(int list_idx, int fd);
 int
 eal_memalloc_get_seg_fd_offset(int list_idx, int seg_idx, size_t *offset);
 
+/*
+ * Set dma-buf info for a memseg list.
+ * Returns 0 on success, -errno on failure.
+ */
+int
+eal_memseg_list_set_dmabuf_info(int list_idx, int fd, uint64_t offset);
+
+/*
+ * Get dma-buf fd for a memseg list.
+ * Returns fd (>= 0) on success, -1 if not dma-buf backed, -errno on error.
+ */
+int
+eal_memseg_list_get_dmabuf_fd(int list_idx);
+
+/*
+ * Get dma-buf offset for a memseg list.
+ * Returns 0 on success, -errno on failure.
+ */
+int
+eal_memseg_list_get_dmabuf_offset(int list_idx, uint64_t *offset);
+
 int
 eal_memalloc_init(void)
 	__rte_requires_shared_capability(rte_mcfg_mem_get_lock());
diff --git a/lib/eal/common/malloc_heap.c b/lib/eal/common/malloc_heap.c
index 39240c261c..bf986fe654 100644
--- a/lib/eal/common/malloc_heap.c
+++ b/lib/eal/common/malloc_heap.c
@@ -1232,6 +1232,33 @@ malloc_heap_create_external_seg(void *va_addr, rte_iova_t iova_addrs[],
 	msl->version = 0;
 	msl->external = 1;
 
+	/* initialize dma-buf info to "not dma-buf backed" */
+	eal_memseg_list_set_dmabuf_info(i, -1, 0);
+
+	return msl;
+}
+
+struct rte_memseg_list *
+malloc_heap_create_external_seg_dmabuf(void *va_addr, rte_iova_t iova_addrs[],
+		unsigned int n_pages, size_t page_sz, const char *seg_name,
+		unsigned int socket_id, int dmabuf_fd, uint64_t dmabuf_offset)
+{
+	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_memseg_list *msl;
+	int msl_idx;
+
+	/* Create the base external segment */
+	msl = malloc_heap_create_external_seg(va_addr, iova_addrs, n_pages,
+			page_sz, seg_name, socket_id);
+	if (msl == NULL)
+		return NULL;
+
+	/* Get memseg list index */
+	msl_idx = msl - mcfg->memsegs;
+
+	/* Set dma-buf info in the internal side-table */
+	eal_memseg_list_set_dmabuf_info(msl_idx, dmabuf_fd, dmabuf_offset);
+
 	return msl;
 }
 
diff --git a/lib/eal/common/malloc_heap.h b/lib/eal/common/malloc_heap.h
index dfc56d4ae3..87525d1a68 100644
--- a/lib/eal/common/malloc_heap.h
+++ b/lib/eal/common/malloc_heap.h
@@ -51,6 +51,11 @@ malloc_heap_create_external_seg(void *va_addr, rte_iova_t iova_addrs[],
 		unsigned int n_pages, size_t page_sz, const char *seg_name,
 		unsigned int socket_id);
 
+struct rte_memseg_list *
+malloc_heap_create_external_seg_dmabuf(void *va_addr, rte_iova_t iova_addrs[],
+		unsigned int n_pages, size_t page_sz, const char *seg_name,
+		unsigned int socket_id, int dmabuf_fd, uint64_t dmabuf_offset);
+
 struct rte_memseg_list *
 malloc_heap_find_external_seg(void *va_addr, size_t len);
 
diff --git a/lib/eal/include/rte_memory.h b/lib/eal/include/rte_memory.h
index b6e97ad695..fffeb8fcf5 100644
--- a/lib/eal/include/rte_memory.h
+++ b/lib/eal/include/rte_memory.h
@@ -405,6 +405,98 @@ int
 rte_memseg_get_fd_offset_thread_unsafe(const struct rte_memseg *ms,
 		size_t *offset);
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Get dma-buf file descriptor associated with a memseg list.
+ *
+ * @note This function read-locks the memory hotplug subsystem, and thus cannot
+ *       be used within memory-related callback functions.
+ *
+ * @param msl
+ *   A pointer to memseg list for which to get dma-buf fd.
+ *
+ * @return
+ *   Valid dma-buf file descriptor (>= 0) in case of success.
+ *   -1 if not dma-buf backed or in case of error, with ``rte_errno`` set to:
+ *     - EINVAL  - ``msl`` pointer was NULL or did not point to a valid memseg list
+ */
+__rte_experimental
+int
+rte_memseg_list_get_dmabuf_fd(const struct rte_memseg_list *msl);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Get dma-buf file descriptor associated with a memseg list.
+ *
+ * @note This function does not perform any locking, and is only safe to call
+ *       from within memory-related callback functions.
+ *
+ * @param msl
+ *   A pointer to memseg list for which to get dma-buf fd.
+ *
+ * @return
+ *   Valid dma-buf file descriptor (>= 0) in case of success.
+ *   -1 if not dma-buf backed or in case of error, with ``rte_errno`` set to:
+ *     - EINVAL  - ``msl`` pointer was NULL or did not point to a valid memseg list
+ */
+__rte_experimental
+int
+rte_memseg_list_get_dmabuf_fd_unsafe(const struct rte_memseg_list *msl);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Get dma-buf offset associated with a memseg list.
+ *
+ * @note This function read-locks the memory hotplug subsystem, and thus cannot
+ *       be used within memory-related callback functions.
+ *
+ * @param msl
+ *   A pointer to memseg list for which to get dma-buf offset.
+ * @param offset
+ *   A pointer to offset value where the result will be stored.
+ *
+ * @return
+ *   0 on success.
+ *   -1 in case of error, with ``rte_errno`` set to:
+ *     - EINVAL  - ``msl`` pointer was NULL or did not point to a valid memseg list
+ *     - EINVAL  - ``offset`` pointer was NULL
+ */
+__rte_experimental
+int
+rte_memseg_list_get_dmabuf_offset(const struct rte_memseg_list *msl,
+		uint64_t *offset);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Get dma-buf offset associated with a memseg list.
+ *
+ * @note This function does not perform any locking, and is only safe to call
+ *       from within memory-related callback functions.
+ *
+ * @param msl
+ *   A pointer to memseg list for which to get dma-buf offset.
+ * @param offset
+ *   A pointer to offset value where the result will be stored.
+ *
+ * @return
+ *   0 on success.
+ *   -1 in case of error, with ``rte_errno`` set to:
+ *     - EINVAL  - ``msl`` pointer was NULL or did not point to a valid memseg list
+ *     - EINVAL  - ``offset`` pointer was NULL
+ */
+__rte_experimental
+int
+rte_memseg_list_get_dmabuf_offset_unsafe(const struct rte_memseg_list *msl,
+		uint64_t *offset);
+
 /**
  * Register external memory chunk with DPDK.
  *
@@ -443,6 +535,59 @@ int
 rte_extmem_register(void *va_addr, size_t len, rte_iova_t iova_addrs[],
 		unsigned int n_pages, size_t page_sz);
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Register external memory chunk backed by a dma-buf file descriptor and offset.
+ *
+ * This is similar to rte_extmem_register() but additionally stores dma-buf
+ * file descriptor information, allowing drivers to use dma-buf based
+ * memory registration (e.g., ibv_reg_dmabuf_mr for RDMA devices).
+ *
+ * @note Using this API is mutually exclusive with ``rte_malloc`` family of
+ *   API's.
+ *
+ * @note This API will not perform any DMA mapping. It is expected that user
+ *   will do that themselves via rte_dev_dma_map().
+ *
+ * @note Before accessing this memory in other processes, it needs to be
+ *   attached in each of those processes by calling ``rte_extmem_attach`` in
+ *   each other process.
+ *
+ * @param va_addr
+ *   Start of virtual area to register (mmap'd address of the dma-buf).
+ *   Must be aligned by ``page_sz``.
+ * @param len
+ *   Length of virtual area to register. Must be aligned by ``page_sz``.
+ *   This is independent of dma-buf offset.
+ * @param dmabuf_fd
+ *   File descriptor of the dma-buf.
+ * @param dmabuf_offset
+ *   Offset within the dma-buf where the registered region starts.
+ * @param iova_addrs
+ *   Array of page IOVA addresses corresponding to each page in this memory
+ *   area. Can be NULL, in which case page IOVA addresses will be set to
+ *   RTE_BAD_IOVA.
+ * @param n_pages
+ *   Number of elements in the iova_addrs array. Ignored if ``iova_addrs``
+ *   is NULL.
+ * @param page_sz
+ *   Page size of the underlying memory
+ *
+ * @return
+ *   - 0 on success
+ *   - -1 in case of error, with rte_errno set to one of the following:
+ *     EINVAL - one of the parameters was invalid
+ *     EEXIST - memory chunk is already registered
+ *     ENOSPC - no more space in internal config to store a new memory chunk
+ */
+__rte_experimental
+int
+rte_extmem_register_dmabuf(void *va_addr, size_t len,
+		int dmabuf_fd, uint64_t dmabuf_offset,
+		rte_iova_t iova_addrs[], unsigned int n_pages, size_t page_sz);
+
 /**
  * Unregister external memory chunk with DPDK.
  *
-- 
2.52.0

