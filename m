Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DB2109318E
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 08:33:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A93C1402B2;
	Fri, 20 Mar 2026 09:33:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 6865440272
 for <dev@dpdk.org>; Fri, 20 Mar 2026 09:33:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773995629; x=1805531629;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=1WZ4+zetHA+bQOUolmbJNyQWREzPrdyS78Ad8ylR7a4=;
 b=niYrqKTLq7ItLDNSa5vI2sTkwKEloW7vzaycUmB0QhzDCEHTJn3q9VBn
 OrZH+BlPenLTr3aB82kt1ogeVQ804EQ+x+4alO2VTSc6uPSWGsSv4T7/Z
 N6E8Zz7kAvX0oiZhZ3N1DO7jF3Ov1Qf1LRFWbTnuBks+JOXlMHghgIt24
 RrLwU5+RZY1ObLy+vRGGX0IDh9R5HyixzgcRL33AATEV/ZkTUwhg+gjt+
 lThenVM04wqsiFJ9gdDXEC+55U/NllyFpLelmHgzi6FdjpSQX2GDJrmcy
 XFWxbwEG+wGDK9RGwzFce9x+racDb5fGk6ZOBOQzNRHmfQDu3IF5IeCuu g==;
X-CSE-ConnectionGUID: fV3gI3dTQfqqkcVCoF5epA==
X-CSE-MsgGUID: Kz+g21d4RBON2pxe/aMs8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="75110804"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="75110804"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 01:33:48 -0700
X-CSE-ConnectionGUID: apx80bzESViaKF08ct3nxQ==
X-CSE-MsgGUID: vF1wk5MOQ62sUCrDFsuyAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="227698128"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 01:33:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 01:33:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 01:33:47 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.3) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 01:33:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwNgqJAszxakN2j8NjNgg3ZBmVULxiiLKkq+PodPSTS70MsRqDAjLW9a9zx5MuRe7qn04UqPlq1jcP04BmX3TzqWLG0nOAYzjv2W2wOKQSOUMWtcTAgvEKJd+mLv1PNn0EaUDbWlu58itm/9W5IOved64WG81YheXqPZdtmhz1C1TxKAwmEyztFRWDRabNpGi6+leSuplEjSxPcH5luT/UTpKp9eAK37GzHQMGkbr3pE6pAZ0YVMQ4lzwKXrTRhBNCE66EQ5DyDZ+nZXCMxI3EGtm2dCuPE/mc77b+Tq2bkgROrIlxEG3tqdMcJxPFUuRLVJg3fkIbTHiA7Kd0cu7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFMOkn/LDmyGvN1X0kfT0ywwtdqtnqNcZU3TQ5a//qU=;
 b=Dux4C+QoyNv31qTT6ABDP/2eeVNflHiQ/QYFc6Z1gOzJZLJuEPwBcnnz4RYgz/N1g77MTPO46arHTDaRYhD0xy8WR3P01uLW+HY0TaIz3pTKDg31/rCE6I3YpFD1xG+9QC4umCfnt3+emovaYRY8rtqwIKA0VGAmXV4dsjR5surllK7lUB4AcSen+SwTbhYqsANLgf9XsVGJyzpMIcOg7qeRyLPMBOtdLNfp5uzG51UW47a5gJxgHCBzSi7gG40e+WhgP4SDGyJzRtv/1w+3NvwyJV8vSglbV5Dj3f3q9aAYq7QmR0oVVPM2Q7Iq3qYfYGdchrtdVMjZrFNTgEzx1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB5118.namprd11.prod.outlook.com (2603:10b6:a03:2dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Fri, 20 Mar
 2026 08:33:46 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9745.012; Fri, 20 Mar 2026
 08:33:45 +0000
Date: Fri, 20 Mar 2026 08:33:40 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Patrick Robb <probb@iol.unh.edu>
CC: <dev@dpdk.org>, <lylavoie@iol.unh.edu>, <david.marchand@redhat.com>
Subject: Re: [PATCH 0/7] Get fast-test suite to run on FreeBSD
Message-ID: <ab0GZOUx0kQ24V3Q@bricha3-mobl1.ger.corp.intel.com>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
 <CAJvnSUDr8oiCEKX_=Q6unP1QSsYQngQU5A4NGJ4k08ZdrSDrcQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJvnSUDr8oiCEKX_=Q6unP1QSsYQngQU5A4NGJ4k08ZdrSDrcQ@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0126.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::20) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB5118:EE_
X-MS-Office365-Filtering-Correlation-Id: de9dd375-ffac-4826-1e90-08de865b666f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: Hhpxk+EOlFF+f0YnMZlfmXUk7cUkVHjc3/au5R11xTsVMTe8/CfbF43yqAMAJ18BmpUomen4ZW8Bviu76fZE6b9r37eeda7axmtQf5X9WEDm7c4F+IQOq9/1SC55XVbeoIHjZBI7Vm7kByKQcyTOs1iSRFMafHWLsaL5RC+WRby92Xs+IW9PgksTcvCew/tJ2X05HqeYflLtIP07+dbe2vk6BFNkjWKK0ogxM2TCe8gyLJsF7iEW22UBx917DWFE8nnwKqpY0WoG7lgzKcFoRvcSiL/CLu5LylpDSGzMzO4TcliawW7ZJRPvWMfq6bnCgWzUvItBeEAxzloRt0MuGHWRNiMtYvUCDpdo9eMdU1/j1XkTLGGSAHgZrcvFdrI59YwwSfIo5xUZYRukbptqdSzPETO/md6LjzQ+ADvImrquOA1bbKZYW0zSYGiyxRlfhz3BfcIDWTypR+0d6uOgwcAitBYYDInyB02DZ63l933so8CnOL78xza1R8HFE9SH6+GV+g/Zj+1TnfNde4QDoByZ4OtUTmbhakNZOYYTL8J07PgSC8VjSvd4+IpQrmAi+5IAHOtMD8w3itNf2NYOb9fQgCtT2sBROwdAdV3TNl37oYX5nS42i3+G6Kyn9RnSJEs+U8qz00xK4CXcFrQRgyWJOKrhkRUG7/kYAMZ4t3GY8GpOxa5VyxJ85vWAMtY8r5wqm7Px3UBmwLU+0fdpZ7JON5vy8rHIdXvThkJihgU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r8YWXCSNspI5fsWnYgd7BeNXAJkcn/UrF+0sxcToUFIm1EGQ/wlynImJ1wgz?=
 =?us-ascii?Q?JlJf+QH+cUMXZUu/mW52HyfZ3mWkT6g5atEe5mQrSa5v5BpjSPJ4RHYBfhMT?=
 =?us-ascii?Q?nGlQes9EfTkd8fMkS85Ba6FO8Trh7UeOa0WJHOra4ifBU/JeUTwbZ7j/YVOT?=
 =?us-ascii?Q?TLQc5ZLgIrfrJlKzeUd4PiJ4vZSR5HOFRCKIdmWz+54JRnDLvwxLagXQkOWi?=
 =?us-ascii?Q?TDdzxeEOfJitmFNd2Pn/e/w6PRtZnfEBNHCFZoFLF5vk8V00HUaeQAQMv+d/?=
 =?us-ascii?Q?ldbHgBf5KFy2QtsBqw7RgK15EaS9hyrBkY1MfW9sgjMpbN83022VSwsEsMif?=
 =?us-ascii?Q?+YbpTB/6l9/iQ/JuzmqQlUet/03cHFuLFOU9yEbaYNckQLVaYcybsszACtn1?=
 =?us-ascii?Q?NJTLFxDidLEDWkchXgUBwyL53WmXPmHcamv4feKXgCKQo+fi6ykuOXIyN8SY?=
 =?us-ascii?Q?j32aRtCk+aGQmUGGQWvU/GCin/pKtBLqX72z9VO/L5MwCnaVb/qUkO8FiDbu?=
 =?us-ascii?Q?d6QPcmdwmJVLzCRTJuU9R5pTnkbiqiOGzqYmK3QevXM4QKqLt3Yh+AG8zuW2?=
 =?us-ascii?Q?49MVmnesUTNJVejQKxStytOHILzAiDqLtwIrxzbNFJDFgRCTj+k8W7Ou58am?=
 =?us-ascii?Q?bjHbcw8qnErejt2QZ5SJ1e+FfV6VZMztj5yL9tazobM0nSG4U57LtmK4btLs?=
 =?us-ascii?Q?xDIdWgbvg97hso4GdBYE5b4XegQ/kRKMcChEiiGLrFywnibiVGpsVZVCaBlf?=
 =?us-ascii?Q?hvwG43l1PTEVVKLIb7T+R8/4ietE7jMW37o4KghMfmWw3m0ihvDo0HPFGoXX?=
 =?us-ascii?Q?/KDTTt+Am/1XV1y5AIo5UcbnzoOgn2lT0s0JFX7T+658DgsjH+MzS+pTI/UV?=
 =?us-ascii?Q?Qh0nh5lgljAMgom2WZmFCJf9r6gHGOsLhtmeXEh9q7VEsV2tnJBW9yznFwfd?=
 =?us-ascii?Q?wf0TyFEZEsR/GhwgO7QXotMfz+QgNpHEN/p2JXMGtrRlRII4EKRXjQNltSVg?=
 =?us-ascii?Q?dqdxTOuz6/IgxxWOZIgOY7UGdOPBhsfXicNexdNx4EyrSpyu00AfAA8oOqPv?=
 =?us-ascii?Q?dGHKtngJL/4GxXXweuA1g+eFhcKe2a085g8j3eVYT4kkWsc6dlTj98NHchP1?=
 =?us-ascii?Q?gP7Qjk8yiFrbs78TLYpvbuk/VBHTyvFYZFMMW9uOLp0Dgz095Pfknp0m8GIr?=
 =?us-ascii?Q?ZDwKNAniqwkHsmX2lepOwefPY7d1EXTxP54YKquOkuuDumsPj1fUA4y7mvK7?=
 =?us-ascii?Q?nZPza0UvLBDRsu7dKMiVuBzXtGFPkejOIfABX0wUcyCvqKHW4m2/+OYW0z7E?=
 =?us-ascii?Q?BmoWuGpcgJ5GIOv6IFNsHt/XSITnVkb5pd/p7HGvNWbfWB9oF/MwlPU11NBC?=
 =?us-ascii?Q?aBQMhebyKpLGCCCW2j16120Yej1AnAWHHhaGLlTM9YDCiNwC8xEy7u+9M7zj?=
 =?us-ascii?Q?8CrDjFASL4EblcLCf2a0KjXcI6iPTePSYy2ixRr7jPITRcHcic6KoLXA7mke?=
 =?us-ascii?Q?Qw/bQDP1O5z4EwdfSBgb1lqhl+cJ+x5hee55UiJbxqtPb7sc8RyLlJIpz9y7?=
 =?us-ascii?Q?mUqAMCt9yhsMdlo0ECu5fq4X+j6MVKos/1QHMmQJJu1Vy0PoO2yFvihCN1iB?=
 =?us-ascii?Q?QvdHRftofz9GvzaCURV6mBS/Or2O8A4c7msOHYaw25US7E2o1E9ICYp6r1eP?=
 =?us-ascii?Q?IE4Dqdtog8h+FpPwSbcrcRIPyIkOFx/PJPiGWdOEVD/WWsd76Lq5IuFmEvGL?=
 =?us-ascii?Q?DojtpCSwf10w/+HqV86UEJy+RFx35CU=3D?=
X-Exchange-RoutingPolicyChecked: oNMKL2KWiDWYcZLt/OYHHGkYi+9s7PPyMwOIIrPbGruUepX7IvIpQtFQhtCR9ZJnOzD/aw4Rl0yNUyNwSyqFFomOHELhxVN7XHv22WNFgbSaYjM56RjlZ+k6ThAvcqlzINcp4rLCOjeCeIIaiyTLgx9M+uHP2j97Jujq1R54swuu2tNtcapeXE5Yk1L4DOI4Htsc9uZFMCNIpYzCFZOgSQzilwNuXaLY5HCjTJmjvGVAa8QSAKRUCMxlnhWB0pU2N7JcFp9ApR/MgABISgfuSnbiSiNhkXzAq9jEvhmN8vbZHFWoy6dZuavLBZYnNigSjGnsJomL0potGV8L81r7XA==
X-MS-Exchange-CrossTenant-Network-Message-Id: de9dd375-ffac-4826-1e90-08de865b666f
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 08:33:45.6912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icIeEtFQZJHkvVCaRsaRoLmR9htpCIHa3wldb8Iau7JwyNcfkQn21VqbODMYK+Twt/sG81JAVRC8CBo6+dswM7OfCd9w9Qrw+BhsLmf1Yw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5118
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

On Thu, Mar 19, 2026 at 04:44:04PM -0400, Patrick Robb wrote:
>    Tested-by: Patrick Robb <[1]probb@iol.unh.edu>
>    Okay, applied the patchseries and did a run on FreeBSD 14. Looks like
>    the suites are passing but a timeout exception is raised (on the test
>    framework execution, not on a testcase itself).

Was this with the base version of meson? Maybe try using latest version. I
was testing using a relatively recent meson release.

/Bruce
