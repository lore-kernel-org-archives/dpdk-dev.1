Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FBBD2ECF7
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 10:30:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B456402F0;
	Tue, 20 Jan 2026 11:30:29 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 4129C4013F;
 Tue, 20 Jan 2026 11:30:27 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dwNqt0HPzzJ46mq;
 Tue, 20 Jan 2026 18:30:02 +0800 (CST)
Received: from frapema500002.china.huawei.com (unknown [7.182.19.148])
 by mail.maildlp.com (Postfix) with ESMTPS id 5CAE640571;
 Tue, 20 Jan 2026 18:30:26 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500002.china.huawei.com (7.182.19.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 20 Jan 2026 11:30:26 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Tue, 20 Jan 2026 11:30:25 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH 3/6] test: fix race condition in ELF load tests
Thread-Topic: [PATCH 3/6] test: fix race condition in ELF load tests
Thread-Index: AQHciLbMojPkcRUa1EyhZxZ+tu4r8rVZWn2ggADDuACAALsfsA==
Date: Tue, 20 Jan 2026 10:30:25 +0000
Message-ID: <f8dbb6cf64ae45618195580be788b59c@huawei.com>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260118201223.323024-4-stephen@networkplumber.org>
 <3f0009fb007b410a931f4f161282cd1e@huawei.com>
 <20260119160326.06a6094c@phoenix.local>
In-Reply-To: <20260119160326.06a6094c@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.16]
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

> > P.S. Did not worth its own patch, but since you are working on it can y=
ou also
> > do s/sizeof(struct rte_mbuf)/RTE_MBUF_DEFAULT_BUF_SIZE/g ? I overlooked=
 it last
> > time.
>=20
>=20
> Where is that bit?

This in app/test/test_bpf.c is a mix of two worlds:

```c
        const struct rte_bpf_prm prm =3D {
                .prog_arg =3D {
                        .type =3D RTE_BPF_ARG_PTR,
                        .size =3D sizeof(struct rte_mbuf),
                },
        };
```

The pointer points to the mbuf buffer, but the size is provided for the mbu=
f=20
struct.

Now that I think of it, what lib/bpf/bpf_pkt.c passes to BPF program is not=
 a=20
pointer to the mbuf buffer, but a pointer to the packet data which is bigge=
r by=20
RTE_PKTMBUF_HEADROOM, so we should probably specify RTE_MBUF_DEFAULT_DATARO=
OM=20
in the size member for our case.
