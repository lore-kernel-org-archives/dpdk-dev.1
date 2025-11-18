Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A0DCED61E
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 11:32:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF64540265;
	Tue, 18 Nov 2025 12:32:27 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
 by mails.dpdk.org (Postfix) with ESMTP id 45A3140265
 for <dev@dpdk.org>; Tue, 18 Nov 2025 12:32:26 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2+zk2tRgq5Rc7djopFY7IzQh+I27pyuXnDTRVIFhKvPfakP8jU3EU5kqzqMe4N7pCf0WMnnMXwsrWFCLSGSv+mOHQG+I4tPHZFQqQQp1ujMN/VC6J12l9uUROqFCO0zF6Q6P+DXZ8TZj/BkZtIps7yd7pFKmj1VrCtnu+b/Cm3QgzlNEvHT/dcJSA+dm0sSYilIN2M6ibEe5WzM74x8hOagV0RWh+bziPnwFyFTd3JBxqo+NiPTT69uHfkl3lfiRtWfEMdT9L9faattvb+XtlHEsVOphYAOnhywE2QdtGhPH+24pU0IC363z+hRIC6lTzWax0cP343uZXoUuJWAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FstEOs5iqrGaNuvz7hiWXlYohfquE7fk0iP2ZW5d0Q=;
 b=zWwJfQhw5V7AkcDRkJ3uh44E0Iaple6X0tiJL5CeHoVs1vQ/JcGYT7OeDeJpNCGS9lOiRfHR9Tp/ntS168HWrADMjxmWUj65emAamZByQ+z5cRRP5Kd5rh9PZ3Wi5d/Q6jqtSjR9fgm6jdDd3gIPzw9rEAANux906PYpv6C3wCwXvFlzoBQAGUY5difWpYyVdxgv1Eh88yOzh7K6Dc6RIaWgwPHGsQK6N/ah6BCjnbZi2QmCeKsz9kyJmxKB9DIBSZr/ygY5jf09oCmL1I/cf1IvtqMysuytu3khVF4UXy3ubqNlI3638VR11xVYlKnObHB0Z3aAzBTvU3glRVuJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FstEOs5iqrGaNuvz7hiWXlYohfquE7fk0iP2ZW5d0Q=;
 b=sfx9cNFpBVUkfnhMphJeHSK7PN+zhKADohL53wnTk0ZAc3UrpotZZEwmF1f/VWk8rO34/797N2UT86KydhMRBgUgspSwCqLESVi8UHi4c7mPVNC1H2ByyY27tduLsvUZzuUT1ybBw3rlqZ0DdfJIe56gkpL2M9KrI2lS16q8f5Y+MTFPkOh906g1Xr//ZEQJW02mOoHoYAa8bB6JGhxRHKbKUilTgDJOKeysXh0G4Q5c1JuBzvWDKINLm7ve5yVSwSV/vYc9cAmoqr11lVSdbrwuBXgEsjm6C8B2RD1aBWc9e8ml3w6yEldHw2OS04FvQfo8OsFJ2A6Fi0g/9qdSGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by LV8PR12MB9618.namprd12.prod.outlook.com (2603:10b6:408:2a0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 11:32:23 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9320.018; Tue, 18 Nov 2025
 11:32:23 +0000
Message-ID: <60271076-2c52-41db-bd19-ae695136a1e3@nvidia.com>
Date: Tue, 18 Nov 2025 13:32:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: move auxiliary data inline
To: Bing Zhao <bingz@nvidia.com>, viacheslavo@nvidia.com, dev@dpdk.org
Cc: orika@nvidia.com, dsosnowski@nvidia.com, suanmingm@nvidia.com,
 matan@nvidia.com, thomas@monjalon.net, mkashani@nvidia.com
References: <20251117072752.9290-1-bingz@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251117072752.9290-1-bingz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|LV8PR12MB9618:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d7b92f1-38e4-4e72-d891-08de26962466
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1BBOU1DaFl1cFZ1cjVUaU9vdW1uNFY3WTBTQ3ZDUE53ajVhU0plZnkybUZE?=
 =?utf-8?B?WHNuSlc1OElJajNXa2RIclBCOVVpMlFwcXRkVTR1aVU0YkZzTUpGdFNlUHp1?=
 =?utf-8?B?RFl4SVRUN1R2SFVvMENxYlhINVlaMytuUU9qTGo5RzFnNmFiLysvMG1ZUVlK?=
 =?utf-8?B?YldKSXNpYnlIMFhtalFqTmdUYWp6dloxclIyeElPNFJEdkkrekdrM054UGRw?=
 =?utf-8?B?MmRmcEZWYnJKbkNEZkxJUkExNzM5UTkyWnBVaHpnT0xhY2MrZWhsUkwreXpI?=
 =?utf-8?B?UVJVeHQvMVNqSDdhUjBad2F1TndLTUpHMHZjQkcvZlkwNHoveDMzM1ZiMTl3?=
 =?utf-8?B?MzRmRy82eUxjeExNbS9yczhtbjBzY20zNHNIMWo5WWc0T3o0VVZGQTV6c0V4?=
 =?utf-8?B?QlNYZzNTMXZEMDN5d1N3a3F0dVFOa0hSRkFnOVpmVVp2VWtNZnlIVnptUkg2?=
 =?utf-8?B?Q1Mwdis4d1BxQTR4M2dCYVh1TWVSMEZCS0VWSmoyTkZWazFnM29zK1pwV08y?=
 =?utf-8?B?Z2lzQ2RXYlVSNXdsN1UyWlZQS1Vqd1J6aVdQb0oyWjc1OE80d2Vwei93UWdR?=
 =?utf-8?B?UTBuZjBqUkZ3cU9NRHkycndJc0xOUjl4SWZWZnBsd2lidzh2LzhBcjUzY0Vq?=
 =?utf-8?B?K0t5QU5KRE91WWtuUi9YYW01SE9qSG1XOXpQSFF4SzRCcjVLeW9XU2gxNEdQ?=
 =?utf-8?B?MFhNSS8wQTY2V3lDa2xCbkpnYXQ1ZHFtcEdPaXV2cExMRzh3b205dEZ6YVMw?=
 =?utf-8?B?QWtZWUhKV3c4NzVsb1NJc0daaWMvc0tUN0IyVktPdGV3aU1SQ0ZIeHhKR1N5?=
 =?utf-8?B?VHBTSy9hZzdTR1Q0ZEZPOGQ0THpEa0hRL04xSXovTFNlYzZWbXYybDJtdjJz?=
 =?utf-8?B?ZExPaGk1ZU5IQXZ3bFl4UktOTUh3L0ROQnlOSFNDRDBRRkpwSm90ZW8vSVN4?=
 =?utf-8?B?dUJmdHdCVzBzMStwUUNOcW1GM1kyaGNyclRFZEd5K0t2WHR0V200a0NTTHhH?=
 =?utf-8?B?bUZSYzBJRTdTckc5WTJGd2lDTXZ4c1o4YzdlMGxOTFRIZWQ1RHJ3Vk41azNQ?=
 =?utf-8?B?VjQ1b2JCam5DT3NoWW1ZKzJJNTl5eVhXYWtsWFMrdHBYeXZEY014Q3pjVXR0?=
 =?utf-8?B?OXM1UjZPMURTKzJ4My9YVDhMZ1kyaDVlc0wzRFg1ZGpXNDFZaHRLdTlaT2xw?=
 =?utf-8?B?WFB2Y0tCNnFXeVVQOWtGTFpES01EQmlmUHA2UEpFbjFJaGRCSHh2TkRzVzNr?=
 =?utf-8?B?QjlvS0l6NGxCSG8rc3BWcFQ5Nzdtbi9DUmVnMUxzUWdTRFVOdTF0TVhvSmlS?=
 =?utf-8?B?L2tJZmdtbkZzTXNLQk1HeEI1Ynk3TGZpT3NVdzBnb3JScS9LWCs0YnowNkJ0?=
 =?utf-8?B?MHlTdzhkZHNuWmlCY1FXQktXQ09acFp5Y3dlQU1ta2xKelVtTWJpc3Izcmw3?=
 =?utf-8?B?b3hFcnFzUTN2azFDekxOY2E5MjA4RFdBVmtqZVJ5OEtUMWpyUDZpQ0dYYjdv?=
 =?utf-8?B?OC8rMkZDbjY5Mnh1d0lTdlAxdytKUmV5cDA2ekQzUzd3R0t0Umw0Ry9Qc0pC?=
 =?utf-8?B?dVp4OWk3cTEwaEFITWRrZWlFTjZvSmY0SWx4SWs3SlBHNVpEWW9aQUxDQWZT?=
 =?utf-8?B?VXNrekhFeURiY2xDR20zTUMwUmtuVXZPOW9XWHlWQmlPbVl1WkRJbSswU1Rm?=
 =?utf-8?B?RTIxL1VVeVZyNHRIVjRPSkhwK1V2dXp2eFQvWkNZM3RXVDhsU2x2andWYmdp?=
 =?utf-8?B?aTU3WEJXVmtRbXlRTmlVMFlFWDNuaVdGU0ZOdVBlT0tmSk51NFJZTkg2UzRs?=
 =?utf-8?B?S2tOVlAzUXR2azEwT1kvNmk2Z1hIYTVOeGJYWUwwNDJvOURpZElNMlRSTmNB?=
 =?utf-8?B?WlhQYjNuYTdOOHIrR2ZuUnQxWWtGMHplSkxpZG55VndGWVBVRmdkL0I1ei82?=
 =?utf-8?Q?/4DCtG38jSx+uhM84E8xdYirMT3f9/pP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnNGZU5TTDBOdUtsVVVjRUx3eThYQlg3Q0VubWRvWS91eDEyVFdpZ2swb1Vw?=
 =?utf-8?B?YmJmOWtkTzN4SFExTjdybVdMbkxLNlJHaDZ1KzZTVTVlNEhVRGlYR0dHWFha?=
 =?utf-8?B?eG8wdmhxR1BkZjdieGRPNUZ3YXgzRUxjMlM5Sm5ibHNrOVpKSDVJSDhaSmZh?=
 =?utf-8?B?MjZXRHJzendENjM3SU5qZlJjazVyakJTSmg5Zld2NFVBMktINnJjYTFkbHFu?=
 =?utf-8?B?WTdqL01DVTl0UTlPZ2RLRHkyRnN5NUxzUmZscXJMSEZXUGRadE9nZ0hnRHJY?=
 =?utf-8?B?Q1J5b1hRcndncm03blBjOUR5TVU2NzFFSU40Q0RZL3FtT2pmM3BKNmFJWkpW?=
 =?utf-8?B?bWpONEtIL1BtNWpTTnZTUVdROXpsS2lPMHV1TFBtMGRCUlB6WkNsM3pSQkJt?=
 =?utf-8?B?RkJsTGR0ejZVWmlIUUJHTEU0Sm8wUjlXUzhCQUVKdmtJaU5tTmZVSXdqVEhk?=
 =?utf-8?B?YmEvWmo5bEc3SjZjdWxTeXRKYkw0S1JIRFIvZnIxaFYrYldOVEw5YytDTGYz?=
 =?utf-8?B?S1o0cy8vUmNhTEx5cGNBSUZVT3ZIY1p4dy9qUURST0pNZmZ1ekRwSHgrSTlZ?=
 =?utf-8?B?eVNaejdVVzRnclFZOU1wQjNLaEpMK1Foa1lVRXduMXM1UncxQkg2M2taOEtR?=
 =?utf-8?B?RC9Jak9yczFtVkFmYytTNEdpRjcwVjhlY0tGK3FiWnF4cWNpRFVuM0xTaDhB?=
 =?utf-8?B?bGNzK0kvTVIvMForVWJOL3dMa2h2SjNLc3hzYTVBODNYSTl6bGlRS0tuMjRn?=
 =?utf-8?B?S3NnZGNtZmpZYytoRUdXV2U1T1FUU1Vlc0pxcjExWlpaMVNOM2ZHRHB5bFBE?=
 =?utf-8?B?bEM1U2RXUy9TeVI0OG5scWRydWR1YTFMekJ2eGlJM1NWdXc3cXEwaWNWQnBz?=
 =?utf-8?B?dmpWR0hQdGx6ZS9xNTNER24vV1picEJGV0NXbEsyakZkNEpaL0JIZlBqdVVp?=
 =?utf-8?B?WFFmOUdPNVR5UFRURUhieTBmUUsvOS9ZbDRmMG9URmRlazRMZHlRTmNvc2lp?=
 =?utf-8?B?MDQzeHI1V3djTENtcmVxUStMUWRmUC9sNC9LemlOOVVnckhWd2txOVRSNGVy?=
 =?utf-8?B?QjRQb0t6aWFmVWRmK1dhTlZWSXF3U1NBM1Y4MlFvMXVvc2VCSG9wK0x1SElV?=
 =?utf-8?B?OGVudGlNZnNOR3pHbVlWdzRjUWRKTHYvTzZSQmJ3VmhoS0N2cXJRaGV0QXpY?=
 =?utf-8?B?VW8vYWJ5eDliUDRGdWs0OVJyM0ttVTRqbzJQLzBuaTl6Q1gwWEZUU2xjcXlt?=
 =?utf-8?B?c1A0cVZhdjFEbmd5OGFvMi96ajRuSkphUHJiakV0M2E3bTdMVktuVjQ1eC8x?=
 =?utf-8?B?Y0IvTEd3d1ByeGVnbUJQb2FqckR0Y3dZMk5rMTFUa1pLOUhMZ082US96cjY5?=
 =?utf-8?B?aVRCN2lOdndtb0pwcVQxdTJhVmtIZW9TY3ZDYk1OcHNXd2dTTk9ZRmViTWVG?=
 =?utf-8?B?c2hSdWFLeWZoa0JFOU1pVHZiT2owcnV4Ym1vMnVZMnpjcWlURXNYaWo2OCt1?=
 =?utf-8?B?cTh2WlBScHNMQUNXVmZTbmdObUpoZXQvRHpubHh2akRQbFk3YUt5Z1R4ZFVx?=
 =?utf-8?B?UlVTRmtHU2d3c1IzTHZKVXpaTnpwRVRpRkw2ZlRpTzRCN0NRN01tb3Y0ZjBX?=
 =?utf-8?B?b3U3cGRQMzhUUHZmRWNBNlhvZ2t4Ulk0akZESXJHMjZiMTZpR2lFRndMZXAx?=
 =?utf-8?B?OVlBNGJZcjJwZlZMaUhOc0ZZdlowWnJwTDh2d3hZeGVMWlFwV2hNM1hpSWtn?=
 =?utf-8?B?QlhsQU9GZ2x1bVVQTnN0OStBUXhya0Zla1k1WUJIMmx3K3VtR0ZJSlRJajh5?=
 =?utf-8?B?WFBHS3ZmaHZsWWoybmZmNnovNGRjZGI1V2RxeXFCdzU1RXFkcm1Zc1F2WjFl?=
 =?utf-8?B?NUplR3VBRFRKRHdRTXZnUjVtaWJVd0NwcGs3bVd5Z25uS09ueGt2aEZCSzMy?=
 =?utf-8?B?WWtxWDN0dzcwNG5jOFhtbTBacHFvZ0QwNVkxS1NmR2VHdXVaczM5WDNJc0Zh?=
 =?utf-8?B?anlwQ2lmcTYvcFJCakE3dHcxblF4MCtCRHRpdmlyZDVsYWdPTEF1b3dFVUJm?=
 =?utf-8?B?Tm1NY0RYbWdjaXFzL1FWWU11cVA4RDVzUXZYL2F0eXE3bCtQZWlRajJHZEo5?=
 =?utf-8?Q?bDodVNd6NVHh80YXUlQDywEY4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7b92f1-38e4-4e72-d891-08de26962466
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 11:32:23.3750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8QQnxooyoSUk35GYtljLld1OP2bIqWKXZP7pExp9ZMc+enICrrESW55joil3Yn6FtyZUq1g5IZtdHT0A/jMww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9618
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

On 17/11/2025 9:27 AM, Bing Zhao wrote:
> Since auxiliary structure is associated with per rule, it can be
> allocated in the same ipool allocation to save the extra overhead
> of the *alloc header and the unneeded CPU cycles.
> 
> Fixes: 27d171b88031 ("net/mlx5: abstract flow action and enable reconfigure")
> Cc: mkashani@nvidia.com
> 
> Signed-off-by: Bing Zhao <bingz@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

