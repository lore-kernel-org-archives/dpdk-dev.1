Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0063C3ABA9
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 May 2025 07:48:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94B284028E;
	Thu,  1 May 2025 09:48:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id BB74B40279
 for <dev@dpdk.org>; Thu,  1 May 2025 09:48:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746085734; x=1777621734;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=c2tGjk4zA6ifAttMhccdnVelQC2q+54AXk870uGtOe8=;
 b=H9HLmv/5M/FAGHoLkwA/ndx86rrwbZ6R3wV7nxLoQjPVpYxc3F6tlCxT
 rrnPzAkivL5cgJ36eiWCko4ooEQaNlZEnQoGYgOjjOblwcMDiJ6NLUCBN
 nbZ9s9t/XVszEesmklpBAN+QvjqenoYw7XpiACj/N+mvSbB/q++ZJqcOd
 dfAyJkeZzhKqiJjmrp0hhWFDxvwIKA0NBXS5oW7hhGKSmqjxjyKhr+YWk
 uPRsgT2mBfm9DlLSjkgjAzTmbYd0vOfpHLRxOR+hS69OjCHpZf4pcl8Dd
 kdKTVyWJTonjoeV1EYg6w+8RZU+HNhJr5rvQeZUot/11uFtzFjVvwqHg9 g==;
X-CSE-ConnectionGUID: BPLIeQppQzmcSfIiDbySQw==
X-CSE-MsgGUID: Bx3mXY7MSsyhr+nWjfUqCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="51569596"
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; d="scan'208";a="51569596"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2025 00:48:53 -0700
X-CSE-ConnectionGUID: JMxat6/ZRraieT8jmvcS3Q==
X-CSE-MsgGUID: QDdFoJaAT+KVdr1P6s6iwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; d="scan'208";a="135303770"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2025 00:48:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 00:48:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 1 May 2025 00:48:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 1 May 2025 00:48:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6HHC+LMVp8JUBKQMB2Tiik3OEoOGzld1jF8rOEQ+QUlHhpP9+CvowqPcqnF02UisupEPRJBCDHIHEOWTtv4belfbVA7zJ2y83y5rrO7kRS/TYeJhf5TsQcQT/6dk5PQM+stWmJ9qmNlYehxem/p7hBELUXK6VThoqtqHdSTcU+9Bq8HNfDB3OiBKajMpvGoOUnDlFwQmeV4GEJaugoA7DyOmeUC1cLcXuMY+zIa8pPeJ9L7RNksJP6t6uWxUGvTtivf8fDTCtwznlxP9h8HW3B8HStFReQKS/xMnniM+i+G+MvwjsAXYLdqDF185+LnTsP8bQ/Akts75MBGbbfAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqN7EXdo02JMCBolgVD32+eAR2u5qDnG1RjPnbmflO0=;
 b=Xfuh2iIaS/NHf859pXsD6cDCPTwct4e+gCcUrD01+TFvgzjFfOEaT0dm4huGxkkxCJZm/FqkrKZdkrAfNeeutfjysv3LRMhqpXa+grpMEvzigFwaazZ6K7J4+FQkQG/N8nr02ykmmffsI/5D8VFHaYfazDWuUwv20RZzByOBfj/BGRDvlhQbCnpZUzvN9R7MCKIpgdlJvkyAjqcL+c+HIP8dpLe0CfP+szpCOqFxeNLRI5OQBU4i+PK1lBWcr9iQbma3ih13h85tcn3vxc9V2gt9rDzTagsfcyt5yHLpJxvIWGqqa2EZZtbF/I1cK4HdE0Dv3WS1RsMZWlprCjSV0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB6005.namprd11.prod.outlook.com (2603:10b6:510:1e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Thu, 1 May
 2025 07:47:59 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8699.012; Thu, 1 May 2025
 07:47:59 +0000
Date: Thu, 1 May 2025 08:47:54 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
Subject: Re: Thread priority for background tasks
Message-ID: <aBMnKlCGNu6fp7hu@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FC19@smartserver.smartshare.dk>
 <20250430124526.6184f79f@hermes.local>
 <98CBD80474FA8B44BF855DF32C47DC35E9FC1A@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FC1A@smartserver.smartshare.dk>
X-ClientProxiedBy: DB7PR05CA0024.eurprd05.prod.outlook.com
 (2603:10a6:10:36::37) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: 758cbbae-c49c-4d51-20fb-08dd88847e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?XdwPFxXzJgDhy+fV7naRxpAJMBKoBbv/ODrJmRRlH5jUOhoPaFlhUtWo/w?=
 =?iso-8859-1?Q?iHFiju9TJfiWQifEvkz+lQPI3oxowratsMbdDHduAXX1GEdrLVkwOVtjSU?=
 =?iso-8859-1?Q?ViF5YFIq73ZiF+C+Ryfl2siTgR7Impets8Cr3DWU13RxI2wbvAoFH2pgYZ?=
 =?iso-8859-1?Q?pccIoX6SR+whpXgDgJX6mdN4OUOMJt6/splNm2joJy/5y00rM9OaKfbBSr?=
 =?iso-8859-1?Q?IZv50Q7KQZYiKAyQBM8iQxUJZyWcYeo000+wXSyHWDrAUEYMg6rPuoM8+2?=
 =?iso-8859-1?Q?0C6LhL0LDDoneiUcw92QlWdwfLUCmW2po09hUxnEKTA0fADRBLkQAn/vrl?=
 =?iso-8859-1?Q?scniOIgbcElomTKA4+0TbBp1o1DaxVtHqq4czAiZ7YI3Q+Z79rEIYIqO6s?=
 =?iso-8859-1?Q?hQ8ok0LXWTBBYOLGEqmVt+HlOTttl/oyX3No8xqjV1/dCxNKYMRxTgsZnE?=
 =?iso-8859-1?Q?WzhzLzCZPn//MD//OKaRLAJk16gATjMDw+5vsQLlwYgnXMyUc6ADW8OFqU?=
 =?iso-8859-1?Q?5PT5kjFB0Ksd+QcJT1qq75XOMaA2UlGuCacyQsgCs6GkS78jNTFG8qE9zd?=
 =?iso-8859-1?Q?gUEeYypFG0KJfewB7+HpmV/d3W2kLIRy81lilAik5Qs9BlD6DCXEACuNlM?=
 =?iso-8859-1?Q?rS/Yy1xSy3xuvuHwxa7n64YQdcEn8nAUbz6ElOuiVIkTq9aIGNuLuFFmNu?=
 =?iso-8859-1?Q?5c0gwrnuMmW7d0m62bgW4cgHE1C/MmKQb/u89JTJyBeK4D9wZn8I7+JV1C?=
 =?iso-8859-1?Q?YCdCnasR3iKOT6ZqfZu8bGcEEy32d7+hGh/u+0u0BzfW/pAactInzCYhGM?=
 =?iso-8859-1?Q?w0555e0aab6Uhg4QSyMVbq2WJ8wXnwx5RY8z/ohn19kbU9s//fvcDTwWrA?=
 =?iso-8859-1?Q?gs5XVGtPJnYqj+g1iMOjqVOcGkB+4jFn7yD22riuxQuD0HvT33r0Gzuxqo?=
 =?iso-8859-1?Q?Dj71CfaIYlux63EhVttH4yMnRDqJq9u5XmXwhwI7OS9WEzjynxzwtq0HBs?=
 =?iso-8859-1?Q?N8hBV3Qt/jZJO2F6YokpZKSkQclUgAKfAwTm1l6iVBlu72/p6+wjHb45LI?=
 =?iso-8859-1?Q?pC7HyaOGKnEC4ScPAtpU4o7KUkEBK5k+VmFlZBCg0JcIPoH99CFjOFSywj?=
 =?iso-8859-1?Q?Za1640tsBhQ2wPiP0+ZxFAP21FIIcfP6Y7QRCbAlklnGLlaruRnkvY0/wN?=
 =?iso-8859-1?Q?ZkiJgqZDwkvHPGjChaw/baIQZ10WcIpTgV4Q9GsRwi+Xg+WOuCvbU7L2HA?=
 =?iso-8859-1?Q?Wsd2Q7/AihwD5zk86xQ+kBDwY0W0ROYjW8M8QExB/uvg7mmNOCgmWUcYje?=
 =?iso-8859-1?Q?Zjn+t1VwUPadfz2KaVmxUvpY/mrRB6LXPVboVfFJlWqRfsFxSS1ciIzmQG?=
 =?iso-8859-1?Q?Hbp/KQVlSl8u0h+H26W0OK7F1TmrJLPOWDfJZjcoCt6RcGCt1UKCtBvS5q?=
 =?iso-8859-1?Q?rWHsfqu/3YcdiTRhFcp+cuyG1A7c9DoQsGvk9DoSYSOTdANSH0Fy3oBfbg?=
 =?iso-8859-1?Q?w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?B7yOk2G71fDtNtMtTiRfaiP9/T1fXujq6Yf+ThyFbaXdcSR2yudEr8hJyr?=
 =?iso-8859-1?Q?4Ln9R5McgzicPRD1RRP1tZrvkiEq0N+KbRoGIkiuXdOJvBSBJkywAQ2V8x?=
 =?iso-8859-1?Q?z9S6j1W67Gtu45RA0FwMIEOUPZwBIAenTJ9/s8CnxCSBAtUgvkmYjNVPKz?=
 =?iso-8859-1?Q?8w2B9ZXr/fpc9lYjVF+UBA2LjPaliNVwgfSVQiv3XeL/2JmZK92OWldMXX?=
 =?iso-8859-1?Q?SQv+97Yf0A2NTwz5lPePBuLzv2ganjVoY2djDLdcZcRf2yG5AsHbycbjAx?=
 =?iso-8859-1?Q?GS01SXJZGtNPhXxp358H53+A/xt/TZlv3zAg2qQcw4rB/x93MrXouSQ+Y+?=
 =?iso-8859-1?Q?5X9EbujoF6Moig+Wd3iOaJYaOoq43LGQLnjLEHRaz21u0I77HglV9KTAAq?=
 =?iso-8859-1?Q?n8Q7q9FkBxDsFrVaEePv8tnf2vq8nmxrj7XDkyyCLxMOO7TFhzdXqrzKPV?=
 =?iso-8859-1?Q?aDjxVRMPp2h6lQ6JdrRrQuB0wrFY0UMl1Nz1ZZygFMbh8QSw8Cqa9y5rmL?=
 =?iso-8859-1?Q?4NNuXAdmUDaCyFDfZbh8/DKzdrbWzvtMgkiIzBmGw5Nc2pHfcy5vFVnTTk?=
 =?iso-8859-1?Q?xX/mbGYeUiOqFJ2SwFQIgu/e87RWMZibnp6CGwym7mmaeg7UKStfvqaVA6?=
 =?iso-8859-1?Q?ArJEMWLQpsXwq6RFvr6WDCvTADBIO1hRS/1fHUXGTQVxno7Llj3VQFdLoU?=
 =?iso-8859-1?Q?aXdvmJnopjmALJqF5Pc38FeUrMTTY5AYhrzctNk2w7Yj6TLA6InIvjFUyV?=
 =?iso-8859-1?Q?JZ47Um9UvkeotU30uz/s28VTL3MTuKmgMsd1EcOpSEwAynEjhwTGfQNlt0?=
 =?iso-8859-1?Q?QXt53L6ycwsuFvJ01b+opcw0VYRrh8r55oX8At76Ve5iIKBmtXpsrEWR3E?=
 =?iso-8859-1?Q?b+aocHS9EBnWxNHYiVhcSREt4viC/MHj1TKZgvPZVR3cGfxNkfBZBNHuZj?=
 =?iso-8859-1?Q?ull4hMtZO8iJR0pSKHHQMlbDe3qNxRsBGieAVRvFdE4g5wTjhd8ZOhup2N?=
 =?iso-8859-1?Q?S4qoyMP1hem8l8B9WwUwzAHfeqkOJY9LKZ3S0XSZW6mR1ArEso7NSpEMvT?=
 =?iso-8859-1?Q?F1y8rQaFURi9cw9BF24J2nkO3peZ0NC4HFrbTA/uU1EdNjAQmCLqgH5hZU?=
 =?iso-8859-1?Q?YbvUfySv5XLFq+BeNsvncRU9AV1ymCXzob/MTLBCcElCa/JvVi68CyGwG0?=
 =?iso-8859-1?Q?gnSyz6xKum/iWA4jKA470GlgezgkzSX1GUEz63iWDRLv1TAsNBPdtUYqCv?=
 =?iso-8859-1?Q?VEE1u6NO93v5rOMwEpBgi8oPhqnw15Zw3fpsDxiMjGci93GTKzJq9ZQ0TR?=
 =?iso-8859-1?Q?vViJKBBx6FMh7PZJUa8F5Vk5IVadJH4/oTB0YCKamtXCBRSqDmC1iLGsHd?=
 =?iso-8859-1?Q?rOHsA9HUmWGW1lhUV+2/4J1GmWQuVjMZ6RB+xxziO1zUgu1I2mDWbpsp0M?=
 =?iso-8859-1?Q?RyZTFsEWB5moDQtDeSWwxALZMlUdB5Rwrh76zsbdpdLvVhwDTz/F+kyYt1?=
 =?iso-8859-1?Q?T6XMBZKKACS/R7m9kKk5jAfIDsCVluSsjJYRonhnL6GP3hSMcSsGfMwk0O?=
 =?iso-8859-1?Q?dRDGP5ntKZ7U3xgEBx1IruOps6juL/iRSmC1UGXACtqFGXHu/fmO0WgPBW?=
 =?iso-8859-1?Q?ZTegm97xTKfEfBA0I0jsBEnGjfZs1VdRMWRkOK7TNtN0eLViPdYKyD9g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 758cbbae-c49c-4d51-20fb-08dd88847e12
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 07:47:59.1898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0HjSO0ZKjCXmZ6+AUXbcr4broBTpuTbJ5iEUlvfLFPuBqzi+SMQ4uW3PEQ3j+bjvkeiKIXMhJZzocCyrpFkm+3Anh7c5kIVV5AAL3APfo4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6005
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

On Thu, May 01, 2025 at 09:05:32AM +0200, Morten Brørup wrote:
> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Wednesday, 30 April 2025 21.45
> > 
> > On Wed, 30 Apr 2025 20:40:52 +0200
> > Morten Brørup <mb@smartsharesystems.com> wrote:
> > 
> > > There are only two thread priorities in the enum rte_thread_priority:
> > Normal and Real-time Critical.
> > >
> > > I would like to poll ethdev counters, collect garbage and perform
> > other jitter non-sensitive tasks in a control thread with lower
> > priority than my ordinary control threads, so it will be preempted by
> > any work ready for my ordinary control threads.
> > >
> > > Which DPDK API am I supposed to use to assign this below-normal
> > priority to my "background" control thread?
> > >
> > > Or: Aren't we missing a priority like Linux' SCHED_BATCH?
> > 
> > Short answer: if your application is running on Linux, only ever use
> > Normal.
> > DPDK applications usually never sleep and this will starve the OS and
> > cause instability.
> 
> I was asking for the opposite of Critical priority.
> 
> For the sake of discussion, imagine a (registered or unregistered) non-EAL thread doing something like this:
> loop {
> 	poll_counters(); // 1 ms execution time
> 	sleep(99 ms);
> }
> 
> With normal scheduling priority, it will rack up a lot of scheduling credits during sleep(), so it might not be preempted by other threads while executing poll_counters().
> 
> But if some other thread (on the same CPU core) changes state from Sleeping to Runnable, I want it to preempt the counter polling thread.
> This other thread could be a control plane application, e.g. a DNS Server, which shouldn't suffer up to 1 ms scheduling lag if it becomes Runnable the instant the counter polling thread started executing poll_counters().
> 
> So I'm looking for a DPDK API to apply a "low priority" scheduling policy, like SCHED_BATCH, to the counter polling thread.
> 

Does this need to be done in DPDK? Unless you need to target Windows, would
using the standard Unix/Posix scheduling/pthread APIs directly not be best,
rather than having us try to wrap all such things inside DPDK APIs? I worry
about scope creep for such things, with us ending up wrapping a whole bunch
of scheduling stuff into DPDK that we should not need to do.

/Bruce
