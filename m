Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2109C61DD6
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 10:51:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B218742EDC;
	Fri,  4 Sep 2026 12:51:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 1AF0D427C6
 for <dev@dpdk.org>; Fri,  4 Sep 2026 12:51:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788519097; x=1820055097;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=86b2NEfdScHxyef3GzgkUcJpl2Nfujrvsh2Yi2FbVJQ=;
 b=Z/mLDwk95NYjHvo8XPpDDxmTM+kTtVnpwLepf0seZ3y7jzpxKwOpSGsS
 B8YQ8tpaPjrWzPpX8x1kvbeMNIuoPnS0qpCmACXNO4wJfKBnR9L/nX5Vh
 a3SVV8EVl/J2NZATzI0oVkScQ79LwWUt++SW+SuXJ0Hp8RXrQ1HFjeoD7
 sWHmdH7M3xeJtP3SansIjx2NevOwvip74a/Px37due/2wxg8EsW6F1NTr
 8vjyueOpghMkhKsfhZp52l0OOFFGcGI5UkHi1IHV4lOLbVWoa2b8JIRW9
 jIPzBDUbXiY8R51ETTrGiQRzxSGa9O/AB2duTlyTws6BU9zqAY8GFrapl w==;
X-CSE-ConnectionGUID: vt3mBZuyQtiRAWq6S8J1nw==
X-CSE-MsgGUID: LhnuUfX/SpiMLNKzyjBL5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="89072936"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="89072936"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 03:51:36 -0700
X-CSE-ConnectionGUID: 8NN9gPK7S16DwVCtCaef9g==
X-CSE-MsgGUID: 7rKQpAW0TYqNLi9ec3Nz/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="273797984"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 03:51:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 03:51:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 03:51:35 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 03:51:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QD3QSY3cDDQaY+zjjf0EYFLh/tqwz4yz4BibmiUveVsnpGxjEySb22ZU25EFVjH//D5uNB+6RzU0eU9o5N2bmeWF7LKP+/YlApwc8KQziMmiK/ETushjIeu3ca7hyKC0hLQwu3Ooh0JPgv5JEET8VwrEpLF1NM7C85u0oWY98qkvQN7Md+mFnJAA3yOXmBOGFYs2bKat4eVr4FxlrrZJ/yQP0XM99M0dDS4Hreh/5Q3ZepYVPCqIixtkRnPQgEAE5MRstwZHWyxyBNSMESLGAlmx3vt+aeAYXvqhrAxqbKpmZR/1tkqTLJu2c/aExCjMn0XdCSumjLdBFXtAI7GnKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nHqxnSUbjVqcmNf1TKZoU653B6YFXL8n48HGFfZApc=;
 b=DjO894HwWxFxHyqt7s4fIGLOoPETRrC5Du5KllYB8q6tnhfYFEnu8ZuXa1wkFcxlAefhOY1mCR5I0Gs9SB1x7d8whLYJqIDHrS3/yZA1wDmomqhnlAS2LolTotMFlx3QoRXwnMp3xr3vfWsjyZiWfd09QWWVVdx3e6lPW6JVjxU/Eg2dnjbRM+8dg1ahweEKiwtJyHIwOXmkFd6czZAodazcwkkrRtBtz44qwXNL2Lu9wh0VZkUhX582IF97FQjkHFJNE+lYrk3bhJula+rcJS06mkSPsOqZPNIC52tqg9ON9Fhe/rr+Yn0A4y1MXStdxDtM7qjudN1GGCvt4loRiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SA3PR11MB890013.namprd11.prod.outlook.com (2603:10b6:806:592::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 4 Sep
 2026 10:51:32 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 10:51:32 +0000
Date: Fri, 4 Sep 2026 11:51:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] doc: fix typo in Intel VF guide
Message-ID: <apqisKBSH4842gvn@bricha3-mobl1.ger.corp.intel.com>
References: <20260903174019.120287-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260903174019.120287-1-anurag.mandal@intel.com>
X-ClientProxiedBy: DUZP191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::14) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SA3PR11MB890013:EE_
X-MS-Office365-Filtering-Correlation-Id: b180b218-b0c8-4733-f586-08df0a727b86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jxcExgR+6trM/5wW+n2hr7pqaglAwCUE8nptE51DCGo6ElIFEkET2TpR6Vp6j/UWtgxRA5bSi8jUW7Csg9a/9Se9MOJdmDzTiQfTFUlgnB/8gc1V+A4iJ4v7lukbjZP4zG6DDYCPQJ3hlzzOSWhBAKDffo+Zs97RVTMDeqkfX0cHYY0RBAeZBqL++xaY6cRoWNtgY+QXFPtIue4WtBU3XtneZKXQBtY0nTjcpmXEjJROKST1IC8ow1TkbgSUVj5lzTYLOJ/RZosf8I4HYaKbtdLHVRnjPTp/cb8tSR51aNnAKZXd8nfCHSC269oVdeM1V8KbNcnbP7fepcXAVd74eoSRIc2NYiG0AEzhu1gKw86VKnEMGyj88yRNGiMyEjZ/KJeVLBz+/5Qvt9oteF44pdX208hFc0RkTGR6TlVL0jI5hC3pLAd+N6aiTIWiBUBqZ7vMvaHqhepRgX0ntGm7+nFlkSV/2Z1+zRqK+xQIYgwNBr3YTg/cK/HdrF7V/qQIh46m6NrZHW9xfQ5LD5l788+m4g3OJ2L0lnwJzTRuc1w0d6kHYAI+OYwC2j2l69h/lPmEK0m9+DF0oU97HXqDMsVZjzzIXgdhFSYD0avqPMo09eI1L1P0YhoxdyAfGVwgGsvVoK/tOVrVVNLJvWh45gQ8LV3VEpbbqxl7e1Ikrss=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zF1ivwlZt1y8p4l4nNxPaxoK0t0yvuTnlMflX+E/0Mg5+OvG4pwBz8lxcz8W?=
 =?us-ascii?Q?SDbdeC9NjEOlOEgwRgiEkxZOd7qe8/CF/e/kCWIIqIn3TMqqjbTeg0Ldet5y?=
 =?us-ascii?Q?AdRkyOENyTl3drvay8lNBH61BSaobEPkkl1hNzAdaB05z4mwRk5sV+b6VqsL?=
 =?us-ascii?Q?a0zxve7C0/NeBiDaKUh0FsJHHZ008jhneEvahqIt8tzR6DIi+sUFNmnTp+Wr?=
 =?us-ascii?Q?fI5aMTIYdZe5ueqsP1xmJhKHk2EYGkSjc9ugWYc3uJoV3J9PPcm18UmunCLo?=
 =?us-ascii?Q?8t+FO66mlyhshl1BMFMtJ/H/NY5tW2jFExBup8+NAYO74h55KCUXE++qGcXh?=
 =?us-ascii?Q?gULaCltcDihpJgLcsTbyC7z0I80lL5A1YyNBurIWGCrjy5a6CLFt5U62iFew?=
 =?us-ascii?Q?FgJqgsLxIgp/XsZ3LCY24lvkk4nVsA3DRlKmjk7FFx2nbjju1k/8ZG78DC6n?=
 =?us-ascii?Q?srQJmndqIAbEFHnnaLmLzXgHVG/6kIQeYAS5EcsavP+NuIf4OYZBp7VcZ7h3?=
 =?us-ascii?Q?S4Itu6K0Iy/KQqQgiBbinFHeSPrFOK1mlj+eqcprNCbJjSzkbf5a7FUDwL9Y?=
 =?us-ascii?Q?7xFGckeNjXOFLNY0tmlW1KpX40whVAGIs/YVJTNvKfwcb5Tlu12M/THYHvdf?=
 =?us-ascii?Q?uP7jRbOqVNonm5qMyVySvUiGbCKw4J0N4CLr7jlIvXFX49F6i6nmsuUnQz8C?=
 =?us-ascii?Q?SRt9u+uBT3ut99FKI3WNXcO1stw+UIxfGAIpdG3dwPYVqXqsvqAIYaFDVOs2?=
 =?us-ascii?Q?hTlWe5rUdWobLwzFsJnuyojScXWUyBGSct01YJPBY96UmLtV5EH5Aqn8lSQg?=
 =?us-ascii?Q?9Chx9uACk9KV8xKPVgpjKkyvKinDhhhE7Dyzr5Ugu19eSBjYAPcF23b7SMhd?=
 =?us-ascii?Q?xC1Ej5+FAccPRJ+AMdEqYp1DW4D+60WSNleKqb0TbkqRtJkr1BeQBVWqBoSA?=
 =?us-ascii?Q?WJLUW9cVoCjEjeSHDAZ/aU4XC0UtMP0HF+M+09KCLFwf9McfsHwjeB+l9Rk7?=
 =?us-ascii?Q?nNlcqSSGxX9szgrcy6vZfC+MsmZ48gEcJvtSo/bQvSKblv6XwABTgm7vH9EK?=
 =?us-ascii?Q?MX2bNf/kHIvOHRRMymIYwDj8IsyyBM8DF2FKtHbxW1JumrMeNf+jK5YLq+7b?=
 =?us-ascii?Q?gDWFArXbTn4IVzJjUHa+6ZwGp2JlbZzhNkCHhlq/EmVt1mT+nW9GiXNUWmy+?=
 =?us-ascii?Q?U6ztBqTI4u1xZXZYi7+cDBs2/w64VMg8TZ93cz4lPWGoXO6IZNruFvmd9z6O?=
 =?us-ascii?Q?oj6TMBxz3+y2615SO4FF0NYQD+cQgm88QJeXEb0nMeHr4amlh0Zu+hbJ9AlV?=
 =?us-ascii?Q?Q5ztkQoU2xKHW7TFW+1xqVnGM84tzkzZop1fNBn6Zah2lzXg3LL0fmBEI3Lg?=
 =?us-ascii?Q?y6ByTi0B5qwCHltVza0bcRcJC2XTIHiWM5m9zDXq4We11kpL+3/MT796H1jV?=
 =?us-ascii?Q?/rmTA3nyGe2Q8lyBFuJzJ3w+Dg57Qq6xHYGzHC4PMSe5cAelG9UUAdZxP/tY?=
 =?us-ascii?Q?kNpbPuOdwsjTISDpPtCj2pkd66mPRLL6nCh+1J23mSga9rCuvX+NAB+BTvyi?=
 =?us-ascii?Q?wjyvbOe+EGj7Wke1CjDSrD6mWv9pddRjEiM0tAq0qeZrmjsim0jPkRXmhSra?=
 =?us-ascii?Q?cOOHKudo1QnBAkvU76l7kCBU3ZHWq1j0i+v4lbpWDaMCK3LfN/1ZgvpbSTA7?=
 =?us-ascii?Q?xDMc+jM2DsFFxvJQSM+c7Es+BtUw/OMxUr2KkosW13AB1bzAhL3EVh3RN3xy?=
 =?us-ascii?Q?6lwouhcpqgxDmkDarZdXQkssY3tExTE=3D?=
X-Exchange-RoutingPolicyChecked: oe9RBUhC5weekVH4J7aYCLyhejMgC75ZaJtUNo1wR9s/DgxL8K8oDXEG0B07ypnUDJtLwLZmNTeJZTFDBmI3kKvJCXytD7RrKIqYE0R6gmssOr6D8EzLFhbriEswDp91bm4OcYNPD9evTU36gqxB+2qwv/BOHZM0tSLrPWqXTlNxSarfXR+FNq3E1qpjc8trmuMWsEd0oFmmDsIS3hAmNwf8XQ1kBy6THL9GIPZ1s8cbam07Imd7q/mYXNucW6FkrB/w7DVerC7IOD7sEy0l8XbCrmXTLD7T/xyw0oMzf/ODuy7P5n0PK237Tguxdt/8pwj12TDWO3tWKkZxeEBjjQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b180b218-b0c8-4733-f586-08df0a727b86
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 10:51:32.6576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZCgb5emARLbHkZBhcY9ZLAi2hOOBwvUFRX3XtUbWi3q2AU5aottPTMqWY6u8GKwMDXK8EFYPrt/TWZCElfqL2g7TuKFaQ0ogOE7RuTvEiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB890013
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

On Thu, Sep 03, 2026 at 05:40:19PM +0000, Anurag Mandal wrote:
> Fix "Knowing issues" typo, should be "Known issues".
> 

    Fixes: cd5caad30876 ("doc: refine iavf limitation or known issues")
    Cc: stable@dpdk.org

> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  doc/guides/nics/intel_vf.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
> index 40a1dfc851..5f50694337 100644
> --- a/doc/guides/nics/intel_vf.rst
> +++ b/doc/guides/nics/intel_vf.rst
> @@ -700,7 +700,7 @@ will cause such packets to be transmitted::
>     The old name is no longer accepted.
>  
>  
> -Limitations or Knowing issues
> +Limitations or Known issues
>  -----------------------------

Need to also adjust the length of the underline, because the new header is
shorter.

Fixing that minor issue on apply.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Fix applied to dpdk-next-net-intel.
Thanks,
/Bruce

