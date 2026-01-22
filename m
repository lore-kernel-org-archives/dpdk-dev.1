Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59910D3EE67
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 13:32:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 243E44027A;
	Thu, 22 Jan 2026 14:32:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 9090B4021F
 for <dev@dpdk.org>; Thu, 22 Jan 2026 14:32:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769088725; x=1800624725;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=NeDwtbVYdTW9hcCK2qmnyT1Bd1pXoiYZM1YAw7wQFwM=;
 b=Ga2KORhmjNSZj1pF1lWTn5UVRDpaDkMpxkSMVm/xVEOLID0nYLlYRROw
 6o48ibcvmp70gpZa+nIxFxKG3xtaJB+myumqGy+RZj0ccou/dPw/uRTWp
 mQllNuP7aDLEguuwldM2jgkF+oGjLmidOx1+04MfvoU6z60nb9vnuMXxi
 aY3jcKTrqQymiBI1pY+qT2KYdfsZ4CsZS0yGAB2ZpDXY0SJsAFnoO5DNs
 KEAsDlHoM+HNqVLZnWJ/+OL7LRImDpNZnmQgVnNlqZGEUhKXEOjXjQ+kw
 Gy8Ph4SET1zIZfqjhD7mA0V5/GyYYLmCuXK2cMU7AYO8fJ5VHRgINYq6U w==;
X-CSE-ConnectionGUID: aMkzwCMNS5Wu4AbxabOVpA==
X-CSE-MsgGUID: zLHeOMzkTxuQElGWT2TuRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="69524217"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; d="scan'208";a="69524217"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 05:32:03 -0800
X-CSE-ConnectionGUID: kdI31qcmSqmNHEV7yLQ4KA==
X-CSE-MsgGUID: 0jhHlNfuSW2SIbYClj2AeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; d="scan'208";a="205857273"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 05:32:02 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 05:32:01 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 05:32:01 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 05:32:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwVqOmn7JsyUMqVyVWqFVwoYv5OONOsV5Ffj+9v8VnIpdcwf5a3t5K9fDIKzi//zESNn7z/6u4g/RRB+9A6/VYho5w6j5h0sMCp/a0xN7S4P6GGPp4ZJ3anxvxcF3KgJBUs28V+cXSZqeGe39WZLqZhi+xy9SfzLQi0dql66elNJ6R+FMWH9Igu2JAR1QfLJcGRIB5uQ9G62ot00S8F+DArLnMH2OjvVeBT0tonkU/sbvhf0Ngc/gq90NBe/cCtZNQo/eRg9lUiLwFEBkWATxijXiQLhXtfaheFABK4pYrg8zmLltIRU0q3BXYn7AMMZ+1jJX+0Gg3nIFcA+CNdErg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcLo5kgv4Vd3rkn2thpoRRe7m6wlvAVXu/5ctOF51m8=;
 b=Y90Ry2KrvZ5r6BO/ye4034FNF2VDx6TRUuYAmX+uS1d/siXhMl0yc5Y487vvcrzIDy+UGsS+0kj0ogUiso5Sxtq5h87nEzmVhVT1g2U9y3prpm3gkk+nkDT1OM/MgYOUju+iMTeqQZAaICFVBb5ziVogy68fe1odegsR9WAKCLAcC/bgCZS0hiCK9Z7UoTEfykedOiliEZocQJnlqEJH+mDo4kjOYzVRKRxvTd45Xrflqh8drCDQvQADq68Ewt8JVa2if0H135A3BkQM+4f79Jor0DCNYQ6fOS+Sy3xjlOa+w2w6rtiudfKxdNWUf59Au3Hp7H2pQw+1x1pgDGtliA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB5897.namprd11.prod.outlook.com (2603:10b6:806:228::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 13:31:59 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 13:31:59 +0000
Date: Thu, 22 Jan 2026 13:31:55 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, <stephen@networkplumber.org>
Subject: Re: [PATCH 3/3] drivers: always enable the null net driver [RFC]
Message-ID: <aXImy8tDAqFygz_T@bricha3-mobl1.ger.corp.intel.com>
References: <20260122122354.1820368-1-bruce.richardson@intel.com>
 <20260122122354.1820368-4-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6568E@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6568E@smartserver.smartshare.dk>
X-ClientProxiedBy: DUZPR01CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: 4971f732-47b4-4a05-f7e3-08de59ba9e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?1IDZdealdlX/Y7iWZa/MinNF9zjDXjS8UhUfj+4rALxdxZcXCklY90Vaat?=
 =?iso-8859-1?Q?6jNNxZ8BTeRxPKIpbVmjPtp8BCu7nwQpO6+JpslWIE0otxrUd1f1ud0NyX?=
 =?iso-8859-1?Q?n4k7kDSWtgA99vNdNAXD72L2lBu69fhCRTGl9Ezr1tlx6FRtiKbnVlSBAl?=
 =?iso-8859-1?Q?mkJrDNm4fBS6bc+aP09pANW1y+VP/+3rIBmSGfqoY2vtxCYzPqtWTmNPoJ?=
 =?iso-8859-1?Q?7CQh+EuV6+dq93ukNSoKZrEGx3W/10dC94CcI34zyP/jGKSgEquWvLe543?=
 =?iso-8859-1?Q?Hn9LecdIrFh1z1Ng4feymO5/p2BkEp/GvXodD4svuWETl+DT+ogfhw62ft?=
 =?iso-8859-1?Q?4G3LfySA2nVzCnNfyzuza5PAR2dal016PLtNzffjH5tJIJbBVgs1HB5yX7?=
 =?iso-8859-1?Q?KL9b5nvc7HijkTOP9caFJnFNq/jGIHMf89F/1NtEpg0lOkM+mN18GF9UUH?=
 =?iso-8859-1?Q?EC9nqMXKtlfTDtoWn3nrtQ15M3aD4IXPtj68hpseYUmEeQ3b45b6QYsncI?=
 =?iso-8859-1?Q?qRQtCMspMUBL8be3tUiti+LjL3vwYW6oRAu/jFyywLM4NFi07UmGTqRgfn?=
 =?iso-8859-1?Q?eo51PK5dYhgaZcXZuSjjaY1UFeEIZt4YHCuL2QLRom748sNIIZjI+VFE8B?=
 =?iso-8859-1?Q?ou5si5OE3MX96Q4LbAtc/yLN3nFOP0WlQTWozQOTl23GwaejdPQQX92j14?=
 =?iso-8859-1?Q?hJA+krCwm4993vBuiuZnIcG37AI1uzvd2ek/pf7NIxiNM+/IRvZXM/frOH?=
 =?iso-8859-1?Q?jDbWmK+XVAS4FEZVOcpspDiVKLkBIvrt7Mw7THDaLwh5W3CHYvhvt6eiYB?=
 =?iso-8859-1?Q?ShklEAHyRm81IiAUvkXQfxSWoTVHaLIesvcgNwuDJesqZff40QCXWxrf2g?=
 =?iso-8859-1?Q?saDEZQKOxwcufn6Bm0YE89tLu/av4g1Hs5YI/9R5O82Ag7Wg9cmAB8+gIl?=
 =?iso-8859-1?Q?2OtDC6wME1xlGfJPwpgAg5sFTQx22T/5WvA048aW2YNAUCoFMH2LPN97fB?=
 =?iso-8859-1?Q?zRfvhiGsuROltsS2xtL6PxcODUzJ08lkW+USOiUGzQkNhRrVdEotmoCWnF?=
 =?iso-8859-1?Q?cwGS+H5OQgpwOdA2qGuFfyBrOa+YIK3E5wq3CT/buoAqigZ59mvdOW/7fC?=
 =?iso-8859-1?Q?7Al7sSK4MsEy003mh1Zme//Y/EQw3wolatLfZZSz3fiLNFEID794Tl9gYv?=
 =?iso-8859-1?Q?SRN8lax+Ns+PI545ZpWuobDX77+o7pfEZrex1Z9W9lQxu9NIFKkKmqEUpa?=
 =?iso-8859-1?Q?bpKu5+W/Dpd3GvpJVuR2JDf4SlnCCtmuhUkQI6tvRDfN9feWXdSVaASA+J?=
 =?iso-8859-1?Q?aRtIdlyONCdtZCJ80zNXkOmm5wRWfi3rYR889X9QbF9H11qlt9qHf0PHQ2?=
 =?iso-8859-1?Q?NQ4N4kQlPrqb0ESQNer6CMKBmHRNk0ZKapWHL5VPvKzZyv8wxT72mE/KQF?=
 =?iso-8859-1?Q?1DcmTIaDb8obD3bCGmX6Z7hvPrbCqHHlDOccuWj7IEO1eGmqnlp6GY52Gv?=
 =?iso-8859-1?Q?d6IZKijO+ike3GOh5M98FoYzI6SP5NplgYRcmwXHJS3+33xhAlmlUkCLSa?=
 =?iso-8859-1?Q?7R1pJqaUifzy0yNAQH6nTiLJOcxuN7Iw2ywlXqbaJ0Z2tOIXuLf+h/RT4Q?=
 =?iso-8859-1?Q?kWhDr76Ffe0vY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Yy62ZpLKg04z3AicJ2C8YFUjBs8b2KXcYBvyZCc1zZ9hWOovAWPrbNH4cd?=
 =?iso-8859-1?Q?lhQWesTRBaYc9VxaJ0HIT/Z3rJ8jjvTAOnN9+x8hvTwQVCsSHaznzsZJN8?=
 =?iso-8859-1?Q?Yjqm1m9kOY4S2nxK3x3NcDlzMuLIejGO17Hz7PWZcUaI96sxzj3VxXXbXm?=
 =?iso-8859-1?Q?k/iyFKzsI5RIN/JKJzymEUY57DmqWpctuPj4glTe8jLBM2dl7FsfKQpsHz?=
 =?iso-8859-1?Q?wmVjy/+u66qKRijwmAqRAanPeg9Ea69wFhTXDp6/3WqTkCSmgInJ9Lvp60?=
 =?iso-8859-1?Q?F8UKZS1GGnXLJyjktGgaW/uxJL6BsyjRIJd7iXAxXDHbslePO5aN6YGpX4?=
 =?iso-8859-1?Q?oSpljMbkOSC941LHdYepOyAW0OIdJ0qEnmiKPC7KeVzFtXgiYYF+wjwnw4?=
 =?iso-8859-1?Q?QgjCb7B0Faij3M9bpv+3i+P4WekrHDTBuvGZ9os3TyEVccW+MyjylkrkbU?=
 =?iso-8859-1?Q?h5g2Jn0DMWxPvzMtlc6ypLihGd7C5xZkQax3zoR0TJu6idXj8BxxyJsLyO?=
 =?iso-8859-1?Q?fvU9u3sIQ8JmUVstoKz/CAr1xjQlER/lFCX53H5rCc4sysmHRwMX5ArxC7?=
 =?iso-8859-1?Q?/yhp/1VjxKXwePcAcpLrjZrI/27RrQb1k/LVUPJ9/ZBq29vubonI2cSbBV?=
 =?iso-8859-1?Q?573MGeBxzSacBOeBHpyF7OXef6DCf6pGRgWIugw/A9k+BfDhJt5eMNGELz?=
 =?iso-8859-1?Q?fpW+NBTxCYuqLjITNyjVZpeGEr63bvr1AQ9vbeghyguhFcKShl91T6GfYF?=
 =?iso-8859-1?Q?zuLLGjdEMn9P7NOdh/FN9RAKdoYPeSp2Cwi2kR8IjOSUKrIBxNSaM6BsVi?=
 =?iso-8859-1?Q?/lJ23LDq2rGdY0zCY8oos67mywDosPpiAEpu/oF6Jt3Ww+1qfEFWilbiNM?=
 =?iso-8859-1?Q?3ZizdP+A/3Y51NjrFQAo6jX04zaAwzicBnjabmTWxgu2ips5aqOiXrHgFW?=
 =?iso-8859-1?Q?N9XyzJHZrcGwJMzLXhg+HdbtwhO07Z89pBkzp/na1RfOc2nv6HZEHHPb7Q?=
 =?iso-8859-1?Q?P4MCDSnfG3aZJp+UtqvqkJRMMrNe3YtbHersBxT39bb605fQjhs4GGbhmJ?=
 =?iso-8859-1?Q?YWa44sFYFwWYCkG4V4nFOB2IuFxQJvauyjEpU4bT+5mAWZLyq3LTcx1dJn?=
 =?iso-8859-1?Q?P0nwxSSb4CXTiETGWNbIYMNrUFJcd2yPTMl1GQiPH23EA4PNDC8iuo3II2?=
 =?iso-8859-1?Q?kYr4obNM4Kqi4CiXiLtSfb3Vr5J1PtpCpSf3p66/D1wBF0NYjCS4+Rjs8g?=
 =?iso-8859-1?Q?Sv+kVbFnIqWDd8rzWRe7LQrArFp1OCu0yGzw4sz02nk1rfR0GNLBGm5dJy?=
 =?iso-8859-1?Q?CLfR4FAraicoKvTBg894lfJcjUDetc2bEv/i8V9Ih6wvNs6T+Fm5in4tHc?=
 =?iso-8859-1?Q?9HMOC+HCfmYQcR8cQk9TC8zQB9cDbAr6dzjh6ovJj90BNyIKV3hRVKinrw?=
 =?iso-8859-1?Q?I/BIuoiCun7YTl1HTs7ayIHnVFkO2BEemFlBA2GQzFVyf4hQVUXDDfLMD+?=
 =?iso-8859-1?Q?kQA51XiyqbuiiDTYw8gp2RwyFTwjl8MlxANlgFxLxSvRkcfO4q4pX6PQrB?=
 =?iso-8859-1?Q?ZUaUNUYcTAN4PJOE9RwBXkJTKDyz+adNXAHIEq6FGlbUlrB0CXiCwSkPzj?=
 =?iso-8859-1?Q?pf/hKF1On68fmta+s8pScWJe2Z8gfx3TTeRNgT1TD6g1bJVlhWs2R2GHJH?=
 =?iso-8859-1?Q?O7nAyx3RfeqR36rWpM7MjGoxGW9b5Wf8DA9l3V1AJd7u2huFwsQvdmeYIT?=
 =?iso-8859-1?Q?K2WtoGSSDBjg53BRJNw3cyK+QkM9n6f2hufUSXEEIbwrEO24ixdOnRdcen?=
 =?iso-8859-1?Q?RHdWeocGxLZhGS2LKktBwbpwmDmBpAc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4971f732-47b4-4a05-f7e3-08de59ba9e78
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 13:31:59.3037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rc7YSUUSI722+fFhQKOCfEP3IpgtGUqKsFnXzFnpak431glXmFMrBfRbsb2icdCUrzNoCSGraEkCRfIuNGWQ1jYIP2b+mvuhyWT7Kml6rCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5897
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

On Thu, Jan 22, 2026 at 02:13:06PM +0100, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Thursday, 22 January 2026 13.24
> > 
> > Having the net_null driver always available can be convenient and
> > allows
> > use by unit tests, so add this trivial driver to the always-enable
> > list.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > 
> > ---
> > I'm not sure if we want this to be always enabled or not, so sending
> > this as an RFC. I can see definite advantages to doing so, but I also
> > dislike having too many components on the always-enable list.
> > 
> > Since I'm ambivilent myself, including this patch so the community can
> > decide.
> 
> I don't think real applications use this.
> If they do, they can include it manually.
> 
> My main objection is:
> We are setting the wrong precedence if we make stuff like this mandatory for convenience.
> 
> But I agree with the reason you are suggesting it.
> 
> Is there some other way it can be enabled for unit tests?
> Maybe the null driver can depend on the unit tests being built?
> 
> I don't mind that the driver is being built.
> I just don't want it included by default when statically linking a monolithic application.
> 
> I'm flexible on this RFC, so it's a very soft NAK from me.
> If it can be disabled at build time, I'm OK with it. (But still concerned about setting the wrong precedence.)
> 
Yes, I agree.

Why I'm proposing this is because, in order to give me faster rebuilds and
because of the hardware I have available to me, I generally set up my
builds with "-Denable_drivers=net/intel/*", since that really speeds up my
dev-build-test cycle. In doing so, though, I do miss out on having some
unit tests available when I run the fast-test suite, which is why I
suggested this addition in case there are others who limit the builds to
just the hardware they are using.

/Bruce
