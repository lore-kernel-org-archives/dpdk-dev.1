Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE1CCD4F3C
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 14:52:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C236B40608;
	Wed, 20 May 2026 16:52:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 3D190402B0
 for <dev@dpdk.org>; Wed, 20 May 2026 16:52:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779288753; x=1810824753;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=j6YukTd3suBL6FWb2LzKacZu5m8LdvNO0CHeR+sGiYU=;
 b=GS3l7wp9hnwhXJZUV0yFJjcFHwnZieqn06Q6pSraKfQv7GPKPjblKUoY
 c6Gn5RVyhDSeBhITupdEhqtkKqi7xAUuFFq5edr1mCH3YipQs0LSM1I5P
 eWJSnQmnOYfN844aOqveDoavpog4ncp2GZLEoUXp6oe02El1uJ9SLGlUT
 jylGyRxsKjKsVnBRTBiHbzQpuJtPUlDZEZwSTqjRF9pNY7Og50bhQuC4W
 6gprrIDNSMEPswfkACs7zllMeoSPPLepNHHg9TJkTDmjglgseM4U+89jO
 V7nU16lw0V6+sr2W3Sl7YLS7cWUKUWZRUqnW1mFYKsdbTggDotmxQQjsD w==;
X-CSE-ConnectionGUID: fhNHi39bRcWRlMYHYePnww==
X-CSE-MsgGUID: EcFJzaVJRwu2CdukACy7dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="97618086"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="97618086"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 07:52:31 -0700
X-CSE-ConnectionGUID: Yn15vR19TCuRtAvJzCwY2Q==
X-CSE-MsgGUID: MsF3a0uOQFGOKeUv2E05BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="233852466"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 07:52:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 07:52:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 07:52:30 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.57) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 07:52:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYcVV6rpNMz49wLPlB5nnRsWkboPZDA3pQHWVtIG5BV44P1jZ910ShUuMNFKMN5e869zrOkqdpIuHoA85A+JEb/8CnQJrHpq6pJrEfrnccLSUsFE6X6DgFuuLbSWQIdDcjdootlD0TYGyWSM9ZK1+KAoDLVdaGwe+x+fd01EbbbBDtL0TJQsR7v/tmFi3Erra3CVqcsLMktZZsF5MW9gusBOS2FJ0Go0jO8cNWGaWXjM74POYpLGtlf0doeipB7qo9jQkUQRUiNNxErfeg6JkzxweGq88e7xzkqC9h6LJZVAu0GCPu7M6rFedg6IODAIllMhrNuhxUgpR78B5Xvi8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6YukTd3suBL6FWb2LzKacZu5m8LdvNO0CHeR+sGiYU=;
 b=BnTFpX/iPINVRTTPvkMqGTWJiax1Xq97TKDVYbb0iIS6sqICcDJUIoXDH0uvPmpGBr7IUg0eHuBGe76XwVK0cRkDO7Aa1NlNADKtprZb7jwfkfHfNuoiEEEwEsah9h3FObaB1EYKZr5/XLNUOb3i3v2NHN/U0n7jXTpTb4eRfB9yKLQYOOgjUdZwUnG3fqO93Z5qSLRXH2haKXLDd+9f4JHqhnsu9KQkcQPhAWLCb2L9n+61INOIWsX6BqUSNF2sfXDbbaD2DTTxCW6SJgw7JRJsNyF5tAUCBJoEVb35DpwD1H+m80TNk4h5FB3lfxdwOOPFhCfjd3Og28xUgrxFzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL4PR11MB8869.namprd11.prod.outlook.com (2603:10b6:208:5a8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 14:52:22 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 14:52:21 +0000
Date: Wed, 20 May 2026 15:52:16 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <manoj.kumar.subbarao@intel.com>, <aman.deep.singh@intel.com>,
 <dev@dpdk.org>
Subject: Re: [PATCH v5 0/2] Update Rx Timestamp in IAVF PMD
Message-ID: <ag3KoMbIFI5ft65O@bricha3-mobl1.ger.corp.intel.com>
References: <20260509101447.42093-3-soumyadeep.hore@intel.com>
 <20260520184350.81934-1-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520184350.81934-1-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DB9PR01CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL4PR11MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: e718cd64-b113-4842-4de1-08deb67f65c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|56012099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CgPzdmm5xeP7UW6zTL1O7SN50bTYD7YvFqUUoywXAWenXMgNRIPPLSsEFXL6XzHWE7u2hHXyRKtWHEYxQGliVkEirstUaWpw2C/I2JB/VF5Gk1c1xMIWinM5u1ieF99RDGpPYTigLmL/tWvcD8dF4roKtrbEmQUBWI7C2I7ezb+n0UVk/ClRsalkrLsPrbBU8ns16H+uSa1O4gaDY7gigawzZZgEOYMYQTV8bhGBWYX/6rAGQF/j0PY3YyiamLj/WSJeUhLphYm/zUHwkv3kbPQRB2XRMN2xh6m6DknWFdnAun2VyUluYOhRgDVeCm2AxCpizGIwdSuXjE/ucj7pjTfslKr8rRgzWjjAzhOnTdaGD4yDHHpIHkQFq6n4Z9EOfwh1w6mqbJs9p5pmhOMgRIplIRVC/2VziOeKESS5YzmpWCzLm4DVClPgBne7+mF575HlgPUcU2lGYkCEW7OPCcyw/rKAEdeSVl4ayPZu8YmDsgPqLGO+/xisrwyis6dddRmtJARXJQsHz2Gv3h1kqi2Uhj3QSQkt5BXaaIdpfPJwx7OtNM9abdOUZtzlqidnv9sOqcJePz+ULk69HKrrM8PcMyjzePWFJuOus0h0MkD1t2ugPkruOqxXjH4W5r2aKFAGuduSVXk1Z0HQtHJQObgaQZldd+ZKs0KNq0RwPeNyxr6N23MlDsN06D0FXJPy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(56012099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+9jJDEx9sz1D1RNsMXJv5gISz8r+1ark6L/FU/edBA7guatLnyWHcEzVMjWS?=
 =?us-ascii?Q?7wm2ROFX0fpm0BtiidC/HBXfeMPEcHkYN6HFBkIXdsApMmsGsNOh1OVB4IFu?=
 =?us-ascii?Q?MSdb8wdBuYRAWkldUznYEh8v8OwGspaHhDKh4TRpcmxhUGyqw20+JaiQP/at?=
 =?us-ascii?Q?OKsqdicUXZ43Sm3cnWWlim4ptMcI50XSEKbheiBCzjE5jqlQoqMHrIMALzGg?=
 =?us-ascii?Q?yC/Ae4qRencdvv5x7q3fJ3ZEqM2Osa6BKi+Yo/i/F9UWLfiI+Z5/PsZzCele?=
 =?us-ascii?Q?kEpC74HnnxqDemq/Uaw7i+nbbLe1+GZBVhshR+SRxKmgSmXRV8H9zAZmdmd3?=
 =?us-ascii?Q?G0J9+p28L1PB2C+yExFbUsA7HofOEeGpK/tuuRzPYGxk0m0wim5hM2hF6Nag?=
 =?us-ascii?Q?InIG24Xvgu+KxAX+F1+nGPmpq2pyx9HcTYTaGe7BajnOtzlQr5/XFtT2kaWB?=
 =?us-ascii?Q?P+1RD/gFMFN2zY4ozD9Tj+D5iRbY83IJZA3/lwueV/FNKpxYWFP3o22aRRMY?=
 =?us-ascii?Q?oBaPlP0bTboVLyuHalTGocSyYiiPu6MOAG3iLIIodJMnYvbcF3Qr9ww4+Rgs?=
 =?us-ascii?Q?lZCHm73b4WhB8l4p1BE+YcVRimUedGcmGvXOYglkeDacwu6c1dOL38ZBcWQi?=
 =?us-ascii?Q?vTnzmvXEY7zo8zVmE6h6Jbl7DegZQ5mskcoIz3I2haD5RbBftfqOlPFkE98n?=
 =?us-ascii?Q?iHKlxlIcByU0YbSJKw2rGwFhyTOwml55EV7wa/jrHkRKwkzbPxgpTrRFG90/?=
 =?us-ascii?Q?qhb8wHYGcpnlWKM4VGvrzYWjIRBAjbfBgEjsDr3xPY21P2mWslzv1quDZjDl?=
 =?us-ascii?Q?X27fdNrQRRDZqz4HKd+dkcjozRKfLY+ZQyHE5ixYo059ij/pWVP3R+2qJeXP?=
 =?us-ascii?Q?8gYngw9FX9m1E33z+MckOpNhzSKTBGqL7hHltpOcpEduXfw/JaBotNw6OYj3?=
 =?us-ascii?Q?RjdFngQ0EucPoPTsv0FLRSez2EPvncA/8vxyVvZBwYadIBte5gqelcuq55az?=
 =?us-ascii?Q?FWCsjqjJILDlb5f6YHY1jMq3UWbPlEujHGvncR9cFb/7vjnLKFCQuNOnkoqy?=
 =?us-ascii?Q?aajeyNwi2r04sMnRcyFbH6ZtL04KaNRqN0Cpui8er8+L5LXJew2gBApVCTPr?=
 =?us-ascii?Q?BpOrSd/eQw9kqyG81sbN7pEhmGn2PpEWG9xgfH0mM0Lg6PxdB3Sv0VZKeuyn?=
 =?us-ascii?Q?hc9PZyoco20+NlFHH00auD/GNksGZ6ttO8rBQUyRw1H9RBw3dBzLYTPcUz3j?=
 =?us-ascii?Q?oQ04/+++YpvlR8YBRtpaQeT5NXv5KuSMCex/M8wGXEpizywVPBsmDr3KIHze?=
 =?us-ascii?Q?JB/P05Z4S0T2k+kW/BWxW8569uDL2thYvFe2+Cxug7IyBba67h+kT3rlkBc0?=
 =?us-ascii?Q?e0MucfAhzWU9TYP0+BMnBVs64NpiLg2BWA7SGa5iRdtuUwGuR2NQmqXxPgUN?=
 =?us-ascii?Q?MqzL6yrRsRq1+impWalvXTETqX6PB32H1IWW8eW6HaEMYJOxCC/libRIYTGy?=
 =?us-ascii?Q?vfHTwSgevRst3EGt+3ZwRmLtoG7FKzmNXRTIDAchqi286SkOpuHkBkpZ1DwX?=
 =?us-ascii?Q?I/MTXgtDnwpd4Mh+78UpIwMhLoMWlYpy+K7vNeexVene08Si9LWIKhnSX4IR?=
 =?us-ascii?Q?He9ktWyZD8/nEdLM5rkKb3E8+U2vVekaGIYrZ54oUj5+aW6M3yFE6h5wJBQt?=
 =?us-ascii?Q?qOItVWsU9EnfVzSKrTJVg7AJUGgp0tFkX93paFncpMl4SrnO4jvBtrCRW3Zj?=
 =?us-ascii?Q?L6xgI6I/uPKTJoKtcUIymw+QdXDikEw=3D?=
X-Exchange-RoutingPolicyChecked: RRbMCBqVqqwm/Xd57jMdpSFyORk2rkBVoE9llYLPBD4RV48L7EcBx/iksMb1yp+VO4nxJJGBLI6bpgAMCiPUcs5dr4qXOFCYu8e1MrLXCPkxMQsv5bkNMmDWcR3iKjN/DXn8cloejFDozZaxdo7/V/Hz/nSvhGkkdoD0iqYe7zzZr6SMbaNaaFOUPJOe77SUIU+5Ycq31lBPYmGrAVPLu0rBCqr+g2pui152uMF3iY/oQiKQah5jAE11ItRpzT9hNnc0Eb+gFGAknYv8Fkkpl6keapZJHpdQPH+Hw3JYuV3l8n9q3jdqrHzr/31q/+JRfeHlQgBsntBO8X/0OScoYw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e718cd64-b113-4842-4de1-08deb67f65c6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 14:52:21.9140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhHiHgojrVWxVe27RUbi3aIQ3L1JKPfd8uJbmVX9/+TBMEwtRYrbUXet21A1QN2C0yG/j4kE0qQl3pU+tVzlNotJs3gus2boIyhHoxZvy4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8869
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

On Wed, May 20, 2026 at 02:43:48PM -0400, Soumyadeep Hore wrote:
> PHC Polling from Rx Datapath is removed and existing alarm handlers are
> used to fix latency issues in IAVF PMD.
> ---
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to next-net-intel.
Thanks,
/Bruce
