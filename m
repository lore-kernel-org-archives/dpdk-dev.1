Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E369EC1EA5
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 12:05:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C909C40E5E;
	Thu,  5 Feb 2026 13:05:55 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
 by mails.dpdk.org (Postfix) with ESMTP id 16CA14026D;
 Thu,  5 Feb 2026 13:05:54 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2F2D1oJ2v22iEiPcQKPU/Ca2SSTU+Cw9LQ2vbSuwWflOsqcYjIDuEOs8nEIrtHeVfoJrd5wVAGoRpus4Je+85xCCz0cO7UhqkrfDZg69U+XoHuUf+EaS1ExwGE6deqnFw1vfxgbb1uVua30W7YoHufrzti8nry5sFRhqc6QK3jitUReC8zhsentiiDTIkskaTuKiORyCUTOQumF0dQDwVhW4Hks+nPFDax6FPnK5nsY+l0zpvNuALSkiql0XE6JDPd+8jMMMuHwFf4dJ6cTW3UiTXWRKq/fOtcJ3BmG9vDpHcKc3BeX2fNP2LXttEU0CSzcNVmyGOeaZ2i1yWn1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXUd+dVVCfbftBq3cbBzpbKeVyINWMcmJNJAV2AuOY4=;
 b=l5KXMBvtJs+eS/k+28IY4drdk9FPUYB+eN4j4GWbmlJozauPa0MyB1o05GGSJhhLALGiqXpJGZ9JN6IEiMSlwH8zuffFlxOEdJMdPozGPRg+5atpCS48+5oRZ9JY6oNnBH1FYFsOrVQh6eKHmI3gUlZpTPCesK2x2aJGx0RGyFfkEooyrSZe8f+pWecgeem/6SUuTTCHltTFVtYb8w2UUQvMd02yr+iO6355HXDYFU8MWtzcyuogTc4D5qnQglPqwU8/+yBnNzccDMo3+fG3jzGjmbE5NYt41MLrvKNvTSnO3xt3pz76OcQxcc/vUVK5ISCLnxVw71mrR0Iiw4ZNOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXUd+dVVCfbftBq3cbBzpbKeVyINWMcmJNJAV2AuOY4=;
 b=QhLV258abB9mWhvFqBNurHZeoKN6z2/scISqTUOvfrJr+EDv+iIG00+Q/+wgWKoipB/ktdJ3tm76ccK+5Edyw0jr8SbkRUxLNPtZ6xRS1ekkNtNrYd5VxQDl92yKSgpq46a0NYByDPn28NSSqk1sCwJaFHhN/1/kCBjRFbO4rFPNXvjFnnxppvoJC2vuOtnfPNy1AoDkLxXhhZWqbNvBDY2mwAqvVWb8TRkQBX1b8vOgjVfNg2cPCPIY4CN4WVv8Zn3RTiIkji+7Zywk7DGN23q9sJ6ek8/aNrlHfMRBqocL/8j1YPVs9Bc1ixKFA0w6dvbyERCCU/OWsnQDCKHsJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by SJ2PR12MB8926.namprd12.prod.outlook.com (2603:10b6:a03:53b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 12:05:51 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 12:05:51 +0000
Message-ID: <515ab846-3a96-4d4f-b8cc-b1a047208fe5@nvidia.com>
Date: Thu, 5 Feb 2026 14:05:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix SRH flex parser initialization
 synchronization
To: Gregory Etelson <getelson@nvidia.com>, dev@dpdk.org
Cc: mkashani@nvidia.com, stable@dpdk.org,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Rongwei Liu <rongweil@nvidia.com>,
 Alex Vesker <valex@nvidia.com>
References: <20251225162049.648482-1-getelson@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251225162049.648482-1-getelson@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::12) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|SJ2PR12MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: 890c76e9-42c3-4dc7-f344-08de64aee7d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTVoV1NCQjhhRklsaXB0RGFZekJtejRtQmRlRXB6Y0daMW1naFlNMVcvWndT?=
 =?utf-8?B?YThMeC9JNzVsVUJkZXZDeVQyYWFPaW0yY213ZExLY3Z4NjV0QUJoZHB0dFU2?=
 =?utf-8?B?WHhjdFJ4VExkTDFEMmRJZUwrWklSYnZkTjdVbXdESlZYMW40Y2p3R3QrVUZT?=
 =?utf-8?B?VXdnb0FoOW0wNFB5NXRTeDkrM0Z0OTZZT3ZKNDJjWjJSQ0FYUkRPaGNzVEND?=
 =?utf-8?B?eElmbFliU054WjlRZHpCcTk2V3o5Y2MxVDcwaW53YXpJd1Y5WjVaVkdwWC8v?=
 =?utf-8?B?R3MvMFZERE1DT1l1WkdkY1ZXRVQ2bFJqL3I2UlQ3K1A0UWVHSTcyS1ZkK0V2?=
 =?utf-8?B?bUFLaDlzTTF3dEhnSDBucWxsK3RCaDBPSVlld29IZ2tHQWZENWpwOW1ZNDdn?=
 =?utf-8?B?RWhZeDVmdWwzMFdKUDB6d3RBcU82c200ZXR1Y0xIbkVQR2RrVFMrMXFDZ0Qw?=
 =?utf-8?B?WDFHUWNQTWwzNEJ3bW0rUzl4WDJ5MlpmdHgwb0M2WGtiUDdQaE5Ra2NGOHFB?=
 =?utf-8?B?VFZ2RFRtR1F5UmxiSGVUd3hPZStGVU1TM3FiYUdpSStTcVI0dWpuNWNMcGxF?=
 =?utf-8?B?UVRWUUk0dmlzd2kxL0ZnSVo4a1VnQ29PZ3R6MVVWK2JpNHFjNURqcFlIMXFG?=
 =?utf-8?B?RUFLRU5GSndaVHk5Uy9NSFZnODFNSkR0WUxmQ2tFditlaVhVbVJMU2xRdlV6?=
 =?utf-8?B?dm5CMVVnRHBpbmFOQzNvQUJiZTY5MUFzVFNCMzJieTVCNnJTWUI1eTZDbVJj?=
 =?utf-8?B?Z092anhxdWI3bUZrVG5IQWVnOWhJTUx2RjJuVHgyV2FrOUhYd2lRRWxiQkti?=
 =?utf-8?B?TExkakpJZkFxajVJWHRoQlJFd0Vwc2UxSGt2aGI3ek01Wjg1TU9aRlZzMnJa?=
 =?utf-8?B?WkNrNXNTUnk5NDVpUFFYWTZ1Q3kveW5uSEUvOCtwQ09oZGFFTnZXdzdwbkZr?=
 =?utf-8?B?ajBPWnhzcE9HbWRxSHFDbTd1NlF1SXJSbWhPMjRhL2NLSGFvWjFZRTNaR2Z5?=
 =?utf-8?B?Y25xSTJUeU14Qmg2TTRzVFNoMEFuZ0cxZEZBU2JtbE1MaEs2M29jTXFBdEdG?=
 =?utf-8?B?eXhkZVJpbHRickZacUNHVzZUTDhWUjdzNlI2VFp0Mit6VGxQUG9TZ2Fwa2c5?=
 =?utf-8?B?dWtiVkxvaDJQdmdjSG1sUEJQS1duc2YzUm9VQWZrUFIvR21nVmY5eFEzRGJk?=
 =?utf-8?B?Y3dHWEFsSjNRWWFDazdSSXVPTnB5eTdJSG1nMlBaQTJhb0pzRUQ2dzhodEtq?=
 =?utf-8?B?NkJKR1k2RlhDQ295T0s5aWJBLzNJNm1waXdNcU9zcUdERDlnMTg4VEViRXpq?=
 =?utf-8?B?VW1XRHNPR2tGL0hzL0hYNmwyVlJ5c3h4Y1o0RlptM2RWMktCcGswVEN6Qjdv?=
 =?utf-8?B?Q0hnOHlVSEhPMWJzNGZNQkUycm1DN0hUSDk1RThJL3R6NTBiVlZabkNQdjJz?=
 =?utf-8?B?RGhVdG5jWmR2UXFUUElGYUgxZCtjZ3dDZHZJVjVlaTZIeFpzTDEwTlVjaGs2?=
 =?utf-8?B?aHJlN1BEcFcveUFFMjRXOEE2enBZbmJKYXoxQTZPT0lMdGdaZGZSQzUvVU9y?=
 =?utf-8?B?OFhpcTduQ0FvTlpoQklzYTUvR1ZpTFhyWVlLZ1dzMFJPOVcyOUhPZGNyUTRH?=
 =?utf-8?B?WjJsSDdOWkY0QktHYkZleUhMNW9qaGdoWWRqSDNHRVFlRk55ZTBHT1hrYlBM?=
 =?utf-8?B?NDBUaG1VbE9ISlJ6WXFtMFFsM2pESWtXUitZWUZSNE1IbkJ6VUd2Z1RKQ29F?=
 =?utf-8?B?Mm9KUEZrZmFRMkdmbERmdjhJMDYrTWJETnV6Q1FyMllvQWdzcGhqVE9FaXRa?=
 =?utf-8?B?SndtVkorOWhaY2hoekNHT2MyWDY5WHBOSGIyWTRNbkZCV3hjK0xHN2JBaHMx?=
 =?utf-8?B?dHRacWx0M0l0YldDd3Arc0dVR3dkdFZ1dVl3K3IzZDBNaThoejdnUk0vd3FW?=
 =?utf-8?B?UjdkSGhkRHRPWklCUExsMHVsUTI2L3NrNXBWakJ5cURSRU5kNmFBcGdsOGJL?=
 =?utf-8?B?TUlVUXl2eE8rRXFhTGQ0em5PeFkvb0NSRGltajE5aWtCUXJjSzA0M0xpb1dG?=
 =?utf-8?B?ZTVnRGhYTlJqdnVvSmZxKzlJNlQ5aC9ObkJYdmZ5UkJ4bnhmNzYwUXpsaThi?=
 =?utf-8?Q?Wkww=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVBMK05rNEtuUFMzY0E3KzN3ZGtPbW8zZXJ0N3Erbk9jNHBHaE9mcEYzU2ls?=
 =?utf-8?B?b1FETVByZlRsd3FQOFdidHJ6MGtxSnhCTjlIemxJVnI2eHBFRDJzTDVQeU9W?=
 =?utf-8?B?Um5LNXltSzdFZlpjTU5VajZOd0xDTGFPKzZlaXh2dHprT0dOa2EzekZBZzBS?=
 =?utf-8?B?M1plSDNzWm9EQUp3RTRhdi8xODVKN2hsTytWd3NTVUxSOFNkNmsxMmcyalBx?=
 =?utf-8?B?QWJmalZOdGNSYkx4cytqWkt4OXpUYzFNNHg4SXg3SkxsYlBya1JacGVUQXdr?=
 =?utf-8?B?TTlvR0lJNXdwejVTZEs1Wmt6UGRuQjFnVTI3elUvTTBtZm1kR3B4WExpelRS?=
 =?utf-8?B?QlJzWGJIT29kbWtSL3c0S3c3TUpDUkQzbnNIRC8rTWo2U0dWWkdmUUE1cDY5?=
 =?utf-8?B?TTNPN1pRUHZkWmhBdmZCRzVlSVBKRlpPYWhqVFN2RExqcmFaUnlUOGFUVDMr?=
 =?utf-8?B?QlFvQjJ0SzloMjY4a244NXh4cUxaVlVUTm5FMlNneVBkN1EyQ3JBcjBNMC9F?=
 =?utf-8?B?SHRtUFptVlB2eVM3dldmK3VGWFRLOGg1NFlMSklvbXp3QWhndTl4cUxxdlNR?=
 =?utf-8?B?YVlYN01zWlpYR280ZDNuOXA0NU91RUlJWEZiOVBoNnBsSGdoaDFaVkdjMmxE?=
 =?utf-8?B?TFVMUUVsQW5panp3SkRSc2dVZlJEOTJ5ajlLcU52TjNKdW9wUmZTVlRicGUx?=
 =?utf-8?B?SnhEN2xid3NIR0VBbWc2MmZmNXY1SEpXbEtjSEViVzNxTmdNWGtaU3VCR1Yv?=
 =?utf-8?B?VGdBN2NCUmFnUis4Q2lUYWZvSGw0dFMrU1lGR3FlZWhjYUhRWmVFSUkwYUhB?=
 =?utf-8?B?bFcxcjBFWERaSEhKRE9JZWdSZXpvajZrVHd2aStQTi91VS9mcWVtaEEvRmpn?=
 =?utf-8?B?c0FpOGhOcGNkYmhrWGJRSEpWSFBKd2JRdGd6NjNGZVlaRVhYc0RQTkpDN3dv?=
 =?utf-8?B?Z1hxZ0grK0ZUcVFFNmdtTUZMRzRQZm90UmxvMTZlejJuTTFKSVZibnRUYmY2?=
 =?utf-8?B?ZXBQZXNVMERXQURnd3hOZkdwaExFV2o0cm9mQzhMWDFlRUlhbUdlSGUzZFBs?=
 =?utf-8?B?SmVKbXNGWkNYdzBPbHU2WGJJeU0xdTRkSmhFUTcrek55NlF1S05mYVQvcXE5?=
 =?utf-8?B?c3FSZXVDczJHdXdwYVdrNjBMOXVDdHhtbjJrbUczZjN4K2VYdmc0eEU5ZXVR?=
 =?utf-8?B?OVdsS01ITXFJWGd6SXhZUTFtM1M5K3BFeXlSQ3BTdWlRTjI4M3ZGVENVZnd0?=
 =?utf-8?B?Q24wdHpndFE5eWZvYkJML1E5dE9rdFpiNWxHMW1pT245dUxBQXEyMXlzZmZB?=
 =?utf-8?B?S1VSVUg0cXgrSFEzT3Z1TVg1d0FiZDMyOCtiVlhDdVdkUWdXRUpSbmFSQVdw?=
 =?utf-8?B?KzZZUjk0RGwrMldqUS8yVWM4U2pUVU85TDFPVFRFTDhjbkUxVEUwUy9HU0hn?=
 =?utf-8?B?a3QwRXhWbC9ETHpSZ3pLV3R4T1FpdCthSlJZS0pVTmY1U3ZBS0FRblowS1o0?=
 =?utf-8?B?K2FZM2R4aGNBWURPckRla3k4TFhlVU9XejhDVE9heUk5TTF2OVdWWHRTU1g0?=
 =?utf-8?B?WC9DdWRKOUUvTnUzQUtmdUlYV2VwM2crSmtTenovRkZtSFBOVnljLzBiWmxp?=
 =?utf-8?B?aFlpeFdwZkV3VmY3Sm1oekwwbFp2OUZucmpqazZZd1RVQkdOY1pzNVppa0dl?=
 =?utf-8?B?bzdBTkR2MmtwZFEvMmFPR0lyY2l6U2lTUzFZUGFpa3ZBNmFtaEtpOTc4SWdI?=
 =?utf-8?B?VklpSTQ3WW45NExzd2Noai9ObjBZREhKVmY0WmEyK3lRaUcvYjV5YWpZM2l2?=
 =?utf-8?B?ZE5hL1lRUTc0Q2YyRk9GVXdud01JdlB3L0RJMlpIbENyTjRHbFN1dWNMRlNk?=
 =?utf-8?B?aU9tQkxwU1Z3ZThjMWNrMDBVTktncHM2RGJSZm9ManZ5RjB1RW9ia1ZaNDkz?=
 =?utf-8?B?MllmckpJbUs2cVkzYm5UbGI1d3MxU2NkenM4TVhLQzZoT05lOWE4cjZHbzZ5?=
 =?utf-8?B?VlU5U0c1eGtLMDVJMjdRYUEwQXMySXBMVE1HMkM2ZmtkUVdGRUh0M0dYdTZ4?=
 =?utf-8?B?MERTVTl4RG1XcitvS29qa0VvQXhPc2JmUy9IWDhmR0FMZkd1VDE3QlBwMlRr?=
 =?utf-8?B?U1RYclQ2cXNyTTYzMzZsSjNodnExOVF5RnhGSFpFbGdIQnJoUHYwbmcwN2d6?=
 =?utf-8?B?dlNES0RLK1ZZMk90RHJITStTR0lNdWVSWVVJc2lvRm04eTNxRkdPaXI0WEpm?=
 =?utf-8?B?RDdUZHArdFhWSkYzTk1ZQkttUkcvYXErd1VaajFIZGNvRW90TmlQM3N0MDJE?=
 =?utf-8?B?Sks4NU9FaUVibjNDTUlIWEllRnJjaTJPNDJ6bC8rSmtRUS9HWmFlQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 890c76e9-42c3-4dc7-f344-08de64aee7d3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 12:05:51.3411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHp0t6dBvd8TFNEZMZh0G9AOCUtNscFhoEwttshZl6S9SqWfS26o8emjjcqdv80LyNW4+Nqhcgw6Vzv7dy6tmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8926
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


On 25/12/2025 6:20 PM, Gregory Etelson wrote:
> When multiple threads attempt to create the SRH flex parser
> simultaneously, only the first thread (T[0]) can proceed to the
> initialization code.
> Before doing so, T[0] increases the SRH flex parser reference counter.
> Other threads (T[i]) entering the SRH creation function also increase
> the reference counter before returning a successful code to their
> respective caller functions (CF[i]).
> 
> This can lead to three issues:
> 1. CF[i] may receive a successful return code from the SRH flex parser
> creation function before T[0] completes the parser construction.
> 2. If T[0] fails to create the SRH flex parser, CF[i] will not be
> aware and will assume the parser is valid.
> 3. If T[0] fails, it will not update the SRH flex parser reference
> counter.
> 
> The patch addresses these issues by locking the SRH flex parser node
> creation attempt.
> 
> The first thread to enter the locked section will proceed with the
> node creation.
> If successful, T[0] increases the node reference counter and removes
> the lock.
> If it fails, T[0] removes the lock and returns an error.
> 
> For other threads (T[i]) that obtain the lock, if the flex parser node
> reference count is non-zero, the node has already been created.
> These threads will then increase the reference counter and return
> success.
> Otherwise, they will behave like T[0].
> 
> Fixes: 00e579166cc0 ("net/mlx5: support IPv6 routing extension matching")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

