Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392F7C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 09:28:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF34840B99;
	Mon, 13 Jul 2026 11:27:44 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013024.outbound.protection.outlook.com [52.101.72.24])
 by mails.dpdk.org (Postfix) with ESMTP id 9757B40685
 for <dev@dpdk.org>; Mon, 13 Jul 2026 11:27:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mv3Wn6ywOP9jzMH5Iv+Dl+inmUbpJjySv7U4UO/TZ24U6vqm+fvUAvWAdM8LqPYrfBfZ8pnMpNRle5tILxuuY7ymbhCSOCLGflBBhBxHfpTya7eeCdYmOcsx19aGfVXQJBKIvDzJzTjGUqBYhWrG6GQCq9IrReMOu+EOR1PpUikWDC/YA+qCJimvXdxYuZjNsQxN6vuTPvUjsuXDCLYhSq/9MCoiyrCLvhZv45FU9Z05Bise8Vo/NNfbpiDh5yg7dhFtyqv0wj3WoIO6lByKKmxbDQacP7no8TAiwXcUkdkEjnnpoDLlrFS7D8HiLSmPk9Bn7yqJvMRTu1S0vTNLtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hK1LaA64V6qfNtNjf6q3s3pxhOo/I3BPU+C9SFA4P0M=;
 b=MeI3s5KhvKKMQUxP/y28XldgeXlJ++HysY03mxVfzubbxgNLR6A5szX3td30iOCe/DaSMZnuxrztCIxVl5z+mSKtt4fZDfAY+8sOCxxRFYOFyeT4BrnCLPSA2Zqfs/cBMwXa2/7rXfzV4ak8sSQbKS2uwG1BYFJHQLAsPDgLH7F19Tbf/I9+Z5rUixDJanImWunh5jl9aPeT+R1jKlhvWU7eRUDEvXILAIDTHHMfiKZ1d1p8DjWLNAFqSwXHhYegwpp7I3WWbGEZpqN91H5E4gmWJymci0BTyduLqP/QO/hOt9qfOd9QCOmaknC78F/Z76KfzIBtXpHcapa1LEvNuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hK1LaA64V6qfNtNjf6q3s3pxhOo/I3BPU+C9SFA4P0M=;
 b=FZZlpiHAXDzFDRIy2t+f7iyxqP7kA0HrvKCjfM0VodtmKcFHB1YWhc51t6OQ5rLQ2ytboGpuXYNbNEC0UfvuNuGkyiacnDF1TL8y16xcDOh94RprBHcqLYOptlpEr2KZgVmE4ugqX5jBp4uOEtiFhuw4Ss+IS744jIBel/u1yhxpjXVXn6nzcMJJ0KOjiQJa4FJkL+F5jzKGdlsDoYyp7gqDK7s9FFJu3WjzNKaqLMp12vnpZRZFdCmLc5WUE/f1pjGDaO9gU6dtpOWKKTLrtqcS8VxG5++sr+EOwkhYdEnHZDNKiCtOYHjEIJAaYdVfydvTqW2ZiRjJbLz+kAf7Bg==
Received: from PA1PR04MB10770.eurprd04.prod.outlook.com (2603:10a6:102:492::5)
 by AM8PR04MB8051.eurprd04.prod.outlook.com (2603:10a6:20b:241::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 09:27:42 +0000
Received: from PA1PR04MB10770.eurprd04.prod.outlook.com
 ([fe80::944c:6b2:95a0:32d7]) by PA1PR04MB10770.eurprd04.prod.outlook.com
 ([fe80::944c:6b2:95a0:32d7%5]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 09:27:42 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Thomas Monjalon <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: Gagandeep Singh <G.Singh@nxp.com>, dev <dev@dpdk.org>
Subject: DPAA driver series - mix up
Thread-Topic: DPAA driver series - mix up
Thread-Index: Ad0SpqTTPtQyOkt/Q9qhZrfS9mRkDA==
Importance: high
X-Priority: 1
Date: Mon, 13 Jul 2026 09:27:41 +0000
Message-ID: <PA1PR04MB10770E11CEC25E074365C3E1289FA2@PA1PR04MB10770.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA1PR04MB10770:EE_|AM8PR04MB8051:EE_
x-ms-office365-filtering-correlation-id: 84a3b48b-6e58-424c-28c7-08dee0c0fd3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|366016|1800799024|38070700021|13003099007|56012099006|11063799006|18002099003|8096899003;
x-microsoft-antispam-message-info: u2Je+E8tr07S+VZ7F3frYvozKCi+HjoUxFvJtWIT/qJeGw+spFj6BALftlB/tjcZ9q5WRBzxzmh7A/hEMdPLb9tMhDeoxxTLQ/73Goi7LUA6dakqJX/HzN+CQvvJiXBHcTiZN2Ly8Hs/YznJINwNLPNlrd+3kgx/AcRDdokMbpRy9gSt5jFbqjf3J0hXXI+0H20+4FQC0/fAMZNymQLsDgR1s+WM0IJFS41OP+Zv/wC3WZHjJ/nzvIEcHeKr52fSXPB/9jiCHURol7NwyCzzzZKZbIlY88OFO8veE1xnuM7uNJaAbikLLlBSpMDi1qYsH4aKGg87eUGNnZwa6kCMqcHMDAJeEJB/l3jKT4Na4wLxShY0/XakatBHnVGUSsxKdisZFUrIqbhuHF+QQGNq6HfOqZdHIqpevQCZyiM95LCgzcouZ3Gwb5Y/bw0TXRA9aQLcWRej7bjEXLP7tTHCB18+NhVaSo7CGuaGGdNQZF7xgtPdE/FRMcQxT+qz2XTm8bl3S+14D+hPL3r2yzgZFCPBOI0dmNsbZfrpm62pr2G0EynVSKwYBpYJnGzr5YEMk/s13jXCbjKJz21jNGMb2A9G1VTMXaqxhNYfGnw+TwnlZd3g69oEg6Lu4px+dMjsrQjO9Qd5SGvHceJaf9GrlhgQRkvDBBPKu7UcCj2EXH3t5lGDE5jp2miaUYD9xCnXXktyO0qHcHDON4YY4YPqOyjWwwOQUSH9RxPOIZfsOZY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA1PR04MB10770.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(366016)(1800799024)(38070700021)(13003099007)(56012099006)(11063799006)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F4cohCIeL4HwlPiUYxNoxRuhDtQnsjy9QRviDdYAgdOnp2p/7LWELq1TGfk/?=
 =?us-ascii?Q?A425KKmKi7m3EeWbkkcXDi8sIRQn3VUsHgj6sdNS8I8a++aA15SMCaNO1dYD?=
 =?us-ascii?Q?noH1m4wWdLNiK9Y9t4wuTP35o7oCzx5dvJG7Xptclz1DRhV6dYbHGkF2sisH?=
 =?us-ascii?Q?wsnXs+z4sa1o6Irx9FBbwlIQrVfd27qEYf9OkZWA6Rt3ERB3v2jtMK0Zo1Jz?=
 =?us-ascii?Q?QWc7jMyFWHQFYvr+dNykmPSMyyvciEQvGqshC5o4x3jZKMGAuDrDFl54UOT1?=
 =?us-ascii?Q?Gva4B+jjta2QeGtMhYCe30LUkGJ05CQ90wUHXqvPeQi4TwYng5hYRL/X4hhf?=
 =?us-ascii?Q?TEa2sFB7VOF5n6QhSEULT2fRi9kL3tOI/7Mgu28lUfE+UM3cSVyAOTnCSx/l?=
 =?us-ascii?Q?uqgf+FQ/6TAvWiNDAGn7k4fnjLetYrtiIx9P0/r03wjAKQX4PyHuqfaWZuqf?=
 =?us-ascii?Q?T0/GD3YWO0dJ9i7bAyNf1DvoWdxS2dUx+CqtP+KQkPFg1j0sfbaeFYPFoIJj?=
 =?us-ascii?Q?KwQaDVhOKYkfkyz3Ne6P/HPABwZgCM44Btp7il81t3REk6yXDODcVY0KH0K8?=
 =?us-ascii?Q?lROqSPXt/UntGdrUN3hHLJW7pn3JP3Nrqk3uA1WD3LG21UrZVQKtaxJwvwfY?=
 =?us-ascii?Q?AlzLhjS+Buzo2i/j9Kf7tUBpGTudQqdKeAXdzYFx1wjtchwMgiM+izgQgSMu?=
 =?us-ascii?Q?VLpMpmXw+28iPZg8OnBfaJOXxLma8nWDibywY2pSbtXXIDFlyDBnh4PSIxTl?=
 =?us-ascii?Q?n67wc3swQUIty1BrvTn51mqkoeZZUV0kveJVoej3pe8jvXwXR77uUBdQkfOj?=
 =?us-ascii?Q?Wtrs6ZZ+u66xaxG0cthKFdOsaVG1NbobZf9f8QOTmXwBIMs8MsJRHNkXWl6K?=
 =?us-ascii?Q?EBCT2xecA+cP59QEsu5RFM5xWv8CJK7UK/1RFCanByezdbgMjXNCJKk3HSIq?=
 =?us-ascii?Q?pi8S7NPSc9zNhUc6rgrmvuUzoJAB+SAq15FIP8IblQbN2g+xzbm/ufA7cNYR?=
 =?us-ascii?Q?IIFLL7BjBV45e0LKdmrvZN8blPOgbsvA27BtYHqOiG2bqXHGfSGAXsR/VfaA?=
 =?us-ascii?Q?I99XkaTNWKhAKC1p+Cp12AmyFR6zW6y4kETy5DugjBwF0A9l2tl6fHVeEjBy?=
 =?us-ascii?Q?BATX7ECPSEsgIWWOFzqyR4S59Ua3usly2ZVocMZFazpSmYSygVQ9KgUuJhYQ?=
 =?us-ascii?Q?qTa3W5vvlfWxT3yZG1q0+21PSZhMhd+q09spNRSeZSurHgYaUyBIdgzJL5QD?=
 =?us-ascii?Q?DX+0lpu+JPkxcfJlH1j9tSogyTlfs9PJGHPQy+29S1Rb5xO2ZeaECrGKHr3A?=
 =?us-ascii?Q?DQEQWxUnitKBMa+C1gdUJzHykzbUQyXXzcJVuUrIrvAYEWGqHmhfiUGlrha4?=
 =?us-ascii?Q?GMFhhxBTwEwxHIRq5QbpePZFvV/Y5JXSXYSlncT4CbyQi/kdGZ4cb+9JJKa1?=
 =?us-ascii?Q?hOIeo7Os2wq9z/i11kMsRfAkhKUg+JXiUCURXfZi9jh70a3WhVhp7sZid+4M?=
 =?us-ascii?Q?fRTUE2btR0gMjhGxWUiLJDz0/FFpMBWX29UL6D5foiZtvtvAP8aqSJc/V71j?=
 =?us-ascii?Q?xZ0+EEzotDSJwz7J9YJnS0/srjTC3FIWI5pDOu0AIS0H7VpTu2vCHbE8ok3l?=
 =?us-ascii?Q?2NLXub5yff+2IvOoI+mzqfei10luZt00V6t6EeUgPomgMhYqnccG5RaYwvAg?=
 =?us-ascii?Q?gB4LNZzxXNjNf5FNAN3bj1GQgsca4wUx6wNXcMukaavsoFb8e3WDFBfZ+2qh?=
 =?us-ascii?Q?qQ6uPp49Dg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PA1PR04MB10770E11CEC25E074365C3E1289FA2PA1PR04MB10770eu_"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA1PR04MB10770.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a3b48b-6e58-424c-28c7-08dee0c0fd3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 09:27:41.9435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IIufJ611wkz08JQI4/FRrbtL2iNmxsE2jXMPCcG+j8+Bn0rgpleglLa3oTwyIppNrEZPnTMC60Zmbxl4WSj88g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8051
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

--_000_PA1PR04MB10770E11CEC25E074365C3E1289FA2PA1PR04MB10770eu_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Thomas
                We sent two different series for DPAA/NXP code:


  1.   net/dpaa: bug fixes for bus, net and fmlib drivers   https://patches=
.dpdk.org/project/dpdk/patch/20260619103901.2274740-2-hemant.agrawal@nxp.co=
m/0
     *   This was originally accepted and added to next-net by Stephen



  1.  DPAA bus/net/mempool/DMA driver fixes and improvements   https://patc=
hes.dpdk.org/project/dpdk/patch/20260703124950.1895871-2-hemant.agrawal@nxp=
.com/
     *   You have recently commented on it, we need to make changes

I am not sure how, but I now see that the first series for fixes has been d=
ropped.  The series is marked as superseded.


I have just sent v4 for the bug fix series.
https://patches.dpdk.org/project/dpdk/patch/20260713092616.2902828-2-hemant=
.agrawal@nxp.com/

Will you please consider it for merge it again to 26.07 ?


Regards
Hemant

--_000_PA1PR04MB10770E11CEC25E074365C3E1289FA2PA1PR04MB10770eu_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"http://sc=
hemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-=
html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Mangal;
	panose-1:0 0 4 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:393701855;
	mso-list-type:hybrid;
	mso-list-template-ids:630458290 1074331663 1074331673 1074331675 107433166=
3 1074331673 1074331675 1074331663 1074331673 1074331675;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Hi T=
homas<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; We sent two different series for DPAA/NXP code:<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<ol style=3D"margin-top:0cm" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l0 level1 =
lfo1"><span style=3D"font-size:11.0pt">&nbsp;<b>net/dpaa: bug fixes for bus=
, net and fmlib drivers&nbsp;&nbsp;
</b></span><span lang=3D"EN-US" style=3D"font-size:11.0pt"><a href=3D"https=
://patches.dpdk.org/project/dpdk/patch/20260619103901.2274740-2-hemant.agra=
wal@nxp.com/">https://patches.dpdk.org/project/dpdk/patch/20260619103901.22=
74740-2-hemant.agrawal@nxp.com/</a>0<o:p></o:p></span></li><ol style=3D"mar=
gin-top:0cm" start=3D"1" type=3D"a">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l0 level2 =
lfo1"><span lang=3D"EN-US" style=3D"font-size:11.0pt">This was originally a=
ccepted and added to next-net by Stephen<o:p></o:p></span></li></ol>
</ol>
<p class=3D"MsoListParagraph"><span lang=3D"EN-US" style=3D"font-size:11.0p=
t"><o:p>&nbsp;</o:p></span></p>
<ol style=3D"margin-top:0cm" start=3D"2" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l0 level1 =
lfo1"><b><span style=3D"font-size:11.0pt">DPAA bus/net/mempool/DMA driver f=
ixes and improvements</span></b><span style=3D"font-size:11.0pt">&nbsp;&nbs=
p;
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt"><a href=3D"https://p=
atches.dpdk.org/project/dpdk/patch/20260703124950.1895871-2-hemant.agrawal@=
nxp.com/">https://patches.dpdk.org/project/dpdk/patch/20260703124950.189587=
1-2-hemant.agrawal@nxp.com/</a><o:p></o:p></span></li><ol style=3D"margin-t=
op:0cm" start=3D"1" type=3D"a">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l0 level2 =
lfo1"><span lang=3D"EN-US" style=3D"font-size:11.0pt">You have recently com=
mented on it, we need to make changes<o:p></o:p></span></li></ol>
</ol>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">I am=
 not sure how, but I now see that the first series for fixes has been dropp=
ed. &nbsp;The series is marked as superseded.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">I ha=
ve just sent v4 for the bug fix series.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><a h=
ref=3D"https://patches.dpdk.org/project/dpdk/patch/20260713092616.2902828-2=
-hemant.agrawal@nxp.com/">https://patches.dpdk.org/project/dpdk/patch/20260=
713092616.2902828-2-hemant.agrawal@nxp.com/</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Will=
 you please consider it for merge it again to 26.07 ?
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Rega=
rds<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Hema=
nt<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_PA1PR04MB10770E11CEC25E074365C3E1289FA2PA1PR04MB10770eu_--
