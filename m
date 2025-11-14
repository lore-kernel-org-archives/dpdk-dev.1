Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A43CEB2E4
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Nov 2025 17:01:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD8DB40E3E;
	Sat, 15 Nov 2025 18:01:39 +0100 (CET)
Received: from MA0PR01CU012.outbound.protection.outlook.com
 (mail-southindiaazon11021118.outbound.protection.outlook.com [40.107.57.118])
 by mails.dpdk.org (Postfix) with ESMTP id 2E86440151;
 Fri, 14 Nov 2025 11:12:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bncq2/0pNHDCVT/IWVVPei/qKFNci+a8shD1azmyfJ/oAvsDBeWyrrNMD8ylIfnEBHW8aPhbmdiaLeIem2M68dVHEGL5dhcz6hBe8rj1JFSsdoTjKuFPpTmGS6pmZWN043+gFknXMJ53jo22nDu1tzeZExqy/CK4vLSSFxkOOeV1cwSXErUO/J2IBw/Gf+bC9t9fPoHswQv4EeVfknHfDVqrawENuHUw/CndCMGA4lvbOBHHXeP+9jqzGjmCJe0SxwWPHiLluaGV2zrKEqeOg1aJbhXqoz/VixOWa3aULhBis/kRdQs8eqjcEiIfdS2gyi/3Z6KuY1vtSXFze3LQqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikbf9p7dzIi/faEIuq8N6hm/Vw5AfXQSxnRQCWTbiqU=;
 b=lEHeeoXsDUtcdviNyahMBDpe0/G7Uukzd7LvyUKo+t6hVz7uu7reCEqcXBvSRysZwtx6oZjFQtLMFBwe1JLxo7lFmVcFs9XfN+P2v8of/Jl9EluVQ+v4huyAnqu8wfJ90ARw5MWZkaaGf4Fv1B2xa5aCKt7IXUgRgbbtFu3a1M5OdX32I3X8opIXzMSTl3/UnZBeN6SCAd5ayDgLYpwVQ5C1kN8pNVmzMFp+Qml/8Sjj8WXEqyYPKF1wKc3ya+KJ40JxdZBOak4BgGewxSVfdPfHjBe1NZoJBjrJ2WXKcyFTtTQq1YpbtjJ2GKwLwfgXIfYkjWyt/nXneAYVzst2JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iwave-global.com; dmarc=pass action=none
 header.from=iwave-global.com; dkim=pass header.d=iwave-global.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iwave-global.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikbf9p7dzIi/faEIuq8N6hm/Vw5AfXQSxnRQCWTbiqU=;
 b=Cf9TaAQUXyat8FkXtv6fntv1X4SLlN5oRsTdifn0GBexx9K5hi1gNrtR/vIs1Col+GeClUdIrbm/ayNx1MOE0nArcR+CIjwLGovkvD6TTicdOOg8jeMMlpoQoQH2CyOMl393H5MQOXnyNOsj24T2X8vgRPbMQAPRDha8vftNdTHqjdvNUiHtiBeMAZIQ1tHBSEJTuqMeaxec/YI44An1kBTviItn6TxwlLWeFrUvrl2vStD8n25KqvB/oaipL6NN5Fs/86i1Ji5DCUcvm5jDJjO77C/WcXDiCT6vFOxWY++TH7tOjBTILQmCxGNt+khfpbAgsxiTp4sS8BAY3tukpg==
Received: from PN3P287MB0273.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:d2::13)
 by PN0P287MB1061.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:139::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 10:12:52 +0000
Received: from PN3P287MB0273.INDP287.PROD.OUTLOOK.COM
 ([fe80::38c6:bda2:131d:d3bd]) by PN3P287MB0273.INDP287.PROD.OUTLOOK.COM
 ([fe80::38c6:bda2:131d:d3bd%5]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 10:12:52 +0000
From: Thenveer Poolakkanni <thenveer.poolakkanni@iwave-global.com>
To: Thomas Monjalon <thomas@monjalon.net>, "andremue@linux.microsoft.com"
 <andremue@linux.microsoft.com>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Chaturbhuja Nath Prabhu
 <c.prabhu@iwave-global.com>, Ayshathul Thuhara
 <ayshathul.thuhara@iwave-global.com>, "users@dpdk.org" <users@dpdk.org>
Subject: Re: Assistance with DPDK on Windows
Thread-Topic: Assistance with DPDK on Windows
Thread-Index: AQHcTX35keRHNFi4HUamT/VsYmxpN7TjstmAgAAvP4CADhga7g==
Date: Fri, 14 Nov 2025 10:12:52 +0000
Message-ID: <PN3P287MB02734300BEDDDD5A08219DCCB7CAA@PN3P287MB0273.INDP287.PROD.OUTLOOK.COM>
References: <PN3P287MB0273982789E89005206DA9B0B7C4A@PN3P287MB0273.INDP287.PROD.OUTLOOK.COM>
 <85f9def5-7f88-47d1-9dc8-524b060c54e5@gmail.com> <2455856.MHSsGVy7CF@thomas>
In-Reply-To: <2455856.MHSsGVy7CF@thomas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iwave-global.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB0273:EE_|PN0P287MB1061:EE_
x-ms-office365-filtering-correlation-id: ce56e195-1b27-44b3-7203-08de23665f16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021|4013099003|4053099003|8096899003;
x-microsoft-antispam-message-info: =?us-ascii?Q?Knl+M6v0EL3DwtLZ1B+eKlsU2k0gI0cAAz9xVDuEi7bAJ1jSzku5CTFNroQQ?=
 =?us-ascii?Q?DtCVe1nVVV1S6XrD31gab28QL7U0p+VUfawsTyL6WVw0niJ3fWMcD4TT5LTW?=
 =?us-ascii?Q?ayXmxSHx0f6E+k2/3/msQGmCjY/a+ChBliLWTqP7W7lnhvnFcWho+jx3fsSd?=
 =?us-ascii?Q?9fGJUAyauw5UnYhPdPoAXjYgeSIxzYmKFARhjwz5yEZPhywer/LGrr0D7cGi?=
 =?us-ascii?Q?r9t7gn8BA15P4BDUGbk32ajnV/rTUuiVlAN7xpJlGgCVcFLwtl7JtLmZqrqJ?=
 =?us-ascii?Q?ke58MihXxIhjbLp6trBPSGnGA2+d0wvK4wXqvSS2MVtTzpYgT5PnwrMCX6I1?=
 =?us-ascii?Q?6kATWl1DF8dHM+iIa/0NEwGQda+lm+eDTv0TwIvk1XmbvkOtyWtRdM0u1gae?=
 =?us-ascii?Q?AIF4PWtqx6pBQjV3mQjnhLB5ijH0SL7yxNXhztcuMXOGT4DVaSDs99EWp7Ld?=
 =?us-ascii?Q?vBHrwz1jQaRjWhyo2DM6e+RLPt9Ip/BRQHsh6o9iXjZf07XoiPest1W1yGxF?=
 =?us-ascii?Q?BCiyz8gdyQ+Tm2gZ/OFke0zDcUURxInP4vyqupPUibgfTksPQlT/ATYT0II1?=
 =?us-ascii?Q?yKwezlDetZ8cRNzWoNXYM3yWpJDRNJg9Iwk19yYmmuFzfK2JjQPFZf4vx0a6?=
 =?us-ascii?Q?nsIZjBLgX5qmmOk7tiu9+xDvk2oSYqx5sCHdTxKC0DYDW0peknkcoLP3OCZP?=
 =?us-ascii?Q?lkgW2bj1/yN/mZMiSEXlHX6Yg/+5F0OGyKiqDi938JnN4jrKggMjM8RR+Bf/?=
 =?us-ascii?Q?q+T3JrtHgZqhyXIaHoD2J0awHd2xbh9OF3XTP4w7RbOuGwOGed802EVcoJM6?=
 =?us-ascii?Q?wIPx+OJwsVsvTv8BwNzCVT+srCOpn0XOjvAZ5CGYA48VAPf+Bx7vXLBKu2wo?=
 =?us-ascii?Q?8C8JRrQV4u+WWXlyrWHuX27dOAYMWE/CmicfXMxqoWUIlb576LO1rddRJBZX?=
 =?us-ascii?Q?9VTZMZtHvgVdmW4L0yDi/uw26gQaGEA+XhZrRcqQNTvCSASSRTdBC282q9Im?=
 =?us-ascii?Q?7em1dcXkOhqo8c/J8myryhr9szdlrB9AF4RcrolQjDwf4oYLdgy5qVSBlysx?=
 =?us-ascii?Q?TcsfZxNLyWFx2tCr0VezXN0nCRAFykDLtwXpU0U74clrURVoaQApoUNmKx6N?=
 =?us-ascii?Q?CTwY0xQyAJSOS3iOUVfK/U+k2FuZWup7EBWYKIrxphOwYeCzJG8pZl0BChea?=
 =?us-ascii?Q?HL/GRwaBvRJk6uaYcLg0J0+PaS/DglfBI6wk92DRPe796nP7Rqz/bFQY5gyh?=
 =?us-ascii?Q?GjcOx7qaNXqiZyXSc/bQpM6f8N534VZi7784CjELF1bvdjljvhHOURIcMy1F?=
 =?us-ascii?Q?zBLBexCl/tkWQYGXKAxAVV9U+H2NWFrp7cM3cQ4c1GMZUHqe0g09BTIEVKzf?=
 =?us-ascii?Q?XN3stx1FJQR1mrrylpmvb7m0NpFRk9fZpgGGNcMD3/L8D73Mv2EMrir6hHVB?=
 =?us-ascii?Q?Y2xj2bgOMMyoGGYxhSep21gmW80MqJ+aRtQBMM0Ude2dKtyTa4dUeI4S9i8F?=
 =?us-ascii?Q?8hVz4CTeSy11RCXJ8mLDpOCTXEdoBigZtmpT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PN3P287MB0273.INDP287.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021)(4013099003)(4053099003)(8096899003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fdKUX54/rTkedwhYxHNKev/QPA2CGjGH48X45r4pE7BEY4CUJhOgFx0SyZDF?=
 =?us-ascii?Q?UdO8fblHrX1jR8sNBus15W91ASVlrZWSMLm5c9dfzKJ+JPyTiBEm2TP+UCug?=
 =?us-ascii?Q?UxB7OrDvgh3R+3ucXaXi2Ty/o2wj2f57uGDOr7ms9181/D7kLgCr/5uCg6AY?=
 =?us-ascii?Q?uXzeXUWhLeE2Vp6C6rfVD/zf18rvuQSIcbFILZqerdjfeAzH8Rbv6giHBZ30?=
 =?us-ascii?Q?eSglgHPWBZ4L96zs/Wfg5tM3JxarV0Cc+dDNxtQeXT01O8HYtYCaeivAE6iw?=
 =?us-ascii?Q?049PlcfG6OE+WKJb1ymI2DNPnuD3W8M/Qjncr5zM0++0aAGhZkhu15yVAiSu?=
 =?us-ascii?Q?q/tncc4P/GjnzDEzxfGIEdlDN95gv9482L9ojCFsz9JhTzlRVtU+LOMCb+/8?=
 =?us-ascii?Q?jjyToK36Sbcm+mXXLGNtaa7o/zE8PsVWzIs+9ymOLo8I1Ustou+GxX/XeTvt?=
 =?us-ascii?Q?D0euBCpgHLe3romzqG4bzTT1HdawFnM658EXGq0tUP+33Y5m8Gp30FJlkjFA?=
 =?us-ascii?Q?JBdpNqeLVqUkBGLwIMlj+iXLeKqEjbLVXQPoBwH9YLdtoHLWbNqfG6ZzmhyQ?=
 =?us-ascii?Q?wxFo4ECXWnM1brOqDZq9WJ1JX0JKUz3O/NXXMlmXzZHiRgJdLvyjislJ+P4I?=
 =?us-ascii?Q?c5mQv7txRJbwqOkeXOiVYKFam8bU5Hrf1VI9Fj8RYefimQbvNQD11Ak4MoEn?=
 =?us-ascii?Q?s7EG0LkyUcxBr/QyxrJQDQkNippPEhAh7ajbGnSFCw2hvuiGnPy+T/tmviUq?=
 =?us-ascii?Q?IJn3DgPLXMT/5SyXxn+2h8dMYDqYwnUBb98aHXX7O7CT+nEOL+XVpHxaG51/?=
 =?us-ascii?Q?D4iMbbeVSJydwMv1jvVTCjy8ULlhKdiqlm52t73TV+PdgAdNiL7gi5DifOMW?=
 =?us-ascii?Q?vU4EfZwQStpd09r/pfdt0bqFCrG1V44lJEpa3nTObSy0NYsX/7mDZCJzTzDR?=
 =?us-ascii?Q?x+gFeKSqGx1JOxk6CzAgvY9xh9sYSYr+wtp7Eslsb+zOy7OQyR6zT5xCZF59?=
 =?us-ascii?Q?mz225Vu3h8jPrKA2/jD4PFuvEHnNzzyNqWlm/8DHdLJ4Uy9ZyuMvVc8FSrG7?=
 =?us-ascii?Q?6SBUIe5Lo+mxr8Uz8NmP7312VC1INdhCdsKmxST3n3JYN8z9sQJxQv0S28Lr?=
 =?us-ascii?Q?mWgJSf7yn8kBUtyeHBWU9xsDl/kLqirAmvkfN/zUKhHQ0u0QvJk23jFMt8Nz?=
 =?us-ascii?Q?q1nb70uLCBbNgnufaChrHxu8nqjZ4i+V2/jGLuwCm6hhDEgaz/2tMSU1lUXB?=
 =?us-ascii?Q?Z1F0GJwCGjnYxrvxqw/PYoOirfE8qkLOuFNKjxfIXAz/6o9/T3VpzptgC642?=
 =?us-ascii?Q?NKk131DDarSrplYwOwsRvgnFIcLRkNiM0plzOzq6QePxUm1fedwf7f09uXfc?=
 =?us-ascii?Q?LTal7vjuwT64yePT5siCL+tgLNo/jw16SfkFn62pV46NZXOljdTAY2LGYQ5m?=
 =?us-ascii?Q?5BUSHhfe0Ov9acXM1anMXOip69apkRFIGvPENiWoXD7iq7xb/KJSsMn4ehPs?=
 =?us-ascii?Q?Q0iee+naVWWkcKK1Wz13TNxMm7DnWxdGKP/GVoq/QplyR2xU6grtgSUegO6I?=
 =?us-ascii?Q?ef9Xs33YxVunY7ptmRMEVYKwnJczW1rkdGL3r0WwVaE/6eTvMDXRuzwyOjA/?=
 =?us-ascii?Q?gwA45EUGiPilsVEl9066vT8=3D?=
Content-Type: multipart/related;
 boundary="_004_PN3P287MB02734300BEDDDD5A08219DCCB7CAAPN3P287MB0273INDP_";
 type="multipart/alternative"
MIME-Version: 1.0
X-OriginatorOrg: iwave-global.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB0273.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ce56e195-1b27-44b3-7203-08de23665f16
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 10:12:52.1571 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 507ae903-cc48-4d6e-bdb6-35278120a345
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NXIs3RAiKLZGa/pdDhBsXNzXtrRNxKCSzNb3GjRtWMITOOTilv1QiXWB97hkATY5HkFUXcu6+iT/nYE/45U3hlC5fDNFDYzEbhcTzMh2nKc8RvS1PpL8QzAOdHssEIfm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1061
X-Mailman-Approved-At: Sat, 15 Nov 2025 18:01:36 +0100
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

--_004_PN3P287MB02734300BEDDDD5A08219DCCB7CAAPN3P287MB0273INDP_
Content-Type: multipart/alternative;
	boundary="_000_PN3P287MB02734300BEDDDD5A08219DCCB7CAAPN3P287MB0273INDP_"

--_000_PN3P287MB02734300BEDDDD5A08219DCCB7CAAPN3P287MB0273INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Team,
I have successfully compiled and built DPDK on a Windows system and am usin=
g a custom driver in conjunction with DPDK. I am able to write to the regis=
ters, and the driver can also read from them. Additionally, I have successf=
ully loaded the netuio driver onto my network interfaces (01:00.0 and 01:00=
.1).
However, when running the DPDK application, I encounter the following error=
: "Invalid memory, No probed Ethernet devices." The issue is detailed furth=
er in the screenshot below.

[cid:94365efe-78e5-4ef2-9d9a-b49188e35759]
Could you please assist in identifying the cause of this error and advise o=
n potential steps to resolve it?
Thank you in advance for your support.
Best regards,
Thenveer

________________________________
From: Thomas Monjalon <thomas@monjalon.net>
Sent: Wednesday, November 5, 2025 3:55 PM
To: andremue@linux.microsoft.com <andremue@linux.microsoft.com>; Dmitry Koz=
lyuk <dmitry.kozliuk@gmail.com>
Cc: Thenveer Poolakkanni <thenveer.poolakkanni@iwave-global.com>; dev@dpdk.=
org <dev@dpdk.org>; Chaturbhuja Nath Prabhu <c.prabhu@iwave-global.com>; Ay=
shathul Thuhara <ayshathul.thuhara@iwave-global.com>
Subject: Re: Assistance with DPDK on Windows

05/11/2025 08:36, Dmitry Kozlyuk:
> Hi Thenveer,
>
>
> On 11/5/25 10:18, Thenveer Poolakkanni wrote:
> > 1. Is it possible to execute or use dpdk-devbind.py on Windows to
> > verify the device binding status?
>
> No. Please use Device Manager for now.
>
> > 2. On Windows, the build generates .dll files (e.g.,
> > rte_net_driver.dll) instead of .so files (e.g., librte_net_driver.so
> > in Linux). How can we use or execute these .dll files in the same way
> > we use .so files when running DPDK applications?
> >
> The application must link the needed libraries and PMDs when building.
> These files must be in PATH or in the working directory when running the
> application. Loading additional PMDs with "-d" EAL option is not yet
> implemented. If you have a custom PMD you have to build it as a part of
> DPDK and link to your application.
>
>
> P. S. Questions like these belong to users@dpdk.org. Keeping in dev@ to
> avoid breaking threads.

This question is probably showing a lack of documentation.
Please can we have this gap solved with a patch?



--_000_PN3P287MB02734300BEDDDD5A08219DCCB7CAAPN3P287MB0273INDP_
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
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Hi Team,</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
I have successfully compiled and built DPDK on a Windows system and am usin=
g a custom driver in conjunction with DPDK. I am able to write to the regis=
ters, and the driver can also read from them. Additionally, I have successf=
ully loaded the
<code>netuio</code>&nbsp;driver onto my network interfaces (01:00.0 and 01:=
00.1).</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
However, when running the DPDK application, I encounter the following error=
: <b>&quot;Invalid memory, No probed Ethernet devices.&quot;</b>&nbsp;The i=
ssue is detailed further in the screenshot below.<br>
<br>
<img size=3D"24340" style=3D"width: 526.814px; height: 250px; max-width: 12=
01px;" height=3D"250" width=3D"526" id=3D"image_0" data-outlook-trace=3D"F:=
1|T:1" src=3D"cid:94365efe-78e5-4ef2-9d9a-b49188e35759"></div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Could you please assist in identifying the cause of this error and advise o=
n potential steps to resolve it?</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Thank you in advance for your support.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Best regards,<br>
Thenveer</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Thomas Monjalon &lt;t=
homas@monjalon.net&gt;<br>
<b>Sent:</b> Wednesday, November 5, 2025 3:55 PM<br>
<b>To:</b> andremue@linux.microsoft.com &lt;andremue@linux.microsoft.com&gt=
;; Dmitry Kozlyuk &lt;dmitry.kozliuk@gmail.com&gt;<br>
<b>Cc:</b> Thenveer Poolakkanni &lt;thenveer.poolakkanni@iwave-global.com&g=
t;; dev@dpdk.org &lt;dev@dpdk.org&gt;; Chaturbhuja Nath Prabhu &lt;c.prabhu=
@iwave-global.com&gt;; Ayshathul Thuhara &lt;ayshathul.thuhara@iwave-global=
.com&gt;<br>
<b>Subject:</b> Re: Assistance with DPDK on Windows</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">05/11/2025 08:36, Dmitry Kozlyuk:<br>
&gt; Hi Thenveer,<br>
&gt; <br>
&gt; <br>
&gt; On 11/5/25 10:18, Thenveer Poolakkanni wrote:<br>
&gt; &gt; 1. Is it possible to execute or use dpdk-devbind.py on Windows to=
 <br>
&gt; &gt; verify the device binding status?<br>
&gt; <br>
&gt; No. Please use Device Manager for now.<br>
&gt; <br>
&gt; &gt; 2. On Windows, the build generates .dll files (e.g., <br>
&gt; &gt; rte_net_driver.dll) instead of .so files (e.g., librte_net_driver=
.so <br>
&gt; &gt; in Linux). How can we use or execute these .dll files in the same=
 way <br>
&gt; &gt; we use .so files when running DPDK applications?<br>
&gt; &gt;<br>
&gt; The application must link the needed libraries and PMDs when building.=
 <br>
&gt; These files must be in PATH or in the working directory when running t=
he <br>
&gt; application. Loading additional PMDs with &quot;-d&quot; EAL option is=
 not yet <br>
&gt; implemented. If you have a custom PMD you have to build it as a part o=
f <br>
&gt; DPDK and link to your application.<br>
&gt; <br>
&gt; <br>
&gt; P. S. Questions like these belong to users@dpdk.org. Keeping in dev@ t=
o <br>
&gt; avoid breaking threads.<br>
<br>
This question is probably showing a lack of documentation.<br>
Please can we have this gap solved with a patch?<br>
<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_PN3P287MB02734300BEDDDD5A08219DCCB7CAAPN3P287MB0273INDP_--

--_004_PN3P287MB02734300BEDDDD5A08219DCCB7CAAPN3P287MB0273INDP_
Content-Type: image/png; name="image.png"
Content-Description: image.png
Content-Disposition: inline; filename="image.png"; size=24340;
	creation-date="Fri, 14 Nov 2025 10:03:52 GMT";
	modification-date="Fri, 14 Nov 2025 10:03:52 GMT"
Content-ID: <94365efe-78e5-4ef2-9d9a-b49188e35759>
Content-Transfer-Encoding: base64

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
5DoDKNg/6vXZy/e91+8jl6/N+buMutMH+MrSazgTY6nzEIe69n6HaDqiKVU0wowtHit75Z8IglF8
+I6Vs8JfvSV+Afn1oV82h9dWL0wH0GH/AciG4wPgcyrcpC6DvAYtXu7pYc6xX/GIM6/JxGxO80UQ
6Lb3qTmf+N9IaU0mRWpcVe2uGB9cG+1Gb1qppklH1tTKdOK1s5w+1z7oy9FrI8KyC+dfH8VGrHM4
fb02g2s4wumJsllPP1GehukmefNH5aMtT9t+0fT08jNNZ+vLj5dfXvmr7/L2DxM93bT58srHRl7+
lbztz2LTtd+Yto+y6f5lW75F8i9HfKpaW1uHtP1PW1+tfMruP1H6m+3fZZevxPePKH3Z8pXIT8p3
WfMzfb8tmi8lL30pffvZMu1/AJCueB9OP8jrNDx6vCd6elmkjhlet4fHhQh02/tNWj48+980qLkn
p5WhmlN4tMTVdBDV8mpDZ1bR5OIMgyE5RTpE7vlxrAz5YjDmIRd7PTFWuf8DcVLki8nxnzF15lHe
xDCbf6L5+QI3G7ZoOojGO9drqPlkOaSoBnu0cGl8GY093j4+J3cRr+E+vYtqGUzTTcrOz0zllzXd
pvxYVvnb7B8mpv2nivLJyj8zbf/k9F7BoVXL7F825Vt3/m04wzE1J3L/6o0W5I4vU4KadVXsP8wZ
9mkZHN9i8x7J9Tft31UsnwPC7mN0bhl5TnT8pAxzy61hjdWcHp7k37nz+0zHh4kpfbbp9mOm/Q8A
sqUHnImx1PU7dnEC8R7pjps67h/JaxRvVt+4yWSv6YeWPn+5i84RHTWX4YnsI/H8YEhdZJ9uJutl
uIrGD/ejeloEX6tgf3ITrXRyfjHe+fSCrv+tlyv3ge06K5r+jsYOv/89pZXTjZ9wk38nmaablJzf
VH6Z0y3KT8gq/7dStnwz8m/a/mnTi6hs/8pQd/5t6fuXOAdSi3b1/adm3uhXeHzzTT+1dmVAZbt/
l8ABYbjuvvvHKKDn8/rDfBVWQnAAzK1h3iTYF31581fBJv1Nt5/1/g0Aqaz6cKqDMzyBcPWm7/X1
jh69+B1t7RYv/snLX+7CodbygbYt3gwfqAo/aU06BmIdZZlzGZ/+OJQXGA64V0viOt3IMy1XsoaX
t89ui2fPKBXuA+uH7O54FuZvNnb9b6ITLp+wRa3ILPhNolnLNN2k7PylGMovlFX+b6CS8snKv2n7
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
gg==

--_004_PN3P287MB02734300BEDDDD5A08219DCCB7CAAPN3P287MB0273INDP_--
