Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CE7CD98D2
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 06:00:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33B4A402B6;
	Tue, 16 Jun 2026 08:00:04 +0200 (CEST)
Received: from MA0PR01CU012.outbound.protection.outlook.com
 (mail-southindiaazon11021131.outbound.protection.outlook.com [40.107.57.131])
 by mails.dpdk.org (Postfix) with ESMTP id 6EE7940285
 for <dev@dpdk.org>; Tue, 16 Jun 2026 08:00:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfUooefWojPTNVMlLE+I+BJET8YsoxCyoA/4vcoDjitMjLLq2T1PyQPjAs72IO7HHBIvgPgMR/4QmNBlwhL+RUAHpOmjTZFAKpLlWypyK7awZLAM/r2zo91Ub6ctA/7VsacSolHixgaGw+Qmv6tkfE3NFJACtJnAqfDK8LB+awET2dm6uVzq0xFL5sUjqNJ1P0z7qg/c8x+Xwpem9S1Jjkr3nspQZUGxjEfPIpZY7HIJZp0CrAAPBnpcIyRrFzydgmM+xjZ5Q7A7kW7mS8l3L1NiBQIkI/zaE3UZDh9H90+tIDgFGcKSE7g2pQFBfVDabj9lRO3TCBPTy8esujZefw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4Cdd70R2ohTe0RnybuhvdBzART7p1lkwq1kP2nm97A=;
 b=MGxyrBEtWtTltVlBMwQW7BHj5CMQCi3vC8GmU/+f6DeG9pWOpsubWermxLinx6VQmoFIzg8hv42cm2dD/ZbElS8f1/jAB0biekcMMVIxqwR7qniNFs8csdAgfql2z3ebNq/gvZtpzzTQwrmUkNH63OZ+uluE0+MEuBZFRLrHRZWNaxx1wgEICdSAFrfv+gokMT/eoeucWg6aFC4A4agh0ZkZcsdlHVxFyT4x0ZbaDihg+Xlc6JTp4LLSONHWxxAsj4JyUMWOi6utNIy0VW2min9cigQh8ko7GuYfm4gNsqqh8kD3mch8otMZy5CHMnId7a6+omIK6gVzZoxlt0YNpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amantyatech.com; dmarc=pass action=none
 header.from=amantyatech.com; dkim=pass header.d=amantyatech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amantyatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4Cdd70R2ohTe0RnybuhvdBzART7p1lkwq1kP2nm97A=;
 b=LAUuuBDiTsOfuPP9CZDMB2a6GlKPpDaONKQvqv0MldN1AHX8ldtqauNFVuF/+JVRecL50zm+3zFxIF5Ujlm/UUJWtSml63/OLQOhXYWxJLnrcJYXZ5jDnkK9GyXD32L4QzqVB5y3W06JkrCMPpPxjVjLG4oR4OZTsFJBiXcncAEEHT+KGbUDMyejDOlXpk4XS3FMTjNwXA6UHPHMe3DuZGIKhtWK2qkBc2WhDIz8Qjy1SXFP3Y2nPP4diyJ1gLXYWnI8+JkVL5Pa6LqG0u7qPIWe+DqCD7COhH4Eel8iQPGZMhZvkamBASGdh+La8W720dumqItgpElnLQ+zS4RaDw==
Received: from PN4PR01MB11432.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2d9::9)
 by PN0PR01MB9039.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:169::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 05:59:58 +0000
Received: from PN4PR01MB11432.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::e52a:de50:7de0:907c]) by PN4PR01MB11432.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::e52a:de50:7de0:907c%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 05:59:58 +0000
From: Samyak Jain <samyak.jain@amantyatech.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Vikash kumar
 <vikash.kumar@amantyatech.com>, Ankur Bharadwaj
 <ankur.bharadwaj@amantyatech.com>, Rajan Goel <rajan.goel@amantyatech.com>
Subject: Re: Question regarding duplicate fragment handling in DPDK IP
 reassembly library
Thread-Topic: Question regarding duplicate fragment handling in DPDK IP
 reassembly library
Thread-Index: AQHc/MPFstdlbQvKQkG909Ypsm9olLY/4doAgADPK5o=
Date: Tue, 16 Jun 2026 05:59:58 +0000
Message-ID: <PN4PR01MB114322C2C97E0EF2C45367D68EEE52@PN4PR01MB11432.INDPRD01.PROD.OUTLOOK.COM>
References: <PN4PR01MB114326CC09306DA93ABA7C2ECEEE62@PN4PR01MB11432.INDPRD01.PROD.OUTLOOK.COM>
 <20260615103752.6155db47@phoenix.local>
In-Reply-To: <20260615103752.6155db47@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amantyatech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN4PR01MB11432:EE_|PN0PR01MB9039:EE_
x-ms-office365-filtering-correlation-id: e467be79-4481-480d-021b-08decb6c7f5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|6049299003|1800799024|366016|376014|23010399003|8096899003|38070700021|4013099003|4053099003|22082099003|18002099003|4143699003|56012099006;
x-microsoft-antispam-message-info: SZ+JcIBV7bb1b0+KIlKfYo8r0+O3T7r0/WtREbJKEnvIflCbos/HYON2NncQMkWBFv6Ec7J7ozCWgDXcNwS6IYst3CWwqfYfBznQsAtV2NFdb9tAr0kVsgvxOP9lJzyan0YlA8uYbYtloDoZEvyxyJgrWb4LzN6nMYxU41cR+bGQyE4hyTfdrGX4ncoS/kfn/Zd1seBFs0ECWr1uvAsJwDMVuiVHkgT5xnaUMzgFgmLY4RIvYQmfomEFLESgHdG2jvjja+iG2d2c7VTd9ViNqdeJiumhVbBJp27k1OSRS9Seau1wFs4Qyp4Tfw6Uq9EC3KVw3Z0IPY8m4jfeMi7sHvD9CFXvgz+zjQHRfIqPAGmP/Vk0A7XH94xRPmFoGwDi3FPxNxWdVgMWH64ekTzwZ79hFmfYMUw0Qvdus5WrinvEC8VK+uqRSigs7t++o1R7ethogWlzxeCobBGJLRtfHxxlN/7hr7GuPsUYgh8Vs3E6e4zK2h3UFlT/NipPJ25aiiuqc5oVPw0CbRh0Efih9bFUv2tNEV9DAwTJj2kGPHNuKm0PYDKgxfn9NtxDOrmxVUe6FEbZALAznD0cs2DmtNg9w64oijAgepju5hxip1o+eaVTWnYVyzEYdBbTCPrDdlwXqk3nKxhZl1Dwd2jeowKtT3JmOXD1SfPq2PPU2TRVdsQb/3Ed3rChYrbxvyA3rX1p+5TyhdgjWwuKbgeYrVIt/yQ7SHMQyk8lCj3OsKBj1LhNCubXVZSO4j8b6/6F
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PN4PR01MB11432.INDPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(6049299003)(1800799024)(366016)(376014)(23010399003)(8096899003)(38070700021)(4013099003)(4053099003)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?bGdTY1dLS09aWVZJK0swdnRqRTVmdUMwdkd3SllJQ3hJR1pla1ROSTZO?=
 =?iso-2022-jp?B?SnN2RTF5UkJGSDhxa0ZQODJrR2FuZ0VZWGJndElQQTl6TTgxTVJNdmhT?=
 =?iso-2022-jp?B?elBIR2tsSlBwTU1Nbis0RVFJUEt1REF6cW8xRTR3SDJrVFRDL0dlWVZZ?=
 =?iso-2022-jp?B?eldmYTZLYy8wRjlRYTREUVNXaVRmWUw4dzNaNzk2MGxnb1ZCTGZYbm54?=
 =?iso-2022-jp?B?OGRVRHZnblVsRHR3UzZuMkovejg3MUNPQnh1SEhySnVnbExYZHBRNjdD?=
 =?iso-2022-jp?B?OG9YL2MvYlM3aHZTOTZXdzRsNU5OYTR3TENGUm41MmlZbkVXSHU2OGpn?=
 =?iso-2022-jp?B?SDhucWhlYzRGMUdEMUhIOXh0S1B2a0RXMEpnTUVQR1loOGFJNEQ1ekdE?=
 =?iso-2022-jp?B?b2ZKT2JQazNsemZlLzljcGJqaDhKTG8xOU1DUGJoWEFyQVhBdUgwNjEz?=
 =?iso-2022-jp?B?cXpNV3RENkIvZEVJZFpaODI4TUhoZXkyQkVJQ0FHWjdyZkJOdlI0ZmVs?=
 =?iso-2022-jp?B?VVBlUHBVcGJReElQbkE2enkrVGxxb3FXRVdZdG0yaGJZRTQ2Y1Uzb2da?=
 =?iso-2022-jp?B?QXlkUG12Mzl1NVZUY3lWczJVbUJMSlhqMlBTZmZKUHR0U2dTa0xPTjBQ?=
 =?iso-2022-jp?B?RTdtRk5uQU93Z2UzWUdiejhScHhXellZa0c2YVlmTS9pS3lreWI4ZVVs?=
 =?iso-2022-jp?B?alNjVk1iK3IwbzBLMmVycXhxckEzd250NVB2akZSbG02a0d2Z2xvemp3?=
 =?iso-2022-jp?B?YnR2b1M3WXhIVEhtR3pkM0RZWjZMRGJRQ0dINDNvcGlTR2Z6YlY0S29O?=
 =?iso-2022-jp?B?b1JGdE5pZTFEUEJWTTZOa2hXazNMS3FFb3grL3ZhYTFISDZpL3Z3aERV?=
 =?iso-2022-jp?B?dVgxYmNta0p5bnUvaExETE45OG1iUUxSaUJLTmNORkoxQ3gyMnNnYjM2?=
 =?iso-2022-jp?B?U241Y2NubGVjRmR2b2pvRHkwQ0o4SmVCV05uSEZrT25vNkYyd0lqRlRn?=
 =?iso-2022-jp?B?Um1BeUhIdmhHbm4wODR6VTZEU2ltTHMrWFZSOXRVWlFVMUlOalBpWEor?=
 =?iso-2022-jp?B?OTZ4MGJzTVpyWSsyTWxJK2VqaGpOTHFnQTVLanVBTVJQVFkrSEw0QXp6?=
 =?iso-2022-jp?B?bGh1NnVVN1lub05SSmRicGZTa0hrSEFsM25RWkZwV2h5dFQ1clVyY2pI?=
 =?iso-2022-jp?B?ZjFKMjAyNC9Hc1lwaTVyQS9kVkJ3RGxmQ3N0eEZiVVBNbEhjdzlYL3lQ?=
 =?iso-2022-jp?B?UUV1ZE1GVXJjUHY3TXRpY0pyKzFTSkJpOUhvUFh0QWl0aHMzNEpxWW51?=
 =?iso-2022-jp?B?VHdENFd5VEVMczlPbStYNWRQMjlGbWozQld6T29mbEJyYUlRbExvbDhv?=
 =?iso-2022-jp?B?L1NQYmlMN0tNbGgzZ0t0dkFPMDFHbnArV2w3bytZMVlXaFpYSVdWN3pn?=
 =?iso-2022-jp?B?OFI2d2dNbGh0cVJFQWRZZmRWeHZVaE9PaEx3NWkvcnV2ZDA3WXQ1ZVdH?=
 =?iso-2022-jp?B?dHZXb3R2cHc0NmJFSGxUZTh6NUJHaXRqL2U4ckczcVdsYmlmNEtyMlpP?=
 =?iso-2022-jp?B?bzk2VW9XWTIvRStFNXgyZHc5eXF6L1ZtTWVwTndXQWhmdi9lVVhPQndU?=
 =?iso-2022-jp?B?VW1FU0U3Y0NINTNheUp5SUMwaGRxQTM2Q0RFSkc4WkZWT0tOdnVjQUxt?=
 =?iso-2022-jp?B?U0ZuV3RQck9qMG5oNlZnL3VyRnRxWXd3aHNzZEhHbnBhbVI0OGNxRC8r?=
 =?iso-2022-jp?B?TmtUcTRUamZXK2luOC9rMXRyVjhQWnlRSWdCLzZ5Q2lIaXpET3ZIRThG?=
 =?iso-2022-jp?B?b2lvTmdQdEFNUXJHdjJwUk0yMEs3cnFtS1ZtbFNBQktyYXc2RVdEb3Z2?=
 =?iso-2022-jp?B?U29mbGd5NXorTDlxaTZ5V3FxQU42VkdJT3V2OFlVQXdEcmxPLzhWL0FP?=
 =?iso-2022-jp?B?c1dLSUJYeGhZOG9IZEpiZ2lSeUpKYzBPM3lvNnBHYkpoZGk1MFExbzZ4?=
 =?iso-2022-jp?B?TzN0RFN0cTRWNXR4ck5sSWhmVU1KclRDdk43aW5Oa0RUSUNEQWMrNnNr?=
 =?iso-2022-jp?B?N2xrcGUzd29IN2xIWEhXdW9XYVBmN2I5MDdlVUxkVUY1cXB4RzQvREFC?=
 =?iso-2022-jp?B?VjhvU3dmcm11T2dMNWJnb3p1T0lzNGg4eW1aaHBZVUFBajR5R1phb0RD?=
 =?iso-2022-jp?B?bSs3TVhhMnFDSEMxemFhZzhneXIzbGt2aFdhak9KaWpoU3piV2ZIT0dO?=
 =?iso-2022-jp?B?K1h1OVZOMzBBRkdUTGs3UW9XOERtS0trZUlDd2dVVmVZYzYveEhYeFBh?=
 =?iso-2022-jp?B?RnhycmJWc2pRSktLQngyTWpXZFB4R0FIVEMzRE90Qm01R29MWktzVjAr?=
 =?iso-2022-jp?B?Yys3eDhhWVFjNzd2M2tSMkRvSGk0SytDVGFLTlhiMlluQTN5QnhITzdw?=
 =?iso-2022-jp?B?L296aEduVWh1SFFEdHJPU1h2c3VxQnpBM2g5MUpXakpQMVdGaWlDMmJP?=
 =?iso-2022-jp?B?ZHFaMitwcDlKMThXSVJPVnpYa25DeDk5Qno0UT09?=
Content-Type: multipart/related;
 boundary="_004_PN4PR01MB114322C2C97E0EF2C45367D68EEE52PN4PR01MB11432IN_";
 type="multipart/alternative"
MIME-Version: 1.0
X-OriginatorOrg: amantyatech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN4PR01MB11432.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e467be79-4481-480d-021b-08decb6c7f5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 05:59:58.6502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d5b66d53-29b2-4452-ba0f-f8badcf5782d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oBY1FIkK5/K+I+qlKh9Bzh5n3Zr5/RFLGeikh1btwPPSr0ms5JbBj8A3znf6oESXbC/N6Dg1GlR61Jy4zewE3mkcYgR/tZ3Y/IK8QzIoGD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9039
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

--_004_PN4PR01MB114322C2C97E0EF2C45367D68EEE52PN4PR01MB11432IN_
Content-Type: multipart/alternative;
	boundary="_000_PN4PR01MB114322C2C97E0EF2C45367D68EEE52PN4PR01MB11432IN_"

--_000_PN4PR01MB114322C2C97E0EF2C45367D68EEE52PN4PR01MB11432IN_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

 Can we fix it ?

Thanks & Regards,
Samyak Jain
Software Engineer
[cid:cb660601-cf07-4da8-aa47-acae8e4439c5]

________________________________
From: Stephen Hemminger <stephen@networkplumber.org>
Sent: Monday, June 15, 2026 11:07 PM
To: Samyak Jain <samyak.jain@amantyatech.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Vikash kumar <vikash.kumar@amantyatech.com=
>; Ankur Bharadwaj <ankur.bharadwaj@amantyatech.com>
Subject: Re: Question regarding duplicate fragment handling in DPDK IP reas=
sembly library

=1B$B"%=1B(B CAUTION: This e-mail originated from OUTSIDE the organization.=
 Please do not click links or open attachments from an unknown or suspiciou=
s origin.


On Mon, 15 Jun 2026 12:39:48 +0000
Samyak Jain <samyak.jain@amantyatech.com> wrote:

> Hi DPDK Community,
>
> I am using DPDK 25.11 and evaluating the IP reassembly library
> (librte_ip_frag).
>
> During testing, I observed that duplicate fragments appear to cause reass=
embly failure and the fragment context gets invalidated.
>
> I would like to know:
>
> 1. Is duplicate fragment handling intentionally unsupported in
>    rte_ipv4_frag_reassemble_packet() / rte_ipv6_frag_reassemble_packet()?
>
> 2. Has there been any upstream discussion or patch to support
>    duplicate fragments while still rejecting conflicting
>    fragments?
>
> 3. Are there any recommended approaches for applications that need
>    Linux-like duplicate fragment tolerance?
>
> Any guidance would be appreciated.
>
> Thanks & Regards,
> Samyak Jain
>

Short answer: yes it is buggy, no it shouldn't be.
Looking into it but not a simple answer

--_000_PN4PR01MB114322C2C97E0EF2C45367D68EEE52PN4PR01MB11432IN_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;Can we fix it ?</div>
<div id=3D"Signature" class=3D"elementToProof">
<p class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em; m=
argin-left: 0px;">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace; font-size: 12pt; color: rgb(0, 0, 0);">Thanks =
&amp; Regards,<br>
Samyak Jain<br>
Software Engineer</span><span style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);"><br>
<img style=3D"max-width: 798px; margin-top: 0px; margin-bottom: 0px;" size=
=3D"4041" data-outlook-trace=3D"F:1|T:1" src=3D"cid:cb660601-cf07-4da8-aa47=
-acae8e4439c5"></span></p>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Stephen Hemminger &lt=
;stephen@networkplumber.org&gt;<br>
<b>Sent:</b> Monday, June 15, 2026 11:07 PM<br>
<b>To:</b> Samyak Jain &lt;samyak.jain@amantyatech.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Vikash kumar &lt;vikash.kumar=
@amantyatech.com&gt;; Ankur Bharadwaj &lt;ankur.bharadwaj@amantyatech.com&g=
t;<br>
<b>Subject:</b> Re: Question regarding duplicate fragment handling in DPDK =
IP reassembly library</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">=1B$B"%=1B(B CAUTION: This e-mail originated from =
OUTSIDE the organization. Please do not click links or open attachments fro=
m an unknown or suspicious origin.<br>
<br>
<br>
On Mon, 15 Jun 2026 12:39:48 +0000<br>
Samyak Jain &lt;samyak.jain@amantyatech.com&gt; wrote:<br>
<br>
&gt; Hi DPDK Community,<br>
&gt;<br>
&gt; I am using DPDK 25.11 and evaluating the IP reassembly library<br>
&gt; (librte_ip_frag).<br>
&gt;<br>
&gt; During testing, I observed that duplicate fragments appear to cause re=
assembly failure and the fragment context gets invalidated.<br>
&gt;<br>
&gt; I would like to know:<br>
&gt;<br>
&gt; 1. Is duplicate fragment handling intentionally unsupported in<br>
&gt;&nbsp;&nbsp;&nbsp; rte_ipv4_frag_reassemble_packet() / rte_ipv6_frag_re=
assemble_packet()?<br>
&gt;<br>
&gt; 2. Has there been any upstream discussion or patch to support<br>
&gt;&nbsp;&nbsp;&nbsp; duplicate fragments while still rejecting conflictin=
g<br>
&gt;&nbsp;&nbsp;&nbsp; fragments?<br>
&gt;<br>
&gt; 3. Are there any recommended approaches for applications that need<br>
&gt;&nbsp;&nbsp;&nbsp; Linux-like duplicate fragment tolerance?<br>
&gt;<br>
&gt; Any guidance would be appreciated.<br>
&gt;<br>
&gt; Thanks &amp; Regards,<br>
&gt; Samyak Jain<br>
&gt;<br>
<br>
Short answer: yes it is buggy, no it shouldn't be.<br>
Looking into it but not a simple answer<br>
</div>
</span></font></div>
</body>
</html>

--_000_PN4PR01MB114322C2C97E0EF2C45367D68EEE52PN4PR01MB11432IN_--

--_004_PN4PR01MB114322C2C97E0EF2C45367D68EEE52PN4PR01MB11432IN_
Content-Type: image/png; name="image.png"
Content-Description: image.png
Content-Disposition: inline; filename="image.png"; size=3798;
	creation-date="Tue, 16 Jun 2026 05:59:20 GMT";
	modification-date="Tue, 16 Jun 2026 05:59:20 GMT"
Content-ID: <cb660601-cf07-4da8-aa47-acae8e4439c5>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAAM4AAAAoCAYAAAC2AsVbAAAABHNCSVQICAgIfAhkiAAAABl0RVh0
U29mdHdhcmUAZ25vbWUtc2NyZWVuc2hvdO8Dvz4AAA5oSURBVHic7Z15UBRXHse/PSc3iKIMImIE
GVABxUTX6HpDomZzoNEku7W7SXaTrCaxkooxJpvTPWqzqZTm3CPqOkRNgkY2ajBmXY9sBGE4BIWg
ILeAXHIOMz3d+wcLMsx7Pd09Q2RT/amiCvr9+vXr6feb3+/9fr/XMDzP81BQUJCE6mYPQEHh/xFF
cRQUZKAojoKCDBTFUVCQgaI4CgoyUBRHQUEGGk91lLorC1XtvdT2VXEGvJZiFN3fA3tycKmli9oe
5K3DV4/fLknzNx++gBOXmgRlTjyxEAFebnwsdhbs2XTYik6B724HExwGbdJKaOKXAgwju1tzTTse
S88ntmkZFQ48PA9hAXrBPl44fBHHLzUS255dHI0HZoUDABa+cxoW1i57rMOJGuuHpxdPxcYDhVSZ
2AkBMD2YJNjPWycvY19+DbX90XmRePxHUwb/fjmzBEdLGqjyk4O8ceCX8wSvScMjinOxoQMHz9cL
ylS0dGPrsmnQa8RN9ZKmThTWtQvKHC9tRIpxgqj+Oiws3jtTjh4rKyjHcpyo/ojYetG741GwFXk3
jl0pAGs+Ck3CUng//Dag0cnqutNqg7m6jdr+2GdmfPHIfME+rrR2Ufto7LQM/p5b3eZRxbHYOMyd
FAzOziOf8kzN1W3YsGAK5kUEE9t7rBz+8PV3aOnuI7b76jW4d2bYjWva7XjndDnae63UcZmr21B0
tRMzDf4S7qYfj7hq/8itdinT1m3FEQHtl8POc66vO8D+glqXSuMulk9/76g0Q2ALT8D6+Zsjdu3D
xQ3Yl187Yv27C8MAr6+ME5R5+2Q5te3vWZVUpQGAJxdEYYLfDYv7z+IGQaUZ4OM88XNoKG4rDgdg
X564B2bKkTdIGoeK6nCti/5hDmVXVpVHrz0c++UcsGcPCMpYz+wH3yHsKrrDkwcK0dTterLcLFbH
hWLe5LHU9gOFtShv7nE6bud47DhzmXqen16DZxZPdThmyhX3vNNyq2HnpBfPuK04/y5rQk2b882S
OFrSgOYem7uXHMTKctgr4PMOUHatC9nVrR67rhOsFX37XoWr6iXezoItzR6xYbR09+FpgXXEaEDI
6tg5HtsJCpJeWI/yZvp699kl0QgZYm2auq04ViLuC6quvRenyltEyQ7FbcUxmcW7B1aWw2cFrie6
FD7KqnQtk13pclK7g+2rv8HeUCFO2D6yFmF/fg0OFgmvN11hCPJCqL/zzzg/evCBYRjiOaH+Xgjx
vbGuWzEtBIujxlP7+SirEi3DrObbpy5R5YO8ddi0KMrh2F5zNWx28WtVsdZpKG4FB3qsHA6er5N0
jimnBk/Mv8WdyzpQVN+B3Np2zAkPIrazPI+0XM8q61D4pivo++qvomQZlRqaqcKRI0+w4bMCLJka
gjE+WlnnV7yYQjx+obETM/54nNgW5KPF1ddXiur/jZWxWLiDbBF6rCw+PFuBF5f3R2BPlTcju4ru
LWxeNg1BXo73aZL4vNML6/DumgT4asWrg1sW51BxPTotZNeLoYRes6paceka3ezKYaeA1cksaUT9
dXqY3C14HpZ9r4G3ubYiDMNAv3oDmPGRIzOWITR0WvBsRtGIX0cuC6aMRbIxlNq+43QFLPb+qN6f
T5ZR5cb56bFxoePa5kJjJ/JqyJFD2pzs6mORUSQtcOWW4ggt9n/1o0jicZ7n8XGeZy3A3rwa9FjJ
pnlXdqVHrzUU9lwG2DLnNQsXNAGa6FuhNs6H2jgf2oUPwuepXdCmPDFiYxnOrnOVyCwduUCEu/xu
VRx1Ijd1WpCWU4Pvmjpx9CI57wQAW1cY4a9TOxzbk0N3u2hzEgDSJLprsl21pm4rvqYkEyODfbHt
zjjszK4CS/A1/3GuGq8kx7qTD3Tgeq8NB4vq8NOkSQ7HW7qtOCLwwbsD39WGvoN/AtDvgtVNnIfP
MQNmfQx2b0iG97AHejN49BMzip9f7uTKjAbmhAdh9fRQfFF8ldj+539fxrdXWsFRIl6GQG88Nm+K
wzEOwF7KmlulYvBqSixOX25GaVOnU/vxsmto6LIg1M9L1PhlW5yPzTVEpQCANYlhCPHTY0lUCLG9
srUbZ6ukRzKEILlraXnV6PNgIm8ADkBF5l5wvV0ojliBVX6bMb9pNd5sisTz982F7yhQGqA/YrT1
8IWbPQwqr99JtzrfNXVgt4D1eGlFDHx0jtP367JG1LaTI7wLpoyFIcALqQnhxHbWzmG/yLQK4Ibi
mM7Rbyo1YSIA4P7EifTz3cjp6DXOE/NkebNTDmB3tvMYNWr3c767/1OJxVmhmKvbitWNS1HcFwAA
UKsYzJo0xu3+pRLorYWOUpHx4bdXcKq8+XsekTgSwwIH5woJWiQ0YowPHpkb6XTclEuf+Knx/Qpz
/yyBOSkhqCBrFl1s6KCWTkwM8sbcSf1lE6nxE6kP9JPCOvSx8spb7oh1DmfyPI9dQ5Q5r7YdBXXX
neSWRtNDoWKob7fgjSMX0MOp0cg5mnU7x6P5JiQgDf5eeHF5DLGN53n8cr8ZXX0jWzUhl9dSjFCr
pPnsL6fEOpVuddtYHKJEeBmGwT3x/cGIeEMA4gyBRLm8mv4SHDHIUpw9ZrpmpiaEDa5dxvhosZQS
s2/rtgoW4AmxJiEcWoLl2J1TOZgF3kUx8+sEvnHE8Ex6ATookUQA+MtpUtkIB67hLGzn34Ltm02w
frMR7Lnfwl51FGAtBHnpbE02IimCbO2uNHfjlcxSj1zH08SFBmD97EmuBf9HVIgffn5bhNPxzwrq
qV8Ot0WMQUSQz+DfaxPCiHKA+BIcyYrTvwATUJyZjj7k/bPIPiXQn9ORwzhfPZYRLEddey+OlTbC
ypH9VS+NGnfF0cOgrkg31+L4RWFl3/6vMmz6tAB5VW240tIFe0U6+jIWoe/rB8GefxdsZQbslUdg
K0uD9cwGWA4tBHvJBMC9BK2GYfDR+iSqhd9++hLyCRZ4NPBqilG0C/1KSiw0hHWRSaBeMjXeUVHW
z6bPSbElOJIVR6jEZoK/F26f4ljdem+8gfowj5RcdcoSi2V9Evnmd+ZUIeP8VTQTathWzQhFgMwI
U3NXH7aKzI2YsiqxZe8xeP/nEVi/fQ5cJ9335i3NsGW/DOuZ37hdVZBgCMALFJfNzvEoI0STRgNR
48hWZDgx4wMGtz4Mpe56L05dvkY97754x3OMIf6YbgggyootwZEcjk4TsDa9NhZzt590Oq4C2Ye1
shw+LayVVUlwzwwDvDRqp/L3L4qvoq6N7P7cn0j/pnHFC4eK0SKyoPSuiE68H/4emA7xoXB7VSas
zDPQLdgBd9JrLyUbcfhig+AWhNHIy8lGpOXUCEZBt62MJa6H9uTWUK2EWsVgnck519bQQX+Wptwq
LI0eJzheSU+o12bH5wJ1UB0WFubqNqcfob0dQoooRKCXFnfGOrtdVpZDFiHU7aPTYFWcuL07wzl2
sREHRSZt747swPuhb4KxSM8f2SuPgC3ZKfm8obhy2UYrEUE++NmtdKsTZwhEajx5fbpHIMJr53ji
nBTaonDgfD01oT6ApE/386KruN7ruepmAPi2ogVlMktwaO4aiZ9MN0iqRRqg08LiufQCUbIzx1rw
btgHYFj5LhF7fjt4GUo3FCGXbTQTGexNbZsc5EVMmJ+rbicmNN2h02JDxgXhQllJiuPp/TQDiN3P
M5zVsQb46cUpw7rZ8qJp2768iDqBLeEDBOp5ZMzYDcZ2HdppD0G36K/Qr/wnvJaboJ21BSr/yaKu
x9u6wBaLKxoV4qVkI2bfhJzS943JPDL7rEwCyVdAguIIldi4iym3GnKq/n10KvxkusGlnL+XFikx
0t20DosNe85WipId46WCatIqaO4+Bc1t26CetAKq4JlgQhdAM/0x6O8+Ae3cbWDUwu8FAACuOlPy
WIejYRjsfCCJGLb/oWCTmO2XwkAJDg3RvsteczW1xCbYV4c1AhlgAGDtwM7sK8S28uYunK1qwfxI
+u5AGuuTwrHXxfrj3plh8NZKL4Mpv9YFq4gkbYifHmm/XgB/wb3rKmiiH4LafzL6TjwMnqO7vHzv
VYBjAZV7r4RIMARgy/IYvHGsxK1+RitHSxuJ0VMA0GlU+MVtrq18emEdWgmR3YESnE0/jiKcJUFx
9gjs71+XGI731yS67CO/to1acZCWWyNLce6ImYBgXx3x5m+MT56bZgjwBsMwgpvgtGoV0h6di1iR
L3xgQhdAm/AUrPlvUWV4rR+g8ky920vJMThUVIei+g6P9DeaEAoKJBvH4y9rZ7nsQ4X+siQSptwa
quKIsuNCJTYAsFYgySlW7pOCWlklOFq1CvfG0zPBY3x1WG6UV2YTGuiFFYTI3VC23GnEHMqbWWio
jb+GKnAqtV0T8zBACeFLRadSYc9Dt/7gXLbWHuHK97Xx4qoR1ibS5fJq2lBMKcER9WkKldiE+Omx
8BZxlmKdgOK0dlvxZam8Epz1s+g3f198GHQq+ZPmnQdmIXGS8+5StYrBpmXT8PSSadI7VeugX/QB
MWCgnroW2pkb5QyVSmJYIDYv/f+LsgmxP7+WmvPRqlW4a7q4CpFFU8divD99K8HHlLkvylX7rrGT
Wge1Oi6UWAJB4pZgH6QmTkRlK7nywFzbjntm9FuP2PH+0KjJ/QZ6Ow57ydRxWBQVgi7C659+luSY
G2BUoN4LAGiGKdk4Xx0yn/oxMgrq8U15M7osLKIn+OO+2WGIDpH+Pq5BAqKhX50JrvpLcG0l4DV6
aMKWgRlHdnn9dVrquCODfYjHh/Lb5Bjk17ahkZK/mCAweQbw1qoxhzKGQG9574sbiiHAm3qPUcM+
66L661TZW8ODRG8bV6sYPHH7FBymlFKVNpFdXEb5x1IKCtL5YTm+CgrfE4riKCjIQFEcBQUZKIqj
oCADRXEUFGSgKI6Cggz+C7TQdDkLgHYUAAAAAElFTkSuQmCC

--_004_PN4PR01MB114322C2C97E0EF2C45367D68EEE52PN4PR01MB11432IN_--
