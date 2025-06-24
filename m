Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82103C77B7F
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 13:44:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B70D040A87;
	Tue, 24 Jun 2025 15:44:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 7B8774026B
 for <dev@dpdk.org>; Tue, 24 Jun 2025 15:44:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750772663; x=1782308663;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=5hHP7EBO+f/fqOopnjy7Qi3TxrQqatcND7/1A6UTwdI=;
 b=VtU2ndcDB2oq0nirxnagJat5UIkvOmL/TWel9u/vgSMvqIDuX396O+70
 0IcGxbiNA+1lEVRpuK/euk9FUF4CmFLBvE3sBOOZAoVmLHvI6yEZyfKbO
 Om6i9iIwP+jptxHAnQ6psI+Y6IAq/QMkmC12gCoQ+rnHYw1uSX9g9K8W+
 l4RaSV+jfbRRkEgneRo72R6JAZt3vM73qKavVf3bSIaV1ZYHM+zjhwt9b
 g45D071lZi7Flskecrints1M7KQleOtP6mYtMrvfqsqFImCYP5B4ztXEe
 FstE0dp43GKmP0DVHuHTZfVkBlwlCAfMrUhPOftIOJ4N/CiQ+jQ258rBq g==;
X-CSE-ConnectionGUID: 1kVxK8VkRNCJ10/zSRTYxg==
X-CSE-MsgGUID: AYeTVNkFRg+Jdz+Q1Fm7fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="52982836"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="52982836"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 06:44:22 -0700
X-CSE-ConnectionGUID: 5aVs3ywLQp2NZH4v3N62jg==
X-CSE-MsgGUID: 7c9if7ZCQGWS1JzLxgLvHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="155950746"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 06:44:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 06:44:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 06:44:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.55)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 06:44:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3QyPN7ygK5rugvYm2u5wM/FkdlDVyhkrzlCSBlWii4CdDN0Gmkbq33xU/frhFmV0lDDRvLXmI4VLXCKIMp7NKuNYowz+R99BP7Kaq2JvON5Dy3C8hriVn0MHUlyUsrjNM+1x5GdZju1ymsBSLUDsbWeY6g4tRXOJZKzT0b9qX73oNYBpZ92fTkDG6UrNeIlsrO4lUpgjr2GyG/FcyqZ3/bSLT+va90oRRfJR8y6j9ipRmyyxYtDa4j4ujRa+mI9U08tSq+t3CI43N05/5Y4Uyuh4XjdTDKAVu5tGqbz69Be+8RZ3fM/eo+BaKtsKyyIHjbLauGOdNsL/iQZ0fyTKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTfkTud2RaPZMAMXkyCW+ayImAT+UqYGTLJR/PRbg4s=;
 b=weem3C8GnvWo3WKuwwaPQ4EzHH+ChKaNUL/gatNgIyflvPAKwgm70gDxf31XUhPzUxY6Z4iouiwlQj4rp5U5v7eon7ltVXIyfbd/f5wD738jJKNStEkW5StD58GgVM33/mFDsud2edAAikzVehGrOfAICq4k0VHcoI7n4WhT+3GrnLUAS7qlgyfYgGPNlz/M1FZInZyazEIGrT2bH1yBGqxENxdNMuX0NWXWAT9vLBvMw8lcEMoBE245fULhpkqcRXa9gdrIbEknHWJ0Ybn4RfA7xwqSFWfu82r95peAZh43zJ3uc6Z3PqE8z/q5v+r1QyLcoOnCMPcqWbOw0L+W5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN0PR11MB6086.namprd11.prod.outlook.com (2603:10b6:208:3ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 13:44:01 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 13:44:01 +0000
Date: Tue, 24 Jun 2025 14:43:55 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v5 1/3] eal: deprecate old coremask-based EAL parameters
Message-ID: <aFqrm0qh42hLJ2gf@bricha3-mobl1.ger.corp.intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250527152913.279011-1-bruce.richardson@intel.com>
 <20250527152913.279011-2-bruce.richardson@intel.com>
 <CAJFAV8zpV=KUDha1tknK0cgv0cboG0htvJZ1kujtx=EJ7hXQHw@mail.gmail.com>
 <aFl8-3IuF9WU_YAe@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8wTVaEpA4whNtEXbrEpD1Kvny4oNZ_di=-maF+4A+tRuA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8wTVaEpA4whNtEXbrEpD1Kvny4oNZ_di=-maF+4A+tRuA@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0175.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN0PR11MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f0fe11-1776-49f1-750e-08ddb3252cf8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlE2aXl6eHBQbzFadEF2VEdWRFRWV2dWcXVCTVd1Z1g0dVdSRUtKZWtCODhu?=
 =?utf-8?B?Si9Kd2kydkJnL3dVQUJhZk9TQzZZd2NlTWJsenkxOXhMeGtkNTlxNkFRZ1hj?=
 =?utf-8?B?SWJNcVZ2d1MzZWpaUjFvZ0RGSi85NkM3MlN4M2VEZlNrcEJUd3dFejdGcHJh?=
 =?utf-8?B?bTl4dDJsUlhjT2JyTWFxMW8xWTB0ekJlNWJXRnVINk1Wa2VWTlRSNGRCeEdQ?=
 =?utf-8?B?K2tldjJTWmpqemVKazhyenBnODR5Uyt4Z3JYcWFDc05Yc1V5cGxZT2Y5WFlR?=
 =?utf-8?B?Y2h3RVh6U2xMUVJ6Q0YrSVE5QzZWQ0RFdlplV24wVmV1Y2NNZytPclpBTkpZ?=
 =?utf-8?B?WnBKaCtVNkhHakdJMktLY0d6NkFKNTZlSXRRRlpHWGVSZldIdkh4TUFqN0pv?=
 =?utf-8?B?V1pSY3ppbHpDT2g0WGlBRkVwV0ZCNmFoU0FpZzhYYWRHNVlhSVhUWlNLWjVB?=
 =?utf-8?B?QzFodjNoYTQwLzlCUTNsR3BzejJrT0Z2cU0xdXlHb3c3QUZXcWIvRmc3WVV4?=
 =?utf-8?B?aDNMczg0YVpFWmhrNnpYTXlRQ3BqUVIwWjZHOUhBUXhpK0J3QkRIZzFCNVlK?=
 =?utf-8?B?Rkw5UE1KUFFoN3IzUUNPeHdRZjRYWnhXd0hVdmo2VzVCc3VlUnpqVHR3ZXNW?=
 =?utf-8?B?UUJSSDZVWk54V0ZUamtuZnZzYXZpKzRzd0o2bU5oSFI0ZzlOQ1lPT0IrSkli?=
 =?utf-8?B?REVuZlk2QnJqSlRoU3hob3NibzVVd1d3SWttaXZrc3Q1STdIUFR2TVNSRDFa?=
 =?utf-8?B?d0cvOHczV3JhZ2tFL2ZRazc1MDdUOENjcGoxQW5OeVdmYTdEMG1IQkVTei9M?=
 =?utf-8?B?dnQ5aHhNSGxIREdaRGRiQktpblBKRVpTVVBuRTZXb1Z6TDNkM0dXMnkyOTQ2?=
 =?utf-8?B?K1RvV2hBZWlSMVhyL1pLdGlSQm95OVRvVE9aemxqVFE1ZE1qaW1pUW5qOStN?=
 =?utf-8?B?UXJUakpnQWZ3ZVFLdHJZamM3RDI1cmlHK1AzQ3FDOEljaFlqRmdkaGFOMm0r?=
 =?utf-8?B?ZTRhQ25qNFRLWm5Ga2oyRmdoMTlENWJ3SzZkZ3Q4b2x1Vi9iQ3lHdjdGS1BG?=
 =?utf-8?B?VnVYUTRtVGRpNklwTHAvYWoxa0VRR3BnWFl6c0dpb0xiVCtJTE5zMlNhclA0?=
 =?utf-8?B?cFR1TTRrRmF2d1dJNU80UUkrbVNvNExCVVlhb2RUR2tEdE5HeVhSNlpzNWZF?=
 =?utf-8?B?UWx6SEgydUZPdXJRdnNnYm15WnJwMW1mQzdoTzluVVg4Z0tOTm5VY1pOOXVM?=
 =?utf-8?B?UVpkbzhOd2ZqNHN4dzFhWjY4SzRaUjByYTA3Nys2bHE5M29MUjErQ2ljR2xu?=
 =?utf-8?B?dmFPTG1BRGhqb1gzYW1MVFZxbGdnamVHUmdwWS8rQTlQSGtqR1VDT2pVQkVH?=
 =?utf-8?B?Q1VxOUhHVDh6OTgxTWtMTjBOcUdvVm1XNWs0R2NmQWw0bGtGR1FQeTlQQ2Fw?=
 =?utf-8?B?TzhRQ3psZlp4T25NNVpUVEIva1NFWFVldGdmdDF5YmhaNVRCbE9icTd5TUxW?=
 =?utf-8?B?cHgrWmQwYlAvRWdtcDVuaHY2N3JYUmZuR3MzazZ0NFhMdnpGT1FxcWFuZjBk?=
 =?utf-8?B?dUY2MC9nZ0taQlJINE9mLzVmaXVQMEJKZ0tkOTEzZ01xN1h3TW9mS0QzSFR4?=
 =?utf-8?B?dlRBbXptNko5WU9TQlJGWTZvTmxQazRVN0huTGg0ZUF3TGl2T2I2dG1lL0xF?=
 =?utf-8?B?MGNTd1RWRWJUSVc5WExSNEtIbWRrejVoV0RSeDNVNGhCS01BTXlNaUZCSEE0?=
 =?utf-8?B?aW9jS05vc0d3d2U1WDF0cDRiK2k2MVdNMzFabC9IWGpGOTVBNEJqTmdCSVA2?=
 =?utf-8?B?WTlTcEZsUFE1OTcxbzZnUldyUU1NcUx2TEFmZW40Z0NmTVhRL0NaTDR0L0Yz?=
 =?utf-8?Q?/AGS3pXcvtWb8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFhDbXk2RnBqMVhHZ1FPVkRlR1NUaS9jaWhQVDR5MHdkaGFBOWhCM29LKzNK?=
 =?utf-8?B?WmViR3hUN1g2SmY4OGpXQmlSRDE0dW0yWGNUMDVLaGMzS2U1WTB4ZjM0NzZr?=
 =?utf-8?B?L0dsc09CWDc3ZEptVmJSeVBLNU1xVEg5WXY5VVFoQk13NGV1aVQ0b3UrM2pC?=
 =?utf-8?B?b29PcWc4YVZzSlFlS1FJcU9YRnV4MlJLemN0eFFxK1FUZGUwMkVSRk9mZllu?=
 =?utf-8?B?N1V5dGVuTU5XY283dGpDT2VVWjBvVzlzYVI2U2d4WjVzQ3h3Vyt3S1NpMWhR?=
 =?utf-8?B?N3hLL1kxRjR2ajNvRjVvRHRyRjhFckNqNmNheW4zQmg3ZHlNTkJ4ZDhYTk03?=
 =?utf-8?B?VmswQ3NDSGthL2tTQ0MrT1FkUXhMU2hzZWpqMUdpaHJXVW9lTURPSTkyKzB3?=
 =?utf-8?B?K29XenB1OVBxYzNqY3VTeGpYQW1vbGttQzRYMDcxU1hDZW80R1JPOGk4bldy?=
 =?utf-8?B?bVVySFdMeDVqMzhDNXNpZW1QZUIrVUlXb2xDRjdvRGZRWFFOUXlkbktTR29B?=
 =?utf-8?B?c2pjZU8waVQwcmxwYWNudmxXMXBzeEdzUnhxTFpJTHdpSlZXdkM2RDhWTkdN?=
 =?utf-8?B?TmtMblJ3bkNNdThtcEZ1WG15cUtCSmhPdWkvUUFMNzRSYU94Q3FBZlJSZmh5?=
 =?utf-8?B?UUxuODhpaG0rVXFwNmR0ckJTdG1PL3RVejMyTXU2MW91U2ZaSFBjREFIU1Ez?=
 =?utf-8?B?T0M1TGgzU0dEaUNSRFpDVjBMbkIzdlI0cVpyRjk0c29sVmhDK1N0K05OU2tm?=
 =?utf-8?B?UEcveElndVVkZ1cwMUlyV1FweTc5K0J4SG1Mdk1FamZxSU1sSWRyeFlOays5?=
 =?utf-8?B?UGxub2hpcDVKRXFpVFpPNXBZbWxIUzJkZkpsV041S0F1L29RQlFIZlBRZUdu?=
 =?utf-8?B?RHRJZWt6eUY5UjZ0UG01MWNyUGh6MnVWZ2hjTFcwN1VFWlhER09FK2M1aGhG?=
 =?utf-8?B?YVBjWHJPLzRraGFIanRnaXFFbzBXa3N2L0RHeXJTUEM0b2JZQk5kVlFNWERM?=
 =?utf-8?B?cDVMZE96dHZ5aGRqTVI2TjA4a0ltbFdCb0JJN0FxRXN5NXhTbUowQjlUQUZn?=
 =?utf-8?B?eTB1UERWNFYvbG9yYlFqS1AxSStXREVSc2dkK3ZaS2pVclJRSUt2QnB0L1ps?=
 =?utf-8?B?dUZDbUt2a1g3WFAwLzVGUXFpTzV1cDU1Q081NzYxTEFWTVd1UXBNTkVCMFdt?=
 =?utf-8?B?a0ZDV2ZxTHRZbWZvRzhJMWFtdmovTVZ3Q3dJTXpta0xUZTBiYm9yYm5pOEU1?=
 =?utf-8?B?bXV3VUJQb2Z3bThrMDlybnR2NVJmTldhcjNRS2dMeHZ6QWxRZFJ0TURPWHZR?=
 =?utf-8?B?S3pTd21La0NhaGQ3VzhCeEV0YmpiRkM3NTZrWEQyTFo4aTdPdmxpdkN0R2Zy?=
 =?utf-8?B?TXdUSVpxK05KUndHNER6YnovMWZHcE85TEtYaUdpSjZ6bjEydTFEb1NNQWtD?=
 =?utf-8?B?TFBRQmJ1TGJ5RGxJVkNDQWJKaHplYURNRkVyTC9FWTc5c3E4SjhqellIVXNM?=
 =?utf-8?B?MytYTlVzenlPSFl0c0h3VjVrVDdMUnF3WDU4dUlKWGFvUzdTSmdtMW0wakJU?=
 =?utf-8?B?QXduQzJyRFcrWTR0Q1ZmU2tjdWVNaElhNTVXRUdOQUdVbkNoNGp3aVIwamVW?=
 =?utf-8?B?VHZjb2MvTk0wdWZMLzFqUVdxT2llanhTQXRTcGI4YnlaV2h4UGJDeHlPOENM?=
 =?utf-8?B?Y2R4SGMzVnp1SnBVUDlnRlhnaDFJaDV6MGU5dDRmVHJQRDZHRGxaWEJxYTBy?=
 =?utf-8?B?Q0w5Y0g5NFVDVmx2SVY3YkIyS1Zyc1NkSmN5a0RjT2RkVnBtcC9VMjEyaldW?=
 =?utf-8?B?Sjh1UE9SVzRPWnJwSzM3SWttaE5US3pkSmIwS3NwNmFLOTV6T0pOOThidUxN?=
 =?utf-8?B?UzRJV1VYd1k0UmFBWHdNSkZxYXpDaitjOW5yTm9KWXlwbFk4SEk4Q2s3dkho?=
 =?utf-8?B?clRMRCtTcS82Tm1XaXR6T0syV3hyUXpLeTIzbzlmOFVRZGZicmh3TnBVdTV6?=
 =?utf-8?B?dmtFa1lBOWtFOEllVWNhdXMrR3Vib2N2WTdqSVUxM1lKdStnMVVJWGNqVDFB?=
 =?utf-8?B?eEtVMjVVRWltVm9tMkNuTndieDErRmp0Y2NUNGgxVnNMNEYxL2x3NVNZTm1Z?=
 =?utf-8?B?WEVvcWlXcThtMmhqazdHSW9lYXU5TjhCc2ppUi82UFNoclA5d0FMN3MwY0lj?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f0fe11-1776-49f1-750e-08ddb3252cf8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 13:44:00.8560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +eCm3hloyRVxedeON16YvMUe910Zcc4hwBh5f69ZUZegr6kdp+rI8unkrfzvNr4edxWMab9ZYuZvoxbuVbNk51/VciNyidNLtWLWy+pyncA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6086
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

On Mon, Jun 23, 2025 at 06:44:55PM +0200, David Marchand wrote:
> On Mon, Jun 23, 2025 at 6:13 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> > > This patch will need some rebase.
> > >
> > > I see you fixed a few docs, but there are quite some misses in
> > > copy/pasted blocks:
> > >
> > I'll take a look and respin this.
> >
> > I'm think of separating it into two patches: first patch with the doc
> > updates to remove use of -c flag. This should happen independent of the
> > deprecation, I think, and second patch just the deprecation notice. Does
> > that sound reasonable?
> 
> Yes, we can already cleanup the docs (advertising lists instead of
> mask), and then have the deprecation notice.
> 

This patch is now split into two separate patch series:

https://patches.dpdk.org/project/dpdk/list/?series=35540
https://patches.dpdk.org/project/dpdk/list/?series=35541

Regards,
/Bruce
