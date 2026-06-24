Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D2BCDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 20:04:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D4814027C;
	Wed, 24 Jun 2026 22:04:28 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2FB9B40279
 for <dev@dpdk.org>; Wed, 24 Jun 2026 22:04:27 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OJlvfL3220720; Wed, 24 Jun 2026 13:04:26 -0700
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022084.outbound.protection.outlook.com [52.101.53.84])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f03u9keuk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 13:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZvriM2nn0FpiDlRX4RqBPR09zIdfuDCL0uEZTPcmTF/F4NkyQlxz4VDIOyZkqNVRvpvSoOvftVROBtwp6G+ZG1S8PzNhBL0RhsvUuVBWkFDH9D0xLeVRNTnLaq4wC24WGX7eKql5l2HhE8qnMBhd7MdpO1UQqVqdgsKzIhC6DBDdObCPBRgucDLzUt5JqcUinLHlteM1vFUas6rNNnNsJkpeCwYvpqUl+tHg4jSjb5KcwcOaFGr7hZdJfY1YXj/TX4FzorWkjnfZ87oa8W4twiJqN6BLcwvLjlmzDEd9J+j2eFPASgyJIuEsVrNGlPKvl1IKxRPey62q06yfmtWj+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avErNcEXVEIoH2N8dzaPye4ISx4u4nBeG79BJr990z8=;
 b=khzANnUzyhHIw62eIAsw9Q2xn7WCaNGn75KU6DqmcMM9DGnmwaGJFWtT1/NKYyU9ZBwqDSB5ZvQKfRwUu6fAnteE3rV89SbolVr7aonT6Hn6qRu/AaFZCDmqQoeHSSpOEFFBrm1yRRbw3t3ARYrgUaAqtOqJdGsGtDK7wsBVPaq2m4fj0adYr4SPG2YCdf1d66ObJk59byjbwtDHLdUrPiJ5FjipYiJlv+/vexyZHRzy3zHr/4V4uoRYJuc+lquol7pDvJTBV5PQ8vs/ilQ+xo0reTlPcYSKRb/QI7uRDPsUxyrbzw0M2sKJMfZljvDoH/Cgoshr3WstmgbA6ko2TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avErNcEXVEIoH2N8dzaPye4ISx4u4nBeG79BJr990z8=;
 b=QU9B5B3zSpnZECdcmVkQjs0vwjXgIEQd2+85skJ8O/omSt/DpEYonUTZYDMyO7BjHZWTPLPzmPgSnb5B4ie6JmJly2JcB1tsFPWaKxdpyVJqrED1MCHECr9GunShb0IwbjMQZg/xkAL9KBsC39eRv3Dpm5CREYbd3nRte16EL48=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 BN9PR18MB4202.namprd18.prod.outlook.com (2603:10b6:408:137::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Wed, 24 Jun
 2026 20:04:22 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0159.007; Wed, 24 Jun 2026
 20:04:22 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Emma Finn <emma.finn@intel.com>, Kai Ji <kai.ji@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [v3] crypto/qat: require IPsec MB for HMAC precomputes
Thread-Topic: [EXTERNAL] [v3] crypto/qat: require IPsec MB for HMAC precomputes
Thread-Index: AQHdAhy56Hbp+brCjUqsKLObXfrff7ZOJN1g
Date: Wed, 24 Jun 2026 20:04:22 +0000
Message-ID: <CO6PR18MB4484479022C9D2E2AEF13363D8ED2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260619135330.1821985-1-emma.finn@intel.com>
 <20260622075651.1980461-1-emma.finn@intel.com>
In-Reply-To: <20260622075651.1980461-1-emma.finn@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|BN9PR18MB4202:EE_
x-ms-office365-filtering-correlation-id: 2316dee0-de42-43cd-717a-08ded22bc896
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|38070700021|18002099003|22082099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: pKeJ74SMtThv/CfiT+kQGZM8UOp8pLnalZCzYbz8dkgGhLMTT68WEcuMCTl2IIqyOJFA1f74IZqrNFdRWAid1Kh6xXh9LN2KxCCq5Px0SjnNil7T3+0qEhEBXxU3/S6I19vghuyS2YgwLRPHOa84QMrAfMBwYdkNvYLAkauB2NOQRR3OY8EoBwY0wWTSlPaeLAH8BTAzwP9SpLQ68N7ybdhb+jWtfUcK14UPqOCl/x+FwH1csSjlVNjEXtaslwQaPC0Gc3bMHOVDaMaLHmyXpXkiJ5bO6ND/FLM494Z4ebAhHUOHXYMbLtWmCGm48cHOF14ne1P0A3nf53ebZSjdagQsPTXKxd4AZl9EaXJh+J+KxuysuZZBYPSjcDBx401Vk5n5/KE1UjxnuCo/d4zuNemtJnyt09au8OKuzLmEG+wRVSjn3xjgX87QIWNNYTYIKQlja2cw2SzMnzrT/oXV2O0t+bKRyASxbvtc+Rav0pkJx+e1Vm4jQi6FUbo10fdXwdbXgm4+2Bzh56doDQMettpUK49jkeszC24mZo5jl7Kvp9vPiMGfuuaQlBaig2LiRHdTSWheTW48REEoQ0c31nAtNfCCDL8VdSFRyWKFGwkWDtqsXgeSl8jJGsL+GMPUP2v6ppj+qIoWsuVatTVYmX6KGyow/4kfnq8BmX7woXe2odmyWILckLLijRZkbyvXFKMUIt+sQq1IMUW0W32tTzTLsU/wQBbHuNs5zfELMjw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmxxMGlFZzJrbUl5bGw4MVJ5SU4rREc0bCs4UDNsekNITVViRUlOdXREeHkz?=
 =?utf-8?B?L1I2aXBoZXhlc1ErbjZWLzhqMWw0NWZ6TUhwMHFEZWpKV2dLaVJ2WUFvN29U?=
 =?utf-8?B?dXNSUklnd2ZoZU54VUJNUXl1UzJzNzlRSGZ1bnh6QnlDNVdFV1A3MVlXenJj?=
 =?utf-8?B?VHZyVEw0dWRGVzRTeUhNN3U5TVJ3R3lUb1VLUXVnR1dyL3RuVDJIdlY0T3lT?=
 =?utf-8?B?eHM0aHYrKytuVml5MTBEUXBWVnlXLzJHMHB6TTg3dVB2ZDZBbUdGNzRXdGcx?=
 =?utf-8?B?RmN5aVdyL1R0MkRmcVRmalpIeE56aHhWVHhHZFRvZUVaS0lIVzA4S0tyUHdi?=
 =?utf-8?B?cmpFcU03Y3YxRE9zUU1PQ1Bic2RPMlU2Y0FOR0NJTXRrd09CclRuK25HOXZv?=
 =?utf-8?B?WWl3ZnZRTThxbFRvREFKTEJSQngyQ0R5SDNic2dpVDBZT21aS2RheVEySXE3?=
 =?utf-8?B?TlM5and5S29lM0FieVl1VjYvZHNnU3hjampVQ043SXJMZDhQeFAwQkY5UUxm?=
 =?utf-8?B?eG83RTR5dlplVE1JcXlDYWtCdnQzbTlRc2hUME5UbFJOcXVwRnpJTkk4SVU3?=
 =?utf-8?B?ODlBQUxLWk1QdEVNbnNZNnExaGlyd1VveEtOcHc3MUxHT2RvWTdzQjlGY3Bt?=
 =?utf-8?B?MXRpQzN0N29NRi9EOHllYzh5YUY0V0RnMGs3bVo1QjhuM3M4QjZVM2c1NTJF?=
 =?utf-8?B?WmRjT0xGZzM5aFJJQ0N2MzUwWEU0UVdyd3FMWWlnT1l3TXBLS0R5Q2IvbEl0?=
 =?utf-8?B?dmxaSmVNOEZFUnBYc2N1K2ltc3ZGWWUxMXBKbERrelB1MHdUU0pQMTkxL2Zq?=
 =?utf-8?B?N1BqazRKdDJoNHJJZHdsaFZJTEs3YldBQjVzcmlHOGIvZ0tCZXMrRUJIZTNB?=
 =?utf-8?B?OHh6K0p2dTlZMWFBOEhtcFpES2h3SzR6cjlPOVNFY2J5bDYvbVRQUW80Y2M0?=
 =?utf-8?B?Z3h6S29maWJqRG9RVU5hbXpLc29oemxKZ2gyR0Vlb3VROXJhTUdRd1dSQjI2?=
 =?utf-8?B?OXRvZGtreW95bTBaQUpHb2MwemFYQ1lJODFrRElPOTRjcUxITStzUlg2cjN5?=
 =?utf-8?B?aFVmUnJhdWQ4bEtvN3lxQS9SR1owOWJDRG4wSWhGRjQvOEpTVUIzNGlGRWRT?=
 =?utf-8?B?YzlIREhjaWo3SUxNdlNLTTdqdVpKSEltY1Fnd2VQMHpFYU1KckZHdWNNc25S?=
 =?utf-8?B?SENNUHk1UFFuY1ovTkN4VFhPSmp0VUlOMGc5RHc5dmpNcTR5OEpkR2d6OVFq?=
 =?utf-8?B?Q1Q2RjFYczBsNzVnRzMwNG05L1JacUNteFpmeGdXQW9jMkZwOFBzK3RsUlQ4?=
 =?utf-8?B?MGhaN3BQR1FkOWIrdS9oVmRYSzRzdXUyNnoyT0VocXVJcTF0ZFFNblpxVmZM?=
 =?utf-8?B?NkxEZjZ3di80VUhRQWZ6VDdpckUxZldaWkUzRUZHanZ1QmkyTVRiNzZURGdo?=
 =?utf-8?B?eEY1eXpQRDBxSjVYUXNCTyttdkRhZjdRRmc4eWhYeVRZK1dBdGp5ZWtFV3NH?=
 =?utf-8?B?VW5RWUptNzQ3SXk2Wmx0Z0E4NWdXbHAzZHUwLzZGcjBvaFVzQzFuM0kzWFJR?=
 =?utf-8?B?L0F0U1ppRFZyeHpUbmMxMlZOc0xienY3ay9JUmVMRnJ3TFV5RC8yYlgxTUlo?=
 =?utf-8?B?SWpLejhIcFhlRm5YVXp0SWlmM1REQVlHVVNIMkx6TGRQK0lObWlhRUtVZzFz?=
 =?utf-8?B?ejJ1OW0wUmc4ei9UVzVDTUV1Rk1wNUJ2WXo3aXZXeXpoOG5aaUFycmljOEFq?=
 =?utf-8?B?ZS9CaVZYd0haTlZqTjJrSS9nRjBFbUJpb1VMQXVOQ2w5OVg1b3kyR0htTm9Y?=
 =?utf-8?B?Q0V4NDBla3FuTWUzNHVDL2ZjdEFZd3BEOEhmY2FVYWpJdnh3c3RJRUZPcDB6?=
 =?utf-8?B?OWxZOTVabEdzVWMwdnR5UE9Ecm5EakdNRVd1R1AzQ05iYU93Ynp0L1IzTXRv?=
 =?utf-8?B?RWdIOS8zZUJ4VFVSVi9SakhnZlV0dTZKRCtzVTNYSUFDMlRtZmI5WHpXektt?=
 =?utf-8?B?TjlmWDNFTk9TK1NZdDZZQnJhWm9mUEY4akJCNy9vdzhqUGhOU01OaWtCU01D?=
 =?utf-8?B?aytDZEx0aXRCYkp2YWxNcFZ4RzVtRmJFbnN0YkFGOTdtc1NDbVNXQWZ4Q2F4?=
 =?utf-8?B?b1JrRWVmTVV6d3BmeUhYZEFDRUJMRUc5Q2Y5a2ZZT01jcjhCek1HajdUM0Uw?=
 =?utf-8?B?YVhFUFAra1JBcElDWGJSc0xKVjNtZ3REYXFOVFBFcS9qeFJWU252VnhEajB6?=
 =?utf-8?B?WCtIRG9nR1Z1d3BCdVJnMUhOSWU4dGhBYVprS0hiV1pTSm1VdXE0cTBLODlh?=
 =?utf-8?Q?6SjwGxVXwV6MX/OSVy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hfYVQVrLNGEc0WJClyaB/volTH6S/oYWvZErnqhJc23Wzxr1IdHdaHQTKk3fFNEkxjkzx8SLsGXKxROk8KKTqzptF3XP3q8wMh6Yl5oHVRsFbZWmt8vehx4EgYss/Bap+otzAO1tgKuYfTLB/xqdu3B7sflS5n3RTfTx/JgMCkstvTg7xGygH5Kff0OhxFRBsiMsnEXFjUjHFW44OCU32r/rIIhJdWWd8z7QQcY5CqRzduphvE6aPxh0g52OmlMgJciqBBaifhkBwtK+4bszGRCQiSnHX3OrUxffu6XrnNOoGWr9ahJidQmCgs79mPW5eHKdlsWfUuawUc3f3x9oHw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2316dee0-de42-43cd-717a-08ded22bc896
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 20:04:22.3688 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EiNrGbzJIMxRqxSyFDHIokHMOv0fZ6u+h2tUx20+AlzK/5tS6BQkSjA/xFILgQ12Zpb8AQbIUKmOqu5ap0Kkaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4202
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE2NyBTYWx0ZWRfX1iKw8lyQgVxg
 ks8YXBsutpA0MjDL/Z/igT9Q8dQkunzcsXTe2yzpZEp7prZVeiPot86t71uUslVnthWTaD31hyE
 sGK0b/M1DbmwHf83bTUWyKf5Qp+lQf1B4TWxrGrsoSZr6yUS5+ItvszRSmmNG6z9yEhM0dV5QVT
 RxG4RrrTaU22o76c8lRic/YtaGLRvvLOkER7H2EtGTZcGu12ITWfqWIM6KYf95pneChwQjj87Pd
 ddqAEi/G36mvke9vyTIYkQZCw3GgORUhvV5KaCBXbUoEjOMaXIqa2m3Mj1ryZ2ulh4ULGDdBnhI
 bRzDA5AiIPIUbHq7r9uw9/85tPMvqgJOs+qKtS2ujmV69fslkdAY62nR16xWCs7UhxSYueWQn/R
 p4EaYFOCvuFhMA71tAqDac7gUPHyAA==
X-Proofpoint-GUID: xtAYRKS4F_9ZHW2ODogJMdz-cvxME8VX
X-Proofpoint-ORIG-GUID: xtAYRKS4F_9ZHW2ODogJMdz-cvxME8VX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE2NyBTYWx0ZWRfX6W2ytPxoeqAg
 6dybuqErzU/Gu6edRZeG+RKivzRZ1A45yM7IqULzt2MlC+LX8qEC8lhl4ClQRErebNfhmrcLonh
 B3yhG0H+ekFg86Vr4qtYDaQiZMwzXJ4=
X-Authority-Analysis: v=2.4 cv=LMdWhpW9 c=1 sm=1 tr=0 ts=6a3c3848 cx=c_pps
 a=BojASg16tjKL+eL2GW4eig==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=QyXUC8HyAAAA:8
 a=KMz66D2mAbCe4UXvlT8A:9 a=QEXdDO2ut3YA:10 a=0lgtpPvCYYIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
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

PiBJUHNlYyBNQiBsaWJyYXJ5ICh2MS40LjArKSBpcyBub3cgcmVxdWlyZWQgZm9yIEhNQUMgcHJl
Y29tcHV0ZXMgYXMNCj4gT3BlblNTTCAzLjAgcmVtb3ZlZCBTSEEqX1RyYW5zZm9ybSBBUElzLiBP
cGVuU1NMIHJlbWFpbnMgb3B0aW9uYWwNCj4gZm9yIERPQ1NJUyBCUEkgY2lwaGVyIGZhbGxiYWNr
IHZpYSBFVlAgQVBJLg0KPiANCj4gT24geDg2OiBJUHNlYyBNQiByZXF1aXJlZCwgT3BlblNTTCBv
cHRpb25hbCAoRE9DU0lTIGZhbGxiYWNrKQ0KPiBPbiBBUk06IElQc2VjIE1CIHJlcXVpcmVkLCBP
cGVuU1NMIHJlcXVpcmVkIChET0NTSVMgc3VwcG9ydCkNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEVt
bWEgRmlubiA8ZW1tYS5maW5uQGludGVsLmNvbT4NCj4gLS0tDQo+IHYyOg0KPiAqIEZpeCByZXNv
dXJjZSBsZWFrIGluIG9zc2xfbGVnYWN5X3Byb3ZpZGVyX2xvYWQoKQ0KPiAqIEFkZGVkIHJlbGVh
c2Ugbm90ZQ0KPiB2MzoNCj4gKiBSZW1vdmVkIGNoZWNrcyBmb3Igb3BlbnNzbCA8PSAzLjANCj4g
LS0tDQo+ICBkb2MvZ3VpZGVzL2NyeXB0b2RldnMvcWF0LnJzdCAgICAgICAgICB8ICAyOCArLQ0K
PiAgZG9jL2d1aWRlcy9yZWxfbm90ZXMvcmVsZWFzZV8yNl8wNy5yc3QgfCAgIDggKw0KPiAgZHJp
dmVycy9jb21tb24vcWF0L21lc29uLmJ1aWxkICAgICAgICAgfCAgNTYgKystLQ0KPiAgZHJpdmVy
cy9jcnlwdG8vcWF0L3FhdF9zeW1fc2Vzc2lvbi5jICAgfCA0NDggKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiAgNCBmaWxlcyBjaGFuZ2VkLCA5NyBpbnNlcnRpb25zKCspLCA0NDMgZGVsZXRp
b25zKC0pDQpBcHBsaWVkIHRvIGRwZGstbmV4dC1jcnlwdG8NCg==
