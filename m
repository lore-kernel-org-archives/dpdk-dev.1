Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4B0C021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 12:10:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 886FB427C5;
	Tue, 25 Feb 2025 13:10:45 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by mails.dpdk.org (Postfix) with ESMTP id 9B8CD41101
 for <dev@dpdk.org>; Tue, 25 Feb 2025 13:10:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ur9iWiUPEkSJjcxYBWLrszhIqbmTNr4YTY9d/7oJX2C7THI3M7fqFF48Qm1UdKS1fazKFggFxTzTL673lmV/srCwM1mTkUKUo9if0gfr0Ix4ZF9b1Zvr7zoYtWBRmaDu30rtU9GvyojKfOCnG8Dh30/4IypGYzRRpzAQb025F8jAUsmHAE0tHrnwWv0cOfnXAysxUWEC4U0JhUS0yfRq8ndZcmb2WAREEB+QAcARutak5XtCI5XTYRaui/6aDifr2sYAWnYhao+48gS+ydIe+kRn1QTZMnTglIS/ku6Xh4GTVrk7wjjNHnHSvwZiwg1n8osSDFroAObUiKG8LYyymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8LCPEitX5ZgfLk2JQcWiR6XbT1RbqlDYv8SjG6T1jg=;
 b=orwxLdDmiUoJyJKyBJz7f+tXs7U6xwr2hBDjeEIi7suKJXDmEEzkXsLvoKuxhhXtvZ05FWmwn0UbUNbuONAunNhaP/ecOGAXH6kOf33C5aeDl38xmToeoqWU/PYJ9uLO7BjnTf5SG6kYbgvjzHzqIVM86yA9jzTYpjW3xb8rAKMhKWB3oF7Yd9u1YPYWhjuipvrKKitLtBhXdzemxB7wNQ96NFqErbsitO/RsozeqLoWZHkMajESb+SMLMWT72IvjQnrQun8K6ltsG22IclhBcRjERn168blGahy2W9qhVAVVA2pHyYbcENw/SoF+Wn6A2uEAGJTtVapfKCaWMeHUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8LCPEitX5ZgfLk2JQcWiR6XbT1RbqlDYv8SjG6T1jg=;
 b=Qa5atZlG4J3FHXe3D22z9lfIwFV13ONCqNDlOhjQWjfGu47ddUSn23kvRtRXqaIK+tu6bzhoJmM/u/kbr4QtW++TEe+ia5ESeMlfIYnAGdPCVG8dDD9A7oQ8QbGhHubE05HwLI8rglLwGH7h8ROhdTyBR8uyHFSEdZOEVPw+Zl5lFIqJX81a9dab6jCnhYlBqGGEIcZXIisSIzyHt1AKEvxKZnoFWiMHN+ZzgxxZ80kijYBeCvJvqz+NIlPbkmg4Ddld7BdgwNLT0k2et5ivpxeo27FAaUhLjQCWDpgaP77zyM5835x1+AQvyiOUv/xtEzzxhlLwT4nH/ggoTJLV7A==
Received: from DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18)
 by CH3PR12MB8210.namprd12.prod.outlook.com (2603:10b6:610:129::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 12:10:40 +0000
Received: from DM4PR12MB8452.namprd12.prod.outlook.com
 ([fe80::b341:6309:cb1f:5b6a]) by DM4PR12MB8452.namprd12.prod.outlook.com
 ([fe80::b341:6309:cb1f:5b6a%5]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 12:10:39 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Ophir Munk <ophirmu@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: RE: [PATCH V1 1/4] common/mlx5: support FDB unified capability query
Thread-Topic: [PATCH V1 1/4] common/mlx5: support FDB unified capability query
Thread-Index: AQHbh31LqtFxZFUwek2PDyDra9vXdbNX7XhQ
Date: Tue, 25 Feb 2025 12:10:39 +0000
Message-ID: <DM4PR12MB84524BED8D748F24D4FB357BA4C32@DM4PR12MB8452.namprd12.prod.outlook.com>
References: <20250225120213.2968616-1-ophirmu@nvidia.com>
In-Reply-To: <20250225120213.2968616-1-ophirmu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB8452:EE_|CH3PR12MB8210:EE_
x-ms-office365-filtering-correlation-id: a633300b-f8ee-448c-f5cf-08dd55956b85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?CKKxvVeGVoEU3iXbggSOfh34V4syZ2C4dSucMXGYo8VUlENtgk3vQsahSbOr?=
 =?us-ascii?Q?mMBjtZCNDaaogS41fB0IOraLiyF7sUz6NitxAuE5f5gYKiEsPZW2a+8T6Qqn?=
 =?us-ascii?Q?dHzvzJcKVUolkfAB1tF8C7dDfzLH4q9f7479rvRPmkrjvqMXuAhJil6clAFa?=
 =?us-ascii?Q?w7w9Eb5y221wTgmP8y41eV6Su1zsmk6KglFZMvI7OU4WWO1CGA71V/UagfZw?=
 =?us-ascii?Q?0uEDBq9IJGxE70FjmFcd2SWcJrszmS/npawF+R5zIQDYf8tKYxOKrSpkjdNg?=
 =?us-ascii?Q?YujJIEjPawj7JP566ORwbFU0+BF+lpQq2sTZJ1v4yN/kI0P2ijbNBqvFlS+X?=
 =?us-ascii?Q?HwA1jwc9SygzkoME03r6+BW3YpbJ9yXYQvjVuL9BBl8tCJdfXJxRV+GsRyyv?=
 =?us-ascii?Q?eb+W/p0tZpvjI1fVL+xSxXd5BLPEsidIV7ab+ZzB4uLOlpvnBLSU7Te3/GIH?=
 =?us-ascii?Q?9KpF+ls3z03GEroCY0NXviYECIMYOy0lX++bQg0zk3s8fmyIZjTQQq0z6Mcd?=
 =?us-ascii?Q?PrwEA0+Ia1AconlZOmLbNdzjwuRx04u5/SxkUD1H3Vpr5VxFAqM6+zvl+RaA?=
 =?us-ascii?Q?Mdw58zniGV9kBuQe2sOfgW55LJqAmk4QCGCM91EztFlN3h/yY48xZuE7j2EO?=
 =?us-ascii?Q?Z26drWxItnkKqAO/dilcod1Ybh8GaR6Yxqv9MRMFRPb+XMODp82niSOlp5/u?=
 =?us-ascii?Q?rMYNYrDumHowznSYp4lu+zZfCeswErQApRSG1tQLqT/Je3hV/K40hdZNOxCU?=
 =?us-ascii?Q?p30Y4M2FQu3A6NpwdeCTbsBUiqq6eIqe+7fSK1rhY4OVzOdAMxdmbi8RBwS4?=
 =?us-ascii?Q?GUNh++2nXRXf1E1uU86QxPo0kKiYAtkTCgA5t7vbU+2weTiaCXA3/KKC10z2?=
 =?us-ascii?Q?Yue8udyvN0+OuiTVn8IrRLCWd0JuwUI4ROHEQnMQa4ohASVPV7ZQQv95S0oI?=
 =?us-ascii?Q?N6eiZvFuMWzGr+Z2ROvWB9Zj+RLOIMownSob4zsKYYmED9VVmdEV6R1d7cpk?=
 =?us-ascii?Q?m3+s+VAOwLD9lIj2rAnkKILpMMMyyTd356GKkYXRbutVx3vrllRAFrj6DZXz?=
 =?us-ascii?Q?nHg9ukpxybUiCN2huhsgkYyDqgYVfxsCBl/bWY0ZD0V2AlWYCx4XnBNt4pvo?=
 =?us-ascii?Q?3lnLxoGB1T5DzBTS8+kGVtyPVOOqfnElr9qqrOpDnRXYUlybLF/cp1f1tQF/?=
 =?us-ascii?Q?nUMuzgtDsQ7SE+D0sCPGFaDn4FCxaYpRW9/lqDG3TciQzHRXR6feHYX8I5y1?=
 =?us-ascii?Q?aYxn4/OZpfJghrWZxisOEykhtvpuXP9mmUj6dyY2Y0ZMPrCgIaSVKnD0u5fA?=
 =?us-ascii?Q?I5MW5nzLmKvRWNFx3stcN74xAKX99pMorl9PSarayNWtFmfXXnUiGK43MahK?=
 =?us-ascii?Q?b9iWDGg1tGNrXCOZmn0xenLomojr3YcmfeSRrYLvczXfQTqsMEbJXwm3xctf?=
 =?us-ascii?Q?kYJPlpaYaGOWdL+zBZDEKIEd/hu0sbg/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8452.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Si8WQ55pyTXp175JwwTiXxGjIOZWFWu36Vx0JbGvCKmgGHzxds3A8eb3vpot?=
 =?us-ascii?Q?80ApC9fivoH5J7dM7ZrWzlmS+8/eAsmVGbVlHbZOXVtbmdilOyvwz9Zv/vgJ?=
 =?us-ascii?Q?NeG1y7wlRG+OKDVloGPAw0Owh+aFM6b6WRyw/0my0RlMI1hoGn3x6/opD9RF?=
 =?us-ascii?Q?8pZC3GV77ag4psZHTK4h0LGmnJd5MlrV4uGyTwGzt1F+6aL/FCz9ZmU90rpH?=
 =?us-ascii?Q?vw0jYJ4wL0Iqt/cD5/u4mWSaVvTy2qHETQjfxdJIAb5zMibl/Vr/Q38nM6N/?=
 =?us-ascii?Q?ZFLXbjQM/vDh61LiMHz5CH5/Qz7sbUY5X5Yu7Y6IK4n1U+ne2JrmM2FUuXXd?=
 =?us-ascii?Q?g0dJudIEF2sxo5+nhL5FNxBYujgzLAL2XAhjFjmmnlQRreDY8f8GSUdEg5qY?=
 =?us-ascii?Q?wIhfCsT/uvvKuoL7JpMzwEWXotvbvVQzkoiARzlOVcoyp1eVJ/o4V4LsSxhB?=
 =?us-ascii?Q?lYLK1EALPUh6uZHE8DENXz3adAIKJfLtDtYwLrgvyh5lrJFXN0ZaWlhGHlew?=
 =?us-ascii?Q?K+wH8qmwf2HGbYV0My9vUgV/p6F1enFLHg2kFVH1VFAELQUTq9CWYnGI0dKm?=
 =?us-ascii?Q?CMaLhos5CZc8v9nJw0HWrM7Wlg74I5WSeRBlWKo+4jC5ot34c91yi6CXauK7?=
 =?us-ascii?Q?WSprsqtSIdHPDwOyKcJf/wQBUVI0n8BxjtgTPtJ8J3OuY7FvOszTVHMQ4a9m?=
 =?us-ascii?Q?dbsvIJOwFkqVW88aCNBwSp5p42zaW3/CjCDH7jzR0bkjzO4jkYkZbwIpcEyI?=
 =?us-ascii?Q?6lIC0HBL1q8lWiJTMkw3eIDpZ4mhrmN3fx3Jg5x1moluC4K3Ej/cl4JgdeVd?=
 =?us-ascii?Q?KGZhmNy3uV+pMjwEEIXO7sCGOjjAd6GyCaq93iQ23fBUiQuWeR1X0zXn90wW?=
 =?us-ascii?Q?mVcOS1rxfIp65JRaNqTmoWaBj/WFtQURHx8K1Ums32K0Okk+XhOtawzrzQfe?=
 =?us-ascii?Q?ZYh3Cujipf3EkszJT3gMj1S3oP3I5sPbTs68IMOGzeMJLdzkPD8sy7JfVcAj?=
 =?us-ascii?Q?3YwAH9ARfuLm0HCIAEzecRfzXxoeuSKgO0Y8Oh/0QE1AH0gHYPCBWag5FkaC?=
 =?us-ascii?Q?EZ9FH7F+1Sc9tsKm7I4b0oV77K6Z6WxjPytGnl4wEfgc17+VBrob7dyDJxeo?=
 =?us-ascii?Q?VgK3nIMlj2ZRDHauYjOomd2ovKtzaUqVAbOMQyZPbVm+TCMEsb/TjzRXY0BF?=
 =?us-ascii?Q?ssLz1u+aZYKCIZNTHbrtOZGHm77Y1QKZBCFFTTYOnkldVIQEjs9COGXoUOnY?=
 =?us-ascii?Q?rmX1utO+lyQ1ejdwbBqDjs5TXvvSqG1gyrYpwYMhir9cD0JcdCQ+Ka4XubNT?=
 =?us-ascii?Q?kooTcM5lxWktSpvSQSeZQQ/BBAfYvJX6hmv0pr0EjTfSXBr97h3F6rk47SAE?=
 =?us-ascii?Q?AocTOp0vPoP97k4xHvqxzZX2E27tGKg99BgwIv+UPo6QsDbwmRUp3CDV2nHM?=
 =?us-ascii?Q?O8XdwosOb+BNqfliriY/1R4cbsf8ql+Lkndu+mvyWDUDomCClTKo71inVFO8?=
 =?us-ascii?Q?FW01ROirnLth1l/sMLs7/AGf7bXBs0ugr1iZZlR4QEaxcG6w1dRndVU1ottW?=
 =?us-ascii?Q?RvXXYMhuKYMCCq2+Kg5CdCu4nRSVqVMAcwpBbPCU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8452.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a633300b-f8ee-448c-f5cf-08dd55956b85
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 12:10:39.8550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: upnfka4iqUHxV29FhkTal+wgAcJ60TimLVZ4Z7kH74eFsEJcigg6LXHEp5kEkAN6AUHWaM1SiXTZPWDoIAZjJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8210
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
> Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>
> Subject: [PATCH V1 1/4] common/mlx5: support FDB unified capability query
>=20
> This commit queries the FW for the new unified FDB mode and saves it in
> mlx5 shared device as fdb_unified_en bit.
>=20
> Signed-off-by: Ophir Munk <ophirmu@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
