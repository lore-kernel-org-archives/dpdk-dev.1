Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661E1C87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 14:37:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D54A402AC;
	Mon, 11 Aug 2025 16:37:21 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by mails.dpdk.org (Postfix) with ESMTP id 5B12D400D7
 for <dev@dpdk.org>; Mon, 11 Aug 2025 16:37:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yq5zbqeXUuhEukgtWKCxNsSnK6h2BPHcvW7JQ1SPaWo5Hu0ddhmB2lQUC+3Mf+CKFY5qQ/2MMqRMkqAfIbiS5yVwhMsmYAOLptymPROJDPsTrxm/Mn+OiTxQEd+9fryNtA/hN7EVl+SRZmG+cxcJGXiPOWK50enleS3cMkI738NcwEFRjIC5wdVYTBiMzkPWrb2m62mqavksXTtoVZiKYECTUcEXuy2HJ+IhDrLfUIHhCHGIwHeqSzIYvjiEc2+CjI/0QbvD0hQ4ovgfLJ4van77UnTl+1TLeNCyei2zaUHtkh/gmtfvhBvJBJITOeVU5X20x45hZU7lA4y+33c9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPF2cOf9xc7u7gY2V/TFDTlavODPSh4Kh01dvQBomhY=;
 b=sqs82XK07f529apfqm3zE5+Vogb5Ec+i89MFHUNxRs4Abz1Arrakra9hdjLkKhHc9/S4RqMnRny+Z3h3f7IcuqtHNinAUqD4hXugRfcCAShjQIE4Bu7VECHP9G2J4xb5iilRcLaOAWjtX7fmDTAPHR0/FC1RoGiG9eH8OPplHhh5koChB3Hq4Vj574Z9mph02b7kkw5ke8Je26l5Cv8KNtI90KYulsnQasyrwy4IYx18Wo0Bdi98hUEbrfJ1i/vHhjPl0RSpKR5SyABD6SP6oGyZ3R3ZEd0YIrtfPud9lC73+v0bJktL0IRG1w4sipXY8E8/bIfS2JxDHL1vNdMYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPF2cOf9xc7u7gY2V/TFDTlavODPSh4Kh01dvQBomhY=;
 b=UWsJKW+ub2erlfLtyInhBwobyRP0VyGMGJiZIffWyauAwd3h5QEDSF+d9DTsiLg2N7qdxLQtts4kXP5/3k5XgfEWFOEQ07SGO9TOvBCRETdfuqfC91gU+A3n7A1lkyXMDydCs/lRbLumdBRxNSVe+x5bKVX+tR5r2pKJw42T3/aJcdPZ7TRCmwshgYX+PmxX2OQGR4JRzzuouHfcSwUcnE2unFDhFKdU0TyTe97qkc2BhmlSTgQF2MxDE3BnVzyBcocGs2+Ec2FguU8ynLfiCzbicctHRPT6s97W3urgMyC+fOHDM7jie2RhkDMX9y3Ql867Tk8M42t9UHDiW4tOJQ==
Received: from BN0PR04CA0157.namprd04.prod.outlook.com (2603:10b6:408:eb::12)
 by SA1PR12MB9245.namprd12.prod.outlook.com (2603:10b6:806:3a7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 14:37:17 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::60) by BN0PR04CA0157.outlook.office365.com
 (2603:10b6:408:eb::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.20 via Frontend Transport; Mon,
 11 Aug 2025 14:37:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 14:37:16 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 07:37:08 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 11 Aug 2025 07:37:08 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 11 Aug 2025 07:37:07 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: Shani Peretz <shperetz@nvidia.com>
Subject: [PATCH v2 0/2] Add jump flow support and queue menegment with new
 snippets
Date: Mon, 11 Aug 2025 17:37:02 +0300
Message-ID: <20250811143704.146795-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624071538.107876-2-shperetz@nvidia.com>
References: <20250624071538.107876-2-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|SA1PR12MB9245:EE_
X-MS-Office365-Filtering-Correlation-Id: a351debd-93de-4153-5f62-08ddd8e4920d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWVONFphS0xaS3lMZnA1VW5RcjJOUWtPNnBEVWp3eTlSSzJ3akFPRjMyeUZF?=
 =?utf-8?B?R2ZDUEp2Qi9Icm1xM21SRUxpTERtRkRYSnZQbjZrQUtweFZzbVltemR3TGZD?=
 =?utf-8?B?QWpRNlZ3VzU0c0JYdkZFVis4a0l3eklVc0xUeElvZGxDRjQ1R1N6ZHhrVTcy?=
 =?utf-8?B?YU5pYTY5L1lnbTZjV2hDTHR3Mk9XUzVSdjR0N1ROVkFDejJuS1RoTnRSZ080?=
 =?utf-8?B?UlJIUXlPVXQveFp2Q05yNmlYWCtoczNmVGlCUk5ITXhDd3grUEp2TFVJOUlF?=
 =?utf-8?B?M2V0MFJZWkxFQ1JWR2lFMFVOS2F5WjhWSzNxeFphL1d0bWZpSjQxNXp6K3N2?=
 =?utf-8?B?QnFJYy83NkJnYnNuR1VVc3FlOHFURjlKUTVkQmNtTThsWklIRTk1c3VPWlZB?=
 =?utf-8?B?RGlBM3ErZ0dhck1NdnJHby9xSkNEeGtDZTVpbXVabVBobG94eHFiOTA5M3lJ?=
 =?utf-8?B?VmhiSkk5U1didmlBY1lSY3l1TW80R0hjU2kzSFlONDdqOHBsRHZHZ1d0S0dO?=
 =?utf-8?B?cmVuY0t3dmljR1lkR2tRN3JtQ1JoRFJMWUlrYjFTNythbE9vWWs3a2djdVRO?=
 =?utf-8?B?RHRUeGtHcC9Qd2N1TnFLcms4T0g0TUZFTCtMQnlWZ2FnNU1GNzhqSkQ3YWFN?=
 =?utf-8?B?ckpsZnBQZ2QrV3RNcU1UUEtIcWt0UXVuQzNMelBTb0dHTUVjVG9SZ0hCMmdQ?=
 =?utf-8?B?ajJTM3dUdmVWY0JrWktOanVCekl2U1F2UlVDNjRDZFd2QjYwZDN1a2lhYVpE?=
 =?utf-8?B?YkJuTDZ0RGxiTHN1c0FLKzlyaTdnNVlMaGhZOWRiaklEK2Fqdk56UGd0Wlhz?=
 =?utf-8?B?K0FNZjUrTmJiZklwdGx1YU1CaisvSzJEYTVuY0hpS1ZKOWcrVDF4Y1U0RVh3?=
 =?utf-8?B?MCt5OGgxTUcxWTg5UDBhZGZHSlRtS1o5bXpISHRnRytKTGhXL3pkTDZ6UmYy?=
 =?utf-8?B?WnpjcC9VUFVJVWVielAxZFUxZkVCYzhEMURKOW12dlBjdTRuZjFwZDM3Qm1r?=
 =?utf-8?B?dXZ0RGtBY01NRVpacnJSWGR3YUhQclpvOElxL2s1TzhwZDc4a2I4NnFaK0NK?=
 =?utf-8?B?M0s3Y3RDeDJLWC8vcDVZMll3R2tsRnhTSTVGRElZNnE2WGpXNG5SVU14djN5?=
 =?utf-8?B?T2lGZnN1b3UxMUNGekxzTlBnZFZ2WThJZWxESDVTYjFqcEt0bHMvSllTZ2gy?=
 =?utf-8?B?eTlGN3dkSEMxcnBaQlNjTVdpS2tIdXdiMzVpQXYxTE9sUjFsRGJIM2crVGVl?=
 =?utf-8?B?VXhIMXhxSURxdzZkdHZnM2hoSjRSSVF5dWF5aTkxUURmNU9CbE9EbHgvMDJN?=
 =?utf-8?B?RWppVjBabFlXMW5PRUxDUVhmTlFJK1h3c25JZ0dmUUVEbEcvVURXVkJST0Jm?=
 =?utf-8?B?WGNzNFN6REgzYUNxQmJpUFdKcGVRQTZ0N0pWSWhrSCt1S3dTS1NEWVpXMFoz?=
 =?utf-8?B?R0VkSnliTEFFN3VNcjQyMVpac1NHaWtONFlXL3FZVU1naHlzZkNXMlVaZDhU?=
 =?utf-8?B?TExZT2d0bjZrSjJHNmhaK2FJelhDY2hvRVNFdVVRekxIWlU4aVY5RExvYlE1?=
 =?utf-8?B?VXoxWUx1QzRmS1B0dGdzaEZodTNyUlhTRTdvazFqSHZ0OG16ckN2ekRpbWJE?=
 =?utf-8?B?UXZZL0xST3VNMkJqbHNQa0lTQ25GVnVFdFNKQzBvYmc4d2FUdnZKb3ZaOWRw?=
 =?utf-8?B?U2x6eVlCaDdlam5iVFIyY0VhTERFOXNWbEx5djlTUDZJSUlMbHYybG16UDVE?=
 =?utf-8?B?MmFZamVmbHY1aGlNY3JOTkg1TVhaUEc0RkJ6WGwrd3kzOXIvenZWM2MzbEtK?=
 =?utf-8?B?RCs2WW5Yc1NYQ2JoQzlmbFBhMjQ4eU9mNXVQNmZZRkhvV2pNVU1uVnFFSlR1?=
 =?utf-8?B?dDJuNTVqbERxNUp6WkczV0tTVDY2MHgySHkyV08xcFBuTkJwSm9haTRid3RQ?=
 =?utf-8?B?VjlyWEt0Mis3M3JFWW5uazZRQi9PMXVGUlFvUWhpRGFmZ1QzMTlKdnh4Tm94?=
 =?utf-8?B?NVUrdG01cG9ZMExTbGJ2cmFvNUxJbVMrd0dZOWVlUmlLcWxwdTVGYUxrdXhv?=
 =?utf-8?Q?QV67CR?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:37:16.9239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a351debd-93de-4153-5f62-08ddd8e4920d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9245
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

v2:
sent mistakely as RFC - remove RFC tag, no functional changes

v1:
This patch series adds port affinity matching for bonded ports and
refactors queue management to support the new port affinity snippets.
This refactoring also enables other snippets that require access to
the queue number to utilize it more easily.

It also introduces support for jumping to specific flow groups,
with three new snippets demonstrating this feature.


Shani Peretz (2):
  examples/flow_filtering: add match port affinity snippet
  examples/flow_filtering: add jump flow

 examples/flow_filtering/common.h              |   2 +
 examples/flow_filtering/flow_skeleton.c       |   2 +-
 examples/flow_filtering/jump_flow.c           |  40 +++++++
 examples/flow_filtering/jump_flow.h           |  13 +++
 examples/flow_filtering/main.c                |   9 +-
 examples/flow_filtering/meson.build           |   5 +
 .../snippets/snippet_match_gre.c              |   2 +-
 .../snippets/snippet_match_gre.h              |   2 +-
 .../snippets/snippet_match_ipv4.c             |   4 +-
 .../snippets/snippet_match_ipv4.h             |   2 +-
 .../snippets/snippet_match_mpls.c             |   2 +-
 .../snippets/snippet_match_mpls.h             |   2 +-
 .../snippets/snippet_match_nsh.c              |  74 ++++++++++++
 .../snippets/snippet_match_nsh.h              |  36 ++++++
 .../snippets/snippet_match_port_affinity.c    | 108 ++++++++++++++++++
 .../snippets/snippet_match_port_affinity.h    |  39 +++++++
 .../snippets/snippet_match_roce_ib_bth.c      |  69 +++++++++++
 .../snippets/snippet_match_roce_ib_bth.h      |  35 ++++++
 .../snippets/snippet_re_route_to_kernel.c     |   3 +-
 .../snippets/snippet_re_route_to_kernel.h     |   2 +-
 .../snippets/snippet_switch_granularity.c     |  55 +++++++++
 .../snippets/snippet_switch_granularity.h     |  36 ++++++
 22 files changed, 527 insertions(+), 15 deletions(-)
 create mode 100644 examples/flow_filtering/jump_flow.c
 create mode 100644 examples/flow_filtering/jump_flow.h
 create mode 100644 examples/flow_filtering/snippets/snippet_match_nsh.c
 create mode 100644 examples/flow_filtering/snippets/snippet_match_nsh.h
 create mode 100644 examples/flow_filtering/snippets/snippet_match_port_affinity.c
 create mode 100644 examples/flow_filtering/snippets/snippet_match_port_affinity.h
 create mode 100644 examples/flow_filtering/snippets/snippet_match_roce_ib_bth.c
 create mode 100644 examples/flow_filtering/snippets/snippet_match_roce_ib_bth.h
 create mode 100644 examples/flow_filtering/snippets/snippet_switch_granularity.c
 create mode 100644 examples/flow_filtering/snippets/snippet_switch_granularity.h

-- 
2.34.1

