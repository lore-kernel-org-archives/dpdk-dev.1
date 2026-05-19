Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2E2CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 17:58:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA4C9402EB;
	Tue, 19 May 2026 19:58:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id BEBF9402E9
 for <dev@dpdk.org>; Tue, 19 May 2026 19:58:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779213495; x=1810749495;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=b6ODWvRPPI7r43+icN174W1mrZnBZajTibZTUDEBfK8=;
 b=UIE3xYiqAS/m6JStw6qBF1mA8OEkwkrRN22baVMGhMZ/becMM54fzIu/
 P2uvYlRxCr1bC40JA0GC6Xb5EgsF2HpId3Gyva0EtyeGI1qWLZXL3q5BO
 KjaJgnLtFw12GMcJy6MwalXs2svOtA6FcTal0KQztE3Wm69SPQHwMdQQk
 YPjiT/idpD21Bv3fHIMRkR0ai3abnKBEgYOq28ZHnRdwCOqfvq1KFDkhN
 iPOUjTWVHelYnxnb4q0Ug0IoOCEy9h/S97W0RdKBzOPEGDaQQacXAfsPb
 5XM5Zlgl0fYyIlaspPwKpHC7Un4p4CVZp//d9i70ChRzJkKaan3+JfktU w==;
X-CSE-ConnectionGUID: NFkNNdUvQ8ihKT9ncINFoA==
X-CSE-MsgGUID: QcpNBtMXToKfB1guoSwrnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="83982627"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="83982627"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 10:58:14 -0700
X-CSE-ConnectionGUID: XTMWr6qPQcyCrLe2FDUbOg==
X-CSE-MsgGUID: UaWFUcidSn2PEokJs5JCbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="239705527"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 10:58:14 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 10:58:13 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 10:58:13 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.54) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 10:58:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xrk0POu2VFXGV97dGSyGN+qTQQ+7fRVRjFcvwbTPoLF2vvnX5xx7d85J2HHg8fcBEDIGP5G5yDfA6Viz3rLUxxDey7nzBx+1/wl1GbWnbt4Q9RvkLjm1vCAH9Qv2U0x0/buaWP1miYKfvaxieuGgE6gcf6IWQCVDx/uD/g3N5MeTNz4gNk6RkqHOwWOAhuHINsu4DhJymzrNN/vyDkNWAJ2s1TC2IS+0tS0tTP12tXxjzKWGzffCT1S1uYOeeM9yIn6c9CYUZWWsC9JpEb/KmfoZ91Bf++BpBhEx0RyVixJDSbvRC9Igq4HaPl+bqmc4+kWnliiOiYAuyQWak6ibMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6qmKvKMceZKDanHSHq7znqWVS3NJOCX5nQN/2ZaphE=;
 b=XurLu6EZa91WS+Xa0tAjm0Ju9VLKMNQUF+uR89by17Q05PraVFzxmHSgdwS+V4yrfeJC06/atd2ZYSI6SMm05UK+r3LNiayM37X8Vv8odBcZbiydoEf/MnhkgyjZiF3UaggzInjsNtG49zUlOH4Dq1uNItGkIiFJesFkU6RR1WFNT7k0nBiHBVJajuIC2pwEP0qHrq+ibUdHGxn4xt6dIhIf04iZYO0ATJjEyFDFpk7Dv7aQdyl69nwP1fL8kMnZFzS3oXuhHNaGNsyNDCWc1Ls9HIDW5O+C7xoRhZ+8JYwEe3XANUZ6l+0zo0mCRdZSPv+u6CfzMBCC6K5TMEKlBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7895.namprd11.prod.outlook.com (2603:10b6:610:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 17:58:10 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 17:58:10 +0000
Date: Tue, 19 May 2026 18:58:05 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <patrick.mahan@hpe.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>
Subject: Re: [PATCH] net/ice: improve log messages for DDP loading
Message-ID: <agykrWAcEnOBZvY-@bricha3-mobl1.ger.corp.intel.com>
References: <20260516101942.443871-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260516101942.443871-1-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0216.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c83ff96-b04c-4789-09c3-08deb5d03033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799006|56012099003|22082099003|17002099007|18002099003;
X-Microsoft-Antispam-Message-Info: dg8/N1U+9Ee9ALLBN/hOH10fENHDHxbxiMy/+HLzzcQRi+un/fmYLz4Hywp/srP/u2bF+gN8PW0DoTMAHW3Tu6a/Bjo1X04s4vivIG2uyP+zg1P05Qb1wzWoycOLV3oUo8jCryRrs9rRqQGsFG7SgPWt0xmmaMUzzBSd3x+DuCss1MA3xFOvH5xI7VL3x/E8/G4+9lh4BGTqP2xni+QZ9OA4ubow+NJvrv3+O5V1jzs2LokSBDblO5o+3JfO5vuZDiaMwGNjfDlTU8kEMlx6zH4eusHxqvSB5QtvbA+ldeZ5qfJLLq5w0LtyfBxBddsX/W9xsv6g7I1ys8wT4YO+akfkPRd1cgQHATqPNlLYqtd2z3HGrEodV8YBxbTveJDVGDnNvoyvD9mxCadFBa5DJtJGw6islIJtkIRmuok2jnSUDYAr0IjU4ilN4uphzFoAeDK5qzSu3d66z0uxyLNCmx3OS5DkYoaTapOyG+cCjK7wf1sU7ksVXJKWlf1kjzSRp2krH3WendQBHukpgIJj438LBdWoksHS05kXpqJ0Az7FEI+6buXqWy3u6CCcT3nLrToe45UdR7rt3fHHQDg1bX0nJAaXuS1uAEsEc2i+NOUncbjo5+dh3dpZ4gkw1A+hCmRPkMl409EvCLIM9KMGuD6AADf7SMeJxAHHsfF5dyKzmL+f8L47UvWlvV5fehqk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(56012099003)(22082099003)(17002099007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NuaFtfScea9pciRjcbCCLv++6+sFUqwnieh7FXLOUnPHthd3Q9ca1SO8aOBa?=
 =?us-ascii?Q?5/6vqccQCal1jPRp5r/vXZMCaU1XdYcD6rwaug7/kzdK/LNzbyW9ZTENIvts?=
 =?us-ascii?Q?qCiZqii6QjcR7z+H8EIDpkDOkxmTiqDpP6jzpLPEt/cIo8FnBU3NnCIVHwgD?=
 =?us-ascii?Q?pk+zLJfaB2sY7mjxZSi/mtJiD7VhKffebQNzqfLvAxORoJaIQPIFR719l86Z?=
 =?us-ascii?Q?Sihcpmc/RaRQ44fIAU81zt2/3u4kd9wq76Gjmsc8LdXFLVbAy5lpBp/d9tMa?=
 =?us-ascii?Q?z/1LyaJQJTaHb1SHD0Mp79R8W3eaS0lb6h7j/bBx3VCKR/jUx4/VgJ9rir6d?=
 =?us-ascii?Q?3uX5vaBirCDuL84Vfy6ohaSdrTUcVhVKqCKNZKh79IhfcN/+TaKXmEXMFxKa?=
 =?us-ascii?Q?ZIn99xT7yWsbl3QiDfOJM4UQfwmaexLrow5ZStIkRIBUyqbcrVk87lDwV2BJ?=
 =?us-ascii?Q?Xs4SWmCLkDIJfOQ+GhE3n6nLyRe8Q5p6acgY7PG47WvMO67+GJ/ff8mn3ggD?=
 =?us-ascii?Q?eawTBxa5ifC7WXzcGUbWgFciK5A8Z2jmjiksNPOtJ5vFafH6DT/SCKsNE6fj?=
 =?us-ascii?Q?Hy2K7ZOluxOdl4iSzjeqx/mm+KGHW6c3W1wsRHXsCG6s0PjQgEeu5rC4H6QK?=
 =?us-ascii?Q?+89YR0u9tMMwvhtLN/4JcHY4gYE3F9XVw1NBz0wl11D7sLx9DdlDvY3jMWSm?=
 =?us-ascii?Q?iuDgPWg6fg3IMrVuyY5wJk8oqiyj+IvSqogKmk9cE8BfHTvG5PwjIz7DJZ77?=
 =?us-ascii?Q?6w6lw0AtSsWQZQzolPcC1sg9+2rcqPql9CYZBAiAZEWiwtqflVIIbX4M0qmL?=
 =?us-ascii?Q?BxaGXe8Pry6+iT/th0sW/ZUMVuH4KEpJBdDOlfcvPmp94mxU6Tm84AvgyeKZ?=
 =?us-ascii?Q?FL89qSOnCk9AeJNSx5hBjBCZzuzIj0gd6kfeVQJ6YnkkepFFdQ1BqYgQ9dPX?=
 =?us-ascii?Q?p/B2NL6N3xpVXGEYz1BHoxiL/jOnGdelNSwHp5dcXFUUCTRquopohBBRdUqo?=
 =?us-ascii?Q?oqeEVbDkt0jiNQUeXwTCG4H29fERpjFLxoZMAif83pWDaM46MS7ufLU41jV7?=
 =?us-ascii?Q?anjzynHgrPWhT5ev5CFgb/gnjRz8u6ozjBurVEdMXtFLomvebAaWYqaWgv32?=
 =?us-ascii?Q?/LxG71LEBgvoEGh8Knk3wF+0K1ooZQxyt9xgcErzXqS50IZD3SmbmtstSPPs?=
 =?us-ascii?Q?q/EJj4FH6WYdWmxsXlTpzpH6Zl1XiTvphcrjs8QvFYSRB9X8DfUtnqZFuGSa?=
 =?us-ascii?Q?eaOelQsNkKcJmpy/nHhtdACGAjtphcHLnvZWIJz1cS1Il8R8YgQ4aC54ifOt?=
 =?us-ascii?Q?Qfs7DqUsOxNgE46x4wwswkkKEqX0DD+BSrx3BFM0PlBHR63s/zZCM4H6dpYq?=
 =?us-ascii?Q?AxxFlaTmQXEE/YLAKrUN+rNZXz1ndJHQOGq0wI0yRVMsyNVIz6xOCVyatopA?=
 =?us-ascii?Q?gnronee49ySAtsI+E/ILa+M/PbT0t8lSe6KCaVLA8iSvCWC6fTD/+oRtCppJ?=
 =?us-ascii?Q?nGFcRBqBnjLdbMxX4N9LjFo+dY1+lPnlBj+lTiyAA8BL13dRYSVrxvWchRlH?=
 =?us-ascii?Q?WlWTvk/A83N1+2R1G99q3QPUDGKvVuXutvSMx+UgNMcdyiOYNJ3dakFOXq+J?=
 =?us-ascii?Q?hRoC0otBevQFBYBV7jPuQ8vyzFD0Xz/dzYhBuYJPVJMObmLzBIjwODVf833D?=
 =?us-ascii?Q?YQcf87lQLptJcfjohsSWEq55mZJmxBPEP5cQ0ip56oQgadf9x2CjYszO8VZ2?=
 =?us-ascii?Q?QmEB+oRzpmS+zQq/koIV4RZIzUStEpE=3D?=
X-Exchange-RoutingPolicyChecked: n7HeElJPPxCVQ9rdWl94xZMxaENiEmw4QA7wuLigKi2MLROTL70bVK4r+Y32PZHdZtsfVTFH8rD2N5aKMb25RNiMuD7bWWuvEJz0/hYvadTCVMBxn6rVIRrTRSXaruG02Y7uHliVPgBSGO9er10HGYBTF/8P0f+0PKTrIhck7S3tqdNmVqVucm6wM5epadu6Y7ILoWV5zfmtVszoRQw9yJAM6O/hiMWVWaDOJrRVLGAnOQwomQ30d7Be6LgqsqUlYa+LZY0PO73qQIFs4KW+XaQiOX6RLiD5JASD3s7pkUZc+Z0yBKn2UyY9wdvJrWcfbMntnt2lEBEQgb4uKnI4UA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c83ff96-b04c-4789-09c3-08deb5d03033
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 17:58:10.2539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6gSxx5XO1Vic9Oit7bEnceWeq+ZYTWS1nDa6EiKwRKUTmWkRLKPlRG4NeegJuEP3Ap6MhUTLAt+LuhN2SpVUceBueSyV+mf/nFfSxCOMNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7895
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

On Sat, May 16, 2026 at 12:19:41PM +0200, David Marchand wrote:
> Some nics may not provide a serial number (PCI capability
> RTE_PCI_EXT_CAP_ID_DSN).
> 
> This results in a confusing ERROR log:
> ICE_INIT: ice_dev_init(): Failed to read device serial number
> 
> This is confusing as DDP loading does *not* require the serial number to
> be present for the port to be functional afterwards.
> 
> Besides, after trying various path, if the default DDP is not present on
> the runtime system, the port initialisation ends up with a vague error:
> ICE_INIT: ice_load_pkg(): failed to search file path
> 
> Improve the situation with adjusting the log level when reading the
> SN fails, then add more debug context to DDP file loading and end up
> with a ERROR log mentioning the expected file.
> 
> ICE_INIT: ice_firmware_read(): Cannot read DDP file
> 	/lib/firmware/updates/intel/ice/ddp/ice-b49691ffffe6e69c.pkg
> ICE_INIT: ice_firmware_read(): Cannot read DDP file
> 	/lib/firmware/intel/ice/ddp/ice-b49691ffffe6e69c.pkg
> ICE_INIT: ice_firmware_read(): Cannot read DDP file
> 	/lib/firmware/updates/intel/ice/ddp/ice.pkg
> ICE_INIT: ice_firmware_read(): Cannot read DDP file
> 	/lib/firmware/intel/ice/ddp/ice.pkg
> ICE_INIT: ice_load_pkg(): Failed to load default DDP package
> 	/lib/firmware/intel/ice/ddp/ice.pkg
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 31 ++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
On top of the changes made in this patch, how about something like the
below to extend things?

Rather than just debug logging the failed paths, we change the debug logs
to always log each load attempt. We also record the path as it's attempted,
and then on failure to load any path we use that record to print out an
error message for each failure, so the user can see in the error logs ALL
the failed paths, rather than having to re-run the app at debug level to
find them.

WDYT?

/Bruce

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index e065581ccf..926b0febea 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -8,6 +8,7 @@
 #include <ctype.h>
 #include <fcntl.h>
 #include <stdio.h>
+#include <sys/queue.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
@@ -2003,15 +2004,23 @@ static int ice_read_customized_path(char *pkg_file, uint16_t buff_len)
        return n;
 }
 
+struct ddp_path_list_entry {
+       TAILQ_ENTRY(ddp_path_list_entry) next;
+       char path[ICE_MAX_PKG_FILENAME_SIZE];
+};
+TAILQ_HEAD(ddp_paths_head, ddp_path_list_entry);
+
 static int
-ice_firmware_read(const char *file, void *buf, size_t *bufsz)
+ice_firmware_read(const char *file, void *buf, size_t *bufsz, struct ddp_paths_head *searched_paths)
 {
-       int ret = rte_firmware_read(file, buf, bufsz);
-
-       if (ret < 0)
-               PMD_INIT_LOG(DEBUG, "Cannot read DDP file %s", file);
-
-       return ret;
+       /* record paths searched for DDP files */
+       struct ddp_path_list_entry *path = malloc(sizeof(struct ddp_path_list_entry));
+       if (path) {
+               strlcpy(path->path, file, sizeof(path->path));
+               TAILQ_INSERT_TAIL(searched_paths, path, next);
+       }
+       PMD_INIT_LOG(DEBUG, "Trying to load DDP file from: %s", file);
+       return rte_firmware_read(file, buf, bufsz);
 }
 
 int ice_load_pkg(struct ice_adapter *adapter, bool use_dsn, uint64_t dsn)
@@ -2020,6 +2029,8 @@ int ice_load_pkg(struct ice_adapter *adapter, bool use_dsn, uint64_t dsn)
        char pkg_file[ICE_MAX_PKG_FILENAME_SIZE];
        char customized_path[ICE_MAX_PKG_FILENAME_SIZE];
        char opt_ddp_filename[ICE_MAX_PKG_FILENAME_SIZE];
+       struct ddp_paths_head searched_paths = TAILQ_HEAD_INITIALIZER(searched_paths);
+       struct ddp_path_list_entry *path, *tmp;  /* used to free the paths list */
        void *buf;
        size_t bufsz;
        int err;
@@ -2027,9 +2038,14 @@ int ice_load_pkg(struct ice_adapter *adapter, bool use_dsn, uint64_t dsn)
        /* first read any explicitly referenced DDP file*/
        if (adapter->devargs.ddp_filename != NULL) {
                strlcpy(pkg_file, adapter->devargs.ddp_filename, sizeof(pkg_file));
-               if (ice_firmware_read(pkg_file, &buf, &bufsz) == 0) {
+               if (ice_firmware_read(pkg_file, &buf, &bufsz, &searched_paths) == 0) {
                        goto load_fw;
                } else {
+                       /* free the searched paths list */
+                       RTE_TAILQ_FOREACH_SAFE(path, &searched_paths, next, tmp) {
+                               TAILQ_REMOVE(&searched_paths, path, next);
+                               free(path);
+                       }
                        PMD_INIT_LOG(ERR, "Cannot load DDP file: %s", pkg_file);
                        return -1;
                }
@@ -2043,11 +2059,11 @@ int ice_load_pkg(struct ice_adapter *adapter, bool use_dsn, uint64_t dsn)
                if (use_dsn) {
                        snprintf(pkg_file, RTE_DIM(pkg_file), "%s/%s",
                                        customized_path, opt_ddp_filename);
-                       if (ice_firmware_read(pkg_file, &buf, &bufsz) == 0)
+                       if (ice_firmware_read(pkg_file, &buf, &bufsz, &searched_paths) == 0)
                                goto load_fw;
                }
                snprintf(pkg_file, RTE_DIM(pkg_file), "%s/%s", customized_path, "ice.pkg");
-               if (ice_firmware_read(pkg_file, &buf, &bufsz) == 0)
+               if (ice_firmware_read(pkg_file, &buf, &bufsz, &searched_paths) == 0)
                        goto load_fw;
        }
 
@@ -2057,27 +2073,39 @@ int ice_load_pkg(struct ice_adapter *adapter, bool use_dsn, uint64_t dsn)
        strncpy(pkg_file, ICE_PKG_FILE_SEARCH_PATH_UPDATES,
                ICE_MAX_PKG_FILENAME_SIZE);
        strcat(pkg_file, opt_ddp_filename);
-       if (ice_firmware_read(pkg_file, &buf, &bufsz) == 0)
+       if (ice_firmware_read(pkg_file, &buf, &bufsz, &searched_paths) == 0)
                goto load_fw;
 
        strncpy(pkg_file, ICE_PKG_FILE_SEARCH_PATH_DEFAULT,
                ICE_MAX_PKG_FILENAME_SIZE);
        strcat(pkg_file, opt_ddp_filename);
-       if (ice_firmware_read(pkg_file, &buf, &bufsz) == 0)
+       if (ice_firmware_read(pkg_file, &buf, &bufsz, &searched_paths) == 0)
                goto load_fw;
 
 no_dsn:
        strncpy(pkg_file, ICE_PKG_FILE_UPDATES, ICE_MAX_PKG_FILENAME_SIZE);
-       if (ice_firmware_read(pkg_file, &buf, &bufsz) == 0)
+       if (ice_firmware_read(pkg_file, &buf, &bufsz, &searched_paths) == 0)
                goto load_fw;
 
        strncpy(pkg_file, ICE_PKG_FILE_DEFAULT, ICE_MAX_PKG_FILENAME_SIZE);
-       if (ice_firmware_read(pkg_file, &buf, &bufsz) < 0) {
-               PMD_INIT_LOG(ERR, "Failed to load default DDP package " ICE_PKG_FILE_DEFAULT);
+       if (ice_firmware_read(pkg_file, &buf, &bufsz, &searched_paths) < 0) {
+               /* list out all the failed package reads, emptying the list */
+               RTE_TAILQ_FOREACH_SAFE(path, &searched_paths, next, tmp) {
+                       PMD_INIT_LOG(ERR, "Failed to load DDP package from: %s", path->path);
+                       TAILQ_REMOVE(&searched_paths, path, next);
+                       free(path);
+               }
+               PMD_INIT_LOG(ERR, "Error: Cannot load any DDP package");
                return -1;
        }
 
 load_fw:
+       /* we have success opening a package, so clear the load list */
+       RTE_TAILQ_FOREACH_SAFE(path, &searched_paths, next, tmp) {
+               TAILQ_REMOVE(&searched_paths, path, next);
+               free(path);
+       }
+
        PMD_INIT_LOG(DEBUG, "DDP package name: %s", pkg_file);
 
        err = ice_copy_and_init_pkg(hw, buf, bufsz, adapter->devargs.ddp_load_sched);
