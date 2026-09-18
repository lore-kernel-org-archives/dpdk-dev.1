Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AAAC982D9
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 11:03:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA3D54027C;
	Fri, 18 Sep 2026 13:03:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
 by mails.dpdk.org (Postfix) with ESMTP id 594C740276
 for <dev@dpdk.org>; Fri, 18 Sep 2026 13:03:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789729397; x=1821265397;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=UJCNj6UvVH+28GHG7eUmf6mEGIu0WRPXSGxxs00IYhs=;
 b=dEwaJYvgEGpjML+r7YodzYt95Dd9pXM0NxomW1kMEcU/7KTg8tIuu12G
 mKUzlP9NoiUSAlhwc1lw1dyEKPA9MGhoF/FvnihhlxVZMEGuUMVjAlx4V
 2W78kfWN0v/Uoq86SuUckINqLrySH6gIPBNOicF5maW20c2jlBdxW/gTi
 C3iKLuvuS7x5JcPRUI9RKq+m5RSWz73vt1IdbVMxRxIeJsRkCZ1+hGr46
 n4p7HMch3UC0vBTYnO8bDzCNhT4a21f/B4An+R3d4qoAebpGbOsQNcoPj
 UPnmhBEDrxVYGdPpILDqEmYB2k7NE9jBpygHoxJ6P3cS9twljK95EqXVS A==;
X-CSE-ConnectionGUID: fJE93WznSFSzSsrAz8J4eA==
X-CSE-MsgGUID: uWPPDirqQtKqRehlamqHPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="743649"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="743649"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 04:03:15 -0700
X-CSE-ConnectionGUID: OfCVP56RTeK2PzU+uwOSpA==
X-CSE-MsgGUID: dyOFu1iiTZGrAKn/MumUNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="268090390"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 04:03:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 04:03:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 04:03:14 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.12) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 04:03:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/1mv4yZq0ggOY9HTBWtPxsIRBoJoAy+n8wn54hlbyR5NddSXdMh2EvQOfzt905OccpqAjT9nwr+rdnr5UgKcGLlZwFKdiJCCUARP3PvOGhjMH3s+8w6EGzarsXo/2HQjZoL3ZpDJwExqxjJoGJpbNU/os7KD02v/JiJufySWWqi5ZzpaOUN/zkt9V+p28qmCuGbcC098GAmFpcVI9mr9ka9ALlgQz2sVf141Q9RvSfhmgw+XB8jdYoUWnMYLLStDL3W9erEV7Y05MTuL0RJMP0VoQT5Hi96OrUJnmYy44ASovq9I1Nm9jk/xcS1QnHvgn561RDp8JEJvwgtcdWsFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76C8ySzTKMovv8DnSkJN/FMYyqsqKQS2TUBKkL/xuzE=;
 b=OZZnfPlEkLBnw87IeoeLkd2JIiIQQ0zhTdtTAt8ereE9GFrcDYXOZ9yC9HXxJcB3MBSjllWVsT1O4GYPnxzgs3AWwv/3z+AgrWtIwxcUQ0pqW9FRgeQKmujXn4oebFjk59IszjiPhZVu6925T0+NBwUHCgN88zRPOywcRsHq3e9LED9NZnrwEKKJrmu9to7eUFaJuxL1GMWurXRLU51cMBGVmtUuYlziKdJfRVDxZDOmXE2weIu7IJOaXXJkysQVKq5lM+sV9Xs2W1QwuQPaLs6x882QS5sjq5GNwUm1HyTeLdEAxsjhrJa4sxzsusK9+eyAye4/kKCVEJlkgzgHPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by MN2PR11MB4567.namprd11.prod.outlook.com (2603:10b6:208:26d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.14; Fri, 18 Sep
 2026 11:03:05 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 11:03:05 +0000
Date: Fri, 18 Sep 2026 12:02:59 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Hailin Xu <hailinx.xu@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1] nics: add E2200 to the NIC guide
Message-ID: <aq0aYyj9MWOnkdnW@bricha3-mobl1.ger.corp.intel.com>
References: <20260812020907.148153-1-hailinx.xu@intel.com>
 <an766BU0CW0bKY7t@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <an766BU0CW0bKY7t@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DB9PR01CA0001.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::6) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|MN2PR11MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: 7178a90f-b08e-4b9f-620f-08df157469cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 254K4TFmY6UPD9fGE12wofDeuCjMYsVLJOOB2TtZWWINVQTDz6h0dD18DWrHCYovUklawyodSeJ+aJ5mcimmDbmMDkbAZHQZf5HFQ5fCB73bUUNwDUKc1BJezv7YX3qb+w8of3ipZAcFIiOVZbYZYSosdS1orAMyzBrC/Yo+B2CS5ZAmYZ/o2S0+v7ZL4sdeHOM6yYFzEwyu/TOG3ufNmyrcODQDs3GIVN/Mx25KozWuuveomck2wpiwOrZ3UAe0Areb2/b362tHvrKPSA5XUsvsT7xfhK/CGMvzlt6G1V+/NhwiIXFQ4e7diT+SUInTrcKbID3ZeuBKz7mvGbQkDdnBWmN79xbjg2Gq+UILoAg7oKiGqwO0A+2YLnK/O/k+QqKyJNXCMPRnequhQEAMGmD1ZuA8wJcbhVdyRcZl80eZMUbCa6TVl9nSaZttfEzgABCWEJQQwnmKtkCUD2l8KDKodvCn5w7bPJZW06nEmC6iyWC7sBblTRkxgseJW49Vb+IwZEw7YiExm8+0u7pAMQeyLGgfxHqCJdVcBGEFBXpq4eojWpj1inpsD4eA8V8DSxKacx7VbSkrb8dWnxHy8lKNFVTdsUk8lFfzDjCgaLE93w5iWVn7OREn5VTl/T3pjukrNyTlg6AewW0bmhFLH8aWicFd/klK0e/Wg68jbts=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sUI1h0xf5hHN7/lcWY6UlxiFLMNAijB5f8BNjK5fynHpyvRwV6WcCMjha4h7?=
 =?us-ascii?Q?Yjpfuw9CYOUigT12by86GDBba/C4wbB1Ug1YJZGFgN+7aNUBL1Y+A8z3yAZl?=
 =?us-ascii?Q?A4JThly9d88S1yxiNhAT4LDCJ7Y/EG3qo3sNn90QdVjNj26yqbFruXJxFlLt?=
 =?us-ascii?Q?pqtfbZnTchdmagjgYlEPw6p2h4qo15XgzguJSiO+Mapvo/jwi57lKQn4YG7i?=
 =?us-ascii?Q?HBB4FtDCiM6FybBgkqVOqfdXswbXOuaPVDHUgN+vdLPq8npFRT0laBNVCCvD?=
 =?us-ascii?Q?UjwOKGNSF6RC8mqTsgg0TvATFAU0dqFnbCHKMdVMO1ijlBlTXk2rZX8G0woe?=
 =?us-ascii?Q?3B2LVQRFSfs773hud1tYUJdByJhJgCHZqnT+qLfG0MVbqF1dAddcoiQlOLVk?=
 =?us-ascii?Q?ufdaJR59ggtKR6AgATapY3T90A53AUqi4Qbez63qrN3jkH9k9rG1SJOapeto?=
 =?us-ascii?Q?y0Xdpt1vl5bsK7SGh7fZnQrtgI+763s75pSPLXHObqmePt1dTn+d6U2WTQCn?=
 =?us-ascii?Q?Dg5LSMdZwdFQhYJsRj32HTbVHZASGWtEVLZHwQ1IoV1fXqCQUucScWeutboM?=
 =?us-ascii?Q?L81LLyGVS1y7TFEiMN3Dw2qGbMYOM7xn49j3r3ioASXrWS6TvTVYio3HCs0r?=
 =?us-ascii?Q?u2byZnlHEvGjwx40TNAULDL2vIUjujkrgXYonIACfQiR/lTv0/U1nfqqDq/a?=
 =?us-ascii?Q?d7oL56LUWx9E3MpRj4cswdsHMw7Jp0geB8dFKoU1NJny9POI10H8g4rX0zgZ?=
 =?us-ascii?Q?nh6mM6PjXPSC2KeQgjHzcYj0BfOlTNkZVu3H/YjTEVlcm780LiVpbpJQcmmr?=
 =?us-ascii?Q?VZQbabFAZLU+H/PNmAvl1mRD9oHMNvxtId8GUQaTHAWtAeokSCbFPyzcDkwr?=
 =?us-ascii?Q?5yVmkSy4KyrPqOLZrBq9g/D5Rx1az4sqoXxvMNBXUvtBcyNWD4uA71avNARX?=
 =?us-ascii?Q?SEJPWWkYkRpq1SfhZ8jI/HQvbamFoHZUHxfC2gvGGwe/2i2C7G66EB1JT2Xk?=
 =?us-ascii?Q?Ms65RA5XQoEtvFlrzLXzFYEho83mzKmu9N54o9CgZFFjx2iVJuZ449Mi5S8p?=
 =?us-ascii?Q?riOybpKpuHLrs4/po+uOkfko4GZp32XYIVrQEyc+5sl8ejutlF49X5v4vUnd?=
 =?us-ascii?Q?RugZYsm+XN6Zw2FC+CyQlh3gfoHL8+S9+5L7L6dEuKZtUz2DR4bg5y/Or0NU?=
 =?us-ascii?Q?dBXeeA87tyvMaiaUbekt7IZKSjygSAWMZXC7/cwpInnl2UHyhZYNfIH6mSrR?=
 =?us-ascii?Q?eoOI8yNCLTSrXausg6MNBm1SEtnqHH2KH9e2zXKAOuqyDH908NRuZ/T4XG3n?=
 =?us-ascii?Q?AOG8/b3d4OJ//I4z8r1guww9GOGae7GyOIx2QLHmR39mqvXZ6EPu0HYQmwlA?=
 =?us-ascii?Q?ns/rvEee3wTxkOsoW2AvfGVmZdqj6sLGLSwl0spjCFCpuvuPrXK+3IhD2bUn?=
 =?us-ascii?Q?LlCDtthMOPfayX2kbMs3km32zQpk3vaH8L1re/ShHvVlZDvweOvZoaTMCIhJ?=
 =?us-ascii?Q?LOTEk7ytAEJ8I84rQmzYrAsMaC/WRnzC2xymc1uIxt2fDCgyy50Oam1BEpJb?=
 =?us-ascii?Q?D+mSvv33UN44UeQyNAhJ7xiAyOviM0JhqdFEbeL7hSHFca3S99j/4Ro3h6KB?=
 =?us-ascii?Q?YJimwGVYaV1UHijE2XVDO8esWjGK/sKYJNvqKqK3E5hlGbLiKP9sYX947Kfd?=
 =?us-ascii?Q?AeK6SpjL583e3rciGU2SqadPI9GmVVNUP0XN82mrT9qTbHQNSYhEmzy6f11J?=
 =?us-ascii?Q?juhZcJSGdIoLWFydkAXV5I/toFWBqGk=3D?=
X-Exchange-RoutingPolicyChecked: jZZCfXf+R3iK9t7YKVSaBHzsKswdKeM3plpIc3BxNZYCwj2mF0RBQrtafOrUp/Q1da1npclXvG2Q+1+zR87uJ7RToeMaZaYysALkNZQglfecRY7e8ck/W+11bdXsCXQea0Is8Rev/BPbpdl7tnPgo7Pj6HVwxUe5yW3ngpJ66Tdyo7gg+/3mcUV4/YEdbzYOB4Pvh6XiFnu0anDYaofKrf+uVc+IyYOC/96/HdydpKS4qYhb9tLKfX4igtjsJuqcs9xyOx1+/XX2m+aZTn0VkSTyzk4zVwL1LWLVHftfEdg5K/h74GJV3tBLt6IxjcQV/dFOW5Q4ctOPjatxh1JnAA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7178a90f-b08e-4b9f-620f-08df157469cb
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 11:03:04.8960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMol5J8mQf2iV2CH4pkjN/f8XlhLGiEHwYUByw9dEzqn7PzwqTEMEhMBoZlYxUfXSHhBOOwpw0wLWIWY3oJ77BaeIe+JXY69jMWVQMPsIOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4567
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

On Fri, Aug 14, 2026 at 12:24:24PM +0100, Bruce Richardson wrote:
> On Wed, Aug 12, 2026 at 10:09:07AM +0800, Hailin Xu wrote:
> > nics/cpfl: add E2200 to cpfi nics/idpf: add E2200 to idpf
> > 
> 
> Needs a proper text description. The commit title probably should start
> with "doc" or "doc/nics" rather than just "doc".
> 
> > Signed-off-by: Hailin Xu <hailinx.xu@intel.com> ---
> > doc/guides/nics/cpfl.rst | 1 + doc/guides/nics/idpf.rst | 2 +- 2 files
> > changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/doc/guides/nics/cpfl.rst b/doc/guides/nics/cpfl.rst index
> > 3e2788ba03..5964a980ee 100644 --- a/doc/guides/nics/cpfl.rst +++
> > b/doc/guides/nics/cpfl.rst @@ -8,6 +8,7 @@ CPFL Poll Mode Driver
> >  
> >  The cpfl PMD (**librte_net_cpfl**) provides poll mode driver support
> >  for Intel\ |reg| Infrastructure Processing Unit (Intel\ |reg| IPU)
> >  E2100.  +Intel\ |reg| Infrastructure Processing Unit (Intel\ |reg|
> >  IPU) E2200.
> 
> Since this is not a bulleted list or similar, best to add an "and" in
> between the two NIC names.
> 
> >  Please refer to
> >  https://www.intel.com/content/www/us/en/products/network-io/infrastructure-processing-units/asic/e2000-asic.html
> >  for more information.  diff --git a/doc/guides/nics/idpf.rst
> >  b/doc/guides/nics/idpf.rst index f4cd69ba7d..1f06eed645 100644 ---
> >  a/doc/guides/nics/idpf.rst +++ b/doc/guides/nics/idpf.rst @@ -8,7 +8,7
> >  @@ IDPF Poll Mode Driver
> >  
> >  The idpf PMD (**librte_net_idpf**) provides poll mode driver support
> >  for Intel\ |reg| Infrastructure Processing Unit (Intel\ |reg| IPU)
> >  E2100.  - +Intel\ |reg| Infrastructure Processing Unit (Intel\ |reg|
> >  IPU) E2200.
> >  
> 
> Similarly here. However, I think in this case you probably want to keep
> the two blank lines at end of the section i.e. just adding a new line
> rather than replacing a blank line with the new text.
> 
> >  Linux Prerequisites ------------------- -- 2.34.1
> > 
Rather than waiting further for a v2, I've made the necessary changes on
apply and added my own signoff (in addition to original author) to this
patch too.

Patch now applied to dpdk-next-net-intel.

Thanks,
/Bruce
