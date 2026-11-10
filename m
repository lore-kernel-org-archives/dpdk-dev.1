Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0BB606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TpMytVe7
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D72FC40281;
	Tue, 10 Nov 2026 11:48:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 817754027C;
 Tue, 10 Nov 2026 11:48:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794307716; x=1825843716;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bde6ZSPFnu2nYb/VE7F4PfsrALZ1CxX6apsuHxrWsks=;
 b=TpMytVe7O0Pr2uzXRNsLvgvlvt/kzNagxm32d7Xy/n6/ILYT7VECcXoR
 NxzyWV/5sP3e30td1HaAQOf8JN4h63CuyQ3xxBGPIc3nQfFQMILHoqypR
 8D3g5nwnrzRobsRo2uqBN+GU55EQ1cOu95EKARXGk625nGyCp23hPAdT9
 P6CYS0NP7k3gKugUuABWhNjNc5IFYK9Dpi9XQYZ9uAvnkRkn9d9q14NWi
 IWNlqyYn5spnT8ljFCyYWE4YakaEzR3prF6LqyORB0+LYArScLr5L8v/P
 b4vVXNqsVCc6RwKuzGMBzz/TuNiiIGJ004NPPHSLQPyCjZzZoQo47O8qG g==;
X-CSE-ConnectionGUID: 3UTHk7nESbqMPSFQ96WrPQ==
X-CSE-MsgGUID: KAAAWfSPQASX4mJe+sUSaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3084309"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3084309"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 02:48:34 -0800
X-CSE-ConnectionGUID: uwgoX5w7ScGYU2AmKogwlg==
X-CSE-MsgGUID: MH+OQFvQSiawNdAI3L9NHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8288795"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 02:48:33 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 02:48:33 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 02:48:33 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.27) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 02:48:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uh5i2TI1XpwDkfrA0qHHtmH6AXUkKyY4ycLbunVGDnugKdgrsgTj+PyGQ8P+qMahjiHbjpe1naxzuzn8d5MhSKb24ZQLxSIzL5NUgEMt126kiVKOqnxL5tmaANKHb/KicMuZX4eG1y2rXybRwAqLBxPc2mtFAtFKePbmJ9zNsFMdmgaUBE8ASe/oovdu3ArTbj2RhDNNQLeLdRKWRhC4iCjCczPNMqv+Rv1UXHXtVpl9Ji2egDGSLtkJFlHx+TBPZKD6soiwb9BIKs3ZCkk9WGbUxo+Ap8hl7CKEv3PTOrLlUhtnrh+9KDaXlKs25NVdFmmjcIPXjoL9N6XtEAkkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azWinyu6YmcoBsCvz3/dUfSEvd+NSluhS4Wy+3XGAFE=;
 b=m7pAfrOWcVDvXA3hqltf6b57LLOacb1TPG3D9Wt5FNrNlU8UTBy1PKFEaBIPkfzWiyM7hZ7k5Fma5+LZjdwH0nbfL3OYTlJcpHe1TiOlGU8xmNsdP9QmTRtYoKfTeqtnXk8AhV6VC+Uvp0IqjBDf4SKynDWCIECjUbyiw6ZWa4u42EjNv5y7J9OY2/nZCKEjyJnZPcpadBiROHASEkKvFFDRhWIjf3EiWI9nJ/bmwQSSjBlYET28oqdBDVCxuhI9W3jNbWNNI1qMzBEDjPlmegbLMOKNkkFgGfTuWT8gv41SZcxUNpihDk5VMZDylur5F9bHbcGfj0WnPA1uAV87oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS4PPFE396822D5.namprd11.prod.outlook.com (2603:10b6:f:fc02::59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Tue, 10 Nov
 2026 10:48:25 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 10:48:25 +0000
Date: Tue, 10 Nov 2026 10:48:03 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v4 4/4] net/iavf: fix watchdog enable racing disable
Message-ID: <avL2Y-UktOuz-wQw@bricha3-mobl1.ger.corp.intel.com>
References: <20261105123237.12279-1-ciara.loftus@intel.com>
 <20261106094014.28784-1-ciara.loftus@intel.com>
 <20261106094014.28784-5-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261106094014.28784-5-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::9) To BY1PR11MB8080.namprd11.prod.outlook.com
 (2603:10b6:a03:528::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS4PPFE396822D5:EE_
X-MS-Office365-Filtering-Correlation-Id: 86303d38-65b2-4813-d374-08df3f181c12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|4143699003|261009223027099003|261026121527099003|11063799006|261021123027099003|56012099006|261026140227099003|261022105027099003|261021121427099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RGsmvdNlZ6L5lf/HV+PjVDY2FV3Zk/QYeBHjiOposmRwQcaDvVglNgiQ7ql29h5ZkMQ24P9qGNyBOOLJ1iIoWOJLqtwCDNd58lQDuZXUWcNj3liET0fTVodMHmKwCK/CzNFkq78w8697tgVnEC2ZVSZrA6ENQZuzVxckc79rxoNgLe6R53hqxjwGG+2TT1gmkQfPviJR0v6hs/0cG3uVxi/M8nRCnsCgHe6PS/H9Yyq9bqBUbdiZSFXYTQ3RJKUKShFxEhUDqCQz8W6FjSB3RuLmWN5FavjGzj7gXd+pfo56+sTGvuTZh4goC6FOxcV1wn7voaDYmHNvQZF/+qLRXTmoPhKmQK3CiJKD02QoDLYsU/j73UUuuLZal3TBu9JVxA+LDO5olt8c6iR4zCEObiEs4P2kBxn/xiQ4vXs7Uy+8EXX/fYbm2aBmSAgP5P8bZxogtgFvDkq1mQkF9B/xdMBiTfrozyaw+ZyhR/ltmm8LFNvPMAcArRekYdQEXB6Hpj7pj0vnP3c6AuF7dINLbB5HnRdPInKPfHSORpCw7l9P2hwNdN29el4OgOIr4ujJzhzliGE4RCEP8qpKt7G9JoJQwz+9PMakUrjI8LpXhnEPExzshzQUjVigmM1nNVffdQj9h4H5p0cLzVkq2JxasmxXEXLI+sYQWdzE2fniiqs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(261009223027099003)(261026121527099003)(11063799006)(261021123027099003)(56012099006)(261026140227099003)(261022105027099003)(261021121427099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AKdf5J1uB6/btBHFQAmuUdiDOOab3Dr3Xtx/bGaALAHI1ues4j6hoXpznd/x?=
 =?us-ascii?Q?f2cQO3vV0NySWM5qNrc2Gyankk2vZxa5QihtgQEPU2HdY61eY45IMLPETn5f?=
 =?us-ascii?Q?mtZD5W5Xk6amvx+3hijqZd13Udt7gEETiOlBopljtlYHaFdNFaiEkJ1GiokF?=
 =?us-ascii?Q?eR6+NfIhfEWXGBKMStrdgFmFgfqBYO4LEJwet7QMrvg1YW4AngR8z4g/8pdk?=
 =?us-ascii?Q?7V1KytDSV/p0gLFb0IT3dANZpB9u3ePiHlstuI8802kHYUbsGRjLqB/UbyFp?=
 =?us-ascii?Q?piPlqf7ZZgZlBzpy+yq7bLIWoPh8kVS2L9zoIFsCEx3rcFImNgRZBf5HyavP?=
 =?us-ascii?Q?37aIeCw74F2fJhdhebE6id5PjoCUNzCcp1zzEl9e716j86vrjAa4nyUuevQb?=
 =?us-ascii?Q?4W+OLF4uWDeF/eQte84bD7zWYyzJK+ErzZO0q8p3lH93b9RA8qZbn/rOciQY?=
 =?us-ascii?Q?7bDBU+aVWCl2dCb7QPV+NDcIYn5d/T35GqQEoZ15wKnq/ePio2u9Y2/IIxAq?=
 =?us-ascii?Q?xT8sk+VPfNKVdy7lzgzKRvghmWjv3i+L0jRxFe+eDlBD489EzsXCGHvIUQSn?=
 =?us-ascii?Q?sK8ek1IqlSbtnwwDPFLeEH9yHPpMLU5rL3hy3lDmsAUaZ6UBwZs3VPRgxPrq?=
 =?us-ascii?Q?AEft3u+5uU6wRG5HYImT8hSVnn+R7gmcpwvSfWQVxPVLvnqXFI8ZiT7sGuwc?=
 =?us-ascii?Q?qCM6ELLppbfUTt6YRGj7WEUWJ3H/Aucc0xJFJgMrYqaCklJSRdOowYakLf7i?=
 =?us-ascii?Q?spwdkGuo04sV5+JUjwkWKeqdT+sFyoJXmVsC/LM4QXV+tgbC5ocbfccPwPp5?=
 =?us-ascii?Q?nEHo7lVDUYKWPdr2RFBz9r/MmldvjH2LyDXS7s0cnc5VPHPrd5eHU4x8U9xR?=
 =?us-ascii?Q?oq7f1J1mXoIlB/h5J7kiMU6lrc5jdiwKgL0BNodB9PMyAwW8Lzsn92vEjAhS?=
 =?us-ascii?Q?NmfMkWDBatnDxUHj0Gy7UPR1+P/FWVY4YT6QExZ9jkJqaeZEK53uOryKu5Id?=
 =?us-ascii?Q?IfQ9AhnZGgTy8rFstFCLleE6ZlHoRy+YpJ3/YRVc4w5nvGh6cjHROT9M8T45?=
 =?us-ascii?Q?0uX6TddSb1eB3u5QC5xAox5urw//4wcNMljBpA0pqaiZ35yFFCJL7P0SQMvW?=
 =?us-ascii?Q?w4U0zOKI/J0ILDcLmEG9CveDy1Euq6atZ4dhs36CPrr1J/rK30ncDENuSieM?=
 =?us-ascii?Q?UWG8334JtBA38SL7x1IsLXbXvgEhhilanI71Z71ERvlyxvaOuOuEQn0Mj10h?=
 =?us-ascii?Q?x59kXcU86BIsjFiJq6u3gAM8rkO9opK2DDc7NKKiC1JbZIUW2szMi9BidSDT?=
 =?us-ascii?Q?tBZ2ezdC6StOU0KR9LqxVu4UZG7BbSSkeLx/Kbn1QhRecfDSr6azX879351t?=
 =?us-ascii?Q?2kb4QMyExJciuXVnGHuiFPOjrygiusVNmgRslIzfKy4PNMnRAjxnZoQzHRhu?=
 =?us-ascii?Q?CT5lc9MkhG7rwNGz4V74inSlFnMWoA5GMzCuE7+8gFz55CzV9DxAJ0WjHXMW?=
 =?us-ascii?Q?YnNNxatakMBNU7Xn2GfFgQ8OX2v4XPyHrTSj3niNtb/2mdqN+vvv6gSziA3u?=
 =?us-ascii?Q?mVbC44vvfAtHyGTlSmTR4oxdgrbYyGcu0rbarYp0wgrZ98FDsu2dQfv4+0Po?=
 =?us-ascii?Q?9O+aU64JkuConfKh/30rjT8NhEYOYd3rooupl2ovwSqtyyoGK5hSzCBeVr7z?=
 =?us-ascii?Q?fzomLkecFwyKyzAsldoiOLfaMNZlZcsKQu6cnv6pxed56ol08UAtZX4G3C7o?=
 =?us-ascii?Q?X1TwUbtm8zL9gKhKQOP1s7r9DmvhrAg=3D?=
X-Exchange-RoutingPolicyChecked: RaiNU2d0Wm9uJkH1PKiVn7owCBqYcrEwFY6G3vvStzac5slCj7KwKgjPc2ELjtcIZuGAFLD2D4lHRkt0jLE63TSGNvjCsrTb6vTwxfcof4ENp5+feSOY416fQgHIjusD8g20vho717bfmXM60KH+Zf6r8ZUlWD6Xo+nV9HZXtro0Fc0x1adoBBMv4i8KdLvwHxriMYY6mttGcFgcfvLOFK7lMhBBlmfz/oxSPh16ob6fR2+U/DZGlmXGOptYk8yJ+EO+g+RH1U5Sscv2lGEkxjrSu3vXZDfgHcOd6A278YLq7KDhwopIPT9/8UmbwxYfkXa9LyVn2s+f/lnb7dMXoA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 86303d38-65b2-4813-d374-08df3f181c12
X-MS-Exchange-CrossTenant-AuthSource: BY1PR11MB8080.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 10:48:25.8174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vd71GgFrWEueVvQBEB8OUXfABi653VsmsK7oxWxBSGbf1+RGD3JLqciMPdb5YfWheH2UjmEnzHtMa9rtqCBbcPftj2wGZ5vuwsXObASYFn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFE396822D5
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 09:40:12AM +0000, Ciara Loftus wrote:
> iavf_dev_watchdog_enable() runs on the interrupt thread from the link
> change and reset impending handlers, while iavf_dev_watchdog_disable()
> runs on a control thread from dev_stop and dev_close. Disable clears
> `watchdog_enabled` before cancelling the alarm. An enable landing in
> between sets the flag again and arms a new alarm, which the cancel then
> removes. The flag is left set with no alarm armed, so every later enable
> is a no-op and the watchdog is dead until the port is re-probed.
> 
> Serialise enable and disable with a spinlock held across the flag
> update and the alarm set or cancel.
> 
> Fixes: 4c9b1d2ff616 ("net/iavf: refactor watchdog")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/iavf/iavf.h        |  1 +
>  drivers/net/intel/iavf/iavf_ethdev.c | 37 +++++++++++++++++-----------
>  2 files changed, 23 insertions(+), 15 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
