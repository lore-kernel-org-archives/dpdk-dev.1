Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D386ECA0EED
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 07:45:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22C56406B4;
	Thu, 28 Aug 2025 09:45:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 2C0224069D
 for <dev@dpdk.org>; Thu, 28 Aug 2025 09:45:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756367144; x=1787903144;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=pwYseOmitajRviNLWogNtX9BpZy6KbopA0vKHsvC92o=;
 b=DiiiblJ1KX/ye0AmA346BT6LW8n1Rz559nnGYA38HpmOYFVdQzCyMEL2
 gd55Bs2hZD154pjaryJtX9zbV2zYNBJ7ZmrtAgQVDRbDf+dAywlNVWrNY
 w/5ff2hllMK1Ae3TgiODLDI0xPDxRLP8DvqXwtx/dajxX/TYB0IKHjsZE
 cw6XuLT6/its56c1kDABdNIRh22MSiR4zwnbDntXM6n9jwY+70UTFdVsU
 x4/KsjHz8t7FrFRBZX2HnFlL4kMobybtYDFPYCiO9lafOZYu2z6IUGzhT
 Wybj5r/0wkcZRaHUj8RzY9UCx+QnsnNxj7dsNsnMN84TYezgULl38HiBK w==;
X-CSE-ConnectionGUID: IAbbCuqAQ06wQSknOzbwDA==
X-CSE-MsgGUID: w3Ll9sBtQLSWxgI8RLrIaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="69721861"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="69721861"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 00:45:43 -0700
X-CSE-ConnectionGUID: j32rrSKTRGyZNEBw/Uc0rg==
X-CSE-MsgGUID: wpRozCp7TNKpeZhB/2dLBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="175318103"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 00:45:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 00:45:42 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 00:45:42 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 00:45:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkhXsqX73Sql2DXF3IU/RduBtlNLFZVXeWETKI1I81YLu4GDcSFoaFfPf+gIQkQ44BtD+z7W99B5r7ii3nxx+UcE7Z9XBx0U1HWcBa9+fhbHjWgqGjBJ+/PXNqC2hFkYaR2sJWO+1RPHjIXijWEE6ra3MeVbL2DdS2K8YNpJgYxr/qeSClT49ePrVUzp1hPKHPhlVCl0GkUFlnqNFz9aEO/v6D/Jug4Grjf9CKwqUpSakp2OrPntV8l1I1DeI5vVSNDrjK9S0Kvy3Cgp0qo2ORCgEa1SFm3EHPd27uUSbfeZ80zLQv9qQvIZNFynQASw4uuqn2E3TSKtNmHpUJ1fFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkwBxF6hki/YRcQ5Y7gYZ5GcExTt0z6nUhfChbMQjOs=;
 b=YguL05vbVRgo2oPZXxwsX438XO/UpfJ6z1IUPppKllldt8qV88gw0tvqJcYHqngzqRILRoFJpKs1X+aLbC+2UDucHNELrVV95D/ijirNgci3MF79RGVZz+khj8h/GFl4TPkGxWzUQBCA0+WMFp4MUS3s7EgqX+bOZOjWzEW8K6J8FMgv9nAF/kDNG3nHJ4Mv39uBIkNUBKfw1Vq32+DsE5O0lOBgJYcuhP6CrmKsictErHWSJ+S6hRNsCgZOy856axX/wGuoTzd/5hMD0OkwKG8PV7082fZ3SnLAtFj3FFjJjuAvLmaUKtPeYb6RsVAwSMYn6IEf/JbpncPmFMEp/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB6787.namprd11.prod.outlook.com (2603:10b6:303:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Thu, 28 Aug
 2025 07:45:36 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 07:45:36 +0000
Date: Thu, 28 Aug 2025 08:45:31 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [RFC 7/8] telemetry: avoid potential name conflict for handler
Message-ID: <aLAJGw8Zzp1mqcY_@bricha3-mobl1.ger.corp.intel.com>
References: <20250827231528.236172-1-stephen@networkplumber.org>
 <20250827231528.236172-8-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250827231528.236172-8-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 418bd80c-6c8a-44ab-8a67-08dde606e000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iM9/1F9a5Sku+GCqlxSKPW3d+b4LtWOnMr2779G3mbuUFuiUQrex9AtDG5JB?=
 =?us-ascii?Q?WxC5KlW25HyzbHqmzk9lbuZbRY3iJte0W5dJSMiMoWHrCwPr0tgQ8zRFYYiZ?=
 =?us-ascii?Q?pUy6cDvhR2sYdqzubG4tCxlnsi6NG22ockUbg4Bzk9EP285gY+iMlhhUusSO?=
 =?us-ascii?Q?j+etMaj+c0rYOHrIxy9VOERn0+oN0A3/vp2O+cYT4dgQqcXn32awnFDTms9U?=
 =?us-ascii?Q?ijI6WocpngOJ2EZkWWPVbcACMlbRCLUcdi40n1asiLYTv3HWZ9cVl7tZoECm?=
 =?us-ascii?Q?YcfA7tJFas8M0Wh4HG+SjH0c38wSqS3Q+ApEqmimw26p5FQLkHyB3XVfiDRp?=
 =?us-ascii?Q?YKthcFuMNhaEquc5yYADjaoy7I6R5YAYEFUIVNLCRnY8V1uGyNpZHhCOBU6+?=
 =?us-ascii?Q?bHhxc90JiucnlFkTHSSsA22YNdxgufGE6/EK1iRadEO9+aGc1uuwQJDwDC2P?=
 =?us-ascii?Q?fFgLnJ+jfAMU77T8K/O1+aWUfV26RJCh9AOc6TbqR0j6mxCx0b6/SHj5Iyxu?=
 =?us-ascii?Q?Mk0SljejN4/IGXcpG3kCaGgmZMI8MtSIXohh+3XyaW3xy0F8U/NaLIoSxH8t?=
 =?us-ascii?Q?5GkweCrZ3AJd17CUtHDirCHqNcUf33lBb0bO7R3GzSuE885b9gdFmZTrOzqX?=
 =?us-ascii?Q?yLvwUFpoeLlaAW9kVZ9JgXb1bYSJ80CRxN3uYQpRwpA0Mu3neCjMGsnX6Zb5?=
 =?us-ascii?Q?D1FpU8fPP86fxbPXWqQXdz3ypBvsKWYS8oD2hP8f4nioZo+T3DDBYW5X94pH?=
 =?us-ascii?Q?VlGlufD9O6pRznnCeMMCLv1TZx9rIpncvqj613HGgXR/OufqD64D9MZV4Wst?=
 =?us-ascii?Q?uRzPPggeRTn9NBjSbBMDfWTiHFY0TxWVti90oCvjx7jIOh5/YADkZjEWyZ4N?=
 =?us-ascii?Q?eULZkdz6H8KQh7vetVWRZNGUTEKkdEFn4nQvM5iP1IsWr+eK6xA6pzAhExfk?=
 =?us-ascii?Q?PvwsgVfOqOTxsRfiysl//QRAvakaOVyZgwG2Avs7ek88v5sDqTz/RLmQd1VS?=
 =?us-ascii?Q?OVXDrX//s/QPEZ7BBRxMcdTcSbGfMu9S52gphPK/yx+8USUP1OcxTh3KFdIt?=
 =?us-ascii?Q?jktCXiqM+7fv+yybpq/Aj1NuI3vr7BEIyDCgSM0QBIzvA57nY2z6vNmBUhUG?=
 =?us-ascii?Q?ryeYHFyaEvoT+w9wyr552M5xzg7PJYx8y+FWgAtU0M9WjUzwaGeJH8kTEJbC?=
 =?us-ascii?Q?4vhOiIY0KOwo1WJT+4QBFg0XuzxSraencaL+LuLKrSoHxJN60UkZbZ0CpjhG?=
 =?us-ascii?Q?owuu4akSVSDyPdZSwaDy0xfaPt43ZLyfjmRLMDlP5uUXPIWLOSC9tV6JL6fB?=
 =?us-ascii?Q?VDQcyjWN0obNTDwKgYUcqJK24QJHIBVp+0Kg+7ikIexGPXsw1bQm9LeleRk2?=
 =?us-ascii?Q?HkxSPEeZZzE2/dUjcCPJh+cmSYlVPlRyXU5bBV0k7lrakIGnyQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cz3dcmulJl/xPxAImReasuQAJ33pYGhhd3C4kfPtyQReo1hw4/ZujOlSGNRi?=
 =?us-ascii?Q?8oO6QWQ4PNOuDkvLpJbqI5O9V96QjW9o4mdI9buBoP8HGXoBuuGeNwL8wmy9?=
 =?us-ascii?Q?AujPq4JY5HWc7YAFJ2FPmbInU1+bzLrG8kbDT0SPLQIC2eO8aVlzMLJvscoS?=
 =?us-ascii?Q?LwalcVJcHsSk1bwgmSE84wy7HIFV9MJ7xcA2iP9w/OC1kstyNYZEaKUGCDML?=
 =?us-ascii?Q?cvi9CBQcdeskhqm0WCo/Ew2u/e3TDHnqTDJNmmJ2DvgF+9xsyhT2KBPb/oaF?=
 =?us-ascii?Q?tkl6AkElYglvAC59dWF0hXCWe/9d0TUdWkdD9HtGiwveVo7jxgwGs41w7p1r?=
 =?us-ascii?Q?zmDL9oEy4PjacH6pK+Esl069J8lFUuR0YDQs4HBTbmSK5MQsDovHlnCRMzXu?=
 =?us-ascii?Q?LfuxATYXEd6UFyxCVzO1G4uyTqd3/apF5KKXBRSNcf0T24b88xCJ+4WsdLcd?=
 =?us-ascii?Q?6mfGNinDeawaNFirz0HYqiQUieEMuktxQbHms5/XMoKQ9h9H/zY82PwWClVt?=
 =?us-ascii?Q?UN6bH20xySJ5BqYHrQ1uxOMQ1Ys7CgqZDmeuv5R14fMKB7TfgduGozXSoe/O?=
 =?us-ascii?Q?L5x/1MihzmeQrecK9LrgjWEcR/DZ+q8brp/+eR7IJje+KOJEYnDrJulOoDsf?=
 =?us-ascii?Q?lSh/o7XcxNzWza27PvePP3msoGvBK/6dPAbbLC0w7urt3B8bM0wWxCKnIxPd?=
 =?us-ascii?Q?vHjlQE6Qmy0uVuJ/TcGQDbDkzAqsdi4ziIY8Kj2XObQynUCFn0eB3A9BudsY?=
 =?us-ascii?Q?VM6JNryPRCXJg11uKC3m+7sK3c+gJSrfTL1pyTfvy/tZgDeP0uRW6RBYLY7L?=
 =?us-ascii?Q?Ic9wUVMGwDMJ9+BWSEG/4VaQGBGIjWz0pnNjGybSXrSedB7xWTCegVCq29ib?=
 =?us-ascii?Q?VCTYmOPMma0OsUX4wOvnZI2MZzK6Z8Se68T90QpY05jDSbdaPwLchSbmn3xZ?=
 =?us-ascii?Q?VsCdKPhrbNRo0i9TSc6kOT6g377NEdM8TW/K/FjfGD/czRoGD6xslYsAUIYj?=
 =?us-ascii?Q?waG7qwl7Kbdh2OlqepA21Vb5irk6g6tzpTcNsmKxak/TT10CI/vMzO9FwEIc?=
 =?us-ascii?Q?+YXRfxMVmla4o1gLw8URSzO+nVGrdlw/KurWOFUqQxJt9njgUjCueUtSmAMF?=
 =?us-ascii?Q?y+Z/py5PlNsezibWCt8i+wlYeC2PaxRt4d4urA3W/KagKqP1y+ulr5u8XpGm?=
 =?us-ascii?Q?VRJdMewZmNuattSonZE7fVbBX0Yy7rHlrg1pJQJbuar2XXvonBk7UZTw1Vv+?=
 =?us-ascii?Q?Ie7nhcZUxeMfjKa7t9xHaILznVkV53D0SUsptwbsaEyLBnuf/nrGppwunhs7?=
 =?us-ascii?Q?IevDOx1XZ6icidY3bjfR+wnFidM8aNrdv+o04tgTNNkqR59ndQwDueZzh3dK?=
 =?us-ascii?Q?IpK6JoCxjjN2NirN5/g8KQou+67m7UDHLMX3wdjHTS1tDQwDglXzaToyzbXD?=
 =?us-ascii?Q?gzvTwqtnF0vK4FmMjpe79cB9Q+SSc8Tea2Rayrf1si7ddJx9IgdipvGFVmeT?=
 =?us-ascii?Q?ZBKeA47xM74qN5vdl1xtUpNfQOvdgdHRIKjJGRVXwyDarnGunC+KM+nCJQLq?=
 =?us-ascii?Q?JTCa1Ys/DrSpwPhpwodSe3A/FU/I8oNWbIuzC9tRfEszjc6dCZBJqTdXEdeN?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 418bd80c-6c8a-44ab-8a67-08dde606e000
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 07:45:36.0224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KRCRw7M6L6lnpzCwuCrEy0unYD197crRl+IWpd+0vH/QVmS2lUVVWwu6IXeNL0BqyIcLSvGbFzQUYZFd1zz0LcJ9e+Yz5x0xcADcAqwSqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6787
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

On Wed, Aug 27, 2025 at 04:14:10PM -0700, Stephen Hemminger wrote:
> The typedef for handler creates shadow declaration warnings
> in other drivers with variables of that name. Add telemetry_
> prefix like other variables in the library.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/telemetry/rte_telemetry.h | 2 +-
>  lib/telemetry/telemetry.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Bruce Richardson <bruce.richardson@intel.com>
