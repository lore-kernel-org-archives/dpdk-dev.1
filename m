Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC6AC44500
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 09:27:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC007402C3;
	Mon,  6 Jul 2026 11:27:54 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id F408F4027B
 for <dev@dpdk.org>; Mon,  6 Jul 2026 11:27:52 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gtzX009lpzJ46bB;
 Mon,  6 Jul 2026 17:26:56 +0800 (CST)
Received: from frapema100001.china.huawei.com (unknown [7.182.19.23])
 by mail.maildlp.com (Postfix) with ESMTPS id 4738840577;
 Mon,  6 Jul 2026 17:27:52 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100001.china.huawei.com (7.182.19.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 6 Jul 2026 11:27:52 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Mon, 6 Jul 2026 11:27:52 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Marat Khalili <marat.khalili@huawei.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "thomas@monjalon.net"
 <thomas@monjalon.net>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>
Subject: RE: [PATCH] test/bpf_validate: use unit_test_suite_runner
Thread-Topic: [PATCH] test/bpf_validate: use unit_test_suite_runner
Thread-Index: AQHdCwDTnyBfzP/NNU+cTJXvSpc6jrZgOGXQ
Date: Mon, 6 Jul 2026 09:27:51 +0000
Message-ID: <0c7107a5baac4ae5bee6eb81f3e40562@huawei.com>
References: <20260703152910.80285-1-marat.khalili@huawei.com>
In-Reply-To: <20260703152910.80285-1-marat.khalili@huawei.com>
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

> > @@ -2267,5 +2183,47 @@ test_mem_ldx_dw_heap(void)
> >  	});
> >  }
> >=20
> > -REGISTER_ATTIC_TEST(bpf_validate_mem_ldx_dw_heap_autotest,
> > -	test_mem_ldx_dw_heap);
> > +static struct
> > +unit_test_suite test_bpf_validate_suite  =3D {
> > +	.suite_name =3D "Test BPF Validate Unit Test Suite",
> > +	.unit_test_cases =3D {
> > +		TEST_CASE(test_alu64_add_k),

Received some additional AI comments that are not visible in patchwork (?).

> **Missing blank line before suite definition**
>=20
> The static structure `test_bpf_validate_suite` should be separated from t=
he
> preceding function `test_mem_ldx_dw_heap()` by a blank line for consisten=
cy
> with DPDK formatting conventions.

The model seems to be confused, the structure is clearly separated.

> **Extra space in structure name line**

This one is true BUT seems to be the majority style for some reason.
If fixed, this needs to be fixed in 49 other places.

> The suite name "Test BPF Validate Unit Test Suite" is somewhat redundant
> ("Test" appears twice). [...] This is a minor style preference; the curre=
nt
> name is acceptable.

I mostly agree with this one, though some (not the majority) of the other
suites also use this style. But as model said, the current name is acceptab=
le.

Net result, I do not plan to send another revision in the absence of other
comments or opinions.
