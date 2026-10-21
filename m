Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B55606A319
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X6MrXi68
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 689144066C;
	Wed, 21 Oct 2026 12:19:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 3E47640041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 12:19:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792577962; x=1824113962;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=mCVwxeXtXWNRYpzSyodqDBYJbF1MIz41B3bOoCwcPDQ=;
 b=X6MrXi68qH8iLyKeN0OC7iJSL9BH976DXSIZ8TIeUb42905e12jTZHd+
 XLFgwZOu2puGJxHfhsW2IREZ3N2p2o2RPCDB3xOcTWdrD5fAP9zY1nK19
 dFEt7j8+ph8Vy7IzNKGuoG0vCCYn6hd7EKqn0KUL1xYIk5IxOuxSpgfa5
 7Gu2//OaQSZnoxaWZXpqyz1X+TN9ozEr15ckj5NlImjvWcJiOlqeEPwf+
 4pr1KePfwAPy7pYiSL+hC+2SAMl46ZgNnHBRX5k8v3xGwWgeLtWIPJ1p0
 2ONBxmvLTSexBPJr6QkFq+pQcMp58PLEENfNfkwO4lAs85pXQKADLpz2T g==;
X-CSE-ConnectionGUID: vnD1wZS3SjyfPXqb7y6oCw==
X-CSE-MsgGUID: aPZqR5dKSxu73u0O5WjUUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1309430"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1309430"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:19:21 -0700
X-CSE-ConnectionGUID: RNg3YqJlR+O89JIAIddKHw==
X-CSE-MsgGUID: dWDYJNXqRjGU7q6+mnwiTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3401428"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:19:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 03:19:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 03:19:19 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.50) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 03:19:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghjtpZt8KKcLnCxQsskL2yAALGLzURjk25F2m7SmDzwnrUzusolu63AZkTncIczL24bwyoSNI8AYbujx+/KZ/Qla/dyNCImzBSzoty1czQ8y7q8iDJBUKjN57k/qLlfIxsK9Kynw6YjlvyxioOlIlXj6pSJWZ6bEKatbsExVFIUBoQJh2AHlomvBuNgK7ZoQr+zqG+IzDJzQE/YLnwoS/pNrD1u/h6LqIS3Ob98hIWinSX5BSU4zwnC4MJWC91dCJxPpzgHMIxN1C82A0Yv1OEEN3yW1wvKEiQd0BXPkaELQhvDccV50rP4IDAxQ5MgDmWUxsbm8RwILRxhb3QOVWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=716borY80IgOXND8ramNKqtB2bhCpw4vfZnCxU9SMEA=;
 b=H3IR1Sdjo7E4RUYivrPhnYoLajLHjK6nm8zzz/audGALZnauHdjIolk+3Ld2dLCW9TAwS3Jf2/ZeVvKJfNZRO900SrduCEM9t40t+BwBb1LAuAN9NpJklkrhQgRxC4MC+BdkFFfSjRrgEoo9PIsFOZysRsf6+wtnNjiIAppxnudHS7KEVYDGzMEJ6OH0WTwDVS+ib9De+N3ipiSKfGDyVZJKjexTGY0cgqSMsKyD1HGpBOjMJ0XqkH7kDF5ZrOjGS8AYgMEdko6Zi9Jgk+a9dpMCd+SQvizXK46eYmxG8dHdqkxqQJuBNIfG93h7IFxgr5jZcfO7bOh76dJtaadM2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SA2PR11MB5196.namprd11.prod.outlook.com (2603:10b6:806:119::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Wed, 21 Oct
 2026 10:19:10 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 10:19:10 +0000
Date: Wed, 21 Oct 2026 11:19:06 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 1/2] net/ice: remove unused flow handle from engines
Message-ID: <atiRmqcPxxfK9RF3@bricha3-mobl1.ger.corp.intel.com>
References: <869a70bf8e9bb8ce36de57ddb46ea2d44d7b9be9.1792577695.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <869a70bf8e9bb8ce36de57ddb46ea2d44d7b9be9.1792577695.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZP191CA0002.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::12) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SA2PR11MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: e2054a19-ab56-42d6-3683-08df2f5cbf87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|22082099003|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: gXuM7zTKCkj2EEYw+LhabUNBypeqvAWEkZ/EZnyU4EaqUd4vhPp0/r+X7ZY/FooqAud4/r8ad7nxEfq/LMVO+Mnm/ixspxR7OLLBBeo2NMaFMzTTOPjaWRM/7I6D6H3ArmkkBVTF3Gjan0HK4Oe36cj9z4ib1Q2pTf2CWGrtMBmpZkxNKDKN/ZC0K9b3XytPlzz7FMjKrzRlpNPaf4aJSED4oDcVXOAfWpU2sd4Pq4SDDCarLJvgiKG0OET+dInuw8BR/DULnVGUqP77xja23tfq9vqhfvV889ATeuvxPmwyMhyv4yHidMnqZ3HEqSoPeHDBHLWrElZ0GpG8ZOTZLf1naouCSaETFDUgxwrO7PrSWtWPxJPUKSiEs+wSouEKk9STHSXM5IpIGb0qRdapNs8rzsnpjRRWsn5ahI7OUu2JWP8K1GSbtwh5Z6kEH8kEEnAyvDx3MY/6CBKkFyK4mQ7BoPwZSKEDIxt/EFs6qcknIYm8RreF3jLvzZzo7oWMaFaAypeN78TRGcbw06dXbQV14q9UMb67h/NOvYM8KYnypdE37L7s6VGVBe4BLX1Q/XNOfZS4swgFFAvJrGM6xCG7qZVqOcfgka3kkNGWu3oirFhWKt/2jWTL6WrqXT9qPN7NXIU82G6QJ0Sz1ySa3HuELpgN98c72CmtdKNHGxA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(10067099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wrKmk8ry2lbVj+3JHQ6pYcpkum7uvDoVl2kLBhwgUxFI5q1P5Mb4g5V71lmT?=
 =?us-ascii?Q?WLBA5SkTGVWanyzXpdIYKOrPna9VFdfGShaIDTE3WPwxsblHbAF9jaZph1Ya?=
 =?us-ascii?Q?u2qyiTAgrKFjYY6nuMQ51QxUt+oi+6JE5+z/6JJBvxnA6eN37Bz1wgQtX5zE?=
 =?us-ascii?Q?10+io6T32Li/xDnTCDwiBqf7wcS5UffxmcgeexaYZM+mxGhqKBENO9RqvTpR?=
 =?us-ascii?Q?enS0UCOl5nrkzX5t24ylej/mY/ZpEeaR0ygwdceLLOL2Pmho78cGPPLLbxEO?=
 =?us-ascii?Q?bz1yaqs3ntIqKc+hXX/IMRK4DkHrnel6ToVXbZDUid0OVI2eSvJ+NLLsQGeJ?=
 =?us-ascii?Q?xNbqsrH0KiXW5C5jFAkHEiyidSWf/YLEd9SAXe8OIHBlA840bueEIwg7RSJW?=
 =?us-ascii?Q?fBdVlkmKdr2h0wWMyXffiuckrpzxVH6TfWa9ELP9dLznbkojPkxdbXH05n5u?=
 =?us-ascii?Q?i6KmDn6gLSQ5CDWbFx6t34Muja4VsnhsirYcoefZXhboDAp2r4ugeYkno3wq?=
 =?us-ascii?Q?osLI2rSLSvqRPphtsZBsL7JU1YGoFL3iehkVDke3pIM7pDDSpvnpB704djC6?=
 =?us-ascii?Q?mqweVqWYrFmogR/OgTbhAeYfDBh8jVne7qxraLwi51xqcVJCVhQWJ0p816TP?=
 =?us-ascii?Q?QWx5Nq30O+JaboArgCzsKfttqZQTywnrbA6HWKSkZDwsajbKyBpYkMJoaOg3?=
 =?us-ascii?Q?kGRBYZAuLIqQBhWmjcPt47LYCPYyj5RDjydoJa6IAwC27vK6zw2jsLv9ISlK?=
 =?us-ascii?Q?LaMNRMUpCAnBkhZjgFByLijWhqW+BKP+FRNDa4VWbeDGZiS26AUxsclFqy42?=
 =?us-ascii?Q?5Xid+g2vtP4d/XSyXE1mFcMk1rFQfkd/c6p2wfTi7OIr/sLNdyrX/nt5IpNU?=
 =?us-ascii?Q?Cw4WFiG9heENBChCZKbFpVpQ57bIiWb0N3oAspN05WV/X777wlP7IWLI9Jm9?=
 =?us-ascii?Q?1yeiu4VQ97b3A+POlBcWW1ZPiDTYEbBdczLhbbQSwTZYLTW6TqpIzKA4yoSy?=
 =?us-ascii?Q?0EFF13M3cFJl9EiprzOwSt5hpgxvNQYSlAXOZ8Ey9cWzUz6Evi0+wWomnOih?=
 =?us-ascii?Q?ygbXt0solDj0nIIbCvlCEsmW2pJ1EKw35+YKWeDri1Os6AEY9IzJ2qDXDhcP?=
 =?us-ascii?Q?mccpJNAQOg1kiXBc50gpe3OROXmUiegVy9wSObv3bmgaFbuIbhyWEc+7QBJK?=
 =?us-ascii?Q?QoBOvu1cMbK5qtQrUCdBHXXLdYkieH+vvIw8PN2FSX8HEq4IWvMLd8eMR+Pe?=
 =?us-ascii?Q?4dOtNL7FdmA+51pqfEv42iiWQwwMlf08b1TmsNytAgPSDrziYvXaGHlBQ3UG?=
 =?us-ascii?Q?vdexgrqmER8DaehTsw8I5xk1148dRSad4Xl7o2hT6onJOdYt1qz4plNgmf93?=
 =?us-ascii?Q?Ku2pYUnlSVBoSNx9crDWK91UqELtNdvoLuvLfci4tQCRTcau5jwsER/9hM75?=
 =?us-ascii?Q?oN9ozl5mRM5SjloDEe4CJjNv1sCYb1ZMf0i9PCA7coYQPMP+w+dNXnfngj3N?=
 =?us-ascii?Q?kEQhBdyciIx+yY+tnqTGhJ6dGOGj8kFwqYzQeQ40K2nyZXEqvzFBh+7nNg1c?=
 =?us-ascii?Q?wThTkg9pMfLaevTHH6cHRJwVszEZw5sISI6ChSLR7tV9dlfrzdHhi5OA7D5J?=
 =?us-ascii?Q?uFMu2vv5q1ROoHYtIzQLbysm0ChfVH0BDvXvUld5RN8StVAYk46Vc+v8+yeB?=
 =?us-ascii?Q?coKThYhxbOdgTSXsz8fuYpYzqCbfUp1oolb1sK7RDGSzc19hjTgBxijNvC6x?=
 =?us-ascii?Q?+bPHi/cAywTq34LpmLbQuFtzyYgWJx8=3D?=
X-Exchange-RoutingPolicyChecked: NPG7w3A/gDVrBVsdhAOWBJacv8hT3ICHw5CF9LKv3Kmo9rH1Wbmzh3TifPSbrRLSnvpR+l0TIfG4NVt85FI/YUmFcNWYv6yXiTIvEJ8lAlnQCnpP41HfsNsw/UdpNrxiEyvbya4BMmNO2djQ+vlTAXj7jNhwsuPMXNeUVLGIKQvCDU9Cc1NTlKtI0/fzogaO3ssZuhx56WOCh7op+ecPrv0XxQTWwlZKUSqx4zMgtpnGek2ep9kUtJelxVLTpHjH7mNr+BaGjcuk5zDvUgiJ7WY4qr/4s8+IrIJCJGxC1ml1GLPD5SyRQwBRRNjvlxMM0UWUYL93HX8AuDtG+vyPjQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e2054a19-ab56-42d6-3683-08df2f5cbf87
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 10:19:10.7597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQfHAqEmzkyp1KMRO26yhck3i2WMZsSYjUae3p5WeD1ki8kfQxXRyZ2163mZphm0QBZHPwkIY6FhgvcxdeWU9Q2eWuxFLjSgpEYkQZBl1o8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5196
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 11:15:01AM +0100, Anatoly Burakov wrote:
> The generic flow layer now assigns the parsed rule to `flow->rule`
> after successful creation. Engine create callbacks no longer use the
> flow handle, and all four implementations mark it as unused.
> 
> Remove the parameter from the callback type, declarations,
> implementations and generic invocation.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
