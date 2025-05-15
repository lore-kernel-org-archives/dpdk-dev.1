Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF90BC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 15:42:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E36940ECF;
	Thu, 15 May 2025 17:42:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 8851A40E03
 for <dev@dpdk.org>; Thu, 15 May 2025 17:42:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747323761; x=1778859761;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=iHw/O944k0JkgLPB+geWRXxQ15Xup4/a3u2CnRLTxus=;
 b=kXDapB+5kuusVKBak36GpwAwv/ArWQlWlgdKiOGPWAi3rZ6pWvpPx5ju
 tOsPahhLQ6+/TWn4xcWUYYSP937Agid/aMcjvyZVbjMX6NRPMgdHgDV+3
 XU5Wq3yobaGf2okwY8jOi4sZpjLBLkQA/zuJplm8oFAHZ9g+F7WgkkW+T
 aL4GVTHfJpHuCUTYRZOStnYnzu+NODyXqc+DjzwAuDt28gOlfqfCjKmSf
 lSCp7PH4RpPDts3LWBksW5ZZNeeqsy6B8PWU4aTDyNhCeTT4CQAWM+9mQ
 w4r5gLvWhrvgU9oVxEqJUfrNXCey3n3e9brH506sKmqr2DpGVMci/qd5M w==;
X-CSE-ConnectionGUID: 8FmJt6PmR4KImtaDQiwCfw==
X-CSE-MsgGUID: JrfOYYwQRguNC5Vp6Oh2TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49428557"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="49428557"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 08:42:39 -0700
X-CSE-ConnectionGUID: IzHrC9eBSAe7WsIqRj1X7g==
X-CSE-MsgGUID: ZlYfuAauTt22KbP/KaA1zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="139306285"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 08:42:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 08:42:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 08:42:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 08:42:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFS3c1QpLwlFdfkSJiaMz8jl8G2wHWqaO+kdu6q7mKxA0jD0NAqpDqJmXkVv+CcjSYvAhEuf7ymJQcJybiFuXQ84rNtkNcvBR1hwMjfdaOG2tUyxo/9cq7iMvgq3cEWz11BnM6udn2TVf6rVExDlqsU3qe6tLwvroQgOs8W8kjdcJaXCb2YEJoV7B9LbYOVeTV/rWtZebLKfIObVCT1enS00xJ0l2PAl0BaihqKenLZLcXrP0FhJEoSwhvGh9gLsvH+boyO6jasTDqNxMePbEXBvcUEntPApfCAU/iV0O8JhiOTOlHGynBtcAyjteZUFbTlKEIKXHBqb96jXfWmt6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWkPmOQ2G6MzPA2rPvmW8TTlLu98ZaQKWzSi+jgUIII=;
 b=t6YkJLP+WI7Ob4OLw9aYSVuHJMB8PHl08BfrJwQxMYXe+puceF8fK7Zz0BNygvXvhOsG2FRyvhLyFfCwFOyaOcq1gWPGTZ5Md4M3XsYBhxCN0/uX0m8bYFGR4I5rbevVLXQcshIkLIEl/OriJnV5+1bL36X7VAdAVCr+hItCewx8o+dJRmt3wwyWrZ+nprgv0y3KwRoH5gZxZe9lSKmsO++uwk/gqG0HO79QOQl4PQ0AcD66KcBKoSlgInxXAn3k91X8IDSJnbqWpzx3iD73PFUL4N+QPh6Z19Ehz9iHEv4hTV19ppTlARiJ7OZg+0XQE6lHmar/+ed/pEwUD/c94g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB7862.namprd11.prod.outlook.com (2603:10b6:208:3dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 15:41:56 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 15:41:56 +0000
Date: Thu, 15 May 2025 16:41:51 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: CPU affinity of control threads
Message-ID: <aCYLP1aRu2DIEhG8@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FC57@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FC57@smartserver.smartshare.dk>
X-ClientProxiedBy: DUZPR01CA0009.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: c3bb19fd-93b9-4897-6be3-08dd93c7059f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?X7RI3WCxhr02zjw5liYY9VZotfc2SmwANbp+0LewwrHrRzR4RZEIYA06qW?=
 =?iso-8859-1?Q?dGqH/BRxhVKy+ND4hujoyjbKkmJTg69VRFwEbfaoG/FUzNCaa4ptOX2HHK?=
 =?iso-8859-1?Q?A0zLRaovBcB4JiQuZtmBiYkSZAqbhIVjYXNrbxOYVRXzzw/d97ven1ZWrY?=
 =?iso-8859-1?Q?iP08TCdhTD6bIqQTAeoTgv0Zz012TEYS8xEXpieiaBhPkfcicRoVOAdQDD?=
 =?iso-8859-1?Q?ZBowEAUP70Ve9LVLU6ex+CgaYgQbATVS2+46sdTXzn0y0MxrLD0j0UxLQo?=
 =?iso-8859-1?Q?zNneBGFr8Z1JgU2LjM9UvbjW6rH6OwaWAj0irGrkBxcIC9yBC+9FcgRcuh?=
 =?iso-8859-1?Q?newgaFOmfLbvJsJ1gVEzJXtzh24LAot7B3g5tvFeSZzFSNYlLakfrQiuIQ?=
 =?iso-8859-1?Q?EIY1RKfuBjjA4N83naJDU3LekGAXjUeA/jlxJp2GlAUu4TQkq6sn7Ggw0Z?=
 =?iso-8859-1?Q?U4rqct39/Z6BVzFNY0Q42v75vlvlSrbgDEuH+81a8Vr9IlE6mavLJ0Xg4z?=
 =?iso-8859-1?Q?DqxqHOkA4BirKLce+cbxDqUbfuobxC7ipivDSm6H01rapigyb5PgVWAZFG?=
 =?iso-8859-1?Q?+s/qN2EFR+eaSuZOluYrrs1MYIu1cIbrEumHFipjTpxVvbjYglevIVr23T?=
 =?iso-8859-1?Q?t4Ygp8d317jXeVRLdM2vwZxBVpEsfycDwtWtKnpstijSzlfurVT5QF3FBp?=
 =?iso-8859-1?Q?sP3CrcR5PQvGLeemYoSvrGbSZdtthqexGp3IHQNOwQl+q2bmBxtwCRRq74?=
 =?iso-8859-1?Q?4oHEbO2NrT5X8iB/dgAxySDYwy29lT0rtoEiejl1ortVNlnZSCRHvJVEjM?=
 =?iso-8859-1?Q?p6DKcZbRUG3uontWqzkCC4LsDwBZ6mGHeXyqYmL7aCjbkznvJwdu50ASzy?=
 =?iso-8859-1?Q?5R/0+fM5IBr4N6szNfvpTZ7Hn+P2VukH/YSnxdxBxG7Kwm6ZbEB+r8XlTr?=
 =?iso-8859-1?Q?vkVYdJnoyo3Glmm3s719T2SUDIbq4xVGQX9JpA9k3z/WrzfLo1XCVvljK8?=
 =?iso-8859-1?Q?vYTe812/+oK76ei1BE+8b1W7rWWoS2G3txG4fUaeSypDqtcmbq7/A1hQvA?=
 =?iso-8859-1?Q?QKmzJh5cgdjp+6MNkMLvwM980ic30xFU6lFSyepbMSIgvOOsLFhcjAcnha?=
 =?iso-8859-1?Q?CEdXEGTJrcjWLGEEwuN4x64D0sMLwpFVJUQYSpB3IDP7t+ik919Z/D/Bt0?=
 =?iso-8859-1?Q?0TcX1LE2AHgapgq6YcPl0k9BDUGDb2yR1rXKJk6xacta/vdCFZk55w9FyC?=
 =?iso-8859-1?Q?u0tWltXBjFxb2VTDjqoTp6xboBSju4FeZj6mDs22wdN05V+u88UpCB8COb?=
 =?iso-8859-1?Q?xHp2Jxc+/bZANSwwF4VREWkSad071CO0I1DTvdxeXghuojIgUO2yYRufng?=
 =?iso-8859-1?Q?YjFCTxiqNGHPQIvmj4+gCfFZ+odSTNrwbkCbSQYsB85szeozw9iHIgLI0A?=
 =?iso-8859-1?Q?V1rr9kxrw7KMnViRzNqaZFuRBrD/mynlGmC/9Pp+ufBmOCFL5L4BX/xip0?=
 =?iso-8859-1?Q?U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?XGiQJiGlj/ILsjUMMQEBvwBxaOYADcEM7wh92yrngM1D6Kl4BqNOctg+S+?=
 =?iso-8859-1?Q?jJSUx/t0LZuKS0X6JWmV6ZPdbsBQFoG9tX2JjiOpG3F2eIQfiNmxFPlmO5?=
 =?iso-8859-1?Q?PzpKq19TzXI2P2g35Nv/YveSghy1vmMFlc/q4gYZBjBCwusZq0t3B+Fbob?=
 =?iso-8859-1?Q?WkU21GAmr5atqRiwTeiLdESf3J5vTwoL8YIs51IeIyeWmd0sY+xGmFIkdU?=
 =?iso-8859-1?Q?SoKexFqDBgpdrarql6ztDckGWH03KquEa7VjvsylzntDksYx2ZQjG2iUwf?=
 =?iso-8859-1?Q?QEcegGqd702y6L9HWsCHWStPjg1OYKVnQt3iWJKE56Mb9ApIDMHdK+41Nj?=
 =?iso-8859-1?Q?Kct/s17y2UPM8M8j/nUjtQxwDYsXIUiisHcy73/XIuWIhr6Bc8A5R4H1dv?=
 =?iso-8859-1?Q?h4NzhEJVJ7uRpYdw7R/DQsHNDPn0ufQgJb+M4+9jGRFbzmjAJ10cbQU2Xf?=
 =?iso-8859-1?Q?4/9lAn/z0vSKMjZ87w6xjZE5gEAxrqnCRzZU9GaJYwu5xwEGBsJUyFcMdw?=
 =?iso-8859-1?Q?h76rfgjeZp+6AclrfVWIA6L5RDBXdKqbklJHJEU3UKdca7N8n7h5y17trb?=
 =?iso-8859-1?Q?YXW/BKNGTQHWaFx5Eez6jGCUNv58LWlDXo/Xv694u1XEwhEq1fx5gNhohv?=
 =?iso-8859-1?Q?b4WZwYbAqmmIlBWW6OXFITjUnBY7xdMLEL33rRZQcbfz2AnFGZpcZwTUZt?=
 =?iso-8859-1?Q?2T70iObmgt4dce9UakwBeulsQr5vUqwge9yMJbolNd4BDfZJ9A+TnKDLFR?=
 =?iso-8859-1?Q?w+MftgC8nfZfxJKLsWqeCELmlMrEPv7rIqhJ91FRKIlq1e+uNaEyGElzuz?=
 =?iso-8859-1?Q?YprAnPvZovvcAof5JEBAQuYlzKbU+MHbBflQcUOz98Sr/5WiMuiKOXpko3?=
 =?iso-8859-1?Q?UTDO1Fe1qbXceiH02iY7QZ9NcRH0i/hv17fW51DqxAKNBV4x9FYwGXmcZi?=
 =?iso-8859-1?Q?tEgj0MJvCpNEwp/vbKpwwzfWeZUyezwgLFAaXXWNU/qpl1HvtUIsTCUn93?=
 =?iso-8859-1?Q?GY0sWYrRONIOiAlGuenRsyjOElCUCls+M887Ik2lA0JSkzykYYtAnB3Sp/?=
 =?iso-8859-1?Q?8DuZu7jAbXYoI6jR+A/jxy9aCTgfmyZA2eNaRq/+EZ83SAIzW8TWJd2ZYF?=
 =?iso-8859-1?Q?BHcj0wYfySofPnjy3SjX5frnjT01yMfWmUyhdZLyDI70GC00yxpIYw1uPu?=
 =?iso-8859-1?Q?eqHkEX5YnzFUkcswqwMXraKPI2au2xRCV5JtA+uLxuxwtScAVb8lWsdHiS?=
 =?iso-8859-1?Q?Ofe5Iw55W7K709k41iDMeeqt5Yw3+XG0OmC5dOMDQispgwV7TTalRaPftk?=
 =?iso-8859-1?Q?8bhauaQuQpUulT9Pe9Qobs3kzW9t3uarpHG//vyYGfOMv+/+GIwXhV5QLO?=
 =?iso-8859-1?Q?FGFE5/yb0lx3GEPXCck2gj+NGfUZIkIotzAEg5eu1YMdEM2A9e3Yq8sbIR?=
 =?iso-8859-1?Q?flaMaJQdPbDTK5FmvEyzQlU8eBbF9b/mMSGb0J0n6p5RGXtz9N3FMn8YUH?=
 =?iso-8859-1?Q?sTHBZvwGxRnV/GWsViiF+E3DjC3A5cwlBCFzYunYT0TWa/NuSAtawJkBm1?=
 =?iso-8859-1?Q?xp08Vgb96yIkjBboj32yiBp0Cke4Bm6x8/5I5L4iZvQV/4Nkn7qIhb/OK2?=
 =?iso-8859-1?Q?5h7sr524ZlTcTEQHDayq4mMSvU7aSXOWsaY1jSItJXZcqp/GDnV6cZwA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bb19fd-93b9-4897-6be3-08dd93c7059f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:41:56.0894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbxFE2PolHShCtyR8fY3R2TC1ZBtMnMYZb6sO6tGLyXYuZ/u+HKICsoIFu+fHtoYtV4RNR2MyERwxpAWL+DhPZZbEp4htLu82Do9WNF2z0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7862
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

On Thu, May 15, 2025 at 05:22:00PM +0200, Morten Brørup wrote:
> Bruce,
> 
> I found another gap in the documentation of CPU affinities.
> 
> Let's assume a 6-core system.
> 
> If a DPDK application is run using:
> taskset --cpu-list 0-2 dpdk-app --lcores 3-5
> 
> Lcores 3-5 are EAL cores, and each of the three lcores is bound to one cpu, respectively cpu 3, 4 and 5?
> Lcore 3 is the main lcore, and lcores 4-5 are worker lcores?
> And the original thread of the process (a.k.a. the main lcore) gets its cpuset is changed from 0-2 to 3?
> 
> Now, calling rte_thread_create_control() starts a control thread.
> Its documentation says:
> "Creates a control thread with the given name and attributes. The
> affinity of the new thread is based on the CPU affinity retrieved
> at the time rte_eal_init() was called, the EAL threads are then
> excluded. If setting the name of the thread fails, the error is
> ignored and a debug message is logged."
> 
> What does that mean?
> I.e., what is the affinity of that control thread?
> 
> A) Cpu 0-2, controlled by taskset, or
> B) cpu 3-5, controlled by the EAL --lcores parameter?
> 
> 
> Now, what if the application was run with:
> taskset --cpu-list 0-5 dpdk-app --lcores 0-5
> 
> Since all cpus are now EAL threads, what happens with rte_thread_create_control() when "the EAL treads are then excluded", and there are no cpus left?
> 
No idea! :-)

This is one of those scenarios where we need to a) test to see what current
behaviour is, and b) try and work out what the correct (or best) behaviour
should be.

/Bruce
