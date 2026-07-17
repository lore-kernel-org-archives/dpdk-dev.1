Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A20C44516
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:37:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B67D40E1C;
	Fri, 17 Jul 2026 11:37:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id DC16B40E0B
 for <dev@dpdk.org>; Fri, 17 Jul 2026 11:37:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784281041; x=1815817041;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=CrVwp+dMpvf1a17Eg3s+K5GuJmbGWwdE56SiU9Ex0Kc=;
 b=REh8C16I/J4/+L/NhU9XvD4Ihkpdqzgst9MbG5aQOEP7TMapdIpXABfk
 h5GJpDdWkpiVQOEnwxCKyODQK9hnYYR26KNKsqFrSbK/hLheJeR44rXRT
 Hn2H4ZvLZbdHt/T9b4OZkNgwU+CuoSnvYHm4yQO4jcvhBt6VDxV5+KrDl
 6CC3sMOGDqXY9cZ0MuiywXOizOCO6rGpmk+IJjrdD1Qint2BW+Ty3kTMO
 LusOw4W3pHXB+QTU7sgxZlpZ0u+Km4wfC25xD1WZsSQOWMu2r01+QSGWH
 WXzMboYyurNAb+D+uASlYsyWMtQf5OZt1//zzJmkWcLfL7Fg4FOeZQniL g==;
X-CSE-ConnectionGUID: MIS20KafQB2Etivj+ll/3A==
X-CSE-MsgGUID: JKeJjafoQoiv19wDpdNvOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84071543"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="84071543"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 02:37:20 -0700
X-CSE-ConnectionGUID: DDxXJ0zYSxCSpOEnS7tGLw==
X-CSE-MsgGUID: KOxwN7vXQ9SNeiJDYzDdNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="261027502"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 02:37:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 02:37:19 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 02:37:19 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 02:37:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONwwRgEvUFQ1ovxkoaR12zbefZvfFKqylAUqfpydJChW525lqtaMV3feChb++7xAEupIEjs4LGcuhGuZoBtgcfeZwWLaKjNIodEMAES9EKROdk7mueBfRyKBTM8KpKylECuy9+xRU8mYs7/OKbc9GxWt3N47WtHz5BETU2uKz06wjgI7+C1uCYW3rnmftYQ1zv1laadWDYV1vDEriyfYt0lgisgpZMDOH7EGt8jBEobUiM2B9RF73pRlud4tV14Q4tfrA79izIcFtkn2KPhjxBxm3fmZwrpjU8xudmF8xKyskphen2juBGCPZPXJ97oRC6YXWEeDcCukaVVL38PpVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1auBwPCa0LlpMz+WZ7PFIDdW35clCZUzVc1pg3TY9B8=;
 b=mDdaHZG0tJbwSJ0I8CJATHZdzVLhIcHEN3SEwWrXqe1A50JLw5qOY9nSuXAFMSl4itmyEAFf95fK/F1hDzxiOno9TPAMCabaHswAYxeui9tVlCFWC9Gq76aCnPiEVX8CAeKp5zAD9TCDqTvmDLriF36Czwnd6IH7MHO8q1p8GG7yXki9A40J+cuYHmhN3FhdY7CJjAaoIKcFvzYLMEkH1KNq7KOdotuullmpzbyqtbw9F0kokCMQZ/5JH7jK1c1VAuNGhLQ+j2k0xzTHtWv24NxXfeP09A5nJQm7DvQM/nmRfNqZACfVFOSvF6v2il97auUWl/JZPg+xMT5jqowGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by CO1PR11MB5025.namprd11.prod.outlook.com (2603:10b6:303:9e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:37:12 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 09:37:11 +0000
Date: Fri, 17 Jul 2026 10:37:07 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Robin Jarry <rjarry@redhat.com>, Chengwen Feng
 <fengchengwen@huawei.com>
Subject: Re: [PATCH] usertools/telemetry: load aliases from config directory
Message-ID: <aln3w5hRyGXhJas1@bricha3-mobl1.ger.corp.intel.com>
References: <20260717091603.1492650-1-thomas@monjalon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260717091603.1492650-1-thomas@monjalon.net>
X-ClientProxiedBy: DU2PR04CA0324.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::29) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|CO1PR11MB5025:EE_
X-MS-Office365-Filtering-Correlation-Id: 1353456c-af3a-4da4-6ae5-08dee3e6fa6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|10067099003|22082099003|18002099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: Zblul5w4EoV53GMnty1bJGnYq5QM2vf/2Ev3nWuqa3KAuu4SIwZe2jIjdoXrteFsnI8beIgmpqqTs64D1DYiZ4vbSv+nAHw3pDLGj0z6Rwww4NDe8AFwCiJgTSbsPfFlue+fXHWoIq/WiUKHORl0RMrp/DDqqxLLxbafVjr4b+UHOfMILQDyiCoZ82lvotc4T8NyasWT5J3OensmotpBjsosu6oqsrxyUFiZ6sDRApPj2wnDgP2hKAJK0MAT3/Jh+n+fCI28tpELAA+nvWlcBZ8eurUJDZBMybCZCA1UlpDAWP4vUOom9lxSHpGLkYX9uwBAbrESJUsL5pQeN+ZFNV3T+6JqQf3dzm3lIG9QB/s5XCI3ZAcewTrKOnmfN3Yb7f6cekTc29/Vu+6BIclYbnP/oJsbQ+6RG3Jp21EJkA3PwlX3jyQwq/efTahxV0hztIpxu+gARBzzK3aEVznDVtOz1bD9d2eWX9yVE4vb8MI06zTz58/dpa1fblTcnDhJ+UoAqGF3hnznbGOAiZnQ/PZPj7Uu+ylxTUuQzT3VAATpLIZexXIAfw9M0SjnX2H7p+j8I8QVf6V/4xod3/CcoQPJZbv6jowX5mK8lS8gwFgRP1GJYpeqLxuCs1hakyZA1cmH+5tfkN1kS602GxE5yrN3he58SKNbL6lsr8vfN5E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HTDyrvOphs0hXZPuyo3CZnQloY3Grwof4d+3PGhXiqgeHjdYIwxkaEoIv8YH?=
 =?us-ascii?Q?nkhC/w8TuZTgflBx01Bf6aytpU9+dsAHh6OxbhqT20ZDCBhUbs/MBMfz1xKi?=
 =?us-ascii?Q?Ctmo57baIurXsBzse8FUs3HpWEhCAGdb+zAhuYkJ89JiEvVQIdloXS8lZlm7?=
 =?us-ascii?Q?2QlTeusux/Pc+aaYtYvVUokect6162HBQHKBS27lB3GdGvOExVKwI/z4NRVK?=
 =?us-ascii?Q?ZUmjH2X3q7zIAWS2SDkL270bqVxscidFfNRhWHoJz3GZ1MW4EaA1Dpcd7Gpm?=
 =?us-ascii?Q?lCXV2/QBhmPMVyDrb3tbov9ZZR/AOeJKrhvFv5nhmNncWCiMJ3F+ZhLxkrYJ?=
 =?us-ascii?Q?QlNwiPqEnIs8cqUaWrGUYEgQkOuX+oKdmWspSso8bw5cv9M8OMSZWITQxS+C?=
 =?us-ascii?Q?9Q7i3S5dui74DQGsHwePuAnSbWc/FBUgBrWOVT0q3I9EtaLfdgO/fKWyy3oK?=
 =?us-ascii?Q?0lrTyaoCK9Osvekkbtw5OzCzYSAFBg8cKq4rFeVukmFfIAGnpSj5KYueOxeE?=
 =?us-ascii?Q?4wbDvCIMTs9/Faq4CBhxLFp3FMBMNyYf3xFeZj70fxvUjTu3kOD6bYYpte8x?=
 =?us-ascii?Q?+Rgw+HO9l3gS2jeDzNVN7nFNOZqgDEeM0cnviY/l9Uk/buz1CqCNCtFo9u0w?=
 =?us-ascii?Q?3ffXvqx1SZbAle8nm8enoegi3VT+0i1sF6Y0YsaJhhkdIdysur7MD5gOFF/V?=
 =?us-ascii?Q?Gy3czE/ZDDIKEwtRqfO44cLljWmBYZi4L1F1CHeP+F1PbkcUoPzOOb9RWjGR?=
 =?us-ascii?Q?3R6oefrLCszRT4YpBP4waNKc/r1yYE8B6tAEaiJLXZLDK5iVC15AoiBT9zLu?=
 =?us-ascii?Q?32nBeOz+nkzrubSFNCT2yOrjcvpoNe1vVbNHcYzAvOp2MkwgEIBRySChL0Ps?=
 =?us-ascii?Q?izKdlPIiMjr9wG7oVibfUPjCWXphjsS2HqgWMpP2p20XshKQZb+QZu+L0cN4?=
 =?us-ascii?Q?aD79HveSYS8q/mRfDKWZmPG5MoSA8vsXkRm+slklR5J6eAU3A5omJKz4anAG?=
 =?us-ascii?Q?jcf4njvzCxLL5RIbUtd1/bFfP+9oji2s3rMNIhyhgyjASCM/YHeDb4XBFC/c?=
 =?us-ascii?Q?4hznIr4uFCGgwHIIc/q0VEuGINdGDw04izL0Hg4VQGqxbCt+SlFKV4lHkVKn?=
 =?us-ascii?Q?sK5P8u64tTfFIXj43qyOBUvYh+jyE5NM0/EiOEODKnK69++p3+Y7UhdsqFT1?=
 =?us-ascii?Q?T948+aGhD1A3lkv1O/PeqoaB8QCLNFb8iHeUVDi9CPvyoEInppdbpb/uxNbP?=
 =?us-ascii?Q?GiDxsM/xt8LJTNrm1AEmyFTkxMwpk7RI59ukni0XlENe4+I/aBiUgFJKQhmv?=
 =?us-ascii?Q?mqibBgwiXWM7rAwkb0TvSFkZSaTDzn+M5AQT5tsC+wdRKI/mPuaI5OwGmbh7?=
 =?us-ascii?Q?WR4rkYlB7JbNhLYlS4nCQw+V3awxSE6uOShvVVPyUhO1yIHfNAdplAKSHO5S?=
 =?us-ascii?Q?pUm88Xi32kLcy3/pTDNmcmo+N4xO3L3H7rv/tmd7q7wGfNwaQDkrVClNg2kq?=
 =?us-ascii?Q?EPj7/jtkU4omQmjsUYSUWn2Rw714HnsxFObFmcWYs092cCMcCNAQltOAslCx?=
 =?us-ascii?Q?kmkzmSqON2Ji3bVUKl9vdtEtaw6xfJvgCfwNJ3ijG2cEVddhr4OdL+x/0r3V?=
 =?us-ascii?Q?a/du0wBrufaa35tpgH7sUlFIo6kd6Rc1V73UpVeqDofzsfShOLXcTsPcCwjp?=
 =?us-ascii?Q?shed9Re3CRgXj7lIeRnSqr01GW2Xm2TXnuOpp8BcANML0oM2sOsrV48vDKZQ?=
 =?us-ascii?Q?/Eb/JV1lT+bdBF6g/ec8CXLOE7amo2c=3D?=
X-Exchange-RoutingPolicyChecked: oIZXI4hXoL8Uol7DTf+cVNSLZWnV7h4YsDjeADauxFGIrmATlqZAVOXDUKVm7TEpHpuDSwraT/08xxdyFAX+odDWnDbzGUXOyKBbnI7dTnAhNX9rL/1O1nNzKtnXuy0kMDmONsIzgb1zr9g68WHrCLjILHidc1/ZPuS8hrWF0BNcmr/znZHGIpMuXSj9s1La1AI4NLtZhuZ42/f72OIXT/UkItKaWhLntAPNZ6SWqZpERZxN2x94ZTSDOiRf0X8f05gmSiW5YR6YKMo3Lal9NrScnUytoKECTT2T+3cOy8HyvOHbt/QB0KfEAYlnnJDgw5vxHvz4fslx/F2BFfs4WA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1353456c-af3a-4da4-6ae5-08dee3e6fa6b
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:37:11.8232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfDBGInQVBmB/Tg7TVFXn9G285SBd+9mcCVOiLqSqK7nWGB4OtOqjm8mDuKan7/lm9My9ld0bvatLjQhXytw7hLB29knOpcjvF7QHgM7rs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5025
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

On Fri, Jul 17, 2026 at 11:16:03AM +0200, Thomas Monjalon wrote:
> The default path of the telemetry alias file
> was at the top level of the home directory.
> 
> Load aliases from the DPDK configuration directory instead,
> using $XDG_CONFIG_HOME/dpdk/telemetry_aliases
> or $HOME/.config/dpdk/telemetry_aliases.
> 
> Keep --alias-file for users who want to provide an explicit path.
> 
> Fixes: 410d498412e4 ("usertools/telemetry: support aliases for long commands")
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Tested without moving my existing alias file - no aliases loaded. Then
tested after moving to .config/dpdk/ and it worked fine.

Doc changes LGTM too.

Tested-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> ---
>  doc/guides/howto/telemetry.rst |  6 ++++--
>  usertools/dpdk-telemetry.py    | 23 +++++++++++++++++------
>  2 files changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/doc/guides/howto/telemetry.rst b/doc/guides/howto/telemetry.rst
> index b3f25c1113..fdaede1987 100644
> --- a/doc/guides/howto/telemetry.rst
> +++ b/doc/guides/howto/telemetry.rst
> @@ -154,9 +154,11 @@ and query information using the telemetry client python script.
>  
>       The telemetry script can load aliases at startup from::
>  
> -        $HOME/.dpdk_telemetry_aliases
> +        $XDG_CONFIG_HOME/dpdk/telemetry_aliases
> +
> +     If ``XDG_CONFIG_HOME`` is not set, ``$HOME/.config/dpdk/telemetry_aliases`` is used.
> +     A custom path can also be provided via the ``--alias-file`` script flag.
>  
> -     or from a custom path provided via the ``--alias-file`` script flag.
>       Each alias entry must be in ``alias=command`` format.
>       Empty lines and lines starting with ``#`` are ignored.
>  
> diff --git a/usertools/dpdk-telemetry.py b/usertools/dpdk-telemetry.py
> index 20627b596b..e575f269cb 100755
> --- a/usertools/dpdk-telemetry.py
> +++ b/usertools/dpdk-telemetry.py
> @@ -22,7 +22,7 @@
>  DEFAULT_PREFIX = "rte"
>  CMDS = []
>  ALIASES = {}
> -ALIAS_FILE = ".dpdk_telemetry_aliases"
> +ALIAS_FILE = "telemetry_aliases"
>  MAX_ALIAS_EXPANSIONS = 32
>  
>  BASIC_HELP_TEXT = """Basic usage:
> @@ -46,19 +46,30 @@
>  """
>  
>  
> +def get_default_alias_path():
> +    config_home = os.environ.get("XDG_CONFIG_HOME")
> +    if config_home:
> +        return os.path.join(config_home, "dpdk", ALIAS_FILE)
> +
> +    home = os.environ.get("HOME")
> +    if not home:
> +        return None
> +
> +    return os.path.join(home, ".config", "dpdk", ALIAS_FILE)
> +
> +
>  def load_aliases(alias_path=None):
> -    """Load aliases from $HOME/.dpdk_telemetry_aliases or a custom path if provided"""
> +    """Load aliases from the config directory or a custom path if provided"""
>      aliases = {}
>      if alias_path and not os.path.isfile(alias_path):
>          print("Warning: alias file {} not found, skipping".format(alias_path), file=sys.stderr)
>          return aliases
>  
>      if not alias_path:
> -        home = os.environ.get("HOME")
> -        if not home:
> +        alias_path = get_default_alias_path()
> +        if not alias_path:
>              return aliases
>  
> -        alias_path = os.path.join(home, ALIAS_FILE)
>          if not os.path.isfile(alias_path):
>              return aliases
>  
> @@ -434,7 +445,7 @@ def readline_complete(text, state):
>  )
>  parser.add_argument(
>      "--alias-file",
> -    help=f"Provide a custom alias file instead of $HOME/{ALIAS_FILE}",
> +    help="Provide a custom alias file instead of the default config path",
>  )
>  parser.add_argument(
>      "-i", "--instance", default="0", type=int, help="Provide instance number for DPDK application"
> -- 
> 2.54.0
> 
