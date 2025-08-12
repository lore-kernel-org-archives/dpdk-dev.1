Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4F0CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 09:53:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 766A54014F;
	Tue, 12 Aug 2025 11:53:34 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by mails.dpdk.org (Postfix) with ESMTP id 454524013F;
 Tue, 12 Aug 2025 11:53:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhpZDri3FHmvrZ1YR+JKe1g/0I+pw/kMrPFtw/CJJjuFFqSFzSAgzOkRjrTQ107fhIPD1XzARHauecOZ8/5yLuDMHiN4szFE0EGeGtmhqetBbCSDxmOkkFip9XGL4zoKam2m8UNwEAZWyMU5FF0uC1L6g3hA6hdGRFt1p8LHF/BDzMRv3makzJVnQIqIkZt9mf+Zfq43mX0sqe+s2CAn3+YFIfzYJJJ16reWpTmXVzZbIU/wKPytIT49noh6MzBihD4Ac8O/zp5BrnKh2+ZG6LcoVhhwJwx+V2vONDNfjKspP4fz0Hvs78zJFCQ+qoo982Mzv6/cFLnpUKY3HUeI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XymB76Qbzjtn1vgjZVjCsPIdZAOWT88amJalm25ExVA=;
 b=mzv03ZEQNglsHFiQUechZYVPiFY1InyxYkNNgyEgl9bMjiw0h+NYaYpdXJ5mzw7Wm6EpWFfrsS8f6uzYFP6Fmo6wGOhwjzpG4TMkzvRN2UpG4YploY0FUPQYUuI3Ex1cT07rVZNepiSZmUut5V3X6ThbF4NQNFHDn4H09CAOYH2s4u65wuDPzvTFeqywSxsjhel1NMDAx5NhGpbu7FYdmz3JX2bPeHIk2EjawgXfXJPNw9XDdArLNgR76ArpjacW1+A46BlzuX6mlc5k6w0rkCK8jroLVBhoap2H95YDK/BUwyTrKDHWz4KpfB6MaO17BXajDPrshMziheBakVsMJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=uetpeshawar.edu.pk
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XymB76Qbzjtn1vgjZVjCsPIdZAOWT88amJalm25ExVA=;
 b=fDq1EpCv3WKvNUKmxmoy6+mL5S5uNmR89WlER9FoVUnE7I6gLYRvg1J+LdV+XW/9CaVeDFHJzRlGHRcF1ub1nXgW6ynlUzAmJ8I/cjwMdiP+MAkYn9o72HuC1SYWYRuKlfBRMK9sCd2fBR/E1NH5OEp4B/APpRnDMuigf7XQry+wLN7D0KSIvqkx+KVaOR7AlsFZIRd41uuPWQLdMO1egxWjNirJGXZHfj0x3/jLJzyKM6ZlH3nCMeVjvyTyu2YnCySNowg6vAcSGPuBL3q43rqlaqzBFmZC6rIDapqnHhOcEUgwa2qkO2Ry41iJ791/YGAgAQVklhrCe2NOhY9oQQ==
Received: from MN0P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::24)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 09:53:27 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::e) by MN0P221CA0024.outlook.office365.com
 (2603:10b6:208:52a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Tue,
 12 Aug 2025 09:53:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 09:53:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 12 Aug
 2025 02:53:13 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 12 Aug
 2025 02:53:12 -0700
Date: Tue, 12 Aug 2025 11:51:45 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
CC: <ivan.malov@arknetworks.am>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>, 
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>,
 <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix connection tracking state item validation
Message-ID: <20250812095145.qw3kl4vl3adc3esh@ds-vm-debian.local>
References: <20250808074738.2nqgorlqzzyf2jid@ds-vm-debian.local>
 <20250811062149.2489151-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250811151520.bonpjpefwuzuap65@ds-vm-debian.local>
 <CA++2-x5voCjMDXcO_jJw6vrmvtDzfPaAArABeAT9TGcVzXtoZA@mail.gmail.com>
 <20250811171834.fcyhsgkssyai5uho@ds-vm-debian.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811171834.fcyhsgkssyai5uho@ds-vm-debian.local>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|SJ1PR12MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e062803-0b2e-40ee-22c8-08ddd9861520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHZ2WnkzT3NSMTEyZHU3Rk1nZWl1Z1I1eGdobSt2MVp0cWZuS29LeXgyc1pr?=
 =?utf-8?B?NWs0TXFpNVlPdjBOYXF4NG9PRWVabjUvTDg3VzhBZjlJbVJveUxhUmsyYlo2?=
 =?utf-8?B?Vy9mM3RzRFRIOGQrbHBydDh5M2RrbzJXbDV4SjlReWtvVGlwcG5kWTF1YUI4?=
 =?utf-8?B?ZEs2QitaTHR4d0hqQjlzdjcyMWZucTg0NTRLZjdlbHgxOXV2dHNSVkQyY2dl?=
 =?utf-8?B?aXpBeHk0SGJ5bHlpa1RKbVVGdWpOWktQYkdmdStJZlZpTFpHS3NKRHZ1VDZj?=
 =?utf-8?B?bVdweWlFWjR6WkFlYXp3a3VtTnljMUhtRW52UHlVVzFXRUhKWWQ3Z3lCQ2Fi?=
 =?utf-8?B?Mzk1N0tVeDhGeXIxcTFSVXBQcDAwYVlyb1Vab0RZZWFZUyt2WTNFMVFka1B5?=
 =?utf-8?B?MFFMSjhDVDRRNWRZK0l4MDAzb09OS3dCZVdTcFF4TUhwNTU0ckxtRHJGTUNC?=
 =?utf-8?B?bjVucWVGRjNQUUdONWJEMTBwNmVQdVEzaWE0dVlvVlFHUjRTUXVyd2FQTVYy?=
 =?utf-8?B?V1lWZURSQU8wSzFlUTI1ZkcyeENvSDI2bHJZL1cwOEltbUdhZ0xRMFI3UE9Q?=
 =?utf-8?B?TUtORnBVV3dydnFKditzclo4U0Y4UWlZOG81azBtekdvNHZkaU9NZUNsVjNs?=
 =?utf-8?B?SU9iQzJablhBZTVVZkFQUmk4WTZvTmRJVVk2dC9rekZ3TTB6TnlWcTVpS3Zw?=
 =?utf-8?B?dUlPVzdJMnl6c3loU3pHbmtEOEVuYkkrbms3TlBUUHJPWXlPN2M5RUh6UUNJ?=
 =?utf-8?B?MTR4elhxQUVFTmg2ckNiU0Z1S1ZXbW1wcG1ILytDZFkvRzUrZWRHdmRJUVpq?=
 =?utf-8?B?RU93bUxHMDQyVFQvSm5hWTEya1ZvSmE2MlIxNVYwdXVDQzBCZnlmSEpTRmpC?=
 =?utf-8?B?c1JpL0hxS0dxVUpsNk9rMFBxYk50TVlFR05DbFVyYi8yYVYrbnRYQjJYNEFK?=
 =?utf-8?B?eWg5dWxrTlVFRXZwbTlzYlJlRDRCTk8yRjVuY254c1h4YUcvamo3bGtHNk9R?=
 =?utf-8?B?UkNTdUpzbU9odytqNU5uT3pjWUhXVjFURFZzbVdrczIrdEdkbE0zSzY3dmkx?=
 =?utf-8?B?UllkNnhGNXB6SFNLNzZQRHlsSFkxaCt6RkNUNEc5dHJXT2pDQk4yelp4OS9E?=
 =?utf-8?B?dTlUdnVxR3Nxcit4ZS8vWUpOUERRdXNIdVNuRXNhVUtlamFIOVY2WTZLanNK?=
 =?utf-8?B?RGNmbVcxY0t5bE42bHJuNWhjZkYraHRqMDBJRlNJNHZ1M1ZMUXROZHVGQVRY?=
 =?utf-8?B?NDNFL09xdzdVZ2RFV2w2dTN0NzJmUmNFNVMzRlVLb29aNzBmd2ZzcVVmRzV4?=
 =?utf-8?B?VWYvV3hDQTR2dHM1K0JYdzdHVHFkSmhHbVMwckxQaHgyUmNuUWNsUWhJSlVJ?=
 =?utf-8?B?MVJnM2I1bjUrSHJ5U0lPcXN2TGpUS3M4MUtXdm5XNldWR2F6YjFxQkM4dEdL?=
 =?utf-8?B?aDBDZDZhY2tKbjBJcWpXSkFnZ1ZPUzNQU2szU056UGdpM3FjNXAvelVtODlk?=
 =?utf-8?B?V1JKNWJ6eUU3UlgvNUFkd0FBeC9VNWoxcHQ0SDUvdDliUU5qZ2NiWEZDVys3?=
 =?utf-8?B?Z0RTTkh5UTVueDhhR25IVXFDeHNRVnI1WTVvVXN6c0pZMzVkWS9mdU5FY2E4?=
 =?utf-8?B?VzBJKzBWQ3Z1cWwzZDlmRU5DYS9qWUFueHdIbGdEZk1OVGFEWWJjWUhMbnZK?=
 =?utf-8?B?aXNROE9Ga2RkVGVKWE1GWmYzUW5WOW5WeElSOWgxWXVyanAvZFhueDBWNUh4?=
 =?utf-8?B?eXBRWVhhMEVxMFNwMU51c0JVV2ZYaGs0ZEVKUkFWL2ZnV1kvUE5LRW1wcVk2?=
 =?utf-8?B?d2VrTTVpSllaKzhaZHBEeGorTFlVbzlBZ0VlTTcyL3U5bVdMdEFNWWNvNmNP?=
 =?utf-8?B?UUI1czZNM0hJb28vWXFFaE0xbURwMFN5OWlaWVVWOE1FR2x3RVQzcGw3eFBC?=
 =?utf-8?B?RkVLU0FNZjNVeWtqOHM2Rmt0UXNHcnYvYlJDeUM5MUtzZFhCODFIVDg1cGVy?=
 =?utf-8?B?WEFqek9YMWVvUHRML3hpaGFjb3hvZ21hYlduaHBMM3AxNFNxNFREMWdkU0hs?=
 =?utf-8?Q?JCMRhX?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 09:53:25.7903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e062803-0b2e-40ee-22c8-08ddd9861520
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100
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

On Mon, Aug 11, 2025 at 07:18:34PM +0200, Dariusz Sosnowski wrote:
> On Mon, Aug 11, 2025 at 09:27:06PM +0500, Khadem Ullah wrote:
> > Thank you for providing these details. Sure, I will go through it (will
> > performed the experiment) and come back to you.
> > I totally agree that the documentation about connection tracking should be
> > improved.
> > 
> > 
> > On Mon, Aug 11, 2025 at 8:17 PM Dariusz Sosnowski <dsosnowski@nvidia.com>
> > wrote:
> > 
> > >
> > > > Are these the only testpmd commands you execute?
> > >
> > > No, as I mentioned earlier, I have provided only relevant information. I
> > had added something similar commands as yours,
> > the following was missing from my configurations.
> > 
> > set conntrack com peer 1 is_orig 1 enable 1 live 1 sack 1 cack 0 last_dir 0
> > liberal 1 state 0 max_ack_win 7
> > r_lim 3 last_win 510 last_seq 65535 last_ack 65537 last_end 65545
> > last_index 0x8
> > 
> > set conntrack orig scale 7 fin 1 acked 1 unack_data 0 sent_end 65545
> > reply_end 65535 max_win 28960 max_ack 2632987379
> > set conntrack rply scale 7 fin 0 acked 1 unack_data 0 sent_end 65545
> > reply_end 65535 max_win 65280 max_ack 2532480967
> > 
> > . > 3 conntrack item deals with RTE_FLOW_CONNTRACK_PKT_STATE_* bitmap
> > 
> >   > In your example, "conntrack is 1" specification sets flags to 1.
> >    > This means, "match packets with RTE_FLOW_CONNTRACK_PKT_STATE_VALID"
> >    >and not "connection in RTE_FLOW_CONNTRACK_STATE_ESTABLISHED".
> > 
> >    > The same goes for "conntrack is 2". It specifies match on
> >    > RTE_FLOW_CONNTRACK_PKT_STATE_CHANGED, not on
> >    >R TE_FLOW_CONNTRACK_STATE_FIN_WAIT or any other state.
> > >
> >   > Because it is a bitmap, conntrack item can specify a combination of
> >    >P KT_STATE flags. For example, "conntrack is 3" would mean matching
> >    >a packet with RTE_FLOW_CONNTRACK_PKT_STATE_VALID and
> >    >RTE_FLOW_CONNTRACK_PKT_STATE_CHANGED flags set.
> > 
> > Can this RTE_FLOW_CONNTRACK_PKT_STATE_* bitmap be represented with a
> > specific valid range ?
> > for example, we can say, 'conntrack is' valid for 1 to 8, or any other
> > range. As, currently user can specify
> > any value e.g., 1000 and it allows it.
> 
> Since conntrack item flags is a bitmap, then any combination of RTE_FLOW_CONNTRACK_PKT_STATE_*
> flags is a valid value to match on.
> 
> The validation could be done as follows:
> 
> 	flags_all = (RTE_FLOW_CONNTRACK_PKT_STATE_VALID |
> 	             RTE_FLOW_CONNTRACK_PKT_STATE_CHANGED |
> 	             RTE_FLOW_CONNTRACK_PKT_STATE_INVALID |
> 	             RTE_FLOW_CONNTRACK_PKT_STATE_DISABLED |
> 	             RTE_FLOW_CONNTRACK_PKT_STATE_BAD)
> 
> 	if spec->flags & ~flags_all:
> 	    reject
> 
> Regarding validation itself, if this is added, please make sure of the following:
> 
> - In mlx5_flow_dv_validate_item_aso_ct() - check for spec->flags should be
>   inside if clause for `!mlx5_hws_active()`. This is to make sure that
>   validation is done only in synchronous flow API.
> - Asynchronous flow API has a separate validation, which can be enabled
>   at build time.
>   This can be added to a switch case in flow_hw_validate_rule_pattern().
> 

Khadem, please note this patch: https://patches.dpdk.org/project/dpdk/patch/20250812094323.712559-1-dsosnowski@nvidia.com/

This would allow you to inspect the conntrack action state
through the following testpmd command:

	flow indirect_action 0 query <action ID>
