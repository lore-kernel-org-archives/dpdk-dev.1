Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CB8C531CB
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 10:32:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34AC24067A;
	Thu, 23 Jul 2026 12:32:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id B9AC24027C;
 Thu, 23 Jul 2026 12:32:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784802772; x=1816338772;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=mQDu9jl55w5qOGYBXyGipcBGGqr9PeDkzhpX1tYCs0I=;
 b=FvQlAfpHeqi7+uEpTF3GF1QTvyZ9HDU/X4ZG9kgPcQOaYV3OYEPYP+Nh
 Nd8b4yGD3Flj/MIXptX8828e3CXCegW+ijM8erbv19W6CAAupIoA8hxXc
 LzhqAmghaVtQONJyhgUr4lD+aZX0zHVi8NqdQYCP8ag9RzGPDiFT1mO/e
 du1/swnQa4NXw8vaLErR0l2+5I2cCPIEDEiFVjTdt+E97iyt2v2bBH0mO
 tIpUE2k8PDFi2Qkgsjl3hofmB7NS94tLu4A5XhLVUwTj7HAzpZc86fLda
 UTV8nWh8qa4ffd6T5AflrkHxYXOeEufOLyB121mY6J3YVhcN0Hxd8AVzJ Q==;
X-CSE-ConnectionGUID: xlcEfiucShGsc6Yw+37whw==
X-CSE-MsgGUID: vmoR/TtVQoORfvwbPPHhwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="84433409"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="84433409"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:32:51 -0700
X-CSE-ConnectionGUID: r3wDHHHNSuKWCLgjaSME1g==
X-CSE-MsgGUID: qLuFD4dtQ+yXan9g7KIvPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="262154460"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:32:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:32:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 03:32:50 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.13) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:32:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g96TJ8ydWtLFFOx9UlhCnHS1vBiO1kxzHFWxrwE91X82HRxAUjdYFcFzmpMGXerOKRPrrnTz+jKtPRCohnZStIKAJhqWlPFw5XORv0Sxwo6KRxQe78ZnBEWUk6umCsGwADOEZ7mW8qPlYFApw4M7i803t1J8t7xBVj8Z2a3LZ6KjDY4ogwGvRTLn5NbsqpseXCHo7wkoC+3w1JCIFZ36rqmpNOQ7Mo07e8xLsfTs20VN7xg57w8JUE52DZxR8gwHSWiVb0TFVgqQu2iewXGhOWlna4GwIy1/R25wHUyNdsqJK5YpxisCW74plsY7J70Df9teR5XKJWYxU3iHUSWlIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6V62RUDegmtFQKzbesNACqld3tIwMOgcRan4xEcuow0=;
 b=t2toDmOqkVK/A0LLXvgqttHZVlgbB76uubwgw7Vjptj9/feRki1z7quwLf2Z/v17FQspKzg1c6r9UxhDyg60WMLKyrXUnNQOHImhatBfs84V4/Lp1XSiVKWj6I18DzBeMeY9XAToMRUusrFT140rorjxNP/mY17yB0aRYh7j3g2aN4SUS0Lj/fvNelFAlC/l8PNteydbLuiOM/t/TG5tnvQatw8Vy1+Db5MGcoCk1C2NHoFzdCAmOoTrOL/jK3DGsWwc20toMRxyg7oRD7s0ckZNPV+hLp3JkFoI02PB8E2oTx07zt2jAMvxeALhDjXz4ysnCfsS0F6l/gGpZndC/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DM4PR11MB6261.namprd11.prod.outlook.com (2603:10b6:8:a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 10:32:47 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 10:32:47 +0000
Date: Thu, 23 Jul 2026 11:32:43 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sid Ali Cherrati <scherrati1@gmail.com>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2 2/2] net/ixgbe: fix return value of close operation
Message-ID: <amHty43m0CLS63cr@bricha3-mobl1.ger.corp.intel.com>
References: <20260710134639.108129-1-scherrati1@gmail.com>
 <20260715124816.19882-1-scherrati1@gmail.com>
 <20260715124816.19882-2-scherrati1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260715124816.19882-2-scherrati1@gmail.com>
X-ClientProxiedBy: DUZPR01CA0135.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::6) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DM4PR11MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 3148ec91-88af-4b9e-bcb9-08dee8a5bd16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ER1GuaA9cUsYqhBUwLAoPowLs9JC2Ueudm1KZm3q5qkK8gLxPkHYioM7zxZAWgGKfAbwA3+Lv42W7GVkeKCEH1/Lip10FxMOWkGhiatNMhYiJ8mDRUV6QvYZNkaRoGOks9nl1uiBcWB8soWjKI+gJXcMYFlg0MmpHDHwhWpGhmx3i7rBZUxloI++Vxup0xE1pcIbZuGjdPxEntkFodlubdlbdW7SmheoQ+ZU3Fxf7EC4o54/LpgCV/o0piPVnj3Hscz8sAHR4rcnDK9xGXb0kv3pKcgMZPRVlBkuvO8FsEkUtgbOKJfc+mIcOBBTb0k8JXB2XT8zVCCirR91cjedsDQcFl9GScdFWWge0KWlF74YnizytfCr6n72gBvqyh9jKsZp/dQDc2aXAPunq3q9jGmDTRZo+A8zJ6jYyngYc7YqUtU9+u4GvCcRojP64L+3NDPa2ZzNucJhI2gkYmY6r6TMHhquJNXalM1agxiNvOj9F9n0PTyz5cKDSkyUnhmO0qoQ00/9ixfVi1QAFef7Um/hMoZ50qiaWiLzjf/NBKlDJyLkAz3oJU45ZCu9FQhKn0Kdz4a17PTSThJwCq5xlpK5j8x5GA1ijlPR0QirWn0gc7680LNPY6y6GuEAilLHO1Lu9Ew5vBqI7VJwB6KlcARcYR/j5D8eRbUSjWAUC3E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6vutqRej8+PFXYEC8v5uVVspDpeP3H5I5T0e+AFgNhFfxXltfexi1EQz0+aw?=
 =?us-ascii?Q?gMqWDUZv0azlKcCvSoraE+u6gbzmTKQl0s+gSB8dWnAMA7wntRpAWBd9YJm/?=
 =?us-ascii?Q?MVNVTbKO9Ms0mylFIFRzDsz/WDIdGS1tCmxEpQCRg2Pu/alqeRYmiganSjOQ?=
 =?us-ascii?Q?7Yj5sS7mCb3Szl3tEMDDrePMKtKUA94IJyvp//C2/PpNAwr9Bma13N+LcOFq?=
 =?us-ascii?Q?Pn44Wn1CnYCiKtRXH/V6M8Ie/cLpwOW+siSpAzK1eOUZ5EzRcJa70INERNjI?=
 =?us-ascii?Q?Hc+Pc56z5Fe3x1N71RdiALdz+bCxm8fXjKpCpVkznIYChvkD1CSN8+esoIbE?=
 =?us-ascii?Q?S0aiNq2q0KHgP6tGSB/jdxNfYsOPqDZd71yc9q3Y4rjdqQEJdSDj3/DjfIBB?=
 =?us-ascii?Q?B0oU1ySpWEFoxyJy8xqc/SpNqL0KBvh1Q0jZ92LXZAkDmm6BuOvGcNn/emNE?=
 =?us-ascii?Q?dzQZAJ/I6pv8US1kP2QIhH+oAWmT0PIsue6mNglQx8NZ72eViRhyXiXdWA5R?=
 =?us-ascii?Q?/et1Vkqodd/0Ai42sXkBFs7SZ2SbHUO0ga7MbJDRBUrZOskuLaq8DOB/Kgtv?=
 =?us-ascii?Q?zdrH3/9+TwR8fF5FGDOn8x1v3pghAxCVpx4TZ3+6GAFRR73lKPIXqPK6yM28?=
 =?us-ascii?Q?s6YhWDPcLj+pQ+kdPDM+gzjlQMrT96nOuufPKD4vzxDyyttuQ2WXcVgukuvi?=
 =?us-ascii?Q?WL2+ryRZyr28MwNrdkHw9PLsqgzy/EpMKfs6tI/SkNynQToJnpvOby0E3Miz?=
 =?us-ascii?Q?o43JBZqoymePN47dvtYt/q5hFTZZzPesjysCxnm140DfrC6UJxHFTlgvnmgS?=
 =?us-ascii?Q?RdrY/pCBtCMQkTUKbh777W6s5peJZuN04Hz3OI4jMVeqPTZjA2oSqGSwoscA?=
 =?us-ascii?Q?aUOzZJrnoAsnYOQf0KQsvpZqpVz2F1pO/5uk2/bRcXcwKzMg0cvh36sRyk1X?=
 =?us-ascii?Q?7dHhQZDPw3o4vevfKG35UItYgc8vamk59gpy33NqPoAjDR7tuqnrwP8Zk5Pz?=
 =?us-ascii?Q?Fpkd9Y7gk2lIIa1N2j7swRdsEBt2Ke+Bnq0nFriyX/jiFI6IYwz9IooTePvD?=
 =?us-ascii?Q?SpgTMjommprjb8YLeYqPv7KHEL2hb3/gTUSpdif/VQUyEqqKkaQ8IPQ/+p29?=
 =?us-ascii?Q?lv2c0hmQ1mxjdGWFMLpNkXY+b0S7ubDYwTyvVF9CPmaFCil/vB6vsy3BWbbb?=
 =?us-ascii?Q?MhZV2nyEVA5NSIZi0HqHgRM9130pRuPVKmh/wndLbM+nLA9yzNDfhVv8j3qx?=
 =?us-ascii?Q?WfTsJc37XIr+kfVYHPk40C+Its0X2QB/GuzgSKXRIz7M3Cx0JnB0FRoEBrL+?=
 =?us-ascii?Q?Q+SeJfJyNMStlZAIMJn8tAfGfrvYU8/jcZ/2hsSQdCUOLQuRlYeSgPm5pGkE?=
 =?us-ascii?Q?4jQzKiuz539+lq70VAlp0yAGU82U1xqg/tUrI8jPxo8pkYT6eb94vgj1g1AA?=
 =?us-ascii?Q?krvkaBB6Rite0/ndL43ZpW0zgrg+jgzEfEpg4/BTFgN6mkhFWkViUe23kOgN?=
 =?us-ascii?Q?TvqEFrzG+JFa+YG2h7lim/KKPufTRSqaE3FdBQOs18YMoPh5lPZhX9Mv2rVX?=
 =?us-ascii?Q?osJTEPQhzT2KXk08LXo8aV1PG4bfPxpcwOxwxacaIjnB2YKeZXjz8E1lJFll?=
 =?us-ascii?Q?CfPYd6CWoJzUzxLJrUZchIcA7ULFe4iBP2vSdCwks9MHdpdX6QU7PJPqoJnZ?=
 =?us-ascii?Q?Rap5z2PNQixSfPdnXFna+vebeQk+QheUHicNB6qqSIaWq9eAITteBJZwzv3K?=
 =?us-ascii?Q?NWN/Q3owAmy+ruxwp7Nhy/XDcY6PyBo=3D?=
X-Exchange-RoutingPolicyChecked: QeOlJd36jScucKVLbueJqpxrzWcbnVq/oAKk5YgNAMiRk+MUZUtVTO6TdbriFfEZ8xwVBjWwMXBjaMjbUIQ+QigJp01qZdsfQbbeXEcU64eHazlI6YbHz2Bazd90fSGZ4Qhus3fJwRjBvOF2MG16WP/1KLWpRxv1qrX9cvqsE55mmXjSbDCxIC9c5F2zs3/cke3zoTlO6zuuvqKioeo+2h/LOAA1r1y1Miha5d8P4BoFmF/FPMKNd/gvToc67DVD0rq7MN7opFfPkark9Zkw5gXuUOzKhaa7L9hESchYJx8B8v8bGT3nq1ge+N6atr5qolPe1FL3YV8MIIIwOGUF1w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3148ec91-88af-4b9e-bcb9-08dee8a5bd16
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:32:47.4377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4Eja0Z7kRluV61oEimdbjOTdd8C/oJtUH79Pn85OLV3mrQZVdRFIoVsHgY1+mbhw9jRUvS33IPTsOly/vHHhPds2cVlhf0mkSjzJRObeDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6261
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

On Wed, Jul 15, 2026 at 02:48:16PM +0200, Sid Ali Cherrati wrote:
> rte_intr_callback_unregister() returns the number of unregistered
> callbacks on success. Since the close operation started returning
> the ret variable instead of 0, this positive value leaks as the
> return value of ixgbe_dev_close(), so applications checking
> rte_eth_dev_close() != 0 treat a successful close as a failure.
> 
> Use a separate cb_ret variable for the unregister return value so a
> successful unregister never clobbers the dev_stop() error already
> stored in ret, and stop retrying once unregister fails with anything
> other than -EAGAIN, since those errors are not transient.
> 
> Fixes: 62024eb82756 ("ethdev: change stop operation callback to return int")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sid Ali Cherrati <scherrati1@gmail.com>
> ---
> v2: use a temporary cb_ret variable instead of unconditionally zeroing
>     ret, and stop retrying on a non-transient unregister error, so an
>     earlier error is not lost or masked by a successful/failed
>     unregister
> 
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
 
