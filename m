Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBB7C83029
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 16:19:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E01B4402A5;
	Mon, 30 Jun 2025 18:19:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 4D4634025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 18:19:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751300370; x=1782836370;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=83aP1mNDddUQjaFRnBdzYYEVzvlqtsQuqZRtVfL4mVk=;
 b=dyOzM4jPqpbIXBuFzRqJl+CKHUD88MWLcAbCiKirEkWLodBzrZ0dTVli
 4WcQZ2AikSCu7iU+ELWXdA9FmhNgnS4sQlyUPU6dw9SCWUvENBOAMWjEw
 MI+zatqRsSRlBlMhb7SJD0xKZUMBH6sE/hC2ORxPWcUlxOUlQKgekLGNW
 aVK+26F65ybLwxkL/XRx8m94PIs1OYVsl+seezlPa40sT419FmdHlL9qG
 ddORzvBOZjYgtuj+fdTT+P951tP4yispfuECFPuIVggKAQclGH/2N9wjd
 UR8FoZHQfrP6r/5S1K8RQn4rO72nd1/m/lMwOYTk3QdOYlStyRswfD/VF A==;
X-CSE-ConnectionGUID: loSnrPCLR/WoxPKtGSnoZQ==
X-CSE-MsgGUID: 7yk016UgTJmyvCaHdeZewA==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="63789374"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; d="scan'208";a="63789374"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 09:19:10 -0700
X-CSE-ConnectionGUID: 7XqSzLmwRH6ea7siAUh4Gg==
X-CSE-MsgGUID: E6Ytla3LRou/b1kH+gxz9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; d="scan'208";a="152980426"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 09:19:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 09:19:05 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 09:19:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.44)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 09:19:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=coMqebZoRtYcw6k3QnhfkozpQKID1FhHrrUnlstV3mDxp5YZhYSZPI4jyUOeARN7jRPukH5ve59GwFulSSp1wXYNL5bqJfBmjG0PT6QhpFYuE2JKJfjtdMLW+vk77q2d2cP7ov3Wf3u9ib/gDuE0+wLEXiqYL0Jqn+yTHxXS/+KWu0guJymUfMK1RKcHOIp83PrFTgCifqrwTkbLCFuJxzItvs464j+oEVGJVZ769jBUMWpqXnst1loRpw22/YID5fTrDH71hRx9mBOnTUa4kRYilxbMjdOJBxiU2bhDCMNCa0F1GEu4W5p0szhvTu8ngdo5JLyVJmPwXWAdHCmMwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83aP1mNDddUQjaFRnBdzYYEVzvlqtsQuqZRtVfL4mVk=;
 b=OXDK1SI0efkorceW/Sw/bN+KTIjy/Soc/ExhkaMiOj1jjezg1ofmv0UzrDaGEPtYg1aB0tgHgOaQtbe+ccBcgKKaYoUVQyXdt8F7QE8oyHwyASWQQrWtld9EtTiF9W7hnz7KJkY04Nbe4ERfK997Ln9EIAm4Zpxa3X5AXA8Iq5E3wOIUFdJG+OEDVvy+cUU/Puct6lSZKAz2hm2k4ZbeY0HNdJk7UrbzYPKXUE8IMTw+odnhmV3Obx7q+pl7dB8YqhaJh/vxwUJ5CfQkWLHB8H8VoExaG/bnJdYD8bV8Miwg5fmwSWcNM6nRhMIbGr5GxgUzMyWy08bYzFTOwasbiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5461.namprd11.prod.outlook.com (2603:10b6:208:30b::17)
 by SJ0PR11MB8294.namprd11.prod.outlook.com (2603:10b6:a03:478::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.18; Mon, 30 Jun
 2025 16:18:21 +0000
Received: from BL1PR11MB5461.namprd11.prod.outlook.com
 ([fe80::8d83:7a30:43c4:835a]) by BL1PR11MB5461.namprd11.prod.outlook.com
 ([fe80::8d83:7a30:43c4:835a%4]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 16:18:21 +0000
From: "Pathak, Pravin" <pravin.pathak@intel.com>
To: Jerin Jacob <jerinjacobk@gmail.com>, =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?=
 <hofors@lysator.liu.se>
CC: "dev@dpdk.org" <dev@dpdk.org>, "jerinj@marvell.com" <jerinj@marvell.com>, 
 "Chen, Mike Ximing" <mike.ximing.chen@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "thomas@monjalon.net" <thomas@monjalon.net>,
 "Marchand, David" <david.marchand@redhat.com>, "nipun.gupta@amd.com"
 <nipun.gupta@amd.com>, "chenbox@nvidia.com" <chenbox@nvidia.com>, "Sarkar,
 Tirthendu" <tirthendu.sarkar@intel.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>, Shijith Thotton <sthotton@marvell.com>, "Hemant
 Agrawal" <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@oss.nxp.com>, 
 "harry.chang@intel.com" <harry.chang@intel.com>,
 =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <mattias.ronnblom@ericsson.com>
Subject: RE: [PATCH v1] event/dlb2: add dequeue interrupt mode support
Thread-Topic: [PATCH v1] event/dlb2: add dequeue interrupt mode support
Thread-Index: AQHb5+hQTKfpvceKnEijI2kY71ZrfrQbcGgAgAAgywCAAAeCgIAAS4OQ
Date: Mon, 30 Jun 2025 16:18:21 +0000
Message-ID: <BL1PR11MB5461AD27C632B62C4A81FC59F446A@BL1PR11MB5461.namprd11.prod.outlook.com>
References: <20250628045112.655999-1-pravin.pathak@intel.com>
 <CALBAE1NrMu3znG6N+iSQacxHWpoGmCe=azvTbkjEUQZGLY+DmA@mail.gmail.com>
 <bc0299d2-052d-4188-ab18-987360d65cb4@lysator.liu.se>
 <CALBAE1MUrpZqWA=E78QiWy7k=H8QrYQ-=4vme4eHqSm8avBHJg@mail.gmail.com>
In-Reply-To: <CALBAE1MUrpZqWA=E78QiWy7k=H8QrYQ-=4vme4eHqSm8avBHJg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5461:EE_|SJ0PR11MB8294:EE_
x-ms-office365-filtering-correlation-id: fc94a4e1-412c-40fa-f9a7-08ddb7f1bb78
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WkVuVVlRU0Mrem5jUVA2a0xZQjFkMWlnOGo5VnNqWE9GbCs5VzdMakExYmx2?=
 =?utf-8?B?MHZxSVpyL2E3SGd5dEVVcFZyOEVKak1IVjBhU1lKUy9MM1p2dVd2UDVQR3JS?=
 =?utf-8?B?ajhDeEJHWDRNTEp2dlJiUVJqMGJmcytzUVN6d3FaM0EzbTZsMng5eVl5bWh4?=
 =?utf-8?B?Y3VYMytwdzJHc0pHOGVCVmNMYVRsNU1HSHBOMExkL3h5ZCtYK0pITWNGUTEy?=
 =?utf-8?B?M2YzVUNZeGwwaWZjY2pJR0FoNGk1dDQwdGlJNUp3T2pJZkJCeXdmT2EvQW9K?=
 =?utf-8?B?QjczZjZ2dzFHekViOGYzNEdqTWR0djEyalZrUlVDejRUcWZzOENRWFJrUWpy?=
 =?utf-8?B?bXNveFJ2dS9kdzhBbTF0ZW11ZFkzZldDMVBTdDBUWHBNZmY4WUJzdHZoVThF?=
 =?utf-8?B?NHVORmp5aktlSENLK3VtOU9qM0VXSThEQkZNNm9TNnRJdTU5NFdrSGIxcndR?=
 =?utf-8?B?enRMV1ZzbDhJbGVSZEVuSXoybGFlVm5KTk1uWU00VnFvb2Z6N0pZNmFtM1FV?=
 =?utf-8?B?a09jWmJMSHFhcE5EZzh3VE9iS28wR1p0RFZ4d0YrQ1NKdEppMHpIZDJ5MWNO?=
 =?utf-8?B?cWVCWlpVMlR4amFhbkdpL0NLejJFUW9ydFlpMEpnTkVHcm50NExVZUNLeFRJ?=
 =?utf-8?B?M1JFYUxMTGxqYmJEYWNZZDgzdWJrbTdNSjlGTlFsZzgvK083MUZLQjlwRFkw?=
 =?utf-8?B?UUVQM3JKeUo4RE9lSm8rWWxIZHZaNnFMbExmOVB4R3ZmdENTU1Q5aTNTZE9F?=
 =?utf-8?B?bEczWFVqQm83amhnNnk4MnA2N2dSTHdLQWF2QUxiKzJjbG9QMTU0ODJkWXN5?=
 =?utf-8?B?b3R2RksxMWR5R2t0WmFVNG9XNzZUL0t5eVJLeThKRk1qaXVhamV6NmhacnpM?=
 =?utf-8?B?MU1TV2thVW9nUlQ5RFZiYmNzVEVoR3F3eHZKMWkvQmltYlErUXJMdWwzKzdD?=
 =?utf-8?B?KzM3ZnNNeE9kdFdvZWczWEFlaEdLT01kaHExT0dCektrL1ZrTzlFd3VqaU1T?=
 =?utf-8?B?Q2tnT3B5Y2x1S1lUVVNPRkZrZnVEMmlmWDJHQ3RqdW0wMS90N0FEMWhMNFRU?=
 =?utf-8?B?ZzhnZ3ZFT2pGNDQ5ZHhGUFpPcStOcVJBNGFEdjRvc3RPU2VtRHJYY2YyQ0N2?=
 =?utf-8?B?QXRzN1ZQN2FLOUxmVUVzR2xqYm5Gem93MFZYM05MdjFuKzZBOCt3YWN5ckdl?=
 =?utf-8?B?WmlUdWVDYzZ5RExiUFA4WGR2Q1lGTHhoNnBkalk4cXRzSUNheXhIK1JUenE0?=
 =?utf-8?B?WXZ1N3lFVUlEQTgzTHNvUHA2YWpiVVhZOVBsTTBaYjB0TGl2anFwOEE1S044?=
 =?utf-8?B?aVFCMGh2dmVhTUJqVWhObnlCcnNJUi9hcTZ3UUcrZ2VFR1ZMRWl0dnVtMkZ6?=
 =?utf-8?B?cVJCYjEveGdCTllPbldEY0g1NWp6citsRlZMbXdKWlBPbmozTTlRZngwWVFn?=
 =?utf-8?B?cXZxNDY4VW0zUmVXem5YV3pIRHNmSDhNeE5PVlhkbmtRWG8vVlNhVjdEU3ph?=
 =?utf-8?B?TG1ObjU3d2w0ZzFXMjBmb2RkRCtJUS91ckR1YTZEZFJ6R05VOUFSUmhJZHdT?=
 =?utf-8?B?OWQrbjNkZ1Y3Q0dzZUxvQWNKaHJFSnJkU3ExOFZMbCsxTFdKQ2o3QURYT1RZ?=
 =?utf-8?B?aHBzRHFJUDkrZS9FNUFZcjgrdTRFcmxWaHROcXhleDZUVnhSUFo2amphdE9w?=
 =?utf-8?B?K3JWRUNrQXZ3UmNyNlBKbWE2OUlONC9QV0U2N2RJQUgvL0FhZkd2MUN1ODBh?=
 =?utf-8?B?U0Y1U2tJQ3c3ejhhQkx0K0xYTUh6bHlra2lhVHA4UkpNYkQ3WVc1UysxQ2dX?=
 =?utf-8?B?cHNVUm1kc3V6eU9GVGlVQS9kMUVmbmhlVFNZV2pQWVNGQ0lIRGN4R09LRjJD?=
 =?utf-8?B?MC85ZUtQb2pTeWh3SUE4ZDBqakcrOVVzZDA3K1dPRkczT1ErRWtqTWU2KzRl?=
 =?utf-8?B?UFFDaSt4TU03WVdiZ1I0M0lBOUlMWVlxWnlMcFc4dlppOERlTmNqUndnNHg5?=
 =?utf-8?B?eWliWnVoZzNRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5461.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzlyZjVKcXZ0SVQyMlBXMXZUTDI4ZlZEWThRRU1sakN5Z29xeTVOYys4NWpv?=
 =?utf-8?B?UmF5Y3dSU0hhT3ZwNE52WjFHa0ZSdzhBdTloMWIzd2hPYnZwaDlYQ1cvRXE5?=
 =?utf-8?B?VFJXd1JYb1NYQVU5Q2lIeTNEaWxGeE15VkZCNnpudnAycWtzVHc1eDh0TWd6?=
 =?utf-8?B?Q0R0YmZ0Nzd5Z0JPRnBrSUFtVHJtVzJzSWtHMzA2TDZsUmY3UmdsUWNXVDlQ?=
 =?utf-8?B?VXdHT0dsZ1F3UUNGMUtaaUpFcDlCb1ZQU2FNdWN6ZUlnN0wrS1dQMmIvOEYv?=
 =?utf-8?B?Nk5xdWx4VXNKYjl1WkQvQWFhbFhtbndxc0lITGgyRFV5d1UzdWNEdkNDMGty?=
 =?utf-8?B?bnNwQWw4QVhERmF4K3dYT292Rko2S3ZNc0R0S1B1MzZldjNKQUY0d1J1aEJw?=
 =?utf-8?B?OFIyR25oQ2pPL1BWQ0RTNEhiRjNUN2x4ckNTVmZFM20raWVyV0xQeU1HaUR2?=
 =?utf-8?B?STNMRU1DbUwxaUlOZm4rbTZYdHZ3cUdPdHRNcm9aL1FBbk9LWFRqWnJEZFJH?=
 =?utf-8?B?VjY2dVpRSVRGMHVvcEMwY01SbitOQzdmb285N28yZzZTeTQ1SUFCN2ZaMG5l?=
 =?utf-8?B?YUJiVTQ4MUc2VGwwa0ErN2hUSUs2Unk5WFFEYjlyVmd1bE5RWEwxVjh4N1BN?=
 =?utf-8?B?UWEyMHNnVFV3YjNuSXdrYjNxUFlMRDZzV1hZbzFVZE8wZjJsU3Z3SXZzSmNs?=
 =?utf-8?B?ekhaMUFEZmd1L2ljSkdXdCtnMmlSaGR0T1dwUGlsM0pFU0R0L1BOdldlTG1a?=
 =?utf-8?B?NXRtVW9KcS9DL01jN2lyclJCVFQ0c0Y0ZVlURW5yZ1NsWTJzYzdhNFRKeko2?=
 =?utf-8?B?QUp4bGRleENTMnNodTB6VERZT09CMDZNT2lEaWVia0d4dk1Bem95eDF5djAx?=
 =?utf-8?B?YnJJY1BGek9PZFBOZW9hL0lIemtybEhQVDJ3N1dCODhHUWYwMHcyWVEzV2g4?=
 =?utf-8?B?b2RvZlZ6T01ielNTWDM2Q083a1FiK1dWRWIyQnA1dk5rUmFrVEI1bzUxUlFu?=
 =?utf-8?B?MnFNcitTZ0F5OUE1K2FNQjk2VGU2d2dWYTM0UkNTaUJjREF0ZTA1QUh1TDZB?=
 =?utf-8?B?aDVYV055NkJUcG8vakljam9weERkU2VjWUg0NXArNVBqNm5Fb05JbDBiUW9F?=
 =?utf-8?B?dUdXUUJ1OGNlZzRoOE5FcmE3MnEzTXUxUlhoTVNmaFN2NFBhT21iTnZCYzlR?=
 =?utf-8?B?bVJobTZoamF4d3Fxdmc2R3pBdWVKbnBFMFZ6KzRqYnNTYUZNRlVtd29GWXh3?=
 =?utf-8?B?M2VaWE9iRWFPTDU5Z2V6M0JTaC8xUEljMzgzZ3JQdHR5MVJWamtRZ3UxNnNt?=
 =?utf-8?B?UkhObXpTbFpKbklLYitRY2VYdjAwK1N4RHIvczJjaW5FcC9WYTRNSVJibE42?=
 =?utf-8?B?OGFhWXZoeHVzeG5VUHNIcHg4c3hZRHhzdmRTYmdkVmo0WXp5MTRnaEZ4eE5E?=
 =?utf-8?B?UEdSM3F4eTJOaDBOVkFucmh5c3ZVU21vRjFHbGsvN3U4UTRaZ0VEalNVdVB5?=
 =?utf-8?B?WFJPYm13elFjQm1hdk1KRzgvVkY4L2UvbVZTbDN1QnBodFVZcjVlaFI1TFNO?=
 =?utf-8?B?NVN5eDFkei9hT1cyUHMxVVhvYUxmM0hid1NZR0dFQkxvZXM4Qkp1aGlLeUZn?=
 =?utf-8?B?cERIUHc3VnlEckszbWJnVW1sZ3l4M0tPVC9Gc3hKVlVoRlpkSjVuS1cwbVRi?=
 =?utf-8?B?aERrQlE2SEZuMFR5Vm42YXUwcnIreVBHVWRxcmJGTG1PRG1xYzY3NFEvdGJv?=
 =?utf-8?B?eEFXbmg0ODhyS2hMK0pnSlBDWnhRZW4reXJQSzY5RnIvZnFMUHpWdzlkdVFB?=
 =?utf-8?B?OXlwc20yeWZGbldDWmlTekE1Vk4zRGR3aXlaUTJBRlVTWGxDUHF3QTFEbWYv?=
 =?utf-8?B?ejRkZ3BxV09RZStrb0hiNS8rSWF6ZkN0OU84QVNpTnVuLzVCWEVXS2doWVZN?=
 =?utf-8?B?NjcxdmZCdzVDYXNGUVZjc1RYN2M0WkIzNmlKa1JJZUI4cTU0a3BjQ0RPbm5u?=
 =?utf-8?B?MlE4djZ2QmpmUDYrYlVkeDYxVWQ4NlNaRHduL1hndE1QeGJiRlhMTnFvUmo2?=
 =?utf-8?B?ek95NjRGK1hIU0IyN3E0RUhPVUExOEo5N2VmdXRiU2orR0VOcER3TEMzdTkw?=
 =?utf-8?Q?RK18rWF2tSuEWDByZR9pmmxqn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5461.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc94a4e1-412c-40fa-f9a7-08ddb7f1bb78
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 16:18:21.6144 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: htshTwI+j8qFlpx2+U2RXA06/3DuxofsCWkzs+37Yx3elNGvRi6D0aH3bSP0+a0hvOUncdGfTrKv/zllEkm0+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8294
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVyaW4gSmFjb2IgPGpl
cmluamFjb2JrQGdtYWlsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBKdW5lIDMwLCAyMDI1IDc6NDQg
QU0NCj4gVG86IE1hdHRpYXMgUsO2bm5ibG9tIDxob2ZvcnNAbHlzYXRvci5saXUuc2U+DQo+IENj
OiBQYXRoYWssIFByYXZpbiA8cHJhdmluLnBhdGhha0BpbnRlbC5jb20+OyBkZXZAZHBkay5vcmc7
DQo+IGplcmluakBtYXJ2ZWxsLmNvbTsgQ2hlbiwgTWlrZSBYaW1pbmcgPG1pa2UueGltaW5nLmNo
ZW5AaW50ZWwuY29tPjsNCj4gUmljaGFyZHNvbiwgQnJ1Y2UgPGJydWNlLnJpY2hhcmRzb25AaW50
ZWwuY29tPjsgdGhvbWFzQG1vbmphbG9uLm5ldDsNCj4gTWFyY2hhbmQsIERhdmlkIDxkYXZpZC5t
YXJjaGFuZEByZWRoYXQuY29tPjsgbmlwdW4uZ3VwdGFAYW1kLmNvbTsNCj4gY2hlbmJveEBudmlk
aWEuY29tOyBTYXJrYXIsIFRpcnRoZW5kdSA8dGlydGhlbmR1LnNhcmthckBpbnRlbC5jb20+OyBQ
YXZhbg0KPiBOaWtoaWxlc2ggPHBiaGFnYXZhdHVsYUBtYXJ2ZWxsLmNvbT47IFNoaWppdGggVGhv
dHRvbg0KPiA8c3Rob3R0b25AbWFydmVsbC5jb20+OyBIZW1hbnQgQWdyYXdhbCA8aGVtYW50LmFn
cmF3YWxAbnhwLmNvbT47DQo+IFNhY2hpbiBTYXhlbmEgPHNhY2hpbi5zYXhlbmFAb3NzLm54cC5j
b20+OyBoYXJyeS5jaGFuZ0BpbnRlbC5jb207DQo+IE1hdHRpYXMgUsO2bm5ibG9tIDxtYXR0aWFz
LnJvbm5ibG9tQGVyaWNzc29uLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gZXZlbnQv
ZGxiMjogYWRkIGRlcXVldWUgaW50ZXJydXB0IG1vZGUgc3VwcG9ydA0KPiANCj4gT24gTW9uLCBK
dW4gMzAsIDIwMjUgYXQgNDo0N+KAr1BNIE1hdHRpYXMgUsO2bm5ibG9tIDxob2ZvcnNAbHlzYXRv
ci5saXUuc2U+DQo+IHdyb3RlOg0KPiA+DQo+ID4gT24gMjAyNS0wNi0zMCAxMToxOSwgSmVyaW4g
SmFjb2Igd3JvdGU6DQo+ID4gPiBPbiBTYXQsIEp1biAyOCwgMjAyNSBhdCAxMToxN+KAr0FNIFBy
YXZpbiBQYXRoYWsNCj4gPHByYXZpbi5wYXRoYWtAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+Pg0K
PiA+ID4+IERMQjIgcG9ydCBpbnRlcnJ1cHQgaXMgaW1wbGVtZW50ZWQgdXNpbmcgRFBESyBpbnRl
cnJ1cHQgZnJhbWV3b3JrLg0KPiA+ID4+IFRoaXMgYWxsb3dzIGV2ZW50ZGV2IGRlcXVldWUgQVBJ
IHRvIHNsZWVwIHdoZW4gdGhlIHBvcnQgcXVldWUgaXMNCj4gPiA+PiBlbXB0eSBhbmQgZ2V0cyB3
YWtldXAgd2hlbiBldmVudCBhcnJpdmVzIGF0IHRoZSBwb3J0LiBQb3J0IGRlcXVldWUNCj4gPiA+
PiBtb2RlIGlzIGNvbmZpZ3VyZWQgdXNpbmcgZGV2YXJncyBhcmd1bWVudCBwb3J0X2RlcXVldWVf
d2FpdC4NCj4gPiA+PiBTdXBwb3J0ZWQgbW9kZXMgYXJlIHBvbGxpbmcgYW5kIGludGVycnVwdC4g
RGVmYXVsdCBtb2RlIGlzIHBvbGxpbmcuDQo+ID4gPj4gVGhpcyBjb21taXQgYWxzbyBhZGRzIGNv
ZGUgdG8gaGFuZGxlIGRldmljZSBlcnJvciBpbnRlcnJ1cHRzIGFuZA0KPiA+ID4+IHByaW50IGFs
YXJtIGRldGFpbHMuDQo+ID4gPj4NCj4gPiA+PiBTaWduZWQtb2ZmLWJ5OiBQcmF2aW4gUGF0aGFr
IDxwcmF2aW4ucGF0aGFrQGludGVsLmNvbT4NCj4gPiA+PiBTaWduZWQtb2ZmLWJ5OiBUaXJ0aGVu
ZHUgU2Fya2FyIDx0aXJ0aGVuZHUuc2Fya2FyQGludGVsLmNvbT4NCj4gPiA+PiAtLS0NCj4gPiA+
PiAgIGRvYy9ndWlkZXMvZXZlbnRkZXZzL2RsYjIucnN0ICAgICAgICAgICAgICB8ICAyMCArDQo+
ID4gPj4gICBkcml2ZXJzL2V2ZW50L2RsYjIvZGxiMi5jICAgICAgICAgICAgICAgICAgfCAyMzYg
KysrKystDQo+ID4gPj4gICBkcml2ZXJzL2V2ZW50L2RsYjIvZGxiMl9pZmFjZS5jICAgICAgICAg
ICAgfCAgIDcgKw0KPiA+ID4+ICAgZHJpdmVycy9ldmVudC9kbGIyL2RsYjJfaWZhY2UuaCAgICAg
ICAgICAgIHwgICA4ICsNCj4gPiA+PiAgIGRyaXZlcnMvZXZlbnQvZGxiMi9kbGIyX3ByaXYuaCAg
ICAgICAgICAgICB8ICAxOCArDQo+ID4gPj4gICBkcml2ZXJzL2V2ZW50L2RsYjIvZGxiMl91c2Vy
LmggICAgICAgICAgICAgfCAxMTIgKysrDQo+ID4gPj4gICBkcml2ZXJzL2V2ZW50L2RsYjIvcGYv
YmFzZS9kbGIyX2h3X3R5cGVzLmggfCAgNzAgKysNCj4gPiA+PiAgIGRyaXZlcnMvZXZlbnQvZGxi
Mi9wZi9iYXNlL2RsYjJfb3NkZXAuaCAgICB8ICA0NiArKw0KPiA+ID4+ICAgZHJpdmVycy9ldmVu
dC9kbGIyL3BmL2Jhc2UvZGxiMl9yZWdzLmggICAgIHwgMTQ5ICsrKy0NCj4gPiA+PiAgIGRyaXZl
cnMvZXZlbnQvZGxiMi9wZi9iYXNlL2RsYjJfcmVzb3VyY2UuYyB8IDgyNQ0KPiArKysrKysrKysr
KysrKysrKysrKysNCj4gPiA+PiAgIGRyaXZlcnMvZXZlbnQvZGxiMi9wZi9iYXNlL2RsYjJfcmVz
b3VyY2UuaCB8ICAgNiArDQo+ID4gPj4gICBkcml2ZXJzL2V2ZW50L2RsYjIvcGYvZGxiMl9wZi5j
ICAgICAgICAgICAgfCAyMjMgKysrKysrDQo+ID4gPj4gICAxMiBmaWxlcyBjaGFuZ2VkLCAxNzEx
IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+ID4gPj4NCj4gPiA+PiBkaWZmIC0tZ2l0
IGEvZG9jL2d1aWRlcy9ldmVudGRldnMvZGxiMi5yc3QNCj4gPiA+PiBiL2RvYy9ndWlkZXMvZXZl
bnRkZXZzL2RsYjIucnN0IGluZGV4IDhlYzcxNjhmMjAuLmE0YmE4NTczNTENCj4gMTAwNjQ0DQo+
ID4gPj4gLS0tIGEvZG9jL2d1aWRlcy9ldmVudGRldnMvZGxiMi5yc3QNCj4gPiA+PiArKysgYi9k
b2MvZ3VpZGVzL2V2ZW50ZGV2cy9kbGIyLnJzdA0KPiA+ID4+IEBAIC00NzcsNiArNDc3LDI2IEBA
IEV4YW1wbGUgY29tbWFuZCB0byB1c2UgYXMgbWVzb24gb3B0aW9uIGZvcg0KPiBjcmVkaXQgaGFu
ZGxpbmc6DQo+ID4gPj4NCj4gPiA+PiAgICAgICAgICBtZXNvbiBjb25maWd1cmUgLURjX2FyZ3M9
Jy1ERExCX1NXX0NSRURJVFNfQ0hFQ0tTPTAgLQ0KPiBERExCX0hXX0NSRURJVFNfQ0hFQ0tTPTEn
DQo+ID4gPj4NCj4gPiA+PiArSW50ZXJydXB0IE1vZGUgU3VwcG9ydA0KPiA+ID4+ICt+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+DQo+ID4gPj4gK0RMQiBkZXF1ZXVlIHN1cHBvcnRzIGludGVycnVwdCBt
b2RlIGZvciB0aGUgQVBJDQo+IHJ0ZV9ldmVudF9kZXF1ZXVlX2J1cnN0KCkuDQo+ID4gPj4gK1Ro
ZSBkZWZhdWx0IHBvcnQgZGVxdWV1ZSBtb2RlIGlzIHBvbGxpbmcuIERlcXVldWUgd2FpdCBtb2Rl
IGNhbiBiZQ0KPiA+ID4+ICtjb25maWd1cmVkIG9uIHBlciBldmVudGRldiBwb3J0IGJhc2lzIHVz
aW5nIGRldmFyZ3MgYXJndW1lbnQNCj4gPiA+PiArJ3BvcnRfZGVxdWV1ZV93YWl0Jy4gSW4gaW50
ZXJydXB0IG1vZGUsIGlmIHRoZSBwb3J0IHF1ZXVlIGlzDQo+ID4gPj4gK2VtcHR5LCB0aGUgYXBw
bGljYXRpb24gdGhyZWFkIHdpbGwgYmxvY2sgb24gdGhlIGludGVycnVwdCB1bnRpbCBhDQo+ID4g
Pj4gK25ldyBldmVudCBhcnJpdmVzLiBJdCBlbnRlcnMgYmxvY2tpbmcgbW9kZSBvbmx5IGFmdGVy
IGFueQ0KPiA+ID4+ICtzcGVjaWZpZWQgdGltZW91dC4gRHVyaW5nIHRoZSB0aW1lb3V0LCBpdCB3
aWxsIHBvbGwgdGhlIHBvcnQgcXVldWUgZm9yDQo+IGV2ZW50cyBhcyB1c3VhbC4gSW50ZXJydXB0
IG1vZGUgdXNlcyB0aGUgRFBESyBpbnRlcnJ1cHQgc3VwcG9ydCBmcmFtZXdvcmsuDQo+ID4gPj4g
Kw0KPiA+ID4+ICsgICAgLi4gY29kZS1ibG9jazo6IGNvbnNvbGUNCj4gPiA+PiArDQo+ID4gPj4g
KyAgICAgICAtLWFsbG93IGVhOjAwLjAscG9ydF9kZXF1ZXVlX3dhaXQ9YWxsOmludGVycnVwdA0K
PiA+ID4NCj4gPiA+IEFkZGluZyBvdGhlciBldmVudGRldiBQTUQgbWFpbmF0YWluZXJzLg0KPiA+
ID4NCj4gPiA+IExvb2tzIGxpa2UgaXQgY2FuIGJlIGEgZ2VuZXJpYyBmZWF0dXJlLiBpLmUgc2V0
IHRoaXMgb3B0aW9uIGlzDQo+ID4gPiBkZXZfY29uZmlndXJlKCkgSWYgdGhlcmUgaXMgbm8gb2Jq
ZWN0aW9uLCBQbGVhc2Ugc2VuZCBhIG5ldyBwYXRjaCBhcm91bmQNCj4gdGhhdC4NCj4gPg0KPiA+
IEkndmUgY29uc2lkZXJlZCBpbXBsZW1lbnRpbmcgdGhpcyBpbiBEU1csIGFsdGhvdWdoIGluIGEg
ZGlmZmVyZW50DQo+ID4gbWFubmVyICh3aXRoIGV2ZW50ZmRzIGFuZCBwb2xsKCkpLg0KPiA+DQo+
ID4gVGhlIGRlcXVldWUgdGltZW91dCB3aWxsIHN0aWxsIGJlIGhvbm9yZWQgaW4gImludGVycnVw
dCBtb2RlIiwgY29ycmVjdD8NCj4gPiBJdCB3YXNuJ3Qgb2J2aW91cyBmcm9tIHRoZSBkZXNjcmlw
dGlvbi4NCj4gDQo+IEhvdyBpcyBpdCBpbiBJbnRlbCBQTUQ/DQoNCkl0IHdvdWxkIGJlIGJlc3Qg
aWYgd2XCoGNvbmZpZ3VyZSBpdCBwZXIgcG9ydCB1c2luZyBSVEVfRVZFTlRfUE9SVF9DRkdfKiBm
bGFncy4gV2lsbCBpdCBiZSwgT0s/DQpUaGUgZGVxdWV1ZSB0aW1lb3V0IHdpbGwgYmUgaG9ub3Jl
ZCwgYW5kIHRoZcKgZGVjaXNpb24gdG8gYmxvY2sgb3IgcmV0dXJuIHdpbGwgYmUgbWFkZSBhZnRl
ciB0aGUgdGltZW91dC4NCklmIG5vdCBpbnRlcnJ1cHQsIGl0IGNhbiBiZSBjYWxsZWQgYmxvY2tp
bmcgdnMgcG9sbGluZyBtb2RlLiAgSWYgdGhlIHBvcnQgY29uZmlnIGlzIGZpbmUsIEkgd2lsbCBj
cmVhdGUgYcKgbmV3IHBhdGNoIHdpdGggaXQuDQpBbHNvLCB3ZSBzaG91bGQgaGF2ZSB0aGlzIGFz
IGHCoGNhcGFiaWxpdHkgZm9yIGV2ZW50ZGV2cy4NCg0KPiANCj4gPg0KPiA+IFdoYXQncyBiZWlu
ZyBjb25maWd1cmVkIHNob3VsZCBqdXN0IGJlIGEgdGhyZXNob2xkIHRpbWUgYXQgd2hpY2ggdGhl
DQo+ID4gZXZlbnQgZGV2aWNlIHdvdWxkIGdvIGZyb20gYnVzeS1wb2xsaW5nIHRvIGJsb2NraW5n
IHRoZSB0aHJlYWQuDQo+ID4NCj4gPiBNYXliZSBpdCBzaG91bGQgYmUgY2FsbGVkIHNvbWV0aGlu
ZyB3aXRoICJibG9ja2luZyIgb3IgInNsZWVwaW5nIiwNCj4gPiBpbnN0ZWFkIG9mICJpbnRlcnJ1
cHQiLCBzaW5jZSBpbnRlcnJ1cHRzIGFyZSBuZXZlciBkaXJlY3RseSBpbnZvbHZlZC4NCj4gDQo+
IEFncmVlLiBvciBtYWtlIGl0IGEgcG93ZXIgc2F2ZSBtb2RlIG9yIHNvLg0KPiANCj4gPg0KPiA+
IEFueXdheSwgc2VlbXMgbGlrZSBhIGdvb2QgY2FuZGlkYXRlIGZvciBhIGdlbmVyaWMgZmVhdHVy
ZSB0byBtZS4NCj4gPg0K
