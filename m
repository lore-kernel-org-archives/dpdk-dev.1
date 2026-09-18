Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A30C982D8
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 15:32:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F59043300;
	Fri, 18 Sep 2026 17:32:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id B3D3E4279C
 for <dev@dpdk.org>; Fri, 18 Sep 2026 17:32:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789745561; x=1821281561;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=iKlJPngmoYYLvq/RVkHEpp9LluzrYbRFBkcx+EfpI0g=;
 b=DySsxkzjCoNrSP07FcNqQndldGyG5xRwN94It2WNYaOsQ3+tXGwqUc+u
 lcfEpP1R5cDPLn84eoK+RYqvMN0/SVv39HVRj3iwlaKpVsigtTMTr4Zck
 cOs4vwuEtQU8GjTcehysokeSkWBanZ3aRfEJuwxqW70+3MafLFkun71QU
 UL2CQncJR/gagH6cY99YIhFR+haShkC3co9aEsyNkabJKsthpnStdkl+L
 sJpViiZI49ACj7/uLWSBePNDCms1je0ZcHYkKnhV/R60onvJ6+Az0Ju4j
 Kb0zQNr0kdjrlYuXH4o+swn/8CrqhcAu9XF6uv2zEq4h6LzTCbaKMDVg/ w==;
X-CSE-ConnectionGUID: 0K2e/J+xR+mI0OoXMBn6jQ==
X-CSE-MsgGUID: gGarc6vpTWaQDuoIUhffkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="115792131"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="115792131"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 08:32:40 -0700
X-CSE-ConnectionGUID: 6KuN21Y0SMajnhQdvOQLzw==
X-CSE-MsgGUID: KcT+PT/+SYO3z5DPjyqziQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="2660444"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 08:32:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 08:32:39 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 08:32:39 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 08:32:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvVQIFAyOQ2xcFnQnTrdcrK4AwE6m5aIQtK3jnXSwJvCfR7wgm9CUnr1N5ALHdMvVLeLkI4Ec1Ruzs1IKSQOEHYQNmH/VmeEX+EU7D1dE5WvdgPRdIZbGW1YSHe/uxlujCVWvH39++wg94di+qxPAtuYfva9FsVoLr2vuXKd5EAz8XYI9r+Ft0rrH8Qa/2912dZU2WYaYHMktgZskOMZS+ckBSqo6rH2IZNCAVqXWIsfPVq/jwUicYZz95Fx0e73p2ZiANMHIVD+fCh//eIYUfcvd2N09N215aVw+RLE5oXFC6fuq9Em++ffQfZKaJrYc9Zqb2vk+E+NvFlmoZMAlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGnpOT/DK05QO0x4T9+EOQyutIKwC4/RTtqjH2bjtQY=;
 b=DqXl+BjURR0pn1xbLOsJJMG1CRDi8Z88K+0eK0o9CF4h9XSvY0NTdTIWcCcOq/HXwEwk2EmIvQxn+nHtGcvSxkWa56HB6CCqoHkbOhLBnFssByQz113FZ6dqPWw7aPxWWCfvy6/Wxcd7E+AbUPyDsvWYF1whR3Tm0hVaYa8HrCSuVFlNBkwkSz8udi4ccF333Gi7O5rTahiY5vqDQXsK5tjqoCKCCPRfuiU1Q4ufrROxxhiDXF5RA/7yOCV+dKR8UuVqZOZ+BpwsxelFYJHV4lW+EJ4g4mCfIAHqWkI+tkegwHHsP4kNaqf+jVplH4h6ErlXdCIou3ifp2U77a6ImA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SN7PR11MB8041.namprd11.prod.outlook.com (2603:10b6:806:2ec::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 15:32:36 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 15:32:36 +0000
Date: Fri, 18 Sep 2026 16:32:32 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH v2 8/9] ci: make ABI reference generation faster
Message-ID: <aq1ZkPhvlVCRH-B8@bricha3-mobl1.ger.corp.intel.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260723125559.3087579-1-david.marchand@redhat.com>
 <20260723125559.3087579-9-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260723125559.3087579-9-david.marchand@redhat.com>
X-ClientProxiedBy: DU6P191CA0056.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::17) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SN7PR11MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b1b3dd4-9f0f-4ba5-fbd3-08df159a10f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IsXRVbD4NlI1bTggn6w++7Jp9n238pOyIcFGxn08S3I9rPfdO3wkQ2PsZQUIQ0YpZJSHnDqDfgOOzlbynH6G4m0bJbyfuO7+DPf4b0n+igopspNHkSQj3Nt93jXlIkKPCMd10PhyY2ss1a6QXKsxyHYxwMMLTfx4PLND/0zZTbeTN0I2jlhu89zull7T835FbFv3dXtzf0qOoM6jyZxk79ntAxXPA9ntZrUqEqOropwfxye0qeyoxhKnXOj/a6gySZoHxMkkUuusBqxhnE4snR5rVbcWjk4gIotSUCpEA86671pSp3aayFuVB3hW45mPldfreVjmTIJIKnSe1wrCB6dHny/AuJ664bhoTnTY6GSikal2HMzCeUjH28qZnoq4SWIqLuDJFUMiG08CmAy50jB7zjSxoV2lZJXuVz281BnzhpTKlFHEqjeNKkU3sABmejaydw0HKa+XdlDfUSQYkbEj+2g4jrI8POQx+teMZgP2nJAfOBgpPaOCJV3aIdgCj2J7DbfdxQyujVE1646lY+T6OZt3vl+N80sekyTF2ZQsrtcunbLKQ8vomeGRSxmQWWS15PzU1yqXjBkjTawNoiAboE5i7yfD9e0TeVLr9bMKZK7+ksFFhXIcBxe6VTSuda3yeCXjs9bh1CrsrGGx08p8qRqaDt9c31g2BwZvJVE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YZlgUClDPAquwrmjVUVEhB0N4UR+VB818g5ovp8KFOMAZDzmMRGPgyvC5V+T?=
 =?us-ascii?Q?OVZ3Wzc1UK1dGLIjJ2BwvYrzrYgU0m/tb64QW7VAPuRyLE2m5CH/oEuPG+S0?=
 =?us-ascii?Q?K2LWF0cdN+bQBBs59lZoJY9yv2/UwF5PVFOlswNferb6zZ6fsw5b43KsDgYh?=
 =?us-ascii?Q?xr+QcyCCRSZ0kUPteM0PprC1RW9/rQxSzAvwPiqwTdLLDs2ylMqx7TeZPBpE?=
 =?us-ascii?Q?2lLdfq9rB3mO0x9dWpO5P2a7LA2W2ZwLG/oXQxjkOS/Rhbsd8BD2+DjYuPiW?=
 =?us-ascii?Q?hccYhRJRUW7M7KtCN+F4DuLDsK9zD8cf3s9oSrz+FcEF6Ls61IX5eom7t5E9?=
 =?us-ascii?Q?4rU9sYEIrEjP4xu2qyphHi9QeSNNPxlMG0N0BvmihyL+dmBAAaT9Mxu6E8jm?=
 =?us-ascii?Q?nExfdGiBJUN4cdT79Q+LEcGqA/WLVZ9++HID3aWrc8dOa+x/7nH1UVsTCFTE?=
 =?us-ascii?Q?829ifRSRJQH47y4y0GE1BlCeU8UdBgOPdYuN6n5pcHf0RWnaWxF8ZUPI0SXx?=
 =?us-ascii?Q?fmO/iCgaB9QQMMMs5p+fDMYkT0Qj4BfUoeSY+cWQXVXYI64IvDAMIc++zbAY?=
 =?us-ascii?Q?Bdk8KE+O7v4TWAfmI21ZJzx0eZXp0peT005lW9lO9hY2HNA/xbq9on8mtVXO?=
 =?us-ascii?Q?lxEhk+RZsECl/ZW8nnasr/yVdrMQ1h3ERuFA+Qxse3Oi7Q5QZaXYYjuY3l6j?=
 =?us-ascii?Q?aWwEKWaF4HXg8JctyYDzGuEDeTQcHT4QWtHOUUOsYh8JRMABTDL8kSGrKc4W?=
 =?us-ascii?Q?tB+de45YPGGTHgO74S1HlheqXXMZcyqO2XCTBVkzvP5uaeciddNpKUcwwJIP?=
 =?us-ascii?Q?0ys1PMl5SRGd09uOu7FGwhYbg/FODiSuOtSE2QdNn72ABHEEE26DHmha3MQr?=
 =?us-ascii?Q?qCvwOUgES+ch4LJmhCWGutZnJEWiiqhgmN3rXCs6G14aFNvdLcjl1Hy0kYa4?=
 =?us-ascii?Q?7pjU0v2Cbd548NXzNiUCzG6+tGBkCh8WYDGDEML0h2XvB13AtaFd4cEo0/Uu?=
 =?us-ascii?Q?LLk0+2+ol3ebZYo+hgGyTjSFwLs/PaXb5Atus2cCJuaflFoeZG8v5M9jEGTK?=
 =?us-ascii?Q?uOdLPa+9grN8dhBQ4THNW5EsJs4kSK6Uwr69uMNQ7W9weyy3Q17Cn7DOD8hL?=
 =?us-ascii?Q?llA/1wcQXDnOFY/IY0yq5wLLCBf4+qmJz/fX4niZnkWW6AdISMasnttf9Ql6?=
 =?us-ascii?Q?AXdeNt6lBt8ecsOXc5pLp70Zg1dNn9xhSGwLko6G0NDaaLkB9O5KxYeIy74e?=
 =?us-ascii?Q?YOCW/6Sjhp0dlKz5Ci1Ti9FP+3N9wmf01rivsvy4KYyGBw/tnDF7D7Q8ZQUD?=
 =?us-ascii?Q?SxXes55dS7rQM07xfSwryJr48m2xVFoo+ej+H1yYjJOb7uMWANI3Iqi20ejt?=
 =?us-ascii?Q?MPGKFfxcNXZ9uV9QJ88fK8KiHREKVC2NLMd241D1eXE6yfy/as6bwAkIDOVy?=
 =?us-ascii?Q?A19dshD8UVLP+UsQtTvniBwEIwNSeJlLZONZMCDwMsHIi0W0BiAVNpnGhJuG?=
 =?us-ascii?Q?5fVcMthPZha1OQyCtz0Ac84ohEsQOmjOz4PCygFRBWNXxRwg2DS4+4x0iX9O?=
 =?us-ascii?Q?Fq9vOAcAUhWvInz+ax8Gsjahd2mA2FQj+1s50Q6v9LDLKDo6TvRzwjiw7OEg?=
 =?us-ascii?Q?eZPy0d4acVWs5vnBdpBYk0bYNf5cOJZUXP9ATYesqQ0nGZMJozolKlEjieTg?=
 =?us-ascii?Q?NYMd/C9ffhj6M5nyqwClXVK4a1m3QN4gweYbMXFJ+2dSwo2T5QmAmuvM1KJZ?=
 =?us-ascii?Q?GGIX+3z20Cf6oxorIA9w4eHo8ICuR7c=3D?=
X-Exchange-RoutingPolicyChecked: 5PHTg4CjbeJDjIznpIqq5LcKuSnH3ii6TAsH5kIFSqxwx2oLizN6CZ4Asw0VTKEybN79k1PGehge8I7RPyQdoLTgDFnAA8bHzoCcsufIkEOqJfsxBcTGP7gVTCuKCKWS24RWgCX7COeCyhr4de4cswnVn0uEu6rHLXOoq58ZkG/Awt7AHLI/xKytdMoK/CiCXXeW63t7A7dJmcm3uiAandMTOovLRA7HDpxzq5gl1HoW0QSqjZyYBhhNFKJ6UqL8Wx0P2XnaqFbA0skpUm1XwrsN66ALOJD4UMSirZT0VOhzY0PZyZ/10i39WtKRSRfUNdAJQcjT3bz8RGdBAqLGtA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1b3dd4-9f0f-4ba5-fbd3-08df159a10f2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 15:32:36.5036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nuvFwkdspiGjBvJJmyAwvGNAPfr9YqsmIXsuJJR6BKAv1Dx9EPUHDIjpburUoJsBzSeZKFjdobdjtnhXft2w+pxuuNerPEff2pD2F2bi6XM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8041
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

On Thu, Jul 23, 2026 at 02:55:57PM +0200, David Marchand wrote:
> Regenerating ABI is not something we do often, but when working on ABI
> topics, a lot of time may be wasted on waiting for the reference being
> generated.
> 
> We only care about shared libraries, avoid building final applications
> or examples.
> And we don't need to double check headers in the ABI reference.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  .ci/linux-build.sh            | 11 ++++++++++-
>  devtools/test-meson-builds.sh |  5 ++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
> index e0b914a142..a5e602ed83 100755
> --- a/.ci/linux-build.sh
> +++ b/.ci/linux-build.sh
> @@ -201,9 +201,18 @@ if [ "$ABI_CHECKS" = "true" ]; then
>      fi
>  
>      if [ ! -d reference ]; then
> +        REF_OPTS="$OPTS"
> +        # We only care about the drivers and libs, disable developer checks and
> +        # don't try to link apps.
> +        REF_OPTS="$REF_OPTS -Dcheck_includes=false"
> +        REF_OPTS="$REF_OPTS -Ddeveloper_mode=disabled"
> +        REF_OPTS="$REF_OPTS -Ddisable_apps=*"
> +        REF_OPTS="$REF_OPTS -Denable_docs=false"
> +        REF_OPTS="$REF_OPTS -Dexamples="
> +        REF_OPTS="$REF_OPTS -Dtests=false"

Minor nit, but this shouldn't be necessary, as it will now be covered under
the disable_apps wildcard AFAIK.

A number of these are already the default, but I suppose explicitly stating
them is harmless (as is setting tests=false).

>          refsrcdir=$(readlink -f $(pwd)/../dpdk-$REF_GIT_TAG)
>          git clone --single-branch -b "$REF_GIT_TAG" $REF_GIT_REPO $refsrcdir
> -        meson setup $OPTS -Dexamples= $refsrcdir $refsrcdir/build
> +        meson setup $REF_OPTS $refsrcdir $refsrcdir/build
>          ninja -C $refsrcdir/build
>          DESTDIR=$(pwd)/reference meson install -C $refsrcdir/build
>          find reference/usr/local -name '*.a' -delete
> diff --git a/devtools/test-meson-builds.sh b/devtools/test-meson-builds.sh
> index 11e4be3f88..8ca7091b47 100755
> --- a/devtools/test-meson-builds.sh
> +++ b/devtools/test-meson-builds.sh
> @@ -206,8 +206,11 @@ build () # <directory> <target cc | cross file> <ABI check> [meson options]
>  			fi
>  
>  			rm -rf $abirefdir/build
> +			# We only care about the drivers and libs, disable
> +			# developer checks and don't try to link apps.
>  			config $abirefdir/src $abirefdir/build ABI $cross \
> -				-Dexamples= $*
> +				$* -Dcheck_includes=false -Ddeveloper_mode=disabled \
> +				-Ddisable_apps=* -Dexamples= -Dtests=false
>  			compile $abirefdir/build
>  			install_target $abirefdir/build $abirefdir/$targetdir
>  

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

