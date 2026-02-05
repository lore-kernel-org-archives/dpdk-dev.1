Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0751DECD980
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 16:01:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BF4E410DC;
	Thu,  5 Feb 2026 17:01:40 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010032.outbound.protection.outlook.com
 [40.93.198.32]) by mails.dpdk.org (Postfix) with ESMTP id 8D2AC410D5;
 Thu,  5 Feb 2026 17:01:38 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFlBDZih7/uWao2bT62md3XgGW0ErJC5MHF1rzlOdhQ4J0l4pS1+H1qYeaT2C6VlodxTuji9YFFITDhulYUuD5JGhmd9rtjG0LIA/E1YqJFNIX8o+I806CApBSHDy35coSHGSt0mlFTc1i06KEbnOr9w4d8R2vdpNtGBQZUmRH1PyTTaXwZ/AUP9KIHQeK0lmFxpWCwYR/nFE0MmU6e9ozy07qS3qOrLmq6R/CDUtAox3PLNtFSdEEeGZDqU6pU5sZTDLgeBNVnn3/i/HS9pGfAmUjJNce7QRnJOpHbDMHSbFrXF8g7KsSftn6xEWC3db2cTmW9GuRppmbikw4rwPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1Z6+hlV8VzsB9l35jIqYz/HY3nRicGmsAjprO5E270=;
 b=bcmv68UV+L9Bglly2LHLYxPYAgnQD8krBeAVRcBlJ/wKH3Q/hVClW2PuFzXBTBDB7anE442BmHniYTeyjdvc200IzDVlLchuFYlQWO632B0aN0g8flu19gD2kPmwBOnRlAhq24BJ1QkZr9gn/T8r5aDveBAwIbEWIlVWSw5jGICggzJnvI1B5u8A0m8rfCwYiGALs7z/a3CXIb7NfAyVMT8KgzKdirW2NMCTbb5v/FGXz/jvcTshU5gQ5RAA6NIRHWb40JELxbg6X63f7tTsYwmDfxOsG2At3H4TnAQgcMCu+ARt0QJtPp/sqJzJOhV788+6jCD5y6k08H5iCnThOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1Z6+hlV8VzsB9l35jIqYz/HY3nRicGmsAjprO5E270=;
 b=pIvzFAIRbjwKiY9f4Dr/ZCVLlrXByIlBYTLIaUdVEPwGNjMy6m0IQmoCpg9FUW98zSRAihaKe5VCH1ZLkKb1zuxDXW1XSrfUYM/6SZd1TMLLRbTFlk7MUopacCuOWck/SfNsOQ6BYmPYPOhxm1r0UDhkCZf0TEDyQ4jXIZrv7vWXgMlk3/hU8KM5JGlI8htOBJ2kwOka47k5GSsViN5metS/yHGXeKhzLb9N59RmXLlaS1cTuAlc5hO3tbPQfsP8jW++0uNRu24XY+0tCfUeyqtP0GqcPYNkiQejKuIXhfwnVDJK+x1+YqGITOe6K6qkhwDOzdO9emeEj44RSlqyMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by DS2PR12MB9566.namprd12.prod.outlook.com (2603:10b6:8:279::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Thu, 5 Feb
 2026 16:01:34 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 16:01:34 +0000
Message-ID: <1a5a2315-2c3d-4329-bc82-7faab1406af3@nvidia.com>
Date: Thu, 5 Feb 2026 18:01:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix HW flow counter query
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org, Xiaoyu Min <jackmin@nvidia.com>, stable@dpdk.org,
 Mohand Alrasheed <mrasheed@wirefilter.com>
References: <20260112172324.1523241-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260112172324.1523241-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::10) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|DS2PR12MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b1c9c50-dced-426a-ad3a-08de64cfd5a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1VJQUx5MWQvWDR4b0xZdWNtc3dJbDFHOVNRc2szclFaWmhiTWpkYUxlSjdR?=
 =?utf-8?B?ejZ5R1MzenFGR2UwUGlNdERRTVNVeC80OGVzNTZBaGhvYXVrQlcwVE9SeXl0?=
 =?utf-8?B?MnVRbWVvSVN3bW02dTh4bm8yeTZ5MzZhL04xOTdLZ0RnRHFGejJBNkg1M3d2?=
 =?utf-8?B?OGlEcE45TzhJbjBtRS9ySUtXYk01ODhwV1RzN0RvS3VrQjliMkhuRVFtcWFM?=
 =?utf-8?B?eFpIZ3FOeDlLajRWcTJWdEVqbUNkcGhwYUtiWUVhVlVHSUNvRTR2d052T1dO?=
 =?utf-8?B?dFJJL2dDZlFhWEJyaHFoN08raHRRNHJiT2ExWTVvMEc5bjA0UExjMUhiY0xM?=
 =?utf-8?B?dTA0ZlVMbzZtM3ZjUmV5YkQxQVVHZEt4VUFFd1RmSFhBYnMrN3cxZVR5TytO?=
 =?utf-8?B?Tm9hNkNBV3ZLYnFBMWJ4T0kxSFhNSGVjQ1RHZWxxRXh2WHJHQmJMR0EzS2U3?=
 =?utf-8?B?WXZveENMRW5nTXFSM3c5VWg5OXRsdGZMbXNpZWQ3OE1HdXB5WmtPc01LZjVw?=
 =?utf-8?B?MWpDZ3ZJcjlWQndKK0l3M3dFQ0o0aWljWnZOUXhDVHA3N3p6NXBNZWcxMXZk?=
 =?utf-8?B?cnh2TWJrNTZhZ2xVNHlOSTlmOHVZZWhTQlFuNVFQTnQydzVRU0dnR2xHMVEr?=
 =?utf-8?B?MkVoRHFIMG5qYko4RmphZXQrcUd5a01JZ0FIcVU0MU8yN3k1Rm4yeEVIRFNl?=
 =?utf-8?B?RlQ0RndXY09jRldzY1h1RnJaWVVCU1BRL0dXZ2JmVk40L1lWUlFFNTNDam5V?=
 =?utf-8?B?alhmQjZhd3IxbThsK0xqMkNHY0ZNbkFrRzRCKzhJbVFiemxUOEJXRFVCdmVO?=
 =?utf-8?B?OTRrU2FZRW9BZ2k1MVN6YjNJaExIcXpKZHZBYlgrLzlLNFQ4WEt1UEFoN1Bn?=
 =?utf-8?B?eGtQci96T2RZWnJPUVhIRzl2VmFmdlVwUjhacHJOb0RidnNkNktCNE5sYWVw?=
 =?utf-8?B?Y1N3QVVVTEtBbzhHaHZEN1RVbllNVjl4R1lvdmN3NDQ0MnpHb1BnemJ4empj?=
 =?utf-8?B?c21vY0YvcklXZVc2VExIVWRmZG9WaW1KeVBuZEJYQ01OY1NqZ1IrLzRUWUhK?=
 =?utf-8?B?UGY2aUhZY1NMZVZlV0dRTWJVcXYxc0tCWGJkSmJNajhYOElQNmNnRU5XZFZY?=
 =?utf-8?B?YmtJZ1Z6SzNwY3ZmUDJrMWVPdXMwVzl3dENlN3k0K0l3M0ZJKzdDdTZvMnlt?=
 =?utf-8?B?aWNmRWxXRzdNK204bXYxcDBsTnNDNHZTSTRJckxLazhFckcxRk9adXFSbjZL?=
 =?utf-8?B?QWdQVEVyT2h2dVNOQ1pmUWVqUTAxcG9DRUNqdTNBU2x4V3V3MHFURm50QkRk?=
 =?utf-8?B?aHVyNzdqOHBYZjhJVWFkV1VrWkk2SWovc1dxTloyMkpWMVEzRXlra2NxTHRB?=
 =?utf-8?B?U2hCc3BQQllCbnZBR1VubDhXNUhiUUxSRU52RHhyZnpTdDczaUV1dGNJVElz?=
 =?utf-8?B?cXIvbi9RZCtscW82V1V4U3pNeFJpTmNjZzhRRDkwWGlLaTk2Tks5V1BlUTQz?=
 =?utf-8?B?TUZvczNvNDFtTTdZZU5SdjJJVytQMzdkd2FuQnl1d3ZrbGR0TmRCRzZ3RGo4?=
 =?utf-8?B?dDdCRHVVQmh2UU5Td2ZaT3RWRXRDYWowQjV2ZDJlM0taOUdmc3BzTU9rRjdn?=
 =?utf-8?B?ZmxxUVJuV0tsVXRhc2d4aWxRZWYvckhpd0JnbWlVenlPWWYyZDR5UzA2Yk5S?=
 =?utf-8?B?UDF3VTU2dVhHWmNxYTA1YWZXUTBDOWFTQWlYMmVabFpqVTJEQnp5VFAweGdI?=
 =?utf-8?B?RDZqTUZKcGNsMEN1bW1iZ05WdXZ4aWF5cFVabVlTbDBUZjVPOElnRmpVTDZo?=
 =?utf-8?B?ZDl4VEFTNWlTZnVqSTZhN0dSUWttMW5IMEpZSmFJUy9hZFltTlV6aUwxNkJy?=
 =?utf-8?B?UEpBODZFSXdNaENuSWNldklGUWw0QUE3L2w3QXRsSHN1dkp2WGR5MFZUcWNw?=
 =?utf-8?B?NkY1OXNMbmpMWW5SalBhRUwvL2w5a3hzOEhKSTNuY1BPQksyTGlSa1pueW5V?=
 =?utf-8?B?d3ZLVGIyUTZMZWIzOGlvczRFbVBjVmpTeGNDUTV5bnVJaWIwTmtqRGVNTFBX?=
 =?utf-8?B?WnFnYTJRcGdkOUlwcE5HWnFnSElNdVBMcCsxaUZvYTkxK0N3cm9DM0Rwc0hq?=
 =?utf-8?Q?aMZg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzF5SDVpU0xpaHUzekVKZG04N25OcXBKa0xBb0ZEZHBraE95dVJhOWg1T3Na?=
 =?utf-8?B?Qzh6cFBoUFRSNVkrUjhhS1RyZk9acUpkeVJBQjI5YmZObm5TZERoK0VrbERo?=
 =?utf-8?B?Ymx5RnZueEJaRXMvVlVmcFlGR2tHVTE1d3M3eW55aFc5a1FjTUNrNzAwSFRv?=
 =?utf-8?B?a21YM2lESzA1NGY3R3EzQ2xJQnZmbTc1TEFaR3pGN3hLaHMrejBvNVVsTzBn?=
 =?utf-8?B?Z2xzeW5paWh4bkJjOTdmWi9iR0tYcW9OSnp0eHVvdnkxdHh6eFFLNXpYMFZZ?=
 =?utf-8?B?UjlMdE9zVEhod0pxYU94SVEyVHAwU0puWjExaTl1K0pibkl5RmZFMnJPV2xa?=
 =?utf-8?B?R2tBN1JoaDVCWlVEYVFNVGtSc21UNlFxMFlJSk1PbGRnZVpCWUtnYmEwc0li?=
 =?utf-8?B?aHdIWm5RSDc5Qm9RYjMrSlB5MWVtZUExSWZ4bDFZMFpCU20yVXRlRnlHclJC?=
 =?utf-8?B?dEk0b0xNS1A3YnJWMTZ0bzdnYlFVTXl3b21pN1RxUzhWeTNZV0lvL09FSEgy?=
 =?utf-8?B?QWNhUjIzSDlpRHEvdmRrVEl0Q3BKVzJoUG5RQkRHR1JHa3JBZ2NzOGZkREFJ?=
 =?utf-8?B?akFad2VKYXh5MFcvVVBmbFdieUZxNTdKc1NpOTJnUjI0TGczMEpCMERvZnlI?=
 =?utf-8?B?czg1eXVxbjJzemxLR1ZsVU1DRXdXdkpYaXNFWTR1SHA1b2N6dzRLUmdoWVVq?=
 =?utf-8?B?QnFPay85OFhXU3pKLytmL2dRTDNzK3RmdDhtMHkyL2Y3WENBN2ZWcUFNM3ZQ?=
 =?utf-8?B?R0FWZGJHS0xvWU10U3JoVXkvd3VVTWk3bmpFejlsUzhZbGJWN1ltMi9rT0Uw?=
 =?utf-8?B?M3RGaDFmYzFRTmZsaEdldUpjM3Z6OE9hdzBYRlJNQis0NStkTXRkanRwMSt0?=
 =?utf-8?B?WG5qL3hCZnc1WDQ3M3ZYNkdRb0RGMnczNlIrL3BmVVVKOU8yL2RxUlk3ZXVo?=
 =?utf-8?B?VkVVNkZMQ2ZMcXJEbTloV0gweVIrOWFVRDlCY1BMOTY5MVpQRXluVFNsZzk3?=
 =?utf-8?B?YlV4RUdCR0xyQzNTeU9YOG40cFN4TERTdzUxMDZUaWpjUDlWamtkampuVmFJ?=
 =?utf-8?B?OHNPOG16UzVPVlZpV2xlL3ZyVTI5N1FPb05qQ2pTdE81cGwyU0YzREFjaEZu?=
 =?utf-8?B?UDZUTzUyWnJpenMyN0RLTU4wNThGWFh6UiswVXlHOFlkTlFQaEQ3ZW9DMVZm?=
 =?utf-8?B?dkdacDByWk8rMSsrTFNRY0FweHJUellLSDUvOTJOaEwvc2JoR0JiekdFOEc3?=
 =?utf-8?B?V1h2dHdueFBHeFhjZmJCSFY4Tllzb1NOOWVKU0JmbytoMXAvWVFGaXpjYUFk?=
 =?utf-8?B?NzEwc3JsamFleVR3V0dkbWRyR1JnUm90TS9zK21OSlB1Vm5xMnA3MGl4Qnpw?=
 =?utf-8?B?U0xrRGthdmRpbk9tTWc0L2QwQzNrcDhsTUtqcGVabFMrQm5PMnFqeVowM0NV?=
 =?utf-8?B?UWZSWFdPU09oaDFMM1RSUkVRTWI5bzh3Skg4dDdDVDFmVEZ0dFlFMVdPNUM5?=
 =?utf-8?B?dFk3dlFBdUhXcktNQ1YyeDl6cndMaUdiU1lBa01KTUZYM05wazNEWUMyTlRw?=
 =?utf-8?B?N1N1U2JQa3FFN2xmdENUYjdPNTQ4S01aZHNQand4MWE2ZzdmMVhxV2Q2bGxL?=
 =?utf-8?B?SkFranlTT2ZoNENXT0kwVFVFeHo4OFJoRHl3MFhsK0Y1d1o3dkNuVW05Sjg5?=
 =?utf-8?B?WnVyZ2hhdUxVbWN0Tnl1aHhzakJCV2J6WWFPeGxISjFTYWd3Sm82SkxOajRV?=
 =?utf-8?B?K0FsL09qZjc5N2pOTzdwRnJLNE9QVGxpRktodHNoekdZOXB3N25kc29PcUtG?=
 =?utf-8?B?ejNCK1F4Q29NU2NZNmg3bnJ3a0VxdHdSU2o3alhReUJjSkhXYkpKOGxBRDFF?=
 =?utf-8?B?dVRrMWw3V0F6T3JaNFl6eTJsMmlWbzh6Y0ozSFNVYlFrc2hnNUhjSWdwWXQ2?=
 =?utf-8?B?QnlBSHJFMDMxQ21TalRwbXl0VkhGdmhxenhLSXVKb3krQ01WUFVoYzllb2lL?=
 =?utf-8?B?MjVtc015YmxtSmFxQUluZzYvSEZiOXNTR3QzeUJON01GK2I5WSsvcXB6NW1R?=
 =?utf-8?B?emNZa1d3eElKVkVwVFRaNFh6Qkl4eVlha2ZOSzBacFVHTDhLR0FZSGMvb0dP?=
 =?utf-8?B?ZFlWdXJ0UDlmei9qWTRPMWRaOGJVNDBMOTN3QjlsVERtb0lreEdEanZlUk9I?=
 =?utf-8?B?em9WTVE0d2JQU1htQVdkNXlnd044eFkwaUgwbi8wMnVaM2tzUURsZ3VaSUR3?=
 =?utf-8?B?TnEwSE5YT0dxb2VtMDBUSlhhRkhVQUN1R0pCanFBZzAyUUFUQ2VPYXZVTjBy?=
 =?utf-8?B?NFBjSHdOeGo4R2pkcmlBQmJlblI5ZW1DQ2VaclZFK1dCRlhsdktEdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1c9c50-dced-426a-ad3a-08de64cfd5a9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 16:01:34.1035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUFnX4ONickmhVVNvmTURywnH9zKRYG8WZL16mYJslEoDNMAlKasQ9o6phhohhzEehw8UCtewaGliYzX1sXZsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9566
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


On 12/01/2026 7:23 PM, Dariusz Sosnowski wrote:
> From: Xiaoyu Min <jackmin@nvidia.com>
> 
> There are a couple of issues in the logic used by
> counter service thread to refresh flow counter values
> in HW Steering mode:
> 
> 1. Flow counter offset in bulk is not taken into account
>     correctly during query.
> 2. Number of WQEs used up during query is not tracked correctly.
> 
> Regarding the 1st issue, HW flow counters are queried by posting WQEs.
> Each WQE queries 4 flow counters at once.
> Flow counters are addressed by base ID (ASO object ID)
> and offset (divided by 4).
> During periodic counter refresh, mlx5 PMD fills whole queue with WQEs
> and waits for query completion. This is repeated until all known
> counters are refreshed.
> 
> The issue is that, between different iterations the base offset was not
> adjusted. This lead to the same 64k counters (max achievable through
> single queue) were being queried. Any flow counters above that limit
> would get incorrect values.
> This patch addresses that by adding proper offset calculation during
> query loop.
> 
> Regarding the 2nd issue, tracking of how many counters were really
> queried during single loop was incorrect.
> In case when there weren't enough free WQEs in the queue,
> fewer counters were queried than expected.
> This mismatch was not taken into account, which in the resulted in some
> counters not being queried.
> This patch addresses that by adding proper reporting of the number
> of queried counters to mlx5_aso_cnt_sq_enqueue_burst().
> 
> Fixes: 4d368e1da3a4 ("net/mlx5: support flow counter action for HWS")
> Cc: stable@dpdk.org
> 
> Reported-by: Mohand Alrasheed <mrasheed@wirefilter.com>
> Signed-off-by: Xiaoyu Min <jackmin@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

