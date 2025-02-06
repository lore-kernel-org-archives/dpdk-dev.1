Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E444C02196
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 10:54:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B607402CE;
	Thu,  6 Feb 2025 11:54:56 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
 by mails.dpdk.org (Postfix) with ESMTP id 550A84026C;
 Thu,  6 Feb 2025 11:54:54 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/svMG5FSBlFhOCjbIeHJTUmgwNupWViQNz4x5yZYruiemQUB/EbG5MnhOhs3pTMSmR1LGC2gdy7pdvCqvAfLGTqJ1KA9fT9IT8E8xxF2hjYsu2mCjJ66sAsbiYSrpDiA8TG2CHlboPmqt9+ng8rjFgJQRBJwyp/Oqt9VleptXm7zhMYJtqLiwv3htbt99SJFc0LTICroSORI/HF3wbdmxIUo5nwe7tRW0mfbMsU+pl9dsFFKR7FWcKWnxdYoTW4A2GxrhWV0KFLE1VcUHf61NvoIeP7xNUWyMX+j9KyAzaMxMvueEPbFvxqOu4kkHGHAq8czxkA/ahG3qk2nPhE3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRkOmjXY62KhiNlrMy273Nr803nhri+0TQwaxHpgQRQ=;
 b=LdvTF583BekWT8nDwYn2Xbx+z47/yh2o2D/3ijbwPvTDh9KjGt/BACJ+RARyv/UAZzxn6iwEHneISbkpdQbv8VMbRJsP34W7axh0ANWT2hBkHNon21V/LSwmNgYs2IxEM13Jr5boAp1gy6efx10xkfkokYgLbw5xA0TKOpo5YR37vNWFyS7mfdHItMMTsjPOZAqW7VvzZCDgW8xlz3XNbaDgNVRF3KRNJVsCmPjkJ/l1P+xNssK8KcSZNbsFZo8Ou1GYHGm5avdW71XwTz74RCavknIuIAZsAyy8QIlEHUbJZhs9QionHyOCMQAs4zn0NaIVbyBRlvIpds7ZSMnISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRkOmjXY62KhiNlrMy273Nr803nhri+0TQwaxHpgQRQ=;
 b=JPQsQLA/H2lxT0xNsx1L0ZJ27L5M5Lg2X+FLdk3J+Cc+fPaTnA1cPiQO5NOqwO8NLtcB5VT5M/jIBc2+9bRmidibMdyEBvo8HwBIsg2ABdu3DGYpjAFoimypmXMZNm0zTVJU7Y/Tofvo0d0epu3qKVukophZ9YdGaPQh4GYC1Cu2VogxPZAyAgMyt5E8FGReCsu+DQU7c2KRPpAGyVq6HT2jmQ52nC8ZtzgQUs3BKSWy0YQXCpvrhZA417WWxQLB7X//X4O4uXed8CjMzhE1iBlFjf9EUKfjw2ILPiunqRT+dG2tRCRnrtV/hY83VsFNEGKq7puYkSUJZzFwaD3m4Q==
Received: from SJ0PR13CA0203.namprd13.prod.outlook.com (2603:10b6:a03:2c3::28)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 6 Feb
 2025 10:54:52 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::e) by SJ0PR13CA0203.outlook.office365.com
 (2603:10b6:a03:2c3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.6 via Frontend Transport; Thu, 6
 Feb 2025 10:54:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 10:54:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Feb 2025
 02:54:35 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 6 Feb
 2025 02:54:34 -0800
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 6 Feb 2025 02:54:32 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, Shani Peretz <shperetz@nvidia.com>,
 <stable@dpdk.org>, Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Gaetan Rivet <grive@u256.net>
Subject: [PATCH v6 1/4] bus/pci: fix registration of PCI device
Date: Thu, 6 Feb 2025 12:54:24 +0200
Message-ID: <20250206105428.237346-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206000838.23428-5-shperetz@nvidia.com>
References: <20250206000838.23428-5-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: eae9652d-1f02-4d82-0ce2-08dd469caed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zirVmfp7xnoD4mzrt4AabzpVb6wHOKiR1c9w1i4xmeoXJwJZZsqyk/NKuYjV?=
 =?us-ascii?Q?XlseMw5ypmMIxyy1F2pUewiusgXUHAiCZKeJ2psfqU+Y2LzDmJh7oyDZLNgh?=
 =?us-ascii?Q?J3RfKgwbUGb0ZlW9/T2OhwGM0UMd3MOts/mwLmTBKxi5oENXdiOWKUi8D6c9?=
 =?us-ascii?Q?ZCJ3QgdxO3wXbWWPABMsUA8zAtWRBAJ9FtXO4wTNM9pFfYPpWdCsmQrPepoN?=
 =?us-ascii?Q?mTH7cBj+rW3SKugIo+dW0GcHSlcqduswioyWqGvdKv98OiUYQ1JBQtMHMeAC?=
 =?us-ascii?Q?VTU9zfMNzdlnalLQnpnH6SpHg/s6xag15wVaNIdYLgFg/3Dws8W9KDupt5p/?=
 =?us-ascii?Q?UOYEpxl37vgNaDmAg87ar/eaC75OdoQyuhQ2wQLpl0Xg8RrTAgDgbtdZEQb/?=
 =?us-ascii?Q?4oDxP0XX+vPTvGVXosRvkO3TTBDrwlvNNJSFtOGMDpQw1RH+s6IC1/FTfyM2?=
 =?us-ascii?Q?Y/rajI9ckhz3MOP+dhIcFPdtC6ZIIqCSp1U+5ccfPTld9BiWlIka2oCdQNHa?=
 =?us-ascii?Q?wxMUSOmzR2yUpIFaXeT+9NHid2kBK1h/ACxtEHWQaiYVgz0PZ98NqnGnjtvB?=
 =?us-ascii?Q?AgK4BxehuiKP4NB/cN+FGS9m5CXTM1pVbDuGmm2qYe98MIbfFv2uSVUUtdG8?=
 =?us-ascii?Q?zVN6bugC8Zi286VVjvIEFo3wTrO6enk/+F2ARrg27H6jdKQFDZqAudi1LeyE?=
 =?us-ascii?Q?ctyRNda/ujsqHo0FsPNotDI5ShtnT6yUOFfG4aFeG88iI+TCwGqiaCQQzdIY?=
 =?us-ascii?Q?ulDkJ5/cVfZokulXX0mkeknUivFBpp0oNJPsc0h5N3U7jYw0OmQS1/VCrawe?=
 =?us-ascii?Q?amvDbHkWXR9mX2zcEHmdbYNUAO+2vMCrYDRGtopbMy93Fcu9Yif03VjvSbnI?=
 =?us-ascii?Q?BWLkClT6paN4NYsKsehdvVIzXaHJNf6NxiEEJXX4Xelc1xBb18i8j4d0MFX/?=
 =?us-ascii?Q?i+NHyQa+DhOFpdj54Ii5xOz50duLwF3L40RloA1M204bXABMPihWsk9Se/5K?=
 =?us-ascii?Q?+6SCyCfrpmHK7NNwE+EsInkfObeb1eSxRkWiEZAsK/4DJYqOvBeT3jfwjb/D?=
 =?us-ascii?Q?vOLvJ/iCgb8xAS60rd+L/Rb8G3G5iZ6NsTcLMRhiUZ2dCLSV/yy2PBK6XCCt?=
 =?us-ascii?Q?VaSntHwdTA569N8T3Vv4ywyL3wWtV3YJiVQUC0Zx7dFquKLSqT55HTwg25at?=
 =?us-ascii?Q?gtHxG6D7hXGfNDkXb/CewaDDwj5jlIK2pC8m0oqF5Cec1x9ogtunBqb89euw?=
 =?us-ascii?Q?Cd5SA/TOi8ZNT2EQcZCO/yIJyksXuJDTNZTQWsjQ84aRPkLuYMyM6hIvBC+g?=
 =?us-ascii?Q?hgbWa7ErW7gGqZqTgYmwfiEWMytTEeHruDMdTXBsbiJuJdRMNrGQ1CYcRlDb?=
 =?us-ascii?Q?WskgYw5Py7BlNGwWxb3EI/Q3JuThzaCbhTTZFdYBnz+yJNkodkETs3zAkKou?=
 =?us-ascii?Q?l4gPoTcGd7B2c08m8TcVbDmnv0yzsHWUbDOijClI9oct99dm2fqg4XTvMInn?=
 =?us-ascii?Q?4YQvShbXLVeWBq8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 10:54:51.7022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eae9652d-1f02-4d82-0ce2-08dd469caed6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636
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

When registering a new PCI device, the device->name field stored
the user-provided string from devargs (e.g., "08:00.0" or "0000:08:00.0").
This approach led to inconsistencies when registering new devices.

This patch fix this issue by saving the parsed PCI in device->name,
so when a new PCI device is registering the name displayed in the device
list will be the parsed version.

Fixes: 23eaa9059ec2 ("bus/pci: use given name as generic name")

Cc: stable@dpdk.org
Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 drivers/bus/pci/pci_common.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index 1173f0887c..70faae4e44 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -99,21 +99,11 @@ pci_common_set(struct rte_pci_device *dev)
 	/* Each device has its internal, canonical name set. */
 	rte_pci_device_name(&dev->addr,
 			dev->name, sizeof(dev->name));
+	dev->device.name = dev->name;
+
 	devargs = pci_devargs_lookup(&dev->addr);
 	dev->device.devargs = devargs;
 
-	/* When using a blocklist, only blocked devices will have
-	 * an rte_devargs. Allowed devices won't have one.
-	 */
-	if (devargs != NULL)
-		/* If an rte_devargs exists, the generic rte_device uses the
-		 * given name as its name.
-		 */
-		dev->device.name = dev->device.devargs->name;
-	else
-		/* Otherwise, it uses the internal, canonical form. */
-		dev->device.name = dev->name;
-
 	if (dev->bus_info != NULL ||
 			asprintf(&dev->bus_info, "vendor_id=%"PRIx16", device_id=%"PRIx16,
 				dev->id.vendor_id, dev->id.device_id) != -1)
-- 
2.34.1

