Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332A3C8303C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 13:43:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C6CF40673;
	Tue,  8 Jul 2025 15:43:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 8623F402A0
 for <dev@dpdk.org>; Tue,  8 Jul 2025 15:43:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751982220; x=1783518220;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=hr8UCtNEtPjypleLrzkznZ8Onnn5rPvaECYSte7N540=;
 b=XwedsA2n/YWA7MyJIyb20Ahck4pJm+lwo5KQDwxZUx598xvXPjnBlCTd
 bQHKciCKXEgDlgjsdFlsqpya1lQYzGrBZVygXJDDrKyPJ/WG1Uezm1a0y
 X04FU3QZzA/C1ADhbgYXF3EBewOvo3xT6CmQVxGi/BvWuUN3eYQy35nGs
 953l1gBlPloN3VwtC/o3BjbCUG5Pu2wdR+mmU36wnoqe+SZrOHX75H03c
 EGN1NPKUZZdHGZN00MWg+q4ZPsvJIjeWp1Pc1xhnz4rWO3a4UmL0K439Z
 uR36xtNptSXzV7jSpAOlHrmzT0LpXWjjFp6N8fh3cScd+iaFnr645IXIP Q==;
X-CSE-ConnectionGUID: R6HWbRSkQM+tm3WaHJnmiA==
X-CSE-MsgGUID: Q1Vyr1RqSUSRdiZFRYzDnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="79651210"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208,217";a="79651210"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 06:43:39 -0700
X-CSE-ConnectionGUID: 4erQfYe9TWiU8jGLr76ZRg==
X-CSE-MsgGUID: H4tm7CuETg6blVgdIzVi5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
 d="scan'208,217";a="155991578"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 06:43:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 06:43:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 06:43:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.47)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 06:43:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jINKUU18Wh2CM8ofJun0ESH1fbuMpvUiCKe4bGN1HIMIWHAkYrfp57SMLuv8fCeGprt5jpJ35XexyCWlLW1nVB95G5st2keuGLUR/RNhHZ2arxjpavs2+W/bpPnYQsCIhkHrDhHUZUUiXWVJIuHnd0s1itxtNE2FkcdBlQRhQuA9jymPrF2rLnUKQqM/4/M6BdQMoAZk6rIAB3H051KiTkzvv+JakBFYiMjduEs9VITCNMLAIgIN5T2SKeXOG8nbqJX8mM3dUTL4GnSBdTxLu72xvrJr1dsXOexYV20B/ZOKH/FSh7+Qa5W6Goj/XuxQWTKOVko0zd+gtijoi82Qvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvaUl+RdgSIew65ePzqGVM7at5pJwaxWPux7t8KeZsQ=;
 b=EUZH4mjgIeebbUtth1gTKOawnA3gC/Oln5NQ4IEa6HaM5LHcThDprVkmnjBOzojngmQ/NA38Ty942bm2Bwwx/HniOCYmYOOQi/EeEWt+i7Gr3Xhw8kiQHlHt3QIe7hq71QZ1VwgcIVTl/lHXBOTYwvxesQUngQR1LMAehdcsGwnzJULhLOK3eD2NB001zte7JbRSAH3ez6oCd1/173LmSYyMfGtpqzmehk6qQTFFuWYsgx1UutYWA+cVYUCu8gr0ZuHU5qxyj/rUyHyvUx2jGtMOINmxftZuMXzuBNod3el5GM+LgYl24oy0bOfU0A0P9FVJIemKUDZM4rP0M7tf8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d16) by CO1PR11MB4868.namprd11.prod.outlook.com
 (2603:10b6:303:90::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 13:43:34 +0000
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::d6a7:781c:d71a:e817]) by PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::d6a7:781c:d71a:e817%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 13:43:34 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-07-08
Thread-Topic: DPDK Release Status Meeting 2025-07-08
Thread-Index: AdvwDkV/3Cx+AQoZQGuVyRyEdN3uKA==
Date: Tue, 8 Jul 2025 13:43:34 +0000
Message-ID: <PH3PPF37F43E35D0BA5C15815CB90A0E0EDFC4EA@PH3PPF37F43E35D.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF37F43E35D:EE_|CO1PR11MB4868:EE_
x-ms-office365-filtering-correlation-id: 03bc785a-82c5-468b-a151-08ddbe256efe
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?w5sWdQJVoh0uAMz0oHCtdTquyVlDJj5iDfnXiMfjGd5fQvdHuvf+5lgo3ucf?=
 =?us-ascii?Q?U+g41pkLZTuXtsR8N7Tx5JQUINLqsO1Jy8WMT26vz1EAssIqGi9fofCdSbUe?=
 =?us-ascii?Q?O1Wgt1/qBLnjtXSA5zyOK3KslLr6jXk3fLC0lAIvtltv+SZrUaX7fx5acRC4?=
 =?us-ascii?Q?z5oSEozbRu5yO0p9RBXdEmqJ20RT+n8RVYhSiWLA3wKcApfP62kyiG4S+RWW?=
 =?us-ascii?Q?LAuVEikwr+TrKPGvvW01sFI81b2D/O5ci1oyGY3YsFxosZiNzEZGgI6zWaAx?=
 =?us-ascii?Q?j9WO5fY8MkaB6Zu5T3uvQ1/X6AvuUhHBclcAwL11jFsxVr6RgLZl6bL5yB9/?=
 =?us-ascii?Q?Kp8crd+cDmyEM3p7bnaD96ex8XIUi6nmufZ+/lpUQayAxxu5PZiF3YYmE5Ap?=
 =?us-ascii?Q?q92RBYhH4PUR5dk2lI1/isUYdYp4HyLieDRseY6Wp3AeUelN3GlCAHFJdXpy?=
 =?us-ascii?Q?rR/wPmSzPKcwU1ITt8KLoEJoGaiSMNJxvpnSb+WW1R4HTFWx0fi4ff/aEEXK?=
 =?us-ascii?Q?VEDxiNh+zhtZl2nQ1+SzC0dwCmIuFqsxaMeQ+6548fWIcKkIO+e/FY7zDHaa?=
 =?us-ascii?Q?AsJpzltQl62Ttmfb4XxJUfj2yVHmcP/g/gbXx1qzmBphJgTi5XKJqJ71i3uU?=
 =?us-ascii?Q?asRoIkp4cXBIM3G8CUSYXT7WlxPBqSAuJhg/JG5ZfoBGycsrtYSDgoTpx+Hi?=
 =?us-ascii?Q?5QL1POPd6BbRwGE9nuEXV9LIuCmJNssjKfOyJ9y2bH8Qy/+4suLfWodBi0XC?=
 =?us-ascii?Q?yQgAArtaLoWRq+a1e7uDGbGQfOz3s8RDkx4Dq1ib11qlOz6z4mITQ4h0EKVb?=
 =?us-ascii?Q?J2ZixV6MZZYI9Q7zRQB/hev9qoH567suz/GaXzC7qUxRJ9qqWGYidc4InK+s?=
 =?us-ascii?Q?cX9/743ZEUrdWj/ruZtJwn6UhIf2zxUatBa3UH1PHypZOIV63Wh3+DbROZaL?=
 =?us-ascii?Q?1nfzmUN2+BkKGcGEXCBTHtGNLXAWWesyZqIAsONYthv/+498UptgshiDi22z?=
 =?us-ascii?Q?BDY+FMEZlBXTv7bJf68kFU+yLbACkjR7w81T+kQC6RnkNdUuGx9u4Z1k340n?=
 =?us-ascii?Q?KZtfHPRhx31nZw2woXaosR9xhJxmPksZQxhWdTpb+02TWrPZMeZVk0NlGGwU?=
 =?us-ascii?Q?JHLeTnaZcYuXQSTrL2uHRkZSsPpwJJ98YgzRy0Qc9arFEQfztsondvIoF56m?=
 =?us-ascii?Q?VfG/Q5voMszGJapP19l4rq2rAAED5YiH2KafQhKwsQ9HUjZ5Qiw+AxMCusLF?=
 =?us-ascii?Q?tjRV5bAuOjYpDtivTKpikkx4rfwDV0zBI6QDMog5opgLwoSjqfRkMK8K2C6c?=
 =?us-ascii?Q?i+/kHv/vA9i78FtVglRAggJAOPUb9MMgTPj+eKQLTLYpuy1fXFNWMaX7fsiB?=
 =?us-ascii?Q?xRMzg8HZib4tMJEzCxfgTSNewq3uJwZMRRy54UrUOpGYc0/oIfMHa9KjHkQj?=
 =?us-ascii?Q?77UM2VfGbnHqrn5N15Uq+wnQG0e0opMc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF37F43E35D.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e1QC4GYRtlAXn1hTv+dMcgylBXeHi4PjxbL72Xti2Jv+CLGON0ZRJzZAGOVf?=
 =?us-ascii?Q?QwQ+x9EzK6YPW8Tl/Ig1ogdpIXN53iRNTELdwv+iNXeAPsOyPvri9fELS3Sn?=
 =?us-ascii?Q?kZ8J+i75D9dA/HyPq7R/qgiait/hcOnuoD5IqPCrZTjZvnykH3OQ1uMKj5Yc?=
 =?us-ascii?Q?XMyA/IEetHduCEs6FIGwpfUno6VURdd+TGT59MNm381+y8AASPR3JzIT8gCL?=
 =?us-ascii?Q?2HcTh2PqeOemYR5peFh+OgHtRJR3LXC+ssafrNn0Ni+RUuRklBYBZUaX54nz?=
 =?us-ascii?Q?+vSx5ywcGz4l3erHILmURn/a/QsHjydY4hH2l7Kxubii1new7GxFfDpcG0qt?=
 =?us-ascii?Q?CNbG9dpaa+zs6t32CNv1D3Ta7CQPRSz9t8GHciNRfU3rP2+vkQJO0QP/5kME?=
 =?us-ascii?Q?FpetjXHxE5+4FoJOJq8oIZGHyCailWr+xCzTug24J1aUZ/io+wkdPhpuDpfa?=
 =?us-ascii?Q?O/Ipxvy0PZkdnErf1l0+XL0I63v2E9wq0Go8vcNYOD5i/rLypLzapfcQWJNV?=
 =?us-ascii?Q?GWaDLHzQzqCvg8SFT+2yJg0mZydL/8lZWshrzZCew0P0cTXdCDfWpimulXE9?=
 =?us-ascii?Q?JvoCKQtmF7NasMGv3RIrGLRwlpbR6P5wGJKgPToAYAPZlP7+dLMKheYSq3qo?=
 =?us-ascii?Q?IMbw8oWVGOinJ4iAEUWz1y5XGbSm3KsL5wW2dZbuvABYf9bKBVYZ+PLAe2dW?=
 =?us-ascii?Q?uaOM5Jnuw1VbMex4tcX00++tTwd/pAkqIO1+qybeQOxIk67l12KeZLY+iif0?=
 =?us-ascii?Q?EKHcGGluKVaGbiQ+EofykNHdb3K3IaddSYT3X4nd1+n/rEw21Ee9/UbXWxln?=
 =?us-ascii?Q?kwlL6H1QZMxDppR33q+tApHkz4RN4Eqb5xtnVr9XI9XzBFCqOt8PQapwBxxW?=
 =?us-ascii?Q?YcZtee8tJH4zaNJhGWqcI9AaVsTs5EFew/40pIUvqX6Na5J/YQjZ6Z4hjxXp?=
 =?us-ascii?Q?IqgrtUGlsIfSG0AFK3mFaQ9TMZk1Lzik+Zhog5EwB+wRLPu15V3xqkrMeRYm?=
 =?us-ascii?Q?8wLI7mvlzVZ/RMAhklEy32gHE05sEB+9ELnHBVIaQLgUVfLikYL0M9E29tpn?=
 =?us-ascii?Q?UAqdVrUpze4uq3DWJZrr2HjCtl2AJgytaX7fVcp7xINBlERfn+3Mgoln+86/?=
 =?us-ascii?Q?UA/1ERN5ORXPvecRKp52CotzO4jJukC8jC80jVqDPqcA39RAJ1RxaddI4mGX?=
 =?us-ascii?Q?no/1JnZSQ0g6MOkH9TBRbeYlheQmHrc02rpimHz8mR6Wq+dQRXsZo2q9CXFh?=
 =?us-ascii?Q?4YVT88Kr9D3ihsdPZDBjchZFcYvmfiSBRcjlcr7ejIR4UtMGDVWyKo485T/R?=
 =?us-ascii?Q?R+lG/el/LQ9Hqsh4SSNKx+BiA0mLJA+AlUUpYSMap96eqk+D5qScUzLqLQ/T?=
 =?us-ascii?Q?i0dmI2dR/+8F8vGOOA48bygCXBaSJtNNqJJC69lZVjPEujYfiY1MzP4hMEJq?=
 =?us-ascii?Q?m+ph5g252s53ibNiVFZCjpcyIBQDzkriiB9jpgrcAQPXs/Lnfk2mQdn/K2G3?=
 =?us-ascii?Q?5FeA/oP1quqTWZDZxkWWBjCGaVeyGghtbbJDGAcaADFmNj/PUfKIbgHrIxj/?=
 =?us-ascii?Q?LTGsiWh9gSWNE/DXi1EEwjL3W2PmOr/jx6WzWZCE?=
Content-Type: multipart/alternative;
 boundary="_000_PH3PPF37F43E35D0BA5C15815CB90A0E0EDFC4EAPH3PPF37F43E35D_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF37F43E35D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bc785a-82c5-468b-a151-08ddbe256efe
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 13:43:34.1571 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +QxwtK+fqxCVWk6bKBnTWwhJusjHuLaND1e2HeUezOjpQH7caNdGBKZXyVoyeHGuNc9YWilxt9SoW1CXg9BQFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4868
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

--_000_PH3PPF37F43E35D0BA5C15815CB90A0E0EDFC4EAPH3PPF37F43E35D_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-07-08
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Agenda:
* Release Dates
* Subtrees
* Roadmaps
* LTS
* Defects
* Opens

Participants:
* ARM
* Intel
* Marvell
* Nvidia
* Red Hat


Release Dates
-------------

The following are the proposed working dates for 25.07:

- Proposal deadline (RFC/v1 patches): 20 April 2025
- API freeze (-rc1): 4 June 2025
- PMD features freeze (-rc2): June 29
- Builtin applications features freeze (-rc3): targeting 9-10 July 2025
- Release: 11 July 2025

See https://core.dpdk.org/roadmap/


Subtrees
--------

* next-net
  * Merged for RC3.

* next-net-intel
  * Ready for RC3 and pulled.

* next-net-broadcom
  * No updates this week.

* next-net-mlx
  * Some fixes pending for RC3.

* next-net-mvl
  * No updates this week.

* next-eventdev
  * No updates this week.

* next-baseband
  * No updates this week.

* next-virtio
  * There is a performance regression from RC2.
    It is under discussion and may need a revert.

* next-crypto
  * 3 patches pending for RC3.

* next-dts
  * Ready for RC3.

* main
  * Patch for UBSan fixes still under review.
    May need to go to the next release.
  * Looking at example dir patches for RC3.
  * RC3 targeting 9-10 July 2025


  * DPDK Bay Area Summit - Santa Clara, CA
    https://www.dpdk.org/event/dpdk-bay-area-summit-santa-clara-ca-septembe=
r-17-18-2025/


Other
-----
  - None.

LTS
---

Released LTS versions:

* 24.11.2
* 23.11.4
* 22.11.8


See https://core.dpdk.org/roadmap/#dates

* 20.11.10 - Will only be updated with CVE and critical fixes.
* 19.11.14 - Will only be updated with CVE and critical fixes.


* Distros
  * Debian 12 contains DPDK v22.11
  * Ubuntu 25.04 contains DPDK v24.11
  * Ubuntu 24.04 LTS contains DPDK v23.11
  * RHEL 8/9 contains DPDK 23.11

Defects
-------

* Bugzilla links, 'Bugs',  added for hosted projects
  * https://www.dpdk.org/hosted-projects/



DPDK Release Status Meetings
----------------------------

The DPDK Release Status Meeting is intended for DPDK Committers to discuss =
the
status of the master tree and sub-trees, and for project managers to track
progress or milestone dates.

The meeting occurs on every Tuesday at 14:30 DST over Jitsi on https://meet=
.jit.si/DPDK

You don't need an invite to join the meeting but if you want a calendar rem=
inder just
send an email to "John McNamara <john.mcnamara@intel.com>" for the invite.


--_000_PH3PPF37F43E35D0BA5C15815CB90A0E0EDFC4EAPH3PPF37F43E35D_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Consolas;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IE" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release status =
meeting minutes 2025-07-08<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Agenda:<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Release Dates=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Subtrees<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Roadmaps<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* LTS<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Defects<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Opens<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Participants:<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* ARM<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Intel<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Marvell<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Nvidia<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Red Hat<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release Dates<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------------<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The following a=
re the proposed working dates for 25.07:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Proposal dead=
line (RFC/v1 patches): 20 April 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- API freeze (-=
rc1): 4 June 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- PMD features =
freeze (-rc2): June 29<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Builtin appli=
cations features freeze (-rc3): targeting 9-10 July 2025<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Release: 11 J=
uly 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">See https://cor=
e.dpdk.org/roadmap/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Subtrees<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">--------<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Merged=
 for RC3.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Ready =
for RC3 and pulled.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-broa=
dcom<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mlx<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some f=
ixes pending for RC3.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * There =
is a performance regression from RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; It is under discussion and may need a revert.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 3 patc=
hes pending for RC3.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Ready =
for RC3.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Patch =
for UBSan fixes still under review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; May need to go to the next release.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;* L=
ooking at example dir patches for RC3.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RC3 ta=
rgeting 9-10 July 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * DPDK B=
ay Area Summit &#8211; Santa Clara, CA<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; https://www.dpdk.org/event/dpdk-bay-area-summit-santa-clara-ca-septembe=
r-17-18-2025/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Other<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-----<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - None.<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">LTS<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Released LTS ve=
rsions:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 24.11.2<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 23.11.4<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 22.11.8<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">See https://cor=
e.dpdk.org/roadmap/#dates<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 20.11.10 - Wi=
ll only be updated with CVE and critical fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 19.11.14 - Wi=
ll only be updated with CVE and critical fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Distros<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Debian=
 12 contains DPDK v22.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Ubuntu=
 25.04 contains DPDK v24.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Ubuntu=
 24.04 LTS contains DPDK v23.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RHEL 8=
/9 contains DPDK 23.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Defects<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Bugzilla link=
s, 'Bugs',&nbsp; added for hosted projects<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * https:=
//www.dpdk.org/hosted-projects/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">DPDK Release St=
atus Meetings<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---------------=
-------------<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The DPDK Releas=
e Status Meeting is intended for DPDK Committers to discuss the<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">status of the m=
aster tree and sub-trees, and for project managers to track<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">progress or mil=
estone dates.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The meeting occ=
urs on every Tuesday at 14:30 DST over Jitsi on https://meet.jit.si/DPDK<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">You don't need =
an invite to join the meeting but if you want a calendar reminder just<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">send an email t=
o &quot;John McNamara &lt;john.mcnamara@intel.com&gt;&quot; for the invite.=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
</div>
</body>
</html>

--_000_PH3PPF37F43E35D0BA5C15815CB90A0E0EDFC4EAPH3PPF37F43E35D_--
