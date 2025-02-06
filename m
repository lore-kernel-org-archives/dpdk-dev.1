Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43682C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 20:43:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3901B40EE2;
	Thu,  6 Feb 2025 21:43:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 192BD402BC
 for <dev@dpdk.org>; Thu,  6 Feb 2025 21:43:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738874604; x=1770410604;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7HMicsI14tDzn4gmRgHLukSL6vvvWVAlR6oCncR25YU=;
 b=XctM1dq2d/BNWGgHvkxsdkniF4prHGPCnUuRFTjPfByJ5xGDZDuSxgrq
 KZQJCAic3uGL479bhUZ/jqQ01v6XuOAdZhBMH5Gi24o1CbbI4hUu4eBT7
 g8aVln640v+6if4NBEYUOsBmVoVcQtMpqHBPDTPpZstH/AyHVSI5aHfum
 +eTHCSj7n2X8C2aVybHNww4lbAIkBFKBlxQyT0XNH2LCIVoST8WnQkf9v
 4e7XwqyLCw8Qrg2t50pZt6MWWy2lAMjYwWwC4AdogIXOBCqYDwpBkZHK6
 4HqIXHHgXzLDoowAHJ5Z8PjAxl5o3BTL2T7BXt5ncViFzE397T8Ho5x3Q g==;
X-CSE-ConnectionGUID: ECkJ0Au9RMm/fWF2CWG0lw==
X-CSE-MsgGUID: AnTGIKlCRWq39J+W9FMZ9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43263819"
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; d="scan'208";a="43263819"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 12:43:21 -0800
X-CSE-ConnectionGUID: qnqillyCRyOIB5rhsWYb6A==
X-CSE-MsgGUID: sDwnqwSAS9+xQoInkVudqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="148534893"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 06 Feb 2025 12:43:20 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Feb 2025 12:43:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Feb 2025 12:43:19 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Feb 2025 12:43:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfV9lxHulT/4PUK7uZp4x0Nxfr0cYaTmJYu6WWuC7Wrg0oihMIccVoqW9laKrO/ZbwV//gIxwWyI/29QweLCqnHea5fMj+afHvABOqPUXma7+zxub7L4oXq6R5jdbYFGPVn8Q3OQ1k9SsNhZFlSHLJINTcF/nQR8l6SG8rC0eujho7HDcMC3mLgjJvAyK9gzq8q0t1QfNJ0GdGlEnH5mHe5RXFlLZgem5B5Ys6mKXmWtTVytSUCJqBwkVG3y+Uryh3rXc4Bodm3msshAc6/2SoCi2WhnnAPBXqwAh8SgecgIiTtyXuktxpaZS9q5R61h7TDnliS5vaFP9oEE+IRDvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCytfAkm60yFUL23Zd+ntMJN8N1dE3bKi+viI9Kn3oY=;
 b=bcbluJv3+vsIuTAKhI/B1DDskyTFsoj3iL21imXqBrU+oWv3ItqWXm97MfTHHe9mI+4tZmuB46lK9F5v7S2YR1FyhprbKXY/wKaAgKgevqnus0eRvQ0jkEocZ8A08Jc4SSsdZzOPBRfemRU0cSF2Vc59gtm/XcXddcaXYZIJH5R5kRxWzt94bdpAIgCvsOiuD9Nj7V9jFAbeeidFDaaRGAMUW3Jd6QCGZVYs01uoNUlLEEla0u72GNxaibgR9xuyUhZmJBGJmQHsBBz3H2JwzCkfylCAJMQoq/YWhA9ymSEq/1Jo4EVf0g0fAqlKZEZTTIAKXet//ZylpmULPXZzdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by PH0PR11MB7471.namprd11.prod.outlook.com (2603:10b6:510:28a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 6 Feb
 2025 20:43:17 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b%7]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 20:43:17 +0000
From: "Kusztal, ArkadiuszX" <arkadiuszx.kusztal@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "ferruh.yigit@amd.com"
 <ferruh.yigit@amd.com>, "Ji, Kai" <kai.ji@intel.com>, "Dooley, Brian"
 <brian.dooley@intel.com>
Subject: RE: [PATCH v2 1/3] net: add thread-safe crc api
Thread-Topic: [PATCH v2 1/3] net: add thread-safe crc api
Thread-Index: AQHbFDfxcqxwzXrsXkKcW53MSd7bMrLT7LeAgGeZNjA=
Date: Thu, 6 Feb 2025 20:43:17 +0000
Message-ID: <PH0PR11MB501321A231397C6E9F9FA6D89FF62@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20241001181150.43506-1-arkadiuszx.kusztal@intel.com>
 <20241001181150.43506-2-arkadiuszx.kusztal@intel.com>
 <20241202143607.40555941@hermes.local>
In-Reply-To: <20241202143607.40555941@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|PH0PR11MB7471:EE_
x-ms-office365-filtering-correlation-id: babc6f8b-70b5-488b-6dd9-08dd46eee291
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?9OGASBXam36GIX5U5+QQU9M1Phadq5IfRfGQcnsn8Tu/b2ZE6hbrCM/q5RHt?=
 =?us-ascii?Q?3RXFcFUmQpIIQaw2r1gy4wke7ngLVqFGyqToFJcFEfzTpAOZQk0iBGf1htfk?=
 =?us-ascii?Q?oEd603vaMeK7sNSW45e+ayn/GLv5Io8wC2Bv1JsqhrbHJ+1nG7Xp5BFBj9/f?=
 =?us-ascii?Q?CuJB/NatvpUQxTFa1QxF79965eHKnFfrL5Rm+vuR8Bgisk756aprgNTlXrE5?=
 =?us-ascii?Q?IC3kGfhFvWVcbln+NHaFIaK0kfl9wYG7Ik+Epkezd+dvDODOB04942E7VPCl?=
 =?us-ascii?Q?mQTVjcT87wnEFnBWjnySaCV26e9zx2LuGGAEnvBaFk2jU6hj2a4SyqbQoWcM?=
 =?us-ascii?Q?sSRYKr1S8foa/XvlHmYH8vzl4LfBe/jrD/dsWUX/Ehlk/ne1ULXpjSFmJSxs?=
 =?us-ascii?Q?sEGAyLQuNbmzM0rI6JnxSQ0H5owquutFEZcdjRTydQuYmoEGMSLIQRN0a/C/?=
 =?us-ascii?Q?dP2FOpI63c3Rez0y1INxO8aMo2yLF4DI4hlCfiYskwkh5Igh4gJf2QnvEmiO?=
 =?us-ascii?Q?dICxEo2VnAo1TbuS1Fq8N9e/ziqUgaEtZsnxMbwtLXGWeeJAk7Nm5oBcXgJB?=
 =?us-ascii?Q?4NHYDJHrBt0jE/Yyun3G1U9113SljAfc6+NggBBqWWpHmpHH9WWb3ZdKX/tw?=
 =?us-ascii?Q?Wh5amB6wTLndbOaraPA1EhfIjkgTayyrXJ8qTCET0Ae6/sf8wvq67St4aoRs?=
 =?us-ascii?Q?DfOiaRF38y2bUat/NiAWqnuN0SirvB8IEeKZEsWeQTGoczakLvaoklbcqv57?=
 =?us-ascii?Q?WwY7RIgRpW5BakFm5Tn3BA6x694p37rn3zGEfewBnJPOPU+cliYLLYQ3J45k?=
 =?us-ascii?Q?6jDCm8ODmlxZC/PxEmZgvsxLdqrREYbGOHpN7e8LaWqFqdcmEYE/bhT38msr?=
 =?us-ascii?Q?/xFyPkBwgQxIXcZ6g7qMQs+mDLoCB/34E0dQhYU82kskPbRUawj7l/hyob57?=
 =?us-ascii?Q?BalgzqYdpFe3Cy5+OFyd5iK4I22fZgN0G+bFxhJv+RoGOGBEKtWa2p7TEv83?=
 =?us-ascii?Q?2gTwSmzVEikWboIG5o2AQBTYc81F+Q+Y4VPG62prPgKXsZQrrWDR/GXG9nH7?=
 =?us-ascii?Q?fO8BPLVSpX4UFhx4JyvTi/kg796OwzKlZW0LwOdsXIVdloYXEwXvDkyQlbjm?=
 =?us-ascii?Q?+YKpelcGIu5ArcHyzF91EAz8CjFQXqcjsSluyMpDBfcfRvK/qsTp8ATzJxTx?=
 =?us-ascii?Q?BWit9rbdSvWOIPHbxhuF9Xjpu5VJZtX0AFxNO42s83GHnGkiPn+vxnNeJqGq?=
 =?us-ascii?Q?AZNag0gyHAkbsqkmZsArKk2a3c9ylBWQF6oueFNEesC81MY4ilI1VQu8o5OG?=
 =?us-ascii?Q?eCFPpzhSHHKZyIKFmE3ev8uyTU59JV+mFeVir1qBsohdaVmXN/YCOgPqFxuu?=
 =?us-ascii?Q?EcNJhNgBw4UNt00QKrnbx8C/tLIRCV30p/nWee50/ShO2Lo6pMs/ojWE3DQP?=
 =?us-ascii?Q?CKEjBhVcy7Dr8PpA50+WaKLqfMzbQ0SE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5013.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/8vA0wxJvlJ9XGjotzcsYw3maQ8ZA3v4TTYrGTlmqsAPwzp1xx1owyPZtTt8?=
 =?us-ascii?Q?zjy0oxeYWyS8u//wKTmPwH/M0+JNGAM3itZHi8fDBGRvTPRpLmnF/xt1WapJ?=
 =?us-ascii?Q?4hc4u7+1c38EbhdbxBTJ7qV7YvjDJ/5ZnNQhzNKzsc8xbsg0mm13VgD6EbxE?=
 =?us-ascii?Q?Ub01GDWDqkWePp5twMOz/FwALLt76Bft/uFem+iGipFKjJtayD5rchEDFa18?=
 =?us-ascii?Q?hXa9dgGoTksDalS0WYhuzhdU6RXTu5shFqMM/99R7oSy7bDNKnQ2lhYvdf51?=
 =?us-ascii?Q?NKiOM7PsqzhrsaRFzfBW+iHdUSJ+wkyzKyRWkoKFK+WqLVRGMGVGn3aPL/a1?=
 =?us-ascii?Q?bkl9LArpCDKYioVovwQnuYVrLHggnXTM02shju6AQcZ//LRC4ygHsOTiGMq5?=
 =?us-ascii?Q?aEbfwoQYgjJmzoBDw008Lpydwzhsv52oEgG2tn9Z/D9OB4L85Aq6n63wNFBx?=
 =?us-ascii?Q?sBbR0oy4ctLN0csBek4biNIODUYsJu2GoLPRMMFc3S4VtKEv1oOcILDFLK/W?=
 =?us-ascii?Q?6abIoS94CW2JXfbw3eG++2h7Wj0/U80e8p/0HJKOZTrP7Ys4QvHvROcRv0B5?=
 =?us-ascii?Q?nAB0Z5c+Zo23XjCtP2T7pggoL1WVUW0JssOtYW/L+wKaP+AHPwRCSs66eV8L?=
 =?us-ascii?Q?0ZhoaMRWGe6to8kol+O4z3zy+R97FMPfVDDH0P5jWS9+W09cmSI6xBZKMlS/?=
 =?us-ascii?Q?y1yJHTiTumuO4s6sCPLiTKKriVD3oTnyw+iMolBgoQxJYj+q4lqwML80wN5s?=
 =?us-ascii?Q?AYcFrkJpexQxM9aJFdTWbA1kUG310uaTHskWfP1kvGw9BO3Lh+fSVQYj5+BM?=
 =?us-ascii?Q?ZpT8PyQt/+G+6i7YO54lKlqa7kimbRNNj1tzFZ7mrDbQYIKidsNav6NL2umt?=
 =?us-ascii?Q?/zWFnfNNxOaRjMWSjEvml3PHfWE7YxkZ/A+uwGOPNHdQYaHSUSrmGU+efCZB?=
 =?us-ascii?Q?/EjZI/363wopiHJGM+qtUez02fHMeUQ1dBqsJ+WCaiz+8ybbMnJahBQs+3f6?=
 =?us-ascii?Q?BX6IoNteo76nx1LfKPxHjmZSQCd2+j9tOJNCgqoCNjjipJySs0c7ob5R1BsD?=
 =?us-ascii?Q?txGsiXWMepOSm1ZXFT3jM1SajW7Ywd6gH7fGhRADx1WGH0JUUh2eQAqU4sQe?=
 =?us-ascii?Q?SusaHwT585K/rld/em/PcKQfthMXF4fU8byAJBlBJfHDvfIIZ26iy0PEqkbx?=
 =?us-ascii?Q?d0zNv9ax8k1nLpa4SwNO5QOE8/wq8ecuiUO8FTGAgWKZaqZAAZb0v0Bj6BDj?=
 =?us-ascii?Q?G0QVwBFhIR6y43TPlLYwjAdZ7SbTgcQZddLsDkGcpnzXmdk3RDgDPVJfn5rt?=
 =?us-ascii?Q?diCTF7o/hSyxYPW/76yQlStkGYXgTDKDF3Pl4ifMAw761/+DP2berekC+l+i?=
 =?us-ascii?Q?jF1uOXhCvWRysBnJwt1yyt+26uJ2TeHSjy3maG1hjlqfgd6zx6zpnv1i8MiC?=
 =?us-ascii?Q?WFXuD2KMS5oCeWmUw/BgUoycAECO3FQ2Q+gJssapmFostWACRVM5mKkIlE3W?=
 =?us-ascii?Q?zhYbKTrIxUHPQ8q0c+6yeByK2/WV+vamdERKKRbK0ZgECJ1PbQ/ODSopIzOB?=
 =?us-ascii?Q?WBmxTFwHqXIlc6SZxCZjhQkslb0nppg4FKY8LOMpxhiUL8ctyVN1L3lxscuN?=
 =?us-ascii?Q?nA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: babc6f8b-70b5-488b-6dd9-08dd46eee291
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 20:43:17.3253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KPyAFWXeR9/qyhPnkdBpVUoH5u4fN41ZyAmaRtpRBupbbCqg5Jy+DhgYV8ayAo1Qukziu7SvvMsH3/EaJYPTOOmjlGbACXXZazLIoRKugCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7471
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



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday, December 2, 2024 11:36 PM
> To: Kusztal, ArkadiuszX <arkadiuszx.kusztal@intel.com>
> Cc: dev@dpdk.org; ferruh.yigit@amd.com; Ji, Kai <kai.ji@intel.com>; Doole=
y,
> Brian <brian.dooley@intel.com>
> Subject: Re: [PATCH v2 1/3] net: add thread-safe crc api
>=20
> On Tue,  1 Oct 2024 19:11:48 +0100
> Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com> wrote:
>=20
> > The current net CRC API is not thread-safe, this patch solves this by
> > adding another, thread-safe API functions.
>=20
> Couldn't the old API be made threadsafe with TLS?
>=20
> > This API is also safe to use across multiple processes, yet with
> > limitations on max-simd-bitwidth, which will be checked only by the
> > process that created the CRC context; all other processes will use the
> > same CRC function when used with the same CRC context.
> > It is an undefined behavior when process binaries are compiled with
> > different SIMD capabilities when the same CRC context is used.
> >
> > Signed-off-by: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
>=20
> The API/ABI can't change for 25.03, do you want to support both?

I sent a new patch with versioned symbols. If this will not be accepted, th=
is potentially can be moved to the .11 release.

> Or wait until 25.11?
