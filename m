Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F70CD98F2
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 14:02:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7C754060F;
	Tue, 23 Jun 2026 16:02:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id F0AE9402D5
 for <dev@dpdk.org>; Tue, 23 Jun 2026 16:02:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782223368; x=1813759368;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=WxILRPd+mI0fSbh11ryPGMHlfj2UJvMKw8kw/Rds6M0=;
 b=AD6VtaOik9ZA1ozulXicDL1VINlR7y5LPpR3PL6e2IyFPkOpPyvn3rKG
 FZa2OR02WxZLbWTZ5H6hAjDT7hVt6qlynuynSZMK7zzOYvmak+RDSRgI5
 ajUywOJYBG0tGwQupvJ/RFScpYOoVYhig/WIluxH157cr0aLWNi1TgsiV
 Qovol+67d44qB3AW7SkFfgWIMNfBDNB0tGaK+763QeKMOjvrA9k9t+y1c
 0fZeuGlXaASEWABBOS1nh9sNotASY+iyx6/vpErJQ1Fdo+D57UOyT4Lc6
 OahY12BXZbqgutMPYLaAAFM7Ogh/8CDzJIzqxdODETh76+Qj/SXVa1KVj Q==;
X-CSE-ConnectionGUID: ZIwIhq0BSxyYCQ+dZeNIPw==
X-CSE-MsgGUID: IcRzWKNTREyv0FLDqsmOkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93621151"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208,217";a="93621151"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 07:02:47 -0700
X-CSE-ConnectionGUID: i4lJagf3SZKhqTRuk6+qZw==
X-CSE-MsgGUID: Hxpu9c0kSi2GME4dCWNOiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
 d="scan'208,217";a="249634282"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 07:02:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 07:02:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 23 Jun 2026 07:02:46 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.31)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 07:02:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBr2+WM7aPYmTf4DfKgDsH16o00iFbve1pMnX3nMITuypTYbdXIJRlHj/EQ+hgfKOWH67OflppFUhmrWKGfibwM88jUN9DwCo2w4lgAPnSKhXXIUDqoqKDKbIPK9+wJdN+6U0Q3jxEPs8M1CedoJsW8w4qlwNiwsmjqB0UJeta1CorKXwHavQVpeS8XyQyXf7Iq/C5bC7SDyvywiadKIb/zTrq5CdPDH/e+5e0PQPCTvnYBy1IgdoYYeeMxHkcqjf8jsL80lfyiHobC0yF9Lojp4y2bVurq8GcXsjFP2+GxfYazClxUK8RUuzIIQm1Pf3gGMCw1NR8aDOhMFEQXQRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvFUnPyq+wzr+zlAbMx1NYm9OIWz3L3zj183sYma8hU=;
 b=Q6gtvHX8NbL17Ndqgf+3QwUtsOLshvYXspiEc/NwF8rB4wsr6fyGw4F847FGkHCGAmvAguvf+71uIwkRXmpCNwHqlRgVDZ+hotF5xkhNQFQsRsva4+Qg+KjQbi1dmseJNwaEPOUr/lhieIoOy7MP4g3gQviIEmcRgcK1cGwvHYxvWoqD0LqCTnsLpUSbb5sNRKHTKUCiebOQr5nZhxOxPRqNeeVuQUDOJUmGWx2UQb87QiYelmvIR4x+f5GU5tj4vylKOLShaED8mvhTBQ1iROSX0CGETzlm6MYqKrzb1DdQAqx73HI48vKmIc2R5aWT/jI4yQNRP4TQKC6IDwspvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS3PR11MB9646.namprd11.prod.outlook.com (2603:10b6:8:38f::18)
 by PH8PR11MB6903.namprd11.prod.outlook.com (2603:10b6:510:228::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Tue, 23 Jun
 2026 14:02:42 +0000
Received: from DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd]) by DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 14:02:42 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2026-06-23
Thread-Topic: DPDK Release Status Meeting 2026-06-23
Thread-Index: AQHdAxjXTbDaaGpQtU2LO8g/f0wjBA==
Date: Tue, 23 Jun 2026 14:02:42 +0000
Message-ID: <DS3PR11MB964636B48403BF6BF70A1594FCEE2@DS3PR11MB9646.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR11MB9646:EE_|PH8PR11MB6903:EE_
x-ms-office365-filtering-correlation-id: 5da0582a-d51a-4a01-5cb9-08ded13017c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|38070700021|5023799004|11063799006|56012099006|18002099003|8096899003;
x-microsoft-antispam-message-info: 7oHo1ymHfi3OYE0D5RtnJ+g0R8Dr5RLEZ+mYaQ4XofuDAuzaRHSyP6qsFz5btGZiX5de3AyP9WFdlsbmTKUC9VxElPZfNbWsour29grujvgEqJ/uJxLiObg3tJmUIpkT3Tb615QX0qmmAeOuAOnL6aj7Mx2FhuTi5uBHh87blUPvUhLOamOpeJDku33YzkZYO9xzF7JtNM/5O/QJFRYqPmN8/zm6ryL4tinZqM5s1ohfAU7HIvn9tfsG7Oif/Qnk/WNRsesRj97GvJKsaiQvevIJp7Ea8DCJ75I5kUNgR21xmvVmD7h/gdsoeAvNvSyuRt7rGEJsw11QotOE91fXIoO3jHbbP9sVbI1pGpF1VTCfa3lNICEixms7TetPoaNjc2Ma6XWoz0qBPWACqY7M/MQeDv6JHppdXgq/CegEuoQWs+MLmZNuOfqcoAWQSjhnwvM9G5HJSX92KyuuCUHuWbwqA+jsbXPUR/OInNSCIr87rjaeRdpvouSE/Auf/9zSIUsjECz4bkBy2ESWrRi3tCir/bUW8a/kUJ16Wrc5fxdkCy3OJ2gJK4ALRvI6Ly+iPV2kWor1zAmcStOstFx73GuMONop7W5/5dyym4cSBGGn/ZS8kjOJptrrC38nyrWiKjp/Eg/ckbCyyNJOCEPJt/ZlicBPRcL0DPg/4bQ8fms=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR11MB9646.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(5023799004)(11063799006)(56012099006)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XmUCIY4ZeuWRjG1WFC/NzIzvtrjLSLQpupmcRactdGb84U2AUbQ8sGjtGk?=
 =?iso-8859-1?Q?ee1yXIAU27yB1X+8Xqs+qx6joPRkRrpKtPQ0HOnTBCNikVvDDhZr7nmbd3?=
 =?iso-8859-1?Q?rwUIIEUFy1YBRcxp3zW3+6+yFLVSF2FvJbjBq+gxpuh9t84MRBdDfdbA3J?=
 =?iso-8859-1?Q?HPppsb8XSwYJg8J9FqmxzkO8ThzEHUxPNR6vXh5su822g3YmWHmiBz6sMr?=
 =?iso-8859-1?Q?PrUctZ4GUuksNS5lPEm3x6YRpAIyHxSrLGypRTQg5o0u3Lg17mkScgZkwV?=
 =?iso-8859-1?Q?iNhJ6idXSMOm/4tQj1jY6IheHHF9pSOWjApVataV7cfhMW4mBKwBy8jH7M?=
 =?iso-8859-1?Q?dV1KJNVEEmi1I/6gv+qnfVaOvgJpuOR1Kj8X0f2N1/nF3h8RL0UNYHB8k6?=
 =?iso-8859-1?Q?Emkni0LKFAK3d8haHO29M7IhVqFV3L8JIGl5Ua2MTBfv8L/ETQhR9qajVU?=
 =?iso-8859-1?Q?8gJkvGOVgEXtEypjiD7HpCbbckXdN5D2+nW0O9xk+Co2WZGyS+L+u4fAc7?=
 =?iso-8859-1?Q?WB7/gCvbt5Wk8H/xhxMpOmYUOHboh3p1fm2wop3cckJgC1qEDnbtvAsqSx?=
 =?iso-8859-1?Q?rlZhIZ8AW8ug9Ph6EX99oABIqbpCZ0wGNyqec9ILgz99RkWS99CNFsql/n?=
 =?iso-8859-1?Q?MNu73z5Je9LOKgUfj7CKABPjkAJl+8W5jruV5Vrlk5ySMO/Ok1zmNhzZ2M?=
 =?iso-8859-1?Q?puRls5/wweM2ytBg1V4Gd7F2cIm9q2gdetkiqMXTlKKLTEy1fo+GoK492S?=
 =?iso-8859-1?Q?4h9mthj3vWmsDCM51aGPzj6vIw15RY9/UgDK0CY8iFJuJskC2PU/t44OJU?=
 =?iso-8859-1?Q?QdSgowUYiwmyIz+Cdx8MWY3Qv7rsAjP70xpwwjK7nFH7M22vNk925XLpkG?=
 =?iso-8859-1?Q?MQyl+DrH7U5ndeT7HmzYrMIbo/HCj82FADDlW5EiAer5bfGpjDLIiU/S2I?=
 =?iso-8859-1?Q?A0dZNGksO/9DBygFYaRTJKrkf3yHcIgi2X5PnM+yTRFDhkNmYdvTsg0o+S?=
 =?iso-8859-1?Q?9GvQ+//6nOYzjEFWPRqndCs6tRWLMAohgYL0mZYEVYA77otr7xOYKNsZxm?=
 =?iso-8859-1?Q?Sr+Qx/jxU2W1SPv7N/TUKLG5pc07XZqLm2rwMYcl/L580gmrAoamwjOOci?=
 =?iso-8859-1?Q?Qs3+CFHFg6vB3Wc45PYz92H86u+AKLA6/wy8wEg48lUAKZWlUgVowD+OiO?=
 =?iso-8859-1?Q?ppzuga6oU6bfzCh0sJ3F678fFrnyiARsNmlPrHXp7v4MlMHDYggNP03h4k?=
 =?iso-8859-1?Q?ArhZIZwQOcxrKznBoeNUvOvkWOJv6OJAdYuLpQkfhDDf6NFl5ampduDYpk?=
 =?iso-8859-1?Q?mSVC8Z71+VucY6lwbbUmUdZWKsOd37Jbt6E58UmGMkUlbtuscEl6+Qt33Z?=
 =?iso-8859-1?Q?CRSkD2D1gz/q3LCEY9NW6aooGsBw20mmoGcOuLMadUy4YyHWnDPsFBFxTB?=
 =?iso-8859-1?Q?uftFMittLTjY3IzXkHtoWCXn3Oo1QRUrK91VVaEX8IruLy8xmRL6wMGhV/?=
 =?iso-8859-1?Q?OAm77GdFtPIenzX23C1pwbWhpUEmzTmCvqaf4sGSxl3Wuecags34uxxxLq?=
 =?iso-8859-1?Q?y3g8uGsumDkGAo34Y4+vTG14NDXwxCk1WYZ2mmC5BJ9qu0Aoft/CZU3Xyz?=
 =?iso-8859-1?Q?7vjL54pBeKpWLoruolTzpxQQie8V2rGhgEWWfl36Bf+riN317yoQtrBIgW?=
 =?iso-8859-1?Q?ylh83T+oxZ7KIX3+PQ4EoJkmbgA4d/rnAzwZwGqZCYkqRn3mu0eQ/sNziB?=
 =?iso-8859-1?Q?t8CXo6cNA+uFk4rkFU8mE6anX/3qsOID/oNhKem17Ux2CN9eLTltS5GdYc?=
 =?iso-8859-1?Q?He7Y6eMf9A=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS3PR11MB964636B48403BF6BF70A1594FCEE2DS3PR11MB9646namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Hjy5EduaZKVCs2wWphrJ/8NzFNh33cyP4jcGNFbsc9ly4xMsffaH7s8n2XjU2DJ3kCwgLKCkgeyUT/W7YGOTbgW7KX/nSAAFtnqzyr4LhtxVD18q+3jffK/xK66hvaVOIf3PEoirKU6U2F2DhA+X54/hPRunvZSIOkrHcTkWrv5D2wrpEV4BTF3d2ER9T8BgWEsiorjQ+J2OW8fmd+VnQ9EHtvb47kd0BKYEovAZcSJ/9yeXfsNERT+beZ7g1L9mtnn9s0pawp2ySfsEuiWmx1dBj7/S6b2hipgJwXdUhpN4nUhJxDdvRl9mnwTltupl2xyHVZt73ImTHOetNVNv8g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR11MB9646.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da0582a-d51a-4a01-5cb9-08ded13017c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 14:02:42.0353 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ua0ZGE/mCgytqpiQXOLbuhpDe2qaajkBCF1ROB9vp9Vo2z91a6ju3sqJei4+lsSgUIge9ZKhQVUA+1GEDsdtHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6903
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

--_000_DS3PR11MB964636B48403BF6BF70A1594FCEE2DS3PR11MB9646namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2026-06-23
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Agenda:
- Release Dates
- Subtrees
- Roadmaps
- LTS
- Defects
- Opens

Participants:
- ARM
- Broadcom
- Debian
- Intel
- Marvell
- Nvidia
- Red Hat
- Stephen Hemminger

Release Dates
-------------

The following are the proposed working dates for 27.03:

| Date            | Milestone        | Description                     |
|-----------------|------------------|---------------------------------|
| 30 April 2026   | RFC/v1 patches   | Proposal deadline               |
| 11 June 2026    | 26.07-rc1        | API freeze                      |
| 25 June 2026    | 26.07-rc2        | PMD features freeze             |
| 02 July 2026    | 26.07-rc3        | Builtin apps features freeze    |
| 9 July 2026     | 26.07-rc4        | Documentation ready             |
| 16 July 2026    | 26.07.0          | Release                         |


See https://core.dpdk.org/roadmap/


Subtrees
--------

- next-net
  - 76 patches ready for main.
  - 26 patches in review/waiting.

- next-net-intel
  - 6 patches merged, ready for main
  - Small backlog.

- next-net-mlx
  - Some patches getting ready for pull.

- next-broadcom
  - Most patches merged.
  - 1-2 in backlog.

- next-net-mvl
  - PR sent.

- next-eventdev
  - No change.

- next-baseband
  - Nothing pending.

- next-virtio
  - Nothing pending.

- next-crypto
  - No update.

- next-dts
  - No update.

- main
  - BUS refactoring.
  - DMA driver to review.
  - Started pulling trees for RC2.
  - RC2 targeting June 29 2026.


Other
-----
  - None.

LTS
---

See also: https://core.dpdk.org/roadmap/#stable

LTS versions ongoing/released:

- 25.11.3 - In progress.
- 24.11.7 - In progress.
- 23.11.8 - In progress.

Older releases:
- 20.11.10 - Will only be updated with CVE and critical fixes.
- 19.11.14 - Will only be updated with CVE and critical fixes.

- Distros
  - Debian 13 contains DPDK v24.11
  - Ubuntu 25.04 contains DPDK v24.11
  - Ubuntu 24.04 LTS contains DPDK v23.11
  - RHEL 9 contains DPDK 24.11

Defects
-------

- Bugzilla links, 'Bugs',  added for hosted projects
  - https://www.dpdk.org/hosted-projects/



DPDK Release Status Meetings
----------------------------

The DPDK Release Status Meeting is intended for DPDK Committers to discuss =
the
status of the main tree and sub-trees, and for project managers to track
progress or milestone dates.

The meeting occurs on every Tuesday at 14:30 DST over Jitsi on https://meet=
.jit.si/DPDK

You don't need an invite to join the meeting but if you want a calendar rem=
inder just
send an email to "John McNamara <john.mcnamara@intel.com>" for the invite.



--_000_DS3PR11MB964636B48403BF6BF70A1594FCEE2DS3PR11MB9646namp_
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
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Release st=
atus meeting minutes 2026-06-23</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Agenda:</s=
pan></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Release =
Dates</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Subtrees=
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Roadmaps=
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- LTS</spa=
n></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Defects<=
/span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Opens</s=
pan></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Participan=
ts:</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- ARM</spa=
n></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Broadcom=
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Debian</=
span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Intel</s=
pan></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Marvell<=
/span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Nvidia</=
span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Red Hat<=
/span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Stephen =
Hemminger</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Release Da=
tes</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">----------=
---</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">The follow=
ing are the proposed working dates for 27.03:</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| Date &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| Milestone &nbsp; &nbsp; &nbsp; &nbs=
p;| Description &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; |</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">|---------=
--------|------------------|---------------------------------|</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| 30 April=
 2026 &nbsp; | RFC/v1 patches &nbsp; | Proposal deadline &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; |</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| 11 June =
2026 &nbsp; &nbsp;| 26.07-rc1 &nbsp; &nbsp; &nbsp; &nbsp;| API freeze &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|</s=
pan></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| 25 June =
2026 &nbsp; &nbsp;| 26.07-rc2 &nbsp; &nbsp; &nbsp; &nbsp;| PMD features fre=
eze &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| 02 July =
2026 &nbsp; &nbsp;| 26.07-rc3 &nbsp; &nbsp; &nbsp; &nbsp;| Builtin apps fea=
tures freeze &nbsp; &nbsp;|</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| 9 July 2=
026 &nbsp; &nbsp; | 26.07-rc4 &nbsp; &nbsp; &nbsp; &nbsp;| Documentation re=
ady &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| 16 July =
2026 &nbsp; &nbsp;| 26.07.0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| Release &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; |</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">See https:=
//core.dpdk.org/roadmap/</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Subtrees</=
span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">--------</=
span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-net=
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 7=
6 patches ready for main.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 2=
6 patches in review/waiting.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-net=
-intel</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 6=
 patches merged, ready for main</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - S=
mall backlog.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-net=
-mlx</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - S=
ome patches getting ready for pull.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-bro=
adcom</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - M=
ost patches merged.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 1=
-2 in backlog.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-net=
-mvl</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - P=
R sent.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-eve=
ntdev</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - N=
o change.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-bas=
eband</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - N=
othing pending.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-vir=
tio</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - N=
othing pending.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-cry=
pto</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - N=
o update.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-dts=
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - N=
o update.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- main</sp=
an></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - B=
US refactoring.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - D=
MA driver to review.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - S=
tarted pulling trees for RC2.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - R=
C2 targeting June 29 2026.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Other</spa=
n></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">-----</spa=
n></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - N=
one.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">LTS</span>=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">---</span>=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">See also: =
https://core.dpdk.org/roadmap/#stable</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">LTS versio=
ns ongoing/released:</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- 25.11.3 =
- In progress.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- 24.11.7 =
- In progress.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- 23.11.8 =
- In progress.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Older rele=
ases:</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- 20.11.10=
 - Will only be updated with CVE and critical fixes.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- 19.11.14=
 - Will only be updated with CVE and critical fixes.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Distros<=
/span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - D=
ebian 13 contains DPDK v24.11</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - U=
buntu 25.04 contains DPDK v24.11</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - U=
buntu 24.04 LTS contains DPDK v23.11</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - R=
HEL 9 contains DPDK 24.11</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Defects</s=
pan></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">-------</s=
pan></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Bugzilla=
 links, 'Bugs', &nbsp;added for hosted projects</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - h=
ttps://www.dpdk.org/hosted-projects/</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">DPDK Relea=
se Status Meetings</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">----------=
------------------</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">The DPDK R=
elease Status Meeting is intended for DPDK Committers to discuss the</span>=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">status of =
the main tree and sub-trees, and for project managers to track</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">progress o=
r milestone dates.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">The meetin=
g occurs on every Tuesday at 14:30 DST over Jitsi on https://meet.jit.si/DP=
DK</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">You don't =
need an invite to join the meeting but if you want a calendar reminder just=
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">send an em=
ail to &quot;John McNamara &lt;john.mcnamara@intel.com&gt;&quot; for the in=
vite.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"></span><br=
>
</div>
</body>
</html>

--_000_DS3PR11MB964636B48403BF6BF70A1594FCEE2DS3PR11MB9646namp_--
