Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCE6CD1297
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 15:53:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67B6E40A77;
	Wed, 12 Nov 2025 16:53:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 4AC8040A77
 for <dev@dpdk.org>; Wed, 12 Nov 2025 16:53:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762962783; x=1794498783;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SnJXOhygHiaAIZUSAOz47r3bPTtNWHJAOOeKOrXgybU=;
 b=oBTzQ4H3c9PUSmX+M3gxLuLvY+UVJRk9lOtsjbpKt3VcZVDxuihVda/7
 GWjVKJGjbiCptcTgzFl6XH7UUkpc76SVqypBIyJqhFfOn7WVMwj8d3b8c
 jXW4iLs0K85ccXiAaYxDQmYEAMLs+Io8J1EyN+b9lqz6eVLxCeDANxNmx
 feMzMw6ZC9F+NiXbEkxbhHFowBoZf9DSxyFhgVXcCHh9/GnkaOGB9+wAx
 D6PF+s9zACb5MTd8fecQcNFpevCEJ50nEwiIQ06+AizSTctX4vfx3HYFM
 BgOtusegUiULiDr3y21eY5oV3MkmCyJWEBhu/abEqIhs9xRK/FepEC7C0 A==;
X-CSE-ConnectionGUID: MEsZlC70QO6lR7WsXkDSQg==
X-CSE-MsgGUID: PxTV//UrRj+LFY6ToZBsyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="64233197"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="64233197"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 07:53:02 -0800
X-CSE-ConnectionGUID: uc8rIqrpSHipio2blnPoWg==
X-CSE-MsgGUID: 5Ca/DoJxRaO3/4PNRU5fMg==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 07:53:02 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 07:53:02 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 07:53:02 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.54) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 07:53:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7JSRtbJMeH/7fYRY1fYC2NHQw+8MFs3bbK77LY0uZ/Fy6zwY52GZhKPLhmqukqPRzGj4I4sDwns6sVPbjqxGfQ5GEUKXEvHPX0ZFNCLntqeVnfGxor+wdjqc7eQYZnyHIFOb8CsLd+cbYL73VtHpgubc5FBvxoUQw7P62sBybJAU+VLS6yWE4feU9WzPXTeyv1W5vFuseLgeXIqGkBR1fd65fqUdgVfLe1KswfK0ZW7ghFlr5fu05ZlmtQcSs2yNxdcbECizrQCV1regMU0q7z9fhdNZxs5frdFOfeuL4mEbK8rbOtQo4Zv2ZIXmqNMMSLfwIyDrejGAN6lm1AI7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHOxG/q8St9jXP/HAEjhPre595G/TIkxgG4EqSUZUzA=;
 b=hS1yzaPjS3EMphBbyiXXTQvLkTiudKOd2xPecdOi0W8LfkH0ai1tSG+1I5CznQ5tHbBBzwxqcJFzqXOi6EsDX1pejiUW1e8EAtx2zcaI3F/Itluk0I5SkRyxswnNEFeFnPWxfsIDCK+93SvgXhoG9Eg4lJiGSlCXKta7qOz34zsTn6tZDxbvCeIS9eh1iN3fM6KRcoMZmhI2UqPyBBlushKW1fOQ6VqNzUiIm3SqCUk1KbQ5M77Dv5xdcH+5prlDKWJJr1RXWn5Byrmah1bag2bLNvHln7b67ukuUbrImcQIiQKSBGNexj/I8zAPz74vCY8VsVqN9x3rzsEzLhXihw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by SJ1PR11MB6299.namprd11.prod.outlook.com
 (2603:10b6:a03:456::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 15:52:59 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::1160:23e3:5599:988c]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::1160:23e3:5599:988c%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 15:52:59 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] net/intel: ensure correct Rx path is selected
Thread-Topic: [PATCH] net/intel: ensure correct Rx path is selected
Thread-Index: AQHcU+ar17I4t9rY8kWQA96gtojQRLTvL3AAgAABDLA=
Date: Wed, 12 Nov 2025 15:52:59 +0000
Message-ID: <DM3PPF7D18F34A1AB3C04F36867D89420428ECCA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20251112151123.3757688-1-ciara.loftus@intel.com>
 <aRSsBFlNObpHuJJG@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aRSsBFlNObpHuJJG@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|SJ1PR11MB6299:EE_
x-ms-office365-filtering-correlation-id: 4ff65e3b-2a0d-4f7a-9551-08de22038df5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?YykwbM6XL0xXgKX0uNt/aarTRvcG4ci1j2jLsJ7QUC4/wD0q9VBuIKqRTSWb?=
 =?us-ascii?Q?FZFoJ5lGE+M6Ds4xTqy5JwOU7dzv+erdgg0H1+dcOTAlQmSU7QSr3x10XlQ7?=
 =?us-ascii?Q?mYtEig9bGeSXBdx5GH1d2dWGIWJZ/HiNKghA9lAjBV7JTYOdoaS/+SqTlNbC?=
 =?us-ascii?Q?gecesYt6fy+HQbmlUvYIYxhHjSqZsutlJ/TeCj5WITrsSrtbnVh7+/rgPOa/?=
 =?us-ascii?Q?cFtOuZOhDlxZZkNCZs8BXY92AT1uVZ4WOKTWhTdGGNMMDOeG6I1zXcHlKACD?=
 =?us-ascii?Q?IORQHvl2NmLL0+xCJPxUzJ4ka2+0cLiGzm9lFoie9vdlfQOmyeSK2ryjkGBZ?=
 =?us-ascii?Q?1duPQqp4SqoVD9Z1Ln7/OO+uaaXFLR077N/YoskBUV5VUrtDeFGUOa8WfLfK?=
 =?us-ascii?Q?kpS8bIuB09lfwxHX/p9hEl32DEAwrsfTrmLx6J50+XO68Ey7IAzKaS8ZBCDQ?=
 =?us-ascii?Q?vT6w+Do5M2cchxARcPtkYdC2wzV7pIuC2jfhApknoQBG4cEsTYFwPPfgI7z1?=
 =?us-ascii?Q?EcCMprmVXdGI6umNkLlUOZTB9w/kDPOXHQnpOyHL6l0yzK99MWUb6ogCjLO8?=
 =?us-ascii?Q?+Jyv8Za74+C2Qv/uj31Hkp8NBkT9yo4EwYPUPoXzayuNX5ErfscaCXML8yY8?=
 =?us-ascii?Q?g1cQCCjdVcATUG0OEkUpnlCoaid4RKt102zPRiQ25w6DE4D0OGFrlhj5gUHC?=
 =?us-ascii?Q?wlzIvlXxELyX6kZXH05GsflwihfnKcrZJHG6Z3igQjbGSTtV9aX8lHNSEipw?=
 =?us-ascii?Q?UnhdTWN91NFG3VmnZKtu/9wc9kxjCI2ziF0VROLzr9bNcv4O1qKb/oUCci8E?=
 =?us-ascii?Q?MDc8afrmUtZcfCkFrPwZ6awxAIhIMUgaHP1PVD8ixp6fACXoRzOie59X3fUj?=
 =?us-ascii?Q?zckFIsHcc1vtWCuFQ9GKB1THVDPJs/sGbT9Gk7jzTkZnp6xZsit9M661FsiD?=
 =?us-ascii?Q?YYXQhVXgmAK6gMWFs0F09MC2Fpbpl78iHDTHG+2Ttn3Azr8q2e4u5OM4q8l4?=
 =?us-ascii?Q?4Dd4BW8J2W1R0RbpsaHZ2lHkwq5trmqVD8BFEkb4DyENAFRTtMKNiVmjG6uG?=
 =?us-ascii?Q?RES/tp5FLqSCkc3XAZ9Fc15VXL6cBfqQ1qqNWpkMvcoqwpoI31ViOnF1vqyi?=
 =?us-ascii?Q?r+YjRwIUSoX+MsLNhtqc+yhq7whj3fSzCRlE6teXhCxznfxSHvUZkDuIzTh2?=
 =?us-ascii?Q?uDTNbnJ44zV6fDDzLx9i5OCmOnP/KPp08a44RGm92QrvrF1VykyEC14/WEsD?=
 =?us-ascii?Q?MXa3e7/Vz7UacPMjUlSa29ZfRkIbsh9/iOXj5yw9ZCgmwAG3+cPdlsb2X13p?=
 =?us-ascii?Q?4WxDcpck07O0ZM+gEa0FxQuIWINWlIksGgJakWTy2dV2tRp9pvSLMdrH8MQb?=
 =?us-ascii?Q?J0ULAsUXMFny7HyzMowDPVXTgSa88aZcOYtWs2b8Sh5KeeURmD4+S5ECEPAL?=
 =?us-ascii?Q?GGWuuRhrEuMGV9q8mftJFmC/glOYM71AHzWK9xHKCzbWxu2MqeWoZ4Bf0vjd?=
 =?us-ascii?Q?hz67QqLZayyqF11Xp0tHRzQaMnWhPsYUSGAH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BXsbR6dU2lvEhlYLV4sg/pWyQuXKE9KBHDRUDTsBbXw0iFzPIzvKLLN/Wfiy?=
 =?us-ascii?Q?M6K8mgkrirJAMNiVdLAAbqEFkj7uZutpdyeZ5FIGkFDiIlyyEH+o/LEByw7X?=
 =?us-ascii?Q?U9lpUWabUdkzFuYn8SdDaA1dkL1YD5ANWtqlAdgDVMkp7Uj6eNmOZ3HzTpZx?=
 =?us-ascii?Q?EHQS4DpJB990ucvFfIWP65Kr+G408E1R6bBlsWzI54hAr7JX7vktv21Ao+Ad?=
 =?us-ascii?Q?BRq1ZYlHXO8tIoFHUI6ru9QVoeoaAGtibJgq7MiFlHDA0vPbNyzBaWYHLHuj?=
 =?us-ascii?Q?+JDUmVDnJgA/toi9Od2L6E/fqdLmoN0rzOnF6BbEWp4Dvcsb0kividsufm1e?=
 =?us-ascii?Q?1r9a6TdHYHTUo88+VbaAUE2OyP6yOglj0a+eVMBwoFUYZ687L5xihEgbgPcK?=
 =?us-ascii?Q?4/fVXG8mcvaUDECIxE2EORiziyZxeO4nbp33t8d+piFsfJeIroOf+bUFVzGW?=
 =?us-ascii?Q?JcUPNAAZeghCiTzhUR8AH+w8t8mmvmJF4cXKC40l9aPl8xTvmZJNXxcN/XvK?=
 =?us-ascii?Q?BHwrvHWihMgrNHX+70r8g328VtDypq6F3aeoNRDTJhFJwyZavgr987CULVKT?=
 =?us-ascii?Q?+W3968l7swqep69OKVOh6gqTn73dtK3cIWteglGQHxcMlLvH4sUF0kxl+cbW?=
 =?us-ascii?Q?C/UezW2F3Z87+qZ7BBUHj5gbHfK/J0tQ64DxdMGIC69CEjHK1Q+hz+5RlUiG?=
 =?us-ascii?Q?mc0unHRIxoakFQIwAmOdFS56DMIRsfn56tjL9vRQ+hs9KJfRsXSH3K17uHgc?=
 =?us-ascii?Q?IOasFgQKX2t1taRsi/0dMSz31iJeG2ryxMogHHzMd8a5seY8HOSy6oDZAJdv?=
 =?us-ascii?Q?lCOA3gk/tl5TZVNj35JUrznoSCyChuf9O2CX8JPtlDtJ2j8UyrlW5bHcwDtz?=
 =?us-ascii?Q?c/sUhNtFDWTdpj6+YaI8pknE/PCodxoqRokU/La+WllEdArBt/Z9dtnH35E1?=
 =?us-ascii?Q?BPWNDO3vQ2Z2TMeuwLQ70i0Y8Eyei/Am6WSQPp51Fc6oItcOd4SrGRwArU3r?=
 =?us-ascii?Q?kbwogB5H2+LtbnAm1QowI/RkiZ62stTnWbLhgyURomiGV+EKXY1/KH195Slw?=
 =?us-ascii?Q?vyIn6AwBEz9OgyHsAR4LsbqduvA74bNl9vb/z/EP5o3Zbd4geEaMjLQrnhhj?=
 =?us-ascii?Q?nBsVDEieB8nIVg9SuVctYvo59hyZXkle+6Prj/1PymZuzxnUGsIk9EB/DLqh?=
 =?us-ascii?Q?rTjgonxDlcmimDPH4gURcipsd8pN5IghMv7kCNefva5B0os0M9QZ2wJw5wCl?=
 =?us-ascii?Q?g822x9mWEB3Vr7FFyzgOqFbC3YVVnrFclh1uzxtXLIJyIrZ/lMxXbBwFG6GH?=
 =?us-ascii?Q?WxC8y/3Osl+CPXvuUpS7GPqtUqEgDnaWi/650lEWN+6EQTs40IISk2rj6pCl?=
 =?us-ascii?Q?6+pSmYuAMAng5+h6889Ov3fve5y6QZWie8aVYv9QEJz3c8D/WhaWJJrGK4fl?=
 =?us-ascii?Q?t5bavi6BoKQ9LAeV0octptHliXj0fGzUU/gNy5gfCV3ajZrdYvE7qwy3JgXa?=
 =?us-ascii?Q?W8OJrlfy0wYbIuZQ3OY47EvpzCyM3NtE2XI+++//u27jxk7JenfgZhKyA0eR?=
 =?us-ascii?Q?/jRyO9MmQUz7noUCLTqOrX68lL3aTWfiJA+9Iki1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff65e3b-2a0d-4f7a-9551-08de22038df5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 15:52:59.4512 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ng4cN01Qvv6GCxXQBDn9jV0MhVej4y6fNNUABttJyRFNX0Zy5BzuZNK1pSOLWfg/yP2hlSgHDLE4dzEnI/ij+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6299
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

>=20
> On Wed, Nov 12, 2025 at 03:11:23PM +0000, Ciara Loftus wrote:
> > The common rx path selection logic iterates through an array of
> > candidate paths and selects the best fit for the requested features.
> > Currently, in the event that two potential candidates are identified,
> > the one with the fewer offloads (and thus less complex path) is
> > selected. However this is not correct, because if the path with more
> > offloads has a greater SIMD width, that should be chosen. This commit
> > reworks the logic so that the number of offloads is only taken into
> > consideration when choosing between two paths with the same SIMD
> width.
> >
> > Since the paths arrays are ordered from lowest SIMD width to highest,
> > and vector paths tend to have fewer offloads enabled than scalar paths,
> > "new" candidate paths with greater SIMDs widths tended to have fewer or
> > equal offloads than the "current" candidate paths and thus were
> > correctly accepted as the best candidate. For this reason the incorrect
> > logic did not cause any incorrect path selections in practise.
> >
> > Fixes: 9d99641d80a0 ("net/intel: introduce infrastructure for Rx path
> selection")
> >
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
>=20
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>=20
> But see one comment inline below.
>=20
> >  drivers/net/intel/common/rx.h | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/r=
x.h
> > index 5012e4fced..9fa3cdc64d 100644
> > --- a/drivers/net/intel/common/rx.h
> > +++ b/drivers/net/intel/common/rx.h
> > @@ -300,8 +300,11 @@ ci_rx_path_select(struct ci_rx_path_features
> req_features,
> >  			/* Do not select paths with lower SIMD width than the
> current path. */
> >  			if (path_features->simd_width < current_features-
> >simd_width)
> >  				continue;
> > -			/* Do not select paths with more offloads enabled
> than the current path. */
> > -			if (rte_popcount32(path_features->rx_offloads) >
> > +			/* Do not select paths with more offloads enabled
> than the current path if
> > +			 * the SIMD widths are the same.
> > +			 */
> > +			if (path_features->simd_width =3D=3D current_features-
> >simd_width &&
> > +					rte_popcount32(path_features-
> >rx_offloads) >
> >  					rte_popcount32(current_features-
> >rx_offloads))
> >  				continue;
>=20
> The logic is correct, but reviewing this in isolation is a little confusi=
ng
> because of the naming. Normally "current" implies the item we are current=
ly
> checking, so I assumed that path was the currently selected path, but it'=
s
> not. The roles are actually reversed, and "path" is the one being checked=
,
> and current is the chosen one.
>=20
> A simple fix that I think would help readability is to rename "current" t=
o
> "chosen_path". We could also rename "path" to "curr_path" in that case, b=
ut
> I think it's unnecessary, as "chosen_path" and "path" should be relativel=
y
> clear.
>=20
> What do you think?

+1 definitely agree the naming could be improved. I'll submit a follow-on p=
atch.

>=20
> >  			/* Do not select paths without bulk alloc support if
> requested and the
> > --
> > 2.34.1
> >
