Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F99606A326
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FxSKxU8W
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C83DD40E5E;
	Thu,  5 Nov 2026 11:12:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 0E37040296;
 Thu,  5 Nov 2026 11:12:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793873551; x=1825409551;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BF48GWDns62uk1fh/lxfpBwPXr7yXjrYIp/OlDySAq0=;
 b=FxSKxU8WPwjfFVPBlexLDvdcoiMmnU0f4lgDTFhEjFpZ/6WXxR4hTac1
 8/5jgtAlvUVk9yxi+c6hSmZUw0W+aAjTNeoP39PWMs6yuv9rmpVO3+eZ9
 hNDGa9aYLDLjSmbZ8tNwpM3teSlvWtI4QcEbdCJChy+yHJsgYrAmB93Vv
 z1JE1S8TGAKvT+2vLihuOSwMoKsdEuBdKhlO4a3cyg3ZhHtZc0ENK6jLX
 iz5ozsCxTRSc+vDRixSVIxj0MUoB1ZHQs22vFRDR+AfG4Yr2L7+bsLHgv
 YiWKd3ulRSwhO//Gg+AaRoZZpKo6xUjJnGUmrdBa0+RZHMRSH5wrxO5Aw w==;
X-CSE-ConnectionGUID: Ug7/vd6xReavotkKlvunTA==
X-CSE-MsgGUID: AeR0g3OwRCeRP17LmPbVdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2671039"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2671039"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 02:12:28 -0800
X-CSE-ConnectionGUID: ufH9SZW2TdyC/KOkP9ye1g==
X-CSE-MsgGUID: uO3df2QySAqPd6Hh0FCWDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="8833679"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 02:12:28 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 02:12:27 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 02:12:27 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 02:12:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxkrrAABgzdy3zEAadaexbxGMO2XP2TzFUhlpbA5O4MsLBWTfPgg78St6oawbzPeJ0Lo9agR05z/NZtA5H8Bhm3AKXa5e9Bu3etW27XJu5jiaW0obDQAOGSTk6ctP9f+MbzD3mCJdjDIu4wbCjzhJS/Vx4rxM4ElRlM1Axk1NkpadQq9tTv7OQ8KbWRSN47q22c32MsVxdh/9F6sNgXIJ4vGjkX31SfFmpcSAzMhQBM5RanXWaonM+0nhn1ue4NB6eZeX9u3tRp2nzeIkAFQu3ce2uGzYMrTOz/WxamJe86YB6uFVaFG90t/Trie5M79lYa2wJaII7X3Bn/OVjWmlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4n7q1lH/twafab6Nx0b6LwIx0geitcQiLaF3VlYxp8I=;
 b=saY/U2XFACkMgqFsyEIkftoevWlPituGewyGUsWiimKo5uiCLYq0Iq0AU1+XykVV4L+1IafQt8A/CMNQ9kBgrigtHs5K4eUlIJ7RZZ5Ld0YLA1wgdhvpE4Glv4Y2p9KTY4/JRjPVypUlb+FACMlOjteeucG0R9VGyY+06+otQLjUXy4OQDDz03QY2PHtEPba6WPqfr7Ms99ZdJT6eWhdD6BU/g0oL1C7dBhKWrpCPfLClHQhfrVKqCfOn72GmzkFmOCM8chpJdrW/p8qsxR8eZOmYpiP39TE3ZNRQpKGlIqdfE2iibM9XSrICoYei0NVLceY1hLAA8Nosw7QfYNwvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7442.namprd11.prod.outlook.com (2603:10b6:8:14d::22)
 by PH7PR11MB6499.namprd11.prod.outlook.com (2603:10b6:510:1f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 10:12:17 +0000
Received: from DS0PR11MB7442.namprd11.prod.outlook.com
 ([fe80::cc14:6cc7:5da1:8282]) by DS0PR11MB7442.namprd11.prod.outlook.com
 ([fe80::cc14:6cc7:5da1:8282%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 10:12:17 +0000
From: "Dumitrescu, Cristian" <cristian.dumitrescu@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, Wei Chen
 <allen.chen@jaguarmicro.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] cfgfile: fix isspace() undefined behavior
Thread-Topic: [PATCH] cfgfile: fix isspace() undefined behavior
Thread-Index: AQHdYiBDjyAxcRtNeECjpEpNREmA7bcfTO+AgAAK8EA=
Date: Thu, 5 Nov 2026 10:12:17 +0000
Message-ID: <DS0PR11MB7442D693AD4BB9C34800961FEB772@DS0PR11MB7442.namprd11.prod.outlook.com>
References: <20261022122348.3467-1-allen.chen@jaguarmicro.com>
 <auxNNQ5dWrmHG96_@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <auxNNQ5dWrmHG96_@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7442:EE_|PH7PR11MB6499:EE_
x-ms-office365-filtering-correlation-id: 76efd860-adea-4b09-c289-08df3b25458f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|4143699003|261022075727099003|11063799006|261009223027099003|261026140227099003|56012099006|261022105027099003|261028144727099003|261026121527099003|261102123227099003|261021121427099003|261021123027099003|18002099003|22082099003|6133799003|10067099003;
x-microsoft-antispam-message-info: mR1ZVIW6gAqMvz85kK3iqcyuE8TT0OBLYnPOgphBoPMMb7O1mZabYC8TiZ7zxwN5sLxNY85oqTGerijGNO6BsqhBE1Sqs6RODDp1PwYZavmf8FpED3GzF/StwUlu9F+QBzs0TzxYhLZzx/VEffrGcVm7sPnFY82Cy3RCap4ML4kfOpgcb86H+RWje7llEpM0V7vHkBjj4D1dTdHgL5kEgfCuBYTPkX9h9E+Ovul9HDDtw1K/qaypZYGx2/gyJIiqLsWzvb4rSRlzwjEf/vhuQuM29YF0MW4fMNrq25YgPdDOOYQ8IXACjkUI4NY//XZ/kaYpdn+6qTluW8EsEDUovBeveh8vusoBE58KGzGqUk/Uzst9jriND/Ko2c3F5AuYNoVY1+UtmScRn4I9/WJZWisnXCeH+sf9OeTFz8uyNFj2rfCouTP8AZ1LdUaEEXtxQ2fP+YGOVrtGe+1Cb29VvrLUMWECUayGriDGs6vspiRd9rMBjJbKP6fc2YG9XvJh1Anh7O/P7feE52bAA/KUKfS4A6fzh3wmwDWQM6WJPhsYQkdUvIFytmpfnwF3FnDXJQnVRT4UAvCa6w241R1ns60KZyg/3o/rJh4ysgjTa5Hl+nKJvzfDnoVPc84JZg8Sz4som1ZOZOf17PbJPHh4Y1VQCVZPYgGFRCs2uFmum42MalnbPUe7ytTbiCPywNXwHBCKyxUATkYIlhZylWbPGvgG9HbnZxFhbBkIeivJZwc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7442.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(4143699003)(261022075727099003)(11063799006)(261009223027099003)(261026140227099003)(56012099006)(261022105027099003)(261028144727099003)(261026121527099003)(261102123227099003)(261021121427099003)(261021123027099003)(18002099003)(22082099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U+jRznOygw5AYWRsBag5RSbc6RInUjC4rOuwi4tqF1BftDANSOEyyk7lKvgr?=
 =?us-ascii?Q?to0aoN7kNQuEDDUAF3HeaJBjJ+epsrgcNTo0w8nM6wYyjPlcisHUepEOjLEE?=
 =?us-ascii?Q?v+AxmN3DlYA9sNrvjFNP8hEE4mYKt7Gb7mUeI73doLatBqfd+gM8KWwLCRkV?=
 =?us-ascii?Q?KQArD09zlNR3x9hbPLDIyGc/aerZaHVwjsksdlc0a1FrZu3l0N+uvxqOkAgs?=
 =?us-ascii?Q?+vu9Yru5iZiQjE1fnSfgOAUo3JCMMLEjfiXx22CX9P5KOn86nbR6jcua546f?=
 =?us-ascii?Q?95joU+OWZXXKurCrUf356k5UQrZCF7DXZ/LSyjPBTfw6md6RfMlnGhVDEPvX?=
 =?us-ascii?Q?QM48llDQCeTWvG2n3iyoiOQl/UsZeLKeeCPYHj7xsIYoMOzRhpdHbqILmSQC?=
 =?us-ascii?Q?M0+ZssbV35sj7q4Nu2xjkYYdxzToCtWmbzBkcIKcZF/mVa/q/wwv0XpqddwF?=
 =?us-ascii?Q?ECI0ymGd92X0dVi0xYi11BoLfVMSmr3wUdj55ps15EFaAG0vOoP6azf4HJjm?=
 =?us-ascii?Q?7mYQ2KgrqMew6cXzVtyr7/nXLx9I5fwp1NPezIaMe5nJDSttR/WXBIU6MIYl?=
 =?us-ascii?Q?9parMhiJ4SEe4FPippm+IiMHUwd52eLRe9eP2YdIS3ut+ygsYzuS4eC/Vp0J?=
 =?us-ascii?Q?ML+5k+lKnz/hsFGxkzXkm+0PazwFg4yNx25dlBd3/wi7SuIeHukhq7hBJx7v?=
 =?us-ascii?Q?sJO3OavqG29iD1lbO3vdlR4FMAp5MyxMu8QG/dUFdNcH9iWa30AjjmP0jydg?=
 =?us-ascii?Q?MBtQSFEdByAt6BmXWIvSOJr5jl74EQQD7Jsr3Qpp8ObrCdsD0v1222aOsAGd?=
 =?us-ascii?Q?f3G6tFYV34X9vrpARGtx8mh7Z4qeEE6I/ax+9Vhwpn6BZc2pzVKUzGrhokl2?=
 =?us-ascii?Q?MRJPiTiBPZGPo71cd5i1DYGWYoBXjloEpij5CaFL7LvfR9FHaMCtDbffYxrA?=
 =?us-ascii?Q?FDSe/Jw7S2ESfPFhqBZ2k4FpS+hrCaCEAbSYPm93iOItOJ037ZvcYYAV+w+6?=
 =?us-ascii?Q?thzDM7DwTXAzuCtsNnkiCAfChMUeJUw9Ks9r0TDQH++Cqy53veeE6DQbVD2n?=
 =?us-ascii?Q?uasBSqK1rxoAfV0Vx/WwBOacHoWle9nF/bw5vAZ+dyLEUPMwcaPUGsx1keBv?=
 =?us-ascii?Q?5izHlPGW9CGyXcF6zvyxXgr7F6MP+xZkXX2W2K18fVhIy/BXbLnBwLoeVEH7?=
 =?us-ascii?Q?mBMUJufFZMsijYqzEsiS52UTT7GqEg/NvLMGbp1fjNQegBgo+qc+81qsOoW1?=
 =?us-ascii?Q?7E2bdyY3SaOODp5y7OZRy4OWJ7b6bcol+6RvrO4dtXBO0s93w+uE/wcV7RQJ?=
 =?us-ascii?Q?QFlcpKwc6PkMWqbXN/qQMfzNP1XwpNl2f/6TtqXrYG/Hyf4K/O9DgigC6XQM?=
 =?us-ascii?Q?BjLLGig/ybV1KoK9ztESvI7+vpiVUgQzNXTii27lfmWYUgsUTsxFZuyoLIo4?=
 =?us-ascii?Q?jxYyYJYFrSa7nZz+ZkkxhQsNgncZpBaFp2NTo/T6NK0/kobw1byE92O/l3y8?=
 =?us-ascii?Q?0dZtIEcy0pLurXfwbJa2anp5AxOzbZA6OYNE34qTI9wZMCKd8KOewm4a6pfc?=
 =?us-ascii?Q?XEncE/aeRscpw93X8nKisvNDdHm1bOMVGCXmIPhTdCVf2DgDFSQkHFV5veSp?=
 =?us-ascii?Q?NquuTy86DdCpBEfc9UgPEvb9wLTkKUvylaLLBnvmfbypRZjvh4kNrnMqvTvi?=
 =?us-ascii?Q?J0xGxkfPneeZeMrhxdNpfSZrLCb4Eg2ulxVV0iWRh67c0zkYU1IqMMqDqxIA?=
 =?us-ascii?Q?XCr5NJd8GMzkIpcBLsXQ279xWb1+dco=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zRUe+JUiDru2vMA2kHCdQpyij4BYBuFtCtfiq/ZVzSWIvx0UVlKM76g/crp+DN6DO8g1aV7qev8SnOJ1+P4I6WNUhO+cIyk+6AnS4uFDWcXRcOKu5qtT5WNVkYkBOF/FqeMSF4He0UQP9YvWgbFOyGuh9+yLUtLYc3gYx3wgFKYeDx2UkyivluA9N1O/eBhR414TqxWX5sR5WSm29nGeOpBmCPJ+zEsjd2P+WFt2mpJjrgZbxLy3Wf7RCYDqh6MceKYyb3Jnc4PH1y9tcIGjRqrflIJIeBGiwv8OWg4wucX86s4f4Cu95nqp61ESuOw79KnMbuRO1VDuOJJmp+rrGg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7442.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76efd860-adea-4b09-c289-08df3b25458f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 10:12:17.6559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZWB6tPYHRWdTGeMBkci2zL8zcA3cou41CtiwL+qDnaK1sFn5Fg1rdn82JrHxAQAPVuiEevTdDtF5VMgPQksRw/GlAISTLllYZyear5BW7Io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6499
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



> -----Original Message-----
> From: Richardson, Bruce <bruce.richardson@intel.com>
> Sent: Thursday, November 5, 2026 9:33 AM
> To: Wei Chen <allen.chen@jaguarmicro.com>
> Cc: dev@dpdk.org; Dumitrescu, Cristian <cristian.dumitrescu@intel.com>;
> stable@dpdk.org
> Subject: Re: [PATCH] cfgfile: fix isspace() undefined behavior
>=20
> On Thu, Oct 22, 2026 at 08:23:48PM +0800, Wei Chen wrote:
> > The _strip() function passes a char directly to isspace(), which is
> > undefined behavior. The ctype functions require an int argument that is
> > either an unsigned char value or EOF, but char is signed by default on
> > x86 and ARM, so any byte >=3D 0x80 in the input is promoted to a negati=
ve
> > int and indexes the ctype table out of bounds.
> >
> > Such bytes are reachable from a user-provided config file containing
> > UTF-8 or other non-ASCII content.
> >
> > Cast the argument to unsigned char, as is already done in
> > app/test-bbdev/test_bbdev_vector.c and elsewhere.
> >
> > Fixes: eaafbad419bf ("cfgfile: library to interpret config files")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Wei Chen <allen.chen@jaguarmicro.com>
> > ---
> >  lib/cfgfile/rte_cfgfile.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Cristian Dumitrescu <cristian.dumitrescu@intel.com>

