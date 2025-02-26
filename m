Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC98C021BC
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 08:39:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B25F24065B;
	Wed, 26 Feb 2025 09:39:47 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by mails.dpdk.org (Postfix) with ESMTP id DD35540658;
 Wed, 26 Feb 2025 09:39:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUT63XtKrENsc6vRcz8E07Wk3zMzsYp8EBcPZKMxvn0uE6ZceJEwW2Rz8X1i+z7jPakoO2OY5pIOBqW92Zl0cV+RtpKZvklqTBXQBUyrPVyl16ZiFJab+csJNYBAMPV5AZYIAhjoXBc5QQsaoKmkRXmv9oANN2cSZOJObHo1aoaBMv8pyKfd+/DQ1G5+TmRi1LU0naT3DEUE76MK3uYo4sc5OCiuzy/vty7knLxAA3YbUiz8NWFcB7jm8nJ9Kf0LJo1mi+1jMPcBOnN3xIRh5jiw96f+KVbJAHofxS3docFva2ZuprBrOSSVveq8T1VAzfaw3mE0LlgrmFBdOOIkEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xclMRK6CXoiAK6Px5IN22pJE10yzbc1Gcyial4+PT5c=;
 b=mAPW7mO9/4zjZx0e4U544HDVwxk6bQq2xzL0VHOp4zVnuyFZ9NXF5YcshVzZfZ1w8Hb/NPeqikAUOtLCbn9fQCLVEBam3etb6xrzOjtDRl2PSbtYUssA9jSVq3o5ki6K1V9XKoErSaFXfyJa+njdD6Lr3wxi5RfxmwWGAkQB6eQhJ62YMtS6abd5KxkDNxRQJE6t/9zz3Hu8XRritkIiMEAE5wkClj5rJu6kdSNG0vUe1aZSbKSkgRr9BF2TC2RqWOOx+xyn/p27NgQt4b1ndHsRsmht1BN4+h9FPtaliPpTR3Uxgwg5yfFOBI8UWTktWCYTJ2B6kNU0ZTRgGJgCaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xclMRK6CXoiAK6Px5IN22pJE10yzbc1Gcyial4+PT5c=;
 b=TJ9okAiUFw/JcCPCalXQXLvqEHiq6+klL9WwybXBz9613QCTKJ1WAWfHQG7ciNX1Jf12XFOlvHYCf/kTIKRV8sbuXXsTPLhpb4Rl9kVI90o38p3iMHYuQ6kZkRicu8Xnqkl/FuAes8SJNPkI0/5Cbu2jQq/Ne704GtMhNER7Y8SUFFOpD02WBOgYOp6Xpm0LCM+e+rz84Sx9MfjY5//DaENidjceJPm6sXFXPwn8QvcAM6+9XCs8g2Qc0rcVfQbla3FmqoS4MeC2xqhRkDSeJ7Jugxm84FgO9MULgmGCMzAbwl86RfxmjSEubuJBEp/7LA5DKEWGWODmpAdGRjlEbg==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 08:39:43 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 08:39:43 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Gregory Etelson <getelson@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Gregory Etelson <getelson@nvidia.com>, Maayan Kashani
 <mkashani@nvidia.com>, Raslan Darawsheh <rasland@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/mlx5: fix packet hardware ptype translation
Thread-Topic: [PATCH] net/mlx5: fix packet hardware ptype translation
Thread-Index: AQHbevs4p40LM/bOAUeXvRtpSpzrWbNZXd6w
Date: Wed, 26 Feb 2025 08:39:43 +0000
Message-ID: <CH3PR12MB8460EDCD521B1BAFDC5EDA0BA4C22@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250209140106.264556-1-getelson@nvidia.com>
In-Reply-To: <20250209140106.264556-1-getelson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|IA1PR12MB7565:EE_
x-ms-office365-filtering-correlation-id: a090344e-ac9c-4298-0aac-08dd56411e3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?V1UDsFOk2hohNGZ1vT7m1uVJlUpL+Q9lzXJbeaJf0/4HuLzJHazixk7cjxlK?=
 =?us-ascii?Q?TxUIa9W6lSFR8VZaxSq89xwGNyvQenNAVwSkNC1sfvdr/I27EA4QUP0FY7Tr?=
 =?us-ascii?Q?xuTWaXgRXKGs5ATf9MmCf0wD2SheRQNKutKSVp4vDe5dDzMk6SFedrLJOYYl?=
 =?us-ascii?Q?YkbU+Q9bE/rdF4ZhVmLzrs4f/8YsggBFSOUu+x0fqdz1xU0Vb0kFZhIYF08q?=
 =?us-ascii?Q?d7ivWxtSjMm1TcB78AZ5AXh8IgUykS+wVeWHUj03rVGR/9VWGjI6Oy1DGfWr?=
 =?us-ascii?Q?6D7WzBHhsHbS4fGSOnnJb/Q36wLNo9MIzI6KxpGWUoDzBQ0nx0yShg1m633r?=
 =?us-ascii?Q?rP8hXmAdAmO4fgj9vD1NxDFl8LlIzRYEOPgpdiksnKOfT7N3G8pU86a6m509?=
 =?us-ascii?Q?wAspo22hcZjjz1bS/deSwuQlb6ll5p0ocub8T1G+GqPpqNeO9HKeS35C2vMd?=
 =?us-ascii?Q?fuA5KI5bza/hIkUdRwNKh6hKa3dmx/kebAdAs42paBvKDPnuPIP1lTKL5IMv?=
 =?us-ascii?Q?RuV8uY6YGzrdhGbbdgfgcibGabs9IcEtz2nDyiuyTvFGyBjkc1pXnsgR1tXg?=
 =?us-ascii?Q?WaWs4ASKv6c3F5Vc6a6v3mjou0pHBfjguT8dRvAkD0UMa1j0SNhYgn+ZOelN?=
 =?us-ascii?Q?/50v7ZettAw5sgUO2cvzlYl3i5f1wW9eKcFS0UB6XLqYqp1MNE379TQCR1AJ?=
 =?us-ascii?Q?r3h5vNCvxDMiC7cTLZyfVL2/W2lS1NaeMa7KMmqKCc3miQ/5nHHWygoQ81fd?=
 =?us-ascii?Q?ZKK4Qv3OOIyRcBs/BAspQ6c5GfV0dtSBR2Gb5Kz06PI4WjU/Xr2bVxSYsevb?=
 =?us-ascii?Q?GoWjZQ3zmJEsf7CB9q7/3z2T+4f5Fc/aARqOlny8mnXXDLT5F6H3QJlK3t9C?=
 =?us-ascii?Q?P3plm6klbIoVfDAm+gGG7tQOFuYeDLHdGnVaCuNOEplOCMOP8AjgBnQO4MwD?=
 =?us-ascii?Q?EAicklXIWSlB32GX2tYu7afSR2VrhcsE75LBL3EIGMEWXPkBl8FK7AR1Mlrz?=
 =?us-ascii?Q?FZL2IG4HJpfofb/moGAA+H/lXFnhac3SiUpjEW1EXZ9wNDsXo2zvzP3vSOJr?=
 =?us-ascii?Q?POOUOKdRseHTLd/zznGAOEsUqq/fzMGSErBZhmWZZGHZGvtd/49TKK7Xwc2n?=
 =?us-ascii?Q?G4M+6/E5yYzX7hPQ4ZSAoGXmP3rhuI7EEBO/fVQTnp92cOWBe4EC6sHEKfJz?=
 =?us-ascii?Q?GB0GKuGyYtMSVi55pcMPyht7K6/DbTcA4u4A2p68yvxoQte8XNjCRmxM5jO4?=
 =?us-ascii?Q?HObToNGxg5vQ9pI0gRvC8qie78CIalye8ggLNXPubStWD5oAlQXqwKKezfE9?=
 =?us-ascii?Q?2Fc0rJXigfOki29bjBfaOXpAVumIEamf1iJKZ6QVBCMiQrJf9ITJxYEmdbsg?=
 =?us-ascii?Q?9PNyyiv1y/t1fhmkUxNy5XrZ+gOrA2rBp76le9XXjeUpSFI6awS4Fh5rv/L5?=
 =?us-ascii?Q?RL8Qjo3wQhNyYmh4SSNtL1B2bIyyITV2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LLDb5DIdhkwgWFo4dc7nukwlS7rPqyJUhDRkBNVRCiMm3oBfmeEs1v2WZL6D?=
 =?us-ascii?Q?MG5dZJOyqw0VcblemIUTxY9In+cdsHP3IM/OLqPjFhSobyY5rKUUA9Xtxf3/?=
 =?us-ascii?Q?6ukqay3Fds26CqnkPHNV+11l23tbj3zsy33W9PuA0nxqYMUgJj+Nj96NAJsn?=
 =?us-ascii?Q?kwKtFsxAzm5gyCpFb/DzDu6JnnsHV9VhFhV+9XcefguacRrD3P5Nz0a61seq?=
 =?us-ascii?Q?m6gscyZ5OD2Z18aKDr63+qNE75UjXs97ZDf+Hc6tOVYS1WWlwd9j8iOCg4/s?=
 =?us-ascii?Q?y3D7U6jeTPOYSRCin2S6weyV/7hGynlhF/YdoDB5egS8z7Vex/zkUaqkjYIL?=
 =?us-ascii?Q?ZCAZzjz288pWdPP9zxoWIfVEIGm7Vu3z6sRjbgMIMfnnSKwomVEVZwouGSeU?=
 =?us-ascii?Q?7xvYprYri3h7m3CviCMal71WaXnMR7dsidaoEe/NSZJK77bhxTemFFQYxrem?=
 =?us-ascii?Q?v+qT3pxGjSoOtiFuYLPJqVAiIvTnAqJx0qoVICqWCn3SoCw1wRPZTXPYB1kt?=
 =?us-ascii?Q?1MO53dgDw+gOdt2E8bUI/P3VIaObTYpFUGIyD3MEJT3CjGR6Qru7KRnsexYQ?=
 =?us-ascii?Q?WNmphFNlHHzRKxN4IO2oVwIqMdWE/WK3VaDfH5UrEYwGSGmi50mDeVxgozxZ?=
 =?us-ascii?Q?bUdmIJ0ljqKnxDNb9oW+zFf8OqiXp090HEr8nmKX5Ix4MqmPej/b8S0jCZ+u?=
 =?us-ascii?Q?8ceFZVWggnrcsvbtrx/e/o0+SGdpbRYEYbgtpWFw9hiYDeR+dX1+JXHt19sc?=
 =?us-ascii?Q?No1vU9iLMNOgMCobEgOz2osk6sjtbc0rY6kHRdqYXcnYWx+wFj2zB0MOF835?=
 =?us-ascii?Q?a4mm2q8/nQjCMpFmA9lfzDzxbsBD2InvWCKdcnemeTSJNDvK0ALNi1PkvxER?=
 =?us-ascii?Q?aXvejVc78z8rczcXH86IbFwJ8Y67grZawNTgTPjBnXTeLd3JKIUFJexyIGlV?=
 =?us-ascii?Q?nMYlUmYYxL8QhbUsME0y/QwF+dpBeNWyTeB4nKSBSWlgq9l855+of2BDPSzz?=
 =?us-ascii?Q?tHLcWPv9mXlkfqjjmt8cZo5/5QqdNaeuQPVunn2sD5xatyhDOtZI1WJpZKcR?=
 =?us-ascii?Q?b+jLLjLsA1B7BV+3Jco6HZX1boyvkrxcTYuTCcko50hs2imph1kzjssfo4TK?=
 =?us-ascii?Q?+Hnvv7/R8obOdRUpxqWQ0wz7OWTPgFoyXAsMnnq/MMlZzVXIwqR+Q59TKu1e?=
 =?us-ascii?Q?S5ejpHz/s9dRc4SRkvwSz1wiz3sQuvhOawr1YYOojPgWHElxTT/+SQFK4ROi?=
 =?us-ascii?Q?O4s8sh5O8bqaAWQY/LaUmDaeeUrJsj7CKg5NsNvI+EbbnBMf1TBWIPfYCq0W?=
 =?us-ascii?Q?9fYE3OP5aLblrml6Md3c2Y4BsFb/EklsU6lUDfnAwsMV8jexrRibmIc0qxSz?=
 =?us-ascii?Q?bNOQ6nt3swFCAyk/fHh9UEXkZduxcTuEuiwxJvVfO92qiu/Fmbu1PJBFDJoe?=
 =?us-ascii?Q?WeMY5waXgUzVrVs/zEDqhlvX9SFXKInKB21fPiXa0f+Eilb5O/bAxogIzziE?=
 =?us-ascii?Q?fEISWxmRrKEAR88R0PJf4tUOEpgJT5utmIkj3XhR7VoTM+6wBqCKjwFnQLx2?=
 =?us-ascii?Q?jjDKMe6WHPKIihe+ZeZeo9UHQICxr/pXBC+p/H7S?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a090344e-ac9c-4298-0aac-08dd56411e3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 08:39:43.6457 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dg8XG1titRBt4WG6MXZNJiOprR08CRRcOpYJLBT53nnONlqElNTSrP/0gsKhdbAoueZGnV73ToYnZ1KLjAG3yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565
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
> From: Gregory Etelson <getelson@nvidia.com>
> Sent: Sunday, February 9, 2025 3:01 PM
> To: dev@dpdk.org
> Cc: Gregory Etelson <getelson@nvidia.com>; Maayan Kashani
> <mkashani@nvidia.com>; Raslan Darawsheh <rasland@nvidia.com>; Slava
> Ovsiienko <viacheslavo@nvidia.com>; stable@dpdk.org
> Subject: [PATCH] net/mlx5: fix packet hardware ptype translation
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> From: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
>=20
> Since ConnectX-8 NIC the hardware recognizes L4 protocol in the IP fragme=
nts if
> the IP offset is zero and reports the L4 protocol type in CQE fields. Thi=
s case was
> not supported in the ptype translation table cause not reporting the ptyp=
e in the
> mbufs.
>=20
> Fixes: ea16068c0064 ("net/mlx5: fix L4 packet type support")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
