Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B91CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 12:58:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A6B3400EF;
	Tue, 30 Sep 2025 14:58:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id A04CB400EF
 for <dev@dpdk.org>; Tue, 30 Sep 2025 14:58:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759237115; x=1790773115;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VLmUy88c0SMJ9sNxriIUlg8e1kQvSV5LN866hmvdZfs=;
 b=e6dMbs7bo4MWly5g/g4oEgxoBzUB4T0TFSYs0OGBf/YzIcac/2+PaSjO
 PCI8aLrrhEujwIkcNgmgJpqdh43IN3L93FRAeQ6FKiEVXwy+kpQ+u/0sY
 cfh6oTmtlHjg+bmGZyKC5C0bA1c509GfUXgt4v44aTCglQPm1SRCdUVaO
 +zR3sXmMObX32X3d68Y5z9JE714poBIKpV/16EfHEdoXsqqe0S6th/eK/
 NSGhaRPxWrUX1mQgzXibkIyDlCMOmJtQDcd9cvnJ6NaLYJbOz1vHyYCmn
 94ezdXbLzlJYzbIQTvyhGx3qviffBtK/nagyJ5QOu1I8l7e5GZlLY99hT w==;
X-CSE-ConnectionGUID: D4vvpm3+R4qzbQpRpoofzg==
X-CSE-MsgGUID: D8A9UDTjTsSr9KSJMSZTDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61536443"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="61536443"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 05:58:33 -0700
X-CSE-ConnectionGUID: tudgbyKBS0a//fUOS8F4Xg==
X-CSE-MsgGUID: SzHG92fwQpu5UtMmLxE6hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="183775301"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 05:58:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 05:58:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 30 Sep 2025 05:58:33 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.48) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 05:58:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bo27dYAeMpAs/0PFV5UGnIfQFJnfI4eSTr5D1nb/+WyXZOvSs+dpWvgfPaioq4dM3TTEbH2+GNCd71jt8BHel29h277K0Yj5qu0J/D0M/ZDn8TYdttCE5rzdJ1nBST15wNnm7g8trJY+JhmmswW9wQtTBfD2IFZ2jqKLjR5tvBu4Qrm/V+l+GWNA/m6EskC0lwhrrN6jbW149pi68SLecZhVuz89SU00VoLjzpsyKzwJKWlUXqZ5+2s7Sl+bCypq85iraC8S+PqCXOwLtEUcDPlkdbcRfnPNixGH7WLwUR9c/7SS7k7JLR/xYFU+8XIK9vc2IzxbkPO7b0cc2ledTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TEZGPAjHZ2zsDj1mYPUyw4duiKIO3toe6Z5WI3RyF4=;
 b=fVxKwmG44xwlKKTbCmwqYsLCRlYc/quLaicQTIMWwJ6tmBAgwZwbeypDTIebnZprMqlsEIo46HepjElN+e6s4Y78teAcpw57MNj5lllZy5jDB12xmEnb2dsxk6ns67c2oWKsEdRY+FLJonC4FcCzwBXTvP5a2RmAUG29l6Q6s/dXg+PTT3uhAvmY3iwBmgQYR1TPjxcsbYbBv3BN6PYzL3yO3EeG/5Er8Ty8HtendYMJt727mI3mybVEfoqp7INWPld0Hqt8M3sqci322DLk6AnA4Tg8cRhwgW76OwPGKd1IVpUmKTBIq9YpERp2HHu3bTXdyu0DGliUbTOY6j5HTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB6706.namprd11.prod.outlook.com (2603:10b6:510:1c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Tue, 30 Sep
 2025 12:58:30 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 12:58:30 +0000
Date: Tue, 30 Sep 2025 13:58:25 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v7 06/13] eal: define the EAL parameters in argparse format
Message-ID: <aNvT8bb7nLUEpzWM@bricha3-mobl1.ger.corp.intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250723162013.2392-1-bruce.richardson@intel.com>
 <20250723162013.2392-7-bruce.richardson@intel.com>
 <CAJFAV8ymGTU2tDzQoy-jk-bN6uigV1f2oh0TAwiHBzsc8nZNbg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8ymGTU2tDzQoy-jk-bN6uigV1f2oh0TAwiHBzsc8nZNbg@mail.gmail.com>
X-ClientProxiedBy: DB8PR09CA0009.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: bf986aff-35ec-4033-df28-08de00210db0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8qyXFl+h9Vo/igB3r0jTneCnCnyAaaUJr4s1ovJEGzxydLK5cGGOQykwNkm7?=
 =?us-ascii?Q?KNZ6QJxQmkU0N9GtoEYGaab2cNJYfKefQrec4TZcVlWUimJAjX29fihwF13p?=
 =?us-ascii?Q?S7ol+2Q3H6V5aIdGQnmwmZrf4xTADVQ3dZIDeQDlWfXkHnQB6cPW6j0p/j+f?=
 =?us-ascii?Q?Q6yqSCGMrHixQ0FsGGkeCbjii10Erd8lQmV05alNmiI09+C0W1L7uYOt3TRM?=
 =?us-ascii?Q?kK8KycrFn5Jtd8l62gmXJiX7/xSCUQ/trhbre3TiQuIcuoti9LBmlZ+ewxqU?=
 =?us-ascii?Q?UInr3sciTlqsb61maXP3juxd+uIZ8E4TwoR/Sy3lmrln2f/T2oEL9DQjDeS+?=
 =?us-ascii?Q?+eZKyD19AUAH5zLRtnLSAYf+ukeqozDDO9ssbHIqV1pl6j8icRTzPeIWM4yR?=
 =?us-ascii?Q?YdYrc8lPVQ/Q3U/72qV/uWjqjpQ/d5JCrln4oR4RWULe3cXnygw29On9vpNm?=
 =?us-ascii?Q?jIZz4wN++5NTPqZQO9XGEs2MqtsNn6xtaRa0XLTddjy7XB3JA5qSdE1hpbnz?=
 =?us-ascii?Q?4p7xHxpytBRh0h1/Zmiz8ea/rpRwtZ4z9ChNo1nDGKH1tPTfSQTj5V9c4Ts3?=
 =?us-ascii?Q?lkSqEsQ2A/wLRulGuMuy1BE5y/lTYwaMfC9PVy1A+uIz8vjENmBVmiXKFLSx?=
 =?us-ascii?Q?l6AHa50zX0MvicNSxFwa7D5zoMaDP199mkSJhg8pdjcfRPpqDgdjWCAQMZ/D?=
 =?us-ascii?Q?pB9B9hZW+JLlv0LZGRYOpuwV7j+ZYMGS0cW6gYB8jyIhEf8hHAg0bKqAUFuR?=
 =?us-ascii?Q?QaYSpVBQuG9j75TH2G5WEuAomP9rbyRsCijbZrYneu75EDb2W/AjLqCBN17w?=
 =?us-ascii?Q?pWMr8NqD8bUODtuhLAfBvqUFbiyRhW5t4yM7Vm5qnK+jBPZIVlvEwyNHCcDk?=
 =?us-ascii?Q?+VEh1WsGndlBhqCCszMOJYR23Jk3fE/FQW+HfMINzm7HldxN0YC4C0MiLqLF?=
 =?us-ascii?Q?+bcuKs8AfbR/NX2aSLiHYDyhXZtlzhFvWO3itJTad/IFgL5P/XtTlKsiuma9?=
 =?us-ascii?Q?kFQMhiQI0+uA/8OGJQs1+qMLybVJxtmmuDatGiYM6uB8O3ElM6PO8YfK1EQ1?=
 =?us-ascii?Q?VdTCQscIZtwOrFoPZFZ/8aZ9FzZ/VFhNSMPR1DW2NqrE5w12cBMoFm/cgxwj?=
 =?us-ascii?Q?Aw8G5IMJTuMbARQAPUHuO3P0EhiAIP4cJLJVFPaIGPmwpKMCevPddRHl+3Nm?=
 =?us-ascii?Q?MZEqMakMTdiTNX/OmFvNmeqPsO15PVf5PCsvIdPlMVIJ8IOhyOtZGkmXq9iM?=
 =?us-ascii?Q?PoHnzpNh997ElfRnYzXmhUhNCFDUlhiPu/LMCHsbGlRCtAxiYLSaXyy+fEje?=
 =?us-ascii?Q?kilHi52DcDGv4yWg003Zd9W6y67Oib4WwTgPWbjPzdtPfp7JVJAKAM09pWIW?=
 =?us-ascii?Q?01JJfU2XGuC7pGT5e02ccvBWP7Sba8upNg+lzfazNSiEnu28mCaKecvOoWtM?=
 =?us-ascii?Q?DaSa492i/zINfsqYQ7AaXyT0ugIQsyUP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1IdQp9MWGE3KQ5fTc4M4mhuWpMWtpvDw5o8sH07qGPVkkokDPPdd2ElLleuK?=
 =?us-ascii?Q?QR0SFwK6qCHRAlnYlkI3v2Prqjfu1CX5R4sTpZ12m0Ish3TZbzuqd0pBSWix?=
 =?us-ascii?Q?cpC3V8W5x3OQKNvX0g2Zz/OpWgg3UMzeMI33G2EZm0fD8JabiHmfRh9mv3KR?=
 =?us-ascii?Q?wG2uMt6hp5cPSsu08B9IeC3KJPOZHetAfGhkozMsEM9cP9y7WjABczvL5mEF?=
 =?us-ascii?Q?YswtI4A2+JmskhZzlS1GtdcinAMFp7ZgP0lUtMoWRFBhuxuFMdYuqi192ELV?=
 =?us-ascii?Q?aWRdhkYcf87vPU1bQOeGHCYAs3PWDC462402KJ5DrJcmcSMdrYIMItJjF+O5?=
 =?us-ascii?Q?DX6APJEHGiF9b362/tHnRN22t8Cl+u9Dv8xtmdMbO7bt6SgAObIlbx1sLBXs?=
 =?us-ascii?Q?Pbg7Zd2haJ1iCdAuXCL3q3cjCsiRbZ/Nd/T48287m4cSB3fdenPBZzJ6xmcZ?=
 =?us-ascii?Q?Zgahu/RxMK6a6QmsuREzZm8/SGyNVN6rvH1vwYBn4XHKm6wmlbpx1SaEOpoq?=
 =?us-ascii?Q?K30fQ4qqYvqqXnrV2RfiaED1bybatEwPRErshica92mdhmCpVDqnqTUtGYp0?=
 =?us-ascii?Q?BBCbzWFLFWXv6n9ynP35EPsfVRnSrBR3h8NtsYVBCNIb3s6QHwg+M8ddeZZh?=
 =?us-ascii?Q?QedgPmP+/KhlcDyRdS8VKHleRtoVpshYYgyEgM5dt8NbVsQRXIhruokDAdPH?=
 =?us-ascii?Q?Pudn+T/DK/4dtGShi0dfwPWSDzxW3Mm8vd8RbfEJtGFb5CKDe+sws0Il2r9T?=
 =?us-ascii?Q?WlE9jJedIV/CDDKaVPlguBdcN5IiuRgalFEgxcoYdvoujKPwmzXosW9JQTSj?=
 =?us-ascii?Q?1HrK2rEaVrngsDFJyJlOS8OZUObL3LPuM6i4Gbd3I1a0jYcGBhxQnvViPlYf?=
 =?us-ascii?Q?xtDa9WdqTrVgoM62gSZuwLaIeMyzLUQxqo+NTvZ3/ecowB0qfvNmZWpeRo/4?=
 =?us-ascii?Q?X1/7WPhznppAK2mJTehzouYiO1f1cBRCk1thq0TSTAsvRMn19L5p4zqezZTs?=
 =?us-ascii?Q?e5Bpad6ZxUgl7EXy+WUUblor4PbPsFmMqfC6/PyfgsPVyY/qMJ88jiu9L4PQ?=
 =?us-ascii?Q?g5CKpACY2p3pS8PqS9ykW8flsMZ78AvThqJZ5sZvnrLWq2JOl6BiBUBVxOZ2?=
 =?us-ascii?Q?Ey1YhliRbdT4nV4MV3lt94ugrVo386zB1oJ+74C2Euhgw/JZvc5bASnxw9gJ?=
 =?us-ascii?Q?1JAXAPnzJq0kG6xr5H4lJHHicdkBgTWSsaJ5oBrOqNJyDpzZLxPQefBN3kqo?=
 =?us-ascii?Q?1u+8tTXvO483C9uvEHVYTS1NECnm1dDaEY0YtoOvPr43atXcUgTs/HZ+pKXL?=
 =?us-ascii?Q?WbFFiWvVsrPy9B7HY843T/PS1nvunOMWz9z4xUrSHRMmhXW3AmmqEXZqe+X0?=
 =?us-ascii?Q?zwtpYPm3k00nM951M8iMo0ClbYYtOJZBMAYqbcUUWB78KY0riRRE83s9isl/?=
 =?us-ascii?Q?I/XD0zYaRQMNksA6RepYvvVuO8wVXUeOO80iKUvEfsS4ldr+0emOkbEmD7Qe?=
 =?us-ascii?Q?69VZRjPyULasyz9SdMZ8RNckxdZRDichqFseve4uLt43rH+xMrAfuiwrrsTM?=
 =?us-ascii?Q?cQsFja1aU3nQto2yiDCt75IfwLDx+UgK9UURnWQxq3ZGZV2z9MoTwliV8z6k?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf986aff-35ec-4033-df28-08de00210db0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 12:58:29.9442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1zvbs+M52uhCCHC8wDI26UROq5NDr1TKOyBPOeNiQed4WzvJ/GSE+RZAKcevDCYGBvmIZzCcexGqqH2HiJ7HH0AjtGLXzkNFukHQW28Awg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6706
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

On Tue, Sep 30, 2025 at 02:45:49PM +0200, David Marchand wrote:
> On Wed, 23 Jul 2025 at 18:21, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> > +/*
> > + * list of EAL arguments as struct rte_argparse_arg.
> > + * Format of each entry: long name, short name, help string, struct member name.
> > + */
> > +/* (Alphabetical) List of common options first */
> > +LIST_ARG("--allow", "-a", "Add device to allow-list, causing DPDK to only use specified devices", allow)
> > +STR_ARG("--base-virtaddr", NULL, "Base virtual address to reserve memory", base_virtaddr)
> > +LIST_ARG("--block", "-b", "Add device to block-list, preventing DPDK from using the device", block)
> > +STR_ARG("--coremask", "-c", "Hexadecimal bitmask of cores to use", coremask)
> > +LIST_ARG("--driver-path", "-d", "Path to external driver shared object, or directory of drivers", driver_path)
> > +STR_ARG("--force-max-simd-bitwidth", NULL, "Set max SIMD bitwidth to use in vector code paths", force_max_simd_bitwidth)
> > +OPT_STR_ARG("--huge-unlink", NULL, "Unlink hugetlbfs files on exit (existing|always|never)", huge_unlink)
> > +BOOL_ARG("--in-memory", NULL, "DPDK should not create shared mmap files in filesystem  (disables secondary process support)", in_memory)
> > +STR_ARG("--iova-mode", NULL, "IOVA mapping mode, physical (pa)/virtual (va)", iova_mode)
> > +STR_ARG("--lcores", "-l", "List of CPU cores to use", lcores)
> > +BOOL_ARG("--legacy-mem", NULL, "Enable legacy memory behavior", legacy_mem)
> > +OPT_STR_ARG("--log-color", NULL, "Enable/disable color in log output", log_color)
> > +STR_ARG("--log-level", NULL, "Log level for loggers; use log-level=help for list of log types and levels", log_level)
> 
> Previously, we could have multiple --log-level options.
> While here, I think we will keep only the last value.
> 
> Should it be a LIST_ARG?
> 

Never thought of that. Will take a look. However, am I right in thinking
that within a single log-level arg, you can have multiple level specifiers
for different components?

> > +OPT_STR_ARG("--log-timestamp", NULL, "Enable/disable timestamp in log output", log_timestamp)
> > +STR_ARG("--main-lcore", NULL, "Select which core to use for the main thread", main_lcore)
> > +STR_ARG("--mbuf-pool-ops-name", NULL, "User defined mbuf default pool ops name", mbuf_pool_ops_name)
> > +STR_ARG("--memory-channels", "-n", "Number of memory channels per socket", memory_channels)
> > +STR_ARG("--memory-ranks", "-r", "Force number of memory ranks (don't detect)", memory_ranks)
> > +STR_ARG("--memory-size", "-m", "Total size of memory to allocate initially", memory_size)
> > +BOOL_ARG("--no-hpet", NULL, "Disable HPET timer", no_hpet)
> > +BOOL_ARG("--no-huge", NULL, "Disable hugetlbfs support", no_huge)
> > +BOOL_ARG("--no-pci", NULL, "Disable all PCI devices", no_pci)
> > +BOOL_ARG("--no-shconf", NULL, "Disable shared config file generation", no_shconf)
> > +BOOL_ARG("--no-telemetry", NULL, "Disable telemetry", no_telemetry)
> > +STR_ARG("--proc-type", NULL, "Type of process (primary|secondary|auto)", proc_type)
> > +STR_ARG("--service-corelist", "-S", "List of cores to use for service threads", service_corelist)
> > +STR_ARG("--service-coremask", "-s", "Hexadecimal bitmask of cores to use for service threads", service_coremask)
> > +BOOL_ARG("--single-file-segments", NULL, "Store all pages within single files (per-page-size, per-node)", single_file_segments)
> > +BOOL_ARG("--telemetry", NULL, "Enable telemetry", telemetry)
> > +LIST_ARG("--vdev", NULL, "Add a virtual device to the system; format=<driver><id>[,key=val,...]", vdev)
> > +BOOL_ARG("--vmware-tsc-map", NULL, "Use VMware TSC mapping instead of native RDTSC", vmware_tsc_map)
> > +BOOL_ARG("--version", "-v", "Show version", version)
> > +
> > +#if defined(INCLUDE_ALL_ARG) || !defined(RTE_EXEC_ENV_WINDOWS)
> > +/* Linux and FreeBSD options*/
> > +OPT_STR_ARG("--syslog", NULL, "Log to syslog (and optionally set facility)", syslog)
> > +STR_ARG("--trace", NULL, "Enable trace based on regular expression trace name", trace)
> 
> Same comment for --trace.
> 
> 

Ack.

> > +STR_ARG("--trace-bufsz", NULL, "Trace buffer size", trace_bufsz)
> > +STR_ARG("--trace-dir", NULL, "Trace directory", trace_dir)
> > +STR_ARG("--trace-mode", NULL, "Trace mode", trace_mode)
> > +#endif
> > +
> > +#if defined(INCLUDE_ALL_ARG) || defined(RTE_EXEC_ENV_LINUX)
> > +/* Linux-only options */
> > +BOOL_ARG("--create-uio-dev", NULL, "Create /dev/uioX devices", create_uio_dev)
> > +STR_ARG("--file-prefix", NULL, "Base filename of hugetlbfs files", file_prefix)
> > +STR_ARG("--huge-dir", NULL, "Directory for hugepage files", huge_dir)
> > +OPT_STR_ARG("--huge-worker-stack", NULL, "Allocate worker thread stacks from hugepage memory, with optional size (kB)", huge_worker_stack)
> > +BOOL_ARG("--match-allocations", NULL, "Free hugepages exactly as allocated", match_allocations)
> > +STR_ARG("--numa-mem", NULL, "Memory to allocate on NUMA nodes (comma separated values)", numa_mem)
> > +STR_ARG("--numa-limit", NULL, "Limit memory allocation on NUMA nodes (comma separated values)", numa_limit)
> > +STR_ALIAS("--socket-mem", NULL, "Alias for --numa-mem", numa_mem)
> > +STR_ALIAS("--socket-limit", NULL, "Alias for --numa-limit", numa_limit)
> > +STR_ARG("--vfio-intr", NULL, "VFIO interrupt mode (legacy|msi|msix)", vfio_intr)
> > +STR_ARG("--vfio-vf-token", NULL, "VF token (UUID) shared between SR-IOV PF and VFs", vfio_vf_token)
> > +#endif
> 
> 
> -- 
> David Marchand
> 
