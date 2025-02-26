Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3747DC021BF
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 14:13:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83B4A402E2;
	Wed, 26 Feb 2025 15:13:33 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by mails.dpdk.org (Postfix) with ESMTP id 3E93A4026C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 15:13:31 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=va1s3RGz2ZyK5VSiMIgvRm5Jkw04ufZnVc4gPso2NpxxkyCzRwkpYgpdKgn0klTnUVl9Rz98vxZ2jA+zdL3PNrbAmV64cWyURcsPkszFvvk6r871gKlJk2uSBznOegbYGss5eYuzuKocDrSd+Bv+oF3Cy5OTnCnW04z11H9NNTwyTDszY6kjJZBbeq2alro1afwPU6PCABOMa+lC5QSdVb6UY52lTpu1C24E4rHlFCKzfFY049ufgsD9672XjDoTqBrtUQanBEKdz3oD6uyyxdL+yr5VDAAC8LHME6vwwIvh6rN1LiAl+9eU/yM9wjmxngbckKt+9wOrmBQCzcfC0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6KmCJaGPKLd6flYzvDy8rUQGVMlZVDuO63INboX/EQ=;
 b=OQ3EDB1DP03Zv126Ldv9QVuTPymHg1F2L12LvW1Mjp7586YF0t4yi7UF6ioZ0CZNqAcif05dl4Qbw5+v3vs4MUf7Ks6cJpkFISydAYBjYWe2gLNQlXJcC5XQe1qoy7sGe4Dn3YUYWQYOOdlga5bf+0q6goC/1lBj1bA6/f1i04iRNupRSe8IOEL6sh7q2KBNmG0ou22DGsX5YkxqDI3lFMAXZK7Q1xerHHRYMVEYVJ+PJ8n5crm0YAok1iKemCAjTEJ0qkTib4ofN2IalfY9RQwHvXZ6UDn6c8INzVHg0DXiJ0+hyBcHzAk1CgCy4mE7j2Cpd/1MPs5MgUc7P3BtCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6KmCJaGPKLd6flYzvDy8rUQGVMlZVDuO63INboX/EQ=;
 b=m1AErkzPK8Jq85yPkGgLJeGCBRpcgSCSNRFzlYVV36Mfu6gr1DmRUoWz6skm2MQVVP7STQS4AvFHUfOZ+Dug7St+PyeWge5rAp5JdekPA5XHCqAB5hxgDnIORsEgBefDepYnYemm1D7uSWDt6u6iTvo/xLtJUUSGhzUujN/phQopgCXkGaxazkp2Zc6Jj0nLFw4ex3vq65lcWV3lDaLIFGyWF7/29rxESX75LtRQDC23jLXb2P7yPWwgWlyz1QRezSV8GuF7dRYtd2YOoa2JGlbxqSYPDVHqAh6ZAqYPLjufh5vpZiD9KLiwzcgwPqSVISPpdy7Xzv4inmmZqUlnTQ==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by SJ1PR12MB6196.namprd12.prod.outlook.com (2603:10b6:a03:456::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 14:13:28 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 14:13:27 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] common/mlx5: add ConnectX-8 device ID
Thread-Topic: [PATCH] common/mlx5: add ConnectX-8 device ID
Thread-Index: AQHbhcMFYmkqTOd1g0ChatEpP1BgJrNZpXbR
Date: Wed, 26 Feb 2025 14:13:27 +0000
Message-ID: <CH3PR12MB84602529F550A8DE280FFAE6CFC22@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250223071647.60542-1-rasland@nvidia.com>
In-Reply-To: <20250223071647.60542-1-rasland@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|SJ1PR12MB6196:EE_
x-ms-office365-filtering-correlation-id: c3b508d1-05c8-45fb-acb7-08dd566fbd9a
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?x4mcTclBfYbyYxnOogpfqB1mpxrS59cdG5qODCWBnDOpCH8gRsWIAV5Lkc?=
 =?iso-8859-1?Q?r+hwU1eYyzcS+QPDMa+HiTywjnDUyd9HlVfKudPxSeLWtcomk29YH+N0b3?=
 =?iso-8859-1?Q?HwYmZFNXdPfFE2vEzJneKMkXsNKfkAzGLvL3leyalCuJDrU/osr/b3OeMk?=
 =?iso-8859-1?Q?9nCz+Kwz9WNcvAEYb7J/Pcw0KvvSdrbZuBeVwHjB0dorH0RZrBRMguwL07?=
 =?iso-8859-1?Q?jVNVEi1wSER7UI2sqclLf3Q65745BkWa6nuxyt86BCUleJ5M2t+CWHf4Ho?=
 =?iso-8859-1?Q?gM9sNbJiOS1Fa7uixvVsUV+tf4I/MPeH4iSIrDzVjesnDH1UP/OoUv0YFJ?=
 =?iso-8859-1?Q?UH0jfZR05NdxUEpaQ1V10OT8ygH1bAIHEeMyYY+Uo75cGde8CiPR270yJF?=
 =?iso-8859-1?Q?rsB57+c+BEvoF+oP9C14YwXxl3+NKdIHwxT/F1Vr2sWhNmGZ/aKI6nfMMm?=
 =?iso-8859-1?Q?Q7V2MCNLoYR4hNuqbZnYXCJkJc5mGQUnLWRUDzjg0ziYzB1U02n/v7ddm5?=
 =?iso-8859-1?Q?vAFq+tX+nwiuC3MZoREUa6RG+LJO2hzwGpDYXxFfwwoGpKVEbWh1w2q9e5?=
 =?iso-8859-1?Q?iXnlMWTtpt1m4VeU3HYugcgyE8d+2bXVLACbJ+beC4PVDLL/vQKF4EXDwT?=
 =?iso-8859-1?Q?ZC97bSVzdfe2S0jiN3ObtDZn7vKglQFFnfDF8eDAzFCVnzPliq4zV2ounZ?=
 =?iso-8859-1?Q?2r8zErRf2zMAGI7bouzSNk6CRN8V9UEy2SkhOjafjoL/YWh1pwc9De2AO9?=
 =?iso-8859-1?Q?+TMNKkiYpvtMuNcTVp1TqVprWvvA9PM8bjlwHnCzkExroT4Xhf68boQiA4?=
 =?iso-8859-1?Q?mN+5ZnWx6AkL426eD4nyw/jpgyO8dvudl/k6SXvGKFVLxwIETQ0xdlG9O7?=
 =?iso-8859-1?Q?twRmR23jImDbJEVPx16kBiO3PPkiwV/cponUvwzksiGNes5iLHa+apvhr2?=
 =?iso-8859-1?Q?1fMD/y1grQRVk94GhrIeI9KcYO4u1nNziOzHeg4I5M0HH/J+0eLdkxAVZA?=
 =?iso-8859-1?Q?czSHbLE9Ft2abJtRwDuKzrGJy+6Dj3qW3mbLfuYz/dk5Om3F4Wj+e3v+Cy?=
 =?iso-8859-1?Q?cy10WiGqr0Pp+Ax1RvOjHeTXGfXXTJTU9sZRTtCtO6pnAtoLCHutPNTRYZ?=
 =?iso-8859-1?Q?oKLaUnJqyFs7DmaTFxDni5/g1hTH6FWpNYeqZpLp4nS4BIprzarmcO/abl?=
 =?iso-8859-1?Q?ZsNI0t6I/NY5IDaJd12wwx1fGcDNcTqEzXOcIVKNIsiHPrmmc8BJ2wUNHw?=
 =?iso-8859-1?Q?Ky9O2YFFKHaRafowjUBM953Yxu7PWoStNpZJU67HHZ7pSvmkhIrCXqepSk?=
 =?iso-8859-1?Q?Qgd7Rc4kFEEGHjO95mFvUskH4V1GdfLvpHoOLgBFlcPTzyrGdRD0EjwJHX?=
 =?iso-8859-1?Q?BEm+3zg4VjI70miIdpjj7KoF46YG13/0g5sIeAWoZ060d883OqMTIihmCJ?=
 =?iso-8859-1?Q?KDk4jY9EryI36XeJBZ5BfR8OIAKeHjf5lHbUR4qo18cut2j+e5HS9xdwRP?=
 =?iso-8859-1?Q?P+JrVKN00PqgLBCxih4jFW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dq1/MWNfH4X7ce51bVFa98TyouUa0Ckt5KcGQy/hjte40Zzy2oZ+oVWPr7?=
 =?iso-8859-1?Q?JZNqKMUnExOMFYd18zeAp9TYYz4PaW0F6fvBL94wzlnOY0y1sJ6mlkSoRA?=
 =?iso-8859-1?Q?f6flqYylPgUtDr+LPivkewRfrmItm5fevnyOj111tyXGDAkyUliEgJaBta?=
 =?iso-8859-1?Q?6PKZywRFkCF5+Pht9XfcF2FadwrFLKxGkA94ipX/bNn7JWTz/Z708R2n65?=
 =?iso-8859-1?Q?2xG7hxtwKXNbN/4GiOvBu+6Fqo9UH2NK2rdOcOY7rv+ZBoai1T98z9Vzx6?=
 =?iso-8859-1?Q?5BELqyBHluj28yF8NHXYa4Zw6e56I1kZNjKHvi1YXALZaN1RMSSsOi2TRZ?=
 =?iso-8859-1?Q?+Eh1Vs5hEwxqIbSzBpSRieV/ersMHnLWEUxONmhU/HqFvdkJQnEXgath+M?=
 =?iso-8859-1?Q?UTMek7puNN8pfetWguTFooNB+ihiEiQ9HVA5PtJ0GU/MH2pYp4bdRe4/+H?=
 =?iso-8859-1?Q?cL39GpzA8PRWf6Zh2llybw/FVbH3ZSQ+CwsnktbxsLA2x1aBc83GAxF8Q0?=
 =?iso-8859-1?Q?WtZB6uHq8ImESllN5y5xwSIEYAVEGpD92ORBqHtiFz78+jhdEH2rK5a/55?=
 =?iso-8859-1?Q?BvvPIjtAORb1u+uDeA+xJj6vS3sj43hUoN1aS5wTlnWczrbQB3ZwKWjB27?=
 =?iso-8859-1?Q?ZfmON+73+9I/6SC6od0hU8UGwS24+zoDn3iPcnGOu3xF6gOAMGD24rQrFX?=
 =?iso-8859-1?Q?kOPsP67m77IyXQMMRDfUhp9NXG+lBbCsH5F70FldAEv/yAEieD8i5+OElX?=
 =?iso-8859-1?Q?gzSXLCdxConlNk6CULiwQVS1GSceiAXSl0GNeYc/JSbtI0RwQbEpgp6RXv?=
 =?iso-8859-1?Q?l9bOZME1Rs2APD0DNShQHe1mH6yydJRH1m3lK5HhHFonMhX/BMYIPIoXJ7?=
 =?iso-8859-1?Q?5vWmulOrvRtmlNEljuoCzohbqKv7ZPZa8X/AP+HCFb+WObY7hI+/3yN2tW?=
 =?iso-8859-1?Q?RCAGm9Hj04MX/cC7hfbuVTsfg7LlyiHRUdzOgf8ZhNucrJTmxBA3jfly8w?=
 =?iso-8859-1?Q?sn1pF1/KALN+zqV6JPmS1XTKzu8C+PktVQmztMuW9uFApoGf6/U1JzIfW+?=
 =?iso-8859-1?Q?yC2GWdls9swyZMyDglNzg1vnkfyqJrww1hxC/UfySZAlljobaF3ogLjikt?=
 =?iso-8859-1?Q?22D5srLMb9tMmYBfrQ1MpokxoBUAsb/JamN/DDoMcyyDPnI1cdNHhpx0gB?=
 =?iso-8859-1?Q?qmK+ZswFKQ5CbNBHRacuuP8M5B7e11YImxUHXlUU8EPVFYftyeESAd/R39?=
 =?iso-8859-1?Q?sUtEdEvn5shr1002XpX/m/2GMb/umm/kIUFq6d9R21pz5RBboTJTTNA5Sg?=
 =?iso-8859-1?Q?yzfxWz51okfo0woyPxtVMmfCxOdo22w6SnBfAhQA+Gq1zLnDmYEs4Sk5kv?=
 =?iso-8859-1?Q?jRbMFAFLZXlgJnHoC6zCXZGLQJB8fuKD2XXem/wqOevDtzx5yhdx81qPzA?=
 =?iso-8859-1?Q?dRXSkXaPJE3vVhQcsHdIVf25qNVndb7PrQ/d3NCPP9xZyPu9Lb2Cz84sw2?=
 =?iso-8859-1?Q?UkRHvUttvWoxd6F5N3NWqcTnEBpCjieFUpyrlfMCfEwVc9e7w6D+HmCCip?=
 =?iso-8859-1?Q?DVD5nd5JMZV2jsYrt6Xar+ppL7lTo5RycuN6lCRZiJyLVb73dySaJcCquA?=
 =?iso-8859-1?Q?KhZ6eHT22elY8dXo4oYwlZbSeYchZ6L6ro?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b508d1-05c8-45fb-acb7-08dd566fbd9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 14:13:27.8475 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PcXyJmxKgm4lomm3QOeVL7v3D4ke8Vs1feuZQdfRauZf7pG7VU0j7xjm58zMUqSebH3xIi3rL1bgWAbd/JCRig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6196
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

Hi=0A=
=0A=
From: Raslan Darawsheh <rasland@nvidia.com>=0A=
Sent: Sunday, February 23, 2025 9:16 AM=0A=
To: NBU-Contact-Thomas Monjalon (EXTERNAL)=0A=
Cc: dev@dpdk.org=0A=
Subject: [PATCH] common/mlx5: add ConnectX-8 device ID=0A=
=0A=
This adds the ConnectX-8 device id to the list of=0A=
supported Nvidia devices that run the MLX5 PMDs.=0A=
=0A=
Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>=0A=
=0A=
Patch applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
