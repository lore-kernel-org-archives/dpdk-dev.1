Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F76CFD376
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 14:00:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 187F5402B0;
	Fri, 28 Nov 2025 15:00:53 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011003.outbound.protection.outlook.com [40.107.130.3])
 by mails.dpdk.org (Postfix) with ESMTP id ED7D5400EF;
 Fri, 28 Nov 2025 15:00:50 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkEUQ6EwwKeAbT9lnTHo9FzL+AD2Xx8eZOtQb8rY/Yi8VbcbU2CctX/GrdGxecNvcpbyiH0Yc8PjZduiKYs9Su9+RLZqyrCaXBGiHsmB7zHsO1tk7bt3YYtEEgWsFclK8ItpEVR7nkvZNmZ2bhMsTujtvjUo+KgyMnSrkvcJYI7wWf/9EOeL8EaJ6EqitX5ffqY6jMI7QFB7Av0tuvwCukQjkcwMJqz/GJE2Yhs1/QV+O5RTvnvEkJtu7SF9bX+CwZQ1ZirvwUCQmq4QwXnMj8zVqLyQ+7EFYqZgw6IV+DiO+TOYI2rl0xZACdlbrtzHL3IkSN+rkrhUsplrVLXwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=u2+TKUSbQ84ZIl1Sur3mpytUkPaSkHUBfRkQBIRiEsKmJKx0y3Trm3SVDNAuL7gIgqzI6TC3GWV+5qOJjHbhPMp6X4usR6DFfrAr3t/Y4QZyxkLTDttt5XN3D9Xy5nFy3vQu5FSZ1Y0a9uYytZ6qNRtMW0buGTlrTG/9c6lat4OhhUDSin7RVo8p8Pbz/NOKJ0kAMQ3xsm0+5ObWBfadEN73UIT3TB6rpEVFnxFLkhVBtycXQEQ14SB6JhjYDCcocU5htX99i4sZdelRClxTWQ3vGSB4c3SpoMdb452n3KTPkzqbX62Nk+PAmWTuT+an387mIdBNXPO3G6aOwPToHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=RJ5EqX1wvppa2T2eG14U7SCsrvnr93TB8vvmUVQfpd9kwdp77F9KJaXWtRgzfHOIdQyRFZgn+lXZSFvAgzuLoc5ZLXZiXbWNssXqn2JDcH5F6OOKVwUI1nnnRlBY9Eib7R8Va3bdJGAcMqJ7I51Wlm+GCsGcsliY0ZEeoTU8Gxsp5QS0rXlZfUsgNoaY3qO9DKiW+DlSKBn3MoK1TV0bIQF4/UXckhzQN3fJ+rYSSWWSHikN5efJXloj/TDhkeQVUumy8aLryBOru74Bx9zenw/9cb1XIFEsqpGJNNv4lr/kN5WknIvmYX4k5ujWpOCGkGUOZsheilL0kmpNvlF9fg==
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by DU2PR04MB9083.eurprd04.prod.outlook.com (2603:10a6:10:2f2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Fri, 28 Nov
 2025 14:00:49 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 14:00:49 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Apeksha Gupta
 <apeksha.gupta@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>, Ferruh Yigit
 <ferruh.yigit@amd.com>
Subject: RE: [PATCH 5/7] net/enetfec: fix const pointer in UIO filename parsing
Thread-Topic: [PATCH 5/7] net/enetfec: fix const pointer in UIO filename
 parsing
Thread-Index: AQHcYG7c+KMZwBvtLUK/7JOULYAW/LUIHc9Q
Date: Fri, 28 Nov 2025 14:00:48 +0000
Message-ID: <PAXPR04MB9328B40F37B2B1753B3487A089DCA@PAXPR04MB9328.eurprd04.prod.outlook.com>
References: <20251128135616.2662164-1-david.marchand@redhat.com>
 <20251128135616.2662164-6-david.marchand@redhat.com>
In-Reply-To: <20251128135616.2662164-6-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9328:EE_|DU2PR04MB9083:EE_
x-ms-office365-filtering-correlation-id: 8ca6cb79-e0e6-4c7c-c77c-08de2e8688ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?5Wn3j2tzzg91WZN/cbBNzWclE5zfpa4i+Ur0aOkcD5xe0YMxUwAwX2+6pcVl?=
 =?us-ascii?Q?PATYsXDWi8AGNpO20oksbuPlW5bA4vIF3plB0ETHCSO04oTXFeEUyNH7klZu?=
 =?us-ascii?Q?lxRL9+Irs8mcuwtaa9uOEKISLZ68IyEdeUKDGiEsgySYsunGefZC6kgxgljU?=
 =?us-ascii?Q?HiMjG4tLskDna1lxQd+xEFMHC4tExr+jCgadvEEURF/jsDkGzak+vrw5ztc2?=
 =?us-ascii?Q?Zvk2cKtm3qUHkZ3luLSAymu1SpqpFrmYkEWBUsxk1laQXnEl9Y2scUDyDoy9?=
 =?us-ascii?Q?9S8y3bkGJIivodrUtSvJ//FeIE34DIJYNUurJ3iNnlliJ40f9Q+fXkwpUeC6?=
 =?us-ascii?Q?xgWg1ho3hZgzKqZX8tuYLg55w2LOrHG78v3PNfiiNU2B/Ka08vzKsKEBXlDS?=
 =?us-ascii?Q?xNDjEnI+6S29s3N6chXK+FVqcdFkA81jsa9wOvxcIEj8Iu4Vo5uxqrAeaeW4?=
 =?us-ascii?Q?ffk2WDDmfC+jQsKZsupHHKzGV3CPtnaQerVIUiIiqYea5N5+FbMJLnEGamZl?=
 =?us-ascii?Q?1vrzMP9XM91bWUpq+wvKBbC+2Q2Vc6njI6W5iuy2qGwvd8pbdxrDYrhEjJnA?=
 =?us-ascii?Q?PA8rELvB0CPTpGetmEgM8LZVSaBjcWw5cszVeabxiilXqMu8iTol3KUTEu6y?=
 =?us-ascii?Q?iYIKkfEEDl0QMYeE5w490jriVd4iAkE8Alxu7WtxXNuyLaH969xa0F7POkoV?=
 =?us-ascii?Q?Wf6BEkm8P26xMOBF8SVMtussZe2rw6we/ogekaWm/Fb9Q1i/eyHQqCNgBiBJ?=
 =?us-ascii?Q?QTzcdoGE0gsZOqKI9bCT0KCKx6plSASKp/H9AjB5LPt6yeLar0RHcxAg+Fdw?=
 =?us-ascii?Q?2/T/Z9uiPbDOdCQg7ufJMzbQW1MboC1HMTzFukThnV0SXCWA9CcaTPrwYJRO?=
 =?us-ascii?Q?AWly/Onks2bIqXQEX3yTP8y5s3sRl5jI6ypfiYa9Ub8wge6T0zWnNetWJQpS?=
 =?us-ascii?Q?BHMsWnhDJvjFPLMuDqBhexJsUVNqJuaOD8uWG5RnsNAf7Z8Z2CpeBvA+UDuV?=
 =?us-ascii?Q?LM/u4EuduVeSTH4cjUci6z+kIdenpHZigs5SGs1SP+JMTlSBaJ6tudGtH+pF?=
 =?us-ascii?Q?6F1YgNU5nSVHQFHx07XKwzKKAwyGh+ANEI89OJMdP72pwSgGJGsqwaM/RSRc?=
 =?us-ascii?Q?6zseCb0pwWtLQoEg5f7gesroZk5uN62ugBnAP0eys04SwYi+4gb09vUIdeVX?=
 =?us-ascii?Q?uY4Yg3VGaqOKWKHmimVjlUpoL/5UVcRBaF+SNvuXOvD04XzWkklzlGwvgqh2?=
 =?us-ascii?Q?DQ7CfFasEQUraSZQsP9e+4M3SCMyhHIoKtR2yKzJG4rONxtx8QGrt5lXRWnb?=
 =?us-ascii?Q?66kMlw9W8jc1XpIdTqhu7zmZyJ4IprcRg6FbnUE5tNV3+/quPcdccK5oOrmV?=
 =?us-ascii?Q?mFWBSFZsd3fcbwJLs0t7lSAKwi9J20j6ShHkuapEoizvf4+XLqt8mZ0sO6iT?=
 =?us-ascii?Q?v8fSduZ5NUG4NmC5ewHElZbZz/oUrqQIMn6fLUpEG5+U5VAqa9xTJ5oijNHa?=
 =?us-ascii?Q?JTF+/3DkEE58edGH4+g4g1yRgKzUhoDGQS5W?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wjH7/wVgEBP2/zZLOyM9aXyGyrQHv6mPsVZjx1rc+LdWNeU4LJHI01Qzg73W?=
 =?us-ascii?Q?m/2fNypmXES3KM1XqJblMtzBHB0Wm2Ln6N/2cCxqvJG2N0oErgpuPh3ER4LR?=
 =?us-ascii?Q?k83ZM3hPO4Lkf0re3d3l3Y7ipBaF1VHykzh3fp/QD+qpB9yHGlRUOnDW5XLR?=
 =?us-ascii?Q?G6ZeZfKuP2hLufuK6O3HJ7OzSfWpPUj3arDvvR0PqVhwNqQMK3DkkG+vF8R+?=
 =?us-ascii?Q?PGFfEcRat3cspBrZI2L8HDpHRnkxrZ1ufHlVvP50tfArlpTLHtGRR8i2859S?=
 =?us-ascii?Q?wbhIcvHIEu7ecZspFh8oL73D+MkVm1uxrEM2b7MJ0Bhz80BSwRmKUMwELJJX?=
 =?us-ascii?Q?89Y7OAa69nnmnU/3FNcUkFL8AIejf5FxgO/WzCu3HY4pn7ZTVp5wTrEEfbZV?=
 =?us-ascii?Q?ol6RdobjOGpLmhNRdUyiEB2yY5Anrg5O149QPxpGwhq5hiVDA+7+0xBWTB4q?=
 =?us-ascii?Q?Pa9jDaA6nXnfkU6OlAOstm2t0IiYvauz7Q+9RTiIBaE7D2o6WIiWkVGn9+oo?=
 =?us-ascii?Q?aqubXvPycSKFV6JAgGJFBcvR0c6GQCOm3c5Eay7cIAVlf+gvnPZ4LhhU65v+?=
 =?us-ascii?Q?CIYgrSLPm1ZAVlzDN2nssHU+8PyUOMLKl9ZJyMowj4xtSwDFlAPO+I0udx77?=
 =?us-ascii?Q?zoeAWfWYaeAiC/PQA+SQ1UORG3EXF3VoS5nXDDlCiHZcxWz018+UwxyDAnXT?=
 =?us-ascii?Q?4we4AkMvpk0pcwVkRkufaMkJ/isIW2MoqeRlyULZRxGfGpNc3Tb4DdMY7wG3?=
 =?us-ascii?Q?jczzIF+UHW6SutOaS3b7IY6Aex7RBR1EYAovI+dhPVXNdGmMZ4PYOfem9+6O?=
 =?us-ascii?Q?BijGygPdzM3c/UW53TvmRo9sPVfvqh/BDAn0gnUD53lVeGxjCI4fHDH2ufC/?=
 =?us-ascii?Q?dugbiiggyE2rtyihixKpeiN6dih3Mrf4SWI4MfKqHa1CE3SKn9h67YBbjBIc?=
 =?us-ascii?Q?epuEvMM8hp+Pz7amfj0SwebRkYdc/gkTcaDVNQ2SBmWgVD26kAI8MSTgFi04?=
 =?us-ascii?Q?E4qReoG5ise1exC/MtRR2xlVYzoEeftBu4iT8dkQwMC7ROf66DhOawcEFyzk?=
 =?us-ascii?Q?xz11iRMedpUHjsm7fJG1eqBG1QFm33RdCuIoSsZf5bhKVRngeqBHJy7WgdLC?=
 =?us-ascii?Q?EkWY9FmxBNSSPOU9V09m6wO1v+18oAgJu+fvYwdFJ6Cw8QR6kdEJPrmcW7yO?=
 =?us-ascii?Q?+t0NpTgwwZrOPSKvJQgYFO7vlb192I+6RDzTQ1XCg1piykqEHSgx/D7FRF+Y?=
 =?us-ascii?Q?awStlQSVVm4G7qktFYnNKdDcZsEmbZIELE0hHK9CDXL6byE7lFFaYvTqXhTn?=
 =?us-ascii?Q?CfeZzJORFhLlZW043pwS6boA1vzbcmVlw7Dm6WIhP9AkGBwOJx5P91ExapKK?=
 =?us-ascii?Q?xcn7TKehhx5w1p3LRJfrtT9crRsXMbN1Wevi2FEDIR4vm9MlmSK4pJWiFNa3?=
 =?us-ascii?Q?KXNtwL8PfFl7ukJc55xcg0eBVrfJRUIhgPCC0YaKOK8PArqNrTxhKjcAe58v?=
 =?us-ascii?Q?QF/5bTKHmCCkhj3fjHU54BVJ/Snr5k51k6olfZEjRNdYxpwQfujSqPPMBerj?=
 =?us-ascii?Q?jt250TYVYQqsaYlOM1oOneXfL3E/aVJXr5kbP3Xl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca6cb79-e0e6-4c7c-c77c-08de2e8688ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 14:00:48.8528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3vdeqlp9dQccIFSwf2tx3H9c5tWebbZRxZRDVn/78E30Ds2mBjddo4jH3TUOExUJlTVpdAgnxiAhnLjQjzr3rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9083
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
