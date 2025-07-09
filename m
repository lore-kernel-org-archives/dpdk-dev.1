Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63684C83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 11:44:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49819402A9;
	Wed,  9 Jul 2025 13:44:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 866694021E
 for <dev@dpdk.org>; Wed,  9 Jul 2025 13:44:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752061479; x=1783597479;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Ig9vu4/d02a4ofDwXXZZtkZLmK8gUVhCw0WZTtQw5QI=;
 b=IhyHWO8/vr8qRSeMh+6NE+W69PNZjwKUDtbkoNOsI8Ln66cfeCPdLrCe
 T+XfdAbZ61FE9QZGzrTTYVDACN8UtjPILZ7+C/do08nuOmXxApHJctkxo
 nhYE/22OaKdqvPDOOu0L0rS/OqdqQuvKehV7hUFvuzNPyxCSirxOvYYio
 ZXnifXiRBbDEKQZ91hT3AVcwm1hHdaOuRGYaP2i0/VoY7Sr86dwCxviyZ
 j3PXjv9bN4FkDvlSfouoNIDFHTWHzhZEkgUCR4lcmHA2G7FZ30rU1pluS
 rqWdqHcsVkLKfuz9iOovjrGj5ToO8KZBjeIB/tBcZQtv/L6I9jdDOKdTe A==;
X-CSE-ConnectionGUID: iwwZjLnRRqCoWZ68QNfwOg==
X-CSE-MsgGUID: i8LzHVUITPCtQQeGTkOhkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="65667685"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="65667685"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2025 04:44:38 -0700
X-CSE-ConnectionGUID: jtn4tw0PRpSHxZ3MJJ7Lyw==
X-CSE-MsgGUID: cE5NikeHRX+d7u06I68dBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="160076529"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2025 04:44:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 04:44:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 04:44:36 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.43) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 04:44:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HH3pSCxMEM/1TT3TbKmZikGgfvbNmynrPFaReMhRbo9FSt6jcZyaItdWcmR6em7MqNpiNpK4wAJjX/vesgbuAkU45swihb8gw/kPnJ9qJ2rsx8tCUk0l72wABtWvGXiHkTkf4KaPF8uE67hKV3ymZFF7Wsi1kA8brZoE26ZzwMkAA4Y62PQQwoQycMvWY9O/P/Md9hbo/VDKPJhWkoCULbta7jecWWQAZyOebA7baQ2vgmanUX+f229Zr+eCD9Xy5Mj6vhxHfZDFPPu8TDaObu4flndVHd4NWQJ43e3gFyOXopvysYzgrmxlXBKTm40MXA/VsiBc/UpAyDpM0uiWNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99IIIZQzqL4Xxb7h6cVN7gd4Za9MTqx2Oqe15udBz0E=;
 b=hHs+x3rMSLCuV5hc+wzp42UMfctS5bnZWG2C8qAXlJ9DGZLPWfNEfVWXvLDNdOZmIMwareGQ5TnCaQcO6a0pWd9JEPpaX6j0TjpidBbGKewYZOEIS/sxuAft6YCYsfzwvtylwhxA4AjKv6QemvTyajVTdaod8TFOwl6NcnJNRrWhscdZAx5yQub58ZKth5SN3cvDczPHXhkfQR0k1UkSmySkReIb/zXKFmv08K03QNNPRFFG8ftVrD3OhMXRVt/gQVTnLcYDxdlM82B4/aWD+iE9Bq9jQ3DtCf+u98z1YZr6qNutdXpuqHKuHArRAHXwULF9Qlrk7fzkiIS3y6im9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7339.namprd11.prod.outlook.com (2603:10b6:930:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 11:44:21 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 11:44:21 +0000
Date: Wed, 9 Jul 2025 12:44:15 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Vladimir Medvedkin <medvedkinv@gmail.com>, Dengdui Huang
 <huangdengdui@huawei.com>, <dev@dpdk.org>, <stephen@networkplumber.org>,
 <thomas@monjalon.net>, <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: Re: [PATCH] net: support VLAN stacking packet type parsing
Message-ID: <aG5WD8YfiZyRiURS@bricha3-mobl1.ger.corp.intel.com>
References: <20250703093027.1259459-1-huangdengdui@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD8D@smartserver.smartshare.dk>
 <aGe7uxORe1V817a2@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD98@smartserver.smartshare.dk>
 <CANDrEH=NEpj8X-8e6JXGVAMGXuykp1bgOMKyLFm1TPBEovdx-Q@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD99@smartserver.smartshare.dk>
 <aGzv-gld5GAFO2N0@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDA6@smartserver.smartshare.dk>
 <aG02GA-OTVVfR50n@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aG02GA-OTVVfR50n@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU7P250CA0029.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: d9fbdb1f-7b63-4716-7673-08ddbeddf1bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUFpcWROUmVCL3JIWVNXeEZMVWh3L1RHNnRHUlpLaWhLbzhHRVBOaVNjOHJo?=
 =?utf-8?B?WUs0REExUFlpczRDQmNINlpNbWlUQVR1SGVER1dUZkR1czZWQmNxR2JZQUNO?=
 =?utf-8?B?NkZReVpXS3F1Nk51WDRnNDJaWXVhdFZwUjZJZlEycS9pdEZEN2JDbkJncFBa?=
 =?utf-8?B?OWlUZ21tRmdoTk0rV1FCTWxVR2xOem9KZ0ZZWjF0VTJhU1c3Z21rS3A3Q2NP?=
 =?utf-8?B?VWV4N0p5VWRTdUdBK241UmJvQmVTUzJ2WTQwOENpOEJCSDU2YWtDQVcrSUZm?=
 =?utf-8?B?bUtNRlNpNCtEd0cwWHdLak1UMUdONmliek1MaUJqREliTkI2OEQ0NSs0eFdC?=
 =?utf-8?B?eklnR2RLSndqVTMzd2syNXNmT0NrOXNDVUlOYjlKRVp2djA0UDdvQmxQalUr?=
 =?utf-8?B?aWJ5NHNHM3pwRGdtc2xFUnNuQTZ1Tit2cGRRRWU2MmxHY1ZNUHQydkRjb2py?=
 =?utf-8?B?S3BoZXo1MjBxMDY2bys1V0EvdW1OTFVyMHdxaUhmRjRVN2crRVA2cU1hUEpM?=
 =?utf-8?B?dGlWbGlmSng3TTZYajBOMlNPK1FIODJ3a3FQS0hCUE1nMjZ5VUtBUEtVRk1C?=
 =?utf-8?B?dXlBODgvSFJBSnpNaTB5ZzRRdzl3bWJBVEtWQ0lLSmt4aFFnMVFHUEpRdGJ0?=
 =?utf-8?B?RGdJbWt5V1hIOTB1MHN4YkRGY2NvaGJQQ21UbDkrU2JGa0gwSkR0dlN5SFRv?=
 =?utf-8?B?eEFBN2p4c2o4R3lKWk8ySkhDby81NENUS2tkcDVKbjMrMWIweWppQmd0RUxY?=
 =?utf-8?B?cmZreEtQWXM5TjEvNHBJYTBLVnorcUk1c3U0M3B4R0F6VkJUNjM4d0kwN1Uz?=
 =?utf-8?B?L0p6dmgzQWZpejhXd2ZaWUVicDFBNjRiZ2tnMzFydFJTUmFDNjhzVXhtaytH?=
 =?utf-8?B?OS9sT2g1QmhUbzEyNlJOV3A0UlM5bmdRVjhwVDVnaDNDV0U2aFNrMEd1VE1q?=
 =?utf-8?B?NlpBaDNzdTBTWmcyY0Z1NGZiSHNLTUlUcTlzUW1TaFFjYUxyUENPanUwYXg0?=
 =?utf-8?B?TWpYSURFWE8rL0NQTzEra25MQ1d1S0kwencrNXgrNDhIdkpCZHM3TURjWG1V?=
 =?utf-8?B?cU50Y05ZWThvWUtVOEtYWFpOMHZScEw4QUZmN2pPaFZjZ0VmUURYeCsrRXN3?=
 =?utf-8?B?RFExOHZ0OHlYa2lOcm80Z3QrbzFkUm5oa1E5RlE2KzN1MmJ0TGZ3RFN3U2hi?=
 =?utf-8?B?WUdSUk1qOWo5VEZqdEMvNTZJb29KVTFHWE50T3dJTTZ3QkE4NXNzSERhblEz?=
 =?utf-8?B?THZDdWJrMVkvUGFEMkpSTTBnVzFaaHd6V2RJTERoaXdRWmZuMThFS1BEeWRa?=
 =?utf-8?B?WkcyZmNLdndmcHN4K0RiczR2anpJZzhhSUlFU2xQTTFBL1QzT3h6MFg5MDZ2?=
 =?utf-8?B?SzJwSnI5b0U0ZU02Z1hCRDQ2MnlOTkxZS2lRQm53MFFSK3k4TUIvaDlVMmxB?=
 =?utf-8?B?Qi9FTUliZDI3RUZsR1dVZzZOREpEdkNnZHBQRkdySUdSd1Y3UFBIYTlOZlh5?=
 =?utf-8?B?MHh3T0x1K2dQYU1yUFBMWU9UWHZ4NGNraEVHbXRpaUxUWXBwd2sza0NsVUNi?=
 =?utf-8?B?Z01kbHRsOWZJWkVHMGZHRDAvZEEyaXZtSVFnRzVtL1NYVG1FOEpjbEtCNUlS?=
 =?utf-8?B?VnBMTVlRNVc0eVlTczhtKzAvdHZpRTNRYnphaEVoY2cvaTN1MXVoL0s5eW5P?=
 =?utf-8?B?bWY0NWIrZFBCdy9hL2VqeEQ5NmFMOGN0VDB6SkhHTHNHU2tiSXpJbDhUc1lN?=
 =?utf-8?B?Yy9IVU9YdW9RVlBlWnpyRGw2dWNYa2VUVElyNGtTWXRQendPcW4vMWVuMmFj?=
 =?utf-8?B?SmVqcmxKSU9qc05QMVlETmk1MU9wSzZoQ3VHZnNIOWhhYmJWWTZEZGMvblMr?=
 =?utf-8?Q?me8Ky0Z1RPehq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2x0MHdFZDQwZEpaSEhMQnFyUUh6aENvMi9nRE8yYVdPMmd4Uyt0SFByb3Zo?=
 =?utf-8?B?UjV0cDZMWFlpb1c3alJQVko5L25SSmtLdnVOYjZoL05TbnhEMDkxb1ZCeVRS?=
 =?utf-8?B?OUVUcEdYeHJ5RktXWnJzQ2M2Mmg3L1R3L3ljNm00RGc3Z0N0cVM4SzZkTEhM?=
 =?utf-8?B?T29oSXBVTUNpVDIydVptNDBBUEVUekhPSG9XdXE5UW9MdTBIOGNsNkFsaEpM?=
 =?utf-8?B?ZStKK1MyUGNSd21WMHJycW9KMmMxQUVRSUtmakVEbHhQUGV0SHI5WEE1V0kx?=
 =?utf-8?B?dng2Sk1GSnh0elcxUW9NZkFpamY2M1VURjJHek9Lay9rcklUVG4vUHowd1BK?=
 =?utf-8?B?YU9sQlNmbU0zWXhyVGFrK1NwVkR6cHlqWUtQN3o4UXpQNnh0OVVzaXpHbGlj?=
 =?utf-8?B?TDI1WG1iaU1VeGZQWEdTVGFvcnlEeldUbVFHU0FvbE9wOGJGb013eSs5c1JW?=
 =?utf-8?B?ajlidU9zQTJDaXFaTHhJbGRjME1VRm4xUGFwbGlIcHAwRUJPRUpoWCs3N1hD?=
 =?utf-8?B?bzRCQzVObFJlMng2eEZjRllhMGtBSTV0aVc1eG5pYWhwQ1FzVWRKaUhLYkwx?=
 =?utf-8?B?Y0lHNWducERJdzUrSE9xS3JGWWhkQ08wVEg1OC82UGhnck92ME16dVk3dUxY?=
 =?utf-8?B?WGRnQk9PbmxXeGZmOXo2Y1V3SnpxTTNubEFiTDJvUlpyVElOQlVMNHhDd0lC?=
 =?utf-8?B?dngyblVjZlFNbFhPdnlrQkl1M2hMcGx5L3VBeDR5NEZQR05CWWk4R1BXY3JD?=
 =?utf-8?B?aDMwcnpObEJFSUI2czJJM3FCTFJTMExqNGhtenUvNVM1cmRVWUJpY0NPUjlN?=
 =?utf-8?B?MXVKT0VNcnJFTFd0YmhVZ2NSbVJCRjBWTTJ2NEVQdDBYZVh5R21CdUtmNmtn?=
 =?utf-8?B?UDJZd3k0dWpqazNVZWdmcmN4YmJCOHc1VFJDczkzTTF2LzQvQlREM2hrVDAr?=
 =?utf-8?B?QVI0R0kxVU9zczJmKzY2NUZaTkZjSVdtbW1EVGxHazlvb1BVZzBrWUIzM1F3?=
 =?utf-8?B?M2hhNkRybnZxeDdiZUw5ODg4alRYbGFYZzRaTGVzNWxxYTZDbUF2VUo3WkJt?=
 =?utf-8?B?RUNwMElrYzFjQzdXeFFlTE1wbHV1bC9tRmw4a3ROWno1d1B2YnlCV09Db1JN?=
 =?utf-8?B?eldoWTdaVVRpWDlXYU5jbGlwUnRZYTZycFlkU0hCZHA4NnJBa3ZUN1VkYjZi?=
 =?utf-8?B?YTB6Wk13MElYRzFlWk1hUU9oaXE3Ujd0Y3hqdVpQVjZPQjdQMmNDNHVGT2xK?=
 =?utf-8?B?WXBuNm9PV09VN25KQTdtZkZWVWliRFRNeGhhTm1YMXdGbUJuVHE4bkJNYjQx?=
 =?utf-8?B?SklRaHZFV3R5MldVUlRsOFlkdnorZzJMdUROMlkvUEx0UGF4emxZRkh6alFz?=
 =?utf-8?B?cFZ6VXIyNWowcXM1TDlFLzVadm1IL3htanNNS1hZelBMei9Va1BZYktVbzhM?=
 =?utf-8?B?cytrNkRCQ2VwdTE5MzNmTXIxNURLVjFQQVhKTWFTWXdqa0Vnams5aDgrUys4?=
 =?utf-8?B?YVNiQkFObmV4ZHZqU0phOWdsdWVTSG85dCt1STVLVVo0d0s1YVpsRFJmVklQ?=
 =?utf-8?B?d3ArNlhmUnZDSE1FVG1xQmtWSzBxYnJKSnZmZGk0OFBZaTZybWszZm0xT2Ja?=
 =?utf-8?B?MmM3dFBSN0FOQWxnRkEwVXJPVkVrb2RMVU1ob1JONzcwMGtHRHBmVEJUSG5S?=
 =?utf-8?B?ZzROM0RiQy9YU1UrbXloSlNnSjVqSDB1UU9SZnZDYVI0L29NVWc1NDQ5K1Fh?=
 =?utf-8?B?S05jNk1HSkY0UGw4cnREc1ZXaml0RTZEaFNPem1ZSHZYckN6b3R4WGdnbXBv?=
 =?utf-8?B?T2JISVlYcDg1VVptMGtPdklBSE9PaW9GYWJ0SzA2eUd4enBaOWdZZndyY1Zw?=
 =?utf-8?B?dXZwNldTdGtBMlJUdGlHK3VIVy81WWNpOUxTdnc5aXp6THQ4QVJRL0Ryd1Z2?=
 =?utf-8?B?eE95c2NsdUxRRVpBMTR3TWtVY01veDJkZit4QUZKa0Nka3ZRY1dCWTNiQ3p0?=
 =?utf-8?B?Y1YrRk5EZEhkR1NLa2RNVGZDbTBpWWlTRkpLMGpLRXgvR0FYaThPSjBvclpB?=
 =?utf-8?B?WkJNUnNjVUZJd3RtNENYbTAzVEVuKzZzVUdDSFZJYXZXSkcwcmxZa2JNbTRz?=
 =?utf-8?B?ZysxanJIeHJFRXNsZ2orSHpTaXlaRVA5WXlQRU5DM2o5d01WejJKeGR3SXo0?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fbdb1f-7b63-4716-7673-08ddbeddf1bb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 11:44:21.0459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uAsK68MG6wRN0wQT6IIl+hFbh/YtAFUEcYBuERRiN4pPxOxsOmzNHHsJYJgujzT77WwJ3Xps78pSMtwC0bw/sgB3w7bEyEz1d/3VB0xrdGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7339
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

On Tue, Jul 08, 2025 at 04:15:36PM +0100, Bruce Richardson wrote:
> On Tue, Jul 08, 2025 at 05:07:05PM +0200, Morten Brørup wrote:
> > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > Sent: Tuesday, 8 July 2025 12.16
> > > 
> > > On Tue, Jul 08, 2025 at 12:00:42AM +0200, Morten Brørup wrote:
> > > >    From: Vladimir Medvedkin [mailto:medvedkinv@gmail.com]
> > > >    Sent: Monday, 7 July 2025 22.10
> > > >
> > > >
> > > >    Hi Morten, all,
> > > >
> > > >
> > > >
> > > >    пн, 7 июл. 2025 г. в 19:09, Morten Brørup
> > > >    <[1]mb@smartsharesystems.com>:
> > > >
> > > >      > From: Bruce Richardson [mailto:[2]bruce.richardson@intel.com]
> > > >      > Sent: Friday, 4 July 2025 13.32
> > > >      > Hi all,
> > > >      >
> > > >      > this email discussion comes at a bit of a fortunate time for
> > > me,
> > > >      as I'm
> > > >      > currently looking at our vlan tag/qinq stripping behaviour in
> > > our
> > > >      Intel
> > > >      > NIC
> > > >      > drivers, and there is some discussion internally as to what our
> > > >      driver
> > > >      > behaviour should be compared to what it has historically been.
> > > :-)
> > > >      >
> > > >      > The documentation - both in the NIC guide [1] and the testpmd
> > > >      guide [2]
> > > >      > -
> > > >      > is rather short on detail as to what exactly the behaviour
> > > should
> > > >      be
> > > >      > when
> > > >      > vlan strip or qinq strip is implemented. Therefore, I'd hope
> > > that
> > > >      those
> > > >      > more familiar with networking than me would be able to help
> > > >      clarify
> > > >      > things
> > > >      > so we can document the correct behaviour precisely - and
> > > hopefully
> > > >      test
> > > >      > our
> > > >      > drivers against it in future!
> > > >      >
> > > 
> > > <snipping full discussion for brevity>
> > > 
> > > So from the discussion, would the following be a good set of guidelines
> > > to
> > > document for correct driver behaviour:
> > > 
> > > * VLAN-strip always strips one VLAN tag if available. If multiple VLAN
> > > tags
> > >   are present, it strips the outer.
> > 
> > Yes.
> > 
> > > * QinQ strip, strips two VLAN tags if present. If only one tag is
> > > present it
> > >   behaves as VLAN-strip.
> > 
> > Yes.
> > 
> > > * Specifying both VLAN-strip and QinQ strip is the same as QinQ strip
> > > alone (??)
> > 
> > Yes.
> > 
> > One more thought about this:
> > With QinQ stripping enabled, an mbuf for a single VLAN tagged packet will have the RX_VLAN and RX_VLAN_STRIPPED flags set.
> > So, considering this output, it would be reasonable requiring that VLAN stripping is also enabled when QinQ stripping is enabled.
> > 
> > On the other hand, that might be a new requirement for applications.
> > So backwards compatibility speaks for making the VLAN stripping configuration "don't care" when the QinQ stripping configuration is enabled.
> > 
> > > 
> > > Mbuf reporting behaviour:
> > > 
> > > Input Traffic		VLAN-strip on		QinQ strip on
> > > --------------		-------------		-------------
> > > Single VLAN pkts		Tag in mbuf->vlan_tci	Tag in mbuf->vlan_tci
> > > 
> > > Double VLAN pkts		Outer tag in vlan_tci	Outer tag in vlan_tci_outer
> > > 								Inner tag in vlan_tci
> > > 
> > > 
> > > Does the above seem reasonable and correct?
> > 
> > Yes.
> > 
> > BTW: I think that having double tagged packets on a link configured for single VLAN stripping is weird.
> > But describing the expected behavior is good!
> > 
> > > 
> > > My one (minor)concern would be the handling and placement of the single
> > > tag
> > > in the QinQ case. Depending on how the hardware treats a single tag in
> > > that
> > > mode, the data path may have to pay a penalty if the HW takes a single
> > > VLAN
> > > and places it in the "outer" position in the descriptor, since it needs
> > > to
> > > go in the "inner" position in the mbuf, necessitating some conditional
> > > logic.  AFAIK (subject to me actually testing for confirmation), this
> > > will
> > > be the case for our Intel drivers.
> > 
> > If that is the case, then maybe someone already thought about this when designing the NIC HW, and came to a different conclusion than I did.
> > 
> > Inspired by Vladimir's comments about QinQ packets with an S-TAG (Subscriber tag) and no C-TAG (Customer tag), maybe we should consider the alternative:
> > When configured for QinQ stripping, the first tag is always considered the S-TAG, and thus always goes to the vlan_tci_outer, and the second (inner) tag is optional, and goes to the vlan_tci if present.
> > 
> > <feature creep>
> > When configured for QinQ stripping, we could control the single VLAN tag placement through the VLAN stripping configuration:
> > With VLAN stripping also enabled, the link is considered a "super hybrid", and the VLAN ID of single VLAN tagged packets goes into vlan_tci (being a normal VLAN tagged packet).
> > With VLAN stripping disabled, the link is considered a pure QinQ trunk, and the VLAN ID of single VLAN tagged packets goes into vlan_tci_outer (being the S-TAG of a QinQ packet with no C-TAG).
> > </feature creep>
> > 
> > But again, this only works when VLAN/QinQ stripping is enabled. Into which fields the various VLAN tags are written when VLAN/QinQ stripping is disabled will be fixed/hardcoded.
> > I'm not even sure the vlan_tci and vlan_tci_outer fields are filled when stripping is disabled. But there are separate mbuf flags for VLAN presence and VLAN stripped (and QinQ presence and QinQ stripped), so it could be supported.
> > 
> > Furthermore, in favor of my original suggestion, consider TX:
> > TX of an mbuf with a single VLAN tag doesn't know about QinQ with no C-TAG, and thus looks at vlan_tci when transmitting such packets.
> > If we like symmetry, RX should behave similarly.
> > 
> > I'm leaning towards my original suggestion, but I don't have a strong opinion about this.
> > There are good arguments for both solutions, either vlan_tci or vlan_tci_outer for single VLAN tagged packets received on a link configured for QinQ.
> > 
> I'd tend toward your original suggestion too, where single vlan always gets
> put in vlan_tci field if stripped.
> 
> I think if we were to go back and change things is would be to not have
> "vlan_tci_outer" field, but have a "vlan_tci_2" field, where the *second* vlan
> tag, if present, is put. That would mean that the behaviour would be
> unambiguous and the field would only ever be under consideration for
> double-vlan packets with QinQ strip enabled. Sadly, I think that would be
> too big a change to make to the mbuf at this stage. :-(
> 

So, I started looking into trying to clarify things a bit in the docs, and
in the process of doing so found [1] in the mbuf docs.

 * - If both RTE_MBUF_F_RX_QINQ_STRIPPED and RTE_MBUF_F_RX_VLAN_STRIPPED are
 *   set, the 2 VLANs have been stripped by the hardware and their TCIs are
 *   saved in mbuf->vlan_tci (inner) and mbuf->vlan_tci_outer (outer).
 * - If RTE_MBUF_F_RX_QINQ_STRIPPED is set and RTE_MBUF_F_RX_VLAN_STRIPPED
 *   is unset, only the outer VLAN is removed from packet data, but both tci
 *   are saved in mbuf->vlan_tci (inner) and mbuf->vlan_tci_outer (outer).

This documented behaviour seems to contradict our proposal above. However,
is this the current validated behaviour of our NIC drivers? It also seems
to make QINQ_STRIP the equivalent of VLAN strip if just one is specified. I
wonder if the original intent when QinQ support was added was that vlan
strip would strip tags with type 0x8100, and QinQ strip would strip tags
with 0x88a8.

/Bruce

[1] https://doc.dpdk.org/api/rte__mbuf__core_8h.html#af720eb399a97e49e5e21959afa307a0f
