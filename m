Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C844CD6E49
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 16:01:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADBBE40262;
	Fri, 29 May 2026 18:01:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 083E2400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 18:01:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780070485; x=1811606485;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=l4IdWGSZFnFO3LrJdy5aHM865Did6T4Rttt+DSkIn6g=;
 b=OzcfTLMSk+BdwL0s4oIMchmThdfKxmmhDPSm5oTeg27JIkstuKro0q4a
 S1cWaChLrr3fnmuJvJtYcbS+5XogwafHV29NriyXQCcVJ3RpiIXPk2kHN
 u1ZDn5+tDX+v0sDO+Z8DWOiE51uBW/BwLHwjqRl8oCuk7V/Jmdx9Bf4qa
 1rhuG9/YTLJk6iLKvbx/i/GRtWNxQhzDxVVET37sHos1CM5MNkIXgv4je
 fXfB0iA9HA29w3V8SLGn+3sfbyhhosBmpS+xROpIl+x5fW0hl1DO4Mxuc
 WBK4Srv1SZsAkkmOyOTVy74H7LOC/4T8zMhqBToh46nY+dOWoifd3bKJ9 g==;
X-CSE-ConnectionGUID: nMjbx5RSRYWAV8FjT7FMCQ==
X-CSE-MsgGUID: SXLaZYEuQkiiQ6wOFNayCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="91609399"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="91609399"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 09:01:17 -0700
X-CSE-ConnectionGUID: 9bEU8e5YTpaMepe4wTwV5g==
X-CSE-MsgGUID: s/T8r+WxQH+Y74ojXtKpbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="281007352"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 09:01:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 09:01:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 29 May 2026 09:01:16 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 09:01:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTj/mqk+2g2Z2xWRYAurYtL1jVP5bC4B/z4ZSJjEvcPt00N/e/VrZhTgO2C/0Ugz88MuHy53f2N71yZyGbrziIZgooNGZ9fLHQ7lGSK0FKzewEl0w3aLCD/2MldwWyl0vlRUIpNmf9nAVU7KCQNSakCGHI1OqBcWi/MdQaGSe9Bc8Vj7Ku1DOXbXPZrkx+4lNWpZsmvrbO0FOPGroLlB9yaZloF0/Gxae9kq15jwCO8SD9c6ZJ/m/aLvb5+nQklmMNWwVuQn+06Wo2S6HgtDzoqkZ4frBrYOFqFF8rMDGQCgT3nDKub+ld2g3kgKRBoAKclPRiOsKa2n712Emo4MgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bupCKEhIzyL0gSYRtLwjMXvQ7p+ZtJsh2xPmPV5UXLQ=;
 b=nm8y9OMYSzOFQTsJ5QJ5g9KTmLm4XTE7d6aLGLLuKYkfikhj/BkD7DQpH8pQC1/nRqX6g96g1ExRoSL0LoBZy/EMWi33luSVdUNFrhlZfsBlCUQl+/ptPEJhNOhASsCmJuiAnhdXs+mCf32vmmiTa2ZVTn7b1ek+Nx52Wg3Ku6lIbkbCX6inAWvRPwCwZkvszNIGlbY0/txi0Tb/nVpU1kPs06SQSg3xSdXKmHjawQyQBVnhj43zkL6Yj5r7XYI16TJwNCAVBIlrCHUo+tfNwyjpaOyLOHThdu4bTlJgNmr1MrndhKhEBpWxnUefAMPTlggjCHJT1thqsxuH0Y+Wtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB8294.namprd11.prod.outlook.com (2603:10b6:a03:478::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Fri, 29 May
 2026 16:01:12 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 16:01:12 +0000
Date: Fri, 29 May 2026 17:01:06 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Sudheendra Sampath <giveback4fun@gmail.com>, <dev@dpdk.org>, "Anatoly
 Burakov" <anatoly.burakov@intel.com>, Sivaprasad Tummala
 <sivaprasad.tummala@amd.com>
Subject: Re: [PATCH] examples: Fix vm_power_manager scratch area to
 /run/dpdk/powermanager
Message-ID: <ahm4Qr5gLBf6sxof@bricha3-mobl1.ger.corp.intel.com>
References: <20260528190449.66254-1-giveback4fun@gmail.com>
 <ahlH3peE5oTV3qEz@bricha3-mobl1.ger.corp.intel.com>
 <20260529082324.00a5f096@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260529082324.00a5f096@phoenix.local>
X-ClientProxiedBy: DU2PR04CA0337.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::35) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: b8176495-9c8f-4875-08ed-08debd9b814d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8126099003|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: sSdfwWj2jzrIZQVM2Iqap9kz71LuAnSgLBGWiylDuvLU2QNc5c1AIaggajmxtYcW1YDcy6nf6u36GFQKVd11kl+J3MkYBsdpcvNbIsbdt4XBIjBtenmFgKrIzkCOF0v35oiRHdItEQarawyja+GgDnSL+3wjmBwARcX05grqOlhYvEexfYNAG68HG3uyH/WHUh0HEj+e1OCKZA/nAvoZqIugwR22ZTOTU50930bsKOKlWBPt0gutPXCCacao3VknUZCUZSWhb/at8MLpbN0+zLe6PQkyQ+O7w8S/m3jsX+3f6YJhmA53AqPT+GdjhHASUXxzt0tJOYQcXZereGHlnNK8Gfa3mZ2607T3riAc5A2RmLdMFFfa7ChQvfhSZ5RigYenSFNhbuwoKddkz2zU+I6B0NXyFUkyQ8eZAeCCZJfCiKodIRzHYYOSYk7tkF/uVrbJE/4C2cnxb4D2O505q2lXsG1VsmMjluY1mCUKLBx2+wjRZlnKKToL4fTwUNPUqbGUNpB3NZgaD1SU94nNrFhEGgA27S3PywGS5/6aA5u2Y68uh3Cd1TL+nvkT54CwdVGfQ1u1caGm1X2qHfcXpMZF13EbpQRuYo1PAEcYjt4i7mFMOCrUhGQqU9AhYyEnIdxq95ilJ3c5tSwYPUvQIMQFiHUEf9m/btVxExfA9+7MO2TBgc3iV4lewEgFvOjojmudWT5j7Ggsd32c2HJYEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8126099003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2de53LUdCpLrVIkJrrUWt9/MOdkXPGSokkPSuTVqjGK8gv1oHxVteW/CRl9T?=
 =?us-ascii?Q?/JPxsMtMkM1LzAGajJbn93rgy77vTIZ6Wuy/btxelG6J50xwHsqWnoxhP3kw?=
 =?us-ascii?Q?KnuEI+Q6y+0nwdQXJxHKwt+WuaUNQrykOFv1TLc9Rg6gnZL9SUSScKGAJVLw?=
 =?us-ascii?Q?q3Um6n0rLyebJH7ChN7+FXaFWUQRJtvHQ53kmyI0ZG4J6toAA8xYYWio48lT?=
 =?us-ascii?Q?/iamZg9o6kSfND/3guuSR0/q41dpbegg0Mkcy4TDSNXBP4JtCB6F0sNVP1oy?=
 =?us-ascii?Q?m7VrOJXnIRc3arL0luvRYZRpzsE7RMLencwOnfL8GrstBDpQuRiYQ+0dcm6U?=
 =?us-ascii?Q?euMCFgvPxmw//Vqvq5cP3AtsUMWhetVdMGXdRq0fqUSwQugGK4NZd93RiSvG?=
 =?us-ascii?Q?2bkjUBsYKc+67E+5e6yxDTzyE/eXLmnje7T4OmPinHqi7Zecu4dWrXEPl8Vt?=
 =?us-ascii?Q?tl8XhnAxxfc71ezrZtQclc1qiCPMkf9pY2XjEhgFRrKNyfQycq4hYrSad2n0?=
 =?us-ascii?Q?hyJ9UECTKQt9W0mfA5jeuPgxzkGe2Uauwp3fHKuKUGLFSjVHGVdO4lHEukHj?=
 =?us-ascii?Q?Mk7ytSgbrH4jFKMPlm7M3sZ3RTScEnKJEWAwLpN4YOtlXhKkTfoECRy6f8J6?=
 =?us-ascii?Q?2gYUbTCBwPlyr/zMI+BxO+Gp0PERWbShIW+2Fu6xD3DUSVyihNzpts6gIecP?=
 =?us-ascii?Q?W1CF6/attZegJ/HzPPcRzoUOb9sZ1jpCprV+eFH/ki7PJ7Sk6SkP3xSaqnsu?=
 =?us-ascii?Q?yBr28vYNlHCg97UbT4uHuM/6zGFb040OL8pOt+E0GnmHHX6XpLWdVf/KVI+6?=
 =?us-ascii?Q?MvB6GFeZFLmGy2gONpS3LbIw9l71yBlKkVaWKOuCu/bJqr6y3pTo/Agw0Jnd?=
 =?us-ascii?Q?25m+dGnx7aM5dFKKMe1LJq3j4mPm9GwpuJ5ipgtnUe5gR4WJan4X2eVaSL8K?=
 =?us-ascii?Q?SItVw2YxlJdsWaNmC/rTQx3j+RvvpaTZ6yb5qp/gkW7DPIeBNaOf18RyKeEW?=
 =?us-ascii?Q?poPB+Y+1+mDW5kPZcxq9EBbghITvF/4xv/fTV76vU48pXWI40o5JbMYBoS7t?=
 =?us-ascii?Q?0Iq8so1GVejIjmc4ZniPuEEP1A3tPILti3mL1WPCiQ2UItB2UUHXItDE+/Gn?=
 =?us-ascii?Q?bVJPK6egLuqU57Y4MF+nUCh/aGgrLt5Z0DGMsMehA3VpM3FECQILbAyPpYcm?=
 =?us-ascii?Q?d7fw8rTn9+8cRnliWZCVYFc5kbEsJFmPtVRKu05tT7ws19gh2QXfaLEkAM6l?=
 =?us-ascii?Q?7+qkeVhYdpcWmQ6C4KTw1FR0nG5WhFSYzYAcXbZLzgMD+FZ0xPy6josLlpaS?=
 =?us-ascii?Q?c3BT82SLe6+HbBC50I6J1j3xcUIa3dWK5oPnOM7hRAI7Dq9qdXc5c8o9g18R?=
 =?us-ascii?Q?jLVU28B6TUkV1qKLmk1vny9o/AK2Cpfe8AmdO1hpOZCUH+QAbT9rGr/k8BVD?=
 =?us-ascii?Q?GTm4NY9VdHb61Py1l1p0pkmFkOPx57Daj8TQSg5F9UoKUMiDq4VK7ISOfVtj?=
 =?us-ascii?Q?89jaamO7yosCMvkNd1muCYv7XadLE3wAVwJJp3/CKiEAX113yOjO795l6QiB?=
 =?us-ascii?Q?n2XIMTaFGk90dKiGYmhomTHrUFjatsKAKz9VLdfQiVhUEtMWO+kLDN2Vl0Ec?=
 =?us-ascii?Q?jQt/WERp5yORg+8o3h41EWnkGowLbUTQ6VA5ijuDTbIIVXRvTHdfWDBOleAW?=
 =?us-ascii?Q?diXPAY8G0iNe3LI9QIF7RooFxa/ox90XipAXyw4fEkMVMF1yMNNRFbTFmVot?=
 =?us-ascii?Q?pGDKbZZ5Oa842GmO8fA0QRacJO8AbA0=3D?=
X-Exchange-RoutingPolicyChecked: oKtvLlSCCRedVX+cMIeBJ6LsS0LE85QIFUplkUuy6gvoEL/LDH4MoG0cwGD6sI1MPVP53ynMEesQOUUeeyjxAsOgYTzP4595wg/Bp2lVy+Cm3cdDoRMBOpO329gFZT4leYM1p4koExq8SoaChUYrcI68OSoUcm0s8hfnipnhFq55NPar7MhUZL477jvEtLSONbDp8M17FW9UjjTk9QGn7kwlyW03zc0FuMRDzXRMNXSdBjhsl+HUMHb5X9LgSqDJbtzx7U/necSQLYzXa6XNOU2USqIKh3BFzd/TJL5d8k+ZAP2up6eeMdsBSi5i7rqwOv9U2kMCToVvus78JXc4EQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b8176495-9c8f-4875-08ed-08debd9b814d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 16:01:12.2814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wGXBsjaNkIhlNM8NND0GBJdU5NQlTPWE0a6/nYD9psMcmh9c97n2Djqegh9nVaPJ6DIxdxMh0OOzmfFWpoNwxOMMG3/e10VIG9/YUBbd7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8294
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

On Fri, May 29, 2026 at 08:23:24AM -0700, Stephen Hemminger wrote:
> On Fri, 29 May 2026 09:01:34 +0100
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > On Thu, May 28, 2026 at 07:04:48PM +0000, Sudheendra Sampath wrote:
> > > This patch for bug 1832 will do the following:
> > > 1.  If /run/dpdk is not present, it will create it first with and
> > >     then create powermanager directory underneath it.
> > > 2.  If /run/dpdk is present, it will verify it is actually a directory
> > >     before creating subdirectory, powermanager.
> > >   
> > I would suggest using $XDG_RUNTIME_DIR for the directory path, rather than
> > hardcoding it by default. If XDG_RUNTIME_DIR is not set, then maybe
> > consider using /run/dpdk. However, rather than /run/dpdk, I'd suggest using
> > the normal runtime dir path on most distros as the default:
> > /run/user/<uid>.
> > 
> > /Bruce
> 
> The login in EAL is a little more detailed.
> The choice is from systemd conventions which follows filesystem hierarchy.
> 
> 
> int eal_create_runtime_dir(void)
> {
> 	const char *directory;
> 	char run_dir[PATH_MAX];
> 	char tmp[PATH_MAX];
> 	int ret;
> 
> 	/* from RuntimeDirectory= see systemd.exec */
> 	directory = getenv("RUNTIME_DIRECTORY");
> 	if (directory == NULL) {
> 		/*
> 		 * Used standard convention defined in
> 		 * XDG Base Directory Specification and
> 		 * Filesystem Hierarchy Standard.
> 		 */
> 		if (getuid() == 0)
> 			directory = "/var/run";
> 		else
> 			directory = getenv("XDG_RUNTIME_DIR") ? : "/tmp";
> 	}
> 
> 	/* create DPDK subdirectory under runtime dir */
> 	ret = snprintf(tmp, sizeof(tmp), "%s/dpdk", directory);
> 	if (ret < 0 || ret == sizeof(tmp)) {
> 		EAL_LOG(ERR, "Error creating DPDK runtime path name");
> 		return -1;
> 	}
> 
> 	/* create prefix-specific subdirectory under DPDK runtime dir */
> 	ret = snprintf(run_dir, sizeof(run_dir), "%s/%s",
> 			tmp, eal_get_hugefile_prefix());
> 	if (ret < 0 || ret == sizeof(run_dir)) {
> 		EAL_LOG(ERR, "Error creating prefix-specific runtime path name");
> 		return -1;
> 	}
> 
> 	/* create the path if it doesn't exist. no "mkdir -p" here, so do it
> 	 * step by step.
> 	 */
> 	ret = mkdir(tmp, 0700);
> 	if (ret < 0 && errno != EEXIST) {
> 		EAL_LOG(ERR, "Error creating '%s': %s",
> 			tmp, strerror(errno));
> 		return -1;
> 	}
> 
> 	ret = mkdir(run_dir, 0700);
> 	if (ret < 0 && errno != EEXIST) {
> 		EAL_LOG(ERR, "Error creating '%s': %s",
> 			run_dir, strerror(errno));
> 		return -1;
> 	}

Yes. Can the power manager call the rte_eal_get_runtime_dir() API and use
that as a basis for its working directory? Save duplicating all this logic.

/Bruce
