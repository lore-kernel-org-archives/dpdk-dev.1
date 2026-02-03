Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B83BE8B36D
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 22:29:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60C664060C;
	Tue,  3 Feb 2026 23:29:30 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012054.outbound.protection.outlook.com [52.101.43.54])
 by mails.dpdk.org (Postfix) with ESMTP id D700F4060C
 for <dev@dpdk.org>; Tue,  3 Feb 2026 23:29:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1BOtahhyhunEqwx/ZnmWD0GzHYZFec00HhtUSsGadxhUrGSwM4HHrl6DR50hSSBhNX5WLv5VuYY+6p1Of0xylmnuOYbUJwyIj1sGaON5uLGXxoRgrF0YSBLhbZTaWmf/bcehj+xoKIcB+8mUyonO0pxa2qdEZ/L4b9x2t5rW5RtcF9teBD3+G2Aq4+TQagzwSvotk/9wtgSWKTJWco5PVYrIpl9+SizRUWY0mA6gtozZC64eTDZTtFPABzakaTVpeMRTf5LWztIf2x5v8Wia3go2rnPXrw68R81VLdndlJ+iFirKIuthmRO0aAAN+NsYS/XfsWhvtVCkeTIk59aMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfodDXENmQZ6V7OmZMz/W0TqQgzvPpJikhoBWbiG7Ic=;
 b=HNk95+i+Ec3PZb2eZ36ZnO3FvP1hNnZE1Sj2C+wx0T6udGDQ5kRN5vMTE7nrCjv6yE4N6eYEZ+UwHbAK4t0IKCqiXVxKr38kDXN72LXrtMUi/Gp96SKT2cezUaKM/3HQ/ppMovr5dc1IHXXH3xU+7Flpv8ykYMT8ESpJATSMTOxTwMg7wgD6dsRUuaZIiXXGihNFMOT1q01qBuvJbt9hp9xELs/q8gaa4wYiRUMuyZS5/+9m6lToD49BB/TQDQj0AtUxtqeF0CWd4B5I2HjDkNPqHhx7A6AfdwYQCSHz8+w8UueloMLNsmt7dlAZJkOvHSPjCLsPp1Z5pUyD+tdlZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfodDXENmQZ6V7OmZMz/W0TqQgzvPpJikhoBWbiG7Ic=;
 b=qwqE6GRz7FtRY5fnpjiaKiIn0X9AbI4dyDgnXaG8DElK03zYbkhUZULJWRll6Ei9QrGp2CmUxqLnGwPJdygj98dnp+UDiJSU9NndXDjQ+l6UX8Bc34rGC+gbUgsYnaSMLApoQ1g2tjRsIsxz8fam20WpffR9pucvXgjDk0dm3N0Xb14MSz4O7WKIP9uGjP8zzGtnDIoRQjoEFkRzBBDL9I6wXMxFjzNB46ZnPD3MrlMIrJP91Alvr0O30YsZA1opY2CF6AudbaZ4C3c19+5nHD+bgFFaZINPOv6x3SjROG6g7a2YiING2S/qizb8kfCINg5wH8mp1c8Oq9hHtLp55Q==
Received: from SN6PR01CA0008.prod.exchangelabs.com (2603:10b6:805:b6::21) by
 MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 22:29:22 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:805:b6:cafe::c1) by SN6PR01CA0008.outlook.office365.com
 (2603:10b6:805:b6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 22:29:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 22:29:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 14:29:00 -0800
Received: from aerial-hp-5g-02.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 3 Feb 2026 14:29:00 -0800
From: Cliff Burdick <cburdick@nvidia.com>
To: <dev@dpdk.org>
CC: <anatoly.burakov@intel.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v2 1/2] eal: support dmabuf
Date: Tue, 3 Feb 2026 22:26:40 +0000
Message-ID: <20260203222836.2862414-2-cburdick@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203222836.2862414-1-cburdick@nvidia.com>
References: <20260127174429.1504288-1-cburdick@nvidia.com>
 <20260203222836.2862414-1-cburdick@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|MN2PR12MB4094:EE_
X-MS-Office365-Filtering-Correlation-Id: 843c8d46-af84-4ccb-dcdf-08de6373adbf
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PViSK+2BJcbVjdrPkAG/14R/f77yMwalxtKDcyXg3EZGs0OrgbZFNsFt6JEe?=
 =?us-ascii?Q?Q2TNbXe/qMyqCoxMstcC47yXEjBzPUxOlbY/5UEj+TLwYwLeFC3WLLUjPVdT?=
 =?us-ascii?Q?OP1dm87ZApQS9avRMsOCPPmYQg5ZUr8LRxwiX58NazmCahqwtP4gPsRXk+sK?=
 =?us-ascii?Q?pjShHmIuMkfElyvTxAIyuU7Jk78ZmoImaW9/VFyWOiycPJHPgkphCZETGK0I?=
 =?us-ascii?Q?+CrNgft7ItZXDQCDc/D30zF+/Aezqme9mp/1BOTMdUSiAU3hs2u0jWX+O3yL?=
 =?us-ascii?Q?L9H0uuSGqjmijUM2Egcbr2XzUYVz6OeVjorPqM5ODu64LFMldbcOaol/cHgd?=
 =?us-ascii?Q?etVf33Mvvj5CH9QtWICTCIn1t5zBWxvSs3YpxTQI4hZ6SK5FhHbdWwVCCHrr?=
 =?us-ascii?Q?uTVc0YY7lAWvDzWeOnSf++XRMLWJfYMm7rORlVJfOMghLaC9wIuQ+V52m/PN?=
 =?us-ascii?Q?T0Npek/1qZKywIfd39TLPmt+vyV6P4cYAU3nIvB47tzHV+995fFVvRTNhwpA?=
 =?us-ascii?Q?o+KIQ6BrMq7f47tM18GCAcuB3FD4Y30qoErqTdhOrlxWzI65ipbi04QMVzhv?=
 =?us-ascii?Q?qdUAD2dQY5xu0DlIcyaPmIQdSxQ763vybzdaSDc15o84asBaq965NkcKoi/h?=
 =?us-ascii?Q?ZqY782KSksPK6p78tmNBaVonikvBkcyoNchmF8Kgjvx8TCH7cUbHbXieu0Xn?=
 =?us-ascii?Q?wq8o97rzdXfkk0r8Ff5gHkThNJNoxTzAuGxV122YXweKYndgwJ0DW/yb5tJE?=
 =?us-ascii?Q?fFXKAh1dqLItPsXz0bD2Ty19ti+QgYctO0b9Fhh6LPeTbdEeCB9I0wmWtPiF?=
 =?us-ascii?Q?S7ChQUW4JGxCA3neVUEkb09qmBCgHlxAV93E54FMzLCL9bAYMN4EbeI4nJF0?=
 =?us-ascii?Q?gFaElL7p1LFQiulwUz8LdsaKT82tdIa/+zO4Qy6HwZSfSxfU4uRTIIRD0NMi?=
 =?us-ascii?Q?w8SuCeqyoUzUA7+WB+ycNyFsf2igy+EAtc7J1itB2ZZ5GnH0Mf2GmPZti93p?=
 =?us-ascii?Q?Vxj6uTrLMacE4LT3o0TN3zj9t0aLK7bYG6anHB9Xxip+VPLsvk36YuVSUm9j?=
 =?us-ascii?Q?5iCP6bxT9eWvuvLu8pLie2GwcqCkbI5EmifvcIwva2PBxz1c21CqvjUthpk+?=
 =?us-ascii?Q?9FvXdZ9THvuStCTQEFKsjSpbUbmzWz+FZ4XbQS47cCuU6bnup9M0n/mFN6HI?=
 =?us-ascii?Q?YmEWHQt9azgPoEZFTSBXFpHBBduGl9vFAUsDjxOfaI4a0pjxT0NYb8CJXWMn?=
 =?us-ascii?Q?LiR9pimWYkkPgoyAqz39CiBEI9JDUh9R3GcLou26DYRSZGdsOyIvdgyyu5vb?=
 =?us-ascii?Q?ealKx9hgZ15m1N05x5WjUHsJ/iZ4LwnFzsdbv9tVjqVIbk593qCX1uq0haQT?=
 =?us-ascii?Q?tba0d5aaxVAoYUlbSi1TBCbotAtTlbedQqR9PfudzPPLPfWs3I24y9i6SkUv?=
 =?us-ascii?Q?oxjK9CdBPa8Q/UjoEOV1r35ixCYTrFH8MPAW1skfS9x26oSF+vX0c2r6pLfE?=
 =?us-ascii?Q?xDzV9HPiunbrQYulxTmE1lh2TIb0vhPTK5QKNSlTSQwk1gXvALL1ObvcZLBY?=
 =?us-ascii?Q?MjPoRJdq94yhXDrpt7fU6gHx379LZO9M1MUauDMMR39CGZfWZ814qapBZHHL?=
 =?us-ascii?Q?EqbkXtWKibHW7qW+BJshWMGS8sd+GSjhyio6GXJS1jDQHKJ1TcBzHt76U9m0?=
 =?us-ascii?Q?d9f+YA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tIJCR3FtzNJXNh0Me1/dJ0v38CYXCuXlrVvmAYc66y5277tYgqJK6j75i/Wr0/uBOG11lGsYb0cW/zV2MWp5eMC5YBUl3ttERE/XOTyExyMACVVF9gaUwSz8U9U4oBqEhvFq85HhyZMr5+pltSQn/EsSOt949WQzMh+mCGbAIqvElG79n7SQcj/DjhvL/JDMYt22Fnf7ggCwx6iQQi1M6IBTxPvW3m0qCKaBoG0WxSHOikv7RCf4PlczUptmor9fK5XzvNUYzLcO7nRpIGZqNkRG5UzD0i/NTRLGbEsNXVG3iF4zKI2BWQ8JOa6zWs4LZ1mCt1idcM+bbSLtlrkl0DeSQpgoY8Q/TDWcOD6Rww+Ti+sX4mzydDHqOvVmbw8l4THjUWAcJeomaKgz4NMYh8jcIGwG91oCgjDwuKETCwv2C42gaYJXch7SHLWxNgdS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 22:29:21.9147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 843c8d46-af84-4ccb-dcdf-08de6373adbf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094
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

We could rename the external flag to a more generic "properties" flag where
"external" is the lowest bit, then we can use the second bit to indicate the
presence of dmabuf. In the presence of the flag for dmabuf we could
reuse the base_va address field for the dmabuf offset, and the socket_id
for the file descriptor.

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
index c62edf5e55..34ebbdc202 100644
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
+RTE_EXPORT_SYMBOL(rte_memseg_list_get_dmabuf_fd_unsafe)
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
+RTE_EXPORT_SYMBOL(rte_memseg_list_get_dmabuf_fd)
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
+RTE_EXPORT_SYMBOL(rte_memseg_list_get_dmabuf_offset_unsafe)
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
+RTE_EXPORT_SYMBOL(rte_memseg_list_get_dmabuf_offset)
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
+RTE_EXPORT_SYMBOL(rte_extmem_register_dmabuf)
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
index b6e97ad695..4e92897dd9 100644
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
+ __rte_experimental
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

