Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53575C982D8
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 15:42:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27D004279C;
	Fri, 18 Sep 2026 17:42:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 59F6940285
 for <dev@dpdk.org>; Fri, 18 Sep 2026 17:42:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789746125; x=1821282125;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WcBD6S5CMAa/dxDENGD2M0qRB34WfaROYIBdXcoxGTA=;
 b=nhfgSbXPjU30t4GjHI+8rSetIN+o4V/RnMfL30Y0sw5Z9SYeWrng+ami
 5X98fzXwv/wFQWc1qKTWwquaGbrngZduuEnhlrMpWbAfzmRZCGcmPZ0KC
 gcu6v/ZAIc6dP23iQABpmeUpG3WnUjpUq9ppfJ6q8jbBBm+1LOn3lWefy
 E1SJ5i2WE9KnCeBPLcSpSW3gBNa8QaYL+M6upD6LtQTXN6Df0Un3+RIDb
 fPL3yBU5OjBnpZ5deeyW4G7XUiNVUz+bqm7r6+uLVQOQhmUcitmXolN8W
 lqjcv4PPDBG5c7sKLWDJXh3g6Hgm4YIRCkbKs2xMjw53aQJGTuwAoDcZy Q==;
X-CSE-ConnectionGUID: wMDnjMtFQY2bOfoDBiNfPg==
X-CSE-MsgGUID: f/0i06wURKi9bMFUcMeSCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="77824633"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="77824633"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 08:42:04 -0700
X-CSE-ConnectionGUID: EUb1x3A5TcuA1/rIIoSv/w==
X-CSE-MsgGUID: +yXTdIRfQJSG2Caw0/afKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="271128519"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 08:42:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 08:42:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 08:42:03 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.18) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 08:42:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNilFKg6X97OJZ3tAFgYcvmwPOCWz0IK0/utdO1cxwIqv0vwBwm4Uw/WLc38R0fy+FSuGkejTxQnuZOybJQaFeR28xSOzzDMBjk9s6Zf67gKHPEJSZrXfxTs/aH/f8BTlOKj+fch9sjbUfV5B9x+02Um5TXcMHyEjDZEbCVBMQ6mWTlyeHyF5iARa8dG+IJYhjtB7e9pds57zgVYNqqH+jHFZR0cRLdF0+9DuFv+jg1xkvUEhYNawRUhGLpkiGLV3BlZnfoCmOUH2BNLgCdE6wBkJvjKE8MnxsKIaAZe6iJdeX0Qq4EjXvXCTNtxqQYfYJ2kBD51mKh5Ti4XEnylGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qT8GzUzEwGzO5dw2o75qXY4vcywNfoeGukzJHbs6z4=;
 b=sm0XFCB/tTI2FNfSGGVITVprmyovOH+Z+WH8KRKq/HNVxn69hAiSbDjweDLeCP85O5bKAmhlZJg78uMugOMvIQ0VkeHqhbwdZdp4HhUA+35KDXJ3YvJM6k/s8bjtr3ki+otae7lZVST4W1TH4u8EJi2AuOPc868AEB2j+SjtKGObSw6F2vas6AxiGysNskINV4Q9GCbxjMYFqSbD/2l0aToPiiynssFwZTMnaVQIv3Wfrok3b9ffOWRHyshOMSbKAyBblBqWGjIOZwlNkQoGh+EpcCMWNzcuSkPtiwE1n8S9rH0b9Ag/s+qU9Ijdy5Hk2OMJVxvI+uFww20ASasHxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SA0PR11MB4559.namprd11.prod.outlook.com (2603:10b6:806:9a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 15:42:00 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 15:41:58 +0000
Date: Fri, 18 Sep 2026 16:41:53 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH v2 9/9] ci: run reference binaries against current ABI
Message-ID: <aq1bwV3yNlXUZeHT@bricha3-mobl1.ger.corp.intel.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260723125559.3087579-1-david.marchand@redhat.com>
 <20260723125559.3087579-10-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260723125559.3087579-10-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0110.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::7) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SA0PR11MB4559:EE_
X-MS-Office365-Filtering-Correlation-Id: a5642be3-22fa-4e3a-e8f1-08df159b5ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|10067099003|5023799004|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XCnB69hCG+nJGtxqYbd1NKi+GSBSPEgmcwoJkqpVHBzs+u7QX0wzwprAb1jW7QFKYiuuI8FM43F6MvV5FWwmB4whLtYamTRktpC+eVrQTLe3Y5kbFvoVEea/DA4YCP5ppockhnLp2v54sJ7R8TajgOwcrlktQ3JjsGDVgoOM2UicPDAWQqbSVxoaZ1vgKJ7skXXo5luE/ZblWVBUzkUBg9Mahdq4H2wnqqzyiK3/8Dh14G8dxeYxFEQ08PW5Aot9hBbS5HRX8jtsifeBM1/raDcwKnPVx9ZMBbW8sYm0ZusOE5QZDIs+0ZVcBe+lvzDpJscuKVHz1OU5B7TOJ9qb2kODvTYKfiAxtJTe1DcEXR6mQ29A3NdCZWyABssLH0G+SjulOiqkXE66zahpvUV9MxorNC1WcLGYjvkfvkOztkg1zuJevD8SA4REafuSi4y+Be9rHRGqUp60iGjFhfh2cpFWmCON8TfB2T2kHmIOxGGikej2aweqDCdcbaZ/b86ZId+jm7jYn3agKeRlwSx6xwkVjfsMDcvBY4OXAwcD/HWFgX6XVSSURkcQuUVu9bC8CQTQnBicltyGo+UVk9crz/iS4zPaKkdjuPC0rbeElvwkUdM20csyidmBDJhcTmTCadWt6Avk2K02JmJxXPPBKb7WU3lPFhGtDKqyrAlu5oU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(5023799004)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3OzN5eDyNPjeTZ2Qb9PQydZXBKWNRYrKaU+1XhdHq5X+K983Gn+vDk1xuhDI?=
 =?us-ascii?Q?KLuB/kiLh35SZVfXIzVD3K9WDxHTwm0f4uZZ/IPIbH3vTVSq2iy3RmWQ5iSh?=
 =?us-ascii?Q?Yk0fZtXz0Al3bTjfn/0o1sLj+rjcgo85/tOTck4N9/HHK4fImV0Icns5rIpB?=
 =?us-ascii?Q?Z5GwO119JaT9JfxceLZZv/hz6PgS58J3ZUIqtQgk9QC6ssSnZ6Z3iBsv9tLq?=
 =?us-ascii?Q?hn443I87crPfQkiO5P49qJeB/3o0tu0UV3Rj9EpB/NpoNt2vanpotGSQPsrM?=
 =?us-ascii?Q?nh3r4Zsh07pJP5tfHIAf56ibEp8ZH6BrAgDAy3ymV6w1AEWrbcdFbDEvEKnC?=
 =?us-ascii?Q?IMTMRFrpqtfJidb2BIockzaQsY4i5aJYNw011Jj3lLl6nuJDNaEVK6bcZMkl?=
 =?us-ascii?Q?uUd+iabif18NPwi8RloiAs4oTa20BiK7QBaIoWnTIZLQhd5JoAxckRmxhGyJ?=
 =?us-ascii?Q?ByxLPU5HjLVIAwpp7Iiygf4pPfevqQ5AVE1/ROme4NLB3Br8CBQpA9ommSHE?=
 =?us-ascii?Q?+TICzeVAj0hYCYeutpZ/r9tNIsNJ7VY9Wdywz7VD8G4/97lIm7P+fUE8F3Q5?=
 =?us-ascii?Q?0sbcsH5+1oep4XF5ZuIBAJisKckYA2wJ3+0QkpR9VwR4DjikMaLWOJlLGIXP?=
 =?us-ascii?Q?Fwc3WNGRsVOlzT3p9IxZHT0OYB5Ut/1retlJGmxu8tccLbInLjFprjpQx9Ly?=
 =?us-ascii?Q?wm6z16/FNaetIEl78rwhSk9qld9sQTVzpRmvBslyCjjtEMGP5zjBqIySJ37o?=
 =?us-ascii?Q?u1XYx7mbVL0koC7xHXbKSM3WUhRIfxMvJ+7pY1X3DDeC6jEh6P5BZzvWmf7V?=
 =?us-ascii?Q?Arz/A94NXTMoMF5NLm760LHnu7Pb3D+8q/r0eRpi1PYfmKRZpcHB3KXLnpzV?=
 =?us-ascii?Q?mLJCIgtqI/rFiM8yVfrgdciLTN99sgC/5ScgfFJDVTYBXoKwEgmOaNQqV3cO?=
 =?us-ascii?Q?S8AcesDuSRw5iQ9VQMNk5kJpi30jF+oV5V6mDPsaSR5z7MCv6eeajnEpga3V?=
 =?us-ascii?Q?VTGjpB3c/iFEMbMfKBfpGTNe0OjVbGCW/DtmQ7s9tACp+/tCh0dTJKdmUFRy?=
 =?us-ascii?Q?2gC5ZHPupmuicKxguUpQfCfexe37JlWv/QlYDQABCaFOfjkzON9erKKODT2G?=
 =?us-ascii?Q?pLSI+xxUiQIHrDEWoOvsoEclzITVZX7iSMJKCxPyIa1VWa0crXgXlBnh+aAw?=
 =?us-ascii?Q?zeLYOHgRcvEcZySFAoJdKu2BUkdHAFdlGk/K5pxY54Cq/cOj66q4ue3Ey+ei?=
 =?us-ascii?Q?YarOm+2G6Acbb8t+k68rL2g8sBf1Wzg/etghAWeqjSJFxKObbwa2jVd22rNd?=
 =?us-ascii?Q?87whxq3wcvUvq4mbaq16wTh1G8ZSfcM1adaVHhnAmhm/UfxhyF2V4emLdpZh?=
 =?us-ascii?Q?EV7WkfxHUhTdBMi2EZkH4sH+9Cje7kYm3wv0hwJDz4Sf1JrzHA1i9x8PBCD7?=
 =?us-ascii?Q?WwrIxXzmfcqM7bgubblCx7ct8suQwcTP3+N3BzzeYwb1H8mytnCiZT2izRak?=
 =?us-ascii?Q?qgocPqw3XXsqYEsd9vJ0Wltmuxh5OiyRPfXx37UgFaaxfIzwZnwB5v22Cm/j?=
 =?us-ascii?Q?yekcB04675CS7h2Ueq/qGc+qsX3QIf8SK/XitPvvQs3rshJ/p4Yqmxw2hsVz?=
 =?us-ascii?Q?XiGN1skUQ4tfVnB17iY9MtGwj14pFu6quCW2ST5VEy2f74f2TBEtRE5UhaC3?=
 =?us-ascii?Q?1FkbvV874hrBi1Jk6jEB+nXsMVYlk7Uqu6F927D36OZKBBta83IQbphAacgs?=
 =?us-ascii?Q?4hej7e79TwqKhUnbvmYQ1rSkYOCZliQ=3D?=
X-Exchange-RoutingPolicyChecked: vk3cxhqw29tw2y6sUOZtjDKeu0coUzvYrLrQqZYExfJYzEnIHmEcQaMv4OuX7ldvB3cLDIxxF69zk0dv/ff38079sluFkc9gBwGnNmg9jus4eUtrtXT23Upax8Knh4nh8UurL2sHI5gsff+ohZaN7yB1T6DLYoBEY1wL+c5Z8c8v/K0+ur9Tmuhf4fu/1Csk4Fgz7qNcXZ1HzGLj5hUwA5ZP517dnU+m345lUkGP1zo47RP0kT5tqzuA3pwOfGsvRil839n1gVgbjQy+EHxtYwpwem0K49atIqXrJNg9IY7dLGb4DOdSe86CfJIxgPZgKigGyzGug81ZgsGkNhr1kg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a5642be3-22fa-4e3a-e8f1-08df159b5ff7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 15:41:58.5610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqJrjbatWh+ilI5sUaSpzFZKYcz8OxPIFVCv/9hgSeW1NkReBSrzc6rMTPQRymfmQxpyE5+HfRWGfZ46P+Tt6LVwj/42JbRORHAmDX29QHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4559
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

On Thu, Jul 23, 2026 at 02:55:58PM +0200, David Marchand wrote:
> Let's check if a testpmd and unit tests from a reference build can run
> with the current release libraries/drivers.
> 
> This gives another level of ABI checking, like catching regressions on
> experimental or internal ABI symbols that get promoted to stable.
> 
> We may need to skip unit tests that were added since the reference.
> So add a ABI_SKIP_TESTS environment variable in preparation.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since v1:
> - dropped hack, testing this patch can't be done in the CI now,
> - emptied the excluded tests list,
> - added test-null.sh,
> 
> ---

This is a good test to run. It's something I believe our internal
validation team does at times too. Some comments inline below, nothing
major though.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


>  .ci/linux-build.sh          | 33 ++++++++++++++++++++++++++++++---
>  .github/workflows/build.yml |  1 +
>  2 files changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
> index a5e602ed83..032f3726e8 100755
> --- a/.ci/linux-build.sh
> +++ b/.ci/linux-build.sh
> @@ -206,23 +206,33 @@ if [ "$ABI_CHECKS" = "true" ]; then
>          # don't try to link apps.
>          REF_OPTS="$REF_OPTS -Dcheck_includes=false"
>          REF_OPTS="$REF_OPTS -Ddeveloper_mode=disabled"
> -        REF_OPTS="$REF_OPTS -Ddisable_apps=*"
> +        REF_OPTS="$REF_OPTS -Denable_apps=test,test-pmd"
>          REF_OPTS="$REF_OPTS -Denable_docs=false"
>          REF_OPTS="$REF_OPTS -Dexamples="
> -        REF_OPTS="$REF_OPTS -Dtests=false"

These changes should go in the previous patch, I think - certainly you can
drop the tests=false one, since it should be a no-op.

>          refsrcdir=$(readlink -f $(pwd)/../dpdk-$REF_GIT_TAG)
>          git clone --single-branch -b "$REF_GIT_TAG" $REF_GIT_REPO $refsrcdir
>          meson setup $REF_OPTS $refsrcdir $refsrcdir/build
>          ninja -C $refsrcdir/build
>          DESTDIR=$(pwd)/reference meson install -C $refsrcdir/build
>          find reference/usr/local -name '*.a' -delete
> -        rm -rf reference/usr/local/bin
> +        rm -rf reference/usr/local/bin/*
> +        cp $refsrcdir/build/app/dpdk-test reference/usr/local/bin/dpdk-test
> +        cp $refsrcdir/build/app/dpdk-testpmd reference/usr/local/bin/dpdk-testpmd

At this point I'd suggest running "meson test --list --suite=fast-tests" to
get the list of available tests in the reference implementation.

>          rm -rf reference/usr/local/share
>          echo $REF_GIT_TAG > reference/VERSION
>      fi
>  
>      DESTDIR=$(pwd)/install meson install -C build
>      devtools/check-abi.sh reference install ${ABI_CHECKS_WARN_ONLY:-}
> +
> +    failed=
> +    configure_coredump
> +    mv -f build/app/dpdk-testpmd build/app/dpdk-testpmd.ori
> +    cp reference/usr/local/bin/dpdk-testpmd build/app/dpdk-testpmd
> +    devtools/test-null.sh || failed="true"
> +    mv -f build/app/dpdk-testpmd.ori build/app/dpdk-testpmd
> +    catch_coredump
> +    [ "$failed" != "true" ]
>  fi
>  
>  if [ "$RUN_TESTS" = "true" ]; then
> @@ -233,6 +243,23 @@ if [ "$RUN_TESTS" = "true" ]; then
>      catch_ubsan DPDK:fast-tests build/meson-logs/testlog.txt
>      check_traces
>      [ "$failed" != "true" ]
> +
> +    if [ "$ABI_CHECKS" = "true" ]; then
> +        failed=
> +        configure_coredump
> +        mv -f build/app/dpdk-test build/app/dpdk-test.ori
> +        cp reference/usr/local/bin/dpdk-test build/app/dpdk-test
> +        for t in ${ABI_SKIP_TESTS}; do
> +            DPDK_TEST_SKIP=${DPDK_TEST_SKIP+$DPDK_TEST_SKIP,}$t
> +        done

As well as the ABI_SKIP_TESTS, you could automate the list by again running
"meson test --list --suite..." and then only running the tests in both
lists. [using "sort" and "uniq -d" perhaps?]

> +        sudo env DPDK_TEST_SKIP="$DPDK_TEST_SKIP" \
> +            meson test -C build --suite fast-tests -t 3 --no-stdsplit --print-errorlogs || failed="true"
> +        catch_coredump
> +        catch_ubsan DPDK:fast-tests build/meson-logs/testlog.txt
> +        check_traces
> +        mv -f build/app/dpdk-test.ori build/app/dpdk-test
> +        [ "$failed" != "true" ]
> +    fi
>  fi
>  
>  # Test examples compilation with an installed dpdk
> diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
> index c63a9a3982..5ee55f4d27 100644
> --- a/.github/workflows/build.yml
> +++ b/.github/workflows/build.yml
> @@ -39,6 +39,7 @@ jobs:
>      env:
>        AARCH64: ${{ matrix.config.cross == 'aarch64' }}
>        ABI_CHECKS: ${{ contains(matrix.config.checks, 'abi') }}
> +      ABI_SKIP_TESTS: none
>        ASAN: ${{ contains(matrix.config.checks, 'asan') }}
>        BUILD_32BIT: ${{ matrix.config.cross == 'i386' }}
>        BUILD_DEBUG: ${{ contains(matrix.config.checks, 'debug') }}
> -- 
> 2.54.0
> 
