Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6657C8303C
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 09:00:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B44F40287;
	Mon,  7 Jul 2025 11:00:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id AF1494025D
 for <dev@dpdk.org>; Mon,  7 Jul 2025 11:00:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751878831; x=1783414831;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=O5xeB/dRf6JPL4894msbxWsWG7ZmXd9eSlEpdd2ojDg=;
 b=Z884ARfWLJXio34+ahYBHY0Coz+vAJtZ6cq21w5Po6mFKiqpjygl3wn9
 ccdNuObKePjE3hJXZaU0sc9JfNNYAuKUJ8H2RB/NiIySx+Lj5lKxRLnn/
 L/8d7jatFm9LUQuPm/f99UmHEy7rpeSdAZPhpkvJvEMZLDefdkO5savar
 AGWIBJB7Ae9I1mHWBPIWJPiA3tLGDePWGsUomQbz+pmyk7OQ3To8xjy2B
 T7uou3TDZpSmPSt7P5anoqXl+Qi78bsyalbMlNfFWbCc7yO78ZyTxaK/O
 rYuYYhp3GsvQg00dY1Cx+mBZ3dTiRi6tChM8dUHXxTROEmbwNhHYHlaMi g==;
X-CSE-ConnectionGUID: +gNlJ1wfSx+8gfD9bVK7Ig==
X-CSE-MsgGUID: //i43DVQS7ygT1OFdhOq0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="76644102"
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; d="scan'208";a="76644102"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2025 02:00:28 -0700
X-CSE-ConnectionGUID: r1cZ1Z3IQqqnccq1zV2xDw==
X-CSE-MsgGUID: yc61yUC7SkSC9PuQnOK4vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; d="scan'208";a="159195868"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2025 02:00:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 02:00:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 7 Jul 2025 02:00:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.87)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 02:00:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2jYGD6xlSya2v4G8kWLX8lR82A+U2Mpy6Ffy5K+J7XMou9ZqNPyT8fkGGBfJw7s0KXCca7H0j+psBbv8V15aVAh9/EnH2DOc81aEWyF4BNskxlrKVofsE701cpdikolbE0lY8dYBt2dTrudsMrdmijmoK4sTD/3D9B+sTydbhARY7C1fHQ0/1WSG7zTIOIto4Xf3745zKgQpGkjDWw9ytEWhLrWw3iY1DpmYHOdR9JMNBr0YWjkH6ZnX1LZB/L+/cIQyKK6K/R1nM3g6SbsdXlRUg4pLcLfLB70olTPnV4YfjN/d15nnM3g7s5V4xEJSYnbhNvYV+7lgHmXoky9fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5xeB/dRf6JPL4894msbxWsWG7ZmXd9eSlEpdd2ojDg=;
 b=WiEdOneJgkbh6jv0pmzaPvKITGdYyj5+KUlWm3VL9zEgP0MpBFOWtJYndZcdzUBHd/z1cDY1aKCjcCb8VxBNh4WNqnQjA3j5nSJEOEGlJPipW7gDcsHES7H2eMbWhhm1E2DiwrSyTePX0y8nh5lGxAfHJbQAKqbcy8tN2hJOEcL4TKTGx1JrBWEW/ZXAfB8Vdv3vPVbEV++98fdzvP7REm4KtUox1fE6ZSPVkv6Ln5fn0oI9+ZDTElcaWTpuRiatzinFuC65lChZiv1eEei28KUt+Gowmlcd0uvzFnchELIzXfELiR5+ydPoxav4AOtGcFku8PPIOQ8GJB+ZEZG5IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ5PPF56FDAD370.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::82a) by DM4PR11MB7184.namprd11.prod.outlook.com
 (2603:10b6:8:110::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 09:00:09 +0000
Received: from SJ5PPF56FDAD370.namprd11.prod.outlook.com
 ([fe80::f9b:966e:2823:f229]) by SJ5PPF56FDAD370.namprd11.prod.outlook.com
 ([fe80::f9b:966e:2823:f229%3]) with mapi id 15.20.8813.022; Mon, 7 Jul 2025
 09:00:08 +0000
From: "Naga Harish K, S V" <s.v.naga.harish.k@intel.com>
To: =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <hofors@lysator.liu.se>,
 =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <mattias.ronnblom@ericsson.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: Jerin Jacob <jerinj@marvell.com>, Peter Nilsson
 <peter.j.nilsson@ericsson.com>
Subject: RE: [PATCH] event/eth_tx: prefetch mbuf headers
Thread-Topic: [PATCH] event/eth_tx: prefetch mbuf headers
Thread-Index: AQHbn6YFqAHfW3ID8kGgUvaUsg96ILPmqzjQgDkyxQCABx0F0A==
Date: Mon, 7 Jul 2025 09:00:08 +0000
Message-ID: <SJ5PPF56FDAD370AD3B60F4AA326723904BA14FA@SJ5PPF56FDAD370.namprd11.prod.outlook.com>
References: <20250328054339.489914-1-mattias.ronnblom@ericsson.com>
 <SN7PR11MB7044C3B89BCFC25021522487A164A@SN7PR11MB7044.namprd11.prod.outlook.com>
 <ff692fe7-03b5-408d-8112-5a4b30d9f96b@lysator.liu.se>
In-Reply-To: <ff692fe7-03b5-408d-8112-5a4b30d9f96b@lysator.liu.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ5PPF56FDAD370:EE_|DM4PR11MB7184:EE_
x-ms-office365-filtering-correlation-id: e7c0e2dd-60a8-424a-cd57-08ddbd34ac99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZzN2anhsbkJXU1E4Qk5tZXJOMFIyRzVYMjAzK3drWXdrZVFuODQ3WUdlQ0lT?=
 =?utf-8?B?bmtDVWNZMWlWMEJIbHBxaEtteE9scjdXWFJUYm5JejI0QzhTaXNEdUNZWHYx?=
 =?utf-8?B?M0hWdTlYaTkxSmtjMlJORG5KNG1GN3A2R0JFWENZTVZNZ3Z5RXZBSVlEcmxV?=
 =?utf-8?B?NDdzTTJQU3lCUGF4ekcva3Z2Um92bEFGWnMyNkZtN3YxbjNwd1QySm9pRkNY?=
 =?utf-8?B?T21tcjVkUlptTFJidWE3M1ludjFZMjM3ZXl4V1ZrRGVtb0pxOWgwdThDbk8z?=
 =?utf-8?B?Z2Z2LzgzUzZkYkdGRW9NdlFRYnA0aW9yQWU0Z0Q4a2FPODhqYjNrMEFuZldo?=
 =?utf-8?B?QzFFeDFDNmJhUFhRZWxDbmthYlBRNW1JZEF6b1ZVL1I0QjNHN3ZsY3U5L3V1?=
 =?utf-8?B?b3BWUDlWdjgxRDIwNTNvRjFWTVJqRmtDY1BKVWN5NXdWSUdCZGdlTVJzNmpt?=
 =?utf-8?B?SzRsNVhaVFBGOTRFM25uZUJITFFsL1dSR0N1eSs5am50ZlpHcEVEZDBpSFF3?=
 =?utf-8?B?K3l5YUJhSGN4dVNUeUNMcnV3TDJYc3QrY0RrQ2dKRTN6blZHVk5JR1k1OGhj?=
 =?utf-8?B?ZzcrdUQyMDFGVUpqbTJWdk1odW4vRHZLY1dhMHpEalBxR2J4ckFKd1VCaTZP?=
 =?utf-8?B?U1pnM251NkR5ZkFlK1JlUHNIbXppK0NBbk9uandvN2VEK1ltYm10UEg3d2w4?=
 =?utf-8?B?dG1ydUxIUkZiYS8zSllxVUZMaDRKN2lkNnE3NmlYdkdaZkMrOVdUZzk4WlMz?=
 =?utf-8?B?QTRqcS9YaUVZVnI2RnFRamRHMG1XSVg3U1ZvSCsrQUdNdVlDdUwvSWZ5RG85?=
 =?utf-8?B?SUNubkdjaVpKNGtCMEI5R3IvbENYdDlyVGpiSWdudWJXckJzSiszRCtlTTNJ?=
 =?utf-8?B?OFZReVU1VmtaL3FDVU9BVklLbGJuWTJtNWhrT1ZHMWJyQzV1Q2tOQjk3Z25v?=
 =?utf-8?B?dkJoeGhLOXpUd2g3cXZtMHJmRm9jOGhKZEQ3ZldsV1c2WDM1TGNTMHVNNkF0?=
 =?utf-8?B?REpYaWJPL0J6Z0JjZThDYXBESm0rVFhCMExROUkzcFp2VmtVNGRCQ3R2Ukxw?=
 =?utf-8?B?L0RjZUpKOXQxbkY0UmZTOUVtRmJVZFlUM2YvUGFDV2ZUWTlnSzFkSTcyRnRT?=
 =?utf-8?B?T3cyYklnWldHUlZGMEp5b3BnYjZTbG9wc2Rlb0FJRGl0cG0xZlE2dE9TblND?=
 =?utf-8?B?TmlxOWRGbkFjVjFIMXd6Wll1MTBJNFFzUlY4TnlQa2w3NDFzbnY2eXcrSWw4?=
 =?utf-8?B?dmoxRVdUWWZTTWpmN1c2MWJTYW9HQk01ZUpJN1BIM3lFZ090NlpuUEN4N1Q5?=
 =?utf-8?B?VmZsR2NHQy9JKytNbVJMZ3VRY1hPYkRiMHJBZVU4U2tKalI4ZGVkS200YjFi?=
 =?utf-8?B?dVFrOGZpNTNmU0E5dG9INkpSdmtzc2lqVHVRbmJBOWRSS1FjV2hNZUthNGIy?=
 =?utf-8?B?OVB2VDNXV0pGMVJTaWp5TW5BK1hhY3ZVdmsyRUV6bkxYWVNBSmtDM1lDNVl0?=
 =?utf-8?B?Z1ViemRQdEcxUU1ZWk9aajJNVGlac3EvNDdDaUtmYkJtbWRCNzZvUUt5djFS?=
 =?utf-8?B?RzJKVis2UGdlQlNSQWhReUo1MnF4VTQ3VlRRM0o3UlZFNmh1cXFSekVzWWlj?=
 =?utf-8?B?TnA2T0l1SCtvb0Vsa3NjbXF2aGd2YldRMjRQbTZCQVpHY0dxS3JVZ0d0T0h0?=
 =?utf-8?B?QktqZTFablNzWGFVckp6Y2oyWk1pMVBWblBLVU12clFoSHhCbEc0dnF0UFNz?=
 =?utf-8?B?MGhmRGp4TDRVME1vRlNvOWludVdiNXhCaDBHdFdCQkk4RytxdnlheW02cWhr?=
 =?utf-8?B?azBnQkVSWU5NaUNmR1U3d2hNd29uNk0vYUpFRVUxc01ZcGxYZzBzcnhTeWs3?=
 =?utf-8?B?a0d3RHdsVEwrZnhHUTRaTVd2MEQ2ZVhJWWpPaW1EeUFjWS9kTXE5VXRrOFp6?=
 =?utf-8?B?SVczR3BNZlhtOW11SUdvdXNCRUhpRTdEL0tBQWhvUGlQVlZ4ZWlWbHduL3Ey?=
 =?utf-8?B?MEg4UjdBQlV3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPF56FDAD370.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VktuWDk0VS9xZWhQeVhqeUY0NEZOZHV6S1AwR0RZOUNERGc1SGFLKzh5NGtG?=
 =?utf-8?B?ZW56RDhXd014VmdDZkk4TGx1R2hxOVNMekt5QmxxR002VUIvNlN0TEY2UEMy?=
 =?utf-8?B?U1JXczdhUURQM044djFGL3k5b1YwM0dDZUc2d0Y4VEx3UVNiTUNuUXpvUzRQ?=
 =?utf-8?B?eEl2QUVEZG44dDhTcHRocWloTE1WbWtENDJvRFB5TW9FclhSK01Db0ZRZlp0?=
 =?utf-8?B?empzWUFxWEIvTUEzTnFtTE1ZYlNxaURtWjcvVVk4SnlLSnVaZnNxV0RibVRz?=
 =?utf-8?B?Y0hZNmM0NHhscDNCSWgyRWo1VVd4RlJaRGxvTE5iS3ZHOW93azRQRFVRWlFv?=
 =?utf-8?B?YlZwenVySmY2NW43MVN2L29CRkQ1ZjhuOHU3bTlpVm12UWo4VXlWRXZZWlVL?=
 =?utf-8?B?WTdPNWtueFN6UUVJS3BEd2FLWklDVzhSUVZPamVZV01ETHZCM3JIaHlVQktz?=
 =?utf-8?B?blF5anpoR3plNXhvNktiUkgrdFBaVGhwczFTT3RrcUlxMFJKSllkVmorRk91?=
 =?utf-8?B?NUFveGlQODU2ZTY5YkdIcDA1MzdSR2hYUGJoWlFEQUlIOS91Z2FBaThhV1I2?=
 =?utf-8?B?TFdHZEs0b1hBSnlIK1BhQjM0UndNeEVPc0RsK29BS0NrbFV6ZWFpM1V6OGZ3?=
 =?utf-8?B?dVVBUjJoTkgyM1JsK3JEY2V3OEVCYWx0YTdkSUpKV2hhdzhsQk1wYVNkMHA3?=
 =?utf-8?B?SlAya1M1Q3ZWZXNHNm12NE1tTGJpcUl3SGkydXl0SWFGVnNiNVlSZDdDYzV0?=
 =?utf-8?B?MFdCZ0dySW1UN3RYRmpmYlhpbGxqZWY2Q0hUcnlNbFViaStWdkFmMFhIRFM3?=
 =?utf-8?B?bk1KSlRQUGtUcEhQWFFQVnZGYUFpOG9aZ1BXVWYxWWZKNUM5dHdVTU5lQXBW?=
 =?utf-8?B?ZmhRN1dBdldQbTdCQUhxSjFyL2tRdmtoWVVnUFI5RGZQL0l2TXR4eXlyYXgz?=
 =?utf-8?B?cXFrbXpaOVRjREZPUE9UWHNGQUROVDNKVEtTdWJGRDN4bXQvNm9kRFdVd1Fk?=
 =?utf-8?B?eHBZeWdtZVROd3VhUTZhcDYwYXBOQ0NBYit5L0JROFpRTFMzMVA4RVlYZVFE?=
 =?utf-8?B?dFV1NDY1c0VCT1piZmUySEd3Nm1vSU5sQmY1dm5pME03N0hIUGF5cnJXRmdo?=
 =?utf-8?B?ZkZRbWcxT3ppeXQrNnpiN25Oblo0aUR2RlhqdVRGQWhHTWgycWR0OVlpeXVm?=
 =?utf-8?B?OEZ1UkNUL2NRRUNWRlVSYkZVMXlYb3hRWEVFSVNLaGFmanlDYy9Ld0p2YTBa?=
 =?utf-8?B?UjFaWDB3NHI0ck5LQjBUZ21hWUxreXFrOElMRXBQQVZNdllxWnA5U2YxNlQ0?=
 =?utf-8?B?M1U4SEVERk9nSFhvYWdubHB2L3NNL0dZUFFVNDJFbkNpVWJsaGtvV2dEc2lj?=
 =?utf-8?B?SUl4TU9WSW9pdU94OVJSeHF6cjJJYkR5TTlGM3dveGROYVQwYVM0Ti8wMHV1?=
 =?utf-8?B?STMxcEtaRXo3V0Zqc1UvbUVZbmFYU3dyTTR1NC9sNk9MRzJFYWtjUFRxdkFm?=
 =?utf-8?B?WVFFUWpxSkVyQk1ZQnE5T09Ya2ZjMjNHUk1nZW9iZThFNVlXOXdmbnNGZW5V?=
 =?utf-8?B?QXQ3ZzRVaStXSnVQakVieVpReWhTWlRHWGk3RDRGRjF4enpva3NtdVl3RlpG?=
 =?utf-8?B?eEcxa0JlVURzMHAySTIyOEJwelpxKzVnV2ZGbHk1cTJBd3ppVG82UytmcmNF?=
 =?utf-8?B?aTRNWmxhQVIyNEFMQ0V0Tnc4K2EvamZ5dFVVQ2J2NUhGc2dQdXJGNUZnMDlY?=
 =?utf-8?B?elRZeE90cWFrUHJrWGFpMngvTGltSVlwbWJQeWpoTFJMbHVuZVdFaitnemVN?=
 =?utf-8?B?VFZMeXFDbWJFU2VBQlFtNlZPYk14cjVDMGhpSkRJZUFhdjcvclRhS1dnTFRs?=
 =?utf-8?B?OU1lNUcxa1FyNjk0ODdZb0hScmpndjNUMmZreWgyR3hMaXlmRUNndTRCRW9E?=
 =?utf-8?B?SHZBRzVPcWt0UlVPT0Q5ZEFTSmNVMmE1SW8vSHhvRWlnNDF4RHh3dkxVWkc2?=
 =?utf-8?B?VnBreU0vcUtoWnVuYmU5T1E4T2lXUVdpMG1QRnhkZmZhRzJ1SFlCOHBFbktt?=
 =?utf-8?B?S3cycU56YVlIWUh3bmc5bWZOUDQ5NHlvYUJ5VExMUXJ0REw1VHdhNlRvWmRn?=
 =?utf-8?Q?dkEf7a0l/6WE6BdSnY9FHAdW9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF56FDAD370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c0e2dd-60a8-424a-cd57-08ddbd34ac99
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 09:00:08.7987 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1NXYuenU1gwYADlkdaiweoeK97Awu+JSy6fCzUBqhn5pvLA+VMGDYxpNZfctkODPwn3W/GLXEDC0uAJM0TkpOrgzN2JOI5BpPCuKG/PDh8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7184
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWF0dGlhcyBSw7ZubmJs
b20gPGhvZm9yc0BseXNhdG9yLmxpdS5zZT4NCj4gU2VudDogVGh1cnNkYXksIEp1bHkgMywgMjAy
NSAxOjUwIEFNDQo+IFRvOiBOYWdhIEhhcmlzaCBLLCBTIFYgPHMudi5uYWdhLmhhcmlzaC5rQGlu
dGVsLmNvbT47IE1hdHRpYXMgUsO2bm5ibG9tDQo+IDxtYXR0aWFzLnJvbm5ibG9tQGVyaWNzc29u
LmNvbT47IGRldkBkcGRrLm9yZw0KPiBDYzogSmVyaW4gSmFjb2IgPGplcmluakBtYXJ2ZWxsLmNv
bT47IFBldGVyIE5pbHNzb24NCj4gPHBldGVyLmoubmlsc3NvbkBlcmljc3Nvbi5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGV2ZW50L2V0aF90eDogcHJlZmV0Y2ggbWJ1ZiBoZWFkZXJzDQo+
IA0KPiBPbiAyMDI1LTA1LTI3IDEyOjU1LCBOYWdhIEhhcmlzaCBLLCBTIFYgd3JvdGU6DQo+ID4N
Cj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBNYXR0aWFz
IFLDtm5uYmxvbSA8bWF0dGlhcy5yb25uYmxvbUBlcmljc3Nvbi5jb20+DQo+ID4+IFNlbnQ6IEZy
aWRheSwgTWFyY2ggMjgsIDIwMjUgMTE6MTQgQU0NCj4gPj4gVG86IGRldkBkcGRrLm9yZw0KPiA+
PiBDYzogTWF0dGlhcyBSw7ZubmJsb20gPGhvZm9yc0BseXNhdG9yLmxpdS5zZT47IE5hZ2EgSGFy
aXNoIEssIFMgVg0KPiA+PiA8cy52Lm5hZ2EuaGFyaXNoLmtAaW50ZWwuY29tPjsgSmVyaW4gSmFj
b2IgPGplcmluakBtYXJ2ZWxsLmNvbT47DQo+ID4+IE1hdHRpYXMgUsO2bm5ibG9tIDxtYXR0aWFz
LnJvbm5ibG9tQGVyaWNzc29uLmNvbT47IFBldGVyIE5pbHNzb24NCj4gPj4gPHBldGVyLmoubmls
c3NvbkBlcmljc3Nvbi5jb20+DQo+ID4+IFN1YmplY3Q6IFtQQVRDSF0gZXZlbnQvZXRoX3R4OiBw
cmVmZXRjaCBtYnVmIGhlYWRlcnMNCj4gPj4NCj4gPj4gUHJlZmV0Y2ggbWJ1ZiBoZWFkZXJzLCBy
ZXN1bHRpbmcgaW4gfjEwJSB0aHJvdWdocHV0IGltcHJvdmVtZW50IHdoZW4NCj4gPj4gdGhlIEV0
aGVybmV0IFJYIGFuZCBUWCBBZGFwdGVycyBhcmUgaG9zdGVkIG9uIHRoZSBzYW1lIGNvcmUgKGxp
a2VseQ0KPiA+PiB+MnggaW4gY2FzZSBhIGRlZGljYXRlZCBUWCBjb3JlIGlzIHVzZWQpLg0KPiA+
Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBNYXR0aWFzIFLDtm5uYmxvbSA8bWF0dGlhcy5yb25uYmxv
bUBlcmljc3Nvbi5jb20+DQo+ID4+IFRlc3RlZC1ieTogUGV0ZXIgTmlsc3NvbiA8cGV0ZXIuai5u
aWxzc29uQGVyaWNzc29uLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgbGliL2V2ZW50ZGV2L3J0ZV9l
dmVudF9ldGhfdHhfYWRhcHRlci5jIHwgMjAgKysrKysrKysrKysrKysrKysrKysNCj4gPj4gICAx
IGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEv
bGliL2V2ZW50ZGV2L3J0ZV9ldmVudF9ldGhfdHhfYWRhcHRlci5jDQo+ID4+IGIvbGliL2V2ZW50
ZGV2L3J0ZV9ldmVudF9ldGhfdHhfYWRhcHRlci5jDQo+ID4+IGluZGV4IDY3ZmZmOGI3ZDYuLmQ3
NDBhZTAwZjkgMTAwNjQ0DQo+ID4+IC0tLSBhL2xpYi9ldmVudGRldi9ydGVfZXZlbnRfZXRoX3R4
X2FkYXB0ZXIuYw0KPiA+PiArKysgYi9saWIvZXZlbnRkZXYvcnRlX2V2ZW50X2V0aF90eF9hZGFw
dGVyLmMNCj4gPj4gQEAgLTU5OCw2ICs1OTgsMTIgQEAgdHhhX3Byb2Nlc3NfZXZlbnRfdmVjdG9y
KHN0cnVjdA0KPiB0eGFfc2VydmljZV9kYXRhDQo+ID4+ICp0eGEsDQo+ID4+ICAgCXJldHVybiBu
Yl90eDsNCj4gPj4gICB9DQo+ID4+DQo+ID4+ICtzdGF0aWMgaW5saW5lIHZvaWQNCj4gPj4gK3R4
YV9wcmVmZXRjaF9tYnVmKHN0cnVjdCBydGVfbWJ1ZiAqbWJ1Zikgew0KPiA+PiArCXJ0ZV9tYnVm
X3ByZWZldGNoX3BhcnQxKG1idWYpOw0KPiA+PiArfQ0KPiA+PiArDQo+ID4+ICAgc3RhdGljIHZv
aWQNCj4gPj4gICB0eGFfc2VydmljZV90eChzdHJ1Y3QgdHhhX3NlcnZpY2VfZGF0YSAqdHhhLCBz
dHJ1Y3QgcnRlX2V2ZW50ICpldiwNCj4gPj4gICAJdWludDMyX3QgbikNCj4gPj4gQEAgLTYwOCw2
ICs2MTQsMjAgQEAgdHhhX3NlcnZpY2VfdHgoc3RydWN0IHR4YV9zZXJ2aWNlX2RhdGEgKnR4YSwN
Cj4gPj4gc3RydWN0IHJ0ZV9ldmVudCAqZXYsDQo+ID4+DQo+ID4+ICAgCXN0YXRzID0gJnR4YS0+
c3RhdHM7DQo+ID4+DQo+ID4+ICsJZm9yIChpID0gMDsgaSA8IG47IGkrKykgew0KPiA+PiArCQlz
dHJ1Y3QgcnRlX2V2ZW50ICpldmVudCA9ICZldltpXTsNCj4gPj4gKw0KPiA+PiArCQlpZiAodW5s
aWtlbHkoZXZlbnQtPmV2ZW50X3R5cGUgJiBSVEVfRVZFTlRfVFlQRV9WRUNUT1IpKQ0KPiA+DQo+
ID4NCj4gPiBUaGlzIGdpdmVzIGHCoGJyYW5jaCBwcmVkaWN0aW9uIGFkdmFudGFnZSB0byBub24t
dmVjdG9yIGV2ZW50cy4gSXMgdGhhdCB0aGUNCj4gaW50ZW50aW9uPw0KPiA+DQo+IA0KPiBZZXMu
DQoNCkkgdGhpbmsgYWxsIGV2ZW50LXR5cGVzIG5lZWQgdG8gYmUgZXF1YWxseSB3ZWlnaHRlZC4g
TXkgYXNrIHdhcyB0byByZW1vdmUgdGhlICJ1bmxpa2VseSIgZm9yIHZlY3RvciBldmVudHMuDQoN
Cj4gDQo+ID4+IHsNCj4gPj4gKwkJCXN0cnVjdCBydGVfZXZlbnRfdmVjdG9yICp2ZWMgPSBldmVu
dC0+dmVjOw0KPiA+PiArCQkJc3RydWN0IHJ0ZV9tYnVmICoqbWJ1ZnMgPSB2ZWMtPm1idWZzOw0K
PiA+PiArCQkJdWludDMyX3QgazsNCj4gPj4gKw0KPiA+PiArCQkJZm9yIChrID0gMDsgayA8IHZl
Yy0+bmJfZWxlbTsgaysrKQ0KPiA+PiArCQkJCXR4YV9wcmVmZXRjaF9tYnVmKG1idWZzW2tdKTsN
Cj4gPj4gKwkJfSBlbHNlDQo+ID4+ICsJCQl0eGFfcHJlZmV0Y2hfbWJ1ZihldmVudC0+bWJ1Zik7
DQo+ID4+ICsJfQ0KPiA+PiArDQo+ID4+ICAgCW5iX3R4ID0gMDsNCj4gPj4gICAJZm9yIChpID0g
MDsgaSA8IG47IGkrKykgew0KPiA+PiAgIAkJdWludDE2X3QgcG9ydDsNCj4gPj4gLS0NCj4gPj4g
Mi40My4wDQo+ID4NCg0K
