Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2ABEF48ED
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 09:04:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85D3D402B2;
	Fri, 13 Feb 2026 10:04:14 +0100 (CET)
Received: from MA0PR01CU009.outbound.protection.outlook.com
 (mail-southindiaazon11020090.outbound.protection.outlook.com [52.101.227.90])
 by mails.dpdk.org (Postfix) with ESMTP id CA33D402A9;
 Fri, 13 Feb 2026 10:04:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGo/RkPQIy57ujL4rpyjRfjpUQd9on5kqNdeQURUTaSLJzDnIJSeoBhHMYC/uVBz9i2gYz0uT0yFIAR8jR2zNSmMy5B3qsscgU/a0gPeM5csOpRzm4BskT0r7toPsulWcfbS/ocjYAK72nnLab+YI7DvHmm+PkNH2aYZHDHl2lGmfBrMjUlZzixmchV5CqmSiPUTXWZalxaVVRsmQ+1au22RZK7D9oR+XrNrasddWqG1iLctynUIMXnzWDJvF+Da8VbxMALUMbA4yrdyta58xHB1NuHhxwjNPL+He2rLEgdtWy+xCbL6djlfUG4NWZczvQXdYqWq4EvNu5LQciOLUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NupTC2QVeNIHsZEQd4h+i2K0vxzfCgYaUPsvJIDi1Xo=;
 b=dRrhNeA2CV5SRtLkZhlOPiDIe/NgntSlKJogAG+E8PpxIDBL1rCA4kibZK5ZTOlqqkfWPWqxcQ7WiUhK6fTgQANQ1l4dY1AUWSfaofDlkhpuJZHPOBLWBx2Mqb8wBGVtdGPfOwM3sD82haKVBtIBdalj1pb6qhPfqfgV+dktszPF+V4d3IdPIgRyMqLysDURzWi2DyfOKGyZsb2xTe1108IDV/FvNmZuKSMswiZOwCQUmrgarMO8CVB1hv/ttKqxSL3kBXIoQL5oWJnpFaY/fATGs/nFRS9djeFvOvDZTOSQC2WZZfim/i6Joi4PAlgts67hUL/OFGBPkiSRCt1WoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iwave-global.com; dmarc=pass action=none
 header.from=iwave-global.com; dkim=pass header.d=iwave-global.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iwave-global.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NupTC2QVeNIHsZEQd4h+i2K0vxzfCgYaUPsvJIDi1Xo=;
 b=gxk8nw9MymcdmDnZfzrg8uJa48JNrmRtfTgoDg/QVd+fiJmSbUEe7iYe1y4OhMMywIijEEtUmDzJgsJ2jd4DzGYTIGYuzI1Grz6bQG4gvkpHEZbX+M+oef5yIqFFHY03JBrzXfp+nBv0XOasOtnDlP6i+eqsFichJS92nrAwoX4GI7ttN1d4Qbxao2TqPQVZlZseaYC4pw8hF9PmahEpjoSPnNB2ItI3LY7m2Wui1C8mSa+mNStzicdlN3nsMIfV9F/l1qGVZDWym+kekEj12BuZUzRw55w0bo6YY40ibSbwTv79+FdgFYx/Dm6eV5NiL7xBRviAdudkB8H2NQnyAA==
Received: from PN0P287MB2531.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1ff::6)
 by PN5P287MB4370.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:2c0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 09:04:09 +0000
Received: from PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
 ([fe80::8024:3f32:d2cc:1309]) by PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
 ([fe80::8024:3f32:d2cc:1309%3]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 09:04:09 +0000
From: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
To: Ernesto Ruffini <eruffini@outsys.org>
CC: 'dev' <dev@dpdk.org>, "yasu1976@gmail.com" <yasu1976@gmail.com>,
 "users@dpdk.org" <users@dpdk.org>
Subject: Re: Guidance Required to Improve Throughput on ConnectX-7 (1x400G)
 with DPDK v23.07
Thread-Topic: Guidance Required to Improve Throughput on ConnectX-7 (1x400G)
 with DPDK v23.07
Thread-Index: AQHcnLCS62jGM71/gkmd9SnnzdDRG7WAUfeAgAAAUR2AAAL4dg==
Date: Fri, 13 Feb 2026 09:04:09 +0000
Message-ID: <PN0P287MB2531BFD1D63007182EFA3E5CC561A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
References: <PN0P287MB25319528772B121E0E380747C561A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <039201dc9cc5$acd5dee0$06819ca0$@outsys.org>
 <PN0P287MB2531B462677B1BDBAE41AA15C561A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
In-Reply-To: <PN0P287MB2531B462677B1BDBAE41AA15C561A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iwave-global.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB2531:EE_|PN5P287MB4370:EE_
x-ms-office365-filtering-correlation-id: 71cdaa07-3d17-40b7-37f8-08de6aded967
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|13003099007|8096899003|7053199007|7142099003;
x-microsoft-antispam-message-info: =?us-ascii?Q?AoBTbsQwVJZw9o9rR8GAhlQsRnHCz/pN6kbbo6ZfnNaEN1+G4WIxT6uWvAYm?=
 =?us-ascii?Q?K7z+hAnv8vOCyDsBCcIQR02dOgzI66iTKzNwa96uVShqcuoTdQC7Xn+2Bakg?=
 =?us-ascii?Q?BesPrvymtKgbzfJ9NuNmfslroauv98dzO4uv7J3av45wfGolH7VH63WDm1Se?=
 =?us-ascii?Q?wrKB4MdB2C+d+N597vDxjPqm7DxozIWhO2yD81sjJvA6FXLixPBBONiyUwq9?=
 =?us-ascii?Q?Ap7eOBXTdCLTZ+97mX24fioJPrzP2gJ2deKRU2rYcZ1iGycsSX8PjCTlt4Yd?=
 =?us-ascii?Q?9CJKF+d/WLrX5YqFX9U6Mt37dhHeW4eoE1K7obZRPU093emdje6JsD9aYjBt?=
 =?us-ascii?Q?R8J/r1RSfuRo3vzysrQ8zaW5TSmg0eCqZAYuBzTtJJdnFzD8zaSjaJJMrtr1?=
 =?us-ascii?Q?wpsZckCHYu/3VdW0I2VpKTqKZb1aOi53skLbdb6fvRYxRCne2YcX+YNLN6d1?=
 =?us-ascii?Q?x8dvJNYTXbLQGHNeZ4YccOwXDpOWUQLLBncZnHqAcM1ameLdnj5Ll70yIEln?=
 =?us-ascii?Q?tS68F+fOmcY56uzOoeoT0cqWF4tJfzyAgltnOJF8h+wZz5mGKDbTZT9Ch1+G?=
 =?us-ascii?Q?MR1hT4CUjgmOYs5cZmE4R6WP5EgaI7sHzAL1IrFAQyXxZLiAnNiGsVMb6w+i?=
 =?us-ascii?Q?pdm+8h086we4tuOHnl2a1Z8e+4i87ekGLZXsszJQxuOVorLeW/fxw3NrotbC?=
 =?us-ascii?Q?viEiqKsKGzJVj1fzhhOR/xauHU57VAMxBqDi8X2WRnNm1JzE9S4G2whWHhdI?=
 =?us-ascii?Q?ApPC7HT+8UiuqX9M8KWCdp4fr871KMW6E16LEjQSY3y6BZDMN3nQHdLqYXet?=
 =?us-ascii?Q?L4fPGfLM4G9kQKLBhPD3amvw0W8USv7S0Kr6a748lZJ7gfvC2Y+llaupSH4V?=
 =?us-ascii?Q?9OsRrg5LhujOQXHec/+bG757zFLkoYQG0MQK6O7j2+xreJ0bx0ZA7FzVNflF?=
 =?us-ascii?Q?MlILhGQtT95GWvbjUZc7axR6SZ/6SQibsQgO0nxU9PQEho+VLsn1lq+puGS1?=
 =?us-ascii?Q?bJxeGV5VseQL7PqamHqn+3tZ4Hg/Zi5XBTaa1vYaj7IKTbQAEyqktz9zoIKt?=
 =?us-ascii?Q?Rl4P6kj+eKakCnF6xxdwmXhMCfDCQvbSaCjzx/RKO/fuPR0+J1FXMJh7jS5x?=
 =?us-ascii?Q?RKXAUl9r+dgzr+DADKVsJsXTSjRXJk4/snLuIA/8gmlXBSH199rUIwyRgXSa?=
 =?us-ascii?Q?ZI2p+L3VKIVc6F0U0OCM/QkfcdokrNWaaB7+MGY9U78QQoeUVljVFk864LeS?=
 =?us-ascii?Q?1/J37Pb4260Wswfqr/B9TtAK7zwCbA+sQ4s+Ii9DwLr4ZSmvl1TD98JAF8p7?=
 =?us-ascii?Q?GFeqclC5Swk9akfKj6vacCOoCj3GoCbwEYUbC1DEPClkjk7xR9zUZXEko+uB?=
 =?us-ascii?Q?b6BnOVIYOxNKTmjAwjlAWD/1rAPkQ9aSeEHzaymUJxz/w/NHO7kyy1IwndYD?=
 =?us-ascii?Q?TEPbXdhfNIsaqNU5DDTjULRIIM6s5q+uMWvYNbxRgIIBko+zyWbWgNv/hFKV?=
 =?us-ascii?Q?BpJ1wmWnq2w2IeW0CFn0qDIMHtci3tyYMwQUFDItmc4EJzSD/65NPjlGsg7u?=
 =?us-ascii?Q?a6IUaZP8lCV1n8m8ND5mV+wRz7MhnBHAbytKtGeU?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PN0P287MB2531.INDP287.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(13003099007)(8096899003)(7053199007)(7142099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I5FM4PADXIbtYsWRZjhagLYu9RYh5eLzDrXIbNTENCcceOissUVLNO3B/qdC?=
 =?us-ascii?Q?+cwk/DsfyzgqS24UG+bz+gw70A6m6oRT7cKb3iPOqxC5baz+dGT0T42TIsOq?=
 =?us-ascii?Q?ENnaWjRIgO6aoRCUUDN0Km36ca6Ny4lrXoqHLGZlPAYNsbo/mrvubzrqFeqZ?=
 =?us-ascii?Q?aBc6U4RURDR6+KHvqWtkU2F6KFqGifUC3AanCWrnnGOVARnmAodVohEmBW5v?=
 =?us-ascii?Q?Yx/6Iek8AGp1OowjJhA10X0clZzumB5DYThoa6tJQFCz+8J432gnwAVv+2Nq?=
 =?us-ascii?Q?o64jh4CKlQP0Pq8r4zd1HRiw58/okys+HLg7WfBxwucMPl8TVoChLfO1Ka7m?=
 =?us-ascii?Q?iN2HcsUwro7lM0QBjTX8Q/T5nMI6DreRWgf9rPk69z/ftledPUTaHnWR335B?=
 =?us-ascii?Q?MTvkLso6hnQjEWlIzv9gpC8UNxPYcFkOoXSu8G1JrhzMVriaNVcH+bQDs0K9?=
 =?us-ascii?Q?pRrPrFZASZytJypJzMS5FBH01tMTFw8c0DIq/5ApS9RKfcoNbpYRxb7M1l9b?=
 =?us-ascii?Q?m1wFbBGC5KR3WqnWoJWE1mNT3C1Xjrbv20QIDGGlpjSRiI9z7N6HQqhix3cM?=
 =?us-ascii?Q?OpoIz472FqKFoJv4aAQN6bh7P6dX4HbSBNACuIjcPCmyMSFdMOHR5Q9ja5eI?=
 =?us-ascii?Q?sb5K/zbNTC6hsjGou/SQi4F/7mvxTm/oUV1spCuZP+kTcmUly/swqDwI9WmE?=
 =?us-ascii?Q?hITUk+IbOjy4D9wulZIH+yWfEYx9scWViNaatCNL4OVWPPjDDoZ+1ZUw0++t?=
 =?us-ascii?Q?5wccg6hNoHU01cNjewOLwWR2C65DHh4hsjZH8MDAjJ1XvxVXGBEymxejwHA7?=
 =?us-ascii?Q?dSHHjanqUkPtYo9oDu70j0hgssbM0HJ6r71iJKN89UTQiJTUKVWqhtKRUFE+?=
 =?us-ascii?Q?PADq+v4rhWFuPxXBRDEcP0QW4LnnX2u9dV3TAgJ/yW5NFtdrdNTsflQe+2k8?=
 =?us-ascii?Q?9aD4jQF38o9KNUsCu+bdTJlLgKqVF/SyYdbhBEGxKnDtCkMuVexF4fF0EsbT?=
 =?us-ascii?Q?GIAiFDPgc/VdAN6kj0+Fr5OYXbMuReIYnz5rFMiD7sxOYh897TFshtB1CzH8?=
 =?us-ascii?Q?grHYygRqKbgr0OUxNIs22fB+zw0el9JXgGE5AfeOmZGE5eOZnZsmVt+OqiT/?=
 =?us-ascii?Q?yOrPmZAiQYGjSbayYCmsKR/Q2MWolgveSxfsOLx7QwJIFYyeKeLkmhZj8FwO?=
 =?us-ascii?Q?ba4V72TCZZHFW5Z4Qk4rK30uon6y6zhgaPQlOz3pfy0Iu51X3lmZZFTg23F5?=
 =?us-ascii?Q?c2FA/slMYiDWXeSQF7aXdhLpWn9Fni0B4L/w/nHebQ6TK4WGzm97joRosiw4?=
 =?us-ascii?Q?ssXOyfeV9K5TTYot0PWTm8so6Bm9UPko5rv/RIZ97dJH8ZzrZsSGoYCAmEIL?=
 =?us-ascii?Q?WYMRsAOtK4Po4MrlscSBoe8Qnw4f0+jsSijT8OZcEIRNY5FPJr9o6p5DhHDU?=
 =?us-ascii?Q?viGwRQya1s+ygOccoXSgh436LEi8c3ygUxtcrB1e21ofE3IozzFzOLyGBg22?=
 =?us-ascii?Q?VUYCbpnYNQi0RniF4G9pl+Dbesd9sT+hBPVVTj6ukU1/37wcWghZlFOx5GqP?=
 =?us-ascii?Q?eDzAxSgqVbOMz0xXGgy/OYnBHfgoZaVzvtN+VDZnQfSbk6KE9HCbS+VIbfI9?=
 =?us-ascii?Q?+TD6URzI8Iy9PMfKo+CaYZABsrUvye0Rxe6WYsNGVHy8GiD+94fzw8dvccr8?=
 =?us-ascii?Q?8f7BTcJ4YBRUpTUbJahx41MLA34HOorQK5GkYWdr0L+ynKRnou1flolFhYWK?=
 =?us-ascii?Q?6gmBReCwPvgkdDqoj4OGBZfiVJt+fes=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PN0P287MB2531BFD1D63007182EFA3E5CC561APN0P287MB2531INDP_"
MIME-Version: 1.0
X-OriginatorOrg: iwave-global.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 71cdaa07-3d17-40b7-37f8-08de6aded967
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 09:04:09.5585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 507ae903-cc48-4d6e-bdb6-35278120a345
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xp53I6E8GweJfamIX7ukNPBUm1E52kBpXEpZsLImSgNMnMZMTPt43AHrUcihJdVhVLLH1wdsCLrE8WaNr6qvHH+IGFy3mCgSuopJCCv9JOn75zuc7b0lYufvhcAOrT/R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN5P287MB4370
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

--_000_PN0P287MB2531BFD1D63007182EFA3E5CC561APN0P287MB2531INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Ernesto,
As an additional observation, I tested the setup using iperf3 and was able =
to achieve throughput of approximately 92~95 Gbps. However, when running th=
e DPDK-Testpmd application, the throughput does not reach similar values.
Thanks and regards,
Ayshathul Thuhara

________________________________
From: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
Sent: 13 February 2026 14:24
To: Ernesto Ruffini <eruffini@outsys.org>
Cc: 'dev' <dev@dpdk.org>; yasu1976@gmail.com <yasu1976@gmail.com>; users@dp=
dk.org <users@dpdk.org>
Subject: Re: Guidance Required to Improve Throughput on ConnectX-7 (1x400G)=
 with DPDK v23.07

Hi Ernesto,

Thankyou for the suggestion.
I will look into "https://fast.dpdk.org/doc/perf/DPDK_23_11_NVIDIA_NIC_perf=
ormance_report.pdf" , but here the tests uses external device for traffic g=
enerator.

Yes, with ethtool it shows 400Gbps.
The module can support upto 100Gbps. But it should have increased more than=
 10Gbps. I will disable AN and check once.

Thanks and regards,
Ayshathul Thuhara

________________________________
From: Ernesto Ruffini <eruffini@outsys.org>
Sent: 13 February 2026 14:19
To: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>; users@dpdk.org =
<users@dpdk.org>
Cc: 'dev' <dev@dpdk.org>; yasu1976@gmail.com <yasu1976@gmail.com>
Subject: RE: Guidance Required to Improve Throughput on ConnectX-7 (1x400G)=
 with DPDK v23.07


Hi Ayshathul,

I think the best is to follow https://fast.dpdk.org/doc/perf/DPDK_23_11_NVI=
DIA_NIC_performance_report.pdf

Did you check with ethtool or similar the actual connection speed? ethtool =
linux-nic-name | grep Speed

Maybe your module limits it to 10Gbps. In case try to disable auto-negotiat=
ion



Regards,

               Ernesto



From: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
Sent: Friday, February 13, 2026 07:36
To: users@dpdk.org
Cc: dev <dev@dpdk.org>; yasu1976@gmail.com
Subject: Guidance Required to Improve Throughput on ConnectX-7 (1x400G) wit=
h DPDK v23.07



Dear Team,

I hope this message finds you well.

I am currently performing testing on ConnectX-7 with 1x400G hardware using =
DPDK v23.07. However, I am unable to achieve data transfer rates beyond 10 =
Gbps. While reviewing the DPDK mailing list, I came across your previous re=
sponses in the related discussion (https://mails.dpdk.org/archives/users/20=
24-July/007767.html), where you mentioned achieving throughput of around 25=
0 Gbps and above.

Could you kindly advise on the configuration changes or optimizations requi=
red to improve throughput in this setup?

For reference, I am using an OSFP loopback module for testing, where the sa=
me port is used for both transmission and reception (single-port loopback s=
etup).

CX-7 Firmware: 28.45.1200

CPU : Intel(R) Core(TM) i7-14700

Command used : sudo ./build/app/dpdk-testpmd -a 01:00.0 -- -i

I would greatly appreciate your guidance.

Thank you in advance, and I look forward to your response.

Thanks and regards,
Ayshathul Thuhara



--_000_PN0P287MB2531BFD1D63007182EFA3E5CC561APN0P287MB2531INDP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<article class=3D"text-token-text-primary w-full focus:outline-none [--shad=
ow-height:45px] has-data-writing-block:pointer-events-none has-data-writing=
-block:-mt-(--shadow-height) has-data-writing-block:pt-(--shadow-height) [&=
amp;:has([data-writing-block])&gt;*]:pointer-events-auto scroll-mt-(--heade=
r-height)" tabindex=3D"-1" dir=3D"auto" data-turn-id=3D"c60e2f95-9833-4b11-=
91df-92a348916f45" data-testid=3D"conversation-turn-67" data-scroll-anchor=
=3D"false" data-turn=3D"user"></article><article class=3D"text-token-text-p=
rimary w-full focus:outline-none [--shadow-height:45px] has-data-writing-bl=
ock:pointer-events-none has-data-writing-block:-mt-(--shadow-height) has-da=
ta-writing-block:pt-(--shadow-height) [&amp;:has([data-writing-block])&gt;*=
]:pointer-events-auto scroll-mt-[calc(var(--header-height)+min(200px,max(70=
px,20svh)))]" tabindex=3D"-1" dir=3D"auto" data-turn-id=3D"748d4d8c-022e-4b=
14-8873-ab0f35445357" data-testid=3D"conversation-turn-68" data-scroll-anch=
or=3D"true" data-turn=3D"assistant">
<div class=3D"elementToProof" style=3D"direction: ltr; margin-top: 1em; mar=
gin-bottom: 1em; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServic=
e, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<span class=3D"elementToProof">Hi Ernesto,</span></div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin-top: 1em; mar=
gin-bottom: 1em; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServic=
e, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<span class=3D"elementToProof">As an additional observation, I tested the s=
etup using iperf3 and was able to achieve throughput of approximately 92~95=
 Gbps. However, when running the DPDK-Testpmd application, the throughput d=
oes not reach similar values.</span></div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin-top: 1em; mar=
gin-bottom: 1em; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServic=
e, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<span class=3D"elementToProof">Thanks and regards,</span><br>
<span class=3D"elementToProof">Ayshathul Thuhara</span></div>
</article>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Ayshathul Thuhara &lt=
;ayshathul.thuhara@iwave-global.com&gt;<br>
<b>Sent:</b> 13 February 2026 14:24<br>
<b>To:</b> Ernesto Ruffini &lt;eruffini@outsys.org&gt;<br>
<b>Cc:</b> 'dev' &lt;dev@dpdk.org&gt;; yasu1976@gmail.com &lt;yasu1976@gmai=
l.com&gt;; users@dpdk.org &lt;users@dpdk.org&gt;<br>
<b>Subject:</b> Re: Guidance Required to Improve Throughput on ConnectX-7 (=
1x400G) with DPDK v23.07</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Hi Ernesto,&nbsp;</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Thankyou for the suggestion.</div>
<div class=3D"x_elementToProof" style=3D"color:rgb(0,0,0)"><span style=3D"f=
ont-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,s=
ans-serif; font-size:12pt">I will look into &quot;</span><span class=3D"x_e=
lementToProof" style=3D"font-family:Calibri,sans-serif; font-size:11pt"><a =
data-auth=3D"NotApplicable" data-linkindex=3D"0" rel=3D"noopener noreferrer=
" title=3D"https://fast.dpdk.org/doc/perf/DPDK_23_11_NVIDIA_NIC_performance=
_report.pdf" class=3D"x_OWAAutoLink" id=3D"OWAeff86e8d-ad77-3696-fe19-ea870=
b99fa63" target=3D"_blank" href=3D"https://fast.dpdk.org/doc/perf/DPDK_23_1=
1_NVIDIA_NIC_performance_report.pdf">https://fast.dpdk.org/doc/perf/DPDK_23=
_11_NVIDIA_NIC_performance_report.pdf</a>&quot;
 , but here the tests uses external device for traffic generator.</span></d=
iv>
<div class=3D"x_elementToProof" style=3D"font-family:Calibri,sans-serif; fo=
nt-size:11pt; color:rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Calibri,sans-serif; fo=
nt-size:11pt; color:rgb(0,0,0)">
<span class=3D"x_elementToProof">Yes, with ethtool it shows 400Gbps.</span>=
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Calibri,sans-serif; fo=
nt-size:11pt; color:rgb(0,0,0)">
<span class=3D"x_elementToProof">The module can support upto 100Gbps. But i=
t should have increased more than 10Gbps. I will disable AN and check once.=
</span></div>
<div class=3D"x_elementToProof" style=3D"font-family:Calibri,sans-serif; fo=
nt-size:11pt; color:rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Calibri,sans-serif; fo=
nt-size:11pt; color:rgb(0,0,0)">
Thanks and regards,&nbsp;</div>
<div class=3D"x_elementToProof" style=3D"font-family:Calibri,sans-serif; fo=
nt-size:11pt; color:rgb(0,0,0)">
Ayshathul Thuhara</div>
<div class=3D"x_elementToProof" style=3D"font-family:Calibri,sans-serif; fo=
nt-size:11pt; color:rgb(0,0,0)">
<br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Ernesto Ruffini &lt=
;eruffini@outsys.org&gt;<br>
<b>Sent:</b> 13 February 2026 14:19<br>
<b>To:</b> Ayshathul Thuhara &lt;ayshathul.thuhara@iwave-global.com&gt;; us=
ers@dpdk.org &lt;users@dpdk.org&gt;<br>
<b>Cc:</b> 'dev' &lt;dev@dpdk.org&gt;; yasu1976@gmail.com &lt;yasu1976@gmai=
l.com&gt;<br>
<b>Subject:</b> RE: Guidance Required to Improve Throughput on ConnectX-7 (=
1x400G) with DPDK v23.07</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
@font-face
	{font-family:Aptos}
p.x_x_MsoNormal, li.x_x_MsoNormal, div.x_x_MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",serif}
a:link, span.x_x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
span.x_x_EmailStyle19
	{font-family:"Calibri",sans-serif;
	color:windowtext}
.x_x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:72.0pt 72.0pt 72.0pt 72.0pt}
-->
</style>
<div lang=3D"EN-US" style=3D"word-wrap:break-word">
<div class=3D"x_x_WordSection1">
<p class=3D"x_x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&qu=
ot;Calibri&quot;,sans-serif">Hi
</span><span style=3D"color:black">Ayshathul</span><span style=3D"font-size=
:11.0pt; font-family:&quot;Calibri&quot;,sans-serif">,</span></p>
<p class=3D"x_x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&qu=
ot;Calibri&quot;,sans-serif">I think the best is to follow
<a href=3D"https://fast.dpdk.org/doc/perf/DPDK_23_11_NVIDIA_NIC_performance=
_report.pdf">
https://fast.dpdk.org/doc/perf/DPDK_23_11_NVIDIA_NIC_performance_report.pdf=
</a></span></p>
<p class=3D"x_x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&qu=
ot;Calibri&quot;,sans-serif">Did you check with ethtool or similar the actu=
al connection speed? ethtool linux-nic-name | grep Speed</span></p>
<p class=3D"x_x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&qu=
ot;Calibri&quot;,sans-serif">Maybe your module limits it to 10Gbps. In case=
 try to disable auto-negotiation</span></p>
<p class=3D"x_x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&qu=
ot;Calibri&quot;,sans-serif">&nbsp;</span></p>
<p class=3D"x_x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&qu=
ot;Calibri&quot;,sans-serif">Regards,</span></p>
<p class=3D"x_x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&qu=
ot;Calibri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ernesto</span></p>
<p class=3D"x_x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&qu=
ot;Calibri&quot;,sans-serif">&nbsp;</span></p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0c=
m 0cm 0cm">
<p class=3D"x_x_MsoNormal"><b><span style=3D"font-size:11.0pt; font-family:=
&quot;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11=
.0pt; font-family:&quot;Calibri&quot;,sans-serif"> Ayshathul Thuhara &lt;ay=
shathul.thuhara@iwave-global.com&gt;
<br>
<b>Sent:</b> Friday, February 13, 2026 07:36<br>
<b>To:</b> users@dpdk.org<br>
<b>Cc:</b> dev &lt;dev@dpdk.org&gt;; yasu1976@gmail.com<br>
<b>Subject:</b> Guidance Required to Improve Throughput on ConnectX-7 (1x40=
0G) with DPDK v23.07</span></p>
</div>
</div>
<p class=3D"x_x_MsoNormal">&nbsp;</p>
<div style=3D"margin-top:12.0pt; margin-bottom:12.0pt">
<p class=3D"x_x_MsoNormal"><span style=3D"color:black">Dear Team,</span></p=
>
</div>
<div style=3D"margin-top:12.0pt; margin-bottom:12.0pt">
<p class=3D"x_x_MsoNormal"><span style=3D"color:black">I hope this message =
finds you well.</span></p>
</div>
<div style=3D"margin-top:12.0pt; margin-bottom:12.0pt">
<p class=3D"x_x_MsoNormal"><span style=3D"color:black">I am currently perfo=
rming testing on ConnectX-7 with 1x400G hardware using DPDK v23.07. However=
, I am unable to achieve data transfer rates beyond 10 Gbps. While reviewin=
g the DPDK mailing list, I came across
 your previous responses in the related discussion (<a href=3D"https://mail=
s.dpdk.org/archives/users/2024-July/007767.html" target=3D"_new" id=3D"OWAe=
131b2f8-ca05-2ff3-d67e-40e6b9de2cd3">https://mails.dpdk.org/archives/users/=
2024-July/007767.html</a>), where you
 mentioned achieving throughput of around 250 Gbps and above.</span></p>
</div>
<div style=3D"margin-top:12.0pt; margin-bottom:12.0pt">
<p class=3D"x_x_MsoNormal"><span style=3D"color:black">Could you kindly adv=
ise on the configuration changes or optimizations required to improve throu=
ghput in this setup?</span></p>
</div>
<div style=3D"margin-top:12.0pt; margin-bottom:12.0pt">
<p class=3D"x_x_MsoNormal"><span style=3D"color:black">For reference, I am =
using an OSFP loopback module for testing, where the same port is used for =
both transmission and reception (single-port loopback setup).</span></p>
</div>
<div>
<p class=3D"x_x_MsoNormal"><b><span style=3D"color:black">CX-7 Firmware: 28=
.45.1200</span></b><span style=3D"color:black"></span></p>
</div>
<div>
<p class=3D"x_x_MsoNormal"><b><span style=3D"color:black">CPU : Intel(R) Co=
re(TM) i7-14700</span></b><span style=3D"color:black"></span></p>
</div>
<div>
<p class=3D"x_x_MsoNormal"><b><span style=3D"color:black">Command used : su=
do ./build/app/dpdk-testpmd -a 01:00.0 -- -i</span></b><span style=3D"color=
:black"></span></p>
</div>
<div style=3D"margin-top:12.0pt; margin-bottom:12.0pt">
<p class=3D"x_x_MsoNormal"><span style=3D"color:black">I would greatly appr=
eciate your guidance.</span></p>
</div>
<div style=3D"margin-top:12.0pt; margin-bottom:12.0pt">
<p class=3D"x_x_MsoNormal"><span style=3D"color:black">Thank you in advance=
, and I look forward to your response.</span></p>
</div>
<div style=3D"margin-top:12.0pt; margin-bottom:12.0pt">
<p class=3D"x_x_MsoNormal"><span style=3D"color:black">Thanks and regards,<=
br>
Ayshathul Thuhara</span></p>
</div>
<div>
<p class=3D"x_x_MsoNormal"><span style=3D"color:black">&nbsp;</span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_PN0P287MB2531BFD1D63007182EFA3E5CC561APN0P287MB2531INDP_--
