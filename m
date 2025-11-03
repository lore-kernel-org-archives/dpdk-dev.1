Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273A2CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 04:30:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF45F40270;
	Mon,  3 Nov 2025 05:30:31 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
 by mails.dpdk.org (Postfix) with ESMTP id 7599D4021E;
 Mon,  3 Nov 2025 05:30:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WO5CdjmnTWmgO5aageMJ5/T9FrDBbKuvxYOw+/Fz6ddNn/LplVJMVKnAFDCwAXUdtzxXKsZHlXie7qUMO0umpx7/pzEHNg2DVZ/7V/V/Qgy0EcXLLn0akbCTrsWnbhrRrgkOz+z86cQZvZ3fcEbhqaxm7Pxh0zqKletQ+go8pezHAW85JPYr/wzgX2w2AvjGFXxB4S2KF5jaDOK9XfRXxKqSDvaBt9wOlzzDwwQUyeGe7WY8Bv99C6dje871euRRTw3YPlR+FbIrwGKLgEZoLOtN3qvWHIH4qUwIID/o3oKnZC5iLvlsxAnZCiQndNk6KOVjA9pH93Wxe+yQl6Tb5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwVAxZ7dlS7iCaLocp5GRAZYVMxZ/OaubYiDQryORDE=;
 b=fCOty/ZrGPTP+M0gUtaUi8BUyUtsnu5reNMr27FGAl4mZpt1414eLtgWhG0KPCSGrNkUGFT1uN5W9PAZnNK3IoQM16/X1vFLdjCKksq5vRmRbfen9NP2sz6iI9XzifXoTpOFjYJLWYqNXCHJlX1Hn0kQO+ZuSddIIVwEPaNpaUlHQ9pc/9RYu60LKZCFHYH3erqvLGsPUtvQy6VqDchOwIOXz0X9WloalRY/oUcu0GutnS26ikKM8E6zP564datXbDRIDMgmII4XyWWbqhSYQFliFGv1t7Hp2y9XyUAnhCz989F7Y553/fpSaJbWUuRtc+xDVqkviqy1FqQPgappyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwVAxZ7dlS7iCaLocp5GRAZYVMxZ/OaubYiDQryORDE=;
 b=pOEGRlNMOdRnmC1Pgw5y3N+Ywe9Thtx2V3b2Kg+Kb/HK9C4Q10Ghq7aAjErVeACsQmgyyGLO5iJUPtP1gScln5LtoeK60P7ueOvuR3wcodtPtgIkcs9/W41axb/td6br1HF0xm4kwpzIGwFP/KNwMP1vnnS+FtE33P3tVCCG8EQ=
Received: from CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14)
 by SA1PR12MB8162.namprd12.prod.outlook.com (2603:10b6:806:33a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 04:30:27 +0000
Received: from CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::7818:d337:2640:e6c7]) by CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::7818:d337:2640:e6c7%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 04:30:27 +0000
From: "Gupta, Nipun" <Nipun.Gupta@amd.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Agarwal, Nikhil" <nikhil.agarwal@amd.com>, "Yigit, Ferruh"
 <Ferruh.Yigit@amd.com>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v1 2/2] bus/cdx: fix incorrect device release on error
Thread-Topic: [PATCH v1 2/2] bus/cdx: fix incorrect device release on error
Thread-Index: AQHcRMwGewsAHO8kN0CsCZLT4NlLYrTga07g
Date: Mon, 3 Nov 2025 04:30:27 +0000
Message-ID: <CH3PR12MB91931D8D32CC4638AA789089E8C7A@CH3PR12MB9193.namprd12.prod.outlook.com>
References: <7e4985db2bbf29515f8cd6a4ab510d71f8a636a3.1761299581.git.anatoly.burakov@intel.com>
 <05ecc81aefbbe2073416c0e78aed926ec9ad54b5.1761299581.git.anatoly.burakov@intel.com>
In-Reply-To: <05ecc81aefbbe2073416c0e78aed926ec9ad54b5.1761299581.git.anatoly.burakov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-03T04:29:31.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB9193:EE_|SA1PR12MB8162:EE_
x-ms-office365-filtering-correlation-id: de02f6df-f40c-4575-5c34-08de1a91b6dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?hXu1EZ+MbSFgr56LjiIwIswbgZhLzi9uspN27PsJs26Q2L1y+PZuEjWdlu2c?=
 =?us-ascii?Q?E3A7rDlGLKxV6fUnWpLlMH5RylT7RqGsHEIJt+DZ0a13Ont/MPNakQC6lEbi?=
 =?us-ascii?Q?/ScicjsldIXqSwbnUg+qOgr6P5XPhZ/RMEZLXAX6SS5OJhJWJxNjEKz1Bz0m?=
 =?us-ascii?Q?l6bultiVXWsCZIN71x2m9YKCduf1nKvMicwR3Ia7ieox2zGpGp0AW+Vl/zER?=
 =?us-ascii?Q?CKa6ApN0zRkAJ6faV+nb1EYy8rkDxwNqbnZCndXfFzMEQp3qMYpu7OIw6HT+?=
 =?us-ascii?Q?cjTOGaMTCzqfQmneIkfjgsXLkDEFT64ybc6bVKhJ9Xs9KxvUvxoFdbmja5EV?=
 =?us-ascii?Q?2sHxpuPKsGPzKgvML3v6iHkWT6XWXBSs6v9FX9QpSmhClkPQD5j1KEA3AhO0?=
 =?us-ascii?Q?itnVpwImYzhOLTShpsxQ2DsE1McDrV5a0LnR02RiOrHbfiaxvbQ2eqX1UqsY?=
 =?us-ascii?Q?pkPcII7oGg6XGtC8hEvtVwV4F3mVW98OMcPegZB3JiAlQdChRvOzmX3Tn5XJ?=
 =?us-ascii?Q?hut5bxF+coyFZXyLOA0A67WwV4S29cvY9085mN8GQznquumwzd60HWXJNznx?=
 =?us-ascii?Q?XDa/nbBmm4GlyK9j2mKmnVw3O4WMOo0V+ARvmzlbz59LAwDXI3CQKZ1w33PC?=
 =?us-ascii?Q?eRFNYoxMsv9fT72m3FiwvhDjbBvqFiu/0YsBPFbQaiaQ8LDpalb2cFhZx5pR?=
 =?us-ascii?Q?v5EtHJ5cmTdUYA7u9prOFLsxiCze3rPHSZfmnjbRLIwxbEjmwCyqKJo45Y/Z?=
 =?us-ascii?Q?7UGb3nG0erEI6eJTTrkqSpVgxwK2/gA7ED/KftJ94YPF/FldajzHAAVW4kFX?=
 =?us-ascii?Q?Qc+VIaXj8eVeDU5NdgHJzMJLHIicxGbGpwNkwUJcZGTVYhW297qzkWOlXav7?=
 =?us-ascii?Q?sn+y0uPhMJh4eH+orA543vzg03deejqcwnhYo+YomvkhzDXn6ML4lWJuGsCW?=
 =?us-ascii?Q?1DO9bjXvINEJucU5ZrQ/od1iTAho7JYp8Bz01QqauYvgstmRzFpI/2iF12Ta?=
 =?us-ascii?Q?jQBORtzMu7wxD+5qPxicL5Kmi/ZMaXtxBpsGeTTaXpgTcI9NGmOtDNN5JBIN?=
 =?us-ascii?Q?2iZfHHOMYEF+yPd1Eg2gzVGqVE99tOiKH/LBqE7xkTkMbrV7TpZSdbuAwOmy?=
 =?us-ascii?Q?k1n7t6QjoLVdaruRnKWf7AFzrDOCAkzv4oUPFzmxF2h2mMc9EkpJOzjlY3uF?=
 =?us-ascii?Q?ha7mk2HM0b/Iq1CbdeWri8+v2ZIqnFj5F9ph+fWeM3u6zViCJKN6b6LN8uxq?=
 =?us-ascii?Q?sFg376Zj/4xYiUH+wI+OwRBuUURHCc1cx7lr5DaUqQRb3IutMb9tQ3OFSLKz?=
 =?us-ascii?Q?CfS1F7QfpdsNbNrufA+D4//8YV+JXy5HMSDm4PbJx5+OoY9vrT4JYXVPn1jN?=
 =?us-ascii?Q?qhHkpnhXpRxRUEB9P7z8eFmgfYHX74BL4MNFgvcWf0SvEL+RnBz6hQFMj1Hf?=
 =?us-ascii?Q?H3w0TlvABkgKuS3mXVfq6iJse9skcfidFcilzCi3y4dBH1HiINcMNXJaEa8E?=
 =?us-ascii?Q?zyCXHAZQQk2okbeEL1liV7JLlb4eKAZqmjLp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fk0QaskgB5oWL5udGxJfcFlnSZE606EkwY72LNWVuqg/wHLriU1VLKCwby9q?=
 =?us-ascii?Q?RnibsOsElT/aGFfdhIXGHbN7mj9JsgGKKJ2Mgtacuz3h3cw2/L28BufYDqal?=
 =?us-ascii?Q?ivfYD3D//DJls14y7fVznYQuxvbjI8FW/TwnRcu8CRr+af9VmmZTM4IagzrN?=
 =?us-ascii?Q?glWjvorn3/FrBJ0rQlTb8BoqeENciVUfutR/ypyUHO+S9Am5CJcCrUTGwNjU?=
 =?us-ascii?Q?0lgEQMVyQWc/YgHsg8vQpC/c2FhZjUyBH/FGihU2mCsXYvqjFvNzCbD34aWg?=
 =?us-ascii?Q?4R7X6HuPAWQVU2Ljf3oJC0pLLw1l+SPzU/kjwMezX6GaKWe4tkMCONUFLJaT?=
 =?us-ascii?Q?UlUgjzT6QAyKsPKE3zXqxRAlCgrrvkSjjHyRJXzTq8/Hj1lSftPbyv4LdTiz?=
 =?us-ascii?Q?NDD+UMZ2jBB/O3QX5ldDo/EzigFRZmRuGrYCcXhSDXCsIgB/HgMoFNSInB8t?=
 =?us-ascii?Q?Zq4mIiLU23m5bbO2uGzWxYlKbGm4DNKHPjmwQ44gclbTQmAx3+OnFYUqnVVd?=
 =?us-ascii?Q?iMxXknPLwDQJthdmktLBVgAFUdCuJ9cPAQYTCvGY6bJQgSuovUNduTuM6l+0?=
 =?us-ascii?Q?V2gleUYy4IIKa5YIhPSUKZ2HWCO4dc9vV3STnccLoTuvhv2Wl6eDzhC1pOCm?=
 =?us-ascii?Q?+iK5EXtT1j4Wgc7mpp7YVTJV9Uq9NtAp5ZpMEYo25kXQX4Kbl4WmK3CRYvJo?=
 =?us-ascii?Q?+dhTTf9ep9SX0btZ/F9siF9LUWZ4OomuyvRx9mmPvypIU7RqAlGWtPQ4Jxgy?=
 =?us-ascii?Q?3VkGIsMECLooBn7vSplX2whioyQ1S3RK85StYcgV9Ue5KpPg+08ubiB7fFmJ?=
 =?us-ascii?Q?qEwVfnJ4kzuru18GrglM3UG112OuWPi/A8W/MNlcky2Qc6vxKCBbCXFMrCp5?=
 =?us-ascii?Q?LEnSQQInaV9bLzMdO/iR1X2H0n8NO3i85X+NTFv3JyMHBWE51Bnkp54mEW1r?=
 =?us-ascii?Q?SOIOZkvbQbkl6ivJC5TkrdB27x93xSOaqXkVi/v9zZTmOAQJZgJT9kADrC88?=
 =?us-ascii?Q?D0hHHMdj8ZjiRzjLlNZXnvRwS2XzxD5qX5py/4QRRLvyXP2v0GTktjWLOAWz?=
 =?us-ascii?Q?KiXc2pb+RdXpks9YgWl5N/vZJC7XFS4XnLwFmgjYkv0IITDXkBg0Q5oZveE4?=
 =?us-ascii?Q?d8bG7+YT5C+i/oiT6WtLOMgEZgpzHQF0mw3zG82suWTjGQKcYAEL8ur6bK0s?=
 =?us-ascii?Q?RXP6bF0KJYXazOxPsl0M3ShDqC09Rhf50DWdUewFrdmcwT7ul7ZZYfq0Ez4K?=
 =?us-ascii?Q?0rznSUDDtskIh0k32GpQ0OAX7eWyALXDETzTXmPaTgLdzFdO8zKgufC5if9E?=
 =?us-ascii?Q?5NhemEABPHL7PGaUIcQQzyYxgX83UMHf3iXoggBh737nv6ujJIuDQCGyHB+j?=
 =?us-ascii?Q?TXbQFjV0RKNAcJbXH7h5ftbtTiu7+cGZ9R3nbctinBwwTgJ4oJ4Ypi3YEgnm?=
 =?us-ascii?Q?NsSz1F05bUldA7LYW+MMZ4x/wYXtEjDwKkZzemLrAVFbPR2nZf0d85ph9xOF?=
 =?us-ascii?Q?6CVVlse49JyGqTPuBMDCr+qN9AD0afJpFgx1BksyxDFMoVwCUy2jXD63ffJw?=
 =?us-ascii?Q?Kob7Q616JpR/k1syXKM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de02f6df-f40c-4575-5c34-08de1a91b6dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 04:30:27.3217 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eewnvlpkd3WQuVQtK85ZdJh+3MJmpoIhKdsW3CXpb4zO1mrXzjuL08cU9wDj6Y1O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8162
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

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Anatoly Burakov <anatoly.burakov@intel.com>
> Sent: Friday, October 24, 2025 3:23 PM
> To: dev@dpdk.org; Gupta, Nipun <Nipun.Gupta@amd.com>; Agarwal, Nikhil
> <nikhil.agarwal@amd.com>; Yigit, Ferruh <Ferruh.Yigit@amd.com>
> Cc: stable@dpdk.org
> Subject: [PATCH v1 2/2] bus/cdx: fix incorrect device release on error
>
> The variable cdx_addr is a stack-allocated zero-initialized char array, b=
ut
> it is never used anywhere except in an error handler to stand it as a
> device bus address for a VFIO device release call. This is incorrect, as =
it
> should have been actual device address, so fix the code to reflect that.
>
> Fixes: 45ef232af515 ("bus/cdx: introduce AMD CDX bus")
> Cc: nipun.gupta@amd.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Nipun Gupta <nipun.gupta@amd.com>
