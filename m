Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6633E8537A
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 16:40:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBF1F40296;
	Fri,  3 Apr 2026 18:40:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 09EC44028B
 for <dev@dpdk.org>; Fri,  3 Apr 2026 18:40:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775234448; x=1806770448;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=nMF+QOII19NvAZ+LoR5MEBw0jmskg6aasw37aYvJmcY=;
 b=BUGmC/y3Oxa+eH3rjHO2B6Q7sF/GaHaHrP1VvrOoyvwuE73Mtr9IB6mI
 H1fIPiRzyL5Uhp66/48ne6xjf4qsu0yV13MlaLTC8pTfanH6l2eukJEzx
 DvGSiOT/w0UzLNn0y/JVz2xcD88d2xUgVyvVmYFfqJdr7rKUm6m8+NhiO
 9fumdzBxA71J9idTahZGAcbkT8dyFTFiql+iW8G/elly+Wuqx23etqbeC
 QeMxOte1GBiIxf6Fc31q4gyFaui6izNPUnDRBwufdSq5i5xG3F8paSyQS
 SB/0MAVueD+ksiYTwdfd/p3nNMFbT/Unv3icfFKT9I7AUStkYhkvzbaID A==;
X-CSE-ConnectionGUID: EXfdPRjQRqqcNSDlQpPDWA==
X-CSE-MsgGUID: rpTfbxF2SWCKGWd+bjPLRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="86917749"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; d="scan'208";a="86917749"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 09:40:46 -0700
X-CSE-ConnectionGUID: q8YAMnbfRXOYEMRzfaVfhg==
X-CSE-MsgGUID: A2HPkRpVQ5qNq//nDuurow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; d="scan'208";a="222942205"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 09:40:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 09:40:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 09:40:45 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.61) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 09:40:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUM8phr9lXMe7THzuMS4G1VzCVLcOE6Po2Qyx+GRc52xTFQTs+uGOA2rWnKWybN7a4uVzmp+FQUSZW/zKNOoqKV6v/VFUKqvO0NEP/2VwgxCGQDiRQkGxuHXYw52jJpPMjpPI7skLXIT5zi+RVwGsCsbC6FlnT4PM7GR9eFIULTTIo4FbbO3zHnbRftlaJUY1cHVYX3BMWdQaHIQ96NBYpL0lmGQOyskqnhHldyx01iow6sJccV9qMxjX40kfQPL4tZdNmresl7KybHSJFvm+LXbeAbKXsWui2bvJ1/fisZZQwMFsOlPTCwovEWM8W6yNejCYnKNTGWYo6zUqsKzbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrVexNWgSlnbAz69PGZNy247n5RNMNJp6YIdfW14CkA=;
 b=HB6+m+5guTcG9f7bNcJDIjArz5E0EyzxhVrPHYBns9VBXEPXqxeCb5gaG2jvYWab8MEQeLYnI9AVDwDS5C9QQPW7fN71h0ujXR8D0CYP9L8ELyFBFFuGXYBgdC2T5SUl31fU6RgGiIdeGrtJgxbYcHtAZwYbTL8hYvshXTidpSOVColPPjn7Rwx+i+1B60B8IDYwfEVCUsNmkpq7HO8oYoVBHZ5qiB/k+wBT1VpHB9EvPBuCeoOAzLVD5haOSrh7JSt4l/8DEmYlBLuUioIl0ED3ZlSkL4uXAqO+6jEpfJzGB9hAvDUcyyYYL49p7WZ7qeTxMvCDNqa2+A0fJ/RCpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB7101.namprd11.prod.outlook.com (2603:10b6:303:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 16:40:38 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 16:40:37 +0000
Date: Fri, 3 Apr 2026 17:40:32 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 0/4] net/iavf: improve VF reset resilience
Message-ID: <ac_tgAD-wTTQVcin@bricha3-mobl1.ger.corp.intel.com>
References: <20260331130120.2471971-1-ciara.loftus@intel.com>
 <ac_mBFKgkjqfaP3a@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ac_mBFKgkjqfaP3a@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZP191CA0032.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: 48263601-24ba-48b8-4cc9-08de919fbbc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 5Rtj5PE+rLcaJdbofqcDjzikcMj72ZKLuB+2mytY3nZUY3GytmVJPY82MYAY2EgdVNs4nuORwNZUB2lZq6aASFVK9pn2bGWlOJ/UJJiQQxOCTe96sdNCYSYSKxLSM7u3FPSv2qwv7oh98ljwCGmfl0Vuvpzt1tauO0QiLvQcYhhCK530zW4B/YwmdblxniTAq0zqiCyqrLT/ITa/GagfPfr4dzHdxR/GIaQisZmixYbPk6fwoF7Xs7fUfPjcADQ00NG7daZGyXlbuxcIMtoQFK6LG2OXSGyxhz+vge84Gys7ONEcX7kg2A9D0WNVkvSazf4jRw2x4TLdoSsUNhMDBEcrCDUslrtaVfxn2I+gw/rUHGK/pdct86EyJEoVxpLSs7mVW+VshsoLY+3e2CCPkFxtl94lccOcXcLP47VZLJVB7IvYop37Zo4f/K++4vK5sFQ08MDeQu1RpdDPTRCiu1VONdLJVTWKSl0yDfCz7QwCRkfd9zIyVpTJUuibYbQ93fhoEh7jLz7FKOu6DBHNewWMisqNH3ZOEGbVciHiNH81uex15xrrAF1Ug8dOUtR/ZjfMu/FdWP2YuGGXJ8qPf5VBeOsD2sf+Q1cr+7zq/Zk+FY61Ugbveo8Pr+2XIO1v0hbCbn7kJwCICw1Hds/EF8AlmsE3flv9qMR7JvIzUQgO8SVa7c5QsFpYHsCpU6gt+vsnBfGViswFLKO2T+LuvtSBIqMk3Bk+aWOzyayADIE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fUDzdHKm5rTY/E9Kfb7Okl9WXYFIh4AduM2OaE0MMvNt0AyfAwwZZm0yNckJ?=
 =?us-ascii?Q?SVHJqVT59N42DPxZFxS2EVquMzwZZDf+F6eWmG+w6Hc3bY7NfyzoNYNVZyXs?=
 =?us-ascii?Q?d/SybvACaM9EWK+sF/bMgCwCa1KuCDpGsA90ykwyi3+04Ow93BO6LxpLYVxI?=
 =?us-ascii?Q?zigCvgxDe7cSM/ljhR9+as0kJfqGh3WnlmQSHX483J3nyPi+TbWQvRNlOIPJ?=
 =?us-ascii?Q?SnrVT9xaqar8zHNbxjx4kOyMFVEyER0bqtQx22fxSfMoPRV5YnSIVx5vSA4U?=
 =?us-ascii?Q?B4yBGB/lcFy396dkUth/DJIUqrqmbdD0HSPPY/VeBvlyTXMykfYf+7dZumVp?=
 =?us-ascii?Q?7j+FQL0rzaNnWNwqGA4a9j2nf9lznVP6V+s/ETg1OA8JRF+rjxsUqwPueNZY?=
 =?us-ascii?Q?BNZf4ah9f9o/wv+Zb4xobC3MCHEMkhNtwW4CeOXDgg8PGy9BrDLT+moeUQtq?=
 =?us-ascii?Q?sdKKQrbRJ0ApL/333OhOtIqZOVZ9Uceaw2cScneH94Ej4YYtGNeP+dsohHNw?=
 =?us-ascii?Q?4kzF4MOdAWC2YKAjD7AIl2Zi3YiIrAQLBNSzKquT3tNdlrgEn0HM6HbVsz3J?=
 =?us-ascii?Q?THnd6NPhJG78uFUTegugfUmNI7eAC6jdrsGO3dLboD3UXXJ0B+/yMbJcsB8n?=
 =?us-ascii?Q?+xoncm3v23tdIsm6NQprNQy+z5UMWpqClocvLbONhd8CxK2t/bqDRg1sDj3t?=
 =?us-ascii?Q?SpV1LdwGtqxl9L4/5YhnWjzn5u6U3X0yOiHxlEjrSazHCyXMYVlzM/SBl4sE?=
 =?us-ascii?Q?noK3qsppRtNSd07VlewblKAgxA264ebFS+OLqfXgV1cR3jR3C6gdA52VXlFK?=
 =?us-ascii?Q?4zX/NEY5Y7DHZyZfCtWPZBRaHx0CWbS+Kjg1wQfNp4VMupgXi3q2VbIf/VM5?=
 =?us-ascii?Q?AO0fBPpFGqLuL4PFbvE6fO3Cu8rsPJ2hK2s6FlRS2csLahw6ZBRzBvvwhgq5?=
 =?us-ascii?Q?4Gxk8b/LjhPHv6mp++v2L36BDfxhnO4NUU8LHwLcMZr0mg3rR0hEbWwbsf2f?=
 =?us-ascii?Q?2ow5MoHgrEBWOlpjRcTN/hBzx+URLy+ok4Iy27uFMJraTal/3XG80nlKFhju?=
 =?us-ascii?Q?+5LrqUpKsKkD7PEBjeUXD+eh7akRxnNqB7yP7gFTaWxmMp3xi1J7wjKFHRam?=
 =?us-ascii?Q?GYM3b/xcknS/bulM+YMq6IZ9icr4p2JUzoykI5UhhGg89EwUJ5T6NVnAaJAP?=
 =?us-ascii?Q?bAmOt1eqRseKbl//oD7Md1cQ+Z61Y6hmv+eZzoHIF45E1zaWcXmJ9l6CUnmD?=
 =?us-ascii?Q?w9z2lf9ls6zQt1KskgrGFE37du3xpJZymhUbw9zMli6cnSPlfU9cEg/WvcuI?=
 =?us-ascii?Q?6A0snSQ3Iunt/0tLnvT91ag4ih0hNGAVidtWF5elweJJRfK2AKd9EAxKv3GG?=
 =?us-ascii?Q?1hU1VAbxV+NTIzsbcqaVd1WG+eStKjwtZ8kQKL35YU3G3U6MzqoYRUPD4wmU?=
 =?us-ascii?Q?+BwIRSAQZcrHhNk0wTR6IwRqBmreOzzDbuhpxbFdb9w1lhXgDvIg3zQNYIHn?=
 =?us-ascii?Q?xwXMqToXNfHYDidelqd/P1P7XA+hiS4oTPPUbJbEQZVVcIyprbMI4SRiKm2r?=
 =?us-ascii?Q?9aNKUPLt7Ye/QzNwrVCrcKkFSniY1xEh84VRL3v1pJ5oMbGH/Zi4nSiCx3HZ?=
 =?us-ascii?Q?Q27fSGt5W1RPD6/dEINKw7Hs1f9cXVXeavQMdqoNeFpaOs+wvynXuvfd2LVN?=
 =?us-ascii?Q?87Nbe0sIy6wJ/95DqYJTExmByl1WBEyfN+E8Y3FSRohlh68ETd1kThUsmmku?=
 =?us-ascii?Q?n6McJyMub2G/uwkycs5RLDeP1ZhUdkw=3D?=
X-Exchange-RoutingPolicyChecked: VHk4g6ILdCOo1SzQp8jJrTqVf815/W41sZmmlgzNoCGV1IfuAyJXi52FskdGPfx90+IpqluXQLJmfmi6HrMyN+rnkbhB4zd0PgiiQvovL6PeaRjb3dU5I4emYsIp4O8a+jwtp2KtO+CGr7msuo1UuIHDS9A4QQKUhYmG4W+ntqcJQrYgxOpmwSEAEjDUCPgr9XmqTVY4hQKZVB6KWYAPc03X3FUxp/+sK1VIfd66CqU/HY3jB3Xjopmqln7fDZEtzOinc5rTfOuyYuLEI1Is0GL/3gxFanoDVlkkOkLj6MEbrbjYa6GfbS4IRuiYZWfCTdPu50ytXIL3UcIzCgIIrQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 48263601-24ba-48b8-4cc9-08de919fbbc5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 16:40:37.1097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +i2u78lRZchVB6mRvHV1oW8ywOyYi3YyLeN941dee2ZddG+w3OWAsK2c+f9G0jtimr96q5C92gjlkStI7eG5hDh4fIdgwJvbu3UbjZZ5tKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7101
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

On Fri, Apr 03, 2026 at 05:08:36PM +0100, Bruce Richardson wrote:
> On Tue, Mar 31, 2026 at 01:01:16PM +0000, Ciara Loftus wrote:
> > Previously, VF recovery from PF-initiated resets required explicit
> > opt-in via auto_reset, leaving VFs non-functional by default after a
> > reset unless the application handled it. This series makes transparent
> > recovery including the restoration of settings the default, and
> > implements some fixes related to the reset path as well.
> > 
> > Patch 1 fixes a regression which prevented promiscuous mode from being
> > disabled before sending the RESET_VF message to the PF during device
> > close.
> > 
> > Patch 2 enables the auto_reset and no-poll-on-link-down devargs
> > by default so VFs recover from resets without the need to introduce any
> > reset handling in the application.
> > 
> > Patch 3 introduces a new auto_reconfig devarg (on by default) which
> > extends the recovery path to restore unicast and multicast promiscuous
> > state after a reset. Restoration of additional settings such as VLAN
> > filters could be added under the same mechanism in a follow-up series.
> > 
> > Patch 4 fixes a minor logging issue.
> > 
> > Ciara Loftus (4):
> >   net/iavf: fix disabling of promiscuous modes on device close
> >   net/iavf: enable auto reset by default
> >   net/iavf: enable post-reset restoration of VF settings
> >   net/iavf: fix reset handling error log
> > 
> Series-Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
Applied to dpdk-next-net-intel.

Thanks,
/Bruce
