Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879EDC021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 12:21:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE372427C5;
	Tue, 25 Feb 2025 13:21:05 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by mails.dpdk.org (Postfix) with ESMTP id AB51141101
 for <dev@dpdk.org>; Tue, 25 Feb 2025 13:21:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bta4ClmT1tDoldQDXzsrYrqFPx+mqPCxc8ZnRVQ/YatXBYs6SNyWBYWm5shjYyDvpnRrx/ivtS6egKMkr8Gr6EH97p+DmT7V/RrT9B80nfY6yOjnS51skoY5utqO4UQOQgumKdIpkE+WXzGgbdC80zadIgRJzz36GzmUG+fZaCDoJLQVHDxofR5oqNvLATGOb7Uw136sPQBDH5Dvo6ucs6TKMeyEo2+fhgAptJrL/CQGXWleuWCNyHkaf85cDrEV8/jjYx8q1PWZ3L/6ePrlChrt5mJkn/8Any9KaFBKxViTyELOh1xozbiBfUQPTerrvzVJOCrRdHbFY547p8Qkkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjJVQ8mftNWsuMGnFEf0MPymgmDi1Hu+40joaSPHxr4=;
 b=C5hSq+g7NS8/DRR1FYS0p6lcgtRpvD9SAMyZjpdI6i6TodR6vS55+SNzzi8NKgkU8JcA/PjI8nj4oQKxUGBo7TqkaDMxzSOxaU/QRAnPx3e+zB5QcYKuqBiv/bZY4uDMoFQq1bRxAaUXKLmeDkxsjVfaofwZQpcSrDws68O+OzjIEPt5Yr76aeZZZMF+f+nYOoLxlI0mL+SnVSrb9iaq+gGAqFioFP+2/e8vkaFDhxio32h//x8kCV+FizPae5qn3SkiTexJhEejkLZbD6V/vlIUdufThiv6Uq34u3Z6O96+J+ZdTCpotqqGGOtWQlEUg2K1ueFZ18uKQlJHSP24EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjJVQ8mftNWsuMGnFEf0MPymgmDi1Hu+40joaSPHxr4=;
 b=IYUnm/VpTn0bTa+apFPszV+tQVj86MsZKwY8WqicuuuPh2ouUejKJQgbz+4JiBhBLH36mN+GFsnXOCq+5Lod+8J0jSKhjSOjhl/lf1NXXcIsxn9YD+mBbBdMYjCrLD/sfGvwui9n2yOxcIrh4K2zwO3Vrx0WMNPC7xwZdsvsF3D0DNxVHEqTLyOT5sPUae/9YFXKtMFzJyptra/rmWwouz2NdlpL6Eve8BLmyUZf8syPYUQ9lxo/ueNvd2zW8mxAksSgMsxMOcN5KelpjR4kVHjDa+qgKbmvu20rrIIXtvNyKOB7/8snEKyrDc2BJtQLnoi09BSa0LIx9QcJDnumBg==
Received: from DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18)
 by SJ2PR12MB8159.namprd12.prod.outlook.com (2603:10b6:a03:4f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 12:21:01 +0000
Received: from DM4PR12MB8452.namprd12.prod.outlook.com
 ([fe80::b341:6309:cb1f:5b6a]) by DM4PR12MB8452.namprd12.prod.outlook.com
 ([fe80::b341:6309:cb1f:5b6a%5]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 12:21:00 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Ophir Munk <ophirmu@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: RE: [PATCH V1 2/4] net/mlx5: support FDB unified domain
Thread-Topic: [PATCH V1 2/4] net/mlx5: support FDB unified domain
Thread-Index: AQHbh31PsZY0wykkP0e/dvRRjeSSMbNX79HQ
Date: Tue, 25 Feb 2025 12:21:00 +0000
Message-ID: <DM4PR12MB8452B9927551003EEA379A81A4C32@DM4PR12MB8452.namprd12.prod.outlook.com>
References: <20250225120213.2968616-1-ophirmu@nvidia.com>
 <20250225120213.2968616-2-ophirmu@nvidia.com>
In-Reply-To: <20250225120213.2968616-2-ophirmu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB8452:EE_|SJ2PR12MB8159:EE_
x-ms-office365-filtering-correlation-id: 55a8f1ad-43ad-410e-7067-08dd5596ddb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1NhfrXJ9PNJ7SEh+N63Y4QkycC270ZJgdIRhn6SJb9cx5ZoxMed/Ru4/fc7I?=
 =?us-ascii?Q?HtLvXDiV0oMLW1xgLoQIPf5tf9hi4+uIWDzLVUakWcQXyWnb+SoAWEJQIh/l?=
 =?us-ascii?Q?1rOapt8C6MVZ2B9r1Pbl0b1U7g3E99KvLD1q4M8fVQ22YA0HS4elbT/ZoXTR?=
 =?us-ascii?Q?cDObfwQYo50OBabBTiMby95n74nD2gCnpqlm4ikLUEf0zIRa5oaekdolACAm?=
 =?us-ascii?Q?KniKbWdEFtCmujNY5IBbRWx3GXS3tww4KFN32kn4IKpfbrWUuO8EHkTBmN6L?=
 =?us-ascii?Q?Z5GZVZOkp6B8QGIoFOOszhPR/qxeXSyE0m8XMnd0MJJOep75nxukLwS9bbnA?=
 =?us-ascii?Q?9r+qtZYzWaZY3dGn0LoVcVRSYWjC1eyPtgwH2zkBKMrDsZJ04H/JMqZu+l2G?=
 =?us-ascii?Q?L+aqp2nVA7vccUPhvH/ZyBaruhDKbi+U4kQtXI2aTtTji2yOoGSJ698oV+6U?=
 =?us-ascii?Q?WdPkLLkk5hsKQPD1D/rZL8kLLLqFKclatwgjBvtEQf/7649e6XDyDWIutOyy?=
 =?us-ascii?Q?zEuDj6RjvhIuIMfePpOP53XBAwBPwrQWyxRoiyZbSJ4k+S0x1ZkhvOTRn+UK?=
 =?us-ascii?Q?PMQFQq/QIymJXfPfRIFjrDOBTyFB1k+zPsoYPrVEupIQv1zoR/zjleRtt72N?=
 =?us-ascii?Q?tDq2rQEs9aFXwDpa+fQEAR9wFv+kMiuTjb/lqrB5VZEpOQAYgCaY0ereFHBH?=
 =?us-ascii?Q?KjiOYdvm2NI4U3RTUlo+Zx83Hs+QaT4OXjTMerFr6/TjEX7Y2gLCCJeE3sEH?=
 =?us-ascii?Q?rYJ8UyhRcmv7bauAoBXzEMfOw9xNxp1Kd8lQmgF7Mt0DJkxRpWuJeq07r39j?=
 =?us-ascii?Q?VUz2tBu14hyJZxh4Wmv3qGoIuOTulzuYxVt4WMWhItcs5aKeXr3XXlge4cU3?=
 =?us-ascii?Q?KNZ7fc/H1qpdgcFob7WHPceYxNDfUzTLo9tjX3NM13QQ8QRB/XWiGM5A5YH3?=
 =?us-ascii?Q?1CbvTwAsrXKNZ4NXHDKSOP/AzI9OQbrsvpMdL7bhDpjsXyeWLP0l+YQu1C09?=
 =?us-ascii?Q?rbGu0ZyHnxL7Y7T0hMlm098fhLN4p14Vezxv0HpmVca0iN//Ai4om3FndsAV?=
 =?us-ascii?Q?Rb6u5H4JM6FA36142gm5L58qVKTcI8pdUbZcEVf/X3qqoYouG9uyrInKKdi8?=
 =?us-ascii?Q?PgZWdkriDYbrJ54RtscICeOnCw3C1Jh15LLknVU2GiFzxtD8cn1CmXdUrFic?=
 =?us-ascii?Q?8ZTB6y4p4jH6wYhe49kVeUjEbjRg4bST3UoM3Q1Ca5pmjMSNmQq0k8hErIdc?=
 =?us-ascii?Q?O7wSa/8NDN0Pd7oPBkvpozJn069GAEaJBW9X7jI628o1Rs1NlT7I6NHfJlf+?=
 =?us-ascii?Q?5kk3PnXOGreVtuWB0QX+On8hjaVBkOdFeEvP6xbzLmkmZeR6ILd89rWMjJIz?=
 =?us-ascii?Q?F/vaiNAA8m1ynoiA7Iqx5bjkBIDkvaTcJKHLLQHkr06s1gCCi+QtnEZbMRlA?=
 =?us-ascii?Q?MAif4qT+VwaM4e4debbJO1tOstxrk+E7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8452.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9C9pGtzvw86GFyj/dC61/L2rt0BvIhsL55rszrd7UHE/lS0SbBvBrcd7PDad?=
 =?us-ascii?Q?9e6efW9UizaZ6sfECaCUKqZfFFapUOl9OhizO5//Qk0KY2jGFfuHdd2CAAQv?=
 =?us-ascii?Q?iBL/CNeKTzy1D7qHDnKhr01bTo2VBtSSYIrNlyYAIIvvCkOFsLSvZ011Nw2c?=
 =?us-ascii?Q?igWEGsT0EmZyDivTrjS21fa6iccg4eRlaj3xfBbf7+ZB5ouP5iP5WnG7+a4y?=
 =?us-ascii?Q?TKoJZFq2M2dqqnSZSdlc8Ltq0YFHpa1hI8kFPt0AKUxUmKmHBd2CwW9I5S5j?=
 =?us-ascii?Q?ppzlGpJk0VCD85+qPJyuopRhYgjo35a6mPqk2JM75iItqirAFtCbRn4vSP60?=
 =?us-ascii?Q?QL/xE0T80t8wBGqrXK8oB1QbqOblmpXpHsw7NaIFAQR3jLuIf9FUoE5yb9vC?=
 =?us-ascii?Q?J1TpV2YZIWBUAey7armZQM18C2sGuyAwmMUdpsxQQy1fFtszGRraZvbWfuBQ?=
 =?us-ascii?Q?pjAg2H28/CbddEcQAA/R4XZ2lTElyqq+MAA/BxjI5QuW6YRFK8cbE0JL5UW6?=
 =?us-ascii?Q?Iq7+C/VAeghBJE/zYxyhnEd0lHnrKRZx4U8g3/38DveDZ3xkX53CgwIqEX54?=
 =?us-ascii?Q?vEg/fOl7V0ChzW1CX1b2pKGiO6itSsqo0F8oq2mMhOtzF5fWrV6Ru5owIY25?=
 =?us-ascii?Q?jWSo8jDex5xabU3JqN8oNt8fwLGjfI2RvBkahCFUlgEQ4Ffv6g3O+79QMXqq?=
 =?us-ascii?Q?FAGLDzJbhdBLzWkj7xUomCP8Roo0iCTDeinXnGdjfG6/1V6n1aN046I9EmgX?=
 =?us-ascii?Q?Qz6FcTqFm+121PTeRThhXhzVZRIpwIfMvcqs73EQIbM6cvxyKbejgxz02NNC?=
 =?us-ascii?Q?tLBYz4JhpOnSRPk/EVifs2C3IREFC5c3Pme4qqIo0v/kZr2rV+kJrVA9pGtS?=
 =?us-ascii?Q?koSeFm73lhnDdkPKgEtNNGV9C+qDfsvdRKGzHVoBR5IEnJ0JWokKdbMHcyvv?=
 =?us-ascii?Q?I01iYQww8Dg+c2Y+2Jvj8syuY4p+auO8sgEfYojmGN6Dqc0DdVZFSev71+SL?=
 =?us-ascii?Q?g7JeGH4ym4elcYabx+Y0ektMzb3RPxGYi3R+lxGoAIqvCFXoHiQ0klVvAseB?=
 =?us-ascii?Q?FyMqZ/vlWnsiVFSINhl5tUC/m6mUOE9IaBQGdI0e9QOzqeoyPRM923hYaL0P?=
 =?us-ascii?Q?FqwvJ1CJK4Ns7HyhYYMLwWCXUFJbtVjdsLOxZYTxtYQhSAGRnrj1HYgvPz6N?=
 =?us-ascii?Q?AEXwconTbo+keKO5VamTrbmcpVKU+ronTbRX4YN4z8KaAXYef0lSHTW5b8kA?=
 =?us-ascii?Q?MrNTE2ydkW7RJkaLRgWLdhyN6lj+cZUh7iIscnupkseVAuodPfM/ZpMyq51w?=
 =?us-ascii?Q?Ls7k0Q3aenBQcm0iZAAhx3qEviIcFF7M1hSPS9JJVxHQ/Fq8AmIOUM7HOP9r?=
 =?us-ascii?Q?tH9X5PIefIBPXVuN3WC4MJnA9xPQ211y244DfFe6uUoHnyXtFSezTN8VfDKM?=
 =?us-ascii?Q?Dj9RRG6B1STOm1fC/9K1jzwMKUOrsmXmv3F16clvuycItqJlwteRfVm1Hn4q?=
 =?us-ascii?Q?h5GDtVkrf7kDtA9t4MsVAbQAvYt8MYRe34R7H8Z1gSVTgRuhR5H6fH/lAym/?=
 =?us-ascii?Q?ma6UjjH/10CnyVvO1mwZy6C3oKQeqHRCQ/7jeRiZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8452.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a8f1ad-43ad-410e-7067-08dd5596ddb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 12:21:00.9255 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KywZuWdwVtnqllK7N6+57EMvSSTTorfqvcNX14alaQiKn9WKogKlieHlzBxkdTnDpE9/hPjvwEBJn6Zm/ZM+Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8159
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

Nacked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Please see below:

> diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/ml=
x5_os.c
> index 091f288..9410211 100644
> --- a/drivers/net/mlx5/linux/mlx5_os.c
> +++ b/drivers/net/mlx5/linux/mlx5_os.c
> @@ -1707,6 +1707,17 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
>  	LIST_INIT(&priv->hw_ext_ctrl_flows);
>  	if (priv->sh->config.dv_flow_en =3D=3D 2) {  #ifdef
> HAVE_MLX5_HWS_SUPPORT
> +		/*
> +		 * Unified FDB flag is only needed for the actions created on
> the transfer
> +		 * port. proxy port. It is not needed on the following ports:
> +		 *   1. NIC PF / VF / SF
> +		 *   2. in Verbs or DV/DR mode
> +		 *   3. with unsupported FW
> +		 *   4. all representors in HWS
> +		 */
> +		priv->unified_fdb_en =3D !!priv->master;

This should be also based on FW capability check introduced in previous com=
mit.

> +		DRV_LOG(DEBUG, "port %u: unified FDB %s enabled.",
> +			eth_dev->data->port_id, priv->unified_fdb_en ? "is" :
> "isn't");
>  		if (priv->sh->config.dv_esw_en) {
>  			uint32_t usable_bits;
>  			uint32_t required_bits;


