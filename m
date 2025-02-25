Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87E3C021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 13:07:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F0AC42E79;
	Tue, 25 Feb 2025 14:07:27 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 99B9442E73
 for <dev@dpdk.org>; Tue, 25 Feb 2025 14:07:26 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ONUA0f007278;
 Tue, 25 Feb 2025 05:07:26 -0800
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4512gd1kth-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Feb 2025 05:07:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRem5jyQuuOojm/YHlp08INsF3h7gQusi0ocyacPcQPdIXlExZ8L9ctbQ8FRy57Z4oDtjgk/jeaYQ5/JHs+k7nogWCqeyQSrlbl0ZpyU30UTKtV4kfIV+tvyInfjPEShc2Eh9fmj3Phuzr4PuWgg0+rvWT57tdQJAe0ZvLK2DNHc5BFqB0lzfjzJgcYC65yvKilsW4TZyTbhCP6sCK6osbi7plMHeHPQkrPgv5ZyVPihzXK37zUMhb7cE17GHkQ+V3xe3w8aGfEx+DcgRrJpR+hNibGEUAFDY5+tiLjn3L5Wvgghc6KREZxB+ICcvAk5ZSuy+umRuJ/olEYehUxJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSgZKqRDThkh/mSqWEOov81Dxu5r6oMyYky0/HcIqFs=;
 b=rFfM/spZpdUnrKGp8hI5vshZlUKgLVE2gUG/OzmfmGUsW8NI2hgOWVfaABaHTRDeuntKR6YzRzWFVOsU2ev0g4NR1sOtgM6xe6KDwoMq7ey2Bn+JbEq0px0jNgDEcAb+W0oHeABqI73yoPkZorIxrhuDZI0eU41Bguj6tNjnATd0PsMchj+ztK0x1OuM5r7MJcCEOBRIq8Q7C3mU8gofdMhG0n/FlYhs+Wz22atwwzbWrVF/9TW1YWtzjYvbL4ca2lHoY6mmTKjDqltrKIJUn6q+nMzMcelUn+iq3NxQ8+o6pN0WnC6EMHsjEYkzR6otrk14i1coVO/03Fp3+YuQlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSgZKqRDThkh/mSqWEOov81Dxu5r6oMyYky0/HcIqFs=;
 b=FLQwo/Zj4YB0BmIBa6rAVKlkd1KiPf8zUs5fZo040nDsL93lhwVSwwvVE6JQOkqe/KyRrjavlt52bWblbRbd/PajYL8Sn70NKuTG3QccPYURH2B0bl578HiS4WQQOXrfOUXb2faNiSM588rRm+7GZ38IVNrkc/tYeces7JmH62s=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 SJ2PR18MB5787.namprd18.prod.outlook.com (2603:10b6:a03:577::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Tue, 25 Feb 2025 13:07:18 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%3]) with mapi id 15.20.8466.015; Tue, 25 Feb 2025
 13:07:18 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Shijith Thotton <sthotton@marvell.com>, Jerin Jacob <jerinj@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Shijith Thotton <sthotton@marvell.com>,
 "stable@dpdk.org" <stable@dpdk.org>, Naga Harish K S V
 <s.v.naga.harish.k@intel.com>
Subject: RE: [PATCH] test/event: fix number of queues in eventdev conf
Thread-Topic: [PATCH] test/event: fix number of queues in eventdev conf
Thread-Index: AQHbeKwxyr8QWMAXN0GpIOII9AgIJbNYGtnw
Date: Tue, 25 Feb 2025 13:07:18 +0000
Message-ID: <PH0PR18MB40869C8BC5E4ED5502E6DC19DEC32@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250206143244.524451-1-sthotton@marvell.com>
In-Reply-To: <20250206143244.524451-1-sthotton@marvell.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|SJ2PR18MB5787:EE_
x-ms-office365-filtering-correlation-id: 32bf034d-850a-4893-7e16-08dd559d5559
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?+KMn81699xdO33NTbfXGMIr3FZQV/faKRPoyszJM3dNcUASz/5gCa46cbh81?=
 =?us-ascii?Q?XyeMlOXc32xhHBO2J8dqpfkA84k5nQ+INy2tUlEv6HWlyfgAxUCo7YZYac8h?=
 =?us-ascii?Q?H+ftJUY+pdr7xX/UzdOi0WbudvgWpTYvECxvZyWzgi8sXo8J+U145VNll1M/?=
 =?us-ascii?Q?4jtR7eAyGY3jbznlp1XkcnvI7njyoftTuvBAPr+XO0SPH2IQ09oSR60VJ7xV?=
 =?us-ascii?Q?I4oZsQPlVfLg4u+IAs3GoEicb+IYd9BwqhPhxpaV6cT7z6kCcglJvc0Vyv8r?=
 =?us-ascii?Q?LUrFgIZ/OyG71ONKVlKug8j4FHFDY43NueAsWaseNPTYT6/Drpy6X5rJNqU9?=
 =?us-ascii?Q?1T7iU3NQlwLipwCJDBXt4k/7msZvTIk79LxE32tLnXLLmM1DXLgsQLy06RAh?=
 =?us-ascii?Q?DP8E+6dpr0mM2TJru4zBa/wSpIlVjF3qBLxWOD0ZyZ5O478G8nLjMNdHr84Q?=
 =?us-ascii?Q?zrlt3GMENApJTKw1ObLYD5uz+ii83XWwa9IoYq+3ThW7mWk0NTXiGg1slYVt?=
 =?us-ascii?Q?S1O0IO9qi2U/rwSqGzEDn2UHCS2w2GYn7BPrciRzxzmvvihrkHvOFJP3euZx?=
 =?us-ascii?Q?ZUHAeRQav2LDWxLGZX4Zg4T+G6HZQKpEBmPIPRjY5IXD13E/HlsX7Kn3fl+u?=
 =?us-ascii?Q?t1tDaACoP1mT1zQFMXSEf8W041iI0ZUCxHD8ZGtnoFXorWdTeR6ub5egl9xD?=
 =?us-ascii?Q?kRRf/BujrOHXVDI7Sl3GwH06bKBoS8KuxCx08kIGCNHAGQOz0smEYI7ZtuF7?=
 =?us-ascii?Q?+O/N6TRC5Xw62rWoy7HRbR/wfb2zSGVN8Yv5lItuy3l74pl/kv2XAKHZqr+m?=
 =?us-ascii?Q?ZNt9ljVEO3U5Kcl7l5ph2ZeBdlLKqoJ4ne0nHgAjjOD6N6/KcTMdV2p4cLJv?=
 =?us-ascii?Q?Sidzb0Qtb+SLI9VNRtANKLyH6BYRXczv9NHCArteiTl5AJ0Wf+p4MMSwY2DM?=
 =?us-ascii?Q?nYszVrAa1MMnEA9V+yk3baEpQ2N1Yvrm5uuKaaC4KdxwdFfCeQt9zB76UfHb?=
 =?us-ascii?Q?I6XLuEF00Mm7B2xAQfLjy4FtCYJ2sIyGe73XArIm5JjWUs+oplkJUWzTyU2j?=
 =?us-ascii?Q?SdzLOA8MhbbHVMvXDEfMX1d2u9Ndnm8gGcVEf3LX9qQOkQ3R4f33lq7H5iwt?=
 =?us-ascii?Q?YBItTyS9Y9e1vwopXzepq4q5QB9O/R/MSEYuNXFe18Rilzq/bwV5MdE8UeBu?=
 =?us-ascii?Q?LBh/HGnlo05f5qx7LNE4oRVL1IEH8pHLQPvb67vMCxr36Tbdr3msgC+qzaZ8?=
 =?us-ascii?Q?DHDdvBfqaqpaUY1olz0KM/Kc5UA7WHHG0gl1EEo9dMrHczr4E67gkjrOYPni?=
 =?us-ascii?Q?86QZFCcXTeJu8/8nV6F2p5xV+gUqSQq5JcHfqxf3+jeu+2aAI+l9nOydgJ3f?=
 =?us-ascii?Q?6X8dgN2LrQGiajmcqkPJvgr26XA18KFE5hijbs95yZNOz0YQEnL4jPjgM825?=
 =?us-ascii?Q?jtNNgUKDj2FUOqcjgu/6MUbf8X2Osyy8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QGC7ICxUdmX5j9cWnDtoy+VDiNFWVFXPNBXfm3zLvuGPee8le2HkO+VdMN1M?=
 =?us-ascii?Q?MfHwD/VmvywKwrdDJgjUbzkLH6yduoIhn3i9r4XrldU4wHbbx3l5QXYcMdhx?=
 =?us-ascii?Q?MNXm5/53VE9zado32DkZKoy1EQRRgeH5hMIEoXu8ldXFDNOLZs+/bfXNTIK4?=
 =?us-ascii?Q?VOFy1oNSUW/Mdis+GlY/OTlJUrcfz1KVHmelrO8pJmrBYglsEmLpfV55l9oo?=
 =?us-ascii?Q?g3vmfAhHIAnpXrWiGhxjjXyJ7DzNrIfDDAK5hmmdEMIuwzaOk9IRsCPKPbbZ?=
 =?us-ascii?Q?O8nD3oYI5pIiUKHIiPaIrxJtNObHmVFKv2HR0hC85ukJ/CyUm1Tv87Q56i+8?=
 =?us-ascii?Q?4EgCtW6VA5Tt9o80frV0hLnJgDKvuiB44bXQXB4EzB0nhgfh7wYs22d30cFc?=
 =?us-ascii?Q?lxHMp7Irum2rDvgw+7baUJ/JYFOsdONTa4mSQm5QL6Kxc94mglO+zi7qGXoh?=
 =?us-ascii?Q?AkpFMeqj2keqIAgP8nrm0PlL30G+KbiCD3xKRlG+2lM/Zp16JhqxgiwiTNSb?=
 =?us-ascii?Q?9feAsURhylSSTHw6WVuLUw0q9d56S0ooDJbK8NurkJ5195iPItjsa0VPNMO7?=
 =?us-ascii?Q?NFFgCTNxXTLRhhrbb/q7A0uS/4Z6dayQ1KNu2Unlox0Qc4rXcKoy/7isYggD?=
 =?us-ascii?Q?0sBVT4uZNV/qg2+HGokaoZr1pNIWOyXc0vQY7uHb/Yel45/wrny2soafDsq9?=
 =?us-ascii?Q?SPtz/aPOO3y6f6nPSvf6DNoMG1c2LZ73Ui+MSL9UrI+2DTT1GTBXkJQoA/4B?=
 =?us-ascii?Q?nbUgRldfOg9vpTqrwJxCJ4FeEfrawemxPBVglU3D3Rf0clMhHkr3aS23erkm?=
 =?us-ascii?Q?RPEPBAw+5+139u1LHjymXN253WgeqAWqUWQK/03hnF28zC1LWxnqJ9UfcR/V?=
 =?us-ascii?Q?aabeEfBCAGOQ0VClge5zS2lib75gHtVqjkdbyD7OXLMwZJ544rmNR2dXM/pj?=
 =?us-ascii?Q?XxAF+ThdxuM5ruyM8tO2Us6H89vn74vjAPBi/F7tSd2wTgrz0VWeMVK2ECpl?=
 =?us-ascii?Q?DQzfi1/92BBTgWXsTrzl+Nh94avGZcrZYDjTTdQWedmU0DG7jUikevXC3zls?=
 =?us-ascii?Q?k0+6YPqkcBfi6q7uouIBB1ms4Ik0G6Hs3kMojz9Dhe/+jamlzo4gFXT8mbM3?=
 =?us-ascii?Q?4GwoW0y1O2Aj32ylYf1EI/74vk6NiV/z+f5HRydckmpKx9aZK2QgHSdEZmpx?=
 =?us-ascii?Q?udTajY+xNwexmzILE926TeztEN4qO0E4iKe+5ZRAXRuBlOL4pWNZ9QJjty/t?=
 =?us-ascii?Q?L7T8qSppdCkiyKn+IVZ9HIsK4cIZpZRUSjOX+sROh12QtCRG/R774qeykDUy?=
 =?us-ascii?Q?eCgEcRKMF09FJCIVugyHcDne8klBAwoLKuPPIfHS5O792KIGsZ5CjIRlhukI?=
 =?us-ascii?Q?MBgo/0+WMAB8Gl2NDhPmEdAnZHIIWtQHiGw3Q5Rq6xoV/2HXs21OR7qKwJjm?=
 =?us-ascii?Q?MFoO0vV4VH27Vqlp5UoFdHHGC1c0vwO6QfqkLZS4F9IpsOuV7EQOef9cMDvv?=
 =?us-ascii?Q?X0lsn5Qz9EZkaLdU1Gic1un76Yy/27FZeRHMr8hYqbS5FThb0ENohVN4tD/m?=
 =?us-ascii?Q?CCKk2iMldgkypjYrMpiJEmvYbX6FjlMGN3yYn2Y6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bf034d-850a-4893-7e16-08dd559d5559
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 13:07:18.6502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QAvYHaRYNiMTowa4ONHE7t4TDM9ajra6Dr5Cq/SJ0kbgD8+g3ErWXcSZwowEBVj3xorKCpLNk8nv+epLWCMs5HJbz/a7HsU1PK6zgCY+pOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR18MB5787
X-Authority-Analysis: v=2.4 cv=BPRJrEQG c=1 sm=1 tr=0 ts=67bdc08d cx=c_pps
 a=nskeBUqQUen4dZUz4TdP1w==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=T2h4t0Lz3GQA:10 a=-AAbraWEqlQA:10
 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=QyXUC8HyAAAA:8 a=iWxQwe-bRrW22CO49s4A:9
 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: vHm5SdNTEr23Az0L6S6peuNQHQiYUq46
X-Proofpoint-ORIG-GUID: vHm5SdNTEr23Az0L6S6peuNQHQiYUq46
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
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
> From: Shijith Thotton <sthotton@marvell.com>
> Sent: Thursday, February 6, 2025 8:03 PM
> To: Jerin Jacob <jerinj@marvell.com>
> Cc: dev@dpdk.org; Pavan Nikhilesh Bhagavatula
> <pbhagavatula@marvell.com>; Shijith Thotton <sthotton@marvell.com>;
> stable@dpdk.org; Naga Harish K S V <s.v.naga.harish.k@intel.com>
> Subject: [PATCH] test/event: fix number of queues in eventdev conf
>=20
> The unit test adapter_pollq_instance_get requires three event queues,
> but the test suite was only configuring a single queue. This patch
> updates the test suite setup function to configure max available queues.
>=20
> Fixes: a1793ee8aba0 ("eventdev/eth_rx: add adapter instance get API")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
Acked-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
> ---
>  app/test/test_event_eth_rx_adapter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/app/test/test_event_eth_rx_adapter.c
> b/app/test/test_event_eth_rx_adapter.c
> index 0233c87779..9a60e34352 100644
> --- a/app/test/test_event_eth_rx_adapter.c
> +++ b/app/test/test_event_eth_rx_adapter.c
> @@ -230,7 +230,6 @@ testsuite_setup(void)
>  	}
>=20
>  	struct rte_event_dev_config config =3D {
> -			.nb_event_queues =3D 1,
>  			.nb_event_ports =3D 1,
>  	};
>=20
> @@ -242,6 +241,7 @@ testsuite_setup(void)
>  			dev_info.max_event_port_enqueue_depth;
>  	config.nb_events_limit =3D
>  			dev_info.max_num_events;
> +	config.nb_event_queues =3D dev_info.max_event_queues;
>  	err =3D rte_event_dev_configure(TEST_DEV_ID, &config);
>  	TEST_ASSERT(err =3D=3D 0, "Event device initialization failed err %d\n"=
,
>  			err);
> --
> 2.25.1

