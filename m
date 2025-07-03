Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100F2C83F03
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 15:21:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E684640267;
	Thu,  3 Jul 2025 17:21:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 4232E40264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 17:21:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751556094; x=1783092094;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=0CpKTmo8F/vZzA9/TkxboN6dsSCjbXENQJUgXLmGITg=;
 b=QxXAAbMs6JdLZhsT3U5K4zjkB3Itk1jPed0YwNARPXIQMflWwXXhhk2p
 MDYBBSYB6GZBFyFcdgkMleD6Lpl8q7svFDEOzQD8mAPI1nYQ70TXDrfIo
 rqT3iaCHgB8LdGchqoxYOwVkrBJ3+ifEwD1BtdyWSUtfXBIezp8nlLsTY
 hvD4+dyi4zdO6DSxHJf4lMwckhCAef6q/AcxDJox027RolkYZMnLqpdoI
 BoH16JF18irgqzj8zG3CCaeYqTTXIGXo76U/1SZzRbd63DnJ7UW76sgsU
 CmNB8yeAVIYRMFR0MCXQUhuJLg/aDjK7fyz7nDg1YfWsCO/V4OnsRp+vw w==;
X-CSE-ConnectionGUID: wOR6MiyYSoi7XDS/9xWHhw==
X-CSE-MsgGUID: +9gRRjAaSOGILIRWEx6veA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="76434009"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; d="scan'208";a="76434009"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 08:21:23 -0700
X-CSE-ConnectionGUID: L8qRm1aFRliU9bwqkaGa1Q==
X-CSE-MsgGUID: wZ6GM8d1QJSDCqGUhAOfcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; d="scan'208";a="155143421"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 08:21:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 08:21:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 3 Jul 2025 08:21:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.72)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 08:21:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oc1oAjbJVCvUPlr7ZsY1SzA7m47R8wSMVzfR9gXP+D74QCmc2FF7OkPcbOpxp6Xi2zAgCNoLpamUmyr83f96EMuSEp6WzBHvFaWpsT12EOcskPngf+JgmK1pfAl22NUR69B9A4S7N0Cgc2pezTzsiD2DxrsheeeLSYeqcjShz98EcOVzR6MHm78UBGnshQ0aU5V0zwDt6+lO2jghqF6Oe5cXl5G9UGgm+STePiHGu9WbSUpvLpNqvRBtfsxgLUiawse/C0g6+bAMGdLoA5wJKWP9OZ+sK8YXfxOQwf9w3Y3MVClGFY+ptVFDphq6Y1HxQQTzju/NL+RZwEdwVJxnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1nfCBjf9pWiUPwqFE1J++92Zt9gytWefDJZhFWw/YU=;
 b=M20on2e9QH6MLWPb/2sxc+ePhmZiFuX5sablXMj9ogwskCrnRfa6mv0I9fg8740y8xjv7xCSL7EVyk7QefBW3Xy+8dPHM3K9BsTWNWSkqshpj87MCR/uq1slc3CghgNzCuL8hzqP8VlW01UaQfmFjG6kdmSnFYHw0jT59w4Y0DexEmZ5bWB5nSBJIoLcqJGaHyA12/KzhQr6PWkhiPGwn7o/LHTWrC8PmkJYiGeNLvgr4hjglzQMCSAOLLmNeyekm6YKGPkHcw33N5tHLNObuvYU2Hfi00y9Wc77cIhJ6xSukBmkf37ObKrL1Iv14zl5o45KBKbaOrs0H+2us7MrRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB7140.namprd11.prod.outlook.com (2603:10b6:806:2a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Thu, 3 Jul
 2025 15:21:06 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 15:21:06 +0000
Date: Thu, 3 Jul 2025 16:21:00 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <thomas@monjalon.net>, Konstantin Ananyev <konstantin.ananyev@huawei.com>, 
 <dev@dpdk.org>
Subject: Re: [RFC] ethdev: TX mbuf fast release optimization
Message-ID: <aGaf3Ii3OxErvYEw@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FD87@smartserver.smartshare.dk>
 <aGaQNxwbTTTF0Al7@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD88@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FD88@smartserver.smartshare.dk>
X-ClientProxiedBy: DU2PR04CA0077.eurprd04.prod.outlook.com
 (2603:10a6:10:232::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 114ad5fe-601d-492e-c78e-08ddba453aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?+AV1SjJFG6WNODgEQln4R63lQ5W3nnywFF4JcKs+vEkM8PCpLaZGarkN2H?=
 =?iso-8859-1?Q?I+vzw3I0/2q1EE8gve9dbvH9p+NA20sxgpO4pv2PvsCn3xWsgkVYAHTzQ4?=
 =?iso-8859-1?Q?Oego4OnIpJrZ+fFy+1bfKWytE+ueGQ2GZeN7aVPZ1nlwCk8TJxgtqBGZ7V?=
 =?iso-8859-1?Q?HwcalXa8ozS44v6EjB2lJRWeIMGPfE0macv1J6FriEcGVOjuUFEzTDjPDz?=
 =?iso-8859-1?Q?MDyCNY60z8EnbJUHgrZXZ5y6X265+bZBxpvlN2V/Xy4hol6OXhGAgCaI0c?=
 =?iso-8859-1?Q?rnYK+Al61GWGqJ2Um6S3ERYepFSAX1fxpBgnyfNuXcW2h/8s2YPEzm3o4Z?=
 =?iso-8859-1?Q?wWgC5NoEUJ3NAR1xTClOyy1B7NCBaGRaLMGOeWf1l2fGEO4OIzL1dINwxX?=
 =?iso-8859-1?Q?l5ByH67TCtBqZs1889EzkSxDc2liyNL5w/4dwvCPjs6MYhfa6sEHernGOr?=
 =?iso-8859-1?Q?t5MOEeFY+HBDvISWq0A91ujSCSCtg3z75Tl5Tl8WVhxHcsqcoD8MgmIWEv?=
 =?iso-8859-1?Q?jE+YGEnlI1opvSX/ychNVh/jotI/+I+vt0whqqL+1cUjXQjymgbyEBwKSL?=
 =?iso-8859-1?Q?ZK0daiJ44P++uPATyIimB76LAnuuo9Tohi1UzPRHX6h9P0RBQd0I33f4Ai?=
 =?iso-8859-1?Q?oI7zYq4Udbk9lOnorT3lNWgXNrR+tu7Cxiohj+pmZ2EYBHqwFRIHV8BFAE?=
 =?iso-8859-1?Q?cbgqz/Tp+qawVxtU4u8KzcHUZXEZbCHwhmfsgnrmTR+LaZdO5QjCK3V7IS?=
 =?iso-8859-1?Q?NHjEUey0CVzejieeXLSaORiP9wh/+iI0QrgeE+UhoGLSincOlnObvSI/ja?=
 =?iso-8859-1?Q?K2xca4qijODvYR4BdVHsJJTUp9Pxsc0acq24pU6i05PuDhJmzUOntjNdRc?=
 =?iso-8859-1?Q?53wVMB/JOt2aELJ4VLbhs0TMGAWo5Ah7Y6ffUGbB5MnOF/NGL+Z2jGLgqw?=
 =?iso-8859-1?Q?S2NOSPuTEuKItVbxbDUV74E0mVLyGVszHhmpk4dDROn1IZoohh9EusW8lr?=
 =?iso-8859-1?Q?vuzlst/NIbB1geb/MyyPeV13GniM4pW/mUnSHJsWX9Koiqn0jQHtjDTgAL?=
 =?iso-8859-1?Q?fQq4ixvZsC+IoqKwllakRp2b0/AYCiLwbCqPrcZ20p5atXwFb78mSLVnGT?=
 =?iso-8859-1?Q?QMWQegZHfw/I57iSZUqX8fKcqT8eIGwMmDW/ru2fBZ1sEFXU+dXUElOFx6?=
 =?iso-8859-1?Q?54wDOqk0TpIlAZuc5y4MwTm+NnJPkSGPcemRtwdR0puEkSrrfjEGsRI9Mp?=
 =?iso-8859-1?Q?9pLvIjMm9qgJSQ8/tPwtiftopdoBKNRsBN3hq29ARaJwrJXyZNA2MBdGK6?=
 =?iso-8859-1?Q?sEfCrd1vx6xSn0qaF959D0bOWXuRVRZJMrIphVD67HTj9uqcQlRKK+s7+J?=
 =?iso-8859-1?Q?qa+Mn11MJvg+GQGrAa4jqipJa0JL/YozWK9y8IQLQaG8U4mzS6hOP69nDu?=
 =?iso-8859-1?Q?Q8U3V3eDkHo0j0wQjJ9tQXBkdJhU6Y/zFeitM4o7a5vbKDH/L5RlAyMDSc?=
 =?iso-8859-1?Q?k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?UzcEakVOhTr+Lt8Ov7MzfOjYh2hd0xuV9npmWuWCoykUyM+Jy9ss3VDWII?=
 =?iso-8859-1?Q?RSIJxvFTB+0nKagO7QusT+Fs3CtfXJIWVJv0Huc3q1W0ispEtOIzU020b6?=
 =?iso-8859-1?Q?aVbAw7szEbR572pEKYiHFQVJmwf8SZ/oLosAGtuU/80sIu1/GS2rM7f6Ue?=
 =?iso-8859-1?Q?M324f7MJ3884scFC4frPPq/wC+y2KprO6pyWibmhPq7MUsOwEug8LB2z/m?=
 =?iso-8859-1?Q?9k19ZirjG8QVhyNjSNgnU5y/szfjyYebBy8XuSe7LrA9tM7fWtuRuCkB5z?=
 =?iso-8859-1?Q?l72qp86j806T57gbesmosK9TnCbFvA4iLNVr5BntBorNSdOb2Lajweril6?=
 =?iso-8859-1?Q?61KELkAheHPfWKdFamr6P58GXchvfXjsV+RTey2SxEy11oCIyHK5u2ATRY?=
 =?iso-8859-1?Q?XkA51YZp4eOW11SwQH8GhDmIir8VEzQGnzOlpDyeOOHYA7YdHexaQfZJfu?=
 =?iso-8859-1?Q?M+UCKTbG8NG8XRGn4PIJVHfdrTIPhXjP6gRsaiwxZfbP2k8LnSDCi28I0E?=
 =?iso-8859-1?Q?6DGlMgZ8e4/RLjKqviFYWGeG8n83ZiJoKCHr6TngeWArO0+sSqXUxttpNq?=
 =?iso-8859-1?Q?1jCZ+gQMzefUY8W2tTNhdyLMgfHXthleb14W4aJHOtWHSXU5P9hDPipjzv?=
 =?iso-8859-1?Q?HFaM2mSrij+K5ZZnRX/TnDDH8SDsODGBg/bVfWUc59oT/ZlQ//utTs1NDp?=
 =?iso-8859-1?Q?hMdUm6yC7Il+Ln18H7DBNuqtK6ZVPfuEbL4Vywzc+RGUdBQW7B3DTTPNLo?=
 =?iso-8859-1?Q?eMaTjNCt4H/b5K0TuLZW3+ChJCbO0O6jJCZHu0SaWFyt9ebl9/HoEwudH3?=
 =?iso-8859-1?Q?Pdmfhh2KE3EPWP9YwaNQXaFa7MibCJXW53fFWwClDsXjhw4lcf/sSB6gks?=
 =?iso-8859-1?Q?BSXIOLwoI2IpEOZb+P1OEcVOW1hvxKjvjP3o2RK62Usfd3RO0mLTIH0Tmw?=
 =?iso-8859-1?Q?82UyqQEiRxQlLF3HMUZs7hrnlvXRPMJ4wB1jLF3jIEb1eWThWUYmQxYjD6?=
 =?iso-8859-1?Q?Ps+FSF0K7j3ONWuZaLjajUMc1Eg6IKFBUjkQNeT3lI/3GmNVJr47I2eb7K?=
 =?iso-8859-1?Q?UF4WwgyAF4gB6La/ALbRzai2hvvP6MAh/0jxKiQn/bJB9/y+7oQ+H7rgav?=
 =?iso-8859-1?Q?0XrvFc9khZFiVx/mKRiSCTKr98N0XDwuTaSLr8asvbhrBSUdzFJe29375A?=
 =?iso-8859-1?Q?QsYhQixZV5Gk4CZZ3kjq94a8BNwY1ZbLgzq3qHX471XgYiiIkpxG8ipoJo?=
 =?iso-8859-1?Q?+4SmAlqz8OlcwDdWYwH9tS83ewm88XPzZyyk36eh3UQxKGaUSWH5Z2RErb?=
 =?iso-8859-1?Q?v+1v0SCHwtWLpZwBaHkvj5O1G4zJ47C6Z11WF0Rd4H/CTSnsiE/Ajd5Wlc?=
 =?iso-8859-1?Q?D+lL9VXOpwvvBDiS7wtIZ8PoI21omURKOoq+ztLA1HouWxr8S7reuyXXzC?=
 =?iso-8859-1?Q?/7ARDRwQiyBky1Vo5rQK4JS9b08/Dsb+Nodwmhrx5cjfHojlzMserYOGiL?=
 =?iso-8859-1?Q?5s8FqB+Zk8FntVJMidcKJIAFl2AueTtzRqlEbvsemhS6ZFEuGF/+2Sxnso?=
 =?iso-8859-1?Q?rPQSBpqnqmr5jDJpqOOyISl/hBi0cSwtZS/Zgou1SEX/6WsMAwq+csFcwg?=
 =?iso-8859-1?Q?qN+y+ikCCrWNpv7mw2E/4IQmjGmMlKFoSuINMAHtw6uPTOHGQqKFWBrw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 114ad5fe-601d-492e-c78e-08ddba453aea
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 15:21:06.1964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBkmjc0GXfr7fRlSYtEVumWnlOttDqO4pLKrRZMx7k9HScPzZWLYo5hENqdWykbSMhiDM3OW368x0uvMHM1Po14FI+4wndpa0IyX+f48jQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7140
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

On Thu, Jul 03, 2025 at 05:12:46PM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Thursday, 3 July 2025 16.14
> > 
> > On Thu, Jul 03, 2025 at 03:59:14PM +0200, Morten Brørup wrote:
> > > For TX mbuf fast release offload, I propose to add the mbuf mempool
> > > pointer to the ethdev tx queue configuration structure,
> > > so the ethdev TX burst operation doesn't need to fetch it from the
> > > first mbuf of each burst being fast free'd to the mempool.
> > >
> > > This modification of the struct rte_eth_txconf, and the requirement
> > > to set the mempool pointer if the RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
> > > flag is set, will be an API+ABI change in 25.11.
> > > Should it be announced in the 25.07 release notes?
> > >
> > > Note: We could phase it in softly by letting the ethdev drivers
> > > check if the pointer has been set, and fall back to fetching it
> > > from mbuf[0] if not.
> > >
> > > /**
> > >  * A structure used to configure a Tx ring of an Ethernet port.
> > >  */
> > > struct rte_eth_txconf {
> > > 	struct rte_eth_thresh tx_thresh; /**< Tx ring threshold registers.
> > */
> > > 	uint16_t tx_rs_thresh; /**< Drives the setting of RS bit on TXDs.
> > */
> > > 	uint16_t tx_free_thresh; /**< Start freeing Tx buffers if there
> > are
> > > 				      less free descriptors than this value. */
> > >
> > > 	uint8_t tx_deferred_start; /**< Do not start queue with
> > rte_eth_dev_start(). */
> > > 	/**
> > > 	 * Per-queue Tx offloads to be set  using RTE_ETH_TX_OFFLOAD_*
> > flags.
> > > 	 * Only offloads set on tx_queue_offload_capa or tx_offload_capa
> > > 	 * fields on rte_eth_dev_info structure are allowed to be set.
> > > 	 */
> > > 	uint64_t offloads;
> > >
> > > +	/**
> > > +	 * Per-queue mempool to release the mbufs to; required for
> > > +	 * RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE offload.
> > > +	 */
> > > +	struct rte_mempool *mp;
> > > +
> > 
> > Is this really best put in the txconf struct? Would it not be better
> > just
> > stored in the queue structure on free or Tx of the first packet? That
> > would
> > make it not change the ABI.
> 
> It seems natural to me to specify the mempool at configuration time,
> because it is a configuration parameter.
> The txconf struct seemed like the best place to put it.
> 
> Fetching it from the first mbuf of each burst at runtime, and possibly caching it, seems like a workaround for the missing configuration parameter.
> 
Not suggesting from each burst, just the first mbuf seen. One time only.

/Bruce
