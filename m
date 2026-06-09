Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDF0CD98C5
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 16:19:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22EB44025E;
	Tue,  9 Jun 2026 18:19:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id D8BA7400D5
 for <dev@dpdk.org>; Tue,  9 Jun 2026 18:19:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781021979; x=1812557979;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=bh8kQw9npsMD9ILb4nV3wjlwq43LFrIZQo1IxKZL+PY=;
 b=a+vwRVnNm3DnbiuBwPjDl2CFF+Q7czbh6JzO8ndmFuDVTcusm10wsqz5
 CnTao0rE/oH1HJqQ5fyVbu+a7GIzG48Bl/XAus1Qk4gEgIdMPcXdNBLOi
 a/GDVM1MkaDz4ZeNrx4IhicKHxlo3VzbWxmRgmKalN7iFeD905TrdF1t+
 BAvqGeBu2eP9YFoU8IIG+laRnYo3RowfoPKILDdGax00G1ZlZH2cI1s0R
 W0HFN93xfzw5UZOC7FCpXkyk/QY4FH/j4jCMskZVWqGvYUiMJCY5VPmZW
 HwzLIA7jjYLI4WJnt2be9r4IoeAT6DU2/bTQ76V6pKZIkMH3DNOOxAoVZ g==;
X-CSE-ConnectionGUID: ZsVlPKgSR8SXUggr94tMTQ==
X-CSE-MsgGUID: mvxC4ntaTAGIlAtphHQoYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81977195"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208,217";a="81977195"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 09:19:38 -0700
X-CSE-ConnectionGUID: iwddQf/uQH68a4EaHXmKpQ==
X-CSE-MsgGUID: FhAUb8GdTYKr9TzimkRDgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
 d="scan'208,217";a="245937463"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 09:19:38 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 09:19:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 09:19:36 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.17)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 09:19:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zg8FW3jkolLTEAl+z8WhePHy9Xl/xwFxU47Wi3sNXpn3NacCUP0dV2e+KmVx0+hYx0xFtDAi4/cqcDgh8TO+krmKgHSVqz7AyzcvOBZF3tdvXF1qGonDJZbqQq4YHZ7SllXmAh8hXU3BIfl2qAaL3uy+0gPwEwx89jUgBk94J5REl6CB96O/IQCHEfTscu9DX+5DCscX5LBjUaDr1s7k7Buw06kUKBslc7Y0M3nrUffJCJrLRbNSSIDITWawCwLZmx0e7qbDQeNohrVHqP5G9V9fbmE+zMFEhHrbxs+j7uCv7jr6Sx3uQg4L6UG4hGJu5bQ1zpzduJe27v2EXII1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiJC0L21EkJpQRJqLROmEqihojfR6HsD+2sKLymiPbM=;
 b=GCPtGxuGS4m4q+SNfWzuXhNEW5P/zrgFw89OJLIV1xGu+BDbzvAi65B3TovKvIGAz21lu3uewkO6auUMCDH0PW4oBEI02gcuoOTPSsTA4Cj2BKV/uVnwqLU6wAaq7DRcXyeAOnUjogwt4K0ae++kwVVjq+xx3bITyng1wDzWa2NSCskT6l74pZSl0rhIIw/WPLaRYUcGMXmXbcs6xA/QVxhHsepEC+IC+nw+OET5TPNoCH5D4gft5ecxixPML2PDvIAiTCbGbkTWmmFDU9BclAKSUtd3baP3AMjSa9u6xVhNDK4A+u/6NSXhI98OdQ3aiyxuO9Z3A0fx94bWE/LP6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS3PR11MB9646.namprd11.prod.outlook.com (2603:10b6:8:38f::18)
 by LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 16:19:30 +0000
Received: from DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd]) by DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 16:19:30 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2026-06-08
Thread-Topic: DPDK Release Status Meeting 2026-06-08
Thread-Index: AQHc+CuaferdjsWw70aY6T2jIgGujg==
Date: Tue, 9 Jun 2026 16:19:30 +0000
Message-ID: <DS3PR11MB964670500323BFD0822A7DD3FC1D2@DS3PR11MB9646.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR11MB9646:EE_|LV3PR11MB8508:EE_
x-ms-office365-filtering-correlation-id: b5649da5-fd64-4f2b-46c1-08dec642e2b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|56012099006|11063799006|18002099003|8096899003;
x-microsoft-antispam-message-info: EvOFJduaADjlRbVSIQlbsY/QNyvnO+4VN/kcfNkt/9/YS5DmloDO8SeDuxq+ioPCYE0OHbYnIgWhegkr95nDJc8WPaKz9E4rvq3NfGSf4r4NUklSgEccBkZZwJNzAjU8gPwVa7a5vZnlCqP56d/bTrQzXhVhCPLU0LztzAH9EcO3vNzU7nPgPOxfuJuffMOFGw6zAt0YGI4eost19C0luuSTsgFWmjC4pi9hoQUvx21PCSBUxPWCIc0ajpNfUroJBdxik2P4xZLsZApRpYP6LsRhF6cwRMaadHwoJsDKlj4+6O4Dfc4PA2Bk9/8tf70BUyEw9EyKN8YwRJWiTOMXEsxhpb7Xln0nzDwNoLCUgbC4RVOjvs4F4746k05KYV+AdSkoedtdrMGh0vUlmqXoPxrtCec/7Xi+kiTwNtuFxlWNfPM/Q0cpy7gxfSwF5XZhA3teqSQN9VXAircP7lpB3ylRc1hoSUX9uqPBcdE/OP+TuKh1Z5cKBJfVKai25kz2o+XOvFJGxYjSm8Youa5P895awRnh3P6fnxsfzb7NqYJE7sKfgSDl9di6xmpint0fO5evOLA1l9U7E/bocWBmo3QUsgnLOVv38UF53FIm0J3k+BY+DyFR+ANWYcD15tP18g7+w5/ZynXp52jO3qR9Jb1sizWf8QN2TFq8ilZJXXLO+orPZDL9rQCa1myQpbzugH0bhRVdhP3HVN7tzkA5xg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR11MB9646.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099006)(11063799006)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kkzWewXv2XWFiagRS5uqYEZLQMHZr4njTAdz+ByXC7qhifxJxHzf5v9Acl?=
 =?iso-8859-1?Q?5K69BvEY6Q/0k217O+66ZCDiJFzmJNVlUxWz519MV7/jlRII3h4pyOa3bv?=
 =?iso-8859-1?Q?06dKsjUTbZi7GEw9hDhrcVm6OChpQFYoGSZxPR2dG3A2O3ZzIIQCiGUy9f?=
 =?iso-8859-1?Q?JsIKSc2X9lcQx0Y5rg1zDLqADztARK9ls6sxxO/9kCi0gFJozF7zZkbBTM?=
 =?iso-8859-1?Q?zYcdm5dQwuyHcuC9ulzz8sRkXp6V6KrzWP2GJq8ecueLgxUUaqSeLXHrTP?=
 =?iso-8859-1?Q?XaJaDUQUEKwNsveo5oWRBYgN63vBWEpfQNpHyJ7AdGV0kzY3Nplum4L6od?=
 =?iso-8859-1?Q?cryUBQFFtStTAnP3/DxLJUXTCCXCytQruabAJq50GEhenfx6+ZloVMGwKB?=
 =?iso-8859-1?Q?DzWXG8s1gQd8mRT65djTytm1EzDdtg1CPvZNBvZNXIPamS/Eyaz67Ljclt?=
 =?iso-8859-1?Q?Lt1VhAENsY5T1bMt1QrhHeek95hPZmK1az9eSnY2WI4Vz1Pal931Zg0z1g?=
 =?iso-8859-1?Q?+AATUB9p+ccO+t2xksGPgXO4zWL0lLh29tKaQANylPPWx+lPZ0CX0XmAr2?=
 =?iso-8859-1?Q?YMzwVziNfLKhdTu8TEtoJOOy/3sqOOSjCpJISVe40/k9NrFdv4zdjaK5+H?=
 =?iso-8859-1?Q?4zlmHo/uXDxTqejOra2tv7jcmmJwpRacrFbHxU7m04QYtc9clmZRbV2SOY?=
 =?iso-8859-1?Q?mzN9X0N8UDzj1F5GZ/JsEs6tEHKYirxBuxh7uZqsKvE04JTnsL5FhZcjb9?=
 =?iso-8859-1?Q?Wssest94FwnBbG8rCg1TTCMoE1TR3WSRgc1tkJUDiqWA5K7X9MelJNkdvC?=
 =?iso-8859-1?Q?8Q3OQLiRbbE7jF/xYCynSbGH6qwZn9nplus5gzVPHqaXLiisyDx+jUs4Br?=
 =?iso-8859-1?Q?ti/RGXqkyZuFhrdyJdzx9mcTqkoYtAvPRMp+9+UcCBU4QldR5eTQZRM7Sj?=
 =?iso-8859-1?Q?ah+TQVzjZHwYu2BVb4DnQIMcRY4EiVbQe4NAkArO06FRteFHfOh/Tmascg?=
 =?iso-8859-1?Q?3EcZfxAMz6bGKhRSz4XmujSrKrvfI9p8pTEkl2JmfbfWrdbO20/4qX3rhv?=
 =?iso-8859-1?Q?XVIGrKw0F9B3anDaI06TAcKOjhklHQSiWcOo7SZszCp0oE5wUgmDKsgvR0?=
 =?iso-8859-1?Q?EFgUQYNhtpO/eULhehUZ4bCHblA0ZgrREIIfaBikKI0AA0rA0mBXuY9/r9?=
 =?iso-8859-1?Q?8Shz5xCiy9HA7/yDjZ10puwJwEJX+z+qd3+Z2Lp5SdImniSbFG/Blrwfcw?=
 =?iso-8859-1?Q?YLV+bAmQk2SpgO7tjZmn1qF4nORZOZO2F9ZvtOfF+htbJl120w9YpN/J8p?=
 =?iso-8859-1?Q?ZhnqDoFCsTTsKdVg6Za8J4SlwhWm+V8gaSR09+9hZGk5NHQWcZcVRMmRQV?=
 =?iso-8859-1?Q?hZV2EL+xASDltZE03KUc8wfsJCazl9dXc7Ww1nSDVuK7Xv745Ur/5N0vgC?=
 =?iso-8859-1?Q?FNyg0CWbmpBJEblacslsDYPLNicNMoEuO88GVnY4qShW4QZmS1mUlnOLyW?=
 =?iso-8859-1?Q?t6cNOv73s6gd9B3jazL5EEw8en9bRzgSh4cpeoVFvc06TZXQXRMtjWO0cT?=
 =?iso-8859-1?Q?bcQ1JetovPdY+Xuvl+cU7FsDCOyaohoIQpeygAOrVbzOjJ+cXZLyfBNpee?=
 =?iso-8859-1?Q?+GzRszXUmQxM0MzmX+jKNjclv9ubdmAoLyP54MFRlj5w0cjcrXnmZet3MY?=
 =?iso-8859-1?Q?OyHs4IH0KBgOvhA+24kiePhCsTKOMN+r/v2xRxT5wvVKbz1Z04IejVrqRW?=
 =?iso-8859-1?Q?pam1ngrXElVA7ndCJysZkzMG0tjUDprxjNLv/GJ4YjuZSCbmNzrT4uexNe?=
 =?iso-8859-1?Q?5mmVJ3bh4g=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS3PR11MB964670500323BFD0822A7DD3FC1D2DS3PR11MB9646namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fRqLsrNUkzDjTQQxh5FIAC1KnLO7/S8+xwIgMWyAg6Uqt8mztcQfgWDYOIjhQvD1IqmyGsIEjrukE2V1f4IKvK+66/f1aaWt+7asdeDVDUHx335xyHAKULpuWgsRFKVLBJmCgt3QPhP6G5wq8GCMxZjELbC3nuDSkL/KjC1dyrOKzxBf4VFoClMZNmvhBrb3y+aln4bWoeG8ANy2VLnxtCENi4xUR33gVyLQsMK3LRBZofwQ1lh3qPbb1dv8zz7k51/UxPzu10kHg0js22IDAKdeb2abjn3oA2oa9UvPvQxcqWSNhTROTcvYOrjtcSmf5rXHJbyed4TSr2QEyYk6aQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR11MB9646.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5649da5-fd64-4f2b-46c1-08dec642e2b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 16:19:30.6033 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3nWuSuUFb1kCGMY20mFj2YK7MO6mGqHKKwmv5wUqqLw8r+4Wso0jPkbWHsab9kqDx/1fYbStyUJ9EOgBL1DliQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8508
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

--_000_DS3PR11MB964670500323BFD0822A7DD3FC1D2DS3PR11MB9646namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2026-06-08
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
- Broadcom
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
| 04 June 2026    | 26.07-rc1        | API freeze                      |
| 25 June 2026    | 26.07-rc2        | PMD features freeze             |
| 02 July 2026    | 26.07-rc3        | Builtin apps features freeze    |
| 9 July 2026     | 26.07-rc4        | Documentation ready             |
| 16 July 2026    | 26.07.0          | Release                         |


See https://core.dpdk.org/roadmap/


Subtrees
--------

- next-net
  - Has been pulled to main.
  - 34 patches in review/waiting.

- next-net-intel
  - Has been pulled to main.
  - 3 others to merge.
  - 9 patches in backlog.

- next-net-mlx
  - Has been pulled to main.

- next-broadcom
  - 20 patches ready to be merge.

- next-net-mvl
  - Has been pulled to main.

- next-eventdev
  - 1 patch to merge.

- next-baseband
  - No update.

- next-virtio
  - Has been pulled to main.

- next-crypto
  - Applied patches for RC1. Waiting for merge.
  - 16 patches in review/waiting.

- next-dts
  - No update.

- main
  - Bus refactoring series merged.
  - Looking at fixes in EAL. Large patchset on atomic deprecations.
  - Series on MAC addresses targeting RC2.
  - Hash series merged.
  - RC1 will probably be released 10 June 2026.


Other
-----
  - None.

LTS
---

See also: https://core.dpdk.org/roadmap/#stable

LTS versions ongoing/released:

- 25.11.1 - Released + regression fix on 25.11.2.
- 24.11.5 - Released + regression fix on 24.11.6.
- 23.11.7 - Released.

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



--_000_DS3PR11MB964670500323BFD0822A7DD3FC1D2DS3PR11MB9646namp_
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
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Release status meeting minutes 2026-06-08</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Agenda:</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Release Dates</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Subtrees</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Roadmaps</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- LTS</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Defects</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Opens</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Participants:</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Broadcom</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Intel</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Marvell</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Nvidia</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Red Hat</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Stephen Hemminger</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Release Dates</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-------------</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
The following are the proposed working dates for 27.03:</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| Date &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| Milestone &nbsp; &nbsp; &=
nbsp; &nbsp;| Description &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
|-----------------|------------------|---------------------------------|</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 30 April 2026 &nbsp; | RFC/v1 patches &nbsp; | Proposal deadline &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 04 June 2026 &nbsp; &nbsp;| 26.07-rc1 &nbsp; &nbsp; &nbsp; &nbsp;| API fr=
eeze &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;|</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 25 June 2026 &nbsp; &nbsp;| 26.07-rc2 &nbsp; &nbsp; &nbsp; &nbsp;| PMD fe=
atures freeze &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 02 July 2026 &nbsp; &nbsp;| 26.07-rc3 &nbsp; &nbsp; &nbsp; &nbsp;| Builti=
n apps features freeze &nbsp; &nbsp;|</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 9 July 2026 &nbsp; &nbsp; | 26.07-rc4 &nbsp; &nbsp; &nbsp; &nbsp;| Docume=
ntation ready &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 16 July 2026 &nbsp; &nbsp;| 26.07.0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| R=
elease &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
See https://core.dpdk.org/roadmap/</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Subtrees</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
--------</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Has been pulled to main.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 34 patches in review/waiting.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-intel</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Has been pulled to main.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 3 others to merge.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 9 patches in backlog.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-mlx</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Has been pulled to main.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-broadcom</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 20 patches ready to be merge.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-mvl</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Has been pulled to main.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-eventdev</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 1 patch to merge.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-baseband</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-virtio</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Has been pulled to main.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-crypto</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Applied patches for RC1. Waiting for merge.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 16 patches in review/waiting.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-dts</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- main</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Bus refactoring series merged.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Looking at fixes in EAL. Large patchset on atomic deprecations.</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Series on MAC addresses targeting RC2.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Hash series merged.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - RC1 will probably be released 10 June 2026.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Other</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-----</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - None.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
LTS</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
---</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
See also: https://core.dpdk.org/roadmap/#stable</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
LTS versions ongoing/released:</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- 25.11.1 - Released + regression fix on 25.11.2.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- 24.11.5 - Released + regression fix on 24.11.6.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- 23.11.7 - Released.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Older releases:</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- 20.11.10 - Will only be updated with CVE and critical fixes.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- 19.11.14 - Will only be updated with CVE and critical fixes.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Distros</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Debian 13 contains DPDK v24.11</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Ubuntu 25.04 contains DPDK v24.11</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Ubuntu 24.04 LTS contains DPDK v23.11</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - RHEL 9 contains DPDK 24.11</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Defects</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-------</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Bugzilla links, 'Bugs', &nbsp;added for hosted projects</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - https://www.dpdk.org/hosted-projects/</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
DPDK Release Status Meetings</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
----------------------------</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
The DPDK Release Status Meeting is intended for DPDK Committers to discuss =
the</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
status of the main tree and sub-trees, and for project managers to track</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
progress or milestone dates.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
The meeting occurs on every Tuesday at 14:30 DST over Jitsi on https://meet=
.jit.si/DPDK</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
You don't need an invite to join the meeting but if you want a calendar rem=
inder just</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
send an email to &quot;John McNamara &lt;john.mcnamara@intel.com&gt;&quot; =
for the invite.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_DS3PR11MB964670500323BFD0822A7DD3FC1D2DS3PR11MB9646namp_--
