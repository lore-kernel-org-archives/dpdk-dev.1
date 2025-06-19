Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A6FC7115E
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 08:40:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A09E942E15;
	Thu, 19 Jun 2025 10:40:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9016A4025E
 for <dev@dpdk.org>; Thu, 19 Jun 2025 10:40:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750322405; x=1781858405;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CtMwuH8Cz9plVeouSNN3iIp5Ikx6tULQRDIwgKPT4kY=;
 b=fYIJaLTGmBQwbTcdS70dQXVNIU//5wzp9vrHlJsaIU+qp33z+c/7G+2/
 nnqVZHM2WBVnxzQU2UmjsogNgVwcwxCL/qEeiHCxot1bl70lxY+ASsu1A
 PM2P9vEGrjwy7qBgVQ5pd/EVJhLxerpVIDdhxzsne1nmmprqr6vZkKQys
 /ufLfXRW/+sdS7d14l2HLUhr79+WnwNA0JEbzRXLaYA0ffyPjMCHeporx
 oPq3laKn3ZwRFOneMCZIZuKar54nC/8PqRC2oyPEItXcjqsxIQj5L7iiF
 MwypTdI8FJmWDeF7sUGvoJHH3GIE+TdNo6EiD3VcOTxJryXPDn4R31/mp w==;
X-CSE-ConnectionGUID: PDLWS48qTsuMEtxyyRYAwg==
X-CSE-MsgGUID: wy1e8X2fSkWrwWn+bC5cnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="63929944"
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; d="scan'208";a="63929944"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 01:40:03 -0700
X-CSE-ConnectionGUID: Wd5FT57UR6W5glN+e090JQ==
X-CSE-MsgGUID: fGtSzV8kTHS/e9btJsW7AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; d="scan'208";a="150339509"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 01:40:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 01:40:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 19 Jun 2025 01:40:02 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.73)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 01:40:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HA8xYXULt4rpI1rOR/ux9d4H2Xhv6DcA/vqrIIPS71YNT9kZwxAVgBWLOMXoHtGkCPkuYWgdK17PUFc0eLwaiqLqfXbGb/xA/504V6DooW2yClv6wUfHS8FBL0P8J3gq5nzXYdSKN6xX6Bm+VUHVnpOmPADJoauImh69bXBePYgYVWrxR6xGB5knZfgWBKGVCew4x22fjn8gVPqw3EOnCIF0t7L/lzvdDH7qsgfZS5CinT0DXJHc2iZcspsppi/aFvBQlQfpnwPqs2lrsL5mbaOsG3d1sDti/cdV6lF8vuaHNpTj4dm6TJwQRBlRwEVWPh48lRoU6pyjMOfRr/FNZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtMwuH8Cz9plVeouSNN3iIp5Ikx6tULQRDIwgKPT4kY=;
 b=LLnQxXhPpZU79xE1NjdhcDkB+ckaL0iyU8eDo+3Ez2WNOr/xt2YYQ38n+u3Iet3YH0XHh2IzrPka+jCBlUIz5aMwHtzYL3+pTl+y/W6bNXfoVb8DeMi9c+0OWMLQW64iLNqQutdb1dTPSp4o8gaqSjUITtZv4M/N3GtfEQiEbv4Wayf/xTabb0WSQwvGg5oRqXFb2+MweviCs9p2+VX+rNFNiztSxotpaYvWdWcRL1lx6jdyx7E9vHL5qa57Vp3pYnGkDxXFnrwRKwwL8ymMM59WGoXFhzaX6zea6SrwTIBkr6xcV/rATx9Lah6Z097ps66p2jL6N3zfhyPXiUZQ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by SJ1PR11MB6156.namprd11.prod.outlook.com
 (2603:10b6:a03:45d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 08:39:58 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::19b1:dfa1:9d1f:38e9]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::19b1:dfa1:9d1f:38e9%8]) with mapi id 15.20.8769.025; Thu, 19 Jun 2025
 08:39:58 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: Shivaji Kant <shivajikant@google.com>, Thomas Monjalon
 <thomas@monjalon.net>, "Tahhan, Maryam" <mtahhan@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Joshua Washington <joshwash@google.com>
Subject: RE: [PATCH] net/af_xdp: add rx/tx queue support for af_xdp
Thread-Topic: [PATCH] net/af_xdp: add rx/tx queue support for af_xdp
Thread-Index: AQHb4Hg0IKRlXuQilEaRQd+h6Kqv5rQKKjXQ
Date: Thu, 19 Jun 2025 08:39:58 +0000
Message-ID: <DM3PPF7D18F34A123EE7323CC7FE84DBA6C8E7DA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250618174103.1345466-1-shivajikant@google.com>
In-Reply-To: <20250618174103.1345466-1-shivajikant@google.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|SJ1PR11MB6156:EE_
x-ms-office365-filtering-correlation-id: 1b17bba7-5f24-4d95-e38a-08ddaf0cdfa6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aHcwd3lydUN6Ni9YMi9PbEl2VmVFWGtsS0dIR3gwc214RGpJMW0rNzVjeWhy?=
 =?utf-8?B?K294UnB1aGJILzZmdFhteVNWc0wxcm1qdFE2TnFUMHR6bVVweWFYQnRkV3VP?=
 =?utf-8?B?dWFHeXBKZzltSmJnazV2OG12aE9kZkNOcVNwRjgyemM1UUczY2xNWFRpR2Y3?=
 =?utf-8?B?dnZhWUZ0OHNtcUU1TlhyZzVqQnFpaE9IMmxGZE84TmNWYkRyYk9OZGM4YzBp?=
 =?utf-8?B?U1I1anAzR2pYRStpNG9MMjY4S2QxL3V0bHkrSkVIT1ZUZ0EvSTk0Q01tblVM?=
 =?utf-8?B?b212MWx4LzFNVXovSUkzSDRMUkJ6cUFiS1pWS05XanNCTnowNndVZGF4Nzl3?=
 =?utf-8?B?aUxPejIrL3Y1bUQ0MWxJR2g4cUhqWWc2NFJqN21zRCtZYm01c1VRYXNFNU5o?=
 =?utf-8?B?d1ZEWHpTdHZBTFNTQ29KbHVORjJoUlR0cWZxZWtMM0xnNWZFRElteHo4dGdN?=
 =?utf-8?B?TTJnajdCMTZFTHQ5S3BVYUZ5N2ZiTmE0QXVoc1REdkw3VHY0NFRJSkxDeGh3?=
 =?utf-8?B?VnZsdkpLTE9BNHRzU1dlMC9UUFh2T3g1YW9qamhNdmFGenY5T1dWeFFJREZO?=
 =?utf-8?B?N25mZ2pFUEJkREZRWVlsM1RhMy9PYmJuME8rYVBsT3RiSThNN1dnQmJRMDI1?=
 =?utf-8?B?Z1MxbDl0SWlLZzVoNTdvQ2ZSU0N6eDR3Q3crWjJ6YXlNOEZtWXEyRkVONm1y?=
 =?utf-8?B?TVVmakJmd2NTeXVqSm1PVUh2UTZrc1ZEeXkrMUdISFNZb1RvNXBkRFp5SWVm?=
 =?utf-8?B?S1FvVksrdUlza1JQS2RTNjREY05aKzlHWDU3SndYRTdWRWF2SHFicGVFUEYy?=
 =?utf-8?B?aE5vQUVQaS9kSFNUK09IdmR3c0tvTHJjOElSbTJGRXR6TStOWnRIYWloQUc2?=
 =?utf-8?B?R2tzaU9KSlFzT1kvdkNDOVFFb0ovcmZKdFFkOVA3eE1zLytVK3JCRDNtSTA4?=
 =?utf-8?B?UmRCeHZYczlWUG91TlpvajBsSHZRUm9ZYnE0MWhnaXlRMTZha2NrdmdleVdP?=
 =?utf-8?B?M3hzOGs1Ly9yZTZHWHpkQ1FZSk92dFhDcW5hcEtyTnNUOUkzOFlHczlGb0JO?=
 =?utf-8?B?SGx1MFl3MHlvRHN0TkVjT3NWRFN0RnhiL0JFREhpUlc0d2dMcW9ma3BkNWdL?=
 =?utf-8?B?KzByZ21McHZydlNvdXlYU28xcmVOSG9vTWlENGNQQVlUNzdQQVB3TE11dGZa?=
 =?utf-8?B?aGlDNDE3QTlDZE5rcFhkNG9peGhVLzBiWHhTUDVHaHZVUFJFb3RZQU1LaEFs?=
 =?utf-8?B?NFBxdkVlYUEvaCtXYjEwSFlnT3FsNmREV1dTSWhGWkFteDhabFZMUWtmM2hR?=
 =?utf-8?B?ZDBDbEVJSEc0N05PZi9lMmpubk15b3hpMWo1cHRDTXpUNHJ0SFA2dUkzM3RX?=
 =?utf-8?B?UGMxdjU1dklsMG9zRVRnRzZ3REFiZWFybU5KbDNHU2tRMjB0YWQ0LzdwMExP?=
 =?utf-8?B?T3VxQXRtK0FrcnlGSVMyUG05cFVFeUE1M3hiWC95b1lOdjFPU0RTRy9GREdl?=
 =?utf-8?B?MWRPcXgzbERFYVV0dXphZzNCbnNGZG9BRWNFVzQydFNpTnNtTTc1NkV6am5N?=
 =?utf-8?B?dVY5d2ZxaGcxeEZGbk91K3hTQjFoeGdjdkx0MGRiTmg1ZU9uQlZUSzNrL0t4?=
 =?utf-8?B?UkQ0dnBLTjM1aHJDT21nQVhvZG93N21jNlYyVXQ1TE90MWp4UkVkbjkyNTZx?=
 =?utf-8?B?ZkdpTkpwT1Nnb20yVjU4UWEvUGtPTllKS1hoSVZjVHQ1aW5RZnZZNmhjOUdB?=
 =?utf-8?B?MzZ0ZGZZWEkwMzNDZFZOcTRCMUo4MzlKME5jeDFrZDZYV3VWWHFxbCtER08v?=
 =?utf-8?B?TGwweVRnb3ViUk1vWmxKMU1HczRzYy9hWkdrdE9zcGRRQ0E3cnhON0M1M0Z0?=
 =?utf-8?B?OVdlVTlsTzN6WUNpeUJmbStud1BmamJneFhjYUw0TU05RGE4bkFadkw1cmRD?=
 =?utf-8?B?QWpXK1ZCS3dsaVV3aTJUdDNudllFWTJpN1JLYTAybnRkRTBZeW9YWEFlK2RG?=
 =?utf-8?B?Nm9zYXBNcElRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1dtRElESTdtMDcwSTd3TmIvRlpzekZNOHdKSmh6VGx2WXBVSndNNTFRU0d5?=
 =?utf-8?B?WGRmTEZBbGhiMktCKzU0UkNrNW52ZkZySmsyNnExeVo5bzJnQk9HdUM4cHln?=
 =?utf-8?B?cmNJa2dmeUI4RTJEbDdqL3kzT0x3UjJkMFZMcnVSZGJkNng2enFvVDhzYU9P?=
 =?utf-8?B?WFdUaWFBVUJCeFFqWGZ6Z1Q5dzJtTVNab205Zm8xQ090NHREeEpuZjJxM09y?=
 =?utf-8?B?UFFmalNSV1JlazI5STNyWXFhbW0zSk9WQUV4ZjBDZ3dJOUk2V1VnS1VQRWp5?=
 =?utf-8?B?K2hhYjI5Mk9mdFN1cHQ0THA5TlN6SVFpRUdqQmcvdUtNeGIyemhyQ0V6UkVY?=
 =?utf-8?B?U0lIMEkxaXZTVTc0alVPeDV0QjlVQ2h1WTNCOTZKaWFiZ1BsMzZScEJQMnR4?=
 =?utf-8?B?dldKS0JSR2FaT2kzSjhhOE9qaVpKMFpzM0k1NXpjTDJLT2c3K21WV1ZMVThx?=
 =?utf-8?B?UC96OUp2a2JabjVHRnZTblNCMGFpUmhlc0NhekNIczBCRjB2T1lkL09meDd1?=
 =?utf-8?B?ODZMRUdRZmN5UUdPbUxiTzRoRFNPcm9RUzF6ZFdoUmh2T3lGdHhsWkRIYVpU?=
 =?utf-8?B?RExSeTgzQjlZZEM0ZnA4UU1mb2pMYWs2NTdmOU9QYi8xRWtGeHkxaXB6c3lB?=
 =?utf-8?B?ZGNZVW56KzdlWGRpV2djQ1RsSHdrb3Y2KzUrWEFVYmhiYXVLMXJxQVhONHc2?=
 =?utf-8?B?K2d3c3dPdXRQYUNNRk9UQTRITEIzaStmb1BxOUo1NUx5Njhyb0F0V1FwYy96?=
 =?utf-8?B?c3FYQlpFU05oNWZsTzVSbXNkNGR4VHhFc3AzbTdOWlFGYmNxRkhBVmQ2c1gx?=
 =?utf-8?B?ZEJDVS9SV1BmaDBDSVFsTmF6RFZVODY0N05jczU4SEppMkpsbG1MOVlKVG9p?=
 =?utf-8?B?REdkZVJ2eFBsR1haVVdoSWppbHVEMGtZbE1RdFFYQUsraFNxcWtjY3NoM3ZI?=
 =?utf-8?B?ZnVzWXRDbC9UUm5nMmlCclRQaGFacko5YTJ1cjlkTkV5R0xqS0VpQWdPbWlv?=
 =?utf-8?B?cERuSDR6eWNDTkdBZ0xuWm0zaTUyNjdrVVdmUE83bTAwKzFDby84UnZFNkkw?=
 =?utf-8?B?SkRDOUFGbHJiaTNPL2VERk9nbEN1UEs5SngxdGI1WTJNYVhsdWp6b21VaEU1?=
 =?utf-8?B?bDN3QlZyZFlic2YxcnRxbkN6NEpYK3pPRUljdi9QWFR5Yk5Bcm5NVTNoeXBG?=
 =?utf-8?B?ZEdqMXV2S2VxbmZDMndaNUoxL0s4WWV1U3ZnYXhjUjRNa1hLaFBJZ1Zkc05r?=
 =?utf-8?B?UHZmSFg5K05SWkFoVjR5WSt5WU4rbkFDamxZcjUxblJFRVhOSTFHYitlb1l6?=
 =?utf-8?B?Y1RTMVZvUlpPQjhBL1VITEZWUXVONnRjakdnYXlNYytHRVY5M3BrZjVRbFRv?=
 =?utf-8?B?OGZLSk9GNEtvdlBaZW9IK1VGSE05T0RZZWU5QmVOMlhGWVEyeFpIQldUclZD?=
 =?utf-8?B?UmJGTWxRM0JQMW5NWmRNbTM1R0tQalIrTExma0ZBd3haN0g3N0pYcFdhaGhS?=
 =?utf-8?B?Q3hIZHBjVG1sZTFlNmNlUUFTekFsRUljWjRzVEprSzNicVJnVXBIelQzdDJY?=
 =?utf-8?B?N055TGJkSjIvN1lUbUcvVHROVkkrSjFkM1ZLbEk4eSs0ZjhoRDA0U2c3QVVn?=
 =?utf-8?B?MEJTN2xRUC9Tb3RiOHREUmVUVzUxbnJDWDRTRjQxU0xETWhmTE1YTjFWVjRh?=
 =?utf-8?B?amhXWXFhRkhZWHkzYTdYOFBvejl4RVBVcmRIaUFGL0o4dWorMndpVktCcjlw?=
 =?utf-8?B?dkFqajFvRHQrUEU2RXpKNnhpUnRIdWpsR0VqeFVQdjB1eER1UVJ3ejhXaVRM?=
 =?utf-8?B?aVpveVI2eERXUXZuY0xuYnd0TzhYN1NHQVJpRTNhbEY1NGlVdHg2N08vVDhQ?=
 =?utf-8?B?ZGkwRm9aalJ5QURwT0VoN3o5R2JIbVJDRDhiTE5MejRlSEFRakFiQ3NUa05z?=
 =?utf-8?B?Rk9nTVdJYzJNcm1UZXFDcFJBRXQ4aTZnRjhmNGgvT3ZrWUlVMUhxOHluRkVS?=
 =?utf-8?B?M2M0ZlRjT2NIN1FTYzhlSGV0MzdKMmNUdmg2ZzF3MTViN05Scjh5MEFNbklz?=
 =?utf-8?B?d0RPNkgzUUZxT0pSZG0wRHVDVVJyVjNRZW1yUS9KU3NmaTM0am91ZkVFdDc5?=
 =?utf-8?Q?YOpn95T1fHYB+4f+0GTR43gnp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b17bba7-5f24-4d95-e38a-08ddaf0cdfa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 08:39:58.2688 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0dM14ZDC7BOdailWZRJ4YZOlMNA3iLRPDWbYGp69fbmBq2/ge3W0P9zGgCDt8jxIGvvG2nPlQ02STyKQflVR6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6156
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

PiBTdWJqZWN0OiBbUEFUQ0hdIG5ldC9hZl94ZHA6IGFkZCByeC90eCBxdWV1ZSBzdXBwb3J0IGZv
ciBhZl94ZHANCj4gDQo+IERyaXZlciBsaWtlIEdWRSBkbyBzdXBwb3J0IHJ4L3R4IHF1ZXVlIGNv
bmZpZ3VyYXRpb24NCj4gcmF0aGVyIHRoYW4gY29tYmluZWQgcXVldWUuIEVuYWJsZSBBRl9YRFAg
dmRldiB0byB1c2UNCj4gcngvdHggcXVldWUgY29uZmlndXJhdGlvbiBpbnN0ZWFkIG9mIGNvbWJp
bmVkIHF1ZXVlDQo+IGNvbmZpZ3VyYXRpb24gaWYgYXZhaWxhYmxlLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogU2hpdmFqaSBLYW50IDxzaGl2YWppa2FudEBnb29nbGUuY29tPg0KPiBSZXZpZXdlZC1i
eTogSm9zaHVhIFdhc2hpbmd0b24gPGpvc2h3YXNoQGdvb2dsZS5jb20+DQoNClRoYW5rcyBmb3Ig
dGhlIHBhdGNoLiBMR1RNLg0KQWNrZWQtYnk6IENpYXJhIExvZnR1cyA8Y2lhcmEubG9mdHVzQGlu
dGVsLmNvbT4NCg0KPiAtLS0NCj4gIC5tYWlsbWFwICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDEgKw0KPiAgZHJpdmVycy9uZXQvYWZfeGRwL3J0ZV9ldGhfYWZfeGRwLmMgfCAzMCArKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRp
b25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS8ubWFpbG1hcCBiLy5t
YWlsbWFwDQo+IGluZGV4IDg0ODNkOTZlYzUuLmM2N2NhYTdjOWQgMTAwNjQ0DQo+IC0tLSBhLy5t
YWlsbWFwDQo+ICsrKyBiLy5tYWlsbWFwDQo+IEBAIC0xNDIzLDYgKzE0MjMsNyBAQCBTaGlqaXRo
IFRob3R0b24gPHN0aG90dG9uQG1hcnZlbGwuY29tPg0KPiA8c2hpaml0aC50aG90dG9uQGNhdml1
bW5ldHdvcmtzLmNvbT4NCj4gIFNoaXFpIExpdSA8ODM1NzAzMTgwQHFxLmNvbT4NCj4gIFNoaXJp
IEt1emluIDxzaGlyaWtAbnZpZGlhLmNvbT4gPHNoaXJpa0BtZWxsYW5veC5jb20+DQo+ICBTaGl2
YWggU2hhbmthciBTIDxzc2hhbmthcm5hcmFAbWFydmVsbC5jb20+DQo+ICtTaGl2YWppIEthbnQg
PHNoaXZhamlrYW50QGdvb2dsZS5jb20+DQo+ICBTaGl2YW5zaHUgU2h1a2xhIDxzaGl2YW5zaHUu
c2h1a2xhQGludGVsLmNvbT4NCj4gIFNoaXdlaXhpYW4gPHNoaXdlaXhpYW5AaHVhd2VpLmNvbT4N
Cj4gIFNoaXlhbmcgSGUgPHNoaXlhbmd4LmhlQGludGVsLmNvbT4NCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L2FmX3hkcC9ydGVfZXRoX2FmX3hkcC5jDQo+IGIvZHJpdmVycy9uZXQvYWZfeGRw
L3J0ZV9ldGhfYWZfeGRwLmMNCj4gaW5kZXggMDUxMTUxNTBhNy4uNjg5OWI2YjE2NSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9uZXQvYWZfeGRwL3J0ZV9ldGhfYWZfeGRwLmMNCj4gKysrIGIvZHJp
dmVycy9uZXQvYWZfeGRwL3J0ZV9ldGhfYWZfeGRwLmMNCj4gQEAgLTE2OCw3ICsxNjgsNyBAQCBz
dHJ1Y3QgcG1kX2ludGVybmFscyB7DQo+ICAJaW50IHN0YXJ0X3F1ZXVlX2lkeDsNCj4gIAlpbnQg
cXVldWVfY250Ow0KPiAgCWludCBtYXhfcXVldWVfY250Ow0KPiAtCWludCBjb21iaW5lZF9xdWV1
ZV9jbnQ7DQo+ICsJaW50IGNvbmZpZ3VyZWRfcXVldWVfY250Ow0KPiAgCWJvb2wgc2hhcmVkX3Vt
ZW07DQo+ICAJY2hhciBwcm9nX3BhdGhbUEFUSF9NQVhdOw0KPiAgCWJvb2wgY3VzdG9tX3Byb2df
Y29uZmlndXJlZDsNCj4gQEAgLTIwNDMsMTEgKzIwNDMsMTEgQEAgcGFyc2VfcHJvZ19hcmcoY29u
c3QgY2hhciAqa2V5IF9fcnRlX3VudXNlZCwNCj4gDQo+ICBzdGF0aWMgaW50DQo+ICB4ZHBfZ2V0
X2NoYW5uZWxzX2luZm8oY29uc3QgY2hhciAqaWZfbmFtZSwgaW50ICptYXhfcXVldWVzLA0KPiAt
CQkJCWludCAqY29tYmluZWRfcXVldWVzKQ0KPiArCQkJCWludCAqY29uZmlndXJlZF9xdWV1ZXMp
DQo+ICB7DQo+ICAJc3RydWN0IGV0aHRvb2xfY2hhbm5lbHMgY2hhbm5lbHM7DQo+ICAJc3RydWN0
IGlmcmVxIGlmcjsNCj4gLQlpbnQgZmQsIHJldDsNCj4gKwlpbnQgZmQsIHJldCwgcnh0eF9xX2Nv
dW50Ow0KPiANCj4gIAlmZCA9IHNvY2tldChBRl9JTkVULCBTT0NLX0RHUkFNLCAwKTsNCj4gIAlp
ZiAoZmQgPCAwKQ0KPiBAQCAtMjA2NiwxNSArMjA2NiwyMyBAQCB4ZHBfZ2V0X2NoYW5uZWxzX2lu
Zm8oY29uc3QgY2hhciAqaWZfbmFtZSwgaW50DQo+ICptYXhfcXVldWVzLA0KPiAgCQl9DQo+ICAJ
fQ0KPiANCj4gLQlpZiAoY2hhbm5lbHMubWF4X2NvbWJpbmVkID09IDAgfHwgZXJybm8gPT0gRU9Q
Tk9UU1VQUCkgew0KPiArCS8qIEZvciBkaXJ2ZXJzIHdpdGggcngvdHggcXVldWUgY29uZmlndXJl
ZCAqLw0KPiArCXJ4dHhfcV9jb3VudCA9IFJURV9NSU4oY2hhbm5lbHMucnhfY291bnQsIGNoYW5u
ZWxzLnR4X2NvdW50KTsNCj4gKw0KPiArCWlmICgoY2hhbm5lbHMubWF4X2NvbWJpbmVkID09IDAg
JiYgcnh0eF9xX2NvdW50ID09IDApIHx8IGVycm5vID09DQo+IEVPUE5PVFNVUFApIHsNCj4gIAkJ
LyogSWYgdGhlIGRldmljZSBzYXlzIGl0IGhhcyBubyBjaGFubmVscywgdGhlbiBhbGwgdHJhZmZp
Yw0KPiAgCQkgKiBpcyBzZW50IHRvIGEgc2luZ2xlIHN0cmVhbSwgc28gbWF4IHF1ZXVlcyA9IDEu
DQo+ICAJCSAqLw0KPiAgCQkqbWF4X3F1ZXVlcyA9IDE7DQo+IC0JCSpjb21iaW5lZF9xdWV1ZXMg
PSAxOw0KPiAtCX0gZWxzZSB7DQo+ICsJCSpjb25maWd1cmVkX3F1ZXVlcyA9IDE7DQo+ICsJfSBl
bHNlIGlmIChjaGFubmVscy5tYXhfY29tYmluZWQgPiAwKSB7DQo+ICAJCSptYXhfcXVldWVzID0g
Y2hhbm5lbHMubWF4X2NvbWJpbmVkOw0KPiAtCQkqY29tYmluZWRfcXVldWVzID0gY2hhbm5lbHMu
Y29tYmluZWRfY291bnQ7DQo+ICsJCSpjb25maWd1cmVkX3F1ZXVlcyA9IGNoYW5uZWxzLmNvbWJp
bmVkX2NvdW50Ow0KPiArCQlBRl9YRFBfTE9HX0xJTkUoSU5GTywgIlVzaW5nIENvbWJpbmVkIHF1
ZXVlcw0KPiBjb25maWd1cmF0aW9uIik7DQo+ICsJfSBlbHNlIHsNCj4gKwkJKm1heF9xdWV1ZXMg
PSBSVEVfTUlOKGNoYW5uZWxzLm1heF9yeCwgY2hhbm5lbHMubWF4X3R4KTsNCj4gKwkJKmNvbmZp
Z3VyZWRfcXVldWVzID0gcnh0eF9xX2NvdW50Ow0KPiArCQlBRl9YRFBfTE9HX0xJTkUoSU5GTywg
IlVzaW5nIFJ4L1R4IHF1ZXVlcw0KPiBjb25maWd1cmF0aW9uIik7DQo+ICAJfQ0KPiANCj4gICBv
dXQ6DQo+IEBAIC0yMjE1LDE1ICsyMjIzLDE1IEBAIGluaXRfaW50ZXJuYWxzKHN0cnVjdCBydGVf
dmRldl9kZXZpY2UgKmRldiwgY29uc3QNCj4gY2hhciAqaWZfbmFtZSwNCj4gIAlzdHJsY3B5KGlu
dGVybmFscy0+ZHBfcGF0aCwgZHBfcGF0aCwgUEFUSF9NQVgpOw0KPiANCj4gIAlpZiAoeGRwX2dl
dF9jaGFubmVsc19pbmZvKGlmX25hbWUsICZpbnRlcm5hbHMtPm1heF9xdWV1ZV9jbnQsDQo+IC0J
CQkJICAmaW50ZXJuYWxzLT5jb21iaW5lZF9xdWV1ZV9jbnQpKSB7DQo+ICsJCQkJICAmaW50ZXJu
YWxzLT5jb25maWd1cmVkX3F1ZXVlX2NudCkpIHsNCj4gIAkJQUZfWERQX0xPR19MSU5FKEVSUiwg
IkZhaWxlZCB0byBnZXQgY2hhbm5lbCBpbmZvIG9mDQo+IGludGVyZmFjZTogJXMiLA0KPiAgCQkJ
CWlmX25hbWUpOw0KPiAgCQlnb3RvIGVycl9mcmVlX2ludGVybmFsczsNCj4gIAl9DQo+IA0KPiAt
CWlmIChxdWV1ZV9jbnQgPiBpbnRlcm5hbHMtPmNvbWJpbmVkX3F1ZXVlX2NudCkgew0KPiAtCQlB
Rl9YRFBfTE9HX0xJTkUoRVJSLCAiU3BlY2lmaWVkIHF1ZXVlIGNvdW50ICVkIGlzIGxhcmdlcg0K
PiB0aGFuIGNvbWJpbmVkIHF1ZXVlIGNvdW50ICVkLiIsDQo+IC0JCQkJcXVldWVfY250LCBpbnRl
cm5hbHMtPmNvbWJpbmVkX3F1ZXVlX2NudCk7DQo+ICsJaWYgKHF1ZXVlX2NudCA+IGludGVybmFs
cy0+Y29uZmlndXJlZF9xdWV1ZV9jbnQpIHsNCj4gKwkJQUZfWERQX0xPR19MSU5FKEVSUiwgIlNw
ZWNpZmllZCBxdWV1ZSBjb3VudCAlZCBpcyBsYXJnZXINCj4gdGhhbiBjb25maWd1cmVkIHF1ZXVl
IGNvdW50ICVkLiIsDQo+ICsJCQkJcXVldWVfY250LCBpbnRlcm5hbHMtDQo+ID5jb25maWd1cmVk
X3F1ZXVlX2NudCk7DQo+ICAJCWdvdG8gZXJyX2ZyZWVfaW50ZXJuYWxzOw0KPiAgCX0NCj4gDQo+
IC0tDQo+IDIuNTAuMC5yYzIuNzAxLmdmMWU5MTVjYzI0LWdvb2cNCg0K
