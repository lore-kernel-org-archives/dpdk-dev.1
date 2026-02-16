Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81D5E81A5A
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:13:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14B0B40296;
	Mon, 16 Feb 2026 18:13:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id DCCD940289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 18:13:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771261994; x=1802797994;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=jNMqMoUsdDG6H/D6n/ofx5hxByFwvM9m9bgYHhS+7EY=;
 b=JDlD7Lfk1Uvu6qxaK+S4URIYRFCiHjAg/pO7HkOU7HqEXXb3fvM5DWEg
 f/DR9s9XPmgQRJ2Cg6WF/aoVyDE5lzZ8O8fOaMnHaGVadRwjh+El3eunX
 3Dk9JCKeexxa+QFwnT1vSEUPqpJUqw9rGTlKe4BPk/D+7bV5U2w02a8HF
 2bQcZ5pXFArd8H+S3waZC/14SaWbD4SQH8NqDZMix9ln7ZNYxYCOEf75D
 45E/Rsq/NjOIcrbLyQDgATq0f0/tWFcn0JzkV2bTC/Tj/kbwIwe3MB8le
 0p8LNz0wESY1lFak1lQ3cxbbN5c6z+2jtWHhNRfGAHHTKEDqMhQSBnSob Q==;
X-CSE-ConnectionGUID: BbwxUTfCQL+XY39gEwqGrw==
X-CSE-MsgGUID: ZxrCSNoUSZ+zVpkFxp/IWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83068240"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="83068240"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:13:13 -0800
X-CSE-ConnectionGUID: HPLyWQ1YRQmF4rrjOwK5Mg==
X-CSE-MsgGUID: ZTxkEruHRni4JVkrAs9xUw==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:13:13 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:13:12 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 09:13:12 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:13:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LE2ubuBIhcNezWd0TapMQTaDYyNS1XyOyNh8FmPZo21eqCE7KTpQrcWOv6V4ysU6/Hl4aq7sShWGsTACVV08GOM40LLOOsjsEOIrrOy8TZrE6F9WggFrOGQMi/R4H0LCm3/+r7YRaCLMuQoRTDPSgNFRxeWyxyjnKzaKDA51GBG5up5NCslcKZyT7NwPZWh37Dz2j8vzGJgei1OUua+bgbZlxnYQb6jftB/2ICcWgm8kFF5NUkNhcjhqFXP02wOg58IawE4RhP4Czh2UwbJJix+mJAsMP2LksMuC3pXxC5rVeDGBy5oE8g7fxOvSR1r9TJZfDZytPahVX+7jnsTYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pF0p7p1r+LaEm3mCHBGkcOst0iJ9odjLkCHc63b5rM4=;
 b=yk+J8BQJLdjyszQs/Z7+JarTOp9FmjuFd8I3/Yl3HailgdkeHUf38qLb4YL4KdwRvYTzg2kDM5pffbuwXBV5uXEyvXMlnBTPP1gFREkzG8R05RaQE3ru3jA5XXDbAAiKwgDELGI787jTevTl21bh8KyAl+rBFL+L5PZp293iFNageudaj9hWSXJU/ak+5Gu3EXN61iw2ancWmOqIK/GytJCoHNaVnBLnPrQ55ZvMUIMkZGY6su+T/tLXJu6WnBfkQ/6w4IJ/t5vCDtncJgynHQHPnbvRKNw7ThIC93MagX4BjsjVRik5P9CTIiJ/gzxYH7YXIT5RZ4ryLJ/G8HB/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPF7CF5FEA5F.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::838) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Mon, 16 Feb
 2026 17:13:09 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:13:09 +0000
Date: Mon, 16 Feb 2026 17:13:04 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 15/27] net/i40e: avoid rte malloc in DDP ptype handling
Message-ID: <aZNQIFpu0qM9krS_@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
 <a48eb9cd4cee66fb306fe57c0755e0256a574152.1770817884.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a48eb9cd4cee66fb306fe57c0755e0256a574152.1770817884.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0260.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPF7CF5FEA5F:EE_
X-MS-Office365-Filtering-Correlation-Id: 2560817c-f784-4ab9-c861-08de6d7ea86b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9+DBgtypy7YdGDPrhrkFMC7BvAjauMJY8cgGNODI3gMZpMwoV+TC9UO7OHpX?=
 =?us-ascii?Q?G3013vQYwdvpE/nbJ9PdR8QrXfZcoFFNzDz/c/uLADlXOIewiVLK/NI6nAQ7?=
 =?us-ascii?Q?5QK+1bzgohU8Jr8vMp+mQOOPPAV5RCuoz63GyrD6mlvEZT47glhsVxIGqcXo?=
 =?us-ascii?Q?OqMPHnxv0RNi6DgPENAGVm+pm5Cd/fV0DDoO8Ln3IEJ/sIOuaZjGAiEkhBen?=
 =?us-ascii?Q?zc7xV9F2VnMSdZTGbl4CYuOz2BIRysckGFz3Wjnw7KJ6yaD19HqxwgGZ4laA?=
 =?us-ascii?Q?+W2W1l/LZXBSXAm2zTo0QZmpTXVakNStcVwI+5q2zPF7NB80SQZxY2LM7iuk?=
 =?us-ascii?Q?kJtX5pV51yXKTpwGEllBCIjfKU8wBxuPbDxCl7fNAu+uE5oHRRf5+gJoG7V2?=
 =?us-ascii?Q?jxdxDoRe7HuWa3WC19pvOh3BC+FjBsid+U4ncuBmWj1w0soOiXAoj82StfFZ?=
 =?us-ascii?Q?5hZkZx6PRUZdSWHn+yLyMJIOpurTunVfIZrm14OnUskyhkYJOgvncnzqdY2m?=
 =?us-ascii?Q?/2WZcYKQS9Zp7urRubjJ+aQboyjx2YQhbJce6xXnQxdfxR2PPaqNxHe4GaLL?=
 =?us-ascii?Q?GqkFsWjR69YB2MVFHA5hPVsTFEcjdd+mct99EfwNonVQIapmvix7XnyRhyfg?=
 =?us-ascii?Q?P3/yG+xZYD7QpDN//Mx806IbNUphvPMoK6MmZtJy9N9neXqcz2CRvEzE3hOx?=
 =?us-ascii?Q?bj8B15QGtNNU4WvyPf5zb9qoCqSehgNmUBmyuG28tWgZFdirlli5nY8ozJJs?=
 =?us-ascii?Q?7SWEGqePep0Vo5zreJxXeIem3GeX2C17r8iYGk51H2KXotuOiIChpF++rLKw?=
 =?us-ascii?Q?EFtoQafA+H9H/t+DyKCe1VJyYK7Jb6++FSjcndLVGtH3RYtFN//B8VJLqkzb?=
 =?us-ascii?Q?p8w9JnfeFK6j5uBknxGYUFOE4w+ypy0cD/SPNfVTj7x2p1g0FJXy5yzWfNTz?=
 =?us-ascii?Q?eOdk3sXlNLUSKr2iVrOR/yvWbHn1Edz/+L3ySbvsWpgKBTLny30zt43r9uG8?=
 =?us-ascii?Q?72dNBzxd6O4RbsoA5NUa6Yc+teAgT9gQoeZy4rkhF2/6tMoRhY3pz2tr3h/C?=
 =?us-ascii?Q?5U3Czr6jXF3SbprpKhraDNq0HtJ9BJ63vlQ5ozoIGwyyjI5RUjLhcqAz01Kq?=
 =?us-ascii?Q?gpxWOq1c6UmLTEyojUV9MFm9nx1wm8aboRq9/OLHDHw60Wiujd5CBFr74mt0?=
 =?us-ascii?Q?0j98QaUj1plipwaL/Mbkucq01QCndXVMdohWZM57AiN0wOJZ5v7ikz+VUyi8?=
 =?us-ascii?Q?zworJEp/NXOpG8tLijDPuf402HyGfQuF3xQBPvl8969zoDTTk6Afz/8YYs2P?=
 =?us-ascii?Q?Wmm1pXPI+W6bKaU+CfNYUok3bbcZ7SpPleRUAbbFfERKVB5D8yBg9XDh3OD/?=
 =?us-ascii?Q?8tApvjSQ+/GvRfhrm5hSW04yPXdtVq4JVhH8R/cYLDEBQInyNZ4Xv9eG4hWV?=
 =?us-ascii?Q?fjWEB29zjFr2gIwD35gt5KtjUaWGx7Zl108LoX3ta1MqDhtZ/jYX5W4KSdR8?=
 =?us-ascii?Q?4FSDxQXvNVDXSvZV53is5Rj6bDvVB+A3AFrNaSK3GIckhjKySuLBqzJUBA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wx6LqPPOoRa75Pz15+nOG5HHmH9p2VGZZheU5W5b5p/tczXpoYg07EkA6fKl?=
 =?us-ascii?Q?nquN7s7jEVXshfDtQC2XIuHS0AvxMxRUlGf3Nib1yEnP+zYmAqcuO/XJyeCg?=
 =?us-ascii?Q?QXLVVP9LKTKzdXXA5lheZ6Nr2fTiI5UsyRTtrLD/ugwmADiPq/WPxphU3z85?=
 =?us-ascii?Q?ZXiBM1GcKmfsGJ3gIAL/pfr241qd52iMzSYhF5kzOGsMNgeTk8TcFvCvjm2o?=
 =?us-ascii?Q?dCNWP1hRhzAw11BazDgtDTyARG0rfbyZwWwz5tI3Mo2iHCTC5yqm/lcD9n72?=
 =?us-ascii?Q?pK5yin2+enSrPHVKjygUaWjvDyFKrv5gen5VUdCcgGl3Ln/fegtiYNVHXg+K?=
 =?us-ascii?Q?3HX3iifxuj/T189RVgUTJlziah6hThLn4i+VuWC2Eldxowr38sNAK6MgHWQr?=
 =?us-ascii?Q?AhjN5fVJLzq/RWjmCek3lDSSJz/L39ybaUtIYWQDHHRiy+9XCCosjZeP2jyU?=
 =?us-ascii?Q?guB4LSSPRzbeaxi+4JaENITtHJRpFFGeScyi3Y9rxZ0Lg9yQDfoWDmLf/kQ4?=
 =?us-ascii?Q?LCXwzxQcS76el1dzP2UcEjE2B+XUJam2DoKAFZc+yZO7IBu43T7wsDwgxhzp?=
 =?us-ascii?Q?t63oCOQWxL5dn971loyyR40wg9aa7qU8VucJ3jeZ+yg6EK9rQdsLpagWB3vx?=
 =?us-ascii?Q?/8neVQi5v7BYcFvI0Tcw2x+jqUK0pKt6KOxKOyFVoB+MC5JLGiQYo3leRKnb?=
 =?us-ascii?Q?1tF2ZvFzrCQJ/+KGn89Yn09afJsaK9Q8UN2MGrfdrprES76IAy5bD1fxsLA3?=
 =?us-ascii?Q?fet8zrEzlwlB4UVdgsjKMnYVKEIT3gVS5DBXrUHwK1VXRnrYse6EyJjxqP/L?=
 =?us-ascii?Q?agDNBG/gKGL/cOINNAyoE1Y5NwCk4bidlvu3d9o7kLWTgca5qICVORpqncRB?=
 =?us-ascii?Q?Th2JywbM3dON/1n831G7i3PsQkYUKRyiqFHczPSuOG33PoKVI8n6jYsKtowI?=
 =?us-ascii?Q?U01ErUxVKq8UASWtW36YOm7m1SDGKUT+5w94P9eAaomxd0ngKkUyWZplt9kg?=
 =?us-ascii?Q?jD0mgz4BFHbPj8GaOJyB5kVLhmdI9lQGEjbTjoaN00VbkltDBanHN9XP5v+K?=
 =?us-ascii?Q?YoOjFM0rMvJXHC02YQ4drsMEBQ7Hci0c3BTOxivsRjIlX8XTFf43vzrFHthP?=
 =?us-ascii?Q?MT+nSsBqwDKsQ5fl2CzJ1tyrTKd3FYjjtwNTJqhHYpCh/h1uWlqsC6LK3dMi?=
 =?us-ascii?Q?JG23dgCZJ+xU0fbwArw1Gyx7luC8Zpk0sXZhvLRluphCbAzO7w4BRFKgCKrs?=
 =?us-ascii?Q?V8n6kxRnKGyWDheWR8W7R7dvGdQ9ZoRzIZ2mbx6DtUBP3eYvkuSptyj//NIF?=
 =?us-ascii?Q?/b7idqCUwp7hM+H0SgEHGqA4omlL2B6Yy6BM5D9Be6cEJzU2q8IuXBJFp32l?=
 =?us-ascii?Q?Ut5j6h2f6XOByhSbkVFGNI2ZGMcmzXTMlkAsu2OV2QwuMt/jSSAqCFilW7aN?=
 =?us-ascii?Q?HFsrbepHCGaKvrP2Sqn6cE1zj589PiWJKOwV2B9RSz2aRaTG9qCCJZJN4IJf?=
 =?us-ascii?Q?lTsKCByJTdPgXOxmRqPp+0TYRkDfd2cv5l7vm8sZJ9jtz5giulb1DfKUSdKP?=
 =?us-ascii?Q?ALoajeCeLMrMkAJUsfLP5buQvYOWsV9xj54SBY7zbEYvg++7XVqrIhbgN3Pp?=
 =?us-ascii?Q?B1HHoL5hNmCWlYtu9H4FbG5lMBpFMzoK1MY8PghZNEAHjLE4u53rrA1E9M2e?=
 =?us-ascii?Q?Djr8St9o4Hu1qtEWzTeZIwygUE30KmnpeOFgcXh45L7irx/dCKxaddRlqWDv?=
 =?us-ascii?Q?xCN1djDvdURCu7IfMOoLS2Y9/WG6VEs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2560817c-f784-4ab9-c861-08de6d7ea86b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:13:09.3773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWGhN6LzM99QraY89BdRRT7f2AIhgA4ZpGeyMSpZbQSzbhsyHnx6hqrlc5/yQEvwMQsI24wm63A9bjuqWfg7lI5AH76RzVzIDO17cMTk3M0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7CF5FEA5F
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

On Wed, Feb 11, 2026 at 01:52:57PM +0000, Anatoly Burakov wrote:
> Currently, when updating customized protocol and packet type information
> via DDP packages, we are using rte_zmalloc followed by immediate rte_free.
> This is not needed as these buffers are only used temporarily within
> the function scope, so replace it with regular malloc/free.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_ethdev.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

