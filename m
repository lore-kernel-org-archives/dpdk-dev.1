Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAC3CCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 08:46:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 298B3402DA;
	Mon, 20 Oct 2025 10:46:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 46DF7400D6
 for <dev@dpdk.org>; Mon, 20 Oct 2025 10:46:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760950015; x=1792486015;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=P02qIATICyY2zOWOfhRRSNj+kOBoNbVow5dZI/Mfq0M=;
 b=S5PU6LX/PGbFexgUKyd6NDzOQe5v79wqjIDXyM7YR0vkzRqF7+8nlx5J
 GLd5kUp3Im77VjVwVxzvZJrnF1UGTS/5z/ED8oSB4ZzNbIdPC4XPGtG2x
 UWNeqtVKRAZpi3CEyr6tVE8Pq5uf+aUk1K2yzoWjD8mKM9JctVbfChdKs
 LUDSj8cMjbwbFX0OIDTRw+AC9Qv0W0QCYl+/1S2XZm14q+Y3AMdhDYeIn
 mxnomqAdPyuExxIlCtZzZmFpxKXPisfeLSa1N9AVvREz5XEkqHEYNHZmm
 hNuYL3wVcLHoynhTIhNSA0TTlivh0kzcHDlDuPEeOHserYTbWOTJpynw4 g==;
X-CSE-ConnectionGUID: TlgYU2VaRlKv+ZeJcGus0w==
X-CSE-MsgGUID: SbMExodiRZWyqj28rUueew==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="63159272"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="63159272"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 01:46:54 -0700
X-CSE-ConnectionGUID: Tldz6AjyT76HK7K2ajbKTA==
X-CSE-MsgGUID: UkcS3JQmTJiPGctE5BAHOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="220426608"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 01:46:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 01:46:53 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 01:46:53 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.28) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 01:46:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vO175niO7Q1bcvp7KSr40GQMQ1QYACga5S279idnRAyQovysza08iKn5d/X00Zb5k0lZiv1PvuktZK2JMC0pc/Atdvkalsy58ceFeSHC5qoUsb7HI+g0YPiqx5U8kqewoAJ1ZrAXCtFXr9PiDc6r9YzkIMg4bi42PwyY60EmTRyiI3+wlqySfKcC9vNS34I9pspMasLsndKOLfRHObmfu+xmQ10e6wd98l6geWZZk00+AY/pc78THwqvcQ5C236XFBu0A96sAFBdvgDJ8Fmq4p6a/foLu6I14ty2nzoSaoPvCrSkyQKaOsg/or2P5a2x/lG1VN7T4FgBOpTvZQ9Q5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnu1SaHFPhwQXccybvLxu3gwWtrVqd8b45sdOt5gKTA=;
 b=jGoCc1uYHF/cb6gpVc/EwWb5Wanxvd97b6EXy1va7srrIAqN8w4FpVJbdLRd1edqru6kZhI4wYrqmOUVyWBUiXtwLFG+Yt8suTmd8xNhLv//n1EyU3cNPeO+1JRZAKWnDfR3vkIRsgTwYmjj50QVGv7kIo0dy+PXtXNMU8rjaQicIr0BjW6oAmY6Z0u77/UVqjUy/oxYL8YdnrFm89NkmPIg8KFlY2pffBE7PTSeX8QNFddXGVSAFsgqIuOkvBy+G49gpPvgp9ddUDD29ExB0GQsuvSQBEopn2aHiSdVcX1bi7hUtpPxUusXWwpZNJGF87G9zYASnPLiPhnFUeNBGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB4981.namprd11.prod.outlook.com (2603:10b6:510:39::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 08:46:51 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 08:46:51 +0000
Date: Mon, 20 Oct 2025 09:46:46 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>,
 <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Ivan Malov <ivan.malov@arknetworks.am>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v8 3/3] mbuf: optimize reset of reinitialized mbufs
Message-ID: <aPX29qp0AcY4fzmL@bricha3-mobl1.ger.corp.intel.com>
References: <20250821150250.16959-1-mb@smartsharesystems.com>
 <20250823063002.24326-1-mb@smartsharesystems.com>
 <20250823063002.24326-4-mb@smartsharesystems.com>
 <aOftoMl0edarmSGB@bricha3-mobl1.ger.corp.intel.com>
 <20251019134545.203741d9@phoenix.lan>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251019134545.203741d9@phoenix.lan>
X-ClientProxiedBy: DUZPR01CA0303.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB4981:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b2c5a7c-bae7-4025-ca53-08de0fb53698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?p2qBNRyrvmrlOpHoGC56Ra2TfZq5MTZ5BVFb2vIWnbhgcmCIIB3rDqPOcL?=
 =?iso-8859-1?Q?Wt9pEhXl8RthInjEy/JKa3cLks6GQRH385RXJOCyQ76HAcDOpWtzM4x32d?=
 =?iso-8859-1?Q?PTIrAq2bcVXAtVxcM71E6G6Hzk6m1HKaNNYd5F8x1tsxKDmWpNfFcLDDvL?=
 =?iso-8859-1?Q?dEi9lvrnQcL6Fh1ggmXzPBq2MPBUulzh1jK61Ft3zT2pPso3LNQsaDaVWw?=
 =?iso-8859-1?Q?G6vfB7EXpeDqA01zP2tzEvM5eV9O+KAaH1dCTrld6a7fr4M6cjL/M1H2c2?=
 =?iso-8859-1?Q?uHHjU3gwypLq0Z4IF8MwUvMyDonTs4cagNhiOJndOe8SCGhxAeNWhf1Vma?=
 =?iso-8859-1?Q?30/4vbWLuSeRXQVE4CP47L9keix/6SLFIYvWKbHocqhsyyi1pMUVTQ07iN?=
 =?iso-8859-1?Q?VZ/uBExM5+dSslIQihfi38rCh19ccx3a15R0onIi76NYtUhjvIXHWe/eTE?=
 =?iso-8859-1?Q?nMSdCJibMAAE38y6edaILkyN9YkBCQRfFLVvqLiUj5IiMglUJfHOwLz+jz?=
 =?iso-8859-1?Q?7SkNgeUrM01w4GLHZtz0H0eqr7tRaNS9ljjME+hiK+9j4gKrLw3aDowcOT?=
 =?iso-8859-1?Q?odOGWUvtHMK7bv90seWcbhYPw28dNVXI3sPiLKvc13w1091U+ePNMlXoZ4?=
 =?iso-8859-1?Q?L50AzdSe9ZLYXmatkRB9sesCa3sG3vHljwFz7fYob3Gzhyh3Eln5XNSZxP?=
 =?iso-8859-1?Q?iC3CVZjf882OWqoFCRUMTs4Mou7CdSSK8vz+iQwffcHpoqRek66hqhjs+r?=
 =?iso-8859-1?Q?eqwRBpPgScFxGiCrBXu9c78Cx/B34+bhzjKvaH86m5gJ1RjrDCjrE2cnJe?=
 =?iso-8859-1?Q?c+jSzcRW47WcAyzSL20nHK/PSJMKllg1ZCuaTrAcBJB2JlAk8ZOuoQGtxo?=
 =?iso-8859-1?Q?3tJgUJo5daQdCcjZCCuLjT1v3JT3uRmljNqgig/05yhUSHpDo8a0+L7sWA?=
 =?iso-8859-1?Q?43tCxmmKmbFVq79r+qjpdxVFW74BdgweIq2QwaRPF0u5QyBO3oC9M30y2G?=
 =?iso-8859-1?Q?bioNtQaLn2MA9DZD8WU8Mmui5gDMVHAt2gqr8baqsm9KichVvP++jDqTLI?=
 =?iso-8859-1?Q?6Kf65NKrlnavJpY6mJvx31AW8x9JfHCUpbmClFCtEP24PO4jHab9mCIBh3?=
 =?iso-8859-1?Q?epCb5FTQQBN46+s13wpNuLbvfth/fkyccZF6EJygcgipraQtHIDR44OMBf?=
 =?iso-8859-1?Q?bzLLG7m8UN3Yt4p8MIYdcvaf2b+TA18LBztUausQ86SjQvrf5AiWiPlBcH?=
 =?iso-8859-1?Q?CUmvSRXu5/6pGpB26rJDF50Ch3R4iVGcL81aeNAoXR65BCm86S3HcP3ETA?=
 =?iso-8859-1?Q?PfCUVG0ioyImNRLlIIJowHN80aHstIl/DhLJP5shMHcj+jQOKw/RG41VKK?=
 =?iso-8859-1?Q?WvtBLOILEOvrWgD2DMFuxN/BuSHEuyZP8McP5uv9ll6PbGyaVpQk0t8NlC?=
 =?iso-8859-1?Q?0ry5BB1U8hCizFit76wQe0SVfy7khTrdods9/NRSZboLIPds7mds8G8Rkg?=
 =?iso-8859-1?Q?sUXVRCoIN47kpoU2FO5gGW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bNpXLCusuyaQ+uaOcMU3nEZZfoh3/tWSzb16lHG9vp/SNZtrd1o4Kc/buq?=
 =?iso-8859-1?Q?HI7tE3YmZrjWTrlQ/Vj6JkbxTGrYFIqUPhJeUxDaTQ2BEQtN0AIxhfjMPJ?=
 =?iso-8859-1?Q?ZkT8AeEDyXzMDB9NhmJDo5iO+cdKy/+m1ikOW2V9mwhenwFkraTf7huTa+?=
 =?iso-8859-1?Q?Rstdd4atJlJzmYxShPJxpQIgXcXsBV9CGf59r1TrJJ2XVVWOFXmdIXoZlq?=
 =?iso-8859-1?Q?OCKxLWg2K4jmaYl/t1RbRbXUWUjzgIXQ/5ftX/7o+gHGFhm9xRWyIhGusA?=
 =?iso-8859-1?Q?xYsQtN2bAbo4f9olvv1L7fBA8NyevpYokTv1RDPICWh4xaBBlvJ3nwfn5a?=
 =?iso-8859-1?Q?9TdXmOLstpsj5+mZTXC/FPIP4hz8nDAkGx6Trw3iZ/lrwH3LFVEOMz8nUN?=
 =?iso-8859-1?Q?l/Hf6nOsG19CKMc75p9IpmObadGoybD/MAG6AiUOgwHG+s2oGcIRFG4xiA?=
 =?iso-8859-1?Q?PBmQt0DFMOp3ajLYAFf8yJjHDrCEgquP4MYDUIN/cTsOu6yVwNZTY0BGzE?=
 =?iso-8859-1?Q?EBt7QC+3pXtbWhOKY3JmIR9Bg8ZqIy75fd8p1s5fcs9sAuWMhi1tgKjRTn?=
 =?iso-8859-1?Q?ADG1RAHKYr0el6rWscKiUa9GpgDcXoX+eCvCMlM3oppGlmR3q3x66Ankb8?=
 =?iso-8859-1?Q?UQAD0Rd1fR+STs5Nzf7pIoSo+sMHwmsymoy5ZI60OCFS5Te0NQ+X/e9ndg?=
 =?iso-8859-1?Q?3yIrdlwsJTJ/31A0VzmRAdXVW7a93vwTCVSvwiWKRKgSAQOJdiaffV47nw?=
 =?iso-8859-1?Q?9eIQbywrLLUbJmsvbzTtMFsvRR8+IpgzyRLQ6fviXBK8/x7MYwJUzanwBO?=
 =?iso-8859-1?Q?5aGYn3gNl90MIOY64SuL0198v07qrso0sAXirAZn5GKPE0s1rxxlct024O?=
 =?iso-8859-1?Q?GWJUh/kbB7dXO2blrzKYsR+W/Wr1bcbk+D+FsuuNwnLyKk5e0Nm8f4iMtG?=
 =?iso-8859-1?Q?fc7MsHI1TrkP8NC3KtdcGZCPDwUCoNaoOWWQsBj9f4NaKeDDFl2Ad+Sobx?=
 =?iso-8859-1?Q?p5LXxoummHpz7h1qLywL647WXb0B8F2hen7CTO9CPGbDWI8pfL6IxfuhMN?=
 =?iso-8859-1?Q?e3UqaCJqjN6sbf14HlyIp4B3Fk/uqfOG6fzSJ61NRR2nW5xNuE1omnCVTe?=
 =?iso-8859-1?Q?TeDknVf6CWQWNmx9myTdiyKj9aR89kT5PuTufIKGMYssbx6WVzP1IBfA1/?=
 =?iso-8859-1?Q?cqzcWUXgcaIqxf96QyIHYY4cpusresW7xe2UXJTlMbjAsDBT2UZ3bE62ph?=
 =?iso-8859-1?Q?R1v44hFZuc0vXSUTymJgiaMOAa9rZ4dgvVZP0T52bh+4NzFCA7D5Zg/T61?=
 =?iso-8859-1?Q?os3lQB8ost/AcH+h3o1W1f+wREvLlSHsukK9okmnhUUKMij2S52o66RIfn?=
 =?iso-8859-1?Q?5d85EWYejbzuNXfH/A6le2Rw4RJEgJhC7q5TXIvzeqdda29uYtJ44bWsm9?=
 =?iso-8859-1?Q?E3Iz6m7M0ea5TT4WBT5Cn25ujcskQ+0PAq5rsLNpm+j8jUg+qpZlH9e/8e?=
 =?iso-8859-1?Q?Kldz7IAyfntjJy8FSbeFd2I+cCo1dCmP73+m/ppzJrH7TuBxp95t1d/W0i?=
 =?iso-8859-1?Q?4Yb/W5Ig+J65vhOhp/4RRv7z/I5ytF9rt6Vh73GB9d7emL0aICyBz1un/R?=
 =?iso-8859-1?Q?9CjzQrBfngtO4CsMz29xiHWh368SDSpk0ujPdrWhDRFeWnNFZUorrMQQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2c5a7c-bae7-4025-ca53-08de0fb53698
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 08:46:51.5114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LhOd7/Uhv7YlBR/oDdMly2pjm6OAPzuzpso3cDrJW25ZRNz/G4dNSLHPGzj5ygusC6rKDBBeijgnRgKZdZ88VQnjhIaKL8iGRgZ1Snx3cM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4981
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

On Sun, Oct 19, 2025 at 01:45:45PM -0700, Stephen Hemminger wrote:
> On Thu, 9 Oct 2025 18:15:12 +0100
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > On Sat, Aug 23, 2025 at 06:30:02AM +0000, Morten Brørup wrote:
> > > An optimized function for resetting a bulk of newly allocated
> > > reinitialized mbufs (a.k.a. raw mbufs) was added.
> > > 
> > > Compared to the normal packet mbuf reset function, it takes advantage of
> > > the following two details:
> > > 1. The 'next' and 'nb_segs' fields are already reset, so resetting them
> > > has been omitted.
> > > 2. When resetting the mbuf, the 'ol_flags' field must indicate whether the
> > > mbuf uses an external buffer, and the 'data_off' field must not exceed the
> > > data room size when resetting the data offset to include the default
> > > headroom.
> > > Unlike the normal packet mbuf reset function, which reads the mbuf itself
> > > to get the information required for resetting these two fields, this
> > > function gets the information from the mempool.
> > > 
> > > This makes the function write-only of the mbuf, unlike the normal packet
> > > mbuf reset function, which is read-modify-write of the mbuf.
> > > 
> > > Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> > > ---
> > >  lib/mbuf/rte_mbuf.h | 74 ++++++++++++++++++++++++++++-----------------
> > >  1 file changed, 46 insertions(+), 28 deletions(-)
> > > 
> > > diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
> > > index 49c93ab356..6f37a2e91e 100644
> > > --- a/lib/mbuf/rte_mbuf.h
> > > +++ b/lib/mbuf/rte_mbuf.h
> > > @@ -954,6 +954,50 @@ static inline void rte_pktmbuf_reset_headroom(struct rte_mbuf *m)
> > >  					(uint16_t)m->buf_len);
> > >  }
> > >  
> > > +/**
> > > + * Reset the fields of a bulk of packet mbufs to their default values.
> > > + *
> > > + * The caller must ensure that the mbufs come from the specified mempool,
> > > + * are direct and properly reinitialized (refcnt=1, next=NULL, nb_segs=1),
> > > + * as done by rte_pktmbuf_prefree_seg().
> > > + *
> > > + * This function should be used with care, when optimization is required.
> > > + * For standard needs, prefer rte_pktmbuf_reset().
> > > + *
> > > + * @param mp
> > > + *   The mempool to which the mbuf belongs.
> > > + * @param mbufs
> > > + *   Array of pointers to packet mbufs.
> > > + *   The array must not contain NULL pointers.
> > > + * @param count
> > > + *   Array size.
> > > + */
> > > +static inline void
> > > +rte_mbuf_raw_reset_bulk(struct rte_mempool *mp, struct rte_mbuf **mbufs, unsigned int count)
> > > +{
> > > +	uint64_t ol_flags = (rte_pktmbuf_priv_flags(mp) & RTE_PKTMBUF_POOL_F_PINNED_EXT_BUF) ?
> > > +			RTE_MBUF_F_EXTERNAL : 0;
> > > +	uint16_t data_off = RTE_MIN_T(RTE_PKTMBUF_HEADROOM, rte_pktmbuf_data_room_size(mp),
> > > +			uint16_t);
> > > +
> > > +	for (unsigned int idx = 0; idx < count; idx++) {
> > > +		struct rte_mbuf *m = mbufs[idx];
> > > +
> > > +		m->pkt_len = 0;
> > > +		m->tx_offload = 0;
> > > +		m->vlan_tci = 0;
> > > +		m->vlan_tci_outer = 0;
> > > +		m->port = RTE_MBUF_PORT_INVALID;  
> > 
> > Have you considered doing all initialization using 64-bit stores? It's
> > generally cheaper to do a single 64-bit store than e.g. set of 16-bit ones.
> > This also means that we could remove the restriction on having refcnt and
> > nb_segs already set. As in PMDs, a single store can init data_off, ref_cnt,
> > nb_segs and port.
> > 
> > Similarly for packet_type and pkt_len, and data_len/vlan_tci and rss fields
> > etc. For max performance, the whole of the mbuf cleared here can be done in
> > 40 bytes, or 5 64-bit stores. If we do the stores in order, possibly the
> > compiler can even opportunistically coalesce more stores, so we could even
> > end up getting 128-bit or larger stores depending on the ISA compiled for.
> > [Maybe the compiler will do this even if they are not in order, but I'd
> > like to maximize my chances here! :-)]
> > 
> > /Bruce
> 
> Although it is possible to use less CPU instructions, the performance
> limiting factor is which fields are in cache. 

Yes, the cache presence of the target of the stores has a massive effect on
how well the code will perform. However, the number of stores can make a
difference too - especially if you are in store-heavy code. Consider the
number of store operations which would be generated by storing
field-by-field to a burst of 32 packets. With the previous work we have
done on our PMDs, and vectorizing them, we got a noticible benefit from
doing larger vector stores compared to smaller ones!

/Bruce
