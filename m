Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306D5C021B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 09:07:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B27D40652;
	Mon, 24 Feb 2025 10:07:44 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
 by mails.dpdk.org (Postfix) with ESMTP id 4395B40299
 for <dev@dpdk.org>; Mon, 24 Feb 2025 10:07:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPo1B5b4q15MqXOcBPSFBMP4lzHglQN5iMA1ojn1A+Jz4Jd8S2FEpGLu26JBJ4xJ5TmvY8PlnR9wTre9zqELwcqo9gAi4sc2r/9zykd6gRFBh0nyRBB4ZVim96MZQGlB6kfCr5ZkOkC7eYiv/uoWrPia3MqTOrXaJ9Lx86hGJU+6DVpkU1mqhlkzJVONx1dkIW7Bu2aJJU6qQ+uk4axgNYen7fVfYDubxGRI9DlH11mQKBrlG6D01Sc9wQIXSXZIUYXpQ5MaKZSwCCbU0o1f0m5ibDncaBQ9yhQ0TnpYICWhZ7oh4b4HWZjsX8UNrGko4/hdbYWZjcWirSGerI6X6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xsu45R12uCL1CRxYo0efKB6+u3G236rC2KnQ+41baMM=;
 b=hP0pIBJ2eVtG6R9uXviaByufijXl+ljet90nX9lJ1GmVVsTsSFsEpyM+oLqaJ18D2pHW2EnsH2vE2nee14vdYA/c/sfIOIATtkWaOsSn7m1GJVv3N6Vm+hB34naNu51d5OVPPvGVbKDGFGydfbvSqEcxJpQU8Dg3JjATSnCj/KyOzfwA4K6sk8nXsrTkJ3M5nhYRt8BAO8s73JYriKvjd4IesPyD1QRarWYj+6t6XKGaiWiZ3rHkHQQaSR67f7okeOZwNOCJe9bFaLJW4FC8/UAx1iDPeP1QeEL1Y76vv807LeAOHgG5Ee7YMk3lk5a2cxXDpmQHoNsRJVTauv5R8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xsu45R12uCL1CRxYo0efKB6+u3G236rC2KnQ+41baMM=;
 b=hA+fqhujaTLRol7+BwjE6YaZCF6tUAfoEhhWLWlj0rNmrMbwLXg6+uu05T4sh2DIw7Y14FX5BfuSKEnFu6JWlmb875uG/f+FyazldxcufFOhfX30PKUjI5R+lpyTdbDbBt5m/Ax8M376kNSCYhlcVhdW9IsO5pietfnysaFQSREQ+VvLs5a6E5gpGpM75zezLP5tDiF+tj9a/nsWDWXPUuRVFAuXkup/T64C8vGjQC6UvQtqEsYFDgwexxrUapNKllac3ikk+LovkNScME8sDfnO3Qrz7WcXix9PULn2eFevtCtsZdoBFNM/t76+eSKp4A5PhQ/FUVW0rviOVkGNXg==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by IA0PR12MB8227.namprd12.prod.outlook.com (2603:10b6:208:406::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 09:07:36 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 09:07:36 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Hamdan Agbariya <hamdani@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, Suanming Mou <suanmingm@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Erez Shitrit <erezsh@nvidia.com>
Subject: Re: [PATCH 1/8] net/mlx5/hws: introduce capability for unified mode
Thread-Topic: [PATCH 1/8] net/mlx5/hws: introduce capability for unified mode
Thread-Index: AQHbgGKmW6k0YpwoBUaI/nZE5hGWerNWNja3
Date: Mon, 24 Feb 2025 09:07:36 +0000
Message-ID: <CH3PR12MB84602F8FE84F8BD5F5DE50BBCFC02@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250216110414.10926-1-hamdani@nvidia.com>
In-Reply-To: <20250216110414.10926-1-hamdani@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|IA0PR12MB8227:EE_
x-ms-office365-filtering-correlation-id: 46a16bea-940a-429e-85f6-08dd54b2ae98
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?J9LANNT5DZW1GXJbcTilikIzDtTwlAYGKdEBhhjSdSp7Btazn2MkZxfUjV?=
 =?iso-8859-1?Q?2ShmDdbA0RXDuI0dmy2sg/VS0RHPnadXmL8f6V87zO6HEaDxBt0sAj9y7o?=
 =?iso-8859-1?Q?vg3q0UaUd05MCbtcH2xKGYDwOyB3nyt1BbUyWU4cQev0m06mZ5UGwzO7Jo?=
 =?iso-8859-1?Q?Qoir90mAx0NESrq4uaXBEimjI4d4twDxm8C74c8+49bCBVPFiiB8bh8fZD?=
 =?iso-8859-1?Q?C4mdvoYaMGgGbgSOaFxZ3bOJhLb9lnTB2VE5d3vjjA02CVgaiIT/OoQWgO?=
 =?iso-8859-1?Q?2W57gQ+xCoRZtGR5e8QcFduIzo5Pb9yWb2uwbDuTjxzgStD/lYODbngGv9?=
 =?iso-8859-1?Q?FwuMXXNq4IfUJ1sKCy1dopdilfcuHRjqP1QIdL6uFpLvI7/TNXlCKTCBuZ?=
 =?iso-8859-1?Q?mX6IdsKwyUjMiF1PjgEwiOuIytjCzoooz8PYwlj8i0P20TO00D6moCHqqO?=
 =?iso-8859-1?Q?bIepO5hujlbTmT7QXqbJ8cYANgyrQxIYvUSeED5OLWIYZGIH88I+W8/0e1?=
 =?iso-8859-1?Q?/H7OVys+ktKVpQOFMTFVHhgEWRikC/pMuSTWrHM/1w+1qINmtcA3/Hkoiz?=
 =?iso-8859-1?Q?joJUhAmVKjLhVDyXWDNajIVtKzF9yrMJPdKMN5oGVjOif9huPt0feVwFTP?=
 =?iso-8859-1?Q?HMYPIk81fSXDW4hPYOIHpiuAM5NzKWuocPGv1tYAi1EIdZj14IFm8G/xxc?=
 =?iso-8859-1?Q?HIJL7NvFODixiatDkja89AiYRiC6kYFleY04Q4eqGQ0CFJ5xR94UGToACy?=
 =?iso-8859-1?Q?XNzs0nlRMVBFBeA/EgncRK1cJNQv8lTBAYdglcw4DEj/lRJW++rQMJicv1?=
 =?iso-8859-1?Q?UCCblzzkvIqDaUNLYcE7irF60ARxKNc0CBbWzPbgH164TkPnO12UYewqZl?=
 =?iso-8859-1?Q?5eXIx0SR/56gqIRw1yHbBWHDuLy1JzjU6+vQm3eUJLMU3hGVG+Qcq7TOPm?=
 =?iso-8859-1?Q?naQzVH8Ul8sgR61dlEi1l4lqw9cNqx2WkYolkhJ2tEydjbACWk75ovuU4k?=
 =?iso-8859-1?Q?R1UkRd+w9bJmm+LaIz2/DbNE2/iEOfjEWaU6mLd8+6CCDZHFG5R7QNYpqU?=
 =?iso-8859-1?Q?cNGsXSD9N7g028anL7QMAcfABIvyeb1VJRapSH+8rEhNCDcWvonWdvpBhk?=
 =?iso-8859-1?Q?UnGm8HSP6Tmvz1yv3x34R/zWgrTrvljqovCktNeRBienDZRwPjAnDYw0xp?=
 =?iso-8859-1?Q?yBG7yGYpm+Is4edNvXIivSkj9rZ8uVmQ9ICzXx/ZOnOn3rBGvJuHOhn6Od?=
 =?iso-8859-1?Q?cG1aAA1SjL84wuxRpw0+w3eok52ySm0dPgiDFeYhyy0uZRGCCtIe7AtQEa?=
 =?iso-8859-1?Q?d/rSBzhQWENjuiUNQs8P7Gl+kiy+uNQzzz8OGrHau/mFbI9Bkjq8EnBigW?=
 =?iso-8859-1?Q?qJOdQItXAPKVqkebvQU6swEdpCnogrKdUj91pWTROyazRSVGZGienqjng1?=
 =?iso-8859-1?Q?pHgApvI4ZSbFxcOlioGR3pG1H07d77W1qgIk53QqU4TxGub3m5XI3HTYPC?=
 =?iso-8859-1?Q?j7wx3PWT/11hVMe5mZZQC9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?17ayRID1RrFqiFAj5hGZt4I1WYeyPOCu/p+RCeKhm+v50KfsbLSiSSjdE4?=
 =?iso-8859-1?Q?lYaKVsb7XPDsdWMOJ8GmnyNrDmz5Dpr06oPsza/d3kRm7rLcAw3R0cDTA1?=
 =?iso-8859-1?Q?bnLrB4LPahe9057Wlr7r3aNfuSCSzfkgnK78T8U+dDdBSy20TBPcuKGlRW?=
 =?iso-8859-1?Q?Ylxoj6fgdEN9kA2yo1XHBEvuF84Mc+CQfLCEFZc1sAX8+ZVVF10xCgu37n?=
 =?iso-8859-1?Q?B5ZGLH+94iD8kCglosSM/nuryaQ3RLpyp/dMtAT6SqujKIbo9iozmwiV1Y?=
 =?iso-8859-1?Q?XQVRX3/6DJwS4cQ/PVq+X5QQ+Qb2rBQkpB4w058wXE6/+uakeThfPwdUME?=
 =?iso-8859-1?Q?/0+b+FGx7q59eoZ4JvW2s7EJHzPYo63eqO6AAEA0ThdZVtavz3h/PDePPW?=
 =?iso-8859-1?Q?7/DhS/oAQ4LdMI5JpOWIWI/1nLgm60vPdAwlFxBq0Lu2a2O5PTzmZuTtLm?=
 =?iso-8859-1?Q?siiqf1QhiV/G7S3aDEB/9h+o2t+W4rcQ0ERpBMbm8DTmbkQMGnLpzGS0T8?=
 =?iso-8859-1?Q?Dxz+tK8TJ+JrIqx/KiqXZvvht3D5KEsOe0f2CGALdUybXeId+0MjJyAqTk?=
 =?iso-8859-1?Q?jdCo9sHJQ2Wj0FOI6qWJkt0M8VAyL5mFKX+f7i4Aao2FQY8trIyh7xYPUr?=
 =?iso-8859-1?Q?Yr1yjH3pwjaHi+Jc0kvLk/fUldlcTvSD7z0opnU6Er0UjwVGKa25alIiGr?=
 =?iso-8859-1?Q?3BpoOAjsLeaBHAhyC46Grq22xM8bpVq5udQyXtOfjwVKev4gXOnl90xPew?=
 =?iso-8859-1?Q?/90S/FvxjYfTZ5aKSPuetp48cO3KVnUrXrDZXs1RW5GMUNcAQiv/jYTTWz?=
 =?iso-8859-1?Q?E/1KrQgh21gnHHnq2ya3pCorsoUEySv2OsHcsWZ0Q9QCvOsYH97mW4mt8l?=
 =?iso-8859-1?Q?mJ/Yi661G3BUroRUwValFSUMOlN4ehd09ZwT7HXmCRhReOqpSb4fa534xV?=
 =?iso-8859-1?Q?G+B3rpcI8f0B2FaVS0+YyqPtAZat6t+1/HTI/j5mOR5nY4TJI5kmaN6K88?=
 =?iso-8859-1?Q?slQj5U5zv9KutOS4fzSxxefKap+OSEA76wiwUjPPH8PCWcg1pPuDZvCrlC?=
 =?iso-8859-1?Q?Es75ZnNHK5sFbt8xlw2eZ/knsqQ646136HnJGINd8adaYUGfIRQ6QZdSRx?=
 =?iso-8859-1?Q?mcB3j8CpCvwlFjXy9etJJCqSR/YtvmW7hdE0G80XgscCRNxBP967jre6V5?=
 =?iso-8859-1?Q?/creedJ1DvQnA7cfq6JjYGCDX+zuyXE1zyi+3sJN3rdzWM2tAhA7/pIzpK?=
 =?iso-8859-1?Q?INmZiJQX+R9+Uykl9NLOpNlBcgH0areeUqfwEUVpbeaJc/Og21CqEZOAsf?=
 =?iso-8859-1?Q?x23MeQFnzMaPx/05/TaeiO7kpSiXdZqgiE6pgSkrgBLR4/PFO6Aiienc6H?=
 =?iso-8859-1?Q?X7qUoeWpi7DW1fPmb6m1d9jlQ4vS2h0+iLpCq241NXTuA8IQhEmqRxAiOh?=
 =?iso-8859-1?Q?Ulc6U98SPid2Eo+swveyEQnv6GfnWi3d+AkiiS10UMRi5NEG6ldJwoYYRe?=
 =?iso-8859-1?Q?zxuapm6lWwwVM1oir5jF6xwS5X8L+xwhxVtAub12HrOHK9EqOXyDvS6jR9?=
 =?iso-8859-1?Q?UdSCn5MqpEjeO3uFxzDqH8lGUhWwFC49KfySw4c3za0cvAEi7X3c0zuHW3?=
 =?iso-8859-1?Q?AXOTW6ya6O3DE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a16bea-940a-429e-85f6-08dd54b2ae98
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 09:07:36.6268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vJ6BZzmrVa/8bSSlhv2+3R0t52jKHPvJ5Mqtzg3+g/sZFFCJ5v5zD+dWwlAEKAxX5u/+HZLzrfvXdtPn4WMJuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8227
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
From: Hamdan Igbaria <hamdani@nvidia.com>=0A=
Sent: Sunday, February 16, 2025 1:04 PM=0A=
To: Hamdan Agbariya; Slava Ovsiienko; NBU-Contact-Thomas Monjalon (EXTERNAL=
); Suanming Mou; Dariusz Sosnowski; Bing Zhao; Ori Kam; Matan Azrad=0A=
Cc: dev@dpdk.org; Erez Shitrit=0A=
Subject: [PATCH 1/8] net/mlx5/hws: introduce capability for unified mode=0A=
=0A=
From: Erez Shitrit <erezsh@nvidia.com>=0A=
=0A=
Till now the FDB processing domain is split into two mutually=0A=
exclusive sub domains FDB_RX and FDB_TX.=0A=
Packets originating from the Uplink(s) are processed in the FDB_RX=0A=
sub domain, while packets originating from all other Vports are=0A=
processed in the FDB_TX sub domain.=0A=
=0A=
Now adding new sub domain: FDB_UNIFIED which can process packets=0A=
originated by any VPORT / WIRE.=0A=
This new domain will process actions only that allowed on both RX=0A=
and TX domains.=0A=
That way the user can define specifically the domain he wants the=0A=
packet to be processed, whenever it is RX/TX only he will use=0A=
FDB_RX/TX, or whenever it can by FDB_UNIFIED.=0A=
=0A=
Signed-off-by: Erez Shitrit <erezsh@nvidia.com>=0A=
Signed-off-by: Hamdan Igbaria <hamdani@nvidia.com>=0A=
Acked-by: Matan Azrad <matan@nvidia.com>=0A=
=0A=
Series applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
