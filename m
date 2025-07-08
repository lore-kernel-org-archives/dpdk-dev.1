Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EDEC83F09
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 13:26:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33A5440A84;
	Tue,  8 Jul 2025 15:26:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 92CD540A6F
 for <dev@dpdk.org>; Tue,  8 Jul 2025 15:26:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751981200; x=1783517200;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=qJff/47Jx0Ztu4DOjC4LK3uWash43GUnRd71UQ038oE=;
 b=F9vtbU1Ibsnb0vHn7G5fds83vSfiHAD2eatywgcJe1H/wehKpV0wMIp4
 hwhUbRxvxVLOQPZrcLaXo8CILGcvMreyTckM7NXBSz/0HkMjjMtIfLh3H
 viJmZ4S4UzPuwGKBVNaohUtkf+N7oX1llYRwelzPnzggI5CSZFhPpIOdX
 V0eRF177oMWFEl+F8+efrgdqjA4h0S25lR2Yntn+woeqFBQOoPLxlZjXv
 nKwoQU1Y5Zgc0IYocJBZGzj7YBk64tB6Se+0l32vXUZ1tyZnQlGxn2kx6
 k8sPWZhjBt/8HzK3IaFNtlpgxtaZFZVPtbaiUPlsTnxDp6bM1qDn6BUeq Q==;
X-CSE-ConnectionGUID: /I9eNfAYQbm7divrx92qZQ==
X-CSE-MsgGUID: ZJWoLrspSo23hX9ZO6SwIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53336256"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="53336256"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 06:26:39 -0700
X-CSE-ConnectionGUID: lWDiJLWiRbWC1J6n4ZhyFw==
X-CSE-MsgGUID: +XwAgw6ZQDewCc1HtRxpiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="159537659"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 06:26:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 06:26:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 06:26:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.51) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 06:26:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrybkjATsTN/rAZYrQBKdVh8ZhQe87OZFbBEjmjCEuYgyTr7eKi2JVLWoQgxleK+21adQV7PMufkqDlgz2nYmULtokGz7hM/b5d0eyqrlv9+jSsPq7Glp1UfCMkUcRoQZCfoL7h9vb7DWzsq9c4wzSE/Nqg1NdqOQSwKY0ut/KJPntgkG2oIB/JWgh4a56GQm/jUwHZSyFY60PA6xqDeiLQDiwGs/KupvMJu6X02m4oZxZsaWRQZAen5xd9lJx7rOXbKlRRFuwkM76RUgrbz1WeFUhO2MnR9lSa+10qwi99AQcVhfCY6OZf6oaWDJarXqsigLAUTZUVJkkiuYr1eYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sK235TXwpHaw8MKQ9dpcvtiTYLI/VamgfMuFi4PLzg4=;
 b=G9ELugUmpVqOgf0HWSqCoukkdyq2gyPt07cgx0WjAp2ilAheHSh+DdaFTRRoATJ0xQaTiC155gMxF2tyUKBaJXCDx7n4ko0k6q5Lw4U2OCwVMqBQrNTCID+mbQp1qqydf7PsJ/fRJdaZDC9EWeV88HkfuW+CDfNS1NY1y7zUzxCn0B+N/RYlKN4HrTJFYOVcPR52FdTFJVRbE8j3GLhYWdGUuPIuJGGDfJeG//kOPRBnjKX9+evajBiiYMRimvaImLBEq4/2tlc4WZmSMqX3ZpHr9kjox2Wcn00gwx4mzbyFuUa1g98GZ+cBHpurfdSISlIFiLZ6bridUIhZi59L/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6663.namprd11.prod.outlook.com (2603:10b6:806:257::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Tue, 8 Jul
 2025 13:26:35 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 13:26:35 +0000
Date: Tue, 8 Jul 2025 14:26:30 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v3 16/18] test/power: fix tests without power drivers
Message-ID: <aG0chiOdTpJ-gs1P@bricha3-mobl1.ger.corp.intel.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250708122823.3406288-1-david.marchand@redhat.com>
 <20250708122823.3406288-17-david.marchand@redhat.com>
 <aG0TbXztzouaF0MO@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8yTZQtDQHe-aMpQtSyeLgVW0xg7GD1N2=usjbhcS7rb5Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8yTZQtDQHe-aMpQtSyeLgVW0xg7GD1N2=usjbhcS7rb5Q@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0043.eurprd04.prod.outlook.com
 (2603:10a6:10:234::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b4bb4c-6324-4add-538b-08ddbe230f5b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDFEanpDcGxSR1lvQzFVMU1zVDhjZDRuRmRHRUwrR3lObElXWXU4ckpyQzFF?=
 =?utf-8?B?cDE5S0N0N0JhRmxGcWM1WGgyT3JOcjhtOVAzT1NBSVFDK1ZPUE9NL3J1dWdl?=
 =?utf-8?B?anlvdVkxUUZtVkNpUEljMXd4Mm5WWXNqYmxteHg3NFBqUU9ObHBUZDk4VSsw?=
 =?utf-8?B?S2VCdVhxY3FHRUVaZ0kzbXNxamJyREEyWVR6WTFpTVZ5VlJCTmI4V0N6ZWtV?=
 =?utf-8?B?OWt6MDltUFJJTjdUdmc1Vm1ISTFsL3BqVHBOWnlTRDIzMm5iTlVORi9LekNZ?=
 =?utf-8?B?RVhXa2Zud1NmTndFNHg5UlpNUGtDR1BEZlVyZkE3amZOMTIrZFBrYVRrQklB?=
 =?utf-8?B?KzVrK3VWRDNzLzZqaWt2dmNuTTVTVU9GR0tYQVRQZ1JucGlWWThMeURnMTN0?=
 =?utf-8?B?MExBeWdzYmxUYzJqUFZ5aTZDa2dXeEZiZ0x5ZldyMUIySSt4ZWU3eDREMjIr?=
 =?utf-8?B?eU0vMFptUEx2aThVdVU1YXFZS2FLUXFSL1k1RmNSNlpRejJyQW9LRHdXSGlT?=
 =?utf-8?B?aktRYjg2bE1mTmVKQ1pEblFxZW9TNjBGVHZPalBYSmJ1TUtUYkhvNlhKQ1Y4?=
 =?utf-8?B?cFdnV0V4Y2lNdWhIUldOdmozaVk2VVFJY0t4dXFnZFBQbUdUdnVIVlFuNU1E?=
 =?utf-8?B?Uml4RFhaZ3VpT0RjTllqYUdLV29uamhTVldHQ0RkQndXUTUvdXRsUjZkQmVY?=
 =?utf-8?B?WjJEMy8xYnIyNHdkV2xuOEdIR0tpekRReVY1VW5CNDdGUGRwYWNCaVZoNEdu?=
 =?utf-8?B?ZER3aXZST2hEVXFYbGFFSm5SMlpDbmNzV3dtY0ZDdWw1VlVIWW5GRWs0dkZv?=
 =?utf-8?B?Nms5OHNNVWJ3RUZHTmNHM3VJRjlLVDdOQWdWWUhnMjZhNFUzTlhnNEMxaFBQ?=
 =?utf-8?B?TmJTTTBUMDlOTVllei8xdXpLSlB5cnR5bE52UGM1dm5nVmQ2K0o1dEdXSVBU?=
 =?utf-8?B?QzlJNm9GdmJOcm1KV0JpVVA2cmw1dDdoMVdZNVJjUVJtU1A3SWhtMEtHNHJn?=
 =?utf-8?B?a1RXaTA2dGNnb1dlaFhRVmtkL1VLNDNWZXFCcTROd2ZvUlVDZjhrWEJsYnBR?=
 =?utf-8?B?d3RJMnJaRjVKa0xnNTY5RnVDMGtWaDBIR0ZLOTE0Yk9rU1FyQzdPR1kyeU9n?=
 =?utf-8?B?TXhWVWRNRjlXb3h6M2dyVUM5SmtkWGcyZ3poQlBmYUpSeDV4d3VUb0tlN1l3?=
 =?utf-8?B?THRJb3dhWitOSTY5SWducllIQkJ5dW5sejMxTTZjclA0N3ArakxRT2krZTVX?=
 =?utf-8?B?SzAzc1NaZGw4ZE9rWnhwaVQ1RDExcHFZNW14Rkt0L2xFVWFYZlBNVjFVd0NG?=
 =?utf-8?B?aFdyL1hKL1JkUVJOUThhQVFQWTdJYnFEeU8zOHFDTVZ3aDU2eDU0cW5EcnZO?=
 =?utf-8?B?b0twZ0hHdFZHMkZaRmYwNy9oWFBteGNBMW5QYlhqc1IrWHpRQTFnazdQbkhv?=
 =?utf-8?B?dXZuQ3VnTU9NcWlkanI2VUdSVU9OWlJ1K2NlclhtM0VjZWZIeUZjVkQwUXVq?=
 =?utf-8?B?b3VrdXhLdHEzdDhoczVFL0hvRSt4QlowTmVpQzNWSVA5VXRvaXV6N2ZIWlJn?=
 =?utf-8?B?czFQODhHQ2ZUd1UzalE3RDMvQ2JHb0NmbVJETVR2NC9FVUErd0xPdGR1UFV1?=
 =?utf-8?B?UlR3cXlHbUdOYmZXM2V4VnRXYkFzU0NMZG1yaGoxOEMrM2lkSHJ3MHl3bjRD?=
 =?utf-8?B?VjIybGdwODQ5bjQ0ZUFCNi94NU9FK096aHc3UGhMSThoM0dJTFBPUmxEamt5?=
 =?utf-8?B?M3IrdUUvM3FMaHQ4OGluU081cms0Smg5b1BYVTVJMUl4bnJEY3NKaXpVQVBU?=
 =?utf-8?B?Y1NlNGhoZjh0VUwwWFBncTdzekNwYmJnbWViVUlLMGVMY0RaYUgxdC9qMlJP?=
 =?utf-8?B?QlVQUnY4WUZwVmNCWUJNQkw3anpidG9iUjBLTCtBWnh4ZG5YOTBLM0h0SnZa?=
 =?utf-8?Q?wKyPY7ojXdg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUh1WE5jU0hFRis5anRJb3pzY2RaNC9SNXdhdlZDU1Y0aVBwTi9nOHBoclpa?=
 =?utf-8?B?NklWUFJJRWJ6UUFLdFZybnZUY3I3YXc1aFJ0bGJiVk1UQm9ua2ZqK0NkVU54?=
 =?utf-8?B?MzRmU2g3b1hKWFlmVjFMTm1EM0ZaVzlRZzFNQ1U4ZThXV2txS0hURTVCZUNO?=
 =?utf-8?B?V3ZJTGJLYTh2L2dJMlAxV1lmOHRlcENhMzZvVy9DYkdFT1A0Q1BXR2tzZWJi?=
 =?utf-8?B?M0xnN2NVa3JyM3R0SmdSYkJvVmdueVZRWHQ3c3h2V09XVTh6Y29TcGhqSkhw?=
 =?utf-8?B?NHFuTnFOaW94akp6ampjV0NvRUtLQzhrNHk3Vm5odnBYNHRIdUpkendJVHR1?=
 =?utf-8?B?a3MwdnVMQVRxTThQeDNZMzF2TkR2RTlRaUwvTFBXZlZsMnlGd2RXRkIzZXdq?=
 =?utf-8?B?VTBDOEQ3amZtNjlUQ2VnWHo0NXUzRTFUcVJSVkJWeU40WDRvbm1ydEloUER3?=
 =?utf-8?B?TmxSZjMzN0ZHZzdYVzI2QTVLbjBsaFcreTV3RFM2dXFYNVk1Sy9zajFSZldu?=
 =?utf-8?B?MzNpT1dSNmIxa2M3djRUWTNEMGpObGhwcTVGZzU4eUtCZ1ZyVks3NldiakJh?=
 =?utf-8?B?SEdxK3M5bS9xQ0hKOWpTVHlZZk5uVVEySmFBbDFlMmN3TTJSc3N2UzlOc0VL?=
 =?utf-8?B?NXEySnNnOEUzU2tqUjFMWEFCb01OZ3dLK1lIUFJhR3RMZ0pzSXZBbWNhdG9X?=
 =?utf-8?B?WEcyVCtjZUZZSURkVTFKMjExM200OHNBM0xUelNCNTRKeEYwYlVUREk0OXpU?=
 =?utf-8?B?VGhPWEluRU0rYy9ISVdjOEEvTTNQbnRGQ0l0NlRSODNFelpGSGJSL1U0MVQx?=
 =?utf-8?B?ZlRHem1wWjM2NEZtQVB4MlI4ZVRaMnZWOGt2VWM3Mlh4dS9XalB4Mko1bnpx?=
 =?utf-8?B?cGZpSzJ6ZUZRdjRPNHB4clBBMVErNnEvaE9na3hiQXZVQTlPam5aZXRQd2Ns?=
 =?utf-8?B?S001SVVKUExvLzJVekJlVVdtMGJNOXB4LzVQMW1ybHYzc09JeC8vK0VwSC9o?=
 =?utf-8?B?VmdzWXVLbjJJeVI2ZEp0blljbUw3bXdCR0FLZ2JaMVR3cVoycWdZZ0luZnZK?=
 =?utf-8?B?UUpyOG1QTnE0N214VjlDLy81UW9UUmJiZW1YajVDcS9EVWZZUDFhTnVRSGZn?=
 =?utf-8?B?VTFmQ3NVazJQRWlYSzF6KzRaWURCc0hjSXM3eWtuRWJkNldpcTMzWS9qclVC?=
 =?utf-8?B?aVMwcU1FYVlWSzBsVnRDa1R1L01NYnB1dDJ5V25oRXdUWmVQK3RhaFErYUpC?=
 =?utf-8?B?YXJ3dkl1QVZxVVMxSDBzaThMZllmc2F6cmxodlN5Y0tGNnNhemdERHFxM1VG?=
 =?utf-8?B?OXN3SWRNeFd3QU5sRmJtYk0xODVET3ZQR3ZIK0locTc2cXJHaWE5RSsyYkVJ?=
 =?utf-8?B?RXZ4aHdEQi9kYW1RejVJeDNZcUxlcGpEKzR5ZmhnNWNhdmpTeW13VGNxZHIr?=
 =?utf-8?B?RlVzVzAxL2lXMnZQdnJGbVh3b1MrVjlLK1B3YWJiQUo3bE9sRnJXYXl2WlpV?=
 =?utf-8?B?WHNhVkl3dUJZMUtPbG1NN21rclZsNHg4Zm1Kb04rckVQTmQ3VGdQMnA4eHJQ?=
 =?utf-8?B?ZU45ZkZHTXdORkdFZXBKL1NWNlpTc0VEZTg1UGtIaThNYUp5RW82NFBBb3Vv?=
 =?utf-8?B?c0lSak0xYWlVbDljM1dIckM0aU5oYk5BTzlGdUc4K2ZNdWZnRmJKTG41Ukl1?=
 =?utf-8?B?MC9qcHZHbnphaHhvdmJ6OHVUR1hqK3VyRjRhbVQ2cXVrRlVSSVhiclUwOUR4?=
 =?utf-8?B?dHo4UlZPUnFpTUNyMVFFRXdjRFh6WnRiSU1kVnpaNkxRbGo2WjFGVVhNeGdw?=
 =?utf-8?B?TktOUXlrQW1wUFZiR3ArZkxZQUhIUEhnZVJVZ3JOS1QrWkxSVFF1ZldoVUlx?=
 =?utf-8?B?bDJubndibFprMzJMVUNJbGY0dm5raVB5Yi9jck5uTE56SEdYSzJ1U0dWZlls?=
 =?utf-8?B?aGYzSkx3dCtaeEs4akFOREhiYnRjNnBUa095WDllYWlUUnh4UXNEZUFXQnly?=
 =?utf-8?B?UzJTeVhKNnhHMHpaOFQzb05JeGwraVZON0M1eWFraXVZMUFEc0J3N1h1QlZz?=
 =?utf-8?B?RXIrdDVkSk56NW5KM0RXZzAzdktxOUh6Y2hlVGtaQVZKaitHbXgrTmZVcmNZ?=
 =?utf-8?B?d0FRdzdtc2lrd3pJSndXak9BVWNWMjNidWhYYjhlQTlDZTRvR1RnU1QzaXF6?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b4bb4c-6324-4add-538b-08ddbe230f5b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:26:34.9451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHdhyP5RfboxpKSYQEfHDNpzuyrtOZGFl7B6QaxzZ1GZFw3ylt/BFxtLSNEw255xDvqrEfSKgRxhukMifnBwc+EhZu5YCgLDB0+HqLn621g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6663
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

On Tue, Jul 08, 2025 at 02:53:03PM +0200, David Marchand wrote:
> On Tue, Jul 8, 2025 at 2:48 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Tue, Jul 08, 2025 at 02:28:20PM +0200, David Marchand wrote:
> > > In the absence of drivers, skip tests instead of failing.
> > >
> > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > ---
> > >  app/test/meson.build | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/app/test/meson.build b/app/test/meson.build
> > > index 7d38f51918..79d635b42b 100644
> > > --- a/app/test/meson.build
> > > +++ b/app/test/meson.build
> > > @@ -145,10 +145,12 @@ source_file_deps = {
> > >      'test_pmd_ring.c': ['net_ring', 'ethdev', 'bus_vdev'],
> > >      'test_pmd_ring_perf.c': ['ethdev', 'net_ring', 'bus_vdev'],
> > >      'test_pmu.c': ['pmu'],
> > > -    'test_power.c': ['power'],
> > > -    'test_power_cpufreq.c': ['power'],
> > > -    'test_power_intel_uncore.c': ['power'],
> > > -    'test_power_kvm_vm.c': ['power'],
> > > +    'test_power.c': ['power', 'power_acpi', 'power_kvm_vm', 'power_intel_pstate',
> > > +        'power_amd_pstate', 'power_cppc'],
> >
> > Is this better done at build time or at runtime? Unfortunately we don't
> > have support for "or" operations on dependencies, so if even one driver is
> > missing the whole test file will not be built. I would think it better to
> > look for the drivers at runtime and return TEST_SKIPPED if not present.
> > WDYT?
> 
> I don't understand the intent behind this test, but test_power.c
> requires this list of drivers to be present.
> 
>         /* Perform tests for valid environments.*/
>         const enum power_management_env envs[] = {PM_ENV_ACPI_CPUFREQ,
>                         PM_ENV_KVM_VM,
>                         PM_ENV_PSTATE_CPUFREQ,
>                         PM_ENV_AMD_PSTATE_CPUFREQ,
>                         PM_ENV_CPPC_CPUFREQ};
> 
>         unsigned int i;
>         for (i = 0; i < RTE_DIM(envs); ++i) {
> 
>                 /* Test setting a valid environment */
>                 ret = rte_power_set_env(envs[i]);
> 
> From this, I chose to disable all other unit tests.
> 
Ok, if that's what it needs, so be it.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

