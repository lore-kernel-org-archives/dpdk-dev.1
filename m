Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8499ECD98F2
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 11:25:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C413B40648;
	Tue, 23 Jun 2026 13:25:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id E5B9440611
 for <dev@dpdk.org>; Tue, 23 Jun 2026 13:25:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782213921; x=1813749921;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=FsKHIb6HOP2VlNTW+isdEO4Gpb7Hk+DXWaPyicf2ZxQ=;
 b=EddcdrQam5q0d3To4qyFEOZPg0mZ7/jV55xlkq38GkxRXc+QQ+emoPlC
 pqf981RPHHu/6cHGI9DqhXwS1XJg+8z1WPfwnxhz494Gulx3hze7FhEIC
 OBDaPxjF8wwEQDfcUmJeGO+zpknoBuufKzicSBpUx/dWIa9b+SNx0O+Gg
 iudcKpar4bzEx+TRcaAmIAPd71vB3sg7ize/axMyUXCHosWdUi3fsPd83
 tDjdTMOxoFyi7ZvA2sxpGeyaUFYA1lgezqhqt7TgNE1Xpo1RBnb2A7A97
 7hq9DBSuUGSR+Ag8WnIh+s/tBMaJSlSz4Fw+cfWcst+QCVu5eocM+Akny Q==;
X-CSE-ConnectionGUID: Cv+2S50hQAqYN7tIaIEmVQ==
X-CSE-MsgGUID: 29/pY9BvQIKRoatPmiCo2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82823817"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="82823817"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 04:25:20 -0700
X-CSE-ConnectionGUID: k5SFWSQIRDqRfitfUbMafQ==
X-CSE-MsgGUID: 4BpxzoGvSlaVvU+ig9ttGw==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 04:25:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 04:25:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 23 Jun 2026 04:25:19 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 04:25:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9gasSaduVJ9nkL2irRg6v+gqPBNoA/bOryo2xdlQsGVltqt9BJnz6dLbMNu4pj3M1ZhmvdyQqZMES+r3IE2/DSAd0yuPsC5HYzqSQXvFYEzZiI7q8Ybp9rbCYdzZAZghpqtKSfleb6eZI3GPMirzcNP6+HVk7qA7JFC6ZLigIZP1SQRrynCxWSjM6YsERROM5vYYkWvolOZhgP24iZWSrTEMx9bvE9dJSju3cGlWglEmDY6FNL7svdywHm8rz+ceJJRgluBeIy0XWSljRYOMH3EwtWgNO1RpIP4WAQ/BUOE753fUfPOrTLb6DsEs/YdME6paq4Y/LLEPi0wxKhaew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3N0J0jr5TiDwC84q8Vzc+oJZuhIufkzn/rmZ14KY1CI=;
 b=DLgxXKSTqeRB4a9Wtcb06pa+knXSz9x++LYJx+qHtYwabdjs9kTHQr/NvM7kEpnQEydVQ9cSHpvWQu/csOgB0/ti6H8R7dPmwfs7+1TqvlwdpJOG0sw8aYK++EMLoIF16VpGms9bKUQRRyybmVbg7Lj27i2alSLyztRyrthgfUAGVvYXxYPnNbyNRngd9uu6JGrAQK9DeQHAPpaAPqpXV0gejObuVrC5k+DRIIAqHf98oINm44C2Y3vvV9e96yLEVWRq+OuXHcoUs4JhA+j5rWk98iuxnneKUi/PqbH2zplecd7HuODqLVM+eoBx4Ee3TlEXtaUMNF+gh1MiuSzibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by CH3PR11MB7763.namprd11.prod.outlook.com (2603:10b6:610:145::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 11:25:14 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0113.015; Tue, 23 Jun 2026
 11:25:14 +0000
Date: Tue, 23 Jun 2026 12:25:10 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <longli@microsoft.com>, <hemant.agrawal@nxp.com>,
 Rosen Xu <rosen.xu@altera.com>
Subject: Re: [PATCH v3 07/11] bus/ifpga: allocate interrupt during probing
Message-ID: <ajptFgcMU-dc84Da@bricha3-mobl1.ger.corp.intel.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260623105439.2144694-1-david.marchand@redhat.com>
 <20260623105439.2144694-8-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260623105439.2144694-8-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0155.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::11) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|CH3PR11MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: b62d8331-6079-4da7-c33b-08ded11a1883
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|22082099003|11063799006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: b9j0xRj9bEh7e2Iv930RreYME15M8jSQQP5nKBI0mRvtwp6MdgZxMy5dLR+ZxatAUtW1y0t8u/OHm28jn07p9BBCTFN9CZ3/lFgZTOlK36E9ba2aS2sSgcp/YHORXUQF1tHoIVaNGTDRj9WiTwAPYjgoZAqUjtcD0SMUeI6ICWvEb3AiNSKj0ewSD2kiy7lTZQERj0mH+G551eJZVc6Y+WmFAiLffwsuDCsqwo/Tui52/NMxrWGRNkgI6s+HB/3t93KGUSDwO/vB9ZL4ROtA0WgJDocu3axdwtZXl4KBBTA5F+Kh0je08KtYdq4duPfyJLpcysqv/lLhgLGSBg8bhCpdIuwlc0k2Vo+fZ0DZM2x/5GpI0l4YJpcBifUKVxVIHipebl75gC+j9+xqaQ2VBm0OgF8s6GvaVHzkp8wSr2tAp+7EX/0rk9JMu+E0o9ya/bjs4up50yuQuiQC7v1+6mfebOqaTS5bLtVzjpqSblu8f4hkxVvl8kn+EP4GqL3kO0K1yNgQ+YYuiwkcqECu5hbovfE96W5BQdWB832gpPK+urVdkUO0s/SW3ZcrhDuuDvAAO65z0SyyAZBKgNejDy36vgEGLGe7aceYKVLtpBXAdT+JlwU0P5Jm0o5YN2unCCLrWLUUjZZLfXAvM9coBYrSxsdHhajXSzYRUSCIFTE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(22082099003)(11063799006)(4143699003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BOzsffi0hnnWaZtRioMWd/3E9HJjP4eaqbZDgcROXZ6MjRBAAfcHdcmZk5VB?=
 =?us-ascii?Q?eVvUuzhY69Fy3284cfWGjcTSrtbMHkX1/Q6Lv51JljbEp8FxnlEy0A8uWBAU?=
 =?us-ascii?Q?VelE9n4+VzNhqDWxj16AuGKmVgWFJSdYS/NMy8sZOui/BHPbqJL3VXntAlzG?=
 =?us-ascii?Q?/EvdXhOL49m06lQHI3jRTZALOjbqoCNXkGAlg977OSu+u8eFDgLt2dVBUsYn?=
 =?us-ascii?Q?56W0W2txe9lpBJERfux2duF4PisaI3QwdcClK7oiMs/vJyIGsOmkNG+ZNXzW?=
 =?us-ascii?Q?J9sPk2xp48WLMUddriDH+A1Kt8PJ0cU0laYVkktEl2+cW4R4WbJHhfYE6xpW?=
 =?us-ascii?Q?akFCRkyvLzHAO+BcFClHz/dm9XR2UcABm02Ih+vEktzYdWY7k4ABr/70m42K?=
 =?us-ascii?Q?Lb0Rjw3oJAbiBrBujSEAneFuG05TWCCBuD9nUnM/OEpfmN9Gal3T2EavxtwB?=
 =?us-ascii?Q?JzC05UDKVYXSBdR5v8UMd+nO9PbuHLHAGUFU8fy1vt8HkDYZxYt+TVMTkrC1?=
 =?us-ascii?Q?S5GUlL4oC4jb4ThtEtpIZG9fXVKAf6pmw2+9JQuYXLjeDSFEYk5UGnpLdQ1W?=
 =?us-ascii?Q?R/uG5k1sT6n04JHQsQlIv6xyV+TUalxDa1Vyh7WUcyQV7KNko6Pxmao6PK9R?=
 =?us-ascii?Q?NbO7u7IWvR+nOub9xu2odK6pP/018Oj12G4ks0i+usfd2SYxGOFDTYoL/oj6?=
 =?us-ascii?Q?sCWiUvFIApoHELqzyq03Xtys4E8WdVRJBm7hNIj0MF/gBNASSKQct4DiIFg0?=
 =?us-ascii?Q?HBVxI0xCuHwGLrN1K2SPQn2NyQz1cVu+VJFXA23toeA/RleAKezogZud5Ngi?=
 =?us-ascii?Q?F6+sp4/DggJSduwmIgD8wVEgpGRHwPAzc+njq725mg1JoUVmDPY4UcTbJUXg?=
 =?us-ascii?Q?lpTW7127ay2dQ1xyKeBEOe3aP66BmsvDPQFgFb4X/4vbrTjba5PMbJHX0PU3?=
 =?us-ascii?Q?FzH4VCC7Ku4ntfQh01gAZ3IG8XMdwWy9hzafZeOUo61sIPX3twwvMRiMmSwn?=
 =?us-ascii?Q?RCsH8mWXnf/3SyjMp0IBhU0PNbHo6R24izc3JEaaKMlI2ckVwhbBje64EHe/?=
 =?us-ascii?Q?B64+HVZzKXh7cuA+fub2YDK03VPnsNumQG8u5gWhe3nR5WjOjvOH4zqNdsH8?=
 =?us-ascii?Q?a5CrTmjtrMPKxbtZ2UTubY9ujoELOrTkJIX5p2ML7ggxEW3H7VNNOsgDkBcX?=
 =?us-ascii?Q?0xwkwkCe455OL0w2m9RAXkzBNS95TF0GTsZ5LeHQViO1JwkeIC0rEpO/mGRd?=
 =?us-ascii?Q?KSQu+/FHZcwn+q9avbjhXBSn45z6bRmg4LYaWWFBJTqxb84CWlnK/dO/mxxy?=
 =?us-ascii?Q?3ewp92zbTUBt3FzrdYl0gPh/tJjjCh5J7VZ6NyVq2lckpODqw7tjVp0TPVhI?=
 =?us-ascii?Q?Ma4yriUW/WbTBN+ZfV82mXflnvTbnt+WarlgwaG7kWmETPDzwsfKSYwIgLtg?=
 =?us-ascii?Q?qZ3sobL7ZueFN/ZD4TQoXo/EMQoY34dM5Srl7Fz6MCqNDkqKbW2Dk74vPr0N?=
 =?us-ascii?Q?lQBpWxcQTHEsNnKettoQug+F/QMk466QeCIM90l1yJow2FxD9Gi79ZMYCrjI?=
 =?us-ascii?Q?iV6sGxNgTmgetHabDeXVGQ/i6MYWge/NDm9MpxwxPb7erHZd/DY3+rac0qUr?=
 =?us-ascii?Q?jUzRwinz2mMjtpIRHmuZhN7uIcVhF2lQsw/1YjQmbIMMfhYoYllAQDPl/PVY?=
 =?us-ascii?Q?rCghtrOd5eYCQA++HLr+73rkowhlcj3jf626TXWlNq/irgJsIYo8tWS2zzZ9?=
 =?us-ascii?Q?zdv7M7XvnKP1rDMbu/Lf6vPgpcXNxIo=3D?=
X-Exchange-RoutingPolicyChecked: dU0nL2dWqha02kLUROuEX6n/X3NNikKlxovGP9W9EW5mW2j4LpK4RhuhbTpizTqLq/GzTer3sL7RfMfhxWYUvBBeRJfuEaZi0Z4IH7zpYqnwkd+nT03rehGf5B3G1uikfHnBj2RhZb8eaA/6u8DW5Jg+Vi1yyNf6D7luGfGQESuUmBsk2ZEK+bo/znkC5SA/uMAsF9S1T0360fgSGBMn+z3ADj7EY7Tp+MipSpm02KCtNK88kwSZPU+vUy0QZiEWtXg536VOb8oMZdJlRhTr/6U9WAnybzDB8WfxxRrJPLkxxqobZ+rWb7sQ/5s/gR/ZCIurWlNqximdxacsQRC4rA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b62d8331-6079-4da7-c33b-08ded11a1883
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 11:25:14.4983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mfte4ok5azeAR5Ip1PQ1EweNury5nyVuuyGVNhi/RAGEKnEZXPuK1sCNmrDUc7sbZnViARrXlPm2qB7f7J0HDhwyW2qFclmOKC1Fzh5v7+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7763
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

On Tue, Jun 23, 2026 at 12:54:34PM +0200, David Marchand wrote:
> Allocating the interrupt handle is a waste of memory if no device is
> probed later (like for example, if a allowlist is passed).
> Instead, allocate this handle at the time probe_device is called.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
