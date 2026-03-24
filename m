Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04331E9A74B
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 09:29:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1536402BE;
	Tue, 24 Mar 2026 10:29:26 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 55FE74025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 10:29:25 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O8VcNl526873; Tue, 24 Mar 2026 02:29:24 -0700
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022117.outbound.protection.outlook.com [40.107.209.117])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d1rpjp340-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 02:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dt46pnTy8Xd41gk90/0yHaY1QHX94eJwHzqx9QuugHbEq3t3/CMeQ/jh4Vk7j7cy+oXNlJnrwWffaeP4sWHpgvslMmHv9eObUWVxEI065sYgJD2T/qabxVeogT7uwT60G1hyjp1GqpqLbKvd4koZRCUU4g5WvW5btvBvq8CkqxLgZXW6BEP35TaTlsQFJ6NuAYO3uZgWJSKmliI4EfXspmHNHzwiURNMCZmju32oVpCIgiPGh8lb3SXV5DJC7qGWHlh7NM3d88GbhdcY5gBfZl/atKdYjHXmueycFd0ct6NdV5j59WDgDuh6TMXByyQv80D+zOuSzXN6fZZauiNapg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjn8aIgHyYZq/6uwwiQjwPjjAg/HPwEpl8JI8++gQzs=;
 b=NCAm/tpR7jLoktSQ35JSEjV6rluCMsqQ6wy2MsGDptKG26o+VNtbRab2bgdJp1G6puZMa+zXj1eW2xSRCjniM1Wgc4jyuLZBVHFMC08UO25j3farMFe0CQHUTJoTEZMF7XF7F5n//qT04mWJUJJi0RKm3n8E5Xm6jzUoDrbcVqjSU1cSRyCND6LPxQ2Ob3YfuctMZM/hAQ0LfJDWPrks6q9NhpRood/ca91cJFv+l5Rrm5dxmi/SJ6u3mC6p8kVSfWHdR1ppHiO5hbxtTmZlN8zqGXvLwz8mm2zyXQnpTk8ML9QUokT8puA18WEKbwoQFGfsG5OUVD3grkG1+Xx5ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjn8aIgHyYZq/6uwwiQjwPjjAg/HPwEpl8JI8++gQzs=;
 b=rb/uzB/Cil3eBc0QMYIeAgcfmmdHA3sVlW+ih9yNL5/wOLuNsCgyO8EHh4xZv1Vug53/qOJAlE4ZdHw8Q/pr8yWaq1opXOfcmOJIBQMu1J3deVMQUfwRQspmRfgSJuJ5lTHmozpLJK2GiiOd0BX3OagWRI7kW9gwY6RJR2i1Y60=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM8PR18MB4486.namprd18.prod.outlook.com (2603:10b6:8:26::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Tue, 24 Mar 2026 09:29:21 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 09:29:21 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Rupesh Chiluka <rchiluka@marvell.com>, Emma Finn <emma.finn@intel.com>,
 Fan Zhang <fanzhang.oss@gmail.com>, Kai Ji <kai.ji@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH 2/2] crypto/qat: fix modexp and modinv result
 length and comparison
Thread-Topic: [EXTERNAL] [PATCH 2/2] crypto/qat: fix modexp and modinv result
 length and comparison
Thread-Index: AQHcutcCrp9jrZ1HzEa0H72jWNDWQLW9RGGAgAAnNwA=
Date: Tue, 24 Mar 2026 09:29:21 +0000
Message-ID: <CO6PR18MB4484965F59B144F034542DFBD848A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260323150854.2394000-1-emma.finn@intel.com>
 <20260323150854.2394000-2-emma.finn@intel.com>
 <PH3PPFC694D094E02483B7953D18FCAB075DB48A@PH3PPFC694D094E.namprd18.prod.outlook.com>
In-Reply-To: <PH3PPFC694D094E02483B7953D18FCAB075DB48A@PH3PPFC694D094E.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM8PR18MB4486:EE_
x-ms-office365-filtering-correlation-id: e151d276-3ab2-4832-0a84-08de8987d4b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: CBqlv2YHiHSAZghvlGKl5nHklB1Swjxf6Qg8ECRh5wG1y+BLliguiEbyrAjhKQaIVvHDDApG65ZCUYTzoJwYrZp2iaKE0YgAgObWYB10PeykKS/OQsq+bRRITF5Eo/iB/OpCEpEUNW8wuVw/8NdeszvCfPCO+OMIH78+UseHQAuaoiE6/+WbGyUauca7ffUQedvzqiWQhzQPuP5Tjw6o22N3c4G+1ThB+6Rh5I75gPk+h0vVQuFO/ULqOEa8XNbMNC4U3nrgVJe2HS5r/tb0KArLrdmo0zczUyTf/verb5fewkXdGx99mfyN8xbeMzC7oZgoPO1UUv7vFjWlTi1o8/8nsrbvpS40Yovfg6b+Flv7x94NQx3Qjz8CsC017bDv224Lzv4imOk1McQMeGZBH2S9fb6t6aj0tzyrq9Kd3XjY3ago2v0TlS8FHd2uqJ62TepzZDttX9D7Ye5Uofm6PGoVyIE5brTGeahlcd/59luVnPjnYRLBfMvClU0DppnAFpkoIw/99IDP+msDEiFp4XR6tyxqixrvN/sGDAAXRGuOAu8nmqZQcfko0HzVnFBowshw0HE67faK01PDEP+Qf4JSsz8iquXzzbaENsjlmsOto4atKlbwOevGK4DpyhSA8JV4xGHPD+pSpWmCVzNDLkVBp8bmbp5gTeN7BtQ0l6b/elDmWYZ5LkBoMFGHvmayhAT4PE7OkjcIMrlV5WYCr2qkldgBHg7couLjP9YpUd3C0oEIqYksbDEnrewdj1jgyEpt4DZAHBsGQroAiMnlWcUj4uH+kJ+ZW9ss6GoQc3w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGIweFk0QmhEcVdnL2VpK3hkOVBuUTZkd1BzLzRsR0hLSmJPcHhDUnNjNUIx?=
 =?utf-8?B?bzM5Uk1ZMzZreHhEdEZEL21ONEJuaWo2bWMwS3dzaUI0MzJqTFhicWxHUWpJ?=
 =?utf-8?B?TkNlcXNyYXU4aFp4b0tvNlBLRmVHdDJodS9RRjJ4bGZpM2oyZzhEMHhPOWZt?=
 =?utf-8?B?ZElFNU9EUTRHd2lrdDNENUxKLy9ZRG1jTzlEMWptTDJVY3VibEd3eVlEOEFo?=
 =?utf-8?B?R3Q2S0tsWS8rUUpiWDNUMlNpTHQxZndoY2FSOWMzQ2FTTzZFYmJEU0Iybm4z?=
 =?utf-8?B?U0NOOHArdlR2NUU3SG1VS3MvRER0L3pmVUJHTEdnNGEwSDByVkxpYjFvYnpG?=
 =?utf-8?B?WDJ1UkN2dCtKSjYyR3k1WUVNL05wUFVrUGZOUUxFZTRPODZOTDcyZjlzTVdr?=
 =?utf-8?B?R2dPeWV2MS9WMUlqQzd2TTQ1S0NYTWoxV1Bvc1R2R2NWeTMxa3JxamNPdVhi?=
 =?utf-8?B?RnN6b2o4OWNtelVEc2U2UWpwUGhkWEpoWUZubVl6M0hCVTR0aFlxYjlDd2NB?=
 =?utf-8?B?ay9OVWsxeml4VTJmc2t0UFhBa3llTTEyOU0vTVMrMFZ6aExFRDgwVHZDN09x?=
 =?utf-8?B?U1ladlF5N05UMklzbEFaUU5rS3hCaUR2ZGpMWnVLcmJqbG05Ry9mWkpUVjZ1?=
 =?utf-8?B?WndWZitCYjRsTWh4V3BmWGVteTJFWTdlOWxCeC9sTm41cEdaUDJ0QkFRajIw?=
 =?utf-8?B?SGRnVnI1TUFVR3V3SkhvalZIWC9Vck15d3U4WHlTaTBBamo1Y0MzUjY4cHNS?=
 =?utf-8?B?WFpKRjI2WVBPSUZPSnJhdjlKS2VRUUF5SjlYNWVLV2FwK2NXSW5IUGc1VE5C?=
 =?utf-8?B?MVk3MDQ0dkpSM2hrT0JtQ2IrVFRac09UUlZKeFFmOUJ6VXZOWFhYZnl3T1FD?=
 =?utf-8?B?akhIa3NmbkFmN1A5aEZtTHQrMXNVazZTS2lsVDk0VC9RSmNjeWk5Ymp2WHNC?=
 =?utf-8?B?cUZENzdKYzJEVTFuMkVuUTJWM0g5RDRtbDZ6NG9RQmpZUkxxWDhmNmtNdldC?=
 =?utf-8?B?UStqdnRFKzJPM1lpVGtGQ2FEVjBkVFdNVldDWVlVejZPWlJsbTFHa3pqdCtQ?=
 =?utf-8?B?cTFkT2xnU1pFSTJtVnZpMm5ORnhNUzYxSEVTaS9ib016SlE2blAwMFdwNWRz?=
 =?utf-8?B?NXVDRnR5cFRvUzN0YWxuWnRJZkFRaDBtR1hGclpuc1pTZ1hUQmpQZkREUEh3?=
 =?utf-8?B?RFUyOVFBU1NYVXpwdVBNTkxiYnJNdUJSMGw2d2krbnQ4V2Q0VFM3eHNZcVBD?=
 =?utf-8?B?SWx3OWVCTlAxWjl4cHp3MU9pZFQ1WE0wMU9XZHEwZkY4a2RSWHJKVXZxMkdm?=
 =?utf-8?B?bGRib3ZnUXdGd250UGwveHkzTUNjNjUxelVpekRQYTlmOEZtaWRkQW9BZW1r?=
 =?utf-8?B?R1E4WWQ0MERybk0wOUp3UjRvSzVLVHMyZW5kU2VBRWgwcFVUYXdwY20vVUhU?=
 =?utf-8?B?TlZ0L3B1cUVjaFFNTTJ6L1BlRy81TVlnMEYzTk5oOFFtMVFURXBMZm9ZbFZj?=
 =?utf-8?B?Y0ZXcXhyb0RQUFBUL0tMbHJxRVRENEFCMEQwbHM5eWh3NDI5REtvNzU1MEVC?=
 =?utf-8?B?NG8vTU03RWVqOHdaTTR3TkUyZXBSUjdjTlpQbmRjUnpucmpwdk83bmdjNk1F?=
 =?utf-8?B?Z1pXR1ZuakVXQW5UUHFxbk1hcVM0OHFIMytBczQ0RlR6RHp0S2crb0gvTFNy?=
 =?utf-8?B?aWU5dVlzeE84Q1FVc1ZmYjhMVmhjVkRoRkZIek9hUnkyb2h0cTRWN3htMVFB?=
 =?utf-8?B?YktHb0s4WUVobkpYcldmak9OdURTMllIYmhOeCtYYTc4WEwvL3owMGZFRm13?=
 =?utf-8?B?SXRieVRoM0czWUQ5WUIyRE5yc1VMK3VIanJCRTF1VU9FWTBrK3puMHNJQUxI?=
 =?utf-8?B?dmdhUU9BejhpWStZbk43QllwRFhKMndrOTdvSlVjMU5paXlXKzVrWkw2dm9J?=
 =?utf-8?B?RTJ1OVZiM3R0cU9EMTY2VHBjdzkvaC80eVNsUkZ5ckU4WmFZWDZnc0lJUFRW?=
 =?utf-8?B?N2t4ZHo4bHQza2NZaWRReVRjTTl2ayt0cmZmV0Mrc1VwKzJ1OEVGNlYrSXVK?=
 =?utf-8?B?a1dGaCtpZ3AxOTR6TVhPRSt1dytkT1NyMmhiSllGbEJIRWE1WEYyalJTUW5t?=
 =?utf-8?B?UmszcDU2MnljNldNRXI4SU1LdXU0TVFjbVhhNlFXamUwakp0UXV1cS9XaVhp?=
 =?utf-8?B?dG1UM3FQanVqajJnYlV0S0R3T3JZdkxLYUFja3dDVzVOSFdQQU82SHpOR1h1?=
 =?utf-8?B?Q2ptTXhDd2JsRFBJdDdVLzkwcVROZExzODVTWU0rN2lvUTZrUmxiaUhBdWZl?=
 =?utf-8?Q?Tu3Mw4URxiOBxhkwdE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EUA5Xe4MoibYv03a+amSHrfhsTKrViyFg153rOrAdf8Gv/643B8O9Oc0ZkbKuoN3e+EXfXOWQIADdkR0xn1WIzpgQb4GQhW/U/drHyz8BKOdcQTWJ0Ttv42F6570D5mdhxqeG85qLLQTIO6Lm0AzzHNktv0tkzEUxRFqZuHlsklqfFT2mF4Zb+mRA9yIRvfJBG2sKRhwf8geYI/is8kPiinVf8KQ6ZOPq+dYLU5kxSW8j617En7dxwiEakZa3voENhld++ExgDi1gl4xIPSFb/DcxUviDlrXvglpBimlv+SUgOI2cCtPZJdAByOVyVtBjm98X/0FRyY6WCFFW/qsuA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e151d276-3ab2-4832-0a84-08de8987d4b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 09:29:21.4376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pLafpGmQhlMRenUnW4KvkpLAAltRs7vTR06/1GaeNtyTjEM/uH7wn/DyfiF4KuQW1AppXL2SPy9Cw+cbn9zL+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4486
X-Proofpoint-ORIG-GUID: qLTmnyjGk65K4gHZU6UqBVYsQdqMf4T1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA3NSBTYWx0ZWRfXwitWs9JEFvnX
 yY63B5KV3Gwxl3Ukxmu/brokBLqi0ZORzeFkg7JWToi/gCSMV8mw4P7gafVy+Resh+WJIziHD6z
 YJYu+E+NEJQOStcxYM3ZuxTYvl9XppPargVRmPghbdGla5akIyZCIR8VRNzkSw9AiPsMKgO4i0t
 JGTxejwMug1sKKo2EcemAwMbpywRlj9VsCrYAEIh85P1iRm+k0bNj4ruWRY4eEQ7JG7Kzu7dtCP
 Pb8r9rMk5e+y0UnykARvS7L058XrMhlfIEB98v7IITKaB1vRV4QqD45sPrXgSHWp5chtyT+VqKP
 d4rllGhr4/8g+8Edf15Fa9LMcVKYdFxrr0eClRhKhg8qxuK7cJEQv5H4x/sjrP75xUBg1JpKuPp
 tOsWg2zqI03YVZRym9zn6G0aNE/lIfGxJsydGFTX2qi7qvsdQ3yxnhhSbC9aAuc8T7s8PuVM520
 AvaIDTWMzF673E1uIrA==
X-Authority-Analysis: v=2.4 cv=Ed7FgfmC c=1 sm=1 tr=0 ts=69c25974 cx=c_pps
 a=upY0ag0bgN/A4kti6igY/A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=QyXUC8HyAAAA:8
 a=HgGmKiV7Z3-eT0Dxn_UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qLTmnyjGk65K4gHZU6UqBVYsQdqMf4T1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
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

PiBRQVQgSFcgcm91bmRzIHRoZSBvdXRwdXQgYnVmZmVyIHNpemUgdXAgdG8gdGhlIG5leHQgc3Vw
cG9ydGVkIHNpemUsDQo+IGJ1dCByZXN1bHQubGVuZ3RoIHdhcyBzZXQgdG8gYWxnX2J5dGVzaXpl
IGluc3RlYWQgb2Ygbi5sZW5ndGgsIGNhdXNpbmcNCj4gcmVzdWx0IGNvbXBhcmlzb25zIHRvIHJl
YWQgcGFzdCB0aGUgZW5kIG9mIHRoZSBleHBlY3RlZCB2YWx1ZS4NCj4gDQo+IEFkZGl0aW9uYWxs
eSwgd2hlbiBhIG1vZHVsdXMgaGFzIGEgbGVhZGluZyB6ZXJvIHBhZGRpbmcgYnl0ZSwgUUFUIEhX
DQo+IHN0cmlwcyBpdCBmcm9tIHRoZSByZXN1bHQgYnV0IHdlIG5ldmVyIHN0cmlwIGl0IGZyb20g
dGhlIGV4cGVjdGVkIHJlc3VsdCwNCj4gc28gdGhlIGNvbXBhcmUgZmFpbHMuIEZpeCB2ZXJpZnlf
bW9kZXhwKCkgYW5kIHZlcmlmeV9tb2RpbnYoKSB0byBza2lwDQo+IGxlYWRpbmcgemVybyBieXRl
cyBpbiB0aGUgcmVzdWx0IGJlZm9yZSBjb21wYXJpc29uLg0KPiANCj4gRml4ZXM6IDA2NGVmMWIw
OThkMSAoInRlc3QvY3J5cHRvOiByZW1vdmUgUE1ELXNwZWNpZmljIGFzeW0gdGVzdCBzdWl0ZXMi
KQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogRW1tYSBGaW5uIDxlbW1hLmZpbm5AaW50ZWwuY29tPg0K
QXBwbGllZCB0byBkcGRrLW5leHQtY3J5cHRvDQpUaGFua3MuDQo=
