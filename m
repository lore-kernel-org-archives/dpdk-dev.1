Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384AECA0EDC
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 01:55:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13A1640273;
	Fri, 15 Aug 2025 03:55:23 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
 by mails.dpdk.org (Postfix) with ESMTP id B73554026C;
 Fri, 15 Aug 2025 03:55:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2jFbrRUo7TAHXk8VPMr016C4FKo12Hpp5tEaNshBoU878+VVUYQ6TI4MI9Ksf3Ig6GApCVKU2Sd3s+ShMvR1BlUbpFjXl0mF4PIF0YjPsQapkitakeRWXUvItYpQZdQrk1puu/R0+kuHBXQdScNKJpoumgRx2u3v297cvhNQkFiJ/fvFvuXSfNIIL9RSA9dz0gwQVNwPu9WwIzihAuk8so6n5LHmE2VXurOQjhVD/fbaaVhapQqC8OTFPXuz8PdIRqwl65lm+8f3+CCg1UTaCZrUJ/fxQiRQbm1WJO54Jtscqs3Wicebd4A2uJSGqScLEl1kGf35NHuWvLiApnHtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAYkgiZmvTTQhVVgvt1162L9Owumxwwq4wfoKwW4t0Q=;
 b=OsWQo3OVQriDUUR9NAsWp8bjRyG0ntH+U4KgFGfU5jZ5X7/GRoNciACLwUamx19wG82F2UiNa6oPJehHGjQo3QC4Za5ANAkpEZsHc3uGDaVCD/TBFnDoNiYzfbWqXDK5p3lM0tGWTBgw1dkgIhx7qn9M+tgnyfiDRdMfNycqu8S+rNSEA8pN2z6wjYJrbz3aKpbXnin9Tp/sOMtlfcwmXG+/DIL4OAnKcTGRpAp/i+Nd8/8n0kd7XICG0e4DHwY4S7toW6vBtvjURMIG3nrWpJSymibaF1rI41q4pmQoqS/ThjKUDqM2EQCytd8Te3mcthZ8iWa9GJCIRsWWX0hAwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAYkgiZmvTTQhVVgvt1162L9Owumxwwq4wfoKwW4t0Q=;
 b=UoVkJ3GYaaMwBa/J/LlJUihtUY7Mi/EQ58akXLEwEds6YuuVpt4BqREwEGEJktBYda33O7Kb/IlVXETfbphgyCddnCkxbJigH8qEWSeq821mz79aE5uXkObyFZzp8USR/xRA5VzAf3xfYw0ZDazPK0UqX1JQZwb92PATE4PKuS4QdgLz9s72ywIDnY4ZnedZh+zCeO2hhPGgqa+oe2kAQlm1JsVbWV9XQekG0pQkD+GySSiZnaf68bY2RAdElDlr0SWzX6dYH1jpTt8BzUzpmHvEXIhpp5kbb3NAKkbfmXNE64sdfNBfttlvsN3odkSwrF7kd7sP9sHrzfmA5A5D6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 by DM3PR12MB9349.namprd12.prod.outlook.com (2603:10b6:0:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Fri, 15 Aug
 2025 01:55:19 +0000
Received: from IA0PR12MB8376.namprd12.prod.outlook.com
 ([fe80::4c58:7502:cc8d:8c7e]) by IA0PR12MB8376.namprd12.prod.outlook.com
 ([fe80::4c58:7502:cc8d:8c7e%3]) with mapi id 15.20.9031.012; Fri, 15 Aug 2025
 01:55:19 +0000
Content-Type: multipart/alternative;
 boundary="------------YK0wQLzqAcbic5Lk7Ue63Q0l"
Message-ID: <82b383fa-80bb-47a4-8a58-23b0573db3b4@nvidia.com>
Date: Fri, 15 Aug 2025 09:55:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] net/mlx5: add support for flows targeting multicast
 MAC addresses
To: Thomas Monjalon <thomas@monjalon.net>
Cc: matan@nvidia.com, viacheslavo@nvidia.com, orika@nvidia.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, dev@dpdk.org, rasland@nvidia.com,
 stable@dpdk.org
References: <20250814100815.801132-1-gavinl@nvidia.com>
 <3720215.hdfAi7Kttb@thomas>
Content-Language: en-US
From: "Minggang(Gavin) Li" <gavinl@nvidia.com>
In-Reply-To: <3720215.hdfAi7Kttb@thomas>
X-ClientProxiedBy: TP0P295CA0014.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::11) To IA0PR12MB8376.namprd12.prod.outlook.com
 (2603:10b6:208:40b::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8376:EE_|DM3PR12MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: 9446fa61-5696-45e7-4ea8-08dddb9ec980
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHdHZGxjdGFCTlRFM3kvcFhwOW5EbWxhRko0U1cyV2JDeU1YSUJVM0U1TGkv?=
 =?utf-8?B?WFlrc0tLamQ1RlZSQlM4RHJBSFd4c1VrblZxRjFmWnRIZXRJbkQ4MnYrWSsz?=
 =?utf-8?B?SnBPYVd1WEs0NkFGZ3NTWXVObTREbkVNb3RDMzRlQWtPaUplRlNIWUY4Ti9D?=
 =?utf-8?B?VHg3WUROeDBkVFdSSi9OSVduUTJUR0U3RU5JWklEam9ONjNFTVlNbTF4eXN2?=
 =?utf-8?B?Unk1TC9YdVc3cU05d016bVkxRGJ5UFlVSUE5SGdzQ3RnQmQ1MDg1V0N5STVI?=
 =?utf-8?B?MGJCRjJ2WHF3UDZZdnNhZ2xDZzFtUStHbFRGcW50RzhkS1VQOG1obTV2MEZZ?=
 =?utf-8?B?OXRDQXRpNG4wcVVrU3FkZjVwOHhnVitCV3gwenRFN0syRVpENzZVWFdEeXNW?=
 =?utf-8?B?Q01yM3o1R3JROUZkZGFadGdYSThQY2VJMjRLc3Z4L3JMdUhlREJnUDNVK0NI?=
 =?utf-8?B?OUVwRlA0akxmbUhvNmZ3c1crUWhvemR3d2Y4aTNONUhjeDIwclQzSWpzcDVs?=
 =?utf-8?B?STVXTmRFY1V2eXhIZ0lVMjRSTHJXM1owbUQzQmpCWS9QeDBCOHlKeWJNVnBK?=
 =?utf-8?B?QVZhWUMycEJjOGxhSnlVcnNlcHFMZ3ZOVmdxdW1wdDdWYTN2UmRGZFlObGJx?=
 =?utf-8?B?cmNKMXpEcCtTMFoxeEViM2hzR1hqVVpSSHhwS2VUQmZUYktJZ3J6d0dMQ2p1?=
 =?utf-8?B?TXhPbXZZbWZCU3FUb09FK1kwdDFhMjFZRWc1M1BQci94NmlHSnlENkE0aEFD?=
 =?utf-8?B?aWk4NWZ5MjFQNVhaUzROQjhEeG1vai8xQndMWXRYbEozb3grKzFQUTRDVWJj?=
 =?utf-8?B?ci9jVFViZjBVQTFueHJkRHNjd0FlTmJlMmpmZEYzcmFaZ1VGN2UwallaV0J0?=
 =?utf-8?B?VFkyUWJiUko5QTUzczVuVkttQ1BwalMyNWVJbDIxenlrMXZ3QzZQNThFQ3ZP?=
 =?utf-8?B?b29UczJMOTRwa2FzdW1ZS05sZWRYNVhUTll2UnR6SS93MzVLQzQ5WlRuN3BL?=
 =?utf-8?B?T2pIbXhEbXZteVZoeFJqWmN2V1V2MzVkWm1qWHFWV0hkUFdOc1NaZ2JRcCs1?=
 =?utf-8?B?MGFyR3Q4QlBKUHdaYXdvUjkrckN3Tm5rMWxsVXpYYnh5RzZ6Q1hLK29jT1dH?=
 =?utf-8?B?RTNZcjhqYlZGbmRQek9lTHlKSys3UWJiT2MzTC9kbDc2MmlsanNtMlJmd0tE?=
 =?utf-8?B?TXNvZ3I4R1lMREtDRG9WZDV0T3Z5elRQeHowZEhkVGhwczkzRDVYa0lsakZ1?=
 =?utf-8?B?c0Z3VHg0OTBxU2czK0xEVmppMWo2c241TDZqNzV2Q1p5Z1Bodmc5a04wa3VS?=
 =?utf-8?B?M0NMUGhVZGNNUlZ6QURIZlpRZXIyaGI2NFY4NEJwaVhsUHZzUkNtSkpSVG5p?=
 =?utf-8?B?aHJTcFdqa2YwWTdHVFNiYW1BM21EV3VIQmY4V2djWnNBV0loMVg4RDBudkRD?=
 =?utf-8?B?S3JLQXEyYjhWaURuQ0JSc05ON0J4dmlyNTdkUysxUEY1MlNTV043VmorZnJS?=
 =?utf-8?B?K29WY1NGVjFJOHdhNkovQTR2R1J0ejA2ZEUrbUtDUXFtWVkxNmUwTlp4ZFFi?=
 =?utf-8?B?bXdNdy92VUJ2aG9maWdqWkR0U05ISFhGa2VDSUVLaWUrR1dmZ3BEUjBlSDd2?=
 =?utf-8?B?U3pFTlg3RWRkenZFRjRrRVBpeUpIdlVUZzQ3TWQvMkF4aVNIazFzS1ZHQ1Jj?=
 =?utf-8?B?dTVrTm1QT21hY1NJcHNiSEM0YzBZQlhTUTQrdGpzMG5oQ0kwWXpWd1k4YlJ3?=
 =?utf-8?B?ZXFBb2xnUnRMU1N1S2o4ZnpkUEQvdTd6MXU2QXFzMHlTMFBYS3UraStiZHpj?=
 =?utf-8?B?ckRLblFyNHkwSEVQVDVsMmx2dnN0eVFrM1VzZ2RTQVB0RU1LcUJKWTJjU2xT?=
 =?utf-8?B?TmIycUNNM0REWXVYeE1XNy9qaGRWWEllbVRra0ZLK1h0ZE5BSDhWa2dlSjh3?=
 =?utf-8?Q?wXNYYXc92c4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8376.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlpsR0NiQzhkY2FPdmUzellKN0V5dVdUZ2s1S2l6R2NERmRyUWlGRWJDcVVL?=
 =?utf-8?B?YXJyN0lhaE45b0RLTyt0TUwzNEU5WU5aOVF0ZEFHUEw0TW5hSDc4R080WER3?=
 =?utf-8?B?STU0YjlxUGJEbXBISjUwMU5ScTNRRi81eGVra2VSWVZKZ3ZpMFEyRzRjb053?=
 =?utf-8?B?VFZ0UG9jTVlLWnhMWVNaVkNCbXo3ZWsxZGF6UkdvUEZNVmdWbmJBdXIxZnM2?=
 =?utf-8?B?bW5yNW1YNzJQWHpGZ1pHWFdpN2x6UlM5UVF0MEhFR09PNkFJVk5PNXBnMkpq?=
 =?utf-8?B?aDVjVVczUU1YTWJTTnlpU09kMkxvSVZ1NklKbE1aSStyN1U4Zmp0Z1MwdW44?=
 =?utf-8?B?V3pCaEFpVFpENzlpdUs1QVp3R2MzUTFJa1ZMODMxVzlqdEtXVGNBQTBZb25u?=
 =?utf-8?B?YXh6TmNaaTVja2VtSkJhOEhJdTZYbSt2MUVsQitqeTl2NHdIQUxoRlE0Ri9C?=
 =?utf-8?B?Q1UvSUNmbjRYSWdXM2U4SFpKa25HWklNUFJWNUw1M3Bmd1M0OU1lbjdCaHhx?=
 =?utf-8?B?RUN5NnNQSC9nRThGMTN5TkFwdkpWcElPeXNvaCtHTCtqZVFqRGlDSzlVUmVO?=
 =?utf-8?B?ZGVTaWVjRDhwUlpSNnFQUjVkVEEvUjJ1ZVVXR3ArUU1mMHhaRTRrc2kzdldR?=
 =?utf-8?B?a0tmZDgrRDQ3Tjh1b3JDckpobXNRbjc2Ri9OQWNNcHJIVDQ0Q1pBT0VjYzZN?=
 =?utf-8?B?QXpCY01kd1BvM2prSWcvcFhHT2tueGlMTkQ4ZW1Rc2Vhc0RSWm9WY2hCOFl2?=
 =?utf-8?B?RGZNdU9SMDA5Z3VxazJaUnQrK2ltZWtXeTY1eCtwZ2Zwb1VQZUJHSENpNG9v?=
 =?utf-8?B?MGVTZTBtOEc2MDB6UFlsOFdkYU8yWDlzWWl6ZWRPdVVsbDNEd3FOWC9rdDAz?=
 =?utf-8?B?Yzc5NUZmM2NFYUtVSHRYOE1haTkyZzBIWVplOStkcndHS0w1MDhuaWhmNjEr?=
 =?utf-8?B?Z3pLL2dTRys2SnBiZm4wTmFEekNRblNvT2hJUDhxOHlJRHUyaXI1amI1QjFK?=
 =?utf-8?B?OG9OUENTR3BNTXVpUTlBSG5MUEJqMHJxRW1vZGhWbnhBY1NRcXpRVFhLbzdz?=
 =?utf-8?B?YVBEaHRSQW1QYXRtTGNYUzNGVDhtWUF2dzRDc1FSMUkvL2xkN1ZkNCtBbnVh?=
 =?utf-8?B?OUd4dWtFOXV4T2RUSzZtNzBoRTAyUHVOanpEbFhiMnVaYmZYa2JmU0dDTFlQ?=
 =?utf-8?B?RDVDUDArMkNveW5mYUhOV3d6MmYzMFBoQlRWRHgrbDYwMEhNSEpCOFFHbTQx?=
 =?utf-8?B?b3MxRDhyUENpWGZZdTU2VnFJa0xwZEVsd2NLaThYdjVBQW9oaFZnV3c2UmRq?=
 =?utf-8?B?OEovQnJXS3ZJaVM3V0o3TVJKTS90YURXTFRRSmhHd24ySnZFMXpvVW9pNjlG?=
 =?utf-8?B?WXdiMjNzNUNyZFRBb0dmY2Yyc3ZudnVjYmFKQlEzb2ZYUTNLSHU5VmhJZk0y?=
 =?utf-8?B?ZllyRERSbFc2cS92Zzk5aVFhQjdocmRvb3hQQkpTMGw2VFdMNHhPVDAydWw4?=
 =?utf-8?B?V2NHSjE4R285WGFPZVY1TFFZdTRVUXVsWmQrRGlySVlqMVpQaHloeVZDVmp6?=
 =?utf-8?B?dmF6c095SDZaMUVkV1lNZFIxZEpOakxEN2R2MjlCS3hkb1FuUkd1dUNvSHhJ?=
 =?utf-8?B?cWVUcEFLKzhFdmI5MkYzem5uSG9Lc2hPYmN3cWtDaWxLYWgyWVBBRzRXSGdv?=
 =?utf-8?B?M2tibFpId1pRTnB5UmlUd0xCK1NXamh4YmZPTzdrVytPYVpLVTArc240N0pl?=
 =?utf-8?B?NitFYkhkZ1J2MDVLRTdTcnBKZ2tvRFpMUFVOdjZ3ZWN3QjlvdHJDVE90SFNN?=
 =?utf-8?B?QUtreGFkVjloaTkwaU0ycFdXLy9kVjE2OHFQZWZsNWZzanJBbmI1UEN2OUZV?=
 =?utf-8?B?eFlyNDZoZ0JyZzJ0L0dxbW5NSml4T0xjeEd2MEhnVWZ6UVNZQTZaNzhsa05G?=
 =?utf-8?B?ZDhuSS94cGYxa3ZrTFo3KzlBWDh1bVdRSTJJRk43Kzk4b1paelJxVjhBTkVv?=
 =?utf-8?B?V05DYmtQcGJrbWV3SjFHQ0wzbGFVYkxLdmJsNGZQeEJMZmpxZG9UeHI3c25P?=
 =?utf-8?B?RmVXejRac1BoYzFYVFVRT2c2bGtaS09LclpqRGtwZ3l0ek15WXE4dzRNcEVI?=
 =?utf-8?Q?9kGXxHa2urCWZDBsqRq5CvGwb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9446fa61-5696-45e7-4ea8-08dddb9ec980
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8376.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 01:55:19.1820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+csifzlJlQDgdlZjkLpUzJxzKHCwYHo1mMqUss8KriryYSRfB16GX0hAXOVGeyePcQA9hz44BTy/rbIECOzsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9349
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

--------------YK0wQLzqAcbic5Lk7Ue63Q0l
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/14/2025 10:05 PM, Thomas Monjalon wrote:
> 14/08/2025 12:08, Gavin Li:
>> Rules for multicast MAC addresses are intended to filter multicast traffic
>> and are managed through multicast MAC add/remove APIs. In mlx5_dev_spawn
>> function, devices (PF, VFs, and SFs) retrieve the netdev-configured MAC
>> addresses via netlink and store them in the PMD device data, which
>> includes multicast MAC addresses.
>>
>> To update multicast MAC address rules, create them within
>> mlx5_traffic_enable.
> Sorry this is not clear.
> Please explain what was the previous behaviour with a past tense,
> and what is the new changed behaviour.
ACK
>>   	BITFIELD_DECLARE(mac_own, uint64_t, MLX5_MAX_MAC_ADDRESSES);
>> +	BITFIELD_DECLARE(mac_pmd, uint64_t, MLX5_MAX_MAC_ADDRESSES);
> Not sure about the naming.
> What is the difference between mac_own and mac_pmd?

mac_own serves as a flag for MAC addresses, indicating that they were 
added for VF by pmd. This flag is useful for the flush API, which can 
clear flows associated with VF MAC addresses. Similarly, mac_pmd is used 
to show that a MAC address was added by pmd for PF, VF, and SFs. It 
helps differentiate MAC addresses that have been synchronized from the 
kernel driver.

>
--------------YK0wQLzqAcbic5Lk7Ue63Q0l
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 8/14/2025 10:05 PM, Thomas Monjalon
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:3720215.hdfAi7Kttb@thomas">
      <pre wrap="" class="moz-quote-pre">14/08/2025 12:08, Gavin Li:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Rules for multicast MAC addresses are intended to filter multicast traffic
and are managed through multicast MAC add/remove APIs. In mlx5_dev_spawn
function, devices (PF, VFs, and SFs) retrieve the netdev-configured MAC
addresses via netlink and store them in the PMD device data, which
includes multicast MAC addresses.

To update multicast MAC address rules, create them within
mlx5_traffic_enable.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Sorry this is not clear.
Please explain what was the previous behaviour with a past tense,
and what is the new changed behaviour.
</pre>
    </blockquote>
    ACK<br>
    <blockquote type="cite" cite="mid:3720215.hdfAi7Kttb@thomas">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 	BITFIELD_DECLARE(mac_own, uint64_t, MLX5_MAX_MAC_ADDRESSES);
+	BITFIELD_DECLARE(mac_pmd, uint64_t, MLX5_MAX_MAC_ADDRESSES);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Not sure about the naming.
What is the difference between mac_own and mac_pmd?
</pre>
    </blockquote>
    <pre wrap="" class="moz-quote-pre"><span style="color: rgb(36, 36, 36); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, system-ui, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">mac_own serves as a flag for MAC addresses, indicating that they were added for VF by pmd. 
This flag is useful for the flush API, which can clear flows associated with VF MAC addresses. 
Similarly, mac_pmd is used to show that a MAC address was added by pmd for PF, VF, and SFs.
It helps differentiate MAC addresses that have been synchronized from the kernel driver.</span></pre>
    <blockquote type="cite" cite="mid:3720215.hdfAi7Kttb@thomas">
      <pre wrap="" class="moz-quote-pre">

</pre>
    </blockquote>
  </body>
</html>

--------------YK0wQLzqAcbic5Lk7Ue63Q0l--
