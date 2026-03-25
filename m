Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30271109C05B
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 18:56:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3659A42708;
	Wed, 25 Mar 2026 19:56:22 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11020130.outbound.protection.outlook.com [52.101.56.130])
 by mails.dpdk.org (Postfix) with ESMTP id BFDB5402CE;
 Wed, 25 Mar 2026 19:56:20 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuYWiyHWYAKDD50YgiypYxbnMvTxDAISpNeTdND9bd90UnlgXC3BBGQmgujeopGlSM/JBLuoyjLQeADTeFoXY2jbNMpolTL0d6hxi0zGN6ldGtOKWOX+DrCufiMYc0mZJAS1fzF/9W6y1MM7eQunFbH0vDPQY0oz3Jg6Y09/juGIN646XaMJ5jjQc1L86Dun8eWCA/kydgCFKHNNhjNitK62Tl5yZplHgohhrs/Fn2oRHJ2uvHb/n3mFASa6e6Eoon4Po8yFqfRVjQUGOZNc5tj066gVkC88j7S92rfu3j0oC89tSyE5v6YDkokqwzRkbCIjY5vVcx/AqWcRrOMPvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EswzVZcvptUEQ38jT1k4BpPAVGZM0aVwJPAQz7DDys=;
 b=nZ/4bqoF4Uy2jS/1RFEQWBcw5jcLGRSyXl+X1RJixF2F0fP33615xKv5VS+p93QxmSzQxDvroj14l9biIv9rNDziHlFGIxLuHAnLV1Aly19GgDZzhdZb5wHjjXB3ZzqFZwpb2ZbdYRoVgp908Ql73srJRVAlwwR6n4BYZq5jWMWqom0IoBcme2X62MDSbPI93UpSohq73ApJl7pjHKlPFInxRBT2Vjy2ySNDne/G++ALWte/kxXq2QMylN20uRD9aLSuR4PV/FgjAAqRJqwQCGCRq80Qfo8d+u/WXVQRCV8KAFQn33uGIlBQO+n9OSNfF75UaAUDE7BpcGk+hjfyyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EswzVZcvptUEQ38jT1k4BpPAVGZM0aVwJPAQz7DDys=;
 b=iBCyVmWRokaRf/CA63jPd0eihCgX4920v1hofOMJJmpqqjOwIGTX8vNmNgHbgl+4nUkCU6Qw4TY4nG4SwRWNuNGR9QP1EErzKv+TovVGDE7J4SatUFui0Q8JGYXppFsrVC5J1pt/0O3P7HjxrcfkbnTPYluUPw8YubTk5R0KZGI=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by LV9PR21MB5642.namprd21.prod.outlook.com (2603:10b6:408:2e5::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Wed, 25 Mar
 2026 18:56:18 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9769.006; Wed, 25 Mar 2026
 18:56:18 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Wei Hu <weh@microsoft.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] Re: [PATCH] net/mana: fix CQE suppression handling on
 error completions
Thread-Topic: [EXTERNAL] Re: [PATCH] net/mana: fix CQE suppression handling on
 error completions
Thread-Index: AQHcvIaj5HzxOFwssUu9tb5A4PKNh7W/mKuAgAAANKA=
Date: Wed, 25 Mar 2026 18:56:18 +0000
Message-ID: <SA1PR21MB668302AAD691801ADDA4773ECE49A@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260325183836.1925080-1-longli@microsoft.com>
 <20260325115451.4120982b@phoenix.local>
In-Reply-To: <20260325115451.4120982b@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=714cab42-08bb-4b93-81ba-510e6c4b9e0b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-25T18:55:34Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|LV9PR21MB5642:EE_
x-ms-office365-filtering-correlation-id: 0c669792-3aaa-4b7a-c549-08de8aa032e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 2jZY/oK7y9sjJLPyfg1i+3nwcqrodER6NuLSfGYViKSb4/nHpeTTXeIhGRMyX+0mGq6TwxwJ5HZWXPKvEvXuUzTZj1EUK/cmxELfl7qHpl88F7WgRGxhomDD6aGF5Q2t+NHj1QH4QdHi2N0YQMMGvqD9KV5t01qjqD4QIWBwk/5vg9MGiGATj3zbylb5wYtNH20Unl+/ZoNjI0TzA1gfBMEk5ELA5b8jW7scI5FSuyEeexB8JxqPG3oXgKnmXv/jnD/lUcYL6W2ZTt2x9IlX+/iizHH/HUAj6gFrDglGyBtYvlR981mTNGNhwPJhoWNUHea9wvASHPWsxrC9tzDp7RPNQ2Dbt/HcYS/FjPWl5q67124ybyv5uLv690XvqA/McAnnphEzisudGSwKVl6WAAFGFC/5BxaNzrPD8blg5qoALuS1Q9wLXVvG9wkgc2NPymN9iD08pE+jTkBpjTstyROO+alvOsEhaX5F5pg3coXkfRuIm1fPaaq8yvDfZUbKEszIpFK4R1un01/BWZmMjlBha6YPqsA0fPUd3gr8LhGPWKIRwZsGRDSZaE4r8+Qe/wL8B5SusXgkwZ//sxXf7IhlAaxQZWF1MwbKliDNGOEK/jcrjNoWTQ7mGHJ1/kNwuhBdGn9EzGEEZP1Ael6hi9wi6MkFSUReUt+/2SQgJZtSnQXzqKwtaJE/rOZmdeARTPwu8iAWIjaj+eIdKrWaZkntKH1H0VzrDCKArVkWKjYreljZnu/xdGpMmKFlFMWSCyOzV+f+aAmxRxncXvJPALubjT1TCKgLcbpm00q3KwI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M4WN7r5qQg4lozXdXszvaUazaZyEmqYRtoYckbwmGW0ICVvsCLnQQ7qio5Hr?=
 =?us-ascii?Q?n996rcptUbnC54Dh4LM8g3O4kQTfc/ryfE074wOPqDXMQ06Jh0GWRRnRzh71?=
 =?us-ascii?Q?c1K+iQNqhx8wpD0phOkGQ6tPsk+Fp6JiTbNe+EKP2l99LUL27kF1Fh06diAA?=
 =?us-ascii?Q?t+NxHl0uLLQJljx/ycl15xHMjnHhxZtHyJHrGhUoRJjxGQG5BZ5PQigIDNag?=
 =?us-ascii?Q?XofyA46O2NbPFvOzHlwdojt8Np5+fY1h0XDryv1AnNdq86TvIJKQyQJ7FiIm?=
 =?us-ascii?Q?O2XklS9mIMPMXTPPPxAsTv5jUT/DEOVvy6yZwbkzQoe7XdW29LtplvmXME4o?=
 =?us-ascii?Q?v1yjB1sFepg4OOgxVInbQFMw69DRLZRUQJhQFo2REwKnbgov86raLrwqLuJa?=
 =?us-ascii?Q?c95uQyYBQ3miBneqBYEZ+/1TSIRp5etJiXYr3Ev4RltuDWezM6s4LgAVahRa?=
 =?us-ascii?Q?MWTOCtMs2YWxZ4+TitNEGdU6oqMab9xFARunGGfQodWySG6QKBT4yZ6yYiZv?=
 =?us-ascii?Q?ATcQsqw6gvFlwZVU1GnfudGH6o0XT9M5vbopyVS9av51emgXyxIJ9YEA8v3y?=
 =?us-ascii?Q?GEjTH0Xfg/ymq/Ad4BbO6aE4ZoU93jD3bHt0hwlqHIbK1chC9LAj3bEWZLn3?=
 =?us-ascii?Q?qfDPLWX0uP5/S0SET8yxQ4kJpuB4zk4nrqDn9qiY495qzRgNzdq4lg+7k077?=
 =?us-ascii?Q?ICztZ3zDlLSQ5TXJEmbjGb4mJgaRrmRZDqjAyZaNrviEAUAeIY4nfrXDWZZz?=
 =?us-ascii?Q?Q65b0rEDN/nk4lfpb7qKvvPr9PQAhxgj0Lr2fjRPWbEvg5OPEFaO3yIkjxlX?=
 =?us-ascii?Q?zRT6WMOjJlFxyEyF4JEIZNZnVNXNeLiKEpB01YMUf10fYdoxOyOm3UtmZvR1?=
 =?us-ascii?Q?PFOIkouX7gthbDzaGvpcTKjRcHs1+vf4NDnATGy/r5UrSJoYCOgdmF5WyMqy?=
 =?us-ascii?Q?DoPd2m9iTirkCzD2H71FU5kcyBVoqhoNUVKrKisGmO7CizfzjoPVhXYJ1Hxz?=
 =?us-ascii?Q?e4CQvlBL4tiMKPu4mUGpY2lP+xR52CsY2G9wMLvIM2yx/zHOVAhV0DNj5gvb?=
 =?us-ascii?Q?t1hJOyfqOfeWU769FdKVphjW9coXh8OllwfU3W3s9FSa9Gybk8cWWsZ5whxx?=
 =?us-ascii?Q?pGNeNj3TthglBs27PCqPDNBxP7n9Z2QGJcqs4Zft/Dmii2zr82dNxAjd4i5t?=
 =?us-ascii?Q?uSAvl87uMOH+Cx1h6Rql9kl+Bo8030BIVxRYjk8JqZULNf42jhZoiT0ESeoU?=
 =?us-ascii?Q?haibchKCdFKiCVb9LF26pQKlw+POlDNRhWQhTEbdoqn+Fq90BqHUuBGo9NIR?=
 =?us-ascii?Q?WHw98h3g1U/2yGCrKS/ioJOVWWIy1dMSvyUIxPqxCrkqGDyX836jX5YZ2MB6?=
 =?us-ascii?Q?eChnQkGkcn9gHlS5yOMSW6PDFEHwasNwYtCgVxx3hfHZu8salVAtEcUNIB3Q?=
 =?us-ascii?Q?mxspfeIdQa3MaMCgxK7JfaDKO/H3HwPMgNKICZTb0uBHicaGKXNT/ndS463E?=
 =?us-ascii?Q?gXOZypzTHUVRUtApy4uGDoHUMimrJpc3GcvPEjBT2V53UyqsvyuncDPv6Zko?=
 =?us-ascii?Q?cSOg63UkxxURfZ66mCeHfKy/VAK6/2RMSgpY1BnwHW62+dGSSCgtOkql2pJJ?=
 =?us-ascii?Q?AduCN3870+MLXQOStd7/awrQvgrjZkzaz/nGV76/efCy44BTJOAh6FojNm5J?=
 =?us-ascii?Q?Mmuv4ikwvct8OblE6wnG+Za3mwVFY21s58ggCgIRf8myXs6B?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c669792-3aaa-4b7a-c549-08de8aa032e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 18:56:18.6295 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DF13VM+ujr38gyAZt0tcTO9tNygUzcWulTQt/FGT5Fn8V3qCxj2O+UwEtqxm1Xpq0FjW4Kg9NIKS2vvNx7fvzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR21MB5642
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

> Subject: [EXTERNAL] Re: [PATCH] net/mana: fix CQE suppression handling on
> error completions
>=20
> On Wed, 25 Mar 2026 11:38:36 -0700
> Long Li <longli@microsoft.com> wrote:
>=20
> > On error CQEs (e.g. SA_DROP), the hardware generates one CQE per WQE
> > regardless of the suppression flag. The previous code honored the
> > suppress_tx_cqe flag unconditionally, which caused it to skip reading
> > error CQEs and misalign the CQ consumer index.
> >
> > This misalignment causes subsequent completions to be misinterpreted:
> > valid CQEs are read at wrong offsets, leading to spurious error
> > counts, NULL packet frees, and potential use-after-free of mbufs that
> > were already completed.
> >
> > Check the CQE type before honoring suppression: only skip CQE reading
> > when the completion is CQE_TX_OKAY.
> >
> > Fixes: cce2c9df44 ("net/mana: suppress Tx CQE generation whenever
> > possible")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
>=20
> Applied but needed to use longer SHA for Fixes to meet current guidelines=
.
>=20
> Fixes: cce2c9df4481 ("net/mana: suppress Tx CQE generation whenever
> possible")

Thank you!

Long
