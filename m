Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888CDC43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 15:07:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 888F740150;
	Fri, 10 Jul 2026 17:07:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 5227E400D5
 for <dev@dpdk.org>; Fri, 10 Jul 2026 17:07:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783696058; x=1815232058;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=1DOaBfv8sW6UkQuhkBEx+q1ZEBZlNc7jUL9UkVhg+ak=;
 b=k8t5C+/5ADgHpg98lBIGnNzCSmcbwvvSVzFEmpyD8HOvUrWizitnoisa
 ZyZu1R1mmLyka1GqnyeEyoPMRfsyEK+ly/ONIVGqaa+QO7tM43FU5ii9a
 FvJPqqIVurlOgpFOJjg5yktX+r2MgQlp2BO01BL2m4Yb+lyjqwt9oGFzE
 7zpL7XiIV3KMp6hpf0Atfc//tvOy2V6f3HlVrPGWe/y1WoCEOjVn5AquB
 qAR9vd8ENjBxJjKje8wzxv3Vn1k/X22PnbQXqByXngX4ziQCtTyPtGLdR
 UdkGvmwNyHrYZ7bqDzrKy+4wGFviOGALApGOQgdUUr/d9uo96VJ8wvMjM Q==;
X-CSE-ConnectionGUID: 3SOxEsBaSiu482o+3LEPug==
X-CSE-MsgGUID: JmdSf7pcS/CUUFgq/7yOdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88082101"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="88082101"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 08:07:36 -0700
X-CSE-ConnectionGUID: m2saIjazRve7Ne46xsV/uA==
X-CSE-MsgGUID: 7dQEU/mxR1qd80KQt4JJOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="258509323"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 08:07:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 08:07:35 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 08:07:35 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 08:07:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIyFGj9wxfNMH/LLhHGP89XMigZWFJszcvf563vitMcfCjCOHQDHU2bkdnbwobA+QpEHR4TqOrgYaK6gpuszE4AnoCytM2jYa6rAsqZQkbMK79WK6N+cJjAjysOH9cSgrfvJSzMqt0XLMjEzvR/hkMZuNl2K5AcDTRBXu6zeQo1RgJ9NwGqsU/cAwWl5lYT+XG+hlFzyUteyrFZLhEdfMOgj4wLdRK8mkIbR02AMJw897gjkRfQZSqGTI0qQFmFJ+oPc+U9FUMwaIDUUArpAapSta/gaq0DOqOxN3rdRa63LPt4ftEzS9Vi5QZObW/VqIBoRKcaDReuX6DZWazNIeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2O3opqL9kKiXUvvc6CY6jegfiF0zt5V5Ma6vygUnywI=;
 b=dn5J3sAKFF3zgDXARATjr8yBh8Stt6W3Uj4C4hUBhj/htiOIkGZp2mz9CjNtzk0eeBazT1SONdncN79PPU5/c2K2Q0VhFYigeepdJH4JsG7i+/TX/IdcsUabLzPSmqMNi2/ks75XKUEtJS/owZHjitx4PGomeRfNX88Loo/XQd6MSVStMkkhflr2ufYnqtrJunxxRQxVbFjGswNLg7B7zTaYVKx3rVkNUIpUPjngGP+v/qX+a2oGLwMmDGScTvDHvkMEv77iNECaTiReG/YvrxmFjGHacAfcX4WfOqclycKR+GLXVU2DqwYDztDfPcsSg14Rr6t+C745gQ04+0EcAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by IA0PR11MB7355.namprd11.prod.outlook.com (2603:10b6:208:433::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 15:07:31 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 15:07:31 +0000
Date: Fri, 10 Jul 2026 16:07:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dawid Wesierski <dawid.wesierski@intel.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <marek.kasiewicz@intel.com>
Subject: Re: [PATCH 1/2] doc: fix ice scheduler rate-limiter burst size
 description
Message-ID: <alEKrp04EWN0I93Q@bricha3-mobl1.ger.corp.intel.com>
References: <20260703121952.1277387-6-dawid.wesierski@intel.com>
 <20260708231926.1550698-1-dawid.wesierski@intel.com>
 <20260708231926.1550698-2-dawid.wesierski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260708231926.1550698-2-dawid.wesierski@intel.com>
X-ClientProxiedBy: DB9PR01CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::32) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|IA0PR11MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: 744f3c9e-a0ea-4f56-17cf-08dede94f6ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|56012099006|4143699003|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: h4VLCBPrgNu/Fh+CMWI4DJUxwm9yYFYUHA0IaRgVmwmtxSo/WfqZ9gCEgBk6tQMD4RfTI54EmRmuY+BlAO9E2VDm/8lzruYSGUFBj8Kf/N3DllykfG+cwHXU+qX6nQ4KjyQuHjW5+gsWDdCwQeMwnB01+Y8aECCuPG0rXq5ZxV4h/uH0t9xdwjhruf+8LmwL073HX7kGWjE2+Im0yoYun10tW9i5aodPV9py/v5/AxtEp0wBtSn612dJ2ij1ktFulk3xpFqogjtU0ecHIts4sphqsV3BJb8Q/+R5hTWPoo7McBRd3qEILsEDNShr8Es6mAiFPKOpu3ei4yNOwrp9SnPsSihJd09nhlX5Q6nUn++rmUsuHI45qZtV0EjDK7cvzZYvW212WhQaGASnMiwfYRSkH2N5BPX7Gg234l/q1WKEsYln71y4X33L92TbEqGwhrpahd6VaLECQUbyw9rQsHBOAWIARbxwAk1I9/sZBEf5g2YO9viE1hhRWLqPmckBi7e4jCb9Y2yjvSPVirO4BqusGMzf5S6NyOV/V2hqCAOmH0plm56t92HCWCGItpzzSSVcZzChA6SDaF3kmlMoQ7qqcgVC3KClJbsJymp6NzaMbeIUxj5DEmWg7upmaofR5Xwe/7Cx04NeGcsW/j0UZatc5ZQXS91uXrLK62dzrYI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R8ut3ECSBFVmBrf3PzVDKYSJB5WnZYoYeZ1sLT3UKDrfAqaoLiUhr7NSNEJK?=
 =?us-ascii?Q?O18yBl0A8hJBtCcc0SUqpqohsN8OB/G7Dfw1qZ1cI8nZncOBF/Pk1GqqnGCk?=
 =?us-ascii?Q?by/GbYqZVqTwhd6BpR+g/Te5XD/zgUhlw2Fojy/i0iuSbA2OlkEj91fbz9LP?=
 =?us-ascii?Q?/wKhxiMKw92Pmxa/vcWtxF5bE/08sJAmgA3W1Ay0H99aLf918rmRVoCstj53?=
 =?us-ascii?Q?1d39GA4k9A+CP52zMrI/a29q935IE/gJtdHb0TQ+zTSE+wt7YEHtB0VTdiXB?=
 =?us-ascii?Q?VPn32Ac8a4wMIHIYamEGRl9CiOiKM2yG7g3waz47E1uaKSnLBLeGILQiZxhk?=
 =?us-ascii?Q?K0nNx//oODlonT/67lNZPLUK7pDCLv6OFD+NLe347LwnpnEFKaJ2C+Qb8P4/?=
 =?us-ascii?Q?307Bs/EG05gt19v/RcWUNQzmCTgW6L0Nng+L9kB752Fh9zPVG1ijJAxCEC+W?=
 =?us-ascii?Q?a34jFHdg5JyUO1ctTucaOo1kOaUynW/uqccZ5fE9SLE17A/A6H7K1kAYRxuM?=
 =?us-ascii?Q?3lLgVCywy9BjLP/0mnj4x9rE06UK/+JrChiisTpHU50s0qjQpScQMaeyvXe6?=
 =?us-ascii?Q?lr9QkNx/0W8S0JgUiudzBLQNBrgMWH7LSo7fliaNcAZwlUbrvhXqrdO5BrbY?=
 =?us-ascii?Q?o4+p8mMlJEQxI9Q8MF88f5gBEEQjq+2ykBItfB10tLDh7pYEhQ1Jrop1nII4?=
 =?us-ascii?Q?rFxu7bQpIug+6O1AxpDBcWyYRhxGUE03EbiczJ1DSqwLt+kRZn+SZN1M1WLW?=
 =?us-ascii?Q?iCpQCB8xgYA2v5gG9ZV2InNn8/zqeVq2G0EfcHFzsgw84PvRDgCpHX+5o6nj?=
 =?us-ascii?Q?kG8cT29DM+pH5H2uWIDxLvmBF0/z+OhKzJn028Js8e+ihHlSvnR1Hm7bBf0b?=
 =?us-ascii?Q?K8IFFuj75wWzh88xCildMY/6CsgQDj3x0uTjW6ljMzyjB616Q9nc17tXqd6m?=
 =?us-ascii?Q?6nPwAseS9Uy6vezJRMNaOexNknfQSerwfLsAsB3cJ3od16If/KcT++qc4Pf+?=
 =?us-ascii?Q?JzOxq31M2ya91f8XMkxtUcExGoq+wD9Sr2LhJUdRFdN0XBPebpgFtz6Z18HZ?=
 =?us-ascii?Q?B1Q8FJFS4dMGLvtnJwttjj/VvXftOe6rIOJBCaR+RoejcA0bJH4U6SfYhw2G?=
 =?us-ascii?Q?mPE+9faARbJIx+FCY65FMKoiGJWeEnsBNdeVfRkYbxPePP7WhXaPbtlLbhQA?=
 =?us-ascii?Q?D5pYZTorFGckNXckFZPiwDWICcqiPps8nJ1mTR+TQdS/r9sIVyD5XvkFOc8+?=
 =?us-ascii?Q?YKBwAvCHk3kZfa8/aw8g1meIom2y4hgylKOSEjBNg8Ud2FrQHAjeK/7Y48hi?=
 =?us-ascii?Q?Jg3WSN/ceNFhSWoQGf1P6ZRgvHKpsMMb29YZAXG+2zvvu+T34t3ZxUI7Deky?=
 =?us-ascii?Q?Y0BgiL59pplEw2/eH/N8F9eCecX/EuAP5peTRXy9UFnMKuKL7+EEwsnIYlIK?=
 =?us-ascii?Q?T42xyS8E59PJh909hmjV/xLtJk8QhsQNdQb7143hwTuwNzXarN1jmCNvVRn3?=
 =?us-ascii?Q?iiwSMu1LF4FMDsqzhIGBjg+ZUJo8W/FLcwPlLVgtfqZ5sYNAEY6Ykmw90Usd?=
 =?us-ascii?Q?7plphxC4ZRDumECn54F4sHZMn1tDPeCjO/hy+H9LpVY7aDdgvg2GO8IGv+fg?=
 =?us-ascii?Q?kbYBipUnbsQZyYeMHNZDjetfKT2LdxsfoYvXwdWDvHbcSg4RDJ9xj3JD0A0m?=
 =?us-ascii?Q?7urarMpOZTYxgxvozXUw7S3PWZjj2myjYx4UnVv3TYm7HJ/CyKp4E/ygESZ5?=
 =?us-ascii?Q?SSzFWJeXQ8stwc0EPds1HKxY6p0Rj4I=3D?=
X-Exchange-RoutingPolicyChecked: Cqbqm+k34cLUxz25y+XwsVk/jRgbvvRIbCaouWJe1EYjSzXrza3JhdexLWlrBUevHUshwgNzTAC9scPVZflKScvYoDbt6Uu0hwCuX0ZZbmuF8B5+nYd3lob1Lap5WzOcKzbOfXh+HLJDQKx8JIiXOOxYoXS6OALDeYOQ3/5+uXVzU0j87CBhlXhHGMt6ohAdbWHoKec+Oi+CHsOGmP1ocgNr2GjQKZO7AoI/QqkQzWZgmQ/DUbewRcEDhFTeVhzqqiaVj8B18TpPWL7ascn/hIHmtJCafIcOwhXXz+OZAf8E8mgjxADof5Zh7D28Yy79M7xFf9blkPC2kFDaB9oQXQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 744f3c9e-a0ea-4f56-17cf-08dede94f6ae
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 15:07:30.9924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtyWZ2aagQVjNehaOkwao019sdn7f/9DYGYjiWwKGgBMF5MuqswPn010yBwZS2OFHq9Gj0kNL0mIxY3Cjx1BQ+PMfTnwwOH/ZiB8OmM5qVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7355
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

On Wed, Jul 08, 2026 at 07:19:25PM -0400, Dawid Wesierski wrote:
> The paragraph describing the ``rl_burst_size`` devarg was mangled
> (a mid-sentence line break split "favours throughput" across two
> lines with no space), 

Are you sure? It looks fine to me in output generated on my machine. Also,
it's unlikely that changing the source text to add a line break between
"favours" and "throughput" will cause a line break to be removed in the
output.

> and it did not mention that out-of-range
> values are rejected by the driver, which can otherwise look like a
> silent no-op to a reader.
> 

Yes, that extra note about invalid values being rejected is missing.

However, the rest of the patch rewrapping the text actually goes against
DPDK documentation policy. In order to keep doc diffs small, we try to
always start a sentence on a new line, and to only break lines at
punctuation marks, or between clauses generally. This saves having massive
diffs as the source text is re-wrapped following a change at the start of a
paragraph.

See https://doc.dpdk.org/guides/contributing/documentation.html#line-length-and-wrapping

> Fixes: b3f2afb3b7ea ("net/ice: add scheduler rate-limiter burst size devarg")
> 
> Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
> ---
>  doc/guides/nics/ice.rst | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> index 5589ce934f..6c2063d47e 100644
> --- a/doc/guides/nics/ice.rst
> +++ b/doc/guides/nics/ice.rst
> @@ -160,9 +160,10 @@ Runtime Configuration
>  
>  - ``Scheduler rate-limiter burst size`` (default ``0``)
>  
> -  The hardware Tx scheduler uses a default rate-limiter burst size that favours throughput.
> -  Time-sensitive applications can lower this value to reduce Tx latency jitter
> -  at the cost of throughput by setting the ``rl_burst_size`` devargs parameter, in bytes.
> +  The hardware Tx scheduler uses a default rate-limiter burst size that favours
> +  throughput. Time-sensitive applications can lower this value to reduce Tx
> +  latency jitter at the cost of throughput by setting the ``rl_burst_size``
> +  devargs parameter, in bytes. Values that are out of range are rejected.

When they are rejected, is an error just logged, or does the driver fail to
load due to an incorrect value? IF it's just a log message, is it better to
have the driver do a hard-failure so the user can't miss the issue? That
would be better than just noting this in the docs.

Regards,
/Bruce

>    A value of ``0`` (the default) keeps the hardware default.
>  
>    For example::
> -- 
> 2.47.3
> 
