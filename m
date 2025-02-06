Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FEEC0219B
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 09:15:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6BE0402CE;
	Thu,  6 Feb 2025 10:15:21 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by mails.dpdk.org (Postfix) with ESMTP id C6CA74026C
 for <dev@dpdk.org>; Thu,  6 Feb 2025 10:15:20 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTzPoFlcehW6cTr+1KlDaDpONiYaYjQewfy3WP3Y4SnRIG1r2ZjpQpsXuq1Dpp5Yyb7vBEQYIgwBwgi4SdzBFrBKiVv1oNxj0WaX4tXqrtky1IKwJKI59FiogqlVjH9XWb036F9d0qjsI0MlH40xetrqE/C7wxDdNu8V6mv9gnuamUkPZXBvAyQazTu/E2POs760VtIAoIEN6It3fjQbep68QMYwJX1iSEghIyLispqSblLpTGKZi3Wnyuj2s7Me2qVvBMQvoLHVVVXsOmMS/rgHWGuYlhLgG8CRikk8dqPiW5I8Cuf7nfInxYB+UH3AjnOoNCkEpJoeH/Fzuy3fDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAzp5OhVknF9x/CpVIYwJ8A0r2Gsz6c8dpD0Mpzx9MQ=;
 b=vYLUq6abgYGpMtMivnDWjWmDURnMBPY2KjDNdk3EZygTxi3mpeme1O9JARzrxM/2P9u1fwYNkeyljR77IhF9DCzLtSmVMHCU57BqJd2Q4wVvPoFtFSc1hge6mtn9XrWcqlHmIJeh2h7qZ4TL0Tx2blTE0PetEHsnmJkvinGKDNQkiPPm05r1VKofpeKABl0E////ax7dg6SVKUDBgRzYjzBS+d0ReD+WizGdlLoS4Psquuqs2d2YZ/zZy5b/VT8rjtlHWZq5+KCpMMDmxBssbrds9t79VzxvRLzOEHvwWdqV57isHcJgY9x37zBTHMyMXzRpR6cpgJ7UM6fBRW6Mqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAzp5OhVknF9x/CpVIYwJ8A0r2Gsz6c8dpD0Mpzx9MQ=;
 b=jPucs8XXjIDWgc1YGe2j4F3JqUVyOiLNMWnHJHPF2mtT2FnpzZzdew0IXADxtBYgzzzmyuWMjFlWbQdxzCxI/DtmZXrj8Kry9gTRDYzy+DKqrh9dM64fnnjZyt9lkkGtNMlj+17pah0aLUwPLSQ5Jt8fw8XncN2VOMv7yjMPERYUzaMjRQT2XrSnn/sFS4381Uk2OBBajnfUeYSVJ85+zTQLT1kXBfiDjf6d4KKqUDfUW47ux68Qa9QLZXt3Lv6VHKXEqwRfGH2f4qej/8MPE1Lkbq713LwoKhjWKXBrswN0RXrzUcCDiT8vWq2Ez7e0jp6b7bXQmoArIsmhznESTw==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by IA0PR12MB8982.namprd12.prod.outlook.com (2603:10b6:208:481::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Thu, 6 Feb
 2025 09:15:18 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%6]) with mapi id 15.20.8422.012; Thu, 6 Feb 2025
 09:15:18 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: "Minggang(Gavin) Li" <gavinl@nvidia.com>, Matan Azrad <matan@nvidia.com>, 
 Slava Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH V1 0/7] port probe time optimization
Thread-Topic: [PATCH V1 0/7] port probe time optimization
Thread-Index: AQHbVSMKlGl1gGceekGwRwgOm8Kd7rM6RO2T
Date: Thu, 6 Feb 2025 09:15:18 +0000
Message-ID: <CH3PR12MB8460040BF991259F99B11830CFF62@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20241223101101.677449-1-gavinl@nvidia.com>
In-Reply-To: <20241223101101.677449-1-gavinl@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|IA0PR12MB8982:EE_
x-ms-office365-filtering-correlation-id: 7580fa76-bd19-46d8-672d-08dd468ec673
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?umvUHL5oH7a2Ojejrxr44fFBSOdrX2O+A74YXmWsp9VGRn/BzP/sVB26CZ?=
 =?iso-8859-1?Q?xzB0GLkWAISCrkMdGdM7QU+Wi06HONDYisa9rv2H7TXNR2+LuLlRdwkYf7?=
 =?iso-8859-1?Q?aHhBp1U3lm5je6XXkig8T7I1OfjrnnoRzqx4OqPwQ2J19Y9PA0TqKJbxPt?=
 =?iso-8859-1?Q?/+c21rZ3Cxlxqwnuo84L6HKgwxOFUVVWiLCW5DXF3Ns+yx8+s8Jmuu+geq?=
 =?iso-8859-1?Q?sYml26PemZP/c8V7IU3pvn6Q1FZZgtMSINGmxIA/01bHWFqKBxIZUFltP1?=
 =?iso-8859-1?Q?lUpmT0TpQRT0yVZM26BWNMiq9nJFCho6Zuw2FJTsxQupBilqVVeB09eYDc?=
 =?iso-8859-1?Q?MmI8g6vQ20yrtOOcvAkzsOx3ci9XaVa2trdt5YnIilP+tsfDLZzQb6/9tG?=
 =?iso-8859-1?Q?Fon7Hlj7ttwsi1u40X+bgp5/wgIJ2NxlATTiSUwIQzUMcp2EGETr+jDglJ?=
 =?iso-8859-1?Q?Z0PlH5vRgLQcOGHB1jGCMOJPy5XeUkxnQgdF1PwlrOAYRybkLA9y5xubKi?=
 =?iso-8859-1?Q?Y7q4KJ/07V9VAidpDZ2w48yOdCDotJLHo96ssn7mBxNDaWHruDug2dCTiZ?=
 =?iso-8859-1?Q?tKWG0Xbo60nT46O5Z4/oJ4nX5BSgKByG5uwPTBlXJ7Rmq0uBuj+87+d1e0?=
 =?iso-8859-1?Q?oapy+aOmE2pmw262zuvBpgzHqw6zdMXuHK4y6+mRPIlj9NW5DcoCnXFXZC?=
 =?iso-8859-1?Q?cr+TQhfs3qtTHmvYF9R/STJZfOMTNdk8alm71ZDumF4NJH72axahb55mjI?=
 =?iso-8859-1?Q?aSQDrC8LV/Id+86JsiLCcWHlk00rTQIMlr0fSPXeTOeJab70pP6cRbOAFS?=
 =?iso-8859-1?Q?KzuKCg7cNsTr+ie86Tr54KRKDxqLek8PzpetIZHD7TOm6VbR6GVHU6HhIA?=
 =?iso-8859-1?Q?48VlwHaiddO//EHjjYp1sHt1DiX4IahwSLkxOvQ0JmExzhHmzfunLZPFUZ?=
 =?iso-8859-1?Q?CL8E6wE9LyVxwSV3kNRmVl7/K2U+ZYidJ+JeX0w4DW1a/lswKtJ2Qvo8Ce?=
 =?iso-8859-1?Q?DmXq6ybLt1tFo1WMH4YSW/yfe/4q3mmIdvT+nZ41xwcTjZK+XUpOwd6Uuz?=
 =?iso-8859-1?Q?LwBzgS0UIvfv17n+hfjWQbnd3yduFT7u7w9xZCmKmNv7vm3zKL6cZHdt6e?=
 =?iso-8859-1?Q?bd+07CxWOenKD99j47dW9+9nS1vsgvwSfPq0X9ZB6GJk1a2d8rWExAFW8H?=
 =?iso-8859-1?Q?7Jw6EQbHg6fbaCjqjYNYt2OcwI9GuNYi3l/7tgNkgUvqIO8IXYoPC+YBBT?=
 =?iso-8859-1?Q?QApOEFto2IuZN/K160J4zNEbETFzbDAW5m/eHSXJoAq4ROr9XIHpL+gRtv?=
 =?iso-8859-1?Q?sfrSE6PMccXg/RlQlVYZ57iCN5/sLLJaezPh7kRo9Yx+LoSsf+Ie/PoOVY?=
 =?iso-8859-1?Q?nfvnZ3XuYjj/ZLvuhFNP6stuySlZUDTGBX3RV02DzAw+Bh7QNyOUz/mf7C?=
 =?iso-8859-1?Q?Vvk9ny1KzCTKnWJ/nk8zBqE1qx2LlmKgiJuqzd5/jK5Fy7SyWj5HGr/Clm?=
 =?iso-8859-1?Q?6YUA60I++4oG9NNWjhBpY0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qy1O3hM84BTpByRPQyRYakP9noqUfCNTupVwL5CJmQAZrtmCNwoc/m3eX3?=
 =?iso-8859-1?Q?7A5oegU/yXOOhg6FpcWyWNWVJOsMnEZO1eVqKT8alCNkFUvWPRTcp81+WW?=
 =?iso-8859-1?Q?qKYTHd1wNoQbwU7fSN2uorbGKqWWzc49dSpclhnLZT/42W0gfsZ8UF+zwz?=
 =?iso-8859-1?Q?T/67a4zjNM09GF13ZaaEkwbzOdS4d3nwyqEkZJ/izS4ySPUW7SMqlgMurr?=
 =?iso-8859-1?Q?IEYnomDCvxXK0uCIb3Pn2bNOYDNXSosd1S/nnfHC5rkI3bk78E9bxVj/m9?=
 =?iso-8859-1?Q?K7Y5NKPXssHC2fS/WBgWa1LOlrhhU4SmSRLGSzZl1QLuMdLWppkhk/p8rR?=
 =?iso-8859-1?Q?mBZyDxiI+eyF6sP4U2DH/EO5dp2OdZV/DGIg6zOj06VJxZ5ZL6B9AhoPHH?=
 =?iso-8859-1?Q?AOxlhXmVlmdKomE/0LGgDHU5yNW06J7xIZ212UdT917yfu0tnj/a1bd5UK?=
 =?iso-8859-1?Q?xEk6Pcz5XyNlqARauBhjlXaTSbhoxOhZuOYI+YbSw/FMkWcc/EqzhPno/0?=
 =?iso-8859-1?Q?gwryz17XR1xYncHtfc7ByyFiKstOEZzLCqw07z/lSUFwJ9ygQTbXdQaKa+?=
 =?iso-8859-1?Q?3y8O9W00gn1GMtGUuJ+pe27dDD3kyejG8iH080Vhrmuw+CPMX+grQ2yQUp?=
 =?iso-8859-1?Q?IDb2N11wmB4rX+V04iTfFhVHE4EioyFNq9JYB7Q5ylV/J9vXmeCene6ers?=
 =?iso-8859-1?Q?UPhCzjDlMfRBwA1uPgk74ttFTSJoohacWacxqt0GGxQ13BhkTO+L2q7IQw?=
 =?iso-8859-1?Q?rGyzifPUtQELXOGckpVIsdRBgcTHuePFEHWsY3I5mqvNxlx/xVMI236Ey5?=
 =?iso-8859-1?Q?by07hVtptXyj03z2Sbq8UNJUfULXhy9rg3ZRwFZHR0bIMUoCPom7I1hcJN?=
 =?iso-8859-1?Q?7WAOT96Igk1wUr6tjbcvnakXOaontK4XY11YotDaedQeOHPuaVfiVFHDGT?=
 =?iso-8859-1?Q?SoLCTQyv8izh1QTUYgEtwW75rIYhEK3/IWqQtsuugw+ULtARg6K8bvYTft?=
 =?iso-8859-1?Q?d0+7P9H72R2WSsEw16ur+2u8kCVkAEZgosiP0/oDCS7cXXRxdpsS/zC/wx?=
 =?iso-8859-1?Q?njWOYj7YLa3cnCeBUwzmQxKeYLPorXI/rJhPRwzZ31eJsOIMiBQFSzOD26?=
 =?iso-8859-1?Q?rXE077B1HnDsmEqEZPiOjd4sh/ZxYbQECT4DESGy3fLNajktvs02XBrbtS?=
 =?iso-8859-1?Q?7XG3LhtjPMb4Wt8eeTHqht9KpKQmWwSiq67ZTCp2QNYL/heYrnjp5ej0rm?=
 =?iso-8859-1?Q?oB1+GT4/kfDAwRpa0y/c48iI5FcZ6E9bjoQVOKT9JCKIFFdLG7GCw6bGcr?=
 =?iso-8859-1?Q?7HuBIFjecmmVVPe2REwkyPvgBaN/WwQxIK5keWqs+41kWCLY9NBfwtijdf?=
 =?iso-8859-1?Q?GGeXu7AvyQrZ60/vaQt/XIJRYGEXLtrD1tKH5M+8X7GnB4UxFjbRmKxlZ6?=
 =?iso-8859-1?Q?ocMRy37bt5P2Fb8F/kJa/uKWPySTXgaTIYMsyTO6QvWJtcY0f5WJynpCE0?=
 =?iso-8859-1?Q?eXZkz5+/u29SGG3atodR19R2Sju6JpwcjX8wGxyFVJ/hdShbH19dfwYGfo?=
 =?iso-8859-1?Q?KFhwpd1l8WMSWMPi9wXyKQyIV6VtqTh/us7POgAyAn3eMw64DO/n64g0qy?=
 =?iso-8859-1?Q?uTUxvPva06V5c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7580fa76-bd19-46d8-672d-08dd468ec673
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 09:15:18.4668 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HTq3hOz1RCENioMVAZSckU1HuYUstaDg3tM003Wh41zLWlotvIS8rsq1See7TTj3Ac2myDwZza5BVwU3Q8vfBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8982
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
From: Minggang(Gavin) Li <gavinl@nvidia.com>=0A=
Sent: Monday, December 23, 2024 12:10 PM=0A=
To: Matan Azrad; Slava Ovsiienko; Ori Kam; NBU-Contact-Thomas Monjalon (EXT=
ERNAL)=0A=
Cc: dev@dpdk.org; Raslan Darawsheh=0A=
Subject: [PATCH V1 0/7] port probe time optimization=0A=
=0A=
This patch series introduced a feature that the time to probe a VF/SF will=
=0A=
be reduced greatly in large scale, eg hundreds of VF/SFs. This feature is=
=0A=
controlled through the "probe_opt_en" device argument. Setting it to a=0A=
non-zero value indicates the application will enable this functionality=0A=
when probing a device. This feature relies on a feature of RDMA driver to=
=0A=
be release in incoming upstream kernel 6.12 or the equivalent in=0A=
OFED 24.10, ie. RDMA monitor. For further information on the devargs=0A=
limitation, see "doc/guides/nics/mlx5.rst".=0A=
=0A=
Minggang Li(Gavin) (5):=0A=
  mailmap: update user name=0A=
  common/mlx5: fix Netlink socket leak=0A=
  common/mlx5: add RDMA monitor event awareness=0A=
  mlx5: use RDMA Netlink to update port information=0A=
  mlx5: add backward compatibility for RDMA monitor=0A=
=0A=
Rongwei Liu (2):=0A=
  net/mlx5: optimize device probing=0A=
  net/mlx5: add new devargs to control probe optimization=0A=
=0A=
 .mailmap                                     |   2 +-=0A=
 doc/guides/nics/mlx5.rst                     |  13 +=0A=
 doc/guides/rel_notes/release_24_11.rst       |  14 +=0A=
 drivers/common/mlx5/linux/meson.build        |  10 +=0A=
 drivers/common/mlx5/linux/mlx5_common_os.h   |   6 +=0A=
 drivers/common/mlx5/linux/mlx5_nl.c          | 262 ++++++++++++++++---=0A=
 drivers/common/mlx5/linux/mlx5_nl.h          |  36 ++-=0A=
 drivers/common/mlx5/mlx5_common.c            |  20 ++=0A=
 drivers/common/mlx5/mlx5_common.h            |  15 ++=0A=
 drivers/common/mlx5/version.map              |   3 +=0A=
 drivers/common/mlx5/windows/mlx5_common_os.h |   5 +=0A=
 drivers/net/mlx5/linux/mlx5_ethdev_os.c      | 136 ++++++++++=0A=
 drivers/net/mlx5/linux/mlx5_os.c             | 144 ++++++++--=0A=
 drivers/net/mlx5/linux/mlx5_os.h             |   6 -=0A=
 drivers/net/mlx5/mlx5.h                      |   3 +=0A=
 drivers/net/mlx5/windows/mlx5_os.h           |   5 -=0A=
 16 files changed, 605 insertions(+), 75 deletions(-)=0A=
=0A=
--=0A=
2.34.1=0A=
=0A=
series applied to next-net-mlx,=0A=
=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
=0A=
