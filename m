Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F16C3ABC0
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 May 2025 15:25:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B565F4025D;
	Wed,  7 May 2025 17:25:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 53EDF4025A
 for <dev@dpdk.org>; Wed,  7 May 2025 17:25:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746631544; x=1778167544;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=WS6XhiBHTAtJ/TAW0HqkKpBmEBcV11M+ajKC2c+RkUU=;
 b=gQPDhXAeZnxLeTDYSsbiV++wQwR0EYrEf6dhoJ5Q8CxhoA1CvA1qa2BV
 QK30BA8wsB+9EmP+h7UkRh7frkawydybtCh1iUoZQa2JNq8pTwadw4Toc
 wPd/jOGHejrrKyysYY3+L9FaGklFlHpQ3Pqqd5BZPEiR3LExG1YaQuPBk
 Sw3SliDHUTJamAxxNvr5FhWgZzU07AWZ1Nze31hSno7L2JTPw+1GKx9SB
 rkeuTqJ6SbMjqt4JufVDKw5e6Z+JiE1tq4+Y67usArjJ8pNTtovIX2m63
 OvoWdn9U+nefnx6zG6hGiN2NE7aWMEL+VMlp8MLkehDRWh9ww0Rl2oJo3 g==;
X-CSE-ConnectionGUID: yk7usPkDQQ20VRNjeiviRw==
X-CSE-MsgGUID: OtUMsJ/sQ72ElRt8yWL4Dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="59028930"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; d="scan'208,217";a="59028930"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 08:25:43 -0700
X-CSE-ConnectionGUID: oO5yXKrUSkO2sI7KWdylkw==
X-CSE-MsgGUID: nGTk8GF4Sy6NbA9A5rDSUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
 d="scan'208,217";a="140841844"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 08:25:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 08:25:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 08:25:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 08:25:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSaNSbkBkAm2McwQG8jIGwEfWZjVXa7VMx4ntFlzPH+TtgXbiXnooUq5CDfdylipzVGAfU5ipMD3PGB2rGYTrw2DAOE6lce+43C5cc7pJOkhl5ft2lT4miPbop+8Fn3W/mfmfTNnRyUd7Ud2ja6KTO1I93AHPB8rnZ3CkIEQsxhz1xix0rL2wkGwwtOxcNgjY0SWa9g2JAPvRas3RgN2JHdlANOYCzYnz28YwBCtfur8ISq6e7MWJBE+rH5kUhJ6hoQXgkfoEQjj7Et4ijgOpUJs1h8eGed4hxEQM1eeQW98/PKldDFwuAA+QezafYsD6HpxxdfAAIaruXSMvA6IGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOjlUanjnkPhluh6U+Md922MQdP31155388c8iga/zE=;
 b=n8884JGqA1VsRpCeJ+v2tRDNoDw4+IOon91d2DYDKOxpnn3mOwQZnd05iTJE+UTlZLc14lxTtGFKI2uW8hAkGNxlxq6GCT7chm06THRRCo/TUjUG0fEELji8N3X9ZKpqS/OUlqIh4eFU/btUFVaHUuJ9q0TILsAkxf45Yqee2Wt6xMnxwbxXue/ie97bEuiTzHszwtaWxg3HvXtpJt6BWFQZPue6+YBgeifc1HxlVQXLoD2wRgAGkypiiquNesTUDfg0vpd/7R0nTLiNat6bG5m6QLlc9wadKRHeAzVtDojlyszQ/wsdYqM/MwX8BCyErOxBxg6yCNgvHvQ18a453A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by IA4PR11MB9132.namprd11.prod.outlook.com (2603:10b6:208:56d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 7 May
 2025 15:25:20 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79%3]) with mapi id 15.20.8722.020; Wed, 7 May 2025
 15:25:18 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: Yang Ming <ming.1.yang@nokia-sbell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v2 2/2] crypto/ipsec_mb: fix QP release in secondary
Thread-Topic: [PATCH v2 2/2] crypto/ipsec_mb: fix QP release in secondary
Thread-Index: AQHbp32qmg0KacNIKUSAnuBr0goc/LOy+rqAgBR653k=
Date: Wed, 7 May 2025 15:25:16 +0000
Message-ID: <DS0PR11MB74583A392F4BEEB1E2AC9F2E8188A@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20250314103638.2198-1-ming.1.yang@nokia-sbell.com>
 <20250407052532.1913-1-ming.1.yang@nokia-sbell.com>
 <20250407052532.1913-2-ming.1.yang@nokia-sbell.com>
 <6d31ea07-8bbb-4e9c-ab88-be50e0132e31@nokia-sbell.com>
In-Reply-To: <6d31ea07-8bbb-4e9c-ab88-be50e0132e31@nokia-sbell.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|IA4PR11MB9132:EE_
x-ms-office365-filtering-correlation-id: 5f72c8dc-6e6b-48cb-5589-08dd8d7b5e6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|13003099007|8096899003|7053199007|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?OzFbgSw2gjKt7yn/MqwypUmz18007TNrf+mMbChrzQIzWy+rkaONd/yIxR?=
 =?iso-8859-1?Q?TN07txa7a9dfUP3fbVJ4picXC0iVSx0c+2BARYX0axr2sUwiENiJia5422?=
 =?iso-8859-1?Q?AqXGQZivOL7e9caX+83l4cU/jXznj7VRvmZ5ny2UAZyr2BqXkLRHVY2J1l?=
 =?iso-8859-1?Q?e+95x0nKVAfWxNX41+zM5L/c2amaBDANWK3fTl92Fe4+ZKk4S5o080pC10?=
 =?iso-8859-1?Q?fOwC7SK4XLbhQI0iC4qBJOnBp/lKnVPsudWJWg2/R5UG46uDOPbWV7naCj?=
 =?iso-8859-1?Q?vXwgKyKflawLwy4AkzdzhLKWD6xItduZmMpcaRIHna+giXQydYj2eGVbUz?=
 =?iso-8859-1?Q?3kztxaiAoVcRjR/w8t5w5kGmQP/bIeaN7M8d0PyIMtA+K1BnKoUcbUprhP?=
 =?iso-8859-1?Q?kE9Eepc8BnYcrmkGgJN3yuBS1SzTdS2eLlL+paa/Htc45qqA3XZHjzP8MT?=
 =?iso-8859-1?Q?7S7JzWqydLa7WO10AsRdOSvENJXsSYIImtnqrXeODLeXYSLtztRuLR7Fqa?=
 =?iso-8859-1?Q?fMgS2V1FFfaWKvorEfOP/SwCUorMJrevOnGPJL8VB2X5XdIQQVP2Juip1m?=
 =?iso-8859-1?Q?SSd6XifYNXRRCJDlPzhBK4FDjt107LPwlS9iTHIwuX5WqsebbHakASr5XS?=
 =?iso-8859-1?Q?1gwYRyUf+sv5xs//SNdmDjNweriSsEodd0cjkTxO3cUrFph5SWmeMTXj89?=
 =?iso-8859-1?Q?VetG5qMJ1gOcDzzjcjFO4p3sANxNzOOjeU19oMWmulZCtn4WcKjshx6K1s?=
 =?iso-8859-1?Q?dOE2Km66X64Dfiys2RvJUTBdhCuCMHb/Cbaebv1K4O22WpZIU+Rr+8qlM6?=
 =?iso-8859-1?Q?4ckOL6+lTQypFsREuuN4hPYPGNZCEX8AY1772vtMj2lZkr4aXkZxiN810w?=
 =?iso-8859-1?Q?CYnnsGUYwBzbKVjA+FUt9Uqb4d71YGMScSiaEh5v7qzMHJe2YYegLMh2/N?=
 =?iso-8859-1?Q?2e+OWYQmvt7htXvN2RPbswJbna35A9t+dHxcGhGiimbqa0OvTp7dgpk/LY?=
 =?iso-8859-1?Q?WTQXQnH4eZgLQFEVFgjDqibX8+5+7TcxoRIuzhybJ3xGuf5w9e/Zdi+93I?=
 =?iso-8859-1?Q?mUpFoHGeOI0wRtHDy8ly8TnA7ep3JqZsTipQhZNCh7Ms7/T5LdMIK3/OQA?=
 =?iso-8859-1?Q?30pokACDic8hbD/LDTGq3aQmye+3KPt2C4JYVEmgT5aYCsbAqLVF5f0xKk?=
 =?iso-8859-1?Q?BK2brXxcxbqczcrEvu1qQiSF8f90UxI+fsg5uyzeNeuSLXQnorZti0guq8?=
 =?iso-8859-1?Q?J9O4xxZiQks16Mtay7+E9QjZvcB1NV5J4NiV3luNkukUtS0rzXUs5jJ8iH?=
 =?iso-8859-1?Q?wVr6iZU1dVSAk5RkUbvrjXl5sPYc6jTn680aTn/7EeLqdyHEzHEijpGII5?=
 =?iso-8859-1?Q?BhLZjSvROK4YzuT8+EkssBWH1v+ifX0HiEBjeznipDfwl9Jkamf0f1K0ZL?=
 =?iso-8859-1?Q?9ZokJwzTPcrcEdYpLg1MvXzC81ffhrHAmdAWO1uWNGBZegwH62xQH3CKwU?=
 =?iso-8859-1?Q?o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fW5k3U9zjT94Hj0GSYuUX7QZQSicLrk8q48B3n8Qcudz23uQ1u4xsAbYF8?=
 =?iso-8859-1?Q?gPSv6X9KXtBjuwkuxA7N1IBypMFkPiXUUQd3AyNVLiBY+sGQxDFNxN47qn?=
 =?iso-8859-1?Q?cwESdEL5PopxH1zOjoxMU0/GFJNP8laDKICXp1MpgJ2ecRt181cH+/Edkc?=
 =?iso-8859-1?Q?yFNQ/G7xJ5FJCgzOZCmRAITM1DiJZo5nFjUYIG2U9ttnI8QVUwDmh64of/?=
 =?iso-8859-1?Q?Y3HtKDkZUGeX7PRyE84I5llVg26QlwEPWN5Wpykhhc1jTlra/fzVTaDp9u?=
 =?iso-8859-1?Q?x/78p9u83fKFkR48SWNMv5ZuMZ2EJvzPmI2taUxv7W9pv4rkOyfgdOFRMk?=
 =?iso-8859-1?Q?PlNo600/yRP7wzMnRLdw3SUy45X+X8a6UJSWqbcZA8+fhgLcDPcVwE784W?=
 =?iso-8859-1?Q?w+lNeFhLNDlEbwy1S8zk3x/3PxAktHi2S7+AhFJ8PvuFpIZv4YghClhkd6?=
 =?iso-8859-1?Q?BzmclY/JfEkKeCss2NUDjaBgc9x4yVXy4jZ/i0OUAjBKp3T9mHd5KezNIx?=
 =?iso-8859-1?Q?kNRmbh8WHXJVerpKH3p3EAAOyIrzarc+2mGbvLX5+wk/AN+Bkc4Rk4cf0N?=
 =?iso-8859-1?Q?IWZ770iWw7QZzdXqLcQXUD9kAa+pCnYMhLYtYRbNnHNFPEHXapZ3UAgBKb?=
 =?iso-8859-1?Q?BiKPKAdj1MMV1xM5Cnbwi86jNvUQv/4MzdZGlkUy3IK1/OqOuAOdk1Eg6/?=
 =?iso-8859-1?Q?zAUkCQOLA1rhK+SnOMl0hnMoWpS/vdrgRfSqRWJI3xvsxjxEcEbliTFsrV?=
 =?iso-8859-1?Q?E2npEK+JDQVlokigHR1FuT8cjQZfreFvOW8w/voQhVS0OE3hBCBOyisK20?=
 =?iso-8859-1?Q?YtmWQQEZBb1FVdB4VV0349tBUEkux2DT54LDPE7GflL2Mg5RPKYjoLKmDZ?=
 =?iso-8859-1?Q?4GWKowo/JGpBoWSX0xcBy1d6HuVi2mR45otMhbAvppHFKcLS+pXY/MCRQH?=
 =?iso-8859-1?Q?Qkeh0Zc403txbNJxcTc3mBKqgQpRShtvtlbQNP269WRV7GtQImMtmcjAq9?=
 =?iso-8859-1?Q?n8xMjdFu4qPoRtlnyu2F0rbV5dK79jMCYqQVILeORsj4H+0vQMwXrh7Wta?=
 =?iso-8859-1?Q?3sOz5okKtQdfB59XvJDWjcq21ULJe1oCqSifGsRnGuep8A84vgkIuvYNSx?=
 =?iso-8859-1?Q?ZPLqXcpiZ7VUOeI8v+UsROIhxqXHdRNQ//qPQ+L0UoP1OVI/55e4657KUZ?=
 =?iso-8859-1?Q?r3z4kvO8pmJorr3TNpHi5GnBjPheQY9jjO4eHgAqgLNaQnGeOyBaWK6dy5?=
 =?iso-8859-1?Q?KNLcPPXSUYzujH4RSotML828K8oemyixkpHRTnZYqoXEMKuTC4X55MlX+Z?=
 =?iso-8859-1?Q?YaXSzXElQztOxunsDGuGJOte4/PUpg6i1I+yQvC8PBrLrhkswv0BxMrC+1?=
 =?iso-8859-1?Q?hjiRB+OtFUbK31ciUl8FZeHG67iadEt4LzdrXkvzfpCDxOOScFlweUQxWb?=
 =?iso-8859-1?Q?uUXlLYcZ4JKPV7CiYs+hwVVLukPSqrWqC+apUuFGsvHHOMKKYuuy9JjdC5?=
 =?iso-8859-1?Q?5WRmeZH1oREN7Xek9qpomxibLiKqPsU7yNAwtsiF401bCQOPB5dzHyaFgZ?=
 =?iso-8859-1?Q?vHFcctE3cNRjXuNIRHPMx9QOMRhKi2FRisD1hYSG4Bud+/oe2a+wv751hj?=
 =?iso-8859-1?Q?x3qjGgEGRasAU=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB74583A392F4BEEB1E2AC9F2E8188ADS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f72c8dc-6e6b-48cb-5589-08dd8d7b5e6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 15:25:16.0934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sCCu7wQNO/3IC8W8fTSuqMO5/Ct+K7EtOUBT85TWoaXN4QlfNHA2vkel2oGMte5jV/HG31XZZArkfgRJ18IG3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9132
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

--_000_DS0PR11MB74583A392F4BEEB1E2AC9F2E8188ADS0PR11MB7458namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Yangming,

PID check is implemented here:
https://github.com/DPDK/dpdk/blob/75f179ebe347b6098cf3af26d3d3b7168fe3fe24/=
drivers/crypto/ipsec_mb/ipsec_mb_ops.c#L376

Can you share the steps to re-produce the error ?

Regards

Kai

________________________________
From: Yang Ming
Sent: Thursday, April 24, 2025 15:26
To: dev@dpdk.org
Subject: Re: [PATCH v2 2/2] crypto/ipsec_mb: fix QP release in secondary

Hi,

On 2025/4/7 13:25, Yang Ming wrote:
> From: myang <ming.1.yang@nokia-sbell.com>
>
> When a secondary process tries to release a queue pair (QP) that
> does not belong to it, error logs occur:
> CRYPTODEV: ipsec_mb_ipc_request() line 373: Unable to release
> qp_id=3D0
> EAL: Message data is too long
> EAL: Fail to handle message: ipsec_mb_mp_msg
> EAL: Fail to recv reply for request /tmp/dpdk/l2hi/mp_socket:
> ipsec_mb_mp_msg
>
> This patch ensures that a secondary process only frees a QP if
> it actually owns it, preventing conflicts and resolving the
> issue.
>
> Signed-off-by: myang <ming.1.yang@nokia-sbell.com>
> ---
>   drivers/crypto/ipsec_mb/ipsec_mb_ops.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c b/drivers/crypto/ipse=
c_mb/ipsec_mb_ops.c
> index 910efb1a97..50ee140ccd 100644
> --- a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
> +++ b/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
> @@ -138,6 +138,7 @@ int
>   ipsec_mb_qp_release(struct rte_cryptodev *dev, uint16_t qp_id)
>   {
>        struct ipsec_mb_qp *qp =3D dev->data->queue_pairs[qp_id];
> +     uint16_t process_id =3D (uint16_t)getpid();
>
>        if (!qp)
>                return 0;
> @@ -152,8 +153,10 @@ ipsec_mb_qp_release(struct rte_cryptodev *dev, uint1=
6_t qp_id)
>                rte_free(qp);
>                dev->data->queue_pairs[qp_id] =3D NULL;
>        } else { /* secondary process */
> -             return ipsec_mb_secondary_qp_op(dev->data->dev_id, qp_id,
> -                                     NULL, 0, RTE_IPSEC_MB_MP_REQ_QP_FRE=
E);
> +             if (qp->qp_used_by_pid =3D=3D process_id)
> +                     return ipsec_mb_secondary_qp_op(dev->data->dev_id,
> +                                             qp_id, NULL, 0,
> +                                             RTE_IPSEC_MB_MP_REQ_QP_FREE=
);
>        }
>        return 0;
>   }

Hi Experts,

Is there any chance to review and accept this patch?

Brs,

Yang Ming


--_000_DS0PR11MB74583A392F4BEEB1E2AC9F2E8188ADS0PR11MB7458namp_
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
Hi Yangming,&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
PID check is implemented here: &nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<a href=3D"https://github.com/DPDK/dpdk/blob/75f179ebe347b6098cf3af26d3d3b7=
168fe3fe24/drivers/crypto/ipsec_mb/ipsec_mb_ops.c#L376" id=3D"OWAe6661da6-9=
642-8ce3-0501-07105371936c" class=3D"OWAAutoLink">https://github.com/DPDK/d=
pdk/blob/75f179ebe347b6098cf3af26d3d3b7168fe3fe24/drivers/crypto/ipsec_mb/i=
psec_mb_ops.c#L376</a></div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend" style=3D"color: inherit;"></div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
Can you share the steps to re-produce the error ?</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
Regards</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
Kai&nbsp;&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Yang Ming<br>
<b>Sent:</b>&nbsp;Thursday, April 24, 2025 15:26<br>
<b>To:</b>&nbsp;dev@dpdk.org<br>
<b>Subject:</b>&nbsp;Re: [PATCH v2 2/2] crypto/ipsec_mb: fix QP release in =
secondary </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">Hi,<br>
<br>
On 2025/4/7 13:25, Yang Ming wrote:<br>
&gt; From: myang &lt;ming.1.yang@nokia-sbell.com&gt;<br>
&gt;<br>
&gt; When a secondary process tries to release a queue pair (QP) that<br>
&gt; does not belong to it, error logs occur:<br>
&gt; CRYPTODEV: ipsec_mb_ipc_request() line 373: Unable to release<br>
&gt; qp_id=3D0<br>
&gt; EAL: Message data is too long<br>
&gt; EAL: Fail to handle message: ipsec_mb_mp_msg<br>
&gt; EAL: Fail to recv reply for request /tmp/dpdk/l2hi/mp_socket:<br>
&gt; ipsec_mb_mp_msg<br>
&gt;<br>
&gt; This patch ensures that a secondary process only frees a QP if<br>
&gt; it actually owns it, preventing conflicts and resolving the<br>
&gt; issue.<br>
&gt;<br>
&gt; Signed-off-by: myang &lt;ming.1.yang@nokia-sbell.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/crypto/ipsec_mb/ipsec_mb_ops.c | 7 +++++--<br>
&gt;&nbsp;&nbsp; 1 file changed, 5 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c b/drivers/crypto/i=
psec_mb/ipsec_mb_ops.c<br>
&gt; index 910efb1a97..50ee140ccd 100644<br>
&gt; --- a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c<br>
&gt; +++ b/drivers/crypto/ipsec_mb/ipsec_mb_ops.c<br>
&gt; @@ -138,6 +138,7 @@ int<br>
&gt;&nbsp;&nbsp; ipsec_mb_qp_release(struct rte_cryptodev *dev, uint16_t qp=
_id)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ipsec_mb_qp *qp =3D d=
ev-&gt;data-&gt;queue_pairs[qp_id];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint16_t process_id =3D (uint16_t)getpid();<=
br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!qp)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; @@ -152,8 +153,10 @@ ipsec_mb_qp_release(struct rte_cryptodev *dev, ui=
nt16_t qp_id)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; rte_free(qp);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev-&gt;data-&gt;queue_pairs[qp_id] =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else { /* secondary proces=
s */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return ipsec_mb_secondary_qp_op(dev-&gt;data-&gt;dev_id, qp_id,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NU=
LL, 0, RTE_IPSEC_MB_MP_REQ_QP_FREE);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (qp-&gt;qp_used_by_pid =3D=3D process_id)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ipsec_mb_seconda=
ry_qp_op(dev-&gt;data-&gt;dev_id,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qp_id, NULL, 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_IPSEC_MB_MP_REQ_QP_FREE);=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
<br>
Hi Experts,<br>
<br>
Is there any chance to review and accept this patch?<br>
<br>
Brs,<br>
<br>
Yang Ming<br>
<br>
</div>
</body>
</html>

--_000_DS0PR11MB74583A392F4BEEB1E2AC9F2E8188ADS0PR11MB7458namp_--
