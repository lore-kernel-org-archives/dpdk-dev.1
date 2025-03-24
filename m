Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFABC36002
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 07:38:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84AB3402E9;
	Mon, 24 Mar 2025 08:38:44 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by mails.dpdk.org (Postfix) with ESMTP id 0D606402E5
 for <dev@dpdk.org>; Mon, 24 Mar 2025 08:38:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rv/dBCng8OyfoGaLDCprBSeKtFTD+VHHcyuZtevwaDXEBCenRLuP+nlAOnw78w8wtnyaDL3QEPQQPlfrxTMCtVFS93lyFRmTepRkbreh/JrgQkE/uwojWFeQ8l5tc+R7AGJ0xXibsDCs0mUZtfffSj7aM6or2OypshxUuhiXbxwYPQquPbJ+ALjqH8zTMcv/zCG9CPk4WNGAnJMr+XIknK2ydyoxDeiquCyfDssFUmIEFN28pZF6rnkY1otUmXwWTotPafVii27Y2vqNHNuSRzLu1jsq45FfFyuUcaWYNU1Zf4vY1FFG3cbipKHLgurXdpHWkklAgm/Z6P3HaySkOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIczkhZhV6FsQR2yoJrb9vZdVvyIbFOdcHfbPD/W9QM=;
 b=I+A4MTZPmEF/P75Mtvj7+uSx4DlJk6StXFb6lGtcYYmdanLUvC7WJZcp8nom9bPARyZO9Um9gM0OBOffDrs38URmbczUwa/u/hRqvt1RBj0AYnCq34FC0S8HRxura0fJW/fTqnlq8typvI4tg3VHPpiZJBSDcJxFq75cpxva73RzMYto3LG8cxl2M6R1KHmYosbC+Gra2tG/azLBNeB/aa3sqXs/0SUmijobBhjcfxB2h0cOOH2s2Sg2qDSu0Y/KqNSbU6eYzit8XAmK6vP8dXICxvSy7SGTB+z7U56fkIcWyc1BEqsdDAoVAYIKcfHj9mGzyQ/aMB0ocHxPiTxaPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIczkhZhV6FsQR2yoJrb9vZdVvyIbFOdcHfbPD/W9QM=;
 b=JtyhHOMSxS8zTimfMVA+YDG1YmWmdVxieie4HfE6I89tyxtNXylpfIzOYF+swBa6GaEXYnI2pIxyEYyIO5O2OcFslRP9TzPWRD/u7Q53AOJqs/KIKngEcRLfxzVDX3UgtSLKxTRlMGwuiZZuy8BjwxRv4+n21WJdph+zGULrifg2KuZuJ5WkmxS2mW34IIBB5MtiIWGkQzvn+6uFKFfrrj90vqR6zcDf1sFfVFRXsbn55ijGswlLZhJClmuS4MTBrAM60OIlkxKzFzN3PZbYUtYIkRaJvWosQe0XVJjkUmONFQB/iGQOpyqBN9VqzvquPRDSf7C0GyoXhPzg+9+SQQ==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 07:38:40 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 07:38:40 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, "haijie1@huawei.com" <haijie1@huawei.com>
Subject: Re: [PATCH] app/testpmd: fix VLAN header parsing
Thread-Topic: [PATCH] app/testpmd: fix VLAN header parsing
Thread-Index: AQHbm+8qBy++gaakq0m8DcV6iO248LOA7GQAgAD632o=
Date: Mon, 24 Mar 2025 07:38:40 +0000
Message-ID: <CH3PR12MB846087E8B2CE0A1A443C9903CFA42@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250323122822.90407-1-rasland@nvidia.com>
 <5993081.QJadu78ljV@thomas>
In-Reply-To: <5993081.QJadu78ljV@thomas>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|SJ2PR12MB7799:EE_
x-ms-office365-filtering-correlation-id: aa7c1582-50ea-4b18-a3a7-08dd6aa6e570
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?dDkpntyQDkBnJT4V90ix/MDwmzrCXpTG/+w61MMVurDYHd9o8mPM03/c?=
 =?Windows-1252?Q?eP/Nuo/7a8Qun0lVqJzQzglL6OeLG/26t+cEbkyzl430XgirEQlp0MZR?=
 =?Windows-1252?Q?JZFWOr1sB8+qoE9oU+FSiAS3uuA3LYafHNsQbiXEBHS+HoZ/FAqJLYfr?=
 =?Windows-1252?Q?4cBS+QBsd4Cp/Hc1otoJqX8+sG72E/xYUE1ThIzEUsRSwlE7KdLDGN23?=
 =?Windows-1252?Q?S11ZqyV6uFFwv/uQprf3mk0rwmJ2teXz3+r478M/nrd66gqlG63GcRZi?=
 =?Windows-1252?Q?dPAnpFI2aceS4eF8TMqbqGY4fEZ5LgaXBY3vkzB2VLrlHlF6MDY6HVbm?=
 =?Windows-1252?Q?aAxgglyygFRXlCmN9bCv9duNpOmBGMzGNcfXVToTAa6W/el60AD3c835?=
 =?Windows-1252?Q?Ul4UfotEniwZBlaGbyHt5XuIvYeCP4O2QFF3VrbDAyVNSeW/LPQDWrM9?=
 =?Windows-1252?Q?5SV610DhBfdtY5CwccNlpwo7WlZfGcAs3lapbc04EnxulchyWtRwO6/P?=
 =?Windows-1252?Q?13Lfg9mtlBh6bBAsv/xhATvudAC445vRUZEesxMmM1zm9m5Nk1zs6sjm?=
 =?Windows-1252?Q?m2meHZ+RjXxNc/nCZ+uVA8vzSYVOmRD6R1FYUWkVK6Ri95ouegFA1paK?=
 =?Windows-1252?Q?OBWylhRg9lQmIDNbx9WKEjg3qCRwHlU+JwIY2oQ4d+45+O590Q/x2+ko?=
 =?Windows-1252?Q?WOxgF6O4y/QkPpsdOGlSvF9ZNonM4cAQteQD/C/mJx01p/+5/x08ykZF?=
 =?Windows-1252?Q?Q9Yccz3HLIwgUoI+Ap4sQk5eiW+5CT8z6+lQrE2cRGRSJUv54nx3w/7l?=
 =?Windows-1252?Q?OGnD1iWPEuxR3V6E0uIleitubCMlt9XZnkzwMbWmH6CuNXDWbq77Z2/H?=
 =?Windows-1252?Q?ZSemIhgLUcDn8fUcJtAvcJY6GNH2WI2lCeZNcOSwNKsnJLfHnv5tdDDj?=
 =?Windows-1252?Q?HGB18WyuyIyQOqkLaicQvB/lN+UNYZOakOExdpOiVtk+7YvvqXM5WBW5?=
 =?Windows-1252?Q?58uYHIJtiTSwtcE03HGOZOyXKceUoXpuECsGQNwetGMPyirhg000+SVa?=
 =?Windows-1252?Q?8TiydUDmNDoJXm/p2HPQqcPyEJ9t8FEI/npk/crn0OOZLI2eAmqkdxD+?=
 =?Windows-1252?Q?qpdGAs9/v0Ch2tN6830adAokKRYQBUKp5mkbF4e9DSWHPyIXpsnQLP9u?=
 =?Windows-1252?Q?cdWSWzRmkCJVxKjlfWlMHF2WOOfLc3Vh2BOR0qxMiuCfvOb9v6SK9Qp1?=
 =?Windows-1252?Q?7nM4lULWvCmRuBVjml6CBtTZwcy7anid8JnQr+c7/nW10RMaZzjUiFk9?=
 =?Windows-1252?Q?hOZjpztZtJ97ytrum8XYP/ds0kABgH16CjApEdRBRHTHipYJzR3pZ8P8?=
 =?Windows-1252?Q?COppZ2M1AGeg2Hxa7znJsJaBImSZngCNflHTwUH5NZSXH6MO43ORNpfR?=
 =?Windows-1252?Q?dgUiDzlZwhvP233JohQbKhhh1//cRxIwizStso52bbH/P6MCPEPy+4g3?=
 =?Windows-1252?Q?rD9bl+sxGuytTh2QQdH/2ZQhxSpBFA9NY15ZpnV3MuM2vDeJ4wasJKwW?=
 =?Windows-1252?Q?paIWDmkzA0Bgx+MS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?dtwYVphTWpjZNyyl+pJBSApAhFt8e0U+YpKc1Gcn0Qm7n89MHv+yj3kX?=
 =?Windows-1252?Q?OWFl2KzHNPosRlSQQ5yigw8OekUCnwxkbxOW/lnbubrW6D9OjWscuU3O?=
 =?Windows-1252?Q?kgzQ8i8Q3c5bEQfxRR9XR9W3EJ6lmc/eaNXRsMQkNl5YgtynGTAG+my2?=
 =?Windows-1252?Q?8b35R93jtlFcsta8nJd5w7qRL58+hVWy7gF1vobWeycFBYvkFje3hMps?=
 =?Windows-1252?Q?rEbLwBlnWHh26AUJ/iIiNe+PkKxAmkpbnq3HS3Z9dplYUajpdGeubcZt?=
 =?Windows-1252?Q?A6eDJdd9ZGuthODlfa7u0Dp949SQXeAtuOdlB+MBuxqTjUMzxcr3RABD?=
 =?Windows-1252?Q?9qrSKKd8KF83xe9yAMVsKJ9LYzqrV2bDjcGZtNpVSYrfPjwCmxZbaCQu?=
 =?Windows-1252?Q?fduH+hWkq3lqZ0XB+5Azq7JEmjl4XJfMtJWyyAKniFBh16NSUISjX1Y6?=
 =?Windows-1252?Q?dOlrNoBu2NomO5x6oxWNNfFtlikomAIJysLUDv586sPEoU0MSJ2OjtSx?=
 =?Windows-1252?Q?vdK02mLdOplpd+JgjvkSdw3OhxpE38cum0foKEzorN+S3Gq/td2L43Ed?=
 =?Windows-1252?Q?w4/1sT/S9uBd57JmfQHIQF6yD9obq1p7vr22iySRCPDfut0x61Z2QNkS?=
 =?Windows-1252?Q?bRsSvEre38a5FMQq9/26kBs3pmHF+PHjUWVyRttlhC/8zPhgSSlMi1nl?=
 =?Windows-1252?Q?apb5+cz+IFwwjNpl+z6l2c+T0+11bJ6w+bxUaL9XDPheAAUFdbC3NKer?=
 =?Windows-1252?Q?Mi3tDB85zvkEOB1FKBcI+gwc89SLiZir/3Mv6DFjidmUzryyCZun4LaR?=
 =?Windows-1252?Q?vl/Hroa5kncPYxlBZZ5QDm4Scq4WyWsUCxy/sLcjMTyF3yKWo5mAMA1i?=
 =?Windows-1252?Q?2+W/Mat7ZLA8DBSM0cqgwojEALMncnCWB/8vEqU/rZ6/i7VWlbBGwQhx?=
 =?Windows-1252?Q?OJtGRWjyHcH+AXTfMeyNaKvcM2fvgNuAV/aHNTk1TuBlAgjHAcx7V57H?=
 =?Windows-1252?Q?A5EV0rC0FIXelRNpg7/nG5as6hrGqgJsmkUYyTxbK2zReWcvnyY9OGwz?=
 =?Windows-1252?Q?ffHwy8TptZkLZMCnC9vv6zeofEBjucs3e2lZMfc366FtbLJCuP07vcDf?=
 =?Windows-1252?Q?ih46IdplJdKoCLU7zK+ISTpCOku0edk2Yu2ZqomvxaoMFku/l/1og+JO?=
 =?Windows-1252?Q?BbGjV40ynDc7xBISgpVobWiua/He0qO3LXnwcW7RjdBmd2bY/f0zLvWF?=
 =?Windows-1252?Q?yPjusT/jerxkTbF1ZYk0Q+htbOokZqd+DY5/8lQpjQCop7HiKs736nIB?=
 =?Windows-1252?Q?X+EK+UONKYfUwqxbkROVKqFCl9ghbslwlnADiX/dMFuExSs0TSes0Mwt?=
 =?Windows-1252?Q?tWFOpY8g+DEoWXU2wpfOCGXsSW75451VCOHELNeYO+FRUiLPiF1Hhgb6?=
 =?Windows-1252?Q?bjbmvlSCLteT7BmZ/GWP88FTH8KYS8XcqtSFZAcXb67b5Zl+DK2a+Kw0?=
 =?Windows-1252?Q?0y73BCfsewVFB6vt/sH/VKojuuH9imaTy+eZg9EcpWYepG+1VnFv07aS?=
 =?Windows-1252?Q?EOgkCYholhH2RZeJWprodOS4GkCFoI5XIMaxN9s54f4RC1xzAIcEQjHZ?=
 =?Windows-1252?Q?zJPY/L/HLOQbr20+KKFb/zxA75VLcs+Ho+zs/aYoQAjSaZDZJTBMq5hh?=
 =?Windows-1252?Q?Eq5CEewFxJpT7H6j3iAwFhc9JIHskVCenIhhL6DRKiwBkCHxdxqyyQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH3PR12MB846087E8B2CE0A1A443C9903CFA42CH3PR12MB8460namp_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7c1582-50ea-4b18-a3a7-08dd6aa6e570
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 07:38:40.2690 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L8CBe5Iu+UVRo+Rr4jTLgm/RSUCSSPSCOB+sdT6xycLU5WxnCS/xzltQ9ZQb1EyXOcFUYZ3ORaxphN7Pzht6xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799
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

--_000_CH3PR12MB846087E8B2CE0A1A443C9903CFA42CH3PR12MB8460namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable


>> Updated the `get_ethertype_by_ptype` function to correctly parse VLAN
>> headers.

>You should describe what is broken and how.
I=92ll handle in v2

>> Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")
>> Cc: haijie1@huawei.com

>Do you think it is critical for the release?
Yes, as it=92s causing an infinite loop if you send a QinQ packet with csum=
 fwd, and it will cause tested to get stuck forever.



--_000_CH3PR12MB846087E8B2CE0A1A443C9903CFA42CH3PR12MB8460namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:10.0pt;
	font-family:"Aptos",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
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
<body lang=3D"en-PS" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<div id=3D"mail-editor-reference-message-container">
<div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; Updated the `get_ethertype_by_ptype` function =
to correctly parse VLAN<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; headers.<br>
<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">You should describe what is broken and how.</span><=
span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-size:11.0pt">I=92ll handle in v2<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; Fixes: 76730c7b9b5a (&quot;app/testpmd: use pa=
cket type parsing API&quot;)<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; Cc: haijie1@huawei.com<br>
<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">Do you think it is critical for the release?</span>=
<span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-size:11.0pt">Yes, as it=92s causing an infinite loop if you s=
end a QinQ packet with csum fwd, and it will cause tested to get stuck fore=
ver.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt"><br>
<br>
<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CH3PR12MB846087E8B2CE0A1A443C9903CFA42CH3PR12MB8460namp_--
