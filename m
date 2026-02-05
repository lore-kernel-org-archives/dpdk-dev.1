Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC95E9129A
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 09:22:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B0794026D;
	Thu,  5 Feb 2026 10:22:30 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010018.outbound.protection.outlook.com [52.101.61.18])
 by mails.dpdk.org (Postfix) with ESMTP id 6B85240264;
 Thu,  5 Feb 2026 10:22:29 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rR/ZSLoONUoPY2smaKTJzZYjrMSO6RKmK5ohDiZHvdqGN03fT0zCO5ta2LLC6FHrW8PInkllCsVFlFM0BTfzoVkuQ30OOG0s3frZ5niOVNme7V5fXlm1XLpFCBAmLg1ZfwjzoHR0ElrmqvqvyWSfJBsuDVlfKnu3ZXlEAJLZcQOtmBh4sSVd4XRC2FYMMnm4G/lNBNE96/FidClCWPN8u7mI9sRNQ7UwsJUj4Zp7DkfnOEDt6c3nOTX6sGaNYLoiUafNQUIpBLQ+EiAQM2s0prHB/B4RqtcYHMsJffapko4kTJrZs4jdpgh8ECnhrCBb60Rip78bJ/P/H+lTgANPvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HctG2vt502lJZRJPzFsI4Tep8Jd/tENU9jLADz8iZk=;
 b=pmEFuTOgbuItILXKbTJFKW4jdx/jsZ+rTU4SNg0YH3yNogz3U59FryrJP/KYFOMVlTcfupaYUQ5irEDiG2sZRWyAwd0xGRRwYbxnbabnISBe77Jzw3vwgHsDBlquzpfa6zjXjs5ZvnD3hOWMb1LGxubvrbFHPjNgi/cNEYuw6vFA5u97nApvzuAkkijq3LBFZa9kYLpMT2/gEbafEBv+oc6ftTRd7D6y8Fb3dAEGpw5sjfvOGbvc+wwLCigyZ1at1KbR0UDzFnIE7apg4QPQxquT2PZyEBlOA2Ar8OE55xZ+VoT+DZhmGD9VNaH9gQ8JtlsBmOxCnOPPJe38AVglgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=wirefilter.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HctG2vt502lJZRJPzFsI4Tep8Jd/tENU9jLADz8iZk=;
 b=UWEvOyFWPGMTAtthQIqhxCmyn8Aaj4tqfcNrweN0XrCj5803W8Lf+vzKfWADOc/LZuy3ma8ySYj0zmLIPwzLVQ6vFjLrxH33xaoj5I3+SJd1qUANOvtGb3DuUGwhlt0vXdkr+ZAc4+529ZemJt7cz8Gj6XWFIt9Iffnqo/jC9USX+ZY2uG2E3UZphV6FlkdnpRbMyCjJXFyxLr/vhyGy6gVl/qGX5lQp31hsffiCzRBBSmya9SjZxr05eiucohLnniQPTBRjlTtiTBIDOXFR/+bPah886bJxE+9v3PBGcqf/mZv00X9UHKqJsH+8zhQmsfAwA9ahhSuOGtgt5Z65KA==
Received: from BN0PR07CA0029.namprd07.prod.outlook.com (2603:10b6:408:141::11)
 by MW4PR12MB7384.namprd12.prod.outlook.com (2603:10b6:303:22b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 09:22:23 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:141:cafe::8e) by BN0PR07CA0029.outlook.office365.com
 (2603:10b6:408:141::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Thu,
 5 Feb 2026 09:22:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 09:22:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 01:22:07 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 01:22:06 -0800
Date: Thu, 5 Feb 2026 10:22:07 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Mohand Alrasheed <mrasheed@wirefilter.com>
CC: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, <dev@dpdk.org>,
 Raslan Darawsheh <rasland@nvidia.com>, Xiaoyu Min <jackmin@nvidia.com>,
 <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix HW flow counter query
Message-ID: <ylp6wkn4b4gg5ynqjcy4ocatzdve3dgginlsiiythdh4qgjj7f@n6nevrprcdkh>
References: <20260112172324.1523241-1-dsosnowski@nvidia.com>
 <24903824.20108042.1768910753339.JavaMail.zimbra@wirefilter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <24903824.20108042.1768910753339.JavaMail.zimbra@wirefilter.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|MW4PR12MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb42588-6d57-4f7c-da9d-08de649811f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qD9/BATi5MVqwbN2bf8rJiFD6qX5t9/OU5f3uq2gsSB4s8cuOvmWLNlZ5WgG?=
 =?us-ascii?Q?gLDbj7yTH6GJDUSNpBieAhsMpTATEihfqZU1epmDIS67RB+GQicyvLaY2lII?=
 =?us-ascii?Q?P+EQkFf33rxrW348k13TzWFopMbA6arsg5HfOuvO5yYG65gfKZEhHKA8JVFK?=
 =?us-ascii?Q?HOjPB1ujXM6TN+P7qC7NEAwyCDQztf3bif1+KRSqelPMIBiuw9BUTQ7psPsO?=
 =?us-ascii?Q?Wmo2HIeNoemQ6lh2ANmq9x73puBPzZztXmXNXSlNaMprnuEhae1EELO3wapx?=
 =?us-ascii?Q?eMunnMsk41czZtSAiGD1SMhGbuCjVnrdT3zES+PY85bC3KpWrvO9hhv2OHg0?=
 =?us-ascii?Q?JLqvizXJrUgfORYwradaKEEfZTB8QROPfjQjYIy7Ejn/vWIFPcslKB3fd8FC?=
 =?us-ascii?Q?FJHNR3vRn63uW5H8wOKf7fSOFQBb9/FpQIjpPNl23/CCGfglvLLcN4Vz3h+i?=
 =?us-ascii?Q?pplM5dWVLGPveyjWW6PFo6pcjml/tDW2iDyJlptZeeA9ywwt++ZSO2filnvr?=
 =?us-ascii?Q?Ckg6oLBs4oPKaXkHwwF8XSOmuoSbm3Rr3qZ4pG9lsyY+g1E4RLqtJCxfUeGN?=
 =?us-ascii?Q?/4Jhum/zVXLNIJjE70fRaqWQWBVBhxG/CYmUy6iN4Ox/1K/zMg6pVI+x824t?=
 =?us-ascii?Q?sU+qSQZxt8UL74GpzV/wSnMnNsk+zOHbKRpQCiXkQ1+85qig8EMsnZpt5CMx?=
 =?us-ascii?Q?BDFIo/wDfRF0NRGr8azztzINAl1aoyzTZEZGC/12mJo2OzDpPbV/Dp4Of65F?=
 =?us-ascii?Q?zUwaYmWgWm8G6GiTj5NxmEj6NWI1LbudA3sdKVA7blrGA0hI/X6HYLLsF1fn?=
 =?us-ascii?Q?l/HNWrmxFaHTnylietISMNbgrSgVRD2SYhBE82RaSGkh9v0jAjDbK0yXdfdl?=
 =?us-ascii?Q?6HK5NbKgr2+jKKwOcuDNt3A5xcvL1+8vk16QTmgh0Weq7bX65E73wVecxuO6?=
 =?us-ascii?Q?vqWgDPWZdeRNVZBcWDvPH5oBvrwXWPfyiZI2sTgPX5FHpDZHZ6uIpmvaBph0?=
 =?us-ascii?Q?HIRDP1odWBbjl3aWTQjIO4w0DDt8gaVEEA2keMN5DRQ/tjj+FxNUWM4hV5JW?=
 =?us-ascii?Q?HkScR3A0UVbBWZfkVje7ZAG6QJ2ShoA9AQl7GW4xDDtnUVCbiZ5mAeNZG/pR?=
 =?us-ascii?Q?SVVaBDd4r+ML58L+rRjSoD5wen2fSvTCvLdxo23eygau9gRtNtwndSu345jq?=
 =?us-ascii?Q?WdDpVqIri1/w6a062QiG91Z4fjz0pzEoI5YIyIccHA03tOb6RHaD/GotaW0Z?=
 =?us-ascii?Q?sI2P2PfNZagUql6c6bX2Q3cJLY7kSubpiJJeKmXKx/jsGYtYlfc21n1BjkK+?=
 =?us-ascii?Q?liw282aiaNqF239ADNxBXpxk+Pua/lpmW3gQdmdkgDlcA3gofnwT+JIrefwT?=
 =?us-ascii?Q?wz07Qx0TvNMZjZlgLbr8ST4FV4OG7xsMsQ0FWk1zmlSnIigHpoYsR2eXT3w/?=
 =?us-ascii?Q?yn8/SQcGAOILTV98JbfjCh5XSPDas0QndL48QJj+O2jq445BbV8zFZdmhnaI?=
 =?us-ascii?Q?LrhuxDClo2UEEBJS3bedvC0ylhWWcN1TCf4tS9tifSIL9EpVSzs5l9H3RaMb?=
 =?us-ascii?Q?P2E1QM7rt+ZM1MNWsbWu2khBhicGPDyL49PgnmB/Qk8V8TiSuFYRMnCJzTpR?=
 =?us-ascii?Q?DrAzgQ8+/Jk5qHCoTn1L5thOFE/RdmX5fdD+oli8f1/RVs95nR5BPreAZJoy?=
 =?us-ascii?Q?+aTbjg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wA8XkAxmHkYxJtw0+mrSdFIdWnHIefaG9b9gxoxz2wbOzvnNhyRN14CP34HX8hb92aU0RwsLoIJC8w1CkmNH+D7wVNNj+Ej3f+nLQgZaq7MZ3ylmbLUXs75r3L7Yu8X2Jto1dTDRBR1ZEDq49EzRhxwiYZ7Yv5y6HLShs0ZIz0LI2hSEOP0I7CSKLKvVlPwwxAijp+FlJl9c1ttFQ2Yp/DdzZ2EtGuWqARw08tHbv6DmLu0ql2w7XmUWwUDV+ynOpPlU29nuLMPrBS2cD7Hf3Xkw+ztwiVyBmp6tp1UvFpHIMUVIy2ffsAtD6T5tTLL/rMNJ+MKzBJ/Q9/B6T4zaC0dDioHdkZYR99yBWwZc4zOwMASF3Jfvn2KAIav1BfVz7xqOmJYtsgyDAS8TSDjv92/4hKh1jvYU/NFecuq5g59NGN3lUME7L4iWtp8jbnl2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 09:22:23.0685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb42588-6d57-4f7c-da9d-08de649811f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7384
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

On Tue, Jan 20, 2026 at 03:05:53PM +0300, Mohand Alrasheed wrote:
> Hi Dariusz and Xiaoyu,
> 
> Thank you both for identifying and fixing these issues.
> 
> I tested the patch locally. Based on my testing, the HW flow counter data is consistent and the issue I observed is resolved.
> 
> Best regards,
> Mohand

Glad to hear it and thank you for the feedback.

Best regards,
Dariusz Sosnowski

[snip]
