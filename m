Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C502DD6E2CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Dec 2025 18:24:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D4A640275;
	Thu, 18 Dec 2025 19:24:16 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
 by mails.dpdk.org (Postfix) with ESMTP id 02B2C4026A;
 Thu, 18 Dec 2025 19:24:15 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xw8bGVcgyjm6pifjshkPUQq9if4vWOvNoL9ZQXUXZ7NZMlfAYlfM+cUXE8Fx0wIo2zyE0+3sBKRnhWuMP5gsaVHy/J2tvrT1eQ+jyqa7hQ+C8AVYJOTaCxr+/56eZmVhGOfSfZXVlSFupIdmJO/PXohTDRcxkNrYjwcZxrp4IqZ593pk4cwWW9Ro31vlxOQcH8icl/kRz3Ecpn+pzUjaktpxUkyp46bp6v/YQ+OyfPkTYy2yzmk98JaBUDoqAMBH7m9oakioOKWSRpVkDjFSr96R7QNPLjiibyqnvQ87lQvFKqI7PxuqYX0lz7Iik4OSs242ZtmVEPnG6aMklC9A7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyUJn03JSZ0WWQw/Y3fhQ7TKRVcajonZQRpQGaUCjrY=;
 b=FpBwPOB1Gq2X6PAPW0konqXYgIQ1/xEQAcJ34Z1j19hk7UkETTbWHz3ubwvraDtTy4hyz1dSsqYAcb6QzXYYAeNVqo4qw+lrDsZjs7PtHRWrfzVv5K1uE0CeM39HMrIGS3+hNSI51HwYQSTJaM8Fh4Cgu3PS36TFV7VDama8+ARulg10aHW5jVS6RUqd/Jiap9ix9t5iUuc9inYXUPXvRRh9b06gibPRq+oV3AdypwD+6APaB9skGMQkSKe2j4k073OHO6ORcW5hrMtC7ff/o5KBvTtHTXMo+xPeeD/DQLeVP3ga3JXtjtLuSWsg52IiFI2WQZQfWk14ViUeoxuhQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyUJn03JSZ0WWQw/Y3fhQ7TKRVcajonZQRpQGaUCjrY=;
 b=INe5tNG/DjUJr6JcVO2CPRPpkuSeHhw0GEQOYiP/vTVUpvXIVLDJSMku+oDKWGBkcefi7gpTNiCMrpbU6SkBfilUQaUXBDU4LvYbDGPMA9XRlmTANWedyki+loOPU+uV04ZOnUGc3S73X9hrN68tSAgmqzJHcny/BAj3TsQ/uR/Qf0OkhcZwbw0DmW1TeDbZbsqvYXOLYrDgOWt9cRjHVwdN3k/31Wbikypac6LTKHZjMuL7Q7tz8Jix+H1Ucm79NuKQVA2FOQ6qrODqZjRZ1nJoPpB95vzY5O4IPcWlR8ojyieWhQDN+fZW7vigPtnear0vO55F6GVNTSTl/HZYSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9)
 by SA1PR12MB8860.namprd12.prod.outlook.com (2603:10b6:806:38b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 18:24:08 +0000
Received: from PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::4be:bdae:b21:3fd0]) by PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::4be:bdae:b21:3fd0%3]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 18:24:08 +0000
Message-ID: <18458ac8-1c0d-4bc9-bf4b-97ee06c1eef0@nvidia.com>
Date: Thu, 18 Dec 2025 20:23:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: 22.11.11 patches review and test
To: luca.boccassi@gmail.com, stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>,
 Luca Boccassi <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>,
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon
 <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>,
 sbadawi@nvidia.com, waela@nvidia.com
References: <20251204005603.3236032-1-luca.boccassi@gmail.com>
Content-Language: en-US
From: Ali Alnubani <alialnu@nvidia.com>
In-Reply-To: <20251204005603.3236032-1-luca.boccassi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To PH7PR12MB9173.namprd12.prod.outlook.com
 (2603:10b6:510:2ee::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9173:EE_|SA1PR12MB8860:EE_
X-MS-Office365-Filtering-Correlation-Id: e1478d37-7680-4b44-015e-08de3e62a1d9
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZjBqN000cEdIaGZnRjR5Wm9zUXFtV0JGbkdzbXFPVXFMVHROa05SUk0vbWd0?=
 =?utf-8?B?UnhCd0VYN0NRNTMwSUdFTDE4MlJlMHVuVTdrdGdZYlFhZTU4cUF2cUd1VWhn?=
 =?utf-8?B?c05oQ0tFT0ZYc0ZhODZHb2hHWFgyaER0NFd6NU5qREpKc0REUVRIdERaRW5H?=
 =?utf-8?B?Y09FSU1VMlZOelROTnNTNTFsUGVuSWRFSXNqUWxmTHR4VVQ5dHlseER1UHlP?=
 =?utf-8?B?UDYyRTVCWEs4YlY4N0RzSkJYdmVUcVB6Vkd3REdqU1l1SHVoSzEzOHU5bVVl?=
 =?utf-8?B?RWlyS0tIdWFOMTlKS3lZK2V6Tm1jeUw4d1VxK1dOdDBBK1M4Zk1HQ3RnelR0?=
 =?utf-8?B?ek1LeVcyOVdjVThDc0JOdUVHQUNkKzl0MFBJR2lMaDhhVCtSUWhDVS9sQlZC?=
 =?utf-8?B?VVRkUEoySTFsbTRiajBVdHBxYWNsUlJCNFEvckJOTE84amFSaG50cER1MFZt?=
 =?utf-8?B?bXIwYUFrRi9pN0pHcmtqUWpkOExYYitYQTkzRnJzNEg4a1VjbkNzTUZGMmtT?=
 =?utf-8?B?ZW9CNENtL3JXSEFUa3dkbXB2OU00M1krRzZMeml1SzRLLzFEU0lOa2s2emky?=
 =?utf-8?B?ZG1rSmZOY2U1UlNiQlRLWk5SQzlLc0F1d01qU1hEM1lxbHpvMStwVitPWHEx?=
 =?utf-8?B?TklncW9QYisyNUo1UVc5STZtaGxpbW04WGRZK3Z5dnIvcHhCL2krTU9SalZy?=
 =?utf-8?B?VkgrT04yWVNYKzYyeEhXeVhLM2Y1TldQbWJBOWNWUUNkblhlb0UxbkRiMjV1?=
 =?utf-8?B?TnBIVDFoRlowcGpmZEFBc1FPT3U3SzNGV1dLYnJTdXQwL211MlpkdWlUY2px?=
 =?utf-8?B?bVMzRkhRejVVTlV1ZGhTYkNGbVF4NUlIM0ZrSWE2YzFLMmI3bjJoQmtRT2JV?=
 =?utf-8?B?NHJrbnRSNWdwOUtlRTBEeEhQUDFJOHZ5c3paTlI1MEhsc3VQUFBhYkhaYXB4?=
 =?utf-8?B?d3RtRXluK1pRaWVxSU5QUkNxYml1ejU0U3MxR2tEMVRTaW9kOGRKNmFaRzhz?=
 =?utf-8?B?Q0cwZzdHWThNY1AzTWx6Z3EyVWZGcDhYZzJnT1o0Ly9YMWUyV3BIdUZZZU1H?=
 =?utf-8?B?b3A2VFVjVlhiNWcrSUlkM2lMOGp0TSthRmo3U0xnODJGWHlraDdDdjBvbjBy?=
 =?utf-8?B?bDJGaWFlMjRBSnQzallOUnBTMnIyT3F0UEVTbjJtSWlmazVUWWI0bkpqck5S?=
 =?utf-8?B?S3FrWTVxUXJtYjZ4YmlpSkxoNlRYOHJ6U0FTaUVvQzZ6dEpUdzMyb3BzZVNr?=
 =?utf-8?B?QTJzclRGWURaQkhuUWVCZFJUSFU5WXFqamJLUVVCY2hYaVdrTVZqdURMOE9s?=
 =?utf-8?B?RlZKSnp1MVJKM0ZsV01kQTl1aGdwMFFiM2lqM25udzJ0dVdqZkJOenhIM3Rq?=
 =?utf-8?B?NEdiZzlVMnUrWnVuVlRaUjNiWEsvUWtFREgzN2dxRHFxdkdtSGYzWGxaekp0?=
 =?utf-8?B?NHF2T2JtNEdaaVA3ODIyRWt1aFhEV2RFeWJDWkE2TUJIUlNpNklMb21DUXhl?=
 =?utf-8?B?cG9LT0FFdWJDU2RmT2pTUUxJSXJNRTdJcFNxZWIwSEN5U0lEeDY4aGd4Q0Fi?=
 =?utf-8?B?T1hLY3luWk13QmkrMlY1MDFqaWNLc0RhWjE3aWRiQVRTMzFCakFZcjZjejFU?=
 =?utf-8?B?L0xSNWFUZEJJOFVWSFJNN01mcDBTcmRDTkl6c2J3ZjdQQTRXY3J1RlEzcVo1?=
 =?utf-8?B?VHdvdm9DZHk0Z0ZocGxsZDFzbkYzNVhNWmxBY2pjNGZDZ3VqUldRL3N1ajA0?=
 =?utf-8?B?cXVxdlVtdHZvbDJxcFNVdkk4ZFVXL1d0ZWh2SGRpWWk3UmdobmI2QzNiZ0Vn?=
 =?utf-8?B?cnBNUmUyemVsTWRENjQ0bGUvRzRkZDZ3d3luZkZINjdmazZtVEcvR2tqV09j?=
 =?utf-8?B?RHBpZlFKdStTbGNVdnFPLzR1WXg1L3hrYjFxb2RRQUhRL1lzZG1mRnkxa20x?=
 =?utf-8?Q?aCHH0GtFl3X/NlEPWKBBFPIkO2GeVloy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9173.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yzh5dllneVIzODlVZTNhZnc0NWxoMUk0VXpRNE9jRXIvVVJFbG90NWhrRFpF?=
 =?utf-8?B?MFFXcFpyMjhRRFJkRjdsblNWM2dHTWdFdlA0QTUvSEp2b2ZzV1lzZFB6VlFp?=
 =?utf-8?B?NHdIdFVxWUIxd1BtYTlJcFpXR0pnaHdFTm03MWdoT2ZyQ3dGVkZCTVNjczJM?=
 =?utf-8?B?NzBlUFhReEdLMU5yZE9ZSzdQeUREbkJYTFNWdmUxb2VMeW9yR09HZzd4dFlX?=
 =?utf-8?B?WnY4Y3B0VmVxZjZORXNNMHE4dFlEbnQyK3haTDZqdkttRjVsaDNPb0hrOEdK?=
 =?utf-8?B?YlNocitqcUhtb29wdFNqTE8zT3dlY0psM2tYdTdJOWV5RmhYMTMxc3V1d2Yr?=
 =?utf-8?B?TUFjRGdwbXQ3cXllNTBFbU0wZXVCcWRibzZsUXpLZWFkR01tOXRRMXhvZlJy?=
 =?utf-8?B?QkNhaHpvRko3cnFiUTlJc2p6Sm5ZdGRhdTVXRXVIanNwRndSL2FOSktGeWFl?=
 =?utf-8?B?RHk1TzFteFFhOWhHMWcxKzV0SGNjbU4zY1dLb1c3K0Evalh0MWFDSUdTQXZU?=
 =?utf-8?B?cXh1NDdsNklRMXpiQUZVdmZ0TmVUcDQwTDdwYmR5QS9WSldwUTRsQkpGa1Fx?=
 =?utf-8?B?S0xUcCtBWE04ZlJSVU56ZmdHZkRMRG9uTklKbkdRalhwN3h3ZFRBS1RkTUJi?=
 =?utf-8?B?VW93b0dXUE1JejJMN2hOS0lJVllPS1RuNDdYem5DckhKay96bStzWmRRWkpB?=
 =?utf-8?B?WU0yd1k0Nkk1YVdGQTVIcldUV1hhSFV1U2NVRlc0Rnc0dHJNSS9kZ042cEVt?=
 =?utf-8?B?d3FReXc2ZHpNVS9RNk1IcE1vd0JWbEozUHAzSy9kRGtaRWREalAxc0Fod2k3?=
 =?utf-8?B?c01xNHFERFBjK21sNEZHc1piVi9ocVgyNWp3R0MvTDdRaEtJRTJ5ZjhLd2xp?=
 =?utf-8?B?Z0FNcjhnVDQxMTRxQTIxcmE5QkpQSVpOOVcyVDM0U1RWVHhHM0lCRksxSkJ6?=
 =?utf-8?B?bTFXdnkwV21tK2FueDEzOU9HcHJ4UCs4a09qMFQ2RW8rSnJFcEQ3K1QrR1B0?=
 =?utf-8?B?ZFZrejBqVk1udDI0cGxIa0NvUXBwWExyVmZjVDdzQ0dvVVVsTzB3Tnd4YmRj?=
 =?utf-8?B?N2cxSGdKWCtQL2d1eXFMRnZ3UnVHNklqMGZJeFlyaEM3Q1pORWRpcm9Rdm5u?=
 =?utf-8?B?S2wvU0VOQlRiNWRtKzVFSE9QLzQ3UUhqYlVPWHBQeHVBanZjVDZEWnlhYlFa?=
 =?utf-8?B?dkdySkRJTFBtRCtaS3QxTEJwenpScHUrM0k1ajJaWTdjVGtKQ0Z2R2VIWk5h?=
 =?utf-8?B?ZDdHM3FKSjZSRDdqSFRFQzVtREd2SGN0T1hFTzlkbG1IWCs1dDU2VjJmeHRm?=
 =?utf-8?B?R3JBNFB2Vi9LeEdiWDhqT2J0dUVjdzM3aHJTaEM5VDIrSlgxWXZKUVAvTmlH?=
 =?utf-8?B?WnNsdzgrbjVWWnEyYWZ2RUlESEtRSml4NXQvWEprUStkWkJWR1k4bWlMMEEy?=
 =?utf-8?B?eUMyOXJaSzBFejNzUkF0dzEyT1JLQ0J1Vm4wMGRjNHdDTW8ybEZDSUhjZjZU?=
 =?utf-8?B?NXdjMDQwc2ZJZkFidzVRK3MyTmlwVVBkclkzeUk1SndSb04vRnVDaWQrR3JP?=
 =?utf-8?B?YVh5WkhIQTlyZTI5aGFLTm5CM1c5Tk5lSXFTL2dIeG5qNlRVc29DWlAwUU1a?=
 =?utf-8?B?dkoreEtrUlJHZkYwTFRIZkhXNElXNEZiNGtrU3pFSDh6Y3hOVU5rbWtONGxo?=
 =?utf-8?B?QXQ4WllvR3hvNE1lTnN4MkFTeXo4c3lTT0lRVVU5ZEVJbjJyOTdzVzAyNzg5?=
 =?utf-8?B?SGNZN2VodTk5V2ovZHZTNFVwV0xxMU0xZUZtcmw5NHg0L3ducTVZVk9Wb01z?=
 =?utf-8?B?UTA0L2ZNa0p1T29hSnY0R2tGZzJxZ25uTVprT0RCR29pZGtuVFZQTVI1Uitu?=
 =?utf-8?B?M25PZjV0Zm9DRDVoZS9yTHp5a0o5UGZWSGhDcGc5WGVjcE1LeWNzUm5rOUpp?=
 =?utf-8?B?NU5GbG1MK2hyRTJWMHhieXFWNnkwTndkRnU4eExmT2RlYTlWVHRlL1J6M01I?=
 =?utf-8?B?NXZHeHo5WjM2MGVIZGNvMENPOHJXTENjRldnU01GYU9NYThxYnY2bnNsUXkr?=
 =?utf-8?B?enZUMTZmOFBtMmd5d1V4dDZIMUVYbE5zVjZVaFdCZE9ZSXcvN0ZpdWEwa01N?=
 =?utf-8?Q?ISnYcHHZaKwA6YL5bioqs2eEt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1478d37-7680-4b44-015e-08de3e62a1d9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9173.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 18:24:07.8549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: niNXDUrKogtDimWwEatvd+Q6ljPxoMDfKopcO0T0pOC9usJodz0M0j6VBf7wJUu+kr2UoM5C0av+6gaqTo0xog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8860
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

On 12/4/25 2:56 AM, luca.boccassi@gmail.com wrote:

> Hi all,
>
> Here is a list of patches targeted for stable release 22.11.11.
>
> The planned date for the final release is December 18th.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>      https://dpdk.org/browse/dpdk-stable/tag/?id=v22.11.11-rc1
>
> These patches are located at branch 22.11 of dpdk-stable repo:
>      https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Luca Boccassi

Hello,

We ran the following functional tests with Nvidia hardware on v22.11.11-rc1:
- Basic functionality:
   Send and receive multiple types of traffic.
- testpmd xstats counter test.
- testpmd timestamp test.
- Changing/checking link status through testpmd.
- rte_flow tests 
(https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-offloads)
- RSS tests.
- VLAN filtering, stripping, and insertion tests.
- Checksum and TSO tests.
- ptype tests.
- link_status_interrupt example application tests.
- l3fwd-power example application tests.
- Multi-process example applications tests.
- Hardware LRO tests.
- Buffer Split tests.
- Tx scheduling tests.

Functional tests ran on ConnectX-6 Dx (OS: Ubuntu 22.04 | Driver: 
MLNX_OFED_LINUX-5.8-7.0.6.1 | Firmware: 22.35.8002).

An engineer from my team reported 2 issues:

https://bugs.dpdk.org/show_bug.cgi?id=1851
Did not reproduce in 22.11.10, git-bisect points to 58a6421bc396 
("net/mlx5: fix multicast")..

https://bugs.dpdk.org/show_bug.cgi?id=1852
Reproduces on v22.11.10.

We don't see other issues caused by changes in this release.

Regards,
Ali

