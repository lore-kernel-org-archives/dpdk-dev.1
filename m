Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134FDCA5FFC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 15:09:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01E4D40EDC;
	Tue,  6 Oct 2026 17:09:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 34F0640262
 for <dev@dpdk.org>; Tue,  6 Oct 2026 17:09:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791299379; x=1822835379;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=dx+VYjTFUSc9SaIYhT9c7zOK6BQodVeC0FSH2FhTxU0=;
 b=ZK3n+GUBSfGO4m3W4NCzaKYcY8fQcr8hIoGRmmX0PwUDSB8buEmsqgT5
 cySgFvtEf+lp7NbbxEnNiJ5uRYPs1VPvOxUD5hf7WQA6/t3KtU+Pc2BX8
 6oaZgbMHdJtiFEsMbJRH6UTTW1xfT9cczZEcy/tyC/ZzU2N4DRGEcdM6X
 eqvAhOkTqEl/rI63VUDWj9oN6YVVefNL23YEXQr+KACPO5fgTfyXjkDKk
 8z3adTMZnkxpMsZmDpWqkEpuBcqqRhcrn0Keahrs4ydbtqH41e714fyAi
 obeNaiEszYW5vA6gGrtK66dgfdK9MCdOz/JKCGiDiwZv8k+D2sV74zQOQ g==;
X-CSE-ConnectionGUID: M+G23qj7TNyEYRXoPbIT5A==
X-CSE-MsgGUID: q0ZD/etKRAiQYfkaqF4t3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="30883"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="30883"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 08:09:36 -0700
X-CSE-ConnectionGUID: UofDz3YdTaODjqP1a8jT/A==
X-CSE-MsgGUID: iMrlgbyDRxaUrG8OEjn89w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="275822113"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 08:09:36 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 08:09:35 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 08:09:35 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.70) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 08:09:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXLwC+C6MlRQ1287/FBkqoTtevTQqN+07ZRxcMVy5u2JhI4hjKQq7gX7ZCVAOtBjx6pN06/qt5XP97Ek86Dpop6izjqgcKPVkOceiowIyWSIGhrEmPl04ImjQ6k3Kl1SaxlUhpAelm0C8Ng2ZyLa3wN006kBErRmbv0nsvOAlpTSqtjFlVQzu/dQBv2cZrY1vjetN5DTWPWFt1Jns4jFY6QRG6M/Zc5CajFbhfJ3G4Xttk/Oe4LDUBk76yvUzgc6O6/pzuNBtb37c8P+aQvRrPcyTKFxQ5QtEl4S3FyT8XnQ90pJ1080I9OIOv+9ffoKgDD64uKqpKCRchY8Rf1iWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+jEAIoV83WwIV18ax2LnpzkXo+mBw+7usUFmktxnsM=;
 b=CSfn0kKssPwohJIHk/cKz7RIEkV64edZ2xV/v3VLXvLI6pD60WjQ4pHgvgdBJy9g3ggMXAGLWYfgpIAYie6bShGejK0+uZj42yiJvGeAB0F6r+4g6Arf/I/B9OF7rdqdrl0ub8aH30+3QhtOCdgmthChkbC1HaGNKc8CWjoP36WzNzRNLfuD4yrac8nqD7F9D4ld6Pj3aH+0k2pMFc8k2y+FjWCm38esOYwWMNnFWYLccrynyoBP8O0gdZJzU+LsXH4lQ5y1XlkaIRi6EyoBvbCg7Intq+B0S719n3jtPljBCjkNDRpbaI3NB8JfaaJIuGE+nvogrwChVMGte9HJ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by LVUPR11MB9788.namprd11.prod.outlook.com (2603:10b6:408:39b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 15:09:32 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Tue, 6 Oct 2026
 15:09:32 +0000
Date: Tue, 6 Oct 2026 16:09:27 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Omar Munchaev <omarmunchaev@gmail.com>
CC: <dev@dpdk.org>, Omar Munchaev <omar.munchaev@gmail.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>
Subject: Re: [PATCH] net/ice: use macros to get field values
Message-ID: <asUPJ6Y9SUAzqbXK@bricha3-mobl1.ger.corp.intel.com>
References: <20260928172759.3369704-1-omar.munchaev@gmail.com>
 <20260928172759.3369704-2-omar.munchaev@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260928172759.3369704-2-omar.munchaev@gmail.com>
X-ClientProxiedBy: DU2PR04CA0314.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::19) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|LVUPR11MB9788:EE_
X-MS-Office365-Filtering-Correlation-Id: a84d6dfd-8fa5-416a-ae97-08df23bbd321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: pa9mXLqVZa2CgQbK2b3i0lrWwZuSnjTf11J3pOEGBv4norI6e1QfDPR85gj4045hiFRC3Qz23gHELWizh0bQp3so1bljd29rm6ToXykZgue0zarTaqUnnFedkJSeG3wm/8yyhTAAxLY7S/XNQ+bb20Kphhsh1fAfKmUIB0Hqy6pq09IyguaAZ6cAMSuzKWLl92cfW95SDZharTlUjGgonNRNEer+xGFDRj+namxfGy5N+Z8vaoc8qo8DSoIW10vstwIx2z4M2hLbxOniIFlZI4Nlu4Dt7b9Q9inBsOLvY8GWZ7EHjFcjfV8ooszY+RzDTnPMyXjPXbJEnJZsSApyad5KdC7/UAjyZ9tNFKxdadvCzIjwFPBWsHkLmVbNn2lxMK3r/rjtF8EqRmYWxjRH/te+HX+ukC4l3ovkqri1oRT6ZZNVFUtx4jQ1nlrNLLTBNpYogiDTSl47v6SqOCU84CVHjHpQ6xYG6JCrRERcFHP6kAzCrw36LBIC13/1Gs+aFiZTSdGu0n6n8MznfVoOUzHUVlZOoWTKFroV9YzzKKObKOVT3Inr4Yep91ta8sRGIxzTIA4WZQ3mUYDSmv6dykZzqBT5pcDo7Xj3Nux7VsbD6QrHbpMPkYcmYVryzuPSMtPQLkNbagT7l2TIcAQjJtd9lOcD2TrDHZJlDCIO+Mo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZO+/QvTLoYNobyDwh1go7KGwinAM1iLCu6TlFnttlTQfq1FG7NSiS0zbzzCT?=
 =?us-ascii?Q?ALM2vbzPKAxKCNoW3unwiB5HFuWWWCuLBnEwAK/8nZrhfmpl9qrbp3OaQL75?=
 =?us-ascii?Q?OouYkq/icdvGgEhZByUrS24Enzp17jRyK0lC5CTdYBeQhy5XEVwma8oZI3gq?=
 =?us-ascii?Q?UAprF98Uxm8Iidy4Zbx9lKYg/2fnAcNOnZ+2WV/OsE57R4m6XfS2qYc3RlLw?=
 =?us-ascii?Q?nZ3Tx6Eay5S6ys82tJd3b+b5fbcAv7qL+f5ACxzuhUyG3ngRZnkJ9E4F1xPV?=
 =?us-ascii?Q?grKliU864/gs3su04csThzPKSIBIU/Yj7q9/roaZQHOSiu8N6fQCAmyz/2ip?=
 =?us-ascii?Q?/e1akB2yTGmBEPTw6DTQkz6LoerqaVd/CzecJvcq7XKByB+a7Gq/DWyfkUqB?=
 =?us-ascii?Q?ObBUqf/h3ES0SXMZer8cmjbnJAnwuTV0fxAAWAwjZ3y/8WeXfQkSLGqJXLIt?=
 =?us-ascii?Q?+y89QNI1TbDZzc/QnMn/V+qBvmsFKcmGFvhAAi9rgG3kQnWrOLf+C/WGKP+A?=
 =?us-ascii?Q?cZgta7wTHnubjOM2JQcBU/761R3PPBKvsicaVBHsZceKyPb9khOPH6oFMtfz?=
 =?us-ascii?Q?VZx1riQTysojz6owU1JdgvhEuDCf3Cc5gAi0SHZUb9llcuO3itSqwccIJOA0?=
 =?us-ascii?Q?D10N6uRW357A4RbXaHiZJOmva7demGj8ohFMKRqYLj39vLzkXII5Wg1/8iU2?=
 =?us-ascii?Q?7kHCxnY8GxfBWniIoPZPjcRMWLYyfbGmhsSuMqrV2f5xlYGRBKDPp9EHFwdm?=
 =?us-ascii?Q?duvRyypHlulKH941WDLs1xSF1TV0fdqBnWKXUOnVoQ8Zgd8ds1XyaJYw9MNz?=
 =?us-ascii?Q?oRxwtHpL2efKAHsBW3TpoBJp/DKTU7j4rIOUj6MMMoAtmM9o1CC0qUvTjAXh?=
 =?us-ascii?Q?t/b0jmAvY6jPknkegOhU5fHk3+UENhO1vlOWI7X4hJVs8mMgwngB7IZwj/2X?=
 =?us-ascii?Q?Evdwt5+A+cYZQjhdUKdIf/B8OLk4v3tb6A/RdswlboxxzSJHYmfeeyV1G0yc?=
 =?us-ascii?Q?taG4a/9VPgXfAstI8CrteOYjQYFFQFPgHDMJL8zuKyWvDwAJm7VGMnkTSn9J?=
 =?us-ascii?Q?R/oIgj+flPkqCwnZM3QZHH3nPa007ORQDIzV8kyeEnxFV5m7MkGctkypcO2M?=
 =?us-ascii?Q?bLzS1YiyaU3B+zCmrpUBy3nFXWocfbdQxGRH2FslFdBYw26xAnKG4qiiBkaM?=
 =?us-ascii?Q?10wGEze+jMieq0IcP74gr/mm9pLGpV4v9x+3FjqNT7FJqYCvIUsr7a0JmqVf?=
 =?us-ascii?Q?4i+XHZPSQIIbnZ0268ylxhHp9R0sQTRH4Vde3xAOQycLlhtQjlHT6OS3UMsE?=
 =?us-ascii?Q?zX/CaOhb08phNLK8+OWigGNW89qw1jepMZOc02YGZFmyRFAZf0OMtRV5eX21?=
 =?us-ascii?Q?g8tEuqbsMM48yx90aUQ3lg7h4B5tS0c48zsxzhzbnWjxr1iZfFO0kTFFr1DN?=
 =?us-ascii?Q?J3giWKGTUBafYRTyMgAg5kmSQ566SeEnP7Yp4OesOYceqBYevbB1HrcvClIu?=
 =?us-ascii?Q?rZqq8dAM/Q2TmzJvdDU3dlkdcuiFSSIqo9ucB9tDoPX3ksYKj0gJoED49rZq?=
 =?us-ascii?Q?59NUxb+XEy1b+EPIFTz88ZW9BIH+JqArmJOzMkNqeBMHW/vExrtQcPpRFhkq?=
 =?us-ascii?Q?aiJLXLn548ymFXnR0V7TTrBOd1vK7qpGYZpJvY8yqvdaY8Zxaa8ka80g2Sty?=
 =?us-ascii?Q?EgBTnIcTfFDjjsQ9890xZi/pZTBR4bLA7i95sx5lxvwiclV+jKwLdQloaUL7?=
 =?us-ascii?Q?4SWYMSEdqZYgHkQbQKbCLcJEPTUlnMw=3D?=
X-Exchange-RoutingPolicyChecked: 2xXJAx44skz74GY1UIfBHyYa+TvEabAa/keO2vHzeDFNpAh6FGj2E6aDGgW/oHSEvxkt6z9hk6zk+BNpvhpKowyjVQSTDD1Bn7C0i/4xOi206W5pxKCU3LPH0WECsZcqWt0Unq+KMhWxnwvOdj2vWL5WS0YfBY0q/mGUzjWYDeTNbzobd4whh2CZw4ulo6zZVtz7vqwrFcWZk2Fc5aU8cJK2+PdmeqG6S8NXzwHk0fl6Hl4YXBVO9sLGaRGFp1+60LUodD+WNPHJ+GIy+gC2ajYMTgtPCMVmeqFlWNKOludArJZaQ6wSxS2X+m1rSSSJ7FK9p5jVgEtnWSlbtl3zrw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a84d6dfd-8fa5-416a-ae97-08df23bbd321
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 15:09:32.0528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8fDsKMYJYLOy/4F331ctPcjPJlSj/aAs5kmnOcudLXyMtBjAb6U1m+U/MnxjiXHUAggzG4myDnMnGOk3j5ZHO6aVmkrrbFnKqRP1SZr3mA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9788
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

On Tue, Sep 29, 2026 at 12:27:59AM +0700, Omar Munchaev wrote:
> Currently, in ice_check_fdir_programming_status,
> descriptor fields are accessed through direct
> bit mask manipulation and shifts.
> The ice driver has macros for this, so rewrite the function
> to use FIELD_GET macros instead.
> 
> Signed-off-by: Omar Munchaev <omar.munchaev@gmail.com>
> ---

When submitting a new version, it's recommended to also run the
checkpatches.sh and check-git-log.sh scripts. These are giving an error for
this patch because of a mismatch between your email address in the signoff
and in the "from" line of the email (and in .mailmap). The signoff has a
"." in it, that is missing in your email address in the other two
locations.

Regards,

/Bruce

