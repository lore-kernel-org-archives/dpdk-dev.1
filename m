Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8024CD98CE
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 12:28:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6CBC4325A;
	Thu, 11 Jun 2026 14:28:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 05FB040041;
 Thu, 11 Jun 2026 14:28:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781180882; x=1812716882;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=i/emx9fUVc5pM8lEq+R6IVIhbrHA3BbqyIKmr83xESA=;
 b=Em9FK9zaeySTgNtkTTyWOnKPQ7EVp8MFhccnEmKKLE0L3YTEnmqnjsrt
 cpwsMZgSdPj+Dar5NWnlrQ27P6X/D0WkeVd0+SYeBGCbYwTSMMABS58PY
 GKT8Korpdw4jN1CdZA3It1opzeHq8qJqGrmzmHzOqELYDpASgYrQnv6LG
 PvTDBNQQx0/x+mT6KJQfI+73gEb/bhaFMkxo+E8r056FJFG4gsBB+KkYv
 9Wo1Y/6YOfFx+WY9sNauWSOheEuU0Bkt+jUyZEIiZElo2Fp7x27pWh/S6
 27fKyAgUkmAggvlVu726l8iISsXHG2rO+vt5H+4Vl/rC1g3/chunJuQ1u A==;
X-CSE-ConnectionGUID: /l5OteI2SweKIjH4+jtMcA==
X-CSE-MsgGUID: CsPvU+qWQMCD5m6HkV0lbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81733265"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="81733265"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 05:28:01 -0700
X-CSE-ConnectionGUID: T5JR933BQ4St+gNrm601Bw==
X-CSE-MsgGUID: fOrkpNFZTUuo4v5kvkBJSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="270132734"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 05:28:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 05:28:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 05:28:00 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 05:28:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBvAp9JWP1XfV9mdLLTQBsfCtuRNsXr9TODoPnuD0ByzVQ9ZbbLLe4/p+Anp/nGkpp20/3WWgHxb4zNWOCNDdk1BEXtLDQCmmflI/uyzMtYwJfA15JiquEMxoehsxbqFsRxB1gYB9r3+t5jobZ+jz3ZHs9SSZFvwRoBqPLByV+LQQekG5H/Q24ch1/96ZTdIX8ppiCfjXNPv8h2yi+VfPsmBJq7oQjwZ1x1Oe6jKoWrGHwcsy7YRSOYB7WwjEjtKYKrGsEGdAW1325cn2rbVNJUZXGb5WSMM1RKwHHQkkbiwc0RylUEp+KRJSKm/PcU/oSW5B7orIJJrD1BvGw/JMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kf92c+t2EH6zWVhpBtPdcp6Kw/xq81PujByg/FHafWI=;
 b=c+u3LcNjfE25tTkjGd3tWSAqSa7Dc9LC1rDT23ake+7F+gOqt0Fliyj0rh0lrJVYSP8gZKz6Ga4UkmF8SP7jcucHdd3NdKYhld07Jq47Sww0k+q3ekA4Ee6Fvgm8ab0qRzFgXtinRQN0nKF7E+ZLY6IoyuXlw/G6BbPdltKFzuWCeGB0Lig93HW0w3VfIPq+onhx9tq8Ln7CSJ5X3NFyDXOzeeYGWWf3654jeFM8KAzvw6z5d2BzNsy3FXibS0JPoRpUEMi0zeg/is/J9cBJF9bP2h4SaJI+OQ4Y7Nf+Vi5KiL7qbq7e+WOeGs1fd6Mvatjv1c/DnyDPSHb7TgESEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Thu, 11 Jun
 2026 12:27:58 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 12:27:58 +0000
Date: Thu, 11 Jun 2026 13:27:53 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: Re: [PATCH v3] net/iavf: fix to consolidate link change event handling
Message-ID: <aiqpyUmXsyrm9-ll@bricha3-mobl1.ger.corp.intel.com>
References: <20260609001022.357509-1-anurag.mandal@intel.com>
 <20260610141230.369232-1-anurag.mandal@intel.com>
 <IA4PR11MB927893A5541358313C538CA28E1A2@IA4PR11MB9278.namprd11.prod.outlook.com>
 <aiqI5XxPOvu1m0Bj@bricha3-mobl1.ger.corp.intel.com>
 <DS4PPF6915D992B77353318BC850C46DA5C8E1B2@DS4PPF6915D992B.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DS4PPF6915D992B77353318BC850C46DA5C8E1B2@DS4PPF6915D992B.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU7P189CA0010.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: a50435de-f753-426b-ff2f-08dec7b4dec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: d07L8ttzal8zFepeuXy32Pq+I98V/P7Dzl903bcF+6+vKH8TQRjHkqV1QU0crlYbVi9CnL0z6WmAkPp8qt1oGdmG0LJLjNlSqCFqZbBzDM245t80/EjWbvUY0cBFsUWv/rbBi/Ao2sC0xDhQnl6o1wnNHFLGOuRzXl9dJGksggj6KMe0PyKkWudBJ9RgW3SwXOTt0o4OKA/4Neb/xs+otGos94fjY/B7NCfQA+VWe1b3aaVe2mjDYjXARrRab9qnOGbPHnMSBwgHPvDk1vyjlbrcxWFjMjCdjeTP/5PvLKCQTbizy6tbHYjChzWPDn6zN6Avxke5cXuwNCEj4BC9GBBW2jCe0tylMcrxoipssQX2j5bWXauy3pacjosYuKdY8Fqn76VXYIvagd4iQ1xbd/uW/v++C6EMVZNqrjcHmXe/u4YyhzCLM/GFS/9888O7tPUI4UpPXNQmysFdyPoaI/D+Z8uJc1YX8JejSfkPE1InJzLdJ2+oMKlhReQFaI5VATyZURc2TXG1p0hZ2Au4BxM/dCUXTmzT5QennTrSNars3KfQHpi2kT2PU73vMs5/TQcWebYVPOwlF0HSWum7PHgcxuJ6ad2mQKBGQj56ioDIIAPwQUcTRS0LB6NLaR0iu07ZEHnKIyPz8MnHZ5hUyjDZSrpThuUifyZ/g7qjQEpqJ2G0dGyTR6wkXWWUdEgR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EQI7xzB2lddS/Ii4QGwzi+muSUD2au+o35UNU+RjT8uk6563jOUzS8z9md9t?=
 =?us-ascii?Q?IN9+Kxpyr429hFL3rxiOsO1dt6AKIhg9vrGtfVzB+eJwAlGekrHz1PsAiEba?=
 =?us-ascii?Q?X1/g81TyfXgK/m/Ng1cBetRcblVyLYtzoNMCXbyojMSTRHGdEwCIzfqF4Re5?=
 =?us-ascii?Q?dPiJLMyLn4mxenQSS4FWMaobMIiFA1m+fuV/kylM2pjXdvoh4jy+i8qFm6o7?=
 =?us-ascii?Q?Ms2GdzSYEI3CQi+zI6py0Ozm6oh7j30CbRg5ff+zSZIgGMQf2XUMaUO0gFbj?=
 =?us-ascii?Q?YxU72kPvcuX9tKHS9Dcd183lcnsj+eoGc6cPFdQ9rHOCs4q0WJCe/XF8GMY8?=
 =?us-ascii?Q?PZH+cIvxjYUApdlUkPIxzw/BURyEnIV2NaSWE4murgloQLvToOVnzXZ9j9Pt?=
 =?us-ascii?Q?GeyD/7bC/OI4X75hgX2Yavq/v3KcbnZlqOtPMFXKszUqnVHly60ciHcMBOJX?=
 =?us-ascii?Q?XBZg3abDvX2JGdqLr+qeG9oZwC7YMlts4bhSsEi0IOnTsRNybw/e/wx1SRui?=
 =?us-ascii?Q?E/B39Mpab5BGCZs4BEwE37IsarVqXeLSBg3vIi4H2hbCf4Zs8wp0eBLT14if?=
 =?us-ascii?Q?VwCTFUR4VMKqzkNVGpa/glFQL2LgguckNTDgXMQISnhMVYIFF/0zAW86MN2z?=
 =?us-ascii?Q?V/YRhxqZoLwELcBJh0a06em9Jj/DXumAEGF4AUhHdHLbklvMbDYsS9KFo3Ux?=
 =?us-ascii?Q?k+fNDCdiLSi7zL1o4gjNYEF840jXthRrIu21KQRe6O8j6msTekgSwSfWfH1C?=
 =?us-ascii?Q?l6ax4qLquc+xZSaLEchlUdzwqoi7HdTmJ77QFRbmmQTnKuWaIDYN0sr7v+9E?=
 =?us-ascii?Q?I65/Cm/dn5rpoKl0USzlr8QSuyf8+tA0aq73wSyg9mtI1EgEdNDP3G+b2g5X?=
 =?us-ascii?Q?wku6EWj3/6seAr6ixwgFz8wdNAhusJwpl76diwNBNm4jctD0hVtf1gD8tD6S?=
 =?us-ascii?Q?MY94a1uDZLndYuqlcVxCVsSqnopu+Ac3hn6bAzB0iC8uxZ9QNpiFFvvZU9Jq?=
 =?us-ascii?Q?XDB+kwVcUFurnyM03kMMvNz45VSKtMZFsAJkeAf0FmHXAx4OCJIHHDy/TvuV?=
 =?us-ascii?Q?Ttzq0ijLW7qKNFSerzXSeUtVKJM2w9ZY1rGp91AKBylU8ckGmXOi8JsqYOJ1?=
 =?us-ascii?Q?ZnBAgRe24eSBaGOzhGRzv+j/gJQxqm0aoxfV44kheAaKFs6yiP+9CfKIK8v8?=
 =?us-ascii?Q?htm+vU/HgIEUs2c6NNXcKQ7G7zNeu+3F9NuKjRUPVLXZ3wvu7takCP29i/tD?=
 =?us-ascii?Q?/lhmJQogL7jHb1v3obPmaUFoDxiLelMgGspwwkhPukyWCvm+kEkP/evnQMDo?=
 =?us-ascii?Q?CY1cmx6iLlRQWpngayTdxy0qR+s1XY4q2oTyiFSTwCErtUcKb1wFgaSYnzxc?=
 =?us-ascii?Q?oQWzv+c+/YPNfKQ6oS6DJ8dA/Lt75gNoNYN8B6U/OhjpsE+H0XvdrU/TltK3?=
 =?us-ascii?Q?/ElTVZNmPKjcsQwfGOYPjHksG44x8cxnbllHwtC4s0JnfG7qPhdsSaGNXtF1?=
 =?us-ascii?Q?ypYXETsMrAoG0rSYM8VpyeOK8A+wG4edVV/mC4kEK21tAq5X9zn5n36Ht6zz?=
 =?us-ascii?Q?Wqc5ym3fel+bEZbao+HZXKmv+/Wsh8i9d8Sv4SE2gXdzO/l+kNH0iQe/nUUw?=
 =?us-ascii?Q?iHjCJhC6kLys0jvxu7pvOigV1nUUof78tSljRZc52VouDSK6L9nRG8nGY7nZ?=
 =?us-ascii?Q?W0pAGiF8a/CCnl6uww7WY2Ccd+Jb4MHstv+qox3eulQcOagpNIlule4A+mOB?=
 =?us-ascii?Q?gq8CmAyj0+R4bL9baODfRmhUCGUPLcw=3D?=
X-Exchange-RoutingPolicyChecked: cJxQpxGUZNDPo4ODEV+TFSg4yAmYWf420zb2GaCh0VWj9AjxAJfb2GDqDBRZ+8ud8D7Z5QSjg7UE7ojzNmEm/Zyn+cdu12GIn4UyJVeRXJ+rzTqSf4nyULCDYuZ5QjFaszQp6cVT+p6Rw7AIG/faguUm6jQXSLxTsc0vRHCbguhog9qTZLvYQcoB7orOetkC9pr+CF0gKvyedj+g4RVNa74ebuRZxYw7ia8E2MMhrjCfKjQg5BM2rBnpS+ZRuaGnUJq38qy4tKvhCsBrptqs+G9FnWfYOQeRM7Vkw1oSufksCxCUebeNANuodlO+jyYQk/G7xdOBKeBcLpIejSnb3w==
X-MS-Exchange-CrossTenant-Network-Message-Id: a50435de-f753-426b-ff2f-08dec7b4dec2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 12:27:58.0695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vodh610jjiFo0wO+Cl76a/BpcSdGfRG2kMXS3dzs3xt0UFQ1zpcGF+lZfEX7+6f9SLzW0a5ACXAGXSpa9xYcAHQv17heLfTnkagnT1GZYcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7522
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

On Thu, Jun 11, 2026 at 12:59:55PM +0100, Loftus, Ciara wrote:
> > Subject: Re: [PATCH v3] net/iavf: fix to consolidate link change event handling
> > 
> > On Wed, Jun 10, 2026 at 03:34:27PM +0100, Loftus, Ciara wrote:
> > > > Subject: [PATCH v3] net/iavf: fix to consolidate link change event handling
> > > >
> > > > Handled link-change events through a common static function that
> > > > reads the correct advanced & legacy link fields properly and
> > > > updates no-poll/watchdog/LSC state consistently.
> > > >
> > > > Fixes: 5e03e316c753 ("net/iavf: handle virtchnl event message without
> > > > interrupt")
> > > > Fixes: 48de41ca11f0 ("net/avf: enable link status update")
> > > > Cc: stable@dpdk.org
> > > >
> > > > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> > >
> > > Thanks Anurag.
> > >
> > > Acked-by: Ciara Loftus <ciara.loftus@intel.com>
> > >
> > Just to confirm something here: does this change fix an actual underlying
> > issue, or is it just a code cleanup? If the latter we probably don't want
> > to backport it, but if it is a bug-fix, I'd like to include some details in
> > the commit log of what the observed issue was.
> 
> Hi Bruce, I believe there 2 underlying issues being fixed here: 
> 
> 1. Ensuring LSC event is sent to the application AFTER configuring
> watchdog/no_poll state.
> 2. Ensuring watchdog is re-armed on LSC event, if a reset is detected.
> (Before it was only re-armed if link was down).
> 
> The comment in the new function iavf_handle_link_change_event explains
> the reasoning. Perhaps an update to the commit message could be pulled
> from there.
> 
> Thanks,
> Ciara
> 
Patch applied to next-net-intel with title reworded and some additional
text on the commit log. Anurag and Ciara, please review the applied commit
log to check it is ok with you.

/Bruce
