Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48FACD5BDE
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 09:20:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7B8040285;
	Wed, 27 May 2026 11:20:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id DF6844026C
 for <dev@dpdk.org>; Wed, 27 May 2026 11:20:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779873651; x=1811409651;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+7mXWIsY0ksfPO+/6MDA/I/QKwmSMns+6bD3sDihIq0=;
 b=XPmUqwrUbvdld06npTJTO5Uf3/v/WvbsrtGtxlAFnizxmRsABlu1zNBp
 TEFx5Yh9DmGDqeH2mS9vTl5bM689jOlu++B/1O7tpomMEugywbmwVVnPt
 20TtIdNckQAnWO2VqUAl1sKhgJ04x0cT5j3fQ23Ou9uBHk5suWjKNTd20
 04Cewjat+9vFf/cOftIpNuz/aoOzdsBBJmakD1wxhmd7IZKF5CwxCKASV
 mW3P8CcVvdxPJAYvDSNglBfv3c8WbK6g4e24DEyFn2xxs6mqTll1en+RK
 RGISya1xsJSv764tfVPOnZkWo6lej+tdOBzpyaevWVd+tJfUYg68uhFm8 g==;
X-CSE-ConnectionGUID: yVLMO8qvS+Silc9qRVZjCw==
X-CSE-MsgGUID: 4gG8T3zYQoGF5r5SiFhGjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80730901"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="80730901"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 02:20:49 -0700
X-CSE-ConnectionGUID: 6UjZJaT4SpyPAprsFGu3Fw==
X-CSE-MsgGUID: I56kXMU/R/aylKgbJICRSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="246447676"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 02:20:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 02:20:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 02:20:49 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.31) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 02:20:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRBTpGdf87OgDRwybO/3XI6lbBWueoGpWooc/W19ppDtOWSjvWcywQBu3xtb9wIZK0aCT/lFNvJ4LZNcq4Rdt94T2slJ73GZQaX0rDRSCLWVhvKS1pXYcjuFgiBL4vOIGaYC6ZsHXGoi2FNKy6zH1HX8uAc764TWvCzSJAeUq2xjhWpbnDW6VI34uh+w18fXetRFaxrM2TCWMzeBJfezsLUvf+WJFD6uKSRqXDuU1oP9P7hADc3n8R7HhzizJA8V8/LZHIolEpcIGll6nT5JIE/PKhVOPbrbFlYK99VCRRnyeqHvxk8aPzrnEX7T+qTgfnbfe4RqhPoiTZDq27Uclw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7mXWIsY0ksfPO+/6MDA/I/QKwmSMns+6bD3sDihIq0=;
 b=vi1kHAHNdU4Wjgjne7Pkb3DC/fhz0IzpaMKlxm97iCV9kEUzHupv18B4HLEKCMtMjG6VQlY0KCGnkme1tq9x2b/le+7b30ucadNWJTq8+oGm61bv0YF9dUPntIhIdjSa2jVZJPcT59T+5YSWjhWn7an+tMVMzWAqhRVtlJgzaXa3NCxBjiUi7WHFXwxRDUBWnxi29raJnmdTf6L5JwRyX7bB73rvMoCggRZASU7i8iPE1WpnxmWBMzoAZfO+CeP+F/pV14iv/iz/FdMQrC/nQmNrwkY3WpKBZKY2BhorEVO7QGU1wdKL2XFMhYIP78OKCunMUtPmg6exH6wjUAR9oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16)
 by IA0PR11MB8398.namprd11.prod.outlook.com (2603:10b6:208:487::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Wed, 27 May
 2026 09:20:41 +0000
Received: from MW4PR11MB5892.namprd11.prod.outlook.com
 ([fe80::d917:88c1:d478:1857]) by MW4PR11MB5892.namprd11.prod.outlook.com
 ([fe80::d917:88c1:d478:1857%7]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 09:20:40 +0000
From: "Ajmera, Megha" <megha.ajmera@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Dumitrescu, Cristian"
 <cristian.dumitrescu@intel.com>, "Shetty, Praveen"
 <praveen.shetty@intel.com>, "Singh, Aman Deep" <aman.deep.singh@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2] app/test-pmd: add generic PROG action parser support
Thread-Topic: [PATCH v2] app/test-pmd: add generic PROG action parser support
Thread-Index: AQHc7UUE7t08lSBRb06Wxz6MeEO5F7YhmRSQ
Date: Wed, 27 May 2026 09:20:40 +0000
Message-ID: <MW4PR11MB5892D90B2AF860214FB57F4D97082@MW4PR11MB5892.namprd11.prod.outlook.com>
References: <20260521055612.508916-1-megha.ajmera@intel.com>
 <20260521101354.726240-1-megha.ajmera@intel.com>
 <20260526122218.1c29d917@phoenix.local>
In-Reply-To: <20260526122218.1c29d917@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5892:EE_|IA0PR11MB8398:EE_
x-ms-office365-filtering-correlation-id: bf2da05b-1950-4f51-3a49-08debbd1388e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|4143699003|5023799004|6133799003|11063799006|38070700021|56012099006;
x-microsoft-antispam-message-info: 6Oi/DmEbzWpJy+dKlELljZYbwKqEbM9LNh2moftOlcDMZvatx/L0O2Ei1gbOHxKGLNMnCoOJ5greBCqUw+CWhg/pclolu68AIe0Prn3XNj1BK3ethdvspZw4Ngsd0Hy+9M0IDQqOFpEUocahEkTCh5vmaM7Yed+OipBU2UwS1znBvaU1XqL4HPyL9xS/AuE/ElHS2gIkyY0JaJgXm7wvgbfL3Elcv+po+5lFKFFk2t8JG5X35NbtUyuJDl+S96gJHeotc5LTLFoBYazh716wcsY3hT2IwqsxXzPsvSUd7sMkp/QT8GqSLkoGAULvA16GnelKU8ZczD6j6YUJ7azSFaUM8rtzxTqS1InwRAyxpng7QOJ8+792WRE2DavOFmUGwi/FINg0Pr/gbiG24I98Ogflkknt7W/nrWt7mpPy9RI3SFd0az2d/iUDWzl/jAMEVWUWMRzss5h3I/f+Sj3Niacflf8SnZCHF6nJjp8T6tBmAF24JGj11RiydHtiRupR+RUUpCeVr0jN2cm8Ereu6ry1a2++CGn8meSvEAY4oMHNwrIcx+rHCnkNBcXxf+wf/k3s3mil7/EDjwCs807n3OsFr5nJuoIrrOnigMcN7RWUMmqMO4J3+xMVTzL2RqG3Nh6rbAySLSf3scUHaGxCdSVRG7yEoblPyFsMRr7yH1L7IZVI/7UJsPOJtZGSKP4rkEc+BEALSo+kSw/fB1cM5M+iLCNKSI9a1gsklRY26eAh3RdhosXLYbzlHP9FZFBe
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5892.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(4143699003)(5023799004)(6133799003)(11063799006)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UPgPoVaJBKRdu3inQu2WyabbmEmjt2eJYOMhcxUjxV8o7FMM2wK3mR13KFUQ?=
 =?us-ascii?Q?QPUhfExFLCkpp+4XMKjTbj/zAHLcT92HCRtHl7xGt7xgGj9vJeVGQcAMkk20?=
 =?us-ascii?Q?cuNzQYfpVBer2jNswNM/lGhVRvuWhgDEr0T/og1OE337powwn9q2Q0n32Tfx?=
 =?us-ascii?Q?uKSloGUldRRnLZFFizfBqS7NoTgbmZcwzH588JPK+I/XUiDr938XBH0IMRVW?=
 =?us-ascii?Q?dEhGJ1p9a6AOkPB5plDw6A4IE2Gyf7fNDZt6HQbAxCm14hECDG1i4LyKoDD4?=
 =?us-ascii?Q?ZGGgEvZww93XVh6TK2REn8qSwtNmWMz4SOKg/gNzGlguaBA3f8FZoHLAa4CQ?=
 =?us-ascii?Q?xjvicxQJQwf+BxRTc7KW0Usf5HYsbygaefrb5oDpn3yW+4Wrdf/qR/PTMM1k?=
 =?us-ascii?Q?zHw9WMifX9eEzY0J6GOXuV5fJeOB9moPB+NRl2lGfRh39sAI2R/3u3iCQ+3E?=
 =?us-ascii?Q?0Cf85+e39COHfz6HJLc/WBAE4s8mr9W+rwSr9J6Sh0Cj1O6ZXqOxI9X8S0k+?=
 =?us-ascii?Q?/Au4puQFPGBmyxCQfIw4gRyNTstA2v4xRlb3kYKUUQHE3zeXW8p6ww1N8gIL?=
 =?us-ascii?Q?qneMQWEo9FM3vNXDY9sZLmoowej7SIkzVK+2/yNvz/gZIMTot/6HpoCVkHmk?=
 =?us-ascii?Q?LUtvAwBrmCJw/HGRmn/fWYjuYXn5wjmISa9YrYBW3J3AfppKLIUA1ddYjFEf?=
 =?us-ascii?Q?3dqJ/N1Xgki7PrlvulDVF34bEYVwULpEZkZMFvT1Dh0yiaS6fea9cdt1tVht?=
 =?us-ascii?Q?GEBnjLOJIRY/+62Z+t8N0NBb3CgdD737UoqFyaGMimExkm2tuYPRsFDKcjUd?=
 =?us-ascii?Q?ezgphzm3rO1bkNEy2Ak+AbJkhum5BwmeoVrRcaNPMu/cYrvrUcd+eXmMXXBG?=
 =?us-ascii?Q?eDB9wtsn+s0+bUQ/+HHfKbRUTkdp7WQbd0tdUocuejIFHD7PrrLllQN4WSkF?=
 =?us-ascii?Q?ZfST9aTiRthC8l6dSXuBgxFFvURDpODnR41W4FjL3T9rJqoTQc4LZpOglVnX?=
 =?us-ascii?Q?PjqpgWeVEV3R2CtfTukt8WroA9zh4jFol22/PmDru44CBfFZSnvtOE0XhiKu?=
 =?us-ascii?Q?WkTzwnQlttUqi9bwRlJLD9C9alZmXpOTZCzUAq/HKevl5KHMBiWHwkO/WZ5D?=
 =?us-ascii?Q?SblfQN1H960GZTl/HEbQ87x6BEH/BW7vI4R0gX2rWGZs1OhWAHxa5t69Vw06?=
 =?us-ascii?Q?13eXX/DECF4QvirelpOfw/gvSC4BfjP7ko1f2yVFUmlxSs2gLOPl7D8QOWnx?=
 =?us-ascii?Q?9Lm6Yi0VzIUbKg1dW9GO5dXKslPDa4/exXCr4b5SbzWgGiR5wBg+a15jaUEy?=
 =?us-ascii?Q?8sU4bKXYV3e4qUHsQdrQ3NYgS+DzCWmkfjW9l1JByN3pYip2/tOCMDr3BGjN?=
 =?us-ascii?Q?MnyVF6I4Tb8v/jMVtkacJWB+iukxkERPwCMImCQOJNF6zFDjagUJ/Nb5sTbq?=
 =?us-ascii?Q?e8D+aTOPr/mz4fREyVOTLW+d0KngqpkHltn4/nSZrTTvVTjrPKa0aXbOHhyk?=
 =?us-ascii?Q?viQ9Ebb1LO1/Wbl5qpWXwWam8ckH3XDrF7/m+6jlKuBNosajbMblylPRhb6f?=
 =?us-ascii?Q?n/R+Ab0zzQzZl7JuUvjTNTmzENN5oR2ps+0kOyc/qnOzGS2EpLCQ3aa/Mw29?=
 =?us-ascii?Q?8ao/MFOAuNiJhFx3pDn4Vtc5NS569d47gouU4YFsrgQ3lkKcIO6W46UMVdJQ?=
 =?us-ascii?Q?aPhn8pZoz0nL0iVnH9EGGb0GzA1UjDR+40WYUyXRCiusP47MGn3OfvmuwDbP?=
 =?us-ascii?Q?JZxeuNeTGg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Q2AhAceV+I/+oiWPLm2Atrc4n/mPU9oxgabk4/ObOJXCa52xCt6C/+TrRG+G/zz9qyGCIa53ZIjexyzOrTW3KZLaLZcAbyO5azG7dDKLPhA+N7FL/lKVkjroWp3vvH1frWjmwnFM5frOk8hjSTSzQ89+vcNKu+ECUKMEp1t9XEFTDs15sQkTXizVe94CArPbHRGR2ABXJ1ifOP60Jcf54LuEglJQdw9hJ9H95G+KTSXQj/JlgbIr587moEF/2IRdJWAEW/jhL4UphRXJyRwkoj7PcYy7XM9Wl0Bb/HNbKWQMOfH9eq5eDLDazPBqYOPEURmGjGPzlX/3Fy6zcOA/OQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5892.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2da05b-1950-4f51-3a49-08debbd1388e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 09:20:40.4482 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oKe0wQ2HT5wpSWcG9FLEuMjpWVCfAJgOd2erV9KoEXd+BXMX056ATNj0uA0J7y3AquoxnPbDEy8ZYPZ1tHhAUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8398
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
> This looks like a third attempt to parse text into rte_flow.
> Not sure how this fits in and why it would be useful?

Thanks for the feedback.
I wanted to clarify the intent of this patch. The backend support for the P=
ROG action already exists in the PMD. This patch is focused on adding the c=
orresponding frontend (testpmd) parser support so that users can configure =
and exercise this functionality via CLI.
The motivation here is to enable configuration of programmable actions that=
 are already supported in the backend but cannot currently be invoked throu=
gh testpmd. With this addition, new actions that are exposed through PROG c=
an be configured using the flow command interface.

Regards,
Megha
