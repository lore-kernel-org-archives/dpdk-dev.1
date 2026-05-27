Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C53CD5BDE
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 08:48:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53B034028A;
	Wed, 27 May 2026 10:48:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 78B0540285
 for <dev@dpdk.org>; Wed, 27 May 2026 10:48:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779871702; x=1811407702;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=x1urg3tg777AMrjLzjyRfTaBTA0WHVWJVH+6uAMyUKo=;
 b=IhmgIThEslz5Buat5/ULhtXzHKW4FgnTmSL5/aoxjswl0vpUt+cwncOp
 QCm6XXgG10mSWft4enoFqBWBtICMk2Kdjy2jUnNkGG67M4xnlFm0ahCSt
 fwu0/ENMOb5YAO4tozu3f8iL2TDxoa0CFZH85IplS+v1mEXBJ+gPOrO5n
 afg9Ds6hsJtmwxQTbyqCr/mPnXWB1UYU1nXUWuaJuDFh7piUlZ0rX7/4m
 K7wetrU6CN6vGPXXeQKbFedgequ5V4fYVZ2gx8FZQ52acclwQfBB0kU1+
 EgKR6WBa18Ru3N9ikAwN/bXKnNKoYm6GcufLFkUuNjaoi9Md2glSweSDl w==;
X-CSE-ConnectionGUID: q1HQTmRDRdid5Z7C+tNTjg==
X-CSE-MsgGUID: mSMFJf7vR2y9dWJXgcUFrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="79731122"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="79731122"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 01:48:20 -0700
X-CSE-ConnectionGUID: NazMoVg+Q3Kb20dGErMzBQ==
X-CSE-MsgGUID: aWB/RVwfROuNJvtKQrselA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="242243314"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 01:48:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 01:48:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 01:48:19 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.1) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 01:48:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnefeimPRCP3XI6CA6vqhLY8PgtBQq3UbF6Y2ELRpHhXhUG+O+j8cuxJIDG4l4jF/hH8WLYWo2ttnv/L3vYU5YiX77ccmc9wD95KN/6OISlPEMAWG9B2oW5Wsvp3J5OWBiDRhy2t8XLvj2kTS7pa//HaAFZedMtqIWFIDpFRalnc3mNxyN7tvqzByU7jh9unpi5/efiEiuVDBxiSkKv8jIt0Dxj92kYAftmNXoMKPctNtyyYEY+vEkspDV7GJrAy/Xvz05mB6k/pbsdiGdQQZT8X/yTP9pgv6pgdmyYYlAoDcqHzX+AoePL1RB9t5m9KiPNyhNZXeMGhmjMJ+XmeHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yh6um8zBgNsmMdV7/kAlkSNy8SKM/eUwtHAn6nehgMg=;
 b=MpDp0nBOkeO5xKD2VH+xGRBE1cpiuxl5zR5YQTM54teTjOMf0+37HaxW9w/Z8ByNMy19tKjrmhkUbsfGMTAvjY9i/FdM46dyM6kz3RbslexYqqMuNExQE2Jvy4f1Ppf1EQMLSZy8CTTuLgqtACz9oc66ji88R/YavZoAWCtZmc6rK/Tv9nmHNF5XHheWgtNpWOwoyN3jleooDwW2FV7yhwK1n6JrdXs2ENh9uCmvtkGLwVPWbsDYA2+G8HQD58/6bZropoFdS8GSUvaoYyEXtRCfWlq9JJGRUdB+Z62DHs7Yv4P9ISfNhKWAn6qxkSyXurykQyRXLi/l8KsBSQMZxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV3PR11MB8506.namprd11.prod.outlook.com (2603:10b6:408:1bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 08:48:13 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 08:48:13 +0000
Date: Wed, 27 May 2026 09:48:08 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 "Jingjing Wu" <jingjing.wu@intel.com>, Praveen Shetty
 <praveen.shetty@intel.com>, "Hemant Agrawal" <hemant.agrawal@nxp.com>, Sachin
 Saxena <sachin.saxena@oss.nxp.com>
Subject: Re: [PATCH v5] mempool: improve cache behaviour and performance
Message-ID: <ahavyHwTzyPPDkQ4@bricha3-mobl1.ger.corp.intel.com>
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <20260419095526.39526-1-mb@smartsharesystems.com>
 <ahCAPT1LEn_Rc7Pk@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6589A@smartserver.smartshare.dk>
 <ahVqYpVXMn59Tl2d@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6589D@smartserver.smartshare.dk>
 <98CBD80474FA8B44BF855DF32C47DC35F6589F@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6589F@smartserver.smartshare.dk>
X-ClientProxiedBy: DU7PR01CA0037.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV3PR11MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b394350-ac2d-4eda-31f3-08debbccafdd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|6133799003|4143699003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: Sw6R+bit0BFjkDNrXFUzHRcwncYG9gJ60bOG4Jn91NJDv0sPjWFmfCkkIXjmWYW4hcS6l0zWA5pSMqdkOXSkiLGy0yjUTyhjT4LfKwL5BZGogj1ignIBAUA7trQBQX50KaSYk7ITgI6tvwWI80T6SfzH8KfpDd2Ap7fpT+cKtQgIDlyJzoeJGUIia58zu0FURQTL8qmrKmxrljEBMQxYk3W6SsxQ0KM39O1xyE0G44Xw74UfNwTHLrR1E3mwxUmbXNgLnTtHebaAKozusOK2fu4ptizosmkYjIGBle63G2LFMwMga8pCsrwP9vc6770txvNNN6dltUI8MsZ48TY1I+nOlXz9kU3oICWXjPMhnFOn5pYUW5A+40NVCvwEq1yiELRVi/fo7SslO8vazMQppaA9+Uq5m1eoKdA4S9kKC8Xc9phth8Nmvsphclmu9JGzfKZnOgiviVgxCzkccE8K8jBibq8Q49COacnKHj9xN4kadTRigDkjHTTg1zpbfrPiDmFbG46AHDkX1GaXtaRjIpvt4zsY72CKRBkx2/alafEj0nEteJ4GmM3hZExoyvZ4tJkIgvFVq0Sd5pTMjGlJs5DL+TyGclHMSGcBYVwes1Njihqh2GIiRF1UggkEhZqiR+vb9wXtgx5f6JSyx0Ua/bVjB+woHgOfpaFUb6TEmmOUsmb4gBo9Li6j9X4D8Ree
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(6133799003)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ALPphKXmg+gHR5WrdVgJl+CP3dhdO6clMxHg+LEyfF4eBDc1XyEGB7PIhE?=
 =?iso-8859-1?Q?sHRyCg127STRbNbILZ5OrGinP0Xzhbd4W1QBodMXMCkbbeHuMdk1CQXi/X?=
 =?iso-8859-1?Q?xWBhzjYiTmAdylKqhZ2U92hBpXXrIY8mde4FGY8FsIUTCSUpmyxA85yzUg?=
 =?iso-8859-1?Q?lQd3eh8ofRxm4nuyv/5bWi1+dhKayvsJtR6mYG2H6D7hhy9oBfMxcsN9kH?=
 =?iso-8859-1?Q?SVYSvqd9Bu4h9VjtCJMYe4poiRF8hhHNMCPUVjGvSnauzEvR+4uaME7tjh?=
 =?iso-8859-1?Q?WfHzVk6sVp2U1lB19nC8rt3SmDey2OLQ6t22bKbwP9jeF771FdUHzNv4/X?=
 =?iso-8859-1?Q?D82AVvTWk5/Tts8+7DAy+jjBBemgElhupQzRf1+aLtJ4S1rRQHf2qXlmBY?=
 =?iso-8859-1?Q?yMIDW5qDh1/6CaBdX/N1sHeXJ/HIdL8sPLH7UkcaLw09EA/j2tX0/a7HRt?=
 =?iso-8859-1?Q?/AIDgqNkl8T30fn5qMb0KKyK/cfH9/ZkplH1EQ73lbyS6hUJUge55AFJoQ?=
 =?iso-8859-1?Q?FXzcJpBEZxBXPHxpuH0s8r1dxBZbJ6iJ5VVB2VLnMIDVuL8d75sTa7ZtAC?=
 =?iso-8859-1?Q?S3hITzQxZVk2YYu03TiuZJ02IecOWeY9lbmCdq/MrEBeRjmef47x1tqkhB?=
 =?iso-8859-1?Q?qBlrf449lsqPsE49FXkW1HxQJJVz8k8CWlSUEO5LreiI3IgmpOG45plg5e?=
 =?iso-8859-1?Q?TKtF4xjMWuCDNqJhMuQMxBtTw0X7WFbu+7YY95CcI5cO3SX2WodSFJnX4E?=
 =?iso-8859-1?Q?SZoMCecS0gAgmNwlSb55oNxvNtG93z2VzSye+lpTKUo/CWgXoT1DDLRboM?=
 =?iso-8859-1?Q?HovU6CC0nkRquDBXKXHPMhnnJQQ3rWpa2/Xj0je7IMbw42SJa7jX5siV1R?=
 =?iso-8859-1?Q?pwChHreN9jL9vIYfPpwEUdIVh9ir32CIocV9upGbvQmEFm8hDHTXyukPyx?=
 =?iso-8859-1?Q?Cr3Wx7L6COCXgpPDXJRE/sLYW5EtsanMkBleaqA3GhwIc6beB2eLJanwyg?=
 =?iso-8859-1?Q?UfWL2IOSfL0bcPdhY/SJiUaeoPx1dJMz690BZLwBMWyxNS4/3y9edEsCrn?=
 =?iso-8859-1?Q?+LYB++8tSYyybLefRXE7goLTNBiIzcTqx6+4QvC4AMPO4MRsZ6mgZYapp8?=
 =?iso-8859-1?Q?XEjqn1cRVZz5fJbjsFPJbvt4FbKIGEZ/BsO4PPQkyo34amUM53OSsaHTAb?=
 =?iso-8859-1?Q?3CLeusZgFToqQLWwqlHPB1X9zIC6sEHWb+USqWc6L5Dd73OP+krIXY21Tv?=
 =?iso-8859-1?Q?CMQ152f1Ioq2FLuexYFGKPAitiu12Xx+ECd89sJytGUW4WKhZnH8+IGpE7?=
 =?iso-8859-1?Q?e5IYbdnT+FXNcTi9b4/vzve1y7bOjkdlnfhsDJObqI/wElqG9U22SJu+1G?=
 =?iso-8859-1?Q?KuoqwGW3K7pbjMUXWDSu/uUYhca7ukuh2+A7VryspORsp+egDyo8KPnAAH?=
 =?iso-8859-1?Q?0+ixNZwsqfu5j2z8F3h3UTWur3YmA+WiTmSSwfPdKMUmeqnOJvC/IQMy/K?=
 =?iso-8859-1?Q?JWvHFCqCugfPd2lA2umFG9IToo7kqmNyuZLliXiTu7WVhemS0Rmr+1XuKj?=
 =?iso-8859-1?Q?USFqQJXRpFf0TrCzrsdvKgkvfsSj+ERUgTyxKxxW0LkTMWMDGJ5DBObOAB?=
 =?iso-8859-1?Q?kxPLS8aVM5mtQ+7KRNwZ7S6nsu0fGPSA5uYVKLsvE8Tu4GeHVTXYNjjH2u?=
 =?iso-8859-1?Q?3wn3BoqmLwpyE31kXvyFbnSbv9p+XuJOL7LD1r32vxUJjcE4J+9PUvUbqj?=
 =?iso-8859-1?Q?0XJ0HshkGJYFGWHlkGSXbS2WJlIYTkNDEWaN0qT07XykwgU5qn3Cz7fPfA?=
 =?iso-8859-1?Q?KK02pumXzGm5lGwhX8iu9PP9YSsFntM=3D?=
X-Exchange-RoutingPolicyChecked: X+y1gPZeEptrHNYjC75lTEd3YHM6Ocis5O1xGMBiv2eyj4T3Wl9By6/p+SGWKpTqzXFEpj2ygz8KY6UDbL9yFWfJMAkg77IXxsb739uQdpx1YPVT/9u6lbvK19vDo50yPu72lpDCTJ9id7wIeZpvv8KAWJ+BkL/25rWtz54VMqfrPEkJ2B5xx7Td615xaUIZMrDYCeMNTCDNUGDD29AbLV8Djo9TKlwpqWg1yINIdkPJRAxNO/MPpQ6mIUJmgcF0bDh70i2OSdpksgGvS0XDZFlM5/mTagA9NF91GRxdK1P/klL2HKVKddwjEmrhJNgOc1aUBrtzIvGqSv7bJ1d0RQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b394350-ac2d-4eda-31f3-08debbccafdd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 08:48:13.3689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /R5x2u5K8nCq3YKGb1ZNvsEUXqE2Qc+YM08lH7oAAKxbAfaQeFWaGZ2lTW/b3tah8hL5md1UJ8pdKFhHXWZnIPBoA6HpyQ2aX87eLq4kfhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8506
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

On Tue, May 26, 2026 at 07:45:24PM +0200, Morten Brørup wrote:
> > From: Morten Brørup [mailto:mb@smartsharesystems.com]
> > Sent: Tuesday, 26 May 2026 12.37
> > 
> > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > Sent: Tuesday, 26 May 2026 11.40
> > >
> 
> [...]
> 
> > > [In all this, I am making the assumption that burst size is well less
> > > than
> > > cache size. Also, similar logic would be applicable for the inverse
> > > scenario, e.g. flush to empty (and fill burst) and fill to 75%]
> > 
> > I'm not so sure about this assumption.
> > With a cache size of 512 and a bursts of 64, the cache only holds 8
> > bursts.
> > 50% is 4 bursts, and 25% is only 2 bursts.
> > 
> > Using a replenish/drain level in the middle requires 5 bursts in either
> > direction to pass the edge (and trigger replenish/flush).
> > Using a replenish/drain level 25% from the edge requires only 3 bursts
> > in the wrong direction to pass the edge (and trigger replenish/flush).
> > Much higher probability with random get/put.
> > 
> > >
> > > Now, all said, I tend to agree that we want to leave space for a
> > decent
> > > size burst after a fill. That is why I think that filling to 75% is
> > > reasonable. After an alloc that triggers a fill, I don't want the
> > cache
> > > less than 50% full, but not completely full so there is room for a
> > free
> > > without a flush, and similarly for a free that triggers a flush, the
> > > cache
> > > should not be empty, but also should not be more than half full.
> > >
> > > One suggestion - we could always add a simple tunable that specifies
> > > the
> > > margin, or reserved entries for alloc and free. We can then guide in
> > > the
> > > docs that the value should be e.g. "zero for apps where alloc and
> > free
> > > take
> > > place on different cores. 20%-50% of cache is recommended where alloc
> > > and
> > > free take place on the same core"
> > 
> > Yes, a simple tunable is a really good idea.
> > 
> > At this point, I think we should optimize for use case #1, and go for
> > the 50% fill level.
> > Then we can add a tunable to optimize for use case #2 later. I will try
> > to come up with a draft for such a follow-up patch within the next few
> > days.
> 
> Adding a tunable is not so simple...
> The choice of mempool cache algorithm (drain/replenish to 50% vs. drain/replenish completely) should be passed via the "flags" parameter in rte_mempool_create(), but rte_pktmbuf_pool_create() is missing the "flags" parameter.
> We can add it at the next ABI breaking release.
> WDYT?
> 
I don't want this just a binary flag with two settings, I think it should
be an actual numeric value. Can we not use function versioning to add the
new parameter to all functions needing it, without worrying about ABI
breakage.

/Bruce
