Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDECC28B28
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 07:53:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2FB840DFD;
	Thu, 13 Mar 2025 08:53:18 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
 by mails.dpdk.org (Postfix) with ESMTP id 55B7F40B94;
 Thu, 13 Mar 2025 08:53:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o74VCHcULMgAqmQJfsxzASLFWJHpcY9Ee0Tn5A0Y5YHLb6qtr+HxmYbMm8i3PUyUHnx9MqSBgY2UQ9uwb2DDmu8iJA1MCX3Qg9uW6cFPMLDWrrt95Xj7Rnjj2CAbsVIj+Yg8EfNGkqsQQTKxLSlMLhvQQYwKRGrH1CmdTmUZ1xUkjWjRDKcfOAJZ3MPtqRsqfIXsPQvWSoUxzohERnK2zzNji7qz8q/icjeUZbxlXX24McZjnAZeCzsja4upE2YRXEAB67+WJujZHEOvB+rvKQQVeRSdG5Kq713/sVI3kRWVY6lR/ILPx18ybz22xlzbIq2t6IStqfAmYamslz1KxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBb0+3p42545OfiPms+GBItXxdDjaZbgfJrwercFHzk=;
 b=DV/bryaanBqAATvjhVZvQf/ma8sdxZvC8B98j+N3RqGiQE5BO5lb1v2gVHW6fHqVSUHubMrQaXo1k9SSMDzEyOUPRDKg4zPxFdCGpkonZmmND+ov8A6IHnmKWqKYWzriexLe6nXoJJioHHTDCnKe8Ny/ggfim13Xr2uwqpFnEu1/tYxZTpHPM/wAD8Ke3Y2kyd4JC/iFdBVTiLXUDE/e+DtdLyjkikyMOYAhxoXgqHALTLlSdTWCuv+tJ2zJ6WFYSqWyEt8VRXS5EZGaW06djfH7Rh8U02gLkEB1axvk/79QcC9E49nypADuEU05eGcwDH2E+sW86YtQCLJxv9205g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBb0+3p42545OfiPms+GBItXxdDjaZbgfJrwercFHzk=;
 b=KxS2rrpnsQ6WYgHPL8uzXlotjsf8XNWEE1BZ2yq80YXKpt786BxqNU6eX0K8witP9gnc5nq7Rf7KqCEX0vu9KLdnYxnPUKXcIRYzxoQMPnqz7BdDu574SxQeh+4hnc9fZGEdRVhTkeedVN7ZYS+rDkZ1XLv5v3+BFGruY0tUZ4DnqZwDu5s52KppcbXFdq9xpRerGWgQxLJMiN2q/Po/50A+wDu0Q4F6QgroMi3rFFiK25oHIM3coTEnjoQG62xoo5KZmJp221BD8csDhGIqgFN26EFokYCrJUqfe1qQIAWudKS5LogMii+EzzyxOinc16ZbgmsPl5W2h0XyChWYgg==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 07:53:15 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 07:53:14 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Gregory Etelson <getelson@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Maayan Kashani <mkashani@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix IPIP tunnel verification
Thread-Topic: [PATCH] net/mlx5: fix IPIP tunnel verification
Thread-Index: AQHbka5yL5NH55tTfEO8WdmEJe3taLNwtngB
Date: Thu, 13 Mar 2025 07:53:14 +0000
Message-ID: <CH3PR12MB84607E4819558F3EB3E73FEBCFD32@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250310111945.1144018-1-getelson@nvidia.com>
In-Reply-To: <20250310111945.1144018-1-getelson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|DS7PR12MB5909:EE_
x-ms-office365-filtering-correlation-id: 7b3cfbab-0b2b-40fa-ebab-08dd62041c2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?B948QeCteYGGoasB7X1pHOe7GC9d3yF5TKMR46Q/mv6eSgoWL4QM08JGyP?=
 =?iso-8859-1?Q?+GmviQxv77AczHI/ifZX3nY8qNEg+ZUcZ2vrYApGJ/+8HSn3lEVQr/DZD7?=
 =?iso-8859-1?Q?HtPrfLYDQUqMGQbHEVgZPacKWJYPdc/s3PtW4JBrPOq5K7HS1MYNAGtiRw?=
 =?iso-8859-1?Q?iyTEMiBqkhaHaXOsbvgfu5L7xfemhhKpCb0OpbxJX0LhR7g2az4RN1nDDP?=
 =?iso-8859-1?Q?CftJR6bQEgW3aY1K5Dv6+dhvZyv/GXRxPI6+k1kdX/F1yVUJpuUHbrD9nv?=
 =?iso-8859-1?Q?wG0pYp0inhyRSjlYUOFd7n5bNkQgHc4a5mjwUj+3QWufQJxlvI+otMsjH+?=
 =?iso-8859-1?Q?8w5XSSq7o4/E/QDnU/ZvZfUFh/Z4mLncbBqQVsxbWg5jSsjiQOn2Zv0Fz8?=
 =?iso-8859-1?Q?h7ugyB9+peQkbhEICbWi6SL2xISiDNc/9fv/G3tGcWeZhW+73dn4G1Rtnl?=
 =?iso-8859-1?Q?UEULFlEMe5X2nq27pUACAPRB2XIhgw0f6+BxUM0KR5uk6knRai1RXVW/Ix?=
 =?iso-8859-1?Q?K4AFCOdKRkGc/c933efG75VM/yYhMa+erkex7zk7b3W8/+RVVfz3wtcp5O?=
 =?iso-8859-1?Q?ZahdXrl2zzVtWEw1AbriLMLHi6w4Roiq3/2jFO7meT32lyIXEIFk5WQnE1?=
 =?iso-8859-1?Q?SmjzpOYc2UvWTO/qd60geV2Ic2sqtsyXmRmFMUvgPCsV5DNKkX1mrBr/Hn?=
 =?iso-8859-1?Q?pxAW1oX9txg7Jq8VbWQyh6xHlGiRY/cQroTAWdHbW6qG4KPOGM+PmxWZsl?=
 =?iso-8859-1?Q?So+sUq1FOYrenygvwg/qxIU57gnA+aObiqD+UoV8KKNEblE8jyklHIO2Ki?=
 =?iso-8859-1?Q?ssodMOyX00sSmll6UgdZocUYrqDuzgmORMLmtEsR4WrMnMnf4CFAQrvNK2?=
 =?iso-8859-1?Q?R0EbtSZSBtoz8Gp1c7zj00xipHXvHq6WI3lQhoXeK36UOnlEcoDTLqBoRV?=
 =?iso-8859-1?Q?fh1MrO7irLxnB6GPyxqRb+nDrOQQ8WUbQlu2/U6nVut/DdSMmmzx7W9Vuo?=
 =?iso-8859-1?Q?8Xd7BaFao+iKmblNf4e/cXf4sZoyI1Z5iZEWw+6o3RIvtzAoOMDtHkxchb?=
 =?iso-8859-1?Q?AvbbKjHAwUCjhVbUb7gaQ5ua2CE25xKJ4FVBdG3LqZI2oNYL5jkNmwVkaj?=
 =?iso-8859-1?Q?UATFlCjBCYSbytecqodiapP7DI4emHyLhCdSRUuVkT8QY/36/YewaEPmSh?=
 =?iso-8859-1?Q?RRoZ/GwJGh1+ANnWR7+GwqRM7N9MQQCiJ+ofid4Kr5p4fZ4Q9qRLobNFD4?=
 =?iso-8859-1?Q?/ULZTCDAjVfr4OjgZTXQRBcjmbWr22muxwCj/XlPE/LLC1y3zJ+IF8HPPn?=
 =?iso-8859-1?Q?2tiaTR6p5R+hZEsGUGcx/XBgG9NIrQw17TiN++DBqnsKq+myi2BKQVF+DU?=
 =?iso-8859-1?Q?zJTGa1xMz4hyrxtST/e3yX4h3F+j9YhC6A+dMXLBfqzkw5cnmdJRzV2WC/?=
 =?iso-8859-1?Q?znV2cXUAafl2ayo/j98kpgP5+ZjTow+znQhB7rmxJbb3rHft4wV0UyVYXv?=
 =?iso-8859-1?Q?tfeIV6rqhRVSS1FPm4yU3w?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pPpU/9vfKhwehpigpw2oXqpn2TpIzrDLpTni5ZEaYAbcaToKKwLTQOhdb3?=
 =?iso-8859-1?Q?3qR7QUViJlUXs/GjYWsGX0apEYOJE3HT7Am+KSDXFw5yBluMWdiOYBEQhH?=
 =?iso-8859-1?Q?THDJhoUj8VjcCuR6frOM2+BvjyDxiv5Rjqrh81eqMvQA7iCMErICEpqIRC?=
 =?iso-8859-1?Q?PGvXjH8pDEGlFIkUbdtGnzU52NjwvnY1dd6YtUOUYQ34ui01wJv+tU0hcH?=
 =?iso-8859-1?Q?2ibm1xPtnyVWCuUYLCcOI8FELH5J23cFcSOfLX2+2Mw2qmR8ZciThq69aH?=
 =?iso-8859-1?Q?D9anjt2YmpfhUuKkD+PXAxfycXaPv2xG3Xdi4+9IkeZVtbbXwBWW7FYF8j?=
 =?iso-8859-1?Q?dW4XoWubn+iM+VTkdvBiObaO/FaQWbtRTTAGNvwjJuQhP9WEq+h2q99H5H?=
 =?iso-8859-1?Q?1RNwkKWK9lz1FxS/k8pBdQnS90/ibjy2mJJckPxjLsU8PPj64mmTlH8zSO?=
 =?iso-8859-1?Q?pL3It2swiqnH/Az4OQRTHKlhSboIYsVm2I8n+g3VQuHUzDHy55kPodkLV9?=
 =?iso-8859-1?Q?ZgIItQfMmSuu9JkZ7Fp0jsd/5USEO+kUFtf+TKFKrR+ihSiBTDQRA+yhDm?=
 =?iso-8859-1?Q?tBYWs8Slv9yitwawadVStX/OfswogSEIQwaG2R7RwljRIBs9/QzYyrWnoT?=
 =?iso-8859-1?Q?fyogKVngno/8i+zDFSW0bYVn0eyjvHR0dQn/uePwzaULVDGKa9KePVhEt3?=
 =?iso-8859-1?Q?DWFZGWEH8E0IsraL9w46eCpo/AuaNoEcQ9bX1kUNRb3Kj31P93tVfjT02/?=
 =?iso-8859-1?Q?x5BwDuCQK1Eyi79a5DweRT92k2ixAlnsxK+Iw8MbumvgkCla85WLPaTk9W?=
 =?iso-8859-1?Q?w7DFXBozvD99LPqyvBlnLrSoQWWnk2w2YPtmN9gAgsNcMyyUFOPlsr/kGJ?=
 =?iso-8859-1?Q?w3AbHYTeW8IDp7whCvK9a3nwGQ91L2kDYa3ru0wVMJd+9BNltG1nakrwrc?=
 =?iso-8859-1?Q?nQxn5JpmquOQbUlxbFSPJur7mG+85OESTpgkfV4ABpelfNCK5A+d40yMoR?=
 =?iso-8859-1?Q?y0e9fJzg0jfje+aU6IxXljTIXsDY7AzUxE1bIHZN/7chEbehoYN1ZjvH+d?=
 =?iso-8859-1?Q?C4d+oGI3P6/QiS+/GIdHdBg2HAHmIi7MVP8kjcb0IOslVtz+4I02GlpW09?=
 =?iso-8859-1?Q?pQvwPzcJlGJ1uxx7Vc/21h01+nUdoUcSEvYsUoiXQe9JLnCY4IaI7nFpYA?=
 =?iso-8859-1?Q?l5WUPw44a9LoIR/ZAhk83PLnjjDqdr7KfGhRUJKf8LHziMakw+8CebOm5X?=
 =?iso-8859-1?Q?39+3dCEeG4km1oXVpe/CXRyPN137TMSCocHjI58YT9li7HBjAgXEWq5eBc?=
 =?iso-8859-1?Q?YVX3kLsTKaP75MPAbNwBZMWbxuo1ieHOQ5XLIj8G2cLdsYsEtemOoX1vDk?=
 =?iso-8859-1?Q?tseUHv6thKgYwzJtIEmVetLomnNhwtpQVATLXY5ZLLllHM7F75mpX8p+A4?=
 =?iso-8859-1?Q?wAttbhGiYNiH//GgJ0vj/SnP1cCSNjDC6io1ZLhAa0So+AEI1RdrPi9ZQu?=
 =?iso-8859-1?Q?YNttkL1Er97KAVyDOEsfn69e7zFEJY7Y4ya2FX/6KfPUsU1huLKAApBIVH?=
 =?iso-8859-1?Q?ncAZLodljScAsuPwsbkHG0BUgjbQ2cz8MXlpK3AghJmd5567vg9ftNJV5p?=
 =?iso-8859-1?Q?rDpNPz21SDbWA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3cfbab-0b2b-40fa-ebab-08dd62041c2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 07:53:14.8066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9JrPoOp+4qCQlBDo2t/ZpILRgz3eZTTxLofahjDxzA36mmJcGBoTAH9428DIAa85DB1c0WCciknpDiVL90aGWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909
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
From: Gregory Etelson <getelson@nvidia.com>=0A=
Sent: Monday, March 10, 2025 1:19 PM=0A=
To: dev@dpdk.org=0A=
Cc: Gregory Etelson; Maayan Kashani; Raslan Darawsheh; stable@dpdk.org; Dar=
iusz Sosnowski; Slava Ovsiienko; Bing Zhao; Ori Kam; Suanming Mou; Matan Az=
rad=0A=
Subject: [PATCH] net/mlx5: fix IPIP tunnel verification=0A=
=0A=
Assuming a case with the following pattern:=0A=
=0A=
eth / ipv4 / udp / vxlan / eth / ipv4 proto is (IPv4 | IPv6)=0A=
=0A=
MLX5 PMD incorrectly recognized this as a packet encapsulated as=0A=
VXLAN and IP in IP at the same packet header level.=0A=
This caused a flow validation error.=0A=
=0A=
This patch fixes the inner IP in IP detection logic.=0A=
=0A=
Fixes: 2db234e769e1 ("net/mlx5: fix IP-in-IP tunnels recognition")=0A=
=0A=
Cc: stable@dpdk.org=0A=
=0A=
Signed-off-by: Gregory Etelson <getelson@nvidia.com>=0A=
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>=0A=
=0A=
Patch applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
=0A=
