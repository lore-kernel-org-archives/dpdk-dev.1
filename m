Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1DCC98321
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 14:52:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 941F3402AD;
	Fri, 25 Sep 2026 16:52:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 8B1E540294
 for <dev@dpdk.org>; Fri, 25 Sep 2026 16:52:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790347955; x=1821883955;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bpdueRWFPS+jRzHcX0DgKW73gKbH0kRO9c4jjLpv3RY=;
 b=FdoRUxDZxfHlw5RirmrabttT64ha30YtjdEJoxp2PRZihMUHKl2LCgEd
 8zKUKjwYA35Q81eKmoMH4pVkONUjVNX/rSirjAGq9B4vkz53YRxz0iqA3
 qwLdCftrkef5eYQTSxXMVGFDiATL/S8cxFTsXO9xqaJdDHHs9fKLATwwP
 sfKrVsGYzcVyu15Li4eg/O++ABOJodltjCJRn2+09w5lKe/48RLRgF1xY
 v9u8QFi46nlcf5X9e8+FCg3idvukGnKkRArDMhduHmKuNk+ShIQfY3Q+A
 8Y2O3hydwIiVl9TLbHxvL8ZhIIyDoGvAHGP8PMKXyl7ins/MUAbkzhPZG g==;
X-CSE-ConnectionGUID: 2Pgp58gnQjKg0X0bW7hWjg==
X-CSE-MsgGUID: 5AptJUbbQBmKN1MKtxAY1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="101794448"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="101794448"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 07:52:34 -0700
X-CSE-ConnectionGUID: YTJobrvcQcepQKjYuBW9Jg==
X-CSE-MsgGUID: /q9iKiEiSxe+lw90gtZRMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="272491415"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 07:52:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 07:52:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 07:52:32 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.23) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 07:52:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A42ursjGwqdmV/DcYuxejh2bjUCpkBJLAFvJRvDj0lduWVffu3D4AUQhth7ZesNKrbBVRmTm9I44kE/RniKxdMqFuZC+WEj1NUe7+VAkSbLns+/UrmhP5kkfBoTDQEwmtuxavRTBCvLuUZ00HDbb9VrEt2yo/LYJADkhvJXceC0fTXRGo1pI/D7JChAgncTnXTkwrDkBgLhCREKYUgL9NPQyKYnpOSyLKx/+yCBKBPVKGhykLNlrxX+preOOoc6YPlywFi+2cIXV6+8easCNrYibWuOjTpqOFbFZMiDDQinD19ds5+r9T2JhcSR7eCa+dIJfg6iPTrvK3JT563dJXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVUi2FPVoUpjKUPyXSoGtz3JIrS5f3vGT3+T6WIsj58=;
 b=bP8iBYOhgFFrnDYjXY+K1KgAxVbzrgBjtX2W/5dTyF2Q0OwmFfTtH8/tPmlA/3S/4qQptbR9sI6M3G45Uk9LM6ImUM6/uxRubjHt8BAv1f3toWt/h5ik70CXVbXs/3cQoqt8GlvpHCGR0rkB2RI0U/xCoR7bvyh1UoEVQaJVfTaDnYaCv//XeyPi+GgsV2FeWJaPAAYqAlpaTIy8G/IjMDsNcnF5KyQiwG0DvTYgEc3la/DLBAbnOixqdQSSvqxSJNm8akyzi8jrL26ZHMm2axWWySrH5NCiLVEsMT/76I6EX0H3701sE7l6m8Nz1CAAftzRTcFQGBpO9t9AWA7rJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH0PR11MB8167.namprd11.prod.outlook.com (2603:10b6:610:192::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 25 Sep
 2026 14:52:28 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0428.018; Fri, 25 Sep 2026
 14:52:28 +0000
Date: Fri, 25 Sep 2026 15:52:22 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "Burakov, Anatoly" <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Mandal, Anurag" <anurag.mandal@intel.com>
Subject: Re: [PATCH] net/iavf: fix dead store on reset path
Message-ID: <araKptJ5tfg3jG4V@bricha3-mobl1.ger.corp.intel.com>
References: <20260925085832.6780-1-ciara.loftus@intel.com>
 <fc8d48f2-d451-4113-8c25-ba1df670cff7@intel.com>
 <IA4PR11MB927850A9B5619F4035DF06A58E802@IA4PR11MB9278.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA4PR11MB927850A9B5619F4035DF06A58E802@IA4PR11MB9278.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0294.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::13) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH0PR11MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: 589a2a52-eb58-4804-0e31-08df1b149e5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|11063799006|6133799003|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: lSexOa9l3RKUPSP3tyjFJSGizeu4glutW8vpVR9obEHrY+5XQtBca/jFMMFFq5ZN1kN7dtdmBccMSNFd/h3nlBxRYXaJIhFWgSHmx+APcubGJNrfmbgFYLynbESML/Zpuf/fE7k23oSSBAQYe4vdzZMS57bfjlRdbjj0jzWV8GNIY6ib9q7UkEe3vrS2r8AByJ4pTjC6y9fxXj26gvfd19sWm+i9awVsG7H1QKwJaKF/6vhXCxahFVNQ/U9gstFfcKwfWOuWMpfrHDVdZ13TKXcO6O/dW1ZtJWKw9dTQhnNYwBrDlV1kWpXUKm+khgzD4Yk0zCt3WEnkpIr/yiHR2QLFUv5S3Igww3WXRTkedXoLL7i9z4DVaiw83ZMwO4h1+wuQr97tRKOo2gZZbKjmrAsrl1nRdIj0B/jsUs8yjEs3OlyeCE60Cd4opIitANDkw+TrImdJy4aM1qFQAfzA4pnOoAIlDV/eb1rHu/bqTv0Zj1QKyKkmPwm9aTpZSAsLzMtN/0QtIVCRGoqhmiJKo38wkeId0O6wDyUVErL9Q4rQPfKAGyjXScmnkWDNNj6Y40y7Gvm/U4zzE2miwSzomVKuK+KNqfE55n9fXEPQM7ubdaaFGuvbRGqEyggugZFFaGFN4xSnTU4OtE0Bu9HFrRqrvbrtkzBYOj483ZKdWJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e5W92NClI2gwIl2wJ460KW9pAoln2QGyyKz/za5PRfMlHkV3lNIpT23LsRUA?=
 =?us-ascii?Q?fs9dpwzwXuoOQySwqxEf0Uvk/ajimIaTNKhgxr7YC+exY+tHsc0y4KwlbL+T?=
 =?us-ascii?Q?reqv5rWOjEgnzqQBHmIpsHE0qV6DsI5XmLz1lzLnSNtcrys7a4AjUUaCxeYK?=
 =?us-ascii?Q?uj6K8D1TCZGXvqEO6dEcrQFKpxKH/41Rp7GTIu1Y2nHEDg1HdfJVt0pkBpnp?=
 =?us-ascii?Q?QS3eR27Z+s4W34FZIYwYkKddlzYdFGCnWKWRXjBOV5jj8iKfW8TxlMzVlT20?=
 =?us-ascii?Q?hkr7UMy7TRZKo0A/bfRYCmLfBvWleFKm0RH4WHZwghqnijLXe9KcEZ1NwJUS?=
 =?us-ascii?Q?yNAmwZPfDbLwpcnLvciW9WJB+Nm6SVxAdUVgNNPFqSKA39IM/HRPXFLglNJn?=
 =?us-ascii?Q?gVJMt9IxJGrvPcTAiQLtYWcV2+Okl/1yNbMdgMOX75aWZ479cF3S8X+G3hlS?=
 =?us-ascii?Q?nMeIdWD0LgcADWZGRhnHRylKwRAIHO4QDd/v/XEB1YwDYXWil5hTLm3VzFcm?=
 =?us-ascii?Q?AZ9ZhrCc76gsShc7naYc38hKtPrgLdgoDBjvbG8NK4LvDrYvSKKUJwY5e9yf?=
 =?us-ascii?Q?7/0+k87gO3/X9bXyLEUbGcT9n1W0GJdazeeoSf9bwqW1lfKdPS5HG1p/qa8F?=
 =?us-ascii?Q?QRRHfW2jij3Hd5bZqyDSndyyPZy/GeFiT4IlJZ+h4rv0v4MBpo17EIzmv0Uq?=
 =?us-ascii?Q?p1AGWjfOKndDe734AHNMnkz5I6OtcUb9oriNnYc382wFKRjQKyGJGd3ukSqF?=
 =?us-ascii?Q?7jvsWYik+DVBIf3rWQXIc73lkVF9TUr+HCpMc2ufSN93kGx1ey6PEoGKhkcY?=
 =?us-ascii?Q?kvJvc6AMftJzXCeAOZfqMKfPTwwO+Vxbdof4S/wKj64rZrs55yznz7HWvkib?=
 =?us-ascii?Q?phLju4NxD5Kq55bjMeMOLbP1Ey15e8agQ5WStQBMmXTdkFI4n0FLWLByEDUC?=
 =?us-ascii?Q?IZSEg3avAuDt49bqlM77YQZ7zTaENm/NBEbeFjRtkOTCOZJAIxMt8jDLZuyY?=
 =?us-ascii?Q?PSnbYsWPDoluRC1malDLfP1OLt+i2kqEkhpSbMdmjqNDezc+uahDykKTHtq2?=
 =?us-ascii?Q?nX9qP7Rht56DHxM8K7x+UrRO8QXGfXmJqS3JAj6iNE7ekju/4cfyFORbcqRD?=
 =?us-ascii?Q?pHouOFRgymIbKQ7EyTVlpdZEP76ITaYY/7FYOFMPqmcUL/GhZ6G7BQxwlh/M?=
 =?us-ascii?Q?y11jpelfdM6vFKirPbNLTL3/UQAQrF2Bszr4esQxFE0JwMseB8qKKidwf+AI?=
 =?us-ascii?Q?OrGe7AQY8D05oz0P8WYLIc2r5fs3q12EutlyeIntG4VaQqPW3XsxYv7gIAsZ?=
 =?us-ascii?Q?lbcUN5Y9p5EtoN8s5ckGeATtPbiLjjw15NDfWwhAGU5mxa03C6YyChn8jTIk?=
 =?us-ascii?Q?3mFnmcbEZyTPOEu0qqpAIFJyKvS5x/QZjlyUNfTBOfPd9AEfvO2ay7Z2ykHm?=
 =?us-ascii?Q?jdXxMIBMQ+tSdI9yYb/ysrmxFe66Jos5qOPfy+ELDL3Kqpt5uF2S4qy/oMc6?=
 =?us-ascii?Q?E5sV436Jh4Qu2WkVz2zMATSEFX1nEJJlhgF8DGGS/KLy2RjMpRlYldFpTFZP?=
 =?us-ascii?Q?vOhrXmLkJPDz5FS8yDLkVnuy8vyciSs6cTYXDW3SkDbo8lKI9DAT0SQqs4OX?=
 =?us-ascii?Q?IbvuVD4Z5t1yWcSMzLVmuk5v/T07XyRVu/3aVmsC1Xdwd1LHl7Mm+oi5IWjv?=
 =?us-ascii?Q?rkcgVlwK5v6ileihdrrfWLZmsr5c3KBxFkZOQKqwSW0VreEOgjzt1EJ45Ibg?=
 =?us-ascii?Q?6lzMYIZ7lAxgknZ2BnLJuzKWaqpiAfs=3D?=
X-Exchange-RoutingPolicyChecked: 37gMncCLs65DNmIjIsSNpcsHrn0gpTe5XonSgziQ3OR6n9F4Ue7MbjThI4hCI7PbMkeK+GMYNZtrIgL6FqI27GDNslSw/zVIiceySKx+2SX3Eh0SSOCYd4eFRSdE3HbT6d9oOgxgQRda4JIqjyvLAUwyAilhgGeCY0l4m40yR9dJ5AhEDm8VwDULZAGSta1JV73S1CkrNjor8whGZacQvEKsSR7lM/J29RIUqusMMFPU1eZPx843A16Z9bquscQ0iH6S3Uc2bg524dlyGnSDpQN3j4V03bRzER64hM9297mU6RfYLtRMOvdPM9caohMqoNU6gHaTwiX3T+HQqa5fwg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 589a2a52-eb58-4804-0e31-08df1b149e5f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 14:52:28.2544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PN9F3SfUporgFosB19AlawW1ynqk14WAX8v67OSiLtchaMimUReSzaNkzWUmhqkcxfRg20k6Zv9CU4H41lzrYOqVLYC/WiZvo8e2zmeJTvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8167
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

On Fri, Sep 25, 2026 at 03:33:08PM +0100, Loftus, Ciara wrote:
> > Subject: Re: [PATCH] net/iavf: fix dead store on reset path
> > 
> > On 9/25/2026 10:58 AM, Ciara Loftus wrote:
> > > When dev_start fails during reset recovery, the code defers the start
> > > to the next link-up event and resets ret to 0 to avoid treating this
> > > as an error. This is redundant since ret is unconditionally
> > > overwritten by the return value of iavf_post_reset_reconfig()
> > > immediately after. Remove the dead assignment.
> > >
> > > Fixes: 9aac2219dc2a ("net/iavf: defer device start when PF VSI not ready")
> > >
> > > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > > ---
> > 
> > I wouldn't really qualify this as a bug fix except maybe static analysis
> > tools might flag it so perhaps having a Fixes tag is worth it.
> 
> Apologies this was indeed found by static analysis and should have
> included the following tag, if it can be added on apply:
> 
> Coverity issue: 506150
> 
> > 
> > Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > 
Added the coverity issue tag - because otherwise I was wondering why we
were bothering with this - and applied patch to dpdk-next-net-intel

Thanks,
/Bruce
