Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56EDCA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 11:15:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2EA0402C4;
	Wed, 10 Sep 2025 13:15:21 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by mails.dpdk.org (Postfix) with ESMTP id 4597540270
 for <dev@dpdk.org>; Wed, 10 Sep 2025 13:15:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BnwtzGOqkTR7IHmgjctWbTVtVYDVOyuioKVABWzmnos3pO+UhKeXReTBGWzHPj+nFavblqjmJwIci7lmEEX+rsIu2RVAlGtm5tkAI7Rvb9/gXaWDdQI+muhrEsgdC7T38QX2eIA2ju09Hze+3U8nscqoXWTp9PKWu65Fedls7mPNuc6kQ8e5Eke9NuwxoqcpRFvqArs4noR3OIK2dFJxAYj+A7CB6nrng6iqKn3hiy6z1GLUYVaqcnJo0c4so2/m2FUYL0it2AmkyAN0AuzdgLJpWxZdtIgPDFpbnRpQZVmWbzmV13Mzj8RmvRJN13LPlWKnkk4ceQiSsMvXpwMxHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiaFmrNP19vBiCyHjMoMxz5l3ZdLGJuOgE5yEqAQcgg=;
 b=uFaek/UAlreSmh1LL/FsD4zHaz2jU+KLQ5CV79sbIwbnoX13aK3wcn2RrSCqcBQeejrUMtOKMSeGiKvhfdkIF5IDIimGuOcaGimKSdhizXwdgUNABck6XwQuu3udMXWIGknf8ZmaH2axKwh2UiKjuCh9Y3qXJjf9FjgkfeeBAhQ7A9PX/Zv6yHB+r0CnElqNRbn3fZqEptl5ZK8MXD9e3dDNFbDBvVfMEihV1UBv+EibqDSUpcGCV5viUU7+Ul72J5pbyRWVJ7cpID+tLEhhEqGy/CvRjGHEv6b5aQNemV1WdRWXI32oG53fAmgsRbBrPlwdKtA22I97P6K0lENGmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiaFmrNP19vBiCyHjMoMxz5l3ZdLGJuOgE5yEqAQcgg=;
 b=Htn+do8VEw2dJwYFhPzpq7GRJqiOZu/fOnrPC04sr0xDUq/Btopk5TUFZBMaU/NS1WnUtqiwpw2986wKLuIw+2hi4Ry1xACfO7ad++PM4k2NAF8URvg2hEPwvdDluRrUiTJgTaiuGL8RKVYsGs7H8w7ZFw3wdLVLf3yFoepFFzK00B7i4e9fCMzuY6Mk6QTbaSWOcBdD8DU1H4G4x7N16mevGNa3vXo8yssXBnFJIWiqRNfyYbp8Rk4lfl+TOEl308aSvsuDHREA01xT9sieWfVaQL6oqrSNPKD+Yi6JojQCKSU8FG4/98UlIwUIYzuZKwoQqXjMrgmY+4f2Xm1/ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9)
 by PH0PR12MB7907.namprd12.prod.outlook.com (2603:10b6:510:28d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 11:15:16 +0000
Received: from PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286]) by PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286%7]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 11:15:16 +0000
Message-ID: <facd0b3a-f966-496f-b94a-54b2852005ac@nvidia.com>
Date: Wed, 10 Sep 2025 14:15:03 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] fix build with MinGW 13
To: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
References: <20250813152829.457463-1-thomas@monjalon.net>
Content-Language: en-US
From: Ali Alnubani <alialnu@nvidia.com>
In-Reply-To: <20250813152829.457463-1-thomas@monjalon.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::11) To PH7PR12MB9173.namprd12.prod.outlook.com
 (2603:10b6:510:2ee::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9173:EE_|PH0PR12MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: bb60669a-a01d-4d54-7c39-08ddf05b51cc
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFptd01RQXUxZk4xVWZ1bEtjMGRDQzZtL2lobHhTbEpYam55cndqdS83QUZz?=
 =?utf-8?B?Uy8wcEZDbURQeUxRNXlucTlKTFRPeDFFdVlGQUdRMkFjWko3Z2ozYWQwVlVi?=
 =?utf-8?B?UEVvZjFpZzJYZmZrMTFJbUtRNmRveTR2QUxGdWNYdXRXZ1VkV3MzM3FFZFVY?=
 =?utf-8?B?YkQ0Z2tPM0dlOWZmTUtlVVJHZWh3Qnd3T2lvT2tjR2kra3hTTmk5bHR0MGw1?=
 =?utf-8?B?dUJubEgvZXJabHgxVUN0SjYwMXM4ZHJkOUJic1pkcG51Z3ZhOVpha1J5UWd3?=
 =?utf-8?B?RlU2QW9KRjlDWE1TZTBtRHlERVBRdDJYc2tFbnM4Ni8vbnNXa1o5V1Q0QTJh?=
 =?utf-8?B?anVMMWRCYlVBWkJKMDA1eUNocVF2Q1NRMEgyRWMrWmd3UjZxUjVjRjYxSDdY?=
 =?utf-8?B?V1lLaVk5a0Q5eVNvcVliNG9SNnV6Y1lNSnlDdDhlVE56eWpCMVpqQWhrQUhP?=
 =?utf-8?B?OHpKSGRoMHZXSVlWRHFlSnBWK2VUL2VSYzc4UW1mUDFDUmUvMFl0Q1J3TS9k?=
 =?utf-8?B?Sm9LcHMyb0orako1cnZVK3pYTTJLNU5ucFE0ZzZPNWFUR1hKMTJQNTlYSjhE?=
 =?utf-8?B?d0FiVlpjWkFBbDNGeGZkY3Ewc09vMGxwYUhrdFNlV21KN29Sd0VFMndvREFR?=
 =?utf-8?B?eHVMYzBNUVZxeWJoWVdMemNGc1pPUmhrKzVJQlZhSW9xRTFOTEdjaFVTSUQx?=
 =?utf-8?B?SFZGa0xna3paR1RZYU81MXA3clllZVQ4TTFDc0NZTTZ6djMyYTZpcEJoK3hx?=
 =?utf-8?B?cTNpU3lhM2R2bGZJeG1PS2t5L0s0UUJWZUdQS1JQNnVJS3pnVVlZSjhkZUYr?=
 =?utf-8?B?SU5heW51clRldW85b3FHSXAxblJzVEFrbEMyN0VWWkxidXdYNDE0SExCdE9q?=
 =?utf-8?B?TTdhaHlRNnliNUFhb3FYMVcrU1dBZmZYT3c4VDJISW1pYjdyMXRRMjRKRXVl?=
 =?utf-8?B?R09NSUFTRlRsSnBpL25rY29ZY1h1bTV5TmFJQ1R1K000aG9oOTdGTS9jTUdu?=
 =?utf-8?B?S2Y0aGZRQ0hvSEpTMDZNelJTbE5GeVF3OFN5bE9qN3hkZXlUVTIyaFhkOUc1?=
 =?utf-8?B?TnBmSUV1TW1DSEJtTzkyQVp4aGVGRGZWcjJ0Q3ZMYU05VEV0YnlYbUx1ME8x?=
 =?utf-8?B?UGhWcjBadlRDeHcwc3V3Nm0xUFozZVRhVUVXLzUwQmFmWWZLdTZDY2I4bEpn?=
 =?utf-8?B?bnF0U0RSdzVzdnpRNTVVVFRzTEVvaDluVUdNemo0NjB4Mm94TXEva3Z5VWc0?=
 =?utf-8?B?a3NXdnc4b1AxTUZ0Nm1lNUgyWGQ5NWZRak5aaHVpTnUvbFNicERNM2ZhR09m?=
 =?utf-8?B?cURjOTBNSFcxRlBaUGxlZ2I4bjE2UllJcjBLdXlSTExwc0FKa0NOcmJMQXE5?=
 =?utf-8?B?ajU3K1U1R0wwYXBuRTZEcFFPQUJ1cHM0TGdaNXI4QnNQYjNSOGlueEp1eW5M?=
 =?utf-8?B?YzZQdjY3UEwwR0w3cW0yS0N1bm91QUZDODQ1V0FFbmVJWmVIbkpTdk8xN0ZP?=
 =?utf-8?B?MFdGSmE5NzZSUGxlcExkNHBJRXRCZDZLNjRhWnRzMjdVdHkwdTBuUVljSjhQ?=
 =?utf-8?B?QWhybE14U1loVjVZNzhqUWhpaGZTSC9mMlB2M3lwUmovOXpaTXRoYWNPQ1dX?=
 =?utf-8?B?dGtmeHBhYVlRL0thK2FVODRhemJsMDlQMnpHdkNtMzFTd0VZT0cwc1BsZjIr?=
 =?utf-8?B?c2laSnVhZG5tSUFjSnFxNEM0ck8rQnU5dG5wZjFQbEZpTk0vTkZNaThiSWV5?=
 =?utf-8?B?b0l3Z1dxMTA3VUZjaHlVRjhleGIrdWd1K3RBVlEydy9POXd0M1psWmxEWlcz?=
 =?utf-8?B?U0IrTGJZenFWMXo4N1c3MmRDbCtJcThMZEd1d3NsRTFHM0F5VFp3M0tqd2px?=
 =?utf-8?B?Tk5rZHNaQlN3MEVkbVBvZXZoSEhFblJ4WVNxYWVlNFFZMHFHcU5BMTR0Z1pU?=
 =?utf-8?Q?Yz9eOaNJu88=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9173.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjJNY0k1N0VMbzMrUndEMWpiTEYyNXlZa1RtQ29oMWx1cTZiVGJzbzRkVlZv?=
 =?utf-8?B?MlNvVzQ0ZkxKc092KzU2T00xUVUreExqQ1A2c0xZL2xQUnlvNFFhdDV3Vjhs?=
 =?utf-8?B?U2hQWEdKb2Z1MHpUZlNvdHczeW5iVWlaTkd2cEFucmJNam9lWGg4QTJDVVJQ?=
 =?utf-8?B?ZlA0N2VpMWdJQkFIdEdRM2lTcWFMNTNpZ0YzcjM5UmFuVGhrMk5qNnZ3K2xq?=
 =?utf-8?B?eE9YdjBnTmtzUmluaUgrNWJnbTF2NjVFaUMxRDdtU2dyZ01FMzlmb1lhM0xT?=
 =?utf-8?B?STRFbW12OVoxQ1FlWUNVeVRWcGFEb1hFbVM1UGpVTWZvc1VYc3AxQTlsa2hB?=
 =?utf-8?B?WUk1cE92ZXlhdk1aVlhXRnRUMk5mR2d0blpqdW1tZXJycjZnTitPUHVPdEdo?=
 =?utf-8?B?cHZJT1RpcGNaZk5CUUZtUVYvUWEwc0pyTUNQaGxGMENRTmMxR3ZVemdLWVZV?=
 =?utf-8?B?RWd5UmhmbWo1NGMzV0tIMERYTi9zRHBnWHo4Y3lxa2czS2tHQXZ2NHlkS3NN?=
 =?utf-8?B?NG5JV055MldGSXZ3S01zYnU2dC9rUGlqVWxpa3ZQd2tlMWt4SU4xdnJwMVdJ?=
 =?utf-8?B?Mnd5dUc2Z3Rzd3M5elpKdDZ0VXQrLzh4UXdwNm8yUGM5b1R4cHVFSHFuTUZ2?=
 =?utf-8?B?UnhpbG1jUGluVldadUdHRVBHZDdJRzV5MUd2L2x6NThtWllLc1NRdkNwcUdr?=
 =?utf-8?B?ZHAyd2FwdmFlb29MU3ZMM3hlVjU3ek9Wc3lzRXlMcWthZkNCU0w4bmdqWUhz?=
 =?utf-8?B?dW5ScEpHTkEyaE5SbFF4azBqdXFyZ1Z3QWhCSHpWUjdOeHpzQ0E3Qk1FNm0w?=
 =?utf-8?B?MGJKUXBUVWRRNzhEZ3BBUWMyTEsrdGhxWHFHcmZ3a0JWejVVZ2VxTStXcWpR?=
 =?utf-8?B?dVkxN2pRWnF0Y3FJa0ZuRnNaQnJTUDEzTmU5TUFiWXNySEpORExLR1BkNEVt?=
 =?utf-8?B?NC95aWJuaWs2dHlRYmdyT0JNWXRiSm5tSkJqV1I0NG9jaUlrTHNxTkhMK2gr?=
 =?utf-8?B?YS90M2grYnhWWk1zcWo1UXN3VVNhZ2c1N1IxV0ZmTEtsQzlFUXRIR21NUDBK?=
 =?utf-8?B?eVliUTVJZnpnaU1ZVk0zY042Y3p6MmFielZyREZIcVNPMlpRWXRlVW1BWkFo?=
 =?utf-8?B?N0l2OERxNy9obGVCSGdSQUN6ZEZnSDZ4WGJTTVcrbzR6T0hvVjgybnRZQzNK?=
 =?utf-8?B?U3M0UjNuTmVZd1lTQjR2YjQyNE5nVmkvVXhLQ0Y4L3lZNHlSNFdoS2xHcjZq?=
 =?utf-8?B?OWhlU3JLRnNIMmlmdEFpMW14STRRR3hhMUlSMWU1WWJzZTV5RDhWbkFyUmJx?=
 =?utf-8?B?b25xRnVndU8vZGhUMUdzd21VcSt2azl3c2lRZHJ3blJUZEN0SUxUZzljbjdn?=
 =?utf-8?B?ZVNUOE84S1pNQlFuUFhLQ2ZWL24vbHZjZ2VrKzFEREJ0MVNtL3RJdTEvNXNU?=
 =?utf-8?B?MHdvNmNhL0diVXAxN1cyelA5elZtS2Q2ejZiU05XQkxFa2tNcmt2TEZJYnJq?=
 =?utf-8?B?OGlQcThIWlhLQklMWis4dkFVYlA0aFh1OHNiT2xuZUxId3RMczh3QXY1Z21s?=
 =?utf-8?B?clBCVGd2SGRBTlIrY3M1SjZvTjMzUHpCU3pYN1Z0aXQrb3FxWEFHYnN0VTBy?=
 =?utf-8?B?OC9kdUVyOTVVVVlKanA5UW5NbGJjbjFwbnRHRHRyc01wSkRCU1JtZGpWQkxi?=
 =?utf-8?B?QmJZS1o5NTd5RlJKRXk5RFl1cXJIaU1UWDBnQnZPN25aM2lGcXFNSHE0TGpS?=
 =?utf-8?B?WFJoZW9RaDdFK1o3RkJteU9tWXdpOTdMb29DMENnMFM0SU41SThLTHVQYzMv?=
 =?utf-8?B?V3o0THIrZGN3S0VBUHVwTFNlbEpHcW9uekxlVlBhUmNwSnc1SDJsN014OFBP?=
 =?utf-8?B?ZE00aUhmV3UrTktiUWZDcVlNQVRwaWg4RTdybHgxeEZKbnBzYlVnSWxNbGRz?=
 =?utf-8?B?c2JWQ2VMUnVRTGZEYllpRW9LNU11anRzb09udlBzWGdTWTR6NlRPSDMvd3I0?=
 =?utf-8?B?REpBd29pWE52UWdURnZGcVlmeWJiMDBMMXQ4M3ZSUE1ocmo4K0t3WWpUeXha?=
 =?utf-8?B?dXo5ZUlOQWp2VHNtNnFzZWUvdXZTaExhRjh2M09oOW9rMDh6bldFRElYZ29H?=
 =?utf-8?Q?Dpkmx7KtOcVzJozRJV9ReM+7r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb60669a-a01d-4d54-7c39-08ddf05b51cc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9173.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 11:15:16.5030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kC/+UBoBlG4oKFykb3uY9Ib+UBwwcBDe2ifIr1+4gZJ/Q3tLjPyHmk8qAE3u7eXSix8FkiNvsZbeR2Jker21tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7907
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

On 8/13/25 6:25 PM, Thomas Monjalon wrote:

> After an upgrade to MinGW version 13, some compilation errors appear
> in PCI, mlx5 and bbdev code.
> This series fixes them all.
>
> Thomas Monjalon (3):
>    bus/pci: fix build with MinGW 13
>    net/mlx5: fix build with MinGW 13
>    bbdev: wrong fix for MinGW 13
>
>   drivers/bus/pci/windows/pci_netuio.c      | 6 ------
>   drivers/bus/pci/windows/pci_netuio.h      | 4 +++-
>   drivers/net/mlx5/windows/mlx5_ethdev_os.c | 2 +-
>   lib/bbdev/rte_bbdev.c                     | 9 +++++++--
>   4 files changed, 11 insertions(+), 10 deletions(-)

Tested on Fedora 42 with Fedora MinGW 14.2.1-4.fc42.

Tested-by: Ali Alnubani <alialnu@nvidia.com>

Thanks,
Ali

