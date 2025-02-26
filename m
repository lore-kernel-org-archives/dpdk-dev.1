Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650E2C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 11:03:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD68C40648;
	Wed, 26 Feb 2025 12:03:57 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by mails.dpdk.org (Postfix) with ESMTP id 80BB34027C;
 Wed, 26 Feb 2025 12:03:56 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g86eiKxArDs+OlxMCT2vDt8D5QIBsLkVHCinumrmKPeDN+XOYDZJEpvp1v3BwPo8BEDtTrO8xT1PdSS3rIeV7LKyngJlS7uwWObuPsSKPRUM0OUrwzOTSi8UwIR7gIyzZQzsvIc45JpiReJRJDfLK2ShIGLzsrxUum3Y1H4iobTXrdc7gXf50X6OwUwAdvMOHw0+/fH3kDvTXoHrDFvoMSZ52qczmmbBzKS7li4rp+7zhuleT375PaFPf3bAhXQKA4Z6WAscidzvrMJyZJN7X0KbxczZtYY2WJJZ2J7asa1o/lWwyIqlpGZVeKLXzMeDEfgvKs5tiYS9g2Ezvin+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtfhEUiMkhlvfO1Bnzy0FPCSYmzG/uFSwAtsoBbnlyg=;
 b=dEFEtGfLYAnxu0V/Chp6YYuRUz2l4n7S77FljltGSotDfrLMkcOYBNR/boKa3sVuNkhcIqBSE1gbYJPQy0qSUCzqMl6WyomxQenQBifQzD93Gzok/RRUD6YqxtgJS+qLg3wsh1FoIDr329Pj7xxXN/5dEMRg1953Y1M2eIdecH3TSPzrLjNiYCDRr+L1m5EBnWjQe0U5Tg1SZMthlscpTXkoQ/OgIcSW3bTM5gpTjDFl4FCNBnSUnTMbDXgWrDNKshCowa8PFjiLIgCiVb5b2qfVB0cBK7oSTuzPXNT86tArax0wTywocj3JkZf/76RXHrAj25050n5Ky1mV32Rzyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtfhEUiMkhlvfO1Bnzy0FPCSYmzG/uFSwAtsoBbnlyg=;
 b=o1Rdwo9Lt5/ZxlMwsd1bqJHdCXi6hKQ1Gol3NLFS9mZMAUMgXnyNRA2+AJ4Rh7IvGKP5RGj/HC3lUW8Rawn+dk5gCOAlXkFrCGAyKvgM7IrEDifjJi2xPF4rNW01MOzhjvGfZdIrj8PuCanZgIr6dlajd/6303jjFOROOKW+AQgChbhg2v8uDb+Hhp1RsDLFhYbq+5kHdi4WQ/342c0Cf/achZJdzFJ52EDUIZQ9RpNm9piz7uwI7IolwC8uxCPecpC6bINc0S1Sngp67UePAklmDlfF7DUF9OoNTpktNbn7JBo3aacXTR/3frwSEeJMNOy6X0gUB5GyUVagfwdiOw==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by SJ2PR12MB8135.namprd12.prod.outlook.com (2603:10b6:a03:4f3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 11:03:53 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 11:03:53 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>, "stable@dpdk.org"
 <stable@dpdk.org>, Slava Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Michael Baum
 <michaelba@nvidia.com>
Subject: Re: [PATCH 1/2] doc: fix MPLS limitations under HWS
Thread-Topic: [PATCH 1/2] doc: fix MPLS limitations under HWS
Thread-Index: AQHbiCTqwgtkhRcSZEysWzJsbgzZobNZa9VQ
Date: Wed, 26 Feb 2025 11:03:53 +0000
Message-ID: <CH3PR12MB84607332780B1B4A7057C00DCFC22@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250226080258.30127-1-mkashani@nvidia.com>
In-Reply-To: <20250226080258.30127-1-mkashani@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|SJ2PR12MB8135:EE_
x-ms-office365-filtering-correlation-id: 1f24a2e3-6aaf-44dd-b820-08dd56554212
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?EkRLko0V+SMZdlnX+NH2DpopAC3Hyxo7dP06YkbyURqYGqnHGDv6qHVARn?=
 =?iso-8859-1?Q?zXyKgSnhPAXpoetW6v/pW9xHsSWCCm3P1vGHAnq52zr3jrb4ozMlPSPUYn?=
 =?iso-8859-1?Q?XYdn6eyBpcd18TStrL4ax+GQxN9+86fmrJJNj68+ZGI/WYJo4xiUXhOxef?=
 =?iso-8859-1?Q?PibfOdJBLBfKDTWqZAA4iev2ixYAsZj45IHd2sHwVrLh4HBamH3ZNTVmBU?=
 =?iso-8859-1?Q?WI7HnpzJIy8xpn+iByDrR1OYbLE3e8rk+ukxSq14ODTYe8rA8gWPMocSsD?=
 =?iso-8859-1?Q?BtUhwZmDltk6IE+6DIGT4V0eDkBzrgGuVMz7v2lnIToJXasFc63LoB9UyT?=
 =?iso-8859-1?Q?UlZniO02D5FveZ++kgS0dEp5xdNvd9G0cRDSrNupp3dzEVFEMxh8n7UTtG?=
 =?iso-8859-1?Q?VBUsLtFRjxbySGyIjFBhQE5F0jhX7otI8bCKf9FI5rxXbVI8+WZGc7Zl5l?=
 =?iso-8859-1?Q?nsO1UF/VUnL0Ra7X+3V6L6F88fnlnfr2eMy1ktFDx/HfogHxRwPoni7Kgr?=
 =?iso-8859-1?Q?aXhIw6CCHOo0pk/KZLgR7KrD4h3Pn2IrMLQ6GF+V3Qub2cVVgGxmPYVnqV?=
 =?iso-8859-1?Q?tb3JsB3pbU0I4l57W1Et/dIqceLQPqEl4z2i85vgvx+9qojcDYGIQk0nRE?=
 =?iso-8859-1?Q?N0eVQUL9D2a34N1Utve6+WEAAFQQBi2u6j5WYr1Ot1ZqdbkPPtQRVkHmk8?=
 =?iso-8859-1?Q?tCyUhRvs7xsvpSGd7lkZF3fJ8OVwyV3iKxeGn3jKZUm526S/ZGXjghG3F5?=
 =?iso-8859-1?Q?v2ne9s1OJ/xlx8crYbNewhrkx2FGHMM9e6yII3JuSrcF4W84xtuzKarEo8?=
 =?iso-8859-1?Q?gXO2BDI9eZ9D6cZ5+Mx/wxm/lR8dUUr9gzZK9DQV56/2UoU+WF47cTd8S0?=
 =?iso-8859-1?Q?fxXm6XlYiU1ZRumd855BQb/VgVX918ZW+Z6Am0yr7c4PU45MIsNqvhWIfN?=
 =?iso-8859-1?Q?R7oMs03sSNsspjcwmoo6BJ5Y2E/JnaQmZfSZ3rgUQJ/pnAYwiRYUqERMVa?=
 =?iso-8859-1?Q?eanzzN6qc57eFSzsJlk+dLO25qkTAtRVjJJb7vUJrTJv1M9CpaU10qfdf8?=
 =?iso-8859-1?Q?ZrNr8W1ycozEQWeDJV5SrnXiyc/1Etj/CnAbJJ7ctCCotMWxG/h1q2nLLj?=
 =?iso-8859-1?Q?lx7Zn+9CGswD5dCg/hlY8pod4mfZPbbC8vbnknMiSKaiUpDLMVmPUOT3BC?=
 =?iso-8859-1?Q?jsAmCENkO1PwuUGan+koTwKqHjsMuhDFKi0eR9vDSiQJqbTkXSrcUgbEPJ?=
 =?iso-8859-1?Q?xiRL8dY17ev2fqV57xibyeprOQbtQX+kkrUW21izVkOJzmkLuDsP54qSFt?=
 =?iso-8859-1?Q?le6tZCvczsxX7b+8Yijfrn/mJAzd58uIRshwXlgNAJ45iyjB4K5jR8guyG?=
 =?iso-8859-1?Q?8EWDalIqLF85LWnm96hn8pXQAhAk180PIZnuorMQQOB6xPYFenzFAUcDJM?=
 =?iso-8859-1?Q?YK4vPAshfFE1DnaWM4UpXMIJi/qK3z5+3qOX8ChppEBY/2PUOzb9tPrF//?=
 =?iso-8859-1?Q?K5SBQjgiV0JdsOEb0E8Ubn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+reGbidxh4PDW51x2hur9U93N+d0dfxbXxUByTpW+o1TUpaSQdlh5j0blS?=
 =?iso-8859-1?Q?GHY9UiqDZyaXo30w3MIdSz40v3KqpZZZvlkyMY9XTi22GIBXjfCskssjB3?=
 =?iso-8859-1?Q?wVPptaPmYhlntrYYSIdYtAU3bhCT/pCNTj4oqEMQxRRxVOi1YW5a/BX/YD?=
 =?iso-8859-1?Q?hgAEgpIHVy9YBdVGCu6R2fskynaasvVtNhQnjQnwff4CAPPQNjwYFxRHCw?=
 =?iso-8859-1?Q?dZnm7co5jeJleKxtjZBXZCr1s0GDsQnX0/DDwM6LPsaKrIqei568tFkQmT?=
 =?iso-8859-1?Q?EwW9KHm7X2SQ0aYe7mV7wNWJ/t351JTkEbhioFgN4v/+zdVA8mGCoXYEl1?=
 =?iso-8859-1?Q?TpYkAVugQCcnqD4JYc/N6uEXnJNkhj8VbnbFVKzY4XE6Crpf2TWF8qZhYB?=
 =?iso-8859-1?Q?4EW9brHW8TcEMtepmBjzY7bx7uDo2FXcxUYhb9j5jK+wTN0l7VkeMR/4hL?=
 =?iso-8859-1?Q?WJo3eUrigJjl3FjqZhH9omcphnC21sG9ftVgwq0TSkQDcet+OskNy+Us0h?=
 =?iso-8859-1?Q?Nq3dVXCbvaLey6JHOit6fycYyslUo5nj22XIBiknLjIRmFSylbtqYI1fwX?=
 =?iso-8859-1?Q?9y2HjxQ7qDMmH+02D+oHhhMFzHXVaeNo6hxeLZYuqaXxMf52bu3jiXD7f8?=
 =?iso-8859-1?Q?aRW84HpylkaJ3nOB1cCn2h2NB+aRxWkxwNpMgpHeP4oIAhIAxnVYIbiGmN?=
 =?iso-8859-1?Q?fMGzKqiQV8H9s47oe3remWWkSdqSt/CzDBdwcz0ecsykSu/2S/B/6i8tof?=
 =?iso-8859-1?Q?ekghbZLKozB0ulMHw3y2UALrH5B4lvB3sJ+53/HxtCBfuIs9gU0ZkUb80V?=
 =?iso-8859-1?Q?gvO6zUSl43xO1hNZtCw7QG3Lhb3lHCgyAS7Dbi2k0B0UR7d7PiDJfqUXSO?=
 =?iso-8859-1?Q?iMLp0mb7tiGRoHoLmKtTFI8FsO9zEK6JlAXhN+eMJDWmhjogXHQGE7zSbf?=
 =?iso-8859-1?Q?yQyMs+L+rzqMNTqACr/Mlj1X9YHhl4jlV9hOczvVB2/ZxD2et9BkXfXfNo?=
 =?iso-8859-1?Q?GvgJ0HtwL9ObyjfBbNURPpoeL9VVziAR/MMc22xBNWMtPf7OgcJoz49+Mi?=
 =?iso-8859-1?Q?9Eg0DtxAw5mrvfgwonWLhlUjX61FoVGMFA5TKNwagCWhZ0L31occ/OHFh/?=
 =?iso-8859-1?Q?egx6NP5R1AhyRkSU/rSU/hbSl6VXdyYOW0xFG994Hei/tMBOttL1+LCevM?=
 =?iso-8859-1?Q?Avo7DthJj2n6u4Xhgusx3HcMs3+SRsBf1mAcnGnWRZ5Z6da/fhr9x/orph?=
 =?iso-8859-1?Q?XB4RwLM+SQOh4zYXrR0P5htOhjz4abjIdR65fllIUGMx+d52SZhGIgVUfy?=
 =?iso-8859-1?Q?KL2P7M9ZA3gYedGb1Zmlz1mRkbBrdlKts0us76VH1gwBIEk7vW1wzSosEe?=
 =?iso-8859-1?Q?g9dIPRJd3qQ9hqJNPAviqt1G+KG+HDPOTiSGtDNds587UVWkfVtzrLEAoG?=
 =?iso-8859-1?Q?52bMgQl5bkfk2S8qO7uAWmmhUn+DaYLaCZAEp4ika8siikavTr2/fSC6ss?=
 =?iso-8859-1?Q?M7E1GEadhOzTPbezVSEIi3m9hKxXEN3vPjg14U61UgZ8p+ER5exqyLL84C?=
 =?iso-8859-1?Q?3UkxhzqsEklR11U11tSyI56MeunIqF/19aWXRo1XHKoWopIwUdcHZvlQ+i?=
 =?iso-8859-1?Q?SRNORTMvifcMU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f24a2e3-6aaf-44dd-b820-08dd56554212
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 11:03:53.6893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AT9IoCMGqUe7vf9wpGiESrBmm9KhaqWtoP7SVxNvgEZFN8QES7bteCErqrJNK5/3vw0sdUzMELaV5u+fX+yAdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8135
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
Sent: Wednesday, February 26, 2025 10:02 AM=0A=
To: dev@dpdk.org=0A=
Cc: Maayan Kashani; Dariusz Sosnowski; Raslan Darawsheh; stable@dpdk.org; S=
lava Ovsiienko; Bing Zhao; Ori Kam; Suanming Mou; Matan Azrad; Michael Baum=
=0A=
Subject: [PATCH 1/2] doc: fix MPLS limitations under HWS=0A=
=0A=
Update missing limitations.=0A=
=0A=
Fixes: 1e2a51f545b6 ("net/mlx5: support MPLS tunnel with HWS")=0A=
Cc: stable@dpdk.org=0A=
=0A=
Signed-off-by: Maayan Kashani <mkashani@nvidia.com>=0A=
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>=0A=
=0A=
series squashed and applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
=0A=
