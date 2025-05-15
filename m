Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BD7C54754
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 07:10:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 272C340667;
	Thu, 15 May 2025 09:10:40 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by mails.dpdk.org (Postfix) with ESMTP id 8E3AC402C2
 for <dev@dpdk.org>; Thu, 15 May 2025 09:10:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYDEK4Yl8WNNCQT4kmU0gZ3kuOr+QOijs0P1qIRD5ia+GLh4iglSEPE3dZm45FFZeqQmUgqByEnGKxQG8TdQG0NT1tjCOI6jXQxkPxQwlyVqG/FQ9/lpSccbZZR62b9mGBk7Ppx3kVcMRDG+rmQ0NmiwJNbptBRymx3G41eir+XpoWl5st+x9FgPZ7E3mh+wTGF3jKQuIXJvO+Pii6+F1CeuRfUHJSH24PKgsUuURe8kcdFGKfQiRZ5ntVGGo+ENASxZ6RBQxQhXKXHnotS7+1sAjhRazTweE5oGKSkur6c83X17dZYCW3GJ5JQ9zrVFZCZ7cVVCvjO9JPYQMUTK5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xu6LUPdZ4xGH+Aj1Se6EUp97vZ9BgmHRFWTcWop+PMk=;
 b=UcANiDLJSf9USntNjt0QXJCFQtpmfv3+r7+RAQR2CY/67/FhvqdNKfW5b/MXUBlNYY+O0ZftsTOpKRLlBDyGGW2ZuePGjhudFRilWN6Z5OdDCvYlXsc/kGmgo8XM+U6qQVBTC4t3fKHtDLlC04kNSVLs2gRt0KcDQqqKIy2+ssTbCsWGwsu64qLbGrfh7F0a9KvNtuysK4m2tTp26EgAk3s8bHH037mWKtd7o8Wl+1amXTZ0D7FAsCo2LCH5nQvyAt5H1eRIqq9vHMvtCVU880s5hec7Awetmmr7Uoli0SfetjwXOZwuhiSk/rZ0+4FBHdRLRedNJA4J54MzRABzLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xu6LUPdZ4xGH+Aj1Se6EUp97vZ9BgmHRFWTcWop+PMk=;
 b=fsnHDuJjkFMpNYdaVTnzJ99Cxg23MEy2cmGhihuxhpv0IxFuksxvAoTvUG0UOi3hCAc8ncDyRVvGDcdoQLr4YySaWW7nMNbtCdG4/XT/cg4UXhCmYFlYIHS62MteNFpaf3QgjrrGAv/4qsMW0XS+oDw3NVYYEK53x2mJXsFFdtWlH2bpn+UCsoYazwQv+QpIdwmcMVSTpYvfYRJ8my7lITVz6cqflQuVhibSHvtPCyzsj81JWCkCD46QsfrMncAvVVevPVIdvniRK/ivLpt3hPeiBOKveb9PLEMbe8gHTzzhqtiZW91YqOTG92rGDxrGnxTCvtD2mcR789Tw+0aL9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by SJ5PPF1394451C7.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Thu, 15 May
 2025 07:10:35 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 07:10:34 +0000
Message-ID: <86658130-6060-4bf6-9137-7101d07b878e@nvidia.com>
Date: Thu, 15 May 2025 10:10:26 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix mark action value in shared Rx queue setup
To: Gregory Etelson <getelson@nvidia.com>, dev@dpdk.org
Cc: mkashani@nvidia.com, Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Jiawei Wang <jiaweiw@nvidia.com>
References: <20250514075018.67370-1-getelson@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250514075018.67370-1-getelson@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::17) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|SJ5PPF1394451C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 48cc15fc-774d-4aef-8039-08dd937f961e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aE5aVDFmRW4zYjdaQ2JiM25aTEljV3FIdjNGVWRqekFTN0tHSzF4U212c3BH?=
 =?utf-8?B?UWNJcnNhTnhIc2Jsd1NyakNnWmtaQTRMQTJOQ3dCVlh3QWF3RnpYQkNvQlJS?=
 =?utf-8?B?SCtSUnZEMHZMQzFwOTZFVFFwUDNicWNpVk00eC8xMC9NNzN4YUkvWHdxYmpX?=
 =?utf-8?B?NC9hcDE5ejQ0Z3hjT2F2ZjV6UzJPeTB3aXVCZ2FtaThMMXdrTHIvRGNBb0NY?=
 =?utf-8?B?bW1SU3lxUnM2TWVlTE00VGROdEpobkt3WmVhUEExaG5pc1kyYnArc2c3bldU?=
 =?utf-8?B?VUR2MXJQUDdhZ3ZwRVVTOFZzQk1CNHM3ZU96eUJsbFhUZGlWT1E0cnQ3N2Qw?=
 =?utf-8?B?NkxFTitqNW55WjQ2YmRiKzlWbEtIcVBwaVZORTVqeWMrRXNDRVhmZUxZMlk2?=
 =?utf-8?B?ZDBEMWN1dzgyd1JDV293UkhERTIycStldktZaDAwQmlYQWZ5UXlEbUlpSFAx?=
 =?utf-8?B?T3RwUmtmd0FhOGRpTHBHVk9DTHU5UEx1ZmtrcjRJV1F6RWNIRHJUNTVpNDZW?=
 =?utf-8?B?Um43UitNWmFjT2RqU1ZmaFdZU2syNGQrSHN6UnFRNm1hc1RlaHN0bERNb2Jo?=
 =?utf-8?B?bTJzSm1uSEN3alZ6VDY5S2xrV2I1U1RENVd0eFoxcCt5MGN1czlPV1FCaTBD?=
 =?utf-8?B?ZWp5aVFYZlY2UkI5eXFZaVhsS3ZDWnR2djZTb3BOblJYdnkxT3VOVmJPTTFS?=
 =?utf-8?B?ZituT1BRa3Y2Wk5ENWRaTE4rWGp3MU5Kci93UFFZS3Exazh1b2VXOXJHQTNW?=
 =?utf-8?B?Q3FxS0xqMUJ4ZTBhbzFRVnlZQnlVRFRjS0NHc1JIZFRUcGo1aThJU0Z2bFVj?=
 =?utf-8?B?ZW5wV2d0T0dYSkdMOEdQRUNTZVllZWlaL0hGSVovN1EzM0NGV21iaUFiY09p?=
 =?utf-8?B?dFhMaWZ6LzlzOUxnNWd3VVlHN2pkREdIYzYwUXF4VHh6MGV1Qy95aXFZaUxZ?=
 =?utf-8?B?Q2g0dk5KM0JLeHc0djhvcURSckxHVE1PUTlqeDNlbStPM003YW53Zkw1SHlv?=
 =?utf-8?B?MG5wazg5Wi90YUExQzRmS1ZQNXE2SkRXYTZ2UTdIRTFnblN5M0FwMVpENW1X?=
 =?utf-8?B?VEVnMVR4dHBxSVRaczFVYXBUbWpMY0FiTkNFM1k4cVV3VlJTK3BQRXUzdWxH?=
 =?utf-8?B?N0s4aTl6OWZBcGJaVWphZGRwZTZqQ1hTTVg2dVI2UTFVVzgwRHRGNDhpbUNt?=
 =?utf-8?B?V2VIaGQxUnBXTUlYQ3V2MG1DTjIxMDJGejYyekptQ3cwY2V0OVBNN2tleXpB?=
 =?utf-8?B?VVVYTDkyUytzZ21jc0h3VXU3WmladXlDeXRXZndQWEk4SnoybHdpMUsyS1ZB?=
 =?utf-8?B?b1cyZXk3RXFjdWE5VURid3hSNnQvV1JuMmRMdFhjWFI5L1JncnE4cnlkRGQv?=
 =?utf-8?B?a1owTzN4enlvbmpQb0o4SWR3Sldva0hFYnFObXVqUTVxazAzUm1GRExWZHMz?=
 =?utf-8?B?VTE5RFM3TWUrbzdRY0dQbFNLWTdzMnhBOVFLRlJMaW1peXo0OG9JaDN3dGxN?=
 =?utf-8?B?Z2tJS09HVDFhR05YSi9CQjJaTHhSTmt3ZjB3TGhXRU5zSG56TFVPNWp2ek56?=
 =?utf-8?B?U1dEZDJLNENZbnhOZXBMMmlIdW8rdmZLZno3d1RlaGxrYVNPeTQvYzczMjFY?=
 =?utf-8?B?aE9TbTJGUjdScExKRlhkWHI2ckFBWDZIcnlrdXYxM3J3U0VCWW9FTUV2aW1K?=
 =?utf-8?B?S3NwUk5oTHlRbmJWdGs1UW1WdnNwcWU4dFB0a0syTmE4bFdZZ2sydjBJdHR0?=
 =?utf-8?B?bzY5ZUlPK3hQRzBxQkZlMmZQSUU3MUpHNFphZlZoajR5UnU0WEFzWmo2SDVq?=
 =?utf-8?B?QlliQ2grVE1EZWlZQWVjMVk1U1BGL08zZm9vQXg3aGVRSUN3V1BUcEZVOEZN?=
 =?utf-8?B?QmNjS2FVUzk3UW9IYm1mQWIwSlc5WUNwMEVFUWJXbS9rREowWkNCK0VvUkZj?=
 =?utf-8?Q?T/QKEeRmeME=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDY1elBtV1FremtsVTFvMXhENzlEMmZEN2tFZmNuelpRWlNPM0lIK0R1ZGNq?=
 =?utf-8?B?TVVYSmlzU3hrakVNNWp1aHZmeUNuVUJ4WGtQdk5sMEV2Q3N1TE1WWk5Kb2NM?=
 =?utf-8?B?bUtlc3diYTRtWUdkYWNZOEUrVXRVWUh6aEx0MnR4Qi9tbDA4cG1HNE4rV1hj?=
 =?utf-8?B?NTM5TGRMMkNZeWFHSU5FOXhsVkg5WDZsNi9YOG54RU1aKzRyVXkyMUxDTnpN?=
 =?utf-8?B?MnIyNTducC82MjluMVVqeXg0Zml3TnVBeldEMWEyWG1DeDhCd2tNa3JNaEo5?=
 =?utf-8?B?RHhoakdQcHB4NGtjWVg5R1ZjSjcvek0yMWhDSWdMbWp3ck5PRWxyMlMrMFFi?=
 =?utf-8?B?azd0blNWcVE3Rk8zNDNzZ3ZlSGJReS9CZzBBcElXc0JxZlNSY3k3RVRQNGJl?=
 =?utf-8?B?aThhUERUUlQrNEI4K2FURDhjK3FSamhFVkhGQ3EzTG91SjlpWmd0MTMzdG4w?=
 =?utf-8?B?dG5UcW83OURCVmVZTDJZZXJtdTFTdnJOSms2Y1dKN0pzMkNaTG1WblNMQXFM?=
 =?utf-8?B?OVRGenJoZzAzZTNHOVVyYjI1Y1A3MkZYVjRNMjc3UW00SG5jdDViUDVmTWp3?=
 =?utf-8?B?UUhKaXl4MTNLSDBLZG1uMzRGMlI2QlQvbmR0ckk1azF1ZkhUcGx4L2FFbE1B?=
 =?utf-8?B?YzNPOHpYN0tQNGJCL3VKRTlNMTlrU0N5TzRNZmNVcFg2ckhZSm44SWNUNDJM?=
 =?utf-8?B?TzBNUjczZS9SS0d4OVpqdkpnL3EvVDFaWHl0Wll2Vnd0UDdTbW4yRnROTkJz?=
 =?utf-8?B?R2NqbW5SZ1RGcHJ0Z3BQZDNjUkFxYkVvS084UWFFR0d3dzJGTyticzREVUFn?=
 =?utf-8?B?VVdhRHI5TmgvWmZ5akVMV2tJaEVvVzBIWW9jcHNjcW8rQkJSTmt5M2Q5VHpr?=
 =?utf-8?B?QkJxOEFwS3dnSlZsUmZLUUoyWUYwV3o2bUdZOWJIT1RZTlVpOFlZK1MzU3Mx?=
 =?utf-8?B?UzhMNkxNNGhXOGkwN0ZmZ1ZVc1hqOXdaejA4bHh4ZThoUGwvbXVlV0UrcUVN?=
 =?utf-8?B?ZUI3TnRvSEpKYWJIWnZkeFk1RnhLQTVteERpWXJJVEd0M2lqSFdYai96QjNC?=
 =?utf-8?B?UTMwNG1kNFcrSlZrK3ExOUt3endDcXBUTHZDNUFHbU1kTUIxQnk3Y25sQmhp?=
 =?utf-8?B?Y0NJeldDK0RiVVFUaTdzVk9tZTBoSnd1SnZwT2cyZkdBbWNQSlNadlViaElP?=
 =?utf-8?B?SE5LUHg0NTlOSjBacFNIOSt1bWh2eVJ1cUFuSElzTisxVVZvekFyRjZPMjZo?=
 =?utf-8?B?TUUzaXpXNnRJMWxwWjNtMGxXUUZJdTA2Qjh4ZjZuOWhKUGlKb1pWelcvWmpl?=
 =?utf-8?B?WUFoc0tsVkRHQjhLVkQ5RGgrbDBDeUpjTitaU1VvTGxPMldodFpqMTdPWlNk?=
 =?utf-8?B?WllMN08wSjFqVmJzaDR5RUh0aGpLRzczQkhZUy94QURCUW12dUhGZ3hOUk9T?=
 =?utf-8?B?bExmdnhvQzVoOHVJMmJHNzQrcWVzYnVVV0FNMFN6OVdub29QUFhsN1BWeDRB?=
 =?utf-8?B?VmF3STZMZk5JdDNzVUhYZ2twWlpEUnU3bkNLdEZER0d1TVlvakRTQUY4QW9q?=
 =?utf-8?B?aE5WNGc2UXI5WFZtUkozaVk1Sk1hSDBsdHpYVDZDVWNsaEdKdllhcFFZbzRS?=
 =?utf-8?B?dGNxUGFJZ3Zyd0ZXNUVoTHVMWWlwc0g3UU5Kc1hpQU92UTRvdnhYRjh6cy9i?=
 =?utf-8?B?VGkrVSt0VTlMbEV0ZmhpOUJVb3JFazlKTExzcFRHZFpYNkhER1J3SHJ4TEdX?=
 =?utf-8?B?dDRMaW53cGNRK1FXZ2FWbzFKcHgvczJzaWM2dWVhaEhPS3BVV0VKbXVkQ1Ax?=
 =?utf-8?B?YmJFSnNPOGxONk9kMnZXT3l6VVZZcEp5Q2ZzYzVMcTlGNzV0cmFiRTYydld6?=
 =?utf-8?B?SGc1VGhYL3ZQcjdhckwvS0JZa1I2MDlDVG52bEMrOHNOc2ZaVG1vc2RuQXdx?=
 =?utf-8?B?d1Q2RzNzaDFtaU45SzVlcjY2ZGpwNUpVTFZ2TTd6OTdxYVZiUFh5VG5HSHNM?=
 =?utf-8?B?dTBhcmJtVlQ0MVFEVkFTcGRvWVRieTBHSk13UUFsblE1RzJ6dEw4S0VOWHc4?=
 =?utf-8?B?TG1TdjU2QWN0eWM5a3pDQlp1T3l4R0VhaHdEQUx4REsxbUkzTUgwSnhacjEz?=
 =?utf-8?Q?MnmNGsmYRZt+4c7cONHtM2hyO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48cc15fc-774d-4aef-8039-08dd937f961e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 07:10:34.8341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqdkheckHD5rsRVPQD3RW6BeJawq3IKdua55GUKbtYOX2ROkQA4YTuKyBxptvfcJl5hcm2ujlBi/43ALZ/BLmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1394451C7
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


On 14/05/2025 10:50 AM, Gregory Etelson wrote:
> Patch `2d8763432add` was not applied correctly.
> As a result, `mlx5_rxq_data::mark_flag` was assigned wrong value.
> 
> Fixes: 2d8763432add ("net/mlx5: fix shared Rx queue data access race")
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

Patch applied to next-net-mlx,

-- 
Kindest regards
Raslan Darawsheh

