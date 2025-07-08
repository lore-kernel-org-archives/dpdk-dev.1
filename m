Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD151C8303C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 12:48:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1447240B97;
	Tue,  8 Jul 2025 14:48:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 34F1240B92
 for <dev@dpdk.org>; Tue,  8 Jul 2025 14:48:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751978898; x=1783514898;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=YKiMySYTRIjZCc3+C+vZHxtOC8yu2giAI98Ad3EEnLY=;
 b=SrWAPcJGlEyGGMfImFA7iwlqlH9Ye/25EGBtFMdEQFdnrWLQmP3RBjwp
 4nOOy2VoetERvdE/EMPq/UeXZaho7Q9ey9pohIvcQd/GNdx/8KIa4lWpO
 etlmJ6PloIPqYPq/LJ8y6ftpL29BawWHJAupcLXPAIlvg6BGN/CLRX9x8
 abUkjBUd1+e6pV5+ghTrIPOwkZ7GwJdi9lCJMWEtxnbN/zHdP1SeCqMcf
 dFMClt0lBBisFIBcjOfJnP7ZkRFrWq8UEJ8Z5O2yQz8qacDRTPosCFvQf
 rgZgxv4bfYTNsAE0AJzN0n7PjHQFGtT5UHuci3HzS69ZagyG7izhvQ7Y/ A==;
X-CSE-ConnectionGUID: ZGO8O7ggReet5DH7G07ogQ==
X-CSE-MsgGUID: TK34HiEKTwmld3PHQkfktA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="76764116"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="76764116"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 05:48:17 -0700
X-CSE-ConnectionGUID: yp45m5BOQBG9zGJoyYpAbQ==
X-CSE-MsgGUID: oqWlwkFwSG2uFaMNNuiO/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="186509408"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 05:48:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 05:48:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 05:48:15 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.85) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 05:48:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wuIKQkuaPAJ8yn9LqJaawqFaPyggbyn/gtWeYC9LfT5jfKVjU1N7MQTAU++nWskxI6ySzOKT+WC1ie4khgTLjOa2N2+APC4+I1C6mAq4FW4wrG+9RFq8AUc4+9+G9pcNtfveDiUVj3k9UAmvEn6JVFWQXdUZsGVqT4mt1+gAELFqZjhBiVqpD7Nsx+hkwe83f/ywtA3taDsn54wnnHxMv5gogKW+kEIl7lI34p7ZXcpzvx2ofYXqnGrX3UAmc2bLTlcHf/pnyJQPsk2nZdFPgl2FwvQp0RPyFHmqAh5qidyHZ+9excruVoWInde676EMnQj/qjr2Q4CvHEqsdYkH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DR8U0S0mpsMT6Sn1EYftqyAHEd55PeLAjYDSC4wjUo=;
 b=Ink5M+FrtWqt/muq/iNB182CUYWFKb7K1yY8Fp0WdDLVhjzf7ZZk+bVhjKDhwe2U5v9OG6IEElYb7ZxSCJzuPjtrP/W2M6ORKNgf/7VbDlUti0AoV6oMq2Verul0R0WVE0Fqjl/EYDjzHLav0GeMHF39zPWcGCcho0C+DmJqwa8Hio1AzGSVpY73N8K3Fp8En6gLFCH4CHkUxaCWYzUc1Kqped29gD8epF3P3hAkb3sQm0X7vWQXxfUr0cQKbmDaM1iZVBruCo6uuF/3jiUuG4Dj97E8lMVpprsHPAyTxAtxGw2+ifpC9WlTWW94yusmYMAx8rktHsNNQyd3CV7uQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 12:48:13 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 12:48:13 +0000
Date: Tue, 8 Jul 2025 13:48:09 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 17/18] test/raw: fix test without skeleton driver
Message-ID: <aG0TicxbRUl_9KR-@bricha3-mobl1.ger.corp.intel.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250708122823.3406288-1-david.marchand@redhat.com>
 <20250708122823.3406288-18-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250708122823.3406288-18-david.marchand@redhat.com>
X-ClientProxiedBy: DU7P195CA0027.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: 732d0fb4-ba01-49ab-ca71-08ddbe1db39f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fGCY7zhdFjQwAWO5JTx06RFxIbCLuU8zk4TaWNH1knSYTCGnkpbm9f4TtGEO?=
 =?us-ascii?Q?Dah4PootRyH9GWdZC4jtQDAW//8BxGb7P1AUMIES3ZY7190QlT1O2gHspVNk?=
 =?us-ascii?Q?F2MQWJcw2THTf2G9oJb49uUk3O0IJbhu5n1kVCcR19JimjXjwG8MF2zwddte?=
 =?us-ascii?Q?z4ll0P8upNLKQ1YYwxkrNE1IXKmyyI2eOyBD5zyNf8dkUsI795QTXJgLP+l4?=
 =?us-ascii?Q?PrVKzoVhqQCEQU6sf/X57ZfPnTCer3jSW0FpCOwFzv2QXQvjMV1SNdFYiqKv?=
 =?us-ascii?Q?sBrIHlJzBiTFRhDPuauO5z2v21UjN69fu57giJxHJzXrGCOUmNNe8ZPzTAkF?=
 =?us-ascii?Q?gOVOYnTKFdih6aUIhCZXzo+O9Y3jbR7/L5wvtc8xwwzNr6SYkw8RlwWCe0QZ?=
 =?us-ascii?Q?GnEVakfk74XaXArf6Xf/4NsouFk9Iyx4CvUX9hz3tKElKh1jO/0CwMwRDnaJ?=
 =?us-ascii?Q?H6ZUXj9rGsMTJQ9VCYkWEVq0337l3FkEudffP7+bYQi4ZFCyIfwWgZeEUgRh?=
 =?us-ascii?Q?tRiH6+s3jpl2Iga+YmLPBb3cUaK2CXZWz1vVTPLkZgPQ2MJ4XwbcT493i7Ck?=
 =?us-ascii?Q?iCcMlNmFU2dAwWgWTzedR74PEiSmmEuqIicIBnRJrv8NfFSRE18FRgHhkLc2?=
 =?us-ascii?Q?aqvdN08tf3hzk2woOhHCqVSA//W0d/mOi9ogY8TMBYLyWEC2i1Z0JvTWLP9D?=
 =?us-ascii?Q?vUIxaJo96X+UaR5QJCnl63yYIw31EJ6VVAi67WDoYoyF41xCZZrtTChAWcE2?=
 =?us-ascii?Q?s/F9e22b1h60ZxFm0vbrMI2FbiR+RaLozAKP0MH4SRW25qhW6NwbcM12IapL?=
 =?us-ascii?Q?il991vtta1y1+kHsYisKb9avlKgFebd7D0G+5VbDDhu7cqHIUrbjiD2zNNTT?=
 =?us-ascii?Q?3Kl8JR1SWGyY2YT/temHOqzGj1xq6DMpDVeSkE66jkEmR3YhMVTwrdb/mC/9?=
 =?us-ascii?Q?y9xJPW7EsWQZ9+1uIPUSgVwCK0l5koYix9n2iaebO/+yc8AHIgZ36Y+4sV/j?=
 =?us-ascii?Q?q2H4gIFG1U/BDfoD7oJrKI5hvxbo8y/iv+gFxYG5YWDEpmBgKbylTjY6K3gf?=
 =?us-ascii?Q?x1ZYyA6K8m1wzWOWeJ4h2ur0mahhu2s2f4EsvgYjCA4KD4Npooagx6w69y9N?=
 =?us-ascii?Q?J6sYYONtlrBw38FlTMfLBprMAHOw6if1JAKI0GUEGwIM6yjkkcRiUqkduTLz?=
 =?us-ascii?Q?U2vUTfpGZMhGZdZAnW8j4pwntEVjTLqDyor6e30pDud+cA0EUpGV1YJ7KF84?=
 =?us-ascii?Q?MDLLMF84yePl7wgEIY+d/DwLVBZywCHybbRvjgZt8MSvk9iHM5A6j5TSeA3J?=
 =?us-ascii?Q?gL32VfhErz5H/FK0VXy8MJC7V9UXixy/P11oZITPGIf4YG5jqHC+7RlBktkO?=
 =?us-ascii?Q?vsWMPSiakkyH452tBBgaoIdsBVZziKHsfYcGzkPQiHa1JJgqtg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VlP+i7H3xRMDBavb7yO8hcrxDiUBe6sCNyirQxK0G9Ik0b651KwqJQCibnkj?=
 =?us-ascii?Q?1+a5qVn5lIsxV8dFERTchqNOhJGQrkYu0jkDvVhmnNIuAhFUlGC2+Y5fnVqZ?=
 =?us-ascii?Q?rG4VF93rZZcmXs523HPEBHb45/6to8KhhXOW4nEk4oGK7lUyHajYWi6uXG/9?=
 =?us-ascii?Q?WxndvILUebKrxrMxyMPzF1uLTx0qzjcURjYQO0r5hKfD7ueWfQl4OnZ3bYbJ?=
 =?us-ascii?Q?BZIh5Yd8ueJ221p7Bf4ID5tovt1rqAix4iiB9ao4yYoeePSByGB9d2/ulOp+?=
 =?us-ascii?Q?uYf6XMo8k19y0AmkGYSFrz2c1oSEbfNKIxbTiFWh69CTdIA20FAxa2jqwamg?=
 =?us-ascii?Q?3eryj5/xWdrsz0XLtmS9pOciGdf3+ktTBFilCRRrj+uizSsvM8lOhUt9/CO1?=
 =?us-ascii?Q?KExIyTsLLBmSt53/Sb5EBafXv6jvEEifndMCfGyvCNtobwuwLPzczCaKbwT2?=
 =?us-ascii?Q?fgY+Y90wupMDbrPTAQDWe4tgN5CTpKRg/jJnCZBB1IKXtLa1s9+fsU81FXHr?=
 =?us-ascii?Q?MPZSDs6oGye579I4cNEfBpAkeiXa6+b+TDJwe6fLfdelJ0UkEf91T4eDWHnQ?=
 =?us-ascii?Q?Y/7gQRZW5rsfWUIG9ySCIKi8byn0GgzxyZGG2ahAb46mr1icpMr+5FWe/VCY?=
 =?us-ascii?Q?h+7ysB6z0w/cJ9yaKjAKpKyTugOijlLrJnjcPPWFHXcJ1YDOL7UMj/vctSrI?=
 =?us-ascii?Q?BDX/9N6JSsmb/X0sqfyBSxwLp6mh0+Q6IEjGFjQfUFozkG/NL+YJyVHWP3Ju?=
 =?us-ascii?Q?FKwY3qqpDpKQc5WvH788NV3iFJ/UKGHvEKQTyEed743k6o51zqkJY0tTgSOO?=
 =?us-ascii?Q?ZhnML0F7qe7r/W68z7zluCdikQx0f7smt6ihtCupamZqFamxezmkuL2GxjWi?=
 =?us-ascii?Q?x6NF38MGJkVb/uACghhnpGW917xz+IeNSsSuiY+jKtn1VIoyALJmpAfsMSR7?=
 =?us-ascii?Q?YgcZ5rztKs9zvmzStxT4jlrXkAMxWcn9rkdOo9OIcmUJzQkhZ2Q5sxiGiqWb?=
 =?us-ascii?Q?p/vjodwQJFccU1bosfvtCS9jlPDUhemwf6WGpvL/eZpORIJAWOaW1kGwa2H4?=
 =?us-ascii?Q?XuCZrdrHuzQGXz7RML6Ck8tssI7WXC6I0lmfVKIfoBK+bZIqd9EATk9jo0Bl?=
 =?us-ascii?Q?R8eiEt9tRqyxtzGcJWmF/MwzIcl2t8qIETVI+hfVZ7aHhQ+lSKairR6puvOk?=
 =?us-ascii?Q?K7rOlmPM79wWv48aCYOm/6qJOxtblas/EBCiLfnB4iZUo0BahQ7MzX0SQjTa?=
 =?us-ascii?Q?quwxMlyJthgnJDPARwFFFx49m1BwN5ZTkjWGz+2FHyOAX35po7NqROfu8icp?=
 =?us-ascii?Q?MjgNWDaFtuQr/47dNSpHApdWFQo1kEOI2i/nksfTDiFu+rEZtclfnOZmf40g?=
 =?us-ascii?Q?uUHxEYI71mrKDeMvGY/JM97qvCfT78IbkSc7PpEjxX/a/I1HXduGxDRG/42e?=
 =?us-ascii?Q?NbaIsjcV3kBalOPtLft5xWoV5k/bj8KLQaOaBixtUu/HZkxyDF0LpaKMjrRQ?=
 =?us-ascii?Q?eagZnNygxuxSJNb1RFFLbZBUf8QW3kpgCrKKQc4dBdKGnlcxxjewDREIL2H8?=
 =?us-ascii?Q?2Q4zJ3fSyTB102ouLhBnLJgTA39JTLQir2q3Wj+D50eIloBinpEwbmIrCUy4?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 732d0fb4-ba01-49ab-ca71-08ddbe1db39f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 12:48:13.4584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QSEs8B0gaDIyY+iPs+E8fJZGa8w52dVLYrEXsVE6n4HQQvPazsrPgd0WB5XQ6fwRQL6qG2RxwUN0220DSJPhfzgwN2dr0p1vsjva3+K4XE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6682
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

On Tue, Jul 08, 2025 at 02:28:21PM +0200, David Marchand wrote:
> Skip the test in the absence of the required skeleton driver.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

> ---
>  app/test/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/app/test/meson.build b/app/test/meson.build
> index 79d635b42b..8df8d3edd1 100644
> --- a/app/test/meson.build
> +++ b/app/test/meson.build
> @@ -154,7 +154,7 @@ source_file_deps = {
>      'test_prefetch.c': [],
>      'test_ptr_compress.c': ['ptr_compress'],
>      'test_rand_perf.c': [],
> -    'test_rawdev.c': ['rawdev', 'bus_vdev'],
> +    'test_rawdev.c': ['rawdev', 'bus_vdev', 'raw_skeleton'],
>      'test_rcu_qsbr.c': ['rcu', 'hash'],
>      'test_rcu_qsbr_perf.c': ['rcu', 'hash'],
>      'test_reassembly_perf.c': ['net', 'ip_frag'],
> -- 
> 2.50.0
> 
