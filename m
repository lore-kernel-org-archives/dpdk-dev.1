Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00413C28B2F
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 07:35:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58043402E1;
	Tue, 11 Mar 2025 08:35:07 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by mails.dpdk.org (Postfix) with ESMTP id 8893540261;
 Tue, 11 Mar 2025 08:35:06 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6ByLdMH+rKXkllQgII9BAyn3IRGMK4NDpaA4g/thwnpsT4Qm8qyyMvDH27EcMapkOx7YFimthOvcpRpZZ+iPAaTlukpfvUwWvStmLjTvHf1n6MAYBjsdSdFelSw9Fs5+wbHnWzpFo2lYuZOm1568Uu9XClPNfydgdVTmsyO84Vjd3aXhpAMNqwJfzD9X2XLB2hsOYqjOHXA4PqM6sr7+ZIglQu5p6rRHYAuXsW9zDtuv6aSeOoa4O0HfSvDihOh2dsmYOCPosoCI0/nwUWRItz32mItA57ZuwUSOoAwAEiEnN0eZL3n4lZrbG9LP5zmlD1+5jCzyfYGMWcMzSFtDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+je2ziT/QkWKNl3CbwFNv+m8C0YpbGHFZG95bnFIBaE=;
 b=onebq2L+2o3X7ltPpCYsLs667PbvrXgFo57Pgw/C8Dz/BCiP59Be9NcvPflE66QKy2R0P+NZPVxzaIvIWO7xy/v5LBOG+UrVmskd1lrDSeS0xcmv4NMVVRx23bWVaY1Jef+RDHfGEe78oUe0O9l0QR9pJYoEGqzGEzUzouHOblYslhgzbjlanlzlL1PfEaRdl3UUidUbGkNk7sj4xipzKw876pM8ED0rFfKgORYYMzevhGv3IuniaptyKxvTXqaZXg8WMDGJ2cNImJQbCwRTMrEdK5Y8JGMET2bOwMqfCgRdfGQM882p+myUiBkbJRr5Sx1avoooHc5dctg/a8SF/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+je2ziT/QkWKNl3CbwFNv+m8C0YpbGHFZG95bnFIBaE=;
 b=D7sDNos06l8pPe43pq0BzdgyU4Z8SYuF56RuuTxQnK579D0/My1p4Y9qZ63zVl+aZeKJSJJQQiw0Gz9OTO7PeS/1AGwoI1Wkf2pjVQ+piJmYCxTrAEAubZcnY3oGUDzo7hTKUznUXd7i0M772ZtWQ04PUIj9Ds0kdQswoFO2iu+LnI2eXMsGnsjy5jSd67bfEy7c+JmqDPPjNV5Z69TATFuXDvUIXteC+US51olQ0Plx6sn1Vlpr42pzj2cvWnUOyjVv+sbxnVZXc2VFG5W2QgeK9yWuON+6g5JyOTRA3ejXnVZ8Xs78zW2sKGpoYgpESM7iwDVpE4q3Chz51HFX6w==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by PH7PR12MB7456.namprd12.prod.outlook.com (2603:10b6:510:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 07:35:03 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 07:35:03 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>, "stable@dpdk.org"
 <stable@dpdk.org>, Slava Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH 1/2] net/mlx5: fix non template flow validation on validate
Thread-Topic: [PATCH 1/2] net/mlx5: fix non template flow validation on
 validate
Thread-Index: AQHbjEEZYnDaoF5QjkapYklSMJAebbNtl5Wz
Date: Tue, 11 Mar 2025 07:35:03 +0000
Message-ID: <CH3PR12MB8460183A90D3454DA4B54F16CFD12@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250303133450.71626-1-mkashani@nvidia.com>
In-Reply-To: <20250303133450.71626-1-mkashani@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|PH7PR12MB7456:EE_
x-ms-office365-filtering-correlation-id: 44c80aff-4428-4fe2-6f4d-08dd606f3d0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?+xkpwwvKM2Rm/+0AGFYGzevWIfzaT5KEhDs2A7xYdA/AzBHvE/lgoggU?=
 =?Windows-1252?Q?YbjBgC/sZHN0MMiKaAqz1lrfmwVF6610+Gh8zFT8fhw6C7+XpKw242Ac?=
 =?Windows-1252?Q?IN1jbUNXT9aHwq0FCV26lhKl6cT3dKx+1OOsgzMK4+mOdf7uvSTaxxhj?=
 =?Windows-1252?Q?5fkht6Sfl4MWmJ7I9iK9miGE1UI0zzRTUicrmOSDzw2S6c75q40qtS9Y?=
 =?Windows-1252?Q?4qcmR1GPu9cpgZdrzMfov+a7z0FUrUJ/QLExjbGKuYgVj933t5F44mco?=
 =?Windows-1252?Q?MTny1Xh0IXEwvrZXoc2qsnII2mZBOX7ZOpav8oxQAxWFcwbzfh+UGdZh?=
 =?Windows-1252?Q?xxPxUeDv0uV4vL8DuNG9lXkGXqJn6s5KHz3BXVfNdQTMZuEdvsJVHJoo?=
 =?Windows-1252?Q?x7F/Yeqnm5VlRlEKXK7pzHBM7T8+uSpWmT+jZMDiTgdNgBv1dZuhMpsr?=
 =?Windows-1252?Q?QEOsoLuOzRQj8pD0gbWyvTyN5KHAVH5Dufp2V/VlxceWK5C0fOBDvzX3?=
 =?Windows-1252?Q?j4qYWeRqqJ9KQtLVJ3nC4RAQ26epjFcQaHVvgYk5F9qGUO/E7nOatGu8?=
 =?Windows-1252?Q?H+ww0oG397OCKqrjLkvbG/cXUyJ92rW6h5kpJjt/cN1EOuFQH4ysB6PG?=
 =?Windows-1252?Q?HQdoB4A6eGUCjQ2nOJVghstSB+7JD0G70Sd/uIJ2cPLwscFx12fJzoas?=
 =?Windows-1252?Q?66jMG12Ok31srK+E5hjXLxluljjVm6pgg+9B9+TeMCtk6e0y9e44MZop?=
 =?Windows-1252?Q?ZBIlL8GED/zFQbZMdy7oRVwj3g1Zy352POnDKg8PlFI82PsOTUy7nLGE?=
 =?Windows-1252?Q?p2dsMR4Ian3VNVwMEP2GwSmmSREn7LeMdT5jYI8JCDdAvXlkD/zSKbs7?=
 =?Windows-1252?Q?odlciavNTWiRQrVGbDu/3hIkToQnyTADUQMhjtm9cW7sph+eAIf+ol3l?=
 =?Windows-1252?Q?X6If4F/Fxhak33btgiN+qEpW8hQl7AfF26wrQkF+wGFK+wQ1wbNkshCD?=
 =?Windows-1252?Q?BNkG/FstZmWPCDBMK/vh7JA/8sPXZNvVQzv6QHUSKpX9c4Kl5EdW+IBw?=
 =?Windows-1252?Q?Zb0pH+0RJV44lOwdB+fOlgoQIzy0Xp+TgHZWiH2tpbp5MEIUQio+hmDs?=
 =?Windows-1252?Q?OxQn87/YInk+bSg5fIq3YOcZRCnIyTHcxu9wfV3fbFdvhtsEElJGjDmx?=
 =?Windows-1252?Q?ypP4zgTOcnBXgyT38x+8fFGrwFq+Xda+rzCRzK8DtvLApqieLXF7f03Z?=
 =?Windows-1252?Q?8ARiDPX5ITI72vLmiJFWFy59STqljPpp+S47WobUXnZTZtTQLEta+g7e?=
 =?Windows-1252?Q?dgzOpSfH5ElS62wa4ehyqfj2kQNFCgMWuuK/8HT/9sf0AMHn0dQII15M?=
 =?Windows-1252?Q?iuub/MCrv8odaGEVwGHjiGPeBNrOrE9hfii01/FcAm8YzoPa/BTA15Tx?=
 =?Windows-1252?Q?aeFutfDw65oyyglFEB/+ZBDwDlwBB8ZeusLCdMUsITGsqUvT1+nNkX9D?=
 =?Windows-1252?Q?o0OVvzexFIE4e422CloGBiq3PWeTr7V01Ml1RD4Xswaf/vFZsZ/VsBzv?=
 =?Windows-1252?Q?CboKJbzoPKjHFR7d?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?2IP+P0Wj135h+B7zwzi2XBx7KGsy+q+KdCw9JTvmmfsUhvlkTBPdZ/KW?=
 =?Windows-1252?Q?GQ8CW2BBHOzYVb8KldH7GS6pkm/3CfI0mB7dA654to4oOdNHTWw6TpyU?=
 =?Windows-1252?Q?YBC3oxnJ4XpTFnXIqaspcGkBVtQM51juLqlguztJqt3K4zeoNgdNLACB?=
 =?Windows-1252?Q?WXOa5WFb9QgysydLc982iT+dSnHeXFwVj4HGiJRqe2OUKk1GTUS5jIW2?=
 =?Windows-1252?Q?ijV5Y/sH5DtMjKVDJ9HdLx0X/e5WjbAYAcOmNnlJWA/v9LdgPs5EITUu?=
 =?Windows-1252?Q?cDZn6j680SiQsNo/iuQGl/jaWfzTPCRjPrc3hLgv1j0MxSXhExhuEax3?=
 =?Windows-1252?Q?8231V4UzRl3MjpEm7v2FSbmd9q9gi1lGiuOlVMfJs77viWMHbZzbLDFn?=
 =?Windows-1252?Q?YYNwUSXOovpSFycLP3e33u+arkhmFx68ySbOvh4YA7hqMcyPz5UztUjC?=
 =?Windows-1252?Q?1yydZC2hMlVE6Nx2xlCn7+0DeS10a/7FvWddJuOO7PsCdaw5q+9eDNca?=
 =?Windows-1252?Q?FoAb4IVasVA4//6uXtnJ77AVmPctHRHSOEduWWveztciKuIQdKI5PRN7?=
 =?Windows-1252?Q?IoLMADC61IbttA+ctSblJHjBxJwVqnlmAc66J6BpoA4NoKw9ikahCte2?=
 =?Windows-1252?Q?oCJLMBSTscIdQ8K5tVYZOxFEZ6Oc6zlEgBPGH15YZBw8XBWTUpA8D7wg?=
 =?Windows-1252?Q?U7QqjLBp+LQlgTbTcnI6xkW4wBAORmz/6kdDmdJfr8JBIc0gJnjXerPK?=
 =?Windows-1252?Q?WnYMcVxOXR61/ZZ3O80JRzEyLwql1sOm1qJReHuBWx4nl3AHKjeeVGZF?=
 =?Windows-1252?Q?kUvGaqN//p6+NpGIGex8F9EH0X9QvySHEsF08BZ2RMlVnKB1rEG4u5zw?=
 =?Windows-1252?Q?Yy8nyRDJ0y3kkBEA6RYBWI9AOQxHFqrgyHaJivnPO0CRRhW17NyaFOvN?=
 =?Windows-1252?Q?AT/oTE3niACqUiHTIXQkWUxj45M2G6NntnGGsyN07h3IrbtTyFgBE477?=
 =?Windows-1252?Q?LLE+tQWAZL+qkvfX6BWtCJDB0WZ6qqLhgpP0X4BUNMn8AvUN6Jy45tAK?=
 =?Windows-1252?Q?KDiH7J8IePnsND8NnISlYmRYAWOHHQNmA5N+QRCYvxPlfRA53IKHMaLn?=
 =?Windows-1252?Q?u3Tv/vng7XuJojGCyxE5Lb5qxnMaWBwHvuw+Qn04UHRq13Jw1q0BjPCd?=
 =?Windows-1252?Q?kjbEmqYcnb57j+YA1c1qqBnfdG7LP2RL25Uob/fFqWNVmfE18c29ZX8c?=
 =?Windows-1252?Q?Tl3GoZ6gVAFH+A0eKntyaMpqJaan0aDL3CIC8O9S3MJ87WlhoSu7nVmE?=
 =?Windows-1252?Q?b1rlf0aQuYTxjUVDGiw4Uzk6o6aCOriJv7g0bus/XBWXq7vaCYJsDObD?=
 =?Windows-1252?Q?PIqgIaRTsU5e3L/oZGyPektW6fq7p2uwvdCCt47YNi63XV6aG4XcVsLf?=
 =?Windows-1252?Q?4O5edHy+/dW/Wo0daJftTzFw7k9PUzQFWUqjG4uE89TXgIAh2qKBgEIQ?=
 =?Windows-1252?Q?fmAk9cl1I8SIVLODi7UipOZhGJhSyEl8Y4LX/Sqb2b6qtAhGR8o7VIEO?=
 =?Windows-1252?Q?PAVqYzsVZi0OKAZ9JcEYykbIqCG4qEklJbBvRkp9EEPswk/BBIMKNU4D?=
 =?Windows-1252?Q?lbiTzCIcUpYRuFtbbOiErhApCMqd9tCatGPL67XsYTEuKxDQD9Ah+5gH?=
 =?Windows-1252?Q?vbCdYtgER9M=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c80aff-4428-4fe2-6f4d-08dd606f3d0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 07:35:03.8260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m2v/iSQdPE2YXP/sw8/1pM+g+Z0FMbiL8ZZdbciqPJtM7vOgkRM3rRl9K8/YYuSXVBa9Y7g8F93UsT+fmUDhUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7456
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
Sent: Monday, March 3, 2025 3:34 PM=0A=
To: dev@dpdk.org=0A=
Cc: Maayan Kashani; Dariusz Sosnowski; Raslan Darawsheh; stable@dpdk.org; S=
lava Ovsiienko; Bing Zhao; Ori Kam; Suanming Mou; Matan Azrad=0A=
Subject: [PATCH 1/2] net/mlx5: fix non template flow validation on validate=
=0A=
=0A=
For non template API on top of HWS,=0A=
it=92s validation function pointed to SWS legacy validation function,=0A=
which does not match HWS restrictions.=0A=
=0A=
Added HWS validation function for non template rules.=0A=
=0A=
Fixes: e38776c36c8a ("net/mlx5: introduce HWS for non-template flow API")=
=0A=
Cc: stable@dpdk.org=0A=
=0A=
Signed-off-by: Maayan Kashani <mkashani@nvidia.com>=0A=
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>=0A=
=0A=
Series applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
