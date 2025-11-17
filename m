Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE49CEBF61
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 13:49:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2029840262;
	Mon, 17 Nov 2025 14:49:07 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
 by mails.dpdk.org (Postfix) with ESMTP id 532544025A
 for <dev@dpdk.org>; Mon, 17 Nov 2025 14:49:05 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H21HDrFIJUICbkcTzVEISxCvXnX2Q5cpjQJWIHNXHbw74Rvca+eHjZ9PAM5sPpWirqJW+AZY5OEHi1nv1ZyH5nonn8wbL6NSs9kRgWP9oXk8wg5RgBamfSAcuElgo5B5YeLkQ5/buBRNpzq9iv5vxnPRorOWlG42ybL6z9m3jMVfZjs9WkHIb6uG3JNXha4XZKgT6L3nMIfkQCL+OwQi1SywwKvPrBd1DHB/ZWbqJQX1uTCN4w0f3NljWLuCFABtlrwlChuaOjL3PQUY41y5RneeGVQeWMzT2hh8bL2osf2lZaaGe2Y7rJDj2TJMcbS8ijLkojUW/9NV+NWy4v/l/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hb4nESCbpjkN6mfdWKkPxwUAZnC89wLOx3KEOIHIHjo=;
 b=YFRa7EpkHD0ditXu+qrtH3HCnmHHaiy7Npxrqh4IQ7EPwazTBryNzwmyJs2Pmn7kefNxWJKVpS0khjZ/8RrtG3VcpZiKjzCg5GRdEzbwvGTTEV2M7PyJ7iAhcBpt++3ZLXi3yTdJ5v1a6+Urn2LuFUqICwp6Zrznyq1Wr1QGzp70aSiODoM4Yvko2slDDhjM5StYY36EauJMvEY1NCeo9LU3OuFMpKo1PA0Oa5tivEsJnYhUdnzGDvBtjOKV2GYbBMYpoQ5zq2qo6IwgGbZkzyHxVyOfU8oodoz43uWV7YuIbTc/vFmI/UcaEIubrrlnYzpRpNaPF9ZP+l5hOT5r4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hb4nESCbpjkN6mfdWKkPxwUAZnC89wLOx3KEOIHIHjo=;
 b=aQCdyX+ih5OrlHGj6WWW37RjnF4K8nwv1cnqisoHp+6y7dIRKP/8ieCBjFPXSqfZ//AJPkvARDCPXHn0wNkGjwzRiujnNLiXpUn+ZRuDqoqE2EJwE5jS8K2OdwNUm2IEkmi8vhyz3OMeAMm0fJvFLBVWNa41b9oqZakUObmQMiRBzpwl5tqhpAAejRZ7TIbxRu8KOrImKnP2wUn/F/MZmr/eyyekBhoyiTn7NglEVv3nCN/xELOjr2xKdDukirVEj/DPqIRv7CG8h1Fo2F4ERGyYjk6UJ2Rd5eQGKvKFBGGxmR6yHqfoPoZunni5tUinyvlqaC6YygnKIr8vApSJ2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 13:49:00 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9320.018; Mon, 17 Nov 2025
 13:49:00 +0000
Message-ID: <0ab84564-3829-4eea-be17-6b4639500980@nvidia.com>
Date: Mon, 17 Nov 2025 15:48:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] net/mlx5: release representor interrupt handler
To: Bing Zhao <bingz@nvidia.com>, viacheslavo@nvidia.com, dev@dpdk.org
Cc: orika@nvidia.com, dsosnowski@nvidia.com, suanmingm@nvidia.com,
 matan@nvidia.com, thomas@monjalon.net, Roi Dayan <roid@nvidia.com>,
 xuemingl@nvidia.com
References: <20251112074015.8901-1-bingz@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251112074015.8901-1-bingz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|IA1PR12MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: c590c257-f6d3-4a73-f6a1-08de25e00fa6
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czFWWmFXT1I3QzByczZROGJFTmtubC8rUVc1bHRYblFRK1F5ZUgxTGVxZFJj?=
 =?utf-8?B?akdXS0EvTVRzYXN2bE8wbXM0VzdPTTVqWW5wQjV2Y2xmNC9jcnpIaTRWeVJL?=
 =?utf-8?B?YTVJcDVpaWNwRmxzTm01bFlMb09DelA0NzFQa2NINXZQeVhUN2VKdDdXeXlN?=
 =?utf-8?B?YzBldUp4aFFCVnN3TDlmaVdPekVScWpGdSsxa3ZUUVVHbTJnZzhxZ1BhOHpP?=
 =?utf-8?B?eExrL0Z4SDJUc3VpcU5HSjR5ZzdSRGU2RmZKZUJyM0hTd09nL0NvZldKVmJQ?=
 =?utf-8?B?bnZUVWYwdlAyRWRrblViSHduN0tBSjFrMkowSys2UWpKbU1JSXFnTWV1SUN1?=
 =?utf-8?B?U0xpYVBCcGFLdXdBUHBZaTg4TE5CQnpsZ0huWlB5UjBWS2dMV0hKZXVmUWVU?=
 =?utf-8?B?L0dqZitGblhBdXBnZi9UUHBYOFQwSUJ4czF4blYwQ1FlTm5pYU1EaVdtVHBz?=
 =?utf-8?B?MUJYNDJ1cGJaMmgxVWxKNytMZTlDMytETkhBWXgraitKQmxLdk5Zc09zaWR2?=
 =?utf-8?B?ZnNrbFlHMURhbG14UE05Snp1dk9WTEVSQTluNEFXOGZiQlZXUTcyYmF4aVBE?=
 =?utf-8?B?S096bVJTMWRzSGhYd3JBeGQrZDNxZklxWldIRTVRb21GVnV2L1pIblE5N2Jn?=
 =?utf-8?B?dkxTN21SVHA2MDNZRXUwTXNqMG5HcnEydFBwWWFLMWZFRTl1ZEdoeDcwSnBv?=
 =?utf-8?B?bDk2VUxmVlRwUy9VWmhGQXFna0hVOXVnQWVoLzdCa21ENFR3UWtLMjV4NHA1?=
 =?utf-8?B?ejlLRElnbTIwV2dqZ2VSOW13d1RWZjdSdDlGQXhzWmlJbFZPY3A1T2ZtRUJD?=
 =?utf-8?B?OUVyTjM5blZOZ05iUE5BWE81UFV2ZGVKQld6a2J4ZTBNR0ViOGJkYjBYM092?=
 =?utf-8?B?cDluZENva2QwZDdxcThwUFQ0SmovSW4vTlVRcUV3MmtIWDNlb1dBdG0ydkZn?=
 =?utf-8?B?aWJMQTBhTXphUlFqbWxPYkNiblQvSTVPbUlnL2pOYkoxR1l0SXBSRzdGaVEr?=
 =?utf-8?B?NDBGazJmN2RVZXdaYytlNEp1c0VCNWJuT0VacDRpOVVWU3gwRHpzUkNoZmhi?=
 =?utf-8?B?WjJlTFlWa3FBN0orTkIyU0tlT3VoZmhmQTBMaUNOYmtaYmE0ZjRNcEMxYXMw?=
 =?utf-8?B?ZVQxblI0TWJuYy9UaWRIaDlVb0NkSStKcERXYVMxaTJmRkdnWGJXMkNwNU94?=
 =?utf-8?B?aS9GT1BoY2FpeGJOL0x5QWMxT21JbmJHdkxCT1FZQ1FRSHpTNGZRYVBjQURJ?=
 =?utf-8?B?dUxTK3ZaaVpUdGRYMHFOMEVsNXVtdExSZ1NZVWZxR3N0N2VJTVBHUnFCUk1D?=
 =?utf-8?B?TXI1YXozYmhnZHhrK25TZUVPcXhiMy9sbm95enFRaWR5ei9nM3hBVUhlZTR0?=
 =?utf-8?B?SVF5Z3hMK0E4dEZRdEdZSTdVckhQaGJ0V3NoNzFLZU5TVjZ1OWRreFhKaTgw?=
 =?utf-8?B?SGcwSlhLOTQvQytwNm9WUVFmWDhDN0k5Mm04Z2EwOWJWU3BkOFVFWFM3STVm?=
 =?utf-8?B?KzUwd3VyNTNwRXJMQThla1VUQ3Z4bUxtQkpaaElVaGN2ZWIwYU4zc3oxMTlr?=
 =?utf-8?B?ZGpKNXVGMjVYVHZFeUpOcEZZaUNRZEJ4eVpCWkRvenhJLzlCV1U1b21PQ0FI?=
 =?utf-8?B?NEpXemRna2grWEIzdXd5TmlHcU04aFo3T2dLdWZFaVBKeGJON2VUMVRNYVdW?=
 =?utf-8?B?Rkc0dVl4VURDdE4yNE0wL0QrUUdIa1phWWh3Qml1ak93OWFEaGp5YXY2OTgr?=
 =?utf-8?B?Ty95aVRrbmZJZ1ZrWnV5cGtPVnhMaTZuUjFlYndtbmVjRU1zdnM2NUQvQXpP?=
 =?utf-8?B?SVozY05teWRyNUVVZzNFTWZFMDFLNWloWCtFTHB5UkZYR3lyRzdrSEJsY0c1?=
 =?utf-8?B?VXRQMDYrc3M5eEc0OS9BTGs4MjNkMmpHaWlBUWp4QkFaU1BQamhoSVgzWnYy?=
 =?utf-8?Q?jfESJSw6/sLufWGthRONGJLSDTlFCamR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkNaVDNUNk10VFQ4Rzh6K3M3cU41Mjl2WWVBNVpNS1YxMzQwS2N1TER2OWR5?=
 =?utf-8?B?ajBVWVJsSzllQmozWEpWeTRiSlpzOGhLcnJZbnp4MDdrc1JJWURNZUNPTmR1?=
 =?utf-8?B?b3hjeGpEOXpYWmpjMnY2NmZ3bERWN2NQN3JDTi9TY2VKbk9tbmFBejFGUTlz?=
 =?utf-8?B?VTBzYVJnb3Z2QkVPc3pKUk5nZHlHRU1MVmZCc1l1aWVvbFNhYjd2T0dOeUl2?=
 =?utf-8?B?MEoweDBpUnlNbWFaUlhrUDZheGJRVkUrcUs4WFpMWk9vYWR3cENuaU1LR2Y3?=
 =?utf-8?B?UmZXc1A5UjJMYllUUllRbTllRWFOb3BPVjJiVWF4UHJ6dG42R0hsZnFWbWxM?=
 =?utf-8?B?Q2RuSTRoMmEwK3A4THYyTWpqU1U1eUtLa3hBUHN6OHZzWGlGYkJMTUtEUFpZ?=
 =?utf-8?B?Ly8wKzhDMG9icmNJRVljZy9kYVdDZkkrVXZYZmJWUFN1Tm96NTV5aUtZRUZi?=
 =?utf-8?B?RE1UeW9kSUo0Mko4US9LOUhaMUd6OTY4VzMvcGl6Q0hyOWRMQTRlckVmNUxp?=
 =?utf-8?B?b0MveVhKb21uQXdUdURhZXdkNDBuRTNJZnBOWUdKYytOL04vaUtWMkZKeUNZ?=
 =?utf-8?B?MmpkeWZIL3creEVrMms1dituUXkvcWtDWE5zSWJaY2RnYlNtenJqT2d5NHNq?=
 =?utf-8?B?OUN3OUp6aEU4ZXRJdllrRUNyZG9YWWs4c0NZVThzR1p6SjJBb2xabk1rTFdr?=
 =?utf-8?B?QXUxTFBVbFdodkFDZEJGaVQyTHFlREZLSnN6WFhMaHlRQXBBOXN4MlBYSXVQ?=
 =?utf-8?B?ZlVCaUsxNVBSNWtSR3BHNlFrRWNoVTdhV0JaTU5zU1YrcnRVZ3FtczVaQW9K?=
 =?utf-8?B?NU14a3RlRktLdjV5RGhCVU5RWmd6MlQzN2FQekh5cHpWdm5PV2dLTHBUR2Ru?=
 =?utf-8?B?WFd3b2d6Zm53aHQ1czVlQ2loOFFiQ0oyZzRQSlB5WndxelU4VlR4WGFKU3RD?=
 =?utf-8?B?Q1pQNWpYQlhhRG9EcXdzOE14enU4REw5TmlTWjhETmlOd2pPSzNtZ25qTDlL?=
 =?utf-8?B?NGFFY25JYWI3S2Y1bEdDY1JTTkNRZUtIcWdBeitXQnlMeS9oKzF2clFFUGNY?=
 =?utf-8?B?Qzc1UnJTTXNNUStKOEs1MndnRkpUd0kxNWw2dGZzSU9EYUZXa2NqNVp5N1Vu?=
 =?utf-8?B?NFNZZ1haRG9rMGI2NytBOEJseUVNNTFVQ1FJZHBTV3MwR3pnSWF3aHpPK0hr?=
 =?utf-8?B?bG4zVHJ1ZitTTE5hZVhKYjZCc0hqZlBoU0hJUThxYzQwMktLb0E1Rml6dWJH?=
 =?utf-8?B?YXY2bHk2S3BKcm1SUlBPeWF3YW9wMUptZlFHdG9kK1d0RTFhdEZXaFRWNkVG?=
 =?utf-8?B?WkNML1ZmNjNkKzZQRDlZMXVBWHZKNEJvZU84SVJJV3JObXVIMDF1T1hlK1lY?=
 =?utf-8?B?cW1Zb2NHWmRvTmZ6ZDIzazYzaDBOSU9IRUJPc1lwbWtDY0dkQTVkMG9EazZR?=
 =?utf-8?B?RFRoUTByVlhROVFLeW1nUVQxV0JUK0dWMkxqMUR2QXhWVWdkQ2RJc3pGOHRT?=
 =?utf-8?B?ZGZ4eDJMQjBVc0NpMmcrTmZXR2pEbjhLUklFS0t0VTRRdDdpeVBpRDRtNEMw?=
 =?utf-8?B?THEreEtld015ejB5QkdlbkptYmU2elp4VVpQcmszcXpsQnZZdHZJZ2xkWkti?=
 =?utf-8?B?Vm5lWGtvOTFaajkvL1dxNUp1TkxLZ3NJdk9WajZ0cXRPZ1k5S3hiaVFQa1cr?=
 =?utf-8?B?ekh3N2tvVEdDRzRMWjcwdGpvUGxWcG1GNUZjYmZka2xCTWFWQklHOHhYaHhr?=
 =?utf-8?B?aDlacUZ5NVo5MzlBZldMcDRiUVdWdE5Yd1NQMkRHY1VkelpyRU1EYnZtU2lX?=
 =?utf-8?B?T1VTMnJlTmljamRDVWRTUnEzWUh5MVRjUWsyaHA3ZXFVeDdwLzEycEZKOWds?=
 =?utf-8?B?TWJpdnBVQlVLV3ZwVWpwVnJnYThnS1hKdzVKZUV5SVYwRkVNdVdBUzdzVFh0?=
 =?utf-8?B?b1NJMzBRM2FzMis5TFdMZG9sTjZtMklJVUxocmpZdnJ5ZWw0eS9KM0hqRkcy?=
 =?utf-8?B?d2xOcnRyYncrZVY5Sng0MEhxSFRMS0FkZ2ZZWXZIYTVuSit4WFlaOTRkMXZY?=
 =?utf-8?B?WEQzQ2NySFBHZDZ2WWg0TU1uZkc2bk8vMXhVNEp3SGVGS3NQbnBEWStzR052?=
 =?utf-8?Q?UYzWcOeYMy8QDzgvLO8RXvNh0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c590c257-f6d3-4a73-f6a1-08de25e00fa6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 13:49:00.4427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAt4x2oDH5+p/fwDq5caD+7yKuN1Hhgpx91im+wXtn1rwAzgmphlYpuFCVBw5YlulzRfRYzUBEJ42WCIeY+jBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041
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

Hi,


On 12/11/2025 9:40 AM, Bing Zhao wrote:
> From: Roi Dayan <roid@nvidia.com>
> 
> Looks like commit the cited commit removed the representor
> interrupt handler cleanup by mistake. Fix it.
> 
> Fixes: 5cf0707fc7e9 ("net/mlx5: remove Rx queue data list from device")
> Cc: xuemingl@nvidia.com
> 
> Signed-off-by: Roi Dayan <roid@nvidia.com>

Series applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

