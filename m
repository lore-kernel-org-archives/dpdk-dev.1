Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C16D39000
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 17:45:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCBCF40B95;
	Wed, 14 Jan 2026 18:45:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 885214027D;
 Wed, 14 Jan 2026 18:45:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768412718; x=1799948718;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=YSSB6nvqEUK/cmgssZKXfJhWmT2OtsmrqNrtEeKgaWE=;
 b=JF32ExKwGOBqTaA5/Hr6Gkl6ogzl2jBfIFuHkdxgh8wxB/noMoS53HKN
 U5DWs9H35OnFRlNwXnCpPlYU2UkhXWR1++tmuDYbzfRDCRSqhD6AScLvK
 7LgEGyUsG0dVbbFa1APowgFDC+80ffrY6QvR/XtAcyG5LCSKtpl8iIPrG
 5TGVA9DkiFEocnoT3RPoCSLremEefaPAYYAQckU+Pcq2CgPXL7smznOvc
 2qAF14Tg4t2d4KJPQR4HSwV6843rGOW/nLPpJ4lBfP8QL84LNaNptbmJA
 LlBcc4CGtEqWLprV78jr5btmrVgiay2CgNO9I2yK9DfwPZj4tmSej6XI3 Q==;
X-CSE-ConnectionGUID: 5Pq6oipWR/S+JuO4sYVX6w==
X-CSE-MsgGUID: 79WkLsVsTnC5mHlFkd9uGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="87296594"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="87296594"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 09:45:16 -0800
X-CSE-ConnectionGUID: OO5Dk3YQTMeuxTJuKY9LfA==
X-CSE-MsgGUID: n/0LyTzjSQu1tRXanj7tBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="204790723"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 09:45:16 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 09:45:16 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 14 Jan 2026 09:45:16 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.39) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 09:45:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evrVme1QB2aYZedpJkNe6dLE++bwxSa//ndaRqCbZkYX5Z/OP4YcgduF/98newPGLojzOPi6b+7a+Bt8zjWFE9LIWqxaWTa1Gb/IED7dZRVV1TMl+hNTUIpP1DqNUuTxWXs7Xrr9nSh9GgSUoyIwIZvmo4oLeJFQVSB2CSwnC3utATzsgfoNanLfc+qz7TribkPQlGJILlGx1n+JmlBbTdqdKmVdoz7QWaKXRb1mDGwLL6Cyjt7bqFvC+370ALNombfZoaaK3XM/VVxDMidstmLKSLI5QCW/IoK+IhEWMlwHZ+t9ywJvMRcJDeOVdFokThcVNT0kwbOicAWT1M7W6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14OPB9Gc+xNXKXtdsc+xZ/QoKu/XBjjanHLR3oXCLQM=;
 b=DzOE96bp7gdwfF8qmbWXGw9sqm+NkjAVbgk8PUwDyTiF41fHyWzbPN+dVmyWNceu+ePfpI4EKunOAVGx4YVq1V91QXb+vlU3vK6Qc16g+1yfPnPSH+IfuC2E77JIpXO+kaAXFZrFTMptuJpCJ7FcpYqa4hVIhQmBwopqI6QRExvOMXcKmqSVBl2OzUGBb4LY9x/U8k0XTy/czAXoPSSSz8WqAJ+f6aFphAL2BCn6qFfBcQwN/+avua1vGESUvP4VVjEG7hbWtlW0q/D5sIOdcaQsPMWDP4+tsMmnDsd5YA/U82NBOZNllXoQtGnAb7UjBLBPTvMR3yWZmXoEJzzQ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB7695.namprd11.prod.outlook.com (2603:10b6:208:400::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 17:45:13 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 17:45:13 +0000
Date: Wed, 14 Jan 2026 17:45:09 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, <techboard@dpdk.org>
Subject: Re: mbuf fast-free requirements analysis
Message-ID: <aWfWJZ2JxB4rkC-3@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F655E0@smartserver.smartshare.dk>
 <aWfL0un-qWa1vGCT@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6565D@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6565D@smartserver.smartshare.dk>
X-ClientProxiedBy: DU7P251CA0004.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: e25cff48-e859-421f-e7e3-08de5394abdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Oj8ZFIyyi1Ek8+FhJPDdRUGNDkdSZp4b76W9seOCQ4uTRcQQmJBO526vAK?=
 =?iso-8859-1?Q?eV1TGOPF6U9OR/UPbPGrq/YJiUPZs/BtNmEL4hrC0DotsEFv+XgOWrElt5?=
 =?iso-8859-1?Q?aocrPpPNLJKKxq78bCObwGdsGxGYqJCayVi/8BN3j0qOia+5JqfhT8ZBdE?=
 =?iso-8859-1?Q?hxy62NHrTQm3Fffp1NzVydsua4Mz113bFu/SaWHGNVq04JPb6SOk4joJ8n?=
 =?iso-8859-1?Q?x8KXVTxbpM+mANQPhX7bFGXzubvPo+Kej13qzbhKGUeXH/8jSJ2eSWXuSO?=
 =?iso-8859-1?Q?ETPcR+t1Cdy6amoyeTwQhYOmCf2JgSH85WYImGVls0GzgmwUYvp4pm6cgY?=
 =?iso-8859-1?Q?bASPwuKJtjZblkR7M3HyRM4a6PCFUb65Zr1OrcQisf+QAhhEhwixJWWafS?=
 =?iso-8859-1?Q?43ZmjfvGcMboX/ietAroaP8/KfUygw09xZpEbBkbW9FtIyRpJzA6+PB8LX?=
 =?iso-8859-1?Q?mJw2wW5kJ/WFclN0aiNKUA3LE9Ghy37Iisghf874MeV1+7B55xIFlBG9C2?=
 =?iso-8859-1?Q?6bFlECy6WI4cGuxC76HdDIA4Zr1H5uvrYtTHyDY2gDIyp73Qu8iKLSSdeA?=
 =?iso-8859-1?Q?53QyFQRBUghunlC3ddx4/VNMzClx5qPPB6jbIYuc0Z9gCXOwWCppGy8+iL?=
 =?iso-8859-1?Q?OuMKMceCl4vAuiQDE9HCFVgpZroJlaD2GQqwG7+L5sTKZlVWHMYgdzdGb8?=
 =?iso-8859-1?Q?bwX7B3Wqqbi2ZcIZvvZkvO9jF4OqJKoNzLi/k1FPYzJDz0oX+bn3e+lCzC?=
 =?iso-8859-1?Q?hWKN15dSnF6ak1yh5c8rWaU+zmO4pjW0Q9H6xdjfMLG6Go8qUrIqudHBSo?=
 =?iso-8859-1?Q?oz7oqDYOTdCsHyGkoFHGWhXi9BCDLp0qHAyTI355OY1C9IXWJvSxCx8Rli?=
 =?iso-8859-1?Q?zgoc9Qh2SVgs4XZVI61G5+42WPbhYGdMcosDpO3Qj+JRe+HkJwcnW3fD+9?=
 =?iso-8859-1?Q?EtB6+NeGbDQFnYrIpDNvgKGI+nSyaieDJN0eDnXQCy0lLiipQ6yQDun9AT?=
 =?iso-8859-1?Q?W2PY4slWOaP5ffaYLb12nRZnN958Hy+tZzwSfoVqVlUk8JGgY9GmC+7xmG?=
 =?iso-8859-1?Q?fvb4uVtofC/pwmrk1Bku76X60QTPil2bgDNbL0I9UbA5U/E40GiOAsu1zE?=
 =?iso-8859-1?Q?hsfBrvzHg6N3cInDB2eOwSDkUxyG08x/8cht7tLpkVLd0q+YQX98YQbbQQ?=
 =?iso-8859-1?Q?HighBPisSWs3EUOjT1aNd3tJG7NZmicYURu3VRiCUpo/+2wN1pTubmadx3?=
 =?iso-8859-1?Q?73yXRw4D3SeF3F5A2MEv4vsC/gp5JQ22Gk2atSz0tD0xwobNaMkphVP67A?=
 =?iso-8859-1?Q?R3q76l4zvoFZhJhc713V1YCid3eLOnvbicPGn81mJjaR+yQMZH1aJXI6A6?=
 =?iso-8859-1?Q?zDjQrkidyW1DJuGsLQbhKpCAOtDGx5sRWz8skkOnFJv7H+aTtzwqPKGN2p?=
 =?iso-8859-1?Q?7o1hUP1zde5y4caOm9YgBI3jtvbr69dfHmz/6zS/KOkASyzdqq8Shf+rjl?=
 =?iso-8859-1?Q?Zy6o9fqEEMGUkB/YqUN6hL2wn8+Op0N4nMnWUxFf+hffpCz8xUhd3DNba/?=
 =?iso-8859-1?Q?FTNil6ngrlP3ShBdst7wGPGSovvPESn7rVDrxQTZHlN0NhBqRfBgCW94tq?=
 =?iso-8859-1?Q?D3RTidy1wZ6GE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?myUvLPbvj6rTJHbr3a8xr1zC9PhK5Kz+iLAYft8Sv6gL1qdXyGYR0VhDk3?=
 =?iso-8859-1?Q?avpbpgImzCAq7InSv1W3iZDWMtzrwIyj26SpdvYLDNjazXWAV2DHGo7LsT?=
 =?iso-8859-1?Q?WstGMQVmsuKVC+5+YMRC9pgU+dHvDo/Ic9pJ+uuN7iHUk9kk+jqGh6R0vb?=
 =?iso-8859-1?Q?TGD0X0r70xmZQL6gGavfRYsnnQtNIzQw4tb2QgZlDRW2AXn2FSusHcw2Eh?=
 =?iso-8859-1?Q?G+vKsX7AZKhKAfh7g9KA+/1xB4VzCBUnUxxuRaQDEG9HbdrELnDWGHRM3/?=
 =?iso-8859-1?Q?MhLHZ6QF012KbtoI/DLLZjZ09Uk/Z2wXHHTc1/qsrLTl60LWMFZZt+eGL1?=
 =?iso-8859-1?Q?mWNWMHklmno+9U8olLAPPL95XZuSlsvXlA6aGpL+qiM+hJWT2kVoRMhKVO?=
 =?iso-8859-1?Q?qbzE8mP60P071o1c5+7b/K2bd3xC7zUgb5HkW+EycHVvnhER0HhtWUwyg5?=
 =?iso-8859-1?Q?iMq82NOeTTmYN5kvBW/btKYDJN7xk/qRKgfsAp0eXAi1OOb5U/CnB7PCea?=
 =?iso-8859-1?Q?pHfAHU8EmQRg8trXKYQ5McqeA9mDsNl14ueOfjl+Bql138vVrAfRH/jQnu?=
 =?iso-8859-1?Q?Cv7pt+zypBcWt/kjeKe1ndSJaOlAA4VzsPGaF/N8feRmMWzoxpohejX+DS?=
 =?iso-8859-1?Q?XyVFPfgraOF3x9HM7Eac1klK0aP05pCwcHoKkDBqel4iQVjuyjXsepEC63?=
 =?iso-8859-1?Q?zkrWrm+zQUeb9uJuVnewKqfeNHnivQ7afWlvrGOr1LS5STcFOm82zdJKzS?=
 =?iso-8859-1?Q?sLv02s8h5FWqoyGzg63MjGLYkqbIAHzdHgLL5kz144eQuMV4u7hoAy6MV7?=
 =?iso-8859-1?Q?K4efRSJw1J/toRILWhdcGm0MoVZ0SmTNnLq7Z6WHcPpQF3zRMFttNunCOR?=
 =?iso-8859-1?Q?cw1Bud8nZYIZwtYuU19+bW7QF7Dj980kCAyBsmVPBUJ6jF75CnfMZGg4dS?=
 =?iso-8859-1?Q?bvPlZd1m1e+zEvxh77RrJrwsql86wWmF4jti8rmOxLbgGXCwy+eti1fGuB?=
 =?iso-8859-1?Q?vYZtM2NrQPYGppc1qqS68cHPsNmjFav/ayxsgR/MA8vEyZ6ftpH+E5q26H?=
 =?iso-8859-1?Q?CIQvQsxCWrkQcBBI6JZG4sWfXp4FhGOYcEBpu5aCRMlyxWpFB4BNlpE0YX?=
 =?iso-8859-1?Q?/H0WI32lAek2J/770JU5qTcd/KRcWjQYEtqjBjpFuOElGRdgNqCSCkAUF2?=
 =?iso-8859-1?Q?7mkT7Pr4U8nUlJWfHg8Lf5ZiXwQxuap5ASDrDfO/U6W2uF4fBDDAAYnAYC?=
 =?iso-8859-1?Q?UMoiiyXf8nO+UpLSzoXXnET3ivCzByMGodDmheX/bHMnmdHr/stLKRlXnj?=
 =?iso-8859-1?Q?9bjdfuffLqe5ise6SL2nTcnhd7xbcfqm+WyjyXQWIuHRzM/fapkaXkzSi1?=
 =?iso-8859-1?Q?WxR1JG5WFVt/wPzk/Mz5A5t2y8AEMaj4Cq5Xs6FBINMis/pvnkvoP1zlDv?=
 =?iso-8859-1?Q?QzW5a23XvRXYY45/WVlqq4Koca3xZFhdwlVUP8C4gZ/St7M2jPidLqpxEw?=
 =?iso-8859-1?Q?hYkmZs5ETRs1Bn8IimYqsrTF+JlaE/CzJfyskVxQqlr3eJ6JInOHKg6rBm?=
 =?iso-8859-1?Q?HVJIwFjC6CqCrMORA+MPbfzL0BR2SNQXo4kafXeZhXy8MAWLGD6IgVpZmD?=
 =?iso-8859-1?Q?Z5an0AXeU/KrGZ+ir1KZHzCxFZDlsnZ21l4tMWsI65X9tLRG9XEyk5ADNv?=
 =?iso-8859-1?Q?09E6K98aPxRR5dFuR8Uq9MWxrgoeVcGXpjNHIPgsLsEovg+4IfTuc3TcYG?=
 =?iso-8859-1?Q?T0r0SVysipvsXOQ5iEMyngakV5j4TaL+DxV2h6VsGapxoq2dRZxk2rHBsG?=
 =?iso-8859-1?Q?N+SrWua7MbgOt5HExvZYyban5ha/Bek=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e25cff48-e859-421f-e7e3-08de5394abdd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 17:45:13.7905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BtxIWPIpJbl4zdGTSHnVl84YMyBhoa9YQb5AXatBSYE5KrofAee5cYF2P7D8TMTkmMxK8kreWfFcKx/v/xfzHOhuY7y9Q1QSR9itNpBaywE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7695
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

On Wed, Jan 14, 2026 at 06:31:24PM +0100, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Wednesday, 14 January 2026 18.01
> > 
> > On Mon, Dec 15, 2025 at 12:06:38PM +0100, Morten Brørup wrote:
> > > Executive Summary:
> > >
> > > My analysis shows that the mbuf library is not a barrier for fast-
> > freeing
> > > segmented packet mbufs, and thus fast-free of jumbo frames is
> > possible.
> > >
> > >
> > > Detailed Analysis:
> > >
> > > The purpose of the mbuf fast-free Tx optimization is to reduce
> > > rte_pktmbuf_free_seg() to something much simpler in the ethdev
> > drivers, by
> > > eliminating the code path related to indirect mbufs.
> > > Optimally, we want to simplify the ethdev driver's function that
> > frees the
> > > transmitted mbufs, so it can free them directly to their mempool
> > without
> > > accessing the mbufs themselves.
> > >
> > > If the driver cannot access the mbuf itself, it cannot determine
> > which
> > > mempool it belongs to.
> > > We don't want the driver to access every mbuf being freed; but if all
> > > mbufs of a Tx queue belong to the same mempool, the driver can
> > determine
> > > which mempool by looking into just one of the mbufs.
> > >
> > 
> > <snip>
> > 
> > >
> > > If I'm not mistaken, the mbuf library is not a barrier for fast-
> > freeing
> > > segmented packet mbufs, and thus fast-free of jumbo frames is
> > possible.
> > >
> > > We need a driver developer to confirm that my suggested approach -
> > > resetting the mbuf fields, incl. 'm->nb_segs' and 'm->next', when
> > > preparing the Tx descriptor - is viable.
> > >
> > 
> > Just to make sure I understand things correctly here, the suggestion to
> > prototype is:
> > 
> > - When FAST_FREE flag is set:
> >   - reset the m->nb_segs and m->next fields (if necessary) when
> > accessing
> >     the mbuf to write the descriptor
> >   - skip calling pre-free seg on cleanup and instead
> >   - just free all buffers directly to the mempool
> > 
> > Is that correct?
> 
> Yes.
> If this can be done with multi-segment packets, we should be able to eliminate the single-segment requirement to FAST_FREE.
> (Unless something in the code that writes the descriptor requires single-segment to be super performant, as I suspected of vectorization.)
> 

Yes, the vector paths do require single-segment, but there is a separate
offload flag for that [1]. That flag is part of the overall
vector/non-vector Tx flags check.

/Bruce

[1] https://github.com/DPDK/dpdk/blob/main/lib/ethdev/rte_ethdev.h#L1643
