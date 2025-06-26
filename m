Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1F8C7EE32
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 23:16:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA0334026D;
	Fri, 27 Jun 2025 01:16:49 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11020124.outbound.protection.outlook.com [52.101.69.124])
 by mails.dpdk.org (Postfix) with ESMTP id 94464400D5
 for <dev@dpdk.org>; Fri, 27 Jun 2025 01:16:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=re3TDYEmR3/pH36TSmhISHm/MgXMa6t/blMGVDFwUP0Fhlb3HIZQdY9Nm3EhwXoAzttaSVacTIlbSGmH9fhmtfgRg9IlFIi2pzXdHSAsk98fjpjNZzMhUblBbCCVUU3JADyYcF5oKROKIdnwZUp6dB5LIgBKu69wrvZKwax9B6rjd4v+noSGJ9Qumstfb/SZqdSbyxQzxHeEzf55HfvtVwpX06RZ3/LVip22m7rHBFtXjWX6kX0yfEEZvSq6s7PGwRbytiNqxN0+CQIgrPzo024WZ/a9nsq4xbtIpclox2j0DT1/MMXfySFFUHdAo+WSn4DusNnlk02Og0ptU2hzRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lnLwShQJf9EY6ttAa6Qub75jkMHRwVC6T3oEXKGzIc=;
 b=fx91voWVaR2APrKuhyf/HrTlH9DLIcYJuuXHn6kXy9H0AeclFyQDrCZhtpZOARNl5emlauH9T1D6OsYTaNufHfi7ftSmmOAGSQS38i/sgFNhVHS0NX5csillWacf/rLPlgtv823neR+G5UQvJvWzr64T7ibF037YdKIW8Nnv25g5GEgyBuyjhoSWqnMdU98zBb1JVVeEvwfIQ0pSUwBOgfS48zr1RZStSvzh7mdbF+lXWc2h1r2kw2Sx9SHCXS8KWjim7y05hj5Qg3nmIq5Fvcm7dtwCnbaiKun6SJofkOIkGcLPf3GRYl3IJoS3u5fS5uYtNQ7WAHU3kKR5hFedwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cgstowernetworks.com; dmarc=pass action=none
 header.from=cgstowernetworks.com; dkim=pass header.d=cgstowernetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cgstowernetworks.onmicrosoft.com;
 s=selector2-cgstowernetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lnLwShQJf9EY6ttAa6Qub75jkMHRwVC6T3oEXKGzIc=;
 b=PkkYTpm44MehCg2meYp3QxGmU9BmWrZZGPYc9bv3R0qZfqnaVjAwbjk4ETfIZHQyP/T40+CRouPqIC9Ex1En6NKD+2TPt57yHUkti1jVwAPESUrFVSh+kEF+2CeIz5h+/dNzJpIrLV67TnHUnTDDvVtg9IQY6Z8t4iB8h4I9auE=
Received: from DU2PR09MB5486.eurprd09.prod.outlook.com (2603:10a6:10:27b::22)
 by DB3PR09MB6177.eurprd09.prod.outlook.com (2603:10a6:10:433::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Thu, 26 Jun
 2025 23:16:43 +0000
Received: from DU2PR09MB5486.eurprd09.prod.outlook.com
 ([fe80::a8b7:d0b7:ce2a:24fc]) by DU2PR09MB5486.eurprd09.prod.outlook.com
 ([fe80::a8b7:d0b7:ce2a:24fc%7]) with mapi id 15.20.8857.025; Thu, 26 Jun 2025
 23:16:42 +0000
From: Yogev Chaimovich <yogev@cgstowernetworks.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
CC: Maayan Kashani <mkashani@nvidia.com>, Stephen Hemminger
 <stephen@networkplumber.org>, Slava Ovsiienko <viacheslavo@nvidia.com>, Bing
 Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix transceiver warning when not exist
Thread-Topic: [PATCH] net/mlx5: fix transceiver warning when not exist
Thread-Index: AQHbvbYIS6Ux7qfBtUOA8dJvuvvxhbPb9EsAgBbNOlCACEK3N4AanWaAgADCsz4=
Date: Thu, 26 Jun 2025 23:16:42 +0000
Message-ID: <DU2PR09MB5486CBB7ADC2068692C28DA9D67AA@DU2PR09MB5486.eurprd09.prod.outlook.com>
References: <DU2PR09MB5486574FE72A43A09A323DCDD68E2@DU2PR09MB5486.eurprd09.prod.outlook.com>
 <20250520114904.6570827f@hermes.local>
 <PH7PR12MB701839586EA3DA18CB3E3D45B26CA@PH7PR12MB7018.namprd12.prod.outlook.com>
 <DU2PR09MB54860A76C9E7A1CFF4A00AF0D66BA@DU2PR09MB5486.eurprd09.prod.outlook.com>
 <20250626113617.fekttwech4w75jqt@ds-vm-debian.local>
In-Reply-To: <20250626113617.fekttwech4w75jqt@ds-vm-debian.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cgstowernetworks.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR09MB5486:EE_|DB3PR09MB6177:EE_
x-ms-office365-filtering-correlation-id: c14c7a70-5fdc-4018-9ae8-08ddb5078314
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?gTsMJkAelbWBnDOMXwRmEy74VC7Y0NksOVRKQHS5kAoH0FV6Xq0AG9dteOQT?=
 =?us-ascii?Q?oJhCFWM8t+o/XKqO/1Ip/1BtiSY62PAd3SmNCb9/mtaNAhW8GhRGhZdUwqZo?=
 =?us-ascii?Q?cApClpxay9YJ34/huUQqz1EZtwzvCNsPyNyXAfRXCNWDX3D2Zg1wv/tAt+2I?=
 =?us-ascii?Q?JuuAc6qPWud4gy8Z0asX11vDUSvXnS8L9TkMcli8e4oPpFxbjEBlpot8O/Nq?=
 =?us-ascii?Q?dQOfqUEqbjFYn10nT2r+SykQLLggFeRbxcjFcs31y0C4CDxdEAJOn3hDk7qK?=
 =?us-ascii?Q?zAIBwH9ZnsFqTl86+E2Wh6FtNkd7G3CI9HzuQIsMr/G7tp1sC8pdmPNLKTTy?=
 =?us-ascii?Q?3r6H6r8/UJ6262ACTGo2K/TUtep48KEUZcl0GjehxmqNQ1adsbzCIoRH8O3j?=
 =?us-ascii?Q?LK1bY2P+/kd+6wSIcIxvZLSQClsb+axj2igPCGOwP2Nc9WIfFDP61nLJ9aaD?=
 =?us-ascii?Q?ugL+taUQbFuwqo7NPRPGyN8KiGrBcYvXu6+uLg/fUYyi2fpyb2LyQ6JzXHwn?=
 =?us-ascii?Q?aDJ61doSy3YvHc3um4WFbMqQ9fquQ1Toi0e/jYLPpWs3nlM+Uv7dD7IQnVb2?=
 =?us-ascii?Q?UkZwu1VkTyVQh+CBkzu+jiE1I4VdV2myE0MmvYBlfkvdAyN12hk2imsrOdb7?=
 =?us-ascii?Q?ocxFpwl+bA6Bu4xgw4StVw6AtCdA2YhI+I18cyy9/NQHZsab9aCoqnIhkciN?=
 =?us-ascii?Q?2YqzNwCE5+dCtaKVQ+7y6GKiJufcU7szl6Z5ihOirvkGh6dDHATY3+GCouuQ?=
 =?us-ascii?Q?CK7AkDAD8ZjlOfRVKGvl4L5ifep8JbsLF2C3/D0b1pBfRW9actFQ5D2/JwTU?=
 =?us-ascii?Q?QDJ86k7uCU0ALWZE0jC0kpXuK2mifVGlhMKARI6TopBBlnkFNgdbV1zWjO62?=
 =?us-ascii?Q?mZJQCi+M5Jud/RhwYMqNk91/ULZzAxgGkOd4S3tg6O6S33Q9o/i9gt2XmdgC?=
 =?us-ascii?Q?t3xrRwgmbcHBBEk66ndP6xyBIfBcGWEcaYSKRSqAeyDaHg5l9OV6N42rkXPT?=
 =?us-ascii?Q?4yLUVOF1qXm2PmmwbJGhZo4GsAEOK+vYKHIv99/9VkPzsMh6N5WwSOIEDJLd?=
 =?us-ascii?Q?Qj5T31d3COQ1RUpDubaHvC1Glet42qvGj/laX/E1/URh/sRydyGRYji76wEW?=
 =?us-ascii?Q?u5orVOHH0GD1BUDO0SZ2r8jhAa9FyY6ajLmBWLkD9JKVfmIsEIYm/zFgLt6n?=
 =?us-ascii?Q?0h3nHwKmr+nEPB1cIfMT0b23npa1PUkpRnWLfQVRAPC1FxRCo4EN8CfvLlFo?=
 =?us-ascii?Q?cHJsmOJb3w29LYd60XNgZHzgnzO0ZwZJgTUrUTXMhkVGJ0WhXY4FzZU+nea9?=
 =?us-ascii?Q?BEAJBCRGna0y7T+Prpl7zF9NXVfXr8HHAMLzotl5/XNorWfMYGXK5vK5J8Nh?=
 =?us-ascii?Q?wCVcmRg+6OOYs6rYcHomJM0BYtX4D5CAzTleQNGa+4tDOk/uSRAlhkeZsYyP?=
 =?us-ascii?Q?9LDR9w7C8Jo5OQc6vl8tDK3EEzscVv1jkxEFRC2tdbefM7/4y4v+Ng=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR09MB5486.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(38070700018)(7053199007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qZl0xNC8GpKDZwXDyZhSFfdhZHp8+DBtgNuWtz5K0ZsLFO41LmBeq6huOdXn?=
 =?us-ascii?Q?kXeyRhktUYQE3v/cuSyK9KH1fz45o/T/IFlkKOE5s6NGXQQAqEx8h72SYLEg?=
 =?us-ascii?Q?iVRjr0h1x3j5Pp9WVWuRKQZsmJwDMCmzU7bWkHGJ6W4apoJIS7e24UhtcKh+?=
 =?us-ascii?Q?NuG2B3Hqd9D1TH1nGRHY7g5ZRdM3VJGOwGQTFQQeJXRV06QWpmXHi6O3zP+d?=
 =?us-ascii?Q?XLxcn9/0tOOO/zXLz3atKIXvfHoRO70f0L4U7MSqFq96hKKiuq2ayNjPTraE?=
 =?us-ascii?Q?8S9DPgNa8kJj25Pc6wXfD42jZu/VwqH/nKWlVTgoZDt8slx6KZbE+T54LkqQ?=
 =?us-ascii?Q?1rH9X2iWxGvbWcLelp9Q8ZC6p2yyF1oPnxFArE1ETwkLqbYtBx3QKLWO+JVH?=
 =?us-ascii?Q?jTb4RxYlJu5dvR3Rj5mkGkQsm0sFqWGPd4Jw4lx0laU8zv5MgvGOvaQw9q+M?=
 =?us-ascii?Q?3+V40Cn3Ej5DA09b4a+Y8CieM7Ox3vkXVD0wYIpUEULqoO5tA6Zmo+0tmz5C?=
 =?us-ascii?Q?uDf6lgYtAp2iYymPY+KXKuvQ5GcTc1MmIb8skeUr/SStZ+QJ782kz3UZw37r?=
 =?us-ascii?Q?wfV8ebE1In1w9ix30IwP2tTM/st8BQRdiDvDrfNYp74wcTp1KIyV8Nzd8gnU?=
 =?us-ascii?Q?osxLKBRaxDVA8Z/rnY2qimjYGty/+66DzGErnd+FO7SQSKdt5mgEThyTbh/y?=
 =?us-ascii?Q?dPZdP/e5cTvlyu7qpkVrwxcJ0tvw0Njcy5UoqGtDYNMqSobZ/sLlIm6HXi1a?=
 =?us-ascii?Q?euB0VoppVZC/1k+G8eqndAFh9Pdf9Um8ehd/EFQ9wl1DQ9NtxxyvH6LPABFz?=
 =?us-ascii?Q?zdDyXaHVUaWYdmtV9WHWbNRktpRTCK0vVaQMdNqDaS1tSmLC89pI5Dzl8MQi?=
 =?us-ascii?Q?qptjHOOh5gyiT9lEMlZlw1AD8VdMPzANAS3uCutjNA+L+d7uML+C+F7q7apO?=
 =?us-ascii?Q?JFyfIQ/Ia8Bq2UK0lLs1+F01ICyWZ99OxgLPLTv+BlFBmpXpf4FPOF2SoWDO?=
 =?us-ascii?Q?hFpy8rYdEbExU80m8KPLV9+BNskZsmbQ5Ai7YtNh1WYyM+l/f85LMN4rfFI3?=
 =?us-ascii?Q?rL7LPvyZcHMppHS++asQtYF6WN7wUD9j9JxEfawzW/OpHZ8Sh82PC8y5QQHo?=
 =?us-ascii?Q?LMmq4/og+r6VQDqU/VxD4YYhQ20gJhbN2jhtMJiqSOQ7wu9YYD1elqt9Qzm8?=
 =?us-ascii?Q?ZUu4d3uzGGKUrRi7sJd5OAl4Mi/TrlnSgHF/h/Fx63S1HIWDUiWVcpq2yS1h?=
 =?us-ascii?Q?bGr+tHfbnU4i9hSOhczaCQPwrFN21zQ6+glYmvbCmW3SusVvOW3sesgV9HnH?=
 =?us-ascii?Q?FZR7k4vE4d3GjEdi7sAMlROLe0+2VbobK6cghxF0tTB7vymJIxUfYR0bcfIn?=
 =?us-ascii?Q?aGdvL57soF/q3ois/nf3uRi7ILUSIS4ha/e0FlZ8/ZW4S9ghxOzWE7xV8Nxa?=
 =?us-ascii?Q?5nH1ybqSeWK8Ytq4ipd73N6kctw5f5saeQrCVdtbRE1fjk8hCkkVtWo+Lt5f?=
 =?us-ascii?Q?PpIn1lPqevCTLixTNgB5IHPZ1WJIcWaJGt8Yn5atH4KXd0/+0jlk3mBj/WCu?=
 =?us-ascii?Q?p84HXv5vRzR8cr2ArvA++SNfRVNjxu2kDMeI+7og?=
Content-Type: multipart/alternative;
 boundary="_000_DU2PR09MB5486CBB7ADC2068692C28DA9D67AADU2PR09MB5486eurp_"
MIME-Version: 1.0
X-OriginatorOrg: cgstowernetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR09MB5486.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c14c7a70-5fdc-4018-9ae8-08ddb5078314
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 23:16:42.4456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fc9e9498-07e8-4b82-b4cf-365bba23cbbf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Czw4PNvY45AQ80OBQzfqbwFlDNP3VdeybEFpdqreX5i7t5Qo9KcOoArcb1daBMaF27+hTEFd+EY9UTB4UF9ZIh0eDFd6yarJhIYu1uk1T9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR09MB6177
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

--_000_DU2PR09MB5486CBB7ADC2068692C28DA9D67AADU2PR09MB5486eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

OK.
I wished  there was a DPDK function to verify if transceiver is plugged in =
or not, without log errors. Such as rte_eth_dev_is_module_exist()
So, 1'st I would have checked if it's plugged in. Then I would have used rt=
e_eth_dev_get_module_info().

The workaround is setting the module's log level so the error won't be seen=
 before calling rte_eth_dev_get_module_info(), and set it back to default a=
fterwards.

Thanks,
Yogev
________________________________
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
Sent: Thursday, June 26, 2025 14:36
To: Yogev Chaimovich <yogev@cgstowernetworks.com>
Cc: Maayan Kashani <mkashani@nvidia.com>; Stephen Hemminger <stephen@networ=
kplumber.org>; Slava Ovsiienko <viacheslavo@nvidia.com>; Bing Zhao <bingz@n=
vidia.com>; Ori Kam <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>=
; Matan Azrad <matan@nvidia.com>; dev@dpdk.org <dev@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix transceiver warning when not exist

Hi Yogev,

On Mon, Jun 09, 2025 at 01:11:27PM +0000, Yogev Chaimovich wrote:
> Hi,
> Actually looks like we're going with another workaround, so I might not b=
e needing my original patch.

Could you tell us what kind of workaround you applied?

Also, I'm not sure if this warning should be suppressed on EIO.
mlx5 PMD relies on the kernel driver to get the module info,
and from what I've seen for ETHTOOL_GMODULEINFO kernel can return EIO
also for cases other than transceiver not existing
(for example error on NIC register access).
So mlx5 PMD cannot discern between "no transceiver" and
"other I/O error".
For this reason I would keep the log and keep it at warn level.

> Also, I do not understand how my patch (not printing a log) makes a test =
fail - I couldn't find that test in DPDK to verify. I'm not that familiar t=
hough..
>
> Yogev

*snip*

Best regards,
Dariusz Sosnowski

--_000_DU2PR09MB5486CBB7ADC2068692C28DA9D67AADU2PR09MB5486eurp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
OK.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I wished&nbsp; there was a DPDK function to verify if transceiver is plugge=
d in or not, without log errors. Such as rte_eth_dev_is_module_exist()</div=
>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
So, 1'st I would have checked if it's plugged&nbsp;in. Then I would have us=
ed rte_eth_dev_get_module_info().</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
The workaround is setting the module's log level so the error won't be seen=
 before calling rte_eth_dev_get_module_info(), and set it back to default a=
fterwards.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thanks,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Yogev</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Dariusz Sosnowski &lt=
;dsosnowski@nvidia.com&gt;<br>
<b>Sent:</b> Thursday, June 26, 2025 14:36<br>
<b>To:</b> Yogev Chaimovich &lt;yogev@cgstowernetworks.com&gt;<br>
<b>Cc:</b> Maayan Kashani &lt;mkashani@nvidia.com&gt;; Stephen Hemminger &l=
t;stephen@networkplumber.org&gt;; Slava Ovsiienko &lt;viacheslavo@nvidia.co=
m&gt;; Bing Zhao &lt;bingz@nvidia.com&gt;; Ori Kam &lt;orika@nvidia.com&gt;=
; Suanming Mou &lt;suanmingm@nvidia.com&gt;; Matan Azrad &lt;matan@nvidia.c=
om&gt;;
 dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Subject:</b> Re: [PATCH] net/mlx5: fix transceiver warning when not exis=
t</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Yogev,<br>
<br>
On Mon, Jun 09, 2025 at 01:11:27PM +0000, Yogev Chaimovich wrote:<br>
&gt; Hi,<br>
&gt; Actually looks like we're going with another workaround, so I might no=
t be needing my original patch.<br>
<br>
Could you tell us what kind of workaround you applied?<br>
<br>
Also, I'm not sure if this warning should be suppressed on EIO.<br>
mlx5 PMD relies on the kernel driver to get the module info,<br>
and from what I've seen for ETHTOOL_GMODULEINFO kernel can return EIO<br>
also for cases other than transceiver not existing<br>
(for example error on NIC register access).<br>
So mlx5 PMD cannot discern between &quot;no transceiver&quot; and<br>
&quot;other I/O error&quot;.<br>
For this reason I would keep the log and keep it at warn level.<br>
<br>
&gt; Also, I do not understand how my patch (not printing a log) makes a te=
st fail - I couldn't find that test in DPDK to verify. I'm not that familia=
r though..<br>
&gt; <br>
&gt; Yogev<br>
<br>
*snip*<br>
<br>
Best regards,<br>
Dariusz Sosnowski<br>
</div>
</span></font></div>
</body>
</html>

--_000_DU2PR09MB5486CBB7ADC2068692C28DA9D67AADU2PR09MB5486eurp_--
