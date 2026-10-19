Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2443CCF2D6
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:24:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8AF340430;
	Mon, 19 Oct 2026 15:24:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9B2D440297;
 Mon, 19 Oct 2026 15:24:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792416287; x=1823952287;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RX7P8deN3vbbbmJowRdQRbn/JRVV17Ci+AnyWiRU0y0=;
 b=Bxn2WLPjKHl/mNOm1V08g/ioXYEPFASmeuYf6hjBP0RTyT9bJJfkEJVa
 yRMeXY0RX1K+knUTraqayj9m/wFLjU9HqBXGoLyQYwQwOyQLdswe0NP+Y
 ZuO9g03Hz5CwCv7nnW4HpD5Q76uwpiqno3f3BFFaGF35eU6vFOz+vU1ON
 PSXC3yODAqusUqAg9E+g36932jPf5DJA75FiosGL8Yfn9C8lTn7dwpzmJ
 LNKHVkyvi1rtXi7TBajNbfyVbpC+S54k3vqhDSe1uC89EmtubU8EMMCiE
 K4SGzyxYIOecPO0tHRG7rDdJQdhT2Dq2wWCCNmMaPOjzcITX7aIWbT/b3 Q==;
X-CSE-ConnectionGUID: OfON0TmeSGma30zlbxWDcQ==
X-CSE-MsgGUID: hT5wQ8kwTMeyW/Rv0IYR/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="997117"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="997117"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 06:24:45 -0700
X-CSE-ConnectionGUID: jWyZKZ1bQTmfB++lK8JrwQ==
X-CSE-MsgGUID: 0KTg7QgkTPyHrjmDQcZN+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4369009"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 06:24:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 06:24:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 06:24:44 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 06:24:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfxrVJrFsvqNOAKj2yJzDgMzj2Bg+7GVII6FlNg8+CyZUi7uLF51oyhI/HtKt1zXmQ6cfO2fFw9MygZnG8UWVkWbAAZd/H2XGOpXd5RzoSZfogD/UmqtljuKSgjsOFuF16xFZrvfEiBZXoZJM/hFlMde2nXGxltYZo6QjGJT1/zzFGVVbohLwE+wn9hnjzWiziKBoCbAp1rrNDX87PtJBaY/rCX0IL6XYU5PSNQl1BR9TeObr04SE9VoUmCcMo+NKKFbNz31qFIKsqYUN3K2zJ3ZYt/LpZcChtYQc64Ye/yCQ9XIwHuxMdFQUIw1gHqetFI70uQsG92OwMptt4P9qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hAXb3ZalEVTyu6sM0qvEqyJsJal7d5czZ1QsbvIOL0=;
 b=dNjmCkujk2jmoCwTgvnw9HtCIefK3hOwaeWKZGqj6W4FRLzghV/aybaQS4v6SbaZS8WRk6FuVjNulqqdiZ2WShoTxvkfMmWQfOFQb0fh2qIEXGbqS3WuNeMF3O/SeMoBjEEmuR92tsErU8iQZKPC2NlHsIQAu8e2Ys0/EiZ03mmwlTI2cZ7AvuRjA/tvidKMGWOwxPyfCA5XuPc2xXZYRSuVFlUJ3VTOkM6nRoIOG/U4UFp0YgmHi3Q5mQ4QF+x+S2n3DExap5NUryu6+u64T7p1Jl9jYq5+7wsQI2OTcs+RSBZPLgruvZOy/1pKmKVQrIU4UTreSZhyGWBh2EslGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS0PR11MB7734.namprd11.prod.outlook.com (2603:10b6:8:df::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.19; Mon, 19 Oct 2026 13:24:41 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 13:24:41 +0000
Date: Mon, 19 Oct 2026 14:24:36 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
CC: <dev@dpdk.org>, <david.marchand@redhat.com>, <anatoly.burakov@intel.com>, 
 <soumyadeep.hore@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2] net/ice: fix max number of descriptors for E830
Message-ID: <atYaFA6l8NqCjIqf@bricha3-mobl1.ger.corp.intel.com>
References: <20261008111928.43095-1-sandeep.penigalapati@intel.com>
 <20261012161226.130164-1-sandeep.penigalapati@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261012161226.130164-1-sandeep.penigalapati@intel.com>
X-ClientProxiedBy: DUZPR01CA0345.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::28) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS0PR11MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 991ca289-af54-497a-9c61-08df2de45508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|18002099003|10067099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: AZ1DyR/v8tDfCJq9SiPENoA9LOMlNDkqxuYPq6EI4x+JsYTR+Fhf1N+5Q6N8+W6Bu2MEGwvkfIAB7wkUmOEXdUicfL+bbzf3AaTs2wmRNnolGFufF+bd2r7ExdhJTIKeP9kYYN0r1yjpzQmAzDDESfAAN2bqS5fBtI1vXFAWvnOzONcKALSV31C+QKPtoOlHhtt80vbARhVH2CFOtyDa4vFROMZAClCpV39ldwYVZq9hkY+xhdUeRXLzXUPssiDs52xaL/drhVNAEiVsg/VuK669DEo84vTF/r5qTOa4UET6UnJEnPR5Rt/3AthluN+WPT3TQgyZ/TwHOivkYDaJnZZKFhVhQBf04sG1axYzFA59OA5byahknJIXKUbPaItEEZXS9HuF1UPWhbJ8pCfAgM+CDXUmj7R70IOv2UAd8YgIaToEvdJz7xta7kYEgZURaRuKMHK/pmlAs7LKGJCZB2wRclSKU+nGmfN0dhLCnef5vKRerEZXAG3+V99zIL2fQXucUCzJRRyui2aMYz4aQTquND8RKDrVuG0G5G5qkfShf1YHa8oxQlvkQ+e1wZ4p4adlEvJ3si9UgeLdeoXgcMWR9OU4QyHKn1bjC9LxCY/hJQe8J4gMWM+QJsG/9JPEO1x4jkUjMnksvBgcAyjRCh8sUiU9DhdN/7zFoErXjFw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(10067099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gSr/94HTFtv32QG9RLDhD/h6dHJwssN+6PY5KGkJLjpodX19QVZC9qLDXdUo?=
 =?us-ascii?Q?fZEqluCiXh+2Gv9+IXv7dULaUX9aqKFJKdcjRgEisXvjzb1FM37KoVOylukt?=
 =?us-ascii?Q?xXuDQika4Wu3x44TGFG39VCkE0rcTwtZmTONxiu67zYRYHZzyou5HqXemFDU?=
 =?us-ascii?Q?PeyHYVR3QVzYDJn/JKKnyeb4TpGWm07hWtVV2I/oauIWk8hLu5ErvuHTQUfR?=
 =?us-ascii?Q?2YISmhvWboEikh/Y6rKSmh5v/FNSFa37wdfGqzEYEVj/cMTaMTvawGlgyu+T?=
 =?us-ascii?Q?QukS92+3IJksLdMrqIZUv8FI40JufK/iUm8DIsfYofySsGigvj2/5QcEUvZC?=
 =?us-ascii?Q?qwrz+vNPs05vxO409U5aYu0bWLxqWtYXU4Wc7DzKjOtSlxu7CTmoRSfqwhHi?=
 =?us-ascii?Q?/Bulfhvk3JUNoxvWIi/HP6KsggpdYEabYlIckl6sD8ybbc0oc0dLprxTfGyH?=
 =?us-ascii?Q?Up2g2P6v05UM0WkYMNoKCxzV9wcAkKkgwps39e199AeqOSZwlHcE3txtiJXE?=
 =?us-ascii?Q?eqPnDqO1vzjOmyUnYgnC9Q8r/kokbSJNYC/Yp8gAYWl/SEPIYRC2Mr7rIDND?=
 =?us-ascii?Q?lRK58RJtiAxJWcXzhfkkEpGnPiZBsGj/AVQm+Gu26I120bF4Z18TLev2BzOj?=
 =?us-ascii?Q?9Bh2+x2DOYu01D6Z6YuB4qrzUm/6eaid7WdD+e8j6atwcJUU9QpMiF+aVC7y?=
 =?us-ascii?Q?IxEcWUOQNjl7oT5sHyHayfXOVEt9y8NrlN0p7DboyqQi8qa4HgJp0Kycx/vd?=
 =?us-ascii?Q?Q4z0gXg4tbfsvAot85pucnYBw4pbAzZR+RF10AGtTkQw4hqZnH20KWbmKo9Y?=
 =?us-ascii?Q?BeSKcaQbu6AEFphf7KRVyI870vr3XKlVmOM5czCk9l4h33aodrGeA5dxB1KG?=
 =?us-ascii?Q?3NbJQm4bZfWY9p2xnbdZChoF/gTKIYa0Wmq4aT1VgCchJUHZeNC19ZZAZNuf?=
 =?us-ascii?Q?P/7hjOWawFeqcOP7SyDfvcR60wpft+03FvUsZtsswTOF+EqT1sJ2Avvcu3Eh?=
 =?us-ascii?Q?IY8XDvSpHBEwqDhM6Zk3pKzJuNVQVJVxxfYR0j5O1sTFi4liLRfgy/wUb2Fa?=
 =?us-ascii?Q?7ptZ2hVZvhoBp2kEFWrdMBZTYvzozTPKk9QuSyz2s2+QzTXO2+AGfJMBWjgY?=
 =?us-ascii?Q?zBwABNSezWlkLDPpE51/jMNoC7cpYSxTby/VWpC6cX34T0kzDYE5TpARqjE8?=
 =?us-ascii?Q?e6G18UKLVeFVhRzKf3u3SqFdpr553hohev0kqYNf9CrLRkqVSGXZLFGHTxyW?=
 =?us-ascii?Q?D4hxugAEhB9EbGZpxgNLe12bMPuaW7gfM51fjE+e6zrdVXUSyD1YbBwNkGfi?=
 =?us-ascii?Q?TNqWmnKVgXEPe34lNgOFOlA1c/T6kX9jKSet6YyItXhjFuiQpRiFg4/Izp14?=
 =?us-ascii?Q?jdQSCEXRAz6UBIg/sqwS2WVT1FEStCEwpOkp1PMu6gqg4uFyo+WnBJ5cK9VU?=
 =?us-ascii?Q?Pn+S3Regoklm26fqHKJobJyozElWbUSWmf3MYu7yo0AL8RW6bCy+Vz0/7rwr?=
 =?us-ascii?Q?+Jed/tXHyIF4b7YtRSEx69DH2quw/7tMToJNHLHjUD2WecVn/bAKypC+ObW/?=
 =?us-ascii?Q?CPXpv8nq37IOq7mQJtHVwDI37j1cL7zpQ0RKodSa9Ihc1+Go8DHAanzclQEj?=
 =?us-ascii?Q?K9BH5VMeWRn7XhxaoE7GulU55wwyiY3G74l2U0/5as52P1dNdKApJSgTeytK?=
 =?us-ascii?Q?Bh4OYQpJN0wAtVSzEoGKXnAt6SVbqeMX0NGBhkuNufkDZQg5NvpDW1GUFxyE?=
 =?us-ascii?Q?7/3bncJlsH+qYlAT+KVCRn3OAGOE39g=3D?=
X-Exchange-RoutingPolicyChecked: iEOteLMUqKlkX8lsND3uVINc/F8sydkcHmdkwHPD02Kb53K+BVP99QSMyu4nT9lPZL4a3XMSaKocMrCU26qX5Y/w/rZMwtLATPspkNRHHxP1cZOnztpq/PCDrRxMs2zjpknWZWKckRnky/Tu8qAZyWWOBHTif3ym2KkYqfyP+6wLV3l76/cKSMHY7ecgwwP56RJgQ+VXsgDDBIuM1VrguXvneAeBnjL2g2wMX1n3XG9pkF3FU5uxdkJ+LAZwrJ7HTFGq9/Uq2AqtlwgNZb2YKZk+POw9geYFuHvpnauwkHxL4N4dgT0h8Rqq77gExe/5t99A4US7YRaYSFDxPRETqw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 991ca289-af54-497a-9c61-08df2de45508
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 13:24:41.5420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLRW2KfvrPGTwFNmjzlHGPUJOy3zuX8HFJxQ1lqphZ7uU1tnjDaNmtUoN+HxzTHZWbZn933tiM+PhlIk91JxJ4+I1QEv8XsihOttKr0Dx04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7734
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

On Mon, Oct 12, 2026 at 04:12:26PM +0000, Sandeep Penigalapati wrote:
> E830 supports at most 8096 descriptors per ring, but the advertised
> descriptor limits and the Rx/Tx queue setup checks used the generic
> maximum of 8160. Only the ring allocation honoured the E830 limit.
> 
> An application could therefore request up to 8160 descriptors on E830.
> With Tx packet pacing enabled, the Tx time queue length (Tx descriptors
> plus a fetch margin) overflows the 13-bit queue length field, wraps to
> zero and triggers a Malicious Driver Detection event.
> 
> Use ICE_MAX_NUM_DESC_BY_MAC() for the advertised limits and the queue
> setup checks so they match the ring allocation.
> 
> Fixes: 0b6ff09a1f19 ("net/intel: support Tx packet pacing for E830")
> Cc: stable@dpdk.org
> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> ---
> v2:
>   - No functional change. Added a short comment on the descriptor-limit
>     defines pointing ring-facing limits at ICE_MAX_NUM_DESC_BY_MAC(),
>     per review feedback.
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
