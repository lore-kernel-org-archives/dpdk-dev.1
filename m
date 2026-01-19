Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC03CCF2EF
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 11:42:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0D904025D;
	Mon, 19 Jan 2026 12:42:28 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 28F334025A;
 Mon, 19 Jan 2026 12:42:27 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dvpTQ4rv1zJ46fT;
 Mon, 19 Jan 2026 19:42:02 +0800 (CST)
Received: from frapema500001.china.huawei.com (unknown [7.182.19.243])
 by mail.maildlp.com (Postfix) with ESMTPS id 716D240569;
 Mon, 19 Jan 2026 19:42:25 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500001.china.huawei.com (7.182.19.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 Jan 2026 12:42:25 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Mon, 19 Jan 2026 12:42:25 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH 3/6] test: fix race condition in ELF load tests
Thread-Topic: [PATCH 3/6] test: fix race condition in ELF load tests
Thread-Index: AQHciLbMojPkcRUa1EyhZxZ+tu4r8rVZWn2g
Date: Mon, 19 Jan 2026 11:42:25 +0000
Message-ID: <3f0009fb007b410a931f4f161282cd1e@huawei.com>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260118201223.323024-4-stephen@networkplumber.org>
In-Reply-To: <20260118201223.323024-4-stephen@networkplumber.org>
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

For the create_temp_bpf_file part I'm not 100% convinced by the explanation=
.=20
Although fsync will not make things worse, it should not be necessary unles=
s=20
the infra is broken (but then we'd see other problems; and note that if we=
=20
started to call fsync we also need to call it on directory etc.). Another=20
possibility is write call getting interrupted before all data is written. C=
an=20
you share an example of failed job? Can we add more error handling and logg=
ing,=20
like check return value from close (also fsyncs if we add them)? Can we use=
=20
stdio calls instead of libc ones BTW, they will handle partial writes at le=
ast,=20
on top of being more portable?

Can ack the port part.

P.S. Did not worth its own patch, but since you are working on it can you a=
lso=20
do s/sizeof(struct rte_mbuf)/RTE_MBUF_DEFAULT_BUF_SIZE/g ? I overlooked it =
last=20
time.
