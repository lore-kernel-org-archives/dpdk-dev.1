Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B539CC02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 17:32:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7F7042EB1;
	Fri,  7 Feb 2025 18:32:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id A0A2542EBB
 for <dev@dpdk.org>; Fri,  7 Feb 2025 18:32:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738949538; x=1770485538;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=aZUxeJi65k3h8zbc+zuDuTz/SoPMRKPl0LDqDNkjZco=;
 b=fsvD8eChGQ5+gkEyRbkSkmTCH6db1ZwnsjtlFU8ohfq92y7bWWmgArz2
 YJ6hzjDLS6hMo0IAb+jZoQATMu1+xscITs/sG7HOC1kNJnu4+Sb3UG1cK
 k/ElsWGNsomz5iaRlrG/d6DRiBl4mTDUubmyiwk7klQhZbaazWGpkdkAi
 zg7Aj9u49qIZ0ximzE/xjD4hZxK1Tvsa2sNkqbA0IkEKe2eal8U0uWL0n
 y54EdFannUi+OMb67udyFQmiaq2kDXjJPgN5k/l9MFR3oxJfnHoLkHNAe
 bU7DjWh+E5g9xCsa+FGiideXL5RiDozRFhVdziW8NYc9dKnJ9gSNnfm96 g==;
X-CSE-ConnectionGUID: pOsX/l23RRWa/vza9wT/EA==
X-CSE-MsgGUID: 5qucIMQCS6Ca2lBiO0aOWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="50578357"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="50578357"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 09:32:13 -0800
X-CSE-ConnectionGUID: 32cVfT3vSbmoIKkQB7X4cw==
X-CSE-MsgGUID: EhV4VXoVTli9NQPmiXykYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="142454353"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Feb 2025 09:32:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 09:32:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 09:32:11 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 09:32:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6n8w+eYHCaRjMyznS0v5h2FO9wLbJCHDZAFythp26SZ/8+8ug2fQV/DyUmG9iSp0pxCQCJtTWspYv7AWMdN8TFdqbjULQF2GqhtsV6owN4v/2T1ncydvN03bXThepdS3asz0ToKewxAcXAUrq5XfFZtfJXimBy6xzMQ4Hh7ljtm1iBmtGfo5gU9PndQCKQ4sm7dOCxnFzPl/aVEcYyeh3q/JyueKEco5joNp7qh+YfE+GgWZb89cOpHuM0PuyraU0EnXKbNyO6M15k/NRWMFrStw1EvXNCndm1FQdCVq+T1ra+N2J65qqb2VjDp9bzQK++8B8qvMeRWfe1cxtvMRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QH4gUdxFvCx6oUtYB3+frot6ikThYW9fJahJp5QbquA=;
 b=wU/aqw5qrVHPUa+vrisqd4FRaVPiPNFojE3imH5l7qyV61tSciYGj2Fxr6wAYeTRPVb+aPq3duGYq4CF5TQbAFiJ/i+XGJG5wq9mYUiKnRq51jIlIVzgjZYieATJ592X6ZRYWPa2aRV4zbkrUpfsQmZ3rbgT2OgzhJ5mK8xU6TP/t/Me+2Zsoy1piypDSlmQM19537a4X12g4XQR//mZV8YmfIP2nEOYIFdkHDBknKeNGfdUcl/YS8Xvz/Xw8WLmFNnI9RLRPQZdlKtMdnjMpy/WO1g70DtszwL4/e0oxu7HM7+qC74PE4HXA2wiZwM9SYTIAqSHRtLQ94XRZ/8VFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by CY8PR11MB6987.namprd11.prod.outlook.com (2603:10b6:930:55::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.13; Fri, 7 Feb
 2025 17:31:54 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%6]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 17:31:54 +0000
Date: Fri, 7 Feb 2025 17:31:48 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 36/36] net/e1000: update e1000 documentation
Message-ID: <Z6ZDhGW-75-VAhS5@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738932113.git.anatoly.burakov@intel.com>
 <fc40dbf6c4eb68aa1954d4843e6d41c3ef0a659f.1738932115.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fc40dbf6c4eb68aa1954d4843e6d41c3ef0a659f.1738932115.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0264.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::29) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|CY8PR11MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: e1c04892-ea16-4fe5-3d55-08dd479d5099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yhf7+YTrTmeq1k8R4r11CcPyZ9N7yIjCCwvdWHWROPG1EFQ1aLAsb8No7jFt?=
 =?us-ascii?Q?2Dfq+s/KODEsfmZ3wspAh4ZCfRepY5MOJTuk5pgRgPD+ipKXKzihSWZs1ZVi?=
 =?us-ascii?Q?U/kUSOScrbL89VNkfPM6JtNtt6bWRFObps0T8ezLDhuhOK8PMgh7mECUfE5R?=
 =?us-ascii?Q?Q0ouiOrhn3/oNyM7g6WSLr/VuIfdTo0FVl/Kyps/kzz4muqnAj4z7gVQwhLl?=
 =?us-ascii?Q?jm7urUadQkZOCMY7gL5u7YCxJXYJ8KzNvPmVw74o4LefQ+e6WgJSicvaSZlw?=
 =?us-ascii?Q?kGvSq3OulAR3ZJQM0IXr6du+tsFy3pe4IC3AIhLWkZNqc2IyQ8PsOYolRGKN?=
 =?us-ascii?Q?XyUXm/f3A6yqWbJS18Rej4BxqIDPH/Nw0B2Zp2lYlfytYg89Cq5QAYhfy4ER?=
 =?us-ascii?Q?9lqTmRX9AuBNWzQwZbXktag1okzozJ0iRw6fU02wqxgchy5WTbNvQtpCwUjl?=
 =?us-ascii?Q?T4QQnlgMyZ3pLPiV+zo2CLbl6isOxT8ijDcYqsDxuAS8I1JCMN6Nw1cpKHc5?=
 =?us-ascii?Q?rXhnbpxAos9dr6gCwFbb72+wfYIJFkhJk9gH9iwK3tBHFjvFItn6pM44k0bd?=
 =?us-ascii?Q?H37538IaZbqSfBopyf7Ha9Uj4IxGK/3BV/yFAIel65wyaACMcRQ1M/0fOqub?=
 =?us-ascii?Q?EObpYYfo/qqsAFbC2UZQRr2Se9VZrx95xsghcmI/e7wj9OOKC20NAJ0MDYTW?=
 =?us-ascii?Q?GV8RrJvaHuIMxSzkYFLvR5t0ofYBhuHmT0uAe6Re4QQsQtuaxSwa1+NdH6NN?=
 =?us-ascii?Q?ZhlfKu5sMmFP3Pur5HebMXX8+k2nSYwm6ReNqr5c0ITUCc2RjlXU/WRSReYS?=
 =?us-ascii?Q?JcQE+ZyeW0nLvTV/4YMvWixj6DlgawpdQUc4WgYZiUoRVMq74WeqQ+MTaXVp?=
 =?us-ascii?Q?GROlDzaHPP2Y2m+gFKJezJNgrqm4Btw9COVxHjGpoiFlF0DkcXFrj50/SwZg?=
 =?us-ascii?Q?kikf/3RYMR4OAC0iv+9TN31CtDmWWchAoYdrMs3qzkrYCfDqr0kbb7FupGk5?=
 =?us-ascii?Q?Os+vyWu6xZDunjEx+OsoKMOhU21mKnrXJSGxWut0LxYG2dkYPvSZwzcpu9Vi?=
 =?us-ascii?Q?xr/+F9gMEdXXXCoePUIow5Laxm2CpgvCU7McTlsg68Fz+4cQXYo15Y13u0O/?=
 =?us-ascii?Q?G+eH89PywT8lqobDJKeYULiXA2gtf9t5fN+/9nYkdJiEzi95WAwBC4JecWxb?=
 =?us-ascii?Q?1hI1sPYKsdNcExRWKW3YSE4GFWPFrco5CLP9O3bAJv/ltj7eNMGbUGSitysL?=
 =?us-ascii?Q?fcotc9snIHJX8Gw+Zh3qsnYyprvr62hWFNCfYvQD8ilGpja3SL1Kmdjj2T0W?=
 =?us-ascii?Q?CfMoLP8pn6zGDNLOrgsjiF5FNKi7v5XVXKbBqpXUtUpbYj96qck0TxqpD4+K?=
 =?us-ascii?Q?bd5oZjQxbhOmM1vFNAYO4TYqq0UU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HCGvMMJie/BoJbG1avmZ+gGipeCFN9zzLai4EKJIcU1qzhq4no320MpePWJs?=
 =?us-ascii?Q?yUMum6HFqluTXD0T0sdghmDE/vpnH9t7/4uzN84jcugGurDyRldwESOoDp1n?=
 =?us-ascii?Q?BWU6tDKRqFn1A7l/89S/0VTj+X5ZO6RH6UpGMg6sp+SVkITjIFJIrkG1EV0R?=
 =?us-ascii?Q?H5qd9HEQCBXDK3rOHDbcCb+ukn1EKII68MS25UX64lDFWj1lBpbTtYOOK3cM?=
 =?us-ascii?Q?/5A2w+D8uu3PMfC/3US7PLXeix/91msbM727UYp+WOGiIZcPM7obyBUpjVKv?=
 =?us-ascii?Q?O9wgmrSl0rcfdXil1SSNBcZrkC4pyFsj5jRfeVUWX5JiwpIIa9TqjrDz6ZvE?=
 =?us-ascii?Q?PWEXgrwgJUzY/o45xEl7V2COasuWBh8Nk1G8fVAHIirQfQHZZD+ZXu4VT3PW?=
 =?us-ascii?Q?uYbfNv8eswA6MnEF65RKblI1C7UpYZ1qWqeT3ENEzrx4uDzdYnQdXYh+OZXh?=
 =?us-ascii?Q?NoxJrSYibxYg3bHDkW+yegp9Nt0L1KKSfdSmnq646Mx8syJe0w9eH002byno?=
 =?us-ascii?Q?suWqUrRFFR3MM7TrQ6zBt+Enlfeggz6rGLjR6Khi9EjtthfYuOD8VA9YkloS?=
 =?us-ascii?Q?DnELDSPI6Th/Jzrha8cGiAGzjSaa6YkCBGxqp0Y/BUnRNeWiIAcGhpuSaE+K?=
 =?us-ascii?Q?WsA0r0XBUTpElKZHu+JhUO+EmNUzNM5cZ5hWgj0rJ4nCDhBJTXm3ZmIOo4RB?=
 =?us-ascii?Q?vDR9FMAdyHFAsTGVEiVC4B8nFPanBX5rRzvrDVG1tPNqG+y58SJ3i85bcimc?=
 =?us-ascii?Q?Lt20Gbw7PxmKXCA6JVL+GuFy7ApoSi9ILmetuFiuURX9h00jJPefo3OlyRbn?=
 =?us-ascii?Q?RlRgCiWlS+i1uKgNyEx+BGoiLA2HohmwzsgQAzZiELFtYfLGSzWAJ99jE77m?=
 =?us-ascii?Q?PuIya4JOTuWQ0AxSUpoiwq9bmCGxr8rPptn2ZpyGiFXDT7FFOTXJq83If4i0?=
 =?us-ascii?Q?kbG5SnueAAsU7IASVsXyqJNAf6VdE3mGQcVK7SIsrzKzayatgFe/Ca/6idLp?=
 =?us-ascii?Q?N0Y2SNnaSt0CxRw09dj5Pz02KH7eWiB1AdIbT7ZkfARqjeaPQBp2vypDSoiO?=
 =?us-ascii?Q?MokI2NcCuEdJF0xIVfHIxDV7zXpInon6/vFd0+jML9lhEiffBpzHBtzgXxZr?=
 =?us-ascii?Q?px1VaQ4pA0x58gqcRG6EAh6i7LMVmxvEBinKTJCbcG3XYt5FLxIGe45Tr19/?=
 =?us-ascii?Q?IzzFypPAb9hv5j3H04myG3/J5DtPnSglVzeh8UjKQ8o2nmbGhsyLE2AoJAhf?=
 =?us-ascii?Q?D3lwt88YSB1I6YBS1Wtb64TRiMuHO8LKLEjOfyzK1Hoa8nAkmGfSw6GJbovG?=
 =?us-ascii?Q?gBDT2bduf1xAYDNz5OhHYvRAAsq+8btibWkTCnlDsb3gsIM15h7RAgHTlq1m?=
 =?us-ascii?Q?bsEdNAM8BR5hFgNBW1bd5iBPPD5RY5nLRB0bZPTTJ0YxZiXxHpJjwn/MdhAk?=
 =?us-ascii?Q?fsVr0qS7YwfqmanHACeJ3AbPKGf3x6ehcj/dFCdh1wl2AwwWau/E+gK7GA/8?=
 =?us-ascii?Q?JwibH0EIIBhMaK9GgfDW2XGzkUb19+ix16TVwqNfJkoHupahLP12D0Q+s/W3?=
 =?us-ascii?Q?BDG6y8iKo6+Zq7h5nNmHLB3jSiKmHD27hOs045+U29nZbayoPYvILI/wYE6T?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c04892-ea16-4fe5-3d55-08dd479d5099
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 17:31:54.5492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HfhoInNncZRC8nHlIVTs7jZygZt8l+OeItskhZLPqbHLawmsXS7O3a+Y4AFQH97A6iwo5qv2e6y6PEYiTDJTFk0pHzM3zpqccK65Ak35LFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6987
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

On Fri, Feb 07, 2025 at 12:45:28PM +0000, Anatoly Burakov wrote:
> Now that the base code has been brought up to date, update the docs to
> call this out.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  doc/guides/rel_notes/release_25_03.rst | 1 +
>  drivers/net/intel/e1000/base/README    | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/doc/guides/rel_notes/release_25_03.rst b/doc/guides/rel_notes/release_25_03.rst
> index 341fdb9a37..82d72714f1 100644
> --- a/doc/guides/rel_notes/release_25_03.rst
> +++ b/doc/guides/rel_notes/release_25_03.rst
> @@ -96,6 +96,7 @@ New Features
>  * **Updated Intel e1000 driver.**
>  
>     * Added support for the Intel i225-series NICs (previously handled by net/igc).
> +   * Updated base code to the latest version.
>  
>  Removed Items
>  -------------
> diff --git a/drivers/net/intel/e1000/base/README b/drivers/net/intel/e1000/base/README
> index 5d083a0e48..2a0696f3c4 100644
> --- a/drivers/net/intel/e1000/base/README
> +++ b/drivers/net/intel/e1000/base/README
> @@ -2,9 +2,9 @@
>   * Copyright(c) 2010-2020 Intel Corporation
>   */
>  
> -This directory contains source code of FreeBSD em, igb, and igc drivers of version
> -cid-gigabit.2020.06.05.tar.gz released by ND. The sub-directory of base/
> -contains the original source package.
> +This directory contains source code of FreeBSD em, igb, and igc drivers of
> +snapshot generated on 2025-01-24-09.44. The sub-directory of base/ contains the
> +original source package.
>  

I'm going to reword this on apply to something more similar to the other
base driver READMEs, since a) it's no longer a driver from FreeBSD and b) this
README is already in the "base" subdirectory.

"This directory contains source code of the base driver code for em/igb/igc,
with this snapshot generated on 2025-01-24-09.44."

Regards,
/Bruce

