Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F344606A31D
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Wckg1hKt
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19395400D7;
	Tue, 27 Oct 2026 13:46:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTPS id D501B400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 13:46:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793105169; x=1824641169;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ir8nnrGzWFO9YAbIc39ilPSAXLzX/2xTe5IgfSthreg=;
 b=Wckg1hKtMRsPx/VhHaiBwhnjZKDDVq9W4vvM5voQo/lDz3PLKlJrVNdi
 FF+UMrgaXXcBMTNlmExSoUOArvQl3KbAxtNDumj33yDxN6Ojp1lqpzR/a
 Yg2c1EHwxn6fapu8HOFMlRyBmNSKK4zHiBd2HLkSgpOOu1K2GLojeGAGe
 v3Qq617aTmTLxyrhJPj4p3IbonBErPwTi7LJUCqv2Nr/yoWN6e0Piumyy
 Fmjh98TAIquWS7Pru+3GyB4h3Zx0JbuMwR3LsNycaPLrYpRCzxVJ9bC1F
 y0pz6o37IJnkk0pYp4T1HEvzk6mIrRqlHL+71m3XneqZCjpWXkmYR5Wor Q==;
X-CSE-ConnectionGUID: 8Cpdu8dZQzWEEd8Vorb4Lg==
X-CSE-MsgGUID: Pk9ufHTCQWWEOYXglSiRZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1805104"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1805104"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 05:46:07 -0700
X-CSE-ConnectionGUID: jZhZu+3ASSWxcBlj3R8/Eg==
X-CSE-MsgGUID: dbG0MUoWQfaNvFrTEO+xvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6379644"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 05:46:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 05:46:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 05:46:06 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.19) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 05:46:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/XQoIWJz13jks2gEUhp8/V9BUIJ7RSRLy+0CbkpJc3TUkPsYCgZTi+N8Nsdr2gnp/+n7k+NQbbmULKHN3/PmXNErFiD30ouD3MGrADgzUrZm2j42pGZhoBmhM5JqsuIDTbr0u1O9jLMOUzQNLPPDyEETBPsOEWLasPd7BEuochhHigT0y8VIk09LqJX8y1PauOOgQyPsqq5CypDHyntfA8F9DuRx5RLYoIhFp35mmK7LQrYtdsB3G7hS1H04V7Jhb6Wk91V9OuOSHvlEI7/4hRPdAQazQA5YEJB7JllM7I9V5E0152Vr0J/oRpBUo82xHYnqtcsjTsC+klFmoiwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nTOKfUPGoDPbmuULm3uSCJ+1Ldwu5EkhGd8CgRm7Pw=;
 b=wzFMLk1dfiVZmudJSBR7kUhbToHlWAOpfBWZtn2lv4CToY8wxLAyjp1QAoxwPvdVV+RAICJIPuMftY/Mv1q59NhmozKwJEitP+NXDmTIfpR/xBaSYs9/GU2GKdd5DkYtBjXPF8mpJcPpW77+vIyrp0Cz4nIE65uelaofA4bCNjIwHYaslvcI1hYB/cdZsqbF2VL2ODsWDCjDX53lzIw2lQtJSpGQJoJK9YiDBofEwYznVr2mUFADd2mGxQpSAJZdlWLdsdN8y4Nxl1nK3iLMdAxd+jL1HUz7h4m8RDO69wQvPuSlvMq/HMhHRKnUtoCBewDal6HMe0ldVGZZMuUXzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SJ5PPF57F27BA08.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::82b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 12:45:58 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0546.016; Tue, 27 Oct 2026
 12:45:57 +0000
Date: Tue, 27 Oct 2026 12:45:52 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH 1/7] net/ice: fix DDP package double free on init failure
Message-ID: <auCdADZs8rY1xIsB@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1793097896.git.anurag.mandal@intel.com>
 <ef12fc7f36b7aac2225a3fb649ede19c46b7c9d8.1793097896.git.anurag.mandal@intel.com>
 <auCbllLxK2e6rYUY@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <auCbllLxK2e6rYUY@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DB9PR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::9) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SJ5PPF57F27BA08:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a41863f-c598-4b47-540e-08df34283eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|261026140227099003|4143699003|11063799006|56012099006|261021121427099003|261022113327099003|261022105027099003|261021123027099003|10067099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6yoMxHdFrgx3KfvBoa/DgVX4At+GO1z9iTpvAeovND0sypLmnSayzLS4t4iaY+pL0SxsvY2+xUslNAGFCpBo8xwPOS6gxNCBQs0pEE5rt6rBRLkjoIy/7DtAmwQCwH107YowcD9G2/LSI6eX+xECWX7U8gisAELlN+MNDQ/48gTOi//sgOzwFWLg2Dy0kagR2OZkg/kTky2ZoK0GV5JpC2kLyH/6iyGBV7XarFngv40cpTwNV9Gwj47AqKqoi5cmreNAL5CmnbLAOV1sUvCkcTxZqBDJmb31PcBHidAwc6MKPz5E3ivTCXuq4zD+UzsEA+yN3VclO1FbfXEj2beCadXjavFHxvoPIUgsnUGdQjbMpY2KZdOQukqpcHlxxo+QrBIqGSnFDkEWcpSRPiatEui5D0ZRVWau7317cU5NhSj8Hn71/LXfukhFobPSfG/AvBNrVU3bCglG+J2+Aye8OH25JBJJaAS5ZqaR5GTkQMUziO62agZ4b3T4l0HId/0YB7J9VKcWzjYE37FVH3Fl1iBvbZdyDLRDLG5YLW7Ppp3OYZ5ui6Lx/UaRBekxaJvxAzEhQw5aa2rus2nYweqAPzOQos5/k8a4qmSn49PsFzsZrpdDXG3S54TZmj42c0EB1CQlnU/4P9/coXRfEZ1wWFDDor5cTuoqF2/hPNKq6Ss=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(261026140227099003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261022113327099003)(261022105027099003)(261021123027099003)(10067099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PDEyXv1R03i+oZ0Cl1tBB33zdy1//O/CokLiV7E1PrVDFvxO04hOEPHP4fkZ?=
 =?us-ascii?Q?vJN/73tiOGeuiUtqnR6V1w7OzqNuWKVQbWpSwt+lwMuVTN+4Zs4YtdWb/+NB?=
 =?us-ascii?Q?wACfZMc5YmLdQRITv9D2cGADEvVmzvYbkuR7mGavNctlWhJRF4VHK/+UMcF5?=
 =?us-ascii?Q?2VLLom97yZzUxV36Tn1UYfWYI0Z8Hx8Uuc1cjzBpVO+bkLZg/aZbSLzZsRxc?=
 =?us-ascii?Q?APPKJwT0pQkiwuRUbu7iThOHVrmDh8seEjsYKX+IdrphzpY2QQNPej38dEym?=
 =?us-ascii?Q?VfX4rtI3xSIWsuoyVTMEDcKQ7WtR5xVH3CZ/457j96d2F+mZ8cbMnbMaHqst?=
 =?us-ascii?Q?m/QoZbbuEelJcKOc2KgKXleCFBZgcuTZNV/YeedYld+AYClCbgYFJOonSQjX?=
 =?us-ascii?Q?m0Mu8ikzwaXg0kp+K0XxBQ71ciMYmGLgNPX3e3MKNNZCz6Gi9UsaVuY+mIAs?=
 =?us-ascii?Q?k4k76ljrwc/H3CEGZ+0RPIjQVPJBw9PnVgfjDkeEg2B3wWDrCkS7cQ941g4i?=
 =?us-ascii?Q?cl4EJayOb7ZarY2czJMWG4pzVEjb68p2XEsSBBsj3HOm55WfR9zMiCNdvsfh?=
 =?us-ascii?Q?1NYP1QZnbiwO/eWU8PCgzvsobU9JuiqzdvdaYi2r6TMbPAQjAYpkaffGtfFU?=
 =?us-ascii?Q?YOUiXMy6B5VoYfH6/ezYfDIf0MqrNDByYxkCmpCxY9EtGLeq+Zu3RlZBvRJD?=
 =?us-ascii?Q?3st5qKIf4tt0LO/afCW3DWD0cvIve6C0lp8urQjMdjqYU0jRH7FG/U0o5R4Z?=
 =?us-ascii?Q?hcJRojat0NORGMCQFvTgPejsbHP0grK6biF2uMg1XJZ3w8l7RSByHg1MK3oy?=
 =?us-ascii?Q?VDKAWv0fO4luFkrH+OchJhJQzDKyiEfdcQmzfZVQy1xhuqY3C9LXv/evUcaP?=
 =?us-ascii?Q?zsfTf0ebu/QMRME61TtI7PbKElO73xipMyQp3yNN0NRygXJKk8BjToT9RJgl?=
 =?us-ascii?Q?zUzFactlSM5Lfo9822/0/TNDStcdL09Vlh25z32dhddGx3xynJg8zrn7s+ae?=
 =?us-ascii?Q?0ZCBrQrS/pmf9FUlpE/QFthn5SW/WCFDH2k0nS+aTkeAQ9xf+/n+dRM1b/LL?=
 =?us-ascii?Q?zSjaByWrRlNaoqPU/TDYuTzw2THA7QwVEUjUs0iIyOlyr5Ity17IcNVEnnas?=
 =?us-ascii?Q?5Ah6/u+IjmM/l2qaM7opILkABuOEbFnok+HJDFV8OfRbNuAyHsG1CUhCBcI2?=
 =?us-ascii?Q?ieSuVbfZ2c124N06r4BqD0mHhPNJbKmn07rpdwB2svC9oPOn2/T5fqkWluR0?=
 =?us-ascii?Q?/wy8UNxoD9a33b/ybp0KXs8iVnxhm1MVvVkwDdh0y5YCciZ8SjIcm53fa1R/?=
 =?us-ascii?Q?FQe5s+kzSeMa0W7m0JwlXEUD2GiCsbCNyHG8K9LSsVoZZ05Z6uXA/Ie9vWvi?=
 =?us-ascii?Q?Z7nLpa87SfwqFSbk9MZayJ5keOaBaEzlNrW2Bvd86XcxB4d2MbYjyQuaUEFA?=
 =?us-ascii?Q?hKFJK7/TcTpVosv9e5mC1+RiAPjZRSAAPkAtknna9ffl2fK3IsyE/Re+LzRJ?=
 =?us-ascii?Q?MLvbFzBVhF4DfIsiBtDk/d9boqul3FLOR5J7yHy3ddNPaobWI8OJk+jAMJkf?=
 =?us-ascii?Q?WumJWDa/Jnc189sQ7I5q4MhWbLIMzEu4Vca6Tq/EhIRHmwM/lA/6bf9WCKub?=
 =?us-ascii?Q?bHJPSqPrztP14JK7v3p+qMOkCQVMCdb3JKlL//gqKjcsHc1S5YzR8yLIh0Vq?=
 =?us-ascii?Q?MqnpsYWNw8nGEswKiht0VSpNRBz8xcRw6dOeKpJptHV/1OoIZyyGoUY7O1N0?=
 =?us-ascii?Q?EsQ0WjRnpm9EHhQe0kE/cQUxLW/JRAc=3D?=
X-Exchange-RoutingPolicyChecked: NIrlztEU//ROFX7KKfQ6uhbWBcOQfCMWdmsaggkkQ1fFbtSmimSk66Hk2Fd2h5PL5wZpFH8HW7cu2Jux43ebtxC0bZa60WRjU6MUM4wZlKVgbCrIWtKrY+E+fLQokuVLlCSwv4qYnVqds5N/YuoQ8vfKpQbC3t9T0JYe9lSvvnxFD868e7eWMouJYWTmALGZ8Z2cCePPn/kAxNpQcI4hNYxk8NFKFvooE/IKyhQtdyIpWfC3WFo0t/IYXs64jPEP9yHVb3IICZVQjRqO1pRJKCioCizeKQ6uQ4p/8GOTuLpg2HwZvbz7+Vd3yZ8+rqrulsY+Q4uki6DDNFSMa3QZSw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a41863f-c598-4b47-540e-08df34283eea
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 12:45:57.0775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+b5J7xtd9RiVdmASFE20XJ1kkOXVxOf2EI4vBS01p2U3pjQuVNBMz/RNSfR+QmLEImK9bgwqWQhdJQbGWzCTKzJA0QmWmmZuJdtko7ZCdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF57F27BA08
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 12:39:50PM +0000, Bruce Richardson wrote:
> On Tue, Oct 27, 2026 at 10:51:31AM +0000, Anurag Mandal wrote:
> > When ice_init_hw_tbls() fails, ice_dev_init() frees the DDP package
> > copy but leaves hw->pkg_copy and hw->seg pointing into it. Without
> > safe mode, the error path then calls ice_deinit_hw(), which frees
> > the package copy again through ice_free_seg().
> > 
> > Use ice_free_seg(), which also clears these pointers.
> > 
> > Fixes: 9c4f15901ada ("net/ice: free memory with matching allocator")
> > 
> > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

I think this needs a backport, because it also fixes:
Fixes: 7f7cbf80bdb7 ("net/ice: factorize firmware loading")

So will add that and CC stable on apply.

> > ---
> >  drivers/net/intel/ice/ice_ethdev.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> > index b846555b97..dd3a4976ab 100644
> > --- a/drivers/net/intel/ice/ice_ethdev.c
> > +++ b/drivers/net/intel/ice/ice_ethdev.c
> > @@ -2785,7 +2785,7 @@ ice_dev_init(struct rte_eth_dev *dev)
> >  		ret = ice_init_hw_tbls(hw);
> >  		if (ret) {
> >  			PMD_INIT_LOG(ERR, "ice_init_hw_tbls failed: %d", ret);
> > -			ice_free(hw, hw->pkg_copy);
> > +			ice_free_seg(hw);
> >  		}
> >  	}
> >  
> > -- 
> > 2.25.1
> > 
