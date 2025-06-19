Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFE9C7115A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 09:40:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECCD442E4B;
	Thu, 19 Jun 2025 11:40:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 710C14025E;
 Thu, 19 Jun 2025 11:40:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750326046; x=1781862046;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cyaUfoFRPpE3FgFFgO+NI2SDrSe6HtLdZoezoVipnUU=;
 b=Kz1DnkpEj/ZLVNuEYfb8VnNTGzO6BDgJxjPhSCksYMIl+o5gplV0F1CX
 p2umMfA3VD+qDfnq6aZ8B3e1jkl8a9a67lQpTU4gKg1WJoTVys1YJJsF4
 +d0WyhEfAVGK6KRUc6svPK91LRCgXYEBMdBJuYI8U8hbCXy5uPhV2O0Rv
 8IfcDUmca4+1NOoXoVPAmGH0TWbG45wbT1hNLq+ode+sn5eLBOZk0oUE/
 tJSi2brv93Wee8NdI9SHzZ0uQBra/X8dIT6SuyRtB+depBUJr3/lEFbge
 42ZHfnNpZq3+WJ8XS6G5+Fm+5Cw08hDuTe2kQwgXski2C5Mw6ewSdsaSE A==;
X-CSE-ConnectionGUID: mY2WtckjQGyGu2QKQ/nKHQ==
X-CSE-MsgGUID: AAmiUo7DScOxwKerr5j9xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="77980608"
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; d="scan'208";a="77980608"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 02:40:44 -0700
X-CSE-ConnectionGUID: mnrjGsfPQo2w9De6NN9yOA==
X-CSE-MsgGUID: Fksf0uibS5Cf3mJ7YcmR6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; d="scan'208";a="154559117"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 02:40:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 02:40:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 19 Jun 2025 02:40:43 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 02:40:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvoEaOTjsfvox4TVvwKYKZ8iS+KbVpuaaQQqkaU9rlnnVmdRBgt7hMfFJaHWdEn5oNU81RC8yopPIsQKqHGM2vI1pZ5px3mp1iwBoL9PWfihGPayryD1httBZabnwr1TzOcr5Ss4NdYp0sW8h3R13nrUlg9jxwqZLtGMfHZG9/qHdYygdWuHLMaQ/G0tYkbuXT6sKrzJX5cdxrDhLvgcE6bAYL9etXu7izIz5rCyEIZowBSm90FyKxB9NikBUFdLXV1WLwhq7nKDzCeHlyNDbvsUW5QFSHT7aoZjHkOe0vTwcVvmxPg5+y0Pj8lZtltJheY6nvnmWmr1L8JS85kypQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyaUfoFRPpE3FgFFgO+NI2SDrSe6HtLdZoezoVipnUU=;
 b=lPO8O+isan4fqVgeZQWIQOgf3109Xhat2VlFrx++v4KizMusu1oL14dSaYaw8BRT8Dgsy+qIAo/RDfa7xFkwmJNqjymsTa0uWE1+kuKuhfjrO75M9zS8IaIL2UOC4c9UfWwvibLLN42UUNATGDZKnISIm162hJhx+u1MivQHMFeATWxWp6dtweNwuolCwfy59uHIbZUyyY4MYsQg0FAmq4TdjAAA83ohsxPf5YujpxiW6R3RLecrs1+U3oVodPHgP9E8bnkNSUkGOIcP9xmKGOxCq8VKHQSBLYSjCsuQSyMtVbX+HVe1glJpqv4FZ1DGtXs4fNUbKkHrIWxJSQgaqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8601.namprd11.prod.outlook.com (2603:10b6:408:1b8::8)
 by SJ2PR11MB8568.namprd11.prod.outlook.com (2603:10b6:a03:56c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 09:40:35 +0000
Received: from LV3PR11MB8601.namprd11.prod.outlook.com
 ([fe80::7878:b054:82bf:b5b]) by LV3PR11MB8601.namprd11.prod.outlook.com
 ([fe80::7878:b054:82bf:b5b%6]) with mapi id 15.20.8792.033; Thu, 19 Jun 2025
 09:40:35 +0000
From: "Ye, MingjinX" <mingjinx.ye@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 "Burakov, Anatoly" <anatoly.burakov@intel.com>
Subject: RE: [PATCH v2 2/2] net/ice: fix updating DCF RSS hash
Thread-Topic: [PATCH v2 2/2] net/ice: fix updating DCF RSS hash
Thread-Index: AQHb4CTUTAe7Fq0hlU6xK1WJpSMoNrQI7RgAgADdKjA=
Date: Thu, 19 Jun 2025 09:40:35 +0000
Message-ID: <LV3PR11MB8601E26E0C2ED6C7BCD95734E57DA@LV3PR11MB8601.namprd11.prod.outlook.com>
References: <20250611095058.114465-1-mingjinx.ye@intel.com>
 <20250618070844.174484-1-mingjinx.ye@intel.com>
 <20250618070844.174484-2-mingjinx.ye@intel.com>
 <aFLCCErZ-WYoKQOR@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aFLCCErZ-WYoKQOR@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8601:EE_|SJ2PR11MB8568:EE_
x-ms-office365-filtering-correlation-id: d8f54e8d-20a5-4677-e95f-08ddaf155777
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?tX6lKxM8aZjbH2WmYgO2/PxCx2d8q9u/U0sXiXJEz5XDZ9C8bVZzodASa+Pd?=
 =?us-ascii?Q?35zfZGsocr/2Q8bGofVMcXRcVzyHzNdR8HeWi5CaKwWAVgxsovWkPXkJ9cWW?=
 =?us-ascii?Q?+PpkOjs3zsB0z4mf/hQxhWGFuDZz8vrqhLQBE3su5UXBX/JdYwq5HNPjAtuE?=
 =?us-ascii?Q?DgBh6Pl00LItZEaYluK6qL87W3mVEQ0e0bGz8WE4gePQoVL0/lBn8CeGCSvo?=
 =?us-ascii?Q?onBiHBxDIyk8J67AkfgpTu9dyUuTSm0O5ZR49SN0ZhEB0B2KvSV6fYUSLoXp?=
 =?us-ascii?Q?ZTCwK893nuBz7x9JvVzjMmVIEN6AmczNGGEyenxVnN97y+KN/KJtVUThGti3?=
 =?us-ascii?Q?eLsBHuRwFKuQJrp2sRgy9tIitvSX0X+Dw0obAxiYHHutjTsoIJsrHplxqWe1?=
 =?us-ascii?Q?bX/rywuN13agf+DcSBOm3ViJHHxW/4mY1RRIwIhtnBG3ZDMJCeStfE4yRZec?=
 =?us-ascii?Q?VElUmjVuxeDjIyhPTy+dbCBYm5H/tADWLBmKN3kp5FwzVDlB6s2bb2pljbod?=
 =?us-ascii?Q?6vDCWlyiLMcSCqJW4T8Xxjh0AO3KXAASBh/kC9SXk60BYDrVPSS65OSNY6Sx?=
 =?us-ascii?Q?xMuB6ZGhi13uOJzaShG+IDpwNFl6au0P77usy7DVqdz9T0dmZOXluQ4HMxG0?=
 =?us-ascii?Q?SdToIDj4PdGQ/HrskU5jDYcbZaH5k4yhKti5nbu7FfLZdsXfig2OQpaEdDMs?=
 =?us-ascii?Q?y0BTXeQSxliqERj4IfhqP66XO6sYGToO3LcT/BpS8Xuw/E2mP/a1xW8ksMaj?=
 =?us-ascii?Q?wWOr5xqGO55kXmFa0V0pH39qDj+64Mpea8a7dFGN1ux64rar0nzZsug5GKiF?=
 =?us-ascii?Q?OpcUweGa68HSZ6l/QhTNYYhKNomgH/vE47WEPz4oWFz8hl6pG1AfIDTVB3GX?=
 =?us-ascii?Q?RpzrJecxDm6I5atA0dcJiTAvTrhouyxk6BqLtZC4YVZZVeruzluQwbMNQimq?=
 =?us-ascii?Q?HjrUykkbfgZpPxU6p5a41zSssVKfxDp6WLLgLTVrXx9gPY2mWHx8QcQNJKCh?=
 =?us-ascii?Q?SMohE89FuK4rDY9QAAN0cDYoPib3G4rGW9CObM0Elv9VUqzTGhUQDzYLiDN1?=
 =?us-ascii?Q?/D4XaHNo5+UQO0xkPrXvPUtDEwUqYFEtaMycWmg5NBaRkuTwI5hab1L+GtDr?=
 =?us-ascii?Q?c0Je714sFoWmgkDM6vHfNTp238W4yPC5/JvNehhCUMAqNYqeQSvgJKbBIkWO?=
 =?us-ascii?Q?1blnmz+n2pjQ3D1lHY73SVMth6x6nvRQyJB16IEZE8GO7a4lQXDzWDAJv+lW?=
 =?us-ascii?Q?/8ZldjoGxi9ppNlZ4ZZO6LOVwW5BaLEfMtq+I2i/R9uupHyjFr/go5TDZuXN?=
 =?us-ascii?Q?VC6tKMtVL6siemxItHDGjILMkp8Vgg+R2ehPzVYKBSeGnEkoESblkV1fAH9y?=
 =?us-ascii?Q?tgPdHOq25HQvAD/Y2mMJp1M7v9WzeWWarOrtIuTG+4020zvc/uYKgS+ut7Gg?=
 =?us-ascii?Q?tOvqu1PI8UldsUMVkWmGKDC5M7RtVAeUwk1VzlVe4hQjh3pJJAmLZw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8601.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KPe9W7WVA9TVJV7pgXrg07wrAyksWi+gNWxFdAYjkrbil9vO2Iih/9aUwBzt?=
 =?us-ascii?Q?Fq+HZva5dnu6ywuh51Jz7DzAY62fK26CbEnB+ZKd6naO/0s9dMmCEGwFJ9SY?=
 =?us-ascii?Q?TWREx0cTFYub5icXM3NdXE0bzwcDXI12X1VA/E4e+gfrM9NXdaSfB9g2Hgo3?=
 =?us-ascii?Q?xkeh7C/G50zvgpDWdZSs08GiCByyFcvix28gbpS1cNIEpAiovzp5L8zLsbQq?=
 =?us-ascii?Q?8a9xZFF9lHewVtn8k3SuffBaR9hDPy9SgJpu0f+rQWVvBf3D6w6XiDSovQpZ?=
 =?us-ascii?Q?Z6b9UaxBpiA5af4qDchUoEWrlhejMv4mcrRl+OhBdZY1bhZ7UuSm7ZpasdKn?=
 =?us-ascii?Q?l4LK1HeC2zGzRyW97CBp59Tu6KhosMACuKD+gsvfd3RP6W9XF/gGLtc7ZHwF?=
 =?us-ascii?Q?WR5zAx+Cph6VB99IrEkD/mEptAlaWJJxw6NNJ00d433lFtKWV5UZ+k9cvv2u?=
 =?us-ascii?Q?pxXFEJDJP5w9WAUbVACWhVY3v0ylywxPUAAiG6LdMuc/qDI2gLOQEibtdgTi?=
 =?us-ascii?Q?Xztm7qoVhsuXA4vri5mmnHGyZ9O+vlkDxD5Js7HFUx04PCbEtl8YBZftq637?=
 =?us-ascii?Q?LV421TbwKw93mAMAG1/mgxU4eLQS1LdntOwJL6hsRQvO7OJDOPyFiEruAVK2?=
 =?us-ascii?Q?1FqSHptoSWS87+v5kEk6PoV85Tcd9YISCIv4TbUf1gCY0di9x0XBBUtRKgnW?=
 =?us-ascii?Q?ZG2Z7FmbmYWr7yp/9nmWF/hj+9Alj/6bF4ZOvSQCE38mb0LTvnHCip3Jopyd?=
 =?us-ascii?Q?E4xeUMBv4HxoYT/KZEVvpOadcFcPtNeLzsA7zfXXyKiWvcfQUX+jGuGDkYIW?=
 =?us-ascii?Q?sRf9bYV5pn5UOTCMlJ+HN1lj2HULTML7lT8k58tnAgOmM5Vpv2Vu0MDDVnaF?=
 =?us-ascii?Q?8A9j6ZdVjRGEoP5r2jFbNbuJ6fUkiyvLB14XznISAqWstyJ2xy1UJAbUPcnZ?=
 =?us-ascii?Q?+LG2RIehr43i4fEbyDCoELSxVrovfm2/LxpKvnVOxfFcOlj3QTfYLcukA5CB?=
 =?us-ascii?Q?FFP7PwmMbR9dlyNAI6RgzzZ5VBfDj8mZtWSyfUufUAtO7la9b6c5EiKcUpen?=
 =?us-ascii?Q?RliWR0hugjccQnGA824s+dkm+lkQCYS0uSEiG337jLEkx+lQUc3F5sRRj3I7?=
 =?us-ascii?Q?9L+KFq0BxX4RHCK8fv6JT5p8Jh3hWiEEH7SX4AiRuDXxlU9H43IxUJ/pbULp?=
 =?us-ascii?Q?7UrvhcLfDee4evQQCxWNQEQ1KbVSEKil5HkPXj8Z6jI5qTpIWY8MdDeem6P9?=
 =?us-ascii?Q?Qks+glyYOTn2/+OqciNRLPSwOgW8k9W5nsm5caOS2U8Vo/suwzWUe7cMZALw?=
 =?us-ascii?Q?RFGqG1pnU3c/3nkgkNyk42Tal9n2g2vQ/wmUBM1sZ7gLqfbsM8kQYzGmoTy7?=
 =?us-ascii?Q?OUqDxbPX8CM1+5t76a9FO4+uTLmzAK5kRrotEQKSqN1QEXnNjjQEtghSIzD/?=
 =?us-ascii?Q?aew/7Cb0kNmtl0rXgl/IuR9cxIke04d9FXKv9rI/VCgIXfgLWYM1rbR5DHz4?=
 =?us-ascii?Q?TWNQjYOHqAqcNKGlg7doCKnnpXlKzbt1l2drk+Ry9stbVVNgutwT1BsFsiRC?=
 =?us-ascii?Q?Kw8ywtGkjFv36JSzMxtN6ldRItGYvjXyq71lFm/2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8601.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f54e8d-20a5-4677-e95f-08ddaf155777
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 09:40:35.2881 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GfRwa0Pe+jCXA+g6ZXvHbSE0mMPXibcUa7eysdr9kLFKLA3jGoc8A/vyH0hAnQlU0GEhL6jeCZIsaxWPknq0sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8568
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
> From: Richardson, Bruce <bruce.richardson@intel.com>
> Sent: Wednesday, June 18, 2025 9:41 PM
> To: Ye, MingjinX <mingjinx.ye@intel.com>
> Cc: dev@dpdk.org; stable@dpdk.org; Burakov, Anatoly
> <anatoly.burakov@intel.com>
> Subject: Re: [PATCH v2 2/2] net/ice: fix updating DCF RSS hash
>=20
> On Wed, Jun 18, 2025 at 07:08:44AM +0000, Mingjin Ye wrote:
> > The driver does nothing if the rss key is invalid during the rss hash
> > update.
> >
> > Extract the update rss key code from ice_dcf_dev_rss_hash_update to
> > ice_dcf_set_rss_key and make it consistent with the pf behaviour.
> >
> > Fixes: c223cadc9e5f ("net/ice: support RSS hash configuration in DCF
> > mode")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
> > ---
>=20
> So just to confirm. The behaviour change here is that, if an empty (zero-
> length) or null key is provided, the function continues to clearing exist=
ing RSS,
> rather than just exiting immediately, right?
Yes, this change is referred to other PMD like i40e, iavf.

