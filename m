Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59B0C5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:37:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19B2B4064E;
	Thu, 20 Aug 2026 07:37:16 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
 by mails.dpdk.org (Postfix) with ESMTP id 469344026A
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:37:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8ChFtaSpaROg1nmkSx6iap8Lr+S0K/CFDcGXJ/MKG1XsGABdqIiYftaABejMQKpE6negzEzDG7XwOnB+CK2beAt6AJSArOoMC93AUdb9+Bkc71CLibhT0kkfyyYz8N4oahT/GeWA9QXaEjeKBWPHIriLhNT0ZnHd4IMhjLcm8hYPCCayaRn9SG6K1u8pVjrLMIlQFAVbyZu/6cqDJusqQbrplxifj7mvdJkswXrTP4ui8eWlx2eWEyTsJwws590NcD3IlmKZ6Eoh9umS/H8Ogb7iBf0ZmJVjKRf0WtP+WGEQ9JjcPVbMjIwtYxWVBdKrV0iu7sARpH1qFjRYJje5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGBfqqwC5i6yjQVyilzxbIkgFLVpBpdMNy5m/JFfHVY=;
 b=FnohBCChDd5mU4k/KAA4FdzddMmchROTVFq0D3wuzuvXVAheK8kkdLonBkUkOInfIqMEGNMx45kRDjsx/ySP6Wds3MIqIp1edw+b8SRjMN2C32TMsHQNaWy9w6+qHujvphKM69r1JDSU0aEZYd5cTtk4SxnWAmGkjX+JM4g14Qvqra0NkGAvAgdzv3ob0LZmuEnEQH+h4+c2725d33JbSoIt19XjPFeLkZTAlJHRMvAiN+jlW+9hBD6t1zeMqqP7NgL0dGK6UbUrE40KKrFqVGuFCJ1djkKHjLKYA9B06PNn9XMraRRZYBmmVlk3jHM5Hhtcgyp4uUiEXJfwDHeuQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGBfqqwC5i6yjQVyilzxbIkgFLVpBpdMNy5m/JFfHVY=;
 b=Bgnl5Dx19pyX8v60dLtDLBfcpVEmoBwh/wBl2udEc1DMwiICHs8fINBYhp3KXr2E953KTEUj0PP6D4VP+/3Gce2vM+M7MAYC3ZxRFfgBXECP/ZSFlZLTR1JWQhfe/bMlF13XEZWEbDU8MpMIDn85scZit5NYt6xdwzU3gtxPO3nK7FRvtLCuJ6BnYlE9xXOclHx+Z4fwHGbd9Njo/ap9uPEYRQioXbkILfoPSucMpxs0HlyfbzEjkBtf6p86Q7cPLnEs3FRnKdT9Y0Brg6iHR/BRbbU+8jQxanTWLUHtIWdAD0I0kY4ZIV8jK6hCk9prDgkgI4I0hgkmGQ5z90CMKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by DU2PR04MB8856.eurprd04.prod.outlook.com
 (2603:10a6:10:2e3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 05:37:11 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 05:37:11 +0000
Message-ID: <fb648c23-50a6-4f58-8beb-a70b2f5a96aa@oss.nxp.com>
Date: Thu, 20 Aug 2026 11:07:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/15] net/enetc: add new features for ENETC4 on i.MX95
To: Gagandeep Singh <g.singh@nxp.com>, dev@dpdk.org
Cc: hemant.agrawal@nxp.com
References: <20260817063454.3290854-1-g.singh@nxp.com>
 <20260819053415.645865-1-g.singh@nxp.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260819053415.645865-1-g.singh@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0188.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::10) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|DU2PR04MB8856:EE_
X-MS-Office365-Filtering-Correlation-Id: d44aee06-21ee-4fb7-aeaf-08defe7d14cb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|19092799006|6133799003|3023799007|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: h64rFjTmz2Z1BwxHAbb/hAsnt5FVFlOkk66t+R5cYC7QYLh8zlVoKhsfwjN+QoJx/OE1b7zEMCk6rroIbYevXixKcR4ERnQ5a6/CJcanZGNK44Ey4WR+ZS5t0NgraK2ENlcjcqdLAfDIdjocBO5YP3ySOFwAl9LwVq9iHCKq/JfhM62L5dP2DK+OVP7mtvMW1+rAtx/VnXfBxgcBbLdAsbrHSddOXPr/MjJa8mhQdreLM60+FJ1Vs4AjYDgEy+uyG4tYdCa//4vlSfRTDl+/sHcWefh8TqZdlGUYQiBNXEsWimFnrSJ62AXOIy8YrLgZG/YV1RCmyjSJv8OFJ/k1bUz0gIr6Wo7wq0x4jmrGCxmDrQqYQbU5KLvYmpgGSsgHF/ABBuTAzuW96QdHVJNu/cW6RRfuWs0XujFeqPXLesO1Q8qZCOkl6JO40YcmGZ9R0ygIpRW1PIedMqoHKF4K3Cw4ldZi3oUSnxt0wV7ZOgL7GGMeIW61+NrcVE/Bw91wEWRvOSrlXA7xa3bZAwfJ4AlFAkcssezhgon3QL/HxeZkvnAAnMMy7zkzZ7cCVAawXnQ+k07c7CD6M7jfXoaAdIb2TRbO8FAuJbrqZHs2E4gk3lPRqjKOhtGLoCoWsFRscK1/xWI52UldOfyUHxYz517kZvtQQ4KQBsEV6phpbpY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(19092799006)(6133799003)(3023799007)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0hpVy90OURJaUFGQW9XZDA4aWdHQWdYOVhrUCs3cUpId0prMkpYSXEyN1hM?=
 =?utf-8?B?aUVRVTVCMDR4NTZXNGZYeU5Kckp4ZENhNTM5VWtWSklNR3YvVU5RbGZTdWVo?=
 =?utf-8?B?N0E2bTRBMHhsUVV1blBFTGNJTnVsK2txV3FuOTk3dll6WEo2R0VzRlBxS3lh?=
 =?utf-8?B?c21HL2xHSDZXY21lS0pySisxV1JpNHhhRWo4RGxNS3gzdHg2VEh1azRaNzQ3?=
 =?utf-8?B?SW8rZ3UvU2lMR2p0S2JiSllVUUZvVVd0R2pDRzYxT3EzRk1NWnFyK1BiTXNa?=
 =?utf-8?B?VHNVRXovUy9adjhEazgzeUw0UlRsdkUvb1FXQmlNMGFXcWJiKzZGS1NhcDdV?=
 =?utf-8?B?SnNOb2lnYUJJNHhjZ3d4WU5PSzRydW5nZzRwQ1ZIQXF0T29kdGcvTzZZdGZw?=
 =?utf-8?B?NU9IWks5L0M3aHhFNHlMNGZEZmlDd09kRVdlVmhhSUxiTmhLVlYrV3NJay81?=
 =?utf-8?B?ckpNWm5Vbmo3QkRnOVNaVmxURjdWeUx5VlJwbm1VOUFhenF2VVB1dFkwSnBD?=
 =?utf-8?B?RnlYOE1qTlB6OHZYQXpBakQwM1JRUTBxUkd0SGFvb3ZyNkxIaWRtbWNid1BV?=
 =?utf-8?B?RUY3NldzNUJVekY3cXRIOVdkZStUVUp4cUdrYlJsbWRSeVFrUHNCTzdBUUJk?=
 =?utf-8?B?U3BGM1IrOUN4S1F1bVNub094ZjFWdWdqcDZZZWw3WjlHZjJWV0xrbGhBOVUv?=
 =?utf-8?B?K3ErWmZaY3ZaUGdObU9WMHkrQmlqZVA5VWkvUDRybUowUkc5SEdMNzc3bWFQ?=
 =?utf-8?B?S0VwWUtvalZ2UTN6NW12NmNYZFJBeDlick1MS0d5RlpzQ3V3TjFGbHIzYmcr?=
 =?utf-8?B?WFFib3JXT3RCbDFPMjI3cWduM3NJTDkvK0pJUGRmTWRlbUp4S2xySVBHdi9N?=
 =?utf-8?B?NWdwemNSWU5ZSXVROFAreXZ4dkh4eGk2ZkFUdVk4aFVLYWVsWVgyNkxkT2I3?=
 =?utf-8?B?YmovbXovNEp3V1FrZy81VmZUYm1hVGNLYktDc25LY2VVbXgyWFF0ZHNYWmhE?=
 =?utf-8?B?TDZoV1ZMUTF4WmlzYm15RW82cWlhb3U0S2Y3L0xQUG5yOXM5WjdmWnVsK2xP?=
 =?utf-8?B?MDk1RGx1am8zSEhsdEFvamJqMmtiMWRYbHdMbEhFUnN4cXV3c0puUVNzV1B2?=
 =?utf-8?B?aTNRcSsyWExyaUFSREVxTXlLK094cEZVemtQdFdXTUlSUmkvQ1FrRzVxS1Qz?=
 =?utf-8?B?NC9GblU4L2Y0NGdTVndsSG9SaEZhTlEwdkk5VmZGbHp1Mi9XTWJ2QVpFQ1hx?=
 =?utf-8?B?MExranBodUkwSUVySk5JcXBTNnFBcUw1b1pCeXZIWWVKV0Y5dWlacmRFQkF0?=
 =?utf-8?B?YUpNdzdaQjJqZFZaTzBTcVZPVUV5VCtrNldrazR6cUV3WSswZCtKZmlXN2dZ?=
 =?utf-8?B?YlRmWndHaTdUMG41SXNaVy9PTUw3cHVuOGZBamtJVFRVdjNoN211bjdya0Qw?=
 =?utf-8?B?ZDROU0NybWJPNjRGRnZFWEhtdUVNVm9hVkNPUU5wQnF2UE8xU0RrKzRGcVp0?=
 =?utf-8?B?Y1ZIWk56UUZBQnEzRGR1NXUwUzZ1alpBM0pwL2srRENrbjcvWXpGa0hMY1Fs?=
 =?utf-8?B?WFpsbW1wam9vU0M0ODNxUDkrMGxqMkdheVdmR01xV1FZNVlmYngvRWNnNzJk?=
 =?utf-8?B?Rk1LdUJLdzFtQ0pJdG1OOExMMlh2SmZMN0JtZFNCMWVONVJ2OWh2WWwxV3BL?=
 =?utf-8?B?SjEzaCtmdnZHd1B2VXhjZG1LTFZrK2FsWThwNjg2VlV0WURPOURmcUhabEE1?=
 =?utf-8?B?dnNydElsYnpheUJjbnpqc1Fkc0VXMHFOWFJmVUF0dHJRZkEwVTBDL0RTTDlt?=
 =?utf-8?B?WjhaQndIaDJKVlBETlF1WktsVkkyQVU5SVZIZFp1Ky8wVDlDVkZVZEVrYVNL?=
 =?utf-8?B?akNLVTE3SFI1WlBtc1o3ZTEyZDRwL1Vsb2RJeEo1TU1KWGRnUzRPNkxMakZF?=
 =?utf-8?B?OXEvbHNQbG12MHdUWDFZcDM3ZzRJVWIrRXNNZnRuVnFrMEFKQUt6eUdTamZm?=
 =?utf-8?B?TDBhZW00YTkrNC80cXZwUm03aXhPNndmUFBBQ1ZtK1JJbCswSkUyK2dBVS96?=
 =?utf-8?B?aHFLRkVnTy83RG1RTktwb3BMOG11eW0ybWE3TXhWNmY4cTZkT01pUGs3Q1hF?=
 =?utf-8?B?eHBXbmhjWWNzUWhtSmJVNEZaeVBPOENQbHZNOHB0blZwNEo3dU1ub3RjTllo?=
 =?utf-8?B?WElCWCswcXM5c04yZWZ2ZEUyL0xheUJ3ZCt0WTR1SlBkaWNEZEpobE5PbXY4?=
 =?utf-8?B?TE4vWnQ2SXJ1K2hEU1ZuTUluYitkc21LSGN6bEVHRFhDSmdjMWYxZEU0WVVt?=
 =?utf-8?B?WVJHQktCUnUwbENQbEZ5bUVtbzA5VFZiZHVqTGQ2NS9NY0ppUmpDa1BRV0ZZ?=
 =?utf-8?Q?alogeCEXl0MZCIgM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44aee06-21ee-4fb7-aeaf-08defe7d14cb
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 05:37:11.1129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTh8JYNNTIy76KFEU+6hSMkJXuEnMEUArZ8ofPxhsdK42nb26KT/TJfb/Q3g4JQffKzpcVT2SrDqyauH/fM3DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8856
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

Series-

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

On 19-08-2026 11:04, Gagandeep Singh wrote:
> V11-Changes:
>   - Added enetc4_vf.ini for VF only features.
>   - Fixed the secondary-process guards leave the burst function
>     pointers NULL
>   - Fixed rxq_info_get and txq_info_get report the doubled ring size
>   - Move the VFs only features to enetc4_vf.ini
>   - Setting the dev->data->lro
>   - Added a comment to use devargs to change delay and timeout to process
>     PSI message to avoid any interrupts stall.
>   - Fixed link_update() now rewrites RBMR on every Rx ring.
>   - Regestering - enetc4_txq_wr in VF
>   - Updated enetc4_rd64 with re-read to confirm the correctness.
>   - Removed the dead code and un-used macros.
>   - Added Vlan check for maximum allowed value.
>   - fixed pre-existing ring write function for TX path.
>
> V10-Changes:
>   - Fixed enetc4_txq_prior and enetc4_txq_wrr have no effect at queue
>     setup issue.
>   - Updated ENETC_CLASS_ID_SI_VLAN_ISO reply check.
>   - Updated enetc4.ini for VLAN offload.
>   - Added else part for burst functions selection for RSC and TSO.
>   - Updated enetc4_rd64()
>   - Fixed RBICR0 issue.
>   - Removed GENMASK.
>
> V9-Changes:
>   - Mid-body variable declaration moved to top of the function.
>   - ret=0 dead code is removed.
>   - Added check on return value of rte_intr_callback_unregister()
>   - The pre-existing reply_msg leak fixed.
>   - Added primary-process guard in enetc4_vf_dev_init
>   - Removed Flow control from enetc4.ini
>   - Fixed VF stats_reset baseline underflows on counter wrap
>   - Fixed VF vlan_pvid_set fails on every successful command
>
> V8-changes:
>   - Fixed Warning RBMR RMW races between threads by adding lock
>   - Fixed `static const` arrays in `enetc.h`
>   - Proper pthread_mutexattr_t initialization added as suggested by AI
>   - VSIMSGSR stale re-read race is eliminated
>
> V7-changes:
>   - added missing 14th patch.
>
> V6-changes:
>   - fixed free() on memory allocated with rte_zmalloc().
>   - fixed eventfd and vector-list leak on interrupt teardown
>   - fixed Rx ring doubling still bypasses
>   - fixed VSI-PSI transaction issued from the interrupt handler
>   - fixed the free-and-reallocate of msg is unnecessary churn
>   - fixed unsynchronized access to tx_pause_active and RBMR
>   - fixed signed shift overflow in the register-dump version field
>   - fixed the fw_size == 0 early return reports the length of "0.0"
>   - unwanted blank lines removed.
>   - parse_txq_prior() returns updated.
>
> V5-changes:
>   - Patch 1 Build fixes which includes:
>      'prev_seg' undeclared fixed.
>      redefinition of 'dev_rx_offloads_sup' fixed.
>      Error: duplicate rx_enable declaration fixed.
>     PF loses Scattered Rx and Multi-segment Tx
>   - mbuf leak in enetc_xmit_pkts_lso() fixed.
>   - fixed conversion on ENETC4_TXBD_FLAGS_F issue.
>   - fixed link speed decode has no upper bound.
>   - fixed mailbox ops added to the no-VSI ops table.
>   - new devargs documented.
>
> V4-changes:
>   - fix doc build issue: WARNING: undefined label: pmd_build_and_test
>
> v3-changes:
>   - fix doc build issue.
>   - fix compilation issue on fedore:43-gcc-minsize
>
> V2-changes:
>   - compilation fixes.
>
> V1-changes:
> This series adds new PMD features to the ENETC4 driver targeting the
> NXP i.MX95 NETC IP.
>
> The series covers:
>
>   - KEEP_CRC Rx offload: preserve the Ethernet FCS in the receive buffer.
>   - TSO: TCP Segmentation Offload for the VF Tx path.
>   - RSC/LRO: hardware Receive Segment Coalesce for PF and VF Rx paths.
>   - Link speed code: extend the PF-to-VF mailbox field from 4-bit to
>     8-bit to support speeds beyond 10G.
>   - Firmware version: report the NETC IP version via fw_version_get.
>   - Register dump: dump SI, port (PF) and BD ring registers.
>   - Ring parameters: implement rxq_info_get / txq_info_get for the VF.
>   - Link-up interrupt: refresh the cached link speed on each VF link-up
>     interrupt so that link_update returns the current speed immediately.
>   - Stats reset: software snapshot/delta approach for VF counter reset.
>   - Per-queue Rx interrupt: MSI-X per-queue Rx interrupts for the VF,
>     enabling interrupt-driven receive with l3fwd-power.
>   - SI VLAN: hardware port VLAN insertion/removal for PF and VF.
>   - VF link status bitmask: switch VF link status to bitmask encoding
>     to align with the PF and newer kernel driver conventions.
>   - TX PAUSE: VF sets Rx congestion mode when the PF signals TX PAUSE
>     negotiated on the wire; adds Flow control = Y to enetc4.ini.
>   - WRR Tx scheduler: per-ring WRR weights via enetc4_txq_wrr devarg.
>
> Gagandeep Singh (15):
>    net/enetc: add keep-CRC Rx offload for ENETC4
>    net/enetc: add TSO support for ENETC4 VF
>    net/enetc: add RSC (hardware LRO) support for ENETC4
>    net/enetc: extend PF-VF link speed field to 8 bits
>    net/enetc: add VF supported features file
>    net/enetc: support firmware version get for VF
>    net/enetc: support registers dump
>    net/enetc: support ethtool ring parameters
>    net/enetc: refresh link speed on VF link-up interrupt
>    net/enetc: support stats reset for VF
>    net/enetc4: add per-queue Rx interrupt support for VF
>    net/enetc4: add SI-based port VLAN insertion and removal
>    net/enetc4: update VF link status to bitmask encoding
>    net/enetc4: enable Tx PAUSE via VF Rx congestion mode
>    net/enetc4: add WRR Tx scheduler devarg for VF rings
>
>   MAINTAINERS                            |   1 +
>   doc/guides/nics/enetc4.rst             | 100 +++
>   doc/guides/nics/features/enetc4.ini    |   4 +
>   doc/guides/nics/features/enetc4_vf.ini |  29 +
>   doc/guides/rel_notes/release_26_11.rst |  21 +
>   drivers/net/enetc/base/enetc4_hw.h     | 148 +++-
>   drivers/net/enetc/base/enetc_hw.h      |   6 +
>   drivers/net/enetc/enetc.h              | 133 +++-
>   drivers/net/enetc/enetc4_ethdev.c      | 517 ++++++++++++--
>   drivers/net/enetc/enetc4_vf.c          | 919 ++++++++++++++++++++++---
>   drivers/net/enetc/enetc_rxtx.c         | 530 +++++++++++++-
>   11 files changed, 2223 insertions(+), 185 deletions(-)
>   create mode 100644 doc/guides/nics/features/enetc4_vf.ini
>
