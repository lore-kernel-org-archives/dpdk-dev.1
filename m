Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FCD1061B2C
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 01:50:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A443640285;
	Tue, 31 Mar 2026 03:50:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 4EB4E4025E;
 Tue, 31 Mar 2026 03:50:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774921801; x=1806457801;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=g1shPsOy/ijOC7xGIh80fj0dUp756F4GvzKpSqi/oco=;
 b=f0th5vT1F27nhGqyxFcsrsp6zvbCClUouU3VSqh+7CFBDqJEtBD9hrA1
 y5NMPaJPL37PP5ljd1zvzmONyi/n7iPnkx3/ng28U8vkazKskfG1KxpCK
 WVUaYp8eFAbs6PcEb4Sg8uUTlPZkIlZBnvZ6Vdrp+kAp0qU2Nl2Sg3Hy9
 tPZlG/lHcniMCx8MJHxRswbOjFCLzPLJF9OUmVIQ6z6zQorGaKZcYktlG
 Pcpyux/OIvBC6riIN6zZM78b6+2Mt5xjzuG/PgyUCohx9lEcbT6YXl9Z3
 yoEMxFdFKSturh5TrSF0D8D2zeXTTTqTHQA0DWhZGZwTql964Nxs2IELO Q==;
X-CSE-ConnectionGUID: eRfp6cLNSliPQXFPjrzZjw==
X-CSE-MsgGUID: SeV+xtZ7SyKQ68IgE4Dafg==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="93307151"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="93307151"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 18:49:57 -0700
X-CSE-ConnectionGUID: qXhBCnxLQpK3Gxa2NVuKOw==
X-CSE-MsgGUID: T39WZRq2TZu6SyQ2xhBL0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="222916934"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 18:48:25 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 18:48:24 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 18:48:24 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.8) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 18:48:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhlUDMhzLmaTCufRqSxGRsbNVx0KhNT8Ny7ik1yBeLEOSkr1FX7EqizO53kyf/U+Ta2hFThLq6I4uZs1GGGtyByXdspGIgvtMjEO3LtZjPYj7XiL7j3iH1V7bufO35Zg+pNrGzYiSX/HJIxk9NRcfXI371klzDj0zJDWgqp3/9OSPfJJyU87ISwO/PxseB3vcHGse2OvQRbf8/4j7zjaEga+KTdsDKpKOI14ntLYDU0hXV8KnRuYsmF3pmj17AIkl+wpjl81fDlzbxlCf4LY1/nPd4cXfFEvR8uEAXxlTUKDiTz5CI6tNZZvL+grAqYa/0fn/SE3Edx9el98ba1VoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1shPsOy/ijOC7xGIh80fj0dUp756F4GvzKpSqi/oco=;
 b=RVoihH6cNHN8+YGFpVPjsqPZHACxCHqlyAYlbG6AaArzZqEUSwYxAXs2NWPnZ2UTZcCpAFXhSJFNcjJ7jUvxgXwsYLdVSQNjTA79SH/lxljwATCWr5MyAkJCI/mk7/8cOBpMUXtQxPB379tD2WlBuYqy1QZfJ1tSFciBBZJ/Et4eqHaBo7UPWpL5x1iWHXYojsh1jc/7p0gFADu/twcAEUt1hTkM8QW81UxsPqcDKsKCJ7aKV3Nzzhg2Sc6yPc2GoagS11lDEABdFQPM5Ah2iaivizuMRZ7SykpAZlrCfGJr6KMMrUwScBhiaILw5UD1J6KodR8BX27qDgczlV+Uiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB8336.namprd11.prod.outlook.com (2603:10b6:208:490::22)
 by PH7PR11MB5944.namprd11.prod.outlook.com (2603:10b6:510:124::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.12; Tue, 31 Mar
 2026 01:48:21 +0000
Received: from IA0PR11MB8336.namprd11.prod.outlook.com
 ([fe80::7cba:57f1:37d7:723c]) by IA0PR11MB8336.namprd11.prod.outlook.com
 ([fe80::7cba:57f1:37d7:723c%4]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 01:48:21 +0000
From: "Jiang, YuX" <yux.jiang@intel.com>
To: "Ji, Kai" <kai.ji@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "gakhil@marvell.com" <gakhil@marvell.com>, "chiluka@marvell.com"
 <chiluka@marvell.com>, "Ji, Kai" <kai.ji@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [dpdk-dev v1] crypto/qat: fix EC session segfault on missing
 pkey/pub key
Thread-Topic: [dpdk-dev v1] crypto/qat: fix EC session segfault on missing
 pkey/pub key
Thread-Index: AQHcvG8zoyYQlXiLF0G0Wlsc2kZkqbXH54nQ
Date: Tue, 31 Mar 2026 01:48:21 +0000
Message-ID: <IA0PR11MB8336FDEBA3C5E8381F816B3CFE53A@IA0PR11MB8336.namprd11.prod.outlook.com>
References: <20260325155040.2922854-1-kai.ji@intel.com>
In-Reply-To: <20260325155040.2922854-1-kai.ji@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB8336:EE_|PH7PR11MB5944:EE_
x-ms-office365-filtering-correlation-id: f33ff0ab-df2c-4998-6da8-08de8ec796d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 2rwidpSukaCCDrsfjmv82QtDKPZjwqY2OwW52bn46ANb1fV4w1aDjBZj8EMyn3hcsxidOM2F4eon0ZhJrcv3ZDu2bwgGK2DDXk+LLVFrnFSLdQPlS0jmilLOlD7Up96RgozKG+kQEKD4+QTOhQUFzmUP0VQi1/iNjgDxjFeMST/+SFo1VE18x+VpyI0sM9nK8578ck1oJrhXNCZeTQkdDnaU5JQsfVJQHAbdRqMmXTcDkc4gt7Tp2KNfc+gtsS3pKbCxIbUqJMPZIPwepYSAhK16Runzqn0a19Gvk4BAmQpLJ7jRRdzvIequYya7eAl3ooZH2nllR6cZwjbK7/CFaf1UZIrpRjJw3X9aBn3UbLb6Dy1XjOtbWcl7FqL+TSZzPYcyS0HZf6Sgl1cpOgTiDOCZLono5d2zw9rVie3iQwDQy/jgR8wEFBzONOrcPQQJhoRHRO2TsEVIyMSLcAuNxMolFIJbE6u78DoGHYTt6HrePBEJfM4LU2ZukzXrgaj7WjD9Gd1NMCQgedghk1C4hkPvzWCRwxgPQzfCdGDvoafOy6z6OO7ZUMPhwhI2urxKs4Ox88ZfAIKZBeKOz7V2ji9q+sqmOoTthxR4RlHl7k4+/x7yd6ePKruTV+f5DnzaiCSZohFvaNHB0Z0bJtT12EkS8KTzEySJwx2+Ug4xM+Q+ls9utKCOwb+mPwrDGil9a8WDrhc5ue2mCNXaXWh830YvnzK9MOw/4Vt7971T+BLFjY4bW1eX/++panmichno/mxuAiB6iIaAYOuK5RF4NZ5Ezxm+Y2ZRo0qJIZPwGHQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB8336.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7LUo197aTNIujB70j3A8NyeaA7tYtr8f8L7CUELporeYPA+ZPaemLUm12M+v?=
 =?us-ascii?Q?o4GEHozxArx8mwviH9itDyncIy9jQ79q8bxe2xTCaC4A/X4sjqddczULQlAf?=
 =?us-ascii?Q?b1RPeNrAuD9SC1V/v45vmA6muXl9QoO6vHRGwTe1rlUEtTEHp0htOHei18SP?=
 =?us-ascii?Q?JljKMFbTh84VmnMaGrZgy+BdR7rk+PTol6hHXLDDiv1OjKMEh1mZk3okMGOj?=
 =?us-ascii?Q?u3q4oqpXU4Uza17R3jlRjKEe6I6DWUJt8dSVglENKcFAHqLQqzjA/rrU0lz7?=
 =?us-ascii?Q?is3yIo8AyZyoEgH27Dgptk/elJJ1Dafw0UHQK6Y7YS4ggLjHDQpkDqORQ27P?=
 =?us-ascii?Q?yPFwEYrnWPKw1cgn1A7H1KAJMQI4JsKed/iHQ/gqHBt9X9Te3MhxnXSira+M?=
 =?us-ascii?Q?rf3L17Eluvp0pzkx4n65pTNXaaF/EC5Xk61cdE7re9vlxsmyi4Y+txBpDl7T?=
 =?us-ascii?Q?9Ww1aX8VlKRfqQCoD4DmuxplA0ILJWj/TIUX3ImApquqBNBwAT9095ArCU7y?=
 =?us-ascii?Q?3QwfPii9ohlcMUHTREO2B+gnYGr6msbSkPk6EKL2UXBW7yx3v3BiUkDAtcGF?=
 =?us-ascii?Q?rYN8TrdFH9AGs2iG8f2KjLgAveHall8w052nv3QUM1mHcxmIvsGV8wjc+RP4?=
 =?us-ascii?Q?5qE+h8n5QbAXolhd+nxlbtbFD/BophfYpQmqH+mOMWLJy3pn1UsNKti8l8WQ?=
 =?us-ascii?Q?+POR8gU30Ed9LLC2Va9a1tRh5DMloxCe0Z6b+3i+4PI8hOWLqHBBgxm2/xv7?=
 =?us-ascii?Q?AE9qINQmVZRaBjh52HCmZkenGWPYwi5T/mYyLnFVydjCWTNQTToJ1/X/5qc5?=
 =?us-ascii?Q?9IU8fhjLG0E/sIXP5mM5QcifuYRYUWF2MyHBDeyqFYO7rdDqRJKXeaYxAtOe?=
 =?us-ascii?Q?boNqLlSgJo4N/15wyX+juul62mbz2Xud4NBwYidZ2DJHeU516qioF9kIuhOP?=
 =?us-ascii?Q?vdzkKJEgHSJfDG44uqGYm7Ro1VPiob4d8+AxBxkk6TfU+qUAO23vYisZJXVN?=
 =?us-ascii?Q?T4s3Rkv1OJyw4rsMekAs00f32aIBd9a4wyLtxzSk+OJdxG9rxGW/DaqXxbr4?=
 =?us-ascii?Q?vGTYTyVGgdTsqX8c8Qlos+7pmhTAz0qnAP3Ri48/SUAhJY1PNNQKL+dTcnkN?=
 =?us-ascii?Q?f3kAn7B9uC3Skusnw7yEBeddgafHpEoiwgjL0xbnjNLaa8VBSuwiFW8uEPU6?=
 =?us-ascii?Q?/AlvTIC1uXfNKI4NMwqNl/eUPtCOQfXKwOJh3m8OviP5cE2qEdw+lW9KR+AY?=
 =?us-ascii?Q?GtXBrQRCCZLOLftpABmeNMv8SEopwyE37Ll04fW+PzKZZGEFg/LPLnue+Tq6?=
 =?us-ascii?Q?bVJD3T6yjS0jCdQxvYGYyuNt2qqtFQpB3jRVAam0yRyKkl6e5T0Md3ibOW6e?=
 =?us-ascii?Q?iFXU0fITs82krHc0aWtxTiofGUrcqTIbaArDxkbA41OqUgS3kxIqxLK1Q2yH?=
 =?us-ascii?Q?fBM2X/BPmSnqoXIxYQ1QvZ7fAHQf33gBHyFcG4muSeHYKdOz+Eh1wAFkozDG?=
 =?us-ascii?Q?i4K2oPSMomVdbLMlZDrPe8uH1heAFVoY/7fSEJL1t3snR/qY0SVUlWNuzbvM?=
 =?us-ascii?Q?OWuAimtNvNPntxEdscirVpCcNm4ZEZxOiy+WpACm+hNF33uWu+GDARCSh85/?=
 =?us-ascii?Q?qH4omn1zPirLsMy3d2lXlD1O2VJg6I4s64Y9t7wDEWxMV3eEpOaywKTrPg4K?=
 =?us-ascii?Q?lLapzeqFz0eS1x8XXmQr2OfQ4DvRjxwOMy8awS9Q11rByboB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mI8NxgYzjcBuhbr0U6mS2QMHf2f3LAd1GX4RBkw4k5k8bxK9g6TTrwvdjMmkgDZgsAhQu3SZNJJNBWNCCWpG3q5uWpycBGdqou0mmTuuShhY1xkbU2wgb1wwmC3ixla7wUP8PRqGNvUq4+lYJ6uUG5N7D2k8EJTv6n1uaENI842utLhi9gXuLa94IK9TRKWzVBaee/DfgVUmh24+O71XB3lbUsrJDgyGqQc3KxpHdUzYTf9R9OfaU297DQqCCSW36p/X0ZOvCZ/Am4DmI7v83nqsp4PEglVmU5NjZAXPYrrJrx9Ylw+ZcGzZzJOTEqXL7LK5IzFvEiLZVkxQT5GzWQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8336.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33ff0ab-df2c-4998-6da8-08de8ec796d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 01:48:21.3100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QKMzjvSVKwUxav9SsaGWfzef6w8BsMAB7pXDqoKs4NEqwXwC5BVFs6M0/HYfOVdq+8A3IlJXitmz/zyoNnqTzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5944
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

Tested-by: Yu Jiang <yux.jiang@intel.com>

Best Regards
Yu Jiang

> -----Original Message-----
> From: Kai Ji <kai.ji@intel.com>
> Sent: Wednesday, March 25, 2026 11:51 PM
> To: dev@dpdk.org
> Cc: gakhil@marvell.com; chiluka@marvell.com; Ji, Kai <kai.ji@intel.com>;
> stable@dpdk.org
> Subject: [dpdk-dev v1] crypto/qat: fix EC session segfault on missing pke=
y/pub key
>=20
> session_set_ec() checked qat_session->xform.ec.pkey.length for the NULL-
> allocation guards, but that field is zero (from the preceding memset) at =
that point, so
> the guards never fired.
> When test_ecpm() created a session the xform had no pkey or public-key fi=
elds set
> (ECPM only needs curve_id), so the unchecked memcpy calls received a NULL
> destination and a garbage-length source, causing a segfault.
>=20
> Fix session_set_ec() to check xform->ec.*.length, the caller- supplied va=
lue, before
> allocating and copying each optional field (pkey, q.x, q.y), skipping the=
 allocation
> entirely when the length is zero.
>=20
> Fix test_ecpm() to zero-initialise the xform with memset so that uninitia=
lised pkey/q
> fields are never passed to the driver.
>=20
> Also add a QAT_LOG(ERR) in pick_curve() default case so that unsupported =
curve
> IDs are surfaced immediately rather than producing the misleading 'Unsupp=
orted
> xform type' message from qat_asym_session_configure().
>=20
> Fixes: 064ef1b098d1 (\"test/crypto: remove PMD-specific asym test suites\=
")
>=20
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Kai Ji <kai.ji@intel.com>
> ---
