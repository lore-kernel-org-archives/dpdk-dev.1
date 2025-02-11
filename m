Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F04C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 13:16:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1D3740156;
	Tue, 11 Feb 2025 14:16:40 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
 by mails.dpdk.org (Postfix) with ESMTP id 495A240150
 for <dev@dpdk.org>; Tue, 11 Feb 2025 14:16:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lORJtsUHHzrj4Xr3nZwhqUGWmzJDy+Zus0c0mxXSnJ4TZx1W6yP6eraXuCJImJjElOir/iuo6U9yDLl1+Dtb1ck6WYXX29osBX8rY3f6xeHZIdiqf2tWn/dnJWkX26lIgBj2A1Xt9ayBAZ5oPkqM2A9d7tOpNGcn/PW0mQqP0yLP6eiXRuoDqjgnAdemZwkdQELw3fHkLbwnRibiLRdvwRR5yfXtnKRKVo3xTFfqpmzVbrOvEACLXmizPhbyxx2+QiDkTE1WtP1+x2tFMMTbFKE03lP01Y1Eg5mx1sNMcEbTg94Odw8QRVzS+zldc6ZFl/okZBEG+CuVXUlOSBEuXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7TBI8iLscbd++ikl6zJgbB4p9Olkmvo2mFurtAL5Yk=;
 b=Df1lFsQirffZD7PGDJyLx8vzso8eKpOG5FFC+jCu6XDTORXFmsCzS43+aG5zIi/UWynN9mufCT3ePyt4DO/RMkZ7EKZspPCdU2yW7YduKo0yNyrXheLYCNSVWBYNRreV610q+hNLv2K/nRYTcxpk9d7kysTIKCb+oSHkamuUO4nWe+cpHCZyoxc9Hp/+tBPk3mumBuCHuubxiKcHWkEI9SDs4V9bPapVb5I3AtbHCKJyad1o0+pF/6B/ToiNC/8UBzW2FDBwI65zTMvT2R9iWr7VSMb0X8/w5oTXPZ/uvNOTLOrQs3Dl6zti5G+lQ4/iFWQJTysvmSt4xEj47Ld7Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7TBI8iLscbd++ikl6zJgbB4p9Olkmvo2mFurtAL5Yk=;
 b=tiXVq3jKs3FJYYZuvbfinpIgh5xH+YJZvZhAH0wSKk5TSk3nSxWtpOeUG+2DoPpKV076N9dXHfSPUESA+6rLppmcocr/eiA0tZXJiJOLURcak1buoIatzVbNjueetZESM+nv9U9CrEhhIwtbc8lL2GaRBYcceFO2ZJXIwlpycuI=
Received: from DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:39a::20)
 by CYYPR12MB9016.namprd12.prod.outlook.com (2603:10b6:930:c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 11 Feb
 2025 13:16:37 +0000
Received: from DM4PR12MB5055.namprd12.prod.outlook.com
 ([fe80::2c56:65d9:9ce1:c415]) by DM4PR12MB5055.namprd12.prod.outlook.com
 ([fe80::2c56:65d9:9ce1:c415%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 13:16:37 +0000
From: "Sebastian, Selwin" <Selwin.Sebastian@amd.com>
To: "K.E., Jesna" <Jesna.K.e@amd.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v1] net/axgbe: support TSO
Thread-Topic: [PATCH v1] net/axgbe: support TSO
Thread-Index: AQHbbjHoIo6WxniEd0mtEBqreAyr3LNCMcCg
Date: Tue, 11 Feb 2025 13:16:36 +0000
Message-ID: <DM4PR12MB505508D5FCE334DA5DE2440F8DFD2@DM4PR12MB5055.namprd12.prod.outlook.com>
References: <20250124073020.189242-1-jesna.k.e@amd.com>
In-Reply-To: <20250124073020.189242-1-jesna.k.e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2b5e56f4-0777-4bf3-9961-1c2899bd2e94;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-11T13:15:50Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5055:EE_|CYYPR12MB9016:EE_
x-ms-office365-filtering-correlation-id: 0b7095d0-2e93-4896-fe37-08dd4a9e5065
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?0MPt8wWKT11RFqWofmSc4dhXHh7hcnsAzX9WbA6PIQ/iiWAR1mLiiWUGECrq?=
 =?us-ascii?Q?fTb0SUiWrq2D4+hBMWpcMQE8aiAYvOulnLqMuO2ugPIA7tbzJYrWVbr25Mie?=
 =?us-ascii?Q?BvOn16o/6TzZAcicA3hg6PQlYCsDXrMkTZz9jsMGkvcMDf9j9yw6kj8rbNXi?=
 =?us-ascii?Q?tESbqzuKGsfc4EdPB5k2yMxw9Ra517nuVujQpdnnwXFkESjNxjnKTZ0MLwU2?=
 =?us-ascii?Q?O5KlMkEeqqnH9OlbtLIzQVE2D3vVD9+BypKU8pIcGdKqXgHqqfnuPhNM/zRW?=
 =?us-ascii?Q?E1oCf2LFYA1m6VBdXFRFJcmmeaszj8hJHN2UA7a1IxvCiSJAhl2lhyHBmKc8?=
 =?us-ascii?Q?3pyakVnstNbnArBBWFRQY4LNMT/tmOrP69aC9gEvFWeE+YK7EFacmDy/KMhy?=
 =?us-ascii?Q?hzqGWzWi9gWNtOklIPqYwKhc3TR7/ebQ5Gx7FxlnSnNQjAKIsLwKMi14ggLb?=
 =?us-ascii?Q?45mPNtcNHxLkyBS51GoeAHq5543iQn5MsWKvNJbRNy1AsxEd3L6FEgOyHkNG?=
 =?us-ascii?Q?C/d3LbBq7vo9yx7l30W+KPqJa8yaWVv0AbtRLjOD1A1hiSL0mvCxbn3TJThe?=
 =?us-ascii?Q?CgO7GnvJRvTN5Q23G8609I1nCGEWUs3PMirGFW1NYK1Q8PRBPFWIBuMLO6Tr?=
 =?us-ascii?Q?Kom7KF/MGB2C8cPCd3s6zg58RJDxMBmRge8gZgMzsY/BQoE6fsge9pQTK+oj?=
 =?us-ascii?Q?Mpgwqlt1yUYS8m0dbv9th85HN3MKypikbB3qopZA6e0ircj2iXZLR0yhjQJk?=
 =?us-ascii?Q?gJhusnNF/82SkUnxZAYW2iK7kS5e6nPfckZe8BZkkRa8aJFt5xtG6Wyqn7cL?=
 =?us-ascii?Q?qHYqNP1TxwZjV8AJ97Js45jehuVfih6rz3xy7tGZBcVforXkYWarTpPQ7kX5?=
 =?us-ascii?Q?a5IVi+uX/kRCPHlupKYcuG/jKak+MBI1K7SIQmIt1dkaMNQoDd32GHM1AMkd?=
 =?us-ascii?Q?SWmzxU0lxeeP7csmOlFm1cz2+oASCvSfl+q0mffvZjUuXc7nBRNqmedumv7S?=
 =?us-ascii?Q?/KJdfK215IfdcljbOA+ClM7g5k6HRXBIw9m5PyTjpJ5EHwU/cE7/LLRObUx1?=
 =?us-ascii?Q?WSVs0JnpxoXwwSqNEtQAHQ7DzgFrCK9UgV6eWkYJo8ot5rAYq91UMJcoShMI?=
 =?us-ascii?Q?o4bo9L5IMYw6Dd2r+iJI00i8LxiQeXlO66ZL2m82QL0I1exEOmTAljrGmqQk?=
 =?us-ascii?Q?G7zQA2JlCqVesZzIFpKzFyhODNK6zKLcGTHxZAkKa/owsjSGjf//NHdxyLqq?=
 =?us-ascii?Q?6UtBTBOPq+sYrpBhGHcncXGpyhmpvxh1HToJ70tEe5jE8f5k388vGFITYxli?=
 =?us-ascii?Q?nKAgA1Lx8IEyngHPZ6SkCYfHfnOrp58zgeo/y21qJETX6lANZETU1LDP36ou?=
 =?us-ascii?Q?3YcR+Q74bsg3BnLQjeReOqNGuvapVDLiHYTeYQEzBu/SGGKRhXB27XDOft+v?=
 =?us-ascii?Q?SiIT+N2xRbtIcuWfeSIQfxc+LJYR4ats?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5055.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wd1elpjQB07oI21gqx3MPOD6isyXppGKDOqN7uHCEM11YXpb6i/J1KvKgEmh?=
 =?us-ascii?Q?7OWNNnl8t2xQBWE+ZDRMM+AH5dkpoPrt6TIyiGGUqZPHNyqZsoZvMtHF66AM?=
 =?us-ascii?Q?O7UmyOzZ3L69dp6EugA+HyAAhjqfnqXUSc3O2VnBM3N8dXk6C/3aMn6dMffM?=
 =?us-ascii?Q?4hI/mtiKp1c4J1fvjrFMbfSKaKo0vijVyZEYbFkdjSCxuDBkuQoAI3Y/GxnU?=
 =?us-ascii?Q?CAEPwWq0KFs4YR+hkKpDZDUx4/qKhySw3Bz2YoSByVe5dIgax2PvSnOifQZM?=
 =?us-ascii?Q?hjWVna1NvMsMMVyNa6uRrvpsvS+An8jNK7rnZVCXN2TX+8gv9S3iBIMNrDqC?=
 =?us-ascii?Q?fhYw6Z20uY2/6UWoOs+LJo3HHJ0JCsHUFfQtasS40k4eAva2GUVfPwA1tUi9?=
 =?us-ascii?Q?uvXKHeU6vR3HwEU2gOVaO81XnOlmHRmVdTN3JY71EsHe+fi9vJjus9twlmut?=
 =?us-ascii?Q?iX5NC+/DQJHGekVdIbul+fiCoBrpuQ6dIRjRPXyq/cO98v4HAKSNIdUCzj+Y?=
 =?us-ascii?Q?bSI+HSHsZy1A+rcjD+QKbGNzkrApWyH3aoWv01X5Fw37JS7I8V9QqbmGiPCC?=
 =?us-ascii?Q?QnsS+cjOzlHMxxrb6H8s/jco7FuGSCm1aYHtv2btCANFAsWA5XQ50xXdliJS?=
 =?us-ascii?Q?Hy8ZDEGqMwNu0coEsTNwYmzDFksFTHJBBDcXiS0+OktISfXGQJk6qnHgE2/q?=
 =?us-ascii?Q?FCni2jkMXx2hAULgT9mD3KOq0XrWdbQtE3NEnO5yBg0fbwvMcZH8FXUZctZU?=
 =?us-ascii?Q?xToML3W9uUnB58ssRaw4mLb3Fr16x1seD2v6k+szJ8ZuuUUUC+qZvlrsXVbT?=
 =?us-ascii?Q?DPXubqVbbDBPsYU2SEMRvpbLQ9r9STeMU9NVFCSAM9LtJPbKu65qznBrkd9C?=
 =?us-ascii?Q?92jCvtXyw5seF1pOfbU9mw1ZGCt3dpj1zv5rZOkvI1hOOcQFOdUwL21VDV3i?=
 =?us-ascii?Q?PnWxw8I/ogWQZ/tINwUGi0Mb18iaHlOkD7bza7faRf8QVa/SKtctr0oEXqOt?=
 =?us-ascii?Q?zk8jzWcScujoepgj+dPTC24zjxLgQz2fHNdBFuP+RjqwuQM2BLA8v3gTsYzC?=
 =?us-ascii?Q?cwLiGoHBSSJlcMwFvF29Ghj8UMngWvVm/FSeclOZ+Kou6q1fh2HXKMxeS9yu?=
 =?us-ascii?Q?UTpbtUY7KMU0dhHGP2OoP2DFZENLiIBgnew3gE+aMiF3DDRGFK3zv23TdfWZ?=
 =?us-ascii?Q?BzWkSIyRuCcn3NmGGs3SB1ejf9fTZwq+rC9TFs2cusuKs99OAG4tBk8OEguB?=
 =?us-ascii?Q?RmgdJ6q543gku+t95cJar6QBIDopU+m3JwIAUR70KYw4utWdvNuXCubwE71Q?=
 =?us-ascii?Q?7FHFqZYg0qnfIS9Okx/PPrpgegAMPR08juBWMS2f1RN9j1AIr16jnQoFQqq8?=
 =?us-ascii?Q?kf8KS0GGWlBCxMiGtBUm3pAyvZZWxtYpPZY3nrzTkR5dCXTzCz+1bd5z341V?=
 =?us-ascii?Q?KmZU5em729wKUtY85+jLqtBv63FyI5zcAIPC1rogEYhUCYs6mFE9gxAtK/aP?=
 =?us-ascii?Q?zHMffDff5PBfLmSXGHL7cyMJUE1jMQ0Ymsk3p/c0HS7nZiAHdqjVCvRr7sC4?=
 =?us-ascii?Q?zAn8ozBpkJb25Rx/CHk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5055.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7095d0-2e93-4896-fe37-08dd4a9e5065
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 13:16:37.0164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yew2srX3JHQ7rjxgo0QFONVUjyUixV1jF54ZnN5BqgBMHexVvrU+f2e2X3/BzoYHjr9lJEAhwkwfFq5SCyliRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9016
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

Acked-by: Selwin Sebastian<selwin.sebastian@amd.com>

-----Original Message-----
From: K.E., Jesna <Jesna.K.e@amd.com>
Sent: Friday, January 24, 2025 1:00 PM
To: dev@dpdk.org
Cc: Sebastian, Selwin <Selwin.Sebastian@amd.com>; K.E., Jesna <Jesna.K.e@am=
d.com>
Subject: [PATCH v1] net/axgbe: support TSO

Added TSO(Transmit Segmentation offload) support for axgbe PMD.

Signed-off-by: Jesna K E <jesna.k.e@amd.com>
---
 doc/guides/nics/features/axgbe.ini |   1 +
 drivers/net/axgbe/axgbe_common.h   |  13 ++
 drivers/net/axgbe/axgbe_dev.c      |  12 ++
 drivers/net/axgbe/axgbe_ethdev.c   |   2 +
 drivers/net/axgbe/axgbe_ethdev.h   |   1 +
 drivers/net/axgbe/axgbe_rxtx.c     | 247 ++++++++++++++++++-----------
 6 files changed, 179 insertions(+), 97 deletions(-)

diff --git a/doc/guides/nics/features/axgbe.ini b/doc/guides/nics/features/=
axgbe.ini
index 5e2d6498e5..ce4a5075f4 100644
--- a/doc/guides/nics/features/axgbe.ini
+++ b/doc/guides/nics/features/axgbe.ini
@@ -7,6 +7,7 @@
 Speed capabilities   =3D Y
 Link status          =3D Y
 Scattered Rx         =3D Y
+TSO                  =3D Y
 Promiscuous mode     =3D Y
 Allmulticast mode    =3D Y
 RSS hash             =3D Y
diff --git a/drivers/net/axgbe/axgbe_common.h b/drivers/net/axgbe/axgbe_com=
mon.h
index 0e1b2c1500..93e6c177b6 100644
--- a/drivers/net/axgbe/axgbe_common.h
+++ b/drivers/net/axgbe/axgbe_common.h
@@ -161,6 +161,10 @@
 #define DMA_CH_CARBR_LO                        0x5c
 #define DMA_CH_SR                      0x60

+/* Setting MSS register entry bit positions and sizes for TSO */
+#define DMA_CH_CR_MSS_INDEX             0
+#define DMA_CH_CR_MSS_WIDTH             14
+
 /* DMA channel register entry bit positions and sizes */
 #define DMA_CH_CR_PBLX8_INDEX          16
 #define DMA_CH_CR_PBLX8_WIDTH          1
@@ -1230,6 +1234,15 @@
 #define TX_CONTEXT_DESC3_VT_INDEX              0
 #define TX_CONTEXT_DESC3_VT_WIDTH              16

+/* TSO related register entry bit positions and sizes*/
+#define TX_NORMAL_DESC3_TPL_INDEX               0
+#define TX_NORMAL_DESC3_TPL_WIDTH               18
+#define TX_NORMAL_DESC3_THL_INDEX               19
+#define TX_NORMAL_DESC3_THL_WIDTH               4
+#define TX_CONTEXT_DESC3_OSTC_INDEX             27
+#define TX_CONTEXT_DESC3_OSTC_WIDTH             1
+
+
 #define TX_NORMAL_DESC2_HL_B1L_INDEX           0
 #define TX_NORMAL_DESC2_HL_B1L_WIDTH           14
 #define TX_NORMAL_DESC2_IC_INDEX               31
diff --git a/drivers/net/axgbe/axgbe_dev.c b/drivers/net/axgbe/axgbe_dev.c =
index 9173a6fea6..634d4ee4a5 100644
--- a/drivers/net/axgbe/axgbe_dev.c
+++ b/drivers/net/axgbe/axgbe_dev.c
@@ -872,6 +872,17 @@ int axgbe_write_rss_lookup_table(struct axgbe_port *pd=
ata)
        return 0;
 }

+static void axgbe_config_tso_mode(struct axgbe_port *pdata) {
+       unsigned int i;
+       struct axgbe_tx_queue *txq;
+
+       for (i =3D 0; i < pdata->eth_dev->data->nb_tx_queues; i++) {
+               txq =3D pdata->eth_dev->data->tx_queues[i];
+               AXGMAC_DMA_IOWRITE_BITS(txq, DMA_CH_TCR, TSE, 1);
+       }
+}
+
 static int axgbe_enable_rss(struct axgbe_port *pdata)  {
        int ret;
@@ -1378,6 +1389,7 @@ static int axgbe_init(struct axgbe_port *pdata)
        axgbe_config_rx_pbl_val(pdata);
        axgbe_config_rx_buffer_size(pdata);
        axgbe_config_rss(pdata);
+       axgbe_config_tso_mode(pdata);
        wrapper_tx_desc_init(pdata);
        ret =3D wrapper_rx_desc_init(pdata);
        if (ret)
diff --git a/drivers/net/axgbe/axgbe_ethdev.c b/drivers/net/axgbe/axgbe_eth=
dev.c
index 5448a5f3d7..c42cac5b8b 100644
--- a/drivers/net/axgbe/axgbe_ethdev.c
+++ b/drivers/net/axgbe/axgbe_ethdev.c
@@ -11,6 +11,7 @@
 #include "rte_time.h"

 #include "eal_filesystem.h"
+#include <rte_vect.h>

 #include <rte_vect.h>

@@ -1241,6 +1242,7 @@ axgbe_dev_info_get(struct rte_eth_dev *dev, struct rt=
e_eth_dev_info *dev_info)
                RTE_ETH_TX_OFFLOAD_QINQ_INSERT |
                RTE_ETH_TX_OFFLOAD_IPV4_CKSUM  |
                RTE_ETH_TX_OFFLOAD_MULTI_SEGS  |
+               RTE_ETH_TX_OFFLOAD_TCP_TSO     |
                RTE_ETH_TX_OFFLOAD_UDP_CKSUM   |
                RTE_ETH_TX_OFFLOAD_TCP_CKSUM;

diff --git a/drivers/net/axgbe/axgbe_ethdev.h b/drivers/net/axgbe/axgbe_eth=
dev.h
index dd00ae8af5..5cd4317d7a 100644
--- a/drivers/net/axgbe/axgbe_ethdev.h
+++ b/drivers/net/axgbe/axgbe_ethdev.h
@@ -623,6 +623,7 @@ struct axgbe_port {
        unsigned int tx_osp_mode;
        unsigned int tx_max_fifo_size;
        unsigned int multi_segs_tx;
+       unsigned int tso_tx;

        /* Rx settings */
        unsigned int rx_sf_mode;
diff --git a/drivers/net/axgbe/axgbe_rxtx.c b/drivers/net/axgbe/axgbe_rxtx.=
c index 974ade9ab7..51a1aeb0b9 100644
--- a/drivers/net/axgbe/axgbe_rxtx.c
+++ b/drivers/net/axgbe/axgbe_rxtx.c
@@ -627,6 +627,9 @@ int axgbe_dev_tx_queue_setup(struct rte_eth_dev *dev, u=
int16_t queue_idx,
                                RTE_ETH_TX_OFFLOAD_MULTI_SEGS))
                pdata->multi_segs_tx =3D true;

+       if ((dev_data->dev_conf.txmode.offloads &
+                               RTE_ETH_TX_OFFLOAD_TCP_TSO))
+               pdata->tso_tx =3D true;

        return 0;
 }
@@ -824,26 +827,77 @@ static int axgbe_xmit_hw(struct axgbe_tx_queue *txq,
        volatile struct axgbe_tx_desc *desc;
        uint16_t idx;
        uint64_t mask;
+       int start_index;
+       uint64_t l2_len =3D 0;
+       uint64_t l3_len =3D 0;
+       uint64_t l4_len =3D 0;
+       uint64_t tso_segz =3D 0;
+       uint64_t total_hdr_len;
+       int tso =3D 0;
+
+       /*Parameters required for tso*/
+       l2_len =3D mbuf->l2_len;
+       l3_len =3D mbuf->l3_len;
+       l4_len =3D mbuf->l4_len;
+       total_hdr_len =3D l2_len + l3_len + l4_len;
+       tso_segz =3D mbuf->tso_segsz;
+
+       if (txq->pdata->tso_tx)
+               tso =3D 1;
+       else
+               tso =3D 0;
+
+       AXGMAC_DMA_IOWRITE_BITS(txq, DMA_CH_CR, MSS, tso_segz);

        idx =3D AXGBE_GET_DESC_IDX(txq, txq->cur);
        desc =3D &txq->desc[idx];

-       /* Update buffer address  and length */
-       desc->baddr =3D rte_mbuf_data_iova(mbuf);
-       AXGMAC_SET_BITS_LE(desc->desc2, TX_NORMAL_DESC2, HL_B1L,
-                          mbuf->pkt_len);
-       /* Total msg length to transmit */
-       AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, FL,
-                          mbuf->pkt_len);
+       /* Saving the start index for setting the OWN bit finally */
+       start_index =3D idx;
+       if (tso) {
+               /* Update buffer address  and length */
+               desc->baddr =3D rte_mbuf_data_iova(mbuf);
+               AXGMAC_SET_BITS_LE(desc->desc2, TX_NORMAL_DESC2, HL_B1L,
+                               total_hdr_len);
+       } else {
+               /* Update buffer address  and length */
+               desc->baddr =3D rte_mbuf_data_iova(mbuf);
+               AXGMAC_SET_BITS_LE(desc->desc2, TX_NORMAL_DESC2, HL_B1L,
+                               mbuf->pkt_len);
+               /* Total msg length to transmit */
+               AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, FL,
+                               mbuf->pkt_len);
+       }
        /* Timestamp enablement check */
        if (mbuf->ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)
                AXGMAC_SET_BITS_LE(desc->desc2, TX_NORMAL_DESC2, TTSE, 1);
        rte_wmb();
        /* Mark it as First and Last Descriptor */
        AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, FD, 1);
-       AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, LD, 1);
        /* Mark it as a NORMAL descriptor */
        AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, CTXT, 0);
+       if (tso) {
+               /*Register settings for TSO*/
+               /* Enable TSO */
+               AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, TSE, 1);
+               AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, TPL,
+                               ((mbuf->pkt_len) - total_hdr_len));
+               AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, THL,
+                               (l4_len / 4));
+               rte_wmb();
+               txq->cur++;
+               idx =3D AXGBE_GET_DESC_IDX(txq, txq->cur);
+               desc =3D &txq->desc[idx];
+               desc->baddr =3D rte_mbuf_data_iova(mbuf);
+               AXGMAC_SET_BITS_LE(desc->desc2, TX_NORMAL_DESC2, HL_B1L,
+                               (mbuf->pkt_len) - total_hdr_len);
+               AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, OWN, 1);
+               AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, LD, 1);
+               /* Mark it as a NORMAL descriptor */
+               AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, CTXT, 0);
+       } else {
+               AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, LD, 1);
+       }
        /* configure h/w Offload */
        mask =3D mbuf->ol_flags & RTE_MBUF_F_TX_L4_MASK;
        if (mask =3D=3D RTE_MBUF_F_TX_TCP_CKSUM || mask =3D=3D RTE_MBUF_F_T=
X_UDP_CKSUM) @@ -867,12 +921,16 @@ static int axgbe_xmit_hw(struct axgbe_tx=
_queue *txq,
        } else {
                AXGMAC_SET_BITS_LE(desc->desc2, TX_NORMAL_DESC2, VTIR, 0x0)=
;
        }
-       rte_wmb();
-
-       /* Set OWN bit */
-       AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, OWN, 1);
-       rte_wmb();

+       if (!tso) {
+               AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, OWN, 1);
+               rte_wmb();
+       } else {
+               /* Set OWN bit for the first descriptor */
+               desc =3D &txq->desc[start_index];
+               AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, OWN, 1);
+               rte_wmb();
+       }

        /* Save mbuf */
        txq->sw_ring[idx] =3D mbuf;
@@ -899,6 +957,7 @@ axgbe_xmit_hw_seg(struct axgbe_tx_queue *txq,
        uint32_t pkt_len =3D 0;
        int nb_desc_free;
        struct rte_mbuf  *tx_pkt;
+       uint32_t tso =3D 0;

        nb_desc_free =3D txq->nb_desc - (txq->cur - txq->dirty);

@@ -909,113 +968,107 @@ axgbe_xmit_hw_seg(struct axgbe_tx_queue *txq,
                        return RTE_ETH_TX_DESC_UNAVAIL;
        }

-       idx =3D AXGBE_GET_DESC_IDX(txq, txq->cur);
-       desc =3D &txq->desc[idx];
-       /* Saving the start index for setting the OWN bit finally */
-       start_index =3D idx;
-
-       tx_pkt =3D mbuf;
-       /* Max_pkt len =3D 9018 ; need to update it according to Jumbo pkt =
size */
-       pkt_len =3D tx_pkt->pkt_len;
-
-       /* Update buffer address  and length */
-       desc->baddr =3D rte_mbuf_data_iova(tx_pkt);
-       AXGMAC_SET_BITS_LE(desc->desc2, TX_NORMAL_DESC2, HL_B1L,
-                                          tx_pkt->data_len);
-       /* Total msg length to transmit */
-       AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, FL,
-                                          tx_pkt->pkt_len);
-       /* Timestamp enablement check */
-       if (mbuf->ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)
-               AXGMAC_SET_BITS_LE(desc->desc2, TX_NORMAL_DESC2, TTSE, 1);
-
-       rte_wmb();
-       /* Mark it as First Descriptor */
-       AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, FD, 1);
-       /* Mark it as a NORMAL descriptor */
-       AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, CTXT, 0);
-       /* configure h/w Offload */
-       mask =3D mbuf->ol_flags & RTE_MBUF_F_TX_L4_MASK;
-       if (mask =3D=3D RTE_MBUF_F_TX_TCP_CKSUM || mask =3D=3D RTE_MBUF_F_T=
X_UDP_CKSUM)
-               AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, CIC, 0x3);
-       else if (mbuf->ol_flags & RTE_MBUF_F_TX_IP_CKSUM)
-               AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, CIC, 0x1);
-       rte_wmb();
+       if (txq->pdata->tso_tx)
+               tso =3D 1;
+       else
+               tso =3D 0;

-       if (mbuf->ol_flags & (RTE_MBUF_F_TX_VLAN | RTE_MBUF_F_TX_QINQ)) {
-               /* Mark it as a CONTEXT descriptor */
-               AXGMAC_SET_BITS_LE(desc->desc3, TX_CONTEXT_DESC3,
-                               CTXT, 1);
-               /* Set the VLAN tag */
-               AXGMAC_SET_BITS_LE(desc->desc3, TX_CONTEXT_DESC3,
-                               VT, mbuf->vlan_tci);
-               /* Indicate this descriptor contains the VLAN tag */
-               AXGMAC_SET_BITS_LE(desc->desc3, TX_CONTEXT_DESC3,
-                               VLTV, 1);
-               AXGMAC_SET_BITS_LE(desc->desc2, TX_NORMAL_DESC2, VTIR,
-                               TX_NORMAL_DESC2_VLAN_INSERT);
+       if (tso) {
+               axgbe_xmit_hw(txq, mbuf);
        } else {
-               AXGMAC_SET_BITS_LE(desc->desc2, TX_NORMAL_DESC2, VTIR, 0x0)=
;
-       }
-       rte_wmb();
-
-       /* Save mbuf */
-       txq->sw_ring[idx] =3D tx_pkt;
-       /* Update current index*/
-       txq->cur++;
-
-       tx_pkt =3D tx_pkt->next;
-
-       while (tx_pkt !=3D NULL) {
                idx =3D AXGBE_GET_DESC_IDX(txq, txq->cur);
                desc =3D &txq->desc[idx];
+               /* Saving the start index for setting the OWN bit finally *=
/
+               start_index =3D idx;
+               tx_pkt =3D mbuf;
+               /* Max_pkt len =3D 9018 ; need to update it according to Ju=
mbo pkt size */
+               pkt_len =3D tx_pkt->pkt_len;

                /* Update buffer address  and length */
                desc->baddr =3D rte_mbuf_data_iova(tx_pkt);
-
-               AXGMAC_SET_BITS_LE(desc->desc2,
-                               TX_NORMAL_DESC2, HL_B1L, tx_pkt->data_len);
-
+               AXGMAC_SET_BITS_LE(desc->desc2, TX_NORMAL_DESC2, HL_B1L,
+                               tx_pkt->data_len);
+               /* Total msg length to transmit */
+               AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, FL,
+                               tx_pkt->pkt_len);
+               /* Timestamp enablement check */
+               if (mbuf->ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)
+                       AXGMAC_SET_BITS_LE(desc->desc2, TX_NORMAL_DESC2, TT=
SE, 1);
                rte_wmb();
-
+               /* Mark it as First Descriptor */
+               AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, FD, 1);
                /* Mark it as a NORMAL descriptor */
                AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, CTXT, 0);
                /* configure h/w Offload */
                mask =3D mbuf->ol_flags & RTE_MBUF_F_TX_L4_MASK;
-               if (mask =3D=3D RTE_MBUF_F_TX_TCP_CKSUM ||
-                               mask =3D=3D RTE_MBUF_F_TX_UDP_CKSUM)
-                       AXGMAC_SET_BITS_LE(desc->desc3,
-                                       TX_NORMAL_DESC3, CIC, 0x3);
+               if (mask =3D=3D RTE_MBUF_F_TX_TCP_CKSUM || mask =3D=3D RTE_=
MBUF_F_TX_UDP_CKSUM)
+                       AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, CI=
C, 0x3);
                else if (mbuf->ol_flags & RTE_MBUF_F_TX_IP_CKSUM)
-                       AXGMAC_SET_BITS_LE(desc->desc3,
-                                       TX_NORMAL_DESC3, CIC, 0x1);
-
+                       AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, CI=
C, 0x1);
                rte_wmb();
-
-                /* Set OWN bit */
-               AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, OWN, 1);
+               if (mbuf->ol_flags & (RTE_MBUF_F_TX_VLAN | RTE_MBUF_F_TX_QI=
NQ)) {
+                       /* Mark it as a CONTEXT descriptor */
+                       AXGMAC_SET_BITS_LE(desc->desc3, TX_CONTEXT_DESC3,
+                                       CTXT, 1);
+                       /* Set the VLAN tag */
+                       AXGMAC_SET_BITS_LE(desc->desc3, TX_CONTEXT_DESC3,
+                                       VT, mbuf->vlan_tci);
+                       /* Indicate this descriptor contains the VLAN tag *=
/
+                       AXGMAC_SET_BITS_LE(desc->desc3, TX_CONTEXT_DESC3,
+                                       VLTV, 1);
+                       AXGMAC_SET_BITS_LE(desc->desc2, TX_NORMAL_DESC2, VT=
IR,
+                                       TX_NORMAL_DESC2_VLAN_INSERT);
+               } else {
+                       AXGMAC_SET_BITS_LE(desc->desc2, TX_NORMAL_DESC2, VT=
IR, 0x0);
+               }
                rte_wmb();
-
                /* Save mbuf */
                txq->sw_ring[idx] =3D tx_pkt;
                /* Update current index*/
                txq->cur++;
-
                tx_pkt =3D tx_pkt->next;
-       }
-
-       /* Set LD bit for the last descriptor */
-       AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, LD, 1);
-       rte_wmb();
+               while (tx_pkt !=3D NULL) {
+                       idx =3D AXGBE_GET_DESC_IDX(txq, txq->cur);
+                       desc =3D &txq->desc[idx];
+                       /* Update buffer address  and length */
+                       desc->baddr =3D rte_mbuf_data_iova(tx_pkt);
+                       AXGMAC_SET_BITS_LE(desc->desc2,
+                                       TX_NORMAL_DESC2, HL_B1L, tx_pkt->da=
ta_len);
+                       rte_wmb();
+                       /* Mark it as a NORMAL descriptor */
+                       AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, CT=
XT, 0);
+                       /* configure h/w Offload */
+                       mask =3D mbuf->ol_flags & RTE_MBUF_F_TX_L4_MASK;
+                       if (mask =3D=3D RTE_MBUF_F_TX_TCP_CKSUM ||
+                                       mask =3D=3D RTE_MBUF_F_TX_UDP_CKSUM=
)
+                               AXGMAC_SET_BITS_LE(desc->desc3,
+                                               TX_NORMAL_DESC3, CIC, 0x3);
+                       else if (mbuf->ol_flags & RTE_MBUF_F_TX_IP_CKSUM)
+                               AXGMAC_SET_BITS_LE(desc->desc3,
+                                               TX_NORMAL_DESC3, CIC, 0x1);
+                       rte_wmb();
+                       /* Set OWN bit */
+                       AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, OW=
N, 1);
+                       rte_wmb();
+                       /* Save mbuf */
+                       txq->sw_ring[idx] =3D tx_pkt;
+                       /* Update current index*/
+                       txq->cur++;
+                       tx_pkt =3D tx_pkt->next;
+               }

-       /* Update stats */
-       txq->bytes +=3D pkt_len;
+               /* Set LD bit for the last descriptor */
+               AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, LD, 1);
+               rte_wmb();

-       /* Set OWN bit for the first descriptor */
-       desc =3D &txq->desc[start_index];
-       AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, OWN, 1);
-       rte_wmb();
+               /* Update stats */
+               txq->bytes +=3D pkt_len;

+               /* Set OWN bit for the first descriptor */
+               desc =3D &txq->desc[start_index];
+               AXGMAC_SET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, OWN, 1);
+               rte_wmb();
+       }
        return 0;
 }

--
2.34.1

