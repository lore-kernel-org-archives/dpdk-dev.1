Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538F7C28B2F
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 16:03:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 829F440263;
	Tue, 11 Mar 2025 17:03:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 730AB4014F
 for <dev@dpdk.org>; Tue, 11 Mar 2025 17:03:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741709038; x=1773245038;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=rvWISPxLLu1CaqaH4Ye+smgbPhGPBGMXrWjy2KSuExc=;
 b=n7UUSUiJ9fAXshkXgX2YWbyJZoPb6dRZc6+o+l9aiq5DG9lYPbYXbott
 qoRXh5VM2QMj9cstntdULf164UUjZOo3Nd5NQ1u9lYbMIHa2Fn3swEcu8
 NO1zCBkLKxyJzNLFd99h+zooieF03kOcpscqz/HJY3ylaUb0Ko07EOWyP
 VPnG1EQKbze0thLeIkX+OKBcqcSLc1anUqSkJU9eiGHNq69zB30mgO32S
 xUHmSxALft0LOmQRQ3BQ3owO79KppREDsMS1tV0ZIJ6Nntoc1ftO32FAh
 A3y89jStysKltfqJbEorAWPKGSd4RGOvxRasklAwbtvQ0Sw1milw/6QwO A==;
X-CSE-ConnectionGUID: rk9qsc4sSTSzkcKDCvV0dQ==
X-CSE-MsgGUID: DfmSD4AETJ2AguOdo7mXEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="52961788"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; d="scan'208";a="52961788"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2025 09:03:57 -0700
X-CSE-ConnectionGUID: JALeU1pFRAim84Y+loE32w==
X-CSE-MsgGUID: zSi1Fd5LSuO94XDDniOHew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; d="scan'208";a="157564466"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2025 09:03:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 09:03:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 09:03:56 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 09:03:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gi9JuVxRsfsbua883u1gLquNYnpnXrfnQyPEZPTs4+4TinJSUpcecuJYM51YiQx2X8PHncJhXX/POXSwT8ZY6T/69E/rJsRG3RywF209kHVOpvKMG+ljr0KciGVX6jYxfBo9Srr/3UV87plOL/ma331vpcBsXbI0mC43YMp93t9WsH/e32ucs/5pYjHqOaT07Z7YouTqQtUEeuKacsvySbKOdfFP+o08IuKfh5I2b0gsVPglapPP3ui+5HTy15tWYbQQyynn6t6yWV0/wMHxXMmFZZn3H3aaAI1hsTX5sUgWOVY7mxIZXquvmgp7yyuuwI92qBEbqJgbwF1MIS08IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYU2zm5UH9kqfzX1PE2okYfZwZJ8npvY7nTZQTuv3u4=;
 b=AS+AFihXZUO1HcKeq6GTPft6jjDqPl7A7ityAn88mv2YN2WQzIIjBoEeYeLjjiDSSUY7NDfNxTYeA0Ub9mDfMm0IZqIBfSmOX/h7ccwO6axV4zwZQY/s9qsA0OmarqHWbwVAqQcPRl2ges3NyEOWr965UbrDwckaJ4iQY3rqmE3GETQIWAe4hXKO7lbfu6Ob0pTcVhXuPK2FSZacr1Q9HfQrGZQOTRIjn3WoPrfRQ6bJbE+GjOjruAGtuI3r7p7tmwMIIjO83SM3SnAHV6H0ZmfPxtFcJcN9KGCY5ZiSZKETQZcFQxaMcB5jYi6iHHzfa/aiMec8+wG6MDFpr2lPlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB7810.namprd11.prod.outlook.com (2603:10b6:208:3f3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 16:03:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 16:03:53 +0000
Date: Tue, 11 Mar 2025 16:03:47 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Rosen Xu <rosen.xu@intel.com>
Subject: Re: [PATCH 1/4] raw/ifpga: remove unnecessary deref of function
 pointers
Message-ID: <Z9Be4-JbbihY18QT@bricha3-mobl1.ger.corp.intel.com>
References: <20250311155300.13410-1-stephen@networkplumber.org>
 <20250311155300.13410-2-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250311155300.13410-2-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0353.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: 553c557d-9190-4c7b-c6fd-08dd60b651c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6m2jdtNIj0FFZDk3lG2DMs8knswFcFtBgxk9K973xloXkI1BzvMANN6Eu35s?=
 =?us-ascii?Q?oyTdeEaluUg1ybAnzQnxtFtiBplZt/AfLhuvXsfagKnXmMOJRt5ho9tL5UCQ?=
 =?us-ascii?Q?/No6yyVKdqb9EtO3DXa71zl6S8loSw7cywKMjqfF2vaWrggEEshy9XQdJRpc?=
 =?us-ascii?Q?8JwERpHWHFC99Yuuu8OD7d8CWrA0qC0HFcoo+Ine8NFloNGhVTxnYEXI2O/F?=
 =?us-ascii?Q?iJ5P3VOd3cjHLk3iD/s55Mqqy4uOlS+gjZx5e/ChjOVvU3ocrn6RfKuQ9azS?=
 =?us-ascii?Q?cCYNK0MWmnC4TA/H7A0ayB6XmJM567KGtV66OQrWZr1/BmiM28xZRQerN6KS?=
 =?us-ascii?Q?mYUb891AAMQoeWfkHX02S8eS+kMkwMmrvx2uTZciUZ1y2ct+0Wt9WMyN+KSP?=
 =?us-ascii?Q?NP/EJTrmelYShE/gKRZh7pLzCdCiix1dXs4KQSw+By3C8Y7JFdTt/KLOqJWL?=
 =?us-ascii?Q?Xo799yKWPZVC7VdQ0k0BMwgcUekwkQr6BK4ARmV7RsJtkO85rKNOFew8FqgD?=
 =?us-ascii?Q?HoaDemJjVyfGU3sTpmUDdbugnz9T2jiqqxi2rkv/AlBm5D7P1Xl8cOjTNX59?=
 =?us-ascii?Q?1rTCDOIHZMEjgcARGhxuUxqNd1N0TuJ5HbnGFkkPNZvnaCwpkKrl0nk0Rb8x?=
 =?us-ascii?Q?+iw+sy2vBCPyWBooR71f/4msjVMD0kSvDyK7fEAYnPVHy27PaO4vSerVS/qw?=
 =?us-ascii?Q?X9R98vn0OLviKqxmtUH1KQ4dNoij8SoULfs+s61hObrX48hfqLScS2DBJgVT?=
 =?us-ascii?Q?14FXPIGD5d8QADwfzn20bERCIdux1jKmYPgeVBg6xKZGTenArxoQo9tgM22/?=
 =?us-ascii?Q?boGAO00HD7DMtbolP1tT9Q99cw1Xw0lO5ZPU9419NkRMH07pP5kfIgObmJpT?=
 =?us-ascii?Q?RkzKWSvOezBY0ZNzZACYPVUWjiJTo10y/OuNePv7q2DKhNAk898dOuhuLchT?=
 =?us-ascii?Q?Dhs3ldS/Hxu29DxAn8GTywRs8OncrnN+M8bDwnpShWsQKKR+fJuA2cKguO0z?=
 =?us-ascii?Q?eOoQgJ9s3fWtrfrvmU4CUf0ueWy2aDmh1gwiycVipAjzXftJv08/yBxFEgfe?=
 =?us-ascii?Q?qeEl9eGxOY6RJ2Zrza5VCq54GS9ohLP1t1v2VLE4wU0+ob9f/YojBnSAm8O8?=
 =?us-ascii?Q?9rsj3hEwJ2qnlbxpFyr7yjiS5mOYXOUmyjw/22GkM0cWBBCXVdFr8qztHWkW?=
 =?us-ascii?Q?vkcX/JPXGNQJHHI0W2tgCRKaM3RBPxOa3h3y+8auYuqj0AMgjgR5xxwvWJhy?=
 =?us-ascii?Q?8Olf6kSRlIKW2HYzfweYwv1Au7qhVHH3x+FIF6QiMbhZlifkfXGnegXsOX/C?=
 =?us-ascii?Q?ybyD78MSwiluEK+wYuAJYyrr9DLmY5QUULTaZn6edq449U6SSIDokrlx0b+0?=
 =?us-ascii?Q?bS32V2Qx3B86JP5Ro9N5yWatyYn/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LkhXsPqJGm+2bix6po1QfB0nn84fNjQ/UwtohuV3uSpG/vMMK8BBXHhTaPe2?=
 =?us-ascii?Q?HelMRLoyWlXiHi8y+tc/ThkvdfUg0pYV1ekUxD/mEeF73DqdY8Khv8tRqfaU?=
 =?us-ascii?Q?cg0LgbTXuOB7vUOcfxsyizriO3n4RqxCMB4FWgUkL8E23438T07vkLxka9cH?=
 =?us-ascii?Q?6ZGFavojXCBEyoijRku7JX5kmCYlMQE+TKXFMb5Yg6IP9RNajDwOsCH3GusK?=
 =?us-ascii?Q?0g87n026p47KlHrkf4eXHQJlTz8LaNqCiNy5rjGnsa0+uPt4x0F7euvuPvCK?=
 =?us-ascii?Q?5M8kGywaSk5B8IFm8BktmUdBICp879rDt2c5+/+ZHK/WSXR1Vjt6kn9Tx+By?=
 =?us-ascii?Q?AicNNMBE/qw+CXop1ULutQMpXlTfywoiAeLPKijBZX6ArPIbY4MDvBft5BUl?=
 =?us-ascii?Q?zAjauZ2Z4pkWkG6sH5VbFfAC1L28xTf1s+K+LYPoez9+GbWgDy8mOTZf7mOC?=
 =?us-ascii?Q?YA6ADetf60krpOJbGBzGarYUbUl253pSUnJvvbmcy2U57/2o5c/gfdHxA7f8?=
 =?us-ascii?Q?xo9qS6o+SjnUIfbyzL3yGHXwGAg4+wPEyRCodUtBe+O6ILWxNvpIlkJqwZ0t?=
 =?us-ascii?Q?BmLu/qpN+tm+zUPPxgwzMYSPbOGUptAumU9m2kbFXq0H9u85fI06w0PfIMRl?=
 =?us-ascii?Q?7YA0xfxAKOnKzvWRho1VhHv0aY2PlKSZPM4SEwqBUDFb+l5/ske0BXwnZ4v9?=
 =?us-ascii?Q?I7DcvCfQetQBgRxwxwF3Pju0ZlGPY2hE+Fc/VjzXuo2zjzTIF1rtLFU0BgXu?=
 =?us-ascii?Q?qpKYSSGYkPPZscQi9KJLgMBE7CO90QkZ5Hbu2cXloeYr4ri8uBnHotXIMnCj?=
 =?us-ascii?Q?vylR6p3yK9NtdP+UJlVnYGr9P91UHWEBjxAWIn4MRMqIBIK+xn4Io1ZU1+Ia?=
 =?us-ascii?Q?5Vtz4MYzJDGRFanu0xFwZoH9o3QE4BjoBP64FEg6/bkUmGnwj3JSokLTgwXv?=
 =?us-ascii?Q?67vvbqd9wSy1pd33j+ya/nz4hH6acz6RUcq64MZqaKHwTkH2lZy5q21ofCld?=
 =?us-ascii?Q?/LoEBO/7ilzUpFb+aqtIdjlKi2Oaa7Zz9TopQhi0qDnL7aZp58zV1FBrRNJz?=
 =?us-ascii?Q?NP+jKgkGCcp0HGqhkDHyXmkcwc3Hyciqn2/qDeP29SlhCgaWRHKPg1YG1czO?=
 =?us-ascii?Q?dZsiIX/rK8QiLUhEkmnyrNsgOTOwS4EW/e4E79HTPHjO0yIjS6Ot4+xcn2m8?=
 =?us-ascii?Q?l7V2h5iURamF0E/CZ9c5/wkea0gI9Xbe3fNZZ+CopNW7cmDvacA57G3QeJ4B?=
 =?us-ascii?Q?WoE2nM9TWUtxH/MS7Z6z3CGlg648mLvyTZjy230sesC7xm+l2dfDA3I+2u/J?=
 =?us-ascii?Q?2PRH+OMc+IvK00ZAvUVdVgkARXodZo0Urf44e2GnzP0r0fkTXYD8NpgIMZER?=
 =?us-ascii?Q?sXtv9Va/tTBIzIKz27KQLLGJjihhD7f1vCT/7+kIdIAR9w1RHlKy70+KD22v?=
 =?us-ascii?Q?UDUDBbmRzV6aU3+x//dmYhuyaAKE6cH9e/Gs6eiQndoQfb4NCh74wFoVuJIt?=
 =?us-ascii?Q?JLUP53FidLJ48TgfzKG7Bhn58b/CDlmoUB/g3Knf+DINY5QT3GCB2xFL6h8q?=
 =?us-ascii?Q?xD1ED5bOAvJGkilNnvggFXZJDvUY7b3R5PRjsmRqjCQCbweDg+S6xPZGBnYH?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 553c557d-9190-4c7b-c6fd-08dd60b651c0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 16:03:52.9715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +H9VY61x+SO7hhcjFCe/PR66vobJuj7gm8SmVKuHHZ+Pap3xPyIJ80p6f4kzS4mE9jBWYI/mTt+DpEi4CjSrJLLOZtc62N3MA3HHAphs83s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7810
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

On Tue, Mar 11, 2025 at 08:51:29AM -0700, Stephen Hemminger wrote:
> The expression *dev->ops->start and dev->ops->start are equivalent.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/raw/ifpga/afu_pmd_core.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
 
