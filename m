Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84BAC79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 12:20:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E32B410DC;
	Thu, 10 Sep 2026 14:20:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
 by mails.dpdk.org (Postfix) with ESMTP id 15A8A4028F
 for <dev@dpdk.org>; Thu, 10 Sep 2026 14:20:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789042838; x=1820578838;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LwULPNUIhcUZz6cDZc6al9EKX+3pJ7W2rqoq3xMvG7s=;
 b=RZib4y9t729osfZWtJuhb+GZCJghKUDa6xsmKV5tYV03SUUd5HY5jT+V
 jnv35wf+PvJ3H858euqO5RXHCg8zdfqvhZrIS6JEZWB/UswO95+8AJaiM
 f5sJMZG8uwhvNGJUZcvC8M1Yrk9m5u+6jvoSdXutYpFttz/QqIDIYqPNl
 Do/OUm/nYsed5oUZ4gc2Ep42mpvRI7JOfzlW7LRJntseQgL1TxjBVVpDp
 onII3XN9oZC5fkn/nehSVwTDeZSvd/MQ++p7DcCWpBiiZCgXg4o6VaNgU
 SS2tfCrnzEMhRgudpW13hc+sPjzyHi6IsDhJ58Sxr+dKFmWwF/bwh99MW g==;
X-CSE-ConnectionGUID: khg68tIyQrKQFjQ7cMh8/A==
X-CSE-MsgGUID: FSteYnBmThacPv0FknBs5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="12360"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="12360"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 05:20:37 -0700
X-CSE-ConnectionGUID: V+aHWRYITBac3JVDJJARyA==
X-CSE-MsgGUID: B9mL7wgQSf+KSd1Zu+kw1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; d="scan'208";a="268341714"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 05:20:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 05:20:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 05:20:35 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.23) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 05:20:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3sbSragA2vvdPiemz59dqyq2YtseOblgMcoG2IiIz4XwRQIBO5PgIvMlrleHJdUigvQoV/zCcJiPbbpuU96kLFRnmFr0lBqYy+ATy4VM+9eYIkkUuwe7F59x7nectRlefH8YDZCLzybsixFu9tCdTD7BpnLUhwGivBGGG8ZZeVoOfyl2ntXhiDPsIivbHegmyDhEq6Sw6i/y1Y/k9fUBKvxQJq04RCMhxoBxpvQ0iDX61fPgKr8e1oRB46GQHtuiEBeOY8nVwAAe3alkPj2s4XUnQnD9RbrSJHUIeku8A5cAfSd2CfrvDOnM9jEzAMxJG7PHK5mKYyv9QQFC2SufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpCRy4gYQxvzTDdqV7T32TQHczw3otEliY8lgnCCZCM=;
 b=ZKKmTouw2MG7W3kZN3uNhSMgCcpUVeRV6XCXJH61eMfs+RzEwrbyR10UMtpGfmRhzNS4Qg5M0CpXrUv40afaGYzoezJyyiuOVgnswbM6bR5PWRe69UcMapEg82sX+VvqugIRhSQNf1/5ycAVsNc2F1s7kId8EDMMLBgRJoiwpXyqIJhmZ/Y2/pY4wC/Q7TRZVTsHjZDITimUvd+B51JpXlBuiWuOEccoCw4laD/qDSsDUOIyV5uNc+fAH9DNhHeBK91nPUd3zHeWq4PmI24xzDEi/GPJRntz4PL4K4GcDEmvObZbeSVhMN+o8yF9qtKwhlaFjt9QaHJmiUrCk4xrSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH0PR11MB5111.namprd11.prod.outlook.com (2603:10b6:510:3c::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.7; Thu, 10 Sep 2026 12:20:33 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 12:20:33 +0000
Message-ID: <632cdb2b-3df4-47f0-9405-5a164bd82dd6@intel.com>
Date: Thu, 10 Sep 2026 14:20:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] net/iavf: accept up to 32k unicast MAC addresses
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260904122804.2256481-1-david.marchand@redhat.com>
 <115329f1-ef86-4330-a198-2471cf3d69f5@intel.com>
Content-Language: en-US
In-Reply-To: <115329f1-ef86-4330-a198-2471cf3d69f5@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::14) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH0PR11MB5111:EE_
X-MS-Office365-Filtering-Correlation-Id: 963fbd48-6d6b-48ce-cf4e-08df0f35e95c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|4143699003|22082099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: I05ZhkCIbLbwNG7iZ0hmbjUUR0/ekPFwXvaiW31axp24EtK2TB3bLrmDXG/t18+iqL1BBxQqJryve/6USXYjBxE5GnXOpTN1cjC5Qh80/NeL3fyhQ6fcd0UgFpl1YRSkyepz0hajXuFIa0mQDKuynBmLroR8w2/qK9FSwUCT+j1EXwP8BgiYugo2LmpwJEpXdUo2yaovzvB023+6tmQwpNFTYIbNWaqgGCRCyHxkk5ovyeOKHWgvC4utLZDz60iVgKIcQa1ky2e8tdr9SRoHmm4zXqJyeerIK0pAPTwFc8A8Cx6gtwysPBrZQtLT5cxUxjkkAzxZdJ1u1t0y/Pt7UOQCuT1+wUT/VOCP8IYK7qp8Pv2RIav3DlCnIsTOaa0NVLV6dgIgdH4OeotWvQgUe+jd1p+1SyTZkrFo4NJY4GONVCGKgskuiQ5LzAjWIXtvLndMvLLycByl9zYUs4TdmrTMkt2esOfTnlQA2BsJ8c1wuLTW1rILEEx8Gv2sF4d2eWbCf5fuC8P3vh5UIybIqcz9qjV4Xt4IvNbjxRH7nHMx1Gfy5acnTv9Ro6r7j40sH4FqTdxFnP4GhEBm+Vy5fLH8bcXI7XcLwxqPPyhFcXFpiOKrKc6aeBTvOiRw8xM0dSEdyEtQ3AQ5GTQNoDx8Lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(4143699003)(22082099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3J0dDhNWkZTUWhUMG1McEUwV2tWKytYdDllRnBQejJ6UytqV0d0cnVJWVlJ?=
 =?utf-8?B?ZUZlNVgvQ0lHdGp3ZTZQZXhGbnRvcHMzY2hBeittYjA5S1FrRmFtOXVOY0ty?=
 =?utf-8?B?SjlZbDQzTzRLcTZpY0YvRHJRckFxaWI4Mm9jNzg4OFRjM2U1Rk5KUU9HNnlG?=
 =?utf-8?B?WTBCWG5IaEdWY1VMVzRjMU5GZEhSN2JyMHRZK29jeWIyUHJFUk56am85NUFQ?=
 =?utf-8?B?eFg0MDRwWGgxZzJlRmhZLzhDZ0Z6SnZOUnVQMDl4NXZ2NGJONHc4ME54bDBt?=
 =?utf-8?B?T3RteTNRRFNDUkt2Y2NvRytJclkyRkJaMFdyUmxvZTUzMXpxYitqSS9ZZEd1?=
 =?utf-8?B?dzJoTjVwa3FIUDFybnZiQkYyY2dDTDFKZlM4aXF1ZWVqNEFqRUJlZzlYMXFO?=
 =?utf-8?B?T2pvMUNOQ1pybEJmWkZKZE05ZEVIalhEVXljS0JlWnlPMUFpRG91aFU1Q1NH?=
 =?utf-8?B?aTNFc2hya3dNN0Q2TXY1OHVhN3ZKYnR5UjhXOVRlWmo1aVlSNWlzbjlQbjQz?=
 =?utf-8?B?QnZ6eFM5OWF0SUh1L294Njdzcyt3RlFoS3kzNkZGbVRuZ0o2OUx2NDRJeENt?=
 =?utf-8?B?Q1YxMDdHM2U1OWp3dlcyekhZcTdpSzNTQjVMM2pHRUl3U2xJVktBbE5LMCtN?=
 =?utf-8?B?U2RoRFhhZHdyQzZtdFg0cmdnYXcrUmZFV1VCcHcyRi9EMnJwNi94dFJOWlE1?=
 =?utf-8?B?a0JuRXlvc3A1NHdsRjZ3Y0JaMFNsYXd2N1Z2RFJqallPaGRCeVA4Q05XL3BL?=
 =?utf-8?B?azRoVS9BMFFxMGQ2dTBHV2c2SmMrZHpkbjZBQndtWDVjb2Y5LzVyYlJzZmkv?=
 =?utf-8?B?VkJubHg2bWZHdWdsajhIajZBRHZXdEZFQ1I3SHJLN3F4aXZGWXBMTTZhaHR4?=
 =?utf-8?B?NUQraFYyUkxBS09tV1hvdnJFUzREMHV5V3JlbEZBUTgyZW9hVUNxd05CUUJW?=
 =?utf-8?B?TTJsbWsyQ0lySGp0Mkd1MFVtemcraUc1bEExODRaK1hlZ0dQQ0xuM2xFQU94?=
 =?utf-8?B?b005OHVIYTVlVnNQQmJmQzNHaUFiS1N6QVhhT1hVRXgrY2xzTkxEOEgzcUFI?=
 =?utf-8?B?blQ0dENMSWtDdFdXbUJTQkttL0NhYVdYM1o2Z1g5SllvYlNiNm9rTHJvMHRF?=
 =?utf-8?B?eW5zb1pFc0M2U09WelMvQ2hpblJ0OTV3VUJ3S1BlS0Fva3JwemEyYVdjSlpJ?=
 =?utf-8?B?WWVtb2NYQlFjTHRoYVZtVlZuUk51QVJXcmVRZ0JWSHZzZTZ2UDRjeWtTZjVv?=
 =?utf-8?B?KzZ5dkUrcVFRUnl4WlZpd1VIcnUrWGpsVU9kdE5VWHVFWVFXWjVTUlQ0akRv?=
 =?utf-8?B?OU5VSWJLY0Z0aU8raXJnRnlCQ0VnUVBKVmNUOEppRlZ5emxXT3NITkxUbWN4?=
 =?utf-8?B?cjNld0JsN3F4QVVXL0Uzd2FCbi93VFFLYjlIell1WTJMYjRiWm84eDNCRUt0?=
 =?utf-8?B?N3ljWE12UHVnYlRvU0thRjVGUzhDNXM4dGttQm42QS94SGNwYkNFS3dnSWw4?=
 =?utf-8?B?L0JvQUo2cmNYa201OWk2ckpRVkdDTG9NVzBVU2ZqdHU5Y3FxWENMK1l4MUlP?=
 =?utf-8?B?RmI5UnlsZ1BFOTJPU2Jqb0NTUUM5SDJBeXhTMGhYWnZKaSsrT0F5aWErTUVz?=
 =?utf-8?B?bS9TRm1wL2k5V0RRa3oybld2cDVnQ0kxU0pUNEFHSXpLbHVWMkxYSk5sZUp5?=
 =?utf-8?B?RzMzdDVkMm5xUzNadHNQcEVtUTQyQ0VxQVRnb2I2dndjNlVRbFRNYUN3NDVN?=
 =?utf-8?B?YjV6RnJlU05OZ1Q2OHgweXhjMDYxTkdMT3UxYzZtQWRNMFlkUUoxY05sU1hF?=
 =?utf-8?B?ZUV3M2U4ellmOStSTlAvWHo2YjErMmlaTzR1QmNpTmlScUZKcGFneklsWks5?=
 =?utf-8?B?RDFPSmFNVjZFSTlGRlZqSGx3YytNYk42Smo3N09lUW9QSG1BWkxJRFlkdHBJ?=
 =?utf-8?B?VFNtSWtHOGtxaUxPSExRZWs1YjZWOGFxeEVFNXA5MkphKzFGVTFuTEF4TStX?=
 =?utf-8?B?MWwxa0JjWmhRWGs4RElxdzViQU1HbmJvcTRmTWhKczV1NmNsYTRxSC9oa3FP?=
 =?utf-8?B?RzZ2VER3ZWFTYUZMMVdZQWUyOWpNS1FndjRQYmRUdjlOYUdibnlQd2MyVXll?=
 =?utf-8?B?cmdwU1dJWUp5NTNrbm1kZUUrZDlPUDhEbThSS3RxZzVKbmJlZG5sNGQ2VHdl?=
 =?utf-8?B?NkpvZndEQVJ5c3NneDl5TE5jYVlNNU9WY29rSGI4Tlc0U014Yk5aYkJxbktQ?=
 =?utf-8?B?eHR6M1Awc3dGT3cycFVFZDZ2NFRNcXZsNzcrSDlqSkxzTmUvZnF6L0ZrWVVj?=
 =?utf-8?B?N1FqSWQ0ZGlaVWUzNG43ZVN6S2ptRXNVZmlNeVZrWVhad2V4T2E2TkJOaUxX?=
 =?utf-8?Q?uRfFdfJdbfFI/h0Y=3D?=
X-Exchange-RoutingPolicyChecked: arA8tTL/JgH4CHrCs1Fb6B1jwa3gxUFWpvVc3NCCymeXmI0gt798wUTilql0+MYH9V+oi03vaIOLsloHbe2VXat+C2s7hP+LQ7sfbTOu6kiTHAPEieRy19i518ngYFvDaEf+iGBRMNfPcIfAM7rQN/VJxUYsPOMfj3Mcc10h8pIrAgNAsSqBbQrfxWAg6Q7vptCCNedoPDLXkA5X86dPdzjb81JMb0dK5L6iTaWNbdzZsyW7we44wBEnhRbD5SsgU6yR2nLgk8/dCSX5fkWipHuZOZOly1flSSeROebW85PkoUwiRD5D1WYNmbENwABD7W8087/LoTIcqR3wqsS3dw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 963fbd48-6d6b-48ce-cf4e-08df0f35e95c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 12:20:33.3963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvNjQJrR6dOO+A+UID2bt0/1B/pHcXZ7tiN11YJ1waOYv26igoqcmD36//2j4aq4NVUJhpg3PP1lPN4jM93++f/ZAegg7k/Qkn+y632pnpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5111
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

On 9/10/2026 2:13 PM, Burakov, Anatoly wrote:
> On 9/4/2026 2:28 PM, David Marchand wrote:
>> E810 hardware provides 32k switch lookups.
>> Thanks to this, it is possible to allow a lot more secondary mac
>> addresses than what is possible today.
>>
>> In practice, the maximum number of macs available per port may be lower
>> and depends on usage by other (trusted?) VFs on the same PF.
>> There is no way to figure out this limit but to try adding a mac address
>> and get an error from the PF driver.
>>
>> Mailbox exchanges are limited to IAVF_AQ_BUF_SZ, segment messages
>> accordingly.
>>
>> Signed-off-by: David Marchand <david.marchand@redhat.com>
>> ---
> 
> On another note, I don't think this is even compatible with ethdev API.
> 
> In `ethdev_driver.h`:
> 
> struct __rte_cache_aligned rte_eth_dev_data {
>      ...
>      /**
>       * Device Ethernet link addresses.
>       * All entries are unique.
>       * The first entry (index zero) is the default address.
>       */
>      struct rte_ether_addr *mac_addrs;
>      /** Bitmap associating MAC addresses to pools */
>      uint64_t mac_pool_sel[RTE_ETH_NUM_RECEIVE_MAC_ADDR];
>      ...
> }
> 
> example of this bitmap in rte_eth_dev_mac_addr_remove:
> 
>      /* Update NIC */
>      dev->dev_ops->mac_addr_remove(dev, index);
> 
>      /* Update address in NIC data structure */
>      rte_ether_addr_copy(&null_mac_addr, &dev->data->mac_addrs[index]);
> 
>      /* reset pool bitmap */
>      dev->data->mac_pool_sel[index] = 0;
> 
>      rte_ethdev_trace_mac_addr_remove(port_id, addr);
> 
> meaning, the mac_addrs array and the mac_pool_sel have the same 
> limitation because they are indexed by the same index.
> 
> RTE_ETH_NUM_RECEIVE_MAC_ADDR is defined as 128, so correct me if I'm 
> wrong here, but according to ethdev API one cannot have more than 128 
> MAC addresses?
> 

I would even go as far as to suggest that ethdev API should probably 
check max MAC addrs number to make sure it doesn't exceed the size of 
RTE_ETH_NUM_RECEIVE_MAC_ADDR, because otherwise that's a latent 
potential buffer overrun?

-- 
Thanks,
Anatoly
