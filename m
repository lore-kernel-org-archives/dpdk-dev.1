Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D430AC0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 17:05:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 133F54067B;
	Tue, 11 Feb 2025 18:05:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id C2BC64066F
 for <dev@dpdk.org>; Tue, 11 Feb 2025 18:05:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739293540; x=1770829540;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wN8jP/IHYI3VMO3e1FdZQEWF8Xi288IpbfnUm8Uu/aY=;
 b=dwIzC48iwsUUykBQdojc4Qg9stm42IGiL/u2I2LxZYIuCVzJGBuVoKDg
 l4UY2GisLIsRU8abQnTy4KwNcqeK2oAnnErZWPyoikjki3nD7xHEN2qrf
 KaEtykSpVPXiifYkoBxxHQhx2huz1CRdB4PPyjSTXKbqv/0+Dg+QeTChU
 5NneOex4F3/mnKMQdvmUxxNJ+YQmf0LZw0LC4PKV1De/gbnFl6RbtyNeW
 aVIFjeONCZ7T2eLDgW6vnNFoJ9A0CSw+t21yujSSfCPE6hsXUwHHmqngg
 +GtCanyv45bhk+QKuRE4foDcbZGPXQHhSce2NPzRmQSMN8i9kxCFrAFKl g==;
X-CSE-ConnectionGUID: SN0XBpISTEm9oy6m7wmrsg==
X-CSE-MsgGUID: NnQ70OkOR4GTfz/EkovzHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="65278823"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; d="scan'208";a="65278823"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2025 09:04:03 -0800
X-CSE-ConnectionGUID: NXFTQOuPSk+dJG2XuCAQDA==
X-CSE-MsgGUID: lkGjyJtHQ+ieIesgFqvGNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="117496151"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Feb 2025 09:04:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 09:03:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 09:03:56 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 09:02:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pa/oagrP8Ro7h7HCVCE7WXa7bF9+ItvDX8O4iAojxyxX6GLBx1McGWqRJAjD2K2xz+22bwtnBAPJ6Gzh4iaIa1KchMUSIP8tTiqI0vfVt7+sJcuZL589DsZwEOvGdSxN3D57oa2Y3sLKu+cHR7pShpIbw3sqTf82mJuG6k7g77MqeZrZzj5koXjMdkZQRqqaDaFORqGnlOveFH1KDnRwMg06uDX8qtELo8fxLNNnIxfL7aObx0Gw28SWN8q/9WlGtDfwwuOJ+NIE+bbfAfcVm0MVZEfBRcJ1i/73WwuIjGMvhdGms0kpFbumRPBxOAEzMCdvNEAL7ESGHAiTuk1ung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9ZDeOKaXuPGq47OlXQlJsui2JwlDG8eDM+8DD8H/0s=;
 b=stabh+D6PNOsdpTKh9CNSx/PfGAv8lHyz8l6yzB7w8ubisXhWuv6VoRgzDg5aYI/jlPyxPiIUWhHyhqOGLXM+JffksESPkoD1SLD6fqu6VTLw75syrz/RHajlhL1PMQMrHzwraN78oZ0KTKvCAIrWf9fMYYAEMqqaFtSHNvfMfmHmtJ3PsMHE0K8QYaJbV3t4Tamc9qabmeSQUYSjzXYutnjYBrrnsKj7W316l+6mL1/mPDf2qfIXcoKJDda4tlsh0hdavmFPO8Q0os1Evgp1VWWUTOr2lSXeDzu1q3j7hm5p8CE6ZttltXdK98YN0tSrivqX9LMDDkLha6pGQaGnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW6PR11MB8309.namprd11.prod.outlook.com (2603:10b6:303:24c::19)
 by DS0PR11MB8740.namprd11.prod.outlook.com (2603:10b6:8:1b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 17:02:21 +0000
Received: from MW6PR11MB8309.namprd11.prod.outlook.com
 ([fe80::ba43:b01f:aee0:10a8]) by MW6PR11MB8309.namprd11.prod.outlook.com
 ([fe80::ba43:b01f:aee0:10a8%4]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 17:02:19 +0000
From: "Stokes, Ian" <ian.stokes@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>
Subject: RE: [PATCH] build: allow disabling avx512 support via compiler flag
Thread-Topic: [PATCH] build: allow disabling avx512 support via compiler flag
Thread-Index: AQHbbCNnlWatbUZnwESocDV38AcEU7NCdEfQ
Date: Tue, 11 Feb 2025 17:02:19 +0000
Message-ID: <MW6PR11MB83091D62D1060A738AA514E192FD2@MW6PR11MB8309.namprd11.prod.outlook.com>
References: <20250121164114.2311086-1-bruce.richardson@intel.com>
In-Reply-To: <20250121164114.2311086-1-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR11MB8309:EE_|DS0PR11MB8740:EE_
x-ms-office365-filtering-correlation-id: 308c1811-4fd1-46c8-f478-08dd4abdd817
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?6G29k/cVx6wlMBBQ5W1/+H3FmCamU72PiPrsSTMMBmT9rYTEm2jIYaoLfPs/?=
 =?us-ascii?Q?oDQ+4lzHf+vtEMlevaZ8WT6crHFQ5Nj5ii2NyeB9RSyyQPuUZ28b39fzmxE8?=
 =?us-ascii?Q?FGOcDMFKjdpKqGaDw48LNZo13fPWwLM2rUoHFaxHQ0jkGNbtwt/7pnXHBRBk?=
 =?us-ascii?Q?e2KUoZR3Y1vQwiPsJqCV3KASljnd4UlGWpm2eEtSssWppfaWp+ewejJMcWrT?=
 =?us-ascii?Q?+P7Qab89K/jGQSsvTDo/7WhfIIhLdFz59iw08NZMp/RgOrpoTXuHluwmBNDa?=
 =?us-ascii?Q?c7hLxRiGxener/FCDYrfJhO2+SirNPq5ysq4jQEFTmFp/W2Zs4Hdk/nsnrYh?=
 =?us-ascii?Q?R0+Xqylc9kOr4/eIhJL2xK/ynIpVqksypN/b1OmHGPpFUVGSbgMSjNnwDlr2?=
 =?us-ascii?Q?m1pvBfrLvttZzMPqARUFPcgzOa6+cihfGIGuAIBBxg4NYIgGKLrT5YmltE1F?=
 =?us-ascii?Q?1mcK/S5SXX0r31U5W9KAYS95z1VQ0lUqABv6RzOQ9mF+F9NDzrIakdJWxY6x?=
 =?us-ascii?Q?meOg726mpQD9fNeZabA03vQnPEFwPuqs9jlRY+Y5dXgRCFIEK/SVvDDAiWav?=
 =?us-ascii?Q?gRiIOPh4hwuPmlXdmQ7j1s0qKZEiuVbzdaG0UeYXQAPImmyl9Bavi9PYF3E4?=
 =?us-ascii?Q?Ca7VyH1D/I1C9ocm+1ap3NlUdEteT9L550XSRFzP8cdLMe+igWNzftKAU+tg?=
 =?us-ascii?Q?F/tZ+ZekaUKjZf4X4n+LtfaGw/qAA8Gfx3RFTeATf/n93AuVDw66J667A38A?=
 =?us-ascii?Q?8FRUxFIDHeISQqwXr5ikMAyOsE1AO0ThGZne+kFb/IQeNw1BHNmGkMnvl9QW?=
 =?us-ascii?Q?+2aQ26GXn+Ma9E4MjpWaGT+9OysA96UVwi2qhtQ6DObljVb91zaz2m6rFG1d?=
 =?us-ascii?Q?yEIlzIbYZfmKAtpzTg91j2CK4yynhR+PU+03I1qEi9LR5lB8aZi4p8x32/Br?=
 =?us-ascii?Q?k6+yuSmK1DSdBN28M+W6zyhPcCzxuAl5OVJ/AbBfTdKq1r21+1fqUKQNBpQF?=
 =?us-ascii?Q?xbMscjKgkAvgO0FOq8BDQoOcAOt0wdYT1bFs8lSWWunXqHwJbuVEEXW13mfP?=
 =?us-ascii?Q?kowG5ci8sKcD1lZsE0aMrt9SEbRblIistfCsKu8SbLGaEjm7aHr/3GHMmiJx?=
 =?us-ascii?Q?vc4908/nQ8DpaumIkelfGEoII7vkhNOK+/RnRH69wcOhxgD12YxK3rTaaMZw?=
 =?us-ascii?Q?i4uVpyB2HRd/3Z6xS1cpxGEbvsZUy1xFC2vg7P0QXoO4gk8TxuaUv1hLsK+Q?=
 =?us-ascii?Q?9TjSn5K+SI+NQycczXej4ongB1PCxsl1876IgaXI4tFHFhjaGV3HpnpQFulE?=
 =?us-ascii?Q?Yg7DYsOwXvmzg1RHeLtvpop1LxOKu+jGaBI7lztBwx8p35TsA5WabS2wS86p?=
 =?us-ascii?Q?GuYI3YwtldDtOAEo6VwJQLGKlhpOntQf2GvpX5Y+Co3/jpm10QAOGaBKSTnq?=
 =?us-ascii?Q?oiM8dX5HOPEg4zNeIvWLyEp1vGj/mYvQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR11MB8309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qsnV6k2uoTy8LUfIY8X2rRHKk+l++WT8AbFtjUoNESjsxdTH+ixjD4L+fHqd?=
 =?us-ascii?Q?+NT8dUsoewdokh0I+9MvbSLPls1UY582A9AbJlhc/2/XY0HITWa2P710BujV?=
 =?us-ascii?Q?hHXnHfDfRoSC0gqJx7a5+0ewv+3hzr+J5fBLhutPF95BSlR8NG4jch7g4qme?=
 =?us-ascii?Q?E6F6JGOXZTnnPOL6wvPKkspHXl14B96Sa1+Vf4YLXrJNCfhM14pbgQAbQAeI?=
 =?us-ascii?Q?aIAVlChv3T7fVX2EopCJJZV8sGqbf8BjLkCPgxdiYLkGBa4L6KAh7ruZLaxv?=
 =?us-ascii?Q?NmW/6MLXOIERUxqWgwHl7DGWT/6r+ioMVdxaNEx/T9pMscDBy+W/72Kc6FfV?=
 =?us-ascii?Q?v82m/dvLJwxTjha76+NZE/WQPL3KGW+Q3/Phpedw2+qUtYTWB6pUhn7aLJso?=
 =?us-ascii?Q?SpuxxuwoC/oVUNKLWkR8i0gufuCWjotZudQJLJx1zTawY7bylFdgC/Wg+0EX?=
 =?us-ascii?Q?Dsp1vtd0WDP7/mTGmz9ED7JZM4VOO9Fccy2on5r39XvNG8yS25OwprD23fJ7?=
 =?us-ascii?Q?4joH5+4oS84xAy2lfj3PTlSHz8kJoEChNkT8mVLPGYRaU1XYp+JgGYU4taux?=
 =?us-ascii?Q?sz5fAPrYGaOS1BhMPR0BQSoYEpId580VdImrzboiyUefN9G0lAgT6KtcL64a?=
 =?us-ascii?Q?TW6HH4ftqbejTLBQQLH7aBQnHL1DlfKx968xlX9Ij5OV9uKfBu+ptabxIarf?=
 =?us-ascii?Q?MzY3lytSyn5FsWyr6NkrM3de4e1aDcbEiuYTPPTH33wzVGOqHnCmJDefRI+i?=
 =?us-ascii?Q?6xOVmJxiy+bwnBMXzzOmA/61xzf4y7piryzbwLweSK7dRwbLliTPvYesqJd7?=
 =?us-ascii?Q?8EQ4RZywGzH2s8M16bh8OQfVDN/OHl8HXIALBl0jioygtMqFIaIa2rVDQyw2?=
 =?us-ascii?Q?PgCRR9LlU44S6OKeia3+81PhP513mmdGUl1RPsM9Hzg1C+sa2iXlEh7BXLJs?=
 =?us-ascii?Q?m0yH5bkc/x8PzgiRRJiTbzfa9ushhOYLReurSkki0bvN4q9oWLM4RjgUqSyv?=
 =?us-ascii?Q?qEz76Cz2idqUw2A1P7pu1S/IXQeaEDDBkCys3Uo9iubi//GRjSMgBDisRkqu?=
 =?us-ascii?Q?AShEavfH4MeHrqm9d9CGdcxMRg/TCjbUumxpUn8soHITAdyK3ak+bXEw7R0x?=
 =?us-ascii?Q?h/KnEsP/HSuFCV0AipCigL7H+gKVd01+y05rIlemUiO2maB47qAxxOfS5u+k?=
 =?us-ascii?Q?SQA6IXsQwhU3kRNF9ISe9eragdTmLDxk/yZM62XWb8HQVUA+e6w6MYwKQ6I/?=
 =?us-ascii?Q?JGJ0XU/NvKLN4g1Qf+jsbI2MoZX8BlqtpvFJmdG3tdAJkNvB9aCO4P4GC7ZW?=
 =?us-ascii?Q?0AHcv8cN3aTQNH/angT3uXw4b2tZopcjBuPvS0dVovZR01BkWsF21ilUgcuj?=
 =?us-ascii?Q?Suq8D0B3+zashTB+Iu1XrdTMOyhD01/xajDsFmbwBsqiWWegt4uyep8ABeuM?=
 =?us-ascii?Q?pWjqiXfCj0zhCjX0m/Ab1gdbFVqeI5PY8jEUmGtVH1MMMrTXmLZVv+F5Q1QZ?=
 =?us-ascii?Q?qqvS7WLqLqy50Xnx9Cfb5nSfxquVbS0zb/9hss8V2Vd4TuRKLOiTMfT76Sgw?=
 =?us-ascii?Q?9gjLfmsGJLUiQpTWlGN33JxWAXidhSNoSqPK2Fgn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR11MB8309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308c1811-4fd1-46c8-f478-08dd4abdd817
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 17:02:19.1121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IQKehnwUYra8kyzKqGwcIv1SzxQJi+nEjglnkgJ3iFt2L9sSUZuLCOJCAh0il3eKjGXxRn38pjaO7eAIqPmveg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8740
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

> DPDK build checks for build support for various instruction sets by
> checking both the target machine and the compiler for support. However,
> any disabling of instruction sets via compiler flags was not taken into
> account in many cases. For AVX512 support, check for a user-specified
> "no-avx512f" flag in the c_args parameter before checking if the
> compiler can actually build AVX512 code.
>=20
> As well as providing an option for the user, this can be used to test
> builds without AVX512 without having to use an older compiler.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  config/x86/meson.build | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/config/x86/meson.build b/config/x86/meson.build
> index 5455bb0210..47a5b0c04a 100644
> --- a/config/x86/meson.build
> +++ b/config/x86/meson.build
> @@ -17,7 +17,8 @@ endif
>  cc_avx512_flags =3D ['-mavx512f', '-mavx512vl', '-mavx512dq', '-mavx512b=
w']
>  cc_has_avx512 =3D false
>  target_has_avx512 =3D false
> -if binutils_ok and cc.has_multi_arguments(cc_avx512_flags)
> +if (binutils_ok and cc.has_multi_arguments(cc_avx512_flags)
> +        and '-mno-avx512f' not in get_option('c_args'))
>      # check if compiler is working with _mm512_extracti64x4_epi64
>      # Ref: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D82887
>      code =3D '''#include <immintrin.h>
> --
> 2.43.0

Thanks Bruce,

tested ok for me, LGTM.

Acked-by: Ian Stokes <ian.stokes@intel.com>

