Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2591CC8302F
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 04:10:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA7804028C;
	Tue,  1 Jul 2025 06:10:30 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013057.outbound.protection.outlook.com [40.107.159.57])
 by mails.dpdk.org (Postfix) with ESMTP id 204B840276
 for <dev@dpdk.org>; Tue,  1 Jul 2025 06:10:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HiRivv64z1qep2Hjfc4J6krf5WYOc7Qai6cfFk22w500PHKrz4MrO7LS0khzIW9vkLXiSTgvuDsSH5aB+KhLNnan9Sq10mlVkFpxql++cKqxrSTxbGJvHSfF+poYCoCqKAUONSuE4jZtpyKFtOjT5sSzENgysgKtDNVp58Ymt4o02wlWjehDy01rxKAjewmIhlkuQ7WLrAmBAcQDjgiAiqnkCLx7oq6GrYXhrDF8dhDeI0qm2PPGybHpCPriqOKiyDCDumZQ2YPiyBWQ3COIgpaLHajHc3N+djIU/DLeyN7Ag8iGGJWOneMIxSNfsC1fLnFVH4fwbgW78RBCNi6FIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4svZT1H0VABeAuQvYTcQO8bE/i9f3HUfzAoERv9dZo=;
 b=osdJ1nznGkU7U45yWmLXtZ6CmcJ/D6c3qTUc2I1W7ghnzD+FH0nlpO+hfuW705XogJtpDT+7FoPkWMgkgRcpsN85G0i+YrTNT7H5ABg+whcb5kUsJuFiA32BHCbmUU/dn8E0Dx85CaSR3ekT1th4F5d+6/nZ7XTjowLY2E7atfEsj9tn8oVgbCc/6+BdtS2gGxqETz8Ajf5qebnzqnxjGmJR1fJnX4BZbEzFrNUC/67Yoam2Yw1z1llz7Bsm6FSMXJY2xjfHf2ZrGHSbjYdRZ460P1tPOwpSyCv8USPQztW5pJWlihAShZ5siHdV10TPSpYJRJ0YPaT++qFTVCoyPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4svZT1H0VABeAuQvYTcQO8bE/i9f3HUfzAoERv9dZo=;
 b=YaQJikpb0UlkQMKi/5ellSDjUwqffkE7T8qF6RxIp0tg7dKHuEcKN/8+3+tJx/SLtGr7/qNk0Wi+dcqXaWl7yXj3KcerEtHx9CHXl+gSW+Ofe/MWd2OkRqvB+WLnSGCqYYctsuc376Bb+KwL0EPZEmQtd4/zVuhkhEac5oFdwv5Q8KuVmOzhuo1M4b8r96gbxdWcpg1uRTyxlh1R/cl+/VVrNgHQ1hdMWuE6ZUurpDFtRdUCzHEEI0ShHry7GFKxUwLGWZ4FlTu8xUFnXT13UtbPFr5Vsll2oJkkWjaKlh1iovXnpJYnAJ9xsXveD0IBxguo+NkWLm1btoNhTbgnuA==
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM9PR04MB8907.eurprd04.prod.outlook.com (2603:10a6:20b:40a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Tue, 1 Jul
 2025 04:10:28 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8880.029; Tue, 1 Jul 2025
 04:10:28 +0000
From: Gagandeep Singh <G.Singh@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: RE: [PATCH v6 6/6] net/dpaa2: enable software taildrop for ordered
 queues
Thread-Topic: [PATCH v6 6/6] net/dpaa2: enable software taildrop for ordered
 queues
Thread-Index: AQHb6aWGm+N2oiW9c0ewKdZs86qy3rQbz2mAgADTUpA=
Date: Tue, 1 Jul 2025 04:10:28 +0000
Message-ID: <AS8PR04MB819822BAF3FA72E9C5FCA6FDE141A@AS8PR04MB8198.eurprd04.prod.outlook.com>
References: <20250613021125.790614-1-g.singh@nxp.com>
 <20250630095800.2943863-1-g.singh@nxp.com>
 <20250630095800.2943863-7-g.singh@nxp.com>
 <20250630081211.6fd6793b@hermes.local>
In-Reply-To: <20250630081211.6fd6793b@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8198:EE_|AM9PR04MB8907:EE_
x-ms-office365-filtering-correlation-id: 4b60c25f-656e-4fd4-b390-08ddb855366b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|19092799006|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?FWgtP5AFKMkSKToTAusbWalhJGWZc81yPVB3sQ9A2Fszmtw2Au9WkuCW6kp+?=
 =?us-ascii?Q?+mLCTeiC7z9tCStHXNRwY+CdUd7YA1tX0MAWMHpzmkzl9OjmEIEtRQwEA/y5?=
 =?us-ascii?Q?fbx5bRj46o6PKRcP45+BupHFVM6Ferf0rW6VnMnQTZtqxW1WxcP2HbhCNmBb?=
 =?us-ascii?Q?WHP3tCbxswZBbup5PELQKDtQmYkaP9ssiiY2x752Cogk+T8IV5qApowpO+mw?=
 =?us-ascii?Q?WeRjXG0Vcb7cVFYs40QAOAj7D1lbylTvnyxN0Bh0/xXg8P4j15NlPNACZnJT?=
 =?us-ascii?Q?ey3frkYiZELb55W+V+nXp5sQpeAcvx5zCXoKPsOQDZpNkSsPhrhjjVuBEG+J?=
 =?us-ascii?Q?3+tLYYOq3laOHGzfROQJKX/+f1EjGtNl7UVZ5hXH8ugzX/UjJn6hxFvTfAkB?=
 =?us-ascii?Q?0J+P3yU1fPpbks9TdA6o2GRxtDlfsDHYkMaE0gLAhK27XEIr7dNT0UAoo5a5?=
 =?us-ascii?Q?ww9CY4/HZ7AA+VhJa0aGDuPyDcBFndhPH4Q0wNU1FxVc3uavei8gT3q2GRMM?=
 =?us-ascii?Q?A+LguzgVWO/W+i1gD9SVUGq1pYXsigvf6hFGa/Mx5vsIo1W3JPNo7BWOQRzB?=
 =?us-ascii?Q?G0dGifNIWULt1Zdhm1NCQ/2H+8Y+VgqqtfDRpwxmkFA5DjvAHIz1xSG6hvFb?=
 =?us-ascii?Q?UisvvU5C5dbU3mOFMMKh+uq3PMCfS2QdzmCQVNpzElvX+J+bK5/u05t7lHrI?=
 =?us-ascii?Q?b25IMNMacHtdjmK1eyMwJ3DjrJt7qetZ2FAGljvZW43Qx8Rh836Jj/iKNTXL?=
 =?us-ascii?Q?NttH8hRFSH0vtWQESbD7j9KPCJ/x6cABOn4dvrezHwz0cTcI5IxDT2pzHtPg?=
 =?us-ascii?Q?uBBX6r4ky1nDC/DozZnXPBlwzjeeOzToSTmlLES5qO+YTlRCSTMzbkW7ahbg?=
 =?us-ascii?Q?RMEe+0fdPZYuAboOUnGS8xuRpaueFXpIMcxsOlwRqFV6zdeH5Gqz5dFXkaip?=
 =?us-ascii?Q?3wj4Z6DT92huY3tbF8stcUxybDu3VUTuCNVBwBPURJNjaiciyj070heeSvj9?=
 =?us-ascii?Q?83olfk8O+E6oBNRWo5H0bgDrneuO06+3Y0XSVWzmMKPRMVyLlgR9eIPRbThN?=
 =?us-ascii?Q?RjowIf0df0IoURTxbT2oDrL3bWBlFOz6VIQchplBba2cOonFf4vpKfcbHUWb?=
 =?us-ascii?Q?D1RWAeqDHZgmcFLBx8fpgv9qXT+JQsIiqFU8u94UHNlbr2EU188EtEe/ZoiK?=
 =?us-ascii?Q?BHpQ9ZSXiFt8AewvWIr+6TgjP9lYB2TCg2GKvzE8i2q5QZujhi/TRCQkRanp?=
 =?us-ascii?Q?TVp3zeVrdHEp5zgOxvEdE9815p9m2WsE3t0CgJAS7GY8dJb6wGtvCC6VsZ/q?=
 =?us-ascii?Q?CeFQA7YetqZed4U/D5V1sjI4I1gKeaoFvhW0Z2OwxUJ40zmvO44P0nYuCrlO?=
 =?us-ascii?Q?d57K3usvHM0ido+Mt4Okr/+br8qOnKfqiL7bDgiG/Ntg8FPioX5ZbNE2acba?=
 =?us-ascii?Q?fz+YxNGzMVcfn9DsOwvDZst9WLEt+oGjlE3ka3g8hVdlFK+gP0Yt40mpQIOJ?=
 =?us-ascii?Q?8wtiCkrBmFXQyiI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bAbeNMIHuwTyqN67pdYko59cERGgSNnZpjXmVUjsyG2RKim/XEbCNfULB5Ua?=
 =?us-ascii?Q?1sCJDKkGUenrqqpHaDjWmS44p6R5MYVpyfsQcKDc+o6XkR/swxyGINMbLt2T?=
 =?us-ascii?Q?Vf5T0eGb1KhBJ+Hg+c6qONWed6Nhe5euChnrzTuEws4wBGXC9cLTBf/txyLM?=
 =?us-ascii?Q?n82HpA4zfAtUImApdeovJ8l7wxdUt00DltiTxrTBjWf1+I589KrIHAJvyf7h?=
 =?us-ascii?Q?NmeI572zW8hxBriOdFOnGCXp7aQBbfnnC5k3HswuD/34DTURHqD6Labl+cYg?=
 =?us-ascii?Q?9aN1KvPqWjAwnBCbXV1OyHwGh3qeNXsh7gmwj1bfg6M1o3XluG7oJsjhKl4+?=
 =?us-ascii?Q?9/9V6lms9GoLhu1Atqll24MklhT87S6rUOliZhbMc1cHxBEvrYjJzCI7d0ZN?=
 =?us-ascii?Q?KCbbkznAyKbKtBeUsY1e/6cdsD8aCM2vNyzztbwFmrcLYffqVbElZ/bIfZ+8?=
 =?us-ascii?Q?gnvN9Qkyj/JLK84hkAPwIMKzQGrmYJ+3wZxlYfln1bt4JA7JTGDJdJDKOgT0?=
 =?us-ascii?Q?+oToRWfrgRUlWqv68XDUZ/wJw1yE+Rk+y85b0svvDk4q6IsCYVTTX0kwECrv?=
 =?us-ascii?Q?SlqgKXStlatlF3+n3qomCpr3Hf8BTh0nAmWHS7KWatfhdkLJoXV6p4X44PrB?=
 =?us-ascii?Q?dq9+AK5GawqFGIOSL2yQqS1Rnyj9QKQX5GZAmYDGlk4wexL19461F6778Je3?=
 =?us-ascii?Q?PogYKnPQOxDKPnmy5BeydoigUOWR10qqTxZFpC+M9afM8zPQsApLWwg4AVKN?=
 =?us-ascii?Q?JncUW8XrZrSNOVeXyrXHsgwhQr3SZJ6GzbHZ6jratqfiRM3/5UZ6s7zU3rT3?=
 =?us-ascii?Q?3TTO6vnaqH3qTapT3eEeAztlx8RSH4IeiYLrF0mtfH1K6u07Lomjs15XCN9g?=
 =?us-ascii?Q?UPCieEoULSJQXK1tlVmS4H+eWxxNe4Q5u+dgwIxX2cMZsCeLC1Ked6QCebOZ?=
 =?us-ascii?Q?Gkv1GtagQjlK7w8KizKSDz5moku3uhYirJeQGZzLH0HFj3Vt0qYm7QTES1nz?=
 =?us-ascii?Q?29mqiViYiOdzPXK9DhSi1BdI4CnTAElmiupC8V302ZBSWBZh6eOh671V6lv7?=
 =?us-ascii?Q?c2afisQmabSkSJQ9RoAwZmWCTxJMLa2rvytdLHboHMiUWU5IsZfLaJuK3YNE?=
 =?us-ascii?Q?fvdH+LblEXXlq0z5P7EXA1AztBGx2i4eWMf6SathMlbb+Tv0x6IcXomWU1LU?=
 =?us-ascii?Q?0uNFOc49HgXB9PY6zwwSz/ok4LLhZnpp0hlvX67XLvSiGde1ZNJ7nFBF7MO0?=
 =?us-ascii?Q?fXYLeaESCGHmj3mfQMQ6c00Pbu0rj8Ew14VyVBinFBf/NuuKRKSEPEX12shw?=
 =?us-ascii?Q?v/GYof62Q0AaOoy+8KoHpDBQj48/3+zI+en39nuHIKj1fFyszqZv+Ovto9G2?=
 =?us-ascii?Q?guwB17c7qxwXo2ZAXFmtQ4u4NkrnPRxVOx/VLtWUBlDgGhoi52hx2vJClfN3?=
 =?us-ascii?Q?dYheMyT9KUamEUjcHkNqN2NPWGj4h1Dd4KclRygpG7Kbki/lNSaiVx5D68nd?=
 =?us-ascii?Q?DtyOwFzbyVz6QDg0FGQnLHSA4MXlKADczIASZ2PCUltURwohng1bvjHWgl8N?=
 =?us-ascii?Q?75a3r+rkCxY3ZMg7yY4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b60c25f-656e-4fd4-b390-08ddb855366b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2025 04:10:28.1179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tfM6Raojph3MNl+dJsQPTPqh7vxEQK68ne98NpOqNaqMD8nSZQJ661O8AAu1HyMr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8907
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

Hi,

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday, June 30, 2025 8:42 PM
> To: Gagandeep Singh <G.Singh@nxp.com>
> Cc: dev@dpdk.org; Hemant Agrawal <hemant.agrawal@nxp.com>; Sachin
> Saxena <sachin.saxena@nxp.com>
> Subject: Re: [PATCH v6 6/6] net/dpaa2: enable software taildrop for order=
ed
> queues
>=20
> On Mon, 30 Jun 2025 15:28:00 +0530
> Gagandeep Singh <g.singh@nxp.com> wrote:
>=20
> > This patch adds support for software taildrop on ordered queues in the
> > DPAA2 driver.
> > It also enables congestion notification by default on traffic
> > management (TM) queues,  which is a prerequisite for software taildrop
> > functionality.
> >
> > Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
> > ---
> >  doc/guides/rel_notes/release_25_07.rst |  1 +
> >  drivers/net/dpaa2/dpaa2_rxtx.c         | 24 ++++++++++-
> >  drivers/net/dpaa2/dpaa2_tm.c           | 60 +++++++++++++-------------
> >  3 files changed, 53 insertions(+), 32 deletions(-)
> >
> > diff --git a/doc/guides/rel_notes/release_25_07.rst
> > b/doc/guides/rel_notes/release_25_07.rst
> > index 53a1c8756d..dd8bc74946 100644
> > --- a/doc/guides/rel_notes/release_25_07.rst
> > +++ b/doc/guides/rel_notes/release_25_07.rst
> > @@ -163,6 +163,7 @@ New Features
> >  * **Updated DPAA2 ethernet driver.**
> >
> >    * Added DPBP APIs for setting mempool depletion thresholds.
> > +  * Enabled software taildrop for ordered queues.
> >
> >  Removed Items
> >  -------------
> > diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c
> > b/drivers/net/dpaa2/dpaa2_rxtx.c index 67d065bb7c..dce1da80bb
> 100644
> > --- a/drivers/net/dpaa2/dpaa2_rxtx.c
> > +++ b/drivers/net/dpaa2/dpaa2_rxtx.c
> > @@ -1800,8 +1800,11 @@ dpaa2_dev_tx_ordered(void *queue, struct
> rte_mbuf **bufs, uint16_t nb_pkts)
> >  		while (qbman_result_SCN_state(dpaa2_q->cscn)) {
> >  			retry_count++;
> >  			/* Retry for some time before giving up */
> > -			if (retry_count > CONG_RETRY_COUNT)
> > +			if (retry_count > CONG_RETRY_COUNT) {
> > +				if (dpaa2_q->tm_sw_td)
> > +					goto sw_td;
> >  				goto skip_tx;
> > +			}
> >  		}
> >
> >  		frames_to_send =3D (nb_pkts > dpaa2_eqcr_size) ?
> > @@ -1961,6 +1964,25 @@ dpaa2_dev_tx_ordered(void *queue, struct
> rte_mbuf **bufs, uint16_t nb_pkts)
> >  			rte_pktmbuf_free_seg(buf_to_free[loop].seg);
> >  	}
> >
> > +	return num_tx;
> > +sw_td:
> > +	loop =3D 0;
> > +	while (loop < num_tx) {
> > +		if (unlikely(RTE_MBUF_HAS_EXTBUF(*bufs)))
> > +			rte_pktmbuf_free(*bufs);
> > +		bufs++;
> > +		loop++;
> > +	}
>=20
> This looks like a possible bug.
> Is there a double free here if there are external buffers.
No, This while loop scanning the buffers which are already transmitted and =
freeing the external buffers. All non-external buffers will be freed by HW =
itself.
The function is already maintaining the " buf_to_free " so I will update th=
is code to free from "buf_to_free" to avoid any read from already freed buf=
fer.
Thanks.

> > +
> > +	/* free the pending buffers */
> > +	while (nb_pkts) {
> > +		rte_pktmbuf_free(*bufs);
> > +		bufs++;
> > +		nb_pkts--;
> > +		num_tx++;
> > +	}
>=20
> Why not use rte_pktmbuf_free_bulk here?
You are right, I will change it to rte_pktmbuf_free_bulk.
>=20
> > +	dpaa2_q->tx_pkts +=3D num_tx;
> > +
> >  	return num_tx;
> >  }
> >
> > diff --git a/drivers/net/dpaa2/dpaa2_tm.c
> > b/drivers/net/dpaa2/dpaa2_tm.c index dbf66c756e..36e815c356 100644
> > --- a/drivers/net/dpaa2/dpaa2_tm.c
> > +++ b/drivers/net/dpaa2/dpaa2_tm.c
> > @@ -611,41 +611,39 @@ dpaa2_tm_configure_queue(struct rte_eth_dev
> *dev, struct dpaa2_tm_node *node)
> >  	}
> >  	dpaa2_q->fqid =3D qid.fqid;
> >
> > -	/* setting congestion notification */
> > -	if (!(priv->flags & DPAA2_TX_CGR_OFF)) {
> > -		struct dpni_congestion_notification_cfg cong_notif_cfg =3D {0};
> > -
> > -		cong_notif_cfg.units =3D DPNI_CONGESTION_UNIT_FRAMES;
> > -		cong_notif_cfg.threshold_entry =3D dpaa2_q->nb_desc;
> > -		/* Notify that the queue is not congested when the data in
> > -		 * the queue is below this thershold.(90% of value)
> > -		 */
> > -		cong_notif_cfg.threshold_exit =3D (dpaa2_q->nb_desc * 9) /
> 10;
> > -		cong_notif_cfg.message_ctx =3D 0;
> > -		iova =3D DPAA2_VADDR_TO_IOVA_AND_CHECK(dpaa2_q->cscn,
> > -				sizeof(struct qbman_result));
> > -		if (iova =3D=3D RTE_BAD_IOVA) {
> > -			DPAA2_PMD_ERR("No IOMMU map for cscn(%p)",
> dpaa2_q->cscn);
> > -			return -ENOBUFS;
> > -		}
> > -		cong_notif_cfg.message_iova =3D iova;
> > -		cong_notif_cfg.dest_cfg.dest_type =3D DPNI_DEST_NONE;
> > -		cong_notif_cfg.notification_mode =3D
> > +	/* setting taildrop through congestion notification */
> > +	struct dpni_congestion_notification_cfg cong_notif_cfg =3D {0};
> > +
> > +	cong_notif_cfg.units =3D DPNI_CONGESTION_UNIT_FRAMES;
> > +	cong_notif_cfg.threshold_entry =3D dpaa2_q->nb_desc;
> > +	/* Notify that the queue is not congested when the data in
> > +	 * the queue is below this thershold.(90% of value)
> > +	 */
> > +	cong_notif_cfg.threshold_exit =3D (dpaa2_q->nb_desc * 9) / 10;
> > +	cong_notif_cfg.message_ctx =3D 0;
> > +
> > +	iova =3D DPAA2_VADDR_TO_IOVA_AND_CHECK(dpaa2_q->cscn,
> > +			sizeof(struct qbman_result));
> > +	if (iova =3D=3D RTE_BAD_IOVA) {
> > +		DPAA2_PMD_ERR("No IOMMU map for cscn(%p)", dpaa2_q-
> >cscn);
> > +		return -ENOBUFS;
> > +	}
> > +	cong_notif_cfg.message_iova =3D iova;
> > +	cong_notif_cfg.dest_cfg.dest_type =3D DPNI_DEST_NONE;
> > +	cong_notif_cfg.notification_mode =3D
> >
> 	DPNI_CONG_OPT_WRITE_MEM_ON_ENTER |
> >
> 	DPNI_CONG_OPT_WRITE_MEM_ON_EXIT |
> >
> 	DPNI_CONG_OPT_COHERENT_WRITE;
> > -		cong_notif_cfg.cg_point =3D DPNI_CP_QUEUE;
> > +	cong_notif_cfg.cg_point =3D DPNI_CP_QUEUE;
> >
> > -		ret =3D dpni_set_congestion_notification(dpni, CMD_PRI_LOW,
> > -					priv->token,
> > -					DPNI_QUEUE_TX,
> > -					((node->parent->channel_id << 8) |
> tc_id),
> > -					&cong_notif_cfg);
> > -		if (ret) {
> > -			DPAA2_PMD_ERR("Error in setting tx congestion
> notification: "
> > -				"err=3D%d", ret);
> > -			return -ret;
> > -		}
> > +	ret =3D dpni_set_congestion_notification(dpni, CMD_PRI_LOW,
> > +			priv->token, DPNI_QUEUE_TX,
> > +			((node->parent->channel_id << 8) | tc_id),
> > +			&cong_notif_cfg);
> > +	if (ret) {
> > +		DPAA2_PMD_ERR("Error in setting tx congestion notification:
> "
> > +			"err=3D%d", ret);
> > +		return -ret;
> >  	}
> >  	dpaa2_q->tm_sw_td =3D true;
> >

