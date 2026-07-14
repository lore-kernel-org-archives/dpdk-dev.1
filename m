Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6FEC43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Jul 2026 08:06:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E9564028A;
	Tue, 14 Jul 2026 10:06:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 4602040289
 for <dev@dpdk.org>; Tue, 14 Jul 2026 10:06:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784016374; x=1815552374;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Mf3bvheBXzxOuWP4fqLLeWgHUuQUqSFUOk0sA3U4bq4=;
 b=nkyTYCm71QH0tRvnvi+n4fmw0Tt8mtEIIPd8aonlYqdZQz0OrgCU5yk4
 /vThXfPQpdfr4g1fOAHNzYjjQaXx4gu56bRmvi0MI6VN+qizbbl1L/uga
 jKuYFXG7uMgcAiQBamf+GLDW6Ul3TvnAmaTABDOYlxMm+m9XQrshYZGXx
 mwpik4VBEaJd0OHf5CG4n4oc0+VavzTuskrvvrGW4g08bzXD7FYaUhlnT
 fgZudUnqY0KjTGAM8NeJUX8nwOKtyibi1wezy7Jlogz0neopsL+NFNrfu
 GaSTMzuXJ44Iqper7NvQTKlQBGgJ8+AdgZECE0sa0Qqde69zdye2DU8at w==;
X-CSE-ConnectionGUID: DMeDGoQtQ0KKg2eM+J7oow==
X-CSE-MsgGUID: gaMVwg9NR46HnpCFSkwjZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="88455867"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; d="scan'208";a="88455867"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 01:06:13 -0700
X-CSE-ConnectionGUID: enauM5SBRqOk6rUc7EB/Bw==
X-CSE-MsgGUID: mC3C8+CJRhS6PPeqZM1I/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; d="scan'208";a="252409322"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 01:06:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 01:06:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 01:06:09 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.35)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 01:06:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrfAwumpI8pHq7kf9NfcjsHBbtq9CQGyvqJIlCTn9HDoEkcCl7WIt57LPbkYTFBFxQeNM3ejFJmx5CLyJC3YUpbLCCxpeYaX3uJKiRnn2FZRcuOlc5NZv4Ts9kl295luymhtwi3IzWtof8S5NYTF7mASJEGqKG4VVjaMZVOfxUbf4JNw39o0Y78PiqQYq/qhiTwm6X1byIkzMZil0TiM9iV7F5Vn9Fgix53eYGV478vQnzIuW+E1Nj0HiGPM/8fZ/gtS3EkyInb7h3EBBJcMM0SD5+2ue4QA4tzH/zT8nobA9Upsh3h2fQzio3BFjyCA3aPR5CX2cdH3ONMKa6zfGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvPTsefjX6HSCHKIamfjbxNCeKhJoNPPGkBedxDXqtU=;
 b=pseZIOTmC4aqQKe2zFUiUAKy8/RcLX1SOk1IpUXoXgW9U+TbiqafP9RhPWAkgv8XlacCC9U71oOWxlCYV6D+xTIbx9EaujKge8kNKG6BimYzYRG+PVrK+38vLkfSxrpxtfG0vKAiYZZPi77/8B/imUne1GbMAzEIH1ai+BQE9YZwKdBRtmA81yJJhj0uVAzD9JOCcVOyYriQO50tykU3yCSAfQIi1ggyUEJrCnXPcqrlJH59M47u8SPQlB+KMB1GAuZagbwTl4/fo92f1AwQSHUrYTDvzEHgi5Iar3nmF2YHNFDjB5lYAN+VDEWXkddaeTb5WA1yltgOeFvl7JQWXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SA0PR11MB4669.namprd11.prod.outlook.com (2603:10b6:806:99::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 08:06:02 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 08:06:01 +0000
Date: Tue, 14 Jul 2026 09:05:57 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
CC: <dev@dpdk.org>, <fengchengwen@huawei.com>, Kevin Laatz
 <kevin.laatz@intel.com>, <selwin.sebastian@amd.com>,
 <bhagyada.modali@amd.com>, David Marchand <david.marchand@redhat.com>,
 "Thomas Monjalon" <thomas@monjalon.net>
Subject: Re: [PATCH] dmadev: clarify last_idx documentation for completion APIs
Message-ID: <alXt5X6MsOEy_5IX@bricha3-mobl1.ger.corp.intel.com>
References: <20260714074954.3412248-1-raghavendra.ningoji@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260714074954.3412248-1-raghavendra.ningoji@amd.com>
X-ClientProxiedBy: DUZPR01CA0238.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::9) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SA0PR11MB4669:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb95cd7-5eb8-4918-c5ca-08dee17ebed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|3023799007|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: Hw+W1EvTtZTQR2ZGv4XkWNezzEq21lUeoDcQLyBeiLsRusuiF2C/ZfWB2aVAmm2DZMg9Zf3YJkvAaKg7gjfVfZqkeb5TF1WEXC3fuZBHmRaVRYFcRSPM1C4rZLeLXf/X+Ni4iFWVaTK1LMEOrCUu2PjWfqNLpLIISQTgue48iYP0Ry0XDNQEHs03RglTmdBeb4eDEDgD752vll6pFwrLl18cZK3yBEcdpmUiucCZB1/9JQ5/XP0bRdMf+J/q9L8J4oCwDHTv3rQJzPKtSFh/PWoe4G64KtX++QBUNRLXq65pcPtG+aKR6I8zxPdoggj8ZcI8eusmVsvxeqboDOtq8mZxyNgWSRcFem57kTBCUTTS3AFZpcugmCx13amuTpUbO0tUvjSvJpnPrR4eDsJBe3Qv3kC3ZNSPNPbIEeLTh8Y3Zyfwpw9d0lu4WGB/XziuxHugiZwAow3iZTWAU+XvS3MsG975Ew9BKYjpQTUpiE0W9+GhGbh5nq6J/oPGz9Z7bPfI8/mdnF1DwSPZNDyVAP8fg+ezX4IjFe5oVwfEj7C/0zgHBkpKTNocbP59Q4sEH4/2cNkJhDPbM4OtRJ4qZzQZRIOKUkIjxqsR7ts+mBom7qdzZImdBgbmscVTrJnvCJClEASl5LKb2v+i6iLQhVyhB465vMYzU5ISePQrYjA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Xf8Pimy8SuP07IXnri4KC+uVc68K3TV0ECJR/PvThXyjmfUf5QITOBkyJIn?=
 =?us-ascii?Q?ORHe83iEJtYIgLJFjRVONOFtxMv5T4x1fF6EFdniDgKDhklPKg+5PQU43oO+?=
 =?us-ascii?Q?cFWxCLQ5H3RBS76RJQMaQi4DEkUrgAc6i91CW+pFaGeD8j/UBxi75Vf+o2t5?=
 =?us-ascii?Q?4U2cZKA+7ffpvy3NouMzdy3iPWEKMyT/WZQ5T6vBdNMQZXLFO8giNKQN0fUh?=
 =?us-ascii?Q?GalMlWX+rXnpC+/0DHDVGwPtFkrFcDE3FKztz0C0JfSzY74ohUFJs/p2gZir?=
 =?us-ascii?Q?H9j9qAf7kjvUVsef4zvo32hm8C0um4xwU2dXWjvbnerC8X9rQuDL+Er4JzH8?=
 =?us-ascii?Q?JNhI+B5GVN0u+c13Ds6GW1gCO+w+EL0NqIbcIEg5Khq8V90L5OYjQSUqX4kk?=
 =?us-ascii?Q?VCwrxnFHFRLEvBhZ88WdDHoTwJRb8LquDDssVyefs79YE+/kwQxKKA86XQSd?=
 =?us-ascii?Q?+S1bqvqIv8k/qPKME2NwE/2kjCaWSHofq3EjVIrw2bc1TF+YXj/VupKqI7pg?=
 =?us-ascii?Q?Z5UTVxdaJW98s8oyWOXn8Mejt7sDxwACFwTiWkRdV4ui8HDJHJqg7kMGH75u?=
 =?us-ascii?Q?rBYW5GUPk2QxSIKR7Zm2tyvrK8zHwNVLUOgOpjHZlcwc1wkSSiSxvZC58Q21?=
 =?us-ascii?Q?j7u9XgFH79/dREfGNMTFgVSkcsEjmgAiXbC+XEJwAOwfyLP1MzVa5fU8a+h1?=
 =?us-ascii?Q?JqRkqef3E8e4Xfizcs2SqsqDGT6JnFwGBP+nZlLtUBagWo9qJzvvrhk4UKHd?=
 =?us-ascii?Q?lSldjn/J7Ob13i194I6dnauLKI65o49fspjAGy6ZV0LBxHUzJ3mGrKToX1VN?=
 =?us-ascii?Q?ZtDcWJDn3mzHKyXfEl4RgIJ9ke9ZmXwCb1jmVDYXlNs/risX2jPsCSK/8wE1?=
 =?us-ascii?Q?f4gxBMTDlvrFHMaEu6I+Uvht8jr511fYF7Y8vsLaFlyqRvAiH7lgdEkJXo8E?=
 =?us-ascii?Q?lb9UFM36hWQq2pSHN6YySNv+QkkQTjbd4AIWrpiHqSQxQ9I+t5xEMBECbeuh?=
 =?us-ascii?Q?pk9F+Q2bJUoK93wAYJkFpc7MrKzVI5lZdsZVAE6rXoSoW+YdOozSAvr6YzWI?=
 =?us-ascii?Q?OSMcmB675u0uVZRfjofT7z+9J3ZU2kr30o9GSQLUWHMauHen5jbHLNJcpa0m?=
 =?us-ascii?Q?ETLzN8Cl9Qcw5pjKiXBNIKSWfFbKQU/RBEydTz4jJnnklwKx/PloeEjloDY0?=
 =?us-ascii?Q?3PszLh7eJGCeRfjTxY54+hfd3X4R3OaAlU1nm7j6jFZBWuIFx9WptrhWTSAN?=
 =?us-ascii?Q?JdTP8vuB0EhtRIi4B1iPOQtz/vQ+xYyMSoFHYKXCAbI6aw9RDmvM95SEcpCB?=
 =?us-ascii?Q?DSd8ERUBpPYftfhjuVbQeCb9FG8Mpk4VnvWp1XqSvrNpMoyHr6yrRw9zY9Wf?=
 =?us-ascii?Q?DM8CoHSJQna1Zoi2Jt1GKK4xt0nXEmDwOo441qseSWV/Q8ZtoNOV7X6idbGK?=
 =?us-ascii?Q?FKMEAnHaLD1ptTmn3lLIe4oXaj24nj2YUu/CuKPHZTlw5HVL6ozQKeOBmj/s?=
 =?us-ascii?Q?RepyxmL0VEkK1xVHiJO2gx2Wr5VRYhCdkbCDEqxyPJ2uIIrIBFz6yDwtLt6V?=
 =?us-ascii?Q?EWPG4IG4Ll3fJLgX8XNRD+97INLuGVCofYL2QptMz2Rq+TR/6JcboKAqY/Co?=
 =?us-ascii?Q?EYnmiW48NpSiZ35T0Uz0KrFFFpk2d0cx8+j9BbFJUFQMqhdBbR9PVj168yAA?=
 =?us-ascii?Q?c/AYmzojkVcukLseVhu6+F4+4UQrks1qecFx02niowEwoTQhWlIBn2QE67+6?=
 =?us-ascii?Q?Ltor78CTFbm8uPPzOPbVZtRLtNp2Axc=3D?=
X-Exchange-RoutingPolicyChecked: ki4FAktEKq+EeFeNPX1Iu4Xc85TnAtgImBfO70C4WVJPAUquG9S+0uW4T5jbBp/0nhwPHRub1A+mc3U/1bVnfXaxMuXi/NOE9FoYhiJ60DpdMh80eOOzpN9m7iU0tIT8MLY63TAZosVykYgMj8NiqCs/fFLFpjX7of1qeT0PLJLdQJ5yWjBvFnBSMcG2KIig0JfFyPy+nNw4JUYfEI2pnL5flzwcQ7gCgtWwVv+Gy1TO2lN8aSC5W0ORvVALQMh9oWbsn3VVbGGx6IKaXdPtqOXwnmwW4e9sgEZxqsB0q0yHE9zUV2bjT4pjAh8Bwms12vATY4euYEvDWgtgs8e7Bw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb95cd7-5eb8-4918-c5ca-08dee17ebed5
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 08:06:01.8787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vutFrsIHki9CrP+V0/N8CGHhVM/eBUVkiFE1PpsWBS6HLEDKSjAgF0ct60wmBuPunndwiwbn9mK12ovySddoaMjq3gv1dddcqW9RTwS4Ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4669
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

On Tue, Jul 14, 2026 at 01:19:54PM +0530, Raghavendra Ningoji wrote:
> The last_idx output parameter was documented identically for
> rte_dma_completed() and rte_dma_completed_status(), even though the two
> APIs have different semantics:
> 
> - rte_dma_completed() only reports operations that completed
>   successfully and stops at the first error, so its last_idx is the
>   ring_idx of the last successfully completed operation.
> - rte_dma_completed_status() reports all completed operations regardless
>   of status, so its last_idx is the last completed operation's ring_idx
>   irrespective of success or failure.
> 
> Clarify both descriptions to remove the ambiguity.
> 
> Fixes: 91e581e5c924 ("dmadev: add data plane API")
> 
> Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
> ---
>  lib/dmadev/rte_dmadev.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
> index 81dfe187e2..394ee8bfdc 100644
> --- a/lib/dmadev/rte_dmadev.h
> +++ b/lib/dmadev/rte_dmadev.h
> @@ -1338,7 +1338,7 @@ rte_dma_submit(int16_t dev_id, uint16_t vchan)
>   * @param nb_cpls
>   *   The maximum number of completed operations that can be processed.
>   * @param[out] last_idx
> - *   The last completed operation's ring_idx.
> + *   The last successfully completed operation's ring_idx.
>   *   If not required, NULL can be passed in.
>   * @param[out] has_error
>   *   Indicates if there are transfer error.
> @@ -1397,7 +1397,8 @@ rte_dma_completed(int16_t dev_id, uint16_t vchan, const uint16_t nb_cpls,
>   * @param nb_cpls
>   *   Indicates the size of status array.
>   * @param[out] last_idx
> - *   The last completed operation's ring_idx.
> + *   The last completed operation's ring_idx, regardless of whether it
> + *   completed successfully or with an error.

Just wondering if completed is ambiguous here. The index is that of the
last reported operation, right? So if we request completed status of e.g.
32 operations, but 64 are actually completed, we only get returned the
index of the 32nd op AFAIK.

/Bruce

>   *   If not required, NULL can be passed in.
>   * @param[out] status
>   *   This is a pointer to an array of length 'nb_cpls' that holds the completion
> -- 
> 2.34.1
> 
