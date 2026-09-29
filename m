Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18648CA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 10:25:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D98214026F;
	Tue, 29 Sep 2026 12:25:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 090514013F
 for <dev@dpdk.org>; Tue, 29 Sep 2026 12:25:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790677520; x=1822213520;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=dPwF6XOEKV5BFsYOFxbOZNJ4w4ygb+KnEBlkmMCTzIg=;
 b=IFTOH5zk8G8JjChI91CQlkCryyTfKABFO94XJtxQIg4ybE46/vvJ1tSs
 0VQ7QZjgFraWsIlo4EthWtnNijGxQa19w0YYNstRjtelOrmGIU7k9Vaiq
 P5oeh4U7fSJV1vyduDy4b+Ue9pO/pKbZLPREU/ip6eZ8HZTibdXk8EHWJ
 4sGOoVlT3GgOceg+5oO1jUtNTkjqhk0xmRAfwJemEK/CxtmlhDQPVrO+M
 LM9Kppjj1Ebrwr+2kRlL02aMHBbi2wKFskj2t9nRSeenqyp7mo/dfy9zD
 gTPzRtVIqqmAaWtmCLjZNOBezX6ziOC+6RqSqPmfpE4qXmBliCduqVbIt Q==;
X-CSE-ConnectionGUID: mh1xlWBiTsWWK+toTCa9WA==
X-CSE-MsgGUID: Eu9MTsMhQpmDzc989Jn6/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90343693"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="90343693"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 03:25:19 -0700
X-CSE-ConnectionGUID: dfFAMKfcSR6ep+WmnQi9ZQ==
X-CSE-MsgGUID: SkubQClHS8m1ezxZyDfKcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="278683758"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 03:25:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 03:25:17 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 03:25:17 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.12) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 03:25:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8u9NW5RiCKPmd/etB2o0ZKHEMMKJZFsKmyaUH+tosdyeqxKONsLocs7/V9tK/qu5dXM2JJib1H+KzcT7JoJvnn4r8y5PTtRCA1RFYKWK49GvcpZedbgD8/g3hScuAVSnSqkhnBZyugSS7kdFjdFK8o8/bkzPavI+x6k92IDAOPdioOXBfrr0h35L3cwm9TGNOAw8N0g8qICbIFHYZCX57VZ89a8QzjoA0Ja148jz4rQNut1o387NwpqoLjpsk3fEeHsKrECLIw5lfK7UT4z6+iZozY4aj+EJGA+DZceEN9jtYfsESnJq4h11YXgeJ0CWY/9zLq8QS8xEYyRrG8F3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCtmtrAlzrT2cbzDjXrY8FR7w2UudOYKRt6nzwtLcxo=;
 b=yBMHRMXpTQ49nzO+Oz8i+sd004yv9VYHX2mOX6Lgs7jd9NBhPuriuuMxkHnpuDkyWXY7HeKC8TUnTiqKJUDnN8CmF1BKhNXKUU2cYwe6rKCfp8gQzbYFOv30tnqymXpPFi89OeUbbOxvbC5NubdFENjYtgMPHl6PMsBFxavX9ozFfNNzXZhaea8XEUL4IOLFM2qpniwF93bmBVQfILa4QzSi1hKHi16ZEmCjZuVDzoSTLBWiYp3XIFY6NqNjzF06yl6PhKwVWnNLcXIK9O8CrWSM9t666OAF8JM4wvHgeJkVWGGxeIlKopfyVEMPWyhb7kMt+p1Tz1XYWqrx5Vnp4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by BL1PR11MB5222.namprd11.prod.outlook.com (2603:10b6:208:313::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 10:25:10 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Tue, 29 Sep 2026
 10:25:10 +0000
Date: Tue, 29 Sep 2026 11:25:05 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH v2] net/iavf: fix reset race condition
Message-ID: <aruSAUwDnUvEkv-R@bricha3-mobl1.ger.corp.intel.com>
References: <20260924084152.11089-1-ciara.loftus@intel.com>
 <20260928095325.37968-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260928095325.37968-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0292.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::27) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|BL1PR11MB5222:EE_
X-MS-Office365-Filtering-Correlation-Id: ade25a6d-00b8-46f9-5e31-08df1e13f0cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /YVAPqz+Xn39mZoyOzb+IfGkCm9VWu+HfUKpE5pgZys8cLBrL3fh3nrJJE40MoE2kLXK3zD4L8pqGyc1k5obCBMnQtsWzDt+mOHTaIbPO6hWUmM+Gv3b9B0KobB2GpA4raZPAl0eJbDtiP7UczJc8H111ecZwYrzdIbgYVD1D3I6nC2tPvltGD5sAebDgDLIGJxFoG4xF51sGBq7QgjY6DUaASkLXj7hGz9UTV8vjvnIMJIWVkonGWpfpL/QWjLQbgi1hC3t9aJ3FRxJwkeYegDn0ym9dJ9D5ga/lGMXbUMZiswVoEm8979mSqeeu3DQQyJ6f1swdIjZhbNIuyiT6alldUHagt4QY8bp/kgvu67nW/vc82W6wolfLoBzuWf9djtD2PUvC1Zr9xT+MCRq6zAf1Lhj1glaFGDKmEy3dTPgoBxY+8UZbMvVSmrzhpIZkT8fNMQIHfIh98ZqZW63nPIQoaxpVCjOKLPtrT82KL2jflKOU207+5i6AcmY8bEv7YnBzyPrTMWz5UnTEwefsJuRUSkt8TBxGGHnHJAsKMsLw+iNvlaAFhGbaf2knBt/AjH8tN4WVHccDwBdPDhtQLGoMAxVwTh22gA2UGkB3IPNJfrzrdE+e06+xrtkAFOSALORqvRG9P9NMg2InGOcX9kYwLhGi+uwU41X5L8CGKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zkM938FLTvbeCggbCm10aG0FzWTDG+GbOhbfr5TAWDFSP/Z2CKEPHNaa3+zw?=
 =?us-ascii?Q?NH8V2hUS+UR3LF/U2D+dZmGHZYdwwpq4CyMn7uFGai15h/EkMbYKxtAp56nK?=
 =?us-ascii?Q?2SgTVGqZnddG6YA8YBSvGaUJvpv4ZK06cpF+ahYm6AvcS0TBqCjwtrXNT/gO?=
 =?us-ascii?Q?YLyM+L7WuDxRnHNUyU4/yDwD7tD5+Miqe3aP5YAx6M5yJ4j5bKBpWChPDTrd?=
 =?us-ascii?Q?x2phfzPj/lo31j7pjOkD07FQDC0s3C5FfsxCSPweRxAzXwqCi4MitLBTuv4u?=
 =?us-ascii?Q?WEn5lK6ojU914tmg5FTgVj2VCxH9URki4C1/ijBg6CPiZAf9NQroMq/Pto5C?=
 =?us-ascii?Q?2zcbZtpkq4dA26uhX81JNN0ndeAcpl04ZVxh/dalEJo2RaZ2cxNl0a397zHn?=
 =?us-ascii?Q?VVzIrrh2NXplxQxeDXB8C8WnOrg+K79zQQTXjsNLF6fUVxsHYvFII61nBL2U?=
 =?us-ascii?Q?0ei8u43lZIuZE/kdr9WN9v6Jz+J6Veqod7zTCiovc5YzU2O1AFyW2+RZ5DG/?=
 =?us-ascii?Q?X+D1nN65yd62JNHp+12ztIO2D0/tZwFHpFlbhh9DSv6HzZ+xNC2zLYSKeXpb?=
 =?us-ascii?Q?cZfzvv8qvSRZDSyS3VudgsH/eZN0VuehkTcod9+yAmwACHpYNo4Y/UH2qOZV?=
 =?us-ascii?Q?sge0DhX5KHms0YF6I69AXwSgIjWrPBV1bQGSytUfJJ9uQ6NsSuZRn4xdRUS2?=
 =?us-ascii?Q?qYEjLtaFyhMdYyGUDMFmqImvaIVLr8IhccGr0m3IUYCXh13B8jAdaFHjmst1?=
 =?us-ascii?Q?AptYBIE2cTnjRNZuvOTjhWj77APqUVycbXLbvnaT2jwK5J4kOfHQCn4AciT4?=
 =?us-ascii?Q?QEVjcmcQ8kjNvd5bcpgb9kFM8oL7nse7/vk0CzXIvP4hXTr+Ul10p+YvC6Kw?=
 =?us-ascii?Q?hSo4kKu8WiND7eii6uGQ+dFHVyE5eHGeJ9kPobm02LIZbgXhJBODUBiC3Gea?=
 =?us-ascii?Q?8YXPNf40eiNblNmHNNbfiPoQZ8vWxOO4zEEsv9f4yK+Q0DK+oMuv6x2U9FMM?=
 =?us-ascii?Q?yNzwDn15W+cwZGVLJC14KrtxGGQs+DuCNhJY6mI2S4VNtbbwRBAFpjZxrppg?=
 =?us-ascii?Q?3CFAfr2YqDAHunlqms/X8CEBGYoQtOr+uoLSntJkGfG7FB2i0TnE2d2c5evO?=
 =?us-ascii?Q?/FlRDZUndSi7AQepn0Xai6gTuZ9ggAVjQYJVCGPf0210G7mRMvqgPLxK74vS?=
 =?us-ascii?Q?kFQqaHt/++ALVKd0KkTQpNnubbrwv3LZynG+pJcf1FUZMbVep8HLPhhkjAbP?=
 =?us-ascii?Q?5FhAEu6CEtXH1D7LT2kCFhzIKfzSy9v9hBRNVbgpOtmjvJqPxGGARj01bppK?=
 =?us-ascii?Q?cZiq9wjNkR3MJK/BdBZkF390fOoUbvj+uYLeOVieN634ChnarjoIIH8QQn0R?=
 =?us-ascii?Q?ZUsw3V4GR8EhsHM5BOVgOSV+vqIscW104PmUvANyU+OahAKOIvXPiWvGRwgm?=
 =?us-ascii?Q?HbzjFEwFAMRcOt2d25ZIdMogLjpty489dsqs3k+8n1XnQc5iIKYY6AnD/pAI?=
 =?us-ascii?Q?PEmVBnG9A7Fgv7/32AzVlmhWlscs1HJLhciYVNIEsReWHPx+kagHBxY0F8Ks?=
 =?us-ascii?Q?x5+7IKrmJjifZ/tHni6GXft/1EgI2iKdqSaZIpXgHhSTN5+5t7ZX7aXubHaP?=
 =?us-ascii?Q?K9qHcs3d2lYKXxKaRUyrCJGUmj0YJwdRDc80r4PUnC0YrAQn5GlTsVz/KmF7?=
 =?us-ascii?Q?eh3eC8iQLIVrWZop9vszjzsgNZP0Nf9fJBHAFECiwyIIQtXmONzrFEnK6qxL?=
 =?us-ascii?Q?GLarbigX59app0Cuaaa+Z5NG5utvxS0=3D?=
X-Exchange-RoutingPolicyChecked: UCdq7Q3xcmrh+m0tr1cqfLzIjXicUEitsrsduH+AvNr19zJQDTips8/O5SeuDsMkXd1f7hpPCYuaCt1wDRvghp45lTM0iA+FBLoXhJeGWsz0ZKdSgvdMMyZP0GlXnO4yYxb4lwiRz36BaskfuzBKAKLCOt94Ngijc9eWS4hmdUM+q83H3W88IQM31uSa6ptNC0HVhKtGZ5y3zDG+aBleXtLBNZ9QDbo5+crFJH+pQRJvpaxy8iJPFrkIIeYgie4v1UiVMr3LlbuQzKv/40cI//C3kZvhDQgDtQu90T+9KcZL8Ols8mlPqm/pwTLyyVmTmZLBH27GK3YgvIp+WfUs0Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: ade25a6d-00b8-46f9-5e31-08df1e13f0cc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 10:25:10.5197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4gnJ+cJBLIGiarPfP8Iat4fOgQHIJPickoKPLqm6WexOKHcfeeQLQrEsH5gmEc/LnGA/C+KywZto1ocbYSQ2/K4N/H4g9vUs2GiKZr++Qg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5222
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

On Mon, Sep 28, 2026 at 09:53:25AM +0000, Ciara Loftus wrote:
> iavf_handle_hw_reset() can be called concurrently from the iavf-event
> thread handling RTE_ETH_EVENT_INTR_RESET and from any thread calling
> rte_pmd_iavf_reinit() (VF-initiated reset), with no synchronisation
> between the two. Make in_reset_recovery atomic and use it as a guard
> so only one reset runs at a time.
> 
> Fixes: 28a1a72eac26 ("net/iavf: add VF initiated reset")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
> v2:
> * Use acquire ordering in iavf_resume_pending_start()
> * Clear pf_reset_in_progress before the release store
> ---
Applied to dpdk-next-net-intel.
Thanks,
/Bruce
