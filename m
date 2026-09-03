Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8347EC624D6
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 14:15:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B127D40647;
	Thu,  3 Sep 2026 16:15:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 499F5402D8
 for <dev@dpdk.org>; Thu,  3 Sep 2026 16:15:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788444942; x=1819980942;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=VJ9dOf7V4pXHo2CQeOz7Yeku0AKnBFTqzUVmS0Ebo68=;
 b=FuV3NbeiZSIoP5U6qpmVmWEr/xAc+9uMjswPPqjji4/HTPqER9TcHPa9
 zAs4M9eMqd6BDEAmeyezJM5NsJmEEFvpA9QK423yOOE/Xujq3mcB4Sdnu
 1cfcg+hzfdCBhdNy9/3CTqCJ02uLSappQj/ETD4iT12b/S979kkWNfxT4
 PmQgtEHZDv4D6ItyGZIh/A4vVJjqBFXjD1SzjaNqT0I+tnP9EzoH2LLO1
 VaVsADySvWMSrytgGCdpIWACGnFDqifo6fuqcbKK+yyzIfmHFrXDmp26p
 mj0dfINirbd65hBYaJtLv8Ymd7d+d81VwMgMJBB1DCEeci5HyW4IdNy02 w==;
X-CSE-ConnectionGUID: Ot6q39eeR6eALT8RdtwI+Q==
X-CSE-MsgGUID: 6sdU+/OiSPu43wK1vxr+WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88953434"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="88953434"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 07:15:41 -0700
X-CSE-ConnectionGUID: YH/digkMQEWhKr2J8hV/lw==
X-CSE-MsgGUID: Oq81lEoxR2qqXCMvEKNaGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="307952814"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 07:15:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 07:15:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 07:15:40 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.60)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 07:15:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWtRiwGcWT3vLeppxBEk0FIhwJ90nZG1PyRpo1Zngn+cjdqmEZnGi6XPdLAEGH+dG/fFa/OW0t4bey+viJlwBpuSm1Wbu7JjKQg7IsH0dzc1A5lQxij9IUrsOW4xKQG3uGwtLJNmRw1xObwzIQmMSKnrO0i63Lc2DbuNUxujsMng3eJOfBfAa7I+mln+tnbFmDlKZ/rvgd2J60u89wV8YK8uGwPUCVBpuBToeuzpcfbpkhqKaZf8WPfdddLDx86mDGw41ij7ck8nUe2it2qi2CjharyF7qwVFCup/bNEsRKwRIddjXuaq5nrMdHBaHSTS9utXKwwdED+30AMFF/Rmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewZZu0a3oARaq6PYrBF4rlGv6+MoguE/sNDbtpsWjJw=;
 b=ocDDKLCRQsYS1sxKzQED6eUXiKebLszBo6obi590M2eZFu1S2GaJZ+OHfb1LhN5q/+5yEWn2tJUgb9V60pmzOUTopewulLC1OgzVIksMLsLT/Pw1iNsiRUPMdvSpUg2KOVo+mo8d9FkU00ub0Re0jwrP3kc+Vruu+H9XLEdbZP1fpoIfKMrM5ZXFYNF6I42EmCIizPWPAJJbQv5vG8Wxx3ejsfij4W2PvYuTb5b3xZrOTxFF+993SyWuw5TECordyY7+pfRUsExzcwcQ4TBkpmo5VN+OLciBLVEHPphaicbmHMQc5YYPji26YKTpO6Nd7BmVGu58eMSbkYVhyfaJrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by LV0PR11MB9790.namprd11.prod.outlook.com (2603:10b6:408:385::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 14:15:38 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 14:15:38 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH 7/7] net/iavf: remove undocumented conditional macros
Thread-Topic: [PATCH 7/7] net/iavf: remove undocumented conditional macros
Thread-Index: AQHdOTNT/LvBGD1e7kK1lnKlG8GAjba85yww
Date: Thu, 3 Sep 2026 14:15:38 +0000
Message-ID: <IA4PR11MB927894397734A49BCB97DA0E8EB62@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260831102621.495759-1-bruce.richardson@intel.com>
 <20260831102621.495759-8-bruce.richardson@intel.com>
In-Reply-To: <20260831102621.495759-8-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|LV0PR11MB9790:EE_
x-ms-office365-filtering-correlation-id: 51768570-f00c-43e7-61f7-08df09c5d463
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: TT7puAGHOuI+y2M8Tq9ScGXdpUXL6KjtuA+HrO4CFtEp2phiBj7EAr6HC3fzAjzOyEUtP7nmVNSAYMljdJCZgvZ9oQVAYPvO9+0EKHCIDg+zlCwiX+1wwL+w6xUSunbD5v0GrDQ4MpDn0WOyzRq5Djh1df8JweZfNDPgd8osaNB8UhJy1zE5BRzEWFadzxSiQSAlNDkfb6fBBxJItwlCiiOcthQlyq5ib9qM11OKgyBjpyLaypJ7ZX1TYx7B3CjiX7s46XYWXRAjWB8Ir/e/AHVHenZ9fpcvOatZhJepHO292sFrqXw1cNPhQz9Bqd3bnt/jm3XTrHscUhTCwxP7EJUQPccRWuezX/Ko/CWzMNgAa/Y5LrO4GjiThiA0XM+KdwjRqViKypaeNcaQQONQtkaRELBUB/NHfDNezwplXDHtLOaHIjpCHoUtLkSCDlh82Y3GcjeVJVEhTBrXCUGuxoUyD7BL0n12NV5otEvimuxhndluUQMIOVFmRQGEdZ9iEvzvA8qt0bKDGiT+y6jkk8eZ8/crhREp4cq2U2AAkSleyRo0lpUzNYYycmdu7pV/aUZWZHWxEifyUw7nFZ3vtg/4mr/2WY6YFP0aucyDCKDs6qCDBRFxVZeB95AVHCTXZ9UTTTH5Q8QZdKUsdIVnFP2wg8LdmW4AQ9c4cfjxKV4pp3MSW5pCPfktDhwAF20suIGKeyZn2ZqNH/Ib0mBKnA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KyfRn/JlGaMbxJi1VvMs82UlGqACMzrsgYPDrUspR5HVQhI8ilhVTq2rjmeY?=
 =?us-ascii?Q?w4YbpUT+xBylhzx2pYk0UBFx+Q4thb6IFc29eti7usz1ke0YbSyGclnRhGiG?=
 =?us-ascii?Q?XFdjcspSQ5FJ9Dm2vody2mFFbUqCeT1crPf2uNfW7JJC5j2W/NmDwwhkIyGL?=
 =?us-ascii?Q?IWhl1XlImNSqn7lQhv2of7I1V7JrkUHkIXuzNgiMBvQj1N+szb5ZcFFKYebe?=
 =?us-ascii?Q?KFrN/eTkBepSH+3ASXNPtT50g1ZVX/YK5lo1hTLU8w8tI+rtyhLsvsoK5G7Z?=
 =?us-ascii?Q?E15TdY7JE3klNx+rjPIKHq6pgLpF/oBBvDk2CodZVOH7p8WAc8mwuowwElxy?=
 =?us-ascii?Q?pxub9LsI7BJ2e4/AZaULW7GRi2a59452RGMhQZV3hNf41EUaEVG+VczSSSLu?=
 =?us-ascii?Q?4hN0RyfTSRvBbYtTwuiPewKb1scIPJ6ClpiXVMLvla7BUMIqMBIoHSbgecP2?=
 =?us-ascii?Q?Zo0UQz0JNdHHFbeAvDmzt+rYoIbByfWQQ1YzDAwMiK56JQ7XP3+f4SoTftH7?=
 =?us-ascii?Q?8lfdk385NnygbiT1lBD+qwyAvD3kVKDyI13Tx41i/j8tqku2mrlQCK5laSMZ?=
 =?us-ascii?Q?DnZsY9tK+4v2GnjedwGSmpFVSbXuI+CJ3B7mjE4o9FtbR/1AtNwkQkwj2gu4?=
 =?us-ascii?Q?M3B8cXierW2L1YqDcc0+kO5uTC+k5ekRIkZCf+p1MNmpScbd8Goid6zbohvT?=
 =?us-ascii?Q?CUWOVuS8tOmBxw2IX5VIfpn1B+5v2k21xFhC/eeuR2ZWAmy/QWXEuD3ZLwN5?=
 =?us-ascii?Q?9DjdhXCpqgH54hfwY6UpaqagKAu7m3AisL4ueH3OdxsTVKCyH5SWmPOd7vo+?=
 =?us-ascii?Q?JMpjF2VpPXy3tZ8FhvLG1SOwffX76SHOWk5+HAdPilFMNtFPYniaRY1LOdCP?=
 =?us-ascii?Q?j0cTh26l0pCt3U60i0Yb4Xb6KmrHmgEDwlGcj4miXW7aDfKV9Zve26fw7fbG?=
 =?us-ascii?Q?6yR/Dls6tMSGNLPSgGbtbCkkefPSCRNb3IMxFQxOKqHLWp7IuJx6UVNmUaX0?=
 =?us-ascii?Q?J02WW7S4KcQj2bVBtpBp1lS3Q3G1l3JyJSpMTxEeJXhLlQG75Pm+LMZ4Rt3X?=
 =?us-ascii?Q?T/mFF7UQV79CnbRRHPZdSuqxEWhcFS88mDjkNgKI5eHj4XO2EvKgH2ORP9E+?=
 =?us-ascii?Q?A0NJeLhuSJW/NOmJ36MrouuyepQQUZ0/FWuI61/Kybu9x0r0OgV+YCYR36zt?=
 =?us-ascii?Q?18tkVpd20R9l8+qK8CU8LFRayTHb3R0s24AW0NVnrtYwwvYnRNeW2egoKW54?=
 =?us-ascii?Q?uxSGndSKGDPLUJ3QBYMsnMSX9FVwl78o8R894NaZgMx7X/W0UspqVsv06q/h?=
 =?us-ascii?Q?BPMPyj2Z8WqXEygpuzRlKeAz+GNjpLFyW2mEByOOsHhKiyxFA7zsngakxGbL?=
 =?us-ascii?Q?Iv+VOThGGmYSCrGFU3ZYuJxLaeVxqrUBaF6fPHpuDBfOi2Ih3m5no36M5m5Z?=
 =?us-ascii?Q?Of7V6wEbyGZEgkkYGWOItzZpANRAYGUt/OTZ67IItZzC/QSLZalx2Ycz4tTs?=
 =?us-ascii?Q?ht9YGkRibRp1nBnyw7ZC7VF+ROkt7QonexzpazVCqFkHJobgHk1i2I0we6U2?=
 =?us-ascii?Q?XtJ/ykryXUSQDvfd33Eu/2XV7l/2W1HntIjimyx2Q0hqSFnaPEjf5KLXsLUv?=
 =?us-ascii?Q?Y0zjQjDGXVGbNxtIbPCvWiSiiIv1Uq+AIam6CmVBLYPTZu7g8vbRbmNQaDJN?=
 =?us-ascii?Q?+QMIL/418cEWUap67ksX6q7OMZvbU97huayCcCTFiaEYVsYE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cwaJiFpuDlIfHGKHB2MDyRB/DrD8EFPeQzpfxcjY8eBq1k91v0B2eEP1CnnwZQ8Yi22Hge+VdWg37beDMeLBUuW4TkDPv0O+v5drUCJyQj03R/qrjYcLi1+DWZpFlk7CcoH1QJARsFQrJjzIDZ2lBKBsHk/W3ef/GyaUK6wUaAS8qC3F3W8Oi2aFHaLQjoR2zjl33tXUnCM+1vWx9XByZhIdf+MKXcvWny0iTLIIK4ahBxTTZQmWYvF0hfQnapTL1HMOARFRnrfIGsUHeY4ULLdkj0riyDJi3MdjSiO5fLu0WhDWd6AWCDRLHMhPufN2Q/mSTFsuDsk1bRGO4Pa6gw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51768570-f00c-43e7-61f7-08df09c5d463
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 14:15:38.6268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zAhdhcq14dxZdvGG12znhs7eB1Q6pnhH4nAWDZVaLvvvAovPDtSTI644O8RekpGTc2BnbNLt2QC7dkVabbumww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR11MB9790
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

> Subject: [PATCH 7/7] net/iavf: remove undocumented conditional macros
>=20
> The iavf driver included two #defines which enabled the QinQ and
> checksum offload in the code. The intent as documented in code comments
> was that any user not taking advantage of these features could remove
> the #defines to cut out some code. However, this was never actually
> publicly documented, and the use of these defines was never tested in
> any builds, making them fragile - if not already broken. Therefore, just
> remove these build time macros.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   |  6 ------
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c |  6 ------
>  drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 18 ------------------
>  3 files changed, 30 deletions(-)
>=20

