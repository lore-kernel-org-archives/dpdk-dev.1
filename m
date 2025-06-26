Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6585FC7EE31
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 16:47:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B55540276;
	Thu, 26 Jun 2025 18:47:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 94D0940156;
 Thu, 26 Jun 2025 18:47:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750956429; x=1782492429;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=jsNynG3GS3PGBVT7TVAGcMLslDaiBToQJeWV5YxieeU=;
 b=Uo1jYfNun4L5pcK8nqVHPtL4iDCjLCptOmRHus3P9FY5c4LMn448oTu8
 CG/dZKXqHykKU7OHh0APHHrNJSktHhr5SAwxw2psNc+O7hEZGn1GndQDV
 cbyns8Ef0bc1g/TSL2FBRHWoAoWBIDnFuxa3uNSJuSTnpTE2gULU4V8ct
 ZRuSEJAivUqfRi1RaUIVoyzEbibVCXCn9RBjZAWX70li42CaMkY/omqgC
 gj8LTZ9RhEF8gWL1dgff4hop0QU/UPpSAz+F/hwgEQ5JZjURN+GnarvTD
 xHqhpofnfaYGUObwbBss6ebqGDfh/BYnW0WQe2+uDtIsk7eeJjUNTW1et A==;
X-CSE-ConnectionGUID: IUVYaqqnTzqsoYtUgK7+Sg==
X-CSE-MsgGUID: dAhmKkqDS42b7u/PVgxM7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="64616691"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; d="scan'208";a="64616691"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 09:47:08 -0700
X-CSE-ConnectionGUID: LneUjNf5T76rRJqry14eXg==
X-CSE-MsgGUID: 8ffAhW3bQGuSPjXUw0T4tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; d="scan'208";a="152080608"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 09:47:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 09:47:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 26 Jun 2025 09:47:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.76) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 09:47:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNkQTJfBSgtNA6pjwY09EoMszgen03ztMvikJwD722OYoKM4BirEG84RY4CTKPjRbyd843nj5Yv9QZNcIQZwJPJbIJkM2WqtOMz3A3a+ljh8hpOlAYQiEjBfQdS2L5I9eb1/beCyob1W+Trj9RyCqIx7WQ9KK05P+KjWx+K/nncSLwTWKyRZsvjK2phz/X3G+9lAW4pyGKgUhuSLmz32IOi0E8+C4pnlv37iBKglMZ/SWfisOdfnIc71We223ia+Tqmaaafoppd8OzZym4JpNQI8UzAwZ7FRO9nkNMc8lIxtA+XX40xgXHDepdWaHM+kbb1nvqBH6p1nvTYn5JQg6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8g3hgXIwDmTTj/Ls4Ps66H8kY45uzNh/J1lI0d6MAA0=;
 b=BMZ06V99rJrA3PxwKmGOAS6rVPWVHjzYCQzbh/TJ2iBgTrowKa7mbuUkgOgkihfWlXx+OvWFEDKFiqqQbFTEE6ywCs+1+mGbcietDeBtHZdf7toEK1bFNmLIOsM9AKri971NLRlD6ctbl6Zrl7RF2nWQ01PLz+0LZtgO6LJcYiwEsH/0/fFsHN65avSBoYSsEdX/VAeTPzPbe5Y3CYthfDNbgAWUF8T600DJvsQc01GWC7J7gtp6ptffkkWbhsVJdqwyQhtH23aKErjJXgZmX75LaMSHR0eDCe0X/yO4/lTJE+HfaGlpn1xLBJv2xCQ73DbPEBQzHamJUsEbWe1a/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB6517.namprd11.prod.outlook.com (2603:10b6:8:d3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.30; Thu, 26 Jun 2025 16:46:59 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8880.015; Thu, 26 Jun 2025
 16:46:59 +0000
Date: Thu, 26 Jun 2025 17:46:55 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Stephen Hemminger <stephen@networkplumber.org>, Morten
 =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>, <dev@dpdk.org>,
 <techboard@dpdk.org>, Tomasz Duszynski <tduszynski@marvell.com>
Subject: Re: DPDK libs as one big shared object
Message-ID: <aF15f-j0eP4UBywV@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FD01@smartserver.smartshare.dk>
 <45747073.doPnVEEUbh@thomas> <20250626055319.1ef24c96@hermes.local>
 <6044178.qgXdJBQaxk@thomas>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6044178.qgXdJBQaxk@thomas>
X-ClientProxiedBy: DUZP191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB6517:EE_
X-MS-Office365-Filtering-Correlation-Id: fff404ff-4a32-4cdb-83aa-08ddb4d111d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?ceAcxqnNBuOdqrMBZ03R3F39gVv1VX3Bz8fy7sF3Hmxeby4JNTh8VylvY5?=
 =?iso-8859-1?Q?W7AqNleLrOWOixtNycjCH00CWA0hJYwhjM1yyMkFmOeiTJUTGAk1rX/gJy?=
 =?iso-8859-1?Q?ETdQOZUrJjKnnJqff2L9fMiJnExQYTXx7IYIOZltbEWxVhlyiSzguJL/Zs?=
 =?iso-8859-1?Q?0bLILPvCPwAEalRaUbFdu/6varoxyaGwx3EI/tcUTLwP6McBQjF1WfmKG0?=
 =?iso-8859-1?Q?pWt3rZGMAazkFDyy+E6ybdQtv1wzHJU5Kl+pW/UyBpyQJSgIRvm8vZHJMh?=
 =?iso-8859-1?Q?ov5hjQGk60YAIrD7RkB3ruApzufglvAuxXgKr0LMTnlfejrSIkD3FBZIdx?=
 =?iso-8859-1?Q?oOKK7Y42Ku5G0jFWPDNXypavBZT0o5ffokQtDE2Wd2SzTlrzMGZD6rIbff?=
 =?iso-8859-1?Q?x7u//XE2HN9TnIc+9AewlpJjcxYN+qCM5YPKVFIhiB9Zx2OuSwdkaH/LQv?=
 =?iso-8859-1?Q?L3l80kytaDcSO0v07Q4F7+V4U1z17f0cqdCQ68KZQjQm8nqxtZ0alpmjHB?=
 =?iso-8859-1?Q?gczbTYmLtyhOIsWGjZpJ4jMRee2kP/dSesG0bTRTUacXwuS3QJAdpVDCLI?=
 =?iso-8859-1?Q?vZNby/APYbyKjhHPNx1awBcd8IC1ovroOaHNd5MvLKH5EtPQwEL/ooXk7S?=
 =?iso-8859-1?Q?ui/jVcALdfsJAwEFwlpMVSatd9zFNUf0x3ZCsUOC3Tez31IX9M045grXFR?=
 =?iso-8859-1?Q?c9hwBis32UE+on2bOuDpEYHa9jTV0tozgoiIlHPeh9U7ZWofC+mIAYPm2w?=
 =?iso-8859-1?Q?ynJswMuaLhFA619SR0ZVJ14LMzC30JYkvHtoXhVLY1u0lqH+Ek6SlsgQkp?=
 =?iso-8859-1?Q?8fm3WWmeGmlHHFJWH7LuX4dpHqioybTqBzwA6I1W60w6WKfiHFRlnSo+IV?=
 =?iso-8859-1?Q?Yia5LrPknFnN+rWcO9t2XGFGmqCSX/OnQqaudkHTFoYij0iNWVP5JCAESt?=
 =?iso-8859-1?Q?/vzHKOVYUNeycjDC8HJfumiswVBqr7dov5LpwdB7Vnt2u5r3VGyGF/YpkR?=
 =?iso-8859-1?Q?or69GhIJJB5VUHFpmLF72aPyapHilezeYh0K/bBOoUADcFahxN9zx0Csbh?=
 =?iso-8859-1?Q?ZnHswHXP+hK1Yn2ntuCQOI/qUc3g4W1XgwOt9i3QixsATyZT/Qb22cgnLi?=
 =?iso-8859-1?Q?R3L8Z0hNAqp50M1oiyQQJ6feSFBtW63kqUHBHgvwu5lZTkNOiEyPttSmpP?=
 =?iso-8859-1?Q?qymwvHvW81gkz1a6C+Fciibb6vUT8QHP1jT91zT/OnIfAhx7fWghGGRq64?=
 =?iso-8859-1?Q?mvcyIPD6bZvCr20sXpmDZLSn+BSXgqXMn0rScAtgB1wNhiBKYstQX9iag+?=
 =?iso-8859-1?Q?yYR/uBMY5F3jbGyc6O7I4LxRsIdE1NJzqFb5rZ+ZZidSl5qlIRqzmSRSdk?=
 =?iso-8859-1?Q?2sJinpxWGxc6aHZe+6teNiS2fbsxcmxeMBhtyftQu6c8NNDyEF9C8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?fm1otgXh8wBmOQuS2rjoZxV1skZr9hNiSgvuNtyzByShCZppvk1EA0Gjm3?=
 =?iso-8859-1?Q?F2Tct3NCIVRI/s+5gXna1Y7aBMHnoIq5JJE0Y6594x+LiNcSP1cNERIwUe?=
 =?iso-8859-1?Q?pE+H2LpuuTtMwaTZqCnssH1NvW7Fl4/hzB0/+9fVOIf3KcYsSP+cBFFrnz?=
 =?iso-8859-1?Q?dF3HqxPjDVmsjN7tinlOUteW9l98xKtb4FgAb98Mx6YYUrcweUiwRZclxd?=
 =?iso-8859-1?Q?G6EG90GMhzbnxugB2fsIi0jmEre+CUMQzGdjePUh5biGmhjcAfU1z2UoJE?=
 =?iso-8859-1?Q?dc4d9t+Q5O9jbMzsigFAD8cD8zylOrECQiGChc+4MXHdz/3uAWDT3mFLNb?=
 =?iso-8859-1?Q?ZBrDnQawj0Wi94Aq291M+4MZI4I+ycFVbO48EdzKqik5CIr8UiH3Dx0G+z?=
 =?iso-8859-1?Q?qlm9OZofgGJAjhCPI/d6k8MAUCDHr8VowPgV14grnYqkJZ29IMwYvrOh5L?=
 =?iso-8859-1?Q?z+TYeaCSaebgNk4gJBoHeTrPtZl15QQw4EkSCXwLO3kI1W+Q/1puL2w586?=
 =?iso-8859-1?Q?MIrya1wWHFsu3A5KOvxxChps3jCWzJH3L27qe2txvFlYJ4ZL7pJx9kfYGQ?=
 =?iso-8859-1?Q?oPXdEdy0EBtIjRDQMHnbArg+fdCnGtnQxjohiD96Swfl8OJrHsRr7Oaz5z?=
 =?iso-8859-1?Q?q3yzEas3bXQgLYrwmre6dzOM9WytOjCSBZsREv9aaD/eZyHVUPlcHJEsDT?=
 =?iso-8859-1?Q?VxSrDFlb+ItQAuEUeyj6OA2RnG9VNqj1qbZLB9124unl8sV8aaWD08JSfL?=
 =?iso-8859-1?Q?eD6hd4Cdi7klXh9WeoB3uEETMZvB+QuAAi8bpVBPlBBfIIi0VCeYTUBiLr?=
 =?iso-8859-1?Q?L6+9KcuylD80RT9OPWKQESuElA8NFKszDyEUlyNNE1oi+5Knu1JM5tLWTd?=
 =?iso-8859-1?Q?lbTS7cpeR3BP+5qpobMKjTMH9RdXqSDIW6n38V2zq8BGPT5X91GPQRATKn?=
 =?iso-8859-1?Q?Mdb8435ZIeM+omAz4acWBbY5NTzBT7sgNfmSSZZlaH9BDQ3m7IX0xZSKyM?=
 =?iso-8859-1?Q?HbgyAYDepCpMrDZxoi9mnT3GysqpSZ7kI8AdUFeQdE1svx+Z0e1FBbvaju?=
 =?iso-8859-1?Q?LW0Y78KDIkgL+Dgajx4Gb13OwMlRKX7HCb+hf56Q/8QD2F7iKm/NlwQkGA?=
 =?iso-8859-1?Q?uBXNlR/2Ktqu/YT63m8Eyiyrp0CcX/NaBEtkulQtE4Ng/n+9oYgjgRJ7Uk?=
 =?iso-8859-1?Q?6zAvzCHxQu6piut3ULbZDZG9EfNXvH9revLZ0BUUl1otd0NaPTWajIylGs?=
 =?iso-8859-1?Q?vB7yh9o+wqh/k+kIVmz/7818sgciAml6oXdP7RfxHibN2jaLg0HzHskJHo?=
 =?iso-8859-1?Q?Yb7gSd3hmVh0nwpFnKcnpqlqn+s7ALDypbQMzQSMuRU1zHNQQe/ehDEWdW?=
 =?iso-8859-1?Q?oZ1s4g7CrIHFn2je3r5/H24HJu2YRzRqwvGe78OVaxz4VRqtUn8FM2DEK8?=
 =?iso-8859-1?Q?dg0b1CkolrDRpiPMyTWBrjqASqxsj4bIFJjxyH8raA5uN7oN0fF/9mVwJQ?=
 =?iso-8859-1?Q?vSTihjBIBn595TEf0glnGS8IPSLLkD9TeYSAcpak5SEsFNHWkIcziBtLJ2?=
 =?iso-8859-1?Q?zuA6D7Bm7gLqv8ARVIVRXdXuTFqOjpzwsQBkETDIfFj7PnuIHX5kjsCjcs?=
 =?iso-8859-1?Q?11WIyTZG6Nb6EYfhAspgB/DlC2PD5B5bR2NrWxhP02ecDfqcM4f1DpKQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fff404ff-4a32-4cdb-83aa-08ddb4d111d3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 16:46:59.8730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EuCsDe7AtJlBywlqVTK594+stnOmSJmYXbYGDqqfGvhl90G5d4EpgovHG1PjaGBkUiuN/buW9XsbCJV7caDANSFp4XMPu6g7GQou7WyR7pY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6517
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

On Thu, Jun 26, 2025 at 05:16:10PM +0200, Thomas Monjalon wrote:
> 26/06/2025 14:53, Stephen Hemminger:
> > On Wed, 18 Jun 2025 12:01:45 +0200
> > Thomas Monjalon <thomas@monjalon.net> wrote:
> > 
> > > 18/06/2025 09:39, Morten Brørup:
> > > > > Why are we still building one .so file per DPDK library, instead of just
> > > > > building one big dpdk.so for all DPDK libraries?
> > > > > I think it's legacy from when DPDK libraries were versioned individually, and
> > > > > thus not relevant anymore.  
> > > 
> > > I think it helps with selective packaging.
> > 
> > That only impacts disk space. The linker is able to only load what is needed at
> > run time. It was a choice made in the build process. Not sure if was the right one
> > most other projects don't have so many libraries to worry about.
> > 
> > > 
> > > 
> > > > > Wouldn't building one big dpdk.so eliminate the problems with circular
> > > > > dependencies between DPDK libraries? 
> > 
> > Yes is why most of the big Gnome and KDE libs are all one shared object.
> >  
> > > > 
> > > > Obviously, the source code should remain organized as individual directories per library.
> > > > I'm only suggesting linking them all into one object, so any DPDK lib can call any function in any other DPDK lib.
> > > > 
> > > > Perhaps only the core libs or always_enable libs should be linked into one object.
> > > > 
> > > > Here's an example benefit:
> > > > I'm currently trying to convince the PMU lib author to make PMU depend on EAL [1], so missing error handling of sysconf(_SC_PAGESIZE) can be in the EAL for all uses, instead of copy-pasting sysconf(_SC_PAGESIZE) error handling to everywhere it is used.
> > > > But this is difficult with the dependency chain for the patch adding PMU to Trace: Trace depends on PMU, and EAL depends on Trace, therefore EAL depends on PMU.
> > > > 
> > > > [1]: https://inbox.dpdk.org/dev/98CBD80474FA8B44BF855DF32C47DC35E9FD08@smartserver.smartshare.dk/  
> > > 
> > > I don't see a problem to copy-paste in the few libs not depending on EAL.
> > > 
> > > The real solution for EAL dependencies is to split it more.
> > > The malloc, init & logic part should be in separate libraries,
> > > depending on the real low-level EAL.
> > > 
> > > Then all libs could depend on the low-level EAL,
> > > and avoid copy-pasting.
> > 
> > There have always been two overlapping targets.
> > Embedded standalone and standalone network appliance , where building more than is needed is a nuisance.
> > And distributions which need to turn on everything
> 
> I heard distributions want to be able to not package some parts.
> 

I believe the intention is to only bundle up the mandatory parts of DPDK,
e.g. EAL and dependencies + maybe mempool or a few other libs.
In that case, there should be no option to drop some parts.

/Bruce
