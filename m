Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2161CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 15:04:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BDD740608;
	Wed, 20 May 2026 17:04:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 5170F4042F;
 Wed, 20 May 2026 17:04:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779289447; x=1810825447;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/T1ERcBLvCXhk0jM14SinybEGOIAJdedGWYwbZu4MQM=;
 b=SKV+WFm97zp/6/rkFF6Kjto6m3DgTSs+/c7FwzDd57trVjftoH3c/BG/
 AnF7K/ez/CrBIZ+2MwT4p+KbndeplVthDC4uPFZs+6ubZZ1a6WxXCnp4O
 gGC9wFgq+rFDGM5MtF1Gj4Er9g0Qtxx3grIgkED9mKoM0Q4vYQt2CjDJ6
 obJR9jg09iCk9DnRYeLSB8TKlCHtj9CqWwC6+ov1ZFMtbdBKA4fvVavIa
 ky8MDS7kc+ZqGxRz4tWRaIcIyZiGfBKb3udZjTVVMFzrHkpiL57kBLMC5
 K8erjHFeU/G6QQiorRsCDEC7+LqF1mEpl3YOpYQILSf4qV9zz3rpD6rgA Q==;
X-CSE-ConnectionGUID: xFkQm1InT4SK0ftI9u86xw==
X-CSE-MsgGUID: b7SNFji4SneECDBMdE377g==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="79919420"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="79919420"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 08:03:58 -0700
X-CSE-ConnectionGUID: rYneme91QLaKR2xx7b47hA==
X-CSE-MsgGUID: p9Ky2XCCRhCt1P1za3tZmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="244207589"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 08:03:58 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 08:03:57 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 08:03:57 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 08:03:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rar+s8hKV2Kq+vD/E9dSCj5jltsjraL94Rf7zW3dnxsRbu02k5hAtVo2Gu3HCAF9UX4O6IORuyGDe/i4vKdSwLHfKrmcBErcgZ2Rv3IXQz6VZQe2WrlXRpZdTwqXGM/1sWw3bNNor+K+GYCj1jBSJFnJfGfhSvFsXaG/4XBJLuu0e+iAaAVAyapwvgpRUbMmlRkWR5zxuhiMYN7Xcmr9v1ZtaffRHy/zTU9REDkNP9mwzzLvHvqBAkrmvqxaIKpOwpKn27yGYj7ywEjcV4IBBCGP+fHxaUGtuqtrvQSRgQP5ARPp4Ki/s3PvzGn5D0DWEfzfx8Le16RtJ3a5W59BBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+6IBopDrejqwWaT9yQG97Qstqs/TmQNvy1sUBzSAE4=;
 b=nb/Y5gpb8pEfUr89AvIyIl9eJ6xZnhzrZBLN805nsEs1OcS4l4CBTHwJMF+EmwUVpK5aMeycotzvE3EDO/moKJo6pd8lL3Eeos+nM9TXtVfvHXrHz+J8QrxJuki1/vI4/2G1K0KQSYenFliPyhwgMjMAJ556VHggpXtcPtxcuziOE46DEkykGPqNpGgXuvWiTl4nRxsYOE/gcwpqa4ai1AhRN6qGEGA5kGKlM4ga7SYJcXim6g5SVDl0xvrP+pKBAfXxTOr2MZbBM0vQbuJGdUNble1+mNkwiwjDBUn6XQT5e6IbCluoIlZHZ6TKbzQO1/lJaRv5NWIO9mQddjJVGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by CH3PR11MB8708.namprd11.prod.outlook.com
 (2603:10b6:610:1be::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 20 May
 2026 15:03:51 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::d99e:14f5:fdbb:f2d]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::d99e:14f5:fdbb:f2d%6]) with mapi id 15.20.9913.009; Wed, 20 May 2026
 15:03:51 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/ice: fix TM node ID validation against configured
 queues
Thread-Topic: [PATCH] net/ice: fix TM node ID validation against configured
 queues
Thread-Index: AQHc3Is5c0iMv1CgaEOOcLTDQtIYmbYVhs0AgAGTfeA=
Date: Wed, 20 May 2026 15:03:50 +0000
Message-ID: <DM3PPF7D18F34A1E01A437AF012C78A264D8E012@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20260505123157.1387791-1-ciara.loftus@intel.com>
 <agx6kiQyvHZJ96ob@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <agx6kiQyvHZJ96ob@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|CH3PR11MB8708:EE_
x-ms-office365-filtering-correlation-id: e347e5ce-b6a7-461f-9553-08deb6810084
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799006|22082099003|18002099003|56012099003|4143699003|38070700021;
x-microsoft-antispam-message-info: b1oYcPcX4NQA4nvu7jXkai/OmB1B3lRXbTfW9mEAx6ko/Z6YgSOewLEdouUb+9Efv++OBHf9sjYHjqWWeO1jFAXQTF3DGFr3EjVDXlKLa5MQ8r7+n95JjyddWukWArEGXRLRaNw7aL8K7G26puKRMDZyrbFzb6m4CaIPwQIl/RhQ1Ta94fdkuyg/StLMDgC+BxgkzjG9NYfjTWkRrkd7+ZhyokKARIUypRk4GpX9522xgdISgmY1y1UrZbqAjAS3nrqCS6jNBG5EBf2U8JXE43kN1dG2tYUYIChpkQ2QkBJRoTZRs5ZkPp+PIzulOM1FYhv9R9kJ/79ZuNG+f89zoqyKrDsXlD7CuPov4aYRrZxiGUlAumJbagO1YMqCXdzsUn+4Bl1SkT58yN7qZfXCYYzJBDkA0X1UNTyrQ3oxnUddblqottQHtPqerL1DIL2cKCOnCnq2iPTGx6sPMzSitYFuwz+jOYLv+7v/Zpp7AibOp8ndc+sUu6qPYBDrnoSWFlJiQqASXzzyA+cx4F8ehDxwYIsW+Rbp+nvg8wGZFT2sivy03ivvc+I5DByLnnjEIj45da/Bz8NeUOgDdL4AEXpUfwQzjCw5gqrXc7H5rlXaSdwZkhneklJ8CLfReE67+VZhMbcPeXaV7qflVstHPJ/eqXdNLQFRDX7XB8A8nW/KMa7FwgcSOuYh2k1gxYS4tuACweQsjE87TBpQMMrD3dSLY4xiiuogYtlPHlEZiSg9jDyJjPwUbCj19gSW7ggc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799006)(22082099003)(18002099003)(56012099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ybL//FaNEHN/xlpQA8InTD+PznnoVvVjGOMFsYCrFQkVakgVi9EpXK87BlhY?=
 =?us-ascii?Q?ECRrxo+3Fs1VP7TfGC4jpCSemHv6WuHYwaB4rzx77PJjvIPUYNhUjsOvaqsX?=
 =?us-ascii?Q?4UemAxp5PhxquQEuoGkL5zS1ICUbKSxl18MNbIVtKrnBOQYp+iqD8zO12Eo9?=
 =?us-ascii?Q?7MGSObp+afCS/FdWQNOOn7y7IfI2nBffbzOIqq1JW4XjZAfFDVolJ7s7CBtk?=
 =?us-ascii?Q?4WUQkUBqnIVOZjTQZZRLra3jyht1mRud25WFaX6JNafK1NNCsKi3/00E22xN?=
 =?us-ascii?Q?gDlkPc4/Lu5VVBA6eNiAgpqQGOGe1abCz1A/1kCa3EUspd8EajYje11nOXoz?=
 =?us-ascii?Q?pXnlbCPKsMXDBAbwaJasX+divDYWmx4tn1lio37Lw6olC5bKfkA3G7a/kU7c?=
 =?us-ascii?Q?4rkSwWibNCLJpv/XMly5IsIdjUH1PWcnu1NuSLO5G+Hb/Vn2HzuTb+B//239?=
 =?us-ascii?Q?kel78+ZEAOKS8C5KXHZY3k4EFCx8XtAe0IokJvrYESbnpmhBqaPQaG7i0n/+?=
 =?us-ascii?Q?QmpsFCZXiqPUqIPl85mF1e/iQHrLJK6vTWUrXrwbZj7kGzDHs8ui/znYDmQn?=
 =?us-ascii?Q?Mo3p+eE6Pq8D2115gnIwzTHB6lUJ56C8vozpH3pQRdN3Oy56zoBn2XAmYKAl?=
 =?us-ascii?Q?DLktsO5kd+zNpAFg6MG/IUjM8FiHWJceL96Pw6G6OMUPHHtZjpTz80J2xBss?=
 =?us-ascii?Q?NaQk78MzQMdKfRnUdSWlN7M7Gw7mhpLubee1ocVqjcTTUv1RdE4yStygZDma?=
 =?us-ascii?Q?ikcRihRpGDk+pbUXOAl/MEggjuBKDZHueAXNIBlPT4l6lLmlrLJwS0gVPnAY?=
 =?us-ascii?Q?AH4KJmQKwdecexaJHJz9Np9J9aT7iuhb7gq5w8W59mZUp0LXkVukDlbv720D?=
 =?us-ascii?Q?Hb9mvvWjTFLtPbHTHUfR2lkMGty2Bw9Dgdk9D0kCZgUMJKvRIiN1iWPw0oCU?=
 =?us-ascii?Q?lmnaYUmxTge7vMxHg5gn4ihqSrZ18sUk1oeZue/eLzgBg2pJEVJkhsASg2RU?=
 =?us-ascii?Q?+QgLZnQT5+DVVcdvoMZWryPlk2fNA8BY0WDBl4Nkwb15Z4Fgq09UXZCVxnOR?=
 =?us-ascii?Q?hKifQ+w10uLd+Lf4bB5IEjeLxUBXmcNGSJulVDd/9TR0drxxEnHA7jCk8Jht?=
 =?us-ascii?Q?a+B6783Ji19T1a1At6ONmFs8uqf7w8QIHY+mfxoLz4jRRGbJFpa6stN9UBg3?=
 =?us-ascii?Q?SmvkqqU5NaOyBiIwwxWCeD7RNa0511zBNtTR2k6UgZft30iHnG3wuFzA7UcW?=
 =?us-ascii?Q?n3hLHrR2jrwZtx5PuubpE5iDiyft1YIuRSYRTYb2+t+IPqYsMctqurvarwNf?=
 =?us-ascii?Q?Bdsncj8FwA0e+iWbhf5Iksz4aXcuEj4VMdo7KZgEQdvrtMJPfXwtkMVWcyrb?=
 =?us-ascii?Q?BLPOzap7vrkbEhLQ8rR3TXfDK64VpyH/UGTpp6ishRl/DuKT0XPJAHdArmPB?=
 =?us-ascii?Q?jKSOwXwNmPj6ECqvgSsrcFlXCqTsx9O0Vcg9jeEQuLYLNuEx+mERsGVh7D13?=
 =?us-ascii?Q?2JnSYci/oaOoE+EthidOBZsOROd4e+/lh7tOs/505BeciJ7N8KMkZM+f/9vz?=
 =?us-ascii?Q?Fs8dZ8RcLZ+oXwe30BHe1BsQZ5BXOEbCR5w64bBhBcFXPd4WKWC/R+W9gH7T?=
 =?us-ascii?Q?E/VbKikPGwAvAQEzaco+IrCaeFdq4Y0V8L9DQlU+zjhajBGVQLy9YEWDREF+?=
 =?us-ascii?Q?PISNFMxctsPwS3DYg8nh43OOXxeg74dh7S8RNWJpTdS/YQde?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZMFXdgllYdRq0Zp60ImSI83H1Ty8Y8aYgCaoy7SFi/eP4j7pRp2or0s0kNMXjuCcgGnPF13SfoGin/W3rGlnqP6oPMnTLjWBEK05BGUBgE41bKB031pJGQAnQolw6+4M1x0TqUbfuFBLuJnxaxJ+rlylp+WeDAnq4tLi2D9yA8wPNPYpgJ3OVLsfJE0RGRPQGRaU3Qitpw2tXCBObJSQX7iF8iRfRfwvTtSw9MRDaJU4PS3Kd7+UXIZ71mF+qoQP8x/kVsveclPrftJztAeIJZ3+wwbOpW4mDUE2n9SxGlet7jv0v+tyT1wXdxITtQt8C0RasaljL5b053RpYaJufQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e347e5ce-b6a7-461f-9553-08deb6810084
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 15:03:50.7691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GHfmYzW46npBDTPZemZOTKhoFLC3JdbHFC6esdgw7pzoXkGP10CylukiwW99OvgNCuFcmHU1jxgPM9yiArJwXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8708
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

> >
> > Fixes: 715d449a965b ("net/ice: enhance Tx scheduler hierarchy support")
>=20
> I think this fix will cause other issues when we want to use large number=
s
> of queues. From the commit log for 715d449a965b:
>=20
>     "If the HW/firmware allows it, allow creating up to 2k child
>     nodes per scheduler node. Also expand the number of supported layers =
to
>     the max available, rather than always just having 3 layers.  One
>     restriction on this change is that the topology needs to be configure=
d
>     and enabled before port queue setup"
>=20
> The last part is significant - the number of configured queues must be
> supported by a scheduler hierarchy with enough nodes at the next,
> queue-group level. Therefore, before configuring large numbers of queues =
we
> need to configure a non-default hierarchy. Therefore, when running this
> check the value of nb_txq is not known, which is why the original patch
> changed the check to RTE_MAX_QUEUES_PER_PORT.
>=20
> However, you correctly point out in this fix, that that is not according =
to
> the spec for rte_tm. Therefore, I suggest changing the check, if possible=
:
>=20
> * if nb_txq =3D=3D 0 (i.e. no queues configured yet), then keep as-is wit=
h
>   MAX_QUEUES
> * for cases where nb_txq !=3D 0, then use nb_txq.
>=20
> Does that seem sensible, or any better alternatives you can see?

That makes sense Bruce, I cannot think of a better alternative.
I'll submit a v2 with your suggestion in place.

Thanks,
Ciara

>=20
> /Bruce
>=20
>=20

