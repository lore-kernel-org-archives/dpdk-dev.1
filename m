Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361B7CAC59A
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 07:43:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F27D40289;
	Wed, 24 Sep 2025 09:43:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id C02654027C
 for <dev@dpdk.org>; Wed, 24 Sep 2025 09:43:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758699787; x=1790235787;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=leRr2LdHLhY1bVtJAbSdS0KTwLpW6WkWQCDW6EWQbCc=;
 b=ek/5OugFd6q/BXqgX36vXU7VzsBMwjvZOGJOsMId641f8B5Y1yY67gip
 fURG9OGr/dBFskdP3TXXhjmrkLTd+QrrNsyRIBLY38nxnf/nwsnQEshNz
 EzJYHgJVjTIZ7aKtjCUF3KT1Efpjdepm+xv/HewzEf1jEwuzlv4Oan43Z
 813h+R5qkhaBUuDnrl6M9ssTiEOy42KUTdb4XjTL91KfGr8wuTrQkCRlU
 9qf2hDY32lfW5Cfo1mQmhcjnfApcD0wDp3L7L2rUoHwqD+aEPIBhXBNW4
 w6LOuP03hhZWdBq6wIXh5EtE82hJHnzGz6zIfOYYjBALWqzauls9oO+LD g==;
X-CSE-ConnectionGUID: mD3Ht8ZLQYWDRJcYXMo2Ew==
X-CSE-MsgGUID: JakxtgwRQHG/V/2O6CiDzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="61045457"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="61045457"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 00:43:05 -0700
X-CSE-ConnectionGUID: NhbU8zKWTryEXasrYe+nVw==
X-CSE-MsgGUID: Sun1kdGaQra3eQ72L71k2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="207903455"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 00:43:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 00:43:04 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 00:43:04 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.32) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 00:43:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fgl9in3MG38X0QhVdLnJsxXWxgX/WPD+WrVnxB0nAr0F51fHfG5reYWSJINLVBc8/bQqIP4lcMlE5vznww4FTV9CQ+90R5EJmJryQvAbcKqb70egC6pJEMvU8FDYaKJGDZkIWDFNNHv7D2z4AZqxUK+ICfcm1ixpme9OZ3QddgYwNexy+rqe+tGec/RTNMgsNg28TpxT50YJj+o+kOa0L3C8xQ8bSVkkmU8dJrMDDxOkJG07OkHY8rrTrdr/i9XWeR4z3Wu8HyCk2gr5y6MyQmMdsoPD19DCgP5RXcyVa/02qvx8ZgwcHPyHlXMUygJwtz2HkactWt8DrQm0xJtEow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rmqt6RBGQ6fDmMj2Dsb5yssckzcPN1/VuKHp3toAJ3E=;
 b=gF84O2QSAUbUZZNvz9DB1vdqICjgEMPR0XMbaKK/8/4wQvXX8XenYPx09IVnAM/RjaR8kns8yIJMlg3o6yDhLXUpALzHPG8F7yxSYrlH31OchrUC9DQSrNHoe2BPtJ4OLhz7/c3pVQHpI5Ukqt1dTJtLjINj2U4i71HvoBCdlcyXQ4y2zFjJKsc20YYxbJqPhcHaQ65O7du/eeyBEBEdO9Xux4GJRvkl6o4ppbKI9rNRnXeYi4mh7sayvLlRwS7Mdo+XpMWp9jqTY7IaMF0Jv68XSprAueIhMp1N+ZGGv3w4ZgycFFtp3LfRY/BsRtez+JR9Ng29NjuflfkFIs5cvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN2PR11MB4647.namprd11.prod.outlook.com (2603:10b6:208:262::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 07:42:57 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 07:42:57 +0000
Date: Wed, 24 Sep 2025 08:42:52 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [RFC PATCH 3/6] ethdev: remove queue stats from ethdev stats
 structure
Message-ID: <aNOg_GwMMwMiUDOp@bricha3-mobl1.ger.corp.intel.com>
References: <20250923141207.10403-1-bruce.richardson@intel.com>
 <20250923141207.10403-4-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65463@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65463@smartserver.smartshare.dk>
X-ClientProxiedBy: DB9PR05CA0011.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN2PR11MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: 1284b0b4-b700-4186-da5c-08ddfb3dfa63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?IhO1XmRcyVs8utbsYcDp54KGpdWiVNndASN1k+OzXir2zygPxYU292b2Mf?=
 =?iso-8859-1?Q?moYyAOLD8NxBLe7roT8tsjLlqqnqQhtxBi8k5/rF4Qax1JX7QQidPran2u?=
 =?iso-8859-1?Q?cGESauA3iVichIrrqKsj9qil/vUp5keRhPwj7AKAqMUW7C7OnMjHg18gPJ?=
 =?iso-8859-1?Q?JkGgQK+lDCOhh5NdLEopP7xK0Wm9JCjVSnv15QWAlm4+fB73aX1CtyqTKw?=
 =?iso-8859-1?Q?SP9KBpP+wpQhOUOouUy2TZo/DYyyguLNtJhJKARLPdgGLmBMfv0T6imVvT?=
 =?iso-8859-1?Q?YwkaNZtKIwmsaCjeZeBQDS2DqwZkjZUNYCAI5kRlrtwkgb7VXw+1wssU+B?=
 =?iso-8859-1?Q?V+m7u9P0Y9zpV1ISDyxctibFrNvkRguRPDl27Fb4bJleH9kZLeOa8cO41v?=
 =?iso-8859-1?Q?QTsUri0NR4P01RyoyjKUW+OSlTDuSlXiLP/Z3QXEMsogegXRVfCC0UYlaJ?=
 =?iso-8859-1?Q?+1KxE0dkEJqvoz+uUY9YaRiO7kxEn9F0rAL/aFIFuzoDnu3KgsDPCVxsrX?=
 =?iso-8859-1?Q?AUiUnqmC3cxuP44b7X4sr2JHHew9mOD2V0E7FUYj3UXl5NjUBDmjwu5HKJ?=
 =?iso-8859-1?Q?R9RETlYYjPZYRb9opAODbGqBj+L9d4WjSUnSBUCHZ7jmX13xAf5F7PLbSW?=
 =?iso-8859-1?Q?yH8N9/rL0vEkyyq9A1QEnXhnQOZiPwZY58Yx+oMQmNiZK5V7F+H6LPu4ds?=
 =?iso-8859-1?Q?d/yoKjNkqwf+1HUkeGYhCpdDRjLkZ732CuOOci6GDrk0MyCp1uDNwt77c/?=
 =?iso-8859-1?Q?J2OVj5toAEH1dBiL4gWsn7+Vk18+pg7x7Q2ez8vrPp6jg/rc2us32yrf09?=
 =?iso-8859-1?Q?7O2Ob7n1bB87MR2fwQnQ8pOnQfW7d9BGwv+zKhxK/aOeLI7Sw/O0auQgvt?=
 =?iso-8859-1?Q?ZiQuca1GYz9TFx3x5TL0PFYl7ROBFEZTAT8cFQlIn/7xWUK5zln/NphWKE?=
 =?iso-8859-1?Q?S21C3CPAw4rwIcp4OZzr7SYTE3ydiidNvuhCu9htkGc64EoSveJ6T5E/GP?=
 =?iso-8859-1?Q?djYGmH1Z13pCs25ti0Ymuwki96zHQlf8IpBqyJ3ICGEwT1lXaZ7ms0LJ9R?=
 =?iso-8859-1?Q?fj23jYdH1DAE4Hx34/l1PTbFcRjJ2fxo0Yz4LABkOSMIUGokt0IGKXh6Dd?=
 =?iso-8859-1?Q?wON+B54HrG8fGzX0rz/JMpz1P2o0IIl1HSKFKb+RTIwGTM0HDFIqdq4/G/?=
 =?iso-8859-1?Q?sj7fVi/3N2Iohf68W0OtGYairsombQgmLG69x+xVNhEY/VfyD6LsLASvBY?=
 =?iso-8859-1?Q?Szj+xd1SrNKD5+VItdVBj4hJF+aHa6dUNLJXiLu8qXlvGmdYOjdyQBKsCO?=
 =?iso-8859-1?Q?Wg2iBRE9Yy+rvz3HC5qzF2KbzcVgaAHhpGXliemlGjqIuhgcvcK7gVc/09?=
 =?iso-8859-1?Q?zlI/IM0WQGm0fdC/R+cJ62PxS0ZwRElO8vgsLMBE2aRWVl7DZsgOvOkKC2?=
 =?iso-8859-1?Q?nKjOo7EphLbxl260+Jv3ulMa2m+6YJ5fkW8uamNiDViawe/cn6UyBOnjHr?=
 =?iso-8859-1?Q?A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?JkCC6g5eZbE4sUMqhnhgFqa30saYjzxv4UT3eOvJBiYbmIVBqmbd31NEb9?=
 =?iso-8859-1?Q?F2EBCOEsHO+WbFqBGAk5z+ppTgMC5X4kmCpKJ+ewaK9OHLenhaYJgA+LJr?=
 =?iso-8859-1?Q?p28KPAjQUXfv0orfGw3ONE82sbNJt3VaDwvyozuSX+c7ZbMCsOaD85V7I9?=
 =?iso-8859-1?Q?b1QYpex4dFI4oYYAXQbReqQnzwuPXlSZSMxsv/YNIiS2oGNDhKknuFddFW?=
 =?iso-8859-1?Q?WrY399zZMIre0N6kVkBPpWfqYTNabtyeabZ8TFLEZz+hEw50KU0+w3g9Gk?=
 =?iso-8859-1?Q?jbBrZeYMtK/H3WMX8E9fVvSBOJQJDPRfsebHNfSE+Na+DJldGupiLkpYN9?=
 =?iso-8859-1?Q?eO9NJNvNLuoC6w+8tfG4i1nxcLcGdx7rQZvAvTni5JbWtUMb1hnpdPEwdI?=
 =?iso-8859-1?Q?/nnIQInb8SnBWglO3eejGtUO+rjbG7UHq3KctY02+cbiUiW9ZYUOKJeyB2?=
 =?iso-8859-1?Q?XMPcStD7C6Z/Z8GtUgMAsDC2kq+r7DzqGjefNtQgISz2SphbUX+4MXNO+N?=
 =?iso-8859-1?Q?lRxvaj1cQK7Qsn4aS4niRR0MfH32CyY2jeqjoQudHzA3dnA58los+Ch7HK?=
 =?iso-8859-1?Q?kJdCe1JoeUlGnC4HjCXNzBjVblMFg512Bjh/FhtUQ6gB2fcGQytmoMFD3w?=
 =?iso-8859-1?Q?vLPZacBfnK1s7I805to3VJykucItDB+dumhyI3PCuRmurcIGYl83MBJ5kr?=
 =?iso-8859-1?Q?0eGbNdm/0ZdddUenSKAaehp477qp4vKJPx+ssqpV0uPmFwaMkIkWIeF48y?=
 =?iso-8859-1?Q?ChGCrAzovJMI2llmF11s5hoe4dq+zA2MHrKV1Fm2bzDXJwr78QDmYCBZwI?=
 =?iso-8859-1?Q?7eHlU4BLCexraU57u2hA67JtiguevE03lPB2pvbl2vZaOdecMfj0EnR1vG?=
 =?iso-8859-1?Q?VW23K3C/Q0Lyqayjf+5kAV4zHNfSTz3FLNl5LN3thE4ds8Of5amYCi13Rp?=
 =?iso-8859-1?Q?cbw1frNx6IHlKFSFONWfF3dS1ZGYCxq1mEBK6K2nMsVsa2mnG/BqfCGUJ1?=
 =?iso-8859-1?Q?BLJ8S37pXjj4tJh4KHpO5swRrBX0SU39mzEjsXJjqIq7QotSiF5cF6fS74?=
 =?iso-8859-1?Q?PVAsPCJbfEP7N/jiiChmPfrOPQF3ZC0ZGRsAet3fIZmBl+XScgo9N7YWpn?=
 =?iso-8859-1?Q?6LNRAElWbvT6rFEALiAlD53u0PYayl7uOJfFYaaj3UvUlpOeMe9qVML1qb?=
 =?iso-8859-1?Q?HAkj0E+tgZplAzL71fpi7B7nRrKIX+I1YxDEwtPAnZ3OVF/Vx/MSSIJuUw?=
 =?iso-8859-1?Q?DQuIUG1dKDEp7jQbYQsEwME0l7GvRdBoJkMe2UY1ditRVYXFt+N0cMLKQU?=
 =?iso-8859-1?Q?Y6SyKdUkthvzgjnA+FyMrvHOzWOwIdLgrEmfeRIQ6bxhpPT6ZcsccrVFAh?=
 =?iso-8859-1?Q?V0hu8SRxoowb29ZfiNd3r/hFgP7OyylHZU1XFK4VaCBAYD3j8uvCWfh0De?=
 =?iso-8859-1?Q?VlEx0cbTbSRXcH4cZb6S/MbiA4Kkc1aGqypVMWSCIfnEki8wKFsFWXELiS?=
 =?iso-8859-1?Q?j4Lg9AAPVG3vYiCIdmC/uRri417cwfwg6ceHiTT8KRlCfEglN28fCLJSDN?=
 =?iso-8859-1?Q?fhJ5rYGYCdDynPRh0KMighWmvy2eVZsm2zgJvNCkaroenLT3I2XsCnNpud?=
 =?iso-8859-1?Q?RoDUMQU0MxMk1UfNHYsYh0UHXy+5Jq76Fe1oalE5Tbidt7o3aW7UDz7g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1284b0b4-b700-4186-da5c-08ddfb3dfa63
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 07:42:57.1030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZxHs5DMLVyUdmvl25AKwyx2OzLvUm4EOT5V0YuBsoHtt5AMUHAI7be6AEcPkeMC2JYpMIHk3i5TJqYsDlTQYjfeSvD8jVeAI23xudl8veh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4647
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

On Wed, Sep 24, 2025 at 09:37:18AM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Tuesday, 23 September 2025 16.12
> > 
> > The queue stats part of the rte_eth_stats structure has been deprecated
> > for many years now, since 2020 [1]. Therefore we look to remove these
> > fields from the stats structure.
> > 
> > Unfortunately, the flag introduced by the deprecation,
> > "RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS", means that for drivers using it we
> > still have to return queue stats from the driver stats_get function.
> > This means that we need a new parameter for those stats as part of the
> > stats_get interface. The autofill flag is set for 35 drivers, which
> > means that if we didn't do so, users of those 35 drivers would lose all
> > ability to get per-queue stats.
> > 
> > [1] Commit a72cb3e7656a ("doc: announce queue stats moving to xstats")
> > 	https://github.com/DPDK/dpdk/commit/a72cb3e
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Thank you for finally attacking this, Bruce.
> 
> A few documentation comments and a bugfix inline below.
>

Thanks for the review and good catch on the bug. Will fix in later
versions.

/Bruce
