Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97AAD1A63C
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 14:42:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20B3F4028E;
	Fri,  9 Jan 2026 15:42:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 22FB4400D5
 for <dev@dpdk.org>; Fri,  9 Jan 2026 15:42:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767969731; x=1799505731;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=O61GYiezwIwETiKzoJgURdBWKStuxuG9HlSxnWTrJyM=;
 b=LqlV0mChdxef83dwQ13suTTYPNJ+Dg9Jx+vAdUz9OnbXSX5bZXxS64ax
 EaN+x+2QDarPUeW7TFLW/r3vI/AVDK+ALaWzzvUJnmcrZZLo/IlHX3/XE
 Ul1eLlKbeDDlfi/7LVFH/5zkbH+Hk02Khvq3NUt//OQtXu11Q3Iaac4sf
 PzBZ917AZ/A6jlCFhZV+6AY1oWZZlh8CtvfzK0KBSCu40/vbnqviI9j8t
 +0jO0N593cN3iy3B9sdw+RVfLCGCSBdg2Fm6Ql7HrNtKoTY/QETf6vOSz
 Hm77KTOkhiXEi0EynpMlWDlh5n4oGjmgO7NBlBETygxv96cH/Frq4zdh/ Q==;
X-CSE-ConnectionGUID: 0OQE0USlSYuXZ4DqAfVzkA==
X-CSE-MsgGUID: X0yGL24dRk6CO0mGRL34Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="73196406"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; d="scan'208";a="73196406"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2026 06:42:10 -0800
X-CSE-ConnectionGUID: 4B0/i9N9TkqhwK/rYNrM5w==
X-CSE-MsgGUID: 6BYFy28WRamG7wRhSmnvuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; d="scan'208";a="207636080"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2026 06:42:09 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 9 Jan 2026 06:42:08 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 9 Jan 2026 06:42:08 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.29) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 9 Jan 2026 06:42:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcBCgWvBAkZ5pc0K9fkWZCctNeU4Fgf3nN8IaTHI9ybbW9BuiZxUOWn+mm8qz94BDhc1p7dJA57lvDH/kvpYoQgBvDdIzZKXi36oGuZHuKTSixqKxYT9pg7/D7XChbWkycRaTqFC9fT7u1RfI0zEmiI8/nGzf92+LNLoBzkQzZ5Sq2lvUDSebNRzCp3FDNzWuFl4xnPqb1cj+Jhk0Ad/AHGfELk4qBEG+CCo1VipR2xg7FKJ+8aX0oD73j4sfIh1eOb7OV2ItAQwCq5GvHWBAiwFPWpWXpiOt/19sLOQU1pqR3jW3X8eGdhcn+qbiW6Xg7qCe72Hx6huVkP/LX8IEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dl9qGw2PD+v/bhZv8XzFgQ6MKIlZren+RqSaSgfhy3A=;
 b=ELwpnksbnGrXgV8X8WDFptBCz+adSuy+UbT6vb3VhB5kRPuxAc29yfo7Yn8xhRh8K2ck8E8xAxwhZuc5w415gP3dK68n13uEB0HNMQSQ5CgXDZmZaakFML2qrkhU71b5WkSQI9h4jLA2BRJC7xOxzjQGUx2ITGiI92aTJuqjpA8t2WFl+D64OZGNNqiTrFHBZWQ1yvOoyaLOQW6aS8g/vLFFe2Qs2yOH240OdYogyIx7MY3bxejU7TCsucmIxfPJ2FgxnV1GyhFntbHFWTYQyYU8p5ve/jZvh2ne6m62apQxiCiVU3x+s2x8UAfi2Cf2GGly/CcoZOhjmHB4GJ1f4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6870.namprd11.prod.outlook.com (2603:10b6:806:2b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 14:42:05 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 14:42:05 +0000
Date: Fri, 9 Jan 2026 14:41:59 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH] net/intel: check raw item spec/mask for null
Message-ID: <aWETtxUiQ57BbHaJ@bricha3-mobl1.ger.corp.intel.com>
References: <20260107075905.179912-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260107075905.179912-1-shaiq.wani@intel.com>
X-ClientProxiedBy: VI1PR03CA0063.eurprd03.prod.outlook.com
 (2603:10a6:803:50::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: e7c3ecbc-3f06-49c5-b54f-08de4f8d420c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnR4b0JWeTlMNHNkUWllQlU5ZjZCbWhuOTdIV21Ua0FnMjZxbWNkOVhNRlFt?=
 =?utf-8?B?L3JLREFCU0dWT09ySDFqYzRxR284S0JPWHdSbWdMMzNwZzRFOXBsWlJDUjlL?=
 =?utf-8?B?cVp6dnYrUy9kRzAzRDNRYXRVZkZaL0RlVjZDOVBKVzFCQVFPcS9hS2J1aXZv?=
 =?utf-8?B?ZjRVdko3TWhXaS9wYTVuWDliVE1RYWVmRFZBcU1wS0VBSVJGWXVOeFA1Ty9R?=
 =?utf-8?B?R2NBalFDaEhHTS9jWWZ1U0J2S2FieExETi9sbi9OUXBSL3lQM3l6ZFFEbW11?=
 =?utf-8?B?N1U1TmtVaDVQd3paQTJvMyt1djRMWVV6UHpsclZ5TWMrME45SUJwU3hJUDNG?=
 =?utf-8?B?MGk4ZHkzbC9PTFN1WjAveGRlc3l2TmNvbUpkQjVubjJLNjRhNUZJK1FVMlhr?=
 =?utf-8?B?ZFk3SVQ4OXdnWlJRM1IyVzlDNjROQzR1MVIrb2REb2kzM3FINUdGVHlzWlpz?=
 =?utf-8?B?MGkvMWJiMFAxSXdRSGFtYlF5UkxwaTJzVDFSVXphK1VJVkZzcjZ1NTZBKzRy?=
 =?utf-8?B?Nm8wMmhnYlJwOUFiU2llWmFUV1dTM3VEOWI5akJTRjFXblE1Nm4ybStkNlp3?=
 =?utf-8?B?anF1R2tnemdKcmN1b051VlFiK1lQcUlHVkw3ZkV3cU53cU03UGFJYmdSTTdq?=
 =?utf-8?B?MVBtd28rN2dJYVkwekw3K0p5SW1PRStybUR2emYzQ0UrZmNIdzhmZXJlaGt4?=
 =?utf-8?B?c0tWY3U1RXlOTlFwZ1dEdUFVOXBmYTdhcUp5STJrQzYvUzFRMHNrWnF2anYz?=
 =?utf-8?B?QUlVQkRCOFAxNUJIajFTclZLNVduWW0rRTN1NFp4a0luTWxsQXBnQmtPMlJC?=
 =?utf-8?B?QldNZmRzMzhkQmxwUVJRbk54alZjZElFUTliNFE0TU0vd0dYN1R1eUFNRGZ3?=
 =?utf-8?B?cnBuQkg5VzVtZlIydkpKUVhSdkcyd2JtK3ltdmhvZXNaK1dPNmpRaytGWWRs?=
 =?utf-8?B?ZFdIeVRRbGhnVjhvNU80WFF2bk50WjVRQ2tXZWtFUnUyVzR6Q0lmSy8yZlVk?=
 =?utf-8?B?MHp4UG9ZaG81U2MyTHRWNS8reXFuRWdjNlp3Rmp6RmpxclArQjhnNXhjSTlV?=
 =?utf-8?B?dldkbnB4dnVsRjlNSTRaR0M2aWc4TXdrOWlnbjgza1hRdGo1UWpVU3JCQ3k0?=
 =?utf-8?B?amlJWG96U1RsZllDKzhBWC9mc216aHFiSmVxT2FmdW1uQWpjaDY3ZWEzSW1D?=
 =?utf-8?B?d20rR3hXQUw1anVTSjdaQ2svZml0ZjVFeG9raks1Z3NLeTg3NEYyVHlGa0Vx?=
 =?utf-8?B?bDdsWm11eGZhaUVnckRQcmE0TXNHdlZ0L1Y2dE9qQWZsVGxzVytsclVtNHZJ?=
 =?utf-8?B?bGtLMTVOOHpwNFdrTHVCdXhkbmV4OGdpZUZSOUE5c2k2SExrNkFncHNPMFdz?=
 =?utf-8?B?UFVZSTd3MUx0L2twcG9kcW9FY094OHdWeXEzS0psYVhMTmpJbHhDenU5N2cy?=
 =?utf-8?B?OVQ1cmdsMnR2cFBzc2FWZ3RQZVdmU3ZheGZBL0xqbUJyTTNQdHJwTG16RmVa?=
 =?utf-8?B?dHUwOEE2WjdMT2dVVHpMWm8xMzNERElQOExnUW03bU15RGJ0RDBQVDhGd1Yx?=
 =?utf-8?B?b3dsZUgrMmJyUktmY1cxSE1GSUpySjFqZ2JvWVdQU1VrZmo0T0tvdkFOS1Bk?=
 =?utf-8?B?bGpRRlZobk9vaW81cnJDOE5RUU5NaFh0NWNDQjBxUWpBdTUzMUpNOUtxTnNm?=
 =?utf-8?B?NDhHcDlKS29WZmdpSlZ0elRLVExKVHoxa1hyS09xNXNCMGFUSUIvSkZHUjJC?=
 =?utf-8?B?ZzJXVHpCQlhQQjZTeGxQb2hXUk1PSGpmbTBJekc5U08ybGx5VmdRTStlcmxC?=
 =?utf-8?B?ZHpkSUJObUlySUtlQzJ0YkErSVAxVmpPWGxBZk9jeW1hamdJWmVacjV6VlRW?=
 =?utf-8?B?SXJVS3kvVHJ0NGIwdTNZUm9wNElSbzh6STVoTGxMMlRVNFdzYXdsRWZVdkUx?=
 =?utf-8?Q?VTj/NV1JZ4Tg9BvXw9wGPVlOo3v0NFQQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTd5T04vSkNTb2N1RGh0M1VqMndsVjJzZG5EdlpUY3ovdXNJajNqUWtWa1V3?=
 =?utf-8?B?TmdHVnRTWFFzWGRmRW9tU1diMEZkRjc3aWZYYk5PVmJlbjFJUUQrNCtLMmlx?=
 =?utf-8?B?aHZVMElWNmttK3ZRcU9PQi82TjBMaFJLSlg5V0RUK0FmMWNNZTRjVS84cXBH?=
 =?utf-8?B?Wk5uTE1sUVpndThocXA2TGFmY002RVFmSGVEL2J4ZkgzVUt4YThQUkViVExH?=
 =?utf-8?B?YWhvUlpIVnAwcmFGMExBV3VKWERUZE1kdS9XSC8yekVaaDJGVm5Hei9Tdnk4?=
 =?utf-8?B?RjF4anVOeVY2VkxmL2lhd1lYYW9sU0VUZXpJRE4yQ1JFdm5aVEcxRGZOdXNa?=
 =?utf-8?B?YkRmaDFKTHJkdmpDZzMwckdVMEZoSmwvVFJjdFp2cFlCdjRxMXJ5b2lNNm94?=
 =?utf-8?B?WEZxQW84ZitvbmZBVFBQeWdlYVdLQ3BIWVpIUzgxaUducGh2YnE4T2xxa1cx?=
 =?utf-8?B?bk9RQXhJOXlxTUhXeGlrOFJvY2NsMWkzRk81VnFrMkVUVTBzdnhVOUJ6OC9l?=
 =?utf-8?B?RHpvVGFPUmRZQ3JJdWorWnlydEpLWUhtOEs3dm1zNUZYRTl0aDlYTkJEUlh3?=
 =?utf-8?B?aURmNEtsVmhiNkwyYmVDOWJ0d2U0eEZEQnFSVU8zeXhkQmxZdkNuMm9kQWJp?=
 =?utf-8?B?eGZXWFFtOHVEcXdiM2VVUjc3bkZXM29abEZGVEFkSVBsL09mbnJHRjBlTlRk?=
 =?utf-8?B?dkJ0NDVLY0R4aFpzSG9PUHNnLzRDMEJ3TkR4eGtqMnFUcXpOV09LU0ovQmNw?=
 =?utf-8?B?cHE3YWZ2UGNoT25XWG9UbzNlenRIbURCWStyby9VK1hBVXZnTmJRbFdONlFa?=
 =?utf-8?B?ZEk2Tlp4UEdyM08rc0ZYTUg5ck1yWk1IaFNIU0g4ZFFpSWZnL0owUjF5YStQ?=
 =?utf-8?B?aW04M3JBSkpodXc0dGQzVTdybk9lRk5uWXNFSFRpU2VBeFBJbUtvYTZkTUlJ?=
 =?utf-8?B?QXVvOUUySUo0MXJhWHMyVXFpZHhQSldLd0NTWElweG5jQ2tkQ2theXZFUHl1?=
 =?utf-8?B?Zk1ja1pYa1hKdGljdk84bHh1Vnd6ZlJwMUg3Zm41RzRBK3hJU3hTMHJsbnBG?=
 =?utf-8?B?bGNrZm9lbzNZZytNVmUvOTJ2UHkyejZiKzQwdTFaK3REdmx1VjR2QVJtdzMw?=
 =?utf-8?B?b29oQUhCN3U3VFM2amQwRS9vNVJJV1E3STVWTnY2UmVKQis2SkE0VDZ0VDdh?=
 =?utf-8?B?VjdHUm1PeGs3VkxnMytrQ2NJaWVXNVlHbitXd0JWd0FqS0Y3TXVmL3k0cEtn?=
 =?utf-8?B?MmlyN2diSUdVR2JydFJaWHp4MWZGeTFnUVBaaVFqTm5FK0ltdWx2RWhha1JZ?=
 =?utf-8?B?VjFTYzdMaHhUZldoQTJLVXlEbVhoNnpBWFJvK3V2WTBjbFIzVlMwVm9nTTlz?=
 =?utf-8?B?M3FVcy9uODJwcENab0xjVWRnaTJIVG1lNlovYXBweG1HY0RGaFVZYXdLOVFU?=
 =?utf-8?B?VmdXWSszR1VxNW1zUTRFSFhjd2hNejdPRVR1RG5IRlF4NmRDeHJORUhPSWxC?=
 =?utf-8?B?QUdaVXVvVXIrOHM1RW1TbCtnL2NVOWRHbHhrMmRqckpITEduZkN2dG94OTRs?=
 =?utf-8?B?OVhGcitkbmhaZnIzb01DNDdQZ0NrQXMxN25NclY3N3BIQWM5Q0d6UDVFK1BY?=
 =?utf-8?B?eUVzYXYxdE95TGRQaDdBQXpKbTNqNEhQRmlhSVp2b3RyaVlVeHQ0UG1lMmFi?=
 =?utf-8?B?YTR3L3NRSHg4QVlhL1NwK3RFYURMaXZLMVVoK3A5ZEFacTUzbk5oNkJ6Sm9Y?=
 =?utf-8?B?dEVFSGF4azBPQ2JCZEdzTnMrWFdKNTFkUEhnQTkwV2xpa29ZY044Vyt0OTRn?=
 =?utf-8?B?Z1VNZzdnN3FCSnpnOXg2TnJDR25wL28vcndFWHFkRXFSbEZGR0dTWEZlL29k?=
 =?utf-8?B?ZDE5UThpMkZFaGZKWXgySDh4ZkJSU0w0TWFZSXczTHlHZFE4a1RuTjAyaXFS?=
 =?utf-8?B?emtGcnVwS1lsbkpTVkl5VHZ3dHluT3dFenVwaTI3WTFBbmRPdkV0YThySVNT?=
 =?utf-8?B?Y2p3Qm0wakp2NjR0YWJTZnFYbEVNTjNGU0F5R09nTjZ3VTVkMXpTSTRrUEVZ?=
 =?utf-8?B?MVdPTkkvd3BhQ2w1cEo5SmlpdE1aWlFQd3Z2dmlsQ29CTk9aUkp6dnJERlM5?=
 =?utf-8?B?blZZSVB6WnZ4N1dNYVJxb21XRXZsdEJwbllyU0hTcUMyNHZoVU9jQmVBY0sz?=
 =?utf-8?B?UWN5OUs0ZytvY0dPR1NzY0U2SFR1bWxlejh5WVlRNTlXcW9pbU1yNFdaMksy?=
 =?utf-8?B?TWErVEFjdkNRWWhFdVpESmNCWndIQSt2K1FPVFFzb2RrR0QvYWpPZG80Q2U4?=
 =?utf-8?B?N2NFNVQ4S1JqVG1oODlqVXF2QWZ0NGhtZnhidXJxL0J0OTRLbW9FbzV0Z3VX?=
 =?utf-8?Q?qhTqjOlQSWEfbs8w=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c3ecbc-3f06-49c5-b54f-08de4f8d420c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 14:42:05.2447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxyF3a/XhZ4ojKREe2Uu4gL768ATvCHeN5f5bhBte6dttLGc2c27O3KW8OPk3fW672QdJGyQjZx0a5NpAIKYbL8mOrNYMOuKMncqFIqo394=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6870
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

On Wed, Jan 07, 2026 at 01:29:05PM +0530, Shaiq Wani wrote:
> adds explicit NULL pointer checks for the RAW flow item’s
> spec and mask fields in both the IAVF and ICE PMDs.
> This prevents potential null pointer dereferences
> and provides clearer error reporting to the user.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_fdir.c      |  9 +++++++++
>  drivers/net/intel/iavf/iavf_fsub.c      |  8 ++++++++
>  drivers/net/intel/iavf/iavf_hash.c      | 11 ++++++++++-
>  drivers/net/intel/ice/ice_fdir_filter.c |  7 +++++++
>  drivers/net/intel/ice/ice_hash.c        | 10 +++++++++-
>  5 files changed, 43 insertions(+), 2 deletions(-)
> 
Recheck-request: rebase=next-net-intel, iol-compile-arm64-testing
