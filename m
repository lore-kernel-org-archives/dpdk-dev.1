Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32760C43327
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 16:45:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23B3E40611;
	Tue, 30 Jun 2026 18:45:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id AB43E402D2
 for <dev@dpdk.org>; Tue, 30 Jun 2026 18:45:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782837912; x=1814373912;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=82kCPJoqTQLMBWsprEgMhySWMg+BdZ6o1dunHXQNveU=;
 b=XO2rxvSQoegCsdgS/uo8SGG8LA6ScgfFqukHnnLv8q1PHXW1cxVAA6kS
 kBCtCo22QssDEtLYZKlrAaulIh1cupPsvNVtoGaUtYdeppxg94wEEC39i
 3DfIZbznAL1rf8HtT+yLFHRRPfCEWTyrKUhZHk/5aONUEVa3bZ8WJkkGH
 zJcwd2VVS20llXU4zdod3hrB3dc9g5FV2a+Vev7KdNs50zWIpvmlPw3RC
 SvCIlSuryX8nbMRvnHW/zmgrJG8K09M1Xyp1DAmYGwwNWnW/nuU8heqZS
 lrxVXpa6XAkd3yCg0WYZf79uRFpp6RypI0KmOA66Uxql4nWkT2roRkJve A==;
X-CSE-ConnectionGUID: fXuwwb/FT1ms2X7hJ2/Ifw==
X-CSE-MsgGUID: hLGjFHmPSU2L9uxfb6MNpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="94210778"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="94210778"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 09:45:11 -0700
X-CSE-ConnectionGUID: 71fXMV8TRRaIvjsDqjWO1Q==
X-CSE-MsgGUID: hX6xCXdqQLuPg0soSBOwmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="249682034"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 09:45:10 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 09:45:10 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 09:45:10 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 09:45:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2KFdkBGnXc8knz/1AwBbJ22h6KKkLqgR4AJF8WPr9DgmLrChQme8OjQ8rNeIYHiylHSH3dmrMCqytBvi1WFxTdMikSc2UUV2qocAHPIt8od2Th0u+kdEb1hpOs6sRToNTLzjAi9iB9TlQG49uEI1V9Q7b8vgGX+IIftEUUqhDNY/cF604PxueZ6dXV5Lm7Z6A0r+rbsZ4Xb0IoTK/SryL0n96/sfUcCxf9AEQ8e3irIFIhTTXDzjfCxHTlPiXy9RPV30SJoh8uJ6bT/u40uBj6VaTdyuw6Jd+VZ0C/y47V/WF4a8Vb+48w3H1wrpNtPvRUI+N3uXwC5a+OV0yUGrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJoxzmNJXe/tH7rB8zxfEeT27usJ/zRzr+p9aanqqm0=;
 b=kACfKsZH/ZyQWgZW/uxZm/K5Ds1tBQ0XDAvMki5UWABPva/pVQu4uLpHHCsuYG1UI/6tYwZPVbD6fyHwhgvF4QvtjmHd/av5qupGIfK5w0aQs9Onbjqxe2oQrcAJksqfugKKIYvTuouihLmFJCAfEq4Hn1KqWYNZcwLSOl/zhTZ6NMWXA6o6kjsXrXZY2f3uuFvBoK0ho8dLggU3oUwSg+zSRHOSPsj9W9X0bNAIqeECXcYQQ3c6UB11kXCoKnTSplXtj6eOoaJ5ZyZuKj5rNauhB+NTb1HqlX6U4mjNBoAgno6IyYYM5cSngA0K7wtPzjKa9ICksCJZK1HDqCpdLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by BL3PR11MB6313.namprd11.prod.outlook.com (2603:10b6:208:3b0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 16:45:07 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 16:45:07 +0000
Date: Tue, 30 Jun 2026 17:45:02 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Marat Khalili <marat.khalili@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [RFC] doc: updating doxy-api-index.md and doxy-api.conf.in
Message-ID: <akPyjgQwQxLw1KQV@bricha3-mobl1.ger.corp.intel.com>
References: <f0e4ffa90e57467cb292d7888caa697e@huawei.com>
 <cesJxiasRY6aqEM1iZ_leA@monjalon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cesJxiasRY6aqEM1iZ_leA@monjalon.net>
X-ClientProxiedBy: DU2PR04CA0222.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::17) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|BL3PR11MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: af4e82a8-e04a-4ef5-7012-08ded6c6f138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NVPjgjxmSIJv3z914Tht40UOePnTexG5MMP4DPkfxpdqvBqnAGitR1Le2t8qrf4YyneeKhazsfDqJbrQfrahguclEB8cBDkuRtAHYZhllKuj3DFnbPjc5G4ebmuHj91dDYsXe10hDBPX4gpb0zPHDgdcA/hvftWG4O/ag7dkIyFI1/JEroiVpqykfqkYBTcrBNL2NckBV43G5hbONcaNV660f4fKJgP9MiHGmQoXSqZi88Zu+FHQqCp7TVaKjFH+5+f8vuCS0qxHRLlD5EG4vOo5pZjnymYfrtP2LgtGu5guZViflZyeQ+uvtt/QSqnv3q3DQJywZm1qEAa8UBlRoDc6SPHi9tuCKdeIua0nah+wnaHBD4EP0IvQpPCP1vssoQbQaeV4MZdMW5nrk4ojTcCmKvPxhyPyEaqfcibol9OfF/zg8xgSnbeNZwMmRDTflkZdOGUJy1eZa8uQcKN5F3sB67OlAivlOGcnpJk4S633+ZtgGDv7NRl8mIQ35TNytdKdkr+/rCauJXe+osxWr6pBsTxK4zQkD58/NgxbBfjXPJrzJMgyN1vWkk16kdu4523e34Zyx2SdLG2icckjyu6yQx9vg0L/t4UZYkuWM7S9MHLFg9F32zV4KiKH/yTD8Vd+1Ba7M5jVpjPOwIEk6+msFE0k63e6D7arcLDhUac=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hMfOGRYIUrx7u40F2cZtgSMFc/KCD5U6WT+WniRCOXJNgr3zEvb36TjohyWR?=
 =?us-ascii?Q?rwwYwDVH4SSHvPLMW1UP1nBptMp+mcf+Ng9N36L+RK6ElTMkqcrXVRw2Z1sz?=
 =?us-ascii?Q?Q+o/AIi7hsUIpguoltRXqE8dEFH//hOaPHll+pDfsWI7+XTsSDueyDu53s6F?=
 =?us-ascii?Q?ihFuQq264KYZoqPfceKYRJ77rROdL3r/HYXFrIK4GoulJ61xa805ADprvBCp?=
 =?us-ascii?Q?m1EPryB/0Dn2OE8s4yOxAsNncIp18XYWIhSq7JNBhTGlG83MG+huOxy7XnvH?=
 =?us-ascii?Q?yLxEc2tkW4I8GZ1ECpTX+fiIf3HNEX4DwEPTtvsDd/4MEBFC77kJWup2926c?=
 =?us-ascii?Q?T7MG8yVNbc8Hfi1yyl37qDZkk3N0Gy2XhxT/39DHB1ua0goBE4AkEaJQShzS?=
 =?us-ascii?Q?GaP1x6SOhag5UJOo8nQc2jNMk/M2HkiwO+/v35F5Reii9nh36x1PU58iqqVJ?=
 =?us-ascii?Q?7L4SuD/+Mr8eBzXyaBshtnMnUCl+GXaxHj3l9hoI8liQcjtCzlBFbp5qEbm6?=
 =?us-ascii?Q?99Nba6+laTajhVgdXSy97HA73DiMT2URON1/q01DPhyDyC87/GeOL4IHa2LG?=
 =?us-ascii?Q?MZ2yMzplHlxF7yLrvyEWQZQnfvoY+XK5mQmcQ9bekv4qQspeCLr40RakUDgv?=
 =?us-ascii?Q?5LWPuCjeegvlopvBOmEIj5SFLmY2fhQXn+U5UK5OG3Lrh1KOcchZnlF8lpud?=
 =?us-ascii?Q?p1pzShrJisVdwTp9rTHJzeFuWYCL4jhB3E8yIfdTwSep4/rzQ7bNgjexDF1S?=
 =?us-ascii?Q?Ct06MjqtlD3NrCjSQU7v7Td4wjqzAcSxNpQoPD2qA6N6h7/mT6IzOK5ipvPE?=
 =?us-ascii?Q?QXw38nxFrGFZie+eBkiP8N4a3ra7qHUfMJkhjApR2j/QluNBr9+6RnsQ1nvA?=
 =?us-ascii?Q?YfMBCauovqpvf83kbwsqKCSGWSMLy92fDpj/59NotSdHjsVzI7serNpqMewN?=
 =?us-ascii?Q?SoZcgfSVzNVb04JvppRZm0LyomY9ttzRrqaZYEdOO71+0xC6Vjad7EA3eaxW?=
 =?us-ascii?Q?umnJBm+40MEl/1oy7QyH4OK1CQKyPPRTM2b46KU4DtfFFjATaYMt8BNEfbss?=
 =?us-ascii?Q?QjEcAfeW2nSqnbF4qVzfBpMAbySi7Kgm6bqS3yHDxjCcq7tmZshjaZYsmzHh?=
 =?us-ascii?Q?rM7VbKJsfGopRIDIho4RbLC9i6lo12vWFjlW2YazpbCTmo+ylE35lV/Lbpro?=
 =?us-ascii?Q?0STIKZ95TrTzEFyfB1KuGRwbaFLnm2bKqEg++OUi4kflppDfCScK6L5o+E0W?=
 =?us-ascii?Q?wsphyOBFnVO6oGEU0mpFMzhAP4J7LMn7XhwD1JpFp7o7JOzwXwc+ZCMK7cDt?=
 =?us-ascii?Q?Sg81l0r7qD/u1l1NHx6DA368vU3nw07pSih1jhUwfljmjLf45hjL2FMseX9a?=
 =?us-ascii?Q?BbiAemz2ia3W5nj1So6osWSxLK/z4iulzaUZ4o2Mf81JGBzSSmfwgR91+bV9?=
 =?us-ascii?Q?Uc3rISSkKINN8o9xwthDZOVLaX+UPuzUDTt0NB4W+TStcxrb6Cv3IVjj+Jvd?=
 =?us-ascii?Q?TQIfdaqEusC9rgSnf5e02TXp/40JDRcaHUM63aqhUqimrfpFcw7fK2g4kbFJ?=
 =?us-ascii?Q?fHVO9eBcx9JdD8DrYY1VeWI2XKk8fTHWvGrNbm9i7tuMvUu6gTm+Oq6m9te3?=
 =?us-ascii?Q?focrcQHnq6W2S49Wflfql6Nf21j+T1EtTAV4AkTVBWlGrWyxNM8EZG7YucHc?=
 =?us-ascii?Q?21X8X5W1cK42SMi3aNitokqkorUOB3DHH5KmxLse3WxJtimkos6rQqSqOXpg?=
 =?us-ascii?Q?aINJwixi6tbxk15gJX7v1oPIq/JEMMM=3D?=
X-Exchange-RoutingPolicyChecked: c8wjSY/yuGXnOtQmXfWtx9yDtXMNH2zDgjGgkO0Ij4JVyDOQtQkXkroFz8DuILYlnTd//XdSFQfTe4osv1uENjWBVZIDHAq42MKE+dRVraeedxjrl9wGWe2yLT7PuOElw6LXcAlxYA8Ph5/RYY/m2Qz+PGOJzVD+DiiNef6RHJ/N9YMYsAYKxrKrivOmzNKhnjZKjSN07vPIRhU6lZecdOKWKq3nx6LLo2hTlzgcWWr3OYYfazBwol/i/lnzi+fif6b3b1irtYx0FZGM3i5rq7lTsj/1cR1tnWzxrSis2BwOraawTKvwlW7KdzYuwSEUC9sYEHJsM3CQ3DSWYjZ7OA==
X-MS-Exchange-CrossTenant-Network-Message-Id: af4e82a8-e04a-4ef5-7012-08ded6c6f138
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 16:45:07.4174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rH3hysLz3QE1UDoN5hoo6LP/4ThcuAGcoyB59JX95udA+Xdts+An6jMLCda0tsXF2Dtl71KFBuj+klScBiKx2ZrIlUuwPmYqhhbtwVv+4n0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6313
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

On Tue, Jun 30, 2026 at 06:10:59PM +0200, Thomas Monjalon wrote:
> Hello,
> 
> 30/06/2026 11:03, Marat Khalili:
> > I noticed that a few header files contain docstring-like comments but are not
> > present in doc/api/doxy-api-index.md and/or (fewer) in doc/api/doxy-api.conf.in
> > There seem to be no checks anywhere in the process that would make sure these
> > index files are updated. Do we even care, or is it unsupported legacy? If we do
> > care, would a check or an automatic generation fix be more promising?
> 
> Some internal files have doxygen comments, not sure why,
> probably to run Doxygen manually on these files.
> 
> In the scope of our public documentation,
> the goal was to document all and only public API.
> 
> If you see some public API not referenced, it is a bug.
> And yes a script to check this may be useful.
> 
Something like this could work as a quick check that all public headers are
getting indexed. Doesn't help with verifying that all contents within the
files have comments, but maybe its an easy start point:

diff --git a/drivers/meson.build b/drivers/meson.build
index 4d95604ecd..5a9ba68d54 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -278,6 +278,23 @@ foreach subpath:subdirs
         dpdk_headers += headers
         dpdk_drivers_headers += driver_sdk_headers
 
+        # On Linux, best-effort check that public headers are named correctly
+        # and that the driver directory is referenced in the Doxygen config so
+        # that its API gets indexed.
+        if is_linux and meson.version().version_compare('>= 0.59.0') and headers.length() > 0
+            foreach h:headers
+                hname = fs.name(h)
+                if not hname.startswith('rte_')
+                    warning('drivers/@0@: public header "@1@" does not start with "rte_"'.format(drv_path, hname))
+                endif
+            endforeach
+            if run_command('grep', '-qF', '@TOPDIR@/drivers/' + drv_path,
+                    dpdk_source_root / 'doc' / 'api' / 'doxy-api.conf.in',
+                    check: false).returncode() != 0
+                warning('drivers/@0@: has public headers but not listed in doxy-api.conf.in'.format(drv_path))
+            endif
+        endif
+
         if headers.length() > 0
             dpdk_includes += include_directories(drv_path)
         endif
diff --git a/lib/meson.build b/lib/meson.build
index af5c160cb8..d897b2c73a 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -209,6 +209,23 @@ foreach l:libraries
     dpdk_indirect_headers += indirect_headers
     dpdk_drivers_headers += driver_sdk_headers
 
+    # On Linux, best-effort check that public headers are named correctly
+    # and that the library directory is referenced in the Doxygen config so
+    # that its API gets indexed.
+    if is_linux and meson.version().version_compare('>= 0.59.0') and headers.length() > 0
+        foreach h:headers
+            hname = fs.name(h)
+            if not (hname.startswith('rte_') or hname.startswith('cmdline'))
+                warning('lib/@0@: public header "@1@" does not start with "rte_" or "cmdline"'.format(l, hname))
+            endif
+        endforeach
+        if run_command('grep', '-qF', '@TOPDIR@/lib/' + l,
+                dpdk_source_root / 'doc' / 'api' / 'doxy-api.conf.in',
+                check: false).returncode() != 0
+            warning('lib/@0@: has public headers but not listed in doxy-api.conf.in'.format(l))
+        endif
+    endif
+
     libname = 'rte_' + name
     includes += include_directories(l)
     dpdk_includes += include_directories(l)
