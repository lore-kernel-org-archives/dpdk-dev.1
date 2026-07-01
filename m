Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5735AC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 11:07:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C190B4068A;
	Wed,  1 Jul 2026 13:07:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id A79F540278;
 Wed,  1 Jul 2026 13:07:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782904045; x=1814440045;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=I/zvw7+3XuUar9rTe6hpEF34I4BwSssS4b9kpAERLro=;
 b=AJ9dkBUzeK4wFlGT0KnKeVNj8YN+2t6okV9FfQwyCbWuTcfGNJqeolC8
 tsm9BhVxritjxoisnjDW61usFQgAcJlA9/NxT8Wb3EBV05MRP3V4xNEys
 W+YubvW8f8scpcsS8KEPhYP00Xk8rBtIbHxJMjUOSTP330DRy9xBdp5KG
 x+h2gUexrVPRNJyuRFGyp5f0DR0EbwfwT57Hfu3vh5TvQ2fSO9xfl1LNj
 j7seYuM7OoYhCu4cKswOZhecaS99qYxFQXji1dh1kyesv3jKSGHmGrmfO
 2cUhpN5mocfzN6AAK7iaDxziXr/jaKdLXajMxyGZwTSE0dxLr2Q5Eky6y g==;
X-CSE-ConnectionGUID: jLE95UE1Tw2LUmm9Ho3Bhg==
X-CSE-MsgGUID: BAJNFltZRDa1ehMFYmsqPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="87546000"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="87546000"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 04:07:23 -0700
X-CSE-ConnectionGUID: rG4YJP7zSRyrQ6jMRj+T7g==
X-CSE-MsgGUID: jYTSIxU1QfCgXtpSeEgFhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="248562817"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 04:07:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 04:07:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 04:07:22 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.31) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 04:07:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MR47eklN3hFYKdwkOJ8wGJPszs5PlcAPpcyTO2p3ua05Gc5Kw3ugu6f7B/d9+2l2h3qZC9nK8zaWl2yvlkxMKHwD2Kd6CFv7y9JCg827+CUzdvgnVjns9DcXUk0e9YYdZoS/Hmc8p1+IQlEN3uw23kaOLgMQSt27PJaKOpIl3Ap6qnsRZV/LHf/CugxaqEcqtZiEVw7dHZxCndRW6yrnbc8dNGqSEi1pmIjo3skwiSlNVPqulLGCVUzZHPTZtFkfB3vFUf/4CmjaJwX+Mj3fgZBe4isGW67LKY8esnd+uPn3AJZjFfAAawS8rKXEvFB73FRtqW6zCTH6fSAFBi6Rmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1OfXLWW1EX2RqhwKCx9lusJ4NKh66G6lrX6VNouOOI=;
 b=PGV/rp+c5fj9Rk1rI37JMMZId3Xw6+vCwFR21fomAlVMuA7FDlrRlNHaS7shu4hjH77AHBJ34LGpI3aYxNh84Z6eMhyfxIJzoyKp8+ezZk2OEQ+5YtrugGNXBwgI8taCYY7+x7JvPbF3FQUDFyzNNHLSAquGNsrSweqESULwCKSx8IC1HjO4koHI5w0wE/aW3Btar9sEltxAi4zWy9kDWzFJpoRWc6IDtnuwd+2RhL7mSe9boUNds1v4PwIgljODTy1QW4Iz4UtAl8mKcm40yqi6MrFamyDUy54HbRvokFWDHqdHXPsKwu43DuYYFwWq0J4gaAMTgKrDDSycKFelgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DS0PR11MB7622.namprd11.prod.outlook.com (2603:10b6:8:144::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 11:07:19 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 11:07:19 +0000
Date: Wed, 1 Jul 2026 12:07:15 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Mingjin Ye <mingjinx.ye@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH] net/ixgbe: fix EEPROM read failure on copper media
Message-ID: <akT04-VmdQR0IvXr@bricha3-mobl1.ger.corp.intel.com>
References: <20260701090703.107264-1-mingjinx.ye@intel.com>
 <akTv-wISOVqvd8XD@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <akTv-wISOVqvd8XD@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU7P190CA0027.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::13) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DS0PR11MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d301e1-1ed1-4ee0-cca5-08ded760eafb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 8oQr5A62ZMr846JlHXsbx+Jgl48CWUD+g2joRCbVgKkkLEuYWIoXJIgvmgYRW/QeQ/yVonMlsh065+DD4NPRKepziktzKsvfdjytQa9kq3rN9IWm2IYU/O4R04C9vbCwyRsA5nQly/UWsOrV/F43DRLruC6uk7wRP5HtJ4UppmHvejFc9cPCQj5zovrtZLqODb5gRsn9lDKG8xeSN/RaOinwR+Ot+iunpU6X5qi2ykn3lopKh40r0+lP1qaKDuDnnIsgrhxP8qO8k/4/f/zsOtoJROvPiLlRnhqtSrsmN6jSImneLt/sd/GciiU0Ht1kkSdSmce/1VUiqgpZmZ+jCNudA5WU6TcKJIOCsbUk9vGShnUrEFD77TAlEGNAypZvoaRn43wG8nOTaEyuSj5P4NjsbPFbfAJNpRXCudHgyRt0nMltPAQqQ0GEYshqoes+5Jjc1uUn4ka93G+eS//AQMaYndZbLGzxOCkWglKY/xO5uR0BJhVjzYy3yP+uQuHGAIlqX/AARpeecZoMeURNh6GrHzRP02kGvERp3A+OjQnhUSuGUDg/CbohfiOAt/QMf0EGi1Ij+QVjKLzCXaYYX7rFkebF9hSW59h+2ze4eR96dpTPIADGz6QO6+HxGoanAHHK7tZNBmlVvQJCtoskpgkp20WBRrIqFwYRnlqhKak=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wxrxQR9e0BjrWgBD6CBSuNsKJFZuT4lhWQ23XXcflFj4knsNqM4uHCUc8wDs?=
 =?us-ascii?Q?cUQ/95HwA0aFWSXYpBk/i71rLs3aWDVHtEjj7wizRSkDoeqAbZgHVKAoipOU?=
 =?us-ascii?Q?hkJpRP5+0RlU/QOrKhUBF1jFnefxXZ9DfmFG3t2UlNW0YaAdFs0z0+f9DiAd?=
 =?us-ascii?Q?cOyr6Fpd6Z5X6dMuIvaMt5rEp1lpbvhqfnDLxXxe97BWEIC8FNxNxFs2griF?=
 =?us-ascii?Q?XDCcKux3vRZ0s+Y+UvH8aNH3+/QUT/phJ/tpsP5c+O4WgT4QzZHfalptNXfd?=
 =?us-ascii?Q?f+wIpM9bXGX1dSbm4iDt0wa00FLGVA4NKXPCZ7RaTyBFeAKmx+snCFqqgVXg?=
 =?us-ascii?Q?it9Uvxe71dlRpGuYHA4VzU0d2/hn6dWGfshzB0uQON7aNDAp9VeNLnETUIHp?=
 =?us-ascii?Q?KG4VKvpzBhvkudC1lVu2WSy6g6iGs7Djk5yxFVBquGqOq7VwJ7SqImaE8WSB?=
 =?us-ascii?Q?xjKi90NL1QPJbtvmAsi/kGhghPkNbzv1TOd22uEjlScMkv+lOLRCwyOKJN2U?=
 =?us-ascii?Q?b/VfJHM2C7vPDtFatuHybMQRaf6GpGCNDwoZLcl0U5SYx+qA1c1Tn6mPGnUJ?=
 =?us-ascii?Q?yuBuuk/BBgS2NyNIjdBlj6iwvd/EFT2K0tjUEV6Qb1xQo8SAvfJ4DxR7rRmn?=
 =?us-ascii?Q?n3MLNBpNFRqg8DJ2wEQAuIOmmHu847v69MSRJ+3KR42Q0VaUkilpPMFz6JAY?=
 =?us-ascii?Q?0wxfiaEUmvcU4GVpgHcV0jFLfQwSalR//aXe5SccQLQ6DEq4CZqYkS//OSAD?=
 =?us-ascii?Q?+Z8ityIKZxw4phu3ZNBu6UOYcFg/VLaGLFLCXy+7Cg97ISttkIaOggHV7KbO?=
 =?us-ascii?Q?uJfAPakuv8rYFAUl3ctSstzSrSxRCVHnEF/8Ih8y3ZFLZWfTkIyU5Gec+u0F?=
 =?us-ascii?Q?kiJbXgrPf6aIDsFRqmWIX5XLguTYyVZa/683bRXcnUVX+tKyyi5v0UG6SRCm?=
 =?us-ascii?Q?clwKtMpMCDK4Wa9LDyDKgeSCOGl3l0TZEeZVatoNcKOoZhO14vUq47eJZpt1?=
 =?us-ascii?Q?qkqkMN30U+lXXa8m9kRMDrpcr3QXaWqelqnAX5iOCN12zcaBq6l61A5Lo5o/?=
 =?us-ascii?Q?nigbsIDHpD0DMazHc5KFou3ktmbWX8rSMftynUu5L0M8DI/UJdm7kXyLowSs?=
 =?us-ascii?Q?yWBdKYcSEE+QP6BKpYw8zDVpeUO6ktcvxAOSwqhiYB5LCJxy8IoZoGGb9ijy?=
 =?us-ascii?Q?/Z3K/ydlqjJIbTMMWjtFVef7txlPJG7c10iGfbzX97H6X/81UNfHClJD3eOW?=
 =?us-ascii?Q?euzEkVqHwzjodNoVc+SmSJrjh18HQMpDFv6vrQw8U3BIwF5YD0rp953HZBY0?=
 =?us-ascii?Q?FszlcH8OOKTzw8iFE5EWjbX9bOse60mNT778w/siYhzLl0HhG3GWRT6DxKT6?=
 =?us-ascii?Q?q0mVYpDdgpyT97EyltEY2uLCgch6qmU+jczTtFOV+nAcWIcqBwPYseQ1UvDC?=
 =?us-ascii?Q?Zxp+t1Y0jtx30yYxXQ5Hoa8W1xySnav4KDO4zKu1zohRZaKDFkHBwfLZGxep?=
 =?us-ascii?Q?GEVqW5pvFqwUDq+Ji8WPkX/ScvdFbDAf1vDSjzVsUw2Ra1yNqz7cwnyvauhB?=
 =?us-ascii?Q?a5C6z7l1dbFvTdtNGcqWJTZP3qNTWOoaNQfXdFjfGK94yAggo00YK2umJMDW?=
 =?us-ascii?Q?aU1516HUkZKEUVCe0EwfVp411T0iKQ5VqiluRDQoNpn4AV2fQF8ZiNN8ukg9?=
 =?us-ascii?Q?2zAUTFKgFH4X3q0KGh5C3lyI2A/fGTY3w6VBfKEiRucGqr8RVoTcbcfN0hs5?=
 =?us-ascii?Q?l9L0l7dOWZKp8CIc/Z5jT6JeBQ/QACo=3D?=
X-Exchange-RoutingPolicyChecked: g2Z2Q5NcPp1hHzw5+vscWUvVf1v9LRbvUVmUM1ARgpPBdO2cLK5BqjVi0acVbagiJsJpY+ghwQaR8ll+sh1pG5qFDsXSqK08X8s2FGwA1PK+M7wtNaWEg3CPGmBMPYu5WRh0639NJLvR1kw5eYZ2DItwcHEZ3BikhZbBcgClaUSq4tacI7slDd4qJ12P6wEM4F2Y9ZHqxaymjQ+XDgSvtAERGUbjjijrfpZr0u82spOajqd+sstk1gbjPNyZHdINdrorNk747VQ7GybyD9me5EuvI819FkFTJ23mqRxb6FqHVH/39N4zelW7vsn3ooZGegsV+Gd1PZdUbx4IJJ0CoA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d301e1-1ed1-4ee0-cca5-08ded760eafb
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 11:07:19.3559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9yLda47nFxxJXSeMSBzY+CY7QgpI3feu4vTV8K4ljE7nRhA+EL0XEZpeuxR+07VWssDmEcMrdC1+PYafP54o/vzyFjJe87Bg7c/9bNXale4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7622
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

On Wed, Jul 01, 2026 at 11:46:19AM +0100, Bruce Richardson wrote:
> On Wed, Jul 01, 2026 at 09:07:03AM +0000, Mingjin Ye wrote:
> > The ixgbe_get_module_info() and ixgbe_get_module_eeprom() functions
> > attempt to read SFF EEPROM data for all port types. However, copper
> > media ports do not have SFF EEPROMs, causing invalid I2C operations
> > and generating error logs.
> > 
> > This patch adds a media type check at the beginning of both functions.
> > If the media type is ixgbe_media_type_copper, return -ENOTSUP to
> > safely skip the EEPROM read.
> > 
> > Fixes: b74d0cd43e37 ("net/ixgbe: add module EEPROM callbacks for ixgbe")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
> > ---
> >  drivers/net/intel/ixgbe/ixgbe_ethdev.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
Patch applied to dpdk-next-net-intel.
Thanks,
/Bruce
