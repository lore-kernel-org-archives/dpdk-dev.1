Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CCEC7EE39
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 10:02:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3292402A0;
	Mon, 30 Jun 2025 12:02:35 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013054.outbound.protection.outlook.com [40.107.159.54])
 by mails.dpdk.org (Postfix) with ESMTP id 39E6F40264
 for <dev@dpdk.org>; Mon, 30 Jun 2025 12:02:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEV2tjsO+NZmlSipvb+RaycHhAz6RUsiZBdMYfRbyooXvDinPRwbP5TL/NIhxmK4Z7PgESt/g9qvJwWkJzYS4lBI/ErnptGD4imiB6ofUCIX0Xd2g8dJfMH6kIp26zJb9hI7Qa/8PnYhVuLYukTdQlHEtXV2e+iw57GFBU8Xme+G6f0ShfacXNNb9CI0ymHu0q1deibWM7d1iFjQ5sggbgWpS2SR0hZy9dqtRxhrFryFTFm8ScjSbG/u8M3xMDh3moIdDG/wCsn0qesnpSDkcnWN0ML6BNpmHgeKu62pqssuri2uCfu88nT+ozdhj1jJAITjV8pczFeU2s+p/J/eiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0h52N7h8x4neoEScoZg9bpLJTXwecKPiwSsbMMjIFw=;
 b=lqjtQSF6xzU0Mw2CDmia6xTDIduog+UP7WWj+SnkzeI43AxS4DiCtECAJxx5UCfD8sM2Qrogx180WZBEZyb5sf8XMMxIMCuzm6hg2l7PDarLE3SGoh+HeHb3YV0085WwyLMA5yk4z71u49i2xpz3eZCN6FPndBZz3/1gwNbmJRLWJS+ZSNt2iy3J3Xw7AKQGB6VtEWRpbjRWeVsR9vThq3iEka9nPvpSZp3eBF7NllCO4h1mRZcb8QKqNG6+OcouG0JqT4o0y5f4JTle85o9LznyK5JFmenQt5psriNAS6rbKZhxApMLVSvenAPky7891h8w4HYpvJDamZG4AFIonQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0h52N7h8x4neoEScoZg9bpLJTXwecKPiwSsbMMjIFw=;
 b=TxPklzRAkHWOc8oZZcCM64rR88Yqe/mZ0EhcFidmiDMHalCa/oMa7/Hdtl87rz44NLWvEKsTdWH+EL7YnCpu8tOWHwjVWeIsDGqnfOrOqVdy+N8I80/0Y9WpdGxm61xmBj015XfUME4lgiHL2EZXflmCijeLkkRyzIsPSOgm8vgHEhUwtPaIZRARY3mYO4Fy0OUPXAmkHnFnrgdAfw9s17yZH7qG+cRRziJUZwb/7zfGu7Hb7QYh7po/+wCBGqZFsw/qoDe2Y2GVlnoZ25hClunGOFPOZSvJT7bB/ZV4P7VAcBigkpsp7eZytbTDiEBEyB8ML5+NmEPz8Igt6BY0TA==
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by DBAPR04MB7367.eurprd04.prod.outlook.com (2603:10a6:10:1aa::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 10:02:32 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8880.029; Mon, 30 Jun 2025
 10:02:32 +0000
From: Gagandeep Singh <G.Singh@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: Re: [PATCH 00/11] NXP DPAA2 driver enhancements and fixes
Thread-Topic: [PATCH 00/11] NXP DPAA2 driver enhancements and fixes
Thread-Index: AQHb0TJsOcCMQDmbCUC/k/K7cODMFbQak0CAgAEVhvM=
Date: Mon, 30 Jun 2025 10:02:32 +0000
Message-ID: <AS8PR04MB81984927114BE947589A905EE146A@AS8PR04MB8198.eurprd04.prod.outlook.com>
References: <20250530071344.2939434-1-g.singh@nxp.com>
 <20250629102535.154ea015@hermes.local>
In-Reply-To: <20250629102535.154ea015@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8198:EE_|DBAPR04MB7367:EE_
x-ms-office365-filtering-correlation-id: 9a288e03-42e8-4ac9-2ea8-08ddb7bd3afe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|1800799024|38070700018|7053199007|8096899003;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Xz441uxSzW9mHGNbDV/gS1iqTPrauqhtxdmzED5DE8c9JCPKD6XOEetqgD?=
 =?iso-8859-1?Q?g3Qrpobbbs6g1mTmcVIl8R9qZsGeWFMLauG3YPuewgJu4v0yU63gHQKzDF?=
 =?iso-8859-1?Q?oPHmcBtcLcaHpLICHkU19BmcYqxSYFBJMEui9pUCdFuUPtmwVWb5yqX7GD?=
 =?iso-8859-1?Q?dulPATor/QMNwn0osOjiaMC7EYNmgvibhkWXSYy/p3JgA/M4bMLPJFOm15?=
 =?iso-8859-1?Q?LQGh8VWbKpWBTapn2cBjuwbCWgXdBT5ybN1l/CrKplTkNIN8dFVDFSQFJY?=
 =?iso-8859-1?Q?xXGHMKQilr+hsadWOPXst6efrwoPrd9TzgyCmUkaIBHBRLaQtmc5y5qiMR?=
 =?iso-8859-1?Q?2sdNnVMdk2JHdop2I8P4g/gsAllIelJQzt++Y+bySCkHVephTbKKH8er8m?=
 =?iso-8859-1?Q?LqY48OvVy1NTn8avKylcc+rI0IBxTICyl5O10khzBfAJC+KtzIt//CUD9J?=
 =?iso-8859-1?Q?7y8yLe4NpWroLncVvregaDcpD10t7la8Ccl0wkJkusWWUP64pljFtBf1US?=
 =?iso-8859-1?Q?vh6xwuZk/321dF7x/9pA9h1raTdjtY4fmjAMUywv6oZXBizTX8ego7o5yh?=
 =?iso-8859-1?Q?KMa7nkC9jVOwUwpnBR6MXf1lAq3Q2gj5JqGCKawAbrPK7qW5AJteoAc5Zw?=
 =?iso-8859-1?Q?hVhtOBFRAWE+IBBES2CntkwrDC59iAEkXs9c2jsT7cjjlO7Jkg/dz20moR?=
 =?iso-8859-1?Q?93UzVS1fSPuaAUyYTURoz2aeoPaRCSQvlVTB9PwnJ21bCGWj34gaCfhJab?=
 =?iso-8859-1?Q?sepefRuyeadVOCMSSm0tJscNgARo3HyF5eOZPxrHQwFJCbj/u/VT4luR4U?=
 =?iso-8859-1?Q?Ne2uuiUnAqJF/B9LibeXM1HfqBdd3r3038W2mRaG8n9EIVgYPxlMTssC55?=
 =?iso-8859-1?Q?703HW67LQapQqJDon8gQq1dpe9whqzyeZ52GdJKpRvpNwAnjDtFXbsKOcT?=
 =?iso-8859-1?Q?xJwBKaEx6+FCBxg0b7OUa/T3IZQYJwi8Molp0i9606IZYSBVEj0KlfqBYj?=
 =?iso-8859-1?Q?1ChwuVbcUpHTaw07dl927+Iwdsx8CesKQSOJ6Fl9M5sbtq6G3KHTJSR8eY?=
 =?iso-8859-1?Q?SVk+X7OGYV9t2DtX70Bh6AUm/qYkp/Olhr/wXBaxfNq0WpmOJopz9GyNRd?=
 =?iso-8859-1?Q?wYlqCivV5GSgl2+6B8aB/+lOexmLdAAhuwJOL5GVHqB5+pPBZW9OLcsgin?=
 =?iso-8859-1?Q?no1ta6CFDTnoizatJjspmQKbAq5yGIKoLf5S4XZfzw+uSOeve6MJCKSq0M?=
 =?iso-8859-1?Q?2SCv9OYuMo0AroP/7jIWsupJuifYr0lUtFKoudatTSXMsIjHfUJPoskGzH?=
 =?iso-8859-1?Q?tDLG4QrYO13ow02Zug5Nqsyly0mDjtJz3kfJVD1Vq4H7IpiyNzLoj7hjpn?=
 =?iso-8859-1?Q?NcqDGWF0EhoPs2GsNtTmPzAlK21dE48afRUT4BX6bm1OUPOpGy62DJmBrT?=
 =?iso-8859-1?Q?9oJkl6qxjJczsibH1oVCKc6fxJieLbzdm+9GVP9hXxLEg0sM7NgFQQWYKx?=
 =?iso-8859-1?Q?RCQerOixb5cDTJsXU05Q/RCfr4llhIrgqkfr1H5raGNZYCjWop/kR8kxAc?=
 =?iso-8859-1?Q?lvC/Kcc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6lu0KZIFxpBSPvvuhw3Yfe43ESdic5Xa6YHm75k8Vez2z4P7KoWBgsjr3U?=
 =?iso-8859-1?Q?cIIKj2JqIijG7k8JfTP5TA+gsfmLAZPhlgEDlalL7N3jE0cQxwkE8O5M4H?=
 =?iso-8859-1?Q?ZBQ0vKGZv3Qe0eWZ1tgbbf88/iUIJzqyCkxJ8yl1wS6ewiXVILu3Ooxyls?=
 =?iso-8859-1?Q?q2+8fJCCqLV9eQqTX1NetFcSr44uyty8Of7EXiRIWeC+o8kMqVYDwQ9Z3L?=
 =?iso-8859-1?Q?F8BOljYRF9wvmA8VfH1sc82UTp2/CqxmmS32KpeWbgVoWWOTU3S6hLkrg7?=
 =?iso-8859-1?Q?U4CAGmwrXrJzBeeb1JNmv6GIMRTR2xeQAd7P8Ox/yKPwwh+NWRettIBgVC?=
 =?iso-8859-1?Q?YwjGaYT8UYT4ZTKGHHdJPB2Fg6yLRxlm0mAwxbQeJK725i7297CTwttthz?=
 =?iso-8859-1?Q?dVNrBHzB0H1q8Xpk+WgTiM96m51P2tUMJqa+snHanGa8ySB7BGyBio3wuD?=
 =?iso-8859-1?Q?3gDCA5/SCIuOu7dVVimShpr4lqiCos+XQcDMqWfpZEb4VHWftCayuB+YG4?=
 =?iso-8859-1?Q?qpjK2TP5+HPRtpM62VmjBGRPN1r8QPMcn355oj7UDDvW4LwhlyU7JUkiZv?=
 =?iso-8859-1?Q?l2sJhfpDjXfkNwg88J3svQ7B+CFeMNVw6yOK6NEJ0SpObkSGXpV3gTC+ZG?=
 =?iso-8859-1?Q?IrYXn67+xM8tsBxjp/1GTPL/JKv89pg0xslqTNyAMGk2d4XParX5NeIekE?=
 =?iso-8859-1?Q?dwsphxtVBEvQqijKcBgjV9kd4WZdvwF7nOAhyB6wp8YHEBgENfdXQaMtg3?=
 =?iso-8859-1?Q?q/BZzw3nCJDPKXBouepr/QO+FQG49pqg4/ak2UyOJ2TZgjU0Y/l/uMidzt?=
 =?iso-8859-1?Q?rti9svCHKHwXrpmd1jXc3+v0ToK0RIeD5X62/RgyO9T7v71rBZof9JLO8E?=
 =?iso-8859-1?Q?h73+U2Agisxqwk18+2PQL8nBVBZ2c0lmyv0mHe92bNU/SwL6fPYvsMG++O?=
 =?iso-8859-1?Q?P01ma5dUhrm+RjFUDmO78Ab8IMg6kpCaQ+mxf7wImkqKF1i0oXuNrKB+iL?=
 =?iso-8859-1?Q?YKfT6MskiKPD5w5Fs3SakwESquk75kdPm/LsnRlgigoc4WGphgftPlY0jg?=
 =?iso-8859-1?Q?x+lXkxRV1fgWE3sr+xV7PtJ4Fi2riWHc1/QLsTmfK+103XIkF6ZCEbE9mx?=
 =?iso-8859-1?Q?BCo6CB9KM0JOocd59fw7z0gGQ6apRKJFAqiAkswkEMMlUMvBq3XHMjQpRM?=
 =?iso-8859-1?Q?Y62NF7qsoUUZCTdk4SEV9YYZR75njZSsSn7oFGW1PmuZkWXJj6IYWCDZOe?=
 =?iso-8859-1?Q?5uleWmSmb3MiuHfB1Dr0g/bh/pWtoe5AtGrfKLSGjLogcOsG1rVKiW2Zi9?=
 =?iso-8859-1?Q?dFZVJkT8ENmh/oI3VgZ/QLPt1cpKj548cyIg/758drfX+4HPhnttl/5LQx?=
 =?iso-8859-1?Q?VmpmvsRwukNJpgXRzqKW4WwwX0ds31PvqrJMCGOfubBHmpkbNNRL4Wacr9?=
 =?iso-8859-1?Q?sdM2bOUj3hETDBfD6cmTclXH23OfiRNCLekM59mjaImstIw5CsuZGbn3Zu?=
 =?iso-8859-1?Q?UjiavphGrkxUznGxsXaQSZk4/mDmeuZugyMuBGaT/hERTs0sz4f9ata/u7?=
 =?iso-8859-1?Q?GAawTg6lgRFogIVavBTU4D4XN8WoYXwkjNJwC/2YOw03hSMY7kbAFpfIkc?=
 =?iso-8859-1?Q?Lyk0UEsgpBRiE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_AS8PR04MB81984927114BE947589A905EE146AAS8PR04MB8198eurp_"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a288e03-42e8-4ac9-2ea8-08ddb7bd3afe
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 10:02:32.2488 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m+BfdScMvCXzeG/LKqa8WZXgjebwRzKvzx7SLQvsq0kHHs2o3QT3a97u8kyMPwpM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7367
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

--_000_AS8PR04MB81984927114BE947589A905EE146AAS8PR04MB8198eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for your feedback. I have revised the series, accordingly, removi=
ng several feature-related changes and retaining only the essential changes=
 and fixes. Our intention in submitting the full series early in the month =
was to facilitate timely review and potential inclusion in this release. Pl=
ease let me know if any further modifications are required.

Regards,
Gagan

________________________________
From: Stephen Hemminger <stephen@networkplumber.org>
Sent: Sunday, June 29, 2025 10:55 PM
To: Gagandeep Singh <G.Singh@nxp.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: Re: [PATCH 00/11] NXP DPAA2 driver enhancements and fixes

On Fri, 30 May 2025 12:43:33 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> This patch series introduces enhancements and fixes to the
> NXP DPAA2 Ethernet driver.
> It includes support for
>  - software taildrop on ordered queues.
>  - setup speed capabilities.
>  - DPAA2 resource version.
>  - MAC level statistics.
>  - improve PA-VA conversion.
>  - add buffer pool depletion state configuration.
>  - fixes for shaper rate and buffer prepration.
>


At this late stage in 25.07 release, please don't mix fixes with
new stuff. Also new features should be in release note.

Please resend with fixes only for 25.07

--_000_AS8PR04MB81984927114BE947589A905EE146AAS8PR04MB8198eurp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hi,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thank you for your feedback. I have revised the series, accordingly, removi=
ng several feature-related changes and retaining only the essential changes=
 and fixes. Our intention in submitting the full series early in the month =
was to facilitate timely review
 and potential inclusion in this release. Please let me know if any further=
 modifications are required.</div>
<div id=3D"appendonsend"></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Gagan</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Stephen Hemminger &lt;stephen@networkplumber.org&gt;<br>
<b>Sent:</b>&nbsp;Sunday, June 29, 2025 10:55 PM<br>
<b>To:</b>&nbsp;Gagandeep Singh &lt;G.Singh@nxp.com&gt;<br>
<b>Cc:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;; Hemant Agrawal &lt;heman=
t.agrawal@nxp.com&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH 00/11] NXP DPAA2 driver enhancements and fi=
xes </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">On Fri, 30 May 2025 12:43:33 +0530<br>
Gagandeep Singh &lt;g.singh@nxp.com&gt; wrote:<br>
<br>
&gt; This patch series introduces enhancements and fixes to the<br>
&gt; NXP DPAA2 Ethernet driver.<br>
&gt; It includes support for<br>
&gt;&nbsp; - software taildrop on ordered queues.<br>
&gt;&nbsp; - setup speed capabilities.<br>
&gt;&nbsp; - DPAA2 resource version.<br>
&gt;&nbsp; - MAC level statistics.<br>
&gt;&nbsp; - improve PA-VA conversion.<br>
&gt;&nbsp; - add buffer pool depletion state configuration.<br>
&gt;&nbsp; - fixes for shaper rate and buffer prepration.<br>
&gt;<br>
<br>
<br>
At this late stage in 25.07 release, please don't mix fixes with<br>
new stuff. Also new features should be in release note.<br>
<br>
Please resend with fixes only for 25.07<br>
</div>
</body>
</html>

--_000_AS8PR04MB81984927114BE947589A905EE146AAS8PR04MB8198eurp_--
