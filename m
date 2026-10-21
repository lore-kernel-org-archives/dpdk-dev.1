Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08FC606A31D
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aKIlJt4M
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CE734029E;
	Wed, 21 Oct 2026 18:24:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id E076B40041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 18:24:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792599850; x=1824135850;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=l1IMc/TUQhKVv6pGCQgvOpWGhleZkuSYJs4lttnPqBE=;
 b=aKIlJt4MH6GuidLEttXkHPiGEmI4AHZ7YstWbVQ7aSjEloFKD6UzueET
 djYLzmFCGiBfVB9U8qk8mCwjAqpnS089Bq5oZmdJ91+KrhdZOOYGNJxCv
 O+ikcl3j1NPfpG+IZhJQAvWRj62TNdWzemdKBUMjBTUXywe7F336SuXvH
 aXAXlEB1Js0dMQ0jKWjBnaq6X3o6cvq8svKqNI9mI67hnBVPvN5JvIoFD
 wLPI7yPkKQaHuMVr0HRGWyxtd7wgP7AWaqheDq6c/zunYnhBR5LHOP6Cr
 Jxcarc71XEgHfpgfd9hl/lvNepeRFTGxYlkC2+hVWocJo8mBNj6dB/PU2 w==;
X-CSE-ConnectionGUID: jZTRUlW1Sy+J4goCCzQ2Cg==
X-CSE-MsgGUID: PyULXur5Sk2344m/PyN4gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1227299"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1227299"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 09:24:09 -0700
X-CSE-ConnectionGUID: dMFtGtQDS4+8Wf1Axs56lw==
X-CSE-MsgGUID: N5ryfHqATgWvjveR9mLz7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3187456"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 09:24:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 09:24:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 09:24:08 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 09:24:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xv6NdaUj/gCmqKpUiCtDbgA5ZML8/A+jmKlOJqUUDPplqmBRv6Qsfvz2hScYzQZ6TYtYHgGK3b8dmWT4ahlr8CVNKsUEmF3ZajcmH3B6VBbT03Qx/7X4OnfP8ixtU9nM+0/uUHo0LdsZmto65Ktfc9+nITpWeOLo3mG9putT/uV3owyz2g5I5jiKM3j6z1/S3/x52a34jhit77J5MjiBI0l+Vk3njsGS4Hk+dJ5YknhKxrCuFTrvwpvgriFydLTXtTFsTG/pXqH2+wiJ+//UmotJezZXTVvQrDvxxkUsLSCguzvIr78cdlthBR/UbujMM8JVKX1CVXWWzJPRhH80Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3UhG8CwQIPfgTk65LnQeSuPRxoujKjqBqFi0SrkfeI=;
 b=sXbwafpdsQx6T6Om1zVwga2aTWVMKp+bf2Cm3cE6K6oMMOYlCxPFlkXoBMdt5pACDdJalB4LQoq8MvD8ARB1e4I2hse3pLtludH2lMFGFZwDjGWPhQRzxNJnNziixO2lrTW7zhuf+hYNgZRSPOu9VQbUY07554vNOz9wp7MCJshUFxU+QkUAMQrRaEXPzeCVTddvgoicDHJyeIGkK8j+dQjwHsytZOlDL2aqRphTCCcbRRDEV3VA9jBG86FcPTW5EM2Bms8NcrR+SC+6VQgx3goIOgydc7MMRfqpi1MnTkPrsiHX72V+P/vGKmvQkgGXtcQSM5m0sk0bqKSZ+iy1oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH8PR11MB9721.namprd11.prod.outlook.com (2603:10b6:510:3a5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 16:24:06 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 16:24:05 +0000
Date: Wed, 21 Oct 2026 17:24:01 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 2/3] net/ice: rename flow metadata parameter to rule
Message-ID: <atjnIY_Yqvi3T5bZ@bricha3-mobl1.ger.corp.intel.com>
References: <3cbd41baf2db930276ce43893a787ea65770e1ff.1792579964.git.anatoly.burakov@intel.com>
 <9bf36a97abcbbb5a624ce63b116da035dfe43a97.1792579964.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9bf36a97abcbbb5a624ce63b116da035dfe43a97.1792579964.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB8PR04CA0020.eurprd04.prod.outlook.com
 (2603:10a6:10:110::30) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH8PR11MB9721:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e32add-13cf-48af-aebd-08df2f8fb9d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|3023799007|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: tWyWQfaPxCXyFFLW/1BX5yu/I18EhmWm0K33NHW/Lb5K5dNyApLbtdq3rHkRPCaCMq++Ai8lRlDMtG8VTpH166vGedMjZ/DZ+SqvO0zdz3UId/2xOsE6FwUs+th1+9p60Yc8NdoMimp05n/8T3LEazpR0e7Jr0UHg6n5YZKNOWAN1Orubdr+LG8tu7DPYABhpqccbfAMrTV5IF46XFbfS9dQiVj148YQ95fC4h9PwK1OaQpjkl0VSuaHNOiV6Gztqw7eI5cjSXXHbKhJV5S6ATEI7PZ/p9thqFHP76BTh1q0U6uuWivcXdYVSSIccrqzql4i+BGU4xu/r0V1aIeHHn5d1DHgHWVQC9w6wdRaE01LbZW8VVeEb7XCdC/gfySYR70ZEgDPw1UZt3q78eDOhWx+bXWY0ts2M3mbajtWNSjDzeEMVFyAZlfzlsF7k1niCxrbnON628ULV73bQGeNW+2XLcl6Sx8OS6ou1YxnAGJHZ/zOo5TDKsaXv2E/xkTLgzRqXsLtCsV5W7wE+mfXR/hE6HwjMZaCS5F/wLuMM1UYEbvrQkSJv4BvmjNgEpPOz8vY4BXmzweG7sQaKMGARvaHy/Bm987bkuB3dcGFN/zTJ6h9S92tYynuIXUuGarHq+SarXophChZ9MOlc+Nmq9Tq2IrPWXRIHqSXJKN4Q1Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(3023799007)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F2yb/6xHBW+yO9nERn6VWuBRswQs/eqMsYB+/2emfZVz+y1QhQgTj2uYUxog?=
 =?us-ascii?Q?KDYNG3RnG+aMt4z5tX35bqGNFoxi020MMSFVSt2UUGLZvy3MgOTJ5nSxZ9Dq?=
 =?us-ascii?Q?haZ4DIO73mnxccg9RRVH7c4qZpVOH3hd2Ei35sOQCjaLHcFjB/jpCRev5JXL?=
 =?us-ascii?Q?nozWdroveLPpZoHT+wdymHfAYJRhdRR4ceDkg13OruBl98cL/3ui/02MNS2K?=
 =?us-ascii?Q?FCWPM51fzMdUlLtmJFt5PPv0W+DMFYbHyDH2U7PbabjOlSHnulHKOBrh9IPn?=
 =?us-ascii?Q?vJJH6WuoGstLlCigeGCS8Ub2NmqFUDacrzkudcJ/dI78huEVkyWVddtFuIwd?=
 =?us-ascii?Q?D3v39722hnCjL4PgxF3fjti2Y2+NGSmdFlWS6Y49mCUn1m0JJomBFaOWWY5U?=
 =?us-ascii?Q?WQ0bhZ4OmKdWz4y2v+9L5pAZ6oJCG2hapQtZucIzTzUi3V8Hm8q6eF7yxphj?=
 =?us-ascii?Q?Ar0wCaBx4jA8FWPJVfd+zOY6LY4oUECb/9GIa9A466MetumMZWpFSPRsJo40?=
 =?us-ascii?Q?X0eGj3NFN8RwoKg4IoFBj8/VUA4rnHUJnNtUTbjMXbJMgaL/JH91UAYgBstC?=
 =?us-ascii?Q?B44i69NU8pm5eWq8fim5eLhmIIwEMFMYe6NqhLuef8JjqGdpdvwOps+rd2C+?=
 =?us-ascii?Q?+Gy2HTmZn2iDuS69kiUGyKJj3N6JLO7GSo3+kK7m7HiaSmHxqEOUuZJif+EN?=
 =?us-ascii?Q?8VlWpDWxs34rU85vNZgl5zPMH+VBrbqz/QA4IinBxwPbl1m1mOHBbc1X6VB8?=
 =?us-ascii?Q?h4X3mR0Z1+KFegDSUG1iid4AC3KilbZL3kYba74vOAjwaQ+31T+HpN5H6JGg?=
 =?us-ascii?Q?DVHKFJxG15vtFm/6DFwDa3veLTnLZjzLu9Ry44aK53JB/9Pm9Q6zjERvbKdC?=
 =?us-ascii?Q?TGVZSGQU7IWcv4TVWO6PRiDeT4AVRWOMqOCJq3ZfzFoJt1RQ8Grbl/NwCGxD?=
 =?us-ascii?Q?6rb2waUT0La97SRXCjNsNPTEVFhRYnhj8lXeiUWgue9c6lVxA/erRfKr/bZX?=
 =?us-ascii?Q?0E6rNkgLGskEsR+4DB8fhXo1BcT+Tm/ydQsONgsSYcsImCrzIQOUygU4o6u/?=
 =?us-ascii?Q?qOWm1r/d7qqrBD66Rs/9glG5l9W9AqmUkim27hLeF+Uit2b+dVByYOzxUql6?=
 =?us-ascii?Q?FA8EcCE5eeW8eNJkaDJdXJp1wMVoALZHHFIPxpCMWJjxtrQ4VPE/Kjn4JwC3?=
 =?us-ascii?Q?AkQ8MW+V5SCK8x9eXpgp3ZYS0WxBmNW4FjOGJpaMILDIt2SGK+7Pgrn0sDIY?=
 =?us-ascii?Q?lgxHigw0ZR5gG6oWQgkQ8tUx3l1qUZFZWxeHNrN2nosF4T1gzxpGNQ74UeNq?=
 =?us-ascii?Q?W7irAvWdixPPCI5mM/+RZaxzEoXCGDzhnnOMnROlpYcJkuOsJKL6ujxHKHp9?=
 =?us-ascii?Q?WER2nAGiXZQeaRS2tiJiu+mJcdJrmLCa7KIzAO1WSQVdVAq0GQGt1vgUjGwq?=
 =?us-ascii?Q?g5fKJzJtPntX2s0Y+WpVlUyIjJTuiRZZF6J/17z44EGouINpXwPzt+RorKVI?=
 =?us-ascii?Q?Y+yjeadiGl6fSnL0jqJi/3pFs807Ct2X3oVxHO3MqpzP8bAzeS6RV0YpJWQi?=
 =?us-ascii?Q?Kkq/1c3g794i+xRscagzATA++j+U5gqk+OoqY93Aamo4xMUI2HKQR4gGEfh8?=
 =?us-ascii?Q?mJy7Ub1AMjiVWNmvfAzOREn4pZGQ1nUHlHDhpkHgemhZOGS+RCVxSxxg1J7P?=
 =?us-ascii?Q?o3HTZwjeXT1nRu2f5ENc0wDSV0c9TTPthGL8FZ2DndNKBQO1LjupBVI7l8Yy?=
 =?us-ascii?Q?Kr1hA//QEGRVrbsBtjt+dXccDguhFfE=3D?=
X-Exchange-RoutingPolicyChecked: ynTcQ9c68ebqfUzuXVvJ4knd1+uHL2kbhFe/sKhtRbnckXZS9B8xZpP50kRf7uNFtK+xb4WEu/vxoGRC7Dm9thz22lACAQRhzkBP+89egyw/pjIV9nYF4meLrB7gu2vngd6pDc4W/GJE+Oc+rtKCO5QeLdRrQtIZElTV49fHn98bDiycNfnLaI4j3E2kJdrqOSKxVQ/PMISA9TofmBWaN8Dy9kgS8q80gV+/EbrV9YPwGp1D+DE1NRW0e++vMXcrSWjs669/57OYts9IIhDnw7+YLIV2dYfAvSBsdvRqNATa9mgfmE9cXFF2YeOw12nSafUmkFUH+wh8k++eZV7udg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e32add-13cf-48af-aebd-08df2f8fb9d8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 16:24:05.6486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVEI29hE2JD4qbtuJNbn6evaByHPrLE5fkymG3gkKwYHSschWaYgA/sbIt2xy9Vquidjw9AoAq9qS/+VSuqq9SC6bhx8N6+F1WVjaCrU9Sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9721
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 11:52:49AM +0100, Anatoly Burakov wrote:
> Parsers now return the final engine-specific rule rather than temporary
> metadata. The generic flow layer passes this object to engine creation
> and stores it in `flow->rule`.
> 
> Rename the `meta` parameters and related local variables to reflect
> their role as persistent rules.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

