Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44989E9A77D
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 12:28:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CA7E40666;
	Tue, 24 Mar 2026 13:28:42 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011032.outbound.protection.outlook.com [52.101.57.32])
 by mails.dpdk.org (Postfix) with ESMTP id C707D4025F;
 Tue, 24 Mar 2026 13:28:40 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCr1uIvLdfWOhQEKOQ+cWLwfiJDhi0NTc4r9j5b0hOOJYlAilXlmtt9NAPtHNHLwjn6ceeC+xkkstPcmgqXROVJdOthHQVHOgGDo3qfVufDyD6ZRdy1pZBbpDUrwcP+/zMiGIOWy1StbJ0r9P0APno2UkB6s0Mfn/+xTx5J8W8+S0V29kTGPPDzE/+fyHMMwzdJBV8K0kCeAVLfq4GuipQshEGjzagNjR5WVRM8+BNFGTCEX8BaAoWmnLTSqe5wseCIu5Kr79weInFjKM8XLjv2rz8il6dtB2HLxya506Y62ySz53Qiela3ncChG6VuoBbMe/OGIlKaHPgLkSSGWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JM7Eosmh7ZyrtDGwsYR9vC5rTcIJhSFTs7Nvfo0QXVg=;
 b=N9DSCK1ldAAMkKBntKsT3U9bJzgxoP8HuWRSsUhZ464am64+OQhx82cW0cdSPPFwqtEQHgh0/dc8/PcOLWayUdVcGTv9fWyMkLDNsKaPPeXHksW479+ZX13WWVFVDVfoZL4GDB6wsUYfMCasOxrn6IuNYyJoLF/xtefTKC2JhTbaxShaO5hPCI3HEeRYTtkmLtkuattxinwneSrPE49EHYMwROIUDf86x0jSoIhL/ukY32Z0oNrIkmcJycbdCjOxsO6ni438d/JAge8R1Cg8pvTc/CffKa+hH4wNxt+jwOZMQROG/sU5sc6MQE/OX5YPmrf124N1DwGUHzbc5/1Sfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JM7Eosmh7ZyrtDGwsYR9vC5rTcIJhSFTs7Nvfo0QXVg=;
 b=sIeK1N4rpGQQeBuAQXXi5XkBGIv7iy4qYX/7d83gYwPPPkJtAyIfOdf8oH8ILr462bn1IzDqqGhiao/6s7IzX0+e8LswpZTRXvPaNT7cfZClOLtCtObTEhg/WyF6DoLWLrW9xGuWVmDL95BzkjzOGlV6KuuXOqyFHndXFOy1NcyJikNtfnkpvK8o5JNhFq7Vb3ZrjhRT7PiS8bs1sSHo7mriwiM2xEpMdSUkw8UUFsIiqO8xMgNt8plgTfg1ax/RFuipmuiYyUfiVyrUYFTDfv+tefW7IkesvzpF225PB5nWI8s+rL2UGkYXH9Ictiixeujs/nz3Z2Q7hLBc3FvoRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by SA0PR12MB7463.namprd12.prod.outlook.com (2603:10b6:806:24b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Tue, 24 Mar
 2026 12:28:37 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 12:28:37 +0000
Message-ID: <8bb7a0d8-9e20-43f5-987b-492480512c35@nvidia.com>
Date: Tue, 24 Mar 2026 14:28:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix VXLAN and NVGRE encap in async flow API
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Maayan Kashani <mkashani@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20260319125345.664772-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260319125345.664772-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::17) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|SA0PR12MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d08b561-5287-4898-d440-08de89a0df8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: s8r7Vx/DOBPLXQESCglnSysYX+XMq8QOFhpH1nEqnAq0u3lM3vGjnnDaei9IHm/AeR5pj2c3nER+lQcImKICTnmafCI0WhS2Coc7DCQ3j7gJeRgPZg01ZlegswVmJahJY0xbKR0yuUywOlq7NhwKJxSia4xfuLA22R+2UjQ1rYSwQhLHBi9GRsc3TK4cMVG1uLrZIbg7va/nffuNFrzoXwRDzRt7FOO+ZOSZhahyGe4I7joRauEDSypHTM00ds1XacN+Uyt7IkE1kmsFHXbz5ta6aRusDA84r6eSeC0E2qjlA8LersUqXa+To1TWdi725xY9vbKJQwa9bte7R1OH6iZjnyirXHPoRUbpc5yDpcIDLnIAckUzkLGarBgFPPb6slNuQPoRODHKPkddTZjTNWxz9A0Nb14V4L56G7MqnZLonGhZT5c30e/0azqu20TIgQFSdi8jTywCBDJpkE4CUfACam9dZFTAH9Kh2ubtRnVGbA8OhMbtXTTIP6fVojnQKruUnN3XEDfYckWEZdy2mMdLFRoLxtw/75i4Ja112vXXDztb2hpo6pmKzc6PubrVFiiH3i7H7SV/X1ukLT6lAXWjHZaKuAekdiqAqqq2iS2wJt7YgLlKj1QDxPrSVfVaG45Xi+ox8bhadIulCfwRpM5q9Kzz/Hj9bTA2svNMhK6kXlnj73U4Gcp0twasj0Gtmt2QXIlc+B2YOO12JowTbrN/eAGfFaEvE6WM8SbQags=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnZCV1JkMUNIWE92NlpRR0F0M0ZpRXUzTnlCYTJ3MU55SWdWcFdISE9BSnlI?=
 =?utf-8?B?S013YjJYTmxzM012WVJYZE1GeGltdmRLSnB4YTBtYk1rSVR6SlZIeS9YVUtW?=
 =?utf-8?B?WGZmbTZmc0pGbHJYb2JjcHBtRS90L0xKRmlIRS9sb1hhdzI5L1N5ZXRVdUt5?=
 =?utf-8?B?THJWS2ZBVVpQaW9hSE5iaHJOZlhXd0p5ZGNyb0JpSUJINllwMW1ZYTA4NkMz?=
 =?utf-8?B?R3AvSTNuMHlrS0FLcldLVUVFTzYvT3VRWnQ2dzk0QXpyZVdMd1FGN0p4OVVV?=
 =?utf-8?B?alhlUUtXRFZIL3VzVWNJbHVGbloxS0NYTHdwOW5wYlM2STNuUWoySTRtaE1P?=
 =?utf-8?B?dU5rQWZjQ1pDSUd2RFNKTWRjQlU5bWVVc3IxZEhOSFMvc2w1QlV0SytqeWY3?=
 =?utf-8?B?aFdSRHF4dDk0bXoyUHdIQ0ZvRFBRcHpnTExDZmF5SlROYjNjbGZJOFcvSzJY?=
 =?utf-8?B?eUtPOTRRWGVUSnNUdjVRY2Z6WHBWTC9kd3FJcUhmcFJWM3h0bTdrTFVMcDVF?=
 =?utf-8?B?NUYyK250Nzc0SUZhSktVd1kraGJ1SkMxZGY4RE9oQzk3WjZ2TDBaUVpkeFVx?=
 =?utf-8?B?YkVzVytTeWhFS3dqd0E2VFRadEtEbi9sWWpVK051MXhsNjcxS2NjcjhPQXh0?=
 =?utf-8?B?VHl1ekttdlZqMDhyTDF3NFRzNklodDQzS1pwTG52K1RYU1pHVzdYdjlZK1NH?=
 =?utf-8?B?dGcyMkJlZk15a1c4d3RmS0tmdkxzR0k5Qm55N0pyMDM0aE5SL1V2OFVMYi9h?=
 =?utf-8?B?ZmRBRmxBSU5yVi9YbStJR1h5NFRjN0tHb0x6OXhDRndoWXN3dkxKRU1XTHI1?=
 =?utf-8?B?UnN2UTBUcmxHUmhDZzBZMFBzczhzbE9uRUtsZVk2aTBwdk9zRllQTWRpOUtX?=
 =?utf-8?B?R082S0NTZnZEQnRJMVN1aVpUSFNHMTh6WmVCSEROdUNBcnlLN1dXU3E4MmFv?=
 =?utf-8?B?SDI3SzBrNjEyYlQxZUR3eklEcFp2YmZPbVhaNndCdlJYZ3U4c1E2akUzbFo0?=
 =?utf-8?B?ajdlaG5GY1NIZ2MrSDNxZ0creHRqMG1XOHZqYmpoSkNkcW15eThzTlFNNUNI?=
 =?utf-8?B?anhPMDFzS0JPV05MNDN5aEZNRWFaQ01JQ2czQW5FRmNPc3o1dTBzbDl4WDdN?=
 =?utf-8?B?TmtEY0J5RDJKdlkwaUR0YktVcE1qWmZXUGVOSURMaldZWVpCaWliWHRwUDRw?=
 =?utf-8?B?cUhTNWJIVGtuVHFQUGZpYWlEQ2NnS0dVM3hSWGRsQmcybmtCK0I5RnhOQjJQ?=
 =?utf-8?B?LzFEam5SQitUTWNtZUJEWE1wVzJJSTFXYXFLN1I2K080UFlUUVB6NGhFRS9x?=
 =?utf-8?B?RWc1cXZsdWJIR0gycnUycnloSkVNc1REZ2dCQU5OeVJBK1gxdDRuTnpaaFhn?=
 =?utf-8?B?MjBILzhBZXl2TlRVQSs2M3RhMGNKQ3BabHZLQm9uaEZBclVoVC9ZbVFKbVd3?=
 =?utf-8?B?QVVMRks2cjMrTmVxZURmbkpEMUt5aE8wczYzMjBpbDFxdzJpeE1VSjN6Zi9I?=
 =?utf-8?B?cXVnWllERTk5M0NRNW9zQlBFWDBFWE9EZDkzMFlIMHhmQXFZaldNcExSQngr?=
 =?utf-8?B?Uk1zTnhTNnRudERqVWxrdUQ1THdZTnJXM21yaHZtdnd0SXRpeUpTNjRrWm1R?=
 =?utf-8?B?ZmQ2YWtVNjl6ZklKMzFnejZQZFY3NXNTUDIrczhFNnd3cmdBcXFjbk8xS0NS?=
 =?utf-8?B?TWl6SWhXL2ZBYURQTjRQaitmZWo5MnFCSHRNTDJJUWFpaS9MY2dhcytmRk94?=
 =?utf-8?B?a2tTbXQ1cTZvdVM5Y3JlU0x0MnFWZjc0clZpV2Q3aTNLY0pJNGpDQnBCSTBI?=
 =?utf-8?B?VWRWb1lqWERiZFNOa1huRDh1Ylk4cnZudlBSZ0grNGVFbmJFcGpTaHNIREN3?=
 =?utf-8?B?TU4wY2pxcndyeUdBdmFYaDJWRVRxWHVsRlhiRzVhQjRWTDN2VGJBdVJVREZj?=
 =?utf-8?B?ZFJFd213SGQxRWYzZUFrd3ppS3hlU2dlRGlaWTBXMVJJd1NLakI2cS8wOTR3?=
 =?utf-8?B?QjR3bmZ5cHAxd21FUDhCanRYWFNhY1dVaFVpVGlDa2JUM3hGcnJtZ0JGVWNw?=
 =?utf-8?B?L0pMU2dpODY1YktIY1NFdE4wVGd3V2JFRUhTTmlJUDRVVjZMNFRZc3pwSzZI?=
 =?utf-8?B?Z0JjOFFCVFhYc2c5VnVwMlZ4dUZyYzBKcnNYVkNFWEN5Q3c2b1lra2NpdlBX?=
 =?utf-8?B?elJlb2hiZkd4K2tjWDRrL2ZtRDRoLzhNbXdlQTdocXVvbEQ2N2t6ZHcxNkU3?=
 =?utf-8?B?VE05akRGbnc3bkFFLzUzMElhbVFkQnEwT0tzRWFodGNQcDViVEE5cUJYWDEx?=
 =?utf-8?B?YmVtZjQ4VTQ3S3Ryd2kwWTNLUmNXWmVyNlNvSUpuS2wrd1NuNXAwdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d08b561-5287-4898-d440-08de89a0df8d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:28:37.3745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43Kx662AENDKUiL3M51thoa13gVe7OEjgq8BToe5p1vTbQ2Oo/QhI6fBkFc+d3VOFZZf1jtEojqF0r2l0TmGcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7463
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


On 19/03/2026 2:53 PM, Dariusz Sosnowski wrote:
> If masked VXLAN_ENCAP or NVGRE_ENCAP flow action
> was used in actions template, then packets were being
> encapsulated into an empty header (all zeroes)
> instead of a header based on provided item definition.
> 
> Offending commit has decoupled translation of VXLAN/NVGRE
> tunnel definition from creation of HW action - previously
> this was done in a single function mlx5_tbl_translate_reformat().
> This was done to adjust HWS flow engine for sync flow API.
> This decoupling has introduced a bug for async flow API.
> Translated packet tunnel headers were not used for creation of masked
> encap action.
> Specifically, mlx5_tbl_translate_reformat() function has properly
> translated tunnel definition to tunnel headers,
> but a result of that was not propagated to
> mlx5_tbl_create_reformat_action().
> As a result, zeroed HW buffer was used in place of real data.
> 
> This patch fixes that by moving tunnel header translation out of
> mlx5_tbl_translate_reformat() to dedicated handling for VXLAN/NVGRE
> encap flow actions and ensuring that this data is propagated correctly.
> On top of that, translation code for VXLAN/NVGRE is unified
> (it is functionally similar) to reduce code duplication.
> 
> Fixes: 9bbe38744a57 ("net/mlx5: set encap as shared flow action")
> Cc: mkashani@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

