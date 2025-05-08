Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C29C3ABBE
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 May 2025 11:33:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DECDD4026C;
	Thu,  8 May 2025 13:33:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id C09A74026B
 for <dev@dpdk.org>; Thu,  8 May 2025 13:33:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746704027; x=1778240027;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4yaI/yFkyzOhu4Trj0RZmdVbfJ5LyosP6D51KUYdGzA=;
 b=RTXZ9guQab8nXkbk6phmIua/SeaZYVryyCv3aBldjNeWBgRyBGmoo2Dl
 4Qf1zXna0rtcVQENm2D4pKLD29Pf6ruAPkYW8mbbJxRqHXiijuGr1wYCq
 xeg5JfP3ZDkhp9TmQ2tTDMWtvykIWEHJodKGXo9CTEl7Rsm9wsgSudJt7
 txbCt+SLN5SMOq4NgEm+0hwqhb/n1RW4Ie5W00qZcopbV+Ahas14QSKcO
 V9EtIsaF8SGgSUlEjbxIqhSGvHUII39raHTxN99nLI0FzP6YXopuM+urU
 QnKDkw/WvOk4MJI005bagY8Io4AEyxlFfzhX5yZYwz5/IyKKMMCvAQtRE g==;
X-CSE-ConnectionGUID: +WZbfDmfTECFJKiNbu/Huw==
X-CSE-MsgGUID: 83BtkBCAQfeaeZogptS3fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="51140806"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="51140806"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 04:33:45 -0700
X-CSE-ConnectionGUID: KJGuAbFcThOaKHznPk/OPg==
X-CSE-MsgGUID: jFyUgV1vRM6uSa3JajC5Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="167339288"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 04:33:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 04:33:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 04:33:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 04:33:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhGigFxpMW8UkCDZNnrO6t41N36quLuykhH76hxFVlXjwigLkdKHRpFuwvan672HV6TMFXa/yDUfPXM5thq76WJzWNl/B/O+Jfpv27aOLv/7cOefRfBsaXvC1GkALQzBQe8p8yPDQtH6GGC/VXN5ouvIWY1lDxHZE2/H8Kuz37pkt9tnwmrWIa2786HsWX0TAopBOrlXuw3mQm3U2GTAEJoMrof82++GQHjSWuV6Q7ty/4i6JUStiT6wAva2+52Q3f/iBNl0YG5XTmVDckvjFkPQf2Jg8UmSzT3hsZ1dtRFICRJpMyQ2NPVf0GmiEn32gG8rVd8vJibh2xPaNCOehA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGbQvRnYvlMB+PbRHEF8YTqvst3jpihqeuFXFT+UsN8=;
 b=TrBA9wwI8FZGnHD+Usy5dd8h1UFzBpCdc0ec/y6JtQIlKYoXabPq/FAmzTaS/jwmbqrTOzyGhBQkYhNsGaGKRzDmCc/Ep+UexGe82unes8E8AklQrQ/gIDnhA17vMWKTUVAuFetoxJ+oqlFcQJ0yHx41oz+op98Fj0zjlVlTmvKiQLNYUJOF4DYSklesvzkdkNPUb6TmWLsDSk28RyJfO0GQnDRkScEH9y8h2RnUuwctY61AuYdl7SL4Zwk1M5LJsA+EnpjyR5Apk0cSYKFa5z1HaK4ZeUG4eAFOlg4RA8avMGiSpSovCw3UQrwed0pjFSxmHNE2lhxHPw+0Uyn/yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 LV2PR11MB6072.namprd11.prod.outlook.com (2603:10b6:408:176::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 11:32:57 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Thu, 8 May 2025
 11:32:57 +0000
Message-ID: <53d50d81-75ae-4d23-89b2-bfd6e5733550@intel.com>
Date: Thu, 8 May 2025 13:32:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] bus/pci: Use force-noreplace flag when mapping PCI
 resources
To: Jake Freeland <jfree@FreeBSD.org>, Chenbo Xia <chenbox@nvidia.com>, "Nipun
 Gupta" <nipun.gupta@amd.com>, Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <20250506174046.1136711-1-jfree@FreeBSD.org>
 <20250506174046.1136711-2-jfree@FreeBSD.org>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250506174046.1136711-2-jfree@FreeBSD.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR04CA0020.eurprd04.prod.outlook.com
 (2603:10a6:10:110::30) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|LV2PR11MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 8218753a-643b-41f1-e4d6-08dd8e2414c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUloS3FuR3YvRzk5dGYveXZsaVNyMkdVMzd1RXpndkJROHpsSHh1b0NHTVJv?=
 =?utf-8?B?cGRlcjV5MXBsNDlTb1E4eDVFdVBJZlZmK3VWemYweWFUUmVWR0FqYVBhWHFu?=
 =?utf-8?B?YjdOZ21yaitZTGtNcE5PVUZXUmtzdWZWb2FBSkdrNnpQYmhSdy9hb0xaSUFi?=
 =?utf-8?B?cUxkWko3bzJWaXhkOHhaOEsvZDlicFR2TGRYVE9oeko5c0xIMEpaUS9BNmNs?=
 =?utf-8?B?OWFIcEdNRW5KR2cwSWJVdDBER2dWVnl3a2ZiSmFTNmRxSTJvVm9ZcnV4TGpm?=
 =?utf-8?B?ZDhGUHVNNGJZQXA1U3BtWEJxdzloN0crK1lBNWJhekZGQkJWcjczZXc1clFt?=
 =?utf-8?B?L3ZtZCt2aUdsYkd1SmhBZk1MVWlmcHlEdzVWUTdmUUVhbGVGbWp2UXJXbHhZ?=
 =?utf-8?B?c1NlOWhvWitUUVhkRTJKa2tDaGVIY2NpVFQ2LzNGVlJ6UDV4NVVyb21nNHlR?=
 =?utf-8?B?MXRIaFBNLzlOQXBMU29WMHJnMFI3T2kzdVlFaGlZTXJKUjNSMFAzNkVkdzNn?=
 =?utf-8?B?WTFkd3hwY2ExS2V1Y3RTYUI3S3o2RGJNZTdQN1JWQ2lyS0pzMnBObWJWbU9O?=
 =?utf-8?B?dWxpeElObjYyeGt5cjU0aVhlaWExOTdpSEptOVVYZXk1Z2lmeDFjY0NUZGdL?=
 =?utf-8?B?N2ZJQlRBUGg5eEswd3NNR1ZKc0VDbzBtU3BMSmJpMmh3OVlXWGxQSXd4SVRP?=
 =?utf-8?B?ZFBrbFRBQkdBUldvNzVYa3dGTGIzOFRBbUlqRkE2eGNLajU3U01uNnFDRWlI?=
 =?utf-8?B?ZlVjUVhGaDRlWlBBWnFiOGg0V05xc3lYWEQweURJT0tGKzAwQjErcVdHU0FF?=
 =?utf-8?B?RHVraE1iUDFacGJON0dwMTAzUVdZa2N3dzNvcDNYMzNaZjJBUnlyeC9HL1lJ?=
 =?utf-8?B?WGNpSFd6bGNHcXo3bk5Bckg3WHEwaEk3bHBtdzNTWER0bnJMcjJrU2xhZmxn?=
 =?utf-8?B?YU45c21UVHRQaGUwOUZJYVI2VnFxU0wybUtRZFZZclYvUFBBNmk0VWY0R2VL?=
 =?utf-8?B?Vm1ITmhUem1nNFRVZVJpdkVtUTVYVUErK2wyMjEzS2tReUtmOGVTNkFiT1lQ?=
 =?utf-8?B?Z1JBNEZLSTFLWHoxRHFUUDlOVVEwVHBHdFRqMndTRXRQSHluVm1MQnQrbWto?=
 =?utf-8?B?WlJqeFR1OW40bGFPc1FkZjhramdYM1BjbkxObkxrSWJoc1RzSVpBcFJSZmMx?=
 =?utf-8?B?MEJLM01hSEZYYmhtUGVvekloT0pjQXcwUWtDMmk3dXNReThJdXk3eVNMVmhu?=
 =?utf-8?B?dnZEQVFPVGI1VzFoelE1elBOSThjZG84bXRwa2hHUlBvWmNvOHg4TlJCN3k4?=
 =?utf-8?B?c1Fnc2xwb3AwK2NzVzFsbG1Ma2U2UUNaSTk4UTJOSWpUNEhqVnlPRG9kVmdV?=
 =?utf-8?B?TEE1bzlzcEZiTzZjbUtNSFc0bDdSQXMrUWF5MkJia3FNTEFmRXplLzVQMElo?=
 =?utf-8?B?eEwrS1Y1czN2bG5EeXcyUVNNVDMrZ3ZLdC85cVdoMUtrTW9kbW1SZmk4NXhr?=
 =?utf-8?B?Sy9PaVVpUXVFNkttK213a1U3czJaSzZxdEhCQ3ZVcmkrQkxsVndUNUhDREJw?=
 =?utf-8?B?MW5LYkJHSlF2azJWd3dKa2hOZGMvYldKeHNqU0E5STZjaDYyQTFYMjZ3bWVF?=
 =?utf-8?B?elN5RVhwZFlkK3VJMkQySkhWWXJmaVYzTHJtclo0UVQvU016dkdkQmpFUnN0?=
 =?utf-8?B?aWRHWnN1UnAwcXJTYmVwTmFGMFkvbFgzMlRzcU9oc0RnZ3gzZHdnUXdIQ1Ji?=
 =?utf-8?B?SUZTYjFuckhhSVRhdEFRSFp4SmhKS3pZRFZYUXRXY2U4VDBMUUQvYW9YWHNX?=
 =?utf-8?B?VkJFN0hDT1prN1lrMjBaRmRCQW9HRTJaVVFMQUI4S3plV2gwY0NQUExCeUFU?=
 =?utf-8?B?ZXBUSGk4UDIzcjk3bTF4MEc3R0tCdUxBVDB0VGQ1MDV2bkxnQWtyMEpPVGxK?=
 =?utf-8?Q?TjVDS5ju410=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHMxQjMxTndjNlc5V202SzVOSllYVCtuYjZ6alJDd2pxKzdWbk9WbGtSemRY?=
 =?utf-8?B?MlQ1TmtFQjJxWWFhbGtHMmlQRHJZNkNlZ2pGUHJDOGhDSUFobjFoQXZhaVd4?=
 =?utf-8?B?enYyVVdTbFNMVTd1TUN5QlFoNXBVdDBHSlU3S0RrcHJYeTNaMGw5WHpZVXh6?=
 =?utf-8?B?K21IWnRpeGlJK1ljRzFZQlc3aXlMM1BsQm1XeEJXYUtPK2U0a2JuL2thTXVm?=
 =?utf-8?B?K1pXVXhjZnhmREZzRlA2bmV4VTJLVHlsYTlJN2dsaHJtZGJVSTFnK2dmeng0?=
 =?utf-8?B?ei9Mem04MW5Qck5RTXFhUHZYQkNrd1IxYWIxdHRMN0U0TFRzOGpHZkcwbmR4?=
 =?utf-8?B?MHo2K0w5VUg5YkUxczlZTGhPdEN2Z2FOeGdycnIrWmtud1MwemNTWHZTYlNi?=
 =?utf-8?B?ckZxcmRxZVFUQkl4SWlDU3g2NGkzNy8zclRXaFVSUG5rSFlxOVJPSnZvYUtx?=
 =?utf-8?B?R0N3V1krRTRTOHJQL2Z5OEhxcVZOWUQ0OU1kU01QSmFrakE5bFNmU1BzWWhP?=
 =?utf-8?B?THRnQTFrd1U3ODNvOS91Y1ZMUFFZbHJiZEE2RitWbEFJcDI3Zk1CSGFvd0tu?=
 =?utf-8?B?YlZPVGphMk1mT29ORTlJd3NucnlqNFd6THNOWVFxMVBucERjOWlrSnkxL1ll?=
 =?utf-8?B?YlFRSjRwSStIam5aVnlxSGJPMVdJZDJUcVptNzk1a3I0RVVvbnFXVmM2STdw?=
 =?utf-8?B?OXRHai9ZKzBBSURqeFRtbDVDL3g4WkFER3BBRXplR2hPTmJLRTVtTnFVaWVZ?=
 =?utf-8?B?Zy9LMWRCamZMbFltWm4xWTdublVNRTk3S3BSUnV1cVFpN2RHdS9WZFNTNjRD?=
 =?utf-8?B?dGZkdnRxVWlBb2RSUzdSN2VIM3lXcEhFM3lEbUNrUlVIMCtHdnJsL3pjSGdY?=
 =?utf-8?B?bWZnbWRFdzA3dzU3RHIrZU9aVmZHeUJBQk5tY2pPbkZvdTg2SE5CS0tsd1VK?=
 =?utf-8?B?eXpLOVZSbm8xaTR6czd2cFVvT3FaMG44S3p1M3ZoWHBGblpKODVOMUgxTGRl?=
 =?utf-8?B?ZjZCWlhhbmpBUU5DLy92RDlOMDBzQnl3blMzZCtRTnZyNU44UHBjejhvL0Zy?=
 =?utf-8?B?bTNIU3VHODNtU0o2RUxKRVpTb3JhMWszb0k2cysxMXZXaXd1QStKbG9QTFZP?=
 =?utf-8?B?KzJMVlg5cHI1OWpFQ3NRSXRrSW1kQ3lqc0d4WVFRb3prSUxKQXRhRHBiR3Vy?=
 =?utf-8?B?WHNXdjFjSVhCRzV2NFFnVE5Lb1BvYUpua1Q0aUVleFNEemI2Z21NL0tqNTJn?=
 =?utf-8?B?Q3B3dHZaTVRuWkxLeTAxdlh2UDFpTWhSRlRVK0ZkZUJpVHpsZXBiVEx3ZjFG?=
 =?utf-8?B?ZHRSWGNYQVlESjZtdmp6RGdoNnlLcjhMU3g4MFh2QjBPS3B4cGNuVW1IcjE3?=
 =?utf-8?B?QnNieStWYWxEVGE1VEF2S25IczN3ajQ3RllmQllMNU1SSFpFK2VSR2NXR0Rx?=
 =?utf-8?B?Q3B3R3lOaVNLQ091NkY3ZURNd3pkOStTZUIvVFpYUG0wSUg3cmtvbENJTmpY?=
 =?utf-8?B?a2VGQ1FEL1d5TEM5S3BMZ2tZUCtCTGg3Z2wwVHY2RE1sS0hFWTZWcVRmS21B?=
 =?utf-8?B?SktJMzBoRWxBQmdoOW1YcFZtQlA5YzRYSGhwRkdoc0d3UkoycjVMS1gwWXlw?=
 =?utf-8?B?bWFUcGgvbXNicjVrazF0UU44VHRnYzU0eG0vVGl0Nkh1L0xEMVpMN3Mva0dR?=
 =?utf-8?B?aVF0emJFeFBkdzBJb2pzMVBxam43TWptdGZqdTlTNDBpYXNXN1ZTUktnNFUv?=
 =?utf-8?B?cUs0Yk5uSmZtenJETWFpSi9jSDFwVjAvcGNkeE0rbW9hVFJYT0dpS3RTU3VU?=
 =?utf-8?B?dHE0RUFJWGtRbURWSmpTMkxFRE9xYWlQdnFtaHlxZ2xWUkt6eVRKWmpILyt6?=
 =?utf-8?B?ZnJGelhvVCthSEZDa0JZSDV4b0dzazZSSUNoQzBFQmlKZ3VBSGU1cS93cFVv?=
 =?utf-8?B?c3JJMzVqUEk2aFVIL0ZiWUFxVGVDYU9IYWFpS1JUSXJzeDVnSjdKTkNsUjBx?=
 =?utf-8?B?UnVhVjBVMWJaNEkyNG9LcU4wK01jcmJLQ0h1a3JUR2tsVXo3ekIrYldsWjFC?=
 =?utf-8?B?REpHOHVuODRsR1BYaThVYktuTFB6YlEwajNzYTJUMW9wSE9GTkE0RzFMR29L?=
 =?utf-8?B?L3dRWTNSOWxQa2tzaEt4a2VVYlJSUUZCUW1sTnU2aE1PUjU2cWtEVmN5TFla?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8218753a-643b-41f1-e4d6-08dd8e2414c7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 11:32:57.8440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z872IKkBp9mGiFgjh/FcH1qZiC+n42/WQ0mULbT8JW3IpcizVhM0obstbbIe+Efz3U4wcqVor8v2ET0VZVZjD0lYte4kRxNTZeVMpK3hBeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6072
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

On 5/6/2025 7:40 PM, Jake Freeland wrote:
> When mapping PCI resources in secondary processes, use the
> RTE_MAP_FORCE_ADDRESS_NOREPLACE flag to indicate that the
> mapping must be made at the provided address.
> 
> Without this flag, the kernel might return a different address for
> the mapping, even if the requested region was available.
> 
> Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
> ---
>   drivers/bus/pci/pci_common_uio.c | 4 +++-
>   lib/eal/common/eal_private.h     | 7 ++++++-
>   lib/eal/include/rte_eal_paging.h | 7 ++++++-
>   lib/eal/unix/eal_unix_memory.c   | 8 +++++++-
>   4 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bus/pci/pci_common_uio.c b/drivers/bus/pci/pci_common_uio.c
> index 30503bd23a..71974e9f56 100644
> --- a/drivers/bus/pci/pci_common_uio.c
> +++ b/drivers/bus/pci/pci_common_uio.c
> @@ -10,6 +10,7 @@
>   #include <sys/mman.h>
>   
>   #include <rte_eal.h>
> +#include <rte_eal_paging.h>
>   #include <rte_pci.h>
>   #include <rte_bus_pci.h>
>   #include <rte_tailq.h>
> @@ -58,7 +59,8 @@ pci_uio_map_secondary(struct rte_pci_device *dev)
>   
>   			void *mapaddr = pci_map_resource(uio_res->maps[i].addr,
>   					fd, (off_t)uio_res->maps[i].offset,
> -					(size_t)uio_res->maps[i].size, 0);
> +					(size_t)uio_res->maps[i].size,
> +					RTE_MAP_FORCE_ADDRESS_NOREPLACE);
>   
>   			/* fd is not needed in secondary process, close it */
>   			close(fd);
> diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
> index 04ba8ddb86..aaeb140eaf 100644
> --- a/lib/eal/common/eal_private.h
> +++ b/lib/eal/common/eal_private.h
> @@ -211,7 +211,12 @@ enum eal_mem_reserve_flags {
>   	 * @see RTE_MAP_FORCE_ADDRESS for description of possible consequences
>   	 *      (although implementations are not required to use it).
>   	 */
> -	EAL_RESERVE_FORCE_ADDRESS = 1 << 1
> +	EAL_RESERVE_FORCE_ADDRESS = 1 << 1,
> +	/**
> +	 * Force reserving memory at the requested address, but fail if a
> +	 * preexisting mapping collides with the request.
> +	 */
> +	EAL_RESERVE_FORCE_ADDRESS_NOREPLACE = 1 << 2,
>   };
>   
>   /**
> diff --git a/lib/eal/include/rte_eal_paging.h b/lib/eal/include/rte_eal_paging.h
> index c60317d0f5..7b1983b615 100644
> --- a/lib/eal/include/rte_eal_paging.h
> +++ b/lib/eal/include/rte_eal_paging.h
> @@ -34,7 +34,12 @@ enum rte_map_flags {
>   	 * may remove all other mappings in the requested region. However,
>   	 * it is not required to do so, thus mapping with this flag may fail.
>   	 */
> -	RTE_MAP_FORCE_ADDRESS = 1 << 3
> +	RTE_MAP_FORCE_ADDRESS = 1 << 3,
> +	/**
> +	 * Force mapping to the requested address, but fail if a preexisting
> +	 * mapping collides with the request.
> +	 */
> +	RTE_MAP_FORCE_ADDRESS_NOREPLACE = 1 << 4,
>   };
>   
>   /**
> diff --git a/lib/eal/unix/eal_unix_memory.c b/lib/eal/unix/eal_unix_memory.c
> index c540f1e838..61e914b8db 100644
> --- a/lib/eal/unix/eal_unix_memory.c
> +++ b/lib/eal/unix/eal_unix_memory.c
> @@ -17,11 +17,13 @@
>   #ifdef RTE_EXEC_ENV_LINUX
>   #define EAL_DONTDUMP MADV_DONTDUMP
>   #define EAL_DODUMP   MADV_DODUMP
> +#define EAL_FIXED_NOREPLACE MAP_FIXED_NOREPLACE

Is this available in all supported Linux kernel versions?

-- 
Thanks,
Anatoly
