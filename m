Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC63C531CB
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 10:54:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D39440678;
	Thu, 23 Jul 2026 12:54:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id D09E34027C;
 Thu, 23 Jul 2026 12:54:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784804044; x=1816340044;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=12e7gGXuukpkixC0VgDkK81fzUqQo0tR8GwxHBIQRr8=;
 b=VLwZdEEGqU8/FhxI1CZRDjE+CPNPG9415mNPp9y+Ze4aaw2vw5yhV+Mw
 R25cNlSVhYKF6WePIEWyOTE2kW3N/FqedsYEQJB+Kv4oWRa4F6BSU0ap7
 yxAuyBz1KmyeVPz7SkmDnyOsnJcpeM3AdqF9oOOkcW/2PFApFTnvRghtE
 Kn1e3xp758d2f/MSDVTKag1TJ94hNQZnkv6Y4hkAU6XFBOUtyg02GkqQ2
 /VkXHKMMBtcd+hZwIbiMoJbBOwLv9Z3ieaQ1/gITzky1ylJlDBmUpYt5z
 aAstVBZ3kWDny2lZKHqnxKF9dLsQf45sSrowA3Dp+ozlo3sDuTVs7B6yp Q==;
X-CSE-ConnectionGUID: ocPxtK8QTkWQIGA28RV71w==
X-CSE-MsgGUID: JwTPrd0dRgm58yhIucAOQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85502321"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="85502321"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:54:03 -0700
X-CSE-ConnectionGUID: riZTDMLRRZqUPUYAUATO4w==
X-CSE-MsgGUID: iAK8KLozQJyV11HJSUiwdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="254030871"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:54:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:54:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 03:54:02 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.17)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:54:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrslF/ezlgMJADOISUjEILjRGXgdk5YMnbPJn84OnFsijQIDZBOEozZZ2uKEgdCnjbnbg7XMA2dvXOXok2hjpRR0M0i0r1fytpgpWdcQ1jqmdsed9u5XHj5NczqFTQDR90bJ4FUfd7bTtjhgTnTe7RFA9k/uxtyj8VS42RXG3P6kvb49muAkSFOl4Wsf/2DEAyf3d939t4HLimuEsTA6w+7yrvgbu4UkR9vpOqZakj6VgbZ0TO6sJkcKFdt/sXwvtYGhdubAuuSCc6/L9Z2C6cXNMJm7zbDj+ZF8MhtLO8lcFo6qSxhDzIxUU6NkYN/yhFsz1inenR4lo8nel3lMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Me1ndfMGQ+tyWwa1gKLaNQB45aitn7sFAA0+Hoi2EQ=;
 b=B1m8CMMVI3Sxg6tuCH2d2ixQmwvCA1uyzcsyOlX+ESYvdzddQ5i88Z9QQ5xGJMZMmD1YUnxcaLYN5bAvZfMSYOh3JUeguEPA5jse3VurAfUo5zvQAFnH6vjOfJuJSQZ/oojynjGEPK0tWvY/LEajqk6owtvImQCJ5/n+t8cak1qYOFi6H/Rgm0MjE13E+tY8b3EMn8oSPee9/n2m6dO19Xfs3o7syE/ZVSSmNOlMfIV0ozoeC2yonlaOR7ECd3f2GW1En5Zi6pTWxJhQVI5evYnUsaThE5QNLMgElGt7jvz7lUfLN7mdWF3kB7jNBRyqzzTBP+UwbzO/XoGHm7UtZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by PH7PR11MB6746.namprd11.prod.outlook.com (2603:10b6:510:1b4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 10:53:59 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 10:53:58 +0000
Date: Thu, 23 Jul 2026 11:53:54 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sid Ali Cherrati <scherrati1@gmail.com>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2 1/2] net/i40e: fix return value of close operation
Message-ID: <amHywjmk5TPlsaUj@bricha3-mobl1.ger.corp.intel.com>
References: <20260710134639.108129-1-scherrati1@gmail.com>
 <20260715124816.19882-1-scherrati1@gmail.com>
 <amHttKyBfKqYqTXo@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <amHttKyBfKqYqTXo@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0087.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::18) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|PH7PR11MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: daa75eab-fc05-44a9-3055-08dee8a8b2cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: aqoxdIFq1GmLn0tLXd1XacRuY7JTTOoWA9ZWu2y4MWtW4SwfMEF3fvYvGm/bp352pdFkJZkrMNZCblT/WoTEn2qH+AODlarpZ8APe56DZQQKJGzk2xfT94HWTMEmomcunIvxRYGObp+okIo3d0SqU1kk6WELGDdEre7e+4CRRaYxySmXNiesqobvFbw7KH6Ai7vDOQciLsCFn0Y0BeNUSSrRQxx4H3kWLpcu3JbpmeNLtKSVooxxCZ7ErTgLbw/MTUeDujdU8qR0XkO8DEYAQjoPdA5iWgvtiohfqg7F0w6cOQQKUqOZRYrihTXKCN3lbdgOQC6hqg+GDxWzoBG3vLQhjwPWBIHkthtwAtnX7S8Zc6dxehZPXVEI6IEzB/mYuq3mIGSWT3u6aXULGa4DcbF10JDIb4x5ClTP8twiz50vOh2hAuQg4KBcNwDkWewdZqMbrTTusegq4mwg8TJItMlSbD8bDU1nmacYBqheksoMHzsMpeYhx0y68De/4MpbUWBRmxMkLdGS9bfpKOwEV85hZzJ08OIzyBa4J1ar76b37ryfNTABAevpV9o2cEl5/0FXiTVNWaFDzAdkdI8eqDzzaqOx2m4HkPGbv0rY8lf3E3hntjNt2XnhT+/gaWkKju20BIgvSYnOmU94A6aBcgFMHkXkWI8ILH/kV+GKAWo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O3MIzfuxNYQ+GzmizgO5zoTXG8vqkBZ48b1KNS4b7Bkp+k7SUWwG/2BEyAby?=
 =?us-ascii?Q?jVy8qr+ZKgEcRHbUvPHLvzQkS2LuHrYp4b9NbMiDzdWR5ki6K50rZamlbooU?=
 =?us-ascii?Q?3mBWUUW3GGbLo0RwfuLUfK3LCWEMMFsEdT1R90Sltme1qGt7j0V3XOi0J6kL?=
 =?us-ascii?Q?cp6nPWnPUEop7dItTCX1EEycrV5YtDYAdmFfGaXY1hsE5Umx4mMuLyYjNKxY?=
 =?us-ascii?Q?2EcmzveaqoAwoC/akqcyg69oyP0NPwd/i8z44QpEQVxAHCRPcE187YfM3dcU?=
 =?us-ascii?Q?4cKeButLYI97pUZByNfon7+/ErQNMFMVHjIXcHV5adtGlabcVQEc8XovftY4?=
 =?us-ascii?Q?uIFScAAzdmoEg4u7v4TAiqnZqe0JiEUXymXDhNP/44T6Dqqr9jT355mMjcQU?=
 =?us-ascii?Q?dvqqcaxI9LyI5kn+lHEsD4m84mstJKiLNFdlyKpccR8Md7umYVbWLuINtbwx?=
 =?us-ascii?Q?BaD3rTvgdKbdXtk+4UT+SB7W0SKGdZ80UjZvvRe59OXZdrEGaUApf6fUMEY3?=
 =?us-ascii?Q?2Ft/MGATFsQGUae6sTeexeTWhCfWCTC8xg8rxKCoeJIUrTh7L0ilkiAVKZ9c?=
 =?us-ascii?Q?hzGIxCrQ4MkRz4odnsXC6cS9r0RAgDxu0PPmxvXNK4Ld/+oyTr33eONSdzxG?=
 =?us-ascii?Q?aX8Q3kjqZeIjqxEMnUIR7B2Ylw4H3OLF9eFgk0LgUDhx2Z7ycpTkBVAXqk5l?=
 =?us-ascii?Q?OXI+h1dvxx20goCdBrphDtFRMVLdEl+ZMLIn6ZePk2SnuFa/we3pcmABFGOq?=
 =?us-ascii?Q?FMADT1YF425BuFPzX/3eSdfBTe9FTPGvKNXLHfEMoztZKG7wb54D0c7NMnCB?=
 =?us-ascii?Q?m4I5AZu4hZwTGR3alCmd9xdBBePfcKAzPYFhNVCTolmYSY8F3noNgruAmkl4?=
 =?us-ascii?Q?lo//DKTjv6W2BZvlvlAIDLw3XBZlmNnWRqzMp7mnqwUnDCc3CRzJjMSVSQoa?=
 =?us-ascii?Q?5qlgPVXjR74eWKYl2D8Tzncdyr/79Rm+qeVxWmoi0en5qhTYHRnTUJmJH1se?=
 =?us-ascii?Q?GBlfwIkaYo2hLlvzi2LX0tkUZfdVSxgJ1NInP6rmYvWSiSZnxgse7wKbYutm?=
 =?us-ascii?Q?qvD2ePQhvb3d7Rn+BNn1C5jg53PJu3mxF14lqVftozh136FYjOGj97keQ2yC?=
 =?us-ascii?Q?qjEvJMLNbPF9lh13pG9PX4JPfA0l1fLsNzzicU5WIvHE7vMaRhYy4ngx61UA?=
 =?us-ascii?Q?T70a8UqltKfwGBJEhcE+mkHOvH54TjWmtHdKJjP4divMb4HZl10DCcAyMfzC?=
 =?us-ascii?Q?5AB5db9QecWMSftDjRauMc6YLKjS4Nqi4ke93boZ7X3pJ/n2OiG2EkvqrbSc?=
 =?us-ascii?Q?mDPH4AO+AIn7LqkclEAgPxOL50W1yB/agP5TQjX84+Aeel/DIft96PVUBeoG?=
 =?us-ascii?Q?kLMdTd9ciFZ1zPQTeYn20Ter2tI9Ri0C0sLbPm4CYDC1RRnoPp8CUWpyxfPE?=
 =?us-ascii?Q?yTAECRiWIR24JqFLE0UTtRNgmHamTHfenh6KXJ/uCVWe/E0A97NROsX1o3lj?=
 =?us-ascii?Q?7HABkVp4x22rlz3v6jJ01X/hP3BSadPuU0G1z+Q/gU3wWov71HueAAeDRfMY?=
 =?us-ascii?Q?/0E/UfiPyqHV4I+EL2qIQNUkVZlbz2fUBZH46SEw35gG3rvE0Hzz0jNGLTZ6?=
 =?us-ascii?Q?7YVVssg19TI5dKpVQIqk9SFm2HkOoVkNQ1y0QpmBBO9gd2SJ9BVqxLkZCcjr?=
 =?us-ascii?Q?zbK/HQOCHhqq+RDoZq9bN60P3FwklhrhnEbpbLxs9HkDQ7fboBsDPV6updqW?=
 =?us-ascii?Q?C/3USs+V+omK657HUKwBfqQ+IU2xy4A=3D?=
X-Exchange-RoutingPolicyChecked: liIPYu2Mr9vCXQDdZn0KFrvTh/dNO7l2qFtd4BmXmJNjDEbWZEQiJ9Mr7ThTa2fU24G52Dzy5pIxH1N2P6M4SEIDEog8Qjaobc5smNCpXvcgR+wWREcK4WAMwMwHH0eC2ADD9CWbGv5OE1aZES1/OXO7tb6QwzSbekUdugERZrhVAGa2hxE/DdhipfiglnLzEkAznnS60WLPxPMZdzYcGWeX4efwlNZRszT9wnz/LUykR+9NbQhU13IBpVDMUDRxrdkjsEeNjBmhEizVfqq0Tdxire0n6RS13kQ+9sqbv60YD6aHVswcOEOBYV7ZeEylxKSHAUWuMfqgyG4/CpEj5Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: daa75eab-fc05-44a9-3055-08dee8a8b2cf
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:53:58.6976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uON4Q9RmvKPgqR3cFhZQ0e7OY1A39muictSN/qBdX+rO/0PFEA5uz5FznuL7Ya3dLz7IXJS0c3nbkLHI+vMY/n81Wqz3YI3UmeY4QUw/wXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6746
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

On Thu, Jul 23, 2026 at 11:32:20AM +0100, Bruce Richardson wrote:
> On Wed, Jul 15, 2026 at 02:48:15PM +0200, Sid Ali Cherrati wrote:
> > rte_intr_callback_unregister() returns the number of unregistered
> > callbacks on success. Since the close operation started returning
> > the ret variable instead of 0, this positive value leaks as the
> > return value of i40e_dev_close(), so applications checking
> > rte_eth_dev_close() != 0 treat a successful close as a failure.
> > 
> > Use a separate cb_ret variable for the unregister return value so a
> > successful unregister never clobbers an earlier error stored in ret,
> > and stop retrying once unregister fails with anything other than
> > -EAGAIN, since those errors are not transient.
> > 
> > Fixes: 62024eb82756 ("ethdev: change stop operation callback to return int")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Sid Ali Cherrati <scherrati1@gmail.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---

Both patches applied to dpdk-next-net-intel.

Thanks,
/Bruce
