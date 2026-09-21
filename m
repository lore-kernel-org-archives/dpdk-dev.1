Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB73C982E1
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 08:39:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8625E41156;
	Mon, 21 Sep 2026 10:39:37 +0200 (CEST)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023119.outbound.protection.outlook.com
 [40.107.44.119])
 by mails.dpdk.org (Postfix) with ESMTP id A7EDE4025A;
 Mon, 21 Sep 2026 10:39:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hw/jxher1fr1OpJDmAKouq4C17h32+pSJbaCQ17m73GtDo/twYV0QZnfz55xsvY6E9qDYm2YTrHPvpB+lzIWTVLLpIb66t6aLyMkOzarBzodolNE0UNgIje0BBz6Vb75RF9mEjbcdnoch3N+JLc2tXL0cnHBZCUvGZ5p1zP0XgZkJFDWngqdidrrcOcKNdZ9DzQM9+e1lmu/1FQzUakF3Cj1DtqHBcRqZ8+3uZyUW4xRcaOh1kzdw5DoeyTZbhK02TId5Cxz2YaRoJUgZ33QqSQhYjF/fTMoyzUy0MoEhAY8B8WpRNBd/hmiE+6zrgRePmjQrplMYFIJq6RNPHyQ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:MIME-Version; 
 bh=TXucghRSb7RlOwuW3KteuPFFUPtDokygTE7g63lRWW4=;
 b=eV5VxF+hBEB9g3ss9TQkYZShwJO4oVPgC3wIsv+D90ss3NDlNGD7wweyB07DzsEl1fX5T51xptcnTS42TZYgmd9HYZ79h4pNgKqXgaJqc+AxlNccwK4nyv4OOCHG5AZ2BK5v52eslQi31tk7jN+HaoM5IGRXi4ofDfyweQ7yG+tvIx2ie0jBbSKyE+fFQSgwu1Gd4TK6hwtNE9v4AuiPoaBS2WZ+UMvJITduNvf+9yoG4+vVujUb+SFy9f165zwpkCqUyqgNHCllKYcr7C62p18DAUoGMBUtMVNlYsdT0gp0JcwqLiYJtdXokLxclnH5JAA4ne/huphRatKEvLvdYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXucghRSb7RlOwuW3KteuPFFUPtDokygTE7g63lRWW4=;
 b=GRnJKh0BUaL5HMXFh2SMlVlPjY3Kywzwv5fMtHImbP//iQpAS7EVcvfslmTp+1Zr4mLtPGE2hEiCwxC7bkBYbpRwY0ZzqR1XG1gEogVeuTIjfM3Y7nt7Qqv0Sz0I0mqivVPeHMYSYLadIwgnHGg5HQEj2Pq5WaD9bwydGqPDfV8=
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM (2603:1096:101:340::5)
 by SI3P153MB2029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:29d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.2; Mon, 21 Sep 2026 08:39:30 +0000
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e]) by SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e%6]) with mapi id 15.21.0472.000; Mon, 21 Sep 2026
 08:39:30 +0000
From: Wei Hu <weh@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Long Li <longli@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v2 03/33] bus/vmbus: fix ring buffer ordering
 on weakly ordered CPUs
Thread-Topic: [EXTERNAL] [PATCH v2 03/33] bus/vmbus: fix ring buffer ordering
 on weakly ordered CPUs
Thread-Index: AQHdSSvRxqeRfDMSEEWFNmEvhOxFvLbYtpgA
Date: Mon, 21 Sep 2026 08:39:30 +0000
Message-ID: <SE3P153MB1848B6C194BCFE69AF2A0450BB842@SE3P153MB1848.APCP153.PROD.OUTLOOK.COM>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
 <20260920181347.747210-4-stephen@networkplumber.org>
In-Reply-To: <20260920181347.747210-4-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1adfaa95-59da-49a1-ad1d-3230045c81c8;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-09-21T08:37:42Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3P153MB1848:EE_|SI3P153MB2029:EE_
x-ms-office365-filtering-correlation-id: 5a24a2d2-8cd9-46e7-d125-08df17bbda85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|23010399003|376014|366016|38070700021|4143699003|56012099006|11063799006|18002099003|22082099003|10067099003|7146999003;
x-microsoft-antispam-message-info: XKj2+ruC18FlvqFh9nAbl0tFMzs/dnxaJuMVi7WJWa9REEPJd4/mneLnLHZIXZEUgPfd2QqJ399flQhQnygQVI/7IlUImtTPnKGYxVHn9WGpyTjp/FAKoDFH5IN4lvjTNPuJr7cvuxjbejTrfKU8IuyGmsulvtarisyhgJnhi7/OwAXA3cjNozmjxJm8SKcjyJTDQFo62Y/ls7ve9l4RLzN9dGyXbXhcfXI8w9qGEYKoe/dFxmLiU47D1JJaaWnL4kpH2VvhWCM5O8SauUr6aIa5O4M94bnr3BtOuKC+6d5CQOarvTPXG+uFSZ/5Oq1McwG2QdArF7XxQSGfwt0tKoTUFe8nBlvEWZiRv8HoW5u7ZC+2yo9OdAFk/ACPVlOMhZ/aOoyMTXCG3JleczHlw+y+PvnNDt5D2/lupt+gekU2Q8HL+6BKHE6a9IhgbeR/YfeOW/FePwS5/n3hqfOYjyLACiGT4dQu02GGoOvAPCZO2maG9BW2V3/AUAbugloLJ3DNp1C9ypNctwS6Kso+C5Eb1j0V0bcKRtlovQOOUIKWrscP4q4cHC0RbwpFpSqSIrg/QkHy1YZBE0IMP+hnPkbid6eRpGXiofqjQVPLBaugnpvHSy/3L5/dn0jd56PMd0np2Gft48ns1T/1KK1VkRvnxMOVGCk2qep8J5Q3MJptWQ6dgY0rHhylxKs66aDBTfTDSm/DJRqJdgRf1JxHQCEV3ujQUi6cKSDlapYekhI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SE3P153MB1848.APCP153.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(23010399003)(376014)(366016)(38070700021)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003)(7146999003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oHdFtAC26dPAjqOJH+FrVrEYET61x0V8UNYdgY3g1O322BCg5ETF/t2FMv6/?=
 =?us-ascii?Q?MPrG1Nug/saaeLeqgvNwaaivPc9kjd0c8lHR3Nh8NCkXzQ2yxsrbHVVWHWd0?=
 =?us-ascii?Q?xfS5vnbMQ1TKJb2mD5wjerVxCBjoP+8xdUy3BWHzjnJuqr3hqte00JBVKKH+?=
 =?us-ascii?Q?9R6BU99HqP2i2b9Y8o2cUu+gDErV2U5XVqDvQT5/ukEs1v+IhprWD4m/0Nyb?=
 =?us-ascii?Q?VySBxX+erQJEhD8aBc3llbcLb2PCZKsqgIMjpW7HkUNPlkjPIRrOAAHMGrJH?=
 =?us-ascii?Q?EQMtDJQ7ovL6g7UomdRuY0LxS4wChFIlQHXV0w+eOw6Qf9sqv+jeC2UYjeWM?=
 =?us-ascii?Q?ylaGsjKS4glMBSBMECcFBNr3Pi0SlggPzUITdGZ5ybax4CtDqy/u8Ze8V/P2?=
 =?us-ascii?Q?1z72nPBOXsNvwyPv6eRrcukf6qOQidC2ixzw8pTrEyZSQIcSUimDaSdSASmC?=
 =?us-ascii?Q?S7DONOu49X37e7AO75m5lhoaz5/XG9bPNbuwhBnNRjD5x6Rbuw5ektn5ncyB?=
 =?us-ascii?Q?QRzKqpnWsknVnPJU8LfbVLEmtyfbl3EKwO/iFjSJxbCsq47wq/966ON/Gyeo?=
 =?us-ascii?Q?SWzrD5wqg6msGN7ujJjnpzutp6co3KRjBEPrESQPzc5LRutXfpIyKgIrbJ+9?=
 =?us-ascii?Q?FYWmWi+HPiaGt+z+AqLrzVW+isKTH8DJB0Yiuyfn23mO3OYI2cUOiZlhJ/fF?=
 =?us-ascii?Q?K9XFGNLUXKaJNF8DeGcVhp9oW+RUgT565sgdR5vKTm6Jk6ZvXg5UKJWYfTD/?=
 =?us-ascii?Q?i1q5dB6X12KPHw+lqKNThLprTkY6NLSVzSM/YWhE4AcIZi+Sh+jI1Vk3TvRi?=
 =?us-ascii?Q?QaZKH1QPTFz4e+FszU3fYQQeqJwG7h0j3KODCP9aEh2lUaT4jGHo+PYOUtHy?=
 =?us-ascii?Q?NALkaUojhks237Ed6V0cQ39kVFguiqbqEr/pzFg4T2Gb61VQz38sCh564yCn?=
 =?us-ascii?Q?BNdFUAViMoQ6o6M2GL4UQ2BTpJOxUpcjyxjwsV12w2zWGEeAauRy8ojjTQ6I?=
 =?us-ascii?Q?GkJ7Rr1R8QE/fSJeSkI50yqpnYvnhVHtVYB4dklDV72mj+pnuoJM8XqziCst?=
 =?us-ascii?Q?kPdBZJPCm3uvyvNyOAeEv+RWKwMXItTVcnOPHekw1lrVIMKxW98HmNzYajiX?=
 =?us-ascii?Q?t3p4uAPxM9jjLUQZb0Heprbbs3HyTR7bE9KgG1tV62pJcnD/SkFzQKnUpgzV?=
 =?us-ascii?Q?l3aDMiYknbnUyjlo4oPty3Jj8MA7QvuPR0v6AT+VVe/4PYU3jaLj983e+DQC?=
 =?us-ascii?Q?hQMVNplu7bvYpGMUQCqPupr6fYtriLnR3lLTa6ONUi6qnTVXYdOqRV8KN0HV?=
 =?us-ascii?Q?/8MtB5ehrnOk0x9msXGKWUKb6yGp2j4rozmf7zE7P39joChbJTG8WCWMV/5q?=
 =?us-ascii?Q?ZpnDLPbChYCsMGwOxpJAkQZ+RJdprge8i9ik0ViOoGHWEsVkFpK222BFlby7?=
 =?us-ascii?Q?058HD7Kes1IiaEpkcvW8BFCVrOk2g8w//IRas8O9AIn8mrFY40cwM0YAjHUJ?=
 =?us-ascii?Q?NalY/TFbR/a4Trp+42XcdO3/wqkXS6bMrFHRC0RaB3PPCUgmoZJWM+5KWmFw?=
 =?us-ascii?Q?doCLgyD4ggQyDWfnbciHwskw7sMFG4QUUN8K+czqRgmkodOumUuSBdnYoOy4?=
 =?us-ascii?Q?W3mVZ4jz50GnmAUhhlUlCWiGWoCa/l5VKkOPs/h0n/Z3C0DKqeQW01NiDbhM?=
 =?us-ascii?Q?CzOcX+rulZfjKz2Ua2dnZQpEnc7bbFscuhoAWcQGKPi1a3/L?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a24a2d2-8cd9-46e7-d125-08df17bbda85
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 08:39:30.2359 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v7wj9J4ag8Yq1i2jY8XZmbdRgZHWhhMfyLHEEj1ynsWFgBMXqQ6T3quHMO2+m5otk0MbJbA2WL5ICTfvJ5aapA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3P153MB2029
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday, September 21, 2026 2:10 AM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; stable@dpdk.org;
> Long Li <longli@microsoft.com>; Wei Hu <weh@microsoft.com>
> Subject: [EXTERNAL] [PATCH v2 03/33] bus/vmbus: fix ring buffer ordering =
on
> weakly ordered CPUs
>=20
> The read index update in vmbus_rxbr_read() was only protected by a compil=
er
> barrier. On a weakly ordered architecture the store of rindex can become
> visible to the host before the data copy completes, allowing the host to =
reuse
> and overwrite ring data still being read. Use a release store for the rea=
d index.
>=20
> The barrier in rte_vmbus_chan_signal_tx() must order the earlier ring ind=
ex
> update against the load of the host interrupt mask, and a write barrier d=
oes
> not order stores against loads. Use a full fence, which matches virt_mb()=
 in the
> equivalent Linux and FreeBSD code.
>=20
> Neither change affects generated code on x86.
>=20
> Fixes: 831dba47bd36 ("bus/vmbus: add Hyper-V virtual bus support")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Reviewed-by: Long Li <longli@microsoft.com>

Reviewed-by: Wei Hu <weh@microsoft.com>

> ---
>  drivers/bus/vmbus/vmbus_bufring.c | 11 +++++++----
> drivers/bus/vmbus/vmbus_channel.c |  4 ++--
>  2 files changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/bus/vmbus/vmbus_bufring.c
> b/drivers/bus/vmbus/vmbus_bufring.c
> index fcb97287dc..f622869974 100644
> --- a/drivers/bus/vmbus/vmbus_bufring.c
> +++ b/drivers/bus/vmbus/vmbus_bufring.c
> @@ -237,10 +237,13 @@ vmbus_rxbr_read(struct vmbus_br *rbr, void
> *data, size_t dlen, size_t skip)
>  	 */
>  	rindex =3D vmbus_br_idxinc(rindex, sizeof(uint64_t), br_dsize);
>=20
> -	/* Update the read index _after_ the channel packet is fetched.	 */
> -	rte_compiler_barrier();
> -
> -	vbr->rindex =3D rindex;
> +	/*
> +	 * Update the read index after the channel packet is fetched.
> +	 * Release store ensures the host can not observe the new read
> +	 * index before the data copy is complete.
> +	 */
> +	rte_atomic_store_explicit((volatile uint32_t __rte_atomic *)&vbr-
> >rindex,
> +				  rindex, rte_memory_order_release);
>=20
>  	return 0;
>  }
> diff --git a/drivers/bus/vmbus/vmbus_channel.c
> b/drivers/bus/vmbus/vmbus_channel.c
> index 6887fbad46..2648d8e3fd 100644
> --- a/drivers/bus/vmbus/vmbus_channel.c
> +++ b/drivers/bus/vmbus/vmbus_channel.c
> @@ -104,8 +104,8 @@ rte_vmbus_chan_signal_tx(struct rte_vmbus_device
> *dev, const struct vmbus_channe  {
>  	const struct vmbus_br *tbr =3D &chan->txbr;
>=20
> -	/* Make sure all updates are done before signaling host */
> -	rte_smp_wmb();
> +	/* Order ring index update before reading host interrupt mask */
> +	rte_atomic_thread_fence(rte_memory_order_seq_cst);
>=20
>  	/* If host is ignoring interrupts? */
>  	if (tbr->vbr->imask)
> --
> 2.53.0

