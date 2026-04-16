Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7702F8A15F
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 11:41:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF20140297;
	Thu, 16 Apr 2026 13:41:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 5632740144
 for <dev@dpdk.org>; Thu, 16 Apr 2026 13:41:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776339710; x=1807875710;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HYhMBfmBTji4tYq1a27sPBk5flQtBf9eqx8zIdGFo1k=;
 b=Cbd2LjirNmw1zB7YxTh0w+ewlBJKWFgyQABUYWWlu7uSQI9JDDSGs6rw
 R5ykOZgq9drx8TqGzdauyXZbF01dbU/882ChU5WLfdVxdXJzT/yTgHVX/
 JKp4mLdHHGPdsH13HGgeyfobNj/MlLAT12KfNKt7rCTiwzsPk+IriyGBI
 FJB/qD3rfPAjZ7K0k0zCDf2/DsAOisp+GbAks6MXh6hbt+cpuGilJ6hmL
 cUZUrPrnErHiVbnDj19r6YWfLeA0vcwvNvFEumJUIlpnFiiLvIN2OrSKa
 6BQGfBGqeDY/3mBLzy43/J6phoAz+dniyWj0EkujXOMfzCeuAhRm4310h A==;
X-CSE-ConnectionGUID: c04yxuHKSfue7PNs+p4NrA==
X-CSE-MsgGUID: HUchcvWGT2yXrRikAf/xPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77210405"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="77210405"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2026 04:41:48 -0700
X-CSE-ConnectionGUID: 2WZVZ6f5Tlanqu1iDcBauw==
X-CSE-MsgGUID: 02eaPwFmRkeVgITkwGU2Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="235672465"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2026 04:41:48 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 04:41:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 04:41:47 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.51) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 04:41:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdF4r/wgVOGyrZ0ydx9neFgn6ZV/re3RgcoDA94KWiyE1ikxYSXwu5LhCbcxzCCSToC9fqMUjx6fOSsiygi/sukgCyARODnFKC7G+YfWQeJDz1mNVapJMjbtPMyJQbejbgjgX0vdxic0voljhP+gBsdazDr0qRrbT/qExXsAmZmv02NIioFZ3XhQnamdjJ8TmRqbegkJdp9qEuU/ggHh4WLGpHu/NKis6BVlikJjUolFzlAomwe8gJP84azyA3l5B2AhHXGJCYABH2OQUbcS63UVqDQgBRui+iQHTv9swYc5c9eEagVzSjOSaB6Yojr4PS2zYtgPpOhVZEx74pwIzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+MWfmRyZNJ+9TAGZLu6j0kotsesxuh99E519tl4yvs=;
 b=XYh3UVdfogehzMRHg9Uqw0VMAFEw2VVFCkS63CxNmabrAAyBp7bXDp96J+MlrpFidQMvEShCOF7wzO4lQaxhdkezq9JvR2zolYHCpVcIIcn0Xao/gXUbdagG/0DUHZRCeVcAaz9+LSsI3t5isNCPBX7CTL4GfFz+g9sO8SJ+xzrJAUhSaOCTyeZQzn4vOjOd+z3iPIELHl7N5S6huMvBGFX0psmu3HHRqOwrqV/QPlFUM4UNXjBJivG2v4qCDcoDr/1pVLRELCBUXppc88NIEKPXNFqVXPq8Tf6U0vI3jd/FKj8+gbaAyZmn4DVZpfV8OXIwIo56di3LHY0hojFljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB5826.namprd11.prod.outlook.com (2603:10b6:806:235::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 11:41:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 11:41:44 +0000
Date: Thu, 16 Apr 2026 12:41:39 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sushmita Hoskeri <sushmita.hoskeri@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <atul.patel@intel.com>
Subject: Re: [PATCH v2] net/cpfl: add LEM block support in CPFL PMD
Message-ID: <aeDK89NfJGTbGi09@bricha3-mobl1.ger.corp.intel.com>
References: <20260217012153.36545-1-sushmita.hoskeri@intel.com>
 <20260409015121.2841143-1-sushmita.hoskeri@intel.com>
 <add11ket672X75wJ@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <add11ket672X75wJ@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU2PR04CA0269.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: fa9897d0-e803-4f81-10e2-08de9bad2231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: s0w/MZT2+tTjb46UT6vDj9FYN46NoUmCBV5xBo3y014Cj7LGsDjY24/GZ6PwiS+EDVeJL3bPZ6KHJ7bYLxG69jiNqsEp/9EuDr52L2nqQ2eA5E6gtITJ/iuWYBnmgcelCCwiZA68EuSnnC6upjvChaGfwG6pt4BGZEyNr5542Ly1s3szkh2TKcj6Pc7unbrXGHNq9AOm1UALMb0CkthOBsQmOsmxfoPF6mHn96heCTGLBHMESZZG3dZTV6IoCgGjXyvZshOJE7Cb4XOotmJ2z3GcUCWfKlSjJZhbXd3cwrJ+QCgv2tAj9wlJ2KxoJe83vNjxu6bfV6peZ6KigTQaJszUt8yymNpEP4ldUWXuHotaArECkKoA2vI5Web4sENNws9eaXjNrU9H6fPrHfOy27TO0UnFSccGOR6B3joZBKyEnnvZ1jVnoULgFGw3W53aAOKuoWxh2yrNh4bcXVxvucC2rqtAkccwJQ4Ysk87VnrG3zlc8Fhn5S9dBlkeYlkAwA9uBc7QRARFHw76A03KZGdKGuMRu8g+T5/EGGYiHQuHH22KMvTKb57ZCIxYD3nHEwcGT8Mdkpq3M1/JyT6IcBJfGxos/jvmeqjWJEKeGikE8LY9hhey3I4nEMWG8uFHLyKAFb/3pqLAn9KDztMpnZnCqfPq4+6YBzsD2giol7KCTtG6Nq9pRNBoLpUKJKr2fJJa3FxnBrDKafUoRoSF4RHIXvfow8mguCrql+oFYwk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c9TaKeZgHO5xJq57ESCeLjmgcPRa6tOZAP228jMWaMq4xzirMIoboY0Hdb8o?=
 =?us-ascii?Q?6qF8DLHQYFqD91OtfkaJbTQYgRmbF0RieXiqdyRWwiIaG3hP4Mxvz2K77dAk?=
 =?us-ascii?Q?vYhb0+Z6xStMesqUmtrVLIYbyjN5YFMGYjucYWABvIsJYXMgmJI1R5Syg5qu?=
 =?us-ascii?Q?G/6+nQFb5hqzMf0+Se51SZD/d/G6Wdie8LGq/+1AkplhyEL3wnhCzV+Dcuwx?=
 =?us-ascii?Q?WYorI1fND5eilK+JHIPO8KGs8nz2/GvoU1Dgpw8yTPBs5zIcrZmtUDF0jUc2?=
 =?us-ascii?Q?czzzyBjIqH27LlxQ+DObZ68H61ciJpyF/YeaJonJwDmRPi56mHIn9/388Dyk?=
 =?us-ascii?Q?hsj2Nq7KXogGOpPLTWTmyyWSds3hwN7PR4sMsLWMlJOszvjrpygQ2mrWDr9U?=
 =?us-ascii?Q?IL/XZYxGncL+XajcJgje8uvOr5XPKtGRqt8fMtxxHhPYc3dtNXqY+wVhVV/c?=
 =?us-ascii?Q?hA2dAaURW/8DvLxddIOnMQMJddAbgS0kUMs4xW042d1wKA368GQJoRZtUAR/?=
 =?us-ascii?Q?yVACBGrXNXoMSFknGEY8bk8Ra1zD4fJYt62UZQB3CVWl0QFkYlH/pLSz3Sq2?=
 =?us-ascii?Q?mrq2sloH0y0R1ad+myFUhu30DBlz7wokmDqDA23/AF7AA9DFtG6ZfQROId2/?=
 =?us-ascii?Q?yZxu0gEnERCVz+n8sD1MLu373NOn4rkEN63TL4LiTLY0GHc4tcN84M9V/UaN?=
 =?us-ascii?Q?f1xysKFawZ7uuI13to9vy4180l6Qu9zs7xGmGLM85KbVNxJbVc3jIvFD+8Kc?=
 =?us-ascii?Q?M3EDUCVNFFUve4Jowk1Pt3o4MQ+avmbatj8FJVqzKE8JMFnB3tiputTndDJK?=
 =?us-ascii?Q?4MR+esM33za5vbU99BU5hORB0yiZGWk/VCzzisXIrFDpZJ04CKEuBsayzVf9?=
 =?us-ascii?Q?vxHbFfK7ztNQRYJ7GdVFNEreX3z7K6Apl1zsnWoiFlQstMTNhLSTm78IuxdY?=
 =?us-ascii?Q?v18/cUqAXu5cR8H7AZkZfWvNcuG66+SXNz/rzFYlMbXu2vsrCmCcfnRG0UlB?=
 =?us-ascii?Q?uKgvGjmnQAYte4rP/xAo3fi0ARxRCrILcX9J62WuDBSrgyWQID6sRMtBCkmY?=
 =?us-ascii?Q?N4YtUUyc71q3NPJZcsmJwwtWBYima2B70XSNVzAjSjeEr29k85uF0odIa0D2?=
 =?us-ascii?Q?pdnrVf3lUaaA9g5c581ZX5swALUXd4m/rTAPQMVZnu1gUJWDJWhfIDWjIYa+?=
 =?us-ascii?Q?NBaxhp3WJFp33PBuy41t+25HCbH9IQc11CHTtdGEkLGgCb+0qllq6OogKYrt?=
 =?us-ascii?Q?cruZ2XJ0Bi+8MDJzM2h2shYRn82leFESRSm8d9Mf860K1C1X4k5/yr9613DZ?=
 =?us-ascii?Q?HAUavRSQQrSj0U3bzqTy0AB7p2iS5sXkukTAz6JkRyi/kJBZ8GFtku4qRs8D?=
 =?us-ascii?Q?aodIy1vUG1X2F/IYbJG4m9FCI0Bs7aU7zDosS5DgJZmoo4p4aJCjXMBYG+bI?=
 =?us-ascii?Q?M7bX53H78CW1OPwKVvUY/IQr/w9DSVbEu8AoXXxImVsMQjwdDPf+nv8F49IW?=
 =?us-ascii?Q?J4MtL9eouUgCasmk0Z8i4dJjTBPlp5jbb5OJrhUJymrnxQ9k1vCo++irbZCA?=
 =?us-ascii?Q?w+gERwJs+OTeE8P/+45I3CWrfCEDt6k4t6YTmRmPz9YTHV1yAQp3H06Zasf0?=
 =?us-ascii?Q?9jTXQBHjISpwDS8Ce5+P8uGCA4x1GkQs3l1QxjmIQ5zayP3TJA1BPlhZHoT8?=
 =?us-ascii?Q?/Aur8qOcOTcxF9hyz1nun9ZIOsYq1pVBLiutHkfi52tcl/A+tXrgvU2+pdwA?=
 =?us-ascii?Q?bkvYyg1D3qHOMd+/Xjn08BTkkfUnfE0=3D?=
X-Exchange-RoutingPolicyChecked: J/fDbOykUzWvE7E28uSj9BiSuWo7oW4aJ1ecT2qi+UaFUWriJdT2ONBK4pExkV1MPwE+BYPgUwUAnJasmhPIekDKx6F1J3qKd2WCTR0vLv38LqXU4xwlQKlFci/xkA8CHkh8lgPRvPUsNnmm/W2oRUiCzNUXKTwdMYxTNpzfp+9K9rioPwcMOQuZmJqGMDXVazHtucPETXOXOK6aM+lxiuiLhvGg3A0rb4+QKEQL6kze6GjsD9jHPZn+jfjWdskI2Kte9UTz/Apzpkbvw+zUQqjHPt6G6N/AQWVil5wUHUHOov+Q3D+9mPnzD8172Pp9sVOP6fK3v1AmhlybSR62ig==
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9897d0-e803-4f81-10e2-08de9bad2231
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 11:41:44.0601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFik8nck/rs9qnyxNcFtt/CAGn4xhyQ2ypd7x/Ql6Ps/jQfuaPJfGp1r4Mkvb+lSwF+YFd/cOyvPJJbCGXIf2bj58CMN0V7jaZ57XX8tH90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5826
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

On Thu, Apr 09, 2026 at 10:48:06AM +0100, Bruce Richardson wrote:
> On Thu, Apr 09, 2026 at 07:21:21AM +0530, Sushmita Hoskeri wrote:
> > Added APIs to enable support for LEM (Large Exact Match) block
> > in CPFL PMD
> > 
> > Signed-off-by: Sushmita Hoskeri <sushmita.hoskeri@intel.com>
> > Signed-off-by: Atul Patel <atul.patel@intel.com>
> > ---
> > v2:
> > - Expanded the LEM acronym in the commit message
> > - Removed code that wasn't directly related to LEM block
> > - Removed extra blank line
> > 
> >  drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c | 10 +++
> >  drivers/net/intel/cpfl/cpfl_flow_parser.c     | 84 +++++++++++++++++++
> >  drivers/net/intel/cpfl/cpfl_flow_parser.h     | 18 ++++
> >  drivers/net/intel/cpfl/cpfl_fxp_rule.c        | 10 ++-
> >  drivers/net/intel/cpfl/cpfl_fxp_rule.h        | 10 +++
> >  drivers/net/intel/cpfl/cpfl_rules.c           | 36 ++++++++
> >  drivers/net/intel/cpfl/cpfl_rules.h           | 46 +++++++++-
> >  7 files changed, 212 insertions(+), 2 deletions(-)
> > 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel

Thanks,
/Bruce
