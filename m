Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B513C021B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 08:09:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D166427D7;
	Tue, 25 Feb 2025 09:09:27 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
 by mails.dpdk.org (Postfix) with ESMTP id C292640041
 for <dev@dpdk.org>; Thu, 20 Feb 2025 13:11:10 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pU94/CrmOzAkxdeedWWEdnguYMzRQZsBIMbp1mbe3MqgmKjr2TkpRN7oVvXAyYIC6CyDJTUoRrbMrX3hjvUBD/kbxinOkZMoKwr7Zp9MC7ZwpC+3X0I1NbCyFSCuC0xuO52oh22X7ss2O3B0RbOCUY6HQcRreoHciZUZH8al6N5ZGYH787U6CDKULcd4qMYcrPptX5cZXOwvQC1F9P3f1+pOyAXx2zEhmTGU2jBvvdB1LSPMRtQkHDEh0eMEBJdobmUgQZ3QsVReZMNTmiQ+7X9lgosEs4R2B9ZKwXiu6Mv8m7B3iCRS7ZQySn4HKV7DD6Rqiun3n0TnweGipMCsyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKkX5l/XjKcsJQKBblI8LnOl+DyyxLUflycc3xmJMkE=;
 b=xtQxsj1piIYxSoKIqdf357GnGP/EWAjRobTAtqG7H7l8J6ZvOdKanM70JhiW4hdMOE7t2wS0OxiV+k3hszE0X39IrLTRMFO8NN7RD1sZ2fAVoeQbJPSuONeJtDXmS0FnwfoUuihvxXaWVR9xRnvkgSuxLvQDdKTD+v3bQsIzYd4XipR1wNSh5A2/78l2Ra4ocsfA4p4lK2V9cXKf0JifqZKNnqvSvwMIrKcujNqQBteqPAW0uTMDXBewMUiW8GR5VDHhDeDCJUHDwl3cll8Seu9sy95KqOuwhIgj0qzTI3IHrHINGFpReLtG+bQMrcpTrmq3dr8sR+2tC6dwf1VzTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKkX5l/XjKcsJQKBblI8LnOl+DyyxLUflycc3xmJMkE=;
 b=j34NuWkbsIJ58ptnXPghC6BTRh0uDxdUF5N/fLWTCmvLi9MjlZ1iJLp6RM3dJDqDaj9up5a9A59kmGlh0PLI7tovU4Je4Qs7T0zdlEZ96uiqO8jR1EJV2bMw/ME3Rdvf1gViGTsy9FPd3xQVd5Mc9nZML2vz7QlJlbGnfaT8LOr9BKIZzQstM+skVcvLK6DTn7LGRrotQsLJQQhDf6NJxaZVdCpyzvbGPby+KQ7Z+SjsgK58VuG3Cevzpf0ZiqurYv0NyxEc3zv+8b8Jvsf+UQ32b9iE+sGt+vbo+4DTvCKdUadgaRtSlmQXI+RgFTehq0ATwHOaJyxfsUap/hpPpw==
Received: from VI1PR07MB5582.eurprd07.prod.outlook.com (2603:10a6:803:ba::14)
 by DBAPR07MB6904.eurprd07.prod.outlook.com (2603:10a6:10:19a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 12:11:09 +0000
Received: from VI1PR07MB5582.eurprd07.prod.outlook.com
 ([fe80::8ea1:7d68:4bad:9505]) by VI1PR07MB5582.eurprd07.prod.outlook.com
 ([fe80::8ea1:7d68:4bad:9505%4]) with mapi id 15.20.8445.019; Thu, 20 Feb 2025
 12:11:08 +0000
From: Pawel Nicinski <pawel.nicinski@ericsson.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Kamila Swarbula <kamila.swarbula@ericsson.com>, EUIR CSI ISP RT TEAM CODE
 DIGGERS Sub-contractors <PDLOLTEAMC@pdl.internal.ericsson.com>
Subject: Bug report for dpdk-stable-22.11.2
Thread-Topic: Bug report for dpdk-stable-22.11.2
Thread-Index: AQHbg44SGj4Tan/uZUKI5taZHyoBNw==
Date: Thu, 20 Feb 2025 12:11:08 +0000
Message-ID: <VI1PR07MB558269DB5FBD221349168695FAC42@VI1PR07MB5582.eurprd07.prod.outlook.com>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR07MB5582:EE_|DBAPR07MB6904:EE_
x-ms-office365-filtering-correlation-id: 6f2eeb21-f27b-43d4-2740-08dd51a7a8ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|4053099003|13003099007|38070700018;
x-microsoft-antispam-message-info: =?windows-1250?Q?MB8tRAzK6zno1chi/+9tX9PhfAK06s31KfUX9S1wQD1uT/ZhUgde08hM?=
 =?windows-1250?Q?cS9r2UBGbMBPmD3S+CzFeZ3qSniqk5Vjfx3BPPgG4s5lVBc+HmRrjh6E?=
 =?windows-1250?Q?HDSoTbVfd/BmKLdxM6VlE4vHKbYvadwD6c4aWbDAN1xzFeaB5gJsaTCE?=
 =?windows-1250?Q?jN4w25IGnPxt3k2WyRsvRp64TvKwvj9QJw68kHN0pSnDbawaBm1mwKbf?=
 =?windows-1250?Q?YyHkxgWmwhT9QsnRfcuLz7oIvBDCKR+EzjK6JZEV2XCdsU8mI6slRAyV?=
 =?windows-1250?Q?UqLWwxQRVh6Lv0B3WhRMNS3S4Wcg/B1JhDYuyQIT1RoUe9EGgQz5x/yi?=
 =?windows-1250?Q?fZB///OYzJWvjEcRIQUJ81/1uPR5VaQ/5TfGf1z3zTYSesxxAvvVN3eY?=
 =?windows-1250?Q?uMNnqWmxa7y2HQSGWn8KT1MfFR8BVnctYPX7lvITD+8tuHPrWwHYn9tk?=
 =?windows-1250?Q?aEBJRFDW2dua8BwXqs4YQ31wNGwQ1aWjaWDTcsr5adF9xKqz5cDtq+YK?=
 =?windows-1250?Q?XR5uPAhoIg5dH6hvMIplK52PBybSAw0mNur6QxycNvOSRc76zfZgIWa7?=
 =?windows-1250?Q?4nEYdMcfU9/4ZOPUns3Nnxcp5vgsgmzxVaM3/lmAXTbgYqeREzyYx5Bw?=
 =?windows-1250?Q?mF0qFHCJuHO0v7xfhkFAvod1RFBQ5udoErftbuTWlHKlAXtOKnz5y2Eh?=
 =?windows-1250?Q?C3Z+XK1f9v5oSnvA1OEu34RtmZ/pQf0Gu+x/U1RxXtHHsHsOa5qUz5q+?=
 =?windows-1250?Q?Iky58gssUcE9tS/5cOvgA2/9x74DcYhpYdhrpsDodecoXwkehyB9lvtN?=
 =?windows-1250?Q?TGv7CaN26ccRaMbnzJ35wNG9DELWia9+ZczHeT2OatRuYIWLT2SBzfVj?=
 =?windows-1250?Q?BridO5GTVVwIP86YnMEGsZLZYK4flkFX+VaDGeKKtt2tKwZ4peepO7Ly?=
 =?windows-1250?Q?swuK42SlBWlccuj2yXDeiBJuaMwbjHykCio6r1ANKUn1R8QrFSR+RF89?=
 =?windows-1250?Q?i5SgAqSwHVifheNhEBBhgwS1gX73HmUhefnmGooHTUVhi8db6fPv+Qfb?=
 =?windows-1250?Q?LnY8cr6XyHTv1yhS/HKsgqqQYyRmTp4Ylx4Gdyj4Jwy8DVi2hMQWfTT3?=
 =?windows-1250?Q?/AL4oJShwNvdEBgswOZH2dvYSaxdXoy1YLQdgvAeiEAEdXt4ZmTaldHI?=
 =?windows-1250?Q?eK41rGRnuglEDerh8/mjavCtKK/FQXdJ2I05fmMuYfx1d7pt+/7biM+x?=
 =?windows-1250?Q?kbkO4K+eroOHwji0a7Y1RRSApo5hMzZ8cHWgUcz78EtWGoEfyjXd6K2E?=
 =?windows-1250?Q?tWlU63N42izCMp+BK0rU/8wpfThU2dYoA5wpmhB+eZbIwjtNf0Q2+x4m?=
 =?windows-1250?Q?xPe+eTgRMk3AxWnSRLYVafbKiK4Frr6+nS4Q2fFqttfrSbVkhXlzaOvV?=
 =?windows-1250?Q?b4UWCTNAcdIzSaQXOFRddNKPeJ1Gdw5X5IcyucTd8Nm+ziU/1Kd7KFlc?=
 =?windows-1250?Q?cr49JgQZl22ta9VGtAgyYC+SGZUrCw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB5582.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(4053099003)(13003099007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?windows-1250?Q?HcLclujkrcZ5Q2Siy+lMAjADDLE/j6jRHwgK2ZikfjBBi27JPxv+U1hQ?=
 =?windows-1250?Q?eHNBT6g36iuihJC4RPGRbPYOXV/Egi9ji5pTEZTwUYFgehAdT5w6WyrY?=
 =?windows-1250?Q?tD1/tVEjUXhmkEsizbxeYLnLgYcvhA2HyYsb18Lyx8SW/xk8HPx/KkeX?=
 =?windows-1250?Q?4PAAumdL11unQI6c5nPIQ1NfiSsNbNF7/HtVvm6nartfC00Ek4+DWKo4?=
 =?windows-1250?Q?jGF9efj0jnLCl1KfC8bEibHlw6m5CcEqAUAQ1tR6euBBlwaSX8Yn0MRn?=
 =?windows-1250?Q?DS0kNxtqg+Qjm0yT75pt1UNuEYAKuX224JAFZ4aTnTS39QvsupcYLrMX?=
 =?windows-1250?Q?+yh97L+3SRlwPcXN5saJrrZ3ic4ucQHHGRPbcBDcs5MagmmqxPHCLNb4?=
 =?windows-1250?Q?thdL9lB7F9a8DJ15y4WAV5uXpXwcfYefwGgo6RyM2RpLhy4tGWw1COnR?=
 =?windows-1250?Q?ZwWtixS0rg67BlRu/dZnMoxf8HvatdoP2Utula01KXJw1KxasgSNLpqk?=
 =?windows-1250?Q?6n2LnJUTDimnM1O6s+CpT1eZn4dWhfe232hYaXejsTVL1Yap7iionifc?=
 =?windows-1250?Q?lEtjkJwPTIWwRoPkbMwOsZ+FJZeSLX5hZWs0ZMMePrHpVY15zEHAIioE?=
 =?windows-1250?Q?gVSoW64l7amVEAcPMyBI2Jd0vtr21m8XA71mhFtowDwOKdqc+lEKQ3Gh?=
 =?windows-1250?Q?Ph6CXRLekie6webQsZyNGiUHJ53lWYlWhbwNYqy8B/eseoQNCgF/C5oL?=
 =?windows-1250?Q?U//J6I3J8iNpvxymjIVpcZ3i0pOv4s3oVp09NmXMlvSi9+2z5J9X72S3?=
 =?windows-1250?Q?uZbmr6BpfX9BXDady3i2uujE3N8gnE74BxgfoWRyQGk/wJl/s57E3Cvc?=
 =?windows-1250?Q?/Z3Qxik3/dpTH9VR5bh/AvDF0QMtwjDhvPMtvNx8EuW+u13YajJI4FZX?=
 =?windows-1250?Q?oL11BEzLC5NF+jRcVxbmQrrDyFzY8QoQ2T1RXMHqUx5o5RZByBYSEqIL?=
 =?windows-1250?Q?cpPNll/lQQe/TUGpEVeCIWNyISl/poDToyL3O3JzYV/R3+56Vw2DiZcs?=
 =?windows-1250?Q?AXo2WfLE1qoBaNm5vu0X7TKA5FD0HRNFynnf9v9aPdUd7w2BcNqQdgHa?=
 =?windows-1250?Q?flLlReOOgZdJWmen2qNBFrT5f5q+5vItatfTo7wYhjZaxZJJ/X+13guh?=
 =?windows-1250?Q?qp4/SmDCHp3Jvv8AOU1W20MgbR0KanClqy4Q6mpa8RxoVWnerqJoAmvj?=
 =?windows-1250?Q?5HacmOrOLZO7u9AmvE7rPTHI9FZsLQRY2BzWSLwgIdJkKsV2iEGey120?=
 =?windows-1250?Q?YHGZLJqzMlTv36s8wddDZ+6BXfWl73tTB4ONwMVhxxJ/In+7d+dRasPb?=
 =?windows-1250?Q?rYG6YjAEY435jhW2KaDpvGvkisjsYkol3pdZFUUlB1HbjLeXLceA0ldk?=
 =?windows-1250?Q?0H+rJBVc+tZfqoOuEvo2BIMGjzyzFpDArCRZAIQu98MyT1BWA+fH7QCj?=
 =?windows-1250?Q?E4kADgb/jGXlrgs5v4A5hG1k/jDlGd0AQSkMp7r4zRPqTEpcKuaM9kbK?=
 =?windows-1250?Q?M5+yL8HA7IzlOGvYTSAItMEF18qD52+/6JeKsAn3cV+2ydXqrqFU4VXI?=
 =?windows-1250?Q?oHZEtpMiZuO//DHeMN3jPOZiT9A2lYjLZz7fgSpdxFh1Nt6FqGnMID3p?=
 =?windows-1250?Q?7gkua3mH8JUZtMzS8Bd+KOZ+yB7+AW5Y?=
Content-Type: multipart/mixed;
 boundary="_004_VI1PR07MB558269DB5FBD221349168695FAC42VI1PR07MB5582eurp_"
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB5582.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2eeb21-f27b-43d4-2740-08dd51a7a8ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 12:11:08.7765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PwB86bAF3bbvU1iDyzEBMmusnxtRebtadZFBUfzJnPULGtWqq+xeht67WYgVXMePVA1UwybF4m9lDQDSyT4VS/jMCEC9V5LFdPg25AdqEQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6904
X-Mailman-Approved-At: Tue, 25 Feb 2025 09:09:26 +0100
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

--_004_VI1PR07MB558269DB5FBD221349168695FAC42VI1PR07MB5582eurp_
Content-Type: multipart/alternative;
	boundary="_000_VI1PR07MB558269DB5FBD221349168695FAC42VI1PR07MB5582eurp_"

--_000_VI1PR07MB558269DB5FBD221349168695FAC42VI1PR07MB5582eurp_
Content-Type: text/plain; charset="windows-1250"
Content-Transfer-Encoding: quoted-printable

Hello there,



I hope you=92re having a great day.



Using the github.com/Ericsson/codechecker<https://github.com/Ericsson/codec=
hecker> tool, we conducted a static analysis of your software. We detected =
some potentially critical vulnerabilities related to different areas.



Please check the attached csv file and make corrections.



Best regards,

Ericsson Team



--_000_VI1PR07MB558269DB5FBD221349168695FAC42VI1PR07MB5582eurp_
Content-Type: text/html; charset="windows-1250"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dwindows-1=
250">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; ba=
ckground-color: rgb(255, 255, 255); margin: 0in;">
<span style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: blac=
k;">Hello there,</span></p>
<p class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; ba=
ckground-color: rgb(255, 255, 255); margin: 0in;">
<span style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: blac=
k;">&nbsp;</span></p>
<p class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; ba=
ckground-color: rgb(255, 255, 255); margin: 0in;">
<span style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: blac=
k;">I hope you=92re having a great day.</span></p>
<p class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; ba=
ckground-color: rgb(255, 255, 255); margin: 0in;">
<span style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: blac=
k;">&nbsp;</span></p>
<p class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; ba=
ckground-color: rgb(255, 255, 255); margin: 0in;">
<span style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: blac=
k;">Using the
</span><span style=3D"font-family: Aptos, sans-serif; font-size: 12pt; colo=
r: rgb(70, 120, 134); background-color: white;"><u><a href=3D"https://githu=
b.com/Ericsson/codechecker" target=3D"_blank" id=3D"OWA008dfcf5-319f-3172-6=
446-b706a768f6d2" class=3D"OWAAutoLink" title=3D"Oryginalny adres URL: http=
s://github.com/Ericsson/codechecker. Kliknij lub naci=9Cnij, je=9Cli ufasz =
temu linkowi." rel=3D"noopener noreferrer" originalsrc=3D"https://github.co=
m/Ericsson/codechecker" data-auth=3D"NotApplicable" data-linkindex=3D"0" st=
yle=3D"color: rgb(70, 120, 134); margin: 0px;">github.com/Ericsson/codechec=
ker</a></u></span><span style=3D"font-family: Aptos, sans-serif; font-size:=
 12pt; color: black; background-color: white;">&nbsp;</span><span style=3D"=
font-family: Aptos, sans-serif; font-size: 12pt; color: black;">tool,
 we conducted a static analysis of your software. We detected some potentia=
lly critical vulnerabilities related to different areas.</span></p>
<p class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; ba=
ckground-color: rgb(255, 255, 255); margin: 0in;">
<span style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: blac=
k;">&nbsp;</span></p>
<p class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; ba=
ckground-color: rgb(255, 255, 255); margin: 0in;">
<span style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: blac=
k;">Please check the attached csv file&nbsp;and make corrections.</span></p=
>
<p class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; ba=
ckground-color: rgb(255, 255, 255); margin: 0in;">
<span style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: blac=
k;">&nbsp;</span></p>
<p class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; ba=
ckground-color: rgb(255, 255, 255); margin: 0in;">
<span style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: blac=
k;">Best regards,</span></p>
<p class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; ba=
ckground-color: rgb(255, 255, 255); margin: 0in;">
<span style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: blac=
k;">Ericsson Team</span></p>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_VI1PR07MB558269DB5FBD221349168695FAC42VI1PR07MB5582eurp_--

--_004_VI1PR07MB558269DB5FBD221349168695FAC42VI1PR07MB5582eurp_
Content-Type: text/csv; name="dpdk_cc.csv"
Content-Description: dpdk_cc.csv
Content-Disposition: attachment; filename="dpdk_cc.csv"; size=6278;
	creation-date="Thu, 20 Feb 2025 11:58:42 GMT";
	modification-date="Thu, 20 Feb 2025 12:11:08 GMT"
Content-Transfer-Encoding: base64

ZmlsZS1wYXRoLGxpbmUsbWVzc2FnZSwNCmRwZGstc3RhYmxlLTIyLjExLjIvbGliL2VhbC9saW51
eC9lYWxfbWVtYWxsb2MuYywxNjQzLEFycmF5IGlzIGluZGV4ZWQgd2l0aCBhIG5lZ2F0aXZlIHZh
bHVlLiBQb3NzaWJsZSBpbnRlZ2VyIG92ZXJmbG93LA0KZHBkay1zdGFibGUtMjIuMTEuMi9saWIv
ZWFsL2xpbnV4L2VhbF9tZW1hbGxvYy5jLDE3MTEsQXJyYXkgaXMgaW5kZXhlZCB3aXRoIGEgbmVn
YXRpdmUgdmFsdWUuIFBvc3NpYmxlIGludGVnZXIgb3ZlcmZsb3csDQpkcGRrLXN0YWJsZS0yMi4x
MS4yL2xpYi9hY2wvYWNsX2JsZC5jLDkwOCxBcnJheSBpcyBpbmRleGVkIHdpdGggYSBuZWdhdGl2
ZSB2YWx1ZS4gUG9zc2libGUgaW50ZWdlciBvdmVyZmxvdywNCmRwZGstc3RhYmxlLTIyLjExLjIv
bGliL2FjbC9hY2xfYmxkLmMsOTA4LE91dCBvZiBib3VuZCBhY2Nlc3MgdG8gbWVtb3J5IHByZWNl
ZGluZyB0aGUgZmllbGQgJ3ZhbHVlJywNCmRwZGstc3RhYmxlLTIyLjExLjIvbGliL2VhbC9jb21t
b24vZWFsX2NvbW1vbl9pbnRlcnJ1cHRzLmMsMzQxLEFycmF5IGlzIGluZGV4ZWQgd2l0aCBhIG5l
Z2F0aXZlIHZhbHVlLiBQb3NzaWJsZSBpbnRlZ2VyIG92ZXJmbG93LA0KZHBkay1zdGFibGUtMjIu
MTEuMi9saWIvZWFsL2NvbW1vbi9lYWxfY29tbW9uX2ludGVycnVwdHMuYywzNzcsQXJyYXkgaXMg
aW5kZXhlZCB3aXRoIGEgbmVnYXRpdmUgdmFsdWUuIFBvc3NpYmxlIGludGVnZXIgb3ZlcmZsb3cs
DQpkcGRrLXN0YWJsZS0yMi4xMS4yL2xpYi9lYWwvY29tbW9uL2VhbF9jb21tb25faW50ZXJydXB0
cy5jLDM0MSxBcnJheSBpcyBpbmRleGVkIHdpdGggYSBuZWdhdGl2ZSB2YWx1ZS4gUG9zc2libGUg
aW50ZWdlciBvdmVyZmxvdywNCmRwZGstc3RhYmxlLTIyLjExLjIvbGliL2VhbC9jb21tb24vZWFs
X2NvbW1vbl9pbnRlcnJ1cHRzLmMsMzc3LEFycmF5IGlzIGluZGV4ZWQgd2l0aCBhIG5lZ2F0aXZl
IHZhbHVlLiBQb3NzaWJsZSBpbnRlZ2VyIG92ZXJmbG93LA0KZHBkay1zdGFibGUtMjIuMTEuMi9s
aWIvY2ZnZmlsZS9ydGVfY2ZnZmlsZS5jLDE5NSxBY2Nlc3Mgb3V0LW9mLWJvdW5kIGFycmF5IGVs
ZW1lbnQgKGJ1ZmZlciBvdmVyZmxvdyksDQpkcGRrLXN0YWJsZS0yMi4xMS4yL2RyaXZlcnMvbmV0
L2VuZXRjL2VuZXRjX2V0aGRldi5jLDE3NCxBY2Nlc3Mgb3V0LW9mLWJvdW5kIGFycmF5IGVsZW1l
bnQgKGJ1ZmZlciBvdmVyZmxvdyksDQpkcGRrLXN0YWJsZS0yMi4xMS4yL2RyaXZlcnMvbmV0L2Vu
ZXRjL2VuZXRjX2V0aGRldi5jLDE4MCxBY2Nlc3Mgb3V0LW9mLWJvdW5kIGFycmF5IGVsZW1lbnQg
KGJ1ZmZlciBvdmVyZmxvdyksDQpkcGRrLXN0YWJsZS0yMi4xMS4yL2xpYi9lYWwvY29tbW9uL2Vh
bF9jb21tb25fc3RyaW5nX2Zucy5jLDc2LEFjY2VzcyBvdXQtb2YtYm91bmQgYXJyYXkgZWxlbWVu
dCAoYnVmZmVyIG92ZXJmbG93KSwNCmRwZGstc3RhYmxlLTIyLjExLjIvYXBwL3Rlc3QvdGVzdF9z
ZWN1cml0eS5jLDE1MjgsQWRkcmVzcyBvZiBzdGFjayBtZW1vcnkgYXNzb2NpYXRlZCB3aXRoIGxv
Y2FsIHZhcmlhYmxlICdtJyBpcyBzdGlsbCByZWZlcnJlZCB0byBieSB0aGUgZ2xvYmFsIHZhcmlh
YmxlICdtb2NrX3NldF9wa3RfbWV0YWRhdGFfZXhwJyB1cG9uIHJldHVybmluZyB0byB0aGUgY2Fs
bGVyLiAgVGhpcyB3aWxsIGJlIGEgZGFuZ2xpbmcgcmVmZXJlbmNlLA0KZHBkay1zdGFibGUtMjIu
MTEuMi9hcHAvdGVzdC90ZXN0X3NlY3VyaXR5LmMsMTUyOCxBZGRyZXNzIG9mIHN0YWNrIG1lbW9y
eSBhc3NvY2lhdGVkIHdpdGggbG9jYWwgdmFyaWFibGUgJ3BhcmFtcycgaXMgc3RpbGwgcmVmZXJy
ZWQgdG8gYnkgdGhlIGdsb2JhbCB2YXJpYWJsZSAnbW9ja19zZXRfcGt0X21ldGFkYXRhX2V4cCcg
dXBvbiByZXR1cm5pbmcgdG8gdGhlIGNhbGxlci4gIFRoaXMgd2lsbCBiZSBhIGRhbmdsaW5nIHJl
ZmVyZW5jZSwNCmRwZGstc3RhYmxlLTIyLjExLjIvbGliL21lbXBvb2wvcnRlX21lbXBvb2wuYyw3
NTAsc3VzcGljaW91cyB1c2FnZSBvZiAnc2l6ZW9mKHNpemVvZiguLi4pKScsDQpkcGRrLXN0YWJs
ZS0yMi4xMS4yL2xpYi9ncmFwaC9ncmFwaF9wb3B1bGF0ZS5jLDMxLHN1c3BpY2lvdXMgdXNhZ2Ug
b2YgJ3NpemVvZihLKSc7IGRpZCB5b3UgbWVhbiAnSyc/LA0KZHBkay1zdGFibGUtMjIuMTEuMi9k
cml2ZXJzL2NvbW1vbi9zZmNfZWZ4L2Jhc2UvZWZ4X21jZGkuYywzNTUzLHN1c3BpY2lvdXMgdXNh
Z2Ugb2YgJ3NpemVvZihLKSc7IGRpZCB5b3UgbWVhbiAnSyc/LA0KZHBkay1zdGFibGUtMjIuMTEu
Mi9kcml2ZXJzL25ldC9oaW5pYy9oaW5pY19wbWRfZmxvdy5jLDIwMjIsImFyZ3VtZW50IHdpdGgg
aW1wbGljaXQgY29udmVyc2lvbiBmcm9tICdib29sJyB0byAndTgnIChha2EgJ3Vuc2lnbmVkIGNo
YXInKSBmb2xsb3dlZCBieSBhcmd1bWVudCBjb252ZXJ0ZWQgZnJvbSAnaW50JyB0byAnYm9vbCcs
IHBvdGVudGlhbGx5IHN3YXBwZWQgYXJndW1lbnRzLiIsDQpkcGRrLXN0YWJsZS0yMi4xMS4yL2Ry
aXZlcnMvbmV0L2hpbmljL2hpbmljX3BtZF9mbG93LmMsMjEzMywiYXJndW1lbnQgd2l0aCBpbXBs
aWNpdCBjb252ZXJzaW9uIGZyb20gJ2Jvb2wnIHRvICd1OCcgKGFrYSAndW5zaWduZWQgY2hhcicp
IGZvbGxvd2VkIGJ5IGFyZ3VtZW50IGNvbnZlcnRlZCBmcm9tICdpbnQnIHRvICdib29sJywgcG90
ZW50aWFsbHkgc3dhcHBlZCBhcmd1bWVudHMuIiwNCmRwZGstc3RhYmxlLTIyLjExLjIvZHJpdmVy
cy9uZXQvaGluaWMvaGluaWNfcG1kX2Zsb3cuYywyMzIyLCJhcmd1bWVudCB3aXRoIGltcGxpY2l0
IGNvbnZlcnNpb24gZnJvbSAnYm9vbCcgdG8gJ3U4JyAoYWthICd1bnNpZ25lZCBjaGFyJykgZm9s
bG93ZWQgYnkgYXJndW1lbnQgY29udmVydGVkIGZyb20gJ2ludCcgdG8gJ2Jvb2wnLCBwb3RlbnRp
YWxseSBzd2FwcGVkIGFyZ3VtZW50cy4iLA0KZHBkay1zdGFibGUtMjIuMTEuMi9kcml2ZXJzL25l
dC9oaW5pYy9oaW5pY19wbWRfZmxvdy5jLDIzNjAsImFyZ3VtZW50IHdpdGggaW1wbGljaXQgY29u
dmVyc2lvbiBmcm9tICdib29sJyB0byAndTgnIChha2EgJ3Vuc2lnbmVkIGNoYXInKSBmb2xsb3dl
ZCBieSBhcmd1bWVudCBjb252ZXJ0ZWQgZnJvbSAnaW50JyB0byAnYm9vbCcsIHBvdGVudGlhbGx5
IHN3YXBwZWQgYXJndW1lbnRzLiIsDQpkcGRrLXN0YWJsZS0yMi4xMS4yL2RyaXZlcnMvbmV0L25l
dHZzYy9obl9ybmRpcy5jLDMzMixzdXNwaWNpb3VzIHVzYWdlIG9mICdzaXplb2Yoc2l6ZW9mKC4u
LikpJywNCmRwZGstc3RhYmxlLTIyLjExLjIvYXBwL3Rlc3QtZmliL21haW4uYywzMzksbG9vcCBp
bmR1Y3Rpb24gZXhwcmVzc2lvbiBzaG91bGQgbm90IGhhdmUgZmxvYXRpbmctcG9pbnQgdHlwZSwN
CmRwZGstc3RhYmxlLTIyLjExLjIvYXBwL3Rlc3QtZmliL21haW4uYywzNzksbG9vcCBpbmR1Y3Rp
b24gZXhwcmVzc2lvbiBzaG91bGQgbm90IGhhdmUgZmxvYXRpbmctcG9pbnQgdHlwZSwNCmRwZGst
c3RhYmxlLTIyLjExLjIvYXBwL3Rlc3Qtc2FkL21haW4uYywyNDQsbG9vcCBpbmR1Y3Rpb24gZXhw
cmVzc2lvbiBzaG91bGQgbm90IGhhdmUgZmxvYXRpbmctcG9pbnQgdHlwZSwNCmRwZGstc3RhYmxl
LTIyLjExLjIvbGliL2NmZ2ZpbGUvcnRlX2NmZ2ZpbGUuYywxOTUsQWNjZXNzIG91dC1vZi1ib3Vu
ZCBhcnJheSBlbGVtZW50IChidWZmZXIgb3ZlcmZsb3cpLA0KZHBkay1zdGFibGUtMjIuMTEuMi9k
cml2ZXJzL2V2ZW50L2RsYjIvZGxiMi5jLDQ0NjAsImFyZ3VtZW50IHdpdGggaW1wbGljaXQgY29u
dmVyc2lvbiBmcm9tICdib29sJyB0byAndWludDhfdCcgKGFrYSAndW5zaWduZWQgY2hhcicpIGZv
bGxvd2VkIGJ5IGFyZ3VtZW50IGNvbnZlcnRlZCBmcm9tICdpbnQnIHRvICdib29sJywgcG90ZW50
aWFsbHkgc3dhcHBlZCBhcmd1bWVudHMuIiwNCmRwZGstc3RhYmxlLTIyLjExLjIvZHJpdmVycy9j
cnlwdG8vcWF0L3FhdF9jcnlwdG8uYywxMTUsT3V0IG9mIGJvdW5kIGFjY2VzcyB0byBtZW1vcnkg
YWZ0ZXIgdGhlIGVuZCBvZiB0aGUgZmllbGQgJ3Fwc19pbl91c2UnLA0KZHBkay1zdGFibGUtMjIu
MTEuMi9kcml2ZXJzL25ldC9ib25kaW5nL3J0ZV9ldGhfYm9uZF9wbWQuYywxMDk5LEFycmF5IGlz
IGluZGV4ZWQgd2l0aCBhIG5lZ2F0aXZlIHZhbHVlLiBQb3NzaWJsZSBpbnRlZ2VyIG92ZXJmbG93
LA0KZHBkay1zdGFibGUtMjIuMTEuMi9hcHAvdGVzdC1wbWQvcGFyYW1ldGVycy5jLDE0MTEsTnVs
bCBwb2ludGVyIHBhc3NlZCB0byAxc3QgcGFyYW1ldGVyIGV4cGVjdGluZyAnbm9ubnVsbCcsDQpk
cGRrLXN0YWJsZS0yMi4xMS4yL2FwcC90ZXN0L3Rlc3RfY3J5cHRvZGV2X2FzeW0uYywyOTQsTnVs
bCBwb2ludGVyIHBhc3NlZCB0byAxc3QgcGFyYW1ldGVyIGV4cGVjdGluZyAnbm9ubnVsbCcsDQpk
cGRrLXN0YWJsZS0yMi4xMS4yL2FwcC90ZXN0L3Rlc3RfcG1kX3BlcmYuYyw3OTUsQXJyYXkgaXMg
aW5kZXhlZCB3aXRoIGEgbmVnYXRpdmUgdmFsdWUuIFBvc3NpYmxlIGludGVnZXIgb3ZlcmZsb3cs
DQpkcGRrLXN0YWJsZS0yMi4xMS4yL2FwcC90ZXN0L3Rlc3RfcG1kX3BlcmYuYyw3OTUsT3V0IG9m
IGJvdW5kIGFjY2VzcyB0byBtZW1vcnkgcHJlY2VkaW5nICdtYnVmcG9vbCcsDQpkcGRrLXN0YWJs
ZS0yMi4xMS4yL2FwcC90ZXN0L3Rlc3RfZWFsX2ZsYWdzLmMsNTgzLCJzdXNwaWNpb3VzIHN0cmlu
ZyBsaXRlcmFsLCBwcm9iYWJseSBtaXNzaW5nIGEgY29tbWEiLA0KZHBkay1zdGFibGUtMjIuMTEu
Mi9hcHAvdGVzdC90ZXN0X2VhbF9mbGFncy5jLDYyMiwic3VzcGljaW91cyBzdHJpbmcgbGl0ZXJh
bCwgcHJvYmFibHkgbWlzc2luZyBhIGNvbW1hIiwNCmRwZGstc3RhYmxlLTIyLjExLjIvYXBwL3Rl
c3QvdGVzdF9lYWxfZmxhZ3MuYyw4NjEsInN1c3BpY2lvdXMgc3RyaW5nIGxpdGVyYWwsIHByb2Jh
Ymx5IG1pc3NpbmcgYSBjb21tYSIsDQpkcGRrLXN0YWJsZS0yMi4xMS4yL2FwcC90ZXN0L3Rlc3Rf
ZWFsX2ZsYWdzLmMsMTIwNywic3VzcGljaW91cyBzdHJpbmcgbGl0ZXJhbCwgcHJvYmFibHkgbWlz
c2luZyBhIGNvbW1hIiwNCmRwZGstc3RhYmxlLTIyLjExLjIvYXBwL3Rlc3QvdGVzdF9lYWxfZmxh
Z3MuYywxMjE1LCJzdXNwaWNpb3VzIHN0cmluZyBsaXRlcmFsLCBwcm9iYWJseSBtaXNzaW5nIGEg
Y29tbWEiLA0KZHBkay1zdGFibGUtMjIuMTEuMi9hcHAvdGVzdC90ZXN0X2VhbF9mbGFncy5jLDEy
MjAsInN1c3BpY2lvdXMgc3RyaW5nIGxpdGVyYWwsIHByb2JhYmx5IG1pc3NpbmcgYSBjb21tYSIs
DQpkcGRrLXN0YWJsZS0yMi4xMS4yL2FwcC90ZXN0L3Rlc3RfZWFsX2ZsYWdzLmMsMTIzNCwic3Vz
cGljaW91cyBzdHJpbmcgbGl0ZXJhbCwgcHJvYmFibHkgbWlzc2luZyBhIGNvbW1hIiwNCmRwZGst
c3RhYmxlLTIyLjExLjIvYXBwL3Rlc3QvdGVzdF9lYWxfZmxhZ3MuYywxMjQzLCJzdXNwaWNpb3Vz
IHN0cmluZyBsaXRlcmFsLCBwcm9iYWJseSBtaXNzaW5nIGEgY29tbWEiLA0KZHBkay1zdGFibGUt
MjIuMTEuMi9hcHAvdGVzdC90ZXN0X2VhbF9mbGFncy5jLDEyNDgsInN1c3BpY2lvdXMgc3RyaW5n
IGxpdGVyYWwsIHByb2JhYmx5IG1pc3NpbmcgYSBjb21tYSIsDQpkcGRrLXN0YWJsZS0yMi4xMS4y
L2FwcC90ZXN0L3Rlc3RfZWFsX2ZsYWdzLmMsMTUzMiwic3VzcGljaW91cyBzdHJpbmcgbGl0ZXJh
bCwgcHJvYmFibHkgbWlzc2luZyBhIGNvbW1hIiwNCmRwZGstc3RhYmxlLTIyLjExLjIvYXBwL3Rl
c3QvdGVzdF9jbWRsaW5lX2lwYWRkci5jLDE5NSwic3VzcGljaW91cyBzdHJpbmcgbGl0ZXJhbCwg
cHJvYmFibHkgbWlzc2luZyBhIGNvbW1hIiwNCmRwZGstc3RhYmxlLTIyLjExLjIvYXBwL3Rlc3Qv
dGVzdF9yZWNpcHJvY2FsX2RpdmlzaW9uX3BlcmYuYyw1MyxEaXZpc2lvbiBieSB6ZXJvLiwNCmRw
ZGstc3RhYmxlLTIyLjExLjIvYXBwL3Rlc3QvdGVzdF9yZWNpcHJvY2FsX2RpdmlzaW9uLmMsNDUs
RGl2aXNpb24gYnkgemVyby4sDQpkcGRrLXN0YWJsZS0yMi4xMS4yL2FwcC90ZXN0LXBtZC9wYXJh
bWV0ZXJzLmMsMTM3NixOdWxsIHBvaW50ZXIgcGFzc2VkIHRvIDFzdCBwYXJhbWV0ZXIgZXhwZWN0
aW5nICdub25udWxsJywNCmRwZGstc3RhYmxlLTIyLjExLjIvZHJpdmVycy9ldmVudC9paHFtL2lo
cW0uYywxMjI4LCJhcmd1bWVudCB3aXRoIGltcGxpY2l0IGNvbnZlcnNpb24gZnJvbSAnYm9vbCcg
dG8gJ3VpbnQ4X3QnIChha2EgJ3Vuc2lnbmVkIGNoYXInKSBmb2xsb3dlZCBieSBhcmd1bWVudCBj
b252ZXJ0ZWQgZnJvbSAnaW50JyB0byAnYm9vbCcsIHBvdGVudGlhbGx5IHN3YXBwZWQgYXJndW1l
bnRzLiIsDQo=

--_004_VI1PR07MB558269DB5FBD221349168695FAC42VI1PR07MB5582eurp_--
