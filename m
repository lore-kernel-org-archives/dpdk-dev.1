Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EDAC7EE32
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 13:40:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91B154025D;
	Thu, 26 Jun 2025 15:40:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 11C7140156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 15:40:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750945244; x=1782481244;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=E5EacqkinnArOwUnT5CnH795YvWcnEjTY4Sod8iE8Sg=;
 b=FmDGn5+GfA6u8+E4OK3akpd+w2Rk8UDql6+DcaUobm40mv0TAcdgs9pu
 Gz5WTlABDcSI8lsH3YiyzeDQ532AxuSOJS+2tk0iByF2UhbDgc/DLbEMZ
 kLbBQVX/3Aat1vOLrWWlv7YTNmCz1e1qPhfunlb8S4ie8syf8KDMWSRZU
 M0USGTg6TBK1SocaDp7JOJjxqd8cogXIYAv546Dv2cHOY8Xp2bSTZM68g
 OopxrIaXpzwy84Ibn3xA61Gz72MhID5yRVsDdmy2hzC7vmtUWftuBdo/U
 ckxdzZO08YygyrQqPyyM4yIu55klrgYgJIOaA+s8Ttby/YISCpNaFZh67 w==;
X-CSE-ConnectionGUID: DZTCZezJRlC9RBiIKAn24Q==
X-CSE-MsgGUID: xx1Gt6SwTqW7pxVoIx+JkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="57047497"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="57047497"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 06:40:43 -0700
X-CSE-ConnectionGUID: jWUNwBuGT8+eb9YsZgCKUQ==
X-CSE-MsgGUID: /BNiKMz4RE6vVwCz2fPySA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="189710713"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 06:40:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 06:40:42 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 26 Jun 2025 06:40:42 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.88)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 06:40:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2JbuyuyCNRKa680S6zahRm5vrtMqc9bjhdw2gbaYU6aCwcEE0IM1/pZIM6m3eQUzL7QB33NwKvwhUrRg3I/AAm7HAKa10NKzKjwEWWawkeWd6+knXcPM5hNtKnha5bZAGWszv+xQ5eFyUTEzCg16OkUXRYqvVHqTL4fEBKGAxPEIw2jY8LvMbS5zXUBojWWdZPZjUEoGHr6KTBqKj4arzRZZBsZcrfaU5PeOUVwksJC+U9t2+rAr77mVnSrTyzhPwl6R38hsPqUyT788xQwATvhFp2mNtXFkzHTLQJFA9YX4xOyp+y22v9NjkBeorKApcgF0U5O0H686G1ktImyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLbdeM3eR5z7loow/015OO7BnGTpfwfIAGS467JwEkE=;
 b=GgDATBYPwL0cWuUnLO3RT2Q5VUJhIIfKVgbrseNXicOBPsnaW/NYY8in/4ZPyudx+Nzz3tM3zhxEM0N6G/a+eYoBzCgNVB9pzffLMAI/DNFQepYck5/wiR3Yw1m6lIXlRohdLj7OHgYzMsi2VndRjqvPs/+RuQmRNGeZPIJ5KlkIn8fFsp0exh9GV/RJaM/7hmRNRjJEQvVn/QzqAN32eI0n/yPlQlfMsH2Zy5jGLgfApU0TSdU+Jkg4eX/nMvhshN2ULOV1mo6yYccyegh/9qfjG/0xUcpMIzdkHxPfrE7ixfxN/4PAqNi5lJ/EMBF6fnAX1TU3YUSg33yvFFZMLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.28; Thu, 26 Jun 2025 13:40:38 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 13:40:38 +0000
Message-ID: <cd530069-d32c-4216-812a-f50f93ae91ab@intel.com>
Date: Thu, 26 Jun 2025 15:40:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] doc: use core lists rather than masks in guides
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Nicolas Chautru <nicolas.chautru@intel.com>, Anoob Joseph
 <anoobj@marvell.com>, Pravin Pathak <pravin.pathak@intel.com>, "Ashwin Sekhar
 T K" <asekhar@marvell.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>,
 "Nithin Dabilpuram" <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Praveen Shetty
 <praveen.shetty@intel.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, "Sachin
 Saxena" <sachin.saxena@nxp.com>, Gaetan Rivet <grive@u256.net>, "Cristian
 Dumitrescu" <cristian.dumitrescu@intel.com>, Harry van Haaren
 <harry.van.haaren@intel.com>, Radu Nicolau <radu.nicolau@intel.com>, "Akhil
 Goyal" <gakhil@marvell.com>, Jingjing Wu <jingjing.wu@intel.com>, "Maxime
 Coquelin" <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>, "Kai
 Ji" <kai.ji@intel.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>, "Jerin
 Jacob" <jerinj@marvell.com>, Srikanth Yalavarthi <syalavarthi@marvell.com>
References: <20250624133409.550372-1-bruce.richardson@intel.com>
 <20250624133409.550372-3-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250624133409.550372-3-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0353.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::13) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|MN0PR11MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd813b6-0111-4400-abfd-08ddb4b708f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXJ3cTdaUVM4SHMxNGxLbzY2RkhTTjM5TEZRZkNvNFdXVXNmd1hHOWxJUFJD?=
 =?utf-8?B?NlBtZ1JKRXRmNWxXUXNpUXVQbmdIRERpQjdzL05ha2FOSWZRWkozdjdUMFda?=
 =?utf-8?B?VGV0WmMycEd1clRSZlRHYTRuaHFIZXRSelhJMUxNYy9KVWNOUHRmcTU1YTNs?=
 =?utf-8?B?d1RldGU4UmxLZG9WSHhzVmpKbjYybUZGN0ZxWGp5RFBZL01wWm5jczBMdlRj?=
 =?utf-8?B?V1FWY2NRME5DZkxacXEwc09POUY2Wk96ZFFDbWRnS1RPZmtFenFweVZFSDhw?=
 =?utf-8?B?TzZxdmwxRUU4MVVJVHRZdWN3enZPNTBib0pka3M5ckRLSW5wOVBkVGtNVk5J?=
 =?utf-8?B?WjNRNUFZalBONmlIajFWNjZaOUlTd2xNUzhHRFRSMHVUMFM3M3YrVlJnYVAx?=
 =?utf-8?B?UVlRTDA2dnN3eHEzMXBSQXF4MGZWK1luS3ZpN1B5VUhQUWV5eDNMdFVxK3E4?=
 =?utf-8?B?V1BXVGNrcFJjT0FKZ3JRSGRxdkNpSVlmMU5SK1BHSkxjekZWSVMzN2JEcEN6?=
 =?utf-8?B?NUZGa1BiVEtvd3czYnFSMHY5aVViOEZ5cFlZTjBVeHRndDVJV0h2bVJpcjFN?=
 =?utf-8?B?UG43TlhFNFprSkxLb1MzSVBFVjBIUlIxTE5tajJpeHQyeDMwVE01MUhiNVhr?=
 =?utf-8?B?bk92ZlpIQmxNaUViSXFwUG1yNWlwRDhZb1hWRFR3aXJRVE1vclE2aElBa0dl?=
 =?utf-8?B?VUt1YytTdGc3MDRXS3NhKzd1dGo4bS9yaWMyVlZ2ZE9jNFBCOFdnUTJNbVZI?=
 =?utf-8?B?UmdueXNqWmNzNTNZcTZxeVJNbzZ6VlpTcnVOQnFTOTJGV2RJT1J1THdyZXNX?=
 =?utf-8?B?aFFKN0lyN1VlczVQOGl3czY0ekpMS0cxaW43bGxiNFQvOGdYdkpwTzRac0tJ?=
 =?utf-8?B?RnQ5WjBmOG4vcHgwaVVGOE9EVGtlQ0ZkMEtqWWkvS2hxN29aSDdyOVFiUU4z?=
 =?utf-8?B?ZE5rTFZRQWFURWlibHAxQis3T20vL05MckFMT2FtUDZkUzJDZGo4Y0h0RHUx?=
 =?utf-8?B?T1N5akI4MmhWamJuVjFVQW44ZW5BY2c5RjdpQ3EzWEsyTDhzRTIxRlR5Rml5?=
 =?utf-8?B?ekFsMjhkZUhjb1FnZ3YrTU5oZzRndTQvQm1ScVhnbHI5emFwWFdOMGhoR3N2?=
 =?utf-8?B?TlMyYjYySmNRd241b2hYWUZnU1M4R1JkK2V2ZlNJQis3eHdYQXF3VVdzcVJN?=
 =?utf-8?B?M0hmb0o4RFNLOHhMMEJkLzV4dFQ3TFY3c2VaOEtlS0czN21OKzJaVjgxTkNu?=
 =?utf-8?B?QVBrYkFqdUtJbkM4VmxGN1h3SDl3Q2gwYnlKemU0ZU8rcFNqeVFVeXM4OU9W?=
 =?utf-8?B?OE9lYldUcE9RSzN6dERTbHlXTmtRaER3bjBCaHdBRU9yVXlNdGM0dzI1ZUs5?=
 =?utf-8?B?M1BoL3lQcFJXMlBuSzZSeE1BczEzL1dWVmtZWVJscG94UStoQXFtQWpGb09q?=
 =?utf-8?B?elQrTlJmcjJHOUkrQnBVWU4wWC9ObjBTMm1ISzhhbjM0eTRTSlpUdWRCRkdl?=
 =?utf-8?B?bEl0eUw3Uk4vL0UyQlVtR2ZPZ01rUUdpSDNjUnNLMjh0YXJsNEdGU0ltWjlw?=
 =?utf-8?B?NlkxN0Y5bm9sS2VJOVpJUkJBam9vU2ZLVkJVRWNuUGgvRnhmV0FVQnA5eVRJ?=
 =?utf-8?B?Z2FUSWhEOU5PRkdsemRrUWtjdVFaQWJpaWZyQ01nSG5mVzlLREk1bDJtM0FL?=
 =?utf-8?B?RkF4WEtvNEZPRGxvWnc1Rmt5emE5TmZQTG9pditJU3FsQUJvbVZFQkZORTNq?=
 =?utf-8?B?Z3MybEIyZ3VmWWwrTndpVmpPeDhxSm1iSmFRYkdGSnZpYmh3NklXZ2FIVUVY?=
 =?utf-8?B?RjBQMjdGeXZhSW9SZSt3RG1zVk1Zb2tkRlZKS2djN0oxNXRqcER6ejN4SUw2?=
 =?utf-8?B?b3BrM3laVVZVMXFlWWpjTTdpdU9rc0JZTUJRWWNmRCtINzBlbi9lYmZxOXVR?=
 =?utf-8?Q?5OUfywOHlik=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmhWTmhZN05adHhwYldlNEVtbWJTQUg2NWQxcndURmtwMnRPZ1lQSndYOVZC?=
 =?utf-8?B?R2llVVYwSHA1UTJHaDgxWGlTSm44QmgrSEZkNTJ6T3gyNkFSRzd0azVUS29u?=
 =?utf-8?B?YVYreWZPSlNqRU5Zcnk4Y3hMN2NWTC9QR1BLNHB6bUZURXpXYmR0Q0NJOGFW?=
 =?utf-8?B?WDNPelp4Y0VzVm56c2ZWRmVjVXdmV0I5bi9YeWpBUHlZSHlDaVBoQ2k4ZmFx?=
 =?utf-8?B?YVNUTysvbVJZRDBndFROK2lnL1FVT2d0eDZLRlByWVQ0Y0I0OWtNSGl4YTE1?=
 =?utf-8?B?T3NKcjNIY0ZTVDJ4K1FwcWJ6RUwzS0RTME9OR2g1bmdiT3lITmVsc0tpZjlO?=
 =?utf-8?B?Rld4c3hRWStzeFEvOFNJQkN0MnJSTG54VXJyRExBUkhHUnNUYVF3NWI1Z1Ux?=
 =?utf-8?B?bVZEZjJFQVJqK0lyRlZTZUY3L2ZHSk5veFpPbHBYL0w3MHNibDQ3TDlTVnhC?=
 =?utf-8?B?TFNyZFFZMmZqYWJHR0p1U2hIS3J3eDdNWEVnYzByaHo4dUg3alhKUVU3aVJW?=
 =?utf-8?B?RFp1dnNtTWlIYmJPbDNJeHY5dXF2dnozenp6KzlSOHc5NmFndllodUVsb2hu?=
 =?utf-8?B?ZmVyYzJoLytvTmMrYngvZURtSk1rQjRVeUVWdElvK01GL3hXZG9aUExDRndK?=
 =?utf-8?B?OGFHeFFEaG5yZ0twcjlyczBjclB1TlEzVGZUZjRFWGt1bndaN3pRZ3dqUjA1?=
 =?utf-8?B?K2pEai9oSVFudEN4R3dSZTl1REc2dFpOUWFyektCbktSTGlqNTliMlpWU0lT?=
 =?utf-8?B?djNnVzJFdGJ6NlJWeTRMV1VwODNma3FMcmI1UTlNOEtIT2dBeUNDMFJZZ1Ev?=
 =?utf-8?B?ZzhuNkZOOGt1bTdvWks5MzhWQTFjMGNvR2p3eDY5T0Z1N2ZPLzU3N3hMOFZI?=
 =?utf-8?B?NS8xNGVxekIrWnVaT0VNS0lHVE0yT1daVVZsRDl0dkF2bmFYRTBNeGJpcnRt?=
 =?utf-8?B?enN6bUVQUEgvVVNwWGM0clN5OGE2U09GUkQ1eW9KdEVaR3VPR3c5empGbTlu?=
 =?utf-8?B?NVptYTI4bGhvbEVoenE1YkR6RXRBVG9haDlSNnF5ZXlRSkxtaXdtTzFhMi9q?=
 =?utf-8?B?Y1BjZWgxSFlobFozOGVSdURKODlNVGNTZG56K0xVaFNuaUpWNFpIWDM2VmVN?=
 =?utf-8?B?YmFpcUN5T0luZTdJSUhkRy9DYWhMb28rV1VLR0JOV1RLREVwd0gwWHJxUUxV?=
 =?utf-8?B?S3VORm1RU1VKdnlkelZXNDYweUVBbWhUWDJHL3MxRVEwa0UvUElHOE5Gc2JW?=
 =?utf-8?B?WkVOSkxpSVVad0lDUEM3MWQxVkdKa1YwR0hUQXhqcWwzZ2I1MmlSRlhKR1RL?=
 =?utf-8?B?VXA4Nmk0UHF0SEtUK2RGK0IxRlpET3RLWWJ3UTdhK1kwa1RiRDU4SVBqY29a?=
 =?utf-8?B?RDNyZ2tsRFBESUZYOGF4elk2dDhTekE3R2dFS0o0dlArV2kzZ1FKSjdGZ01P?=
 =?utf-8?B?Vm9PeitLRk5MY3g1T0syV045RklLUkxGSXdzcDFsUFN3bkpFZmYva3J6Z21S?=
 =?utf-8?B?a0V5dUJtTTloeUp1c3hJM3Z6ZXNWejhXajk5ZmRLQ0lEK2kwa1dFbEJyNDlP?=
 =?utf-8?B?OGIwWmZBNjlvSFFBWkhtQ1hEWUlvSEFKR1UyZUg3aEdxb0ZiQlZqeGlIVUhC?=
 =?utf-8?B?a2VIaFN4a0phQTFaTk9CWk1IMk1NaFVIejlBcVRBMzVnNUhUc2lDWUtUSXJl?=
 =?utf-8?B?Y1E1S2ozYWNBT0tjZ3VaK3d5eGxQU212NXdpblNLeDhVNk14WGdKZTArNE5l?=
 =?utf-8?B?eWtyeVQ2UHIzaWdnNXRIQ0p4NU82ei9nU0lsa3JEYS9PWHRCczM4cmswSmlC?=
 =?utf-8?B?SWZqYjNteUdpZEFmRDFXWEkzcmdGTGJzZlV0RFphLzQwNHUwYUY5MEdPM0to?=
 =?utf-8?B?cFVIdzJ5M2s4ak5iVzMyY0hXaGNhR0dISUpLSm1tMWpLYmZCalpLRmlKVXVY?=
 =?utf-8?B?SEN3RUpQbzVOeENRTVlRY3J5elZDN1VBeHVRRkovdW5LUUEzT1c1Y2o2T0NL?=
 =?utf-8?B?eVRzSlNkLzR4bllxK3pNZ0NpcFBhTTI3VEVOTDFZUjNaVk5VMmVWb1diSlRE?=
 =?utf-8?B?d2M1eFFoREtESG1YRENJM09QUXBzb1RUY2R4V0VHZXhnRHR0Y1cxTldDb0ta?=
 =?utf-8?B?akRzV1Z2YUZVTzN4Szk3eWYxYm1xZVBSYklYZkNudmQ2V2ZBYS9zS2Y5VXlt?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd813b6-0111-4400-abfd-08ddb4b708f6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 13:40:38.0007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vvecxd3FzI96xuWJ4LzILyFz6o+U1qNrh3fGChh/RTfnXY73bxdt+riOvEmfwtP/Y4YIee3xW65O4Ec4bjz/bhV1OFq4QdWt07ugwv5wAmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5987
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

On 6/24/2025 3:34 PM, Bruce Richardson wrote:
> For the guides for applications and examples, use the "-l" flag rather
> than the "-c" flag to pass in core lists rather than core masks. While
> for the trivial examples given, core masks work fine and may be easier;
> in real-world cases, with potentially hundreds of cores, core lists are
> a much better fix, so update the docs to reflect this.
> 
> Similarly replace instances of "-s <service-coremask>" with
> "-S <service-core-list>".
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-By: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
