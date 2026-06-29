Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C09C43327
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 08:35:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49BCB40299;
	Mon, 29 Jun 2026 10:35:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 654DD4021F;
 Mon, 29 Jun 2026 10:35:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782722130; x=1814258130;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=aR0cctTz6s7zZ4ec9ffS+102tXFpyAyqFc19Z9LHyU0=;
 b=bXupIcHKKtBvZfkg/mxJDVd6MN071DbOmlCKkIoj2CM8lKhimhFwF8x3
 6VHsdlwV3Ydw1A7fVINMR8+JzCvnVAyfiAnocaFYKm6O474GfDka0SRh2
 vZqcTfZOQUwNPkrBYgAfOq8FR1w1D2RWijQI0MpRpL9bb9V0ukC7bILmR
 mein+fwSdO3iT/40OvFlQUrs/chbIY3ogIg3vLoXK18Q2ULbvExu/rmes
 pf/tY7JvZZCvIRp2C6kVH7IG7uN3TW6NtIJQchY8M54xx5i6Gtzj71ba4
 aWKiKelkPNecQmPaDbqAFbEHdwpno5x51P7iNoygteyIU1QIw6psJYZnD w==;
X-CSE-ConnectionGUID: sS/ZG0LtSvaLe7LGef4rkw==
X-CSE-MsgGUID: bX6n6YtdQau2udovM25fng==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="94891504"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; d="scan'208";a="94891504"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 01:35:28 -0700
X-CSE-ConnectionGUID: cY+xY4pTQg6c/jsdvKfmpg==
X-CSE-MsgGUID: goLvYPyQRf22WgSP2kuvvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; d="scan'208";a="249271796"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 01:35:27 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 01:35:27 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 01:35:27 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.5) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 29 Jun 2026 01:35:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/WmTE00fJ/Af8gGd8UUejNOyoPoTMAeDz35UtxprTNalv5ULI2Gdk2o+WoivXRxARgfuWaXO4/d1TgOj9hCKmDakZfHqQhZrG/ApeVKIuhwYhH7by24/GkXCrcSKcJedRkn6SceM+WA2+vEZ06ZQgUFahTZj4xkz/IOjZ1jd5luzuaQAd4Gflw3wxStzUMri1t9Ppxc4cBEAJrB4JqAhfYvqddV327cleDD77CPLiwpr/1YVIZTk0oT/zTkjnowfZtUM/5uFS4MST6Y1Nd2sKZqfuloUWoB+tPBnIdGeQGmB9/YRFrF5+6l1xuT5SELfeubbKH8C4kun2tnR+jBCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lotkEfBTmllhQWK+rx2ig2gho3mJWiTXWZYmvZPgib4=;
 b=CJQo2DY9AnqoO1BrnhGmJmWL6Yhg0SQeXErFCnbKtNaeb+TSUM/RAknS5ymrY0Ac60TjMI0pxF287mYC7ivP5dzR2VTadm/qylCxeYnlhPhBO12NwR0ZC9xsfCnQSU9ha3x9RQPgiwCpmluZ/13iCBubQpgjAYr01H4mbUdOii9i1mYk5q0kwzv+NHTOmQSTJ0y/ElkX4heOG//bjnr+kDF2qfD8Gxf25v2Qhyrr3FSP5XBm3SzG5tBvHe7/jJOIfAgCju+QeorMWLwlkcgmnJSHOcXJj4Sx0NNVHAEMqMB1rvirEOeG4hbf27sypL699ZZvCvs+3aSmcyKtKaM7cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 LV8PR11MB8608.namprd11.prod.outlook.com (2603:10b6:408:1f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 08:35:24 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 08:35:24 +0000
Message-ID: <dc3a218b-815b-4d18-838e-c3f463b4391b@intel.com>
Date: Mon, 29 Jun 2026 09:35:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost/crypto: fix segfault
To: Maxime Coquelin <maxime.coquelin@redhat.com>
CC: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>,
 <stable@dpdk.org>, Chenbo Xia <chenbox@nvidia.com>, Jay Zhou
 <jianjay.zhou@huawei.com>, Fan Zhang <fanzhang.oss@gmail.com>
References: <20260624142023.1525497-1-radu.nicolau@intel.com>
 <CAJFAV8wCno0t-oLAtVCmWjvYOdcxGEGohcxOb2JP_W4W3cr7aA@mail.gmail.com>
 <c2920f91-4c4f-4e30-8626-12f2606a20f9@intel.com>
 <CAO55csyCW5nms7=nCzLw9PA0kptGrGQgQARZ1HJEGBu_Ws4CFQ@mail.gmail.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <CAO55csyCW5nms7=nCzLw9PA0kptGrGQgQARZ1HJEGBu_Ws4CFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB8PR06CA0062.eurprd06.prod.outlook.com
 (2603:10a6:10:120::36) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|LV8PR11MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 9158c84c-caf3-46e1-2def-08ded5b95d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|4143699003|56012099006|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /d0xS0MtuQrL/y75IQujNg9tukuLHCFv1A6Ev1HaxH7ur42wpqCA564tDmrh5VMLEnavTXq33xwdK2EjpzbwGkh+iMDN0gnJuGwd0TzVxsQ6otcUCvMtis4lblE+/QG6JiRNoeQSKdYteFrLaIp4hgzz1cBBVm4Ygyt/i5Q7CeiUoIrMfryh43KsLa9gPnCNcgYZnTN/oRG/rrMghzasLpgUYTgKtW1GqSPtYm+ky8miaU4tUtgLw7t4/gHjoibgSwDWx1IK3yes0Bt1Qt/Fy9sLTbn1GP0tazr0lOkQ2UJ7NzpptUyDsd4tTVbMIqUuqcFMZuIDz35oQFVJNqonmOU3GQIT5Jd2v3T86f7swQRvVX5UiOSHYe1RmJPpBM3YgVJCDqeVcSLwmj+kt6+XEqpe++7XcZnDis5svcj++9Y7VOQgEON9plQi76jjcNuiT+IdUKuplZECsZJ2UrC/1Bb2rdv/0fWgRRENdUNUsHImiQldAnNwUUiAMM1vdzNYyrCIkTF4hk0jOcBuxacNRDi221eFyg7JatFFmHYeRAMDdW1y6pGPZtLDH9LuOx8R3aL8GpyMq3TzniNs1JF+gwQ9/JKAoMxvUzceIBg8pTmODQReNGN4XSLnGbEfSgmW3JYu+Cm/dYO9/qMy/V6FkuNY46ufidJ5lwxvw3xfX/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elJiK2JBdnlMb0tDZ0dCRWNiNE9JbmFXTFp3YWhPNkJjZU9vR2hQeFp6VjZh?=
 =?utf-8?B?UTBuQTJsYU5xSFN3bjBkVGFZYjU3akJDSWVzdjk5cU9tYWFrQ09keHFUQ0R6?=
 =?utf-8?B?TG52VldpNDJlanExbFJGdHZEaUVpeTF5aEl4emQza2lMMEk0cXA5Y1V2Z1Jk?=
 =?utf-8?B?RC9JS0sxQ0ZqVmlqWDA0czdqK0VYdGpwaDkyMmFwLzlhYUdtTDJnMEM2SHc3?=
 =?utf-8?B?SnhzczB0RE5oSEc5RTAxMzdQRFM5aFg2OWF3Vk9WM3ZDVkhVRHhZbnFWMndI?=
 =?utf-8?B?MjBtbzRpelJYbzZVU3lKeVBmemxEeEpqTm5CSU9idjdBSVE5VnAzWHNkc1lj?=
 =?utf-8?B?dzU2MUhLNGczR1Y4TWx6Q0pjQ0hBOG5vemFub0t2U3BPR1N3OFQvOVhrS3Uw?=
 =?utf-8?B?bjVCRjdRM1ZUU2FuL3g1SUNVNUU3Z2ZqOGxTSGUyTmkyZzE1TzdsMDJWVU5P?=
 =?utf-8?B?SWRHZHBNbHBXK3dadUNYVVE0S2tmekgvaTMyeDN1QmoxYzhkNDVoSlI1Ym9R?=
 =?utf-8?B?QWlKRm1PR2h5dGlEUVVMV2xpaDEvVHFaRG40eHhFYkZPUDhCVS9MdVlUaHk2?=
 =?utf-8?B?eUZsL2dSaXdETVQyVFVHL0lqbUppQkNXdllKNkdvUjJkb1NWNERUeDNWS2xB?=
 =?utf-8?B?UVRiQ3BEZmJsMGFUdm5OY0xZTTdqVTVyZjJ5UDNldWtzc0dWNHBUSWZBZjVC?=
 =?utf-8?B?ZThzdU1yWFNBQlBNdnFSVFhsdHNkZzRrc3cxSmNCNVdqQUxRT2ZIajRtZVhs?=
 =?utf-8?B?SEFVYXNwMmhBUWhXTzBPQzR4UXZGTTFVd1BSSHN2MWNyaEFaQTVaQmkwL3Mr?=
 =?utf-8?B?WldsL2RlVVNrTnlSV2g3VExTck8rVXJJWUFQMmRRbW1FOTZEa3pPREFnMGZm?=
 =?utf-8?B?SXRwZGJ0Wmpmb01VSmRDVklSTWMzT1hoMS9ndExBTXBYRmtJa3BrWExWVlVk?=
 =?utf-8?B?dGFCUlY0UWQzbnJQcDJqOXZhN3JDMXo3dVpPMElXR1VrbFhyTlZQZE93MHdV?=
 =?utf-8?B?QW0rT3o2MGdQczZqaTlqYnRzL1JaRXVjYzBpNXp6aVZucUJnOHkxdHVYV2JI?=
 =?utf-8?B?ZHhTdmZ6QzBOMVVMZEtuOHpERW96c3hLWlI2VzFTNTE5RXkvTVFIN0E0K1JV?=
 =?utf-8?B?TDVpbVliTXFoRlJtcjE1YXF3aVlCVDBkd3AyempGZ3AvODhodDkzcjlRN2tq?=
 =?utf-8?B?akVKUk9OZnZ2UkhyMklsMEF3TmFMVVpVRVRQekdBaUo1Y01LVGVXQnF5dS9j?=
 =?utf-8?B?cldOWXczVmFrRzBabXQ0VTJUbi9ad2tvck9FZnZLamgrV0g5Sk4weGxLRTlu?=
 =?utf-8?B?blBhMlFRbDIzRVpScGtMNHhDSTBxQ2JNNWpTS29CQ0tpUUZXL2JwVURtMDhZ?=
 =?utf-8?B?cG56MlJ2ZUYzVFRabjdQcVFpMWVNQXdDUWE5VVRSb0ovT2tBNkdqVDZ4OXho?=
 =?utf-8?B?aDVEZ0lLVnJkVi9mWFBERjUzWWtoRnNwU1FWSWdTcTVOdWJxK3J1VG16Qk1k?=
 =?utf-8?B?ZkZpKzNYSUJhZmtzSWljL1BxYjZkdFk5SnRwZ3daNXJ3S2RkU05sNEFUSGVY?=
 =?utf-8?B?eHFDTTFtTE5NcUFOZlArV2hkS1NRaTc2Mk9uMFh0ckpvQnMwSGtPak1VSE4r?=
 =?utf-8?B?aGRWTWRDOEdZeDRjVnQzVjJFTERQWjVvV2dvM2hFakd2dW1ycXk0V3ZzaVFJ?=
 =?utf-8?B?VFhqOWhoTG10RWkrc1hmUGlHcktDSWswNE5TeU1XTy9memVHUDNzZkFYUUht?=
 =?utf-8?B?Y0t2cE5ORW5teXNMYThRKzNNZHhySDNBZ2ExLzFPUzkra2JtZWd2UU9ZQTBX?=
 =?utf-8?B?QUVyTXA5YWdLZmNYSGFkN3NpTm5TSEtMUXNxK0MrUjNMQXRzeHlPbUVYdTVS?=
 =?utf-8?B?Wm9LSEU5Y0g3L0hCTHhNQW9BV3lnL2txQisyZ2FiVk1Ielk0eSt0N2RGa2V3?=
 =?utf-8?B?dDI1SnNJL0hxODJ4dzBaMVJlTUFYTkZSanl3cEpOVTFMUERqcGlseXNvWFhK?=
 =?utf-8?B?cHlNM0o5WmVqVVYwQjFaUzdibkZLbVlKenJkdnFGS0ZNbGtQMjNlMkxYWGFk?=
 =?utf-8?B?V3drdUFLckJiQk1iSWpSWVFxU0ovbThJUnZaUk9Fam51cXNESHYxZEU5V3pB?=
 =?utf-8?B?WXBSNlcrbk9zYzdvVDZJMWFWZFFGb0h4L1VTV2hXWENIY2gxYzY5aDd5bHpi?=
 =?utf-8?B?UzlOU21zMXNYb3Irb0RRZUZZSmJ5S00wbHZPbVRBMm1iWlhZSXB2NzBoeHVi?=
 =?utf-8?B?R2M2bEZJbDRoWEhsRGxENkZIdnBNa3hCM3lZME43L2xIUUdUNTFZMEhKNnU1?=
 =?utf-8?B?VkxsTnpFNXJsU3o2TXd3bjY1QWZJYzBVSlpOTVd4VTRmUjQ0OUFUUT09?=
X-Exchange-RoutingPolicyChecked: FVkTD+qLUiAFieZ0cx/PQPmngjhM5pr27z86EDfpoTrbIZI+x2a8f7x1N1xPXHj0+9mpyvA7GvSPJRHWExLdgEUWfSqCjUA0wRE3oeIX4c7dt5bh2Ed3hfIEmSwQuWoBJjIjKFW7VpDH8PBwSui1x6Kc4VErw4ZYqqS+HdfmEZIRAulaR5s8oLCjmAjE+8yqTJy3QfufpWWGMHcZKmQ8FslGQupx2aDN82pFG6+gwFjAKR/zl8VQd+fOWEU+7fd8H73WngJQ3HAdrEyY1fnm9+NCqKb8pauavS80xkHzeXXcZUC07pbHUUJh8XzAu5y9E1dmJvLjvvyW+x1gyHqy/A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9158c84c-caf3-46e1-2def-08ded5b95d39
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 08:35:24.5067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5EyVjKUvwTnqAJvOtvpwDIBm/x7dNVkTKucwo5VvT9VemcYuweHdQZPIIwSTlAt3tzzWFAFWfYnP6uv5um8qOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8608
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


On 29-Jun-26 9:18 AM, Maxime Coquelin wrote:
> On Fri, Jun 26, 2026 at 10:50 AM Radu Nicolau <radu.nicolau@intel.com> wrote:
>>
>> On 25-Jun-26 1:44 PM, David Marchand wrote:
>>> On Wed, 24 Jun 2026 at 16:21, Radu Nicolau <radu.nicolau@intel.com> wrote:
>>>> Fix potential call with dev->mem uninitialized, one common usecase
>>>> example being running the autotest with more than one device.
>>>>
>>>> Fixes: 3bb595ecd682 ("vhost/crypto: add request handler")
>>>> Cc: stable@dpdk.org
>>>>
>>>> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
>>>> ---
>>>>    lib/vhost/vhost_crypto.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
>>>> index 648e2d731b..3679eaca1e 100644
>>>> --- a/lib/vhost/vhost_crypto.c
>>>> +++ b/lib/vhost/vhost_crypto.c
>>>> @@ -1512,6 +1512,10 @@ vhost_crypto_process_one_req(struct vhost_crypto *vcrypto,
>>>>                   VC_LOG_ERR("Invalid descriptor");
>>>>                   return -1;
>>>>           }
>>>> +       if (unlikely((vc_req->dev->mem) == NULL)) {
>>> (Unneeded extra ())
>>>
>>> It sounds to me that some initialisation failed, or processing happens
>>> without waiting initialisation finished.
>> Indeed calling this function with dev->mem uninitialized is caused by
>> some init/deinit state bug, but I still think we should keep this check
>> in for added safety.
>>
>> I will follow up with a v2 to remove the redundant () and also I will
>> look into fixing the root cause.
> Or maybe this crypto backend is lacking proper protection between
> control and data paths?
> If dev->mem is reset to NULL asynchrously by the control path without
> proper locking, then
> the above fix is not enough. For example, the above check could pass
> and dev->mem be
> reset right after.
100% there is a deeper root cause for this segfault and I'm working to 
find it, but it may take a while. That's why I propose this as a stop 
gap fix, it adds an extra check but of course it doesn't remove the root 
cause.
