Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B52C87FCB
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 03:32:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1AA240270;
	Fri,  8 Aug 2025 05:32:28 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by mails.dpdk.org (Postfix) with ESMTP id 4AAD040150;
 Fri,  8 Aug 2025 05:32:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTjhHkaR3qWQDRncoZQZFx/bWle4Pg5YncR8u48nYulPp2VBaWprQnYqzY5hWD/aXxvJtkf57a3pPY8aVlyfwjiIlT5IcBDjs5S/MLJFvOzKaOFXgsmGBGWPC88lAf/vZzyRCYtLJyw6QEymaWQ52M7Uv4IC9ij+TPSKes3sosdtd+NP0fTOkn3/FTP73lfcgCurWG6XwcgFzNEvsfSdHLFQJ/NX+jeN4Wi74zW0+OSf721BI4jeijEyoTbxr4aR0tY6+EQUu4ktL6QpnhJDeP/lX7A1sfZalpvk7Hck01LaomssAENnAKLK06ZAjXOm1Cdt8w/A33tEjtNZXUsnDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oz71w0RAy2ex59lJV7a74EtERKa+ABt7uXmWWNfh4oU=;
 b=hjlE5xLA/nAmRo+mkiLwFE83inrT36a0BPtoy1NVMvqKudNIIpFhuc8m1v3HFWq5Hlbx3d9k2PCeGMOtjDXhWjsWrUozzMeIegdSIh5Fr0KrpeuQVUAbYt+HkT3JF92rQjs3ma10huVfqX8mTF5twOfyjQkx6QxTaN6ikmVrYQFi6629XDvZ1xcHpuHkw1bJDnQnU4u28ZVbTDZlZvrAhryNkfQDPvJz1eMPxIpL7LWjUeFuYuOwPChcCCWHwhommusB9HcyFLbns87qr+EcQ++ncWmnfo4RprkU78EN7gJTvUamC5cpU9X3Y6RInuly671yP27yRixsi+qjYenMeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oz71w0RAy2ex59lJV7a74EtERKa+ABt7uXmWWNfh4oU=;
 b=xxmLkRsMbDAA0QjpR37hLgONXaCTrScO1GL3g1Omw5j6ebTHvR1p5gmeVdE/HimmCkYBBg0eUkHppV9YMGAgxVDVtj+QRlCfVXkeMbSs+fKGz2CtQKejJmMNBBks3W2tX9Nn+by1u2PgD028/ELJ9qjjgGi+DKUrAncn6n8rp38=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 03:32:20 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%2]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 03:32:20 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>, Sunil Kumar Kori
 <skori@marvell.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>, Jerin
 Jacob <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] app/graph: fix overrun error (destination buffer too
 small)
Thread-Topic: [PATCH] app/graph: fix overrun error (destination buffer too
 small)
Thread-Index: AQHcB4to6k1JPd/USEKlNt6fLamgmLRYGf9A
Date: Fri, 8 Aug 2025 03:32:20 +0000
Message-ID: <PH7PR12MB8596EB855E0097265B14B82D822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250807110640.1094029-1-14pwcse1224@uetpeshawar.edu.pk>
In-Reply-To: <20250807110640.1094029-1-14pwcse1224@uetpeshawar.edu.pk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-08T03:28:44.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|PH8PR12MB6988:EE_
x-ms-office365-filtering-correlation-id: 3027f066-2f6f-4bd3-6edb-08ddd62c2e9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?oFupjheCKXpS+v2ZKO7oidF8Dn8g/aW+cLtmlk7t3bsTLP+fAWOcRF+8r6bU?=
 =?us-ascii?Q?50aBOwlAA1ZU+PgO5PaBMOyrP45VLPka7ep2nTWfi/kHFY7vF3WdhIQhyMx3?=
 =?us-ascii?Q?WVRP++xESBBRf0xhlzLnUum6IEsqXSI8o6gsJ32Aw9bEzjk975ZUZdqSCvNW?=
 =?us-ascii?Q?wtBso2vjHB/Qm13mVFtseAwCT28MuciDIZfA6WvkyZCqS/O+auNE5kr7vFnh?=
 =?us-ascii?Q?sZVRDWkYGKighIRhzDhEmngQiixZvKp8fnaUIdXoLjJJNH//2MshiZZuckwy?=
 =?us-ascii?Q?u+9p0THnQay+58XjyFhi/rLEHYL20LEAnN44jQsUTaTuX0ODZF3EQMeJEjNo?=
 =?us-ascii?Q?fvOFtj7m2cjAvR3CXtAmheXa9H51Hrb8dB9WXl/TtpeYqMjJUnuJ+qpLXGK/?=
 =?us-ascii?Q?pIAInWIarctIBCM6CKoWvzoveyFTrGHt/+h7XQG6cCmOamVvWlHsPxNiwTeB?=
 =?us-ascii?Q?e307Sm2QFBZ/CLb+j1D4UxlWRk3600QPTfqDJCZHE0+VhKlx36BXZWWmd/jU?=
 =?us-ascii?Q?7+UkuJM0cet8lM7UNIHGv4ONIx27j744U+kotzGIDSVtF4SDirlGGD714t4N?=
 =?us-ascii?Q?+bptOzZ1PYbYBT5ZrBhD4qPOFrMhltwi5CjNAczqciFn+QC7QQEP3DGbQs41?=
 =?us-ascii?Q?Dpi0Nvmem9iCOr2EzyjUTPj5x3LQ9IvR9+kUM+15bxdjNI5+HgnlCzwDJxnK?=
 =?us-ascii?Q?kWkWHhVodjDePgrx0JEG5okMtlRJBs4dDRvs5/yn1DDu1bd6oePuQ/QCuXCA?=
 =?us-ascii?Q?ri5G8Usb6vKj2t2kLkxIt1g1lbBYyfKxd6OfYe8nqOaLCWSIuqoq2+OcOwkL?=
 =?us-ascii?Q?x9RN8gHugHkvKtPHP93gQmFyv6cenYgqPM1ANq5UpkPwIXYOrucl0CUIbieB?=
 =?us-ascii?Q?L1HZvy9Q0Ir++QKKJRJio+Pm14pZdsi87qRbPlpCU2wJWr254potHjegvLTj?=
 =?us-ascii?Q?sSAimVtNVoJkcYKkb805uhxMDFvFYB+aG+ZQKVg0W7npho8m11SGmXrYHBNv?=
 =?us-ascii?Q?0aBo5hAx79fiinqRRBKJbudpdKsafLmjM1DRADqdpQafItM8xTcG648CqY8j?=
 =?us-ascii?Q?vXh2lO/Nk1MUAjUoi08d1HVY95Kx1JOR1DIqEU1Xo9+MIShKJCKLgV5GRGGM?=
 =?us-ascii?Q?P9yjhkKJLp1owsQVq840+wuuTPBZTEwIFN85cd7QSYKlnwkrX1fjVmbJnNyC?=
 =?us-ascii?Q?qSd6AUpvipKl0+OrhCYC6M5unWdtbt9Xlz5Q/SkQedE2v1VMIRwFlnNtbWVq?=
 =?us-ascii?Q?JyWhvamc1s0rl8b2CvDWS87qrzxSrruZkY299WQcD1Ew0WUyBrrTzQB5gWWQ?=
 =?us-ascii?Q?3XMVXx1C0NKiHvTSns7IEi/fVvso6EwveBLj+9f1i/Lj7VqJPC4aOHYbIdfS?=
 =?us-ascii?Q?ntqaJtrheuJ5R8Pm2G+yO6SDYQ4KgCX1hIsvXpbZRN78czdOTTN0+h3uX0tJ?=
 =?us-ascii?Q?BluiogsbrrjSWipgAEcYDsO2lEcxSrYjnMLK6K6WyeEWI42rjNrkgbpAIf/1?=
 =?us-ascii?Q?3otdpvBU1VMELm0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f5kZ086Ea4nscg1W/bO0TOTUlpIRz+cJvq914JZxKR0xG/GEKqtHe/XefAyl?=
 =?us-ascii?Q?Jsnazj/xnUV+Jk3Oe7Rux0hE0fnUPtro3y0l6DTntFs7fHnALlRGl2mAi2hQ?=
 =?us-ascii?Q?i8NQ/+JdiKQdA1U48vbT00ryEG70x3DJV7TUhzdI8qFyYDU7/rlsf2WDCDf3?=
 =?us-ascii?Q?/2nSb867+BpAYDNBCo/NY5x1MYWk7IF8Q+bjroOuD/KV5yKefORfQslQezmR?=
 =?us-ascii?Q?QuYrT29meb41sWIP/Y9uIO48idiXYSupWrOR61kKOUwF4M7KePgcbzBXVFWq?=
 =?us-ascii?Q?rIwJM5vH95kwBUPchJkcYuvtw9QlS8T8cxe1KifBc4/s2IvwJFHjdE5/vq+h?=
 =?us-ascii?Q?xou2Q1GTJqHau0t1HQbXubW5G4X87ph3KtSJ/+kTjHoGohMsvH0owjBr8+CF?=
 =?us-ascii?Q?i7VSk3kcwi8mz/HKWH4sRdWi86O5p5l5vxv/RiD67c4kx/FJqsyl0IAiejf/?=
 =?us-ascii?Q?beIl0x/XkIaGyRUh71M/ug33Tdw69CLzu/eyYVCg50xZZ82KXdA2t2TAPCZD?=
 =?us-ascii?Q?KXSfwC8SRrPZrK6JFUBEhEcAtQxwz2gyxESlZwRjW/xURrVfo9wdWmx7Xswf?=
 =?us-ascii?Q?e4KV5abG+AXmMsm/BJXmfVpgG7uOdC62uuWo+k0LJw4ObK4SjbP285sTWozo?=
 =?us-ascii?Q?YfkOYT5MxUGAmpFpFwc9q9LGKRtUxQUcGv+MRCepBwS6BbFaGNle6Ivga1TR?=
 =?us-ascii?Q?FTXk0cS4JETauWK73zHfdarWJpPaTZ4r0zgee2t8jagOdLDRCz8VWUKiSnvO?=
 =?us-ascii?Q?7Kc1aqT6uWe3Zis3XoNeFSGeu2BK0vZ6XJ2pM0ezBjU/ZBbendyB513KoDl0?=
 =?us-ascii?Q?OrymWb3GZz6rBxtNm7KlK8tsaNmbu+nh7ZNwvXQw2tzls6t1mZAI04bPLK/k?=
 =?us-ascii?Q?qWI3AZ2STf+nBkRp3NhJvy6/Qgn+Bf4F/ksXpgntOxWEhSy22Nxce23JZ7O2?=
 =?us-ascii?Q?+XSiPnT7jFGdUVP0gCNiGxphDZ2g3mIvfxxBAfdLNvvpNWFtq2VzD+wkXA2s?=
 =?us-ascii?Q?DpyuSkPzQQCS3y1O2PovA774laME18cupU4lFVQ5Vqm42Vf4hQDkvd32YUP2?=
 =?us-ascii?Q?H80DzWMVpW4bazD4fB3lQbiqDKPIimtrxe/Za6Zo2TwN0afxiq4nPX/Y0eEC?=
 =?us-ascii?Q?4jvG+FS9kkvWgMO+AS5ISVR6w0Q3k5Y47O4G/DMYEAdDJB3byAPu0VyHKqg4?=
 =?us-ascii?Q?AposcnhDsHGsI1Gscs0zxNcfnZM3FWJZc+ZrsK34OG4Hjbs1VqLEOZLIF8xB?=
 =?us-ascii?Q?+NO3S7gEYhKiZ9KJB5FIDs1TmDoY6D6yF94gaJY4QF+lG1t8Z4bXre5XfHpH?=
 =?us-ascii?Q?owyYRhF/h2bpftWZNMyrrviq9wbmmAQ//1xBALJqf03GdQEK/4WrfN3bdyeZ?=
 =?us-ascii?Q?Oo6eTF2UlFhTR4MIRZLiCwlPrwHVByOqzINsXzzD37R/e76K9/2guR+XdLNB?=
 =?us-ascii?Q?Yu23KRGPMmt4ZTvN+Fe5bYXoeL/2sdooqc159kUf/AtnEK0vj/k2/B0Ps2Xy?=
 =?us-ascii?Q?Yg2ZUW2+stGdhdvQ+0FCO6a1fCr8nAYgnPSV+S79tXui3QECAPiR7smOeSZv?=
 =?us-ascii?Q?9aGOeexG8XpX6u24HQ0/S3BLhOKdYWmHPg0lAJeN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3027f066-2f6f-4bd3-6edb-08ddd62c2e9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 03:32:20.5282 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iTn2euAIMcwTsoadsR/5PsCX2pqXko3OVbMpEYUwEjGSRbuKi3EhQLJezbfmCNQw8YDW0uLAKJPqYtivGkdXUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988
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

Hi Khadem,

Thank you for sharing, please find my comment below

Snipped

>
> Some memory locations will be written with incorrect values, possibly cor=
rupting
> data structures or data integrity.
> Size of destination buffer is smaller than the size argument specified.
>
> Coverity issue: 415430
> Fixes: 3850cb06ab9c ('app/graph: add ethdev commands')
> Cc: stable@dpdk.org
>
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> ---
>  app/graph/ethdev.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/app/graph/ethdev.c b/app/graph/ethdev.c index 2f4cf65c96..f6=
d4bce9ab
> 100644
> --- a/app/graph/ethdev.c
> +++ b/app/graph/ethdev.c
> @@ -663,11 +663,12 @@ cmd_ethdev_parsed(void *parsed_result, __rte_unused
> struct cmdline *cl, void *da
>         struct cmd_ethdev_result *res =3D parsed_result;
>         struct ethdev_config config;
>         int rc;
> -
> +       size_t len;
>         memset(&config, 0, sizeof(struct ethdev_config));
>         config.rx.n_queues =3D res->nb_rxq;
>         config.rx.queue_size =3D ETHDEV_RX_DESC_DEFAULT;
> -       memcpy(config.rx.mempool_name, res->mempool, strlen(res->mempool)=
);
> +       len =3D strnlen(res->mempool, sizeof(config.rx.mempool_name));
> +       memcpy(config.rx.mempool_name, res->mempool, len);

Yes indeed the strnlen is good choice. What I assume you are doing here to =
get the exact size `config.rx_mempool_size` by seeking for first `\0`. But =
the api `strnlen` intention of use is not of the same. The second argument =
is treated as maximum seek size, that is either return string len less than=
 max-size or if not found return second argument.

There will no difference in using ` strlen(res->mempool)` and ` strnlen(res=
->mempool, sizeof(config.rx.mempool_name));` in this code case.

Can you please rework and share again. Hence NACK

NACK: Vipin Varghese <Vipin.varghese@amd.com>

>
>         config.tx.n_queues =3D res->nb_txq;
>         config.tx.queue_size =3D ETHDEV_TX_DESC_DEFAULT;
> --
> 2.43.0

