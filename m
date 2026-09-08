Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18463C79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 07:25:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D6FF4026E;
	Tue,  8 Sep 2026 09:25:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 9231F4026A
 for <dev@dpdk.org>; Tue,  8 Sep 2026 09:25:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788852355; x=1820388355;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lzoh+epcQxR8Zk1iIseii6VqkCCyo343f3feAz8+88k=;
 b=Dw/UdKYFu7V6qRnQ9zrmVag1MrotjS3H5l5EdT3AGMhXJoeROUA8dXa5
 pAhcOFQwWrvICWEG12dAfzma7kK2CpSm7IaDePdxQlVEUpWSuP+zYwQka
 O/sMt6zHJce5Z4JcHKe/R1YT8c6rA64FYLtl5ObN2nmUidutrHtPv77+I
 VfqBSYqtn51eJOqGPdl/bcu+28z99HWI93M2XEXz5Xej+/leNKQAfyQTF
 QE1bo9U5jL9bC5GJjAFzHkA/GaX6OT95yp/qBi92/OSK4wxWC8jlcvypj
 EbgSY0QQwnLjhS8cmwkG8BbziNaOZ8jyhnHTnrJ1Yh4C8eoyVzavkn+Dc Q==;
X-CSE-ConnectionGUID: eig6w9G0QhWM2kNAAMDKQQ==
X-CSE-MsgGUID: NVWsC+4jSjqOvaNixUVWSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="88395174"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="88395174"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 00:25:53 -0700
X-CSE-ConnectionGUID: X3d91XWKQNG8xQPiejx8+g==
X-CSE-MsgGUID: 56CpOO4TSqqJnGv73npzVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="295817480"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 00:25:53 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 00:25:52 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 00:25:52 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.65) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 00:25:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anCvzLfAzrbaiIdwIzRkwfNawn/CTdkRr6GUah5KztLs7dBKrgmZU9c41xN0J1A3MmmSsFpFylJjQNbmFNPiTqeL1FKK0lkLHGA0YLV7plL22cV1XtPvooydN0bauj3H6hOH6aPnL/GJllxBIP81kh+tvszoY+YTN73mZ6UHFsvOPdZwMIorUGgW5eLjc7SFtRjj1PffiTNewEnrZhRogiCM+ZAcyI7ApwBviaQGj49cD3ETrjlK1cMBbZ7QcLo8p5TVWvCQ3cyhH4H7fwoqH0E119d4t2cF2t0GqsN2P06xg63GETDybKmAQ43sSjkjInsCunYaCTiQZox7DHXqFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YefUc7RrxFlfM6CD+eONVoI8kxfH8MNFVmLvHw5Nxs=;
 b=tbg1H+f4P7gfFOZBMaCRoHXhnAIEvY0/a5kle8CcAqqX0Zn7tk2oKHDBpZCtuJJ7Cs8x39fsgNv8I+aN8pti++EYv0UoA/mIAQq3KOH6YeonMh2IDVCdmTgV7M3/v/NRYjtKZ00e3n/brxydjWPzmFXyNtGvWBC2t5EOG2grsKFTQrayrAV6RQa8BE9qcKVda66HmLgF74xyDdwnUrtpT1qPFwcQ/hoOQIan3kq82H4grThqXwaEW33M404mueucHWK3ighR2YGmG32hEuaUPzPj/5vjV41oRQBvqvgL8wFwxaPnd2OTWKrcIDbAnJmm8mxmxfhwuKVoJAevbNjKkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7563.namprd11.prod.outlook.com (2603:10b6:510:286::11)
 by CH3PR11MB687348.namprd11.prod.outlook.com (2603:10b6:610:362::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 07:25:50 +0000
Received: from PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954]) by PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954%4]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 07:25:50 +0000
Message-ID: <f39c6f17-6da1-4d46-84d7-5c2e45cd1122@intel.com>
Date: Tue, 8 Sep 2026 12:55:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 1/3] ethdev: add Tx timestamp slot management APIs
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <bruce.richardson@intel.com>,
 <andrew.rybchenko@oktetlabs.ru>, <aman.deep.singh@intel.com>
References: <20260827122200.339388-2-rajesh3.kumar@intel.com>
 <20260902055125.836268-1-rajesh3.kumar@intel.com>
 <20260902055125.836268-2-rajesh3.kumar@intel.com>
 <20260902071311.5e28db7d@phoenix.local>
Content-Language: en-US
From: "Kumar, Rajesh" <rajesh3.kumar@intel.com>
In-Reply-To: <20260902071311.5e28db7d@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0212.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::9) To PH0PR11MB7563.namprd11.prod.outlook.com
 (2603:10b6:510:286::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7563:EE_|CH3PR11MB687348:EE_
X-MS-Office365-Filtering-Correlation-Id: 076b306e-2cbb-4a72-6a1d-08df0d7a68ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|4143699003|10067099003|6133799003|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Ha6urvhrEPLPxQ7RE8SMf84wZEHMo/vpOfvKJGxjy3PfJcol7p8ALIwK40CCm0FtbAwBIY9Axfc++kVdzRx/ukYLyc2aLCZFgcoN1TcQYGo0QllMWdbGErtko6HhH0nv7RpEl429z9RGStRBivVy80Lp9Z20z2gn9xykxuUyspvE/tNwiNFsw/yc/UuS3hZEP+8erWYnhHvlswy7LGfDe9WLx/wFsXdsAsBnUAcGbpvvOM5Qd5xrJO5pqIV963zG+KVZ4EBZ2x4pf0itE975AJvQqeDwtneBxZKDbK1uPjyzxxl934M0AB5/6RtJFH61m6cv6kybNwkrFeW4uywO5wt+PxEK5IvKEVaMA29cRSWoUrLiMtmZAXHVrqiUvvOtCWAkvdaIbEJw6QE2PRmrZF+UXeoPW91s08TSA7t1h1+n0pycEGJUcoDwf3U+NpcU4IvwKrEj03OzO1ytZkkUNZlTqD3N6hzLdfZ53+YAF1Dtf8NIUlHDq6fTfo/Hb2KN4T7MdIfV/VzQIataomQhVmk2PHxQZV4t8QQLLGPDV9iJY+q1QPXn7ErF5+8QA3E2gBu22hGOkMsAmkdcJ2jlPgd/YQA3m4vupwHsroHDeFUn9uWTsQvvH4mv5HXTDvjShRKGE4hqgg66jMqC0lB5+WFBCcWaTRrutcJwSpzFugU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7563.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(4143699003)(10067099003)(6133799003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3hUczhGREljTGhMRXdpWUVLTXlzQlhYejFiQTR4MFNwZ1BvSTdabVBnQUQ5?=
 =?utf-8?B?eGRWdDhFWGNzQkhISUhCdnZVeEtjb3E2QlhQVGFmdWtDRzFLY2txM3NidzR4?=
 =?utf-8?B?OTFkVVFyVGh5enE4aVI1MHJ2T3RZb3FkNnRiZ3hUMWxUaTIwMU84VFUxRTJU?=
 =?utf-8?B?bmJTRUJPNDR6UGpMUmRRaXc1UDJ4MjN3Uy9HcXJSUUVucGp2c2Vid3dPNkdX?=
 =?utf-8?B?aCtUZDg4VW5oVG92MWZMYUNHTnBGMDZHVXFiaFlnQmYrQ0xwQVd1YmtPa0Ri?=
 =?utf-8?B?b1lYb1NFWHFSR0pJamNHbzlKYU1tWm5HOU8rbWhWTFdyM1E0bzVKTEdsV1Q2?=
 =?utf-8?B?cWRoM1hKOW9ZQ0pWNW5qOVZnbklGMmpFZG9WaE1NK3RzMlU2YjNCTzV6OCt6?=
 =?utf-8?B?UWMwRks0SGllWGNFUjVSYU0xM0xXZ3poTk1wclBuaHJGVGZkNDB0QUQrSmVB?=
 =?utf-8?B?MVdCc1lNeTJmV0xDMmsxOStjR1l5RndyMVJaTDUzSVdRcEltTGpPd0V1anRu?=
 =?utf-8?B?UEs4aWxIbWhTb3BKR2d4RHNmaC80UUU5elUxRlJaWWlURVBQR0VWOVUzNFRr?=
 =?utf-8?B?QWxuVXd0ZVpMQ1U0YVZRbnNpcllmcjRZRm1wM3hkaDNnR2daT1Fva3NKYW92?=
 =?utf-8?B?RzlkdHU5ZWdhbTFseHdzSVp1TzFCRGE0VkZpeWtid3lJcG5DY0M1QkJCVmk5?=
 =?utf-8?B?UVdwd2s5Q2NTZVkyT3JyTGQ2VDJTd0tSbDBEbmtiUW1DYjdKWmRCaEVkcHBP?=
 =?utf-8?B?bC84SHlPYzlwZXJoalcvMGRtTkhTUHFHUmNIdUt1dnlqa2dvZ2VqaHBJMHFO?=
 =?utf-8?B?RFp6Q1VDdERSUHJyK09uTXhwS3dhNnNRcStseGlTNk9NbVEzVmFJNFp2TEFl?=
 =?utf-8?B?T05ZdG9UNjE4M3F6MGJqTk5vNDVKRGRmQW10U0srNnNic3BTTGRtdkNsbnJh?=
 =?utf-8?B?SzEzSWtFR0tkaE90U29mckFWUTkxR29FcVdEZ1BXL0k5cmRiTTQzcU13RURQ?=
 =?utf-8?B?WTJkZE94N0dzQVY0c3NkeTJMK2E2S3RxR1I1UFQyNW9wZ3FYb0ZsdXB5eHNs?=
 =?utf-8?B?WktZZ2g0bXNCY2RkUkplVFRmdzF6WDVTOUx2clpwdExkWTZjVlU4WEpEd1dn?=
 =?utf-8?B?SVJ1aWJYUGdxZmo0RnFQQkVxNlMxeWdsaDd1RzhoNWZrM2svUVFtRXA4WWF4?=
 =?utf-8?B?U3NLSU5XZnlMem1jQ0dDcWhVZUFlSTZsYksyRnFFOXdQcWkyV1lkRnk4OGJR?=
 =?utf-8?B?TGtmWUkxT20raVc2M1NLSGhxbDhjTmJMNXlCbTFhWUxQTkRta2tRdFpWYWdT?=
 =?utf-8?B?WFIySTN5UlB0RERMOWZ1Mnpha0FGaCtJMWQrY0RPOXFUSlZ5aHk2ZmpyTG01?=
 =?utf-8?B?ZWNlQUZtRWo3NVhNMzAwbkpuRlNmNlFjUG5IQWdNRWJJR0xNTXBZdW54b0JT?=
 =?utf-8?B?L0FoMGZJOCs1WVdqUDFMTW0wQjBUU1dwZ3JQanBkUnRuSC9KMW1tbGw3TXdM?=
 =?utf-8?B?WHlOS3dyM1Bya2c0QlVMd3k3V21Rd0tiRmZvNFBZd0VMUE54SHQ1RzdjcEVR?=
 =?utf-8?B?L0hFdiszbkdrTDA5WHJqY1RDc2J6RFc0VGNLM0tqS0lzMW5rbUJxb3NGaWRD?=
 =?utf-8?B?K3d0b3NoeFlMRnk3ZS9HbEJ4N0Q1TVAzYXVqSU1VWTBEUU9mdkhQZEUzeEV4?=
 =?utf-8?B?cGV3ZXhqaEEzM0NuZkNRWVkyWGIrNEcySjJUSC9raVorN1Z0cndSUUR2eTBQ?=
 =?utf-8?B?S0Y2T0xEV1FiSmFwMkxOcW1xY2dtcFNKVlhDblF6NmZUazBreWNwOHJ6ZEpJ?=
 =?utf-8?B?L1dBUS9FZnRCVHg5TjZmdEd4WFpmcVJ5Q0Z0UVp1ei83Z0JmaHQxQldWakU5?=
 =?utf-8?B?UnAzcUQwamVoVzdRNDlRd01Ta1NIRHN4dWJrQ09IcklLOXZoSGJzY2xWc2Jz?=
 =?utf-8?B?amFuWERHNXp0eEdoaFB3UVNtdk9KUU45ZitVcFFpMEFvL2xmZ2ZWVFgwUTEy?=
 =?utf-8?B?OWZ4Q3RpWlpIZDJRaWNwZzlsZk51WlZWMi9lcnZieDlKVDJYYWZtUTFvMk9z?=
 =?utf-8?B?ZXdkaFo4cXJ5RmlIZk9ub3dYdmJseHB5cW1kT3hXSVJsMXk4S3hjWkxvNVpV?=
 =?utf-8?B?bi9kU1BaK3NQK2VzNEZLNXNYN3JHYWE4K1E5NVo3R0FHUjJTM2RXenMvUExF?=
 =?utf-8?B?L2NXSjI4bXJCcVVNMEJVKzh4bXFVRXRnUWluOUFUMFZCY1B6ZjUzOUZ5dGpr?=
 =?utf-8?B?VWswdzlLQlVOV05iL2hpWTdrRmVPTUhyc3hhTDNaaktpYmV6alF0ajJjbnZz?=
 =?utf-8?B?bW5FQVI2QkI2dFNrcUdHTDN5ckNGT09RbzZiNFN5eDc5RFU0aTdMOHYrUkl1?=
 =?utf-8?Q?7YVndmseL5YP4+FM=3D?=
X-Exchange-RoutingPolicyChecked: m5mv8NTc2Fy18KcCYgyfoamHzWrCiqcyS86CYlFdpAvARSEDEjqf9QuQ9/xKgslL/wwU20PiOanewP7SJIGNxnrp12QL7/XStxRpWieCUiLLuIeFIZh9oylC3Fh0+FbDWLNs+iySZary2fuLj57L/dLWt7fg1XFrGWu/65KHU3GA100dd6FcJf4oIu8WFHxuDuiO7TkV3zIA7PnNUSDbGPxmnIUyciVfFyYJMX4ArKJ9j2jTG/zyq4YeTRDgCYysExfNNGfqAeMbsIJCcgB5Ki131NR8rDew/vuqKraDiP1EgfDwa4U2BIWvLH3ttNy01+H6KdHjIapQt/Z++tX8ug==
X-MS-Exchange-CrossTenant-Network-Message-Id: 076b306e-2cbb-4a72-6a1d-08df0d7a68ae
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7563.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 07:25:50.5422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/a3OYjS3wu9jFkJ9dBEkNRoYC7Dwwfl4zs2FhuIiuhALr7jmYhPQfk+FPtWSDfZc6jtA3fnVIioZMNiOSVtbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB687348
X-OriginatorOrg: intel.com
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


On 02-09-2026 07:43 pm, Stephen Hemminger wrote:
> On Wed,  2 Sep 2026 11:21:22 +0530
> Rajesh Kumar <rajesh3.kumar@intel.com> wrote:
>
>> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_timestamp_slot_alloc, 26.11)
>> +int
>> +rte_eth_timesync_tx_timestamp_slot_alloc(uint16_t port_id,
>> +					 uint32_t *slot_id)
> Could join to one line, max line line is now 100
Acked. Fixed in v5.
>
>> +{
>> +	struct rte_eth_dev *dev;
>> +
>> +	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
>> +	dev = &rte_eth_devices[port_id];
>> +
>> +	if (slot_id == NULL) {
>> +		RTE_ETHDEV_LOG_LINE(ERR,
>> +			"Cannot allocate ethdev port %u Tx timestamp slot to NULL",
>> +			port_id);
> Minor nit the wording of that error message is awkward.
> Similar problem in other messages.
Acked. Fixed in v5.
>
>> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_slot_dynfield_register, 26.11)
>> +int
>> +rte_eth_timesync_tx_slot_dynfield_register(void)
>> +{
>> +	const struct rte_mbuf_dynfield slot_dynfield = {
>> +		.name  = RTE_ETH_TIMESYNC_TX_SLOT_DYNFIELD_NAME,
>> +		.size  = sizeof(uint32_t),
>> +		.align = alignof(uint32_t),
>> +	};
>> +	uint16_t port_id;
>> +
>> +	if (rte_eth_timesync_tx_slot_dynfield_offset >= 0)
>> +		return 0;
>> +
>> +	rte_eth_timesync_tx_slot_dynfield_offset =
>> +			rte_mbuf_dynfield_register(&slot_dynfield);
>> +	if (rte_eth_timesync_tx_slot_dynfield_offset < 0)
>> +		rte_eth_timesync_tx_slot_dynfield_offset =
>> +				rte_mbuf_dynfield_lookup(
>> +					RTE_ETH_TIMESYNC_TX_SLOT_DYNFIELD_NAME, NULL);
>> +	if (rte_eth_timesync_tx_slot_dynfield_offset < 0)
>> +		return -ENOTSUP;
>> +
>> +	{
>> +		int flag_bit = rte_mbuf_dynflag_register(
>> +			&(const struct rte_mbuf_dynflag){
>> +				.name = RTE_ETH_TIMESYNC_TX_SLOT_DYNFLAG_NAME});
>> +		if (flag_bit < 0)
>> +			flag_bit = rte_mbuf_dynflag_lookup(
>> +				RTE_ETH_TIMESYNC_TX_SLOT_DYNFLAG_NAME, NULL);
>> +		if (flag_bit < 0)
>> +			return -ENOTSUP;
>> +		rte_eth_timesync_tx_slot_dynflag = RTE_BIT64(flag_bit);
>> +	}
> No need for basic block {} here.

Acked. Fixed in v5.

>
>> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_slot_dynfield_unregister, 26.11)
>> +int
>> +rte_eth_timesync_tx_slot_dynfield_unregister(void)
>> +{
>> +	uint16_t port_id;
>> +
>> +	/* Reset cached state without freeing dynamic-field bytes. */
>> +	rte_eth_timesync_tx_slot_dynfield_offset = -1;
>> +	rte_eth_timesync_tx_slot_dynflag = 0;
>> +
>> +	RTE_ETH_FOREACH_VALID_DEV(port_id)
>> +		eth_timesync_tx_slot_info_refresh(port_id);
>> +
>> +	return 0;
>> +}
>> +
> If it always returns 0 why not void.
> Not sure what the point of this function is. It doesn't really do anything.

Acked, removed this function in v5.

>
>> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_timestamp_stamp_mbuf, 26.11)
>> +int
>> +rte_eth_timesync_tx_timestamp_stamp_mbuf(uint16_t port_id,
>> +						 uint32_t slot_id, struct rte_mbuf *m)
>> +{
>> +	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
>> +	if (m == NULL)
>> +		return -EINVAL;
>> +	if (rte_eth_timesync_tx_slot_dynfield_register() != 0)
>> +		return -ENOTSUP;
>> +	*RTE_MBUF_DYNFIELD(m, rte_eth_timesync_tx_slot_dynfield_offset,
>> +			   uint32_t *) = slot_id;
>> +	m->ol_flags |= rte_eth_timesync_tx_slot_dynflag;
>> +	return 0;
>> +}
> This is possibly in data path, use unlikely() here.
Acked. Fixed in v5.
>
>
>> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
>> index ee400b386f..bde391dea4 100644
>> --- a/lib/ethdev/rte_ethdev.h
>> +++ b/lib/ethdev/rte_ethdev.h
>> @@ -5513,6 +5513,19 @@ int rte_eth_timesync_read_rx_timestamp(uint16_t port_id,
>>   /**
>>    * Read an IEEE1588/802.1AS Tx timestamp from an Ethernet device.
>>    *
>> + * This is the legacy Tx timestamp API and is intended for register-based
>> + * timestamp reads. It does not provide per-packet correlation.
>> + *
> Rather than weak guidance which will get ignored and stale.
>    1. Convert all in-tree uses of old API
>    2. Announce deprecation in this release
>    3. Mark legacy API as deprecated

The slot APIs are additive, not a drop-in replacement for 
rte_eth_timesync_read_tx_timestamp(). Existing hardware/PMDs may expose 
only a single TX timestamp latch and cannot implement per-packet slots. 
We will not label or deprecate the existing API in this series. Instead, 
the new capability-query API lets applications select slot-based 
timestamping when supported. Removed the “legacy” wording from the 
existing API documentation.

>
> AI had even more observations (Fable 5.1)
>
>> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_slot_infos, 26.11)
>> +struct rte_eth_timesync_tx_slot_info
>> +rte_eth_timesync_tx_slot_infos[RTE_MAX_ETHPORTS];
> Exporting a RTE_MAX_ETHPORTS sized array from the public header bakes
> build config into ABI. rte_eth_fp_ops lives in ethdev_driver.h, this
> should too; only PMDs read it.
>
> The per-port array also has no per-port content. offset and dynflag are
> process globals; the only per-port part is "caps say PER_PACKET". Put
> the two globals in ethdev_driver.h and let the PMD that implements
> slots check them. Drops the array, the refresh loop, and the forward
> declaration.
>
>> +static void eth_timesync_tx_slot_info_refresh(uint16_t port_id);
> Move the definitions above first use instead.
Acked. this function is dropped in v5.
>
>> +	ret = eth_err(port_id, dev->dev_ops->timesync_enable(dev));
>> +	if (ret == 0)
>> +		eth_timesync_tx_slot_info_refresh(port_id);
> No matching reset in timesync_disable. Info stays stale after disable.
Acked. in v5, eth_timesync_tx_slot_info_refresh itself is dropped 
entirely, we don't need to call in timesync enable/disable
>
>> +int
>> +rte_eth_timesync_tx_timestamp_stamp_mbuf(uint16_t port_id,
>> +						 uint32_t slot_id, struct rte_mbuf *m)
>> +{
>> +	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
>> +	if (m == NULL)
>> +		return -EINVAL;
>> +	if (rte_eth_timesync_tx_slot_dynfield_register() != 0)
>> +		return -ENOTSUP;
> Calling register from the per-packet path is wrong. First call takes
> the mbuf dyn lock and walks every port calling into driver dev_ops.
> Header says "safe for concurrent callers"; it is not, two threads
> racing on first stamp both run registration on plain globals.
>
> port_id is validated but otherwise unused. Stamping a SINGLE_REG port
> succeeds and sets a flag nothing reads. Check the port's slot info,
> return -ENOTSUP if dynflag == 0, and require the app to have called
> register up front (which the doc already says it must, before pool
> create).
Acked. in v5 register is no longer being called from per-packet path.
>
>> +	rte_eth_timesync_tx_slot_dynfield_offset = -1;
>> +	rte_eth_timesync_tx_slot_dynflag = 0;
> Written unlocked, read from Tx datapath on other cores. Also cannot
> free the dynfield. Agree with dropping unregister entirely.
Acked. Droped the unregister entirely in v5.

>
>> + * -ENOTSUP and the PMD TX path falls back to the port-level ptp_tx_index
>> + * (legacy mode) on every port.
> ptp_tx_index is an Intel driver internal. Does not belong in rte_ethdev.h.
>
>> + * The underlying DPDK dynfield bytes are NOT freed — DPDK provides no dynfield
> Non-ASCII dash in source.
Acked. Fixed in v5.
>
>> +typedef int (*eth_timesync_tx_ts_get_caps_t)(struct rte_eth_dev *dev,
> ...
>> +	eth_timesync_tx_ts_get_caps_t timesync_tx_ts_get_capabilities;
> ...
>> +int rte_eth_timesync_tx_timestamp_slot_get_capabilities(uint16_t port_id,
> ...
>> +int rte_eth_timesync_read_tx_timestamp_slot(uint16_t port_id,
> Three spellings of the same op, and the read function breaks the
> rte_eth_timesync_tx_timestamp_slot_* prefix the release note
> advertises. One prefix for all of it, rte_eth_timesync_tx_slot_{caps,
> alloc,read,release,stamp} is shorter and consistent.
>
> Also TX/Tx mixed throughout comments and docs. Tx.

Acked. Fixed in v5.

>
>> +struct rte_eth_timesync_dual_domain_timestamp {
>> +	int64_t adjusted_ns;
>> +	int64_t raw_ns;
>> +	uint32_t valid_mask;
>> +};
> 4 byte tail hole. Fine for experimental, but say so or reorder before
> it goes stable.
Acked. added 4 byte reserved field to fix 4 byte tail hole.
>
>> +++ b/doc/guides/prog_guide/ethdev/timesync.rst
> Lines up to 150+ chars. Doc guideline is one sentence per line. Half
> of this file documents existing clock/Rx API, which is a separate
> patch from the slot feature.

  Acked. Created a separate patch in the series to add documentation for 
existing clock/Rx API


