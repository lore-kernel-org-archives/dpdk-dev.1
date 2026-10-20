Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD25606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=dlHIRfbK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FFAF40270;
	Tue, 20 Oct 2026 09:29:53 +0200 (CEST)
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [52.42.203.116]) by mails.dpdk.org (Postfix) with ESMTP id 536B240144
 for <dev@dpdk.org>; Tue, 20 Oct 2026 09:29:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1792481391; x=1824017391;
 h=from:to:cc:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version:subject;
 bh=iEWySxKae2FwYBcGJ2tTfFggJ5v8D8vE6qTXOqcMSWw=;
 b=dlHIRfbKWd/1g7DUzO/l49qZlL8MHhLLhOkwEWF17FrbJ5AHszENMgLz
 ivZiFr8yAIkbLdUzhEA72xP6ZF3sWJTFlk/vbneJO0QFQxbQ4pgi2RavI
 TtnPhDfm0fRB1c6dmvbb3BvoxDjc9F083Au608gNSiUeTU6noVZrfr1o0
 UKEAPCATzj/uCkHKz12Y4IB5jQNFiQ7zlPAXoOPCwy7uALhpaauMYczh2
 6+vqvoVgMI7YYCoEajjwRv62AH040jQIi7FL28eSFZGkxsA551df5oMj3
 X3W6LdmTaQRlkN6LJ6L6CMVKuv7QXpz02hRu2pMt+F0H/qvu1/EiVcuxZ w==;
X-CSE-ConnectionGUID: 5hNbYWYMRX2tt1B7lm8E7g==
X-CSE-MsgGUID: Zc3Ah/9rRQCoAw+AfDiWZw==
X-IronPort-AV: E=Sophos;i="6.27,168,1787011200"; d="scan'208";a="31754498"
Subject: RE: [PATCH v3 00/13] ENA release 2.15.0
Thread-Topic: [PATCH v3 00/13] ENA release 2.15.0
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:29:48 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:31828]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.120:2525]
 with esmtp (Farcaster)
 id de6152bf-a363-4a9b-8de7-7407a4335117; Tue, 20 Oct 2026 07:29:48 +0000 (UTC)
X-Farcaster-Flow-ID: de6152bf-a363-4a9b-8de7-7407a4335117
Received: from EX19EXOUWA001.ant.amazon.com (10.250.64.209) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 20 Oct 2026 07:29:47 +0000
Received: from CY3PR08CU001.outbound.protection.outlook.com (10.250.64.206) by
 EX19EXOUWA001.ant.amazon.com (10.250.64.209) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49
 via Frontend Transport; Tue, 20 Oct 2026 07:29:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBuNXXVeUETdUg1EOennDJNaiDctRI2bHqwuYUFz9MtNC9Cu0mX/OTX5XrCFwP/t7lX002RN22eBLmMUKm7SwN3ir0+ajCbibCAf81V3JwRXb+rXIM33mv9g4KoLYcKn/7RSN7QtM1OPUbyp6bU9TLoreQNzF3TayxO5xpPheR3QYDNXwq4b66QoZV3Lv0vOajLJD0ww/QbS2QwNU1RHt9AVsPopoi3bQ8+862yEMXUsO0AIDxXtYr1yNR73DkFhoQSBlflhlyBXkANuoXZ3Hafus3e9XziAIYvwF1qFizu1OVv+Os/UIvMTdIcUNnpHnr1Z7EYbcGnisDUhxlIUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEWySxKae2FwYBcGJ2tTfFggJ5v8D8vE6qTXOqcMSWw=;
 b=MmyBEXy2Ygqp+1cE64BtpnMe7onL//m6PGsGWdZ2GrYINUAKlhgK+/6n0HkL4gEP6ZOFozrydeBoZVE6HMjqn6RMHICdF54F5YuDCyMWvZR9/6ppVOVaifXYPuOk1UzLJas0nrDzma7Onn8d4G0WYvDfvpeitrzzTZ18hclPUrMiBVDnO4TJFWA7h7iROOzbZ5lgmGsAuN8gQ93Ul96qPq/e38Hz+zStAUFTC6EQQX1YTDXZMF83ZyTYV8pT4I4psBXboWJPiQMu3344/1Cy6In7xkjhfz+MxoClwaJ+X9rqUmM3+BOvkyQ5/Zs1/AbPx4nDxUor31c7uxP6sfgVCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from DS2PR18MB927544.namprd18.prod.outlook.com (2603:10b6:8:32d::21)
 by CHBPR18MB434425.namprd18.prod.outlook.com (2603:10b6:610:407::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 07:29:45 +0000
Received: from DS2PR18MB927544.namprd18.prod.outlook.com
 ([fe80::80c9:539e:549a:e0a5]) by DS2PR18MB927544.namprd18.prod.outlook.com
 ([fe80::80c9:539e:549a:e0a5%6]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 07:29:45 +0000
From: "Brandes, Shai" <shaibran@amazon.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Thread-Index: AQHdXuV7MhFbD0JysUeSkXDdZqwbLrcFEYSAgAD08QA=
Date: Tue, 20 Oct 2026 07:29:45 +0000
Message-ID: <DS2PR18MB927544FFF8B0DC2BD0662D4421AF672@DS2PR18MB927544.namprd18.prod.outlook.com>
References: <20261018063606.973-1-shaibran@amazon.com>
 <cover.1792312029.git.shaibran@amazon.com>
 <20261019093405.2935bec4@phoenix.local>
In-Reply-To: <20261019093405.2935bec4@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS2PR18MB927544:EE_|CHBPR18MB434425:EE_
x-ms-office365-filtering-correlation-id: cc20aa35-68e1-42cc-371c-08df2e7bea43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|4143699003|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: E6UB5LDe8GXd+5b7HGUeJkqUUInI6yPohA/8cixWAibL7H24SagMvkExIG+gn3yLysNqyt/+S2kgm3X+0UBLINiqd5NOdLMMZNe8ddlivZRRLy6k/5HVwuE/pE9N/8zy5zJHvXk30IBNb05jEO7I/DWlq0tV1DFsngyZLo4EAEk0ZccThD8oLyIpXl78wQ39MDbVBhLeZHrwCXEoeiMKToMN2cHmUguzATDM/g7ViPJEdifvwAXpywkjJznnxCiMYOYy5CVO5nOUyfdqg2BlQIR4vfmJhFlan/PG2yOkf+nyQZtBw4S8YrzaZqQlf6OPzbAc8Wrr9hndKMR0yAWUURcXmQuk7W+FqCb/yvnsT7sT+s+XrM2EUfb0/vLvQ1aVrFx3eJsmT5UEhv1K8FfLwTng6FH+bg2drUoqOdkwyymwccyyhX9z2hqGM+x9hEjIhxzrqtN8fAwDujt7jmArgmVEqq7fNuBtDI1nbZAMwwKJBG4jmcXYfZmmg+Xg/qWrgTkLrNSdmYletYPIQ56bf9z00ZlOuRliWJ0BiO+TM6bW7sLBImLNx2F1VRBG7zemHctlXicSQ3MS2rT85w68gSxFkuzzFX8sZUeqLyXUevVpQ51Jo+P7z9Bibv1Hz+iF7p5KxLDc8hNU282MaJFPiadTvUl1HvbsPNSEEbU19W4vDEyxhT54lbEEydUXg1/M22vnYflzTdC52c6hvrR6tWrL1KeiLX5LAFe5C2kRptQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR18MB927544.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(4143699003)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bbPkxg9LR3SOTVySoLgM5KXfy8J7SdkgCZyDG3SUdhk7Zmh4xKXyzz5VQr/l?=
 =?us-ascii?Q?3aD4wU1AVEoQrY7neHESp383dZTQSVSFevQpr4AalPxDRg/p0JI0klo99qQe?=
 =?us-ascii?Q?+7RNCbpWJDsr82FwNukG4xfePi9eBUbnkJV69+oRzeVySenZA8LnMyv+YK4v?=
 =?us-ascii?Q?vPj5J5bY3SkyvAmlit+rqMl2wPd0P3xny4MCvZrwFKEjpA+bgnKEEvSICbE9?=
 =?us-ascii?Q?Y70h9IqSi9wiNJmCKytI74sCATVazgytl238wcg/LieH7Xp2R1cSeLrDrFAV?=
 =?us-ascii?Q?i3u2SZpNKPqZlXP9m4VNkA9DZkM0YzQq1PHTqZs7j1td0y7ucs7JRO30L/Ab?=
 =?us-ascii?Q?96PAAcdUZlqJV5NZvRBuBlPb4CTrst3rgExiONDSm40x/MZP5SxDrRIp+ci6?=
 =?us-ascii?Q?lMWCauu+YlFtu5LTGvGBmiQ8aGujpSUGfx6jHQ+7C5K30D64m8kxDBJ1hMwS?=
 =?us-ascii?Q?UNd1HNHXGtAH8w/EPFWUCflhGAN1uZ6nzRt0UPqe3lPQNFKPTQuyR9gxHYT2?=
 =?us-ascii?Q?lpjtGKjuwV73wl/F+cUS8EfrQoKMf0DfnRrYKws8REFIP6gLspFuiS4SvpCw?=
 =?us-ascii?Q?FuF0O3bGRUE85Q1iEkZ0s3F5wfo0TiBY3xYyCZmQFFxduOr0LwbEIcug14yA?=
 =?us-ascii?Q?VSIb+Fjm9S0xvd7OshiZ/D55UJ1ndrqUGQZHqSdxOjHqPPmQikwzWzmBmZdP?=
 =?us-ascii?Q?WtrdChKQQnI3QtRSCqJYHJSfAr8NFgY1Q7FTnfqvqP4f5K2TuHhs6Mxbyjkd?=
 =?us-ascii?Q?aiX89nA51j/uW4olCwiVjChDiZRyKz+7lyHougptAGJiJ7VjinrcZDmioaBh?=
 =?us-ascii?Q?DOQr8N+NtTkAezEdlAkXoD7folrzRoau7J8/hvtLKeFd7Lqw3NqOuFYtRteA?=
 =?us-ascii?Q?wylVAVbsQVihscI7Cmg7oeq6Z+AUyoDe8qo/E7EOe/JXTYxlKiPMh8NEcSDW?=
 =?us-ascii?Q?rMTydJUd13RRJV3U18wufkB5avv2Vvw8Kwl3EefQvXiAHNFnL74pgNfGovA3?=
 =?us-ascii?Q?J4qBpSSm6D94ToVUVnzM9A2+WN6zb5IsgikY48Y5CmRcxrVUUqJZeWJTs49M?=
 =?us-ascii?Q?RM3U3w/FMLhY20wdAtMfhWyHhIHIDQHfm5oMv63TJuMjTlrbw36R0Cks+Q7d?=
 =?us-ascii?Q?yfI6q4cN2VIZDe1vkBtSn4ED1UBLxp1BXq8sp9zNDEoSpKHPRrpiXWWO06Qn?=
 =?us-ascii?Q?mu/1DLoWZH3u/Yprpd2u1fcj0y4QnjS5E2hcTb2pdywZlKLTAmVaW7eFKcc+?=
 =?us-ascii?Q?HU/txarHC3Lst8w2LqolRYlB/h3YEBiu9z+dRAxNzGxz+QgmdY2Di40xRe5j?=
 =?us-ascii?Q?PvEo31LTM4LnpGgMHQonaXG69UWD1IAzz1n2QCEQF/jP0lcdm3d4OOI4mEbz?=
 =?us-ascii?Q?7sXC9iqd9Df2RhGpIOnQQEO8znHtsAlJjEHx9+FZCEXeT9paJHwJPtR9DNYh?=
 =?us-ascii?Q?/Vzu7N5IQplV8Elvdw//DLhf7DNVcbm8YUFbqst+a6d9ibH+N6mLpYVxvzxH?=
 =?us-ascii?Q?Du6qkp1NNc2vm8UQ1P/aXAdtohd04COJ7ea6tkdQbqYqX0WTYRdz/Is/BInR?=
 =?us-ascii?Q?Zb92i6OAFAnmNT4oEKLsNUpSsj4zoUcoNIFREBqv5U4ngE+Rqa/CQN+kyRAw?=
 =?us-ascii?Q?eMK6fzKL6mSKYIdJ6nulDwXHM4cA4iIDLFj21Vyb7Iroxn8Qpaa0Xgo7zqGA?=
 =?us-ascii?Q?BxxbZHZq5RkYhSahnBH+LjafbcQ3/4/8RDhtCI+eFcWaEKGa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dxT+8PvS/mFj2/JT4sD1E+I3wvEYVtKDKvxwkK/IkWIdZIGlKeblHkwqNtGCi4pwHcw5Zn5LfGHfbqJ48shaFJavbp4UrHTTlvH4INzwSyEqbH38a8g9WKCrhg9nwaGoiJRzrYrDVFvlU0hvv4ei909YIce4b1u8xjFgdfj29HwG87h8xBsnbzOYhpZQpHarLluLyiwEhObfQz8JV0H1SPfe5PvfIAurGyANE+4p69MQRPKsaMP8Zxw5r/KVN8hdw5LkWGmaZXh2niwHE6VIXsEPVbQUUYBLF1Ut66a50EYRJ46RUudwDiRSwXrMj0RT7cJSDi5N2nj+0xfRqdp+MA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS2PR18MB927544.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc20aa35-68e1-42cc-371c-08df2e7bea43
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 07:29:45.5701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WlacxhJvrhvN8XYczhb2gDDjIG7aMEKVDINrA57tO4y4WWbKP8SzkjOeNPwBAfwbUk+fZmwvo1lwx1cVJLv+Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR18MB434425
X-OriginatorOrg: amazon.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I missed your earlier review comments, and I apologize for the oversight.
Regarding the AI review, I assumed the result from the initial patchset, wh=
ich passed cleanly (https://mails.dpdk.org/archives/test-report/2026-Octobe=
r/1060187.html), would still apply, since the code logic has not changed be=
tween versions.
However, the latest run does report new issues that also need to be address=
ed.
I will address all of the points raised and aim to send a v4 before the cod=
e freeze tomorrow.

Sorry again,
Shai
> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday, October 19, 2026 7:34 PM
> To: Brandes, Shai <shaibran@amazon.com>
> Cc: dev@dpdk.org
> Subject: RE: [EXTERNAL] [PATCH v3 00/13] ENA release 2.15.0
>=20
> CAUTION: This email originated from outside of the organization. Do not c=
lick
> links or open attachments unless you can confirm the sender and know the
> content is safe.
>=20
>=20
>=20
> On Sun, 18 Oct 2026 12:45:41 +0300
> Shai Brandes <shaibran@amazon.com> wrote:
>=20
> > Hello all,
> > This series upgrades HAL and fixes two PHC correctness issues, an LLQ
> > feature version not communicated to the device, and a failed LLQ
> > configuration zeroing the negotiated tx_max_header_size.
> > Additionally it adds n-tuple Rx flow steering support through the rte_f=
low
> API.
> > Review and comments are welcome
> >
> > Best regards,
> > Shai Brandes
>=20
>=20
> I am disappointed that you did not address the AI identified problems in =
last
> version.
>=20
> Review of [PATCH v3 00/13] net/ena: 2.15.0 (bundle 2204)
>=20
> Applied to main at 9a45341f18 (26.11-rc1); every commit built with -
> Dwerror=3Dtrue (gcc, x86-64).
>=20
> Series level
> ------------
>=20
> There is no changelog. Against the previous posting, v3 only rebases, kee=
ps
> ena_com_execute_admin_command() exported in 01, and fixes a typo in 11.
> None of the earlier review comments are addressed; they are repeated belo=
w.
>=20
> Error: patch 04 still breaks the build.
>=20
> Info: the stable fixes (02, 03, 06, 10) sit behind refactors, and
> 06 and 10 depend on context from 01, 05 and 09. Put the fixes first so th=
ey
> backport without rework.
>=20
>=20
> [PATCH v3 01/13] net/ena: avoid using un-needed admin response buffers
> ----------------------------------------------------------------------
>=20
> Warning: undocumented behaviour change. Besides the move, the missing-
> interrupt fallback in
> ena_com_wait_and_process_admin_cq_interrupts() changes from
>=20
>         admin_queue->polling =3D true;
>=20
> to
>=20
>         ena_com_set_admin_polling_mode(admin_queue->ena_dev, true);
>=20
> which also writes ENA_REGS_ADMIN_INTR_MASK to the device. Say so in the
> commit message, or split the wait path rework into its own patch.
>=20
>=20
> [PATCH v3 03/13] net/ena/base: fix missing barriers in PHC timestamp read
> ------------------------------------------------------------------------
>=20
> Warning: wrong Fixes tag. The req_id poll loop without a barrier comes fr=
om
> f73f53f7dc7a (v23.11); a14be4dd8693 (v25.11) only added the statistics
> block. As tagged, 23.11 and 24.11 will not pick this up. Use:
>=20
>   Fixes: f73f53f7dc7a ("net/ena: upgrade HAL")
>=20
>=20
> [PATCH v3 04/13] net/ena/base: rename bounce buffer references
> -------------------------------------------------------------
>=20
> Error: build break. The member is renamed in ena_com.h but ena_eth_com.c
> still uses the old name until patch 05:
>=20
>   ena_eth_com.c:160: error: 'struct ena_com_llq_pkt_ctrl' has no
>   member named 'curr_bounce_buf'
>=20
> Move the ena_eth_com.c renames (curr_bounce_buf, plus
> write_header_to_bounce and close_bounce_buffer, which 05 also renames
> without mentioning it) into this patch. 05 is then only the ena_com_sq_is=
_llq()
> helper, matching its subject.
>=20
>=20
> [PATCH v3 08/13] net/ena/base: deduplicate meta caching config flag
> ------------------------------------------------------------------
>=20
> Info: removing the field leaves two consecutive blank lines in struct
> ena_com_io_sq after mem_queue_type. Drop one.
>=20
>=20
> [PATCH v3 09/13] net/ena/base: split LLQ info into datapath and config
> ---------------------------------------------------------------------
>=20
> Warning: this is not "No functional change". The burst limit divisor chan=
ges:
>=20
> -       llq_default_cfg->llq_ring_entry_size_value;
> +       llq_info->common.desc_list_entry_size;
>=20
> They differ when the device does not support the default entry size and t=
he
> fallback above picks another one. With a 128 byte default and a 256 byte
> fallback, the old code allows twice as many entries per burst as the devi=
ce
> accepts. That is a real bug, present since the LIMIT_TX_BURST support wen=
t in.
> Split it out:
>=20
>   net/ena/base: fix Tx burst limit with fallback entry size
>=20
>   Fixes: b68309be44c0 ("net/ena/base: update communication layer
>   for the ENAv2")
>   Cc: stable@dpdk.org
>=20
> and keep 09 a pure refactor.
>=20
> Info: continuation lines of the descs_num_before_header assignments are n=
ot
> indented:
>=20
>                 llq_info->common.descs_num_before_header =3D
>                 llq_default_cfg->llq_num_decs_before_header;
>=20
> Indent the second line one more tab, or keep it on one line.
>=20
>=20
> [PATCH v3 11/13] net/ena: support flow API for n-tuple Rx steering
> -----------------------------------------------------------------
>=20
> Warning: an item without spec is rejected for IPV4, IPV6, TCP and UDP ("I=
Pv4
> item requires spec"). In rte_flow a NULL spec means "match any packet of =
this
> protocol". testpmd passes spec =3D=3D NULL for items given without fields=
, so the
> obvious rule
>=20
>   flow create 0 ingress pattern eth / ipv4 / tcp dst is 80 / end
>        actions queue index 1 / end
>=20
> fails. Treat NULL spec as protocol presence with zero masks, e.g.:
>=20
>         case RTE_FLOW_ITEM_TYPE_IPV4:
>                 ...
>                 has_ipv4 =3D true;
>                 if (spec =3D=3D NULL)
>                         break;
>                 if (mask =3D=3D NULL)
>                         mask =3D &rte_flow_item_ipv4_mask;
>=20
> Same for IPV6, TCP and UDP.
>=20
> Warning: secondary process. All other admin commands (MTU, RSS,
> stats) go through ENA_PROXY because only the primary owns the admin
> queue. The flow ops call ena_com_flow_steering_*() directly, so rte_flow =
from
> a secondary submits admin commands from the wrong process. Proxy them,
> or simply refuse in ena_flow_ops_get():
>=20
>         if (rte_eal_process_type() !=3D RTE_PROC_PRIMARY)
>                 return -E_RTE_SECONDARY;
>=20
> Warning: features/ena.ini adds the [rte_flow items] and [rte_flow actions=
]
> tables but not "Flow API =3D Y" under [Features].
>=20
> Info:
> - ena_infos_get(): the two "&=3D ~" lines are no-ops (ENA never sets
>   RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP or
> RTE_ETH_DEV_FLOW_OPS_THREAD_SAFE)
>   and dev_infos_get should not write dev->data. Drop them and the
>   comments.
> - ena_flow_create() parses the pattern twice, once inside
>   ena_flow_validate(). Split the attr/started checks into a helper
>   and call ena_flow_parse() once.
> - adapter->flow_rule_count duplicates
>   ena_dev->flow_steering.active_rules_cnt. Use the base counter.
> - ena_flow_ops_get() logs WARNING when steering is unsupported.
>   testpmd calls rte_flow_flush() on port close, so this fires on
>   every close. Use DEBUG or no log.
> - ena_flow_query() only returns ENOTSUP; leave .query NULL and
>   ethdev returns ENOSYS.
> - ena_com_flow_steering_remove_rule() and _remove_all_rules() pass
>   a response buffer they never read. Use
>   ena_com_execute_admin_command_no_resp() from patch 01.
> - ena_com_flow_steering_destroy() leaves dangling pointers. End it
>   with memset(flow_steering, 0, sizeof(*flow_steering)) like
>   ena_com_rss_destroy().
>=20
>=20
> [PATCH v3 12/13] net/ena/base: remove x86 Tx LLQ write barrier
> -------------------------------------------------------------
>=20
> Warning: arm_wmb() is a no-op on every non-ARM architecture, not just x86=
.
> ppc64le, riscv and loongarch are weakly ordered and the driver still buil=
ds
> there. The argument for dropping the barrier (UC doorbell store flushes W=
C
> buffers) is x86 specific, so make the test x86 specific:
>=20
>   #if defined(RTE_ARCH_X86)
>   #define ena_llq_wmb() do { } while (0)
>   #else
>   #define ena_llq_wmb() rte_wmb()
>   #endif
>=20
> (rte_io_wmb() everywhere is the other option, if Graviton testing shows d=
mb
> oshst is enough; on x86 it is a compiler barrier.)
>=20
> Info: the new comment in ena_com_write_bounce_buffer_to_dev() is
> 20 lines, half of it history of the old wmb(). History belongs in the com=
mit
> message; keep the comment to what the barrier orders and why x86 does not
> need it.
