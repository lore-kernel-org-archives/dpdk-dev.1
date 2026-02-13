Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35737EF48ED
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 08:54:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E45B402B2;
	Fri, 13 Feb 2026 09:54:47 +0100 (CET)
Received: from PNYPR01CU001.outbound.protection.outlook.com
 (mail-centralindiaazon11020141.outbound.protection.outlook.com
 [52.101.225.141])
 by mails.dpdk.org (Postfix) with ESMTP id B1178402A9;
 Fri, 13 Feb 2026 09:54:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfGTNzEbB79EW2ypKtztDiK4ZP8xwte1SeOihgy1t57fG41BG9IgUPvF4JHhCM1oxMx06BHabHAkkDxJmBbucMLKf+w3oE9RklFsHV9HfBk4zeZ+2yYDF0JwPDmYxAyKDWw/iRbx9evQMwseCr3+Il5vORnlzw0bePe7Kl0XlFat5U1O/ESQydNt3bI3NA0/j25yTAuQUG2Em0r+nAPkiqXX8PIv5dyH6jd3UBffB03bQeYxNDfDLJFZScXlfly3Hzy5PVppcSPdXur11j5x3j+Amsla12Xj21nZBy/GuLtKMseU2Sfxa/gqqDRSwBGNlizTOe3KuVJwY4HXZftPeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKY8v6baURIar9vtSO4lVC+LvoVTB5bzF91UhVXnyQ0=;
 b=k+IsXODOHE3maOAhbQ2uFrNx2A2KWPmpMCyDV/VCKQM67IIBwa1V0Lc8PEIYxLwg6ohUz76vwP4heqhfrwWIa0VRcbP2aX64ZP4uzKWMjLTafUN9d3P/f2TOuFFKl/v88xZRohwLKkiAWAWz2CFyYO+vUnhMSqgwDZyg15zR3oDKZKPahwmpecqpgpAdhz6+QWPvNkWtHERy0Hj6N3QF7+gl0ASLt5FDDl5tZoPJ0s+d5B/9pa/nRBSWDjW7AA9O4Og7lP4oetz7PsATA1RzBJda3hLurQGp/eY5o15dMf95Fsxor0NY/dW/U49QFpNv12F52W8YIL0NNoPuuQro7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iwave-global.com; dmarc=pass action=none
 header.from=iwave-global.com; dkim=pass header.d=iwave-global.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iwave-global.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKY8v6baURIar9vtSO4lVC+LvoVTB5bzF91UhVXnyQ0=;
 b=MahDekWZ9jgGAoqLGhASXIp2F4fTsbRElmuHV3NEG0009Hsdrqx14zBT/zIeTYxPEW5HlshGKVczjDSgYEFaiwG2fY9Keecm2tQA+WMWjQ7tH0BKclZK4zQ1qpfBjdlppLadmA08fddw+ZwLj/d+hf1vfAwDEbcxtznL9o5hkbaxoqAJFWzN9eSX1IiJDEKuOk5iK2lsLYIp81D6e4LoRf5ycKqNjzvp/9rgP40h3aejqk4LGvxa7rPOetJwQM44dp8logeOj2bbCcdGYMZwGmfrhKIejIjMAWFEJRFDAB8uYKWL6uR7pa4fUwe3uoVH30vyPBumymHSrHHjb8Xlrw==
Received: from PN0P287MB2531.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1ff::6)
 by PN3P287MB1170.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:197::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 08:54:42 +0000
Received: from PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
 ([fe80::8024:3f32:d2cc:1309]) by PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
 ([fe80::8024:3f32:d2cc:1309%3]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 08:54:42 +0000
From: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
To: Ernesto Ruffini <eruffini@outsys.org>
CC: 'dev' <dev@dpdk.org>, "yasu1976@gmail.com" <yasu1976@gmail.com>,
 "users@dpdk.org" <users@dpdk.org>
Subject: Re: Guidance Required to Improve Throughput on ConnectX-7 (1x400G)
 with DPDK v23.07
Thread-Topic: Guidance Required to Improve Throughput on ConnectX-7 (1x400G)
 with DPDK v23.07
Thread-Index: AQHcnLCS62jGM71/gkmd9SnnzdDRG7WAUfeAgAAAUR0=
Date: Fri, 13 Feb 2026 08:54:42 +0000
Message-ID: <PN0P287MB2531B462677B1BDBAE41AA15C561A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
References: <PN0P287MB25319528772B121E0E380747C561A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <039201dc9cc5$acd5dee0$06819ca0$@outsys.org>
In-Reply-To: <039201dc9cc5$acd5dee0$06819ca0$@outsys.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iwave-global.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB2531:EE_|PN3P287MB1170:EE_
x-ms-office365-filtering-correlation-id: 621220f6-fcaf-4336-009c-08de6add879d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|13003099007|38070700021|8096899003;
x-microsoft-antispam-message-info: =?us-ascii?Q?gTFP94jSkBb28isV2MzB1IHt8CR6XzoxsTelcIsYrXND3nwqFPvx/aR+jNhJ?=
 =?us-ascii?Q?G5Hc/RIR22PzkxOBkvihusj+TKtgzNB61G8tNoIN2y+yguGINIzZiUdYyAfr?=
 =?us-ascii?Q?/v4LruUqN7NVEjVE/IbDBElNckVpJU57aUxDcufHZH9mpq5CDT6VDuOHuFqf?=
 =?us-ascii?Q?un4j1UsP9LNkl54wB8S9vAkG3oCjx2o7JaTINEYHeBmNuhsxagGXGsv7q+Hi?=
 =?us-ascii?Q?k6bjX/4kT39vC+IemeARftKinsa2/OZx0YlCznMxKarTgOzlfdAq/Kfh/gAc?=
 =?us-ascii?Q?uLfh+/MkAQDIUD/+EhXoAS78g1R0FoRlQpeOY3Yw0JHq1e/2+vL9E6OkjUN5?=
 =?us-ascii?Q?FwrCLb0uwTd53DR5omO4yvVyTFch/LPftBmruLgfNtcWZKX9zUiW79JSBrhC?=
 =?us-ascii?Q?rWzll8PLg9m0Ciic+MDlfE0ye6QLg4iyx6FsV2ySIxrYhrEU9ZsgBoXYOu7F?=
 =?us-ascii?Q?KiPwCaOsUGRSjVLA4qV4o4GMaiVtOzdQs+OHjoh4jV4xgZGQFAyWEOSLGwyL?=
 =?us-ascii?Q?62RnozSPfCIIwyQS73zUjq1xb5RXwVEvi4eD8qinbX4Sj5t0FB3eIpzCiXuL?=
 =?us-ascii?Q?LxzQH77POYeCEVfxLRXW6O+ksHGjvcJ6s3hPERsRKBHskrYxBMPunIMA2UcA?=
 =?us-ascii?Q?EAv9KoIiUE+7JUrG95mD066IWHgUgBuAH6QOhiS4DSEnwpIVnAzaMXDBOJCo?=
 =?us-ascii?Q?rEftEaXVIsF2LH7jBmbPZqYJfum85Zl8+uXORXvDU95GPWLtGEOA7eSx4ikj?=
 =?us-ascii?Q?KJRNNjUYNDOpzZll9XgaSFdUItqMJBPbH3dt9oLTn2dCqWQeaTFXCRMcl0Ll?=
 =?us-ascii?Q?lSCt1jdCoal5Va4vpJkXzqwndXgEW3CEcw0YJLnoUjVMTQQjRjJYPQr4q1fo?=
 =?us-ascii?Q?gTN0K98ayGVZ2M+Jc1ftHvP6x3ysuRIcQsLKwyCi1DWR2Lf0I61kLPYJkqSi?=
 =?us-ascii?Q?oRrTUKyYD15K76D1HF1fJ2XDaoeIHdZqqtZZrzO6IE6rnyciuV1r+GXqMdxr?=
 =?us-ascii?Q?T2iSbURRG0n4PA0oTcEyrqOdrnPSeDcdYgvmU6Ni1z2eCkQN9AJ461gQCcYK?=
 =?us-ascii?Q?4V3CctcjVdPI8BeSfsky6v+Wih5KMxeTacVowWOKf5CcJpS1j6+t0+clD3aC?=
 =?us-ascii?Q?aCdPLjCFOvTUhQyjYCsS00/NTR8mvdc5ApXnO0abK8JbMFYnHM1NSyK/XDBv?=
 =?us-ascii?Q?VkM8A0+s0YJ3D5grxFY60uWqqYrXmME/+HwCGig0SN8gnihOlYvovFRD1OLe?=
 =?us-ascii?Q?zXxnx79bkomSEqVbh/ZZYXJu5UcLq9irdZxYALLYcleJ1x+YzGmohJmB8HCi?=
 =?us-ascii?Q?YaSi7qjJWOdaeoZcOcgMiII72u6UD3yS+YwPy6ssBXHigbxZ4NGUleVw1wSQ?=
 =?us-ascii?Q?t3hsQ70XLDF/uUSDCfgghXIyZSkjhRzH5d2RfAR7CEFWcPV7ByYRLkrpHzA3?=
 =?us-ascii?Q?o3MmS3NgRl6/BWPaFNse3PAhHPlq/uOUBA2JrW9v0MNXEaTrS2q1OvNJ88cd?=
 =?us-ascii?Q?22eCW/fwMx7yC3uYvVZeEiMVxg6xGxGMpgw6G1/JBbd8yCaU4uUJXj06y/Lw?=
 =?us-ascii?Q?ZdSGExlDsIyEoeigkF1dmPomnMSYOPwXqRGqVOXp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PN0P287MB2531.INDP287.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(13003099007)(38070700021)(8096899003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qF9ICRkmxBGYKSQuHtWZMBz6M3ieIDmfWLgFlNuvojVUOjKBfhRfHFnC4bPk?=
 =?us-ascii?Q?ONaqtEtSXOSjcOVlk59tmWJg1ko4wW7DYRLcKDDhCkP8bs5EZJfeoEx74ISh?=
 =?us-ascii?Q?kOGa+zx+T3FBCrIWVjQxeM3oV7ydphmk+9F+hUHtIygSKxHuddBL4LNf60mR?=
 =?us-ascii?Q?xZVbvtMe20zI/M6Pv8+VS9WF8TagREnhdyjtZcufz3tfNotCzL1O5S3T9A6Q?=
 =?us-ascii?Q?XotGLNPFvM10Bs9u+zrEjrAm3m/6I3TxQm7wmO4d6NoOTLjzsOFw+LE/R8Rs?=
 =?us-ascii?Q?xXZr+EDwQhMZcFuHzDW9qcPet6URFrtKti+cXDQubQFdByf6gD07IDRAlDsq?=
 =?us-ascii?Q?LqORAU7k0JQh6aVklECdOv/QSh8ZWlunG8Dj0l5qnZsb2h5nWrRPU+NGkOdk?=
 =?us-ascii?Q?V0+QESO52f8oHggAdgNuKChVtNnRMs/+/e1nqyjgHYCatawEVVWNfC609yXN?=
 =?us-ascii?Q?a5IhWiPoOIwUWlRikpcNBvevRSSZTrBYli99J+pHCJHiyKCyEfLIzwI6FfkO?=
 =?us-ascii?Q?kjZMRE5rZUPBr07lqAvRwnJzZSdb2CiPAEVvW48NtG+mCj8u8/JIgGMPv39b?=
 =?us-ascii?Q?8IRvIsTPrGxzMO+Se/zr9vIRhhj77aBVzuDJROA85X9Tem6SoGLhVp62lQJV?=
 =?us-ascii?Q?uQhmoAtedSJpR7MvHjfUzNqGyFskzqskRUNFyXMY8Ktw9JzHjvyF5QH6ofUY?=
 =?us-ascii?Q?L9fYW8JT3/j7Nl7PjBXHUBlRiKl07BCk+P8p93mjaSWmfGC4vri/hgc6wfpI?=
 =?us-ascii?Q?GHKFaYkwAQimZJyb+zen2b30r4KP3VfK7vvqiKR4+fFopiupUYiWD0tsNMpf?=
 =?us-ascii?Q?zRFlwhLKHZsizsakcnu3Opjnc6mKk5RHsBw6o+XV9I3NVoioWidUGQ5V2gzP?=
 =?us-ascii?Q?2cU2wcK2wy3Jv3T82m4pHTtKWIWHhyUL06ij4ZWiM8h8GD1FzObY5aMwDDS7?=
 =?us-ascii?Q?DPpgINt0PGPHVTPP8jYZi0JH5Uyd0JlF7I9LBp/gVbvTFFvEc7uv+Y+FSYx4?=
 =?us-ascii?Q?W+WRyb94nhxNjz518pX4DuTlX/mK1PoEzlPNQE24pA+U2NQmm/bru6WYBQBR?=
 =?us-ascii?Q?/xOsY8Sq92Lr92BS0hcPNsuMFI87UhCUTC2OyBmuEFv1OKFef1yPmIaHmj8O?=
 =?us-ascii?Q?h2Crzuuu6mLiZZOOyPsmlPoa117/P+AaAGew6BULgojLvdW79X1Jrk4064gE?=
 =?us-ascii?Q?lYMCrB7D+thqPrcFRq0QDkgSL3iV1EnDmtSncy8iuYOVwqSTNbwHcRO8tBrw?=
 =?us-ascii?Q?pNh+H4Vb1qk+9ZYbdg+bnwV7Z1uaZiObTNMbtxKP9PlBsFnuvww38tYTe7lp?=
 =?us-ascii?Q?xREktOJvXqeB99bpYihwEmqCL7r+AYqZyoRPzO+zSbsLGne7IoWLZYZAd1pl?=
 =?us-ascii?Q?P/JSXOUvQVsWkvrpzSWppvzbJqJfyIPJkdN7MSx3yzPPStBHhtu3RuF8WB2G?=
 =?us-ascii?Q?Tr6VUcEO33Ux2o8oLVvK/S7GxwG9Rgdx1y+ckShaERjkIqxch/zGeq8VzkTD?=
 =?us-ascii?Q?RGYJ2Wnpv128XgF0rNhYW2fI29tzRKZEGltrvl3QB6XURfjXMujphaIiTzor?=
 =?us-ascii?Q?M1e+TjzVjlJ2ICcKNfcBX+ysVVB5PpLdqOVlBE/uSDF+rJK74mI58ZqOdNZE?=
 =?us-ascii?Q?2N1sLdaMDxq1mstf7LxJTtZ/ePqH5xuWKiV7y2EhISuenAuN538zrXczLrJY?=
 =?us-ascii?Q?U9D3n7SPEQsI81AO77iAuw1IrYf3nBywcaAOtNR7YvXN5YwhVkb/z2voCdH9?=
 =?us-ascii?Q?6s+Q5CxbKwuLTGEShjhzz8+A9+b2Xjg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PN0P287MB2531B462677B1BDBAE41AA15C561APN0P287MB2531INDP_"
MIME-Version: 1.0
X-OriginatorOrg: iwave-global.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 621220f6-fcaf-4336-009c-08de6add879d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 08:54:42.8648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 507ae903-cc48-4d6e-bdb6-35278120a345
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pi6ba+eM0hYPlWcnqbH+fFHOScPUBGd5gbG82aoTslQ1rgog/iSgfqdZXUSNkKtwWfHrz++giaQ6jzlfCUUB8uHPpU3pKDV/HkJcbsiUJDIQ4N/O+TxgoaOktmwguOl9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1170
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

--_000_PN0P287MB2531B462677B1BDBAE41AA15C561APN0P287MB2531INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Ernesto,

Thankyou for the suggestion.
I will look into "https://fast.dpdk.org/doc/perf/DPDK_23_11_NVIDIA_NIC_perf=
ormance_report.pdf" , but here the tests uses external device for traffic g=
enerator.

Yes, with ethtool it shows 400Gbps.
The module can support upto 100Gbps. But it should have increased more than=
 10Gbps. I will disable AN and check once.

Thanks and regards,
Ayshathul Thuhara

________________________________
From: Ernesto Ruffini <eruffini@outsys.org>
Sent: 13 February 2026 14:19
To: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>; users@dpdk.org =
<users@dpdk.org>
Cc: 'dev' <dev@dpdk.org>; yasu1976@gmail.com <yasu1976@gmail.com>
Subject: RE: Guidance Required to Improve Throughput on ConnectX-7 (1x400G)=
 with DPDK v23.07


Hi Ayshathul,

I think the best is to follow https://fast.dpdk.org/doc/perf/DPDK_23_11_NVI=
DIA_NIC_performance_report.pdf

Did you check with ethtool or similar the actual connection speed? ethtool =
linux-nic-name | grep Speed

Maybe your module limits it to 10Gbps. In case try to disable auto-negotiat=
ion



Regards,

               Ernesto



From: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
Sent: Friday, February 13, 2026 07:36
To: users@dpdk.org
Cc: dev <dev@dpdk.org>; yasu1976@gmail.com
Subject: Guidance Required to Improve Throughput on ConnectX-7 (1x400G) wit=
h DPDK v23.07



Dear Team,

I hope this message finds you well.

I am currently performing testing on ConnectX-7 with 1x400G hardware using =
DPDK v23.07. However, I am unable to achieve data transfer rates beyond 10 =
Gbps. While reviewing the DPDK mailing list, I came across your previous re=
sponses in the related discussion (https://mails.dpdk.org/archives/users/20=
24-July/007767.html), where you mentioned achieving throughput of around 25=
0 Gbps and above.

Could you kindly advise on the configuration changes or optimizations requi=
red to improve throughput in this setup?

For reference, I am using an OSFP loopback module for testing, where the sa=
me port is used for both transmission and reception (single-port loopback s=
etup).

CX-7 Firmware: 28.45.1200

CPU : Intel(R) Core(TM) i7-14700

Command used : sudo ./build/app/dpdk-testpmd -a 01:00.0 -- -i

I would greatly appreciate your guidance.

Thank you in advance, and I look forward to your response.

Thanks and regards,
Ayshathul Thuhara



--_000_PN0P287MB2531B462677B1BDBAE41AA15C561APN0P287MB2531INDP_
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
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi Ernesto,&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thankyou for the suggestion.</div>
<div style=3D"color: rgb(0, 0, 0);" class=3D"elementToProof"><span style=3D=
"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 12pt;">I will look into &quot;</span><span st=
yle=3D"font-family: Calibri, sans-serif; font-size: 11pt;" class=3D"element=
ToProof"><a data-auth=3D"NotApplicable" data-linkindex=3D"0" rel=3D"noopene=
r noreferrer" title=3D"https://fast.dpdk.org/doc/perf/DPDK_23_11_NVIDIA_NIC=
_performance_report.pdf" class=3D"OWAAutoLink" id=3D"OWAeff86e8d-ad77-3696-=
fe19-ea870b99fa63" target=3D"_blank" href=3D"https://fast.dpdk.org/doc/perf=
/DPDK_23_11_NVIDIA_NIC_performance_report.pdf">https://fast.dpdk.org/doc/pe=
rf/DPDK_23_11_NVIDIA_NIC_performance_report.pdf</a>&quot;
 , but here the tests uses external device for traffic generator.</span></d=
iv>
<div style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">Yes, with ethtool it shows 400Gbps.</span></=
div>
<div style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">The module can support upto 100Gbps. But it =
should have increased more than 10Gbps. I will disable AN and check once.</=
span></div>
<div style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);" class=3D"elementToProof">
Thanks and regards,&nbsp;</div>
<div style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);" class=3D"elementToProof">
Ayshathul Thuhara</div>
<div style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Ernesto Ruffini &lt;e=
ruffini@outsys.org&gt;<br>
<b>Sent:</b> 13 February 2026 14:19<br>
<b>To:</b> Ayshathul Thuhara &lt;ayshathul.thuhara@iwave-global.com&gt;; us=
ers@dpdk.org &lt;users@dpdk.org&gt;<br>
<b>Cc:</b> 'dev' &lt;dev@dpdk.org&gt;; yasu1976@gmail.com &lt;yasu1976@gmai=
l.com&gt;<br>
<b>Subject:</b> RE: Guidance Required to Improve Throughput on ConnectX-7 (=
1x400G) with DPDK v23.07</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
@font-face
	{font-family:Aptos}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",serif}
a:link, span.x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
span.x_EmailStyle19
	{font-family:"Calibri",sans-serif;
	color:windowtext}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:72.0pt 72.0pt 72.0pt 72.0pt}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:break=
-word">
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif">Hi
</span><span style=3D"color:black">Ayshathul</span><span style=3D"font-size=
:11.0pt; font-family:&quot;Calibri&quot;,sans-serif">,</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif">I think the best is to follow
<a href=3D"https://fast.dpdk.org/doc/perf/DPDK_23_11_NVIDIA_NIC_performance=
_report.pdf">
https://fast.dpdk.org/doc/perf/DPDK_23_11_NVIDIA_NIC_performance_report.pdf=
</a></span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif">Did you check with ethtool or similar the actual=
 connection speed? ethtool linux-nic-name | grep Speed</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif">Maybe your module limits it to 10Gbps. In case t=
ry to disable auto-negotiation</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif">Regards,</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ernesto</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif">&nbsp;</span></p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0c=
m 0cm 0cm">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:11.0pt; font-family:&q=
uot;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0=
pt; font-family:&quot;Calibri&quot;,sans-serif"> Ayshathul Thuhara &lt;aysh=
athul.thuhara@iwave-global.com&gt;
<br>
<b>Sent:</b> Friday, February 13, 2026 07:36<br>
<b>To:</b> users@dpdk.org<br>
<b>Cc:</b> dev &lt;dev@dpdk.org&gt;; yasu1976@gmail.com<br>
<b>Subject:</b> Guidance Required to Improve Throughput on ConnectX-7 (1x40=
0G) with DPDK v23.07</span></p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div style=3D"margin-top:12.0pt; margin-bottom:12.0pt">
<p class=3D"x_MsoNormal"><span style=3D"color:black">Dear Team,</span></p>
</div>
<div style=3D"margin-top:12.0pt; margin-bottom:12.0pt">
<p class=3D"x_MsoNormal"><span style=3D"color:black">I hope this message fi=
nds you well.</span></p>
</div>
<div style=3D"margin-top:12.0pt; margin-bottom:12.0pt">
<p class=3D"x_MsoNormal"><span style=3D"color:black">I am currently perform=
ing testing on ConnectX-7 with 1x400G hardware using DPDK v23.07. However, =
I am unable to achieve data transfer rates beyond 10 Gbps. While reviewing =
the DPDK mailing list, I came across
 your previous responses in the related discussion (<a href=3D"https://mail=
s.dpdk.org/archives/users/2024-July/007767.html" target=3D"_new" id=3D"OWAe=
131b2f8-ca05-2ff3-d67e-40e6b9de2cd3">https://mails.dpdk.org/archives/users/=
2024-July/007767.html</a>), where you
 mentioned achieving throughput of around 250 Gbps and above.</span></p>
</div>
<div style=3D"margin-top:12.0pt; margin-bottom:12.0pt">
<p class=3D"x_MsoNormal"><span style=3D"color:black">Could you kindly advis=
e on the configuration changes or optimizations required to improve through=
put in this setup?</span></p>
</div>
<div style=3D"margin-top:12.0pt; margin-bottom:12.0pt">
<p class=3D"x_MsoNormal"><span style=3D"color:black">For reference, I am us=
ing an OSFP loopback module for testing, where the same port is used for bo=
th transmission and reception (single-port loopback setup).</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><b><span style=3D"color:black">CX-7 Firmware: 28.4=
5.1200</span></b><span style=3D"color:black"></span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><b><span style=3D"color:black">CPU : Intel(R) Core=
(TM) i7-14700</span></b><span style=3D"color:black"></span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><b><span style=3D"color:black">Command used : sudo=
 ./build/app/dpdk-testpmd -a 01:00.0 -- -i</span></b><span style=3D"color:b=
lack"></span></p>
</div>
<div style=3D"margin-top:12.0pt; margin-bottom:12.0pt">
<p class=3D"x_MsoNormal"><span style=3D"color:black">I would greatly apprec=
iate your guidance.</span></p>
</div>
<div style=3D"margin-top:12.0pt; margin-bottom:12.0pt">
<p class=3D"x_MsoNormal"><span style=3D"color:black">Thank you in advance, =
and I look forward to your response.</span></p>
</div>
<div style=3D"margin-top:12.0pt; margin-bottom:12.0pt">
<p class=3D"x_MsoNormal"><span style=3D"color:black">Thanks and regards,<br=
>
Ayshathul Thuhara</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"color:black">&nbsp;</span></p>
</div>
</div>
</div>
</body>
</html>

--_000_PN0P287MB2531B462677B1BDBAE41AA15C561APN0P287MB2531INDP_--
