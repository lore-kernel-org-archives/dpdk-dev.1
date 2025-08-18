Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E3CCA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 06:32:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CC674026A;
	Mon, 18 Aug 2025 08:32:23 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by mails.dpdk.org (Postfix) with ESMTP id CBC0040267
 for <dev@dpdk.org>; Mon, 18 Aug 2025 08:32:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8kzjuQcjjwu/FbvSmxICYKQhYlaLjoMu0m8pLpA/1I/erdaUzBANTf/b6PpK52W5dx897p0kEWqVTH9oOisrBGBXJHiExKXs+MLmjUaEXbT8k12NOmu+ShZTOnPSSFeFC+d9Y8GIiVCwdr/WNgoEmVB/FKD0yOReLT2JFNGhPfFospyHkcxNDXq+5fNWwaht4B1a/tnEyEfz0WBUcTZZIB0ci0IxzH+rXc9+/bQpGI7kq7f8UG7excCfWXC62RvF2uk8OCx3KkqQZ1XWJSPXWgXmOMsXIpSQcdgP3yVuR8+PANIzdOg6SsmODgq1c4w4wSZJMpSP2Qd6uF2v2b00g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rM08bXosSiqjHKnLuSHojBY1zt4gR+L/OkEi18myNY=;
 b=AK2UThvey1Eq9RMUJPhMMl4P1k9RDGCYpdqTdrGxVJuxAB8z92PLYj9O//BDjTkCugUbiS+zv69TqALrwb0yZnbxxHcXeOvBpfHV8sZ9zNyYo3xIZ3/VtOqR7CcckHQuSGa53oOdJKQD8nWbJdh7fSBwe9Q6xD6kxqMJgu01OI+qxXUCTKjarW9JXcaWswDpxfrWROfiiS9IcuTvjbdcLcT6WLln6LXwEtNx1xaPPBRKJDLNutASmUYhClAWXeXTMbIiQwMkvI2wr2Krou9gfq2OpTyqeRKYsWvZd7MHjBG3/FiR4D0sokl8FbWrOW9K8TKYpIaoaavT5nivduRqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rM08bXosSiqjHKnLuSHojBY1zt4gR+L/OkEi18myNY=;
 b=UhrezNS9m1BMRvv5iRV8nTS5hzNl/PkMOFI7ilPxdzk2aQ6hebHwE4WIVDgcBMNgp+bShaNLM5IwNtCKWF/St3H+tQ4i4VwKOHzqiGGbBpb074IDNTRbezz51StBzv+pIrdfpvKAJbkH/ep4ot3IkSQ//bRgj/sy4EQmGDqvlKJvEXLkdJDOI0oO8d6ceL7rpVYkv4qGXiiHxLadPbKdnsBgcIxOyF0afsQPNlh3S9Caf1anWyNHo0+0IqRkf49cU+BAxUQZhQUzGkEgLbobalPUebC6jAwQEq0OvZlSwJ3ovK3IeM5mi9EGVOZtSgzFuEquQYi6KHPb/xi2JyDnlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 06:32:18 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 06:32:18 +0000
Message-ID: <07562abd-18cf-4080-82d1-3d98b3608d52@nvidia.com>
Date: Mon, 18 Aug 2025 09:32:08 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix external Rx and Tx queues access
To: Gregory Etelson <getelson@nvidia.com>, dev@dpdk.org
Cc: mkashani@nvidia.com, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Michael Baum <michaelba@nvidia.com>
References: <20250731060849.18117-1-getelson@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250731060849.18117-1-getelson@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b1cc2de-255b-49fe-7251-08ddde20fab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlhWaTlMdkJWNXNRdWhoVmRqZ2p1cmVqV2tLZytzck5TVy9nMVBCd09UaXlo?=
 =?utf-8?B?S2RsUFV5cmdmNURrRHRWWmxCb1lZUEhNTjZNNWl3d1lmMy8yamVnVUtKQU44?=
 =?utf-8?B?MDdmSjc4ZnJCb0hWOVI3TjUvdWVXdUpUTXdGczh5ZGxqK1NjZFdUSmo0NkJn?=
 =?utf-8?B?a0FSTlAwVmZUTGRMRktQS1lSRmVBRDBtbUxwOTl3RWd1OTFDWVUzb0ZxQlp2?=
 =?utf-8?B?QisvKzIvQnJFQlRObkJPMTdIbmhSaDBrZDRCYlE1Zm55NENxcXpXK2tnQzlV?=
 =?utf-8?B?bXNoQ1MvVU0vUE0rMTVaMUd6enVlWENLdnRmN3hxTnM3bDlBckJxREVRbDZK?=
 =?utf-8?B?dG9IMm03cUUzWTR6T1pOdysvZmhURXhYSWZOZllUUVEzTnlFc0RjSGtPdG1E?=
 =?utf-8?B?dkFJWlVwdnRCSGxoL0svSVdCMk1DSkZjMC9nWEtkYVptaG9VM0llbFpZeXFp?=
 =?utf-8?B?c0h3dmZ1S3dXeFBsU2JUeVpMV3NBQUtETFpLRmpsaVFjUkJXbHNTYTNmTGMy?=
 =?utf-8?B?OU1scmZzRjlRL0FzNU1XR1BqalB0b2ZtWWczVHlZcG1kbXVpTWFtTEdHUUZq?=
 =?utf-8?B?VDBqNVBOVE1Kc0xKcmtmR1hRUW5TMDg4d1VsUkw1RW5vS1lyTkQ0NWlsYUFq?=
 =?utf-8?B?YnJyM3I3UktQbTUzc21JVzcvb2dnaXZuWHozRTBkYjhxdzliemVyRjRXSkVS?=
 =?utf-8?B?cjVFUTUvalMyNlZ6Q1VMOWEwSnROajJxTEhDZFRSYUl1czB6U0Y3WHZtNGlo?=
 =?utf-8?B?ZkxGYUZpYkkxY2RCSU1yWFd0bUdsRnZWZXJyU2NHbGVSZHQ3eXVnSGN4R1A2?=
 =?utf-8?B?NkYxNmxZRUYrL0RJRnFCZkdUdWt1dFlTV3pBT24xdnNyWkZmbEp2V0Vvbzhv?=
 =?utf-8?B?MGd6c3ZTaGxXQnkvWHhrTmhkZE94UTRpNmtueHdESm9UY093clRxUURKdXVF?=
 =?utf-8?B?VExTL0l5dTBoM2h6YWliTGVnWXNQQ0k0TlpmekJyOTBpUDBocE44TGVtNTNP?=
 =?utf-8?B?N0FKMlB3c1FyODNoc3E1NVF5Nks0YzFNTi9ubDhpcWxpVktWVGR5SjlsaDhr?=
 =?utf-8?B?d09LQXRaSzZLUWt5WUFPYTFwb0pKY1dMVE8yQStCemNpV09vTVFBYzhPUlU5?=
 =?utf-8?B?UWZHN0JpUVEzQ05lbUpCSm1EdHJlUVRaUnZLaTVYQnRCTEZUcGhpOCswQ0RG?=
 =?utf-8?B?clZVYTJ2dG5aaWxmelVnYzNEYzg4RFBQVE05cGk3NS9rRis2SHY0dVVKV01T?=
 =?utf-8?B?WTN6aHlrTG1EWTl6dUt3VFlrNWZQYkwzcnpRbmtKZG5SK2NSS2tWMG5XUFpB?=
 =?utf-8?B?WTVNOU91YkkxQUVOSS9VVHhOcHg0KzVGL01QUGp3WUdDK3BJV3FZMWdpRCt1?=
 =?utf-8?B?RnVwUkZvMUNYRW04MEVSdTVmNnNrT2RLOW1xaUNIdnF5TkxNZzh0UWk2UDRV?=
 =?utf-8?B?V2xLSEowMlcwQVV1TE1LK3htMkt0akVXandSWk5OZkdLUGZqbXZyZGV2NGNV?=
 =?utf-8?B?K1BVeWVualJwMjVsTzV4aGFnYVl0MGNiNkJYeGF1Y2l0L25LK3FpRG85V255?=
 =?utf-8?B?S25YeG9IU1NreEpKUmZna2hqbmg0UUFvZFRRQVdIdzE0Q3RsNDNNVTNwVXo3?=
 =?utf-8?B?YlQ0UDQxMWVZN3NYT1M4VUprZ0dwY3NCVnk2Y1ZMWHExUjRlVWxsZDNPWTlh?=
 =?utf-8?B?dkdaZTRZaGF6L3RPdlFBSlg0SVBYbE9iQ0xpNXQrNi9DbENOVG5YSTBEVVlW?=
 =?utf-8?B?cGZTSlJrc2tOWVo5MU4xRFJLZUJ4cmV2bEhNUitUQ3VqZnpoNnlxVHh3N2Ev?=
 =?utf-8?B?cklBanl1aXF6a3p1YXJXQnN1elhYZGFnc3FuZmlkTmFPa0t4ZklNWDhENFY1?=
 =?utf-8?B?L081eVRhb2FoWmJVbkpUM2h2bTlDNjNuWTJ1bU1KSWtMSmlWR1ExMXRSVVh1?=
 =?utf-8?Q?DDiWDJ8QUIs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk1ZbWE5Mzk0amJhVHlKM3N6Q085QmQrSHdJMjQ1Y0k5U1p6ZTBzMFVLekdB?=
 =?utf-8?B?aGRJVE5EdW1aK1ZTd3h3Tm9yc3MrNXdaMytleERteStpdmt0a3A4NGlWVGJY?=
 =?utf-8?B?d1dEbDVxUEx2cnFsWVQwa2dEN01mQTNtd3VwN3krVy9BVjcwMnhNWk45OTJE?=
 =?utf-8?B?TVZmdnlzRUxNTFV5M1RicjBTb2tNRCtzT01rWW1ZVENrZ1Z5cnEzQURZdWQz?=
 =?utf-8?B?bzVKeTJNU1o2cGZsWHVtOC9hMGNYd1VFTTh4cWtIVVlMaE80NlQ1SGU5QytV?=
 =?utf-8?B?OGl5eTFVTEZvNGhVK1Boc0YzaERjbW5la2hVazBoWk1qdVlxTTdha3U2bjc5?=
 =?utf-8?B?dnBZRGc2MDBwTzFtSmZ1bkVRUk0xOEJ1SW1qajVHUGREQ2xoblhWZUpQSTBB?=
 =?utf-8?B?UE1QRUpBL0pZMVRnWWJ5RzIrOEhMRmorRUNpTDZRcys2UmRHc0NUc01Ja0Zr?=
 =?utf-8?B?VWN5RVpsQnBlWkloalROVnJjTlNlS3RpWURKNFZrQkVyRHlremFlZXp4bTJM?=
 =?utf-8?B?enNvUjlBZWZJb1B3citidlpVOGR6M3dFT0ZQZXdCSUZ1Rk51SGZlblhLRXdy?=
 =?utf-8?B?NzE3cXpHbDJJLy95Yk5aM09YVkhva0dYMEY2MnR4QzZsUzY3QmF3M3EvM3Bx?=
 =?utf-8?B?YjVtWXFkUE5iSDJPVFdxNmZCOTNRaEJERVR3bkI5Z0hFaUJrblpBczgwMmJN?=
 =?utf-8?B?ckEyOVdENU1YTnhuR2M0WlVGaUxxN2hjUEVlVVNaOHE4OHpFbWNGTDZQS3Jj?=
 =?utf-8?B?V3l0RW5nd2MvUWFDaHF4WUo4NnF0TFNlcmpIMHM0UjdQNTRWRDlLMGZ2ZWJV?=
 =?utf-8?B?eS9UaVFOY0JFMDlEVXZvelQ3bHFGT041UzhGUVV2eEl0SzVSd0NqVzRncnhw?=
 =?utf-8?B?TkxWM1NZV3lYVnBFSDJIbnpMU1czMjRKSkc2R3p1bnArOWZzbWZLZUpCb3k2?=
 =?utf-8?B?d1dleUdOTFhTNjIrSEQ5YUYxWUtpUld6SWpPclZkM2lCWE9DcWtQOTJCbTZK?=
 =?utf-8?B?N2hVeGFYak5UN3NVT1NicUx5RXRPRHhoVkdsaEtHYjdYM2NndlNNekt4YkJ5?=
 =?utf-8?B?dHNsNUVURi8wNDJuQ3F6enNCeDRjTEVtUVg3OFFJclZ3RFVlUmEwbnFKdjVs?=
 =?utf-8?B?aEVnQUthOXhkQXhqVnNMV056SnVIWVdZMXQ5ZDdRcWltL3B2cndMTFMrcDJN?=
 =?utf-8?B?UlNRMVExeDd4Qjg3OVNZblcvOGdMT1JoUlJlTVdQVjV5SDd1ejQ5ajlndnhJ?=
 =?utf-8?B?cWlITGRFT3l0bnU3N0V2b0tPZ0RXRWZ6U1Q0QktXVTlVdW9GV2JJSzR3cnpJ?=
 =?utf-8?B?S2dXOGRMblNaNDBab1NnSExPczdvRDNQYkppT3BwbU9Fc0hwUzM3ZFhSd29k?=
 =?utf-8?B?MnV0bG1JRFFUWVE2M2dWRjN3RkI2QWZXZUlvRmU3YUtVVzJZR05ySXlDOEt4?=
 =?utf-8?B?QzdXRk9zSllIMHh5UnpDMFUyeTZ6RlV0VmQwckNmTDFKQWErdEM4UHIxeXFn?=
 =?utf-8?B?NnpERVZFVGM5VStORGEvYWd2cFhFV3RxQzVjMU5JZk9GM0pQRDdhODNyeEFW?=
 =?utf-8?B?ZGxPTjFMalN3RXNDQzM5ZHhNV0VZaXB6aGlHOXJrMll3N2dHc2hyd1VndWRM?=
 =?utf-8?B?WER2MUZaQjcxcVBMbkVtWTd0aWIrNURVTm5iZnlUYTdMUmVhbHJhZmNjd1RJ?=
 =?utf-8?B?TXIxNGhIcWwySHNsWGlFcmdZNGhMeVlzWExDWmFVWVo0NHIyTmJrQmpDSCtT?=
 =?utf-8?B?T1AycXBQNjlockYwSGZrVTBlb0lrYmtQU2MvQmd4dE5FeUZWaGJSM0hYYXhl?=
 =?utf-8?B?eVZCUGVlMzRHUG1LNGptYXlLREhnRy83WjRQVXdGc0l0TjJDWnFTcjk5VGRx?=
 =?utf-8?B?QmVGL3JTNXVOUUxZaTBVZnlLNU0rWVlHU0NGZGU1anFCQ2xjYVU3bU1EOE83?=
 =?utf-8?B?S0c5L1NVRHdkd2pjQjZsYnNkTGQzMDNPbjZxRDhWMUl4TUZrT04yMnZCbmdC?=
 =?utf-8?B?dXZ3b0tBU1U0Q1ZxMkpZVUMwcWZ5Nk43eFhtcTVtV2VFeURPL2UyZituV1dr?=
 =?utf-8?B?alNYOU1lSlpuSEJ0S2RwNG9JNWtadGpvYVRKWVFNYitDVExWRml2bzc4bFNp?=
 =?utf-8?Q?8k4vYUaucBVeuOzz7tX9O/TQE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1cc2de-255b-49fe-7251-08ddde20fab0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:32:18.5522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvEpKSRtYXK/gKbbkFq45sRkt8+0SYahDLIRoiUSkC6ozXrR6SQEotoCnfEGcAvILbZiM4M/cIvMo/Fr9AIZLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829
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


On 31/07/2025 9:08 AM, Gregory Etelson wrote:
> mlx5_ext_rxq_get() and mlx5_ext_txq_get() functions did not return
> NULL value if query index was not referencing external queue.
> 
> As a result, calling functions did not expect the NULL on return.
> 
> External Rx queue:
> 
> - In mlx5_ext_rxq_get() remove assert and return NULL if a queue index
>    does not point to a valid external queue.
> 
> - In mlx5_ext_rxq_verify() validate that probed queue index references
>    a valid extern queue.
> 
> External Tx queue:
> 
> -  In mlx5_ext_txq_get() remove assert and return NULL if a queue index
>     does not point to a valid external queue.
> 
> - In mlx5_ext_txq_verify() validate that probed queue index references
>    a valid extern queue.
> 
> Fixes: 311b17e669ab ("net/mlx5: support queue/RSS actions for external Rx queue")
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

