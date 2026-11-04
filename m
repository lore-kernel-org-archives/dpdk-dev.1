Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AE0606A328
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 09:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bCaExJEp
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10D694026E;
	Wed,  4 Nov 2026 10:41:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTPS id 3D0D540151
 for <dev@dpdk.org>; Wed,  4 Nov 2026 10:41:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793785295; x=1825321295;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=w9Y4mpKwYaJAJGsIu2AUCDmosA338c/4FUU+2fc5lRI=;
 b=bCaExJEpaYY5MJDoiW20+MPqHf3CZhgmWJuXbDhoC8wkDYAAfJrdNXSM
 cWwlR0lKeEJJpFdAasZjhpKS8EQBfw3hSOMCXhYJlodW+Ccp1ZsZ8IioV
 OJ0B13iYhdN7aAzBFkQwglylhhkZ5DyxMZekTwGaT6fUbCH0W1plV57AQ
 P4bmnoH4MZhCR1+n68P+rToi0jKXxvfUn2FOY1rvPcIshxnABfd0TaK+Q
 IPuc9S6iFvnIHcK83ha5N0wG/LI9J8vXh8O64aV4TqG5xWQWCxjI/bFMp
 bb9GMREQ8HxVDpc42WK+2Z7Xan3mGcHpOhwX3y5treD91bIu8Ycnv2+je A==;
X-CSE-ConnectionGUID: XCUq9MjCSFmjqySjenQmyA==
X-CSE-MsgGUID: Uvi3GAxkSUu/Wj+esMR4fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2432099"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; d="scan'208,217";a="2432099"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 01:41:33 -0800
X-CSE-ConnectionGUID: myt+5K7pR7OhuPpz00j6fQ==
X-CSE-MsgGUID: eT2ntHjzTaynmC1nubZrLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; d="scan'208,217";a="6577565"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 01:41:33 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 01:41:33 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 01:41:33 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.33) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 01:41:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDhuin98Rz6us19TXZH7oxLndvKBs9j6JqgFNvZ7scH/n+EN5RDfXK/d5LobHWxwPjZt9gcgDD+svkT9rHZMhQgTxZUGMDFQW8qUeXoUYm5/uMRzC3aE8lVug76/Q7Y/ygVKLqrikIaDaMe84ajsPYPG/Pkjp3Ba024NSCPjKrj648G+99LmTKiVHmcKKqBUsSnkXC2vlKtYmPHgH/adyih9ovzP0CIfhZznWRdK94MqCzp861VHFEcW//3eupsdmKua2+N2IWSb0Xm3TDvcfuBaDvRmOq9y+BD8ALwekNcYd5cP/eBOHwHjO2CGLar4Id3HHE7fhLQW63meDgLnBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VC8V4UaRiUWevoR8LgQUytHVytXR7DkQJE/ZB5YFIo=;
 b=G1q2lAXAMIdIscDs6BaYPH33QeD7DULXjBreMvj+YA8jLx5AzBn4rk5Tsy1GnT7RND9VD+Vw5AtcyuIFV0Eu37haXYiOlZNWaMjHhjLJLjUlbM3TOwG6iWTdruzWxfphOxtcAhcpNmxcCxuWWJ0eFc0Ym+NytwE8LfT9YPrdMx4CcyuQ+J5eIsYKsU4ZA6pzRZjdSCZbZYsrKoe8/pNCTuu+YI1pfeVdIvOEiy72njmTtnzMEh9O31iiMNSLKwyuxKrj8SsB7Y7QvO6YmUbU102C/hkdXLa+rojtueMzhEZHY5AunRs610rrGzBRYKFfeVVne0sD/Idh74bwV0OI7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS3PR11MB9646.namprd11.prod.outlook.com (2603:10b6:8:38f::18)
 by DS4PR11MB895587.namprd11.prod.outlook.com (2603:10b6:8:53d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 09:41:25 +0000
Received: from DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd]) by DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 09:41:25 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2026-11-03
Thread-Topic: DPDK Release Status Meeting 2026-11-03
Thread-Index: AQHdbEBVwtTCCOFZPEygbLR3/Z+A4w==
Date: Wed, 4 Nov 2026 09:41:25 +0000
Message-ID: <DS3PR11MB9646972DBCB11F6858A6B0DCFC682@DS3PR11MB9646.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR11MB9646:EE_|DS4PR11MB895587:EE_
x-ms-office365-filtering-correlation-id: a3b0ac1e-1f32-4a37-cdad-08df3a57cb4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|18002099003|8096899003|38070700021|56012099006|11063799006|261026140227099003|261028144727099003|261026121527099003|261022105027099003|261009223027099003;
x-microsoft-antispam-message-info: 9DGrdovGZtmTrm5iyveNEqBiuH9G7Tv4ZEdQIgjzD1lMXs4RydyK5wQvODh0VJeHKVVjpW/Sb9+EROXJ80uxMRXTYMFkixNpo6qskkEm3oHwnTtjlv1bO2xa2KO2Tcp2PIGtgYZUbsSajHJQPJSgh6WT8p1kfs1RjSzzOOKqnoXwPZ6uywt+VIJ8eVfn0XKa6AhvJCSM4hUIyNLQSto2RWs/NrvKNDsm48RyClh71SrES5W1BwVdN/grjuL1ZQPbpB8Uj9O4V43Ak3AoxFz1L6gIIji1SC3VN4uB5OinLo8LLl9crmUfw3ucr01HFx3wK97F3HMID4GixDC/Mc4BqwwePRYeQJRnuH2ZHEt9+NYaAtzvY0bjF5aLup4WXlRpYtmLt5PIBuz9ruq3O0fH8vW2cDUwnd83X9OTSIvFHEbBQwiw1cJUAjyjPMUG9CZpKPBIb6Flj9qxufTVTj3iqf/60c1hcVLOqzxDfIIL+gBcN54Eyr7TQ1/vLXMrpggOtgWqzJvRfWceHl+YYwu36+IbS3ohuvdBnV1Ma9e3Om5G1bhGQkWf5vQ8F8zIRuQop7VtLG6xhLo22tKMUwlR/Vvm2FJhdtZmeO6XE1dhnmPjhsKtE9vTE+UtHMBrrqdUQiNIcD7HvCPpi6w0mcOuE3vixRAs8YX5biWxCqWXuGA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR11MB9646.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(18002099003)(8096899003)(38070700021)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4HMiGzu+Ei8rLcV3v0Hl1HhpN3C+Db0VkRQuuc36QjrC8rQ4Uyn0N1d6jv?=
 =?iso-8859-1?Q?Y9sNJBP9D+pDIiDRZmL7G0WVOu9Mx2iEu4DZWUoWUqSnHG27rBCHB+Kiko?=
 =?iso-8859-1?Q?vJQz2aL2FbZ/5Z7bl8hlXVLZJlhOfPF5sKH5yRbDj/+dFs/qmoCZI7hoBd?=
 =?iso-8859-1?Q?cuFCNtipyRfgSNBlwvg1NvDiDamUajGj6qZCcDNBfpgsF53nVpaRXNHgbX?=
 =?iso-8859-1?Q?xrwq5rMJQTPrf+29AcdcSKI7YYpJN7Ve16ZYA4GXX2AD1baYKaQIXwMXmC?=
 =?iso-8859-1?Q?iXFsGaf2Tw6QKC8OwrOXU/hngafAvtaDWB9t+pGlLqFpD3aI9WyhBGBhkT?=
 =?iso-8859-1?Q?uJ3S/C/JSmEzEbvi18OvaIOc1pNUHTiKpFM+0A+lbTzjtsVR0tfhdF+Zwi?=
 =?iso-8859-1?Q?n+71sopRxectwAtRB6abuydZfIi+n/iwKVEYj28NhTMWQTUJ1GmP2s1xRt?=
 =?iso-8859-1?Q?enYXRQGn7woPpwV74luTNGCdtKFt+scmTvSiXOopxLipbtF0oe/Fv76lxF?=
 =?iso-8859-1?Q?BtTtWPHNCgZrO0SjH+P3Zt1LZRTZTa2IyddaebYbRXKxAuoNPJuMMnEi6r?=
 =?iso-8859-1?Q?1I6UBZivoiR2Nl4B96ecD4utXy/EfK4GM5m7+v2iXksC9NqaCFY9wvjnRD?=
 =?iso-8859-1?Q?O0F2B4Dpv7K+DZgaQ7b1yZwYqce818g2eX1ZfSBT3LK7ElWumPaqXn7Nsk?=
 =?iso-8859-1?Q?gWNuSpdPiPvNdCbBYm0CUElDco/roxHeEqP2eLqTtn0kwo/vdFc+KsKbv1?=
 =?iso-8859-1?Q?q840cbgqs/a5q0dDdVGqzbIKlUhSDxtoj1Vh9W2AzubQ9aD3fqUS/IlRWN?=
 =?iso-8859-1?Q?x80GMq/mSoeTT+mzo0L5gemMZh17BuuLkvQkUff44GuwGbyAEk8rCZOdmU?=
 =?iso-8859-1?Q?ii0VCS+vtbUM4O8M2ssZ6nX7B7n8/F6HhUkFx2uUxR5+7SCkMjDR1ewbzB?=
 =?iso-8859-1?Q?nPloY6dU43CmCg9yIqrPrriRZ7WvN7vpT6xJKoYmyHoj+vDyLpCg3a8Fyh?=
 =?iso-8859-1?Q?4hcaSZKl1rLdqLLacVjdF+aw4w5YFV/Ya/PwxDZjwGNELVzaEE375w6D3M?=
 =?iso-8859-1?Q?MSUUv2WBiPO1hiWdQXKbjSusmGgl0/pAs3HEoCPbiydpuGFWoeETbcoTRq?=
 =?iso-8859-1?Q?pG+iy0q5Rxn7aeSf9QaMenzMc1SZUEBCuCeWkT00Ygm8N/u0gHWInGfUvF?=
 =?iso-8859-1?Q?M5nDp21pJQHKdUG4NerYFYBb7QPlbCmiMlaV49M5dnSQlnbdA+FnbJnBwY?=
 =?iso-8859-1?Q?VBiMky5CQnEjMWEUkkPEdEQm1WYhCYSNUAIiBRi5Y7UoeNMpJG3adEOuij?=
 =?iso-8859-1?Q?TyEzsIbeHS2BKDEpKo6vTCHJd/qVKJEzZ/o9eXJFJFA2h8ayXlbZl/Cgk1?=
 =?iso-8859-1?Q?FDcHR1rdhtN3VGa9APnwJB2nc3xIt7tz1G0yPrrTMEgvyS2E2ti/8inRW3?=
 =?iso-8859-1?Q?VuMfxWSg3SggEVGqzzzAGx/ktMy41XtqQEDVN7k/eG2L+UmvIcrjnkaTNU?=
 =?iso-8859-1?Q?USA0md5xXyJvWdv6QulPQSNbgJ36jTWsE/Xf43xYrWeaL69SKXj5MXU+hk?=
 =?iso-8859-1?Q?Q3O9lYnGeZck3Gw7aawH2e5L9aBWpklXhUcoQ/cUYJuU/yWS+4of3H1VqU?=
 =?iso-8859-1?Q?B4UkvOnniTMQQxbuCnCWC33BT+9N3yCgs4pQPXoSHUU5Du44UexNNndUrL?=
 =?iso-8859-1?Q?NSWmokjwKOzjSvh8Vv6Ng9RfSXy/L98byf6Ic0I95Gt3D8Yj1MXnmhP/Lk?=
 =?iso-8859-1?Q?rQrOOgEJIH72DI4H+9IFSloebyLC+4oJRqedUlm/K3Yi632mV2nXZpIxD5?=
 =?iso-8859-1?Q?aXoAtKRHHg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS3PR11MB9646972DBCB11F6858A6B0DCFC682DS3PR11MB9646namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EXfpDggVTUPHn9nMtcAMrBu2ALkngzXJsz3IuUM7qgD22aTLJSXQYxV6D3s8fw10+ngIaBBBzvFczIQ1grLxD9Ogzq5IW0bSmjptzLhIGd/aFBQtPQXh5EOSvHmmkuPhCt10SJv8cRGh1EcJqoTzso4E4UvmLn7gOH017KE7KJVsPffZJ1laGFWgDegm900o4KDEuI8T9xVydJ2c2r5unNfkvMI8QPFwRSjs+Cyy3pJtklPL8kxWWd+WQvDeXL8vUuP/BmR6Fi8f3udnRrg860F4JMGC/nuABn258dBZyCF6A1tPx6NPWLqQd6j8dkBqRLMC3YiijcXn/GmPOeLHBA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR11MB9646.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b0ac1e-1f32-4a37-cdad-08df3a57cb4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 09:41:25.6534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uPDzRJbhX/dW3sxKnGKC9mzrBr05qJQTHzi6KZjbT0GFcGUOmSMTKOyFkyVAapwQOc0hkI3Ek6P25BhFYfEdUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB895587
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_DS3PR11MB9646972DBCB11F6858A6B0DCFC682DS3PR11MB9646namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2026-11-03
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

Release Dates
-------------

The following are the proposed working dates for 26.11:

| Date             | Milestone        | Description                     |
|------------------|------------------|---------------------------------|
| 31 August 2026   | RFC/v1 patches   | Proposal deadline               |
| 16 October 2026  | 26.11-rc1        | API freeze                      |
| 02 November 2026 | 26.11-rc2        | PMD features freeze             |
| 10 November 2026 | 26.11-rc3        | Builtin apps features freeze    |
| 18 November 2026 | 26.11-rc4        | Documentation ready             |
| 25 November 2026 | 26.11.0          | Release                         |

See https://core.dpdk.org/roadmap/


Subtrees
--------

- next-net
  - No update.

- next-net-intel
  - Merged for RC2.
  - 15 patches in review/waiting.

- next-net-mlx
  - Merged for RC2.
  - 10 patches in review/waiting.

- next-broadcom
  - Merged for RC2.
  - 5 patches in review.

- next-net-mvl
  - Merged for RC2.
  - 10 patches in review/waiting.

- next-eventdev
  - No update.

- next-virtio
  - Merged for RC2.

- next-crypto
  - IPSecMB patches to merge.

- next-dts
  - Patches merged to RC2.
  - Merging/reviewing other patches.

- main
  - RC2 released 2026-11-02.
  - Regression in libtap
  - Looking at warnings in interrupts.
  - Working on ethdev multi-queue checks.
  - New but late patch for 1.6Tbps support


Other
-----
  - None.

LTS
---

See also: https://core.dpdk.org/roadmap/#stable

LTS versions ongoing/released:

- 25.11.4 - Available.
- 24.11.8 - Available.
- 23.11.8 - Available.

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


--_000_DS3PR11MB9646972DBCB11F6858A6B0DCFC682DS3PR11MB9646namp_
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
Release status meeting minutes 2026-11-03</div>
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
- ARM</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Broadcom</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Debian</div>
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
The following are the proposed working dates for 26.11:</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| Date &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | Milestone &nbsp; &nbsp; =
&nbsp; &nbsp;| Description &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
|------------------|------------------|---------------------------------|</=
div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 31 August 2026 &nbsp; | RFC/v1 patches &nbsp; | Proposal deadline &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 16 October 2026 &nbsp;| 26.11-rc1 &nbsp; &nbsp; &nbsp; &nbsp;| API freeze=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p;|</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 02 November 2026 | 26.11-rc2 &nbsp; &nbsp; &nbsp; &nbsp;| PMD features fr=
eeze &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 10 November 2026 | 26.11-rc3 &nbsp; &nbsp; &nbsp; &nbsp;| Builtin apps fe=
atures freeze &nbsp; &nbsp;|</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 18 November 2026 | 26.11-rc4 &nbsp; &nbsp; &nbsp; &nbsp;| Documentation r=
eady &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 25 November 2026 | 26.11.0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| Release &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; |</div>
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
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-intel</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Merged for RC2.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 15 patches in review/waiting.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-mlx</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Merged for RC2.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 10 patches in review/waiting.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-broadcom</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Merged for RC2.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 5 patches in review.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-mvl</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Merged for RC2.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 10 patches in review/waiting.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-eventdev</div>
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
&nbsp; - Merged for RC2.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-crypto</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - IPSecMB patches to merge.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-dts</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Patches merged to RC2.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Merging/reviewing other patches.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- main</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - RC2 released 2026-11-02.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Regression in libtap</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Looking at warnings in interrupts.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Working on ethdev multi-queue checks.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - New but late patch for 1.6Tbps support</div>
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
- 25.11.4 - Available.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- 24.11.8 - Available.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- 23.11.8 - Available.</div>
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_DS3PR11MB9646972DBCB11F6858A6B0DCFC682DS3PR11MB9646namp_--
