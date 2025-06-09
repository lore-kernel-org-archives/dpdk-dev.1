Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5356C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 06:02:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94B9C40666;
	Mon,  9 Jun 2025 08:02:08 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by mails.dpdk.org (Postfix) with ESMTP id 017BE40661
 for <dev@dpdk.org>; Mon,  9 Jun 2025 08:02:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jbs9k1pZwD5Y4kQKIrqYVdi4T7r6HttaKEwTGfAts7vXiAAxNxWeLoSHmB/OozUTrn06YxqhBgT6CX+oM8AfB660jOjwtvIPiM03J45WLiHhnn7ijnt4rKybXUWcyLCFreF9CPNsQQsknGmJ0RC+M1E0ygNO6SdVp6djfzTt89JJDCp5HekQJQDLLMhXoCCcgvgVSD4TzFx7QJrr+TG3pjTyuF2fuEJLDKzkdlc+A1o9lrCSaFKFBuDr6VEs7gzCdCt5xQUA1zWrT+JtPdl0gUYLNmu+0QX9UDmOcJzMy2zjzW6WJv/OX5iiHn8YzFtKzuib3dc7aAKGLBzD2tqnIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGcUFA3moI0HQ1BIDpz5E9grfMPCqTi9GsTgYpuDwFg=;
 b=duLlCVAlBVUwtstxbDe5kVLDXGK6bJO1ClbnWibw5IfesmU/Ik6lZjmkcNE+K3SIQtV+RQg4Pl6bgvjnv0ZR/BB7ua7rn6jM+Y+WNnghw+9cBmkfeuOcizLQnNNS1whhKnAuPbQ+wbF3XHAA2pr2r+gCpbuCRSgq4gVefgFjJ0sMu2RyW6/aF0QOKHtaEnrYBh3gwRWabcFUbAWXfa4z+dQ3YA+bCH3xRMeRsNOjZlfVlAC/zZtveh2c/SHV1hzFvief2DhiQMOtOOZI4j73PtF7HEmZ0T/TcQi30DplyoDdx5zx0fq3LIre1V86bgX/qz1pGdiMATPbzt7u3uQLIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGcUFA3moI0HQ1BIDpz5E9grfMPCqTi9GsTgYpuDwFg=;
 b=PUfooFJePUcj3NMDO0Rc7z/4nY9CcFt0C/xG5bDHF2vI8MVONXTQiCikV8z5m0HEOzAUuVWYKty75gHdGPtRNwXY4MN3WR3IPB8bPo9jJyRijlCOUqJSWYezDeKjTFsxIoNIPM3a26wzFC+bWPL5YRYFR/wxY4MPR19c4A+7/hM=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by CYYPR12MB8732.namprd12.prod.outlook.com (2603:10b6:930:c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 06:02:03 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%5]) with mapi id 15.20.8792.034; Mon, 9 Jun 2025
 06:02:03 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Song, Keesang" <Keesang.Song@amd.com>
Subject: RE: [PATCH v4] build: reduce use of AVX compiler flags
Thread-Topic: [PATCH v4] build: reduce use of AVX compiler flags
Thread-Index: AQHb0LCFssNT35AU5kW6BTDmyPwZVbP6ZSmg
Date: Mon, 9 Jun 2025 06:02:02 +0000
Message-ID: <PH7PR12MB85967617A71099E2F0E5C835826BA@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250325172215.3360590-1-bruce.richardson@intel.com>
 <20250529154249.1310449-1-bruce.richardson@intel.com>
In-Reply-To: <20250529154249.1310449-1-bruce.richardson@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=9fe3a40d-aad2-4f3c-9f2e-b2711d3c1340;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-09T05:56:48Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|CYYPR12MB8732:EE_
x-ms-office365-filtering-correlation-id: a0824d55-e950-42f2-4227-08dda71b2785
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?U+Ds+v9KdmMcAKrL0l38wOewov7UyMBohKt+SR6qoL6hpAfECg8Fr4+qIxbG?=
 =?us-ascii?Q?8WLgbY6bznOi+Mn1fm25kmLp5K8T1mSwFBj/XJfdTw0mQjtNTrQ1WHovT3EI?=
 =?us-ascii?Q?j3zWX0zZ2VmRUTehznc2UZU+sm6GGYBhIR40e/IN1dWVsm3UPsU4qRWJHU3J?=
 =?us-ascii?Q?kX5flV9Gr1cLT5BzaNO5l0P9KSaLXWdpTI1U/M/oxFz8UQ5Q98Zx+LYcccOe?=
 =?us-ascii?Q?OgP1MRAGyQnKPU1FjK1n9aiGdNxTjMZL3hXtSBM9fEb+8f6uzOWM9k1dUrVq?=
 =?us-ascii?Q?6JpKSoOrwn0p1xxAU+euYhoP+G1B5uk+0qDQ4Sp3LAXJOTlmKmnpuizLmkUM?=
 =?us-ascii?Q?POOgTOVMk8gZqbauHuTLDWeWGt5top9YbaccBhWSanmViYvWINj9ApNpfti0?=
 =?us-ascii?Q?poz+HbzpjGEkbMYjB90xnVPKGfkh6Xyy2pqwvy5mSltZ6FzOtUqeZT3t3s/Z?=
 =?us-ascii?Q?MNH23jKyq/2FV2eBMyYZh6t/1LRtAZYPYL0gvBYNvoY6vObwyfKG/m9vVzcM?=
 =?us-ascii?Q?ftv+7fmOBErEOJglfbkhjiNBsovQInB3DvsrzTMtvU5yAo9kVO6xD2/hzpEn?=
 =?us-ascii?Q?2II9q4u7p+5lFTEIaHHdlV4obKgMXamNCuB3clLW196cvBKNyUSm7jr25YPH?=
 =?us-ascii?Q?RbK7RS+mnoH2x/2yb1C3GVCgpxoC0GW3M56ECDkAb/GDNQHI5Hvgq7AqIx6z?=
 =?us-ascii?Q?xu18UkNb/Zjc9KcEyBXgjqy32P2OS9sK5HTX0aJzv9iNY5bmoM2YMqGJM7zN?=
 =?us-ascii?Q?VcU1vUQ/HSb7ynfHvQFmuGqdm2A+ea/q/PjGIZ75ZnaN9MN1+dZVVpcSOFt+?=
 =?us-ascii?Q?SX0jmfjRo1EsLaKrNCPjNAPbBscoQ613r+xyGF6YsTJaPlbs+VCuy9uRTeWE?=
 =?us-ascii?Q?f4+M3Xd5jKSD4RqmdU5UCx7UyGKMXaeMc3dRvIaMPYkT817eBZke/sQtBmZ4?=
 =?us-ascii?Q?LwaijxdK/y8uioyBtY6XOn+6qs6OPzxEAaJen4tvnorCe1CDwOcEPKBovyee?=
 =?us-ascii?Q?5NxiC00MSu/ZRXH33Im/7fS3IEhLSh+9oXXGqY6z8/UJUdO9tYS2MUzKWb9p?=
 =?us-ascii?Q?n7Zm0WAPxKy9fItQ3JCndn7vL9jNiyuboWzLuDvI7uVUn/SUD9b0hkiiksM4?=
 =?us-ascii?Q?UvRM16wz8uTgCRGYzmCbYRlAv5cQLIeVmHEL80Kpn2vlqbnTLkCDohWbOqNZ?=
 =?us-ascii?Q?FiLx3TdtVZqEyssyXa91mUecKbfgJZlAZicxXkXxDmxq+AkM1FEP6S54S/No?=
 =?us-ascii?Q?mqiRjz/DzhVdJt8D/FlFQH9KSY6jDojrJjG/OtHdKHtdYJRCXUk5tkpOBphq?=
 =?us-ascii?Q?SQEs/MQk0WfsoPXb2N1dTljvPK4oqvh2crBi04IPwtUSrF6/BXr7CmF3c6pF?=
 =?us-ascii?Q?sTsvuM00Py5JF8Voy3boChTLKjnk514YuyDx/Hcw4pD/FMK5wq53tiyy12pn?=
 =?us-ascii?Q?RKoU434qS1o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cvI2X6+VuwX72FBjuJJwVhcslDVPgjo9kPWY3yXjpx9rEW//zwVIBuCbbaPo?=
 =?us-ascii?Q?jdCBRyk1vGkS791YTR7GkVP5RnM0uEnsxkmPjBoYLZvnAHK7CrlWmCcqUhax?=
 =?us-ascii?Q?D4Wgo3NR7twxOMaN6MFc2j4v/BQ77JCvWjIeG8mTaOMcxuV3PDc02gR8OfX5?=
 =?us-ascii?Q?pfr+HwzZGkh1HqaYzH/dRKNpWs5ukqgUsdWBl13bGEUm2xigi9T1CWmHotoF?=
 =?us-ascii?Q?xe21YdD15KVLGYAO9RwlPJnaTryc+z8ueeFWlbrNJpnRTVFMRcT1S7M550X6?=
 =?us-ascii?Q?8CzVFmUTUZeZ/q3h7nZ7QXKuzKDKUCJBm5+DgEB4/9xhE0aBxd/tjcBKyhhN?=
 =?us-ascii?Q?yI5otySP6M2gI4HULoadyJl81Us1oadLXPIXriwhptWbZEMGXtyt6zHdaTYQ?=
 =?us-ascii?Q?pbDWRVYLo+Q2Ms7uAmklLyCpyboCaGGleo5U3Cxtdi4AeamzzJorNLMniCCL?=
 =?us-ascii?Q?afID5c3leMlMVZ/WXtMXFfJeAteNuAe/Qf2Y++qt+Pm3UjSjIDMg4f2T1Na4?=
 =?us-ascii?Q?yYml96XOmBGQT0E6Jb0OT9/nNoqkBPcRK1uZB75uTqXmvaK6qDsvzSTSsIqD?=
 =?us-ascii?Q?IcPsL9qUIEcepZzr1J5/AvE2sJa5ToDhMzD+NYCrFDPbCDXz/0G/4XU9t9We?=
 =?us-ascii?Q?2usde54pkjsRzMczXCMy9Xbw4eJpI/8ZPlv1xhOFv6si7WziSIWIaaf0lcSZ?=
 =?us-ascii?Q?+hHXMLPYCrvq3Nhij4MaMaFoEqYn68hspXIyNBWp/uyC/+YUG18cId80mt4k?=
 =?us-ascii?Q?/FQ1lMjK9aXWb/20fqSBuXJIgGFQGPl6RtfESe/odeRvjHpkYJK0YtXQ34hW?=
 =?us-ascii?Q?6fn79C1CfIZjtlrH/VjMwF+IPPFqzKpQEf+u+Tk5LFmaNavBod7KV4iqXaK5?=
 =?us-ascii?Q?bbRCvM9tJtxxiZpGMfLfl3K+wDNEUmuBf+rsap4ewMrL7M5f5Fh7gDtBKyag?=
 =?us-ascii?Q?O18D6TdQMUVxQn6ByMYeQWeXXl1CwzzU7IjmUmw0/WdVLeMBCVOiiTzMlRY6?=
 =?us-ascii?Q?a/T6YX3SPOtfKpb/F+4HV8HhNliPVgucI768fYFxZHNAqvhRgU3Y/VXOdPPp?=
 =?us-ascii?Q?NahyvgMH6GFrDY9d/oIGHRGqEsidg92Gi4mzVh+WQsUQEF2QMBvOizD0m6oJ?=
 =?us-ascii?Q?a2j44qJR+hVYyEBMEYcXTNcAncDb/Pwc/ga+wR4qrc1eOQINWtTrvpsi5tEm?=
 =?us-ascii?Q?9zrUuxcut67VKrM+eNlMmmGTXQuCnEgbeuT9ihpZqs8kejY/YrqDNKS6sWS4?=
 =?us-ascii?Q?7+6++ilf0SSWMT6Xwchb/z0BHxzV9ZAA4NFTuLoNVX1ppRfCfFDBdrnrkZcJ?=
 =?us-ascii?Q?Zup8iHiDzLsp5HaIsXcCxp+FmgTsomVQXM3UvCDxOzVOAYoZoRS2jc2rxQKN?=
 =?us-ascii?Q?zQojVCYyHiB20cQiGD/w3jqCRErPN0VRXZNCKqRbhvHd+JvPFGBO4CeDA5Y2?=
 =?us-ascii?Q?90wvB2DzR5p5PdLCqXEr5E2U+Z2oO9WcGMUeqapVbvy+uS4Gf2WHfifmD+oh?=
 =?us-ascii?Q?R/bYQpiZ0xFhTOXcIbH2qlvZSDcoiA0pxRyg6uH/o5LVQaqhbcMOVrju2rrS?=
 =?us-ascii?Q?V+veSLD10euoFI5/XEM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0824d55-e950-42f2-4227-08dda71b2785
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 06:02:02.5167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: APXiIUU3uiR+Pmou3WOawOH9102UxnH3zvzwds6kWmYEyp+33J7BfbXxNSYsi6y/na6aqKvxZtERlkY6/A4Z2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8732
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

Snipped

>
>
> When doing a build for a target that already has the instruction sets for
> AVX2/AVX512 enabled, skip emitting the AVX compiler flags, or the
> skylake-avx512 '-march' flags, as they are unnecessary. Instead, when the=
 default
> flags produce the desired output, just use them unmodified, and don't bot=
her adding
> in extra enabling flags for AVX2 or AVX-512.
>
> Depends-on: series-35006 ("doc/linux_gsg: update recommended compiler
> versions")
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
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
>     now a separate patch/series [series 35006 referenced above]
>
> ---
>  config/x86/meson.build | 31 ++++++++++++++++++++-----------
>  drivers/meson.build    |  9 +--------
>  lib/meson.build        |  9 +--------
>  3 files changed, 22 insertions(+), 27 deletions(-)
>
> diff --git a/config/x86/meson.build b/config/x86/meson.build index
> c3564b0011..e6612dbd80 100644
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
> @@ -65,26 +67,33 @@ if is_linux or cc.get_id() =3D=3D 'gcc'
>      endif
>  endif
>
> -cc_avx512_flags =3D ['-mavx512f', '-mavx512vl', '-mavx512dq', '-mavx512b=
w', '-
> mavx512cd'] -if (binutils_ok and cc.has_multi_arguments(cc_avx512_flags)
> +avx512_march_flag =3D '-march=3Dskylake-avx512'
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

Hi Bruce, we have reviewed this internally and tested the same. We would li=
ke your thought for the following.

- Before patch: we were directly setting AVX512 falgs for F, BW, DQ, VL
- new patch: we are setting the flags for `skylake-server` as bare minimal.
- AMD supports AVX512 from `znver4 and higher`.

As per GCC `https://gcc.gnu.org/onlinedocs/gcc/x86-Options.html`, the extra=
 ISA supported between skylake-server (super set) and znver4 and znver5 are=
 `SAHF, FXSR, XSAVE, RDRND, LZCNT, HLE, PREFETCHW, SGX`.
Currently for DPDK microbenchmarks and examples runs safe as it is not usin=
g the `SAHF, FXSR, XSAVE, RDRND, LZCNT, HLE, PREFETCHW, SGX` instructions.

Question: should we check if target is `AMD EPYC` then apply bare minimum a=
s `-march=3Dznver4`, thus avoid possible unsupported instruction generation=
 when non `c_args for march` is passed?

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
> diff --git a/drivers/meson.build b/drivers/meson.build index
> b0850bbb24..51c824ea40 100644
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
> diff --git a/lib/meson.build b/lib/meson.build index 41fd98f4e9..16389b9c=
34 100644
> --- a/lib/meson.build
> +++ b/lib/meson.build
> @@ -260,18 +260,11 @@ foreach l:libraries
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

