Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D57ACFD315
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 07:58:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7024440678;
	Tue, 25 Nov 2025 08:58:43 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
 by mails.dpdk.org (Postfix) with ESMTP id 536C9402E8
 for <dev@dpdk.org>; Tue, 25 Nov 2025 08:58:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOu8cg5VxJ/wS2e6of6tBeco/PR0nDR0raX62G/Xd3qiNOOzfnDdHBN3QxSCd9zI9Fdv3tlIr4osIvyGWcii2o+Aqq01twFxmqoIkWxAZO/xFx4OfY5xPepAmWMMr6IumqgrQnFE+oHZ1OsegImYFL+wUJNUgX1JDtnw7WR9YiekxDx19yq4ZRpBoYM0ZZkBJQZ6W096Odol9tUmEDc13kjXVOPBO5WKhjv2wraSpW6OKDWqUBwtREpfIXK/wUaW7YQK0wuztNlaNPfxFqaqL5c2lMEzNQ9ATlWOCSxmfprpn/tA50vWriFEXiS589VSioBlYDH0eGfHHtAcgu0GRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVYznrqb8iLZBEHlslzf/p8Q7cEuHMztv87fVmLdFeA=;
 b=fqzSAhDc+g+R60yw24fSFBR5FpEWUIpaf4BJgTnL+enC/4rxeU2lrhfy1Q7JZV2bnyMMcgH+9JH5Mo8JnIrl9tmeBGyjSToLbEw6lwrkOdczhgh359TIkyJRDyidfMpmBE3BT+f2ZIeyGIwwuAPk6nVDb/aGz7iuxxjXQa6DnURneT1mO01rCVqd+lEHeby7/5tePn1sCJiEArfUvhDgE5bhvlG+3tFKqrZ8Cr5FTZ+gdXuM6pFDvA3N846oY7DTPVFIEG+PKN2ynsRpr3lNIXNyGZ8sb/2WGP2nzCFVzKJQwPmrhZHRdjwKTUcBdGDCI+T5fL5UdZD0sfo3tkSaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVYznrqb8iLZBEHlslzf/p8Q7cEuHMztv87fVmLdFeA=;
 b=TJwOfKwIS+/N+ZNNvyTgv0skDLSQ/soLRvMQWeVvBs06n/v/haW9wVNEDsrb0mA92T7WrCUYEGFzpkOxv00MSO5cXSOodxO1F09SxaaZAzsEn3bLjLlEJzJk8eVNqVWJ38jpEmQLB5BHnKs/eET9f6eTOLrFGtbGpOMgIHNSOYrameGKBGql6j05P2mhqVuqyjBltdsOhLS8QpUj4PEj1G4+IzzhBTjALq7ybhsaZLcJFI0T/z7sv5Bcfpj/2GYYIfwiixu8EBqDmu0Pl4j+gm2xwyQq/b3m4yePppBdRdSRt7Cy8/yEQKtXK2Ist4g72W5SznSxreO9kyfDKT550Q==
Received: from MW4PR12MB8611.namprd12.prod.outlook.com (2603:10b6:303:1ed::8)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 07:58:38 +0000
Received: from MW4PR12MB8611.namprd12.prod.outlook.com
 ([fe80::ea91:2ce4:e2be:85dc]) by MW4PR12MB8611.namprd12.prod.outlook.com
 ([fe80::ea91:2ce4:e2be:85dc%5]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 07:58:38 +0000
From: Wael Abualrub <waela@nvidia.com>
To: "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>, Ali
 Alnubani <alialnu@nvidia.com>
Subject: DPDK release candidate 25.11-rc3 testing report
Thread-Topic: DPDK release candidate 25.11-rc3 testing report
Thread-Index: AQHcXeFOldpNok8GVUqSB81q96FXLw==
Date: Tue, 25 Nov 2025 07:58:38 +0000
Message-ID: <MW4PR12MB8611AB2374F9992ECB7B8937D6D1A@MW4PR12MB8611.namprd12.prod.outlook.com>
References: <2831295.atdPhlSkOF@thomas>
In-Reply-To: <2831295.atdPhlSkOF@thomas>
Accept-Language: en-US, ar-SA
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB8611:EE_|MN0PR12MB5978:EE_
x-ms-office365-filtering-correlation-id: 5773b860-7aa4-4811-ef38-08de2bf870fa
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|13003099007|7053199007|8096899003;
x-microsoft-antispam-message-info: =?us-ascii?Q?6B6wv8DJPnBwZtbR+JTf/vbf5UVOo7L4vl/JbmcIKwJqr36qLTRXZxqy7Qf/?=
 =?us-ascii?Q?qgPW5ECKUfa25uYu8UM80pJm71m7DJw8xWFI5q6fZZ5WKygB+iHrxGOtbtX8?=
 =?us-ascii?Q?qLomw+SBPRP7wS/p1UZkQLqup7EWajsFd/I3r+P7+cnFLfTiU3NfkCfIsJMP?=
 =?us-ascii?Q?jdlgWl1Aohs/yWLGK52XDSuk+7Jr1E+mX7CIxHDBHJcoG2t4T7QOgahxS9Xu?=
 =?us-ascii?Q?G8msCrq5vEpCYTi7kS/4dvvvSA54xznN+zucQ7/zH5SkJmQy/TiB/ieUFfsL?=
 =?us-ascii?Q?0p5bC3qS3upy+HixPXomD8qq3tR8mjEej8QuPVUl7YUZBgfN2nMjAaSeX4aZ?=
 =?us-ascii?Q?f12ERTvNd6ANLPZQBaQuiAirCXkttsnBLcdstuCCFuIySg8p99TxqZlHq/2h?=
 =?us-ascii?Q?hWfKP5JN5vdshnpoCtcpY//3fk7i2Fi8f3BXBT5n2JYK5AT27RI30+CWmM8P?=
 =?us-ascii?Q?XuXhQOfiCBHs5DvTTpKwhm2tBg4dCe6ChwHP4SR2LLOx2EmXWVuelelwno7r?=
 =?us-ascii?Q?8q9nv/sSemr8FVn8YaVejTcPi+cRAnYS8hFQf1gJD/Ouc1f6ueJMwYNJk534?=
 =?us-ascii?Q?yTtEMHpD3/UDQvnKMnUWb4KRXj7/pTgWjpS1ch7LnLDKzPv2VlIUWM2W5fHY?=
 =?us-ascii?Q?a7ThVPKIfWCOv3rpTSzKroE5yZh9oDJtWN2xa13ztCSdhl4rHKeIpWjmKpjo?=
 =?us-ascii?Q?NsAGzdlQ3ls/ULx9FUaxbBTfr79yckYhO0evSuoRRt/Z9KoX3Kas8i2Tv1KO?=
 =?us-ascii?Q?MSCuJRXrhFHtny3Kmedd6cMm6tYM/3M4z2AB3ujkkCf7yJM5s0V35J3+MeMP?=
 =?us-ascii?Q?9EFU0UWfhTWExHV6BCrtx8MJBp96sdBYN6WFRIPQ9cMpJ0l+/M6EaWkmPrwG?=
 =?us-ascii?Q?faeRg7P3tiOz6eeDAUkTcxDYelLqwGAVqjCUti6h5S8iJeGmqyDJUEPm9zgR?=
 =?us-ascii?Q?/o0ngm4dO5h9L8vU8mJiFCD8vmseyBSdhLj+4a0l1Xv1QGK27gLd1qDJvBLr?=
 =?us-ascii?Q?U1RYE9nNJrTQ4jvlCQpxEoQIWJVFlytMijjBBeynDzK+IeNynyU2PKuPHQW+?=
 =?us-ascii?Q?9Rb2wGThQQB8fLjA494hTzedPmtgbRVa3Hf31+t/2UUEvmb0x+wULEJxL8hG?=
 =?us-ascii?Q?Qyx4Yy5ackZJFVBdUFuYWmuxJ+CFBW3Gg3+aDdUKsckFSsRh9oN+FDh9yRvo?=
 =?us-ascii?Q?5Y07VoEY1iTVIzc5ZavhOJudgdJEdWDH38AImnuHqJgdfAPwSIs505z8lGJo?=
 =?us-ascii?Q?UwW9p2LJOTqJr4PBcXTT+Dx5VU6kT6woGJ5ETfMaxk8AjbpnUkL9Z5TwaE6C?=
 =?us-ascii?Q?syBrnejOg1mUdEhr4df8c+3Ar6FRLJydcH5RacBW925CEoDpFzHveBOR0Kx9?=
 =?us-ascii?Q?CNv6VEjgprblZbyNR8h4myjFXBobtj1Tt4bWy5zVevQnOIIzAklDsrHfl8gF?=
 =?us-ascii?Q?U1i5oH2XREzocTGXpJcGX5ZKZ+L24+2BYWmO69Af7UScSdMY9WN+VULeOh7O?=
 =?us-ascii?Q?DgsFsM0KjpeWa3ceDmFB001VxAOvb67EgG7k?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB8611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(13003099007)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NgmBbju6ElSB18n7SLgfrK57/9ZG3MG2SSmJdUUW+l/87rtY7zKAhJcHp5/3?=
 =?us-ascii?Q?4qR1pAIWrOqpt5j69UpcoNdp0wSeNq2ZA487m6R600/+YjVsjoy1xcRaCmdS?=
 =?us-ascii?Q?VfRtkF8K97/PKgnk4JLgZlazfP5JgN7PMyG4H/i7LZMegMiUGcCbM+HdwjK2?=
 =?us-ascii?Q?3GIUHPXwV1tChoGkSX0ozQL5bYx+s00kDI93V5Hnzon4Xjf+uVpKf32x2hfK?=
 =?us-ascii?Q?Xel/v2lLcowmM0KL6JaWk4h8JMkypzb5g1DM+EdN46tghVHF8ppl/tejIyqW?=
 =?us-ascii?Q?EEnsav9LmQAJzy2CQT1XfgM3tQEeKDZfkS98RDZR7RcL7cmCwU0VcDFqzi8T?=
 =?us-ascii?Q?TA3mQzZETst43mkfW1WdNreFzZkURaw6RUwEaSbnngfEne/yQfjWvgtqY/fU?=
 =?us-ascii?Q?Hg9ghNE7lsCDZOiX1RoFa2PVeQ1j0fNO2L0kCQFej9pm5OgHtMaJJG7frmIi?=
 =?us-ascii?Q?fI1YLr93t7w1QHZ6+pnrAyx3aELLa0eWNraFVzr+xgE9jrxvOqtXtnf3o9Rp?=
 =?us-ascii?Q?GuAYAx3XGx+qTBuNjAs+E6Hj2bA1zvxpcMxOZ4b4zR2M2xqQPu+tgHmjB/16?=
 =?us-ascii?Q?a0/x4UQo6QIoziS80zke9HyE1mqvCrjYMSmcCwNO9Id7LcvdTC+m5TaRvXs9?=
 =?us-ascii?Q?6mAFjR1Lxuc9Q9gtUueGTa7WfyyZN07c/cX6YbddIudaEUYASdn8mAuT4/f7?=
 =?us-ascii?Q?abPLExFvMs69ZIQpeHnEaDAFqMnDMas5EaIYd8Qtf+7SFcsiYVYA5sdCr9QH?=
 =?us-ascii?Q?peOJ5dZVX6zZcTskEVrhvap5gvU0agDTVaoyj9iVnisE0AXr0LXJ/O1IodtB?=
 =?us-ascii?Q?X/Dz5SMrd7uVGoJjzStDiSSodkr8QvwUxeD/KdXxS0rdSpdXBdGu60sCnC1p?=
 =?us-ascii?Q?ZCKCf2gfxjSlYuLPy63pF+Rde8F+KcOy1a3l+XposVCkpo0w/ThgCG+iaBDu?=
 =?us-ascii?Q?LHxEafJi4tW3Prj60B859h0/j7tFEvnLhBf6gMobDPCY3b8M/rDufuy1bAx5?=
 =?us-ascii?Q?Nyaok65fylnBHWm0MRnmtflXezNvmFcbV97WMBjEanRO70EExFnewY/9zmJ9?=
 =?us-ascii?Q?vd46LFp0yZugFaOdNNF4J03Rzdc7SiYu42BY2vLT3pWKwrLw5qrqKl2piBD1?=
 =?us-ascii?Q?wP1wQ7sptv5GpnarhX4JaAzO4+iDUuhjTbEKi29x71ZkQcJeiA7C/Xj3Jh2W?=
 =?us-ascii?Q?SavtQkk2fuyHwLaLak1DDLnXvbEuWOqV3JlPwQBu3fI4h8A4rEKaRHHS/voF?=
 =?us-ascii?Q?l119KQrzh2Pr2Tjtp7Y/+RmMUMohRahiTHpB4zmdF6qF4AphlREHKRnvKv/f?=
 =?us-ascii?Q?mWR0v9pl9Llgut4E/nHIrSxmHXrqYHXOCES3DHb8Uq0vYkJtoufArHF5pqkC?=
 =?us-ascii?Q?San11oVZ3VXAeZzjt7+bO0b+su9Rik7AF3VZLONyf0hLVKEH+xC1KK+mFs6o?=
 =?us-ascii?Q?A4+2UJcP1NFx7mKa7ync38qW6WzU9xtrdAGjmgZjN/ZYpimL2GSEqH277Gzh?=
 =?us-ascii?Q?XkhYQ8sA4pPtn5kV+OQ963idvus7oxZND3b6LkPOTVR3n8MM+4JL4Y8om++5?=
 =?us-ascii?Q?oCHF9mQPyZu0Sz+wSVnqXsECgQa1lp79UaZJnDWk?=
Content-Type: multipart/alternative;
 boundary="_000_MW4PR12MB8611AB2374F9992ECB7B8937D6D1AMW4PR12MB8611namp_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB8611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5773b860-7aa4-4811-ef38-08de2bf870fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 07:58:38.0348 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NRQcgT0CoKyq7lTOLbptME0rFuH4fuFeqAwNA4AY/muWAuzoYF7DKEE9xBuIevDDTDwWpXLm0Ucw/sNVxwKLMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978
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

--_000_MW4PR12MB8611AB2374F9992ECB7B8937D6D1AMW4PR12MB8611namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

> -----Original Message-----
> From: Thomas Monjalon <thomas@monjalon.net>
> Send: Wednesday, 19 November 2025 at 6:51
> To: announce@dpdk.org <announce@dpdk.org>
> Subject: DPDK release candidate 25.11-rc3
>
> A new DPDK release candidate is ready for testing:
>         https://git.dpdk.org/dpdk/tag/?id=3Dv25.11-rc3
>
> There are 98 new patches in this snapshot.
>
> Release notes:
>         https://doc.dpdk.org/guides/rel_notes/release_25_11.html
>
> Please test and report new issues on https://bugs.dpdk.org
>
> The next release candidate (-rc4) is planned for Monday 24.
> Patches and reviews for examples, tooling and documentation are welcome.
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

Kindest Regards,
Wael Abualrub


--_000_MW4PR12MB8611AB2374F9992ECB7B8937D6D1AMW4PR12MB8611namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p class=3D"MsoNormal" style=3D"margin: 0cm;"><span style=3D"font-family: A=
ptos, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">Hi,</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0cm;"><span style=3D"font-family: A=
ptos, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"><br>
</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0cm;"><span style=3D"font-family: A=
ptos, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&gt; -----Original=
 Message-----</span></p>
<div style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
&gt; From: Thomas Monjalon &lt;thomas@monjalon.net&gt;</div>
<div style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
&gt; Send: Wednesday, 19 November 2025 at 6:51</div>
<div style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
&gt; To: announce@dpdk.org &lt;announce@dpdk.org&gt;</div>
<div style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
&gt; Subject: DPDK release candidate 25.11-rc3</div>
<div style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
&gt;</div>
<div style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
&gt; A new DPDK release candidate is ready for testing:</div>
<div style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
&gt; &nbsp; &nbsp; &nbsp; &nbsp; https://git.dpdk.org/dpdk/tag/?id=3Dv25.11=
-rc3</div>
<div style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
&gt;</div>
<div style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
&gt; There are 98 new patches in this snapshot.</div>
<div style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
&gt;</div>
<div style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
&gt; Release notes:</div>
<div style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
&gt; &nbsp; &nbsp; &nbsp; &nbsp; https://doc.dpdk.org/guides/rel_notes/rele=
ase_25_11.html</div>
<div style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
&gt;</div>
<div style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
&gt; Please test and report new issues on https://bugs.dpdk.org</div>
<div style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
&gt;</div>
<div style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
&gt; The next release candidate (-rc4) is planned for Monday 24.</div>
<div style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
&gt; Patches and reviews for examples, tooling and documentation are welcom=
e.</div>
<div style=3D"font-family: Aptos, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
&gt;</div>
<div style=3D"font-family: Aptos, sans-serif;"><span style=3D"font-size: 12=
pt; color: rgb(0, 0, 0);">&gt; Thank you everyone</span><span style=3D"font=
-size: 11pt;"><br>
<br>
</span></div>
<p dir=3D"ltr" style=3D"text-align: left; text-indent: 0px;"><span style=3D=
"font-family: Aptos; font-size: 14.666667px; color: rgb(0, 0, 0); backgroun=
d-color: rgb(255, 255, 255);">The following is a list of tests that we ran =
on NVIDIA hardware this release:</span></p>
<p dir=3D"ltr" style=3D"text-align: left; text-indent: 0px;"><span style=3D=
"font-family: Aptos; font-size: 14.666667px; color: rgb(0, 0, 0); backgroun=
d-color: rgb(255, 255, 255);">Note: all tests are passed, and no critical i=
ssues were found.</span><span style=3D"font-family: Aptos; font-size: 14.66=
6667px; color: rgb(0, 0, 0);"><br>
<br>
</span><span style=3D"font-family: Aptos; font-size: 14.666667px; color: rg=
b(0, 0, 0); background-color: rgb(255, 255, 255);">- Basic functionality:</=
span><span style=3D"font-family: Aptos; font-size: 14.666667px; color: rgb(=
0, 0, 0);"><br>
</span><span style=3D"font-family: Aptos; font-size: 14.666667px; color: rg=
b(0, 0, 0); background-color: rgb(255, 255, 255);">&nbsp;&nbsp; Send and re=
ceive multiple types of traffic.&nbsp;</span><span style=3D"font-family: Ap=
tos; font-size: 14.666667px; color: rgb(0, 0, 0);"><br>
</span><span style=3D"font-family: Aptos; font-size: 14.666667px; color: rg=
b(0, 0, 0); background-color: rgb(255, 255, 255);">- testpmd xstats counter=
 test.&nbsp;</span><span style=3D"font-family: Aptos; font-size: 14.666667p=
x; color: rgb(0, 0, 0);"><br>
</span><span style=3D"font-family: Aptos; font-size: 14.666667px; color: rg=
b(0, 0, 0); background-color: rgb(255, 255, 255);">- testpmd timestamp test=
.&nbsp;</span><span style=3D"font-family: Aptos; font-size: 14.666667px; co=
lor: rgb(0, 0, 0);"><br>
</span><span style=3D"font-family: Aptos; font-size: 14.666667px; color: rg=
b(0, 0, 0); background-color: rgb(255, 255, 255);">- Changing/checking link=
 status through testpmd.</span><span style=3D"font-family: Aptos; font-size=
: 14.666667px; color: rgb(0, 0, 0);"><br>
<br>
</span><span style=3D"font-family: Aptos; font-size: 14.666667px; color: rg=
b(0, 0, 0); background-color: rgb(255, 255, 255);">- RTE flow tests:</span>=
<span style=3D"font-family: Aptos; font-size: 14.666667px; color: rgb(0, 0,=
 0);"><br>
</span><span style=3D"font-family: Aptos; font-size: 14.666667px; color: rg=
b(0, 0, 0); background-color: rgb(255, 255, 255);">&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &nbsp;</span><span style=3D"font-family: Aptos; font-size: 14.=
666667px; color: rgb(0, 134, 240);"><a href=3D"https://doc.dpdk.org/guides/=
nics/mlx5.html#supported-hardware-offloads" title=3D"https://doc.dpdk.org/g=
uides/nics/mlx5.html#supported-hardware-offloads" data-ogsc=3D"" data-outlo=
ok-id=3D"77900450-a898-4bd8-a6cb-2752b06bee1f" style=3D"color: rgb(0, 134, =
240); margin-top: 0px; margin-bottom: 0px; text-align: left;">https://doc.d=
pdk.org/guides/nics/mlx5.html#supported-hardware-offloads</a></span><span s=
tyle=3D"font-family: Aptos; font-size: 14.666667px; color: rgb(0, 0, 0);"><=
br>
</span><span style=3D"font-family: Aptos; font-size: 14.666667px; color: rg=
b(0, 0, 0); background-color: rgb(255, 255, 255);">- RSS
</span><span style=3D"font-family: Aptos; font-size: 14.666667px; color: rg=
b(0, 0, 0);">testing</span><span style=3D"font-family: Aptos; font-size: 14=
.666667px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">.</s=
pan><span style=3D"font-family: Aptos; font-size: 14.666667px; color: rgb(0=
, 0, 0);"><br>
</span><span style=3D"font-family: Aptos; font-size: 14.666667px; color: rg=
b(0, 0, 0); background-color: rgb(255, 255, 255);">- VLAN filtering, stripp=
ing and insertion tests.</span><span style=3D"font-family: Aptos; font-size=
: 14.666667px; color: rgb(0, 0, 0);"><br>
</span><span style=3D"font-family: Aptos; font-size: 14.666667px; color: rg=
b(0, 0, 0); background-color: rgb(255, 255, 255);">- Checksum and TSO tests=
.</span><span style=3D"font-family: Aptos; font-size: 14.666667px; color: r=
gb(0, 0, 0);"><br>
</span><span style=3D"font-family: Aptos; font-size: 14.666667px; color: rg=
b(0, 0, 0); background-color: rgb(255, 255, 255);">- ptype
</span><span style=3D"font-family: Aptos; font-size: 14.666667px; color: rg=
b(0, 0, 0);">report</span><span style=3D"font-family: Aptos; font-size: 14.=
666667px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">ing.<=
/span><span style=3D"font-family: Aptos; font-size: 14.666667px; color: rgb=
(0, 0, 0);"><br>
</span><span style=3D"font-family: Aptos; font-size: 14.666667px; color: rg=
b(0, 0, 0); background-color: rgb(255, 255, 255);">- link status interrupt =
using the example application link_status_interrupt tests.</span><span styl=
e=3D"font-family: Aptos; font-size: 14.666667px; color: rgb(0, 0, 0);"><br>
</span><span style=3D"font-family: Aptos; font-size: 14.666667px; color: rg=
b(0, 0, 0); background-color: rgb(255, 255, 255);">- Interrupt mode using l=
3fwd-power example application tests.</span><span style=3D"font-family: Apt=
os; font-size: 14.666667px; color: rgb(0, 0, 0);"><br>
</span><span style=3D"font-family: Aptos; font-size: 14.666667px; color: rg=
b(0, 0, 0); background-color: rgb(255, 255, 255);">- Multi process
</span><span style=3D"font-family: Aptos; font-size: 14.666667px; color: rg=
b(0, 0, 0);">testing</span><span style=3D"font-family: Aptos; font-size: 14=
.666667px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">&nbs=
p;using multi process example applications.</span><span style=3D"font-famil=
y: Aptos; font-size: 14.666667px; color: rgb(0, 0, 0);"><br>
</span><span style=3D"font-family: Aptos; font-size: 14.666667px; color: rg=
b(0, 0, 0); background-color: rgb(255, 255, 255);">- Hardware LRO tests.&nb=
sp;</span><span style=3D"font-family: Aptos; font-size: 14.666667px; color:=
 rgb(0, 0, 0);"><br>
</span><span style=3D"font-family: Aptos; font-size: 14.666667px; color: rg=
b(0, 0, 0); background-color: rgb(255, 255, 255);">- Buffer Split.</span><s=
pan style=3D"font-family: Aptos; font-size: 14.666667px; color: rgb(0, 0, 0=
);"><br>
</span><span style=3D"font-family: Aptos; font-size: 14.666667px; color: rg=
b(0, 0, 0); background-color: rgb(255, 255, 255);">- Tx scheduling.</span><=
span style=3D"font-family: Aptos; font-size: 14.666667px; color: rgb(0, 0, =
0);"><br>
<br>
</span><span style=3D"font-family: Aptos; font-size: 14.666667px; color: rg=
b(0, 0, 0); background-color: rgb(255, 255, 255);">Kindest Regards,</span><=
span style=3D"font-family: Aptos; font-size: 14.666667px; color: rgb(0, 0, =
0);"><br>
</span><span style=3D"font-family: Aptos; font-size: 14.666667px; color: rg=
b(0, 0, 0); background-color: rgb(255, 255, 255);">Wael Abualrub</span></p>
<div dir=3D"ltr" style=3D"text-align: left; text-indent: 0px; margin-top: 1=
em; margin-bottom: 1em; font-family: Aptos, sans-serif; font-size: 11pt;">
<br>
</div>
</body>
</html>

--_000_MW4PR12MB8611AB2374F9992ECB7B8937D6D1AMW4PR12MB8611namp_--
