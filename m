Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F65CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 00:54:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 924A84025D;
	Wed, 13 Aug 2025 02:54:07 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2136.outbound.protection.outlook.com [40.107.93.136])
 by mails.dpdk.org (Postfix) with ESMTP id E859F400EF
 for <dev@dpdk.org>; Wed, 13 Aug 2025 02:54:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGI5piyR0XE17dzNAN2/AX5NlPslVJaeRAmCZ3LuGOqtAOKYvMclrY6xxyLLi8879T7WuuQfSbzhirLmRrL+DuRGvHtkJWOqYDT5yzL71qZjXjxgM/xnkYM2R0aFqiAYn9dhozf71lDqClVsYL41taBuzEkQdkYSsk51N/w/jIzrfWQ5m1rBJwSA7l+miLUcuMItiCg9OY1uhhDpIJUHfLTGQFMmmIfzEl+HxRlci8+F03mUciu/XtE0Z2YyYe4GrGsF3QlLsaAe11PsqA19x1fn2FWGUCa80EQ/uO6P/L0oHebYetZHPzeHgJTJWlyob97nyDeJJsLRR/uzB0epqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hdrSZ5zrsMNydOR56hShAnYpBboHNw9ZzdtS0iPMV8=;
 b=ehFCbgIuXemZzzoez9CD5G4n7Elz7KBCEomb4xnlCE5Eu4pr0CG29GgNclyHKUMCjjACRLwUWTi0QFqJQvS4NgGxL+9AEN2/PGuORBFeR+hpVe8BEeIt/qa0QMefdmnlOrSrUrI9BKsbIWwV1Itsuehp1uGbpJwRO73dbLN9JV3P13RfIJOpLgz1TRwA3at8UZ7zl9pegqS35kHPUggZtGpsk4LPJ6pM05EK3dFHop0z+wXzI6o0QM7Y8pXU5ri5KKOtWUbiFgDBW87nd8sUGRI5UfyJstRN7rrBA8M1gxhTE5WJTxUnCxwT+cvMm/W8/SQc4RyCey+Ng3MnzhVkVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hdrSZ5zrsMNydOR56hShAnYpBboHNw9ZzdtS0iPMV8=;
 b=O2zObCIgGu9xKIihrmLh5mkbDPO6lZX7G59MoGxidOPbD3pAOan1Ie5kqzJ01G6chUlszYoAVtI99LdHWqn5a+X6Ifpd1aPPpMTgkr8Pc5FnBj5oUNQgKFlnG2nTY+aEjDXj6DLfabsxtlYUgE7UZeKRSiXETFMg64ni5grCrqY=
Received: from DS2PR21MB5181.namprd21.prod.outlook.com (2603:10b6:8:2b8::22)
 by DS2PR21MB5279.namprd21.prod.outlook.com (2603:10b6:8:2b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.1; Wed, 13 Aug
 2025 00:54:03 +0000
Received: from DS2PR21MB5181.namprd21.prod.outlook.com
 ([fe80::ba4c:dbe3:e555:a63a]) by DS2PR21MB5181.namprd21.prod.outlook.com
 ([fe80::ba4c:dbe3:e555:a63a%6]) with mapi id 15.20.9052.000; Wed, 13 Aug 2025
 00:54:03 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "longli@linuxonhyperv.com"
 <longli@linuxonhyperv.com>
CC: Wei Hu <weh@microsoft.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [PATCH] net/netvsc: add device argument to
 configure if NUMA information on the device should be ignored
Thread-Topic: [EXTERNAL] Re: [PATCH] net/netvsc: add device argument to
 configure if NUMA information on the device should be ignored
Thread-Index: AQHcC+ooatGB/MGmWkek93gCy8dyRrRfwVeA
Date: Wed, 13 Aug 2025 00:54:03 +0000
Message-ID: <DS2PR21MB5181D2FBA5A20BC6DDFDAFEECE2AA@DS2PR21MB5181.namprd21.prod.outlook.com>
References: <1754952487-30601-1-git-send-email-longli@linuxonhyperv.com>
 <20250812173514.1faf462b@hermes.local>
In-Reply-To: <20250812173514.1faf462b@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b44e0a8e-8ab0-445a-9487-3f5385777ddc;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-08-13T00:52:46Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS2PR21MB5181:EE_|DS2PR21MB5279:EE_
x-ms-office365-filtering-correlation-id: e00ebf25-8907-436a-5c76-08ddda03e613
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?1oitvD2rw7S1t3Mcw+UhXRxvnD1nKvCpn0VOv70kpoctt3qUMcopvCo6Lyau?=
 =?us-ascii?Q?NH7Tk95vQH/SHpptozD+AHfSuEG9x8OpD+lBovA3cAaASTeYX6jGktidTFCb?=
 =?us-ascii?Q?EYWBrM7YWzZBXi7GnkldUXV44QSD1aAwACqquHurypAJfwPotNi8+Ja6EKVh?=
 =?us-ascii?Q?ElYRFrzmEHtYbrJrKcsGJ9dZRNsPEVp1dSQ20y82dhj7MB3ZVy3ggpBA+L1i?=
 =?us-ascii?Q?d9IZ/xLaKdjDSBhIBU6X7y+/J+FusybVKz5sC3PDayVOvexeZn3bgRIFUeKo?=
 =?us-ascii?Q?xE1I9afzUfeYSnetnNpQoWdgcnDYQNzqXGvLYNeVQ+4ChB5/K8ZtRO/cq0Jg?=
 =?us-ascii?Q?68OWWdsZYgo0O1dq6bCif8jP4eyjsGl7RTyWPVqZqZOulZlS0/OC5MKxyCiz?=
 =?us-ascii?Q?lkPbLAviTPHiz9fZ3Y5+8Y62DdHIuC5gYyATu3jcRawaVcez2TRU4wD9paek?=
 =?us-ascii?Q?ZiNyxEB+l/GmXchgf8y5SeBzvz3i0zI67JrO+9X4xbD/A8ft8GjF2Uk1AsZI?=
 =?us-ascii?Q?v3HoxE54so4pZMOU30tJQkyKhU+XuA85sY3jYRDdCj1IK1IoLJi1DfsaCGjh?=
 =?us-ascii?Q?j9wphWIscj4bjbA/TOSPYLtvaWXAy/7mKAmAXiWniO6AXNzaCj/jdTyBatS2?=
 =?us-ascii?Q?8yCweixVKj1MJaTUPbvROokMnDpifkncDlzij7hYaKbnYeXXFkuhmmiafL35?=
 =?us-ascii?Q?UnTyL1m/EAF3169Evu1HfKkVd8OTG2YzVyJn6pirGlac2i6kqA24S88Eh0dD?=
 =?us-ascii?Q?pOp5984OHrgVGpWYiqgBcNKEkorsWw1OIsGHLAHIYtdkIBYLfCJHmWvCPr5C?=
 =?us-ascii?Q?mZHE+z6JvTOzp95s3K5evEQKNvKVK7uvOoeYkFWFsYKZuMee6vBP1zmfn61/?=
 =?us-ascii?Q?z+/2lDg3eQTJNxcmehJwQqoRtfq/qqAEdqSd9/mKlcD4Hc134HE/bQIrViyE?=
 =?us-ascii?Q?bfj+HfA0b9I1pHQNV2PbvPCamj0htn6PH5Mif+SklPUhfkYpAncHPUGkntRR?=
 =?us-ascii?Q?YfJru2IjfLHKLQwKY49RGqNRgBGyze+t2DWsBFYzWZoeynCu25vXfw5hpkzN?=
 =?us-ascii?Q?yiUL4l6KJOCxAyuJWbRJQTW/va4cl2vRmyl75RAfPOwk9cIpcgdGPL+wky/Z?=
 =?us-ascii?Q?Z1lAnu7I2vaV9YUPvaimHMfX5zwGJZNxPsZviUkOcF73yCyAv6A1CCe44XB6?=
 =?us-ascii?Q?gyH2DuyTwqPSrxXNZjy3AN9b/guFKQxkyiOl30+A79S9FWv7eMQIIdXMoQz3?=
 =?us-ascii?Q?5zEwF2TpeBv7ya2DFgrBW0GXJx5imVf1VScTXfDU6QD0VbKg7X0l5aJmeKfE?=
 =?us-ascii?Q?0UxIIP6PVZTlKJXgUcLCMQHYqdJQEofHyyErgbyj6xNhO3CYLFiNQxod8lpU?=
 =?us-ascii?Q?pJft0udGly4g7UDpkrbXC8Dq6+X6+kszVmHD9iGPd7CSieSkwqcRy0bSP3HD?=
 =?us-ascii?Q?/wX5gU7nuQ7KQwZikfuN5NYTa0eYG2z3mT/HThc4F233qGRRzt2QIg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR21MB5181.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FpQqP3rtJ0BdiJ4WmAV/8VzlDrfrqdmBb45Mj3zxvww4UNauzxnkXDv1L3sk?=
 =?us-ascii?Q?Z1siZyQcbb+0J0oxpb0gZ9ZwhPRoWMwqyOCY4JARV4vf4sxk9dP+7BluRj5N?=
 =?us-ascii?Q?arGuaYshBFqYcrHqZ+Ahgky2hWd1ZyXklX4rAqVaghGN1TUZFdRuGZoGw50d?=
 =?us-ascii?Q?EIhMW2q98pPkR7L/+pQ7gIF5ugoSgoTjaZs5RZuH/ayHFDe2LZLWQSquAzkw?=
 =?us-ascii?Q?f4NW9qE5QhcMvP3LiTPBlK65n+ljvKgJVDW/2NW2iu+HRQ96SIA5MplP9XOO?=
 =?us-ascii?Q?DLrpmefizHroRlrWG6cOW3lsQ0KT9vIOsFXJEnyAje7SzuG4ldXMPIPihICx?=
 =?us-ascii?Q?Ivw7/r9tUzTqUJLEwtzGAvsMH4k1kTU2IpO/xi0jb2mRtfAbb0Cfl2xsGvr0?=
 =?us-ascii?Q?sSnsce4vhtLAKXCc0j4jAkacIathTm8H6evwiGw2C7voIH6rn8FMWIswfM50?=
 =?us-ascii?Q?UedB4VN++hKs5AGf7TyuQJDnSb8x3ME0H7LHIRWGR5qm5fJASTBNAjUj+fUq?=
 =?us-ascii?Q?qEkbHzQgDdxsVOy6ocMNwBSX3V7VlfIDiNE22LgbyYpRaYOwwcRK17ZHJZly?=
 =?us-ascii?Q?qTfMtzarCc7M5ZFJE84vKM4Y9ieTjaATYVpzq27e43q+RuTAGfzW6XJC32ns?=
 =?us-ascii?Q?pTCkn2RVNJcQs54HpuuXYPRjXvJJ4rk4gbmd5+1jMwLQev4Rkk1kbOGeaYN6?=
 =?us-ascii?Q?24s2OCaHJVMDwyEKZToGtJz2Lfo1WxRNmTzGJaEqqS/1NPIO8KgqWL/XS+p5?=
 =?us-ascii?Q?wonvwqKpKMmfnHx/j6ZeU4nYibbiyn3ugHQBr3VXaQH7vkoqKtzzhRUXQxBq?=
 =?us-ascii?Q?SKPfx4k+Iwt5UoaQvP0Nt8gl9QH6aXy1DbdXOX1kt6f0wOS53TE2CHSD514l?=
 =?us-ascii?Q?+w2OGscO2wQ2OX+8OEwfk4evRZ7vi36N67WSRRykBIlIfv5pRAlBPDpzKacA?=
 =?us-ascii?Q?Rq2lfS6BcShDstJ86kijp5H5YKZKHWx8rpXHJiHbmyZ71yymST5DFQTO6o9l?=
 =?us-ascii?Q?P6Vzofi89EF9RKsYvriHpDS7zH+55YMds76gg8Y2gg0mv6lIHBJyZoqN359X?=
 =?us-ascii?Q?oW7GYej/L6S7XqefTDy9yAfWaqItkP1HcJAkh89UNJAxFvj+guDq4xzcvsT/?=
 =?us-ascii?Q?ityMmIHvNnMptnsU2i0IQdvmU3ERZIhXImQ36l6ShI2VApe/ZaW/fg48zqqc?=
 =?us-ascii?Q?uckTy5jP+I/2LTWCkiljzFs9XDtfBcVkaEX6TWHIuUxxjjHg3YsXKNGf4PmD?=
 =?us-ascii?Q?E66+Yckl3NzJCE5Z0qzeI2b80K9TPGtjKPRa0MBiNzPQ0tC8bS5eFY2EDlmP?=
 =?us-ascii?Q?FPBmIZrSquaS5SDlhbqXbORmEt2uZ3yGQrIJyHGsz7X+XY7WdCfXSPHq69yn?=
 =?us-ascii?Q?d4zy/stemE4BkZ3TO1dwQlOBsbYA1JotbLcuEATF3Raym5W6yDwszitBh74E?=
 =?us-ascii?Q?wPTZlzouI0ad2HwkydNbp9oSlFABOTPYfZI+hJxEo6CuwgEqby0dWpHg/0RI?=
 =?us-ascii?Q?PnhW11KeqAim6S4TbADSBlh5u6Aa8xRrzWvlcikRXDg0yWNn4qGtZ0y56f/D?=
 =?us-ascii?Q?LUmWkQV07xJ7ID9hTFt2T2s/ZVH9GNbg77iXWlx/NUc+jc53+oFQzwoddZwu?=
 =?us-ascii?Q?17yW1TKABkKYIr0JXP5mV19BozuCC2ObCt29H1OLXVPC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS2PR21MB5181.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00ebf25-8907-436a-5c76-08ddda03e613
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 00:54:03.6035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0FBeQTSdAEbQL4Onpy7yDSzbwBU66l6ZNp0dOK3eHoecn0wGzf/kI9qhBRCRaayIPYK0p48e26RRX4IFzo4q3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR21MB5279
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

> Subject: [EXTERNAL] Re: [PATCH] net/netvsc: add device argument to
> configure if NUMA information on the device should be ignored
>=20
> On Mon, 11 Aug 2025 15:48:07 -0700
> longli@linuxonhyperv.com wrote:
>=20
> > From: Long Li <longli@microsoft.com>
> >
> > In most cases, netvsc is used with a VF device. The application
> > generally runs with better performance when all the device memory is
> > allocated on VF's NUMA node, as the VF device carries most of the data
> packets.
> >
> > But sometimes netvsc may run on a different NUMA node than that of the
> VF.
> > This patches adds a device argument "numa" to allow the application to
> > configure if netvsc should be NUMA aware. The default behavior for
> > netvsc is that it is NUMA aware. Setting "numa=3D0" tells netvsc not to
> > be NUMA aware.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
>=20
> Using 0 as "not numa" seems odd because NUMA node 0 is a valid node id.
> SOCKET_ID_ANY is defined as -1 in rte_memory.h

How about using a parameter name like "numa_aware"?

>=20
> The VMBus channels are being created before the device is probed.
> And those end up being set before the probe is called.
>=20
> > @@ -126,7 +183,7 @@ eth_dev_vmbus_allocate(struct rte_vmbus_device
> *dev, size_t private_data_size)
> >  		if (private_data_size) {
> >  			eth_dev->data->dev_private =3D
> >  				rte_zmalloc_socket(name, private_data_size,
> > -						     RTE_CACHE_LINE_SIZE,
> dev->device.numa_node);
> > +						   RTE_CACHE_LINE_SIZE, dev-
> >device.numa_node);
> >  			if (!eth_dev->data->dev_private) {
> >  				PMD_DRV_LOG(NOTICE, "can not allocate
> driver data");
> >  				rte_eth_dev_release_port(eth_dev);
>=20
> No need to change indentation here. Yes alignment with paren is nicer but
> better to just focus patch on one thing.
>=20
> Maybe this should be handled in vmbus then it could get all the allocatio=
ns
> right?

Okay, I will move those to VMBUS code.

Long
