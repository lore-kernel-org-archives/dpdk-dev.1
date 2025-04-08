Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AC5C369A4
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 16:22:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC46B40267;
	Tue,  8 Apr 2025 18:22:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 79B4540264
 for <dev@dpdk.org>; Tue,  8 Apr 2025 18:22:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744129327; x=1775665327;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=CZj/N0L5qIlH/rSCsMjimPfWn3Hh3TDgLvJ362s7HxQ=;
 b=B9uMH2m/FCcrz2OwzlOMz37wTKsfwISNCyftNcCYn2181y79eDfnkTfn
 lXYTQfyzR1UJW4F3IccN/mGpO+IQnBepj/Fvpu8Q+9ooP057B/R6xrqNH
 qUQgBkiT+r9i4nvtUQSFYyjYTZ31SoRgutULkwqVm4vjTiBomCtK++uO8
 +jkdFa/ArPJWe4doxfblNrHBHfdrLe2br9UqyXluJYuqf7QQQHWkTFG8p
 4m8YLtjqFBUym1P2GXBnMrIC7J2fuvqUaDgqifhVRv6AIfRdAyqX0/s0d
 Kr6SFrFBfebGDp4qLJr+mxlD/vrl/frLyo8aFQ8BJ0mR7TFUag7rpxAlo Q==;
X-CSE-ConnectionGUID: KU9lOse2REus/2LdbDpiHQ==
X-CSE-MsgGUID: 5Hj9GnNwS6WWuatPGUhr7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="44823616"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="44823616"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 09:22:05 -0700
X-CSE-ConnectionGUID: u2/ZGgirS4yhC3psr4L10w==
X-CSE-MsgGUID: RNiH1wi4T7aPI+QOZswlpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="133175362"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Apr 2025 09:22:06 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Apr 2025 09:22:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 8 Apr 2025 09:22:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 09:22:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTaUmfvEx3VfprJwJfechR8l/917n717836ubOZ8MbTP7ZXiwN7AmPmmQD1E+OHzMgK7GHH8ctyO6In5sY1o08wl43B2q/tKG/5npe5BnE9i07FjpBzgYFIFZ3k9XrBKt2ywDEUEWOy5WRM9ovTQP/OL1Gm9Dn51lOsMlRoRySJISYu3KGhMZk4N0P9QYw9GHuQ3mnEu8TlsjBluYVthDhhWVykWCLdX5i48wKQM+/CJkeAmMz7nw4XGSkhTWNumspZ3J25kVUMrGZFDYEh9CRZmJIw8CG4xlhwCF7CSpCSFKR6axB8mOTzZ6INOiavEnrQm1S+LqzPOXi7u2Raugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ah7soYI+wx7Gu1/Hs/GLJIjS2nNhfVT16v3YEWxYXeU=;
 b=kIfvWVAawPzgQXkH6oze0gomUgonvUE4t6ym2xcUwj2vexM1nOZKJSsR32N8r+E5vKV0nkOsnRXmTnUe1cnYraoEDxgFMNbwlVQRqzS9gNnbu64MB8mF4s+GfeMH/8LgrPhejHcddP5wdrcbPZZW2Ywz11gj7NOoqFk+xbzc/OovzTLd6uBHSq8kAqguVzDzkbZ0xM2/6jQIJ7Rl+GxcwY/+NIar+TDf2bpTMNLiodAsA4ipC24pAWbOyrSYDifMm70X2dxnh0+q+S3wHvKFbjNw+eYdS7xck6KkMxINyuzrD7w5IgXFFBnodm7Z9poIwkeWbHIuMj3FF3VFwk8omA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BN9PR11MB5290.namprd11.prod.outlook.com (2603:10b6:408:137::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 16:22:01 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8632.017; Tue, 8 Apr 2025
 16:22:01 +0000
Date: Tue, 8 Apr 2025 17:21:56 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v6 1/4] net/intel: align Tx queue struct field names
Message-ID: <Z_VNJF5kDFVbYAjs@bricha3-mobl1.ger.corp.intel.com>
References: <20250312155351.409879-1-shaiq.wani@intel.com>
 <20250403112429.2741138-1-shaiq.wani@intel.com>
 <20250403112429.2741138-2-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250403112429.2741138-2-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZPR01CA0221.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BN9PR11MB5290:EE_
X-MS-Office365-Filtering-Correlation-Id: b975635c-b22a-405a-59f8-08dd76b97df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M8S9HnbgWHRF5+yAb4k42uUwHqygoqRzXu+ONQ3L9+d5igO6Hh0TgFUqDO8i?=
 =?us-ascii?Q?OewJNfCGuufFrthIZTbgpwlW9qAmSxrA8I/Fxs1ptXyM2xKcdqMSxWCaAxJv?=
 =?us-ascii?Q?f1K3lmwJJukp0PJ1r/6LYkTA98v9jz7IKqR1LPcN0YDbWbaUmlkH6HBZoS4v?=
 =?us-ascii?Q?yLV+MpO7Vw8zcZQlV5X5IEmAd+Mq0Ac+sqy2jmPNDkIILvP893U71q5j5P4n?=
 =?us-ascii?Q?uz8gHjLfC4309xNppPf+x1Hml4mNcUNyqFPj33e0JH6p/h99WTilLorDfdaB?=
 =?us-ascii?Q?sy0mwGJa6uY0RLXEYMtocShsB0l+I2GhYePyiCA4IDWSF9N8W52bircB3UmY?=
 =?us-ascii?Q?ssqYdZGDe++xxtINZ30T+gheOcqnPGYGjfiW9Q91k8gtvC0t98+Y82SCvdcI?=
 =?us-ascii?Q?3mO2YS5/zekUEJPQQtUFbyeL8fYa3cIabhTUMatmCOwZd6QVUW09eLVgXGNL?=
 =?us-ascii?Q?9aeL9LgiV1MVfGuyfC4VvhalywXYpwDlWFm3R3LZ/80mqMci6O3Uz9c2+XT9?=
 =?us-ascii?Q?+pR7wlDSIusjoiRymPW7q3pkHKOe1rpV89hPFdLKTw0br57kbbg2nR1egXDW?=
 =?us-ascii?Q?dY55pFBfelfPDTWiFTZ6FgUsLC693AQB8m3pciH2sOYtHziNLbsQAA9nIsEp?=
 =?us-ascii?Q?fpPmAuMfcZbVEzVImJQNblTDywqkhrUFOetHnD5DE8TbzDaqcU2ZfQ+2oske?=
 =?us-ascii?Q?0d0msecsoy8YJ8+qkQJHphC1+Spnmdc8WGBA/wPQm6AdzlzgReIfK3wLapn+?=
 =?us-ascii?Q?2FNDxXd+zB5wXqqCF55S9dvMAggCSeRDhvO+kI9Pjq0BXbyqdoVgKrggLkrq?=
 =?us-ascii?Q?KvV6Y2xF28wu2R09DilhHZMuMaQ5cBCmmErQGoHhCqfq0WqoWzIN9PVBUQ3a?=
 =?us-ascii?Q?ihudaxclLG48FlOTlky9A5//ve4CtAZzLQ1M1CoAtAfNyhaIHBcV4JX7Kl+o?=
 =?us-ascii?Q?Nhfmbjqb4wTN/iadugGefQ2iv2OGPbH9AQ25Y1Xe6WDYhQfTzYOMldgkqUGc?=
 =?us-ascii?Q?2wDglhLSI0ujhUrybnI56eW84f9VZjuVtgWOtCQgspgcGsCCaZwJRb7lr3jZ?=
 =?us-ascii?Q?5Bzv6oaJJEbXcFd7csVoKgpzmAn2VWIUnMMi/rE/KZjc4AWmeoLKqUiYinUX?=
 =?us-ascii?Q?6Ep0ev4fYVYlW/Ah17Gufu4oE6H73ecMenq1hS54DMokiZheK4tij1Z7zUWE?=
 =?us-ascii?Q?XxRuIHs3SMmTIVHEVrHryAKH9mJowXniN+ChogN5DjtPKR5uZiePZjCBr9HZ?=
 =?us-ascii?Q?jCJiDO8VkXTeQvkTQft4FAKzoRkuAoHfbgyLYHM9zyfIR4VaurP3EMh0FY87?=
 =?us-ascii?Q?Atp4i+HTNAJ9A9QWQdsJ78YYG3gFa+6l+N/tt0CdF7D/SxTz1pT+sA5MVE8y?=
 =?us-ascii?Q?axTp47CoZXbFDg84LYSTmVRqPxZs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S5aLR09zK0iSAaHUiif6ne6ruf/F/5e9XTn3iLjIq3g8RLwnvNspTup3nk7d?=
 =?us-ascii?Q?VddrVdl7JtEAAET0HVrnOu0RcKS2yxhH5kYC/EpTUTJdr9tlRAyz7O+ePHcg?=
 =?us-ascii?Q?8NxaT0qtuXY+ePG+tRwOLMRQ+neK3l36yNP4nA8EKt1dOOXVfaZgsOJy3/x+?=
 =?us-ascii?Q?fhpbyDVr3jwleI8s2B+oT6hsxR5d23lp/dEn4O+KnoqnSHA9HUH5rEB3xQtx?=
 =?us-ascii?Q?fWtISWtRQhOJkmWE57/l6aGecwhiYkY2NDijVEF/phSytwajib21s66ogyhH?=
 =?us-ascii?Q?JE2TPPjSf0S8QcXWM/X6mHz0jhLWJkfb2y2w+SBpeYHXvkUMae8GohasCPZq?=
 =?us-ascii?Q?P589vZvQSSXsKyUK3QbKRF/IGv5/IlRDuMIo2oi0zuRwKmfS//OpK5BrWhDe?=
 =?us-ascii?Q?/HMkKIfRPw9UB7Vbw1lkdzpIMoQQc0Y4uIOixAHY9LUB2mEMRWAGy/3ki37+?=
 =?us-ascii?Q?u1IXLq+B/FQamNGR7qAiM1pQsbVHcjELXrj+aP2E2npEVt0ccIDZW3FQuhXl?=
 =?us-ascii?Q?lUImuHFqgckfwAKC06u3iPZss9DaQrdKAnAX2dF7nH6dyZQDiUHiL+WwxXzW?=
 =?us-ascii?Q?PnWcS0y72hOWmuvhQahzdNBq9qD4mscFzoC8TlVJB9l1fxK+/90LEIUh0k/l?=
 =?us-ascii?Q?14OpOjZpk/HDz5nsfZzEgrNRxlCwxNoTWGZp4x8Gvix4Zv3pEj46weyHH4i8?=
 =?us-ascii?Q?wpxugYSdv/1DlvRPts71dkd0gMA4W5l2a6FURBpNnIqNRsNYofOk7A70g3k0?=
 =?us-ascii?Q?/6PmXzS0YPtjnWFh7lR1gDsf4WNlMXLkfyh1kM4fbXRwGHtPZIrcqDBqTCnG?=
 =?us-ascii?Q?Di+fbgNlgM8o/hPlwvi3MVQkI5He646wj2pkSHJDGD3M6XSYg+04/lciV0XA?=
 =?us-ascii?Q?MovfUoyoyrmo7r8PAuZooXPRVDASzOxbWJO893TvqPoqman4oQfEnikyTfKn?=
 =?us-ascii?Q?/Y/TRUQhAhp3/RdCKr9MM2ZstJOobUR1MtUqxR7FStLGNReies2u4UucpEFU?=
 =?us-ascii?Q?Qqn6ICfiOVhLrhkF6ZeyMFLRV6Dz71g8zcszcxHILsCCIVg+UFwTZ7mN3Z2u?=
 =?us-ascii?Q?87G+6JMQLVruyUjicFxXW3bzUKXc3dP8Ny3CTJSojvImae74fzzGcRZEhsal?=
 =?us-ascii?Q?5PM+pbPAJjBPm5C4TzZ3ijsVMzRqMX9Z7Cz8ZzetdcXMc9vKtiZiFdXElidi?=
 =?us-ascii?Q?NXH8ZEbmTS4WsYkV5HNlb89srHNUiiKqVL6gqHcbWgDC3FegXugYfUxTOxc9?=
 =?us-ascii?Q?hW9s2/E96FxHvmV7SmMVSRegml6gAjWQEoUbKixWQgrFYe4HeuSFaYtAWvCE?=
 =?us-ascii?Q?ReKKeNO0vTPTPjKc/vm9Gbmg3arKlkdEQtLoOS6Rht1BgE23PGqpkBfieVjU?=
 =?us-ascii?Q?rNVvKp4YVc+TXkS2mIDeMI/lZDuPD2ZuFvPYRqcI5seXBv4KXdkAX6XB4vgH?=
 =?us-ascii?Q?n9ejRAcEZ9chbu0xSATd7lJyLIsNuSq0i2LkTmDttXXtPJPCr5pMApfVhaJl?=
 =?us-ascii?Q?IbTkaYYjkPrh/sWiB7FRcwbTl6W09rtkxFdXdOZJFcZtLYYVbvWBDvaf1oif?=
 =?us-ascii?Q?yfxWLPfrIUXMI8f3pmhSqESvYljaMwX7oz/XLyehumlcrTef1yWBB4aa5uJ7?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b975635c-b22a-405a-59f8-08dd76b97df3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 16:22:01.2966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5EkAyFve+4Aca1Ms0uC4uZ6Hxq5r0xtLI/XRvvDvJowyI96te1yBGf06N2ce5njDlDSgW0GPG0a9tVcDamZ5peOlKzOnO8oBWWlCAgnv2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5290
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

On Thu, Apr 03, 2025 at 04:54:26PM +0530, Shaiq Wani wrote:
> Align the Tx queue struct field names in idpf and
> cpfl driver with the common Tx queue struct.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

