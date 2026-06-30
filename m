Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7465CC43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 14:28:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B0774067B;
	Tue, 30 Jun 2026 16:28:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 0A60340654
 for <dev@dpdk.org>; Tue, 30 Jun 2026 16:28:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782829732; x=1814365732;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=xjMtIdCO8g+BWif2CmYhLJPMvirfLtcgzi+JJkmo7ng=;
 b=QEXY1ZvQXzAhXWUuF1jv1Xa7i4mLa/Nf5YzDLodrCw73GdMD5fbn0I1F
 GP+V7Ii1gmdqpmKXH7iSFXAm5crQXjDhSTy+szH9sR8Q2Wng8vFj3JVFx
 XI+PqVjUjCrxjj9gMj8MXg/bTzJsB5s7Kp/pxnxo89kA5naXgzWyxDiH7
 eRRL7gQs+A8IfyQiKAWwGV6whEnr3z5NfflIT2BY9OgEOItEIYJpseAFM
 K3N5jt0ZsYdnVGYYE2wVaOGm1LvkzZGfRJsgm8M/90+k7T15xauUv/htN
 KTgRLJIuof270VCOc4Ii+roWtYBBvvWCdYvsoydFqq33HPVpcS5K6B6gq w==;
X-CSE-ConnectionGUID: uhrXLeLfQWWXyvZ9Jo4/Sg==
X-CSE-MsgGUID: KpIoLn0JRS+JxVXLxxmeaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="82533669"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208,217";a="82533669"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 07:28:50 -0700
X-CSE-ConnectionGUID: 3bJiGBTESP+dWoChi0tDJA==
X-CSE-MsgGUID: vp7vkwrUSUaDGS6qK92cIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
 d="scan'208,217";a="247813110"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 07:28:50 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 07:28:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 07:28:50 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.1) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 07:28:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHsUoLMpAd/GV+421YMQIcaQdHqhSL8P1YAjMX838j58XFJVXYvZzmcI79/lqbUr6tNNCNZnquLcKPbO4KQVmGDkYisvJcrVCIxVtZARbSOwyDIuw/CvVgWY2xCcylRjv0NsNdrARpAz75a056N0FFu0vzYBYIz7+eceMfTmJyW+x9Kpb0GZ5dYU8neXqx8G1i3bvQYWPsSPeuHE2CuMJBCkbrZQPT+MAD5DpaLSoK3ZmQ1B7fmClOkSXHERTTshXPhNn6V8g1/RL2L/hKw0TLZtk/oSoexDPEXFzzoZ494YwjnPSBoAdw8aLrxIcw3fbCIWlO4xiKJ+q5Ssw7P+bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbGTwqbi5mhR0xu1jMpcCtlj8Nw1A+X89B0LD9eikxc=;
 b=OSmLllAnZXvu1HerXWJE4OGYApNS09RervnaC4EWwBUcz20T9hm6QkJMdx6AqXR/Hprdk3fxJ7EPVFPhl9pEKipJd0rylkbUpaRbrLQ4y3Wsp2xwafpOsW/hS6JG2gNdOeC94kQ6uiB6423fuYxQ6hMNvUWH57znHj6+lx4M0gB8VAUCNyk6pJOdSCE9T76MLJq7w75vWp0qLt51gdop081JwzW2cPqBFNHdDoPCBNl1iYWew64sojemkeK0mwegvqU8b7NzrZa49pMGNQshEWmeff9dv/F7wdEyuRLD/Qvc8QhTOtB+D24JWazX2WwVW+XSxtoe84BdcBcEIASUaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20)
 by DSVPR11MB9744.namprd11.prod.outlook.com (2603:10b6:8:352::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 14:28:48 +0000
Received: from LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae]) by LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae%4]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 14:28:47 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: Akhil Goyal <gakhil@marvell.com>, "De Lara Guarch, Pablo"
 <pablo.de.lara.guarch@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "weid wei.dai@picocom.com"
 <wei.dai@picocom.com>
Subject: Re: [EXTERNAL] [PATCH] crypto/ipsec_mb: fix clearing snow3g digest
Thread-Topic: [EXTERNAL] [PATCH] crypto/ipsec_mb: fix clearing snow3g digest
Thread-Index: AQHcidPV7YCHgps/J0uYbt4UMX3LorV8W54AgCs4Y4CAsI7/Mw==
Date: Tue, 30 Jun 2026 14:28:47 +0000
Message-ID: <LV2PR11MB604554E92C84D5884EBA4DAC81F72@LV2PR11MB6045.namprd11.prod.outlook.com>
References: <20260120061234.137-1-wei.dai@picocom.com>
 <CO6PR18MB44843F6D8D644EDBD045B45DD862A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CO6PR18MB4484A9157D8A409D0A9D9D8FD846A@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB4484A9157D8A409D0A9D9D8FD846A@CO6PR18MB4484.namprd18.prod.outlook.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6045:EE_|DSVPR11MB9744:EE_
x-ms-office365-filtering-correlation-id: 70a5512a-5827-4a89-f6c3-08ded6b3e5c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|42112799006|23010399003|18002099003|22082099003|8096899003|13003099007|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: K4E3lwC5Ah9F7rHOL5/+tHJ/TW55zEjp7CPPtel27ud6MGoYOXBqEdwXguIkm+pYyTl6JATanKVgsi0XwhOZWi6UUQMbHGT44X5akg4EaZ5rPo1ruR+C5BYBOVtw0ZRLmVdusG/8qocflynji4FW5hC5sJQH3bG/6duqSf7fKdnqqlYS3oam5tBK12tG+P0xn3wY7qt12v4o8m5No/IgXyCZVYnGIyWg1zonDWeFSSiYo82H/JkEWAg7+MCaRl2UTAi3BwqHiB/QLAZ3/rwhzr71A3ASXFPhd7qQrd6XgCy9uF6SR6sfX343PQN5+GuvQpCh5CdWmhYxGQQu05P0d+mA4aH5mmeX05TWmYsSxTwvFr7FTYYfOSgxLQcGJxCRxR1D6B5c45y7noXkFM09Rtr0uKPZKVn4u7HAGFJNJnsU2iI+B38JEgcQ+QSWyfD0SbeczcSZXKUVCG2f7x0qAbX9XXzYyIvDxnpSlTUEvKgW6r9vEbaUdibB1jLPWfCOMUCgTJWfST6+xZ79Ek7Ts9kmveMJSVQdFEHlcTprAxu4t3RRqPeXopQH48qJ5n5FPP3ynDZdvlM1DXkFaPDvyiLVpy9BLZNWT6yjDM4JIhu9Bv1VDaDk46yJ0dbG0rowhPsAnlCZXaaThv6PnXsVMyHHrFTgDA+95zHooUkwcxf5G9r17JsbEdN749VGQi5XvQ6dMX3zBZ2S+5QAR0nnU6a+sCcd+dG1Xf5/r83JCIw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6045.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(42112799006)(23010399003)(18002099003)(22082099003)(8096899003)(13003099007)(38070700021)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DI9dmeNlXZ2DmjFcnR7KjlU/r88+HGtUCKsOowrM3JFD/G4qydHhi4SzIp?=
 =?iso-8859-1?Q?wPtDNoF8vWAHWAqDomYz5tzcyfLlwq7JSzrYaEWPOZrLTcztSVyqMvFHWb?=
 =?iso-8859-1?Q?A0B3Es7FDxLWDpbpg/6IsYbpQbJzjN0WGRR7lyxm/RfQ66lHkob0BbOPyR?=
 =?iso-8859-1?Q?GM+4mTf9PACtCpY7UaEbYA6QrUKGaL3bADuaDapa4tczxCep+3pzFXlUYB?=
 =?iso-8859-1?Q?LA6pgxiWykb4ZSva6Dc5OcoBOnvmt2HWzbUU+IxEiN4D9vtbb0587pV3Gz?=
 =?iso-8859-1?Q?jYwJ1TrFQUG8TR47TofYhx/JWrRSPDWbRC6X2FP7XTZqdJIWaKvEyJPGo2?=
 =?iso-8859-1?Q?Jxa5gHlVWXH/WHOVT05zikFd8Ij2h046Ti4vGLfEaXo9hEABgAe+X/1L0H?=
 =?iso-8859-1?Q?JmBIjSvW6WJ5AJh48I9kph8Tp5CdSepbMWSI5k45rZPNbPtcrM7y7QPObi?=
 =?iso-8859-1?Q?MdLAJcexaOf8hy1MAKbydm/J302MrJFoW60rwu72ACPXt593RBZDZceke9?=
 =?iso-8859-1?Q?xxLSwOb4RD/AFmLU68C5ZKEBV+wS8/136jPYxMI3+A9QYlSgkLJX/oYEnY?=
 =?iso-8859-1?Q?//C17Gdb9t3kXrCdSd47vupKlwvPGlyq54LJqI+xVSfT6CXfYI2pcBInFF?=
 =?iso-8859-1?Q?7eWmJw+dL6+FnmZTrAsIJw1A2uzofBAFb9c1Jy6BN3D8MhWd4ZmckrkQf3?=
 =?iso-8859-1?Q?m++zge9Qc+CUrAWSIAg8CB6MdHXcrgWkkGoutu9lBwVGS3JIIUof87KQJu?=
 =?iso-8859-1?Q?o/gE3VmKSJ+VPO51ud+dgUX0F4PiaXjFxQEcZKx3JzqLNv+1eLFE0Rf20b?=
 =?iso-8859-1?Q?J3tOJ9KcQmDVdvc1J1lHVJ+jMbouuzFVpsxV/82/gJShbpGpbuyzKyiA85?=
 =?iso-8859-1?Q?9P18Wj9dblpqBQvD4Hh9kulcnHhRjfK4l5MRX14j1SV4RuvZXPqrbR5Bq6?=
 =?iso-8859-1?Q?GvxZlVcqLI3RvGpdb8NYeDMYOegoQJWnSgVfY9oTVgCNOznRvLroB7eUNE?=
 =?iso-8859-1?Q?7I/zuFsPpd6OK3y2iQ0s9X2ywuiAH+DdLEgQKW9Nk0mwrBed9bmtu5fte/?=
 =?iso-8859-1?Q?JH5iewG19slX8UJZf/nMKq8/5Ld64iwydJct00khuO1Vi3kuvH20WVskTR?=
 =?iso-8859-1?Q?ZdUJY8O3ZQqc6OhNHDvRGfYsF04PZMnnV0kCA5mBBCSuwHTuCT1UTll5Av?=
 =?iso-8859-1?Q?9ywJH8Xx3zX5DHQnWlyNKjUqrAqib4L3vgk8HT6u4mTgaok+GTT1xgV/cQ?=
 =?iso-8859-1?Q?bKvy9r0Urv9Bgnir4WGX7V7XlBk9hIeoAl18dTDO92qsr/iW0ccFMe1gk3?=
 =?iso-8859-1?Q?jyCTFg4M8OdTiB24uT1U+OkPeh6eOJiqKi0UlChJYlhKwMR1VArFthee3V?=
 =?iso-8859-1?Q?VMX5r628UDdxQGusGpJ4X6LCm9V0uCqhrotNgLJFDCCTcpWHmLtojorKGC?=
 =?iso-8859-1?Q?Zvzj9M+90RhRRuCqsO9RAWTN2/rKj3FjXJ2i38gkXslRiJpggnpVE5GM/P?=
 =?iso-8859-1?Q?ajkVywAwhS4/MNk1KDXK5BUso2x+fo3bUgeTrEUZQgCl4aEF7c5jQQYl1I?=
 =?iso-8859-1?Q?iRn5dxsXu3AdRi6895z7JxG8rYAutbW8845DbU+yFjbG4sfsaawGs/OFzj?=
 =?iso-8859-1?Q?/cIhMcF144RHFkXxD4m+XGNVVsfNvwVFuJY3cuullneyJQQ6B62M7aki2D?=
 =?iso-8859-1?Q?pah7r9HEhdPMxDO7t01Nox2rM5clPTCZpSj8vcLeqe0oaIN4Be1aLWLgNR?=
 =?iso-8859-1?Q?nqejTksTrzwsrDsA8rD2Gu0aiC5+q0qDeHUugRG0Mtwkd7?=
Content-Type: multipart/alternative;
 boundary="_000_LV2PR11MB604554E92C84D5884EBA4DAC81F72LV2PR11MB6045namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: f9XKxOyFkJxWpgknWBzKJfWVW3uexXUaLIFIZ8B3QZIxtqWDmV0LUDRRCCrxEzgipM26hwK5MbNh+e7EetF1qlvJUO8YEFk9TECmwjp40pXJursd9UK6oGb88ghNcAGlcOkWNR44S5DOtvHkmTJiFlk1WnkTsS6mDSLWJ7ETewX74ISqRiUQDDJtO4ghUr2N+Spd+7iOiq/Q4mGvtkX5ta5W+x7UmcOmbIwqkNhYH9yy3q21uno+MObxYy2vqXoeM2K/Afj9cwleEzyoQzZ7pqvzfyOofEwCefU9DQXzI8nDZIV8xI2fKexsRj23uYx6RTVc0jtg6DgveRSyUhmsxA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a5512a-5827-4a89-f6c3-08ded6b3e5c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 14:28:47.4801 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q7gpb6nDNAvdJG+PnUTKHI9XM2GyqK3cS+nLSGc8Y+I9TNrPUnboyJ8d/a6jdCRTvaRu4oOGVeFBD9NxutUEcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9744
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

--_000_LV2PR11MB604554E92C84D5884EBA4DAC81F72LV2PR11MB6045namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>

Please aware the IPSEC SNOW3G and ZUC PMDs currently remained in DPDK will =
only be built for the ARM version: https://patches.dpdk.org/project/dpdk/li=
st/?series=3D38319
The  AESNI_MB PMD is recommended for IPSEC-MB lib


________________________________
From: Akhil Goyal <gakhil@marvell.com>
Sent: Tuesday, March 10, 2026 14:05
To: Akhil Goyal <gakhil@marvell.com>; Ji, Kai <kai.ji@intel.com>; De Lara G=
uarch, Pablo <pablo.de.lara.guarch@intel.com>
Cc: dev@dpdk.org <dev@dpdk.org>; weid wei.dai@picocom.com <wei.dai@picocom.=
com>
Subject: RE: [EXTERNAL] [PATCH] crypto/ipsec_mb: fix clearing snow3g digest

> Hi Pablo/Kai,
> Please ack if no objection
>
Reminder for ack.

>
> > From: weid <wei.dai@picocom.com>
> >
> > Before this patch, the software crypto_snow3g
> > clear the encrypted auth snow3g digest when
> > the dst mbuf is same as the src mbuf in crypto
> > op.
> >
> > This bug can be checked by following way,
> > start app/dpdk-test --vdev=3Dcrypto_snow3g,
> > run pdcp_autotest
> > the case failed when i=3D42 in
> > run_test_for_one_known_vec() in test_pdcp.c.
> > The case is PDCP control plane auth snow3g gen
> > + cipher snow3g enc.
> > The case failed because the last 4 bytes are
> > cleared in last for() loop in line 167 in
> > process_snow3g_cipher_op() in pmd_snow3g.c .
> >
> > Fixes: 5208d68d30cb ("crypto/ipsec_mb: support snow3g digest appended
> ops")
> >
> > Signed-off-by: weid <wei.dai@picocom.com>
> > ---
> >  drivers/crypto/ipsec_mb/pmd_snow3g.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/crypto/ipsec_mb/pmd_snow3g.c
> > b/drivers/crypto/ipsec_mb/pmd_snow3g.c
> > index b3c3b05a8a..35fe23c157 100644
> > --- a/drivers/crypto/ipsec_mb/pmd_snow3g.c
> > +++ b/drivers/crypto/ipsec_mb/pmd_snow3g.c
> > @@ -157,7 +157,8 @@ process_snow3g_cipher_op(struct ipsec_mb_qp *qp,
> > struct rte_crypto_op **ops,
> >      for (i =3D 0; i < num_ops; i++) {
> >              if ((session->op =3D=3D
> > IPSEC_MB_OP_HASH_VERIFY_THEN_DECRYPT ||
> >                      session->op =3D=3D
> > IPSEC_MB_OP_HASH_GEN_THEN_ENCRYPT) &&
> > -                           ops[i]->sym->m_dst !=3D NULL) {
> > +                           ops[i]->sym->m_dst !=3D NULL &&
> > +                           ops[i]->sym->m_dst !=3D ops[i]->sym->m_src)=
 {
> >                      digest_appended[i] =3D
> >                              snow3g_digest_appended_in_src(ops[i]);
> >                      /* Clear unencrypted digest from
> > --
> > 2.51.0.windows.1

--_000_LV2PR11MB604554E92C84D5884EBA4DAC81F72LV2PR11MB6045namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
Acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof"><span style=3D"font-family: &quot;IntelOne Te=
xt&quot;; font-size: 10pt; color: rgb(0, 0, 0);">Please aware the IPSEC
</span><span style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 11=
pt; color: rgb(0, 0, 0);">SNOW3G and ZUC PMDs currently remained in DPDK wi=
ll only be built for the ARM version:
</span><span style=3D"font-family: Aptos, sans-serif; font-size: 14.6667px;=
 color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);"><a href=3D"htt=
ps://patches.dpdk.org/project/dpdk/list/?series=3D38319" id=3D"OWA0f42c09e-=
b027-7009-7799-f5578d934de6" class=3D"OWAAutoLink" title=3D"https://patches=
.dpdk.org/project/dpdk/list/?series=3D38319" data-auth=3D"NotApplicable" da=
ta-linkindex=3D"0" data-ogsc=3D"" style=3D"margin: 0px; background-color: r=
gb(255, 255, 255); text-align: left;">https://patches.dpdk.org/project/dpdk=
/list/?series=3D38319</a></span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, sans-serif; font=
-size: 14.6667px; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);">The&nbsp; AESNI_MB PM=
D is recommended for IPSEC-MB lib&nbsp;</span></div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Akhil Goyal &lt;gakhil@marvell.com&gt;<br>
<b>Sent:</b>&nbsp;Tuesday, March 10, 2026 14:05<br>
<b>To:</b>&nbsp;Akhil Goyal &lt;gakhil@marvell.com&gt;; Ji, Kai &lt;kai.ji@=
intel.com&gt;; De Lara Guarch, Pablo &lt;pablo.de.lara.guarch@intel.com&gt;=
<br>
<b>Cc:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;; weid wei.dai@picocom.com=
 &lt;wei.dai@picocom.com&gt;<br>
<b>Subject:</b>&nbsp;RE: [EXTERNAL] [PATCH] crypto/ipsec_mb: fix clearing s=
now3g digest
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">&gt; Hi Pablo/Kai,<br>
&gt; Please ack if no objection<br>
&gt;<br>
Reminder for ack.<br>
&nbsp;<br>
&gt;<br>
&gt; &gt; From: weid &lt;wei.dai@picocom.com&gt;<br>
&gt; &gt;<br>
&gt; &gt; Before this patch, the software crypto_snow3g<br>
&gt; &gt; clear the encrypted auth snow3g digest when<br>
&gt; &gt; the dst mbuf is same as the src mbuf in crypto<br>
&gt; &gt; op.<br>
&gt; &gt;<br>
&gt; &gt; This bug can be checked by following way,<br>
&gt; &gt; start app/dpdk-test --vdev=3Dcrypto_snow3g,<br>
&gt; &gt; run pdcp_autotest<br>
&gt; &gt; the case failed when i=3D42 in<br>
&gt; &gt; run_test_for_one_known_vec() in test_pdcp.c.<br>
&gt; &gt; The case is PDCP control plane auth snow3g gen<br>
&gt; &gt; + cipher snow3g enc.<br>
&gt; &gt; The case failed because the last 4 bytes are<br>
&gt; &gt; cleared in last for() loop in line 167 in<br>
&gt; &gt; process_snow3g_cipher_op() in pmd_snow3g.c .<br>
&gt; &gt;<br>
&gt; &gt; Fixes: 5208d68d30cb (&quot;crypto/ipsec_mb: support snow3g digest=
 appended<br>
&gt; ops&quot;)<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: weid &lt;wei.dai@picocom.com&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp; drivers/crypto/ipsec_mb/pmd_snow3g.c | 3 ++-<br>
&gt; &gt;&nbsp; 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/crypto/ipsec_mb/pmd_snow3g.c<br>
&gt; &gt; b/drivers/crypto/ipsec_mb/pmd_snow3g.c<br>
&gt; &gt; index b3c3b05a8a..35fe23c157 100644<br>
&gt; &gt; --- a/drivers/crypto/ipsec_mb/pmd_snow3g.c<br>
&gt; &gt; +++ b/drivers/crypto/ipsec_mb/pmd_snow3g.c<br>
&gt; &gt; @@ -157,7 +157,8 @@ process_snow3g_cipher_op(struct ipsec_mb_qp *=
qp,<br>
&gt; &gt; struct rte_crypto_op **ops,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; num_ops; i++) =
{<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if ((session-&gt;op =3D=3D<br>
&gt; &gt; IPSEC_MB_OP_HASH_VERIFY_THEN_DECRYPT ||<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; session-&gt;op=
 =3D=3D<br>
&gt; &gt; IPSEC_MB_OP_HASH_GEN_THEN_ENCRYPT) &amp;&amp;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ops[i]-&gt;sym-&gt;m_dst !=3D NULL) {<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ops[i]-&gt;sym-&gt;m_dst !=3D NULL &amp;&amp;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ops[i]-&gt;sym-&gt;m_dst !=3D ops[i]-&gt;sym-&gt;m_src) {=
<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; digest_appende=
d[i] =3D<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snow3g_digest_appended_in_src(ops[i]);<br=
>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Clear unenc=
rypted digest from<br>
&gt; &gt; --<br>
&gt; &gt; 2.51.0.windows.1<br>
</div>
</body>
</html>

--_000_LV2PR11MB604554E92C84D5884EBA4DAC81F72LV2PR11MB6045namp_--
