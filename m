Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B918EEA3C59
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 13:45:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6456C4028D;
	Thu,  9 Apr 2026 15:45:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 9E05840276
 for <dev@dpdk.org>; Thu,  9 Apr 2026 15:45:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775742355; x=1807278355;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=OJl8FvIBeygfM1fhuEMvKFDp9LgoRJVb8AC5UiFlr/Y=;
 b=kbuf/25FjJH7upj/ih/cmwsG6ZceKypwOhnbab2k2CXentkwC0CfoT1S
 7xBYoLIQo6RNVAYxcdDipZMU08vpAKnrjh4dGRurxLNUTIXew8V9Ln36B
 5CS8fjbKmDhY9b6MhM5skK5xXUNkmNOJxFAXriarmY48HRbzeMZf15168
 j/LRls4Kr0dygSdJ5Lf8RcAIdGJhOS9kGrR319w2Y1NUt3PImYEyF85j6
 P4U22clKeOIoSC5H20dP2jirQnF3eg/PVeg5sNWny7DQGFfIcX/zoyYJa
 sTmO/9F14fDYpe6pWi7VVgQ0UiBM/brbJ+SJTwMID/7QjfGlyeBcQZL3n g==;
X-CSE-ConnectionGUID: F8xLB2HNRUOf8t2icFyn2A==
X-CSE-MsgGUID: /cHbMiyVTViV2/lX8pg2Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="87821925"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="87821925"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 06:45:54 -0700
X-CSE-ConnectionGUID: U2thc6E6QVqYoZyutbi1pw==
X-CSE-MsgGUID: UJ9S0ud+S1SpSkrTxBqc8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="230444779"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 06:45:53 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 06:45:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 06:45:52 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 06:45:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKateMTawpaNT0V1pQe5X3WHo9pmN06CrCdSQ+eGf7Vf8Fgz2/i5jUhQl94ds+mNZQBGqKbZjtBtZnjvrK6bAl2HiNZzdWv+q9Re4wxzpkH8Sr5pojN/iGTVlC5nNBS71mUs2hTELf7lFzpe2qvHOcQxUaHXMOdAaHTWmRpfmHY3n9JhVJyoAVfd38K5DshaMxUX6RV6NAs0Kt0veTfKdXjFZ7ObcrJA/GZxdZ59y8sspfmgnrKQD8k2TEN2dS3x34Ude6vo+ze1Z4IbHIh1YtANGZPNGzH7piHndQBEKs4NWtLUDGnfH3wwFLkjsdLwH0rcPRHRWiwSgKDmrtvu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+2uqhAOTi57LKT0iyoVcXu1jukd+bbIJNZvTIszCvQ=;
 b=oCby4S+Hk8qvBB/GGW61xAsvy107UooZBHbIBSp6BvKs4uFcUIR9P3nvjcy2LwwLfYB9qk4m1CtdctSFm7jXCnWZO1GyR0o9OoUUZwVfKTzu+P0f7u0dQwbYZGjBPKiC97fgjBFflmO+kVQyBs/4oS9sEjtwXpWxd8Y4Nesp5MdEaMMqKtTpoGNz3nxXcTcMHCJ/gkBLx7ssIoQkZYMImtEjD9btiyBXvNYKtRdirXQ7dN/MYdZjws8JIpAMaBxoCcGCjvWaPkpphhxiz6aGgMO1lsd8tlrtg33Y3Qy6+u3nmWb8EedyQnTFeOqlfJHYkF7KwFkLNnEkAlB6v37VAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL3PR11MB6412.namprd11.prod.outlook.com (2603:10b6:208:3bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 13:45:49 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 13:45:49 +0000
Date: Thu, 9 Apr 2026 14:45:44 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/ixgbe: shrink size of context index
Message-ID: <adetiCMz-_ciXUle@bricha3-mobl1.ger.corp.intel.com>
References: <20260408154804.1596060-1-bruce.richardson@intel.com>
 <105e86f9-0f2b-46d4-bea3-4b55bf5ed92a@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <105e86f9-0f2b-46d4-bea3-4b55bf5ed92a@intel.com>
X-ClientProxiedBy: DU2PR04CA0266.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL3PR11MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: e564e6c8-638d-4ed6-1fb8-08de963e4efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 9O82+84CKHw439LvutehX62zC2rC8Ndot1S4ExlN8VcUkkBo91DYj2hLIR9L8iD8GBtpfyy7eUFVWND2fT2VFen1bqRi2Mn71jweGRzejvXZ+mXDSSzuvew/KTozmjBJDm9ni0eOeU/OSSxqZURl9qFPduUzO/U/eCjlw6kx2T2d7kppeaGMYiBRPmxoRHzt5Hym/ucqD0HHDf1ierHKGEi1RpQq3Y5+B4DCYEt8i2S1/wGH793LAX2mdBlpOnzssnO27saZoRNKaSmymkswuRpK6YdwJ5KQvRRV0mUxq9p6q7rj1PTBwsus4q7nEUmmwA/4NMHb2JrKS+a1uvu4w3cvpGKKjzok4amsWmV4E9yJC+MXkRBJJKyvu6yVH/ssqdZifqBpzu11RemQjL4BHJMm+Us7Jbp7t3D6tGMu2sZZJHvhNweWfm0/KWjkpB+c7tFS5Yt6dRKkAoM7txLxrQXnbX2kvcK+8UPil8dtEYfYgwyNXd518VzJFRKlvjBNiPm9OL1bplJGVpPIjfUgcpik+VERb0xqs04776xHGcbjKfIDFiRAH859fn9rlo11FXlNqmrobdEgxkkY5o/iVM+GkngsIzxejFUEXLRcbEsfw6G6dfRL2qkd+ebyb25yFA/v83IQ2ULekJ0Oe52+kt8HPB1H02tQ3jvbC8we8aFJTBu7yWH9U32VgSIZcZEDS3nGwiaZrfkbi1pF0XFFzHTpJpndobEY65x5P5Hk/BE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S98M96g4E4J2TmfCLKJbLfdvJX9m5fYSlue5hhbGw+X9a4jjD/tQUlvlFo/6?=
 =?us-ascii?Q?Ytr7XX4xVwQ/TBwf9t2toWeD4nKqhKDhT1LJ4spA++bC1J5wgdTXGZyz/fHP?=
 =?us-ascii?Q?bZACAKTYTmKNQwiqUwolJygf7rwnhE+3v0wtUcKdXg3COtKDy5VotXoY6KJX?=
 =?us-ascii?Q?LtDB52n8xS5osDDTQ5kwBcP6rmtW+D/2AbwOvK4jdpORIwuo/BhfaicyzwSV?=
 =?us-ascii?Q?d2wPQqntSij1KTcE9tVbptR7lJe7RUQJNtrQjkdLxDgEj8LyzzqobVKkluJ0?=
 =?us-ascii?Q?xxlFteSbQBduNhfZrn/oxcya1Ro1qRJGjIDYQ9L2Lrd1n0Y+aqWW8o99GoPG?=
 =?us-ascii?Q?sYSQsqKmjh7e9grkVVD1FbW+CeRgsEeoQKnYAjc5vuRRu3cvyhJ1Satw7cf5?=
 =?us-ascii?Q?pEbSMt6d4pGtHi17qO5tAx7cOB4yCJHnLPRf4CS70VH422g0wl5Fib2MwqKp?=
 =?us-ascii?Q?lU8F5mdwmnjR8of4/B9yk0Lzqh+KsMGbzpQZysUc4tNjDRix60kXud5yl1tZ?=
 =?us-ascii?Q?pjZRbb8+o7JrxUtJ+FN2liHs7788wJQl2wuNG965PFKQH+7xwiySw7vEZej0?=
 =?us-ascii?Q?su4YcIUDijKXcwchw8AXDRdhSghwF6qqOcLxUv4UMdsGWl6qohC4Inh5BGGW?=
 =?us-ascii?Q?tgQkX5KajIFR9IQ+6T+e1k1Z/6pv9sbFZUiiVdAFTqp0UK4rt1v51L4Yeg8x?=
 =?us-ascii?Q?N7iHUweiXb8OB2vXB/tzDjT4QDzUwyFiv1wtUwQ/JiFU8GvfFnWbTZxH7jWg?=
 =?us-ascii?Q?fwDjE2+hgHBKnYDVZwlndpTYGiLK3HORkrDsOvpuzdM4Qmhoa1F0/0iLVegm?=
 =?us-ascii?Q?i14wrcLUv2vfGvlx0TecQgrigR3JMz7OLpWS2RNW/bg/ZxbxrXGG6qsS/+48?=
 =?us-ascii?Q?f1cjPhqIDYt+86665Mgavo4k0RnCJrIx0yCoHCpIavU3MmfkRxdwwqAbKPNh?=
 =?us-ascii?Q?t2kH8p9DReKwREM7IsNBrkmPrWrPhjC2uVun3htuA43fZLMC2YeUJDNyRmm3?=
 =?us-ascii?Q?M638hRJj0tWblq3jhKFV2GUSDEZIM8sYryn91d1RsIJahcDG9uAXCH8mFZPy?=
 =?us-ascii?Q?A+UnYym7H/endYjx+/SkTHT83E6fT454RiMtHf8/rDPBFJtRbX2ffP/hKHJU?=
 =?us-ascii?Q?B6PNpAJm3XfrRJHso+gc6UFrKXYeNR8wmKJ85F88Pph7oYs4XeKjJtigDKvs?=
 =?us-ascii?Q?nCz6KzLX4HAqBl6ox17YugDVS6D91De9JmAF5RyPleaDbazFWcUURE1/odii?=
 =?us-ascii?Q?mJY4g7KVwlqpQths6J3oYUDWTHdSWlCif8gIHsdOvu7dEW+HUMd75gfdmI3W?=
 =?us-ascii?Q?UfOm5wyHuaCTj1rtW9Vmktq97ol2vOYNfOhwvnWCOHhRqrIqyHC6K2jDbed4?=
 =?us-ascii?Q?rBPop/IbupA72SnjGDE7aOG6ODSedrP8lmYEbp4lbaZZgTEjGLG2MwYjmMAb?=
 =?us-ascii?Q?vSI4EA/u8fZavC7j5cfa0HKDZhK/5Yki88O0QcqmEfNpY3O4Nk3esb4r/p4L?=
 =?us-ascii?Q?3LgCsl4TvZRQVLMQUc5eRRHcn2LOa7E9X5kQ76DpCDTEG6W8BxQtEhoZeMpN?=
 =?us-ascii?Q?4fK9n6jEvtEmzHH+dBbdCOW4i8yQtbyGg+vNUCVc4/M9y0tme3cWgiqTdpJd?=
 =?us-ascii?Q?SYm8AxcoPos5s6eZf+aHrz1D18Zpue09yLgPobIPBeueQzb3r4xAllQX6Zms?=
 =?us-ascii?Q?vNTA7LNi03MokdMAgrZVNvxu50X3eofBe6lnKYph/8GqhF8zw6V5hNdyXTho?=
 =?us-ascii?Q?EOqfRJOSnJWu4F3q9zjPMzK4a30YZIA=3D?=
X-Exchange-RoutingPolicyChecked: mhHegkBd2J8KmI3QL0Gz2vR1twvlqd5CJIFQ7irjPHbRcpVUF5IkER3u3Jn40PFmGaqyr6/6s4mz7D5pRGsck5YlZrzEBC+5KzfEqg5IY1213uaarxpNwYuX8O90rrEIx8td0hrY3MtNqufPf3ku40UnA1m//eG+123p857r+AcD9t6EtUS+BSZj69wKh5hwQ5mIEJ7jnpcH9OrhuGOEDVdKxPdivIeAPOCJCOzJsEcw+QWBwtm3aDiT+CqQZ+DuV1RfNKsQkAD5IEEM/ojcc9gaQoQkIcjZgl/0hiKrxXORYC2cq9TdyP+dbRWFV56yPC2Y4N9Crgyd4cZLBj0BWA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e564e6c8-638d-4ed6-1fb8-08de963e4efd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 13:45:49.1870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaCw7E/1QpXG/DxGV0r5/Kzm3FtRUkyg/cphRJqub2hzf1NS0Iio+vZ4GkF1XurqjD/tyd/9F/M6gkzIpWJ1pk6xMzKzTB5jGs27xdXLv6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6412
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

On Thu, Apr 09, 2026 at 02:18:25PM +0200, Burakov, Anatoly wrote:
> On 4/8/2026 5:48 PM, Bruce Richardson wrote:
> > The ixgbe driver only supports two contexts, so using uint32_t for the
> > context index is excessive. Reducing this to uint8_t shrinks the ixgbe
> > part of the union from 32 bytes to 24. Although it does not in itself
> > shrink the space for the whole struct, it is worth doing as ixgbe is the
> > second-largest block in the union, so may become relevant if other
> > rework shrinks the idpf-specific block.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> 
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
Applied to dpdk-next-net-intel

Thanks,
/Bruce
