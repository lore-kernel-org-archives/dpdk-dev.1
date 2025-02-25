Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A067FC021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 12:11:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0784B42E7B;
	Tue, 25 Feb 2025 13:11:14 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by mails.dpdk.org (Postfix) with ESMTP id 3347742E79
 for <dev@dpdk.org>; Tue, 25 Feb 2025 13:11:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBCtaVnHda5wySjfE2wdKPKc+A+KjtV38rHIcv4qBNw2YFwCgZ2EfnebmISmY/XNp/vPRM3yN6WcpmPQnJfqsRBVWG7slckGvSQ1eJYZyu0pTJ6gnlGaLuuXFCpG6/0+KRkSHrV/lFs2MZr0Ir8G+4b2mrSqmp9V/iEKQeqtfvyhlwTS4pnUGa1ezDhX67UPzCOnSxEB/+FRd2splJtmpV9/Lg2NdsPx2MtH3TX+PzaxDfFUHwVCb+76ordMiseJBY5c6zf2nY4i15RkIkXHvuzII3D8AMqbJvncphbJmN7ggrBxWNFWrM2tnP31GofK8ftFJMWtS/307kV3EuuoZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFfK1ptMO0Wmw6A82w6NatpwqZZYuWl/6uS8+SutFws=;
 b=NnX2R1AqRkPRAkGwJVds4yT02RkMBprqfDJjH1C4sCOU9oPun3W9rOZi+iov1fYhv3FCLBD2iInpTvTeZMBHsNVrB0pI0gQsuscd93pVXip5vdj2hcXLqhBWZTgfrst3gkKCN1Yy0w8KifEbNpO8RL447Qot833kTueQytLAgqINAJc2bBaM29eyKwWKlWdbcbBYjNJSAZNgiYnEWK4AAkiTQJVSgQ9/eCCOtiTMfSzmeXSScAS2n8mpv+TMEOiHhI0VexCM+HiMM+Le7bZ+7P1OZhpu4hQwlkVbyRyvmcnHU3drX5DjLx10ly0NVCTbs1n1SFwHt47hMYLZ2ewP9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFfK1ptMO0Wmw6A82w6NatpwqZZYuWl/6uS8+SutFws=;
 b=TRZ9kj99reGNtMEe5sKB5xgzZgJLigHgmnIgObduJEhxYVQDM+8neD13d1rZDmGZblqjCIPo/0tTAxYTQS9M2u4WzySNbsEtIf8vfYVEp9sZ7+aIRU/gcJLNhgj876eO90N+4ez/iVInUc7U1WBqEcW4irL2ihHUCT3Zcge+SVcZDbw4YtBHyt7wyZXNxPKO0X3I4GyDVSIoSsdiTMBj/fRKM4Dq0PekNy9b4EymSD+1Z7KnpiLaZebIvb2mYBTFqD9E416J7TDZZaoaAvExDUgJ54SCPx2uOH2YWx2L95yeqlgNVN6y4aJultcZF8mrV+L+702iWF0UvsYAT+Qkxw==
Received: from DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 12:11:11 +0000
Received: from DM4PR12MB8452.namprd12.prod.outlook.com
 ([fe80::b341:6309:cb1f:5b6a]) by DM4PR12MB8452.namprd12.prod.outlook.com
 ([fe80::b341:6309:cb1f:5b6a%5]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 12:11:10 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Ophir Munk <ophirmu@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>,
 "Jiawei(Jonny) Wang" <jiaweiw@nvidia.com>
Subject: RE: [PATCH V1 3/4] net/mlx5: remove unneeded FDB flag on representor
 action
Thread-Topic: [PATCH V1 3/4] net/mlx5: remove unneeded FDB flag on representor
 action
Thread-Index: AQHbh31T0jrhNy9crE6DYy647HdI+rNX7bDg
Date: Tue, 25 Feb 2025 12:11:10 +0000
Message-ID: <DM4PR12MB845252C434B4EE99178E5A5FA4C32@DM4PR12MB8452.namprd12.prod.outlook.com>
References: <20250225120213.2968616-1-ophirmu@nvidia.com>
 <20250225120213.2968616-3-ophirmu@nvidia.com>
In-Reply-To: <20250225120213.2968616-3-ophirmu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB8452:EE_|DM6PR12MB4236:EE_
x-ms-office365-filtering-correlation-id: 3ff329ec-28ae-4ab3-520d-08dd55957e05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?d3FqI4NrHMlR6mRk9AT7xq9KX5Pi8r2hPVygqeEYkAYeAwStGHlYfox/umo8?=
 =?us-ascii?Q?boQNQpC3983e/qbWTBd/aYW9+eO9TKdSep2S1HXGGlzc2jonbu640nPlSoEf?=
 =?us-ascii?Q?5q7Ebm7ikNgQKG63lkzjIIjbMu0wZYjAcSPQu5CIQbFj4nCVuQ5/JVc9Fp8u?=
 =?us-ascii?Q?ihnQIyq96sw2Tp3SdG9wO8P89Xw4i9HM9J+bv+cDzpxwk5U387fXJXx3xI4+?=
 =?us-ascii?Q?5aIsETlvqAgj9aDAC4ZVnfnQGXSu8dDz+QbAKWdkWskJrVhjg+gCckj33FTF?=
 =?us-ascii?Q?JhF6oHGWWXrLSvum4bo9uyoaSa8eMqop70ODftG+IlTPB+Cp29gpK7REcYPL?=
 =?us-ascii?Q?dypIfX+yGSJQd5a/UpX4yTRIK3hMWy/M+b84i/QQRMK1riprWk8mDbNaE1N2?=
 =?us-ascii?Q?N32ipWetgNZIBY6AMwB5oz8AXt4JiRATNsARBY3GSAHJoJohxHvs9lywmV2e?=
 =?us-ascii?Q?mPYz0itHyZtDSEcM06hBG5i73v/pJYvoGJ67HwXqCD1WKgTtfp6z3cCrA1N3?=
 =?us-ascii?Q?//iWiEMA2Si7CisdceY0tCm1I4BzEFtL6iQFJPHmLiLkF4aUqmySOvyhfK4d?=
 =?us-ascii?Q?8ZY+tJjInqlQyixdBK44XmtgjxGoc407EBS2e9cdwDxHyi8f6+QfJQi8p/2s?=
 =?us-ascii?Q?F1SBClkJ762wMyDmw2VQx0uTwuCeGVXfjwAPFmYjwnjPJH2APWb+z6SFHtI+?=
 =?us-ascii?Q?HG0Te7UjhBB3vyUy6XrArFL/vDmHnEsv68weKTlrdl7ME6xfWKiPAsRHCfWG?=
 =?us-ascii?Q?QYkKFpHeohCYqLFBMeTsC0Ql5+OXvMovORTU210CAT4z3muQODJqHJyoCwJl?=
 =?us-ascii?Q?FgkefX8LLTX+/V64i8E9WY0lm259Szj/jSvS4ePfYCie+/fp3vweNUyPxPsS?=
 =?us-ascii?Q?4HzcgJTPBoZvEgBUBOWpG42qAh8jYoL7zZfx1G7tDtEEesTNRxKF2R7wLloV?=
 =?us-ascii?Q?KX0qUUj9R06j7oAXS0VwXod/ewGoVk85DdU6KOxrz2rsmMt1zIueuA3FWSpV?=
 =?us-ascii?Q?ubBlBrBlWRbmsVoas39O+oIWNbwx11sjHb8JJ8AJLrTEJTV81CMOv44WkREi?=
 =?us-ascii?Q?oCDXhEG/JEaMdRdx/j6xqevS57YSISBOJPrN4hEdtlo/Qjyz2JAhnL2wghCA?=
 =?us-ascii?Q?cjS6ggvSIJoQyMpX5+mP8m3egokV3RveVRrjq11ifvY2m3AWkHltS7zweiFl?=
 =?us-ascii?Q?AhjnrdXTfskLjIRTbQK69hSN1vnJodZ72DeMsiJxtJ9Fyik1S16E34bySzio?=
 =?us-ascii?Q?xJ4/TyX5xix3zYX5f8FjXDwN01/f8ZO5YSLbAu0t2/FW7Z3zx+zQ/MegpxDo?=
 =?us-ascii?Q?89pkEUcisf8o8y0zdYl9XEe8809zcTNYd9gdfYVptO1WCda/rwXKv/ijv+po?=
 =?us-ascii?Q?mEIT/ZUtf58H8Opsprlryg4RLj86oYa51teY8f9U5FGHXWzJ+FjRClQVNeDA?=
 =?us-ascii?Q?y/RBKAQbuAbwUjyQ/2zQIp8Q4wbY5eA7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8452.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NW/XQw3jC2h2BnJjJeU7SKv9RQcL2mjIAJLqImCDD2BzCTEU1YMOztiQC/eg?=
 =?us-ascii?Q?Y72LIOSS2FXn6h7b1FtTZ9RS59hov5Uo6xO4n9fZ2Z8Tdb0vQ4/YnFqmAF9L?=
 =?us-ascii?Q?zWSF0W6gkN2sgMncLkzqWpOaestpo38+YC4uCj0L9Zmx0K/4Zug4bed61JDw?=
 =?us-ascii?Q?alFtV6WJ1lypqlex28rQHPLk26uth46zk3UQauFTg/bwmByZhoWaK8+pgWAR?=
 =?us-ascii?Q?eMks4QM4JCJpbw1/Ibh++OaCYrYySJGUAqD010Zi8cMbaTDaOhPV7X+jkUvm?=
 =?us-ascii?Q?qQfcVGmpEfl0CR3ltQhsVTlDR37aqW4HNnroQC9IIPUPQW8+Re7iNRemR+JS?=
 =?us-ascii?Q?hrEtX+bmcRGKNJWD1xTZhxZYiVwWsgiCnyNuvJo46ID9vOeZXc5D7o7IkHr0?=
 =?us-ascii?Q?PF79m/1pUfP29snH5VcQEcnU6g+QVT3AkrAoNiLEmLA7dnNwZyWOj7fwjx1H?=
 =?us-ascii?Q?H/MnQVFmrxJrS+fzUNlm/L6FXNeZgcSQ+5HNUwrSE3OWNkWh1k56jA/McYDR?=
 =?us-ascii?Q?A3/HiIB8Ze0tDYpEIVvT5DuypYtjrWcdqTvbKSPBAcH3q6x5wfM/HyULycwF?=
 =?us-ascii?Q?lKclR4JJducF1AXmyhBg22kWwe7u+pTXwBuzpW6A84irZyh4UvaTHCCB2OD5?=
 =?us-ascii?Q?PAI+HSiUiCw+ZvdA6TjPtKu6L5Lew+ipqOFkx255oTzgRo58NQg7QPuRdWsQ?=
 =?us-ascii?Q?by2v7xYymDcvEZInYEjuGE9H73r1IAqcMFkg4p8tZ9MqWxAOMX/LqYd9KKA5?=
 =?us-ascii?Q?DhGgLpP3KYy5KQZp6FX2lSltuChvHNWsxEyIL3WAZ+Pm/0Bb5jNi72iQOPGX?=
 =?us-ascii?Q?+wNmJ91ER+HqBUFL9K4oo73ZVSE4wBP/13PnZ6o5BsZZeY5Tardcjdf5FPx6?=
 =?us-ascii?Q?ngIqI0bPuUSDjhjxqF/sf/iEhVF//xrNHNiI9/WON4krNM/0Zf2Ex0SGPqhz?=
 =?us-ascii?Q?07D9HuMYNR/ryvioajDdPl6+0V14SffoWDmQ5ErZ9Xic3D2h36DeGhycfk+e?=
 =?us-ascii?Q?iXR1QeGDWJ+0qikPkNmMz6WWo8NVRCb/+Pc8yQ/6DTRcFsqEEOWL8n2KCjjV?=
 =?us-ascii?Q?Iam5G4TuYxoYN6cmNA/W93o0r5GlFa0aJRoJKOm59ebzUdRvaTLc+6taXDw1?=
 =?us-ascii?Q?TmH3AxNsvkPBMVHMKzb5uUMqhjmoZtbvT1rUNqqUbR2WAnioywTBexsWwj24?=
 =?us-ascii?Q?WbzorOwrG8hwmR/jDHJmMLKbVgQZHXgcwLAKf2y6t8iFEDWSB/RA60B/QZFN?=
 =?us-ascii?Q?CQCx/WYXGW/BCh5dNSOT4AviTm8PaveDUPn8CApaUe2v7ckvwe6zZu8zhOld?=
 =?us-ascii?Q?WsvzFZ/0DLlkdklfuwyghSjxjXUgtHge2J6D20rv+NCntyVjvOJfVHhrZinN?=
 =?us-ascii?Q?8viyQYnvpTgRrFLVg/Kq0cnSI6Bge12EKv7ifepZg5ROYf/75znreiGdOpW4?=
 =?us-ascii?Q?bqgsPPlGCKudoCMUjXHXd/Mskz78gDXhwnn+blTvw8e6VUw0glOt0Sg67+4l?=
 =?us-ascii?Q?UDzieY1JOtvAZjytPOQQq4x0MEUjjEV9P7xij7Z58kpfLr5MKW1RViz/7h30?=
 =?us-ascii?Q?FZgOxaJI+S90ej/1HDWy7P+xabSve5Xep2B6aFmc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8452.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff329ec-28ae-4ab3-520d-08dd55957e05
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 12:11:10.9210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j1JQx+pfjk7hxfY44vR2oVh7JlI6dPe4KiGuz9JDgxFZ9YVNSFe/GNdLkuMbYeYUu8rlSjxpW484eq2H8nvWJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236
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
> From: Ophir Munk <ophirmu@nvidia.com>
> Sent: Tuesday, February 25, 2025 13:02
> To: Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan Azrad
> <matan@nvidia.com>
> Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>; Jiawei(Jonny)
> Wang <jiaweiw@nvidia.com>
> Subject: [PATCH V1 3/4] net/mlx5: remove unneeded FDB flag on representor
> action
>=20
> From: Bing Zhao <bingz@nvidia.com>
>=20
> The "send_to_kernel" action is shared and created during the HWS configur=
ation
> stage. By default, the NIC Rx and Tx flags are needed.
>=20
> There is only one case that the FDB* flags are needed when creating the a=
ction,
> the same as other shared actions. Only the transfer proxy port needs the =
FDB*
> flags for shared actions.
>=20
> Removing the unneeded FDB flags will help to save the resources of memory=
 and
> STCs.
>=20
> Fixes: 07836ba156cb ("net/mlx5: fix device checking for send to kernel ac=
tion")
> Cc: jiaweiw@nvidia.com
>=20
> Signed-off-by: Bing Zhao <bingz@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
