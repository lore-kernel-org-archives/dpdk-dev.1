Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473EAC2A09A
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 11:30:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35C044026F;
	Mon,  5 Jan 2026 12:30:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id C5E7640267
 for <dev@dpdk.org>; Mon,  5 Jan 2026 12:30:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767612651; x=1799148651;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RtTUrdZ/IvjXGGbxL++4axdmUTlYEcuIzesGU5llsjo=;
 b=mgl/HKHNAcRDk/WF8+6POQMalsUlg22l3cePQ1GY1Z3CBl9ewnSirNQp
 dKpveC3YyTGO1uoVd0/x5D8sKs9G7N2bER2m8e7AlsurPASeB84JSTXcH
 yqoaQ8gnCOcPgg6r8IHmSbToh2Phed4LhWQXVKqRVOkacD3UtOiKBohuW
 jqYD3bqBamyQnyn4D0tEJPJS9LG7RB/JZAS4hqY+LdEOajtTg5oZJ8gEg
 q28QjElbW5qiO0oL+mgNOqh41j/4SlCm/k8hkm7fXjNJBy35E0gurYl7A
 Yc1prXEcqcZP9BiaUSTi5LJ0fKT3uCn9t0YB2Q90WdrA2G4UWikOAUgDm Q==;
X-CSE-ConnectionGUID: d9/kNrdjQsap3nZTPb6+lw==
X-CSE-MsgGUID: 6DdjqA0eRJyTAG7qHOX9BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11661"; a="94444427"
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; d="scan'208";a="94444427"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 03:30:49 -0800
X-CSE-ConnectionGUID: goeDrKlqRoOEllibiYlvsA==
X-CSE-MsgGUID: kpNa/lAFRJKdaiK2or/7IQ==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 03:30:49 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 03:30:48 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 5 Jan 2026 03:30:48 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.10) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 03:30:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0ScuL1C0YMEHWOoESkDxM9NjtBccfNRSmh8ajlFA5tgnHnwIhRSCULw9dXQJLtWWBq0kG0obAuyMxFco/wrIPlwGWvv2IYaizu6yiDFDbgV6PWVDl5e2yV/qPclAB4lt4CQmwsMWq7rshGataIdhFLkKofhEX5x8xAuCwbbI4YByAngjuEmf0b1C5vcvDvn9VD7TbJwbWTN1GWvQuwLDnbtwk48F62xwzecvfKMk+4+E6tY9LloKAqKyvtpsn9k2/Y1yub7f+wcB5iUMo/JTGIRS7iZPZRbZe5SYIvcsJkzeFQ12qqnPDnav8m4VlKctQWT14MAkbc9mIjDEm85Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Pa6yaSAC68iAbajqZq75m7o+Dsgt1+839RknBcmSys=;
 b=ypZsS4LxPJroLaD4mdIxF3J5rrV2dbNAveYAh9mIeJiduL5xcG1z13t7i6ZFt+EL7NeMTgtx1IC+TjICT73Id2Lqa3+qsnLGK4FOVM9R+OQmAL8CuasYujwOAPvLiZdOUW6xrVDWWyO3eACG0aN6t/qsPH7STB21EXIXh1Ht599iFVp8EG9OEoS1vH6qRJCkXSlW3b1m+MHFABqN7INkSE0xfeWwLkziqMx5eJcqMWsKv2NaN6gcaOLrfQM83D7S1p4BpdXin11t+563Yq+nhScpW7if55lAIMCeXt8hmgIze8p2U5HOmbTaZJgg2xpaOBzqCQCl7rwWx4KnICM9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 11:30:46 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::2b59:d9a6:8854:e9b9]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::2b59:d9a6:8854:e9b9%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 11:30:46 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "mb@smartsharesystems.com" <mb@smartsharesystems.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>
CC: "Burakov, Anatoly" <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v5] net/ice: add MAC anti-spoof option
Thread-Topic: [PATCH v5] net/ice: add MAC anti-spoof option
Thread-Index: AQHceYIypD5T/+EglUuH43h1ow40F7VDegOQ
Date: Mon, 5 Jan 2026 11:30:45 +0000
Message-ID: <CY5PR11MB61160E26A3AFEA280405C580E486A@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20251113105914.34949-1-anurag.mandal@intel.com>
 <20251230114828.6156-1-anurag.mandal@intel.com>
In-Reply-To: <20251230114828.6156-1-anurag.mandal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|CY5PR11MB6366:EE_
x-ms-office365-filtering-correlation-id: d2e49bcb-e88b-474b-e04c-08de4c4dde57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?pO+t0d0COU3camifpwnm6b4ZlrSp1oST86rnY2Enj8jzTJ8vK+tKrWXyQq?=
 =?iso-8859-1?Q?cv+sm33l2Zpq/x6LjOinaoN6xcrx3H1Oaz1KuRd5of/vG3vNnavLI8hQC3?=
 =?iso-8859-1?Q?MuLZowd5Y+XSJyly5VSpuOswSDi4nOtrU6BEFSxLbgBO7xOD/XHj11U2a8?=
 =?iso-8859-1?Q?MMnI5/JZ9nbYtWtZXJ5E6agX8VdBUYYM8Z2RXP+XteKOinaCs0w1AXtzoQ?=
 =?iso-8859-1?Q?atK1Xiytj3hptHY9yydtw0iGTFYQKLzDwMba1eWYB8mDhq0ehdSvJHHzI4?=
 =?iso-8859-1?Q?KTHn036EykCiCJ/tJpHjTQyYSb3CMiyRIzZd5+olVEjHQJFCsanEi13xWK?=
 =?iso-8859-1?Q?J2fHMY9Otu1PUfWq9Cdte4/awkGMp6iJTc9PDj0wbtzwhMQPWKUBWJcn43?=
 =?iso-8859-1?Q?R5AdfYBCp1GimSt7ypGMd6DtBTwLVT62gq7B5JoKk/vxa/qxh8jEH1b24W?=
 =?iso-8859-1?Q?3a5FY+titPe0tF0I3FaO7gyBnN9VYSwag6Wk06rHwaWytr9GjFx2ZRafHa?=
 =?iso-8859-1?Q?Ie/A5ukXksclzI2HhqGIa3vKv22Fad8FIK4RBBGg9n5Z7ea7C4prl3uHEO?=
 =?iso-8859-1?Q?iqt1t+nz8b6+dv4cQ2bHh8dxXINKe60GkELTL68gBF/nQ5r8fBkYrMblx1?=
 =?iso-8859-1?Q?B21YyXTEllpgMKzwq4OimUGOswOSzxbGegFeDHcrBaqqp7UlvqvkJ2spCS?=
 =?iso-8859-1?Q?6A0N19kk3ARHUwKY/1pZTmVQRURvZl0lrAlwsMj2TcG4of+nX0kzZPejuF?=
 =?iso-8859-1?Q?izXvGsZhBeCc3yO42vA68xz4JnV2NrDbDsSF9+jORtThnhQz6AMWkpBksK?=
 =?iso-8859-1?Q?nLI8o9yRWaiLWbawJbRqhGHjcU7BaXFXdqAZFY5blaBz4r0mKmS52eWMol?=
 =?iso-8859-1?Q?88N/OfOA9OzzTMO2bMLMTIgm0E5Wi7k9GZVA06LNFaJE10AzCK0d5ZOAvN?=
 =?iso-8859-1?Q?zOsdOR+joyL/IeQNrlwTE3dWTlvyE6j1V6sghx0FrER7rwljv2Z/6woF5B?=
 =?iso-8859-1?Q?f+OQyvrdtE6iJhYE6SOG4xTY1bLItqSHn1McxaMQLlZmc/PktjQpXj2aD/?=
 =?iso-8859-1?Q?tSxd5Fhlv/k8GWA9bd5kVLJAl8fzeWv5Q7lNRbV5L69oPpUtl2DbV2PDwd?=
 =?iso-8859-1?Q?lxIGrtRElQeVZq2rFejaNUf2xvycjn+4kL85U+J5KgtZPfRL6Uxteswvr/?=
 =?iso-8859-1?Q?HuH658DMEiOAuDcDRtAUU/EZQryIt1A172/bDsVnA/XAnHa11nO12pYwkr?=
 =?iso-8859-1?Q?PUbHetg7R3/s9ijuIBytu0wgWBKKklPdAz5hPQcxsT+2G9jq7gkn135oPu?=
 =?iso-8859-1?Q?IDPpqefPr/3x0tu1qInz/vAUSkJqIte1gY7Qo+gfTGwvdwOeIxIy78shPu?=
 =?iso-8859-1?Q?YoYEttXShOuqcu/5XSdm/Neg8epsmhczaozHxtM3bOMMEqz1aoGCrD2H03?=
 =?iso-8859-1?Q?CUOEzVrCKQ0DLHArnfHQeaUufnIT50JdDy2us9sPd9WDKc1xC7KaAZ7TgP?=
 =?iso-8859-1?Q?LS/3fYG7aTYf5LLHmIFX5F+GcHJln4bvD12+dxLxewz1YaQjKF1EBiKdKz?=
 =?iso-8859-1?Q?lUia1KFjvqC5j263NyY6Bt0Z1QoV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qCMgUzNgBq4/STf2mCK/mv1dNDPS6R99ihv1QQv/phSSo/Hhf6IKY3kqJ2?=
 =?iso-8859-1?Q?EwSQEJUZujP+zTTwALEN5wrmuPdxGm3fx9UcDXG1ZIkkS5//7h0o/TTsi7?=
 =?iso-8859-1?Q?94Qe8VMhRrG/OPSWBejSZGaHOJDoVAmZjP1BdtQebjBzF+Q8dFvYA342KG?=
 =?iso-8859-1?Q?29GtUhGp3lnq2Orae45n+wdJp/2A/1JcuyQoEYpM1TGO3TvR1qzE9bSeR2?=
 =?iso-8859-1?Q?LqBfgpxdYDXFffWc/DjGKQVhyoWxX2xDQrxMFd8/lfLqOPuVfNksGv23YL?=
 =?iso-8859-1?Q?WLtbrCMCQd9C+H5q06ink6gDRczDa1KlLhc00oxdevIUkfqfN8tEvD2d/+?=
 =?iso-8859-1?Q?Etwdfa4ghSAsaP5FS6nbfY63dnLcFS0SWGTMyzMr7+xNI3EAz1qaB1XJgK?=
 =?iso-8859-1?Q?HXSWwKYbQa4fRjK2+NXjeoQeic1ON7pdzsmXzYx8y6GuE8676Q40TOSQMf?=
 =?iso-8859-1?Q?C7OBwJ+T6baX1mTHh5kOPXafjnOYG1lBXJa35QomHbESRWXb1MAO9UXna8?=
 =?iso-8859-1?Q?Nf4K+HepT4LcYm8v23Lu1PF079hhH15P+qMVFXUiwS2LhNLDSDuhRXK9vH?=
 =?iso-8859-1?Q?Dpo4DroUhZDLHbWGrFHYgtvaYX7WGi25yq/aBrbH8oWVoG+y2yygHXHcaC?=
 =?iso-8859-1?Q?WhRTTt6vPwvMSH6w0/PbzIOzjXxy7UIpI+lUprsftOW0FNKvEhJ3TH+oE6?=
 =?iso-8859-1?Q?MhUyRnu9quqloBYdAqH9mLpGJdXVztLYUizWgRJyqTDr6XnbJtDLkwhKLp?=
 =?iso-8859-1?Q?6zuCns5yCsz5jETCR/B+q7A9zCYSm2Mpm3Tcyt+AjPbfw8HymnqF+z98Js?=
 =?iso-8859-1?Q?21m4gaWWB2orXUF857GJt2FB0AZ3TvmdPfGVuRcU/44lWGUCBTwVGU0OEg?=
 =?iso-8859-1?Q?fbDZRsLZDXCu0dy/4JQytG09ehj0Hh5zuHvYM1SrI3QqFzc9ouYZj86Qdt?=
 =?iso-8859-1?Q?IKGZww2BY0OxK26W9Q5GDOFD9Gh4bX8oU1abjd0TRhPUfKBwJ6Sbq6Mx/f?=
 =?iso-8859-1?Q?m4krl9zNYqm4ueCROgQGAMKGAWSaJ739z6IyGAy6ot1+L6ogUo1igMbA8+?=
 =?iso-8859-1?Q?u0tT27xMjngj/vabJGBmI/9/mLcjrpN3FNzWgAYhgQELcz/BZxK/ZTVMNO?=
 =?iso-8859-1?Q?y6aQxSaL4I/N0nWjzR8SBrpa4XlMUQw7UeLmRewpaUmhi1vxy6FTFbNtVR?=
 =?iso-8859-1?Q?KauGSteCaJ1a9BJgkD6I/fX0RijkDJbeSj1bKm24DYYmIw94S2KLCcWbUt?=
 =?iso-8859-1?Q?leScDkscZNntyROaMk6ejgMpHEQZclRXEq/p86sKsmioCnuRwxIe2zfN16?=
 =?iso-8859-1?Q?X8fhyXF4T59N2YNWx9pwHEsnmi6ABHANB1Gl8h5rspjsfA66b+yi7liMWy?=
 =?iso-8859-1?Q?xl4sValLL/0h/JUeIfvc1oz5hOUsdc7NrExyZxiFbSu4HSN1/8XyDRZunV?=
 =?iso-8859-1?Q?DxI7P5dz+/XJ++1b788Zvv7HbSFUovPT3BMq+yKmEn7WxzTUc030CgqE2Z?=
 =?iso-8859-1?Q?oytRnciaM37184vZj4+836XKq0e3MWEaya0uJlYx5OmNdwAfEPfB9C5kJQ?=
 =?iso-8859-1?Q?nZddHVegV2XI+RB9rDeIMCRYFgP3LTTfL8YEWM5UKG4CZag+crskuUfFWv?=
 =?iso-8859-1?Q?ibotTASNX9OH6JMKAIIEvQNJS5cx2jjgeWDSHsqvv7zm+6w5Kj2EsjQfuN?=
 =?iso-8859-1?Q?QpjtswrJT3HCU2+o7hVmBZOs6FrGjKrFKLoggku9/NtVhODFF0jUolkY3K?=
 =?iso-8859-1?Q?yI8iCpedo6InI7cyNcOUcRwkgCULL+InSBDzg+GVUjv3a22IVHK+7HAqGS?=
 =?iso-8859-1?Q?BtqoUFoJ3Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e49bcb-e88b-474b-e04c-08de4c4dde57
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 11:30:45.9382 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /LIfjF0WFmLBCRkBT8i1EXIq+xJwEEn4h0bOg+BWvjbW9v9FyPQ16+zika3Gvo3oynRu2ikRj/kK+VIFAgFTKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6366
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
> From: Mandal, Anurag <anurag.mandal@intel.com>
> Sent: 30 December 2025 17:18
> To: dev@dpdk.org
> Cc: Richardson, Bruce <bruce.richardson@intel.com>; Burakov, Anatoly
> <anatoly.burakov@intel.com>; mb@smartsharesystems.com; Mandal,
> Anurag <anurag.mandal@intel.com>
> Subject: [PATCH v5] net/ice: add MAC anti-spoof option
>=20
> VRRP advertisement packets are dropped as TX-errors upon transmission
> from a vsi of ice PF due to MAC anti-spoof check, which is enabled by def=
ault.
> There is no way to disable this security check in the Tx direction to avo=
id these
> packets being dropped.
>=20
> This patch introduces devargs "mac-anti-spoof" to allow user to disable M=
AC
> anti-spoof check. Disable MAC Anti-spoof check in the Tx direction to sen=
d
> outgoing packets even when their destination MAC address matches one of
> the MAC addresses assigned to that same NIC port and avoid getting droppe=
d
> as TX-errors.
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
> V5: Addressed CI failures
>  - Removed ICE_AQ_VSI_SEC_FLAG_ENA_MAC_ANTI_SPOOF
>    flag as that is causing CI failures and observed
>    MAC Anti-spoof check is enabled by default
>    irrespective of that flag.
> V4: Addressed ASan CI failures & Morten Br=C3=B8rup's feedback
>  - set the default value of the devargs to 1
>  - enabled MAC anti-spoof check by default
>  - provided devargs option to disbale the same
>=20
> V3: Addressed Morten Br=C3=B8rup's feedback
>  - set the default value of the devargs to 0
>  - disabled MAC anti-spoof check by default
>  - provided devargs option to enable the same
>  - synchronized with source prune
>=20
> V2: Addressed Bruce Richardson's feedback
>  - changed devargs name to "mac-anti-spoof"
>  - changed devargs member name to "mac_anti_spoof"
>  - changed macro name to "ICE_MAC_ANTI_SPOOF_ARG"
>  - set the default value of the devargs to 1
>  - added NOTICE log msg when MAC Anti-spoof is disabled
>  - added more code comments to provide clarity
>  - fixed typo error with ICE_AQ_VSI_SEC_FLAG_ENA_MAC_ANTI_SPOOF
>=20
>  doc/guides/nics/ice.rst            | 12 ++++++++
>  drivers/net/intel/ice/ice_ethdev.c | 44 +++++++++++++++++++++++++++++-
> drivers/net/intel/ice/ice_ethdev.h |  1 +
>  3 files changed, 56 insertions(+), 1 deletion(-)
>=20
> diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst index
> 6cc27cefa7..c3e9cfaee3 100644
> --- a/doc/guides/nics/ice.rst
> +++ b/doc/guides/nics/ice.rst
> @@ -194,6 +194,18 @@ Runtime Configuration
>=20
>      -a 80:00.0,source-prune=3D1
>=20
> +- ``MAC Anti-spoof Disable`` (default ``1``)
> +
> +  Disable MAC Anti-spoof check in the Tx direction to send outgoing
> + packets when their destination MAC address matches one of the  MAC
> + addresses assigned to that same NIC port.By default, these  outgoing
> + packets are dropped due to MAC Anti-spoof check.
> +
> +  MAC Anti-spoof can be disabled by resetting the devargs parameter
> + ``mac-anti-spoof``,  for example::
> +
> +    -a 80:00.0,mac-anti-spoof=3D0
> +
>  - ``Protocol extraction for per queue``
>=20
>    Configure the RX queues to do protocol extraction into mbuf for protoc=
ol
> diff --git a/drivers/net/intel/ice/ice_ethdev.c
> b/drivers/net/intel/ice/ice_ethdev.c
> index c1d92435d1..7251b111e0 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -42,6 +42,7 @@
>  #define ICE_DDP_LOAD_SCHED_ARG    "ddp_load_sched_topo"
>  #define ICE_TM_LEVELS_ARG         "tm_sched_levels"
>  #define ICE_SOURCE_PRUNE_ARG      "source-prune"
> +#define ICE_MAC_ANTI_SPOOF_ARG    "mac-anti-spoof"
>  #define ICE_LINK_STATE_ON_CLOSE   "link_state_on_close"
>=20
>  #define ICE_CYCLECOUNTER_MASK  0xffffffffffffffffULL @@ -60,6 +61,7 @@
> static const char * const ice_valid_args[] =3D {
>  	ICE_DDP_LOAD_SCHED_ARG,
>  	ICE_TM_LEVELS_ARG,
>  	ICE_SOURCE_PRUNE_ARG,
> +	ICE_MAC_ANTI_SPOOF_ARG,
>  	ICE_LINK_STATE_ON_CLOSE,
>  	NULL
>  };
> @@ -1761,13 +1763,46 @@ ice_setup_vsi(struct ice_pf *pf, enum
> ice_vsi_type type)
>  		/* Source Prune */
>  		if (ad->devargs.source_prune !=3D 1) {
>  			/* Disable source prune to support VRRP
> -			 * when source-prune devarg is not set
> +			 * when source-prune devargs is not set
>  			 */
>  			vsi_ctx.info.sw_flags =3D
>  				ICE_AQ_VSI_SW_FLAG_LOCAL_LB;
>  			vsi_ctx.info.sw_flags |=3D
>  				ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
>  		}
> +		/* MAC Anti-spoof */
> +		/* By default, Source Prune in Rx is disabled
> +		 * and MAC Anti-spoof check in Tx is enabled.
> +		 *
> +		 * Source Prune is disabled by setting local
> +		 * loopback with ICE_AQ_VSI_SW_FLAG_LOCAL_LB
> +		 * flag in the Rx direction.
> +		 * ICE_AQ_VSI_SW_FLAG_SRC_PRUNE is added to
> +		 * prevent transmitted packets from being
> +		 * looped back in some circumstances.
> +		 *
> +		 * MAC Anti-spoof check can be disabled by
> +		 * clearing ICE_AQ_VSI_SW_FLAG_SRC_PRUNE
> +		 * flag and setting Tx loopback with
> +		 * ICE_AQ_VSI_SW_FLAG_ALLOW_LB flag in the
> +		 * Tx direction.
> +		 */
> +		if (ad->devargs.mac_anti_spoof =3D=3D 0) {
> +			/* Disable mac anti-spoof check in the
> +			 * Tx direction to avoid outgoing
> +			 * packets getting dropped as
> +			 * TX-errors for VRRP support when
> +			 * mac-anti-spoof devargs is not set
> +			 */
> +			vsi_ctx.info.sw_flags &=3D
> +				~ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
> +			PMD_INIT_LOG(NOTICE,
> +				     "Disabling MAC Anti-spoof check "
> +				     "in the Tx direction does not "
> +				     "affect Source Prune in the Rx direction");
> +			vsi_ctx.info.sw_flags |=3D
> +				ICE_AQ_VSI_SW_FLAG_ALLOW_LB;
> +		}
>  		cfg =3D ICE_AQ_VSI_PROP_SW_VALID;
>  		vsi_ctx.info.valid_sections |=3D rte_cpu_to_le_16(cfg);
>  		vsi_ctx.info.sw_flags2 =3D ICE_AQ_VSI_SW_FLAG_LAN_ENA;
> @@ -2398,6 +2433,7 @@ static int ice_parse_devargs(struct rte_eth_dev
> *dev)
>  		return -EINVAL;
>  	}
>=20
> +	ad->devargs.mac_anti_spoof =3D 1; /* enabled by default */
>  	ad->devargs.proto_xtr_dflt =3D PROTO_XTR_NONE;
>  	memset(ad->devargs.proto_xtr, PROTO_XTR_NONE,
>  	       sizeof(ad->devargs.proto_xtr)); @@ -2467,6 +2503,11 @@ static
> int ice_parse_devargs(struct rte_eth_dev *dev)
>  	if (ret)
>  		goto bail;
>=20
> +	ret =3D rte_kvargs_process(kvlist, ICE_MAC_ANTI_SPOOF_ARG,
> +				 &parse_bool, &ad-
> >devargs.mac_anti_spoof);
> +	if (ret)
> +		goto bail;
> +
>  	ret =3D rte_kvargs_process(kvlist, ICE_LINK_STATE_ON_CLOSE,
>  				 &parse_link_state_on_close, &ad-
> >devargs.link_state_on_close);
>=20
> @@ -7732,6 +7773,7 @@ RTE_PMD_REGISTER_PARAM_STRING(net_ice,
>  			      ICE_DDP_LOAD_SCHED_ARG "=3D<0|1>"
>  			      ICE_TM_LEVELS_ARG "=3D<N>"
>  			      ICE_SOURCE_PRUNE_ARG "=3D<0|1>"
> +			      ICE_MAC_ANTI_SPOOF_ARG "=3D<0|1>"
>  			      ICE_RX_LOW_LATENCY_ARG "=3D<0|1>"
>  			      ICE_LINK_STATE_ON_CLOSE
> "=3D<down|up|initial>");
>=20
> diff --git a/drivers/net/intel/ice/ice_ethdev.h
> b/drivers/net/intel/ice/ice_ethdev.h
> index 72ed65f13b..5fe4688d57 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -617,6 +617,7 @@ struct ice_devargs {
>  	uint8_t ddp_load_sched;
>  	uint8_t tm_exposed_levels;
>  	uint8_t source_prune;
> +	uint8_t mac_anti_spoof;
>  	int link_state_on_close;
>  	int xtr_field_offs;
>  	uint8_t xtr_flag_offs[PROTO_XTR_MAX];
> --
> 2.34.1

Hi Morten Br=F8rup/Bruce,

Kindly review this patch. No CI errors reported.=20

Thank you.

Regards,
Anurag M

