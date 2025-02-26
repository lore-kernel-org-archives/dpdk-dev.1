Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5464C18E7C
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 16:54:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EFB24029F;
	Wed, 26 Feb 2025 17:54:01 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by mails.dpdk.org (Postfix) with ESMTP id 5EF6D4026C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 17:54:00 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDkBXlLMK4CX4NCNkR5ziU9I77yoL1f8FwPAw7WmhVZjOXCa8+Hn/cFPvygFQ1gSwg2qcrAuJI87gxFl5jRfmHYfe6ru61E1cghhVWQnHXRbSuObuHR5TRwvm+zF/ZssgMNN4SEmqC6D4KFKef0aYvU7JySHDIuZ2YXMVEXe7AWzVnpYIVozf8qlBd6WaGOdSspOcqGbYra2MO1Z21SjsucU6zBqtlExeyc6oqDhYTX9fnr6ZcgU6wNHHL7eMGSIHnQCCxbPkEhyU4+UJKKLUsHgy6036W72vjqRaCMIwI+AWj8FN9EVpHE4deq7k8PgFGbWWMA+RGIxTbktxeQ2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VwyMj9RIrijKgTkRfhgRATMliBy3wnA3ATIKSHbtpA=;
 b=uNfFWbTiggW68rcmpBAyrbL5m4vAMlV2WhpPZ5XqWixC05//4v4Dx7V3TjF/m56ly3xLtJOcU+7WTVMRDiP8MXn0L3KGdHqJDpaxFBE+xGTRvd7ZDHXO+0PzVlH6WgAPem9RK8dQt19TIoQUCHEkUcHxAaejPXaO+T6L/yyXt75ecimTaY5yyo36UCy7ck62DihagVYhG4LRCPn5HtT8TMzw2vlb714UxiDMaO/uNHm/r1oAevCvuopUrft6RiVY/oxu0FucyBzR1ge95U51xCjwcaEg9nr5CsCsQOn/tuXawotyGXbHEXWnqc+5vNIIQI+qGA2A+u60HwyGgEct4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VwyMj9RIrijKgTkRfhgRATMliBy3wnA3ATIKSHbtpA=;
 b=GiqfPEmN29LJoq4haP8Nv+OeL1HFHTmmfe/x+8LsTFv7rXYSYpNa7bZ00vUGj5tz5nhXakTYPDbqtnN8fcMn62y5AGHk3BTKjVBwE5lqz52wdPiq7tKXfwhVbPQxkLpz4ggKpUWoeCnQw49p7f4SauPrDrQtw0sQdZTfdZFba5Usu5YjRrvINQzB0Q4C37M+fjEdBjvyBD2F2hTJhO8lQnUjGS2sQVmdDvIOjUfl6jxuvszo0f+dO5cLqpMScXDT7GV6uxve6aePUFAM9PRypq3c0DCQlD5SxxF4fhgEeBQNn2INticGK5/Tvcv7mIC85iO1KCdj/OROJFjfzip+YQ==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by DM6PR12MB4387.namprd12.prod.outlook.com (2603:10b6:5:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 16:53:56 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 16:53:56 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v3 0/3] net/mlx5: support jump FDB Rx
Thread-Topic: [PATCH v3 0/3] net/mlx5: support jump FDB Rx
Thread-Index: AQHbiGg3FwC+TqmIZU+As+/cXwa11bNZzR1C
Date: Wed, 26 Feb 2025 16:53:56 +0000
Message-ID: <CH3PR12MB8460D497916B04904AB84E71CFC22@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250226140119.2142352-1-suanmingm@nvidia.com>
 <20250226160425.78147-1-dsosnowski@nvidia.com>
In-Reply-To: <20250226160425.78147-1-dsosnowski@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|DM6PR12MB4387:EE_
x-ms-office365-filtering-correlation-id: 0b600fbd-125e-47c1-3986-08dd5686287f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?tRnjbC5b8SsnQJk8eEYirjwaJldoMfrsCPlqwbxgc+IfX0lwVJAmFwAcUL?=
 =?iso-8859-1?Q?WPHXWW2yEeglQN+tUO//BWyXYYywq56Xz64xI6koiRogZg6FTL0yT5NGTj?=
 =?iso-8859-1?Q?38PE/iY3AYit6ZnhqE9I/HAnqRadVb/ZojrZ5B5Y3bQx29obxgL1vyMoxC?=
 =?iso-8859-1?Q?wipLiyh56/R1aiWdONjFofJUh409j6TZEd+4E/CixdOsFaIOIr95xwuV1a?=
 =?iso-8859-1?Q?H3qEQ7ucdH1a4wvhcapzVoCNbqC5F+/AwpemO/9ZMOJsCtdlVIfJGmkMor?=
 =?iso-8859-1?Q?cLHwlrxIHRMd35feeud7TGckFaAZQxHo3PmSrcOInVb0uYXuB722P1dlZz?=
 =?iso-8859-1?Q?ZE4+fyqyWHvlIaTgNfm+ssfBrobAFy6qjCk2DkkrvrCGddAZX2010C0na3?=
 =?iso-8859-1?Q?4lRVS3wQfaKWSExVJ8o8CzeSJP/+kJaxORg5kBtZK87ijopHgytgqroE4a?=
 =?iso-8859-1?Q?WvE9a895+WqgLCYY+NJFDUOOXcPyNN/he+kSz0YbGlQFruvDh6mZ7eCIpm?=
 =?iso-8859-1?Q?BcFPhDrbDMFRFKE28sJasN5B9ghHpRzem7OVAHnRScCTYVu7Uc3/468xJQ?=
 =?iso-8859-1?Q?srAWGC1zPGVu4m9dVImASJWmafki/xgqwrYKDOe5nymth78MLSIofJlhhU?=
 =?iso-8859-1?Q?w2Niun+HBG5TKdGJSXmxDNjm+CG2rz7tRjIj3SBAMsRZ12yKwxtv2/1juk?=
 =?iso-8859-1?Q?qJGf4fxhLBRIrjmjP6rInXlCWJY3iNsVDc06smiyH9yxzBs8ov8cfFsPS6?=
 =?iso-8859-1?Q?Uq2db8ZTnxIru69ICmfdQIVpWx/9yzAaPtEe5IUsEedCGIulcid2r0uUXm?=
 =?iso-8859-1?Q?ggV8b1VTiHPBldMCJlWcEcf8sTYr0DHVagerd3KRE+z9gjBLmfPjif25vw?=
 =?iso-8859-1?Q?N4t7ql+7hzmNxIZ5yaCPZhnCH4QmiZ5u7QMeXcP939hyLjYcWJlDm7nhwy?=
 =?iso-8859-1?Q?1RRe4MmWD0zoOzTXEXOdib/Qd+TVHWzAIc/mvJVhxY+vDXYCV+8VWNU5yH?=
 =?iso-8859-1?Q?kTQ98QlSXOsShZS5tPkWNGQgapXmEdaBmH5X50rvkIJxI49PWQD7zRJotF?=
 =?iso-8859-1?Q?8UMs2FBRLhgjp0iBeIaL86GMP1pmjAdudu/uHHEWmasaTA62Uj1aqGhNQK?=
 =?iso-8859-1?Q?HOcKHIpdDMtTtaQc+qYlfwHGuEnfIbaUQ//WWKA+bqxgmygCvkQo20QKoJ?=
 =?iso-8859-1?Q?df9UaOx69O7UZ8ez9aX4+S6OHzlVqd7WqGXnnvIB3SslgNlpDASLwQXeuQ?=
 =?iso-8859-1?Q?G1g9dUomLulpUhxSpqvqDNAOA6ZR5GaqJKxOGK7gy9UpxBacu2tDnpIej0?=
 =?iso-8859-1?Q?jXNPLevZIp+u9zk1PPlL2iazSEiD3jr2yRjRiPHECC2Xxdhu7d7ctbZEFT?=
 =?iso-8859-1?Q?flEBsGG4rAy+cOmrDeDP+VDYjs8jdVni7nGQfeOl41Qgc1CmPJ2jcDx4Kh?=
 =?iso-8859-1?Q?A6ypoWHDrF1PDL+/mTgy1e9qTHitbnbh9yGNUmpZVGdMvlaJt6m17lVWJU?=
 =?iso-8859-1?Q?LUm4I11/IFS1ix7xc7ynzw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?D/JteVrI3E6p4T7oRBTSC9EWjX2Mnx2d8Dz30JD7/lkbKHCwVXbSQunGVb?=
 =?iso-8859-1?Q?QhusplMOoVEqDbnAEO9p9BGB+2kl+/bI+XEWFKox35lzDm+xXfRG3Ac9fa?=
 =?iso-8859-1?Q?HQVbp3/58m1eIZnldrEjcl+CEIcbQn8r+TTKFRmkAVFGOfddBnuZwYgv5N?=
 =?iso-8859-1?Q?LQRpcVtOe2KqSHFB79i+95wJWuCpGHCyLPgXBC4L0Yfm2aQJPR2JK7G8g3?=
 =?iso-8859-1?Q?9NUgsvjMXQogTPikCG/nDXNpMwH6aWEaIVb/A6vgfY2Wschc+dnvqesNKn?=
 =?iso-8859-1?Q?OD7EhMiZ9uLm9momcrIkNq8ql795taiCKPCVAZoIVKmYKAYoPjA3UIy4cU?=
 =?iso-8859-1?Q?rndlsvPVVXiy9zx0L1NZNKav1ouoYit/j9XNvVs1ITQ0gQsxuiYPSqoD9t?=
 =?iso-8859-1?Q?K5l0SRA5xwPXOouaJpLiDVV1T/3RxIGgsqJ9DzTpeqV7GZQtMZHtyS02ek?=
 =?iso-8859-1?Q?/boWy9RxHh0bqpb2xAMeGnYFACTdAePKDWCWNDLlOAE41UrkIC7E9tAvMw?=
 =?iso-8859-1?Q?fLGInMTSZE6Fxky5HAQtjMSoVl//x+f86xKdzmsV+kB/FwqezyQp18oNhO?=
 =?iso-8859-1?Q?ufHXTBEl7ZdiWFUmueXdTyjBVLsg1u0tz4dvlpEuIlinzd7GtHE98yhr1+?=
 =?iso-8859-1?Q?kKXJNWZg7Tj0w2jWOR3qrbkQmIcw/z2QDgxEWo1e2wh8+YMgqkHdd0e1gR?=
 =?iso-8859-1?Q?rgWENDuNVaukZIpoHY7OnPQXgQfjLN5++CuWHIcmJ/fs26/a2ns1DrRSLi?=
 =?iso-8859-1?Q?/WAXKiHH1jrg9WGTp/gmuMFq5ItXukeGAnhtALEi2qzEgSPNV5JYn/hPWi?=
 =?iso-8859-1?Q?oGoK/+Ddswaitfdh+OGpYmUBwy5SRBIEpv2nj5KKmt1oAZHASkigblWx2L?=
 =?iso-8859-1?Q?qJuowYYyK41iG05WuFxjWb2upKtHW0aVGGTN0w1lPQZt1+l7Gey6WEliZZ?=
 =?iso-8859-1?Q?IFlWYY/EHO0mFhZ+9fckgoBsGzBHed0ZfJR6iV/rw49MPw9Se49qDCsy0F?=
 =?iso-8859-1?Q?GL9qOFOPH36EZWe3Wo8boen/Ujq/cxJEs+3i0rHslNvx6deyJMQffJ0tDc?=
 =?iso-8859-1?Q?rUiah4PlNUXmtHbFVOaOn0JaPLY1vM6429MFWKBup+XFpljwf3BAcFJLyy?=
 =?iso-8859-1?Q?AE/HjimSbk8uIzIE6rYsi4dMJemajZkmgcbrn7IlHZ6qZvT6VeXKqjdl7E?=
 =?iso-8859-1?Q?i7YdM+BzVkTVdmKPlcdqZeyuyErM51hHiaPVV0qKza687Vngw8sqQ6Mz4R?=
 =?iso-8859-1?Q?4Rn1AzYW+RcIQ4b/0E72Jn85ogt6AHTZiYe+Xyydyvuj7Ia2oFqK2pjgFi?=
 =?iso-8859-1?Q?IQpXD1Ffh+U0saoydwIzTP2lKLrzVe/FsVPmQ04D8i04iBf9CzW9PwWzGN?=
 =?iso-8859-1?Q?cFBefYCmUPNN5S/h86BKg7dZ+BkGDclTcH+Xq2nubNL+7w22sHG4/2hdMH?=
 =?iso-8859-1?Q?a8l66qTGfxFU0TIW7uUKqAZGbkdlBv7wqCgWoL7BLqqYFc/5yIMcP4P6Uh?=
 =?iso-8859-1?Q?jEcB5YvJRrVpuSEV4Zf+SADLeMgLYuIz+HeZ/V5Zy+WqK8yIAqEaV9h5ZF?=
 =?iso-8859-1?Q?kikwiZ63Lx/w3khzBDB2f7Sh3BzJUpT6ywINwBnUeaCdgA2YHHa7OfYO0m?=
 =?iso-8859-1?Q?ssKs50EmpF5fVoWcKqyx8rjyrdKhhG3Iuh?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b600fbd-125e-47c1-3986-08dd5686287f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 16:53:56.1433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hnygp4wJJM8cSQCcA+izLIRs8+bO0YpcYZDTCrZvX/Ie8XxVK/HY2Ay/9GqpLGhRKMrUwCx62oIpKWby414obg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4387
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
From: Dariusz Sosnowski <dsosnowski@nvidia.com>=0A=
Sent: Wednesday, February 26, 2025 6:04 PM=0A=
To: Dariusz Sosnowski; Slava Ovsiienko; Bing Zhao; Ori Kam; Suanming Mou; M=
atan Azrad=0A=
Cc: dev@dpdk.org; Raslan Darawsheh=0A=
Subject: [PATCH v3 0/3] net/mlx5: support jump FDB Rx=0A=
=0A=
Before FW introduced the JUMP_FDB_RX action feature, jump from=0A=
FDB Tx to Rx is not allowed. JUMP_FDB_RX feature introduces=0A=
the internal loopback for Tx case and allow the REG C0 C1 B be=0A=
preserved as well.=0A=
=0A=
This series adds the jump from FDB Tx to FDB Rx support and allows=0A=
RSS action in FDB domain rule when jump FDB Rx is supported.=0A=
=0A=
v3:=0A=
- Rebased on v2 of mlx5 Unified FDB patches (series 34723)=0A=
=0A=
Suanming Mou (3):=0A=
  net/mlx5/hws: support jump FDB Rx=0A=
  net/mlx5: add jump FDB Rx flag=0A=
  net/mlx5: allow FDB RSS=0A=
=0A=
 doc/guides/nics/mlx5.rst              |  4 ++++=0A=
 drivers/common/mlx5/mlx5_devx_cmds.c  |  8 +++++++=0A=
 drivers/common/mlx5/mlx5_devx_cmds.h  |  1 +=0A=
 drivers/common/mlx5/mlx5_prm.h        |  9 +++++++-=0A=
 drivers/net/mlx5/hws/mlx5dr_action.c  | 26 +++++++++++++++++-----=0A=
 drivers/net/mlx5/hws/mlx5dr_action.h  |  4 ++++=0A=
 drivers/net/mlx5/hws/mlx5dr_cmd.c     |  9 ++++++++=0A=
 drivers/net/mlx5/hws/mlx5dr_cmd.h     |  2 ++=0A=
 drivers/net/mlx5/hws/mlx5dr_context.c | 17 ++++++++++++++=0A=
 drivers/net/mlx5/hws/mlx5dr_context.h |  2 ++=0A=
 drivers/net/mlx5/linux/mlx5_os.c      |  9 ++++++--=0A=
 drivers/net/mlx5/mlx5.h               |  1 +=0A=
 drivers/net/mlx5/mlx5_flow.c          |  4 ++--=0A=
 drivers/net/mlx5/mlx5_flow_dv.c       | 32 ++++++++++++++-------------=0A=
 drivers/net/mlx5/mlx5_flow_hw.c       | 28 ++++++++++++++++++-----=0A=
 15 files changed, 125 insertions(+), 31 deletions(-)=0A=
=0A=
--=0A=
2.39.5=0A=
=0A=
Series applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
=0A=
=0A=
