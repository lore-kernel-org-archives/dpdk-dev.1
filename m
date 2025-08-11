Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B0EC87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 14:44:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13EE940DDB;
	Mon, 11 Aug 2025 16:44:55 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by mails.dpdk.org (Postfix) with ESMTP id B77CF402AC
 for <dev@dpdk.org>; Mon, 11 Aug 2025 16:44:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeSO/leEn3sYJqNLmWsHA2oeS4rWSXs5HG+pErxd/CMe9CBm+bb21UbNc0gM1/4paGG0vtkOfgWTV11xpA/Famtb5yuEE19uVRUWSZSSJTeuabVYmwcQjIdEfif8DwRLV1uAck38MUl0f6dOsKTCs9flnBBnTk31jz8TwaCx0z2S4hSs49NjvuLQFqilHmftu9sR8zhlQERS68exyYoYfBsfOVlWVWdDYlYbgLjscBPdFHBIMDaX1hOR2kmti62o5etp7rCEJdNf1JygNIhpe4hqj4+Rf9bLsEYgZ2HZuhjtsWLThN3zPQi1OVhmuKUJYDFIUxuMgSqfOeEN4yYirA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nXde1tqFK51whl7ol7FYnFBG/9K0Zlw+y/mDLIJXVQ=;
 b=Ng3CRypb4sGMJ0fNKC4KdLzygOIiYf496zFBFkYBAtPHKzAPe+WxiWigdS8hguBzhdw2t2aR7tRFDCKjc1U1LkosYIhZFe8DMuE1QttYE+PL3UuXkj8nqvuz5cBK+G1VxEDUc7+jOjDiVOKAQDuAF2D6T2jxoLEERr4qcXt2Zx2YhHPuWt2MErPAIzS4JpNs7Wrezc8+XSq/QTJk6K0QA3yjHMK2eonS2XQ1be7jw7GG3j+nUrWRhlXBVho5ZBkT4hy4iYwukcocG+xnff0W2mY6TCGAl09cjjyOrPkn/br7yXYf7Sv2o2Q8E1Ov9YhT4/SM7g+kuAjgCHnD5KzTkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nXde1tqFK51whl7ol7FYnFBG/9K0Zlw+y/mDLIJXVQ=;
 b=um5pvzYaJC2vO7zVR72ERrw/rrdPoiKZSEdQvENv4dXoVO/iUJ9Zv4fsIEHx9CNUyclWwDRx4nOsWL0CPSxb+JlCF5lPdxtDtaI3Gzd8AdUhN9V1e8G2AOf6f4rrYR1AHID0pLEMYEjLlf2B9r+QtEKe7pnfMb5/d8XZm4e/9TA=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by BN5PR12MB9462.namprd12.prod.outlook.com (2603:10b6:408:2ac::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Mon, 11 Aug
 2025 14:44:51 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%2]) with mapi id 15.20.9009.013; Mon, 11 Aug 2025
 14:44:50 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
CC: Stephen Hemminger <stephen@networkplumber.org>, "thomas@monjalon.net"
 <thomas@monjalon.net>, "Yigit, Ferruh" <Ferruh.Yigit@amd.com>,
 "andrew.rybchenko@oktetlabs.ru" <andrew.rybchenko@oktetlabs.ru>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v7] app/testpmd: monitor state of primary process when
 using secondary
Thread-Topic: [PATCH v7] app/testpmd: monitor state of primary process when
 using secondary
Thread-Index: AQHcBTOmTMs4cZesWkSBbj/ohPqRp7RYGXxwgAArOwCAAFY/MIAAD4mAgABTxwCABE1voIAADCgAgAABZ3CAAAoKgIAALdJA
Date: Mon, 11 Aug 2025 14:44:50 +0000
Message-ID: <PH7PR12MB8596AF79DA967DCA9B68FF498228A@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <PH7PR12MB85968E4B05D92C12C963F1E2822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <20250808114909.1606758-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250808094900.5027f034@hermes.local>
 <PH7PR12MB8596C293ACF92D446DBD10508228A@PH7PR12MB8596.namprd12.prod.outlook.com>
 <CA++2-x4i2OegW0u2a6AJepCFgqjLbwzqdw+es3BqrABgqM7FZg@mail.gmail.com>
 <PH7PR12MB85965BF756C6D234FB8714068228A@PH7PR12MB8596.namprd12.prod.outlook.com>
 <CA++2-x5FZSB56rrVLU96hSosLGHybQWPFPo3VPe=y8YHZBhfqA@mail.gmail.com>
In-Reply-To: <CA++2-x5FZSB56rrVLU96hSosLGHybQWPFPo3VPe=y8YHZBhfqA@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-11T14:41:16.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|BN5PR12MB9462:EE_
x-ms-office365-filtering-correlation-id: a83455c3-a9c1-429d-3e2e-08ddd8e5a085
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?V4jIP/CfXYuZTa6CxJnujZQfC6XHagaZS4ElhMAGSMcO9AooJHpBmuP6MPKE?=
 =?us-ascii?Q?hZ2LhMcU34nCXxDf37FuvncMWh1yiiQ6zsYDAzD6uKa+E4te0CioNq5LQJ/E?=
 =?us-ascii?Q?vtiRV5NkI69u7zV5gJL7Gj/gRsH8g+sKLJIpkc1NuaBInbo8GEFrdwxXHlru?=
 =?us-ascii?Q?tCjBo4aYpE0Mdie2b2YBLW1CYhrjs4CoZaNF+qQPeXLDOXh5V7c4liv3jqLh?=
 =?us-ascii?Q?IsmY1cNJqf+S1TO1f9lRVZb/e1XoSxw55fbKx2zDApdVoGwhxcLUh3NfYKa7?=
 =?us-ascii?Q?hK7fFUCcDVb0kS4ANtk7yCObJejLs4MvQgq83UCb8Ad9cstUnF5ZqDrBkkWI?=
 =?us-ascii?Q?K8Fkp4FCTMfzndDl2yTljQw8mmk1idSqnPV1BHnhK3Ke6rYP0lnu315UR5o1?=
 =?us-ascii?Q?NqLgYI099upU5Azdjd0e+53qk1IhurB4bGsGOjM0rOMaLjxBafKyNAQZD9mK?=
 =?us-ascii?Q?FA4E3mkc1KyJ/4z0LS5JvolSbj9KhxsPfHWCeKrt2MRORU7bh3HJw5z6lo2u?=
 =?us-ascii?Q?sy0IqVKP9keZKbYBXjxYCNCftqR3nbDcug2rNSUzOdqU8LNgXEVhffFyJx2o?=
 =?us-ascii?Q?oSUISK35qc4GVZsR4aUVuk7GhfXO61Ee2lkOrKviB/ccZDDFYy1MRkhB9jjK?=
 =?us-ascii?Q?cu7sjQwwSeJZD9qEnkWw1SP8q4YuET0+t3sA/oNb654tOflQmvy+BzCo3ng7?=
 =?us-ascii?Q?aaTz6j6OS4JdlfqEaokFrD+npHpmN3AYSksASdpUTLr0JxTyTctZPBpFtMay?=
 =?us-ascii?Q?77J9WbLlAoO/hpWWOJI7XuFUU56oexcdDXe2Hs4yK/RukRDsxFJRtGlP7CGZ?=
 =?us-ascii?Q?J7hR58aGyz8SxT6gMia4p8R8rzj9I5ADYMtkxQFp1uNROOWn/XZwQ9nlWvGn?=
 =?us-ascii?Q?izGEwJwzMsdImJBTodvzCGRC0x+AwG5+XVnsnK4gRIpI6PIoEhP78LpcP/5a?=
 =?us-ascii?Q?K4t3eC/FikOfOSE7Q7WYXCNKukSbJnPpZfFRRRwBjwxjGjZzcaqZPxdWgfAJ?=
 =?us-ascii?Q?3sJD7hB9+meiaOG8ObWlJbkPutw7NC/NdrCqJBzgRE+6T82Tnm+ABwqy7HJy?=
 =?us-ascii?Q?lI+j4/mhkNnscvpEdmCZGYbIY00ApeHw12PhjrfZ4hKdZoOtTkdYxh5s5U7J?=
 =?us-ascii?Q?P4vE7p1pqh6AQXMWVELTVEKsvsxeihjyykcv1OJJcKWbmitcAeBpaIzYBOtd?=
 =?us-ascii?Q?iOEbq5KBwncQ2YaNOTxpDFKVJHbIvoLEcb5qez8O7w/0A7S7Hn85/lyhsAsk?=
 =?us-ascii?Q?ympVALKCvTSmNRb17qum7G10jl/0kxZVrw/0//Zh1EVIbbLwtEtqj7wyxXoe?=
 =?us-ascii?Q?hdCgf3T0V63P3tHdLtYEWHH+ZHLmc1uhTuxPH+xr2FXMxpRdbTiAH4kDOxLF?=
 =?us-ascii?Q?cCgNhxCVrDn37GuuE7JY82EF8aBu6opcbIw5aoSpynj7hsQyARCCzZA1lRN3?=
 =?us-ascii?Q?RmrAGH3q3/0oUVGgzJoEwHjPc2Gj8lyVsbcZRW/ExYYAy+sLqSURc9miZM+U?=
 =?us-ascii?Q?0yRmc+Xh/8S3t6I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cYIZuOkvXYBIBg3jT1i7zkMRc0zXM2kFJ7V7DZY+cwUMIKYsw0gwDwC4Mnj4?=
 =?us-ascii?Q?Wc1BFVy9rXwNOWH2/E1AxKC3BKAKdgXA7sI3h7NDicUBLpeuozxkXdOqLJdD?=
 =?us-ascii?Q?w+g0mjOpco6kJD86lNu4ysfwRcl3DAF7yXuEE8B9CojSWvr+ti+S7xCwyBOO?=
 =?us-ascii?Q?yoIcicbhjSe/OpGa16MjYxxd+HVrk0A58j4sOfNLVa5v+KGi4Tv32MH8+x65?=
 =?us-ascii?Q?yI9GEFhigX/7xui1GRT0MxpTuMTx5XmwyhkLCApxwJZ6kIOeUgyOemJqTmTi?=
 =?us-ascii?Q?sz/PYY8eFPUvj+CpuZC+eyOSjT0bD4rb3dUg2YpgJLsJyfJdCGiLUTdZjHHt?=
 =?us-ascii?Q?1X2TLnblEU3LiUyGfX47jn3oXoIVykhFd86BOKEFcV6UlUzxnIrymjyNYyb7?=
 =?us-ascii?Q?lpbtUxMJR3T4TILCHl4jHKLRzdQjfyOFE2+3EKh2gMmxv0BTozVp7L9Drr9f?=
 =?us-ascii?Q?7uG5SFXYXZqtnwWPf678lIv8ep9KRNbdYseuRBucP9IsnoBs69RPzrirV8bG?=
 =?us-ascii?Q?QiGLf5a/cjkwjFOYx7ZEZXkJYlgkv35teuvqeHurjqChqH4CSaIy1HYqZJBF?=
 =?us-ascii?Q?doCSSKCpEkDFocSj0JE/tYYXhHeApX4p805fDoMV9h5N6K7DFpcDh490s/xF?=
 =?us-ascii?Q?F+2pRPbCQu5VAhhORk61fkcVpKcUSLl8FcXLsB7nLOGIeiQqaU4Cw2uJob7k?=
 =?us-ascii?Q?3qMzKfV3HWHk0G02pI1eGlLGHLJKBG6Q1pSUor3cPjfPACfJ0AjHH96k/+dP?=
 =?us-ascii?Q?/2bRgYD6sBx6FfYxQGsVxIjkmU8ehzPyLvJ9/sP2xXCDiJrkuXJ0OQOTbXp1?=
 =?us-ascii?Q?/9Q5eqtujaZpCt0xTBwA59jNZNC5RLEttvG6ziMXwFsFugtEONy425YtlkYw?=
 =?us-ascii?Q?EX4FWTLjxl3kIe3JC/ETD3/zrSAUELMzJ9w91/26WZqrTFLof2rLfGNWWI+h?=
 =?us-ascii?Q?wnhS42HuDsI7qdu4Dvr7HtMqel56HSTCAMt2x8seoTwxPN+y9L/VFrKE/fmo?=
 =?us-ascii?Q?u1Nkhw72+1WzVf4ShaNcuEC8VgCI7qMpNGz4Ke9joPSoGXQQ/e91mnSHVaHy?=
 =?us-ascii?Q?rpLBYxns6/GZEGwYHDoJ9E13w4615IGDPzVfMcewPueC7hI9yq26ZBzNxYQ+?=
 =?us-ascii?Q?cOZYevk9xUmPDwQXyWnZTX6hs+h9uFFehb/BmdV7CG1Z4HjdggVTachr9w6k?=
 =?us-ascii?Q?TwiVwWKoa5kb0H2naQda/SJduWVFW1QyuAAGkz++sw/Ka0sp5LW6WQs7tYvR?=
 =?us-ascii?Q?DdlEYFE+B3UbWkT+W0/M0bZZqqdLeRyX1CoH1zWIfRiEIRdRqz+bLN7Kp/os?=
 =?us-ascii?Q?8pRRD72n+7r/ybXhDn3R9T6qBRm8/UQdlmd3gT/Yxrh6Z8otrEww4cLcosvW?=
 =?us-ascii?Q?EAXnLO4LCYhcwCEbJiEDXPKmFjStSTBWPDwcMm5WicUfaHm7wJlP1+laHl9e?=
 =?us-ascii?Q?l5lmoLiinmLJ3dAOB+7fhKq9/L0bo2+4m9Ipwe4JQJpvCk09CLlD/VAeww0O?=
 =?us-ascii?Q?Mfqn53HsXVdJhcrxhn4+trehXGdJy7YsqixuxDY4jkRbSvWhOKRdg/WRz5jn?=
 =?us-ascii?Q?041n9wwAB7mbaSZsXgWDZ7fVFhJlG/Akp4ZoWtP3?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB8596AF79DA967DCA9B68FF498228APH7PR12MB8596namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a83455c3-a9c1-429d-3e2e-08ddd8e5a085
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 14:44:50.8301 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yNw3gppTSFHmzjIDLYpcibJ9tg+qFvH+N+ZsP8QK2XlR0fK5m/Ucv/95JxajCtzUAVHrvEIoRyYPbMbBi/KEIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9462
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

--_000_PH7PR12MB8596AF79DA967DCA9B68FF498228APH7PR12MB8596namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Hi Khadem,

Please do not use `sorry for any confusion`. Very clearly, I shared what wo=
rks and why your case is different.
Snipped

Hi Vipin,
sorry for any confusion. I am only trying to explain that these patches are=
 in its final state (waiting to upstream).

[VV] it is not about the state, but of the quality and state.

You have provided your valuable insights and
I am very thankful for that. There was much discussion about these patches =
from start to finish.

Already mentioned that with Stephen and other community members, the discus=
sion was started earlier and I have provided all the information
to you in a singla email.
 "First we tried
to prevent the crashes at PMD level, but it was not possible to
add checks in each PMD. Then we tried to add safety checks
in the ethdev layer, and it was not suitable as with primary closing
all reference to device information (pointers) would lead to crashes."
[VV] I did also share I checked these eemails, none of them discussed use f=
or multi process communication as a trigger or why it is not useful.
@Stephen Hemminger<mailto:stephen@networkplumber.org>  agreed to add a prim=
ary-secondary monitoring mechanism.

I am always open to healthy conversation!

I will rest it here, I clearly understand your previous content ` The commu=
nity agrees with the current solution. `

--_000_PH7PR12MB8596AF79DA967DCA9B68FF498228APH7PR12MB8596namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Hi Khadem,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Please do not use `sorry for any confusion`. Very cle=
arly, I shared what works and why your case is different.
<o:p></o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">Snipped<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div>
<div>
<div>
<div>
<p class=3D"MsoNormal">Hi Vipin,&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">sorry for any confusion. I am only trying to explain=
&nbsp;that these patches are in its final&nbsp;state (waiting to upstream).=
<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">[VV] it is not about the state, but of the quality an=
d state.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal">You have provided your valuable insights and&nbsp;<o=
:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">I am very thankful for that. There was much discussi=
on about these patches from start to finish.&nbsp;&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Already mentioned that with Stephen and other commun=
ity members, the discussion was started earlier and I have provided all the=
 information&nbsp;
<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">to you in a singla email.&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">&nbsp;&quot;First we =
tried <br>
to prevent the crashes at PMD level, but it was not possible to <br>
add checks in each PMD. Then we tried to add safety checks <br>
in the ethdev layer, and it was not suitable as with primary closing<br>
all reference to device information (pointers) would lead to crashes.&quot;=
&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[VV] I did also share =
I checked these eemails, none of them discussed use for multi process commu=
nication as a trigger or why it is not useful.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><a href=3D"mailto:stephen@networkplumber.org">@Steph=
en Hemminger</a>&nbsp; agreed&nbsp;to add a primary-secondary&nbsp;monitori=
ng mechanism.&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
<div>
<p class=3D"MsoNormal">I am always open to healthy conversation!<o:p></o:p>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt;font-family:&quot;Arial&quot;,sans-serif">I will rest it here, I=
 clearly understand your previous content `</span> The community agrees wit=
h the current solution.&nbsp;`<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB8596AF79DA967DCA9B68FF498228APH7PR12MB8596namp_--
