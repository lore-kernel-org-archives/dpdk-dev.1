Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74BEC5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 11:59:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E37340A6C;
	Mon,  9 Jun 2025 13:59:21 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by mails.dpdk.org (Postfix) with ESMTP id C5A514060F
 for <dev@dpdk.org>; Mon,  9 Jun 2025 13:59:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQWNcTS87ttHMD4XPzsEXIhMrUEdQotiZaTtNzJDfdR7jg8J8ZENOz+QRK4Bhh37vo2A2ruO1vkLEpDnxO5yD1zypns5ScPFaruZ6AwfzUktWTY6JwgxnCPITEfhd3UGXTlsCizET/2GalOF3Q8XWV6QTcKe8xual4QeU7bVcVPiyIWFta2Fd930/z0yPmVHLo9LHtU3aMic1hbkIMtVLkgll3V6lUyXq4dYD6F5pC4Ff2i/BMO0Vfr0PwzG5fC4hstlYtytqF+jOOO7yoRa/D3wNIaLvr5PrtZ0Y/AX4ACrgdgQmMjwbwj0uXYPhKxDg8CXog15Lo1TWV016RsYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3MEmdS4Q1fn6Sxvyc9A6ESUFa5D4wvHoWXXc8ZEGlk=;
 b=MfBpB7/4+nPQOTpImrT0R5Nqhur6xghG+Ko5LwU+rEdtDZhucbZWJALKmh8RGKZXac99roRy+dWsXUWKsXbIqn+XZv0RdX+E/D+75cSrF3oqdwWuBJbv3YI2p2t7LkcTqY25UJ0k9P5lmLpei/HofXwETLT7A5CN9ZdVQ3h3BvysQ+edwBA48L4/7XmD/7yvim/sA4XHuka+Aix4WGDgzze9NBINoO9g2XrdXt3vdZNaAevII4Y6c+SgM/DSIpxr3SDhfNJm2hibgNT0mXoQRDgFs1LkbzQ511fHqrPRMbnkYK6wEH0rC1D/wuo3IXHDYwrWe2wRJM2mPOYOLyYZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3MEmdS4Q1fn6Sxvyc9A6ESUFa5D4wvHoWXXc8ZEGlk=;
 b=kPqE8l+SCCgNuOLLK+0yocwmJRa038LVkSScH6l4pB2bf+dUFtVGMdkcqb+RJcnMH1wbRZjGB9CFoO/XJBweUrSsCPFo2uPnOKPn4oHQjsWBOSth0sVpYxVUaPR5nWXtBJZQsruST7jCvAyqwjCWNMjiup9QCEXSoH2q97bPn7c=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by CY5PR12MB6528.namprd12.prod.outlook.com (2603:10b6:930:43::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.41; Mon, 9 Jun
 2025 11:59:15 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%5]) with mapi id 15.20.8792.034; Mon, 9 Jun 2025
 11:59:15 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Song, Keesang" <Keesang.Song@amd.com>
Subject: RE: [PATCH v4] build: reduce use of AVX compiler flags
Thread-Topic: [PATCH v4] build: reduce use of AVX compiler flags
Thread-Index: AQHb0LCFssNT35AU5kW6BTDmyPwZVbP6ZSmggAAh4ICAAEGXQA==
Date: Mon, 9 Jun 2025 11:59:15 +0000
Message-ID: <PH7PR12MB85969B5D596151F83DA09600826BA@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250325172215.3360590-1-bruce.richardson@intel.com>
 <20250529154249.1310449-1-bruce.richardson@intel.com>
 <PH7PR12MB85967617A71099E2F0E5C835826BA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <aEaUA7rDVyPJEvP7@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aEaUA7rDVyPJEvP7@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5344a98f-071e-4580-8d5a-e013b1d6bdd8;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-09T11:52:40Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|CY5PR12MB6528:EE_
x-ms-office365-filtering-correlation-id: f60bdfd4-9756-4218-2c8c-08dda74d0e68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?yg7NPPEXsf98qpgpSccRn7RQ/XrWGdrE6QvO5fmaxuzeFvjZA+0uJVK7ERzX?=
 =?us-ascii?Q?oMEjMnXUN+x0yyzRox+weWNt795+8wdUuevU4ICsBdQAraO7PIGcmoCI9nOC?=
 =?us-ascii?Q?QJt3xbV18JsFboPuIkBR6pSo0jWsZx+ArD9p2w52zlGTX+RjULF3I0+BQ1a6?=
 =?us-ascii?Q?hGZzL5/KJx6C7Pt6fAkd0m1w4l/1z5I9e2w7a1SbQ2opqNtLCLRy96O+KAWs?=
 =?us-ascii?Q?qmsIDrQ1e6Vx4of162KuHYM6KZARKDNCmabagoagukDvThOyMf8/bCoKD0fb?=
 =?us-ascii?Q?K0VKlpqdu6QhwvgYl1Lk9aGNYAjv/78kQbKohcojSnz3cnUljWwOvuCMHync?=
 =?us-ascii?Q?4bx1XyY+9qITiR53vWPYR1q+KmV9a/BnEd+bUUGUye2Buzr+xz8P5FW/ZLC1?=
 =?us-ascii?Q?HfRyCVUx+aG8fz3DtoxkA/GGOi2tsugfJtDIBlWMf20sZ5Vnz0h1E1AswI/5?=
 =?us-ascii?Q?AMr63LMdoQaXEZew1pcuWD/Ruc2MWD7GzcmBHchGOHUywxBQ5EuHailpqz2r?=
 =?us-ascii?Q?5AQHgtC3M6mcOkl33VOXuCkW4cHWNBPY9t0p60bpMYlvyzPzoZ3gBkm8AdJo?=
 =?us-ascii?Q?sAxOVWqoksnFK1maA3zryn4uYDUG75YiyQkraS2BWld8we0hry7nK5Ux7Ipv?=
 =?us-ascii?Q?3PxlhKxUkLni06Ad55k4zuFN/kEkFK+vXZb27dRuwRWAO9QrmUgziLhfryWL?=
 =?us-ascii?Q?cuWnBYZPU8ddBE2uFfRSpimqj0Z5Z6B6TMo1YRKASf/Aq5ci7Q4Fbu/ailKd?=
 =?us-ascii?Q?g5jwapFtI/juPcFzIPsO9Abk2QnuW95RkKlcoSaqIXvLSjNjFyoVJWPsstOy?=
 =?us-ascii?Q?hZgevmAirVFcA9Sbhi0OII5CXqsAP0dWleGmwvHNYMq5O6HoZDBT05ryRc8p?=
 =?us-ascii?Q?V/EujUJUAhtpPp4QsYNLF3hoSgjPxX+G5B82zol21LnnglNoQXfHRt1k98NZ?=
 =?us-ascii?Q?gwDSLPBxo7uygbXY3fQLcRb6zL33pywWSAo7Wf1PEFfBCr/Sn0iCnXaLVoGC?=
 =?us-ascii?Q?F6wwajuebGVdzc+R1yMu8w0omu+WqzO5y92ApM45rNSqSQ2vwbDY1WjLjwSR?=
 =?us-ascii?Q?rvtD0NbTsNakwnVn9H71gyPOOGGKGQ+ftEyunpbHG++0rvyYTQ4NMLCU6i+O?=
 =?us-ascii?Q?nwKf4gcSThPAp5yTNBLF0jPqYtq9csA2a5DWtWzCZ4A3CeJuoeJefM2R8Mq4?=
 =?us-ascii?Q?XtmFkWgfFXPIXizYHLzBUjVpXXqurQd9+4LhjjLUVkiD97wGA3LO7rhsMy1i?=
 =?us-ascii?Q?vor5fTH+Y+bwyf/KS+YF8tFuJvZql404aR8PVw2GwoDp4RNjO0+sg5ilI/A3?=
 =?us-ascii?Q?cgFgQJ+eX/KFcw5d586tQIrhN2k5lgMMx0IWi//LJleYAxD2rjUmuFgtR+Oq?=
 =?us-ascii?Q?dZhRxdGCpLKOFx2heuGlyWDGuw97RjG6uIOsmIyB0naypwH7U72xyXrxEVWq?=
 =?us-ascii?Q?pFBbk11z8c4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ltRvsr/04PlatdsMlRuzJ3rb2o9rEPzG3nAk0AAze2++XXx/GM5OTM1p40JU?=
 =?us-ascii?Q?CnYebpp8vs6h3YocynPtH2tXXpcKmzvwild+NV+0mZWZRKWSl5iEeEn/VmyK?=
 =?us-ascii?Q?m3ZHacuO2H2YS/DQIggokSnrgV8CC6mOIbrSlvPiFEDWS+PdyJ4ZJnQOyWE4?=
 =?us-ascii?Q?JRApwIG7wcpl2W9cXY0xfVLZLRZPtlLtKja3CfGzhbO5+SaUWarTEVmP6OKU?=
 =?us-ascii?Q?cpthXaHyrsWSwEt4qXAlgiDuu8olTEfVh3JfSgYA0h4xafnl82OdJRnHZ4HN?=
 =?us-ascii?Q?FB+kj4yjis40WbwJilZ2I1iTdodj6RszA3/pKacFWmPSAeJ43rEfzaTEQ/md?=
 =?us-ascii?Q?QSHUdfNhGsHAmia/KoYC8qS9O4leSK4CxytzIxp7zAc2aclCM5gitSElW7ej?=
 =?us-ascii?Q?jhlQORaVspucWsjxQkNOxXmtvnO7nhsjUiNEoVDz1Py7SHZWLu/zp6xDAjyr?=
 =?us-ascii?Q?FN8jDiNF6Ijk9QYFYKCNxWP4SpbUOkJsBY4IoBzUvCjEBqIOP6aWccDBBgsb?=
 =?us-ascii?Q?g7kFAjQXEWqjKrsOuwX8II/BgYDv6sisAcb3+dA7ARDUfaFixw/5xClF5Kcv?=
 =?us-ascii?Q?VTXW/zph2e4LuOhTf/QxFheHVcg3cQBWvjGK0tfuMdrOL8WtTJ/GKmPZl2aR?=
 =?us-ascii?Q?eBKyjRfT4561B7gTEsqRGCwlUzWxJoa9yAitU2MI5z2DTRZien8ZpML2bpds?=
 =?us-ascii?Q?ryMgxClsQMjoHIO2VZ2V8CJW6aYXR50YoqsoObJ2w2ejw5K9UcGWJoiv2dWr?=
 =?us-ascii?Q?feKyTBeta0MFNK9amW086r/ZRVHvwKeMMVmwunh8gNr3DGv6Z+ypQjLBOQft?=
 =?us-ascii?Q?0Fpd0z7pdvYJ2zW1r6k4MSZlpxwA7SP59YL5cBc00p+OzstOht9aGepLq/DZ?=
 =?us-ascii?Q?tYMd6muRoHIbRRSagUDWxV1rijMAoIiykqcE4mZH8I7EEUxmJvBDxpJp4b3Z?=
 =?us-ascii?Q?Y6mQPu4N+mtKeRI+gDUfuqMBFU9vxsMWx6LNxE39inB8f0pTVktsskW3A3Nd?=
 =?us-ascii?Q?64EUGisYHhDofHGxPofuCgJ+nOMygz8lTTosFKnlAUXfTNDDGnExHD9sZx39?=
 =?us-ascii?Q?+TMUUMMoM+tCvy1lMUC6PB1ncDzEMEQyk3K8NxZ9uF/qlABffz4FxGFee59Y?=
 =?us-ascii?Q?JQYxAwS3N0oBotYqcdanhv6HvF2I5oeGaglyo6uxpb3prnalExITKNREi1f1?=
 =?us-ascii?Q?/beSS84fYO6t8DCY4uZDHzo/sMP4JwI347TAApjwb0FoyH5lDp/tZx4dIQDQ?=
 =?us-ascii?Q?45/Em1d5iWI5lLaR09YxDfXr0WIHPrUE6LvC5u0d17ZL8gUITyd3bfNzXYgY?=
 =?us-ascii?Q?evUVJhU6tPOeEOE+kxkDwCVdwjVRZac/4mfQmmPeqsxp9Cml7lCrNTWemdCV?=
 =?us-ascii?Q?KB1hJdO2d0Mf+sO7dDLQjmVSo1QqF67NjIuLm8ZmvbD7nrudz0U/QBWvoZlJ?=
 =?us-ascii?Q?ekRioV1+5vWbB7mp/6Oop2D858TXovHC6ExjkSfXtA+cDT/JkNuiKE9d+qrK?=
 =?us-ascii?Q?RKQACZgUuq/KLCqLvRDB7YM5qkNVKTxn6TV2UAv+uzwetGFjvOk6wNFVEjbh?=
 =?us-ascii?Q?gwznXYWHWAJTMHvpAjQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f60bdfd4-9756-4218-2c8c-08dda74d0e68
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 11:59:15.2202 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u8GOtSZ5QnijXaVFf3w+0zwZJQTWWw65FcFi5uJ0h//0wPCkl2cqtfE66EbU4OeXF/JjdC/2YVe/YE7dZ4EUWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6528
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

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Bruce Richardson <bruce.richardson@intel.com>
> Sent: Monday, June 9, 2025 1:28 PM
> To: Varghese, Vipin <Vipin.Varghese@amd.com>
> Cc: dev@dpdk.org; Song, Keesang <Keesang.Song@amd.com>
> Subject: Re: [PATCH v4] build: reduce use of AVX compiler flags
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Mon, Jun 09, 2025 at 06:02:02AM +0000, Varghese, Vipin wrote:
> > [Public]
> >
> > Snipped
> >
> > >
> > >
> > > When doing a build for a target that already has the instruction
> > > sets for
> > > AVX2/AVX512 enabled, skip emitting the AVX compiler flags, or the
> > > skylake-avx512 '-march' flags, as they are unnecessary. Instead,
> > > when the default flags produce the desired output, just use them
> > > unmodified, and don't bother adding in extra enabling flags for AVX2 =
or AVX-512.
> > >
> > > Depends-on: series-35006 ("doc/linux_gsg: update recommended
> > > compiler
> > > versions")
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > ---
> > >
> > > V4: Fix error flagged by CI with clang builds without AVX512 - change
> > >     "cc_avx512_args" to correct "cc_avx512_flags"
> > >
> > > V3: put in version check to work around an issues with some meson
> > >     versions, (hopefully) allowing builds to pass in all CIs. The
> > >     printout of the extra flags now only happens with meson >=3D
> > > 0.60.2
> > >
> > > V2: dropped the doc update for the minimum compiler version.  Based o=
n
> > >     discussion, that version bump is larger than proposed in RFC and =
is
> > >     now a separate patch/series [series 35006 referenced above]
> > >
> > > ---
> > >  config/x86/meson.build | 31 ++++++++++++++++++++-----------
> > >  drivers/meson.build    |  9 +--------
> > >  lib/meson.build        |  9 +--------
> > >  3 files changed, 22 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/config/x86/meson.build b/config/x86/meson.build index
> > > c3564b0011..e6612dbd80 100644
> > > --- a/config/x86/meson.build
> > > +++ b/config/x86/meson.build
> > > @@ -4,11 +4,13 @@
> > >  if is_ms_compiler
> > >      cc_avx2_flags =3D ['/arch:AVX2']
> > >  else
> > > -    cc_avx2_flags =3D ['-mavx2']
> > > +    cc_avx2_flags =3D []
> > > +    if cc.get_define('__AVX2__', args: machine_args) =3D=3D ''
> > > +        cc_avx2_flags =3D ['-mavx2']
> > > +    endif
> > >  endif
> > >
> > >  cc_has_avx512 =3D false
> > > -target_has_avx512 =3D false
> > >
> > >  dpdk_conf.set('RTE_ARCH_X86', 1)
> > >  if dpdk_conf.get('RTE_ARCH_64')
> > > @@ -65,26 +67,33 @@ if is_linux or cc.get_id() =3D=3D 'gcc'
> > >      endif
> > >  endif
> > >
> > > -cc_avx512_flags =3D ['-mavx512f', '-mavx512vl', '-mavx512dq',
> > > '-mavx512bw', '- mavx512cd'] -if (binutils_ok and
> > > cc.has_multi_arguments(cc_avx512_flags)
> > > +avx512_march_flag =3D '-march=3Dskylake-avx512'
> > > +cc_avx512_flags =3D []
> > > +if (binutils_ok and cc.has_argument(avx512_march_flag)
> > >          and '-mno-avx512f' not in get_option('c_args'))
> > >      # check if compiler is working with _mm512_extracti64x4_epi64
> > >      # Ref: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D82887
> > >      code =3D '''#include <immintrin.h>
> > >      void test(__m512i zmm){
> > >          __m256i ymm =3D _mm512_extracti64x4_epi64(zmm, 0);}'''
> > > -    result =3D cc.compiles(code, args : cc_avx512_flags, name : 'AVX=
512
> checking')
> > > +    result =3D cc.compiles(code, args : [avx512_march_flag], name :
> > > + 'AVX512 checking')
> > >      if result =3D=3D false
> > >          machine_args +=3D '-mno-avx512f'
> > >          warning('Broken _mm512_extracti64x4_epi64, disabling AVX512 =
support')
> > >      else
> > >          cc_has_avx512 =3D true
> > > -        target_has_avx512 =3D (
> > > -                cc.get_define('__AVX512F__', args: machine_args) !=
=3D '' and
> > > -                cc.get_define('__AVX512BW__', args: machine_args) !=
=3D '' and
> > > -                cc.get_define('__AVX512DQ__', args: machine_args) !=
=3D '' and
> > > -                cc.get_define('__AVX512VL__', args: machine_args) !=
=3D ''
> > > -            )
> > > +        if cc.get_define('__AVX512F__', args: machine_args) =3D=3D '=
'
> > > +            cc_avx512_flags =3D [avx512_march_flag]
> >
> > Hi Bruce, we have reviewed this internally and tested the same. We woul=
d like
> your thought for the following.
> >
> > - Before patch: we were directly setting AVX512 falgs for F, BW, DQ,
> > VL
> > - new patch: we are setting the flags for `skylake-server` as bare mini=
mal.
> > - AMD supports AVX512 from `znver4 and higher`.
> >
> > As per GCC `https://gcc.gnu.org/onlinedocs/gcc/x86-Options.html`, the e=
xtra ISA
> supported between skylake-server (super set) and znver4 and znver5 are `S=
AHF,
> FXSR, XSAVE, RDRND, LZCNT, HLE, PREFETCHW, SGX`.
> > Currently for DPDK microbenchmarks and examples runs safe as it is not =
using
> the `SAHF, FXSR, XSAVE, RDRND, LZCNT, HLE, PREFETCHW, SGX`
> instructions.
> >
> > Question: should we check if target is `AMD EPYC` then apply bare minim=
um as
> `-march=3Dznver4`, thus avoid possible unsupported instruction generation=
 when non
> `c_args for march` is passed?
> >
>
> Can you clarify why you mean by the "target" here? Is there a specific va=
lue you
> are thinking of for the "cpu_instruction_set" option?

`Target` is target CPU, when generated without any arguments we get code fo=
r `native build`.

On AMD target cpu zen4 or zen5; Before patch as per the code ` AVX512 flags=
 for F, BW, DQ` are used in ` cc_avx512_flags`.

With the patch, the cc_avx512_flags is set to `-march=3Dskylake-avx512` (wh=
ere compiler optimizations `can add HLE, PREFETCHW, SGX`).

Note: in our current testing for dpdk app and a few examples, we have not e=
ncountered the same yet. But there might be projects where compiler may add=
 those instructions which are unsupported in `AMD EPYC`.

Hence the question we are asking is, `should we check if target is AMD-EPYC=
, if yes use -march=3Dznver4 instead of -march=3Dskylake-server`?

>
> /Bruce
