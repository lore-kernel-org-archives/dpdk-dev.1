Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F99C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 11:59:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BDB040268;
	Mon, 10 Feb 2025 12:59:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 1A94540041
 for <dev@dpdk.org>; Mon, 10 Feb 2025 12:59:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739188775; x=1770724775;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=29LjS6tIalWO1Yp1ADEzr6+LPrq4kQux7wytlD9BhjE=;
 b=X3VPYI7cuLkMsKeF7I7HJey98codXrOl10R7ZGZh4BKxpNNYAbTCgMmu
 1pwQvwgMCJHciWmibEiqnk4x9IGWwCbvMB+OZc3U/jzDEnwCrJYFRA0OM
 5voeR+GIoM6IpmhuoquZa1cX0zYhcHwjSDXQlqlN7t7CJrgdX/yQgEHNd
 tpZ392f6ye/6d4FND7/1lIeO0XCjReV7uZEDr49uR349DJoyPmMwDSn6m
 XUnhthgqSgN+aKfoNa4N4o2NKG/xfb0u8rG0z50/B/Fb4NdfINdEsJNGa
 40Fnh3OVRiSDXMEkSm6zb5hXgkpHyupHOVYvyvF6oMbw5u40/LN2Uyf8Y g==;
X-CSE-ConnectionGUID: B3G5i1RCRASbydONxE2qtw==
X-CSE-MsgGUID: mpDvkrGwTGavQZ4C9zTA9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="51156270"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; d="scan'208";a="51156270"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 03:59:33 -0800
X-CSE-ConnectionGUID: aMatdcNfSSy4gWOVt/blFg==
X-CSE-MsgGUID: R8xpnul/QDKSZQS06mRMuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="112011105"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Feb 2025 03:59:33 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 03:59:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 03:59:33 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 03:59:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQ61zHnj0yqTqrwwM6pLzMorkUfdP9wmCf13usSpVFzMNsQYEwZEoorCNKt+MYatyzekNM7FEWD8wWgh6/A2bD0RN2VshXNLNSRzH1d36TWJ2n183W7AKJ7KyvDoVHfEzM9Mzw8Vk35aCKPfIHO2/aZ3RR/YxEaeIY0JNkMyA9kmQUpj2vxFPiJKvjz8ta5xKPVX/TOHzyV4B4ItYyUOZBe2CWgsspEKyRXXW3dXB/xMrUVPgzrVQoKRDFPgv/j7peE6aKjmEuwlN3IyW+qgL/MDiDUXzTM5o7Lf4YkvFa7ILfGCN6r3YybcksmW7BfhEfXInsWelv5s5uJOK+tBkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwzDYWeiMVO9DNWtATCpdAPhFkyYHqLkcyEV3QwEV3c=;
 b=YqpsfzPV5WwwP2O+fS/MGdg5tUmU5xZEMW35Ircif4W8jXw8QcgaSMejyiJzCojLKRe8q5gDryAVer4GK9NIgSXTOMqKaJkGURxBsblvOubIizn0TdvI3JzH4igKDwW+PBDH+cJLAGFqjfFn3tos/pIYmpwsWC/LkFFRdo/4OU/mIp+HrsleYuDApgCSAwYzVPqr1PomJztvMfo5K4ZQ38F3wMurEq3YbYLaJuYY4aX+Q/P0lRYPywR5U9eMDMT6NNK6a+pAtnBsIRZYWsH0fzy8ytNGr/sxHLlwWcyPDMnHRysnxdpTMGAq0eWFnuh+IifB39eaZHiUYnZFHqMDSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB7017.namprd11.prod.outlook.com (2603:10b6:806:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 11:58:49 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 11:58:48 +0000
Date: Mon, 10 Feb 2025 11:58:43 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v5 0/2] enable AVX2 for single queue Rx/Tx
Message-ID: <Z6np82B-dcbKUfrS@bricha3-mobl1.ger.corp.intel.com>
References: <20250203052430.1243485-2-shaiq.wani@intel.com>
 <20250203075508.1304702-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250203075508.1304702-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DB8PR03CA0031.eurprd03.prod.outlook.com
 (2603:10a6:10:be::44) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: 76f55fc5-7a60-44a5-2ada-08dd49ca476b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AloTzfIk4CbHq3qbR6CtVzX6iCpV0IeG7KOoDJgkxMmuddBPEG8Mzy7KgnSp?=
 =?us-ascii?Q?+YXh7wYjvTWMA8XceIX1pBN27kxsWz2A9Hi9hwaCFicZM4M86r/ElED+F5i7?=
 =?us-ascii?Q?9G3NVVIInQKXldKiJ746pFbblypp9gmRIRBIcYStt2DaNgVwuHNAP/WgqEIr?=
 =?us-ascii?Q?wL6Bg89Su1mQnsyc525UNi23sVMeUYD3r53XJj0xnJC/1YxQ0BFrY2gjDD8Q?=
 =?us-ascii?Q?HvBd28lhWPISL+0WT9/eDMB1p9xQwyKUjWu+GJT6gFgaipolKnWjAVWhneTE?=
 =?us-ascii?Q?Ed25Ptd5nFOVRIoFAw+KluO/HeZWi1miiZvUM7KyeqWzta8NL9xi2sWlKAyl?=
 =?us-ascii?Q?WR3bf4JOF7mlRwKdy45+f9nQWLVk7oV4NXIDDE4qPfGgf5pOCTAOT3cAMd5S?=
 =?us-ascii?Q?rY/71xq4J0ZA2q1ZQ/d7/SB+QFvzb+wU1Db746Ruuj+KttD3PzecMJcQki6k?=
 =?us-ascii?Q?4Xum4v/pd682dTfgHS7nYXJS4zovB6VnjvgXQNgQPglv17vDEa53WPkBQ/5g?=
 =?us-ascii?Q?dhYiPMky3yvsCGo7bsfCReRkKynbMgU+KR0G7WPAK5GiZe8aCq0oEG4AMFRO?=
 =?us-ascii?Q?mdp2lK0tO7v/HdnPANTPIwS9NCST5VGyhJjJawzK5dV5mSIXxDwSRB0WSPhn?=
 =?us-ascii?Q?8Tdi7/Gp12HUndugdiN74fUzvXNWQGgOH1e1Bfe09pUnsT2xH1abalcCn8G3?=
 =?us-ascii?Q?6d2P6VxOgLKnZxDrPmwourLrcApxpZeSoooesAbapKrkQvLzFeg3uyTZfG7n?=
 =?us-ascii?Q?NyTm0wxbA87hu8YShG2oYoH82GnFc0La9EgLuxnc43GJ2DcNx5vi6WpolzeJ?=
 =?us-ascii?Q?2lY7u+V93cEg7s82IqcHD/LcROsgSxe1aaDNUglTPSfGnSrMmLuVpoT3QQui?=
 =?us-ascii?Q?0q6bzaQJ0HpvxIoTKqA9tIvqwsbmS5icx1k3T4zY/COZj7oNm3LYleUjmtmp?=
 =?us-ascii?Q?G3YpGN4ZStanaKrrAThBQp1D2RWB3cFXYPn2AvGjNvuzcRUHdCdhMj+/dOVZ?=
 =?us-ascii?Q?mDuuw+W37sgd3vshoLQ9F9/TN3jLgad87Az9hgjJtSfPmOnamY92uNEjtIdB?=
 =?us-ascii?Q?DRuw2S0L8sxEUnrYVqrZuPzhaZyn9ZY48aiT3JjSeppNxyQYCzYXSTtp2Zm4?=
 =?us-ascii?Q?sMcxNQ09TSJqISFkrueqXgsCZECuMCCynuq6DNwADiDZfRBkPp2V4hHaO06K?=
 =?us-ascii?Q?KZdoeX77E1i5asNw5vpiQ/J3HN93/xpCJMRX0wD991SqWDMvGK4bW+ZrhIMJ?=
 =?us-ascii?Q?AaXlAPT0RI/gIJxKNxBpbHQAIY+zR5PdWztf75PRSfCL64DjK0tvVjBBAtN2?=
 =?us-ascii?Q?OrFkpkwLChU3CfKSfHsNYCTjopnBZm+6vNK2cRu5QbNKbHUi1574jCNGTLtz?=
 =?us-ascii?Q?roSnZPb8S4letflkLW0G3zJRqma+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Asdp++OR+EYUPXYOV48uEPWhE0/OIRf4WDLo3/7hmf8KcfQi0OhVyt03ac5L?=
 =?us-ascii?Q?ikg1shtwHQKYDzJzSIc9NLhwGsRaHz9tGhX2r73Z5TZ99WuxKmgySsusf+Di?=
 =?us-ascii?Q?o9JLFpPKFjSfgnOuBtI30g4hvhn6lto29yshaqjd3CZw0AxnHncGro1gO/6d?=
 =?us-ascii?Q?fUq0GxpWI8eJCpHGtMzN9Rnx/ix2X7CQzQoNmb/SrMKLgccg1zORk6hJUxIh?=
 =?us-ascii?Q?IhFacRTKPCHbl7OtXQjKN05P1FJXyiczzpxp5dkXX3s+te7zp7nn1Q7oVPor?=
 =?us-ascii?Q?oQeTnNkYWkzom6vt28IAqiJkc8JoE9ekbgJ5xQ4LC26hQxi/qVT9UIBcC+jF?=
 =?us-ascii?Q?riXsC4ePECNhezwKLNrn6ldakzwzJXbXfQzh65HgJXrom9WvrmKRZsVrbReu?=
 =?us-ascii?Q?O6JwECVj5L6+bOYytgpzYoPb0a2rndojJrF+qpJHmtOwU7enZmYGzv3RM3NL?=
 =?us-ascii?Q?yhBCktt6HyRFF0A7YMhz7oembLbcd5UtrYk5jnuTGFe73ghziasB24DaeP0w?=
 =?us-ascii?Q?JdFMsq3g8s6IrAUCh2ErG0yl6M1gNCEVXPio1KcA5mCwyysu7vSdSwcdwHC7?=
 =?us-ascii?Q?8hgOkAlLcYqs3y04aLWHvDo1Ye0vVzElW1lcQgE6jkjEhM/lGOB1m7y1pBTK?=
 =?us-ascii?Q?ppIGdmEYFfnnOokO0/jIjxES2gG+nSZhmACw/5I2p7DBdIdqWn1CAdQUYcvA?=
 =?us-ascii?Q?ozsD5E/wfS/RGk4B61g/nz7lav9JJNI7hYxJKRqqdnEuFy/3WswTVcrndRqm?=
 =?us-ascii?Q?Zksf8nJWpQ7ZOw5aoT15QP1qbnT/FLpMYpS33fkK4BmPaPVLtNmvo3BkPb7r?=
 =?us-ascii?Q?ZetQKg4dvNPut2yJ5JuNneGGdHJzgSpoxNCS/14/z+kxi7Tw1LRxZujCSngJ?=
 =?us-ascii?Q?5PKR2S1dVmhd95P1mme/XE8SZhi1aA/TePpVVDKdQRIa7tMVi0fKU1BauV/v?=
 =?us-ascii?Q?gsDp+DKQYWqBenS9Rcdc34UR+qstuNeMT6bP0Z8LlPp0pTn9gYupI34LCJy1?=
 =?us-ascii?Q?O2lrYPqB8oZ59mJrD6MiCjN36RMpdRqdi252ZnpOq0FNHTrapUazgBiy1h4x?=
 =?us-ascii?Q?tTiXDMVwkrZSISj57a6Pe6npwRiYUtbLZlUtfNsnr1/KoIlXWgLmAYDl74VY?=
 =?us-ascii?Q?QUwFBQkiGVIAKZRAPb0qvYgShtgCusrxKL5x40jKzl+S3kJZDt6hN/BSR5OW?=
 =?us-ascii?Q?r24a+HUfa3kmu33FRqII4269IPBjgeIA2ev+WKThDT437wIT+J9VnWXNtRm2?=
 =?us-ascii?Q?SQeaHfIpCdPaw6C1hY9V1qXxNr0E2AAisLr0+Gz2D/m7b5KcOhgTUUg66gN9?=
 =?us-ascii?Q?UsAXWNimW2BSYOm2T9gt2hHDjBNbP/MCarZBD0kaQ8VmanEuy47ii8Lz8Mxo?=
 =?us-ascii?Q?KOdIui43VhhB1YXB0i25qFwr8zUHRLjAsiBqg4KZ92qjW2IRwfGnqtA0qmFx?=
 =?us-ascii?Q?47sQGsWPSXXE79WPzNIw5Ivjtdn8pbvWB9/r1qkp4J/QQTFW1yz2IymxkF54?=
 =?us-ascii?Q?eVb5ZByIU20H+U2Vpe2cZx1xgTKTrPe7zFb88kPr3E7Z5bKkk9bGhWLNY/Hc?=
 =?us-ascii?Q?u5htz9T56e7gOBa5LkRkc3Ox/AmuT9NS8/OA6vEYsfYff57Qoe2CcEbMtl+6?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f55fc5-7a60-44a5-2ada-08dd49ca476b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 11:58:48.8033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNIASas6QA0WOTpwIAbaxq/wN3uz/m7K47bgl3AXw/EzT3b3XJtym0QlwlB8YAqesS+EuWvQRaOmR73zj7MICqjYl8CoQpZxRYcYuF87zRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7017
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

On Mon, Feb 03, 2025 at 01:25:06PM +0530, Shaiq Wani wrote:
> 
> v5:
> - Addressed review comments.
> - Used newly introduced macros as suggested.
> - Fixed build and compilation issues.
> 
> Shaiq Wani (2):
>   common/idpf: enable AVX2 for single queue Rx
>   common/idpf: enable AVX2 for single queue Tx
> 
Patches applied to dpdk-next-net-intel.

Thanks,
/Bruce
