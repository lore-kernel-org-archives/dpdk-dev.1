Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E20EC36002
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 09:40:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7F9B40655;
	Mon, 24 Mar 2025 10:40:43 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
 by mails.dpdk.org (Postfix) with ESMTP id A8773402DA
 for <dev@dpdk.org>; Mon, 24 Mar 2025 10:40:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baeERIVJRHC50AJisZNVzd4sZGPw89QqA2WOVbOXetu+Z6QdGLgD+n5bkv4thZUkDLVrb1o4v7+wULcJSW8WCT2QZNt4uuCDZkQcgHzqELbAhpYN9v9acc2xhhL0BuYOaVfgqwk5BoBw456Hj9KSRQi2begTDW1vLEfCPwGsVESQ+dPfSkuufojwth4IoyhazeTBtonYCOBz99xSOd/fPQKTvgeJZ1slvCf6Lhf3xibE+8ojXUUNU/STWyIB5BqpM0yE2QRUL9RiJ3/RJNgZ6szBPF0hrabhIdFyJ/JJs2umeuSCP6pwN5cOhOSRwzoSSXJakrQP3Gss0SKAbAFmJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIOXeMiB3PDpS3L0+KFEv2P8qjxEQcEYKSGOjUb8emA=;
 b=ocnCcDCip3h0V0R/Zn2yStPwxlmQSJUyVkcn8L072Cs9VKLbiYsPCBKD2X2llfJlJ+b4TzKoV7le4U0SsrIqec8R40MU0DkndwORZ4DGO0VldXPvqXXV8sfPjlt02FdrAFnheHDNhiaomBUHKPc9cx3tPv61Mca9B8vh1Lrxk/bHIjre0+RTe78UuFfWxmV/K73ed7ONeAC7WBAvMboqpLuW/4ARbhw9DD8eH/0wB9Ke8/P7PPhR+/ClcYFuEuNALt85B1NYDtBeZPzHd2GHzKjB6p6/y0IKJZHSuh4VLSyOi3Roa2H7Evuioe112hURwtYNSOItFSuPoJUVyD9PaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIOXeMiB3PDpS3L0+KFEv2P8qjxEQcEYKSGOjUb8emA=;
 b=SLtnH0pHpU85a9f0DuQczM7oqVQFm3s92bEE/IcMlrV2sZUqldE+Rtk7/NhMmyfuAIuaWHJ33WBvLv3GmFrQ+U55KAAbW0SK7BUA2UXVLZilHAFHc0CjcV9e45xZlZ2hqXMacuUL1g6NuPrfevoXvV2/EYya7591Lmlsu5zd27XFce4TLVQA0lzLYHAXNnv16Pye49WhM8BwzsdUdP8nqlF8WMbuyFD4ZywHPVejOpS4+FyU2UoRDd7MuNpB9TO70VUuHiO6nR69uD85OH1vQEJqIwCHMW+Ae5tpDtiXZXRsx+3+xHSUQj5bXJRkDiveXYUgMv/LUy37Y1puaFKXLg==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by MN2PR12MB4271.namprd12.prod.outlook.com (2603:10b6:208:1d7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 09:40:40 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 09:40:40 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: =?Windows-1252?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "haijie1@huawei.com" <haijie1@huawei.com>
Subject: Re: [PATCH v2] app/testpmd: fix VLAN header parsing
Thread-Topic: [PATCH v2] app/testpmd: fix VLAN header parsing
Thread-Index: AQHbnJnkEuAP/W1w7kKEo5NXIqQSVrOB/jwAgAAJ3aw=
Date: Mon, 24 Mar 2025 09:40:40 +0000
Message-ID: <CH3PR12MB84609D51CB1C8A9B3EE5EA66CFA42@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250323122822.90407-1-rasland@nvidia.com>
 <20250324085023.23721-1-rasland@nvidia.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB4A@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FB4A@smartserver.smartshare.dk>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|MN2PR12MB4271:EE_
x-ms-office365-filtering-correlation-id: b53a6c6b-5c71-4ffb-f83c-08dd6ab7f09d
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?j/b7rH0IPnkPW3Y8g+ESbeTwL4kK0i2WdRVOuAL+z6bdRh6GsMps6n/r?=
 =?Windows-1252?Q?v3ZFrkO5HHSuS13T6essJcboGzoiUsCFWPWn02hTx1MvJSua1o0osNWd?=
 =?Windows-1252?Q?FiYxQjzJG2/bCpdUg0gXx3TDLJP9QLQTeamEQJ6pLFrqb2WV7ogF8Q67?=
 =?Windows-1252?Q?f1taWxD8W8gS9Q94hQB996QAnHoQo7YyVxZxeNVdjp0yfIDS2hC6NJb5?=
 =?Windows-1252?Q?i6aM+S8L2Q+40JLKimdfPdBxU7wbB/LbzfsSkA42MI2d3dLg6nNPljQC?=
 =?Windows-1252?Q?4bpDGwW5k+fNtogmEr/kKXIGCT6/sq6KwsRNwu7EDVp7T78Mfn7cJWRR?=
 =?Windows-1252?Q?CXZxmmzSNPU0CzRagEwTFHdRu5G+Gj60GR/XW9P+iOhUygFJ8I2N1sOK?=
 =?Windows-1252?Q?9H7cSCnVapwsNKmgjUy2oYNHnxjVjYcqjN9FPE2mJWk3ien0yxUFkzU+?=
 =?Windows-1252?Q?RXZWaWHFZtPoUZDZIyQXuYzrr9IfNm+dtX44YGfn/2hjXvuw5aitZNe+?=
 =?Windows-1252?Q?3/y64frrp3zAL7mjawjwrKKE7XiJCMg6PWuWv2chLgewpzpMUElXeKv5?=
 =?Windows-1252?Q?4cP7p1jVTYoGBlWjQo2Kq2hNkk29zz0AwUJF55Wpfn/oiLKPjt2pfB99?=
 =?Windows-1252?Q?Rgw8bDTTfufs4VwKxnwmKKTlrV0xkWvNvfT4EgGda6ztLhKYY9wDaLy5?=
 =?Windows-1252?Q?Vdbjli1/WbDJn0oTEAU/4I1AocvqWmdzTSDJ3bbitdKDWBC4EFHAvrqC?=
 =?Windows-1252?Q?HGKEzJEFWjUE0htOzFAcPToZWVkhtW87bZS5wcjeG+I+vw1WN1SG5JDW?=
 =?Windows-1252?Q?HjkjZc66l1/JEWCtIzeja8U12ZjRmaVREW5V7HzVPt7BCB2+4aKLpM/r?=
 =?Windows-1252?Q?eNcPVPN8APHZd/kkd2E1/WTzGTvOF242S73m/ITD6HQMwe56S6BJMf2L?=
 =?Windows-1252?Q?JwDMswdktpxWMYTFH/ry/I7CX1l0qUplNvXrIbfVLi1ae0MuwqgdUHVn?=
 =?Windows-1252?Q?M0HWKmV5FNzsHJadmJYx6J8g3Qqdbighq6z/QnNdpmzhCPAR2Q1v8iZA?=
 =?Windows-1252?Q?KNRqoSpduA1Tnay4NMxx/uWpA8Ntz2SBzBsCSpWoFyI+YNZj+GNNRJh9?=
 =?Windows-1252?Q?P35p1lkfqIAxe+FMUoiVa4yQFhegm3rzBL6tZaOXtC4Wg3M+bM9NMaqd?=
 =?Windows-1252?Q?Dag3cC3cKffE/SKYEYd55b6VjiZNI80zOfhNwKWDXCGqBjLUk3kBOeNH?=
 =?Windows-1252?Q?J6uNox3HDN3GVwt5e+fHAuUbARmqInkhwGh4owbK464sGAnTlvy4+kyM?=
 =?Windows-1252?Q?3zNcFpBrVxjzVYgUgxW27UotNCJAzFJDyypd9GYzDnJhHigBQobmhRxn?=
 =?Windows-1252?Q?OiPJVy6l346lxpS0QMiqteCgPex5DTrkFr51PvjC+pY6AuPjm9OA+oX3?=
 =?Windows-1252?Q?h/W36oR87WKPcHd1pnkMUloi/KckzZlI4GqyrXWEhyBXKJBMEyZmQHja?=
 =?Windows-1252?Q?uOyN+XpCGEY+3JxND0PxcEDayHJEtJrOyFMfpz2yOIs7t4FZ/12gRCr/?=
 =?Windows-1252?Q?v/dR9OWOtZwoHWAM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?NMRTLgGiX4fMvvRSsRp7cd14WRniFxKqKEPWJBUiqtvhIKLidWYYP+hQ?=
 =?Windows-1252?Q?n/DOxWf5rOwPLV0EWqFxzXIy9NCFDhCtGRasLYOlfffHOIpsuhFUKMHc?=
 =?Windows-1252?Q?V8d2PpSZlXPbPJZrOkQ1RyE0nT1yH6O8Y48QAlbcJs7rV+rPdBeM4q9h?=
 =?Windows-1252?Q?heyIAvus0tOSYjkLU6DTpJ/0dy3M++bLy4+PZXe2BSQ2phiZPGnqii7B?=
 =?Windows-1252?Q?spMOBglU7/+BisSqcHouYbWTBsjZLQw5CubAuLAUSz+5/YPPnMMV7pCn?=
 =?Windows-1252?Q?K8RsafxR+azQDVJkHYM2fCVKvFeAmPYePUGWqvUIewi4Lu7I+1AvAOT9?=
 =?Windows-1252?Q?KbbJLpNfqjxPbUFhxpPjThZ/Ru3QrjMVXPglU2orJ5TBFA9gbKcx8nTM?=
 =?Windows-1252?Q?41ZpUIZdYr4wNm8uMUFltzTEBMIT+sv/A5g5SsCXr2ft6RzTrkZD9HcS?=
 =?Windows-1252?Q?yhIsHdm3YyphhTV8VQgb5+QlZ7+LWUQJrZ2p03e2cymkQoc7ieTcx63L?=
 =?Windows-1252?Q?VUK3r0eWI4b/bnQrAlM9OOMjH/C0daQ3gaYdy+2nXGCVJc9F3N+KJByc?=
 =?Windows-1252?Q?YJmlmPAZHU34Y6bP89rw0frQX81y0nidRnnpclIrxsTxB6fBfcfVJ8j5?=
 =?Windows-1252?Q?0VwYbLSA7s2bPlEY0E2CCMuRo+YpeEID3MXXNG7uzkb1TRyc4W/cWYAz?=
 =?Windows-1252?Q?nT4tZwU8IoRz+cnsaWkwX2SUgTp2ciAKNAO+RoUTtMrN36MWXCzRZz4n?=
 =?Windows-1252?Q?bTtFXabx/oTYz9YXdI683wO9PiFmyeafbZPVROELQc3RnebP1whMqJ2r?=
 =?Windows-1252?Q?0s90wIN5jMivrmmoeYiZ4Q4I7iQ4Q/1j+xWiVdGK1piUduE8fkA8UirW?=
 =?Windows-1252?Q?pwNCdEnlxTdHEycESTA1X747PeEZeK84RdmECACh2RQChR/o6Strg4aw?=
 =?Windows-1252?Q?SlsVTg4HqiqKrIq4CurG0lxswYfPrOJU7tBjVRqrd3tleOy5pOXrmsM2?=
 =?Windows-1252?Q?tXmYeCbYpniNVBcija2phq2uFN0dM1ZO2dW1qCKHHpIeg9Hg9BX63CT4?=
 =?Windows-1252?Q?lsi1JWXwdX4RdkdwN3A+mk+r/16ZmOt7m4wgbpPOlW5KXeuZ7sFXZ240?=
 =?Windows-1252?Q?M1SsBMixe1y/SZyY64l3yygUbsWGpGvIiUDXqYLw8U6WUQkfbinLbphm?=
 =?Windows-1252?Q?sQl021+JglnuolbcdPLUkfBZzQUlLWPWN66z2qzwwLatTVxddEsJuXb+?=
 =?Windows-1252?Q?NwFMx9kWCQ7VGpxkcWORoJmSDcEWcUhrcsRyN7COWDBGSYGnci+O1nGR?=
 =?Windows-1252?Q?Kp1LjOmQYl2bqMqnn45gAjWFmb7KsokKUoLCokqtEiweSI+Z3EMaWrlJ?=
 =?Windows-1252?Q?NQ67P9XsivP8srM/4c9M9JgcXx3IZArh18KMt38KmPp2NFF2tb4qbrPO?=
 =?Windows-1252?Q?4W4n2vBJck9Eq4FgEQVA5GMXKT7uc5kkIOrzbZvcFGt1/s5gcAYEyqDr?=
 =?Windows-1252?Q?bLDrtvbqaa5mt6gTs54sOfOCsEI0pwjzXfy97q4oGm1xKCOMSKGyE7GZ?=
 =?Windows-1252?Q?PyZfTO92/pFVR0kEyS/jc0rSPbj6hF0dNck7ToS1+SvaHbwe1qdyPN9p?=
 =?Windows-1252?Q?f9wKbL7qCseDQ2xULjRlk5OyQSoy7XO5D43m1LK4cEekdpNSoD1x8mrd?=
 =?Windows-1252?Q?dpagTLjlpXY1XiAyefVd7CauppLEkbSm8wwG0QQOcNVK2+vRK6K/XA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH3PR12MB84609D51CB1C8A9B3EE5EA66CFA42CH3PR12MB8460namp_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53a6c6b-5c71-4ffb-f83c-08dd6ab7f09d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 09:40:40.4586 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /BUcoAYmdcHGVgJ1K8rNFjEbGFjanWgsmHT9zxmCe+NnFZgqF1uFZWbt1JDv9njqK9B21boa/5yidA6SGa6zeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271
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

--_000_CH3PR12MB84609D51CB1C8A9B3EE5EA66CFA42CH3PR12MB8460namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

>> -                     eth_hdr->ether_type =3D=3D _htons(RTE_ETHER_TYPE_Q=
INQ)) {
>> -                     vlan_hdr =3D (struct rte_vlan_hdr *)
>> -                             ((char *)eth_hdr + sizeof(*eth_hdr));
>> +             vlan_hdr =3D (struct rte_vlan_hdr *) RTE_PTR_ADD(eth_hdr,
>> +                              offsetof(struct rte_ether_hdr, ether_type=
));
>> +             while ((ethertype =3D=3D _htons(RTE_ETHER_TYPE_VLAN) ||
>> +                     ethertype =3D=3D _htons(RTE_ETHER_TYPE_QINQ))) {

>Two details:
>1. Lines continuing on the next line must be indented by two TABs.
>2. Please add the boundary check, as requested by Stephen. (I realize this=
 mail may have crossed my response arguing why it is required.)

Sure, I=92ve sent a V3 having these fixed thanks for your review and commen=
ts.

>> +                     vlan_hdr++;
>>                        ethertype =3D vlan_hdr->eth_proto;
>>                }
>>                return ethertype;
>> --
>> 2.39.5 (Apple Git-154)

--_000_CH3PR12MB84609D51CB1C8A9B3EE5EA66CFA42CH3PR12MB8460namp_
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
<body lang=3D"en-PS" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<div id=3D"mail-editor-reference-message-container">
<div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-size:11.0pt">&gt;</span><span style=3D"font-size:11.0pt">&gt;=
 -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_hdr-&gt;ether_type =3D=
=3D _htons(RTE_ETHER_TYPE_QINQ)) {<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 vlan_hdr =3D (struct rte_vlan_hdr *)<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((char *)eth_hdr + sizeof(=
*eth_hdr));<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; vlan_hdr =3D (struct rte_vlan_hdr *) RTE_PTR_AD=
D(eth_hdr,<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offsetof(struct rte_=
ether_hdr, ether_type));<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; while ((ethertype =3D=3D _htons(RTE_ETHER_TYPE_=
VLAN) ||<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ethertype =3D=3D _htons(RTE_ETHER_TYPE_QINQ))) {<br>
<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">Two details:<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">1. Lines continuing on the next line must be indent=
ed by two TABs.<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">2. Please add the boundary check, as requested by S=
tephen. (I realize this mail may have crossed my response arguing why it is=
 required.)<br>
<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p></o:p></span></=
p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-size:11.0pt">Sure, I=92ve sent a V3 having these fixed thanks=
 for your review and comments.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 vlan_hdr++;<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ethertype =3D vlan_hdr-&gt;eth_proto;<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ethertype;<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; --<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; 2.39.5 (Apple Git-154)<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CH3PR12MB84609D51CB1C8A9B3EE5EA66CFA42CH3PR12MB8460namp_--
