Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADEEF53D67
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 15:04:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 624E24025E;
	Mon, 16 Mar 2026 16:04:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 6D370400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 16:04:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773673444; x=1805209444;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HIYWN+tYrVDrEBTgFwbNmARGk5ag130m5N0BOW5VdBY=;
 b=R1U/MUp4PuGBQrztbSi84S85J9fHqM4h2q40ImoMIpW5fxs5XgMEuGzi
 Xok5R513d6yMdeksNQjm7atuZvKsBzlwi+WoZUeFqlak7TJBayjrT9j+R
 Nj7hzdu2hRwiDevqPj4CdIjKgE0aeK5TFI/jmYq75xnBR35PgYzpb7wIn
 xsgwxDOQA2gTKYKJkJ8cF3rfSSSS3rGHY0SETmcx4kHaMk+84G4L1w0IV
 mnusVJh0KwPRx0hkj7405xBZCP1Hp3F/EcdirsPN7RtTbV0N5pgJhMgV5
 KZVF6hm6zwhbjBqfMXyC4r248Fc95toOJUDtd627MvUDU4kUtRLN1jD6l Q==;
X-CSE-ConnectionGUID: 4GK5SPsKQnCptNXq1zi0PA==
X-CSE-MsgGUID: wRfPPxAfTPyIchv+MgOMBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85007195"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="85007195"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 08:04:02 -0700
X-CSE-ConnectionGUID: rn/gS8c2QRe4WoTynE1LdQ==
X-CSE-MsgGUID: ll5J2wBMSvi47YWWC4wvmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="222025540"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 08:04:00 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 08:03:51 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 08:03:51 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 08:03:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfDMxSmBOoGlmDkjoLTDVE9X4N2pSIZ0leBv/iaXRsBClksV8IJWMoFLw2iGbTBXLFrTfBOb7OwC9/0C9j4irb4ep0YhamLtApl8Pva7chNCFIukPqUkcBhJYo8ke4PfZ8H7uxIfJSMdNi55Voe8hKnJFV5IhsWP7eXso9+7nwtx5v1ibg/coDRrPcze6aX2pgw31c3H2BaQ0s54fa/OS1BJIDM0WDf97F81o3nVM41uNeQy5Ami54kbKsK7Cqv2gdl081Vp3VjNCVW0pteih+nfZTD57vPnuuL9IgZiTUuG/2iohH1MDO9uIJnQ+3lsR4MfYSMaAhC6VZzl6croFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/m5mimDG9zkGCBikRyCgegrPIddociMobVuTzLSeHhw=;
 b=B00ciyudEhL8YpEHlD1jHi/eZQzWz/zNrlKoN+mZWdKnkQ+/UtKmP7v2MgidiUEiti2jXZ0GKjFDPu+DxrdL743oPt+x/V456Bj0Dryky4+LSQ0xdZ+tCw1T+60y77Lt9iuOqaKnABJxYHY/mzFRDkMNzT3Q0+eX5Qdk/POevFU8nW3fzVaH4si0+Y4V1zQ62HE09QwrF5o3v5wQW2UBRIwcFIXxuWsbrUET5hzttgfVBd+5oZiesNL3NOmcb1anKdLMLBDy1UN70p3yWbwM/FJM4G4GXo2PtieLvlZvIy6p/qWf1gU/tBNJuNHFZKgaoZATEjNChRAtoaRvlFHpnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by LV1PR11MB8844.namprd11.prod.outlook.com (2603:10b6:408:2b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 15:02:58 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 15:02:58 +0000
Date: Mon, 16 Mar 2026 15:02:53 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v20 22/25] net/pcap: add link status change support for
 iface mode
Message-ID: <abgbnQRHJgJK2-bo@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-23-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310161356.194553-23-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0080.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::9) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|LV1PR11MB8844:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d59d31a-77fa-4aa8-cf32-08de836d1c31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: B6qCHOIvWun82i8SpgjfEXbJ2uH9WhgOkOYzc52TgoBR9nXu/SW7SyaRydxxOSUSzF3fMK5mlW8WDKyr5IXn2esvE+hVUvcBjbyqG0HljnhiZSnglCejteHOUy7zdKB83R1+331xRtoNdewK5RgJ/b8zZ6EPNuf6RugOWY4YiKgCijQQZnw6VpU4MqNCvcLUJQoifVF/vWtoZHO6wT5O+fafekwkDd185l60vgAVkPjt9uPA7qD3f3McHvYFGwxxDm5U/iwPBOjScT+D3XGACLmyeQPUHZJulJxGJ38fQ4Ok+hZeips9a8c/z2ADDWe84fgCkYMBA2Diyjz+ub+1LR158x8gBsj4sJe5xavZ6A8znUuiwQTSrEaQ0E5dbOlvb/uzKUlVFDi2OOwmZukZ7dahyq49BBqXclciy8mgWaLCm3w32jHoMkb8FQPnsXTyaxk4bG/Z+s8v85bXQaeH8x74ThhB/TogN7EM4zhBFXDeCSCtWlKOaj/NBo3tckf84e+yedtwPysaazAL24OWmL4zyC7EA5kTU/gJm2X4kVEs9JfwgT6AOMZpS5PkBvxf3coURyjcPAf6ow/wB7iEkOYrgfH5vX+8szk6fjUovPs+7LwFBZNKDgSQ7Ry/tiLksoJwYH8p7rn1KplCIL2Xy34HCfrMxK4XZ6bkosZRLZCJYChhcNtbXnK5O67w8GgEDQGwHA7w4ZoPZkri+9kNAuwN0/JJS+EmJJJMPoADJNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pUMnM0lTJJG2QfkzkSbF9KxjdrSYtaDDgo84e18DsxopvbaPDk6CJmje6/Ok?=
 =?us-ascii?Q?4FKpQKyJZVKMv1vj22UYc0nPJNzP0MKbCunRlZRrAyH7YXY+7cbr+reQ20Jw?=
 =?us-ascii?Q?hYNG9gNQIExP7ayA0edBMxptYyfKLCEc4TbKgfw90nJe76YybU/4pGTXzdjb?=
 =?us-ascii?Q?y4zw6POreAN+K4oMVlSjxxNVhddbj2AjKexCM37d72ofxmF374Ni1UMy7X0i?=
 =?us-ascii?Q?RpkwMBlhDRqsPIpQbOkBMaBTtAIWeYg6V006P22nqrNhqqKO6Eee2+SwTdeg?=
 =?us-ascii?Q?EB2J/jYHtSEbnpsvPSM6F1eAH6kPviCZsv0adK6GwaKwpyFI8iup8yEhoMAG?=
 =?us-ascii?Q?3yVp1XqkN4bUkol7iG2pE/rH4DcEtXe6TAliLNjNqRVyeEmlHu+6DRzOL4sC?=
 =?us-ascii?Q?xZxEdSYvXCwakbLAAEtAncKZM/n+zTKsTkHtXiA29cqg/GVpZozp0L8iEQ6V?=
 =?us-ascii?Q?kmiNlP8YcUWfXb0LWhobh4yA3nyZMy0FHephUJkyWYp+WUk8c07ebhHSwEcs?=
 =?us-ascii?Q?zuVqev+u9VE1xgDz+hbWSA/Q/ZqvtSclRlFNGEh63cjZ0CGW/Z+x1B58yeWC?=
 =?us-ascii?Q?iblmF8jPDSqw7BcdV+Xz8S6oXTP9Ynidinsf25e7chuHI6OdoPoKCAUHLC/L?=
 =?us-ascii?Q?IvRHXTStvU3eDzYrOw9eWLVZMZEGdN2I1bS+jbJbCwZurb596ZTVzOYUzxHU?=
 =?us-ascii?Q?a2lkF7+IVQtV4QNDNVdivzEROdTwbACy/C8gtoLTZtJiS8LimTMub5DHjLpO?=
 =?us-ascii?Q?ZbCqiFcrPZKn4+Qdlv3zjcwFfnpF2HhOWlZgrhPc+YXJnv1EWW9SbkdDDbQa?=
 =?us-ascii?Q?HbQv2nR9MioNkZlhClvIfztPtHQOXz0Q4zz2bSF0uo2Z4BzLu8fnJ1DADpW9?=
 =?us-ascii?Q?AhKxnoRuZ+ZQ0TOGnCfS5yOZdCK/KQp8SJxfuOi2GObDrOB/VBILWKKZkPWs?=
 =?us-ascii?Q?+zzSuWGEH0aFpAch3e2V0btaUX4gptdOGZIBu7Blz52bjl4wM8BxhUePwIrW?=
 =?us-ascii?Q?Q2LRJEuVk0NoLg7BQdIJZp5mT748dpBUoO4KUnACMZMWxUCOerPXY2he24ST?=
 =?us-ascii?Q?fCVVEJiCY8XqfsDRCY1hBdApF4m7QXBkVr/B/ARUYZUy361/4KxbMJ361XzZ?=
 =?us-ascii?Q?BED7ypBMM1QgR3ZwepfdN4v4mAPsH+G3ry+4VARPZ+PTi0k60iSeLDzCRTUn?=
 =?us-ascii?Q?n9uSKp1JKQ2jkJRAWh99hsMxl//mdPCYAqfd+sgnu7ZkBq5fI9hrwRx5pHyM?=
 =?us-ascii?Q?jkHt7hCjX1mzb2Du89SDe/pq0SJjJc8RN2Fx9lNemtqZvNKUooL4gUoAY24U?=
 =?us-ascii?Q?6JM9q/sLyvXggTlZsCgG5zoyl+OrSYkg6lUZ9f/jAyJByy3g69zvByewtqVy?=
 =?us-ascii?Q?lRUyOZT528CPznE7zt0nbAT8B5wen12F7Fz6AVSU4jZGMu1CIp2gXqV1UZXD?=
 =?us-ascii?Q?qqg5BNbHEIHS8GU19+Au4yWbttRWhKbIkDHoF5/Shtjj0SjjhTWdoxCfG9kd?=
 =?us-ascii?Q?EKG8YEcBz4Co4ps8DlnjBJN+kfFDbYvqV4Gck21/c4j4PLj4j9boGt3eUJM0?=
 =?us-ascii?Q?sXBW7ubr1wwlL2OAwVGH1vbSTvbifUdVoPBanFiN/bsNuSrW3kD5Hj0C+4pJ?=
 =?us-ascii?Q?SCqYiLnEJWK0E4HKah5hfTJLmV/JRqyRos/3mhTXsm/Da2s6ffSY5xVLf4nl?=
 =?us-ascii?Q?vGSaeQ24kdbRUePnCC28qc3LuITY5tDeBfHqWmlQYUpspk9bXAbfGyC3s6xh?=
 =?us-ascii?Q?8qLx8BUtZLsKY53imaJ1VrWmxZ9nYkY=3D?=
X-Exchange-RoutingPolicyChecked: aJCcyxGr8uvHFNywV3ffSg404SZSAU43eIIdwabW0wHaqmJzWsCWzOgN0Q1W/PB6tOcemhkYbcgWmsR8mZSFEE8Dr2wccBdQ5KJFwnKB/jWkfI/4q/+//XXGYIXzvQj/jRQJQNisgjBxtVTdZFrDjWMSwSKHKomyS3mzM+cvwv3V4+eL4+zxn17p8DmYY5q5Xq0QBRwJrZR4e7MeKr4UIM9FZWBLX2bArsZ49Ovhdme5W0AzzmK3G01ZaSYboslU5a9LD02mUm6TU2vAtquGtYPjE861D5eDZTV291mpVz51YDBnSy0hLtR6OPYOD3zlZS1wa1Lrs7LFMoqHP899qw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d59d31a-77fa-4aa8-cf32-08de836d1c31
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 15:02:58.2139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zKj2lfOW7yqJx9SOa3RzdXzkdpbe8UBMwuUujqAeLwv6/q3Cx6h/o0uQl0wUp/45sTBZASSP2KHElY3riqg3TuwppNAoGjSvmK1kdbwRxV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8844
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

On Tue, Mar 10, 2026 at 09:10:00AM -0700, Stephen Hemminger wrote:
> Add LSC interrupt support for pass-through (iface=) mode so
> applications can receive link state change notifications via
> the standard ethdev callback mechanism.
> 
> Uses alarm-based polling to periodically check the underlying
> interface state via osdep_iface_link_get(). The LSC flag is
> advertised only for iface mode devices, and polling is gated
> on the application enabling intr_conf.lsc in port configuration.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

