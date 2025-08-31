Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BC0CA0FE8
	for <dpdk-dev@archiver.kernel.org>; Sun, 31 Aug 2025 14:51:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E230140262;
	Sun, 31 Aug 2025 16:51:55 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by mails.dpdk.org (Postfix) with ESMTP id 210214021E;
 Sun, 31 Aug 2025 16:51:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g47nyxkaZ1JRiqUeJlzmi7EPsUsbY/jhOS9lI8wauSe926G7YUiWttWNssyYvy31vFCu42hRGD3gDyU4qn+5WmnTNu8KD63wATRtiE3s9GMAHHmJgUoUZQIzqQFgtFlGz8PALgN1SLeoiiZx/wukPSqez4HOb0hOt8QnovBHwuoq7uJMPM8Zf/2pnfNkHwS2DPvPMjDpTw4lh292WuUfahbQMfkbK0v9VgEPDS6V70DoS2TxtsUwx2G7YVCG0eyvtwaq5tsWF6THuhUVxZptfxlLUYRcFNLX4QDqWHxYPPnfzBBPuiMeRQgSWJN/HFBAGuTVwF8/h7EXmx2h0Yh4Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaXZccfKE4ve9vLx/1BhALnoSiSpGjKIZcrnubyOoWc=;
 b=g9OllxOz+1O3JbkgTtoF2M45heKmF03vz/txCS3mBsuVtCVc20j3MBM9fsjbiuoxFcJWe54dLiXdQLu2eqhTWRMCrxKqRSaO6fIuXFrgDcDFS6xss5+kiYqLwYazjOFLEaMOGrpkfFR5KIjNp+r7HqcI+wxjop8uVKpSXWKZxTKriesI1JZcDDCuCK1dONCsYQz3NTb1DKHOCSjm/YB3gkqzufSYtZBJjVb5lv8ueY2nj2F5PIW/v/nquw8++7gw6At9XESmoytmPngQFC2f9Ey0o6YAMjyK/wZHglTww0ssl4aN6GE/kO+UbR3p9eVx30/mxMrBjv4k2w7p3SuNIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaXZccfKE4ve9vLx/1BhALnoSiSpGjKIZcrnubyOoWc=;
 b=ewCZfZ9z+k7iMEt5Xbshk3y0S9AP5DqcVydXyd214X0BZvycIzQYiPC9MKBhSt1Mvuu8mqVFDnTeczx1HJz7743e4XJ3K5wStyktKQIBK8Lu4BEKcsSx/FVDEURAHc2cwIdN8kd6+pIO0WD6TlmCGvfgewG68xik2+9g5dYpqXGZkTDMK0cA9vDDTCD82Ch8jQzgTElr+2Cc7zM3oVwYVuU2RvWih6cRsA39pLjvNgMORes50zwZOqGqHr6jXmcDuGNwlC8flZxRlSPqD2hOqDFKPCpqjZt8iI3LCGzEQNxA4oFe8dair+pOHX8BEfgG8LLkcsR2R4IWyTV2iYPJQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Sun, 31 Aug
 2025 14:51:52 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9073.021; Sun, 31 Aug 2025
 14:51:51 +0000
Message-ID: <e6cc2edf-3317-4ff2-993e-d2574cfe56a6@nvidia.com>
Date: Sun, 31 Aug 2025 17:51:44 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5: fix indirect age action handling
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Michael Baum <michaelba@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <net/mlx5: fix indirect age action handling>
 <20250819112742.1068903-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250819112742.1068903-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::17) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|MN2PR12MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c51b316-53f6-4364-4a25-08dde89deb90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UktjZHF3QXJMSnh2OEk3bHdWeTBXZ0ZYZEs2cE1YU1k1ZlVTUjRiVHhGMDlF?=
 =?utf-8?B?eVJ6L1FHOEg0eGFuS3Y4NjVFR2s4N3NsdDNZUkVsKzc4cll0WUljcTl5SkRn?=
 =?utf-8?B?QUlxNGFsOXQwOTBNS1NQRC85LytTQU9sem45Yjk1ZmVMQlNha2tOcGsyai9W?=
 =?utf-8?B?LzdrdFFPOEF2dHpZL2lwM0lkZU5IT2RjUGtqYWFhbkZpWjBwN3A3ay9GNWgy?=
 =?utf-8?B?WTYxajhCYUJqR3VoN2V4VERoOWFic1lhNWJwM3ladUxKNUltV3N0MVEwODlk?=
 =?utf-8?B?dlZwenBEV25ER05DM2dXa05DOTNxV1lNMzJnTzBaQnZ5UzZVQlZKMXdJbDgv?=
 =?utf-8?B?Q014ZGs1KzZia0oxNHJNcVFYWTFtT29hV1MyWERvQjg0Vm1HeDdZdnBKRnlW?=
 =?utf-8?B?d0RXcjArSDZYOXZDZTFpOXpZNW9LRk5xRDUyYUxOUXlhTStsZkx2NXI1TVdD?=
 =?utf-8?B?UG9wMW5EMWRjQWFpblJvU2RDcGtGaG9tYjNjSDhSUVl6YU00MXF1SXhYZ1JG?=
 =?utf-8?B?RFYxRHBDc25TTGFJamkwTUVDU1RKSDJ6QjBKVFFuTWVXSzE1ajgzYWZHbk5z?=
 =?utf-8?B?Zm1GTEhuZUxBZm8rUmtETDUwSk8rVFF1T2swWXgzakVVd3JPZG1sRFl5ZmhK?=
 =?utf-8?B?b1QwN1F1MzNXaklUdm5oZW53b0F5a0ZKVnRYK2ZtRytsYlZIT2MzZUQrb0RX?=
 =?utf-8?B?V2pEQWxWTnhqNVd5TzQvOHJRWlVmeThMb1gzZzVWQlBQZGJEWG5aZGoya2li?=
 =?utf-8?B?bzdYVGU1OEM3WlY4amVsTUN1WGRkSXQ5OEZ6LzRDV0MxdFlaeUZDY2FSYVFp?=
 =?utf-8?B?YldRWllISVNyVWYwZEdrS2JiWVNUN0pvNjFIM0JYZjhyRVNQWkowL28rbzNS?=
 =?utf-8?B?NzJ1d0VmMUd2MG45Q1JiNnNBNTdGUEpvNThGdHlPd05HVU5FN0VvaWR5SlBy?=
 =?utf-8?B?T2lhZFRQck1YeGNkbWF3VDNhNXVabHNzZlJlRDlvSU1YV2g3cmdnUWw3NEh0?=
 =?utf-8?B?Tkh1RU9JVkVNOWh3Zys4WXNJMDlLdGVoYW9kWHk5bmlJWGFJRXlORUtNS1NM?=
 =?utf-8?B?RVZXQVk2aW1wU1FVbHdTRm03eHBXUGRLdEFvbHpSTUE0OWU3MWJtbXRvcnRX?=
 =?utf-8?B?QnE1ODI5UnJxNU5WRXRqMWNGVXd4RVFta2RiL05heFJybSt3VGNjUWJCUHRF?=
 =?utf-8?B?Yjc2WVJIajMwTld0RWhKeXorTTI5NEkzdWV1MkFZakJVaUNDTlh2NS9lazdx?=
 =?utf-8?B?ZldQNVhyQWtCVTB4K3huOFFpUG9uNHZPbFFxTlcvR3lLQkN2aEl6cnVaVjlO?=
 =?utf-8?B?akp3dVBpS3RNSC9uelYvc3VabzYwL1J4dE14b0FKLzFudjlXZ3hGK1l3UXBh?=
 =?utf-8?B?MUhicjlCbEV4YUk4UDQvaU4xRTZCUHdhaGcxNnRiZCswV3BmRHRWdXJLUk13?=
 =?utf-8?B?d3NvaFlHd1prVEgxaXdrM2sva3RFNlVUK0JMcjRSaE1iWi9mY2VCTHUxOXJS?=
 =?utf-8?B?NjUwRHdnNDZJYnBJbWVabFhLdHptU3VLVm84OUc4cjhBOC9LUm9KQTRXZVlZ?=
 =?utf-8?B?WnBiNFJ5RWovajA4bUZvV2hKd2RsdEp6UW5Ua0tYa1pESnhNRUg1d1JwMGJO?=
 =?utf-8?B?d0xTRXUwNDJyTklPdTR5cnB3YVM2b1Y1NTUrVmliQ2FCWDA1eENEMTl2Vkxu?=
 =?utf-8?B?MUlPcE96SnByc0lCaTBCVmRnZTNNbVRNNmFBd0s2RUVSUVZBcUM5cy82S1Yy?=
 =?utf-8?B?K0U5amtkSzNXdy8rK1ZmdGhVbU9IS3E2SkdXSzlvdy82NVZuekFLNWpHT2VP?=
 =?utf-8?B?TE9XUDF1OG1jZG5SclYySUZlS3prVk9WSTNCZVEyV25jdWNFYTAzNkpVaTRW?=
 =?utf-8?B?OVRPekgvc3dPcW9MVFZhMnd2Y0xmM0JoY3JmTnFPZkRBZFdRUkRqQUFvS3Yy?=
 =?utf-8?Q?Jn/XiMRul1M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VURraUljWXUzRC94QzUrbHh1aVFkSHRxcUcxMnQ5OUpCMGRUeW5xSG9BL2Np?=
 =?utf-8?B?YkhpeG01aTBncWpsTnUyVGlOU2dWNTY3NW5xbW5nYUd0WWRMQVlQakFoQWk5?=
 =?utf-8?B?bkVDSHVlQlhNcXQvQUpqN3R5ZEdyWlVDV3dFM1FBZldFQW8wa1V0WEUrZ2hT?=
 =?utf-8?B?MzJVSGd1SGpZb1VtejZudDh6S1JKdDV3aUo5N0RTeWIrQ1dvZVM5OHp1emtT?=
 =?utf-8?B?S1c5S2RvTE9FWGw0NFM4VGtjUHhwaWJnZ3ZqQ05QNHc3ZDlxTjBqNnVraHBu?=
 =?utf-8?B?dFI4azJkYTJSQks4dWZTbzZMQW9keHhETUc0bEk0MHhYZzJKeTV5MiswVUx0?=
 =?utf-8?B?NlJzM1A4V3Nvd21wMVE0TUlnNFJCSFpZTFU5WGZBL3N3eVNraTJxN2ZPL2gx?=
 =?utf-8?B?ZmVvSU9iMXZvTWR2MUpzNnNMNjZYZ1JsQWl0ampGRFBISmhKY2t1aW5ZUCtx?=
 =?utf-8?B?b0JtU0tKYjNqSzhPQm1kbHlibEJEaE81L091S2tuTzhnVTA2NVY0Umx6UVor?=
 =?utf-8?B?eXZITXE4QUJvZVh5dkxuNGhybCszejhqeGhXdmlVWWFKRGpMbTFsb3A3Tm1j?=
 =?utf-8?B?TVpjejk2azJkeDU2ajUxbkx6ajhPUFM1RkdueFFTUytjVWkvYWxLZFJ5bnpm?=
 =?utf-8?B?azBDTmpMbFlwUmthcHRQaGZIZkVkYkVqaHZ0QVJpZ2lmMU84NUhJSW1keit3?=
 =?utf-8?B?ak1UblZoVlNkQ0ZvcCtuVC9XakdyRjNwcFNVSUtadGZWazE5ZWZqZmw2a0Fs?=
 =?utf-8?B?RXVZMW5qdjJyRDNWS3BaTDZSQ21KK3JCa0lYSkZ5cWJpQkg0czVCSk0zWXY4?=
 =?utf-8?B?cHpFUHZ2QnV3WitIUkxnVmN5bG81cFVMQm5vTVlQSG4vell1bEU1amhhcVZC?=
 =?utf-8?B?TzFxWmlNZzVySUtJNWZoeFl3ZDVxRTBNazdKaE0yMWdON2tva2xVVHZZSlFI?=
 =?utf-8?B?QlJySUdyZ2VrTjhDUElPYmZpU3c3UHgxTC9LdVczN2x4YW54RmFid052d0dw?=
 =?utf-8?B?TDJSdEllL1dTMG1JcnpDUFROOW1wN1d6U3ZFaUczbmdLSU1seXpwYmZ1WUEx?=
 =?utf-8?B?MDdUQ2pPN2NUdnJsQUliOVpkWWdGRjIxMk1iUFRSVjRHTWhNNG9QME1BMnFZ?=
 =?utf-8?B?a0hBeFMwQWN1NUh6NlBlRmN1R0lsaWlSQ2ZGT29ORXA4eVRhU050N2dya1lm?=
 =?utf-8?B?N2N6ZklkcmwzditpMXRqdlVMVm5wd1VRaGo1L21vSHF3SjhPUW13R0pWeTVr?=
 =?utf-8?B?SEo2cFd5U1N5c1FUazJYWUFnRDNtcm1CdHNvdXd5cldHUnc2cE50STFPL2dB?=
 =?utf-8?B?WWJsTEVKYTJnOXJRQ2orN3N5OEtUUG90bG1EaGRXdUV0cit5Y29oTUs4bEh2?=
 =?utf-8?B?SWhlKzR2eDl2eXFLMEZDNUpsTHdrVmF0VnRFUzVDV0h4MjVoZDZtVmlBSEJh?=
 =?utf-8?B?TlJhNDM3WEcrUkJzRDRNU25jRWxIdGNqZld6Y1FQUG5sbUtxR1lkY0JpUjRp?=
 =?utf-8?B?Y0QwVUlORXEwRjE3UkdOelFUNjRkTFNLYmhBa0Q2MEFrQ2VjR3pCSSsyRElH?=
 =?utf-8?B?dUlYcC9UbVVNMUgrbTlZZFRKWmN5SjdnMkFobnQzcU4rdG1vMSs0V1BkdGFG?=
 =?utf-8?B?b3VNTWt5ZjBNTHB4L21FdnhqanBHSU9tZlF3bW1oVGVUNWhGUmFIQzRGSkFO?=
 =?utf-8?B?TXEzQ3BkT21WZGdYclR3ZjBWRGxack82cFZORWc1WFViZjlLTlN5S0FkdUJX?=
 =?utf-8?B?cXRuYWsxN1BXdDJyam4rR0NocVRURDVMWElKOEFjKzVsV0ZtaGY0bENWVUlX?=
 =?utf-8?B?d2RjTFJWL1kwWWt2eU1lbTRCUEtUVExWTFpkZ0tuWmNVb0JmbjZvcElPbXZH?=
 =?utf-8?B?SWpsV2dtR0t3RTNuV0NHVXl1aGRlSFQ3MVVCQ3I1WllyTU5rVXhENStUSjUw?=
 =?utf-8?B?TXNWVElCQ25hLzFUQ24rWE9DUHN4NElRYW14Mkh4OWc0TzQ3RSsrSHo0S1NE?=
 =?utf-8?B?cjMyeG40bjV6OFVLODdoZWhJY29uZ01VT0NUYlBsSjdic3lJM3hmRWdqN3VW?=
 =?utf-8?B?UkREOUlhaE1lTUZxUGYvOVJxS2U2Vi82ZmZFSm90U3VPVUNrRnhOZmhVelZv?=
 =?utf-8?Q?hTnpXfUCsUkispEMKpEhWwnBE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c51b316-53f6-4364-4a25-08dde89deb90
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 14:51:51.8885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9iDODJJQiNhbzQna0JT93cbuUUDLyeJvZ732EM/mhd1yBKI5CwnaN90/WYHXnU4zZAkQYSJO2rODKcFVUI/XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
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


On 19/08/2025 2:27 PM, Dariusz Sosnowski wrote:
> Indirect AGE flow actions can be created either through synchronous
> or asynchronous flow API.
> mlx5 PMD stores the queue used to create that action to support
> strict queueing. When action is created through synchronous API
> invalid queue index is stored instead.
> 
> Whenever a flow rule is created with indirect AGE and
> direct COUNT flow actions, PMD allocates a HW counter for ageing
> that flow rule during rule creation.
> During allocation of the counter a queue index is needed
> to select a proper counter pool cache.
> 
> In case when indirect AGE action created through synchronous API
> was used in that case, the associated queue index was used
> to select pool cache. Since queue index was invalid, PMD crashed.
> 
> Counter can be allocated using the index of currently used queue and
> it does not have to match the queue used to create AGE action.
> 
> This patch fixes the crash by using the index of currently used queue
> for counter allocation.
> 
> This patch also adds missing validation for synchronous
> and asynchronous AGE flow action creation:
> 
> - If strict queueing is disabled, only synchronous creation is allowed.
> - If strict queueing is enabled, only asynchronous creation is allowed.
> 
> PMD documentation is updated accordingly.
> 
> It also updates validation of synchronous query
> of aged flow rules in regards to strict queueing.
> When strict queueing is enabled, synchronous query is rejected.
> This aligns PMD behavior with API description.
> 
> Fixes: 04a4de756e14 ("net/mlx5: support flow age action with HWS")
> Cc: michaelba@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>
> Acked-by: Raslan Darawsheh <rasland@nvidia.com>

Patch applied to next-net-mlx,


Kindest regards
Raslan Darawsheh

