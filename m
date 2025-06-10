Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFE6C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 11:08:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE76842E62;
	Tue, 10 Jun 2025 13:08:48 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by mails.dpdk.org (Postfix) with ESMTP id 3AF8B42E5D
 for <dev@dpdk.org>; Tue, 10 Jun 2025 13:08:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEWbMayQA+GnYgmvRB7M521yHLXk/cfyO2BDUBJLyXWnKxgblWMMYlQYQXR7sEz7nHozFJkXqSM561SrCyufrz+3pR3XnzOzkHmTDTGdRgVTmG+3OmhyAgZIpaOf+C4Uh40FEMMYMrbRnLNUbK+3f4xQtBIr/WJ/24fMvORmRF71VZPqr14B9VkX82L1dfCwM16+TIATp5Scv7w5NaeycBCttY5IX47zd5HVTEOJOAr6GPgmjggPMVAYQ1Z3WrAVj6p/wUA8Ao+F04285Ri+jBdEjFiYMuPe9WBgHndUoc+01L71wuD32qcFLbxwFy/FNFQwVDNTnXuiWvQkJyvF+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sayzHrg227PGtrP6MZJLkjprMaGaNSjyJfdvxTNtv9U=;
 b=VBO0T1/gunXOkUd2N8BjEchMkSxdH28g1HtILOHPC0+/XbTUoVWikLS5nLK5JoSACW4ZpwgNTnOE4ZE5LZ6ywhgOY3EpdU7+BS17qDr6WLRgIW5bqP1fLNa4ym3LwPOSInne8Ejr0JO1La2WjZCPnUBRa5BGwU3K60SBN9qw2UVbkwwi4UAEzlY3+Jsj6kNtNLYrpfW5PMp+eZDpk7LZ29dqslElliKuInt3SUhbogZ8My4auxRPVU4hY1LypBg9Dp3ueEwUnIdRhm1QrnJPs3AIVP2fvwQh2y9guGKtmIA9zxYtN8sKs4K185K+RUiwP6sVrxelayyvuNMFU/qi0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sayzHrg227PGtrP6MZJLkjprMaGaNSjyJfdvxTNtv9U=;
 b=gffSN9vknOz7gM/hMFeMwdVd6frKl7/lMf/RregjosjGrY8CZKfZ9XHUbRSONhUGVeogk/qMF7GmtVkzsl1eyouoHT9Y4cyqe9hS4xf6GnwEChC8EFdT6vX++kiVgXR+q0eW9ij/P7d/WbhnMhD3XZ9EodLPOgIJJeq1EQ5Sbb8=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Tue, 10 Jun
 2025 11:08:45 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%5]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 11:08:44 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Thomas Monjalon <thomas@monjalon.net>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v5 0/3] lcore options cleanup
Thread-Topic: [PATCH v5 0/3] lcore options cleanup
Thread-Index: AQHbzxwrl7uP5TzS10uf0QYzsXMtprP51c8AgAJ67xA=
Date: Tue, 10 Jun 2025 11:08:44 +0000
Message-ID: <PH7PR12MB8596DFDEAF9A7D0EB11D0A9A826AA@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250527152913.279011-1-bruce.richardson@intel.com>
 <5697443.hdfAi7Kttb@thomas>
In-Reply-To: <5697443.hdfAi7Kttb@thomas>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=af430a0c-b9d7-4601-a1ee-a416b191dd06;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-10T11:06:50Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|MN2PR12MB4158:EE_
x-ms-office365-filtering-correlation-id: a5cdef9c-e046-4688-3831-08dda80f2a79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?a0loK1oycDNEODNhNjVqWDZMMXdMbGdWNTJUaWVyT205a3FjSFptVWNCaEtx?=
 =?utf-8?B?cjRyc1p5ejlBV1l5M044aFUzZ240V1huRlJHUW5ZRGZXOVBZNjFzNFptQi84?=
 =?utf-8?B?cXVSRFNxOFpwalZGSWpjaGtIcmp0OVpHTHJ4VXZ5SDc0MjA2UjQwcFpRNkxW?=
 =?utf-8?B?L2pQRU1NREpOV3I0Q1RRRk1CT2E2RnYvYVY0N0VvR29DNDdhbGdNTTVPR1lw?=
 =?utf-8?B?SEY5ZGg1ZHlJZ3lyZ0tucE9ldlNzMFp5QWVYMFZCdkNhUE5GYVl3NXZSa21E?=
 =?utf-8?B?dVY4c1pna3BISW0xUjlLU1JkUGF2TWtZQTE2RkN4U2kzNTFTZ29yZXp6RTJi?=
 =?utf-8?B?Q01nRWF2Q3pYR3lMZ0pvQ1BnbFBnL0JENXY5YWlvQnozd2RCaUIyaXdPUjNB?=
 =?utf-8?B?bXBqWC9sQnZ1VmxrU3kvSnNDYW13QXFCVkg5eFhyUGFEWm1MTFRxZzVlTWla?=
 =?utf-8?B?MmpGcUR4Rmw2K1NtSW10NExnb1Z0d2tGdUY2V3lJTmRMTHVYdTJzb3RRQWNY?=
 =?utf-8?B?YzlqdDZUNHA5UTM4bk9QUDRwMnl0d3YxcHZ2akdTVEpKcFZOQmVkOUtSV3I3?=
 =?utf-8?B?ck9WZW9wU0g3dW94dnplRlRnQm1kZXExMGFvYVpsaVBaS3p1R1pzdU9ZYW1v?=
 =?utf-8?B?N3lSUmNFanV0OUNhMHNTN1F4VDVSaWJjRGtoUWwvQk0wc0I2N0FYZXg2VmFO?=
 =?utf-8?B?Ti8rNWRsczNpb2F1T1RKZkMrS2lldXFKKzlKUFdiVWtneFB1aDU5cUNYc2pN?=
 =?utf-8?B?QnQ0QkpUeGkxWkdFOGxkaFhsVHBjUTQxem5CSlJtbkM4NnNLajNYdkh3b241?=
 =?utf-8?B?ZTRvUFVPdUJLVUh6N2lJWmJpRmlIWlNuZG40OEJaZTY2OW1zTXpxU1NhTmpj?=
 =?utf-8?B?Sm9SaDRvZWdLOVZrVC9tMVJGUGlocEhBZnUwR0tYZDhnS1VoTzFDUlh1Q2RS?=
 =?utf-8?B?Ujh3elk2WmlBS2NWTFpYaG9YZGNtRzYvSTZ3VmNWTlcyREErWlBoT0hUTWlx?=
 =?utf-8?B?dXBSSEtSeTFQbWcxZjJmeC9meFAxeTN5a00wLzRtbVN6U1RmV1loSlZvWjNp?=
 =?utf-8?B?R2dTODdVSWYwOVFSZlZFMi94QTlYeDZqNno3ME0zbVEyYnBYVnpvampIbFZB?=
 =?utf-8?B?Q0hlUDdackREd0R2ZVJsbU1Hekp1b3BqWGFackFWU3I0WHJ2S0V0Nks5YkRV?=
 =?utf-8?B?dThKUWl5TVYrWC8vczE2WWJUV0Vaa3FJdk4rNm1kbENwSXU2M0Q2SkxocGR0?=
 =?utf-8?B?REFQY0wzaXdIcVhXWWlZTHJUNnZEQys1aEFaTUlvK2ZPZnc3MUxHZXhreWtM?=
 =?utf-8?B?VFdOSjNmYkxlMDh0a1lTdmNQeDZkcnk1RHpwRnd4RjN6MElwMFR0YlVTT3Zr?=
 =?utf-8?B?VWIydkpwdFdUK0lad2tUa0hUY3NmUkcyWlFWZHFjaVFDbHcvbEhRajBCV3Fu?=
 =?utf-8?B?eUcvYTZXVUhtRlYzdC9xTENqUDVNaG5QbmNqRTlxZ2V2bEl6QTY3ZjQ3MkhF?=
 =?utf-8?B?d3pYNTRXa0pUS0lJZXRuaUNWbjBhSkt4dnRZUWVGMkM1aFFRWFErQVF6R1Uy?=
 =?utf-8?B?NXUydHdmM0lOZ1drdkZyVVFVdThqTEtaelh5V05aODNSR3Z5TnBTTm5zMTNF?=
 =?utf-8?B?TTFZTkNwcGQ1Q1VsVXUvcDJHMGdJNlMxNWcwZjFjSjlEOHVEWld1UHovSlZQ?=
 =?utf-8?B?Q044cHcxUE5pMkpFUGNLQ1ZhRnhkQ0JhN21vU2t0ajVtL0F6WHBobjhkSk5l?=
 =?utf-8?B?TmdJbGZUUUdIWldGV1JJYVh4eG83UFJuZWNGNUtqSURaLy9ic3Z5ZU9wdFUx?=
 =?utf-8?B?azBxd2FIY3E5V3BZVGpDdE9yZUlxdHRVa3pkMXYyWW9MZjE2eVFlMXptdkdt?=
 =?utf-8?B?NCs4Zk5LYjdhUkNzNjdZOWJqUzVLRjRFeGRjdHUyVjBtSHZKaDNkZVVmZ2pB?=
 =?utf-8?B?OFhwTnRaZEpzc0xVaXNaRDZWL1MwS2dWR3BYVkRJaWtGUFdSTTd3Nk54ZkFv?=
 =?utf-8?Q?5m0+LrLq8V7RmCAFJWk/BMyXsX2GVU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blNlRkozNlp0cVU3TTgvSU5pb00wSGNyVTV0emJ5SDRDanYxVEN3MWFFTE4v?=
 =?utf-8?B?dUROdHlucmRtb3UrQzVDVmdndElCaTYyb1IvRFJpYTljZVFUNWQ1S1ZZZ0dY?=
 =?utf-8?B?cmtraGNWejVlaEI4RmtVb1o3elEva2ZNYVlUMU8wYWdOd2VGRnJvREF0VHZq?=
 =?utf-8?B?UFh0ZUZFWThBZTg2Tm5ERTFMWTN6dG5kbUpHc2NTeVBaTFh5aUdvV3gxd3pJ?=
 =?utf-8?B?OHF2VUFOa3d3Wm1peHFUZkF0bG1aK0xFRG1lV2FjdEE0eXN0bmlDWlRFbyt1?=
 =?utf-8?B?WUVZNUpQeVRvTjFTU3FRME16ZkgxTVlYa1JMWVZkK0FiNVdGNUlBeFFMSkhO?=
 =?utf-8?B?dGN3UklVR3hacTZqWmZKeGRRNG9KejNLYVdxWDc1SEVaZDFyeXR6dGZpekJo?=
 =?utf-8?B?WW9lUHVYbkhvZWFUdW94bXc4Z1dTYi90NFlxWUlHdDExSS9kMGVQRi85OXdp?=
 =?utf-8?B?VEZYdGhadUxEUmNZWnFnVXBRenMzc0JPVFMwYVp0UFRFdzRIYXhEaVlDSVlZ?=
 =?utf-8?B?Z3pGRGRwd2hQcjNZZWE0Y2dMNVFLenlwWTJvQ0xrMUthYUhSUlBRMjlsUlJN?=
 =?utf-8?B?WXN6OHpIZmVRb1BRYmNzQ05PZk5KdnhFOG40ckw4NFJmR1BkclF1VlY4VVNO?=
 =?utf-8?B?OTlYckJkTGlpNGxrQnorbUFaWEdnVG1yODhWQXNIc2x0R3Yrd1RmcXViZDdp?=
 =?utf-8?B?a3U4WHhkVlYwaFhockI1aUF4KzhxVnFmbG5qZDN2b0gyS3dQV1Zyem5UcHJ6?=
 =?utf-8?B?MU1oWGdXb0FUendnN05XVUE4a1NMb2dFaVpEZ0lXY1NRaWI1SVAxOTdNZ25r?=
 =?utf-8?B?VDl1cGVlVll3cEZzUWpWd1RmbW1nNzIrdWl5SURacjRINzUzS0ZmRGUyNDNw?=
 =?utf-8?B?TjZMYTFZRzNvWEg0OVdNeTN6M1RObFRFRHhNVHVKMGdBbXNuL1BIbGVKRnFq?=
 =?utf-8?B?b3RCTlhJUXJiWUl3TmJ2UGdvQnFKb29vL3JtMzQvK3gyZDR5M1lYRXplb1c4?=
 =?utf-8?B?QXl5Z2pZTUF1eXJjSFJPRVlkNjVVZ3RKSDVtazIwNGFkSmRYTzdaOFN1M0JR?=
 =?utf-8?B?SGYxN2t3THY5Y1hvVHVzbk9TNTZpM2JOQy8yNGc5anhXa2hldjVJN0JyaWxE?=
 =?utf-8?B?VlR5SzJocG1vS3cvZFpjSjFZejFTekJFbkV5Y1ZvZGFBRC9uZDdTMkRaekVR?=
 =?utf-8?B?L0pUQXhKMXlQeElRUjVndU9pSVJpTEpaYUdTT3R0RzlqVHFmRm1YQUVabEVZ?=
 =?utf-8?B?MjZXRnVGMnliTnY3Wnp4c1duWnVpZXZuRjRrRjdRRTlGcFEzTmwzZldlbFJh?=
 =?utf-8?B?cHJPcWlneTNJeWpTcEV1OFhUZFM1YlNNZ0Q4WjZ1dmtZZzZZcTVhL0ZCWTBH?=
 =?utf-8?B?bnpjbFhQaEFITEw0M1FXMWRNOXRGeGhIVDhROXlpR2NpNFR4eGVDL1ZXcGFV?=
 =?utf-8?B?T3ZHM3J4R0FGUUZJV0ltR3BKWkk3cTlzNDN5cjhVTVFKV2RNbHNkMkczdzNE?=
 =?utf-8?B?UERHcXFlcHh5WDR4b0ZKU3NYMEF0bXBqYTJMUEJUU3ZPRU5mcyt2eWdPN1d4?=
 =?utf-8?B?Y1RHWDBXTW1tSzJFcHpvQndOYlp5MEtreTZKenNPaFdYOFJFSUc0emRGQUwy?=
 =?utf-8?B?Vm5sRmE3VGFkWFFsc3JzM21BSTVxdVhkYUZvWTNuUWhnUlV6WGZLMXhWNEVs?=
 =?utf-8?B?dklsK1BLL3NxbnBPbDNXSHJrQ3NpdEg0b09WOXFoN1ZEckU4My85UG9oQ2kz?=
 =?utf-8?B?eVdvbWdmaGZYQm5rbnM5WWowNWUzaDNtNUFyMFRiZ2gyWFk4NFJIdHhmY3hQ?=
 =?utf-8?B?UzJOVWlsdlkzZUtnUVdMU3QvbjI0cFR5VHFOMGdNbElUdGhkYVdGSFRQNERp?=
 =?utf-8?B?Q0diZnZ0RVg3dnB2YkxtTTJFVkl5VDN1WHAxOFBoMFB5RVhXeTV5VlMvMnRH?=
 =?utf-8?B?Y1E1WUhpM01GQlQ2NDVYWjVaZnU2Zkw4VTBKUTUxVk5ZODU4NFR5Q3hjaUFD?=
 =?utf-8?B?Z3Zrdm41RXA4MVpBNWNvM3FOMmQrd0g1VWlLaUZuSDVCZWVBUkRNZDRHRHZl?=
 =?utf-8?B?UzI1cmhYV1dNdUN0czh6VnBXNnBUNm5PR21GY0pnc3RYTVJkQk1mWTJJWDJw?=
 =?utf-8?Q?4TOg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5cdef9c-e046-4688-3831-08dda80f2a79
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 11:08:44.6759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kFYtUy0b9em3dDVHBGRv1P7e2xllA+T4+tUizxVBhPODRp6XAAwcdZFgFAsUfgL+Q0YEEAbhIs4EP62stB4c2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158
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

W1B1YmxpY10NCg0KU25pcHBlZA0KDQo+DQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5h
dGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBv
cGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4N
Cj4gMjcvMDUvMjAyNSAxNzoyOSwgQnJ1Y2UgUmljaGFyZHNvbjoNCj4gPiBUaGlzIHBhdGNoc2V0
IHBlcmZvcm1zIHNvbWUgYmFzaWMgY2xlYW51cCBvZiBFQUwgbGNvcmUgYXJndW1lbnRzDQo+ID4g
YmVmb3JlIGFueSBtb3JlIHNlcmlvdXMgd29yayBpcyBkb25lIG9uIHRoZW0gKGFzIGRpc2N1c3Nl
ZCBpbiBwcmV2aW91cw0KPiA+IHBhdGNoc2V0IHJldmlzaW9ucykuDQo+ID4NCj4gPiAqIG1hcmsg
dGhlIG9sZCBjb3JlbWFzayBwYXJhbWV0ZXIgKC1jKSBhbmQgc2VydmljZSBjb3JlIG1hc2sgKC1z
KSBhcw0KPiA+ICAgZGVwcmVjYXRlZCwgc28gdGhleSBjYW4gYmUgZHJvcHBlZCBpbiBmdXR1cmUu
IEV2ZXJ5dGhpbmcgc2hvdWxkIG5vdyBiZQ0KPiA+ICAgZG9uZSB1c2luZyBjb3JlIGxpc3RzIHdo
ZXJlIHBvc3NpYmxlLg0KPiA+ICogY29uc29saWRhdGUgdGhlLCBwcmV2aW91c2x5IHNlcGFyYXRl
IGJ1dCBzaW1pbGFyLCAiLWwiIGFuZCAiLS1sY29yZXMiDQo+ID4gICBmbGFncyBpbnRvIGp1c3Qg
c2hvcnQgYW5kIGxvbmcgdmVyc2lvbnMgb2YgdGhlIHNhbWUgdGhpbmcuIFRoaXMgZG9lcw0KPiA+
ICAgbm90IGFmZmVjdCB0aGUgIi0tbGNvcmVzIiBmbGFnIGF0IGFsbCwgYnV0IGV4cGFuZHMgdGhl
IHNjb3BlIG9mIHdoYXQNCj4gPiAgIHdhcyBwb3NzaWJsZSB3aXRoICItbCIuDQo+ID4gKiBBZGQg
ZG9jdW1lbnRhdGlvbiBvZiBleGFtcGxlcyBvZiB1c2Ugb2YgdGhlIC1sLy0tbGNvcmVzIHBhcmFt
ZXRlcg0KPiA+DQo+ID4gVjU6IGFkanVzdCB0aGUgZXhhbXBsZXMgaW4gcGF0Y2ggMywgdG8gb25s
eSB1c2UgcXVvdGVzIHdoZXJlIG5lY2Vzc2FyeQ0KPiA+ICAgYW5kIGV4cGxhaW4gaW4gYSBub3Rl
IHdoeSB0aGV5IGFyZSBzb21ldGltZXMgdXNlZCBpbiB0aGUgZXhhbXBsZXMuDQo+ID4NCj4gPiBC
cnVjZSBSaWNoYXJkc29uICgzKToNCj4gPiAgIGVhbDogZGVwcmVjYXRlIG9sZCBjb3JlbWFzay1i
YXNlZCBFQUwgcGFyYW1ldGVycw0KPiA+ICAgZWFsOiBtZXJnZSBjb3JlbGlzdCBhbmQgY29yZSBt
YXBwaW5nIG9wdGlvbnMNCj4gPiAgIGRvYzogcHJvdmlkZSBleGFtcGxlcyBvZiB1c2luZyBsY29y
ZXMgRUFMIHBhcmFtZXRlcg0KPg0KPiBUaGlzIGZpcnN0IHN0ZXAgbG9va3MgcmVhc29ubmFibGUs
DQo+IGJ1dCB3ZSBuZWVkIG1vcmUgYWNrcyBmb3IgdGhlIGRlcHJlY2F0aW9uLg0KPg0KPiBBcHBs
aWVkIHdpdGhvdXQgdGhlIGZpcnN0IHBhdGNoIGRlcHJlY2F0aW5nIHRoZSBmYW1vdXMgLWMgb3B0
aW9uLCBwZW5kaW5nIGZvciBhIGxhdGVyDQo+IHN0YWdlIGluIHRoaXMgcmVsZWFzZSBjeWNsZS4N
Cj4NCg0KQWNrZWQtYnk6IFZpcGluLnZhcmdoZXNlQGFtZC5jb20NCg0KV2UgaGFkIGJlZW4gdXNp
bmcgYGNvcmUtbWFza2Agb24gREVMTCBzZXJ2ZXJzIHdoZXJlIEJJT1MgaXMgY29uZmlndXJlZCBm
b3IgUm91bmQgUm9iaW4gY29yZSBtYXBwaW5nLiBBbGwgZXZlbiBmb3Igc29ja2V0IDAgYW5kIGFs
bCBvZGQgZm9yIHNvY2tldCAxLiBCdXQgY2FuIHdvcmsgYXJvdW5kIGJ5IHVzaW5nIG9yIGZvcmNp
bmcgdXNlIG9mIGBsY29yZXNgDQoNCj4gVGhhbmtzDQo+DQoNCg==
