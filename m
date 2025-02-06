Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDFFC02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 12:29:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27135402CE;
	Thu,  6 Feb 2025 13:29:01 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
 by mails.dpdk.org (Postfix) with ESMTP id 282EC4026C
 for <dev@dpdk.org>; Thu,  6 Feb 2025 13:28:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkjSkr7tTRFI7ZHlgbrd9FP7mhCOvTx3KCV7twBPxNPgJrxyNGxkqMJs/1NxOQNJKZN+D6EJnulLbfn7/bZig5w4MdiaKtt35YYoXuRlVz5++YPEix0ymsYmggBMDflxoVRJeVfWZpOqY23i/37CIlX3NZXCvkacHtg3uVCME3aEpSYpPu8iyFHr09VcGAUSeZpzMD/ay10FHJkB9IHmZ2tB7wN8lyhREoj/EyIop+cu+dgEYHfRzRZnhyUY4uRQPrdIZti4w7Bwy941TrPwOK6nY5MZQ7m/krwQIiql7Z+8Pq3ck1o6iF9jrXW2f/gqmkqNe+uqoUckDGcddZTGIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdvgZ3jM6+2IFOFFMyC5zMebQCT3oxZtfsq8/smZflI=;
 b=OiMYoO0udbJ7nD9cpv/DmAkhQdkob6mMFl/QADp6RppQ1Jh9bbvdj9llMebeWu5xHRK92t9Ecih90Wx81cvXnp37IxWAXk8Ve7lky7rracjgmzC2WRkuBoNr0VKcbKrYpRxusuHe1EISihFKDkM1mqv9Ff6HSjacn2TY18Eh8ZGzivxhjs4ovKlPpaE3lLIK/Nx21xjwvNuppeKmbKUt9Srhw+oQHahpHv1Sabbii7DARBcrOfPmvALE87FP+5owj6ib5jXFlQQOByv2+EldbXizqZgwBfZQCTyeS6GpE6qAFBKksqS3hzTWoOoyBh1lRtHok4Omc8dowxbNif2HGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdvgZ3jM6+2IFOFFMyC5zMebQCT3oxZtfsq8/smZflI=;
 b=Ml4+K65XvXhJr2UBALwBastu0sexOZ4OlzZlnfWHEqmAt6cLbMZJglPvqAC8W5Lo7TL/Q+ARYmn90Qlkfk/zpDmGlx3z+RkTqa9ioNbA+9dy4YaNEeNx5k59Io6KjUOMvwQCFqGxaEsvGZdX7W1fCTaPNz4yyOhAuaFr2VLko3AKo/kzl0Iqav45zJWv4tmzStY1YhmolaOuew4Qv2zhd58C74bjZWpDrgOeOjsErnPtcTrOFi1T5AwIFO3qGZsgl5CvaDNw+j16SJRC8pnOF4NTT/KoPbCf0wRsO63pV+H9cvn/p5BjyXnKUvh08JokR3GnFNWnHebRq2A/5fcrDw==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Thu, 6 Feb
 2025 12:28:56 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%6]) with mapi id 15.20.8422.012; Thu, 6 Feb 2025
 12:28:56 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>
Subject: Re: [PATCH 0/3] Non template to HWS fixes
Thread-Topic: [PATCH 0/3] Non template to HWS fixes
Thread-Index: AQHbcVnb9a2+igRraU+0quLmzMrDCrM6QprQ
Date: Thu, 6 Feb 2025 12:28:56 +0000
Message-ID: <CH3PR12MB84606F4BB7676B0BBA617013CFF62@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250128075406.175330-1-mkashani@nvidia.com>
In-Reply-To: <20250128075406.175330-1-mkashani@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|PH7PR12MB9127:EE_
x-ms-office365-filtering-correlation-id: 937c81de-5cd2-4aa2-f408-08dd46a9d339
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?gjkzNtC9W5clHCGJ+yrtvO7xnliPjnVVQFdzrntOe7F91+p/EPcqbYneEN?=
 =?iso-8859-1?Q?GH6o/r8G9rtadYJ/WJ5fMJpP4qjqmUT6FGanlQBD3Mnj0BThqtTjEW6URc?=
 =?iso-8859-1?Q?UaK8lzj7Ds0CpwdZj1leflBG9tvGBzFj9XUkTBCQS/cxuz51g3iO9L4Ko0?=
 =?iso-8859-1?Q?9gUA67rJ1XjoMt79TrYcRPY/ylqVhZmxpY4jI7B1+RIZqOLeTFw9zkwfIn?=
 =?iso-8859-1?Q?8JilXhI4qCIqKZaVlL5LuqSllzhRXlfzdZmObpcsVlN1wWuv/6Cs5lJzYM?=
 =?iso-8859-1?Q?YFgg9+vEtEOVeiLnbbJTER4xvhn1KEmTeyLqeWLw0c884WSq0E8kTAWM+Q?=
 =?iso-8859-1?Q?WxuPbxnefD/0DYeyxGqRmOW+WaE3lp1LBWxsblDfd/fsy4HALZBbC5CVV9?=
 =?iso-8859-1?Q?XTj9vAsDXGsjklSp/LRNF9AVRQ6DyEykl433f4SOqtNnpR57DzyjsgO+dY?=
 =?iso-8859-1?Q?wM4p0x1VwKx9M3h/IhkFMIjSpBeLqm6SbyYHKrfglB6w53ONP9oHldo0Fm?=
 =?iso-8859-1?Q?Lgx9DE0HQnmrBhU2Rba7ZQpiIvSTzIrH5Vustf84EZZ5brJH4YAk2zjh97?=
 =?iso-8859-1?Q?1YfpO51t7yiSqOG55WXgfYStJTMS48HfjQzLS4ZkYMJBKW5/0E40iR4paR?=
 =?iso-8859-1?Q?N4Tgv3pFkrTQlI56vDSq/b+Wa6zqByZ7igGOjgk5vDgJy2l0/Nr76sjfdc?=
 =?iso-8859-1?Q?r0l5lB7tDak49uxTFEC+CJfVN50HeQv7LPt5DN63hcMlBUernYmkbxHW9f?=
 =?iso-8859-1?Q?E+DIze8vtbfMcCAMiBFDGNmV16a8JUeAsqXaFl1Jvjf3LrDLzmeezik9mr?=
 =?iso-8859-1?Q?7U5PDs9EXdb2TPQgFyhBly2bgMTgz9Iej7S5MBrGIJH5RP/W7Gt0StC/aw?=
 =?iso-8859-1?Q?ptNWoyw+qqLmsCxo7eZPu2xtqGR1T8BDuOjCnPwkHj1VhIRdSLuk8EW6gm?=
 =?iso-8859-1?Q?FiZh1MYvxdRGbn3qQSamGnfqi7hCC5Jrn/8SNdufwVZHDb4kGqlOQzDVSr?=
 =?iso-8859-1?Q?8I8Df5jUmxp26W79lWSgrDl7/JJ84wK+f7EQN+Hm94twi949RhzA4OAk3X?=
 =?iso-8859-1?Q?cCODP35NDvcYFKfoKjVYXJ2pnSpRA7TJ2m74Djp/Ckkwv7LM1g7SuIgz7l?=
 =?iso-8859-1?Q?ruAkm+KC/NbKFirWxCqlH5TXhUf2oTMEaczlQgyp9Me/cJEfaJXeUGvjT/?=
 =?iso-8859-1?Q?50a5VROJqRD/UGW95MTmkzqSnzj9fL3RzT+T59tGG3l6iZhef+0K6MHIRz?=
 =?iso-8859-1?Q?GRYrhTNtjvplnB56rPoygWY2uN2KcXib/Yv4rjhHZfbIgTSCoVKZ0tlL7l?=
 =?iso-8859-1?Q?IM+jQqC20viA0TVmMSRZJgKuJ5QhUBMGP7Lsst7d0oCqsZSCXYwygxmyPy?=
 =?iso-8859-1?Q?p22/4woOemeHrL752VmaenJzy+ZqFqoiTuWiA8VPPSOJ/xYIf04nhJ68FA?=
 =?iso-8859-1?Q?XLsorZozeHHOS3vDqfCzFjs0Rbq3SVzaEMB4dLJik+X5oyri1ByKy/39Jh?=
 =?iso-8859-1?Q?vOKdhNWVpTWQdoO/tOzyVY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3Fc+vMWHzhIRybXUTJp3Iuku0UAG6gD87OHSN9Rr2tQN1dwoOXNRfrngGj?=
 =?iso-8859-1?Q?M/WSmTzXjiYJ+lWhkdSOuF0W8rA3/pQd5tv0Ndr6hUn9oe25XPLFmizD7K?=
 =?iso-8859-1?Q?PZxJ5TrjKl9+OI3TlJVxyxHUyslQ2M0Jr79ibkL1tbTPXGFrjt0GH0oYdO?=
 =?iso-8859-1?Q?H3nEfM/JcMvFeuvAtbKCTFuDCBfnTYFTgk+iK7133uGl14LnyrfcaoKASf?=
 =?iso-8859-1?Q?7Ds4fQu51yC/NHugr3LyMUIse3ObbqexAk+CiAv69BwPLHH+QOap0hLoia?=
 =?iso-8859-1?Q?lyLRzAmSOJoNzIbJknLxyVlCUnJyusXXao+VmJPIgG0o8Nd03ZPlaABhtp?=
 =?iso-8859-1?Q?0vY/w9az0B3wXLtPQAgyWyW8IvtARrLTHBRu/FDE3aBdY0Q3rOtVF3aVpY?=
 =?iso-8859-1?Q?onidu9tkxFJeFc5mIAYBPjjaOSflTi3HTm5XrPFhOLCXCjEui7U7G89I6i?=
 =?iso-8859-1?Q?9xqYbGGYbhWXDmwBnqq8k8qIzxdxYTrzXjjEvDOh0wheUXSW2VPPxQS2BM?=
 =?iso-8859-1?Q?7zdELZ8A8kcnSL3MTDaiM9hqMODBdaSiQL0Bjf2b6h1lImr0NUHWvpP4R/?=
 =?iso-8859-1?Q?PtEsLCiD6iCMx0aHObVre5tNs3vZAJy+tzSn0tB++W73xUBh4EF7Enb2Di?=
 =?iso-8859-1?Q?vNuptdiqPY7WLyVAKeLol3xNMyQ4Ce2xd/kd0LmIE3IT2Uq2C8cSG+Pok7?=
 =?iso-8859-1?Q?MvbyyzaPqg5G0di7XyJ6sJY7YLTUgIKszIlx/GCsavrlXWNmRS4pp1zR3M?=
 =?iso-8859-1?Q?ic2Bqj/otkBZ+INQXk9ZFAlLgtU3eHnqEauhAFm2f+HtUEM31zabl71J4B?=
 =?iso-8859-1?Q?p6Dvs4F9SbtfHOHrSh7NpbF9X6VjUdrOZdepLGcnMtk5l+XpZIvnFN0wO4?=
 =?iso-8859-1?Q?8n+q8qy7rrGzP5WjF+uQy31usRO66NNBAByKvkJOlpI8vlVeBTqNxkdUnb?=
 =?iso-8859-1?Q?PIWZPMy/slycX3e04z/vSlo4o5Ao8maHxlOj0zb/c2JNiGIxcDSBhEWx8c?=
 =?iso-8859-1?Q?b/teWIF2r6F+Sk9OaBiqUU6h/PUm752zB3rtcDWOUTMmXhkg0g1oqGLLE5?=
 =?iso-8859-1?Q?3r0YudAjFbooIujHhfBnI1ucfJjFN9AsEXVrdc0Qji41w0qTdF3OQoFzDe?=
 =?iso-8859-1?Q?0mWKNVij6eQioYa2AL7btKClBKy5NI3iXIZvb6vkNVqhLByKaPk2Tonb/O?=
 =?iso-8859-1?Q?WotwzmY2ZOZH5OhXSOyzkFJNyS9YqAnZsyjXp/osq1OZe9ziXzDy5ZjmUX?=
 =?iso-8859-1?Q?6K0s0opDw+HmocEJJ7A4k66K9qjbtdnH47m5VAr8j/joDWFVQaAxC93CMn?=
 =?iso-8859-1?Q?T398wLZssnRPoBGg1h3uwrWyFC60IBHEFjvmFcQe6XkpecHOHwgO0HlaOc?=
 =?iso-8859-1?Q?RAHIe8Krl0v+gp5wVhM9dZz4Jm/bLOcCVnxIPzKV0tnpSrmgFfHuFlJUMP?=
 =?iso-8859-1?Q?nOZOSXRXynpq4iV3zh6SOaQr8jaJxaJxb2u5ejGRxjix+KV9fmNXyiD1s0?=
 =?iso-8859-1?Q?kMaTI6mR0xhUGZTtS2XrLKAjVfY2qTuR7nOyxJb8IKboH8beWqubAJtiam?=
 =?iso-8859-1?Q?dKvxMmBkva/3f4J/LfRcAh0mSOb6Pwct5M8n3Lly7bG3vK04WAa1xKctTE?=
 =?iso-8859-1?Q?rQwgz3wik76dZav28s1aYmnANYPc97X3kj?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 937c81de-5cd2-4aa2-f408-08dd46a9d339
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 12:28:56.3572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: asJqrg24SK5M69ABYBhv9Gef30togsSG6wE7NTUNBgPHh0IjmzPuInOg9wbJfDwHCpKmqNpdiNtMYTBsphIm8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127
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
Sent: Tuesday, January 28, 2025 9:54 AM=0A=
To: dev@dpdk.org=0A=
Cc: Maayan Kashani; Dariusz Sosnowski; Raslan Darawsheh=0A=
Subject: [PATCH 0/3] Non template to HWS fixes=0A=
=0A=
Few fixes for non template mode on top of HWS.=0A=
=0A=
Maayan Kashani (3):=0A=
  net/mlx5: fix limitation of actions per rule=0A=
  net/mlx5: fix crash in non template metadata split=0A=
  net/mlx5: fix flow flush for non-template flows=0A=
=0A=
 drivers/net/mlx5/mlx5_flow.c      |  1 -=0A=
 drivers/net/mlx5/mlx5_flow.h      |  2 +-=0A=
 drivers/net/mlx5/mlx5_flow_hw.c   |  3 ---=0A=
 drivers/net/mlx5/mlx5_nta_split.c | 28 +++++++++++++++-------------=0A=
 4 files changed, 16 insertions(+), 18 deletions(-)=0A=
=0A=
--=0A=
2.21.0=0A=
=0A=
Series applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
=0A=
________________________________________=0A=
