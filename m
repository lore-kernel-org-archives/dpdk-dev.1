Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92D4C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 10:09:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F13834027A;
	Mon, 13 Jul 2026 12:09:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id C24ED40276
 for <dev@dpdk.org>; Mon, 13 Jul 2026 12:09:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783937391; x=1815473391;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=x7wm/n87KjGT5nhoMaK2Cctu61dYfm8ynXnbKtn1Muo=;
 b=YB37p5djKxmD7AStT6UtAkYM68NUAJJmsQckk6jVijWuKJySefrPMMpX
 YZZuIYvdyu0earHEiY+OouBKGl61I+MZJl6IdpmvF5yb5Oa+XK834pPbv
 Or5mvBp/tFhk30qf4YPZIRJFzqXXf6JGMxuNUT8fTljyRo1HfDcKa1Xh5
 RLgh9t+oLBAhy2YcMgD0rodE6nIatyKGfh0AcZEiWXEVbCZBpQd4NMmRD
 e3Sn9tkdr5TIEKSR+h13UzDjB15UlE07uSf/zRoy4UM42Uk108vtTuy4R
 yXhqadE0X/qNkGqVy4Mfau3qgsKaLBDCWs98kV1IwyiIj5IDBiTB6IDBJ Q==;
X-CSE-ConnectionGUID: PAduoeQUSbuphk/T9wFnOQ==
X-CSE-MsgGUID: 1fo+f27dTqyYrB/rhQkgGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95141764"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="95141764"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 03:09:49 -0700
X-CSE-ConnectionGUID: Q2VLrCjCRr2bCCjgFPqg6w==
X-CSE-MsgGUID: VA/JZ/qzQpuGGnC48OKlaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="260401515"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 03:09:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 03:09:49 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 03:09:49 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.43)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 03:09:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RN+9umlfNHyloiZwWFsyF55ifls9QUB9v5ib/M+GML0b5bCDcninC0e9Eiq5Ulv975jHJ1eLbcowfVrxBgK2sQDfJSaBek9mbhNfH1gyvkzkzSj/2/B713XNiSe+eGEi3HnGB1ZL1MQ2juykQ1Yo5uOw6lkcaSU/otzp1DgG+Mwlo0IhYZOjl8iMRuZtKojq6PjJr4kn7k53SzN0kIWD6hRpY/MfHxU0Rji4oZBRPcgLGiA83G16uDJKGcSj/qdamSMHGeslMfAAAASWXzMm357uThkW4HAg31YNSw8ghjtxaxuKyJfrqPs05q+ATw2EM1cf8gt9n2cEVFdGWp6hBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5wHijkFC29S9wHhDxhjCR7rScXgEdOnnrFiF0jxH1E=;
 b=tHZ0l9EAyr0tQTTaX5MFQD3iqUAGf84f4nXH2yd3nsc5H7IdBVXTNpQBGw0pt6hAmYeGYqpc+psrNDHHXpIw7bAxF8J4ndDY93NziSafCK00otNA1NBRIQ77x2Jv+3smxDsNRyRlK8A4UFGfEiHqe2seUdvevYS1dlQrCVn/2zp4/7x45l8URc8XgzuBKC1WJYkFFd42WiJx9uuorAiQFBcF7rDkwtDSn6qNMwC6g7z1uMNG+Dp499Jmgdc1x6Z2WcnX9ifrWs247AX6j4IVW4np/xW1glqdrMdw+vTiE8qMKJyNQUwXxCcKm7QE92ziqvdAzdGUvz4Ivh55/Nu60A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::85d) by DSWPR11MB9581.namprd11.prod.outlook.com
 (2603:10b6:8:36e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 10:09:46 +0000
Received: from SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 ([fe80::a6e3:dc11:48e:b2e0]) by SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 ([fe80::a6e3:dc11:48e:b2e0%7]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 10:09:46 +0000
Date: Mon, 13 Jul 2026 11:09:40 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dawid Wesierski <dawid.wesierski@intel.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <marek.kasiewicz@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v6 2/2] net/iavf: disable runtime queue setup during
 queue rate limiting
Message-ID: <alS5ZHqcu-rumZoX@bricha3-mobl1.ger.corp.intel.com>
References: <20260708231926.1550698-1-dawid.wesierski@intel.com>
 <20260713094259.1721234-1-dawid.wesierski@intel.com>
 <20260713094259.1721234-3-dawid.wesierski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260713094259.1721234-3-dawid.wesierski@intel.com>
X-ClientProxiedBy: DUZPR01CA0162.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::10) To SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::85d)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFED9C9AC99:EE_|DSWPR11MB9581:EE_
X-MS-Office365-Filtering-Correlation-Id: 13afb35d-77aa-442b-304b-08dee0c6ddc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: strTOL0wDPFqTNONDN7Pb7ax0auweq3dyvfhpRvAU0nCWxpyKhhhlA1t9PkVwj2Id+XuYFCih4WEJWm+YZYu0ZEtX+rLfMbrbLxUmXTY5RQhX4iTvhUvSZradLqJkso0qOsE6zE8JSPZNlJLY7tDfJxUDB2vP9mQrKXQU03Re4ANoUaXB+JAkgGs9NGvHAswaEtIQFbOPzX6AeYElU/ogDhwYxbflrSeb9rHZzar01vLXhV/5QReKwh/GfoZXWzKKLkanbvueZTe6g6gdNy7mr6zt5vp5XyHXsdUojGOKyRYQhy0LW7h+GIkMgzR9AME83HHCsB2+O0mkujVHj/buQxtLd9HbbMYfmpY8IgB0mgkmo/YGye3cs6+jiGK/eFj395wdMUzH1tlFOLvAw8shhmUSgsh/x90X3Nxui5QVkDESm2uxZUhKHOA5VbjfciNt3ZXLzu9uOPccCMxhG+LIqWg3J7oBH672yecu54ECF7PFzK0Z9Oy9LYtDkDqfw8M+UPH1s65M+rtXEGmtfwPIhhi8O6kqLDw6iWXCpgwDQeZ5ZaewfwTFWl1x+il1bnCGiGcB5VkiT/lfQepGwWu7odIlHrJW29SkAyjRGa5sTJDavVIs2KkDDqD1rmSO5byfoIPa0PRRZcoX0sCbLpYse2DNWVQbRQxnFhsxJerBp4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPFED9C9AC99.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JQCg82ikQsJW4uoS46Wz2OhvhHNhHN6Ydy6gq6bZT6xFQivCM2dAw7kfO4e7?=
 =?us-ascii?Q?laKDdbPf7e5b7DKQFvf0wAcacqsVZHxlxEdUDa7E3Tr+tfwn16weIaNV3UgB?=
 =?us-ascii?Q?tlC71Y95dgHot/VHupfiQq4nA72+6bN6i6NAYNKx3hWKJJOHoztZKcfBelVH?=
 =?us-ascii?Q?udO1T4/oNu/fVyDwXhPBv5s5gMwW2n19PhbgFowZR68YtEae7PXY1T1r6cOd?=
 =?us-ascii?Q?l0mfsF7ALSJeZJ5CSkhDNILlc6L9WCIUEuJHml8vI+JybcdVVy6ff3z1avKk?=
 =?us-ascii?Q?igF1xa4gfb46B0yI3WFyBNTzk8svzh6BA+Wa+0GsQSftlBJoHBFyxw9nqOvn?=
 =?us-ascii?Q?VuKjKaKbSb4Ly/998MWx5N2htSkmayn+f/vdDxm5ga2LGXAQyww9eNrrxZaz?=
 =?us-ascii?Q?t0d/YhqHk2gIVQwXqnbmg0JWBUtg5TXGIFuSU2dRMjB+P83oNxXZx3FEjxFI?=
 =?us-ascii?Q?wtT3KmEshlzmd9fe2hxxWlX+oTDDuIqAdYCMEa821hy1rZjp/OdIginEN1Ik?=
 =?us-ascii?Q?YqK7Tml1prVQS2ZtaDCmVM6aeRf/upA+G+4NtKfBG4+5tMvJYBdP95U723pt?=
 =?us-ascii?Q?jCCZFD+sKX6yNj8yqsxPuqSNkgXtjx9YkWQq+UX05NsFd8FtspaIyKXnvxQe?=
 =?us-ascii?Q?wIeehtUZYjaH0MCd/L0Upu1bzPPwltiDEsM9nzQhHMOhde9TSt73AFD/QBkd?=
 =?us-ascii?Q?Vh40PjEpXtVlAPHvwuFfikfmz1a6gp3qHV0x7geTAj8z+b/JhfNhx44YMkeg?=
 =?us-ascii?Q?HMSpcfLw2owu3TMB7yG33GsAFYirXNgMg/aqucVjOG/l0DvO6ZWFGq+2bbHH?=
 =?us-ascii?Q?kXWhvk42K7H1unl8xZHczmnAxikaMTZpHsgCHpiHCIIIuhEGmT+z2ulXgz8O?=
 =?us-ascii?Q?8ziSFWzYtrhpfzmep/6FXejLMT/UL4orCzS8SdOngBRq7UyzA9ZLyABu38R4?=
 =?us-ascii?Q?d0k77ZgAcP9D56NfYkBFO/1PoHaHyl0AYQIOUhqMIYBAwADA8SE5j4H8D04L?=
 =?us-ascii?Q?wDPVz58068JWfx/kJC2ednxLIYF4IA6YH8NNu4fxcUf93+x3xLRzbvm3MWml?=
 =?us-ascii?Q?GCH5kcvko86knhMLZCJdMFWQJeFpWWcCX3qxYoGaaEIDEu7Bw3ebyyXPOWQm?=
 =?us-ascii?Q?LgkxyKFJbvZO/gRaQCWDRIUSGF4+Hz+g4QWu/ppRfeghYAD9yKw8jhd/o6N2?=
 =?us-ascii?Q?PGTKUCUmgnkS35UdAFnEtLKgO/rLtXP82+DnrcVTGlW6Rina0jPLfi9eBV4U?=
 =?us-ascii?Q?YhtriwuxOA4yUsa1YT9KDA7/jgDcTKgrGQgdoa6bAlfCJnMrdEDlLYYVGiBa?=
 =?us-ascii?Q?AqKlmR8ELAPHIvVSF9Emn0yHfbLQqsmnvtswJw3IFJ7gDRXMjY932aihKpYz?=
 =?us-ascii?Q?SOuFy7P6l4eoElKdgRB3+31UejMPymVgjqj6RVTNMTRl+uVGMCL6E0E6kXw4?=
 =?us-ascii?Q?8MP13RTfF6xdolDX+PZuNfXceW7fSAMR89rXnb9OsnSprJ8PfvaaUBf3uLpK?=
 =?us-ascii?Q?bFrgL0BlW4mLkC3loCwHSlHifjfm653LkgaBYYeXY8FA0BIplkkxCPIw6k3O?=
 =?us-ascii?Q?wS9s7pcOadXAgxOTp5lory+QsVd+Hd0DbovIKl9kTjuMQKxiu/EfuzfJz8A4?=
 =?us-ascii?Q?gvIoHl5TazP0jt6y0dkbVncW7yv8feeuP9n9gWhBqA+2lXFV557WzHdn/qdf?=
 =?us-ascii?Q?ceWvtIdT0jZa4/hbjM3ww7Z+mJWm+l/MRiUeKKjUNGRIA/5v/zMCGcIwlhI3?=
 =?us-ascii?Q?Jbo+Wmmo54E/fODBhQXZz3e6jTeDny8=3D?=
X-Exchange-RoutingPolicyChecked: XnwewxoKpeHWeosupCCE8ZfTGXVeFVViWhDhE7xGNVVUYkqEH+Gj0iXC8C8kwom2z85FznyjKvkevCetAJbZSqC06jmVCbL7Yu7jXm3P6nHU+91wae2QRGK1hOlpT+p3K++bk6B07iw72H0Xx1YiZI7uoGo3s6BCmTzmjia4jV+jGWmvMD5TWzG0fTDg4MqdRCD8AghjA5QkRlfOowsJlC0Yp6mumjESvf6R7Vwo8JYbdr3yHWbR3VnLJpW3egDDPPOEAzXoQbjWDl7QBU+uvYZCpyqxbJVY6lCBXNnSV+f1EVUEFrNgzOx7rSMPFn7LpETs41BySdqvwGLlvJzXnQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 13afb35d-77aa-442b-304b-08dee0c6ddc9
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFED9C9AC99.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 10:09:46.5037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 991SXhXzfNBrxR1epRDX3McnI5kudn9+xJ6WlkoIhjf8kRoA7+RA7hZKlHh3TKgJWQRXiBPYLe891z7F/Upnx3UVFIcoUXAiCKQ4xki3JwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9581
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

On Mon, Jul 13, 2026 at 05:42:58AM -0400, Dawid Wesierski wrote:
> Runtime queue setup on E810 VFs causes queue state corruption when
> queues are dynamically reconfigured while the hardware rate limiter
> is actively pacing TX queues. Queue configuration messages to the PF
> via virtchnl can race with ongoing TX operations, leading to undefined
> behavior.
> 
> Rather than gating this behind a devarg that an application would have
> to know to set (and could just as easily avoid triggering the race by
> not calling rte_eth_{rx,tx}_queue_setup() on a running port), stop
> advertising RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP and
> RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP as soon as the application
> commits a per-queue bandwidth rte_tm hierarchy, i.e. as soon as the
> condition that causes the race actually exists. iavf_dev_info_get() is
> re-queried by the ethdev layer on every rx/tx_queue_setup() call, so
> this is enough for the generic layer to start rejecting runtime queue
> (re)configuration with -EBUSY once queue rate limiting is active, and
> to automatically allow it again once the rte_tm hierarchy is torn
> down.
> 
> vf->qtc_map, already used elsewhere to look up a queue's TC mapping,
> is repurposed as the "queue bandwidth committed" signal since it's set
> by iavf_hierarchy_commit() exactly when a per-queue bandwidth mapping
> has been pushed to the PF, regardless of whether the port was stopped
> at the time. Fix two related issues found while making it load-bearing
> for this check:
> 
> - iavf_hierarchy_commit() replaced vf->qtc_map on every successful
>   commit without freeing the previous allocation, leaking memory.
> - vf->qtc_map was never released on VF teardown, so
>   iavf_uninit_vf()/iavf_init_vf() (e.g. across a VF reset) could leave
>   a stale pointer referencing freed unrelated memory, and the runtime
>   queue setup capability would never be re-advertised after a reset.
> 
> Both are fixed by freeing vf->qtc_map before replacing it in
> iavf_hierarchy_commit(), and freeing and clearing it in
> iavf_uninit_vf().
> 
> Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
> Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Unfortunately, since we are now past RC3 for 26.07, I'm not going to take
this change for this release. [For RC4, we limit changes to critical fixes
and doc changes, so as to avoid last-minute issues]. I'm doing to mark this
as deferred and will take it in 26.11 whenever my tree opens for patches
for that release.

Regards,
/Bruce
