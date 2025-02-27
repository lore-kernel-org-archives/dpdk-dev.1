Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82450C197BF
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Feb 2025 20:14:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C38940B9E;
	Thu, 27 Feb 2025 21:14:42 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
 by mails.dpdk.org (Postfix) with ESMTP id 9D115402D7;
 Thu, 27 Feb 2025 21:14:40 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJlWcEPZEaNkgW4VQxM1Vnf/kfWC+Kf+z6dVbeup+fc+ZXRHNrHsY35Pns05mHpCnWmca/0EqM4CREkorhBljDZ2caBgxDghFOpTQlKN/YAtQQxt9a97otoND7iXydf0j5RqiD7SqYiNM21bv0sEhXBoGS6lr3+L0E5dTScpAfTRX1gUTtbCGfMdDEvwBbgXX1pM3vbKqtZRVEZbqVMLdw7c/B8Yba9YF+pZ/wvsAvN3XRPy6REtYGCl+HVlWXAu4n6svJXWZhGhyMm3SBv3Sf45mE75M33gXuRz++D6Wy1Bvqc7c3LsZTouCLcFEYwdPVtjT1a5+UW3s/X8x7RjwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qm82tQMgaKGsv0GQGIXCdcmGdds/ez130ZMdO/6T6aI=;
 b=tADVdZTopcQlbP4MdfCgN4s3mFEhfkGo4W925ugUC+KXe2Z/V5FJyT/HvffTXmtSMXcAHP4UPQleZ0+JJ/g/HW0cYLTKZzQviYkaC5HwLtl8VgWZIeH76n1wV5+oeqk+R2LPtIwNv/MgxDEXddbvaVN0ci/OyifTXA61le+DR50qNHfcov33T3cmC5MIFuDJlDkQ2vD7mcYW/aciUxzWhEvY/+XNeiU880O1Q/czrLOhAgfJhii3gV7a04YLZ3oILaOfFfq1QJa1cPO3W6LLKnpnqgewOyRCv4BqvV/wKFiVirsYMtSVv1chCt7kUNBOZeUcbaq6LI+OgO9NfOZBOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qm82tQMgaKGsv0GQGIXCdcmGdds/ez130ZMdO/6T6aI=;
 b=tSmyWdiBGrNBRDlYP+xeguDl3auyz9alDZmbFqEa5X4JK7auypIMLEFa5AE9nlIgPkCCKi8zt9dMTQ6804+CYEh7XZY8sQw8AypoWHVujA1lb8u9e0+a8+AnGLCu+mcuUY4m1D7cN80yVF/ereVVB8U0/771MyUJF8YpEQm+zFI=
Received: from BY5PR03CA0019.namprd03.prod.outlook.com (2603:10b6:a03:1e0::29)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 20:14:37 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::d4) by BY5PR03CA0019.outlook.office365.com
 (2603:10b6:a03:1e0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Thu,
 27 Feb 2025 20:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 20:14:36 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 14:14:35 -0600
From: Andrew Boyer <andrew.boyer@amd.com>
To: <dev@dpdk.org>
CC: Andrew Boyer <andrew.boyer@amd.com>, <stable@dpdk.org>
Subject: [PATCH] doc: update ionic driver guides
Date: Thu, 27 Feb 2025 12:14:18 -0800
Message-ID: <20250227201418.51132-1-andrew.boyer@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: a40d19ce-f6ab-493a-8f3a-08dd576b5b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bIp4StIdwHN8RBNkJcV7wUqXYiOGx/eqkD7wimCDSUK5qndYpSndW1IdRI01?=
 =?us-ascii?Q?7zWzgI8Uu/KncRrb+fVUBtKfpvwAMFRDHInzew2HHvn45NBbT0mms3WnSQj1?=
 =?us-ascii?Q?ZprUhy1ZnX+LvOXhi29T2eKG4icFEnx4AZJeqpLUgCiMaeYFoubo4tU+MLpm?=
 =?us-ascii?Q?XxPaaXAoxB+MfArhD0/X6ikALY261NjjhzrGgEGG8Az//DZQvCEw6Q68/TYB?=
 =?us-ascii?Q?qzWWLx0kBt7MX0vM9vIjKDSWuE9XFXz7jz42V+eYq99VwUbrlMnVbHdySayi?=
 =?us-ascii?Q?oAr51vPBMX7QPST5ligcMWC/Ee/sMsdKyehldZC3k440SoqbEFW7/EyDAuu7?=
 =?us-ascii?Q?AMUJg7/3n1PsWV7OI2EZsj3LD269v4k6G0KDrOFnTPaiIyjNrieVh1wkhC27?=
 =?us-ascii?Q?AeXW+9UtT3DGyMNg1QOXFOWmi3grs7Xoe84G+kXKtK4u4kjI8WUCRz63TMCJ?=
 =?us-ascii?Q?5yQwyyNL+7bhNZ8lC2lUwQC3idwVltkuQ87AonQ4KZl4SsbhVoC3BuYmrWkD?=
 =?us-ascii?Q?ChHQHxm7ig4l7BvbOvLfWJ9mTooI64zpTZeCQghCiQDcySAr/VUjUFQxwzUs?=
 =?us-ascii?Q?X0tKjalaLzkNkTPPPzrIz+CRBvjFUO2f+cjso+jhXc3QJFaBnLMgy1T+MQuM?=
 =?us-ascii?Q?VqHs+TaOdTX6Gj43+KVOXu9X6MBIg6nCN8YUp918tKsQJ7KxZe4LalV66gam?=
 =?us-ascii?Q?KGBsgs7JxiLp7vPrtqarxA/ogG2RIz+mfyacHU8N35mmnPsvPQ+8/9gMnreS?=
 =?us-ascii?Q?STVyf5tNE3Yd3mb2pMYmAZhWyqk9ULAlYOwsLEaFOWozKi8g2nY/mXz8a0HW?=
 =?us-ascii?Q?qV40F8D+eVNOEIXgZykzIRvkswq154D0AKgy5vXF8hb4rxd8RddVo3+Z9Vuh?=
 =?us-ascii?Q?pt8aPmrMAmtokRhlWF67Doe8or/oaLWMIGfA4LLAodAoMhZ2yZtyoRH9MCQW?=
 =?us-ascii?Q?R6BXky8/Yh5XluyfKZ5BeB8Eq/Q5k7CQ1ZeH8RxIMa8Z6GDWUU/xtX2p30qT?=
 =?us-ascii?Q?raUfZojnj0jxJp2y5c8lB0R8v9c1ULx5vNkb5JtP7Qmy1pWx5WnaBdKBJ6Hx?=
 =?us-ascii?Q?42XjocMueABP3rku1aA09uWTcWxWeiDXs6j/WiFoNPkh2OuLGQinn3dXKthe?=
 =?us-ascii?Q?tjPvMhaMAUowm+1+j1farNC7fWbRrIF9ZW0DmOS+blg/p0JFVGhWt/dO+COU?=
 =?us-ascii?Q?/RFk/YDmvLDmZdLgG/poSb0JVFVGGrXqm7F7ueuHHzB5f7o8q+lOf9D9BxqV?=
 =?us-ascii?Q?ufTHka1fpARXxNTPP7QCto22E1FhxhyBwNT7BHBuesOxPDg0qjqzutZBM0+R?=
 =?us-ascii?Q?/OAA5KiqvmH7CqDkDdjlTpSERIY9g37HndeIJFG4Yq1yBhuzy6YhteQo+MhA?=
 =?us-ascii?Q?OqgHDZy+9U9u/Pifb7P1uVOC1M3vHr96q51APt0gNn2nWq5j2dzR+dstTXtK?=
 =?us-ascii?Q?GWWRAqXeJXBCOs3sdCGxbAXFeXx5xCZp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 20:14:36.4561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a40d19ce-f6ab-493a-8f3a-08dd576b5b95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813
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

Update broken links and add a link for the DSC3-400 product brief.

Cc: stable@dpdk.org
Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
---
 doc/guides/cryptodevs/ionic.rst | 14 +++++++++-----
 doc/guides/nics/ionic.rst       | 18 +++++++++++++-----
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/doc/guides/cryptodevs/ionic.rst b/doc/guides/cryptodevs/ionic.rst
index 2641835f63..d563602ebe 100644
--- a/doc/guides/cryptodevs/ionic.rst
+++ b/doc/guides/cryptodevs/ionic.rst
@@ -12,11 +12,15 @@ It currently supports the below models:
   `(pdf) <https://pensandoio.secure.force.com/DownloadFile?id=a0L4T000004IKurUAG>`__
 - DSC-100 dual-port 100G Distributed Services Card
   `(pdf) <https://pensandoio.secure.force.com/DownloadFile?id=a0L4T000004IKuwUAG>`__
-- DSC-200 dual-port 200G Distributed Services Card
-  `(pdf) <https://www.amd.com/system/files/documents/pensando-dsc-200-product-brief.pdf>`__
-
-Please visit the AMD Pensando web site at
-https://www.amd.com/en/accelerators/pensando for more information.
+- DSC2-200 dual-port 200G Distributed Services Card
+  `(pdf) <https://www.amd.com/content/dam/amd/en/documents/pensando-technical-docs/product-briefs/pensando-elba-product-brief.pdf>`__
+- DSC3-400 dual-port 400G Distributed Services Card
+  `(pdf) <https://www.amd.com/content/dam/amd/en/documents/pensando-technical-docs/product-briefs/pensando-dsc3-product-brief.pdf>`__
+
+Please visit the
+`AMD Pensando Networking
+<https://www.amd.com/en/products/accelerators/pensando.html>`_
+web site for more information.
 
 Device Support
 --------------
diff --git a/doc/guides/nics/ionic.rst b/doc/guides/nics/ionic.rst
index e0eb1b5c9a..a991a2cf3f 100644
--- a/doc/guides/nics/ionic.rst
+++ b/doc/guides/nics/ionic.rst
@@ -7,11 +7,19 @@ IONIC Driver
 The ionic driver provides support for AMD Pensando server adapters.
 It currently supports the below models:
 
-- DSC-25 dual-port 25G Distributed Services Card `(pdf) <https://pensandoio.secure.force.com/DownloadFile?id=a0L4T000004IKurUAG>`__
-- DSC-100 dual-port 100G Distributed Services Card `(pdf) <https://pensandoio.secure.force.com/DownloadFile?id=a0L4T000004IKuwUAG>`__
-- DSC-200 dual-port 200G Distributed Services Card `(pdf) <https://www.amd.com/system/files/documents/pensando-dsc-200-product-brief.pdf>`__
-
-Please visit the AMD Pensando web site at https://www.amd.com/en/accelerators/pensando for more information.
+- DSC-25 dual-port 25G Distributed Services Card
+  `(pdf) <https://pensandoio.secure.force.com/DownloadFile?id=a0L4T000004IKurUAG>`__
+- DSC-100 dual-port 100G Distributed Services Card
+  `(pdf) <https://pensandoio.secure.force.com/DownloadFile?id=a0L4T000004IKuwUAG>`__
+- DSC2-200 dual-port 200G Distributed Services Card
+  `(pdf) <https://www.amd.com/content/dam/amd/en/documents/pensando-technical-docs/product-briefs/pensando-elba-product-brief.pdf>`__
+- DSC3-400 dual-port 400G Distributed Services Card
+  `(pdf) <https://www.amd.com/content/dam/amd/en/documents/pensando-technical-docs/product-briefs/pensando-dsc3-product-brief.pdf>`__
+
+Please visit the
+`AMD Pensando Networking
+<https://www.amd.com/en/products/accelerators/pensando.html>`_
+web site for more information.
 
 Identifying the Adapter
 -----------------------
-- 
2.17.1

