Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0407B606A330
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 06:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=sWybd6Xp
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDBA940431;
	Mon, 23 Nov 2026 07:13:14 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
 by mails.dpdk.org (Postfix) with ESMTPS id 9B9DD40430;
 Mon, 23 Nov 2026 07:13:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TM9+hoKeS3fQ4v5kVWeKFto9yswgAgKj19UDoplSmE/BFeAeWZy3e3P+zmOPvmHKL3yqMjrtL/npbxhcBQIcxve6kVFUSJWf+PMSIE08hz6tdNLS5YBzAaXe58lgDz37VOGdNGcIztcObkw3KAwitk/55Cmo4vgXkk1hpgG+YBFP7ghxCNb47SwEU5v9FOTGpSDlf38ehON3FIFv7qTtRTHDt0HBDEO6dYKYhS5Gf1h1fcrlTZRkhaGNo5pW5D1ogOe6BszBsjYVRaN1eV7LccX89X8KMu8L8VtU6X6QeLILPFtB/ieE+QoI6/wQ6jNnep9xk9zB/RMEfPL+Rc1DrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRilmkb3nC3kUOlcMUQdtbTrNE+YrmQ6mbE6rSUSUm8=;
 b=caiXvc2ejbO1NY996NXlkj4YA/vQNfFivUUx+vbyiD7RKMGa4J2ikML8pOrmW8daCpTpbKtDovIqCyBQ8PfWRVsdecSLJbGUypinvfCf5v5z9VWKO9AvoNHGSCqBn4XYitLbB+kZhY2xpCX1yRaiI/L0JdPNOjQM8L67+95+vxgL01+NhLc5b4srnbmhOe2yGbZ1NVMNcSfAmkykew7CvuF+TEkjKkLVcMWB8nZID+rF7OVd393+v5HXOeqBkhpYd8qPcBz69ofF0q/bClARJvnP8mp5EEvrb3DlHSjZA5hbOp5XobSRbV39W3ERAAZJndAIaKWdanLb2UpgjqxBpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRilmkb3nC3kUOlcMUQdtbTrNE+YrmQ6mbE6rSUSUm8=;
 b=sWybd6Xp/q+1s3HZDmMQD2RsL2SAC1PK1fQATqmlhNpSzkCdPRQPpZMOGERkR5Ogk4rGmSoAzx/jlIL4/tbq6S5h44CznMf8YJV+LO3ru2+Bx/neJkeSkbhagIEA1kFXzlm0MgcLrAdi0BJPaNzDh9AUaNyKVMhE5S/3kou3GkKA+WBMzAAlfCW3aHQVzDodv3HU9cJcQwpDNOg2x4r4LCb3i+QIY9+KUArLdmH48ufRKsqgfEDDfYBR9jKHzLiJd9pylGw8geOa/QzNXwvbltFKZXOVA1TxT+Vlm8GVLPwuJ5F9TY01zpGTFxbF4mGw7FfqCypc0U1ge55FsUuBRw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS4PR03MB8131.namprd03.prod.outlook.com (2603:10b6:8:280::9) by
 SA2PR03MB5929.namprd03.prod.outlook.com (2603:10b6:806:11f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 06:13:09 +0000
Received: from DS4PR03MB8131.namprd03.prod.outlook.com
 ([fe80::5759:ab24:f49c:ac71]) by DS4PR03MB8131.namprd03.prod.outlook.com
 ([fe80::5759:ab24:f49c:ac71%7]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 06:13:09 +0000
From: Cheryl Bansal <cheryl.bansal@altera.com>
To: Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Cheryl Bansal <cheryl.bansal@altera.com>
Subject: [PATCH 2/2] bus/pci: add selective BAR mapping support
Date: Mon, 23 Nov 2026 11:43:19 +0530
Message-Id: <20261123061319.163645-2-cheryl.bansal@altera.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123061319.163645-1-cheryl.bansal@altera.com>
References: <20261123061319.163645-1-cheryl.bansal@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To DS4PR03MB8131.namprd03.prod.outlook.com
 (2603:10b6:8:280::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR03MB8131:EE_|SA2PR03MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: 2225054e-65af-4187-eee5-08df4928d8d3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|55112099003|18002099003|22082099003|260925022911599003|260925021911599003|260925021311599003|261009221227099003|261009223027099003|261021121427099003|261021123027099003|261021135927099003|261026140227099003|261026121527099003|261102123227099003|261022105027099003|261028144727099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: g858aTAiKKZx+xSc6wZXdGVmtnRKiwve+ERsxltmNSVsf5+cj5x1FKSvSlBmdblPdqEUIQ8m7cHqbM2SM5lqpwy0QqI+9IY3FwFwxpZsYqk1s3NN/bhlTzQ/kfDBSIxlmQnAH0iKAw42+fLSdoL/ekGWqE9d+x/2f9ZkOpM645TYohL3yjB4IIDtHTeAn7xWseXuLIdBTk3eLmbTZWVsqAaOAf7tBQUcch9i4Sm2uobIeZWUsRTTaLUPAkdO+sCAsOaspIOoSHhyKMzMCOj3XWenr4spqfkdUBi+yHpuUc6vLMkdHSVSeG65seOtdRXf/5QQgaUfBO9ij/9mDjmZpYu/5NwhMHtDITuQL7iOww69avBDMqeCYAZEkV11Cq69AzXh6mZLqlXLeLLH/wVXoDpGb7Ii0USxXAgKtYRa7e4vl3HLF+UB5FaDKssgYnFU+9hKFzsyNGa6TOs/db/NEROebWMKmWOe+5KLLbJRc83x/YfIW8nftD4esB89hnaax1pytxVVLHpHP5Ufqdg8LvzPJd1muXnJvi7MCNSP0lTh01Wi9GoXnawSxbuzOpahdBKsecGBEg+xjeCnc8KzGdBDrUubQObCX+Q5plzlvrazxwWVsQTIUdDPh+kGYdJ3A53+wlQNB9RM9aKnYGZ1kBE7qwcNpouVYXY/gIKdFUw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR03MB8131.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(55112099003)(18002099003)(22082099003)(260925022911599003)(260925021911599003)(260925021311599003)(261009221227099003)(261009223027099003)(261021121427099003)(261021123027099003)(261021135927099003)(261026140227099003)(261026121527099003)(261102123227099003)(261022105027099003)(261028144727099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wJwsbNDcUIuV1wp92f+x719A9NeUPNX7eeMMMFMpRxeF3JnHCKzxzVjRGQ3a?=
 =?us-ascii?Q?N5PPaH0RRXxMd4bsQvHfOmJn0ThPH6F7lvucuS/czzseo4tXbyBOvUr1dnmF?=
 =?us-ascii?Q?X2F5Pm14HxDdkYBFAXA4DMKaZy7GUlJ8YzRIkmcE2+2xlKgbIPPjuck/gjgi?=
 =?us-ascii?Q?hO9xBuyeBbGAdvsLj4lqJ63sHhni3Cr+BrQnDQIGh52Z59gAHXZ4lhGjnGGR?=
 =?us-ascii?Q?Erz6Ld9LML/Q1qlD9zrw9ppIL2NEMSpCAWxvBooIVp9BVeu6Z9RTddhStpdg?=
 =?us-ascii?Q?hn3gkKrJMtmMENnQ4hSGE2e8iWjlpPfPmciJwfqH9YfadrRpXrACxNjPR/vg?=
 =?us-ascii?Q?qiH0ziaFq+olExLPc4Cg2n6b+TJppMRTx21VWqG7Qc3W5Yte69DTzCy7FuMu?=
 =?us-ascii?Q?i/SWsyV5ydUPYWRQn1YGg5d+6HiHgUUoCLhWoH2jW1qqj+vxa2cg8JfrGsf1?=
 =?us-ascii?Q?ZIoJlayF9DUdbR4/A7L73wqD+KIv8EgYGCwhnD8uOGRi2Yi6BcPuoDccM6va?=
 =?us-ascii?Q?VcWrRDIecBfWsWG0JAk+O+QkORT8fb+EE/Ugf5n+jtfsY+I1UQ/T0BFmfxud?=
 =?us-ascii?Q?eNl7pWWBwbk/hpDGfCltzP5Etl31TdoBQSOPHWP3+Y/iNAOxcimeRNVQXHII?=
 =?us-ascii?Q?37NNY8xwamEqE/yRrj/EwCAIAABDcIKUs1y/kMbpaxvKhc26W6aV6ihkiHTA?=
 =?us-ascii?Q?aqXzmGOMMknWFjjBnTYITt1nYnoFXdMNTk1DqsxcGuCnhu/1tmWAJ8KtVif2?=
 =?us-ascii?Q?V3HvXpBfhXgCVSqzLaFTTcuzgvOpB+j6ISYi+zH2ThdupQgw4RwzXvYW6R2i?=
 =?us-ascii?Q?rdVtwHHlqDOJWhmSiFc7ll4vuwGsl4vF3yIF0eOq/Rp0vvBtGetwzqckg6LP?=
 =?us-ascii?Q?bjYN0FZ4hzD4vkoD8pedaDJfQji1aQ6GEl3wUkP3DJT/wtmn3lbIYEjAFPOz?=
 =?us-ascii?Q?pNM5877rLR0XHkp+Vvjiyw8VCnmyGOCKdxqhly3vpQxajqWEm3njzLILZZB6?=
 =?us-ascii?Q?2ilLVknpz/KttB2oVcGhEp135acOcFEoLPLhR2zfDAPNSAVN7pqb36/ajAx4?=
 =?us-ascii?Q?E6kUmTTGvYf5skCT7P6l4MkzU6oJ6cKTPHsTIEGH7HO9+fKrtBVAKOe1FT17?=
 =?us-ascii?Q?sjlDrBnkf3qJPnW7HSZysxFU9ciCuHked3yydLiaYu/NaZTOlhGOcm2nbtFM?=
 =?us-ascii?Q?edtktKLau0+thYhpJjcDUS2UukTBjz07+yKW4wrOcXgn6EFQkR5YqeLXNXJG?=
 =?us-ascii?Q?vdHJMNynmlVQbzk7sfoxoO1RZeAfD0zSr6YbzjIpCTmUACVh4KRgGlY/YCYC?=
 =?us-ascii?Q?fTcdZ6ZJnChoAVa1nSSGk/0I6nyY2ihUZrQZ3LyQM4Ta+tZg0w0a+LNAdcw5?=
 =?us-ascii?Q?EBkOlXSKeBH+6m77Au7L5vu7z9NE9RmzgKTAw9UTat03e7PgBu6tWEQCKz6g?=
 =?us-ascii?Q?V2sOldi0o+vdXvTMOHOx6Pa7KdLStzj17WOp81rAXcTIzdwIFGAQaiAcg57B?=
 =?us-ascii?Q?MgTr7vt2DWOKS2R1HzfLgzZBN+sd7EPMX2AfSHCs5XWvma6nEaA5s0zWUbNu?=
 =?us-ascii?Q?3mZAeM/2v367ZwwmHh315vvAVwgthUE1OhbX+rqWt3N/cykRS+5oXNWbu49g?=
 =?us-ascii?Q?rN2kV4kD74YV7oxrWcA/7k87XWtnO9BX5Zzb+E7RzhWnfuBrqFAST8P5ud9p?=
 =?us-ascii?Q?0BEY3Re9JdqMsQZ6z+5Z481yMpWWWT5vDKBPboriPgytwKjHhZimLtjwThLw?=
 =?us-ascii?Q?MGbb6L5EfQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2225054e-65af-4187-eee5-08df4928d8d3
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8131.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 06:13:09.8153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fmwmBIlPdi6S2GscIaW7+qhLys4lJk42S74cIWXndqzQtGmk+lfNKldsA3WVXw9W8Izg4G602HC9z5PjYzVcwalpBQHU1rMzVCxy6qvna4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5929
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Drivers that only need a subset of PCI BARs still pay the cost of
mapping every valid BAR. There is no bus-level way to select which
BARs are mapped without changing each PMD.

Add the bar_mask PCI bus argument to select which BARs to map. If it
is omitted, all valid BARs are mapped. A zero mask, a value outside
BAR0-BAR5, or a malformed value is rejected. The argument is parsed
from bus_str so it is not passed to PMDs. UIO and VFIO map slots are
indexed by BAR number so primary and secondary processes stay
consistent when some BARs are skipped.

Example: -a bus=pci,addr=0000:01:00.0,bar_mask=0x05

Signed-off-by: Cheryl Bansal <cheryl.bansal@altera.com>
---
 doc/guides/prog_guide/devargs.rst      | 13 +++++++
 doc/guides/rel_notes/release_26_11.rst |  6 +++
 drivers/bus/pci/linux/pci_vfio.c       |  7 ++++
 drivers/bus/pci/pci_common.c           | 46 +++++++++++++++++++++++
 drivers/bus/pci/pci_common_uio.c       | 52 ++++++++++++++------------
 drivers/bus/pci/pci_params.c           |  2 +
 drivers/bus/pci/private.h              | 16 ++++++++
 7 files changed, 118 insertions(+), 24 deletions(-)

diff --git a/doc/guides/prog_guide/devargs.rst b/doc/guides/prog_guide/devargs.rst
index c8a7224aa0..dc30f3a487 100644
--- a/doc/guides/prog_guide/devargs.rst
+++ b/doc/guides/prog_guide/devargs.rst
@@ -82,6 +82,19 @@ The above example will pass ``representor=[0-3]`` devarg
 only to device corresponding to PCI address ``0000:02:00.0``,
 and only if it is managed by ``ice`` driver.
 
+PCI bus arguments include:
+
+* ``addr``: PCI address of the device (BDF).
+* ``bar_mask``: bitmask of BARs to map (bits 0-5 for BAR0-BAR5).
+  If omitted, all valid BARs are mapped.
+  A zero mask, a value outside BAR0-BAR5, or a malformed value is rejected.
+
+.. code-block:: none
+
+   bus=pci,addr=0000:01:00.0,bar_mask=0x05
+
+The above example maps BAR0 and BAR2 only for the given PCI device.
+
 
 Simplified syntax
 ~~~~~~~~~~~~~~~~~
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 10ab2355ae..90dc79ee16 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -58,6 +58,12 @@ New Features
   the kernel driver is the generic ``vfio-platform``,
   which carries no device identity in its name.
 
+* **Added selective PCI BAR mapping.**
+
+  Added the PCI bus argument ``bar_mask`` to select which BARs to map.
+  If omitted, all valid BARs are mapped.
+  Example: ``-a bus=pci,addr=0000:01:00.0,bar_mask=0x05``.
+
 * **Added 1.6T link speed to ethdev.**
 
   Added the 1.6 Tb/s Ethernet link speed,
diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index 4363d7ff2c..1046d84c36 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -738,6 +738,7 @@ pci_vfio_map_resource_primary(struct rte_pci_device *dev)
 	struct mapped_pci_resource *vfio_res = NULL;
 	struct mapped_pci_res_list *vfio_res_list =
 		RTE_TAILQ_CAST(dev_vfio_tailq.head, mapped_pci_res_list);
+	uint8_t bar_mask = pci_get_bar_mask(dev);
 
 	struct pci_map *maps;
 
@@ -814,6 +815,9 @@ pci_vfio_map_resource_primary(struct rte_pci_device *dev)
 		struct vfio_info_cap_header *hdr;
 		struct vfio_region_info_cap_sparse_mmap *sparse;
 
+		if ((bar_mask & (1 << i)) == 0)
+			continue;
+
 		ret = pci_vfio_get_region_info(vfio_dev_fd, &reg, i);
 		if (ret < 0) {
 			PCI_LOG(ERR, "%s cannot get device region info error %i (%s)",
@@ -1018,6 +1022,9 @@ pci_vfio_map_resource_secondary(struct rte_pci_device *dev)
 int
 pci_vfio_map_resource(struct rte_pci_device *dev)
 {
+	if (RTE_PCI_DEVICE_INTERNAL(dev)->bar_mask_err != 0)
+		return -EINVAL;
+
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
 		return pci_vfio_map_resource_primary(dev);
 	else
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index 3770b4ad75..f36e66a48d 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -3,6 +3,7 @@
  * Copyright 2013-2014 6WIND S.A.
  */
 
+#include <errno.h>
 #include <string.h>
 #include <inttypes.h>
 #include <stdint.h>
@@ -25,6 +26,7 @@
 #include <rte_string_fns.h>
 #include <rte_common.h>
 #include <rte_devargs.h>
+#include <rte_kvargs.h>
 #include <rte_tailq.h>
 
 #include "private.h"
@@ -78,15 +80,59 @@ pci_asprintf(char **buffer, const char *format, ...)
 }
 #endif /* RTE_EXEC_ENV_WINDOWS */
 
+/* Parse bar_mask from bus_str. Absent => 0 (map all). Invalid => -EINVAL. */
+static int
+pci_parse_bar_mask(const struct rte_devargs *devargs, uint8_t *mask)
+{
+	struct rte_kvargs *kvargs;
+	const char *bar_mask_str;
+	unsigned long val;
+	char *endptr;
+
+	*mask = 0;
+	if (devargs == NULL || devargs->bus_str == NULL)
+		return 0;
+
+	kvargs = rte_kvargs_parse(devargs->bus_str, NULL);
+	if (kvargs == NULL) {
+		PCI_LOG(ERR, "cannot parse bus arguments: %s",
+			devargs->bus_str);
+		return -EINVAL;
+	}
+
+	bar_mask_str = rte_kvargs_get(kvargs, PCI_BAR_MASK_ARG);
+	if (bar_mask_str == NULL) {
+		rte_kvargs_free(kvargs);
+		return 0;
+	}
+
+	errno = 0;
+	val = strtoul(bar_mask_str, &endptr, 0);
+	if (errno != 0 || endptr == bar_mask_str || *endptr != '\0' ||
+			val == 0 || val > PCI_BAR_MASK_ALL) {
+		PCI_LOG(ERR, "Invalid bar_mask value '%s'", bar_mask_str);
+		rte_kvargs_free(kvargs);
+		return -EINVAL;
+	}
+
+	*mask = (uint8_t)val;
+	rte_kvargs_free(kvargs);
+	return 0;
+}
+
 void
 pci_common_set(struct rte_pci_device *dev)
 {
+	struct rte_pci_device_internal *pdev = RTE_PCI_DEVICE_INTERNAL(dev);
+
 	/* Each device has its internal, canonical name set. */
 	rte_pci_device_name(&dev->addr,
 			dev->name, sizeof(dev->name));
 	dev->device.name = dev->name;
 
 	dev->device.devargs = rte_bus_find_devargs(&rte_pci_bus, dev->name);
+	pdev->bar_mask_err = pci_parse_bar_mask(dev->device.devargs,
+			&pdev->bar_mask);
 
 	if (dev->bus_info != NULL ||
 			asprintf(&dev->bus_info, "vendor_id=%"PRIx16", device_id=%"PRIx16,
diff --git a/drivers/bus/pci/pci_common_uio.c b/drivers/bus/pci/pci_common_uio.c
index 52a10f806a..19d8df5d1d 100644
--- a/drivers/bus/pci/pci_common_uio.c
+++ b/drivers/bus/pci/pci_common_uio.c
@@ -27,7 +27,7 @@ EAL_REGISTER_TAILQ(rte_uio_tailq)
 static int
 pci_uio_map_secondary(struct rte_pci_device *dev)
 {
-	int fd, i = 0, j, res_idx;
+	int fd, i, j;
 	struct mapped_pci_resource *uio_res;
 	struct mapped_pci_res_list *uio_res_list =
 			RTE_TAILQ_CAST(rte_uio_tailq.head, mapped_pci_res_list);
@@ -38,15 +38,11 @@ pci_uio_map_secondary(struct rte_pci_device *dev)
 		if (rte_pci_addr_cmp(&uio_res->pci_addr, &dev->addr))
 			continue;
 
-		/* Map all BARs */
-		for (res_idx = 0; res_idx != PCI_MAX_RESOURCE; res_idx++) {
-			/* skip empty BAR */
-			if (dev->mem_resource[res_idx].phys_addr == 0)
+		/* Replay primary mappings (indexed by BAR) */
+		for (i = 0; i != PCI_MAX_RESOURCE; i++) {
+			if (uio_res->maps[i].size == 0)
 				continue;
 
-			if (i >= uio_res->nb_maps)
-				return -1;
-
 			/*
 			 * open devname, to mmap it
 			 */
@@ -80,9 +76,7 @@ pci_uio_map_secondary(struct rte_pci_device *dev)
 				}
 				return -1;
 			}
-			dev->mem_resource[res_idx].addr = mapaddr;
-
-			i++;
+			dev->mem_resource[i].addr = mapaddr;
 		}
 		return 0;
 	}
@@ -95,11 +89,15 @@ pci_uio_map_secondary(struct rte_pci_device *dev)
 int
 pci_uio_map_resource(struct rte_pci_device *dev)
 {
-	int i, map_idx = 0, ret;
+	int i, ret;
 	uint64_t phaddr;
 	struct mapped_pci_resource *uio_res = NULL;
 	struct mapped_pci_res_list *uio_res_list =
 		RTE_TAILQ_CAST(rte_uio_tailq.head, mapped_pci_res_list);
+	uint8_t bar_mask = pci_get_bar_mask(dev);
+
+	if (RTE_PCI_DEVICE_INTERNAL(dev)->bar_mask_err != 0)
+		return -EINVAL;
 
 	/* allocate uio resource */
 	ret = pci_uio_alloc_resource(dev, &uio_res);
@@ -110,31 +108,34 @@ pci_uio_map_resource(struct rte_pci_device *dev)
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return pci_uio_map_secondary(dev);
 
-	/* Map all BARs */
+	/* Index maps[] by BAR number */
 	for (i = 0; i != PCI_MAX_RESOURCE; i++) {
+		if ((bar_mask & (1 << i)) == 0)
+			continue;
+
 		/* skip empty BAR */
 		phaddr = dev->mem_resource[i].phys_addr;
 		if (phaddr == 0)
 			continue;
 
 		ret = pci_uio_map_resource_by_index(dev, i,
-				uio_res, map_idx);
+				uio_res, i);
 		if (ret)
 			goto error;
-
-		map_idx++;
 	}
 
-	uio_res->nb_maps = map_idx;
+	uio_res->nb_maps = PCI_MAX_RESOURCE;
 
 	TAILQ_INSERT_TAIL(uio_res_list, uio_res, next);
 
 	return 0;
 error:
-	for (i = 0; i < map_idx; i++) {
-		pci_unmap_resource(uio_res->maps[i].addr,
-				(size_t)uio_res->maps[i].size);
-		rte_free(uio_res->maps[i].path);
+	for (i = 0; i < PCI_MAX_RESOURCE; i++) {
+		if (uio_res->maps[i].addr != NULL) {
+			pci_unmap_resource(uio_res->maps[i].addr,
+					(size_t)uio_res->maps[i].size);
+			rte_free(uio_res->maps[i].path);
+		}
 	}
 	pci_uio_free_resource(dev, uio_res);
 	return -1;
@@ -149,6 +150,8 @@ pci_uio_unmap(struct mapped_pci_resource *uio_res)
 		return;
 
 	for (i = 0; i != uio_res->nb_maps; i++) {
+		if (uio_res->maps[i].addr == NULL)
+			continue;
 		pci_unmap_resource(uio_res->maps[i].addr,
 				(size_t)uio_res->maps[i].size);
 		if (rte_eal_process_type() == RTE_PROC_PRIMARY)
@@ -166,10 +169,11 @@ pci_uio_remap_resource(struct rte_pci_device *dev)
 	if (dev == NULL)
 		return -1;
 
-	/* Remap all BARs */
+	/* Remap mapped BARs only */
 	for (i = 0; i != PCI_MAX_RESOURCE; i++) {
-		/* skip empty BAR */
-		if (dev->mem_resource[i].phys_addr == 0)
+		/* skip empty or unmapped BAR */
+		if (dev->mem_resource[i].phys_addr == 0 ||
+				dev->mem_resource[i].addr == NULL)
 			continue;
 		map_address = mmap(dev->mem_resource[i].addr,
 				(size_t)dev->mem_resource[i].len,
diff --git a/drivers/bus/pci/pci_params.c b/drivers/bus/pci/pci_params.c
index 6cbd98b4c8..4fe148b0a1 100644
--- a/drivers/bus/pci/pci_params.c
+++ b/drivers/bus/pci/pci_params.c
@@ -17,11 +17,13 @@
 
 enum pci_params {
 	RTE_PCI_PARAM_ADDR,
+	RTE_PCI_PARAM_BAR_MASK,
 	RTE_PCI_PARAM_MAX,
 };
 
 static const char * const pci_params_keys[] = {
 	[RTE_PCI_PARAM_ADDR] = "addr",
+	[RTE_PCI_PARAM_BAR_MASK] = PCI_BAR_MASK_ARG,
 	[RTE_PCI_PARAM_MAX] = NULL,
 };
 
diff --git a/drivers/bus/pci/private.h b/drivers/bus/pci/private.h
index f266a1b04d..0806822602 100644
--- a/drivers/bus/pci/private.h
+++ b/drivers/bus/pci/private.h
@@ -43,8 +43,24 @@ struct rte_pci_device_internal {
 	struct rte_pci_device device;
 	/* PCI regions provided by e.g. VFIO. */
 	struct rte_pci_region region[RTE_MAX_PCI_REGIONS];
+	int bar_mask_err;	/* nonzero if bar_mask was present but invalid */
+	uint8_t bar_mask;	/* 0 = map all BARs */
 };
 
+#define PCI_BAR_MASK_ARG "bar_mask"
+#define PCI_BAR_MASK_ALL ((1U << PCI_MAX_RESOURCE) - 1)
+
+static inline uint8_t
+pci_get_bar_mask(struct rte_pci_device *dev)
+{
+	struct rte_pci_device_internal *pdev = RTE_PCI_DEVICE_INTERNAL(dev);
+	uint8_t mask = pdev->bar_mask;
+
+	if (mask == 0)
+		mask = PCI_BAR_MASK_ALL;
+	return mask;
+}
+
 /**
  * Scan the content of the PCI bus, and the devices in the devices
  * list
-- 
2.43.0

