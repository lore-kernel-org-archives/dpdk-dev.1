Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C0F606A326
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bEltITv/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FC8A40289;
	Thu,  5 Nov 2026 10:33:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTPS id 2AD0640281;
 Thu,  5 Nov 2026 10:33:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793871229; x=1825407229;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=LIfH+v9QAeLm47UJnyzZLMae3VCfFB86Y6M3Z1m7tDc=;
 b=bEltITv/OGnJbw6gJehrjRa3QM/skyc6iEyXSGuQ1XN4d90+wk4COIR6
 XBxmFS4rYRBShvxEoaYj2QcKLbtAI06TXLd1KOIwRDdrejmuhpia7trCD
 GbM5qJgoht3PZMQ9cbWlhRvqj+4z9gpNEOyhE9MViv1KQvgCc2+Mjj12i
 acbHezKMfn6hQR1APkjcz7uV1zcDi3LRQtFre2mPbVKEu8OhZRa29Ua8v
 cd1OcNohETngoPojdYPEaNda+1vyO860OwcpuS93v6Wyu69FKvlPNJZMg
 cH6EpiplBDw/rdgfTWhGq3IJLzN4+11wRA2mdPyOiVcGl12WmtJmxWuGP A==;
X-CSE-ConnectionGUID: XaDE9Z8NRGKOhSocFB1lMw==
X-CSE-MsgGUID: gPYHFop9SvSPhr/MD/1xgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2681963"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2681963"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 01:33:46 -0800
X-CSE-ConnectionGUID: ZLPPNwERQMuzJQ1umSdXKQ==
X-CSE-MsgGUID: oIIcB6+fRvuAOvWDG9MHlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6844425"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 01:33:46 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 01:33:45 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 01:33:45 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 01:33:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLV40L5wsRKqQrQzCY5r3ByvZrrWZEBa7dc2axaaNAOzW8HFzxe79w3HH/8oJEc6zCgT85gGtg2wGAaCoZ5umLum1aVr8m+GzX9PKjcrXlQMRushRz+I4RATuhd37PPEOeuOO2Z7vzVYrhKdMRUU1p1kL8Assot7P/SGDdSQUHYUvGnKL0w7+pyh/fa/B0mj2CXPyroSMekYB3f+EDk1vxH0Js/WQdvpg+4N/EtsALhgX6EgYvCvHZoiKTS0IkMNSSQiEO7HefIzgyrVEijwub5V1leaCf/HMScWDdrK61otQxLCGpitJVDgCsTaKMAfDS3+ReCDKDt99LBmJOvayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+0GXdcFtJEKbplxB1r23UrbdDNfkFnqP0M1BYEeek0=;
 b=DnfwBynaeswDBzy0N/NgmWtCKczV7jL582NJquYaG1qz8g7hzaS4O6aRxFRrSDLsBOQEzSrlfEwqb2oV2+drl9NvyWk3NSSMeUEgHbX4KHA7riURU9aLselWRqnmJRULbmkJxOJKuFav+8DO43P89vvXnWKbSuDfNnNv3/bQuDsYBoH4A13YP9nVWDvrxDw+LsB3Ckyp8L4g/Kwdbr2Ery4SRzR3IUFt8st1mQxtSL03hrznCri2afRlR/Po6uMAsT8+ZA+rnwM0B8ofznzmo/5jbGkqFxA0036adGRFfqo+LQTp2I3J56rh4ot9i8XVlTIjnBHL0loL3JLNDsKjsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH3PR11MB8416.namprd11.prod.outlook.com (2603:10b6:610:17f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 09:32:42 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 09:32:42 +0000
Date: Thu, 5 Nov 2026 09:32:37 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Wei Chen <allen.chen@jaguarmicro.com>
CC: <dev@dpdk.org>, <cristian.dumitrescu@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH] cfgfile: fix isspace() undefined behavior
Message-ID: <auxNNQ5dWrmHG96_@bricha3-mobl1.ger.corp.intel.com>
References: <20261022122348.3467-1-allen.chen@jaguarmicro.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261022122348.3467-1-allen.chen@jaguarmicro.com>
X-ClientProxiedBy: DU6P191CA0041.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::21) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH3PR11MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: cf47bbcd-8987-4e39-8eef-08df3b1fbd9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|261021121427099003|261102123227099003|261022105027099003|11063799006|261009223027099003|261021123027099003|261026140227099003|261026121527099003|261028144727099003|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 5nWJ3SvWoLV9mZxorx7mbGi0Ue0YOi7MhVs2XVpUH3KyZSPAqYlVve3Nn3z1po1YenFG8F+Watx3m8h0zai3tq7seSeS1GWmMJFMv6dJ5sDlDvdxYs2NB1YwDhHZW384q+yzJW0vdPvGAvIixH5Rwz21CQNNHjFPlbVLtEEGaOnvsRHcD6nltzQf8vW2eBsK40hfPihQGOxbtKPku77PP3/lZ580ll8fMr/cqfTopAOCvHEKLG2oITmRSp1rGapZGdHwIqbPuTLYuj4kON6hcIIZfeb0lrV+JwYxUzAJYaIv/ryu4OwHgR+S0+eWAKW+Pkk6c00a2Ta7ZJR4COQF108slOLRVWThhgNH0HDI5eEPAhct8uwWnq3WKRGGIC5AjYvm5eBkV7zuPXbNHPvQEBVI4KZWo2hiZELZlIHFp5MctWkLnUfG5e08gx+dqPgpfuyyyb4cd8Y0GM7BTCjdQBDxt0pHeWz3FBg03Zh9MG4xNaUT06qRYt+eo/1JhiI6fksBirSX+7rt+MGRkCYscGQtRaqdUF1LG51jokD9IpPUQXIPFdn1Wm5a5IsRzzVONULjtbe+ymEhle8Dz1dolAkVkX9swkZscrPT1yqk/+ACNoskcfiIR0Yoo7gEuL7rWbuBibcv3fq2DKjiDClnEiNMGbseQkxv3Rbaru46u/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(261021121427099003)(261102123227099003)(261022105027099003)(11063799006)(261009223027099003)(261021123027099003)(261026140227099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vkhj7dlSbJruEt/5M9Md2bL1zBQ8oOlHIwHZv6G2V2xLCinHKcISjmLE99ws?=
 =?us-ascii?Q?uiVApntNBCtWzH9JM3QKn/6SDZ0WGJt0p7j2qMnU+KK7/1sShQ99ZfT4oI0y?=
 =?us-ascii?Q?iFo3TM7c2NCTSZcC61Kpxbu3fn0Qtm27TgyN2/xfGn9VvM7XpWIaZM0scR/4?=
 =?us-ascii?Q?NSHuez2GL0BxfIjEwGBJJfvoDFPicY30Si8y5Wj3yC510lgmwo7aqnxBpCbI?=
 =?us-ascii?Q?8ETAxoupZm0XCagfjvRXxHcLC2rgQ+PaXdRVAdMSRUBqQSI6+1HYjVLW+qeQ?=
 =?us-ascii?Q?hZKHsN10sCHbi1NaPTWm4ZFLte20akl1bTSCLNJLo4Rwi+4ygvkklnHG+z79?=
 =?us-ascii?Q?JA0ENoQPX/3Ax7WX84WnY3gOvBRm6G0Nhqwa1Muf0V2bAegYvsS6dFPfCDuP?=
 =?us-ascii?Q?4Sa8pGF4DK+w+VhyWRao0W4fake0ApfBAIUFtrfuCQUa+DXhsyCa+phrpayO?=
 =?us-ascii?Q?UH27YPthSyiCIjblJpkj1ao8BC29GWLqQLuf9ZO4dG1qVGJdj3ZDVgIqYc6/?=
 =?us-ascii?Q?bkm2pW50PLWQMngs1nAvbiUNENvgBAhebvC0QgQ2h9nforpNN50G2uoGOGNr?=
 =?us-ascii?Q?ghM9Tc4C4Kkls+R9JKEjZsJbiGDJXvHYwH989a/4yi4EsQBFDZplAm7sex+A?=
 =?us-ascii?Q?7xkN13cpJ+PTnSrGGR7FOkXQSeSL/Pv9bbCcu0IVG1fIPIcWXb33+e4ekj+V?=
 =?us-ascii?Q?7tu8Qolx9qNHf8h1ir4pOPpkkbpuNr9BnaoCKjMgZzu/HBgXJArYNkmwAfTa?=
 =?us-ascii?Q?q56ZxHBlLpeQuLeL9+M3M8dRJk1r3xclNoMO0PorXErJCbih/CLUV5+mRkqx?=
 =?us-ascii?Q?Md6/SnbVbAwcx6g56qus/WYfQqdjIPr9D2GFYpWCD31oWg9LQToQ+n+UIiR2?=
 =?us-ascii?Q?2OL+TSt6etUUD5cafq3H9bpDFAO6WeVCQwHttPEVK8HHTuu8253YYMjeyc9J?=
 =?us-ascii?Q?kV/kYbGuolNx2Ao6x5Z+f4fUD8/o1aSFs9xY2UPX2mo5CrzOHpA+srPGp/B+?=
 =?us-ascii?Q?VacPV2C1m85fUnUzoWyRAzv/HNMjnFJ5VTGqcozv8jVK77LDn9w2Eh4ZUbFs?=
 =?us-ascii?Q?61cbkCkzxM2pMB2qABEEkHImE1+iKNFYIP03GwFFMIY5EsH0AwSw1P3IMW9T?=
 =?us-ascii?Q?gP11ayyV5YS0lTC/AOlTaUXwfxJsJXzcaVF52M12oLmqNdzBTdwhuyYqVom9?=
 =?us-ascii?Q?PSPGuPw8qq3Qmf+A+x+L3jcx5USrM3SXwOtNl2yyL4UgJKIniq+TzxQkj3qG?=
 =?us-ascii?Q?w6Dnbjy7TeqGncrKJmfD49gglFz+6aa/PiDjf0zPOyNy2+19Tg7MEj8c/Zas?=
 =?us-ascii?Q?dkBi44ecHyW90AJBh9/6B0NczleT9zgla+IhA82bA9vC+z8Pjk6b1poFzI1k?=
 =?us-ascii?Q?saj5pCpW2zjXZCxi7aIKO0OAXhONlKfRJHSLtY/+Oj+8sywAyI73OtjFaQ8Q?=
 =?us-ascii?Q?za8ulhj4uxZ8IXynJNNvou6gpjpEfLefybHnaVZ8M3SmCuejzX/Z3wVp4tau?=
 =?us-ascii?Q?2CWP2hIJGyoKVgqhh8DkRSGvp7t2e1cM96Wf/Is6T/24Vpbq3WO0W0K/KbmN?=
 =?us-ascii?Q?WYWelvl8cnVcr03jKw4JNh5mJce9pw2cyCnjXGfjqLjLaS/AZh8TclVkxjAd?=
 =?us-ascii?Q?tHr/yihUrpkDo7MxWo3i3INRYuN6hnyL5NvjxlU4exrBiejP8/PXbEbKhLhc?=
 =?us-ascii?Q?otQsPFxDQdlaxiLE845W8iTtO2wM9PYsFaN0IfTp53jtbd/DF0Tmd1Kamw4K?=
 =?us-ascii?Q?j3O1aB0a4ZRe1xutkzGPcy0u3kR3aP4=3D?=
X-Exchange-RoutingPolicyChecked: 2h46lUXvKkuYmNz/OiyDUS8R+6E+8eu2l9NjOv5SVq2FSHkKaevOyJ1/2CBqOAosWSVF3+bwyTaVtbtyFBiMRXIW0tuOwNsnqIaR5KN00JtlDeT5BKW+BIcHAYLAlu7UeLlqTvTIBplRD5ouoteQoVBPHQ+JQiufeqEOk7zVEbbFloDmBXjfps3Kk8LzAjfbDDcSC3l+c5YzGkL0+XTSBO32jL9V5ni5hoeuug0pjdgBQ43hGLFqCmPRnqt8MV/F2kb83YIDkzpqFk0pwXgLw57P8zyXb6QkgWR2HboCMX8WpWtfX+LBrEl7Sb3hfhYsh4Vz3jAJAlkqbYobgR/YOA==
X-MS-Exchange-CrossTenant-Network-Message-Id: cf47bbcd-8987-4e39-8eef-08df3b1fbd9f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 09:32:42.3667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/2V6aM+J01/7kGyshR6TrSwcsH9VT8mxs0F9bvFWh0rJtP2mg2dLrSTLYfXNwfLtbqMvyi1ZhJknJCyKigBIFZeZI104Tvbs/LMlAb8OxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8416
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 08:23:48PM +0800, Wei Chen wrote:
> The _strip() function passes a char directly to isspace(), which is
> undefined behavior. The ctype functions require an int argument that is
> either an unsigned char value or EOF, but char is signed by default on
> x86 and ARM, so any byte >= 0x80 in the input is promoted to a negative
> int and indexes the ctype table out of bounds.
> 
> Such bytes are reachable from a user-provided config file containing
> UTF-8 or other non-ASCII content.
> 
> Cast the argument to unsigned char, as is already done in
> app/test-bbdev/test_bbdev_vector.c and elsewhere.
> 
> Fixes: eaafbad419bf ("cfgfile: library to interpret config files")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Wei Chen <allen.chen@jaguarmicro.com>
> ---
>  lib/cfgfile/rte_cfgfile.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
