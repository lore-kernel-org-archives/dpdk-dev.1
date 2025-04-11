Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0DAC369A8
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 13:13:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CFBB406B6;
	Fri, 11 Apr 2025 15:13:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id DFCC54025F
 for <dev@dpdk.org>; Fri, 11 Apr 2025 15:13:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744377194; x=1775913194;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yBJRcbMbNsU5qKjAUNldhdfn9Re1bpkPflPT+PeAOv0=;
 b=KezqsMTzTW99OHvqMmTGV+gs1nZk4M8dYpDt2Vz2DY6QbEiLHzQsfXAk
 Tw7hRIwp4frwxQprmGrzrax2QI8pzhNyer3JPAyULseGDI3JfPLyjGtV2
 GJbyJec4DixG3jYhhZcGW05cpb9qZrx9tHBlIK65D2I1SG7LUReUYzsGa
 ehylwJpuYPowl9jboAm5OwyI71qNwjz82dckgMnoWEeIvpMLyho6hcAOV
 j7LJsjWyIkKm2YMullQR1c1N42hJyakfjMchRqmWDoZ0l0tg1P8Sx6FuJ
 xKTID48O2ce9W6xgud0/FKJmtyFeixaU9L6ogVTUNCr1jHmKzYCfHBHXR w==;
X-CSE-ConnectionGUID: MetdwewhRG2ruPRJLwWf7g==
X-CSE-MsgGUID: uK/yOysdRa2QtnQX77MUlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="49580005"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; d="scan'208";a="49580005"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 06:13:12 -0700
X-CSE-ConnectionGUID: qaJmNgjsSH2KJlGQUTY8Rg==
X-CSE-MsgGUID: Wr9/4603SBa/1EdN/H1KWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; d="scan'208";a="128968257"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 06:13:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Apr 2025 06:13:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 11 Apr 2025 06:13:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 11 Apr 2025 06:13:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiBx3OxNXa187IgSqWfmJbxmOPNgD8KkcHc+dY2P7s4NPL9m7FkIZnK8AjbH24ZJ4mt8bICyPcE/zay1Ny7Wu3lKqQXx9g0kxdqpEpXwbnFWMeq7CKQaTqsqz0Kcvj/u/TwdJw+omGnBP3hLxuiJ8lziixx5FPFjUvkLld0Zlde8uVN1TO9s7UsWdvUTCJysArgYLJz/YUdDiD2Qfqah+EHMYfe8lTnqjZ1KAoCuORTVTOYkRTukCLFuqyOVebBOnPpAojcuB/Y+2+F0JF3Yro8cufG1nSFOjGf38XYd3TTY0ReCGxtWy6tAOV8efefWlEvUjhMfR+Wo4MVRxqM9Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORKu5aIkXCD0FuQ7duuqASthWbufg12SjlO/TnSe+tI=;
 b=RZ2qXW85S6F4y8H9foVA0zcFuxqOelzCF8JjVUH6pgcVcjK5fWGmY7eV6fWR5t1/Vl8wnk4NLH3aF/RsywZkO1151278UGCE5d3yZYH2iy9krGn+3W2JoXSCrlMPk8tjB0oFaHL3MkFmcAF0nLflJLE7n88+DRKl4E61IIKfYzAwTigeFmmYIuGcCnPUTKsykEd4JJfS20Geh1cKWAkg7f9V3IcKCO8bAj5bD1boVYz2kkI3ZwHuK1bo7Fw610dF4O55JAZGFhd4D5Cp1YPDZP2tBSoyweBTQHS1g6/bHK1+YPuNLBrIOeoqehhINiHwyVtd8MFCkJoebTq1Smyo6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6803.namprd11.prod.outlook.com (2603:10b6:510:1cb::12)
 by SA2PR11MB4825.namprd11.prod.outlook.com (2603:10b6:806:111::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 13:13:08 +0000
Received: from PH8PR11MB6803.namprd11.prod.outlook.com
 ([fe80::8680:ff9f:997:18b4]) by PH8PR11MB6803.namprd11.prod.outlook.com
 ([fe80::8680:ff9f:997:18b4%5]) with mapi id 15.20.8632.017; Fri, 11 Apr 2025
 13:13:08 +0000
From: "Van Haaren, Harry" <harry.van.haaren@intel.com>
To: "Etelson, Gregory" <getelson@nvidia.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [RFC PATCH] add rust binding support to DPDK
Thread-Topic: [RFC PATCH] add rust binding support to DPDK
Thread-Index: AQHbqJbQrTpmpKHoHE2sfKugVvsbB7OcYZ4AgAIImgc=
Date: Fri, 11 Apr 2025 13:13:08 +0000
Message-ID: <PH8PR11MB6803EEFBDE79D34996494ADAD7B62@PH8PR11MB6803.namprd11.prod.outlook.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <20250408145838.2501034-1-bruce.richardson@intel.com>
 <187447a-fb49-2833-7e44-ad5bb0d67a99@nvidia.com>
In-Reply-To: <187447a-fb49-2833-7e44-ad5bb0d67a99@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6803:EE_|SA2PR11MB4825:EE_
x-ms-office365-filtering-correlation-id: 4b94bbaf-ad6a-4be2-9dbe-08dd78fa9a65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?EB2lxjti+JvxEsm5MftpUyFXtquM45mt9oWG3giJ554FsIw2i9mcheWlKB?=
 =?iso-8859-1?Q?GtSux2PEa5AeBVoJvsH41R/0nXJgJwKyaNsYz7HDwfGaA11kQsZrL6Pj3i?=
 =?iso-8859-1?Q?B2KCZKFOVJKs8JbcI+E5fBs5mnGSDH6ennPyUrypfbnRaqhcF/Hr82ZgVT?=
 =?iso-8859-1?Q?N26LQ43V6YqaOUH8z5LBjuQ83/2ejY5T5hycd9eIdn+fRIh/ZsdE42K/vf?=
 =?iso-8859-1?Q?ZDXD9SuOPY6nMeYDyDyi/BmH0XpGCWAEXpcYHmAK4jtJKrgIjQgNbTpKlv?=
 =?iso-8859-1?Q?gor9RbCAhkjfOucEuQFqJaSlDSG8NIpdSOPbMFqmjxvAbIo+QTJkkVq37K?=
 =?iso-8859-1?Q?FS6h+mPfaV745OAl+4r/YQ9PAg96h+bAdY5FgQAgaFEf10piS16U3YU/rL?=
 =?iso-8859-1?Q?JZJdpL3isbV50fu3IWOeOSvZWA2I8dqtX65N0Ik4VQ06D/WSC0ZamxCNdx?=
 =?iso-8859-1?Q?ebZCQ2jiUDGZP6LeMPO5epm8cK1Qyf67aW+dhIebbhnyNdnGcqxX7FiKdG?=
 =?iso-8859-1?Q?84iPQ9kuKwqv1RxY8Vzrz/s6auwNS/rf6NCwp0Hm4ZAG9tllB9h1QCheSp?=
 =?iso-8859-1?Q?crKoEo5dCmHtjMLhzDPqDizMGsE5el245Ab03q/996EyjHhZjY+yU+fA+f?=
 =?iso-8859-1?Q?Dm+RV2jWCCqqKe0DtZOrD4s4r4nQXeoHqcxEp0mICPZ3kY+hDZeWYewOFK?=
 =?iso-8859-1?Q?CaftrYUCfxtfvFYdzF3mgpTDG4kWtZLNnfu+6o1rhPZp8aX4ebviq5Cdz9?=
 =?iso-8859-1?Q?DT4zrIWS65o70Ni0zTEepeS8ix2utH2qc4UzM94etkAt1b3dFEhSeRCD4b?=
 =?iso-8859-1?Q?1YD8TFmpP0FLL7Xczxr2yJcIeU3cVK/q2h+N5/5ptPWe7J8bemK9YlabV8?=
 =?iso-8859-1?Q?Zswym3pfmdX1l+SHkwh1ad14pV4JTHybIn1u0l6/1P0c9n1URI4EKICrCZ?=
 =?iso-8859-1?Q?oe/xDR7/td6TwMR1NufnL8Vv79St/wgpwiA9kp7K2GFLde2nK1hj4vnWY9?=
 =?iso-8859-1?Q?VjQVBJ/fOM5Gi3ERxRVGp71q1kkFH038t1hlV4eEnX1AVe4I++xMv24Gy8?=
 =?iso-8859-1?Q?Y+ntnTDa4gAxyGCyJKMPD79vpEGjKHw4n36xRDQkmwmsEy6BbomlbyZTr6?=
 =?iso-8859-1?Q?ArxghQiXreMUATII0ulENPIAaYx7I2vdP8j/8yoks7ThziVrulY7Zrc7+6?=
 =?iso-8859-1?Q?NeOo/98ZrllIecWF9Z4PiVGnAhj77opV5ozc24NHH1ywCbpU0NJbB3CWCC?=
 =?iso-8859-1?Q?DA6da7FAF0WLxQTMYPWD1Zrb3cGdPTmWrd4bpkWfnnaR2WvWYrdZCBPVq+?=
 =?iso-8859-1?Q?R0huULXPSUmB8oBizFFwzEG0G/fVuAjAwoql7Q96xMbK9RFPj9FRhC9sRg?=
 =?iso-8859-1?Q?TtvE2XK+QSCCHHNJnVaP+IoNsZc5m9I7fnJzNLtCUMdKDMZgNsbYwztijx?=
 =?iso-8859-1?Q?jZ+fZweomufQDEne4hhh13VTUupdp7tYCKi8NUBIatIBxXjJnH7M4qKyEV?=
 =?iso-8859-1?Q?k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6803.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PZX088rZTa2E7NIk0TlmCuLALrakOWnA0Sf28sGjznvZyUyQS4FN7Vjo4T?=
 =?iso-8859-1?Q?sAqKmsIg2nCHkCPff2+NiVQLUQRYR8IVjM+axCpsLZQ3UGHCpph5m+H3O3?=
 =?iso-8859-1?Q?W07r3e4dezGAU+ZYRij8tjGyTHPU93DOp6ugyd6K68DmWKlhwL1j53WOiI?=
 =?iso-8859-1?Q?e+ySGzPAaaDjHYaCvoZ6ArxfNl7ng8psBN9n1eZQF7GgtkTkxE/sdAJVmz?=
 =?iso-8859-1?Q?+EbEeWf7J+G6WT3uxAxzdfqBE+Y7Do4i8Ym4g+iGC3R+rTlO6+KM3DQBWY?=
 =?iso-8859-1?Q?rLLMvnQZn4FUGBeKh7hlMOm5XLiXXgCHtsN4cWFCLubnRbKjKvnDi388l9?=
 =?iso-8859-1?Q?L11s9GYaWG5EGAOnNkXKupeKTbCsQRivq2yQ4n6bFr4iXocUOm0Bj3Rz37?=
 =?iso-8859-1?Q?CYEENUPuxcElKx5di4iXO1fp08qiYJci8TETrbuS55h61EFdeMv1vEE4BG?=
 =?iso-8859-1?Q?Qc4VMoxqR4+KRvCX9dlHQgcyC4p2r+mtPsCASC1pA+njz6uWy3v9mNkiZG?=
 =?iso-8859-1?Q?F6DaN2plMmW/HvjO9ExP0hfJgPl07Expq0oz3jTnB18BgmV5pmcAZf+SPB?=
 =?iso-8859-1?Q?MkWPhTsxq+jaEezNLf1fdnBLFXpjgHemKSMLdOZe4sHCTtiqGY6MfZ8xcB?=
 =?iso-8859-1?Q?usZjo/mrHRENrfJ3dQGRui8JuxTARWCVrMrDhYec5ucUzkSw+hysNgnf7V?=
 =?iso-8859-1?Q?8F7aTI8MFu5kwtVr9kogGuY8nxpuQQ80ayG1Yr2uTPMtHvxqR66xMuCctr?=
 =?iso-8859-1?Q?n9mvUDHM17CYDZEQCZLgnAVrl3T0qkbL0Mpmi0n4EwUQELiNjWRvJxud/6?=
 =?iso-8859-1?Q?GkYYVdEA54ys7VW+dIudbMjI4EDB7rCKxPD8IzxEc629Vaf0rjTU06xf9l?=
 =?iso-8859-1?Q?ldtWeoFjrSUrkQkTZcA4WRtbPsooZvTs0Okm/sz+OGRSngQzNpNw2x2kF6?=
 =?iso-8859-1?Q?GqeAjJhjYqiGRT3fc/ikldqWiEAnAwJKVEMjyACp1bTFuctxgxdloqWBcq?=
 =?iso-8859-1?Q?UZZYdQ/tJ+VtPnWOkB0W6PHB7170l2x4Bzg2mYs1Bd4DSSuzJ0OYiSUV0j?=
 =?iso-8859-1?Q?yLe1MMaJpmglKRfNlC58+uwgmJhfNQ0QLc9NyiflzYOAcE+jTHEkSW5+HO?=
 =?iso-8859-1?Q?Nnd34imWlUIz184m+IKyQIk0xn2pyUrKF3LqAJTvmtcV0UDj97mhfBo70p?=
 =?iso-8859-1?Q?77DJcR6ou8bHo02+H/CC4Mlu22Nd6owUgNneuJHpMtmYQ3+QI4/Awgi7kb?=
 =?iso-8859-1?Q?gC4lTrwDh2d2d74l5Hy4YzQ34993nuXWruW7L+VZviTF7+WhhyBqjop5Sx?=
 =?iso-8859-1?Q?dG5l7pG+30w0OvIz0AmuolNjlcMVjIZx4BR+l77RB6Jcwo7QVokNGaB8SY?=
 =?iso-8859-1?Q?OauOWmQfK3Nx0/AEfNJ9rWOCOzYTl62/htcB5DTL4pzEWV3B7lEOcXhQhz?=
 =?iso-8859-1?Q?GalYzWl3HHhsifRFqm9T9DLOUggHSaZnS12fuaLSEj5wsGAIT5iOmK8et0?=
 =?iso-8859-1?Q?TMmzZSoqi8pSkhH8MR29MYxneHzG+WzxNDwa5RfOLkEbbu1iGt274Or+am?=
 =?iso-8859-1?Q?HJUkDygnLp9Wb2sWne2xw2QhJ9gAvjUBaWEgsGLMEfOOnCtA+WzeViAwPS?=
 =?iso-8859-1?Q?vOaKmU/ySJWap7JU2w195tC7PEf2wF/9za?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6803.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b94bbaf-ad6a-4be2-9dbe-08dd78fa9a65
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 13:13:08.3701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BZkngZoOzABxfzQR5dpckeSwNx/KpIgGg1/tnbKwla4RKhujZWoY5pkw7yYFCsqKTB+VaSOB1cHOuV5LaDFxJzb22KcLr6DwhwNCuwLhYLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4825
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

> From: Etelson, Gregory=0A=
> Sent: Thursday, April 10, 2025 6:28 AM=0A=
> To: Richardson, Bruce=0A=
> Cc: dev@dpdk.org=0A=
> Subject: Re: [RFC PATCH] add rust binding support to DPDK=0A=
> =0A=
> Hello Bruce,=0A=
=0A=
Hi Bruce & Gregory,=0A=
=0A=
> > Add a Cargo.toml file in the root folder and a number of other scripts=
=0A=
> > and rust-related files into buildtools/rust, which then enables DPDK to=
=0A=
> > be cloned and built as a rust crate - all-be-it one with only two=0A=
> > functions: rte_eal_init and rte_eal_cleanup.=0A=
> >=0A=
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>=0A=
> > ---=0A=
> >=0A=
> > This RFC is proposed as an alternative approach to enabling rust suppor=
t=0A=
> > in DPDK. The key difference vs previous is that we are taking the whole=
=0A=
> > DPDK project here as a rust "crate", which can then be used by other=0A=
> > higher-level crates as a dependency. Building the crate does a=0A=
> > (minimal) build of DPDK and statically links it in, so there is no=0A=
> > "install" step or anything needed - the Rust app just adds DPDK to thei=
r=0A=
> > Cargo.toml file and then should have everything they need.=0A=
> >=0A=
> =0A=
> Having a shared source directory for both for C and Rust DPDK infrastruct=
ure is=0A=
> the correct approach.=0A=
=0A=
It seems so, with the various approaches so far, agreed.=0A=
=0A=
I've tested Bruce's repo, and Cargo.toml. The initial build takes some time=
.. but it works!=0A=
The experience of "Adding DPDK to a Rust project" is very similar to adding=
 any other Rust crate.=0A=
I like this - it makes the "strangeness" of depending on DPDK near-zero :)=
=0A=
=0A=
=0A=
> My concern is how to properly maintain Rust crate once DPDK starts to imp=
lement=0A=
> it's own API.=0A=
=0A=
I'm not really sure what is meant here. I don't understand what "own" word =
refers to?=0A=
=0A=
I see it like this:=0A=
- DPDK has the public C API exported (and that stays the same as today, wit=
h ABI rules, version.map files, etc)=0A=
- The Rust crate consumes the public C API (via bindgen, as done in this pa=
tch. More detail about bindgen below.)=0A=
=0A=
So DPDK changing APIs is API/ABI breaking for *all* consumers of DPDK, not =
just the Rust bindings.=0A=
No special treatment required, just identify API/ABI changes when they occu=
r (as per ABI policy) and fix.=0A=
=0A=
Some approaches to how CI could help, and when to identify/fix Rust binding=
s took place on the last=0A=
TechBoard call (minutes not yet available on https://core.dpdk.org/techboar=
d/minutes/).=0A=
No decision made on how - we're still at prototyping phase anyway.=0A=
=0A=
=0A=
> Rust files may need a separate directories to host libraries, application=
s and PMD.=0A=
=0A=
I'm not sure this is strictly required - perhaps "nice to have". Bruce's ap=
proach=0A=
has been to minimize changes in the "DPDK C repo", doing just enough to ena=
ble=0A=
building "Safe Rust" wrappers on top in a seperate "DPDK Rust" repo.=0A=
=0A=
I like this approach - use what bindgen gives access to - and incrementally=
 export/expose=0A=
more DPDK APIs *as they are consumed*. This ensures we don't accidentally o=
ver-export,=0A=
or have mistakes go unnoticed because nobody tested/used the APIs yet. More=
 on this below=0A=
in the context of bindgen usage.=0A=
=0A=
<snip>=0A=
=0A=
> > diff --git a/buildtools/rust/build.rs b/buildtools/rust/build.rs=0A=
> > new file mode 100644=0A=
> > index 0000000000..1ffdf03d2f=0A=
> > --- /dev/null=0A=
> > +++ b/buildtools/rust/build.rs=0A=
=0A=
<snip>=0A=
=0A=
> > +    let bindings =3D bindings.header("buildtools/rust/wrapper.h")=0A=
> > +        .derive_default(true)=0A=
> > +        .allowlist_function("rte_eal_init")=0A=
> > +        .allowlist_function("rte_eal_cleanup")=0A=
> =0A=
> Calling the `allowlist_function()` method generates well-maintained targe=
t=0A=
> bindings.=0A=
> That approach requires to specify each DPDK symbol for Rust=0A=
> library API explicitly. There are way too many symbols to bind even for=
=0A=
> a simple network application.=0A=
=0A=
The "allowlist" approach ensures that DPDK C functions, bindgen-converted i=
n Rust are used, and reviewed.=0A=
=0A=
If all DPDK C APIs are exported, there is additional and unknown risk of bu=
gs, that the users=0A=
of the DPDK-rust-bindings will hit: providing bad user-experience. I do not=
 believe it is a good=0A=
idea to export all API structs & symbols without any tests, reviews, and qu=
ality control.=0A=
=0A=
If it is really desired by a end user to export all C API as "unsafe Rust" =
bindings, there are many=0A=
crates existing already doing this (and your patch Gregory also provides th=
at method?). I do not feel=0A=
this adds value for DPDK community to maintain: the end-goal must be an erg=
onomic and safe Rust API.=0A=
=0A=
My vote is to incrementally "allowlist" new APIs, and having a "Safe Rust" =
(or "idiomatic Rust APIs")=0A=
wrapping them to export public functions in the "end-user facing" DPDK Rust=
 crate. This ensures that=0A=
any public function in the "DPDK Rust" crate has been built, reviewed and t=
ested.=0A=
=0A=
This will cause the initial versions of the "DPDK Rust" to be very minimal,=
 and to gradually=0A=
export more functionality and APIs in a safe way. From my perspective, this=
 is the only way=0A=
to give a consistent high-quality user-experience that is the norm for the =
Rust ecosystem.=0A=
=0A=
=0A=
> Bindings file or directory for RTE library API is not enough.=0A=
> Each PMD has it's own symbols set and will need a separate bindings libra=
ry.=0A=
=0A=
As per above, I recommend we focus on minimal functionality, exported and e=
xposed in an ergonomic way.=0A=
That means initial focus on EAL, Lcore management, Mempools, Ethdev, and Mb=
ufs. Or from a "use-case"=0A=
perspective, enough to get L2-macswap to work using "Safe Rust" bindings.=
=0A=
=0A=
This means that things like "PMD specific symbols" are not going to be high=
 on the priority list initially.=0A=
Once the above L2 forward use-case is satisfied, I'm happy to provide input=
 on designing an API which is=0A=
"PMD specific" in a generic way (initial technical thoughts, a "dyn Trait" =
with downcast to a PMD specific trait).=0A=
=0A=
=0A=
<snip>=0A=
=0A=
> > +#[cfg(test)]=0A=
> > +mod tests {=0A=
> > +    use super::*;=0A=
> > +=0A=
> > +    #[test]=0A=
> > +    fn test_helloworld() {=0A=
> > +       let appname =3D std::ffi::CString::new("test-rs").unwrap();=0A=
> > +       let mut argv =3D [appname.into_raw()];=0A=
> > +       let ret =3D unsafe {=0A=
> > +               rte_eal_init(argv.len().try_into().unwrap(), argv.as_mu=
t_ptr())=0A=
> =0A=
> Activating rte_eal_init() proves that Rust crate has properly linked with=
 DPDK=0A=
> libraries.=0A=
> That is more like infrastructure test.=0A=
> An active network port with IO capabilities is a real Rust-DPDK POC.=0A=
=0A=
Agreed - as you can see, this is a #[test]. It is intended only to show tha=
t eal_init() and cleanup() work.=0A=
=0A=
Next steps are to "allowlist" more DPDK public API functions, and start bui=
lding "Safe Rust" APIs over=0A=
them, in order to expose an ergonomic and misuse-resistant API. As you note=
, this is where a network ports,=0A=
lcores, mempools, and ethdev configuration are all required. First goal som=
ething like "Safe L2 macswap"?=0A=
=0A=
I will make some Safe-Rust API suggestions for EAL, and send a patch someti=
me next week to discuss.=0A=
=0A=
Thanks for the inputs! Regards, -Harry=0A=
=0A=
