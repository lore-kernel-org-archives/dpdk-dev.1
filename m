Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE89E85367
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 13:13:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C043140296;
	Fri,  3 Apr 2026 15:13:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 03CA14028B
 for <dev@dpdk.org>; Fri,  3 Apr 2026 15:13:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775222030; x=1806758030;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=pyl+xjqDe3aWmZB1YimR7lO+QBhJI9xK6nH5yy6Nozo=;
 b=KbEyrh7sjqc8RBJ9DBVSButlrxbtYU8I0n3wns51wow7verr6sU5uaJL
 HkkBnRLPqAMovYifGsHx6tdtqkHbBOmTX8nIA72NTjlSulfnsW2n5bP8C
 Sr0RdXg1G+1lle0lE/Hl603kSKtifbQJlSrQrNZzMP9AFpsKM4cXCXmlo
 X5QP/nWASZJPF0vN8UsbHqar6N3JXHQjFb864nIAp6GEkWhHEz3VwdGlX
 pCNrfmcBJEU1g7TqAYSfuXk/e7m+BgFIMuhn4FGN+dTbz+3KQWC9uybpI
 ZtLg25V3uCRkAQI/E6q3Ek72S5BO13/o/+hAFXvYV+Zk9lszGPaB5ULL0 g==;
X-CSE-ConnectionGUID: Ix1wrcfzRtmx7PLtY2ix0w==
X-CSE-MsgGUID: zoT87/sYSZaDCxtOrArBRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="86584145"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="86584145"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 06:13:48 -0700
X-CSE-ConnectionGUID: HltwVXv+Ryq+ZHW3SSsJnQ==
X-CSE-MsgGUID: LGZsTQ3lTgWVt1L9yC0yYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="232059787"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 06:13:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 06:13:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 06:13:48 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 06:13:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivmfXwkglTAjMMi3wChMdS7avKJfzGQbJzlAnKwg3/iCmwedqrnQm6AkTKutS8KkeJjraKiV4JBJNt0UAZ0aae0Q6l2b/Gu6dEDkGSa7moDc/cKiDg5NRFIyLp4Bhsa06s7iIzHYxjmPSvtkZGBz3pxe3YUPHhLumMaB58196SYl9K182DcFr9hq7nFjxJkCsDBWaqOj9XeIUQ8tbzZQNIrRO6o/MBqp/uI2PVWz0C0tr39MoHWuZrUW/fon1x67e4xnBg8MZ5hfNvwRoLc+LZ513HJhgJchpRumDQKwvoW6p6lmnY9qPTaBNmm2jdv65YpCliHWyLl9qXW69sC5dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwdwTd3viihV85X8xzoUCOfgKHVedSW6/DCFEk9Go58=;
 b=PaGM2YuIQjYbgcFxxv9zL4G7B0F1RtKJTuzPYFdMLGQP8I7LlLrg3uf168z3a+XAy9q+YvKPMl/WBNiSfWWzA0AbGYCbGoLW8z/RO4+oKt39uHzBjcOL2dRKYXpGznJojWOK4wBkKNbKAZzmoe6OwXLVYMVXzYPxQUzOhva7Do0rDYNvSFyH61ss0PUn6MO1mwj6vvT0tQH0bgYdpiuZcjW0yMLXs2zuB4jvfcqeAmJb4IHk5GRyfvGmRc+924wGA8s8Q9iwkzxYPnsg5if05LKgaE98NIDkikilUH4HG1YLEwvFuJgZ/goO+Ho7krqLF3wdrpHpHJMc9r/5jCS3vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB8105.namprd11.prod.outlook.com (2603:10b6:510:254::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 13:13:45 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 13:13:45 +0000
Date: Fri, 3 Apr 2026 14:13:39 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 0/8] Reduce reliance on global response buffer in IAVF
Message-ID: <ac-9A7cuHQxgqSDK@bricha3-mobl1.ger.corp.intel.com>
References: <2a3001591642339ecf8f91584c83bf0766e0b66d.1772021348.git.anatoly.burakov@intel.com>
 <cover.1772794442.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1772794442.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: c1643c8f-e01e-41ee-c7fa-08de9182d590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: G86T4yzfTmnXJ6roibu/FHymqNIGHXECEE0ZzhpavMwi4TIwN1UiR/ewzEpUUXQPJH9tDYs8w8vHXx0HRcyMRTtLn/3WoOfOny41caTddwoSR6cq//F47tBSgn7SNQdA9wKSE++B//Y9fbJ7Ig9JIi2sZWTO0vPjtb67boexMKyuLi1bhmp7UAuU7nodWbNi72+I8J+XrCpklDjv4eqC/csN9KO9TuSj55cgDOzBKvfaBC+YG9B9K6nGGeyHHqO+I17M1vzW37FShhd/CAM2bBm+mdcI/gzUzoAAtbp8gBFeGTAY+EuvTse8EYFMSsL42lja9vCcJWwO8kKldsnvo6N0LlhqbejfiLO/9tMCV8GuVl4i/ZTrs1c0U9Y3jhM0TwcTAt2hyZvf23B0ANLutgE1VxJwivUFcyYJib5cpZroC+tVg0tOzntmLaU3tw7dqrNoST0Hum27hDx1RAIxxxjV9+LVPFGHHVVYcCGIvbJH4ax0foUk9stgw0c0nEXkLppXK2WbQmt661K4XCQj2yotD+1qpq5nu4moyWDCUBgGrvIYsMBU8CexsA/Igt3Lmetc2rtA9s3E62aoHSd0x8hbfTIPmaeoK1GUHTBoyWFQ3WHeo/nIeLBLrkMDXDc28jh9pfc/38J/Kfbl/JDL3va08+jTecSEXPRdMav8ldP9l2mmnR7GJq9Vzly1duxUI6Z2NcEjxPiytp8FQU7BaQikXSD/7MC4UDjGJOi1Jf0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1qyR7goraBi+xltb1b9t5rlzRvug2jatZKfSx+jIx6EYPxcFOYmP+5tS2/Ss?=
 =?us-ascii?Q?q0KP40uVKNw5fDZ2jukeKLDEA6ukACfAecyTrHE9G8JsS0K2171+guZuVbhB?=
 =?us-ascii?Q?j7wNpj+0kpS+/NVM1fuPxz9vl1suzB8AZgS5xVeNoVCh4OsdAfOpExKumdtM?=
 =?us-ascii?Q?XBgK3Ed6T4H3EvfOBNVzBA8PtU2hHovOQ7n5EjVhM+Cr06Sl5O54SS3uRJ/p?=
 =?us-ascii?Q?nh99fI6jWoa7ndfZ87Pdl1W2UbuxVJGZsuvJ5VNjwSZWo4UzT+umZmIMkzQB?=
 =?us-ascii?Q?yCYWr1qMGaAt0wKb3mAPlLX91uuoqlvMp6NaYhvsN4hUaSLn71VrD8lWPzrL?=
 =?us-ascii?Q?vNo23DRVc3DkIijCfhkBf9nuEChoMUgIesm5/NVPi1ARQZc8tZKJt1dPeyx+?=
 =?us-ascii?Q?X/fR/8NQTb8G3jMrCcPw2dpxdAvejTmZkJkU14J0rWjkmEsWTet6lbatwaRL?=
 =?us-ascii?Q?87hRYCpm0BNAWUUhVsaFDqL4G0+bmGZlCre7W7MmnlMSiCweAM6Yux18AddO?=
 =?us-ascii?Q?lGPJ0XCuGr2+m3U9UN8DQ68yXq+/PBIGTTWdES7U2ZvFERcM0flkxY0CcSyX?=
 =?us-ascii?Q?dgsO0bpYBbFikb+p8bRshKom2HZjONuNWdUtgT0r/PdHDUZDXynRU8rLi7Uk?=
 =?us-ascii?Q?u+O6Ijxbv9myQ5nYZfIXq+aXCerm1SS8ll5jzLXz9jxC3Hpzi4cSDk9tCkcP?=
 =?us-ascii?Q?MoZ8JhZDB0t4oKxt+KjlJxkV69RySV2qdjk7WdE7pkqAclcLqVIA5G55TKrr?=
 =?us-ascii?Q?4skqNex3a5tBVo5vXM0DhvwBtmamf0jv8il85bcF8hpmACqDm2byOdRyZ9Cv?=
 =?us-ascii?Q?VjdYnp/ygVemWZ9TVQrdTq3mFTxLm8MrxB1uaVNNlOZtp4lFhzuRCXtGoKbl?=
 =?us-ascii?Q?cBUdH1Ei3QaTA76ICw+UAmtHaIJsUqwtirAvGlmFzm/nFK/WwXyn+ozXq1+4?=
 =?us-ascii?Q?TqjQLyC5qUoAkKX3TBYoyC7URAW7boE0arZGjki8yFbI+DlJHF7V5XLfKqWB?=
 =?us-ascii?Q?H6xtAori9i3DNHDHRYuZs9BDr9KS6ANWn/2fhPs+f+s1UoHjR06fPMl5ekXy?=
 =?us-ascii?Q?nV1tjwJsMCAmMCp2lSoyYQTYjDYRsnADefBlNUu1YaFjV96u6CkneNscQibU?=
 =?us-ascii?Q?Z2tVpUPft7mhg5ro8xpBQOONExT/UIISgsWOdLEL8w7+NGOc4crwPad/LslX?=
 =?us-ascii?Q?oZ1Cc/NdwNR2HYT4d6KL6Q3Rhf6G0fNXyW3xHcJV2mP1jgSh1HWSiEpvvXg4?=
 =?us-ascii?Q?PxKeRpFicILdbj3iIcZBUssg2AEALz7R9cOU6z4xCLj5wwZmPWGY5U8VCkbR?=
 =?us-ascii?Q?5UYJ1XdGGZ80wvY1q/ls3foWFXmAQO8dzwteok+0VwT3OC5N9irUo45YIU2P?=
 =?us-ascii?Q?D7kJZAxfwJyVIXwTmJz9GEC8S2/t6lB9P+EwigUH3NbGQSs5n9aEvhPBRjpv?=
 =?us-ascii?Q?Ry+CYKebLducnN3ir/+Id5GedZ9fkEs14rUufCZ7ckhdOC7ttFuWbE3vbXEM?=
 =?us-ascii?Q?MuxMssKBuvwjcQTCrI8yOiMlhlELgSlYQYqPbP7yJp7kTQXIeGxbn27js4CS?=
 =?us-ascii?Q?OQZneGWeSZcgC4ZImEecr59tPztsbRDs4Q2+PXHmrnLip1LFlwNyvKPfqbZX?=
 =?us-ascii?Q?zUcr2V2vP/uoegpabsnUkHcU+vp37YGezi6t/pzFdCt3B6hZJu0Cv1wmRi+i?=
 =?us-ascii?Q?TdoyT3v9z9DJQY3yuqV04qfrlmgP6shYYwsz6vEbQEj1LwGxmslA/0u1YBj7?=
 =?us-ascii?Q?yQqMQRUEFL2/2geoD3/Vwd1ZS++7RkQ=3D?=
X-Exchange-RoutingPolicyChecked: dtUka0SUqa0uy/yYLgT+DMcsF7r587kmSb4ewFOfhxnkjI5zW5nDafFaUcCMSeGd2gMXUIyBJBblKf9CUEbSBAriar+c+dwud8IhpAoKpTsI9cBdFicEEiguLyV7D1+6LjZCONI2eupSu5LGUdFLWTE9KJVbQIaILuIZNXvgCxyAd1LWlaeUO1284C7kvEAt1CP7r/KD5cQPxUUjcYA4eGXf1oDs6kGNYymPEzeQK0TcoiV53klBh29ThWzPKXRWVwd8J9eMQw09xWSA21YAmW3ZhRQwq6O6+TjbmlBgxw+XRIU78jI+zFNSmwxbFgGoMsx6eMTeLk27EslaaM+vbQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c1643c8f-e01e-41ee-c7fa-08de9182d590
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 13:13:45.0765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QWKQMqVRIHmxoEFCKIf4sESe5YfNOS/rjt+BUWABOd60rcpNwTFI0G09nJPsTt+KI9CSZlzc7Rs7AYYCaApAlYS4NSpzKudlwRkEFzYmKSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8105
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

On Fri, Mar 06, 2026 at 10:58:16AM +0000, Anatoly Burakov wrote:
> In many places where we are calling down into virtchnl, we are using a
> globally allocated adminq response buffer. This is unnecessary, so replace
> with adminq buffers allocated on stack. However, because IAVF virtchnl
> message queue works asynchronously in most cases, we can't remove the
> global buffer entirely, and we need to do some cleanup and refactoring to
> be able to reduce our usage of these buffers. This patchset does that.
> 
> v1 -> v2:
> - Stats query was passing in a pointer-to-pointer and storing pointer to
>   global adminq response buffer as output parameter, so changing that to a
>   local buffer resulted in storing a pointer to a buffer that was stack
>   allocated (i.e. introduced a use-after-free).
> 
> v2 -> v3:
> - Reworked the virtchnl message handling to not rely on implicit behavior
> - Split up into 8 patches for easy review
> 
> Anatoly Burakov (8):
>   net/iavf: avoid passing around pointers
>   net/iavf: add a variable for hena
>   net/iavf: add virtchnl interrupt enable flag
>   net/iavf: rework "async" virtchnl requests
>   net/iavf: refactor sending virtchnl messages
>   net/iavf: respect output buffer in virtchnl
>   net/iavf: do not use global virtchnl buffer
>   net/iavf: embed virtchnl response buffer
> 
Series applied to dpdk-next-net-intel.

Thanks,
/Bruce
