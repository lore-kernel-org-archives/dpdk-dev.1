Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44041C282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Mar 2025 11:52:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CA54402C4;
	Tue, 18 Mar 2025 12:52:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 3ACBC40291
 for <dev@dpdk.org>; Tue, 18 Mar 2025 12:52:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742298721; x=1773834721;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=wKJt+7tJkuBVOgt3BMPBM3Kefjy0IaAVY/zVbbVWxa0=;
 b=bWh1THLXZST0vOp+4RxKUhtNGq8qEgrm1mcN97BC49N0gK0BUF5sbwBX
 2A8Xw+HMA8rnVZ6chBGSrMPfnAlAaDLSlSP1fIpIcZkacnAWai7sKVnLO
 Ks8rmA/hNbNieyz4jaKKX7dQWfTqW7hiVTqKgsjjn3Yie8Hijrvxgzqcc
 3lT2elMtoPTVHVvhcx+eTeh0wihb+pModrptPyQ+powxvQHjyMbDfXTph
 VkYd5LjE2A8GYuVgXyMLvMW1Rwoo0NReVrYkbgMiXiDzB3P8ALjRBjncK
 VmCIknhS78FoWaJF39RO2fUJsz2bUkWxIQHWlV/xJeqE1j3xO6y+mdD3D A==;
X-CSE-ConnectionGUID: AN3BwznsSVqH4L29n0xY/w==
X-CSE-MsgGUID: RyCSVDKmT+WBmnmaX6BLIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43302051"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="43302051"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 04:52:00 -0700
X-CSE-ConnectionGUID: P3+aeywZTWKBpTDWxuSQwA==
X-CSE-MsgGUID: EBoTA5ESSAGrFE3DhsoYPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="121969392"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 04:52:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 04:51:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 04:51:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 04:51:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyNZccoxu7BCB6XiiIgeLNp2lk0sLSqOai0sXtdMrW+GiEd2lq0iug/fUhbwqoB/fqNV6x9R/QdI4QnjAsIBHlMXvV1ZB2JxyMdzjuc9dw4b4P7q3FcsloUpY1WvFuoMOTVkzzQcsKryxK2gqZB40pZ1nFudfgDu1tLU40lgaIq4NIFl0l+wcS2iVe71H266DwEvOIkWtlN4vQ/FGEIsNsQb0St8UdOje/FKuy/9M/bRQOtO/148D49k6YZEe4oYybblJ1n06kwv5AGTQRKMOfDuGQGniDvW2uIr+194fU9wZqMSgJGUW0/yHhIvA0NcjHibl7pkNdMTdN2+inIv8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17GavAyCtUGSyIzSry2ayPNE0gNPLWIw/jeLs01dzIk=;
 b=M+CUi557MFF00YYp1idFcHlt0Q9J62pGd62w/y5fEtfwodNBvuxpSy7Qq1w6E8aPSNIpOMDP6ypCnqV47tF3ZIveijhwzr0b+n/EgC1iYid3r7OdStBL/V+zr/z9dQRqD8Dh8ddATed7tT1GF25MW2vNQmMqwW8lmGwlMP0ck5V1K7wbywoqExjIUsqjWLfn6E8lfWEtGJGpbFT2uoaCxWQgEvCZ27raBETczRCtb5E4L358PCJCazFMaL1tNPncBThXRfKWkNT4xxk6T4CTVa/ENA4cakjuovPgJIayc5t/82fZcHnBkzUJ3Xt1LFHxgmvZwPlb+2GsuN6mDHLYLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN0PR11MB6136.namprd11.prod.outlook.com (2603:10b6:208:3c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 11:51:29 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 11:51:28 +0000
Date: Tue, 18 Mar 2025 11:51:24 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 0/4] remove driver-specific logic for AVX builds
Message-ID: <Z9lePOm9TEz9AXn-@bricha3-mobl1.ger.corp.intel.com>
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250314174439.112658-1-bruce.richardson@intel.com>
 <CAJFAV8w_gdDZ49nJNMxaxvk-Sv8v6T_FK6nWbVyaoKELjaJRUg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8w_gdDZ49nJNMxaxvk-Sv8v6T_FK6nWbVyaoKELjaJRUg@mail.gmail.com>
X-ClientProxiedBy: DU7P195CA0017.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN0PR11MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 008f3f9a-ea3d-4ce3-355e-08dd661337fd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LzVqSVMzWmZaaXhDcWJtYmdrSFRHUUtGRTdab3NBZlhwMDBIeWxhYm9GOGlS?=
 =?utf-8?B?LzA4dzJKMFIwNnRWcEdlRE1jSHM4a2krMVFpK013eFZBc0tSdG0zMS8zVkkx?=
 =?utf-8?B?K3BIM3lNRzZYN2Q2SDBNZnpRZWpiSlZIRUxJOS9MajN5dGxlelFqaTdyWlBT?=
 =?utf-8?B?Y3d4SlF0dU5EVks4azNiK2JFL085c1FtbnZOV1dpUGVFb01ZTVd3UVBIUUc1?=
 =?utf-8?B?M2hPSThrUFBhRWs4UHFITFRGbVhDbWZuVlcwbGQyQ1lJU1JxdDVTR09IR0h0?=
 =?utf-8?B?OGpYajdOSk1MZkQ3MXI2cS9seFdQanFXWkMvamRYeCtqS1lyaFl4UHRQby9P?=
 =?utf-8?B?aldSZUQ4ditYdUNqM2R0UERLYW4xUFJMazlJSHQvQWZYT2R3Wmd1ekNRY0Qz?=
 =?utf-8?B?aTBvN3haRHBwaWxRYlQ3ZzNYM2QwOVhJc0p1d1RQNHFQckFoUGZaT1pBd3FX?=
 =?utf-8?B?OForQUNlQlNxZ0ZVQTZTYmNDZTN3M0h5c09KNlNibGxDckQ5WkRVMXJ3Y0VO?=
 =?utf-8?B?bnZnWk4xMTJVRERjbTEzcmUwWDVTb01BTlJnaCtXTVJlS210RERIekpnRklC?=
 =?utf-8?B?dUtRMG9OVWwrSGMyVFhDcldsNjR3K2Z2UEJ1UlRFSi9sOHQyWG5uTVd2NkJF?=
 =?utf-8?B?Z1Y4SkkxVTNDME1JOEpFYlFGeGJwTDhOZU8vcnFzVm5kVzJ6Umk3aVhDRUxY?=
 =?utf-8?B?YXV0WmNuVmVhdFM3bWQyMjJxTCtJOWRHcEVmTjh2MXRSSjlXR3BXNGxjSFFZ?=
 =?utf-8?B?a2dRYkNuelJLdXo4eVE4cXhlZkQ4SFN4NHFjTjZzSlZZKzlYZmVtYXhWL051?=
 =?utf-8?B?d0NFSFQ3d01KN3FaN21jVy9jcXF5UUVxMzExL2tCUS9SYnR0N2lyc2t4OVRE?=
 =?utf-8?B?OW9CZ0VJR2NNL0x2T01Ic0g0dGd6S2hod0lKR0xUSE9vV1IxQ0phY2xrVkph?=
 =?utf-8?B?WElKVnFFM29zaG5hV2ZyRW4wcWtVNkZMWDJ1ZTFBS29OTlRqRFp4Smw0UlEz?=
 =?utf-8?B?SVBtZittWk82WUdsTmJGMk5hQkppTmpSUWQvU05ZTG9tTFo4aURZWUZSellW?=
 =?utf-8?B?VFZMcTJkS2hmOE5TTElmMm0vZXpGeUhDSEpNZGhKSVpJRGFWNnFKNGMwRTcz?=
 =?utf-8?B?OVpVVjZzNzJpUWYvZUFveC9HZnFDQW9lQ2ZJcEZHTkRKSnhua1NURDRkemJl?=
 =?utf-8?B?RGF3bDJweGRyeXU1Y3E2d3ltbG96cThOdUZuMXRtZUNqb3pTODZ6Q0JLaFZp?=
 =?utf-8?B?UjY4SmVMbk0wSWtsUTFUd0RLWUZ5eGZNWUdJQzdYRkFjRk5ERnhvZkdUQ0tE?=
 =?utf-8?B?bzIvRGx2Yjd1dmxkMU1SK2pqS2NxR0VwOHNLU3k1bmFZcjd0YnRDZWR6a3Jv?=
 =?utf-8?B?RXVaV01VdnBCTExSY2VtYmEyc1dNWitja0lqT01EZ1MrTkwrU095OWxYdHM2?=
 =?utf-8?B?b3dBNUdTUkpFNWx6L3NhRUttNERpTlljaFM2VUZSOWZMbUlLU1RHRGtMd3hr?=
 =?utf-8?B?ZDVzY3FxdjBTL1pPWVVreGZXb2dLeHBHUzhlbHFucXFrS2h1MWYzOW9LNm9k?=
 =?utf-8?B?NnZ6ajdlVkUrUUIwbWQxSHl4UFdTbXdlajVRZ201Q3Vnend1WjdzRWxENytw?=
 =?utf-8?B?ZFNVYmFlR3Ewd3E5SnFUUUE0c2hTY0N0VVo5MlhTV2xUL0xBQVpFOHhWUUlq?=
 =?utf-8?B?dWpnTEN6UUFPZUZPVFp0V2R5SnBseG93NFkxYUdPYytFY0JrWEpucU5xbWI4?=
 =?utf-8?B?VkxQcjFIU0ZyWVhUenRwRnZjanRGNUszOG1lOXpaS2JVTjFpNFZmbEtpZktt?=
 =?utf-8?B?WFhaZWhydER4OHBkS2hMMHl6VkJUdVNLTE5XVGhrdWh1MmdNUm91djVxbW9q?=
 =?utf-8?Q?xOx+/xfmyxxjV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGdUSVY5dHkvQ0FTTTF2TWlHNkNsd3lxRUVUNkdmV2FsSHBTNnduMmJUMm15?=
 =?utf-8?B?a0FHcW83d09OYkZkM3BrQW1ub2V6eXhMTjZqMTE2L2IxNUprU3pUMHdmYkY2?=
 =?utf-8?B?elljK093OEJxbnAvYlNRYVA2U3RUMXFhcmRMelF6ckx0SWFqZ1BncHJLTFIv?=
 =?utf-8?B?UzVMdlBWN1ZmZWk2ckVoT3dycTh4WlhWekZnY2tnbVQ0VnIxVVkvRFpNMUxC?=
 =?utf-8?B?RXlCOGpicmxzZjdaRVc1SHdycVNjMmRnT2JOUFpmWmY0ZXRuK29oYTdUM3BY?=
 =?utf-8?B?OE9zc1dUaitwYjFsY3V4NmdCbitscUhERFFWU2xvY2phcWlmRFgxZXlnNS9y?=
 =?utf-8?B?YUV0ZW13NS83Q0NsMy91N0dHOHlaQTNhRTVPa2ZXV2cyWDVORTJ1aWFGVnk4?=
 =?utf-8?B?V2FnMlZoZTN0V0c3UFpSOHNFWTJ1dDh0Mjk4WnhoQlorZ0VRT0xoUTRFQlZY?=
 =?utf-8?B?aXBtZFhhSy96emp1dWJSaEVIdUcwblJ3Z2oxZGMwc0lXazFDUDQwR3JVKzd2?=
 =?utf-8?B?SU5xR2tIMzJQTEJSUU5qa3BFditBQ1JvdmQ5TEY2aXQ1dStXTGFBeEpvNWRJ?=
 =?utf-8?B?TXZmTFBkTVIwSTFvUXlpS245V0JrR0dxem1CMDR0RmpCUVJPUHg4SCtOaFh2?=
 =?utf-8?B?MG93Zk11b1BjTjZSbEU1bUxlNTJCbjlhR2FkWUpVY1FRSDloK2JwOCsyOGFS?=
 =?utf-8?B?cVJBbkliay9yUzZFZTFERXpWMjNrVkN4U1NqUms5cWs3WFFTZG9GcVRoK1dh?=
 =?utf-8?B?SEdBVTlySVlEcVVCMklwcC9YNDRHVkdnZVg5NHhMMk5HSW5Sdkp5bGRGK0sv?=
 =?utf-8?B?cEN0Qk9iVUZmaUxWMmc1ZmdpNUtWN3dpMkxsdlAwWXZ2RzAzUWhpMkIvRjdz?=
 =?utf-8?B?QmxuZnpMWWZQK1hZU1ZuU09zdHVuMncxR1BnVmRQQjNZcjhnelQ0dU5ZNmVH?=
 =?utf-8?B?bFcwSWpiSi9FZVhpTUVoMWExRmJMd2ZjYkw5cEdvWG82elZsdE8wOHhCbFhH?=
 =?utf-8?B?ZFZDYnhCSm90cU83T0RRT2lDZFE4N0xlTU84SnlQVEhuSzdCeWJUTS8vaFE5?=
 =?utf-8?B?eVJScWJSclFuLzJTWHN1eU9TQ0kyOW9qWVF2SEd6WDA1MVNoQitDTjZzZkZV?=
 =?utf-8?B?NTRLK05yWSt1K2MzbXdlZkNlT0Vrayt0ME0vcU9OeHhzKzJXNUVDM0R6RTMr?=
 =?utf-8?B?cHdxakRIa3NqNi92UzFZT1ppM2JBSHJYNG1icU9kdTgvUHNoOTVnM2hyOE1B?=
 =?utf-8?B?L1BGTVBnd2JJSWhpUXZCOEtjcFRzUngyd1BVMksxRVFEMEViYzJ2TFI0U2Ux?=
 =?utf-8?B?SUQzQUxZdWpkaGRTK0RtM3o4OXVuOU8zTGJ3dlhrZjBMK0djY201MlR6cjRx?=
 =?utf-8?B?ZHpVbnVhc1J1UWNEV0VzSys2QWZ4VkNYbzdzN0IyU1d2VktEQzhRNE0yZUZi?=
 =?utf-8?B?SE83QzJiYjg5aDR3dFZoLzNUZ3lXek8wQVlBOVJlWlgycG5tdnozNzdsYi9Y?=
 =?utf-8?B?NGhBSzJGMDBhczdWVzl0dnNPOTcwRDYxbmVMdGcycVJsOHpHelVPdHVPdTAr?=
 =?utf-8?B?SHNEUXFJZGIzY1RYUEdmUkV6YzZuaEFkT2lCcEU5ZHJZeUJ0ak4zdHRPNFFj?=
 =?utf-8?B?Z0lZSXlsNFhnT0hlem0zdG4vaUVzTjhIK3hWVk5JY3BMZnJwZ3Fna2kvMGEr?=
 =?utf-8?B?SlVYYmxXOTZvNDNiV3BpWXhnVGc4QUNObmNIRFlJNmV6MDljNHd3aURMMmRR?=
 =?utf-8?B?djJtM2FPSCt3aHdOc1prWVRJUk9MclFocEdZMnJrYThMRGZsNldYak5scEU3?=
 =?utf-8?B?S2tQVUYzSXNGMTU3Sy9KTVFLdW92d0dBZVd2enNlcFVZd0J4SWZJMTZFdE81?=
 =?utf-8?B?RXhBZVhGTlhvQU5DMXgybEQvWHVkN05LdE5PY3IzWGxyNlVOY3RxRE5XNVNL?=
 =?utf-8?B?d0NxZHhOR21Zczh5SDE4blBRUTY4ZjF6K1ZRN3dJVWdmT1Avelk5bDliTHA0?=
 =?utf-8?B?L3JmVWtQVzBBeEFiVm5zRzZvclhQSEp1bmZVU0syVDhiWTIzeWpOMXR6YlFl?=
 =?utf-8?B?c2dLTE5GV2FhbVVuSGhCNUNNMTF2YUlDLzNiM083eTFLSzBQTjBTMDMyTHZt?=
 =?utf-8?B?cXU1N3BTREZFNEtyRy9ZdkZXQ0Z6WjFHdGw4MS9QRTlSbndMWlRUWERsczVN?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 008f3f9a-ea3d-4ce3-355e-08dd661337fd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 11:51:28.8359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JCW5p8nKC5/Q+9JPLJDAtKETnqTzwpAc2P+fKqz65E1MgXGk09gc0z30IKmhUtqdilOO+djpzTe+czo6xoHFndFNxoSJT8DObmNImvBs64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6136
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

On Mon, Mar 17, 2025 at 10:50:24AM +0100, David Marchand wrote:
> On Fri, Mar 14, 2025 at 6:44 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > A number of drivers had special optimized AVX2 and AVX512 code paths
> > for performance reasons, and these tended to have copy-pasted logic
> > to build those files. Centralise that logic in the main
> > drivers/meson.build file to avoid duplication.
> >
> > v2: add patch 4 to remove use of unnecessary CC_AVX2_SUPPORT flag
> >
> > Bruce Richardson (4):
> >   build: add generalized AVX handling for drivers
> >   net/intel: use common AVX build code
> >   drivers/net: build use common AVX handling
> >   drivers/net: remove AVX2 build-time define
> >
> >  drivers/meson.build                   | 30 +++++++++++++++++++++++++++
> >  drivers/net/bnxt/bnxt_ethdev.c        |  2 --
> >  drivers/net/bnxt/meson.build          | 10 +--------
> >  drivers/net/enic/meson.build          | 10 +--------
> >  drivers/net/intel/i40e/meson.build    | 26 ++---------------------
> >  drivers/net/intel/iavf/meson.build    | 25 ++--------------------
> >  drivers/net/intel/ice/meson.build     | 25 ++--------------------
> >  drivers/net/intel/idpf/meson.build    | 25 ++--------------------
> >  drivers/net/nfp/meson.build           | 10 +--------
> >  drivers/net/octeon_ep/meson.build     | 13 +-----------
> >  drivers/net/octeon_ep/otx_ep_ethdev.c |  4 ----
> >  drivers/net/virtio/meson.build        |  9 +-------
> >  12 files changed, 43 insertions(+), 146 deletions(-)
> 
> event/dlb2 can be converted too, or is there something special about
> this driver?
> 

Ideally, yes, but it's also a bit special in that it only builds *either*
the SSE code path or the AVX-512 one, and has duplicate symbols/functions
in the two files. This is a bit strange, and probably not what we want, so
I may need to do some work on it before converting it to this scheme.

> 
> As part of the discussion on the base drivers, and seeing this series,
> it would be cool if we had a generic framework to specify a set of
> cflags for a set of sources.

I'd rather not have that. Meson doesn't support having per-c-file flags,
and I don't think we should resort to massive amounts of hackery to try and
support this. I think having the same set of cflags across a whole
component is a good principle, one which we should only violate when we
have to e.g. for base dirs, and for ISA-specific files.

> But at least this series lgtm and is a first step.
> 
Thanks.
/Bruce
