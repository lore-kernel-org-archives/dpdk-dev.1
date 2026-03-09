Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDC6EF36F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 07:49:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6DF7402EF;
	Mon,  9 Mar 2026 08:48:59 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id BE4AD40281;
 Mon,  9 Mar 2026 08:48:58 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fTpzp2nMGzHnH4s;
 Mon,  9 Mar 2026 15:48:54 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id B017140572;
 Mon,  9 Mar 2026 15:48:57 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500001.china.huawei.com (7.214.147.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Mar 2026 07:48:57 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Mon, 9 Mar 2026 07:48:57 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Robin Jarry <rjarry@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>, "Yipeng
 Wang" <yipeng1.wang@intel.com>, Sameh Gobriel <sameh.gobriel@intel.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Ray Kinsella <mdr@ashroe.eu>, Ruifeng Wang
 <ruifeng.wang@arm.com>, Dharmik Thakkar <dharmikjayesh.thakkar@arm.com>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH dpdk v3 2/2] hash: free replaced data on overwrite when
 RCU is configured
Thread-Topic: [PATCH dpdk v3 2/2] hash: free replaced data on overwrite when
 RCU is configured
Thread-Index: AQHcrUXnWQN/pYas8EynXYWGlT0VyrWl16WQ
Date: Mon, 9 Mar 2026 07:48:57 +0000
Message-ID: <d96d3cb1bd804cfc90e0fff6d7f2c594@huawei.com>
References: <20260212213313.1376294-5-rjarry@redhat.com>
 <20260306084710.492520-4-rjarry@redhat.com>
 <20260306084710.492520-6-rjarry@redhat.com>
In-Reply-To: <20260306084710.492520-6-rjarry@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.203.174]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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



> When rte_hash_add_key_data() overwrites an existing key, the old data
> pointer is silently lost. With RCU-protected readers still potentially
> accessing the old data, the application has no safe way to free it.
>=20
> When RCU is configured with a free_key_data_func callback, automatically
> enqueue the old data for deferred freeing via the RCU defer queue on
> overwrite. In SYNC mode, synchronize and call free_key_data_func
> directly.
>=20
> Cc: stable@dpdk.org
> Fixes: 769b2de7fb52 ("hash: implement RCU resources reclamation")
>=20
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>=20

> 2.53.0
>=20

