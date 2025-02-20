Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAE0C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 15:40:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C2A0402CF;
	Thu, 20 Feb 2025 16:40:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 29C6B402B2
 for <dev@dpdk.org>; Thu, 20 Feb 2025 16:40:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740066039; x=1771602039;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=o8ueg2P3JI4ftLojGOxNbA05Ck0eLu8WzZWgJ/mzzDg=;
 b=LCbNv1yO9u00skO9NIPUgnI6OM1MmLdkh0iIFj/l17W/wvUvKvIu7OMr
 keknlQX9ePSyR5xjMwAi+ziuI4Hl7Da4bhEDewWl9924SrkuVxq0X93bI
 lKzigiZWYc2qAwiIXu5hy6mLTli9axHIkrseRwt6ZDYpwFnIcmWkPh9HU
 m8xXkhyhcK8EFMu07LUibKCWDRsE+WBaA15O1yCLem2y/dvlcHTdzDiil
 qL4a28hCGbIpelOlRy8DZkTe/LnOKG1PwGFBbno4+fC1rzU4TpneDfRcP
 KruQ9OqEHyOvoh+66QwrINXB2oniGukAFMEHdcLAtiwtfL62VgvHd8gQr A==;
X-CSE-ConnectionGUID: uh38i0INTDaEG+UmG2h78A==
X-CSE-MsgGUID: 9u8C9vKWQJaIdwjZbO49SA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41060493"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="41060493"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 07:40:38 -0800
X-CSE-ConnectionGUID: 8SLRkpq5QXS73Aaj1OwrqA==
X-CSE-MsgGUID: F14neDPeSEGQLHaHejzR5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; d="scan'208";a="115289807"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Feb 2025 07:40:38 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Feb 2025 07:40:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 07:40:37 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 07:40:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0wmAT5sv6up64/f2cq5HzIOu4iJ6f4oMErooLoEVjG3rMh0T/utdRiH9Y9orMOfX2lCEeWELGftRx/jA26+zidXw2ZqqPCXgDhNQzlTqxGW+ljvrGNOXC0wWE6yUnG6xeIvHGEdCPaYDbGqPhMXmlJ1A550qwwrXNa/Jm+Gp4A3xFUV22VVc58CwRo1WVZE4D+V73+h8/NBl9b5Cubilcuq/A26znYl/BuxVKN2EUBh+LZ8WGLhOAyWpsalXQqgUv0PirXpt5oax+8s0WN1XgL5SKyZfM2XCARhiAgiQKdtY78AMQXB5dtDI/d1ck/N/vJ1ZYvIZiXvgWbGalHU8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxGMjNovh/NNPeeJdSCAu8n4UyI/PLKYPRXYk9coqjY=;
 b=aRQr4vJv7oyTjvIParIw1HlcnrrUmBjNFs1FJBtpJ68PIdXLP5uA/9ArNQxqcCcYR/X6VHYmD1uvDPkHaiEd3p1MjwNV/C9uF7fhz0SeYdkGnBp9RyrBZx4clkNgpJU6q4mYJRfDErZMR/7haSDWrVhbG2ZFZ6ekuyyvbh5zZoxZNSWRMI1f6fdHfNxRMORDMy4nvyTqFbG35ap0VDjAUYIg95wmy0ZR0276MqYlg+Lpcsa0kF4PK9sk9j2Rn8TDtx/89Ehn1p7bnZYb8Pw9ivT+RjzYLmII8viRT35JCX1rN+MxjWiiLOCVeQ/EPQmnefy9Lt8Kx3fTHmRQyzPRrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5591.namprd11.prod.outlook.com (2603:10b6:8:38::23) by
 SA2PR11MB4892.namprd11.prod.outlook.com (2603:10b6:806:f9::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Thu, 20 Feb 2025 15:40:11 +0000
Received: from DM8PR11MB5591.namprd11.prod.outlook.com
 ([fe80::4d18:36da:367b:5e82]) by DM8PR11MB5591.namprd11.prod.outlook.com
 ([fe80::4d18:36da:367b:5e82%7]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 15:40:11 +0000
From: "De Lara Guarch, Pablo" <pablo.de.lara.guarch@intel.com>
To: "Dooley, Brian" <brian.dooley@intel.com>, Akhil Goyal
 <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Ji, Kai" <kai.ji@intel.com>
Subject: RE: [PATCH v4 2/3] cryptodev: add SM4 GCM
Thread-Topic: [PATCH v4 2/3] cryptodev: add SM4 GCM
Thread-Index: AQHbgsR7Pnl1agc0eEicwmO58jBP4rNQVdfQ
Date: Thu, 20 Feb 2025 15:40:11 +0000
Message-ID: <DM8PR11MB55916FB49B2FAA8CD378F2C484C42@DM8PR11MB5591.namprd11.prod.outlook.com>
References: <20241213125850.2714328-1-brian.dooley@intel.com>
 <20250219115001.1047145-1-brian.dooley@intel.com>
 <20250219115001.1047145-2-brian.dooley@intel.com>
In-Reply-To: <20250219115001.1047145-2-brian.dooley@intel.com>
Accept-Language: en-US, en-IE, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5591:EE_|SA2PR11MB4892:EE_
x-ms-office365-filtering-correlation-id: 259f88a5-996e-469a-6695-08dd51c4dcb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?JCm4O4kTPwT16O9D0NOCkifRzdw4G0EtlvDlB33WJcSuZIKi5E5QWLZhIny9?=
 =?us-ascii?Q?ZnM00ssaqlKHPv/aHz/hExr70i0zbR0Ica9PWNj1tzZh5f0mEQC3SFGFsMs/?=
 =?us-ascii?Q?xi9TdGW914V4yuwjQTkOBT4m9E3ITRyz391FDXc1H3jP8v+NlhvEQqg0YBJ4?=
 =?us-ascii?Q?F7XwjdUH3u5Eu/3Eaazc2uFWJyAiJKpJibkQ7c36fVpNgwxMyUgtE11Wc3mI?=
 =?us-ascii?Q?tBn2oilZ635jW7/MEprzLficdk0IXOnhW+TcHLEMnCcxVMsl2bTwd9YVC9ta?=
 =?us-ascii?Q?0NIi3Ohky9bQTGGxRB/cFEOBF4/x5vpP519KI/kmiopHvmAbr0Tm/KSBEd8T?=
 =?us-ascii?Q?9cj4mBohLycuMxoo1D9hF9v2vNDEym+v3X11jLTHySKKA4DJm2Ck/nERywBI?=
 =?us-ascii?Q?mET8QKGAhrH4Q96Ewjbo3zlK/6ukuS/eWkQdgQBp0T4SN0G6Fn+/Q1iukqNI?=
 =?us-ascii?Q?46K3pJjCPxBFC/57hv842h3YkeEaAnGLzlxgItQAEfkTPW7zrqCeKWUUiYna?=
 =?us-ascii?Q?msr4+1FtynTuxa6ush93G08yLNqkERNNQiwiehuFvEBZeropI6P9vJ5BW8Vv?=
 =?us-ascii?Q?l9u0yej5fsX42EetkAmKJ+2F0EkB11e7ZpFVroGg4tzE0f9+mVqFX0yHrSjX?=
 =?us-ascii?Q?6eUGGfWtjnnyWGJjSQ/nW35qxFK6H/Mm2GbM76RH0yVpxcYGz2IRMamHkuJB?=
 =?us-ascii?Q?/uGHtKQgNRqWRp675rHYl3c7j1R4yi2UBMyV2jOidd+p9KGoZbCZrXPiUxql?=
 =?us-ascii?Q?MvtKYf9xTjKrQR0pYFEwFFDpWkkGGgBgHsA5joBxtJs+PFXB+gxCPElvlTLs?=
 =?us-ascii?Q?I4JPJHrnWgGEfYvHigyyjQ0M1QmhoKcBiXBEyyQQEnd5d622mH24q73h6gDj?=
 =?us-ascii?Q?CtL6V0tHZw7SzE6yn2ISorhtfGQVKEG5I0iuD4U/9wFWxLDePeoimfiLfHuG?=
 =?us-ascii?Q?ut5dafrEsnHaP+OvDe7wL/iJ38qI+8DV4lCzSmyr7H/FKNQ4s3FG0bmo3IZ8?=
 =?us-ascii?Q?T50O9oRlJUqu8Le3MYjZvuVOtEoTRZwSLYrNM8a+JjuBgg/U/Yuciiw29s1+?=
 =?us-ascii?Q?J6I4gRphuJA6LKudaH8EmhR2CK0eVTJIlfx8K1Mc1H38kiUFnLSN/8HmGFWM?=
 =?us-ascii?Q?kmek9eS+WGkBmxm73V/stwRtq5vBmVSJYsRELxPxCMRCew3jlzi+PeHUzhYJ?=
 =?us-ascii?Q?tPh6F9M5nNl6cW8CQAT4W5XEibfTvp/FIRXLRfM9LJvDPfkFP4zoQJ7F5by+?=
 =?us-ascii?Q?2ymm9xfXOsKk7V9/meyN8Q22GIsC553E838EIbWhlSgXw+fYV8Jd8jToBO9l?=
 =?us-ascii?Q?KUTTZEIwj9ul2FlYnUnvIgrS81XvV0hdXIfWTmcA/yazEcXEsOn61zb4b+uk?=
 =?us-ascii?Q?LAJEErCkBBUDXHziHu06tkBVSgePoR7IsE0IPNrSeEHEK1wSp585Z+VfLhUR?=
 =?us-ascii?Q?5TOGTg2wdQH7pz0hlCXmgoZfQti9T1Zn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5591.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OnHiakMyr06sKDKLBf8m/DJpHm0Bts+amheJ2bi9OCsQ2o5onxOcUf6ypFlF?=
 =?us-ascii?Q?bNvkFMzZtw2BWgy40hbO7SbVDlGiMCiSon76y+/3zzOBVQyq6qNy+aKbu47Z?=
 =?us-ascii?Q?QxTiWy64jasgbVhIefXQ2uHaJ5cOM3ZhMpLE9M8WXtYeOiSjl5jIyNehM2KU?=
 =?us-ascii?Q?Zr/nn5bAuhqFvwjgXt6QzFH8GLvz2evUr/X3VUgPGFSbJT60/jVZeugfe7Pd?=
 =?us-ascii?Q?0EQLqiCGKiBvmS7zmiWS3RQx7AGUv/W2BSlFbKzaShJtTb2a0iMdzN9kWWeJ?=
 =?us-ascii?Q?JK1jpfvAY2zX9X+5SL0eC3+eH0Dl6LtnEhP1HiwT4d4IXe5WvKIGFCYuP5ql?=
 =?us-ascii?Q?gQX4cwo3AjibDND6hBOXHPPT4EW4A18nm3VvxPTs0oRUEkzH7250qQHoOqQO?=
 =?us-ascii?Q?nKQPmPpKwb+UKnp+6yqjC+2MiUaf68e2M02DqIHnwu0aZyqE85U2Zk+gJzg7?=
 =?us-ascii?Q?34b0gMJLkfg8H7ioAJdQ3p5++wougSbCKEM5Qx9+ZK0/56ODD10lMYePi1IW?=
 =?us-ascii?Q?tv4RwJ2uhHmZsYL/D7IGMP7I7495mO9eU5Akh/d7e8A4Yf3TGCCrjA1afrxE?=
 =?us-ascii?Q?LhSJQhF8k0xJmX45lhhJ29a+g9DzVxWnYzlMfgRQiAc9XAzL/WjKhAk6kKvh?=
 =?us-ascii?Q?uF88uM0WJRKC9w3Q/ReIf1Hkcv+fTCGJo1Exs3nfKtTtryPh5zFTUgQrEVi0?=
 =?us-ascii?Q?V5HNLoBx2IL4aEmjwOJK11HTbtOnzQIpmrPsH6/NvU4R7U1qFWwzwcHQ9eoF?=
 =?us-ascii?Q?92xVFlB21KhRQESmNRp2FICBya9xhZJtU4mpUtRn/ezzRqE4eIqu8M2YD5/4?=
 =?us-ascii?Q?LJBaiFsXU/l8hjkTNtlvXWtymhbCPZKR7uRgWTv2OasX7/C2ZHMB7HuN4EOX?=
 =?us-ascii?Q?m4bNGM0hP4IroUU6S7w60K0Pw+zQKA5G2KtG3ZCs/851DUS3x9amS8F0Hdfz?=
 =?us-ascii?Q?jQ6G0cEBCA1xQ/JRZW7XNTL/iz7cmoSDnxOTDfIzao4UFfVmFSLv7oPYUJRV?=
 =?us-ascii?Q?RCTHKgIQHSM64QqmxrcLPjboDn3rpmJXvNpBU31vzW2etxRUkt5K+xJWYWNM?=
 =?us-ascii?Q?mGyIihJptpM0RJrk5FSBxjBQAWa178iG12u9ix+IEEx0cO8mnRWTiRxGPWxJ?=
 =?us-ascii?Q?gWFmQF1zNKehd5hFacIOr2Flc5XT50W1D0Le3NesYu06L3EikdNcwAB5wj8d?=
 =?us-ascii?Q?XJ+DCvIpFarW8ScoF2V7Mz20riLFfvb6FvXeTj9KU1GaXV3x3hdzBedfe78e?=
 =?us-ascii?Q?iFWK3olK/AvWWXIpqsRC+hN/gn49j2fUf/yaqve3VXQO34OF9CrltVsI30xJ?=
 =?us-ascii?Q?IO9hgdKLda4K76WRaqYCQNrfRygr6mSmBfGC8taB6cHcC6TrXHNlxrHKmaJv?=
 =?us-ascii?Q?ZN8nfth3r5tSu8VuwMHF1eAvJJIZqI3W/oSierUzSBhsvK8PEu+u+qx/24kT?=
 =?us-ascii?Q?x9WBvBSwlP7BfCl9UU7MNagfrD+Ar/UMthg0QlJp1DwNBK7pgJDtZqGWcD0R?=
 =?us-ascii?Q?3tZXBE3j95b9Gb9K3cjY131ZJqloHsPeAWgUsJZop5G9VQPX++szaihzyNC+?=
 =?us-ascii?Q?3gM9xGJgpFBjHmKEd2OTCIC6rKbr/Qo9fULlSWkybr8St+F2Rra6fYGyi1ie?=
 =?us-ascii?Q?RA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5591.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259f88a5-996e-469a-6695-08dd51c4dcb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 15:40:11.4057 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Z+b3uWtQmJif16SfIHrHYhF+FSjnVfywlLBijNmwXnH7eRH8zo27Xz0Kb7oKvStV8NHMOy+PMqSAIG5GfPuk4/+2sFVcdNHX7QwOn1sEz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4892
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
> From: Dooley, Brian <brian.dooley@intel.com>
> Sent: Wednesday, February 19, 2025 12:50 PM
> To: Akhil Goyal <gakhil@marvell.com>; Fan Zhang <fanzhang.oss@gmail.com>
> Cc: dev@dpdk.org; Ji, Kai <kai.ji@intel.com>; De Lara Guarch, Pablo
> <pablo.de.lara.guarch@intel.com>; Dooley, Brian <brian.dooley@intel.com>
> Subject: [PATCH v4 2/3] cryptodev: add SM4 GCM
>=20
> Added support for symmetric algorithm SM4 GCM in cryptodev.
>=20
> Signed-off-by: Brian Dooley <brian.dooley@intel.com>
> ---
>  doc/guides/cryptodevs/features/default.ini | 2 ++
>  lib/cryptodev/rte_crypto_sym.h             | 4 +++-
>  lib/cryptodev/rte_cryptodev.c              | 3 ++-
>  3 files changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/doc/guides/cryptodevs/features/default.ini
> b/doc/guides/cryptodevs/features/default.ini
> index 592af48026..116ffce249 100644
> --- a/doc/guides/cryptodevs/features/default.ini
> +++ b/doc/guides/cryptodevs/features/default.ini
> @@ -118,6 +118,8 @@ AES CCM (128)     =3D
>  AES CCM (192)     =3D
>  AES CCM (256)     =3D
>  CHACHA20-POLY1305 =3D
> +SM4 GCM           =3D
> +
>  ;
>  ; Supported Asymmetric algorithms of a default crypto driver.
>  ;
> diff --git a/lib/cryptodev/rte_crypto_sym.h b/lib/cryptodev/rte_crypto_sy=
m.h
> index 505356ff44..b47e52f63b 100644
> --- a/lib/cryptodev/rte_crypto_sym.h
> +++ b/lib/cryptodev/rte_crypto_sym.h
> @@ -482,8 +482,10 @@ enum rte_crypto_aead_algorithm {
>  	/**< AES algorithm in CCM mode. */
>  	RTE_CRYPTO_AEAD_AES_GCM,
>  	/**< AES algorithm in GCM mode. */
> -	RTE_CRYPTO_AEAD_CHACHA20_POLY1305
> +	RTE_CRYPTO_AEAD_CHACHA20_POLY1305,
>  	/**< Chacha20 cipher with poly1305 authenticator */
> +	RTE_CRYPTO_AEAD_SM4_GCM
> +	/**< SM4 cipher with GCM mode */

In GCM mode.

