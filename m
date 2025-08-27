Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCD0CA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 14:05:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EC624028E;
	Wed, 27 Aug 2025 16:05:29 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by mails.dpdk.org (Postfix) with ESMTP id 27E2E4027D;
 Wed, 27 Aug 2025 16:05:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FiE8kA/sTOQz55FZq/pwbclM2YTBKePYUQ+PEoWDxGR8q13mtrwItx1aH3iKdpcttTZGdf0Bno2k7XBjGEmLeIeu5OrRE30Wqu35WFgDr5VS8kx1yUOhl59DkqNIQy9UTjKNEXoR3WyAScKPpZjVBvs6t9K+y8eHRE/50nxvj6w8ALrXT4pBYoWbIlqnJW89Ehx5RtzKoVoWGHNe+v3+VrapZVxkhbQmLyT/AcVfpOnd/D8MyFRUwEYOryX3LpVMMGqh1t9a9ryIyOYJlSxa4Uvccf089wOwYneo1vSJlBItLdGiTSg9p/SihwQRmi4n6VxSFLNtyhutCzUlEi8ajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYVECil/VtDnFXW3LsZanwRz83DVyZ9jtxa6/tmQWgM=;
 b=YI3RA+H22XwMv5Z0yAswTe9iW7ofOiBy04qtO1CBkVVyLJdSNyXRft1OVsGvAzH3M7L+l7p6P7Rk/3FXZJkbuxzIwpJW9xS+A7nb6mzOHd+yrV1CIKYmyfB+cy5vRVHkXptURmHDKZNuqTo1S/r+SivS27THxYfDAIPap3iuuCVNjEVZwst55Mr7qgqNYBLtFIMF+gjtY7wlzY9/QjX5t5d5PvegVK2Wen0qfbUzXtyrsvVggqte92WR005o876ze2R0UwtU69dyhXA4a+Td8jyXsUgaX+vSRFX2A4vIyMOrJydUSF8/ps5R80pZyBsjkwCHTeEb8zNoPwUsY34KgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYVECil/VtDnFXW3LsZanwRz83DVyZ9jtxa6/tmQWgM=;
 b=ONe8dwpH1mSnYWdQ39FcvwI6mm0lvc6hJxvKorkuZXd0Xblt6jaWX0V/EwD8AUZ3SLZfDbTGC3Bb0A37tCBc6DmFV3zwf2NH/xOcNkPgfPrFWn+1hO790vSkhaD9dv8eaY8SUk86flRObNoUTFe+jhnFJbErb1JhUO/IU1xRx/k7dHxyCaCQJbyS8IvoPSgndfkWdiA3duudhb+mCom7G9ao/C2+aLZ6UJuALfGNBK3ekAGXKowVyitEYLPd5nQ3/YAaZlrvaN6trX8bDlk1Y/6JHrV2tpUXYEYgLEhkwQaSg9tLMC8x0kCw3AqR/TALsC9rVE0LgFEDqOHJkIALBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Wed, 27 Aug
 2025 14:05:24 +0000
Received: from IA0PR12MB8376.namprd12.prod.outlook.com
 ([fe80::4c58:7502:cc8d:8c7e]) by IA0PR12MB8376.namprd12.prod.outlook.com
 ([fe80::4c58:7502:cc8d:8c7e%3]) with mapi id 15.20.9073.014; Wed, 27 Aug 2025
 14:05:24 +0000
Message-ID: <02673728-843b-4d60-8dda-46e9f0eaa1eb@nvidia.com>
Date: Wed, 27 Aug 2025 22:05:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] net/mlx5: add support for flows targeting
 multicast MAC addresses
To: Thomas Monjalon <thomas@monjalon.net>
Cc: matan@nvidia.com, viacheslavo@nvidia.com, orika@nvidia.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, stable@dpdk.org, dev@dpdk.org,
 rasland@nvidia.com
References: <20250825141322.974335-1-gavinl@nvidia.com>
 <20250825141322.974335-3-gavinl@nvidia.com> <3029429.o0KrE1Onz3@thomas>
Content-Language: en-US
From: "Minggang(Gavin) Li" <gavinl@nvidia.com>
In-Reply-To: <3029429.o0KrE1Onz3@thomas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To IA0PR12MB8376.namprd12.prod.outlook.com
 (2603:10b6:208:40b::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8376:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: 24794a43-8327-4d80-a1c0-08dde572c430
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0pBc1RQZXlXR3FEbmRQbDVKVG81L0VFdWhHakhWaUQ0a3RxVWNrMXRvVnRs?=
 =?utf-8?B?aFhoVHZicmRpVk9TQkF5VVdEdFB2cjhDaitRcGErWlhlQVJvTnRlN2p4VVlz?=
 =?utf-8?B?bWNJQUVRV1Q5b1ZsNHc2SFZHSFYrUlh6WVpkZEtXMWgxelUzRVFHSklHeXJa?=
 =?utf-8?B?cU9OcFErUllieDR4OGZvUk00VURJVS9EYmgxRmFyZE4vWFB0NkM3aSsrdUdR?=
 =?utf-8?B?NzgwN2RNeUQ5UThMMnU4NzI4RVdLSDdGbzgwVUs5aVJVLzhKWktVNnR5N3FX?=
 =?utf-8?B?UkxPaUJJSFlEaW9oRnFVOVEwNjZaK3lPVUhEZnZWckpVRThxeGE2a2xSTHZk?=
 =?utf-8?B?QjJ5N25lNzFpeVRCQmg1OWxORmZoMXdOZDhwc1JXY2FQWlA1UzNrcjFVMmlY?=
 =?utf-8?B?ZlFhNVdPV2RBc3VzTXpheC90aVUwM2k2ZS9CZGppWnVvMitUczdvSWtWbnR6?=
 =?utf-8?B?L2JGUk1idXhBR1doOEhvdXJlYjc3U1pqUGQxT25rT1FDZSswWFVQdjhZMW1O?=
 =?utf-8?B?WXpVWHphZDVLMG5WOWNFNEhSeWRRZy9RQXJocGIwMmJOb3BRSEZVOUtHbVlm?=
 =?utf-8?B?S3pTMldRMlczUmp3bkJoQWZBTkxXWWoyM1JqbWhpaE1xTklJMjd5dFc3ZWZv?=
 =?utf-8?B?Ni83Rmo3UC9aY1hOQlB1cDk4YmZxd1lZZExsQjNOQjRIY2RKdEFwWlVnMlJQ?=
 =?utf-8?B?d2JERlNvUHFBdUEyN2ZTRE9sZGxIUzNLRGhXcWYzaThYRm9iYUZOcVVhWG94?=
 =?utf-8?B?Y3lVWnEvbkJNSGxSNTBOL0VMSzgyUlZWdWxaSlZiWXpvanpuV28zU2xEQXhV?=
 =?utf-8?B?N3l2L2w3S0VETnVBakNqWVYvT3F1dlBFVnh3NWJpVnc0WVZFSmFqLzFsVzBL?=
 =?utf-8?B?YlhYblRiRk91ZTA5NmZQN0JyL3NCTUt6QWl0TjhTR1lxZGZNNEI5a3VYaVhZ?=
 =?utf-8?B?OG9FMXNBdG9wVUtKNWlnOXdyUG1FUm0weEpZeXY1Q0hNZjduaUJSWmFkS1Ra?=
 =?utf-8?B?R3FLRFlmaEJnQmoxdllhRGZFdTRMMHVBTkFSc1dXcEEzbjRQK2hCNmphbVBy?=
 =?utf-8?B?cFFUVWFKVURVRDFUblh0UFgzMG9zTUhORUNneEJ2T0IzM0EvMDRlVWs4OUlr?=
 =?utf-8?B?cUJHY29XL29GZzh5a2M2QU1PQlNwVTRJUVgyUVVhRnhuU3JUT3ZrYThoQ0lL?=
 =?utf-8?B?RU5kNjAyQ243cEFITE1POGJKeWJWMnAyc0Z0Z200RzB4cEhNbzNPMmpobktF?=
 =?utf-8?B?M3VkdSt0UXRiUk5SRjFvb0l2L0V4SzZtaFpzVWxwa25INE9NQ2xIYnVzMjhQ?=
 =?utf-8?B?aWRzU09XeHpLdU05TWZFaXJROUhlamNCd21VaWlONGh1dXR4aHdaU0FWUzhG?=
 =?utf-8?B?UmErNHloTjRDSFFRcncyWEtDaFNheEwvWG9sUDU2SnN4ZWpvWjFrdUI2djVm?=
 =?utf-8?B?aFp3aUF6MStHOWliNnVpUkVkRUNxN0RpWVUzaDgrYjVvb0xEcjNCK1JNaTZr?=
 =?utf-8?B?cG9iQ2haVkJBVnVvdlEzdE0rQ1JxNkNPbnMzcmdQQXRmL3EvY3FlTG9IWW5m?=
 =?utf-8?B?c3FuNGUvNWcrZkhnbVNDN3FZdEFxUzNkVTZzeDF3UkIzWlUydHRhL2R1S0Nk?=
 =?utf-8?B?TjFETlZvbzk2NklvSkJ6R2lrbFBTL0xVZy8rSUtBMHhGOHNlTGNjalR0NzJ3?=
 =?utf-8?B?bUpVazlYY0NmakV4UFpyVkpjeHgvY3FjNG9ScFdySVVkeURkdUozdWg3K2Zt?=
 =?utf-8?B?eEVQTDFpWUo0dGQ2MFdybEhjRFVGT2RnOXRyZXRnWXRZTlhvQ2ZxWllrQWNl?=
 =?utf-8?B?UGpjZnpGOTZTeERsSE5iY2VwQUZjMmxJbCtGZklRYmFrSjNwcFpMS0dTY1F4?=
 =?utf-8?B?aVBYZWloQUNtbnhUdXk5Zm1JOU9PWnhPQndjUE9TQW5Od1gxdkxUKzV5SzN2?=
 =?utf-8?Q?rGBrQbwllPQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8376.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjUrN2h4UExaRFNxRnJhK1ZTVzhId0hsSk1TbnByb0tnaTRwdTN0aE9pMW1w?=
 =?utf-8?B?aWJkM2VXcFFFNXdUUmhTWUtaMmhkSHZ0UEl6MEZVbzhpbGxqZFl6WFRoeWpE?=
 =?utf-8?B?Q0lBVng5QjZLYlJRMWN0dnNQdm1TS2toZmsvQUJheTV2M0xmZzRGYUpTWFps?=
 =?utf-8?B?SlowQ3JBWmVyUDMyaWhZNEp3NE9DUWRFa0Z1M1dlM2xGT2NPRWExUmJYeXZv?=
 =?utf-8?B?NWIxNDM3dE1SV0RPa3hUYmI4dE1MejNHS3RrQWN2enVWekN0bHBsdkpiY1JZ?=
 =?utf-8?B?dlR6K250UEl2ekU4RzB3TkhFdkVkRmRnbktvSE5TT2lpblVjT0J1MUhQNEZq?=
 =?utf-8?B?bGt6eXpmZVhUaDQ3RCtCTExEdXorMy9JbVFSRW1pb1gvOGJ4VGQrVzRHN3pi?=
 =?utf-8?B?SS9zd0FtN0NTb2tFK1RFZWVZS1QwM040QVRHTm1lYk1SS3NJZ0tCTFJWb3ZD?=
 =?utf-8?B?ajViZWFEL25zVEh0MlJldzdXYmt5aG96aFBMZGhRMWgya0YwVFYxSEVwUUhh?=
 =?utf-8?B?TWMwQ1c5S3pUemUvZktkT3JQSjZuTnlCbW9GSGFTaThoVlZIUjNUYnpaSnlG?=
 =?utf-8?B?dmc1UjAyWjk3Qi9kRTBLbkNBYkxYbkZrQXc3eEhwcHlCazN2TmFvaGhHa3pH?=
 =?utf-8?B?R1EzQkp6d3RLU213M1JpUUZZSndURUZ4UlNVUDJtTmFGbFVJZlJ1N1pMcnU2?=
 =?utf-8?B?Z1hDNCtiVDNvbktqZzczTWZHcmpicDZiM1dLVVp4UWhQbEJoWWFoeFQ3cEZ4?=
 =?utf-8?B?ZkJmaGNCTVltMnJIeWNNZGhyVTZBN01QeWFZMVNZOTdOUXdGRm4xRmdicDE1?=
 =?utf-8?B?THlPcTU4M0RMall1WjR3VVRNUWtFSy9SaWx6WStYM2VEbWtEOWVwWnNZV2Qz?=
 =?utf-8?B?ZFFwbDlpaDZkYnFZWWxlMnZEdGNlS2ppYXA5Q3Y4bVdweUN4aEpqRXR2b2RJ?=
 =?utf-8?B?d0gyNW9FRU4vdW9vbDRRMEJ2Q2FBZmZSTlZPd2tvT3JRYjNnK1VmVWRvaVoz?=
 =?utf-8?B?RjErVWR6N3dodS81Ly94MWxxb2Jrd0RGSXZEVFZiNVVOd1YrUlNIL1hlTTk1?=
 =?utf-8?B?ZVpXWnZsd0dCQXFlVEZRTU1KRmJZZDVkM1JCalYrY0x4aTEyZGZKR2FQa2dY?=
 =?utf-8?B?WmVpYko3anIrR3lURVVETUl1Q3Z0V2dNQWF5WXlFWnNPbGFidlI0THVqZTEx?=
 =?utf-8?B?U2Zwa1VXSVBpbElUTkNkVFU0ZXBDNkNqUnVxN1JvTk1ZQm0vMW52WGlOckhG?=
 =?utf-8?B?OGtvaWUrMDBVVjdoMnA4bHRUa2g2SzNIZ1lxUEs3L09EckRFak5QOU94YWph?=
 =?utf-8?B?OEpKK05UKzJVK1ZMN2plQjd4YXB0cUlnL0tsZy9jOTdNelFpT20zSEd2LzZV?=
 =?utf-8?B?Q3JRQmJ4TjhxOTVaQktGaVk4MnpBTFpaalY3Z2hyanR3a0JvcnlqZlpieFRv?=
 =?utf-8?B?WThod0hkTU05VGRKOTR0VGNpWEM2UzluSmZVODZMMGhjMGY1NGdYQ0tTTEV2?=
 =?utf-8?B?akZTdVJjZ3ZWUHI3bXVyUGlmMk95dExQcmsyWE92aTJTcWVWRzlNODlRcmZ1?=
 =?utf-8?B?dVB1aU9kQnlaYzZ4cFFGTmhhZHRoWkVJMlc2TnhWaDh4RnlxUXJLa1diQWov?=
 =?utf-8?B?aTNYcXFYa2dhQ0xaMWFkNnJGMnRXc0dDRlE4dDFJK2k4TlFqazFUbUdXUldZ?=
 =?utf-8?B?cGs2eGladFQzNjR3cmoxMUY1cWtMNENkOWs0aHVuU2JRUyt6TmtaelFrYStI?=
 =?utf-8?B?WjliSEVGb216OS84YlRWc2g3bVhZa0pNU1orTS9HZEJ0WnFuSXk5QWQ5MlI4?=
 =?utf-8?B?ME1SY2ZMeGpTOFhtL01OQzRrTy8vZ2ExWDFJNkp2eGdUSzRrelUrVFVpOG14?=
 =?utf-8?B?L1Rmc0hobE9HRk95QUZYSlZyRk9MK0tpemxnTk5RM2J6dWpXS082d0U3VlZN?=
 =?utf-8?B?cEcxZXdZRmw4dnc2RFFlc3BHaUo3a0hsNElSSnpsY080T2J5dXU5cDd2WTZX?=
 =?utf-8?B?Z0ZtemU1aGpOS3dpTGxmTGUwdnlVd1dSWmpMZTBpbysvWkhVZndReXl1UUR6?=
 =?utf-8?B?UFQ2bzhkOWtmcjBGODRMVjBBLys2YTJRSy9hUk8ySGJCNTIxZEhITXNKTFcz?=
 =?utf-8?Q?4stx3BioXsoypqilNaH/bd/v8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24794a43-8327-4d80-a1c0-08dde572c430
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8376.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 14:05:24.0941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nhaQUlpqwOYgfmKEhoGrnCZsi1gt6efcRrHf1V0SEl2U8dLbu/Si6Mq+XTkQuaa2UFADDLlVCZi5hd0eY6TDxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374
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


On 8/25/2025 10:52 PM, Thomas Monjalon wrote:
> 25/08/2025 16:13, Gavin Li:
>> Rules for multicast MAC addresses are intended to filter multicast traffic
>> and are managed through multicast MAC add/remove APIs.
> You should name the functions to be explicit.
> Also it is not only managed via DPDK API,
> as you say below we also retrieve kernel addresses.
ACK
>
>> In mlx5_dev_spawn
>> function, devices (PF, VFs, and SFs) retrieve the netdev-configured MAC
>> addresses via netlink and store them in the PMD device data, which
>> includes multicast MAC addresses.
>>
>> Previously, flows for multicast MAC addresses were incorrectly disabled,
>> causing the multicast MAC add API to stop working.
> To be clear, it was blocking addresses added in DPDK,
> not ones created in kernel, right?
It was blocking all multicast mac address including those added in DPDK 
and ones created in kernel.
>
>> As a result, multicast
>> traffic directed to those multicast MAC addresses was not received.
>>
>> To resolve this and update the multicast MAC address rules, create them
>> within mlx5_traffic_enable.
> Actually you allow default rules for multicast addresses to be created.
>
>> -		if (!memcmp(mac, &cmp, sizeof(*mac)) || rte_is_multicast_ether_addr(mac))
>> +		/* Add flows for unicast and multicast mac addresses added by API. */
>> +		if (!memcmp(mac, &cmp, sizeof(*mac)) ||
>> +		    !BITFIELD_ISSET(priv->mac_own, i) ||
>> +		    (dev->data->all_multicast && rte_is_multicast_ether_addr(mac)))
>>   			continue;
> PS: you forgot to use --in-reply-to to keep all versions in the same mail thread.
Sorry for the misleading. Will add it in next version.
>
>
