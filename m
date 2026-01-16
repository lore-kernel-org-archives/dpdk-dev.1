Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFF2D4A5E2
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 02:07:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C39640651;
	Fri, 16 Jan 2026 03:07:06 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011019.outbound.protection.outlook.com
 [40.93.194.19]) by mails.dpdk.org (Postfix) with ESMTP id 8EC224014F;
 Fri, 16 Jan 2026 03:07:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQGs/Ws5AxEe4V1IQJyXdaoB/lPMQ40G+GnmtSzQ4u9sRvwkzP3oqmU467pxRMDlh6GqDwBOYBLOBDlcib9INrqc2I4YnN0k17bNukAWWgVgIymJ8DXsa9eaqnWP6Z2+59BCU85R1ub5PEPbcfsOFmVo8C1oIN6WcQf7xoAndCxtsoU0CNbtVLs1VKE+yS2Ib8yx9jTdnvNqq68kP4QU+d8zL7j9HXmC9kfUMUutuwVL6tGDIe9AUSLMYp5+ycMrNMspsdBp6lBpROqzsDcFzUYQDqndLTtYoDzR21G1QSImoD0if5nask8pjgPeH9v//VYNpphdrB+TwDEtzWo8aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W67P4r0bkfa/zwxJAGUdbi3pCcP7O4B2mDomHd3fKVg=;
 b=WOkvHCTKeCb1GumxHi2+CiAmtYigIpcGoyKNLH+O06C2WGexLLpsp97VMN96JBoaWwU5X5CPL5+EHANbbNEWBWARZ6kSvx7Su4pCXJia0UMyx9IwFiv46PLCPip0gBuHFXm7hlqexsSFYW7L4u+8lVUlT6WW1BDLRBICctYsPHUf3KQQaeKJRrr+gmaCXBx1BDr5zTkHbZWBX+7ry1CCQnAGzEtpv9ayD3ViZS6fjL6D8dia5tl8mJfyLdUVAZgVr4IfbfSnBNpVzLvOHEgONw5kKZuVVl7fayxsg8B89PcluJuRwjArr8qQxA48j1FReH46JSQtck4b0gWECC7XLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W67P4r0bkfa/zwxJAGUdbi3pCcP7O4B2mDomHd3fKVg=;
 b=tGPEukf5MyGFYDbqu3grCJ3MWtKNQu7tqHny75zgDGvabm7IxOg4vX2EtcMNB42sTLtKnfaJfZUk1rE9gr/r647LwPtE6zVL8nTi00VsXNqSXZz+a8/ECe50mm5CUOR1MWhg66L7Zesr5rGThyFF9ja+CP7ElywryQC+4UnlRJ8oIs89E5H1E/EX8y+gvSHjL68TKoTfFLStGBvLdkEPIqkQCH7jWvfhf4Jl7hET884cyfOxjcBzL5RCyobF4hleoduKQlKFQkF65F9+rQvnArWl579+TTwnpG7iok36VLswudjLfimSgjdLV9GAK7/6Ap+WzXVuPb77GP7agq088w==
Received: from BN9PR12MB5098.namprd12.prod.outlook.com (2603:10b6:408:137::8)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 02:06:59 +0000
Received: from BN9PR12MB5098.namprd12.prod.outlook.com
 ([fe80::78ba:2665:1445:6730]) by BN9PR12MB5098.namprd12.prod.outlook.com
 ([fe80::78ba:2665:1445:6730%5]) with mapi id 15.20.9520.003; Fri, 16 Jan 2026
 02:06:59 +0000
From: Chenbo Xia <chenbox@nvidia.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "david.marchand@redhat.com"
 <david.marchand@redhat.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH v2 1/3] vhost: fix virtqueue array size for control queue
Thread-Topic: [PATCH v2 1/3] vhost: fix virtqueue array size for control queue
Thread-Index: AQHchWtahlArT3DvTUez1de6SsVmI7VUDrEA
Date: Fri, 16 Jan 2026 02:06:59 +0000
Message-ID: <1BD79CB3-96A8-455F-BBEC-F5BC83629577@nvidia.com>
References: <20260114153445.2751895-1-maxime.coquelin@redhat.com>
 <20260114153445.2751895-2-maxime.coquelin@redhat.com>
In-Reply-To: <20260114153445.2751895-2-maxime.coquelin@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5098:EE_|MW5PR12MB5681:EE_
x-ms-office365-filtering-correlation-id: cddd8afa-532d-4a74-191e-08de54a3eeeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?HS68vpGRb4uKyC2Mi0Xcg6dF4zMZSATaEQcLX1s+fnspNgoPWDzAaPofN4pU?=
 =?us-ascii?Q?O4Yg1LJji427HKas4qlebWpfFRBpkbzfInMWO7bHFikMfcDKenxibV4Q6h52?=
 =?us-ascii?Q?b+jNftsExTvD44rSJvq5biukf51m9bltcBZdllOCI0SyWUYMYnuFCNvKue/7?=
 =?us-ascii?Q?8kq7of+lMZZYDt/n+BImkRHdmZJgW9leeCOtr0eJI5tUoQ3yBPOy/k+pqL1E?=
 =?us-ascii?Q?FvbLuI7D9XLRCHfxKyhrBIDF/mUTbOlhbVe5MmQot8P3Se4s3cbrqJKCzxhk?=
 =?us-ascii?Q?1PIiOvOlDeSceisIWZptm9XFmQOAp7GeUsw+KnaCfocPEUAExOwUNHyYhgR0?=
 =?us-ascii?Q?CbwL3XWNU3Z/+aT1lVerexpTp6TtggHBlajc2+AZj+Mbm4k1BceoaJ5if1Xn?=
 =?us-ascii?Q?R+M+r2cQht3q/7vsiLjJ6kSzhZn+jmV3HkccuhDzbE3QTBR/lMh5HPiiRJNa?=
 =?us-ascii?Q?hqXJ2aphxcIauv+OXt/lFtNdxzA5Tzr2hE8S0zOOtP1iFUz5jeOuro/oFt8m?=
 =?us-ascii?Q?j+Krg6SeU1AHe3wKFMxxIMW+V0zNE3kCIXo0STKahKX/3xw7e5OZgKnK7hCj?=
 =?us-ascii?Q?dY/4EC15IBIli2Qpv9jWXg9IId+oBlEy+Y62uPr66dwD7nKOgjdu8AKanPoP?=
 =?us-ascii?Q?qUL3UaXVlDOftVtOHKACYpefhpJMJYsiSISJbJvjGTxH/I8KsR/xrk9U3ZrE?=
 =?us-ascii?Q?QTNC/eKr1ZP1HZkMaxeSU0eaSL/g954NYiv7hfFR8AW5pp6xtdogEnZbgx1C?=
 =?us-ascii?Q?fmCAg5na2OwzPS6uYtTt2g5A/jBXmdmFT4Cle+nxfXvySXCg59EO0G/WDTGS?=
 =?us-ascii?Q?nTZwFT2yYQAtUSxUJtlA3AOit/tAMHl9J7otR8hdmdY1or5M0MylcBZpS4hM?=
 =?us-ascii?Q?PxQDj5vJ8D1uJf3AziG83S+Ewnaznlaqfe6jd1xdHQdxs2Br7wFf8loBzyq/?=
 =?us-ascii?Q?TCPbF0TSDh96zVkuYNoeRxP9s+a+tG0IpQRWdh4KvFU9PJgMF/frGAPKpBAy?=
 =?us-ascii?Q?G+lpngyupfc5YcvjFn9Q6Yp0UIuFhC3K1iUDCFAuOlo5hWlslLsZyTz3dJiU?=
 =?us-ascii?Q?+ClPLMHLvAeF+36lNN04Qa8YlAMn3MbyXpxqnJdEFUkp0/2uGvvMrCV460BG?=
 =?us-ascii?Q?LgGkWYzefKBG5jgt+b7Y9+xPkHr+k9pQiekoVtk2iPTsCYTPXfvcjcjF+CvI?=
 =?us-ascii?Q?FSWhPrv1d9B1mLV1X3zswO1TaFrxLCEGlLNC3BkCxtMYX8F8hZpLoVzUU5kv?=
 =?us-ascii?Q?F2xaTi2I3ACVYLF9UMoQEAHpmhn8ALj38A8cbCA8wPyJsTQB+LXXQPyuzdOs?=
 =?us-ascii?Q?ZgndH0PtjqJ1sp4AJ+O+w+pbGwnYQMQqwMeuEgBzVKsRPD7kq/tewsbaSTC8?=
 =?us-ascii?Q?OtZXYRyl4lOOoeL264e4KiJbp2Qf0ReDvLXPDStCU93YPpgSwxEWqawC+9DX?=
 =?us-ascii?Q?XpT1PJx8FY0lNcnuxG6b2LMEEdu4o9Nv9LIBJu049iIheeJH3RY64tJBq848?=
 =?us-ascii?Q?l/VSurmbqQNM8jnkohDhPQansX0k9JUkXC5iXHAsCcKzRMWgiRAnPYXWpDoG?=
 =?us-ascii?Q?ZcKHC9xL6z1D7tySOEJusTAf71Itv62l2lNYxMvxVEokn7kOMv6diaA4EzNd?=
 =?us-ascii?Q?MtaC4ilQlo633PoaijTc/WE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5098.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?070XYn6xTHwaBiGQtTHjZ3u3CDDfk+cMOhu8VY6bz3YHfbP93GIU9nhQHAFk?=
 =?us-ascii?Q?/jnzzX03H08nz/9NnL9dfsfhJZeqiOwjM3PxTZgOYoVSyl76pve1222L9MHj?=
 =?us-ascii?Q?I1FZwTNFccArRZ3GlC/hMEyvwRfavRw5AkW+Zo1RyTGsdJm1dCHsm4jPNEGi?=
 =?us-ascii?Q?m1I8ZO4uCLa1mNdnfNnR7zFVCSj7EiZW6zSQEUfXXoSXm7v+kINgYJuSQTek?=
 =?us-ascii?Q?4BcyLrMEa65qpih7wz8wxL0r8EfNve8ycqX4JEC+3h9PxS6oXzcE7/zG1b8Q?=
 =?us-ascii?Q?THPKHwLNlkdDswOk1aABMRNtCoCtnta/gbOjql4UvP/4FirNZK+UyFitaNZN?=
 =?us-ascii?Q?3c5EsFNU0hhsxZFaA1jHUAOiFNti4WnHFnVwWiYGrMTWNQ+cNImV6Q0HxJ9M?=
 =?us-ascii?Q?OGQ4BID/e55NP5Pvz8N93hRV4h+xUZy4ra9+mV5BVjc4pkHofnefyS+nPAhf?=
 =?us-ascii?Q?+7cZNVqy3J1UT//zsh66Q0rloTKujar18RWrSQ9vVaUymgm3eDU3KrQbyJkb?=
 =?us-ascii?Q?/kmrt/FdSWw+kxFn7u6IrgJ4WPfdx7eHneeZuVJFb4DKOurm5xvjlw8cf4i7?=
 =?us-ascii?Q?S/JgGmYM4J3bMASe7wjpHkjyH+6J/YNZw/9b5Q/QObcTuSlpCaXkHZDFK7lS?=
 =?us-ascii?Q?wfaXOYxyIX/9qiXmZ+o3TbxAbPIrmJehw6ozqwUAAJ8XGbS18EhIgP5Uymbo?=
 =?us-ascii?Q?oWHyUfvcgX5R1aCNeXVTT4Yy0/JcdwLX48qiKdAs7/VKqr5ZF8rklS2jq4jm?=
 =?us-ascii?Q?OmqU580AyVpLQunf4HvY9BtDrLHk25SggZYUoI5RQ82yLUvoYs1XL4smhH4g?=
 =?us-ascii?Q?gT1WKT9UGwH955OI8YMEqco3XtDuHgH4/Q0eoemTCqxwpIZ/TrFRqkU/dhKR?=
 =?us-ascii?Q?xVSaUV7VZsMHQ0thuiDCXUoed+KKyf4an+d17HEw5/bC4hEERsk+ORPaFn9o?=
 =?us-ascii?Q?GJqI7FHij0WodkN6brnFdktHhBY/G/SMW5Qt7gvUZrUljrPAzfJKoAISaSPE?=
 =?us-ascii?Q?eCLGFT0sGpZkhaR2NlsDm84ePawfKD81tPrrpFcuVZuRdpjrKXHSkZBlyMEE?=
 =?us-ascii?Q?uNBY4s9oO/RGLmb8ZZsTDQbLw+ejPOuI7/qG020oTWZwKUZA0TIFmZHk+/Fv?=
 =?us-ascii?Q?ezWEMeGUJOEHnNSh0N6B+BbRo094RcteWZuYdgOZ1CgWEWYQzzTpoNMEPPya?=
 =?us-ascii?Q?opyj1n/UXhTh2r/DTHN4SgFW/LnpY8SH1MYuBFoSpw98jBg2G3lR2+lc1oxg?=
 =?us-ascii?Q?To+MGXN+bQdFlYF14I75EDtjsgHJUPWnk6FVPneaTUIe1+RKTZLlAJB/8YM9?=
 =?us-ascii?Q?GQt70AhLU5Ym6yPKTEYS22k7ksDf3jGDioBfVjJGdWOqkCqV7vSDWJHHtj45?=
 =?us-ascii?Q?w4GYmxVV6Uu0YKnkbXqkSAIEkXKxBcbEI9r0EFyD2LW7D1irMxAkRAJFfcQU?=
 =?us-ascii?Q?L6YUHwJCXE9rMG8PxM5Z/CDu/W+9awS43EAA3V7FZvr8OZ/YTuuw4WsJtX6L?=
 =?us-ascii?Q?5QCFxgciFT/XYbL8O6GMvcTpCpCIJv9zQf0TKg7BK1O+FKM8Xy6t9fZMJ0BG?=
 =?us-ascii?Q?uG/iayh4whavvqc054X/utkTj1NVh/HnE+7HfMxFCZY1qW79TlC36ckXO1dr?=
 =?us-ascii?Q?2c0GZ6jY3Ab7MMoS7gtNOcjYBC1bwSovpi+DM2pU/oFsSRrSpH+Aul2ZU68+?=
 =?us-ascii?Q?LDZ+8RXdVv0s90/JNbED84flxaxiGpXqEsxwiL0lGjdBS8c+1LbVHwkCSZ0k?=
 =?us-ascii?Q?+aYI8W6QJw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5FCE817CFFDD394992B5A566BCC71DC4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5098.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cddd8afa-532d-4a74-191e-08de54a3eeeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 02:06:59.7418 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8tCYUla/Zv7VCrHeBUOzIWah9keFWT4cR7Yhxx5XHrBmjiHoPPI1OdDZg3l0bOk1OAbZcvZNS/aVVfBbT1r1Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681
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



> On Jan 14, 2026, at 23:34, Maxime Coquelin <maxime.coquelin@redhat.com> w=
rote:
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> When max_queue_pairs is set to VHOST_MAX_QUEUE_PAIRS (128), VDUSE
> calculates total_queues as max_queue_pairs * 2 + 1 =3D 257 to account
> for the control queue. However, the virtqueue array was sized as
> VHOST_MAX_QUEUE_PAIRS * 2, causing an out-of-bounds array access.
>=20
> Fix by defining VHOST_MAX_VRING to explicitly account for the control
> queue (VHOST_MAX_QUEUE_PAIRS * 2 + 1) and using it for the virtqueue
> array size.
>=20
> Fixes: f0a37cc6a1e2 ("vhost: add multiqueue support to VDUSE")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> Reviewed-by: David Marchand <david.marchand@redhat.com>
> ---
> lib/vhost/vhost.h | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/vhost/vhost.h b/lib/vhost/vhost.h
> index e9e71c1707..ee61f7415e 100644
> --- a/lib/vhost/vhost.h
> +++ b/lib/vhost/vhost.h
> @@ -261,8 +261,9 @@ struct vhost_async {
> };
>=20
> #define VHOST_RECONNECT_VERSION                0x0
> -#define VHOST_MAX_VRING                        0x100
> #define VHOST_MAX_QUEUE_PAIRS          0x80
> +/* Max vring count: 2 per queue pair plus 1 control queue */
> +#define VHOST_MAX_VRING                        (VHOST_MAX_QUEUE_PAIRS * =
2 + 1)
>=20
> struct __rte_cache_aligned vhost_reconnect_vring {
>        uint16_t last_avail_idx;
> @@ -501,7 +502,7 @@ struct __rte_cache_aligned virtio_net {
>=20
>        int                     extbuf;
>        int                     linearbuf;
> -       struct vhost_virtqueue  *virtqueue[VHOST_MAX_QUEUE_PAIRS * 2];
> +       struct vhost_virtqueue  *virtqueue[VHOST_MAX_VRING];
>=20
>        rte_rwlock_t    iotlb_pending_lock;
>        struct vhost_iotlb_entry *iotlb_pool;
> --
> 2.52.0
>=20

Reviewed-by: Chenbo Xia <chenbox@nvidia.com>

