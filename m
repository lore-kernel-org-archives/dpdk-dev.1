Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC66C021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 14:14:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFEEE42E97;
	Tue, 25 Feb 2025 15:14:00 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id DCC56427C5
 for <dev@dpdk.org>; Tue, 25 Feb 2025 15:13:58 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ONUjMq008228;
 Tue, 25 Feb 2025 06:13:58 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4512gd1r9p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Feb 2025 06:13:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUETCnimtyMP1i3i+MmNUnAsVRjuTxOHvkLjLTcqBEBEkz6P9VXQm0FuCYqBA9cWEMYsC60hFmyTDtiG/y8gExUr+DwtUxwKntEP8t4MJaMOooMkRzf2MTUc90tCrigQBvguSBXaJTyVc942YaqcUvXP6TvKb/3urPJGZ0eoWHA+JslCVxB5E/5ptnA+z8AISIy/imDHIkoQXAlOGNB4wQGZZuxtaxIE9cXehj30nwzwO0FYT57yYf4dreBl/GL2l5Yq7SDh9lpgskq9eeN5hQ9NbT6Y2gRBhvQk/+8cMY9wl1G7OT0jEzEwJM4c4ffctWjsua0qb1/DgvosYL6FQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4S+rOpqaWDiVluA243UZ79fFrMsIlc5APQFhkQvWSE=;
 b=vh/7bcAIHuiCbnMkeuE6llFXM5yytCVKlCijDACmTVsXKaZn7FafSuuGDA3SPtinlfDvGUtx4L1gQihhGUT2nRxNHW7GZfVrNfj+9oZ7H8buuqAvL6HMEpmMFNykXKbVt0CL7Jy6L9dntsBH4nfRpr8mbUsqANh/Q8BrEGF7OnpQ5Yoqhnbzaj3CO5lx8nx9VNu+IKisEXOpSe2VA+aWAoDM9Pn4hdPK3dHmUz9K2sba90WSWepHUg77NuFsSmhf4x4wCK4Tqotc0H01EIBmvcfe+csJJ/BSEiUOx+zNP36vHpp3CrufPZooR5LE5rCJKIKKT8Vxzrnfp3VcFVoO4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4S+rOpqaWDiVluA243UZ79fFrMsIlc5APQFhkQvWSE=;
 b=KnmvJT4mU9Lsu9Gu9oA1NsF1Gjw01Hik2IGctHlhvJyNaykBvd5/l40vS9bJJeKHkUeAUvxef+L52qZacZqk4oeSzsN2neRA5GeYLjQHQj8BDL/aHSiXv3/hUlEBSPjetfRVKa1CofBTX6liE8gSgexxzx2JVisI8BSLpYv5Bcc=
Received: from PH0PR18MB5167.namprd18.prod.outlook.com (2603:10b6:510:168::7)
 by BN9PR18MB4297.namprd18.prod.outlook.com (2603:10b6:408:11b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 14:13:53 +0000
Received: from PH0PR18MB5167.namprd18.prod.outlook.com
 ([fe80::fd38:dcb3:d404:a4b6]) by PH0PR18MB5167.namprd18.prod.outlook.com
 ([fe80::fd38:dcb3:d404:a4b6%3]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 14:13:53 +0000
From: Amit Prakash Shukla <amitprakashs@marvell.com>
To: Shiva Shankar Kommula <kshankar@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>, Vamsi Krishna Attunuru <vattunuru@marvell.com>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, Pavan Nikhilesh
 Bhagavatula <pbhagavatula@marvell.com>
Subject: RE: [PATCH RFC 3/4] doc: update prog guide to use rte_dma_op
Thread-Topic: [PATCH RFC 3/4] doc: update prog guide to use rte_dma_op
Thread-Index: AQHbcltDVZikB09c60uZXCDNwjAl0rNYOa0Q
Date: Tue, 25 Feb 2025 14:13:53 +0000
Message-ID: <PH0PR18MB5167AFAA73349A4E69B98552C8C32@PH0PR18MB5167.namprd18.prod.outlook.com>
References: <20250129143649.3887989-1-kshankar@marvell.com>
 <20250129143649.3887989-3-kshankar@marvell.com>
In-Reply-To: <20250129143649.3887989-3-kshankar@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB5167:EE_|BN9PR18MB4297:EE_
x-ms-office365-filtering-correlation-id: 1d9de571-1c97-4435-c2da-08dd55a6a277
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Hxxmx0RX1KB8aycP1++0+NzAUQlSwvDiRfVY2XXCxa/t/9dlgy9rEzUSDII/?=
 =?us-ascii?Q?d1sVrCDHn80XgPZvC+wzInvNWUN866eFUCr55IVWWZ6Xvht+4umImguO/LEO?=
 =?us-ascii?Q?dG7rZDFN1kiqMtX/a9G3clLoHCs4HOOtSd0EgFeIoW9yMNHLSAHYYUVKqxyT?=
 =?us-ascii?Q?+XGsyR2c6/7tNRukCshx4Z/GHz7BRV2hzhWIqfjp7p6dMim2H2UVrWz30edK?=
 =?us-ascii?Q?xXo7ohoezi3tS7BQl4pPx/MpOPng2e2v6RZXoT9E/f6Enk+XamL5YyrjkpMK?=
 =?us-ascii?Q?jZojiGBZqdTTQ1cIaOASyDVmrV5hb8h2wPwOvaAPsoNZ+TuH1qFA3nKhn2QH?=
 =?us-ascii?Q?kYvcGSRROMoW/2lHHA1up+ju2oz7SUZ8va5uuwCN3NSsJbiT+INADTS+91qY?=
 =?us-ascii?Q?kbiP8AcqSSQH1sY8oOmQg0M6EMY60sA9QCS68hERU+O9KpzKKNwbDuh4AkkH?=
 =?us-ascii?Q?soWBM2KrbTXdjk4q0/Gxok10xtIl5wDfphLXaY1LjhdO1iLbA0pLm7E9giTB?=
 =?us-ascii?Q?6g2YSJi7UIubzP2ERYrBz/yvJ5uc+V2JP387qBmK1FCZkCorrJIgFMf2RKlf?=
 =?us-ascii?Q?zR4HinIfJhsHUtSv+R00laH1pUrYdz5jnbB4beOT7VI5PNv3Vu67tsdFMED8?=
 =?us-ascii?Q?lr7O4UqKMWj2nA/TpkCntMDAuoaxKAdj96xeztoSbXCerUIHJJ55hsE/cfRN?=
 =?us-ascii?Q?JAAe/prH8UYd34q1h35eMpQN4JpsbFx8OT/9cnyxQBpPOvpVr7yHLI//tmGC?=
 =?us-ascii?Q?XMvgTcSllCCu+RO6XzwxaxCMF/LJWZR/JpNQydmvN6C/KlLQYJNUo+G1C5SU?=
 =?us-ascii?Q?9wobJ5TmddxGYTJQEyXrPkWq/lV3luiJ8rVLGoX2lNkNHLrw1vDaF4TlMRP+?=
 =?us-ascii?Q?3rUwdCuLRtJ4DrPSbL19vCd5OLCiE6L0DWdUdARPdJF/AcYEOQRyMQzYWySq?=
 =?us-ascii?Q?M+xhP7kz/icJb4fwlWsmRrV8p8kPRn+254EWGqTwOqbJhnXKvZzJgGw+KM8K?=
 =?us-ascii?Q?1tKh5cbaYWOnq0dOzfW/t89aknovZnDpeXCTBEInT5tmR7djKUyb4S3t/PjR?=
 =?us-ascii?Q?2Tf+A63Pz9BBFsK8OfTbQJ2ZpGQBYAqAUBQq248lew5aKclB3K6JJYV/PE4J?=
 =?us-ascii?Q?F55oPpR/8l6JUeoqzm1GxKCoGfMvNBcS6r3ZkKxf9DimI1IEBvblqmF+u9lc?=
 =?us-ascii?Q?CrEhYRTSVpJ7+Ja7jfm2GKc5UJ4tHg+JIKw5kNiNoKVPaSrWbD9JDKTZuIXG?=
 =?us-ascii?Q?s7PqiPr5Tp+10GftzpxWHhgsQdzI3wgeRAqA48hB+B86mzzh6+xxLZuHwY0/?=
 =?us-ascii?Q?26cKmz3Rv3q7WOethTFQujFEd8h7rZnJS7yU3+IRVor7Z9wetYPDqeYRn0is?=
 =?us-ascii?Q?pANHc7PXSCemYEfxLr4SgjqpBT04jmSe0nP2UrkdWpv9seQBmTLHqpv0Larr?=
 =?us-ascii?Q?nEvOwdKpu2hWtMzI/UrT4phjoCaPgj1x?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB5167.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+kM+uAwFYpTtD3MjMXG5o5k8wmJfGKsHqdaHnetjySvF+sxpx43xHc2Rj0+U?=
 =?us-ascii?Q?PeJGxQjtcVL5OyzewKcwmhBw913McPxfjis1Zz+jybGXkkyHktwZJZmXHuCX?=
 =?us-ascii?Q?hAMOJVNGYp5ZGNO/B3hAczypj5PHOc9p7w83CuzYOed3pE84n74qZbXns94C?=
 =?us-ascii?Q?qvbpQ8jnaDxgFZWWoq+6oZrNqs635LKVAgpT3l8VSGt2e3FpdlxUrEy1xLYT?=
 =?us-ascii?Q?L4htCsSkgoIFl57H07eFptGE2MNg8BhN6K8R+aAP1ddMeHnY4QlUOrm9mYie?=
 =?us-ascii?Q?d4PPFyE0GeFtQ8lTR7pW0VUbiwfFIzDnjcs/KphKZhcSJjrfpufh8DZzjovX?=
 =?us-ascii?Q?j2gLtFMnGkUURVUxG7P4CiAYGmGmiuoEzd1UuAxA+IxlWDbOqQrmlnwE4mE1?=
 =?us-ascii?Q?IF8Rypj+DGa+y4k0SzjAT6Mf81HA3pZITNbEERNVLflgR6HG8j/HUQM0tQJL?=
 =?us-ascii?Q?fvFJMiyvKX2/wXqtl9emBT2cdVrCruluddJJWi1VmwtY81yGID/EseEaUnrU?=
 =?us-ascii?Q?RUi+yYmr2QfFPF6IIrnAMe6MbnidiUKkcfQrX8GSUSC4NU8798bweGx7pVPa?=
 =?us-ascii?Q?qr+2UM4xRJqdz+Y8bpAU2YVP0O3ytMymkhs+BTfeFe/B9FqR5kojlwiQ5mJE?=
 =?us-ascii?Q?mI5/OeYvPi+QtcvSw1J12CIyZfn0VOInsWhdoKSi/q96KTiTEzUbmQbLyabY?=
 =?us-ascii?Q?FFgxXfUmWs8QKZDFPhrfxn+PmFwZ5O3F52EwcAEjjGlx+q8ZKMg7a3DS9u5H?=
 =?us-ascii?Q?R9nByXBQNbFaOKFa6zwzWn9/dnxiNK+AymgRC+fQxqwuoOegiV5xgZnzFoQa?=
 =?us-ascii?Q?8igrtypoivMTGCuPOeDFC0C8vTJMNtbJWYYGJK5krNf4w7JGRa/E8QQZM2NT?=
 =?us-ascii?Q?jBnKWzgUzfiAatI1EFqOklWDG/yk0813DK+JAU/0mJDgvjEXszeoi6sm1XRc?=
 =?us-ascii?Q?9o0y0sTcZU5rCz5LCw1h5bTH1wwL+DzVdClL6snDvE0iD7UzsWePBQFgs11T?=
 =?us-ascii?Q?xpKEn5qWtQHvc8aAg4CzlyDr360qq/68nZR0cS3m0kliUlySw3Nz/OMh2B/K?=
 =?us-ascii?Q?fMgRQx7l4WRQ+hFABgifbNktCmzrdGx5xoraf7YDZ60Tr2Kwfx6/jjadxBp+?=
 =?us-ascii?Q?AqCVcCvlugqMjRQNjF6BlBCUQidCXRCScnRNSFlw3/Bez4SC6KbCJK1xM7cZ?=
 =?us-ascii?Q?laV5FS5KntvdZwfawU4NRj6rENE6n3uLTMn2K9GmwiMMah8lKM6Oiq59Y8CV?=
 =?us-ascii?Q?s2TCKT1k86HGH61ukWN6EFVE5e1dc/lmKHHVE9YIAiM+tHXYVa8Ih58THyI4?=
 =?us-ascii?Q?uIrVqQc3SKgGEHyLXGPtuyT+TIzJhMGmerbykPr4LXvhaqVooR3/5OzDb7SV?=
 =?us-ascii?Q?mt5hEI1tGv8uV0uKSrieqIg/CQs7i5p7sotLX3ri8V1A08P9uV3pEsRWVnVy?=
 =?us-ascii?Q?c+zq0qRVbT29Q19E4WpVKX9ejnvOyhuSAkBjur5ydsiaaCWN8mGplw4cTVvR?=
 =?us-ascii?Q?giIjTuRcG3zIFqzvsLZAWUjT0GvJyYPNxM3uuvKKICsvcPC3+hBrcWyirIVF?=
 =?us-ascii?Q?Chl0ESeYPairIlNGDDA5oagl+Kwxu9+HhzmWJJYl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB5167.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9de571-1c97-4435-c2da-08dd55a6a277
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 14:13:53.4724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WbsCjKTLJRWjFOZZXHDTPJjxjG8iC9ztcRtv4lcKe6MZP2M0rylax4kCSAa5Wk03E60U44I+A8DstwtHkybjQwU4dy83gsCyvT226eWdjR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4297
X-Authority-Analysis: v=2.4 cv=BPRJrEQG c=1 sm=1 tr=0 ts=67bdd024 cx=c_pps
 a=PK5aExQQjalka8oDlC/sVA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=T2h4t0Lz3GQA:10 a=-AAbraWEqlQA:10
 a=M5GUcnROAAAA:8 a=i0EeH86SAAAA:8 a=8rWy6zfcAAAA:8 a=BosQwps4EP04c1zR45kA:9
 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: wH9m0CeJJbVVwa0eO7xE13PVRZCCSMWV
X-Proofpoint-ORIG-GUID: wH9m0CeJJbVVwa0eO7xE13PVRZCCSMWV
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
> From: Kommula Shiva Shankar <kshankar@marvell.com>
> Sent: Wednesday, January 29, 2025 8:07 PM
> To: Jerin Jacob <jerinj@marvell.com>; Amit Prakash Shukla
> <amitprakashs@marvell.com>; Vamsi Krishna Attunuru
> <vattunuru@marvell.com>; fengchengwen@huawei.com; dev@dpdk.org
> Cc: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>; Pavan Nikhilesh
> Bhagavatula <pbhagavatula@marvell.com>
> Subject: [PATCH RFC 3/4] doc: update prog guide to use rte_dma_op
>=20
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
>=20
> Update the documentation to replace all instances of
> rte_event_dma_adapter_op with rte_dma_op
>=20
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
> Change-Id: I0fe65d18f4601709826c11c6738cacec8991515d
> ---
>  doc/guides/prog_guide/eventdev/event_dma_adapter.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20

Acked-by: Amit Prakash Shukla <amitprakashs@marvell.com>


> diff --git a/doc/guides/prog_guide/eventdev/event_dma_adapter.rst
> b/doc/guides/prog_guide/eventdev/event_dma_adapter.rst
> index e040d89e8b..e8437a3297 100644
> --- a/doc/guides/prog_guide/eventdev/event_dma_adapter.rst
> +++ b/doc/guides/prog_guide/eventdev/event_dma_adapter.rst
> @@ -144,7 +144,7 @@ on which it enqueues events towards the DMA
> adapter using ``rte_event_enqueue_bu
>     uint32_t cap;
>     int ret;
>=20
> -   /* Fill in event info and update event_ptr with rte_event_dma_adapter=
_op
> */
> +   /* Fill in event info and update event_ptr with rte_dma_op */
>     memset(&ev, 0, sizeof(ev));
>     .
>     .
> @@ -244,11 +244,11 @@ Set event response information
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
>  In the ``RTE_EVENT_DMA_ADAPTER_OP_FORWARD`` /
> ``RTE_EVENT_DMA_ADAPTER_OP_NEW`` mode, -the application specifies the
> dmadev ID and vchan ID in ``struct rte_event_dma_adapter_op``
> +the application specifies the dmadev ID and vchan ID in ``struct
> +rte_dma_op``
>  and the event information (response information)  needed to enqueue an
> event after the DMA operation has completed.
>  The response information is specified in ``struct rte_event`` -and appen=
ded
> to the ``struct rte_event_dma_adapter_op``.
> +and appended to the ``struct rte_dma_op``.
>=20
>=20
>  Start the adapter instance
> --
> 2.43.0

