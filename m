Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104E6C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 09:53:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8BE7402E0;
	Wed,  1 Jul 2026 11:53:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 87A9540278
 for <dev@dpdk.org>; Wed,  1 Jul 2026 11:53:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782899606; x=1814435606;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=NPRB0hdXipsVCQBnAClAXSR4UCAtBVjOos7o+3Dsq9Q=;
 b=jlqG0znLB6UhyTuvmtUgLUYYc6rcRgFDljgNT1WR7oc2HPSk//mrcri/
 rw/+AdE3RlqPd16ySpgmRumwoVtWjEmWUPNKEnbkw7LokW1ncIS6HD69w
 EYoN9H3v4+Y/3ihDCqSo8g3ah1kKaYoIejoDou+nCJfMyNZPib/j6Zt2w
 Fgcos5zp9oLzEoiaIioocr8cybIiKZwf53LClTEcjCUwCNoAB6irKfBWF
 z/4bpcO7J7xX09+KURTLLoAOCpKN/8mv9rzQ7T0iMELLbDalcxo/+Wnzh
 UpFxJdJxlX5WDWZITH5fyVdUt+499XIbUZKgKX/HMIW6J0C/DR7MKo4Xf g==;
X-CSE-ConnectionGUID: ZRTC3UahQ2Grb+olLh1SmA==
X-CSE-MsgGUID: +iNop8heRt2wNOlomWt79w==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="94781986"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="94781986"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 02:53:25 -0700
X-CSE-ConnectionGUID: wfYlmlDETIa/jrMoS3fNsA==
X-CSE-MsgGUID: nXw4L61uRQ2KKDAv+0eWMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="248544188"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 02:53:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 02:53:24 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 02:53:24 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 02:53:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eoc8eN3bMsRlHX0NNgGbV5mYBmVSB2WmZOC6Dz61AbZnuST8Y6lyoDOv/txpPBG+z2dNgk2y3Rg6mYEJSw1rPMbsFB6IhRQaobJ99sChPqL6sbShJEgoB7xozBnyNPUfRWJ8WJRohSgOKhrfJsQ6v471TkST600+3PyIhnRwJQ+U7rR9VkWM9ZiEx8DUI+3s6NRPicb/lpzwcBcEKCq7qyk0QfdOygNELPZIoY+g8N8XjH4POr3CddYKcTpGku1TQ/VL5XOhewxfwekaGlKGBf7Kk5QAw7b8PLuKCZrs3IpYFoJzLQu9IPxk4KqZRDkHbwDqz8Ve2bRL7ldkbQE8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lIXS30lFw7WdYIVaFHHs6ey7p7iNt0MV4f9vXtJfD0=;
 b=tylvQApp6pBnPcRrmLpfpX2G4tvWG3gUHcXeIl4S5HoPxvlIosXaAl88/tm0UfiB9DCEEwAUWeEB6zU62PFdYnYlC58RpzL8bQ4ZWsflR5grxVrIEMe4AoFdK+SZHTbo0+s0CUaSdXl5EWCmqaZN8QZY7rkeKUIcrc0Rd0TNLBx6vvKc1yG0H1g6vb99/53piBXSlxZY69B6pK5zeWhF/PIEZeV2SysaWW+w8ol1fBA7a+T9u9z36vwzTkug2fjWRkE3nIbyZkLYa21Pm3KRf5ILlyGpOKRZd+8DvFWM3RTX9or0flpyUi6vAgo7xxjxqckgO2WrYSWcaHAwxF5UiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by CY5PR11MB6365.namprd11.prod.outlook.com (2603:10b6:930:3b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 09:53:15 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 09:53:15 +0000
Date: Wed, 1 Jul 2026 10:53:11 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, Jianfeng Tan
 <jianfeng.tan@intel.com>
Subject: Re: [PATCH v7 4/6] eal: fix async IPC memory leaks on partial failure
Message-ID: <akTjhwjOhhPPZeK2@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1782469943.git.anatoly.burakov@intel.com>
 <c4564e3c9e7ad675c60655b80cac1a077ad24bb1.1782469943.git.anatoly.burakov@intel.com>
 <CAJFAV8wmRsznO6S6gz0cmnhAs+QHW1k=7oFo3DhR9--A-Myo5Q@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8wmRsznO6S6gz0cmnhAs+QHW1k=7oFo3DhR9--A-Myo5Q@mail.gmail.com>
X-ClientProxiedBy: DB8PR04CA0018.eurprd04.prod.outlook.com
 (2603:10a6:10:110::28) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|CY5PR11MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: 862423c1-95b4-41f0-28e2-08ded7569266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|5023799004|18002099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: Gq2TwuqEtImL4xlMuJamhEy6ht22eKwrnGdYJQTe2iKklufbMsjAeyCcwF/9dr3O9eJrbrhsvsDZf7taPztFEQyG82JuCV3Gloh0w7R2UF0itEymztUYKr/nElCE9Tc6rO3muhJMnygh5tZ5A3JBeIl4pD4TxnKwoGxeCk0BTUJXveBU/kApZGKlzQmQjdDuZTFVGqwhLriOD/Zj3lWpFXuvJla4pincGQHNtfGDkoyjtSJ8oFllH8uufr3WYtiCJLO/WYglquRADsZFJL9nqoJ8GgqEULKMQyy77m5qUujpG2ZQXXC0mbiU1sucIYm952neCkhCdtXWllPfknyZTe9/UnrsSd7ABihjuv6UdJ78/Q2pmmD3XR0IQza4BOXyqHHMDkf7IVmx74cM8dljzwX1To4QEHNEaUfm0DomROWfZOkrtUey7FmTmHOjjAI0oQZa1UQKjzwBpZRRKzhUrW50yZRRe19Z/DioxLChWjHJan1vtHLez1iaeezPLiqBJwRdhiPQSBrl8g9GCh1uNDQbXrajgXKV/i8nH9sb7URvx/6Lx0i1NWgTJrkKXrLEH5OK0HsCDfzl/QHY67MSo2vaS566kw3ZC0RpM/x7O3g+rI2FR07jOz/qDdrYMcbRIOaQpy3KisCpHclHK1ArgrQ5wiwx6ZPzwJWIfQN7gUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(5023799004)(18002099003)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hG7ScZkJtAasaljJpZkUVU02OHW/TsodZT7Vu2Jf2W4lWOrPoRC1TIyf/A9m?=
 =?us-ascii?Q?YHveh3iP+xi+mL9RLTYuGL6AbR3URKZAn8Zrj9zmwfKsjsOkOQ4ep4H5WV8q?=
 =?us-ascii?Q?D3JtQnyVAbbk3dzJqPox/FFCoF5Y6G+wolWWtKAkf2v3539GGPbkx9VHJA1g?=
 =?us-ascii?Q?sPRY6W0zIm9c2N+x2SPE+bIKBKOC57JVmlIW9YdjRnwmqHk89nIpKSQz/iQS?=
 =?us-ascii?Q?yZm9BRt8oV2rQvzCa3PCAf0ftKv8ZuVHuXIV2swnDoV3zNYo6MLk4qgfdXnR?=
 =?us-ascii?Q?gXIJX4lZyA6SW8Lx4ZhHa8c9XLYQTilwlQORpTsmi4IcIOnDNbDRyEeuKIwZ?=
 =?us-ascii?Q?k4PqgyJu09vFZDPcfZEPetPMmfdy/dCtXNw0T01kTflF/TCxpBdB3vp5dgPX?=
 =?us-ascii?Q?dWyffO8URs20cK5GUSnSAgByTrRRP9XT/Y9aCl1am5mKOBwhJ8YCSIjKt9CJ?=
 =?us-ascii?Q?vOGpv2I8imF3Ow6ajSe13hXV0E6BwYNS0Hb17ftEh/80bfzH9sGgpljNz9BO?=
 =?us-ascii?Q?aiuhWUtQJNB+uT4UjzEKUUSf3aFefpoJypRclMKLQqvOHADD8ZRHJ12CohAT?=
 =?us-ascii?Q?6re8ctKOKXbLhgVZPfaoABe2KzZMwPLWGKY103IUIbRgiX/G0wh5Hs5fiBMl?=
 =?us-ascii?Q?3Bcm+SKCqbXUy2zGzVqRq/hC2GfhwLJZJHPVDH6yVnaWbbnQqWU7ljWY2j4B?=
 =?us-ascii?Q?FQiRX8n6GdHGXWPOkv0Lja9um51SF3A8Do3nLlZKBaMaw+rzwoJdrxXCuKFG?=
 =?us-ascii?Q?X6sV6N8DG1719yy4lv1XzrshhhsaTnHt8na8Y+IygNq6Ide7TmXrVPRbLS5I?=
 =?us-ascii?Q?gn4seRdp4x0dRtLn9i4nX0OYMYQARsMuDdmTEAvYEaP6bGp8ZPlae/LzGu+4?=
 =?us-ascii?Q?IDlJfmjQ6K0GXYdMCxnN2MIPCIDZXMzMh5tGepBOTFIUgVkrHVbEUtMEqfPw?=
 =?us-ascii?Q?uwuhUlqw1s2S9z1X29M8uT/am2vgiU351w4L7VnnIOlwXb5p33subStgt/hI?=
 =?us-ascii?Q?F5qoH+j6LsIYcq2A4903IZVl7A3N27N89/hOpLSUQQFBUsYW0bD5XCRZXk3O?=
 =?us-ascii?Q?vlDfUfKTkhUGp70XvFCDcizwOpdjuhy/od8VjleZ09Vj6CZXkVe5HeiE9Ul7?=
 =?us-ascii?Q?KYvk4Xh6Z87H+TbyRfggq6NneOITk4HvXfoGRzS+GJZoP+ZnY5M5yjmaE4kI?=
 =?us-ascii?Q?Qhgtx8ETJOBEfozHcJhjWQcL9JhuKyc+8/OqiezrTmEiM1DJMrWMdtAhLNv/?=
 =?us-ascii?Q?0kMk8RmitsMMSCwYQsCLQzYXa57XDrGbvvd4Krr+CZLmouR8A7RCuuqzSkAY?=
 =?us-ascii?Q?TjgRwlNmoxtZvKhyURssYnspaE5tD+/5+vGP9m+/GtzZZwUII3DU6jiPUal8?=
 =?us-ascii?Q?4e1W5LuzuMH9RuhxCMdFfLFgQH+T1RgmIqqk1jvn/1qraVeOgWUDWBh+6UjE?=
 =?us-ascii?Q?OBhZ4FGABf1heIfcfuHqRJPZnwmuEDuLpBUxjjhCB1/+VgCIPgXrP+eIwhBE?=
 =?us-ascii?Q?1iLklEDK584Qqa9FKBTejHYw0YQ63rO0Okpka6I1iVcLTJR2kiCx18zj68oK?=
 =?us-ascii?Q?RG+44gh5Fzzi3AE3+TTDV/Z6jnpsmUSSwW+8cszjFfno2CUzWHy7zAwRBX6w?=
 =?us-ascii?Q?9NCNL8gp/+B8BWQtRk+09IXXhz2VvkGBm40a6p7OBoEoP0NYYIRgptAq7ekS?=
 =?us-ascii?Q?04mZAsdnVig65cGilUoEt96HjC72jeJXcEAd5lSj5URFwiaiZD5jSQUr0jus?=
 =?us-ascii?Q?udPEY13hmYItbh407OuX2XoLYGdaJHQ=3D?=
X-Exchange-RoutingPolicyChecked: Bg0POKC3VH/gIsFawq3odZCnh3axYhlewdNfA0NAzyvJz2ZYFT1v4SgmWkqFwBEg3l3N4whtSYZdE+Q2RdMGHfCKCkMCXccXkwUzcDFHDHQ7meNT7IESB4GXIvZ3KP9qlpjkso6ya6DjzDKta8tYO5iwDgIYRbMo/pwjyESxOMMfpilvUS3w0M/YzHScRSF3gs4MIVONefxt0sh703gI3+8BNMURjmyTTsGRn42BtzKJYBKwxvdlldgcukDdIRhL0vo4va1YkDmk0koRYGbfVMRo/W3HZDD8rKEgur1wpKD9xTKJaH9dY4A4a65j8IdWxY9nVOXZKohgDevgSrN7zg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 862423c1-95b4-41f0-28e2-08ded7569266
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:53:15.7851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7cxUFTWsBaNsp0PhFyfbgMRBbJQvbrnSjr2ZxyyW7zlsEBBzcHP3vd4WygDZVHWwb4SyXoQzIkAfz7VxEOtT8QJreJzPPMu3I8Z5GXoOno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6365
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

On Wed, Jul 01, 2026 at 11:47:05AM +0200, David Marchand wrote:
> On Fri, 26 Jun 2026 at 12:34, Anatoly Burakov <anatoly.burakov@intel.com> wrote:
> >
> > When rte_mp_request_async() fails to send requests to all peers,
> > copy and param can lose ownership and leak.
> >
> > However, we cannot simply free them unconditionally, as "partial failure"
> > means some requests were already queued and thus still reference `copy` and
> > `param`, so freeing them directly on the error path can cause
> > use-after-free when those requests are later handled by the async timeout.
> >
> > Fix this by rolling back queued requests from the current batch, and reset
> > nb_sent to 0. Freeing the requests is now safe even if some requests were
> > sent, as any responses or timeouts will not find the request ID in the
> > queue and will safely exit without doing anything.
> >
> > Coverity issue: 501503
> >
> > Fixes: f05e26051c15 ("eal: add IPC asynchronous request")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > ---
> >  lib/eal/common/eal_common_proc.c | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
> > index 991bf215a3..0cffc7a127 100644
> > --- a/lib/eal/common/eal_common_proc.c
> > +++ b/lib/eal/common/eal_common_proc.c
> > @@ -1245,6 +1245,32 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
> >                 } else if (mp_request_async(path, copy, param, ts))
> >                         ret = -1;
> >         }
> > +
> > +       /*
> > +        * On partial failure, roll back all queued requests. We hold the lock
> > +        * so no one else touches the queue. All requests in this batch share
> > +        * the same param pointer. Stale alarms will fire and harmlessly find
> > +        * nothing via ID-based lookup.
> > +        */
> > +       if (ret != 0 && reply->nb_sent > 0) {
> > +               struct pending_request *r, *next;
> > +
> > +               for (r = TAILQ_FIRST(&pending_requests.requests);
> > +                               r != NULL; r = next) {
> > +                       next = TAILQ_NEXT(r, next);
> > +                       if (r->type == REQUEST_TYPE_ASYNC &&
> > +                                       r->async.param == param) {
> > +                               TAILQ_REMOVE(&pending_requests.requests,
> > +                                               r, next);
> > +                               free(r->reply);
> > +                               /* r->request == copy, freed below after the loop */
> > +                               free(r);
> > +                       }
> > +               }
> > +               /* requests on the queue were removed so keep things consistent */
> > +               reply->nb_sent = 0;
> > +       }
> > +
> 
> Please, don't reimplement the safe macro.
> 
> I plan to update this with:
> 
> @@ -1252,15 +1252,11 @@ rte_mp_request_async(struct rte_mp_msg *req,
> const struct timespec *ts,
>          * nothing via ID-based lookup.
>          */
>         if (ret != 0 && reply->nb_sent > 0) {
> -               struct pending_request *r, *next;
> -
> -               for (r = TAILQ_FIRST(&pending_requests.requests);
> -                               r != NULL; r = next) {
> -                       next = TAILQ_NEXT(r, next);
> -                       if (r->type == REQUEST_TYPE_ASYNC &&
> -                                       r->async.param == param) {
> -                               TAILQ_REMOVE(&pending_requests.requests,
> -                                               r, next);
> +               struct pending_request *r, *tmp;
> +
> +               RTE_TAILQ_FOREACH_SAFE(r, &pending_requests.requests,
> next, tmp) {
> +                       if (r->type == REQUEST_TYPE_ASYNC &&
> r->async.param == param) {
> +
> TAILQ_REMOVE(&pending_requests.requests, r, next);
>                                 free(r->reply);
>                                 /* r->request == copy, freed below
> after the loop */
>                                 free(r);
> 
> Objection?
> If not, I'll update while applying.
> 
+1 to this suggestion from me.
