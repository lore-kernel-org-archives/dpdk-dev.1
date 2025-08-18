Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C840ECA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 06:30:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F8F440277;
	Mon, 18 Aug 2025 08:30:24 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by mails.dpdk.org (Postfix) with ESMTP id 58BD54003C
 for <dev@dpdk.org>; Mon, 18 Aug 2025 08:30:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSZycuJMRwQPGkeJ7qBUCEDplIDETtdDQPhS0XM/kz2sM1G2v/WQsC8y7FDbfmrJMwUWUiFAOnnVqpC73F8YpT3igfrk8Xd82eRFZiZlXfvh4/yUoT9qGMz/r58ZJafHzu8s8atCe6mRW9/A3vrGD/TZUPRFY7+GhZZY6ReYinBWK/EozVYDBUykMDPewPMoeLjGARq7rd6RwY0cD1xNZq+d85E+F7oA1lCwtQ8umGMbcJ8r37ituIGBC021hwZdKzXTeA1zIT8qGczwclV21kF3kJG1LNUHGgogBOcK097AnCEPyCUDdhXFzGjrYIuTHweOfcUbV6J2gszTUq93CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiQN0GVv4NStkLXtq9AmA+t5eYFdnRJ4m7HiNQyXHSs=;
 b=F4i6bvhMAdL5SCMKNMzSYS9mMOGYg7Nm67XHmGnB9p1chFFt7QYNpQe+KOwTVa7qcUfpAC2myjQEUjS3VFoahDFRfmF9zjkbFw7ixm2Iac6vLYUNqfAf9NCgA3HS4uNdp/kuHaiosaEubxG44bdAuVzEMwwgd/dKwb4Glh8/QKyCoMe/i++SXrxRIKB7c1Nu1vmouCJEzsiVSpPWEawj3Sg90eEyJdTGCRZshSgK1izDokvHVN4vVHSoH0iSXdaXJ1aoH4nEcohV30VRuq6LEXGBHRVoJeIgu/tgxBiQwoHQAVYmh/yNyrb/lR83EcB7aiv4NnnPdTLXL7yv13e49Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiQN0GVv4NStkLXtq9AmA+t5eYFdnRJ4m7HiNQyXHSs=;
 b=Z+rlynbLQDMQnqBL9q43UuVfpIK3NxXRystIa9dJI8bbGZKKCmBhDVuoWO9JPIz+fO4sQKTJ5F6II8nmJI/JURbb/ZDQm1VZyZcaX2fp9tkb91cCudvSGPCu6r37IfgY9nik5wYQozJsPGrh0va6R/7nIZs7HAv7kIMMsShoNSEL7vyBm+yiCa33hAiRgOIJ86iVCh5iXMXNXUFBqVLTGEjQMFI23QKNUCTYnoMZ7J34sV53ZKVnVD1EXrR5z3wWcqlsmUhwZEVr3uzEKWvpyVvgjvtHUdBhP09Y1TCvBskuublIWudOCNy1vi2Aboah3Susbuu11sq1ugnKJPktPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 06:30:20 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 06:30:20 +0000
Message-ID: <23430566-ec02-4d88-94db-a230b3464e61@nvidia.com>
Date: Mon, 18 Aug 2025 09:30:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix ipool memory leak
To: Rongwei Liu <rongweil@nvidia.com>, matan@nvidia.com,
 viacheslavo@nvidia.com, orika@nvidia.com, thomas@monjalon.net,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Shani Peretz <shperetz@nvidia.com>
Cc: dev@dpdk.org
References: <20250723064923.1805575-1-rongweil@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250723064923.1805575-1-rongweil@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: 3553bb50-2df3-4a26-8146-08ddde20b445
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWs0M2Q2cVBvOVZRWXpJWng4WHJSLzRGT1paY3V2NTFLK21LMXBmN2ZBRjNV?=
 =?utf-8?B?YkJaTVNMV2VaVUZnSUZYaENmNktCRFRUOVRXQ0VoZ1lJL2UzYmw0Slh1cExN?=
 =?utf-8?B?b0k1NG8zbnZkUHZPb2YxYVRUSG9KR2lEaWFpQkJ5K2ZLZEpQVkxtaUFHcTNZ?=
 =?utf-8?B?SkhLNWlIOUFoRW8waVJmQUJBV01kaWcyRU9EbjdPRjhQb0pHRERJbG84bXIz?=
 =?utf-8?B?dldJQUZQN0NHUHNvYmxIeVhBemJvZ2Q2Y2hyRWlCaE5TTjQ2RkhBMmJwc2M5?=
 =?utf-8?B?ZVdha2NpRkNZY2dKTHpFT2dXMVNreTFkQ0dnWi96dUh0cm5HWlhJV0FjZllQ?=
 =?utf-8?B?WmNUcVo3VE5wZ256eG5SVGtseHcwdjVFeTRMQ094cjVRVWtxNWhmd2Nwck9v?=
 =?utf-8?B?bVp0bW5mR3NydDVFajdHVmo5UWRTU0tqV1NTeFh1K0R3UGpORUxDT3VYZmIr?=
 =?utf-8?B?dDlXRU9lM2gzR3VOQ25rRHRQOExkd2VucEEwNjdMOUhvVUs4aUJiK1hMT3JH?=
 =?utf-8?B?NDRLWVd1RWQ4cSthZTZBSXprWUM2V0FMZkp3SE5DU0srKzdSWmtmS1lhaTZQ?=
 =?utf-8?B?TU8rQ1MzWFdHLzlTUTZNVk0za0FDNkUyRFB3bTRMazNlNFVyQnpZZVhWRmNU?=
 =?utf-8?B?bnR2OXE5cEY1QWptRVl5TDZCQ2FLYi93aU1uL29iT3o2Rm8zL09HNVA0a3ZT?=
 =?utf-8?B?MGRGRzF2YjAzWGE5V2JMWFFEUjdBK1Y1RTNEd0owdHNBcmpBTnBOUURLNkVN?=
 =?utf-8?B?Z2lHLzRkaWE3dDl6WEV5M0JCUERZaU83YytPa3hKVTRmR2V1V3ZReVI5UFI5?=
 =?utf-8?B?OVJVNzFxOUMrUjJCSDFadEVuQ2F6SG9NcTBpbEg0aUdUakozMlRhTmFpeDIw?=
 =?utf-8?B?ZnY3SVJlcUt0c0xjRHdGaVpIZW9IK3p5WTJhSmwwZXhuUHJzMjhjWG5nOFp6?=
 =?utf-8?B?eC9yVjYrRmllekk1Rk1CeGo5ZmFwNnpQbG1hNnZFOE40ME9WOWJ5d0NSendq?=
 =?utf-8?B?bXQyL3hoNzFQM2VjVFVITVQrczM1K2Rpd3JVTTlWbTJubmtTcWRLUkxibFd0?=
 =?utf-8?B?eFRhVlA1WVlhSTJvZXVRZlRUelF5ak1jYjB0UFNLZXVONkJhdFRuaW9LZUVp?=
 =?utf-8?B?RmZaTytkQ1h0cnQvVXRTa1VxSFVtUVhpY0tyUXoyNXZSQ3Bqbzd3SnMyaFc3?=
 =?utf-8?B?UE9ENlg3MWgxQWs2SXptZ3JxVnBmcitwaHdLM0o2RjMrRjlkYUFMdE1JeFJQ?=
 =?utf-8?B?dTlJcGd1MTYyYzFHNTlWNE1BdTB6MFlyNGFpREE3VTFnREdJUDk4Q04wcEsy?=
 =?utf-8?B?dTU4VFNjaURReDgyRHhZTmRPeU5VaUhnQVRndXluRlJwTjJuTithdTcvSFB1?=
 =?utf-8?B?SFpsOG9iZTJTK2RKenBpWi83eVJJYXdoYm4xSkoybHFGRzB4Z1o1V1R2bXpR?=
 =?utf-8?B?cDFZYm9KM2lwNXh5RWhHRFcyUkVZZnRFWERiNWt2VGc5SUZJclBjSGJ1UWlN?=
 =?utf-8?B?eGROZXJhdzBTTWh1MDgzYlV0aUVlOWtsSEd1alM0TkZaNEJPSzRaZUZnMDVz?=
 =?utf-8?B?THRKTEVNK2NINGZHSFVpM1BvTE15WFNyTlVjSk9pVnBHYy9HUVViQjRNOFlT?=
 =?utf-8?B?SlZWR1JWYW5zRnZ3dzRuVXJjLzR5Y3F6WmN0VGJsVjJoYmRTeWY5RzYrcWg2?=
 =?utf-8?B?QmVndkpUNFJ4VDQ0bE50WkpXRVpSYjFNVEJwdFVJM1Y3cE5JRUk1a1EvRlJS?=
 =?utf-8?B?ekIvVlBDazc0dElsVzN5RG0vUUR5QXZ6VllCbXd4OTVJTTI1YXo0QzVEM1Zv?=
 =?utf-8?B?LzNyT09Vd2g1T0JkOVF2ZFhSaG84aGVpU210dCtSUFZYMTdPM3lCNTl0Mk1p?=
 =?utf-8?B?SzQ1ak9pK1VldlRZdEQvZ3prUjV5SXVvVjZCSjllZDRJeHFOQk9rTTA0OGVJ?=
 =?utf-8?Q?IHVYXwkuZMA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1Z3Y2hxTnh2WVB2UWF4czIwemdlams5WHltS2w2TDMyaGlNZUFFdkhvd1FV?=
 =?utf-8?B?c2ozRFd4ck9TYkRQMm9PMEo1blkvSXpjS3NjNjJzWlNtdmxlekZ2dGZuMThB?=
 =?utf-8?B?NGRPbWI1S2QxNFZZbHZ5eDU3dE52ZmZ4Z2VYUlE2ZG1aQzdzUWROZ1JVNXkw?=
 =?utf-8?B?NjhGK0pzMUt5UkltSC8yYjZ1bTR6VGhXZjh5bGdoeG54L2lPZlk4YzJGMHdU?=
 =?utf-8?B?Y3lrRU1aRVZlWUoydjZDd1dCS3FHTEZ4bW81N0VaT0F6U0JzcmFsKzZGMEdw?=
 =?utf-8?B?ckNNeWw1UTl0dGZDR3hTb2M4MjNmcVRxa0tEc1VCZWVLTWFtOTF3M1k2V1lQ?=
 =?utf-8?B?VWcxekxSVkdIckxVdUJOU1ZNOUovYTcwQ2ZDeVJXbjJBZVhkdFliOWRCelR3?=
 =?utf-8?B?RDdQbDJSajBvNnJVS0szNlFjTDIrSlE5M3ZZS3Z1dndERGxzNzNETXZ0Wk5n?=
 =?utf-8?B?SCthYzRIdkdWb0xjc3JXdFF6L0hLQSthTHdHbVEydk45a2xpcU05d01Gdm8v?=
 =?utf-8?B?QjhvTzJab2NRNEp2Uzl2TFA3cXpqYnVYT2dPUVhKSXVPWmd0SXUvdUpYMXdy?=
 =?utf-8?B?QU5wRGxIYmxuNC9WcSs5RWNlSklFb2RnMWZXRU1XMjZESTB0cU1zTnNydmN1?=
 =?utf-8?B?dG9NNVpONS9INUxFNGMwOFM0a2ZicHRQNmYrTDk1VThmczNrVDdLaSszNERD?=
 =?utf-8?B?RFlZY1lic25IYXFnN1hHS05HQUYzeHZWRXpPSWtTWXBNMVFOZGZVN2d2bEdV?=
 =?utf-8?B?aWRqNzhGT1ZPOHRiSmpRaFNuTHpqT1FkVGMxWGswQXlxS3dDV2VYSkF2a2da?=
 =?utf-8?B?ZWV0MHlLeUtZbWRib1Jjb2hWMU83YW1iczJBK05MaXZDL2svbjU0U0tsV3lj?=
 =?utf-8?B?MFJPYkVkaXVnS0NuU3dDWU5xSmlmcDNUL09scGhsYlBJVUswTXlMR3NmZWd1?=
 =?utf-8?B?KzJGazh1NFZaRHJzWTFSZEw3TGpvVkJCZ1VKd0cyZm9JVHArT0dvNjhMaFFM?=
 =?utf-8?B?VkhqZ3YvRTB6Vnd3Zkg0TS9Gb0J0ZFRucUcrQjc0MXVsYnh4RG5jMkxldXhi?=
 =?utf-8?B?d1A0VkZzSG9neVBLYXFKQ2Zld00xOUJkbEFrVXgvY3hsZ2FyYkRjMTEyVXg5?=
 =?utf-8?B?ZEQyUElvMitQOXdNd2FNTzlwclR5RzB4K3o0Zm9WNFY2bk85SS95bjZjWmZL?=
 =?utf-8?B?ejZWWkx4WE9WSHZpandJWnYvQjBnVmhYUXN4RktPWHZ5L2lSYkhrSGw5eXQx?=
 =?utf-8?B?VXR1MWo3UVVDTnByVGlVN3ZUWFN5Z3J2RTM1Yk5pV1Bwc3U4RkE5UkFnNk91?=
 =?utf-8?B?WHExVWhQenlMaEE1T0gyQ3U1Z0k5TTNlOVNUMHFiemY5ZnJJRFExNG9lcE9N?=
 =?utf-8?B?TmQ2Z1BUdDM2S2RDYTlLZXZraDJlZW9KVzJrUWNWZUpmSThEYkc4eWhncTZ2?=
 =?utf-8?B?eVJzVUNGa1ZSRHZ0ZFB2MnVBSTZoS3BJSWJVREZrSFFSR3lRQXlBbC9mTDRk?=
 =?utf-8?B?cDBLUm9ESTlZdGdoMVJYZHd5Smp3RlRmS3p3cUo4K08yUGNnQlpZaDc5ZXB0?=
 =?utf-8?B?NzlFcS83TVdvTmlBT1gwNjRHZlpsbXZFc09NR0w3bWI1R3NWbXVNbTRUeHY1?=
 =?utf-8?B?WDd3a24zTTdYMlh3T0R3NVFjNTFzT1N4Zk9UVkMxaDhKTUxWQUplcHdINnVW?=
 =?utf-8?B?bVREKy9TR1RoNTA3U0ZGTTVnOVhhS1c4UThkT1V3bnd6bXhoRXpPN2hndUx2?=
 =?utf-8?B?cnVyZ2d0Qjgwa1ZNR0FsWkRrT0syajE4Q3NDZkpBM0N4ZUdmbFFROStHMFJM?=
 =?utf-8?B?WEQvQU0vbnVha0E1bEtlb0dBOGJwNWlSaGg0NjdXajUzMEpJUzMrTXlSaFJE?=
 =?utf-8?B?SXNML3dvUXYrWlM3Mk9CNjAvRW1NcVNTanc0U25OS3crbjkyS2FIZFhHdlAr?=
 =?utf-8?B?WnBXR25aSWJyNHh6ckJKYjFFU04yei84d3ZYODFVdkFiV3M4TGZpK3Rkbm94?=
 =?utf-8?B?a3lnRWxORkpZWHlGYmdlUS96NXVZOVYzTmtBcFdYcmpZWXZQVHJtcDcwV2dp?=
 =?utf-8?B?VmhPSlhnWkR2STkrdmZ0STVIMG9Ib3hKbFViWXphcGJoNTZpbWFHM2owSjJC?=
 =?utf-8?Q?DEXV1Cstm5SSze1ESB7vTAy75?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3553bb50-2df3-4a26-8146-08ddde20b445
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:30:20.5224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22mS0vAURb2zVNsqcMnmqQvh+1ilW4C4kxgpuP1st34TrrSrWLZvJYLC9UwxqncMrdNsrpdgzLLTp1JXLQh+wQ==
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


On 23/07/2025 9:49 AM, Rongwei Liu wrote:
> When ipool debug is enabled, there is internal memory
> to maintain the ipool cache allocation. Need to free it
> when destroying the ipool.
> 
> Fixes: 3a2bda363 ("net/mlx5: add ipool debug checks")
> Cc: shperetz@nvidia.com
> Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
> Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

