Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AB9C982E6
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 15:15:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4FFD40E50;
	Mon, 21 Sep 2026 17:15:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by mails.dpdk.org (Postfix) with ESMTP id 1C1B2402B0
 for <dev@dpdk.org>; Mon, 21 Sep 2026 17:15:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790003743; x=1821539743;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dX0ULp7DZuMJ8XIV1r7TpRQT10s/ASxxpS6IS4EfS5M=;
 b=H+DP1kA7sC+wezCpvQrO4VGoNMGzpEjMKh5Wdkd7Vh3hV9gA1eCeYVBi
 23/TTWZOp2O61aEuVvNrLR5ZQWRkuvxE5r366iAd0S+xcGn6R8djmAs8R
 +CFJD+0PII1wcP4s4NXySbCO1BJJSEAoqBsMTTSmK6hGRTWX3K6VEhK0O
 DflOoEG4anL4juKeoZ+yN1KDrI3dcOllSw/c+8g9un1G93CmKl8wcUoop
 rUU+d2p0dxl59ccrCkQnJSSCHd0UV7qb64c/JUxxwpvulg3U2VC4xZ5lC
 wm9EGfjB0AZhlUn/ShLqWtp5zy0o9eKCqK/AgSHwFazojLcqOoPeCKwEx Q==;
X-CSE-ConnectionGUID: uu3p2jdvSbe+/uLsDsnjWQ==
X-CSE-MsgGUID: XOGdCbyUSy+Vi1xjTUfQgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1031554"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="1031554"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 08:01:04 -0700
X-CSE-ConnectionGUID: Yk7MvvORTRCCcUIHqkSnMQ==
X-CSE-MsgGUID: zrc1xvGQRNy/Z1sm9IoFKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3737279"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 08:01:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 08:01:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 08:01:03 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.43)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 08:01:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvoj8lbIzh7mHo+E1WQkyrIav/50JNf79RkbdUYq6olxTbWQe5zSMIWckUqQ30+jIZcF31GE7w67KSor+/e6N2cPX24ZujK4MBb1niDSbLkRoHto0Jm4VzRSMEa6Towh3exMNif8oPCRrTH6ukJpT3Ut0OuqLkE0iuoMg12EhHUpZks13YWKAp0HS5WNiWOnCHNXK+QRV7sIMqASBMTbhwICcbOx4Opty2iaYkqJT9PSCIQPjyVIiVKrecMg/baR691uyl/1CAC1G/XNjGtl6oV8tof8R2/qYyE+PGUyPX87d+890yTqDh8/Os622Zcc6QqdNSD81mCcQ0NoB0+cXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYTYHxMFYTMuzysJ6PhY8Qu2ptb4KPDv2ZjpzIm0YZI=;
 b=kR/z0sUaO/sKJf6nmQkKFPwqiMtcrdlZKt3L3TlEmjDw4snyLPQd+3TWM+VPMuziw3ntIKLVJjZF4Nbb7gyOdAOPMi6eipigo1Qaxk0Tw60Ourqu4EgwR71Hd8QeqCf8oWhXEC2eKxj0KSRKtQhxIa6wZ+rzS3AitvqzR/P2TOMIQhVrc+dx6klgIvjo1tRzz0b0iwUU2xORKiVzyj4dUBl5z+Vls2enBe9YfF2eBQG4E4ES5bCgJb84mrOBSkC4MVhOj+nuMxnTlyv1oUNp/AAg9ItxYXtM5PgWUxmKR9ulUo1N28tghbADICxUXCyX3PcwrCtOkn4Xd9Gb0mWoCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7563.namprd11.prod.outlook.com (2603:10b6:510:286::11)
 by DS0PR11MB8206.namprd11.prod.outlook.com (2603:10b6:8:166::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 15:00:59 +0000
Received: from PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954]) by PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954%4]) with mapi id 15.21.0428.011; Mon, 21 Sep 2026
 15:00:59 +0000
Message-ID: <11be03b9-2f3c-4665-9a89-3fce0dabeb33@intel.com>
Date: Mon, 21 Sep 2026 20:30:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 0/5] ethdev: add Tx timestamp slot APIs
To: <dev@dpdk.org>
CC: <thomas@monjalon.net>, <bruce.richardson@intel.com>,
 <andrew.rybchenko@oktetlabs.ru>, <stephen@networkplumber.org>,
 <aman.deep.singh@intel.com>
References: <20260827122200.339388-2-rajesh3.kumar@intel.com>
 <20260908073206.1236372-1-rajesh3.kumar@intel.com>
Content-Language: en-US
From: "Kumar, Rajesh" <rajesh3.kumar@intel.com>
In-Reply-To: <20260908073206.1236372-1-rajesh3.kumar@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN5P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:262::8) To PH0PR11MB7563.namprd11.prod.outlook.com
 (2603:10b6:510:286::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7563:EE_|DS0PR11MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: ab9532bf-4aa8-46b9-c91b-08df17f1250c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|6133799003|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8VUBAQRcyZ735ybMvO1b7xfu35G9o735aqddpnE8H9SdeAP5e4LfB9/JCawAXKOQQpDw3vLaX3Uy+flfYLAPS85KqXxjYQE0uEFF04fiTLLy6nWl9GiXuknMv1s34AL2bjuaYtFis72vpvBp5n2hWpqayLxWhuZU2dGojMAEqR/9EYXAJ3x6f811c6cFAK12sSLKmLa8de+Gxvm1/x+i8ttjAEQdMCwwU/OcqJfnnONbj7CuXZ51eXOeswySRkL8JoBye8xIcH6aohX8hjg+dQgx/4NOnjo9Io1N2zTkpoB0EIBvvd+19Kc5kE4VLIWF01It0XwWb7n2C6U14Liz7ujbkqtIBpvHA9nBp3mLi7H95DuQ9zD5bKBw6uDenMZOiersB3NcDSJ/hU4ZJLgPbCTdJKCphESg9gYhq0G7G0z2kLLxDwyVBARTlvIq8UkrVYHGyrGmwwtvdPzJq4mxHG2Hw6fiKjhgX2H9HIJgjCUW6InBMIyNRfUh88Xy8C8hmBkVcbpoA5FWPoDz2YFsio5ZbPndhvvqeM5t9ZKr68V7x9+LQYy4o9bwrCmFsvRU5WTP5iwcsdwU40kgvjtCxVVFVvkJ91XR5iT8FNmmsUGGyi7yWVkcl98Ye2WhuCVWsBBCudc/Yi3UNZdQNcccvjBZOXjtslQaEq/pyM/g2NU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7563.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEw2dlNHb0RHUXJXZkhMS0dEOVhzQnE5RWg1dTMwTDZBZkhYVmVtS05hTXBQ?=
 =?utf-8?B?U2tHQmxYbk03S29vemhEa3pBZkFCOW9KaWw1QnFTNENZMzA3NGxwa0pBMFJm?=
 =?utf-8?B?dUwvcEpoTDFkNzI5YjN2NHlKOFV4S0VhMUhDbXIwUnVhZ0NTMEh1clRRTDBT?=
 =?utf-8?B?WGRwS1ZwNFBWRjlkTFR4TWZIUGtndm41UlRnWmpnUmp6Ly9VNnBhQ3E4eURy?=
 =?utf-8?B?UFlyTkhOR1ZsRm4xZVZ1OEhaQndNZEx1NVJ5dWtwL1RBYmpFQktHNFFaS1dt?=
 =?utf-8?B?NzEzc0F2WmFKekYxWU9FMTRxTkVWUlRlRjJWd01UanlBSmc2ODhYUzZONi9I?=
 =?utf-8?B?OUNYWXlQYUFhU2FGWVp3QS9GbDEydmltVDJwUjhvRGxZNVN3ZnRtNTEyTkd0?=
 =?utf-8?B?dktDb0JjV3V3eU51Z3BhL0IxZWpwQW9uVmp1SnBRUmRNWG94K0poTFBnSnNR?=
 =?utf-8?B?R0dHSjdyNXZJOWRCRVJwM3Yrazg2ejdJdEprMDkxMlk4eGRrYmpEaGQwQXRF?=
 =?utf-8?B?WWRiMlMyMnI0cWNPTXFBbGdtdjMrbU5RRTFXRytjWDcwbmp0OXBWVC93cnZ0?=
 =?utf-8?B?eTRsQnhHMWhSTUg0SWxldThoRUZNVGF1UVFPWU93RC9OdTc5d2RUdXBTcWJr?=
 =?utf-8?B?ZXZyQm9DNzMrajRocVJncFZKOWlmcG80eHA2U1ZnTWpnRFR3cm5yUnhmc0t3?=
 =?utf-8?B?eVBOVE1JOW1vRjhHaGJkdGtobnpnYnZrQnFDaXVVU3doSGZmVElwakdJaStq?=
 =?utf-8?B?YTFXUmNXbjZQZHJkYittcHBUaGU3OEoyckt6SXBwWVNrY3EvTmxYSW5GcU4v?=
 =?utf-8?B?R1pGbkJSUGh2YkNqaTYralhUYTEwcW13ZkZ6cU9vWi81THVTT3JyK2FHSGVy?=
 =?utf-8?B?bERMdTZHUm0zb0UrSG1OblFCM1RGeENPQ1QyNzJCbHovVUZuaU9WS0U5NXJ2?=
 =?utf-8?B?SmpWRlZQSDRzaFFjSDBmZFZ1eHY2TThvYVNqU0hvZVlQaUk1bDc0TjQ0THox?=
 =?utf-8?B?MUhhaVBNTVV3empPMis2dFRsZ2I2cnhhTUViTzZFQjFkNUtRa1cvZnlVdzg4?=
 =?utf-8?B?QlFKdy9QOWtKWGR6Zjdia1hEZ0dJWWpCTlVERlNKcE1SaU1naXRqV2dvQWFz?=
 =?utf-8?B?dVVpK0F6OXJucmM2TVV0VDVyWVlHK1VHa2JEbHpOYXdLNWlPNUs5ZG1VbHA2?=
 =?utf-8?B?N1pMRlpmdElDeVEyNVFVcUhSOWtPcTRpeitNS3ZxVGxKR2hVV1dwd2FVaG5F?=
 =?utf-8?B?c1FrSGlTY24zVWd2QkY0ZTIyeTJhdHhKK21UUTNZQzhubVo5SDFrZDUwNVVU?=
 =?utf-8?B?bGJUekpWM0lCU0RUT0pCajhXRHR2NHVyekZNRitLVGttb2hUYVlscmdFbGRL?=
 =?utf-8?B?bTNpbFpYVHp3RGVzVEYwN2xWTEdwYTFEMmFITisrbysrQXFBeWhRczMwaGcv?=
 =?utf-8?B?RkxPT1lhL0NUSzJNWlBtRFV5VlNFZHZEdDBYNFNJZFNOL2t3ZE5rc1FuRmxO?=
 =?utf-8?B?aHp6R0xzcVVIMWFwVHl6cUNhdlR2MHZSNTYzamluUWZxM2t0Q2RZcmh3WTlK?=
 =?utf-8?B?aXNNdW9sWXI4WGNnclJFRWtvcGlHcERXWXMxbEhmMDBzWXpvYkQ1Z2pSZjJw?=
 =?utf-8?B?dUU3Rlc5TkFpVDhrOTliUlVFellXcC8xNG9uZUlkUmQzNWRPSlhEdDUvTnNi?=
 =?utf-8?B?MXR2RVZNdUZlai9ublg3Zm4xVmlZTjNsbzQrNVBJVUhNRUd1M3pqeUtnZml1?=
 =?utf-8?B?QU1oN2NTRVEwZGRxLytvQTZJYk1KcDhCVnp1WGpOY1lHVGhyZzZ2OXk2a0V5?=
 =?utf-8?B?QS9GSzVYTzFQaytUaWl6K2s4UUlJSHhtcURESVF2YTdhSE84RU1uQ2wvTzBu?=
 =?utf-8?B?clo0WndBaWRhVUMrMEJaUmExQ3E0bGF2WnJFbkNOWlpwc2ZyOFduby9EV2tQ?=
 =?utf-8?B?UmlRbVAwSDJVc3U5RDhqK0t5c3Naa2Y2NTcvdUVwSEJuaDQvM1Nucmw2VGNO?=
 =?utf-8?B?dzExcExHY0o0TmNYMWdqdW8zSG1FSitDeDR4Y091YktBYTUxV0x6SW9jV1lM?=
 =?utf-8?B?NnB4Q0dDd2g1ZjJGaWo1MkFpUkI1c2VnY2ZZRFFJamhTNVlUK2ZueTY1REZy?=
 =?utf-8?B?UGdBdkdXeDVZbEF2YXNzM09DTXQ5SHJFZ2ZBYVpqQU05RUYrSjAxZDFDc01r?=
 =?utf-8?B?VWVWQnBCa3RJZVNLdHNSZ1R2SkFva1NqNFhkREJqT2FZcndmMkZnanhqRVFD?=
 =?utf-8?B?WXJVNkVHTHV4NlNRbWIrSXA4VFBDRC9OaVJhWlpJcjEvNDZFd0lIck4wVGta?=
 =?utf-8?B?d2x6eXMwY09udWl1MURDYkVKYk16cEhIU2NmNDRvQ09iQ0JUdldEaCt2cisz?=
 =?utf-8?Q?iN2ipi6oUZ4y0QjI=3D?=
X-Exchange-RoutingPolicyChecked: mRRG20olhx8oVSY07sVDoyIv8GQhAn/wJvHkweaj47dewbV//eZRcn7H4rfpp3ZEshPpqDYxMbmErJD93McC5UObiT6fhAolFt0aON6AoqOPVKTsHga3VVO/p+nVU4GO18Jghz0mFFkSTUQl/ZrtD14aKNq9LTLgcjgIH3Opecz8HTC8a2526a5tDfe7HuD71uT2bdvOc7bJmRzgvoLQelkrwomB322VDUkzvqF9IwYzvE+MSAVQfDuz8nxKIZ/YFq4kYZQgxpTtyJ7b2avrwU5WuK59+9THvrxffErBSnbRsw/ojzyG99wSfxj95GzdYh/DQss9YaUbUGvjNuNs0Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9532bf-4aa8-46b9-c91b-08df17f1250c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7563.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 15:00:58.9997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3BMys2HeuaqzzYTZAp86O9BBv3jLf7l0ZY8+GFzCxiothhCwZPEXIlVBekAcLGrAiaxhw3xEpwQsLiVAHekBYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8206
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

Hi all,

This is a gentle reminder to review RFC patch series v5 ("ethdev: add Tx 
timestamp slot APIs").

Regards,
Rajesh

On 08-09-2026 01:02 pm, Rajesh Kumar wrote:
> The ethdev timesync API currently exposes Tx timestamps through a shared
> hardware register. This requires applications to serialize timestamped
> packets and does not allow correlation when multiple packets are in
> flight.
>
> This RFC proposes an ethdev interface for hardware with independent Tx
> timestamp slots. The interface reports the supported timestamping
> mechanism, provides a port-global slot lifecycle, and lets applications
> poll each slot asynchronously after transmission.
>
> The proposal includes the following components:
>
> * Capability reporting for shared-register and per-packet timestamping.
> * Slot allocation, asynchronous timestamp retrieval, and slot release.
> * A dual-domain timestamp structure for adjusted PHC and raw hardware
>    time.
> * Mbuf dynamic field and dynflag support for passing slot handles to Tx,
>    with a helper that stamps a slot handle onto an mbuf.
> * Registration and process-local reset of the cached dynfield state.
> * An ice PMD implementation using the 64 per-port PHY timestamp slots.
> * A testpmd command to report the slot capabilities of a port.
> * Programming guide documentation, split into a patch describing the
>    pre-existing clock/Rx timesync API and a patch describing the new Tx
>    timestamp slot feature.
>
> The legacy rte_eth_timesync_read_tx_timestamp() API remains available on
> devices using a shared timestamp register.
>
> Changes since v4:
>
> * Fixed review comments and AI observation.
> * Consolidated the Tx timestamp slot API naming onto a single
>    rte_eth_timesync_tx_slot_{caps,alloc,read,release,stamp} prefix,
>    replacing the previous mix of tx_timestamp_slot_*, tx_ts_*, and
>    tx_slot_* spellings across the public API, PMD ops, and the ice
>    implementation.
> * Dropped the per-port cached slot-info array in favor of a single
>    process-local dynfield offset/dynflag pair.
> * Split the programming guide documentation out of the ethdev patch
>    into two dedicated patches: one documenting the pre-existing
>    clock/Rx timesync API, and one documenting the new Tx timestamp slot
>    feature, so review of the new functionality is not mixed with review
>    of already-existing behavior.
> * Fixed inconsistent TX/Tx casing in comments, log messages, and
>    documentation to consistently use "Tx".
>
> Comments and suggestions on the interface and the ice implementation are
> welcome.
>
> Rajesh Kumar (5):
>    ethdev: add Tx timestamp slot management APIs
>    doc: describe ethdev timesync clock and Rx timestamp API
>    doc: describe ethdev Tx timestamp slot API
>    net/ice: support per-packet Tx timestamp slots
>    app/testpmd: add Tx timestamp capabilities command
>
>   app/test-pmd/cmdline.c                    |  79 ++++++++
>   doc/guides/nics/features.rst              |  15 +-
>   doc/guides/prog_guide/ethdev/index.rst    |   1 +
>   doc/guides/prog_guide/ethdev/timesync.rst | 219 +++++++++++++++++++++
>   doc/guides/rel_notes/release_26_11.rst    |   7 +
>   drivers/net/intel/ice/ice_ethdev.c        | 211 ++++++++++++++++++++-
>   drivers/net/intel/ice/ice_ethdev.h        |   2 +
>   drivers/net/intel/ice/ice_rxtx.c          |   9 +-
>   lib/ethdev/ethdev_driver.h                |  28 +++
>   lib/ethdev/rte_ethdev.c                   | 151 ++++++++++++++-
>   lib/ethdev/rte_ethdev.h                   | 220 ++++++++++++++++++++++
>   11 files changed, 933 insertions(+), 9 deletions(-)
>   create mode 100644 doc/guides/prog_guide/ethdev/timesync.rst
>
