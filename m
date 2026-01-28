Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E32ED3569E
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 10:43:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFC2440274;
	Wed, 28 Jan 2026 11:43:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id A9EB9400D7;
 Wed, 28 Jan 2026 11:43:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769597034; x=1801133034;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=EG4MohHtSLio4oEW2IKSlYmq0kxn4//EGw3Iq7HwZ6k=;
 b=Ac3czX2AtPWCP1rpAgByrPXXzAaES7nvtSstmEEiee39LTCLzWJ7whKW
 iW4MnL0WkgY9lwFJh/nuv11gUEnWxFuSpICpeJWgQ97iWD/LCPoXBATjo
 u7Vd4rO9HveL0F/cu5KnAVXPXaI9ScFdEKEsfKL26bLS9+W49fSdVlSPt
 g8l0mZEB81doLC2tDqE7RZnyA4HQsPpzWawz4tS1Elzai4bll0m35ADMS
 i10PltlPnkCBcRcB/CY2HAu7DSpHC5mZkTFG2+6ZSmoIarg+p8QmI3urE
 hW0WctBwYAeKCtCHv/wLUzvZ2MLdVpQcYFkqQ39neQl8GkO+gf4sVE5Jr Q==;
X-CSE-ConnectionGUID: 22cSKfWdQEuG2bj0Ww7Spg==
X-CSE-MsgGUID: 0m3c3zz0RrSqbvJuFudxfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="74432220"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="74432220"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 02:43:53 -0800
X-CSE-ConnectionGUID: UilubDq4RDaUihBvXLyd3g==
X-CSE-MsgGUID: fOSZsWv6SOm2uFjrapkBJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="208300778"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 02:43:52 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 02:43:52 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 02:43:52 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.8) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 02:43:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXw1CU4O0vng0i4bDKg7zQ1bUdaNrGqwb2AyXc4Tv3KMjVt27kc/LHz30/rJ5hbkkAo6zhces6w7zqc9AhFweCjIHpdbGIz0TxwAsPaW3A+W1vj/LO23qXNHkOpTMvmIRDxPHP25OMjoqHgDY/HQ064XGx6gM5GO7yDu7J3MxiMoiPvHm2Z3z8K588/m6IW80jCBokKbxzA9AVLzLSO60g22KgTBybxlo6gP//QL+fchxZO+q4jr6SGjTz7MmNIUOaCBY06sPNyfMzByIDx08PLMpk52Bz6CYg/A/4Ns3lfdQneFNZkyZ5ZKX8bvM5QG5t0r7mp8hzpHemYq4xoWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tA1GKD13wyI2MJf/Yftw8+LlXfPe9OlqVLC5gkMHwFk=;
 b=uYiRCZQ3MiLoC2AK4TWaCtOgoA3M0n9LMYlxLptv3fpjQ2WxCbpG/NI9v8ly377x70RcMhDsJ9A3ieW8FCkMvk/k758bBA84ue/0DqKULIT7AQFFZ99QXZdqiAGAGcKlhNHN0Qiqyqx1zuUz4N2hIuWS9wTu74Ajw5TmI+j/+raMS0/x7FU6m90d4CC9e1L5w/4SENmUjAp/PSjhyg6GC40f6YpFt6fvb0XMmLnSJVGB0ZvZOjAfHnvKVNL5Bcru2apUX4TVoEHjk3PbJBu+Vk9Cvm1VzgSd0qdMcDLpyz+azACJY0x2VZNnHVKNoFYY/9zNsyhzOLBcRGNIEP8NKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by BL4PR11MB8798.namprd11.prod.outlook.com (2603:10b6:208:5a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 10:43:49 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%6]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 10:43:49 +0000
Date: Wed, 28 Jan 2026 10:43:44 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] examples/ethtool: fix error message about ports limit
Message-ID: <aXnoYJo_ZJ68zodC@bricha3-mobl1.ger.corp.intel.com>
References: <20260128103350.2730104-1-thomas@monjalon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260128103350.2730104-1-thomas@monjalon.net>
X-ClientProxiedBy: DU7P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::31) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|BL4PR11MB8798:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9c8c81-86ab-4e75-6748-08de5e5a1efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1F1UgfFjNqSg+ol9IWcIBAYVlG0NQB7rx7LFZZKo8dJlCaXrs9oQxwha4azn?=
 =?us-ascii?Q?O9Oc70PiKojat1Bt/lHQomjIs/Kcw8Yw38IV66w4+KdAKz3vwB2C1szABRL7?=
 =?us-ascii?Q?x1rtc/sdoGt1odV+2gNK3iOG+yStjdaMnNNh3jXR2HjhoTTf38ee50pW/ywf?=
 =?us-ascii?Q?OzZLzGZUI4GM735TXq7sUfsz9gPGptd7Dqb0mrmNgZhF8gMxPMtPD7WGerv2?=
 =?us-ascii?Q?8iD1C5rw61OtwwdeIA4sqmn1T3RnjxW90KbT8BsuGsSF4Ociu/FCsTPn2Dhh?=
 =?us-ascii?Q?uBLiJEp57cmm91S4tIEZADvJE6XdLyyGEQ8CWa3PQgOu3OaBr7w+0h3xyMTW?=
 =?us-ascii?Q?1mddYjSfv2omfKRtND6DlO8pl+G0VeezdsLuKGyR6jRyO5zwyhX9cXQ8vstR?=
 =?us-ascii?Q?cONDaslHp+lW3OhFApmTlwzUOg1fUs1u7I3rDLPHmXujE+pjGmY3cgFZZ9bs?=
 =?us-ascii?Q?XcJi3IVGaPcZFYd1vAKq9xrYzGnBvqssxWwLWfRcKIZ9uXVzmOU92trYWinK?=
 =?us-ascii?Q?r8TUkOhIT9stNDLKR6fOXHXxNeUb3ZwWXW35osrDLn3/zVDHroJKbGxT5Zpc?=
 =?us-ascii?Q?oc0FF77Wvolp4B2SPvOSf8c79BF8Hbmcl2ciIIfq7HzkVqg9lBcWHAEDvbPL?=
 =?us-ascii?Q?+JZuWjEN0y2ny6uPVu49vC3cGj335Cn8AxmMa2cj9vmp4lK0dOP5Fv4x0cXV?=
 =?us-ascii?Q?zznX1558rNdRz2lV9jsOmnSk+lvxAcqzSSerts3TD7w+hDaJ7UqLQHsQ6AzL?=
 =?us-ascii?Q?/ZmGPMLgdiE1Cud/joOXdHU9SSonujAP92t6FSZsd0LhpFQpN4iLydJhBEvT?=
 =?us-ascii?Q?jkHslQ4hKGx6B9LndTx7gETiClprDRDe1dtHWZm9ORQNydS4WhcHZfiTdScc?=
 =?us-ascii?Q?l2Y/4kYyxUKEymg1LTjb/2Swo/Ztt8rw5kWm4Fk2NhLsIVysN6JdzkmjzMlP?=
 =?us-ascii?Q?2binu1gRG5M91Zsu1JEn/FXN4q2tGDxvFj6lLDnYjj7IjkD+8XIcUN6cH3hH?=
 =?us-ascii?Q?ylv+JUXbJPUjc7xZs9gPxfeOFddlYh4IEviZkrgS225V6got6aA9I2rR8ws1?=
 =?us-ascii?Q?bTVsL0tlYi9Ofek5atEUcu1DT5/GDvK9UCodLfzM9uKtKJOXlRsP0+ZxYgz4?=
 =?us-ascii?Q?vTK/tm05pQwRalvYCTmDiXRcmL47Q4V71ZLxpngD3lv5g2pz+IIBHD8ijC+/?=
 =?us-ascii?Q?S0lhGDOgyAuISlC7VSf5q8xoLfblaG4viUUdIHivBKHgRPZH6I7EZw4gUWWS?=
 =?us-ascii?Q?ogw0NHQ0PSmK9lpmm395d65xFNcO0eo7QKe8vD13oBUc5Vlwyyv/sUQKkPEY?=
 =?us-ascii?Q?D3SPBymyVj2DjTmq+w/8S8+wVC1zvWJSFkIKl3dPAclNwKlFr5T0dWmD4EBJ?=
 =?us-ascii?Q?KICEetiTU4xu1X0DqgeZTZ6gSDCGZ5sps1ACB4PHYeIuugeTdLd8zHxCSbKr?=
 =?us-ascii?Q?WOmdzrF7P9flYnM6/uJ5QOjYr9cE4IsggUqxnnMWd4cndGrz1H+QZNUx14Jn?=
 =?us-ascii?Q?akbqSm9++wjMDSdI2SB0v8sXWuxr2OrgqIrQVeThVqkG+aIRSplyVIUKOZIb?=
 =?us-ascii?Q?2SsDTI5KB0GdWG2Dyeg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FUrKgXEFifMRJwIidsuAwzQq5xyfGZbwi10UtW6QtGr6xpaEsjdPnB48xWqz?=
 =?us-ascii?Q?zkzbNJzwsVMyiYEK1nUXtO9HqCx+SfKSrg9NHwtXGMRpXYqnLaRnvkhHnhRr?=
 =?us-ascii?Q?dnwUyXyfMlT3/QLwlcCOVhjLVXxnPmEWuKIcGn2ak/aljrkiyGqNQc6zbtFZ?=
 =?us-ascii?Q?LXYZXZdJFbNPrLhVdnBENe4PiiN0Z18CkzhqwhU/wTbNAyxNW459VSAguFl/?=
 =?us-ascii?Q?5z7LrWbffxIslqrZ8kzOoGkjWxYGC08OtGfcAsu7lWNBgJk+YkWcX6QTeEdA?=
 =?us-ascii?Q?E+/Dn2E8BvOjbyd40M9Nz2M2iFPxwXnAxSzTEfl4Xs45IcpIMN8siLKc55Lp?=
 =?us-ascii?Q?+C7/tfLtsFD1jIf+pIBgltJGNGmr2Wxgy1VL27yPw+v8M2zY3Qdm9yXmaqGi?=
 =?us-ascii?Q?mDDaNw+agEycGLfb51z884b3wUjB0fcoK+pQDj/2KmEE1fSDZs+mhRZrje8h?=
 =?us-ascii?Q?k5hWrORgbHJ5/JVb7HUWuFumTbxVvysykVIGooW4gQ6dc9fEIadx7NVkoeGS?=
 =?us-ascii?Q?PZa7lKGPuhYwLDnt7SV6Q/mYwv7mhIooWHvnhe3hPdsrd13GF2VEXVQfk6SL?=
 =?us-ascii?Q?9kgIyNIU5rlIMmkUd0JM5yULNgGIXXXvRvMMCsqFSqxkm1o8eePThxwL0V6w?=
 =?us-ascii?Q?j5LW2MKdMXOebCL4Z8N6toWVPAmIOeW86ybAue/Cl+MWNOq5D3KXFyEEoUD1?=
 =?us-ascii?Q?0ya+BXOLBal1Mj8+geGAddZPfcDRVQdeA423hGxwUsRNy3LlZDeBZLJLqD+5?=
 =?us-ascii?Q?lZaRIQS+Prvxy7/sqB6fuBmtx4m3/hgCASUdLoz9tGHBBq4JkSSdD75A60s9?=
 =?us-ascii?Q?opCcDndckGZa5d5eMU+04AQ1Et3U7sI3wx8ywMWIWO5mWSKkRd0fhpJvLywa?=
 =?us-ascii?Q?lkfLNFZ2Izbuf8D+WmPbvyEHIq/9mCmQdqPM6nZ0pDrcokj0cFKweDmcWPHl?=
 =?us-ascii?Q?AZMhL4TPaNnc5TYr08kPMYA0z9/AAiHKDsOHnGAlPwu0liUJY8ROCxf4TzE4?=
 =?us-ascii?Q?56COuas6w/vPf58splPX6TnRcj3PfFN+fTh9DKdRWQwel53s+85x6Lw0tMqB?=
 =?us-ascii?Q?m2qoNNT4sXb7DDW9NUkKQNKJqvspVu2m6IBZuSX0+FJfkn9zYCDVelIdSgvm?=
 =?us-ascii?Q?b2PRWMeb1bm7qIVi03uqCeRjPVxLEpdan1l+Y2yeUL94yKQweig8IUq9ZNJc?=
 =?us-ascii?Q?8WaFiOcpUZCvde/+0VaLoyukdCht8SHSKVpQPcRpSQ1zICwbodyxB5ztdg48?=
 =?us-ascii?Q?lEd5E9zGDFXb+sLsL/h9GbRdI2mixJjKoNNw+0LXou8rGTp+OKz12oFlXPp3?=
 =?us-ascii?Q?pobv7T29Q1Ph6QM5ZISw6lMHKnR6/jbXGRjW3NUyFnQXWbcrF0MuWY1ZTH/m?=
 =?us-ascii?Q?E/5T05ffov7JE8yENIVGjtxio8q3YU3lHO9tG8V4DKIISxRyXqos8CQZNv42?=
 =?us-ascii?Q?CT0GFx8qyGgMUqyDr51iwUfa8Qy7icIS/xZVuktzHT6/EArwDXTNP7AKkXIa?=
 =?us-ascii?Q?BXuKj47Go/z4k2mEq+BqNOA4r+Gk4yOfsluU/604GmeM8ThbIJppfi1GV46X?=
 =?us-ascii?Q?nIZaE+eDvJNnsKw9SpBp9v9RH6GJhOMCMyY2ewGwk2k/TsbDdJB3wrtwAFSd?=
 =?us-ascii?Q?tdFDpwhQSIx7jwtuWC4aitK9QV2hvrlx44M6axyop53CkJ4FVFWsLtMPSAvK?=
 =?us-ascii?Q?mNYiWfmVD8S9C80ag+uSeHNEpXuUmbn4BlvnwZIaUEclfu76woD/upZ1nwIM?=
 =?us-ascii?Q?WILJQMuRkfi4piQJVT+5R/DZ1Blheng=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9c8c81-86ab-4e75-6748-08de5e5a1efb
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 10:43:49.4373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQxd3tMDPexxZdy2rSg3RceU6SVrJg5gIlq8wn+38phy5f7Q6RFk7Nh63odF9epk1WH0dLD5uRxWA0qX1ZNRELz5koUcC65DH4LIAYf8/0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8798
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

On Wed, Jan 28, 2026 at 11:33:50AM +0100, Thomas Monjalon wrote:
> The error message about the number of ports was swapping
> the desired and maximum number of ports.
> 
> Fixes: bda68ab9d1e7 ("examples/ethtool: add user-space ethtool sample application")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

>  examples/ethtool/ethtool-app/main.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/examples/ethtool/ethtool-app/main.c b/examples/ethtool/ethtool-app/main.c
> index d380f69cea..b6bbae70d2 100644
> --- a/examples/ethtool/ethtool-app/main.c
> +++ b/examples/ethtool/ethtool-app/main.c
> @@ -288,9 +288,7 @@ int main(int argc, char **argv)
>  	if (cnt_ports == 0)
>  		rte_exit(EXIT_FAILURE, "No available NIC ports!\n");
>  	if (cnt_ports > MAX_PORTS) {
> -		printf("Info: Using only %i of %i ports\n",
> -			cnt_ports, MAX_PORTS
> -			);
> +		printf("Info: Using only %i of %i ports\n", MAX_PORTS, cnt_ports);
>  		cnt_ports = MAX_PORTS;
>  	}
>  
> -- 
> 2.52.0
> 
