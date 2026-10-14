Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7755CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 16:25:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0839E40272;
	Wed, 14 Oct 2026 18:25:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 863D140144
 for <dev@dpdk.org>; Wed, 14 Oct 2026 18:25:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791995145; x=1823531145;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=54tPeHo7uled2hXqjRv+WbAytIRO/McrgW7QL+qBc4g=;
 b=Za8tz/K1ihkfeadjn61R6UbomNO86ZXSi6L435xhVMU7msAe34HcmtSD
 Fvx1+spNn7NjaqWAGxgSADmrXoqtQ5WrYAM3ECk6Zj4gLPqfgT08azOc4
 8V3cQTzvk68gEW3il3xKoIpPt0Vji/LMKlyXkF9Yc0auUPDALhFGMw4A0
 yUKZnxXWU7m7g/LWDeJNMBq3YNBn8o5x58qGDTIeOlfgq2Olwmf6SjUmM
 7Ih+awe8q1u6yN+BbJ32PjswGnJEwb8G/JL99rpDHbyBf1AIKRILsH/hU
 Ag/L9oDotJqYQno8d/AsgVKmq8JBBS+lae1VCyp8B8YwFBll8Pq/FKynb A==;
X-CSE-ConnectionGUID: S9MckE1RRvmZJaixne80hA==
X-CSE-MsgGUID: kGLRxn2rRyeRjSHewF5oKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="765980"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="765980"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 09:24:18 -0700
X-CSE-ConnectionGUID: B4V1OWFsT92ZszXCgCXRPA==
X-CSE-MsgGUID: gg2n+BU+RuSaVLByCeBBww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1356201"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 09:24:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 09:24:17 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 09:24:17 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.28) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 09:24:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jzn1C66VVwb1oBzlh8EBUKvkS4NiRlJu+R4Tn47SsqVMhGv1xHe4E6KTrWOkWqJUEbQ9OrJcFrCdS4HMkwIRK/shhwET5vE//lbMg/ClH53PaYPRCccloT8ZAL4ZLKPaRKdU0mwbcpJSAdhfw5yhrIe/gbUzkCIegpeLy4ycEAHn8fFNvB5nbPPCOupZUzJkQBeZYrZNSIl13pujLOzPmjDqsNTG8AVf9IWPW277exleYtjLaWg4OyNRzHyACDJ0KET9jLwyFMshZ1BPnA/qqPIcP2pkcDy5p8fLgEkxA8qIlt/trCWLNUipk2fPYth7517T4jkgmb4IQJRROpV7PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MccwtjBZ5b2TRJe/0+Q+7oSzRqoF31gZ72/72SRC6tI=;
 b=SlZFhuvlt8EGaJQbcAh+p8yFwiKo8NGz/rEku5PGDx2g9kyEyyPCU7/CboBxH+Sl2gWNcSKPzivLu4d4dPSR+tSa7I4CxQTrU4WlgYNPIGIBJP6mDF/mq2aPaPZ1BO7/6qXiNzV637XfUJhaSHiRn7s/wNkBXrhe6Xn1qOHPG+lepaMZgNzSlhSiGgvfiODsK5xnRnUUi4kF5ts2gy9UzzCuDsSYWfbFOI8vHPyXy+PpmRu1gg28iTDMPOd3Uflfqqqvd0+9kK6mUc+clR3HRfPTaKLHtYugBDBY7OmJwRjgoNdXWXox5BJeeIO0OQ02cjYO4S624rOdInsLHNTc7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CY8PR11MB7241.namprd11.prod.outlook.com (2603:10b6:930:94::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 16:24:14 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 16:24:13 +0000
Date: Wed, 14 Oct 2026 17:24:08 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] doc: announce removal of legacy telemetry
Message-ID: <as-sqDz9EAuaqBY4@bricha3-mobl1.ger.corp.intel.com>
References: <20261007161737.2351221-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261007161737.2351221-1-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0262.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::27) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CY8PR11MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: fcdc64e6-3127-4373-d93c-08df2a0f9553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|22082099003|10067099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: +9tUDaE9Dntn5mLWSiy6TpL3rTJJ30NMmDAm8Rv1vXGgnYurziusaBVU3ESmTx5eJRqtRj83PGct+KTCNHiwMpsYqOiGXZ6MAk2231yP5HE7j5UDQRKCZHhNbbXvjusFlW9m2uDo7TPU9kGsBUkGKCaG0LqlV7NZnPDI8YK0VEQRnCIqKNa/vV6D390bpSo1Ow2fT6JU/gPU3jI4kjBdp6Hq0mLHe76vzU20LOFQ7C8yLivogjZXqWwOa/hH6JVgN/nKsltmHUrPyS5TeRx98+qoRAtGf1SZYpBYl4cYvSACHVl3BBC3lkXrlVMF3sp/1qRXWGezsISMYymcHKdpEH29AvB4viB7I86JVibxCzLJee9IeyvcSSSmWYellyQbUwEtgx6WLleS1dLQMOotkzMPb7W2lNr7pCw9EUQYp1ZfBAKo6BvYjY9WC5IiBgGYwBGWHBiPJEqlcnyWxa1WJ0l4rfTw3cEQJ/Q1wfn9cyUODK5uxr51ouQCjAi/I2EASWL9+jzaS5VS2ZBoHUA8BOuWect1D7Sf1EHxvdy+R40dM1/5Bs8EcZ99bnXYYksslUVxsZSyNxdwglmdCyBUcuky1BOcjUtC7b+kHfZQ4ldL10F6YLYU48HqzheHm3uoT/2zZ8vjfwUWZyHv6OHqdIpvYclnD6NhPrHR6BQFC/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(10067099003)(18002099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Go3KrS1fFBqD6qvlS396rE23UqAsZa+MRbn1/oJZE5EPgl73MkusEyU1r2Oh?=
 =?us-ascii?Q?S/eBfVWFdmG0WKme5ZGzlD/ZahomZb3HBPDNHh04TZLlU1jMPHmjqoIhnLK/?=
 =?us-ascii?Q?G49dYt6DWKqt3xTOgsNE7GxwhDprQRqHhFrlfdVwhxFTcNAu41Xm386oAxJv?=
 =?us-ascii?Q?zleKwoNY3Yw4WMwu6Sy8SYtD5c4Zp/ClTk/tlBIIM6CdPrOnRNdB4X7hHgfE?=
 =?us-ascii?Q?lDvJATIz2dRgaHcT+ApyHpiVn/pWDlLpNxmnGdLti9ko12QADHKZfJixKynG?=
 =?us-ascii?Q?TXS3TJLQ025XD7XAOUziVoCDYnz4g16wdDy65i2dalij4Dgz69EVJUUxJgLk?=
 =?us-ascii?Q?KTSuDI6ZSUeZH802i9BIzofOyVkfVXC/zJdINtxkqmr1laUO4ixxtoGBxfwL?=
 =?us-ascii?Q?XvOT8MVYC2dy7NCkCi+wfDT4mig+TIj3iOAuS4/bQMpTsM+dEvdriUAb7dyA?=
 =?us-ascii?Q?IRXZNwyro5omg4wTW9p1yzEtauimsuqmLVRYmFXbNJhVb0vjE3PndBvQVF5E?=
 =?us-ascii?Q?QDcDT5O+OXdmq65dry80VLW6IoKlnUertsnQVZvIlVv9/UZmQtJjBHwuUo4s?=
 =?us-ascii?Q?lMR1EaqYV0OLfldGOZmSUL1JIkxn5sauMygqf/EL2HDz5Z9YIBgeE7zgbQyj?=
 =?us-ascii?Q?56f0BxpKfvOGv4B7rQ8u061Y6Sy/BaNxBbBWP5IKIohlsiPjYBmbOdq3Gwb3?=
 =?us-ascii?Q?DjqOiSb8RbKQBApj/ghNAKKncSyitr5lnrYdQpVvluyK2cprNCUSLry1vEXr?=
 =?us-ascii?Q?nbiAkleJCYRnrSd7Vr3e1Lv2huYO/yhfnXvt5Q8FUG3uPZLUQONyMBMR2VPc?=
 =?us-ascii?Q?AuHdMK3hEX59lWgMrQ0CjjJNxnY7A+O+q/X+xSYNM3fmIiBy9cH48hAHdtvR?=
 =?us-ascii?Q?hU7gOWlcWzpGlz+C+I3xNJtorBHbkMhNhb6AKF/HZKW0YTinvo/4kcqDX2Tv?=
 =?us-ascii?Q?MG/TqKi0F4pOkeo73ppOOK9blqLQd4gnVT1hPkiIIs5X6ycl+MMYbTyIcX56?=
 =?us-ascii?Q?9gQ0GjMC25dtudUqV+xgHASORejoIk/TEN7wYcv4R8efPiWkhjsgAQwAz6rf?=
 =?us-ascii?Q?eF6MLFfzrXKfOmczBkwMWGpnR7q5mrJJYWSqMmMN8Tgs5fHnGxwxo9QH1Yw9?=
 =?us-ascii?Q?QaMaSLa9KCTk7UZACdG8qYfC3S8QL934GVO32KVIg3XlNZrzLH+2SjB08X5J?=
 =?us-ascii?Q?oXrQPLwSop9unj0+zfjOUTFGe6n+iykiFYoZ73TlgLm1LH9TABL8a4TL0lnp?=
 =?us-ascii?Q?KqrYaciBtz31lbCnwYk9XqY/LdH+lj0u6llmfQecKLEtsXAJS2+/SJTynl5W?=
 =?us-ascii?Q?SPjMCdq3AMArMxIuHsBNhRbgSnT2Og6J0sy+G0nb/J7Rf5xdcJa9Qoq4Vj/W?=
 =?us-ascii?Q?JdUascGjMV0WC/wM4ceQIPBEVp2noYQU4KAZeyfypKlKhlq3vu9Y+47W+BVI?=
 =?us-ascii?Q?D4XM9R3MQaTdS5bvkI7pQpNh6mRD66G4gOREx/RtwgrX3Y8/WHn2vIwDB1Wr?=
 =?us-ascii?Q?3SBKvcR3clkdbcEq9rPEBVwf7GbzO7vhmym1vk/kkQNa0SQJF5KukfN88Rbd?=
 =?us-ascii?Q?Y+xqD9bYvfFJxeDAN8hpos8r7YaUsMwrWSJqOxN9teENZstGDx+RabobeK4+?=
 =?us-ascii?Q?IR1QxLKjAgDc7si1Xq4zQc5z94xYGLLQCRZhT+bJ5HY5I0H4UPVttnMXch1O?=
 =?us-ascii?Q?xrBGMEInBHCELQvvdC7oumldQvVAFZrMBUPQZFshWJ132KyP8wsMrtQAave7?=
 =?us-ascii?Q?rXYC3mG6ulAvWHQANxuhxSA3C7WG/2U=3D?=
X-Exchange-RoutingPolicyChecked: JmmjwYiZAGMT9fU24IFZoQg6ykbGD5FEEhOmbYTZlzAkmXx6v119BII+DkRjy0/knmA2F83VyJmItVbVt2da3XC5gN72Ia9lcKxBrulOOIbjL5vZLvU3z+5F8wYjimz5RYBnbvfsz0i2tZaioQYQFXvT0swM/TOiiJ6eKgauw+JuGR+gyE163YFQQFzqZoRN/g9Epq5L85uMN5hTx7Uua646QVRSU4j1YDixrmg2nw0a8am6fUIsdwmze2DHV9xt55dm0gHmURZPfMgZmO+luI1R6zaZ5eVast9BBdt0KQRiPYugdIRD2vdsbgSSwzHqWsI65Z5st9ETdo2G4Z8+WQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: fcdc64e6-3127-4373-d93c-08df2a0f9553
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 16:24:13.2780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/OstrxctzX/1Cj+TwqoTHsbiQcqLeNUWFe0I1Aj3FwAgbEXoG12pYKwbJFLsu9OKulgVvyW58NAehGF2MhJljhHWjkrFNXfzUObOD8dcfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7241
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

On Wed, Oct 07, 2026 at 09:17:37AM -0700, Stephen Hemminger wrote:
> DPDK has carried two telemetry socket interfaces since 20.05: the
> original legacy socket and the v2 socket that superseded it.
> 
> The legacy socket was kept only to support dpdk-telemetry-client.py,
> which is its sole consumer. Everything it reports is available over the
> v2 socket.
> 
> Announce removal of the legacy socket and the client script.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/rel_notes/deprecation.rst | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
> index 56a67c372e..fba852020d 100644
> --- a/doc/guides/rel_notes/deprecation.rst
> +++ b/doc/guides/rel_notes/deprecation.rst
> @@ -138,3 +138,7 @@ Deprecation Notices
>  * bus/vmbus: Starting DPDK 25.11, all the vmbus API defined in
>    ``drivers/bus/vmbus/rte_bus_vmbus.h`` will become internal to DPDK.
>    Those API functions are used internally by DPDK core and netvsc PMD.
> +
> +* telemetry: The legacy telemetry socket and the ``dpdk-telemetry-client.py``
> +  script are deprecated and will be removed in a future release.
> +  Use the ``dpdk-telemetry.py`` script instead.
> -- 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

