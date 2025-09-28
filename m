Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED89CCAC5BD
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Sep 2025 01:53:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CB4640659;
	Sun, 28 Sep 2025 03:53:22 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010066.outbound.protection.outlook.com
 [52.101.193.66]) by mails.dpdk.org (Postfix) with ESMTP id D5A2C402EA
 for <dev@dpdk.org>; Sun, 28 Sep 2025 03:53:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wifsikYGqiQS06xzEk44ePo+yIio09umrspP/zaKuQWUaOFbJeJiecTl4VEyxcGatkhVUknLd8hyVibIpKqbGtrtuFnoBsXW/S0sbny/YGovF7g8yjsdNXO5lSWnnnXaT5FW5U8eb3rrfX+EXDAX1PT1Vx6Ry/4DhneK2xiAGzxMPrPDGzKHP1E4tmWlnvv6COD5DTFCJsP4/rpRYAKe0t3ty75hmaEeaafR6/4hZCKQcX7BtkN7DWWljpNjDfHiwaJ78Z6XKJ3smDigxo/JXBBmIyP6+CH+OZb8Ul3sQyw05AaRv0KwrpuoPrVlMWW6mas/OJxrtj69CvQO5a/i8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTChKYYvNlSHcgAdEuZLjXB6H23thmrod7G5pRZaOQE=;
 b=UfMzHD0VdL1SFNkUoRqMXHya5YjAXRfBW7MWkwYXIfnk0hd++pIZkYyazuTWg/84ABYEjI+BOIwGDgLOgYD35MMOW8v/qnz4/Xa0kjaH8/atQhhKcD3WP27QOBD6Wi6JD1ijBTuuc1BIZBdASksexQ/OT3fWQo4gHpNUxuVhK71G7K5uu/F226WvwGWH+j+Y875eehLcmqHArj/OWKIRLaK4JMQIDZI9RH/IcMP7GX978QkgoOblFNxPI2RWdOc/dkHBV+sT4uNMEjuuMwJQCBKBv05ol8PNb454YU/Hp/lfAutQ+/WZsNrpz0li/ZDm8+wLNiXUtwiZ1NnGW5OIxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTChKYYvNlSHcgAdEuZLjXB6H23thmrod7G5pRZaOQE=;
 b=fr4vSpt44xBgEmghPUeR1uW3kab9G1US8BgIrzgioHkV/JsXCaIFSEY4glQGDFWLI8kwss510/SJJbGJHqcdM7Zwv9X36VitCl/J65L1V6O0Bhobcg4JTbpJJs6Bffx3iL9QdCLpWCaVGN2Pm1UHB/RQ70tJoXu8RI98SAFV8Kblbiq3RExrk+605JDX89MAedLB6G7dsl9SPASzmfZWKkv8iG/ug8s6cMBXvQAWxW5qG4PMH/4F5/da9bul2B12jx4OlfWs6iIa8Q+OJD4t9LUYFTxfMx3OGrsJltg9e1r7nXSBG8edZNUWRleNz6Nq5Z25ELFEDVl0cojiNVfjsg==
Received: from CH2PR03MB5239.namprd03.prod.outlook.com (2603:10b6:610:a2::21)
 by CH0PR03MB5954.namprd03.prod.outlook.com (2603:10b6:610:e1::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sun, 28 Sep
 2025 01:53:18 +0000
Received: from CH2PR03MB5239.namprd03.prod.outlook.com
 ([fe80::7fea:1069:aa12:4792]) by CH2PR03MB5239.namprd03.prod.outlook.com
 ([fe80::7fea:1069:aa12:4792%6]) with mapi id 15.20.9160.014; Sun, 28 Sep 2025
 01:53:18 +0000
From: "Xu, Rosen" <rosen.xu@altera.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [RFC 5/6] intel/ipn3ke: avoid use of pthread_cancel
Thread-Topic: [RFC 5/6] intel/ipn3ke: avoid use of pthread_cancel
Thread-Index: AQHcLXQP2XJN+JYjIE23bi75hHqLPrSn2l47
Date: Sun, 28 Sep 2025 01:53:18 +0000
Message-ID: <CH2PR03MB5239F6E985FC44074E69A283FC18A@CH2PR03MB5239.namprd03.prod.outlook.com>
References: <20250924165527.268645-1-stephen@networkplumber.org>
 <20250924165527.268645-6-stephen@networkplumber.org>
In-Reply-To: <20250924165527.268645-6-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR03MB5239:EE_|CH0PR03MB5954:EE_
x-ms-office365-filtering-correlation-id: 1a90571a-89cb-453a-56e4-08ddfe31cbf3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|39142699007|376014|31052699007|1800799024|38070700021|7053199007|8096899003;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?e1BGgIhvT5owlYSyFiBTJ1HXGH8k42BqUfJockLaGgtlUyyTgGHPtw2+rJ?=
 =?iso-8859-1?Q?YE5YJ49/gwTTpLIFJcBlJf7jRQRBuTr6a+J8E6ic6OqIU3mhDb9btMA/IN?=
 =?iso-8859-1?Q?BkIYtlxcVNt9RSDsRH9ZUq1Gme1oe4hvF5SYjnC/E6y/sdgoKkN2aoZJ9K?=
 =?iso-8859-1?Q?CZxf/VRZ7P5pVZxesQahw6ypSTXMaOgbBXtKCTfDH5eUyZ9ERKvJAoi7nF?=
 =?iso-8859-1?Q?5I5w3cdzm0xu1OQFv79evSeEKkCPJSUCogVpNkYTZcKj3RrOJ0yZDF2sqz?=
 =?iso-8859-1?Q?t4UGQsiz6oxYIdODn3ivhAda4FWGjAKcjlpHd8MkLGoqQESExGiOm4R/mk?=
 =?iso-8859-1?Q?RhknPcAofnh+KXmeTkZlRVO2DdMlmJ/n1+m+JWFfcpyxhN5vKINNhU879E?=
 =?iso-8859-1?Q?MygQELJ8KcwGk+2GQUUwTXDoN9SNw+BoDiPxgDn2Z8SouAEmbwAMWpfWsc?=
 =?iso-8859-1?Q?7OCzea6qCK6lYyickEYpuAQoiuIxYBbb07mm4qc2n2Ag4zVfoO8uJqI3vL?=
 =?iso-8859-1?Q?IBK/pjvsu/Z8OtHO5novoGYXklE+Nwubopb7/9YOujqQ7POckan7j9ka86?=
 =?iso-8859-1?Q?1FmXz7EE/fpxSBn8YsH9OuIy/UcQh1fZL3b8+0Y3E/TrESYjtNt0OzaU33?=
 =?iso-8859-1?Q?fjjZQZ7ww6jyfTMSyoJX4djiMp0UdbPRC618ZdWgGrEncDbP/9KQBSFoSQ?=
 =?iso-8859-1?Q?xS95cK82PBu+3pTTXhog86vJgv9hekNOCEOEj5p+H5wVbC6SaEyiQmPU+w?=
 =?iso-8859-1?Q?S7eNugPstAtszlfei/UfIj9GaDM+hyEQMiWHyqPIR8WT7nqTRA7JPiRAbB?=
 =?iso-8859-1?Q?jjUvBB+8nvF3ZdH14Befhu4YebiwXis9LbhX2Lk7ZcIwOA4e8YWsIMwJp/?=
 =?iso-8859-1?Q?USMmIgjnPHFFsSmFyzP/kVNubPv7XlYEgwG3LFzv8uiR4K+URd/HLlfCdM?=
 =?iso-8859-1?Q?sOW45fikKSp1e/n9J2YJaOI1/yvE17MQN+W8pvLgFxWWE6MAt0eSYcIkPa?=
 =?iso-8859-1?Q?pA9bQEG4era5x1lQjxr65tQ265CJIkwyZJZOrcsqxRIxD1HIRCcQvZavV2?=
 =?iso-8859-1?Q?fBHpIAPcEYLEFryjzb7muYSo7Jbg+jLlpMYkYT6luk7mYw5Htumv8KJu/G?=
 =?iso-8859-1?Q?hXxKs80xDPYuT73/qW6xX/WWUGW8dEZ2SGJPNHQpwBX45wPjbUkAziXih9?=
 =?iso-8859-1?Q?6s6JGYIUKOGnfNQxLVMxyJxf8TEtHrY1XWCI2MYk3sXQPmkLMs3NSQHqCJ?=
 =?iso-8859-1?Q?nLbCCxfnkYX3BWaF8y/yODsfcS9PEEWxBAOMaT0YoZa1m15qqqMi6OKQ01?=
 =?iso-8859-1?Q?W91YarUW1f7RqgloWtNYsZ4Q2uSkzDPMezGfItuDaAaHlJ8wnc5us7niH8?=
 =?iso-8859-1?Q?u50ThIJXWVRjOu7yRk6Wj4qMZ0VFaMrz0ELV2zanfszToEYvmXzsIB498E?=
 =?iso-8859-1?Q?rsNlt5axwJSRChtyGEwRaJ8jksryc+8fsz7zkSSotFdnMNu78lRThx6SYr?=
 =?iso-8859-1?Q?hupCodrRW14Fc4DjvOY2FsnCSL3RnQwmlN9lWdnUcVELmROLfJwzPkuUm/?=
 =?iso-8859-1?Q?cQQihx/rFtLA0YnMyl8gTo5WdoTU?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR03MB5239.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(39142699007)(376014)(31052699007)(1800799024)(38070700021)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5v3BWeAahTidzBASDyocyJiRpisTnXjCOaxCKMFHAHt4tdXdyJw1YdSyC8?=
 =?iso-8859-1?Q?x6b5QhDCtusPLApvt7zGYWPmWx3UN93wKDhEVsCzofC5w7iEzW/qiQKatf?=
 =?iso-8859-1?Q?gPg3paKOVOwrEWio+uQbjgnDW83nKdESCFGACTYgMYANhirFlumvFh0EQp?=
 =?iso-8859-1?Q?z3Rugrujq6dWt2T6TxNCZCeGW+vaXhbmhPsPcMhsXqmYn+UftyxgesAnfg?=
 =?iso-8859-1?Q?TiLBm7IrdX95kkG/E+T0MtqxZLgip5Fv2DIDfLUS9lSpwFE9FmoCbNTwKs?=
 =?iso-8859-1?Q?BWlWJXutT8zwRquSgNW1f+GhftQaVINNNB+wVcbtW868hpo10sWw8m4b9P?=
 =?iso-8859-1?Q?qPuTmoPqwXfZewKLIVdsXd615YsDKSxjDb1GnBsdvpaNAaCW1eKk7cRc9C?=
 =?iso-8859-1?Q?T7H4OrwXOZDbw3ULn5wnKylYBnKjnojBY7K4zo4gaVzHoWiVuhd38AcVnB?=
 =?iso-8859-1?Q?4R/AGFtVDgTV/CJFbvCtElM3mBGrp4TNzOG6yabQhJHgG5UetwmRvOUGXF?=
 =?iso-8859-1?Q?pC1iNxNO64ii5iZ6TD0a8P6svaUl8XMFAEl39yqsdqKY4wr7IQcWS4LpoO?=
 =?iso-8859-1?Q?W9SJwjrw7vo0W3Ti7rntmJENkoZYLH3VBKdbZLLumLZQckq83O7J65yast?=
 =?iso-8859-1?Q?j/vg5Abo825rsd/ifxbI1/S3BN3ynNCVoO2c+QYg8BBOmKdplxQcpAovsG?=
 =?iso-8859-1?Q?HtTPCw8ChFMlpfgYI2r5738BSGp9njCyJRUUMzoDVrnoAC6j7rAph+N4El?=
 =?iso-8859-1?Q?/jsFYTR2VYsJOvghW9JIhKud+MGy3cOZ+haQHVHA2FDrLLWqvqfA7aSCeE?=
 =?iso-8859-1?Q?GM5DCiWCktxE+JkAUKZQWr83hHI576gJYrrD0P9ih3Ad5DbsaE9osWtHam?=
 =?iso-8859-1?Q?qJ8ZH2621Unj+LCt2MJWiRvN2kUoe2UjKTA6H9bU3/nGHXO9S+ZQCvjUAF?=
 =?iso-8859-1?Q?5fwq8J/UP6HSEBEE6momEBszBV3QlvgH5wSXr3FvNz6rzws7J+IKyrypWE?=
 =?iso-8859-1?Q?0jACz1fPwPQAnkXCs+IN0nXuB8knWhrs/s4DXcDra+5PUyKCMM0HCoQAgg?=
 =?iso-8859-1?Q?odFtWDh48QIQqPrVEdZ+Bm8sRgimBTe4/dmdhhiNT9+fnSgf+PccNG/LT0?=
 =?iso-8859-1?Q?muG9uDYB7cg4LmZ+yRwCB+22XsmhlQKrN2wlyCBclt9CrOPEYW6aa9d68W?=
 =?iso-8859-1?Q?CAbcD2vKwuJn54abTb0yF6dhl7uHyUk1YQ2q+IVA3ZxWC2QALAYBiMwKdu?=
 =?iso-8859-1?Q?AG5WbJeAQ4cmx/aT+Kp/Z8Gs/MyVqxpo/ZAbtaBC6nzGmBXvd5gNy3+pJ7?=
 =?iso-8859-1?Q?mCgaMbuKs80SE/IMVtqYsozFyeHqMD+/HLOfo1HWIgxBnkRMVit0VQLWMv?=
 =?iso-8859-1?Q?Vq3GEoB+91AjZSRnQYFgo1V16MO623Ofuq5c44jmwROa3D01I2IaL1MhxY?=
 =?iso-8859-1?Q?Cyu/iRx7N2eNglhnxiX49vvvwoqOjNm/qzVRwNb8dyVfo17uqjAVgUbNF7?=
 =?iso-8859-1?Q?uoPEKjUDIhaqBoVxbaSjCOCBr7WQH5E5zDyPxIxS45dD1PC4/W0Q/XENnT?=
 =?iso-8859-1?Q?jqwiDoPEBfpLSEj33CyAMZ6zhNYffAAGt28zbcypjsgLHMpZMvgq7PuT2n?=
 =?iso-8859-1?Q?fmOa0cDnHyWNVw1QGCTsFeFFtkknb2F9kS?=
Content-Type: multipart/alternative;
 boundary="_000_CH2PR03MB5239F6E985FC44074E69A283FC18ACH2PR03MB5239namp_"
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR03MB5239.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a90571a-89cb-453a-56e4-08ddfe31cbf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2025 01:53:18.4917 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y8nSpZLKBgKc/bLDAa8QIlso7Ex3qlhJBQ4zTAPgbBoFQ43uuZdtmDBlFQ3eJckz4u5dtvEX87ImBqNw2/mjvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB5954
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

--_000_CH2PR03MB5239F6E985FC44074E69A283FC18ACH2PR03MB5239namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

________________________________
From: Stephen Hemminger <stephen@networkplumber.org>
Sent: Thursday, September 25, 2025 12:51 AM
To: dev@dpdk.org <dev@dpdk.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>; Xu, Rosen <rosen.xu@alt=
era.com>
Subject: [RFC 5/6] intel/ipn3ke: avoid use of pthread_cancel

[CAUTION: This email is from outside your organization. Unless you trust th=
e sender, do not click on links or open attachments as it may be a fraudule=
nt email attempting to steal your information and/or compromise your comput=
er.]

Can use the existing reference count (scan_num) to control
the thread without using pthread_cancel.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/ipn3ke/ipn3ke_representor.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/ipn3ke/ipn3ke_representor.c b/drivers/net/in=
tel/ipn3ke/ipn3ke_representor.c
index feb57420c3..4e831c6924 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_representor.c
+++ b/drivers/net/intel/ipn3ke/ipn3ke_representor.c
@@ -26,7 +26,7 @@
 #include "ipn3ke_logs.h"
 #include "ipn3ke_ethdev.h"

-static int ipn3ke_rpst_scan_num;
+static volatile int ipn3ke_rpst_scan_num;
 static rte_thread_t ipn3ke_rpst_scan_thread;

 /** Double linked list of representor port. */
@@ -2578,7 +2578,7 @@ ipn3ke_rpst_scan_handle_request(__rte_unused void *pa=
ram)
 #define MS 1000
 #define SCAN_NUM 32

-       for (;;) {
+       while (ipn3ke_rpst_scan_num > 0) {
                num =3D 0;
                TAILQ_FOREACH(rpst, &ipn3ke_rpst_list, next) {
                        if (rpst->i40e_pf_eth &&
@@ -2612,10 +2612,6 @@ ipn3ke_rpst_scan_check(void)
                        return -1;
                }
        } else if (ipn3ke_rpst_scan_num =3D=3D 0) {
-               ret =3D pthread_cancel((pthread_t)ipn3ke_rpst_scan_thread.o=
paque_id);
-               if (ret)
-                       IPN3KE_AFU_PMD_ERR("Can't cancel the thread");
-
                ret =3D rte_thread_join(ipn3ke_rpst_scan_thread, NULL);
                if (ret)
                        IPN3KE_AFU_PMD_ERR("Can't join the thread");
--
2.47.3

Reviewed-by: Rosen Xu <rosen.xu@altera.com>

--_000_CH2PR03MB5239F6E985FC44074E69A283FC18ACH2PR03MB5239namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi,</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Stephen Hemminger &lt;stephen@networkplumber.org&gt;<br>
<b>Sent:</b>&nbsp;Thursday, September 25, 2025 12:51 AM<br>
<b>To:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b>&nbsp;Stephen Hemminger &lt;stephen@networkplumber.org&gt;; Xu, R=
osen &lt;rosen.xu@altera.com&gt;<br>
<b>Subject:</b>&nbsp;[RFC 5/6] intel/ipn3ke: avoid use of pthread_cancel</d=
iv>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof">[CAUTION: This ema=
il is from outside your organization. Unless you trust the sender, do not c=
lick on links or open attachments as it may be a fraudulent email attemptin=
g to steal your information and/or compromise
 your computer.]<br>
<br>
Can use the existing reference count (scan_num) to control<br>
the thread without using pthread_cancel.<br>
<br>
Signed-off-by: Stephen Hemminger &lt;stephen@networkplumber.org&gt;<br>
---<br>
&nbsp;drivers/net/intel/ipn3ke/ipn3ke_representor.c | 8 ++------<br>
&nbsp;1 file changed, 2 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/net/intel/ipn3ke/ipn3ke_representor.c b/drivers/net/in=
tel/ipn3ke/ipn3ke_representor.c<br>
index feb57420c3..4e831c6924 100644<br>
--- a/drivers/net/intel/ipn3ke/ipn3ke_representor.c<br>
+++ b/drivers/net/intel/ipn3ke/ipn3ke_representor.c<br>
@@ -26,7 +26,7 @@<br>
&nbsp;#include &quot;ipn3ke_logs.h&quot;<br>
&nbsp;#include &quot;ipn3ke_ethdev.h&quot;<br>
<br>
-static int ipn3ke_rpst_scan_num;<br>
+static volatile int ipn3ke_rpst_scan_num;<br>
&nbsp;static rte_thread_t ipn3ke_rpst_scan_thread;<br>
<br>
&nbsp;/** Double linked list of representor port. */<br>
@@ -2578,7 +2578,7 @@ ipn3ke_rpst_scan_handle_request(__rte_unused void *pa=
ram)<br>
&nbsp;#define MS 1000<br>
&nbsp;#define SCAN_NUM 32<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (;;) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (ipn3ke_rpst_scan_num &gt; 0) {=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; num =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; TAILQ_FOREACH(rpst, &amp;ipn3ke_rpst_list, next) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rpst-&g=
t;i40e_pf_eth &amp;&amp;<br>
@@ -2612,10 +2612,6 @@ ipn3ke_rpst_scan_check(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (ipn3ke_rpst_scan_num =
=3D=3D 0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D pthread_cancel((pthread_t)ipn3ke_rpst_scan_thread.opaque=
_id);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPN3KE_AFU_PMD_E=
RR(&quot;Can't cancel the thread&quot;);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ret =3D rte_thread_join(ipn3ke_rpst_scan_thread, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPN3KE_AFU_=
PMD_ERR(&quot;Can't join the thread&quot;);<br>
--<br>
2.47.3<br>
<br>
</div>
<div style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West E=
uropean)&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica =
Neue&quot;, sans-serif; font-size: 14.67px; color: rgb(0, 0, 0);" class=3D"=
elementToProof">
Reviewed-by<span style=3D"background-color: rgb(255, 255, 255);">: Rosen Xu=
 &lt;rosen.xu@altera.com&gt;</span></div>
</body>
</html>

--_000_CH2PR03MB5239F6E985FC44074E69A283FC18ACH2PR03MB5239namp_--
