Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD78C282C1
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 17:28:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88D0E402C2;
	Fri, 28 Feb 2025 18:28:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id B929A40280
 for <dev@dpdk.org>; Fri, 28 Feb 2025 18:28:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740763701; x=1772299701;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1eXRGXbcdtOGdDNDeUy/KNuotE4uX5C74t5ooOxNKUA=;
 b=BLxhmrcAYT9QKhFH80YY6PeWOf5UQYVIMlVT3dIqovFnxjQ4/tsPM03u
 EWzcRcoIV1ta75LKF+18KUgEVXF9NYCV5g7cSGh+R97nenZT9VuCBIlGJ
 7SMU56ziOCp60lNWFU7O30f02rJkqsUfopi75p/IMzPV1thw5oP5gYxep
 3IDxauCYPc3nlc2wQPT8VrUlDtjIiRKEGPCClmKUCNb4Z90JK1X6ehPIZ
 zniNHn+rq0CH1Lht2hiqVbvtOHwGfVdCtf+0CUTo/ogLLRpD7WbzEzsAw
 CTcwHAN4yDRrUwRNYTq7dJ9aF+bNJ74GaVCE34fEiFOh5Klua1m0nSkgr w==;
X-CSE-ConnectionGUID: oW1sIuE4TTyWUjxMa0Z3Ww==
X-CSE-MsgGUID: 75sqsFFhTX6dQIAYXdV89Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="52334048"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; d="scan'208";a="52334048"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 09:28:20 -0800
X-CSE-ConnectionGUID: v6iSCZYeSceD+RMqW8mtOQ==
X-CSE-MsgGUID: 8Amv7KdiRsaKTxPAJtA7Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; d="scan'208";a="140613897"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 09:28:19 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Feb 2025 09:28:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 09:28:18 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 09:28:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/5rMFphOwQ5AIvGg/tV7kdWIxrrqJNADmhrE/Hh0Kt48iHvqow46ycbUjHmY8bOpncFwQPXYL+3QlwuGLf5uNTXRinR58TB3RUvyui4+ZrM2DbajLRUsn59yiFFZFOfC+vDDoKFnOI+wWonynLLNc3+bOKd+XgjCuF7Kh9UM072OtV52bs+LMdttKNwL5ODHCIxQum2YN2ZLlg92bAJL1BcW3pF68uQTepeDzseZGGkJxt19cAacpEusdBJfjwc8XtDv9KEdYJ/iaAvTbI3JyKe4JdmuXPzEw4S/I3P/AKKoZ4eaaAi/HfsHsbLRlHBpu2dJZxXfAPvKziA17lFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eXRGXbcdtOGdDNDeUy/KNuotE4uX5C74t5ooOxNKUA=;
 b=H/joV+FhbOUeMKCgAniQ4YhO9a2zB/hKRD5y5fAf8JuakvYyr+P8qTR7UUMnBSqlqHRnwD/YtnWnRQ01pzXiuXx2Y2fRsdKGIqsIClPOFu/23LhV+rrgcXTlNl6UAk4r17/ma0GF+KLutHi8OLo4NSu9o9SOZ/x4TRovVQdFci5FK2Sf7DPbhFaeJ/x6YyvTG19m3SKzp67nM2Gk/gzEqMYlyLwdy4mmjtkJAgchLrkU/439S+OnN/xgdENytxIYf2rliug9dAfmOVdQ7dUzu4UudHRKUGF9w2QlKTn8zOAWW6xJsf1SKgzZPZJBV2k9yUJZa1bA7YciXdoqGwpKXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6694.namprd11.prod.outlook.com (2603:10b6:a03:44d::17)
 by MN0PR11MB6230.namprd11.prod.outlook.com (2603:10b6:208:3c5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Fri, 28 Feb
 2025 17:28:14 +0000
Received: from SJ0PR11MB6694.namprd11.prod.outlook.com
 ([fe80::37fd:2328:c9e0:9d57]) by SJ0PR11MB6694.namprd11.prod.outlook.com
 ([fe80::37fd:2328:c9e0:9d57%4]) with mapi id 15.20.8466.016; Fri, 28 Feb 2025
 17:28:14 +0000
From: "Chautru, Nicolas" <nicolas.chautru@intel.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "hemant.agrawal@nxp.com"
 <hemant.agrawal@nxp.com>, "Vargas, Hernan" <hernan.vargas@intel.com>
Subject: RE: [PATCH v2 3/3] baseband/acc: add internal logging
Thread-Topic: [PATCH v2 3/3] baseband/acc: add internal logging
Thread-Index: AQHbbeuOi9lkK02gFUqQztsexFnPJ7MlAAqAgAEkyKCAABMuAIAVeEKAgCDv1ACAAIldEA==
Date: Fri, 28 Feb 2025 17:28:14 +0000
Message-ID: <SJ0PR11MB6694E715CEB27DD13F152ED3F8CC2@SJ0PR11MB6694.namprd11.prod.outlook.com>
References: <20250123225519.2469167-1-nicolas.chautru@intel.com>
 <20250123225519.2469167-4-nicolas.chautru@intel.com>
 <20250123152425.0663a626@hermes.local>
 <SJ0PR11MB6694A42B032D97C9D9CF0D77F8E32@SJ0PR11MB6694.namprd11.prod.outlook.com>
 <20250124100058.5b4de64f@hermes.local>
 <0df7deea-a6f9-4078-9dee-de42a1e647f8@redhat.com>
 <3eb26ee2-1130-446b-a0ce-4789ba21f14c@redhat.com>
In-Reply-To: <3eb26ee2-1130-446b-a0ce-4789ba21f14c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6694:EE_|MN0PR11MB6230:EE_
x-ms-office365-filtering-correlation-id: d3c3df1e-0a14-4304-2794-08dd581d4861
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eGR1cFFXVVltK3p0b2VMSTJRWU42R2o4VlFoV2ozeWQvNmhXcHhHTkMyazEx?=
 =?utf-8?B?TTZaZzZsSkZ5cWdUM0ZmRTVxZXNwSXN3M1VDbVppeURoYkFtTHlhMHloR1Q3?=
 =?utf-8?B?bEVqQWxJMTh0NnVzcDZCek52a1U1Tlc4eUEvVm40OFMvckVIeTVwYWR2dHY0?=
 =?utf-8?B?K01NSnFYbTBhdTUvRDJJTHcrREhvaitMVDVCYW0xd1NNZTBubHhxR2VPWGEx?=
 =?utf-8?B?dllrc3hoOUJZZUZKNFYzZDBJRmwrZllpK1dkRDlGRWVzWHdad3k1U05sT2Jj?=
 =?utf-8?B?Ky91WXVJQXByRnRhWitHU1RVcU85bmd6MVBHMGFuM2ZMZ3Z5UnJMM0cxWVc4?=
 =?utf-8?B?anBzY1l5K1BRYTRxbTh0YnE1bXRMc3hHRFhhZ1l4eWx1SUNUVStYTDh6Ritv?=
 =?utf-8?B?TDVTRzBuRlFYem0wVWtPa2VTYjhXakYrY0NGS2xxc0hlWGtNMWxTenhCK3dI?=
 =?utf-8?B?aWxtcldtQ2lVS0w3TFErTGVtVUNsL25ZMnVWNEFzKzNrd3FMdTJSRUlKUnBW?=
 =?utf-8?B?UXU1NHZoRlNrZTVyMlNtbktESmk5L3l5dTJPNklTa0NQd0MyMFF2NkhQcFVG?=
 =?utf-8?B?MDFoKytoNWw5NmRiM0FzQlp6OGh6U3BES2pHMUpKNzJPYVFjd1ljR2NSd1Rp?=
 =?utf-8?B?UWFBYjI3eG9tOEx4eW1ONzc0QWhzY0l5Nk01RDErLzJ5Y1FyN0tpY1pqWEFo?=
 =?utf-8?B?c2RlTUhqT3FaSXl6RFYyM1V0WUhqdGhGMGNkU09ycXRLK1kvZU5PaGlIUGFl?=
 =?utf-8?B?MEJ4QVpLOFROT3BobmdCaWVCekRyREhQZWlFeXVwVDBSazdWRVV5M1NSNU9t?=
 =?utf-8?B?Uk5nSG8vMzl3RXBzbHk5YWlhWEdnaTYzdzR4dUkyV3dKM2lmUjRFZEtuT1dS?=
 =?utf-8?B?K0VJbW1YN0dnLzMxclNCS3lQVTdpNUI4enQ2MUNUa2pRYXI1YkhkQTNGM1I4?=
 =?utf-8?B?djJ2UHl6LzFRaU1nQTFxanFZRGl5eDVmTWtLYTgxTEtHTDBzQUdVcWZzSkJC?=
 =?utf-8?B?dkQ2QVFOMFlFVmVmbUN2eHBUdWRObjNlaDgxOTlCbmxYWFJIRXl6cldJZlJr?=
 =?utf-8?B?bVlobldDWkNHTkR3bTdCcUNydzFqZnpSbjlQZ0h6T2hYZ2RxcVdybzREVlN1?=
 =?utf-8?B?SitDMGRpNWVHRDhvaHZHdW9Sb2k5azQ1RTR2R1Fvb08yM01xK3ZNN25QTTNl?=
 =?utf-8?B?K24rak5tMHE0TE5pUjVkWmxvMU1tWTM1N1FyekZOTkg2Tk53ck1LN0VCMnlE?=
 =?utf-8?B?azF5eEY0eURTVkJUVUNkeDJVKzNORE13RGhqdStaL29KY05ZM2VKSUNWZ2cx?=
 =?utf-8?B?OEMzRncrWmtyNHMwR0dmYlg5N3phS25VVUM3cjVoSnZOZGRvSnhyQkRLNDNv?=
 =?utf-8?B?ZFlJT1ZYUDFSemdlQjNLWnpUZ01UZWhqRVMrOHlrcW9tNGt3bWgxS3duclhl?=
 =?utf-8?B?RzhsaFZoaWYweUhDVnFBS2tqbVVlOEE5MklzbjZ3U2VIKzhrQ1Uzbk5jZE9m?=
 =?utf-8?B?Z2QvUGZXOStvSkNaUFA3dlY0ZkErYllBWkZmOG8zcVA5aENSUCtRUjJLUnI5?=
 =?utf-8?B?RXJhWXRxNlI0Ui9PUXJRdVhoL2h2cjk0NFFVaXZxYkh1cUdJYVBydlphNnZK?=
 =?utf-8?B?dW80UEFJcm50ellKNjF6NkJBTDkyNmlOV1ZubE8rbVc1by9yU2poaXQwQ1Z4?=
 =?utf-8?B?VTBMVkUrV3RkeFJaSEZqWVowVFJ4a2JTQjRkZnovd05UVnJGdmJZSTd6TUlM?=
 =?utf-8?B?NFFSbTZBYTUwby9LSGI1RUJVY1I5SWtNQXczTUlFbldGME9FeHREVDVockZ3?=
 =?utf-8?B?QmdDdU1uTnlqazlMb3lBOUlSc1czcjJRdFoyRE5JZ29mMHZlOWZJNzcwUWF5?=
 =?utf-8?B?dWt1anVIMzdhK1dJdy9nS1p5VmR3S0ZWWlRJMUxPT3AvLzI4V2duY3UrMlI1?=
 =?utf-8?Q?uX8EFw0ZytaZDk3W3sBhrF7dao/uvkrC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6694.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFBBR2ZDck9JcGZuSUdCNXVqT0hZc0dDYXFrQWtuOG0vRW95Ti9KNWg3aG5r?=
 =?utf-8?B?RGNoNi9yRHJRY0RwM1VGUmZvQnkxY2R3TkkrL3NLcm9BTDR4aUJWc3hIdVhD?=
 =?utf-8?B?OGVxK1BvOW51TWovVVFJYzdVUkpCMFUrenZFMnJZQlJLZEFGMGRZdjFadlQv?=
 =?utf-8?B?eCs4c1dzWmE0K3d0UVVpcU1yNHdxVExxRUNLMnJmM0FPV3FGRXJoQk9BYWtU?=
 =?utf-8?B?VDJoRXltVjZtNzFVQmlkV3ZobEl3d2JvWjRTWHMydUFlbkplSFRRYXpjMzU3?=
 =?utf-8?B?S0JGZm9lN0tWN1FCakc5QjVBczMxWmpCRjhTVjJ0U3ZIM2ZQaFF6MlYyT2wx?=
 =?utf-8?B?eGdnSkNDR0ZUd2ViaUpkT2thempJTU92ZnA2LzBJNG84Qm9zcmtLZHI0b2NK?=
 =?utf-8?B?SE54c2VkOUZpenJ0bkxQL1JjeHB2aVJQcHloOTd5YUQxa3AwU203QmFRbVRW?=
 =?utf-8?B?M3JjQjNVRlNpMWxMU21XbVV3NUFRaUFWVkJINHdGVlc1QWVpcGFyYWxQd3BO?=
 =?utf-8?B?dnRmUDdHL3BnUCtRMU9XVlk4NThXelB0Y1FBU1M5MHhpcFhUbWNodzI3bTBU?=
 =?utf-8?B?KzRZOHByUEhVWkJ4ZG9DZldIUkZZT3dCd29OeU5QYUtLK0d5QTVqY1JVam01?=
 =?utf-8?B?cnRCTXBJQ0Q5K3YxcWo2akF4cVVKOUtYdVdXRzRIMEx3Qlg5YWJSTmx4Zm1r?=
 =?utf-8?B?Um1GVFZFSlpXdU9DdDRpL3F1N2pRTExvbS9TNEF1dy96b1hoMHAyNlYxSCsw?=
 =?utf-8?B?czVUWENaT1JRWDgzQXZVK0hxaElvNEIvazFzakl3K0F0ek1GVXpjak1PTUE0?=
 =?utf-8?B?TTc3MUJTTVJwL0pXZElzSjJIM0NuZ0IyQWR2Tm9LbVdKYjFxM1BzbGR5TENM?=
 =?utf-8?B?WWE4WHVaZWlrU1EwVGV1OXVCYUlOS1dwekF4MnZrc29EbmFlRFp2ZXNvd0Jz?=
 =?utf-8?B?VEdiWEROS3VYdFQ1ODNaZXBnNW9MSzViSmVYOVpTZXNlZFlqcXBvMENLY25H?=
 =?utf-8?B?QjVybGZSdVg2aEFWcFVCQ0svYTFhL2hLSWN1VHV5c3h2YXpMZmhRS2ZDbDVF?=
 =?utf-8?B?VDhHQVdyeEdUSkVaaXIvTkZETmpDNzBISFdYZzF2Wmt2UU9FL2RJaDZMYkhS?=
 =?utf-8?B?VGJmREpiOFNGd3lMek1NOFJRZ3JMWlRRWEM1czRxR3J0Q25YVURPYjMwSmY3?=
 =?utf-8?B?NGJWNUp2SC9tWWo4RkFLZU5ZWWVDMWRIRjRaUjBkU1hXd0hkdzNXZkpjV3F0?=
 =?utf-8?B?aFRmbVZkTnlHWThaeGFmL0ZCR0lzblhKTDQ1clhrdkxqNEs2cVhKeXNGc2ls?=
 =?utf-8?B?dWhQb0RrRjM2VzA5Zm0rRWpLaUFwUTRwT1I3aU9qbkNPWEhnaHE5aGZqckpx?=
 =?utf-8?B?Mm5uMHpkNWtZR1Y1WHJRU0J6QisrcHlSaWNKVmR2dDBHNGtTSWlIb1dZdzRR?=
 =?utf-8?B?TDZBYm1sZHI5V29pVWNITk5CdGJGd2VhNU1wa0hUeFIxUjdGTGYzT0FERE5o?=
 =?utf-8?B?ZFY1NVlnM3IzVGdTUVdOSEJvNENLTDF1c1krdnZ4S3dic3gzQU5Va1kvVE5K?=
 =?utf-8?B?TGtIQlRsYXZ5Vk1GYUN6SmxEU1NpSHgzT0FKL0V5aXlJankvV0VpaS9RaFZZ?=
 =?utf-8?B?My9DbGVneGFiRjdBMUpmb00wL3dHbEZ5VExjb2pzbHNBOFVhU3dXQ1BnSnlS?=
 =?utf-8?B?N2QxeElHR2R1QjVKSDRMak1rbUM5aXRMb2tQUWNuR0tTSHVtdnBRMWx1b0pE?=
 =?utf-8?B?S2ZzeVEyaUQxM3RSdnlyOGtENWM4MGJLd2lSSlZzUzkveDU5QjRBOW9LT0ps?=
 =?utf-8?B?M2I2OEwwQ1gwL2lEVmNOM1JtOThSOEhWTE9welNyUms0TXlkdVRhYmU1ck1J?=
 =?utf-8?B?WlpPWmJPcFBkS2ZoYVFQbGY4ZnlxN2NrZmU0TzllUzR0WCtQSDRGWmJ3a1p5?=
 =?utf-8?B?NTJJNitJU0FKK3Rhd0FGeWRGQUlkZ1ZtRGplSGF3OXEyZHVLVmJoODZkU0s4?=
 =?utf-8?B?WXVHWmtURzFUSEU4MksxSERZaElBUnFyWTk1QlM0dFNXdlhRYmVua0liQUZu?=
 =?utf-8?B?a2gyREZFYXhVYnVUTDN6WTZQS0ZNTDBGaHBPV3owNGxIMXgySGtGK29mUUtW?=
 =?utf-8?Q?3cptRNjgCmSlgpsDxh+fw4z/p?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6694.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c3df1e-0a14-4304-2794-08dd581d4861
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 17:28:14.8064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6cxzox7smKYRDyqkaZjf3OTvKJcljbojq5Q1oFeRsFJhr17uVt0F1iMjXY7VIMDwO3vc1AdtRk7y6ZIKVSo3JiLzOxC7ueLfvCyNILKXgpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6230
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

SGkgTWF4aW1lLCANCg0KSSBiZWxpZXZlIHRoYXQgZm9yIDI1LjAzIHdlIGNhbiBqdXN0IGFwcGx5
IHRoZSBmaXJzdCAyIGNvbW1pdHMgb2YgdGhlIHNlcmllLg0KDQpGb3IgdGhlIGxhc3QgY29tbWl0
LCBpdCB3aWxsIHRha2UgbW9yZSB0aW1lIHRvIHRyeSB5b3VyIHN1Z2dlc3Rpb24gb3V0LCB3ZSBj
YW4gZG8gdGhpcyBpbiBzdWJzZXF1ZW50IHJlbGVhc2UuDQoNCkRvZXMgdGhhdCBzb3VuZCBva2F5
IHdpdGggeW91Pw0KDQpUaGFua3MNCk5pYw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IE1heGltZSBDb3F1ZWxpbiA8bWF4aW1lLmNvcXVlbGluQHJlZGhhdC5jb20+DQo+
IFNlbnQ6IEZyaWRheSwgRmVicnVhcnkgMjgsIDIwMjUgMTI6NTIgQU0NCj4gVG86IFN0ZXBoZW4g
SGVtbWluZ2VyIDxzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZz47IENoYXV0cnUsIE5pY29sYXMN
Cj4gPG5pY29sYXMuY2hhdXRydUBpbnRlbC5jb20+DQo+IENjOiBkZXZAZHBkay5vcmc7IGhlbWFu
dC5hZ3Jhd2FsQG54cC5jb207IFZhcmdhcywgSGVybmFuDQo+IDxoZXJuYW4udmFyZ2FzQGludGVs
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAzLzNdIGJhc2ViYW5kL2FjYzogYWRkIGlu
dGVybmFsIGxvZ2dpbmcNCj4gDQo+IEhpIE5pY29sYXMsDQo+IA0KPiBPbiAyLzcvMjUgMTA6NTIg
QU0sIE1heGltZSBDb3F1ZWxpbiB3cm90ZToNCj4gPiBIaSBOaWNvbGFzLA0KPiA+DQo+ID4gT24g
MS8yNC8yNSA3OjAwIFBNLCBTdGVwaGVuIEhlbW1pbmdlciB3cm90ZToNCj4gPj4gT24gRnJpLCAy
NCBKYW4gMjAyNSAxNzo1Mjo0MyArMDAwMA0KPiA+PiAiQ2hhdXRydSwgTmljb2xhcyIgPG5pY29s
YXMuY2hhdXRydUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+Pg0KPiA+Pj4gSGkgU3RlcGhlbiwNCj4g
Pj4+DQo+ID4+PiBUaGUgY29tbWl0IG1lc3NhZ2UgbWF5IGJlIG1pc2xlYWRpbmcsIHRoZSBsb2dn
aW5nIGludGVyZmFjZSBkb2Vzbid0DQo+ID4+PiBjaGFuZ2UgaGVyZS4gTm90ZSBhbHNvIHRoYXQg
SSByZXVzZSBleGlzdGluZyB0cmFjZSBwb2ludCBmcmFtZXdvcmsNCj4gPj4+IGZvciBzb21lIG9m
IHRoZSBlcnJvciBsb2dnaW5nIHdoZW4gcmVsZXZhbnQgKHNlZSBwcmV2aW91cyBjb21taXQpLg0K
PiA+Pj4gSGVyZSB0aGUgc2NvcGUgZm9yIHRoYXQgYnVmZmVyIGlzIG1vcmUgbGltaXRlZCwgbm90
IGEgbmV3IGxvZ2dpbmcNCj4gPj4+IG1ldGhvZCByZWFsbHkgKHRoZSBjb21taXQgbWVzc2FnZSBp
cyBtaXNsZWFkaW5nKS4NCj4gPj4+IFRoZSBxdWV1ZV9vcHNfZHVtcCgpIGFscmVhZHkgcHJvdmlk
ZXMgYXBpIHRvIGR1bXAgZGV2aWNlIHNwZWNpZmljDQo+ID4+PiBpbmZvcm1hdGlvbiByZWxhdGVk
IHRvIHF1ZXVlIGludG8gZmlsZSAobG9nZ2luZyBpbiByZWFsIHRpbWUgaXMgbm90DQo+ID4+PiBh
biBvcHRpb24pIGJhc2VkIG9uIGluZm9ybWF0aW9uIGFscmVhZHkgaW4gUE1EIG1lbW9yeS4NCj4g
Pj4+IFRoaXMgbmV3IGJ1ZmZlciBpcyBwdXJlbHkgdGhlcmUgdG8gYWRkIHN0b3JhZ2UgZm9yIHRo
ZSBzdHJpbmcgb3V0IG9mDQo+ID4+PiBydGVfYmJkZXZfb3BzX3BhcmFtX3N0cmluZygpIGZvciBm
YWlsZWQgb3BlcmF0aW9uIG9uIHRoYXQgcXVldWUsIHNvDQo+ID4+PiB0aGF0IGV4dGVuZCB0aGF0
IGNhcHR1cmUgYXMgdGhpcyBpbmZvIGlzIG5vdCBzdG9yZWQgYnkgUE1ELg0KPiA+Pj4gVGhlIG5h
bWUgb2YgdGhlIGJ1ZmZlciBjb3VsZCBiZSByZW5hbWVkIHByb2JhYmx5LCBvciBJIGNvdWxkIHN0
b3JlDQo+ID4+PiBjb3B5IG9mIHRoZSBhY3R1YWwgb3BlcmF0aW9uIGluc3RlYWQgb2YgdGhlIHN0
cmluZyBpbiBjYXNlIHRoYXQNCj4gPj4+IG1ha2VzIGEgZGlmZmVyZW5jZSBmb3IgeW91Lg0KPiA+
Pj4NCj4gPj4+IEkgZ3Vlc3MgaXQgd291bGQgcG9zc2libGUgdG8gbW92ZSB0aGlzIHRvIHRyYWNl
IHBvaW50IGJ1dCBJIHRob3VnaHQNCj4gPj4+IGl0IHdvdWxkIGJlIHF1aXRlIGNvbnZvbHV0ZWQu
IFRoYXQgaW5mb3JtYXRpb24gd291bGQgZml0cyBuaWNlbHkgaW4NCj4gPj4+IHRoZSBxdWV1ZSBk
dW1wIGNhcHR1cmUsIGFuZCB0aGlzIHdvdWxkIHJlcXVpcmUgYWRkaW5nIHRyYWNlIHBvaW50DQo+
ID4+PiBmb3IgZWFjaCBvcGVyYXRpb24gdHlwZSAoSSBkb24ndCBiZWxpZXZlIGl0IGNhbiBtYW5h
Z2UgYXJiaXRyYXJ5DQo+ID4+PiBzdHJpbmcpIGFuZCB3b3VsZCBiZSBhIGJpdCBvZiBhbiB1bmNv
bnZlbnRpb25hbCB1c2Ugb2YgdHJhY2UgcG9pbnQuDQo+ID4+Pg0KPiA+Pj4gQW55IHRob3VnaHQ/
DQo+ID4NCj4gPiBJIHRoaW5rIHRoZSBpbnRyb2R1Y3Rpb24gb2YgdHJhY2UgcG9pbnRzIGluIHBh
dGNoIDIgaXMgYSBnb29kDQo+ID4gYWRkaXRpb24sIGFuZCBjb3VsZCBiZSBleHRlbmRlZCBmdXJ0
aGVyIHRvIG5vdCBqdXN0IGVtaXQgYSBzaW1wbGUNCj4gPiBzdHJpbmcgYnV0IGFsc28gdGhlIG5l
Y2Vzc2FyeSB2YWx1ZXMgdG8gZW5hYmxlIGRlYnVnZ2luZyAoYmFzaWNhbGx5DQo+ID4gd2hhdCB5
b3Ugd3JpdGUgaW4gdGhlIGJ1ZmZlcnMpLg0KPiA+DQo+ID4gSXQgd291bGQgaGF2ZSB0aGUgYWR2
YW50YWdlIG9mIGhhdmluZyB0aGUgZGlmZmVyZW50IHRyYWNlcyB0byBiZQ0KPiA+IHN5bmNocm9u
aXplZCAoYmJkZXYgYW5kIGFjYyBvbmVzKSwgYW5kIGFsc28gd291bGQgaGF2ZSBsZXNzDQo+ID4g
cGVyZm9ybWFuY2UgaW1wYWN0Lg0KPiANCj4gV2hhdCBkbyB5b3UgdGhpbmsgb2YgdGhpcyBwcm9w
b3NhbD8NCj4gaG93IGRvIHdlIHByb2NlZWQgZm9yIHYyNS4wMz8NCj4gDQo+IFRoYW5rcywNCj4g
TWF4aW1lDQo+IA0KPiA+Pj4gVGhhbmtzDQo+ID4+PiBOaWMNCj4gPj4+DQo+ID4+Pg0KPiA+Pj4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4gRnJvbTogU3RlcGhlbiBIZW1taW5n
ZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiA+Pj4+IFNlbnQ6IFRodXJzZGF5LCBK
YW51YXJ5IDIzLCAyMDI1IDM6MjQgUE0NCj4gPj4+PiBUbzogQ2hhdXRydSwgTmljb2xhcyA8bmlj
b2xhcy5jaGF1dHJ1QGludGVsLmNvbT4NCj4gPj4+PiBDYzogZGV2QGRwZGsub3JnOyBtYXhpbWUu
Y29xdWVsaW5AcmVkaGF0LmNvbTsNCj4gPj4+PiBoZW1hbnQuYWdyYXdhbEBueHAuY29tOyBWYXJn
YXMsIEhlcm5hbg0KPiA8aGVybmFuLnZhcmdhc0BpbnRlbC5jb20+DQo+ID4+Pj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MiAzLzNdIGJhc2ViYW5kL2FjYzogYWRkIGludGVybmFsIGxvZ2dpbmcNCj4g
Pj4+Pg0KPiA+Pj4+IE9uIFRodSwgMjMgSmFuIDIwMjUgMTQ6NTU6MTkgLTA4MDANCj4gPj4+PiBO
aWNvbGFzIENoYXV0cnUgPG5pY29sYXMuY2hhdXRydUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+Pj4+
PiBBZGRzIGludGVybmFsIGJ1ZmZlciBmb3IgbW9yZSBmbGV4aWJsZSBsb2dnaW5nLg0KPiA+Pj4+
Pg0KPiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBOaWNvbGFzIENoYXV0cnUgPG5pY29sYXMuY2hhdXRy
dUBpbnRlbC5jb20+DQo+ID4+Pj4NCj4gPj4+PiBJbnZlbnRpbmcgYW5vdGhlciBkZXZpY2Ugc3Bl
Y2lmaWMgZXJyb3IgbG9nIHNlZW1zIGxpa2UgYSBzaG9ydA0KPiA+Pj4+IHNpZ2h0ZWQgY29uY2Vw
dC4NCj4gPj4+PiBXaHkgZG9lc24ndCBleGlzdGluZyBEUERLIGxvZ2dpbmcgd29yayB3ZWxsIGVu
b3VnaD8NCj4gPj4+DQo+ID4+DQo+ID4+IE15IGZlZWRiYWNrIGlzIHRoYXQgd2h5IGNhbid0IHlv
dSBqdXN0IHVzZSBERUJVRyBsb2dnaW5nIGZvciB0aGlzLg0KPiA+DQo+ID4gT3IgaW5kZWVkIGNv
dWxkIHVzZSB0aGUgZXhpc3RpbmcgbG9nZ2luZyBtZWNoYW5pc20uDQo+ID4NCj4gPj4NCj4gPg0K
PiA+IFRoYW5rcywNCj4gPiBNYXhpbWUNCg0K
