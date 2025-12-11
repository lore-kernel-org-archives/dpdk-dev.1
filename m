Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC6ED3E792
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 11:59:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A75AD40DCE;
	Thu, 11 Dec 2025 12:59:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id E276140285;
 Thu, 11 Dec 2025 12:59:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765454347; x=1796990347;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=wVi4f6D560kalV6QMzStUBnqOJkuQC18L2NZsOTCHS0=;
 b=PVUEDMTaWth7RpaXvytM011JVrqDSuhe5pXm23GeGUg2nQp3wrpuzNmz
 FrUvTsjJHMoYeiu3zEwOiO9naq0SUwgMgYKKjMrzSMZYXh7ZQ02LHl6vn
 /hIDBITW84Ke41JSmHtgxGK0aQglD15H2ZkHePeP8Eiy26gek+wetgk1c
 Wqm3XZr1drzt+DPm8K0hjdLzufPCnjDJjZPbuhyZ2rthTYOJN8elKeNx7
 7X2rQfsaGtxyPHp7ILX6zfNa2KISsGXHFrmDXKeLDg3O6sG2kRMJQI0ty
 6XxLw2KKUzVsH0OqdNqvBa/8oncL6GWbFL0HFSfLzk2bNn/3PpEC4puHA Q==;
X-CSE-ConnectionGUID: 4HtJit7CT7ydyLQbhwzFRg==
X-CSE-MsgGUID: QuLaRf4QQ8uAtPpiKhHqYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="85040985"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="85040985"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 03:59:06 -0800
X-CSE-ConnectionGUID: Y+h9zUq4Si6VGoNyZUNU8w==
X-CSE-MsgGUID: XvpJQiELS+aqqHK7JlneUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="201252380"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 03:59:07 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 03:59:05 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 03:59:05 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.17) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 03:59:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+cijK9GkywgHf9sxK29Qww2m4IMESgEbmZYMENHoP3MgfLQ1a1nhVw+C69uydWZ79nyWS/1XOO5k8lfDCi6OA67Qw+Xrdwt/ae66gfrzUtZF+yGpUJukyQ7I0MigP5ZokGUP/Md7RL0HNbyQSzo7xMnsbR2BAVlFJEDdvO4iUfIH+t8uNgR44wKZUAWiwfgz7TGldYWZSHcxBwbZC0NPVaCVO6sJ3MG1I96m7SISlk76H6BQRpgrMQYBQ+U4E2FXTVFlJLFCe1sY8UG+LtZ98rXylxQMHJ/S7aHVwenbQ2Rb1aJC28lvujqojJbVIhN6Z9tn3DLK3UOTQXXIER+kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHZrcmYV9/BgjrjhHafYe+Qs4T1GPsIiRb4rpQCSg9s=;
 b=qPCPuhP3ls7Tt0fGoDyM1BvWX3qDIBUTtaswwveKPz2vDCOfdt5fTHB4aKfkaLJiOWfM7MqfoXVJI00bYbWpbW4TcSStttyT7n4bqjyMe09M4nfAg8o+kQPE1JjzmQ32hat7YMfosLQYK/1Wj1po3yTenUpf+zEtElGsrY4bYwieCMWM5MX3PujIeHh5/bAtcNyiq4RWUJUjRFCDJJK2OJLZPtvvAqvKkc/q+lLrBQ9TGe5QltCKw8yyb2cJ08fmxuyOqE4eojRiimDXpNin8Ra0uqkKd+ABUBNzOVbKSkQt5z7VZKG0p8WaYBRvlw6jsh0maNqV7o2C1uHq6FEbFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA4PR11MB9441.namprd11.prod.outlook.com (2603:10b6:208:569::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Thu, 11 Dec
 2025 11:58:58 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 11:58:58 +0000
Date: Thu, 11 Dec 2025 11:58:54 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 11/13] docs: fix TSO feature status in iavf driver
 documentation
Message-ID: <aTqx_tKK7bp7mKlF@bricha3-mobl1.ger.corp.intel.com>
References: <20251209112652.963981-1-ciara.loftus@intel.com>
 <20251209112652.963981-12-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251209112652.963981-12-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA4PR11MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f70522-5713-402c-c38f-08de38acaacc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iTe1y4zXNpHkaTcQr0LuhIG6d9nznDF4eqD0450wa/4SVN255RpeFtOM45e6?=
 =?us-ascii?Q?r+9jILTqq9f/aV/IvL3L8TsqZxP7EtghiwPsyxX2amu9pMU5wdWFHyCYTvcj?=
 =?us-ascii?Q?dJinFMQTlSC3UZKZ/D8t1cMvkPh5L03HQCeOoEcCw86Ezc6ZHj0z8w17R8I8?=
 =?us-ascii?Q?r5eGMUv1Aouk3Hd9B9EQ06FO17T3q5fUVPD5uQzN6ZVzwt0VtppMuaiu21eI?=
 =?us-ascii?Q?OZOB0Ohr5PzHQYoizjHRdBNqCPwY+iz9kAh4ht5JQx7gJunGGONqHDyPgvWW?=
 =?us-ascii?Q?4ZeqHquEXWQV4MDkJwbKO28y3LfLXh3m1usoIXugKOQ4mVSXTB17LYpw1fDg?=
 =?us-ascii?Q?OEzR2I7qewXcrywY/Yecl+lQQdbVGe4JFq3cM761zqRFHcd1m3KMWG7Wd70O?=
 =?us-ascii?Q?dVRx0C7X+f9EHCTX0oWnRoWpElJbB8jSlq5uo4xyQreKWS1mWh3DtEzxOdbT?=
 =?us-ascii?Q?vdLFo23CYCSpAJiMcBDzB7QCfFsbnQ2WHG3Xl0gawTuEdu5K7yU14NjsTOk9?=
 =?us-ascii?Q?yK703C6H3yWsJZCxnOGA9Uam10nn/BhAxtO34aBRXOykyJMVF1nVS1UuONFX?=
 =?us-ascii?Q?5wR3uR0+ZVLoq2vYnglE7sMSn8xJv6jnyL+HgpIktDttKVlhKgBMr5uhiBdj?=
 =?us-ascii?Q?fD+x5t3Q72WgbNVzpaufFuYY3XNyV/qD0V7hpcbzyc60K/hTLPvKKJmG6qUR?=
 =?us-ascii?Q?TNIRULuDRHz2xwnnzMCwU9Phvj4aed7l/BrtTwbIFrXzZJVsLcFNOr1GLejc?=
 =?us-ascii?Q?lLBQ6SDwe9E82rk+RP68O1uD18DFkLDjKUqiLSuZRSIhwNnxqlDpbn7XeKA2?=
 =?us-ascii?Q?pAHGO7IZecUSMir0hI7qfi+EsW6jjF+MctyePR5rxvA9r63DFzWgTifLdpse?=
 =?us-ascii?Q?JD823rgYp+mc3BrAeOQNAHTIEu8xuY/JTPa4NfL0t9dRIR5HQKDhq5hHmGng?=
 =?us-ascii?Q?pUPUxlkHAIwj4EhlfoeP3btFfEyrdrU5T0Kn79Yrvtoo6fIIkCSEGJzSsnli?=
 =?us-ascii?Q?2hlhsGFXKFpQPV8MISPF0bLXT3hccwVg+S9LRynYayipAol2yK23gI3VJYBw?=
 =?us-ascii?Q?6yooe/HTeVo6qv+YjbhzwhjQpVKGHLUdqPCaATVbyZnbWfbUO2q4YydQUdLV?=
 =?us-ascii?Q?z4wG+yPW5ZnmSM4VzKHfRUnWLlBuWF/YBgqSGhWvRNbql3c7y6jSZ0pQOr+q?=
 =?us-ascii?Q?XLXy00R8D0X5Tojpf+n/pSTg58qYQgBIR0YT3jwqCKZaB8RYxOLVetmq2Gcq?=
 =?us-ascii?Q?pIPw0CdEwN1hakvQGGLJ4cbz8KLQYDaA8LMb9H1VYNqG4epmknpIQ50Z7ImN?=
 =?us-ascii?Q?LjaA90MUX/DIsdyPINL9E2yqT6gb7EPy57szjTgGvkfA6FK3v/ccZ4CMjmBx?=
 =?us-ascii?Q?CbzZBJL7JOdT7eYTp7kJ7GLZCgpBmQtfHsnzcnyn8J8utiFqaAbbrLmMIZa+?=
 =?us-ascii?Q?J66Xt4o2iIT9iUfOx5nkif8v6jGzd0rA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2bS//FKp7hYrKzivR8jQ3FdyoeJ7/EupgRGRuBTo0jtxEl5LTa4LyXgRl2av?=
 =?us-ascii?Q?BzX+W08qEGVP/vuGA1byMGOvOPxu+eaqJtPKXu7gg9bnHT1UrIH3sND0ptSU?=
 =?us-ascii?Q?dnJxak0jsmMt0cno26w7AmQ6bPvOQ0tB8PFA2dSaxDy8bpsQyPQmNrTlpIHs?=
 =?us-ascii?Q?Cv9dMA0zFzozldQYT9v3N1cn3z3YrARxcOl1x+e8jNvgQ1FClMGSKVdkOIsO?=
 =?us-ascii?Q?7RW0BtxJctpXZ4MZyhB5xrjL5kLnBT22C96jKw4XpfNmAbnbkaTHO7OuMA8v?=
 =?us-ascii?Q?ANfqnBTN4yL5RzTNwvJJ+SYoQRrt1sitlnDk7eah+hYcy7EnKAn5eIwk/vZ8?=
 =?us-ascii?Q?ikY3TrkWgtHpAOEdrfEvUddFqXxrp2F9lLikb2nk0+RYWsU1JBeGKaloDPEy?=
 =?us-ascii?Q?sNttne9cQelrsopF2oeMZA8MGVUUHVqdOvLNfbZEmuzLpJbvmFKBQ23HB7lQ?=
 =?us-ascii?Q?VuG6y14Ffn+eBBA1dP9xs8p5N5cf0xi+OfT//+FlFC8ibfDaSUrFX8AMX7BR?=
 =?us-ascii?Q?iKu3KWvPHohPR7KdUFes4BhEi9RdJulgqRE+4tB675A4SSYuGuC0hhKydRg3?=
 =?us-ascii?Q?jtlHIMUefdrHIOJle9Hq3rrGAXaLvBvrTdjgD4sGxGbiywoZjs9G1QRKqW/u?=
 =?us-ascii?Q?7pjRDjJb5kxIYm9AyadR7VE1IdjnArxQ1jdXUlAlJwogEnxXP6lWOiTv3ar4?=
 =?us-ascii?Q?AcOTdI/Y4dO0xQDNNd3jR+T2go8E/72NK458xjnqdhELjOHnjEkA+WkV1PeS?=
 =?us-ascii?Q?UZONB2xULL70FVNY5daITgCSP6fRUwrI0p3odNqBKB6cIQjqZsXLurGJ2jgC?=
 =?us-ascii?Q?fuCQ2LaOs/+HQHxWbemiWwF1WCm8qMtA+5/mxIjG1QJ9DfkqnjbJCtjSjtqx?=
 =?us-ascii?Q?pT7L4zyeMz9T4SKwwsr5Pp4OWXqtaIpnUvAbhFBKuAvX6WozEKtdsNm+0N/O?=
 =?us-ascii?Q?ji/rKHZj6pjGatlwMbTFQ+ub1vu1vb1gZ8DWQFzvfh7gOOYpOlXgl4KRz87N?=
 =?us-ascii?Q?tXVOpYbmcsQS6jGvrg2uiqKn+DhlTEOOEfMsQlyq3ECdTGxOe0FXbjKesCaC?=
 =?us-ascii?Q?mSO39b0hm+77T01FX/MZaYAlvrv2f5GlSd34f/sVtGn7eMrXE0/Yt0KKNBO2?=
 =?us-ascii?Q?wzGrqUwU7wUY3iF7ZVwCiljInsmKCmCCfFW39Yq8SbG59kp1eaD9KsPY4YKt?=
 =?us-ascii?Q?zpnnDG7NXhYwlUlP1RQpr0CfqtzDhmidvT2+QOEF5UOAi5xcb1ku1DjKYYYa?=
 =?us-ascii?Q?rzy6GPMcyC1yFfKznfjS0S6tDVMri9h5Q5X5ivcv9BToLn/VsJr/tAfFY5Dv?=
 =?us-ascii?Q?U2SKNCDsAz5q1cMeEFJNSqN1ok6zAaN74aJOyf/742iQkzB/ijNp4Cv8hvM3?=
 =?us-ascii?Q?53GMsCc9HY/vGnSPLMdhQ6jcYqGNs+wKLHUf1PqtNaUM8wq0+ewbhL3Qn4oD?=
 =?us-ascii?Q?9bjXJ0xZjdaGj+hEeUlf/rfjCCJLzeOioA3p6AeEfOzLDQJhyXGvFVedJFau?=
 =?us-ascii?Q?MA7MOBL/3Hx42VW6nh2cjxe4Pq8miiFPSg9HnrmrvuIdaY6eZJ9pH8t96YIR?=
 =?us-ascii?Q?8JswEM8+Au2eh7TZjF6/qMZBwllIbiqH8V9P7QB93/uNSajrKP65vSp3bm6X?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f70522-5713-402c-c38f-08de38acaacc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 11:58:58.5397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YsRiZQAXSHiNVXMCoQFAkF6Oma0kn+lad6g4U52pPz2UmrlhCUEXfA5qyABFhvduCAxGCvat+2oNRuIQD0YkqZunnhey98Pew6JCFwyWTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9441
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

On Tue, Dec 09, 2025 at 11:26:50AM +0000, Ciara Loftus wrote:
> TSO is only supported on the scalar path so change the status to
> partially supported.
> 
> Fixes: 319c421f3890 ("net/avf: enable SSE Rx Tx")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

>  doc/guides/nics/features/iavf.ini | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/guides/nics/features/iavf.ini b/doc/guides/nics/features/iavf.ini
> index 7695e3ff7c..6c9e97594f 100644
> --- a/doc/guides/nics/features/iavf.ini
> +++ b/doc/guides/nics/features/iavf.ini
> @@ -17,7 +17,7 @@ Burst mode info      = Y
>  Power mgmt address monitor = Y
>  MTU update           = Y
>  Scattered Rx         = Y
> -TSO                  = Y
> +TSO                  = P
>  Promiscuous mode     = Y
>  Allmulticast mode    = Y
>  Unicast MAC filter   = Y
> -- 
> 2.43.0
> 
