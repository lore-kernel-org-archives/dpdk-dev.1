Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA35C5CFEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 13:57:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02726402AC;
	Thu, 13 Aug 2026 15:57:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 9689040298
 for <dev@dpdk.org>; Thu, 13 Aug 2026 15:56:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786629418; x=1818165418;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=H4p4eatnFpqSm6lofhaEPXJi5ZOYgU+Ma4p6u1pIN5A=;
 b=Abc1aWcEOHx2IZSTYj5l+RUdv3SudIkAhG7Mdhfel16+w2SZPH5Uppd1
 8pONfLzl7cDVpVI2oNsD5BMuyVdjcFsPMrhesGDyyxaZbaUhhE3ugYEWv
 P29bILLextn0rkii4m5AEzI3OMSGzZS6EGSMHkHqlStijoV4WNwaqJ/if
 aAWyUKD9jmViJbqRjATsqcTtw3Vq0i4pQPE+B6/GlTT+wAh4PaUxrtrhE
 AxNoQ9yZXnrqHJ/O51Vc1WpVK3um5iUvTdacBmABlgmp+PtrwiQAnKoRE
 HgyggYAbvcnMlwi+qkjPT/Huu+f8ix16iLJjSp6W+miszqHWNvwVN/YC0 Q==;
X-CSE-ConnectionGUID: k+4czqGvRKWoyLmvLfmDWQ==
X-CSE-MsgGUID: MR3b4m8ERMqwChm6VwDIUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="91014696"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="91014696"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 06:56:57 -0700
X-CSE-ConnectionGUID: REwALZgPTB6bxnUVXS7hOQ==
X-CSE-MsgGUID: N8vJryCEQRqP7oUM/pSAcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="264529010"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 06:56:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 06:56:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 06:56:55 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 06:56:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydE+nBDc/4+HwSwVfMLqkCtunGZP6y6aWfux75i7IM7Z4UwQkbuwE2U9Rdgg/sPxExC10Dqz1iVKdkyJHFSIJnmfUcwVyz4n6sr8unbaYbAKGDuuHZ0xWsJ90LMULfW8Wj3Z7eElH95JD6iPalXEB3n0RthssBmPOK3s3Nlevz8LON0ERNAGZ1K4PtC5d6cUoBkY72BFg483gukXztfAwTgWsB5vHVI2eA04A8msBPtYfbNBF9bMzLl2Psw2FNvN+EiOr7WFP59YKWOX1EQ4CgKgzD2y75jhxZ5VXb7xCySxpwQCytrtwH1yfaTn/X0jp3utjRYyK3N01oUoLYDZsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdSsRMHcBfwSjUYFABJJv2xS/7ioxmv/VsTXlxDdD10=;
 b=ta+wEdEdZxzHuCPulstXeterBVUPCMawrzxy1kHfsqM+PMF0iqNbUra9GDDxDE9viVGkgrOcbq3Omjxulkmif7U+dsK9q4JY083UW+4ke99SbqjnFiEK+Th7MAbeq+rMd+CokP5DrOWCZHjFliMl9FiP1M7Huf45x4nAAYN0oOxpZ7aewugORPPY3J1SVs/NAZHP63DGshHnx4lAioCf6EKXiJQMIpgNFutAwrF7iANXbSi3eZQzhBFUiT09s0ItXeh2VfXnhc5TwI8B2Qp+KFwIS5JPHEP7ueUQ4OXlSDwZmgGrdFugNMYy/SBdHyoB9k0BSFykPmOSwIIi/Gnp6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by DM3PPFA4B6D88E3.namprd11.prod.outlook.com (2603:10b6:f:fc00::f41)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 13:56:49 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0270.016; Thu, 13 Aug 2026
 13:56:49 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH v2 7/7] net/iavf: skip flow flush during PF-initiated reset
Thread-Topic: [PATCH v2 7/7] net/iavf: skip flow flush during PF-initiated
 reset
Thread-Index: AQHdKxEToZdsPsSYekSUzYbjEPvxXbacAOzw
Date: Thu, 13 Aug 2026 13:56:49 +0000
Message-ID: <IA4PR11MB927898B4B2DA1053ACB231908EDB2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <cover.1786617159.git.anurag.mandal@intel.com>
 <8ac1b7833679b57c30c76cf10f170620c2c29f03.1786617159.git.anurag.mandal@intel.com>
In-Reply-To: <8ac1b7833679b57c30c76cf10f170620c2c29f03.1786617159.git.anurag.mandal@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|DM3PPFA4B6D88E3:EE_
x-ms-office365-filtering-correlation-id: 294774f8-c282-47c5-3b62-08def942b8e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|22082099003|18002099003|38070700021|11063799006|4143699003|56012099006|10067099003;
x-microsoft-antispam-message-info: JRhdhTeW3wIYaXB4v9a2B9P3+YFFPPi/3oJfN7gOeT6I+FX2Im5YzpeJnUIjDvu3zm+hLmj2ekZ6t3dDVAU6JLl+afJwSsM13+KJf2Aq+u0Uk64n0z55erms/fTGhNOD8znaMZgZ5B9GRAlMM9EnufMc/O5dHDrz4ElPnLD7gJy6+pz0KRDpSoJiCx66A1OYGccZQz856wH2V8S3nNuf0jnjaXFUmSsGX/gt5YVlzRxkyaVCslKlkjSVGSllP9swXb56ghRsvWxQCAHTdrH6Ph3I8tECXRzBnhKfYHi0kbNfSsJ6fqf0qSuYdNYJDeKFO6pzE8vxe1OgMdJ0mpf7r4RBdzBTeM219jdNoQrLTh170+BogCHCDSU5RtJyPjwADYGg48E8o2SwDPCjInqqB1eBUFVHa6R2XOo/qz5DOat2MQoJp2eRHj/RyKw5XI/Hd2k+WJiLdU4dZK/D+F0htIxyRWOwhI1HHSubBzZikjGhihs4CdVRAKvmMDv+Hz3Zlnp9G3KD3L2D2EZiDNi9bF5pWqd4LKxe0anMkvAhw8hInYUrW81rdLVePflQL5teCjQEVAYBXxPRk5ceegGTIRtevfocY+93zdIaCjSOa71GxI0RKTHEZXBc8T9eUrH8FEsM8PiBVbNV1/+MPpT12TDg1E1oDpyGbj4Wb5/fAtCySaxa8VmclvDX4q67itpQjd1rdfIHVdUbhb4jCMnNPrcjIW11L6mvVdymEyatoTI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G/90swBGprVXrYmi0oKUoRa2ofgsCM7pz8HGUmYPNx7oxPZISlxO1pW5XGa6?=
 =?us-ascii?Q?FmhJQPUI72vRX9lIBa8M/FpAAs1Gmj7ZqYMz82IVky7/pm4p/efZVHiSHW8o?=
 =?us-ascii?Q?0NGrIFuCD5kBIYW/v98nwqCfU010HAmMUzh4cTV4+tCvYjXR8eLl1SvH8u7z?=
 =?us-ascii?Q?RrI89TPTACwSrRC/ZPU9uAoi6FlfPdcouHZbxde7oJTEJ+0zjCZkywWPy9WI?=
 =?us-ascii?Q?slt4wXzuaPOt4wrbRS35Wlib65DI+LXjQdkLFU9fL+kari4KPmRqOBOHPIdh?=
 =?us-ascii?Q?Q199OYZjsfE920nmYsIoSELDH0+TSUHJCTueCAeLgg00aq8yAZa89osAy8l1?=
 =?us-ascii?Q?JYEKkd1GSgVaQgrgeRDKVUT6QKRZV0bIRMkrYgPuSt2+HpIRhL0k7fEfrwNJ?=
 =?us-ascii?Q?w/jzd+J9TkNtHj5XspiiSohiqYKGGK0YlxDSrZGfMAqR9T/EAsgs3qNEW3hn?=
 =?us-ascii?Q?dk58u5yEM0ZZh2+3Strt+c1iiC3l3jNoFtai/kLQwHsYZ5qjprG95nd08ldC?=
 =?us-ascii?Q?uRdM/VE9MyepF0EtDlP+bcHPgxSszk11QTXIvYAGN4GpWI5c5hmOSaIDTd+j?=
 =?us-ascii?Q?QjF/SoD5b1ETcQjASxn1ZW1m6GhVU9sIMGDWiwEe0QT3WnIMC9d+Pss/FOIH?=
 =?us-ascii?Q?yh8g4fa7Srym6TY1JBuMCbqu/y5kHOv9/u4LKMVyNo89dZNzlTVF+n10Q3+E?=
 =?us-ascii?Q?3gXdqn1aj9M76NduWgO+mLT31RX5IX3a1yfs0t2fyDXs6x5le6yR3Xz9TcxL?=
 =?us-ascii?Q?0x5EEJz2RXydnPmcRu7/jzE/paidnMjWqfAUmXz/ZnlKLfrjLLPoSkV6HCbJ?=
 =?us-ascii?Q?6I/G63vyS5A3fjMYcoAWgYCq58HANlr7TwEf75o3Z5RWqkMEIJuchFsmv5wR?=
 =?us-ascii?Q?GZLazwOrxkywKryEhXIiWyQf2jrlF/5c061oAiUf1h43P+HZ1aQ02Akmy7Jl?=
 =?us-ascii?Q?7hEV2xPqBWJF8Z+tTpd972f0Bsw08cr6g9p2w5DxyOqOLi33x56Re7pTmEZ1?=
 =?us-ascii?Q?ws+zWJU+PfUZRWa1J1DoCZ7k5wsRSa/tilIfkVDsk27sNy6XWCUqLcIK75mp?=
 =?us-ascii?Q?xfyb4ftmOz2DuZ/mP/uLCWT21DbOcNwsIRCnRqwc2+IuUSi126Jvm+rIA+LC?=
 =?us-ascii?Q?Zw4ArrayqmbfuL8NxTHi2vBKXqxD7FKpT2Q+CVuaOXr/8wA4F6FJZi2A42s4?=
 =?us-ascii?Q?cvqm+IdVJPw9VDQ4opXOiYiNHaUlcYfv0KyNxZUEMPbOQg5QLQnqrZdHcM3v?=
 =?us-ascii?Q?bEmgfYT6X5iXJ3qe8FzIxXPODw42OzOg8hzohrFwRp0Mca6GOT/eQSvqOrqz?=
 =?us-ascii?Q?LmFJSQv/LyY9eVTxIqSpVkPR0tw9TeXwhwMldng+8rsOB9t7Coo+SozhegOL?=
 =?us-ascii?Q?SpRXvI/X4iFvwyp/ZWYoe5jv320LGIICjP6ndYRan4DVqhb2MyxZ2oCsfHIf?=
 =?us-ascii?Q?xXtN1g7DifcGRac4qKGUZmldI0OUc1aPLvdnGVLcQI1uxDxrN3OYeETHRr6e?=
 =?us-ascii?Q?XkN6JhWmi5nYR0HIQfz3IbwzCBl802RtpgD1I4vYefVy68UD7fBSWNk/xMMD?=
 =?us-ascii?Q?i83an8g9Ahz0EVbi6+bFwFpE5ACyX7NJvfnKtgLuH2h4G2hEp4BUxfXS5ZOt?=
 =?us-ascii?Q?sU2zesi5nz/Q/GuKzLYGWYtnndfn1Ju8T2+JUsE3i8QuxvunNNvlmbETIYIW?=
 =?us-ascii?Q?y/zdEyJvXO+kTJ7LoV6ak+SjL2eCrPejFoRxpl7/0FYqfD+yfosF9F3soqxc?=
 =?us-ascii?Q?RO3MTfQfXQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mBGZGyPaQnwdikqEw4Wwy0t7dv8a1Zyvi84E3Vld3bU6u7wr7q9X3OezRh2k/y6HNDrNIjelbwGqVrpGsjiFKC3T6Y90fSKKnY66H6DKTvk/a6UXLXzeBXJBNL68FQ8UPDhHo5YknkMzTTUAXob8n7KVlLNGDSwf93unb+1ZQ2PdMOckHndMQBjjy9BxbPYe0tao7zhCWKnkNXA5wRLs+OkKyVecQtlERa7RIoCFW1zfCbREDJky966cGEqQq2zuA8JvJf0/MY/QuuX2wI9upchIO4sdpj5n3FWIPUdzA5/mJLSUGkvUGI86nXxDBJfbRgLEUJehUZ2kdYyVCCXDTg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 294774f8-c282-47c5-3b62-08def942b8e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 13:56:49.8097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BT2lk2LXQeGTqoX3ZU10uM6pqPo+iaro0YQpFfhw59uRA9NLeg+KpLyp6ryO4vUrppMwMuzW12t9le6KXlGpIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFA4B6D88E3
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

> Subject: [PATCH v2 7/7] net/iavf: skip flow flush during PF-initiated res=
et
>=20
> Skip the virtchnl-emitting teardown on a PF-initiated reset.
>=20
> Fixes: ada64daa1a5b ("net/iavf: fix VF reset for flow director rule")
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> b/drivers/net/intel/iavf/iavf_ethdev.c
> index 322b59d68c..5373e71b69 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -3235,7 +3235,9 @@ iavf_dev_close(struct rte_eth_dev *dev)
>  	/* remove RSS configuration */
>  	iavf_hash_uninit(adapter);
>=20
> -	iavf_flow_flush(dev, NULL);
> +	/* Skip the virtchnl-emitting teardown on a PF-initiated reset */
> +	if (!vf->pf_reset_in_progress)
> +		iavf_flow_flush(dev, NULL);
>  	iavf_flow_uninit(adapter);
>=20
>  	/*
> --
> 2.34.1

