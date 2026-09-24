Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A56BC9830E
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 11:24:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2ABB5402F2;
	Thu, 24 Sep 2026 13:24:12 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011008.outbound.protection.outlook.com [40.107.130.8])
 by mails.dpdk.org (Postfix) with ESMTP id F4021400D7
 for <dev@dpdk.org>; Thu, 24 Sep 2026 13:24:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULbB8QYfGlVH3IvrVjEk5NMUyDSUl96zqSXVoKq7vYU5Bi3JrlJduDp6p98bAWlJ2RJgF6+9W4zWpC0Oa5M9qN3MdUJsXJDmdj5WqabQ84KPA0/emtXWrJGuiu+xYPySGTbu7J99Yr8/d2EeBaKOScHaJX1YREkvyAaTq5RUBYegkeWKZPDri77HOZ+/PG+fUvrv3bv36wgOUJXQyimvtyAUIUMOvNj0hhdwY/GseDu8yQtDnBVoUsP2r9FkU+2mv9hBJ8PDrxhXY8V6/Rm/v1tkViAm45J+DFGiuV+q0oG3K50CiqKkpHpi/Zl4rek/F5AljSFqrmPmHMvaf8oGKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTCAn/aFyVY1meWxfI+g6WsBHbkSGUTOkbF3SYd4N48=;
 b=ZYCevZ00c9OUxI8PN5NWdrX7DOB64/JB6KUI5nVQIMUoauwaYrP6KcY1JG7FSYYFXiNFrhPYLwzjgNBRqxw7WHyw4TXq6tqYh1cIN6F4mdI8ld2riemwJWxReepb8s6fR1L46eIzdaSU5t+HvDK+HE8+olJYozuNnSvjuAoW1oaHTZgE4dm5e3UYixxcvG1D26KX6AulDpqkbMUBN62mm4ttu6ELLxxwnIoK/GC2jra9NnKQX6ziYUETjRzrLe3FTxFKddBfNLKTjp+H1lXNGJWCTwaOQJSQk7Z7+QDyPR37/Gvf7NTGcF5KbXS4TRzbxVtrWGJun+Hn0F0NAGyhWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTCAn/aFyVY1meWxfI+g6WsBHbkSGUTOkbF3SYd4N48=;
 b=EZGvXudNchXxvDZFJFAg6Gb723VKwkBNR4bE3Zt9M9TlXhNbXAS/XiDo7LlO4RVRWaVbmx8DGZ+xG9DmpqwkY3r3suYzNcmNOP9d0IvnWsPrvUtZiKptJHbsenew/Ljw8bNkdDQ5+flhKIVbrOdf0RNml2eTh56bA6I6L5OUYjzbJyDyamCFnR0JZ7B4nqwVrxss0eyRMGxzVJmtnjwlk/oxCm36h0CdBZ0Ae4T0EJBvWFLSU2J+OHzacabEFz2Bmh018pGKhySU4fCuFDE7YThMoKgzKHEyUqdBwpqqHP2rSIFj1O0rTo26F72NctxCu6XGXOstnO1DhcmS9Jqp1Q==
Received: from PA4PR07MB7280.eurprd07.prod.outlook.com (2603:10a6:102:f6::14)
 by PA1PR07MB10463.eurprd07.prod.outlook.com (2603:10a6:102:4f6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 11:24:08 +0000
Received: from PA4PR07MB7280.eurprd07.prod.outlook.com
 ([fe80::e42d:d4f5:1b1a:68e8]) by PA4PR07MB7280.eurprd07.prod.outlook.com
 ([fe80::e42d:d4f5:1b1a:68e8%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 11:24:08 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Arthur Chan <arthur.chan@adalogics.com>
Subject: RE: [PATCH 0/7] net/memif: validate input from connecting peer
Thread-Topic: [PATCH 0/7] net/memif: validate input from connecting peer
Thread-Index: AQHdSspp9AnWsoXwEkeyXyUwHnOQcrbdmC4A
Date: Thu, 24 Sep 2026 11:24:08 +0000
Message-ID: <PA4PR07MB72807B6698334B7CCFBA3A4190812@PA4PR07MB7280.eurprd07.prod.outlook.com>
References: <20260922194138.508919-1-stephen@networkplumber.org>
In-Reply-To: <20260922194138.508919-1-stephen@networkplumber.org>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB7280:EE_|PA1PR07MB10463:EE_
x-ms-office365-filtering-correlation-id: b68a656b-d84a-4249-4379-08df1a2e598e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10070799003|10067099003|56012099006|11063799006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: +dXJ0FvPAtIt2zZte1Dj414kI89cUBUB+pRT1UuTYyjLKr9Y7wQeUdWlYJtyMPr8MI9pbq1Re30bK9Ko+PfFsQggCdQ75JWdH6iY8NZDNANkUdurbdxTcb1dmWCWA9xuGYjlQhEzgvNFq6rBpm15uYONilqgVkNy+abz1RYvPSWtD7VnuX0q2LuxZpuRo2Hpm6nBzmtq6oTjbXAIcAPOFGzcxTc0t0WBWDS/jThEQoqTzbc4M8hz0dj8j9cY5pJfkD7ml2VKsjK9CBBhu690KjQoeqR8pamiOJ4VAyZUJJx4lMvRgeRlsSdy+iqKnQjeAY6ESuX0hJx2qVY7/zIBkLJgBPy/AKH9/2qQKRj3hrEh3gECkBdfWkZZvFG0K8jS6Xr9BKhwZzTIEnXL6CfvB+SoADzfFxtq1+cQkTXs4OoNlUh393NYu2aNjWo8CxvRdrOgOzF5vNa2sopiLVsVh8k6LoCXE4OclPfgTO3GfNW2+FVnY2X/bp8sIcji0Nv8K5XlFEHKE1Y83EYctnjLW28a0LRRoXLNRftkEBl93jkXB4qoHAXMCFm8mlQGKH+EjtYC7vZPlwKNtofAizck7kZEjEJtqViX9bPm5l66r5hVPX1PiDow3HRaxp2+ep2uvdrj4WxEy9k2jR3yo35ZB3+re+CxctbpSmMnxC0H4wmBxYYgmRJ55dr/0SMDYM1w15T6e0oWZIOQL2G4jmGvlRPMp3Fk2Y+uYVOLrr12GVo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR07MB7280.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10070799003)(10067099003)(56012099006)(11063799006)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1FiUWVHUUg0VGxGWEc1VGs1aTB6d2VWOStTck5VK1dTbXVpMFVDTzFPTDBq?=
 =?utf-8?B?YzlDcURpRW9kYS8zWTlUMHJzQXAxbmQzd2NCZjVKZm9GUWc4ZDN3eTJWUjdq?=
 =?utf-8?B?ay9aek4yR1NmRzRhQm5sMHNUUWE0UHdNOEsreFEyelQ0UEZtc2lNVVQrY0Mx?=
 =?utf-8?B?Vm1SY3MwcmNMbGJmMVBNMkJJaC9iMzhxRDJPR3lSVGhaU2VxRVBueEUrdm5G?=
 =?utf-8?B?TnI1ZWpJUW4remkrWnlDa2s4SWFpbmQ2L3g2aTRFa1ZBRmc3aFViZ1ZrcEpz?=
 =?utf-8?B?TUI1b0NvT2dSMGh5c052VmtyL1J1MHFlVXA3T2xBdnJOYVpacUp2YnZpL0o0?=
 =?utf-8?B?T0pFSURjMWswV09XakwrV3dEdkxkVUZyK080TXd5d0lIUVRCNFFJYnpUY1Uv?=
 =?utf-8?B?K0FlZ21lZ1d4eis5SXJJN0NESnozbGl2YS94WFZ3enltNXRBVVJrdHBnU2ZE?=
 =?utf-8?B?MUhHRDQ2YnZURExGaFRkR1NIZml1SXFxbkIxMkp4TXVuVVdWRjFhN2s4ZGhO?=
 =?utf-8?B?KzFuY2lGUWJuMm93bjZrblUwSzRCM0FiSWxKMXkxQXRHQkxCVkpqYmpUcUUy?=
 =?utf-8?B?V0FjcVdHUUQ1YlgvNXh6VmlrcjhGZG02NkUzcnlXOUd1Uk1jSG02b1I4TTRG?=
 =?utf-8?B?Q25ZQmdadU5sZjloREtRNEdaSk1yUVBQNTJIR21mb2N2bVF6YkpKeUI4cHlU?=
 =?utf-8?B?M1dDUHhWdnkyK3VKMW1rNStzbC9hTW5ML2VkVXNjbnFRbDVDaGJVL2dUaDI2?=
 =?utf-8?B?RFd4ZXNrUkpRVWp6RHFvcEtoemNRcnVMNUNRR2d1SUI3U3lmaDhTb1I4Tzhp?=
 =?utf-8?B?WGJDb3dOUFN1MDRpVlQrL2g5ZnlieXlCK3k5cnZhbGgxRDBJQk52bXo0bU1m?=
 =?utf-8?B?TVo3a0l4ZDNkcDQ3STl6MlRGSVZKU0VEZXJMbVY4dTdpcklpQ0xId0h3VUZL?=
 =?utf-8?B?ZmxKMnBlM1d0Yi9SOWlicU12clZsWVl6UDE2RmtYblpRY3V2M2kxNFovbUE5?=
 =?utf-8?B?bldKbVhtZ0w2c1BMYWZnMHp4Tnc5aXAvV3V6WUM1c1MwL3l0TEIxbkRRTGs2?=
 =?utf-8?B?RlFibHZxMGhrNjJSaE5jT01xZVNydDkxb3hwbWlSelFXTjlveHR0UzZ0L09Q?=
 =?utf-8?B?a0x4SFlCQUhQZ3RLVDQwQU5FMEVaS0dkWnhPaC9ORnBGUWhLZ3cxN05BOFpq?=
 =?utf-8?B?dVVJZEpOV3pDOFlNUVFTOXpVZ0dZaWRVM0VKVm1LVk9pdFJCQjlQc0tOamhD?=
 =?utf-8?B?U1JYdmplSDI0SDhUdnE4SWhLUW9Ha1kzTGNiaVB2dklONTBYSEpRZkhKMmRt?=
 =?utf-8?B?YzQ0MWdXT1BjV1o1U3d2eUVWSDFyK2dpMXdKbEVwem5HTTkvM0luMC9LQVBO?=
 =?utf-8?B?UTBxQ0FDU3Jtc3k2U2lRczhyeS95MmJZOUFpVFFqeG5DOFpuRWU3MzhLSDRH?=
 =?utf-8?B?anppc0Zuakk1aXlqem9FRUE0WC9LVElNMlA4aU85aW5JVXpEQVpOZkJEc2c1?=
 =?utf-8?B?ODkzcHlJaDZwMFlnNzlBUFNaZ0tqdndONkZEWk5nRzV2aFZudzhiWk90YlpK?=
 =?utf-8?B?OVpNWVJIQlF2SUQyK3l3YUJCdktRWTVRM0d2bWhmeUQ1QlFlNEZzSG12TTVL?=
 =?utf-8?B?TW9jYlhPbXgwZ2RxbDdFblhlUm5zNlVVWTRvU3lUK2hmblZ6L1Izam8xQVJt?=
 =?utf-8?B?MU5SUWNUaWZpRXFmM2lqQzN1M0tRTG1QY2RUeTJVY2JZRFEyU2F5a2ZkNnMv?=
 =?utf-8?B?anBNSmRiQ0FuVXF3TEFQTnNrb1hCMnpjcjlwRGhaWFNaRzJ6VnNZK3QvNy9P?=
 =?utf-8?B?V0NkRmlZRWcyeGNpbDk1dDU2VEt5NWhWVjU5Kzd5Y1BiYndFc1ZyUDY0M0tP?=
 =?utf-8?B?MUgzbGc3b01Rd1lhcFR4OHVKODQrZkloN0YrSlRyRXloOWVNTDRkNktSdjll?=
 =?utf-8?B?cTVEelpsanhzcnNpMDY1QmNhS0IyOFE5V2s0S2gxZG5mb0x1L2c1dWZpbFc1?=
 =?utf-8?B?OHJxMjIwbktRQ1JHcDd3L25TM3NhTnE5Y2FoYXI0eUhySCs4QTNBR0JFcUIw?=
 =?utf-8?B?eG9ObTY4QVdJVXl3VU9Ca2tFUk43K3hmQVFHWG5OSXlXWCszbHFSZGlVa1RC?=
 =?utf-8?B?Q3lUZVdLdytEVjVaUFZGZFNvT3FENTRjd2p4YzJHNWxMN1VqZ0JONXBPa01y?=
 =?utf-8?B?cnAxdWROd0lkendOZjdvLzEwUkVhMmVJMlRhVXh3MStVd3k4eTkvU3dMM3hr?=
 =?utf-8?B?Zlh3T3VsNHI0YUMzL3RVVDRibUVnbnlCUThoNDJ3bk5GVTl2aFR5VHp3VW1J?=
 =?utf-8?B?azNqOU9WbHVBU0k2REZCL2dLbDZhL2VMQ2NPa01WcDNjMUJBOFp3d2w3Zi9I?=
 =?utf-8?Q?1UK2lrOfV8zg/d3vkWUcIMb+RgKokutAlsRp1/z9L9u3q?=
x-ms-exchange-antispam-messagedata-1: sddL0hg6XEO+pvncXqfmn95JDo5Pfa6aLEQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB7280.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68a656b-d84a-4249-4379-08df1a2e598e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 11:24:08.3015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L1v1L0+OcL+alz99fvHGkuTtWlGz7zmrZMkZ/Q+CxfiZ9hZa2P2k19oDlaYfARbaWEbjnqdb81q7fgckjhpA6SQ+ZuBP+92pdO6PCyECzmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB10463
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBIZW1taW5n
ZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiBTZW50OiBUdWVzZGF5LCAyMiBTZXB0
ZW1iZXIgMjAyNiAyMTo0MQ0KPiBUbzogZGV2QGRwZGsub3JnDQo+IENjOiBTdGVwaGVuIEhlbW1p
bmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+OyBBcnRodXIgQ2hhbg0KPiA8YXJ0aHVy
LmNoYW5AYWRhbG9naWNzLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDAvN10gbmV0L21lbWlmOiB2
YWxpZGF0ZSBpbnB1dCBmcm9tIGNvbm5lY3RpbmcgcGVlcg0KPiANCj4gVGhlIFBNRCBoYXMgZWZm
ZWN0aXZlbHkgYmVlbiB1bm1haW50YWluZWQgZm9yIHNvbWUgdGltZSwgd2hpY2ggaXMgd2h5DQo+
IHRoZXNlIGhhdmUgc2F0LiBBIGNhbGwgZm9yIGEgbmV3IG1haW50YWluZXIgd2VudCBvdXQgYW5k
IFNyaXJhbSBZYWduYXJhbWFuDQo+IGhhcyB2b2x1bnRlZXJlZDsgaGUgaGFzIHJldmlld2VkIGFu
ZCB0ZXN0ZWQgdGhpcyBzZXJpZXMuDQo+IA0KDQpUaGFua3MgZm9yIHRoZSBzZXJpZXMsIFN0ZXBo
ZW4uDQpBY2tlZC1ieTogU3JpcmFtIFlhZ25hcmFtYW4gPHNyaXJhbS55YWduYXJhbWFuQGVyaWNz
c29uLmNvbT4NCg==
