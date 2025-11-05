Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAD9CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 17:50:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D252402E7;
	Wed,  5 Nov 2025 18:50:19 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
 by mails.dpdk.org (Postfix) with ESMTP id D40614021F
 for <dev@dpdk.org>; Wed,  5 Nov 2025 18:50:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUFUITFZTPBTJSyTw65pvYbI1VssMnSskrQMZcfrLcokBOq+BuntiZknh91pRaCBqd/k5Jvvfv6WLrCse7beaxKflctD96hGJIm7nD0HfdLJhR9vj7nbxLB9gr38bck+paVl2Iqmxz17K2npzgkpD9U4RbaQhenVrQhm/Zd7sBjb1KG77EVJTCZ/Qg2mR41pVRaLSZx1DNq0t41uOYwsOl5pViOQC/NSvCEfxpwT2TSAAy0OyiQ8bs46WaCF+EEyFG57IHW8GjmTbkM12w03VYRqtrybSVnChrBsQmt5ZSpyKRcP6ZvjXM+SHiX6XkZq5cTMOuQ1EJVE+SPTL0rO3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jansU25VXj9dPxRtQl6W/03w9MSLzkWYD6a54ADagWU=;
 b=gqoVdDupiHU8YKY8gU7hIpSJeAYQ4Dv+xUs+IBL+M1CDUhKRavLki0UiDjLUOsBNHL1wMwk5tZrTAjvS9Q7cQcqjCZlZKb9SQK1y3yk67OeRuGQ2Que6QC+GyXpudKBpNmlhdniM4bHQ19+j1nH0bBL53XdEsJ5UBGjQl5WimZ+cVNH7XiKGLVlItVUs8ndoocZmHTKxsgGS4kZhtqQLjT0uPX1yBtuI36gJMbRYjzq/GcV6itOJd81eg37N0hKjfeQN4NgkhioVnmrphvRmgGSIbJrejDKGMb0VlzfZefWCkFjVQ90rzJUcCrEPkuRAARev8XB4JkWiBEDvmdWuSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jansU25VXj9dPxRtQl6W/03w9MSLzkWYD6a54ADagWU=;
 b=LzStFe6UavWVMf52y4IaX9ZyEOoVX1Uu9xMpuNPb0vjJ/hjwRQSEF31QoaVBJn1ad3XsTFxP7CbEpzaaKW8iR7j1aynjngDuOzNl9CLBBuYlCQuD1OlBv9OOz92QSLAjvKm3AJVM5zu6ovtP6QJJP+qSy/qFXEaQPz4sbkDk9PfNIp53GE7yNvHplufkIHoYb3t9dJ26uRSD95xetsveqAtlaVDXdfVwubjJ1Yz+ikJ6FQOf9AAdHbDSlkjMb+BTs8vVXCUngVK3YcNsaAnPIudi7DpBzal7LmXpgYFrRoftuUQHClsup8JlelVsGHJPRaqIII8mBzTTZE//WzhlaA==
Received: from BN9PR03CA0348.namprd03.prod.outlook.com (2603:10b6:408:f6::23)
 by CY5PR12MB6370.namprd12.prod.outlook.com (2603:10b6:930:20::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 17:50:12 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:408:f6:cafe::b) by BN9PR03CA0348.outlook.office365.com
 (2603:10b6:408:f6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 17:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 17:50:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 09:49:55 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 09:49:53 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 <thomas@monjalon.net>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 1/2] ethdev: make representor parameter more explicit
Date: Wed, 5 Nov 2025 19:48:37 +0200
Message-ID: <20251105174839.323085-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028095831.53669-1-getelson@nvidia.com>
References: <20251028095831.53669-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|CY5PR12MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eba9b40-6807-49b2-f7d6-08de1c93c536
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NRSEORzGEdRKAwUVYmEqrzFZqNqSaQFZNnd2DFmAxG9NHG3ehLRxIK7ZkQ6m?=
 =?us-ascii?Q?f0i2OmN72WQn24k8DIJ2f5g/Am/M+D8VMJv+WYxllaKZtLK+rMRSpx671vVw?=
 =?us-ascii?Q?akR03N0kyDi+7v/5HXnMlZJ5OYu5fLT86wF1/Jls+yOElxengeZ94EPeXIGP?=
 =?us-ascii?Q?YNxzXYa9QrMWAFmK7TbxbsN44nRgLNXX6wnnPVbWwe53NrayKlKiIBK1Tkbp?=
 =?us-ascii?Q?SytOSP/CfmzLXVUhpHxFnPUQQoU8Ixzpodhr5crhENUO2wjyxQkG9SZqev4u?=
 =?us-ascii?Q?3IBo+76LXPkd6VN3NlJlHH3gEGwYEMhfICIFF0C+42ZJzGfsTJ0gl9C8YaIi?=
 =?us-ascii?Q?v9ULdq+B9NA7fsRarGJ0jZrzSI2hzYzikj+5YY1/4baRkqqCC8A9tEocRi5S?=
 =?us-ascii?Q?247XsdOFk7K6TnMyUhqHW7ALvEFDNJy5IzMXrnyS/Cj7BRdmSsxkPVSoSjsx?=
 =?us-ascii?Q?gC6S5CJBXMZ+CL77hJ500exCTpG3iCvGPO+Rpv3QukhuMIaPws5BI2HPG7Y5?=
 =?us-ascii?Q?jCy137h1LNNjCpuiP+9A5/gAmfnAMcjUu+WZSlynEvnaYxIpyuE1Vqv0Sha8?=
 =?us-ascii?Q?wDAQq/p5KiyE3eXXWc6fxcRIN0HDwcgcJU1BBY5FsGQs3jxM9MJ9PvI3dABd?=
 =?us-ascii?Q?+dCv6pkAH0/gh+ufU4AH9dW8C7XRE4BRfJOCbudQw8kHZYgF23vgYqpyJGau?=
 =?us-ascii?Q?IRac0TOhvzVZIJMngaaBxQ+XBBJ9tPN6K3LJJ2LlaYSuXaOwsvWjkJt85Bmp?=
 =?us-ascii?Q?9QQw5z5Jy0x7RpTFK3GdJt/xl6DC7s+VLeoROoqA2CRFM46UybsGmXIKKMr5?=
 =?us-ascii?Q?8Yha13husgv8ZqH5wrWl7DcSAlKG/E4dNIWNKnDBU7LB/IQpQzX8eMXiLQxU?=
 =?us-ascii?Q?AzhcmyvFCaxmUvebGTRVoYdRqEYaE9++TFsz3F0Ku2AaJVS/b69CMOUMhmDF?=
 =?us-ascii?Q?8oaGVa1VWkwsYdX8PIwd6E9yoVAutFfnYCzdojl2FwdkqV3YLmTNxDGCrRxs?=
 =?us-ascii?Q?nCidWcHGhS5gtFjSiDwRP/LQjeEBMhjZh16OS5Q9hNthFieSuZVuMhSf8rzR?=
 =?us-ascii?Q?2zIX2vGuZ/VsM+uVdURJKW3CAKmVe3DZG+JX+LC+9hmRIJVx62p9RRhP9gK5?=
 =?us-ascii?Q?D0XVfOzKY7s7RqVJpZjXWKOBc6iTdRynXHry66AzKTcgB3MT8g/HLMdJNYUO?=
 =?us-ascii?Q?J2MhJztnq7+LMWcZ+AFniZIq8HfNg7JUph1dZe5QHQbpFrOlEpxJBMBt+/lG?=
 =?us-ascii?Q?sMl9xudoWi+39vWkYOkpoEPIbMpkqCdC85d2fqLoxdBjdHwG5mhf03jDF00p?=
 =?us-ascii?Q?H/G5BfrbwdgJGx1rhMONtMDO/MJ8ueFe0aFkntzGPtvAkxl1W0Q5A91wrjgr?=
 =?us-ascii?Q?2yLnTeqkfusQcVyDzPyW3Ul7M7h/Gurqd8KmE7DjA4UsH5Zj0pCG5EYeBNh4?=
 =?us-ascii?Q?t3e9HGbVy/LweTEV9dJLX8Xp82BuIBfJrfo/v7/DB5xncaCSJ8R+GzpbN14G?=
 =?us-ascii?Q?CDsJKSA8Nu8B494H0xDHPLGyeGC6ja7abBYgWPA+iN/HZPNDuxLeuq2/V/wO?=
 =?us-ascii?Q?kuctybewrI5cZ1suBig=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 17:50:12.5763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eba9b40-6807-49b2-f7d6-08de1c93c536
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6370
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

The current format for a port representor parameter is
'-a DBDF,representor=pfXvfY'.
That parameter syntax describes port representor relative to
PCI device DBDF.
In that notation VF Y belongs to PF X and PF X is relative to DBDF.

The syntax 'pfXvfY' will probe 2 port representors: PF X and VF Y.
If we want to refer only to VF Y related to PF X, the parameter must
be '(pfX)vfY'.
In this case only VF Y representor will be probed.

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
---
v2: Add comments.
    In rte_eth_devargs structure rename port_flags -> flags. 
---
 doc/guides/prog_guide/ethdev/ethdev.rst | 27 ++++++++++++++++++++-----
 lib/ethdev/ethdev_driver.h              |  5 +++++
 lib/ethdev/ethdev_private.c             | 13 ++++++++++--
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/doc/guides/prog_guide/ethdev/ethdev.rst b/doc/guides/prog_guide/ethdev/ethdev.rst
index 89eb31a48d..daaf43ea3b 100644
--- a/doc/guides/prog_guide/ethdev/ethdev.rst
+++ b/doc/guides/prog_guide/ethdev/ethdev.rst
@@ -379,18 +379,35 @@ parameters to those ports.
    -a DBDF,representor=vf[0,4,6,9]
    -a DBDF,representor=vf[0-31]
    -a DBDF,representor=vf[0,2-4,7,9-11]
+
+  These examples will attach VF representors relative to DBDF.
+  The VF IDs can be a list, a range or a mix.
+  SF representors follow the same syntax::
+
    -a DBDF,representor=sf0
    -a DBDF,representor=sf[1,3,5]
    -a DBDF,representor=sf[0-1023]
    -a DBDF,representor=sf[0,2-4,7,9-11]
+
+  If there are multiple PFs associated with the same PCI device,
+  the PF ID must be used to distinguish between representors relative to different PFs::
+
    -a DBDF,representor=pf1vf0
-   -a DBDF,representor=pf[0-1]sf[0-127]
-   -a DBDF,representor=pf1
+   -a DBDF,representor=pf[0-1]vf0
+
+  The example above will attach 4 representors pf0vf0, pf1vf0, pf0 and pf1.
+  If only VF representors are required, the PF part must be enclosed with parentheses::
+
+   -a DBDF,representor=(pf[0-1])vf0
+
+  The example above will attach 2 representors pf0vf0, pf1vf0.
+
+  List of representors for the same PCI device is enclosed in square brackets::
+
    -a DBDF,representor=[pf[0-1],pf2vf[0-2],pf3[3,5-8]]
-   (Multiple representors in one device argument can be represented as a list)
 
-Note: PMDs are not required to support the standard device arguments and users
-should consult the relevant PMD documentation to see support devargs.
+  Note: PMDs may have additional extensions for the representor parameter, and users
+  should consult the relevant PMD documentation to see support devargs.
 
 Extended Statistics API
 ~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index db0b3d2c40..31674210fe 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -2012,6 +2012,10 @@ __rte_internal
 int
 rte_eth_switch_domain_free(uint16_t domain_id);
 
+/* Flags for rte_eth_devargs::flags. */
+/* When enclosed in parentheses, the PF representor is not required. */
+#define RTE_ETH_DEVARG_IGNORE_PF_REPRESENTOR RTE_BIT32(0)
+
 /**
  * Generic Ethernet device arguments
  *
@@ -2026,6 +2030,7 @@ struct rte_eth_devargs {
 	/** port/s number to enable on a multi-port single function */
 	uint16_t nb_ports;
 	/** number of ports in ports field */
+	uint32_t flags; /* see RTE_ETH_DEVARG_* */
 	uint16_t representor_ports[RTE_MAX_ETHPORTS];
 	/** representor port/s identifier to enable on device */
 	uint16_t nb_representor_ports;
diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
index a881e9c003..d332654f00 100644
--- a/lib/ethdev/ethdev_private.c
+++ b/lib/ethdev/ethdev_private.c
@@ -152,11 +152,20 @@ rte_eth_devargs_parse_representor_ports(char *str, void *data)
 		if (str == NULL)
 			goto done;
 	}
-	if (str[0] == 'p' && str[1] == 'f') {
+	/* pfX... or (pfX)... */
+	if ((str[0] == 'p' && str[1] == 'f') ||
+	    (str[0] == '(' && str[1] == 'p' && str[2] == 'f')) {
 		eth_da->type = RTE_ETH_REPRESENTOR_PF;
-		str += 2;
+		if (str[0] == '(')
+			str++; /* advance past leading "(" */
+		str += 2; /* advance past "pf" */
 		str = rte_eth_devargs_process_list(str, eth_da->ports,
 				&eth_da->nb_ports, RTE_DIM(eth_da->ports));
+		if (str != NULL && str[0] == ')') {
+			str++; /* advance past ")" */
+			eth_da->flags =
+				RTE_ETH_DEVARG_IGNORE_PF_REPRESENTOR;
+		}
 		if (str == NULL || str[0] == '\0')
 			goto done;
 	} else if (eth_da->nb_mh_controllers > 0) {
-- 
2.51.0

