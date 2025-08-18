Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C780BCA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 06:33:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 232064026A;
	Mon, 18 Aug 2025 08:33:03 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by mails.dpdk.org (Postfix) with ESMTP id CD02B40267
 for <dev@dpdk.org>; Mon, 18 Aug 2025 08:32:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXnBtqvKJSct/2Ac2hsn23vrwZJzFCBhfUGhVnlEtcGeD9qDYftTsCUHy09KHmrco/Zj7hPb7N0mfLnARiARpK+RdYa4HhxdQO9z/nrlOBpZrnp2ZbPKCJ24eTlgQ9r/9OngyzTFXEEuKljufMKmWa7IZJa4fr30TQx4XLdD0ReIkkxCCt4M+HgRm2fgAW0e30KY2jvDlRXVqo3UlVB8g8tcEQ6LOVABfWLxYaCq4tV5P/kCgw8a0n874EjmkBZmgHamj5+ZfMXNDMD7fOvHZgb8Hjp11satLUZ9TbjebRHnJVYmTU9mPb3d76GNcjtLoMDNRVcuHYn6XOn1Ib781A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axEKe438AXJk1QDamEyrziCEHo8i1QWdliQV3z5CuU4=;
 b=Mo8GlPeOxiwRK/Hj4Yqa41wfmUJSvlmUwqJVQVB3J4crp5jhcrmSGNBL2Sgxtxtcx2d09aWNoRFc4paUJ4c3ZJ1e2sCmcJzoYBWhVCh9GRcbgPMvKMWf1hwSFts/YnhAqXrwsVwfAbXT9MkWBQ257bfDPcI8udifcQlH9gh9rcBkYMurKaonKAY5/KmgOZSGnBsFfSMLNSyTy7TMDyOFwCegFDBb24cXSpA/iMsoQqDsePSN+ro7mwIrdqaCY9MugW82z5SOxslnVipFhDjpX1VYPJq+emaRHGN8Rz+c2RZiZZibtq+6l4Q75ZyHPKSFxpQ0Wbh7r//INcTSs4yJqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axEKe438AXJk1QDamEyrziCEHo8i1QWdliQV3z5CuU4=;
 b=tQ2A0hY2JsMXHV251vchzAqeBeMyldo5eRzQL//3HYwv/wKnFDAeUureSo7dJHXI1Lt4BbJABspj8MUk823NiBKE0PpGapYB2R8yO8jMsz8opBDagNylxvW8goy7d/Zn638/acbVOesm8oqkGKusi26XrBDlWgVC4vsavghMWvaoPQiduwSnrSRHHvwy2CTOEYJG2OBtD4/xfY/pKu/ks9vw0tZJw7BtldHk1QmrXTmK6Jus5O31rhT8YMksJjN/h8oxHb0MhAgJU4pM1SIW7jSCa0td3FJCQ/vHvrfRaEWMhsp1WaHcd63vnoNmDl4UmwhKYnw6gMkqYXApEfE8qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 06:32:57 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 06:32:57 +0000
Message-ID: <26c4e50f-6b9e-4bd3-afaf-1ccf9523ea08@nvidia.com>
Date: Mon, 18 Aug 2025 09:32:47 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix storage handling of shared Rx queues
To: Gregory Etelson <getelson@nvidia.com>, dev@dpdk.org
Cc: mkashani@nvidia.com, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
References: <20250731104138.61593-1-getelson@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250731104138.61593-1-getelson@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: 40801065-d1e0-4006-fbdc-08ddde211202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjNSQ0dxZGZQMG5rcW5wdjg2YlE4d291VTJiT0dCRFpXVG03eTZKSDY1aWcy?=
 =?utf-8?B?TGl2aWhiOHpXTWE4ZWR3ejhTY3ByVjZMVVBvUTdNdHlYeWJKSEhvMHpoSlZR?=
 =?utf-8?B?S0tvTi9QenAybVdnWHBXcDMrWEk1MGVQOHBhYTFQVXFCMU1xR2ViRjlxTVJp?=
 =?utf-8?B?N0JBNlFhdEp6RmZoVG1Cd0pXdExmTnptZjhGTXRscFNuN0ZOTVhrcU1XMUth?=
 =?utf-8?B?T0RoTWJqQlgrVXA1dUJPSmFTMk9xSk9DN0xNVG1zRVRlV3BzTTBPWlBhWHBC?=
 =?utf-8?B?SGhIWnUrMFdyaGdybk54dGtZVlFTMDRTQkJSZDV5Q290eU9IUCtmMnhUbWor?=
 =?utf-8?B?aDlETmtyanV2aDMxSzQ2QmdRS2RaUm1lRisxMDI3V2ZOVW40dXd6eHYzSWtw?=
 =?utf-8?B?YzBMb0h6MHNYSEhVb1UvZEtiV3ZSRnZFcU9xeHpFV1dUOXQvWkQ3cWdNamcr?=
 =?utf-8?B?RCtIQStUSURRYi9VbTJSQ3FVU0lLenRGak90elp4N25UVmlROE1MUG5JeC9x?=
 =?utf-8?B?SHVuRHppbS83SU9OSjgya2ZUa3QxVm4xejJwTjdvVUdReGUvTVVuUWhMRng0?=
 =?utf-8?B?NVdUSGlQdTRUU2J2L2hHZHg4cHl6dGcycUhZd1c3YkJYOFFRYnliOFFtZ1E2?=
 =?utf-8?B?dG9uT0pzZEIxQ1d1S2czTEFubEp1ZlVtUi9Ia0d0OEc1MEZCMmhYMFBRcTNn?=
 =?utf-8?B?V1FFTTRSS2w1TFJoa24rSndRMXgxQjlXR0laNlNFMHYvYUNoMFlKa0FlYW5W?=
 =?utf-8?B?dmhyUkZRUVBsdmFKMjF2ci9YcVRJUGxNdlgxYlFhdVpTVnFlNnFuVXRDTGtt?=
 =?utf-8?B?L0RONmpNY2lZNkNWWXo1YzRjbGRoQ1o5M0FpdGFNVGMyTDZmMldRT3czWTh1?=
 =?utf-8?B?ZkNGQWNKdXByOEltVlEvTFd5aXVEY2o3UktNQks4a1EwRFFkVXBQMWNCM29N?=
 =?utf-8?B?aE0wd0tyeDZHa1Z0eHFhWk5KYjlMRW1zcldtOHIyZzdHZC9BeTAzNmRIZnR4?=
 =?utf-8?B?NVdHLzZ3Tkw0RWhiaW5HWmp0cmNnb3QvRzhEZjRQay8vUHZVSzNPdHNMNXhm?=
 =?utf-8?B?UmU1QUN1M0UvRW95WXBqa29YRXUrRXBiTXFhTXZjWjV3dTd3dXpSeUpUbUpi?=
 =?utf-8?B?Zk5MMTh0OXVOWkpqZXU4NVJTZzBnc2REVW5NSTZzcEk1NkxoZHRpV1I4angz?=
 =?utf-8?B?QmsxTk5Pb0lXR0RsaVZNd3Q0SHQ0alNvNVVrQmxkVlBrc0lzK2hrTzI0NHpt?=
 =?utf-8?B?Y004THlOSU5LaXpaS1FKMVJxTldIWlVXMmVtMDdzYzUrN0VxRmRNM05LdlBJ?=
 =?utf-8?B?cW1XWnd5WnFIQW13UllSOGtOMnlnR1lxdkxJcG1SUlBQOXB6MFZ3Wm5OZTZI?=
 =?utf-8?B?ZXlGdVpvdTBWK2RNemU3bzlFTG1IQzREWVhqRStpWkliTmszT1c3TXdqM2Z5?=
 =?utf-8?B?RkJWdFMwaUQ3SWFUdTdjc1BxOGRlWFBrcnU0QzZtaEtxMEdlbU9SYUJHQjA1?=
 =?utf-8?B?RGlLVGNuWklaL0ZQdjYzQzdUa0dVYWZ4VEgwT1c3U0s2bktsS1kzWTZFSFk4?=
 =?utf-8?B?bzU2elpBMnlHazJRS2NHT2FIdzhWbGdMRXlzaURYR3FWZDVGSXYzUlhVZ04y?=
 =?utf-8?B?YjNEYjdyT3Q4ZWc5YVBuaXNYOEorMGpuRzh4b250aGtnMVBSL0I1ZDNUUEN0?=
 =?utf-8?B?YXdpVHlaRVBqK3hlSGMrTS92TWxjZmNORkMvR2lDRXJxVVpDQUd6NEpXbGl1?=
 =?utf-8?B?K0gxcVJtdGpRYjU0U3RIMUpEck1NLy90cVB2cTZnbSszSXVJZ3BPV3FQeWNQ?=
 =?utf-8?B?NjZMU093eDNkYm5Wamd2bWM0M0p0ZG4wM3ZoUm5NTUsxaGlWMWtET3ZjU1dt?=
 =?utf-8?B?UDNjcW91dkh6WWpsNnV1UkJxSjhKdHVjVHJwRG13M25udlJXMkNlQWhYU1d0?=
 =?utf-8?Q?pefuYcY4dpU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjJHRGprTzBRUDk0Nm9ZcHJOT2htdGZ5UTVQalJoMWx3MERWQzlBaDBISHpt?=
 =?utf-8?B?Z2JadWVFcnpyRElINjlGdk5SajYxa29XdVozNU1qUzBIQzN0b2JpdTd3cEY5?=
 =?utf-8?B?a0ZxMERTUEc4Z0J1Z2R2RWJIMWZIdXNwbC9XWWh0dDA2Q044L3Y0Vld2SzJq?=
 =?utf-8?B?Zy9TRWZnUWdSZzBEeHp0dzA5RFUwN2l3U3c4aDRCV2dPWXp4WHFXaW1uRTdH?=
 =?utf-8?B?VkxudGF1SmRrKzlwSmxEQnZBNUxJQU1UemQ0Z1NUb0FNd05RUlNGTkpmc0dQ?=
 =?utf-8?B?SXhGVlFBSTRmZ1B3ci9OeEdmVlo3NXFicEZ6VnJ1enlDaGRkNDZpdHhwOXhq?=
 =?utf-8?B?RUk5djhXMldqT3gxUkZSOHk2Umx4TE9XMVBlMUcwZ05KMmlqdVVjTU40cUdS?=
 =?utf-8?B?d0I3ajRPWkZPWHZ5cWRDRzVnbTErRWZZSnhqQ0gzNkJzcGx2ZXlrd0xXRHNz?=
 =?utf-8?B?djU3UkVlUFFwN2tUbmF6YXpwWE5pWWNEMUxKN296aHhmZFFmekJSczEyN3pj?=
 =?utf-8?B?TThhUUdrbmlBV084bkdCTHVmQk5PaG5HMTJTMG9zRHNOMTVGeEhFU2pOeDJ4?=
 =?utf-8?B?d2N3QnJkWFFxYXFCZjZqV2VkTmlhcUhvNGIzaS9PMFpvR1FoYmQwYjhXV29m?=
 =?utf-8?B?amFJV0lMbE0xZmpia0t4Y201MWM1VEdpTjMvRzU1ajFNeGV5Y0dZa0U5cmpo?=
 =?utf-8?B?c2t6Y2JzU3pETUFuSXNYMUxoMkpZSjJrMTlNYTd3Vjg2LzJ4SENhU3FjdW1K?=
 =?utf-8?B?RnFYSWtIZm5YSXhacEpyWDlDeGFSZjdSYWxQNkZvZmY3ZlBXMXg2SGpRMEYy?=
 =?utf-8?B?aHlGRHFOa2w3RGxxTDM1N29aakREbmVwRnpCTDZuTitleHVSY2VUSTBZaytX?=
 =?utf-8?B?NWJtblJDRFZBSTlJbnRlQlJpc2x5bm5VemkxYVlrZ0pvdDE0SlVYTk94RFdY?=
 =?utf-8?B?bFR3VGlYU0tERWxOSFR6NG9SSkFpb1BiUy96QTFnNHZTT0RNd2JHclJ0VjVD?=
 =?utf-8?B?TEJEeXhaSG81OXIrSkxqYWlDYVh5RXdjcWk2V2FiUjE3UkU0aUJWMFlaTExr?=
 =?utf-8?B?ZlNQK0p6QXBBM3VQVlkwc0dtWmxxSkhJMTc1SERYcVM2bWJBdDJlaUE0S3Rk?=
 =?utf-8?B?NTBYNkFBclJtVTJWYnZ2bXcrY2RxV1ZOTktlSmhxNng5TjBnd00rUFphcFBj?=
 =?utf-8?B?VkVWMjc0dzhQUTdCdGkwU2NnYVdwM3B3L3c0WXEzN0Q2MGl2MG9ScDFUOGhI?=
 =?utf-8?B?QWgvNUdKMlNBc0I4aFZIQURwdFRLRlNMQ01BUGVWYVo5MXo1RGFPSGY3SUV3?=
 =?utf-8?B?RXlCa0liVTJVeXBEb2hueWZmY3NnRHFMa1RXcEsreXNGTXZKbHh6bXhwQ29w?=
 =?utf-8?B?V2MvTjJCUUNCdlZUeVFWdHQ2aTdaUUdnSEZhK3FiZ2dxclpzZlZCaTdSUFZF?=
 =?utf-8?B?enljMXl0bGp3N1Z4R1hNaVBESE5iekYvSUkrMk14WmJpSVVLYy9HTHAyYkow?=
 =?utf-8?B?TWdDZVhiVTR4bHh6LzlDbXFqM0xGK05INHQrQ3pVN1IwVWVVVWo4V0NTTEQw?=
 =?utf-8?B?eFRkT3orYnRmQkZFbjAxRzdtUVZWeG83S0NpdjVOZHRPUWRJVFlQZzRmVkVv?=
 =?utf-8?B?dktNM0JFTnp6MGxNWk1icEFka2U0VjdUM013MmhhQXNPWjhFUUFtQ0EyQ05U?=
 =?utf-8?B?Z1pVakM0MnE1ZHVJMXpyMXJNaWs0OEJkY1BOaFV3QkNOY1pMOUR6RkxCZE9I?=
 =?utf-8?B?LzlHVFBSREMrNTdVMkgzQms4WERWREJmZmJ6Tkx6TS9oSEdJR2FWNHRTdU9m?=
 =?utf-8?B?UCtBMlJIVVoybmpja3pOdUtyUFVxTW91L2VKeWVTaDlpb0pIL256a3dJU1Vz?=
 =?utf-8?B?bGg1cEpSWjdhcloyekhrZXZCck9NM1RxKy9lNGJOKzdkTk9FVXl0ZEhrUUgy?=
 =?utf-8?B?bWY5WFhWczk1ZXhCZVlRVGxZZUsyM3lSWUNnS1hsQnFUTDR0blhva2lEdjdj?=
 =?utf-8?B?TDVXTytwU3JIb1BEcFBaOUZldkZMMGQ3NU1KN00zSXRQcXQyTk42dWQvREhz?=
 =?utf-8?B?OVZkNFkyMlFJWGQzZGRUZHRmTlBmaHo1NTB0RFplU0M2aU0rYWNsYWZHL3h5?=
 =?utf-8?Q?fziHT9DJxsyMKpOLJGt5nJriX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40801065-d1e0-4006-fbdc-08ddde211202
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:32:57.6617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6bZE8tAXN088911BGeyiGojAQzsvwCsQs2ceOFND4EGejDEBxxekJdXfsvdRgd5Ukod5i6d/RxSTxvI3h08EA==
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


On 31/07/2025 1:41 PM, Gregory Etelson wrote:
> The MLX5 PMD maintains 2 lists for Rx queues:
> - mlx5_priv::rxqsctrl - for non-shared and shared Rx queues
> - mlx5_dev_ctx_shared::shared_rxqs - for shared Rx queues only
> 
> The PMD used the `rxqsctrl` as the primary list for Rx queues
> maintenance.
> 
> The PMD wipes out port mlx5_priv object after an application closed
> the port.
> 
> If PMD shared Rx queues between the transfer proxy port and
> representor ports and closed the transfer proxy port before
> representor, the representor port cannot iterate its shared Rx queues
> because Rx queues list head was wiped out.
> 
> The patch separates Rx queue storage list according to the list type:
> - shared Rx queues are stored in the `shared_rxqs` only
> - non-shared Rx queues are stored in the `rxqsctrl` list only.
> 
> Fixes: 6886b5f39d66 ("net/mlx5: fix hairpin queue release")
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

