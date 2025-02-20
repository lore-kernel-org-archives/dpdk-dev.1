Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD06C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 09:13:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0F9C4014F;
	Thu, 20 Feb 2025 10:13:27 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
 by mails.dpdk.org (Postfix) with ESMTP id BEF0440041
 for <dev@dpdk.org>; Thu, 20 Feb 2025 10:13:26 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1eX+lzxT458huC09iG8awFj+hstBNNC9xVAagD1Z+d3EhJoUpvs1VFTG5SUOSmZ+d4hjlEesOOhRJ48QFSsmUXAPOrmvuC4HSqvDuXNudOmyC0WMP+2JWi1QZa02lRhU3XpUb6ygE7b4SX0VAGm8cAZGIh1mWTT0iRT038p9Qibz1wu9bWCSYHYMgj4A7Cq02LQCO0udflYsdIYMDNN08QvBhvefNWlKNRIhSL8yUn2sbHTEH4K2mcCnnpr5USZnxwfYJhNjgn6MRUsU6dJrELbrYlQK34PUS5AnBWhB8Qrcs6dej0cpoAt21b8z4/4evS3oVcUApo7aK8MeI5gJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xyjh+QId689QFsN8tNFLxWvNG3GFyYtqQ6CQmnT7nOo=;
 b=hxIGj9e4gP2JTZvJhOMmS2dOxDDKOZSbY7ND51lWzYKJLu7rWzhP7vAcEQRDTYCSxj9kN8QB2+hNDd85wVwEjuwzUZ5I9n20WZOhdbJVB9AigNHJezhA9q/p2E/F5FilN8vTEml/BXvGY6lv6oTEEH+0SDgIagd0A8hssXI6TtccDqdFsCVjC14KZln1hQt9TGwGQ15APMzbnozFoRgXZeWZZ3p2XQsUHoS8B2CU/qjmXlDZJ6egyzkY9Ta8OYypc42fdn02VC4jYKDKkHb2ER+UNrTwXkmFSdXQs2RLsPqwvC4koFvJqwP9qwX9LoXZmLI6p0esc3mVfK2jtYBFLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xyjh+QId689QFsN8tNFLxWvNG3GFyYtqQ6CQmnT7nOo=;
 b=d8PrjYCX3IrqErGpoaietWncrllA3S/spL/tJCyWX9KNhZ1fiZ9ySnSH0+r1Pbl54WgSPmgIYuabnEo7vF6rK/K/jwBQ2qR2r2DaSunxHXtreRdEmywuEmZEDh9hkHbypxJHovfwKm1jYu+DyDezfIzmaLnTYDj+n44qwoaQUzG4dj3VgAo0BI2Y06IeUnI0IDi1EX4gqtLVplF4ob1A0ork6wUNiuAkJyPuR6VKDVVSA6sHqOrlb9AmFu/UUriMXE6eqYo7YGYunG2MllzvOJfX8/QpFE9IAbDijbaC+mqdcQ2fmA0MrUH8QJ01Rc8TehFlqZW9fb86EgspnftSfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com (2603:10a6:800:119::6)
 by PAXPR07MB8769.eurprd07.prod.outlook.com (2603:10a6:102:244::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Thu, 20 Feb
 2025 09:13:25 +0000
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21]) by VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21%6]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 09:13:25 +0000
Message-ID: <2a825be0-cebf-4218-9e4f-d64b02bf2d6b@nokia-sbell.com>
Date: Thu, 20 Feb 2025 17:13:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH v2] cryptodev: not close device when secondary
 exit
To: Akhil Goyal <gakhil@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Cc: Anoob Joseph <anoobj@marvell.com>, "kai.ji@intel.com" <kai.ji@intel.com>, 
 Gagandeep Singh <g.singh@nxp.com>,
 "jack.bond-preston@foss.arm.com" <jack.bond-preston@foss.arm.com>,
 "pablo.de.lara.guarch@intel.com" <pablo.de.lara.guarch@intel.com>,
 "matan@nvidia.com" <matan@nvidia.com>
References: <20241128054829.1453-1-ming.1.yang@nokia-sbell.com>
 <20250103030957.1117-1-ming.1.yang@nokia-sbell.com>
 <CO6PR18MB44844F645EFA1FA6C852B11AD8122@CO6PR18MB4484.namprd18.prod.outlook.com>
Content-Language: en-US
From: Yang Ming <ming.1.yang@nokia-sbell.com>
In-Reply-To: <CO6PR18MB44844F645EFA1FA6C852B11AD8122@CO6PR18MB4484.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To VI1PR07MB9898.eurprd07.prod.outlook.com
 (2603:10a6:800:119::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR07MB9898:EE_|PAXPR07MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: 8faf092b-3b42-4617-4f6c-08dd518ed47f
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anRaT2xuRTFYSWJMTU92YWx1RTRWelZtRFN3WjFlYTRZTjZTUlJncHgrblpq?=
 =?utf-8?B?aWRnQWtUOEo0bVFsaG5KN0IzWmRVZzFhMnMrZ1RISUFQeGVaQkREWWcvUjhp?=
 =?utf-8?B?am91a2RtbzhPQW54NVBRTEZGR051akZDbCt5eHNuMEJuL3FmWndhMDc2UmJ5?=
 =?utf-8?B?N2ZmeDllOE5PSEd6R2tJTmNHRXQ4RExFUDMyRjJOV3pBdk5iOGxSWU01Mm01?=
 =?utf-8?B?WG9FcXhVYkI4cEhzL05ZTTlwVUM3SjJ3c01xN2FuT2Z2TFp6TS9VbkRZQUEy?=
 =?utf-8?B?ZHhQajViY05wemZyd1pvQWRKOW9uNGtuRmtjM1lNSTdkdWUzMW9LL1l5clNN?=
 =?utf-8?B?STBiTkcwRnA2RnIweXZFNnFVSXZ2M1E5QWxveXFsY29ONU81R0hhYk9oeWJO?=
 =?utf-8?B?cnpEcnlrcWFTT0ZtZUdDYzIrZHFyZXkrVmZoSUhzWXlOU1VDSUl5dmJRYW01?=
 =?utf-8?B?ZllmLytNMWl6clZhQis0YWxnRTJMeDg3RXpxMnByVTZkemxsTi9zbzkvYUt0?=
 =?utf-8?B?Q0NoZHg4Ti9BYUNkVTJMK1dZck9pditURXZYZmhmTkFlRGlBa0NjU0Q4TldB?=
 =?utf-8?B?bklTcjlyeXI5NkJLYWxmV1l2SnZRenlrRzFZd1kxQ01OSS9OdFNzOUpMQ3d4?=
 =?utf-8?B?dlBpUThpaUdtSlh6eTNkc0liYmNTSS8waTdoNTU2SmN4T0hBcXhOdHorbGQ4?=
 =?utf-8?B?QzZ6VEZDSEk4SkNmckVGWHBRclBhL1Rmb2xONFg2bFVhZXZ4WUZCaWN6U1hw?=
 =?utf-8?B?SnZWbko1ZStaNmtFZmpRRVhKTkRwRkJJTUNpZktHZEx3MHk0bGt0QmlSMHZL?=
 =?utf-8?B?YmZKMCtUMW1DQ0JVTUFkaTY4RmJLOGowZlFveGFUdm9UWlRocGkrZHljdE9L?=
 =?utf-8?B?RFQ4NVNzcXJ2WkdhWEt6SzQrbXZydzhhMTdhbnNMS2VtY0pCVUdUQmg3NWd2?=
 =?utf-8?B?WHRqSE9uMXdnbGtjMlhoRFVUcXhvVTVLdkNvb25PSmtoRk91NXZUWnlmU24v?=
 =?utf-8?B?WGl5WWZKeUNmZTJnQ0I4V3B4bTFDREIxRFZFbFM4amJiZXRPZVF1V0huQ2dX?=
 =?utf-8?B?Q1h3QnV0VS9kKzlzcTZrSE0rZTlzOTRGS0MzNTFYWTRVbXdRK3crWjN2ZVJn?=
 =?utf-8?B?OU5qYThsTUJKekZmL3I4YzJwalVoVlpjcTQxc29vSXBMTFg2RnUwQVlVRnFr?=
 =?utf-8?B?SjJ1NUNaeDN3MGJUY3NHd1R5RlJvZ3d1Lzgrd005MVpVZW93QlpnbDhhSk81?=
 =?utf-8?B?eVMxOEYrWFZpR1o0VU4wdWhEeUZzcWxEOGRpRTdidkdoT2ozb2hPTHM1OWtL?=
 =?utf-8?B?MzExcm5MYm9NZTJJTTNrOGRvREk5RGYwS2t1VWllY0cxby9zYVEvd3BJc2pC?=
 =?utf-8?B?VGJDc3ZsNUhZOFpDaU9OdmtjdTFpUjczRVNZbEVwdVNKWHJhOWZaWDZEbjFt?=
 =?utf-8?B?M0Y4czRSYkgvYy9rZWxLUGY3L3R1TEROaU5FUG12N3JVNW9Ndmh0UVkzQndz?=
 =?utf-8?B?KzhjS0t0dlgwdExNZU5ORTVscGxjZStTNFcwNlUvMDNpamJsM0dRQ0tDRk5a?=
 =?utf-8?B?UmF2dENVcjAzZHBNOWJ3aWRvSERqbFYxM3BKQnVod3Y3OVVoWTdLTUZ6b0JI?=
 =?utf-8?B?aHVneTJYanQ3SzVFNGpZMFR1a3M0U0p3R0l5ci9KN0VPRmlXQSt5U2RjbHUv?=
 =?utf-8?B?cmgwaWtxODJ0VzltUG5GK3lpUVhJTlNtdDFkNXg4Umh6eXpvTzJIVW00elNm?=
 =?utf-8?B?VVZINXpPVmpFNGt2MHhWTlRmbXlEMWJ4b1hMUVQwWHRYMFFGaTZMRFZrWGg3?=
 =?utf-8?B?ZEtKWXlubmpiWGxPOHEwZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9898.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGdPazdCbUdLL3Q0ZG5uK1NnM21SNGlweU83MEVMZjNLMWtNWlVoaER4Z0xt?=
 =?utf-8?B?Y3JYZ1lWYVlwT2wwWmR1Z09ZWnN4cXYyZnVKeWlEWU1xZFl2Mit3YXVMOUgx?=
 =?utf-8?B?NVJ0MGRHdmVlekxoTTBNSVpPbC9ObGtmQ1g4YSt4Y1lEaDJXSnJOZC8vay9r?=
 =?utf-8?B?R1pyRUE4a0JwMXVqTzl6bVM0azY1N0lxc05FQmJTVlZCYmR5U1RFRWNjYVh0?=
 =?utf-8?B?MkxxWjJLdVBqZVcyTzA4Rlp6b3BUcEdmREFYc1RRSmpPakNkY21lQjlGUS96?=
 =?utf-8?B?Mi93ZW83dG1JYlJKN2pUbnQ5bTlCU1htdGtQMGR2TzVrZ0psdTdydXpKM3R2?=
 =?utf-8?B?VTdpakk5ZC93Vk5YV0Y2SU02L0ovNTZWSjJoaHV5M01xTTdDYUFxQ3EvV1U0?=
 =?utf-8?B?ZkcwRjVMT0JEWE1uTDZIalhDd1dKQzhqWDcyMForZjlEODZYYUxBT3Y1VW9t?=
 =?utf-8?B?TmppNXEvdFVubUR5eENWUmdmZnRKcFV6SDZiaXA5Vk5DQkdwWWwvSFRVSTdF?=
 =?utf-8?B?a0JCZS9TMjg5UUpGRE85TW9hUVVxSUhEWnI5K1dLVHQvM0xXOTNQWGVPcmVH?=
 =?utf-8?B?a0VMVjZ2L1czbEJvcVNwcmZDTGRRa2lERDBGUHdHQmZVQkhiZmlxb0xjallR?=
 =?utf-8?B?UkRxZjJkY214d2RvMHl4U201MmZYY2NPMXVuQUhMbVRGSGZURmREaEFScUVN?=
 =?utf-8?B?azFMWUFmYnRWdFhsLytKdW01N1IwdFh3YnN0V24zVFA4OXdaa3NqRThLeEcr?=
 =?utf-8?B?bVRENG14a3hWZGlzRkRJTjVIc056S3NtUTAyaGdOR0NCK0JyV3drMjdPeVps?=
 =?utf-8?B?cFNqWTQyZzRwdGE3TmVmMStWTDZ5RnpYbzhiajNBZFpuUmRUQVhJbnVCWEVJ?=
 =?utf-8?B?SzkzalI5VXZwZzczK0FXU3FtZVRFNzJkVENNUnM0TGNIYTczdEZTcUJQTHh5?=
 =?utf-8?B?Y01ydzk0RFdzYlhpellVcCtLMGtHSmJnMmxyMFBZQmViNFlqcUR6TEJWeFJz?=
 =?utf-8?B?V3didGRqemxid0kvU2l6VGNFWGh3QXpldzN5NnJwUTdsSHdrYjRRTWE0Nisy?=
 =?utf-8?B?V3ltTlNGb0t4OXVBeDdaVHVXVEtQQzBqaXJPcWhmckk0UUhVSU1sY0hWYm80?=
 =?utf-8?B?c0w0aFlRL08xOHVMMnk3T2UrVXY4QVVHd1BOMkxybWpodlRzL0NmVFpkSk5s?=
 =?utf-8?B?THppNkhQa0ZML3RCdUlkajJNaFJiK3krVk1ZQUs1ckJKNWNPMm9BeXErYjZs?=
 =?utf-8?B?a1BoQTlaTjVuR210KzR5TE9lRkc1WC93WnNuZDVpS1Q1V21ZcWhzc0RTTW9a?=
 =?utf-8?B?a01hQ2V2NVFqMzRnODdtV2JIZWczaEh1VkpLMnRJYVVSWm5yb0lpa2lySkNu?=
 =?utf-8?B?SjNKVENzazhoUkRvNGxJN1BudkpsZWF0dWxhU3JSV3BQYmJLVGFzU2phcGds?=
 =?utf-8?B?cFlncUFpcUkwWU5BT2duTWxUcWc5MExxYjk1bHFrb3Iyci8zUGhOSFIrZkxW?=
 =?utf-8?B?a2xFSnJtUkJ0Nm8vM21UbDdmZVUzVWkwMEZkU0lGYmlhOTErcDFVQVdLcGVi?=
 =?utf-8?B?RnhJcE8rOHlqRWZ5bk1jVCtRV09hUWxrQ0c0MktFeGdrWUZvZjVRak91c0l0?=
 =?utf-8?B?bHFsNFg2STJ6VDltT2Q3MmxqZGlMNlhseHFxOUhCSGJqcEVKMmxQS2prT0gx?=
 =?utf-8?B?bVB5bEpEUGYwVmt5TC9xamk0dllabXhtNzNuS3BVeUxSY3pDeEZGc0FUek1i?=
 =?utf-8?B?a0lnUS8ra2hZK3ZSS1ozVmtFTmpmZzJDbis1L1lXR3NQUHd1ZUZiNk9haDVt?=
 =?utf-8?B?K0ptd0FjZVI0OGo5cG5tZ0lwZ1BrcFRXOU9XNkNnSkR0ekdIQ2h5ZHBuYXVs?=
 =?utf-8?B?RHl3c0hINzA1S3FJMitWaS9xWVYyTHI4Znp3RmlwMkw5VUxTbHllTllyb2xM?=
 =?utf-8?B?YjNCaUcrSlZRcVdIcGcwSEJmdDNuSjhvNTB0VTNmSlFuNWgrM0hZckJXMWE4?=
 =?utf-8?B?M2lsbXprbnlqN25zcmhIY1hjUXZVbHVNVjhEMUZwM3BqQ0lNR2hKSDFvRDY5?=
 =?utf-8?B?ck9ReWRQc0twdldBVjc1dGtKbkkzQ0FGTktHWDlDR0FaQTZibkdNV0gvVnpC?=
 =?utf-8?B?c0JMMEhmaTczNEZoUE80WnUrSjFuaUYrVVlWT1d3enBaZmlYUjg3VlM5RHZx?=
 =?utf-8?B?Vnc9PQ==?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8faf092b-3b42-4617-4f6c-08dd518ed47f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9898.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:13:25.1044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVpyTze6y4qMuqArDk6uoMMJFzYK4dkT6agJX7XDaQrkia3JUonGRXBan//Q74Fo5zK+ni6glVhTj4UCI8yN5LpRwYaG1XmgA+6fuC56nIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8769
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


On 2025/1/8 20:21, Akhil Goyal wrote:
> Caution: This is an external email. Please be very careful when clicking links or opening attachments. See http://nok.it/nsb for additional information.
>
>> The secordary process should not close the crypto device when
>> it exits because the primary process still manage the device.
>> There is no reason with occurring error log below when
>> secordary process exits without any operation on the crypto
>> device while primary process starts the device.
>>
>> Case situation:
>> eal_bus_cleanup has been added in rte_eal_cleanup. But for
>> secondary process, eal_bus_cleanup will trigger vdev_cleanup
>> which trigger rte_vdev_driver to remove. Then crypto devices
>> will execute ipsec_mb_remove to rte_cryptodev_pmd_destroy.
>> Finially, rte_cryptodev_close will be called by secordary
>> process exit.
>>
>> Error logs occur as below when the secordary process exit:
>> CRYPTODEV: rte_cryptodev_close() line 1453: Device 0 must be
>> stopped before closing
>>
>> Function call trace: rte_eal_cleanup->eal_bus_cleanup->
>> vdev_cleanup->rte_vdev_driver_remove->ipsec_mb_remove->
>> rte_cryptodev_pmd_destroy->rte_cryptodev_pmd_release_device->
>> rte_cryptodev_close
>>
>> Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
>> ---
>>   lib/cryptodev/rte_cryptodev.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c
>> index 85a4b46ac9..ed1021f635 100644
>> --- a/lib/cryptodev/rte_cryptodev.c
>> +++ b/lib/cryptodev/rte_cryptodev.c
>> @@ -1142,7 +1142,7 @@ rte_cryptodev_pmd_release_device(struct
>> rte_cryptodev *cryptodev)
>>   	cryptodev_fp_ops_reset(rte_crypto_fp_ops + dev_id);
>>
>>   	/* Close device only if device operations have been set */
>> -	if (cryptodev->dev_ops) {
>> +	if (cryptodev->dev_ops && (rte_eal_process_type() ==
>> RTE_PROC_PRIMARY)) {
>>   		ret = rte_cryptodev_close(dev_id);
>>   		if (ret < 0)
>>   			return ret;
> I believe dev_close is actually not required in pmd_release_device.
> Dev_close need to be called from the application separately before it is released
> which I think is already happening.
>
> Adding more people for review.
>
>
Hi Akhil, I suppose the change of removing `dev_close` in 
`pmd_release_device` requires much more effort and commit size because 
this change will impact a lot of examples and cases. As there is no more 
comments from other people, can we accept this patch as a little 
improvement for the second process's scenario and wait for the entire 
improvement from anyone who is interested in this entire work?
