Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036F3E9A048
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 13:41:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B61F402C6;
	Thu, 19 Feb 2026 14:41:29 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010048.outbound.protection.outlook.com [52.101.84.48])
 by mails.dpdk.org (Postfix) with ESMTP id 54359402AA
 for <dev@dpdk.org>; Thu, 19 Feb 2026 14:41:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nd8XvUpmxjIAsAzE688r4fmAVMhJXU7z+1AQtqqSuLyul3Nkg/oVG5PCQJyzqD4DdqiGKHpNWSWyUElYVPCe3/IAmXBr95us41oZeDdFODalR78DPZ2u9ZckeeP/26CU/851e6bp/mPbMC7l152DjUaGneVmCDidDBjiiI4AcBoe/vikjMudwlUh35vOmlB3aO3t3nSDVwjFCYk84TPxoGmHmlicXfn3sHdPjEsbbUbjkwEhkDt+MGCCd6N6aTdh/i+D2XhBQVhUV0CkoLYpaLWckdAsrs5DgkKZ8WbsvWEWwFy96ZahKOIzgVvwXUsBaCei0zBaWpynU9ANkGLFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=CWBfcR92CB7EtyYwNjH6dQLAA+unR6TUtpfEEvO1PNZm0G6biiqkeEdl5Qe7kGfcX2LdiU5w8ochz2BEYr4IBPVdu+65ThslIgqUQHmNtPf96F55CvCpCrrMjAr0qpUIY+xrzOxo22LXrJOVqUjoil4rraooSpUEDHQPLBcVQ+6a3k0CwBOWSKgwMXRQ2HnP23tf+R8UeO3/UuSETPBgrusRrziZG8bx6sfAxlB2Geh22PlqkW1yw0Q7FA/24EvuMXOrlWqXx7S3+YSWOAmfe91dgMGEusK/zhqbDTigBcoYMLc7XplMjGl/II2KSMh1HQQD960LPyPSU7I2RWmnmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=ql6o/oRR9TX/cU2ssPyEfgpKkmeCt+Mg79RPZ7krKyfETWj1tbrYi9wPkm5w+e3suBxg9D2D+0gYn9Pp9weJJABUU8T6S5R619BMGpb0Ly7dWanjd5SMkcG7cQaiYJvmhA3ZESLOrX78QsnNrIg8eHee/R2VN011AUxlfiuoULe8lgeXs0jW+t/FHhcpwR7HauXLpjobXLfdte/kRk2XB9lZvIXLOWmhDP9LZgRv5womhqUtncE3+iXx3mld1ML2RbA0/JAqPEjHJkLRj+bkoO2qGPChqQ3FKTgrbigACaTbFb40pf5NCP0mkDCFIG844Sc3Fwl73/S0UB+9Fch3pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by AS8PR04MB8674.eurprd04.prod.outlook.com
 (2603:10a6:20b:429::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 13:41:22 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 13:41:22 +0000
Message-ID: <22e84ac0-31c7-4eed-9e76-7a3ea14d981a@oss.nxp.com>
Date: Thu, 19 Feb 2026 19:11:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] net/dpaa2: add devargs to disable Rx taildrop
To: Maxime Leroy <maxime@leroys.fr>, hemant.agrawal@nxp.com
Cc: dev@dpdk.org
References: <20260218160453.142311-1-maxime@leroys.fr>
 <20260218160453.142311-7-maxime@leroys.fr>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260218160453.142311-7-maxime@leroys.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|AS8PR04MB8674:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a74a665-f574-4ca6-391c-08de6fbc9180
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|376014|19092799006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2NzbW5XdkRmYUJCV3d1elhzd25JemgzQjVyd1pBQVdsbGh3ZmlGVFlsYk5F?=
 =?utf-8?B?ZjlabjhycTF1YldleFJ3SDVpdHU4dWxCRGlpNUQ3Y3ZOa1pZamRhc2pvSUhv?=
 =?utf-8?B?OERheDJ5aEVqUFovS1ZFb3gxVFFkOXdkVWlWZUExVEw1MXV5QVE5REJHdFNP?=
 =?utf-8?B?VUtDbHJLbFVSVmdLejlEVGJ4MFRXWjIvS0NtUW1rYU1heTcrbVY1aXlXNGF4?=
 =?utf-8?B?ZUovemQ2cmVrQjNPWk9kZ0NUTGsyTmNVZmdCQkIzWWFzNG1qRnAxdlc4cXpw?=
 =?utf-8?B?OFdaMzhzNjBDWVp3WldUNHlWZlJzblBKWWd6b05wNjdxMXJVb2hpaWR1TXUx?=
 =?utf-8?B?cGM2MEVTb21zTEp2VXg1R1A0aXorQUtNdWFNV2xOOTNqNHE5eVp5aTVYU2sr?=
 =?utf-8?B?TmNNOHpoRU9RQTZqU0Z1MjNjOHF1eEE2Sld6YXByMDZjdC9KaU5UQWFza2VY?=
 =?utf-8?B?bEdCM0h0Z0M5SXQrTXA1OE9qUFZNVEdRUXAxc09Cc2cyUmo2UzN4SmxmSVdi?=
 =?utf-8?B?cUpINThMTjYrd2Fhb1FoVldqOHRSR202dmV4aWxzaWtFZXhlQ3lHSEdDNWZP?=
 =?utf-8?B?cVhWbUh4S25LbWl1U2xod3Q3eGFhd09pV3pWNnh2SEVYbDVWdG03d0xBZGR3?=
 =?utf-8?B?bm50eWFUYzQyTFZncys3TDZKOWliY3lxTVBEZVpZK2JuMjZmQ3kvbXZsd3Jy?=
 =?utf-8?B?ZGYwR3VTRTFRQmNZcUN6dDBsYWZ4NS9Rdk5XczVNbnF3UndQSFNHVHpWSzJV?=
 =?utf-8?B?YjlhME96ZmFxRDY2QnpFM1AxejQwWW1icFBGKzk0dm44YVpwT2VLRGU1RlNi?=
 =?utf-8?B?Uk5hOFQ5TGdrNXFmQU4xN2lPbFNhUEVLV290N0tGK3hzUVlLSGJTNnB5NEw3?=
 =?utf-8?B?Y2E3dGlYRkhmZlhZNmRPSHdLSnF5Q2hvNVg0b0EzUktFMDBRbmVkUTJValU3?=
 =?utf-8?B?b0F4MXB2bFJOL3Zaa0ZOSkNmTDJGc3JFRGdIUnZacThldXhyWXdFL0NBbWdN?=
 =?utf-8?B?VWw0NXNrU1l2YUxpSFJMelVjOVMxVHFHTlhhK2dURERiYndnYUl6a1J1MW5L?=
 =?utf-8?B?WnJTR2prK3FxRTlwLzdZWERiU3VWN0x4UG5BNVM4RHB3TnBwMEtNMHNrUHZu?=
 =?utf-8?B?UFlpaGFxQlJ3eGFFTmluK1o0UFcrNWhvR0lnTmFTZElwdy9adXdnelphSUlC?=
 =?utf-8?B?VmJmRjMzTkpJb2dXWnJsclNyYk4wRWRCRmhiUmI2MW5obldwb1UxTTd3RExP?=
 =?utf-8?B?QjN2VjU5Zll3RndzRE82NFUvRTVSc3d3UTl1a05HYmtiYTdYcldnekZKR2lV?=
 =?utf-8?B?dGV0VE9lU2UvanpLM0hDT1hQMy9vU01vWG13bXU4QThnVTJXZ1ZFcE53dEZS?=
 =?utf-8?B?T2pMczMybUN4M0dDVXUra2hjUnVLWFNsbTVaVTdTdzJITGI3NUJsdUlES1Jw?=
 =?utf-8?B?QWpiTSswNS9kczRVVXFxRDZKQXV3QzhxR2p6ZUNCVnN4S3pWSGpXZDlLYkJq?=
 =?utf-8?B?ZnRua2UwRUtYSzR4V2xwTHRCZnI1MlIyZ1Y5dnMzdGp0bnhpb2Q0b1dHK3ZL?=
 =?utf-8?B?RnNCb3EyQlFHNVhYOUlWTHVzSG9GYlpIKzArcEZMZ0xYeFYwRFJINnVWeG53?=
 =?utf-8?B?K092RnNxUXV3dWdoaVFPUS9zVFgvckNjRmhEQmxnc3RWcWYyN3Q4NEJpMERj?=
 =?utf-8?B?V3BLbFlLemNYRWhiUE10ajZDVXpKVlFJbE0rZ2E3NjRMMk1oSUZ5dTArd2xl?=
 =?utf-8?B?QlB1V2U0OE9Ob0JablJSQzNzeWFTT2ovaHo3RjFxSlU0QkorNVNtQy9qbFFz?=
 =?utf-8?B?d2VjeEU3SGVMQUtGMVVVaTY2N1NPWmNRV2kra3R0MExRTUxHZnkxMVI4bmtm?=
 =?utf-8?B?SHJvYkNFcERrTEpZVFZJUlM5TWxaZXJlNDFiNHIrL1o5bTcwd2dvRWpiQWZn?=
 =?utf-8?B?Y01BeEhGSlhEL0FlUjdLd0xxQ3pJUE44Mkt5THdVaHFPbnN0dVcyNlNtWW1j?=
 =?utf-8?B?L1Z5NmJ1S2Vsa1Z2c0dsTGFLZlMrS3N5TEJTdHNwVStnL3V0U3NQaTFEWHUy?=
 =?utf-8?B?YU9NcG56QjlySHluckZIN2FCM2JnalZhdTcxY0dsQ2xGWndZWkxBRFJxemdR?=
 =?utf-8?Q?OlBE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3ZQV1VJYi9iU01zWXV6U2J1KzV6Y3BJM0VjaitZbUFYUzA3V3ZTOGhQT2Vi?=
 =?utf-8?B?Y1FobjJ3R1piamZtRktUNUZXOGJ0ZUVTMzQ1Y1dvcFVjanoxZWwyMC9vSmJI?=
 =?utf-8?B?UHlIa3lMS2dzL0MxSDY2cmM5SE9lV2lndnVxeVNvQVE4WTdPczVXUGV6Tjdq?=
 =?utf-8?B?ZWFSYmc0NDJsUHE4MytDSkoyNDZaWUZwTmVFOU1VZjRqbkJHTkY5UmI0U3ox?=
 =?utf-8?B?Snc2MFRlblA4eGxWMjFCUjY5T1RJN0FxbXRkcXJTL2xMUStnQndueDlOUGN0?=
 =?utf-8?B?Zk95OXA1RmpoamZwLzlkaTZKRXI1bUZOSDAwNENGM0VsT0trRVc2VWhLZnZp?=
 =?utf-8?B?Qk5qUEZ5WHQvR3dYVWp0eWJsQ3Y2WklJUUN1R3RUSlNDb1FjVWRSZGVwMEVT?=
 =?utf-8?B?UnpHOVJkNGl4anV0cEV3OFNZU2ZEVlhjcENicWl3UzJPaXlyOC83NWlWRUlu?=
 =?utf-8?B?OENVdjBrcmhNVmszcjk1NzdkRkZGcDRKS3hTakM5RFFtbzYyWnl4Nkl5WkpF?=
 =?utf-8?B?bkdKdnVxam1oSXh2eGF0WmExNldhSGN4MDNpNWhKSFhKVFZjcmpTVWNmM00z?=
 =?utf-8?B?UzBvMXQzOXhNY0h0MGQ4SzZpVXZENk9YTCtYTk1WUU9QM3VJZWUwcDZKZ2kz?=
 =?utf-8?B?NVpCN2tZNU04ZnRDaU9RYmsrM01XdFdHQ3p1Q05qN3loWGl0NHBmUVJDaGo0?=
 =?utf-8?B?U2NrMHFHakFMYmNtYWo3cFpVZEhrWC9sTjRyOHpmWE96L2JWZDIraFJWek8w?=
 =?utf-8?B?b3U3WU9JT05GaERYQ0hQQVRDUTVvcVA3d3RGR0NyeEpLTHVpWEdJWitVbjJs?=
 =?utf-8?B?SUtDeTRGRzFIYUpWaHV2cjNnQ1VCUDVobWFFYWNzaGFVMkl6TVp0MlNYVkNC?=
 =?utf-8?B?Tm1FWk1HVU1rdW04OTl3RlRRWTcvc242cUJjNUwrVzhENnBnenBKRVlCRzli?=
 =?utf-8?B?Y3VMai9veExTQVdLalJRT0VMMlF6WnpSR1F2TGtSTlJnUmd6THhMQXp2dEhy?=
 =?utf-8?B?anlSZUtpNjVkS01pbXBLT0xQWDJqSmR6OXd1KzNUYU9sVlRCYzFxRTRuMDRB?=
 =?utf-8?B?dUhYcUQ5K01hMXdXZUo0WjRwbDdPLzdsN1dMNkFXKzBieGtlSlh4WUh1MDA1?=
 =?utf-8?B?UFpjbi8zdWErYWd2Nmh6UzhrMEoyQ2YyTjdXclFyd05YdmU5eDVTamtiV3ZP?=
 =?utf-8?B?aExxcjZrQS9WQ3VkNFphS1RNbU5yOXJxakxNeSt2Qkt4Y2RmYnlQRklZb0JE?=
 =?utf-8?B?NzV6NmM2d3g0diszZ25PcS8xMy95bVdnZWg1YTQ5QUZwL2wxbFZBSlBEWURV?=
 =?utf-8?B?ekNTY1VIL281bXpUNUhDRWZlNThUZEdUcFFjU2FLNjZZdmRLVTJRU1A0eXFS?=
 =?utf-8?B?Tk1KQnlFdWFSWlVpVWtnWStIelJsckUzeXcvdVpxVlAwWDBGYy9zUGQ4Y2Jm?=
 =?utf-8?B?L2NRQ0FpY3kvc1JXMFgzb2RNUTlXWFZHTFhPdnRqUjhFSGg3MWxIK0NoOUVa?=
 =?utf-8?B?eE5kb0hLakRNM3BWekR2WlZVMFZ6Q2kxVGpPYTduUmpoSGlIQUFzVDBIZE9Y?=
 =?utf-8?B?a0NwV2pnRWM1NU9xSTN5bVVTNjVTTitSSHg2NGFWRDFmL1JXVkZ3K0Z6S3ZP?=
 =?utf-8?B?Y1krL1BFVWJ1YVRSNG5QekNvcEVOOHVhM2FaQTU4TTdLLzhUWGFDS2xGbEtl?=
 =?utf-8?B?bU1DNG4wNk1lbmY2SmdDWUZiVkNYcVBDMmthYVlPL05qYWZhKy9uS0s2dkkv?=
 =?utf-8?B?ZkVGYnk3ZmpSRCtKY0tUUGFzdkxpRGkydzVHUlVkekNmbUZEUlVORXREa1JN?=
 =?utf-8?B?b0h4eXdkUVpSdCszWjkvSGtpS3BCb3BLYjdKZUN3bjNDSnpIYWJsT2VCY1BQ?=
 =?utf-8?B?MmRKWnJCc29lT0VwSzdzL29HaytkRlBVK2Q3bHNXWExSSmkvTnBTOHFERUV6?=
 =?utf-8?B?MXJZNjRNZk0yUm9WMHM0aXc5Qm9NWUVFVlR0czBlNjREQXcyVjkyTkZDQ3RR?=
 =?utf-8?B?dnFOY3QzZ2Y1M0hkMmRsV0ZRckV5THZOOVZRSzI3RDdSdTdobjBZNFVtMndL?=
 =?utf-8?B?eWJOTXdTMWpSSytXNy9RRjNrbTUyZGZKNVFJUGFZL2svbzZNMlBhMUJFQ0pS?=
 =?utf-8?B?YUczZDFvbWhHSHI4eDh1ak5lYTAyQ0Q4SzJSei9Uc0M5MTkzeGdKUzVsc1lB?=
 =?utf-8?B?VkFtWmtaN0pJWU5vYjZmZmU1Z1VxRktXaGFaOUJnSXUwNnlIZTFJeU92OE9u?=
 =?utf-8?B?VHBmVG5TUStISG5LQmNvUFpZb3Zwb3NNYUw2K2ZEQVJoNVNUa1FUdEdCeGd4?=
 =?utf-8?B?L0h2TFJvN0ZIYlZHaVZ6eDVaNUlFTkxEYlRWSjdGWDdLMVltaExHOVBEYmV4?=
 =?utf-8?Q?USYjo1kRDK/Gki5Q=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a74a665-f574-4ca6-391c-08de6fbc9180
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 13:41:22.2891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnFDrPlL071XvmQLAN6nErn+qkPSWlwuScozn5AtquSNh3qTwYFY6+e1nqMzBq8H87uj/icSFRc963i5i6I/Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8674
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

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

