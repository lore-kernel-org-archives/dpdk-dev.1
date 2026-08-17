Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69D8C5DF70
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 09:34:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE0BF40611;
	Mon, 17 Aug 2026 11:34:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 3558640613
 for <dev@dpdk.org>; Mon, 17 Aug 2026 11:34:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786959297; x=1818495297;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=K20hMsNh8+F87Nj3agdU3qW+xFSphQUIW6F+WpnxUFQ=;
 b=TskipQ7B4or6Y5O8AG6bVYqMRE8izc1wSzQkJhumyf9jPgzd1CgzUV+o
 JYdE0R/WXMOMDpBjvvao0t/6msorr/w61mkZwV6TtkyKOsiJlSOqvGuOI
 /YyjcX/2RkwL7FwaRdwr/Mt6aRJRsiFEx1GBdlkyotfmfp6BKT8PFWukT
 spv59TV0i/znxdsPFxFXTFyM9Vq3AHKmeeEL2XtHqel/cN/8i1wDnZ1ND
 F5MtgtjYu77UUSGLpHyZpMS1XHN4tTXZH2ZaTSjrFqYw+hUytSkkFk5ju
 4tvKjNnlb8yhgsWRM0CQMec2a02EVZ/gNvomlJ12JRJSJXemlh/F1qmMD g==;
X-CSE-ConnectionGUID: E6wuAkCQSDqF5PPkyCQgbw==
X-CSE-MsgGUID: btXiDMcDTSiDQVuEi0JamQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87446840"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="87446840"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 02:34:56 -0700
X-CSE-ConnectionGUID: qqfca8ADT2684CVdgU8UZA==
X-CSE-MsgGUID: 0dlG51RjQkqN9I703yNk7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="268350306"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 02:34:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 02:34:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 02:34:55 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.43) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 02:34:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLjR62vzA0Y6wzusaHkjrndPkAdeLVdHeOpH2bwEciJCXNDj5DdYUOVNz74EWnIHStxkwFK0Cj8tw8tTuboilY5bGJlhBnH9syOOv0fWsSbCcowBFcui2upr/IhTIMHl1jHVq9FEEOxk+fS7K4/ybzrnHPdvhs3IFlsmVWxB2t40VW4xWRMQuWOUi0y7nBGpApqaFUMoofB4kgs23TSbN53J0FUNnzgNOoWRwZtoX6/0g99XuupD9+u6FydBSD8zrPkqQ6bmz8PkymzEo6tET+/GadNQl8RgOUNSXmdWmBhN5gkS4OzPGEpOm1hUlfI815yLng4hp27F2j5abWAvXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxy6PQqsPIVWNVq1c17yPOvFQ7vkIBdf0ftAhtpV6Qc=;
 b=ayZ1jyTPqH4Smd3ERF0b6cVZiXrdvnpok7btRA+6tOYdMyPPCg0I44hCMxUvpKp2lFe9rJOEDrhpjLSof/stR1+rU0kKiWQ1SGzEWtLdMk3Wt5cy/fpzfVkNPBjNd05ar9lccKAP6fOnaThloWVbzSFnXch8/VyD62iDkFCv+kZZTIFZjE6GKOUjX/JDuEbGcl5EkGw+klpeThsw/tWPzqZshQWGgEXigRI7s3bBKWkSl6EVwzXFP8uB1Ays8AVpf5/L0+mAktrijLO83oi0ubB6vLDFpaaDMaK0HEUfhIyECghfTr5Iy52/VIE3HuiR52oqbG9Q3BaNxv86v++qFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by IA0PR11MB7211.namprd11.prod.outlook.com (2603:10b6:208:43f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 09:34:53 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0315.014; Mon, 17 Aug 2026
 09:34:53 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH v3 6/7] net/iavf: keep watchdog armed for the whole reset
 window
Thread-Topic: [PATCH v3 6/7] net/iavf: keep watchdog armed for the whole reset
 window
Thread-Index: AQHdLhSmXDIxPsQUqkmVLlwaaXlw0rah+vIA
Date: Mon, 17 Aug 2026 09:34:53 +0000
Message-ID: <IA4PR11MB9278760ECE38951F0BA9818C8EA72@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <cover.1786948817.git.anurag.mandal@intel.com>
 <2158af5afa7b7e8f63224b466151608e040140b2.1786948817.git.anurag.mandal@intel.com>
In-Reply-To: <2158af5afa7b7e8f63224b466151608e040140b2.1786948817.git.anurag.mandal@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|IA0PR11MB7211:EE_
x-ms-office365-filtering-correlation-id: 39e25776-dd3a-4d93-b3fc-08defc42cad9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|38070700021|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: zV8/Q+vX0lzx9lkqEvgyOvdq6xtNINoRvVOvGFCZGwAz8hjfFzznfKn2tJIxPfK6L5RLA7UHDgmacemkulzrGnEDEE2wHkO7mB/HaM2g+1VZnPlDPmQbgsckgYBJhZmmgTcSYvsK57A5AkeUqdp0hebObmEe1iKCfAiZX00fP8O8/zur9PzbRqvmiro+KtwCMSfZ5TNr0KBzgJEyeSsz28rfKIi/Zp+jdUhTvAD12AWvqnSOd22BBEF0Twh9hrfwkaGHTiwNgPi5tVMJrZAK3mm4KLbWZQI3H4GgU3HPb1T1qfSBtDAQWufSvENebc4AFoP3aGGB8n4pYAUFzx/GNa03bPHltj5Ij2WpRli7VScNL4mpk9MIWPDrKhscGsDXpgoI9PsFSGDabwNYhXyoq5V1OkqG3FfFqiuGGMzxhjkujoD1AJSKpdjmQNMKDdnMmzIAok2/D6fzrcaUYYZqNC40UMW5DgsKKIv7qwDiRWuRLLmu7eGEOmkWoJJu/ebL+SPIlkKxxUWJ1z2HSUMAIBQT7XtU0EKtev1a9OK9Pucbhm52yB5hmzLVnC1Zjg49JJ/X2dAOpEqypat3XHuXbMU2Y7AL2QB6Sp8KRb86HkdZ4HkU5DNQgtE8Cj6HyN6T7d36XPQPXpfFNEIjL6twvZrKzQ/USvUmyb+s7sreYkS03wbDr+o9ycLMNvuaDny2oLsGw1/7uYI9IY1C0o5BL/DW8G/3E894DF/nXoE5/c4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qqb6z7LBZb+mKBoSh2lbBFeeapV8IYx3FuyLEHgjtVKsQzkhSH98trRH781U?=
 =?us-ascii?Q?YaairqhptI6DzDfch90CwDGRJ448JiFDLN3moORsOxClD5kfm3gQ1lDvfbYb?=
 =?us-ascii?Q?Vdu6e4J7d8/p0k9wLrUs/JONHwFDd9tyh5bmvNysbCu8uRRytuKxkRAWjaWT?=
 =?us-ascii?Q?Bu1gysMJIDqkPNDAwDW0KmtHD3XowKWnOrZce5EWZ9sKEQcrpa6XMRw7o3ab?=
 =?us-ascii?Q?6PdAVsREpkrIIM+SzReW8HQM3fOE/oXeX/d3LVt0CbEtgxgOSBY2kqstY8gu?=
 =?us-ascii?Q?obmz0kepqDojw9wZZ/D04c+gAtvKuQD2hBghNdSW/ALb8F0iQo/wsDkK5p5Z?=
 =?us-ascii?Q?mIs21Pq02PCLUNeCdWMQhNEos/FIVLE/apLXqpjpYwGuNdS2CH0T7aN6cqsl?=
 =?us-ascii?Q?TSsO/LDh8Imr8I/bNMFrZtS/IIjLMv2lCdLFElVQPkful4Mshv6gvCCq37Fh?=
 =?us-ascii?Q?/kS7kevWFYMHvLTr1ExOBzokTWBK6rAvhC/WkpsHOPQwV2RgLAob1RNBb1ew?=
 =?us-ascii?Q?jdMPDJg8/Dt3OHjciyuHpLbZb2AA/aQv0k7zShUDwJyDIdI+Lgirj1c+ZdyN?=
 =?us-ascii?Q?gWM74SeQgozPzFsmMa4D/b2dkORfX/TYfNncxdR/7Xrqx6YeiLyD4hvPUhdE?=
 =?us-ascii?Q?ko0CfJMRXmavb7lqyyyUSun9xW5GaN2lHOv0xX0tNS5/y47u0i8VdjODtJyO?=
 =?us-ascii?Q?x7Jg1CHIAhRz8FADFyg8ozcTUOvINY6YkeJBr7/KJvNFSbcVFP0F3jsuog3Q?=
 =?us-ascii?Q?pcyls79eOnJJdXnZ7zq3jvSP8/XAuaeBRrmepVJoQSGG5VJehGK5KQXy/5Dw?=
 =?us-ascii?Q?GV1sTbqREEt81sNe2knIBfDn0EEaOCHHKBpwWWXt6p9O4TVmWC5uND/s5a94?=
 =?us-ascii?Q?VEtFBT4cEqNH7MeLS3fizQXt5GRbNiV5nvwf5Uny2dDB/iq/zSrM9WxTwuXL?=
 =?us-ascii?Q?qEVsVrl/nXMLuYHc74zFvqXYhGCoYgcqXJLcqYLecv0gTFeEcjEEwg3nJ9E/?=
 =?us-ascii?Q?IiTQu1FBNDaaSBc5+gTpIN7wZXfKBm8YP66039jfFC/nKdrNKMrvRhDRQlFd?=
 =?us-ascii?Q?oGcDc68n+pAbtQsqocsThf6CVAehXvm4wvnQSqBcYpUembl0GvotCVJSkjqF?=
 =?us-ascii?Q?scEeDEdEIp2f+hLftSZXbsNvUr7ZQf5i8y1JC4K1/TUi0JnD5hlIHZaqMEVs?=
 =?us-ascii?Q?eTeEmTjD1/d0mF0aPujLG0PlE8EmRoGCkbHiIM7W+os9CwfbHC2gzANC4MV7?=
 =?us-ascii?Q?Y6hyNlN2mnr84R4kHEitCjWg46FGxlXkGMNb/yqJERmdg7yolVVeQzv/oWd/?=
 =?us-ascii?Q?9GkQ7zsJn2lUn7INBel3M5FQ90jvZW+L5+Vn2F9gn1laWe1MawFWDAZq+XWy?=
 =?us-ascii?Q?SQBq4als0qFL6awkO/h42DtpBm5Xwf+PNjNXfubmCqW91Gegbp+56r6PcB07?=
 =?us-ascii?Q?pIhCZlRXiaUb70dRw4k6kyR2xCGmwBldR/pdXNKzQG+MxVUh9DK160bOIt3W?=
 =?us-ascii?Q?AH3rXDGy2UJdMKybyDzXOV53bfrw7HmayqpcY9v85N+wlBXhtcJ4iTeChxbN?=
 =?us-ascii?Q?o/Sx1fghdS5uPS8iAmUfMAGtyEG2wWYoZ4G6RpEWDWIZ4IU/jli/wuii/ov2?=
 =?us-ascii?Q?VmMyg8+GKxMOagHAdFnI+YTe9uVCv7s2sGn/kshu05iyJokMvkx+tuBNqGGo?=
 =?us-ascii?Q?kx6GAlD+sfoWN3KnYCMzZG5Mll2jURy34rt4u1qYrI1ahwheFFvmQnHR80Gt?=
 =?us-ascii?Q?qELj1tnDHQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CuvRASoyEUrd6HvEnEAhdjZGatiF/HCbJ+8D5y/S/3acl6sCEl7hdyFODtPSU6lTGoQTm4l03KkHmuY7tzsrNbVBkQd/DJM6GYiQjuH37ExMEU5nNllQbp2F52A2r2OfH3Okfz8QkOnwsiBkc6+7tGgQya09sv+o7iSlm7HvN2zNueaf4dfQmc/D8t/x2s4+QSdGr8YHQkOutMfO5lF4y/Y6fuG6GStfsyolC1JFz9wm0s+vTBhtmCTkcKk9em7n8avT/0C80elUEyd/Z0Jj+mbXfOD/nSQXr7/T6oVjKGm2M8V7IH3bSoz/y6iAjoo11NS5Z3x27hzn+DPmcKMyeQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e25776-dd3a-4d93-b3fc-08defc42cad9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 09:34:53.4366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tvj8YMAzfWRUJpucc/KGk2fUbsgkZi+09jpFLVxuOrrV4+rihhY4sbxPfNvhUSLF1ePJBkIEXZ0fcIdJzEgWpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7211
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

> Subject: [PATCH v3 6/7] net/iavf: keep watchdog armed for the whole reset
> window
>=20
> The device watchdog polls VFGEN_RSTAT to detect a VF reset and drives
> the auto-reset recovery path.
> It is disabled when a link-up event arrives, on the assumption that a
> working link means no reset is in flight.
> That assumption does not hold during recovery.
>=20
> Keep the watchdog armed while vf->in_reset_recovery is set, and enable
> it on VIRTCHNL_EVENT_RESET_IMPENDING, so it stays armed from the PF
> reset notification until recovery completes.
>=20
> Fixes: ece7d7eef04f ("net/iavf: fix duplicate VF reset during PF reset
> recovery")
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/iavf/iavf_vchnl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20

