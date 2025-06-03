Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93F2C5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 08:29:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74E294028E;
	Tue,  3 Jun 2025 10:29:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 45C5E4025A;
 Tue,  3 Jun 2025 10:29:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748939362; x=1780475362;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=C3Hk6gKQ5xBS9FJ4uKu9lynz6N0s616ZilozvdeXGbM=;
 b=OhTZRilUWYGwbuQsJ+G5SPEmTUkKg+a7MYieics4Uct1sxUP1BSAlk15
 dAPVgMmTHw3otVwL4F73i2mmB1r0W6PcAUJdBeN2KRzZtHgi/hLoFSNvP
 7tcpxib8yFKNlg51TOZZieCfGTGrIK5ycmc2MqKs32/zIcTgMrynUBxjj
 RgM69X2Dq6Eyj0umhsxHLSeNCyBvlA29YbcHT/qj7swn6VoRhcUSdlDy8
 skVf++iiHwZZ4hM7ghNnCZfW5i6TdSSbM2wXAEfVkM36miyvJMEj7xNn/
 rUr72A/IGmqMaWIIuxC89ojVu/M1Pj7wYT4y/QjcoTzntXoiYa6H+plZP A==;
X-CSE-ConnectionGUID: ywNKazbRQvq/74/d1omCdQ==
X-CSE-MsgGUID: K20ZC8kaRD6P6cRyA5bNfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="50091323"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="50091323"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 01:29:11 -0700
X-CSE-ConnectionGUID: 9dDt8nvBT0O2Dk/NSYUwHA==
X-CSE-MsgGUID: YrWK7Se4QMyF1DEpeosePg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="149836939"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 01:29:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 01:29:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 01:29:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.60)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 01:29:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6ctud2qDpG8npNpyz/KntlAmyqKshmcbLclAWMr73bAr9o19U3JWY9pEv+1+DM5JrZIVSxoQ5/kyPwQZqPiUr/TAshjw7iqLwcbztRzk0FFUdTcSsjXLAlrQlGrM4pyrOBGMEpZ/FHFRydodSVO/LDFQmaoTtn6sL48dbdkE6g3mEAYiI6bZSGhBGkKxgbdpoduaaY1pMY9Gp3KEPvMvKv6O7SWDT7DqBZdYkhgTcINksS37Hg14jklDo7hKPoViQxK9CFFEP7KescyOSV9d2rgaLy/SzvEm1TWoowN+9gTe1nC9QWH54L3WJGPK1i8bIUz+rnddcRs0LIWEHmVWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMMvV4oZ1ul2UAec/PhzazDcOgNSLKjOJuObWk0+zYk=;
 b=aZ5QOd5D4fpKzeY7zwdZIckZSgo37iUYQY+f7JCBpDL6JWfLuAH+UQA55bEjioVEzbhd6jypCt38CaCR3ckDxdO6DOnT5b15Zb0nbmKSWCjws4uZsiRkJhIXe8qebURZkN+cE+gUvI2y48N1SqqLlUxe4pp4Y+/nq10+mX+LcyzJ64IlCmEYPGCqzYVn/U4vSJ+p1FYa7iP4XZG9FJ2z+ceeC1jmBE/sZ7roaqrm1mFg809DNgVJJQtYJ87ng+ir6SQqb0poKFxkKshNb5tn2hI6ELjljf3kI+tlK4XLY07Av8/mKacwA22fc7XmaO9JaoQBAgqqr+LL5ao8XAyt/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB5106.namprd11.prod.outlook.com (2603:10b6:303:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.36; Tue, 3 Jun
 2025 08:29:07 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 08:29:07 +0000
Date: Tue, 3 Jun 2025 09:29:03 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Rui Ferreira <rui.ferreira1@h-partners.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2 2/2] fix eal/freebsd: unregister alarm callback before
 free
Message-ID: <aD6yTxLUgI3jxlPe@bricha3-mobl1.ger.corp.intel.com>
References: <dcbff1c1ee8c48598294306fe80167ef@h-partners.com>
 <20250530081845.64297-1-rui.ferreira1@h-partners.com>
 <20250530081845.64297-3-rui.ferreira1@h-partners.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250530081845.64297-3-rui.ferreira1@h-partners.com>
X-ClientProxiedBy: DU2P250CA0003.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1ab7db-0205-4b38-c26f-08dda278b537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AjLn5tkkP29tBdzq+EsaRw0v4gGEYO+Aoj1MYgQ+p05mMJbMVoGz05jOc1lE?=
 =?us-ascii?Q?q3Vx32fng/W+fGXzmVWa1eMxD3rAa7fyj7EBstVrV0BFe2QWb07YkCUGtqw6?=
 =?us-ascii?Q?ruRXm9yBsvIp5aXqHYsZOMgh3CEsyHNkIOvS1Z8lwzot53MOYpGDHAEyRFm8?=
 =?us-ascii?Q?GIqawHlsxA/H/QE9f7ULsF+kvP6yvrlckbbHbE21JUhQi/le5UzjfpdGKNw5?=
 =?us-ascii?Q?J6M9B8uuIuTq53sgcTd9JHQa/mT0rJojteclzXLkvYXcGo5sxz01/ym2D96N?=
 =?us-ascii?Q?+hovbUBMNlPr8pJOtpJUVAiY0s0HpqrvhQ2q3AVInLsZ5JHbF+NGsjira4yY?=
 =?us-ascii?Q?TXOZcEBovYBJ9jpfvBH67k73bm/9A6KTmYWKDjsR1jQqtVeqahAbvHy2fvYd?=
 =?us-ascii?Q?qfzwEr0ymSOWpnopKp3p4c6qfn2zI1pFwn3uPcYtfi+ZIEsk3+65vuhwrfqL?=
 =?us-ascii?Q?lv8ZGPbQ+CYfrdek8KYVwqHHv0XS0nGzGzT0NzotFbfjoyl+7HLbGffMNrl6?=
 =?us-ascii?Q?p9+DPrQ0lCVyKnGMked/eFkHUedXNwMf2wlStnjXOaD2XeGp5COEtRNwcNqj?=
 =?us-ascii?Q?cmM9Zwr96epdIvVeuoYTLZ0IubV6XtqwdgaLNwYAXbJ6kxpe6rOh/VkXhfQL?=
 =?us-ascii?Q?63MqRqDGcKzWsTcpCjkjaSG1oiZqWg6u6ubgPDl+TPj6wnMkgYgwfDoOIwsu?=
 =?us-ascii?Q?yMf5pk3q+lj1EZUmTnZ7h+U4esV15FG6ZwL9CgnipPdN673mCST+Js1QDYa9?=
 =?us-ascii?Q?jaShENohsIPrPlQOS8Yfca1StlC1+Lu3Yn2KMNzWip8CsKUeSWIjpbYxW7Wd?=
 =?us-ascii?Q?k3sfHxJupXsDsbtuBqq1Z+uGcvwBJMUwq0cHbdrqstQToVKuFXAoeQR0zNVT?=
 =?us-ascii?Q?YIhNkWuhrhlbwEu5rUNTGDl1RQk68roqq+u+Gny2nhoH4LoGGeMtxYr/0dMD?=
 =?us-ascii?Q?lhao7t/q/rA7SsYvyyqLlCT1+D7e+otO0QjMb0/DNAe9Otg1l0xkbltiVpJu?=
 =?us-ascii?Q?Cp8hC6QlSSNFbg8oaUdbzA3jBzD7Tbw/ajc/KBJIu3D0rWHzk7wHhNk93aiR?=
 =?us-ascii?Q?lYiaMZmYjOC8qkueps9bHHpKBvmH+jk9Wo8W5smk3Ma/xT60oeEsYFv3U0DO?=
 =?us-ascii?Q?TWFU178mdRuqJagm6Di9rNjjJw1yPBQU+P4Husv2TWUy5ydeisELtw8G+Gxr?=
 =?us-ascii?Q?vrN1sMyWnowAfkucMrGp4q8ILg1qI2qJKRqFCSa5YWFAErxkrsuSvU7QCUzr?=
 =?us-ascii?Q?OriOWlNQeGd3w3RXYDZGrsCFU7b9hsTt3aG7jNPeaPvVcmM/RRjv+aH6KfeG?=
 =?us-ascii?Q?n2Ui86Bbl9qeHlpbJ6brNL+vqFPbnS6mjQrwRjHn0/g2oXGb/49JeUQZVltg?=
 =?us-ascii?Q?7WDuKaozvfTjoTR6R7nu2M/JS8dTKRFw8LLmBjXxJq7LmpRr1gQ/HdTYUY99?=
 =?us-ascii?Q?XCpCfd9kLcs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yVhhZLH1WLQyOWJMMZ8HhHUQUTj/vnCsASX2ZgEcorSnyQ/PWDR4H7Y2x2DV?=
 =?us-ascii?Q?3q8gWW9Nzv/yLL0Upufkmd9Tl/tWlhWQ712j/XqYrWd3IxCpD0yACy0+n6Bx?=
 =?us-ascii?Q?pfEDsio11xItoNjUHkHiy7v2r7fPVT7FgGjvihTkrdlNURcgoOkYpI7+ixDJ?=
 =?us-ascii?Q?6aWDgenB9GGW6v7FVashv9vFsgfmHTI06D89u8p6U9wYNR/va/EIRuXflfbD?=
 =?us-ascii?Q?UBYH+G/fTPvhL8F6FTaQ27OQtcBYrCzG3qXaLL7DOqjPMgXAhYWCxZgt1f/t?=
 =?us-ascii?Q?W4Z5A6aIfOk/rgXp5Q9+Z2gO46kHw/lh+32cWbQSyHqbK+1abbIUoQPAfw0u?=
 =?us-ascii?Q?VHRqn+1TJtHrtcV0ncg2ty1vlVu8GVuJhYCEioTW5rcjM+L3k5N8QnprdK5y?=
 =?us-ascii?Q?bZ+0pm+uCTNCtE0GIg2X400aqGVgbkUIBegpGgxMIRCFiUpV2tqAN5jU/IXa?=
 =?us-ascii?Q?F1exQ9zjHX1YvNn6ZV9q4zqkTDWAvyKS5x44W8SXmQ9Ae+siWSjOlEKGQo0z?=
 =?us-ascii?Q?XqS0bcqBsa622Yp/9P2o1uMRyNSY6oebHNVWnxHvF930bdw6IVnZMNV/RWdu?=
 =?us-ascii?Q?V83kewSDK3CLjqm+XbENIhcJK4dnasvjsjCXjJjsEZeyTHnvVKXh7o+dJVWK?=
 =?us-ascii?Q?C0d8t8YEk76kfDcoJbFM7jY3QcpPYJUb4CTNtfQ0kpnqCFjkWcPrEID2Spv3?=
 =?us-ascii?Q?bsrhnKv92jditCP3XvTBzPa1t844JHjO9QsyvuFMcRvxEx0uNWdsi9lCuan5?=
 =?us-ascii?Q?totjSLs05J0LY24Lc7B62SHwSzldxYxK1MBBVkWp77uYjzC5Fop1MTxAlYKL?=
 =?us-ascii?Q?cQZNQN3qKfEBwcvtOsPaAiwUoV2QLtVxaV2ZrcHsdGMnBNhjIHVhThGQauRd?=
 =?us-ascii?Q?iGLTW6r/v8U8bLa6YJBX+c0eoyEtMsIf2Mkg6MrPvY5dQSptJYddE1OHUkDc?=
 =?us-ascii?Q?k+tHq9C3L0qekFRfSPitFLbqhCZN7dpUU6PVFOxZU+wc9U6Ydf6uVUF7mWx9?=
 =?us-ascii?Q?XP+ZUAATOiUpRGQi6OBZrKxHfJp4RRGV4vC6z2eikqSta5WFbjazJB1+VV6u?=
 =?us-ascii?Q?0K69B2ObN6YUtsZ9NrqSb+IpEOF/fcE/ekb8X1r5JDlMNzuvgTaXGPBApN1Z?=
 =?us-ascii?Q?gLWj2g90/f9KQStd7iLB/UeIQM889uLvDTI2n3u1sVaZkqwIHjSLvC63KzjT?=
 =?us-ascii?Q?G05eGAdXoXAtrCp7668IG+aeUMe81Nb3jLd2X+Pyg11DjnpjBTH6Rh+CeubM?=
 =?us-ascii?Q?V5a+pmzmHB4T86L1sLF76m2cnGxWLWPC5hF4zKC62otH87dqs9qtY9QhzvTq?=
 =?us-ascii?Q?k5rDHkqfiJFZ7zLKdAXZG8tovMroPdIHAgkoUuKHOVQi6rqnWK2YvaPo/o2i?=
 =?us-ascii?Q?ekrC9f1ayXFn0xCTKAsZqHka6hKmvlcZ1kGDMjUC2lnp9DoulSZRNTNg2NAX?=
 =?us-ascii?Q?1VUFaR7kqKsSomG931nMInI5Li3Rqddx/QQ3atGeWj39eYRWvMbUvkOdfy4T?=
 =?us-ascii?Q?VrdHm2hV8q0QL0uCD7RSsJRIvXN+ZnudIEvoo5feWtIKuBaLglGZF8Vw0Zfr?=
 =?us-ascii?Q?atgVMwCNrKKyd18Fzq+T2ztjhAFX933vkyNFrhgEZDkjltc9HFpnR280Sk6j?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1ab7db-0205-4b38-c26f-08dda278b537
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 08:29:07.7645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJC6FVHvpRAwp6FU4IrsSNBG2HJusJ8/JjT9YrcYBOPIHfoByu92ZxBfSC52MdbWcd0d8J1MWzDujbM+ZR0EPvo4P0mGsS9X0zS1gl9D0oE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5106
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

On Fri, May 30, 2025 at 09:18:44AM +0100, Rui Ferreira wrote:
> Unregister callback on cleanup to avoid use after free from the
> interrupt thread (eal_intr_thread_main).
> 
> To be more defensive, set ptr to NULL if we can unregister.
> 
> rte_intr_callback_unregister_sync may (optionally) use traces
> so the alarm cleanup must happen before eal_trace_fini to avoid
> accessing freed memory.
> 
> Bugzilla ID: 1683

Source of bug is probably:

Fixes: 90b13ab8d4f7 ("alarm: remove direct access to interrupt handle")

> 
> Signed-off-by: Rui Ferreira <rui.ferreira1@h-partners.com>

Patch looks ok to me.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


