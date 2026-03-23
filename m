Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E85DF483E4
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 18:52:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BB9A402D6;
	Mon, 23 Mar 2026 19:52:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 5F8CA40268
 for <dev@dpdk.org>; Mon, 23 Mar 2026 19:52:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774291976; x=1805827976;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=v1HstRIY1WvrBUC0hqz5oS1qEywpK4PWJWuBQ4t2G60=;
 b=GciC6osc6+l8YtI326t5cHDTo+NsDbXzf+P7+0TBiAgTbVoU88nY/5wW
 juVDuXJ9jcdEeCf9ZjWWQ37ne+qepWXFLPOhoHyzG60pGofJwaFYd0tq7
 V2ZkKEzDgT0hOusYgA2/AN5ywTG9nOzlr4vtkZeTHbCjOZHppwOsID3ZC
 pOwhFFxP1RtXBa9iCGnJVH36sqdXzNE6/+TuCbgZNPW0LFoVJFxJAPS3g
 fG81wAXjzO8QNHZWTkPdxyIcl9UZKr3GQhC/BbkjwDWBp/S2PAUGrFxzA
 lqFer9hvRF5OTfUBmfYTz6rM3F/MGEm8uhUZ2PtSui5saa+ECoG/amFDC Q==;
X-CSE-ConnectionGUID: HxfgwoGNS7+zh/eezNRg7g==
X-CSE-MsgGUID: ip9yYU9VQduCQ88s5X4uAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75490714"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="75490714"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 11:52:55 -0700
X-CSE-ConnectionGUID: L4YCf9uqT/2P+VhFtbfnLA==
X-CSE-MsgGUID: KHftbJLkQCqE6i2n211ufw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="229034049"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 11:52:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 11:52:53 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 11:52:53 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.35) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 11:52:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkBdc13eGlo2frMC/sEw3d/KhF7XbqMhYTMOM9GQcqxdFr84EZGF1fEG0sbYDkCrCp/pbRTCWvnFES//cKbJvRdaEq9WeeBS4G5iX2XAEdm2pzhYYeybPMp+QQsPU1mLsvjQjOnw7H/TCYftywb5HYLmh10g+WwdR3+TAFVCRL28K2x0faX5udU9t3QJp7HaUibNvwaZKKe3Sxz2EYT1Gx5u6vtS3YvBoRwXcUf1SGoD7KIiYmAnn/ggeq0KbyksBnAfLtmFh6MT47tstmW4bJQHeUrRDboAlT+qTGhNYfS0J45OaGy/8Y6Edmdh6+ko0I7IElBPfOSM9cPphbgyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9bdp2YLpM0CY+MySi9m2w0nxOtlnOroibXRt3f6Fek=;
 b=Hhw5oorpxGiUMetAfmGWIa+DVGAG/zQz66ZGV9/0Ex96UVuBDDs9apHSRS3B6pILT2S4MmFDdO8afXtTYEA7C9/K0sKl3R5x/8zcPWCWTei8svScn1bRsRaUyEF9i0yOkmbLXGqugCuUKdQbEOnqN1mzgt7A79lz+zKOWr7t26r1swDJgUj8gXqfdA2pqn/XNgaQ5iDpwbnw5N4HXTsikGd6n3sJ2ksR6yLfu7V1UUDevf31x95dUQkwN1o9XptjdHdLzC9lwfS0D4mt5pgl4IqfIZjPZ2bab7mpvfAtmSXCjC2woz6c7+qbVPYYH7969TaBAErJavXMx3nEgy+Igw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by LV2PR11MB5998.namprd11.prod.outlook.com (2603:10b6:408:17e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 18:52:51 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 18:52:51 +0000
Message-ID: <04c9a27d-0ee6-4ac4-8b43-6406bd66c455@intel.com>
Date: Mon, 23 Mar 2026 18:52:47 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] VRF support in FIB library
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, Robin Jarry
 <rjarry@redhat.com>, Maxime Leroy <maxime@leroys.fr>
CC: <dev@dpdk.org>, <nsaxena16@gmail.com>, <adwivedi@marvell.com>,
 <jerinjacobk@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <CAHHRULVmnHih3BqoCnMv-FEj=aC3LehgCFaVhh=0eQ-SLsovXg@mail.gmail.com>
 <22bebf4a-3801-45e9-8ac5-726cb6c89721@intel.com>
 <CAHHRULVvLpFpwA-Z8KMuCKmdM24OCeZDrzEMEMs88h2-iqapXw@mail.gmail.com>
 <DHA98WR0DERF.T2XK820FGTF4@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657B4@smartserver.smartshare.dk>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F657B4@smartserver.smartshare.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB3PR08CA0002.eurprd08.prod.outlook.com (2603:10a6:8::15)
 To IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|LV2PR11MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: a24745f9-b3dc-48d3-2a23-08de890d6264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: HMxvkHa/0SqcOc3yyPP83fRTDn0X39/Qi8H8Qy9f+GPZ3fnAno93I0XTFXIHNP5b0sUsSxCZ2QtnwgdT1vbHaHugRY0xzWMh6GvC/SslHoNy62iO9al1GxthHHyhlxJpAPtki6+SmrXCpLauGVjpg0w7ujClrATce5suII3IWDjJ9i/j+ByoZWieE4fpiudRxu7fRisTREtMob54fY/lMtmfqN52P26S1o4u8JyAySM6Y3MgyhSILzQRl6GBGoIldX28mnvtsXsfU0o7BHxVMjNdinP6hbVR8MCVFqAXf/m0dlwm00Yi+qp1W/7gY1pVIP7bBo31SU4hl1LbUbI9fk+5l3iPTc5VEAW+5QiZzWXPbAdPsZJMQqkJU1Cc2emVACw5kPEXQiKmIGXYsvwMSIl8E1Lr4pUym9xuopbryTiCMqAB0oCJujvJTXlV4oY8lskc1wh2AkIEa2Ku6n7FiLZpiHteuip3vFA44WY29QahV9RvmAi1TGn3p6ZBg0lVT6MHaOCO8RrLxjsk+Ydkpd9gJ0nlPMpDdNT76HPJBc1jV2Oll/PpOhOL2aVq7E4dZ2oCIkRT/i6MILYWYTKYnMtfsNCJTCVKQogEKeg92hM9pstxuk/VEZDj0J02cnn+aGuI7n3VlzcOcHbPEYtMmOkMaxKJcmU/HFVnRaAP4tCrzwIhKO3CgZCQnMh3rd5CdxFNrfA9LVc4WeWA+h89iy2LldEUOWW2BKcXyW3UVBA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0g5Q2VZQTBXTExXOXdSSG9vcGE5MFoxbEtQQkRFOXNZZExvNXFyazl6ZlQ1?=
 =?utf-8?B?L0NKbkZ3KzlGSkQvL2M0c0U4bjNvbm8vaFI1NDNJRHpnN0FMMnJRcEwyTStn?=
 =?utf-8?B?ZmNvem1WZno5NXNIdjZ0QnlsTXJKOCtSWkNKYW4vVnlxSXFxOHVEUjR0RlV4?=
 =?utf-8?B?S1pKODBJR25icWtnMW56NFNsZ0d2RnRCTW1aaUlqWmJwZ1JHeVR0VDhoWUV3?=
 =?utf-8?B?ckxBRzJhSS96R2Q2b08wRno1c29zZXQyUFNGcDN4TWFiZDRRZTlxUnBTSEtK?=
 =?utf-8?B?Q0x4WGduUnlxU3VLZ1plbEQvazBMN3dMM1gxZk90QWI3N3Z3TXg1YXBDZCtJ?=
 =?utf-8?B?Y2U5V0twNHZPS3JJYVF2MGVuYnp1WnZDdGZJTXRtV1ZjTnF1WG1TclpBa3g1?=
 =?utf-8?B?cE1xNlJVQzFZdTdWTnN5RFlmcW01M1l4Z3dZVWUwU3hTem01Tzc4TzdhN0h3?=
 =?utf-8?B?aFExMzFKQytzblR5bWhRVmFOVVhIUVVjRkVYbDJWZnpaMEZQR2Qyd3Btb2tM?=
 =?utf-8?B?eUJIVTlrNTVpaGNlM0VMbTV4TWsvNzE3eVZNNG9UOExXbGVnMDBDVllWSjRS?=
 =?utf-8?B?ay9lN2FodWJFTXhCYm5oUFNxZGkwRUJrTzRtU1M2aDZzSGJsbi8yTUpTcUxh?=
 =?utf-8?B?d1FoQ2MxandKU0prMHVOd3ZncmZJZzNEWVNTK0hEdFI2MTh6dzRPZjBVODA1?=
 =?utf-8?B?SVh3VXErRlpNUmkzeWFJRTZnT2M4d2lUOHJ0NFhJbkM2bmdIK2loMFJjMk5V?=
 =?utf-8?B?NkkxY2RwY0NzNm40aklUeTdkM0hVRGRVVlJSS0Vrcy80TUZXb0pTS09mMjZT?=
 =?utf-8?B?Ni9xNGxMeVJzUHpmaUk3MFVXNno2M0QxV2F3a3JCcmZiSzJiNkRKTmNDMkIy?=
 =?utf-8?B?WmNnN0ptWHJqZkUwYTdWUGJtZmFLNlB6WG51L3dvL0F2cmduem04NDZicGpV?=
 =?utf-8?B?Ylg5RTE5dk1IRlhXV3Qwdis3MlljeThSc3lML2c0OHRaUU95cnpjUFA3aS9s?=
 =?utf-8?B?TWZWUEcrYTNYRldkRGJKOGZ2V3p2NHRlTTF5TGpDaFFLbDhZU1UvbUw1eHZW?=
 =?utf-8?B?T0xBcWtVWWtlVzV0bnp6Q0xtNEVabXh0VktBNDZGcHllNXIrSXl1Vnd4K2d3?=
 =?utf-8?B?WFZabDNEVmJIYXJhcTRzdytYZGpBOWRSdWVFN3BPdVhUVDFtdXdZYVRKZ0dm?=
 =?utf-8?B?VlB5YTdVNHpFQzV1dGFLYjNaNCttUmdOOC81SEJvWHFwTUZmUmNDbFZhcU1X?=
 =?utf-8?B?SE9QUlE0YW9MU3NoVlhlb0dwK1RDVU85bG5oazlCd29tN1hmMER2dEt5N1lC?=
 =?utf-8?B?M0Z3Y2xDTnpOSlNlOENrM3p6VkF0SXdsTXloN1ZxbGQ2MkEwVGJvMzlTMXRT?=
 =?utf-8?B?TEgydW5GbC9MbW9nOVFzVGx1V21hNG9MWktEUG9MRUp6akhMYkpQWXA1Z0p4?=
 =?utf-8?B?RjUvRUwyUnIvOEZzWDU1QmJKR0NmdnJ2VGd5UFNSYy96aXBNWkhGMHczajlQ?=
 =?utf-8?B?RHA0WFB2Z2dKZkNMb1h6Snh1WTl4dWRRS0djaDVsaktnVWkvOGZ0Wjh4NzFa?=
 =?utf-8?B?MjJaV0dUdGRMdWtDb0lGRjB4ZVoyc2NYbU9hWEtWcWZjcHk1cGtoY2kvaFRI?=
 =?utf-8?B?M3U2N0NMWWlXMXBPNzdsczlTN2pVRXRHNFBQZjFPSzRBOWlMd2JoNkVDS0RT?=
 =?utf-8?B?eUdlZUxWOC9ZNUtyK3JHbVp1SzQ5WTR3K2hvYlIyeHhjZ2F2WElLM0p6ZllF?=
 =?utf-8?B?ZXkrdVZwdCt1RDBnVkFUWkhsNEVmTUYvYTU2WVNTY0lsek9weGNwVmY1S05X?=
 =?utf-8?B?VDE0SzY3Q25kOUI1WjRwZlVBK1FPQy81WkdMRFp3VHlYYXFzM1NHYnNhcFYv?=
 =?utf-8?B?R3AyNzBQMHExV2pqdnkzZUdNWlUrYUdDNXc2NFNpTUs0Sm9KSWhuc2xsbmlP?=
 =?utf-8?B?NHhDQVc0OXFiTmJJWGkyaXVIWmFXR2NlcmxkdGdCSlNQWHo1NXkwZFNXd3dw?=
 =?utf-8?B?eFpPNmh5QTFOT25walhrdXZkUVBiTzNhbUZYM3owNy9HbDZqb21OV2JDY1Rt?=
 =?utf-8?B?WC9xTEdhRS9mUnVqSWlxSm1PSkVTWEUwS0ZscFVGNndtaUV2ZkFmQk54akVK?=
 =?utf-8?B?Q3RPQUNSakIxWElqelRKSGhYQjlpTUFjN1p0Zm9YY0hQUXl5SUVtRTM5Mzgy?=
 =?utf-8?B?K3gyOExFbEM2UDhXUDh1RXpDS2dPd28vTHRSbUoxeXRCMGl2ZURjcXFHN1BT?=
 =?utf-8?B?ZTFscS9BMUxjcXo2ZDVPc09zNVZLVGxaYUVpeWV4RHJwRzUxYlBRaG1TUEtv?=
 =?utf-8?B?UVNPZmJZY0FBMlBuN2pabTBiVWgyQVhwK0ptYXdaWEplZE9NQnVCMjlrSVp5?=
 =?utf-8?Q?GfShOn+3ims3qWQg=3D?=
X-Exchange-RoutingPolicyChecked: WJ5z31cd01mQIFeUwOGIcWQF/OnpiSyJoqNgQnaQ1OzEyQJLesTzK4fo8bY5bNGvAmEhL0XLj3I8sgW9/aeIO6TM9A/XR1JL2yqlfrL/Bggn9sn6ClBaY/xHeZMWH5ruG2FC2KTLwg9x/KRATWlOwBvgcwfQrZ169H6EYM3yFuVOkqZOIrGS0Q8RhIRLl4+FV5YoqzFflev0GRcwe8xH8IRnrtrJjOOraB8QxbiQevXe1drz3m+pc8sbU5XDtz3NwCYpvbdBpbYrdv1/0oDVwRYQp34YWhx3vxZg5R3xImIri1iZPbyRBf12Zf1cbJELDbUkef24tQ80KoeMtcs/VA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a24745f9-b3dc-48d3-2a23-08de890d6264
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 18:52:51.3484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDhSSh+4D3nuCzqmysE3ur/hrCAB4bQaRd6QbzDpmIAixThC6ATSdFqORtXTGa+DADWUewIMl1PEiFQXrexP9iIWI09MFcDAhDKjO2xQbCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5998
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


On 3/23/2026 3:27 PM, Morten Brørup wrote:
> Let's take a level up in abstraction, and consider one of the key design goals:
> What are the typical use cases we want VRF support designed for?
>
> I can imagine a use case with one or very few VRFs with a very large (internet) route table, and many VRFs with small (private) route tables.
>
> PS: I have no experience with the DPDK FIB library, so my feedback might be completely off.

No, you completely correct :) In real world scenarios only a few VRFs 
will have full view, so I considered that number of VRFs would be small. 
For small (private) route tables, it would be good to use either smaller 
nexthops (e.g. 2bytes), or some other LPM algorithm that is not so 
greedy for memory like DIR24_8.

>
-- 
Regards,
Vladimir

