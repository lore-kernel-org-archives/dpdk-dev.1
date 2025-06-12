Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54F7C61CE8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 09:55:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 088A04021F;
	Thu, 12 Jun 2025 11:55:16 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by mails.dpdk.org (Postfix) with ESMTP id 8CD7C4003C
 for <dev@dpdk.org>; Thu, 12 Jun 2025 11:55:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2VLKfPsdAhacB/Qn1mCCucrbCLAEN9GnA7DkZE/aF0IrSA4KvWq/Mz6+fX3UQdYqxM3c7jaW0yhXaZgAjve46537gO4tuDczig1LqL7Ak0vvtCOBRGHbHWKpP81nreOnmafGItvg98VQjNEA+az1oggXvpXgSiVOi6GwHwA2q2Y2vT3+qa6quL+qWWWDboXIVnWNj3oZcp3ZocuFZhy9KBWFkIeCHv77BDq6C4jlnyIzCJdcVHImsoogINFCheUPBj3I3y9pjzF1qvfaoJLapNc5eaw4uTGZUf5kG/zWJyevY1t/tzgt8KefWvYc2X/Ne36wQUeTIi3Rz0HY0/eJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQRILgfiQoUKYatbcsQZPIg+Y34a8bqnRxDclLnzMjo=;
 b=Dvnf6Je1mlx0B/1Rx6TsUPgL8rNofeNo3VDa3QDbqGMb4jtD0R3Y+CWDSOsAILUZTV4ecDDrvsH9Ell5W2qrSreO8eW9VG3Hfl6uKKcYCUJrM8gM+QLdX9hYjFwcwNrPRBsZV9tqXM9BO6nsN/+UcPBdF113HTZ6/rmmEYmfOckfAnfCWvqApuhFL0uW4ENrVsqJkjOdRw0ZEhCXYsj5WsQUtPGiQ5dbaA/UivAPXIZUBYB8xWENVZdFjlMyyIwFRfdvI8x1EfKzpQ7GNX69xjxO3oDg9EMbIvb6SPXHVTlc6y+gSlZGKnuBoxAvzUyzk4VGgpB23TJtpNrOlDG0Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQRILgfiQoUKYatbcsQZPIg+Y34a8bqnRxDclLnzMjo=;
 b=NiwPpZwxWKa6aPHBk8px10Jp4AAwvz6sgrydmT62DxqtDMeUZrNLr4jWAg6Nf56qpQCsjsbVPugRYSdsdQaVH9W8g+sg9Qrc2u0m3HIygA4AYkjUqh3QBdP1klxhFBK8LSubWYy9qyZDaivgnQ77U9iOl7PMPJp77I9ZZfoBExI=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by IA1PR12MB8286.namprd12.prod.outlook.com (2603:10b6:208:3f8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 09:55:10 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 09:55:10 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v5] build: reduce use of AVX compiler flags
Thread-Topic: [PATCH v5] build: reduce use of AVX compiler flags
Thread-Index: AQHb2r8K2FUk7GJtekyeMJ81z9g/obP/SnaA
Date: Thu, 12 Jun 2025 09:55:09 +0000
Message-ID: <PH7PR12MB85960653AC67A63162DC75468274A@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250325172215.3360590-1-bruce.richardson@intel.com>
 <20250611105310.472523-1-bruce.richardson@intel.com>
In-Reply-To: <20250611105310.472523-1-bruce.richardson@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-12T09:54:34.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|IA1PR12MB8286:EE_
x-ms-office365-filtering-correlation-id: 761896cb-9b69-45b3-c32e-08dda99737da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?E2JhaOblL/ayaYzcV9frnFH++6OQsvukYI1B09ID6xQhOd+PqDM/aQVxqRaC?=
 =?us-ascii?Q?SxwZAPkgDjQfQYrY4SDxKQw48FK2eG0qUcHwQYm5M4iK2JoQRNELzXybt5Qq?=
 =?us-ascii?Q?HH31io90WxiV8KR47UhRtMQZFHy450OhHFjhi8C4R/hNFCvLGNAH8Nli0OEN?=
 =?us-ascii?Q?dHnlXPktnnJKVePZOnHyf6gjF2iOL5JYXLBJtat2fPtPCPzjHB2dHLbK+zrG?=
 =?us-ascii?Q?9/uqa/MG1VNM430K1AAcSxTOxuHLKSUG/cC/dgx81LZnTuMRjMvgXHPQ0qCb?=
 =?us-ascii?Q?TLmrWm8AtYR4Fn62ctd6/asRHtogpiKw8sbm/0Zhhn5HUeMHSnuuFeUdfSGq?=
 =?us-ascii?Q?Q7RC5oSrb3C+FTXhxdtoy1YbHX+gleqkQipKH0pH4tvraFBwTUZriDx5tSNI?=
 =?us-ascii?Q?VMwSrhg+b7L0HJ/l+owjnaem91Ud8fmFGAIj7hegYqP0Ij+y3CbeCNudYH33?=
 =?us-ascii?Q?ODe0g3Ju5bmb461GYQdkKD7zuS12rPGXrS2fE5Ibr9ytaTSNPlygBvnlfKB7?=
 =?us-ascii?Q?s3h6WTN0cT1GNdPVkFn807cJXgk3jmyzVDGSqKU0WyKJorlUSoOmSJB5zE3A?=
 =?us-ascii?Q?6Nwvhu6VPq8J3/sHCIbAM4pEYJcChY5e94T0X1ThLWGT8/8qRX5SezpGbxPN?=
 =?us-ascii?Q?NQysS25jhoR9+FND4nd0phcji1ckz/KfpvTaRHznM2Dz+LtkDwJ/8N7GUYAd?=
 =?us-ascii?Q?VY1q87DF8Fy3cxIBqdhbTS7dQc0AvWnMcHeH1/IIMHohzJh7AHhjfMEYodmV?=
 =?us-ascii?Q?ixfrHxky/Rs80qu9w3VHyWNTs5buzcwMIEBWnb4No8ORmC6v8gMAejblm/vE?=
 =?us-ascii?Q?4BqUH3/Zm11g6o+KWpzygc4wgHWNLtk+LxGY1hJ/tJusD1VyLdv2sP9A/39a?=
 =?us-ascii?Q?1ryL8AxyqBdVkASBvsK5h27uEsG5qvZt26nG4FaP2f+LvGmdBfIN+jJZ86Jp?=
 =?us-ascii?Q?bfTOjcM9M7BPMo7tl4eHj2cTVY+rnRJOMO6t2R4DP9l/IC5ir56AAwAu7RBJ?=
 =?us-ascii?Q?WQGAXLwqMUA697Vz0U1pnZNZmITCz4wvk4zwzd/LTJ7QosKL3X8H2VPglkll?=
 =?us-ascii?Q?xUBbNx8CizXdTOQKpBkJjXcD99ZfS+fy9GZRB/sgThWj3kq+XIqlwUbhsdbB?=
 =?us-ascii?Q?TJyKw0rnIMfjBMuq8Q1JYXiVjiv1DuyGmoa1lpnmhPkOoWPF5VAKHe3fFnXk?=
 =?us-ascii?Q?U/d91rNyd10cODD3GGr6zpaLE1klywso3TdbEdftuWrU1GtZyvSi7IAlnQ+T?=
 =?us-ascii?Q?kTRqiohmWrIsfLsXcaKuRxjWItunMvJYt/ZVP9BvKI4ZoYAVqJRFGyCyWqmW?=
 =?us-ascii?Q?bkPY+98IoE7XalM5tfH9bbMMIYDBiDx6F3TNFS/DOt9wj7ES4gebcvcAG8av?=
 =?us-ascii?Q?+7KOMKLAZG1dJl6v8yvmENInRHm1cd0/NRZj+jpK2Etch9TOZ7NqdMqYCORH?=
 =?us-ascii?Q?laBXJP0JrCCKUrFffH/cl9b7MGMQmOkxSoI1jbF5W/ETemA3uWFcqNxkB4Au?=
 =?us-ascii?Q?GCkn/UhuufTJl/8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LieScFRy1YZwILA32IZFSRQTiDd2kymta0oCx90NnFaGP0xRwafCnj+1zf33?=
 =?us-ascii?Q?1h4U+/zG5Kv02h7gcumPl1MH69vxuR6LBjp+MF7VopJ2HNooWtB/w1XvqG9x?=
 =?us-ascii?Q?DeknDPLtpZStRu8j1YvNUHWSSH7QscPcYvRLE67RheYozjXx73G6TJUnFTu3?=
 =?us-ascii?Q?rw1KXBE47JlmSLjV/angPKotnFiIZBMjbba9ocYg9maCeGA3knTB26kkaC6J?=
 =?us-ascii?Q?p5V3BYyBya2h/OUfbhOQ6TqsKXVMMj1nrkz/xkHsmsq6JKTtqmH1e/H0Dh/O?=
 =?us-ascii?Q?WRzD9EBinOtb+ERYigcxf6meSZs9tbgqXfcNsmB4qaeVZGgvFOSLIjOajVpO?=
 =?us-ascii?Q?vqIa3icW7sO+/8ZQvvKc6f4ykBwDetxC2jKxGD1ukVblbeH2VjLAeplI5o9o?=
 =?us-ascii?Q?tB2UkpWbfWA40E0JnOuUPQREw0lZQS3cD5KTYAdYG8vuDkTOZQYomDkr6nc0?=
 =?us-ascii?Q?gA5OWPJfPZoiL3NhlHZQTGbvwzvC0uaS1o3N6QwjjHWZodH344KeoywibPbU?=
 =?us-ascii?Q?uFYhcXQ31ctQxe5hNwSmVab3YQGkUgZwZqjdHrk2aw8DI1vD6w4C9ifFLeNs?=
 =?us-ascii?Q?KkD/Xaha5l4gAwiVKV9BWxguy1q88dvu1eZkkqgDOkOUhy7ZCHqFyrtPtQS9?=
 =?us-ascii?Q?gTSjyEaEkxLJtINpMJVsQ/M4U+26uFLk1d7ow1MXhlLQ9N5hXdG0BiH72W5B?=
 =?us-ascii?Q?c8igi5ienLvvIh3pqWXyYhxPmGLoGY7el+WWxYX6qa0TUeD6EJc/lz+l+XJO?=
 =?us-ascii?Q?+pdNG2TtF43wAETKaUz6kUfFrDMjYVLLf8eKzEOb2CIBxIY8T/6p30TW4SCM?=
 =?us-ascii?Q?MEkP7i1he+gAYYnVbT87guG4GIWmAJ/4XfzhvHoWMqguJR9qRhZ6+BMsOZIx?=
 =?us-ascii?Q?tXueBAV2uChjzEro3pNmoU/HKK9RVRtA9X4ZTefwtBPprgozPNfFlZeId4Gw?=
 =?us-ascii?Q?sSWx4gT1/u/EaZI1t3ppj63+2lPbzCdYJz406APQDuwgkaU6ZIENpMQpUVXQ?=
 =?us-ascii?Q?EyF4K0QYP5NCGirnx0Fu9LutZoNHlQt+Bjy5kqr+QXXNy17/m7Ydpi2tvfxY?=
 =?us-ascii?Q?OjZeTpc2HS/cyF/q4MgXCFiJASYQPDVvOkXriedT/ODMBz/dgn0NbOmSsmy2?=
 =?us-ascii?Q?L+aYoo6IxkFaZNmNFHMwNtJ0pW4QcoFxAaAsfOxE6IWL/KMUjOp9KYnfK6MU?=
 =?us-ascii?Q?zTVBfHiCgW3QVhiRM/Z4nvhtuhqm4IFg7Xwz2PbCFMtKTsd1+s3RXMAH+aq5?=
 =?us-ascii?Q?DIiRQPge2EN3DmGPzuWq1ETwrnb3pj9ebnWbMzFqzXAIBpVtRlAyZmDnVLez?=
 =?us-ascii?Q?fd2xPTO36q2jdcPmIu8xsqb85jPNkzDLDxS2JOtLmrwfnLbCCDNsu04VKxxA?=
 =?us-ascii?Q?hshjNAIIQ7/kgp6CZa2Ptvg5NXer+P4XlxJNIw3XCY+VDr9cm8JDJ7kKyNlX?=
 =?us-ascii?Q?GJdh+JSbsKQcqx7NOKVt+1N1mE/kQTNEfPnA1nlrAAAyga+JTHLr0YdRt0Vo?=
 =?us-ascii?Q?NH962U1nBb44wT9NkY89q73VbEUxuAFUlvBwzz4yOSlfpPn3HhMzmKGEUrp+?=
 =?us-ascii?Q?9zSGLNZXM76PgfyMfZ0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761896cb-9b69-45b3-c32e-08dda99737da
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 09:55:09.8521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FaTsqHX3/6787EhSqwpa2cWpG7/lxEDqArQ0/dnywzoS1sLtIHkRLF9WZpV33lIOswNIZIqYHa+O+h+lWx1O/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8286
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

[Public]

> -----Original Message-----
> From: Bruce Richardson <bruce.richardson@intel.com>
> Sent: Wednesday, June 11, 2025 4:23 PM
> To: dev@dpdk.org
> Cc: Varghese, Vipin <Vipin.Varghese@amd.com>; Bruce Richardson
> <bruce.richardson@intel.com>
> Subject: [PATCH v5] build: reduce use of AVX compiler flags
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> When doing a build for a target that already has the instruction sets for
> AVX2/AVX512 enabled, skip emitting the AVX compiler flags, or the
> x86-64-v4 '-march' flags, as they are unnecessary. Instead, when the defa=
ult flags
> produce the desired output, just use them unmodified, and don't bother ad=
ding in
> extra enabling flags for AVX2 or AVX-512.
>
> Depends-on: series-35421 ("doc/linux_gsg: update recommended compiler
> versions")
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> v5: Use "x86-64-v4" arch, when available, in place of "skylake-avx512"
>
> V4: Fix error flagged by CI with clang builds without AVX512 - change
>     "cc_avx512_args" to correct "cc_avx512_flags"
>
> V3: put in version check to work around an issues with some meson
>     versions, (hopefully) allowing builds to pass in all CIs. The
>     printout of the extra flags now only happens with meson >=3D 0.60.2
>
> V2: dropped the doc update for the minimum compiler version.  Based on
>     discussion, that version bump is larger than proposed in RFC and is
>     now a separate patch/series [series referenced above]
> ---
>  config/x86/meson.build | 34 +++++++++++++++++++++++-----------
>  drivers/meson.build    |  9 +--------
>  lib/meson.build        |  9 +--------
>  3 files changed, 25 insertions(+), 27 deletions(-)
>
> diff --git a/config/x86/meson.build b/config/x86/meson.build index
> c3564b0011..e2ccfb6d12 100644
> --- a/config/x86/meson.build
> +++ b/config/x86/meson.build
> @@ -4,11 +4,13 @@
>  if is_ms_compiler
>      cc_avx2_flags =3D ['/arch:AVX2']
>  else
> -    cc_avx2_flags =3D ['-mavx2']
> +    cc_avx2_flags =3D []
> +    if cc.get_define('__AVX2__', args: machine_args) =3D=3D ''
> +        cc_avx2_flags =3D ['-mavx2']
> +    endif
>  endif
>
>  cc_has_avx512 =3D false
> -target_has_avx512 =3D false
>
>  dpdk_conf.set('RTE_ARCH_X86', 1)
>  if dpdk_conf.get('RTE_ARCH_64')
> @@ -65,26 +67,36 @@ if is_linux or cc.get_id() =3D=3D 'gcc'
>      endif
>  endif
>
> -cc_avx512_flags =3D ['-mavx512f', '-mavx512vl', '-mavx512dq', '-mavx512b=
w', '-
> mavx512cd'] -if (binutils_ok and cc.has_multi_arguments(cc_avx512_flags)
> +avx512_march_flag =3D '-march=3Dx86-64-v4'
> +if not cc.has_argument(avx512_march_flag)
> +    avx512_march_flag =3D '-march=3Dskylake-avx512'
> +endif
> +cc_avx512_flags =3D []
> +if (binutils_ok and cc.has_argument(avx512_march_flag)
>          and '-mno-avx512f' not in get_option('c_args'))
>      # check if compiler is working with _mm512_extracti64x4_epi64
>      # Ref: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D82887
>      code =3D '''#include <immintrin.h>
>      void test(__m512i zmm){
>          __m256i ymm =3D _mm512_extracti64x4_epi64(zmm, 0);}'''
> -    result =3D cc.compiles(code, args : cc_avx512_flags, name : 'AVX512 =
checking')
> +    result =3D cc.compiles(code, args : [avx512_march_flag], name :
> + 'AVX512 checking')
>      if result =3D=3D false
>          machine_args +=3D '-mno-avx512f'
>          warning('Broken _mm512_extracti64x4_epi64, disabling AVX512 supp=
ort')
>      else
>          cc_has_avx512 =3D true
> -        target_has_avx512 =3D (
> -                cc.get_define('__AVX512F__', args: machine_args) !=3D ''=
 and
> -                cc.get_define('__AVX512BW__', args: machine_args) !=3D '=
' and
> -                cc.get_define('__AVX512DQ__', args: machine_args) !=3D '=
' and
> -                cc.get_define('__AVX512VL__', args: machine_args) !=3D '=
'
> -            )
> +        if cc.get_define('__AVX512F__', args: machine_args) =3D=3D ''
> +            cc_avx512_flags =3D [avx512_march_flag]
> +            if cc.has_argument('-Wno-overriding-option')
> +                cc_avx512_flags +=3D '-Wno-overriding-option'
> +            endif
> +        endif
> +    endif
> +endif
> +if developer_mode and meson.version().version_compare('>=3D0.60.2')
> +    message('Extra C flags needed for AVX2 output: @0@'.format(cc_avx2_f=
lags))
> +    if cc_has_avx512
> +        message('Extra C flags needed for AVX512 output:
> +@0@'.format(cc_avx512_flags))
>      endif
>  endif
>
> diff --git a/drivers/meson.build b/drivers/meson.build index 7b7205dfac..=
b62880db02
> 100644
> --- a/drivers/meson.build
> +++ b/drivers/meson.build
> @@ -267,18 +267,11 @@ foreach subpath:subdirs
>              endif
>              if sources_avx512.length() > 0 and cc_has_avx512
>                  cflags +=3D '-DCC_AVX512_SUPPORT'
> -                avx512_args =3D [cflags, cc_avx512_flags]
> -                if not target_has_avx512 and cc.has_argument('-march=3Ds=
kylake-
> avx512')
> -                    avx512_args +=3D '-march=3Dskylake-avx512'
> -                    if cc.has_argument('-Wno-overriding-option')
> -                        avx512_args +=3D '-Wno-overriding-option'
> -                    endif
> -                endif
>                  avx512_lib =3D static_library(lib_name + '_avx512_lib',
>                          sources_avx512,
>                          dependencies: static_deps,
>                          include_directories: includes,
> -                        c_args: avx512_args)
> +                        c_args: [cflags, cc_avx512_flags])
>                  objs +=3D avx512_lib.extract_objects(sources_avx512)
>              endif
>          endif
> diff --git a/lib/meson.build b/lib/meson.build index 1934cb4a29..0d56b208=
3b 100644
> --- a/lib/meson.build
> +++ b/lib/meson.build
> @@ -261,18 +261,11 @@ foreach l:libraries
>          endif
>          if sources_avx512.length() > 0 and cc_has_avx512
>              cflags +=3D '-DCC_AVX512_SUPPORT'
> -            avx512_args =3D [cflags, cflags_avx512, cc_avx512_flags]
> -            if not target_has_avx512 and cc.has_argument('-march=3Dskyla=
ke-avx512')
> -                avx512_args +=3D '-march=3Dskylake-avx512'
> -                if cc.has_argument('-Wno-overriding-option')
> -                    avx512_args +=3D '-Wno-overriding-option'
> -                endif
> -            endif
>              avx512_lib =3D static_library(libname + '_avx512_lib',
>                      sources_avx512,
>                      dependencies: static_deps,
>                      include_directories: includes,
> -                    c_args: avx512_args)
> +                    c_args: [cflags, cflags_avx512, cc_avx512_flags])
>              objs +=3D avx512_lib.extract_objects(sources_avx512)
>          endif
>      endif
> --
> 2.48.1


Acked-by: Vipin Varghese <vipin.varghese@amd.com>
