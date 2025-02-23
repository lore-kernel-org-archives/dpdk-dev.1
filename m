Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3781C021B2
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Feb 2025 13:04:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC9A4402CA;
	Sun, 23 Feb 2025 14:04:22 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
 by mails.dpdk.org (Postfix) with ESMTP id 30B4A402C1
 for <dev@dpdk.org>; Sun, 23 Feb 2025 14:04:19 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kiadOcjS8pHnRcJ+XNdrvoPWKgDb2216Q6y3lESOfyplrLTawFGI7KKbv5ED5Y1xRmGmHtt00p4jxveZHDLndhAfPCOo9lrxbb2cDXzWJ1wSTL2VYizZhHwEQnaqxI/jXIj5eFG2DOW8xZkmpkvAPz3S8q4qilNUSCQbHYhOWFSri3SMnQLqZz1A6tMi68VnUIkbhZTd2el+0fk0D4Xe3PXqNNm7mOKw5iDGLDJVcUYXoRczFs6bRjBKoIHBsMZMzhtlCsa+oHAea3s2bcFhsDp2kLy4sIBY0+Hv0IDN+y1Bt75XXEPpVQbjWcRBvF318OlwRRpsnlTxNvIjXmg+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ayp1iyzeSN3R+9xvww+fsGKWGY29cq0AGuisXkIRWDg=;
 b=TZDabr7OrTBQOHZ8+rV/R3gi9Os9v6awv+wnOKqhZeLCtzwB7v1IVmx46CkBE8Go+i0QfxPrnzh33yGDIl4KmptPunogBXmhdrQEgOE2rXVa1Txqr1eypEpZr6kvMyG4yCSN+Uu03x45KAogaN0UAI1jxHQZ838ng/TykIhkXoNndieN+/xc8fxHnYkJWy2swpsLgmxqdSpCJAIX1z0YZqYV2BUFWY6on99HjeQxbrka3odvmvpnFToeAYVQgpfoaAZfxwKtRExb36CT9Duw0BltC0pwcwVG4kpCSgfLXXBqUg6galMohUL+Xp/iicz3HP/xdDBUpZGhBUJDdPrn0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ayp1iyzeSN3R+9xvww+fsGKWGY29cq0AGuisXkIRWDg=;
 b=PRZZBD01dT0GFCh2yDux1TmBJgQUWh0b0USIxqoG6QzcjsCn2mLYOuCPlVF+Krq+nNqDzkBU+auZSaAJBq52WQc4jKuKEisPRyDa7g8LUNsKjSqJJyAKrXK46y1VOqFqtVXdvXbEmje/ZEUNTpH25ULLT+rX5M8mx+N8OKbQ3oRci0w9itBi1K3YkLJKbiq5A3GvhkQnyuUn6lRDcFM2M09vfiTKNSgKs61rlQVNwNzGAOKyupELKs1uVQAXZSvtyiNiL5rGDgPGEETabXoed+Ir4Oolvh2B9FenhTOn+OMh9UUPUbBbfVmrpAK4YqpbgTch7Oj/P5meWin9SW0NLw==
Received: from PR1P264CA0009.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19e::14)
 by VI1PR07MB6623.eurprd07.prod.outlook.com (2603:10a6:800:183::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Sun, 23 Feb
 2025 13:04:16 +0000
Received: from AM4PEPF00025F9C.EURPRD83.prod.outlook.com
 (2603:10a6:102:19e:cafe::e6) by PR1P264CA0009.outlook.office365.com
 (2603:10a6:102:19e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Sun,
 23 Feb 2025 13:04:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM4PEPF00025F9C.mail.protection.outlook.com (10.167.16.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.0 via Frontend Transport; Sun, 23 Feb 2025 13:04:16 +0000
Received: from seliicinfr00049.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.60) with Microsoft SMTP Server
 id 15.2.1544.14; Sun, 23 Feb 2025 14:04:15 +0100
Received: from breslau.. (seliicwb00002.seli.gic.ericsson.se [10.156.25.100])
 by seliicinfr00049.seli.gic.ericsson.se (Postfix) with ESMTP id
 E1380380070; Sun, 23 Feb 2025 14:04:15 +0100 (CET)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
To: <dev@dpdk.org>
CC: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: [RFC 0/1] replace inline assembly prefetch with cc builtins
Date: Sun, 23 Feb 2025 13:52:14 +0100
Message-ID: <20250223125215.358925-1-mattias.ronnblom@ericsson.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9C:EE_|VI1PR07MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce8752c-8129-45ff-1b26-08dd540a93ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDVKZHpTTWNBMjAvWGE4bVl4NjJ1dU5hcm5DS3k5c2l6a2EzdUtHbFF0UTZJ?=
 =?utf-8?B?TDJKYkttdFJ6NnR3ZXpuc2NnTEJTdTA1a25zSDg5cUVERy82aEtlT25GR25k?=
 =?utf-8?B?VWJlZEtkcFZhVit0V3doRXRnN3ZMWFVXbUw2Uml5SmREakVia3dJVzRoSFU4?=
 =?utf-8?B?a2pIWUhObGN5emk2ZXlsZ3p3SEhUSG9wcjZ4NmZvcHhnMjI2cGtCREdsQ0h5?=
 =?utf-8?B?aitCTzRDTHRwQldHSkROTzVqdnNzNFU3Unh3bkRodkhoVDVTRXlyWnJPdFNq?=
 =?utf-8?B?L1g2WWFTZDJJYW5oT1hXVjRqNUFhN0ZpYU1qbXBlL1lGOXdHMWI1aXI1VEJB?=
 =?utf-8?B?Nld3ODliNzl5N0ZQbTR0ZDZqNjBrM21wUVJrVWdvVnpkZCtCZnJvWWVWcXBL?=
 =?utf-8?B?a0J3ZFcyOWdMR0NEd1FpcVRNVUZNK3JNWW0rNlZYZHM2cU5jMnE0OU80QzN6?=
 =?utf-8?B?SlQvcHE5VHR2ZmxsaWYwUDQ0SEJYNWMvRTIydXVrVFlkWjRCVWdXd3JuREdl?=
 =?utf-8?B?RXA5cEtzZEpyT3ZkamhTZmdiRWlGakhUM0ZwWmdrd1IraVdHblg5QmtWbEhW?=
 =?utf-8?B?RERnU0IzQ0xnNDlCSnZ5Nis3b1htSkxRenlidGN4Yk9KMEJMbklVR0EvWlBD?=
 =?utf-8?B?aGZvZkkzVHVrSFd3NDhvT0FkSGZSeFZLMU1Bekx3RDFJMWhTcysvcWlhT0RZ?=
 =?utf-8?B?ZHB6a3RacStFVC9IRHFtYlN2eEp5RFd0LzhHaUlkWWNkWlBrUmt5MnFCbDlK?=
 =?utf-8?B?WFo1K0Z4SW5TT0hCVll1QUFxTTBISHp4NlRDYW41c2RETW1YNGNQMmpMVHJ3?=
 =?utf-8?B?RFhWZnBYTkFXYUV5dHQxVFI2NVN5WUcxVEhONkg2d0VPK0tyVTg5dUVKdmp3?=
 =?utf-8?B?dG9qeGN0ejN4SGZEZW9ZT1pTdkVMaHNyZnVBc2xRbm9DL0VpaGo5Mi9aWDVs?=
 =?utf-8?B?ZzlvM1FmT3liSEZwSDJpdFB1dnVocWxnOUhzK2ZvQjcwR3hWY3hOUTQ0eTJV?=
 =?utf-8?B?RzhVcDhCMmZKVCt4eDU3SWV3ZDc4NzFDTU93a045STNwUXdhNlBQNzhoT1lo?=
 =?utf-8?B?WmNtZkxYanpsc0VwekpMWTlkaG1HangzWUZFWVRpc1FUSEZ3SUJkKzdPMnpq?=
 =?utf-8?B?STFKc25WNWpLUlhhSlBzQmRXUW9XWHpKbFhmcW9lOWg1OXIrc2lzb3h0T0Nw?=
 =?utf-8?B?cEZjQnFCYWQrR1hSd1poL2VrSjRUVVZtSUJiTTJ4ZFhmV0dTZUoySlozR1NG?=
 =?utf-8?B?c09qNFRUUlYyQkFQTlNyNXpsVklnaVdlT0dPMFVCOUNGY3RyYVlQY01ZTkpR?=
 =?utf-8?B?U3B0TW1XZTRWTjFONDdBblBOMUZzVDU2QTBUVEY2clFsNk5xTmNQc0FTUWVF?=
 =?utf-8?B?UlozRjAxTUdxVFNqODdLZFlzb2pmMmZWTGU4SlczaW5ncDhtajlQM1ZDeEQx?=
 =?utf-8?B?b1FhTGFNV3dXdXJ6VVFWaGZQaVFWd3J2NktoRGNaOHN1MURGRm5pYnVUS3VD?=
 =?utf-8?B?RTFtdE5zQktLMlo1NDVwMmtLZU1mSkJUYzdMOUxrNDh0ZkRhYy96UHhtaEsx?=
 =?utf-8?B?ZFpORGM4RDJOVmhFRTRUaUU3dVZiRmhBZS92MHpVMG0rYVpRSE0vTDcweUR0?=
 =?utf-8?B?NnE4ckM4ZVRLMFhlN1dzYTExRnpyMUhXQ2p6Q0ZpaERNYzlKMlNRRThUWG9z?=
 =?utf-8?B?UmJsbTQ4SUpwTTVYT3JEVFU5eWhPTkQyazNReExZVGZxa3V3ZGFOZWRabVQy?=
 =?utf-8?B?MHNBeW5mc09wYTFraUNaSHZtaHhEQ1hEMGtBL3dreGxhUERLRndmdDUzZk1z?=
 =?utf-8?B?YmpPMFVBMDEvWnNoOTBKUE9DdDFObENMTFd3VUpPZzRndkVZVER5YXNXd2d4?=
 =?utf-8?B?SWdsOTAybU1xQjV3Q0srK2p0NERHSWJrTHVLMFRmSG9velZWd0VRWXVpMXpu?=
 =?utf-8?Q?I9jBTfP5raZdgj4nCWmduaRaDoUwmiEp?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2025 13:04:16.4140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce8752c-8129-45ff-1b26-08dd540a93ec
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6623
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

This is an unorthodox RFC in that I think it probably shouldn't be
accepted.

I thought I'd try replacing the x86 inline assembly for DPDK software
prefetch with GCC __builtin_prefetch().

Being essentially a black box for the compiler, inline assembly
hinders certain optimizations. The hope was beyond DPDK source code
simplification there would also be a performance upside.

I evaluate this change in an eventdev-based application with a
multi-stage pipeline, which heavily relies on software prefetching to
mitigate the cost of core-to-core transitions. After I replaced the
lib/eal/x86/include/rte_prefetch.h inline assembly with calls to GCC
built-ins, the reference application saw a ~50 cc/stage slowdown on
GCC 13.3.0 and GCC 14.2.0.

So unfortunately GCC uses its newfound freedom to make the code
slower. I'm guessing it reorders the prefetches to happen at a
too-late time.

On clang 17.0.6 and clang 18.1.3, the application-level performance
remains the same after the change.

I've tested only a single application, so it would be of great value
of we could get some more experience (preferably from real-world
apps).

rte_prefetch*_write() is using GCC built-ins, so I tried moving that
to inline assembly. Initially a saw a 10 cc/stage gain from this move
(on GCC), but after reorganizing the prefetch logic, that gain was
gone. I have a patch for that change as well, if anyone is
interested. (It's a little more complicated that you might think,
since you need to detect if prefetchw is available in the target ISA.)

Mattias Rönnblom (1):
  eal/x86: replace inline assembly prefetch with cc builtins

 lib/eal/x86/include/rte_prefetch.h | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

-- 
2.43.0

