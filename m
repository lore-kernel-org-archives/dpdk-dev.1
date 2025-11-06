Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6884BCCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 05:54:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 521E3402BC;
	Thu,  6 Nov 2025 06:54:26 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010046.outbound.protection.outlook.com
 [40.93.198.46]) by mails.dpdk.org (Postfix) with ESMTP id DD76D4013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 06:54:24 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1ZJgvcSlGUY4gq7Ns1SxistSyvxr0QgDR5pzjrpjf0Cl3LzF5P5c211Dc67/a9fdBEo4qZkqDJ1ROzRqWj+BUFrhgtVN7OYqS6sdYzgBjeGuNQa9Sn1cue5On0TxRdeCKjf2+z99K3maalVKw45aloJjlxYyowAtLq+ZPBx1pw9ihrrC7X2aW18wLtP23uEykcIC+n3CFC5vIzURy7HI+vhBKxdYg+dHCdjNNhY3c4mDbA1oASBc0NiFRGNVsMpoS08GH4KWvn06aordiG/ss6RqIgnawLIkB1ztagkoX0HFZVQo3PRNaeNeLl6bCllT03CVW93tkfgQf8Uzk/jpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBTahd/L2gzmM7bBLX+IihxryLE49yQQ8eugcTxTgO4=;
 b=fdDDDoOSMPHGfTqXazm3wZQdUdMsF0P870I7uiIFL3P0oFYLIpcDobi+j9tAb/tFXs5zPW9irucIrTL53da0h0DL2PIICZht2uIKlSp4n1aU8tD9XZk6RvokXVJSglzyIxSL7VBkbwc1XUhAx5pkNa4AUF1LZqZG9/vIJ25inSsenKGuRcHa4AI/rgnnmARQS5gciD1O9s7xkCP+Px4dzMBueoglCwuYG/8dHw/2g4Y0Gb+dzv0hdm+5RWDD8IpVliOFCj+dMBhR1ShxViBWaNJqBwbnMCby7PGh8P8G6Qibwql+TIUBZo37wxPoeBAcO0xu70v8AME8hdRNme6HoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBTahd/L2gzmM7bBLX+IihxryLE49yQQ8eugcTxTgO4=;
 b=coRbTOs6gSFxEs/5HXXcSdX4/ikHDPUSrrn7CwfhYM1ybdX8bWMhQOzpuPX1IaqtZLpKkNYDyShgGCL7ubjeeOTFmGAo2R9NPGA16bn7dD8iNhXlVhmJyj/Qq8l+8hDlfKozo/TYlHwtYzn+xKBE13UGo6/jFMcfCYt8LhVQWYBNPB9nGAOP0ueb/Hv+RjD8fU+LygAbOCVrti0qtMi90SivNXlJEFJ+BjlMuN5Bzv6MjjnEHjMneO/ySxckOFOWCGGFRXWyZWz4Yx0N2qU8ivN39R3lB7XUjgXq4ifUl9qKJ+wIQ/QNT+ZNu8v9E51AlPmYP6IKM29OxVVCyBAQdA==
Received: from BN0PR04CA0123.namprd04.prod.outlook.com (2603:10b6:408:ed::8)
 by PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 05:54:20 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:ed:cafe::d5) by BN0PR04CA0123.outlook.office365.com
 (2603:10b6:408:ed::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 05:54:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 05:54:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 21:54:02 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 21:54:00 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 <thomas@monjalon.net>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v4 1/2] ethdev: make representor parameter more explicit
Date: Thu, 6 Nov 2025 07:52:44 +0200
Message-ID: <20251106055246.360824-1-getelson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|PH7PR12MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: c606ea0b-669d-4109-6f09-08de1cf8edc2
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1uAgSrJmqfthYa94b+xm3y1yUsbAR0WTGJlYXEmRBf6zt672Nd8KSZpceDEi?=
 =?us-ascii?Q?xPcbMahX6vfZ6/OufPXE4kHBPMFNARgjasgTPSKywpnZ2osoE4rbovi32+Hy?=
 =?us-ascii?Q?MY8mbUW38XzWkYbQCBFO/kuW3k2WPbzE5WJGUxK2+x+0BQS2QoImFWcoL+x1?=
 =?us-ascii?Q?DEVoVVI/plra32D0fxQWqkBzJwRQKycFRLPPbHaeiEMmrxlqP0WDadrlI1IJ?=
 =?us-ascii?Q?6ccEp2QmQzoAI7LCmZLZksQQphh63U3qRWEG3iYpYXKavz8JQsDM/pItdKP7?=
 =?us-ascii?Q?oRAdx4fOKMEehcokopGTUzi/ttzs1it8TnpvYQqJ4aQqH+R1OZTJrSFcJf6x?=
 =?us-ascii?Q?1Hzm2c064SSHmgCwOM2XKqrdo4RUY88ONNUFIlCvVUxIOgHll0nj5Z7kB8Nd?=
 =?us-ascii?Q?r0UmHZKOH7/rQEb13vLDxpGm2s+IpgS51GIRDFjKaFH7sLYAABLBN7m/rDWO?=
 =?us-ascii?Q?Fnm2P7oGS1GfdHtat6PfLoC9pe8hZ8e1lnO41B+TOAei0qm6Egr+2NPI/FtU?=
 =?us-ascii?Q?yGWOFlXaADFhePFtN5ONrco9HKZWwo+GALibrj0S8dvnZqKrdL7x3KnZw6Bj?=
 =?us-ascii?Q?nbROwzrYJIvLOr4pBTYV/UhtNFK8Hb1lefbJ9yPk8v1P8J5i9EJ9c/aGp+7k?=
 =?us-ascii?Q?4h5gxu+Yylq8x7OyiX2fNEBIRGlqfWreQZOT9am2dKfHf8f5zHuMT/5azjxj?=
 =?us-ascii?Q?mzmNM1948K6/WL0FucnK7jg5XZ84hJey+QS2A0rcaFDTgXfisPdnX3SCcZEG?=
 =?us-ascii?Q?oxbH0LF3PgohKeJgQoosSJRyXDKRDXoyQwr2Nhkd6GfqWxlnRiVRd9w/BOhf?=
 =?us-ascii?Q?h3momelM7yPCkL95sAKck8vr6NXEImtSURxBJrTgn6RorDql9YlRVBbqxrJO?=
 =?us-ascii?Q?OtfLK+9a5wA0n2iZz9vEyUyuDKtsgu6zuSRCONC94IVf2C8PE9zC6rrxrx+r?=
 =?us-ascii?Q?Z4d1T5Nf2bQvgZXXqnvAHOj8U2w6ln+T5t9vnzD8FLqwNVoP2BFK5Trp5tzI?=
 =?us-ascii?Q?bLk9EP2/47nR7UHNvPJL6mmZjlw5adK77TVHWCqPBQPW6bwKIZSZBpV3A4zE?=
 =?us-ascii?Q?zNytDEdgUmdZ3Wxg2DvT+vF1WAR2S5wg9N+TvQ66mUAIycIMzVoQ6xj5jJ4C?=
 =?us-ascii?Q?OfAVBkkGjnIrC2RPMAWD52yyB7HVPn2w9JV+whz5ps5KLIJCTUr63V781UgS?=
 =?us-ascii?Q?BRgW7TBRvbad42vNs22i/mlBEyiykG9e4ySX7WUogoLX0+qJg7B9ImFVxevi?=
 =?us-ascii?Q?29sx7Eac+QnHtAduiOBJnKhDuSmCcH0P69R56JL+LejwVqFHiN/JyZ20ge3Z?=
 =?us-ascii?Q?6RluqDSMMb3uA7WE0oTkup35KNwahYVpszvDEAnS7KKlKFnloZu0XYO38zGw?=
 =?us-ascii?Q?U7OQSes1Q3RUs9yUDoc47XnjETxmIIzYBUW1oBhhOBrC13hijtLQXfjGhCH1?=
 =?us-ascii?Q?wpxmOSz1/h2u03nlVAqItRKlFV5Pj/J/lRIx+kgLhyIWULcqtFM+KRcjXj/k?=
 =?us-ascii?Q?dyM1I3pNnZr0dx5jNC22EUJSIj+ijTZybxdh8wSZ7Mr8O2xfKd3q+QOIxR4a?=
 =?us-ascii?Q?2CO+/+0V25Om8Yfhga8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 05:54:19.7825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c606ea0b-669d-4109-6f09-08de1cf8edc2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6978
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
v4: Rename devargs flag macro.	 
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
index db0b3d2c40..1255cd6f2c 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -2012,6 +2012,10 @@ __rte_internal
 int
 rte_eth_switch_domain_free(uint16_t domain_id);
 
+/* Flags for rte_eth_devargs::flags. */
+/* When enclosed in parentheses, the PF representor is not required. */
+#define RTE_ETH_DEVARG_REPRESENTOR_IGNORE_PF RTE_BIT32(0)
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
index a881e9c003..72a0723846 100644
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
+				RTE_ETH_DEVARG_REPRESENTOR_IGNORE_PF;
+		}
 		if (str == NULL || str[0] == '\0')
 			goto done;
 	} else if (eth_da->nb_mh_controllers > 0) {
-- 
2.51.0

