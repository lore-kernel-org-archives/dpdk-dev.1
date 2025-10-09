Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C50CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 16:10:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D92B402A0;
	Thu,  9 Oct 2025 18:10:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id EF7A440267
 for <dev@dpdk.org>; Thu,  9 Oct 2025 18:10:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760026225; x=1791562225;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=h1Xp3GchUEMNiXN6S9HEOe7zW6UgjfUE+ljylp29LrM=;
 b=XSvQQHXB0GZ0wLG1xZzKqBvgWCz6ghswgVOnazCrX8J5bh96XekoIxJB
 rnIiJTmoi8l43rIBy+NqXoeC2NaPbWI6Jb5ucO+ZYGWVQPizTCv6s761f
 E9AjIOVBji+ARG1XkjKNXMc+WT3QCEElqAhATV2yFg5FmSwQWtK/9HApm
 y20iwT9dqExSIcI6X3MaAfDrWHShFAh4PnmjXIMAQlQ7nOtdryiJzyfag
 gHrMT3MmEY6166hNO2nd9IKRdFOMqM+p5QdopkOCkyoLvqkUzwjIGd1Ha
 POd6BLpbGtpcoIhrH+x3uqoqA634cl12JST4fP4QvgWaX0rA8ZG07EBY+ w==;
X-CSE-ConnectionGUID: IIe9g6CdQa+xarvuM+XXrQ==
X-CSE-MsgGUID: fuIq5IALQMW0nkohhPrrNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="62282560"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="62282560"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 09:10:21 -0700
X-CSE-ConnectionGUID: 0bCeLyd0SqW1CAmnd7wfRw==
X-CSE-MsgGUID: uu/unQ7xQiGEtJ7+uUH4aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="179862028"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 09:10:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 09:10:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 09:10:18 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.62) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 09:10:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McDazlGgzReun8H9JDQ9uagAKTX3Wz6Eg9S6pSeT8nOJx72aOkTBxT8IY0Tu7WNBF9XT3QXCJ+8WZdOPRmku0yiN3SUcIeFV/+LMAhj2CtKHqeaOKB4EkNCQngL4ntxWTWh/Si3TGJsQTjANzoqE4ZDIdVrD2vGqov5kiM3y+C2rdpsCc//2/CCMTul0o43NHIL15goAlEvpqhhppx+q8IogR/Kwbey2MnDqLQ2HiOys+irWhX0xXVvy2Uonr1wgknG128tHunaFmOLXnZH7bmkty7xrX2Z745s+xnSNIU4ADUUQgHoosduapGyGX07uZ1H2mx2FEBFgbfXSI8zTJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MexToeDb/iTBRIyM3gnLLQk6IBIoC/BSXRbWz/BO7uI=;
 b=Ax/zID+yI0+8gI6MvXd5TBbn2DdWlMu1ZDKJQe6/IsiAsB4HsCxEHK9Mz9o+xTcGZeXEOfByBkjnzjNK6Z5NF+OJ2uxsOn3g7tkrSqiXQyhxfcO+Yx4stvuR9r86W92miQKbTViS0emnsPnAvXDgJ9kXV/7u5pxp4RAkTGRsRWtgI8UhUgpU7ZYbBMAzXTgILyviQmxQKLlCo7rnmxvMfYQPdLNRh/8eGAeo6Mzx9L7C2QxJcLeZ+p1RJD5J809JOYE/XUkeQbDYf0IBHxXeZKfXYQp/hTQVbYO5jqYimCa+LQzox79DXZTst0WB801lCWth1+1jaCWENlWoqSFe5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB7660.namprd11.prod.outlook.com (2603:10b6:510:26f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 16:10:14 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 16:10:14 +0000
Date: Thu, 9 Oct 2025 17:10:10 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Venkatesh Vemula <venkatesh.vemula@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <shaiq.wani@intel.com>
Subject: Re: [PATCH v6] net/intel: add IDPF PCI class ID support
Message-ID: <aOfeYt5kMus0F7Gg@bricha3-mobl1.ger.corp.intel.com>
References: <20250919145125.113028-1-venkatesh.vemula@intel.com>
 <20251006181239.362664-1-venkatesh.vemula@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251006181239.362664-1-venkatesh.vemula@intel.com>
X-ClientProxiedBy: DUZPR01CA0215.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB7660:EE_
X-MS-Office365-Filtering-Correlation-Id: af1a62fa-f752-4c74-7e75-08de074e54d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zPOeGx5gY/urxxyIjb5Bm7T19N4wtUPX6K8sPSUJD2OqXiSD8Ku47SrR599Y?=
 =?us-ascii?Q?gpOTT6H8xR2t6k/tQk42BDSdTf7/EPV/W0fuj073HuL0WIrV1Fe3N2ngbWDQ?=
 =?us-ascii?Q?9CyQ5//G5TRrQQOhsB6RoMeNUxQO2uxLqrOGP33Ru0WBs5rMhhLLjXlsrnyI?=
 =?us-ascii?Q?LiWOLXOLBOssTmCHKQiHWe6adGaEO9cwo5f6lFK0o9NAYMweF8w9CJJblXiZ?=
 =?us-ascii?Q?6CZLZRCaqnKzz3UqG2UOkqGVswWPB1q/I9LeO4S89Mtw0FW9rX3rSbgBIN0y?=
 =?us-ascii?Q?HR/U4aEdB6eqtvURyIYUuFs3K/gVKMIabWS1LdOiolwJ6JjWomhR3CVglsg4?=
 =?us-ascii?Q?B52XFpyxv1rnwRNB7j+rToDO82nO9EboPxunFpT5qxPr3sZ/Qk8PtBj0Jy3B?=
 =?us-ascii?Q?XLDWADfhRie2eQZCfjWUpZy7ADMW+rCNP2ooaEI+ygleClJWhcJEVC4p/GH5?=
 =?us-ascii?Q?mCthOZO58B+Xgx7vghMdiig4WVaDNvPKTr2Ng6gHd9TdhCCYZ/qPb9OukMQ5?=
 =?us-ascii?Q?oYX7L9zTnASH5yYfx0MyL5TszLQ7ErWnlcPsFhbPiOL3t/DGHV9UQ9Ei7ya5?=
 =?us-ascii?Q?CLExJ8oDXaaT0mWeVVxCttIcHg1ArdZf+NRLcgdXkJsREViIDnd1xFPZiJNW?=
 =?us-ascii?Q?iSgB/6PbG08/laswYH2EdNqY1a0PoQEi2Oju56bWDJ+hwezeCFRi9ly0UTrY?=
 =?us-ascii?Q?xeuaYxD5iLN8dZkVjDdOl1ABy2FJ7j+HXQ+V6LD7g18PP1/KXQphf3xnaySt?=
 =?us-ascii?Q?CI9q+c65cQm1ssEUbH6HMI8snOpVcovB0+9D3HWkuxA/HXOcMPpZJmoFoMPm?=
 =?us-ascii?Q?NK5vEPZedjALgL9r/lD7/xcWA/fO5/oX8HE8ZIQI1FZ+BlAHnPGsE22PTr6y?=
 =?us-ascii?Q?y1llD5abKgfojrCoILTo+0YMRB+Pr2rOpsvVSTnYqpx5feLbqCf90lxhgdMw?=
 =?us-ascii?Q?ecvqvuwDQQd3tcAYoUDTqQL3rR0HXG1cZpOCfVqGHicn+wITU5M7EKlliWyD?=
 =?us-ascii?Q?3Y7U/UzUTOdvmsmbvvbSbrw8BUf7KrwtqHvlRhxb6INuoiKJW5Fu3RnhRmdw?=
 =?us-ascii?Q?BMMJu4fA52yadl/AJwXnzA/ZC9VwgGfzFon2j2q61PULwoz1bsIRaOioubzX?=
 =?us-ascii?Q?Ksts6FV3GYjYAkemuw5let8M4f/Tm3PMgNk4XrWXYDBaTAdeUiWdr4lzXgNZ?=
 =?us-ascii?Q?9U7KUSe+I38RM+7g5eAhPlU2/l58Eau9JPigCJZW9tUzWgXB1UvnedmdAmcI?=
 =?us-ascii?Q?AYFBZURlUY/HgwF9+mOLrqhlgF1SJibPfI19nwxqFDgCLqvq/0O/g/a2YJZH?=
 =?us-ascii?Q?pG0qSSjv7BdG9Vo6wbnNJTkpde/esPTZXX+Abi31mvv//gzGvA4dCQ8UKrSr?=
 =?us-ascii?Q?wWU2Z+RYmwmUJI/1prrUaDoda7/Shk+amDC9Mkb6yW4jXArGJV6paxGl+EOx?=
 =?us-ascii?Q?tPj9advsXp6c+ZkM3B5BtXTze2T21uRg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NaSkMF7BibSdhMEAs6Xs1144PlupQKWTTVEJ4/uNlYE6KTXVfMrbjWjEIzf+?=
 =?us-ascii?Q?Id8cpA3MsPonrZcIumld1y6vuA8oVZOYxEGHsjCovD/uOi+pxg3c1PaVEz/J?=
 =?us-ascii?Q?YLd3iMI+Ur8XXt+xlJOM2njlfNOy14SvkGxkPjeYgCXHNOAk+Nq5sSS1Mwgz?=
 =?us-ascii?Q?/1k/GdBdCPAwzC5Xyyi6XjFUskbARl9Q4I+juAUate0BQ6MjFQG5O0KiArbN?=
 =?us-ascii?Q?B/iC2+7eYe54/Lc8Snj/o26jPsmLMECjkZ8u+/Myo88DWzrZuki/iNtDPwJS?=
 =?us-ascii?Q?ImveClrA9tdSKcnnZHruH2nhi94yaPS3ozLVKDyVjRP7nL/8HBLpwPWC0a97?=
 =?us-ascii?Q?U/t3onqEi78DUeCcNhuwwtAMHIfoYyz5JgwMrj/UnheDCLjhUWCWPKckZMp3?=
 =?us-ascii?Q?H6iU8Xu8WhKiyTiXnNAHIT9VNXlxb6dMT9zHQxwSOjtaViye/mNaONk/zXJW?=
 =?us-ascii?Q?0o9LM0b/OFyXqk6V/KczBlIHWHPYXAZEcXHhL73O5NpRWO0lJGDqMW+PHnt8?=
 =?us-ascii?Q?CQFwpuLpxSoR74JlBg4FbOXO61GZ76WdzeTIFV03WeptIK/hnR583C7APygU?=
 =?us-ascii?Q?ae2T8EEMRUMf/HjfTj/vL5PwPrgGIO64g51i3uVWh+hBR8sldOj+0Gwztsrl?=
 =?us-ascii?Q?k8C6hSIKhZp1Fmxt56YGqwmOfWFDuyH8JMaz0gvh6Q2Ov8QHNNvV04j5/Gsh?=
 =?us-ascii?Q?TRIc2dwKIuGuLl4NruLM0p/uRFarVHjtgErnWtVYrziOIaMONuo1Ip+kQAsF?=
 =?us-ascii?Q?ICy0zyrhdhIjSDAPq2C6xHZbD3bgfeu9B1JIybWYP2Uq7DjmsoRPo1TSTMYA?=
 =?us-ascii?Q?/ppzkoGgjlOImLjejenl6RwTNnJ+AXVzM5dq3SwfY25ZUOfbMRSR54cZ058G?=
 =?us-ascii?Q?y//2K2bYZNYo1xtrfWV80sZyR7+ZVwUE6jNcZKI2tOaOSCuaUOvwn0BNPvm3?=
 =?us-ascii?Q?wT8akvTPEmcpVYK3hDkDyK04s62kxyYHxHhCTuQ//AF5qnlP3Y0xqmpzuvDt?=
 =?us-ascii?Q?vK4gSxfv7pBGxc9c/t+Ld1uE4AiPMUcCkSdBFuCR+iYXepPUHK9yAsFunopK?=
 =?us-ascii?Q?/QLRZnW1LuZTRw9QoBuORfhyXfRhYhBldnvguxafAxyIPcV1vHMGY3VQtdID?=
 =?us-ascii?Q?l+elE1fp7dYqJAz12vlrry3ijIfIL+cY2gcKJjLjEuMJNSi0T/jk2qDb9Ri4?=
 =?us-ascii?Q?c8oNaO0oBnDP+r3HbsiMA691vTo5ByL2hYRCwL/AxBTtQ9GuvoAVIQYNNEQ4?=
 =?us-ascii?Q?sp4T0VUcNlyjvYpEcduMfF71rbs0QHwSCgIj4TM3BG84HOP/0CzICadVmtjN?=
 =?us-ascii?Q?A5HIc8nbPfi2gn/tBo2aAfYwiXn87p6/Fjfb1ulv2DKNwVjybDujhNg+ebwJ?=
 =?us-ascii?Q?JLFd9X8mNEBhM0eyNfXwuHKNRUIzQU82EfVcis3B2KYW+AdHKEhX/TrZqVfV?=
 =?us-ascii?Q?jMe/v6xykWWjPgmWpbcZVRaKjlgNU81ly98vsr3IUx9FKZZjhNQelHqPFPlN?=
 =?us-ascii?Q?I2THQmPTKvVZxBw4W0wRX5HOat0UDQ7jHp3vutd67q1PJSTyLzzJHVDBgsWp?=
 =?us-ascii?Q?ceBafwlMeSNWJ6Z3cggKkisnEpAsx9R1YJrHLKUzVY010IQ8VFnjbLUsuKg9?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af1a62fa-f752-4c74-7e75-08de074e54d8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 16:10:14.7106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qj1LQZZWXOLGiFHBRU4vWC5fNY0ALLB7bfLBoYb8wwnOqFQXuLqScnCp4lxP5oZuDFxRKBxKR2tOMvE3gURk74Jl+a9+LwdlmKE1xleXFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7660
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

On Mon, Oct 06, 2025 at 11:42:39PM +0530, Venkatesh Vemula wrote:
> Current IDPF supports only the MEV device IDs. MMG has new set of
> device IDs and same might be the case for the future devices. Instead
> of adding new device IDs every time, make use of the IDPF PCI class
> ID(0x20001) to differentiate between PF and VF.
> 
> Write and read the VF_ARQBAL register to find if the current device is
> a PF or a VF.
> 
> Signed-off-by: Venkatesh Vemula <venkatesh.vemula@intel.com>
> ---

Sorry for the late feedback here, but a question: Would this be better as
two patches rather than just one? It seems there are two changes here - one
to cpfl just adding a new device id for the driver to use, and a second,
seeming unrelated change, to idpf to identify PF vs VF. The new defines
used in CPFL are not used (unless I missing something) in IDPF driver and
vice versa, meaning the two changes seem distinct?

/Bruce

