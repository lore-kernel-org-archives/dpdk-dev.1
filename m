Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC61606A32F
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=nQHI7+iI
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B239240611;
	Wed, 18 Nov 2026 10:20:06 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013019.outbound.protection.outlook.com
 [52.101.83.19]) by mails.dpdk.org (Postfix) with ESMTPS id D964B40298
 for <dev@dpdk.org>; Wed, 18 Nov 2026 08:12:54 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3n2BNM2zZ9TZ14L06SPqPCSBxcpOr9szDPcLbEMI6/Kz29sDrrU2dPVT0f1+3BR/8znXtnkvBVkvDW1WiGMJ3T8fMdG3m4ABDMposSmVj/TqRNZinYHHuZQwh+WchMyguza6SHmCZQLjYhIzan+0w34tx3ljLFG/uKog5o/C3J4TdKDaopTf4b+TrNtFvybKfYb8EXWPZLXnYA+EP8uiWnsGkm7t42Lk0ITZuazW9hXnV66gySCw8WSNeB5QbyehoY47KZn/ztvtdwESQni2GKczxEZjWtzU4uOWHdsNvsgPnc4ObPgBFdeKNzetTvrcxChRgBTr7OHE1TeWrGhtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6p48TiDT9ZPf/SA6LnhMof80KSW5r8jtktRII5Sv+n8=;
 b=VtiKhObAA7vB2u2cJa9rcEe/G3qGijzXsPKNDolG3Qelyb5SpNwgU6+OW3cZ8Dp6zwgNHrr/fSEoULkRySRzbvPLfjdo2k6jbKY3e5azitSjTHalWEi3/Z1ft0AjCOpDRua5ldjGGPpIQ/fz9ZRL9yTV1Y4VduhggyJgA59sH9vSDHYEaTKu0uMHab7T35td1FIAkWKAxbP1aPWIj1RQWJenn6SP305bfcEPkbBlGQNSFypvoxFc4niJJHj+8kphYiegBBNYv9KsZXiiKTj7OYc98CIgddRlTQr338GDRXDlo3EXh4Frkx5SLcFvuJR3Q/xKF5F9eK3u1bFuMReINg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6p48TiDT9ZPf/SA6LnhMof80KSW5r8jtktRII5Sv+n8=;
 b=nQHI7+iI52pGoFm07S6eme9pXxsRkfAfzEvQmnoWRFF3s037bRpBOk0DqHJ/o/DZp4gL55kVrzlRSm55WD4wQQQnmqBqPv9NFMyCuIl1UuDj9p1v3xCHqM0fkzTQKmOxa0bGxsHKBUPgzCLJQ7LCDKlJl2Ivw0K+GEzFAzT/u7BHOU3oxmxIsgSayR+1joz55sm03wn1mr/lbxEL8Z+bmTnSS6/m9O4ZNlsTDND5AD/MMPkjGEdQRZRjcwXnao1vccmEuR+1uCuUJ0jt9KMKbJ2APmMkfGf8v+VG/k0HDHmnDJp81SjyOdS3sbtBNW0EjFW2Pc6/H5q6qDgNAP8r8A==
Received: from GV2PR04MB12339.eurprd04.prod.outlook.com
 (2603:10a6:150:309::12) by DB8PR04MB7034.eurprd04.prod.outlook.com
 (2603:10a6:10:128::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 07:12:49 +0000
Received: from GV2PR04MB12339.eurprd04.prod.outlook.com
 ([fe80::c961:11b9:a616:1683]) by GV2PR04MB12339.eurprd04.prod.outlook.com
 ([fe80::c961:11b9:a616:1683%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 07:12:49 +0000
From: Jun Yang <jun.yang@nxp.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: l2fwd-event example issue
Thread-Topic: l2fwd-event example issue
Thread-Index: Ad13K1FI/kGaUrrlQvqzY9fe7MAl9w==
Date: Wed, 18 Nov 2026 07:12:49 +0000
Message-ID: <GV2PR04MB12339F9F9B196059434A6B3CE9D7A2@GV2PR04MB12339.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-11-18T07:05:06.0000000Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12339:EE_|DB8PR04MB7034:EE_
x-ms-office365-filtering-correlation-id: d5371d80-1933-40bc-6fe3-08df45435a5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|19092799006|1800799024|10067099003|38070700021|11063799006|56012099006|261009223027099003|18002099003|8096899003;
x-microsoft-antispam-message-info: Gw6cYhz4BELguSbYx1J/wjUM6EFYgSEx9Hl2hr0zTIFDKQ+4Z5myfC0dRbfn8JesKAyaG09lXzsvzfgTMPfExdUAsRlCP/M8fhG8MO5qpYvxtnIWGRRz4a2exwqhYbZDOvuO2B1M2brzAB7UjPWCitla4bsVCWFao6NY1xUcvTJFgNhAKMcI1ymodArg2MhQjhUzHIlxVzoME3cWWQdoT70GgRVzkGfDt2pSL2za6TkyMpv/ttoEdQrSseIyB3ynIEsPCGes8Er7qAAYOucisXS0OFMWMYWSUt6ldwfp0irxnVBTRi+G4j59J8rHwcd7EehYHNw1sZvGvIxJSNNPsJD9tqhkztuHwjZwuDulgTR+QJLKuVJuosGHV35PE/DGOyzh+pRcgWHtnYyEsJT2dd8Gq26PeIyW53voY80nq7MKEEIU5GbRQ4+clbUGuEMRrHuUC/ztY/WE8llK35q2uH3uYTf9/wXr1vUTKNBwr+T9HXphHhWk3EzJ6hbSdCsBlCJERfv8NKtmi6RVIcL2So0KYdlb8rOXsFNqOaTAeCKix4+Mhnedk8f9bPMgMzAktUoeCR5y6kqnJArFmWJQac/7crDe7GxNVNruhb/6yZC6NguPZPWPkpB4dhTXC6Q4FdLIyCLFjvKauYV9dAM63JBCGADr0fQVm3xxnUdEFraYGvmUrZvtRAhULsDqhiWxnRQ30BrwxZu82yFb5Zx5dQEfe5xPJnWcQfMgRa3u9Hk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12339.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(19092799006)(1800799024)(10067099003)(38070700021)(11063799006)(56012099006)(261009223027099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UlpWoJRT4gjg9vgbm/1qIZV3kVvkUpK628/n+IUQpK2F+czcVCtDqITfU/qG?=
 =?us-ascii?Q?+XRXPOlPAqA2z7RPpdTRXA8qPtaI6bxcIOk9Brml4ZDH0FFokgRPDQia2M5e?=
 =?us-ascii?Q?eh5JYEritwwOwxlWjDBVBd/X71NSzVXJWZvqsvKCzZqImwK9RLeBZdh1oX+i?=
 =?us-ascii?Q?hcmYuZpVjicX8mhfHStu15e6Rib+DoXsaQpViPbCi/mOEilT4MQGxiNKj/kt?=
 =?us-ascii?Q?wcnHqHQvGZwR3hBspOcpOPzapt7/dk8FXQAaGOVsU5LFhzF+C/2v2GHgBmcU?=
 =?us-ascii?Q?NJRg972b8XKatxrb/3A18JrCliVffNrZun6GczqF7FySHJ6zIdav9jLKI5KV?=
 =?us-ascii?Q?E92qlxvkHq8uQOmEovHe8YnjZNlaaSkbhSyJAQgcXyLD2fxHzlto0kD02bng?=
 =?us-ascii?Q?qf0LyNNlZ3GQMVOTyOrgMMfat9p24jj0Pzas2IAVKO+bpE362iDOTb9KcjDQ?=
 =?us-ascii?Q?FGOXgjXNWJ16Rjs7YOdxRKm8kgziQqA5IkkGh1w6lWFrh1dVUCtK43zmZ9r6?=
 =?us-ascii?Q?dbDrmXaaxXApFc3JmyNjPNqbR4+GCFYEbXZeeOmLnjB52A14DzeY+YjAN1vA?=
 =?us-ascii?Q?YfjkuP12rWr9bqxoPKkOx/F7sLKs7FOQ4KHei0r/K0brOEMH/1/yhIhttmDI?=
 =?us-ascii?Q?AgoD/wrQXVnzQoG/qfsGblRPJBmLhi+oY+pRs9Gm8jhK94HuJYL2cxJHXbv0?=
 =?us-ascii?Q?JY2oVoOmYcJbuj3EUJsNPjEM2JqJwJVy/gMXt6Bq0umMph9l67hPuHwgJoiG?=
 =?us-ascii?Q?NV9hlymwXmi08ZiZHM6cg6PJDtbA7F83vGlERLNEk8ak5uWytjz+hYdt1u0U?=
 =?us-ascii?Q?eVnf6BXpRa6LS6jLbWSAOJoIGaGjbjpxLdGklN4S2LtXCAuR5v4Ajy/rK2Id?=
 =?us-ascii?Q?JvhDHM/gTRuvcWLHTp6LaxWv+l4y+c9ZwM6QYeZSKKVvTPaWIJHZ1lAisvHT?=
 =?us-ascii?Q?sao1WacqbnS3QHuE/dsm0pziLIlpeC129BWvtDKiWB0ZFJk4LCf7IMwxC5C1?=
 =?us-ascii?Q?zVTNjR6l57YwjMSOJQNrfAXb8pDqSdhYMPoXY4T5qPMF7FiTGBp2q2Eu86Xy?=
 =?us-ascii?Q?BkG2HSC24oukOvFe1lrldPrg7T+Wku2h9eSYx4UlNwpAfbPlRyYhO3yq+Uw2?=
 =?us-ascii?Q?4HdLOoqsosQZLLqmF8dIMzA105UIpxGRab3M6IhKC140cMHXfvoiY8e2zrzK?=
 =?us-ascii?Q?Tevog0gEDIflKHi2nlNWYVXzg3VhUG31/j06zt7/KjERHaTZ30dqCJpvX1pZ?=
 =?us-ascii?Q?BmpPkr9MQ+Q1264JPWmMlIb4aJbUJCXQng4gj3EyhhK236xpeN3I15DRR6t6?=
 =?us-ascii?Q?u9iuNqCycp+jP+Pyl9IkguKYYNB1G17Xnh9VMv9ZDIkUS+NTMhseKQMtgBZ/?=
 =?us-ascii?Q?KTqH08RvipzDl4wTVRSPlBTb9cwygypBBx88/BbbWL32iOdGSDiakTeZGT9V?=
 =?us-ascii?Q?TUMMlCfCRTqpOZC47HPMiEmWgpCzHPEGVgIYY1yw7UhKDtFdI2oHGjjPAICg?=
 =?us-ascii?Q?V3/jv93CdVE8enTQX0O1WVoX33UH/xuuszKXECyoMu3EWPrpPNasFVDmNDun?=
 =?us-ascii?Q?yXN1cn4ksYho2fxcVfXSo1iiG+zHWChUVjzDLrQgLVUhjZU5imZ1binnEXsM?=
 =?us-ascii?Q?TN2U5MY6DATVTOa9oKENqWnGLzN2r9SxPg2CA4m7Bjp4DXKkPGxwta5KbuAH?=
 =?us-ascii?Q?6B+ov2a1/ZqbEQKpgHBBzyttvGPY/2L0bffAu4LN4L4hJqac?=
Content-Type: multipart/alternative;
 boundary="_000_GV2PR04MB12339F9F9B196059434A6B3CE9D7A2GV2PR04MB12339eu_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12339.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5371d80-1933-40bc-6fe3-08df45435a5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 07:12:49.0319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HUTWwo9McMQ2f87F38+tvgHUrM4AYnd8LuVeA6FfScLJVWkwn2p4YsWG4sgQe8NSlM63OFIiWZsDXAa5bUBgTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7034
X-Mailman-Approved-At: Wed, 18 Nov 2026 10:20:02 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_GV2PR04MB12339F9F9B196059434A6B3CE9D7A2GV2PR04MB12339eu_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
Could you confirm if this change fixes a real problem?

diff --git a/examples/l2fwd-event/l2fwd_event_internal_port.c b/examples/l2=
fwd-event/l2fwd_event_internal_port.c
index 26233d1ab6..d1c2225856 100644
--- a/examples/l2fwd-event/l2fwd_event_internal_port.c
+++ b/examples/l2fwd-event/l2fwd_event_internal_port.c
@@ -133,6 +133,7 @@ l2fwd_event_port_setup_internal_port(struct l2fwd_resou=
rces *rsrc)
        if (evt_rsrc->disable_implicit_release)
                event_p_conf.event_port_cfg |=3D
                        RTE_EVENT_PORT_CFG_DISABLE_IMPL_REL;
+       evt_rsrc->deq_depth =3D event_p_conf.dequeue_depth;

        for (event_p_id =3D 0; event_p_id < evt_rsrc->evp.nb_ports;
                                                                event_p_id+=
+) {


NXP Confidential

--_000_GV2PR04MB12339F9F9B196059434A6B3CE9D7A2GV2PR04MB12339eu_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
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
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:DengXian;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:DengXian;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.5pt;
	mso-ligatures:none;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word;text-justify-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Could you confirm if this chang=
e fixes a real problem?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/examples/l2fwd-eve=
nt/l2fwd_event_internal_port.c b/examples/l2fwd-event/l2fwd_event_internal_=
port.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 26233d1ab6..d1c2225856 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/examples/l2fwd-event/l2fw=
d_event_internal_port.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+++ b/examples/l2fwd-event/l2fw=
d_event_internal_port.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -133,6 +133,7 @@ l2fwd_event=
_port_setup_internal_port(struct l2fwd_resources *rsrc)<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; if (evt_rsrc-&gt;disable_implicit_release)<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span la=
ng=3D"FR">event_p_conf.event_port_cfg |=3D<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_EVENT_PORT_CFG_DISABLE_IMPL_REL;<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"background:yellow;mso-hig=
hlight:yellow">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evt_rsrc-&gt;deq_depth=
 =3D event_p_conf.dequeue_depth;</span><span lang=3D"FR"><o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"FR"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; </span><span lang=3D"EN-US">for (event_p_id =3D 0; event_p_id &lt;=
 evt_rsrc-&gt;evp.nb_ports;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; event_p_id++) {<o:p></o:p><=
/span></p>
</div>
<br>
<p style=3D"font-family:Calibri;font-size:10pt;color:#000000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Center">
NXP Confidential<br>
</p>
</body>
</html>

--_000_GV2PR04MB12339F9F9B196059434A6B3CE9D7A2GV2PR04MB12339eu_--
