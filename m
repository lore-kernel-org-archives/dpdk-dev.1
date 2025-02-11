Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA81BC0219D
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 14:14:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB904402C3;
	Tue, 11 Feb 2025 15:14:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 3772D40289
 for <dev@dpdk.org>; Tue, 11 Feb 2025 15:14:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739283256; x=1770819256;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UnIc9JpnEno6/LUb6CjFxSHFnMNUDsQ2gxtIIWXKBsc=;
 b=mY11qVpheTnwdfDxPjUWa0ylkrSe1Z/7VesVuuqTTESfJgefW/fX1/E5
 r3XorfS9p2sQfD/pJ2KuT9ysEeI3q91ragOcG/zVlUgX2pA3sYGGlnRiq
 Etq3nLxvrDkr8R+2DH0a8yqnB3Oe6gw3jPz1CD7BzhFrJu2c0sHnEyMvx
 pZBbcYS5JETOb33xLyiZ19F5HZUqFC8ByQZ0eNzm0/neGpI7siijMFCLD
 MZmhQ1teCgvtKaKjyKqhxDRdnwjWlSH3sd2uQl2h/JDEY/jmRlKLFhmBD
 qat9rNcLnFLriMm3OvNxAfxXzjJSarBJJqpO/YLBDFp2iIygQb2h6RJkG Q==;
X-CSE-ConnectionGUID: U+08B5JzQjeNqeTK23nNXg==
X-CSE-MsgGUID: ZjVLdPK7Sg+LqGp16dMlbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="57312836"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; d="scan'208";a="57312836"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2025 06:14:15 -0800
X-CSE-ConnectionGUID: xbyhFgZcSr+pkMmQXFrv8Q==
X-CSE-MsgGUID: t/e1SMaMQfuMBwoFHXvrcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; d="scan'208";a="117545519"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Feb 2025 06:14:15 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 06:14:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 06:14:14 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 06:14:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmnMYXXz9sZ7xQsQoADURzQMNmvVRjO7rPi9bMDjoj384GkIokFwbaNXxqTdM+iaRdptXEQ8E0OHcw+BZVM3R8XDmqB65uHehD28f5zTPTCm+2h3TQfHKEKj5trFYtfPEBgKMQaRMRTWr8UAVtZSU8xC6KDzLJpPniZdXV2gy4HlHRs8jE0JBFfsqS/sBKae1gciD2TykKW/Kfrg6WrembBu9gZzjbPGhtDuNSNERC0SZXQuoorwiEZBOA1PJv5omdBVcwAcGLrRqgmySRK8Z/OQvX6i6X0pwugRQdXcFQJ+LpU/SDWDN/nuATnhN/kxrVMstMzYxa25iCoIHqAnjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYJo7sgvxdupeSeOoDb4LifcqYaxlKBuIUcKZndkt34=;
 b=j235hp8mqyD6YpILZEw+M+RcOSoQGKrBnihRnH253V+SLxzvDPGipL03DgqI+6tO7Fhr0BBB5hLVrnMEgbjkajL8bonfz6rrcPcO5c0iFfg96Hki7GtpDlP4gcVUY3y6cc9FFhBlBT1+BiXk6q5jdlpmUllWWYv8ei6ePb9GlUx4IUwR93ZBuNvmFCY+90yCUBpeaE7qBy0egJhG4QydWh56zc01TwB4TktvxNfkkfdp319Zzycs5Qzf8XTE9vnTPN/1SPHAb5kQxGa167KFIKvNBDjE1PM8JClCwYe8fE1+uy84VZA0xQLNSk59yAkObOhcTeomV4/gklrAI3DsPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW6PR11MB8309.namprd11.prod.outlook.com (2603:10b6:303:24c::19)
 by DM6PR11MB4754.namprd11.prod.outlook.com (2603:10b6:5:2ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 11 Feb
 2025 14:13:44 +0000
Received: from MW6PR11MB8309.namprd11.prod.outlook.com
 ([fe80::ba43:b01f:aee0:10a8]) by MW6PR11MB8309.namprd11.prod.outlook.com
 ([fe80::ba43:b01f:aee0:10a8%4]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 14:13:44 +0000
From: "Stokes, Ian" <ian.stokes@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>
Subject: RE: [PATCH v5 4/4] net/intel: allow building ice driver without iavf
Thread-Topic: [PATCH v5 4/4] net/intel: allow building ice driver without iavf
Thread-Index: AQHbe9s5QSidgofXREaYmkiWOskcobNCJmpQ
Date: Tue, 11 Feb 2025 14:13:44 +0000
Message-ID: <MW6PR11MB8309BA14FAE5FDC350DD913692FD2@MW6PR11MB8309.namprd11.prod.outlook.com>
References: <20250128163649.343336-1-bruce.richardson@intel.com>
 <20250210164427.1118265-1-bruce.richardson@intel.com>
 <20250210164427.1118265-5-bruce.richardson@intel.com>
In-Reply-To: <20250210164427.1118265-5-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR11MB8309:EE_|DM6PR11MB4754:EE_
x-ms-office365-filtering-correlation-id: 46d31273-c7a5-4d0c-8274-08dd4aa64b08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?pzSKcQREhUoGHPrXy7ZcVGr0Z0TWOILJBdy+iguZyjLdl14yh169BQK9fTeJ?=
 =?us-ascii?Q?IU0nZ452rgVrV2zPKPwP44S1b0/aWHf7vviRsXJuavpfJf4ODdXflUCfktcr?=
 =?us-ascii?Q?rn8DkpCYa7NlCHpLCE69oZiN5HSsP0hFcjpfqRJv/TnPoffH7Z9s59ttu/pM?=
 =?us-ascii?Q?LKJidTZHT+lxB180frr/bOQCJnUZ9QghqaTaFfbc0q3iaZE68obN2qFVttXT?=
 =?us-ascii?Q?ZevFrBqEQoIO4vd1hSgR2WUw2XRqTxsc+Ht6tnGZR9EBvvjBwzTuzWeqOowB?=
 =?us-ascii?Q?nF3ugtpEDThGTVch6vid97oBM4AAFnvTfEWwWd7AQgZCgtZtE2mGEkWoyh1/?=
 =?us-ascii?Q?bAOcqfvxy5kBDZUJnz9Bz3mqNuWa2amOyoz9NaauNpo9Xi4hg7E6B13CK6Ed?=
 =?us-ascii?Q?OoAPwufvfRxXVtJ4OQoNR9/1ffziGy4XN1zvG4u8yht0H6qO1AAZCXG4PacX?=
 =?us-ascii?Q?uIGWS7THEWDea9Q22N71BhgnmQIDgCKxo9ZvKkdIOPO8k3xkypOqknvOuyzw?=
 =?us-ascii?Q?hT0bgOqxJ4KsZlp04LJYYUy1fywCy0747Smfiy2D3kks0Edmp4odu07xpdAj?=
 =?us-ascii?Q?e40mFxVoWsfhxKP51SBnlHU+Fl3KpTuHMoKT2oBcgm4tZSZ77Ft10aOUKejl?=
 =?us-ascii?Q?UZ/3P22IVh4Wry0h8nCqnUZZzeoUoyF0Y1PF1aRE36nO6+tWlOtvNHDYek7Y?=
 =?us-ascii?Q?u2SN/kgsdeikTcblfYWUSutbntKWjEnY4Vm8l09Q1zkFvtTR9vu0ZBM9X61w?=
 =?us-ascii?Q?sBIE/Bhtkyk6AugrxzKnzMt+I4JF/mO/fGNOkAekkGV97Hqr4zj5721J/b3z?=
 =?us-ascii?Q?yzS6qUHwewasix1glhM3lNNvlHF7oe8bds85T27tMMcRXArbVlMzkQh2F2fx?=
 =?us-ascii?Q?7TFcRNYbZWdQkBn1KAXSSrgtUSYPl0t0W3sKFDaVCwgH0xl2+AzjNegVhOBW?=
 =?us-ascii?Q?Y5edAOJp7UOBdkQUsLFJewflaE4RCdj3Qy3OLThMJwk9v192bXjo/KVrA9mz?=
 =?us-ascii?Q?fPSoaOccuY8cnSOJWXmrRk/n2MLOkQhbx37zpI6bcG2ZIDtX1W++qXrvKeUl?=
 =?us-ascii?Q?x6qqlKdkqjZ5wTEUf0nUwn7scLxa3B3i9qEFuL7Vv98R9GkUU4ejmDIIeBtj?=
 =?us-ascii?Q?jajOApJb04gr3SJ6FOo1qJJObI2UbcQet8yz4EP9OnUHvJMRT9xcORjE0mlb?=
 =?us-ascii?Q?7naH9P0PNP2p3fUj3C0zudKJSzKXq5XePJ5HmRUhqZ/wrLmJJUC9arnhFuYg?=
 =?us-ascii?Q?s9+XpFtYDNzNcl2tWoHB7hrQ0vzZ4ggfkaazB4l/9uuiPiWpA5ria+5mfr4E?=
 =?us-ascii?Q?3eFVGIImNrvUdbldDUBeHW+Veaq70G26OmiOCFV0LSP4J2u6r+RsiMNvHMlj?=
 =?us-ascii?Q?efHrr0DWYkjE8pkI4w7Vu1ZyIQJifNdGOFZmx+LpI9rJr2apg4R+Pm9rhM7p?=
 =?us-ascii?Q?PSh1mMk0rFfvKWVR1lxHP5h5OoUUicmq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR11MB8309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OvWsB0/UD5ABq3Y2dI3jZbV91DMzPLGP3kgz8F5bxdUOqpsUHwgS6Q4K5+KX?=
 =?us-ascii?Q?K23cd2Ka+noJ6FI9O56sg4ARmdYnfBV0mq2EFxub3TP6hQr+Wrp5ONA4ebci?=
 =?us-ascii?Q?4C0d5eXoYbfqpIARo7DPy9VoRL+U4Qt/GWMTVq0g2/xG6ULg8X9gei4Nsvd3?=
 =?us-ascii?Q?C6uMH5UVEz64mLjhHzb7UCf5FWMDmTKgrEpTqMResD6AI/ARcfMRP3YwiqDd?=
 =?us-ascii?Q?02s2Qs8hdfA6fQRx0qvHmj2T57ENi0Oa3Q90jm+1VXM95y/FGykqVwdWA0oV?=
 =?us-ascii?Q?G7ZAzYON42RbV+zPyl7cLCkrwamytF6qrmDT/40KAKRX0SHcPxN0Lk/yEsqL?=
 =?us-ascii?Q?RtXFW6F7znMFnn8+rFRMz2Ki7KTXhkkhbTQk47+rBiWrqqZFkcZdHsyEDyvP?=
 =?us-ascii?Q?fzBrsiq9l+urVTqudXHMRZ1e2sipTsr32xIh1nXmQiLiKRxAP7znGncPDhZm?=
 =?us-ascii?Q?j0x2a1flYly2Sq+OX1XHnk91tL1VJWFxhgFO7Ed1Q/jXfkc87xXAtqKNTyX2?=
 =?us-ascii?Q?ahFLLwlUFtWF1N8RZHY3PEUHKT0yPR2Gva2qv+cXBKVlJytTcWkcpY/ODc0K?=
 =?us-ascii?Q?xi+d6MOT/zEXa1nMH+Cld+bZZ/o54m9Q73Vh/5zS7N5oU10ukTmsishv2GDf?=
 =?us-ascii?Q?f6DtFDYe9Pb8RexQVwyk3wEYZYQDitOM0Xnb7VcHJIqREyAsqYiE702aYmoA?=
 =?us-ascii?Q?GOMHj1Y3SDKpnTwoHCPz78hLBAvoAQhmtBUio8aT25agJB7XqeMaAYfLkUUD?=
 =?us-ascii?Q?2nrsnUGWcwh/cPbLQN3igWhjd47rLuUW9uvrCpR/CTfSTu1kx4MlzzXDcu65?=
 =?us-ascii?Q?QK3KBRAh2AeXHxj2AQ/2GMvOpdOCllt9Luly2/hxvJV23wjm196Ab1XqHZAY?=
 =?us-ascii?Q?EP1lUA2Bg/nrCKAiCshm/qHjKfQiXNq/MF5fT/F+icm4MVNA90cZSb3gNZ75?=
 =?us-ascii?Q?9nqiLDUdBQvHniVWSH7DRp+lOBbes7Hi26ZZEV4DVtKoBreRljJtZeIkzgfR?=
 =?us-ascii?Q?SlmRLkeXn2eAoMGhRm2b+t3Ey2BX2CrVp3BHsZRouz751/TnI3OmsSS25hL6?=
 =?us-ascii?Q?csh8kWhntColIHPswEpskIuZSlWztMosrk0gDV5D4ihHzOxAsts8clQQJuF8?=
 =?us-ascii?Q?/nmFrsYLbv/6hEaRRro/ThMSxpwE8jPG4uGNs6RoJ7H/o2lHnUzp3n6vUCpp?=
 =?us-ascii?Q?10ZJg4y0B3K65FXeiQVpsAMyx2jyUOAcVfD9jia7dCD2qNK/xdz68VxwPAmq?=
 =?us-ascii?Q?2LeomnPnWqKQeddsrYivLmaONTxhN/CS4H/6Zg2ROv6QxYGyjuH0KQ+eARYD?=
 =?us-ascii?Q?PskkdZ68k/efXqALqGrwW8fdIXp1OP5r6qh4Mp1WsDO8cX9pCsvYviNQdRGo?=
 =?us-ascii?Q?oRM9eeJUyEcMXXkt/1YI6q5DtEGzfPeMBrb2XY0UU4C8FAaxqlCm3x0Fc4UK?=
 =?us-ascii?Q?uu50UOAwZzfB9I++xCPSuUdFty2PpTfpWqyyMBgjxzcB2rRgHA7DWIByYGAG?=
 =?us-ascii?Q?p8s6/Qmmghbx9+ZrAzAv09v8EsukI+Yj5fdwhyt+JD3Z5M9Xjz79ese6FBrp?=
 =?us-ascii?Q?VU32qptLno2Dd7Z4hd6nvJ8vucf/kMvWn4vhcZ6C?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR11MB8309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d31273-c7a5-4d0c-8274-08dd4aa64b08
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 14:13:44.0192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dA3yI1b+T5QQMoRfaw66Ep8ZwNDxo/3Wh5JqPd5I6YcdUA/kS1+2dUYsc+SvlPPG4YnMhnf/GEavwsFhJI/QKw==
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

> The ice PMD relies on a number of functions from the iavf base code,
> which can be got by linking against that iavf driver. However, since
> only three C files are necessary here, we can allow ice to be built
> independently of iavf by including the base files directly in cases
> where iavf is not part of the build. If it is part of the build, the
> dependency remains as now.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/iavf/base/iavf_prototype.h |  8 ++++++++
>  drivers/net/intel/ice/meson.build            | 13 ++++++++++++-
>  2 files changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/intel/iavf/base/iavf_prototype.h
> b/drivers/net/intel/iavf/base/iavf_prototype.h
> index 7c43a817bb..5d2ee0a785 100644
> --- a/drivers/net/intel/iavf/base/iavf_prototype.h
> +++ b/drivers/net/intel/iavf/base/iavf_prototype.h
> @@ -11,6 +11,14 @@
>=20
>  #include <rte_compat.h>
>=20
> +/* functions only need exporting if this is being built into
> + * iavf driver itself. If included in ice driver, then no export
> + */
> +#ifndef RTE_NET_IAVF
> +#undef __rte_internal
> +#define __rte_internal
> +#endif
> +
>  /* Prototypes for shared code functions that are not in
>   * the standard function pointer structures.  These are
>   * mostly because they are needed even before the init
> diff --git a/drivers/net/intel/ice/meson.build
> b/drivers/net/intel/ice/meson.build
> index 5faf887386..ff7f84597a 100644
> --- a/drivers/net/intel/ice/meson.build
> +++ b/drivers/net/intel/ice/meson.build
> @@ -18,9 +18,20 @@ sources =3D files(
>=20
>  testpmd_sources =3D files('ice_testpmd.c')
>=20
> -deps +=3D ['hash', 'net', 'net_iavf']
> +deps +=3D ['hash', 'net']
>  includes +=3D include_directories('base')
>=20
> +if dpdk_conf.has('RTE_NET_IAVF')
> +    deps +=3D 'net_iavf'
> +else
> +    includes +=3D include_directories('../iavf/base')
> +    sources +=3D files(
> +            '../iavf/base/iavf_adminq.c',
> +            '../iavf/base/iavf_common.c',
> +            '../iavf/base/iavf_impl.c',
> +    )
> +endif
> +
>  if arch_subdir =3D=3D 'x86'
>      sources +=3D files('ice_rxtx_vec_sse.c')
>=20
> --
> 2.43.0

Checks out ok for me, looks good.

Acked-by: Ian Stokes <ian.stokes@intel.com>


