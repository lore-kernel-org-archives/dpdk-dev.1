Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1F8C369A2
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 16:22:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFFE3402C3;
	Tue,  8 Apr 2025 18:22:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 8EF3740264
 for <dev@dpdk.org>; Tue,  8 Apr 2025 18:22:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744129369; x=1775665369;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Edie20n5ioCDNCzET2vWdCqP4iDse2p+wwxlVqh/0iA=;
 b=FBg3JYWouJSNzliB3h+F4LubasIk4jAc7bJ6qHGEoOX1hes3wM9cRCtg
 pgdltrFP4nT2aK0XWLgM5t9stTPeWkSYQ27aGhDYtio2WzZAcmQ7XmkYD
 8dzuiJt6nTgpyFJJ+ORZ4M/nwwzILrGHZ5Qu9qMe7Utr8p9lM+kwcbahk
 UKBsqDPD6AXzVhjC7j3Dbz/0FoOjLIoAImdvmgqOtyDJfjf1M33BqjEpk
 y233SzAxIk9L5icGiYgsfo5W+exBZdnwaQ6eYxvzMV5yj6RRJz1PYIoQV
 t4+CTrW+Gj4EoYu79uIcJanSA3YZ4Y3cz0f3hwUf53L2Huauv05sHsHYz A==;
X-CSE-ConnectionGUID: iCev3T0PTDaMn+Y17IfTYw==
X-CSE-MsgGUID: LzgJ7LVSRVeNui9FBIlXMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="44823781"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="44823781"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 09:22:44 -0700
X-CSE-ConnectionGUID: +qeLRbiTSgu5czh/QJBDcQ==
X-CSE-MsgGUID: Gzy/4zggR7OII4oSkGXvpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="133175623"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Apr 2025 09:22:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Apr 2025 09:22:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 09:22:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 09:22:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjJcYozAVRGuiJNs3agDhjwnl/A2eisSU+dfmIvuu/+EZnkRSjU+ghSGNrxxQw09iZRoPNrdd0Iy6VZsaXcaicfnlzO5NU0xemZM3lEmS1R87MGTp3xHxVDKpgwlC5yMsEXgT9Kk5jp/BoTqILP+7ZpKYs1cr7pLjqCSZVkhlgNYY5xaPPHGGj/UCwPtL+aF1n0pkdGgjYzGbCe1lDrwfp2LvTArrExuimbVuLyz6X7Pqq1J7J4qrg1XdMSReoonV5ynjAcjLqgKP//FG3TGGjLfu7mDbc2TUW2oIPwlyABehmkUOn3ROm+8lWoUJjWEPVW3Z6CDCzrThivp7uJIRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrIBwc3PH+CEi0aNs0yBoNVHfBMZAdhGDc67LHJxmeM=;
 b=lYrig1QtDR1vGEVwZ5qd+97AAsg3i3tUp8DmiGvtw7WWYyMdAb70i8KDFGWrBSpINmugEvhPYC7ys89KfKkazHLQiJVBfcksfWCFdcJqOcXNb7ql2ZPH76eWThk8yKbopRovvrTTQdeZa6gCUI4reYgEh7YvCYoYN+xYMltrT1XtxegMWLy1Hdkm/LnmTT2IuXojuDxjtSyWCyM/NYEXclBUmR2Yws3aNx+l1+ZqMr9QUZqb5Q3q5ljsvLqNLv3ZG91oTjc+Z+6UVjUKdWU9+rZXKhSirLnHEk++5b9qPat9gUPxzSaiImb8vn00ddUUQQy+YEkPlRWFWYFlZRL6Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BN9PR11MB5290.namprd11.prod.outlook.com (2603:10b6:408:137::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 16:22:19 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8632.017; Tue, 8 Apr 2025
 16:22:19 +0000
Date: Tue, 8 Apr 2025 17:22:14 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v6 2/4] net/intel: use common Tx entry structure
Message-ID: <Z_VNNusv73beq-2J@bricha3-mobl1.ger.corp.intel.com>
References: <20250312155351.409879-1-shaiq.wani@intel.com>
 <20250403112429.2741138-1-shaiq.wani@intel.com>
 <20250403112429.2741138-3-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250403112429.2741138-3-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZPR01CA0306.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BN9PR11MB5290:EE_
X-MS-Office365-Filtering-Correlation-Id: 483f8a41-01d0-42db-0a58-08dd76b988a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xW9iHr/Ik21OssbNmvORCnCqga4SyIZmGf5Tc8rhz1E59NT2JiWuvHXc0iWL?=
 =?us-ascii?Q?0VNZPb1bW02iy+jeKKu2oiT+gPzkFuad923+kHSMqEoDyfuEKqhDUmbNc6j7?=
 =?us-ascii?Q?Bmq6/cNLUAJo1jXw5F4cT2VhcvRL910RYxtSphS2zcaXtVVUSJCY07Ul/MXB?=
 =?us-ascii?Q?S7d0gIxvHpfz/4MIPQR2CJmizxXAmb9l2AecKek6jqLohYCUNIzfTvQgAG0Z?=
 =?us-ascii?Q?ds+v9NiqyXBgwQ4C9ke+bGbJ2VDS2mOqGdEm+LRshVXRyBMHzE7B/0PjDefM?=
 =?us-ascii?Q?b80IxZUvesB76+LJ20Tt/3G59A/pjJt69Hn5wspYNwdUeXBahrODPBq3siQ6?=
 =?us-ascii?Q?gBwjZc7hQq/S5W2s/SoZUylzqQpjbW0Dqw7RbvhLPyHsAOHHT0IabPqG4j+g?=
 =?us-ascii?Q?TCh3bcbExjnnBEYwTJMVf3R0ZLt3k6iwLOXTlu5vB1CYoPeJHdcCD5f467Ch?=
 =?us-ascii?Q?M4lblSUqAsUcbgjDbvceif7jDfRwDq5+2JmIsgGfZ6uJUz+M0XQqOis7nDxS?=
 =?us-ascii?Q?Uy8HP2nKBWZ9CV93DgnO2gRJE05Xu+DYeUR5r9Zde0wD37PGSojnufDlMnzs?=
 =?us-ascii?Q?A//yrPu+4wAs6StWs80KostzfYsdL46e5UosaCeMG9L5o13MI0JkUIgnk7l9?=
 =?us-ascii?Q?Y1TBaki7dhGc77kOqwOqnJ6Ed1zbVvRJPzIX7tKwOI+v6qJ18B/3oX6ocezs?=
 =?us-ascii?Q?91pDTU8TQOAalqn4Kq9A/HqpBCoa1xFhb0JB4upKjUqxTYNhfdnndUIgO4wB?=
 =?us-ascii?Q?DAqgJKAS7Z4di7DCLH8eBpgERhuJ6++hH9DqDzF/0rGPbsp1eXXZZiRriMEL?=
 =?us-ascii?Q?LC8fF0qBrvi6BQ8DSPpgC042Qd/75bbcZ3VQtmBKHCSFGh+7ailEYIV9vebS?=
 =?us-ascii?Q?I6YzbMKCkiNtLoOTb4xXb1ccWieB1wLGGvXHkeUuSC2hx/WFpDybaLurOuVU?=
 =?us-ascii?Q?J+FC6f96xSJXxaYJ8uMzjQoBdzuFFstO6bSFqtl9gc9IfoxEG6BV4G5E6Czl?=
 =?us-ascii?Q?42XyUCX9d4lsbukRYSPWzVQm6ZvIoVyjMeVyVZ0at1zc7GDnsD5cW3Fs9BXu?=
 =?us-ascii?Q?dU/X2nVP52bQs+cdVuzjwFp1WQkOIX86DgT5IlVJVg6kBx4o5LxA3trruxmA?=
 =?us-ascii?Q?Zm+qarqxeN9IXMf+IjMF+UyMQZOq8g+BKD0dbZ1w8I5RfmASY+8cDRkFbA4U?=
 =?us-ascii?Q?5MvS3naOnNYx4BmbCRVfPD2rprBIGJm6JfExLOY+dPhoytuBaphY7n/ywaJl?=
 =?us-ascii?Q?lhaQIBSVWvGapsdxKtR5bkV99F6kRcU1WLZszyWEF2egx03BmlKvUVdu2/Jr?=
 =?us-ascii?Q?wCEH4IPV7VHplZkhyiZH9TyAoT4n2E6UWm/oL4JcwLA6UPbuXYhNrdzGcc7D?=
 =?us-ascii?Q?vSfJ6SSsh3p+KgQYzuNJGAPTjoU/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0CcHkSYdmG06TB5Ixfujd7MiRqUfRKaK0SeKK+kc6gNfmuveVXfhNO1rhW44?=
 =?us-ascii?Q?z5xTBvM9R73hRHIlbKvc3fB762TcauhDx2gtKfNnoxP/W9Kdrx/I+GjHLl3b?=
 =?us-ascii?Q?ioEK1MbDUmJOkAcA0a++PrpOEhQ/d5Ak0cepD9FTtjyg4WsslKegF82nBfN1?=
 =?us-ascii?Q?wcq71OAM4r99jD/qJWjQehfuSHF2ZFyLxLgdZ8ZWg+mPG9iLJJUBj1kcU9gu?=
 =?us-ascii?Q?8kpOmOm51Ev1ooRzVYgxMcUeoHOF6dvPXJn5YNDgvKbDBU9CvQuw5hI+svVJ?=
 =?us-ascii?Q?rDjq11zuvE0gMyerXTSlUGqtpJdlaYWixy4zI4P54ds7nUGKbA2lK1dYTnvF?=
 =?us-ascii?Q?Ks8ZT8MxlNPPIIMgNuA+DIJXN6Liov0cNLCZuSWA+iZ07R+xv/qmn4S05Fdc?=
 =?us-ascii?Q?Uh9NpMxE0Ebk5jzrqrdsmP5qwEHs8RYp6aKS3akcB5digkQg77IPQI8qhzLp?=
 =?us-ascii?Q?sRwjXJPEqHwZi8EacMVQ/bM7veQsqav+91C+OM+Mo+PtMUFRnnh2YGQla+ZT?=
 =?us-ascii?Q?tofM9q8/VnZ08V8k21wyawRmu7h7RptP9LDeM2OANshqplt99qeyGs0gnFlg?=
 =?us-ascii?Q?Pi46ZCfDns7baFWjBCdQr8uh1RT1AB8JZwQaRg8+WQOQsBBRcvxz9XzVq8dH?=
 =?us-ascii?Q?unThr1GiTUirOvXMDI83fwLtLAbpqGVrV+wogNIItHH/Eb6l3Tfr1wcxlyrt?=
 =?us-ascii?Q?NaUSx88X2DqeZn/vRxB+gADgVltuDCuSFj2JMqFkVwb+1tNMSnGJM7hlpbkL?=
 =?us-ascii?Q?MABcR9e9jO91pmowb8j5gCBuG8cOHw7rzGjZLd55ESmsImasZZMUcj8koPE6?=
 =?us-ascii?Q?hktBNRA1Zro+rux7C5LKuJUUaP+2+zfkJ+r1xNKj5tFc2OYDHxKbSf48O5Qq?=
 =?us-ascii?Q?z2XTXLnGOUpTJP3NDK4loCNUxSjFAYw8J9lSWb/B8z41Y9+m2oti5rl+KQXY?=
 =?us-ascii?Q?MxdQdMGNYSIKAme7FN8bE6U2QvGo16QYcAnjZZ4azZJeBgHRLAelApBlO0Wp?=
 =?us-ascii?Q?RbuzucoNrRjxE7bBA0rqCvKC+4wfhvoDT8UuJJ3PFKW2+BiqDR422oIZ8NNr?=
 =?us-ascii?Q?S6G4eYkgNSrj+ELpiyNmV7jnPZvi0O8+jODNaNRmmeYSWyB9MsJ1z1YEx58y?=
 =?us-ascii?Q?IOYhRqdT1iS5FmoVK4zO5MqJD24sqiTJeJdnBjMxHFQLlv32skz7EghFQLjk?=
 =?us-ascii?Q?uTTKvPBkRlobPkarguMgvOhst1NwuOtce2Rp1vahyt9EAIHNVbY9BDmmy9XK?=
 =?us-ascii?Q?ndBtZUR27QpFexIzTtqyMc+2saFYnTAJPucha1KsoA6eQ7LcnGA/x3pdkXBd?=
 =?us-ascii?Q?DA2jqz22DRc/8NarHPm/Xq8aB7+Htu/aenq9rqK9m9QgXQzGL02xmx/KqwjN?=
 =?us-ascii?Q?YXzSg6oO+xbw+iRLJubkt5w3SrC6fqtkFZpzSuG4+BXQROkDWJSJdtScqck5?=
 =?us-ascii?Q?EnbOHRMywerCBCvGWGoDjCgh5fH6cmzrTIgWLzCMRuEJ97O/2Sw6St5pg79Z?=
 =?us-ascii?Q?7dFlMTv8IUbwWav2zo+aQfFtSJBVTtD3lBuI+XjnSvEg6NPJJD+tBjHzGohl?=
 =?us-ascii?Q?PwsDG0KxLyU3spAcukrgZQQu66Ee65gbadHw1WWXfedq5s/3XSJLAFIgHnt8?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 483f8a41-01d0-42db-0a58-08dd76b988a7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 16:22:19.2181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: euqJbjCG0KLp75OWPvhWjWoiB2MFnYZis2mre5bOE7gjFn+GObkxcUh/iWnQiuzptUXtQGfgPG9n+XXB4dpdClufsj2RBFVDYL78Xw0tMVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5290
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

On Thu, Apr 03, 2025 at 04:54:27PM +0530, Shaiq Wani wrote:
> Used the common Tx entry structure and common Tx mbuf ring replenish fn
> in place of idpf-specific structure and function.
> The vector driver code paths (AVX2, AVX512) use the smaller SW
> ring structure.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

