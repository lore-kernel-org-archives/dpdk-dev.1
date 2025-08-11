Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44975CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 17:20:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83EFD40615;
	Mon, 11 Aug 2025 19:20:19 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by mails.dpdk.org (Postfix) with ESMTP id 70104400D7;
 Mon, 11 Aug 2025 19:20:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wop4OE++tGv9i21YxI4y59iXjjjPn1VxE9JXbjQjKqLBTcCOiDlICf6AOX7nMtqqN3nmR49G+kxA20Ac4SCejJocUrIFihiRYRFUNUd/kNkhe7SzwPGtXzEDYGom9QdN0xfZ3KOxwpfpEGckU6zoDyBuQDeoxbZq+1QNlw/ioAazUEobvUdr0wZ6SwiX6zh97u6mPJAl7EkcesXvYxG4WOiQPkr/QL7ry8RC9rRcFbt0eW9RGkT1zt77fF1AMlwdaoh2ViRT26518UrKM6Y2dCH5M9IEGXmCXE/H0VUhcKvyFXiUCHD5fgR5q3+rSONPsvHqZHtnLmSVaA+9/GUx2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UC05jCFaLQJl6mZZiyYcuZJg6+3Fl+ZNw8N4XtDOAP0=;
 b=P8Qdx3ma1cqabgbWn/dY3xXQYgOTOTpHMYRFlNAF7gWG+yj/x1LHHnjTP+s1CiD8pxFyjSqPmsKBqb3t20mVNpny18tWB+dUguWWQAVFYzrqmUp6XfAz20SQvebgk1NSM3s6U/OJ3TcgRPfcleIN+evKvH0fjvWGT46EZN6JrpSiCvM0xSd/qigRIQwFEh9zowSkIlMfM5EgKUgzNcIwqen4yCB6NW+c4JtBzcnUIpCdFu9lvjfi7bxgqaNlF3h9SqIcpHj5wi3ifep43f+oNizOin+G8s76LNEl56tV/l4YClO4i0/Z1cnhhuBIUw0sJvJsjeiI0ARLT5GqnyJO0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=uetpeshawar.edu.pk
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UC05jCFaLQJl6mZZiyYcuZJg6+3Fl+ZNw8N4XtDOAP0=;
 b=NHAsH6Mcdo2WDcdAQ5Z5fdo3OJMfsrie8TVwozp7W9BXHxrbEEg5WoK5bQ34qB8BtjbOk40+sMx0eGRQZheQnxdW4tV8XcR6Lrkvb0Lkb2h9kkpASjWJU3K9ZhbA8kBm3JMx0iIuSL65AlAhN1XUE3Vb39/DFAO69yHyiaPTy0AyfcUmQp5VxPvXEbgO65Re8L/whItw2A3YNj+b2WQtVeI5WifZyfdFFhi4fqST9MCR1haRNuhV8qtyJPkYk9l2q7QZULkhL3brflRZ4mtpTQnbhXoDvdPnnDKjST7HYkx+WbYI4wYkbM2TGI5DjxMPN+nk3C2RNA9yKbRofJoZGQ==
Received: from CH2PR07CA0010.namprd07.prod.outlook.com (2603:10b6:610:20::23)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 17:20:12 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::a1) by CH2PR07CA0010.outlook.office365.com
 (2603:10b6:610:20::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 17:20:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 17:20:10 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 10:19:54 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 10:19:53 -0700
Date: Mon, 11 Aug 2025 19:18:34 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
CC: <ivan.malov@arknetworks.am>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>, 
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>,
 <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix connection tracking state item validation
Message-ID: <20250811171834.fcyhsgkssyai5uho@ds-vm-debian.local>
References: <20250808074738.2nqgorlqzzyf2jid@ds-vm-debian.local>
 <20250811062149.2489151-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250811151520.bonpjpefwuzuap65@ds-vm-debian.local>
 <CA++2-x5voCjMDXcO_jJw6vrmvtDzfPaAArABeAT9TGcVzXtoZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA++2-x5voCjMDXcO_jJw6vrmvtDzfPaAArABeAT9TGcVzXtoZA@mail.gmail.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail205.nvidia.com (10.129.68.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 469c3976-4f56-4ab5-a773-08ddd8fb5368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmZRcVFTUE5QRTZycU0wVjdMaG9NMFlScGZvTnpJSlNBaXl1RUFwdVhBdHdu?=
 =?utf-8?B?aUlzZUVtVWZPRDVFUXZVa0F1cVBNL2tRZW8vT09acVhIdElFQkk0M3Zxd0Zl?=
 =?utf-8?B?N0ZiRkh3eVNNUzRualRlZmZOdUlwZGZlcU9CNEo4SUJ0OHJXbmdXdENIUlBV?=
 =?utf-8?B?QUdpYUhFYVJ6TjNzQ2l6Q3I5Z3ovRlg4Q1o2a0x3V3JXYzNuWmJuemoxYVhX?=
 =?utf-8?B?SERCU0dDaGEzN2ozd3NrQmxEZ1JwaURjMDd5OWcyQVpOSnZWZmpOVFJEdzRE?=
 =?utf-8?B?ZDhhSjNTb1NkVzlyOXRUcVpvSllMTUlTNEVFMDlORUg4emRscXFFVDFHNXNH?=
 =?utf-8?B?UDF3QWdhWTZVMUVjclVacHU1L1JXSVBvYm5TaXRFM2FMUERhQU5CK3F2aWg1?=
 =?utf-8?B?Zi9NUFVlQkc5OWozUWhiNzJISld5Tll4VTZ2T0lPZWpONWVETitIRFk5TDVP?=
 =?utf-8?B?MUY2R0d2cExIbmRhTXBSN2NOMzFESGNKU3EzbWRpT1luanV3V0ZkRzh6a0pG?=
 =?utf-8?B?alZrWFIrYmZCY1FkQlRtOGlPZlhQMVozaEY5VCswUnpQcUhxZDNHK3I4WldP?=
 =?utf-8?B?MFlPdVdSWlIyZFFFNnFpa2graUhrdEVCanEwRnA1cnpYMjkvRU9zVmgxY09J?=
 =?utf-8?B?ejBrTnJmZlNlb0lKOGtjTmVHY2lHemJPV1lwNjNXcUVvUzVGKzRuS3JvVkdr?=
 =?utf-8?B?VEJta0JmbE10NVF6MlhTaFRQMzVWNnYzQTI2QnhDYlpWMUkyYVZKZ1JOZWZl?=
 =?utf-8?B?TlRyQ3I2dldzdk8xbVJJbHFzMGV5YU9wWWhEQnZpc0ZRMEc0OUlRdHppZEpY?=
 =?utf-8?B?UlYvaXVmeXd5cGIxc0RnTGVOdGFmVytOM1ZtdlBVUW80Z1hhQ0RudG5rT3g1?=
 =?utf-8?B?R0JrV2NySmNwVEkxaEVHa0o0NXhXQTAzZC9icXRJUGkwOXVXTXE4RW1BSGdh?=
 =?utf-8?B?Z0Zyd3RWS2tmQzFvM3YzbmZWbEdyRDYvWFhoelZnWnVnVFl3OVlBdWFQZm9m?=
 =?utf-8?B?Ym1wUXlWV3lnQlZaK2FPSnpLNyt2SzE0SEppZS94VmJQeThmaFArbTEraExm?=
 =?utf-8?B?TjJhdzFpdEhWNEowVDk5dUN0SnFhdGFkNkNXd2xKc3o4WjNTTWFwN1lSREpY?=
 =?utf-8?B?TjZ2Q1RqdUZ0OVNzdzMvMXZRT21jdlg1c1Rac0lHVGhSR2NsQ3lvMkVNR0hs?=
 =?utf-8?B?ajA5eXdFaXlVb0EvYlkrbHNrcjBlMVJIUUZLTVJoQUpNWXo3YnpOaHJ5VW9w?=
 =?utf-8?B?QWNlK29rWXA5ektidXVUR214UTRydTJ1aTIrUkhHbk9kSkk2WURPT0kwbmRi?=
 =?utf-8?B?Y3FUNkd3MExUczhrYUp4VXFKVC9EMDU4cCtRS2E1WWQ1a3Y5RVdaYXRrWEE0?=
 =?utf-8?B?ZzVxM0pEVkRPU0JxNlUxYnNiZ2Yyc3lPQWpVVi8weTdpK3hnMFZXeGE0QmRl?=
 =?utf-8?B?aXNaTElWVDQxQ3ZHV2lQK3U3b3M5WVlBb0htR3REZEhRa0pBR1ZhaHQreUw2?=
 =?utf-8?B?RGdhalpWOUt0bWRPcGdrV1F4UGtGWkpXckMzM0pRbnZaUG4wMWs5U3Rncyt2?=
 =?utf-8?B?K053TGFVRzRtTGs5dU1QUkZ6L1VxZ1FBWElacElSb3gyZ01DRUpydFVPaXlr?=
 =?utf-8?B?UzBEVEtnR2R2bEh5OFJKTU9WbURjZlcrU1pQVE9xdlh1ejJOZ0tSY2JqaXJV?=
 =?utf-8?B?VDl6NTNuNDNKUHF1cGZZWXpNaTJqMzBuL0toZFZJTXQ4Q3RUNVUzYkNTRXJB?=
 =?utf-8?B?eUlvQTRQdWM3RGpDU1NvalRvSVRKTTlCaHlkNkVvMmNrSlBHNDVVeTJDK2Ur?=
 =?utf-8?B?bEJSOE1HaVRsYVV1d24yUy9oVUtuaTNlaEhEaGQ5UVM2TG5VUlZuN0RyNGV0?=
 =?utf-8?B?d1pvaE56MlZYRVYwSUlkamtPVWJEdlNXSnR2S2ZGeWk0Zk4rQWwxbWF3ZWZP?=
 =?utf-8?B?a1o1RmpoUHZpUFZvNkVVRGM4bk5DNUJDNEJ4c09EcVNMczNGOFVBK2JmYWZv?=
 =?utf-8?B?aGx0SmgxekVPaktCRUpNR2V0YVE4Q3d2ZFlXT1ZyVU1HSjNNZ0pCM3JJTHRa?=
 =?utf-8?Q?crvUgi?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 17:20:10.2672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 469c3976-4f56-4ab5-a773-08ddd8fb5368
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526
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

On Mon, Aug 11, 2025 at 09:27:06PM +0500, Khadem Ullah wrote:
> Thank you for providing these details. Sure, I will go through it (will
> performed the experiment) and come back to you.
> I totally agree that the documentation about connection tracking should be
> improved.
> 
> 
> On Mon, Aug 11, 2025 at 8:17 PM Dariusz Sosnowski <dsosnowski@nvidia.com>
> wrote:
> 
> >
> > > Are these the only testpmd commands you execute?
> >
> > No, as I mentioned earlier, I have provided only relevant information. I
> had added something similar commands as yours,
> the following was missing from my configurations.
> 
> set conntrack com peer 1 is_orig 1 enable 1 live 1 sack 1 cack 0 last_dir 0
> liberal 1 state 0 max_ack_win 7
> r_lim 3 last_win 510 last_seq 65535 last_ack 65537 last_end 65545
> last_index 0x8
> 
> set conntrack orig scale 7 fin 1 acked 1 unack_data 0 sent_end 65545
> reply_end 65535 max_win 28960 max_ack 2632987379
> set conntrack rply scale 7 fin 0 acked 1 unack_data 0 sent_end 65545
> reply_end 65535 max_win 65280 max_ack 2532480967
> 
> . > 3 conntrack item deals with RTE_FLOW_CONNTRACK_PKT_STATE_* bitmap
> 
>   > In your example, "conntrack is 1" specification sets flags to 1.
>    > This means, "match packets with RTE_FLOW_CONNTRACK_PKT_STATE_VALID"
>    >and not "connection in RTE_FLOW_CONNTRACK_STATE_ESTABLISHED".
> 
>    > The same goes for "conntrack is 2". It specifies match on
>    > RTE_FLOW_CONNTRACK_PKT_STATE_CHANGED, not on
>    >R TE_FLOW_CONNTRACK_STATE_FIN_WAIT or any other state.
> >
>   > Because it is a bitmap, conntrack item can specify a combination of
>    >P KT_STATE flags. For example, "conntrack is 3" would mean matching
>    >a packet with RTE_FLOW_CONNTRACK_PKT_STATE_VALID and
>    >RTE_FLOW_CONNTRACK_PKT_STATE_CHANGED flags set.
> 
> Can this RTE_FLOW_CONNTRACK_PKT_STATE_* bitmap be represented with a
> specific valid range ?
> for example, we can say, 'conntrack is' valid for 1 to 8, or any other
> range. As, currently user can specify
> any value e.g., 1000 and it allows it.

Since conntrack item flags is a bitmap, then any combination of RTE_FLOW_CONNTRACK_PKT_STATE_*
flags is a valid value to match on.

The validation could be done as follows:

	flags_all = (RTE_FLOW_CONNTRACK_PKT_STATE_VALID |
	             RTE_FLOW_CONNTRACK_PKT_STATE_CHANGED |
	             RTE_FLOW_CONNTRACK_PKT_STATE_INVALID |
	             RTE_FLOW_CONNTRACK_PKT_STATE_DISABLED |
	             RTE_FLOW_CONNTRACK_PKT_STATE_BAD)

	if spec->flags & ~flags_all:
	    reject

Regarding validation itself, if this is added, please make sure of the following:

- In mlx5_flow_dv_validate_item_aso_ct() - check for spec->flags should be
  inside if clause for `!mlx5_hws_active()`. This is to make sure that
  validation is done only in synchronous flow API.
- Asynchronous flow API has a separate validation, which can be enabled
  at build time.
  This can be added to a switch case in flow_hw_validate_rule_pattern().

> 
> Thanks again!
> Best regards,
> Khadem
