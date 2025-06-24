Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEC7C77B7C
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 07:16:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6ED2940609;
	Tue, 24 Jun 2025 09:16:03 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by mails.dpdk.org (Postfix) with ESMTP id E286040264
 for <dev@dpdk.org>; Tue, 24 Jun 2025 09:16:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+1cvGYbjwOCC/q+T04oR0U9zdAB/96FifDF6JzSmzyaCde0CfJUHXUcdzGRoteTgzMK+zaWMgBoh6piq56CL37IPz8TNMM9KOx3tD+w8SprYbyuKAp8ugWCtheT6J4zZlJPyBOgbAHUVCH7MTrb+M5W/2nQ3fv8BPYJQV7BkyJZauOX41ilJBtRcnB62gJtmwgW0zXFeRDulJQNeNMhhjSEmHxyOOxdIj5U0NRVwgJmSPiF5+HlMJ+rrfSCiBMVB69Pc+C9jKr7uHPP2viOGnhA2Tu//adpdeXpO8WqtbTOpGfNW/0Ad+U5RHuKHO9H1b0+vPQTVjkQobvzmnawWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOiw86OxmC8BXR6hIaNtcPGEo7C2dKCJ1VAjOkA4fCc=;
 b=fCDtvVMwATZrxTiYDZIKbZBR6KjvOEfvLjR61CALy4ANYwvHLcNnSeDZnmnCiraq+xlydNEg+3wv9OJ2+XbVZE7T3Bwo9MPq06mh6NGVguLiHz6ONKGG0eIw7sNlpqJSfirWfkrMGG3Dod0gWU2yBeXi73i7v59eya1SNWA8Se6OUgZP26ZNTwiCsTzIxDN0OqrSBRNLUFqj1OboO3ncrnhjbWI2cvW7yAuUdfRrKXxlzGb1OATC69oARapqXJj59kYKIz41NWDCdPgRxgMIj1tftG6uR7C7oezAbuaixg667hctz2ovR3cDzGFezbXh44CtNCLypsv80Rgk+gxosg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOiw86OxmC8BXR6hIaNtcPGEo7C2dKCJ1VAjOkA4fCc=;
 b=JLppWiJ++bp7xXmd70uACrIyZr2B6rY13PDtLAgLddAzMVZQKaJyewcNDaU36BzQTgYndlVj3FFS4YQCXk4QATVZL9wkgcUCMxmEy5/RULQ8AFLYB/NPCKPnF22uaOpzT247uw4msFI0fVg5BRwynKfLZurBQm6lCggEQxu9YGSPUoo15of0YLyCcT/tYy2W/gQR2YSAKWDn07vgtiybHQ0+QX9ZuKlGvlghSHojqmL1oaX54yZFPFlqQ5hfdnr4LmL+7HZajloUZMikmrLMHgKqf/AMK4GXJDNqlvv2SiUjlMvZHne7co6VYlmV6ai0PmK2W/y89n4TLykYiyaeCQ==
Received: from BN9PR03CA0927.namprd03.prod.outlook.com (2603:10b6:408:107::32)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.18; Tue, 24 Jun
 2025 07:16:00 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:408:107:cafe::ef) by BN9PR03CA0927.outlook.office365.com
 (2603:10b6:408:107::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Tue,
 24 Jun 2025 07:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 07:15:59 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 24 Jun
 2025 00:15:42 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 24 Jun
 2025 00:15:42 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 24 Jun 2025 00:15:41 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: Shani Peretz <shperetz@nvidia.com>
Subject: [RFC PATCH 0/2] Add jump flow support and queue menegment with new
 snippets
Date: Tue, 24 Jun 2025 10:15:35 +0300
Message-ID: <20250624071538.107876-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f437e9-bfd5-4998-13de-08ddb2eef8b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmQ1RU90S0RqeEQyZFpya3pGRG16RnByVXN5eXFDYnhMOCtFRVQ5Z3lTSFl3?=
 =?utf-8?B?UDZYbDJpa1BRTUVBWTVCSk41Zis0a0gzTlZUS3BFVkluMjVpOWZ0UmZ1NWZu?=
 =?utf-8?B?enJUcllqSzFzTXhsemFmME1ETXp2eUdqMGl2SHBUelRteWdaZ3RiYnRsSzEr?=
 =?utf-8?B?dG9PQkR1Z0xtUFZHaStQMDhXTFVOb2VKNDhYSE1DZjUyTEc5Nm1Wa2toWk1J?=
 =?utf-8?B?NEs1WTVLQXlydVQzNjFwN3R3YXFXbUxJb0dZSVVkNU91MURWd05JNkZ1MXBP?=
 =?utf-8?B?VCtQT29EN2lCaXdWdFhYV3lBMVB6d0ZTTE53TFV3dCt0M2F6enczWHczL08r?=
 =?utf-8?B?eVVyQktvdjJHcVpWK3dYekNhcDI2U2ZoZy91clRvbFlSdTc0UEpGSER1Y0s3?=
 =?utf-8?B?eGVMY0hjZ0tNdUUrSDk4WE1GTEtiNWVONURHRHAvUG9BQXFhd1p4T2pwdkxJ?=
 =?utf-8?B?eWFhenNrTnc3K3ZUY1hPeXYvNlllaCtBYm8vZkJZTmJoUXIwYUdsUTBlZTVK?=
 =?utf-8?B?MC9ZQjhNdStrTHNxeG1XRmNGU3d4bitDV1I0RHZmYW4rL1JSZ0UyTGpOTk9Q?=
 =?utf-8?B?WFltZFhJcjJPTjdSb1cxVDlOaWZEaTltY1pVc09QRGpNRmpsUjhtTmNRZWx0?=
 =?utf-8?B?TU0zelJCMW95dzJwbU9CYjBiZ3E2K1BZQ0g2ZC9pRk4xUC9WbWJJSWdCbENo?=
 =?utf-8?B?czNwNlZ3ZlFaMXFTYnBHSm11VzFqUXpMRG42bjk0R1phUWhxUHpwVnowdnhi?=
 =?utf-8?B?UFZGN2JNT0I3MWwrYVJVdmFMNGtpRzRqNG5qbk04c1MrQWJDWkNJNzVFYURZ?=
 =?utf-8?B?bjdsTzdTL0h3aU5YdEowYjZiQ0dWbnVlRkdaSFFYR0hVaG1qN3pDWFZYNUxx?=
 =?utf-8?B?ZkdHWjloSFpUcThyOGRVYS9PSDZnRmVGMWVJSDVNbjRuR0x3YUtWYklVaWpi?=
 =?utf-8?B?WEU1L0JMQlVvc2lQN1BEOTI4cWhNcjdpWWlkZWNwcGxabUQvTnpQYlZnU1Zs?=
 =?utf-8?B?OUVaVDFYZjg0RW4wTldLT1E1bWtKWFYvVmovTjNiVEUzdmpnTW4veFhsZERL?=
 =?utf-8?B?WUt4bWQ3N05SbEo0MUN5NUE4dXk2ZmNkYUYzV2UwSXJTc0ZZTW1nVmpMbEQ5?=
 =?utf-8?B?bGMzSHFYamt2Qm9NaEs2M1h4ZzJmQ2Z4cDRPY0pzTHg2Tk81UU9teXhCdm51?=
 =?utf-8?B?b1JNZjN3L2N6Sy8zQVFnU0FMMWtvWDR4eWtIdWU4MWhMS2FJd3JoY3EyMW9V?=
 =?utf-8?B?Z1NMK2Vkb1lZMFBtaDlYR3ZGdVEwMzM3YXJNNWp1Ym5nMGFzK2lpS3RuOU1Q?=
 =?utf-8?B?WFFmek03S1BGNHhzMkZrMEI2b1ZDOWVQTE5VOWJFSlVwSkYwUnh1WDZhUDVZ?=
 =?utf-8?B?Ykt1YUt2L3h0UnZRWmc0OXQvQnFDZFA2Vm9pSHEyaHk2U1VVYW85ZG1UZnht?=
 =?utf-8?B?ZG4ycXhDUldhdy80SFJ5cUJRSVMzdnBKZTFPa3BiUGlXQ01leDJBNWV0OUxN?=
 =?utf-8?B?TWVOTU1pM2RWK0tQKzlMQzR3Q3BRV3JkN2UxdDF4ek1rLzF1VHh0ekxQQW15?=
 =?utf-8?B?YWVpeVJ6MGQzcmMyNU92VitiSDE2Q3RtVnVVZUdvL3NHSkxXS01iN3hENVFP?=
 =?utf-8?B?S05HSVFVcitINFVBOGZ5bThsbEZteCtaS3FoVk91bHVOU1U3bEIveU5IRGxO?=
 =?utf-8?B?WUN0T3EzMUJWWUxrVEo5ZEptM3g2aXp2R2pybXBpSFRuMjI3N0pZRGplOGNI?=
 =?utf-8?B?R05aSStyTzBHUDROeVN4dWEyOWxxS240d09VWUlhQXczdHp4Qmo5VS9Yc3Bl?=
 =?utf-8?B?Szlwczk2UCtMejlOclFoRnN3S2tNYzZ2Q1RxTTZuS3crWVpmaW5Qb0tTQjFM?=
 =?utf-8?B?SWtZcWZ2bzFScHE2dmJPVGtwRk1ZeExTZXU3ck91SzBtdnphZEJCdEczL1BV?=
 =?utf-8?B?N1liYnJ5QTlTb1lhU3RQcWNYNStCeVF2RXpZaUVvT1JBZXFmcjJIVFJwdXRm?=
 =?utf-8?B?emF1OW9Sa2FxV0dXLzN3WHRHSVZWazNqSi9PUk5jc01ia3k1aVRSRThHeEIy?=
 =?utf-8?Q?/obH55?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 07:15:59.9264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f437e9-bfd5-4998-13de-08ddb2eef8b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
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
 .../snippets/snippet_match_port_affinity.c    | 110 ++++++++++++++++++
 .../snippets/snippet_match_port_affinity.h    |  39 +++++++
 .../snippets/snippet_match_roce_ib_bth.c      |  69 +++++++++++
 .../snippets/snippet_match_roce_ib_bth.h      |  35 ++++++
 .../snippets/snippet_re_route_to_kernel.c     |   3 +-
 .../snippets/snippet_re_route_to_kernel.h     |   2 +-
 .../snippets/snippet_switch_granularity.c     |  55 +++++++++
 .../snippets/snippet_switch_granularity.h     |  36 ++++++
 22 files changed, 529 insertions(+), 15 deletions(-)
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

