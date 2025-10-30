Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A42CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 17:19:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 215F34026F;
	Thu, 30 Oct 2025 18:19:21 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010042.outbound.protection.outlook.com
 [52.101.193.42]) by mails.dpdk.org (Postfix) with ESMTP id F36FD40150
 for <dev@dpdk.org>; Thu, 30 Oct 2025 18:19:19 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7A5/UTdQFOJD/QUPMW/JtPokR09b7pv1kbSIhV6XIjbeSDJX7yfmL9YgFKz3qfzNGnZoJ3iTJzvUcXaw2BWYx/cIDGEHAKmFgILePmIs8RTUmsXSW9Mjthpj0xywEQ3mGpTqnon92Fzgp05i0sWUBolvgBTvUrG9ASG41I7lzegp7AivPRokQYfnwupAKW5lBh1EMRhNOkhcVH+CqxVrxrMrG53TjEmATzTACHub48NJ0V4cPFtKYirv9JDkm36itOAhesJggiOaH5EQrS0ken5nJ+lZusKcER3D4iJnirm/q/TYPQeosNbv0KclpQgBlyV4udr1HIVqjqyakVBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KBQHo26IJGJosPVJQJgsIgO116vHeBMkzTFXmQbCMw=;
 b=d1tpkSwbTMNLZg9n05LagQhoQjNnEvWVm1cPdpdTE9W61KOAz5gCc9pX7K9Y/ezEo6IUVw8lQJxjY8fFXq7Vm9mYpKm91aPwr07MjYAfzXACsk7CyZ0atxY/IjKEN8nw2+8jQ8FOc8YuxWBs9LqF10oHUPCf9vKbEoa6NN/DGG7yEx+mpHlP8ogN4R//47LzFKkVu6sMSboY7OhMXwx3jWPLaznmOVZYeH2+EIzwLDVCXlfBa7GF3m+9uAU2pRx/UrFf1aBBTEOGpNLKpUWvULX91k4TBQPKJLBL6XgE4D4FU1B344XnirYphFTRjbfSWX+GqWpr4ncygT1lrJBFsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KBQHo26IJGJosPVJQJgsIgO116vHeBMkzTFXmQbCMw=;
 b=QmDbjVDprSNGWwTwIviPCIY6zYWXT+LDitHbOtbgH2xPmxrOwp378ZDep5pvBbvmPQqxUD3Vt9+WpUQzTGtJck50aXvCZQff6w+Jf4BbX5M/b+RobO8vI7u4gioNAM0rmR5Bf+ybs1/hc4AH477eEXs1Z/vi+hT2C9IkSMrihrGAKDFaxsyJNevpodFx9FCApOJPq46jgIwHYKPO140jMxfy8/cLmw4hl+o1F2aTEocVFiTrH/cmqFMUT678j0oN3e+78oEPE44QHu26doGHCLgpmSbOHlgLlBHbSSpfNoRIPWlQzQf6ZLEcPX9AFAEb6tHXS3TZPBQ6jbzMaCae4g==
Received: from DM6PR07CA0082.namprd07.prod.outlook.com (2603:10b6:5:337::15)
 by PH0PR12MB5678.namprd12.prod.outlook.com (2603:10b6:510:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 17:19:15 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::25) by DM6PR07CA0082.outlook.office365.com
 (2603:10b6:5:337::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 17:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 17:19:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 30 Oct
 2025 10:18:59 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 10:18:56 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 <stephen@networkplumber.org>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 "Aman Singh" <aman.deep.singh@intel.com>, Shani Peretz <shperetz@nvidia.com>
Subject: [PATCH v2] app/testpmd: fix devargs format in port attach
Date: Thu, 30 Oct 2025 19:17:34 +0200
Message-ID: <20251030171734.320367-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030092016.226974-1-getelson@nvidia.com>
References: <20251030092016.226974-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|PH0PR12MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf2add4-091a-452f-fa7b-08de17d87388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CkeM7ZsxgXIkVI6whtfrGbZovvSkn7RFjKsr1yZcKORHGRZtKXvUqeD4B+JW?=
 =?us-ascii?Q?AAPnysb6A6cAxdn/B5/rsNAlbfPkCz8nAF5Nhl3skG5luPILEAs02v0ls2kk?=
 =?us-ascii?Q?hb0biT6LRcgx7Zx3/U1dZv+ccf5/tJ4i7KfCCI3V7BPqJ/+co7uhobUnYIg5?=
 =?us-ascii?Q?blK2Ds4wMRwui9bs6af6r+vka0FfEqWzwZqw0IP73g3JE5urf0jJxyUToPT2?=
 =?us-ascii?Q?d6P60OZSSP3i0oiJRPcl5F50D1Zf516enkHiDcaKfuzfIfFMOpGt+HCWdOkg?=
 =?us-ascii?Q?mUbqwnwt3mqb9b23ZOWT3E2YgE5k+4yXNFrlcP35B5b/7efJpPHrgNl81OuN?=
 =?us-ascii?Q?vWpZXdGLttJDN/ftgjLH1dgxaS7eOD571Lwn82OEJCJpv6zWwL9BurySFo8G?=
 =?us-ascii?Q?pHbYLiZMhQkiBlyaArPBI93/Y80EiDlWTBy7nTqEadNfc+irg1vlLrON7EUl?=
 =?us-ascii?Q?+LdSFALyh7CcLUEu8gOJGv7x3OuRWDGbicu6Z+idaJlBjFrC2z41DwAqt5bh?=
 =?us-ascii?Q?rHCczCoy9yz9GXqFwxWOV2PjMRHlNc9VfSnXmTsYZizgoSBnup0bc6uVgicr?=
 =?us-ascii?Q?+JL+peD8el1pbZf6MaCK7i5wjjbMsluZ4g49WS1CeaA1B+qKpvAC8wkzqRq9?=
 =?us-ascii?Q?gMSkEX1/0tqJ9Yhh1AfeNe90dXErGt7fFC0N9F/LkX7KGpBFofNfzGWo3SGX?=
 =?us-ascii?Q?i8mjQ3Q2YWtmoHfB0tYcOb+M9yQmvXDmR4AFB+kbQkNefDqtzjQ5zaDUq1Fc?=
 =?us-ascii?Q?geN9yBZi7hF+FR2kVbdqfsGiu3C2BItu3pAQhV/8IiRZKVXQuGsPX/XN4hJ0?=
 =?us-ascii?Q?I8UehEfqnKOnfP9B10MoCvZ4zg685Z3aLBHSCi1+3IojzogHCXNRFAFMtEr8?=
 =?us-ascii?Q?2EltFdR0/w6UbETnotxY8cuKYLebijLNt9mdwKJ5G/W0UXB/VMopsO2fZ9vb?=
 =?us-ascii?Q?pNA40zaP/Damp4vrg/J/oXuLrSQq3X47UgeR0ghVZ+RXI5n6dhVU31Zm1OUl?=
 =?us-ascii?Q?rm7g4ZKlB5BKT9bpwPaYabEiw+mR6S3Wro4yIyUT/NZDWi3bZ95npDnSnwRA?=
 =?us-ascii?Q?u4dmqH0zvfqLGIHMsgCdeHM9oJH4u2/NeedNS6ln1VNR0wwIVbkYaYZTuEhZ?=
 =?us-ascii?Q?Qn8atqx10jOsqzY6ujoiNfTzLa0TqbznZFmXIe2k723tmq0aSLa1GU/7hyvS?=
 =?us-ascii?Q?Z2NCMQL/Z96iSsikRhaH6FMAnvuYDwezFqgnzg2nnuIqJFla+vvAiPlzjy4w?=
 =?us-ascii?Q?aKPcIYP8SgZMEKvIGAiqqb6oSSR2YAttDdrAJFfDKwkMMnC/dzCH8JM34aIp?=
 =?us-ascii?Q?ZxgVOAYdpVn/W/kyc23OQxnwBvbVnCelJHrxerVNpQsn40ML9gbM19gswpuI?=
 =?us-ascii?Q?gqFibu4v8op/7fdIJjA51e4NDNItTBPGaQQB7vdfrHpBuxsRPNStXpUBtLDT?=
 =?us-ascii?Q?SgP99nwq+oeERmdfkCZ9Pg3zcxX7LVUt016/HvmSGmjjnmBtKULMUNJXQeFN?=
 =?us-ascii?Q?bvOp9iE0ElYWAIxDIUH5Y2ZpgKn+5kDw7Sv0bqzCyxPLZLeJw1WXn7URvStL?=
 =?us-ascii?Q?VUnummP2c2nOIkpsUdk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 17:19:15.0378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf2add4-091a-452f-fa7b-08de17d87388
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5678
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

The port attach procedure discarded PCI port devargs provided
by application.
The patch restores PCI port devargs.

Fixes: 12c2405989f6 ("app/testpmd: canonicalize short PCI name format")

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
v2: add buf_size parameter to convert_pci_address_format()
---
 app/test-pmd/testpmd.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 2360da3a48..a2280d38d3 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -3431,6 +3431,7 @@ convert_pci_address_format(const char *identifier, char *pci_buffer, size_t buf_
 		return NULL;
 
 	rte_pci_device_name(&pci_addr, pci_buffer, buf_size);
+	sprintf(pci_buffer + strlen(pci_buffer), ",%s", da.args);
 	return pci_buffer;
 }
 
@@ -3439,8 +3440,8 @@ attach_port(char *identifier)
 {
 	portid_t pi;
 	struct rte_dev_iterator iterator;
-	char *long_identifier;
-	char long_format[PCI_PRI_STR_SIZE];
+	char *long_format, *long_identifier;
+	size_t long_format_size;
 
 	printf("Attaching a new port...\n");
 
@@ -3448,9 +3449,15 @@ attach_port(char *identifier)
 		fprintf(stderr, "Invalid parameters are specified\n");
 		return;
 	}
+	long_format_size = strlen(identifier) + PCI_PRI_STR_SIZE;
+	long_format = alloca(long_format_size);
+	if (long_format == NULL) {
+		TESTPMD_LOG(ERR, "Failed to attach port %s - allocation failure\n", identifier);
+		return;
+	}
 
 	/* For PCI device convert to canonical format */
-	long_identifier = convert_pci_address_format(identifier, long_format, sizeof(long_format));
+	long_identifier = convert_pci_address_format(identifier, long_format, long_format_size);
 	if (long_identifier != NULL)
 		identifier = long_identifier;
 
-- 
2.51.0

