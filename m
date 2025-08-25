Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94932CA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 07:24:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81F914025A;
	Mon, 25 Aug 2025 09:24:25 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by mails.dpdk.org (Postfix) with ESMTP id 2FE5740151
 for <dev@dpdk.org>; Mon, 25 Aug 2025 09:24:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JF4Vo48eg44/79Dm5lGJPcavj/gKmSG/AG29khHlX4B3vg4fBQ22gkoAtx9EivD5kYch1d57b5j6nxOmsf7g4IB/9V3Rcw5ZREJfKKy6V+xPc1VrMg4zxvjkzQsmpAH/c6mqKKZZ72FxkWrDcJBlexyCd5Iw+IeWkJ3A5q8F3iI3TJQOUvKabafJsz2gzPTtGyd5yQVz0Of6n5tJ72IYjkV+G9h/pPDf2dnH2cTlofhmxLBKTFlVTvf0bd17wNv0Amos0lL42nw0aBrP+icsb94NvAoBWD2SYQTV3k4HqRXl4K4XWOI+i8VtBCj7vl+2JMX3ITSUtuRIChvPkgl+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCodjd9VOyvEQnNJrR4Rt7Mk07n8czE3+XonLzgIW6M=;
 b=MelfzsuzG/JIMl9BBTIYuVhM9uXbA/xtvWJhHfTaRojwMTJgS4b2O1NB7QbG/yqRG1cWwG+nT4fMpxax+U3R7JH9jiV4a6aJ8SCE7ZW3j9ZeYgC+3oGc4O1absCZrsD/2/yAXXuO4sTIjij5FjVKib60m5JemCH80cdEsyrpkhrbobnBSjzalPZWQZKeUm+10SxOI7swJg8sV83PGRmYpSS/8Fp/keeIYwNmL4NZG9bY+ZFVOHNMhyhfUvqyDqqOwdp6rrKPWqzo5KzHmy+Gu0QJSBno2+I77yqV8lPFU5GFbFTQtGP/BhLfednH+cHtwuYRPXxahddk0Ys4qkwkLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCodjd9VOyvEQnNJrR4Rt7Mk07n8czE3+XonLzgIW6M=;
 b=pKZtdWQY9p04WWHPVeMMNDW87qX2v4k+3mUUsKUIk41BDuj+iXD0jC/AeFeTxy/GzjLwYYzt2BfmoQi7cCtwdIXVgCgDY+yik5N/0ORGGiQ52nqfJ/EB9Jm33HqaO57UlOId4tt0VnTUu8UaFHyLgArZvRijQ3k3RhIDdV7sMBpSAh3bWjeawzDbNwjOoVTWZoJuRkVwEyZFFTO/jrRq8DZViDNdZZDVjWbqFVsBuIVxmSMrsxH0nZFelOpKz0/sl2FHE39QNwpTdvknjdECEKkZMSsw1DcvuLAtud406Rcq3xa3OjbSh5OWt8c3I/gKsRFw6xPrrebqvPkFbRaNoQ==
Received: from DM6PR07CA0085.namprd07.prod.outlook.com (2603:10b6:5:337::18)
 by CY3PR12MB9654.namprd12.prod.outlook.com (2603:10b6:930:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 07:24:20 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::f5) by DM6PR07CA0085.outlook.office365.com
 (2603:10b6:5:337::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Mon,
 25 Aug 2025 07:24:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 07:24:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 00:24:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 00:24:01 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 25 Aug 2025 00:24:00 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: Shani Peretz <shperetz@nvidia.com>
Subject: [PATCH v3 0/2] Add jump flow support and queue menegment with new
 snippets
Date: Mon, 25 Aug 2025 10:23:44 +0300
Message-ID: <20250825072346.25548-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811143704.146795-2-shperetz@nvidia.com>
References: <20250811143704.146795-2-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|CY3PR12MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da47423-025d-43b5-dee6-08dde3a8683f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cCtVbVhBZFNkeWo3VXV2NzJLNU5tMWtJZDltTHlNaXhZTFdGdFJpUFYzVGQ0?=
 =?utf-8?B?UUFVYnArRXZRQ1ZlSTc2cTh4SUFZK0FxcFFUS0h6SWFsVHF3ZStnZS9pVlpV?=
 =?utf-8?B?V081ekhtanBUZkQzbXJNQ0hxbzRxMTd3WGg1UDg1eWQ2TDI5dUtHZmU3a1lL?=
 =?utf-8?B?bUJaSjVmcXFCamloYklTanFLbUVReHk4M3RrMGIwVGcxS3RSckl6ZERzNWk2?=
 =?utf-8?B?TjJYdWErSWFNaGhnR3JJUjRuNnpuZ0Z1YWsxdGRuRStSY1ZMQUhJdGhoVmVq?=
 =?utf-8?B?V0RNUCtnNnR0RWRUZXJzNWRnSmRoanRiRXVoMkt2alpWRXl1bDNmSzVGVzZo?=
 =?utf-8?B?aEpqRWk1RjY4NTNnemdvR2pqQW1VSDArbnFPcGZkanB0MG0xUDIwRWM3TnU4?=
 =?utf-8?B?NEIreHlSWHNuT3JUYnc3ZUdxZk5tZFg0dzdPOVE2Sm5JTlA5ZmFwM0xvOXQ0?=
 =?utf-8?B?eitxeW1LdVhvT3ZjN3VmWWVpa0lzTGZ1N1l5dlh5cVhJZkd1SlJTRzVlTkI1?=
 =?utf-8?B?T3VmdFZhZVFSM3R6bnhmVERmYS9iYzlGZ1ZGUDZlcjFTMzBManBhbEZEdjdU?=
 =?utf-8?B?RCtOUnFBc2ZOOW9nK2tyZ20rZFZJb0hQUEU0VHRTeTBBT1dZOHRrL1NqMmdF?=
 =?utf-8?B?NU1lRmQ0REFTblZHYTJvUnU3b3l4cVRCeGI5cWFoVmVuTlE4dWpjME9SaHBi?=
 =?utf-8?B?bEpobkUzSXBaNTZoRHpmNVFBazRvSDFLckUrbXVTTkxUc1NNZ2FQMGdCSDF3?=
 =?utf-8?B?V2ZtWnd6S3ZjdEVIRmdTK2tDMXRpbmxMWXcvVXZKTDFPY2xwbEhpalUxS2tv?=
 =?utf-8?B?UHk0QUhEeXNJeE1qNk0xMkVJbFVtRFhJWWhTVHIzR1J1NXhvNGxMeHQ1a1px?=
 =?utf-8?B?aGY2WnlBRW5LazkwUFg0bGhJRjBLY1YzMEV3eDJ4YXB3cDdQOXJ5blF2amZT?=
 =?utf-8?B?WjY2VHJQSlVZdVVUN1dCS2YvdW1aNFlHYnExVkRteHFQc2tDL0lsNmljMUI1?=
 =?utf-8?B?R09ndEJwcVp6YW1hTlpvbXN0U2diSXRpd3IybGdLMkxrZVNMQVNaNnJQeXJX?=
 =?utf-8?B?Vi9YT0F2Ui9USGdWZzZsd21zMlNGYmhsN056TDU2VWthQWdKK1hURHVZbFND?=
 =?utf-8?B?SUd3cmZNNUpxMG4xVzJoZWFsdXNtbENTUlpxMXdMOVkxdzVncHVoem0yeTVP?=
 =?utf-8?B?ZTc5dWwvSzdjY2pkR29hdEp2MkxmMFVLZmJPbWlKbnZyNmNkeUpjNExmWWpV?=
 =?utf-8?B?RmZTQm5CQUZXYkplaStkTk81UHhVR2dNOFhMUjFOZFd2SU1sZDZsQ2h4RFU2?=
 =?utf-8?B?MHVadnlaWWZJSVRvSzRGVkZTL2ZNZEYyZ1VuUUJFb1FSSmx1K0dETk4vRzFV?=
 =?utf-8?B?Rndycnk5dnJSNU9YNGVlZjM2VkY3YWtQS2VEZlMyeWFrOTB6MGg3WFFJZHgz?=
 =?utf-8?B?eGk3TUVjaU9kZmw1OUtXa0Q5ZWpHMzR0VzhCNzBKZGFmM1JNYm1KN0p3UWtE?=
 =?utf-8?B?UXZ4YmRvZlZXQTZJR3dsL1N1dkR4YWpXWWF3WTd0MGhMRjBKVXRQNS9nZDgz?=
 =?utf-8?B?UkErMVhSY2V3T0xCR3dBRnpyMlhZanFtRkQ1cWMvOVQ3MlY5eEVIWGNYNm8v?=
 =?utf-8?B?UmxJdUZmYVJKK3ZqQVBURWU1d09vK0FYNVdrNFcyUklERTB2N1Z2MkJwS0tX?=
 =?utf-8?B?SjM1SjhuQVUyaUUwQml2TnlrSmZlRlkxdUFDWjBPNkFMVzc5WW1GMG9NNHBQ?=
 =?utf-8?B?QUhlMkRqN0p0aW16L1V5WlRPc05WeE84RUVaaTViSVZ0UmJPTWc4MVcvWVpw?=
 =?utf-8?B?Y21kZEhZU0JtRTZwbUZXajNiaEd5Szlqd3pva2trVEd0UjlnVnpEUUNaQXdS?=
 =?utf-8?B?TW05WG1MekNxQXllWERCckQxQmYwVjFBS0JaWUhVckNKMkFocGZ0YmlGLzFa?=
 =?utf-8?B?dWVqUlRXUVdyUkl1ZGJMUU1rNlV2d0tRbU52dG9KYjhLZEw0K0JuUTZtY2RB?=
 =?utf-8?B?aVFONk5UM0t6QUF3bDdLckJLeE5xaENyQlpEanlucGQrZXY2MldyUlJxT1cx?=
 =?utf-8?Q?xroRkT?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 07:24:19.8057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da47423-025d-43b5-dee6-08dde3a8683f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9654
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

v3:
add comma in the meson.build file to fix build error

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

