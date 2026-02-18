Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ABDE9A047
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:03:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85D1540269;
	Wed, 18 Feb 2026 17:03:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 39FAC4014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:02:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771430579; x=1802966579;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=qNdJjAOZuPG9aO9jxpoUHaFkeKPPn+3umkz0+cjLbEw=;
 b=IaSq/esufgD/0lEPii+cEmGDZ5/Wl6YDEQH5oCq7k6GsPYITjG1y/llW
 hiFwqUrw5CG7SEBwP+eGYd0iTg36hY4kyzztfeKDIVJHlhx5pvp92vmgW
 PfwaUYxbZtaWufq/RUK6r5DGEzVNjQmo/5Mb78q77tEaUp5PkwMN95/ct
 JvPPeGuWIY4+sTO4kbdqyNWeSphDWEiKnlBR31p/p3NWURVCX05odDxj9
 OThgvqKf26fQaDjql/YUKXZnEy89uAviFof+/+ECLAUhHjSmNq+Pi4Cyt
 xbRcqZqXVcKlBFkBJUUNOiXRRVeS7DS/5gEtmMCsC4XJv42/Y0dhRDhZm A==;
X-CSE-ConnectionGUID: BC0Gl6unSVmTUEGr7upmQQ==
X-CSE-MsgGUID: 7lubYAfJTOy+lMiVmYkcdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="72551923"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="72551923"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 08:02:57 -0800
X-CSE-ConnectionGUID: 6BVd/iRJSNut85CCDGyfUg==
X-CSE-MsgGUID: JhtS2mF9T/mmQNfF1P81GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="218068648"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 08:02:56 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 08:02:56 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 08:02:56 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.50)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 08:02:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJPcGMTpZa4DrjABPu8x5WqDOggxVwfl4eSayxi1CIL8/f534PRFcxADRjdlaFvdRtyUSJCb8qSEbgVQp6655qFmr2y/nFmSQS4doHIC7Bhi+0A7cM57uTR+3eT5menpuT3GRQ2nROokqNxN4gbEaolG95WMETAxhrnT5QwS+CVSb1XALyAf9v83EPa8MEA7UulOvRRuX1kBI0pYwnNgaHzyr6IIulRXm7dzJ9jNCALn+xeX3KtKLJFg/+qJzKni0T5adixwdxQlH/DEW6Vi9beY1NmwKiPzkIYI8MVdb5+nSksL4e6ITBHTdy+modBTUSwXpu0DGWFfZ6+LUwro/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFnZx8qasevUYsvTmY7RCPW0FthnQo76BbsnyRIuhuc=;
 b=zSGtXVSh9ye4xY4UXD2leUp+GRX1PsnX77QxTg9JUnPQfMxf0AcWm19YzgiFHNPniRbYynElnVM7XwI4wKohfULnOw42LOvLYkuk0REs/6JGoBuDN49Cfne3I6tiZhqCVM67CbVPq9bKhq64H4OQRdI+E34+Ty6Awwy7ZOQCF3DZymj4qUkCemgNZpPDTygRyssUMeyA3HFNbjgIqr07Qp5IRy8F6i2+Czz6jS5nNb6Z4S6x2JABq9j6wgyuLKp0f44gPKFKzzipEe61xH7Bj9wyBZe7XEwdXGN+avnJbMXD9LP2eIrEZk2tXyvZlzKU/Fkan5X9TYlMdOstTR17XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV8PR11MB8771.namprd11.prod.outlook.com (2603:10b6:408:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 16:02:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 16:02:53 +0000
Date: Wed, 18 Feb 2026 16:02:48 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] doc/ixgbe: update ixgbe NIC guide to include E610
 support information
Message-ID: <aZXiqIrbhPJgAtro@bricha3-mobl1.ger.corp.intel.com>
References: <20260128091416.75683-1-sandeep.penigalapati@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260128091416.75683-1-sandeep.penigalapati@intel.com>
X-ClientProxiedBy: DUZPR01CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV8PR11MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e3abf7-fde6-4d20-1404-08de6f072c1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nv+ag9xX9BwXSur4Yx7rPDajz0Em6jZov5rt8ee+Zj5sCzWqbkyJwOLn664R?=
 =?us-ascii?Q?TBpzNj5HT+wLjSOFF0B3rfB6CuIlC0hb1ZtwY8+NKgN49AIYgIp/lmPHV+CY?=
 =?us-ascii?Q?R+a+gkq40AdqenvZhm0xjxqG7w20Wmd/US0LX+zTOH+5A5YuPFxOHY3a0vXe?=
 =?us-ascii?Q?H8tgRYcGXYIP/STKpLPV/ZfnZa0Wf2rlaPHLPdL+xsCiF+iKXSeYIjzxRbKj?=
 =?us-ascii?Q?eDsL4js58FcyP+fbEjZU/IY2iUlQkIDA/1O8XnjXpbr+hKKSh67FjY/LpUbm?=
 =?us-ascii?Q?EiPcMK90Aych7lbSl/0puZmIT2MPis6q9axWdR6FgtAe/wAx2YrmhmenqGyS?=
 =?us-ascii?Q?GO3OT+G7Jl4vh2o0PbhXacxBM9PtQqVCpLn+oaQlWbYVYXEkdLEbTX/XmtmW?=
 =?us-ascii?Q?CSn0PaBslqjx3NGZDgDCoAd4EkBi5qGlhowZ3uOGqrvTi5mSkAdkIpZ6qogD?=
 =?us-ascii?Q?qB1osd1iTsMzoI3/oopIYYUQ7bPqZj7hyJ4a0yD22m4aqDit76QWi2LgEYh9?=
 =?us-ascii?Q?3mB+HXB9uHfRjhUGJyiCvXRbJ5/NMz3/D42P8tGKGp7JFXOM/z8df+x5EZTc?=
 =?us-ascii?Q?Y+ghemZL+iRyxClvWQm9KSNj14iOnT2wwIASQ5rRvtgltrczk8cLe3nKsVc4?=
 =?us-ascii?Q?dJ17AGHQOrSooRrQBrWFLrXeGXFpYZgpS9GhAQFW7yDAlAIYYShdf87j5H0k?=
 =?us-ascii?Q?Glu19hyqDYME+vfoaKr5zahlgCHPBHCRlP5cybCQsioQbEeX8P4wSGVGHXdo?=
 =?us-ascii?Q?JI+rXKYO7fcE2YNCDNE1OfLgNBRqz6Du+ttlZXoSxEgN8+v+5z8Vh0hUBpSa?=
 =?us-ascii?Q?0VeojI7cx1BQdoCLyqvtBMAsLTzJ8SfyGnyW7KcyZU0rv+WIJEVE4STECsEB?=
 =?us-ascii?Q?OcWi0EY8VpMsXfGdq3+FDn7jf5ZiaMFw7ztUC8pzjazaz98NfVHT5F9v7NRL?=
 =?us-ascii?Q?kRdOm+0fgWCgFOabdqCXiAwyl8grqCZNbtBY0G7pMAoy7UP1cIKIZYU6X2nZ?=
 =?us-ascii?Q?CGnFoGBoRcbNsWQlv6ALuJDYGOo0e0KFkoD8T6LLW8drwGy7DANlDCadeuD5?=
 =?us-ascii?Q?9q+7en1gdzivjSV0WjYz6HV1vASCS+JHBqqSAuhab+CX6fDn/0+0zczjBueJ?=
 =?us-ascii?Q?HokU3iIeVReFoEqJEpLm+1OmZJfggAaIUfgy4G97zlZ2z+woFgPubVPFyYbH?=
 =?us-ascii?Q?SoS8Gru5pd+ZKvac3oIHvaHFcVRmn+3WcfS6n5IMfGw8mYulNPVwT/x8VDfh?=
 =?us-ascii?Q?qy5IAmvG16tlR5C8WXINWpCxOAXbKhGkWT73KDIf+u/Rzssh9P4tr51hRgy3?=
 =?us-ascii?Q?Abe3ZZTLOnKo52PHUZkffevcBgeQcf9UES88JhMhBlBCK62PvaLClxEdPsMQ?=
 =?us-ascii?Q?4/YbEoHBqfpf+RGIbkPmh5xyhrG82n9xtb/A+lwoGIQiVnn/JJDx8rUidVIP?=
 =?us-ascii?Q?TxTXaRM5+CKIiSSbPjXlL9KeG5S3K5jpXTPcztoZyD8lbDtCcuenXLXEQRT7?=
 =?us-ascii?Q?I5Ux8dstFyvkwcSIhGaCTWfYzG/3wsdT3GpQ2T51mFt8agO8Zu1MDgr4zbZk?=
 =?us-ascii?Q?emtKeZohTuZ9Cj7b46E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ivzkyCvDLKOw2fJC+ouA5+usW9ulpYA5d2kzMs1dKEgwRgH5hocWNhrBwkX3?=
 =?us-ascii?Q?jccG+95vT0shdIrAlgawtc3PwtSrZuU/3dZWymCKlAyGFNLYEtMhxPzFfCS2?=
 =?us-ascii?Q?6FjBFLCQajfiPVHfGWsKeW3RROO3uxo+Bt6kfyYEEbKgeeh97hnl2tMEFv0q?=
 =?us-ascii?Q?D8lb4wW7ef5ntlrDAKvHYfYCGP72sR8TodAfZ5GJAV7/U6RLvWnkq81knVYz?=
 =?us-ascii?Q?JgwY1tsitShiV00scB2U2ASzWPqkCFVFKOJ4h0sc4s/sZrD9UaW3hRhKBneC?=
 =?us-ascii?Q?3UDgYrsQ0He4KpFIU+VsJxQ6gBshU3WKFfsFY78fz+2C+CcMApiymynmujSS?=
 =?us-ascii?Q?2126pEc9YUrJbjzl/b6VVjFLoMa/c9jmacsVx2Cerzw+nYejgOtxz9viaK+f?=
 =?us-ascii?Q?I786xaL16WevoQ5mBXRr/X8edk+EbKReffwQxErtoIl0SHFv8vMUl14yu6uZ?=
 =?us-ascii?Q?5/tplGlNbU1/mWMHuxBcV0zYe+2idDuvEEAeA+o/LWqLxo6qbQ2XJQjQ0HY7?=
 =?us-ascii?Q?IjYX0ukxvUBWxQOxAr6uxn38x+1FWnuvSxKYKgqFKJrb0ia8uxk9qrfsOf1S?=
 =?us-ascii?Q?nAgKydobLU2NFOO+HFl+gfysAYCCv5jG4I8QBWPfk3QQiwKs7KGm5Y/sgobt?=
 =?us-ascii?Q?fp1eVg0u85oh+Cjl9LK13qO55zCc8Qb29G3tvOZ/akJzOngZzej+Eemsxu9E?=
 =?us-ascii?Q?0jMY7qTe1mlLa0wyq94OzxcV4ppZoLc4o8fDVACTwt8jbrPKn0s8kLrUu+O/?=
 =?us-ascii?Q?JPwDGwsIPh2Qt7rl6dQigPD+eyD4ctth8Tb7pY8QocYcJE6tDgkeiDXn19QJ?=
 =?us-ascii?Q?KusswBN9Ny3IO3MMPj+Pd8wJLaa/cgrNLemTgAIEclaVoY5Phc4Te3aM1GgD?=
 =?us-ascii?Q?ZtF6LS4/G6I//GqAkB6/QKtKehmSbKq+vWnau2lPhrytf7NQDtWwcjYiXJ2z?=
 =?us-ascii?Q?2uqaG3xnUXwbgcO17eWaA9YMoLJHXtjSi8x02Di694ULusqmg97Qf3mUrUgM?=
 =?us-ascii?Q?l6nGKbgJKk2NkUsofN4+4bazQJHGK/tsl5b85t1Mr2WfW442tn+lYcx2TLEp?=
 =?us-ascii?Q?PN4vJ2VFTk6HpQdC5tn6PQvBDyZunQkr9k9LUvSNQe1+DawcbvLOBVgp9Nl5?=
 =?us-ascii?Q?oQVUMpD6MZXHyYCf7eWhggs1QY2n/BadOihuDIFxNZKcdYeEDJLT1YgZkoq2?=
 =?us-ascii?Q?FrGRf7RspbKCg3QhFG+wSQOCdtdQ7E3FcmhtyavcoLe0Q9FGdz4e+fDTSJHr?=
 =?us-ascii?Q?Yxb8r3Gsd7Gp73ds+isyXhN559keTmAWPI/xsJx9P3raFQgD/tzxkQ9IeR9i?=
 =?us-ascii?Q?PIYvpOUoAkZ11tLx3o/1zq1pI5At6jVBPtENtuX5+a0Y0b4lCqReKY0Pth3k?=
 =?us-ascii?Q?PRJNd2FB1Q8dXGEVmsQJMN6tK+ZOj4QNCh6oVwJjBSfGERPhMCbfMVNmKgnE?=
 =?us-ascii?Q?7XzVMWWbFic4uSyy43LHxrphy0FmSgASV2ewf6RxyUA5WyKAEtxjKFv3x0/I?=
 =?us-ascii?Q?PAn7LsW4uVdfL8PGIj8JKXV7R5edOTWlR0h7YknunoTZWva4wH8UKVN3BPWx?=
 =?us-ascii?Q?SkgTbAa2fUEhmxyVlQS/VoUboQjYUuHmk/pxZjBwzbls1t7spXtNx9WQ1Cvt?=
 =?us-ascii?Q?ViEuu9CsTX0eJIT/OuNMc/zEgeab2R5axg3ssa+g/r08zZQ0+3xP2ylCShv+?=
 =?us-ascii?Q?OEiprnhMOLyeb3TuZu/Bduflcc+V/+DpTziz2/AuhqUdi3d5HzTWm2+rekqP?=
 =?us-ascii?Q?ii4ajmGUGXRrUxQTFrACY71j18HA/P0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e3abf7-fde6-4d20-1404-08de6f072c1f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:02:53.1909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmssBcv8DVh2oMcd6CcyjyCPl4np01pCI49Ii7KwGtsnVaDhbhExyBH3+HW4gw5MEQTCMFwSdftGAJnU5cAzTr38/D/RNM8sBEAyPqHjTHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8771
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

On Wed, Jan 28, 2026 at 02:44:16PM +0530, Sandeep Penigalapati wrote:
> Add Intel Ethernet Controller E610 and related E610-based adapters
> to the list of supported devices in the ixgbe NIC guide to reflect
> current hardware support.
> 
> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> ---
>  doc/guides/nics/ixgbe.rst | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

thanks,
/Bruce
