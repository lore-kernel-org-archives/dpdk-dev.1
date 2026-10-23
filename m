Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0614B606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ihDGivsH
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1033540268;
	Fri, 23 Oct 2026 16:37:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 968C840265
 for <dev@dpdk.org>; Fri, 23 Oct 2026 16:37:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792766243; x=1824302243;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wn0iWQQZIBBzR2c5alAozgfW8KjiWbwH7oEk0972SUs=;
 b=ihDGivsHFKdGp196S872XfDL740GVvkibuJzXRIQPKJvwcMk3PWAkzfp
 BZRBnwfoBYpaCpyxJYAhrrUwSTc8k8+JedUOsIgrDxgydwedhn7AHCkjr
 mXFd2oW9kMHw0b/QK+8N+Obel5o6lI2ERVxrySZACtG8y+x3Pg6mhYEGv
 paxIIocxJsZVHlR4v9THgXJpPUQMvlN5Q9/RquvTVo2LrObCdG40vjpe1
 71Up/CPySVIA/af3CZXdQE38zg2bctRgN3nWLqLaPLww7bGNmnV8RtY/k
 bAtskmpQRsPjiTPEW5v5mvkATBncai7AunXHKO66lLx1BrJ5YRTPkmI9T A==;
X-CSE-ConnectionGUID: WrnxswB8Q+SMKHAn6LDV+Q==
X-CSE-MsgGUID: 9zGzExoZSPixW4ZhLB835Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1541665"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1541665"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 07:37:22 -0700
X-CSE-ConnectionGUID: NtdR8tKmSS2aoX0PXIFT8Q==
X-CSE-MsgGUID: nTIFx80nSz6HXsyfbe8+Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3978769"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 07:37:23 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 07:37:21 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 23 Oct 2026 07:37:21 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.60) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 07:37:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogKiujXc/VSpxZ9BF45a5cbrA2+P7J6OCCXeeCZ5/uwxZg/iNuYdUj+rh9ZfA84mIIOh+hua+IelfDVDn7Xogy6yCImW4WVD8psKq1N/eHUpctB+SvdPAosgSoK4xfI5h3sXWTrov9nSZ0Lr/UTuUEx7XJRP2zlSK9cqY6LQyj6xeJNhOCtIcc3dfkqP/hayKgXi+Yw2mxjupVIEAKQTCwDAvocHrxTRX8VlCybTRZ+8+3GfBC7ufhU94GXSjT8BqT/uIEL82TMnj0Ss2ObekjeR680L146ZNGMhwvLB7tPPiOPiBGlgydBfjd/HKZfbKrM0dbxze0B02gBDZrf1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4zJhuTUswswJgcCruCopW4DkH/xAVdJ1oWQEc4TAUI=;
 b=Tx5LJDfJgKKx+d450HqsDh0faHqlNzEGIwmoAwAfbMjD0tJ3TlM0JKtjBcuy485yU+WqOSb28+MFAX7PcnNSm1InFHdNVkYW42Xw8In+WFZ0NJsSBkJHgKsohWZFL0m/CZrNqCkjpKZC0M/Kf6/Y913MrW9lYMrZm5NK9VIKJJ4rsTFWwKyoegFVVKWSm6jElTAnQ1CFfmO7E1k0CyQudFyH7RgNQ+kZIidYTpKKnx1o5zJXnL97AqJ6o/urUd3Fd9XdplixrcNBf3cizXIvK22bMQL3/L1th1idzriDJfeA3lPP4+cBW5k8hDi0AjCCZdzDWxrL9s0/Xzn6u7c8TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA2PR11MB4923.namprd11.prod.outlook.com (2603:10b6:806:fa::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.13; Fri, 23 Oct 2026 14:36:42 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0522.017; Fri, 23 Oct 2026
 14:36:41 +0000
Message-ID: <0615fe20-ce56-4ce8-a7d6-be46f741949e@intel.com>
Date: Fri, 23 Oct 2026 16:36:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] interrupts: fix event arrays copy on instance
 duplication
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Harman Kalra <hkalra@marvell.com>, Ray Kinsella
 <mdr@ashroe.eu>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
References: <5766e02ea3243de1f63eb68efc210719f11815b6.1792763492.git.anatoly.burakov@intel.com>
 <8e863c1aa5d265fa27560dd27ba61858c217ff3d.1792763492.git.anatoly.burakov@intel.com>
 <CAJFAV8yi8VxCz8kyuw=Qz155KPzWw2OPGMPJ0nRH+HhBFTMHsw@mail.gmail.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <CAJFAV8yi8VxCz8kyuw=Qz155KPzWw2OPGMPJ0nRH+HhBFTMHsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR01CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::28) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA2PR11MB4923:EE_
X-MS-Office365-Filtering-Correlation-Id: 57acff2c-4a2f-4057-f6d6-08df31130dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: R/g1HbmXJ8Z1KCBr/gmVHfxbmQ9biKjbaRtdIOK5LHHFcCW4BkF0avCq+mGblYC3pNq21vPU8q5dEY1lipoIB4PkEdhyvr82QFjuczxuZPWcBwkaIQcfaJHPtYskbefV55PNA6QroTUZLdyOcWSgCFlXhqezC6lRYdLgRGe1ih12g/qu6+hDurC3xqJvpxrgpBv4WjvAhRV35U4rvrGnFbcIS1KXY/7FgOpKg/JbPRiScRdH4vpKU6O6tpwHJQcPBpU4zAkdMUwiK5vSuSQtCld5BQuVrJsyNV+pB5CVsMgT0F2nnps+jPOZX4tSrbCd7+LEqNFiP+3GeO3i+GnEvGMbzo8ZPOhckMxOji/HAMwTaW3tknHaxR/ngJYlzO+RdZrItyBC9w3WGKhMwuTwTZTj9IiO+AfTkCywK0Njm0Cl1v5nMhui8BgOLmIYAdA8qc8kJZmRW/pOj1lctlPFyCijKFln26O6XyOHsIWd4m2sr+LCHMzlA8BSKu+4U3VeuGCsFv2CzC8rQfUjLP1zhUMFQmMRNjV5EiNdAV3zFuximX29dVWEhO9qV+tnLUO+0zciwOmbcXPrpxqfXeQ60pEMSKQcQX97RIPc0PGjEcrxV/iT8zjdYFguCk+H9lMK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlNlSDd2aGlpeklXc2RRcDFXWlBWdE1HVnlqYVYyaVl0VmI3M0VkaGQxazIx?=
 =?utf-8?B?d042M2hZSmh2SDVXQXBGeGZxaVpGQkRpUnJheFR2SGJIejF6QWdKTiswOSsz?=
 =?utf-8?B?TDFZOEtXdGN6Uk5LcmJNQkF0Nng4a2gvRCtrL1VaQjRCYjkzN1YxT2tkV09F?=
 =?utf-8?B?MFYrZnJiWkdMRGp6UGtqWWs0bDRnNk1Dd2tZcHluY2JrcXh3cTRLdG11UjZh?=
 =?utf-8?B?RW1JeGZPcnhoeVd3M2FUbEYwNlN2U3l4NGZhZ2RyNmZaTHV2bXlndXZlZlBH?=
 =?utf-8?B?RnV1N0FIeURWWXJWUWhNaGlXRUI2Y1FYNDNmYzkzWWd2dDVCWE8wUFFQc2xo?=
 =?utf-8?B?U1pGNk5SWHkzc2pKUkJaOTlPc1FxcnRCTzVZS0dMQVBOTlNIdUErQkFXNytr?=
 =?utf-8?B?Q0xtaEN6NGNlaTdXSzV0Mm5YdnJ1anFBQ2c1OVVqRklLUTA5NXNFd09jSDdQ?=
 =?utf-8?B?aWU0aGVieGNqRnU0K203U1JJemJWNm5RcExGWnFMcjYvNERTbnpNUWlnSjJG?=
 =?utf-8?B?dE1jNjdlS1dwWVExSUprMlpNanBYTzJlbStaK2FRaUUzd3NPQW5wV0U5elVU?=
 =?utf-8?B?QjhJR1p2MVNEcENzZ08wdXMwc0JXamNNbnNOeHJKbGF1THFaSkUzOHRPRGV4?=
 =?utf-8?B?cThDS0c1UEdUS1hta1dvelRjNXMwOE1zSS9USTRIbnR0Zktzb1hvd3RsRDlC?=
 =?utf-8?B?QS9jdjZnOGtZb04rSFlYSHNsZyt2c0FCdlhDUUc4WW5HOEhBV0xEK2ZmREN4?=
 =?utf-8?B?Zm9SeWFyWmVGb2oreVR5UCs1MWJjUFlqQUtMenlpNi85UnUwZVZ0OG1aVkVp?=
 =?utf-8?B?cEorRFNmQlhmWFJkd0JIZEJmNEtRTzM0aGpsQ1pTV2FGMHdGczJ2eGR5TGl1?=
 =?utf-8?B?a2d6a0FOb2Y0Rk1jOFUvWlkvZ3JOTndiZ20rMDhFMXRnL0JSdnpEeDcwcGJt?=
 =?utf-8?B?RDVhaWI4VE1abkNzYWxmN2ZjalZXNFZqTWZPU0tjZk9xNW5Db2x5S2pvWHJl?=
 =?utf-8?B?Rk51dFlGNEt2eFNtc0J4QWxCOXFvMktiSjRJdnlmMTFhVm9vREQ5SG95bW5H?=
 =?utf-8?B?eE84am0wdEJIUEl2VCtGQmZUUTRsYzh1TU5xUDRQNmphTmgxcW1uWWxxdHpr?=
 =?utf-8?B?di9tN3puWGJYNWRSN2V5SEEyVlcrMW1yRys5V2pYbm1mN3BocXNaQ3IwakJP?=
 =?utf-8?B?NFNqS1QxK0E4RlhwWjVxZDNGcjNIQVlzNHB4Z2RLaW5iSkxFbnNNUDFyWExv?=
 =?utf-8?B?OUNWSkYvdi9QTTlEcldYQWIzVmlnelB4QkhmVk5XM2trYnl5RlVoTGZaNk13?=
 =?utf-8?B?NUJzQXdEZlBmamtBTkJWSnlTV2V0dnVEZjFWc2pZZmxnZ1AxNGF3dW0ySWov?=
 =?utf-8?B?alRFaFFoOXRVMHpUeHAxell3TXVid0E3TFJHY2p4NUg2dFlzRENidndqd2lS?=
 =?utf-8?B?ZlJXbjZPVC9WM1EyVUthZFRjam9YRlVjc3UrcGMxUDJFbm1OYXJmZFV5SXlE?=
 =?utf-8?B?UnZWOXFFeHQ0ZExvMTFwZEtIbFdrTThWUnBJYTdBWUppaU9VdHRDTnhnTDc1?=
 =?utf-8?B?bTRrdEpQL0Jwa3FKY1o1MkQ0UWxiS2x6c2Z4MlhpUFl4V2pqdjVoZU5pUXVR?=
 =?utf-8?B?eGlZdkdScGZSOTdKV2RSdTBld1ZBL1krZ2pRc2ZxdWpoSSt5b0UyZFdONHdK?=
 =?utf-8?B?d1U2YkcvVm1iY2RuK0QxT0s0QlpLMkFzUEpaZlV0MlVHeHJUcWFWSEkya0Z4?=
 =?utf-8?B?VmtWUmRIUUtJdEJFaFFMMUowS0EzbUk1RCt6QmZhMVJKdHdRL2ZnYWtyRUhH?=
 =?utf-8?B?VEEyejAvSDA1UXZtTmNvT1ExbHlyb1ZsTlhxcVF5dDViYjZVY2RqWENKYWVt?=
 =?utf-8?B?YlE3empUUTN2eVRiKytvZ0t3RkJBN3dDcUhsRkMzb3pJTU9vL0c2cDI4NC9v?=
 =?utf-8?B?ZlBQZGlBOEpZRmxKR0c4azM4T2FkWnZZS3RtV1ZTMWd1cDh6cUtIaFFLZUdk?=
 =?utf-8?B?dnBJeU1Na2xjOXBkemdCU1JoSFpIRjRKM1JzMmRCRHlwT3VValh6ZG82UlNv?=
 =?utf-8?B?a1V3VHVVanhxTGVnQzlwZGRZRW05Kys2RTdBdVlvY1l3c3NUdEdzMDVQWSto?=
 =?utf-8?B?TDdBU2psNE5pdnBlcmtPYi8vY244OHk1NjZIU2xTeHJCZFQ5MGxDNDhWV3Y2?=
 =?utf-8?B?U2srUDNXMnpyOEl3Kzd5K05tR1N2YmxuYUdYSThLNTV2bjdqVFVtM2MxaTRJ?=
 =?utf-8?B?bnVRalRiNC9TY21GRnAzTnNpZ2l0eDlTZFBhOFl5KzVadzBucW8rWHQzOGV5?=
 =?utf-8?B?N3lwa1BPYUVLbkIrcGJPSTJJRUx4WWlSdy92WHV6R2xhK09xaStwckFTTWJQ?=
 =?utf-8?Q?00I0Z2L+9tFE+ZVQ=3D?=
X-Exchange-RoutingPolicyChecked: 430qML57CIOITZbHTgNQFMIglLs2b/ArOBmcc/aIj+u811hAXmETyFPIZ4WD1/JErOYyKZZcvmufB1znqcvoSzRg40WXEViu5T0dzcZcGPiO4cwxvLQy2e+GYaKgcR3/+0L1QZlJ+nGEZlfxzSwQOL1v8srcCcLztEt49FEdizYDt9nnnPfduVWTQoyZeqclYeYVQtG3ArhrtQMuqkf3w4FRnVNqpnW/eT2WYmimrwnq4wCqf4Nfr1QcR1sELGkaydr0RM9kFFcW42uCjVdXEd/WyxMrzkEu9/rVKzhiDWXMT1YbS4daRORvwhv74zGHCzYaHv8kIKshYEyHafjoWQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 57acff2c-4a2f-4057-f6d6-08df31130dda
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:36:41.8180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkcYV3f7shQ9okye4JtPmuq1Q2lnO+2Y7yqYvtY9yfK8eDEqiUQvAE0lm4VWi5NEK4gvlWkdRwS7C2eBb7J0X+dtJdvjYIpmYM6li+HTYQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4923
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/2026 4:15 PM, David Marchand wrote:
> On Fri, 23 Oct 2026 at 15:51, Anatoly Burakov <anatoly.burakov@intel.com> wrote:
>>
>> The event FD and epoll event arrays are copied using the number of
>> entries as a byte count, so only a fraction of the entries make it
>> into the duplicate.
>>
>> Copy the arrays by element size.
>>
>> Fixes: b7c984291611 ("interrupts: add allocator and accessors")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
> Thanks for working on those issues on such short notice.
> 
> I already put a series for fixing a number of issues with interrupts.
> As part of it, I would remove the whole duplication principle.
> 
> Could you perhaps test your series on top of mine?
> 
> https://patchwork.dpdk.org/project/dpdk/list/?series=39749
> 
> 

It seems that your patchset makes most of mine obsolete, as only 3 
commits survived the rebase (incidentally, the ones I had in v2), and 
the conflicts were trivial enough to resolve on apply IMO. If you like I 
can rebase my patchset on top of yours so that you may include it in 
yours and take over?

-- 
Thanks,
Anatoly
