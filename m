Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374EEC36008
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 07:37:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 215A7402E5;
	Mon, 24 Mar 2025 08:37:18 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by mails.dpdk.org (Postfix) with ESMTP id 66D3340151
 for <dev@dpdk.org>; Mon, 24 Mar 2025 08:37:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmM2Iu6Ut1tEQnhBW67fZof5cYzwTVi9VXVZ2lmhfv2ilnimW5BPdb5YZIBdeU7L/iYSiJenRMQtwQjH3nOxNbhQ6SwgGxMNxf9xCNSmn23/+IEw0BQsJhSQMZ7gfQEIAm8tLVYrvVEFAibXnixd4nwto2ZpxkBZ/zP+zoJzp2uHvuHYO7a1Yc0eePExpvmDKrjd7YGpxK2HV/nWQJv4rbe369S2UZMUSQjXI/lp0hBCesE9JKERGtUT164Fi9iPK5IS1uoXtF1YV5QdwRqeg8gNpKfUz820rm4mK2Lj+8uG0i8aquvKJp6WBqmehd5ENYoxGziSdoiFWhbBcGkzQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5xjKpYBwymNHHs95Y8zcKIJzfzSwnpyCFKcLsS+hhU=;
 b=MC7Szbnso7svq+/rJ28IY87521ak5YF5lh48MZoqteBXgzD3S0mCNPHpRbEJ8fH/BCkFDsLDbMatWT/cQoCN1KKyn/leyX6SFBUjMdWY+YSh7bIXxp6Lv0sbuES46Hzh/0kh8wlc4o/vixJoJgdnR9CAnD6OYu5m+7dUndnO5JfFArZLTSGFT2rZycviO0860CKgIKxVYVMeLQL9iSAMt3OnReqw8JA8Umx98a8ISjZELVYL5AVPAIm2tMVGpOKqj6nzSmIxR3+WU9KM9oRQWG4Zh8AjKvJRfwhxbTQK6+gNKcjvm3Wg187lxqZZEMgAkzGBotyrtEzaz1GtTxiJ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5xjKpYBwymNHHs95Y8zcKIJzfzSwnpyCFKcLsS+hhU=;
 b=CdTEsRuWfFdYTPl6rxmpsrSLfB3qeuKzVw0xG5TRFMcBvCU2WjH92GEJyOnB9cKjfFch13e3OwFai+VK9MoHt7nBzFPMBY9cbhVVys7rVjPbPDTqWptGyvmfUKB856I3fYfBkCmsx09bSYT8eO/W2uE1EACGXHpin/vICOGoN1eFf8275OO91OmGjbvwMBcy6Mn7L64mh7dDKRE+ts0W9IvqB3lvXYyX3MQ7+EloQ+PUaFWA23OcofohtcmOnqJ/sEVwWMm2b5XZxFhTrf2ix8akxllnnk84FpiAztqpOkCaJAOYPwsUKKN2P3nZ0Uf1hgANFwzrVHwSR/dWP2DSzA==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 07:37:13 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 07:37:13 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>,
 "dev@dpdk.org" <dev@dpdk.org>, "haijie1@huawei.com" <haijie1@huawei.com>
Subject: Re: [PATCH] app/testpmd: fix VLAN header parsing
Thread-Topic: [PATCH] app/testpmd: fix VLAN header parsing
Thread-Index: AQHbm+8qBy++gaakq0m8DcV6iO248LOA4YoAgAEFOSY=
Date: Mon, 24 Mar 2025 07:37:13 +0000
Message-ID: <CH3PR12MB8460CCD964AC2680AAA9F2FFCFA42@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250323122822.90407-1-rasland@nvidia.com>
 <20250323090032.06d6aa45@hermes.local>
In-Reply-To: <20250323090032.06d6aa45@hermes.local>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|SJ2PR12MB7799:EE_
x-ms-office365-filtering-correlation-id: 3fe25019-668e-4151-d297-08dd6aa6b1a0
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?+C2Kj0aZi48sYn1LLUUMoxnsYfdPvxvG14pvkJb5asXrNY1l4W4/GDnH?=
 =?Windows-1252?Q?ke9Tj2tGtMgWvjE+W6BGpxJbdpZMzU3WlQxa+vVhmwBwio8DthJRLhyw?=
 =?Windows-1252?Q?clOymVFy7zlsa1+q7yo07TNlDGWfw6f89EKaPpLcceV6FFSikw4Bfkm+?=
 =?Windows-1252?Q?YSje5pvndnPrkNOoQ3usoRjPiqOMhV6FAhWSab7OQPbkdaKPIhmu9uVg?=
 =?Windows-1252?Q?gEduyQ8PldcurlkkyhCq0sJwTeawt1sj88kbh2va6dH2WBgJvpGVzuy1?=
 =?Windows-1252?Q?/xK4KY1qbvpFm3jsx+SWDO7Q3bm9sNn8wQV3bmghb82zZ/vOcbsx2KtZ?=
 =?Windows-1252?Q?oNmpLhSj6j2r1Qqx/XfmNz+pR+8tQ0/lv+K8qmlpDCbpFe5Ji1gN8kl/?=
 =?Windows-1252?Q?P0V6ME91YDhwKgPKrzeKaj1Qo4+92NRbrjXu3p8JNwJcekepou6lJRTH?=
 =?Windows-1252?Q?S/9CwR1l8PHFt+Y4GiyR1bYRMCWyIZK6/QiINeoEyOhQ5RwUkLow5QUX?=
 =?Windows-1252?Q?tQXeQUbNd3MCZPnz6Q7ml/5sRZBkrY15895gsQE762Xd6oOqggHPjOKY?=
 =?Windows-1252?Q?XFJHdoe5S5u4lp3ouoAurHBXS1YM243hj1qlANxv8wGwnVGWf5zovuup?=
 =?Windows-1252?Q?sOY1yajlBAaiZzulZuZ/Mt/Rn+kVF6dN/Nw2aGapIPfFOSVuQ+5qBjE0?=
 =?Windows-1252?Q?O/+bUNIIC/uQfTGevUZzJ7bzv69mjWBy5r1qMfbQNLubyJNxKHtFf70Q?=
 =?Windows-1252?Q?4phs5Ua8vUbOYMibMv8M43Bb47P7MeY2nsfoXRp9qLhaVURW6GW7Bsen?=
 =?Windows-1252?Q?tLXTX7vHWoGOLPcV5wlnD/XI4JOOXPdzVjnMZQkFomHyKmGjWoSEvxwY?=
 =?Windows-1252?Q?NE3QW9xIXekyTw+XFmWG+3mHhQxt74axAzIUf/mX98/ejeU6TSeZfkxX?=
 =?Windows-1252?Q?T86jfZ+alGVlskac2yWByAquT92utcKiP0R8OKXurj64bkBxipFPVErm?=
 =?Windows-1252?Q?ihAiIJNpLA9PaSwyr5cwOdrYR8zqpIKq4RzHamTOuIjMreNA1EtU5M6z?=
 =?Windows-1252?Q?fL8x/m6ndXH6p+ogoO5mROKuDWxmzA0l9ZZQtdj7hQZ1K2smjstQFW/e?=
 =?Windows-1252?Q?i5BSXZ8+pF8Rot3CBQGJMe1Okv6EEOghi4IpIKtlAnFylvFWXzir62Mw?=
 =?Windows-1252?Q?p8cs7Vgb9I5gC5w/dz23EDa7AIqN2LjuzHsrqhWVfsKuhvRMCJmivx9F?=
 =?Windows-1252?Q?/cJm9mZIxnw/K7TfjC5YyspmWZVUdMlaaXsfFNIMtBvU6rEnDtNptv0B?=
 =?Windows-1252?Q?HpMSu1ZXFB17h77aTOr93ft+oKC+sXTpzw2MVq8hqe1AEwdIMdIjFwLW?=
 =?Windows-1252?Q?lpwHVO2tKavx1DQwkJVCMXHTjETx2ipJLg5lvxcKlmWw78pxA/QslzA0?=
 =?Windows-1252?Q?v1qYmVrraF8YDdDlymes3RaVGBQPtr3T7qXQjPBvAaNKkSlLy55H2jgC?=
 =?Windows-1252?Q?MuyHY4lvRq/VMx9gUA+U3PJOo1rCh34s3gHRw2r7zrDDZ7v7v/ycbgvl?=
 =?Windows-1252?Q?Uwbsv9PdFu5jN4EZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?mWuH9LQxuhZosBgTSkH1XPBLEQ8Iz7tgq1FpJ/orvUAw6QJt3UCrx8oX?=
 =?Windows-1252?Q?SXvBiTSb0rNnkZzKwKQiV2sDTazUy+K7k7UiqjQkVCyTk8fcpxIjbXVy?=
 =?Windows-1252?Q?mv/Q2QDmYzGNzOFyb2gpY1e1C6fcKsKXWhBUK9ByGs/HqW//BtqimJMv?=
 =?Windows-1252?Q?b6s7aUKKk7Vm3eXsfZgHMQFJXrKxa0LkGjdSK8RRqJzcca2cjN1G6Ff5?=
 =?Windows-1252?Q?CKSHMWN1cQRRKOIcya42JT/nu6IjeP32ULsQ78LQOgW7DUzLN+87FnPn?=
 =?Windows-1252?Q?XjbLuWlDyQt4wRXqCEMsHGjLI8rCU1SRofj04KdEyWHH8JcFR91zJJ2N?=
 =?Windows-1252?Q?M3JN+aQ+hegoxq3FVvRzwJ7zoA408NUdZ2dZipp2zS9HhSbGIuq5xV3y?=
 =?Windows-1252?Q?34sb92xhppmOEmQv6a6pyvdUFfx32uhXWQUrPJ+zqWdyATuPttEfL16t?=
 =?Windows-1252?Q?t1vsBE4xgRuM/5KXK9O+D5oOI34+qhWYP9H6SOM2wEWPDaJ35MgEnHyo?=
 =?Windows-1252?Q?OnJQlxPL6/XLZhTakvm64pvMgSQTvSmcAACoViHC8hAMA3WPHqRG+1bp?=
 =?Windows-1252?Q?csS6FhzjLfEj5MylLITXcP1u/a5Cc1Mi8wjSsJ47ErwtOEuNq6V5BuV0?=
 =?Windows-1252?Q?wTf3OfufVY+QT8uFOHyCN/gDivrboL0tFgQxQEGtaejfav2RzXRVZvJc?=
 =?Windows-1252?Q?TJa7F47ulEIigsoEeZfYuvLgmQu2mjZoxMcZPEV1LQbjMAmhvxb3Z0It?=
 =?Windows-1252?Q?9si1R/aJz8cgjYASJnXMjQqV2G6nZFi7Yi0OpdfEP4lywdNITfDFijxA?=
 =?Windows-1252?Q?YfJsJVVK38Y+vpo9PAefkgMgmIRmSty8OJ3Zg885HqOiVc9uJrIen/t1?=
 =?Windows-1252?Q?KaW2OtSZ5SC9LDhmV2275P1FG3TB3cf2Jlqpq/9qwyn9gcfPJQ3OMcpl?=
 =?Windows-1252?Q?ZwKGhvLPLn/c9X2pMJ6liWb15wb/45ZBaUiLeIcNaxHE9e5nohcmVz1J?=
 =?Windows-1252?Q?gxE376sbjNhMAwdiC7eiSEuv9hN7Je7EOIxMgkF3UyQnzh8rP0IQU5ov?=
 =?Windows-1252?Q?lYHeiWSDocZXuq4VaBMeo3M8sg7YfTQ9nHxPee3dsYWLnwH90rYI/z/s?=
 =?Windows-1252?Q?N3ULd0zvY5BRzdeGaPZJO+jQOsUSXZPZv8zTnyrNi+rphmbILoBAjMJY?=
 =?Windows-1252?Q?QmIWJSk/9HdcWIEx0tRU8jcSgj3U97aHZREgzg/eereC266+GX5LBdF+?=
 =?Windows-1252?Q?iTAxgwkm2XAGUcJZfrSbTrpIfWqqDy3LdcFRg9J7/VeEFXntycLz1R4J?=
 =?Windows-1252?Q?CBzWSO2UksyMq9L2VMnwggINtPnUiXls2FE6+0UefG/AOh5cpbcuropR?=
 =?Windows-1252?Q?5AqV0wxKqMQYJeqzdupi99iIEMxR84Di8WuvLCLoNcjQjejBqoiRbTJK?=
 =?Windows-1252?Q?ohztECy87jJKUQ0+4f/c5gR9jWUD+YVFvvWRV4dvBG5IxaJI/VpmeByU?=
 =?Windows-1252?Q?ON9OCIkoXHurL1j0JbDC0rO0VjjTbszbeBR+uCfyhIli3VeB6oKjpTcJ?=
 =?Windows-1252?Q?88g/dBcL7hXD3sw5OIxgLa23HDhM6aUp/tyF8b95wS+gv4YGukbeAgOR?=
 =?Windows-1252?Q?iv7OtEC/QUlentj0TXB3y2Pc45dlRB+YpJ2tP0kfHfBvuZeVTzVQO0uC?=
 =?Windows-1252?Q?5ZShfalbG+V1+1SSi80Nqr4Ff72vY0bOczBGiOH9tw2EgAfKJ4cfGA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH3PR12MB8460CCD964AC2680AAA9F2FFCFA42CH3PR12MB8460namp_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe25019-668e-4151-d297-08dd6aa6b1a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 07:37:13.3599 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7y14dYhlBT4/oRSYcNbfHhiwASzClKDmwou7fgfgJdJspUymnFlTrhU5ketjf1UMaFykdeC/RI8jgKSeRDJDaw==
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

--_000_CH3PR12MB8460CCD964AC2680AAA9F2FFCFA42CH3PR12MB8460namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable


>> Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>
>> ---
>>  app/test-pmd/csumonly.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
>> index 5b906eaa53..302cc4cc66 100644
>> --- a/app/test-pmd/csumonly.c
>> +++ b/app/test-pmd/csumonly.c
>> @@ -468,6 +468,7 @@ get_ethertype_by_ptype(struct rte_ether_hdr *eth_hdr=
, uint32_t ptype)
>>  {
>>        struct rte_vlan_hdr *vlan_hdr;
>>        uint16_t ethertype;
>> +     uint32_t i =3D 0;
>>
>>        switch (ptype) {
>>        case RTE_PTYPE_L3_IPV4:
>> @@ -486,10 +487,11 @@ get_ethertype_by_ptype(struct rte_ether_hdr *eth_h=
dr, uint32_t ptype)
>>                return _htons(RTE_ETHER_TYPE_IPV6);
>>        default:
>>                ethertype =3D eth_hdr->ether_type;
>> -             while (eth_hdr->ether_type =3D=3D _htons(RTE_ETHER_TYPE_VL=
AN) ||
>> -                     eth_hdr->ether_type =3D=3D _htons(RTE_ETHER_TYPE_Q=
INQ)) {
>> +             while (ethertype =3D=3D _htons(RTE_ETHER_TYPE_VLAN) ||
>> +                     ethertype =3D=3D _htons(RTE_ETHER_TYPE_QINQ)) {
>>                        vlan_hdr =3D (struct rte_vlan_hdr *)
>> -                             ((char *)eth_hdr + sizeof(*eth_hdr));
v> +                             ((char *)eth_hdr + sizeof(*eth_hdr) +
v> +                             (i * sizeof(struct rte_vlan_hdr)));
>>                        ethertype =3D vlan_hdr->eth_proto;
>>                }
>>                return ethertype;

>A loop like this is prone to getting attacked with a malicious packet.
>You should cut it off after a few vlan headers.
>Also. what if packet is truncated, shouldn't be reading past end of data.
>And what if packet is fragmented, you need to use rte_pktmbuf_read()
I=92m trying to fix the current loop not really changing the logic, and I=
=92m not sure we handled these cases originally.
If needed, we can issue a separate patch for fixing these cases.

Kindest regards
Raslan Darawsheh

--_000_CH3PR12MB8460CCD964AC2680AAA9F2FFCFA42CH3PR12MB8460namp_
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
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; Signed-off-by: Raslan Darawsheh &lt;rasland@nv=
idia.com&gt;<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; ---<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp; app/test-pmd/csumonly.c | 8 +++++---<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp; 1 file changed, 5 insertions(+), 3 delet=
ions(-)<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;
<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; diff --git a/app/test-pmd/csumonly.c b/app/tes=
t-pmd/csumonly.c<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; index 5b906eaa53..302cc4cc66 100644<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; --- a/app/test-pmd/csumonly.c<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; +++ b/app/test-pmd/csumonly.c<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; @@ -468,6 +468,7 @@ get_ethertype_by_ptype(str=
uct rte_ether_hdr *eth_hdr, uint32_t ptype)<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp; {<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct rte_vlan_hdr *vlan_hdr;<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
16_t ethertype;<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0;<br=
>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp;
<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; swit=
ch (ptype) {<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=
 RTE_PTYPE_L3_IPV4:<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; @@ -486,10 +487,11 @@ get_ethertype_by_ptype(s=
truct rte_ether_hdr *eth_hdr, uint32_t ptype)<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return _htons(RTE_ETHER_TYPE_IP=
V6);<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; defa=
ult:<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ethertype =3D eth_hdr-&gt;ether=
_type;<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; while (eth_hdr-&gt;ether_type =3D=3D _htons(RTE=
_ETHER_TYPE_VLAN) ||<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 eth_hdr-&gt;ether_type =3D=3D _htons(RTE_ETHER_TYPE_QINQ)) {<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; while (ethertype =3D=3D _htons(RTE_ETHER_TYPE_V=
LAN) ||<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ethertype =3D=3D _htons(RTE_ETHER_TYPE_QINQ)) {<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; vlan_hdr =3D (struct rte_vlan_hdr *)<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((char *)eth_hdr + sizeof(=
*eth_hdr));<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">v</span><span style=
=3D"font-size:11.0pt">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((char *)eth_hdr + sizeof(*e=
th_hdr) +<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">v</span><span style=
=3D"font-size:11.0pt">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (i * sizeof(struct rte_vlan_=
hdr)));<br>
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
<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">A loop like this is prone to getting attacked with =
a malicious packet.<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">You should cut it off after a few vlan headers.<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">Also. what if packet is truncated, shouldn't be rea=
ding past end of data.<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">And what if packet is fragmented, you need to use r=
te_pktmbuf_read()</span><span lang=3D"EN-US" style=3D"font-size:11.0pt"><br=
>
I=92m trying to fix the current loop not really changing the logic, and I=
=92m not sure we handled these cases originally.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">If n=
eeded, we can issue a separate patch for fixing these cases.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Kind=
est regards<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Rasl=
an Darawsheh<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CH3PR12MB8460CCD964AC2680AAA9F2FFCFA42CH3PR12MB8460namp_--
