Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF40C19776
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 05:23:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2E7740E0A;
	Fri, 28 Feb 2025 06:23:42 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11012022.outbound.protection.outlook.com [52.101.66.22])
 by mails.dpdk.org (Postfix) with ESMTP id EA4A24028C
 for <dev@dpdk.org>; Fri, 28 Feb 2025 06:23:40 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Au8dyJF4G6zEAfSN2hVeNHBVekoU8bPhlkRYPIPLgeTHXObFMHoAgoq7SDv1h2k7CAWRjDgKXg/jf6X3E17MlkeMbb2kUTv+jVL8oCYRj25JatYhDCDxIHJ9FMwc4+nHTvzT+b18AFCsgQQMqXDDJux9vVUTQPUZ+3kNei7PglTYmx16F8u6+f2g8Ze8MHPi428mdFvlNRDfVOUmLZwlLBJpW8ZEBaFgQPrYSBb1PPuWz0QA0aZYFW6WX+1IIV0m+BE5IqYEFbyilmb6AEmhwIUf8T9Nv9Bk1lptzKh3TBdpIxlGUEHkHZdr1XGVc1aB1eUzkh1pR4dhVCtwMbSp3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LW9c6hA1ufQaGwa/wBqGHTRiU9e0KuP1qVYLJVufDpQ=;
 b=qfpZrCU0BrwR1kyCIolbSaQn8pKgAqoX7ChBHlR/FxgudxUcqiJNqJHJJL6VzAXWDV/dAD63NTrZQBWtl5T6DcjVt7ZDc23wCK0nAPgAOWvQwIHqqWCve+1NgsVVIl01X40g9+Me5ri2b83/TbySRPhEuqBO9F1HSb/jo1hgSi96LVKjBVmGG2XUV/I7Vn99lHEYE3v6Hy/0stud5YZVCuGf8GnzPm/DTTHNB2SYWC9vbAeZqdckupJ5g6iuYEJIhKbmU2S19tIJ/7ujf9j+OjiHxwoZgXBReeuMDeAhAQRVEVJqZbDzpSWYLBKdzPfWLtJhe+GLqexIFsk44YDr2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LW9c6hA1ufQaGwa/wBqGHTRiU9e0KuP1qVYLJVufDpQ=;
 b=U8QxLDVWZFQXpanjAb2/46SdG2GS+Afg7UXBe1vpzxw6uMfu1vmUDlT3Lq7skqPgffwsVa+63t6ABpEVKZ9orq95TKpB621kG4BWbp2L5crNJjryL+fzy/rmVtLiugOfZMTD6ElUXeJ/Kh4rAurQojsod+VIgbRZ93VjGOSM7xhuDlF0FphEE/A4C5gq79dnv2sDRdLWh2vBq5IujB4WKYVhpOup1B9aGUSJwsAQctOe43eOmeKZ+TJvBa8uVFnhILqJC+XhqTKiLCINj7q7xQHagnklL+4EfBR/1y9q/IB9cJor7d9Kz5ug5cyPUyMiUaGT6YzLkRc49vrGxhT6KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com (2603:10a6:800:119::6)
 by AM0PR07MB6387.eurprd07.prod.outlook.com (2603:10a6:20b:15c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 05:23:39 +0000
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21]) by VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 05:23:39 +0000
Message-ID: <3e017837-f766-404e-a3f9-353d11ba7415@nokia-sbell.com>
Date: Fri, 28 Feb 2025 13:23:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Skip vfio in the scenario of non-privileged mode
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>, dev@dpdk.org
References: <20250117072847.2741-1-ming.1.yang@nokia-sbell.com>
 <20250117084750.3259cfa3@hermes.local>
 <ba8c70c7-a738-4b01-8df6-2df5bb0e2d7d@nokia-sbell.com>
 <20250226054540.166dfd43@hermes.local>
Content-Language: en-US
From: Yang Ming <ming.1.yang@nokia-sbell.com>
In-Reply-To: <20250226054540.166dfd43@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To VI1PR07MB9898.eurprd07.prod.outlook.com
 (2603:10a6:800:119::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR07MB9898:EE_|AM0PR07MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: 030655ff-cfc2-4a34-24b3-08dd57b80eca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnBtOGxWUnZKODBLcjBodzNSZ2lGa1IrZStDa01JWk9MTUlZQWtlbDEvQWV1?=
 =?utf-8?B?bk5jYUtuY2NnTnZQeDUvWS9relQwWUNVOUJVbW1WTW9hVVJPcm5lYjdhOXls?=
 =?utf-8?B?dkpRdUhJMjlkWDk5bnpHTUUxMkZKdjdIQlJFOWNTYnYrckRNZUg0QTE1UUlm?=
 =?utf-8?B?K2d5eTdiWDIxY0diMFpJTUlVekFiajBYLzJFUS9NTW9lQTh4R3Q5Z2hVRVgr?=
 =?utf-8?B?Zk05UThadTFlT3BzTGFSMDVpSHRaeVlDenZ1ck1yYzMzdHI3ZG9Cd0RpeU80?=
 =?utf-8?B?L3Y0Mi95RmpJZEhwN3NUbmY5U1lwUjVTTnpENFFCU1ljVTRrL253T0t2ZlFl?=
 =?utf-8?B?R2pXeFF4bFZzYTRwbmZmZEdvbVFxQ2ZqQ1Rtb1J3bVIvUmZOdDhEei8vcXIr?=
 =?utf-8?B?YjlZUEhzTTIrUloxVFpLSkhOT095cVl2UnBKWGwxNVJXZWhOM0dsenh0OEQr?=
 =?utf-8?B?YUpPMXV5UnEzS0lOMG1oa1BmSjJXZjc2TE1scWZMeDZaMkpySmdIdDk5cktV?=
 =?utf-8?B?Z0hCTEV4dVF6bVZRWFp0cW9ZMlAxWWtJMHlHc0JUcGtIbTU0cWVmazhocmRk?=
 =?utf-8?B?MjF5RlR0dmRQb3dCL3ZZazBCTFJRb0MvS0RaSCtqVGlLZlVCdy9lakZmL0ND?=
 =?utf-8?B?b3BCY3lZZ09YRFFvL3NIanU2cjRlNFZtWUJ0Q0FlWit6cmRJeGVGYjJBRmV5?=
 =?utf-8?B?SGxUWndiamIxeWtqaTZvNm1VSzV3MlpDeUhycngxYzJvS21xbXhRVnBKaFg3?=
 =?utf-8?B?ekw5SU00SE5pNmVJK3F0cjJPeUVKbWR1RExNNEV0V2lhK3RPQnhFcXNRMTll?=
 =?utf-8?B?Q3gydThxOCtRV3VScTBTaWNZZEZHSVBsVUZzUDBRYzVIbnNBQ0FKMGF2ZG4x?=
 =?utf-8?B?ekJWYnVNMTdYRkRTVmp1RndQM01aK1ZLcVY0Unl4MHRFUnp1djkwQ29GZHdH?=
 =?utf-8?B?amhKUXE0ZnRCOFFrRXVxL0l2UnpDWDdKb2VVOWFzczRnT0Yyc2JydmRwOHdp?=
 =?utf-8?B?d0pqSVJ3V3N6ckNBLzdrZTMrUGlZMUxLRU5ncU80YVQ1QUNlYVVJL2dSZW1H?=
 =?utf-8?B?bUtKTURNVXlmMzhjZmg1NzFNZlBtbUJBdDM5QlBSWmRWMnVFQk9HZk5PQXFp?=
 =?utf-8?B?amJFUmRTS01HTXE5dE9zODZTOGpkSDB6V0x5cUlZZXdrRGtUSnNma25wRXFM?=
 =?utf-8?B?TjNmby9yR1YzN2YzbGsyZXJPSGdxcDF3T081eTJIQndmUzlkUHpxekNnUm5E?=
 =?utf-8?B?TkxhNGZSazEwM2NCYzBuRWRHMkRteTJSejl3WG9TeEttbmlNTldIbElJQk4v?=
 =?utf-8?B?WmM1WEdqNVJIWEUydG94ZGppMTROSmRDdU91Q3YxU1VpTmMwdis0a2NuWita?=
 =?utf-8?B?UG55SmJ0RUxMVXFNeUVBU3F4c3lOTzdvdXpxNlZ5UTdmaURwaXZLWFI2ZERx?=
 =?utf-8?B?YTBIQkJaVUZZM3ZoZFhDYnF4UHZVeHRndmxnN1QzSVp5Z0owcTBqc3FmWjVi?=
 =?utf-8?B?MGhKUkQveGY3dy9DS0taUDdNRml0UUhqMnpLUENhUDFJVmV1cjFYYVY1YzJM?=
 =?utf-8?B?OHh4ejR1T3lqZXYvamJBZUFRbUVBVURlaVU2eUZWYW11Kzd6SHFaREFhREl0?=
 =?utf-8?B?WWNlZ3cwU2FFeFJYazZLdTd3Q2o3UnlGUnFMUDFTWlJSYzBld1NpQ1NhQTlu?=
 =?utf-8?B?bVdpV3NPdU9zMzBYdXc4cUJYZUlBaWtrOXZ5RFZZM3gyR1JqUGd2Z2cxczI2?=
 =?utf-8?B?c1lITDkxTm8yTDlNQXdxTGRYeUdTL0RScTBjVkRkcWpTblpWbnhCRG5OQmdp?=
 =?utf-8?B?aURzSkNxcXp6Z2dCYjRoQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9898.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3NJZWtnVjV2R2MzYUxDMnJOeFVST2s2SXpwaW4wbk9nNEg2UnB1YXU5QWgv?=
 =?utf-8?B?cVJxaDF0U2UyTFcrTk05ZEo4d3M2cW5EZ0Rzc3lBcFV1YysvUTJFRkdOTk9K?=
 =?utf-8?B?bjNRQnF1MVY1cm5zRHVRdUlYQllhTmRTdnpOazB0ZVhUOE9JR1A2SDl2djFD?=
 =?utf-8?B?Vi92TlR0QUZtdXhGalNpL2tZdXdpVVYzNFppRmlhT3dJSUFxSzFTUlhEZEI4?=
 =?utf-8?B?T2JudkJRT2xwdmdYYVJmSTZPMGhKdHN0c0VEWENuNHZ4LzVLdlNJcE5jalRP?=
 =?utf-8?B?WVhVaFdYelhJZ1NQOUxUSmlRMy82SHYwWk10OVdVTjRGeGRxUGNkcWNqL0Vx?=
 =?utf-8?B?SHB2OGxsSkxNNHJSNTdkM0lEQkU4MXVGR1JRc213TmxZUUxvRVNNV0NkRjBE?=
 =?utf-8?B?Tk9yeTJpUzBoaThyN0VkR1ZEcHVRZVZXRmIvSXE3OVg2M0c4azZiejRWQW51?=
 =?utf-8?B?d0pYYW5DRTVwY1JRNnRZcy9yMUgyVUZ2bjA4YzNRM1dhb0tDelhvZW5KeVhX?=
 =?utf-8?B?M20reld1ZW9QN2E2cU13d1hZZElJaWRGMUo0Y2szWjBianErRWQ0WDFCVkdK?=
 =?utf-8?B?SVJoWFRNdGRVSGNoZFh6bGZ3WmZSZmhGbVk5cGtmdnBSK09VREg1bWt3N0RG?=
 =?utf-8?B?M25TZGszcEUrb3hLbjd1bC9uNStuZ3FwR0JGTEJ5THhVUW5aMVdtUWRmbW0v?=
 =?utf-8?B?ZjlDSWdaSTdIQm11NHZBLzdlTDMrTTlZQXo0NGdKSC9LVm91MzM2OGErOWFW?=
 =?utf-8?B?YWg4YUh2cGxBd0hHV0VOMnM5UlVUd09ZMUVlakJ1RDlGUmgrcUpmVmo0QUNZ?=
 =?utf-8?B?SHZUczlkVU01VFU1MnNBOER6b2ZIQVIyN2hhL0Q2ZDAyS1ZZN2tUTTRPL0VZ?=
 =?utf-8?B?V0xlZlY5djdEc3JjUEc1KzY3Q0xJd1krSnVzRktVQkFBR0x2WWlTVnBHMHJM?=
 =?utf-8?B?WFVCWmFUYjM3V3NCV1JlQ3pKZHlESVVNSVB1OVplMzFYUUt4RTAwbHNMWW43?=
 =?utf-8?B?WTQ4QkpFemd3REhvL3ZXVW1TNXlPWENzcDc0K3g1MDdvbENlenhGd211Wk9m?=
 =?utf-8?B?U2hlRUJYUllvNnNCbFFGa0RtME1Yb2xicUlzL3RwSWRXcXM1WlBnRTl2S0d6?=
 =?utf-8?B?VmpuS1VzRlhEYy9tZzZmTU1ubk5kY1h6K1k1Z1FlSURKY3pZbFhCTU82d08w?=
 =?utf-8?B?L3lNazROYnpZdlhPRWw5dTlsd0svRGFwYlkzVVR1anpFN2l3My9SOWo3U3p4?=
 =?utf-8?B?V09QVE9VZHptaTBQbWhmcXNDdGZDeTM4cmxNOGJCTWdRc2J5cEVYOHBYcW9a?=
 =?utf-8?B?Yi9BQ2M5NUdndTI0T1VKcWVDQTVoNVRUN3JKRURPM2pCRDNvUGp6dlVKdWRV?=
 =?utf-8?B?VzZqS2pXNnFqV1Q5a05lOUhGNkZ2c0hBTnZiRlZPVnJXbWkxell1WXVNL1JG?=
 =?utf-8?B?YXUwMnZOWnBPR1lNMVk0ckR5QWtMak1mTlVWcW5CbkNhMnJVK2JzRytreWd4?=
 =?utf-8?B?NVFPWk1lUjhkQUMycWFKa3JLazdnbVd6T05OUXNQUUpwWnNDZmR5V3h2YzB6?=
 =?utf-8?B?aUV4OHhBSEc4Tm9PRWNUemZQZWRiUGJMNDU1Q2JoUENYeXoxS3NMaUdubkhC?=
 =?utf-8?B?OHplR3NlN29PRnFPaUVGb21zVlZvZnFvZHl2MmIwaUl4eGFRcTJlR0phU2k0?=
 =?utf-8?B?N0tibEZ0S2dCSW9NU0xxa2k4NnZEK1pBUXVRZk1YMUdYUmd2TlhvbjBIVjY3?=
 =?utf-8?B?dWVLZTlCa3ZPRnd1M2JLMVU3dFB4cC9oYklwMHNuLzlJUVVTOUIwcDFEWEJr?=
 =?utf-8?B?OGFudVFheVZVVDl4NENZbmlKdkhLenh0K2ZQcU5Sa1lYQUFjNUlSTmtBRHVM?=
 =?utf-8?B?dGsyb0Eza2FOdENjMTl2WngrTmFRcFJKSlRwdjUvZjQzQ2JmVXdIaHRqRE5w?=
 =?utf-8?B?UGQrR1dWRHp1aC9Vamw3dnM4Ukxvb1l1VGZ2aEZLY1RTWmVoZWZ6RGkraS90?=
 =?utf-8?B?V2w4c0ZnY2pTMFdaQ3B1TjBJUjFLZVo1OFZPYTd1azd2RXp4REphTTJMdmhi?=
 =?utf-8?B?cTBPSktJM1g1RVBSazFmdi9hTzhRM2dXYUhBTGZsaUhuRk82eFBDb1ZWUm1z?=
 =?utf-8?B?MUNOSzRsN0JSN041dHVSNGxSYmJRdWx3VzJGNUd3UjZFZC9lblV6VjladHRB?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030655ff-cfc2-4a34-24b3-08dd57b80eca
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9898.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 05:23:39.3234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTyLTQ8m0rNIHXNvmvfGWoXy2S6s+VNTDqZ+6Of4M1p/86uBoBvtMjJFkvXcV1m/Z3rQ8VoWFUL6CiGR8SzEd9ssP0AdEZFu0JEFCxdBpks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6387
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


On 2025/2/26 21:45, Stephen Hemminger wrote:
> Caution: This is an external email. Please be very careful when clicking links or opening attachments. See http://nok.it/nsb for additional information.
>
> On Wed, 22 Jan 2025 16:15:03 +0800
> Yang Ming <ming.1.yang@nokia-sbell.com> wrote:
>
>> On 2025/1/18 00:47, Stephen Hemminger wrote:
>>> Caution: This is an external email. Please be very careful when clicking links or opening attachments. See http://nok.it/nsb for additional information.
>>>
>>> On Fri, 17 Jan 2025 15:28:47 +0800
>>> Yang Ming <ming.1.yang@nokia-sbell.com> wrote:
>>>   
>>>> DPDK detect vfio container according the existence of vfio
>>>> module. But for container with non-privileged mode, there is
>>>> possibility that no VFIO_DIR(/dev/vfio) mapping from host to
>>>> container when host have both Intel NIC and Mellanox NIC but
>>>> this conntainer only allocate VFs from Mellanox NIC.
>>>> In this case, vfio kernel module has already been loaded from
>>>> the host.
>>>> This scenario will cause the error log occurs in DPDK primary
>>>> process as below:
>>>> 'EAL:   cannot open VFIO container, error 2 (No such file or
>>>> directory)'
>>>> 'EAL: VFIO support could not be initialized'
>>>> Because `rte_vfio_enable()` call `rte_vfio_get_container_fd()`
>>>> to execute `vfio_container_fd = open(VFIO_CONTAINER_PATH,
>>>> O_RDWR);` but VFIO_CONTAINER_PATH(/dev/vfio/vfio) doesn't exist
>>>> in this container.
>>>> This scenario will also lead to the delay of DPDK secondary
>>>> process because `default_vfio_cfg->vfio_enabled = 0` and
>>>> `default_vfio_cfg->vfio_container_fd = -1`, socket error will
>>>> be set in DPDK primary process when it sync this info to
>>>> the secondary process.
>>>> This patch use to skip this kind of useless detection for this
>>>> scenario.
>>>>
>>>> Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
>>>> ---
>>>>    lib/eal/linux/eal_vfio.c | 11 +++++++++++
>>>>    1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
>>>> index 7132e24cba..1679d29263 100644
>>>> --- a/lib/eal/linux/eal_vfio.c
>>>> +++ b/lib/eal/linux/eal_vfio.c
>>>> @@ -7,6 +7,7 @@
>>>>    #include <fcntl.h>
>>>>    #include <unistd.h>
>>>>    #include <sys/ioctl.h>
>>>> +#include <dirent.h>
>>>>    
>>>>    #include <rte_errno.h>
>>>>    #include <rte_log.h>
>>>> @@ -1083,6 +1084,7 @@ rte_vfio_enable(const char *modname)
>>>>    	/* initialize group list */
>>>>    	int i, j;
>>>>    	int vfio_available;
>>>> +	DIR *dir;
>>>>    	const struct internal_config *internal_conf =
>>>>    		eal_get_internal_configuration();
>>>>    
>>>> @@ -1119,6 +1121,15 @@ rte_vfio_enable(const char *modname)
>>>>    		return 0;
>>>>    	}
>>>>    
>>>> +	/* return 0 if VFIO directory not exist for container with non-privileged mode */
>>>> +	dir = opendir(VFIO_DIR);
>>>> +	if (dir == NULL) {
>>>> +		EAL_LOG(DEBUG,
>>>> +			"VFIO directory not exist, skipping VFIO support...");
>>>> +		return 0;
>>>> +	}
>>>> +	closedir(dir);
>>> You need to test the non-container cases.
>>> If vfio is loaded /dev/vfio is a character device (not a directory)
>>>
>>> Also looks suspicious that VFIO_DIR is defined but never used currently.
>>>   
>> Hi Stephen,
>> For non-container test, /dev/vfio/vfio will be character device, not
>> /dev/vfio.
>> Here is the command result on my testing environment with Intel NIC.
>>
>> [root@computer-1 testuser]# ls -l /dev/vfio
>> total 0
>> crw-rw-rw-. 1 root root 10, 196 Jan 22 01:50 vfio
>> [root@computer-1 testuser]# dpdk-devbind.py -b vfio-pci 0000:04:10.2
>> [root@computer-1 testuser]# ls -l /dev/vfio
>> total 0
>> crw-------. 1 root root 239,   0 Jan 22 01:52 59
>> crw-rw-rw-. 1 root root  10, 196 Jan 22 01:50 vfio
>> [root@computer-1 testuser]# dpdk-devbind.py -b ixgbevf 0000:04:10.2
>> [root@computer-1 testuser]# ls -l /dev/vfio
>> total 0
>> crw-rw-rw-. 1 root root 10, 196 Jan 22 01:50 vfio
>>
>> Can you confirm your test scenario?
>>
>>
> When vfio-pci is loaded but no device bound:
> $ ls -l /dev/vfio
> total 0
> crw-rw-rw- 1 root root 10, 196 Feb 26 05:39 vfio
>
> After binding device
> $ ls -l /dev/vfio
> total 0
> crw------- 1 root root 511,   0 Feb 26 05:42 15
> crw-rw-rw- 1 root root  10, 196 Feb 26 05:39 vfio
>
> So testing for /dev/vfio is good indication that module is loaded.
> Not sure what I was thinking earlier.
>
>
>
>
Hi Stephen,

Thank you very much for your explanation. It's very clear.
Can you help to accept this patch, or we need more comments?

Brs,
Yang Ming

