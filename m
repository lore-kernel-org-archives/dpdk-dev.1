Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F97CD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 08:47:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61F5D4025F;
	Fri, 26 Jun 2026 10:47:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 26D56400D6
 for <dev@dpdk.org>; Fri, 26 Jun 2026 10:47:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782463631; x=1813999631;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=O+ZsllNf9LQN9S7x6mehVnNvBo4jcIQ6yhK1psSqp3A=;
 b=anZHBly3ElBgQHV9bRSw+sRt1dZvYvDjlXi3yF5vjiaybEdUJ7Kweb+D
 ksVGhIvFu9RIJdwy+8G1+pBlU0/uoFYhVVCWgXt7FnRcUcNTGlJf0qQH0
 MMz4BToarXdw30uzupxhOYkSxeYeS19KIHI9zFmU4X6Ay804Cmq+U+Dgv
 5iMknqns3S3fqj/4qxlbaVOlawSkfxANTGdJ3bR+4ZODZd7RKyPxU0OSN
 HUOESgORmrmhPwJ/e7UsciZlMafFPmsx0kkWjA+1Q3OfvS3thfgjvTeEC
 i8SxvBCNpVU3N15j68u9JneDBTxzfDbPJVMwg6OBoJj4QqgPn4VAa4W6y w==;
X-CSE-ConnectionGUID: WKEjYDI+QEm+5GQZe/lUnw==
X-CSE-MsgGUID: QuqazeT/S06JKskj1wuiqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="87102432"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="87102432"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 01:47:10 -0700
X-CSE-ConnectionGUID: KXoHh3LOR/2Gu4MupkP50Q==
X-CSE-MsgGUID: YTOYntDeQo6YKK9E4ZZq8Q==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 01:47:10 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 01:47:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 26 Jun 2026 01:47:09 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.10) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 01:47:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1ohaCd8C0IjBbPOZVi4MgPKoDJ+5ROg0/CABFCGpjaoxbY0gx423rM1vkS9iVr0AKclSFSVTtASiiulq2V0nGt27Lz32i8xb+IzLOBhrlOKBoILZYMQhKqSjjB8cmsACXH4u2hM2/4/ZlQ6JNsYID0OnauBs0FM7qy5z3pWeRodt7ty+AJkg6a2szpj7MnqRi6h55lVIKnvYTMCKPyBAjjRTuAHBpeB68WNH2zMQghlLpgWtM5VQiXqT/erOWzsk+9GnzDeMBfoAU1gw+bWiOXnghzzGCq2RGM6lTAft60E7zEVAZnLVDZb6TrU9XqO/plS0Om4sknxHHXi3+dKuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBfQXYV0o5iNSCJ0auPXsHAgYIuXzqasa6DGnz6JahI=;
 b=DIn48zq5wGlk0ZWkR0RkOAWh5vmNUbCtumWzzmF1H2kZNuI1ErfQlEen+XmAz5TjhS4Ofe7e3XSAR8cxuIvYIr0/DhO1JGopqLI/bkM/pwlUq3ORS9qcXwScKABLUs45pUjZjuEffV4Afc+26bSBMePQJD1uY9vtgCOq8Cru14lYLEr73ho+mW5PAU9+hpSP3ajcmv+veFeWQrkXPPvmbOdSV368IgQcs+TG19lHFMHK4BueAw+wqe1u0yJ6+KDFYHQSYCW8idXdiX+npKEnwCiAiaGUMd7Ojrdm/M4OLjANEaWxjTb48l2w3otZgSDqG+Rp8nU9gUXdpeXNvl9ROg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SA2PR11MB5051.namprd11.prod.outlook.com (2603:10b6:806:11f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 08:47:02 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 08:47:02 +0000
Date: Fri, 26 Jun 2026 09:46:58 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 0/3] net/intel: fix potential rx stats underflow
Message-ID: <aj48giiB0U5rfUkP@bricha3-mobl1.ger.corp.intel.com>
References: <20260625093619.726471-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260625093619.726471-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0057.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::6) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SA2PR11MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b5278bd-cb62-4028-2624-08ded35f7e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: QyEe2uonwI2cqgNi8HSKcy/KFUzP0WnyEjltXdrAE0msE2hkR6BEgxc6XhFhaeBjNpYCOr7SGbe27OpgGC18foTnEvnrOl2SJ7D6DWHSGL8vjyGX94pFy6OTEjhlT+sOo92pQeWmCwhekBYR2nhlq/+6mJXHbzvwL56aIXfJncaKVM9im0lk+ExJ4bCakBAxXfCVSWneFufBlFHFDrn1hANPXSUzCsIHvHu81WxZvrdKyrL+SfvpfJoE1OK0CnMHNJFY6gps6JlftBowD8Dk1KHPJh1E5ds8zDalMCPKALoYs11+mjAYAKaVNUDHdnGyIHLvHAso/GdjweKyPoBNnt+J5C+mfcgCmYHjmHKKGeb4SAhSjdX+ykppa8oxK3NNQB53RU0d27HhQEsrGHBzIss+TCd+t5ugOXcll3rDoZI7YppRrfFma4Xs7KnCKAhfALR+OtmeYZyGJwJMUs0SujZ6BJRYRmCa8SMX/2Tw+xgkF8UdZodEoKxqjhEQhoMiz2/soodXVq6SOP7XxOsSxfUYDshSAA+7lG88XsGQAoCAo8/yUv68de5IMx2yrg/HxeH6ENmcVf/B9DGpaBAfulaVZJf2XbaeUzi24ro821ajloUoCccukRmDdHafV8nSQMRcmXq3q/uekrf5zIlWJ6UrGbI47DQA5NZnGrfk5eo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pH1duKL5YliOTxtNvsS5+UutOsihs4PkLGGcR89akpUEOIh6Pt+9Cut4ujTN?=
 =?us-ascii?Q?1UK8tHL6IED7lS+FwFdi8KM+/0gSmug3AeWDZvdxjHjaMMIXMD3ELqNfd+O8?=
 =?us-ascii?Q?/uuN3bOVZLQH4gIFTWpmX7bvvw6nVJ60q2FaL5KklguPXedkas+o+7G9RAxD?=
 =?us-ascii?Q?cfvlcu4MOMFi5vT1VVghgwef+4ym7OV/3HJuS1r6vc45UCf8oykM7CH6GclP?=
 =?us-ascii?Q?4TOwN9pFBV5nEN5m7ctYZCyRF6Cfw27oBvYE33Pshu9G1VWD4WF1amXcuI7f?=
 =?us-ascii?Q?IUq5zO2kEKwCfQaOsbiShAdP3TE6THK4ml7zDHIKK+2CKwP3ASoePh0TQR4q?=
 =?us-ascii?Q?etuemU/oUOxStBX/Al3VflMcdy4zvAskJTTQsbh47upIdqINcUiP5STmcJ9k?=
 =?us-ascii?Q?AQo2tT1MpZugnGjfQKu0aD6QHAAcecfJJBibbIx1u+dVS0A2HMGf9G3rqLwB?=
 =?us-ascii?Q?cuAflBbezqeOz67sALCFACpQByWLI+hGJWv8pRYHJxtiQL29QszCPvWBkIlx?=
 =?us-ascii?Q?stdVKnqtvq0qGJQgLqAj22EdjOO5/bZnWg6BYnENHX5+Tk7Kq2SBWHhmja5/?=
 =?us-ascii?Q?SALLowGgQD2zqCZoyBrIC0ZsKgkrxJx30Do+6TGyju2FVaXxzppTP2jPdM5H?=
 =?us-ascii?Q?sjTt570cBOIdQaX+0hmmcSKeGa/X/O2IubhqdYtMLpfLg49gEuDLNuMEWsyc?=
 =?us-ascii?Q?cXMC5QizkFWz2fwWSDvbrXct/uSj19NLHbiERI8czjOrzRzkT+c1nA63wcJE?=
 =?us-ascii?Q?8x3waUHLLNrm3DpmSIGFUrGp72GXvzfReekdu82ZmI3GSdrd5qKCSVKrt80z?=
 =?us-ascii?Q?LMN1QI3M64il+oZ/CL1QJcxMchF/KtT4qoeYiFNCiTh6S6So+Vr7VQg4PpnA?=
 =?us-ascii?Q?8JVoYG+D0i9Yrg8iH9iAcVfCL0RjGsT1It+oszUM1geA2lULiq8hoojQ3f/9?=
 =?us-ascii?Q?3+ZONsfwETCDCHMU3n1JirIYaSXzLqi4ya8zVnmfFafWZUJZOe7MqjKN33nH?=
 =?us-ascii?Q?27WzDobSLNiDRp+uAB698CarHuop9nHk714CVz1uVn1oauSotSZF2k0xKLQo?=
 =?us-ascii?Q?qHTR8B/ep1fNTTi/pQtS8cXxofrl3Ex7JC4/dTIFGBiI22WZbIauu7O16oVB?=
 =?us-ascii?Q?uM/PJ+SUD5AE0fwvouyaprE8Upb7Gfc6z/uL2PQfZDpjbFB5Ti5v4d0eE6t/?=
 =?us-ascii?Q?eRlmcJdxl9qRzLYO3stQPT9YAaYYDlH507/znearRJKRbIgoZ0tW8WvM6h5e?=
 =?us-ascii?Q?2eIhweBdG5DNuWmKahQB48fCBdARpnWOz62f9Q5oxsjonMkqvEdSUJi5bbb5?=
 =?us-ascii?Q?ueeo2D4PaJ75LPn5iUm4UNa0CJcbTSF9jkkg2mAbzXLw1DAwRysOE6Sb28NV?=
 =?us-ascii?Q?wPyoUM8oON2oNFQ2pOmZLG7S/AtUNKzb5FZDkrUUGLzKOHrE9LTaZ4ibAMIs?=
 =?us-ascii?Q?ypo+C0G7uq4DkCfLRWeK+dHMup7AKWZIqfcbL3vkmJGF/KOd02ESLvRNun1O?=
 =?us-ascii?Q?tM5a4eej1dvuzwjq74sSzWekmZSvIdrXJN14riQtdihAsCXUyzywBIk+JXEM?=
 =?us-ascii?Q?J/CkM0p6370juOq8Ni23Vak0A4xE1SfiPn5UfQbmQ8GRkGr4O0GuxD7mD2Q/?=
 =?us-ascii?Q?HB1/W0Tz1Uyl91QlPOcUstZP2webYbEqCoKXmPcBAaF6Y5ouCRJoaFRDpZ4e?=
 =?us-ascii?Q?OiRXQmopH44jBX8/Z0YvNQOqE2qZWr5wJQRw4nIfwpACaGreEmfbn8LVD61g?=
 =?us-ascii?Q?U37/9hN7exM9eC4nGOHur7LWHdIxjOg=3D?=
X-Exchange-RoutingPolicyChecked: isGhJ/VvGTe2l2A9e4t88nsozL1en/qDh0SE9UgklZwzb93I/KqWIywA/VprgaZx3wziNLenB1rfUihfMh4PzvdcHI1DJz8j7iDHO0kwOlElIk9FcqgdL/qu1uTc4EEQ1wpn9biQXwV0pAg6OESH9T8v6ME9Y7oTkKw7tDGwTo0Ys09L0CD1BIK5I1xFHsE/2RIMiPB660MkLHc5f6uEnCdCANHXPkBm4400evT9Z8oInh4O0RODGlIgFPvVITVsVk5V9eDKhbbUo4WbFrQXIfxCSyBSd/WadzQnxLPV+KtVm8ZGFcassqEjUGP+aB8PcQZxItWQhucaQRXdxmjrrw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5278bd-cb62-4028-2624-08ded35f7e04
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 08:47:02.4657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJm9AHjU3CvlhSjA6np9RR0ZTKShsOyd34cN3GU7viQ+SWfkBlINp86asDCBE+bN0r65hJJNO31BKRr2HY/wcGmz6KzUMtMWuIJsw8u3+8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5051
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

On Thu, Jun 25, 2026 at 09:36:16AM +0000, Ciara Loftus wrote:
> The Rx packet count reported by ice, ice DCF and iavf can momentarily
> jump to an enormous invalid value under load. ipackets is derived by
> subtracting the discarded packet count from the sum of the unicast,
> multicast and broadcast counters. That sum already includes the
> discarded packets, so the result is the number actually delivered. The
> inputs are sampled from separate sources at slightly different instants,
> so the discard count can briefly exceed the measured sum. Because the
> arithmetic is unsigned, the subtraction wraps to a huge value and is
> reported as a hugely incorrect packet count and rate.
> 
> All three share the bug but not the fix, because they differ in how
> much control they have over the sampling.
> 
> The ice PF reads its counters directly from hardware registers, so the
> order is under the driver's control. Reading the discard register before
> the other three, combined with the fact that the counters only ever
> increase and the delivered-packet sum always includes the discards,
> makes it impossible for the discard count to exceed the later sum. No
> clamping is needed and the subtraction can never underflow.
> 
> ice DCF and iavf receive their counters from the PF in a single virtchnl
> message and cannot influence the order in which the PF sampled them.
> There a reorder is not available, so the subtraction is made saturating:
> when the discard count exceeds the sum, essentially nothing was delivered,
> so zero is reported instead of underflowing.
> 
> Ciara Loftus (3):
>   net/ice: fix Rx packets statistics underflow
>   net/ice: fix DCF Rx packets statistics underflow
>   net/iavf: fix Rx packets statistics underflow
> 
Series applied to dpdk-next-net-intel. I was tempted to squash into one
patch, but kept them as three because the fix is not identical in all cases
(iavf being different).

Thanks,
/Bruce
