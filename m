Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A79606A325
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=sZbWoHWq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A6FD40A75;
	Mon,  9 Nov 2026 17:09:51 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013071.outbound.protection.outlook.com
 [40.107.201.71])
 by mails.dpdk.org (Postfix) with ESMTPS id 7E3E940270
 for <dev@dpdk.org>; Mon,  9 Nov 2026 17:09:50 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCBbbqx5+i4nW2PGxfdr+z9kCRmffnJRQibxufB8wjEJlmoeyjMwp2xZt4jQcpvzmN+uOJiO+dP/ZjvQXnrgvdW/MR93FR+q0o/K9xr5OuN2vB6svEVgGu42WAPg8z9gJTDLWhxaFse+QzdglkPBJ1WEq5CpyOE57CNOXMKXT7reDImlgXxLjfk2Oe8ZMxXADDrT4rmRBsjm+Ulk8tFLPhi1/VzzOuo2MQIijpcNNO3z1cKOBC9x+Ygb3i4n6jr5tNsdkZ1Hr+BOhyx9wlcvyV+1ofwc6i5Icn3eDBZD2+Q1AfOOvpRcepOi2wo2wWfA/LjNfDFQ7B+KDoHH3ch21w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSbTYzO/nyH2zvA++n7o1tiTPsGehZjJ4HQdwlxyjfc=;
 b=AESex/6wAwD1ILEfv+lFADC0btuD70myGkd0TEuzmCuFF+Iu2KzMkbOrPeJBoRxg2A/WsfEN+yO1OboYPU6R3SIMsP7pFLQ4qka8lkm+pYjiJB+qo1Ktuus4l/6G9irwS0SWu76GYIvafzlVkoqdsfusrmmpc/lIaRKaMxBeYP9uwGHPIRr2jX3TtxxXaZDlGumB1J1NuYUqgQSv6WbdYrCnErtSjzfdggQ+J97bIV6Vz8+X+pPHJTE/9lWvjLhCp/ubNJU/48eAp8y6fUgkUhOU5tkaf97tuRpSy6w+92jWM08cUGJ67HSi7oF/FydGtObTZanEVkdhUhEreKMuPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSbTYzO/nyH2zvA++n7o1tiTPsGehZjJ4HQdwlxyjfc=;
 b=sZbWoHWqt1/bgDbK/r8PIW/FzUzwM/fZwOVTY+j0XdTpzW4sIYvNPPzv4UEnWyhzXqyHx7/yBYOHgOJuJCKRqErejUr7aBBUxf1iTFLGMpfwnqew0SW8VsZzIvOz518FjDLYGFqvvUeo5fekVsrKEXPb9jz3ltCYDj0izU4numeX/UprYFE/nl5cHX87Pmf1AhD1TTM7AYKYqNOGNvAKSYKhkdj3NIteOYT2NelomtdGTa30jwUpbIau04bkHituFvq4sjEydchw5r06h5Wp8Vz1i+L14VNjn3h1LITyicLD4x5c1Ifx0HM6ocgrR1YNALlQ/2nPb4I1sGyZ9QsYbA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CH3PR03MB7411.namprd03.prod.outlook.com (2603:10b6:610:197::16)
 by DS1PR03MB7942.namprd03.prod.outlook.com (2603:10b6:8:222::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 16:09:45 +0000
Received: from CH3PR03MB7411.namprd03.prod.outlook.com
 ([fe80::66:2169:186c:d088]) by CH3PR03MB7411.namprd03.prod.outlook.com
 ([fe80::66:2169:186c:d088%5]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 16:09:45 +0000
From: "Subhransu S. Prusty" <subhransu.sekhar.prusty@altera.com>
To: dev@dpdk.org
Cc: ferruh.yigit@intel.com, stephen@networkplumber.org, rtice@cisco.com,
 cheryl.bansal@altera.com, nanditha.jayarajan@altera.com,
 "Subhransu S. Prusty" <subhransu.sekhar.prusty@altera.com>
Subject: [RFC 3/4] net/mcdma: add experimental PIO access APIs
Date: Tue, 10 Nov 2026 00:09:25 +0800
Message-Id: <20261109160926.800828-4-subhransu.sekhar.prusty@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261109160926.800828-1-subhransu.sekhar.prusty@altera.com>
References: <20261109160926.800828-1-subhransu.sekhar.prusty@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::26) To CH3PR03MB7411.namprd03.prod.outlook.com
 (2603:10b6:610:197::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR03MB7411:EE_|DS1PR03MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 13253d7e-1870-457f-f1d6-08df3e7bde81
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|261021135927099003|56012099006|261021121427099003|261022113327099003|261022105027099003|261009223027099003|261026140227099003|261102130727099003|261028144727099003|261102123227099003|261026121527099003|10067099003|55112099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 4v7qcDZJgZYYwLrmYDV9PBD2xlJRLf1QSQOYO4bjDcJJjo/9UtNFFh+7E8BqIK3KNVF+KZqiPfWH4nQFWWZV3FNWPxSv4bQ1U9arm+xcNNrJNCM2aP7x02Bw3G8fqOfsmb2XnGONVr8zvN1k4MNavPd82/siXYeyLRuehayZaJZDuIqy2o6fY7ZFYqxuQ3fUOG0fJhCEy3HajUEkb9fLjA3SRAtCTpeEyXbuxiAVfBz2tHGJd6+oltA8d0Dg9MhwsbLkbBdka7Z9R2x6yhEfV84oGGKNqGCet0YJhHtgGsAAA07igGuuEhvaBX31s88mM3LvbWm03TvistSx87L2gvylFSflJDAzb0tO3PaSJLTDIKgsy17KHLAJKv6m5GWlWiSi702F7cC6uAkB00byQuWyznXtO9igjSZHgHbQ2LJgoyEPxdlfCiw9BPaWOlxI/dO/Qnz2PD9aK0YqpOy2W9VLCzaAGsaCLk8fuppgsffXJwFAJRXm8yqAGpdkPuVYw7oX3kMwX1ALzbAm1CzzInvZ8dDKVn4PFMp/DfMHMRvgiI84H/VPIyKa8mPFxGnl83sCErAL2EFZbb9Ly6rhk2wrg1m6LVvqkigvVwShs/y8/fQcvSzvqYXuwmLFsP4vh/RT9hCm6jY+cs3wvRktuOawG/xRbSR4RASjZZ4ABIg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR03MB7411.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(261021135927099003)(56012099006)(261021121427099003)(261022113327099003)(261022105027099003)(261009223027099003)(261026140227099003)(261102130727099003)(261028144727099003)(261102123227099003)(261026121527099003)(10067099003)(55112099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MJ/CxFW9ECEEyOy6AfJIcW6V9sY5yliZmFr5pr1ArwocrM0jyQ8z0Ln4KBF/?=
 =?us-ascii?Q?RAnrvZXAW0brtgnqSnYtPoTsyhlCe/4Zw56gMFvFkSpH5V5AtEU3ptQhqpt/?=
 =?us-ascii?Q?9DVGKnroHWlNyj8seod3dXbNxh4Jyjkkll3ERLtnAOeZGvInJHM87qPUKN8k?=
 =?us-ascii?Q?UqCm1vT05zY/0DnX76S4A/FlfOtbrpkRLNsFF6A1Or1egKIxFWtVKadwyyPo?=
 =?us-ascii?Q?ozQda4LqqBV41nMzu45AWgCB34CxGFRyMbQak+PZh+Kwv/HEp87WNorKtNpk?=
 =?us-ascii?Q?xjqxv2UTpWHaluzEZqTBbWgscf8qapAFvedj1DKbyac+MHOfBohFG2KmTnQJ?=
 =?us-ascii?Q?cwpAoB82kK7xqhvGmGTozwrQGL3wIH9bzHQM9UKh/FG4p/aATdEgE2FP9i13?=
 =?us-ascii?Q?++5wMZCqWwNIFf9VaN3YS5p3hFAOWX1Zg5Si+rz4/F4E2FGqsi2Rx26/yGa+?=
 =?us-ascii?Q?8W8Osv7M3eTisnIYMcv3lbfMTpj0VyPzclScNF//dTsL/HSKe3gONsZXvm9O?=
 =?us-ascii?Q?Wihx1bz4s3pQV+6WvW8TqV+yA/U/c05bIekrL+ShOpgygAlsDcXfyQbhcdKe?=
 =?us-ascii?Q?kN3VmvyTVuu+h74jm1RunmwO4bIawoiykFaBult+aWWlT9C5B8fL3ze6/oTc?=
 =?us-ascii?Q?5h+ffxbtEDfyodKCRcdk+riLq6JBQMm2Gd/TKbDtQVv8sF+xNTiFPYO58Fks?=
 =?us-ascii?Q?2ue5fOgciCzDrtIfvzck3WYOBCAUSl3RyS9t6fuea3S2XnrCDkebQhtZv9tg?=
 =?us-ascii?Q?kATFbJnlEGowj+AGff8V+MTmoj7kZTElppizHyOhqdW7RGTm+QPprkOC70BJ?=
 =?us-ascii?Q?iTQsj3DZMAtdqcHmoGRwhjxVZ1WTiAkez/Duoy1Zd/YGodP9vnACygMTvE7g?=
 =?us-ascii?Q?sq+kJ2cpcanTM9rYrjx9CjMWHNwc8M8E6mZCpifk25+r4XCcsfoP6oCtWTJa?=
 =?us-ascii?Q?YrzBvhxnPnmrrk5XA3mpIi44WfABvUT9xcTVDVpPOHeGRfbQWsFoKRhZQnFa?=
 =?us-ascii?Q?Wm2m06pJECdVO4A9qK8Mmsrt8SUnc5VVFQ8HIkdtYNYzk0JV4oSSUxm0kWJE?=
 =?us-ascii?Q?WTT11yjQXnpYit6N1lWwiNLz1QyaAoP4RRkis+nXHvoj6taynztlanmrlqlz?=
 =?us-ascii?Q?73Ec0YQr5QfPcnOuLiCg1x1p2BZhHLoWsG/JiJbno5ZpB3+6McHrDHVL0pN5?=
 =?us-ascii?Q?Uj02Rt/KexPev9AtOSbWuXPxOwkxU/7h0frES9TF1u8QzEfdSTDpdA/uRDVe?=
 =?us-ascii?Q?ATFvTEbN6jaNdEKxCnqKyIsE0es0gKdF9xCQ3+k2UEyBtWCtfSYfhp6RGIX8?=
 =?us-ascii?Q?wjnUByiEaR1piP+IAKTycwr/1lT7x5NtNGPpXu1yhY367K/GpBLM4Aefd0BO?=
 =?us-ascii?Q?HKi1WN5PHl7O3gNRpxdq2nHjot+O99InBgknEZKuk8zhCgVXqnBXcokUbUxI?=
 =?us-ascii?Q?156qTKiKYZcL2aiKlUsJJvB9XHDuMgpc3qk+if+k44SR62F4A1T+2DdLtDts?=
 =?us-ascii?Q?l8zQpRMOHOnWra3pNmhXtUNCGNQGZHPLiCYt5byT8SFAh8IE/xnnmqFStgMg?=
 =?us-ascii?Q?vQJ1P+zaDZ9Ll5pyi+DBGcO9EU695cZjmpCcTXWRNxUvMD2ioi0rOE7BVg3U?=
 =?us-ascii?Q?hDHA8ww/HQhCU7m+RaiwEu3DugGpboxiRIbobMlgBln/EzbQrVMDKY5Q/PkS?=
 =?us-ascii?Q?39ZmjVpCEURxeb3rlztpnMAUw9wN4oGjHbkOrpySzQZQxX4cFWojQIH46sex?=
 =?us-ascii?Q?bwtnOt0WdBWtkjukduyTSxVmwdHymbYonypw0TMnFT6wfr4lUqbu?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13253d7e-1870-457f-f1d6-08df3e7bde81
X-MS-Exchange-CrossTenant-AuthSource: CH3PR03MB7411.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 16:09:44.9841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1wj77HoWXqfDnpnbv3FeDxZ2nlcxfdp9wB2xKaimsxYVxZ+S8u8HkwIiRFiySMtC5pRmicPzEFMmasl5uMk1Te6Wq2bqHxG+HVUv0tYT7D8+omwJQFblV9ujPsuWU1U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR03MB7942
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

Expose __rte_experimental helpers to read and write 64-bit registers in
the optional PIO BAR mapped for an MCDMA port. Applications use these to
reach user logic behind the PCIe function.

Co-developed-by: Cheryl Bansal <cheryl.bansal@altera.com>
Signed-off-by: Cheryl Bansal <cheryl.bansal@altera.com>
Signed-off-by: Subhransu S. Prusty <subhransu.sekhar.prusty@altera.com>
---
 doc/guides/nics/mcdma.rst                |  13 +++
 drivers/net/altera/mcdma/meson.build     |   3 +
 drivers/net/altera/mcdma/rte_pmd_mcdma.c | 106 +++++++++++++++++++++++
 drivers/net/altera/mcdma/rte_pmd_mcdma.h |  61 +++++++++++++
 4 files changed, 183 insertions(+)
 create mode 100644 drivers/net/altera/mcdma/rte_pmd_mcdma.c
 create mode 100644 drivers/net/altera/mcdma/rte_pmd_mcdma.h

diff --git a/doc/guides/nics/mcdma.rst b/doc/guides/nics/mcdma.rst
index e31fac2efe71..3bbd345d575c 100644
--- a/doc/guides/nics/mcdma.rst
+++ b/doc/guides/nics/mcdma.rst
@@ -104,6 +104,19 @@ The following standard ethdev features are not implemented:
 Traffic acceptance and any Ethernet semantics beyond descriptor DMA are
 defined by the FPGA application connected to the MCDMA IP.
 
+Experimental driver API
+-----------------------
+
+The header ``rte_pmd_mcdma.h`` provides experimental helpers to access
+ the PIO BAR:
+
+rte_pmd_mcdma_pio_read64() / rte_pmd_mcdma_pio_write64()
+   Read or write 64-bit registers in the mapped PIO BAR. ``pio_read64`` returns
+   0 on success and stores the value via an output pointer so a valid register
+   read of zero is not confused with an error.
+
+These symbols are experimental and may change without notice.
+
 Building and testing
 --------------------
 
diff --git a/drivers/net/altera/mcdma/meson.build b/drivers/net/altera/mcdma/meson.build
index 65f442310f07..df1bbc495c73 100644
--- a/drivers/net/altera/mcdma/meson.build
+++ b/drivers/net/altera/mcdma/meson.build
@@ -10,4 +10,7 @@ sources += files(
         'mcdma_eth.c',
         'mcdma_eth_ops.c',
         'mcdma_eth_rxtx.c',
+        'rte_pmd_mcdma.c',
 )
+
+headers = files('rte_pmd_mcdma.h')
diff --git a/drivers/net/altera/mcdma/rte_pmd_mcdma.c b/drivers/net/altera/mcdma/rte_pmd_mcdma.c
new file mode 100644
index 000000000000..49d7d97b90bc
--- /dev/null
+++ b/drivers/net/altera/mcdma/rte_pmd_mcdma.c
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2020-2026 Altera Corporation
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <eal_export.h>
+#include <ethdev_driver.h>
+#include <rte_compat.h>
+
+#include "mcdma_eth.h"
+#include "rte_pmd_mcdma.h"
+
+#define MCDMA_PMD_NAME "net_mcdma"
+
+static int
+mcdma_pmd_port_get(uint16_t port_id, struct rte_eth_dev **eth_dev)
+{
+	struct rte_eth_dev *dev;
+
+	if (eth_dev == NULL)
+		return -EINVAL;
+
+	if (!rte_eth_dev_is_valid_port(port_id))
+		return -EINVAL;
+
+	dev = &rte_eth_devices[port_id];
+	if (dev->state != RTE_ETH_DEV_ATTACHED)
+		return -ENODEV;
+
+	if (dev->device == NULL || dev->device->driver == NULL ||
+	    strcmp(dev->device->driver->name, MCDMA_PMD_NAME) != 0)
+		return -ENODEV;
+
+	*eth_dev = dev;
+	return 0;
+}
+
+static int
+mcdma_pio_offset_check(const struct mcdma_pci_device *priv, uint64_t offset)
+{
+	if (priv->pio == NULL || priv->pio_bar_len == 0)
+		return -ENODEV;
+
+	if ((offset & (sizeof(uint64_t) - 1)) != 0)
+		return -EINVAL;
+
+	if (priv->pio_bar_len < sizeof(uint64_t) ||
+	    offset > priv->pio_bar_len - sizeof(uint64_t))
+		return -EINVAL;
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mcdma_pio_read64, 26.11)
+int
+rte_pmd_mcdma_pio_read64(uint16_t port_id, uint64_t offset, uint64_t *val)
+{
+	struct rte_eth_dev *dev;
+	struct mcdma_pci_device *priv;
+	int ret;
+
+	if (val == NULL)
+		return -EINVAL;
+
+	ret = mcdma_pmd_port_get(port_id, &dev);
+	if (ret != 0)
+		return ret;
+
+	priv = dev->data->dev_private;
+	if (priv == NULL)
+		return -EINVAL;
+
+	ret = mcdma_pio_offset_check(priv, offset);
+	if (ret != 0)
+		return ret;
+
+	*val = mcdma_pio_reg_read64(priv->pio, offset);
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mcdma_pio_write64, 26.11)
+int
+rte_pmd_mcdma_pio_write64(uint16_t port_id, uint64_t offset, uint64_t val)
+{
+	struct rte_eth_dev *dev;
+	struct mcdma_pci_device *priv;
+	int ret;
+
+	ret = mcdma_pmd_port_get(port_id, &dev);
+	if (ret != 0)
+		return ret;
+
+	priv = dev->data->dev_private;
+	if (priv == NULL)
+		return -EINVAL;
+
+	ret = mcdma_pio_offset_check(priv, offset);
+	if (ret != 0)
+		return ret;
+
+	mcdma_pio_reg_write64(priv->pio, offset, val);
+	return 0;
+}
diff --git a/drivers/net/altera/mcdma/rte_pmd_mcdma.h b/drivers/net/altera/mcdma/rte_pmd_mcdma.h
new file mode 100644
index 000000000000..d76babbdf7e0
--- /dev/null
+++ b/drivers/net/altera/mcdma/rte_pmd_mcdma.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2020-2026 Altera Corporation
+ */
+
+#ifndef RTE_PMD_MCDMA_H
+#define RTE_PMD_MCDMA_H
+
+/**
+ * @file rte_pmd_mcdma.h
+ *
+ * Altera MCDMA PMD specific functions.
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+
+#include <rte_compat.h>
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
+ *
+ * Read a 64-bit value from the mapped PIO BAR at @p offset.
+ *
+ * @param port_id
+ *   Port identifier.
+ * @param offset
+ *   Byte offset from the PIO BAR base (must be 8-byte aligned and fit a
+ *   64-bit access within the mapped PIO BAR).
+ * @param val
+ *   On success, the 64-bit register value is stored here. Untouched on failure.
+ *
+ * @return
+ *   0 on success, negative errno on failure (-EINVAL, -ENODEV).
+ */
+__rte_experimental
+int
+rte_pmd_mcdma_pio_read64(uint16_t port_id, uint64_t offset, uint64_t *val);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
+ *
+ * Write a 64-bit value to the mapped PIO BAR at @p offset.
+ *
+ * @param port_id
+ *   Port identifier.
+ * @param offset
+ *   Byte offset from the PIO BAR base (must be 8-byte aligned and fit a
+ *   64-bit access within the mapped PIO BAR).
+ * @param val
+ *   Value to write.
+ *
+ * @return
+ *   0 on success, negative errno on failure (-EINVAL, -ENODEV).
+ */
+__rte_experimental
+int
+rte_pmd_mcdma_pio_write64(uint16_t port_id, uint64_t offset, uint64_t val);
+
+#endif /* RTE_PMD_MCDMA_H */
-- 
2.34.1

