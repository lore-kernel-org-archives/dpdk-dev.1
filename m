Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAD1E68171
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 13:00:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3750340659;
	Tue, 17 Feb 2026 14:00:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id DD99A40657
 for <dev@dpdk.org>; Tue, 17 Feb 2026 14:00:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771333258; x=1802869258;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=2Ancm2H/Z1Kw8mBqkT8EtN9rhiatUmR6kdrz0q4bZow=;
 b=PhB6RvbcIWZ/ZpoSun4BYhJz66we7GKbc5QONFGKg9cv/uZ5eSvEftUS
 +eiaOy/DbhtM/cgySdA1LuntfVWkMqH38rB1J4K3NcPaynuA4bzMtNhXR
 2J3mqLFvIta1GDXAnBn/zSCpUPH/7q36oIBl7yPV7lK5KARKgJA6DM+Nw
 lUsUPKn/AiPLmc6rsB+REuBSO/XFpQ/G+dUA7fKIpwY+/tGJQKHgCxoj3
 AWmeADblu7bbdawnPwqvwXzsVg3KWRywIm3H3gWMLKqKQnpLBas2NHdse
 Lhh9jY28U0tnjrBtptie95Zv8ZEtFdU//Ep5beovRaZRoV2GmQc8ezMc+ Q==;
X-CSE-ConnectionGUID: p65m3c0fR4aR7qX/lwP9OQ==
X-CSE-MsgGUID: hVBzidtHQxmLDpo3b5NpPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83500271"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="83500271"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 05:00:56 -0800
X-CSE-ConnectionGUID: dReUUsmsRhSWhnBRW5G34A==
X-CSE-MsgGUID: a22TrMfcQ/qPJJ/dzPiqKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="213132205"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 05:00:55 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 05:00:55 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 05:00:55 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 05:00:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkuI5HUEBm4Hena9YHO/iHm59EOogqWbzK7JQAJ0lWl+BSJMw1LZM784q8r2JBJ8O8kQK1mQOI0J5XMa0SXDktRsjktVnKiULC8iMUw1klHy8wvWJU7L9fJzaITBn+qQAD7xP1FuBltpd9O+804EhRUjW8OoJ7mO9dsyhwkvMUNwRYqsqvib0FH9+XLCQw0y0TP548TJcIncJ//nJXJp3q4rzSt51fRj0KhUIM1rN2lEFpKopOGXCT3UPxxbhzC4/ghRJ8Vn8yyao15QBYOPffrYWGlAehBrPC3OpFH2mS+1LDJO4nU/uPmhjgXqOnaREBd/LgGpDclNwxdLCKfazw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbB+MQFPoJd6O9yH66Tbl3Dx4nBB4k5meSfGmGUoMkE=;
 b=vepaf6tS5ST/+Yr6yrxkw56pk2GNEvkmDteOAQ1GniVGMtVmXKfPd/rgeoJ2Mw0qYQVu7wZ+Y40Wu5WJYFCadvtawXbHPhfq+XlTPSNQ8uYkOQ20A1Ptq2YEDQOsxCLPGB9079dk+tGYV76AJjSZl8F8FALJ9v/Hk0NyqkMRzweXiUA+9+1qKb+4JMflBqoEGhNHGQqHUpd9KB2+s97rmUINcoBQ1NMl8gwDu6E5dnlibA2rRWFbbptBlSNYKF9+E/PgxDMxShz8rrLqHEMttXMkVfkIwShR8GU+/9w9XycIZ8A3lIWi99/aEA+kJGQoBB3p4XuZ9ZWK9q/CVZLQ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS7PR11MB7692.namprd11.prod.outlook.com (2603:10b6:8:ef::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.13; Tue, 17 Feb 2026 13:00:52 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 13:00:52 +0000
Message-ID: <77c016ca-7bd7-4f14-900b-e0c3ed9c0b9f@intel.com>
Date: Tue, 17 Feb 2026 14:00:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/27] Cleanups for ixgbe, i40e, iavf, and ice PMD's
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: <dev@dpdk.org>
References: <cover.1770646012.git.anatoly.burakov@intel.com>
 <cover.1771330390.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1771330390.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0145.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::12) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS7PR11MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: 0070b6c2-cf14-47d3-55bc-08de6e249472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7142099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OG1JazltOS8xR2NlR0dWQ2RoYUpUaVFTNzV2cnpKNmFlQzM2ai9FVW5CZU9W?=
 =?utf-8?B?TGx0Nkpwa0xHRzEwekxYMTFtS29uOTFyVkVRdm5iOTh5Wi9tTU5EL3BmV290?=
 =?utf-8?B?bGlBaXdqdGNtRStWRWdwT0I1Z2Rpb2w0N0dHV0ZIUWtLTlFHU0xJT2h5QytB?=
 =?utf-8?B?M3BOYVZqQ1RiaXhiRFRvZ3JsNENiNk9IaTJkTDlocjdiRElDNUdtVUp5VTFT?=
 =?utf-8?B?cERCVHE0alk1TGJGS3lqREtjSDlLVCt6M1phbFlyblRDY0dPT1lLVW5FQUFm?=
 =?utf-8?B?VlpkVmMwRTBlcnNqSjRyWFNMbHUwQlhVVzY4OFJUUzYvclJwZUtEbk1ySTlo?=
 =?utf-8?B?U2JpUzZQQUttRnJhN290SlRDNzJyZFRXZlFEb2pCWFlUQUM5bU5lOGxac2p6?=
 =?utf-8?B?MlFPNU5ZWGptZ281Z0tLbG9JMktoSGRIQ0hYRFRqK0ZBR2xJMUtIUmJYVEpo?=
 =?utf-8?B?c0thSUg1YVN1UFdyWHcxaDNZYm53WkdiN2VETitCd09TdCtUdnl2dW5rdEFD?=
 =?utf-8?B?RVg1NzdaU2JiQ2haMlJiNXJFakxaUDR3UHZWSlF6cUQ1bHpUV3hGZXZtU2U0?=
 =?utf-8?B?S0Q4R2JIbmszcy9OQlV2Wk5EeVorWkRLZlAwSC9ZdXBPZTEvbFJRTHJpd2lQ?=
 =?utf-8?B?VU52Q1NsaHg2NW5KekdPNWliTTQreXFDODljL3RLNE1OL1RwM0VYNURhL28x?=
 =?utf-8?B?SzVObmc5b012KzJYaG1rOHFWRXRlU3hTMTNHREcrd1cyUnZMSVZYRlAzdDRz?=
 =?utf-8?B?UjhIbm44TmgzSkFYZUpjMmNSSWFsbko3cjBaZjZERmxBVGNndytXdXBlRXpF?=
 =?utf-8?B?MjU5YkQwTkZGSnNMZnk5U3RnODgrbDcxRm1OR0xIekNINjJ3WXNNZGlJTVhL?=
 =?utf-8?B?QmExVmp3MkNhTmNvVzMvMldsNlZERXM3cXZKQnQ1R2N6eWdCbUpYVytSall6?=
 =?utf-8?B?WDJXVktyZ05XRkE0aTZiUjFIeDVJQ3RJMU5YWVB1OFlZMDB2R1hOQWtlSjZk?=
 =?utf-8?B?Z1FmWG80TE16M3hmeFRkS3N0MGU5Sk9iUlZPOEFEam9wR3B6dmY5Q3J5dldZ?=
 =?utf-8?B?alBuVEEwSGpYdDg4VFVuODdIUGlzTE9RdytxTHpZeXM0eDBGWkl0elk4clo2?=
 =?utf-8?B?MU1OVkJFelJ4WUk1Q2F3RXJhNlpRMmRtREpSNWQzbDQwWlRvL0dadnlaY2wy?=
 =?utf-8?B?TVpHRWI1RDRrell6enFYemdPcjhhUFN1ME0ybjlidExmbmJPVDJ5MkNvTXJQ?=
 =?utf-8?B?Ry9vc3ZXWFBTLzJ0dWpnd2tvdklIT1U5ek5BanJMbmVvYzRrR2NGWGZKdkdJ?=
 =?utf-8?B?QjljR2d2amZFeGNTdzJ5b3RZOWI3dm05d05uRmdWUkxsTDNpcjJHRGJEOGpM?=
 =?utf-8?B?UkNSSFU4NFZrQ3F1L2Zvd1hDYWRZem50dlNCeWJaYm5YSmxZOURVanJQWVZK?=
 =?utf-8?B?S0VxdkxpcGlBRWdZRkpna0FIMTYrdUFpTmI0TytmV0NTcGVPV2NaQmV0VUth?=
 =?utf-8?B?YlBVd25vOERVd1k3RUdIaUFvSGNKVUY4cWx6NE02QXhQMlMwRnpTVThMRUt1?=
 =?utf-8?B?NnRvMTczSkFHZHNMbmw1SGd0TzN1bXQ1VGVDa1k1NmhESFpVWkVyeTNabjNs?=
 =?utf-8?B?dU94bG9RUG5aNDllY1lKLy8zNVJEdFB2RXU3a2laWjVaZlFKaGsxN2ZTdXBS?=
 =?utf-8?B?cVR4aVlFVERxWVV6Q2pra2dxSDZRc3MyeXhNMmdjRDFuVFBubTMySkwxaWtJ?=
 =?utf-8?B?QllMWFNwbmpneHhkM0dxbitLeWdWWkZGWjFuU0owbUNWU0VjQnRnQ0I4WTVL?=
 =?utf-8?B?d1hiODArWDQ2NDhxNURxY08ybEZpQlFCdmgyZFpDNWNCbWg4WGhzZnpKU1Y2?=
 =?utf-8?B?eXRiK05MNDU0VktybWpjMFdtRnRZRFZBM0MyZjZGckRnckJJTFVaSFV6T0RO?=
 =?utf-8?B?YUFDMWU1MTNLWlNKYTE0M0xab1ZBRjNYeGo2SDBVays2M2xsV2ZkRWFhNnF3?=
 =?utf-8?B?OUpSTStZeVVVZ1AzU2p5OVNoVGNXT1J3SUJESDloVEZtMWZFdTNkdmJVakli?=
 =?utf-8?B?bVlBbWpmTWtMd0tGMllpQXlrcXBTWEpxR0pQTk03b3lHZFp0WmdaS0ttczdC?=
 =?utf-8?Q?aV7s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7142099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWF2M29Qczd2TlhqN0p3SEgrdjhmQUhIaGMyaWFUeCtKSGN5U2RVRGQrbHA1?=
 =?utf-8?B?ZmJZUW9YYW53OHJ1T09MWmFkUEtQSUlmV0pRenkvTFJ3RTRRbDdxYmk2S0NE?=
 =?utf-8?B?aVMrci9yeVVZa2ZEczU1RGdpaS9zS3RrcjVXSFpEbXZuRjZTYVhpL0hGVkFT?=
 =?utf-8?B?dHdlTzNRR0JOWlhmMlloVVNHTDRJc2gyT0Rsck1RUHU2cDlMOWd2S29ZUHht?=
 =?utf-8?B?eU50RS9xRERGcS9ndGZva2pMVllFdlhYNkE4SHNzM2ptNE5BNENJTktYWkNG?=
 =?utf-8?B?am1CMWNYaW5uVTVVa2RmT0FzZVJjbDFwaDlRcis5NlJ1RnYxV0xORnpFWFRZ?=
 =?utf-8?B?WWwxb0RJaDl2dis4a0lYSHUzRkxaYTRDMFMwRG4xdDZTUytiRFQ3QXJMRTNB?=
 =?utf-8?B?ZEVSZjF4ay91Y3pCUFBmRG9lSjVSMURDVHdKZ1Bsa2QyWktlUjdUSHJGMnNX?=
 =?utf-8?B?cnk3MGN5N2JDVk1qcS95TTJyWkJSTVU5WkNjTm82SDZhSkNGbFV0S2hKaGND?=
 =?utf-8?B?UG96UCszeno3bGw1bjdUam90bzFhd1gwTzhnaVNoWTBlR2J3aTBxQ3dDVlhS?=
 =?utf-8?B?cmErVWJSdytZOE9ZQTBjZER2MjJQMnpGRTF4T0xIQWdPeS9PN1F5K1RBUk80?=
 =?utf-8?B?QXltTUQ2WjkvWjlPR0Nsam1HckxLeVZqSU52cFNvT2tseCtlWmhENGFBdGlU?=
 =?utf-8?B?dUFGc0tubm1zYnp3ZU9BR0hqMmt2OEpxY1ZHSWdUS2MyOHNmS3FDbWFaZFVr?=
 =?utf-8?B?U1Nxa3I4NGNMbXJNRDFRc1puK2EwWEUrTWtkMGh0VWdNRENEbTN1THJFN1pT?=
 =?utf-8?B?VDVDNXRVM2NsTjRNSWtSb0tmUTlweVNQMlRaMkVDM2MydGpvRm11UnRSNzZa?=
 =?utf-8?B?UDhoenF3bUNWMitWeml6YWdjQ0pZbGVsN3lYYW1tR0FoRG14SEU4RkJiRkFy?=
 =?utf-8?B?QW5PSmJsZkRralE0K2k5RmR0MVNIOEdTeHNlU3ZUUUM5NC9uUEJoQWk5b0Uv?=
 =?utf-8?B?STRoOUpYVytmVWdiM05qTDlzR0IzTUpiNE0zeFhOUUgvRmF2ZjNFUjhlMmFv?=
 =?utf-8?B?N0JBRUFkbGl3NjlOZDBKdi9lNG1pMGZzTElDY3JMZno1THNxZXJUemFDbS96?=
 =?utf-8?B?dTQxVUR0MWc0ZU1pbjg1SkU4V3poY1dFa2hjMWxYeXN4QkFLWUZ0a3VJY09j?=
 =?utf-8?B?ZitMK3BNKzdPL0hxUnN4Q29MekVSdmhJOE5XSXlEOE45ZTFBMXdLQnZQdlNT?=
 =?utf-8?B?eER4RzBYOG9yWll1Q0tLamovSTY2cFJxSHJMbk1tbUk2ai9UNDlhRzNTQ1Y3?=
 =?utf-8?B?QkhtV3J1Tjd2S1B2VGxReVNXNWJ3eXpIZE9QUjlvbnVYV09Ia29yMGpOZ0Fh?=
 =?utf-8?B?OHdlSTNXUzFWZ3RHU3dyRG5NeFUyaXREQU9YdnlCd1IrMXM1SHZYSEdFZU9L?=
 =?utf-8?B?cW5oQ2hYeVo3SDZzbkZJZFZCRk9uM0dDb3F3TGhoZGhXenVCQVRxQVJiSlU1?=
 =?utf-8?B?UWwvNlRQYkZRUzdVTktiWHBYVjBMVVBTdzZ1dE50L0NFaDdJM0hZQmNJQkRm?=
 =?utf-8?B?L05LL2ZaZDRSY1lQUGpRaFVvT3ROYStmeWVVZHoxdXBaWFBTajJ5Q2p2Yk4v?=
 =?utf-8?B?RjJPMGZzcHpjbTRMdTQrODJqck5iNWk3Y1J6d3dySmtDN3RVTnZYMFdGWU9n?=
 =?utf-8?B?OXhsd1VIUXA4ZU5zMm5NTjRMS3IvOHgycW9mNjFLTHpnTFFpTVN1VXF1blZD?=
 =?utf-8?B?RStRM3FUS1N0TmJhOHlZWjRCRnFMeUVsQzA5Qk9idHZMTm5PSDJNYlBZSldN?=
 =?utf-8?B?Zm80TGZ4VjAwcURtZVcyYS9WeG5uZmZxbEM0MGJ1TmhDelZQaGJ2eUxiUkxP?=
 =?utf-8?B?OUNNdXZseFIrYXZrSlVXY2xnaGtGU0RBOGZxMGlsNmlsRkhxeEt4U09MYkhh?=
 =?utf-8?B?WFJoWUlsTGxzNDVVQytjSm16cDBQTm1NbWJzZlVaelpFcUovZlIyek9IV1Q0?=
 =?utf-8?B?d0tPMkVVUk9vVnBWZ2w1R0RKQmJzbzJMQ2tEaVhmKzMwQ1YzQjZyUHNiRHFW?=
 =?utf-8?B?QmkrSEJsblEvSGdDcUczbW15MXQ4Qng3MFBsbnJVWXFucHdYWmx3M2oxclVG?=
 =?utf-8?B?WFU1aGYzNWxKYlE0SHFjaEYxM2ZrSFV5QSt5L3pSaktCMFZOTnFBL2pMNURo?=
 =?utf-8?B?V0dFcnVDQUFRWVp2cUd4ejR2dDFVV0Q5eThsdU1HM1BNUmprcTVRZGVMckYw?=
 =?utf-8?B?aGYrQVRWblZGL0RySEVJNFNKeWwzOEQ1bEdQQlJkbllETzBFK2NwRWhhVU1o?=
 =?utf-8?B?UmFEZFJUZHI5QkhHdnZqOFNQTUhXUllYQjlycVJCVldUemQvUnVXYnRES1h1?=
 =?utf-8?Q?8+0S1y0K1l9FJJdQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0070b6c2-cf14-47d3-55bc-08de6e249472
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 13:00:52.3584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlPFNAUSFukJmMNg0fd+m6CNjUpHQbURe7XV5gvVktTJdYuBV6415rtF/+VVGHIfXvJPeXXMvza1wvu0it5RF0sivikLssW3WF32Ef6u/zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7692
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

On 2/17/2026 1:13 PM, Anatoly Burakov wrote:
> This patchset is an assortment of cleanups for ixgbe, i40e, iavf, and ice PMD.
> 
> IXGBE:
> 
> - Remove unnecessary macros and #ifdef's
> - Disentangle unrelated flow API code paths
> 
> I40E:
> 
> - Get rid of global variables and unnecessary allocations
> - Reduce code duplication around default RSS keys
> - Use more appropriate integer types and definitions
> 
> IAVF:
> 
> - Remove dead code
> - Remove unnecessary allocations
> - Separate RSS uninit from hash flow parser uninit
> 
> ICE:
> 
> - Remove unnecessary allocations
> 
> This is done in preparation for further rework.
> 
> Note that this patchset depends on driver bug fix patchset [1] (already integrated into next-net-intel).
> 
> [1] https://patches.dpdk.org/project/dpdk/list/?series=37350
> 
> v1 -> v2:
> - Added more cleanups around rte_malloc usage
> 
> v2 -> v3:
> - Reworded some commit messages
> - Added a new patch for ICE
> - Rebased on latest bug fix patches
> 
> v3 -> v4:
> - Rebased on latest bugfix patchset
> 
> v4 -> v5:
> - Adjusted typing for queue size
> - Fixed missing zero initializations for stack allocations
> 

Due to Thunderbird mishap missed a bunch of feedback, so v6 will come.

-- 
Thanks,
Anatoly
