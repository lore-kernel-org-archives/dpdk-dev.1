Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4067AD72379
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 11:33:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5611F4026F;
	Fri, 23 Jan 2026 12:33:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 25F2640269;
 Fri, 23 Jan 2026 12:33:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769168025; x=1800704025;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Uri5ZU4ERK2pvWnBMhhpbKYyme1V4rEN2+5arpxSgDw=;
 b=EmqMWRAJiHXQlG246+MPLZ276a0PYszOtJGq3Xm1UWKoAmvSRkcGZ5Lt
 jrPBxBEGgRcSHV2wFpO9SwWk6PumrmrFme6+QYyevhGg2FyyJDaALTHPU
 q8teSkGjOmhRbKWtW030q+iRWrPLuNnRAaVk+n/nS/4OxW7+hN+EXFJF6
 U/C7VjoMvUNjE4r+Bq1ZwfhHJFdDvccekY2+DbDdhGhsfbiYJZkNsK+xK
 GD9Y1jJkSOfcJGb+f0YOlBKmPHRfea54/tKBlS7w9Jod+bjujaVw28M4q
 ZlOuI97pW28z1CPEwXgcbmbYUREeI/BoXIZFEr57pm2uW0csXNxwQEvFS g==;
X-CSE-ConnectionGUID: 8F/cuE1oRo+DF/hswuDE9A==
X-CSE-MsgGUID: iT9pmpF+SnGHMgBHb8WSaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70481371"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="70481371"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 03:33:44 -0800
X-CSE-ConnectionGUID: 8cg4DybLTPmqGVQJAOi6Kg==
X-CSE-MsgGUID: pXo3j+f8ReeL2FPeTIFE8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="211506536"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 03:33:44 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 03:33:43 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 23 Jan 2026 03:33:43 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.44) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 03:33:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXqHSxTQLcdbnGAqaczpWTX9VV2RcNSNlDsC5HcRgw/UyI+a2Tpuk8D/thkAR85qQZyE2zxE3E94NuIQ8iU0XFY3VeIW/oEEogKBfWaYiDkZllzEqN6KxZrULDwl5l7Da4CKKWPC8pm3k0h0cqQYu8Lt3uRuaIdbInJWAclurTWzyWourqj8SjxyzFaW6EMMtbZMaBFXc0vbUj9nl9ug2148DioPtZUszlx8DB/qbmy84hDLYxNd/+hTECZqJSHK66hb3k1T588q+yug2WvzWOWR4JpogcpSmUTapdPsEYQSrzGN8ET8l8aTlQ5/7DGuz/OOWlW5m8U2hqqQN8/AHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yN4/pS2CMUZlC2VOdKItniOZHgD9nxNHCo+T+fF5kBI=;
 b=jlRxg/1PjL1NHiGSEsdNhu1Of8l5mLFDiITEbp54UDfhXeZTerrT8wwNBa3P2AvH2vmDyz2BHIeDaayj0i7O4KTL0LBbebWEO2u1ueyphQxVm+dvYWWPEzvYJQIoePLjU7EI/4IDlDqOHWOE3bfxPwDzhEbJMZZbDCqcLnPids4CQ5c1iAtaFNs1vU0fcBMzjJK/hvLp+3m61FLEGVR2SddmP9/Yjcr4vQxKi8Am6mn9fbuyj4wzDuV+FK02+8iVFie8cHnlxYeAvzO9aD7M/HmYiUPfD7586teFzm+EoOsbA+trtd+ryQE+ln1B97t8gffa7bfyMlRimAHAhz3eZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6944.namprd11.prod.outlook.com (2603:10b6:806:2bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 11:33:41 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 11:33:40 +0000
Date: Fri, 23 Jan 2026 11:33:35 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, <techboard@dpdk.org>, 
 <dev@dpdk.org>
Subject: Re: mbuf fast-free requirements analysis
Message-ID: <aXNcj_Pvb-q-DnOP@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F655E0@smartserver.smartshare.dk>
 <aT_1J0If92bxkLG0@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6565B@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6565B@smartserver.smartshare.dk>
X-ClientProxiedBy: DB9PR06CA0012.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a97578-ff1b-45d4-8f40-08de5a7341e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?z8ltAWR+IK313XIWt9COKs3+eNEMr25ANE+xGcmHvbOrBIfp/5gIaoBlHV?=
 =?iso-8859-1?Q?ICImXGRfOSwSrSFzzINx8ihCDj6WQMqibZdl4iiKPaTq8qCwkI/DbjxP47?=
 =?iso-8859-1?Q?enyY85x12LbdYraHcUP1g7Uw2QD9S6QeM1P8/nGwLimeLBZfdZs3+mC9CB?=
 =?iso-8859-1?Q?CRJT+AIj8Xjcqaut9D/Sv9H2Jj8Kp6BZGv7xgZ5V4lnYuqRomne6VNs3wS?=
 =?iso-8859-1?Q?LIuYPUOurxUHoBAz+Z0UhqDjT3lq7rYDFYLBkVVWKM5ZfPlFK9mJ+Jw7Bx?=
 =?iso-8859-1?Q?TZEYvCX+c1Dug5lUoSPDYji72DnlDCtQf1cfoXzQAuXaEJE8UMDmUMfT4k?=
 =?iso-8859-1?Q?ov16DxmT8zwRjutjmRn1HKWjlxjrMkYzveB95FQ9TIHAQfjewcXm0ch5u6?=
 =?iso-8859-1?Q?9QhdAnNnmj8GD/AZlVpfSz9q2NzZk6/sVvpJPBOUP/1zAyQbFPDIet6d8j?=
 =?iso-8859-1?Q?/FRX/jOVuRGxKZCytldSeEKB7/Z2fjA5uQiLFFr/QECnYB5HJAGyoOW8JL?=
 =?iso-8859-1?Q?uZADo13hIga3klCCWnz1Cq4CZjixgO06CrmBZXAXgPJRCkClY0CBcEmTAn?=
 =?iso-8859-1?Q?naz6LnE2kia8IJgglBbWUrefF04tQAgOwjW4PMQekPqsbpygYZCtS39a/9?=
 =?iso-8859-1?Q?U4TYp9/3/QITUDNYnRJPbgloBAr5nlT4DDOoF5XVSZ20OAyevWGyVtEfik?=
 =?iso-8859-1?Q?nqAKvOLyerjj8gWlosiovZ0R0Zb/tWTwSBQMBslhd2P9FdGudwVbPj/fRf?=
 =?iso-8859-1?Q?q64Tw4+PVJwuaniOHZVZPLTa8RfMUoxYjzGC7E3N03NmHmWSnIoyOLBbKa?=
 =?iso-8859-1?Q?xMmm5NI+8IGST3BWEuius21e3e8jAJj4dWeZFmvzgQruGlZFKvEJMoyhWe?=
 =?iso-8859-1?Q?3BW9LfSRkqS2dx4MHpGejEWGb6BYNRZXpr2mz/BH4XF4/b1XH9EOu++QgQ?=
 =?iso-8859-1?Q?/zAhARy4HXdGUOp98IRNeZg6GU24rP+xMOHMUaTs4awSN3qq3CdptZPqJ+?=
 =?iso-8859-1?Q?/XKKEk4P6slYCRpAvpdbG6A0Dm6YKglyCkdM/SEVE4Phpu/oV9gBUX1W92?=
 =?iso-8859-1?Q?MiP9EQbTATHrVfOCDVdfwjfpV+Mp/6bzaUyMrKFeTalqB7iVdwRjkn//E+?=
 =?iso-8859-1?Q?6+ibcs0FUTgGzfQ6sUi2Ete5AKXv2RJkYExGDSACYJRaQG4JAvL5zhzpGz?=
 =?iso-8859-1?Q?/t63sCjxWWnqnzcFYwBMP/CUmr6xT5SbSe4srinFwLnQBgLdoLJvVoBIYL?=
 =?iso-8859-1?Q?/1aqpJpMgQ02dT1UgI6TF1KYhwejXBlMbiR4te0j1R7D/GYlr4s2uFJux/?=
 =?iso-8859-1?Q?Mx18snJQU5K88/bTGolg7+yZLZhlUO1BMsPiGHoqmEi+A3DoFjppLvMtKv?=
 =?iso-8859-1?Q?1bttyfn5vv5tuk/zSn2rjrtB57GM4rz3EONTRLk5st8vk6wyeC8cEERINj?=
 =?iso-8859-1?Q?EAuUyYB9kJfW4aoFpgYXfFv9fJJzsAeLWqiExUadw3jv+4ELuT+asmtglf?=
 =?iso-8859-1?Q?jilPggHeWIMJA1cAQRcKjoZokvaZSPE0B2bTnvhkXdnhGCaqXOlIjE0lc8?=
 =?iso-8859-1?Q?sYO9eMtDdHk8/jWpiIYJPgOk+yP5zefII6hdCD7Qkb/dVTutSyAAKgN9pJ?=
 =?iso-8859-1?Q?xEwKHzg7OiAFHFFHjtMQ1Nzh8LOSBkaljB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?AxOkYcY3O+EUyYQrPQw0m4PZ7lYGgQS739ti3IO0rLRGkz0yU3rCtGtm3z?=
 =?iso-8859-1?Q?Jfff8Ea0kvGYdi+8YZc6WX59OD5ao8GcGKWD++zJDKxyau6JAYzLBXVHAo?=
 =?iso-8859-1?Q?g3yvs+AhXMrpZ6XqAFlzLyE4BimaG35ilkEiJscE+8Gb0xd5X7JLFDB/be?=
 =?iso-8859-1?Q?zOQRDo0Br0rIqJdKhFfs5lNSf4jg68J2mMy07b7N2/AEVLy2/ub72FXnyL?=
 =?iso-8859-1?Q?cwAbMAdpwbEfAUVPnXK95qSPK+QbSMjCTa4/RtDgqfYrfAqFXNdfHeoYlr?=
 =?iso-8859-1?Q?xWW7MusDltx5i3nnB+Bk5e+o/5lyJn617ACeiF3igQrsAxhdUoQtA4se/Z?=
 =?iso-8859-1?Q?dUVEFVzcUnksd99ueZ9+RClzN94ERW4sIUQG5hC6ekZ9sLiQEztOiqmKeU?=
 =?iso-8859-1?Q?Jv5QPWbkgOOaSBEEarG8RzDv/Yaxd35yT74DcTgkpGtW1YP6WEydHIWlYJ?=
 =?iso-8859-1?Q?oG6MRfYJMBb/4aQkG7G/oFCVKuVj093NpDMJ6tHYoxQLFVi/hWPToyZLpM?=
 =?iso-8859-1?Q?i0Yt+AbchERE7vP7nGVkwCoZpkoQX/q2XtCG/PIdVWyvGqofi1RHBtXzR4?=
 =?iso-8859-1?Q?5qB9kP7JcfyEbFCwwVz0/GgqbLp8wlIRm3J5btRFhV2iWlMv7zU84xPbFJ?=
 =?iso-8859-1?Q?xChjgrj4S8zh0BGyenqPIo/SY8CYYXBLCD9AsGAqqgZpblPSYzoq3ErSxH?=
 =?iso-8859-1?Q?DYVBw/ar+1fkYSZWZBz9jmfiEhvtTJ6AD+axYGTtdxkChDOFcFQNgJbYxJ?=
 =?iso-8859-1?Q?sPX4l2QEG6Gz4Lxwvs/tV90CV56AkgBT5wIwTJZd+9kyDXnNjuYJU66Mq9?=
 =?iso-8859-1?Q?LTLnzuDOtgiTmSpJQh81/wBQfuxtMdlghIJS03mw+0bEderNDJS+tme8j/?=
 =?iso-8859-1?Q?NwTvoFrUVwQaWO/c5Nkt8s3VjyfhDLrjNzt1jw5GD1gPZ9TPnK3AHyPnKF?=
 =?iso-8859-1?Q?nCIsxHK/ZSKcr+4W7iOQCehkF65gIxOipZHGrOjlIWrE+ljSK2pwO7lzLv?=
 =?iso-8859-1?Q?4EgNQh0mUIj6KMxa6VMwk2jp63AfynYF3JcdEm+s/vuyizj0pCYicKSU9L?=
 =?iso-8859-1?Q?Av5D0aWAM06bQHQSaDT9BZ7eBezAOboXEkoLD0FFH94fY2hTS484Q4TBhb?=
 =?iso-8859-1?Q?GE9pDid2MVuM/MfcdyN5mm7L7dt0YH8ZoNBHSRYUxu3TIiV5x9/Sh8z3BZ?=
 =?iso-8859-1?Q?gxkO0h9BKEaaFXxPLglcYf21LL4NPJS29jUItWwjM4YH6Xkai32UhPw0Nu?=
 =?iso-8859-1?Q?j4H4aBkOz2363faOaQzIgj9ig8pOKEuNr1O+TkYINNa1iwhdoFMgh5eYK8?=
 =?iso-8859-1?Q?jpQe6oqyGJ8m+4lxfjhqR5DAtpgb8+k6tfbXE555jr3HtQV4Kq0dQG8U1o?=
 =?iso-8859-1?Q?lhzy4cT+fTHvQ96eCG2PFWLh02lf1hriPYyWV8M62nbT08qa8fmYr/pQ57?=
 =?iso-8859-1?Q?hcFP7rZd3uItbA+olIQt5Vn7UJ/84MmMA+rB/+VHGdvCF6pOA0NZZyXlDd?=
 =?iso-8859-1?Q?9G3VBQqQIlNYhvhXDBZ6CwbWG0ib7bQpAsBg3E8FEJXFtOnKRJo3WNgxkv?=
 =?iso-8859-1?Q?+pvH0D2YuSPSPHLZRPmeDeon7P5pbKv84FoaMoFBKxSO7hLlpdllkF4Tgu?=
 =?iso-8859-1?Q?5aChXRG9hTVaSf+zBaIZjad8wKLMXT/9P9E6a0qLa5NXuviFF8kZL8s89f?=
 =?iso-8859-1?Q?b2V+MyUFO5uZ0v9dVm23CbpYXOAvxL36C010IT4XX5YV9dMOxqQwOMkweJ?=
 =?iso-8859-1?Q?gklTLxHAGWHmhONk9AnbZUgrGB2jbfeRH+jqOQIXjwvG7kOHQz7/DI6edd?=
 =?iso-8859-1?Q?W1YHObC0vsyxvQ7L3reYsXLt7pl41Kc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a97578-ff1b-45d4-8f40-08de5a7341e2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 11:33:40.8727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukNBZb85MTaUjEx24/JizE4MD0kwepmGM+nWcNctHV6+R9SL5FtRuHUgWGYEOjyifAsYOg/uFxJMBkvVGaNlFXCkNaiwqhXTh0lfIVcdWIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6944
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

On Wed, Jan 14, 2026 at 04:31:31PM +0100, Morten Brørup wrote:
> > > If I'm not mistaken, the mbuf library is not a barrier for fast-
> > freeing
> > > segmented packet mbufs, and thus fast-free of jumbo frames is
> > possible.
> > >
> > > We need a driver developer to confirm that my suggested approach -
> > > resetting the mbuf fields, incl. 'm->nb_segs' and 'm->next', when
> > > preparing the Tx descriptor - is viable.
> > >
> > Excellent analysis, Morten. If I get a chance some time this release
> > cycle,
> > I will try implementing this change in our drivers, see if any
> > difference
> > is made.
> 
> Bruce,
> 
> Have you had a chance to look into the driver change requirements?
> If not, could you please try scratching the surface, to build a gut feeling.
> 
Prototype implementation done and posted as a patch to this thread[1]. (It
applies on top of my "combine multiple Intel scalar Tx paths" patchset[2]).

The logic is not terribly complicated, and running a quick perf test with
scattered Tx enabled (to force use of scalar path, this optimization
doesn't apply to vector path*) shows a small perf increase from it using
testpmd iofwd.

/Bruce

[1] https://patches.dpdk.org/project/dpdk/patch/20260123112032.2174361-1-bruce.richardson@intel.com/
[2] https://patches.dpdk.org/project/dpdk/list/?series=37033

* Vector path already has support for fast-free, and disallows use of
  scattered packets, so there is nothing to optimize for here.
