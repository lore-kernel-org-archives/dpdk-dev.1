Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD33CA0EC0
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 10:58:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 519FA4014F;
	Mon, 18 Aug 2025 12:58:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id F182F4013F
 for <dev@dpdk.org>; Mon, 18 Aug 2025 12:58:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755514708; x=1787050708;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zU6PepP+Bw8aHf4FBWvH8hj54Pj93eTGJa7NYsXJtSY=;
 b=Tfp07aolzJM04UoIaQiFTq/wqMYFLuPlGszGRI5gwsgxPQzuepfPzOFu
 j93DLL3hFAcDnULXKq4hp+67bCVoZF7yHqKvqZRY/7wTUdDS7LW7tjOt4
 JmvKyfYphCnsl3pyyCw57BWhAWviAn/1a3Ag97IQZ1avyDlw5MDuoDl/Z
 y77yOgOiBvvz3bfxF8ZNJrg9+urTOTI7wfNrhXTpFkQIW72ZMeSdDdGyk
 TSFlIpV7O2NewJLEVjP2yCgwJ4aFJosVixB0NdoQRG1xUIGaVXz4Rjk6Y
 0yhrvloXc3S8vbBSZdubHFZplYUQyUVzIfhLcDBQeYO47k0+s8uXeBtg2 w==;
X-CSE-ConnectionGUID: 6H6nTKPdQbukZd60RpcPsA==
X-CSE-MsgGUID: TZmw7EoNSvCoHvzMJNK1WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="68337600"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="68337600"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 03:58:27 -0700
X-CSE-ConnectionGUID: SFM75ynOSFGTqnhkT86+gw==
X-CSE-MsgGUID: 0NjF8zBiRwSPjSjPXsh1ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="198560626"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 03:58:26 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 03:58:25 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 03:58:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.47) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 03:58:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRvFnjsNeArXFX8Dhi7RT36O4dLI9lb6R9tgPcs/p3oyzXMXeXI+DOAaw3Umf57GJg7maWTdB6WetRb7ZkeRCqh6GoTBNK/dgkBkQCA2MOdJzOyXMnnd4HaM9ZrT4bwqFB4ogZHh3QWSen+tq3QbDnVtB0eq4vFLIQNWfMN6uqmks5R8foyWrcIAdwZ387TUTVdnOY/X0RC/VpymUB4kB+U2dCOfdja4o1IbQ86cLWGGU9y3Vm4OP8x4D+ajrdfyaZhn+GQnMZ3AxPjlQFfCjIPCQRK+U6ffWoqVYomF50XLei+SFLrAN3DQs79DnrEEegOiijo61PgMu2U8NUwuOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBeWcz0rggmsRJwQbWJRrTdE63EYjD2Tlpd7tPVVLm4=;
 b=BhPWAPOn7/TLnnb7mKbvEmH84xZ2uu7mHbw1Pn9TNHsbrBip65xztShTN9fh7IUytRqR1NvsLNOjrONnlFeOIaq+Wa2HaA2ybsxA1v9tjWmlrCT/Q0b7XOaLCokgUf84apsv9RajZrq9V7bglADhibmN60LjUUZCk81MOY7mqoNxLuh2WQdBSvl5BiOIa9tcvopO6xaiKKqtc1fqW0UWUzg6bC1lA0TWMdh8SeG1ocrCpKlKPrw1gCFdh1KOLA9lcJVufMbWdx+vXjAqh9czZddaIGWDeU/gKLiWMZKuCblKJT/MWs0xOOWH6tWR7H+izI4I4jhxbKelzkuKy6ShrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ5PPF6E320AF71.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::833) by PH7PR11MB7430.namprd11.prod.outlook.com
 (2603:10b6:510:274::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 18 Aug
 2025 10:58:23 +0000
Received: from SJ5PPF6E320AF71.namprd11.prod.outlook.com
 ([fe80::2f6f:fb0b:90e1:76bd]) by SJ5PPF6E320AF71.namprd11.prod.outlook.com
 ([fe80::2f6f:fb0b:90e1:76bd%6]) with mapi id 15.20.9031.019; Mon, 18 Aug 2025
 10:58:23 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2 12/15] net/intel: introduce infrastructure for Rx path
 selection
Thread-Topic: [PATCH v2 12/15] net/intel: introduce infrastructure for Rx path
 selection
Thread-Index: AQHcB5hvPBoHzzwUFk6K0Ht+0EJHb7RdWSsAgATTAICABfXjAIAAKpJg
Date: Mon, 18 Aug 2025 10:58:22 +0000
Message-ID: <SJ5PPF6E320AF71904ABC4769CFD6CE4CF18E31A@SJ5PPF6E320AF71.namprd11.prod.outlook.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250807123949.4063416-1-ciara.loftus@intel.com>
 <20250807123949.4063416-13-ciara.loftus@intel.com>
 <aJnVvjcg_nhgnesS@bricha3-mobl1.ger.corp.intel.com>
 <DM3PPF7D18F34A14E9758E3D0F2CCE373428E35A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
 <aKLhvoclHxDkyVpy@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aKLhvoclHxDkyVpy@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ5PPF6E320AF71:EE_|PH7PR11MB7430:EE_
x-ms-office365-filtering-correlation-id: b75f2f36-0493-45b9-c99a-08ddde462669
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?GaVUUViuNOiVnMyz9q6nlj4i2KRTD5RBixVrMpmopBRrDojUMZUi/0zDSYDs?=
 =?us-ascii?Q?mQAg8EzOgTDAiS0ieZvGdrj2g1TFEtr3j80hEds6eyPInTUFv6u+AsYQ8vrV?=
 =?us-ascii?Q?2avneMUyRDmP2ix2axkbV6830iiImUoThJ6Uud4nGbybS7pmv7OBcdiXTCWZ?=
 =?us-ascii?Q?VDC7BBWRpbSZLVTHBuC/zl7C+6eYlUGlyBB9jbqFlGPHp3YQvBWRe5Zam+NX?=
 =?us-ascii?Q?rW3ChVefbmSvChkuc11ZYKJDKowpnj1IEuJTmXZedR3koVEr7BgnI4pBHc5F?=
 =?us-ascii?Q?G3Es5mYEknXDtixILjJq5501pRoRLZN42ZllmTLnBFaUUB1OD8Tj7zKEOqVO?=
 =?us-ascii?Q?BIPp+Oc6eXQOZ0W5Rzb5e5Nj3kp6RS3McbU7qwcrs7h8BTDizAOtDG+I5Hlr?=
 =?us-ascii?Q?GK4s6t3caZ9qaWSN5LhZ4QGHW25KGpSTXZuJatv+1dPfhmsUfdM6UzlCq2NZ?=
 =?us-ascii?Q?wLOxw5+KneOWWrZ4rXBo+20YvmDHeKHUaJMLjQDQWQNDqEpQqlrHOE05X9jD?=
 =?us-ascii?Q?3mo3rTa54Wwn3ibq7iV8xzI0yOZEVOkHOyq60UWJQm4FzUhf/1hIY430pCFX?=
 =?us-ascii?Q?AAp/CUONnanSYci1q+wGaDlB5GpYHlQo+qkNOlQv9Ocx9Yp2o6MHQdebu5Sd?=
 =?us-ascii?Q?L4BDvFT7ELCV0aA1aAEkPakrs3aATBAXmXawDa45TLaBmGC2M4WoOLZzVITo?=
 =?us-ascii?Q?7pi4YCaTEybc2J4z7qko+sgIj37otDwX6Aqgd7fG7gchy8JHb2SaPOfnx2aF?=
 =?us-ascii?Q?Itdg2eWUrsjI/YN7E6vphQ2L4h9APPOVaQJQBCw7kFGmA2HU0oIKDkw31pn8?=
 =?us-ascii?Q?4Rgp8sBIc106YZzwQlGwkrRIWGXOfTOdjOvybrV+KyS4MWvmVv/Waeg9vQRL?=
 =?us-ascii?Q?SnGQlyQX6BCYnmy23gWGMJNyyOZqYcEAPh4Rt2Qo4eTD9o14Ou8Rt4NCzRNR?=
 =?us-ascii?Q?yWz+U3DF5oruRRghp2ns+b9XcOm5r5rBFuenBhbr+daHod17MC9aSgPXCDhx?=
 =?us-ascii?Q?3ESbrFi9nW4hesTx2COCtIbbmN2Hth57rR8D34xymDSUNPpJ4fcNaA2EbtEP?=
 =?us-ascii?Q?r71Ljr1oHZNhPfHpXpiIbIxHK3ldeChoTdpL3jTSGSefBBHCUoo32wzDrzho?=
 =?us-ascii?Q?KtL94udn7Cd1Up6dHH1IFfodrFJSvye42M02y02WXUCFCjae97ZMGcw1SPmT?=
 =?us-ascii?Q?Ot2QIcoJmJtMMCw+CWtQuLUx27Jp7Kcn3SbCoQNZNulHGHp6i+kZuiNcrSU7?=
 =?us-ascii?Q?DQ7dAHjbAKmwK7USEWIsLhrkVr/H+qC035rQK1frCtM88s+1NHJluqKOFs/x?=
 =?us-ascii?Q?qauL/S3C5Wq0FVwIrVaqWFlpIrVgNz4XjN6eE+nbGoG3BH312C/wD8KOlzj6?=
 =?us-ascii?Q?SAr4oKZ/4oMWzpZTdgJIe76N5hQQnd5HPUgznBJTYXhW8rn2jcPGaSX65Iwa?=
 =?us-ascii?Q?YZpkAAV7egWHavGNlo3qLINje/4fthqSdEy3HD8M4twqyTNu9qsnLYDBSFYp?=
 =?us-ascii?Q?nYbw98S7+hOwtsQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPF6E320AF71.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/hDPeYcCO5Io+7VGsq3Lk5wpHMK3lkSIeJKoIHP2reybVY/k1Cbe5Mk4nOBn?=
 =?us-ascii?Q?geJLW75bgzzHnB73zJLNEuMQEqxmvfW/Q+8ChRVFNC8N32gPg5OS9f3sBrZv?=
 =?us-ascii?Q?fudrTCg6xgOf5Rp5QWqXljEmorq6z+XsnPH+ICYeeQr9gl5MG5BekG4bBkgL?=
 =?us-ascii?Q?rwCiUdImPctGeRbwgBSUl1TSinnTXmu2WPfnHMlWLScxSd0mlnq3NDUhmumE?=
 =?us-ascii?Q?86QlXYQurVKjugFHScd0X6OCw3yudQMzMxmF1x2mIK4xYT3Ndk3d1piyNdjb?=
 =?us-ascii?Q?j3oP3y73lBrxh4pQNpK35bAaoTsAbBgbQABHlo/40z3Yk1WqDHEcv6KX3n+A?=
 =?us-ascii?Q?LTBYb/0DZGOAjW94kwsqBATzoFQoli7BLCW/fumBBv0PFgklhpTzLBrV30Qb?=
 =?us-ascii?Q?dEZqVF0JltFI/Okmg/Sd/SgSv2dNmgpC3fkhsy6dlp2pVUwj6ch20FQmQbh+?=
 =?us-ascii?Q?/Y9fUOIGN4K9AH7NEaLDLdzOkbdLDbK2o3QPMt49WUhFNCbICKR/U/ynRkpG?=
 =?us-ascii?Q?Tm9gTZQxwTWshFa/9/Rln/q7QjUXikV7UG7Nf8G8Rw0XAlKCGQhRL1m/rSbU?=
 =?us-ascii?Q?7yAmVSu4Vk2gswGwbXdBsUen8E6nWCgrfkPjx7qFFrybdCFqkgPw5rHgf8Gp?=
 =?us-ascii?Q?BZSwh6gpUq3cwDSiWgAf25pl3G65mRxJcVbpLi2hWR8Llp7jNB8n4pR2093D?=
 =?us-ascii?Q?xYWgc3pHf3GAzAMjZ6ivg+8jDuaJUIPQ7rVXLtXLWvWud8PXYQ6e+BHUOaFv?=
 =?us-ascii?Q?648KnLwmLh38EK0vxHxi4AF5X1591DBY6Ms824V+mCwB/fgNLkPhluRc+U+C?=
 =?us-ascii?Q?jSvWwgJogrZxsodeWO37XUqhtCjx/pArmgEubkrFh8b2W6HykdyhEncJd66m?=
 =?us-ascii?Q?iH0HMBvluGkHaDMpiXcNKMQZvx63j+lIcd3iSd3sM1PYG9ccRDKMupLWtCBx?=
 =?us-ascii?Q?uYjxfDYlysomqQF9F1KkGu5NFU0m3QSXNsHcEDD9zY1R8Xt9CZbgCCEs3/KD?=
 =?us-ascii?Q?D8q0fvj1djtGmia69PIFenR5eBI0tZVDXqRw6E6UecGtC46lTH2QCHfnLtVU?=
 =?us-ascii?Q?1TfyyO4ljXikSTgVOXc9TQZVckWW+4g73fXv4BMQuyrKakT8xhSUPF1HNtl0?=
 =?us-ascii?Q?SSU2j3m2BnryTsBk5jk9RgXpG+l56aFuv+Hz4BEH2JUEZNDDl4V0lAd1AREf?=
 =?us-ascii?Q?ZL+Vu5bfElalc/12DNaW3ZnBMG3g2VT0pb+Mg3gOKmKKmDg5UPec9C4KiYTF?=
 =?us-ascii?Q?FY15IecciwdTHwUVnF72TeNuW6KEplB58d5nQ2jcm88fZ7R/dL2M8bJwpwAq?=
 =?us-ascii?Q?PtzZy/fUNuB3yB3QSyO/bfU0hxfHetKxv9brXDTWWQmRXcmKHHZQRqZM9bPf?=
 =?us-ascii?Q?OMO6dxmGPu0LVqxgt6gwBY/+y1G1NbHGv6ezFOxPJH+/D+gh+3VX9iFU45/N?=
 =?us-ascii?Q?XHpnh2DkwD3Rk8UBtcqdBXwHNlIQbk9Q14R0ZVLY8tm/9YprmW0gnGmuK+Rv?=
 =?us-ascii?Q?9ou9OO/GBwImLIo9JMKk3FPVJmmPQbPOzC0AFHbGo1ZeLhN5mVsECoNIWXCh?=
 =?us-ascii?Q?FRyoyEoiovSVFxKRcBBfqhpCpOU8GMeQdv2kWLOrBlbx2g02o+vAeef5uXHE?=
 =?us-ascii?Q?I1Yp2Bq9DZ/KyL4PE8kXp18WqEgcrui6aHDCw7QX1+pX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF6E320AF71.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75f2f36-0493-45b9-c99a-08ddde462669
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 10:58:22.9898 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4oiWYuWKr05l22PVG7YiSk80DgkuPNtaUBrF9xr+sL9xuDOc4JzSzaH1J/DL51EoiZ6i8GjrbEAj1LkR1btzIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7430
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

> >
> > They're not necessarily needed but I think they improve the readability=
 when
> they are used in the next three patches when defining the features of eac=
h Rx
> burst function. If you don't agree I can remove them.
> >
>=20
> I'd tend to prefer assigning bools to just true/false for type-safety and
> type-clarity. In terms of readability with defines like above: if we do
> want separate defines for scattered, flex-desc etc. I'd tend toward havin=
g
> them as enums and the variables below typed using those enums.
> Unfortunately, that's not really feasible with the struct below, because
> while bools only occupy 1 byte, even a two-element enum would use up 4
> bytes per value, which is padding we cannot afford. :-(
>=20
>=20

I went with splitting out the boolean features into their own sub-structure=
, which you suggested in a previous thread.

The definition can look like this now:

[I40E_RX_AVX512_SCATTERED] =3D { i40e_recv_scattered_pkts_vec_avx512,
	"Vector AVX512 Scattered", {I40E_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_512,
		{.scattered =3D true, .bulk_alloc =3D true}}},

Let me know what you think. It's perhaps a bit unusual with the nested stru=
ctures but I'm ok with that since it's more readable than a series of true/=
false. However, if you would like to just go with the simple true/false app=
roach I'm happy to spin up a new patch.

Ciara

> > >
> > > > +struct ci_rx_path_features {
> > > > +	uint32_t rx_offloads;
> > > > +	enum rte_vect_max_simd simd_width;
> > > > +	bool scattered;
> > > > +	bool flex_desc;
> > > > +	bool bulk_alloc;
> > > > +	bool disabled;
> > > > +};
> > > > +
> > > > +struct ci_rx_path_info {
> > > > +	eth_rx_burst_t pkt_burst;
> > > > +	const char *info;
> > > > +	struct ci_rx_path_features features;
> > > > +};
> > > > +
> > > >  static inline uint16_t
> > > >  ci_rx_reassemble_packets(struct rte_mbuf **rx_bufs, uint16_t nb_bu=
fs,
> > > uint8_t *split_flags,
> > > >  		struct rte_mbuf **pkt_first_seg, struct rte_mbuf
> > > **pkt_last_seg,
> > > > @@ -222,4 +243,86 @@ ci_rxq_vec_capable(uint16_t nb_desc, uint16_t
> > > rx_free_thresh, uint64_t offloads)
> > > >  	return true;
> > > >  }
> > > >
> > > > +/**
> > > > + * Select the best matching Rx path based on features
> > > > + *
> > > > + * @param req_features
> > > > + *   The requested features for the Rx path
> > > > + * @param infos
> > > > + *   Array of information about the available Rx paths
> > > > + * @param num_paths
> > > > + *   Number of available paths in the infos array
> > > > + * @param default_path
> > > > + *   Index of the default path to use if no suitable path is found
> > > > + *
> > > > + * @return
> > > > + *   The packet burst function index that best matches the request=
ed
> > > features,
> > > > + *   or default_path if no suitable path is found
> > > > + */
> > > > +static inline int
> > > > +ci_rx_path_select(struct ci_rx_path_features req_features,
> > > > +			const struct ci_rx_path_info *infos,
> > > > +			int num_paths,
> > > > +			int default_path)
> > > > +{
> > > > +	int i, idx =3D -1;
> > > > +	const struct ci_rx_path_features *current_features =3D NULL;
> > > > +
> > > > +	for (i =3D 0; i < num_paths; i++) {
> > > > +		const struct ci_rx_path_features *path_features =3D
> > > &infos[i].features;
> > > > +
> > > > +		/* Do not select a disabled rx path. */
> > > > +		if (path_features->disabled)
> > > > +			continue;
> > > > +
> > > > +		/* If requested, ensure the path uses the flexible descriptor. *=
/
> > > > +		if (path_features->flex_desc !=3D req_features.flex_desc)
> > > > +			continue;
> > > > +
> > > > +		/* If requested, ensure the path supports scattered RX. */
> > > > +		if (path_features->scattered !=3D req_features.scattered)
> > > > +			continue;
> > > > +
> > >
> > > I think this test should be in a similar format for the next bulk-all=
oc
> > > one. After all, if scattered Rx is requested, we must provide a scatt=
ered
> > > path. However, if scattered is not requested, a scattered Rx path sho=
uld
> > > still work fine. So:
> > >
> > > 	if (req_features.scattered && !path_features.scattered)
> > > 		continue;
> >
> > This would be a diversion from existing behaviour. Currently we never s=
elect
> a scattered function when it is not requested.
> > Like you said it would still work, but the path selected may not be wha=
t users
> have come to expect.
> >
>=20
> True. I suppose if we put this in place, we would also have to put in a
> later check for whether the currently selected path is scattered and, if
> scattered Rx is not requested, choose an otherwise equivalent
> non-scattered path over it.
>=20
> Given that we are looking for compatibility with what we have now, I'm ok
> to keep things as they are.
>=20
> /Bruce
