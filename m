Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C70F54AAC
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 13:04:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9DB74067E;
	Tue, 24 Mar 2026 14:04:02 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
 by mails.dpdk.org (Postfix) with ESMTP id D65F34025F;
 Tue, 24 Mar 2026 14:04:01 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVK+TFR+Vqi7P+DcV1pI0NJ49D+ZPah71IzmGJXLLv1j55OajKpnUm0DRkK5q8SktHwGTyy1Xpgr3yHF3Ecks33zfTgooFVI0sHRQedKk4kEOknLJRtAv5881oFnnvwJItggfu3edCpj5OipkqeKwaGWI/4hXpoGu/UQmvYUxMnVf0NEnFHldmc006otbXzT0KAV4Bxr6+7WHB0t0m29t9IQiqS9nWjNXj7H6Y7e3rVB1rJub3Ia4hnaIbbMXPwkocesEmmFWYyNoXoQ1+oxkT32N8pWHfkS9TXNmy8N9PV+54vaWVJyX+Q08zZV8f9IUQ+SBqN5VYvlEMT2jgDSIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zN6dqUojFiSzgElkWAHHN/YEnbwN/puYDEQvnbmvvnc=;
 b=Cz/sKX826BY6UG1u1xtbhPIR8KTTMmqNjuvK+nUNaaEhiU5Dfl6caFvXhz0J0XhBOo2Bsrjhc/qc6C2vLKpph7YimvSDDXIp+6aeVm0IWBmE5cgUY45bBmYe1Nk9svYYUavaWo232gMa8creV0tFh4L/khLUHwQdlG7NWjThlujWM7RtLyFzClaXaPlBpfMYdBXybEt57Q55nkcp0iYpTGclkbgi3aTN6ucRiKWVH/gXQeCVyzatDPjQV5ARN9kVbULw+WaNYayC3SXSCdHR812EzeO0kMeujUediFKB9RZoihaKVjEif2PmkVS+fTFigBp1fs6w33JgF2TCo9jnQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zN6dqUojFiSzgElkWAHHN/YEnbwN/puYDEQvnbmvvnc=;
 b=JPHJkNe3upo3v37de4gFg3/6u+hEkrQ4ERtfMUc+GMN5E/0HBn8+z0YyURQGe+WdslRt+tHvV9rjPKs7c2UXTZdcU+mzaUJnwysWf+fRQ6EnDBEb//Ii5lsIUoS7JKXZ2ILAbCzkpMUxl6FAqJUP3h6yr6P9EvPmRVtytm0k71HEIwaBqinlXNzglMiPhkyVAx3h8mjvvf8ktV6sToXFwb4/1tAEAPTRMby/eyrbq0u62gGM4abNgRQRSWvcS8xqQPygOJJc0idy3ObR4Y1frvnpxEIiXhXc/WJCLAJDFAwQNfWWsN0I/JKb1/mIGnMcUAmyZVFIBpdQwaLreuDXJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by CY8PR12MB7516.namprd12.prod.outlook.com (2603:10b6:930:94::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 13:03:58 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 13:03:57 +0000
Message-ID: <fcb9d7d4-44a3-47d3-b8c9-2ff7d3d97a25@nvidia.com>
Date: Tue, 24 Mar 2026 15:03:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix VLAN strip info for CQE compression
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Alexander Kozyrev <akozyrev@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20260320160001.787223-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260320160001.787223-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0020.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::9)
 To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|CY8PR12MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e2d521-ae45-4fb0-14c2-08de89a5ceb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: VRg+QIJdgJmCedAbGanQPAExxwG1SQ/FxPo56j9jDzwtU8HIwWx57z80YAI0PB8d+uLI2Reuuj16mV23VdHVkGNXufTN58W5eQRp9cZ8f2Z4JxTQcJh2/FSaV9Ks6tfqwtl4E2gLkP1/lke0MvUz5FoUccxqPVFFdZ0Zh7F051Wd/tmzYEwmuXCkzVkdgtnqVvZd3vn7ONjyykj1NYHcu55mTaH17IS+R6kP3Cupt5TTmje/be9hB0m5XxP91ETwrOijmcb639u69bKbefLI8XXEiGtTyQAg0I0uznqZgvOh24gh9LrAJ3VD04Txj2q/y7yoTFApdEtAVoilM8CJTiLu6bOWENFzONyaWExTdDsCxT8K6QurK7KC/zcsB/Br1pFoCF187KjlYSf6NGB1C1dzBz+NBAunoRqwZM/tzDlhBDGzQO7iL4OJ2DvTlhzsl058ScWftY2EWtaPpXMO+PRloV+p1mVztNIQ2nFhlhCZXu1FAxIHzlNQQ/VLlMbkUTlFt74fC3J2nEZz6CzhFOLe7bSDPsNWaPtfFsuAmmdblvKrlSf1FiNaEbyLQojfK2YcrJJ6K0Or1VH4vuguR79upsdAkdU1+F4l0TDY61sE9wpr38WGWUBpjL9ku8QkIjDBB46TraZOknLUXdpNJJAfiazKKW6eZ48vxQtDAIzmncBCWNtt03S/mU7EjduOHU4yWymcHS5ZEiRf4MLAqLFTWRZqQoQTIY16lbQWcQ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHZzV29XNHZ5Y09rRi9mY3ZGNURqYjZRNHNRenpKWnRmV1lOL1Y4S21zOHNv?=
 =?utf-8?B?RS9mZk95TWs5K1RCQ21jeGtSWmx3S052UVlXeUorazRqRFpzSmtsYm9EOUpm?=
 =?utf-8?B?WWRBeXN1WGtvbkRMZFd4R3c2akUvcGR4emFHZGtUVE1QRW5JU0QvZFV4OUxE?=
 =?utf-8?B?clJhTVJuSytvSGZyZFZQYm81TjBleXNINkZXVFl4S2VERUYzbTdxVUtINm9E?=
 =?utf-8?B?UjJGak9QSjVHQVpsSU1NVzVmaWE3eG43d1VaT2FNQ3pSZHkrbysyYzlucVlH?=
 =?utf-8?B?YnBhWkZiK09STG9hSzhpQnd2SkUySnJ1NVY0Z2JxdGtnOWNGaDQ0em4rcU0r?=
 =?utf-8?B?YVZ0TFJsN3FsZzZvWkVnMXBwSjdOWTM1YzV5UGRoVDZ4ZllqVFNJM0YzR2Z1?=
 =?utf-8?B?UnR4QzdmaXhYSlYwS3J2MTV2ZHc1czZJZGZ2d1hXSE1LRmxGaWdoMGtieXZa?=
 =?utf-8?B?aWxSeUdlanh4RGVTZ29qWHFNSEgwWTBuUXJuRi8xcHcvMTIwQXV5Z0dkOUNE?=
 =?utf-8?B?TzdMcWNwWjBaUVZKUm5qYmREazFhUHlGejdxU2hrZGpBa1hObXBmK2diQWgy?=
 =?utf-8?B?NUtkUzJuZGs4bFMzVGxWVWE1RittWE9FTHpMYXVrUTI0QmF6NVMzdHo2S2F2?=
 =?utf-8?B?KzJlRGZIVWVvY2xaMys0WUlPTU1oM1o0U21YNlQwRDVHczlZOGE4YStWck0x?=
 =?utf-8?B?R1ZUeFl4aE1zR1VrUnlhM04yQzdRZUNkbTNyVUVOajVoR0RGVVJZMXNEbHBZ?=
 =?utf-8?B?OTZWOE41eHpwWWJ5anBkVUgxZDlFREVQL0dEeWJId21QdlVnQ1dIMm9CMS9s?=
 =?utf-8?B?RmV5YWhCMS9BV2lqTy9rS3RBUEp2WkNEUEs0TU9GUk9BVHE5UGkwOCtqQzZG?=
 =?utf-8?B?cXpIVEVaV0pnK0FYbkJRR2ViZnVrNk1EZGYzK3FGQmgvZU14YWtxVlU1dWp3?=
 =?utf-8?B?bkJpMVZaeFpSK0hoUzl1Q01kVWNicktPaExBUm1HT2p1RGRPTTdMbDREK1lP?=
 =?utf-8?B?M0t0VDdsOHBhOEdrYWtncytxbVNTOXJySy8xVG43YTZPalBVcXhrdWJTQXcv?=
 =?utf-8?B?N3RCMGdXeVN5SDFvQ3hwOTQ4VExYcGNsbTc2R1Y1SWszZTRCcS9sOTN2Ym54?=
 =?utf-8?B?eEJkZGNxTlQ5TmtNajl0Ti91L1VYMUNIWll1aUlNZTA0RDlYRlBsdUtrRTlK?=
 =?utf-8?B?ZGtjSjRoQVlsM3AxNzFRUTZ4OWpHRW4zUTNBN1loY2dEZkdjKzZaU3JDSlZ2?=
 =?utf-8?B?a29LVmZkcGpoV2g1NGVmMFE5Vi9HdlMzd25ucjdmZmlaWDJ6R3BvR0hjbmZh?=
 =?utf-8?B?RkV5cE00SGxzeE41UHpBSkozUWo4OHViYm9CMUNHWHJQTnJJdGhlNVpPVU5Z?=
 =?utf-8?B?TlZwRVJBcDdsZi9YbEhVeGRjdmNJZlpvZVRHTUhiemFkR3ZDT2M5Y25lZmNa?=
 =?utf-8?B?UE95NkFoZXVKNzl0ZE4zN1cxM0JsWjV4UzRQYWl4T0xMNi9jbnhCOU9tcncr?=
 =?utf-8?B?UG9VSU8wdFRSYU5KNDlzZDVuV0VvZmhubjQyRU04eWxHaWxIZUJBZUlIa2Nk?=
 =?utf-8?B?UjZjb2ZuTmlLYmlsZ2wvaDdrVTY2L3Ruc1o2ZzQ3RzhBdjRIWDZqTTJJYmZ2?=
 =?utf-8?B?c0NHQmZmdVU1M0ZsZnRXVVNsRTJnanYvQnArMVZkMWkyS21yYXV1Q2pWd1Vu?=
 =?utf-8?B?Smd5b2JNQkNsdi9telh2ZTJFSTE1T2c2R2lHUW1PbUg1dUJ5VnI3OTI1Z1Yz?=
 =?utf-8?B?N1Z4OEVFckxranVPbGVXTjA4QTkwMFVYejh6THhMM0ltcUlXNmRwMStHaGdW?=
 =?utf-8?B?T0hnTFdLZGpoSkdrQ2ZWREVTdGF0aktYYk85ZTJtUFB1Nk5velUrNGtTcUtM?=
 =?utf-8?B?NmR0VWNHT2pqaFQydTBsTW4rTkUwM2RNY09KWHk5MlZGZUtJaWEzY3dZSDhW?=
 =?utf-8?B?aDlUZDNlN1hPalJDaVEwaHg1eFNoNkl2TGdPdi85R0U4cDVPWGVjS2sxVE9F?=
 =?utf-8?B?cEUzUG81L2lYRytZVEpsLzMvV2ovSFE0NnloNDdlOXB5d1ZMY1JFNWZWYm9h?=
 =?utf-8?B?bXR2U3lXT2hPT2lEN21lUFJqUlZ4NzdWQmRnUEZ5L29nUmpCL3VNMHA3STFZ?=
 =?utf-8?B?eTh0QUpHa3JhZDZGNWJOUnFqQXY1OWRHOVJDSmlxVTdzbUh3R2RvVXAwNllw?=
 =?utf-8?B?SWxqdXQ1SnZJaGlFYU44SUhONUlOc3lrU1ZGZXNDUWdlQXVqa25hczRJUHJl?=
 =?utf-8?B?QlR5NzVrM3A1bTNZYUM5c3p0ZzR0c29peUJPa1BRV05STjE5ZUt6Y0grYWZ0?=
 =?utf-8?B?Z2MzWUF0ZXk5U0didVRSOEhIWFhBNGVhdDBQeWdaTkxlSzZxcHVRUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e2d521-ae45-4fb0-14c2-08de89a5ceb8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 13:03:57.0788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5ChvXG8uDiej1ao/CUlu3DN/qxysqRsw9JDq+kl6hpzUScGZEx7of2W6KZK85O0vzCOul2N9iGD57dzURvk4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7516
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


On 20/03/2026 6:00 PM, Dariusz Sosnowski wrote:
> When L3/L4 mini CQE format is used with CQE compression
> (rxq_cqe_comp_en set to 4 in lower 3 bits),
> each mini CQE reports packet header info for relevant packet.
> One bit in that header info is dedicated to CVLAN info,
> used to determine whether CVLAN is present in the received packet.
> This info is used to determine VLAN stripping info
> when relevant offload is enabled.
> 
> Before this patch, users might have seen incorrectly set/unset
> RTE_MBUF_F_RX_VLAN and RTE_MBUF_F_RX_VLAN_STRIPPED flags because:
> 
> - Struct for mlx5 mini CQE incorrectly defined the location
>    of packet header info byte - it was swapped with neighboring
>    reserved byte.
> - CVLAN bit was checked incorrectly because of cast to uint16_t
>    and big endian change. It should be checked as uint8_t.
> 
> This patch addresses the above.
> 
> Fixes: 54c2d46b160f ("net/mlx5: support flow tag and packet header miniCQEs")
> Cc: akozyrev@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
> ---

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

