Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FE0C021AB
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 06:12:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D8314028B;
	Wed, 19 Feb 2025 07:12:08 +0100 (CET)
Received: from HK2PR02CU002.outbound.protection.outlook.com
 (mail-eastasiaazon11020080.outbound.protection.outlook.com [52.101.128.80])
 by mails.dpdk.org (Postfix) with ESMTP id A6EAB4025A;
 Wed, 19 Feb 2025 07:12:07 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TuIx18GwuVc6urUjfvALLnHUZulUwMuElIuCx7FaZ0J1BwMgAj3P1S8chd6OWYGI9NC3xZEo5ViYmJSvj1jEVKreOv80FiY7pq4D/77haKC7ApLzvgEk1HZancnKDYKwHuDmB4jkV4/QnvO30GHrKL2CIIY8UgiRWgkROmg2bQUB4VtK6Qr17j2Pe2pVwan0sdF6SBkzwjM/thtqow8dlYhOI1D39ZpLwi2JMDOP5OUuDv41OEhrKDwcNZcFjeepXTW6SAxKxwQIUBsdQp7ph8DmJzBcPMI+m0fSMPrixP9zlLh0ClPWo32H5tAHZW9odi6SOf9ZwigrKDoMisKXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IU6iP3K0NSqKxrJRBBpjp/kO/H+IgMiCYWM7MMZfyBU=;
 b=SdJQUCuH6y7Ts4jc4qMyC49CQhe/ZklZM4OTNefDR2xHV+7xAIVoGzxBIg3AastDAy/2niRMceFIKpA6dCE9XQZbhlLjyODcfpJUQS5uJjB5o52xhbPy8oOia0YyijjPjzCYY8Szwn0fE/RsneazA59OJRPasGOizULx/zTKKlPk8d0kPnMkAgWIRG/nw44I/JE+wbJtiODj5KFsdmiz6U4OhLkZAp/lhTajk6oKYPrpIzUDEcK+4MDJMu1GzhygYimtKOvt9U2MR2T6LxiSB+l0Vp4PJLPQqlsAyEYrgg+PvcVdQUcdPyaZiF69oYLR1Dxkk8iWx4CvujqHmbpG7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IU6iP3K0NSqKxrJRBBpjp/kO/H+IgMiCYWM7MMZfyBU=;
 b=IxUJzwb/W3MCzhh1fHEhZ1z8Ml4fPQY6mKTGcF8eN5o+depB9cm/gc29sFeArN/IXmyfi9OhekznvHFC6m2wcXNtyF23yPtLo2o0/gvHMQRl9BwlOYlLgtlZuzGbJAeMbXudq0ofP6fv4rbwcTg80aJSk+3zbmUg3NoiFitjksM=
Received: from OSQP153MB1307.APCP153.PROD.OUTLOOK.COM (2603:1096:604:373::18)
 by OSQP153MB1084.APCP153.PROD.OUTLOOK.COM (2603:1096:604:393::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.2; Wed, 19 Feb
 2025 06:12:03 +0000
Received: from OSQP153MB1307.APCP153.PROD.OUTLOOK.COM
 ([fe80::b5b4:898a:d979:93e9]) by OSQP153MB1307.APCP153.PROD.OUTLOOK.COM
 ([fe80::b5b4:898a:d979:93e9%7]) with mapi id 15.20.8466.004; Wed, 19 Feb 2025
 06:12:03 +0000
From: Wei Hu <weh@microsoft.com>
To: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Long Li <longli@microsoft.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH] net/netvsc: add stats counters from VF
Thread-Topic: [EXTERNAL] [PATCH] net/netvsc: add stats counters from VF
Thread-Index: AQHbgkn3Ny6dgV61QkKchmNNgsH4QrNOJX0Q
Date: Wed, 19 Feb 2025 06:12:03 +0000
Message-ID: <OSQP153MB13079AEE64F785EE8EB9F75CBBC52@OSQP153MB1307.APCP153.PROD.OUTLOOK.COM>
References: <1739913199-8988-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1739913199-8988-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4d371c9d-53b4-42aa-bcab-4bcb3c4f69ce;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-02-19T06:10:54Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQP153MB1307:EE_|OSQP153MB1084:EE_
x-ms-office365-filtering-correlation-id: 6d32b622-2fa1-4b10-1c20-08dd50ac543a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3hKESFPdSyrAVyaRLf936wNaO/apbhUWDhsiQyU7yqZ5I8EqVBClcbm8n72N?=
 =?us-ascii?Q?A+oxriEjzmpVsUi7xijeTr+IJ/zE/MoJ4TM+6fYcR1rRy4pgUdr8HONZDMBm?=
 =?us-ascii?Q?n9eJb7WevXGlLd/H9mwBdyFicqoiHujjekt6XCNYwPBtjCpBaMjhhAQ9L8xG?=
 =?us-ascii?Q?sBzhs0r/au3+1knXJkFLwMMzzgihM8ORviGL2tzHGd5AFZTsUQJcQhQUIBEl?=
 =?us-ascii?Q?eh7rCZILjfQisG6rT3MN9Z+GrPTwG7xx+R+NvJWr5rKyHxFFblL2U2ygnSVt?=
 =?us-ascii?Q?MKokgiBYrXkMbQgx3IewTBcwzaI85Qoifmo2jeaACX7xu+VGUFfJ78382/Ra?=
 =?us-ascii?Q?NUYBBEn/E4LQUUFsf7Aid5kchfoBqlaZcnrPTz/sjs+wm0k6sxfQsnrgfQVi?=
 =?us-ascii?Q?VIPNe36gw46dfcyFb2zIWHbCSVFX7QUS02QgdDhch5Iztqo1yqiNTn/+2ge6?=
 =?us-ascii?Q?omBhZXZarxyQ5gwOKpfVYV/QkjnZGj71JmDArG+HrAzmss8fuJ2lHh+iGBIf?=
 =?us-ascii?Q?PG7Tr75ZS7XmZlnRuyPudJpV6oGF8tZlMU1fsP1YVq3djjDEytqtWMeezwgX?=
 =?us-ascii?Q?ua2t5rqP7sdupfGDnxgNHCfQl31HqQ4EEreKfktoGL3ZMMieDr6sxPnF5Zmw?=
 =?us-ascii?Q?dB8Nk5KIocdyom1tB19f0lodThm36IrfZXWCwpgi9RAyYBea6lBdctVfp7jV?=
 =?us-ascii?Q?V/KSB2QLgjBPG1BqSyj2Z47BMKQuF+d7ByXNifu1R/E16VXUi6cyVW40XMot?=
 =?us-ascii?Q?hmQ7g/oCKebiouqz0b59JgMICF25hZwILr1Y0qi7h0G/JntjMrHPU9K1SeWd?=
 =?us-ascii?Q?9xfebui6tZPoIKhFaIDUw8JCBS18rQAYd1+7pVhKWhtnU756DvJv4JfeuGe1?=
 =?us-ascii?Q?V/N6Vns45w+cMUkmrPjYdeaXDK6WxtDftiwE5L+jmvs6Z8GO7cG1Yk5AYviB?=
 =?us-ascii?Q?rUjaf89kLM/Re2XJjd3BQA/zSHTvQ9Qf9bG4abO+jR895QA17ixOFuGdvF+h?=
 =?us-ascii?Q?n2rGGf9l+n2DiJL/KNvv+YmiHb/W4TynVtnAWoCWJzEzkYEkb5tyBI10LgsS?=
 =?us-ascii?Q?WJ6+tMd1wNWqW5g6CoE5jNwAtWXXrfS7WuLrBYWBpImdr2sTncwcXRMteSb9?=
 =?us-ascii?Q?3LwRBtWz7oB5fcxBVnqGjNiEwL+uiqxiyW9UyngOgOPHF2adbfkSjkYDd2J8?=
 =?us-ascii?Q?dRzJ0Qn+lHRovSg1IxDAncxg5E5+hF96b/8jCIopyL35FePyG4iqsXI4vYN0?=
 =?us-ascii?Q?GJ4MEQ2qvKkO7L+GUPe5H8ViibL8hCGqZHIQiHLZu6CzslcwCDhJ39bmgrEC?=
 =?us-ascii?Q?nzUVkpQfbEjF6f0no+5oRq/DIcC+LcRs6YBhblFz8P5WYVCPPw60yrQIeaDx?=
 =?us-ascii?Q?xRbykabTmBCAsyuuxHMixoFN+QQJxDM5eXNs3MJ36Lp8VPqLX8knKee/6g3m?=
 =?us-ascii?Q?QwxzttWT0vVSmqQuSYfgBmCkmqT7BcPN?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSQP153MB1307.APCP153.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7053199007)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EWxJCYXIDWnEBHZKEInOpMHkGPOk05hqOU/hSpIK/rLf+jrLMcVO6mlJu1Ya?=
 =?us-ascii?Q?d9cnC1ddz1jcfiYZKt/r3/CWFvKHdEbYGtXZ9pLYnFgHGgsxV6Zag4uyKtA0?=
 =?us-ascii?Q?m43MOwC7hvDTROWh1RtYhMx79WacXTNce99h6Eh289qlIncWPr+zIdZxWZel?=
 =?us-ascii?Q?I/wkfQcgCdJ0JwWsetEOz/kIDJgU14vg4KObBOV+kpUHJwkHey/qjzdv2E7V?=
 =?us-ascii?Q?E/21qa0bW4T2BhZ7qhu9u2N6oqaEtK1cIgLkOq5h8OLN8O0ECdSuu3e7Fx13?=
 =?us-ascii?Q?sopWwgMe0LcsF2B6RKvor5LVOuA6JhpM1Fz9rQPpCyTwVKOB9d6fn85NzPm9?=
 =?us-ascii?Q?J6pnQaVZ6kpxBtHWjIFETlqKrnvG4iqbSGyfmLJd07UoksMZbWiqlpzO6CB2?=
 =?us-ascii?Q?jYp83Bb75+udu3jbpq3S9kOnR0F8GjGEfJ8Sn0Yw5OVle5AXeNaPzz9q0xqs?=
 =?us-ascii?Q?C8DGiw1yqBolRjl4SpMfM4AvNnirEnC7wZTu83/H3KQN8ejOf+SOYqKC30Oa?=
 =?us-ascii?Q?vuwMQ/vtGoKxLPD0ogeK1T+PdPWqGzHuFVymUH5LQ//7hI8uQBruv6kyVySq?=
 =?us-ascii?Q?ybzNhbis/iTdNE73JkLmlidr9QqhhmIaJQlSY+yfXkOFdm01izI/2w4OghwX?=
 =?us-ascii?Q?avsKXiUQ8pSu+7DwGo0TpqkQdK14yOBHd0EWRh4yskwMHHl3rhfl1UC8Wjvk?=
 =?us-ascii?Q?71I57i+E0KKLq7TqZkbuw66LWOK5sa1ALCzJG3UanZwISjo4uRutFnFshQBf?=
 =?us-ascii?Q?NDfy0HXzHGzyptP9U7tz3MxoeZmOVX2kgX1hb9nii/4a6M5AP2yDPAmg0d+Y?=
 =?us-ascii?Q?x9BlTi5hIx2767Oaoo9X+slLma4Ye8Ioc3AONxFXifCTSXQyUR4H41lScUiu?=
 =?us-ascii?Q?M6OUBN8K7HRlj9u2HY6glvH1moxrjztlK9R1XnjOVn8ha613mCkmuBzjGzVV?=
 =?us-ascii?Q?pfd7QW9F4IAm9RqQBY01DbctN+irc3LSJJmr6Sgtvx2M9M6HJT/X4rL68stA?=
 =?us-ascii?Q?DLUu50cAyGJsj7SdOoAzIU11mMt3Dm4ktHgkxeGpuDX5Q23gzID/xJG+jhEK?=
 =?us-ascii?Q?mH1ni7QJcjQt0ZT72lCbYb/TvwfOoktZ65HMH8wcC6rllSTq4+82Zo6v1NtW?=
 =?us-ascii?Q?oEBI4RGNHkm/StKwmh1fHwuiecp3ZcRAi4JTy2zprqLbYKbPUi2F5edAdLsO?=
 =?us-ascii?Q?yvrzNHK1PbTIkVUeJ6n9Q9sM+5pcRTpmbZtTdA+eFITMQlRKMj9OxFxIKvfH?=
 =?us-ascii?Q?hfQlRHuI/LUoFCcmwPK1Rd/5pj1UEs+OOBV3W5KBpUosPuu2tGrZtc2cW6hG?=
 =?us-ascii?Q?95lV2w4QY+BnsraolKLwXs6xYDt1lb7ERoZc9HH1VbrAy6Z03MZzVQtYToOF?=
 =?us-ascii?Q?RoGj56Dhku6A7HAvwTsZnp8IAA4WaI0UsP6U/c+YY95gm4uaQvaxk3/AiY2W?=
 =?us-ascii?Q?hD99F/OCWH+WYGXAICQoicCy3/6lzE0VqdDT+h/VSMza0G7asDTWgKsvupn+?=
 =?us-ascii?Q?1CYjH8BuyyR9amrDrAQg6D+1fIGfh/v5AgJk3gHrad2qswczdLmndBd3CRhU?=
 =?us-ascii?Q?7Rd7U0D7I6UcKZHtizjX71yEMG1JXY9bmpnLBXvf5V9C9wX7AB3NK9/cWZ5D?=
 =?us-ascii?Q?eg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQP153MB1307.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d32b622-2fa1-4b10-1c20-08dd50ac543a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 06:12:03.3650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ftTIaTOaTfM742wUKj3byncJ0bmiyyu6l7Nv68MP5RzYSZjyXlpwh7yc56efPKeIq4QgVx5F46tP0ZbVMLiMhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQP153MB1084
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
> From: longli@linuxonhyperv.com <longli@linuxonhyperv.com>
> Sent: Wednesday, February 19, 2025 5:13 AM
> To: Stephen Hemminger <stephen@networkplumber.org>; Wei Hu
> <weh@microsoft.com>
> Cc: dev@dpdk.org; Long Li <longli@microsoft.com>; stable@dpdk.org
> Subject: [EXTERNAL] [PATCH] net/netvsc: add stats counters from VF
>=20
> From: Long Li <longli@microsoft.com>
>=20
> The netvsc driver should add per-queue and rx_nombuf counters from VF.
>=20
> Fixes: 4e9c73e96e83 ("net/netvsc: add Hyper-V network device")
> Cc: stable@dpdk.org
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/net/netvsc/hn_ethdev.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethde=
v.c
> index 988c51928d..069d603d90 100644
> --- a/drivers/net/netvsc/hn_ethdev.c
> +++ b/drivers/net/netvsc/hn_ethdev.c
> @@ -824,8 +824,8 @@ static int hn_dev_stats_get(struct rte_eth_dev *dev,
>  		stats->oerrors +=3D txq->stats.errors;
>=20
>  		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			stats->q_opackets[i] =3D txq->stats.packets;
> -			stats->q_obytes[i] =3D txq->stats.bytes;
> +			stats->q_opackets[i] +=3D txq->stats.packets;
> +			stats->q_obytes[i] +=3D txq->stats.bytes;
>  		}
>  	}
>=20
> @@ -841,12 +841,12 @@ static int hn_dev_stats_get(struct rte_eth_dev
> *dev,
>  		stats->imissed +=3D rxq->stats.ring_full;
>=20
>  		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			stats->q_ipackets[i] =3D rxq->stats.packets;
> -			stats->q_ibytes[i] =3D rxq->stats.bytes;
> +			stats->q_ipackets[i] +=3D rxq->stats.packets;
> +			stats->q_ibytes[i] +=3D rxq->stats.bytes;
>  		}
>  	}
>=20
> -	stats->rx_nombuf =3D dev->data->rx_mbuf_alloc_failed;
> +	stats->rx_nombuf +=3D dev->data->rx_mbuf_alloc_failed;
>  	return 0;
>  }
>=20
> --
> 2.34.1

Reviewed-by: Wei Hu <weh@linux.microsoft.com>
