Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B5FC282C5
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 13:54:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7F6F40E32;
	Fri, 28 Feb 2025 14:54:05 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2C06A40609;
 Fri, 28 Feb 2025 14:54:04 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SBUIxZ006484;
 Fri, 28 Feb 2025 05:54:03 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4537rcgmxr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Feb 2025 05:54:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtUIbytu9fa30ksKYJ9+w7Ca9Nk/TPVq40czDhIaTXhKIdnR9KRaysS83/1nUV64B/UaAkknKyP4QzPO9V5cf9kHEaBEgG5REiJdwhr/fu+agrFlNyMoCJmed0JfWocYGR3zM3pi2TWDj48osup6kawwMvDtIcgRhXskKy3NeK3iL/OKgcB0HhsBbh/wo6ROljTKDk1TPBX9/uX6sQcMqKK+p6vaxVZJTUt8psbaiNbp+Cheg/Mbve/TSFzAyNYnpnoSiN4rEYMfw2iUjAj+fDxvygDixHgrSdmbjGfWf+Jt6lwSsyCRPLh+r5Dks9Rh4Yj3Q8iyBYqGmnUIp3Qcvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teFtQgC8JgsUCE6iq9pePgkpP2jVzAx6htCaxBtKiC0=;
 b=lkbAjgeLCKQomVesawALkaV5rz+hCIBRpvkNjGUPKZcUSh5JBGtfTvAoDj/U27ik/ubHAhpY6Bl47UO+8KYturm6VirzjWJTCE8gew4kgdYaIFB61Ppc4qnP9JkvHF/6b33FNgU56kyWQVAFqrKL4ovcPYhSMC7YQJcwSe6N2tgGtXx03CH3fMbzYiqTtZP8N28NfJ2Wu4JIgDE45uCJTRsbCR1QBBwam+VDiw2mwkXIk09BfjTSQjQ1Gra9qHFwmghS/iju1SwFRt0pLqHAZlUK3bJKJn+vcoQr+qNlnxSQFBjn8fV42R58UqDPaSKr2JtgyPla+0TdQKF13RtFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teFtQgC8JgsUCE6iq9pePgkpP2jVzAx6htCaxBtKiC0=;
 b=mfiajOH0XliSktFgDoBqzoJorReT4JEJEFpTEhfkx9HmJS22hKdh9uOsJqPTaHyCOX+SqokcvW9sbNqXXbaE5X6XKtJOpXpVW69NYwZnactnW8DC3Hz4WZsWPvv8xbBkvwFkvbFvC3tkWjiyn1YO3a/9889/lI6fXN1PRqzXLbo=
Received: from CO1PR18MB4714.namprd18.prod.outlook.com (2603:10b6:303:e9::18)
 by SN7PR18MB4047.namprd18.prod.outlook.com (2603:10b6:806:100::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 13:53:59 +0000
Received: from CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::26fb:729e:a947:3e06]) by CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::26fb:729e:a947:3e06%7]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 13:53:59 +0000
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: David Marchand <david.marchand@redhat.com>
CC: Maxime Coquelin <maxime.coquelin@redhat.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Chenbo Xia <chenbox@nvidia.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Jay Zhou <jianjay.zhou@huawei.com>, Anoob Joseph
 <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [EXTERNAL] Re: [v6 1/5] vhost: skip crypto op fetch before vring
 init
Thread-Topic: [EXTERNAL] Re: [v6 1/5] vhost: skip crypto op fetch before vring
 init
Thread-Index: AQHbiH6FA1dexCVgyUmrLiQ9SxTU/LNa32UAgAAA7wCAAD+IoIAASj/ggAD/9oCAAFQr8A==
Date: Fri, 28 Feb 2025 13:53:59 +0000
Message-ID: <CO1PR18MB47149ED167A626A1159F9515CBCC2@CO1PR18MB4714.namprd18.prod.outlook.com>
References: <cover.1740594750.git.gmuthukrishn@marvell.com>
 <0784f44b63f6161ac8716644acfea979704eca39.1740594750.git.gmuthukrishn@marvell.com>
 <81fac570-cdd7-45f7-b209-ce999d5c3d0e@redhat.com>
 <de649087-3686-4372-a1ac-d9a05961b6c0@redhat.com>
 <BY3PR18MB47054AE703CEB9AA6812A7C9CBCD2@BY3PR18MB4705.namprd18.prod.outlook.com>
 <BY3PR18MB470536F2A1329EE6732E332CCBCD2@BY3PR18MB4705.namprd18.prod.outlook.com>
 <CAJFAV8zDrLGrjk2F5EXqzGJUytQdnFnv5b1y5xr01TfYj0dRLA@mail.gmail.com>
In-Reply-To: <CAJFAV8zDrLGrjk2F5EXqzGJUytQdnFnv5b1y5xr01TfYj0dRLA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4714:EE_|SN7PR18MB4047:EE_
x-ms-office365-filtering-correlation-id: b88f0f36-2063-418f-8788-08dd57ff59d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?LzRObHovN2Q0bGI5T252bGRyRmVMT3lKS0x5c3VqSmkvS1dtY3NNTkxrZlY0?=
 =?utf-8?B?dzVHVlJHaVdlNThyMi9SbG96NEZSaFdqME9XaFpXb2Z4b3hyenVvZkxxSSt1?=
 =?utf-8?B?Vm80Zi9zbzZyV2dlZFdmSWNsWjJWQlRtM09wL0NMeFpUMkVjOERhaWhxYUtW?=
 =?utf-8?B?S013UmVhMGpnUEJld29BbVlSbzMwUkV0WEFHb2xjUDVtckovNGgzd3NmUjJn?=
 =?utf-8?B?RHlzcGxYMnpNSE1iREFQMnViTW91clo5dEdKT1hHVmUyaEtuWjJwcVJOUE5S?=
 =?utf-8?B?bXJ0VVhGV3dpUWRBbmlKNEM1dWVINVNwRnpUTVkveHcyTlRuRlBwOXBDZURx?=
 =?utf-8?B?YWpLNm1UYzJpZHltWHpsOWpIaXF3WTN5UnJoQjV5eWtiY0JsLzA5dkZyeXhp?=
 =?utf-8?B?VTJJcitSWVIwLzdFVkZiL1lUcnRjaCt1VVJZYXpiOHlaWmVMN0VOM3FvZFFo?=
 =?utf-8?B?TFloUkNUUE91Qis1ZHZ5QkkvNy9kcEozbDZDTDE1ZjdGbG9FMmtQYTBOVkNu?=
 =?utf-8?B?STdIWGFTdjJjd0g1TUswb3NiMjFsemxjTmdBazdwUU9MN3V0UXpraW1Cdzd5?=
 =?utf-8?B?ZWRRUiswTVFxdk1vcWZpT2Q5c3F0WGh3SWF3cFhMWEZ0UlVnZUI3ZEpEVkRE?=
 =?utf-8?B?L2paMGdwZWNUcnN1bVc0UTliTkdOZ1RqRWE4VVprUXNaQXBCK0dubHAzTjRq?=
 =?utf-8?B?MTVLbkV1WEJyOGE1cHFHRC9iQlV6bkNNbEpYVVhhbEQ0d0NuQ09nQUpPTnNE?=
 =?utf-8?B?dnAxQ0NObHZtOW4rcmlJbU9hS3VseStGajhyUlVqcWozMEVNTXVBSktyWnNC?=
 =?utf-8?B?VWQ0ZkxTcWZPOGttMzNFV09lbjIyWjhLRVVobkRnL284NDRha3lnaEJxd1lZ?=
 =?utf-8?B?UnhINTFTZTN2S3dIYjVudmRMRlVIeGZUd0pzbURmc0FvVmlvRlRJanpwQmxo?=
 =?utf-8?B?aHVTVFNod3J5S0ZoemxmeFNQQ1NaR25ML21mWDcxdzdOWVZaUlkvSEZ1bDRh?=
 =?utf-8?B?c0xFZ3JKN1hTZ0R6b0lXR1VHM2NLMGJQQkNLTllrdDlwRzN2Z3ZveVRkeGdi?=
 =?utf-8?B?V2RpUkNKbUZLMzVkZEVYM2s5R2tTclRUc3M2aGV6RWJiR0RTQWowWFZHNmlM?=
 =?utf-8?B?aUZFWk52R0ZMUVVObmthd3hqZURtcXFtRC92bVZTTGZRcjNrQ2p6Rmx4ajZn?=
 =?utf-8?B?TTEwcDVtRXFNc2gxTW9GVHVXTDZDdW1HUUM3VE9MTDdrRWhXK1diRXhxQWU1?=
 =?utf-8?B?MEZjeFJYSmw1Q010enBNRFUzM05LcjV6cFkwYVdxYTA5bTdwSndjUUVaMTlT?=
 =?utf-8?B?UExpWS9RcnZZaTNUQUFIL2N4djczOUNSTElnaGp2b1dPVjJNNkVBbE9nR0V2?=
 =?utf-8?B?R210ZVlLM2RaZ282TWxtdzRPUlhhWXBWTHF1Qlh4OU5LSHJmVXJRZE5tNmY2?=
 =?utf-8?B?SU9lNHpOL2YydWtFbTlKbDhpcEIrc04xZ0dwejc2R2lpeFUrQitOTjVQek1k?=
 =?utf-8?B?bS9ueHBaWElITHplWjE0ZFlLNVJYb0NvNzNjbWFjdEhaZTl0NWNSRXMwdlJN?=
 =?utf-8?B?SVJxZGJzSysrRnJsRHFKTE5BSUozM0pHVEJoUkovVFhYQk8yaGRQdEZKYXFh?=
 =?utf-8?B?NlZCNDlZNzhQZ2NHMjZPN01Cemh3byt0a1JxUDFBVUEwV2RrLytZKzl4TUVO?=
 =?utf-8?B?ZTNBMUVjQnFmYlNuNkJ2ZE4vTzBaMWc1bWJiNU9hVlFwQWxiZGV6QUh1UmxS?=
 =?utf-8?B?WnVPN3dvTWJSWVRLdnlhZFVwVWx6dUpGS1RpcDBxRFNlczRVSVBJaG44eE55?=
 =?utf-8?B?dFhXcWROUGhVNTVzOFRqajFaazl1TjBjWlBFRC8wcytwYlVaQjVXS0M3Qndj?=
 =?utf-8?B?dVYrQTR3ZElaYU5qWldEU2ljZUhlZHZGVStPS0NseUlubitEazBqSXZzRzJR?=
 =?utf-8?Q?VJvb6FyDnPBBs/Gpg4kMRhBeWuzg+pPS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR18MB4714.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWI1WG1NQ216Q05OenNkL1VUUnJjUmtuQXFLdEtVYWlhSzJEaEpsancveXFB?=
 =?utf-8?B?TEpIem5hck5lR3pLSmNTcW9DNlRodWZra1NGMk9Tc014ckQzV3ZzU256bTZY?=
 =?utf-8?B?aUovRit0akgwZWpPSXF5NmcwNW9mWkdHdUpldEdia0E5cHVNMG1QTlI3N3Jt?=
 =?utf-8?B?TmF2ZEk0ZXc0VjBzeitDUFBNNTVvaVV5dTBPSE5WcFNSSWRYQTl5UElkZERT?=
 =?utf-8?B?L2E0ZkIxM2luZTVKcklKbjFTU0pkNkRIOW1KQXZxQTBES0xEemFJYlRuUENo?=
 =?utf-8?B?aDg0YVhXNllDdmZ0K0ZZL1Z4a3h3UTdZVCtoVFdaN2ZQUlRJYnhqQ1BVQVpI?=
 =?utf-8?B?K04yeWkzZ2RjUHJ6MHNjMlRFQlBIT0xmT0M3b1B1Sjl1UEhJZysrUittZEIy?=
 =?utf-8?B?dUVwdGFNbEhQcWxvN2d3bThRV1ZCYk1ZQ2hvLzNjM1lHR1pTOGpUUTRhRTlw?=
 =?utf-8?B?TS8wcHVHYmhtRXVVbS9yL2xjNWdGaEVhd3R0bDNGZHJIVHE1NzBoaDdyeEE5?=
 =?utf-8?B?emp5OFUxY1JBN3haZDFzbHVmbXVRVnVhanNEeC9KSElpVDl6bm5GM0U5b2pE?=
 =?utf-8?B?aENiTEw1b0pSQXg3ZE82ejdRbzl3ZVNPYlpoK3lkMlRRSUZqT2ZmdTVFclYz?=
 =?utf-8?B?K1BDWFVQSWRjWjlqSEZML0RGUTMyZ2ZjTUZ0TUFObFViOXlvR09rVzVDR3oy?=
 =?utf-8?B?WHZ6ait1R3QyOWt6UElVMjNNK3FrMUVkT2JqODZVRUxGZ0tad2hiOHgxWlRh?=
 =?utf-8?B?R2tobi9PQ1c4UDZsSjd1VThmNmNPMzFQN2R4bmxlRjhBVzNGTlpjaldxNlUv?=
 =?utf-8?B?SW0zem94L1pUM0o4c2JFOXBqQVIyR1lURHc0eHNXOWlWblVFbTl2Y1ZPOW5L?=
 =?utf-8?B?K0daSDVvRE81VTJyWm0zY1lOWjJ5VU44OExkVEFaVW1ucncwblVOQzVZUVRU?=
 =?utf-8?B?bFR4SHVmaTFCQjYxdTJjaHdWUjBxRG5pR1R1b2laUkFWL3pJRDQ4M2FTa2Mx?=
 =?utf-8?B?OHBnSFBGM29zVDFjNDd6Rzd4eW5Za0k1VUhDZ0FXTlhiV1RjclVEL0VYakth?=
 =?utf-8?B?SUc4WFdKM0JLTnRnc0tTT0hJUm5EZ0FSZWJ5aGFoZm1ZQTFENFp5YkpqZ3cz?=
 =?utf-8?B?dnloeWtxV0RpeUV3ZDlKdWFidHZOWlpGcWgydVJVYUpVSkp1dGJWM2c5ZHA1?=
 =?utf-8?B?TU5lT0dMS296WjF5ZzB5TnptN3FlYVQ4WGF5U0FPVmkxRUZlNlZheWt4QWRZ?=
 =?utf-8?B?emdScUluczJJdis5WURTazd3Nkc0NFFTczA3dVl1NktYWW5XNjVQcFJYYkpp?=
 =?utf-8?B?VHhadHRZbjQxdjJSOTYzSisrb20vU214L0tHdlNYaGdGZVB1OWw2WXFUclRU?=
 =?utf-8?B?enJPVE9SU2JHcG9lRlI1dW1EUG9xUXYxNjVxUEZ6REhHUUFDVGswRVNCRjV2?=
 =?utf-8?B?SWtKLzZ4QVgrbW1xNTd1MVhYSy9MUk40andxaklmQllZK3hIQ1F1MkZXQ1cz?=
 =?utf-8?B?cTYrQkJjdGd5YmlRRWV0cGJoVXM1SGZaU0pRbDVsQkFzaXVkQ080aHFOTXBS?=
 =?utf-8?B?ZlhUZEE2WFpCa1FxQXRjMXNuOHJvSmJKVmVIcEREMjhUVUhYMnpXSGFDcStn?=
 =?utf-8?B?czlsVHI1QVF0Z3d4ZThtbC9obDhBeDkydVJwR2ErQkgwaGVjQWNFbElSV1JM?=
 =?utf-8?B?WWVZcjVwT0VaZjhKblFTb3JOTllVZDVTcGhTR24wMGd5T2Jlb3lWNk9xUUtL?=
 =?utf-8?B?bm9wTDhKMzZyT2sxdm5tZnhOQnc2RldUMWk3RFJrNjFrSC9TTWxTaUhTUm9q?=
 =?utf-8?B?SGZqS1F6dmRGR1BzQStBVXlCVHZSMXFjZmZlanRhZDI0Vi85bzNSckJMU05Z?=
 =?utf-8?B?bWg1WW9qMjFtTUlRTUlyMERsNkhiWG5YUzhWbFF3d3FmQ094eUxVdmJ0SGZK?=
 =?utf-8?B?dDV5VnlEME5YRnBkbU42cmRCMHdObkx6UzhLTjZHNlBoRlVjU3c1cDEzUEVh?=
 =?utf-8?B?QVc0WDdLazk5ek5DTGRoaVRvZkEvN00xWE01K2JCU09tc0tZbWUxVG5ZaUdP?=
 =?utf-8?B?QXBaemIyMExUQ1lZTzUzdU1KMjh6dFVOUUN1a1hpU2JqYnJ6NlFXVk1BVWRO?=
 =?utf-8?Q?tQoppcN+/slWFhSgcwMgFoOax?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4714.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88f0f36-2063-418f-8788-08dd57ff59d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 13:53:59.1855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rdEBka4rS3FyN4H9iwniABFKYSThOTFDtUnqFUKfpxocwswE4FfgltNqxZfRS7ZW9YeY6lFz7RPARz6lNiWcgF7AIhJffY6KdbMQJyEAgl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB4047
X-Proofpoint-GUID: nYay3eUIaASGVroZxMPz4gl-_q1P4ikJ
X-Proofpoint-ORIG-GUID: nYay3eUIaASGVroZxMPz4gl-_q1P4ikJ
X-Authority-Analysis: v=2.4 cv=GcvtnRXL c=1 sm=1 tr=0 ts=67c1bffb cx=c_pps
 a=+hq7TYb7Jqj0EztKBnUMzg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=-AAbraWEqlQA:10 a=NNTqsqtgUHVgKveqYuMA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_03,2025-02-27_01,2024-11-22_01
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

SGkgRGF2aWQsDQo+ID4NCj4gPiBJdCBpcyBkdWUgdG8gbG9jYWwgdmNfcmVxIHRoYXQgaXMgcGFz
c2VkIHRvIGZ1bmMgdGhhdCByZXF1aXJlcyBpb3RsYg0KPiA+IGxvY2sgSW4gdmNfcmVxLT52cS4g
RXZlbiB0aG91Z2ggdmNfcmVxLT52cSBpcyBsb2NrZWQgdnEsIEdDQyBkb2VzIG5vdCBhbGxvdyBp
dCwNCj4gYXMgSSB1bmRlcnN0YW5kLg0KPiANCj4gKmNvdWdoKiBjbGFuZy4NCj4gDQo+ID4NCj4g
PiAgICAgICAgIHZjX3JlcSA9ICZkYXRhX3JlcTsNCj4gPiAgICAgICAgIHZjX3JlcS0+ZGVzY19p
ZHggPSBkZXNjX2lkeDsNCj4gPiAgICAgICAgIHZjX3JlcS0+ZGV2ID0gdmNyeXB0by0+ZGV2Ow0K
PiA+ICAgICAgICAgdmNfcmVxLT52cSA9IHZxOw0KPiANCj4gVGhlIGFubm90YXRpb25zIHdvbid0
IGhhbmRsZSB0aGlzIHdyYXBwaW5nIGluIHRoZSB2Y19yZXEgb2JqZWN0Lg0KPiBKdXN0IHBhc3Mg
YSB2cSBvYmplY3QgcmF0aGVyIHRoYW4gdGhlIHZjX3JlcSAod2hpY2ggSSBkb24ndCBzZWUgbGl0
dGxlIHBvaW50IGluIGhhdmluZw0KPiBpbiB0aGUgZmlyc3QgcGxhY2UuLikgYW5kIGFkanVzdCBh
bm5vdGF0aW9ucy4NCj4gDQoNClllcyBJIHRob3VnaHQgYWJvdXQgaXQgaW5pdGlhbGx5LCBidXQg
dGhlbiBJIGhhZCB0aG91Z2h0IHZob3N0X2NyeXB0b19wcm9jZXNzX29uZV9yZXEoKSBpcyBvbmx5
IHN0YXRpYyBhbmQgY2FsbGVkIHdpdGggbG9ja3MgaGVsZC4NCkFueXdheSwgSSBoYXZlIGNvbWUg
dXAgd2l0aCBvbmUgYWRkaXRpb25hbCBwYXRjaCBpbiBzZXJpZXMgdG8gZml4IGl0IHNwZWNpZmlj
YWxseS4NCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQpSZWdhcmRzLA0KR293cmlzaGFu
a2FyDQo+IA0KPiAtLQ0KPiBEYXZpZCBNYXJjaGFuZA0KDQo=
