Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7363CA6C9D
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 08:51:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF18840665;
	Tue, 27 Jan 2026 09:51:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id DC93B400D6
 for <dev@dpdk.org>; Tue, 27 Jan 2026 09:51:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769503913; x=1801039913;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=CemhQaOdQz7m0S/SPryz03wIyttoIdmxaQh4bh89GEs=;
 b=diNPx/V0b7QboTCX9kVgUzD/emBIbcuKPCzmNBIrbx6ZoNRpC7eZSAjS
 uvyUF96Yn9ZBMIr0s2UaYyHsTzXkYYCWh+HSCdzfDWy/nUBEZnXAfz0XN
 qbJiOLUm9sUD/Jst3LmTi2XHkd+SSCuOH3wrc+BKEHjo//1MtePwUTnvc
 ta9Pjk31XWEEpYGgroksPMx5PvzX9qj0I617za/zzekzpmLhgSTM92Nll
 pydbn78myTN5ReQKVzllBsx4e3qh32oUzUDdQALzo6CCIokJo4wfJw0Sh
 gaNecbPWWm4INvX1zzs+gVd0gWv/MRvpg0S6+J4Wf+K0DNIa+FU3+cwaT g==;
X-CSE-ConnectionGUID: /zW8mmBCTgSnwZqsK2RYNw==
X-CSE-MsgGUID: 2HbnQQueRL+YCmhn/bmHbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="81327016"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; d="scan'208";a="81327016"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2026 00:51:51 -0800
X-CSE-ConnectionGUID: kcwUAE7jRfGCp6kTkMgRNA==
X-CSE-MsgGUID: UqgsumYNSkeTpRiGfFjl+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; d="scan'208";a="207043625"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2026 00:51:52 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 00:51:50 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 27 Jan 2026 00:51:50 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.42) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 00:51:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buEPqpYYqSgONZgYJfrv/uag9/ZXEEgI2a72r9sv5RUQ8ErXN2cyiXmSr31fa8Da7jnB+uG9YjoTAGMbwjHPXoS4oxZGSfZ4EtA5V+f2FSciZT8pqiD3wzjbNZ1Ba3d+qlfzgEJFuxqkd3oWBzt6aCBjqCns0wVQ9Ac9+TTzw+fKNncDeMbumPYfEAPgDi/kuTBCU6+pTHWvDePAa4dvgONSTm1jQau1xPqncYMPlBVK9KZWLYGxcX7JDK25WoyVqnNqvPobErq1mqS6MjJA9CBAkkW79vlRT1gGCZFLzNV4n2ZM0cLy8qr9nILVCHmh6uDrIDGlvajwivtdlYxsYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EliLwBiW8ZynQleST6BreS0PQFdvYv2esH/EQXtn/rA=;
 b=LGMa0T5B1Vu1YAw4LcWOK965JJ8VSRBNeZ5yLOLCsFEK7qvAdK7SjM028ldN/qXfRmeHIZ5poCpvb+MvNkz4hYKq0u+6bjN5A1MSMfAUnk3wbpNEs5aYm33uv4EyHwX6NolKUrhf3RLNitMefahr38yLyKEPp8cr9lf3DWNmMuTQY1Sev67aB+M8/eVNaGNV7kghiyu3JsHb1G5Frrxvtlw1xW9uHMQVvK5ufZ8lb/Soom8oVOQ8bRW822Gl+LdrVPvHZr64WE4axrZfBhzJ9L3j7zJ2GmR5VPTMHGvnbZxmt+/77qz1nlm9DZZbP3us82Vq3/9nO3zl2GANZ3unDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB9448.namprd11.prod.outlook.com (2603:10b6:208:572::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 08:51:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 08:51:43 +0000
Date: Tue, 27 Jan 2026 08:51:39 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v12 05/17] telemetry: check for path overflow
Message-ID: <aXh8m4mqxwFUqmBO@bricha3-mobl1.ger.corp.intel.com>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260126232428.276534-1-stephen@networkplumber.org>
 <20260126232428.276534-6-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260126232428.276534-6-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0338.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: 969fc978-0309-4406-03c4-08de5d814bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LxTeJHEHzIbbHBp8UVEyfm/I2TtVRLj/PqzW79cIHnqPu2Z3JxWhJUYxXVor?=
 =?us-ascii?Q?SmOku5EEGrCU6RV2zwWOLYDK7GO+o4wKbnQZ93A7pBdGEdb+bPpDfP7YBkzK?=
 =?us-ascii?Q?K3ea8bTBeRuzq1Z4p2oJOJ27h7xyI0t7HCAzbtRMQtl9NmiAy9zQzn5EgIMp?=
 =?us-ascii?Q?jH7up9MhQ14nDZQQ/QuqB/vVDB+xBQr3KpoBksRTFvOYE3v/uQLvo63SD4o7?=
 =?us-ascii?Q?3takbJ3XQejViEvzxBEpCB/AVVUfTzC9WIxznRpbxIQaOc++JB0CkN7Z+wLd?=
 =?us-ascii?Q?jZVqwTom6Ysp45j31ee6oRYZCaPVS+4TUmyKSFFxEaS//v3a/EbU4LR0Kk0Q?=
 =?us-ascii?Q?tbpsUpYPd8MDh+V3EuGyIxuDZnkAQA3mSpLbJQTugpWlLNzRM59zOcl6R4Xa?=
 =?us-ascii?Q?tQ4Rt2DG/0eTo1IUxon+GyCsNMrCTNzJPT3I0J914L9lRiQWDU0sCEQXwUuT?=
 =?us-ascii?Q?hZ0+IFyyzEx7+JYF9C8MXK/BWfLlex4vDr2kkxE7wMHhz6lQbQy3MX//mLSP?=
 =?us-ascii?Q?nJO7Y/70hCEOwkzs2jBQV1UFmEmBlxllP65NLWnEkMRGTx+JODNv1XMQ2jTC?=
 =?us-ascii?Q?xWPvfBoC+w4aVvGFEpaBW3BFAA97Pse5N7jsxcxCt/UrfmvvvWofZtcsEXOg?=
 =?us-ascii?Q?ybxoO10NpiX8IWv2UFPQTWuGfzx2lEVJE/1ovC/dk4NitChTib/oUOI8+iwC?=
 =?us-ascii?Q?tva+OqJwzxpf+5oXs118vBL9/BlcYPINy53yxox0+nQEN5N0JB9uM+nTXkoS?=
 =?us-ascii?Q?WFVF5DZsjS1G4K0pMoqTtDxDAMfMu/6X4DaXM+Rjz5m4yNeg8y+X/i0hewiA?=
 =?us-ascii?Q?SIl6SNgJHBYI05yKxEAGa0jc1CBzR2YeJFQSZjOj3uK6yiXwy8r/blxZUUPD?=
 =?us-ascii?Q?p7p3frFojulq4roIhoKdJ1AfLWoRmnKt99ijQaEOEwLnIC3T40s0TC9AdjAr?=
 =?us-ascii?Q?AvzWY550nJq4BpUBMyQZfAb3GCxy8p2TKbbTdkLG7m9eP1k6l2/nFMbDMDlP?=
 =?us-ascii?Q?GlMf95ZU9EQ4vwVxrI306/kK6Jfqo7HzMh4DfftPaJuEFqux2p/GSEwfpN9I?=
 =?us-ascii?Q?Z2LskYVfgfek0/U5E0V0spgCiJKqUHdWVFggEzpMAsW8ui92H2zQroBbTRFf?=
 =?us-ascii?Q?Ky/GEgvPbSgJ7e0SeUvmLQW8dBr8Lu4ba4lTDmlWBxO8Hl0n4d7a8dWG9K2b?=
 =?us-ascii?Q?NVoGEcb1nCoU+xKeiiXtIDBuVgaLBV9XAI8yAkJV8NjWzF1Zwsd7YlDTfDO/?=
 =?us-ascii?Q?fgFqlH3W0RngPnyROoy5BLczMPX9pjjBpIc/GWnGAcfr9aqlmVzjdRpi37ZW?=
 =?us-ascii?Q?9vPeaz33Jpf00DC5cfjchk3Ee0pBbXbn5V4kPl6D6f+CnmB6zpeP//t1jHu1?=
 =?us-ascii?Q?JehIHMllwUJNnX+TPnkXxCMLtEHrT/3Mf/s4YDZqeFLeLzBw1p8mHwWhZg5g?=
 =?us-ascii?Q?KdXgJ34JXt/9VfQk2x+EXu0Y312lUN3ESwl8Tu7dKV7w/ZfnUwDfx6ndSFxD?=
 =?us-ascii?Q?6tkhA76BFzjQbjVSQaafXE9ZRKILx6A6l097zClnWiK2+yiGy7OEkG3Rz7A0?=
 =?us-ascii?Q?kTAbHoWIfgNpDQuLqkA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uLIYuBU28vlmj4PP5XMOfddf3CuYKXi8MKtsw9QrfuSSyBr1Z+q2g9L0CVol?=
 =?us-ascii?Q?WhZQ0BVvZX1X418fIHbw7K4PaIjP4KXb2dfPkhMzzniXRM84k0NLLIWxBh8U?=
 =?us-ascii?Q?pKxnNoblusQ2EobVU1+OBHwDDW0+TZSzUI5NNfhRP6PoIg+vfcoV12KfKQ9F?=
 =?us-ascii?Q?dRXzjErcz0JHpoyDkAyXHt6dDu2B7cJRSEULKM0CA3vYW6fcUHAHdHoRN3CZ?=
 =?us-ascii?Q?EuDbt3UpH+ois4WiMMpUfW9IIEC+aDfDVfIXnNjHTD+sOeN7o0Wr4XH99FfW?=
 =?us-ascii?Q?abuJ4Lhj041PcHcTreekI2/9ZrnC5oLELIJ5YVQGqu8da59WDtCGGtpPDoXT?=
 =?us-ascii?Q?vrXlmMu8KDnwYKxsCNYojqFJ0vNJtyY74GnHmkQKr2XhAUofg4p2K2KMaUqm?=
 =?us-ascii?Q?U9S6h8bggy3i2sqhLCuHZIu2s93SDRkWUDnCb0XCzipp2RfWK+4NzDxu26o4?=
 =?us-ascii?Q?ZNGLGGLLta1xeBtz3cFasNCvGjUr194HTwNEegcf5wnknQOVESSaje9Y2Z1s?=
 =?us-ascii?Q?I0rYqm1UN2gBE5MD2pq2MEa0eNitp2CReZT5MQ6m6dVeQ8xprJHsKrWQz7oS?=
 =?us-ascii?Q?4Z1QWek4WzUNmHd6d/I8Xy3cEqKjX86zw17tSaVhPn/zdwOWtgOzxI9Q68zi?=
 =?us-ascii?Q?5a+TCwr2IgNSmxkw5hjS/PXwAZ2VzKL6ceSBx65PT0LE4F9E/ATuxtSNUOYP?=
 =?us-ascii?Q?xBtCGxdYo/j3H9U8q01+WE5fNFmtkCoLuTZGgPbN4DvnSGwCV4ZdmqM0atc6?=
 =?us-ascii?Q?kEdw8HlJ/JfkwwSwAzK8B9nhRw3j7fqBgVIU3R4lgAum5ihKE4OFS3nuZyPP?=
 =?us-ascii?Q?9h8LlP+KH+yfzzM8xCgvKF6DaiNbEQk4e8NR42pyndRzHAgwmpxApLNHVgZV?=
 =?us-ascii?Q?yd1K6MRdL+0o7keDZu1oevLSnoPEmTKHNRghQ/r3C1ns2AzRp0WkZmmDtCC+?=
 =?us-ascii?Q?G4Tw1Luu2avp+4RKLuI740214q0hAz2A/JnSOVBqhCCulZj9wipOsntTXUc5?=
 =?us-ascii?Q?7W5Y3S4LOad84gTaQt4PtTi0S0DL4TXnPhXEjzKxiRDgO82mF9C5SOvxp8bW?=
 =?us-ascii?Q?B979ZhU3rIt9AS6BzXQHkwY+XgYxi2eSu0TCjsLH9IUproFjbqxxtPU47B+S?=
 =?us-ascii?Q?rgsZLW88BsBQ0Mm980fjkviKgIc7MLJX/20nYEbKWvqTjhFNdHfJF7uyos1p?=
 =?us-ascii?Q?xHR5We+yp984bTmGnkmQCe69+akw8Aa9BA2NdJ4TrPmakOTl4jq2TuFK1Slb?=
 =?us-ascii?Q?nxzh6seXwLj3etcFgWBz8QylT6rSShXgCjFlVvnhB8mFBBUYxOxNhUec0L42?=
 =?us-ascii?Q?vWPS27FoSIpaz3WeDQiMx5shdgR0WitAmJzkHAVMfdSE6i9EkjVm7Wuu27ZD?=
 =?us-ascii?Q?iEauI1efst1rZX7FnQzJvOwnV+aHqIZEGvO8r+oFBtWqD0Z+eJiOHb3K4xF8?=
 =?us-ascii?Q?8sDVfVMs14Qr9FuqHtJl1fKDM3M+C6F/MA/pegHejPxeU/if/8Ae7IqNbY+q?=
 =?us-ascii?Q?sAb0BkAzJ1Vn+zZsX4dZdQzZWQVy+Yvoavjl7bOvMY/BmEn9uOW/EkE1qqQg?=
 =?us-ascii?Q?a1ynxPYNVSBGdr5cQGUtjC0MxKsYtzCrAdIZ5kwQs+Mdbnpo/VkGNYZhIq4d?=
 =?us-ascii?Q?qaLB0eriqpNmX2/XF1H7bYbrijEXYdR/54RsatYKug1B4DgZEsw0GX28ialk?=
 =?us-ascii?Q?GKqlSdtinaCVZI0Wibn1vff7XWN3tdhGbfDxV2SUWfYqz6V+zgCmW5/kKvws?=
 =?us-ascii?Q?xpHc08oMVJk2cdA9TWHUU3hG76IwI/I=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 969fc978-0309-4406-03c4-08de5d814bcf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:51:43.9404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9uL3GMlG7zwXHR5VG3tcr+kB0/W+FpUBVnDnmWhMOrOCn7HeuQDXr52EenNEILg0zBzobRdnZP5ahGmE3uD/hh5Afz3Ah5jJI9xzikGWOhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9448
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

On Mon, Jan 26, 2026 at 03:22:13PM -0800, Stephen Hemminger wrote:
> The unix domain socket path is limited, check for overflow.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

>  lib/telemetry/telemetry_legacy.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/telemetry/telemetry_legacy.c b/lib/telemetry/telemetry_legacy.c
> index 89ec750c09..1d73282ba8 100644
> --- a/lib/telemetry/telemetry_legacy.c
> +++ b/lib/telemetry/telemetry_legacy.c
> @@ -102,14 +102,17 @@ register_client(const char *cmd __rte_unused, const char *params,
>  		return -1;
>  	}
>  	*strchr(data, '\"') = 0;
> +	addrs.sun_family = AF_UNIX;
> +	if (strlcpy(addrs.sun_path, data, sizeof(addrs.sun_path)) >= sizeof(addrs.sun_path)) {
> +		fprintf(stderr, "Client path too long\n");
> +		return -1;
> +	}
>  
>  	fd = socket(AF_UNIX, SOCK_SEQPACKET, 0);
>  	if (fd < 0) {
>  		perror("Failed to open socket");
>  		return -1;
>  	}
> -	addrs.sun_family = AF_UNIX;
> -	strlcpy(addrs.sun_path, data, sizeof(addrs.sun_path));
>  
>  	if (connect(fd, (struct sockaddr *)&addrs, sizeof(addrs)) == -1) {
>  		perror("\nClient connection error\n");
> -- 
> 2.51.0
> 
