Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F09C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 06:24:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A4A14026C;
	Mon, 12 May 2025 08:24:19 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by mails.dpdk.org (Postfix) with ESMTP id 744AB4026A
 for <dev@dpdk.org>; Mon, 12 May 2025 08:24:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SaM1mjJYAtvvl4SCLcWJdplvbDK2Yjbh3kE/AmUUrRV5xqN++9fzHfWXXC49ynB9FzQI/Y+A41CNGnPTpcBV5Y5P9GjOjHzobKrNFcdHt9ym9r+Yvm2Rph950g4DbUD4xIRbiCvvr6hSZcWKQPjb6NzJjgOCdo+RHM7X8JN/17sYRB5hU0MtqAE0lQq8SrFgQ0EUwwCTXdFgRV74faBY+zv0CPGdnwAkPdX71t4c0IgONYLZVC9YK41qhJ0Vn30jHNST5ZHvj3toJTLnGbrXt+Y//RM9HWOJy4Yaeu32PsWSBg0gPk9yqbiMpWRNJtJ7GEjM6P+fD7YAxiDZAQGbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oLDu7KH4BuhTGjOnk8SFS4bJurnnysVesiileHi8r0=;
 b=B3+vD+nEIjfpGPywtCRkk3Ts6TgMZxZ8I1YVuzYwrpms7Wm3RxspGPHt2yGljqh8cejsAShttL6vVLtE6iQmU2Wu9FZpd+8nMF0oNFLybIpo2ElF1fJ2t4TLVvooUUTQRL0XDdCTh+wSCFtLhap47zv8Jsg2ncEjQAiZMP4co20uRujlyordL0vIS6ixdAQtRrvoEbAQxpTBCMa7pSj8AZEGZ5CJPH4qQmOWqmCcR3ZGx4FO+ZPQcN9F8FrBCr8eFQyvYIRLzpZS59k8vYt2phhGoXm/uCWHHRcX4F1S9ZLkMJiHcFlhq/cjwgzmXR9zJCVyaLTRfr0eEo/p7Z+N7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oLDu7KH4BuhTGjOnk8SFS4bJurnnysVesiileHi8r0=;
 b=jadsvv0ToX1Nk8P8FirxqTuiJMYJ9mizYl/gK2lih+u+aj3O/Hc1KTF+Cix5fZtb7KZ7OswsI4UXaTdlY4d2+b6S5k+kMmFmPIEf+vpqDEn/GJNKfPVYm8tT6nDea59Q804uBqh9Th9uZPhGC917IcJ78cBdIKUajmZ8i7T0+KXAPf6wVLIUcPSKhuvDP/OXqHUnLpi9l6D/kthS59My6+BVaNuoZOWvZB777mArajRdqVVDritHlTOcDOZPGycFB+VK9MXE/hvNi+dlrz4kbYrz37mvOfSMtDi8BI4l7xu4mrZb4RoUNoQe9/P/bmnOwQ4h/uyN58R/qek8Bqtczg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CH3PR12MB9219.namprd12.prod.outlook.com (2603:10b6:610:197::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Mon, 12 May
 2025 06:24:14 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 06:24:13 +0000
Message-ID: <b484a4d7-b4d1-4b66-94a6-6abd30d76bd5@nvidia.com>
Date: Mon, 12 May 2025 09:24:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5: mitigate the Tx queue parameter adjustment
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, dev@dpdk.org
Cc: matan@nvidia.com, suanmingm@nvidia.com, dsosnowski@nvidia.com
References: <<20250423082450.5eb6cdee@hermes.local>
 <20250424133128.133900-1-viacheslavo@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250424133128.133900-1-viacheslavo@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::7) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|CH3PR12MB9219:EE_
X-MS-Office365-Filtering-Correlation-Id: fe345e69-62eb-4ca1-8710-08dd911d9d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDVRTHRyZU4zbGFqTENSK3piOHRKRHVKY0pYVG1wcXdDQ2k2MEpRS01GV3d6?=
 =?utf-8?B?djZWd1NUeTM2Q2xKc3ZXdWlQd2tuWkplRHRQYy9ERVljMWNUK2VCZnNQUEpG?=
 =?utf-8?B?SXpnS1hNK1d4UkFPeUJGRmFPajF4ZGU0Z2dsRlp5bUJUb1BWQnYvSCsvMzUx?=
 =?utf-8?B?UUx4d1FqLy9IQWJBQjN3WTFHYzRkbEMyRVR1UDY0Ti9RY2d4SHV4eFFDSys1?=
 =?utf-8?B?alFiRmtqUDRQRlorTitVaXBFSkM1VTdEb2djMXlHWkxoT3pFSERCY2F5akhU?=
 =?utf-8?B?YnM0OXpuWmRncUhyOUE5cGI3T0ZHTEs1Kzh3QXY1TDRROTIyemROYThzR2Fk?=
 =?utf-8?B?cklZaWUveW92TEhqVzNNd3Z5dTFaYUc2WkExTEJWUmlPTlVYSEZpNnVWKzBB?=
 =?utf-8?B?d3UxQ0tiM1ZwTTFZeXQzLzNKODJicjhZYzB6ZmZzK2RMdTNCSzdpejkvTThO?=
 =?utf-8?B?b2NYa1R0MUJnM25CaHpWanJIYnZSRThoMDNqYTFsWWppVTRYaFJHV1krTXYr?=
 =?utf-8?B?Q0lISGNwbWlqaDhTN211TXYyRENSK0d3SkU5VmpKMCtzR2lxd1ZSWWJpSG5F?=
 =?utf-8?B?c0V0cjZWOVRQamxPYkVkSVBHOGtJdWRmMlRseWdUcmsvZGNlaTEwcDJmaWJp?=
 =?utf-8?B?cFRlZUlYclBYNk9VK0xKM3pRRTRpTFJOZFhiVUlzN3Y2SS9HMkF5TGU5V1Zo?=
 =?utf-8?B?SVhCeE1kR3pNWXI4Q1RjUDFDZWQydU91VkFqN3JuajB2dG82ZUJ3Q3lrOFB3?=
 =?utf-8?B?UzE1SCtPdkdTeVlIUThnRjhtWFZTSlhtT012NHpISGpOaHlUQlMyZE9Oa29U?=
 =?utf-8?B?M1RIb1IzcDdQeHB3TnhiWkVvTDloZW93QzIyOVVtckFxMUhlUVQyQnNWazZj?=
 =?utf-8?B?MTRkMkRycDFjUG5uSDkwMUlvUU1XcVREdlE0Vy90QnlmbllYVVV0T2o1anEw?=
 =?utf-8?B?MS9ZVGo0WTFXdGduaStzd0JBTllTRnN2SXRGNUw3MlpYUmtPT0pJRXJRMkNY?=
 =?utf-8?B?cGdRT05zY29ja2lGSnJQRzdkTVYrb3FLUk9zNFBXRkxQUXdGZ095Wks0ZTNp?=
 =?utf-8?B?Rm54a095MlYzRU9LeVpNNlhJa0k4TjJYWGR6OE9QNTlWM09MWmszNHJwR1hr?=
 =?utf-8?B?eGZYcm9ncmtiMGRma2wxWUU2TEQ5b2I0YUo5L1hYYkNPTjRsQk05TUJLZ1lR?=
 =?utf-8?B?R1BVZ2syVWNEYnlDQzhDR3FIMmEyblR3ZjVSK0k0dVMzYUl5MUVwbDdsdlJo?=
 =?utf-8?B?VkNjQUxUeUovTHFFWmppL3k4cFl3RnppVWc1aXl6QWNDNVJQL0p4eFNXbVBq?=
 =?utf-8?B?aXRsTTlWdFo3UXllcm9sSTdRbG5IVmlQQmpqVUk4RWowZFo3UFB2NkowREpE?=
 =?utf-8?B?SjkxWEFGWWk3WndBS3duVmVWeGY0Y3hUN3dJRVZYWUtZTnErcGtTSE1rcTVr?=
 =?utf-8?B?TmUxblgzWXhRM3hzNC9NQ1NJNENPckdBcC9KL1F2b3Q5MTJKRnZKMTZucGxD?=
 =?utf-8?B?TVh5YllWRi9ZUjVOUXJHVDduTWlZQ0VXOTltYnp3WHh2S1JmSFhaZjdBc2li?=
 =?utf-8?B?d29VTVMvV1ZpOE5aMUZwTUhtM2RrVi9FMGovUDRibytCRjlNc3Q3d0xIcUl4?=
 =?utf-8?B?QUVRbzUxVkRmTkZCUnptZ3QyTTcrV3h1VFlSeXd5bGJ0TG91dFNzMHZWellR?=
 =?utf-8?B?TlRlL0pRTm4xSmtKSGsxaFdCQjFNR0Zzc0JIV2lIQWNXajNYWDZBeHAvd3Jy?=
 =?utf-8?B?MzR1NTgweUEwbXF5b1pKNTlRR1ZHak02YmNXV295RlhDSjZwWkw0Vm1qRkZR?=
 =?utf-8?B?ellmbVQ2KzExdnQ3OGcyOGlnYlIxeXdhaVQ5TjBpMkpycVFLZjV6VGw0SjZ1?=
 =?utf-8?B?OGRSZnczTGowY1NscklPUzloa0NSbUhxS1RGbm84bEZXa3pZVFkybWtydEhL?=
 =?utf-8?Q?ysmNQRv0huM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjlERE9JdjhjZ1ZUNVJLdWc0a2hZc1JSU3o4NU54KzZkV0N4VmNMMG53d3Q5?=
 =?utf-8?B?YithdXIxNHZsVDFJVGZtaEViallQcmRmMFRKUFlqY3V5cXd2ZjQyRzZWS09X?=
 =?utf-8?B?Q25GbjMwZkJ0VFpsUGtqWTlCQXRJblRlV0F6VS9wZG1KNHdpc0Q1cEovUW81?=
 =?utf-8?B?V004Ukg5TXd3YUIvV2VSUnlPT05mU2xld2xjVkxUekI5R1Z5MWZJK1FKc05t?=
 =?utf-8?B?alVQYTNka1ZVYWtNTVVIZmtXMmpvQlhNWlVxQ3Y5TEE2b2tzQ3QwdEZHL09B?=
 =?utf-8?B?N2pDT25HRmdkVFN0MFhiS3VyWDBXUTBrVzVmQ0g1cWUxQThpeFZaeXJLWG1w?=
 =?utf-8?B?MHZJc0ZZLzkxUm9NajJvSDdCeGpmYU83d2lydkJzS1JkY0t1aDNPRmxoUURC?=
 =?utf-8?B?U2l5SWQwajdsY1RUSUJkeU54NFd1TE5PWDdLRnRtSmlVUjNpa0R2NGdEenFo?=
 =?utf-8?B?b3VHK3hvNlBCRzlzOWFBS0FKVkJtbXlWaVgzRUVIa1lYdkYxMzIxTGd6bVdS?=
 =?utf-8?B?Yzhod2ZhVldLMUFJeFR4K09IUkQycklXakU1elBYbGxTaXF0ejg0WHEyeFBC?=
 =?utf-8?B?ak1wWlc4YWpOUS83Wi84NzJNU0cwckp0S2tPMWV1ZExqZlJnVTQybnVDMmo0?=
 =?utf-8?B?UnNTKzk0RGR1V2F1NkJzSVEvN1p3a2F4SjROVlFPME9DeitIaGRxelhPUEM2?=
 =?utf-8?B?V0RNL1E0SjcvT2hxSVFQOEJwcXBUMFpxWEI5NkFQdFNObUx6bXdTWVFVM2N2?=
 =?utf-8?B?T2ZPbHovOFRVTERhODhzbXhqOHRSVGxOMFBTaUcxMjJuVnhmZ1Zkek1iZ044?=
 =?utf-8?B?YkF6NW1vUGNNNUNtUGhPY3N1dEl6eVYxOExiMUlFS3RWNTIxRUtOWDZVbEVy?=
 =?utf-8?B?MU9rcVo2cE0wTFpLaE8yKzZxdjIySUtBSDhvT3B6eTJOM01Zc1V0VXVkWTRx?=
 =?utf-8?B?T2RnVXp1MGJXdDNFZDhCSmhZY1c0TGlhMHY1K2kwTlRsNk80b0xxOGEwcUd6?=
 =?utf-8?B?OWtKbW0ydjNYdllmeEpWM3Fyd2pGcmJ3NUFGME9TSTg0WldOakZiM2QxRWVP?=
 =?utf-8?B?VlR5T1FjS3FoNWxGT3VQOUVlYUZoVy95LzBiYTFEdTNYc2NCS1UvSHJDYjFS?=
 =?utf-8?B?RVh4Z2xlK1p1YjByV0tnQ0dtNkliWjBUWnRZSXNiVDJ1ZmdKazFyRGFTczFL?=
 =?utf-8?B?b1Y5ZDNkQUlCbU9YaVhSa1dQSXltcFllY3FFSzJPUmlnKzdwLzZxSXdKdTNG?=
 =?utf-8?B?S0poQjdmNDk3VWxSbUsrQndyRHBmblNWd3lZRVd3S05HOHQ0cWIzT29yMGxT?=
 =?utf-8?B?dGhJbmx5ZCt2dHFObzBBNXV5S2U2eEs5dTB6RnJsaHQ0SVVaaWc2UnZOZUpV?=
 =?utf-8?B?REdRTEJZOFZ1VG00TjhKa2RPOU1LbVhvbXJ1TDlPczc0Qmd2cytnbjVOOVky?=
 =?utf-8?B?V1Z6RGhOZlE4VEt3Qmp2L0hDT0lXWHN1Z2hHNis5S3BqdE90Sk5oVEFjNytM?=
 =?utf-8?B?NkdEblMrZ0RyR3JxVDhuM0ZOdGFQMHljcFc2N1BBVU14MXhmTTltZnltTmFP?=
 =?utf-8?B?VGEwTUtuTWJ1MUY3aWhPaCtDUzFmWjRiN2xpWEF4UXFuTTNFUnJYVG0vOGk3?=
 =?utf-8?B?QzZmT29iQ0VFeGZyY3NFK3RrRVdXK3pJeEpiRFc0MEtNKzhpazIxRncvV21p?=
 =?utf-8?B?TnRVWEZXZHZkSUYwaUxZSGRwMytJUytFMHNrUDY2UnI4anlRcW16cVBxYTVv?=
 =?utf-8?B?aE1IcVFJUWlLUDJET3EyMG93aEk2TGRVSXo2TW5Sc2o3ZFBCWXNZSmZlQ2dt?=
 =?utf-8?B?VDZsWnR3QWRGUlN6S3RockhaY3hCcncxcnY1TzZKa1dJek0xUzF4ajNiamhO?=
 =?utf-8?B?ZmQzU0dFN1cwQ2VwNXhScmdIK3BseWE1YUxZTS9kZGVET2U5azBGd1hRRklt?=
 =?utf-8?B?MnBwTTlpakRVdDBKajlFZ3puRk1jMlpSa1hqYTVkM3JVMngwaGlYZFhWaHkx?=
 =?utf-8?B?VWh3MFpIZVdLT1lLbnJDbmdzVWFubUpIdDdXRkxYbWdOb01ZUGZwWTRNV0RS?=
 =?utf-8?B?NDN4N3ljRjBkeG9xZmQ2ZzZHdkNnbjJuajlJSC83RU5yTWpmQk14dE1HMXhy?=
 =?utf-8?Q?aoQTCuFVNfm60tG4S0MjbuOPy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe345e69-62eb-4ca1-8710-08dd911d9d57
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 06:24:13.8709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8HOZK6x2gVC+l4FtS81W4MLuD8crViGKVB8FrhrdbPmfas5dtq1PFh6sAVJvCGNRcFEAEHVsTlLKY5ZY9crLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9219
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


On 24/04/2025 4:31 PM, Viacheslav Ovsiienko wrote:
> he DPDK API rte_eth_tx_queue_setup() has a parameter nb_tx_desc
> specifying the desired queue capacity, measured in packets.
> 
> The ConnectX NIC series has a hardware-imposed queue size
> limit of 32K WQEs (packet hardware descriptors). Typically,
> one packet requires one WQE to be sent.
> 
> There is a special offload option, data-inlining, to improve
> performance for small packets. Also, NICs in some configurations
> require a minimum amount of inline data for the steering engine
> to operate correctly.
> 
> In the case of inline data, more than one WQEs might be required
> to send a single packet. The mlx5 PMD takes this into account
> and adjusts the number of queue WQEs accordingly.
> 
> If the requested queue capacity can't be satisfied due to
> the hardware queue size limit, the mlx5 PMD rejected the queue
> creation, causing unresolvable application failure.
> 
> The patch provides the following:
> 
> - fixes the calculation of the number of required WQEs
>    to send a single packet with inline data, making it more precise
>    and extending the painless operating range.
> 
> - If the requested queue capacity can't be satisfied due to WQE
>    number adjustment for inline data, it no longer causes a severe
>    error. Instead, a warning message is emitted, and the queue
>    is created with the maximum available size, with a reported success.
> 
>    Please note that the inline data size depends on many options
>    (NIC configuration, queue offload flags, packet offload flags,
>     packet size, etc.), so the actual queue capacity might not be
>     impacted at all.
> 
> Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Patch applied to next-net-mlx,

-- 
Kindest regards
Raslan Darawsheh

