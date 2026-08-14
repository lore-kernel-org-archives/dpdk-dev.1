Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F70DC5CFCF
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 14:43:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 107CF4013F;
	Fri, 14 Aug 2026 16:43:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id A0008400D5
 for <dev@dpdk.org>; Fri, 14 Aug 2026 16:43:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786718597; x=1818254597;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=kjrdf6BFsZHmUDElNnV4IwfmHB74wlg9hhDTTFc5l5k=;
 b=JxPP/aCscJM7FNJGLBa9TrCeo7lbkv0nMqXYlct83ueadhq5aAWsqF1p
 hd5nIMSQpeqcnW+xL8molYD8yCZdLExbmbk18xwiriZcTMeiLQMXF8xdb
 RbUNdFqQtKBCgc3hcMRsRsOEzu4Njo66tLXPi25yMcVmswOiU6/RUyvlt
 3K2dsjg3M3b9AeMARG6lu8YPlGhUoW6z7Wrfz8R9mFggX0pvDUTw+EDij
 eqh6kHXl/S9tLz6Sr+r6p29X1H9nk6MJ8CyS4TYekfxXoDjHQItE2o0hN
 BPV8eZ14vAANOs0Csh08eX7pKDrCz2YIfkhe6hwoy04C4TSstCEdsk+tb A==;
X-CSE-ConnectionGUID: 9XN2u0q0T1y+rWgPnoLR5Q==
X-CSE-MsgGUID: Ti4FiJAvQFm4i2Izg0D97g==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="104679392"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="104679392"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 07:43:16 -0700
X-CSE-ConnectionGUID: R68s3QYgRSWR00405r+AFg==
X-CSE-MsgGUID: ueqh5jvVQjmCMBQjKhHfaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="264285276"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 07:43:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 07:43:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 14 Aug 2026 07:43:15 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.9) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 07:43:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDSfrgUKkauDLggOpsdNSIi16VWvz+6C1S6mZxnWPc2xn3la0k/jADkEA5WWmP/fjugKkNlcQGc2qKaAdAtJNiPfxvMMdfZuB3KjmSskng04IFMEB/fK5AJngCIiQA+kuIOmB6EgoHvfvsAlNhR3UiG/2jug51YV2fcYfFSVsRNyAHGJGoLsHMj6F5b1mUuUfH34YYEyyf9G5UQ8HKvYIzcvZmhKW2fTSI6UV/3oHAKtStwJ1gfu6qidFUwl5aKdLVKynS6g84XtU37fAcU5oSeiQc7E7BIr9D3sYWO3dPJmFktKtK0hpT7LF0qg/5jnBIUDlPwXzsALeJk50ddviA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrcKwO30exxLwbWprNuhplff+ti07UgjdNMyUZa5kbs=;
 b=l8hchxD2CGI82aOrYADvAOPJflusKTGtD+s9OxU4zgej1pac+fcjgEBWWo63Bna+VRFvh7pqFSRhXGuG/JPk8ogpzePj3k8dKQmNP6tyVcHZoiUgN4kxWf305u71M8qGUOwf9byB3pUyJ6utQUn2RtizMR+u0QrfwO0kwaUOa5h23hLI7QTDcKg39et129TTDxb4LuFSKVV5OlSvEj8ZVIPpIn9xTUdcQ4MNa2/ePoNLhIOFeS/DVVlnrZYD88nzYzeBgq62I5jXvAJk3HE/pG72VXDzKh7TJAieqFxLJpDPgh2OP1qNaYPb64+Zc2HyS8VcYfmjfcATAMAlpabxOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DM4PR11MB6453.namprd11.prod.outlook.com (2603:10b6:8:b6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 14:43:11 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 14:43:11 +0000
Date: Fri, 14 Aug 2026 15:43:06 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, <stephen@networkplumber.org>
Subject: Re: [PATCH] net/ice/base: allow array bounds warnings
Message-ID: <an8pel-Q8gpcPvfi@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F659AF@smartserver.smartshare.dk>
 <20260813111509.1446335-1-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F659DF@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F659DF@smartserver.smartshare.dk>
X-ClientProxiedBy: DU7P250CA0003.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::30) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DM4PR11MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: 393b84b8-0eb8-447d-5caf-08defa125cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 8N1Ul8jQz5IhHLq2JDQ9JBpVlknfWz9WGBIHzo9USJBOQkRu5DOcssWAsSdc/immFTKaCAVZ9Dfd+EGfAFhWjet7vN62RMWVxl1JRb2S+wds2m90nYu5wrihgHg++g/cnFNY1O0hc9apMgx/lrKiL9NFJ23Ux//4yp+cTq03iUO/HiWsiB6lmbZRkUxfjU/NQ6zrkDSEbz/2dP8a0Owcmg+SRo0e+chubtxAoEnYWk0PknIDpW3br3K8IVJNgsIjaACBehFZB0Obkyki7iFC17fFpNft0WKOdWdRtBHYeLBhp0+azdyEB8UXx7J53YEJRwSSLsLv/zhcTGz1D0890BiI/d63aDEstwQSaYp2vCSH5tFb/rY2lBFEQRoEHwMHRL+AbZTGTblp65RW1c69O9tqdVCNdWy556w67GOWSYqOOfG1Jf5S7w/YDYPw9BSjtIgHvdoUbc/Ul/+KAFabmRA+BPu3SosnEL4kcsY3aNV3PnrHi2XjWytEM4yE0Ghsv+VuOgdq2oAGgEWIVLTjEAWO9XlQxgWynRMEg3X0GcbwNKbqutfVNOYWPWCOKNmwT44BonKX8sIWSGkdAPhZ+/H+pB1iUj6IHJotlUmY72o5oU19eGeg/9GIaQ+YY3i7+dJeC5FI2YxWcRlvpIAovGKNyU7Cw/5exinRmjPOtn0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?UntkyVMk1EgbbjIg4w0/XItmfOH8xmpUmQO7fc46mvv70t3qn8iCMLfzDl?=
 =?iso-8859-1?Q?ana29USiicFvDCP5wKwJSH+8wiGvhv10fm8GP+/AZy4A4XJCPeDrQbe4ky?=
 =?iso-8859-1?Q?JnanQZ2a9bpZ+xoduusVXfqz33Joa/3k96jnfz8lwQE+TsemKhsLXJx0zP?=
 =?iso-8859-1?Q?bKECDRkv6IKggQqnFkGujijhnPXNVzWBkevJZIL6CZSD3YayXse5c3B5J+?=
 =?iso-8859-1?Q?J4vPUubxWdXb6b2Mf7+k7bRoLFW0gdtj9VEUe9vUhHa0/7ISk9FbDPmRZO?=
 =?iso-8859-1?Q?Xm3o8E/PBUBZKFNcPVCLFQtCihYSwtd2bsSLWTs0aLw4lU0iw5k09pG1Hv?=
 =?iso-8859-1?Q?3cPVSW4QjTy1IxSGtrkD0ULXTNknAIgoMC2CeyoexcNQsLK2xHgxVkIxq0?=
 =?iso-8859-1?Q?BS4GXazq18LNMd+BnkyCWNYSNRt7GpK54O9BXCsVDoX2hf932feYaWxoWz?=
 =?iso-8859-1?Q?pHgqpTM/7Lydstp0BaFwhcJG2oxtgMz6RUb2ONp8kN6BzoatMU1kfr5MFX?=
 =?iso-8859-1?Q?Y3JIOB7QD+fw0EmVmljLIRCTRYkPIjjCIypmBII1G7yvYSG0FAr3DU1BaV?=
 =?iso-8859-1?Q?Kqpoex46f9QZ1UJo5aRXLun6I+EfGwje/vbGzQGbjxwClt54Gj6P+arVvk?=
 =?iso-8859-1?Q?1qLV/Ds0x1IZYJ5Itndxruyss7Gg9JpHRxqjlyTgvMpwb0E3pFAQcZirgz?=
 =?iso-8859-1?Q?4GSVw1tXvPjuBoy5hCZDwYRyhXJGp141Y6jAIzTgr/Aef2gBdhzBLlBuv9?=
 =?iso-8859-1?Q?G1NopLiAt4eS9JNPTTJj/S+eVw55EsEnzSN/eW/U8KUZjHvYPhz5UqTGGR?=
 =?iso-8859-1?Q?tR10W9ohQUOg4dVNAe2ChazEjDZyGftWQJeFRKXBOjldwvJDdQWLLpptrX?=
 =?iso-8859-1?Q?hqlrFWBZoUlJfolt3/HOp3s1wkmWAa2qBqcISkj1igmrydUXy6hL4dVWBt?=
 =?iso-8859-1?Q?5CSKn10Hmr6kBPevEmJCq25Bgl4YN4GL06Z95Lh2gpx+EG/Jd83NnLIOwq?=
 =?iso-8859-1?Q?1brqiWzBDOmOQhfbRLx5wWgpeoaDG3jWq/BgN8S+3Q3HoEP4T7EAnkSpdV?=
 =?iso-8859-1?Q?ZRcKFMsXLNfvlhb1PdKmtFZwCkflYteijL5nDZIedBBWbMO4KUpT2mxXhT?=
 =?iso-8859-1?Q?jy1FsAhaPzdb1192vEeSMrVYyYJJKtr9vL6dwtL1VN993vUCT6OQHS/HRd?=
 =?iso-8859-1?Q?m4HeO8bkuQIOWLuzHixa72aREhJFbPcu+vx/JWuidzXkECiS21rMyOLQzx?=
 =?iso-8859-1?Q?w53xylLjg7sMqS2KJzRh29kPFnip4dFtpFz7jOYK8P3S5jF+n/Usfp17ex?=
 =?iso-8859-1?Q?gPmYvi4N/1Cfszj0kzO1DnXSWtN45RFvGCYVyw4wU/vAuZ8JeHa/wFpkFm?=
 =?iso-8859-1?Q?0rcC+eLmEhbajDs5qCVJRRjmhP7zdrUN9C8ZfH8kh+Vll8lTSwcZdAJ3h1?=
 =?iso-8859-1?Q?KVAMlmkPrs+nlbk1vtHQS6444pwkgZOG/RZG1QFhlLEDg8fzc9FzBGsYJA?=
 =?iso-8859-1?Q?560uVU7Akc0GLEm+UrYCg+BG6FyafxVxyRocfwaqKtg2+7RvM0TKGS2OoX?=
 =?iso-8859-1?Q?gm4rvZev/1KuUredC2eZSic27JRYJNTD8efY4zQ/oG8nhhm0VtagXMRZ+Y?=
 =?iso-8859-1?Q?XV53/Z6TvaPD8biopCL4CYckdycnjg9XwTubo1I8Vvl43k5ZTUUldznB7C?=
 =?iso-8859-1?Q?5duREm9IAqDvFIsR2rta3xZ96io7Ls88GvbTtErDTEW5SmKCWAOnuqLS/a?=
 =?iso-8859-1?Q?/7P61onuIL4nTUQMDSkrqSIsPeMWFWHpdMIWY+nSk+nyZ65B+RhJQvgzE+?=
 =?iso-8859-1?Q?IEG+ZJ1m7yYCy7u286YihEYnsU9Rs4o=3D?=
X-Exchange-RoutingPolicyChecked: G6UYZ0ojdVckicBxD3/VPqIMmTkhRRaLyV2T5OI+3ligahp5laMe8JscXlAtLIPk7YuD1Ke/q7ycO5BUUu3MISE/XnyPLN/qe6RjO4jpjho9OINFTa7kIyQgh7QkYY7t50MRKNoiRY0xMZqGVKRZd80Mt7SfHBkqHzWrH57YPJk9N16eKVpSh4jVnpiZgMggxCSGCR1NDxfGXUnDOUf+zXbMx6gU8bSplrGtXCaiXIEhlH3GDUBHbzmwnJ9Us9ZnwIgB/4QFoRkxw3/uFOX0bpimYeJbiMLDlZV5ykOlPG1wfHsLMR6DgKLoYuCninSQFYPTvuxr00D63+AuViXNIQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 393b84b8-0eb8-447d-5caf-08defa125cc6
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 14:43:11.0038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8I8++SlCFnr4Hz/G5YCTsZDaM+DxUyL9yXSY54hcwZBBIcxQpa4KlmuUVpjFg/psD6uGpyWCTLSeqwERegyb6fu1hdD/Wio3HTzGrPcNZs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6453
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

On Thu, Aug 13, 2026 at 01:48:12PM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Thursday, 13 August 2026 13.15
> > 
> > Since there are no zero-length arrays in the base code any more, remove
> > the -Wno-array-bounds build flag.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  drivers/net/intel/ice/base/meson.build | 5 -----
> >  1 file changed, 5 deletions(-)
> > 
> > diff --git a/drivers/net/intel/ice/base/meson.build
> > b/drivers/net/intel/ice/base/meson.build
> > index fd079c41cf..da961f0752 100644
> > --- a/drivers/net/intel/ice/base/meson.build
> > +++ b/drivers/net/intel/ice/base/meson.build
> > @@ -44,11 +44,6 @@ else
> >      ]
> >  endif
> > 
> > -# Bugzilla ID: 678
> > -if (toolchain == 'gcc' and cc.version().version_compare('>=11.0.0'))
> > -    error_cflags += ['-Wno-array-bounds']
> > -endif
> > -
> 
> Good catch!
> Consequential workarounds like this are often overlooked when the workaround is not necessary anymore.
> 
> Patchwork should have a "fixed/workaround" state for tracking workarounds, so they can be properly cleaned up like this.
> The root cause has been fixed, so by removing this last detail of the workaround the bug is truly "fixed/resolved".
> 
> Acked-by: Morten Brørup <mb@smartsharesystems.com>
> 
Applied to dpdk-next-net-intel.
/Bruce
