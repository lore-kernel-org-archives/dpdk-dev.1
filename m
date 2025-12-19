Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7A9D767FF
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 13:14:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52040402E9;
	Fri, 19 Dec 2025 14:14:28 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 5BD1C40150;
 Fri, 19 Dec 2025 14:14:25 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXnzh3XxGzJ46BH;
 Fri, 19 Dec 2025 21:13:52 +0800 (CST)
Received: from dubpeml100004.china.huawei.com (unknown [7.214.146.78])
 by mail.maildlp.com (Postfix) with ESMTPS id 25E4940086;
 Fri, 19 Dec 2025 21:14:25 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100004.china.huawei.com (7.214.146.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 19 Dec 2025 13:14:24 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Fri, 19 Dec 2025 13:14:24 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Marat Khalili <marat.khalili@huawei.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "jerinjacobk@gmail.com"
 <jerinjacobk@gmail.com>, "mb@smartsharesystems.com"
 <mb@smartsharesystems.com>, Wathsala Vithanage <wathsala.vithanage@arm.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v3 3/6] bpf: mark ARM opcodes with UINT32_C
Thread-Topic: [PATCH v3 3/6] bpf: mark ARM opcodes with UINT32_C
Thread-Index: AQHcb39pZrKK34DuJkixdo/L5sWwf7Uo86XA
Date: Fri, 19 Dec 2025 13:14:24 +0000
Message-ID: <bc79cc074eab4ab79b1a77865dbf110a@huawei.com>
References: <20251216182036.77869-1-marat.khalili@huawei.com>
 <20251217180141.60227-1-marat.khalili@huawei.com>
 <20251217180141.60227-4-marat.khalili@huawei.com>
In-Reply-To: <20251217180141.60227-4-marat.khalili@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.245.175]
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



> To prevent confusion as to whether operations with them will be executed
> as signed or unsigned (and with what bit width) mark all ARM opcode
> constants with UINT32_C.
>=20
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> --
> 2.43.0

