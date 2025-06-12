Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DF0C71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 16:44:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA5E442796;
	Thu, 12 Jun 2025 18:44:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 3252442789
 for <dev@dpdk.org>; Thu, 12 Jun 2025 18:44:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749746683; x=1781282683;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=7cPABwBajT2fU001ZAeHWM5bStiqTWIIrhMWnqX9YTU=;
 b=XzwhXNzbP1yGgbG8QRn0HdIeH+kQSMjLao1JEvft5xsnFhp5X7TKtlbW
 7pv5DAuVDZIiZ5vPeyKi7wQPWjirVo7UGqAKOBDLQIVQgmqJsp9MllUSl
 GsrdpwhUY4B5S1uj4WBAYE4eZZHCQXR28vKoSAvJWqTXSIeH9hPWrRaIf
 aguqGA2G3y6et0AFpNgIuXFuGRI6bBy091dn/Gqaes7fcA7RQf5SUl2zV
 BEBF2O4gRj5jr11XNnT1yQ7zt/+xW94+4mOfNx10WfSkjRpAyOJQf42Y2
 PV/exxp7l/O+URTO4M6SDCBi87ahugO//R2RhmY5VYFBbtlyGMLBBgI5F A==;
X-CSE-ConnectionGUID: uIkyGzQSQfygRpR1upxKlA==
X-CSE-MsgGUID: qRgv2U8bShO+ot+KqdaCJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="52086374"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; d="scan'208";a="52086374"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 09:44:42 -0700
X-CSE-ConnectionGUID: ojq+pY9cQq6lXlzNV/sisA==
X-CSE-MsgGUID: wGERt+MzS0CU7iJnsySL+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; d="scan'208";a="147438129"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 09:44:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 09:44:41 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 12 Jun 2025 09:44:41 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.50)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 09:44:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRYs/KvCE4bNu3VsBGd2pxmvL9TCNQw2283+tZ8HZlN7hyOhds99IPLIKJAuSfa+qLVjQEm7lWJJpsMxsZBAMdfOaNl/Z/8ihWNboZj2SRryy3mSHiI86y31VcJvcnTBucNYz5w6QLk4lyIGHsCJyd7E5yvxJTmaUexB1nnOnyaK5sSuhf/VC24ay4rC4NNMzICOfrkkyq9QhT84U+cT008pDn9DLHS7NdMyfwu18fb9UkE+lnuGU+CiJibU/Ic04CVrn86cDttxe52CUJnwLm6b3dyNFLfwYmzCcy4OLY3tYsJ/wjoiT4bEsahhUv6LwxW1kkfYnTwubEzxH6n5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcKMioGUWX/q8D7z4NAk1PiBG+ctFblKV9yGsmaXQHo=;
 b=o8t7KdrweS+pCNF11vjGImHOraX1D8G1Y9c1pEb7xEY/MzBin8CV4yiI1dh18ycLtmaEPVh8c4tNkOfaugqf+2O7acMR2v3c+gqWIGNza5uyqaSidzRTRURoMi0nTwu/w/7PX0JAWec/qHSIvx794JYXwl6oY/WxU474IHZkH8pMPRdJUR6gHpGxf40EQVpWxX+lwiOsMBadFZEATb4Zlepl68w/ZmmqVRyO1GF9hN2g1Oq9BSR3upitbC0tyF+GRY7lap9gZZwzkkiD2Co+oCIRGNlXWnV9LiKsB6d+rK56nA8bi3+4hHLkot/2iRyBBoApC1eV/yrCfu2nQAPS6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7010.namprd11.prod.outlook.com (2603:10b6:930:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.28; Thu, 12 Jun
 2025 16:44:25 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 16:44:25 +0000
Date: Thu, 12 Jun 2025 17:44:19 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Singh, Aman Deep" <aman.deep.singh@intel.com>, "Subbarao,
 Manoj Kumar" <manoj.kumar.subbarao@intel.com>
Subject: Re: [PATCH v4 3/6] net/intel: add TxPP Support for E830
Message-ID: <aEsD4z-6QPFGkh6t@bricha3-mobl1.ger.corp.intel.com>
References: <20250606211947.473544-2-soumyadeep.hore@intel.com>
 <20250610131159.495566-1-soumyadeep.hore@intel.com>
 <20250610131159.495566-4-soumyadeep.hore@intel.com>
 <DM3PPF7D18F34A1DCBEBCDE7C91289CCB5A8E74A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF7D18F34A1DCBEBCDE7C91289CCB5A8E74A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU7P190CA0025.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::32) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: b92a7c49-ea40-453b-a6ea-08dda9d06404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2ZiiN4nvAYJo+EGcS9PwbY1sOwo0Vk27StD7tjPin/Twd8Mn1otiqPzr0tCL?=
 =?us-ascii?Q?HoOa3FT0q484oxtVn4v4O/fguxyOLeYNg9FuqR1i+ifKcXQFNbI2OT9FBBMD?=
 =?us-ascii?Q?4cR3O28B0/NfFA4ZYAyLA8MNjBpzYuo0ig+Gb0UUCDCSy6XLTE8DdYFLakWu?=
 =?us-ascii?Q?Y7O4tsspNqVLOq6Fli7JydAxrO9Duy6mFDjlRnNIeaLA5/PogwZJ7fFJ799c?=
 =?us-ascii?Q?miquH1h9GqJ09yKPLkV4qVIy2o1J92DCTn6d+W9YmXV/kDTen9k9oxMr3lSQ?=
 =?us-ascii?Q?3NY8zdiWFPhuN27UEsz2QDxw/6HUStxFfHGku3qjQKxgSzQFWJzGGe95TBZG?=
 =?us-ascii?Q?3YOSjkuGnxcR6VHa2Mp+yjmHi/n9QbVAPxEhlgE0rzkLlHSONnZZhjJ1BAOF?=
 =?us-ascii?Q?cp3ngZO4SSatYixph/ek+1HFAg+KWR+STwZm2j3jw9IjtsqRz99VmtANNZb8?=
 =?us-ascii?Q?a4phtkkq6+JK7J2naR012mhfRFBhX0GzNrQRqpgk7Yz2Yu6q581oxaKRQp4s?=
 =?us-ascii?Q?eximVIrWYRLde4GtCisPz1tOZwfWoO7hFR/a9TquvlA+dNYRdgJMStW92QNy?=
 =?us-ascii?Q?wZzjFaXCZ6hwZtm6csXM/eztIMfrsuXStOMmz42/A/y7B6fzyZjGsnBk7nyM?=
 =?us-ascii?Q?wSyU9KLO2EUUL0+IsWZsXasUpWgxgFw3IQFppQ2zz/eY2REB/X+ngpQ3azBX?=
 =?us-ascii?Q?/BqqqzCRP0LIJ1+Q8YNdLBTMNl+LhVpRYlxfEP+yhMIMeSUpUruWU1ri3xzj?=
 =?us-ascii?Q?rp5HqHXnYBPGr1f7bTpX2Me3L535hPIMfk50Shc1pUIkW6rVcG6W7cKSv+Kk?=
 =?us-ascii?Q?Jy+1mMBaS3NCHZ3dwNBAw/628wIhRZxMNwxwcEqpnEWWCIMUsQFejL7FOmtF?=
 =?us-ascii?Q?9jbWIp3H34BsM6bdpdrJM3rVsfqMe5a5NkscMEJugrHYVYhKJW+JyJv0Fe3v?=
 =?us-ascii?Q?STPeylXQey55+q1Qq8/DDo3jaXvTQR0bktZuy/iR2QcQpIhGl/Cg3g++51mH?=
 =?us-ascii?Q?IAErpqSDHAKEy/JkKML8XHs1/RNwqRlDtv/vheVgjIcc2c8WK7D5cJ6gTgt8?=
 =?us-ascii?Q?0gtHgStwqocGGcNVw8GKxifm1jGl83L3WQ734OYACywQAbbDdyZll9ZmySWR?=
 =?us-ascii?Q?mm8v8a30arcbfqBoE0YGcOFIBsTJOsQKpsGqNFsyVu/5VHGRhy4R/FCXhEuI?=
 =?us-ascii?Q?E78V29m4TGPpIiPSkHf8GiIJCEjJnCJX0+ZvKzKASptZ8eEHsgX0NYVAc8No?=
 =?us-ascii?Q?NgzcF97VE1HOATlIHP7jQvE7qK03lOas4YDOzZ5vc3Tk9QQ5muuP5qpSjAlt?=
 =?us-ascii?Q?vjp4oEH5xsCKiJwsjUXH9SHjOm4F6Dxoe+tnfWyR+BSrWMwoV+ikYitbTx+D?=
 =?us-ascii?Q?60gXelho2HPRxMfgZE4XU+osSxv1J9CmOoQJZP9lPejdQshsuveMkx0WG4Na?=
 =?us-ascii?Q?m3uGz/zoqZM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pAgnQhKcNQniqbtmTHl7ss0a+E9jAmz4X1uRAM0uHnHojdgA6O4zBwqCEH7j?=
 =?us-ascii?Q?GlR4x6uTdLTtdQs0SKlNq08UJYa6QQY6mO4Lk0k4pBLi6hvjAOgbHjje2I+M?=
 =?us-ascii?Q?rDzA3xuKdCE+yMK0qSrEMlXxQ/AHxJkLiZJqA1DnFHGfLDNvrVWb1Y/pEug2?=
 =?us-ascii?Q?Gb4wXnwvCWNYSoKQNUcmgeiF9XUDjmjgW1ByBCVDYIZwawPYDYOurDJMkMxF?=
 =?us-ascii?Q?oyPo18PPKnPqK4QWgiSP8bVfkzwvqDrtoi9cXd3YxRScdJ8nnP7iSh7/xAnk?=
 =?us-ascii?Q?G8ogBnTKKNf1JEq7CSbjAAdpfPk55znVoQ4+LjJiHZpzfme4yzSToCVgS/TT?=
 =?us-ascii?Q?Ihngstjl36RXL7sKpy1xNRnryXlRU11Ff6RxYwk+nDn3QBTsiJsINL/dj5r6?=
 =?us-ascii?Q?oe4dpxl7W6n2qp2xFMI/M8lk4vfvhKXGq0KvFJoS2PECx/bfCMopPbVCNYF8?=
 =?us-ascii?Q?rGpNcKgptCZaLYWgwWFE9ODzrYBfuAfmRXYkOdb2vGe1kHy3E5gS5hdZWU3W?=
 =?us-ascii?Q?r38OVDHWzyWlcvWuvUonPaCXOi76vnxeRb3j33V+GMwYlKOMBJj6Fsj52R2l?=
 =?us-ascii?Q?CuyRThJGp4/hYQ0YB8CEOWn7/hjPAOg521HmjX1nputyo0+t5bKA2bR6+PVo?=
 =?us-ascii?Q?Bxm4SGu+nU7Ew/C6X+o/8SLVGnGjJCH90MhzFr5/OMBRDr8WkVmt5GrAYbgY?=
 =?us-ascii?Q?omkoLjdEppVAvjuFxdsXY5lO1vKO3eITfdpm2hMy3lWGQqY5JYNGy7y1zLsU?=
 =?us-ascii?Q?kfMbZpT32+vl9bRHyGDG6Wx552BRpfLQHzkQlgZKBhpVxDcGCux0cr8Wqn0B?=
 =?us-ascii?Q?D0fDJI2/A1w1VTlfZz7OEOj/6QU0z9VBFeblfuDKiB7nxiq9p3qeBh9iP57O?=
 =?us-ascii?Q?iB0CzwWWuJH0mF0bDYWbEUk0L1Uto2IBQfcIAFVmwFA/CqwZyHJ5YTDuzHKt?=
 =?us-ascii?Q?SCmwPJawJd2/KBFpi0VCMYnQpKuPNaBO5+cYn0jSYPl3v3YvYVYIJfNROAf1?=
 =?us-ascii?Q?7XwgS1eehSgI2OZnZB2HPfi9o/ZjoruQVqZScabHWOIWhbZCP3XjqOWcUaiL?=
 =?us-ascii?Q?a48kIt/6aXZa8IREjTv/T+aSEbVGBYHzz1Yc2qfDZzvATfl+vqooGxh8LAaZ?=
 =?us-ascii?Q?ugO0YB8KcFbz5WzedFJEKp8fr5kgilqRgdsLP2axmuUesL9PREKcw5HktL9T?=
 =?us-ascii?Q?+GAQEZx2RsfIm3Dios1uPWAAVAzy3/3nKYz9PoQoDRaRTw+lGK60PYZ5xmhl?=
 =?us-ascii?Q?ygMGwzP/uu57k2s8wr3/EDZ9EhUVjDMScBwHmNjxsvQCd7qAclT4KAtk6u16?=
 =?us-ascii?Q?ADPF8/GH48n171YuK5CoLdiGlkI6iUS6n363XfvvXtpoxzEKtuxdPCftubO1?=
 =?us-ascii?Q?pSX/J7VovE5GNCQ5UgcmRf28XMIIfPPgxqS7kdgQgc0g2l5l/OR7Fx5HE/+r?=
 =?us-ascii?Q?wgU6zivQH7YpSODPBhhbvNZsPFf6L0pCv+DddsJbIS/bAsq4ac9bQKIu1bmo?=
 =?us-ascii?Q?uhkc5GrCXOmi01MBOssIGg/6Wg1Ir3b42BZYhVPpz8zSGKpPR4Tn5PPS/ucm?=
 =?us-ascii?Q?Yi+YUI5g0TXcxRjQfga9Ebesv+5iVtMhCTgzuVVGwinIp54ePkdAZiODWFw7?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b92a7c49-ea40-453b-a6ea-08dda9d06404
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 16:44:25.5891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fluvFIkjvD4QOIKvqlwkl1MuAhSEeplGbl6vkGgVsAp49KaMuXCfQMPfF1AABQ/tqCxUN/xHFJ6Dy/TywjJVt6qxDissevB8glRFn65iny8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7010
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

On Thu, Jun 12, 2025 at 11:31:30AM +0100, Loftus, Ciara wrote:
> > Subject: [PATCH v4 3/6] net/intel: add TxPP Support for E830
> > 
> > Add support for Tx Time based queues. This is used to schedule
> > packets based on Tx timestamp.
> > 
> > Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>

Hi Soumyadeep,

more comments inline below.

/Bruce

> > ---
> >  drivers/net/intel/common/tx.h              |  14 ++
> >  drivers/net/intel/ice/base/ice_lan_tx_rx.h |   4 +
> >  drivers/net/intel/ice/ice_ethdev.c         |   3 +-
> >  drivers/net/intel/ice/ice_ethdev.h         |  11 +
> >  drivers/net/intel/ice/ice_rxtx.c           | 229 ++++++++++++++++++++-
> >  drivers/net/intel/ice/ice_rxtx.h           |   9 +
> >  6 files changed, 261 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> > index b0a68bae44..1fbbe40cce 100644
> > --- a/drivers/net/intel/common/tx.h
> > +++ b/drivers/net/intel/common/tx.h
> > @@ -30,6 +30,19 @@ struct ci_tx_entry_vec {
> > 
> >  typedef void (*ice_tx_release_mbufs_t)(struct ci_tx_queue *txq);
> > 
> > +/**
> > + * Structure associated with Tx Time based queue
> > + */
> > +struct txtime {
> > +	volatile struct ice_ts_desc	*ice_ts_ring;  /* Tx time ring virtual
> > address */
> > +	uint16_t nb_ts_desc;	/* number of Tx Time descriptors */
> > +	uint16_t ts_tail;  /* current value of tail register */
> > +	int ts_offset;	/* dynamic mbuf Tx timestamp field offset */
> > +	uint64_t ts_flag;	/* dynamic mbuf Tx timestamp flag */
> > +	rte_iova_t ts_ring_dma;	/* TX time ring DMA address */
> > +	const struct rte_memzone *ts_mz;
> > +};
> 
> I recommend taking this out of the common file since it is only used by one Intel driver. If support is added for another we can move it at that point.
> 

Agree, until this is used by multiple drivers I'd keep it in the
ice-specific files. If here, it needs a "ci_" prefix.

Some other comments on the struct:
* you have mixed tabs and spaces in the definition and comments. There is
  no need for a tab before "*ice_ts_ring", it should be a single space
  only. The whitespace before the comments should probably be just spaces
  too, so you can line them up correctly.
* The ts_ring_dma field is unnecessary I think. Doing a quick grep of the
  code shows it being used only once, when setting up the queue context.
  For that scenario, it's as easy to get the dma address from the ts_mz
  pointer instead.

> > +
> >  struct ci_tx_queue {
> >  	union { /* TX ring virtual address */
> >  		volatile struct i40e_tx_desc *i40e_tx_ring;
> > @@ -77,6 +90,7 @@ struct ci_tx_queue {
> >  	union {
> >  		struct { /* ICE driver specific values */
> >  			uint32_t q_teid; /* TX schedule node id. */
> > +			struct txtime tsq; /* Tx Time based queue */
> >  		};
> >  		struct { /* I40E driver specific values */
> >  			uint8_t dcb_tc;
> > diff --git a/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> > b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> > index f92382346f..cd02d2b4eb 100644
> > --- a/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> > +++ b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> > @@ -1278,6 +1278,8 @@ struct ice_ts_desc {
> >  #define ICE_TXTIME_MAX_QUEUE		2047
> >  #define ICE_SET_TXTIME_MAX_Q_AMOUNT	127
> >  #define ICE_OP_TXTIME_MAX_Q_AMOUNT	2047
> > +#define ICE_TXTIME_FETCH_TS_DESC_DFLT	8
> > +#define ICE_TXTIME_FETCH_PROFILE_CNT	16
> >  /* Tx Time queue context data
> >   *
> >   * The sizes of the variables may be larger than needed due to crossing byte
> > @@ -1303,10 +1305,12 @@ struct ice_txtime_ctx {
> >  	u8 drbell_mode_32;
> >  #define ICE_TXTIME_CTX_DRBELL_MODE_32	1
> >  	u8 ts_res;
> > +#define ICE_TXTIME_CTX_RESOLUTION_128NS 7
> >  	u8 ts_round_type;
> >  	u8 ts_pacing_slot;
> >  	u8 merging_ena;
> >  	u8 ts_fetch_prof_id;
> > +#define ICE_TXTIME_CTX_FETCH_PROF_ID_0 0
> >  	u8 ts_fetch_cache_line_aln_thld;
> >  	u8 tx_pipe_delay_mode;
> >  	u8 int_q_state; /* width not needed - internal - DO NOT WRITE!!! */
> > diff --git a/drivers/net/intel/ice/ice_ethdev.c
> > b/drivers/net/intel/ice/ice_ethdev.c
> > index 9478ba92df..3af9f6ba38 100644
> > --- a/drivers/net/intel/ice/ice_ethdev.c
> > +++ b/drivers/net/intel/ice/ice_ethdev.c
> > @@ -4139,7 +4139,8 @@ ice_dev_info_get(struct rte_eth_dev *dev, struct
> > rte_eth_dev_info *dev_info)
> >  			RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |
> >  			RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |
> >  			RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |
> > -			RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO;
> > +			RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO |
> > +			RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP;
> >  		dev_info->flow_type_rss_offloads |= ICE_RSS_OFFLOAD_ALL;
> >  	}
> > 
> > diff --git a/drivers/net/intel/ice/ice_ethdev.h
> > b/drivers/net/intel/ice/ice_ethdev.h
> > index bfe093afca..f39c4b0471 100644
> > --- a/drivers/net/intel/ice/ice_ethdev.h
> > +++ b/drivers/net/intel/ice/ice_ethdev.h
> > @@ -17,6 +17,17 @@
> >  #include "base/ice_flow.h"
> >  #include "base/ice_sched.h"
> > 
> > +#define FIELD_GET(_mask, _reg) \
> > +	(__extension__ ({ \
> > +		typeof(_mask) _x = (_mask); \
> > +		(typeof(_x))(((_reg) & (_x)) >> rte_bsf32(_x)); \
> > +	}))
> > +#define FIELD_PREP(_mask, _val) \
> > +	(__extension__ ({ \
> > +		typeof(_mask) _x = (_mask); \
> > +		((typeof(_x))(_val) << rte_bsf32(_x)) & (_x); \
> > +	}))
> > +
> 
> I suggest moving these macros to ice_rxtx.h.
> 
> 
> >  #define ICE_ADMINQ_LEN               32
> >  #define ICE_SBIOQ_LEN                32
> >  #define ICE_MAILBOXQ_LEN             32
> > diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> > index ba1435b9de..94d42ddf06 100644
> > --- a/drivers/net/intel/ice/ice_rxtx.c
> > +++ b/drivers/net/intel/ice/ice_rxtx.c
> > @@ -740,6 +740,50 @@ ice_rx_queue_stop(struct rte_eth_dev *dev,
> > uint16_t rx_queue_id)
> >  	return 0;
> >  }
> > 
> > +/**
> > + * ice_setup_txtime_ctx - setup a struct ice_txtime_ctx instance
> > + * @txq: The queue on which tstamp ring to configure
> > + * @txtime_ctx: Pointer to the Tx time queue context structure to be
> > initialized
> > + * @txtime_ena: Tx time enable flag, set to true if Tx time should be enabled
> > + */
> > +static int
> > +ice_setup_txtime_ctx(struct ci_tx_queue *txq,
> > +		     struct ice_txtime_ctx *txtime_ctx, bool txtime_ena)
> > +{
> > +	struct ice_vsi *vsi = txq->ice_vsi;
> > +	struct ice_hw *hw = ICE_VSI_TO_HW(vsi);
> > +
> > +	txtime_ctx->base = txq->tsq.ts_ring_dma >>
> > ICE_TX_CMPLTNQ_CTX_BASE_S;
> > +
> > +	/* Tx time Queue Length */
> > +	txtime_ctx->qlen = txq->tsq.nb_ts_desc;
> > +
> > +	if (txtime_ena)
> > +		txtime_ctx->txtime_ena_q = 1;
> > +
> > +	/* PF number */
> > +	txtime_ctx->pf_num = hw->pf_id;
> > +
> > +	switch (vsi->type) {
> > +	case ICE_VSI_PF:
> > +		txtime_ctx->vmvf_type = ICE_TLAN_CTX_VMVF_TYPE_PF;
> > +		break;
> > +	default:
> > +		PMD_DRV_LOG(ERR, "Unable to set VMVF type for VSI type
> > %d",
> > +				vsi->type);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* make sure the context is associated with the right VSI */
> > +	txtime_ctx->src_vsi = vsi->vsi_id;
> > +
> > +	txtime_ctx->ts_res = ICE_TXTIME_CTX_RESOLUTION_128NS;
> > +	txtime_ctx->drbell_mode_32 = ICE_TXTIME_CTX_DRBELL_MODE_32;
> > +	txtime_ctx->ts_fetch_prof_id = ICE_TXTIME_CTX_FETCH_PROF_ID_0;
> > +
> > +	return 0;
> > +}
> > +
> >  int
> >  ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
> >  {
> > @@ -799,11 +843,6 @@ ice_tx_queue_start(struct rte_eth_dev *dev,
> > uint16_t tx_queue_id)
> >  	ice_set_ctx(hw, (uint8_t *)&tx_ctx, txq_elem->txqs[0].txq_ctx,
> >  		    ice_tlan_ctx_info);
> > 
> > -	txq->qtx_tail = hw->hw_addr + QTX_COMM_DBELL(txq->reg_idx);
> > -
> > -	/* Init the Tx tail register*/
> > -	ICE_PCI_REG_WRITE(txq->qtx_tail, 0);
> > -
> >  	/* Fix me, we assume TC always 0 here */
> >  	err = ice_ena_vsi_txq(hw->port_info, vsi->idx, 0, tx_queue_id, 1,
> >  			txq_elem, buf_len, NULL);
> > @@ -826,6 +865,39 @@ ice_tx_queue_start(struct rte_eth_dev *dev,
> > uint16_t tx_queue_id)
> >  	/* record what kind of descriptor cleanup we need on teardown */
> >  	txq->vector_tx = ad->tx_vec_allowed;
> > 
> > +	if (txq->tsq.ts_flag > 0) {
> > +		struct ice_aqc_set_txtime_qgrp *ts_elem;
> > +		u8 ts_buf_len = ice_struct_size(ts_elem, txtimeqs, 1);
> > +		struct ice_txtime_ctx txtime_ctx = { 0 };
> > +
> > +		ts_elem = ice_malloc(hw, ts_buf_len);
> > +		ice_setup_txtime_ctx(txq, &txtime_ctx,
> > +						true);
> 
> Nit: this does not need to be broken into two lines.
> 
> > +		ice_set_ctx(hw, (u8 *)&txtime_ctx,
> > +				ts_elem->txtimeqs[0].txtime_ctx,
> > +				ice_txtime_ctx_info);
> > +
> > +		txq->qtx_tail = hw->hw_addr +
> > +				E830_GLQTX_TXTIME_DBELL_LSB(txq-
> > >reg_idx);
> > +

Another nit: this doesn't need breaking into two lines either.

> > +		/* Init the Tx time tail register*/
> > +		ICE_PCI_REG_WRITE(txq->qtx_tail, 0);
> > +
> > +		err = ice_aq_set_txtimeq(hw, txq->reg_idx, 1, ts_elem,
> > +				ts_buf_len, NULL);
> > +		rte_free(ts_elem);
> > +		if (err) {
> > +			PMD_DRV_LOG(ERR, "Failed to set Tx Time queue
> > context, error: %d", err);
> > +			rte_free(txq_elem);
> > +			return err;
> > +		}
> > +	} else {
> > +		txq->qtx_tail = hw->hw_addr + QTX_COMM_DBELL(txq-
> > >reg_idx);
> > +
> > +		/* Init the Tx tail register*/
> > +		ICE_PCI_REG_WRITE(txq->qtx_tail, 0);

Can this init of the tail register be put outside the if statement to save
duplicating it? Does it work ok if the set_timeq() call happens before we
init the tail?

> > +	}
> > +
> >  	dev->data->tx_queue_state[tx_queue_id] =
> > RTE_ETH_QUEUE_STATE_STARTED;
> > 
> >  	rte_free(txq_elem);
> > @@ -1046,6 +1118,20 @@ ice_reset_tx_queue(struct ci_tx_queue *txq)
> > 
> >  	txq->last_desc_cleaned = (uint16_t)(txq->nb_tx_desc - 1);
> >  	txq->nb_tx_free = (uint16_t)(txq->nb_tx_desc - 1);
> > +
> > +	if (txq->tsq.ts_flag > 0) {
> > +		size = sizeof(struct ice_ts_desc) * txq->tsq.nb_ts_desc;
> > +		for (i = 0; i < size; i++)
> > +			((volatile char *)txq->tsq.ice_ts_ring)[i] = 0;
> > +
> > +		for (i = 0; i < txq->tsq.nb_ts_desc; i++) {
> > +			volatile struct ice_ts_desc *tsd =
> > +							&txq-
> > >tsq.ice_ts_ring[i];
> > +			tsd->tx_desc_idx_tstamp = 0;
> > +		}
> > +

Both these loops are zeroing the ring. Just use one memset, which should
reduce the if block nicely e.g.:

  if (txq->tsq.ts_flag != 0) {
  	size = sizeof(txq->tsq.ice_ts_ring[0]) * txq->tsq.nb_ts_desc;
  	memset(txq->tsq.ice_ts_ring, 0, size);
  	txq->rsq.ts_tail = 0;
  }


> > +		txq->tsq.ts_tail = 0;
> > +	}
> >  }
> > 
> >  int
> > @@ -1080,6 +1166,19 @@ ice_tx_queue_stop(struct rte_eth_dev *dev,
> > uint16_t tx_queue_id)
> >  	q_ids[0] = txq->reg_idx;
> >  	q_teids[0] = txq->q_teid;
> > 
> > +	if (txq->tsq.ts_flag > 0) {
> > +		struct ice_aqc_ena_dis_txtime_qgrp txtime_pg;
> > +		dev->dev_ops->timesync_disable(dev);
> > +		status = ice_aq_ena_dis_txtimeq(hw, q_ids[0], 1, 0,
> > +					     &txtime_pg, NULL);

nit: Can be a single line. We can use up to 100 chars per line to avoid splits.

> > +		if (status != ICE_SUCCESS) {
> > +			PMD_DRV_LOG(DEBUG, "Failed to disable Tx time
> > queue");
> > +			return -EINVAL;
> > +		}
> > +		txq->tsq.ts_flag = 0;
> > +		txq->tsq.ts_offset = -1;
> > +	}
> > +

Resetting ts_flag and ts_offset on stop looks wrong to me. The
"tx_queue_start" function looks at ts_flag to see if it should enable the
txtime queue. That means that calling stop and start on the queue will
cause the queue to lose the configured time functionality.

> >  	/* Fix me, we assume TC always 0 here */
> >  	status = ice_dis_vsi_txq(hw->port_info, vsi->idx, 0, 1, &q_handle,
> >  				q_ids, q_teids, ICE_NO_RESET, 0, NULL);
> > @@ -1166,6 +1265,7 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
> >  		   struct rte_mempool *mp)
> >  {
> >  	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
> > +	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data-
> > >dev_private);
> >  	struct ice_adapter *ad =
> >  		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> >  	struct ice_vsi *vsi = pf->main_vsi;
> > @@ -1249,7 +1349,7 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
> >  	rxq->xtr_field_offs = ad->devargs.xtr_field_offs;
> > 
> >  	/* Allocate the maximum number of RX ring hardware descriptor. */
> > -	len = ICE_MAX_RING_DESC;
> > +	len = ICE_MAX_NUM_DESC_BY_MAC(hw);
> > 
> >  	/**
> >  	 * Allocating a little more memory because vectorized/bulk_alloc Rx
> > @@ -1337,6 +1437,37 @@ ice_rx_queue_release(void *rxq)
> >  	rte_free(q);
> >  }
> > 
> > +/**
> > + * ice_calc_ts_ring_count - Calculate the number of timestamp descriptors
> > + * @hw: pointer to the hardware structure
> > + * @tx_desc_count: number of Tx descriptors in the ring
> > + *
> > + * Return: the number of timestamp descriptors
> > + */
> > +static uint16_t
> > +ice_calc_ts_ring_count(struct ice_hw *hw, u16 tx_desc_count)
> > +{
> > +	u16 prof = ICE_TXTIME_CTX_FETCH_PROF_ID_0;
> > +	u16 max_fetch_desc = 0;
> > +	u16 fetch;
> > +	u32 reg;
> > +	u16 i;
> > +
> > +	for (i = 0; i < ICE_TXTIME_FETCH_PROFILE_CNT; i++) {
> > +		reg = rd32(hw, E830_GLTXTIME_FETCH_PROFILE(prof, 0));
> > +		fetch =
> > FIELD_GET(E830_GLTXTIME_FETCH_PROFILE_FETCH_TS_DESC_M,
> > +				  reg);
> > +		max_fetch_desc = max(fetch, max_fetch_desc);
> > +	}
> > +
> > +	if (!max_fetch_desc)
> > +		max_fetch_desc = ICE_TXTIME_FETCH_TS_DESC_DFLT;
> > +
> > +	max_fetch_desc = RTE_ALIGN(max_fetch_desc,
> > ICE_REQ_DESC_MULTIPLE);
> > +
> > +	return tx_desc_count + max_fetch_desc;
> > +}
> > +
> >  int
> >  ice_tx_queue_setup(struct rte_eth_dev *dev,
> >  		   uint16_t queue_idx,
> > @@ -1345,6 +1476,7 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
> >  		   const struct rte_eth_txconf *tx_conf)
> >  {
> >  	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
> > +	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data-
> > >dev_private);
> >  	struct ice_vsi *vsi = pf->main_vsi;
> >  	struct ci_tx_queue *txq;
> >  	const struct rte_memzone *tz;
> > @@ -1469,7 +1601,8 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
> >  	}
> > 
> >  	/* Allocate TX hardware ring descriptors. */
> > -	ring_size = sizeof(struct ice_tx_desc) * ICE_MAX_RING_DESC;
> > +	ring_size = sizeof(struct ice_tx_desc) *
> > +				ICE_MAX_NUM_DESC_BY_MAC(hw);
> >  	ring_size = RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
> >  	tz = rte_eth_dma_zone_reserve(dev, "ice_tx_ring", queue_idx,
> >  				      ring_size, ICE_RING_BASE_ALIGN,
> > @@ -1507,6 +1640,42 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
> >  		return -ENOMEM;
> >  	}
> > 
> > +	if (vsi->type == ICE_VSI_PF &&
> > +		(offloads & RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP)
> > &&
> > +		txq->tsq.ts_offset == 0 && hw->phy_model == ICE_PHY_E830)
> 
> Perhaps we should log an error if the user tries to enable this offload on an unsupported device. At the moment we silently fail.
> 

Also, indentation on this "if" condition is misleading. It's indented by
just one extra tab, which means that is aligns with the body of the block.

> > {
> > +		int ret =
> > +			rte_mbuf_dyn_tx_timestamp_register(&txq-
> > >tsq.ts_offset,
> > +							 &txq->tsq.ts_flag);
> > +		if (ret) {
> > +			PMD_INIT_LOG(ERR, "Cannot register Tx mbuf
> > field/flag "
> > +							"for timestamp");
> > +			return -EINVAL;
> > +		}
> > +		dev->dev_ops->timesync_enable(dev);
> > +
> > +		ring_size = sizeof(struct ice_ts_desc) *
> > +					ICE_MAX_NUM_DESC_BY_MAC(hw);
> > +		ring_size = RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
> > +		const struct rte_memzone *ts_z =
> > +					rte_eth_dma_zone_reserve(dev,
> > "ice_tstamp_ring",
> > +					queue_idx, ring_size,
> > ICE_RING_BASE_ALIGN,
> > +				    socket_id);
> > +		if (!ts_z) {
> > +			ice_tx_queue_release(txq);
> > +			PMD_INIT_LOG(ERR, "Failed to reserve DMA memory
> > "
> > +							"for TX timestamp");
> > +			return -ENOMEM;
> > +		}
> > +		txq->tsq.ts_mz = ts_z;
> > +		txq->tsq.ice_ts_ring = ts_z->addr;
> > +		txq->tsq.ts_ring_dma = ts_z->iova;
> > +		txq->tsq.nb_ts_desc =
> > +				ice_calc_ts_ring_count(ICE_VSI_TO_HW(vsi),
> > +							txq->nb_tx_desc);

Nit: these 3 lines can all be squashed into one (99 chars long < 100!)

More seriously:
With current ring size values and alignment, I don't think it can happen,
but this assignment is unsafe and with different values could cause buffer
overflows when you clear the ring. Here is now:

* The ring size allocated is based on ICE_MAX_NUM_DESC_BY_MAC(). If alignment
  does not increase that max value, then the allocated ring size for the
  timestamp ring will be exactly ICE_MAX_NUM_DESC_BY_MAC().
* The ice_calc_ts_ring_count() value always returns a value >= to the input
  value, which means that if the user configures the tx_ring size to be the
  max value, then nb_ts_desc will be set to a value > ICE_MAX_NUM_DESC_BY_MAC().

On a semi-related note - is there a particular reason why the code is
aligning the memory size allocation for the timestamp ring to be a multiple of
4k? I can understand why the start of the area gets aligned (to 128bytes),
but not sure why we need a size that is 4k aligned. Can you explain?

If the ring alignment is unnecessary and is dropped, I think we could
definitely have overflow if the user configured a Tx ring to the max size.

> > +	} else {
> > +		txq->tsq.ice_ts_ring = NULL;
> > +	}
> > +
> >  	ice_reset_tx_queue(txq);
> >  	txq->q_set = true;
> >  	dev->data->tx_queues[queue_idx] = txq;
> > @@ -1539,6 +1708,8 @@ ice_tx_queue_release(void *txq)
> > 
> >  	ci_txq_release_all_mbufs(q, false);
> >  	rte_free(q->sw_ring);
> > +	if (q->tsq.ts_mz)
> > +		rte_memzone_free(q->tsq.ts_mz);
> >  	rte_memzone_free(q->mz);
> >  	rte_free(q);
> >  }
> > @@ -2961,6 +3132,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf
> > **tx_pkts, uint16_t nb_pkts)
> >  	struct rte_mbuf *m_seg;
> >  	uint32_t cd_tunneling_params;
> >  	uint16_t tx_id;
> > +	uint16_t ts_id = -1;
> >  	uint16_t nb_tx;
> >  	uint16_t nb_used;
> >  	uint16_t nb_ctx;
> > @@ -2979,6 +3151,9 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf
> > **tx_pkts, uint16_t nb_pkts)
> >  	tx_id = txq->tx_tail;
> >  	txe = &sw_ring[tx_id];
> > 
> > +	if (txq->tsq.ts_flag > 0)
> > +		ts_id = txq->tsq.ts_tail;
> > +
> >  	/* Check if the descriptor ring needs to be cleaned. */
> >  	if (txq->nb_tx_free < txq->tx_free_thresh)
> >  		(void)ice_xmit_cleanup(txq);
> > @@ -3166,10 +3341,48 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf
> > **tx_pkts, uint16_t nb_pkts)
> >  		txd->cmd_type_offset_bsz |=
> >  			rte_cpu_to_le_64(((uint64_t)td_cmd) <<
> >  					 ICE_TXD_QW1_CMD_S);
> > +
> > +		if (txq->tsq.ts_flag > 0) {
> > +			uint64_t txtime = *RTE_MBUF_DYNFIELD(tx_pkt,
> > +					txq->tsq.ts_offset, uint64_t *);
> > +			uint32_t tstamp = (uint32_t)(txtime % NS_PER_S) >>
> > +
> > 	ICE_TXTIME_CTX_RESOLUTION_128NS;
> > +			if (tx_id == 0)
> > +				txq-
> > >tsq.ice_ts_ring[ts_id].tx_desc_idx_tstamp =
> > +
> > 	rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> > +						txq->nb_tx_desc) |
> > FIELD_PREP(ICE_TXTIME_STAMP_M,
> > +						tstamp));
> > +			else
> > +				txq-
> > >tsq.ice_ts_ring[ts_id].tx_desc_idx_tstamp =
> > +
> > 	rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> > +						tx_id) |
> > FIELD_PREP(ICE_TXTIME_STAMP_M, tstamp));
> > +			ts_id++;
> > +			/* Handling MDD issue causing Tx Hang */

Please provide more detail here. My reading is that on timestamp ring
wrap-around we need to have at least "fetch-size" descriptors populated in
the ring, so duplicate the last valid descriptor at the start of the ring
"fetch-size" times. Is that an accurate summary?

> > +			if (ts_id == txq->tsq.nb_ts_desc) {
> > +				uint16_t fetch = txq->tsq.nb_ts_desc - txq-
> > >nb_tx_desc;
> > +				ts_id = 0;
> > +				for (; ts_id < fetch; ts_id++) {
> > +					if (tx_id == 0)
> > +						txq-
> > >tsq.ice_ts_ring[ts_id].tx_desc_idx_tstamp =
> > +
> > 	rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> > +								txq-
> > >nb_tx_desc) | FIELD_PREP(ICE_TXTIME_STAMP_M,
> > +								tstamp));
> > +					else
> > +						txq-
> > >tsq.ice_ts_ring[ts_id].tx_desc_idx_tstamp =
> > +
> > 	rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> > +								tx_id) |
> > FIELD_PREP(ICE_TXTIME_STAMP_M, tstamp));
> > +				}
> > +			}
> > +		}
> >  	}
> >  end_of_tx:
> >  	/* update Tail register */
> > -	ICE_PCI_REG_WRITE(txq->qtx_tail, tx_id);
> > +	if (txq->tsq.ts_flag > 0) {
> > +		ICE_PCI_REG_WRITE(txq->qtx_tail, ts_id);
> > +		txq->tsq.ts_tail = ts_id;
> > +	} else {
> > +		ICE_PCI_REG_WRITE(txq->qtx_tail, tx_id);
> > +	}
> >  	txq->tx_tail = tx_id;
> > 
> >  	return nb_tx;
> > diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
> > index 500d630679..a9e8b5c5e9 100644
> > --- a/drivers/net/intel/ice/ice_rxtx.h
> > +++ b/drivers/net/intel/ice/ice_rxtx.h
> > @@ -11,9 +11,18 @@
> >  #define ICE_ALIGN_RING_DESC  32
> >  #define ICE_MIN_RING_DESC    64
> >  #define ICE_MAX_RING_DESC    (8192 - 32)
> > +#define ICE_MAX_RING_DESC_E830	  8096
> > +#define ICE_MAX_NUM_DESC_BY_MAC(hw) ((hw)->phy_model == \
> > +					ICE_PHY_E830 ? \
> > +				    ICE_MAX_RING_DESC_E830 : \
> > +				    ICE_MAX_RING_DESC)
> >  #define ICE_DMA_MEM_ALIGN    4096
> >  #define ICE_RING_BASE_ALIGN  128
> > 
> > +#define ICE_TXTIME_TX_DESC_IDX_M	RTE_GENMASK32(12, 0)
> > +#define ICE_TXTIME_STAMP_M		RTE_GENMASK32(31, 13)
> > +#define ICE_REQ_DESC_MULTIPLE	32
> > +
> >  #define ICE_RX_MAX_BURST 32
> >  #define ICE_TX_MAX_BURST 32
> > 
> > --
> > 2.47.1
> 
