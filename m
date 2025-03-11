Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55747C28B2F
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 07:33:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE8AE402E1;
	Tue, 11 Mar 2025 08:33:12 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by mails.dpdk.org (Postfix) with ESMTP id 7C7C140263;
 Tue, 11 Mar 2025 08:33:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHap4j9r6mM+AZLBDTPa+d7/klW6c7YS86f/BG+d/zk8UlertfngHZfZKPsyVYCyYFboJxcvr0QtnvMh5PmHGVzDR07+Q5cfWugk6adQblqvoHJxcGywxoSep1qL+fhKwGBohjNGzWmEXPAQXtbNgvW6Ec33CavIEsGUkEL9S3gghaqBJ+8BuiDEqssu5ESD9Pv6bY2eRQ/N0dYjJCser04PtPlPwGtcKxU21LZBoniAVaJWvn0WPzN7j4rYfy8ijgOo3BmPRgogxdXh7u+ApaZXgpEqJ93J18wZTme2+tauqMlRYox54mol/cfpXJCqlglWSXiO99ZKLrRGYEJ9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlKnc7wbCYwa4vi2FNENkcZ9yrxOSxZoexOExt8vqcE=;
 b=CyRZXhTag8+S9mt6B0q6C+iTTeqIWAlxQrdunU3++LR+flvu7lwIKaQ1npmYWJV6J38y5mde0iaKRGrGvsiZwSJcB96L9tK0tXoSsbQDslVqmxpCxp5J7NkDHTd+zqSijx0gNO3bni8IwXKMOfLhUPBd3/QuG7yNOfmEW5P4H4thrju8GZGTKc1sSzgTJ1ARahkvMchb680jk5viQULneHDaA7gC5DJZ/Ceu8jFFogk6YlOMqjG/si1kmDUydVIqP0ctDSeSU7pOrjl6Q0LTNjqnIlMN1L3zWcWXR63mqbLtmfyP7zj5byN61Gdnmg9Ix5JfFDL02prFdlP7PuVbEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlKnc7wbCYwa4vi2FNENkcZ9yrxOSxZoexOExt8vqcE=;
 b=pdBEycGhuY3rLjLfU1wn26Z1QiNC/MSn61ckSb+xRZby1yUBxSyhgaTJAcSH4OcMRlDDdKEHonosXaMSB/xZnx15E+YtsvVzbLn7sgwbiMoJ/spT7HL+NtpcMM9xilBlNH6mCkZ0D1t+QKAo4XgShwL3oJfj9lEVTUTi4Ix256+e19f/F+6i9pb2v5H/SkIfPpORD4h2xoj5GS4hHxqgGUeM6a9SgDIC4IFKylaf2LACZfs6Iqc1GjxtR+lYlpDED00fiZUnjloO8+A7BKGAHymuMIG+E1PvsNmSHzoeGvkynsOIyPYX9FWf+xnFIeGKtIIi5HG5uY18+eP7WNZ+jg==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 07:33:08 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 07:33:08 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>, "stable@dpdk.org"
 <stable@dpdk.org>, Slava Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Gregory Etelson
 <getelson@nvidia.com>
Subject: Re: [PATCH 1/2] net/mlx5: fix non template set VLAN VID
Thread-Topic: [PATCH 1/2] net/mlx5: fix non template set VLAN VID
Thread-Index: AQHbiQTH6A444rEjJE22mKFfgGAMgrNtnX2f
Date: Tue, 11 Mar 2025 07:33:08 +0000
Message-ID: <CH3PR12MB84603133DF0FB485FE136EDFCFD12@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250227104531.93668-1-mkashani@nvidia.com>
In-Reply-To: <20250227104531.93668-1-mkashani@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|PH7PR12MB7940:EE_
x-ms-office365-filtering-correlation-id: 89334b34-aafc-47aa-4a3d-08dd606ef87d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?MCpcSymSh/1lvwrcmSGbnKhA05oGp6ySafgO2lKfC0sDAVzmpidfdjztx9?=
 =?iso-8859-1?Q?a8+Qtcqmabva5jitDrU03FlXuXQ+v4Ll7oaxW2L7EvdLlIbrIdq+ZZvixi?=
 =?iso-8859-1?Q?aPx/FqazRevtKB6uTjzc86XJuS/TDoFRh9G4rXhW/F/Bcbd5y95BGlPrJ8?=
 =?iso-8859-1?Q?tfXq1MxnjD0FnHAvkW3V7Qbl+mkG0Q4feINDTUtYVKU4XyJcL3zAe/iGew?=
 =?iso-8859-1?Q?cd0K3L5wSSoWipoI+Pb+L+mQUjhwC3bXJtvOv8CwexaR3QhhUv7/Es8wlj?=
 =?iso-8859-1?Q?980N32HX1GuhWMwRCQ34Tj9qZ6aK7qWRUcRgY/UheG94HLPyVa+JUItIki?=
 =?iso-8859-1?Q?fFWaq+G13RHY2//4qXLY2aeHjV2ejF5niIfcSMYE/OIsVLM8saoKGEsvUm?=
 =?iso-8859-1?Q?f717XlcTQwuh7a7kZqvHYoqZF8wNiOsgzCze4bXTGK9XCg7dd91/lsNSVP?=
 =?iso-8859-1?Q?rYsAFQoWvqAgL4HMnpFsE3I3tRHFfamtTEdmpx6WUFvzhGCA5zI2Qwvajn?=
 =?iso-8859-1?Q?Up9LcLyMZHk86g0/uGMez8tbvnF25+cLlswYe16xm2h/T4SdADKhN3UlE4?=
 =?iso-8859-1?Q?qobkBT9i6G/A0EWXqyHjNcQ9OeiutwhpfMGkWNyp5XqfsUsFA7GdDfwQhh?=
 =?iso-8859-1?Q?asA9P4kbpl4zSMXCmNTwPWMdcvplWnT3m1figZ2IQO7lXy8YPyLXqkhZEF?=
 =?iso-8859-1?Q?DpEb93P3p9uxXyfMJDNNxbizQdAbqzZWBmh0WpAbKZTNlNwxNlv03K86jD?=
 =?iso-8859-1?Q?WYGGigU4l6KF+V234S2vinjEgBG7K6vv5Rl3wLl+FBfF35ASqOpileG+5o?=
 =?iso-8859-1?Q?NUYJs4i59nj+jWMkFA/noGC9Y9Xd19A49NjewUC08D2pMjlclaujWSUbk6?=
 =?iso-8859-1?Q?uVMPgTnV5cHIxtwb7WqAD0zgy5aAH1JNFFkat7Azt753ATrmJLohDE3xgZ?=
 =?iso-8859-1?Q?oNSLUK6IR4Nb7UbA+L/eN9yrumJnIl2t2n9s1mSZYtKh8Gak3hkUjiYgja?=
 =?iso-8859-1?Q?XobyLb7ClRXoR0EI0MTqzXqrmSX8BQFA47Rpo8BiJWd0uQgFj7PtTiRJjk?=
 =?iso-8859-1?Q?9gmbom6iPE9IXT/KAWXVNhtVKcr8hYRxn0bXUnUGFmSOpT+5ixxNAydGib?=
 =?iso-8859-1?Q?Pcao6PZl2L6yxV0k7PIrKHvMrBLbyNQz3l/Sxk0GPup7C7FnOrFh0XjDEA?=
 =?iso-8859-1?Q?rn6w45M0K77QniLZxm7H1bVydtYmEc5NnitLFQ+U3WysNZCktwy/F2K1yX?=
 =?iso-8859-1?Q?suVWGRBp6suCDi40/qTv/KXLdkJq8g7TowX6V9IAVR6u6ySDTk4wVE+60o?=
 =?iso-8859-1?Q?jAG1uHWyWZgR0k13AH/C/nYbNKitRcia0rNr01PXZ0R8X/bOuLuVjtD/iZ?=
 =?iso-8859-1?Q?TcS7mdP6SgcugbjhO4Rh0YjHhUUU7AUQWuMppVfK6HXQ7foD5EyvT7lFe+?=
 =?iso-8859-1?Q?cA+zZ05EXNhY6Ukx3T4ndu4B615+3Oj1tj7lr++IBXK4kOt5zXxtatuXWW?=
 =?iso-8859-1?Q?Sfr4SwE5Ja7NlYuVwrYcHz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kKie6Xb61HHb2sIBa55ROMjCyw2RQQyat3LD8GpTRwQfrkUCjohJ6OiECi?=
 =?iso-8859-1?Q?gYTJ7zEUnF9oANnOziFACP7/eJr2EgEChUlCvC3FKTxS0wSTQNT5pEcwdD?=
 =?iso-8859-1?Q?N3sZE0aKfb8FkmPleAnLe9fcYGmyrbeCvSuAd+LwzBDE2YmTg0qn4PliqA?=
 =?iso-8859-1?Q?7x0B07RUOtFZItFM1092VXn+8pIOeC79Qzgr4+w3aJeQQtSYutjksPqQXj?=
 =?iso-8859-1?Q?j/lSEee6vCmTgRScgSCyb/Y0Y2U/fzwGzycMvnVXVFcajPXhac6qSfUbu0?=
 =?iso-8859-1?Q?PxE4J0t+Zl49Jw77e72YPnkAFaAaUf1onr05bfi+xYV4xCzAOBB0OOr9pJ?=
 =?iso-8859-1?Q?WTWk/lObLak6MOvRWc22nhNXO7nPXjojVkUfHpvehFLD2n7LLJTiyEFlMs?=
 =?iso-8859-1?Q?pmY9gILlp8Rxcrgwqq0rmLmPwhG1wJ1AQ1h0NjTI8Q3FOnMhbQGpC6TaZQ?=
 =?iso-8859-1?Q?YpgJHy4Fuxg13EPhZoAQYpIeir03HAULNMz62FVTK2ygQ69sfrZjYKkZ5K?=
 =?iso-8859-1?Q?n9L3H49z8khMvFGrMIZpqJlGpkxTuxQN9W1+FFXqHnbe3r9FNjWI+iX6Zq?=
 =?iso-8859-1?Q?oD3/S9IWGTOsmK1ralBNf4+qfelcExd88xJisb4x9lBhvyNbw95S25UQsE?=
 =?iso-8859-1?Q?LjXR8heyRR7ruovfBTHh0/9a+FwtqFMfFovQlZGAeY9HXWhm+uInmZSnSP?=
 =?iso-8859-1?Q?5GlCKHE5DkW04vDIJrvl4ngmrByTdWc2hNoovHnFqsHiJ7JXf/GI7caXhj?=
 =?iso-8859-1?Q?HUxj5yqQWYblJNOdMxwXkQrS5uy1fvZrJlCzXErBY5AWaC8jxIcXxDGy5d?=
 =?iso-8859-1?Q?3Ja/lbuR/Wtcgq2mSOzUIyp5a3NqGFd3PPH2N7zXQCcb8ORKnISRDZkUNZ?=
 =?iso-8859-1?Q?92QTNnEzCt9pTwutQArvddrviDdfOQkfEIZfGmUmQUlLHFX5o/nAyJwnoE?=
 =?iso-8859-1?Q?UuzgIGG8EGShfOnBPWGgW4DtgK8njiEiA1J30DsT22mB0tO4o/qs4lA7Fe?=
 =?iso-8859-1?Q?Fujcpz+7gKzyS09vXpCCnqujGlqwJn+9i+UhJlW3gl1R2eafUkY5avgzHN?=
 =?iso-8859-1?Q?TDWUA9pwz8Cz6nN5PI06UxHr6OIcpSMXDukDVKnzkRwB9CVp0TDTf/VWMW?=
 =?iso-8859-1?Q?f4JHPGbjCWlqifk93/XjXpNxLyO6hJU34PwU0tn1kLMb5TKoYlycpvmUrj?=
 =?iso-8859-1?Q?2LpYH1cYfJnYn+mjtRnqHF5lWBohZiy8OjukvnNNhW2YBjft8X/weXnKST?=
 =?iso-8859-1?Q?TJnbYqtJGpC/+bO4YzCtWXAm6pCG9MQUlqBZzvBECOP5nN99k4abOGVgMM?=
 =?iso-8859-1?Q?6iuBIfqIMKTt+olWGOq1L0PSKyBRL4UkNN+YLej/6ymEZGJvwZQDFDYhlr?=
 =?iso-8859-1?Q?bkTCtrk4rqLGjB6UFmSo/1eVFNKy2+qg+fTWxqc5MgEfDtkqI1KF7//WvF?=
 =?iso-8859-1?Q?DS9hOwKh4/Epxl38jYM8yOGqc4K5EcQ2C+3zda8YJcdRl4/9MjAd8rF0i3?=
 =?iso-8859-1?Q?JQ4HQnF2Y2yo3NQnrc3vkYGvCd7kFlihlf8Yi8ZmmVclZbd3BFamVVUHA1?=
 =?iso-8859-1?Q?UWtU1trBOZSHKwYtSvOGBWa/ViPNM4PQFiPH0bZmzU+mWdcr+cOdYxKKtU?=
 =?iso-8859-1?Q?OykLGG3jgIV9s=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89334b34-aafc-47aa-4a3d-08dd606ef87d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 07:33:08.8057 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lEffTkmSdFxlt0DeGAi/zgFyhA4FsSzp3g2XxsUtEdV0kIhH/8aHilNJTY8smx9s5JCVkthboIvx+OgBCevA6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940
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
From: Maayan Kashani <mkashani@nvidia.com>=0A=
Sent: Thursday, February 27, 2025 12:45 PM=0A=
To: dev@dpdk.org=0A=
Cc: Maayan Kashani; Dariusz Sosnowski; Raslan Darawsheh; stable@dpdk.org; S=
lava Ovsiienko; Bing Zhao; Ori Kam; Suanming Mou; Matan Azrad; Gregory Etel=
son=0A=
Subject: [PATCH 1/2] net/mlx5: fix non template set VLAN VID=0A=
=0A=
Support set vlan vid in non template on top of HWS.=0A=
Update relevant return errors in the relevant functions to avoid crash.=0A=
Mask the vlan vid action in non template mode=0A=
such that the action template create will use the vid value.=0A=
=0A=
Fixes: 00a0a6b80674 ("net/mlx5: support indirect actions in non-template se=
tup")=0A=
Cc: stable@dpdk.org=0A=
=0A=
Signed-off-by: Maayan Kashani <mkashani@nvidia.com>=0A=
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>=0A=
=0A=
=0A=
series applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
=0A=
