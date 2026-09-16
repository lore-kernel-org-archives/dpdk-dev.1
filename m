Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83CDC88E77
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 08:57:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F309A410FD;
	Wed, 16 Sep 2026 10:57:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id A7D474029B
 for <dev@dpdk.org>; Wed, 16 Sep 2026 10:57:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789549047; x=1821085047;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EvVGiMI0/451Q7kVWcSMQ82lwFdk0KNcaJndeSOv32c=;
 b=QGWt9sA1iswxSSHJg/LpVnz+wTWn/A3//z2/yGQ5DHck8ncwzICHO1LN
 tWfgHULLeZyNYqxb7T13oJL8uN4rqnI9BZzklMundp8CtPCjLlBVJa6cc
 JiYIT5Cgwf6jpoZ5IwsWvOkNiguqTfbDWkNjVzIASw4dRhl3r5VhayKVf
 qGRU+VlTZ5CpiiC7vJWFiISEcftx+7ErOJ2BprSnhkML/lDBcZdz/Tuqs
 9wd0K7TrTzwOtLAnDwBx3D1jCW4L5NgAp+Fd+OFDDKW50WLVL4uyOj5EU
 G0KLpe9o7j4iC75H0x/1LWx0CfYaQQdg80AznMsCXE/B2U4oD5jZsRYZL Q==;
X-CSE-ConnectionGUID: iN2M7W2jSOyrdYMOt0QY2A==
X-CSE-MsgGUID: BANVzljaRjO5eAwRJXjucQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89937692"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89937692"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 01:57:25 -0700
X-CSE-ConnectionGUID: QPDbHywnTl2/6q4yElo4+w==
X-CSE-MsgGUID: VLiHvmaGRqixmjfaaiRM/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="272806426"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 01:57:25 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 01:57:24 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 01:57:24 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.34) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 01:57:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+Iyw8gFuYVwPJd2OKUagKrLRzJLzZF7jybEbHnUhXeVVRFab4QHN3tDj0g5T6E5/wFJ7VNIvy91XN6xEjmBbkNe3SQ4EXqRyQtUcCsGiRquRgg4rJnm7NGsEAvBLGWwLvqclO0BvE+bToAs5QVgbBI7exAjYp+a1vT7SMenQUogtrLAD4oCDOa9e+M6Kp77JsD8bCZ7GLR2DpkLkYDpg9X740GyStvkNPh33QvnFUmqSfr9M58wdabr1p0Uai4CdND2kCbj2LHfqBRLfRU9juIF7bOazFwI32VCvvuPUM74uTrbpdFGrJUrHRGTTeCIjOLU3RA/Lkw1U6HFOYzf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVeT7AGXvVxHqdYcSc7yb2G+M1YUqxBfXzszSNxR97I=;
 b=BZM8/E3xTSPBLowGpy32F5A1OHXFOiASf2i88tNeWrhgsn4qya/w7nlNxMfikbBp4aDz+KHRGXsVwxwagxbQgt97dWHbnFa8fkoTQ6qWxZHCXaffmmGd34fccuQbEvhPJCphCfGeCm7ksYfoUuNqAfy+qbF//uwvMMq+PZB5bOMGpIAAQX2q33ZB88fdzMKzyLaUGWKU7plCY0jLELyGHbQfGx1m1bC8WiCPIXwsf9PxZKfUf5P2Yi1YSJQtTl0oHYTCC9sLhbhbfNgOh+JBLJ0NoqmpJzxk8nkNsgBlePCED3sKANncfux4hWVVRJhQVLBKSQMrUy3zpItQFstAFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by DS4PPF399DBF572.namprd11.prod.outlook.com (2603:10b6:f:fc02::1e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 08:57:22 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 08:57:21 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH v2 08/15] net/intel: allow building without IOVA in mbuf
Thread-Topic: [PATCH v2 08/15] net/intel: allow building without IOVA in mbuf
Thread-Index: AQHdRReE0X7YFe3po0iiZ8+6k/KAi7bQ6G3g
Date: Wed, 16 Sep 2026 08:57:21 +0000
Message-ID: <IA4PR11MB9278AA277DD8C60A333E74238EB92@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260915133654.278780-1-bruce.richardson@intel.com>
 <20260915133654.278780-9-bruce.richardson@intel.com>
In-Reply-To: <20260915133654.278780-9-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|DS4PPF399DBF572:EE_
x-ms-office365-filtering-correlation-id: 741081ac-4035-4a95-58eb-08df13d0853b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|38070700021|10067099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: p4Yv3buwohE88WhUiogTfgRbuKV2G4RFMvVvCtzYx/11VBuYtPMc0CxDRpuHPBVuHShCTTvp5p9uNPbgnE6aI3pVp6B1qKHSyk6mPJx+usF/R6S7RSdH3F4VWv4LkcpK9D+/3b5DvcyFmvgdMwqJGyMYi5a6ymi6wKhwGlapTCTQEgWEHKE9rgXRbI6tQH0Tg7KtXG2lNQyZHt4aKJglETz7RA9NTwMmdZOq0Jq+PXMDC25NiZTle0k6qZIFE8c3XdoYg/fcFj7jjNQkQ8rFLguqXygIRLGF5wzyBwPgrzT2WGKd2JTyHjW3jiEZEOYr7cl26dah5InnXNxW3J5mHpofqJMAAAlD8/WZjoZIUCB0N0tOvSJdQm6qLNaW33VLZQgEnTZkdodENWkJKatZvAZwiv0g6nBc2piZpKV9vLsjV1AuTjSpdnYGH8U7XHwWOv9KgILQQ9l9POcdVNuric97OcoDLamQeGVz9GTF1X7i4++U+LPYvCxfpMql0QjYs28XhCaXp7/D4TuTFpBGshFJhYmSduYWa9CAmpw2smFvp0EiJt5AXEo2DHpla9pgPWewrSR/f0qYhDHGfej6+inowTWEAaN+sqjE8X3L9O8yE29wt4N77fUq0RLzs9y2Z+y9u3qyqsPOFgdoW1AwVzcRDiCbpFGAycLRYJOhs22qetCETooeEkvp24GuWS1As44qOQy21cuXp0spqElPOw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(38070700021)(10067099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hJJwEmepSKFmRGa+L4zAHWukGbT7NC21CCypbefLiRTZqxRtFENd+bMNQtKV?=
 =?us-ascii?Q?4RlfQSPw60dOurIJuuxSFOO/WOw5wQeQtrEUWSSZBVI7fLPGBo11SO5jBSNA?=
 =?us-ascii?Q?V3VKELNiHBT4uPF9QgsI7GPLX4Cz/G5Gf6PA5DEzObyVg+sZe3axAehAmm/V?=
 =?us-ascii?Q?rokcyrDX5m885REaYwg/LcOtuFJ0ckdLRA2mQ6eiGxDSdnkbQ3V/XkibGx3a?=
 =?us-ascii?Q?DKddw3DgbbhjBgDnVS6QnJth0H5HY2N/fDl/AIRASEbVkw2K/ZurZX49gePS?=
 =?us-ascii?Q?RGDR7JzLf8UitqQwzTUwS87yWLmXUA4dyaypcuBg7dZTrF9SdjfxDL5AVvxv?=
 =?us-ascii?Q?6gUcpk/MV7wXXOpe/ft4ysaZrGYmfz0Fs5g7NT5nodwMUpqNnEuTXsSDDRVx?=
 =?us-ascii?Q?bZGobojnZR+dM0C5u/MZQRLQsWqn73e8TjIQUDkA+T6Jh0CHHhHoZrV4NmuP?=
 =?us-ascii?Q?HxTKGIMiJb68LlgShIGV3q/NosqQgva6PlJHEDG0/wXGn2ZoHhDXt6jVNrP/?=
 =?us-ascii?Q?uv+UNa61Qtf3SKBSJZvd1QMhNzJeeY93w15DSlHe7uxRWTIDr7I4gazQHKzJ?=
 =?us-ascii?Q?I+eQyAffBpnvGQv4QwOpSBHjDhWo+Ss/hchtbqR3p+fMcmDqkQo8c8Dvqrj/?=
 =?us-ascii?Q?k5MD7JBeS4N836+RoWDG8W5iFQRJ6mbo/6Al+9rj/XnHU8yTwqJL8qvoM41r?=
 =?us-ascii?Q?c1yQ9Pi8eq1kUlSWbnH8DZvh8q2WLiTf3s5PQIOo8V/uk9JCIB+tZqU/iwi4?=
 =?us-ascii?Q?2DeRH0d1nKQSKCkLbaS4fmnaf0Oo9PepENx1S5LONJHZiBCzWfWoUyGwKHUw?=
 =?us-ascii?Q?afCBY85BuaWUuvZX/T7fhW3huuHvpC57TjaEsEVg8zVR81slbs0TkwjBkqYY?=
 =?us-ascii?Q?tn+VdfjB+efTuJcW8K9HeVE46deXAULWoednX6wiWN0WOuxpLAIpcV5z/PZp?=
 =?us-ascii?Q?pbmAOi8oFeHR32RD+5TWp0FSDWnuNZnDeRkLHm6Tzz4ltMxqy3qjKydCUBQ5?=
 =?us-ascii?Q?AV/+pY8HuVjlrtF0orjScOh59JxOfNUr6zAwG63UJdYyau4U9Rt9D387hd2p?=
 =?us-ascii?Q?qdu34isOYJyS1Dd+ui0jKewNXq547qkHuFjJ2eZm1cxIhrBv9j9NoShwY1BI?=
 =?us-ascii?Q?1KDuKnPqIVkgo/gBLxUqG4cjFV7FUo8KlmQa5Ff8+0ysXvnIzlSBiKLDMH8t?=
 =?us-ascii?Q?sxIHiQnl9QLu9BoM0LfqqRxNGR5GKJFUOtSeoHspSpFvHjdbQZ4kw0DHNy71?=
 =?us-ascii?Q?IHfANw7yX5iDT1DYJ5GYpNHSBLlDe5m2acWsPayl8YncQ9cwEaBkfSh0dngW?=
 =?us-ascii?Q?BGhiZMHuyeKRmkwk48X6z1WxAlx8A7qJKA/h0PRkvZubIILyb4GezqNqVdZn?=
 =?us-ascii?Q?CsRJQT1f4iVFFmfb621yN4Ba/1AQpJAusEVeRpxCIanCiSwKZUfc9iL0fPkI?=
 =?us-ascii?Q?h6mMxSleWUyW76QUsYD99dMTUvJuBcvKf78SlE9umDBkYxoEX/siy2VTExeQ?=
 =?us-ascii?Q?SqkCD8MzBGHSdHX/efgXEtYXJ8XISIn03z+1sQEoeZGx68/6EPlTeliQ0CMt?=
 =?us-ascii?Q?ZJcYkggASVk+nkLvsqWvBWTW3s8GNlJ6CvT205fsHNzrgnEWw++VbVftX37F?=
 =?us-ascii?Q?2BrWxxjc7HxGMs+FepOANtQkxri7axqtlhZ4qd9vfFtOatFohXWSPV0Hjs3p?=
 =?us-ascii?Q?16RRQqvYcXZCAU9DbRztrVnU8bGRKNeeUSsSR2DO0ClXtKrs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MSVR2ijXM1NKU5Z4Q9pQj5BzjuR/jcPz9DKs7XxkTt7ETCstpSxKvk1WaqEYi6db/JotZks3NTFLLm1JJbk89751HrjUER0Id5Bmjy5kNpaJWWPcwGkvcFgq101qbOr5jYMUTmzOiYl07LV71NwmL3CIlMRLy2u+CNmQw5s7uBw3GJ0cErVmqLCNLg+4tBrN+xweflzS6w2Fpg1Xg72uqWQ6GVaiESmHMida9Q2LisgJ525AfYhVHnZrceWleLd0cWGBymHh3DK2UGIFSqqjfDyGdPrAb+awMPZqV1aabeAJzWMUlfjLmN6ErWu4cuZkwQ2uOeJVcqHKNErppThT0w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741081ac-4035-4a95-58eb-08df13d0853b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 08:57:21.9034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sDNToLwbtF0ytGz0+33nx6MK8RebRbZYTdOM+FbyvgQ1rgtosk3KYgvf6KwdPOppTTdeuseZO7QSstGP69tqlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF399DBF572
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

> Subject: [PATCH v2 08/15] net/intel: allow building without IOVA in mbuf
>=20
> Ensure correct macros are used to build the vector Tx code without the
> IOVA stored explicitly in the mbuf. This allows the iavf driver to build
> when the config setting for IOVA in mbuf is disabled.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/common/tx_vec_x86.h | 30 +++++++++++++--------------
>  drivers/net/intel/iavf/meson.build    |  4 +---
>  2 files changed, 16 insertions(+), 18 deletions(-)
>=20

