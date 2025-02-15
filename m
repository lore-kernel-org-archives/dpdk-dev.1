Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6C3C021A0
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Feb 2025 11:12:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 858124028A;
	Sat, 15 Feb 2025 12:12:51 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
 by mails.dpdk.org (Postfix) with ESMTP id 5BC79400D7;
 Sat, 15 Feb 2025 12:12:50 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWuDnKuWk1rL1pArynF3dNZ3c4vbvUE0PxrBJE9br+5EbwTskVMEyt5AS6PAMeUm0ZcPHAIueDZaMTc3i2q78Z8eiT7lD57dvZ3O9wSFbT/E0HNUpgiMKdh7Pg9wivXxB4RKSZ10SqhqLfu48GsxSo2SHdrPngmTHxKmJPSMQoUfuwCzWzEUxOCPapkX49AFp60HSqKWQjFp1/CUO5hUOPPANhrnFr9M2/E+D7esS5YfnYnaWCoVeDV6djO6SoDNEBarBKGzXo+LPlNb6629QhwG1x6jeLgbDozQQHJCxER2nHMw3qwXSdKrqrwHeIIc7s0qRzlpSWzpk+h9PCby4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=MROKKhfC+teqy2GkY3vqzpiLKTLk6l2JlamPCUhtJ3mPEUdjbeBne5ffhp58sfunyx36htF8dWGcWjyhqNPaaqxOUccF2sPGPXn9VA2YnTSGTV/nGSMe/nfrbIA+bYptdNffvA2fmqPaLMC3Sr3cUP7Jzmm0XQRWeMwuZNQqBYDoUoZG3h6UXQBaCYnLB/LZVtTx6KCMFEQMLz1Y4uXQYdn2ss3onaVOLUGnL6UXUqmUYvYlZmxnc0jeNnd9H6B4aX9SJEk8bqIHDuL+Y3mypoDdiv+RgWVY7lDfk2REBjJ6D3kowQNRrRvUDpCTtxlLqcYSoJKABhQMlK7c8eTFNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=mC7QpCQtezLCeWpO2V37DIFUppus9u9cf+20p0pz91xqQHOKqvDVKS5tbOMpxhMgo00qpUu3GCwxll8VE4zRQOztsn60YCc16GlV9PvDvfEHtQbIM5dTA5hBIfndRRXtOI0xX9032+pdHhVpKc4wTFOa8ENM8cvy4GLJWaZGEkt8ppWWQey4FtJuBbyYavEUGpx9cyo+9BR4DyYLtn2Q/7NRpdpAqd8MA4dkPTJYvBOWbXf4xliB6Ud4TTobZzen/ZuaBmZt2YHWHlz5b4zZKHVoorfAAqY7WrszNOJCCzgzSDM98QlqW/nYlXTdZO2EbJWPxNs6D9Oa8VXIgG0/QQ==
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AS4PR04MB9573.eurprd04.prod.outlook.com (2603:10a6:20b:4fb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Sat, 15 Feb
 2025 11:12:49 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87%4]) with mapi id 15.20.8422.015; Sat, 15 Feb 2025
 11:12:49 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Sachin Saxena <sachin.saxena@nxp.com>
Subject: RE: [PATCH v2 3/7] bus/fslmc: fix use after free
Thread-Topic: [PATCH v2 3/7] bus/fslmc: fix use after free
Thread-Index: AQHbfwTwmIP+csDeh0Gs4/oGdTPiKrNINvFw
Date: Sat, 15 Feb 2025 11:12:49 +0000
Message-ID: <PAXPR04MB9328F3E7482A31B557E607BD89F92@PAXPR04MB9328.eurprd04.prod.outlook.com>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250214172134.73908-1-stephen@networkplumber.org>
 <20250214172134.73908-4-stephen@networkplumber.org>
In-Reply-To: <20250214172134.73908-4-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9328:EE_|AS4PR04MB9573:EE_
x-ms-office365-filtering-correlation-id: 213d4448-dbe4-4e07-400c-08dd4db1aebe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?v+725pcBVl3pHcJSZTVsdmRKstkUOXXkF/l9GRh4wGpRyta2vWl2neM9A47P?=
 =?us-ascii?Q?eoYnEgjB13BjQfCfIV3lnxSHiDbcQkk0IgHBNpi/voiFkFYOxAkDRwv8QOLI?=
 =?us-ascii?Q?fMe5OgczntTK83v6lBN/EglR5PZLemW1ius+MtRvGmMBSUZDQg5hSBpJTgYu?=
 =?us-ascii?Q?p44LvRsgOKFeuvnKC6d73J2y1mZvnRE8eukhU0m/3fqZNjilx4TEv2r4NIAK?=
 =?us-ascii?Q?mEs7PPdkkKvbQOMG6mnEqvbzRvodPj7eepN5TF0PwzErGW+E5nPHLy9gK+DX?=
 =?us-ascii?Q?kYCVJiQ1/YiEMvi4GjuCmMJI/ZAu+7S43NWBt2jo5LCjEecpIuBXRfh3hCdR?=
 =?us-ascii?Q?63DqNyk618akhJBVQWbrcrMRXsgBuprMB6AD1FsjBR+p2ufujE4RKEYiR3wX?=
 =?us-ascii?Q?hjYFfIxxZsxrkJG8BRpjVUGso+ZbaZtJ2YZMuQE0kVApGXgf6qgOZVwB+DAt?=
 =?us-ascii?Q?oSirF6fvge6eYExX5mUlhAPnH/Vc1V5ITL3I68tYX0kP6ru8TX4e9isEsXRZ?=
 =?us-ascii?Q?nygmL0fpq6uf6q53ENKKDmMkhkkiYITKm7wNos6KJ/vwFLGi7O1sLZ73nbLY?=
 =?us-ascii?Q?0+VQD7C6lTj3JmawxRmnkiyL+g1xpcodfxxUbJIc960FZ6r3bGKuqv8/DUKH?=
 =?us-ascii?Q?MX01fBlq8ZJQdDaGKKkoYDNhStJEklqhpf/o/c1pVMQuf+YPwhXz1hNrPaYk?=
 =?us-ascii?Q?kBRz7svoq7KIXryXU5BTZndZ2Yu4zVnT2xaIEwfvTjV4HtBesAaIB1fKaS28?=
 =?us-ascii?Q?+nfWMU7lVcB9SFaqqMxu3nVxcQpDgZliSqbhpL7f+xsm45hJooQcDxRNPlzh?=
 =?us-ascii?Q?fEiYwnQ4l3l2Tlq6PkdENIzcdpXvYDw4zW2iYltPeW6ibUSkPPmdWaHg6S1V?=
 =?us-ascii?Q?YrZZY2/HTxJdxKKmOGkAATQ305opwmxP5ji5tgGMp66cKfwrl64sZn4q5I0O?=
 =?us-ascii?Q?QfWTifdO/XaATqZqdCwSi0CMTmWX9WIYAtUNqTjeAzethRYhutn83HuAJSA7?=
 =?us-ascii?Q?BE6IIuLqvwLYLkMzVu94uY+/kzGS+Hlc6NtEruY1EQ5x+K2QW8TZsLErTO6y?=
 =?us-ascii?Q?lOpkC4KGai2eUJ4DCh2D6kyakodn67dStUjsp+5KGYqq69VC1She7pS4g5W9?=
 =?us-ascii?Q?x0mqpr92s48Jyu6aNSmZX6AUxfN4M0hUDaqR/VKWf30d8Rtq88j7oGSk6iSO?=
 =?us-ascii?Q?XQw6CAFYy1foUwUhnkeMAwQd9x7YlJW00s+FOvU9cHtvTl7ozWlRkp+HEHFE?=
 =?us-ascii?Q?URFQbSybwSjwDS4PkB3/qtpGMBOs1OaP/bu/CKaZ3HtQhw0iHWHKaeNpM0hz?=
 =?us-ascii?Q?NUwV5dOluYU6OeLbR51oT7lbGKExYYdRbKqDN+RpYRlgn+3x2rh3tGvAjUUH?=
 =?us-ascii?Q?hE8eY2ocCb7V6U1SOVboHBN3Gfpm04xpxIabG/vsn+6i6LdFw2hj86/Un1dB?=
 =?us-ascii?Q?7Qi/Wo16jH99uSaG926RBKTaOGdgKvAp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g88AVmr72iv8BitLY7W/DEmDFf799E1PUqpIFMceBcirrCwS8ZsD6HedD+Eo?=
 =?us-ascii?Q?3r1d9eUR+LMiI1lY57Xtk+0rGuQZEUKKdNgwuJN3artHPD/8CHA9u9pxTehQ?=
 =?us-ascii?Q?We/oAQ9GSl4eIpZqcOn2TPgu2+yMNAX84WA0WpTANaPPM4dTU+V8uK5umEgi?=
 =?us-ascii?Q?1KPkKbn4OGFyafHEvmyrkK5sihghn+E5PZItr0o9rrABiFSULdZcyivTBItr?=
 =?us-ascii?Q?Pw2mcQ8scQOUBNxSWV40eS4XC/hyWmAjqpujxgdSVHpqEOtpA0TsTIibw3Mp?=
 =?us-ascii?Q?DoDfi/w7XC7dCeMX4mk5jBozUcJFtLGPEh6DVIKWY5Ipl0Pxb1zvp+QoIdGJ?=
 =?us-ascii?Q?8+hdZP9UI0eaoQx0jRrJF7jYzHuLSm76E7MAagQQhjwfLU/1+IH/T58uPSxq?=
 =?us-ascii?Q?W2lhNo5q7hoYdRK3ZblVFAsKjQwfGDPl2UWOmdXZURKKd7v6YzNHagV/YcXD?=
 =?us-ascii?Q?U5n04rU3W2Q+Dha0xVpllXA8nips1tZAPtMs4ZoTWHq6WBk9/LeZBXPhYyM2?=
 =?us-ascii?Q?ZEe5K1ZJiFXaatSZSmrljY/NxnfkRAc7RFo19s6IE8eq+JO1N+0ikHcfPQVB?=
 =?us-ascii?Q?44AeyZ9Gbe3f8eokgdNXzNPNRMk42PV2gXsXFYkZ3IHQjUopkwigbmQXAFBX?=
 =?us-ascii?Q?C+9fiOu20uFQlaR9om0B1IP75e1WFdItw5suKqtZuLWYgvdunWE2Ig+fmj54?=
 =?us-ascii?Q?GfKwP9+p9UXruF7uz1ByHf+hy0KpVoXAOKNQRAhWdZQuCTHwihnnKhOFdDMh?=
 =?us-ascii?Q?Sjnpm5OjmnXZWt7x3bweQdWxKya3YGYKPFfHUOcY1Hacwwo4k3ks1QmW62A8?=
 =?us-ascii?Q?rXg8Oe8mvKz3NIDVFD9n9ef63nHKUXCQwRohrAHGBlQlBBig0d6uZ3k+Hf6w?=
 =?us-ascii?Q?hCmedFdCY+Q5oFI1MUW9vnGjp33g+Yg6ihShdzVTzOJ28KevpDrG9eIdKYjm?=
 =?us-ascii?Q?dGr8DNSOcJv5N47UFZUTiR9IPfjzBYwyMYqVZJdhwA2A4mENKLpwo0lTOI9G?=
 =?us-ascii?Q?rqEeE2cEycXYvhPIlmXWgxs7hK1p8uxaF0XpGh9Z/W9cQE4eYn+L4LYLYqxd?=
 =?us-ascii?Q?W4FNRMIE9tZ0zAGBtd3r/dcEwmdEh51ktw0HGqk9uwJUUF/MMkDhElw+CSVl?=
 =?us-ascii?Q?/iFV80TjTqdOrWk7xrWv+1MEXBht5FhzuXnBOzHCfT+pe/TRNpxVYnsbVMdS?=
 =?us-ascii?Q?dZLQMXabclUq3hGtWj+B6h6I/5tfwSPVCmAHM6Uq4K+BFjh+aFzIG3yxXzB+?=
 =?us-ascii?Q?2TR7fAAmzcmC8orj+Wio8eIRisfbv5igofb3Rwr+TQBpECLoXM2uqcnrZlby?=
 =?us-ascii?Q?3gk7j3dDBFYVG7TUCiwWr6PAs5TKK2a9ur1EtGDX/vuG7W+tldpEKrNV1N0/?=
 =?us-ascii?Q?JK8lFWqt4Vhrnc/SPf++FJDIOC/loRPMho63jdxa1IXjvDE1c3RuWoIQVje3?=
 =?us-ascii?Q?7qqaNKwUDHcsTdjW8r+C3lp7U8i9AOHB8Jtj0WstjA+/3NplMabWzBcvMbj0?=
 =?us-ascii?Q?1l/QN8askIZlqeWm+VWxj0QHMZ081JAGfLOPl2CXEjvh8UCkaQj/PPWxBDgB?=
 =?us-ascii?Q?cOkh3f4YAO7UbyZUaOppc4lpuwcbfhaRF4mwnCwm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213d4448-dbe4-4e07-400c-08dd4db1aebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2025 11:12:49.2469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 89EsCys8LNG/xBwXzznrPhuxaXjELl4K4eaBeElt9wT6+IEu+bcubp9vSP9e6y0XcDTiskE08a3C0gh8qIxIaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9573
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

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
