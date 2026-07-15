Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C71C44501
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Jul 2026 10:29:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8D95402D3;
	Wed, 15 Jul 2026 12:29:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id D90254028B
 for <dev@dpdk.org>; Wed, 15 Jul 2026 12:29:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784111375; x=1815647375;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=hyT5pGEtj/SrflanD847SrQ5CHLtWwQynPT16tHy4lY=;
 b=jDa7OW0ql1KWd+VUkxyKnzmUMKpXAD1pSr3AWTSkq64CgCGwDaTKbSHO
 DQxTAFCr+6NU3mKIjnBr275pRAAg8dcpUaR7+7V1ZTiiUzFiQe/SiEgF+
 Iki8jA8WeXn5DE48QczVND9S9DNOZERehWVvoQsMjOBiJQBQTa5C3+05a
 QBUVVnanK46PFTjY8ZmTUej/SfXmQWozJ7clrEb/d5UastvRnJbE6/3DL
 SoD36+7YKe8vAPttnG5Bua4ZYJDv1xm+QB5m8dikyisjMkisCU4iuwdHs
 JqWlQ+Kyk9LUrZRcwYBNJ2YP2AmQsV3koGgN/noSFVQjBInOBI/9d1CwJ Q==;
X-CSE-ConnectionGUID: mgOawpYjT8KSjqCGadxTWQ==
X-CSE-MsgGUID: qFbDLSS7SUm9DJM/ZrqxtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88646833"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208,217";a="88646833"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 03:29:33 -0700
X-CSE-ConnectionGUID: YsYG8c0pTPWQRHgPdEIsjA==
X-CSE-MsgGUID: YryvRXCgRMqZhX8L59UwyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
 d="scan'208,217";a="261049812"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 03:29:33 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 03:29:33 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 03:29:33 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 03:29:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgTk7nLcfeBart/+W95jJqB+QpfuCZ33eBH8TNbzfagsbVa3nvDmd/Fw3EgDmwq6lvbfKKKo1/cd8SC+rnBwy1uQXcGRGv6gpe8lCIe6NKo8MyylkAivaspiYbA+FF5P0q7pRsWekk0rV04d8/IT5BrIu7En9b19Tx3bbQqjw0jJ9splLaDeRYG/6oQYuPO05F20//nRNfgRcrF1xeRAzrIamm91Uyu0+snTth6XsggJUtbmc22yrBeEgJKCkCaba7f6VVNT92n0+t01EyWZyuZCqmCMppyXSe6s/G8dPB02UyprAqCAGIF+U+pTrWaT3t1ORAKRvGpFXlewLKnCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnWrRtpUD6F6o2T0A1bgGfypWziCwm+QAFUpHZ0zZbQ=;
 b=YAW+2bSKv4OsaWO2W3WTMNNeNMNyGNpuCHSyf2alUgBOpzPnMPttRI6I8q9Lv2LwbsWuP98+DgGBfa5CbjU6x4JiTvV9kkdfxkKmApyWknthPOKGDX8DUi2w7UVXET9GU+VEJwZPIxDMDcasQmrAUAwQZFkuuUWFMzAJDQ12tnE8vfcFPIEDLK+xp4doNkPLwAi/1heQ3ksO8Q64+vZO/KD4r2ZpVcy8KKjWHhKfRYLOgV4y0ynagoED2jSXeTuDWthb4kgeQpVCclgezhWzVe91XKFbthfaU2inu/K6mR64vbxR38Q+PSeq2QakNeUDqW9mNAQNPnFoWV0CDEEceg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20)
 by SA1PR11MB6663.namprd11.prod.outlook.com (2603:10b6:806:257::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 10:29:28 +0000
Received: from LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae]) by LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae%4]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 10:29:28 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 "david.marchand@redhat.com" <david.marchand@redhat.com>,
 "jianjay.zhou@huawei.com" <jianjay.zhou@huawei.com>, "Jiang, YuX"
 <yux.jiang@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: Re: [PATCH v2] crypto/virtio: cookies are allocated from mempool
Thread-Topic: [PATCH v2] crypto/virtio: cookies are allocated from mempool
Thread-Index: AQHdDS4K4TZwfyio/kCYpYBWKNGFLbZubwy9
Date: Wed, 15 Jul 2026 10:29:28 +0000
Message-ID: <LV2PR11MB6045F2B5B35E1448045B866781F82@LV2PR11MB6045.namprd11.prod.outlook.com>
References: <20260703144931.2541180-1-radu.nicolau@intel.com>
 <20260706095746.2586714-2-radu.nicolau@intel.com>
In-Reply-To: <20260706095746.2586714-2-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6045:EE_|SA1PR11MB6663:EE_
x-ms-office365-filtering-correlation-id: 1627ac95-fd7a-459e-baa5-08dee25bf337
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|42112799006|6133799003|10067099003|4143699003|11063799006|56012099006|8096899003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: cT5wqUFMD1fA18Bn/3kokSsolWVTBgN2IxXYxcaqRYFrc1TfdyUu9L+/wIdXICn98XGcA8PGm413qRGT/m4ywowi+BzsMqZE52d/U0lVNxh2jo9MqbqkwJ7kfL2wMjCVnKG4p8If0GDGtYH8edOfKcCHev/JMsy6PBL8E6vFNCIn8+1UKeMz5u/murrfJEAuKuOWIrACIWQ8TDuhyAawmWhV2A+MbEOZfLM7InC9XDjRyF29KdN5Ov3Tk+Tq0IRWSQTBbcnTTfCnHrKfbfgWivSK/MakJQ1XIGdH8jNwSwFzHEQUUlbjCfXJGCNPRhSTD6jUZ3RX8In/4vkQh2LaIv2/y7jnb13UEEEDuPU6NploaelCe2b6vxf0UhIH3adZwb5f2TxDbM7UmBN1cXUyVWzdwfexxcvXWtZ6QOtgnjIVaG5co9kB+grGO0Xn44RPUxSDB//k6ID4y/9W4ZHKwDDVHWqKY3YsNHruEwGU+xq6doBLeup3jVaULVStRpAezucdWjCSmHWVwEbuUAu1Vrdp2Tn26DJHfR9nseWy+kneawyUaV9cT5qXlCPxVLaCmNN8RIYbMSrWj03Zffegl4j41K/De3QaHi4Rs4QB0aTWS9hE7iUpnSurXPtFJlSII4e5aOqgMyspjIUF+JyiMEjuYozCw3C5vhLhWKYFj776NC6lWz0RyeXUjI5TRZr1n7VrJKeJsFqr+H5S4LgyAE2fp03cR1z5+PSWpbZp5P4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6045.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(42112799006)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(8096899003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7EMV/hMOnhR5mI1RaSE5QAclkUcLZch/QQ0KiEGQLf68DZ6enPU7JUyT5xw/?=
 =?us-ascii?Q?/1ulLImei2wEF4OkekK8djM+M5lFWm5smRjj9uJ6t569HiPbYmKla286f15P?=
 =?us-ascii?Q?wJzYBNEntOFskAetzFSZ1qDubgMVVz3afjPh8BI/ROTiJUoRXeQn79QaZjXL?=
 =?us-ascii?Q?5ZAvv2UbprIghvdt+wQiQ8yR6/u/8PaMhkju3XneOytbzF/Y/6HZlf89IHvE?=
 =?us-ascii?Q?MsxnlUoGaQHKBkOdxBeuYb2qRYRnvGQlPT5vyBhYK1ELnBARjOKgo9DTGrZz?=
 =?us-ascii?Q?alNV6ppvkKPX/Z/MAv2auMqoCB6Dq6qi9SxiPXGDw6puJIYQyQVJAvaFaYQs?=
 =?us-ascii?Q?10r2rV76TJJI3RliF1CzMmDIcaFXBKigK9y4csAAwd/W8C5ndwhdVdICUcQq?=
 =?us-ascii?Q?k/DFwL1skiRdX554lueAbERvwIjRIwdWGjS0faUAQZza0UAAvSoMUYy4oNz0?=
 =?us-ascii?Q?YmEfPjp/FsNa1uODF1xiDZY67JCASzKOVybyseTPKfQ8LkVknverzZJFOc6Z?=
 =?us-ascii?Q?/Vr1HvxXLSu9WYg3PT9r0AkUraKB8ROoJ9GJg5qEILJNetXK4Fry5VrEBLr6?=
 =?us-ascii?Q?6A94jJUoSSiRC5na9WamHAk5T4Ql31XdrG3ahOXDG0hsNod3xFiFgRz07XgR?=
 =?us-ascii?Q?hjSqkUCFNCZ0GWeNZjPyoZz2qHcrGGP6k8sh2NW4wpCFE6EGTeXJp7UfvksN?=
 =?us-ascii?Q?cP3fdkHy//1l9KfJ6vNgIN7ERzSbjSp+8mpFQLn5iTQZhzl+y2eiZWAUKgWO?=
 =?us-ascii?Q?Yz3oG9EJvx1kfUQjU0Lzy2/dDOtEqW6fYT/4s1heBgbBMKQFr5uIOs5HdVhr?=
 =?us-ascii?Q?kCdvcvgSbGVpr3JVXlYB/Uh2XkViCPHv0eAQ1aZPrS2yYKcW5lCRuUM+TgZf?=
 =?us-ascii?Q?Vlk8I/4up+100cLtdsVfw/80hZGVir78AFzDCPl9tFgVGZT8zHDa1nJNUnei?=
 =?us-ascii?Q?cDPFwiOswsqeDjeN9QPPXhxX0w2L1CgAaapP0Sta72VZUIfHUk8x5TexBsiS?=
 =?us-ascii?Q?Iy4k2IlKuRldt+861+B3q1f0RUSmBDHZxqspVQWRmshPG7dQvPvo/lv0d5um?=
 =?us-ascii?Q?hKAIShFSot9xXo+uoBTfTRGcfbpouh5JbafPGTabnZQBxub2y46hN+NtqRql?=
 =?us-ascii?Q?tkrn1nkDrYbTdDpCNLtFZaF8MvXGnmhPkAgqKJjZ5/70rRYuc09XKnI5yGlu?=
 =?us-ascii?Q?0pkHusj3lrsYdQIq4yJ9/Yb2AJ1wLlo5ly0nPBQmuxHKlsD8L+RjJk12VePZ?=
 =?us-ascii?Q?BGZX0mQsix+Tzkc+VT894CkP4h3K2OGhR6CpcDizXEHrUQJoODb1LcXr+c3e?=
 =?us-ascii?Q?EMaZywsHnoPSYVsOy/H2+1rrHVL4V3wIpSw9b8KwjIR4H6QdZGeY6lAWxnj+?=
 =?us-ascii?Q?uXvcckw19WBF6jVTcLc8DVNrXFj9U78/lpwKWl0ZCnUIU3UTAgFwse4iTCBR?=
 =?us-ascii?Q?uPgkN7rCt0bEvSU4h4f5cp30wABrYeZKM4wXyLTgmJaMFJP/GGz9E9MYouTg?=
 =?us-ascii?Q?9eA5ev4VxYOfmuTAplZT0og5Tg79S3DDqO/2p8XyRzT7WBLIqA3271sBIhy/?=
 =?us-ascii?Q?rGZa3HHH05wS3C/np1o9iNL/5oD5bIwL8aGeAf5r1TuS/bJzFMxIwdRnaPXH?=
 =?us-ascii?Q?u43Qo77Mkg66yNpvj5uLw7+wIXQn8C4gIuala8JEgRAk3SWaFX1qrjeeuxZ5?=
 =?us-ascii?Q?B0AKnlmvpxVilHOPooTB3k8pN+cYDE6jbWxg83CoE45325nv?=
Content-Type: multipart/alternative;
 boundary="_000_LV2PR11MB6045F2B5B35E1448045B866781F82LV2PR11MB6045namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hgiCMZdy6C9ljL+rTaXWl9qOKl12UtHwqXwakA9WwRZj8vwjdc9eqn6PSacwEHAqKfiR6oHMvsdMgbkMJL3V5Xvzcd9f85mcDoj177H7ykhsVC5roK7N3elqs+M9PCnxddyq7V1LX4sGkwT5rfPtLwcN0IjXXRSZJq5vBz8nvuE7HIcJNEcxA75rO35bKP2kE0Z4OpMzSqEpAyMkJHL5/HAfUo2nNoZh1Q+vmA4Bn1iyUKbVgIZjWZFu36iX65U9HcETqAwpu6Jb5JMOF+MwCd43hKbsQ/ynpMmWPmWysuxnuFDlq/FtsFBMQz5pULa+dEwrx1e/c0pQnB593DqG+Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1627ac95-fd7a-459e-baa5-08dee25bf337
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 10:29:28.3420 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wd/49L5U7rWN7hD2jDV7C0unm9/hKrfOXQAMGX3MDWh2KUEhzgrSkWNj5Tq6mhhA8l0nO0XVKyewW1oUGZYyBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6663
X-OriginatorOrg: intel.com
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

--_000_LV2PR11MB6045F2B5B35E1448045B866781F82LV2PR11MB6045namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>
________________________________
From: Radu Nicolau <radu.nicolau@intel.com>
Sent: 06 July 2026 17:57
To: dev@dpdk.org <dev@dpdk.org>
Cc: maxime.coquelin@redhat.com <maxime.coquelin@redhat.com>; david.marchand=
@redhat.com <david.marchand@redhat.com>; Nicolau, Radu <radu.nicolau@intel.=
com>; jianjay.zhou@huawei.com <jianjay.zhou@huawei.com>; Jiang, YuX <yux.ji=
ang@intel.com>; Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH v2] crypto/virtio: cookies are allocated from mempool

The Rx/Tx functions allocate cookies as needed, no need to
allocate and free from heap.

Fixes: 6f0175ff53e0 ("crypto/virtio: support basic PMD ops")
Cc: jianjay.zhou@huawei.com

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
Tested-by: Yu Jiang <yux.jiang@intel.com>
---
v2: removed redundant mempool free

 drivers/crypto/virtio/virtio_cryptodev.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_cryptodev.c b/drivers/crypto/virt=
io/virtio_cryptodev.c
index 6f079f15f6..d70651646e 100644
--- a/drivers/crypto/virtio/virtio_cryptodev.c
+++ b/drivers/crypto/virtio/virtio_cryptodev.c
@@ -68,7 +68,6 @@ void
 virtio_crypto_queue_release(struct virtqueue *vq)
 {
         struct virtio_crypto_hw *hw;
-       uint16_t i;

         PMD_INIT_FUNC_TRACE();

@@ -80,9 +79,6 @@ virtio_crypto_queue_release(struct virtqueue *vq)
                 hw->vqs[vq->vq_queue_index] =3D NULL;
                 rte_memzone_free(vq->mz);
                 rte_mempool_free(vq->mpool);
-               for (i =3D 0; i < vq->vq_nentries; i++)
-                       rte_free(vq->vq_descx[i].cookie);
-
                 rte_free(vq);
         }
 }
@@ -102,8 +98,6 @@ virtio_crypto_queue_setup(struct rte_cryptodev *dev,
         unsigned int vq_size;
         struct virtio_crypto_hw *hw =3D dev->data->dev_private;
         struct virtqueue *vq =3D NULL;
-       uint32_t i =3D 0;
-       uint32_t j;

         PMD_INIT_FUNC_TRACE();

@@ -175,29 +169,12 @@ virtio_crypto_queue_setup(struct rte_cryptodev *dev,
                                         "Cannot create mempool");
                         goto mpool_create_err;
                 }
-               for (i =3D 0; i < nb_desc; i++) {
-                       vq->vq_descx[i].cookie =3D
-                               rte_zmalloc("crypto PMD op cookie pointer",
-                                       sizeof(struct virtio_crypto_op_cook=
ie),
-                                       RTE_CACHE_LINE_SIZE);
-                       if (vq->vq_descx[i].cookie =3D=3D NULL) {
-                               VIRTIO_CRYPTO_DRV_LOG_ERR("Failed to "
-                                               "alloc mem for cookie");
-                               goto cookie_alloc_err;
-                       }
-               }
         }

         *pvq =3D vq;

         return 0;

-cookie_alloc_err:
-       rte_mempool_free(vq->mpool);
-       if (i !=3D 0) {
-               for (j =3D 0; j < i; j++)
-                       rte_free(vq->vq_descx[j].cookie);
-       }
 mpool_create_err:
         rte_free(vq);
         return -ENOMEM;
--
2.52.0


--_000_LV2PR11MB6045F2B5B35E1448045B866781F82LV2PR11MB6045namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);">
Acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Radu Nicolau &lt;radu=
.nicolau@intel.com&gt;<br>
<b>Sent:</b> 06 July 2026 17:57<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b> maxime.coquelin@redhat.com &lt;maxime.coquelin@redhat.com&gt;; d=
avid.marchand@redhat.com &lt;david.marchand@redhat.com&gt;; Nicolau, Radu &=
lt;radu.nicolau@intel.com&gt;; jianjay.zhou@huawei.com &lt;jianjay.zhou@hua=
wei.com&gt;; Jiang, YuX &lt;yux.jiang@intel.com&gt;; Fan Zhang
 &lt;fanzhang.oss@gmail.com&gt;<br>
<b>Subject:</b> [PATCH v2] crypto/virtio: cookies are allocated from mempoo=
l</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The Rx/Tx functions allocate cookies as needed, no=
 need to<br>
allocate and free from heap.<br>
<br>
Fixes: 6f0175ff53e0 (&quot;crypto/virtio: support basic PMD ops&quot;)<br>
Cc: jianjay.zhou@huawei.com<br>
<br>
Signed-off-by: Radu Nicolau &lt;radu.nicolau@intel.com&gt;<br>
Tested-by: Yu Jiang &lt;yux.jiang@intel.com&gt;<br>
---<br>
v2: removed redundant mempool free<br>
<br>
&nbsp;drivers/crypto/virtio/virtio_cryptodev.c | 23 -----------------------=
<br>
&nbsp;1 file changed, 23 deletions(-)<br>
<br>
diff --git a/drivers/crypto/virtio/virtio_cryptodev.c b/drivers/crypto/virt=
io/virtio_cryptodev.c<br>
index 6f079f15f6..d70651646e 100644<br>
--- a/drivers/crypto/virtio/virtio_cryptodev.c<br>
+++ b/drivers/crypto/virtio/virtio_cryptodev.c<br>
@@ -68,7 +68,6 @@ void<br>
&nbsp;virtio_crypto_queue_release(struct virtqueue *vq)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct virtio_crypto_hw *h=
w;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t i;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PMD_INIT_FUNC_TRACE();<br>
&nbsp;<br>
@@ -80,9 +79,6 @@ virtio_crypto_queue_release(struct virtqueue *vq)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hw-&gt;vqs[vq-&gt;vq_queue_index] =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; rte_memzone_free(vq-&gt;mz);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; rte_mempool_free(vq-&gt;mpool);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; vq-&gt;vq_nentries; i++)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_free(vq-&gt;=
vq_descx[i].cookie);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; rte_free(vq);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
@@ -102,8 +98,6 @@ virtio_crypto_queue_setup(struct rte_cryptodev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int vq_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct virtio_crypto_hw *h=
w =3D dev-&gt;data-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct virtqueue *vq =3D N=
ULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t j;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PMD_INIT_FUNC_TRACE();<br>
&nbsp;<br>
@@ -175,29 +169,12 @@ virtio_crypto_queue_setup(struct rte_cryptodev *dev,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &quot;Cannot create mempool&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
mpool_create_err;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; nb_desc; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vq-&gt;vq_descx[=
i].cookie =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_zmalloc(&quot;crypto PMD op cookie poin=
ter&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; sizeof(struct virtio_crypto_op_cookie),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; RTE_CACHE_LINE_SIZE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vq-&gt;vq_de=
scx[i].cookie =3D=3D NULL) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO_CRYPTO_DRV_LOG_ERR(&quot;Failed to &=
quot;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;alloc mem for co=
okie&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto cookie_alloc_err;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pvq =3D vq;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-cookie_alloc_err:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_mempool_free(vq-&gt;mpool);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i !=3D 0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (j =3D 0; j &lt; i; j++)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_free(vq-&gt;=
vq_descx[j].cookie);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;mpool_create_err:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_free(vq);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
-- <br>
2.52.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_LV2PR11MB6045F2B5B35E1448045B866781F82LV2PR11MB6045namp_--
