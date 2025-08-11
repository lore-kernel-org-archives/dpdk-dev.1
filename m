Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A47C87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 15:17:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E1CD402AC;
	Mon, 11 Aug 2025 17:17:18 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by mails.dpdk.org (Postfix) with ESMTP id B601D400D7;
 Mon, 11 Aug 2025 17:17:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcJdbiaogKBvAcrFYCl+aMsHZ8WtYfd0nRS82Qn5Ggi9Dknvk3BbTCBX/FSrPU5pb7+/a/txu32wPaDwVCq4emS6Fsrn0h03Gg/rcjoL+p2o1v3GRbFC44p3wxdvXCgK4Nicy+ug+QYLbmyavr+8FI/B6/8o4CpSFves6ozXgTWapmygoPl3V+zqmPsHvproT+rhpqWGo58iNu6rHMMYtQwNwaPP+NjklYWcnIPkHkym/uzmp+1NOxD1jzCCTFawCMpOunNPdRZt53QJGV75fwTp8apzdvmENDTNrM/Golm/iMpA/guPGeQfGAmo6j37obyMQ6Y2/5omH/BXrDIweg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wi75UPXaAroKSxthDesLmSWKofSnlnI+CsbW6CA931Y=;
 b=Qjmf29nDCMFgHO7AsG8+SBKXNsZad2tjecVgZJZGNAuvMxGAOqQkX2o5pK20cUszcZ1BZn7Jsx631DU6AyvMjXWWJnJzTZY9wNjVFamqNDX/ZMKD/VtTpeFx93RMPuKuRynkXK9aDpTUEXBO6Mll2n36v2BcygXAn/GWJ1EEq86u2giymgKRWwqiVPdbrH57h18mDRGF94DrgBG14YXuehh5Ki/vAtd4lMgEadTUL6Qekd1kETWCY+UXXnebxDbZqlBKIk/3wRbbjPSVxj8blCdcknlCi4+EN7Dl5wInfD0WEJrTNpBchzsyjR8nlyJqYcTdmEtn1J20VW5p3b3WEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=uetpeshawar.edu.pk
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wi75UPXaAroKSxthDesLmSWKofSnlnI+CsbW6CA931Y=;
 b=iiwTXijuze+BOzwJ4tRy2F+lthmDF45/2GDMTFZfKOihSGCjB8e8mEnbIbLUWyP6n3d7RTZoIx3m3WQnkeeo2eBZ9Ly9oCsrBUcv7sllAb5rvTX7S6q2RDs8EfaWzg8Lyoz4ASUzCPy4U+k+DvwJcQS9QpLfuiiiMi5htxx9XljanPeUmoHAw+vRFlkHauba0LPZ7sMBUa9H5t31d31g1twUil2wjER9LCnpNZ1OsXaiMka8g3ohdWOIwVJBYfUovHrUTuodJvhp9OPzxUvzlofgo0ag/X8jBRojlZhyXKmGoe1FSoU96/age/78spcCAXvYWO2RuziOmnlVu30FPA==
Received: from MN2PR16CA0030.namprd16.prod.outlook.com (2603:10b6:208:134::43)
 by DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 15:17:11 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:134:cafe::40) by MN2PR16CA0030.outlook.office365.com
 (2603:10b6:208:134::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 15:17:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 15:17:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 08:16:45 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 08:16:44 -0700
Date: Mon, 11 Aug 2025 17:15:20 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
CC: <ivan.malov@arknetworks.am>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>, 
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>,
 <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix connection tracking state item validation
Message-ID: <20250811151520.bonpjpefwuzuap65@ds-vm-debian.local>
References: <20250808074738.2nqgorlqzzyf2jid@ds-vm-debian.local>
 <20250811062149.2489151-1-14pwcse1224@uetpeshawar.edu.pk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250811062149.2489151-1-14pwcse1224@uetpeshawar.edu.pk>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 71602d4f-104d-48de-7e9f-08ddd8ea2422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mqLGP9ETnvWVhFgXLOtX8ILNsCKu/0exgNjdMPVI1fR65DfAbSi3qw+VIeYR?=
 =?us-ascii?Q?Z19QqMk01DcB8SZkfzv+CU8XFJV5TwbR/PRkknxiA38LtBBA2TSWcAZ6T7rI?=
 =?us-ascii?Q?zAAZI+FMf3iTj/YPACCvIYink+y2vcWXfw3K1LMgufa0fDObqnoNrU51OEBS?=
 =?us-ascii?Q?kJoSns/sbXN8hPcW1DP2DoRSliyvD2GMrB1w3uXaToZ32/SN6fOVPrO2aCwi?=
 =?us-ascii?Q?+5gYU3fejUekcWyuXVvdrYGPdKmZOKAj87UQb+6A2up/7iZady1pQ9xNfDMx?=
 =?us-ascii?Q?RONqrGE8HP7TBbTv8b1/TBTsWdrzNaEgJJ/4me0aXO2iZa8kWc7yRHEkQTNz?=
 =?us-ascii?Q?i9A21qwrl7gyucH/ZMdgGlhlHSsEU5DmGoIlLaaWVvgC5/LHKfre3aCPxsD9?=
 =?us-ascii?Q?GyGKCLc6KjdvG7C0IP/oipWNq0PXNdxwjQF0kslFGPpnTDKC4b7LQqdIL5A2?=
 =?us-ascii?Q?6qG/AwGpfEfkNSyAqDKfmSsnfixzXwEOskmk1PcvWK2vS3lzZiyxZ4nGk2Wb?=
 =?us-ascii?Q?SZyXLHG47Vzymp4Bm7sUqcTFHAOg+yll6hWk5ueSBwLkAfISenGSqLtKs8KL?=
 =?us-ascii?Q?GKzBY/DLuEGxk5TLAC+Dfk5jBJTpzYMkDJxwoAHeBWu0gdNsbyb8LQ4843gf?=
 =?us-ascii?Q?JzSHExWv4Ka4uAjihT97UMnoSlND1TERVnpscRbob7qKHTn+XztFjkU9ZMO2?=
 =?us-ascii?Q?/GgE6ZYQHqUnfo44N0By2XM3OxOpvK65a8lG4JbauUKs+CcMWGjXAm2ughAf?=
 =?us-ascii?Q?YmJksoO2YXQEllQfmvGIj8UONAEjk7gC95e/PhZi/0hu8kzo/WhkFn5cE2rz?=
 =?us-ascii?Q?PXuElLJqTyOFgPKixFhr0I8lGbopVF+ayum5drZcq42FOAdUBpA8Qib6xg95?=
 =?us-ascii?Q?q0+d9J3Zz1Om6069NZH7ZNiLZjIPO0R8c4IwIc5FX7Y/Bj2HhI+MXTrouOxf?=
 =?us-ascii?Q?ytMBERcv0zWP9BVRqGfr/RksfYtgy32vXSTFYgB9zfpZ6umNop2CU6onQiTA?=
 =?us-ascii?Q?aYfhQuQXIKQJH/mCDVjrfPETw4/bbNRHEX9vS/lWjTCPk1dt53mhfgDixniE?=
 =?us-ascii?Q?CjVP3Jhv35CgkvcbiCVSzyUOE8pMTBGJfFpcQAGiGsyagmGStvMH1pa3xe2P?=
 =?us-ascii?Q?RSPovG7pjvlrWHzltH/lwuzPKozDfoLCk7j5pZCJBwpsYo7X5gGk9luPI5+o?=
 =?us-ascii?Q?+XhkbIMUF1NvXo4iYniNoUjLFTU5MU0wIsB8Ej7qVzRJH8W5dASpTDsxb68V?=
 =?us-ascii?Q?Vv9ENKKzsm+eRI/wmZYhpgw/Ufs25hBZFugL+yOPMJTh6S27HKZV4Vs+8ayB?=
 =?us-ascii?Q?QmSnLg27q+fjv0R9AXz0Sgbr/D30dQLDAmvB1SOCYVi1VUTBynK60xjiK5G9?=
 =?us-ascii?Q?HYCRTITu84SOkyxTgjuesAhh87oT12+EVsXeX2hm6d0HSL/+UTuljMSWCnQ0?=
 =?us-ascii?Q?fWNfuNhaaoPjCDaqttsl105ztXZ5FcWzlgvcXcFeAILd/shdEC8pAXQOv4qm?=
 =?us-ascii?Q?OfZCDhJtAcczeP8dr/uVcHPYTDldXeNJ9XXy?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 15:17:09.4887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71602d4f-104d-48de-7e9f-08ddd8ea2422
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549
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

On Mon, Aug 11, 2025 at 02:21:49AM -0400, Khadem Ullah wrote:
> Hi Dariusz Sosnowski, 
> 
> According to documentation, conntrack item matches a conntrack 
> state after conntrack action. Your statement is also correct 
> "match valid TCP packets which change TCP connection state", 
> it means in this case also we are matching TCP connection state. 
> 
> Please check CONNTRACK item in Generic flow API (rte_flow)
> 16.2.6.47. Item: CONNTRACK
> 
> Matches a conntrack state after conntrack action.
> 
>     flags: conntrack packet state flags.
>     Default mask matches all state bits.
> 
> https://doc.dpdk.org/guides-24.07/prog_guide/rte_flow.html

As mentioned in the quoted docs - flags in conntrack item match
"conntrack packet state flags", not "connection state".
Packet state refers to one or more RTE_FLOW_CONNTRACK_PKT_STATE_* flags.
(Documented specifically in API docs).

I am focusing on highlighting the difference between "packet state"
and "connection state", since this distinction is important, because:

- flow item deals with "packet state"
- flow action deals with "connection state"

One of the flags for "packet state" is RTE_FLOW_CONNTRACK_PKT_STATE_CHANGED,
which indicates that this packet has changed TCP connection state.
But without analyzing the packet and inspecting TCP connection state
(by querying the conntrack flow action),
user does not know the specific state transition i.e.,
whether transition was SYN_RECV -> ESTABLISHED, or ESTABLISHED -> FIN_WAIT for example.
So user can match packets which changed the connection state,
but not the specific state transition.

Perhaps the docs (both programming guide and API docs) could be improved
in that regard to highlight the difference more clearly.

> 
> E.g. I have performed the following experiemtns on connect-x6-Dx for clarification
> (provding only the relevent information).
> 
> conntract state can be verified for liberal mode.
> In liberal mode, the Seq/ACK/Win check will be ignored (forget about act/seq)
> and only the state change will be tracked.

Correct, but even with liberal mode (so no TCP window check)
"packet state" after conntrack execution is still at least
RTE_FLOW_CONNTRACK_PKT_STATE_VALID.
This is the area of the docs which should be improved, since it is not
stated.

This makes the following example matches correct
(take note that flow item takes a bitmap of RTE_FLOW_CONNTRACK_PKT_STATE_*):

- conntrack is 1 => RTE_FLOW_CONNTRACK_PKT_STATE_VALID

- conntrack is 2 => RTE_FLOW_CONNTRACK_PKT_STATE_CHANGED

- conntrack is 3 => RTE_FLOW_CONNTRACK_PKT_STATE_VALID **and**
                    RTE_FLOW_CONNTRACK_PKT_STATE_CHANGED

> 
> Test 1 : Starting state machine from State 0  
> 
> flow indirect_action 0 create ingress action conntrack / end
> flow create 0 ingress pattern eth / ipv4 / tcp / end actions jump group 3 / end
> flow create 0 group 3 ingress pattern eth / ipv4 / tcp / end actions indirect 0 / jump group 5 / end
> flow create 0 group 5 ingress pattern eth / ipv4 / tcp / conntrack is 1 / end actions queue index 1 / end
> flow create 0 group 5 ingress pattern eth / ipv4 / tcp / conntrack is 2 / end actions queue index 2 / end
> set fwd rxonly 
> start 
> set verbose 3 
> 
> The following packets will be forwared to queue 1, it means the state machine is now in established state (state 1). 
> sendp(Ether()/IP()/TCP(ack=265,seq=265,dport=5555,flags=0x10), iface="",count=1)  
> sendp(Ether(dst="bb:cc:dd:ee:ff:22",src="aa:bb:cc:dd:ee:ff")/IP(src="150.1.10.10")/TCP(ack=265,seq=265,dport=5555,flags=0x18), iface="",count=1)
> 
> FIN packet Terminate the connection; the following packets will be forwarded to queue 2:
> pkt=Ether()/IP()/TCP(ack=265,seq=265,dport=5555,flags=0x01)
> pkt=Ether()/IP()/TCP(ack=265,seq=265,dport=5555,flags=0x10)
> pkt=Ether()/IP()/TCP(ack=265,seq=265,dport=5555,flags=0x01)
> pkt=Ether()/IP()/TCP(ack=265,seq=265,dport=5555,flags=0x10)
> 
> This will be again forwarded it to queue 1: 
> pkt=Ether()/IP()/TCP(ack=265,seq=265,dport=5555,flags=0x10)

I'm not sure how this result was reached, because when using these commands
and sending these packets, I do not receive any.
I only receive the packets if and only if the rule with conntrack item
matches on RTE_FLOW_CONNTRACK_PKT_STATE_DISABLED:

	flow create 0 group 5 ingress pattern eth / ipv4 / tcp / conntrack is 8 / end actions queue index 0 / end

Which is expected with the given configuration.

Are these the only testpmd commands you execute?

If yes, then there are a few things missing for functional conntrack offload.
Let me explain:

1. There is no conntrack action configuration.

   testpmd has a few commands which allow users to provide initial
   conntrack action state. Please see https://doc.dpdk.org/guides/testpmd_app_ug/testpmd_funcs.html#sample-conntrack-rules

   Without running these commands, initial conntrack state is zeroed.
   As a result, `enable` field in `rte_flow_action_conntrack` is zero
   and TCP state machine in HW is not updated for each passing packet,
   and each packet is marked with RTE_FLOW_CONNTRACK_PKT_STATE_DISABLED.

2. There is only one rule with conntrack action.

   Rules with conntrack action need to know which TCP connection direction
   would pass through that rule. This is needed because, conntrack
   offload does not track IP addresses and TCP ports.
   Inside the state machine, there are 2 separate sets of seq/ack
   numbers tracked for each direction.

   Users must ensure that there will be 2 rules (1 for each TCP
   direction) with conntrack actions.

3. conntrack item deals with RTE_FLOW_CONNTRACK_PKT_STATE_* bitmap

   In your example, "conntrack is 1" specification sets flags to 1.
   This means, "match packets with RTE_FLOW_CONNTRACK_PKT_STATE_VALID"
   and not "connection in RTE_FLOW_CONNTRACK_STATE_ESTABLISHED".

   The same goes for "conntrack is 2". It specifies match on
   RTE_FLOW_CONNTRACK_PKT_STATE_CHANGED, not on
   RTE_FLOW_CONNTRACK_STATE_FIN_WAIT or any other state.

   Because it is a bitmap, conntrack item can specify a combination of
   PKT_STATE flags. For example, "conntrack is 3" would mean matching
   a packet with RTE_FLOW_CONNTRACK_PKT_STATE_VALID and
   RTE_FLOW_CONNTRACK_PKT_STATE_CHANGED flags set.

Please see [1] for a full example. Let us know if you have any questions
about the example and if it works for you.

> 
> So, according to my understanding(from rte_flow and various experiments), 
> conntrack item ('conntract is') matches the state of the connection tracking 
> state machine in hardware 
> and forward it to the relevent queue. 
> 
> In any case, I think only a range of values for "conntract is" to be allowed. 
> 
> Best Regards, 
> Khadem

[1]: Full conntrack example, testpmd commands:

# Initial conntrack action configuration: original direction, state SYN_RECV, liberal mode and enabled
set conntrack com peer 0 is_orig 1 enable 1 live 0 sack 0 cack 0 last_dir 0 liberal 1 state 0 max_ack_win 0 r_lim 5 last_win 510 last_seq 2000 last_ack 101 last_end 101 last_index 0x2
set conntrack orig scale 0xf fin 0 acked 1 unack_data 0 sent_end 101 reply_end 65535 max_win 0 max_ack 0
set conntrack rply scale 0xf fin 0 acked 1 unack_data 0 sent_end 2001 reply_end 65535 max_win 0 max_ack 101
flow indirect_action 0 create ingress action conntrack / end

# Create a rule for original direction
flow create 0 group 3 ingress pattern eth / ipv4 src is 1.2.3.4 dst is 5.6.7.8 / tcp src is 40000 dst is 50000 / end actions indirect 0 / jump group 5 / end

# Update conntrack action - now rule will created for reply direction
set conntrack com peer 0 is_orig 0 enable 1 live 0 sack 0 cack 0 last_dir 0 liberal 1 state 0 max_ack_win 0 r_lim 5 last_win 510 last_seq 2000 last_ack 101 last_end 101 last_index 0x2
flow indirect_action 0 update 0 action conntrack_update dir / end

# Create a rule for reply direction
flow create 0 group 3 ingress pattern eth / ipv4 src is 5.6.7.8 dst is 1.2.3.4 / tcp src is 50000 dst is 40000 / end actions indirect 0 / jump group 5 / end

# Create group 0 rule for TCP traffic
flow create 0 ingress pattern eth / ipv4 / tcp / end actions jump group 3 / end

# Match valid packets, mark and send to queue 0
flow create 0 group 5 ingress pattern eth / ipv4 / tcp / conntrack is 1 / end actions mark id 0x111 / queue index 0 / end
# Match valid packets which change connection state
flow create 0 group 5 ingress pattern eth / ipv4 / tcp / conntrack is 3 / end actions mark id 0x333 / queue index 0 / end

set verbose 1
set fwd rxonly
start

Example packets to send after all flow rules are created:

# ACK in handshake: transition SYN_RECV->ESTABLISHED; logged as "FDIR matched ID=0x333"
pkt = (Ether() / IP(src='1.2.3.4', dst='5.6.7.8') / TCP(sport=40000, dport=50000, flags='A', seq=101, ack=2001))

# some data from original direction; logged as "FDIR matched ID=0x111"
pkt = (Ether() / IP(src='1.2.3.4', dst='5.6.7.8') / TCP(sport=40000, dport=50000, flags='A', seq=101, ack=2001) / Raw(load=b'a' * 100))

# ack from reply direction; logged as "FDIR matched ID=0x111"
pkt = (Ether() / IP(src='5.6.7.8', dst='1.2.3.4') / TCP(sport=50000, dport=40000, flags='A', seq=2001, ack=201))

# fin from original direction; logged as "FDIR matched ID=0x333"
pkt = (Ether() / IP(src='1.2.3.4', dst='5.6.7.8') / TCP(sport=40000, dport=50000, flags='F', seq=201, ack=2001))

# ack from reply direction; logged as "FDIR matched ID=0x333"
pkt = (Ether() / IP(src='5.6.7.8', dst='1.2.3.4') / TCP(sport=50000, dport=40000, flags='A', seq=2001, ack=202))

# fin from reply direction; logged as "FDIR matched ID=0x333"
pkt = (Ether() / IP(src='5.6.7.8', dst='1.2.3.4') / TCP(sport=50000, dport=40000, flags='F', seq=2001, ack=202))

# ack from original direction; logged as "FDIR matched ID=0x333"
pkt = (Ether() / IP(src='1.2.3.4', dst='5.6.7.8') / TCP(sport=40000, dport=50000, flags='A', seq=201, ack=2002))
