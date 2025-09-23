Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB0BCAC5AC
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 13:28:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA3D9402E9;
	Tue, 23 Sep 2025 15:28:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 4A4A2402CB
 for <dev@dpdk.org>; Tue, 23 Sep 2025 15:28:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758634107; x=1790170107;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=kJZzbfxhI5xDjuSku91ERdj5udZZRtsfJavDjVC+p6Y=;
 b=glXY9OqU1Jqy9EE2h3TTS38Ox9bD3IHYIIbUgkn80PLMEIMx7T0Q5/D4
 aHvUldG9ZFyJzM3G8gemXye5xvD2YLAdDks0Y6Y2eIhwMX7mMmS4VZHmR
 DWQfnPaLSpnza105fkEqyGILQ02rmYRIx+PvMwXGHPHKYdhSG/N19n4AZ
 nfjxvMk3dKPSaY/C2N7n/leuVcSETWjeVbEBAx6R87TMJgGbL7Ta2wyby
 wcIxi5Z23JzO232YwkMzQg+Vl0QqJHl/mkcbzfrWwUcQFodOERhbifs7b
 M+nloOehw7DjvuYvaDUAuF3p/2Lzqffdza0+n1KGxt4pWuJ87nrTPLjtl Q==;
X-CSE-ConnectionGUID: tpUI10U9QYySDgGTnTyUfQ==
X-CSE-MsgGUID: ScQ97HH2SI6vntV0BuazZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="60967946"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="60967946"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 06:28:25 -0700
X-CSE-ConnectionGUID: N3CSHX3PRx+PublTeKkCEA==
X-CSE-MsgGUID: AsR6Bm+fQXuux0xRcbmEOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="181070433"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 06:28:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 06:28:24 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 23 Sep 2025 06:28:24 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.15) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 06:28:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5BYFx43z4QfwZ9yrcF2yJK5T/EeBAsBvldUlXwQO18+sFav2Wt3B1AuyPIUw2tl+lqVF/WjK+Tygy+ItJicKhJi4ZR+5CLVZm6Kw80R2eamL7upNsppIA3LEXXkzcKciRUiOP0OabX8WcKt9Ji4OZWtnEYJHpnnVs6CI57Qtz84zQ07hRBAHuaI6upA8aeHifNqROIcHtqP+Rmr6E7yE25ZqLaw/pa+XuHNiDd5/eMhILWU/wprkat5rok4EqJmTdLuRK942AcuQnQLXKF4TvquatfcgfTGwCoUAFG01wxVufQoZNhgZ3mNSLoUviiyi6dXLyvSkxTLqHIyA7M87w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejbWgtZ9Tl08cwrTPgHPqHEbumiibqCpWX7LtoH58zE=;
 b=FFZ8Rgwj11B43KrTZuE+pL28b0s9JBdXw6RO4q15bWUD8yxdthhtuwJLpt+faPbQg0N+1drQxsNQDlAASCtW5nRIIHvRMnCyXXiFEiVISRBbx8Bl9cm83vSsZBX7ra1SOzvAI3XWXQforkQZvHznJ2rkKBdI4cAiKzMGKpK1v8e9gwnGonvQaJd4Fmhm559LeCFNEtX8ETDhfjTeaFWN30/WHBpNVwxc8SR26n7gn+MapFIdHpiEGcU5DTmz0oYNtMIDb3WV+6cjexlVkwRNA/HHhmNq/hdmi/KCXB88XBNWLsQybDU0H4+hrraRXD60OMi9Ct9pAs1cdlG+smti6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 13:28:19 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 13:28:19 +0000
Date: Tue, 23 Sep 2025 14:28:14 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Kevin Traynor <ktraynor@redhat.com>
CC: Thomas Monjalon <thomas@monjalon.net>, <dev@dpdk.org>,
 <david.marchand@redhat.com>
Subject: Re: [PATCH 1/2] build: add backward compatibility for nested drivers
Message-ID: <aNKgbnlYLSvu1zgq@bricha3-mobl1.ger.corp.intel.com>
References: <20250922110708.47879-1-ktraynor@redhat.com>
 <2842623.IobQ9Gjlxr@thomas>
 <4a7059c1-43ad-4df7-a4fb-03ea938e6009@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4a7059c1-43ad-4df7-a4fb-03ea938e6009@redhat.com>
X-ClientProxiedBy: DU2PR04CA0199.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: 924cca16-9e94-48d8-8187-08ddfaa50f8a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7Lnb3dhk+Q+tqmE1CdaOrnf6+VjabtLoRI3apK8ghFVyhFt+XuYKJfhP/Tby?=
 =?us-ascii?Q?RdpLsihgUum+e5ur3zX99yR7qBOPL90gcacpT2inggwg4Ans9wCtO8re2BS3?=
 =?us-ascii?Q?OVWEVebBY4rpbS0wLYr9wecAlRzK2jIROFtIgX5srd4vnWtiPgULMbILRNjw?=
 =?us-ascii?Q?KK2Enlr6Bv8WI8Pdr9frpRVbc18Rz93358WvgatOg+/eijFvLl7YDqWJWgW+?=
 =?us-ascii?Q?rgKhvkOVD45A8wZJBzcwtAnj0QddbjLnV0Tmx87G48pYTt6G0/l58Nik9a/d?=
 =?us-ascii?Q?lcfhzlEMRDLVXuZ3QuIynUqazVvQ7DrHGVm6tVmzNSDHm6eMAdwtZ5OgUnR5?=
 =?us-ascii?Q?nVXhH88Pdj8drz+qgz623sXKlVwma9j+R8trkVXByPWKRA4aATz0Qo+v1+3/?=
 =?us-ascii?Q?LpYqrSrDo8lPRcErd/cq0PgZYhsq6J/Eqr29z1afzdem7B3uQQjHqFl/RkSh?=
 =?us-ascii?Q?OERL+KMU46UthIUnaLzShuQ8U2WZrfwlXH1t3r2s4wVak/bJjkeoNBZJBPYf?=
 =?us-ascii?Q?1RwA/AAmlKKtZxtjwEhP2C2Weh+uFJtHc0+W9iGyM+Ahmx7WQJS//LbRd1Xm?=
 =?us-ascii?Q?KzspBA0DxyLh2vmc2/+55EabvY9sNgXEk7Hwhr93OenaBdrxBsWx2Nbsju9T?=
 =?us-ascii?Q?e+zsxbG8Vl1QciCOx6+D09K60b17dULVehXwAfnPq0ZVM4R/ZbHo6s6yw/gl?=
 =?us-ascii?Q?NMLp83Ryi+uLaoLxuX8IrWbOr/dUeSM0/n76d5Vv4uOQeHyxt8pA0cOP0E8H?=
 =?us-ascii?Q?+m7jMJegfyCo8c/Us2uQvEoHk/uzZ/hYeS//nxwXxOeAX/f+m6r/LMJGDQTQ?=
 =?us-ascii?Q?CU4sNzKB29pL9QVpARcc2QturHZbfM+caUWtTi6J14cjxtpx8/s64DuwK4Le?=
 =?us-ascii?Q?JaLCHTU05qCl6rRz+dBp1Z2u12CS7DrzTacJTKfDOBFXoTK8tc0BX9tYKOeD?=
 =?us-ascii?Q?mxsAC2W4GbGQG480n/HOkajWJUaMs5/4WHkiylZK6jiltt+Au1G2ksMsURD0?=
 =?us-ascii?Q?TsOS0X/w6bo5DdILZZaV5FCn2He04ZdN0cmPa03DVG0TXu5FduZf04Zf67lE?=
 =?us-ascii?Q?hGiaWSX5FNzk1Bofwssrpmtdak/GGpvsSjU3rPUmgJjFhkoL76VtLdOqp0G5?=
 =?us-ascii?Q?a9xxhQG8EobFJ9XVN9nDCh3DcFqtZfNlZv7mBOccncH/vCegkEE2h3et/FOr?=
 =?us-ascii?Q?3c/hIK6OKcFqs8LWD5lfUnv9o1zQXn85XN5j5Xmi1nGfs68Q65RNKCp6Um58?=
 =?us-ascii?Q?IYtNozNEWO9Zy31zQ0fL22lFe6izgnG8LOEQS1Zd4yHir5nkhy3RY1ttnHbW?=
 =?us-ascii?Q?RE6qXq70ki9bmOzb8K11OYGVQLtj0+V7H8YFjt4dT78CzY86YIJZuBFJuUeb?=
 =?us-ascii?Q?pWSFdg2UuKncrUcZdHssVd9DdHADhcAHO6V8qCADt6WNiKzCpuAmZG1MphTs?=
 =?us-ascii?Q?XB+g8Q3KncE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O50xCbXEZMDwxzYgXptKUvTll8n6cvexwm4nO+aoO3xra7OKqCQgt0SmgzYp?=
 =?us-ascii?Q?ysbV5XusjxHyT/HUj5x0seErde19m+zfFbK7F5/zOAUpRpRhlI+UNd1oHq3U?=
 =?us-ascii?Q?Q8bKC01ANTEevjJV3SeIEyS9gP3jFN+lqduWKinmzpTPvs37Gozf1g8H8tsz?=
 =?us-ascii?Q?4Gjo2oodbow4l83Fkg4xypsUejHGswsxL5R2+aLoWvL5yWGyRDq6pRfRcRBN?=
 =?us-ascii?Q?qqnVzkIiUF3BkLDrN88/FhIMWu4ElAsi78DSn0ET69tZdu+tgy2GTSXbEp9E?=
 =?us-ascii?Q?rEzTMLQoUnq5DqII18ZxiuYra3585SPLot6Ye+X9bRxuOb20ILKW61v+5Qcf?=
 =?us-ascii?Q?OuYgpBZF6CXlA9DkByXc4tCZIb8VdMljsEfHjv3paKEH6+x3p/1SdPyPoF0B?=
 =?us-ascii?Q?cdQEy/lHbB/qi076UeHCmrLSxUVV8L2fs1kAcuARZ1Ibde31wMEHuhLOvPMp?=
 =?us-ascii?Q?1znE4xy0Ez0kX4gMqnva7WyQFklDU4s7XgxMeMgh96Xpe2i9Er3INm298dC5?=
 =?us-ascii?Q?AidaRJfWXjEU130Y2STCqKlFokps3b67LtAVTw4jIum63YHQV6SR8H5mRVFV?=
 =?us-ascii?Q?CBN74Z9xXcPlJHLLkyQ23D8jlGGZwrxjAPPYuF6BmRzLBq4I0NHGsIhYCUgF?=
 =?us-ascii?Q?O/efUTDlMEhWHBa08lVMoyYd7/vpFM9HL2hzL6qpJx1sj7HgiC3YdFR5kFcZ?=
 =?us-ascii?Q?9zAnhfVYTjaSVOwrccoHGb/Bp+oWt056l2v0OVQN/yYI0vTYZryTOXTc1cx+?=
 =?us-ascii?Q?GHoxvjXNKPSL5Bqt3roMQE+ThsRhF/y1fn5y774xvBoyNPGroSJhlzRipxEn?=
 =?us-ascii?Q?g7XPAlzcuouPUyFtM870J6sM2F01xqyOrq02RUL6j273jjihGzCTUCbF0Qo2?=
 =?us-ascii?Q?9PqVc8wUagT8ZNH1qbt0ky6VZJJdZUVhBqrRjsF+x/5Cjdgiqa35FSFIIQA8?=
 =?us-ascii?Q?izzpZdtaG9OV/lRUcYlTIOuBloYb3KlLLFGJh5eB518g86klwLzG4pswjFwy?=
 =?us-ascii?Q?xUeBP6JONFMRV1Cs+uMY4cMdNGVh58L+AN+HzVIRqzymXASBrTlEZPOiWlLN?=
 =?us-ascii?Q?z6DGkkiO9b9C1G1xcFmTIZ6HlTyqJKQM28dWCY4/cz29cEowaMEVspRMQwKP?=
 =?us-ascii?Q?kSAyLwt24XO4tyitqNzxIx3L6hAtVekM0/0akrDQc5sDb8AWqq4wM7QZwI76?=
 =?us-ascii?Q?shftXaTvVUidWjkfEZxOJosClzhOXM8W/2AfJBJjmwxbU3NrcBGAUQnqc6wp?=
 =?us-ascii?Q?BEGnWJ7NNxQlsucpI1CRtQclLOBLDt0pkGgDaCYW+5QbxOb4PKxIiQKL9qhe?=
 =?us-ascii?Q?HWJ+KncuMlbStNSldyr5+SQLhrY0QLEq130+M8MC74MZBnjQgheOB7FfcSsZ?=
 =?us-ascii?Q?7CS0tcIhFnmTDc4brVeFMindeL64cQIESO5iDNw7ina6dFIk4uxR0+Egg6D+?=
 =?us-ascii?Q?sjiiBNc24yNnRoxpL6I46GmcndbX04VzUtQf3986aAciw0y3vKjeX6yy0LW9?=
 =?us-ascii?Q?iXXZOlUu5aIEV/2NS4AwcnTyfkEwYvbANtkcjLe6GswDlO4ME0kf69FcUeKh?=
 =?us-ascii?Q?NVuaP9OPMoMPrpcIzz8dXxpH3QKDXG1y+LQyf6r5xoFRLtavzxMVZ71pTAWZ?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 924cca16-9e94-48d8-8187-08ddfaa50f8a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:28:19.6318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R2u7wWKeIGf0ys1NfCGJ5ue3J5qtW+7DYIGPyohqPbA8aBICIHm3Zl67mCxrHzWoPJftA6U2t2tO1B+cEzi8d+ShSRvj8gKxl35IdQ6H52c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5880
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

On Tue, Sep 23, 2025 at 02:08:35PM +0100, Kevin Traynor wrote:
> On 22/09/2025 16:51, Thomas Monjalon wrote:
> > 22/09/2025 13:07, Kevin Traynor:
> >> --- a/drivers/meson.build
> >> +++ b/drivers/meson.build
> >> -# add cmdline disabled drivers and meson disabled drivers together
> >> -disable_drivers += ',' + get_option('disable_drivers')
> >> +# map legacy driver names
> >> +driver_map = {
> >> +    'net/e1000': 'net/intel/e1000',
> >> +    'net/fm10k': 'net/intel/fm10k',
> >> +    'net/i40e': 'net/intel/i40e',
> >> +    'net/iavf': 'net/intel/iavf',
> >> +    'net/ice': 'net/intel/ice',
> >> +    'net/idpf': 'net/intel/idpf',
> >> +    'net/ipn3ke': 'net/intel/ipn3ke',
> >> +    'net/ixgbe': 'net/intel/ixgbe',
> >> +    'net/cpfl': 'net/intel/cpfl',
> >> +}
> > 
> > Should we build this list inside a file drivers/net/intel/meson.build ?
> > I'm not sure my idea is better...
> > 
> 
> Not sure. It's generic as is, so any other driver moved anywhere could
> add to this list here easily. Let's see what others think.
> 

I'm fine either way. Having a general list may be good, as we may have
other driver moves or renames in future too.

> >> +
> >> +# add cmdline drivers
> >> +foreach driver_type : [['disable', get_option('disable_drivers')],
> >> +                       ['enable', get_option('enable_drivers')]]
> >> +    driver_list_name = driver_type[0] + '_drivers'
> >> +    cmdline_drivers = ',' + driver_type[1]
> >> +
> >> +    foreach driver : cmdline_drivers.split(',')
> >> +        if driver_map.has_key(driver)
> > 
> > I feel we need comments for above parsing.
> > 
> 
> Ack, will add
> 
> >> +            driver_mapped = driver_map[driver]
> >> +            warning('Driver name "@0@" is deprecated, please use "@1@" instead.'
> > 
> > Not sure about this warning.
> > We can keep compatibility without saying it is deprecated.
> > 
> 
> Yes, that is a good point for discussion. Seen as support for the legacy
> names were already dropped and I wasn't aware of any ABI like policy
> about it, I thought there may be a preference for deprecation
> warning/continuing to move to the new name only.
> 
> I would be happy to keep the legacy name without a warning/deprecation
> for a longer term and we could adopt this as general guideline by
> default too. It should not cost much effort to do this.
> 

Agreed. If we do decide after a while to remove an old name, then we should
do a deprecation notice first.

> Another minor point is, if this needs a Fixes tag? Yes, in the sense it
> feels like it added a banana skin for users (the patches are because I
> hit this issue with 25.07). I didn't add it for now, as no guarantees
> were broken and there isn't an upstream stable for backporting to anyway.
> 

If there is no backporting, I'm not sure it matters. Maybe add one anyway
to imply that this was something that should have been thought of in the
original patch.

/Bruce
