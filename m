Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD43C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 14:12:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3277F402C6;
	Tue, 11 Feb 2025 15:12:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 559BC402C3
 for <dev@dpdk.org>; Tue, 11 Feb 2025 15:12:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739283160; x=1770819160;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VFNEZ6eAI9mMz5gdxOEqOAbxfW8pi2f/AL4YTYvZm6A=;
 b=ZkNnSjqNpoWx+zv8ZDkujEIhTSSq1FvGVXx4PpqxItWc1I0n4XBfo6vG
 i93661DLV6HgmTjbZtH6m7mJi6k4270CdZK5IA22MazTBvYhCoF99slaL
 0DPEvb44juKRI2u89mKfA+Okh+UBJnG1GbOVfl3eWp4D88ux9evRVGI8I
 pt4ZUkMJjc0absY8FzhsCZd/YPBm2ew17lobnAoMDdNWrsGpFnZI042Tm
 AElR6ktXaCz+WixKUP4h6WMo11N5HYmH7FBM+q6B3HOWEZkBumkaX8NoT
 Z4XvzYHrRMrxcpPsyHqk+HRDuADuwDDMrk1441Q0HVfjpWH8bf/mMk+Qb g==;
X-CSE-ConnectionGUID: Oc2ODgBdRMi/aqrhaWzlMw==
X-CSE-MsgGUID: CBvcNQJaTZW/nxAZoaxvXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="42740524"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; d="scan'208";a="42740524"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2025 06:12:39 -0800
X-CSE-ConnectionGUID: 2xKZgVnVSua0zZ/z2T/Xiw==
X-CSE-MsgGUID: 8uUfeGmERCi29j7MCWTxow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="149708555"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Feb 2025 06:12:38 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 06:12:37 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 06:12:37 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 06:12:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFu5lpL1oy6fQ1ws38cBVHHlITOfRbOVcYA2r9+WRkYaqBYB36woty53t6X/DNO/T87Bl/amZIwWTlE3PCqYkI1A82V6ucjV1rqiXFtI8NzGgyPAcUchUc7xFIW008vydMilvrwCbOAyaJIpFHkxLsc4LiVrGPRPxBUttTKDdqItry9AbR3rgznpQ8MzrjBOW5/XuDgHtAkdpMsa+uul2mjTTUzbN010GLI9vCZlWWxdxGcSuTP7zPrB14bAQ+D4/KAkJK9QomnNEki4JoGecbGyYVMsqHwxZz4ize9KEbAoLVD1ZQY9FxVKkFiuYEHW9zCmPSejWXxvDNDtvVpLaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiOqgE+3C6ajjj1xwNvuUZhSGhDRSDqi4IYlZkwYHtM=;
 b=ld844iNRsA86ez7CC3FvsCxXZb6zH3qjX1h+An1ub5/wf/wjQyYR8XZhV2+B1QL32ZPzpwJfSpKf0rwfCH5GakEGt2o5VmaTqTgOJk07nQbPtoPoeGBSIJYHsgRpxJqkKz9BvRUP7gZDABJT9zVFGvrepmjAWyzglicz+kUG3GbQpr1kj1kIFqg65v9G6uz3PGb82RGF7qRBmOYPCvYUO1yR6sfkNJd21u9ddV9dRuuKEB10xuLW47oIYE7iaauPa79XdS94eXAktAEK+JD5aNrEIzgUTVk5TxgeLqY4UcOsPDiCVQsX3MrvrKbl3cX7whX2fLEefzZZbqm/9qOFLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW6PR11MB8309.namprd11.prod.outlook.com (2603:10b6:303:24c::19)
 by DM6PR11MB4754.namprd11.prod.outlook.com (2603:10b6:5:2ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 11 Feb
 2025 14:12:32 +0000
Received: from MW6PR11MB8309.namprd11.prod.outlook.com
 ([fe80::ba43:b01f:aee0:10a8]) by MW6PR11MB8309.namprd11.prod.outlook.com
 ([fe80::ba43:b01f:aee0:10a8%4]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 14:12:32 +0000
From: "Stokes, Ian" <ian.stokes@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>
Subject: RE: [PATCH v5 3/4] drivers: move iavf common folder to iavf net
Thread-Topic: [PATCH v5 3/4] drivers: move iavf common folder to iavf net
Thread-Index: AQHbe9s4u53FLICcF0uiRW5f3IC+frNCJeww
Date: Tue, 11 Feb 2025 14:12:32 +0000
Message-ID: <MW6PR11MB8309FCC5041119B326B143C292FD2@MW6PR11MB8309.namprd11.prod.outlook.com>
References: <20250128163649.343336-1-bruce.richardson@intel.com>
 <20250210164427.1118265-1-bruce.richardson@intel.com>
 <20250210164427.1118265-4-bruce.richardson@intel.com>
In-Reply-To: <20250210164427.1118265-4-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR11MB8309:EE_|DM6PR11MB4754:EE_
x-ms-office365-filtering-correlation-id: b8172ebf-c69c-47a0-8531-08dd4aa6208d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?/nD5l1KQ7E1IANiIcPeDslejn4foe87X6xwDiy9JQnugGTQ1r4829agg1CM+?=
 =?us-ascii?Q?m8Et4ecRUGVWv49bTZCBqSUhvOztwUc6gXWxzuO3dFfUFmcgmK1MEG/LbWcK?=
 =?us-ascii?Q?1XZ0ZmmUS6RbwyskF8VxUI6qbO4yt3HTTeKJ96yKX/ke5W8P0ASW74JpNBXo?=
 =?us-ascii?Q?kixiqzXaTP61/G3NXZNQMBqkDiDNH0KSBgECirkbeuzaTA5tUjZWIvyZTwP3?=
 =?us-ascii?Q?/1owzbdhnCCERKdbLPBCuoEMP8qSxS40MQ6sDxYA5gAzmG3NCWguj49a1nfi?=
 =?us-ascii?Q?Seogpcp6w4g8rxSouHLKObyt0tPJ63uo9UGLfPRmMlasWHaMhm7JpVooCQ2Y?=
 =?us-ascii?Q?42NVqICJh9Co9kDYBW0T3P9MtAo1VccJR/n800hmnw4dKf9U98ZwXlwv3A3D?=
 =?us-ascii?Q?LadaMk9lFxAMOe4twHaOMcwAkEal/s/7rZfS4VBWVYd/+R/g6dKn1f7m8fGJ?=
 =?us-ascii?Q?JF8AUUrvPURa+lgC9QF8QaQt2iiN+LKbIYOwzDG9ZE/xONEtXVY+lFUPSR6h?=
 =?us-ascii?Q?uTjd4kJpw+/C6UF51oqYGWa0AN2NMCcZqnhwQxUU1jIb8qPfYe974Yqw/1Rc?=
 =?us-ascii?Q?2v3Pqq1nbIZtdmLJVJpnUWPpwa/YTrH0UJ2YhnVzpsBFydsMmUjunXWYuhx6?=
 =?us-ascii?Q?YT29e0BmTUX846R69vvY95bHrTttkNWp3WkfiEEMYSrkIJ39mIo2aKsPTFMD?=
 =?us-ascii?Q?HF6ZzJneX1YdPGZ6VbrO2NenZc9QQtdVYZyjMASb8UEmBJrtRZhSGioTfO4j?=
 =?us-ascii?Q?SGrxybc5yd4FE/65QmuAkh0x4JAYBeQWWp3ohb+prAlR2JQp8WCWBWMYeh5Z?=
 =?us-ascii?Q?1foQw5v5l46MJuO3zgoCX4MLWm7lAB3y1GZGgubbsc2EaFYo0Bt087jjQ/e0?=
 =?us-ascii?Q?70fQeMC6tfHd6u53cvKkgbqpr9tW3sQcyDqUGT0h4dxhOnGFXA0ShPpPZLXk?=
 =?us-ascii?Q?eRg5g4uQ6fFLNdGioadbTHu8oRCBngO+NhRVPtd3ZooXxTkW6YlO1mwXXyRO?=
 =?us-ascii?Q?44ZVh9Fjsqw8J132+LxSYm3tDnhQnv/263d7QrtH2NMS9YMN/8HE9ApM6/4p?=
 =?us-ascii?Q?tNuDtRw7BPUQRRmTO8bDAEBhj8ZEftidJpnJKBuliX6j8Lg4Xi5MposuqWmo?=
 =?us-ascii?Q?vY8hLTXBUncWwtYuzs8e6FRrEvdHN7RChvHbz1iwD+sPEwt/hhk7Cv19BIqT?=
 =?us-ascii?Q?1XPYKbrlZ0itH0kffKhUHMYT9SyRtO/gEjdr2xPlDocajXL0oBL5Xib1hxXE?=
 =?us-ascii?Q?xH0k1IBkSEFA8H6eDSYmBfj1fpBpkcVP2YSynLAwK+fZrs8MdTYmxyASk9KV?=
 =?us-ascii?Q?NJOlE00k0kHpCavdD7xkILGHRAh+Jt2cKmaCN+wAqiBVOzhvscEXPjOIb0to?=
 =?us-ascii?Q?6OTr+mjaC2TEGFgkD/qE1UwM44HcF+Ym2/2MXkUC1jURSC8cxEnyqlhUQieP?=
 =?us-ascii?Q?J6/P8U3QwBuX2kRLc8QOeebuuCjh8VVZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR11MB8309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ghttP4WbtXnJOhfW2+6ML/jivCU2HhHEz0lMqyeocMH/bRvPbtEgdr01GzOh?=
 =?us-ascii?Q?hQGUyo3qkemng1WTDoHFRrSe76JP6xCV0mAeqXGtnuzHhb3ogq3me7UvpiRM?=
 =?us-ascii?Q?5LZrNBxT5gnGMFt1pMi5GE7IihWp5gNW0D4Z2FZhytO/OqqOfks4LA/tVgBw?=
 =?us-ascii?Q?C0rCIXfVpU0YporthMVmjWST/A3qU7G7F99/oxIN1dNMeMzdTbHT4CAKQs8m?=
 =?us-ascii?Q?WwR+npQNkibkrCWvCJSQ8iOl/TzP+PiyXZZmBptG6xcF2F6N1WdEfHbQO/xv?=
 =?us-ascii?Q?b3++FgT599zVae224AQNbKCyMPX1Ba0bk1hQAzEfUQUB5q5HVsi5c8Jzpf6s?=
 =?us-ascii?Q?aozLC9bw+uT0KbMea0+0Br/mtKDpyyK4p0OBU6TbeX9/4BQahnGXWInzOm+R?=
 =?us-ascii?Q?yLdeoIpJYjDJKiILUkQaSBor63iI8W3OmbO4Tch/y1aeayR7puv4VyAjyL7a?=
 =?us-ascii?Q?MMtvUpMJnjv7Ko/SPDszlCXK+djj3/7INUdJ58QLThKx8f25r0AlNRE8aRg4?=
 =?us-ascii?Q?dtxC0u7CcMWU3l/VOzDOSJ1T6QNFZe75MR4OB+CLCmtnLVqylC7HvOfiE2JX?=
 =?us-ascii?Q?gkDGZ6ZWB0Qv4B2x2mGB8JgbHHh2pCrqm3ZvEzcbIBYBbecxoCJaH32t5Mg7?=
 =?us-ascii?Q?5uLUjNPQHigWw6/DBE7xDcVpwKC99uJzXTGPJNFUppO2kq2zGAOJUk4AnZIZ?=
 =?us-ascii?Q?uQaBzDpqGnpqu2xx5AN0Uipp9VryPUtrYZX4rZpKrI99NXt5Gz84Yw3nJV30?=
 =?us-ascii?Q?06AKH2lHM6IAJGKe6R9nQPkkIFmt/fx28e4IhbB4P2XnyQNsbVC49G8I9/Oj?=
 =?us-ascii?Q?MclgHCowHnJ/r/IvvjXJwVhaLq63Ap58Z205R259gPXmmrPAD4JddXCzQ21F?=
 =?us-ascii?Q?zVTS/45C+AZUM/Lxh/6u858LbQnvtWF0JSp4mBWOPgzvqCzkvjapqNh8WZn6?=
 =?us-ascii?Q?hL6G9BwWNKc32Nrjqv/8dZwcoc9QnESJ87HUhryihpnSHPBKdnUqPjIgCymH?=
 =?us-ascii?Q?ERaDvK14yuc3wv8RiwdMbs3f/AayUo28bsgXoFeN20YC0zmSZ1z/vhG2Pdsp?=
 =?us-ascii?Q?JUwJluYFx5cw5ILBidlW2fNCox+pUq8aDF9nP5tjGT7+0c5OhgLM/T0NlxLU?=
 =?us-ascii?Q?B8GYkKHvC6DcIDhsFToCtadUU7LSThQ0r+dmRMPAJ1A2eRRoOTS2mUPfiiQS?=
 =?us-ascii?Q?6SwcRD837uHmQFgIZ1omduLYUwvOgc8Ngs64jaE5jRIxBW/F01b3HAPXiU/6?=
 =?us-ascii?Q?QCDGJkhaIJ/RBjdfoxG1woVTnB7Lu99hV0anRuANy7Y3sePnsxY3VfA3Ro30?=
 =?us-ascii?Q?/xqE3cU/ZjFIshTXCqmXMGldWupJu1yPoqeDVw9kQZQuJLbm2Wmyo0L9V+hD?=
 =?us-ascii?Q?1ec4SiGcXg8qGOGLTbl3VDeJa8WGOy/3hejM74y1sRvCYL3JxI3w+6XgBlH3?=
 =?us-ascii?Q?fFh1FetihyWtRh1yJ5/QK08onMzJ1o6WtCgLduWRxBN3WRByKaLCjehZ9DNK?=
 =?us-ascii?Q?m8UgB6OvTuHGlbaMgCRnPweQSKQNx1LSCR7943ws3tx1J+kMoJlTzt3KduHT?=
 =?us-ascii?Q?iuhZn6/c8mlqwo4kTcCHu/Lpc0a77zW2HZe21f2n?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR11MB8309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8172ebf-c69c-47a0-8531-08dd4aa6208d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 14:12:32.7313 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5vof7+Jw36vjd7Fkp4npgRteHR5DVUzeDFbRvf3U1Ya/E5fEdJz6CmWWiYE8rzcb7h4ItPuTkzscHqAMgjR90w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4754
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

> The common/iavf driver folder contains the base code for the iavf
> driver, which is also linked against by the ice driver and others.
> However, there is no need for this to be in common, and we can
> move it to the net/intel/iavf as a base code driver. This involves
> updating dependencies that were on common/iavf to net/iavf
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  devtools/libabigail.abignore                       |  1 +
>  doc/guides/rel_notes/release_25_03.rst             |  5 ++++-
>  drivers/common/iavf/version.map                    | 13 -------------
>  drivers/common/meson.build                         |  1 -
>  .../{common/iavf =3D> net/intel/iavf/base}/README    |  0
>  .../iavf =3D> net/intel/iavf/base}/iavf_adminq.c     |  0
>  .../iavf =3D> net/intel/iavf/base}/iavf_adminq.h     |  0
>  .../iavf =3D> net/intel/iavf/base}/iavf_adminq_cmd.h |  0
>  .../iavf =3D> net/intel/iavf/base}/iavf_alloc.h      |  0
>  .../iavf =3D> net/intel/iavf/base}/iavf_common.c     |  0
>  .../iavf =3D> net/intel/iavf/base}/iavf_devids.h     |  0
>  .../iavf =3D> net/intel/iavf/base}/iavf_impl.c       |  0
>  .../iavf =3D> net/intel/iavf/base}/iavf_osdep.h      |  0
>  .../iavf =3D> net/intel/iavf/base}/iavf_prototype.h  |  0
>  .../iavf =3D> net/intel/iavf/base}/iavf_register.h   |  0
>  .../iavf =3D> net/intel/iavf/base}/iavf_status.h     |  0
>  .../iavf =3D> net/intel/iavf/base}/iavf_type.h       |  0
>  .../iavf =3D> net/intel/iavf/base}/meson.build       |  0
>  .../iavf =3D> net/intel/iavf/base}/virtchnl.h        |  0
>  .../intel/iavf/base}/virtchnl_inline_ipsec.h       |  0
>  drivers/net/intel/iavf/meson.build                 | 13 +++++++++----
>  drivers/net/intel/iavf/version.map                 | 14 ++++++++++++++
>  drivers/net/intel/ice/meson.build                  |  7 +++----
>  drivers/net/intel/idpf/meson.build                 |  2 +-
>  24 files changed, 32 insertions(+), 24 deletions(-)
>  delete mode 100644 drivers/common/iavf/version.map
>  rename drivers/{common/iavf =3D> net/intel/iavf/base}/README (100%)
>  rename drivers/{common/iavf =3D> net/intel/iavf/base}/iavf_adminq.c (100=
%)
>  rename drivers/{common/iavf =3D> net/intel/iavf/base}/iavf_adminq.h (100=
%)
>  rename drivers/{common/iavf =3D> net/intel/iavf/base}/iavf_adminq_cmd.h
> (100%)
>  rename drivers/{common/iavf =3D> net/intel/iavf/base}/iavf_alloc.h (100%=
)
>  rename drivers/{common/iavf =3D> net/intel/iavf/base}/iavf_common.c
> (100%)
>  rename drivers/{common/iavf =3D> net/intel/iavf/base}/iavf_devids.h (100=
%)
>  rename drivers/{common/iavf =3D> net/intel/iavf/base}/iavf_impl.c (100%)
>  rename drivers/{common/iavf =3D> net/intel/iavf/base}/iavf_osdep.h (100%=
)
>  rename drivers/{common/iavf =3D> net/intel/iavf/base}/iavf_prototype.h
> (100%)
>  rename drivers/{common/iavf =3D> net/intel/iavf/base}/iavf_register.h (1=
00%)
>  rename drivers/{common/iavf =3D> net/intel/iavf/base}/iavf_status.h (100=
%)
>  rename drivers/{common/iavf =3D> net/intel/iavf/base}/iavf_type.h (100%)
>  rename drivers/{common/iavf =3D> net/intel/iavf/base}/meson.build (100%)
>  rename drivers/{common/iavf =3D> net/intel/iavf/base}/virtchnl.h (100%)
>  rename drivers/{common/iavf =3D> net/intel/iavf/base}/virtchnl_inline_ip=
sec.h
> (100%)
>=20
> diff --git a/devtools/libabigail.abignore b/devtools/libabigail.abignore
> index b7daca4841..ce501632b3 100644
> --- a/devtools/libabigail.abignore
> +++ b/devtools/libabigail.abignore
> @@ -23,6 +23,7 @@
>  ; This is not a libabigail rule (see check-abi.sh).
>  ; This is used for driver removal and other special cases like mlx glue =
libs.
>  ;
> +; SKIP_LIBRARY=3Dlibrte_common_iavf
>  ; SKIP_LIBRARY=3Dlibrte_common_idpf
>  ; SKIP_LIBRARY=3Dlibrte_common_mlx5_glue
>  ; SKIP_LIBRARY=3Dlibrte_net_mlx4_glue
> diff --git a/doc/guides/rel_notes/release_25_03.rst
> b/doc/guides/rel_notes/release_25_03.rst
> index 2338a97e76..d2e8b03107 100644
> --- a/doc/guides/rel_notes/release_25_03.rst
> +++ b/doc/guides/rel_notes/release_25_03.rst
> @@ -182,9 +182,12 @@ API Changes
>    ``-Denable_drivers=3Dnet/intel/e1000``.
>=20
>  * The driver ``common/idpf`` has been merged into the ``net/intel/idpf``
> driver.
> -  This change should have no impact to end applications, but,
> +  Similarly, the ``common/iavf`` driver has been merged into the
> ``net/intel/iavf`` driver.
> +  These changes should have no impact to end applications, but,
>    when specifying the ``idpf`` or ``cpfl`` net drivers to meson via ``-
> Denable_drivers`` option,
>    there is no longer any need to also specify the ``common/idpf`` driver=
.
> +  In the same way, when specifying the ``iavf`` or ``ice`` net drivers,
> +  there is no need to also specify the ``common/iavf`` driver.
>    Note, however, ``net/intel/cpfl`` driver now depends upon the
> ``net/intel/idpf`` driver.
>=20
>=20
> diff --git a/drivers/common/iavf/version.map
> b/drivers/common/iavf/version.map
> deleted file mode 100644
> index 6c1427cca4..0000000000
> --- a/drivers/common/iavf/version.map
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -INTERNAL {
> -	global:
> -
> -	iavf_aq_send_msg_to_pf;
> -	iavf_clean_arq_element;
> -	iavf_init_adminq;
> -	iavf_set_mac_type;
> -	iavf_shutdown_adminq;
> -	iavf_vf_parse_hw_config;
> -	iavf_vf_reset;
> -
> -	local: *;
> -};
> diff --git a/drivers/common/meson.build b/drivers/common/meson.build
> index e1e3149d8f..dc096aab0a 100644
> --- a/drivers/common/meson.build
> +++ b/drivers/common/meson.build
> @@ -5,7 +5,6 @@ std_deps =3D ['eal']
>  drivers =3D [
>          'cpt',
>          'dpaax',
> -        'iavf',
>          'ionic',
>          'mvep',
>          'octeontx',
> diff --git a/drivers/common/iavf/README
> b/drivers/net/intel/iavf/base/README
> similarity index 100%
> rename from drivers/common/iavf/README
> rename to drivers/net/intel/iavf/base/README
> diff --git a/drivers/common/iavf/iavf_adminq.c
> b/drivers/net/intel/iavf/base/iavf_adminq.c
> similarity index 100%
> rename from drivers/common/iavf/iavf_adminq.c
> rename to drivers/net/intel/iavf/base/iavf_adminq.c
> diff --git a/drivers/common/iavf/iavf_adminq.h
> b/drivers/net/intel/iavf/base/iavf_adminq.h
> similarity index 100%
> rename from drivers/common/iavf/iavf_adminq.h
> rename to drivers/net/intel/iavf/base/iavf_adminq.h
> diff --git a/drivers/common/iavf/iavf_adminq_cmd.h
> b/drivers/net/intel/iavf/base/iavf_adminq_cmd.h
> similarity index 100%
> rename from drivers/common/iavf/iavf_adminq_cmd.h
> rename to drivers/net/intel/iavf/base/iavf_adminq_cmd.h
> diff --git a/drivers/common/iavf/iavf_alloc.h
> b/drivers/net/intel/iavf/base/iavf_alloc.h
> similarity index 100%
> rename from drivers/common/iavf/iavf_alloc.h
> rename to drivers/net/intel/iavf/base/iavf_alloc.h
> diff --git a/drivers/common/iavf/iavf_common.c
> b/drivers/net/intel/iavf/base/iavf_common.c
> similarity index 100%
> rename from drivers/common/iavf/iavf_common.c
> rename to drivers/net/intel/iavf/base/iavf_common.c
> diff --git a/drivers/common/iavf/iavf_devids.h
> b/drivers/net/intel/iavf/base/iavf_devids.h
> similarity index 100%
> rename from drivers/common/iavf/iavf_devids.h
> rename to drivers/net/intel/iavf/base/iavf_devids.h
> diff --git a/drivers/common/iavf/iavf_impl.c
> b/drivers/net/intel/iavf/base/iavf_impl.c
> similarity index 100%
> rename from drivers/common/iavf/iavf_impl.c
> rename to drivers/net/intel/iavf/base/iavf_impl.c
> diff --git a/drivers/common/iavf/iavf_osdep.h
> b/drivers/net/intel/iavf/base/iavf_osdep.h
> similarity index 100%
> rename from drivers/common/iavf/iavf_osdep.h
> rename to drivers/net/intel/iavf/base/iavf_osdep.h
> diff --git a/drivers/common/iavf/iavf_prototype.h
> b/drivers/net/intel/iavf/base/iavf_prototype.h
> similarity index 100%
> rename from drivers/common/iavf/iavf_prototype.h
> rename to drivers/net/intel/iavf/base/iavf_prototype.h
> diff --git a/drivers/common/iavf/iavf_register.h
> b/drivers/net/intel/iavf/base/iavf_register.h
> similarity index 100%
> rename from drivers/common/iavf/iavf_register.h
> rename to drivers/net/intel/iavf/base/iavf_register.h
> diff --git a/drivers/common/iavf/iavf_status.h
> b/drivers/net/intel/iavf/base/iavf_status.h
> similarity index 100%
> rename from drivers/common/iavf/iavf_status.h
> rename to drivers/net/intel/iavf/base/iavf_status.h
> diff --git a/drivers/common/iavf/iavf_type.h
> b/drivers/net/intel/iavf/base/iavf_type.h
> similarity index 100%
> rename from drivers/common/iavf/iavf_type.h
> rename to drivers/net/intel/iavf/base/iavf_type.h
> diff --git a/drivers/common/iavf/meson.build
> b/drivers/net/intel/iavf/base/meson.build
> similarity index 100%
> rename from drivers/common/iavf/meson.build
> rename to drivers/net/intel/iavf/base/meson.build
> diff --git a/drivers/common/iavf/virtchnl.h
> b/drivers/net/intel/iavf/base/virtchnl.h
> similarity index 100%
> rename from drivers/common/iavf/virtchnl.h
> rename to drivers/net/intel/iavf/base/virtchnl.h
> diff --git a/drivers/common/iavf/virtchnl_inline_ipsec.h
> b/drivers/net/intel/iavf/base/virtchnl_inline_ipsec.h
> similarity index 100%
> rename from drivers/common/iavf/virtchnl_inline_ipsec.h
> rename to drivers/net/intel/iavf/base/virtchnl_inline_ipsec.h
> diff --git a/drivers/net/intel/iavf/meson.build
> b/drivers/net/intel/iavf/meson.build
> index d9b605f55a..c823d618e3 100644
> --- a/drivers/net/intel/iavf/meson.build
> +++ b/drivers/net/intel/iavf/meson.build
> @@ -7,9 +7,13 @@ endif
>=20
>  testpmd_sources =3D files('iavf_testpmd.c')
>=20
> -deps +=3D ['common_iavf', 'security', 'cryptodev']
> +deps +=3D ['security', 'cryptodev']
>=20
>  sources =3D files(
> +        'base/iavf_adminq.c',
> +        'base/iavf_common.c',
> +        'base/iavf_impl.c',
> +
>          'iavf_ethdev.c',
>          'iavf_rxtx.c',
>          'iavf_vchnl.c',
> @@ -20,8 +24,9 @@ sources =3D files(
>          'iavf_ipsec_crypto.c',
>          'iavf_fsub.c',
>  )
> +includes +=3D include_directories('base')
>=20
> -if arch_subdir =3D=3D 'x86' and is_variable('static_rte_common_iavf')
> +if arch_subdir =3D=3D 'x86'
>      sources +=3D files('iavf_rxtx_vec_sse.c')
>=20
>      if is_windows and cc.get_id() !=3D 'clang'
> @@ -30,7 +35,7 @@ if arch_subdir =3D=3D 'x86' and
> is_variable('static_rte_common_iavf')
>=20
>      iavf_avx2_lib =3D static_library('iavf_avx2_lib',
>              'iavf_rxtx_vec_avx2.c',
> -            dependencies: [static_rte_ethdev, static_rte_common_iavf],
> +            dependencies: [static_rte_ethdev],
>              include_directories: includes,
>              c_args: [cflags, '-mavx2'])
>      objs +=3D iavf_avx2_lib.extract_objects('iavf_rxtx_vec_avx2.c')
> @@ -43,7 +48,7 @@ if arch_subdir =3D=3D 'x86' and
> is_variable('static_rte_common_iavf')
>          endif
>          iavf_avx512_lib =3D static_library('iavf_avx512_lib',
>                  'iavf_rxtx_vec_avx512.c',
> -                dependencies: [static_rte_ethdev, static_rte_common_iavf=
],
> +                dependencies: [static_rte_ethdev],
>                  include_directories: includes,
>                  c_args: avx512_args)
>          objs +=3D iavf_avx512_lib.extract_objects('iavf_rxtx_vec_avx512.=
c')
> diff --git a/drivers/net/intel/iavf/version.map
> b/drivers/net/intel/iavf/version.map
> index 98de64cca2..d18dea64dd 100644
> --- a/drivers/net/intel/iavf/version.map
> +++ b/drivers/net/intel/iavf/version.map
> @@ -17,3 +17,17 @@ EXPERIMENTAL {
>  	# added in 21.11
>  	rte_pmd_ifd_dynflag_proto_xtr_ipsec_crypto_said_mask;
>  };
> +
> +INTERNAL {
> +	global:
> +
> +	iavf_aq_send_msg_to_pf;
> +	iavf_clean_arq_element;
> +	iavf_init_adminq;
> +	iavf_set_mac_type;
> +	iavf_shutdown_adminq;
> +	iavf_vf_parse_hw_config;
> +	iavf_vf_reset;
> +
> +	local: *;
> +};
> diff --git a/drivers/net/intel/ice/meson.build
> b/drivers/net/intel/ice/meson.build
> index beaf21e176..5faf887386 100644
> --- a/drivers/net/intel/ice/meson.build
> +++ b/drivers/net/intel/ice/meson.build
> @@ -18,7 +18,7 @@ sources =3D files(
>=20
>  testpmd_sources =3D files('ice_testpmd.c')
>=20
> -deps +=3D ['hash', 'net', 'common_iavf']
> +deps +=3D ['hash', 'net', 'net_iavf']
>  includes +=3D include_directories('base')
>=20
>  if arch_subdir =3D=3D 'x86'
> @@ -30,7 +30,7 @@ if arch_subdir =3D=3D 'x86'
>=20
>      ice_avx2_lib =3D static_library('ice_avx2_lib',
>              'ice_rxtx_vec_avx2.c',
> -            dependencies: [static_rte_ethdev, static_rte_kvargs, static_=
rte_hash],
> +            dependencies: [static_rte_ethdev, static_rte_hash],
>              include_directories: includes,
>              c_args: [cflags, '-mavx2'])
>      objs +=3D ice_avx2_lib.extract_objects('ice_rxtx_vec_avx2.c')
> @@ -43,8 +43,7 @@ if arch_subdir =3D=3D 'x86'
>          endif
>          ice_avx512_lib =3D static_library('ice_avx512_lib',
>                  'ice_rxtx_vec_avx512.c',
> -                dependencies: [static_rte_ethdev,
> -                    static_rte_kvargs, static_rte_hash],
> +                dependencies: [static_rte_ethdev, static_rte_hash],
>                  include_directories: includes,
>                  c_args: avx512_args)
>          objs +=3D ice_avx512_lib.extract_objects('ice_rxtx_vec_avx512.c'=
)
> diff --git a/drivers/net/intel/idpf/meson.build
> b/drivers/net/intel/idpf/meson.build
> index 87bc39f76e..d69254484b 100644
> --- a/drivers/net/intel/idpf/meson.build
> +++ b/drivers/net/intel/idpf/meson.build
> @@ -7,7 +7,7 @@ if is_windows
>      subdir_done()
>  endif
>=20
> -includes +=3D include_directories('../../../common/iavf')
> +includes +=3D include_directories('../iavf/base')
>=20
>  sources =3D files(
>          'idpf_common_device.c',
> --
> 2.43.0

Patch looks good to me Bruce.

Acked-by: Ian Stokes <ian.stokes@intel.com>

