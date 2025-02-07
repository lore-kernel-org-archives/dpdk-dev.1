Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E86DC0219C
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 17:37:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40C0142EB1;
	Fri,  7 Feb 2025 18:37:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id CB36C42E9C
 for <dev@dpdk.org>; Fri,  7 Feb 2025 18:37:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738949849; x=1770485849;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=coDVKCIbWFYzef8vu1dmGgJOpWkTk84NRONyIiGgy7E=;
 b=QXR1g8YyfYg20WQF9lzdaKdBzm7h7+MD1Jv8256p0U9LHPAYXJxhFtC4
 pRRefouA/SXX8sVAdSqjqh7kqpx6GAoJlqEVQcQkOhIKNqOZ4kj8mdTp5
 dogS2avmuE/SJb7e1W4zqXCZx1KUPMCOKLBscZbtFpOH+MKfyE7SDVk5h
 hNC9e2zIhGsWKKiBcGdbnUxvps9iXLtfnPfFynQeFk1IB+QrTRcP9k3Ql
 1r4Xt5Hy9QHp1ADSJFTV6IuocTE6x06lqBRo3TR6VhqASbnAlhVTKH/s/
 mlP2uBc/Kuo21mMglem7HJxLn31AZaLHwBzOLkA4Ivtb9NkVl89bJqRTA w==;
X-CSE-ConnectionGUID: BFYpf5ORRhmA9NEVQ2L7uw==
X-CSE-MsgGUID: 6EXbef/6Qh2TKRxe0aHfFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39752678"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="39752678"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 09:37:27 -0800
X-CSE-ConnectionGUID: JrcnkVXPRnylhs1H/0Kqjw==
X-CSE-MsgGUID: ZmikimhvTjeK+yHqCZzn+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116193191"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Feb 2025 09:37:27 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 09:37:26 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 09:37:26 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 09:37:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cc1cv1qEZWRSpDz1PVwU92sztIeby2fqIW5aMGxYoRRutk2ySTdqGZpZH/mSmZvjj1ZY7kWEWDzPVaJ3UXhkNei7s9V1LA2iWCqww8HXrZvoITWG0vuwvzj8pNHOdIyY2mpmwV9APRuNB6uwQHR8URXt+tr+1ECRuN2sBLOWEULsYhcvAOaDqCYdRpiZVVKVxXuM/pk0asrN5Z64Hj4zPst2LReB8f2ByqOegnQqWWwirzaZ0P8qA8FgRBWirmJ/gbf2nEhQ5gPJVg33GkwQ1AGB6ciloOkFNZWB+i4bl2eqktDmSTHXk6ZWMcCsOLSsEpcg+MKeI4U6Ywswn+1Gpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YG3RYMCyVOYr001fW//iq85ppOPc/8yTVUIAQNaZke8=;
 b=CkEUa8iwnKAS0Hc7MM8Qwt/cDVOwImS5TExYTZd9WKXyV15HRmDrZt5bZHSFuIv0Dpgl0KIzxZpO++sNLUxbtKVWZca6pL6lr3qzaOrk2Wu6zUw0zfK6jrIrxZdupDHq62u6BAQG3vEh7bkwkXGoC2e0G0NXwHh392vkEjL5tW7aVi74gzsx55dd9iDmEa4nBoAwU2nfKpFYrPilo/LqDn/mfui/81Nh+j93+V0Wf3F/WEqv458xZOuzbifiQrlaKRA1wPpVw848Ju+7l9pNd7+yHv2+h7xq5oO6e4LXPbOgCd85LzJMDhCZ7xXEdKQhzZYoCFCDxaBp19utKePW/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by IA0PR11MB7212.namprd11.prod.outlook.com (2603:10b6:208:43e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 7 Feb
 2025 17:37:20 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b%7]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 17:37:19 +0000
From: "Kusztal, ArkadiuszX" <arkadiuszx.kusztal@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "ferruh.yigit@amd.com"
 <ferruh.yigit@amd.com>, "Ji, Kai" <kai.ji@intel.com>, "Dooley, Brian"
 <brian.dooley@intel.com>
Subject: RE: [PATCH v4] net: add thread-safe crc api
Thread-Topic: [PATCH v4] net: add thread-safe crc api
Thread-Index: AQHbeSremKWHkU12xEiD9M6gOu2xHrM8FKgAgAAF2AA=
Date: Fri, 7 Feb 2025 17:37:19 +0000
Message-ID: <PH0PR11MB5013C5B4CCD8AC10040F44EF9FF12@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20250206203844.3874038-1-arkadiuszx.kusztal@intel.com>
 <20250207063758.3971992-1-arkadiuszx.kusztal@intel.com>
 <20250207091242.07656c4c@hermes.local>
In-Reply-To: <20250207091242.07656c4c@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|IA0PR11MB7212:EE_
x-ms-office365-filtering-correlation-id: 88953c96-1628-4616-bdfd-08dd479e1289
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?FwPiYaoeCkKwdnZuX2Kp7n35romfCRITa0qbX42rwfJXioIgFoxeTNqyA9em?=
 =?us-ascii?Q?2HFlljx1rQqhngSyOt6+PMogKuhTB2tlH++bVOpLYSFSgds7LYujx0A+6Z02?=
 =?us-ascii?Q?8SW9wmxBPAOl4EH7t5bGIzKHZLc7fQ58QuQ2IV/f3T5A8a1Yqtv+4t5xTdYQ?=
 =?us-ascii?Q?gE2u4njbwzzYv4o7ehPYYsC0NUi81OJNloLmM8g4kdULVaorMNEMdWa+8P92?=
 =?us-ascii?Q?+vl3A+/OVbRl22OT/EcbRoN2Gzz1JTul11rCV9uGCOrFDwpcCn5Jh2ikhStb?=
 =?us-ascii?Q?5n5ZjTlIpfSeSe6dxbt3A0+UjYDO2jDiktKyNyKdTKWQxz42YuwuWjaZLlcD?=
 =?us-ascii?Q?9oKgYhUoElI3bLx7aFE+BUPlfVEgeA6ZLArrUYVIIsZ4D9NbueHkR0pqHYiW?=
 =?us-ascii?Q?6nQekkKNRwDahGGVypu8c+FvBCn86rZnhP0cyPz0eVXtzlGGgmLad6YQXn4R?=
 =?us-ascii?Q?JVAI96ZpYCT3hTHufujhch/c1z3iBSYigBr6r5wNXbEx+okU7jLvO/AU6bb5?=
 =?us-ascii?Q?Sx/+4ZgEJf7WCIYYLn3teomEbNDKIPFqwRp2xUoyGrkAdjAHWDTUGDImspyO?=
 =?us-ascii?Q?YjZ81WTjPaCOXhIiNcrNcOdpfw9jPbDuZ5XKelut79mnqI+DCbYhksd9+iCx?=
 =?us-ascii?Q?zyUmL20BZxBrY6xp5WN4b8AHK6xAhcYwdDdyyOF54eYp09LAS2Kgc/CGEf/C?=
 =?us-ascii?Q?/3iZqHieBTU4p/Z4c8lSMk+ZI93qhre64zl+Q2ZTI7WufEMrXPkl25jETrk0?=
 =?us-ascii?Q?Y53Mc6ojZg6I7/ntD/FyyWOs5Ygu9TLI2F5DUOjToUoE3zAE3U2vM7LA2u6F?=
 =?us-ascii?Q?iGWssW1kmb1qzTCG8nL8KUaUqMs5g26x6DnxQm8zcjKJ4siEI5OPRaC+n3C5?=
 =?us-ascii?Q?h03szEnG2ybhA/EbA2Sd7LOvgB+DkBNJTcX119jRKYQj1XmduT+EJmImzTqx?=
 =?us-ascii?Q?0MSpvIkoMYg7xbZ11VfrXkuGZcwtvHj3hNYU5KyLCQAi9/0JSwoJlCy8u2JH?=
 =?us-ascii?Q?ZId+HDJQoPHlEHZ8ZAD/D/w/yzQGwVNXWF95+hX7M4vXjVBImZZw3+djtWbi?=
 =?us-ascii?Q?qV78vbDPKS34aDmK1MmWc1jZ4Ftb/YYIJzXOjCk212WjeBetz5A55HMsS/I8?=
 =?us-ascii?Q?FJ3J3vhOHfmJGANJeGaO5M+tYTjPsPHn2aq+9zMEQhdb2xoAJKpCI/G2OX1B?=
 =?us-ascii?Q?9ZKco+QN2E8tX3HM5bMJOriHBQtUDLTeggb2Q3HmFsFDePTrmj50jfQ4xWG9?=
 =?us-ascii?Q?kyWF8MZpEvHe37l5Pl0hc0hOk6aVb4EtC1R23ourKYyEX/pL8Jc2om2BaAbY?=
 =?us-ascii?Q?wOhbTWy21OwuMlqDbXqYpxlt7gAZkgTBpSUO4ZDgjQ0WO8FnOT0V5Rl5bMiU?=
 =?us-ascii?Q?a/w5fiKHEr/7XeWzDB+JEGc+uOPXfyV/HKAL0cYUKr+vunw7136JYNx6gDwL?=
 =?us-ascii?Q?bl4Q0i4b7FNGq4/UlD2jJBRUTxZzl1jJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5013.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UH8waAqC9IYVx9np5ajHiV6U7U2mwPZdIcFi+ozgHPojPWYA1eb4jlDE3xtq?=
 =?us-ascii?Q?3zcCOKo1TirW75lQcJvQP6+1HbjdDhsqjTPNwFQbs17UKBX/ivXBkBT4QVNf?=
 =?us-ascii?Q?feIVRm1GR+DnGlUYnHKq+VU9881/qCH/uvPHLGhXx9Qz0aGBso/g9/U2mXEq?=
 =?us-ascii?Q?b8H8eOYC7HTTzHBxBV2naBhMFE6arEBETRYi7eKFOcoyLMtEYRYAVev24D3M?=
 =?us-ascii?Q?rbSnMy7tm2G4DSk096o3lKZOTUQiQO+dGWqAc4UQfFhbRkomuMsEniA3Qd4x?=
 =?us-ascii?Q?NgjDQVDdwNprCGiSvx/Yb/NbziozaLt3+25rDIIhpKeuzltt+yTU6VyVM+FQ?=
 =?us-ascii?Q?gqoG/vB4QfWAW29yTrgEnFzygjLnnMBqrIPLUyyWRt4lshQPzGN9qEpRDZd6?=
 =?us-ascii?Q?Z5oRlBovaM0hWIWaL/5ob4EPppf5XQdgPTELdAYoJNSND0M7jNLgYCK5GPBM?=
 =?us-ascii?Q?bUF1spvUUBRt12jvMnA6EuhVWRF7+durGJ5fH6vbdK3p0nCx2PcowICO09Ff?=
 =?us-ascii?Q?nPLs0jAJoI0nZy7qbwoiXoWJl/6pZDy5JmtHflz9pvs0x2ilBJjCemsSVHK2?=
 =?us-ascii?Q?Q8a5hDO42Q2nRYss7we+H+ngPuD2i1t5WvuTTlFPhDwXD4Acd7ygouWvKSHM?=
 =?us-ascii?Q?9O+pMk/fdQQLanaUqHZWmMN+CnEVlU+VMATP3mCaam/pm+97NBQ1bKZwVmtL?=
 =?us-ascii?Q?0YuGc8ftmEFyE0kfKVkOnBjdKpFkmzRnGWY9m6e83SoYUe1OEbBii2jSR1OG?=
 =?us-ascii?Q?8lyCVE/JCqmIUheZIq17wmxnDpKh/SRusLcpjPQXGyvmfctJsXhYIytJUdjx?=
 =?us-ascii?Q?OwshnzVM5dnb1EuuYJGEO5UJTSvj/tcWdaERuLhDfRjYKReabOl0aamDiCU6?=
 =?us-ascii?Q?VNezbS4/PgtJ5UKDlZo4meGGiRHDK4OcXu3tomTHCPkoRlI2TwpuIEvOlTsy?=
 =?us-ascii?Q?VEKyqBIdb+DPbrgub0xT7uvSiPiVoLWLloCEbx1v5IZAPiXDvG3k+LGaZozq?=
 =?us-ascii?Q?U8Zt3ANAYOfiEht+W+O0ln+W0yY7jczOdoYH6GcdnLEncXkSiPMWKVyY+/Z+?=
 =?us-ascii?Q?1ixPYfGnK+fJllQNR8Jp/d0wSXS46jrMNz7miWpPnbfBhs4e9gDvVgS4kX9b?=
 =?us-ascii?Q?zYr6QNAW10XUFQEV/6IRh2LvUo1ZbKxsy2htEjocoQo6hV+9XACnzWiPR3/u?=
 =?us-ascii?Q?xblpW3Qf6Hnm0786R1AwGCYxkVaf7cTdrnPOAsXvi7EeJ/H14/+zYpSdZKgT?=
 =?us-ascii?Q?8A/Tzzgfl00PExFObvqAc8w30CKfrpUFX+UnyqwXZTuzDPkS3D4pWLr9VQuG?=
 =?us-ascii?Q?axmCRYWh0xzQVcr+PaSL6bytN+EnrvMSv62IqDAOr5Nxk77ijEb2UUeyVwK2?=
 =?us-ascii?Q?nlCMpANBvIdkHVhjKQB5i7e5qVri9/j6R2y2EodG2iz+GpZ18nc5CGhM3Lw5?=
 =?us-ascii?Q?fZbCI2NZoR9EOLsnHWPbbLfzXKLJY30tGbmU4ktehK/CqNNVcrV0JTlaft/w?=
 =?us-ascii?Q?e5Et2CRH8N8jcGQa7+48NNGYpyZdkGf333QGXtkCtYtjqeu+CpooxAtn2R6+?=
 =?us-ascii?Q?cUECTDuQjAbf1c58UnTp0Q6Ke3WPCqGL9z5IW/KndQ+Zv3HMBduo2h3JKtOE?=
 =?us-ascii?Q?Fw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88953c96-1628-4616-bdfd-08dd479e1289
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 17:37:19.7607 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7KMY8hRDQD36fWtbJiivGFFG8EiIpcQDGfufZ24m8oqreAVkS0TYuOvb+idX5Z/OgLdnwwjx5L2c7LpfoxV6WWKB14acV/PCFhQ6LEh9Vb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7212
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Friday, February 7, 2025 6:13 PM
> To: Kusztal, ArkadiuszX <arkadiuszx.kusztal@intel.com>
> Cc: dev@dpdk.org; ferruh.yigit@amd.com; Ji, Kai <kai.ji@intel.com>; Doole=
y,
> Brian <brian.dooley@intel.com>
> Subject: Re: [PATCH v4] net: add thread-safe crc api
>=20
> On Fri,  7 Feb 2025 06:37:58 +0000
> Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com> wrote:
>=20
> > +* net: A thread/process-safe API was introduced. Old and new APIs shar=
e the
> same
> > +  function names, but the old one is versioned. Replaced functions are=
:
> > +  ``rte_net_crc_calc`` and ``rte_net_crc_set_alg``. The new one is
> ``rte_net_crc_free``
>=20
> The first sentence should be more specific, and avoid passive voice.
> Follow the style of other release notes in other releases.
> Also, should indicate that versioning is short term (until 25.11).
>=20
> Something like:
>=20
> * **Changed the API for CRC calculation to be thread safe.**

But this was added under the `API changes` which states "* sample: Add a sh=
ort 1-2 sentence description of the API change".
This header is from the `New Features`, so should I add it to the `New Feat=
ures` then?
Otherwise I agree.

>=20
>   An opaque context argument was introduced to the net CRC API containing
>   the algorithim type and length. This argument is added to
>   to ``rte_net_crc_calc``, ``rte_net_crc_set_alg`` and freed with
> ``rte_net_crc_free``.
>   These functions are versioned to retain binary compatiabilty until the =
next LTS
> release.
