Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655B7C79FA0
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 15:31:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 242D94067D;
	Mon,  7 Sep 2026 17:31:49 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012013.outbound.protection.outlook.com [40.107.209.13])
 by mails.dpdk.org (Postfix) with ESMTP id A304140658
 for <dev@dpdk.org>; Mon,  7 Sep 2026 17:31:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXwvDG367t9x2VVEVOepVViVWwHBB5baRwzi3mh4Kr4P1ts4jP847c3NAIdSDYjuV788sbNOQ4HcGB7YDo+hu/PRtTJNY/TLZKkUXyAgtg4A8223INn6/ec82JJIhzRKZekO6qIvOcvLO1WhfEz6bL02OqemIg3LxEj/3Fj7ejozWPV59Viw2/VHJIzVu9ljWNDCVHeG5UJfZbeEhxVejxQqm7WtSaXrq8HkB2UBO7RS/XyFCcrW3HGRTQ0Rq/wPytBHaprf6XdW40CqiCn1MDyd6I+5Eb/GollBN9ZiBM3kYZx3ZIVYaPmEmocnGxBqWlHfxHrtJ7yVh5x+W18yig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7H/rjEMG9pF031uT/iYrHPfWO5qdKD7bKOzr0gj/zTs=;
 b=X0AwR0+fDGZgBVHZXvrq30el2zdDMBKG8fnhWyLQFwo+IHunu9GLwSjudcGhs+WLzA/xlYZu+urR53JhfElHxA8FDkfplrOzxw+Z86k0OLriEt9HXxz5BrMPoZjoNlVYKCUaeX5rBGN3NobPSjmI46cyJpwnkf0XvMnGjlNOzS43d6ECWhUPwgADJKVA/JTAJTcnQsbMuJvma/KH8e58+WOPl4b8EYKOqzFQJCCvTgWJDSz1nfUYjbDpJRaH6qMXozykd2OUMAUoyWe+tWl23QO4xacwPY/pbVvT2aI5+sAjvrsCG5jzPXRbAubPqYuvufNlad7lFvB6GePSxeHdtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7H/rjEMG9pF031uT/iYrHPfWO5qdKD7bKOzr0gj/zTs=;
 b=EqxSWXJ17mXb+HWm3H0Zey0z9ufhw/c9r1dUd9esGVFv/LWhQzo85v4PYisNul10e7QKXOtmeX5Mhxv67dQTOZa84PAoTGcxrOoU5jZ+BleVWkG48IZJh4ME2PN/QDfJDgKPd6RAtJFjHhpyG1ftTZImHW1rFoYKV7K9+zg185LtX+M+xFL2pvx7HUGKVs8VNTU4fbt9YTzJ7wukgSKlv9H5ALeJw1YKJgNgP661arLNMYzNkmdfQ/GztcEgURZJ3bVAt0Ogc/GqFuM4xZUpt5awCjengT78LuHMfvNmSp3Wqo6mf55IWyNHoje5C8jJT68eOjC3gMRUUuy4AuKV4w==
Received: from BLAPR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:32b::15)
 by DM4PR12MB6184.namprd12.prod.outlook.com (2603:10b6:8:a6::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.15; Mon, 7 Sep 2026 15:31:41 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::42) by BLAPR03CA0010.outlook.office365.com
 (2603:10b6:208:32b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 15:31:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 15:31:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 08:31:24 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 08:31:23 -0700
Date: Mon, 7 Sep 2026 17:31:20 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>, Thomas Monjalon <thomas@monjalon.net>, <dev@dpdk.org>
Subject: Re: [RFC] ethdev: simplify representor info get API
Message-ID: <axbyaqm57t7ngjv2mrfnf4yrk4thrumjg5lbhrbqr3gwz6yzbi@ik3cvcxp5x4b>
References: <20260831162905.383162-1-dsosnowski@nvidia.com>
 <20260831094654.2cd73523@phoenix.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831094654.2cd73523@phoenix.local>
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|DM4PR12MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 62fad4b1-d766-4009-685e-08df0cf51d70
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|13003099007|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: EbHO9DHQzz04GPadGryM87TEeHBQQ+SYc8ZK4ZAPmUx6rwl7h/vQJ+e+V57PpQiOTDTbw4DlnyYQkyk/Jc0+5Xdsnxubi92/MZFh16Yr2pbXeHMDIk3BBjo9oOHYrzSOsL190FxkOn5j9uO8i9IorjwAB1ZxMLDSRw1S3u3xOwjMdL69UqfUzfpy+dmDrw371a9xk3g5NmEJj597KdTJf46bCCZYixsxYqY8uxiL5dXtqATN6Ino4cfLvYuVdB4RI/mUxLJwMiObl1QJT2lnb9STehVAid44zyz9RnSoslSTcvq+ta5uFQvua3tt0Hyt7Bkzj6W992aDSyrNZDlplTfJFEdakdte9EEnIpI5W4TiVOveskC0J8UqYNJr1Rl8fDLJ9fQ13bUDgS752uIlCDpYYSmS6V0s41JpYvr62XmVUBp5RabdlaFDCGp6drIplqMP/8bhWB6S/4QO/fgIE5HFtekOI0px0Qq6JQlahaxRT5+IWalFe3jDO8B5/4zWMxfQ8m/MYvbZI0kbCvo1tb8xcYUN+RGa1Z6vzqh0+L1Wsqaw5kytm0Z2aTCYsrUAz09ZwrrAP0KCX4DIY76I91zmFlEwV2037AUZMoJydvqciYMGT0Fs0IuMsI/WRbzIbOzJHWI0f9ZnvIeOZxJEq7NPAtxIuafo/PPGHyeajeeL3xRArnVKt+3C5jWxzC2SVD3kXOPQ73lchXet7k0m1A==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(13003099007)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: azDUs44nmiOACqHqBCOtg8ivp3MfzSyqsiQszeAt3dKaxdk6+uirNe7HEzCFaRjobbpw6rW9wIE9odYRWaMMAlOqtJZuKVf7dz7Ou3BDUqWGtE8MK1dg9tVliVAji/WQKFyMcrAgnW1fVZVkheK1mFZcTtjJPSOgyJwTZAw5iexyJuZtfTssoIpYR52EF/N9Y4m96tiY9Tkx9+CcRNGlBWkT2bqkhX3+QYj67LFmJk3JF2HTq3tg6DRuWArlL6gCCEKSOPtkCTwuiIJ+67o6pGUiGncPdv7AvdDbjSZhlnwktCuH7KcDJWk0gPsWIDX/Ri7aUUpSnT8DiNk3mEXiI3nlEpjJXWlU4nhT77MqmeGza22PNkyd2QL0xX1JW5JtjlIrTfCjbTlziR7tm/eK6YMRuIa2E7P55ohL7N7Ri4Gfwn7DDY8tMWUvlqvt1fPy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 15:31:40.8995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62fad4b1-d766-4009-685e-08df0cf51d70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6184
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

On Mon, Aug 31, 2026 at 09:46:54AM -0700, Stephen Hemminger wrote:
> On Mon, 31 Aug 2026 18:29:05 +0200
> Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
> 
> > * Background on rte_eth_representor_info_get()
> > 
> > rte_eth_representor_info_get() experimental function was added
> > to ethdev public API in 21.05 DPDK release [1].
> 
> You know the API shouldn't have stayed experimental so long.
> There is no good reason for API to stay experimental across multiple LTS releases!
> 
> The code would be much simpler if you use sentinel values rather than
> carrying around all the XX_valid flag values.
> 
> With int fields and -1 (or a named RTE_ETH_REPRESENTOR_UNSPEC),
>  the whole comparator collapses to something like:
> 
> ￼
> static bool field_match(int a, int b)
> {
> 	return a == -1 || b == -1 || a == b;
> }
> 
> return field_match(info.controller, other->controller) &&
>        field_match(info.pf, other->pf) &&
>        info.type == other->type &&
>        (info.type != RTE_ETH_REPRESENTOR_VF || field_match(info.vf, other->vf)) &&

Ack, I can apply that in the next version of the patches.

My only worry would be that mlx5 DPDK driver gets these values
(controller numbers, VF/SF numbers) from phys_port_name
exported through sysfs.
phys_port_name is based on devlink port attributes [1] with
the following types:

- controller number - u32
- port number - u32
    - Used for physical port representors in mlx5 DPDK driver.
      These are of type RTE_ETH_REPRESENTOR_PF.
- VF number - u16
- SF number - u32

Using int fields would not cover values
which can be returned by kernel.

What do you think about going with int64_t for these fields?

[1]: https://github.com/torvalds/linux/blob/v7.2/include/uapi/linux/devlink.h#L412
Relevant attributes are:
- DEVLINK_ATTR_PORT_CONTROLLER_NUMBER
- DEVLINK_ATTR_PORT_NUMBER
- DEVLINK_ATTR_PORT_PCI_PF_NUMBER
- DEVLINK_ATTR_PORT_PCI_VF_NUMBER
- DEVLINK_ATTR_PORT_PCI_SF_NUMBER
