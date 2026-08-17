Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86589C5B572
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 14:47:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E85640269;
	Mon, 17 Aug 2026 16:47:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 0D6464021F
 for <dev@dpdk.org>; Mon, 17 Aug 2026 16:47:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786978059; x=1818514059;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=UXu+gWhLpbiL9Ml3GD9oS4m6hnVL1w43myg3O1mslPg=;
 b=BtwA0th1aRmOfSCDsYDBmB3Q5+Ymsfj+0d4SxqVP0iq0aO8wsOky/WiC
 phcD1XPrBagteo+X+stFl5g6T1TMlgusp1BMTKqA0OgOvoZk9cOWNw3x8
 BqiGjadC9R4Hn3UbtIwDGV6mxEkqzORLb/BaS/EDEBZxBXEyNFYuUSIhn
 YY/Sw6DuO0JIP4jOamHELrJDgl+laK8vwqzOi0mGpfYFpZUS/xtcTDtWT
 5yWQ4rLmVKiPdyXU5D9Gy3uD+IaRP8GRHTY5K6fC0+UP5ePMvD3YqY6mJ
 7th39tVccYoRCLBNu6uPeDQh4dTGxLuSsuajzjDuvJHmCgkQ8J6xB2ZUZ w==;
X-CSE-ConnectionGUID: mW6V+MqJSSqyarQCi9Wp4Q==
X-CSE-MsgGUID: JxlhvAkfSH6RVWm/pS9YUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87331948"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="87331948"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 07:47:38 -0700
X-CSE-ConnectionGUID: o6AkeyfORPyHd8dmMeroVw==
X-CSE-MsgGUID: PtYDOFhbQqqceZfUMam+Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="261192188"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 07:47:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 07:47:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 07:47:36 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 07:47:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TdansDCS2QnDRrxm4W2PK4mZHGqm7x/7HgDvSaUry1mg2eRgY/6TjyDVhTXPZ4SVLmDp3gj9uVenULgK3k5aM15jH0OfX+BsSCFD6Jmzto9TKsBxXSJGL/R2BnCbs47YC0rcEV5NDhumie9YCg2rjWccpB8pHeVD8ReSS/C4LD2dRHDrk3nK5wxUDqksrlW/O6L0BZPWYtct+l69c7sxF+BH+/0nCwgw3OEdSUFX43LjvHGxYzLCN5HDOGeIhw7viaDT4KGXbNTE+96yq4JiqIHUtexD0FSzqFHaEstt+CvshHZNqfoJwHHbVxUgq1HACDNm2gaMcz9HbUKcuYQrfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=patqA87wKzwyVPS/bpQeOec/UQmWqhybdBQg2eRAIAk=;
 b=efu6OqXN1kQPvFkToEEC0YPpYPzDSdluXaVFocknqxhR1UjkZ/ogoGiGU9OPXDyzqOqcALQMs03vArvR8TLMoI/UkhoS9PWnyC2ZAjGY10d3nhyLTHOjhJycl9bOrRLPStFAKD20X8xIS8Sfs39hyhLpxgaYxCfTCzdgY8j8MufEALIDRfvGFaGN9M1AuWFq93iJezD7oAE8jOFSA0QWqSY6QuQNOptW3+NXgFSWUsnUFuIV+4aEUuu4sFTYHlIXceDGj3sIXzTw5JO9Jv4fhv9hEQgVqjgAl3dQmyb23zvSf3I1BvrWPZI/F57P2IzG0qXU8aABKYiA8ysHAnhYJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by MW3PR11MB4571.namprd11.prod.outlook.com (2603:10b6:303:59::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 14:47:32 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 14:47:31 +0000
Date: Mon, 17 Aug 2026 15:47:24 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Michael Shamis <michaelsh@marvell.com>, Liron Himi
 <lironh@marvell.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>, "Shijith
 Thotton" <sthotton@marvell.com>, Shepard Siegel
 <shepard.siegel@atomicrules.com>, Ed Czeck <ed.czeck@atomicrules.com>, "John
 Miller" <john.miller@atomicrules.com>, Julien Aube <julien_dpdk@jaube.fr>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Andrew Boyer <andrew.boyer@amd.com>, Chaoyong He
 <chaoyong.he@corigine.com>, Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>, Cristian Dumitrescu
 <cristian.dumitrescu@intel.com>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>
Subject: Re: [PATCH v2 00/17] drivers: replace strncpy with strlcpy
Message-ID: <aoMe_H4Vrlo-KY_y@bricha3-mobl1.ger.corp.intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
 <20260624103658.792750-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260624103658.792750-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DU2PR04CA0032.eurprd04.prod.outlook.com
 (2603:10a6:10:234::7) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|MW3PR11MB4571:EE_
X-MS-Office365-Filtering-Correlation-Id: 76db1bae-0169-48d2-5022-08defc6e76ef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|56012099006|10067099003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: BErzyRqL1zFMJaoU5g44XV6JniED1egkY3M4ZhmVgsqBqjp5Y4l/DeyolOl42psqgXT3Ekm7sQw4eIRJU7kWbbYOwzp/6e0rakkMtTSqRiKNwLdAol8cMIlqgMZIhRbaDvTLU9GZAmgA5t5UD2yHAzhH4dUA1KWat1v5G/6y1zTHiFEOfaeTRFHOG1v1lqNGEm+q4ywFxlKK6cCERXz6HV3zXUU5XP8yRAIIPijhnxoGstW/Vcy4wQ0OE8m5B5EUxz8bPFU3Stiy3+I0EwsSramFAFvFsz+XEBjpKC7KB2YnZha/8xIau49wLTQsGHHhXQVuGokN/P0TS3s6+NiTc6Ilwjl1thO9bqJRKBSkC083hvRJsPfYGoPlr0mH/B1zbrpEbxHL34tOe92crUVkHT8d0RBwBxWd30CFwjU+VPxk3DQFs/0irfTjeuYalcHwDcSil8nEP5vTvjcGUuMnlUfkaPSZ+tuAg5AwzKpS7RJgWFDHJ7ZLupyXUVPMAilfF9GDhTRJCivxcZ0gxM6JlEPLy7oMS0W78IQ7+Po5GSejCZJdHxTpUmUgy3rW6vfeCQkCI+vHwImO3M2n3Y8rSsGMBTRaX/j6NTphVoHIB3Ntc4L+kt7HQvDs0DnNODsDHWe7tVbYUVpFK5yN0giAH+foBAbqQ55UQxpEdqfyyQc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0PxoErJbJi9JcJqax9jerTM5Auno67OxGdwwdvTocwQxx7rp0khS+2VLvalo?=
 =?us-ascii?Q?NFveralFNTrDH/oQ7GxciLij5x6lgMS1zYLi4mMjdRLWDmUzNtkc5jy+ISFr?=
 =?us-ascii?Q?r14FZFhfvhWvRzj9NRjKfLD6926ZLHIQOaPVxVoCiswlI3Mj9GHYcZI25+QK?=
 =?us-ascii?Q?kPPq/xtuwzLUaIEMBxMcA2U1dt8KHWrhLj2CLNiaIinvP1d+99A8FM7iBaUk?=
 =?us-ascii?Q?kocjKOxDVVNE3qIof1nyU24V1F8s4adEt1KBvhfVIPdokHzQZ/HS4XsDIxJr?=
 =?us-ascii?Q?PgXPYd8oGiRq3/u9Zu8ynE6vBvOrCg++CTTh6dDk9xf0XRsKp+Sm0Q+JbjWV?=
 =?us-ascii?Q?Yk4OHHExmmHxvG5FyG1tnwvVajGob2qqZC0Y5crclDk/We3OSXyZkPAyJZOJ?=
 =?us-ascii?Q?dWLMieGPRpXhgAzGxs2YXAEP8rEAD4QAAqYEV4H7ckZq0MK0f89jwsBTyV1D?=
 =?us-ascii?Q?ydex54WD/QIpoNYRg0LoB+8rh5LXWHQJgEzM69ZDk38Lvq7QT/IH01ssYwmE?=
 =?us-ascii?Q?8x8ryfUCg3A0WiD/rTswf0Hdb+teMqOlmjE7EB15BbjXVKZAFIZ8DPuhSzDs?=
 =?us-ascii?Q?CoLZkCylHpqMyb7YH8En96DAmyOMc2E572Tq5JDWAZTY/s06f9ExDdSXxYbH?=
 =?us-ascii?Q?EOBY73wPd8aW5/+NmwcDuBlGBXRsnm8gBBjAeYmnD4qFxhPlJY5c8/QAptTf?=
 =?us-ascii?Q?qCzJDThr7NPuXVaTFwjRBu6V/IWUO66xnyu0AyPm3iEW0aXU2/556lJZljye?=
 =?us-ascii?Q?7kAMQPtti7/Z98XcohomXlCx2v4btu6WbM+N63UfrUjSuWo6eph2sX9OLe24?=
 =?us-ascii?Q?DII+h9D59Yaw0fuEGOV4oOrqzOSTrAZOL0szgJ36D4mkO3FCqZlbG30MZYXQ?=
 =?us-ascii?Q?075QgbxGV/LbQdAWxOm5g/F8aRyl1+7oXjPQMnqmtl3kzP3a2VCkPn6rfGq7?=
 =?us-ascii?Q?t0/Y11EGT35ldrFqgXCc6ajMMZBme1PN/3a7iDoSuRtFEw5UmjpX9hpRmR99?=
 =?us-ascii?Q?kQBcUS+k7Tskx1GE0TBlt3qDvEL46rWiST4boZMy16bJsITkAXGlolMMUCe9?=
 =?us-ascii?Q?Nt5izIpLILC2jML91Nfc65vF4cc+Cop8KqvtKl8rI7hU4JdJUBtBwNTE3FCE?=
 =?us-ascii?Q?PFkeStDVWSeFavK0+Bkve9pGBAsXQLP6km2dDH3c7DtWg7ft9UEgDjzjbey2?=
 =?us-ascii?Q?P8/51RCK5bmVBn7CSE79cbyxjEIrBpaf4yDJTFT53oyi3sD7gV2EPFoF6llc?=
 =?us-ascii?Q?iwQbo1ZHqN+/1lhtjZZVlZZfRm7ECYFfBOj3kUDwdgt8X0Ya8tIbDwIvT2IH?=
 =?us-ascii?Q?2FWNNwIX9G992FetdrQWlVkmnNjiqmjHoAL7QE3pIhNyRz1Nt6wpm5ATAwd7?=
 =?us-ascii?Q?z8pidVVTUX+o/EI5mJta2Hpr17qr5FS0VH3wF3bQfIptxnLTb6tRSjGf6bKP?=
 =?us-ascii?Q?vDaFQR+UKq+3KczjrGatGC+15Xol/2efL9QCV8kaxWB2BlHHx6QtEHO/JkuQ?=
 =?us-ascii?Q?zZVDMvaaX2jk5lwlpCYnqxXEFa90s2sZBSFiIt2wDF1cDmMCbZiZRKIM7rar?=
 =?us-ascii?Q?e3h+efKJCa8HFeA8tc4UUJCd8pv34jew4i0ewwbSOa+DDqNGuJMBTzsOcoih?=
 =?us-ascii?Q?YleCvaLDSha2amdvt5D+on/18+ztMZ7j3gbfh9NRt4Mx5/JGBw22VT2AeGnl?=
 =?us-ascii?Q?TMmwnSarelys6hmnBfdXw4m9x/UxRwiZsD2lErvwtibP2gLzvWQI6uvMRpoh?=
 =?us-ascii?Q?Mp/DVrywICfTJkRbPjSEhDXHURYmB9Q=3D?=
X-Exchange-RoutingPolicyChecked: GUcmczSkzkq/bhnayZ+TavRIZHGw7CNKwNhLbsY9THYvs5veqh9i5MrKsPdFP3jeYAGeLqUtbT3wDOsnH0bOWzJMjZ0wD8yntdOuzhLUVgM2u9XI17lUf41aX+kWqroA+xTtu3y5vBVbfpRDVoUMqMbsmr/gMcV91gmnjbyLOBsqw44hg2lWp2NZr1JPLEaibmUN+4iVvFprXiQRE+LggcqqvSShzFEG/6FN+UTLPZqOwGgdDrAzhUucSVl+omlwgu9iNVt3qQ7HKebxwcWdyzn0mo9kYuOR5DRvDgR7jyq+Kich42wBwCfmG7eBkoYgaeao/ceRyP6jnHOzaxnDcA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 76db1bae-0169-48d2-5022-08defc6e76ef
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 14:47:30.8801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfn2PagB+YZP8OO4g/xjyg7d2ct+jMHPsQAV75/VKs1e7h2SKVFwz7zJuw8MWLls6aqYChWJl40JtTlruaqIllyZ8XfCWI+HStPP5JWFCQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4571
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

Driver maintainers, ping for review please!

Thanks,
/Bruce

On Wed, Jun 24, 2026 at 11:36:39AM +0100, Bruce Richardson wrote:
> Many uses of strncpy in DPDK drivers can be directly replaced by
> a call to strlcpy instead, which is safer in that it always null-
> terminates the string. This AI assisted patchset makes those
> simple replacements, adjusting lengths as appropriate.
> 
> After this set, there are still a number of drivers with strncpy calls
> in them, but those are not simple strncpy->strlcpy replacements, so
> left for later rework.
> 
> v2:
> * fix incorrect commit ids for fixlines.
> * fix build errors due to missing rte_string_fns.h header include
> 
> Bruce Richardson (17):
>   common/cnxk: replace strncpy with strlcpy
>   common/mlx5: replace strncpy with strlcpy
>   crypto/mvsam: replace strncpy with strlcpy
>   crypto/scheduler: replace strncpy with strlcpy
>   event/cnxk: replace strncpy with strlcpy
>   net/ark: replace strncpy with strlcpy
>   net/bnx2x: replace strncpy with strlcpy
>   net/cnxk: replace strncpy with strlcpy
>   net/dpaa: replace strncpy with strlcpy
>   net/ionic: replace strncpy with strlcpy
>   net/mlx4: replace strncpy with strlcpy
>   net/mlx5: replace strncpy with strlcpy
>   net/nfp: replace strncpy with strlcpy
>   net/qede: replace strncpy with strlcpy
>   net/softnic: replace strncpy with strlcpy
>   net/vhost: replace strncpy with strlcpy
>   net/virtio: replace strncpy with strlcpy
> 
>  drivers/common/cnxk/roc_model.c                   | 8 ++++----
>  drivers/common/mlx5/linux/mlx5_common_os.c        | 2 +-
>  drivers/crypto/mvsam/rte_mrvl_pmd.c               | 2 +-
>  drivers/crypto/scheduler/scheduler_pmd.c          | 8 ++++----
>  drivers/event/cnxk/cnxk_eventdev_stats.c          | 2 +-
>  drivers/net/ark/ark_ethdev.c                      | 2 +-
>  drivers/net/bnx2x/bnx2x.c                         | 2 +-
>  drivers/net/bnx2x/bnx2x_vfpf.c                    | 2 +-
>  drivers/net/cnxk/cnxk_eswitch.c                   | 4 ++--
>  drivers/net/cnxk/cnxk_rep_msg.c                   | 2 +-
>  drivers/net/dpaa/dpaa_ethdev.c                    | 2 +-
>  drivers/net/ionic/ionic_main.c                    | 4 ++--
>  drivers/net/mlx4/mlx4_ethdev.c                    | 2 +-
>  drivers/net/mlx5/mlx5.c                           | 8 ++++----
>  drivers/net/mlx5/windows/mlx5_ethdev_os.c         | 2 +-
>  drivers/net/nfp/nfpcore/nfp_resource.c            | 2 +-
>  drivers/net/qede/qede_ethdev.c                    | 2 +-
>  drivers/net/softnic/conn.c                        | 6 ++++--
>  drivers/net/vhost/rte_eth_vhost.c                 | 2 +-
>  drivers/net/virtio/virtio_user/vhost_kernel_tap.c | 2 +-
>  20 files changed, 34 insertions(+), 32 deletions(-)
> 
> --
> 2.53.0
> 
