Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F73C83F34
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 15:16:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6938740DF8;
	Wed, 23 Jul 2025 17:16:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 3998840DD1
 for <dev@dpdk.org>; Wed, 23 Jul 2025 17:16:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753283789; x=1784819789;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sZtelGzh8+CH3HijqdNuNVuDWgzysYQ9IR+RrELr4wE=;
 b=n2aCUhevCyJReW8yw2P5yFzVz3KQtgcpBfIkf/b3P8s4/BvXDRGr+L9v
 ZF0Tsanx7bKMYMOnc5OZDT2t7GaDc8SOxuEIR5Yh0DLMiFcZlsIDyoFbr
 TBjmnENlzU+W/QDBfYY5OeyWWwkDTPQrHDtq5d1GBpdcscuzybkmhb/mF
 7ODyTn/SvSL1w+76NGT6PH2HgCzhiSIQK3kUADim4xji1LGGcLPELRKXf
 E0ug8cJpXWthxZIHogXzmz/zDByvJoxlFQdUgXCz3tQQIVG8HnY7uE/Lp
 DQK7aHq1cPGYzKJHk7w2PkMl9pfvTbiaiX5teA1oiZ5pL3tYx3ikS7c54 A==;
X-CSE-ConnectionGUID: x8MM1UrPTbek5G5ishTHyQ==
X-CSE-MsgGUID: UZ5+W4HqQB6XcAKsry/MZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59374728"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="59374728"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 08:16:28 -0700
X-CSE-ConnectionGUID: QkP+mpdZTpOkc35t+63Biw==
X-CSE-MsgGUID: HSR+zCdTQcWpwZsknYMmiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="164030959"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 08:16:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 08:16:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 08:16:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.40)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 08:16:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UiDwkvEfYBoIPHYTgWzz1+g5oHWT9dh2zOfzFhBTukbo27sKyfq4fIR0TQZbG/g7JbFjJLWnRXjDN1FXx7WzCbjZIVraXH5Gqsx+wkNrAl+y+CO41diGJCd/vcljcWupR/Biy/aykwoXIxb41Jwkcdf2QaIWhKirt2GfgK45XHXn0biQ3nUI7TOGqkYQcnyf5cM7VCAf4JDB+4Zsrj0qT5czZUdFvM1glzYK23UiytKK86/c0SSJvbvd+lG3bWT8OrgdcW8bSTG3xHbMdujA8DWsaDRoPS5w+MAGxKUgQWKEAmJjotnHP7Jd4pScbSk5pjdrtMMgJr+TCTheGMbCLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VR5iGz388xWXwmO5Hdi6M97MAyf7RtQUdU9pioAse7c=;
 b=s2qa6MjkHt7fxmll6bERGo59V1+phVopmIim1NVdsUqZ9+00grUNjchKuOouS3S1IumP4L2Ac7n7OaP2f3Wg6QQwNS7iB2bwVE/+rIe9m4CH8KaW5Jo9pwGr+YXZ/kVPZJfsNMzebbuj7rgC2mkS/xIVEn+jI4OF1LhyHYnBZq/42yUkTyeiBmUV5SCZI5a2bILpg/bNgPT9P9ezkP4y2i9Mj0Zy1c8q8rWBfokSsGtHy2gOOVMgvjmAN/rXfyWmYxqVrTp2tof6tco0my2KkSGnBNumKM/v6kf1kTVaisbwnEY5bpN6tTj1F8dvyROZ5NX7Ze2ocx13OtglwmPN1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA3PR11MB7436.namprd11.prod.outlook.com (2603:10b6:806:307::6)
 by DS0PR11MB8082.namprd11.prod.outlook.com (2603:10b6:8:157::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 15:15:48 +0000
Received: from SA3PR11MB7436.namprd11.prod.outlook.com
 ([fe80::f4da:1337:16ac:83dd]) by SA3PR11MB7436.namprd11.prod.outlook.com
 ([fe80::f4da:1337:16ac:83dd%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 15:15:48 +0000
From: "Dumitrescu, Cristian" <cristian.dumitrescu@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "Marchand, David"
 <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Allain Legacy <allain.legacy@windriver.com>
Subject: RE: [PATCH v5 20/22] cfgfile: fix section count with no name
Thread-Topic: [PATCH v5 20/22] cfgfile: fix section count with no name
Thread-Index: AQHb+9Z10hrsrTYieEu/i1eAgzB6PrQ/z4IAgAACBHA=
Date: Wed, 23 Jul 2025 15:15:48 +0000
Message-ID: <SA3PR11MB7436B56A7A6CB4E92E185803EB5FA@SA3PR11MB7436.namprd11.prod.outlook.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
 <20250723133157.159825-21-david.marchand@redhat.com>
 <aID61pJDV3gbZTeS@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aID61pJDV3gbZTeS@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB7436:EE_|DS0PR11MB8082:EE_
x-ms-office365-filtering-correlation-id: d174fd14-1fda-4efa-8eee-08ddc9fbcdbb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?pgnQZwlVgOWYyQbqqIJKdplQ6fxa6weIHaIe4xIBwsfTDmSq831YuyoKCiou?=
 =?us-ascii?Q?RTNuu4IGIuULWTb69f8zcb6jlDfghO9F04XK1Tpqq9aVeXGV/70ZfSfMZbGj?=
 =?us-ascii?Q?gNMcWDiDuXZE40226/RganlmOn9YhuaP71n8JXupxqYwVS+CUKi0am/1K9iJ?=
 =?us-ascii?Q?vzaV1CXv3C2n65Cl6q3jxPDJXeBufRhWk3YsfBZoL7PLgdPy6/GvyuacSEVw?=
 =?us-ascii?Q?+Du+nW0CEQEg+KjW4FuSDSEmE8O8xAbhstN4K3ptt6s9OF9Sfqe5dwId5JDy?=
 =?us-ascii?Q?HbKzVkL8HVwbmytlTYQJv5xkt6n3picqcgaQFz5kZNRKyOpDIzGUPBMVlR9e?=
 =?us-ascii?Q?d1lWQQ/i5PivQsg7R+FgYSeBWJNKrZCcJdht8Qr0hOdrUFi6newRI8gsXhde?=
 =?us-ascii?Q?aDKow5N0qEf8/tLUHvOMyVIXlhioHmrp+msbNba/Qll47AfJi7b+P8fW8RtW?=
 =?us-ascii?Q?irGSHYk4wbrpCUoc49oxXqt/UIsnPG/JvMSqDbJe3m9JByxxuQ4JN3b5NyLS?=
 =?us-ascii?Q?X9sXM6fyz40M/UrcjG9MehZo83TEQkkuSVkITnYzj4xTHf3B9NmDZwva50DD?=
 =?us-ascii?Q?U/YIpPJQyQtYBhJCmeRr0F9DP/ZSOKnnEYhCSv72ih/Ky5yv8bnsuOnLfrSN?=
 =?us-ascii?Q?ZAOdDzctN5+qsEvUfHzfn8NXH5uBxrqYppxEeqWY5a6UyRmLFO+eMUJx3m3W?=
 =?us-ascii?Q?Ukd5z5fhkhqjBD2RHEBdbfs2FLnxoQIA6BYMCUz07eXzyuK7+P2Q33kIt01T?=
 =?us-ascii?Q?EGjwTTxFsZ3ENbULAA6yyTs0dgtRUKlFLCsqdcUCM8mAQApwsaXsH3gpjCIr?=
 =?us-ascii?Q?0VUAVvyYTrSF8QlVoRUTmI5VqmBwjPH7XE2bncqYQXJSKzRszlcu3S1wgznT?=
 =?us-ascii?Q?wAecPYJzIKI3M5IRCceLePU1fNPAue/Uuf/X+wxJlfcw2dYEelDKQq1oSVfl?=
 =?us-ascii?Q?WkQ66bItYczjS1IUyoZBRAUkwCLypfO6DvRm2pZHQHYv/fAJURyVPCPTJj10?=
 =?us-ascii?Q?1fHB7B0euahypge42aOQPwPOyVlHNbu0zPTxcwICS5fbBkLJPIRcxR3M038k?=
 =?us-ascii?Q?J81L0eW4J7t+F1KDawxMckJ1WxOlUChNB8vtp/8E1Ona0Y03LJYF6Xqs7fyi?=
 =?us-ascii?Q?Y8YEeWNDpPAENhs6DKrNMYir1TEjAtQ53s0CJaZvuo7RXtMORgGj/DbOOjqw?=
 =?us-ascii?Q?oclSY96RAgVYR6dQBTGpLhB7zV2ipsNGYK1z+XF00hdgVWfjnr57fJssYkU6?=
 =?us-ascii?Q?EtQPTcFxN0bF89rM7ytdjgSHeNUzSMIPG9S68rcr2NxljCvwN4JB7Gqlzb9h?=
 =?us-ascii?Q?xr65INsppwbkNuptNsOj4bcMlwf3lHZagaheUbkqjWQ62gf5lgIlm7CK7Foc?=
 =?us-ascii?Q?PlboKNBeyvUyWZEvo4mWQaZEcMmGusY8N92ftTnfTCbjAK56VOZbagcAS1pQ?=
 =?us-ascii?Q?fMxKHNKY/EbP3v3HWRSfFeZbfn60OWOJvAwP5FEkQmCg/k5IzEF1rA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR11MB7436.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?87+a8UqETBK4/4hIB4b8OSUsKj5cTTOPryicfxImQiKwgso1MqsAPrQJM/ZX?=
 =?us-ascii?Q?s6nexPkldtAzNTf4Q0bUnaX2LrXZmiK/evv9UVKil+2W+C0o9R+BXq7+TSWi?=
 =?us-ascii?Q?wDFTQtLOHUGa/XO9s5/gaii0qaFoDjCkJZEN3K8xkoUHphocgr0UpnpX9uAX?=
 =?us-ascii?Q?251xrG2V2s/ksSpVmr3FPYtl6J8x7O9M4r6nuYadeB1ys+IxLZOaxyc4OMn+?=
 =?us-ascii?Q?wZXBveZaMZi8pa/Lgl8w8UBKp+feWuf+oWeZOUXV61Hwm6EWXYHFRGTZ6Er2?=
 =?us-ascii?Q?ZTCnQBIQlqsYmHmEoJr1CsVGqped4QmMZgqpFQN93o4bfjq5xWtAbwphr6tR?=
 =?us-ascii?Q?2dvBu6IbS2FYlQazG3c/uM1ECddWm5QUg82eQYRPmsyvZf/RqAkDCo1XQdbJ?=
 =?us-ascii?Q?S5794l61sStwe7GmPY56JlxgrPXqYjJuZfvcXEV5gaoSRLAbvU3Fon+cg6no?=
 =?us-ascii?Q?YjveTSpbCbQAe0pr8e23D4nYI2BkohmAEAxmHkLPheGQvHMTXMM2RxSa1TsB?=
 =?us-ascii?Q?/FO3e3TLAGTNemCfGHbMw2rpnPEMZQxJBcPzNDAAz/BDJry2zmpGtWleW6Ux?=
 =?us-ascii?Q?A7MH4OhagGFJFlPqUibAF4QzkU38JGCClgLZ0xP/kRaptRMSX/7Uy+sR7eXB?=
 =?us-ascii?Q?zBWu+NfAmi1ah3QbgFaKkaerKUrOW18pA7saQYidxj8YTz/BUinHpcYui1R8?=
 =?us-ascii?Q?746gdl7b+FCQS7iKe7ravqL+w26IGiPWwdV1tsNI9HkUD1kYXD4FpEHg7W58?=
 =?us-ascii?Q?Qs1qyhMUiCv6BM1L2syCj+JMIsp+OIBrk7nlWwKoJtxmIMmYt/qrBCbjRXrZ?=
 =?us-ascii?Q?tXP4ueHN0RCg1Adt/+sPTSqyFmg75jnBkgzqc9GiZwsp8McVIntgzA300CLo?=
 =?us-ascii?Q?m+YJeeXkPVah7EKR2WpCpmvhlgP13Ety7iI5Rfd3uOtKSkMbjZSBy/5r9kfc?=
 =?us-ascii?Q?9YlovBdbaKmsvZwC2ku0JVze8ovPi0nCynkj6HyMrp7t1DJRP5gCuPhXlqPt?=
 =?us-ascii?Q?/8R3GMvuiQcr1a6w77gs4mZPg7qyRmlCcN5FUxS039ZbZhcn0bxaXaFC6Dra?=
 =?us-ascii?Q?4XJuperUoplUFf0lwNUcLNMt736ftfj6VJC8+Dr7HTRPtPuZfW1y1OuBDc0y?=
 =?us-ascii?Q?da0lAklR3yF2EipPQHltqi13+RJCBTlwmsVjR9FyMzIX7J3xNMbSU7ennRO6?=
 =?us-ascii?Q?V/JXfbfpm1poMdMec44VHLvzE6qi1Hx9S1ofObJ/+PgJ4wUK0o1dSOHaKxNO?=
 =?us-ascii?Q?Ry5duYajF+x5ZL4jNtoYOeK+OfT50ZbUHtYHr+Bhrt2qtMhKqgHdExCgf6eu?=
 =?us-ascii?Q?v6hLCkBfwjJZQ8zUIyLnl6A/L/kLBeBHGwGRiU9Tk4kz8kqvAj6jEA5WUuJj?=
 =?us-ascii?Q?fijh1cp4Nu8hbXUI3yDsXrcKUusdZtNJ8k6dHZ/2OopNbFe6GOc1hS87iDAg?=
 =?us-ascii?Q?b1G1BEI2WOnhmjtJDdTqtYKgcN/5a2dpwqVkahDZ9Up+E7JDu0Fpn02XgsaH?=
 =?us-ascii?Q?exwVA6Rg4KydpF1Rsj13E4K28iimu/VPsmxHGGtuVzMX0sLSxDFsW5b3dYM5?=
 =?us-ascii?Q?3n9uqjcqwT3Mr/bd37BL/l7kt4fj2ANNDKOht7FqnM122pyO3lFrUpUIavZT?=
 =?us-ascii?Q?IQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7436.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d174fd14-1fda-4efa-8eee-08ddc9fbcdbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 15:15:48.1654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cC5eCEQKYNiQmPcgstSGT+M8cNJaz/u0b11OkC1FiR+h+VXMCpFKcCz9IWJszF2D6XB6oSZxXJcfqD+pB70PQCNwkA1HgsxhJ551l8W52+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8082
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
> From: Richardson, Bruce <bruce.richardson@intel.com>
> Sent: Wednesday, July 23, 2025 4:08 PM
> To: Marchand, David <david.marchand@redhat.com>
> Cc: dev@dpdk.org; Dumitrescu, Cristian <cristian.dumitrescu@intel.com>; A=
llain
> Legacy <allain.legacy@windriver.com>
> Subject: Re: [PATCH v5 20/22] cfgfile: fix section count with no name
>=20
> On Wed, Jul 23, 2025 at 03:31:53PM +0200, David Marchand wrote:
> > Passing a NULL to strncmp is incorrect.
> >
> >  + ------------------------------------------------------- +
> >  + Test Suite : Test Cfgfile Unit Test Suite
> >  + ------------------------------------------------------- +
> > ../lib/cfgfile/rte_cfgfile.c:475:7: runtime error: null pointer passed =
as
> > 	argument 2, which is declared to never be null
> >
> > On the other hand, it seems the intent was to count all sections, so
> > skip the whole loop and section name comparisons.
> >
> > Fixes: c54e7234bc9e ("test/cfgfile: add basic unit tests")
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>=20
> > ---
> >  lib/cfgfile/rte_cfgfile.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/cfgfile/rte_cfgfile.c b/lib/cfgfile/rte_cfgfile.c
> > index 8bbdcf146e..9723ec756f 100644
> > --- a/lib/cfgfile/rte_cfgfile.c
> > +++ b/lib/cfgfile/rte_cfgfile.c
> > @@ -477,10 +477,14 @@ int rte_cfgfile_close(struct rte_cfgfile *cfg)
> >  RTE_EXPORT_SYMBOL(rte_cfgfile_num_sections)
> >  int
> >  rte_cfgfile_num_sections(struct rte_cfgfile *cfg, const char *sectionn=
ame,
> > -size_t length)
> > +	size_t length)
> >  {
> > -	int i;
> >  	int num_sections =3D 0;
> > +	int i;
> > +
> > +	if (sectionname =3D=3D NULL)
> > +		return cfg->num_sections;
> > +
> >  	for (i =3D 0; i < cfg->num_sections; i++) {
> >  		if (strncmp(cfg->sections[i].name, sectionname, length) =3D=3D 0)
> >  			num_sections++;
> > --
> > 2.50.0
> >

Acked-by: Cristian Dumitrescu <cristian.dumitrescu@intel.com>
