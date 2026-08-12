Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255F7C5B572
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 14:08:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F38940298;
	Wed, 12 Aug 2026 16:08:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id C59034025F;
 Wed, 12 Aug 2026 16:08:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786543713; x=1818079713;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=URq3sSY8or5KSl8LFIUIr4Hk1vY719Ps6sksYbFrY6Y=;
 b=SUhDgs/OVIwfVQPEZ+gTLJKa9oekSalPPXl851ZC/uXoMdedNdFaFe8b
 M38bsJWecNdb52TtH5Dfb7pTs99AlfrPNuFxVDNGeishihCKlnsMzwYQs
 eCLn6ljX2KYrB3u66ltO3wQBTLpAldCDM+Xpsc0e6S6olg0sBrABFG2x3
 B2Q9YoYCUqWvpbs7aTJ6H9QKM0OtuEk9fhzJCCKHdzd7lQOCigzb7Ycvs
 XQDSi4vOoJJK9Th+ezWOcAwdmavBKmv3E0Y/677H/AqG90IeCurVBjtZh
 bdVPFJg6vv6i/8PXbgffRM9ApCh+hMlH8h1BiON1dwMj4L99tmIGrTyjh Q==;
X-CSE-ConnectionGUID: IjLNbrzCQ3uc494ZP6VknQ==
X-CSE-MsgGUID: 7i5Y3HgWRfuMFzpaJpf+OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="86865065"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="86865065"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 07:08:32 -0700
X-CSE-ConnectionGUID: +6WCWHS4QsCBgfsyRpsb5w==
X-CSE-MsgGUID: ZIoojadYSOOvmYaTc2ZTKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="293601383"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 07:08:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 07:08:31 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 07:08:31 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 07:08:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0kHf5x7XyCQS4Lmht7WQfcHvNJNupWlvviVRmN0CuTQcXEivfxYuhY4LSU0TY6ZbaLs8HmHrz8EfAdF5XJrmMSAlDBE8CpsHglt7ZQsxaA/l2jspbHEYv7GeyUxTOzAOR3Pt4iIGL3v+HM4+jybtqpzZAKieD8k1qGmWKvYavloUEjvXDh1BUqa12di6AF+D4x3Y2+uGGXoQS+10tH3LBCQK8N7hSj9HPGxxLB6LQH+ZI3+G0z2czsytKKXh7hJN6Gfoht5cog6nRtyQ96525QR6q+C3yl6sCgW2OtVLmqiHOJU7UI9Xj/pJKkTXyiJKCFwV61mYM7L8jQU6IWlvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1fLHZkGA0St+1bz3iJjChVMoi7GxJyzy0jG6s9xAGM=;
 b=lFP4oaubEaNWMEXCqkgwOFky8aMkRjjsHLxZvekkMt1o7SFvC4+TvNa6CAJRBmqmd3HU3t27j3C/HATpxdMqQfdWcoT3/BR0nu6+BPti0x36/7NJqHG9NSFe5vAzDo9gSEh6bQUwn6pHQaTPRkrrb7dEcxYP3jACzc2b1Ics4q+et9yAglTBvG5ownM91/ie1HOU9rDfXbAfElT0Tn0SnA9LuKOYn3Awe+EggNMprwy42dbKNnI0A+13J0KcFLXxYB5k5Bu3c3B0eAjnIH0IFAbo0jNZkUgkDo1kfaRNht/QbQ/SqA5hd1Oxbvbefbn8fRwAKrQ77dppMEaoKl/Vrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::85d) by CY8PR11MB6841.namprd11.prod.outlook.com
 (2603:10b6:930:62::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 14:08:27 +0000
Received: from SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 ([fe80::a6e3:dc11:48e:b2e0]) by SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 ([fe80::a6e3:dc11:48e:b2e0%7]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 14:08:27 +0000
Date: Wed, 12 Aug 2026 15:08:23 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] app/test: rewrite telemetry test in python
Message-ID: <anx-VwXODYao_COj@bricha3-mobl1.ger.corp.intel.com>
References: <20260724201541.801099-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260724201541.801099-1-stephen@networkplumber.org>
X-ClientProxiedBy: DU7PR01CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::20) To SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::85d)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFED9C9AC99:EE_|CY8PR11MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ed08ad-7627-4f21-37ae-08def87b2e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|9063799003|6133799003|22082099003|18002099003|11063799006|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: 7oxj7AAnhlfV4+0Ya21VXXY4PvKQ2Aqa/dKjNq9dnhbpS7/TES5Ppzwp41pUlUjHEgSB0njmTebZBgUcFtUqwUTxA06ftRbf+c4SjTuseeryujVGqD+QES+2rCAbIdOTD+pLsFd+MiduEVe61f8t7LG4F+ewT/NRuzSRDnsoyTVgeZmyaIJTjBjiLbquiJGM2zb3dVYaBdl2hp8Gg+PjoCrO2Hn0zxrt4OaQAxnxPADXFZFel6CBVLqCIdM5AlQ1bIYqqjkvXot9Xj9SQGRyycSGRKbJKUVGfA/xatxFCOZv4k89uSLB4vgmAG4cwcWQl08Q3qYuwNpOUB5tT7yoSanK3XjAA/TS2Bv0BS9RJVwiv/eZbi36MvAfFuxcKMC5zWcFdCuAFNN/nfxuyDy+W3TJE4y2zqNdm/+p5qSNRQbKwUntfm8+GyOMZHoE1ByDZwH1e/rZFHxebg6WRWMbixYGFxk0E86j5yHiXPtcnlnb8sH4s6hut/wSqq7OZFkgrVIeimRml5f0nbjFjMxvtja4q4ITEWQnZz0p8Ay4dQG7j1Ndjl1+K8KHdqawUusxW68zbKmskUDsVS3f3GnLgcIhryLdx2MzNY3J0x/4Bk0A6EdhT1eWTTHhc1Gj2moLb5gPOQmzdiENqduLoDDHTxjFk8/OxDlEEGzg/YJ9a3E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPFED9C9AC99.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(9063799003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xYXVxHZB3iFiu9IfFL6LprJpanXAQ/pFBELugw5pINcjwO8ZJOTOhLU3Jhm0?=
 =?us-ascii?Q?atXXTy5IftcCbbt4xeM/825XtEwZRRcJds4hhBJs3VbEFoMk3YF3kw4xeedO?=
 =?us-ascii?Q?dLcq1+N1AXxH0FAjxJYYg+MAJOrheUW3TqzONl9s5mityq6OqRBbxzdhDbBX?=
 =?us-ascii?Q?uCx9mGiViVOt+freHVXXT2JI3efJxeGIs27S3nURMeh6rn2wZzkg8IN24J9Z?=
 =?us-ascii?Q?TEDNfjdW8W4bW5g7IlTU82t7wtG/O1f+3RrICipgkzVGZnSI4H8cAZHJZEcT?=
 =?us-ascii?Q?MBUStYcjMlANGxYw4c2lA1PT/nyNqE78FEx0lDnhshrbDnf/GYPzGCFWDHna?=
 =?us-ascii?Q?naQnCRz/SnKZnHCRrVQW/RpGvV1JjZ4KDtdXpIPS+2i//ae6UbyABf06Caaq?=
 =?us-ascii?Q?G+v13AwUsefOKDvJG15Br4ccEGCfTzx3X8QMg2d1Q2oJzDhDii7fY1x8XQKv?=
 =?us-ascii?Q?ernxx0fbt1a/pAq4zWEkCCX4daCQh/K4vuXQCpNwLBQMP1JyJt4qsxPcT2b1?=
 =?us-ascii?Q?wPFmCb+n86dD3+IQ+RVC/D9ImhWespReY9X+AJNb58FpSlY79Z/T7xaUuAYB?=
 =?us-ascii?Q?hQ5mwFquHr2qscJis0ZN2ZCZnzc+3mt3hJmeU4mJGD8dRUZCbgLDF/kg/IOb?=
 =?us-ascii?Q?cbvStmGKqf41XfZGztTqvm2fE6y37xK6G2DLqgLvvS1l+MRdDak0m+3PlQR0?=
 =?us-ascii?Q?YEP8/GpSY3hiv0UTugz//yFNzrsWaLdjZi24GqhIEKBiI1yfPC+YMccpH8eW?=
 =?us-ascii?Q?2TqtSSzarBMrnYPhoxliOYBGS6QpNMtWQOy0hIJTQmIFLMruRDCOw005MfRo?=
 =?us-ascii?Q?+9z1pXHcaa6/XU70ltSWitEbZCmgeOsjPoTjH8zoljQbQJGjH1v97QHyD3EQ?=
 =?us-ascii?Q?dmeatJ0mOzcQMVkeEheoBlto1zLNL8ZdRhAUgO8HGHEUdHSjcTtJTeGJeP4j?=
 =?us-ascii?Q?+bZHRUVENtry3o5iqZzdgrFovDk+tn15tlrSEK5KP1bjLzL00jc8Ci57UDYl?=
 =?us-ascii?Q?0STC5/YbFgUQ7P6VwDsKAsfuYODrk1TRMd3TbHD8o9c+O6Ihrl5xOSCN3eDC?=
 =?us-ascii?Q?bD5+pq37BoFfUZZXG+i1HU4KN5TO8gpFhMITgjN4w0Ap/UG7OXHQ9z8h5mza?=
 =?us-ascii?Q?6wpRIQLtwYUp6WFyZUhASQ/ByNHelujTAJ8D/iAtdWMM0szh7LePom7UJkzl?=
 =?us-ascii?Q?gxgt1X5hD5cO/K9CwJ+i2xc/I5gJgvJiEYr1f4TsmDPqfUONLUbFAVrVkv3B?=
 =?us-ascii?Q?PpPmllMHctGSSdAVtxnlnG1ZJjPVMJr6wd+yojhIzDJGjkxnN5b9W1/wY25e?=
 =?us-ascii?Q?JIDe4X+k3kQaEHFlIeZmxejKfVP7ygpaeCcIfeAOlvTkrr6x+iXQk54DS+jH?=
 =?us-ascii?Q?nsf3NZCU0SAruMKcO60Feg9WLVwuzl9nx/AB83e2646uDEeX+ySBkVjtVU06?=
 =?us-ascii?Q?2BGK5bYB1oTlpYd70N53E24XdJ6OH9mzdR80h/TL0Zp+8Ol0WVWO4bjApYWJ?=
 =?us-ascii?Q?0bvoOqERKDGpLK0ek9qaFr4U7fNydTRtlD6OYZxzUvDgkwxUSE1xDKS6m6uZ?=
 =?us-ascii?Q?6iE2oBMjGNdGH+PhO/4e6ggItHqsxUGanSJu3rRiKzmJG5VXcx6uqc83FAyc?=
 =?us-ascii?Q?fXava7ukQ6iXUf7zFwoGZH9Lsz+Wz9S3dIENkT0I9MG9dLJipDjObbrtIFWb?=
 =?us-ascii?Q?Oazh3ieQ3hphAmOu/HJqV5nHFfiNiB0Q3uy7GJNrqTzzFD2b/UKAJU+nu71j?=
 =?us-ascii?Q?cc6RK2E/ZU0sTfAG9YWZjBm/fpYF5iQ=3D?=
X-Exchange-RoutingPolicyChecked: Mh4vNP88MwEmz9Y34RPqrrjr+su8qX273whM7tNbtdzJ22qEhOsXUqOIYnQ1btFG83UuHYWtBq0fjXVVv7pxZ1qPHe3KtVE2EPOEN2eUkXnXTDQOCCB/ZmoLSiMXvA1rtyScUJzsz3YpuO6xVXabkJeTxc92vLJ2KxJa3KYw/BnDY6kEuGUE94YWzz3lwz5X2j95rtFubTwvLLscqrdRu9bkNaKH8Nf+idoL6byDwSssYVYiTS/JhiWWYmJCYHe1/sT395wdYjFSihSXDNbGrVs1tCgmiFNgyCDcev7+5g5N2JQzeOgrp91OHZzOnhII8qfTfdZkXKKK0zSQde1JLw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ed08ad-7627-4f21-37ae-08def87b2e29
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFED9C9AC99.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 14:08:27.4711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHkAZxU8jMtL4MYBlH50Sv6smby/7AKZoQfZhEnjW1tCb8CqPThDPZlz7AA3xcZf0V9VJVsRP0fwp9FHmZSBsUf3ZsM85DYZhBwlD/Lbl4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6841
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

On Fri, Jul 24, 2026 at 01:15:41PM -0700, Stephen Hemminger wrote:
> The test_telemetry.sh was failing with test timeout.
> This was caused by the overhead of spawning a fresh dpdk-telemetry.py
> for every command it walked. With every endpoint queried three times,
> that is several hundred Python interpreter startups per run.
> 
> Replace the shell script with a python test that opens the telemetry
> socket once and issues every command over that single connection.
> 
> Each reply is parsed as JSON and checked directly in Python.
> This also drops the jq dependency.
> 
> Bugzilla ID: 1972
> Fixes: 9da71dc4f96e ("test: add test case for scripted telemetry commands")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/suites/meson.build       |   2 +-
>  app/test/suites/test_telemetry.py | 129 ++++++++++++++++++++++++++++++
>  app/test/suites/test_telemetry.sh |  30 -------
>  3 files changed, 130 insertions(+), 31 deletions(-)
>  create mode 100755 app/test/suites/test_telemetry.py
>  delete mode 100755 app/test/suites/test_telemetry.sh
> 
> diff --git a/app/test/suites/meson.build b/app/test/suites/meson.build
> index 786c459c24..ec1de99154 100644
> --- a/app/test/suites/meson.build
> +++ b/app/test/suites/meson.build
> @@ -145,7 +145,7 @@ if not is_windows and dpdk_conf.has('RTE_LIB_TELEMETRY')
>          test_args += ['--vdev=rawdev_skeleton0']
>      endif
>      test_args += ['-a', '0000:00:00.0']
> -    test('telemetry_all', find_program('test_telemetry.sh'),
> +    test('telemetry_all', find_program('test_telemetry.py'),
>              args: test_args,
>              timeout : timeout_seconds_fast,
>              is_parallel : false,
> diff --git a/app/test/suites/test_telemetry.py b/app/test/suites/test_telemetry.py
> new file mode 100755
> index 0000000000..f37eccabcc
> --- /dev/null
> +++ b/app/test/suites/test_telemetry.py
> @@ -0,0 +1,129 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright (c) 2022 Red Hat, Inc.
> +
> +"""Exercise every telemetry command exported by an application.
> +
> +Spawns the DPDK test binary (passed as arguments), waits for its telemetry
> +socket to appear, then walks every command reported by "/", calling each one
> +with no parameter and with dummy parameters "0" and "z". Every reply is parsed
> +as JSON and checked, so a malformed, empty or missing response fails the test
> +immediately and names the offending command, rather than relying on a shell
> +pipeline not erroring.
> +
> +A single connection is reused for the whole walk: the previous shell version
> +spawned a fresh dpdk-telemetry.py (Python interpreter + new connection) per
> +command, which scaled with process-startup cost and timed out under load.
> +"""
> +
> +import json
> +import os
> +import socket
> +import subprocess
> +import sys
> +import time
> +
> +SOCKET_NAME = "dpdk_telemetry.v2"
> +
> +
> +def runtime_dir():
> +    """DPDK runtime dir for the default 'rte' file-prefix, matching EAL."""
> +    run = os.environ.get("RUNTIME_DIRECTORY")
> +    if not run:
> +        run = (
> +            "/var/run"
> +            if os.getuid() == 0
> +            else os.environ.get("XDG_RUNTIME_DIR", "/tmp")
> +        )
> +    return os.path.join(run, "dpdk", "rte")
> +
> +
> +def wait_for_socket(path, proc, timeout=10):
> +    """Wait for the telemetry socket, failing fast if the app dies first."""
> +    deadline = time.time() + timeout
> +    while time.time() < deadline:
> +        if os.path.exists(path):
> +            return
> +        if proc.poll() is not None:
> +            raise RuntimeError(
> +                "application exited (code %d) before telemetry socket appeared"
> +                % proc.returncode
> +            )
> +        time.sleep(0.05)
> +    raise RuntimeError("timed out waiting for telemetry socket %s" % path)
> +
> +
> +class TelemetryClient:
> +    def __init__(self, path):
> +        self.sock = socket.socket(socket.AF_UNIX, socket.SOCK_SEQPACKET)
> +        self.sock.connect(path)
> +        info = json.loads(self.sock.recv(1024))
> +        self.buf_len = info["max_output_len"]
> +
> +    def command(self, cmd):
> +        self.sock.send(cmd.encode())
> +        reply = self.sock.recv(self.buf_len).decode()
> +        try:
> +            return json.loads(reply)
> +        except json.JSONDecodeError as e:
> +            raise AssertionError(
> +                "invalid JSON reply for %r: %s (raw: %r)" % (cmd, e, reply)
> +            )
> +
> +    def close(self):
> +        self.sock.close()
> +
> +
> +def check_reply(cmd, reply):
> +    """A telemetry reply must be a dict keyed by the command name."""
> +    if not isinstance(reply, dict) or list(reply.keys()) != [cmd.split(",")[0]]:
> +        raise AssertionError("unexpected reply for %r: %r" % (cmd, reply))
> +
> +
> +def walk(client):
> +    listing = client.command("/")
> +    check_reply("/", listing)
> +    count = 0
> +    for cmd in listing["/"]:
> +        for arg in ("", ",0", ",z"):
> +            full = cmd + arg
> +            reply = client.command(full)
> +            check_reply(full, reply)
> +            count += 1
> +    return count
> +

Not necessary to fix in this patch, but this iteration can be improved
using a few heuristics. For example, each node of type /*dev/list should
take no parameters and return a list of devices that can be passed to the
equivalent /*dev/info and /*dev/stats or xstats nodes. This existing simple
logic can then be used as a fallback for anything not meeting that
pattern.

For this whole shell to python replacement:
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> +
> +def main():
> +    if len(sys.argv) < 2:
> +        print("usage: %s <dpdk-app> [eal args...]" % sys.argv[0], file=sys.stderr)
> +        return 1
> +
> +    sock_path = os.path.join(runtime_dir(), SOCKET_NAME)
> +    proc = subprocess.Popen(sys.argv[1:], stdin=subprocess.PIPE)
> +    try:
> +        wait_for_socket(sock_path, proc)
> +        client = TelemetryClient(sock_path)
> +        try:
> +            count = walk(client)
> +        finally:
> +            client.close()
> +        print("telemetry: walked %d commands" % count)
> +    finally:
> +        # tell the interactive prompt to exit, then ensure the app is gone
> +        try:
> +            proc.stdin.write(b"quit\n")
> +            proc.stdin.flush()
> +            proc.stdin.close()
> +        except (BrokenPipeError, OSError):
> +            pass
> +        try:
> +            proc.wait(timeout=5)
> +        except subprocess.TimeoutExpired:
> +            proc.terminate()
> +            proc.wait()
> +
> +    return 0 if proc.returncode == 0 else proc.returncode
> +
> +
> +if __name__ == "__main__":
> +    sys.exit(main())
> diff --git a/app/test/suites/test_telemetry.sh b/app/test/suites/test_telemetry.sh
> deleted file mode 100755
> index 3c5b629b63..0000000000
> --- a/app/test/suites/test_telemetry.sh
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -#!/bin/sh -e
> -# SPDX-License-Identifier: BSD-3-Clause
> -# Copyright (c) 2022 Red Hat, Inc.
> -
> -which jq || {
> -    echo "No jq available, skipping test."
> -    exit 77
> -}
> -
> -rootdir=$(readlink -f $(dirname $(readlink -f $0))/../../..)
> -tmpoutput=$(mktemp -t dpdk.test_telemetry.XXXXXX)
> -trap "cat $tmpoutput; rm -f $tmpoutput" EXIT
> -
> -call_all_telemetry() {
> -    telemetry_script=$rootdir/usertools/dpdk-telemetry.py
> -    echo >$tmpoutput
> -    echo "Telemetry commands log:" >>$tmpoutput
> -    echo / | $telemetry_script | jq -r '.["/"][]' | while read cmd
> -    do
> -        for input in $cmd $cmd,0 $cmd,z
> -        do
> -            echo Calling $input >> $tmpoutput
> -            echo $input | $telemetry_script >> $tmpoutput 2>&1
> -        done
> -    done
> -}
> -
> -! set -o | grep -q errtrace || set -o errtrace
> -! set -o | grep -q pipefail || set -o pipefail
> -(sleep 1 && call_all_telemetry && echo quit) | $@
> -- 
> 2.53.0
> 
