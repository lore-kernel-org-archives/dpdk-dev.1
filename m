Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0827C3ABBC
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 06:25:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1B67402E6;
	Mon, 12 May 2025 08:25:55 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by mails.dpdk.org (Postfix) with ESMTP id 7FE724026A;
 Mon, 12 May 2025 08:25:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMsLNM1NZ54NHUB0WVm2QUIW/QrZn/DZB4Vky4WK+5IUeGoCjInK4JudHSCcVEfoKJbrpzYksVdi1E3MiH8vYIPXPiQ5RaE8mU+qivEBSdJ4adUpTuxGkTKbpSePyOGGXgk/QcmYYDb8PmcHycw604SLgavj6JxDSfPb0QeeZl9iPmQMlKuBEfH6xgu4Cq3vwB3rttEtapYmNe1lEEBoQqERlTNjfvQw1cA2C4X4y0XoC0tKv8fwsXoKhAD+2Qd5q1DX6+ZH4n+pTEnMo4wf4mBAI07wV+xhCez0vwpNXemYBF8plJ6J3zaYmo6/J0kWXiomITjo2hZU7dFlMHUgRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A60OHJ+4sXcW0vRHLoeonSLotGEu6VWZD0oYKc61nsk=;
 b=XCU4oBy18L0IwkPwqE0zB25Img5OIPYKwLeGlG5JIjp5Opo386MDRX4Ecz3+DUf0IqkKYGZxvN+bUuTYkWXOToGtMhYXJqLGMt19E+XuyFCRrK70iYzgItWfDJWm1jISdHDpIbmQIUtubBm5e+ZrrR7jAZVuQJBADPOCabfo+Hhy+0s3VClL2PU4EgDnmU+l+PMt5zCJdHTruUt2lJ6/ajL/JieSlvVoTZx9Pb/TDYU566DA6i5BPXTgYphNq7yUsVTTjPLft1w60fzeD4Y6svqkhGg2leWNt9LSh3TRy9M/25ZtEt2dZoexpm5uvOtxQAXQwGVxzPHOZUJxoFatPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A60OHJ+4sXcW0vRHLoeonSLotGEu6VWZD0oYKc61nsk=;
 b=FC30/4ETQ9Z1eQFjIBPv/DUT3//NKOfSrYMCc0C6Z1V08ilmtMRzKnY3mn61St6McseqnlMdl3CTicrAg2J+9AjZ9AQRS5utyY8P8Zo63ILXDIorP6cCqmeX12niTlzv3CuNZQiOqJjKeXPRfxWaUAt0AWy/MpO/Kp9zVPNbFcmeth+HJjsPwJ6eUQzqrjt5az6ti4b9LkIQq6TYmmMN9ja4A3RiGcWLdrA6QyicOtQvY/8SpxY7ZKmapa1NZnPJQDtbup5o3FoBb8saUcpVM2kLNO/m1U8OA3No+smqu+lnkijjRzXZOuddodDOHupDAl1f4xmsfb8eBW5a4O7CEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CH3PR12MB9219.namprd12.prod.outlook.com (2603:10b6:610:197::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Mon, 12 May
 2025 06:25:50 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 06:25:50 +0000
Message-ID: <9f3fd49c-7daf-4914-9f99-1e755d57533d@nvidia.com>
Date: Mon, 12 May 2025 09:25:43 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: validate GTP PSC QFI width
Content-Language: en-US
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20250425193507.39102-1-dsosnowski@nvidia.com>
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250425193507.39102-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::18) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|CH3PR12MB9219:EE_
X-MS-Office365-Filtering-Correlation-Id: afd7f45c-fdb2-44d5-e6aa-08dd911dd6e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZjR5TENhNWl1R1dSTDB5aFcxRjMwUDV6Mlh2UEZmSU9GNzRUNXo5dXZaeEVw?=
 =?utf-8?B?WDBnTnYrUlBiVHZPMFh2TU5UYVJZdEkvQzk4Z3AxREhZTjY2dWdzcUQrV213?=
 =?utf-8?B?alFvQTZUYXNwZklPS3pENzRScEJJdTNRdWkzcHZnclZxSEtFekpyanlMUGg4?=
 =?utf-8?B?MERJTkRpNDVEYmxGa3V2OURTK0ZQUkl0ai9TWXQrS0wrMjI1MTlwbUdlR0pq?=
 =?utf-8?B?R3BNbUNTQjBaaUFuLzBvUldmOXhpcW0xMExPL2tGaWtaN1Z4WjIxK011S1Ra?=
 =?utf-8?B?M2FndFEycGhnRm1NbDdzWSs2YVhnYldzK2NieXdFRlRTaVU1cDhZQWljL1Rm?=
 =?utf-8?B?bE9GTWI4TXgrR0FSVWdVUVUvTkZlUXJOTUZucy9BM0tqcnUrSjJiQm1Gbit2?=
 =?utf-8?B?T3A2QkRicm1pK2l5bXpHUE4wMEI3emdCb3d1R21jRnFBa3ptSUxCK284N2Vx?=
 =?utf-8?B?dXlVcU5abmFRVGV2cmFCQ012akZFc3FlY09RaUt4dUx3UnM1SDJ3MjQ5bjgr?=
 =?utf-8?B?MUNsbjdYWGFsS0tlV1FXdDlXSzRCcnBGMERBV3dWVzROd0ZVdk96NkdqRXpS?=
 =?utf-8?B?MWpwVFNnWUhtY0JJMzdmWmtuQ2grL0J3SnJ2WVZIK2RSODk3R0RFMjJqYWV4?=
 =?utf-8?B?MzNnVGdDeWhOZW42Z2dmaFZxSjdqNDFSTFJqNTFJWEhMNzR4c3lBZklnMkNs?=
 =?utf-8?B?bS9zWWx3Zkx2RWw1MjNNV0JzM3R1ZzBhNnVrYzJSTUcxUW5SK0cyZFFqeWl3?=
 =?utf-8?B?NmkwWDlxOHI2a2VuQ0Q1SHlhSlZOZW1iK2FodnhtOE5oVkMyZ1k4U2l2NS9Z?=
 =?utf-8?B?Z09mR1hoRk1sZUdOSDg2VS90T2FUU0FWUHJmTWkwL21XY2xFbzRnbWU3QUwz?=
 =?utf-8?B?NFRhSFE3UjNBc081SU9XT0kyWEhTN29SNGhHazdhdFVqanpzMjhETXFaRU1j?=
 =?utf-8?B?dU5VVG5YbEd4WWVCekoycFVoRG5Kakl4TUZMUGQyeHlZUGo3Z3A4eDVEZkFj?=
 =?utf-8?B?NG93dWhZOEhqOFFqQmdsNnNCSDloeTZndktCSU9CVGpFVlQvekFGUWRoZDdz?=
 =?utf-8?B?OUpBU1dMaXNFT3dXM1YzczhlWE1pdmpuUW82bzdUdGdBU2RGK2MyTGpuVXRi?=
 =?utf-8?B?SFJCdlRxbVQ5dmdLdVROZHl5d2NXSU9tNE1lYTRwdXllUzhXNFBONFRXc1Nr?=
 =?utf-8?B?Mms4MUR4MVNlS3J2T1RyL3pYQXUzeXczOFVnSVYrYVJaQnJHeFlWSzZkWWdJ?=
 =?utf-8?B?MUVHZnF3Rkw2VTQzbXRrYTBwMzZiRW5Kd3BheFVuVzh3S2FWODRMSmdheG1R?=
 =?utf-8?B?Ri9xQTUvbEdJWWdzOEtldTRSdDZNZi9nelQrdFUzbHR1K2pmUS9Rc3g0cTM1?=
 =?utf-8?B?NXA4RmpaVGlyb0xjK2g1a245Uy9vYVYzZjB1N3Q0ZEFTbXdDV09nRUhZZkk4?=
 =?utf-8?B?Y3RPOUJKck8zMjBLYVl6R0EyeHBHdzFoQ1hTVjAzamkrSmFIckF4ZkJPRUZ6?=
 =?utf-8?B?a3dRWDhaUzY5Q0JNdWltNjQ4MDNOcmo1VlkxUWIyVFhjcEF4cjVYUlpkNnpv?=
 =?utf-8?B?cHFaYXd2WmZycVNnZ3oyKzNJTjhZSkEvcjN5UFZCVmR2MDg5NTFxV1JLak1w?=
 =?utf-8?B?eTRZam5HSU00cXloM0szUW1FRmtOaExMa3hsaWF0QjIvU2NKelNJSVJJV1VU?=
 =?utf-8?B?TGd5QXQ0RTZ4M1JwQmp4dmJNMk9vVS83SDJzajhCL1VqWUp1OEE3RzlWN01m?=
 =?utf-8?B?V29vZkdUUG5IMWVXNFRIZHd0VmIzcGkwM1JranVyK05pSFVQYnc3cFZJVHYz?=
 =?utf-8?B?L2RqTmJTbW1YamVsMUdNTXZQRXZOT1dETnBKRzZoL3lja2JFaVd1VTBHOC9v?=
 =?utf-8?B?SnlRS1N2cU96ODh2VXNNUFJzSVZKRWhMY1RUbzQwcm9xSEV4TWpmUUJ3MUJo?=
 =?utf-8?Q?AdrIjXDJz+c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y29tL01ZTiszN2NnNkdFQUlabXZ0WEI2YnpkMGxkem91cFB2VEpUZ0lsaFIw?=
 =?utf-8?B?UU53dXJNVVZhUVZTTUx6TC8zWDlJbnRmYkhIK0l0Y09kbGthN3NZQnFqQk1q?=
 =?utf-8?B?OS80T3Z6eFBzcDRtVFNzeTA0TjN3SzZQT3NkMlRCcVFIcWd6Z0c2TGV6ZUZm?=
 =?utf-8?B?QXc5RzVheTdHaDBxbWNMdkJIYld5MUdXR0lZeUtVajRNalgzVzduSlA1UDBS?=
 =?utf-8?B?M01GS0VReE9BS2dsZTEyVjI2N0x5QWtTc3VvdU1aRkpaRVFyQUtWYWpUYUR0?=
 =?utf-8?B?MDBibmxoWUl4ZjNaRnhyZlVEWDM1R2krK203MnAvNmtEYk5IMUZjd3BCS0RX?=
 =?utf-8?B?M1hNc1M5UVBsZDFlV2wzSEFzMGdFcE9mWTA4TkV3ejZuM29xWSt3VTlpOWNk?=
 =?utf-8?B?STN1QjZ5WCtnME5DWUNBaHVodEVoUUpMdlZmSVVDTER3dmZsUmxhVDUrMnZN?=
 =?utf-8?B?WlRWaHllWnNTanVpeVEyQWcxak9NNnE3L2VZQ3VlN2hjdlI5NzQ4MjYwdUo2?=
 =?utf-8?B?dHM4WDQxbUNzWlBuZGU2TjdtdDB1anhvZUQ4YU9pQzNvWGdVcmZCRDJncWtY?=
 =?utf-8?B?SUZCYVlUU1kyV1BveDVldk9CVXNjNkhHUk43TWs4S2gvNGs1YThPMmpEODda?=
 =?utf-8?B?RjQ4TnAzSXhiUVNmMjhybjFLTnloWm5ncng1cGhaQ3NqY0ZMM283OWd1eDZ3?=
 =?utf-8?B?SEFRRS9lVzh0ck82aHBxSWhaNkpmN0p4aDgzMldvZnU4SU1NRk00dTVZOWhG?=
 =?utf-8?B?YStTcXNGWk9Dc2FmSG44LzM3VDVlVlhYUHVEU1I0UnRrSGQrYkthOVBVNVNO?=
 =?utf-8?B?VUpRVEx1em9FSTJVT1RMNmhuZmJPVHhPYWhzY0I5UCtVSXFqcFBSMWdGb1pX?=
 =?utf-8?B?K1h3aFlFM0VjRmhMb0RhUXVDQmhaWmp6ckE3dzl1M0ZVN0ZJVTdDM1MrYWZj?=
 =?utf-8?B?Ty91bVFJcjdmcStFYkMvY0E5aWhyNEhzeHVWQnl1YWdCU2JOK2VYSFNoWjl2?=
 =?utf-8?B?aHhsZlYrN2dndnlMT3o0SlNLWllFdmltK0RWRHBQb1NhbXpzNmphUGZrZU9l?=
 =?utf-8?B?T1dsc0p6dWplbklVYjlkUHNORGRXSnBPT2orM2lNbHE0UDNHY2o5TnUwMFVv?=
 =?utf-8?B?T2t1dGxaeVVRV3BDRU5WZThRM1VkRzQ0WGNuWGlRWHZoQm5XdVBobDhvU2FB?=
 =?utf-8?B?ei9OeTVadXRxSnhwd0kyZ1krYzZCOTlESnp6bHFjV1hsa1piejFsZFlYTDFJ?=
 =?utf-8?B?aU1QcDNtVXFwamFld1BoMy9XcXBNaE13NGVLRmE2UnpESjBnR2ovbmNNVFNQ?=
 =?utf-8?B?cXZkekVqeGlsQVhqeVRQakt3b0RTUlVxY1hCWUp2aEFwSmdYQXlrbm0wNThD?=
 =?utf-8?B?U1Q4Qyt5TFYzTWQ5Z2wwb2dVNzhIOS8zT3BLRHFKTGlJcmhnOFArL2I1OVd0?=
 =?utf-8?B?eXZwVlUrVkxCZmNzQ1dnSjZVQkRnNC9aYWx6d2F6MVQrS0RXZWlXN0xDSm9a?=
 =?utf-8?B?S3Z5QVBjRXpTclU3cHVGd0MrZGtEenRpR09yVmxIVUNxVUtSTjBQSENpcm9a?=
 =?utf-8?B?c3pYeVNHVXBHeVJZaitweW5ZTlM3OUdZazZJMVNXbUJaSG9xTDBKM0Rpektt?=
 =?utf-8?B?V0paVEZ2VE8zMHNhNGFkTXlMVnVJRUFVRzlIdGwvanV5blF5NTBCYXF3OHFF?=
 =?utf-8?B?ZmdqWE1nNDgzVUlvWTl6ZGdXV2o5U1dldk0xMlIwcHp1VXI0TGRqS3JNOE5r?=
 =?utf-8?B?WklsSUpzL1hCaXlUZUNpaGNvZzBJYXc5Yks2NmQxU053dnFYZFNSWEJHcmYw?=
 =?utf-8?B?QjBjU2JqWUl6Yit1cmRyWitSSXdqZ0NwZGtnNEcrRThyenRHMUtMRW5RNzhY?=
 =?utf-8?B?b0Z1MVQrSDUwOHJSVVpTRXltcjR3K0FyNE91d2xiOXhPSzF5Qlh3OFhIUVZy?=
 =?utf-8?B?bGZyOWFZMVVYekM5UEF0YkhMclZaOE92ZFN2SjdnVXU0RWlobVRCU1hYNUhT?=
 =?utf-8?B?TkJVcHBsQTlVRC9UQTJvakIyRGEzMkROTlBZNDFnd05ac1RmbmFyU2lRakNV?=
 =?utf-8?B?QXVPSWprUktDK00za0wvWC9BYWV6M0VsOXNhMDFCSTZFRXFLZkVsUFNhMGdV?=
 =?utf-8?Q?j1aMSuECC6hX0eY902tQhwSmv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd7f45c-fdb2-44d5-e6aa-08dd911dd6e3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 06:25:50.4370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkeb31m0TpI9l2v1qMbbu89z9yVMFocES8o1RWd9o07hxL2ovVpS6/QO1ik9TSkns4biI0f1Ju0AxFCSwGLzmQ==
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


On 25/04/2025 10:35 PM, Dariusz Sosnowski wrote:
> Add missing validation of GTP PSC QFI flow field width for
> modify field flow action.
> 
> Fixes: 0f4aa72b99da ("net/mlx5: support flow modify field with HWS")
> Cc: suanmingm@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>

Patch applied to next-net-mlx,

-- 
Kindest regards
Raslan Darawsheh

