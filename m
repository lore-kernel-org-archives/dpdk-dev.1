Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2A7CCA468
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 11:48:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CE5F400EF;
	Tue, 30 Sep 2025 13:48:52 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id E86BB400D7
 for <dev@dpdk.org>; Tue, 30 Sep 2025 13:48:50 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11021130.outbound.protection.outlook.com [52.101.70.130])
 by mx-outbound23-224.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 30 Sep 2025 11:48:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WF6isjm7C2VZAZIECbBp6njd46+yglvA1wKZJENISiweAzUYSEeYp8se95tXt8VCHZ4qjSS5rZqtg45Bqt7YIQ9zqTSLp3P9jGNu37nVJLh0kCcUyM6YaYlFshKut4jWybJsirWdSJTkqrqx6qfB40zB9q1uZHB3M/4ynId6KRD3EEwWjaHjXSM2DsIZm35F8y4K9uXxNl5a+5OpPwYkv1c98Or4EvDEGeJTc4qs6sTf5grzRwCtQoT6OeXGedBjbR8Bl/bNjWFLwAALTn23DWzwihVdPvza95x14mtFopTECt/b71H8DLFOmyxe2kRqVPM/X5RA9pc6EjhEhooDhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHSnt3aqy10sgbvJHPTPEW1xb2V3ayky/Uw+KROcPMc=;
 b=ZujuzxTBsMfLqEuPV7vXlI7WU0lFkvsvI9rAwjn+SoYzlus1pAay/Z4poF/i0ALsfZyxrERARSm0gemhCIRrwD7R0OGSJHOMAoQOrAj1IH17++l+/QfohlSQY0YTD6Tr3Rnh02rKTNdOcJTrDF+tLo/blIvFs458fvtvyseYU+1R8GDNE4QcFsTy5fwoHRExKuXdWUYM5mYLjPeZHBhNS+j3CFfkrRljbwF6+GWvLokOK5gjKGuHImDU4VVrBg0NJ+07y/KoSndZGr1p/g05x9DiVOsQG/j7WvzKn3ZYltGrBeaGc2K16wVQSLV762DMFYm7wre0tvYmcfbbxCYseg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=napatech.com; dmarc=pass action=none header.from=napatech.com;
 dkim=pass header.d=napatech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHSnt3aqy10sgbvJHPTPEW1xb2V3ayky/Uw+KROcPMc=;
 b=TwiHdT89QlaTpPI1sY292bwM9ypEyEuPAolTGqaR427dvm16Eb6VUd2C8pL/tIaLcAvFCBfZiaPrp0I36ezPdZmS2pDCFhV5DHdf5d+oFHbUO8qUnf62mgJcfpPoMznhHD00tIj6hE6eCYgl3sw6JJ8MQBMXDDZzjDIDYx7MDQk=
Received: from VE1P190MB0830.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1a9::5)
 by DB9P190MB1795.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:33b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 11:48:48 +0000
Received: from VE1P190MB0830.EURP190.PROD.OUTLOOK.COM
 ([fe80::fb19:d808:3eac:2ea3]) by VE1P190MB0830.EURP190.PROD.OUTLOOK.COM
 ([fe80::fb19:d808:3eac:2ea3%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 11:48:47 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [RFC 0/3] net/ntnic: prefix global symbols
Thread-Topic: [RFC 0/3] net/ntnic: prefix global symbols
Thread-Index: AQHcLwI2GnBqbEYLBUmoniCZ/WfO+7SqLH5rgAAzCYCAAPsBSw==
Date: Tue, 30 Sep 2025 11:48:19 +0000
Message-ID: <VE1P190MB08303C1DE56E5B9F84D85229801AA@VE1P190MB0830.EURP190.PROD.OUTLOOK.COM>
References: <20250926162534.401577-1-stephen@networkplumber.org>
 <VE1P190MB08308308E532B306FCBCAE3C801BA@VE1P190MB0830.EURP190.PROD.OUTLOOK.COM>
 <20250929093323.67dc12f6@hermes.local>
In-Reply-To: <20250929093323.67dc12f6@hermes.local>
Accept-Language: en-GB, en-US
Content-Language: uk-UA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=napatech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1P190MB0830:EE_|DB9P190MB1795:EE_
x-ms-office365-filtering-correlation-id: a881fa7d-fc76-45b0-7273-08de00175129
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?lBeVxo0iSzZyJ4trxx1p10q4QxKCaNC5lV6aFWSrit0dxmCW/S0JOaaqd7AT?=
 =?us-ascii?Q?UO/90XQQJxzDqHuwvaxHkWwOxxztJI1TeYmbsqXSnfp8z4Uce44mw79ZmZwJ?=
 =?us-ascii?Q?zNOWWkaoziQzTeFdOmXBHjbyOw+4zAuYdMF/uKygn5FO2ohY0WkWaS0vnJ4J?=
 =?us-ascii?Q?ulbybCts+/C9Q/Sp9loppB9k5op6XYTaEPCL8za/pRgZOyV87dTwhhHht/I7?=
 =?us-ascii?Q?ZCLXvs6c7ofkK7k10yezfQuLac1XUlfVKpYTFhrngYe9ZA7WN5vBOwanxfT4?=
 =?us-ascii?Q?w/Jxt8HZivk1t+Zdbcq+C96CvbPTi2BJ5CwgnAAfrt7oJdJg/3dNb4OL9OWx?=
 =?us-ascii?Q?HaV94fubHeNCIT5u1F64rc3vAPYeRjI69y5chdwX8Dwh87ib2SzMZA/VHMA/?=
 =?us-ascii?Q?SVk0NHZilnycgCwLHJoAtuv/zwqoX4aSLuZ/3yK0ugu6aGq0zSeEKNbuUJut?=
 =?us-ascii?Q?5NsXFJnofp3xdWP1BinEIljcnnY7bHuPUNE58RjVCut+ShE/adjpw7TA9abV?=
 =?us-ascii?Q?39vw1TPo4aTO73J2CIQPb1grZHGtISLxtXOW8tqWHXDfjOSm6sgtLTCk1FWk?=
 =?us-ascii?Q?1WmEbc/jfb71KPMPDEtx+q/xDHkjxDIpBxfexN9tw9NUpNj2uFN3JUIdXciN?=
 =?us-ascii?Q?yufujtFjxRKogqZOFiRSMnthoiNZCybwS7OU49bV2MRLYvChFNNCq7/EhP1n?=
 =?us-ascii?Q?nBAdQJZwI/muzj1npzC/jxEya91gDjKFelyzl9rHJfUspCzsp07i55y5ttXw?=
 =?us-ascii?Q?uBYjVhSzi6hPxjqI+JhDeJ2CQNLIqT50odJkJKJpTU5MdqspL3i/cPnbQ1wE?=
 =?us-ascii?Q?IY7wV41k6fidqNbhBKktUkiRPRTdHRplvPiHfkgx3mrsUD0JIxN3j41AezJ5?=
 =?us-ascii?Q?ZJOOY5EE7HaQ1+38NEMRKCfLrMSBZVSWRRxA+rQNmpfcSJZBsDgDrKTadP5m?=
 =?us-ascii?Q?nq3wfKUMH2jE4REQtEZeLwmZr2R3bkAnWNGkcmKXV/NncD35l5P9vM3aAf7n?=
 =?us-ascii?Q?DezwnnRs90ohVg92z722xRbIqQox9KUbnocRDGpcgd1LTKj8esTJSTsnSFB/?=
 =?us-ascii?Q?EZUPbk26QQc2ESCL96Vy/kNnxOoGqHeZvTN+/iABt4NAKQgp8UBSZ2uvmTn0?=
 =?us-ascii?Q?2qmKPrp8tfFbjISwzZF0qJMpaALcuxt9BoKRsxErQlSrU0nQ2SGK+NMbC+ct?=
 =?us-ascii?Q?ro8Zl9iB2+avoQHPKMtdhnmHERZ8R7Qot1NCXc1zJEnAtIlWSzsyuXWDCeSi?=
 =?us-ascii?Q?Zzu072gHZ0aITdQcBvpdsQ+KeEYPIHyj5AM/EFcwmqnvTbHcOV/jp4Lu+/JH?=
 =?us-ascii?Q?5l0sIbBP+aWEAcZhaaCzkLgG11OcfIwc7rrsSWAq2vfqQ8T3kfF00YAWdbAV?=
 =?us-ascii?Q?fefqLErMBXJvZU4K9p2Alq+gczDWdTaMRIq3GvSRRSqxQzzUt0q65Ff89aYY?=
 =?us-ascii?Q?W4bTs3dCV+58aN7AL7qp+p4U0fU1shzU/tcE666KortTapp5C1jTjSF6eSkK?=
 =?us-ascii?Q?luQxHV+TWGJgTX7BQiFdFiBZ1S0nn/bB2zXZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1P190MB0830.EURP190.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(8096899003)(7053199007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AJ2NJyUml9ewnSy8qP70pZZEQPkTYlEU5ZMitb9nVHijbwUmWcWawhfAgRiV?=
 =?us-ascii?Q?qQxeHrUo0ks9QU8i+9pqqiwMjFkguBK2za5DDljZFS8l1P2E/nYW/swgfxNg?=
 =?us-ascii?Q?Mbrfp2+BpWG0IeHlSvyNhHBKkZJMtIcGXaeQDf0soCKEYTsYmSnYI6MyLu31?=
 =?us-ascii?Q?mG2S0QOzHZN5hUXWTbXjEKKN35LnYH0zGqrLXwRmdsy0dtkk+64XnMdXxMi5?=
 =?us-ascii?Q?w1FNJ1jop1yqFh/9vy4VQKDyDNweYWBKvS9kF9UumImzRXq7ABk5vc0e03sb?=
 =?us-ascii?Q?TkuDM4ZpdgqIH8irO+2FUKp4wakdZb4iD6h57zHA7KASp2oVOGmOiGq3uJBR?=
 =?us-ascii?Q?XGpktFcncIdTpy4dCPGVSVw/GxQVAHHAY988qe4/kQUuhLByVkylOxY5I2D0?=
 =?us-ascii?Q?qiP1tC1ualQNB5e43Me6IDs6AD4H8FIvM/yzc8P3RsgpZReE5qsUrybvAhbO?=
 =?us-ascii?Q?GAkvuUOzDoCo9ckHUtbn/TnSSjR7DjFlGxJu2MZpB2yk07QBlcCWJu5ieYEb?=
 =?us-ascii?Q?u1EuVUJtuWwiGFVvpLy75ykyM2LzOxj1zJJ+wMs5PrygPMvIw3kmseggcPHG?=
 =?us-ascii?Q?Z8kpYSOl5jvW37nne8oD3xuTAjy/2h4JEoalFt65FZpzbyfxKcOKeFW2E4Le?=
 =?us-ascii?Q?FWO95K1yDQ4DPTZX5geC7pAdfEgT1sHElDjAx3a9ZuMDjRCE+e/LvJvIAijt?=
 =?us-ascii?Q?FJxpIeJCP1osyTV5flZBlafsxI5TTtYvwQ4kFUR6LX090SkABtSPTbE/XWLT?=
 =?us-ascii?Q?IMwDAYjw/oKoDbRf8sS+KpRol6pTaoiSBYjWxDR6kL+Bf5qgaZ0QEc2ThRVr?=
 =?us-ascii?Q?xLr5u/20h9Su1S7yGdyEeL0XQNnS1oqVjVxK9AG84oXxVQ86AO5o0yODNw+p?=
 =?us-ascii?Q?naaotFuUFUhGG1P9SWmqmHD5qpuHxl1EidLPbbMZKZp3NJoB7swH9oybPrcP?=
 =?us-ascii?Q?kJZEZ24RUaVVhX5/IXWptXzMdtuLrlMu9nW/m8kDN4+2iushRFXPWIvG/cgr?=
 =?us-ascii?Q?fPQRjm0RKTGqO2mHg5fE09aIMuvekAIZQDBp3Xb6VD0NQqvIFqpTXSUD1PyE?=
 =?us-ascii?Q?eZKVRcGfPrnuQhUjAG/MUN6ffPeZAEDITH5A2eMfwxDzDZPo1+PuqMYM3sEY?=
 =?us-ascii?Q?fPAAHHD8t2YK8LX0QeN44Vma8yWWbmthtkdGR9i6eFH5l69h75sHC/8edzo6?=
 =?us-ascii?Q?ueHaIB8Qp5eL7w1k7j9JtVx4Mmm1ZncmjMK/3UA4NPItD7JwCfQr31Yr+1DK?=
 =?us-ascii?Q?MLjv2KUkBnw/o+s/d+bW2DSiJAGvEJMcB4JoLOInn9Wl2DWzfF3oSpm427Uh?=
 =?us-ascii?Q?yPMrVbtEO0/ZVLExkzyFyCJHW/O54UkSUlQ19SSL1dE2S+ceyTPfUBQUCzTd?=
 =?us-ascii?Q?NCe7FfYcT0RcufbovwLMgZHUQliEtmps7MbYqA4YEqB+9wydZ74AgJj5q9Lr?=
 =?us-ascii?Q?H80x0B8+Cd12mnpoPlXEW0oqKwQkjQB8vfHrHAqOV4xQesxovdTX/CvJcz0Z?=
 =?us-ascii?Q?p9NXC+uaC116ukHb3ImhlYLLcwCL6hZcA/Rye9hGkKbvg0oZlTHNM9agP/K2?=
 =?us-ascii?Q?1o33EIPMuCj1il3vWwu9oDlaaGi1UU7lok7scBHj?=
Content-Type: multipart/alternative;
 boundary="_000_VE1P190MB08303C1DE56E5B9F84D85229801AAVE1P190MB0830EURP_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nYlXjUaP6v91ldiJJ/sHBVTWZUhtnt4mUpm+sVk8jRZsmXetqj0K+8QPL2FQQ3E9ORIHMTxEPVQLhVp+xhjBDs4BU93xPj4AjE1Qd8PzFWkBu8BK/nVtIMMTdmPXwVB63Eger4UkEMS8GkOIiOmiJcNST65a0Ywk5sM2s9sSZ5C3iOjNF4apMno+Pc6TT72onagEIpuRyx0bnyxX68CII+h9xvAHwkEEebKuCcbjC+4z5RwgAgOl0FIpU8wiO6jfPQonOxBh0dNIVyaqt3wmwK7E7nCBXuqSRhOQ+7tV5frHDlXzjmOLSsUn3an4SLFiDGsCVPh38Gz9nTfu6RcC2gkuYkjT48wNluQ8NPng3FitCrTUgyFzHcl2Ddn3TV570EyDBNv4olaVlYcVyOoz88bnUr1EzZwOJLoLgm5QnWj+C8MTwn7qUpzZRLjWzvG2odRU0w0pfuED2WoerNZlAu9fTDLVmX78PnDqf1OO5POeqyiCbSEa94qr8Dn8E9nmzNbJiCjwXWARisosIADgRPtdv9op00vLMjMwAbrQAQ54KrPYBI4vxHq+MdBG8Zs9vzeU2kEiEHM1p/c1r3A1+KzX33DiNA1YrNabp+Zdv0pQZyEyyso78FDde+lYbAzcZaI5cHUxh9WstQprtKQHlB+hIxq/7DId5wVY3LsfoBs=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1P190MB0830.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a881fa7d-fc76-45b0-7273-08de00175129
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 11:48:47.8524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tQD944xaTyZRslG1BTI3xDrni6M8pJVCgSnzZrBgZ544uJtnLNtGJ4j7qM+oN7JDfcjL6Gj4Jea2j9TcaySVjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1795
X-BESS-ID: 1759232929-306112-7643-694-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.70.130
X-BESS-Parts: H4sIAAAAAAACAzXLuwrDMAyF4XfRnEGXWI7zKqWDLclkKR3qoVDy7vWQLIefA9
 /jB/EdsMOYu8D7AzvJts465pmzM0rqmtk52COsKfIaW1RhVziX2x/jdXnRVC5PtboQlo
 StkqIiWdTUDZu4WelwPv8K9zdlgQAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267864 [from 
 cloudscan21-167.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 HTML_MESSAGE           BODY: HTML included in message 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=HTML_MESSAGE, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

--_000_VE1P190MB08303C1DE56E5B9F84D85229801AAVE1P190MB0830EURP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Great. I will add corresponding patch to the next patch series.

On 29.09.2025, 19:33, "Stephen Hemminger" <stephen@networkplumber.org> wrot=
e:

On Mon, 29 Sep 2025 15:59:36 +0000
Serhii Iliushyk <sil-plv@napatech.com> wrote:

> Hi!
>
> The patch series looks good.
> Only one thought from my side is about consistency between prefixes for g=
lobal symbols for variables and functions.
>
> For functions, we use the prefix "nthw_*"; however, the patch series uses=
 the prefix "ntnic_" for global variables.
> Will it be better to keep the same prefix for functions and variables?
> If there is no strict rule, we may keep "ntnic_".
>
> On 26.09.2025, 19:25, "Stephen Hemminger" <stephen@networkplumber.org> wr=
ote:
>
> The ntnic driver in next-net is not consitent in prefixing
> all global symbols.
>
> Stephen Hemminger (3):
>   net/ntnic: rename nt_log_ types
>   net/ntnic: rename hwlock
>   net/ntnic: make flow_lock local
>
>  drivers/net/ntnic/include/create_elements.h   |  2 --
>  .../ntnic/include/stream_binary_flow_api.h    |  2 +-
>  drivers/net/ntnic/ntlog/ntlog.h               | 16 +++++++-------
>  drivers/net/ntnic/ntnic_ethdev.c              | 22 +++++++++----------
>  drivers/net/ntnic/ntnic_filter/ntnic_filter.c | 10 ++++-----
>  5 files changed, 25 insertions(+), 27 deletions(-)
>
> --
> 2.47.3

Sure ntnic_ and nthw_ are both ok, you choose where needed.

--_000_VE1P190MB08303C1DE56E5B9F84D85229801AAVE1P190MB0830EURP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:10.0pt;
	font-family:"Aptos",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-UA" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&quot;Calibri&quot;,sans-serif">Great. I will add corresponding patc=
h to the next patch series.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&quot;Calibri&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-left:36.0pt"><span style=3D"font-siz=
e:12.0pt">On 29.09.2025, 19:33, &quot;Stephen Hemminger&quot; &lt;stephen@n=
etworkplumber.org&gt; wrote:<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-left:36.0pt"><span style=3D"font-siz=
e:11.0pt"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal" style=3D"margin-left:36.0pt"><span style=3D"font-siz=
e:11.0pt">On Mon, 29 Sep 2025 15:59:36 +0000<br>
Serhii Iliushyk &lt;sil-plv@napatech.com&gt; wrote:<br>
<br>
&gt; Hi!<br>
&gt; <br>
&gt; The patch series looks good.<br>
&gt; Only one thought from my side is about consistency between prefixes fo=
r global symbols for variables and functions.<br>
&gt; <br>
&gt; For functions, we use the prefix &quot;nthw_*&quot;; however, the patc=
h series uses the prefix &quot;ntnic_&quot; for global variables.<br>
&gt; Will it be better to keep the same prefix for functions and variables?=
<br>
&gt; If there is no strict rule, we may keep &quot;ntnic_&quot;.<br>
&gt; <br>
&gt; On 26.09.2025, 19:25, &quot;Stephen Hemminger&quot; &lt;stephen@networ=
kplumber.org&gt; wrote:<br>
&gt; <br>
&gt; The ntnic driver in next-net is not consitent in prefixing<br>
&gt; all global symbols.<br>
&gt; <br>
&gt; Stephen Hemminger (3):<br>
&gt;&nbsp;&nbsp; net/ntnic: rename nt_log_ types<br>
&gt;&nbsp;&nbsp; net/ntnic: rename hwlock<br>
&gt;&nbsp;&nbsp; net/ntnic: make flow_lock local<br>
&gt; <br>
&gt;&nbsp; drivers/net/ntnic/include/create_elements.h&nbsp;&nbsp; |&nbsp; =
2 --<br>
&gt;&nbsp; .../ntnic/include/stream_binary_flow_api.h&nbsp;&nbsp;&nbsp; |&n=
bsp; 2 +-<br>
&gt;&nbsp; drivers/net/ntnic/ntlog/ntlog.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 16 +++++++-------<br>
&gt;&nbsp; drivers/net/ntnic/ntnic_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 22 +++++++++----------<br>
&gt;&nbsp; drivers/net/ntnic/ntnic_filter/ntnic_filter.c | 10 ++++-----<br>
&gt;&nbsp; 5 files changed, 25 insertions(+), 27 deletions(-)<br>
&gt; <br>
&gt; --<br>
&gt; 2.47.3<br>
<br>
Sure ntnic_ and nthw_ are both ok, you choose where needed.<o:p></o:p></spa=
n></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_VE1P190MB08303C1DE56E5B9F84D85229801AAVE1P190MB0830EURP_--
