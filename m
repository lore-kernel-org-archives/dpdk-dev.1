Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17CECDB47C
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 09:51:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52E9440150;
	Wed, 24 Jun 2026 11:51:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7DDCA400EF;
 Wed, 24 Jun 2026 11:51:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782294682; x=1813830682;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wVAJhO6FgTV1O1iM0FfFrlB16RUFFrerJ1i4FQAnnOA=;
 b=f3uFS7hLylcSJdnBixxg4u/1WlapRqJYJQ3cSIXXtW/IctNl7RgJqcG+
 xw9KzN7R09pmDCoMFYH9JQITGSlW28feAqPmZBnXbzzWlGyTLSsuTmbDF
 xZjzp7wFVytEyU0RSB1bzDrtAF+RtpASMJlJtBWV3sjOENxoxXh9rEYwL
 h/BUs76EyztAotFW/06HQW5YL9vfrEI5XAklKPzDuLo281PpabxhXMh31
 zOmfZVC5144r186NHsQEi5GTSBsSFJSDRw488ftXyR2tXWjfoNnwjCChM
 LH7YFtGkpHSv/K5tSSt56amk1JZt9/UZdoWOZp7Ypk+zup4V5DwODFc6A A==;
X-CSE-ConnectionGUID: +a/jLxXDQKK9aHoVlfYqMQ==
X-CSE-MsgGUID: UsycFU3ATcW/sgyo3lwu8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="94542648"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="94542648"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 02:51:19 -0700
X-CSE-ConnectionGUID: u8KM5PavQrycrcUEnIu9Fg==
X-CSE-MsgGUID: a/+bd6kgTLeIyvQzMcSvYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="243413521"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 02:51:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 02:51:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 24 Jun 2026 02:51:14 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 02:51:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7LNKnaFh+58aSk3Rr84LI6hv7Q/DRSbeloQ1Zio5qLOfAzwL+rMjw2cE7erkQ9Fr91HOatUCcqZFeRM0HPIdbi9O1CCDRrYBCROxmMYOB5nUpyuU4pAWC2QNODbp87VtU3e5a05wvyMRq08I3X0411M5JMp+QV6cT5x7FsBgWyNEaOGL80o9jL/TJ+ZcAp/odfGrxjUpclE5tC6egfuAJp7Whf8aVQbcdH/M0+G3C3VFO2ZGt9m8qyKAchohNXnRSgab7w23K0XJFFKRcxcqgcrdnjE1q0dpilPK0EY5KAKNabKfVJc+9+uHmppjsprZ/HtJ0qu2aHoftar/RAoFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnzpNNb6V6MhyGXsPwjmwYEn9l1sOzDbA/KUlJ+vs+U=;
 b=uAq2tZUNrxNiqKWwRrvBL08ofkEcBswysB+orOU6gqrTiFRU3rYaTkYg5GfFuPvf1MB7Wn34GJ2Zz2BSAUrp+7dQgDNL7dm8OKqI87dvgnDwDu+H7uTf/Zrc8hieOwRP8vsitmJxCJyfAcmckG1HBlGvWgORxY4I9YPzS+IjcgfQTITgXAijT2PXgcFc3qxGw1ZPO3gvY2wj7N0iuvYynS+fCH34ktWW9pxanE865HQRH3JYNzu/Jfg5W9gn7yZdxG51lynAQwBsLriJ2IZu2CBl6Sm53xecT8qiHiEhlfiLOWu63aqC+hrdU6lpNCT0F47OGvLi3ysa85ZmR+nf4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by SJ2PR11MB8514.namprd11.prod.outlook.com (2603:10b6:a03:56b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 09:51:12 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 09:51:12 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Shetty, Praveen" <praveen.shetty@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "Wani, Shaiq" <shaiq.wani@intel.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/intel: fix use of non-recommended string functions
Thread-Topic: [PATCH] net/intel: fix use of non-recommended string functions
Thread-Index: AQHdAwKiST1eyM6xSUmRQy5mzFNhPrZNd8iQ
Date: Wed, 24 Jun 2026 09:51:11 +0000
Message-ID: <IA4PR11MB92788919362D4E5CF700DACA8EED2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260623112221.677931-1-bruce.richardson@intel.com>
In-Reply-To: <20260623112221.677931-1-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|SJ2PR11MB8514:EE_
x-ms-office365-filtering-correlation-id: fe55a22e-11e3-4f1e-abda-08ded1d61fea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|11063799006|56012099006|22082099003|18002099003|6133799003|38070700021;
x-microsoft-antispam-message-info: qSJyJuSsNrAXKwQpcSJrEJbzQWu4bKoM5VmGKVNYBJBq3PsQ7ZcqD5QXQIf8YulX+4i/bCWkkmUnJr/qh9GXDJb1lYD07PfmQbAQiKn9X8JZEgjrMe2W87VIvmmx7esDjtovZIxOAFkJYJqFnKHGnUlwQgh3r9hKyNZ1m6wa+wCbg3lJfXqJHgjK/dtLvRJz7IPGWRVhHoETk7Q8ro+28uWYbT/cZX+66+N+bOomeKGygRxf0bMfHCR40R1CxCIuf7xZSRPqHnFB4pBIoAwQ7kJA9PpxCsjOLWHZq1U36wDNp8YykS+EJpPiwkqHagHEGM0+vd4bg1bAnlgnprvuQvP2cJLtp/zaQIrj6kghJ+oztG/KvTBa6gJc69yNnEcEprtT0XAoJSApuiIz6bSd/iPLL+mQ3jYkc6PJwC0mR6i1FgZVh/b6cWzCu07DozQ4pkK+JMceL4HaI1lAF+APBRLVdV0oMbSKGEW6QMkyoKah7Il8MS36dErHph80pEyF51r2c0QmDvw0NEJzZ6QKiuvALEcHMUM6cm8CrALMWiwSQzJuFXOIKw4oELT4OQprP9kMDOYP1vcYXM0FVv5pVzIz1IvJK4AnLQADIQzwW5mytPS/OJvKV+aX1jHhAjAyNCnv1CLgoKO9OWPfKv4YoCchccii1v+4ntWtk2L6weWv+ZFMZLaLHmlMpT+2f/kCHsBzt8h1jMVig1oQ+X5q4LGWOOh0+5qhNZ9Lw6miols=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Cs7r0ItIWRmXf0ZjdGt2hdNSwDZ4RJ3tLLECpNnfIwcWKd1RYCOZwukh9gYF?=
 =?us-ascii?Q?HB1cVSa11DLLk94fcnCFSqVt3bEUM4ANFdq2skTceYzFFHDRg2PzdyVudw72?=
 =?us-ascii?Q?9cJOHg1sPnxsOaARUb6Xc34w7X/NtottUv6WYTntW+qTa7iK5+mCqTvstQyD?=
 =?us-ascii?Q?lNuLUEj/HK/aPr0OwgIA7RqKJ2HqbhLidn7MFIP8/f9czI7vJZm+T8xCKtZ9?=
 =?us-ascii?Q?UpMEJx4rmHoUfcLomSb6TkuMQweh1DNP9QTFaSQF8OoHxe9aaSkDC4wN2xVL?=
 =?us-ascii?Q?nQ9VT7SUVg0kU8Ps2cQyP8UfhAnVGNDxjJNjIWO+wxIHnTRdD1VhJWwZwWRJ?=
 =?us-ascii?Q?mCORaKGHPSXPemYIJceaoNd/yWIPKBuKgwD7oKuyraO6fJD7rBd7xNYrZAaU?=
 =?us-ascii?Q?pPSiJ9KEhbqiB+2fLaA61VmggBFgPViLphjisYPWjX94CCfUoo5xN71NJB48?=
 =?us-ascii?Q?DUJt6mxgief2kjzbpT8D/AvY8iMgv+jDIPUSFX3Wsh9M4pI1PeJlKQ6Gfaje?=
 =?us-ascii?Q?mwd4Oi3UkiymYU9Ho3mpWFmJqWEDQp3e0aoULdQo5saGySSeS8Jrmhmw35A/?=
 =?us-ascii?Q?uPmQWLc4IuDuWtsdYgnbntHKfivy6zN4F3cYmb8cVHFXGiHQicMqGS13dLRz?=
 =?us-ascii?Q?j5sofyf3ZZbMWpUE86k93MpWsGpBunjwpz2eK3mtXkgsreTmmDA7OvYjjINZ?=
 =?us-ascii?Q?CPp2HlIgKpu/tB2jNIomzc/C9U8xfeTZLroyOFMm0jW/64jQyHTgieqr1dEa?=
 =?us-ascii?Q?gYPP9xLxiU/03h/10KdU0LuyZ0aJE3E8qPx15oRAA8ZfSavd0z6HshJnXGGo?=
 =?us-ascii?Q?twzh3zqVXfry6vX9lmrftfYwHz7Cqz2xFZl1v8GjOlPpvkG8fPSmxrmMndM0?=
 =?us-ascii?Q?TkotGHwPkbZq3qi0Dnk19T3E0cyBblwqirb1UWMjE6BauDuWgNvkw5eiAVwQ?=
 =?us-ascii?Q?Ik7/yoLvzGBeMHcPi9Yk7lPG47vz30cWUx3vF4R3M6luTQVAzHfzs85OTlSU?=
 =?us-ascii?Q?l0N3r2XcX1HSZ+4TzznX0bDgyGpZNjlC7S4WlgDSpuF9qxQifbDw9RH73akn?=
 =?us-ascii?Q?fv5d58kImKA8FpsBuX87zp9X6VodBD0eFenWASlUhGrtZSRf7xquyFtIrxOF?=
 =?us-ascii?Q?07zUsVTvTE59HM5sXg7+PnMz9a/OSVAgyVDlga1rm7N+HzAWGli30m8o8r+f?=
 =?us-ascii?Q?T00Em6JyJJg+6uFeU+xVkcwUzroJr8CDV1oVqPXaSM+b1pBE217AcNGrSn7l?=
 =?us-ascii?Q?0FdU8KLtWMdXaFbokPDKAjUsYnRv0JElJ1qULBNtP+6cOkcETwNmPC+rqB0R?=
 =?us-ascii?Q?LEhi8V8XWecO00XP+c1UeNyhx3Okh9TBrLWtk8P12aWUblobVGZ2d77bbWaJ?=
 =?us-ascii?Q?/BrlL1eqijlUser40InRB8MRtGixM7hr9Uo6MVbNAVF15otRedxeVqrwi5Dl?=
 =?us-ascii?Q?ItokJj1d2Z3C6mZgHL+cK9aD8BQukB1+xH9j8CPjFjn+Ti3MMtn1/iZ/rTrN?=
 =?us-ascii?Q?fKytP+Q8Md6Dre+PTBltOhdZDlG7ul++sRQnLJTIaAY6gsX2giIuV5h8gfG7?=
 =?us-ascii?Q?Gl4sFVjTYKkGYtfFphK+QU9aHFuTr2tB3SfC5EYBRo2LadpgCkBUgw4v0K8S?=
 =?us-ascii?Q?eyctJk9pK21b1YFPzHVyRVj6MNwRRwdwaclqb9Y1R7OoePVkUOSSSFbfcOu9?=
 =?us-ascii?Q?C5dLXGmaLEeIIbSafLy7Xk/XA9eSdefgDZ6IRRiBoQEChSFu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mO8Paza9WFAcoFTYe9WLxpLcup+JdT5GTNONYlJbdmrcJ1QtUikBIXjha9YAwGYIF5qM/UxZfvLqadQ81P4lsFr8JyWAFLSXVCG6EMzX9XDvLkzIP5x7cR+BAo2xy8SWbtsX6UR9IfNF1euw0PGaDixWgr4rs+4bz5JTsU98iNthSLJniQAR6YOtDhdLIsRn2/lXWkKNcIKBxYYlzcX5og3WBRdEzLCe+Vhu+B/aAWurr7184L6m3681QLbZ8eNNrIOZDpLStQsuFwIb+vCRlhPFtaYA3OaCRugxeM/AXgN22SI809cL6Q9q+Iz8bm6Due6asyyti8kd+1F2nqHlVQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe55a22e-11e3-4f1e-abda-08ded1d61fea
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 09:51:12.1699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L7OLUJfWG4ZKyydJXiMv4bYtGUryMr5PDlw6U0feuprbnIe1XooDQL8A9ZmK2zatp2VYkn9mmc9KST9g/OQZfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8514
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

> Subject: [PATCH] net/intel: fix use of non-recommended string functions
>=20
> Replace use of the strncpy and strcpy functions with the safer strlcpy
> alternative, which both bounds-checks and guarantees null termination.
> In the process also replace instances of strcat with strlcat where
> appropriate.
>=20
> Fixes: 2d823ecd671c ("net/cpfl: support device initialization")
> Fixes: c4c59ae62793 ("net/cpfl: refactor flow parser")
> Fixes: c10881d3ee74 ("net/cpfl: support flow prog action")
> Fixes: 9481b0902efe ("net/ice: send driver version to firmware")
> Fixes: 7f7cbf80bdb7 ("net/ice: factorize firmware loading")
> Fixes: 549343c25db8 ("net/idpf: support device initialization")
> Fixes: 484f8e407a94 ("net/igb: support xstats by ID")
> Fixes: fca82a8accf9 ("net/ixgbe: support xstats by ID")
> Fixes: e163c18a15b0 ("net/i40e: update ptype and pctype info")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/cpfl/cpfl_ethdev.c      |  2 +-
>  drivers/net/intel/cpfl/cpfl_flow_parser.c | 16 +++++++---------
>  drivers/net/intel/e1000/igb_ethdev.c      |  5 +++--
>  drivers/net/intel/i40e/i40e_ethdev.c      |  3 +--
>  drivers/net/intel/ice/ice_ethdev.c        | 16 +++++++---------
>  drivers/net/intel/idpf/idpf_ethdev.c      |  2 +-
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c    |  5 +++--
>  7 files changed, 23 insertions(+), 26 deletions(-)
>=20

