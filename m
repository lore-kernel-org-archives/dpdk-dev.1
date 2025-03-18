Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5BBC282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Mar 2025 10:38:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98721402C4;
	Tue, 18 Mar 2025 11:38:05 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
 by mails.dpdk.org (Postfix) with ESMTP id 7DC7F40291
 for <dev@dpdk.org>; Tue, 18 Mar 2025 11:38:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAw7Co5pdej/S6DD8vRs6LmHlayzaHY+khmJ46e4BHCjfwJQ7PyKm2WtO02G9xLP4G0DX0Cks5+XdVN+OCRCIYak0SuWHJGZzfMpreV25F5Rb8wAVLohN/n9PyeVQbFWMxVq4Et+FswtG/o3ifjvB4ay8KUM+99DS/rV2FnbJII34M7igueCu/49dmUTlwKDdNXtPMLymeBx06ICKeI5Dx0xxRSktErX+5zXZNDZ4wi5AQkmE8HEZw4yZSFEL3GdgA/KHVC5HY0OQ6sX4oFlXKuy2DQRCwiBgNwK3s5Bay9YSdGyEUX+jTKG/ra7lb7ci9Ncffby6wN70HdjPX7/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brFV01SNVRNuFaDP74IFbxRcKvaaIkMTxRxLyNNrnUA=;
 b=WSSXATlEfe16bTnl84uUkyqQsG64rgmcEbwtFvXQ+g6Q/D7pGdTijjYSXcmikuxEh2xQju2eGt1yz1To2oWt8J5pV0xoJGQ8frGAhy2IMIK8xROJyl71h9zCUHMYk06VswdTE8kwTy5F52XMugInn5K4j5l4GVr6u4yV1ceJ/kdu6zkuSpF54YjxrSdkEp7qi0vw1DTUPG8FRnpNv3dx5AuTrMCYZ8xW25CtLvnAOQx7g+hZ4XgjBmpJRFBqcz3Li+EpMuz28YU0ril968BtaM3xMp8sdznd8DzN6ryBjM0Omoq7n/Mdb81tOcZW+4KqRS9KRLaauWANZD6jzFf/fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brFV01SNVRNuFaDP74IFbxRcKvaaIkMTxRxLyNNrnUA=;
 b=eNfu9n9bPzFr96YzahUVx1YrCNyH0r9dqrwFDouvyXHbxdzPVAKfUvWNEh7BgqYs+th6VlXn6+f2pEYMCY3IXvTi57s4qZReHPJAJyeAXTu2AxYyqD3XzjLmZXe/YvXNSZ5csg+BgcwpF5d6c9s7ShghQ54NIFqavNhRW1L1CdwZsbjBw9Qz4SaSsMZWrsNq08LSH30iw3uT29b2NnspXX7dAXIUkCVJPem12wjPvgBjl8XsSwvqn6mWe9YOaCjlK/nSCW7qU7Jmh5xo3nGwJoarw6Z3OIqUwkG5MJrNkZTgxH+73CNAc30tmQ38cFVSsSSEV9ba237jz5FXF0Xnqw==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 10:38:01 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 10:38:01 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Gregory Etelson <getelson@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Maayan Kashani <mkashani@nvidia.com>, Michael Baum <michaelba@nvidia.com>, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: Re: [PATCH 1/2] common/mlx5: add device duplication function
Thread-Topic: [PATCH 1/2] common/mlx5: add device duplication function
Thread-Index: AQHbk/K8CZJJvZHjREeOZ18W+FLoP7N4u6xV
Date: Tue, 18 Mar 2025 10:38:01 +0000
Message-ID: <CH3PR12MB846047F0E51E764BEB8E0153CFDE2@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250313083351.25559-1-getelson@nvidia.com>
In-Reply-To: <20250313083351.25559-1-getelson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|CH2PR12MB4277:EE_
x-ms-office365-filtering-correlation-id: cb6f9013-4bd1-4465-2bac-08dd6608f52e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?aj1EL1cZcBw9A6EuswxHt2rX3/PnqeFfzw3mXiHhwXmFqetaP8T2dVvG4c?=
 =?iso-8859-1?Q?Xw8idWGSKsNziJYVxrRM1xs+bxrwNOiiX1AlrPEOFfuG0Yk1JgA+LZDShg?=
 =?iso-8859-1?Q?Jma9ihzld17K/AjPBql5Tk8RqY3jKF7CZyBD8fLoWbNQUUYufsJOJrMjXw?=
 =?iso-8859-1?Q?xSEToMkYUPGxsmEo4gOt2iqGw8vuHriEwriklvt3IHy3mSYTbJXIoKuub/?=
 =?iso-8859-1?Q?tfhsI9COD9SNfAdS3+EYyQbfxXyLATdoOOcPlBL86LNSGcJY2TwyAEyo2f?=
 =?iso-8859-1?Q?Fx7WMLHH2zyd/WALez24nlUHh92akdvpqOz/2cYjXS3uD28CFZXVDg0Npo?=
 =?iso-8859-1?Q?YYm5SA8Lj6p1Bv6/odT+xvrcmd4Y6NTY03XYPwvZw9c81vaW9PiXQJzuG6?=
 =?iso-8859-1?Q?t9jC6wwQ7LMhMBFinHAasGDKvKU2P8n2QW/vwPAOm2DISqnq/gv9BCeBDa?=
 =?iso-8859-1?Q?oS8TbrBfHAuH3eh9T/NR7DDDTggx+sm6SJRR5TyIF5TlNJ0sL6kxUS2Z8G?=
 =?iso-8859-1?Q?2iaiY24yKg6gb36HcK5kphQuikv1dOzii5Wu7D/TythB50PWF748tgNM5y?=
 =?iso-8859-1?Q?VjszlSNm9xsIUjqZgs9lNNwsEgB0yiWA7HzHoL5j2UKw/ZotykOVEBMSSV?=
 =?iso-8859-1?Q?5TnNNAf0FLOW0CL8Fs2nIRAphkQiNJamWhOGKqWHX7S52bVb5paw+MFp8M?=
 =?iso-8859-1?Q?O8594aF5PTveNxMwzkDXpdDnTENDia0i865MS8uz7qJKfoW2oUYgWRhQyT?=
 =?iso-8859-1?Q?bv14k4+XDoZW6cwVlxh+RIskTHp9X0nxu5p4b7hGjphuZCZNhSSSqDmQ5W?=
 =?iso-8859-1?Q?MLPIeZCA9SR0r2EXp+m2UBBeRnWa/zirOm343lp5O3RpCDCQO7iS07oO5r?=
 =?iso-8859-1?Q?fQ0YSrzSEchpaO5mV3/zc37rZcpEjAHpPzQu+7LDJvh8h6FGSuwjLMWaSK?=
 =?iso-8859-1?Q?7+eGwpyEfjig/EIsm/MRodxH4+wPrq0rBjDnYlWA9MunMqgkDuJ+2qjwUO?=
 =?iso-8859-1?Q?y3b1VEswoPL/VvsTKS9MeLPPOQ1Ql+a/qTGX5EnkSLbuDOXAlveoA/qikB?=
 =?iso-8859-1?Q?rv5wKy9qIVgg+SHJWQagXCFMhiKLkiC4pguNMyl4C5nzSvD/VFSv6dSnZ4?=
 =?iso-8859-1?Q?ON7gnZ5uCOi5b76t3ofeBZ1+/2O+ag/yv7kaXpWtRtwjKfWJ39H4SXibSZ?=
 =?iso-8859-1?Q?heeL+YTQrRJhx+/6HGhoQyyP6/Ga5a325qAJsnixMGTPqijhjh9A6Mg+4L?=
 =?iso-8859-1?Q?mD/VxVGoWhTZF1lLoSTUNj5Xcw3gqAFv3LYKcIaYQEhRQLg1kyMVuQHndm?=
 =?iso-8859-1?Q?yNG9vRQ1F4w79KNmwEqdHtV4O/1JRjoRkJIruHNBHzHQLpu70w6Fbc3Hah?=
 =?iso-8859-1?Q?nJu9rDaU27RVmsCCfUbPNGU2/Ayjy12zZvZkMNtcWd4/btLPmiQOVXePeX?=
 =?iso-8859-1?Q?w7Gkj4UNBAEgzYjU372nikG0qXjUSyM/qjbgbAHIIGPL6rOSYNZbeLDDCV?=
 =?iso-8859-1?Q?uXHHFHmN6oes15b9BHVG/B?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AIS6AC8ImOEb0puRRwsQu3qgf/f4vbEzr/o2L7QioFsJVra0Kk0l6wTbuY?=
 =?iso-8859-1?Q?ZHLhomnbcra4ivlSaixDoEGpPPI5QbE07Q8CZ9RX3jgRWDhB8qfdp5riuC?=
 =?iso-8859-1?Q?r8pzF+Z+dZWKpcugNEq5+iipJlUqZAsmeS8yUDfg0qnMW4m7u85l5HPcUn?=
 =?iso-8859-1?Q?VCNy9wFeF10RB/V9Oh1it7LYcwTaGpjmGRUruvyW1J/eC7az/s9ZIut7Fl?=
 =?iso-8859-1?Q?bddK1jPOXruWff1/YPb+THJ2IG8V3J0yd1EwpyEFhpEflLgfW63jIo/r3u?=
 =?iso-8859-1?Q?ZLcUQyyI5WYwLg9Paud+N3XS1cqrn4B0TIUohiiiIgiJkqM0whoMxRIG+L?=
 =?iso-8859-1?Q?OP9tSqIT6NE37k+xgRlwSYBkI5Qpbm1yGMfjj+1ykfARGd4JO7FtTqsLTq?=
 =?iso-8859-1?Q?fDIPbloo8hHRIJeaudHE91DEbOrTmZ78Azc6J+bR3G/STMUzT/pLrr2Mip?=
 =?iso-8859-1?Q?oCkOovq1zGr/FTZDypiaS3g8xroI71xNA0SfYzKjbkUG0BEiBmXLbnyCs+?=
 =?iso-8859-1?Q?l4EtHKGsRJkgA/FoickoDwC8aLHwdqxHZ5/0g8fiiWz/ZYI8OI4iq7+ML1?=
 =?iso-8859-1?Q?G90PmmvLV9yCWij5hAcmUqwc8h1VcGz+5nGfLAnC9o96buSYaj3K2oLi0P?=
 =?iso-8859-1?Q?hbdZIgSqJ2eBJL63KwyxK2GPq15qOIjnM5fEIWj2mi7eNi+7nmTH42SVxF?=
 =?iso-8859-1?Q?6I2w9xVysK/cssnydaV2gXoB1WgB/2BrxLk2lANHGpDLR1eukXUCSmA3NL?=
 =?iso-8859-1?Q?t6gemg/9fsePBKFnwuN5Fz9f7/aVYpntxqrMyGrEcrjtYDLAi6zoFAA0rn?=
 =?iso-8859-1?Q?crxHP4PHw6eMEVyDjTUziTm/Lm802fw82u97rd1D7RIIRqq9cWJ7JsKPWe?=
 =?iso-8859-1?Q?UqoCsWhQs1ACbxnwgzrwjbI9rDFeH1p/ZQNTt8w2rxDqSIoQqnfhIhaZxp?=
 =?iso-8859-1?Q?Z3vGB0qHXz1SapfeKYb+pb3E37saJfA+9wCxx86Reeaf9B6R2tjS8g67cG?=
 =?iso-8859-1?Q?7w9QZJc1xjKcXF/QKy1dHfYG++U9a4dAddV4mHI4rudCgJXFLnInO+Iu95?=
 =?iso-8859-1?Q?thwRkxonhJMWSscIWmzXfjx2w3GoGPgVZVLsWHdm/+cgCKGUtrbUwh3fho?=
 =?iso-8859-1?Q?wd61wFKDHPGRagG64A7Cr2jLI4sMgYdRSX0OYyeOEfgo6lSruaafqlmxRT?=
 =?iso-8859-1?Q?xqPzp7lazklIeCoCfUq3/NkrlUQfLTQfYzIByuKtWiTlVETjlDGmk4g7mO?=
 =?iso-8859-1?Q?FpdvtzrTdtIGEmcZX+V0rmw2Ehg9TPZpoNp5mpDzLSi7Dy9EdVUZKuxgch?=
 =?iso-8859-1?Q?8HCs3NX+JKSF3S1uLMENavsfQX0vJAszR7ATRwSMQE1OaTwCj1318RjCPz?=
 =?iso-8859-1?Q?iD7DTWWe/GB7MDQXUW5EEC7TlMY5ghCH8oJZzd7+t7ivacAjtlEAqb2449?=
 =?iso-8859-1?Q?KwZtyDB0NwrUSQgMSSmnI1JlgjxiGavjRvOpCmXuvRrhjfRnfi7+miIzno?=
 =?iso-8859-1?Q?ZlOC1YpkValzWA9eJxspmFsnqw0VJYwmf4UhxmUIaXTm24x7VWlChGy+Xf?=
 =?iso-8859-1?Q?RFw5zq1HEShl0LKiajy3WAtDu+th9u/xngtgw5RhekyhfJ2c87LKe4tr+C?=
 =?iso-8859-1?Q?htIGLqCyXxip0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6f9013-4bd1-4465-2bac-08dd6608f52e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 10:38:01.5252 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tkV1l1EIBGnCIjLWjHtVKfGu4u8/twx9A+BcojiwtXUKqUdAqSHDdoXKf07ZWx+WhQUybolZ6pYKIaRxrZXVxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4277
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

Hi,=0A=
=0A=
From: Gregory Etelson <getelson@nvidia.com>=0A=
Sent: Thursday, March 13, 2025 10:33 AM=0A=
To: dev@dpdk.org=0A=
Cc: Gregory Etelson; Maayan Kashani; Raslan Darawsheh; Michael Baum; Darius=
z Sosnowski; Slava Ovsiienko; Bing Zhao; Ori Kam; Suanming Mou; Matan Azrad=
=0A=
Subject: [PATCH 1/2] common/mlx5: add device duplication function=0A=
=0A=
From: Michael Baum <michaelba@nvidia.com>=0A=
=0A=
Add function for creating additional CTX for same device base on=0A=
existing CTX.=0A=
=0A=
Signed-off-by: Michael Baum <michaelba@nvidia.com>=0A=
=0A=
=0A=
Series applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
