Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D64C98310
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 06:53:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D82D42EE5;
	Thu, 24 Sep 2026 08:53:40 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012069.outbound.protection.outlook.com [52.101.66.69])
 by mails.dpdk.org (Postfix) with ESMTP id 4EE1942EE3
 for <dev@dpdk.org>; Thu, 24 Sep 2026 08:53:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJ2bo+u2vgX0Fc3U39910aJZAOphpzWF6nwKzqzvf/cvEg49k8F4fQl1JFk6KaZege8dWVEVTSNZIC3HSyKe8LYzliGuRqsZ3zHUdKE/x4U8/waPv5bsF6lT5i7GPci01dPw7EqKEF3RKN9lGeRp7kSSg+bVI3A33kFOjtPmQz331cBu8BNMJCa62y4UrgP2MMoKd1EUylMsSpIYDpuvr1DrFwghwOJTs/PUV4QmKwvVNp+sZGEtdgeZqbo/6zyjZ2nd9P1zpmTtoxntgkWIIBSufOgl5sCRNF0bW+rANtdFq52LMETGdOyI3KqZjiqW8Sy/rie/DyVwNUCJeJwKIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFpcVTN6fkDGSQJFaEUOhFM/Ptr6ZjIkrkWvTM80LVI=;
 b=UyztQSIQBLbt0x4+HweIwngD0hCIZ6wXccQDswoUXUNDj4312E5UAabHlgrf0K5ewTf4M0+wkDmcqlYj6xZt/xNqstny2ovgwhiFBJRqxYlaMXYW2kFdbhG/Aslkv3MH3/qlwiWpAWaJuG2nEyfqZLAIwKvuhheMoIM/Lj6dP+0k81l7yuw3cnFpT/272rx82DLY9mB3mPfBU4Pt+xhFgD1MmDmxFwNnTDHLVbin5vBxYGXTB4PUdGnjVEVGWR6rCNOKjNrng6+aYxHnIgw9uvQOszvSlWnA5vPxrgMwhz/dNmvE3oFaJSUgKs0LSzd8KcLRbLEYHn0YXQcEoedVMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFpcVTN6fkDGSQJFaEUOhFM/Ptr6ZjIkrkWvTM80LVI=;
 b=arNBlorHG2kOWUIO59Rj/I5iYCeaIPOU9NPErB9+sNFxco0UCUUe/IpU/EPdCKJKFFPNslgwb0Ib9ooMUr7p8ob6ggZ2GNQ69VgS1ed31C9zukmbbiXX0UrJpk+jlddwN+tmtK1pg60YOnWujdP9eGUgEQ5PRBRT+svgCZddOG7FvN+4VWKGUdhSZK0NgB5YdmdnaWMTcG6/mOVt+9u0vWNi+FRvACBVEHjTUOc8yoZNDCN0eU5HxLRw7jBcGbyYa2iEkZvnW5XmkHYLvgxJoWNFOvMH4GHXGrKiWf/GiKPKZLz9+t08cHW5TRRVmPy12qRuDcK0VId7YYsmVYScgw==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by PAXPR04MB9155.eurprd04.prod.outlook.com
 (2603:10a6:102:22e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 06:53:37 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 06:53:37 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: David Marchand <david.marchand@redhat.com>, Prashant Gupta
 <prashant.gupta_3@nxp.com>
CC: dev <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [RFC v2 00/16] Device unplug and bus cleanup refactoring for NXP
Thread-Topic: [RFC v2 00/16] Device unplug and bus cleanup refactoring for NXP
Thread-Index: AQHdRnkV4h4BGBSaLU+wNQggEE8r4rbdVAsAgAABvWg=
Date: Thu, 24 Sep 2026 06:53:37 +0000
Message-ID: <GV1PR04MB107503D0622CCC88D2F5B62A389812@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20260917074917.595603-1-david.marchand@redhat.com>
 <CAJFAV8z4mrPq5CPKOeBE1nS1-_Bkxkfy6_EziBYb4Uo+mj-dyg@mail.gmail.com>
In-Reply-To: <CAJFAV8z4mrPq5CPKOeBE1nS1-_Bkxkfy6_EziBYb4Uo+mj-dyg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: prashant.gupta_3@nxp.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-09-24T06:53:35.484Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=1;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|PAXPR04MB9155:EE_
x-ms-office365-filtering-correlation-id: e0e1425b-baca-40df-0e89-08df1a088f34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|23010399003|376014|4143699003|10067099003|56012099006|11063799006|8096899003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: SDDnl3iSFsyXUpSSi0D1NDB+675xRrZTO2LBZ2/Vv4CH8nXtNKzkqu/c1PtYFyhfLmgWA5VY7Uf98XTt2BsMk/UwoXftFTlu42FhbqXkQHtX09Ml39e2OtnW4N9LO5DujtVyrKlh3H4znEUAxrHi8WnhBnUXGvdfLAYlhn9FtpM2KojLWF0gn+xBvwELgMPygUumX+/tzrg51WguZS78io6qwAmk7xhF9HdoDKbBfWnqq3D3gjwMs6QKBLqj3GCeVgV3CQZOdWXsJgzylL9I9K4j18MVV1YlCSLDaEMYeeh25uRonLwfVdExeJkQy9MeORwRecWmLUEjCMvz6W/h0BW2tJQ5cFfVY/AjUFJGXtEYfUIJdrfw4uG2rQEOLnR8sVK3/ibtAznIRPiDjQokBESDWcqUw9PDBA93V8l4koLar8TGi7yLVYgyIM9G15/CLw43LFJ14Ku6q9UYxe9sRGV2NxyGzX1ZkiGqA3nPhwV+/IcYGka0Wl9NxihhD6s12JT/BignrKHoOMAZtt9VoZwEYlNCD/9kWWjmYQB7DSZt3hWVWdDVLl138BCBBYyDL11hKlNfeQpHk0JXxbbJIpxSKCk6BEVuDRAnw4sW7pwrFzSjCxDlwqkHsvqAEy0VPy5vv++FxbY45BN8mj3GY5aH4AHZ38UOVx450z0irp6C70tEgkvrstmRY0oVPpbwYinsn1iKtc9eihDFQ1owPZ5iT6qANTnmtW+57ZInGAU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(23010399003)(376014)(4143699003)(10067099003)(56012099006)(11063799006)(8096899003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZRYj8a94CdB3XzS2FSQo0iXbsO1czxsGYkTZmfPBtgw2qzY/+45rldbBu2?=
 =?iso-8859-1?Q?4cAYGeDHTIbPuPjw3hYyD2QdHqSuvsOdMpkuPsVG9BES9oVJyu8KtGmToS?=
 =?iso-8859-1?Q?2skVITWgfr+0/bUxjd3ALMbc8Bq+CDP7cbZPXxcR8WgR8tFIZD9smxOnGe?=
 =?iso-8859-1?Q?tS0Pu3i7LnOMdjts7IgxsuUe78bzirHIdA0SZczT1jvVyVhQii0v1NSLye?=
 =?iso-8859-1?Q?vvIVEcCBQ2NxzvubPJNg6/w/lJbHv0CnIGibOmNdM2GOWW4h4lLkyot6Uy?=
 =?iso-8859-1?Q?xrvQWzK+on/TKgsacdoPjh9KC92iYfv4LzU2zSTSV7f1oc17sGbMkSEKRH?=
 =?iso-8859-1?Q?nNqhzHop/XoUlfy7S86LX7XIX676xYEZVd2bB1fsW1uKzP0lmLecqMeAVU?=
 =?iso-8859-1?Q?0P8rJPUv8TQe5B4ALv1JbC6y0cRd2S/zqCJ9vcHgCSg5Ts7OUgVn34JVhN?=
 =?iso-8859-1?Q?Zl25OoGFkAC5pey0vE3nyqKdm46xIh4bmzgF74/ivjRa/uGjddeDHWjHaP?=
 =?iso-8859-1?Q?JeP1coxftVmT3bZi3/VwwxcFIUvn8OdFqurtzTBlPv2SUoF8C/pxduIgji?=
 =?iso-8859-1?Q?lRC/kXm5FMMhpiWs9fAOYNAgO2NDaHb99wR6kt2cXGX1Pyx+Iz5iR3fmZp?=
 =?iso-8859-1?Q?vSzmgdxXcdPuFfm11joBktysHbm+qhgabDx0SCAcpkNEjrZydCAGScIpew?=
 =?iso-8859-1?Q?8432ULj7YWGzlDz7MlhJJ+/6FnDx8YVuFQR+8lfCvc97Refjo+F4eYAy06?=
 =?iso-8859-1?Q?2teGVFnh1bng8RvnF+Pj10lqog9lmQ64lVrz0a6iUdv8R9eoLftn0zMl+b?=
 =?iso-8859-1?Q?bqCD4hSSPZhhWfSDVVz/qj61q50zkALQP+taj8cd59sByWLyraD5CBzUNp?=
 =?iso-8859-1?Q?cl1ZbA7b2ANlzK4fwXPfsatQGl4dCxDK6IDazYBvkrTQF1OuXolNq6+hEm?=
 =?iso-8859-1?Q?52z78uX/BCB0Xwp8uTqB5fuqhBagmTNQY97dZ/y9Amwg0f/bVU/Qs+rlgs?=
 =?iso-8859-1?Q?yICGCCEX9JIVz2ZM94vNxkn77WjsfvzGTh678Nwk9CtfFcR06Z9U3TKQgo?=
 =?iso-8859-1?Q?388Ch9mOlsqNRC3QVjWD0cigft6h2FS6y5d3ywR5E4Kwz7YM53sWb9GGct?=
 =?iso-8859-1?Q?o2ZeRy26qpVRZxqbsBTW+djLd/enviBKH6zgdYRKsrmyUGUBFnGNB0KYra?=
 =?iso-8859-1?Q?6SE6/qBTbtgtF7m0Uo2jc5BAni6DmeuQI2iXaZ2wjkap3J/iFunKpEAm6f?=
 =?iso-8859-1?Q?cxHHa+TZnyzXmk9j+LjSYohZY3EgRMwZGHS9y2pyGBEqYVtEhTL+nqffag?=
 =?iso-8859-1?Q?FKYzkkC1oXDfr5YP0QGsrBjkZwSm7XL8WpdZ39OjWI8TpIu0UTvsP+dhsT?=
 =?iso-8859-1?Q?cDVogkIq3DuWLTBGCl1DvLZgcxf6TgID/64Cg2qiUKeoGLmZ3gXEveLcFG?=
 =?iso-8859-1?Q?MMwG8Qd10boqJETU68rUP0HNxOSe/DEkzoKiOD6cpkBfZtnvbC79FVg/MW?=
 =?iso-8859-1?Q?kzDKzScGn94lHetJRW/emyWIqdzPLr5uac27ZgCH9Ln7NrwBv1HjuviTbk?=
 =?iso-8859-1?Q?swIpEjpF91BxCWhUHJT6498W3xXf/Sch5Bd7LoeVprtbMcXDd/F9KEwZ++?=
 =?iso-8859-1?Q?g+CDLfxPg9wzD1/zcZLKysVcQGr1KqXP2IKjwlglHLjiOhaHtWGsj8kuek?=
 =?iso-8859-1?Q?jBj/av3sVNNx/lFl7XMkkPJHwMC1j1qnB+wvRckbknDc1L/bpw1l2z4Txx?=
 =?iso-8859-1?Q?2OrD3ufYjHN1ibJSzEo+AeDlCr/NIrE2Dvz4++d2Kk9BCGZ2fwGlS8HdFE?=
 =?iso-8859-1?Q?/ZcIOJ3SSQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_GV1PR04MB107503D0622CCC88D2F5B62A389812GV1PR04MB10750eu_"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e1425b-baca-40df-0e89-08df1a088f34
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 06:53:37.4191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0S0bL3pGZx1CtcXFmnAUPHtqPMI51oxQLnjGaSBMjX47RjJFPNAns2wGAhSiUd0pw2WvTWlm5fK3wyLiwikFUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9155
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

--_000_GV1PR04MB107503D0622CCC88D2F5B62A389812GV1PR04MB10750eu_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




________________________________
From: David Marchand <david.marchand@redhat.com>
Sent: Thursday, September 24, 2026 9:46 AM
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: dev <dev@dpdk.org>; Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [RFC v2 00/16] Device unplug and bus cleanup refactoring for N=
XP

Hello Hemant,

On Thu, 17 Sept 2026 at 09:49, David Marchand <david.marchand@redhat.com> w=
rote:
> This is a followup to the refactoring started in 26.07.
>
> I took some time with my best AI friend to cleanup DPAA and FSLMC bus
> drivers.
>
> Like the last time, only compilation has been checked.
> I have no hardware to test runtime.
>
> One thing that could be broken is either the order of devices
> initialisation, or bugs in the device filtering that I tried to
> simplify.
>
> I went with the approach of splitting the device list between
> internal bus object (that I called "control" devices, maybe a better
> name can be found), and normal bus device object for which DPDK has a
> driver.
>
> I think it is worth testing and fixing, as it will make the two NXP
> bus drivers similar to other bus drivers (but keep the special IO devices
> handling internal to the FSLMC bus for example).

Could I get a round of tests? Or should I just sent a non RFC series?

I see potential conflicts with other series coming from NXP.
I think it is worth getting this cleanup in, to limit the number of
special cases for those two bus drivers when compared to other buses.

++ @Prashant Gupta<mailto:prashant.gupta_3@nxp.com>
Please confirm your test report on this updated series.

--
David Marchand


NXP Confidential

--_000_GV1PR04MB107503D0622CCC88D2F5B62A389812GV1PR04MB10750eu_
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
<br>
</div>
<div id=3D"appendonsend"></div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> David Marchand &lt;david.marchand@redhat.com&gt;<br>
<b>Sent:</b> Thursday, September 24, 2026 9:46 AM<br>
<b>To:</b> Hemant Agrawal &lt;hemant.agrawal@nxp.com&gt;<br>
<b>Cc:</b> dev &lt;dev@dpdk.org&gt;; Thomas Monjalon &lt;thomas@monjalon.ne=
t&gt;<br>
<b>Subject:</b> Re: [RFC v2 00/16] Device unplug and bus cleanup refactorin=
g for NXP
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">Hello Hemant,<br>
<br>
On Thu, 17 Sept 2026 at 09:49, David Marchand &lt;david.marchand@redhat.com=
&gt; wrote:<br>
&gt; This is a followup to the refactoring started in 26.07.<br>
&gt;<br>
&gt; I took some time with my best AI friend to cleanup DPAA and FSLMC bus<=
br>
&gt; drivers.<br>
&gt;<br>
&gt; Like the last time, only compilation has been checked.<br>
&gt; I have no hardware to test runtime.<br>
&gt;<br>
&gt; One thing that could be broken is either the order of devices<br>
&gt; initialisation, or bugs in the device filtering that I tried to<br>
&gt; simplify.<br>
&gt;<br>
&gt; I went with the approach of splitting the device list between<br>
&gt; internal bus object (that I called &quot;control&quot; devices, maybe =
a better<br>
&gt; name can be found), and normal bus device object for which DPDK has a<=
br>
&gt; driver.<br>
&gt;<br>
&gt; I think it is worth testing and fixing, as it will make the two NXP<br=
>
&gt; bus drivers similar to other bus drivers (but keep the special IO devi=
ces<br>
&gt; handling internal to the FSLMC bus for example).<br>
<br>
Could I get a round of tests? Or should I just sent a non RFC series?<br>
<br>
I see potential conflicts with other series coming from NXP.<br>
I think it is worth getting this cleanup in, to limit the number of<br>
special cases for those two bus drivers when compared to other buses.<br>
<br>
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">++
<a href=3D"mailto:prashant.gupta_3@nxp.com" id=3D"OWAAM226322" class=3D"tWK=
Ou mention ms-bgc-nlr ms-fcl-b">
@Prashant Gupta</a>&nbsp;</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Please confirm your test report on this updated series.</div>
<div style=3D"font-size: 11pt;"><br>
--<br>
David Marchand<br>
<br>
</div>
<div><br>
<div style=3D"font-family: Calibri; text-align: center; color: rgb(0, 0, 0)=
; margin-left: 5pt; font-size: 10pt;">
NXP Confidential</div>
</div>
</body>
</html>

--_000_GV1PR04MB107503D0622CCC88D2F5B62A389812GV1PR04MB10750eu_--
