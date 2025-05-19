Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724FBC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 May 2025 11:20:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75730402AC;
	Mon, 19 May 2025 13:20:55 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by mails.dpdk.org (Postfix) with ESMTP id 0C13840276;
 Mon, 19 May 2025 13:20:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UA94BzTNwBvdmEKgUT7xt9smOewhns2nZCYRs4/me8+ek+gtqlyvUZxumxkdb5YZcFzpVaJdHPOaefL7/B1PWzwsLWQeqb5qgoJ/b4aCcW/R3Bh6BvSdOn7WV+RwuVFzNfE/ohMg+Zw8Q+oUqmFbwz+qWLak1tWhov5pHUs9OuPycpgAo4RchSJA43ire9Ea581vho84xk7iOnhq4hseia2CCkQi4FQOkldQKvw6wbApxvq/NhmbSTJao0Czmx3G1Jeqaxfq2zywRQ9wL4Af5rG2Jwrn6VAs04GRStokLVVWEMM6ujML1nxG5cjFhoR78snEMHJwHni6wcoqNARlAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIjtWgvxwr1IzcGCbN31vx5yDASN+KaCrEQE9YJZQJk=;
 b=Gl0juWblOb4Kxbr3NnjB73KY4Qubfa8Lk3kIVLtMP3nTuGUYDuvdrrn24w5cvDIElSGPtBGMncQhLZTqlreTwsanG0a8JfyQTnWtlTZQe//lwqG1VATYNcV3nYuM7/hoYbYs66mwXmm5tpeE4wOltN8ohPmB8jo6J7iPqT8PB08LRMTcEN6r3/KOyatus+y40tlvZxmIzCZ55exPvAxOxqw6j+0CFUpNow/ZrsRacaerC37+NhwHFMrLERxeG/ghAYo3sSBL+r+qItJvIjOBkBhkYOtIwD23NBOh3QcRGLvHBIC3MwFf2T1p8FwuWmfFliM/EyJg5qRw/wrf2VxJpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIjtWgvxwr1IzcGCbN31vx5yDASN+KaCrEQE9YJZQJk=;
 b=Jt/G9rsgDPR51qr01dGQS3QriBV8pB7GIRXvalCtlOMOaQR2UtZnF8qlG3eVqJYtxagDKMlXOTpjfGTQBzAffu0m44dmLs5nd1EFS9uGeFUyMmCAotRGg7SQqigf0M0zhJSZ4O3drN3zSMdnS/XsQoNolO9N3+9Me07Zvhnjuq3h1Zchctv0Zy2MG6fNepGlosRVqn/mOoObGN0R4DmAzwoqi+dI3ohKc6Rx/d1wv+AUm/dlc04E2YxtZId7k9NzO5BxVH3sOW+L+OwI4Fymf6VjlnhioJEU2xMsUUrMF1n526cN9HPO7siOJYGPGqAzsDmPxoeo1T3xuElxVuq/YQ==
Received: from MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12)
 by DS0PR12MB6629.namprd12.prod.outlook.com (2603:10b6:8:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 11:20:49 +0000
Received: from MN6PR12MB8567.namprd12.prod.outlook.com
 ([fe80::9bde:b697:6d6d:ee04]) by MN6PR12MB8567.namprd12.prod.outlook.com
 ([fe80::9bde:b697:6d6d:ee04%6]) with mapi id 15.20.8722.031; Mon, 19 May 2025
 11:20:49 +0000
From: Slava Ovsiienko <viacheslavo@nvidia.com>
To: "Minggang(Gavin) Li" <gavinl@nvidia.com>, Matan Azrad <matan@nvidia.com>, 
 Ori Kam <orika@nvidia.com>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, "NBU-Contact-N?lio
 Laranjeiro (EXTERNAL)" <nelio.laranjeiro@6wind.com>, Yongseok Koh
 <yskoh@mellanox.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/mlx5: align PF and VF/SF MAC addresses handling
Thread-Topic: [PATCH] net/mlx5: align PF and VF/SF MAC addresses handling
Thread-Index: AQHbxjHIRZLbt/alE0mt9CsJ6uhiDbPZ001g
Date: Mon, 19 May 2025 11:20:49 +0000
Message-ID: <MN6PR12MB85671F07DB6848CF4AF2ED59DF9CA@MN6PR12MB8567.namprd12.prod.outlook.com>
References: <20250516071032.4357-1-gavinl@nvidia.com>
In-Reply-To: <20250516071032.4357-1-gavinl@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR12MB8567:EE_|DS0PR12MB6629:EE_
x-ms-office365-filtering-correlation-id: 1053c4cf-5685-405c-c850-08dd96c7358b
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?udOoN241nLtaI/g62mshG3bM7HdGhN8ymoe/Ye9lBXJE+6pbn8qN8DXe6j9I?=
 =?us-ascii?Q?P8DwfcqsmJ6hdIRSBgmmK4kQcBADBqhyzqsSlu17pIxt/AbH9Dihsqxlahe5?=
 =?us-ascii?Q?uS4osrPOXNfyYS/Zn4gcBqQA2tT6MY0oZMO2LUIFfTnGoT4Mjkn+J9oZeQxA?=
 =?us-ascii?Q?kS/0NVz2bnJQFy9OIlMuphj8tsQFurRyhEq3KzfWycjT2xa0TovWxvrG2bdZ?=
 =?us-ascii?Q?AgD7AzXBhEKtq4drPqfl1K9FPLSHNZIrFK05sb12sZbMPwGbDkTrFM14LvZy?=
 =?us-ascii?Q?IWRDfHhkFSeNGLvJJsgu/z/gAzshieUhMmQ7UmUliLku7OZx3X28pZcfX7Mr?=
 =?us-ascii?Q?Y2mSgqRY0NsPAzyT8hVLPzNLXXwpWkDwakN1PtUoGt12EyZQPjxo+4RAp7n7?=
 =?us-ascii?Q?eVVvHfdQfGROjxAueJTJ4JrZMqW5FKuU/QlFl9cCFvXsZikzjptT8yHQ4TNM?=
 =?us-ascii?Q?jR3b6lzx1D6NAWE442Fdx5qLjjZufud2Xs16ILpf4OTxojTLH7e0llhR/8fS?=
 =?us-ascii?Q?VDGdb+udbg5vWSWSSGrogrht+wGZnJy5mjB7G/+ySeGzAzOAH/64UTVUTJQj?=
 =?us-ascii?Q?YZqpMl5B2kTU+XmsuFtVNFuPvj499MW3AKRfdyG0AfZ5B/9/20ZlQVWTB3/x?=
 =?us-ascii?Q?ivL/lynEwBlkDOjRbisoNaf27xe1gaFcHi0ytaD+2+3GQAHf2nlYZBekaTyu?=
 =?us-ascii?Q?PulYR7Rwq+hsYoRtmAqBgl5sOLPzDVZyrxLfwoYWEdmVspVoxpUrfMYWgYLr?=
 =?us-ascii?Q?kvDSpCidS/HmkbXKj0MkpMUTjQc8ZGFHOelWC3AQZOPFgQTgXfR45BIzq24g?=
 =?us-ascii?Q?eTQ3e+bxuNDXkf8Mu+EBhN7mr8xU3NH1LmIyqPYXsBZCVQC+zmNFNJIzSt6w?=
 =?us-ascii?Q?ejZeynD/LpAQOsz2P5OmbqebWvFBe8mnJ/X2K8azofUjYtvNnOhpKnx564FS?=
 =?us-ascii?Q?IcQceZHSrl+7D7C72cXsgC2yKXb9JM1AYl/CcczPh9HqVAlLn1XNMR6VC/z7?=
 =?us-ascii?Q?DklT7tfj7/DQqCAb5EXYrgLs5VkKA7z/kPamndVc63Z2iOw7Zb2GFQ/FtgGg?=
 =?us-ascii?Q?ISg695jqQIqqR/yqm9kNBo0waWQ0/dJPMe7rLc+fZ5bH7i21WSQwMnK5p0LU?=
 =?us-ascii?Q?YQTrID7Txs8BCpynzcIAl/n8eL+UK6fq1M8HUgjq5t9JYsCYzyPjHZsb4ib6?=
 =?us-ascii?Q?SxUlBlLpuo02sFNIcQhPHxWoKAw1PoRKH0JC1q15NCtCelRHYpXkDK0zxEzX?=
 =?us-ascii?Q?x9UyEJOjh30BaIdBm3tNpA+sb2KT8LP9zL6K1cinE0ZjgR9XKRLuSn29AT+A?=
 =?us-ascii?Q?MntEeujDJaelzMS7TxZFVXcjLRWXU296itClm9yn0MdMmPL8gfPeD+n4Jwe0?=
 =?us-ascii?Q?cvRn+sadVYLZB8sh5lQSXpuy40Z8NQIvIrdgH9B/ksJFAQieY15vyoMVXWST?=
 =?us-ascii?Q?3jVL6Tlv/qWcOH6hRXADWiRRWUoXP2dUiDms8cDk81E3PoFmX7B+sW0xT5Si?=
 =?us-ascii?Q?4kYVZyZf8zuk9gs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR12MB8567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G9afiXHov6xGQ3jdkdds5tubKx3rjEhYVwnmwuRtpItURVVyzWsG/vSjUUJ2?=
 =?us-ascii?Q?YB8UsFXfHPWt+N44VLLodHhIrSkGDQyylbebiM52/4fRRv1pAFPB8U0HV9at?=
 =?us-ascii?Q?r8bAYpbhvnm1TgAxzBypSy52qhkL916C1CavOdi8ebH6EMBq4XvvQAMVFm3U?=
 =?us-ascii?Q?2qyWulVfo9wWA3dwWLau/dqw4QokoTGS21E6kKJIEJT3A9hxGl8IFbQ15+mn?=
 =?us-ascii?Q?UvRIqAlNk98uKRZ6XqlcZVM4F/z/kzbzusuCZRno08fMgn8w6LyrtdxMSp84?=
 =?us-ascii?Q?6QuQPFLuUxD8s01fpPdXTllgTM581YGivvu+9fwAI9mBICtL3IpU9dL3cnvO?=
 =?us-ascii?Q?f78+SK/qF0IR7Cjod7WEwyoloe3RzILLzDBMv3aPj2AEtF/KiS0TA7TXuXVr?=
 =?us-ascii?Q?pPdnSTDyJsFBbWsLOD4CJbDftx36WH0qCPsQzMJvCs79P2hh/vHOqRN14Thk?=
 =?us-ascii?Q?TzgBM/tcHrBv3/zoaCdkz5b8737PXFv0AdQIUSaQi2T08yM6LRQQTlaAy31G?=
 =?us-ascii?Q?lRxQAfElwH1ak7DLtt340TVMB4sGiO4njeluY19VM25gWdhBS8UDg9WacKSH?=
 =?us-ascii?Q?w6HSpmJEKTcv5kMEtAZMoKtjX9KmJ33H3ol4D2gkCHS2DLGPOVbIzYbrvEW0?=
 =?us-ascii?Q?t3pe/l+cmvKC6SqmpUoK7QFFFG8fgxvwbmPrJ8vMgw6TV+smjZ0H12D41l/D?=
 =?us-ascii?Q?Ikt8rbB07imVFgdDkrxVgNRzj5wLPgOuLzoAG9lHF7eah3Ie50mmlRD6bWDe?=
 =?us-ascii?Q?S0IuF3SCTKqIiNtO2OsAdLs76M2hb4vpqmRskhlUYpd8PswhEkS2C4zc9m9n?=
 =?us-ascii?Q?Gtd0bY22SQEqvUtZOo7GqNRD6f1OaKAKWtNIjSNFuQSpfnjPjmoYSKzAcmGC?=
 =?us-ascii?Q?WWro3ls26+erjjkjsno+hTokrqus/otOGnh+WTmlQdPEXSSLAH0zgPZj0u9g?=
 =?us-ascii?Q?uYoD1rhxdlv5UIbk7K2hPAoNbGVMDcH0LFvryCcYssfDdtRD/bdjEJ3DW1vb?=
 =?us-ascii?Q?DcCnx2tVJ6JhzNRrxwou8FEHOSFu4dvjRlunriDMQtOi5K8bEIWyse/EALwi?=
 =?us-ascii?Q?eKFCPimzt1kHGb7afac/GD+h6yUVrCqQtKvCll9oMBUgZ9MkP+w4SowWKwIh?=
 =?us-ascii?Q?9ywihfXVR0NKbFCpsPwddTtEDRULbWffofj9VcZBswcTiDhVawQEQUHy5uEF?=
 =?us-ascii?Q?Kwya1n5DJbnBaoXVMdAGPglG1EEc+QhhOS8F5Iip/QteIn0CO1oVp8qUi5MH?=
 =?us-ascii?Q?lH+v9xn7ZfTrjKfHD2HAdQyCqup/akx7xMobJjz5zOIclASOMGmZMFTQqVg6?=
 =?us-ascii?Q?RXfC3RpzMnuz0deW++K3QH2+baMAll+IwtiHxN8Cmcbr1d/V8nyChYbZvscM?=
 =?us-ascii?Q?IKqziPGdJ51SgZ6dm+URN6WkXSrNCGicpDIzN1yF3Ye5SJ1ef/rKSJj7eSgh?=
 =?us-ascii?Q?U2sESkLkTSlHMTQys9difue6VpulKT48aOkjaI16Uom8GxYLPxD+K+fwFabi?=
 =?us-ascii?Q?hgtCOd840lLTjgr5aI9W4QXKWS3KLNZZg/FVPV+pHgvKVEfmcRc4lTumKPJS?=
 =?us-ascii?Q?2aMC0P+Av4ZPG39f8IdkyocHoJcFLRKovrveJ4HW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR12MB8567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1053c4cf-5685-405c-c850-08dd96c7358b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 11:20:49.7291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /eSJJm4PzdY1/g73+XGKEHh4jl3FNChtuOLtA/mAcNFIbAXoVESTETQXjPb5nwn2XCyBrFNrW9JJWIiHFCp9ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629
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
> From: Minggang(Gavin) Li <gavinl@nvidia.com>
> Sent: Friday, May 16, 2025 10:11 AM
> To: Matan Azrad <matan@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Ori Kam <orika@nvidia.com>; NBU-Contact-
> Thomas Monjalon (EXTERNAL) <thomas@monjalon.net>; Dariusz Sosnowski
> <dsosnowski@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Suanming Mou
> <suanmingm@nvidia.com>; NBU-Contact-N?lio Laranjeiro (EXTERNAL)
> <nelio.laranjeiro@6wind.com>; Yongseok Koh <yskoh@mellanox.com>
> Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>;
> stable@dpdk.org
> Subject: [PATCH] net/mlx5: align PF and VF/SF MAC addresses handling
>=20
> In the mlx5_dev_spawn function, the Virtual Function (VF) synchronizes
> MAC addresses from the kernel using netlink. It queries the netdev-
> configured MACs and populates the list in the PMD device data, including
> multicast MAC addresses. These addresses are later used for control flow
> creation, allowing traffic for the listed MACs to be received. However, t=
he
> Physical Function (PF) does not synchronize with the kernel and thus does
> not add any multicast MAC address rules when enabling traffic. This
> discrepancy causes the IFF_ALLMULTI ioctl code to malfunction, as it fail=
s to
> disable all multicast traffic, leaving the VF still able to see it.
>=20
> To align PF and VF behavior, only unicast MAC address flows should be
> added.
>=20
> Fixes: 272733b5ebfd ("net/mlx5: use flow to enable unicast traffic")
> Cc: stable@dpdk.org
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

