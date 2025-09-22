Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97006CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 09:18:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79A7740653;
	Mon, 22 Sep 2025 11:18:34 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011019.outbound.protection.outlook.com [52.101.57.19])
 by mails.dpdk.org (Postfix) with ESMTP id EDEC64060B;
 Mon, 22 Sep 2025 11:18:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVCY7PX43VJO1XeUsSx+jTnvGZ1gDDF+9Ck/hu/DDHzfMeDFMsaN0bAF6NEgSKV8gvhvMdxB93DyhzSIht8jruQNDWG5YDOW64Jzxsmf4NqDe0LU8DpZesG817sTWImBYyRXSa+BlqvdBs10nbgwuSbN0T9xMFBXJAwL8NGjYUxlIMAh+MiGVS8+UOQeoh8pj4Z2TEVLENvd7auRf3vJZKrnfc6fzenitcc3mbi/2WGPpF6ic1XhWOvKdqcX5WMab2EcXHzHOdEmqD6foxpyev7sw8NVV6BHDoPlbd3lH5JV+IxxYYILVvouwSdd+NbHfV5NyaAN4KU3bGePej+J5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wb/0qUdGuopOr6LkouSD8ij8tK8hbP4yASG0mveqHaw=;
 b=trupkL1H4h/Wekh8rlmXXn0ZWZQdlORdrFBxQiTPpCahsRkzFCm8AlERNbbYoSWLvGJpFJvJoUnXlhLkm4v2oVl5N/7qia0tknO5upBQd2KGF0+WUHOJsQ91zDlNydauoNgd7r7YmOd/nwc4y3+usQ/DkX3S51eYmIy+TxInq04aWgjFgJOidelx9Lh69A87DJZPVyTthJdBKXI32hMZornW8GD6WgYmSncNaH+FwnxV47VmsioyBjLxjCA/3xH8BnxZb4RC282jphRq82dJfP8+tJlVrqhYQpAmPX3jTAxbp50rnYZrngkup8aF2WX73wnLr5Nb0tUp5UdNAJ1Pbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wb/0qUdGuopOr6LkouSD8ij8tK8hbP4yASG0mveqHaw=;
 b=QWFWCis/LstGGIdb0eriGIsMbByxRDfnFRNkKpZgKhPMp7atYs6PiBQxD5+GLl9QnZ4B4BD96bzrKGkTUHeYEUbSoOp4t6E5/Wi3wKzySGKLBZ/m7Ul0EPOyswvrEAq8WBsYQupqpGeJ3EW/ay1tMGL97Yhaht9OpRN+cOyEoLY2gnLDoWFShEvNXSJNP/84iPuYLBGIyeNlsHQNx37L3obDi2lVWbUNbMg6FjzeUwYqGRuE9w9lXh9KqJIKJOkOgCoB96uqDvqmOudV+Y+Oc77XxG2BHyRDFPs3yRDDbabGGExzzEfMRtEU9VgsyyENe97WPDWM9mce0mJl+Is4ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CY1PR12MB9558.namprd12.prod.outlook.com (2603:10b6:930:fe::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 09:18:31 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 09:18:31 +0000
Message-ID: <f157b593-7bc8-45ca-81be-5216b1968a16@nvidia.com>
Date: Mon, 22 Sep 2025 12:18:19 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] net/mlx5: fix indirect action memory leak
To: Rongwei Liu <rongweil@nvidia.com>, dev@dpdk.org, matan@nvidia.com,
 viacheslavo@nvidia.com, orika@nvidia.com, suanmingm@nvidia.com,
 thomas@monjalon.net
Cc: getelson@nvidia.com, stable@dpdk.org, Bing Zhao <bingz@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>
References: <20250917102604.451241-1-rongweil@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250917102604.451241-1-rongweil@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0027.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::11) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|CY1PR12MB9558:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b34c47f-a7bc-4ff6-712e-08ddf9b8ff1a
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MW1kbEVSbXpTekJMemlSb0Uzd3dJN3BTSlNuNDJWb0tobWovT1gyTEdiMGFj?=
 =?utf-8?B?QzNmUy80bTNaSjRhVHlNbHZrZ3FqUXhQSm9MWndDcFBINTV2VnlQTW9KeStG?=
 =?utf-8?B?cEVZVmx5c01QVEpWOFdac0tqcjMweVhvUUtLa2tDNExMcWptNVhqWlA3dE5j?=
 =?utf-8?B?M0QxYkgwR0JtenlCMzV6TXpDcHpNSWc2L3V0RXliWVp6ZXlLejIxSytIbWh6?=
 =?utf-8?B?NEpKZlB1aGw3QnhrZFIvZEJrbTErcEJ2aEtnVGIxMlY5bnNHZ3pHNTdRM2Fi?=
 =?utf-8?B?RUFOU1NsaDc2RmJVU1pkTlI4UVhSSGpJNTdqYXlIVDJ6QWJ2UnRKOHRSOWcw?=
 =?utf-8?B?WWRaZlc3Y2hQcElaZ04wVWRjTUJJeWo0R09NOUZWVUVqKzFrSzA4SDZES05y?=
 =?utf-8?B?RDJYRTM1OHF2Rm1NZmVhWDBXQlM5OTFIanFpQzVPSGM4ci9KVnVKdmlmd1Bs?=
 =?utf-8?B?bENuZlNWUGMrOHBkU3pCY2lhblNla2RHTC9ZV3c1L2VYNkxUODRTWDA1V0dG?=
 =?utf-8?B?ZkpUanEvUGc5bWxMQTVmV085eXBaS0s2M0c1OWdHbW9QV1VXNW16UHFKRzBW?=
 =?utf-8?B?RW1QS0taaE5NTjh5bkxPYkNwbHpKbVdFSXZsbjYvM3p6Nm9lU3ZtVEUrSnFo?=
 =?utf-8?B?dUxqM1hBdXhMblJIQmdWQUlXT2dnOHAwOFRIaDJwdnJXbHpNQ0dyQlpMam0x?=
 =?utf-8?B?aHBlSEdUend3R29NaGJ6WjZjTjVFOVBsTWxZbzZlZVkvVnRrU2xEUkYreHpa?=
 =?utf-8?B?NmV0WmRELzQ3eGREeEhvc3FBbWh5S1hwUlRTd0VGQUh6endvR0YyM1p3K2FG?=
 =?utf-8?B?Ym1Jc2xGYndiVE5STFNQRFhZYzhIYVdCVjdtbS9Zb2trWHZLVXEzejVZbER3?=
 =?utf-8?B?aVFxVjhxRS9yWklPdWFnMHROTHhqeFFlSFdCTEZTTnZ5MzVWWHpaY0dROHVt?=
 =?utf-8?B?OFRsOFRRRU5nbm5RQUVjaC82TzBkay9EdUFieW9RdThwZ0ZWMjY4ZitzSVhs?=
 =?utf-8?B?VHV4VDJYV0IwY0VmN0Jhb1EwcENFNnFYTDJjUTVRdzBRa05ObzJyakkrbjEz?=
 =?utf-8?B?cTJVZmFiaTA3MzUvUlU2VlROMlNOK1VuellxcVArVUY2UTN4bTNRdWJCTWdj?=
 =?utf-8?B?dzF5ZDRPSXRRZEMxaGRidzJ3TDZyMjFjWEV2TndBUW5JcStjSS90Z2VQNm1o?=
 =?utf-8?B?MkxLYVNPdmhwcERnaGZYTUx1U0k0c3JzRzhXU05hNlFsZXBxNnJQN3ozS0RO?=
 =?utf-8?B?aHNDeldXUm8ycm9BaG9IejhhUUptWXlQVjd2cCtuSGZtTWNNWVR4bExIckZV?=
 =?utf-8?B?MnVZbmpBZXdFYk1PaXBrRTRDSTNMb0dkdldyTWIvVTJzWFlwVDlkczAzb3Jl?=
 =?utf-8?B?TzVWbzBWREpMdTVLRVFRTGF0VldNOXc1dE1sR1JUK2JSUlEvYkxMdmduOVZB?=
 =?utf-8?B?MUlvTWhiMzA1ZDZFUUpCNUYyZ2dwZXh3M3NxWkZ2OXpsU2Qzc0QvM0VwY25F?=
 =?utf-8?B?cTdnUGtpc2dlYXlFQnZtcEdEck9hcVlOU2pkaTBac2NBakhPc0xOcDRKbE1h?=
 =?utf-8?B?WVBHT2FFYjJIM2NSMjQzUEs1WEpHazFOYnp2M1IyZ0pCeitFQlp4bkZJZHVq?=
 =?utf-8?B?VldRN0VTT2oxZTVzZUhZMmFlbzkrenkyUnFhbldyVnhvY3lQclcrRUs0WEFW?=
 =?utf-8?B?OFhHa0NXTC94NU5jbDhNdUkwRGJIM3BSOWNnaVJGYUxPZlNwWmZ4Nk13ZzA5?=
 =?utf-8?B?VUQ3YVNuQWZlSzFaK2Z0WGFDbWp4UGFOazBLUnNNUHhYeFhHWk4zNkMwTlRL?=
 =?utf-8?B?dG1yUmxTN1RWOG9VZW1kZGIwK25BZnNqdkhYVG9IM2NESWsvQkp0UENRL3Na?=
 =?utf-8?B?TmdSRjVRRU55bDFLaUhMQnMrcEpqR1daSHBUQ2xsc3hEeThlUkY2c3phb0cx?=
 =?utf-8?Q?ThXQ9tG8f8I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm52VnI5NGVSNEdEUmNMbkxJZFpPZVU1cDdaS0I3R2s3dkkwL21xcGN6SnhP?=
 =?utf-8?B?UVdEVkF6bHhLWi90TXUrQkI1VGN6TlVrMFc4dkxPNkxPNVJsMGxyeFNWWUdw?=
 =?utf-8?B?cm8yRUpoTU5WOTZpTU8xcGpHMmI1K1pvbVBkMlRvV0tkbmVBK2E5Q1pqNGov?=
 =?utf-8?B?eWxvZURtZEczVU14RXRQRy9yb3J3Zjh3OHg1QUxQTHhNVzVpUk16N2FpcGU2?=
 =?utf-8?B?UUFDSHA2NlIwQ3REUXAyczc5OVRNM2VTdGcvblF6Yi9OVGF1Wm5HWTJ0ekJj?=
 =?utf-8?B?WTFnR0U3MGVtbXIwMUxodHRIUHN5UXdzbVpPRWJuRjU3U3lpM0tuMXVOREQr?=
 =?utf-8?B?VFVIcDUvK1ljSFc3cTEvVGZWK1FET0ExckpoQlp5ZUlRakEvMXlBY0xqc0c4?=
 =?utf-8?B?b1VJUFF1SzZ6LzNoK0QvK29SY09pcjJGK3BFUnd5eU5CODFDNUsxdXN2a3pX?=
 =?utf-8?B?VklrOVVOVXJqZlpPdWdQaFhDZWpkWFlRZTNQbnlPYVRVWG9jVkVvRW82TjJQ?=
 =?utf-8?B?RmhnVFIxbVNtMzQ3OXJyZ0ZucnlZUWdpTlRDQnZpc0hIMWxNUUdWbkRxNlEr?=
 =?utf-8?B?U3crbWlFZ01EL3RJNGpHSHlWYTNyLzBVV2N0S2NHUURDMWpSQVJaZExRd2hE?=
 =?utf-8?B?UlZHeGtzUCsyaXliNGJJQU5vTWlQTENJdVBqV0UrSTE3d1lDQ2h5dHd3Vjhw?=
 =?utf-8?B?bnYycS9zWkFzYWdSUldKeFlBSW1NVDVVNkUveEY2KzZiWTRNUGhoNjhJVmpP?=
 =?utf-8?B?ZVRObGk3RXBNM2pFNXpLaWw4QlpXL2lwcXAydVZWay9HTDN2UHFNZnYxQzRs?=
 =?utf-8?B?enJHanQxYWcyWncrZDAyMjB1cFUzL2MvTUdEbjZjd2xGVjlDZ2FvQmpOSUc5?=
 =?utf-8?B?Y3k2K3I1ajJmb0RLS1VrYkJheFBZc1I1YitSL3U4ek4vUzJNSjJSM0IwUnhD?=
 =?utf-8?B?VnFobkNBMkpMa3NwTmdMV1d2d3hoVFJOdlpGK2J3djU5QXBaWnhSUVRucEFB?=
 =?utf-8?B?aTB0OFBQL0tKWlNiWWRBbGZJdzhVTjNKTzNMTnpHOGxuVUJ6Qk5JTDFTUjdP?=
 =?utf-8?B?d3poVTNhMWU0bDhCR0pUZjg2NzdCOTN4WHFYSUxDUjFKN1VKenZkNnNkVHdl?=
 =?utf-8?B?bEFzbTlxbHpWU1hjMFk2dENkL3VuVmY2a0E1SWxHWVRUQWJ4WVVBUXA3cFJs?=
 =?utf-8?B?SUczRkRORHArbTBlMDBPKzBvb2kvblJIdWV5MFEyc1JURGFHWW9Ecy9kTS94?=
 =?utf-8?B?dEszeE5QeGp4bnBIQndpdzdaWld6UlZ5ZXN0YlorUkJreXN4QmR2U3oxclN6?=
 =?utf-8?B?TXN6WXc0WkFnTmlUb3I4eEFDYmtBVitGRmFmQS9HNGU1Vm5ORTZuZllzM3d1?=
 =?utf-8?B?VG5NbFhrTjdaM1ZrcHRZQlFIc08xWXhyWGp6S056UFBhMFU2a3QvZmRuWmZQ?=
 =?utf-8?B?WGw0VTVLbnYxWENFNTB0MzNjMFFSU3F5eHFHVUFEM0kzWmNZVlBRMHBORkxy?=
 =?utf-8?B?Y1NzYzdBRFBTaUF5ODRHQlZTVU92VDFNbWVObFNOVWtoQ29RYllKNFAreXJs?=
 =?utf-8?B?bU5ZOExLUjVvbzFZd0V1eGptUERJTWZ5N2hnUkRka00vQzBIUDkrOC9tYkJ4?=
 =?utf-8?B?b05YRitJVi9NTDNMOHZqUnp5ZkF5WUFDZHVHS3VOdldOK0JERGdxVmljZG1N?=
 =?utf-8?B?QTQ5VFdCU3pxQi8zaHpIaFk3WVhPbEJpeWRkd0lLN3dHYzJQcnMwWjNGcHps?=
 =?utf-8?B?SmMzb1BaRSsxRmFiT0l4U0xneWZDSWlYMi8vM2l0cERydTR6Q0JDMG5CTkgw?=
 =?utf-8?B?QU0wTzdwL2FlR3h1dnRqdjl3LzFTa1FhUWI1QWhNb3dkTURSa2FGR0RxRjd3?=
 =?utf-8?B?T2M5T1IwRTJyTm1VNWdmVUdYSjJIMkdoeFBoc0NzWHgyV1EwWHJINVphV1Rl?=
 =?utf-8?B?YWVpQXl3S2FYTlhubzB0aE5yVS8vai9jTjd5aHA2M3ZUTGE3RlVJVHdBWTRW?=
 =?utf-8?B?NUMvN2V6QmJaMlRONkJVc3A2ZHIzM2QzVXV5TVBubnRQb0VCcnZkSThER2w4?=
 =?utf-8?B?dFRQWVRDNFBLcmZZQUJtdERMME4yVm5XWkF0TGV0US9ueDJtOEF1WlRaN1g4?=
 =?utf-8?Q?tmGV2u3Oryi6ecY7bNuuogmQR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b34c47f-a7bc-4ff6-712e-08ddf9b8ff1a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 09:18:30.9109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JyJNzdUBgMP8q5kYRDvFvRFbhz0rZMsYlQ/7zMGFmvIc5U/sWMelKseqItLi2Nkw4I9eKzaLQt4SDYLZ1gyGZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9558
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


On 17/09/2025 1:26 PM, Rongwei Liu wrote:
> There is a handle that is not freed when using
> indirect action list to manipulate legacy action.
> 
> Fixes: e26f50adb ("net/mlx5: support indirect list meter mark action")
> Cc: getelson@nvidia.com
> Cc: stable@dpdk.org
> Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

