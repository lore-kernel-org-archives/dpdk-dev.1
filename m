Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08618C83F03
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Jul 2025 14:07:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E089D4025F;
	Sun,  6 Jul 2025 16:07:45 +0200 (CEST)
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com
 [207.171.184.29])
 by mails.dpdk.org (Postfix) with ESMTP id BFFA84021E
 for <dev@dpdk.org>; Sun,  6 Jul 2025 16:07:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1751810864; x=1783346864;
 h=from:to:cc:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version:subject;
 bh=cE3q3SRNJ2i+dVGc4MpuXrrugrpgM+2tz3BxfM0E+Kg=;
 b=LA45DOmnm0+E6tbJgFFfDSxp7cbTCU8hLBKBG/IxvqDYrLcvu9os2k34
 OdE4ObuK5X4wHP9bDywO8iGSlO1c7EQ3rINWQhTyulFp4LMC0pd80bus5
 cgg0a1UMXAyVmW12iCqz3x85rkU/Xd9LUaAKMwaI4e9ocp9TjumRmWEeG
 oEgP/0NQb012yDBwE25orf2UEzrJECQLsOjQn/rdXgBwKgVfpvX7Bv2+b
 xvh/44aLGgrNK61G+E4Nvd2Zfj6gOQCRM0HV46EQaQzpY43y4OHZl54US
 gWRrLb5wmRouumqxf+K85m69X0H4MJf7fgexZqNyBn8UN0SdI6bueJUAi A==;
X-IronPort-AV: E=Sophos;i="6.16,292,1744070400"; d="scan'208";a="536560382"
Subject: RE: [PATCH v4 0/7] net/ena: release 2.13.0
Thread-Topic: [PATCH v4 0/7] net/ena: release 2.13.0
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
 by smtp-border-fw-9102.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2025 14:07:42 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.29.78:23357]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.59.125:2525]
 with esmtp (Farcaster)
 id a4439334-19d3-4e3a-bf17-57b88f1f5d42; Sun, 6 Jul 2025 14:07:41 +0000 (UTC)
X-Farcaster-Flow-ID: a4439334-19d3-4e3a-bf17-57b88f1f5d42
Received: from EX19EXOUEB001.ant.amazon.com (10.252.135.46) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 6 Jul 2025 14:07:41 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.252.135.42)
 by EX19EXOUEB001.ant.amazon.com (10.252.135.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14
 via Frontend Transport; Sun, 6 Jul 2025 14:07:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrMYtIddItOUDqzcP2+T/DZw8/JztFOwWYin24x8CIx0Y/1R5IcXXf6fCdyGdV0V+nq4dV23ggij4NSSj3p/M0J1gc36jS6AB4PRe20CWH1/hB5x7Iczi+N9Tq9KkDeejUd8AdMvwHSB7mAmRbDeI3lipf7zRt0epOtkJlmiBxKou0ECNLu32P3tMIyVFZy0OWkXsygYw1tcb1LjNSHcqbvZiD/3hqP6yctULc2tdGQezzBgnaBN3EBuE6MKumoLmnhZp77v6abOc75rcgtHmktI5lJ+sjSae2Z2xIdoWsMC58BykfqVdrLZUBuioFNl7Z3roiUgNmj3Pbk7v8uuFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cE3q3SRNJ2i+dVGc4MpuXrrugrpgM+2tz3BxfM0E+Kg=;
 b=enF6GWSlmbQGke8pw/qSSjAVj4xvDh/uUzOGkyqndefAPU6xJzjVUtNVqRSm6cEr5OfFKkxD4U0emWVrfthWd7rhuJEguIs9ZT2L6fMI4hDYpcYxadbdHHJwnk96Mb8EqQRCP5HH+lsIiiFffQjKjehRYLTF9ShXBQL8GbDGn1GlwqQPKhWgvCmEhA/9v2pvDlbI4EQxv4O4ubn+kH5/DuP6qEDb6r0qnqNht3+Tf6zrR9w4N0WU/Pl5RQKvRYb7YTEcbTrgiVqcNdCZol9twg3U1xxogG1B1bum74pFVyOacTIG48fUYQc6LT9qXk/uQxjAsbHza2ZxDFX8/tu6Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.onmicrosoft.com; s=selector2-amazon-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cE3q3SRNJ2i+dVGc4MpuXrrugrpgM+2tz3BxfM0E+Kg=;
 b=Pd9zPNwRyZk57/QiEKAjsj1EgS76Qv42R8YRZvqOoBshqWX8Woqiva3ia0TIPNhUL1GAV8wnfnbkLhtxPTaRLSJK3hpsuVfLJsAiTj+bxg/VuLJy7XAufYyXiVZ+qu7mK7t/foDCL6bvePYQ9WV6iw5RjcmhYjqKxSEQVvqxfmw=
Received: from BL1PPF6F1353624.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::da0) by SA1PR18MB6402.namprd18.prod.outlook.com
 (2603:10b6:806:468::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Sun, 6 Jul
 2025 14:07:39 +0000
Received: from BL1PPF6F1353624.namprd18.prod.outlook.com
 ([fe80::d6dc:769d:2626:b65d]) by BL1PPF6F1353624.namprd18.prod.outlook.com
 ([fe80::d6dc:769d:2626:b65d%7]) with mapi id 15.20.8835.034; Sun, 6 Jul 2025
 14:07:39 +0000
From: "Brandes, Shai" <shaibran@amazon.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Thread-Index: AQHb6RXdQA5MFp0IjUCTPfPSSzZbLbQbiYmAgABCEwCACV/zIA==
Date: Sun, 6 Jul 2025 14:07:38 +0000
Message-ID: <BL1PPF6F1353624747BD7280C05E6B65201AF4CA@BL1PPF6F1353624.namprd18.prod.outlook.com>
References: <20250528102531.9876-1-shaibran@amazon.com>
 <20250629094931.05268741@hermes.local>
 <6be9d6041a3e4cdea8ed6609c32f9b38@amazon.com>
 <20250630075434.02a990e6@hermes.local>
In-Reply-To: <20250630075434.02a990e6@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PPF6F1353624:EE_|SA1PR18MB6402:EE_
x-ms-office365-filtering-correlation-id: 2c0b1b1d-7ba7-424a-cc4f-08ddbc96774e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Z8qmvN56N5VEFHlXuId/5aH9ylVX6virCF7woMtmvJXkOYJ8vt/34LFhURCY?=
 =?us-ascii?Q?byJV4w1V5NlLlx6UUMiun1Gu252Ki+FkrB++jH/ClPRv0fbBLlmTsuMDq10Y?=
 =?us-ascii?Q?oqpI3sqn8h3j2EQQ/EDhCtwc3zWijvoiZH3gjTFV8QkMF9L8innvvXwcSJcs?=
 =?us-ascii?Q?RJ5TpXOgRqZSsQFphhXmkS9kvrP2lVVFEKVcFbO23mpppC+Ax0ExTHLFoOmM?=
 =?us-ascii?Q?53pnEXNOHDQ04IeuN7Cp5TSOnZ8DCzm28KzyDG/4CiDiE77a40hhaAv9Dejb?=
 =?us-ascii?Q?M7TSiR/K5+CdP0G8BxGy5RUecETmPQ1Gc4lzBxSpqGryOftxX6OTwcsYTu2r?=
 =?us-ascii?Q?DD9WxH/XyAFQgqCKAk2sGZDrlcohkK0CK/4HCL+6X5RVfxS6DIkGvpUnTg24?=
 =?us-ascii?Q?aNRnyYwUMp7JFlO7Kt4Y6m61rNKeqpEULpVtxi/CGEnCMBREtEh4JkcAt2Yc?=
 =?us-ascii?Q?woP/l+fkwM/umeapgpuSP2p+YPB4/uz3A7TlMIywM0v6B/eC/WnT16abnHgE?=
 =?us-ascii?Q?tas/BRhojiHoJOmLqbsrSr0RLFRN9CIAbxyQEMimInJ10qYxGMu9zdY149v8?=
 =?us-ascii?Q?9CGjAwfLpRPayimY86V2n02mwwlX8tHbMypNfCbiFOi5fXdAbcAJTZyhzYaY?=
 =?us-ascii?Q?ZeC9zBj3s49sByKlV1l44s9mEo1y7aXy17JENejI4Nv5k3SlHDiAodYzHuke?=
 =?us-ascii?Q?foQLFRUyspV3bEgyhFZzSkhtCZT7IlCdU5Ck4sC4Ed8wWUxN5z9TqyQFSUkN?=
 =?us-ascii?Q?67DsqO+KLKRguWTanhiBu/k/9VC0ujiEAMD4liJ+htPa2LNVQabo0TtaW2qS?=
 =?us-ascii?Q?6xnYK2P4kHCYRxfNZ7XVGvoOAo2GzWr+0NGf6TCL6Qq0MN1yT9hlAyCFoe1p?=
 =?us-ascii?Q?CvBXuDGobHLjAYsrmE6nojIJiXee2RpLriYf26dUEdsu93+vdKmfBhj0jA1k?=
 =?us-ascii?Q?WE9STm0d4i/ryyLR3bfCMDROanbo/STN752UhUH5vuDqvi3ur3JYOhLV0slq?=
 =?us-ascii?Q?7bO2NI8T4Rp68PvnRVX4rOtefPokuZWVHpwaYo2+fubkEogN5RDI0DuF2hB5?=
 =?us-ascii?Q?n9gj7wOjQ9x9rEDxQSOyhfoR/L/DQf+fTJ8gElO0ETgwUP0+UJiJAWBaZIW5?=
 =?us-ascii?Q?BuVItb6jRJQaDGBfptI/dx2DzeFaheyj+G9832bvnpHulONtdNYPPbQfz1qn?=
 =?us-ascii?Q?CseyavuMk3FHGzY9ZGkhDyz8W3L77eMN7LikC9kqe4XJNVeKSVnlnD4gRFUK?=
 =?us-ascii?Q?h5eh5oavnlsEtVhzEJq/JU6o7ersIil24DQoq3MhhW872TLdhLYi7Hx1N2We?=
 =?us-ascii?Q?ajSWK+TURgwEwuPnQJvx8ARpcOw+uBB72dp6EGGprjezIVukmlidiQirofba?=
 =?us-ascii?Q?SjbyLZakR1nVJX6eK7IlEfb+Ykpiec9lkcs1AeWcokSUamZXWAWVyTITEprt?=
 =?us-ascii?Q?3AOKk3vxbFITo3aGJKG+m8BXteeJ0iI8DJBFd2RuZKH1Nyj6+DN/nw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PPF6F1353624.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZW/L4XXQTI86xTNXSaMiEI3+NI5deolZfAqXOthlF18wPeiucXTkwTcpmUhc?=
 =?us-ascii?Q?8FzWCfNWGetHhxp4yADYgWqTV8yh7l2kpLir2Dtp7llaey02mNLdomtVoavD?=
 =?us-ascii?Q?FfVHmeVc0oLZirbIpsc6rGEvho0BwLoFPAVH3G1/vbOWL0NRWKckBiTy5wMQ?=
 =?us-ascii?Q?zKSP7TRPC92OIxyqXYY7sGRpzigNHxpWP5cX6uwqoy7ny9TRW4deP7P6byG5?=
 =?us-ascii?Q?BwTV/GGi0SAaLyDbCcq5WIUvEqbvijvjs+n1W3etbn+0L+HMADr5kOkBULQB?=
 =?us-ascii?Q?YnnIPzwzgOO1Tzelpp9Hd1oc9WZhv6ndsr1EXP/0HlhjZA7tpf+quRgNkz+F?=
 =?us-ascii?Q?6jVPEcJ1pIp5DzuH6hLWBzzRBemDhoZl8fQgRhPQ+Dgh/WIvHcCsmCHkzjWZ?=
 =?us-ascii?Q?/2bsSvQVe5vKD9t/PbSCVugomlbqs0CHIqdlrfpfOVbpXcYVf5H2Jy9PDhzT?=
 =?us-ascii?Q?jL0uR36zfAgtVlippAj68tSzR6FTEpzBYQF/gvDUQ6rD8iC2k5vLGRNzjOb2?=
 =?us-ascii?Q?LeH27LR0pJ9f9OnJCJlbQOcvpdLpfGfuxHDa0Xh7LylrypC73+VTof8SjcJ+?=
 =?us-ascii?Q?wJbbJ1uVmSmCy1OylW/TmDES+gadSaIyNY2qyOHqXgIvffgw9x0l6hRC9TvV?=
 =?us-ascii?Q?I7RsxVTXV61qmCXWofbSLqezPvYl7zP77iKLnb2G1+/73jOQduOAlMWAguGT?=
 =?us-ascii?Q?fMM+rfott1Pni/ymLEGYiY5TESusiMvQXLBl1tv1uwKlvFWKlVx6y/DH9rb+?=
 =?us-ascii?Q?foMjYOOeAr9j0nv2Dx6muK8pTAC+9DYjh/rWqzHJvTqOQ7ZmLmYwrKsyrIvL?=
 =?us-ascii?Q?TmzgSDQUUEGWZBfOj2nChFuNa9BGAtitgKUmvSdaW1rF/dkApch3oiRpm5tO?=
 =?us-ascii?Q?PZYeLsGRc6oODcr+NvGU3ioGuc2KMjOLnU2TYTnq8o3KNdNzIR2KJFK1zfM4?=
 =?us-ascii?Q?yNrGbcrVzih5BQSkZsp9PD7U4PCTwmcmtpycXPy3s3MQdxn4ZCBU4VJbeBFI?=
 =?us-ascii?Q?LJriHCSqj7+8YoIIxCbhV8On8VCrYJaDLwL4X9abOtaYw56G90jDbZmwPxQ6?=
 =?us-ascii?Q?Tjy4KkRdkzbyy3Sz8SZWRVjPvFqTi4Y+nt+r4BQYUrPoWqhvVXzk/PYZ0DTv?=
 =?us-ascii?Q?eEsm1eVVDPXrITjWi6ta2ZhwoJ9J+H4EIozhtWGwfqwE68GqokeM+o2nhpFn?=
 =?us-ascii?Q?9zRvJMIxlrikZ7K6zy5Qbk3BZpUXpXzBofjl2xzuxMkJ4e48vQVRfoWKw9Ju?=
 =?us-ascii?Q?owtWkm+eFq5WkMELQ9PPOmN5/klFcNBPfd39i0jqXo9/kXQkVzkoiMgnJYrs?=
 =?us-ascii?Q?XKPJ3RN7YwklIIa4NO/stFTE5TxTdhX2yfbVoJnyZDjdV5dH9iqcGdiAzVtz?=
 =?us-ascii?Q?psrw7oEzLdIWzL6xD/VsX0HtE4KlYpdgU8QKemzNxdOJJQb7lPfble0uqdEi?=
 =?us-ascii?Q?MMOfYcmIZx/11A6ETMDdrC08OoV27MHrXQwYD5miN0pJNS0yGeLp3uZnvOVq?=
 =?us-ascii?Q?bXadBOOVOXTe7o6v4F3/Ob0LRkcX6+W2HVp0ESufKEh2kSdTnEBu1sNUuvxz?=
 =?us-ascii?Q?btNI5x5arA+uHg2vQY0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PPF6F1353624.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0b1b1d-7ba7-424a-cc4f-08ddbc96774e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2025 14:07:38.8747 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MBPCKGrDfwiZeLNBlAGPUm6r3D+pQv27fobJhi5Zqo2ZUjn4vO2rECfkOX79DRmc6RKzYv+t1kusaJf774esVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB6402
X-OriginatorOrg: amazon.com
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



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday, June 30, 2025 5:55 PM
> To: Brandes, Shai <shaibran@amazon.com>
> Cc: dev@dpdk.org
> Subject: RE: [EXTERNAL] [PATCH v4 0/7] net/ena: release 2.13.0
>=20
> CAUTION: This email originated from outside of the organization. Do not c=
lick
> links or open attachments unless you can confirm the sender and know the
> content is safe.
>=20
>=20
>=20
> On Mon, 30 Jun 2025 11:08:12 +0000
> "Brandes, Shai" <shaibran@amazon.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Stephen Hemminger <stephen@networkplumber.org>
> > > Sent: Sunday, June 29, 2025 7:50 PM
> > > To: Brandes, Shai <shaibran@amazon.com>
> > > Cc: dev@dpdk.org
> > > Subject: RE: [EXTERNAL] [PATCH v4 0/7] net/ena: release 2.13.0
> > >
> > > CAUTION: This email originated from outside of the organization. Do
> > > not click links or open attachments unless you can confirm the
> > > sender and know the content is safe.
> > >
> > >
> > >
> > > On Wed, 28 May 2025 13:25:24 +0300
> > > Shai Brandes <shaibran@amazon.com> wrote:
> > >
> > > > This patchset includes an upgrade of the ENA HAL, introduces a new
> > > > feature, and addresses three bug fixes.
> > > >
> > > > Thank you in advance to the net maintainers and community members
> > > > for your time and effort reviewing the code.
> > > >
> > > > Best regards,
> > > > Shai Brandes
> > > > AWS Elastic Network Adapter team
> > >
> > > Could you check against current main branch.
> > > This no longer applies, either it already got merged or something
> changed.
> > Hi Stephen, the merge conflict occurred due to updates in the release n=
otes
> after we initially uploaded the patchset.
> > I've rebased the changes on top of origin/main and will submit a revise=
d
> version shortly. I'll go ahead and abandon the previous set.
> >
> > Just a quick note, we originally submitted the patchset over a month ag=
o,
> and it has been in the "awaiting upstream" state since then.
> > I noticed that rc2 has already been released.
> > we would greatly appreciate it if you could include the ENA changes in =
rc3.
> > ENA is a self-contained module, and the previous maintainer approved th=
at
> mode of operation. Hopefully, an exception can be made in this case.
> > Thanks again for your time and continued support.
>=20
> Thanks, that version got lost in the huge patchsets that were sitting in =
backlog.
Hi Stephen, just wanted to touch base and confirm we're still on track to i=
nclude the patchset in rc3. Let me know if there's anything you need from m=
e to help move things forward.
Thanks!
