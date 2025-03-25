Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53359C35FFC
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Mar 2025 08:38:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C26040E2E;
	Tue, 25 Mar 2025 09:38:46 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by mails.dpdk.org (Postfix) with ESMTP id 78ABB40B9C
 for <dev@dpdk.org>; Tue, 25 Mar 2025 09:38:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wB4NFWsNupgpDRJTZ0kg+gigSx1MEBgCruVr5Z10onmo5nmyr6Dol+U2isDYtHg9CfRwFyhs6W1yZEuEeTO3w+N8urLKYkqeegvpa2fNrQGVQafkCdeKQOVozKTbSfGqG557mraXjJojS2mvxeHmIXcOCNhIIznsB8O6dQWS7EUYoqrCpItbwAjRJ6KYB0O15mu2VUqUsebTxlxz7GWQk9ow5jBlhEwMqr7Mj9Nf6bCz4QrHXYoZfnuuhvXpBbvsqCPDqefx/xQfamNHpd9MtmSz0hdY2qEk2yJ54+2ovNODOD3gZ54rN+9L06wRvF09BeCLxhMEokxVzTD3X+vexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lev1xwPmz2agQ5hVRCEo5MW3oXiY70Sh/77ZCwig8i0=;
 b=c/cZoFMBqrrZcn3K+eRDM+uGt00Pdce4i+MtyQkCz03cxlHzrKWJsFdYLxM48IvjcPqXxOxJpUf+SYC1oxsjJgBAcDGGiyVdzKfwBhs/dQ5ch/TdAZcJvJ/hE7Ze+Mv6TtkD1TqgV+0WOYVqmdOgC02J9IDLthTPG+/YMV8wyv9Lmozhr+n/oF1VQ6aqJnkYb0cBN/Uvz9bjyH8xzFTrMaMQncRsHdOEHm6qD0vJ7xwEzI0IOpt+hdBA2mA+Ffh5EFVbMrw5kXZgxThcjarhG9frPL4toXSOnl6qW07tCRR5LKC4zpLYl6IusQe91/ZL6Sk9C9PU5N801ANXxgPkzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lev1xwPmz2agQ5hVRCEo5MW3oXiY70Sh/77ZCwig8i0=;
 b=eHYKxnEd4Ylj3UaincXwxgaMolvUAn/mkAH23u8NO6IOz5w2KciLMl29BRt1NM8KW8dMQpjg8OTTmLbTx/QkesBYLRxx8d/bM3FoG0o1yHehhxLu81vBGAYdDoq/Bpc5d5439xzYiLiokV/U47OPCg3EGQizcXW5Dgvg+rz/TlkwHd2r5DNZ0/Yw5+psCfF8o+M1jrBkofDC/e4I1OWhCCpPNI94K2CpU0mzLXB75hdHzbUtLGbdOsMWr4M7yXacvBRKQoRHg9B3oCvfzhT26Frrld3W4Vwm/3w1rqRdnGouqhIlsOeTa+/fGWi7k6XrjDJ4hdp7nh7OxEmmydg5Xg==
Received: from MW4PR12MB8611.namprd12.prod.outlook.com (2603:10b6:303:1ed::8)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 08:38:41 +0000
Received: from MW4PR12MB8611.namprd12.prod.outlook.com
 ([fe80::ea91:2ce4:e2be:85dc]) by MW4PR12MB8611.namprd12.prod.outlook.com
 ([fe80::ea91:2ce4:e2be:85dc%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 08:38:41 +0000
From: Wael Abualrub <waela@nvidia.com>
To: "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
CC: Raslan Darawsheh <rasland@nvidia.com>, Ali Alnubani <alialnu@nvidia.com>, 
 "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: release candidate 25.03-rc3
Thread-Topic: release candidate 25.03-rc3
Thread-Index: AQHbmIhO2y7EZ9EQAE2U1DuPDlmLCbOCMcgH
Date: Tue, 25 Mar 2025 08:38:41 +0000
Message-ID: <MW4PR12MB8611E7526EB4E9A65CA76707D6A42@MW4PR12MB8611.namprd12.prod.outlook.com>
References: <4293915.o2A3GueYyp@thomas>
In-Reply-To: <4293915.o2A3GueYyp@thomas>
Accept-Language: en-US, ar-SA
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB8611:EE_|SJ2PR12MB9210:EE_
x-ms-office365-filtering-correlation-id: 5d2c760e-6ed6-4fd7-fda2-08dd6b78724d
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007|13003099007|8096899003;
x-microsoft-antispam-message-info: =?us-ascii?Q?XC1bJEeO1eLrIKxMNT2DhpXIIpKcSwGXKsgh78KdmwGAZaAJC5weQPcq7wBU?=
 =?us-ascii?Q?Hf07G9vk/CvNuJtmFoSxSKu5rHZfIb3Fn1BUXGZpfWyV/wlqQzc/Ot4xJyEw?=
 =?us-ascii?Q?i8HD+or9b2u2fv4/W5V0qgFIQ5gvbazXRdcoVPv8Q2KC70hBb8afwsPyISYn?=
 =?us-ascii?Q?aNdgJSsyG15MqQB5QcmIPlYEZ7Ut4fulOLBvNPbRkL7G7tAiTyTZHcZvW4HJ?=
 =?us-ascii?Q?mghcPBKUR3UxqZdooL43jVuaAi3J3FOF2oseyAaVDGtn3Eapeq/GZkwgbpKI?=
 =?us-ascii?Q?dTmqkWDoOP60oc9FN8kBIQ4On+UzJYhS8fkM/n+/x3cdfo+T4tvg3YiccRzA?=
 =?us-ascii?Q?h3Mqe9O9Kt/oMFHekvhTKsy9DFfr3iDC0f6LaVQOdvndMRiR4BEHWxpagiEt?=
 =?us-ascii?Q?UzPksH6hN6mk9aUKw08oJ92BfWfZs893b1e4+i5bqJQB6uAsFIXoLP26coUx?=
 =?us-ascii?Q?P4nzr4NzgCIAfb0VjlcIGrZNugP4aWfcQPDd6bXSNvj6tnWTt8VsXpGhgFyz?=
 =?us-ascii?Q?PsqVT4hU6g2XSOz5lO742ndx/MCXQlj6EcwR0LnM8WWPKmPnT52e4rMcVArR?=
 =?us-ascii?Q?BGCjBxRjHLh0S7quB6Ug+P4S+/naD3LEtrYnUdEvwWrCvh8BVd8BELcrq+8x?=
 =?us-ascii?Q?J45vczsNbZQ4zadoKBeG1FJnTTbCkAMHAFd5kRhaWKj/dAgAH6sqqXOEW7u/?=
 =?us-ascii?Q?7ctzLw75OUrilMJHDCDNRjsjv/g2GIoNDQtkpAAzjI4GVlJl+lHLzvvfXiPx?=
 =?us-ascii?Q?bGdb1VE3iR/ZGEsAljOUDyi4cuI2bEJ06dcUfgQbBNule4Aa9eZlBwOXi2h7?=
 =?us-ascii?Q?U+L+EdDBVkRnXoo8wYvhdjZ9J194+UrI6xk98w0k3B4fKopNp9dkM/Bmhyau?=
 =?us-ascii?Q?WrFOv/fHhY+/HkJm3gMEAfCc1x++WFKdLkuCCdZnYQkS1nbanLZBKDzQ5B4d?=
 =?us-ascii?Q?37TDaZxpDEJn79iPsIZTtfaGgyGlH9DfzuuApXDpmrSdoikbW4R808m/nb3Q?=
 =?us-ascii?Q?/FD2a+GxqoC/1TPyKIeNz/ELe9v3iwvbD0LeV/bOeun34DY1FAWuoKOPZLgR?=
 =?us-ascii?Q?zjIbnAWME2DIwG+kYIY20LpG5eJ/zbmjsL3tEqQkzHzkVtOIrDa6ZXwcvKGy?=
 =?us-ascii?Q?EG+CbrXG7dfDAQiFD3UTvcMEud4Wdxh7aX2FPzeyXS3xRNMBh9Y/tcogO+Gh?=
 =?us-ascii?Q?EmO7j9lIpb0nH2zRi3tQjQiFhP8SPfwDCoZmRrr/P4imNN1uWelSiaFkeqa7?=
 =?us-ascii?Q?/xhgtUHt+7kYU1mxn17rFjzhprjUZymlqNBRWpzmm4vYVb6FwVPqBfQQX0kK?=
 =?us-ascii?Q?Hu3rI4OAmmFqh4HGWtl9mDUZGC3+l8Y7dW/inJH1XXIFsB3wjRArLDNEKg45?=
 =?us-ascii?Q?N1CTf4KilWB+p8kdSdl3Mv78C+Pl2EDNvWzH1l8AALSc1fr8jF6mvAP95dM3?=
 =?us-ascii?Q?LGmoaqkVL6AzpnCNDCzRGIShj1JqdI68?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB8611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ypxG/CtURSS+fWbtTKzO4gdS4QuUSSDx/6y3dE24DZCWpzJuO0j1EFkdkWwC?=
 =?us-ascii?Q?9BNHyoda5UmvIk+ZsSnksKJByea19foeGgJl/5VwJZf9+SLp5n3YtZgybbZ5?=
 =?us-ascii?Q?ZZYQXgLU1zyqmfUF9UC3qt3st2DY5IxYAyGynlF1AT8r8NKVbVEaij4721OO?=
 =?us-ascii?Q?r+MDN8PT4FZIHlbd3NUmWPmS7bkp9/JWjCpdNbOuESD1qQCfRMmCAr/ULLtt?=
 =?us-ascii?Q?JsOEyF5/izIJJwyffsr+V4+YJa7Usgi74e5isddSBg4AGp4PgfQFb6NiY7K4?=
 =?us-ascii?Q?aszWdN13u+XZG3D3S+7lf+USx4/bjzPQA9EvYw/SQwq0DqT42ONmekWNo9fB?=
 =?us-ascii?Q?NiBBriBgcsRcJYHxlS4jSkzYX1J9tpho4hwcKcJW15JI1nJpAsUnIDXNtJod?=
 =?us-ascii?Q?iL7WoSV2kZEHpJ535dODZVSt8qB+rTclAMKbx1KfnreGvI2bEcSEs239KLPk?=
 =?us-ascii?Q?FU1MaZ3QhLFK+hSN4B61i/lQsn0+RvA3Z0tJqRH5JDWwWjnIIN46bOG1aNNR?=
 =?us-ascii?Q?Had/FlqDqq1ZZG/ZgHV38aebA6SXYe5M13u7f43HAPkauQ40wkGsIYR00ukr?=
 =?us-ascii?Q?fIZ2tKgYh9o5DtNaAzKzsXM/rDP4HwQ8NMf6NATnroTh93tKinMZPQuOZuKz?=
 =?us-ascii?Q?8V+nTl062cl/gTdx6j9UzXMNJ3dbK7zh5fkNf3ZoamMRFKGtSzG6f6MBENHb?=
 =?us-ascii?Q?f8vFa6knY4leOO+YtWe5SlCwe9JZ+RbRf3Ok9YQeB/FdRs855SYKtpyY7I80?=
 =?us-ascii?Q?eLdLMtrWsU9/GUkx8MMjDDKEk+l1o/sJ/vkAhJW7s5m+Z401Qe1nbgjQIZ4d?=
 =?us-ascii?Q?/s/bcyKwuwUv6AnmvinRU5iIgxoLy6PSMBbJmqQVoM9fklfbtov1AzFzceZz?=
 =?us-ascii?Q?ksGIboojmfGoenTDgRcCBIc1CtruI9sh/iEi0J9lUA3HVVMO55JDcbi14O0P?=
 =?us-ascii?Q?IFOi9ZEuKk5WzyzgkW4d9hwqiKQUTB/lyga94o607RBVIYYbwKRBfAllxoXN?=
 =?us-ascii?Q?FgDy/TFXVOGek7I1vvzOGXIq6+IpaDB1drJJLbmS8PyjcdCI5bAvPIJIAjq7?=
 =?us-ascii?Q?P4wWULbBII47qOHEi8OItKVdviGwEVb6T7RlsjvxzNNCO0f/1OTKbCWFi0zh?=
 =?us-ascii?Q?Vepc4rXIoVCjV3jbgUWVBhBbIAfLaElM1LrqWhtjzDAri3fZ6GKyR6jrrB6f?=
 =?us-ascii?Q?I/jZSiv8KqZE0Hh1YafziScsOihwfB4Sqq82vOMQlkBTY6EzWva4x2s3G6XN?=
 =?us-ascii?Q?y99rX4cd2n2CB1tN1fJmOXdRA3p74PAxzJgx+7ioBhBl7CU26PVczLsCh+Sn?=
 =?us-ascii?Q?0s3lTYptI875wJIYJMhhpJKdCvXjiS8vE80c3Da9bNZFErSu/vLy9MX+kT8m?=
 =?us-ascii?Q?EDQedd6hMVJPasz20p9IxlBPXlksEp+PiUr1KV9ueLat88XpanO07DEVBr+8?=
 =?us-ascii?Q?7ewzRcYqdB3SIv44R04DX9Tpi4yIvEAWPozy0Cd9SctqsHyOF5edyYMXBkz1?=
 =?us-ascii?Q?+HUdkegL8nKivRqZbwMDFtpKfiEB9FbKpSLjrEPyvJX2Lmd0tJMNdjYNbvUX?=
 =?us-ascii?Q?Lq8YmnYd0AcjWQD/A79Cgv2anB2GN6lRU3Pe7vghL4rANYwmlHlVWFESIWiZ?=
 =?us-ascii?Q?kQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MW4PR12MB8611E7526EB4E9A65CA76707D6A42MW4PR12MB8611namp_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB8611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2c760e-6ed6-4fd7-fda2-08dd6b78724d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 08:38:41.4239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KsbU9woshHaauERRywwGAgpHeFNe8kIeS6pCAtmXuO9yJt8Cp+adEfmylg0QVzp4Ymd4geEVOgcZ+FADh5T92A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210
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

--_000_MW4PR12MB8611E7526EB4E9A65CA76707D6A42MW4PR12MB8611namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


 Hi,

> -----Original Message-----
> From: Thomas Monjalon <thomas@monjalon.net>
> Date: Wednesday, 19 March 2025 at 6:35
> To: announce@dpdk.org <announce@dpdk.org>
> Subject: release candidate 25.03-rc3
>A new DPDK release candidate is ready for testing:
>       https://git.dpdk.org/dpdk/tag/?id=3Dv25.03-rc3
>
> There are 71 new patches in this snapshot.
>
> Release notes:
>        https://doc.dpdk.org/guides/rel_notes/release_25_03.html
>
> Please test and report new issues on https://bugs.dpdk.org
>
> If no major blocker is discovered,
> this release cycle may be closed at the end of the week.
>
> Thank you everyone
The following is a list of tests that we ran on NVIDIA hardware this releas=
e:
Note: all tests are passed, and no critical issues were found.

- Basic functionality:
   Send and receive multiple types of traffic.
- testpmd xstats counter test.
- testpmd timestamp test.
- Changing/checking link status through testpmd.
- RTE flow tests:
        https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-offlo=
ads
- RSS testing.
- VLAN filtering, stripping and insertion tests.
- Checksum and TSO tests.
- ptype reporting.
- link status interrupt using the example application link_status_interrupt=
 tests.
- Interrupt mode using l3fwd-power example application tests.
- Multi process testing using multi process example applications.
- Hardware LRO tests.
- Buffer Split.
- Tx scheduling.

We don't see new issues caused by changes in this release.

Kindest Regards,
Wael Abualrub

--_000_MW4PR12MB8611E7526EB4E9A65CA76707D6A42MW4PR12MB8611namp_
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
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
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
<body lang=3D"en-IL" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<div>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">&nbsp;<span lang=3D"EN-US">Hi,<o:p></o:p></span></p>
<p class=3D"MsoNormal">&nbsp;<span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; -----Original =
Message-----</span><span lang=3D"EN-US"><o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><a name=3D"_MailOriginalBody"><b><span lang=3D"EN-US=
" style=3D"color:black">&gt;
</span><span style=3D"color:black">From: </span></b></a><span style=3D"colo=
r:black">Thomas Monjalon &lt;thomas@monjalon.net&gt;<br>
</span><b><span lang=3D"EN-US" style=3D"color:black">&gt; </span><span styl=
e=3D"color:black">Date:
</span></b><span style=3D"color:black">Wednesday, 19 March 2025 at 6:35<br>
</span><b><span lang=3D"EN-US" style=3D"color:black">&gt; </span><span styl=
e=3D"color:black">To:
</span></b><span style=3D"color:black">announce@dpdk.org &lt;announce@dpdk.=
org&gt;<br>
</span><b><span lang=3D"EN-US" style=3D"color:black">&gt; </span><span styl=
e=3D"color:black">Subject:
</span></b><span style=3D"color:black">release candidate 25.03-rc3</span></=
p>
</div>
</div>
<div id=3D"mail-editor-reference-message-container">
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-size:11.0pt">&gt;</span><span style=3D"font-size:11.0pt">A ne=
w DPDK release candidate is ready for testing:<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><a href=3D"https://git.dpdk.org/dpdk/tag/?id=3Dv25.03-rc3"><span sty=
le=3D"font-size:11.0pt">https://git.dpdk.org/dpdk/tag/?id=3Dv25.03-rc3</spa=
n></a><span style=3D"font-size:11.0pt"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt; </span><span st=
yle=3D"font-size:11.0pt">There are 71 new patches in this snapshot.<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt; </span><span st=
yle=3D"font-size:11.0pt">Release notes:<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><a href=3D"https://doc.dpdk.org/guides/rel_notes/release_25_03.html"=
><span style=3D"font-size:11.0pt">https://doc.dpdk.org/guides/rel_notes/rel=
ease_25_03.html</span></a><span style=3D"font-size:11.0pt"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt; </span><span st=
yle=3D"font-size:11.0pt">Please test and report new issues on
</span><a href=3D"https://bugs.dpdk.org"><span style=3D"font-size:11.0pt">h=
ttps://bugs.dpdk.org</span></a><span style=3D"font-size:11.0pt"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt; </span><span st=
yle=3D"font-size:11.0pt">If no major blocker is discovered,<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt; </span><span st=
yle=3D"font-size:11.0pt">this release cycle may be closed at the end of the=
 week.<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt; </span><span st=
yle=3D"font-size:11.0pt">Thank you everyone</span><span lang=3D"EN-US" styl=
e=3D"font-size:11.0pt"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt;color:black;background:white">The following is a list of tests t=
hat we ran on NVIDIA hardware this release:</span><span lang=3D"EN-US" styl=
e=3D"font-size:11.0pt"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt;color:black;background:white">Note: all tests are passed, and no=
 critical issues were found.</span><span style=3D"font-size:11.0pt;color:bl=
ack"><br>
<br>
<span style=3D"background:white">- Basic functionality:</span><br>
<span style=3D"background:white">&nbsp;&nbsp; Send and receive multiple typ=
es of traffic.&nbsp;</span><br>
<span style=3D"background:white">- testpmd xstats counter test.&nbsp;</span=
><br>
<span style=3D"background:white">- testpmd timestamp test.&nbsp;</span><br>
<span style=3D"background:white">- Changing/checking link status through te=
stpmd.</span><br>
<span style=3D"background:white">- RTE flow tests:</span><br>
<span style=3D"background:white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;</span></span><a href=3D"https://doc.dpdk.org/guides/nics/mlx5.html#s=
upported-hardware-offloads" title=3D"https://doc.dpdk.org/guides/nics/mlx5.=
html#supported-hardware-offloads"><span style=3D"font-size:11.0pt;color:#00=
86F0">https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-offload=
s</span></a><span style=3D"font-size:11.0pt;color:black"><br>
<span style=3D"background:white">- RSS testing.</span><br>
<span style=3D"background:white">- VLAN filtering, stripping and insertion =
tests.</span><br>
<span style=3D"background:white">- Checksum and TSO tests.</span><br>
<span style=3D"background:white">- ptype reporting.</span><br>
<span style=3D"background:white">- link status interrupt using the example =
application link_status_interrupt tests.</span><br>
<span style=3D"background:white">- Interrupt mode using l3fwd-power example=
 application tests.</span><br>
<span style=3D"background:white">- Multi process testing using multi proces=
s example applications.</span><br>
<span style=3D"background:white">- Hardware LRO tests.&nbsp;</span><br>
<span style=3D"background:white">- Buffer Split.</span><br>
<span style=3D"background:white">- Tx scheduling.</span><br style=3D"caret-=
color: rgb(0, 0, 0);font-variant-caps: normal;orphans: auto;text-align:star=
t;widows: auto;-webkit-text-stroke-width: 0px;word-spacing:0px">
<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt;color:black"><o:p></o=
:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt;color:black">We don't see new issues caused by changes in this r=
elease.</span><span lang=3D"EN-US" style=3D"font-size:11.0pt;color:black"><=
o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt;color:black"><br>
<span style=3D"background:white">Kindest Regards,</span><br>
<span style=3D"background:white">Wael Abualrub</span></span><span lang=3D"E=
N-US"><o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MW4PR12MB8611E7526EB4E9A65CA76707D6A42MW4PR12MB8611namp_--
