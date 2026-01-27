Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D65D2FEC0
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 17:45:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59B92410D0;
	Tue, 27 Jan 2026 18:45:26 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
 by mails.dpdk.org (Postfix) with ESMTP id 9EC3D410DF
 for <dev@dpdk.org>; Tue, 27 Jan 2026 18:45:24 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCBW0bKprIisUFvzptM4Rr5nT5mvBaaQjHOxZdObkwMlEaLclhmVMX/xXNr+PTA3IxBDkMSeel/IztQErk5rDjnO5GLYFqLEhnvjbGptM8yOyQTrjxwQz2UmC5mXeygbOsNwb0REHgTS1NkavWf5xk8K9pp8u++XrPqjoTCVQq/9uR7Q90JT6X1XthRaM4NotRQ51lL8WlRfsc6XrCEXLBLn2F1mzqiuiMGZ84OsuwjqLaHcjGFx7Ar6NKr1pCoD6THa9m68pkJcbLt5021zACFGaDapIb02EPEkCgASUgIPQhjjJFpU95lMGwEPHecmYwQqKKnhV1ZtgXGjYR+csQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGNZ1MmEMTZKeHhSEKFGbUqUO/mEBSnCWZOBp9jPIFs=;
 b=Gv9crkvfm7JKgORRO1S3OjtzN9YGr3pgl7RmgplNGH+ubKPyA6+XXEwWWGdE//VMiVkfVw4e3U/ILqbrggqh9miFXIgHtrHXFoDFJzwtddAmBgQsuZWKcM46CnILn45dsKeIWYicrKfEW/KUSPEyT8PC+hDaPDbWSIMNfVWW9wdavUVA1RWREnROszlCxDq7mt/LpopxIDaBMrtldSrp9lOUkZVIw4I7VP7DFIvyhiSH/HtbwSTfcSwzLrLb1oy2be8aTHB2Hx+2Sd+f48yl1L1ETEpiN+xi1OftpsV79reGhFNybffFKoyYbc8t2yj3JuA9Jb6GOzTQJfydbAsIAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGNZ1MmEMTZKeHhSEKFGbUqUO/mEBSnCWZOBp9jPIFs=;
 b=CA9mIZROJBq6g45mQd6q99261cxdBWUFswASmMfOe9Oit1qBpNFPN98NXcgV2bNRqHrkYgHvPItU0IWuFg1hZi+Fzr1n2ia6+zrMVyjawEBsnu17PzGe1IucW8enNxnnICd2H7DFtveO4F9H7B++mqJotCiYZKhmXUClUaVT/bisRyFinSshqJPQfmVM61vT5ixHZwDLuYpiGSXwSFT/RB4b9ZPzUSiZKzaafUNfmALnk/vl3PxIsPsu7wPvz5TOInyNjlOcNGqdSEuD5OhXNPC6Ql7eGw8aZVnWhiE9XBWzTxDRPDzNVBl+uCzDIl+z2rvDKjl3zzxcelJMc1hyLw==
Received: from DS7PR03CA0326.namprd03.prod.outlook.com (2603:10b6:8:2b::28) by
 SA1PR12MB6871.namprd12.prod.outlook.com (2603:10b6:806:25f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 17:45:14 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::c2) by DS7PR03CA0326.outlook.office365.com
 (2603:10b6:8:2b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 17:45:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 17:45:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 09:44:54 -0800
Received: from aerial-hp-5g-02.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 27 Jan 2026 09:44:53 -0800
From: Cliff Burdick <cburdick@nvidia.com>
To: <dev@dpdk.org>
CC: <anatoly.burakov@intel.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH 1/2] eal: support dmabuf
Date: Tue, 27 Jan 2026 17:44:08 +0000
Message-ID: <20260127174429.1504288-2-cburdick@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127174429.1504288-1-cburdick@nvidia.com>
References: <20260127174429.1504288-1-cburdick@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|SA1PR12MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 75796cd1-04b9-4c15-db5a-08de5dcbd329
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xca+rVZtuhPXJaxbhZt/pWan3mVPiAz33jSP4aOLzO96jtHbvJIzrwSfCHww?=
 =?us-ascii?Q?OjpxR+zPP7mWDrKJxvWPLcgzHzbsuSmdUbzSoq4ePvmjJ+H31ObDDdqQjaRY?=
 =?us-ascii?Q?p0Gwqcl+YYVxXtCyg0zVgi2T0DAlHYHG+4TAZjgMkoM0x4Thjkn3B+ZdbnM8?=
 =?us-ascii?Q?Q4pVqbws/bkCw+OgZVZcX2E+RwJnluRAljWfYUewqWbrW6BxbMxR6ysqYaMP?=
 =?us-ascii?Q?ozrqo77vj12+6Yj/ifJ0mLzzx92ZfdxhuswbypooRnXlMD6nhlom8jjZvTsr?=
 =?us-ascii?Q?cGLJ4VkerIPGkJBtjtwUQmZMWFC00aDAxLDcx5f0CqGO5NRmYYhJxR/4DL3w?=
 =?us-ascii?Q?1kLbpyn7OZ27byPfXarHyAR8Lyfr6RsYWJN3yEvw/RZGOVcdlNJIM2R5EdjJ?=
 =?us-ascii?Q?DcONG6jIPSnm+Vtd+nFQG5BJ/PHDx1xMsZeZYWcS7IE5Dmf+VDvKupd4Bu9M?=
 =?us-ascii?Q?UydC+Vye04+3gRE3uYTkF2rz7FoEfNeenbEbJxb72EZNWAgX+g4AX6kAEmmw?=
 =?us-ascii?Q?5IhJThiVnvmeLsGj+Ftm7yyrihoUn8xBED0Y9MgxM1u6DJy7aUDXhr3BxLUf?=
 =?us-ascii?Q?WRyapn+32DMgl2pihe6bJwGVgQAX9TTCa/XMiaNCQEJ9xRzizyjBqTdtCvOn?=
 =?us-ascii?Q?1t62rwe/kJpMI/yL6C81Kol8P9ePp1L8l3dqwgaaY1sanGsH+wa3EHW8tiAz?=
 =?us-ascii?Q?GTWonquHZq32lxmueA2Jsx7qkifMegM+sK9lLPBzDn8U2hQrtkPyuHMAEaHu?=
 =?us-ascii?Q?shxcBYPc7pHshK45QMPQ0KQ8ts+5cwhvKO05TD/twkGKuSmWssSgeRwxDnQV?=
 =?us-ascii?Q?v+jkjKWkCf/2fcJDZpLiKtwT7jamhESc28njUjojHCJLVt4WRDXzJrUOFuV3?=
 =?us-ascii?Q?29k9zdCLuDxokz613qiSXJV4ZZHcD3jrX890IsyQSI5LaReHDEmnpnxrlY4T?=
 =?us-ascii?Q?x0n064XoCws/je/BJDa/x6waDCyevm+kL2CG3Gv6H2SBEtetHaKxVghE/i7O?=
 =?us-ascii?Q?X5jHTfMPsiYbMU7x9pqPD5Rr6g12hjMAy2gusvJoJSAB4+W6ArvTcU7ZhC2b?=
 =?us-ascii?Q?GIIic0/vABbb+FwJFZhoszkETrpurcmaJfi9lnRhHBPbM2GG0oYxflFyiVgR?=
 =?us-ascii?Q?UDw23QYvrHji5cjEQnyP+kpLSKm5LlVqn63ouJVSlhD7IAm5Czo6c1W6kWh1?=
 =?us-ascii?Q?tUIj6mGX34tn/czCe7miExuJed0vOx8Hfmvvka733t4CPuv3wJm0Dlx+gVVl?=
 =?us-ascii?Q?gEzyVC6pr2zBT3kvGDcWSxf0qIzrdOqkPpfhbWKpSscUI3C/7LoFBVJud51X?=
 =?us-ascii?Q?WAQQf2VoA/jn+aiQZfpk3OnS1IUSGKvwRuJ7PguwX6dVXQj1+HqsXFYmNcWl?=
 =?us-ascii?Q?geXJF3Q9z5Mpp53/mYeV7e/ZNFQVq0jAicMxfOnEmyCn2FKxfEQiTBuVGELo?=
 =?us-ascii?Q?wnm4r8NcbWybZ4EQCGyUyhLpCFCZWZheu7fNxYyQZayMb+d6kBo2ASej9k1g?=
 =?us-ascii?Q?cySfKHCm0Vh9D/SBTp1C5UvRl9Z6SVVC0nv0qw/cHiiNHaaJHZ+74MPh74tH?=
 =?us-ascii?Q?rWBM6DYf8NbyneCiE4GCtdPcHys2grWANrIrFWA01AyE1zH/IP6s8062nyJV?=
 =?us-ascii?Q?oIUIB3J1f3c44CoIZRDWgFMviLhQkPNcGzmQnN5i2uCaY0iY3mqGmGXbbHZA?=
 =?us-ascii?Q?PdokNg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 17:45:13.4283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75796cd1-04b9-4c15-db5a-08de5dcbd329
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6871
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

Which option is preferred?

Signed-off-by: Cliff Burdick <cburdick@nvidia.com>
---
 .mailmap                           |   1 +
 lib/eal/common/eal_common_memory.c | 168 +++++++++++++++++++++++++++++
 lib/eal/common/eal_memalloc.h      |  21 ++++
 lib/eal/common/malloc_heap.c       |  27 +++++
 lib/eal/common/malloc_heap.h       |   5 +
 lib/eal/include/rte_memory.h       | 125 +++++++++++++++++++++
 6 files changed, 347 insertions(+)

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
diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index c62edf5e55..304ed18396 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -45,6 +45,18 @@
 static void *next_baseaddr;
 static uint64_t system_page_sz;
 
+/* Internal storage for dmabuf info, indexed by memseg list index.
+ * This keeps dmabuf metadata out of the public rte_memseg_list structure
+ * to preserve ABI compatibility.
+ */
+static struct {
+		int fd;          /**< dmabuf fd, -1 if not dmabuf backed */
+		uint64_t offset; /**< offset within dmabuf */
+	} dmabuf_info[RTE_MAX_MEMSEG_LISTS] = {
+	[0 ... RTE_MAX_MEMSEG_LISTS - 1] = { .fd = -1, .offset = 0 }
+};
+
+
 #define MAX_MMAP_WITH_DEFINED_ADDR_TRIES 5
 void *
 eal_get_virtual_area(void *requested_addr, size_t *size,
@@ -930,6 +942,109 @@ rte_memseg_get_fd_offset(const struct rte_memseg *ms, size_t *offset)
 	return ret;
 }
 
+/* Internal dmabuf info functions */
+int
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
+/* Public dmabuf info API functions */
+RTE_EXPORT_SYMBOL(rte_memseg_list_get_dmabuf_fd_thread_unsafe)
+int
+rte_memseg_list_get_dmabuf_fd_thread_unsafe(const struct rte_memseg_list *msl)
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
+	ret = rte_memseg_list_get_dmabuf_fd_thread_unsafe(msl);
+	rte_mcfg_mem_read_unlock();
+
+	return ret;
+}
+
+RTE_EXPORT_SYMBOL(rte_memseg_list_get_dmabuf_offset_thread_unsafe)
+int
+rte_memseg_list_get_dmabuf_offset_thread_unsafe(const struct rte_memseg_list *msl,
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
+	ret = rte_memseg_list_get_dmabuf_offset_thread_unsafe(msl, offset);
+	rte_mcfg_mem_read_unlock();
+
+	return ret;
+}
+
 RTE_EXPORT_SYMBOL(rte_extmem_register)
 int
 rte_extmem_register(void *va_addr, size_t len, rte_iova_t iova_addrs[],
@@ -980,6 +1095,59 @@ rte_extmem_register(void *va_addr, size_t len, rte_iova_t iova_addrs[],
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_extmem_register_dmabuf)
+int
+rte_extmem_register_dmabuf(void *va_addr, size_t len,
+		int dmabuf_fd, uint64_t dmabuf_offset,
+		rte_iova_t iova_addrs[], unsigned int n_pages, size_t page_sz)
+{
+	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	unsigned int socket_id, n;
+	int ret = 0;
+
+	if (va_addr == NULL || page_sz == 0 || len == 0 ||
+			!rte_is_power_of_2(page_sz) ||
+			RTE_ALIGN(len, page_sz) != len ||
+			((len / page_sz) != n_pages && iova_addrs != NULL) ||
+			!rte_is_aligned(va_addr, page_sz) ||
+			dmabuf_fd < 0) {
+		rte_errno = EINVAL;
+		return -1;
+	}
+	rte_mcfg_mem_write_lock();
+
+	/* make sure the segment doesn't already exist */
+	if (malloc_heap_find_external_seg(va_addr, len) != NULL) {
+		rte_errno = EEXIST;
+		ret = -1;
+		goto unlock;
+	}
+
+	/* get next available socket ID */
+	socket_id = mcfg->next_socket_id;
+	if (socket_id > INT32_MAX) {
+		EAL_LOG(ERR, "Cannot assign new socket ID's");
+		rte_errno = ENOSPC;
+		ret = -1;
+		goto unlock;
+	}
+
+	/* we can create a new memseg with dma-buf info */
+	n = len / page_sz;
+	if (malloc_heap_create_external_seg_dmabuf(va_addr, iova_addrs, n,
+			page_sz, "extmem_dmabuf", socket_id,
+			dmabuf_fd, dmabuf_offset) == NULL) {
+		ret = -1;
+		goto unlock;
+	}
+
+	/* memseg list successfully created - increment next socket ID */
+	mcfg->next_socket_id++;
+unlock:
+	rte_mcfg_mem_write_unlock();
+	return ret;
+}
+
 RTE_EXPORT_SYMBOL(rte_extmem_unregister)
 int
 rte_extmem_unregister(void *va_addr, size_t len)
diff --git a/lib/eal/common/eal_memalloc.h b/lib/eal/common/eal_memalloc.h
index 0c267066d9..bb2cfa0717 100644
--- a/lib/eal/common/eal_memalloc.h
+++ b/lib/eal/common/eal_memalloc.h
@@ -90,6 +90,27 @@ eal_memalloc_set_seg_list_fd(int list_idx, int fd);
 int
 eal_memalloc_get_seg_fd_offset(int list_idx, int seg_idx, size_t *offset);
 
+/*
+ * Set dmabuf info for a memseg list.
+ * Returns 0 on success, -errno on failure.
+ */
+int
+eal_memseg_list_set_dmabuf_info(int list_idx, int fd, uint64_t offset);
+
+/*
+ * Get dmabuf fd for a memseg list.
+ * Returns fd (>= 0) on success, -1 if not dmabuf backed, -errno on error.
+ */
+int
+eal_memseg_list_get_dmabuf_fd(int list_idx);
+
+/*
+ * Get dmabuf offset for a memseg list.
+ * Returns 0 on success, -errno on failure.
+ */
+int
+eal_memseg_list_get_dmabuf_offset(int list_idx, uint64_t *offset);
+
 int
 eal_memalloc_init(void)
 	__rte_requires_shared_capability(rte_mcfg_mem_get_lock());
diff --git a/lib/eal/common/malloc_heap.c b/lib/eal/common/malloc_heap.c
index 39240c261c..fd0376d13b 100644
--- a/lib/eal/common/malloc_heap.c
+++ b/lib/eal/common/malloc_heap.c
@@ -1232,6 +1232,33 @@ malloc_heap_create_external_seg(void *va_addr, rte_iova_t iova_addrs[],
 	msl->version = 0;
 	msl->external = 1;
 
+	/* initialize dmabuf info to "not dmabuf backed" */
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
index b6e97ad695..d1c2fc8aa5 100644
--- a/lib/eal/include/rte_memory.h
+++ b/lib/eal/include/rte_memory.h
@@ -405,6 +405,82 @@ int
 rte_memseg_get_fd_offset_thread_unsafe(const struct rte_memseg *ms,
 		size_t *offset);
 
+/**
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
+int
+rte_memseg_list_get_dmabuf_fd(const struct rte_memseg_list *msl);
+
+/**
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
+int
+rte_memseg_list_get_dmabuf_fd_thread_unsafe(const struct rte_memseg_list *msl);
+
+/**
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
+int
+rte_memseg_list_get_dmabuf_offset(const struct rte_memseg_list *msl,
+		uint64_t *offset);
+
+/**
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
+int
+rte_memseg_list_get_dmabuf_offset_thread_unsafe(const struct rte_memseg_list *msl,
+		uint64_t *offset);
+
 /**
  * Register external memory chunk with DPDK.
  *
@@ -443,6 +519,55 @@ int
 rte_extmem_register(void *va_addr, size_t len, rte_iova_t iova_addrs[],
 		unsigned int n_pages, size_t page_sz);
 
+/**
+ * Register external memory chunk backed by a dma-buf with DPDK.
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
+ *   This is independent of dmabuf_offset.
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

