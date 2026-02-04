Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EE3E9D402
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 15:53:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C69140698;
	Wed,  4 Feb 2026 16:52:56 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010047.outbound.protection.outlook.com [52.101.56.47])
 by mails.dpdk.org (Postfix) with ESMTP id 04E6B406BB
 for <dev@dpdk.org>; Wed,  4 Feb 2026 16:52:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpSl8UV7qQir7stGuXV2POoynnY+qQvu7Md9JL0Ajw9GeOptraXwS+bJDD3PmrnW7yr29UA8jtWsAfMw4kFH0VK2sx++5GbcVS/GxWgZhK+kjIWVMFIX75fyF25LtY1+b2kgZ0bPuo5r58x8ShGgnNc/wsKQZB2VKE7e2TqTIqWslHQNKuKRQixPGyPGIl7rKCj1iCQUuNSNv0S0fRr6NhJKb3OempFud8eZ82TClztkjHamgim27xR/UGnSeG2JFW0oL5axpqIE7whDPGlyKT50I2zt+KQ065RgacekGwACA370YTsonO071Uc/IwKGqlqy/jOQAEtCMd9BzON/IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ObQpnsOkhYY5E+1N97zvooLS1XrerU9uwM0r5/VSnA=;
 b=huNEwJECGHfdxekku/FzAI514Rik8ZikcOXMPjE7nxn3UGFl+3+JLL+QUjHnnWLcFSH/Rabdy08b0fKWmzLa6Izes+x9D77jOhHCxz8NnaowLPHby4VuyAB3qobjY4tyqZvEAbRhB4rUKDB2MPO5mTL02Y3fSZ3p5lEVojzTzsBX8UlylT0iI+0caI0PHnwzWOh66bk3EOX7e7cPlYJ//soJIkXiChamf4zzNCXlu1TGpdh9uHbpbAo6EQDA/iMsc8lOqUDVswA3NtGoMK6RygDGvNC5plrlISCVAlxQz+LkRIE+SVlEkEaUr5gkL7srzsPbS5uAHU+dPDIXhjGgFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ObQpnsOkhYY5E+1N97zvooLS1XrerU9uwM0r5/VSnA=;
 b=jQ62LA+aU4WLWkmHYIzGjhDBeaZ4LjtG0PK5lh7F8w0UUnmkzr4j3+dQlHJ7ibjP2O2JIKfpbuPQ2GqRcYg0TAQH+0NaElE4KhnG5PbcVB5wmxBcBqXc3cimsEE+cLwD5dKCwMQyzv/EU/WhUqoTWRhqh4uFDdkCZO1CYmT5HRAUCwv+03fjPerJDdMVum/NfBGNZ1fbroo5DoOgzVTamB0uzANYJR+i4xHfm6NBuLYy4MsDCrEQrJtyyD07Ot3Qjzv2J7NtSGyYY4CBy2XQVaR7LmzOl7/gprJDmhd8SLHIfY+ry0LlLcyEn77aHepdDPJxMnaIu8Xokyk3ojhh0w==
Received: from BN9PR03CA0331.namprd03.prod.outlook.com (2603:10b6:408:f6::6)
 by DS4PR12MB999102.namprd12.prod.outlook.com (2603:10b6:8:2fc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 15:52:47 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::6) by BN9PR03CA0331.outlook.office365.com
 (2603:10b6:408:f6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 15:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 15:52:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 07:52:24 -0800
Received: from aerial-hp-5g-02.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 4 Feb 2026 07:52:24 -0800
From: Cliff Burdick <cburdick@nvidia.com>
To: <dev@dpdk.org>
CC: <anatoly.burakov@intel.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v4 1/2] eal: support dmabuf
Date: Wed, 4 Feb 2026 15:50:08 +0000
Message-ID: <20260204155206.2345189-2-cburdick@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204155206.2345189-1-cburdick@nvidia.com>
References: <20260203230338.1066297-1-cburdick@nvidia.com>
 <20260204155206.2345189-1-cburdick@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|DS4PR12MB999102:EE_
X-MS-Office365-Filtering-Correlation-Id: 1060f801-5d3b-4c52-42ca-08de64057169
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8Qxc2taDhF6MOQCZnP2LaiKL+ALdx5aBzeYMdj8umalnzcZblWjNnFgfjRlR?=
 =?us-ascii?Q?Yg6KmjAlbdV/Xog77s432DuPwRZb6MPiVvBdgkH3jzRyujuUK6QhJgA//Ex1?=
 =?us-ascii?Q?8ZJizM5Asod8xPKNF7EflkQTJq/Az9h2VQ3t0DkkKRcUHli86p1yYoNocVoz?=
 =?us-ascii?Q?aBGAN7hl+9f7HJeDG3c9eKpiXulJ1d6uL8w4MudI+pd7h4+kcPO33JZ+N56w?=
 =?us-ascii?Q?d5w/M/odASYOuH3206WaLjy/a+DApYSl14xu9+HFzX6qzY53yJ6YYZpMhgMf?=
 =?us-ascii?Q?hTL6zO0FL7eX2l1IYla0ggMSsUtpDJCsjhEEl2rEzCQ76qgseoeH8Mqek91P?=
 =?us-ascii?Q?ltpgBZWgJoInylFpcEoLnc7UqpEczmT/bMahfbHYJZKeTAllFJUicWN7ugqo?=
 =?us-ascii?Q?KniTU01O9zpxRKG+VVu9ZUVj8k1r3FvA+5zLlOWKV/u4sj267FVPQuwSraWC?=
 =?us-ascii?Q?JCYgz0Xo7lyqiIQ4M8Kx5zvqUQ4q3/cjDgFlyd1QkI428Rbpu3H9KrX1iAhg?=
 =?us-ascii?Q?qWl4+bUouEUxfHn+EGP3jUcF67ABoU2pi0I9g9j+r+ETv4+TYtbVyU176ZpE?=
 =?us-ascii?Q?7gS1ZDPPKzPHU2jifc8Fy22taQX7Huq4zFcQjXB7On3rXkf98ZrrIBONCx+6?=
 =?us-ascii?Q?EUeqHSubwbtoXMuj1yJs/hb9RH6k9MKZudQmg7jmL0vs/oSnTpnTWvd6w2im?=
 =?us-ascii?Q?g+EPafi4ga2mTqBiAvWCyoGD9FKprNoHvhD4SK81pPQ7h1cY2GLPZeRmJ1u7?=
 =?us-ascii?Q?BY1QVgNY8zRMXd0RWUFM536eQqkpWNMYfqmQMxyxdxjFUieaxy3TUfaBBZcZ?=
 =?us-ascii?Q?/c5Z/advs3hH0fnnF/CohUhpmHTfB7KvgB1blGrNh6fBxSLNosf7nM6/jy+V?=
 =?us-ascii?Q?iBhyGPVU5StC9zzjekWUnO3dmyARtw22cIjM3hzGirIygkKTlxbKzICZgOwP?=
 =?us-ascii?Q?YpzAw/BIT2ZpBOZNPEASH/fpGmGKeyseqJOf4HZgl69M9SzzZ/F0jaH07OV0?=
 =?us-ascii?Q?CsTmPYIdSX7AqEF5cY/NlxM3IQ4lgE+slUOgbXlFxEgMkqEXjKifV0fMa5U2?=
 =?us-ascii?Q?duq/e7VCPt8owNNfEz6pYMi/JrjV92iCiECix1CEJkWhMUDf0xFS9VOAVDFm?=
 =?us-ascii?Q?4oB9kaU6DQjJ+YU8CqETk8leKeCVMj70ZDIZKZBLK90AXb3bMFhUyIlNfOes?=
 =?us-ascii?Q?yELHomzgAFnmuVw7HTqBhQ/Suu+JH9vq39hT3RJWd9N6N3bnAoCnJJXNIGFu?=
 =?us-ascii?Q?z2VrnUhfavATaO+Uz+QOWWUOxalzuGvoNnIOQJnlRdAmmH5lIYtY2+g9l2YX?=
 =?us-ascii?Q?SSncVCOZlOjASzI3jeH+0rXP8laTnKx8/gONElMZDJ5OPig4lfLi16fI10bY?=
 =?us-ascii?Q?ZVlYYjt20mrhHuJ4V32RjaNhu6UKifLF8qtS/2mXi+y+EgbS3TkYLboJB5NY?=
 =?us-ascii?Q?/iueY+3m0Zr1I0QfPfLix4WKb6QLsYCj+vVB0XcLcZjFIqbNXJYoxmc1m5rb?=
 =?us-ascii?Q?bng4PdRe9pekyCQmIJikGE6ZdJwJw91DwtI53bfTC0LMBJCjJvC7wk3zpb+B?=
 =?us-ascii?Q?n0W6jR7YbC8M1Fw1UjMEi94wRSmSe6K5WTrcK2CxkAiI4zcOBmha4Z6oQU2g?=
 =?us-ascii?Q?miaERKjAF42L1J8nttJehJSNkwAZPNVkgh01yjbN6e3Zf4PVVqgT6hEEok1b?=
 =?us-ascii?Q?eLBvKw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /Yer/rFiwKVS+QDGMHspLs3PRKSJojt1IEV165//TJlo86Xt4HV1iQCGbvhT6DsFngqujKXZsJV7QGrSufjfECgaZyemPrfPDPjqHe1gF/lJSnUOdKWC825QYHkqub09tX2QpY+qejNM1j+pan6M/4BkYVejCxD7dGmrFAB/Y9K3tzZ3LzMctTWfvKC/JCsjgE0BUySqK5AjYcoiSicQunH05ioPRtKu0t0dAZmY9mljwZk07Lsat1Hwys0941W+6K75TeHICfTj/MDJY+ko/qIt7Tu4uBdLbr9SLfjqzsCr0hpXwjW4YLN+DoXCrPxX/ZdqXs2mlekBirzHRstd4+D8KuutM+v+UOCntfvHsuNGpx1Pv9i/G5RaOlZW6ZmvVw8TMA+Qq5lKwEFSUccRZ1IHNZAe4Ore6fKeYOjCTyIh4SpRBS9qwowK9JThL/j4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 15:52:47.1504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1060f801-5d3b-4c52-42ca-08de64057169
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999102
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
index c62edf5e55..4b8b1c8b59 100644
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
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_memseg_list_get_dmabuf_fd_unsafe, 26.03)
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
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_memseg_list_get_dmabuf_fd, 26.03)
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
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_memseg_list_get_dmabuf_offset_unsafe, 26.03)
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
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_memseg_list_get_dmabuf_offset, 26.03)
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
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_extmem_register_dmabuf, 26.03)
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

