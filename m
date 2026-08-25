Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6388EC61DBD
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 11:06:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B518402A3;
	Tue, 25 Aug 2026 13:06:47 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 6C9F5400D5;
 Tue, 25 Aug 2026 13:06:45 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=LJCeAMjQQvH0ubRJ16fkD5R4O+Tn+ycHtdmQU7+NGPQ=;
 b=jkQdGYwLRLAg8e77dlt6RdvY2Z5iquj8ck81FPhiXTEcP0/yPmpSNDQ5ci2HJwPa0ycB4xf8J
 +jnGM0Y279M3f88mcku7vEJKcHy42IRh7ILDhiM/2TcltJoQgcIIL4O6qNGqy0rxbn0pJYAnvL7
 1/uzbZaUxlh0EdyHyRj5XuM=
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hTlMS0jwJzHnGcp;
 Tue, 25 Aug 2026 19:06:12 +0800 (CST)
Received: from frapema100007.china.huawei.com (unknown [7.182.19.38])
 by mail.maildlp.com (Postfix) with ESMTPS id B1E614058B;
 Tue, 25 Aug 2026 19:06:43 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100007.china.huawei.com (7.182.19.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 13:06:43 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.2562.045;
 Tue, 25 Aug 2026 13:06:43 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Sebti Mouelhi
 <sebti.mouelhi@huawei.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Marat Khalili <marat.khalili@huawei.com>
Subject: RE: [PATCH] bpf/validate: fix 32-bit BPF_AND/OR/XOR shift UBs
Thread-Topic: [PATCH] bpf/validate: fix 32-bit BPF_AND/OR/XOR shift UBs
Thread-Index: AQHdNHgC1orGxHc0XEynl4+ZlV4tpraumaZA
Date: Tue, 25 Aug 2026 11:06:43 +0000
Message-ID: <3f1e8b3ad7d94ba7b8cef46be591698a@huawei.com>
References: <20260825095530.41354-1-marat.khalili@huawei.com>
In-Reply-To: <20260825095530.41354-1-marat.khalili@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.78]
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

Answering the multiple AI reviews (why are there 3 of them, all via Claude?=
):


1. Test naming

> +/* 32-bit bitwise AND between a scalar range and immediate, triggering U=
B. */
> +static int
> +test_alu32_and_k_ub(void)

I agree with the AI that test names (and comments) are somewhat minimalist =
and
would require reader to check the commit message to find out what's going o=
n.
The suggestion by AI to replace `_ui` with `_range` is not improving things
much however, so only doing it to placate the AI in case of another iterati=
on.

As far as I know DPDK does not have a strict policy for cross-referencing b=
ugs,
fixes and tests, so in the interest of time and code brevity not putting a =
huge
effort into it unless asked by actual humans.


2. Test coverage

Not contesting that current test coverage of these instructions is rudiment=
ary
and needs to be expanded; 32-bit instructions as a whole need a lot of work=
.
It is all out of scope of this patch however, the added tests are sufficien=
t
for reproducing the specific bug and confirming the fix.


Not addressing the rest of AI comments, they are all non-issues IMO.
