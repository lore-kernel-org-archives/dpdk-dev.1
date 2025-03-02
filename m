Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446D1C19F32
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Mar 2025 20:31:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D0F1402E2;
	Sun,  2 Mar 2025 21:31:51 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C57E740041
 for <dev@dpdk.org>; Sun,  2 Mar 2025 21:31:50 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522JqolU022098;
 Sun, 2 Mar 2025 12:31:50 -0800
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 454kvegscc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 02 Mar 2025 12:31:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2rUyUgmJjCtpxbNdwn8OZvZNBnihxgmkp2LPp46CeP74cZM71ZbFq7w+N3ASOFQq0BvEDLv/I9hYYzcGZyJb3y0BGLc0CRIO9OjTJGIeCtBYPeFhzDYcHNjFMb/MutGXNn7jx3EDHW3L4VrZ4P9cEHb0XTbilj9h0IBf5sdwQxUQMO10p60qV2sDdY9yAp+QF6VhfhuBzToqfx8ewynS9l7zQZpZ4QJ6miEXoh9GuS8Hz4Kkz38sfQCgO77JlEtPIdVqqtPGc09hfQY3KL8A0nUR434gYiqg62t1xvYOjzgz7mnYcsMbvyqLH+IXr69+iyyowD2w/a870LpXXS0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuSRIDWCPu3Zx17nWDbO0T0WN7+sigHExfFQiVfFJX4=;
 b=YJ94A7hN52b1oHUu5NJCSL0NT966EM4jFQPvj0T4zKOMQAiALChqYi/gbSO3jmaU0If6A6J0hGGXHpFb16acKwcMDrWJf5UMfAOrsiqpAIcOXp6OI+5a1I7o56j4HOsP8Wnq06a0rPDO9iD+gm0pRJCOyOhRp/XLWjh5fZFKC1DVz+unn2JdBh9IGkLb3ZHkeLEClwjGXjBXaxPQxPFgKeZ6SZ1q97wc8axYQPr79Oq6SK3Vb5DN9Bv/4LdWU27bdkTWx+kIBg+ZJNLgZ58wnNuegZUGC3TGMlA1XQ/DHyjG2yB7Z9/fTOKh5g0E1rLYcZmZunmY5nUVvuhloQXm6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuSRIDWCPu3Zx17nWDbO0T0WN7+sigHExfFQiVfFJX4=;
 b=n/9qXz6DNyGy79kELbjt5WeMHJmNThUaoa0kz3Yv/7GQuFOP5J/YIr4GR1gEnjGXMZE9CkgHuKDaTxoUW0Qoogunz6VqOidco944jOVewzDQ6BDr5LU+Q5Wn7wXSIt0jGz7epWorFkwFVuRlZcJtXVv60ZjhDm7wL11d/D0pT8A=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM4PR18MB5525.namprd18.prod.outlook.com (2603:10b6:8:17d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.25; Sun, 2 Mar 2025 20:31:48 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 20:31:47 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Brian Dooley <brian.dooley@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "kai.ji@intel.com" <kai.ji@intel.com>,
 "pablo.de.lara.guarch@intel.com" <pablo.de.lara.guarch@intel.com>
Subject: RE: [EXTERNAL] [PATCH v5 1/3] cryptodev: add SM4 GCM
Thread-Topic: [EXTERNAL] [PATCH v5 1/3] cryptodev: add SM4 GCM
Thread-Index: AQHbht2EOE7jA+u7j0qHveZ6c9zWy7NgVk+g
Date: Sun, 2 Mar 2025 20:31:47 +0000
Message-ID: <CO6PR18MB44843ECC0C5DD4ED75B22770D8CE2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20241213125850.2714328-1-brian.dooley@intel.com>
 <20250224165939.717714-1-brian.dooley@intel.com>
In-Reply-To: <20250224165939.717714-1-brian.dooley@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM4PR18MB5525:EE_
x-ms-office365-filtering-correlation-id: 18ddf999-5375-4c54-c2bc-08dd59c94190
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VW5QVWJYVkh0b2MvRGNVTXErRmIvZllTdVlyN0Y0OFZzYVhSTktyQU9mMG9z?=
 =?utf-8?B?dGdNZHhDL0JzdmtXeWV4Y2szQnJkYXFyMDFQMDJxejN4bUhBajZZY0hiU1VJ?=
 =?utf-8?B?SzIyZUJRTDhDSkI4aGhaSDlEZWtwNU5EQkVPcGRraHlsMjRUaEFFUVVQMHFI?=
 =?utf-8?B?NERHODVNUGVUcExuZ1JheURCL1g5VkpPUEdIalF0c0UraWRYblBGU2sxM1lO?=
 =?utf-8?B?MEV3bnY2Mk5maHZoNzRvOGY1Rm92enozaEVJb2U0cWNUeEpCUGhoOTl4SEFF?=
 =?utf-8?B?ZU9ycWdYMmNtRFBiNjZMcDhZN2JaekhpVDEvTWN6S2J2M2dJOWRnQnJ6V0Vk?=
 =?utf-8?B?NjhTQVlDOW1xM2lrYUkyY3BTM2N4MVhlYkQ2Vkprc2Y2R0I4VVlHU0tibGt0?=
 =?utf-8?B?Y1kreXlXeUJ2amI1eVpDZXNiMmw5enM2aHI5VExPU0ZNc1d4ZmRrM0RLeG5L?=
 =?utf-8?B?OG0vOWpRTlFrcXhUU05FVzd2Z2ppQ3V6QTZWcUZXdTVOOHhvUnVWY1hCaXJU?=
 =?utf-8?B?bk9Ed3ZHUEVNUDBQSWoxdEJrYXVEeGdOMXUrWWRFelhBR2l4bW9aTXFqYnVR?=
 =?utf-8?B?aGZjaGVRYXI1VkRrNG13VTBod0g0aVk3S2JJVGRBRjhHK0RnR1lHZko0dmR1?=
 =?utf-8?B?enRNTmIrOElKSlFwRFUwOGhEb2FRam44MjY4eCsvMXNXWlNyNDFMMm40K2lw?=
 =?utf-8?B?Zk44WmM1b0hsSW0yVW51QTgyeGtqL3hneE9jc2R6YUV1S2kyK09XUEpoa1VW?=
 =?utf-8?B?YmVqMytsYkltb1NZRUEwSERJYi90Rm5wS3VBY05NR0NKdHlUOFdHZFlnR3RB?=
 =?utf-8?B?V0dSeFg3elRsSzBKd1NiMS9IRzEwY0dpWGZXZDF5V29Oc1dmYU5keDRpU3FU?=
 =?utf-8?B?MzRGQmJXZ3VsUlJuNU11L2o2UzZDWnVENm1WRC91SDUwRmY2QWFzcUxmWUNo?=
 =?utf-8?B?SHZWenF5b3NrTU51em1YYTA0QklWV2hMVkROTlBQdmZpTWFRVkdSMXp1VURQ?=
 =?utf-8?B?L0ZFUjNDM1hFeXVNZUhQNGY4R0ZWcEhXSmY4QVhvcWp4V3NwMnB2OE1wTG4w?=
 =?utf-8?B?d0RNaTZJM0I5dTREdFZFQ3paM2ZtbWZCclVPZGQxWWN2OTdPSWhaWHJmQTNs?=
 =?utf-8?B?bC9QS01SbTNOK2VlZkJJYTlHUkR1SWRzaTlFSm5Hd2MwQTUrNUtCTTNnK05t?=
 =?utf-8?B?bUN6QjJEMzZOMms2U1RtKzB6bndjWDBsdmx0RzE3UWFzUlZMazEreWdkL1lm?=
 =?utf-8?B?R3RoRnc0aVg1WXdqL0JZQ214M3lEcnNUaXY5bjRCVUlGV1FrS1UzVHZaZ0d4?=
 =?utf-8?B?RkFIRHhYMVJwL0MzRmNSMTRZVzJCek5NQWNNbEFiSDcxZDlyQzgzdEN3QU5q?=
 =?utf-8?B?ZklLSkk5d0xscHptcmptUlVSY3VxN2s5ZUliMzhMcFREcFMvNG9NczNOTm8y?=
 =?utf-8?B?bFJKOFYvdHlxQXVsS3Vta0lZLy96UStncWVyc29GMzN4UnZkSy9td1F0QnF3?=
 =?utf-8?B?YWx5WVppemVpb0R0MzBUSlE5OUxZZ2x0WmdPUDVFZUJCcGc1bWNsNTJpVDZx?=
 =?utf-8?B?ZFJsbXJxVzBqQXlieFArbkJFUW8zQlppc2Q4dG0zVVFGZEs3Q3d5ZG1ha0hK?=
 =?utf-8?B?L28zdHBFWmNTU3dsaDlza0hLY2tuMXk2QjExaTVaV3phWE9JcHdPaGdLc3Vl?=
 =?utf-8?B?d0tla2p4WG45cVVnS3J3dWNtL2IvSFNSK29RMjkvVHF5ajU4TGlaWWQ4enBx?=
 =?utf-8?B?ekRtS05HYU5OTG0xTzFwbURPYjNYSmRxU015WExKTG1wYWZFeUNRM2dGT0VR?=
 =?utf-8?B?cHE0aWg4MEU4ZzJGOGtrY3ZkKzI1VDJWOTJvNXJEVHJxUzZ2TkloS1hxMlZ4?=
 =?utf-8?B?ZjNlZTFYTUFLcmJ2TVZETllxMGlTZjZzNkt2djZDUW9EQWtRN2pMQ2RvU0pw?=
 =?utf-8?Q?wDFOK+HQEpnQBCCJ49CifO681PdVro0q?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnBxaWdQUFJwOVlnWGJUMmZaR0hyWkhaNlBzTWxKTXppb0QrY0hMQTJra1ZQ?=
 =?utf-8?B?VURSempGRDVzaUtrTmlpRnd5bUVrQS9UVXFIa3FiTTFBSmhTV1VTVWhXQng0?=
 =?utf-8?B?azg0YUZKQ3FvWDMvN2FFL3Bndy95SDR5VGtUOFdtbU9WTzc3dE5sNGZ1Z0x6?=
 =?utf-8?B?UjV2V296T2JPK2RreUU5eVNGOHZPSDdsMXdWYXlJNGtQSzJvb3RlQTA3dnVm?=
 =?utf-8?B?NGpXdlFHWFBMN3k5MEd5UHptNXpWUTVHeGtBamF2L25jTjJWcDhMV09Eck9m?=
 =?utf-8?B?dUx6MjlEY0tsdWRQWEV0d2xqbmYwNUsxM2JHbU1XeWtjbi91bTZqcUsxNm45?=
 =?utf-8?B?c2RJR0NTNGZ6L3FNNStGOThSMVVJR2t6bW93T0I4MlZnN2ZaVkdGS0tHZlZw?=
 =?utf-8?B?VmFZbFVNZW1TRjEyZHpZREk2TkNOL0hvaXE5OWloRm1pTkZGKzRJdmt0RVVo?=
 =?utf-8?B?dDB0RkE4dUN2UG5mTk1FUzNOM1EvQmZVMjA3cTBZTktxeVFJUnkwYkNJcGho?=
 =?utf-8?B?enBEWG1HdUd4bURzZ1FMelRPSlNFUmc5azVIZHE1RWp0a0lQTnh3T3pZWGJW?=
 =?utf-8?B?V2JPd2NCZEpKUzFUZlhZRldManAvSzhiK2pGME9QZFArcDhPSHFjQUlLY1lo?=
 =?utf-8?B?NUZkanhsNmRSV1huRzR5RmFxS2ppK2NGTktIcHk0RlBSMFNiY3J3c1BmYmFC?=
 =?utf-8?B?SlM3bytsbFUwWlJML1dlaUZVam93Y2F5OWN3N3FtT1BrY1poOXN6UUJMbkFJ?=
 =?utf-8?B?VVk3ZDFSMzFlUzRySzREZ2FjeEcyakZnQkFyWWcrcVJpN0dkWUZyNUlHbGFi?=
 =?utf-8?B?M2c5NGxmbkNsMCtENmUvWUNlTFdNbnNtTDZpNGF5czZpU3VRRnN5ZmpXVEJK?=
 =?utf-8?B?VzNkUWxCdjh4TUphelFRb3VxaFNpVkhqaTJQTU9CLy9GcHd0WkdnVExPcGtF?=
 =?utf-8?B?dWNqbGRPK0VXZFgydEJ1NlVNenhQanNNMVYxMGNENkt1Uk1BSk1LYWhUazBS?=
 =?utf-8?B?YlcyejYraCtmcnpPRkxQNzAydlB3aDVaZHh6UWxVMmdYSEMxU2plT2FTYzll?=
 =?utf-8?B?a0dkL0RRM0h3eXFCTXpib2ZvdWxDemswR0themdWYUZhcllCU1JxaDc4V05K?=
 =?utf-8?B?TDkyeEsvb2tsWGZIRlhiRHpHQTJPekhhRWRZQlRFN1hNNWFHbkEwbW1ZQm5W?=
 =?utf-8?B?ZEFTZHdVOUx1M2c4TWZYSlhodm1wTjR3Mk1MSm5Jc1JCbjVURXY0Ym5qeXE1?=
 =?utf-8?B?Zis4U3Vmd3JSQmdsY09oa3NOeHBEMDFJbml6OHdySUh2bFRXNzhRU1JZMk9Z?=
 =?utf-8?B?WDlkUVQ2NVYvbXZ6ZC9meVVaYS85TVhRZmZMZnNCY05vdlFZTmhJMzBjcTRJ?=
 =?utf-8?B?VEVrVkNXV2xBTmJiS2hRNzBMejd2cDVMMDFUSUhYd2l6Qk1mdGxHTHMydHJl?=
 =?utf-8?B?eHAxMEs1Y0ZmUm9NZkd4aWdEcURyMC9tVXdDQmtqdDRaRXhndG9VK3M5cWph?=
 =?utf-8?B?QWdrUXcvOExhZXdtVFRMN3NRZWhUSEN6eTlpOEp4L0hyTURROVZmOXRwS0t4?=
 =?utf-8?B?ZVdNQWxlSlNOOGZjSDZ2MTA3Z1RIUGpvNkdFeVJ2MlpLZCtJNWgrSVZtNFVQ?=
 =?utf-8?B?dk1XNlVhdEg1NG5GaTFUeU9rMGpMRTNpc2hMSkpWY0VETDNzWEE2UG4vc1Ez?=
 =?utf-8?B?V0l2TnBHQ0xkN0RjenVwbEYvcytyL0V6YUxHY3lmbzhyckNxdlh6Qis5L3Fn?=
 =?utf-8?B?YmJNUzRvU2NacmZ0Z1U2Y3VkUTlwVW15SDhIa205RDVkUkhTSEZpN0tOVXNz?=
 =?utf-8?B?ckxEZ0dXcFFzTWZBbVNreERHRmlUVHc4QWhNbTFaZzVTMzhEbEoySGgxL0RP?=
 =?utf-8?B?VUZrMEtjTG94RUo2TWZJdU10endmbVpGdlhpOWVYaUZDTGR3U2czWUduVFdC?=
 =?utf-8?B?eDNvZDBwcytPV0hnOFc5czBkWVVTaktXYnFJcUZoZHNZTW1JRDhtTWxPcE5h?=
 =?utf-8?B?ZzRMT1VpQkN3TjRvTS95NnpMK0hDbFhDWjRQc255dFVpN2pob0d2TEFldUtj?=
 =?utf-8?B?UFpHbmR0VGZIQ3l4ckl6MGxHNmx6SjQzMTZ0TnFaWU40ajZ0d2RHRjdGbjcy?=
 =?utf-8?Q?ZF+OaqfEnvI7VyB1GXH22aEx2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ddf999-5375-4c54-c2bc-08dd59c94190
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2025 20:31:47.9287 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oTgRK9Tqbww2qORVJrOfWtbVlORT6hB6snTZgC+U1WUlF606FNJ7chexzHVZMQud4hfRbvSGEbLt64cSpnt27w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5525
X-Proofpoint-GUID: H7supsIY5WjA1fc5SpHmgQG3ehcs7tMy
X-Authority-Analysis: v=2.4 cv=O73DvA9W c=1 sm=1 tr=0 ts=67c4c036 cx=c_pps
 a=RoG0BMNHDmmKSZcrvsSD+g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=QyXUC8HyAAAA:8 a=M5GUcnROAAAA:8
 a=zTCPTazOmJgnPaHrJCUA:9 a=QEXdDO2ut3YA:10 a=oBihJ1cIzGAA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: H7supsIY5WjA1fc5SpHmgQG3ehcs7tMy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-02_06,2025-02-28_01,2024-11-22_01
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

PiBBZGRlZCBzdXBwb3J0IGZvciBzeW1tZXRyaWMgYWxnb3JpdGhtIFNNNCBHQ00gaW4gY3J5cHRv
ZGV2Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQnJpYW4gRG9vbGV5IDxicmlhbi5kb29sZXlAaW50
ZWwuY29tPg0KPiAtLS0NCj4gdjU6DQo+IAlDaGFuZ2Ugd2l0aCBHQ00gbW9kZSB0byBpbiBHQ00g
bW9kZQ0KQWNrZWQtYnk6IEFraGlsIEdveWFsIDxnYWtoaWxAbWFydmVsbC5jb20+DQoNClNlcmll
cyBhcHBsaWVkIHRvIGRwZGstbmV4dC1jcnlwdG8NClRoYW5rcy4NCg==
