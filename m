Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABEEF4198C
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 09:54:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 181F940611;
	Wed, 15 Apr 2026 11:54:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 169B14042F
 for <dev@dpdk.org>; Wed, 15 Apr 2026 11:54:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776246851; x=1807782851;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=iM42gmc+o8239i8vKW84HO4/AQRGqIoD+F7oBKG3VDg=;
 b=VGZszk5aX36xI3WPshpXUCse69vKlY7aLwYcSzooXeeh/eqlgik5WRSK
 rvpmE2k32rFIq/N5Y72gAz1zXwxWP+GXsnv/moEs26nKjrzImY076D6H8
 xtaEqjWlhNABQQroZOZEGUkhiH8RQcp+Rt/kaRfdL7lvnenRvcamt2DD3
 oQAmLLIhQiv6XL2ua9585k6sC3y+uxA55cIzvwJEpVECYO2lwe/SiYI+I
 4xZtJG3SgScLkaJhbaPVdIhyvwjqDuLEmKSX8WEoBr0b1M4k4CkGsJhYX
 /TQO5HDhI08vbVAvOts9w3PCBFXsTn6h3q7eubcK3QzVY31E+/XOIAQWt Q==;
X-CSE-ConnectionGUID: Hb0H/GywQ7S67Q6spNah8w==
X-CSE-MsgGUID: pcZx5qTfRk+KUDTD+a3BhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="87842434"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="87842434"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 02:54:10 -0700
X-CSE-ConnectionGUID: 7Oec5z5qQlqip7tOnn2/uA==
X-CSE-MsgGUID: ObfjUZ7JTJKxU3X3YA1XiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="223876245"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 02:54:09 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 02:54:09 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 15 Apr 2026 02:54:09 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 02:54:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfMAUp7iuMM2w7Wox5IB6PDeVoP/4B+K2BceW6yd4q+OF6nEGqae/dwOWaFq5JAiOdJMJtstXDeBkFMgN1wmHKd8FBzoqvzwuFa8xAoCgxcfKeMst1u4WClLiA+cQ+/uWjD6fVxOPFaUiRH9SkgOWf2hPg9RJNyXOj5tAenwyxP/9RUQC2uu4OazDjui/ljrBJTgEwem4sVmoIpgmQ7HU2lhveYGSPT4kZHL0m6GIT92lZzXwNziDvgULvSADwWM4eSiqO/MctJzCa5gB3ceARbLfKUV+b/ilL4JWmTNwQ+uItJlrbDW48BtVBYzZMqtfzYNkdeobRGVRGacarsc/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNeKAwSMtRWGroLdXcse4VPRxHMILVchAxfK7lSyfsk=;
 b=DURkzO6A5joInxnNWd34ZgG7TBCe1nr8CI8E64FugK22jVr4LFgOHd5ZEC5m2E5ZFrAjNquRZOZwQhiseaK/QP0kOpzVPkMDuJfRuNa3qOerpHVaBLTkaTyi0WdEk5AcNfjYXcnv3ERLiotkUviEsZnTaeQw9ubI+0DeyAi42wuix25HEt4Ze3+4YZqGhILK+3WE2quLmGficE9QyO7H3XOOaxjphdJtxvUQvX+wkjWeU6Mt4FBEGq8r4SL4vxv74XsdfiFd90Okpo4dHuQDezAfhTQugiETkWFL1Ydcrr95SwwBOREgblO06cWZrG1nAYH3eZcvrqj3IIdXhffTQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB6245.namprd11.prod.outlook.com (2603:10b6:8:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 09:54:04 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 09:54:04 +0000
Date: Wed, 15 Apr 2026 10:53:57 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>, Robin Jarry
 <rjarry@redhat.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, Maxime Leroy
 <maxime@leroys.fr>, Kevin Traynor <ktraynor@redhat.com>, Chengwen Feng
 <fengchengwen@huawei.com>, Parav Pandit <parav@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
 <nikhil.agarwal@amd.com>, Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia
 <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>, Long Li
 <longli@microsoft.com>, Wei Hu <weh@microsoft.com>, Kevin Laatz
 <kevin.laatz@intel.com>
Subject: Re: [PATCH v3 6/7] bus: factorize device selection
Message-ID: <ad9gNaoYkXn5Zoj8@bricha3-mobl1.ger.corp.intel.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260407115211.1903623-1-david.marchand@redhat.com>
 <20260407115211.1903623-7-david.marchand@redhat.com>
 <24331929.6Emhk5qWAg@thomas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <24331929.6Emhk5qWAg@thomas>
X-ClientProxiedBy: DUZPR01CA0073.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: f9357087-d68e-4183-6d6f-08de9ad4ed72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: v1SpsbLEFbg400ITleztvVLjej4JkMGrjFpPVou5uL5sGpoO6MUXwvSr73BmJMvE80oP9APS97c9bVVvRx46qthy9PqEE6VllnpOMK9XMTBucqYGuDbGhbF3XdVW9WPhhK9j+bUs9i+OE22GHBO2A+VF5AzX2yxJdgJn/RRCVxrvWozYczRiaormP6CDF8SaIenLqWN72Qhe7IX4sZfE9CeQy8tPmYXfYeVC5vQ7H2SkGdzWEm5nrDwvgsxA/kDi5XZTzgW3qX2M+jrw9l7HkmqHp60Q9aXRqIkKjJ+w3mh1QdE2zz/Mg7uNw4av0v9FUiIt29zcg8aGkwDz0Fp662snGBoJPJwoESMIS8G4R8x2pIZQyGOUWLv89STlgtQUB0tQ8A3QyImJGu+cmPm07RNRjKsrip17UJ96T6g3no7PY+VazkgAqxkx2KFIPys/oU9wu5yOdhlRVSm8NaIIIil1rKtYcaOfvDpOC2attIGp4tsq68Nkkq7VTL5qPY4rpLTz52VChc4WRzPpgpQmWoqZbZSJwHl2vwR/9C/3A9kUx2FyaRxoFsUvhjSXKUhyNxZz7hcXTck3BllCyhl5Dv4uzPwSNtNDISXQ2LDEK1npT5BJhStIgjzTBqk1gwcW4POXwLCoVlFns02QxUddirelRGextqAUOG7cEmh+2dX9nO7duSwjEZNX4++nk/McjvefPQLQSm3ciNmxKySIkiCIC96Z1Dfi5uRhectrDZw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8pm3Jk6LTFzooy8zHF3nHYaVLlWmgCpb9h8aw1qOahpf+KqvLjarXRFN+hz6?=
 =?us-ascii?Q?/EIvhNAUIa5e1irjP261yFM8JSDTINa0P+c/WbIyNJwp6huQ9g/4T7E0R7ww?=
 =?us-ascii?Q?s7GFSEupTBNAn+QDZW+xJLjERg8iTE4mK15pamOEvRNA1qn8ZVHuPTPyQs0G?=
 =?us-ascii?Q?TRl6P4s6H9S7LBsPbQM697LSq8VdptGg6hXAmuvR5Uyk0UdeqJ/G87G3PGhE?=
 =?us-ascii?Q?Np9lYe4jUY717GPmRWc2xEvSakSGZF+6V+Ug1muS5BfdPNt+Y9D3U/5oP9iw?=
 =?us-ascii?Q?+fxXmETYe/aN+O8xlJwRYmcrz9da4v2Pf+2+JKoctDvm2mohLzQMCHBSVctY?=
 =?us-ascii?Q?gzI+FVFUyuWS72ZzvUXdgrTtvuEjCxEm5cEwfUrsdbulg7N7/kU8xmOHkHRY?=
 =?us-ascii?Q?75z1oclAlb7UcyNXwG/9lM3QwzPyN5cCXsWqdEXHOeUYa1djxQBLhGtpKykD?=
 =?us-ascii?Q?9sKS7tDcr9LW7nETKinJ6ykuR+wsalVgFJ8qzhFmqO408ibVwmxqYrmxbnpT?=
 =?us-ascii?Q?rVcnHQ00uefbjj+53W7FyauyG8tzDFByDPMa9K7VoAsJV60Ht/nQTkwxN+2D?=
 =?us-ascii?Q?OiGkGYdaCNTA6XIkS1rqicpglLsBtFmmIO6LsJA4Z7U7S7NNCaFXbJb4zgRr?=
 =?us-ascii?Q?3El37HfVSJe4ghybkDcqsrXIYLLpH+To5hwZqkwXp7OsTuxtHI2leLDZUBzS?=
 =?us-ascii?Q?cgzWJTvVpNy5jrWXg0WKeOfE3+gFsIFrPXg5dMvFQiwpboBwKWMx/pSiX4aX?=
 =?us-ascii?Q?QM+38tSd3SpdE2waUY2wv5G/KJ9DVvYYR2C/vk4GLlfstPLjp6iE+MYM8ju9?=
 =?us-ascii?Q?9NruLu0INAIcI17AdZhLf9ltCRri4IRebbdGmUlSW3uCuTgdNQFPwnhLdI+G?=
 =?us-ascii?Q?QV3gmVFvEf7ArvscMtDXrsMeT+XPde2ebGkEwFzqAVVyaudAT0KIVw/aQzPi?=
 =?us-ascii?Q?+86cn/5vhsGYlgKUoe+ShFJLeTwbzeRpiNFJwHZeng124WyU8ZjSO5dGTrAS?=
 =?us-ascii?Q?fNDnZi9vJeu8dXkj/1fIbF5N4xeST0W4mQgDxRluDmJffcgtZrZjPFTniBoe?=
 =?us-ascii?Q?NT11/9cYkNvEMWEaLAo7JCZUo/p+Ex1ItENgmEjJ/8clSjftZnwktMcIQkHf?=
 =?us-ascii?Q?CFwYR7wfkqK18ejL5loy00vhf2T7xeXk16an0e+hkgzVfANC3R9pveNh9dK1?=
 =?us-ascii?Q?AsqB7ycIriG41dZQtNU3LmVAWcgCTUTmMLJJJT5uAOW2ggdFeKqp86hnODiJ?=
 =?us-ascii?Q?YnnKpgLrpKL/N3DupzanPShBowVOQ8g6isYak3iZZdrgCLIyLk3kzQxlT5Ww?=
 =?us-ascii?Q?Cqqq7yFaM95H+p18Csuua5T6HSmbPsPmJ8GSUF6caXg0mqMMCK0w/0/z6M8D?=
 =?us-ascii?Q?UDA595QRbAlBYRkBWJa12FLSmTCQqD6Ewhk3cEQSYVbmjjYdm8sYnav/Up0e?=
 =?us-ascii?Q?I9uTpamdnT9Y1g2x7SvkH5ja0/wdq6elEyaW5mowN2pzPJ6Z1wKqB5iGJLJq?=
 =?us-ascii?Q?PLmOyABDFjncs8DVUxK+cVZp3P0Qrw3dizKWMdYoivbxhKYfgAFqgdIss2u3?=
 =?us-ascii?Q?00QhNHv7RITARqH4gby42n7wQ3CRUw9GnQ2VbS7TycUkHvllMSKfjVz38qDd?=
 =?us-ascii?Q?y8dndk9b+kPwMfPgl2U7Q2TTT3CFlLrHdsdQ6w04l6JolwfbMQKb7II7G9QP?=
 =?us-ascii?Q?tp/PZEwfv+eeKxY2gwMkf38E1nlYeqPlS5Uys0st3VjWbuBgteNwUJgyHmmv?=
 =?us-ascii?Q?asrII7ybwzHOsH8chWySxxohiDvVkP0=3D?=
X-Exchange-RoutingPolicyChecked: fxOMleqHF8Oyw3KoP7ZrelHzZJ4Nd9OxKOsZfneQXAWJKc3OS4+Q8KujKMEa8cGw2PTG2+SaSrZFnMpmkB4V8b5rPq/YpPFpzEjcCkxUuYU3NHhIi8Y43FwWxxiHCyt8M3zLeadi1gAIEu1u2sXwd3lApZUNAUNTZOEoDZ/il4YGTcDNj/g1jFhqtNMK5UPLJT9aQzCoskUVn+WRVGQnA3WEtlwA7JmmQdIgDYC5qGzBjZRi7GmtHXdsp8hQUlQu/McyiPr+xZPPc7bG6ZddnQVHcv9HZSXwrc64ThEp4TIUre3pWeLwY+si/SmIo7tNyo7eOeH1lMpIt8yICLK0VA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f9357087-d68e-4183-6d6f-08de9ad4ed72
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 09:54:04.3519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1A+ZALDsMlxp6R3wNSjBMtpj5TTlHVivoMWnykf1AATlW6CNNetwSIkdGJMk0bJUwtYGAWCpEzhJs8NdUFGLhpKQhx5qsdXAmxLkqlzB6NI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6245
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

On Mon, Apr 13, 2026 at 09:30:36PM +0200, Thomas Monjalon wrote:
> 07/04/2026 13:52, David Marchand:
> > All buses (thankfully) implement the same logic when it comes to
> > selecting the devices to probe based on -a/-b options.
> > As we want to adjust how devices are selected, provide a common helper
> > in EAL and use it in the buses.
> 
> [...]
> > +/**
> > + * Indicate if a device should be skipped during probing of a bus.
> > + */
> > +__rte_internal
> > +bool rte_bus_is_ignored_device(const struct rte_bus *bus, const char *dev_name);
> 
> Name suggestion:
> rte_bus_device_is_ignored looks easier to read
> 
> Actually it is ignored only when probing the bus.
> What about rte_bus_device_is_ignored_on_probing? Too long?
> 
"rte_bus_ignore_dev_on_probe"?
