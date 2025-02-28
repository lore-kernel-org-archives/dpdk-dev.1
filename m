Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771D8C19776
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 14:13:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A586440E32;
	Fri, 28 Feb 2025 15:13:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 2DEB340609
 for <dev@dpdk.org>; Fri, 28 Feb 2025 15:13:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740752028; x=1772288028;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=CuRdy34d4FUeYCtrR+IMcZiD/Xu5YbMmfS64i1iw+Cs=;
 b=Ihv0/WDWO4nyKwt2jkinDgCjhfaEdn15OhbKpwy3WsBzy2beIn20dzpP
 FbostFJzVX8Ei4EdLLGJ1Nsqx813NMXcJLTppmZ6xqX423beSmDHaKa6q
 uRJcsMBHOr7SSt7GpZgrihLWm5L6TKCe66Dd3ffJ6JjoIKQibNm7nLXQf
 WjrBk43dOTBqidxDwRyaY/Orfqamq0PyhkWquakhYIud73Cac3PGbC7+R
 Rdmwr57WzcD5haKjIP8/HFllUZVPm0Z8LpnB5maQnJlqvzX4UwcUzKE0o
 Bi/3kY5Dq4gOGswq3km9RShehfqHSOzPUgQnWXSIR5PtKniJ7J7u8vBW4 w==;
X-CSE-ConnectionGUID: aqtetP7NQia8lhuvIm/9EQ==
X-CSE-MsgGUID: XN8NSDnTQqW31YnbiYbnzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="45331925"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; d="scan'208";a="45331925"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 06:13:47 -0800
X-CSE-ConnectionGUID: WNITSDghSw+XTKGL7zUEsA==
X-CSE-MsgGUID: ENWXMkC9TaCmAqSWfRw9fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; d="scan'208";a="122354337"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 06:13:48 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Feb 2025 06:13:46 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 06:13:46 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 06:13:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Imnudk2MT/YPoJZh9+ZHa83Zx1Ji4WI47z4tirRRbgL9ZpmbC4X1COVYgtimtl2u9hVOE7KdFQdlUb9dthWG8JBDGsDCNmZUGFiC4CEfhW+P3tCh9XxWpBQpvetHQZ1agqfs6OcmjA5R/AneI+GGHNEiA/HdfDbf3ym+zImJeuvCExZIi9/XS8KNRdV54Vu528RYmc5zflKhoA634w7wMlt5SHwUdq1LbMRC4aIHT+idFfhsf10+U8mQRjbqedVKL5+S0GkHL7Hlk6bH23e70UcbmtyAyXR4radeib922uCxwG31Ngtl/v1sjNWGsp9PFQureSGjGO82ItQ9VgTr8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOL1N9mifsJTHdH1890wYJbDMIMv1YAVTrWsPH6ff3g=;
 b=Ta4rvtOqiFtlwWtvZE/Z1wM8Cyh/sLAnJL8lEux5OSETvOP9bDHj1keiAD5GVEsNmAKkKAbsVcJzpKhs+n/ySEPitomgEVOFYr2mzQBQwyCd7YQpPwY/Qa8BWo+VhlhcvJrUoX7G8JRyum1JLQcvCU9k4fCE+jr6dsma0BbKbaASb1+/h8uMKaAr7EUnrl1I+jwdq8J6Vt8gun1wwu0g5HYpieXjpSwcb/T0mgr9eCihCmXgVSyvBkyAQiTHG8thRG0CiOpcvT7Q91lnwxR1ELOlPAVjqWqlcprestEA9nYBiAWagFELOm9zGyWnRMxWMt7wcp8at7l7Bc19lGKftA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5109.namprd11.prod.outlook.com (2603:10b6:510:3e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Fri, 28 Feb
 2025 14:13:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 14:13:44 +0000
Date: Fri, 28 Feb 2025 14:13:39 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
CC: Mingjin Ye <mingjinx.ye@intel.com>, <dev@dpdk.org>, Anatoly Burakov
 <anatoly.burakov@intel.com>
Subject: Re: [PATCH] net/ice: fix ACL filter uninit
Message-ID: <Z8HEkw-nE2p_39vB@bricha3-mobl1.ger.corp.intel.com>
References: <20250221082510.332677-1-mingjinx.ye@intel.com>
 <f820a6a6-4332-43f7-95f3-96d40bd3bb6b@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f820a6a6-4332-43f7-95f3-96d40bd3bb6b@intel.com>
X-ClientProxiedBy: DU7P250CA0009.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5109:EE_
X-MS-Office365-Filtering-Correlation-Id: f20b1463-29d1-40d0-1114-08dd58021bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bg+2PcAks5U9Z+HMdrFaJk2DxtwwEOK9QXBUiUWVk2V2N8zz4O8AsGlg+Lr4?=
 =?us-ascii?Q?0uAFjAfrbYky/wrLD69LY/Dglh7bhBWpe+aWCVGBXBXcVVPy9JT8eUho+KVy?=
 =?us-ascii?Q?Ugx5nyzXQdWg6kj7YooZUR4s/zWNgyry5yWqajJmDwIwh65wwk7xk444VElM?=
 =?us-ascii?Q?SJOJmL1966gh+k6nQgg4IXwpYJ2qTPUtkiW5hi9JJnIHbkTmvb4rFIRUmLmu?=
 =?us-ascii?Q?T5eCjTd9Ws7740wdDxOaLXcFbLuP8Mmajbvn8s8TzLNhQb6d+7i0I1dRBSm5?=
 =?us-ascii?Q?MkiHjaWtexqhSPq9mUpvGKbaFLuV05kDF07lTeUx8r4ytxtLOWhOPiZCqKYx?=
 =?us-ascii?Q?4P2j8mZwCEa9LFw9ieK5/4ebHLX07tkBOdw6BDCl2oo/ZNCRv+jXwtaPpoAi?=
 =?us-ascii?Q?LEmPbAP1AhDnxM1VlhOVmBiYSAOnbpXAaICO9bQ2pJr7ISX+bCSKosunz6wl?=
 =?us-ascii?Q?wm0VVZrXLbBvBS6lw/S3fXd6FJBNwSgyjiW6VSHKXuNBWV/8zXJcymV/WpXp?=
 =?us-ascii?Q?JFO5WowjI2XXSP5VmUXEmp84++KvaRhH8ljQtG1CM51k62RaJOObJ5qSUexD?=
 =?us-ascii?Q?f8I3qcmvzZNvNMbqIvKoosuS5x6rk4RBPC9OXkC56BqurQDb+JtW0LfIgYIF?=
 =?us-ascii?Q?EeCUNRo1N8Xksf/p2B/qaBBm0ctqrhMNcr+iDcYNIGaq2ffAuiav+5PYRp43?=
 =?us-ascii?Q?euA3e/ciM8lx5TZcP2Qn060JnaTTC28scAEqM91iByCcFuzfTuXX2Qa52Vqg?=
 =?us-ascii?Q?fDRRnSybVkbDfPfbwC8IpEF8LbTPruvIDowoawnDOhGnbTsQms7IXpOZA8Cv?=
 =?us-ascii?Q?jpz7waYUjZJk4iUk2IFcOckiRBaLQmSK9a48r0dZhAvK3549a3QoxHSO46gB?=
 =?us-ascii?Q?Lo8gGmWxWGIk50E/ocQYMT5GrHRKbckP9mLVb9cwXEyOujpZCD+I3qw1GVa5?=
 =?us-ascii?Q?3GqZCILaqVVgVKmO+yEDtREklQbhkkLF9+9eJfe4+m2a+hv9dE6GVcKNhill?=
 =?us-ascii?Q?F7yibMWBII2ZEl0KHLle6rFkqC029b+wDkO8VVop39xH9JWr0QTXPul8M8os?=
 =?us-ascii?Q?8jY9UljBg6i6tmqDmrlgmRt7c7MsmA6E3ekNGjRUotKtJaQGXbQoVZkkYioa?=
 =?us-ascii?Q?o1Iz3da87ispZLL41zEoeXhTkHUcNAOdPLFF4nmnZ00Fpz9wfWXAg2lhNri9?=
 =?us-ascii?Q?Fcfg5vV+6WkucSadPvBHEirFY4v4pyrdql+OzvvTjJPaiAOQv+RHjTYOWCwi?=
 =?us-ascii?Q?AMU0OYO7XULunMXYjh4q9qrA5dhmsK5a5ZQ6cA3+ovNOmeB26aLGa25ZlzNj?=
 =?us-ascii?Q?Fr+FArPaFk+cfFw3nPNM3OuNoc6JjfRUPt6QSaHrZJwYgU9zi1nPYWNuicnb?=
 =?us-ascii?Q?oK5DVZ5cM4vYv3ovJO7Ga81hkZRC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YPWNuVY0YH3rnOw5W9pGzUppyzJVRNR0GXDw5eyp5r0HMYk7RPYpEvIIg15/?=
 =?us-ascii?Q?GkWXe3Dhx2EiMwBawz63lreqaL/fTxIn9w8uQGPg/drshgs//UcrpXH2HYlB?=
 =?us-ascii?Q?30XZYGYRXSTsxuf8cfdpVWiSx5xRf0/Bbd+0QuJhj3mb/ONcXmcFfP6Y1h4E?=
 =?us-ascii?Q?Y3TH1QuAoW49c4IIKZvMhckZ0aFz5R+DT1bPmWrLapIos3Dur0MZt3gKfQ4D?=
 =?us-ascii?Q?C6IVwVb0NORysf2bDpNyYZ7o3jQY+O88pCuMwURnAqLo13n57bu1jAgSz2kh?=
 =?us-ascii?Q?NWC4xJFInDzQh/G9i0XoySbMPiaCSGLBiV4AwStmqItR5nPrgUof+8mmxyI9?=
 =?us-ascii?Q?xxUUnVa0tgvUCODs9AoVYKBxwC+KTxFOfBnlca9GacToocR3CcKQxfZwiOl/?=
 =?us-ascii?Q?QteCTx9fqmPxjh+ixnhxPaIMAL3YtsKf10bqJ0H9Ko7uW0ZOiW7gunjOe9Vg?=
 =?us-ascii?Q?cEbwju5gZoe5GwePsl0QJwc2XekAwXH0he8AMopQ/BgDfIJ+mKN+5x4yW33n?=
 =?us-ascii?Q?jAM9iE02sAx7PlMN9pb4Nmyq/GS8oqQa/UCHBSuQcm+J5NNv+kainX7aVJ9N?=
 =?us-ascii?Q?647zhdU6MW9ieeETHuMj76bshQa3Cpb/2hgs06NI31Gi3h9mBulRIPMGYWbx?=
 =?us-ascii?Q?3rDd91m4tDoD1vPzhWlF4Olr0l+iniVtVdHg80y+xWl77A51RKXgmOtrO+Qs?=
 =?us-ascii?Q?pvzKC0pq5YpIEt+keI89TJretKUcJNmr26LjrkDamh7IsjElMVGO3MbIn5T4?=
 =?us-ascii?Q?sirfo3+ohc0HD5pGUfnFCurwvA57scfOYSOGhktlJT7KvkegU1xeWQ3mSYvW?=
 =?us-ascii?Q?Tlvwdhf2axRvpmAPIORZWHwe9NdVm4oyriSJ3HqUODwUe3RCa1fDFoqRTCpA?=
 =?us-ascii?Q?VsAuxFdZYsXRk/heaPtoO1HdJhGUMmstq0WsPH50SfPF/PX9hWXgluR7Mk8m?=
 =?us-ascii?Q?Knj3LlrLU6vNzv/SBPUgGxCnzVgcU0dWr1oPvVtanzoBFjkX1jlhNqR3QVtR?=
 =?us-ascii?Q?KMSZmIZyEWRShgzN3Hq/ygwGj6cdE0ASbwdCdggCnap2l0QUIcJFslMQl3bW?=
 =?us-ascii?Q?aiyNfgiRnoPBxr4NVCSA4l2Gdt58wMra3pGpXRgNRinmFa/W79dV6AGpSC+W?=
 =?us-ascii?Q?klbt43OB/yP3cowIYdrnQLioSOETVw/YbB2caY7DkrjsoCelobxcl+cMwcz9?=
 =?us-ascii?Q?L7XaxBmN/qJVQhd0gmQ9xJrsL0FTKG/mOiTP0uwSUpSdKL+WIyCGswL11ijM?=
 =?us-ascii?Q?Hx8uix7DlRoQy50lVk8FTPX2NSG8jXL5V7REvHSgbJRh+B+iMUIMjH7opYzo?=
 =?us-ascii?Q?Lhrxxk72yGfEjFZoxUn5mOALNyZkaa7IQSOHN/ZRuEI2EPMlDLCHbjvgeyap?=
 =?us-ascii?Q?uOvF1WxU5zIX6PoYsKOxHvm9J4Se0QmsoeHAJ5lyCZ7Pb/UGPJq58OjRPuEY?=
 =?us-ascii?Q?6vrV0ObaPmeajSlWaAoEm3tSCd6Ba98Zvvtuh3Y/ahICxS8c6NqygTjOCezV?=
 =?us-ascii?Q?3fbHdXc2T5iiknrpphj1Mckuetg6fo9wM2DLReW7kv3RzwCLMzP22qmDgLJ/?=
 =?us-ascii?Q?QE51pHwhacRQ3WLcwifQgARf8f249LGRsherKM60QBkn8bYqstr17Z97LTjD?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f20b1463-29d1-40d0-1114-08dd58021bf5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 14:13:44.0577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFgSYKRyFRQkklzo3aCxAS9fk9ZQiltEaX4aceYXvHrVckrSye2713JogmFJyc5eX45zj2zLF21Y/SMYRnjY/6KPgFX/WZHPn3fn6FI69mQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5109
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

On Tue, Feb 25, 2025 at 06:16:36PM +0000, Medvedkin, Vladimir wrote:
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> 
> On 21/02/2025 08:25, Mingjin Ye wrote:
> > The pf has enabled the ACL filter, so uninit is no longer limited
> > to the DCF.
> > 
> > Fixes: a9d612291c2d ("net/ice: support IPv4 fragments in ACL filters")
> > 
> > Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
> > ---
> >   drivers/net/intel/ice/ice_acl_filter.c | 48 +++++++++++++-------------
> >   1 file changed, 24 insertions(+), 24 deletions(-)
> > 

Applied to dpdk-next-net-intel

Thanks,
/Bruce
