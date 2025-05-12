Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665B8C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 16:04:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 056DA4060C;
	Mon, 12 May 2025 18:04:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 934944025F
 for <dev@dpdk.org>; Mon, 12 May 2025 18:04:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747065873; x=1778601873;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0zhRHYKq59LYPMNrZvm39jINji7NpctJex6dSGnXpYA=;
 b=Xn1Hx41pNieDLLvF/K3P9WkOJCSOd2ufy4NO8TXAXyzun2z0hOQ6bEag
 RjKLSXyv/jLyU2BZyRLZpjjhQy79Zgd+cY379tkesSWC1u9+vMnztQ0om
 eC3Zw12JLfOREBUA+p2yPWNZFqCV7TmPMwUPussPjbu71tDIQc7zeaO57
 isi6zBmnRCO4jpPzLnMv2T9RdQcWp1/5WmI3Txx8Ganfh14Ag0D22HM5b
 nxMy8UHlY7AKGm2nBjh53yIqM4U9Ga3iF0R0aE9jzPvwQqkkIjcbenM+D
 xVPEBe8BlAin7/XGCm6dHFWmbpHOtYhnd+ITQAg6ArZnnJrThxV6mGJdU Q==;
X-CSE-ConnectionGUID: MqEcaffNRzGJVm745TGtSA==
X-CSE-MsgGUID: D1WeZw2iRrmdI0X1sj4l0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="74265740"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="74265740"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 09:04:31 -0700
X-CSE-ConnectionGUID: +04NCwvGS4mDt9yykvGndA==
X-CSE-MsgGUID: cxi52e3kRH6nCiUZbijSZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="137439859"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 09:04:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 12 May 2025 09:04:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 12 May 2025 09:04:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 12 May 2025 09:04:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Co6qfSTfdYDIeFHRtTureAzRKHaQLgn6GW/hAil+hyfIIiy5KrlwV0Jw3qv3Vb7kmm9C+Fj7hX2jbXGly+eWZrarkzEGaDnfiVQwhi/LzN2f5WzgYNRtPYet44QS/1xhx2a/zblf8y5it9BZpth8ZqkO3wU/s5wnaWi1B+5MMUL9csQfwHINqkoQMWrgoNQPXx8Zj5YJl/ZTmmPQPXUZSp2fQCpKruFb8/9y3gORIGb3a0GHg4TN2roKnvkegesibnqJx1DTn0Cg/1HtkI45A3rjzNpnN9bcNuVvwtsjKGHlEMEI5wHnOc34CrtjYVA7+tRAsocQx7/npq+Uf9IPnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDy75PRLltFAg+pJ7iRQfam4g22CM5lG67IoRywm9as=;
 b=dtQdoO3D+JJMHFWhJA0prI2vHtcZqb0lKkWRh+NOpdMf38qqoGyRdDIQ8V6MiNrBWIRnu4J6wyBRFyoCA4JykQoOtxMSi5QK86vdmuWrZIpYvPBtzx6LwW57kR2DI4g5hJ3jVT1+YaR+UZI8Z8GRP1BNI7GWRk4lKIZKxdkVLMPQ/AKuhZBzv2hv9fnSR7kZAVBEhqCC13ezZWVP7SykMh2yYNt7e5MGBlhUNiU8E/RfLqSbmrUOz1FCOBCuWpVAWKtsMf8wmt6TkNxN2zfryGNp3GHa8U9/bnXK2MSZLePvoG3hH95aBViN8edN95rz74SQdTZ+LmreUeDsNBvMdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6357.namprd11.prod.outlook.com (2603:10b6:8:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 16:04:26 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 16:04:26 +0000
Date: Mon, 12 May 2025 17:04:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: LukeSeewald <luke.seewald@gmail.com>
CC: <anatoly.burakov@intel.com>, <dev@dpdk.org>, <luke@aterlo.com>
Subject: Re: [PATCH] net/ice: enlarge limits to 64 bits (ice_stats_get)
Message-ID: <aCIcBLJyohs6H3gh@bricha3-mobl1.ger.corp.intel.com>
References: <20250403135041.1377720-1-luke.seewald@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250403135041.1377720-1-luke.seewald@gmail.com>
X-ClientProxiedBy: DU2PR04CA0071.eurprd04.prod.outlook.com
 (2603:10a6:10:232::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c77eba8-42b0-4073-aa4a-08dd916eaae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4ZGb01ROqpnqUOmV57HQAPXpyXLayvRtziCm5i2732AMl8AsUsim6j9mpBKk?=
 =?us-ascii?Q?FlVyPObFUNoLDmG5gMhwfVw3mNuKYw9gPjRcJ+3x6cup8S6dlROwF+Ui9zjo?=
 =?us-ascii?Q?Io6x8pFq+alOiYiW1WMQmnVvjWSGG7HxUlXDS7yx6hp0vwm+iBOFNmUb/skN?=
 =?us-ascii?Q?VgliL47ENqpHnG/+e6N78mJmwBurcDN2OlNHEbrnP1zFrckL2RGW2hmxiWh4?=
 =?us-ascii?Q?ZO3KYXAx3oXSRP+O+nPVSWL5CL89pSjfEgfymSRLTMmuExEdgjl3sZEWM6nb?=
 =?us-ascii?Q?+onP1NSnceF8a/ATGKe2Ok2XxSWosFTDKbpnFP9LLu4bOEEmjwLKuGUwEaXd?=
 =?us-ascii?Q?B0LLF31U5E64is/hJYmb/K1lE8XOYoMQJUyavqBKDiPpHvbKRwHhM05eIRhq?=
 =?us-ascii?Q?cbh+x+DKRyV44L2XAxKqLlWOlUpYZy0g/QoOWN+LTwRwU8UR/e4f/8h3oQJl?=
 =?us-ascii?Q?URvC9TGikUkN2oRkLDma2Pxf1eqXQMkuEy0Ms5Gqk96GjTNJCdQTfAfdEUAP?=
 =?us-ascii?Q?1K9Iv0aL6LfJBw2Ib1OkYGDajHEBtt7YKF0aSQDPMulCr3uhXwyl3mgeBHKQ?=
 =?us-ascii?Q?oPjXqzFnUhVrEMtNiaji+VdBDCvFHYaTgokQKDqrJ2GQp9olgz0hT83A9unU?=
 =?us-ascii?Q?wJ2DyxGR65073+1AvnFttB/62qDRP/xqB0OqfL39VH7qOVwl3lbR9+SiDlbo?=
 =?us-ascii?Q?BAuI9UMrHAkf5oCFPKAKCdDPd8d327iK1C2H4+fCNoUeC7KqWWXY1O37qrAN?=
 =?us-ascii?Q?R1s1XCrrBzzA8GO66rs/Y97GRbDcPaIccxSItWWGomIEG4Znw24LaEKSBb0i?=
 =?us-ascii?Q?H86111cW7+qhlfCOvvw8CU8W1uuYF1qzFzZTY6THYEjjF22Wjm56pPHL71dv?=
 =?us-ascii?Q?xwiD6ogTfql3+7C3VhBmMcOgO632Ckm/E9No8Kcf2N66rC7T1GxNzlTGjhGa?=
 =?us-ascii?Q?nZWDjUAZG2Jl4zVH4T8/jzZo09Y3RVRIqqJRsHwU5jEhiboB+y7kdHjU7K9+?=
 =?us-ascii?Q?WsfImSQep+7z7urQ+16zXcCIVWN4WRxh+KTV/mpUHuG3n/Qzqr7IwarN36Gh?=
 =?us-ascii?Q?lv1shrkNpyOcyEq7d9E0i7LgwHxZROhEeUNbp8taBA8fagQQL3iJ4lPVHqHW?=
 =?us-ascii?Q?t6CDKaUP+PfW5YXmZgMxIx9/ww+UAQZiaBLlU0hPyXpwjJiQORYnXEwTmrmo?=
 =?us-ascii?Q?8M55vT6HGdDfBm6zU07WRn1zjVtL1lNHmFflb16tK8Yi3IwiiJG+YXhuDPQZ?=
 =?us-ascii?Q?WV6wbfOXz9gdC8mv2PEgOToAQV7b35IaG7fhNf/5/RrJqxQqKt+ah8/UZxZA?=
 =?us-ascii?Q?wG3qIGpXv/ptAR+TbMDMRDj6oDFIgTkfzv/TazYDmWP6RoLIy9/2aFXo17iG?=
 =?us-ascii?Q?ClY4+D7cjR3jRXZWNSqWtFH3qe7IOGgNc3ZOHt9AKc/sTeOrUJJp24PZtx9T?=
 =?us-ascii?Q?LVw68DXiRts=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ckxhwZE2rS1bkifyYXM0/d3kBGzKLt0il6kiJbPDxFwpLPqIFWdm7XrfDRj6?=
 =?us-ascii?Q?YA+10Ua5cyFN05MNmUNv35MW/J76fZ9K3zcS3aLu1odFSlawSCVXZ2Q8gjMt?=
 =?us-ascii?Q?amTAJG+sQEIY8r2cHhzEPOkPbV+H7ztvejOlCc70+RKm5BI9F0obn5nE3p1x?=
 =?us-ascii?Q?yYGfBBwGL/5egSXq+BMgsecCb0+1olC8njoBtFBkJI8Edwpw2Zi/CyJgsyt/?=
 =?us-ascii?Q?1cdWHbIOrKW1YAqnaoKeK8WQQ3KPbfY3qVp/B45g5nfJrF4eXCpvhHi+ethL?=
 =?us-ascii?Q?EF7UfcK9Um3TsiBHIBEdtu3vYgKLelqE2XvLfeGXMncJ2Z330EeJrk5MedMM?=
 =?us-ascii?Q?z6Pxsd4CHQ3CtsSgyHfuqa7/CUkfALD5FZqbxXGmW++qYtKiTEs7eyQ6y4zJ?=
 =?us-ascii?Q?CxZv+XV97wIA3JaGTcVL+cm+V0zFqR91gWQC5R9viViCOAiouhejzX8hAZcz?=
 =?us-ascii?Q?w7nmTlJh0X4qZb5YvCHfUazk9/x2+L7OCFyFu0fGvr4gsKjdqrQxy5U6AZno?=
 =?us-ascii?Q?VyEC60n8cPU/K3ax3We5gljWSbZWuxagHIls5oos9HLVgXsKtI1vwH/2Djs4?=
 =?us-ascii?Q?86vtFsuy5PkdDdmZkbcpeq3zcQ4aqDC8ELvXRJ3HFKWRg+9my6eeRUSaBZ/l?=
 =?us-ascii?Q?LTO14N67IkLH3i2mohzvokqsbI9iybc+wVVEx3hxH+IOo/tIhUJetdPJh7iA?=
 =?us-ascii?Q?uvqwt0xqZCenvnGorW7OAB27FTlnKq81KPa42cfMgba4lcZsfhwsmY2AKs6c?=
 =?us-ascii?Q?OKavbg14/wjCE1+n1dnnpy8R+fw7vO243comP2Mv/OOzHN2rf16NScOc9zZd?=
 =?us-ascii?Q?f/0UwlIPsxch0F0q3mwFs5qTDSVxVnPrj8CkARlckAYlSe9bZ0M8LFL+WMqT?=
 =?us-ascii?Q?Kfz1Rnv0hrXrPJNPjXBhNFvPB+MjeYPajbnxSEDlTFdXYmOnKmQ6apwhYA3g?=
 =?us-ascii?Q?UZ5ObcCF3tswUGLzPsi9JWuXqryL3+sEYiJ29ujCBxzqbrAZ2ps5Zu1W8f7H?=
 =?us-ascii?Q?OuVIaPjfd6NYeCoX4R9rabjhtd2mFcmrkMAgxX4VPQJ/iX+VOBQRpCwUe2i5?=
 =?us-ascii?Q?eAg0e9Xzar1zWzOzy3mDBDxDP09+5gFISUXWHUr0je6C57in43Di4/nadqXM?=
 =?us-ascii?Q?mieLAOHYgo8Z33qcq1kyOlrqT1bONU3xzCYVYCKukg3/3CPKYQLpBBz28A5r?=
 =?us-ascii?Q?7M6jDP6aYs/MmEL6fa34cLwmwQ0XIMBpNuFbhTDfI+8ESS0d/9Ka0Mcm1Fme?=
 =?us-ascii?Q?pEhSHqlb079abpBI78WzcFu/pLv0jTJeKVATiHm+yKwo2NfdywWELR6iIT0H?=
 =?us-ascii?Q?Geecd754hsD5IfkRquPv/e5Cr+Dty3mtHgScEMhmmG1cqB6daH6lINrXsEd6?=
 =?us-ascii?Q?I7sD1El6vkVQZb5r673+Dh0LTXoWbmlLcPL9vORe/bzpRPMitCO2xd/yxNCW?=
 =?us-ascii?Q?Se/vOJs/HZonIGn6xI/6iGTHOeXw5Jt2s9wj+goYyGrDA4285YwzTX8KwwMU?=
 =?us-ascii?Q?axbOv/FWwOtQkCdbeymcSbD0EZUc9Y0xlv5XuN8ZExA5ZYGE/2F6PX11OiW7?=
 =?us-ascii?Q?UrxTUmTcQqMsgyr/EY9xzN06n/Srwyt/TGp6BH2kqyxlI4n41Trbw30VzRcW?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c77eba8-42b0-4073-aa4a-08dd916eaae9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:04:25.9581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+xucuUR8rcz39qhiAKkqhvPyDUWzv3ky0MXmV4hMuutPaCBiz1tWJEzH1mYtMA1qna0lM1gr0JscdD+vlV/cbaFBdiBoXXZUbAwnqNdvoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6357
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

On Thu, Apr 03, 2025 at 09:50:41AM -0400, LukeSeewald wrote:
> There are various counters/stats coming from ice_stats_get that appear
> to only use 32 or 40 bits and once it hits that limit it "overflows"
> and resets. This was causing large spikes (sudden 2^42 increase from
> one second to the next) in values of ibytes and obytes, while causing
> sudden drops in opackets and ipackets (as they "overflow" and reset).
> The sudden spike in bytes is due to the packets count being multiplied
> by 4 (crc bytes) and subtracted from the byte count. E.g. One second
> the packet count could be just under the 40 bit limit, subtracting a
> very large number from the byte count and then in the next second hit
> the limit, "overflow" and reset subtracting a very small number, thus
> causing the byte counts to appear as if there was a large increase in a
> single second.
> 
> This patch fixes the issue by enlarging the limitations of any counters
> or stats used by ice_stats_get to 64 bits, following the pattern of a
> previous patch -
> https://mails.dpdk.org/archives/stable/2020-July/023940.html
> 
> Signed-off-by: LukeSeewald <luke.seewald@gmail.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 103 +++++++++++++++++++++--------
>  drivers/net/intel/ice/ice_ethdev.h |  44 ++++++++++--
>  2 files changed, 115 insertions(+), 32 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

