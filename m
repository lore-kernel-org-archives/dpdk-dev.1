Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A314E63F3F
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:27:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8732A40296;
	Mon, 16 Feb 2026 18:27:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 6E52740289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 18:27:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771262875; x=1802798875;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=nmQ8hSdQarjWOdhdzNZDw3UwslCYMFee/SI/4MxxWH8=;
 b=QmNJlvgLljzaPN1rKXWQd3Vjg+hRJTjRHnJvvFIL4U7YDiSnObk0BbZT
 q4hmVwzdyEKJUGP2Uc6g1gPEDNb0VLJgcTmOuHTsHCBBQEDlGNxg6lD/D
 /vd0E9iit6Cjk6nbdn1gAfSgGw8zbxa//eUBu6nGExcyqh8X5ppq4AJUu
 UuPiQPjtH0qEZtLP+tqqG9H/sjykrCBhxjPR+mILD5D/WKonQk/7roUzG
 0RnqFPV1sHISGSSCaAI6nw+PyjMphXEzrpwpY/RLpe3zGNp+RZub+hvx0
 YNuan/CccEmnp0dfBaMBngQhBJyItGbv1LNszjezXY08a/ZFtsATfcOUa g==;
X-CSE-ConnectionGUID: rMyzUn5wTGuIRsT2HBnfcw==
X-CSE-MsgGUID: AJ1xROAESdS84rGombKDUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72518170"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="72518170"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:27:54 -0800
X-CSE-ConnectionGUID: 6x5srY2JTn2roTlG2UufaQ==
X-CSE-MsgGUID: wXFTAr7aQtaEPyW83AQaAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="212445074"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:27:53 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:27:52 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 09:27:52 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.10) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:27:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4wTM5AbS+/ku21MN/mZ0FTbkA/wiN6Vbu9GyoJygS/scxdkoccsolp6sWu0ddqHg00MgdoDFhhduEgnRG82THoreEokRiNrIlvr1PI6iAPe1Scb+91s/g2n2pUpbFF/tt/KMyYPMsp0Tg1jKcAk4S7FvO+UqpoEkj/+xfD78y6bdXb4qagfSmEgkCh+on4Bk0nq5kDu88QfH89OkNG15BemJWZSKUbfYdCOhdU7gcrhGugfybq1Cy9Kj8iQKy3uf1awwUygcTfNkmzo7qEUmuw3KO2ThV/hpKfJnlSmNU3i2YMTHe+bm5T1WA6GsuIgsUCR6jiX2dR07Kiu11clcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLMpP0Z3Ujldu9ZcUKgDjH2P4jAKBah9zGmm7xrsTCs=;
 b=rLnd76hbprtkXMTAM/Xq9IEZ2hRydDT7zxCmcp5wJ7j9nZIqME/7WhIqbPXIp3xn73PiD2X0tuq85v3dhvqQ/GNGNlEDMMX0o/vO5AVXXgIq0KCK0NfiYxvhYO6ke1h7uCZ1RFWEe+t5VvWIL/+xAyK5ha31JKboKiiMPZtdoJ6Ga+Et0pEZRtnWR/yjfiIOVlOnCIPhCoTj76aJHRkaaK9UGfv3J1RLeKOvasnkwnZuPT3FlLIpexD5IEcgkEZkF+7WzK05unrlu7DAg29YBK6lCXQAg9cHK5nHQEmzGCDyiX/4E0ay/0/9Tbd2wE6lH3srgEkULlNTMxfav+Ho0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8518.namprd11.prod.outlook.com (2603:10b6:610:1b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 17:27:50 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:27:50 +0000
Date: Mon, 16 Feb 2026 17:27:46 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 20/27] net/iavf: avoid rte malloc in MAC address
 operations
Message-ID: <aZNTkvpt8ahCdoSS@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <ad3c77be6c74565b7a9e4544b6565ea91f94fc70.1770978324.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ad3c77be6c74565b7a9e4544b6565ea91f94fc70.1770978324.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0125.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: 755b4282-1014-4aa8-bb11-08de6d80b5a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8AkPlTuvKUfHIUlWxiEBWyrQuxuF7Z59CtrnAW+2DByIQSneJUW6yFoR3LJK?=
 =?us-ascii?Q?TZ5Y76AxirrcbM/X37AtV1b6P/g+hrehaHki5stPBNM4VJNqm0+cynOyeWBB?=
 =?us-ascii?Q?A/FAhcYlqrPR3gxBzvPYuv8PsBLSVwl4JUBPXF9Ru/tsksyXDkaACn5wydGC?=
 =?us-ascii?Q?yliIt/hAsmz9jn0gXAVOKEllIbFZV91jHroFOAN5PnmkmRJj354V1eftlFRF?=
 =?us-ascii?Q?ZiSTDys5fTi73aXMnQGNMOdqzlA5xZkb7aD1mCuZRCXvjWyuWgdTMNzgIAFn?=
 =?us-ascii?Q?wsvSUqoauIl6lTG+4z5ySg8EMaKxsUzmC2RmW7yYyOK8ByHmVdPvAF3jeUlg?=
 =?us-ascii?Q?YxjN4fVUQ8LO5/g0hxUBK24nJaBqsOHtMKdXO543Aflw/fyNS0W3vJpEBrcE?=
 =?us-ascii?Q?cq1SfkjKrPOqXXrd8c5erKPAdjw/Do4SkbMAXiq4pClgkRFcTwzKyUq2pOSz?=
 =?us-ascii?Q?/P1gG74UVJOq4PVCitFfUBcgxibVQctLrtOod8txm3ZSuvSybDSDo068XiZB?=
 =?us-ascii?Q?xGLKDs9AnhLzjUsh3KlkczKEIBOsJexxiH680/v//DyQbep1VE5ZSCXVzySi?=
 =?us-ascii?Q?hFvun9x5jXmXUIJchAHvH6nb2o4L0Vvv0BHFrs0zrb37d7h8yHpMig/Y7kmM?=
 =?us-ascii?Q?KbMvcdK09/Ze0siikjU0qIgMIDntqZKGuRRAsjEh7D+FIBMZsE5w1XzWF8pm?=
 =?us-ascii?Q?TLrybxZYZe1kSs9g3KC1pY2x/oQUlo4paBLlWSe0sBnvp4H0FYs46qY8Ar3n?=
 =?us-ascii?Q?xQC17RpewbG3uQTsdrJTs9DeDLbCgwU6dVu7qs+nHxv7YgJPDXlfW28g+WsJ?=
 =?us-ascii?Q?53uXE1DoXoWTHO4ES5YdttVuwTDeqTAJwkEMIesFbKiVIxGumxKfkF++9Ltg?=
 =?us-ascii?Q?Kt+mjIk2oMpt0sIr6X8zG/bdQ56iZ3tqjY7FQx1zuTO91b8557SX9ySq9oGn?=
 =?us-ascii?Q?KVHDKls5FfC8WI7ERJLNTsaeP6CPzd4AMcZTdsvRpG8uJJXYwdAaHpldfuFt?=
 =?us-ascii?Q?Gi7hTWFO3zdYhccrcw+in79l2Wj2J253maXEDIHPdqgDoGL4oXQnf6lyzHzU?=
 =?us-ascii?Q?l2jev3rZke0t/9GxcrGtNtivJd2+Ppdl96zcQ3u8g++I7SXmtL3Ux20+mK0R?=
 =?us-ascii?Q?0zBek52OvLu2yUTyKeCehx5Kr7fPET4cvSZ2HlAdcorEHLtAoKXjcOWEq0fK?=
 =?us-ascii?Q?ehqhIdnw/ACpDsTcuXNQOqnxmR63twaOtBBurzJ82znLojWURzVidjoZKSCf?=
 =?us-ascii?Q?sucn9fj1sqYJnhy8yfMvtIR3y07rzUL6fJqqwhp5ut7FGgeSv89LwGbPvLYr?=
 =?us-ascii?Q?JFNwrzQr1MiXrDBN7CSGr7n6nE+wSbHe6CfebFFK5yk7piOVVOd8hyl46wZF?=
 =?us-ascii?Q?PMdADzIQZjnl4/S6l1Q0dIKF20uxBiPOVYNeWmV+TgHqncairKJIBWwdTtEQ?=
 =?us-ascii?Q?lofWs5wyB/6lWRI92k5IOeIDy7LS60V2t4rjTjb9JEK4eiI+Ki/Fl4a9pk1j?=
 =?us-ascii?Q?DH4rI1mf4tpS7Qfv+JnKOzz+TsgcX6+wnp1X0dppdxq5iy/wzzvSh7+Sft1/?=
 =?us-ascii?Q?4TDfOh5cxejjPnbo/NY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/TNEZllzSXk5NMzKSwRGYFA3NSBu/YM9idWfsFSl1R4LTaIQVPWEKj8dhnnu?=
 =?us-ascii?Q?iveDnPAphRht+AjB0JNdxXhyjjwrbw25UebVYqh8AxrYYT1S+iPilHuqNVXb?=
 =?us-ascii?Q?lhW3sMeo2fztvrjqqaq66zu/dCxhdM4sPvCcYDefBfLy09qdLcQLqAB6cVPP?=
 =?us-ascii?Q?YgL9Txi72GtQmmcaYPWwZpU64Jd1U1JvA5qvWvl9xINNoeCJAX5fLHc5ChQ0?=
 =?us-ascii?Q?1BM0yVoRs995BNSjlWVR/XgMS1dOMz1TQQ+iSw6EFhDVwmVE8Li4c9T3verj?=
 =?us-ascii?Q?ke3T0ojHhBQbjMqPykm4OZrWcpCMtw6ZVeyzjQZiXUz1ModinOJ11+i3fkgw?=
 =?us-ascii?Q?1Ly0ne1sSYoyS0c+K+ASIOxObIsfbbQX89NNIpbSRI73nKa+7XQFocgmuuHt?=
 =?us-ascii?Q?PHwdm9bUSF1qLEsMMAfcWmIsgNTSXQVx+iXUmOv/Xbtb/fZB8XHJ3f6HJz7i?=
 =?us-ascii?Q?wn6rq/g4efU7UxWkZXHtPxvtHud6vRgQHX6dlXHZlMyznVmBJI77JAXubOmW?=
 =?us-ascii?Q?ME+GGOqvuYHSCo3KT5IQJcHU/98LSgFIwmILotSb2lonUxLSOtue5r1v4fdv?=
 =?us-ascii?Q?wwXROWFlS9VLbu6HFD+t1X0ZtfTnIUZ/LfhC3V5rfnqWi3uaMZm1IP177wW8?=
 =?us-ascii?Q?gNPC9su/e3unSJnlMe9QrJxc63zRmm9bmjKZs/fRh+smpASNJC92nWqhbzI9?=
 =?us-ascii?Q?3VdKpGg/C9xtZ6kNwH8Z/X8QRCGmUfL3MN8O4W9gCg4ecrJGmsExgIP8+QCt?=
 =?us-ascii?Q?ZDbSRj9Ki2jjDHxa7MDAKlvHA273bJMHZArVNDPIgMmBgTn8c79vCXHq1KhV?=
 =?us-ascii?Q?dT3dgjdyHyclRK1yLD3XJ2+sPjCfx6GKXZmg0aVyjTsAel2ayiKjseXhoBdf?=
 =?us-ascii?Q?cohBWuKO+otqkyrXVDYx5WMH2RTRIUP9+e2TH+hpDR/G2ha+f1//lhOWw0RO?=
 =?us-ascii?Q?9hLCB6ekfJBsiQPZGZEiBXNVGYb4qJBAY1QkWDb5Mk7jG7Rk5BAvrLUUgEO2?=
 =?us-ascii?Q?7/HGZ0x9jaHiWcQnvo9sagtFrCbGO5WfSXT2Hz++JXyEguYiAvpZyVB2j3C0?=
 =?us-ascii?Q?E77g9EZYaABgx6ADFn/zRTL7XTohESoZrrv0PtAxKGVxzSDGIKG25gReQ1NN?=
 =?us-ascii?Q?Rqxw8N2k8OPvGhCfIMnwj6/R2X+a0FH8+GmFbBJNKOywrLIQWR1zfgiOxCz0?=
 =?us-ascii?Q?56CXROs7R2MBm8EF+c9IhwrvznVSU8hMSgWE2X3zXZijPlacnWXZpVTnqg0i?=
 =?us-ascii?Q?ifxkvjQlX1pHHbD86LZkQujcxz6kse43N1MGkYZdRLN2yjC3YWpjbt4uI0Id?=
 =?us-ascii?Q?yqd7CqakFdep5AJ5xIIAci5i9Bga8aiqQbqm3AmpSYISfYP5AVuBKRVCvTxJ?=
 =?us-ascii?Q?NGdJeWS/pjMcSym5Roa4AEqws7d33HjkolD2a4Fctdgpd4IokQnxIPyQTt7n?=
 =?us-ascii?Q?xnqYF7Dhb4dl86WEv4b0Qv6GZsqablhOfTUNwj+qF9sVuGKK6RX18K5pI70t?=
 =?us-ascii?Q?jRPBra3d6bIiZPcSyF9CtqZEOQTb46UslQ+Jpeic5bx/iCrSYokv6VzXHy9I?=
 =?us-ascii?Q?IpwQtVfXwWI/+TQcOBnCO8A2En5haA0O1ldeeN2jL7mfnftIGlSx3m0VCTJm?=
 =?us-ascii?Q?fWVqPhq+Aq+sKQZ7LXeQZ/sIsRWGzX9k7Omf/L9sdsa3OoCPOORG6qSmaFDu?=
 =?us-ascii?Q?EFICuRs33VY5y8naLxf9Tj71bumUgfcGdHzF97MtfNOrIyILurCDzCbM8AjA?=
 =?us-ascii?Q?0fALcqDMOq3BZ0wIq/WCmwjtxaYWtlU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 755b4282-1014-4aa8-bb11-08de6d80b5a1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:27:50.5893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+o7RVUKNyfzNjPxC0lN8ak22nHTT0u/8gBTdhP38JjGDb3wL5jUtvujXWY+EkocwC+5uJKELf+VUaCR6x+fPP2bQ49aErjUl9UyFJAKayQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8518
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

On Fri, Feb 13, 2026 at 10:26:31AM +0000, Anatoly Burakov wrote:
> Currently, when adding or deleting MAC addresses, we are using
> rte_zmalloc followed by an immediate rte_free. This is not needed as this
> memory is not being stored anywhere, so replace it with regular
> malloc/free.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_vchnl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
> index 55986ef909..19dce17612 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -1402,7 +1402,7 @@ iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
>  			}
>  		}
>  
> -		list = rte_zmalloc("iavf_del_mac_buffer", len, 0);
> +		list = calloc(1, len);

Given the loop above has a threshold set for IAVF_AQ_BUF_SZ, maybe a static
buffer of that fixed size might be better?

Also, that check itself seems a little off, since it allows buffers greater
than the size, rather than ignoring the length of the address that pushes
it over the limit.

>  		if (!list) {
>  			PMD_DRV_LOG(ERR, "fail to allocate memory");
>  			return;
> @@ -1434,7 +1434,7 @@ iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
>  			PMD_DRV_LOG(ERR, "fail to execute command %s",
>  				    add ? "OP_ADD_ETHER_ADDRESS" :
>  				    "OP_DEL_ETHER_ADDRESS");
> -		rte_free(list);
> +		free(list);
>  		begin = next_begin;
>  	} while (begin < IAVF_NUM_MACADDR_MAX);
>  }
> -- 
> 2.47.3
> 
