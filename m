Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9136D606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fj+Atlxt
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC55640264;
	Thu, 22 Oct 2026 17:35:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 53B184003C;
 Thu, 22 Oct 2026 17:35:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792683355; x=1824219355;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=dfmSe5ghoAC3SmXj2XXRMrUerTeINVtveRp0dP4rbug=;
 b=fj+Atlxt5jsJBUuNB/KS+fH0t7m6mj4+Ammimoya0Phft+Ke5r+pPpUX
 nRc24xJdJ2j8baSiKNNywsiscRQXH86ZX1KMkjZinlR5xb3teYtjDlK5k
 5Nel4fQTOwlZsIXKB9s6gcgmgmaceiYLCfu3GKVdDjvt4ls7X5JvMBeOC
 lJRCqkKGX+5xs1xWBQlLPhUF5poGF352UyhrlAJafjiIuFJhd8pGfX+0d
 SUsdUAARJjs8oGdFu4jNteFDhm4/bfPeUdLcGJQUMoJTP2pCQp3eB/x5v
 YfCld5JIVwBT1WDGR7l6COucUQmeZsxzaciwyt89wT0kSG4tRixwgC4zx w==;
X-CSE-ConnectionGUID: ZkzSFGUOQ02uXcizDPdJJA==
X-CSE-MsgGUID: P5cJcB0wSZyUgn16cFvjhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1324421"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1324421"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 08:35:53 -0700
X-CSE-ConnectionGUID: 8BYEwV8ASVC+f5cX7rOfPA==
X-CSE-MsgGUID: QtpXmHuFRNWYSyUYYF8d2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3803669"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 08:35:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 08:35:52 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 08:35:52 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.41) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 08:35:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWysI2iMxqT+joNRQEu69OwGWq849ZoavBaFaoSrolh+pzNWkzdqDsipePtJZqwXiHkQAO6F5Uj2A46oWbn4723pzPieFsgR6a6jMe71apHKpVmHIkjPpJxBwdeEVvO+m6kZYPg+fIlAF+GUvC9QS49c0x4RP/shUKlo39KIHvTHNnEb5u3XNEV3jjjBtUwBRbNkVtJomlzOlzxKVqNHCRXFNbqMAZQnM8ea/1KrqAVNz1nvaY5z1navx5JuO10AltEnMDTl50weYJva04pPKRzRVhW4DaGyNljQN9QElhQkYhZWPgWKfa/AWG/Kjp14I21uQeEJAKgbGxMV1SqPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAw9Yoi/QRn7KKf1ePQUt4H3OFwwJd6zo4+lAmr6iUs=;
 b=fpe4RiAv94EPCAtFCKaal9Mv369jvVrhhetpAks6gcvBgKgu9CZYBdaOWno50RNxYPbdz1KH7V04MNCPYB2buST6kVQNZFTrK5uQtHhUIRCQTz+vSlIQ8hlcT1KFixX8WbHafQMcQ//EwwQaInI5NT0PM7jZwe/cb62tTqL2BQ8cnd6wQ5LOj3fwTAd/GvS+9NIGRNdHfnbStgKSvllaWutBFUZz241vW4XSTa8twqvCcVipgfDZTxf2wsGwaxE6ReYcaiosbW5Q6ry/8QLLt0dsmRKesKrLhoXKopp6wY/E5ootmLsyAkHeoPQqGlYx9L+eiUJm3HOO0Yi3uGxg1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SJ0PR11MB5918.namprd11.prod.outlook.com (2603:10b6:a03:42c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 15:35:50 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 15:35:49 +0000
Date: Thu, 22 Oct 2026 16:35:44 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dawid Wesierski <dawid.wesierski@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>,
 <anatoly.burakov@intel.com>, <marek.kasiewicz@intel.com>, <stable@dpdk.org>,
 Jingjing Wu <jingjing.wu@intel.com>, Saurabh Singhal <saurabhs@arista.com>,
 Qi Zhang <qi.z.zhang@intel.com>
Subject: Re: [PATCH] net/iavf: fix interrupt callback race on close
Message-ID: <atotUOk-9s9IcsFv@bricha3-mobl1.ger.corp.intel.com>
References: <20261014122427.631805-1-dawid.wesierski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261014122427.631805-1-dawid.wesierski@intel.com>
X-ClientProxiedBy: DUZPR01CA0077.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::15) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SJ0PR11MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e56de25-e833-4ab4-e0aa-08df30522623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|10067099003|261021121427099003|3023799007|261021135927099003|22082099003|261021123027099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: LcwOdA+d5G8iBoyBfOsrqHE+gfm8NwT1WhJzsTkCjL4tcdpvsKNXrZ7ReWD3IvsaPzFXZ1PziuFxf1rqR4Dq88EDmwaeh/J0XwSKhwG39HX9Baz/MKKjuat7rkNGsz0SiCF6mqaRD5mF5p5gcGys335EqFf2ICmqmULmYr120AAo4q3U+lkeP7nEwG/k8dMv2EdzqS6ukUM3UHYH8xi8c5UWuiiFUQbKD0joHALt95ZSILRB3+wrpcRmCMpyYCbkyKSVje4ySaI7plXbUswW+t19I6ZfCA3OfLresw6j4rTddSEvPFnqglasc19jDW597UpYI4IdNQ3v8oKKzJd7SOpARuF+2DajRc73uaNC4mxl34qNrQk7pxF5hDeGdSSS+GAiG+S3qE9NS+d8pfLkd2CgKQhsgKYa4VyEcOi8VFiw2KUz6Uz+aysb+IeRbfh+AnUtb7TSNx5+7F8aQaI5xAsK2RwXK4Qser+GRO9yY/4XQSuYE/AjWsx6253tej+9WpFxcvyWCqkJffuVCriBhCZ5kN52RBhHl9kHSun+GEznHTKEJg+skDbI4SieIrk5qalx5/jOSwwqiZH3bF7NvhK2SlF7QytoljqpnMDybKmymi/AVJjLm8E+Abp2XYBx/KmWesGhGoChfZXdyVxA4WepLqXmBJK8FlLAMl2aPRk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(10067099003)(261021121427099003)(3023799007)(261021135927099003)(22082099003)(261021123027099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qMd3rHnXB9rPAuF3seuZioANBj0rcVHt7kvljihX6XrXDVTT6dGLPArtuUZh?=
 =?us-ascii?Q?J91Hz6HUFdwKEjiJFhLkHVFTwsYgS2NWxLey7dwnN1zMVtD4OOyCQUfnZ372?=
 =?us-ascii?Q?s40Y+s3SZu/pi0RcpVgPv3KPgy85gykM1s5CiPvu0YS2pPHMPf2KDtVDeEuy?=
 =?us-ascii?Q?V5UEY8wYUCda5Aac25fz/RBV/mD+XxIJfu5utd7JlLB525waa85kw0hShu/K?=
 =?us-ascii?Q?99cHEO5joBv5ieNc+LWCVmz93wLxCkVdQbGZdxpjwmP20atHk/a6G/6vmy8K?=
 =?us-ascii?Q?hyt3WOxGohI8IiMvPfc6ujz8PrV+OcpHL8oTCn82zgdQRJ5vVX7dFoGSkoMF?=
 =?us-ascii?Q?qmakYsZpr4tWk97kqlyyE4mGF4crjVnUf05SRfXlbIr6sbqRSjvF/GLEHY2G?=
 =?us-ascii?Q?/y9ns+cHR3rHP73UGuzu4oXuiXuglphLJ020Y0qtyVPym5SHbESWRHjxzR7s?=
 =?us-ascii?Q?WDLSPjKfoSog2eGh5S+Rfz5dwQShO073VNuooo1Z6KxVBw8tN9H0/7o+iV18?=
 =?us-ascii?Q?jmmRTvgDpftlHa78z1BLnYIGGXH3XUvRaTzhpZ2jIF88qZKXS6D8TF2ReiBj?=
 =?us-ascii?Q?tsNIHqb8t4j1YTr46VztpGqc/Bi1Mki5xeJHbwtTnCnKa2rAFOdCpgb4Z5va?=
 =?us-ascii?Q?kST/E1+h0ZcmjahG1E5GBuz01cHf8ldP7GOaNOeqp8PSIqSQCr3rdlTYjI6h?=
 =?us-ascii?Q?7uMdLxIrVWzc1+Jrbniq96pvE3SIiCMsCafv9+uUxGO3dXWVaX1oV05rE/wy?=
 =?us-ascii?Q?UpSDeqd57wl3jrpdRq80mLwJ5nDoTclVRValN8iFw3NvgnUAPXtFJfoOomoB?=
 =?us-ascii?Q?AtUgNS7UszFN3H5wP+izJxJzmi7dSHnLW2fY7lZf2P8Il3pDTj3Xflk3nfWH?=
 =?us-ascii?Q?eoD0ERvmTwDEIam+Dtoc8dDkek12jwFMrXbsOnMDQ0BO1MpNRI+KN+jHDvFk?=
 =?us-ascii?Q?pNe6V1Y6WCMq1sfEK6xX3bxyBx3nsArA8hr4B9/Kg9u/EUPgGxLJ9wbICkF3?=
 =?us-ascii?Q?qIoGuNOrvj0QzA+yeThIQPwdMVgd7KKheQciPshz6thGw2nMQnmntiPmzImt?=
 =?us-ascii?Q?81J8XtBYy+Jk0/h7dmhRMbYK9mnbYMFqpssJBH6EooUEN8VUuvOWg+w4qYY1?=
 =?us-ascii?Q?bXnHDx5aqRTMUyrGxAxlianmV2HP9YuivXBN6bRZNz8ZSRoFc1N+LSXvN6g6?=
 =?us-ascii?Q?+IImMzf2JMsacrK3G++vD/StGz7YGnga/Gpqq8xfWeDIQWRpbe1/LgK/7KoM?=
 =?us-ascii?Q?m1BODkTAFzpi+roSXA6rSB8N2qlD/R+bUc5aV3uc2B3YpqMl/4amfW1lt7Cf?=
 =?us-ascii?Q?GL1XJ96TtxkHcPwik9npaxebCE+odzVWZpmic/4DhfWJptVkdSFx1ZeIVwH9?=
 =?us-ascii?Q?oWzSCsMqJGm+7O73vI8nTKqH2d1xI0IEjDbM60ZLn6m72bYGL9qZVuP8yZYh?=
 =?us-ascii?Q?KadFOpr7UfW2vTiGrbUAkV9MGcAeqZjbt8YAx2sLoFWEVCk4JEJnb531Flxo?=
 =?us-ascii?Q?xu1LHR7OYILFTp1wfe2xLsygsyoCu8KI/g5vCT3oUXzXtRUd6yaCtjlD6+Bv?=
 =?us-ascii?Q?B+92iJPu5t6U5x3nHa2RJkf7YjBlQKiDyh2V4w4NMGBICQ9sBmDNgiN66cp8?=
 =?us-ascii?Q?VRGorFpOv4DyN392wY2plF6GtNIUa7dbo04b5P7n/EDTbxFZ+Glxs6p27PZg?=
 =?us-ascii?Q?Lyqq73Xs0INjPX+sjk17Rn1Svmmpu1F4Q9BiofemsAqkAwEz2ZAoZYnbKCY1?=
 =?us-ascii?Q?7A5c5vGBlYUKRBuam6zZDEdPeKQUz0Q=3D?=
X-Exchange-RoutingPolicyChecked: iOZORh0Vvr0o085kPp37eUTwBIDEenq+UkChtej1Sc5NCAF0jT9WTPrtjIp/7JntuLQohQHqT5tvx0+4MNddVvv6JCA8zLIafXENH+SqGVb+Rjx1VnB6cTNqrjei9Of8wpziVNVYfc0mwCCVC5IehZS2kw0FKAs0euTq8lQ1eujJ4GJInw8Ba0DaJEgaOA6q+2Neyu/Bveks/9Uzv4dBRR1pIDeCB+YWr9gTGxgm4NLxjPEALuz4lbvlpGcgtG5UU0VirGaE4AKXqwW/z6F8Hjap8BOAyzT0j93ApGkQrN6hSyaKRUq60MNg8rlFSqjB6Nf7ubxH5YvVvuV46fvAFw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e56de25-e833-4ab4-e0aa-08df30522623
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 15:35:49.8467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFATiwEFa3TQ9XagUAv+u+ajef7w5eT0pZesEgETDdC8yTFFpjgiZ1VZkImZmbtmb6/7bx+Z0SyvVUBbFzpZjmAnecb+P7kYa5wtw4BF/Vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5918
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 14, 2026 at 12:24:27PM +0000, Dawid Wesierski wrote:
> From: Marek Kasiewicz <marek.kasiewicz@intel.com>
> 
> iavf_dev_close() unregisters iavf_dev_interrupt_handler() with
> rte_intr_callback_unregister() and ignores the result. That call
> returns -EAGAIN, and leaves the callback registered, while the
> interrupt thread is running a callback of the same source.
> 
> Close hits that window. It sends virtchnl commands (RSS, promiscuous
> mode, flows), and iavf_dev_interrupt_handler() handles each response.
> The handler clears the pending command before it returns, so the
> thread waiting in iavf_wait_for_msg() can go on to the unregister
> while the interrupt thread is still inside the callback. This is
> likely when the two threads share a CPU.
> 
> Two failures follow:
> - The interrupt thread resumes the callback after
>   rte_eth_dev_release_port() has set dev->data to NULL, and
>   iavf_handle_virtchnl_msg() dereferences it: segmentation fault.
> - The callback returns, but its source stays registered after the
>   port is closed. At rte_eal_cleanup(),
>   pci_vfio_unmap_resource_primary() closes the interrupt eventfd, and
>   the next rebuild of the epoll set aborts the process:
>     EAL: PANIC in eal_intr_thread_main():
>     Error adding fd 49 epoll_ctl, Bad file descriptor
> 
> Use rte_intr_callback_unregister_sync(), as ice_dev_close() does. The
> iavf_dev_init() error path has the same pattern; fix it too.
> 
> The sync variant waits for a running callback to return. It would
> spin forever only if called from iavf_dev_interrupt_handler() itself,
> and that handler never closes or re-initializes the port: it hands PF
> events and resets to the iavf-event thread with iavf_dev_event_post().
> A close from any other interrupt thread callback, such as an alarm,
> returns at once, because the iavf source is not active then.
> 
> Fixes: 22b123a36d07 ("net/avf: initialize PMD")
> Fixes: e35a5737a746 ("net/iavf: unregister interrupt handler before FD close")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
> Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Patch applied to dpdk-next-net-intel.
Thanks,
/Bruce
