Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA12F9B61C
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Apr 2026 11:02:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EABBD4042C;
	Wed, 22 Apr 2026 13:02:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 3BA44402E0
 for <dev@dpdk.org>; Wed, 22 Apr 2026 13:02:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776855777; x=1808391777;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/DfQ7XaxaNYOHeWbTMOm8MRBwfbLNYjnYsmpegFZBy0=;
 b=LZxC2YsAS/1ZEsHLLg/wtI1d/R/0jhD0XHnVOLjicZSSSVUnuQnLgRFa
 yVJrw/7FRbS4Eg6rJCTp4DI8WScjXiQBKycPcM0kVKkH3DRLB1LsXOILN
 VgvNx28df8kdX9dxgIsGq+lIE2YiBKzYHhJ6PDQVGq4fq7bVKF3yvRCpP
 wSc8Zlpkk84HYiuWtVY6G2zoFlsU9AqM1rkVFxsPUpvWfOb63oMzPLZxv
 S3bJidraLePLzFq7udf6/ZQsoE+nDWmdJdQbUyHPp6ZHQ9DEtxcEEJr8x
 O4o/NSfy5W5FcpQVhQpzSyWk/ATnbqKbrig9dM9HzZIgX+4yyx+l955aP w==;
X-CSE-ConnectionGUID: +zs2ETo3Q3iXjsAp0E59/g==
X-CSE-MsgGUID: 2Sr2aYYmSA2PR9NT/33MOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77681138"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="77681138"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 04:02:56 -0700
X-CSE-ConnectionGUID: Kv8jVaOXQWWWOdBviUD7VQ==
X-CSE-MsgGUID: HLMN7CqyRIa4clvwnzF0kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="231427972"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 04:02:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 04:02:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 04:02:55 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.60) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 04:02:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXUrg+eU0T7K54OBrNUMY9xx5V3Y3QGhmQygJSfnBzMuwcBz8Qo/zEqcIJlsIbfaf8vPix9sYP6mZ4HKTAV5WH0NiPHmCVbMWWhAXT7mzWVE/RDcPggr3OxVwg37Kxzk8ZeF1BZjoBBQPXwNJP2eiZbyN6lnqQ0aUzlQJnkdhTGcZu4me1HZ3f3MqdvRldzjUtfV/5knJQzFUMaAk3cIGnqhG7qUMMPBuTrin8jWrIKahdFyOlGWfVR/32pEbsx38whm5m4jv1lbbl8AfP4/ljwnqoTgFnaWmJ3fjWQdcKBocZkFL0ITzY6r5/EkbsVmEA8VyWgv29CfOynSsTaitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAvvck3wwhPfCR40mFn9sYPNb4d61JMyAZNdsunI710=;
 b=YMcxtXCKxGk3Rqz+2WVNVY8iQEapCfW0b9uOqdiOlWYX25qOVhQ+PNjFojKe0neMwOUz2vUI5aNa2hy0KJmnHbFOUUC4pWduVmNQQQ5yzfJXk4ndMPOdr9IfAakbVnXfhgHFUKcVQEf59vvJFTj+/eL++GPcUExvIVQOrOrx6LsKWNw0cmLt+wpKu9vxFn5njuU7HGDpvYxubNoph6ZL814dswdjgfGzXi2NPf5vKgidKKze6DgdnpFxpokF5aesdZXFNKOA04W8aWoO+EtEPJaxbHNKLPNwTGj3RZnFsWKTjXMsTn7g3R0r6iviW8cTyIgj8VU2GWxB9ALGi0o1Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by SA2PR11MB5033.namprd11.prod.outlook.com
 (2603:10b6:806:115::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Wed, 22 Apr
 2026 11:02:46 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::d99e:14f5:fdbb:f2d]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::d99e:14f5:fdbb:f2d%6]) with mapi id 15.20.9846.012; Wed, 22 Apr 2026
 11:02:46 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>
Subject: RE: [PATCH] config/x86: enable compatibility with muon-build
Thread-Topic: [PATCH] config/x86: enable compatibility with muon-build
Thread-Index: AQHclcFjak8EuviMqEiYCXoLY9oft7XrYdJQ
Date: Wed, 22 Apr 2026 11:02:46 +0000
Message-ID: <DM3PPF7D18F34A1A9A7381CA38881194F948E2D2@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20260204103015.1895506-1-bruce.richardson@intel.com>
In-Reply-To: <20260204103015.1895506-1-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|SA2PR11MB5033:EE_
x-ms-office365-filtering-correlation-id: 847c5156-9ce2-4a48-d35e-08dea05eaf69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|10062099007|38070700021|56012099003;
x-microsoft-antispam-message-info: JQy1w725HYN/lFxq/aauxk5u6gT8jY4Y04lgcvUrf+ChAY82I0zB9Z320rKEehiSN+HBLjFVGfiOgzuSwOeidGebTJhgot/bxaxk31Oi8H43iL7mLNdOPjpFFTVGpVqofLMM2iPCdrpPTpa99CId0AxO+u7D+V+N+aC0VjsOckZemrNx2X4y9K+h3ADPNHAxBlBivQ0PhK0qF/vNd5gYiy7PJ5MzyOyRlbxfdAWY3iOX4fpe6dchWecI6FlV9NqeXuwnm/ojnCIjjMCtg87FwGjrnCMn3OzQ3HcpdheSByZyfw4zW6UnJa4Hn7ayxmJoVUY4ZLewtJ4D6TZ8Sq4vgnVoWAF01staRZDl7zu0dXPx6Tug3n6tb+7ahoMS+6+W02ukz/WSIqUAWNbqdXB4tKwc5BBdRzzP8DrjBtdfgRIMAFo83ojk/6/oHd4kLql0PkUNVvNYFvHOIkcFHVrRdjRwYnhEb+KphmmdYVOo4m9AQxY9lMxpUskj0TwyW4vXfsOOh+Wt3E0n8XS3zeqqnY+0sxKeQ0kDMPS3DvRvsc2ZBUG3iVdt5/QkE6ti4A2Wnx/aJyRiSlq+q2Br9wWbDdMiQCz3emP8LEK20PUd7xJ3vBgzy4iputT+V1JjrNvYt2LhZdj8WYXB0gWPeVvVXFtjPSv7eZuNN7L0unRthokLCptE0l7R6fyYZ4I6+sTOSgAwpsqYVKl2Ifr3cVWLgDlvsS24CL90LHWqLGGahP8/W2XA88OLYfXSWQlNE4KHmH7nce2XddEuIRY3jw7ABggm7WrvKFlHpOryC2i2jGQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(10062099007)(38070700021)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LzF4Ev2SAsJH/tC4jWK7eYV0w1Ncg0PHk6Uc0V4SZ1NO8ekHIkTVR3pykcCJ?=
 =?us-ascii?Q?DdBPLkaANi+OeAs5Ph1bNqsZGTKlvHYIAk3g3bbqRyaqLxnFE+4bCtcmOk38?=
 =?us-ascii?Q?vIH3vAYkrOrH0Pi9P2quXbek3UKxamOmbd94cGAoNWAP1S3vlhKGOmYCfSyz?=
 =?us-ascii?Q?EDLwJFlhBxdbBY6SAV2tN9WIo7pwoaIqX4faxbhKgsb80PENz+f11K3PFs6/?=
 =?us-ascii?Q?HWXLnR0wT42/Jg0UW2ZhloDHEUH4OyCYQeg4+cOtFmhp4usP0+c+tGeGo1P8?=
 =?us-ascii?Q?WF960bxCerAV8dw07rf86GQxeQLTfxolBYnUdENnCdKMNt4zofCrng/CNlE5?=
 =?us-ascii?Q?BtJGZZcnLQ5qYXELl6V4k3Em5bmU4Tthm3YLWqXEyjhMYTeHw5VomY6+pZKk?=
 =?us-ascii?Q?8j4oMDgxf6xabHISDpTxdAFhIrOdDvck7CYWiDsOPmdPX4LXjK0btbc9JSex?=
 =?us-ascii?Q?txHY/CXhabSjgYqW0/h4kZDODkz6+OIdZ3G+ECMB0bAt4QjatdS+k8WSWSR/?=
 =?us-ascii?Q?D8+HVVqlMJodao9raE3wRiqsp7gDqVge/wpJe2gp2Dr2GEdfcIFxAtrOnetV?=
 =?us-ascii?Q?+o3VgeqTDxo4TPLdPM0KpTSfoC+OVlTehvFJuB2qhxypjaopXqHktCs8VJjO?=
 =?us-ascii?Q?8OdugJIL8yX4xuoXOqh2a/kIM2TWjARYEtgh58nBwRMnJ/GR8o7Vr53rSUR+?=
 =?us-ascii?Q?uF+uUGxLHWBRTHwnBXo5HrqDr5+72sLfifj0TRKhE2gwLVegQZuRUSCKy5vt?=
 =?us-ascii?Q?RtIvCBhACaSqMe1aBN73FzuCaDq9U8IoH57PsTLEYZXRBPdSB7SDwayuDooF?=
 =?us-ascii?Q?yNaMBsy2hZ5DZh0d2PHHsEvGT3WNm2FlN863eiZ2t9cCTTWFnut9AfsvzFWV?=
 =?us-ascii?Q?Jeh5zJjP76/g1jHl4PPkur37Ob7ZWCMYAOwmVOhcHFL3f4KIhA/lti7XY7WJ?=
 =?us-ascii?Q?tA1p7c4bkQ5LmHACOgemrEIVBNlqK7dDuf9ajsLVKCp++hgyXkrTMnrHD1mI?=
 =?us-ascii?Q?pwkJRwf/rvEiU25aKdTfo5dKZ35DUsXMRymdSySX/+4y0E6tEg157yzTipGh?=
 =?us-ascii?Q?BmWENNYizfqcMOjVN1B3h1Hzbwq81FHsEdYp7d6VYnGnEwjBMnMkq6YlYN66?=
 =?us-ascii?Q?D6UEAQoog8mn3yeR3rSJaUczBJrLCbpMmut/+iYoX4ImoxWDUVcm0pthb79c?=
 =?us-ascii?Q?vmRvmQk+FOUcuRf2atwnVoqNvO8/jjPXClJPoHjaqUUTcXguF1O+DmFtVQGd?=
 =?us-ascii?Q?Q882WLTLWkhMh/uYVJaZWsev/PZ33NkQ71A9/THMAe7bUDXhn0xEcFEKsq4E?=
 =?us-ascii?Q?tFrqhtQY2NXC+rHg/Jb2F5qw0oQsInCfKpxNAg2jygKrH6f2kFEIqXSgi9Wn?=
 =?us-ascii?Q?FTsWzKKJ+U7ty7IjlzLuOoKTfek6nf2HEccwHSR68YzCZ26zkCMuqX0qQw4v?=
 =?us-ascii?Q?qd4g6lwT+p37FEaIFHNu37j/sjzRoCdvPEULQdBJXa8zd72rHVnBIvuVSZnm?=
 =?us-ascii?Q?OMWrzlQ7MCruPuDZ2fDMdBdjIiSoXQf/zheRfQW2bY5/OFQePyM+ia4Hsc0f?=
 =?us-ascii?Q?1/xJGGKJg+my0XOSzsMadfon/j1zoUhotxIKFTZZt6fC3R3HhsnDy1iGgx/9?=
 =?us-ascii?Q?H81V3TMDXvzgu3G3L5nyFboYUdZJpNaqs5+begC1zM3h3XcOXir/1jFdBrmO?=
 =?us-ascii?Q?W3Yy/LJKSTKWAREo1TGYJxvimK0npwZLvoTn9rRTQMtW8Kpsj5xq+SclLRZN?=
 =?us-ascii?Q?EXyBGU+lPg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: H7R4uSDuuksG2zfSf+kDywjDdsO3BzflFWaBBGWrq2JHFmxqCZEXitj7pR4VRpnQiaG8Ks9S3sOG9p5xiYlnMjdU7Er0nP0hY91sUmbSZ16Afo8J6lrhJq5AOqgqnqj6OlQqlbZ/m7mh792ikV/pb/JYvgd4GelPIxCMVDVT0h0eQzaD2viRj2UqiHjhv+8x7UJh2l6BezZM8asW2jiy3qcD9vglA+egZPGjl7CndRFaA/Jfz8KbwhnfYOyCwM6+aas3RSNAXTDY3b341Kk0g1oo8XgujEK4Nb/OKQJArOr4i1AGLjiub61t79SqsbcnA1s37i63q62o4Gbear/a8Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847c5156-9ce2-4a48-d35e-08dea05eaf69
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 11:02:46.3220 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LxW84bcAsiHrX5CMClz8sR47UGbApZSW548LuMEDaMjhRgtS8wA/FgRpBUfPsQTLQh7H+sQLzM9v/Z9x+FWPNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5033
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

> Subject: [PATCH] config/x86: enable compatibility with muon-build
>=20
> Muon[1] is a reimplementation of meson in C, and in some ways is rather
> stricter than meson in processing the build files. Make a few small
> changes to the meson.build files to improve muon compatibility without
> affecting meson:
> * when checking a list of compiler args always use has_multi_arguments
>   rather than has_argument, even if list only contains one item.
> * when putting lists of compiler args in message output, explicitly
>   convert to a string for output using ','.join().
>=20
> [1] https://github.com/muon-build/muon
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

I tested this out with both muon built from source and muon downloaded
as a package ("muon-meson"). Only the version from source worked, as the
package version was missing some features required for building DPDK. I
encountered the same issue with the cnxk driver you flagged. Build was
successful after disabling. I think it makes sense to make these
changes.

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
> Note: after this patch, the majority of DPDK configures ok using muon on
> my x86 system. Some drivers have not been checked due to missing
> dependencies on my system, but one, ml/cnxk, I had to explicitly disable
> as it's using a feature not currently supported by muon (cmake_args
> parameter to "dependency()").
> Despite this limitation, I think occasionally testing things with muon
> is useful to more rigorously check our build files.
> ---
>  config/x86/meson.build | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/config/x86/meson.build b/config/x86/meson.build
> index d2f4d5c02a..124b204847 100644
> --- a/config/x86/meson.build
> +++ b/config/x86/meson.build
> @@ -68,7 +68,7 @@ if is_linux or cc.get_id() =3D=3D 'gcc'
>  endif
>=20
>  avx512_march_flag =3D ['-march=3Dx86-64-v4']
> -if not cc.has_argument(avx512_march_flag)
> +if not cc.has_multi_arguments(avx512_march_flag)
>      avx512_march_flag =3D ['-march=3Dskylake-avx512']
>  endif
>  # workaround for older compilers, e.g. GCC 8.5 on RHEL 8.
> @@ -99,9 +99,9 @@ if (binutils_ok and
> cc.has_multi_arguments(avx512_march_flag)
>      endif
>  endif
>  if developer_mode and meson.version().version_compare('>=3D0.60.2')
> -    message('Extra C flags needed for AVX2 output:
> @0@'.format(cc_avx2_flags))
> +    message('Extra C flags needed for AVX2 output:
> [@0@]'.format(','.join(cc_avx2_flags)))
>      if cc_has_avx512
> -        message('Extra C flags needed for AVX512 output:
> @0@'.format(cc_avx512_flags))
> +        message('Extra C flags needed for AVX512 output:
> [@0@]'.format(','.join(cc_avx512_flags)))
>      endif
>  endif
>=20
> --
> 2.51.0

