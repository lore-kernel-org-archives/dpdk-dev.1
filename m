Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02072CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 18:15:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCF9240264;
	Fri,  7 Nov 2025 19:15:43 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
 by mails.dpdk.org (Postfix) with ESMTP id 6E81A4021F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 19:15:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAWjBLkJs01fyseyhCwt2b8tzV7uEXrpi8xNo06UsPO4K9+Yf0HA4vciISCMdYlP22mIKOlDI/q5pJjMlfzax46Ef5Z463LUI32O0hjVTYcEcuGJq0AiS2ucGaNIKiiaukzGa7QPCCR0whYV89qYB4vqQPVMcFsIU81Y6lklSKTt5oL4QEdcxVX0TYPRJ7e1L2br2z4hWj4TdFho2s9kapyjxXoSO+jB08H+y8VgiIcN0Al7VIN1VzPCa/2tPGO9Kjj5yms7m9dThWPD0rrO2itjwWD/BmAqKB5hIIRPj2bp2Ip9/VeutnFutrbtp/ksgBQRa4JYKJ+i0qBv+jTF2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlqQxAHkr160RAOQhW80+LAxNSeBB5ZRHlQRsp56Uvo=;
 b=V58MDtl1w4jvo+20QrBSFri5AsfusTra7CLyFy3BaG4n9WnRNl2IqGJuISo88F4lfkuQ2Y/oqdNev8YtC9Cyc4waOsd4xDn43CHCmISrn92mgrEeT32uKKlcgvYXL9xmuZcv75eXKnJasPa8jcH6zDfhM/vXoQlHtbewLh6UhBA1SeQ0V79KhuiRs3aIrqUbogotBGUKmlBwTiPK934/X/xzLRcRsKCSm3MoBK9Yq8/KV5IGwYNPVM23rPfZMHCbqD2Fh0Ou/l2kE1PDcKJ9PNskGILlnuoZwzrgIIlATJIfNcv6IP8vh1Put3EN6EVRF+nKUoj82Eo3Mn3mXIG/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=cgstowernetworks.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlqQxAHkr160RAOQhW80+LAxNSeBB5ZRHlQRsp56Uvo=;
 b=EG3C05k9HEWc6cwGuHXtdaUSRHYQPZiEpO4GaZNzX+X4/yPtP1nSkpS8tHR8wV9V0ZZVCWySL31gvLTq7hws7SEus69shqmlBH5esUnO45XMrYkE/QeU0JT37VPTVv/MPm6w/v8LMFcXQjT0vyFBelcD6T3xbVwECaWSTIR5njcLVI1eLhwqxQEfRuzes66rq8v/MCvavwZET7RZJqHU5SWiUpAi1THdaQfeou91MUv/7aoDiI42k/wwpGwvMqr3+SngKpsZ6iC8aTfJ0xz9+w5hGZ4RNqZUwVeZAaYM157trTYMLAB6P9677P7PnCedHipRryr2tW4jea+/b2dSig==
Received: from BY3PR05CA0024.namprd05.prod.outlook.com (2603:10b6:a03:254::29)
 by IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:431::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 18:15:38 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::13) by BY3PR05CA0024.outlook.office365.com
 (2603:10b6:a03:254::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.6 via Frontend Transport; Fri, 7
 Nov 2025 18:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 18:15:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Nov
 2025 10:15:16 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Nov
 2025 10:15:15 -0800
Date: Fri, 7 Nov 2025 19:15:08 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Yogev Chaimovich <yogev@cgstowernetworks.com>
CC: Maayan Kashani <mkashani@nvidia.com>, Stephen Hemminger
 <stephen@networkplumber.org>, Slava Ovsiienko <viacheslavo@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix transceiver warning when not exist
Message-ID: <20251107181508.xkcfqpb27htzpbbv@ds-vm-debian.local>
References: <DU2PR09MB5486574FE72A43A09A323DCDD68E2@DU2PR09MB5486.eurprd09.prod.outlook.com>
 <20250520114904.6570827f@hermes.local>
 <PH7PR12MB701839586EA3DA18CB3E3D45B26CA@PH7PR12MB7018.namprd12.prod.outlook.com>
 <DU2PR09MB54860A76C9E7A1CFF4A00AF0D66BA@DU2PR09MB5486.eurprd09.prod.outlook.com>
 <20250626113617.fekttwech4w75jqt@ds-vm-debian.local>
 <DU2PR09MB5486CBB7ADC2068692C28DA9D67AA@DU2PR09MB5486.eurprd09.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DU2PR09MB5486CBB7ADC2068692C28DA9D67AA@DU2PR09MB5486.eurprd09.prod.outlook.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|IA0PR12MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff934bb-1d6c-46f5-6400-08de1e29a6e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dq9qZ+5dXIDpWWs6zHvD1yunnUwoGdbkydk2t+SJA5bvmU1yy3D5rrCsEoFv?=
 =?us-ascii?Q?WDDYgj6rvErWKi8tKKi7keM/D/4iZKe86Fk26VuYZcB6lG9WOmQ9CiM6uHQ9?=
 =?us-ascii?Q?Jp58WFb6OjIe89hcCZjebYJ1IkEgN5iructSBw4RrEq/CGlee5PxFj21UQvw?=
 =?us-ascii?Q?ch3kO0sJtbFhcPissmrChGz1wYa4QEacn3k/uE+iaVnEb4o2WjtrLsRZdYdq?=
 =?us-ascii?Q?sjyNgj3mzrnqFtAvu/BWuxaXZewjfrwVvIjawzicGo9OedyPfBx7mxtvSWKE?=
 =?us-ascii?Q?t+NnGQ+Dyri63yYQscHZHq3PQQVDxVm/bLl4IxfNVslS8PwzQ+ITSe8q1s7V?=
 =?us-ascii?Q?EBXbvIOV4804IKwyHLzBdgT+IRc81Zg9lg/uMbehfcGB0GOKfMhH7fjRMic3?=
 =?us-ascii?Q?aRi7CQ6uk2qrRN7BTGxIans1SvEkwoLelS37jJWYy0r9wgooMVV0s9Y47vHD?=
 =?us-ascii?Q?k1bCzp/LczG8AeuPlzCpAgk0i9Jtkht6nZ2JLvTeSZ+DfqCtJUPulFhqt5CG?=
 =?us-ascii?Q?3PnLv9KJZriOFvbvlORFXBf7X3ycQihzS1WcS1tipN6R6dhkbaYD2HVx21fe?=
 =?us-ascii?Q?vw8UPjyVrf4Pi1Xr2NzYSzUo9AVonmmgeo5KMEN26sJiVDmEUMEjPCefIydG?=
 =?us-ascii?Q?Hok4a3tLuyDLAUci/N4WrLFbITbjIpXZCR6yme2gDlOfqNvd2RUzefMrPBbT?=
 =?us-ascii?Q?nLK1lhE4qVQuDHiXlej1iXSdnYy4x6oZJ9bvpLjSt+hkiaz6icIQhKoZUULn?=
 =?us-ascii?Q?F21mGo6saguUyOkgtZUsbDf/Pw319EvCCDnNAsEo31WkxdPzLoN0H+5bjuk1?=
 =?us-ascii?Q?oz1d9W/X59cxSVDAb/5qmEl8NrgcQaDfLOyjWZzxvwkqM1rkWWowEwfVe+qE?=
 =?us-ascii?Q?05DB/ja4u4hqL3Byw8Rw6ebuXXOktFdcQKP0bt83aYU5Lp2X4lRzoSxLtSZ7?=
 =?us-ascii?Q?pqPYk1U2QB/ECRAMij3FSjuEuon/Z1E1wEyfBPHZGmaHx4bVEr1J7mFTdmYo?=
 =?us-ascii?Q?UsjOMvppr1UOeeC9g4bQ9Ds8JAHec8dIHXYPbT6q7h9V95aSKOigi7Ll4uzP?=
 =?us-ascii?Q?mIzgJcmjQdNPHo1NV9gFVljP7ECRg/xftiSx2oJ1juqIQRnXhWlqZ16oTKPx?=
 =?us-ascii?Q?fIJO1CPJmhiUkutuNy2/EnsFN4mlscTUeXdtP0S51vddzdgl6aRkAcw7+Z6c?=
 =?us-ascii?Q?Le6zs1MDTOMdcxU+YDmOzX5UhgwaURIWx8Ra59k7eghBEkdxhfVRYKEQvjzj?=
 =?us-ascii?Q?3OdPgAkLoI8tnzZRHH53nJZBzF11hqLS94zlZNJ7qdCH7VauTGzxtd6SRSET?=
 =?us-ascii?Q?/h7c6X/FiJr3niXBbqwpYTHrbH/qzCEWpdLJGJ3Zi7hjLCVe48M/4hlR/QZW?=
 =?us-ascii?Q?GoLW3RhhSC7jb/zqIA19NxZwOGZNySzxbOc7SmhAz69OXxBH3aIgadjDcGMN?=
 =?us-ascii?Q?PasjkpWpUW50fBFxNz8Q2lgymgRjqtgEiPqdpKoZst+mwIefOMRaSbQjMLV7?=
 =?us-ascii?Q?IwDjEWzJVZ4Zi26g9TfJnGKGft/N9ATl0gIr+5SVcLYFVU+WQJmd6+BlqPej?=
 =?us-ascii?Q?vm+y8+vqUoaoysKAXZM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 18:15:37.5316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff934bb-1d6c-46f5-6400-08de1e29a6e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529
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

On Thu, Jun 26, 2025 at 11:16:42PM +0000, Yogev Chaimovich wrote:
> OK.
> I wished  there was a DPDK function to verify if transceiver is plugged in or not, without log errors. Such as rte_eth_dev_is_module_exist()
> So, 1'st I would have checked if it's plugged in. Then I would have used rte_eth_dev_get_module_info().

I think such an API is a good idea, but in mlx5 PMD case, this would possibly also require additional changes
on kernel driver side.

Alternatively, if ETHTOOL_GMODULEINFO returned EIO, then in this new ethdev API,
driver could return that transceiver does not exist and nothing would be logged.
But still, the same kind of uncertainty as I mentioned in the previous
mail would be reached - EIO does not necessarily mean that transceiver
is not plugged in.

Because of that uncertainty, I think it's invalid to reduce the log
level or introduce the special handling for EIO as proposed
in existing implementation of rte_eth_dev_get_module_info().

> 
> The workaround is setting the module's log level so the error won't be seen before calling rte_eth_dev_get_module_info(), and set it back to default afterwards.
> 
> Thanks,
> Yogev
> ________________________________
> From: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Sent: Thursday, June 26, 2025 14:36
> To: Yogev Chaimovich <yogev@cgstowernetworks.com>
> Cc: Maayan Kashani <mkashani@nvidia.com>; Stephen Hemminger <stephen@networkplumber.org>; Slava Ovsiienko <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>; dev@dpdk.org <dev@dpdk.org>
> Subject: Re: [PATCH] net/mlx5: fix transceiver warning when not exist
> 
> Hi Yogev,
> 
> On Mon, Jun 09, 2025 at 01:11:27PM +0000, Yogev Chaimovich wrote:
> > Hi,
> > Actually looks like we're going with another workaround, so I might not be needing my original patch.
> 
> Could you tell us what kind of workaround you applied?
> 
> Also, I'm not sure if this warning should be suppressed on EIO.
> mlx5 PMD relies on the kernel driver to get the module info,
> and from what I've seen for ETHTOOL_GMODULEINFO kernel can return EIO
> also for cases other than transceiver not existing
> (for example error on NIC register access).
> So mlx5 PMD cannot discern between "no transceiver" and
> "other I/O error".
> For this reason I would keep the log and keep it at warn level.
> 
> > Also, I do not understand how my patch (not printing a log) makes a test fail - I couldn't find that test in DPDK to verify. I'm not that familiar though..
> >
> > Yogev
> 
> *snip*
> 
> Best regards,
> Dariusz Sosnowski
