Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD05CC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:02:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A875D4027C;
	Thu, 15 Oct 2026 16:02:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id EDA5B4025A
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:02:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792072926; x=1823608926;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CG4H/7IRTquICA4YZZAnhQtFdQOGl5s2o/6MYrUcUzs=;
 b=CNhWCRZAXN9pzTQQ9+nYMIkOhw9wNIie5BbLcgUwtFOpLrM/hGcrxh6P
 O/S9AV04KqDqSQjmCkI8OAJFAnast5m+mhYz+J4Kxu8kURAD31mj2w6q+
 JigOPM1xWpLwxiUP13mNuwnJrLlyqfToQd2vhjndDjBBq7u2G3HKu3l/B
 KJI7NeNql0/DLIpLcePMbuPxJX8vXYeuv+57VBo3pkfjnLuGU3+KJIMQO
 ROvYd8RF/8w/RmwCXp2miSyZU5qlxhYUD8R6gQQwSYPG0GMi/Rq8FyzV3
 q0Cnb7OnOBrJnUaQBSQKw6pz9AgpgvZfVsGfeE1hkRr5cfwrONLPH9NAn g==;
X-CSE-ConnectionGUID: scARb/VLTxW0xEIYQurQEw==
X-CSE-MsgGUID: qljros1WTRCj0L4J9dHHNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="853253"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="853253"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:02:04 -0700
X-CSE-ConnectionGUID: +/AdMekvRJCr80weix8YOQ==
X-CSE-MsgGUID: fgev098uQjKtQ2hSG97ZmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="3453181"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:02:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:02:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 07:02:03 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.44)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:02:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0yCQqlq2z0VXuGg9QXjo8UNZP3NpRXTb7Q/IAwCsiEWKxhpjgqzyclKnZZj435wPQXwwd/7yYLFO23MzgPveUr+A23u+fYMkFzZ612AnyxsG9aPIrWhHApFjCmUZguXwRN6dM5CsBzRBiUdxhICJ1e8TkqHCoZ6j9DZeyAMNMapZAo84vnYXgXdzH2kGE1/5rzIRzR9U3vcwvHs0KuxyNcIfilCOVcuazXG3ZZ+ZJLtUOd1TdPNJjWSTPVqtuI5ER/ixmAaKRaGzW3fC/UY3w+yxJS1JKpwHj0wPmKg0EEC994OP4hKBUhtTLk8vgMJCdsaTp4gAFsH15hhDQ0UUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onWr7d2/TKg4DVp8rJNfZwKl/hS38niPox6LTpHGKpE=;
 b=mtfx3SdXuvVgVkjpWh7q9JnLhsE0WccgK1EsO4mQtz6S8qG8pKsKC75aq7mOz3dr+2xs4cV+y2yNCRgFHG6xEoENcRMsoKGYOlIYxttOcg7DdtW92ylE71LB79wE5j2ValGBPkFLXgedTt3D9e80P6zNxpN5rtWaza4hojCh2NkE36Q8CfCWnSTUhn127seJOCDinYzQX58miInaO93Y42MOBo+JUKcMCC3aySRzCdcmOByPOYbGlflQV4oZlPeiIosNU9zdWBxoHVemIPd/8VUSjeFEtB7y8iDhfjhc9QSpNlGMB6G2gM+3yRgiRO6cNWQsumLixzyzlTiPXMW6mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DSVPR11MB9743.namprd11.prod.outlook.com (2603:10b6:8:34d::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.23; Thu, 15 Oct 2026 14:02:01 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 14:02:01 +0000
Message-ID: <ba06909d-a0a4-4cc7-9d98-dff5f8a148b5@intel.com>
Date: Thu, 15 Oct 2026 16:01:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ixgbe: avoid private driver include in testpmd
To: Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>
References: <20261014203435.583064-1-thomas@monjalon.net>
 <CAJFAV8zqXgiwAghLZgR4Ha0dnvwtf9puECJpmv57N2zTE2dMxQ@mail.gmail.com>
 <395f7d87-087c-4da6-908c-e9f569a7ea04@intel.com>
 <RcoKQBVWTYKPV4WELHVFcA@monjalon.net>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <RcoKQBVWTYKPV4WELHVFcA@monjalon.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::22) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DSVPR11MB9743:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd011a6-bf63-4060-63ad-08df2ac4e244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: l65tiewz1fk6YE8wSai4QxnlV/iat0QrkvbhEk8DGDV+pkZJQZ/stkq63LQWd2JKuaAK43rngaKWgBwuYWKKvS8AmgzEmeIqnMsWrmbc4JM54Q3otJz1arNqK3rs08j+YF6ahLHmINutDbMJgLLlk0EyCeh7RbsR/Tp0tUn3yQ3o6T3eCGI6hYKxPAgXIKWrSr1iykuWJ14fjl0OazZ+9J0RMBzC7VDxxAX7FAL8NFnNUuL72dW3Rtdy03t7NYXEBg0uO6WG3y5OOWYOgRRwlqoo3MkopxYJEM9MSXds/QmLAfNd/zWIZ8H3glx14aBnnD1rnLhMF3W9NGZx7rkiBA56dIzMODKkP5kvOkasHkvhDMi621Hx560qH/SiGaG4kMPdKrNMRTeDOyxDR3sf98PLth0FfW24Iw4sPPGAu1/RnaKm1qge6PAKuEFetTUCM72pVdTWxXLwKDQGvJ5uKZqagnxJDn7ulD+CCK4nyFxXLI5gragv6CQOoQyhA9x3jk00hlcCm1wvDt5oZALmr76dpYN8+LbP47U9TRYouHHt7cAn6Rquz6zN7LDV/5alq/B1JIVJp7AHOe7O1keltHcT2cE2YIRWlAdHE9kS9xWMlgJcosElF8TWjkhJlE9piMUA5Zkiocq/bL+fUP7otYfkuDIOAXD9amnCygs4izE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFpiSUh3c0c5MVNHVzZidVFrU1grU1p3TnZ0SlZiN3hLQ0psVTZqQ2dzUWtT?=
 =?utf-8?B?S3RNTTVUMXM4ZnlVOFZEU2dDWXdjS3ZZd0U2cENjN1R0dnZMSnpEYy92eWow?=
 =?utf-8?B?eTRESExGemdBdkhLcldBUlBDU2szbThVblArNXpvR3RxaEZ5Z1J2SU1sNjZR?=
 =?utf-8?B?WVVoOWs3MzJzMGl5akVUem5BWWFocStSeTZJSWZ5dlJ5Qi9PaFpkV3kyUVN4?=
 =?utf-8?B?MUFzTVFqQ245a0hKWXdteDBGR3NPOHh3ejlaVFdpNkRmenliZ1VRME04NGls?=
 =?utf-8?B?L3EzeVlick9mM1R5TVlOOGI4TWZQSlVodDJ0ekZjdzVUbnFFTElmM29pR2lJ?=
 =?utf-8?B?RkdHcGthM1d2L1prcVlBNGo0VzQyejRlSVpSc1RrY1owMGoyeVFUMjlmZWpk?=
 =?utf-8?B?Y0k0MDNlRGNDR3ZxL0ZibDkrNmVJMXZHNkR0NmxxVGN4NUY5bDg5dVpZaURP?=
 =?utf-8?B?Vm82SnNQUkpldzZ4REo2c20xdnFNWXhXMUE0enk2SnhPdStrTUxMcXlwZnYw?=
 =?utf-8?B?MmZRd2VHNW8rNGtVNGRPZUJ1eExIL1Fqcy90RU95ZnRRbkUzMFIzT3RzQVhC?=
 =?utf-8?B?VTVZM0MxSElDNG1IOE5hYVdCMi9YNFlQOHExS1hTajN1TkFna0lZNlhPRUs4?=
 =?utf-8?B?MHlOS1NINDNiUXVKN25HUGdtenNEMFlvd2QzSlBsTGFnM3hlRDZyNVZZaWh5?=
 =?utf-8?B?OGNQQ3dDUXdOUVJSS2UyK1dYT1JsdGZxc0dWYlhjMGRHcjYyR1p1OCtsVkJC?=
 =?utf-8?B?SWxBV2V0aDE2R1dodjl0YUQvamZVajBBZXluc0x4Zm1mT2s2ZFhsVFA0c2FJ?=
 =?utf-8?B?aXF3NDlwTjc3QndoMWhpbkphRkROSlFUT3RTcTVuQ1l5Yi9TQkN5c3pMWVFM?=
 =?utf-8?B?MU9hTnpERGd2VXRHVi83eUFBemQyb1EwQy9TV3B6NmJMNnU5a0xDVmhkM3ds?=
 =?utf-8?B?a1g5N25uNHBxMVFQUE4xL01SY2ZwQkFSUm94TmE5VHdvSXdyaGZpc2prSDVZ?=
 =?utf-8?B?MVVuM1lRaXlDUGQ2YUpkbGkrRm04UllhNDdTM1FlUEZHTTJXSmJqOGYwS1Q2?=
 =?utf-8?B?TDNMU3dLckpuYkpoemJYa1JMTURaVFUxZkxYZ3o4UTUvSG5CZG1XWnBnV3ow?=
 =?utf-8?B?Wk1jaDVsTTUwTENlMjVTMHJLc2M1UXhrdEREanlyd25JWVhiTVFJWE4yTEpQ?=
 =?utf-8?B?cmZFTUE2MTRzM1grYVliQmxDakJxdHR3Ym1sL2JVZlN3M1cwNVJqdHRwejhl?=
 =?utf-8?B?WWpUU2lJUUNoeUt4dnlVbXVvM3U2QW96SzFTSlZPUTY0aXJHeVptZVdkRWZE?=
 =?utf-8?B?SWMwbGJrTEtKNVdRbDJSdEd5MDBtbjhBRWdIWmpwUE5tWUw1aUFGbHJDMFdY?=
 =?utf-8?B?cXhmRHZKcWNCS0dacFhHSDJNSXhLR1pNWXRTWU4waGFNeEJkOFhJOUlnMmFL?=
 =?utf-8?B?Ly9uR1dqVU85UmsyZkQ1d3BwQllWN3hMaEVCL1p2eWwrOXl0ZnEvelhiY2Y0?=
 =?utf-8?B?Y1IyMTZ0Q0wwQk5IK2ZyRnhTcFJkMTYvUHNGWHRtN3BCaHJJT2dKdEo0a3NO?=
 =?utf-8?B?T3hIVlg3Q0llR01VRHBtb2xDSkhhZ3dPcnJEMGZyUGV0L0loUkxNVHRuekhY?=
 =?utf-8?B?SmI5TFdYL0VaQ0dYSWwzbm5oblVZQmJwSSs3WG5TaTYrNHdNWDJ4ZUlwTkIr?=
 =?utf-8?B?ZzFsYWpQKzZIamxYdUZVZXo2aGYweDNiQWozZEw2ZCtQb1ZCdTlVYStyRm9z?=
 =?utf-8?B?aGp5OWVWUXIwem9NUnVzVDY2ajdkYjN3QmtnWGsycDF4ZlJCbzhzK2hoS2FJ?=
 =?utf-8?B?K1ZUOWlQck52WWRtd0J6RzRxSDBGZVd4STR0blcrUjRGRXhvV0JwWmN2TEsw?=
 =?utf-8?B?b0VNckZYd3NRUG5UN0plcmNKbVRBUkhpMFFKTU41eDNzWDAzMDlNODY2V2lL?=
 =?utf-8?B?UDZKK2F5REwrZk85SHJjYkE3MkF2V2dWenE0RnkzcXpRNWtBNGdVbnc3Wkxs?=
 =?utf-8?B?TjJUZG82aUpBOEw4MmlXQTVGb3EyNXp3TStDWnlPaWs1eHhBTnpneHpUZldq?=
 =?utf-8?B?M3gxdzEzdTc5T0ZvRk5hQVVmd0dzV2htcDhyTEV0Z2pSRE1SK2tZR1doZmkr?=
 =?utf-8?B?anE0Tzk4YzZmWnI4OGlqWHlCMFN6cVlXQklVclJNSzNORlVLa085QlNNYy95?=
 =?utf-8?B?OTkzWTBQczlVdG9XWFlPWEJ1U1Y4M0VkdloyNTVIaWFuR284N21td2JlRWkv?=
 =?utf-8?B?WDRpdVVHR3dIYVBNQVVMc0FYOGRrTXBJRmhBVkJuY3R3MXJucG5iVG1NNENF?=
 =?utf-8?B?YzBvRy9XZXBkSFY1bjVFRDlzekltSzNabkVLcnpmRFBTMDY2TytRQ1NEcnlO?=
 =?utf-8?Q?mpKhbrEE43GV88og=3D?=
X-Exchange-RoutingPolicyChecked: oxD8MYwrHeFZCT4YlNY9yuz80v8L6IhMT26Yk9G0HFmzhsnnc1FLQYbzA6QfxDonU6k04ECiqeWdT8byI7Ii93uCSkHtjTY+E1BskWBlIjlbsfviY1bCxzNDui7o8XH5wndpzIL4tQZloFnS8djvhAl7bIJ7lrrbhbUppis7R94Vewjvzqnx7hnpm2XR23WLTd4Scy0VxwJTnGYFJTFsEQpzP5ZH7Tpx1fRiVu3LqjixAuOtjSI01Wir7nVlY+XKIe61bdtZIU1YkixpugytEpmVcWOzZGU428bxB88P49kkym3DAP612rTT44/S4+5w4TKswE1FsbgwX3ehrLxU0Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd011a6-bf63-4060-63ad-08df2ac4e244
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:02:01.0428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x83bm7sixl9YwyDk5SAnjqikGwccLmKMq/D7KQ7kFDCvEHpvW4sZrzQMPjb0ZVd/+RDf55o1/s8QtPw78JCAeeNEeL6R5BmLJbRSdEKvUCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9743
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

On 10/15/2026 1:50 PM, Thomas Monjalon wrote:
> 15/10/2026 13:21, Burakov, Anatoly:
>> On 10/15/2026 1:18 PM, David Marchand wrote:
>>> On Thu, 15 Oct 2026 at 12:41, Burakov, Anatoly
>>> <anatoly.burakov@intel.com> wrote:
>>>>
>>>> On 10/15/2026 11:13 AM, Thomas Monjalon wrote:
>>>>> 15/10/2026 10:53, Burakov, Anatoly:
>>>>>> On 10/14/2026 10:34 PM, Thomas Monjalon wrote:
>>>>>>> Testpmd commands should use the driver's public API
>>>>>>> rather than access its private structures directly.
>>>>>>> Note: ixgbe_testpmd.c should be considered as part of testpmd.
>>>>>>>
>>>>>>> ixgbe_testpmd.c includes ixgbe_ethdev.h only to check whether bypass
>>>>>>> operations are available through the private adapter structure.
>>>>>>>
>>>>>>> Rely on the public bypass API to check availability
>>>>>>> and handle -ENOTSUP in the commands.
>>>>>>> Remove ixgbe_ethdev.h, ethdev_driver.h
>>>>>>> and the now unnecessary RTE_LIBRTE_IXGBE_BYPASS definition.
>>>>>>>
>>>>>>> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
>>>>>>> ---
>>>>>>
>>>>>> Reviewed-by: Anatoly Burakov <anatoly.burakov@intel.com>
>>>>>
>>>>> I forgot to say it is mostly written by AI.
>>>>> I didn't review it myself.
>>>>> Please double check.
>>>>
>>>> It doesn't look wrong to me, testpmd code should not be using
>>>> driver-internal things anyway except through pmd-specific API, which is
>>>> what this patch does.
>>>
>>> On the principle, this looks good indeed.
>>>
>>> My fault for just moving the code around, without considering the used APIs.
>>> And there are probably similar issues in some other drivers _testpmd.c
>>> files (at least net/ice seems to include ice_ethdev.h).
>>
>> My guess is this doesn't blow up on ice because it is not using the
>> graph helper yet. I'll see about fixing our other drivers.
> 
> Please could you make it as a v2 of this series?

Sure. patches already submitted but I'll respin with this one included.

(I also took the liberty of checking if other drivers have this problem, 
and no, only ours do)

-- 
Thanks,
Anatoly
