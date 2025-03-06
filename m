Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48027C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 08:16:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28CC64025D;
	Thu,  6 Mar 2025 09:16:18 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
 by mails.dpdk.org (Postfix) with ESMTP id 20DA740156
 for <dev@dpdk.org>; Thu,  6 Mar 2025 09:16:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHGEI6hf1HDpBPgkKTiGNSkWKXi1PPFM2kbI6EOcb3zdimJDbAJz0RECS8G0esm9DkOn7hvTJONzL+4koMT0fvORTERibgzQPUjxHXqqhptHAjar8InCT1vG1WkliARI+iOfNEpKJeZK8s111UVkqqzmp13xHgk1Q6flgEUXzt3oVOl8WcweulZ1lIvvw8VRiU0XKFhKF9+/9u9EvGSCL7H8kDxACKLm2PrpzhjxQVw5TVWKgzUeWtk8VsHITNa25KB8zk4xlNjUp4SLHjjgvA8ATiRadTQcerjnKdnDYp7iJl7CubHPxMFfjp8rFeSeYqEk6i7HWzAtzWndB8vZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFssN2CqjRx72KV87Fa0gQBO0Wh/8fNHuCvvAE+qq/s=;
 b=EsRY49Uyr5aU25Hx6r9lKSz9CBy+trePbNZavZa2lgSTVt87br5m+vv+su1pUfFKtJV88H7j84yd+X9/n7OvYs99gEuO5uLQTyxfeW6qM6+2DZ4oRidtfpM8A4HFtkanVv2KmwmJirShxGXflEhrkl676PXNUmD1VUxmt4xSVTYzyeUjf6Dhxq9kWwga0NB1cpR3YcW3xXZAWcYKpU9ks7vRSuBby/qqWV5qNMSgrgtaARero5vTMt9RPZCmnyRsFTXDl5aoKldspUzBGz93l3UDpXH3KZVB3nX0uN5pK3xdPSpyA5dpD6VHa2UdNak1B3LrPdPcd5Tl+MTkv6MlYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFssN2CqjRx72KV87Fa0gQBO0Wh/8fNHuCvvAE+qq/s=;
 b=lVQ52a5+kMRLQE6c+gbXL5+VhEZNZcLHRjzHqQwF9CdY7voKe7mVaEm4FxtspDeudjJ60Deev1kAAtnR7BQnGxgQtAK58Y8IhWgozhOYNJs2nRVErOxxySpF+CEAt6k6tBz0+fKoUiAb0C8dUaTU+zjMdq6T5XRGvwy9gnppHaX623yrtyZGr7iFUOfp0vihAEB0k8iNGbxSPuaDeWu37gB025kPnHPCaOg0RX4J3YIE/64kRmqDt560Sd24CBhMqn3Hq+uMChKvEaTWQO1kkMlXmkOLY3IPP/K3Btn/rQcliDNibf351QXN0EUYQLQ/d1z77oKwpJvknLiA6bfdsQ==
Received: from VI1PR07MB5248.eurprd07.prod.outlook.com (2603:10a6:803:a4::30)
 by DB9PR07MB9272.eurprd07.prod.outlook.com (2603:10a6:10:451::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 08:16:13 +0000
Received: from VI1PR07MB5248.eurprd07.prod.outlook.com
 ([fe80::2dee:d246:de3b:42f2]) by VI1PR07MB5248.eurprd07.prod.outlook.com
 ([fe80::2dee:d246:de3b:42f2%4]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 08:16:12 +0000
From: Luka Jankovic <luka.jankovic@ericsson.com>
To: Luka Jankovic <luka.jankovic@ericsson.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "pbhagavatula@marvell.com"
 <pbhagavatula@marvell.com>, "jerinj@marvell.com" <jerinj@marvell.com>,
 =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <mattias.ronnblom@ericsson.com>
Subject: Re: [PATCH v9 0/3] eventdev: atomic tests to test-eventdev app
Thread-Topic: [PATCH v9 0/3] eventdev: atomic tests to test-eventdev app
Thread-Index: AQHbjdi3rIqmdOaAEkiHHiJsd/3hLbNlxFiA
Date: Thu, 6 Mar 2025 08:16:12 +0000
Message-ID: <818c4278b785cd4d0ae716602a6d6044900683ba.camel@ericsson.com>
References: <20250305125215.2870237-1-luka.jankovic@ericsson.com>
 <20250305141255.3031686-1-luka.jankovic@ericsson.com>
In-Reply-To: <20250305141255.3031686-1-luka.jankovic@ericsson.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR07MB5248:EE_|DB9PR07MB9272:EE_
x-ms-office365-filtering-correlation-id: 575fbdb6-1fe8-4300-2480-08dd5c87288c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VHpGcU9Bd2NZU2FKTjdBZmNOTEtWR0hPNWt6V0d3aVBRblIrTXMrS3kyRCtW?=
 =?utf-8?B?cmx2a2tYSVpNU2V0WVdnYWwxY1FZNDhZRlB3aU84RVFMdXA4NGFiZXJWY3RS?=
 =?utf-8?B?ZGZHSmMxSHRzWVNhZEp3eHV1a2s4NHVkcjJncklFVHpVeFk1d29NaDl1SlhZ?=
 =?utf-8?B?Z0FWUG1xS2JDSVJ6ais3dGlIM0pxRXVjNlZyRlh0K0ptV0c3WDRzRERBZGdv?=
 =?utf-8?B?dCtvRDJiZVF3b0l4cWl5YWUydllXUTRRZzYvMW1kbVcreWRhSHEySGc5UFRt?=
 =?utf-8?B?NDQwaWRJU1ROdHphZmhxcER6VHNMQWZ3RlhKWUhLRzdqQ3RuVDRpanpnNWRq?=
 =?utf-8?B?WFNvYzhpVXNNUFZPMkhNZ2hONEJNemVtSUdSNEFQbDMyTFpMK2lsWFpvenNN?=
 =?utf-8?B?UjlKbEp4WXgva1I3SWNPWFRpOXZFYVYxdk9ONmZXaStvSTJJdjNPQXJxRDJV?=
 =?utf-8?B?UWsveTRzVndkWWFJSkp6RldvbjBvS2JpOTFWRGZiL1BMNHZFeVM0MGJNVFNo?=
 =?utf-8?B?ZzJWRFpFQktzQVBZS1JPc3dPV21zUW93a2ZVaEQ4VHV4d3UxZ2MzN1lZYkV5?=
 =?utf-8?B?Q1pYVXBWaGxlR0c5Y09JeUkzeXRwTzVrSGt5NE9xT1ZnbXNpL1dlQm80MEFD?=
 =?utf-8?B?S1hjamVmclphQUFYVzR4YVZxYThLMFE4NVlONU9xU0JlcEdYNDBQVHA2eXZB?=
 =?utf-8?B?VFFWNFVnZFZpTDZPdGtubHYzRGpmWFY4anp0cVhhd1pwczExUmdtMW5SazJa?=
 =?utf-8?B?clk5RENuNzNTNmkzUSt0R1FuOHd2K21ZWDIrWlVIU09zU2R6WjRYY0RWTHZX?=
 =?utf-8?B?OUJPYTkxTnBjZlQreTdYZFc5N1JrYXhGcStYMUFETnk1ZVJMZ0VyNlRIUVRT?=
 =?utf-8?B?SENQc3FVRFYzRkZDZHRuelJ2Y2UzSkcvcDZaYXNwYlkvNCt2QTYxZTNNRjlO?=
 =?utf-8?B?cFVGLzVvZ0lPNWdtQTh0OGJqUy9NalFqOHduWk16Q1BiRzhHdTVPaDFMWDg4?=
 =?utf-8?B?bSticE1VVUx6eDZuUDJ2VUc4MjJPUjZOM05OZnlBakJhT1lCSDQxU3pCZ2h0?=
 =?utf-8?B?N1J1RTN6Um9XLzlUQUVSS010cFhNMVhEbWJPMXgyK1RlaUZ4Q25RNXdZdmpq?=
 =?utf-8?B?bVRmVkg3R2ZHT3VJR004bzBMUUpQbFNzYTlkd0RFVEltckUvNWp3ajJwVG1D?=
 =?utf-8?B?YUo4cjJoMFR5ZkJrTnNOQnlhVE9WYzFOMVZNRW0rVnRheVVGOGVqNDh0Tzdy?=
 =?utf-8?B?ZW9ZdjhJeTNsUVoxZDJhZWpvWmE3OTJ1d3lVNVhqYmg3dnkvWEEvckoyRnNC?=
 =?utf-8?B?cjhOYUtYR2RqUWlmZWt3VnZOQUJxVmY1OXRmWFVrS0F1dFB0S2dtdkVGNWJQ?=
 =?utf-8?B?L2cyeVE1anVMS0FLZTJnbnQ0dGN5RWtTRkV6cjczM0I0WWNMNkNHVFVPT3VY?=
 =?utf-8?B?dlNLTUxaM0V3U1VnV21CRzRGemt2MHRNUGd6V3VYTG55SDJWeHVtN2NGaFFI?=
 =?utf-8?B?NXpBVzcxK0Q3L21tZXF5ODI0bmZBUHVlYXFVODc1NERGYTZzSjZNN3pVZUpw?=
 =?utf-8?B?TVphb1ppeG5ZdTFSdC9zaTAyK3ZlNGV3TUY1QzFIN09jMVNCSlhhbW8wMk8x?=
 =?utf-8?B?WEhSeHA4Rmp5MjZxUnh1cFZZb0pESC9YWUVxNS94QnFuRlhDWlRhRE5heWFO?=
 =?utf-8?B?QmpVdTFEa1VhZE95UENmdU9DcHFjVDc2R29QWm4xVWw2OHdsYURPV28wa0JV?=
 =?utf-8?B?a2JMZmp3Y1lTQ243SEF2QzV5QURKWCtMdENld3lONld5TERtRDFFd3E2Z3Bx?=
 =?utf-8?B?UmI4QWZza29wbW11TWUzYjNjN3QvYzFKL1FDcCs2L3RTelA3Yk8vdlF4azZD?=
 =?utf-8?B?L1lTZ1psT3hXMmZhYkZNZkNoM0dFbDhiMFQyZXlIeGdTdmFiU1B1VzBUY0Y5?=
 =?utf-8?Q?w/66sCkRkKOUivCtefkWoExgi+ZNH4yl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB5248.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0hEVXdOSlFKTE56cDlPVmhRWXhqL0l4NW92QlZ2L1QwM1lqZmd2SjZkQnVj?=
 =?utf-8?B?Mjl2L2sxUzVjSUlkQ0J1dCtTcHhVaUV3WXp5dWNOc0d2RWNIWXRsQVlud01r?=
 =?utf-8?B?TElvdjQ4THhmaGxwZXIrYUJGVEpQcWo3bFZoOHZFQ0U5ZmpPRDFYTzRZRGkw?=
 =?utf-8?B?dWVjQVVIVHFFZCtDRXZoYXlKSCt6a2NpcGxwQzhwczhXMGUyU3BrRHQzUnhT?=
 =?utf-8?B?TlVERGg1dTlleHBDVUtKS05HbXpVdEVmdVE5K3g0RlZOVjViWlFFRVRSY1Jm?=
 =?utf-8?B?TCtRL2lCZkRaR3lBSWFIRXMxMk1SZVJUK0t1bFJjL205bUpqU0kxeTBRK045?=
 =?utf-8?B?WHRiWTM1Z2Mxa2VLOFJQR1NjNGFEaHVKUnhSaXphNUhxOGNvQjJpMFdCcnls?=
 =?utf-8?B?VkN1a0llMEpKZVp5Q1prUjdQOTR4clluNHNlMVZmQjArTUNMV1pnbWUya0Zv?=
 =?utf-8?B?Q0JFNzF0a2FqZTUyaUZMVHhMd29oYzAvMFFHUkRtTzFXU1ZMZkZ6clpLSXlZ?=
 =?utf-8?B?enQ4cUUwNTdLelFrNVBTZElkK2hLTXcrZEJSUktFdlMvczBQbXVzRXl2MGVD?=
 =?utf-8?B?dTNKcHNjSUVZY0t2ZUNRVnBnNzFsdFBMWWdnT2NFWUJtc3Z5TVMxcktqeFRX?=
 =?utf-8?B?WjV4UmpkZlJHOFpTNDdJYzdmQ1dZb0xGWXgxS0VKdGUweHlUSTZEd1RtNklw?=
 =?utf-8?B?QzdoT2lqL2dqejdIMURCRTY2c1NIT2tvRHhvQTJ3V1V0dHNpV3VwaFUrbW1X?=
 =?utf-8?B?bHlPelF1eEJnRVlINU5PR0FDSjlRK3B0VkVmNjJBaXNzTFBtTXRRMmRIVGlt?=
 =?utf-8?B?aWEwVjNyYTRLK1c5UnoycUQ3LzRhNGdBcDE5Yk5IWHA2c3JFR0hVbUYzRFpo?=
 =?utf-8?B?VkVCMjFzTmxPSDBUVjN6K1FIaWhPRkx6c2l5WENhMFExZURwRDNxNUJ3MnFB?=
 =?utf-8?B?ZXZVbFRJMUtEeVNBNnF4bU9tVzJWYnNIS1JaZjZrbVlYakFlcGs4UkdhMFdW?=
 =?utf-8?B?UldMNmRMZFRReit2ZC83d20wellvaVhsTnFFb0F0a3BSaWFXK2hTNWNiN0pT?=
 =?utf-8?B?RHB4NlRsSzBncXVUMFhzaUlFc0o4OVFyaEtyOEl2MUpybGVZaWgxZDBYbnh5?=
 =?utf-8?B?MkNhbzMzdUUrYVBXTUwyMTdTZTB6QjhJS0w2bVR4MWM2YXpNSmdNd0NjSGE4?=
 =?utf-8?B?eW9KR2FOeEVQeUtjNU1uczduazVmUUxyOFlFSTR5ZkZmN0doaXljZXFZdFNW?=
 =?utf-8?B?bnNJSkIyN09lSWhJMnZXdkRPMkJESHcva3FEVHErREpiY1VWTjkza0lGWmNZ?=
 =?utf-8?B?VUFvTWVNV1lNQW4xeTJWZE9LYks1S0tsalFhN25lMjZpM3FrOVMzUjVpSWVh?=
 =?utf-8?B?TE05WGlVcGZvSDFDTG5NOVJyNy8vcGdKd3FlRDQwT085bllXeHJiVzBUdE02?=
 =?utf-8?B?MFpoS09icndCMmtjbE4vRDJ3dWZuTUhzNVlSRzdQMVJHREhSbTVib2tuNmtG?=
 =?utf-8?B?UWVENlVjMnpsU01DWjBUMXJCamx0WDgyNnEwcmRrU0FJa3JNM2pDWGN1U2pD?=
 =?utf-8?B?TE4za0RhV0lSMDM1Q3N3VUIzS0hZSklLSXFZZ2szUHRnbEYzeS9aTzhlbHpW?=
 =?utf-8?B?dmpONGZhYTgvaHpDU3I3RTRUdHd3a2ZtQmFOQmxoVStMOEhYbHNrMjNLSjF2?=
 =?utf-8?B?c3hSRkFhMER3NUY4WWh0QUtEUXk5VkxiU1hnY3FHUmtod0p0VFlTRDNsbjhU?=
 =?utf-8?B?RWx4dUt5eERVOVd4ZmxTc1hZSk16NytnMVBVSXBUNXpVejkrYjk4dFRjeldr?=
 =?utf-8?B?NUQ1K0YwSXh4bk5UQVNiRFRjY2hqTEhDY2JYbENlNUEyZUZ4cFdwRWNkQ0N2?=
 =?utf-8?B?TThyeFBKeTI4bllhUVU0ZUFrUFZMVUlqcHZHcWFwd2hkeE5lbFlHRkFjU2Zr?=
 =?utf-8?B?bFdEL1B0cG8xREg4all2dE5WYUdzS3MwMS9sM2VRNDRGbnZOZmtqaGpQRnBE?=
 =?utf-8?B?Q3V5ODhRcFpuM1BxclplMkNHWDR1M1VFNGE2S0dIOWVDRmlWWjZRVmdBL1hp?=
 =?utf-8?B?NFVLbUEwS2VCbFJVTXh3MnplQVMrOWE0cmd5L3VPOE5hZ0thUjBmZUVBOERw?=
 =?utf-8?B?VFhSTjNZYzN5aVJGZUtjLzRsNXJyZitUbUx1MFFEWVArRGxZYzBhdEk5VFdG?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C911FBFDEF72724CA8CCD87429FF5FD2@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB5248.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575fbdb6-1fe8-4300-2480-08dd5c87288c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 08:16:12.6992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/EE6qWaQbDEn/kbaBwPFYh/IE1Ayl2unJdY3xOVzUCFOES5BSecuuJu3bWd2A0vxA3w2nWObWVWrnvn6w+QxqE+ZYp4NCgz+KH/BoBbxgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9272
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

SSBhY2NpZGVudGFsbHkgc2VudCB0aGUgbGFzdCB2ZXJzaW9uICh2OSkgd2l0aCBhbiBpbmNvcnJl
Y3QgZ2l0IG5hbWUsIGJ1dCB0aGUNCmNvbW1pdHMgYXJlIHNpZ25lZCBjb3JyZWN0bHkuIFdpbGwg
dGhpcyBiZSBhbiBpc3N1ZSBvciBzaG91bGQgSSB1cGxvYWQgYSBuZXcNCnZlcnNpb24gd2l0aCB0
aGUgY29ycmVjdCBuYW1lPw0K
