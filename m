Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F4BC54FB3
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 15:10:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B00AE402C1;
	Thu, 29 May 2025 17:10:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 12E7C4021F
 for <dev@dpdk.org>; Thu, 29 May 2025 17:10:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748531412; x=1780067412;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TxAD70ughZ2zvx7itVMZQlS/Yat0iGeaX/3e2kbAx6k=;
 b=RA+FJbP27ARZaqfUbzaSEtfn/E5azSQ+rwN+9kF3kEk2t0HM97ArpATo
 D+HUSOrtohsjp4QmhhwcYONcjPPJiPsdukuCR8E5lSAv1hPOd4qTR4b5e
 wR1Iwzoix/z7sX77y05LixBGKmKDyLHF5gfFKTuADBkDpD5n9q0N4iCvT
 XsBGc4t4E9yIJyTNQuzCXWQudLDF5Konryu+riUQfeucNSRL6CNESpfHe
 /D41YjmEIZ/6uYHpnFos1vydlJrbe3q17rdGcfE7k82oyXYsK3NEPxtR6
 1s9X6ntxBzd2KH4ucSBOUEYg7AU5ZS6JfbQfh3/yASlB0FP+LwKFjlKq7 g==;
X-CSE-ConnectionGUID: BgnEIu/eR9uf3Gv9niwxWg==
X-CSE-MsgGUID: CzKa0G25QE6qzyhV3Ju9bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="50652311"
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; d="scan'208";a="50652311"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2025 08:10:09 -0700
X-CSE-ConnectionGUID: BXybdzo2Qn2Ev65ImKqYLw==
X-CSE-MsgGUID: lEvBFQ+8SJaWZxfYtca9QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; d="scan'208";a="148746631"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2025 08:10:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 29 May 2025 08:10:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 29 May 2025 08:10:01 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 29 May 2025 08:10:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUD4bN1/XYwIdFvQPSDAN7QL5Ro+gnNo39sVXtV/Z4YgBAAao2ZWAy+JA/iVcvrl+h4h/tsPBhnvjYxDERUpXsUnLQtmaV3HPkLJolSvyBKCas+qs3yV8X6FrtDAa43Bgczu9ODohS1RVTmv0Ueo2c8gkwBAsPttssue11763arQGrV93Q/NuoAkY42VrcVIHNWLpMYPLVjtEU6r4egsqtG0hpM8r/+NdG+lD+Jsd5JV8oZxSTWxlOec8XsvIks8Vs75YrA9s/Tuv0JizpTgF3YHer6/1Urkid/R1N0YRo/2XUDDH+vvlgzGfNqMWXPPd9xotSvtxz1xxFedXGk7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWBkApqYkTUInXH/VJEY3BeqTNN7opaob/FLdYt7D9Q=;
 b=UA8JMsBXRPkYN9IITHfJwG44mX385V/CkKHAN8U1Cj7IHoS/xFQ8MHrdOejw0xwnTqvx6q5DCAWmaRRJ/lJUYFr2Mg+Qv0mTFC4oJHVLQC/5BYAjWYZlcFy9a7KYZINEwsSr+E/xkWRXJ9NbiVakYxtvWa5ZiDTYWNJv/ImPW9JxsDoMRL1Qw7Tu1xaCeYJqADr3OXy6osTJ/N5WnPXgHTu/hXEGEmkpg53V7i1aIyceBKoiwhAI6esi1vLPmfFhscjC93NPf8CA12hMW82kDnNdcgwpifekNxwnUzSs0IPn95IjvqXm6b91ZqiV/oeqLPFypfh4NlqI6hQWTlhv8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB4861.namprd11.prod.outlook.com (2603:10b6:a03:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 29 May
 2025 15:09:57 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8769.029; Thu, 29 May 2025
 15:09:57 +0000
Date: Thu, 29 May 2025 16:09:51 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: Chengwen Feng <fengchengwen@huawei.com>, <david.marchand@redhat.com>
Subject: Re: [PATCH 0/3] argparse additions and rework
Message-ID: <aDh4v0_0TB13RsjY@bricha3-mobl1.ger.corp.intel.com>
References: <20250527092113.903910-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250527092113.903910-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DU2PR04CA0027.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::32) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB4861:EE_
X-MS-Office365-Filtering-Correlation-Id: e176ef39-0720-42b0-7fd8-08dd9ec2dfee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EzQsW6SJokoG1X19lVSG3+4RNsITg58/NsVl0ZB9zn9jLkymJV8+rwdFf9cx?=
 =?us-ascii?Q?DkdhQ9+lh4QY44Zb/u+DMbA3sBHr560paY3CBxKG+AuTycGfhUv4x7HtXs6M?=
 =?us-ascii?Q?KK5VniOBwRfua4KGvYRVF6LjB2mQygw9M4GtzJ+Ah0quJFR0KjWG9yDx9liy?=
 =?us-ascii?Q?TpedEUJ/LYxaZnnhY0QBgaiquvqPt/Nuq+BnZBt1mbosr3wrPu5I1sGZ5ucl?=
 =?us-ascii?Q?ReID/OdlDrsuYPfmVKv5Cs0GBEh9r/GBEO0Bv6U5OYZCx4KcQn+qv9cJevAB?=
 =?us-ascii?Q?eYVW59Bv4uoMxoJgCTRk2TFezwxtQkxfduJzvRv3p5BFnCinRi/K+ZB9TTWt?=
 =?us-ascii?Q?TEAlXLeF7a2WWcbDl7NEG9W48Aoz8+w43geSObWQO6ovWt69Am2CupuoIPbZ?=
 =?us-ascii?Q?LOQFD19JLsxW/SX6oBC2Hs+EmyP+ikeLQiNwsjWt0nu1Xxl4rCV/3uRYdWXe?=
 =?us-ascii?Q?LzTbER0SzSoWDwetre6paSJpxcpH/PYgj8/pHBlROoMvPrjZLDOKd+jpX0AQ?=
 =?us-ascii?Q?lMunvl2T00E8qhKwXnNkvD0jbX34OdLjaiusFOUcnP+ll3SYFEISeykXYUsp?=
 =?us-ascii?Q?rnzzu9tiCpMP4UZh61/xE2k6cbpod2cGHsW2TgnyCLr6YI0ZyCnWpL/i6XIh?=
 =?us-ascii?Q?ZPn5Bjt7QInGzYteEWFilN7sNVUtJsWV6T+koj5LO72fo76jvXe0/U/3pz/5?=
 =?us-ascii?Q?fiZ1Fcog5IqXggv0LTKKjnZr5XutbEgGY/lTVCdGHvROux54TQ58WT3xRwfD?=
 =?us-ascii?Q?IETZ+fbKsFOPtmVCWjjrfCGERewmv0PvKMEcF/ZnBRA/f2KH4aSSmhLrB+jE?=
 =?us-ascii?Q?X4FqODnagDnuzlFGTJDQUhrhzP7N45xE0LueY1mcTbDpsfkvyCQmNLMdc2LV?=
 =?us-ascii?Q?drJ2L0lnl8Xy/nTe5uITQV+UaBhwkM88M1XsE2XBcb2o8yq9Q+QzCT/0YNbn?=
 =?us-ascii?Q?FMovJyieXBSbcZXmvha7aP7trcXT0D7M7U1/R0cgwSeek2DylmufyKTNRj/Y?=
 =?us-ascii?Q?+k9hE6pgvOhpXa6jVnx4FT2lhuk0+QYJ9hyfRF65/bB7FL+bJWQ+CiE83XbO?=
 =?us-ascii?Q?6z3ia90sRfxzX519VKswLalrBFW6TdIpQAcUTo9A5I73JsJ9sxv2/+/u+ZmP?=
 =?us-ascii?Q?tzH76KMnFUUuwL0IXtQpAnFcawaHUkFjmeCMIe3AxusNbgc1CmtlguFV3BFf?=
 =?us-ascii?Q?r+wItP9S1p54VVFZiLfItYra/gG2zR98Sed7rb79eMIjRA3vw9c/3lGEcA8O?=
 =?us-ascii?Q?szX+MOwUPPhMS4wnkcLyRn0Yctho4vtpZWl5+Dtk2QtKwgfEm5qgyUa9d7Bh?=
 =?us-ascii?Q?jAQWiM8wm7Rm4JkekkDMfh02yIBcgpCaYbR6Ntw93jEv+vXOsCxae3MNgQ+/?=
 =?us-ascii?Q?GPI5tZuyDEYYkwXaSb9i6IytI736kiMU/VB74UU7IKZgd//v4DpCr9OyZIvV?=
 =?us-ascii?Q?xUWjOHQiIXY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lgtz7sWZ54nwRdcD+PU2HtMlevRN+Hpk0/tLRbr7hjTuIMVChSgvWLjl0wni?=
 =?us-ascii?Q?9kurO9v3bzIFWUtlacsloNjpKydZdKXGcQ99bJPJomnKQgxHLS1BW4aDxypt?=
 =?us-ascii?Q?VnkLFwd2F736eKVquuDVevdVXGdKpGPVcIgD2sXCi0Y3sLFfnipdwTx7geOR?=
 =?us-ascii?Q?NkyCn96OOFzljWQ1XdIeOvRSKgXocZsJ/YdGXKeg4lDQdygEisz5zCEBbI9c?=
 =?us-ascii?Q?smdpTz3n2PnkNfzRR47BlsIKAaAzukNtjfJ1scUykThwgyBiYsS1hTyMGGB+?=
 =?us-ascii?Q?2ZrnmGMirYuuz/Lk03nXuic0fXYagw+hfcxVqEixBLpReudPtbPw8UUjroQu?=
 =?us-ascii?Q?G+cAfuqJi/5iTWATPQUO6eH+TNrK7/FbfCJWelhSUi/KgXMJjcq3KF2dEzOE?=
 =?us-ascii?Q?yBQwm5ELIbBMVkzK/s4bZNdJPaqbBDcNH/cDEl2d0wMT+oUYcpyvilRZB2/Q?=
 =?us-ascii?Q?eqI/H2Ih0sv53wM11FQg/RZWooiCPhUQL+JnQH1drEbSdC6KvWN9fbDgkDTH?=
 =?us-ascii?Q?NlqN0rC6060ilzdNtGFA6F5QyIvY5ae30ir2IzR94Itwx5MXZKHFIaiHlzn6?=
 =?us-ascii?Q?nrHxzB2qwsWSAgrs2yLOSut7qKJfICdOfT8GwoTajTYzWLo67bPDPb9zHMA4?=
 =?us-ascii?Q?guhCuXQ8U/4lvBIWVfeca1585IrY2E5fCRZaVZQH3Rsj5cgpr+3G92wGp8To?=
 =?us-ascii?Q?jOxnrWO68Wt7Zp8cI0QYyyGR0bQAzoC2+7P8WW83GAgPOIp8g01s5XSZYsY2?=
 =?us-ascii?Q?nMXtSa2fPBOZl8JFmTvgMTs2AXwkVi19gfZrVnhOG8LNN++CGbrxL4RpG6fc?=
 =?us-ascii?Q?U5S7mR4xFNx+1AC9jqbfDTJj0SYpsj9N8lgygPmvHtb2ns4vTOFNMvsjlkIA?=
 =?us-ascii?Q?z5khrGGWF+0vL1qbTytGJyLcQ7C4LjMrweMpxCe3hk2SdnZGHry2P9VW3nwl?=
 =?us-ascii?Q?vYj715MgPga5T3jDWiLlNUh7xcT3RD2ijwKFUFB2ogBrkXDRf9Elu6KE5z1C?=
 =?us-ascii?Q?jOv27UhqSL9HCc5ilXSVNE11KMA+gzcILzl4xmensEVmJetUAMuHRyr4n+Sd?=
 =?us-ascii?Q?lGQn4xVVZBkcLdv1NJD4eqlDFbUrqk39wunplblXBxWIhjIt/sVJexCjIuSL?=
 =?us-ascii?Q?hbOLYkAwGK9q1PCah57F8JJrNYjjvqcOl/retH/swTYIB7H1lDb9mJVWicKf?=
 =?us-ascii?Q?cOZ71EdcOY/MGc6EYd1xnCyW7VhEYHM419nnh4Pi7V8qConW7GNprGLRJAbY?=
 =?us-ascii?Q?oFxdzJbui1GM7jcPbOqAjZIR9Klviqn6coCSRWNNykzn7mBWRUZZ1xADYujJ?=
 =?us-ascii?Q?5Tnhme8iQTjDdQ3aIrPK6vCKLUqf5ukMHES6Ir/J5ywx7yhI22im8WCfHXRe?=
 =?us-ascii?Q?9/dVjJTZYV32M2FfORWLRH7aXpG9QVUoOW6j24uKBtI3aNqDaB9LkqTAipTg?=
 =?us-ascii?Q?r3b63aK0dhrAj1uKE7hl217VfS4aY7j/bRMjmy8aYCQBak2A/FZDNKsSOzyS?=
 =?us-ascii?Q?RVmZ5IkQv1KD3HbFLAigQGdUF2MSucR1i3LgndXYQPq9z56RXrxf0S6VK2Y2?=
 =?us-ascii?Q?vosgN6ZDtSh0gespFn37Q2UyAasd2C66mB3gwWpRfYI4Dp1BONT+KC8AfG1I?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e176ef39-0720-42b0-7fd8-08dd9ec2dfee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 15:09:57.6846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHXsgoRvzNjHaZgh1usT2IRqw6FEVGCtUQQqwER1zXir16GqCje6GIrzpCk+WC+Tc2sqta6enj+HI4YUxCpwPqhk3hRzCEAqt7cXXcwpfrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4861
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

On Tue, May 27, 2025 at 10:21:10AM +0100, Bruce Richardson wrote:
> This patchset is based off the work to adjust how we do argument parsing
> inside EAL. To enable argparse to be effectively used for EAL, we have
> new features and some changes in the first two patches, which are 
> relatively small - though are ABI/API affecting.
> 
> These add support for saving off strings and boolean values, have argparse
> stop parsing at a "--", and finally have argparse return the number of
> arguments actually parsed on success.
> 
> The third patch is a bigger change. It was inspired by the fact that
> when adding the boolean and string support we had to update some
> "MAX" value defines used in the code. This is obviously not good from
> an ABI/API perspective, once the library becomes part of the stable ABI.
> In order to remove these MAX values, patch 3 looks to replace the
> #define values with enums - which means some rework splitting the
> various flags into separate categories, and similarly splitting the
> single "flags" field with separate fields specifying if an argument
> value is required, what type that value should have, and then a
> final smaller field for any additional modifiers.
> 
> Bruce Richardson (3):
>   argparse: add support for string and boolean args
>   argparse: make argparse EAL-args compatible
>   argparse: use enums to remove max-value defines in lists
>

Ping for review.

Chengwen, as maintainer of argparse, can you perhaps take a look at this
set and give your feedback? I'm hoping to do some rework of EAL argument
parsing using argparse (see [1]), which requires some of the changes in this
patchset.

Thanks,
/Bruce 

[1] https://patches.dpdk.org/project/dpdk/list/?series=35256&state=*
