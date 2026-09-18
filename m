Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7196DC982DA
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 15:07:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 309924279C;
	Fri, 18 Sep 2026 17:07:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id C753A40285
 for <dev@dpdk.org>; Fri, 18 Sep 2026 17:07:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789744028; x=1821280028;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=unnFn+iDQiPlGS7ZzocVS1Z50dfHig+LvbqN207UUhY=;
 b=gKYGd0hE2LSbHgQ0OmHAIuDZeLVNoYLtJb4BSgOMRcyCBkGCDaf/AA6J
 1JbIDP/ECI3PtzYvO/9f36Mr0uc9+hvgHYgpTpSibVNZy2ROfdeTeUsq3
 FJ5gfV+69Y4w083+719v+dw3x+Gl63rSDKpf5owpbhiyAfeuapu9uJbaD
 soPHEK5kxiHxBWghyQ8sJ92KnQjZVy8JGSNi+GbNP7Siqsi8U1qQwT7GC
 2cSmKOyfg7DxfxEEWeoWEr/Gue3esboa3AeHYeEkTX28GwEqdfiBi6TN5
 Bkkdtg95YLRZ/JQHieHpJ8muu3xWn33ogebcYOQGueFuAkFsR3Nf6fF3E g==;
X-CSE-ConnectionGUID: f4JAxKC2Qsmo4IiKTJFCEA==
X-CSE-MsgGUID: Itec+W2ES6SZ8XJUP/OdKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="89392489"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="89392489"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 08:07:06 -0700
X-CSE-ConnectionGUID: SCAX3mW5Qk6ihbcjzjdgyA==
X-CSE-MsgGUID: rgeUw1M5TcGV3sVXaTkV2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="271119950"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 08:07:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 08:07:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 08:07:05 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.63) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 08:07:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VISdyR86+CxbmH/TG4i2b8JkGMFd4584ketGmUxwGSx0JDwjiJAtzYjjTaNAxP64KnSLEHtMdFuA4ChnTImxinGJkEk8Bfn/ceM72574x28I1qkuiyUkIsfkr5PUjd3l/ywX/8zruy3/CweZDsKPrafc+QIVzGfk5RPIViBrKFiPyPoFPAIzM2cTp6iAkui19oiy9eksRN7Q1mZtIcWWeTub6Jvq8ZaaaqIdWU9RIzmU2vFDV+algjhNyUPQdBCLh/VxdH5EfkxGmDsDblLn6ekpXbews2Jy88ckcJwDlsQoz7Q8dchUxYKI2T6JFQStv3zCWTNwI8r+aFcvJgkXlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUjZNCXpcZFXvxwNq0++srunew4PjUiAPlBLo+EDiZc=;
 b=Qd6JBtj+vzgkFoqiCHw9agTpGGmRBqnzV1BF3gfGuylWiiYkG5pljqYXNI+ZBB4D3gKy0X8lhCul6QFhfZdBQ1qQlDlYIBE9+4nqzh5vBxHINZf59VUgc8vMS0dsJAw2ebJTpS72oxl7aBU5cQjTugeT2neqFACluilx65DgI108XlA1xDRzAyIr+pLGnMfogFOCE4hr2/np7aWHPfi8bDevC/unkrLKC8F3V//nX4cb6qM1Mrfs7VL8Q7JG6AozC4BHTb0B1rRaZm5cawQWSJFJdkXDyITFPMOAwQI1E1ylF3rokRUkw68zc38yHeNm0PU7hvJoBZjNgraCW4X6Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by IA0PR11MB7401.namprd11.prod.outlook.com (2603:10b6:208:433::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 15:06:55 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 15:06:55 +0000
Date: Fri, 18 Sep 2026 16:06:49 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
CC: <dev@dpdk.org>, <jingjing.wu@intel.com>, <rjarry@redhat.com>,
 <thomas@monjalon.net>, <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>
Subject: Re: [PATCH v1 1/3] raw/ntb: generalize framework for multiple vendors
Message-ID: <aq1Tie4YuRtESo30@bricha3-mobl1.ger.corp.intel.com>
References: <20260823140639.153997-1-raghavendra.ningoji@amd.com>
 <20260823140639.153997-2-raghavendra.ningoji@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260823140639.153997-2-raghavendra.ningoji@amd.com>
X-ClientProxiedBy: DB9PR01CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::28) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|IA0PR11MB7401:EE_
X-MS-Office365-Filtering-Correlation-Id: ea041eb2-0727-499b-0284-08df15967a22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|3023799007|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JLoeC85a9pmo79Ozwp4m4MUC8eooNSeBnIE4HpCBQLNHmJzLh756R/Z7yolJWjD0u1emdy+ciYLDtLSLgSfywBxWe6B+kNqoesc7E4MRVMQVMWK+S4rpO4MnFnweBsWrYJfPssE2jGkuKAUWft3tfKKL2YXepTuetKW70H7sgJXJBQNixgnZ2ejGkKdwTBuqKMbOWEPJu9fWVg7GCE4LhEEXkPgejwSB6parqzVvp8R1k147xsDyRBHWsJc0+ROVpz4FLOepEapq3i/IeOKHz+TeqkU1b6nr9tFLMFRlM5OKxyiB+yzcvTFr3TLtU99bKzpq8smUAunuXeaXg8+0aUMG7Z9i/24ngmL0tMcxVw5FjNqD2zRztaoku9B6HW8iOh5iSE9byE2Eb5zqpA6fvbTxxocmWLlvZ9yr83FPVqvNZUwzPHoWqnLERm8DVujiD983qdAyn7Y4tDZlL9F+2YsEkUlRWLONilon9AJIDKQAZHD5CIFfVAtWGumZzorGLIvnhPUYgJnhmM3S1V1Eu3/1IETDtpskS6Oim2L6kUfNYiRd0hJArcom1VKJSJyc++HEc7EBPWzSXf6Ycxcb5yKkyMW/TmOvt+/9qK1cbZntiqqCWWnLRQdnKjTcfiUwQQ/nhOzGlPaGgy+Om3ugCsawGBYu+uFl/W8cHI2KU10=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(3023799007)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HzD0tR84nB2FjQaFJXRwXpQesxirrwhlATM32BgQXyH5P+5Hj4vFXhuR17JF?=
 =?us-ascii?Q?b0jX/5ZRjRVubTl5u5vJYhuZRUu4EyIzy0XEgR4yxBxvjmXvIyzpy6HzK+QT?=
 =?us-ascii?Q?4trDGM+e5CU6S1UV33npWtq1c++TGoqKftDJgKhOtYYYVEHTyHWTqtMqChMR?=
 =?us-ascii?Q?yf+WQ4lLmFnXvyQ+cL3tEWGUKurIyLUZwYMkZKPfPkdtulhF360oFYIH63TP?=
 =?us-ascii?Q?fu8kaL+PyUjuOpg9I8UvvVlBmvGsk3v2S8UTOW+pGqmdYwcaByM6qdbLnhpM?=
 =?us-ascii?Q?Pa6NOTFqY5ndPTbc5RUN9TcbE5BAAhfXGn36xVcELz++eS0GHOMqjXUedojJ?=
 =?us-ascii?Q?rxwiAN2240q6Hr254T/uPxJ1j9OVombAKJtNPsC2T/Zu+hxay/Ral/l5pLtk?=
 =?us-ascii?Q?VgEwu+G013NEU8jOQQih79tCyNxEF+gdihtTN1QaqhEdE5vNkcbopQe/PNe/?=
 =?us-ascii?Q?xRcholuIMPfVEhUL/JMnQqmk/Ha7u8AdWyqF+pIN5tEAAOEWyl1ashhwVZAN?=
 =?us-ascii?Q?M+D4lIsECBvnoar3pkQfRT/TKRmJ9Uoxbfy5NXhqpnu0n0ygljxUT3QcnADR?=
 =?us-ascii?Q?UTVVz7CdohFSkg9Lu3mlgKXjc0NbzTZ/SscHyGz2YQaakJrZXyMsePgMLa2T?=
 =?us-ascii?Q?OiSfxfTDYTTfaUEax1ANTfxXHeDDjzgY5FltMqM0Gy3TDeS9cV5cm6n230KU?=
 =?us-ascii?Q?QE7dDFBhOdKthg5jJ/Knv5CpTahyjp6kVX+Yi4diUbLqQ2uE4TAeAmYIfN+G?=
 =?us-ascii?Q?OsyuIX/feipIWKxs9SBt+FHWmKlfOIddQwR1ZCjMKjc1mAVJ2qyMmgcNFjtO?=
 =?us-ascii?Q?3pf5eH4SQtPo7KqVTuCw+Jmg6n4aGiKymv4lsEKls6eG2e4/l2U9rIQfY/pa?=
 =?us-ascii?Q?Ok9y4SZWln/fJf3DbVGIbPJzzcHr8RZqlZsrG5HStKOOQSvbYpbuUZYlc55x?=
 =?us-ascii?Q?18mKw1SIQUmmSvKr4tqXphM5+n95qkDuZidirBe0kZeq6k74HOmnR6Ja/kmg?=
 =?us-ascii?Q?tBdQHg6SbyaG8cQA8z31d8yxeIb6sWbQXRMgmbcjkMp9767k34QXc5Q7IBEh?=
 =?us-ascii?Q?PDz5mRfYAsKnBfISzGJK7wfYyM61fDgRW8tmNKK9IofbYuX7ZQWExtfSgqQk?=
 =?us-ascii?Q?dC5ztS0LQ9QKsMdBKWIpqqsp7kvFIGB1DbOK30qTnjAeK9YQlJ5Hv0xj3ikx?=
 =?us-ascii?Q?BOqXRH5XUNOgdHP1JXpPKLUbm38MD0jCZMuFoikg2DmZRqUDzVmA3lcZ5h8+?=
 =?us-ascii?Q?3FC/GQGVVnYSs5lukD5iaddTnxNXAgB4xmdr8jMHxUjZs7BZQ9TRf4DW0gy+?=
 =?us-ascii?Q?pUjmN887epJim9FjLX+8x+TO7UDkl4unikA45A/iGJQ1k4J63xNL94Yev5sg?=
 =?us-ascii?Q?uM3J46SNtbcxXLAGjXaktPLcSfMwK7lh85AZMmD0th4QSUuOxpDBSNp631ZY?=
 =?us-ascii?Q?T9wyBs0fxsSxTiKdGlG3c/RMvNskZcMOum/sEJ3S0NuwE+vStQX443UNHtPM?=
 =?us-ascii?Q?zFVG/CdEztFAlmd/tXG9XFaL25QvhWL9G8rJXrMIs/203WEshwnEupC6Jj9N?=
 =?us-ascii?Q?LTJLwE8dzN4k3Tp38WYzVFSXG2NaCh4AUOV053qNvg+CymZXxDP8S3nTEyM7?=
 =?us-ascii?Q?EVxCBBPhInBnhwHrbP/wAmR0hIzAwu2DmUMQUAl49Jf5ATyph9CAIH7Uk0xG?=
 =?us-ascii?Q?YuOeChzYzyagkxpCDEWfnqURYrgoG+EpDHzk+wUwJez42nLfjePyaafQ89Os?=
 =?us-ascii?Q?kB0UkyTC65WEJBIfuNK0TjEhx2NGEWE=3D?=
X-Exchange-RoutingPolicyChecked: imI6Hv2gkwyq61ZdocFCdmeDzEfzCuReE0S43TtbsS2ZWK//15XLNaK+S017bp4+pAhG4SvdxpFAzEHJuaDHNtYb4ROrlsgq4Nztk/YKlxXun3+z1Ks/r+Wx/BbrWgk0ULG/+FZ2uPoyGHrtynzO8K4XZ2fEKAlnIHPxJiXbjayfZPpyXrkFfX5vaDDS1lsoVSIyoD8JPg005Mhu9fbCaB9ZsB8ZWoOh/ua0YOeb75ObFVGb6mJ/+tN3W3KZvJ+D++MAbpDyjqT6OYFp7z1z8MgL1Y7iT6hAQO264d8ACn7tpHHmiYUyOgYTt4Rg9v+OqmiklLgUUnpY2a5OBgrDVg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ea041eb2-0727-499b-0284-08df15967a22
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 15:06:55.0023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXMEORFAJSiymI0iZkvSyjeFdQ7Rd0jikDw/X6xVrNzHV1VPquFtvn7LSUufEnzasF4Cai2CL8xER4aKZ8dRcVEhADIxIR91MVhk6SvstdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7401
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

On Sun, Aug 23, 2026 at 07:36:37PM +0530, Raghavendra Ningoji wrote:
> The NTB rawdev framework was written around the Intel back-to-back
> topology and the built-in scratchpad handshake protocol. To allow
> other vendors to plug into the same framework, add vendor-neutral
> hooks and make the common code dispatch through them:
> 
> - Add NTB_TOPO_PRI/NTB_TOPO_SEC topology types for hardware that uses
>   a primary/secondary topology instead of back-to-back.
> - Add optional ntb_dev_ops hooks: interrupt_handler (vendor-specific
>   MSI-X handler), dev_handshake (vendor-specific link handshake) and
>   read_peer_config (vendor-specific peer-config read at start). When a
>   hook is NULL the common code keeps using the existing built-in path,
>   so the Intel driver is unaffected.
> - Add a pmd_private pointer to struct ntb_hw for vendor-specific state.
> - Guard the receive path against a malformed stream with no end-of-packet
>   marker so it cannot overflow the descriptor ring.
> 
> Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
> ---
>  drivers/raw/ntb/ntb.c | 94 ++++++++++++++++++++++++++++---------------
>  drivers/raw/ntb/ntb.h | 18 +++++++++
>  2 files changed, 80 insertions(+), 32 deletions(-)
> 
<snip>
>  enum ntb_link {
> @@ -100,6 +103,8 @@ enum ntb_spad_idx {
>   * for those db bits.
>   * @peer_db_set: Set doorbell bit to generate peer interrupt for that bit.
>   * @vector_bind: Bind vector source [intr] to msix vector [msix].
> + * @interrupt_handler: Vendor-specific interrupt handler. If NULL, the
> + * built-in handler is used.
>   */
>  struct ntb_dev_ops {
>  	int (*ntb_dev_init)(const struct rte_rawdev *dev);
> @@ -119,6 +124,16 @@ struct ntb_dev_ops {
>  	int (*peer_db_set)(const struct rte_rawdev *dev, uint8_t db_bit);
>  	int (*vector_bind)(const struct rte_rawdev *dev, uint8_t intr,
>  			   uint8_t msix);
> +	void (*interrupt_handler)(void *param);
> +	/* Optional vendor-specific handshake. If NULL, the built-in
> +	 * scratchpad handshake is used. Used by hardware (e.g. AMD) whose
> +	 * scratchpad layout differs from the built-in protocol.
> +	 */
> +	int (*dev_handshake)(const struct rte_rawdev *dev);
> +	/* Optional vendor-specific peer-config read at device start. If NULL,
> +	 * the built-in scratchpad reads are used.
> +	 */
> +	int (*read_peer_config)(const struct rte_rawdev *dev);
>  };

For these new op fields, do you foresee cases where other drivers might use
the "default" functions as you have now? Might it be better to simplify
things and always use driver-supplied ops, converting the existing
functions into intel-specific ops, rather than making them fallback
functions?

/Bruce

<snip>
