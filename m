Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46931C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 09:18:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D2DA402D1;
	Thu, 20 Feb 2025 10:18:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 6AC84402CF
 for <dev@dpdk.org>; Thu, 20 Feb 2025 10:18:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740043089; x=1771579089;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=wWWMX63Ga22o2XN+j6mF+N4pqtWC28zZ+CvcLpuCFb4=;
 b=BhtSVRBIul744dDKaQ8hfKHuurYqj3PQ1tyJvyII+YdM26vnESt2f1LY
 zbJFfbMH67qq9lK2M8m7+8NZQp4/aMpREZ+w+XvHKXshM6ASxD5fhgzoG
 +xkpayJvoGMYQVYrz3pOyc7Xy/5hbPbt4U4wSL5mwkZ3+zBD/qOqMRMqu
 BgKl69BEtHiz5MNxJAqVuNo0vQf/MLC31IV1Yh0KYjZ7nadJPU88fpicv
 4hlLPZIVsSG4M/a9PwNQ6xtX9h7rDOU8arI96acMlYDYDNoQE79kJOJyk
 dwsgUn4BMR8QePIaFtaiZJBcIY3FBqGFOZTqgxhxjN33uX6KOqMWTV85t A==;
X-CSE-ConnectionGUID: mm4LHY+mTFe1D7pWWyAODw==
X-CSE-MsgGUID: LAynXqIfS16M7oEPgCfO4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51796263"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="51796263"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 01:18:08 -0800
X-CSE-ConnectionGUID: tuxDqYHqTiO5ynoFHvo0FQ==
X-CSE-MsgGUID: OKby+t16S4K7kedgLTSY3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="114816159"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Feb 2025 01:18:07 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Feb 2025 01:18:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 01:18:06 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 01:18:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iK/SSjVTxjKtm3Lq5JpluZjVd6t5PQAbvpyKSmmv67GahXL45eymAt6X0xslLn0ag/gK6dpQEpyp/83YFqI0r+ab/ZjZAf6HUgOtVty5bzHLAw3ohP+qBtvyRJmh4qDDMHS3SxNBMpqGSrR1j8q5IrtSCVKqK40Y8FY5ZY1DfxwaUYdT4ui6BQjRqeuAvIbXdu5w+hbx9MHMddX4jnov9+tcdUG+NGCRhHPov+9DRRyplOW/mvXx+fZqmw9sdUjmDlth2OMzd7N2oRexj6xvmaOdwrdL0tl9IXMq04BQATlkxELcv0wz01EGHP9nSJ7KEnwbb5QxwMErZqeYlccG1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjvp+Jeq7g3MxHGYmUHDMzvPyg9AafDG16kqRy8NPKo=;
 b=lfGzC8d/gkY6Oq447PaFYLW5d2KQlfUvb7u8+B+L3W8Sg3qmZCggNIDqiugfLC4r/23s+wWLzK9j1iARMWQLLyDTT0I3VaGe8dToxpIHlTsk3jQNTHdsPQz4g/5MFcsgN2aF7Hf62Z6AOjnt6XIVPBviUNYmMeQR8S5+6ZFHsT1fE9K64lpDj1e0LK4TnK42d6WTpiQ+VigWk1KjCQDk6cVLo/XtiPrXxnYuk/z2tX1OpZR+hOqEcB+uU8HqDwCTi5quT5jhMmj+UTx4cXXhhzo9N8sRMxfgfhYaXutpd7JFT7sEK2XJFDoA8cwEUBN+Trd7b2QAANraMDJSb2KwLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7894.namprd11.prod.outlook.com (2603:10b6:610:12c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 09:18:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 09:18:00 +0000
Date: Thu, 20 Feb 2025 09:17:54 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v2 04/14] net/ixgbe: remove unnecessary dereference
Message-ID: <Z7bzQkT76J7GToHI@bricha3-mobl1.ger.corp.intel.com>
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <20250220023509.630569-1-stephen@networkplumber.org>
 <20250220023509.630569-5-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250220023509.630569-5-stephen@networkplumber.org>
X-ClientProxiedBy: DU7P190CA0009.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 6098561a-2602-47ab-3dfe-08dd518f78bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u7kZ2vMKS/dlepUTJUcE7fEciE1mjOMvREpaSI+7vUc5p1AFV79l4PNYoJG3?=
 =?us-ascii?Q?f733UZVT5i33N0LsHqo0e/urbSqvYs81Q9MhZ5WGmILf5pVNxlD+FGHxxCaS?=
 =?us-ascii?Q?iNQKItwQr5meeBHYjFTxJ7aNq9JlLVn/FmqNlcYqMxgGX5Ng1Img/EHWUzRf?=
 =?us-ascii?Q?KU7w7+ZBwJbs+JcxgAC/61najMQSYmf4ddCsyXL2OQ9OBHcDT+zbHeAtBt7/?=
 =?us-ascii?Q?akNn6iIwb1o3H/b+XOl1FKCu12P0L6Z7cI1LcKNgRNkjlT5HEDL3DF6Lf2vo?=
 =?us-ascii?Q?tHe1KGxgJxYJgpj0rMtwiB5Hcx7YJOL1vebmwv4R3MVSLVK2lj8taXt3UgNm?=
 =?us-ascii?Q?s8aMqH10+E8w5uqHjz1aCkzFLRbcuJ20lq5ELxGW9WiAbDa60LOdgVM4MIbM?=
 =?us-ascii?Q?10qmXKGYWNXegNyfDiVPd6pB5GESGmSrBpEdZ6Ye3FZ1VKuYt+97Cl/YhBun?=
 =?us-ascii?Q?HKDn9uHb5yxvRRNghyaOOyUGwB3LzS3dj6YgHeYdNDQwFpARRi5Ja1OoTG7z?=
 =?us-ascii?Q?CQ2JJpcz86jOYb2yeu0w4CAiMxGFCMhMax+WG7rPK0pNGBaW6xWbiXUEVbTW?=
 =?us-ascii?Q?WjJK8aDLvMJ8HWHseyQaWuITAaqAaWSsAnuiIiuwmp9hyr9kYzrdEidibcEl?=
 =?us-ascii?Q?DG+dwPcA/LpVcGytoHRj3+w0datHA81x7ZrxJeprJR+LqIvHC3J4u9OtTUdV?=
 =?us-ascii?Q?XBk9VZUo+B1B/H1Ix74EcxOos9KWUEU11QlQkIkZcfCNI53X+kHPeDjt6lh/?=
 =?us-ascii?Q?yi0iAqlYNS/8DyJJ8ZyOPN75YtEt86kTqNSmF31ld6vIj4sjN/IVlVbZ5xSt?=
 =?us-ascii?Q?Mykch6dzO6weK89DWHkp6qhEEPbr8DFUWPDFmvmXd39MkQmNoIdEsWi4eKx9?=
 =?us-ascii?Q?JCTW1W9rYPNGtfbil8ztKzdmNMJyF8n3Ptmvjx4YXOLtWTMJrsAScGdOM/h4?=
 =?us-ascii?Q?VrLOIEcRttA0Nfwj+odar/EzIiSP8gROfYU2u8Xc2dP5uvp0RLSOfu/ZJ0EU?=
 =?us-ascii?Q?Gb1uhcjppCnvL4GenQ/SrzeOKD2G6NHSUib7yqbBWeBLUyyU8iTNW/jcT0KV?=
 =?us-ascii?Q?Pzz9sQN3ANdTFNXpop+miCmaF+VfzIfnl/3oy2lrGxgVP6ZviJgPwQnly2Cl?=
 =?us-ascii?Q?9h2HzYfnctpCB5z/JMvzjlHRGHgkEZ6XmGZOjOxXRnEdj8mX5Y6xiyIP+Byt?=
 =?us-ascii?Q?Ch07Op3U3QYZD5BbT+YoUMdsYe42dVuEqkzrYSXbAt8njPFdCbzlwEqL5L2n?=
 =?us-ascii?Q?Y2PItehIYJEtErzc6OvkSN3jIdcwNqgYpuoz+sJbpm8hn+vmekmySJE62VfQ?=
 =?us-ascii?Q?iY6Q0qDXjInY2rkfYtCj1pjhaLuzQ37VSLJHBCRhlHZJ7npSZGOD7G9pRrj3?=
 =?us-ascii?Q?8AdVyYcDKcoDVHgfB/WyT28mmBTj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UpMWlF4+6JBHB+I/XJdVMATD3fXjQc/H7HQ/YbYxm4PJbm+LH//6Px3Zrf4i?=
 =?us-ascii?Q?pEwxXRjZSCclIXAVcbJEP6bYQZWx6CoCWvToImw1M7XTQXf1AujjmeK3QIye?=
 =?us-ascii?Q?j2aIHbw7BLctyPIeMckAExQOLwf91Qqh150RfjV60Z6LuQ9hmD4JhLtrq1Qn?=
 =?us-ascii?Q?DFEKXig7933cefg/D7yMUcb4FjMOwygSQmpm60GqnMaroG8UYybhzntcuB7/?=
 =?us-ascii?Q?GKxMiw+reShLJEOmUTuCFbvU/zlXvCZVyqDSHaTHW6G3aGHKycVu/siBrRkd?=
 =?us-ascii?Q?+54NKP2CjrOj6APpDcxlDZ8/bjAx2OBAs1pGZUhZ2XWTSb+3ADWi0DmBy/Kd?=
 =?us-ascii?Q?ylnkJLFqpcHlM/xahduK2xlGa/EHY9rzppV9HKmsiiC/tfbaaCM0D0HK1kxG?=
 =?us-ascii?Q?LucAbBAxG1zm0mfhC3iaM9fFRbEVPATsC5Cy1UkfS4fRDiQv4rlutXhkUgO+?=
 =?us-ascii?Q?m5GAoIEWtqCxLjUsAXJU8kmhlgCR5Yss4PpBQijFHOgT+PtPAa+BMuZ3Kd+c?=
 =?us-ascii?Q?9wTnv8hszpCm9wmZlE5nFsW32waZxl3ubW2JhdB+LkKt87PdNQlUtcDGRLnw?=
 =?us-ascii?Q?BOZLCwDnBMaLOWL0IwHNSZCUwMcqWB9uq7WJawqkoFxz/1Hkcnk1H++a2KsQ?=
 =?us-ascii?Q?skEAdhYkOUpkT8LdAaF9Riq6X/q/wXNx737cQ94js5y7Rita5Tm5QqChDbpa?=
 =?us-ascii?Q?h+86sS2AMH0jcnoZ52WiknLKYm24v7PhZc++dNMzSrGK1sty7clTSYYbkOvF?=
 =?us-ascii?Q?hBGirU8bOcQfSO3p8Bo6a5R8e54A2YHhdFP2Ep3oi8Q42ciUk4MkCXpDHoXP?=
 =?us-ascii?Q?ZW0FQyj9hO0ylBfbFVMBNoEtMHv9xZupwOvfjq5JGxTLUTRbEucT4j/TxjcN?=
 =?us-ascii?Q?d+A/8CgOwbFVb2RbInnQYypd5i4oKX/ya7EtW8RD1upyAaI5YKIrPnp4gtbk?=
 =?us-ascii?Q?zIzA+ilu3TdjFqrftzxBSXy2U07QFWDkuzwtSFauQ7zpfEWgLy4xsNAn6wbi?=
 =?us-ascii?Q?+K7Bn4D75Kbj/VFOT5wYCcbobY9MAoQUUP8Z8eLsVEzqBgxXzilHl1uMbQ1c?=
 =?us-ascii?Q?NS49evJWPe4QJjcfXPATMhnDHd9rIBlqVaznUWFvRooYWrnHeABwPlPcCRXj?=
 =?us-ascii?Q?k3vUGVZS8impYImqBDnIWjTqMI6rHtH0Pj24hr5PixRyhVmd8yh9P/loSnAa?=
 =?us-ascii?Q?CRx18PA6b9n5SPpO5Fcwqi/zDo5OmI8/jtXyLdRoo3onrGcmAy58ZUaCmYKS?=
 =?us-ascii?Q?EUBfbBXdA0EWgxQwjs3cuQOW+vTT4ouPdwuVvJmMSaLRou3xTC+7DytAbkaQ?=
 =?us-ascii?Q?xQuhuDRLNuJQsXeF+M4SHQTrcgAo3g0/Wglp7DtW+KwuvvoPUT7Nzgf8Yxcq?=
 =?us-ascii?Q?vVLqMzm94WX2Q9ulIRl3lLs3uvzI+QDIGnqrxyt4kJf4UOyUwHNGL+MVWFzU?=
 =?us-ascii?Q?wXSMCn0CPbqig+ARoUiZerT51TzOIMTAeGWhx2s3vgznA1B4Aq+Bv2/MqA7I?=
 =?us-ascii?Q?e/OC7hC94v3YdpyQjYAMkvFNhNCDrl6bu3bWbQH4A5qYeIyQlaLKi0gomig7?=
 =?us-ascii?Q?MZ75l8Oq41CyYTeFBkCsfeBH06VoxuElZHrADDvDxhGLGHnA0U5VnswrEYTb?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6098561a-2602-47ab-3dfe-08dd518f78bd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:18:00.5545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIqqvfr6jnhisnzsPPzbwytJDZkF+cRSXlSATGS2O+0teSLy9fGU/bIolI525xcC9CyRIx267FpurDpeYWMAPevclaLJaHBag6qtCAHlcIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7894
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

On Wed, Feb 19, 2025 at 06:32:08PM -0800, Stephen Hemminger wrote:
> The expression *dev->dev_ops->vlan_strip_queue_set and
> dev->dev_ops->vlan_strip_queue are equivalent in C.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/intel/ixgbe/rte_pmd_ixgbe.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
Reviewed-by: Bruce Richardson <bruce.richardson@intel.com>
