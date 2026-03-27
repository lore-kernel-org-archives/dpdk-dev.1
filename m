Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BC410ED66D
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 12:32:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4B35402C5;
	Fri, 27 Mar 2026 13:32:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 8FE7340280
 for <dev@dpdk.org>; Fri, 27 Mar 2026 13:32:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774614768; x=1806150768;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=knknKmlzTKnOM7waAyMmHV2Rapl0DO9KIhhNeP9QGPw=;
 b=fAR1qSNM7iljET7yHC7JWOjwIU+VCHdBe/w7RKJCOOzWwBIBprh60dJX
 aMxjfmU/orOs7RmRl1ZnMOV0gPdcQnN/ZQve6KmQ3uU+nV3ZHpkv6yP4d
 kMwQtKD0WL5qj5DRIJge7n5K3Zxcf5Vi0gojWxnoY5HeAt4yWyqFPvMFY
 ls6YjMUsIumK3W8Zs95WVc7TK1MIWpgKjEWwmE99E/X6EdGvoUVuNxovT
 oxQHCAdy0uvoK+3xDNLDAfv58v2dW+RGLJQKPOlqS3zbh/ZkuMOTiw7/z
 5KPkK1jFbiTVaIQbAoeKUgzfIUhlud0vgK3eEgJulSFNfCtapLzXkM3/s Q==;
X-CSE-ConnectionGUID: frO87RH5RzGbqraomeJ41A==
X-CSE-MsgGUID: 3YXN+3bVTmGQY98R8DF3bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75567827"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208,217";a="75567827"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 05:32:47 -0700
X-CSE-ConnectionGUID: VXLtTfayRN6olPCU2Y2dyw==
X-CSE-MsgGUID: Pajd2hvDQyu2eukFSAKImQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
 d="scan'208,217";a="221976468"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 05:32:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 05:32:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 05:32:45 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.4) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 05:32:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4A8Dy9FWojqcI1bkdUc4Vd3aVA8gT+fO8qK8aZpH81+UohAP6b2bIcsKH5I2Q9C9saOWAMhVISP5AZ8KOIjuPwz+ISA/OdrQEmwsvv0p/+xY7uuKpOb8b4jo9GIs0n1Hb8k+kLf+9bvL5IQhEALe/buQqDM/d6b5gUJTPiGQG/qAj/CJCwAyCs1y0D/jOV3L99vj1krdBWCTYVXbMz9SCVBEe9yrFYTD9RARJFUnBu+AvX0AEGAZMHYf7iML4uGlZK93+DLr1A8Hl3CTjaxPUXLdGOTmmqgZQkP8jkjJ6hUCsnmoCnc2soJegizxirLb1P1tBM0On+zW2tuFTi3OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knknKmlzTKnOM7waAyMmHV2Rapl0DO9KIhhNeP9QGPw=;
 b=huUR4bAm2cy+XNhjxOOM7NI43ORoTQzHk0QJd8lTpd2BVbXo+uwcWoQ4Neqln3kRjFfpuTc168mpwhpHnWIucFOUkW/1EHBtbOzioemqCFHPgRR6P2Gt1FhWwRaKDX0BU+cMdQ1sEbjLyAVygPVKDUyoPRP6Lc+GpXl5hpcIjlBGYnEZ5ENZKCLjIkMods6eYUjTZRnvdArVu3aP5B3rWY5+O6+z+PUmUshmcICZdx247KHG52HZRRh9+BOsupLS37L8w4/8anUfhjXLPgF5wuisdsGB3rHh0clf2FjAgTv0Fe0gfohfYFC1at05MkJ/FcNHYWZ9YPgvkgSD8pdyZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5)
 by MW4PR11MB7127.namprd11.prod.outlook.com (2603:10b6:303:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 12:32:41 +0000
Received: from CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e]) by CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e%6]) with mapi id 15.20.9769.004; Fri, 27 Mar 2026
 12:32:41 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [PATCH v4 2/2] doc: add device hotplug documentation
Thread-Topic: [PATCH v4 2/2] doc: add device hotplug documentation
Thread-Index: AQHcpyQhES4TnGMZ80GmESW5c3WCI7XCfSVX
Date: Fri, 27 Mar 2026 12:32:41 +0000
Message-ID: <CY5PR11MB631878C0C54C024C792B36A9FC57A@CY5PR11MB6318.namprd11.prod.outlook.com>
References: <17532da36934963d943f54de17c2d0d24dbfe8a2.1772112599.git.anatoly.burakov@intel.com>
 <aded6fabee0c70416df4d9eeca571a544e97fc96.1772112599.git.anatoly.burakov@intel.com>
In-Reply-To: <aded6fabee0c70416df4d9eeca571a544e97fc96.1772112599.git.anatoly.burakov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6318:EE_|MW4PR11MB7127:EE_
x-ms-office365-filtering-correlation-id: 270b8f61-2112-4f04-4dd3-08de8bfcf030
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: mCREzaKTvPRh6T1/iESuAbjW9ubzJxr1zc5Gf/7tXKuqVVCSq8SzgVQkNisc1qzp4ZMv2PKPk/VzdC7fDNUJjLjETZleAnHVm+dj8EHK4mcWKpm9kL+xW09XVxyTdN1+hwLYjY4sWajlSL+udaF6uW3j5YLvaAqat5svOyvEWwcSv6As4X9SoKLB4YHVVksxsHMumhpofXgJbG1Q/FTloF+EVy76qJwSGmEDxbSmImzOaThKCh4hs1JlkwhIaTioLlYgowaQM1sV/HAtHpOrxergcwQXPVDKbkkVjviznvkEMu7N8hKrYtK5/6EF522hDnK8oExe0zuKskg6ivXv02d20U18taC4umJ3myfC3ebRBQcq4INo3mjPgzSeR7QulQ6HyPFRG0FRT/FR5NtWIMgx63sOx0rG2pvJIw3U7tJQFqC7zI0BuUKWhk6gC3yg3CUNvE11bdnLiNSl2DMZ2VjFJlSI2dbCgF8mpKhf5gGxzW9Q4LavoQa/6rgjQYncWp9J6H5HVA4XtSkHMuERe3Oo0rI1c6EOzoWattj3bS6VFAzjstC7igeq6AHEDjP7UyWObA3J2xYkZLDpjBr49fTIctbwg4/eB9mg96DIvf5pm+6u0DS1x61HvhIgNY5lITAuAqY9r0rueVb9Z4Jf8HaTO4t9eKpvVqy/RKYRRo0aZcyfzn9wv81ZANrX49SD4x5uRdMt/7C+IQE6tUjpBhy+1np4BHmYHTsddLf+nNTqMOHB8kUwiDUIJdKtD42nSWWwbbn+uS2C21V/j8w9W2sCOzI95wDmtDKSPIXJQXk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6318.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(18002099003)(56012099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ubvBbxHmk9AbjlDGEM5QDYKfhpXN7kXkcrl0dmmfnpYXUO80yH2ReN8IXw?=
 =?iso-8859-1?Q?Qn8O1sg2W1zJwlpX4FRYpYP5NoO6KGCce9XnxNpknvEcHrWSy2FnYRpmk6?=
 =?iso-8859-1?Q?QCd7LHALx4aO7PqR1dY5LkO4TUelaH370Ou+Ti0w6SgALN7WjtKwNaTavu?=
 =?iso-8859-1?Q?BrstM0sJgLMYiqTmE0eNjA0LHzCN5rkFrGTXxR374BIcq3xfwjQzy3eV77?=
 =?iso-8859-1?Q?Jv3ASk1BvGFBbqsMheqnSSBsLDCu7wU/1lHaA/eHm4V+26mQZDSgrBL0/8?=
 =?iso-8859-1?Q?DzFu/9oQnVaug+WZTEX7Yfpl9IH3ql/2TXIsduoIcxLNzuAb9w3UN8xFq5?=
 =?iso-8859-1?Q?jNwg/7IykmPTsSV/cqdsHZz18gExjiXuB2s9+lCqzTCAhyXJDUaelrnCVE?=
 =?iso-8859-1?Q?Uysgt186igDIIvz+0Gav/+c0EVE6cp6co0MZ/vCwlFCxWfDAuPhYI4sHQX?=
 =?iso-8859-1?Q?DdpHBE3val2iqKbIaZihHBBuFhHTH4T9V2jcK4AMCDaa+5AAHwjtsiOldk?=
 =?iso-8859-1?Q?RFkckPBe0Ok7BIT2Lr6Cyvmhu6wh2hNZuk2/Gw/wVRtfu99UD7xPMTDaI2?=
 =?iso-8859-1?Q?5+tcX+IshM7a1uFohHV9ofNVZ2Ds4+FCDQrR3lZfa3ezsqN4IBLgncq/Zh?=
 =?iso-8859-1?Q?Q2U3cnFKRR/gPmxXCa+2ZIGjQ/bcTBRhZ+CyYNudCLTdGi0XOyU8oVr0pt?=
 =?iso-8859-1?Q?td2TWL9RP/T8Qj4nkCy3nLiX1UsoQUMUCrQlaj+aCBgTw1uApHdIppBsey?=
 =?iso-8859-1?Q?WrZDeUiZjdZid0/UKrxdWbJo9ZGybevBNCwTKqSgQCtLUgdHH/kY56cu5G?=
 =?iso-8859-1?Q?ZPKFX6qUZAPCQ9SvFFiEdovoZus5bAe31Pderm9Z/i5cyHO6xFVGcBf0h4?=
 =?iso-8859-1?Q?9NzhU45KwEowZ5d1kFHfcfrRCmUPwDV1GVcAU6/0kiUFo+pNSmsQAZ1pai?=
 =?iso-8859-1?Q?cTfMjpWdPT64nXqKk20uJqeZ98OMdHhbEUOozRdcQA3R1KoHgxZ+f4Vaom?=
 =?iso-8859-1?Q?oBTVKi04hvqzfCd7gAr4cmpbYlM6WeVA37meI6G9OqJhHMx0tJW+VZntdq?=
 =?iso-8859-1?Q?6p8FvgThVHa+3toBwG4Xrr9S/oHu1MVvRVBC11SDcK38ACLPABaR1KC4w7?=
 =?iso-8859-1?Q?l/OiJrtu86CixIG/zGCiR4ISMlr/h8/AwejXmOuIsoAe3d8luvuKkoRuht?=
 =?iso-8859-1?Q?wluePJZ24exLmFiznpwnDu19S4QCafSqn9uuk0DHpTycQI/nHLwzczOkUA?=
 =?iso-8859-1?Q?lQJiReWLaryJeO4vC0Xf1Ac2l5adFoMxQ/diKiVDa0rGEBks3+0G+F34Br?=
 =?iso-8859-1?Q?wEUFgTMuLGyKjz2JwHpUngbge1R8zo30j/TVyOrld0ymYnsW3uX83U+uhb?=
 =?iso-8859-1?Q?aNrOfREMm3eYoVW2zBMNd9LzEJq/Cp+B6b3X51b9HGzmdV3ZctOU3vo6Kv?=
 =?iso-8859-1?Q?m7Bg0y3XCb94SIdxodA1A3D9pxSHxrZoTV0oJjH5X0tOk8McKDX70T/HYo?=
 =?iso-8859-1?Q?cn8kx2m1f5Hjgl4XZubvkbftk+YRwQXEykuED6wTx4kh7X8hQgm8/w/sbn?=
 =?iso-8859-1?Q?p7NzX22HnSQTg1Zau3xKmk7Usk2W9FhPNKbskK6MI+0Es4edk9WEf0Za0o?=
 =?iso-8859-1?Q?i+SixWR1t8YH3eCj+ZjqPSSSkWYNz449R82VvTPdYcmqn/xx7jFScsL+Uk?=
 =?iso-8859-1?Q?7Z/PaQDW9aj27X/nmkk3K+u4CkdtxiX3qadx1Qsk6+9oPZSJK1un0o2DkA?=
 =?iso-8859-1?Q?NKFLy4KxBs4HtPpjil8vlqKaUY5iWdwJvty+lU8JCXz5RAnSXafzVpVQ+x?=
 =?iso-8859-1?Q?98o2vz7kDA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR11MB631878C0C54C024C792B36A9FC57ACY5PR11MB6318namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EcCLWPm0H1BxrZI8syB18cNOwCaxkqyqxNyuASdkMBRErHK6/+KetKV89iY0BNIkcdVQ4sqBxLtd9Ih3RdDHkoi2Il6EColL5H/GmCsOwp4IgMAekvO/uszCv8pi2x3lzuD0JhDOMGIAmn5gorn6a+0wv2aHcbvglmKh0LYm1XkJe6KZpFFVUrywFVlYOqNE/dbce+GGA1D02ZBYR1XKvAZadt5qzHoe4YvKPj09VDaa5ZaY2Dqnme6b+a8qY34qRjInRqI5f6KJC5kQ4EBWuDST/G9f8uVVLIancfmt+9vV1kK/AvUEjhf9pMQNO7AJO9e1St57PFWBS2olShN/oA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6318.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270b8f61-2112-4f04-4dd3-08de8bfcf030
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 12:32:41.0457 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X3MBicGHE0RWA3bX7aIBmwPRVHZBgDk39vxA0ETGaenAVPkxYIk07TRYKYqQw+wtN44kAgekH2B9iQGxwwwINQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7127
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

--_000_CY5PR11MB631878C0C54C024C792B36A9FC57ACY5PR11MB6318namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


________________________________
From: Anatoly Burakov <anatoly.burakov@intel.com>
Sent: Thursday, February 26, 2026 1:30 PM
To: dev@dpdk.org <dev@dpdk.org>
Subject: [PATCH v4 2/2] doc: add device hotplug documentation

Currently, device hotplug is not documented except in API headers. Add
documentation for device hotplug, both for user facing side of it, and a
high level overview of its internal workings.

Acked-by: John McNamara <john.mcnamara@intel.com>


--_000_CY5PR11MB631878C0C54C024C792B36A9FC57ACY5PR11MB6318namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-siz=
e: 12pt;"><br>
</span></div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Anatoly Burakov &lt;anatoly.burakov@intel.com&gt;<br>
<b>Sent:</b>&nbsp;Thursday, February 26, 2026 1:30 PM<br>
<b>To:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Subject:</b>&nbsp;[PATCH v4 2/2] doc: add device hotplug documentation <=
/div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">Currently, device hotplug is not documented=
 except in API headers. Add<br>
documentation for device hotplug, both for user facing side of it, and a<br=
>
high level overview of its internal workings.<br>
<br>
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">Acked-by: John McNam=
ara &lt;john.mcnamara@intel.com&gt;<br>
</span><br>
</div>
</body>
</html>

--_000_CY5PR11MB631878C0C54C024C792B36A9FC57ACY5PR11MB6318namp_--
