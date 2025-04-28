Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2828C369D5
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 16:44:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67125402A9;
	Mon, 28 Apr 2025 18:44:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 471FF4021F
 for <dev@dpdk.org>; Mon, 28 Apr 2025 18:44:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745858669; x=1777394669;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=05+oF+2PvpWb9NVotXX5DjEwQvG+QckXXPAHTxIEx5g=;
 b=cp51mExqR+jf1lkmLK0NCaCDq+9oh3Y5U9Xv5AdrhdeSs3ttAjVhKtsH
 wMRfMS43SBaSBFP85kqTJKuqaHvafmVvMe37LJsknVTzgi4wy+PPSkMK0
 VPP3I0c+Fnp6apQK42N6Zgu8K4slXklMSLzxSJuspzoWzvqXCPSIeolH+
 FA2IHbew2W8A2gYqs1DDQ//DlyOIQ3QkEO6ItXifbXBYddLsLSTBYWDKl
 jOnm5qGd1mEzhwHHUjPIJweQOBQi8owx3GbugRhHh5axbRYsp3h8PkEcB
 4nKZ30nsvpV2Mctw4D2IAvQcDoHHUVHRk2X7/sAO4KZJY2gJsN+sW7H4X A==;
X-CSE-ConnectionGUID: iBBuNoG/SMuYd6KilYRYjA==
X-CSE-MsgGUID: Rh0DRoT4Qr2B4wXtPCuJ8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58108414"
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; d="scan'208";a="58108414"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 09:44:28 -0700
X-CSE-ConnectionGUID: ki9Ba7/cSJacEXpzpIz79g==
X-CSE-MsgGUID: 398UKjWuTVCwT8KxhQRglg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; d="scan'208";a="133299376"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 09:44:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 28 Apr 2025 09:44:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 28 Apr 2025 09:44:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 28 Apr 2025 09:44:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIzGtLcuCTwg/Di1U2OBgpJQ87GkHWkIuU6X0WSQZtb+HOHdDblu0d3Fpb8zeVfB2UU2nx0MXOU6SAY0hdafcX7EBoPNq0GNoM59i9AuV4I1DAxGQJXouVD1jW4Nzm05EZ4slcwFAxX6wR2R9CoaAr5oBT3LCaZiM+oVUljnAYah0q6ISu5e3Udxyfx6SwVAmrJ+V8Xr9AenjQy9K+jV5CWCVXQdyyFEhN+l/pY/HMoJwpRDPNCefBM6BMpQZ/Z+FC/g8tW6y9xnKe0afuXlC8G6Uku6937RUdEZQFYUzX+pH8c1ERjXXhRooKC7hax/6KZmfVeuCgtrDND8kiAdvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8oYjZjTfUa7+o04lQqdX8PfybvHypKCqZM8UZlWvZ8=;
 b=WN4zDj8EekQxAdFVWXyQaLka/cXNMuhAsGA2J+i7oS4sBO7vskaahNu8zstoYQ80+ZzaU3x9cTRGcZFH0ry3k+efYx3c3XpT3snUdo/amI8bfTl2Am4WMu46NaZg/+H2mGxG+8F5D7oqmC5pz0DgnzuxvE4XIJGgyYQ6JxO0kSufYjI/qPKlGvfKhUq/iYj+JjoRKFF0tsFD0sK86XRxO4cq8j3D0Hs0IuaJaD4M2HcowAHquBe7Aa6Uv1jYWh1FBVcJpbRWTQsUtlC5JB3hAftZ0bBF/tGmTF4M0Tx0RBSr3TvHoAdSF6Efc2sDlQ2vOCJn+DTzi1D88dWl44QGpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8138.namprd11.prod.outlook.com (2603:10b6:610:158::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 16:44:15 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 16:44:15 +0000
Date: Mon, 28 Apr 2025 17:44:09 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <david.marchand@redhat.com>
Subject: Re: [PATCH 00/10] centralise base code handling for drivers
Message-ID: <aA-wWTEaXLb9Fa9f@bricha3-mobl1.ger.corp.intel.com>
References: <20250331161000.9886-1-bruce.richardson@intel.com>
 <20250410083720.07b762f5@hermes.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250410083720.07b762f5@hermes.local>
X-ClientProxiedBy: DUZPR01CA0314.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: e8588ae1-0806-4b9a-b85c-08dd8673e918
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lHFOT4+60JMXVOFEZ7Th4quKmL5+gFrIlFn5d1KwRRj2uhAeVPfhLlJQLR3t?=
 =?us-ascii?Q?dbdnkWF0AklFD3iwyhfYr+Vqcv3UDzvqgAkkTYPXFx12Erhx6ZUmbkBbMmh3?=
 =?us-ascii?Q?yRA29Hdj+KvL2YyM5Bn8Oqt6bJ0maqnLqLRvYQdKe1G9K5LcSPnkhg2Zx59w?=
 =?us-ascii?Q?ACVumO5RBBvzg4YH7XwcJePUSlS7VBPweMC9MP0TxQv2ijdfn7/sscIhjd0x?=
 =?us-ascii?Q?hwbNi81Z5zf7JxzN06nQEFTfjKiv9wWy1KpiZP/mcmawm7OSZ2bujwZGGr5q?=
 =?us-ascii?Q?NhuM/TRNs1F9w4NUX1IP6zO+CswnN6p+2evFdl9selknxh612ZdvofWJ2ljz?=
 =?us-ascii?Q?fCWJEv3PK6gEtqS6O8iAVW1iRpMs8Ll0JROmYEOycDssGDhjAWqSRdEEKLkR?=
 =?us-ascii?Q?fqo/bOTBRhJY45IWq+Z/naazHT8Nl8exwB5bY3geTzLlZKCBr6JoUMsUtcdI?=
 =?us-ascii?Q?B6PYi6RQxMsZxjHBpeSAERcH2OS/o4l4TOecSmumD+DH3cAqn3PNBsUyjLvz?=
 =?us-ascii?Q?wWO4PAH12mxZGUP7J5OTW1IM68P2TqKkGh9J8vYtOvFC/dqTvOy9wFjSIn02?=
 =?us-ascii?Q?jM61r9ZOTp782lCrQiiqcqzoXSJfWw0bLjXY+ENE9ArnLiXnMecV9EYrsarA?=
 =?us-ascii?Q?clcqj8rLGwxHbxEEPublcduYIQWqFCfzFWAye8XVWkNbf0T4T4b8afsp1QkX?=
 =?us-ascii?Q?9Evnx2c3L77Ht9PMV31d8VZR3RUKsexoddLAuJ1T9l4L55FbHmbaqInQEhtI?=
 =?us-ascii?Q?qjlFcqDZUQ7dz2j10TK+cPOFpGZFYn4bTtlXxsqDdlc2eq4o14D3UgG8KCna?=
 =?us-ascii?Q?FdgxuIca2U3VtwQZj2j67ufvShQPJM/Xx+Lcjv5YfyN3OxXQ+5fz6cM55NSe?=
 =?us-ascii?Q?I3UD6IHJmGj8bmfXL9N0wM1vBRTwkpo9bCxP+UFAch+z3ka3ajxa6B1YQ3Ov?=
 =?us-ascii?Q?h1b5ytPGdeqE+41T4o/7qQ//HGt17OEwCeZohAtTymQVAnbADAiKrJ3Tiuik?=
 =?us-ascii?Q?p3sigIhKaCH1Mrxjx7YjA3TojJqyh2wZXPcBDXwRDmC09r4A/wljtBP2BbYa?=
 =?us-ascii?Q?IeGTYRq1sEAdeYdb7iPzLTKmMsRsmkHENNT67qOwxq10j7K9lMXqaGwWuJ8A?=
 =?us-ascii?Q?auKx5vCG1DC/duLowI5rrc4BJelSRqiNJzzHFI7htVZ2CwgmdiX2s70pZ76/?=
 =?us-ascii?Q?Ga2W60kSZUEcOMWw6umEeGLQplJ+FpeBviyseQkOtdg0TTSty0IWn/C1Qrjx?=
 =?us-ascii?Q?1pKQTb5wlavSrpTDRkZFME4qE4gTp1qLGP0cMyygksCL5hiPxLsWGLkXuORq?=
 =?us-ascii?Q?wxKDsrXMtQpzn3+8KJ6ZX9ukHIJxXYneRib+b/ItunWpUr89RBqz56pFyt89?=
 =?us-ascii?Q?TXkj7ucYebtZd4SEc/JpTz4yhf3+DWOra04cM8SYbiBLeB/prcdAke5OU0q9?=
 =?us-ascii?Q?F4sW1AFF2a0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OPToCkCTTqWEcoeWF07KhRJ3nJ3FWtM1AFljC6PRf2e1qcivsykAJznKVViR?=
 =?us-ascii?Q?6eQve+MTRPNnj1x+R+eFjvAq5bfnLItq3/trplBgwPngwy4zGCbnO5hJ+WEP?=
 =?us-ascii?Q?2np69zE6tI03BFwZ6pLCRc2IsABTP+uRdWixw1yBL/KGqzY9FufiMNdB/6VH?=
 =?us-ascii?Q?BA6BHLclggI33i9M/NDszz7ZF4SWJkg0MR2DFevkOc46fduIKR3V+mZ1Qv23?=
 =?us-ascii?Q?rSJkY6fUAJ6Migw8AkrAWDjlm4cGRA8viufgRpPtmoyg9eB/GLXt8Mc+GyDy?=
 =?us-ascii?Q?0wv3ap4rlsQYE0TSVvN9Xz2L3qviF1tCm1Yv90C25w4pY1Rp9A70huLWzjRO?=
 =?us-ascii?Q?foAWeIhlAy3ZB3Z409exED2aq/qVX+rc7eLBcMtzv9MW8BpXewKBoRkyBrNi?=
 =?us-ascii?Q?rkfbW+Y2ssh5BrCak5N9QyIHpcJXqj20n1GItpR4XtJvEPZqA/4//Df7scws?=
 =?us-ascii?Q?H9JDwiF68aY6njRc8emD9n7Pf1NZPh4eAtmxMZVQOJIzsgJkHG89grvbw016?=
 =?us-ascii?Q?vHJ/xd8UIgE4THePJ920EWjc7ahxYA+3heiOl49zEBALbmSl+6t42ZjK39Yt?=
 =?us-ascii?Q?3W5bOeX6soW2Nv5b5LgDPRG4ZIofc4ZVGTrbgKfc5oYCUG4vi3Eg2/rm9qDn?=
 =?us-ascii?Q?VkzfOUFe8ZqnVcRhYx6R++hbdqc2QMqV/kKFbJ74Nhr6OSuZi+Lvarcw9DkS?=
 =?us-ascii?Q?uJERT8CH10yc3OoIDv6xNtxqk4liOQ7ZMbC/HEINQv0S1wc/AOUpbSE+a/Pz?=
 =?us-ascii?Q?2M+46mLo9fhcVlU4Mkk2+O8AkOAT2Mf0Lbw/R7hO5m8+WVCsH0eR+gSF1ZDX?=
 =?us-ascii?Q?j3FAQQSJKV7HCGHSV2EY4V8eb9UEbK8VGYyyZ7BUweUzhVEsKOkM3K3DMYk6?=
 =?us-ascii?Q?I5XkqVorXdFI1/84ErNfHEyWz9+e/K2sKbNIwzBCokoRZf/JY+oG9dR3pWLu?=
 =?us-ascii?Q?40Lvl+n0cBEbQ3oxT6LdSQPwZVVb1d7X0yi02b+z602f7tyrZiJkO1cc7djN?=
 =?us-ascii?Q?yzR6+cj7KgAyGs+g/0Of9sWJAk4hAB+9f+4zD9veehhVMdnMjEktFFw4x3ha?=
 =?us-ascii?Q?dExH1epBc7wvzGt69YKjinAyBNPRuRUajNkNTHY+QNhgsW3IuyG4+hcexKqs?=
 =?us-ascii?Q?deKLMD8NLP74TUGkyqbRWqErLv3ljDdeI5jNSrrbhZgaTv4baWjREsg8cjda?=
 =?us-ascii?Q?YfXxf84OMokT2Yxr57KhENenKY6Aao74SddSZEEUAoszf7JSAo8wapQfbfcC?=
 =?us-ascii?Q?IYYpe07YqG6I4GM4FmWbP1u4S3eNSsKTtlgyfXFmUYEqpvhzfRIfn8FJcUqk?=
 =?us-ascii?Q?shLIogPk+UlSiMMWNr88OTYMnOvE3T3O9wtSMAxuRQQtDtlo6gcAkY58Sw/u?=
 =?us-ascii?Q?wDsoo2lZ2aquvfS9MPD1YgtWi+yiMlfpmQAZIDJLRCFBvzHxVB2ksO6FFTbD?=
 =?us-ascii?Q?KbkswnGSoC9sMLVj0e7ClVyyAkcV1wD83IuAXYEmv8r6ICPIiPS/s9+0Q9xd?=
 =?us-ascii?Q?s+dehv1WE5PS7q+Jp80ny8LWGZKwlZho3eCdxPpRRiZbPzT1QVgJKh0gSY9f?=
 =?us-ascii?Q?VuqnCnoim5TRPCfA5Q8gS9VQsO7DjRUrSr5H01MSsHU4TqVSIeFwF8GdJAsP?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8588ae1-0806-4b9a-b85c-08dd8673e918
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 16:44:14.9689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fABLH90nqusP7ursRnC+Y4Lu5oU8kZnGM9gF1bzrZrHfnnjVSc8kir813nzVrB/65MW3wcGXSCgDTWlPpeWdnFFQR6vScuYopCcbt0J/d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8138
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

On Thu, Apr 10, 2025 at 08:37:20AM -0700, Stephen Hemminger wrote:
> On Mon, 31 Mar 2025 17:09:49 +0100
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > Many DPDK drivers use the same pattern for base code handling, having
> > a meson.build file in the base code directory which optionally defines
> > some custom cflags for the base code build, then builds the code as a
> > static library and extracts the objects from it. (The reason behind this
> > is that, in meson, cflags apply per-object, so we need to have a
> > separate build object for the base code to use custom flags)
> > 
> > This patchset deduplicates this logic by putting it into the
> > drivers/meson.build file, and allowing individual drivers to then just
> > specify values for "base_sources" and "base_cflags".
> > 
> > Depends-on: Series-34946 ("net/intel: clean up base code build")
> > 
> > Bruce Richardson (10):
> >   build: add generic support for base code in drivers
> >   common/sfc_efx: use common base code build handling
> >   net/hinic: use common base code build handling
> >   net/intel: use common base code build handling
> >   net/ngbe: use common base code build handling
> >   net/octeontx: use common base code build handling
> >   net/qede: use common base code build handling
> >   net/thunderx: use common base code build handling
> >   net/txgbe: use common base code build handling
> >   raw/ifpga: use common base code build handling
> > 
> >  drivers/common/sfc_efx/base/meson.build | 18 +++---------------
> >  drivers/common/sfc_efx/meson.build      |  3 ---
> >  drivers/meson.build                     | 20 ++++++++++++++++++++
> >  drivers/net/hinic/base/meson.build      | 16 +++++-----------
> >  drivers/net/hinic/meson.build           |  1 -
> >  drivers/net/intel/e1000/meson.build     |  3 ---
> >  drivers/net/intel/fm10k/meson.build     |  3 ---
> >  drivers/net/intel/i40e/meson.build      |  2 --
> >  drivers/net/intel/iavf/meson.build      |  1 -
> >  drivers/net/intel/ice/base/meson.build  | 22 +++++++---------------
> >  drivers/net/intel/ice/meson.build       |  2 --
> >  drivers/net/intel/idpf/meson.build      |  1 -
> >  drivers/net/intel/ixgbe/meson.build     |  3 ---
> >  drivers/net/ngbe/base/meson.build       | 12 ++----------
> >  drivers/net/ngbe/meson.build            |  3 ---
> >  drivers/net/octeontx/base/meson.build   | 19 +------------------
> >  drivers/net/octeontx/meson.build        |  3 ---
> >  drivers/net/qede/base/meson.build       | 17 +++++------------
> >  drivers/net/qede/meson.build            |  1 -
> >  drivers/net/thunderx/base/meson.build   | 10 +---------
> >  drivers/net/thunderx/meson.build        |  3 ---
> >  drivers/net/txgbe/base/meson.build      | 18 ++----------------
> >  drivers/net/txgbe/meson.build           |  3 ---
> >  drivers/raw/ifpga/base/meson.build      | 21 ++-------------------
> >  drivers/raw/ifpga/meson.build           | 15 ++++++++++++---
> >  25 files changed, 60 insertions(+), 160 deletions(-)
> 
> 
> Looks ok to me. Since depends on the Intel part, lets take this through next-intel tree.
> 
> Series-Acked-by: Stephen Hemminger <stephen@networkplumber.org>

While I can take this in next-intel, the required changes from the Intel
side are already present in main, so this should be ok to take through
either the net tree or, better, the main tree (since it's not just net
drivers it affects).

Thomas, David, do you want to take this (well, the v2) through main tree?

/Bruce
