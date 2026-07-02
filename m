Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990D1C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Jul 2026 16:34:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89C834026C;
	Thu,  2 Jul 2026 18:34:34 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 1222B40265
 for <dev@dpdk.org>; Thu,  2 Jul 2026 18:34:33 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4grjBF21gzzHnGjn;
 Fri,  3 Jul 2026 00:33:41 +0800 (CST)
Received: from frapema100002.china.huawei.com (unknown [7.182.19.63])
 by mail.maildlp.com (Postfix) with ESMTPS id CB31040575;
 Fri,  3 Jul 2026 00:34:29 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100002.china.huawei.com (7.182.19.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Jul 2026 18:34:29 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Thu, 2 Jul 2026 18:34:29 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH 2/2] bpf: silence noisy message
Thread-Topic: [PATCH 2/2] bpf: silence noisy message
Thread-Index: AQHdCandYp+v290kCEWKJzoRjLjBlbZZ5vuQgABkPACAACHu8A==
Date: Thu, 2 Jul 2026 16:34:29 +0000
Message-ID: <5745cb1553bb4e0e870d36e36755187e@huawei.com>
References: <20260701223453.104660-1-stephen@networkplumber.org>
 <20260701223453.104660-2-stephen@networkplumber.org>
 <75fa182ed2b64f88bdb0c6c8a729aaea@huawei.com>
 <20260702093004.15841f2b@phoenix.local>
In-Reply-To: <20260702093004.15841f2b@phoenix.local>
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

> https://github.com/DPDK/dpdk/blob/09e4f37ddd0f7d5cc7c696741f31f1582c73a71=
6/lib/bpf/bpf_load_elf.c#L331
> -L333
> >
> > (In fact I tried to eliminate it, but had to but back at the insistence=
 of AI reviewer
> > and even broke the build in the process...)
> >
> > So naturally I support downgrading this message. With the commit messag=
e corrected,
> >
> > Acked-by: Marat Khalili <marat.khalili@huawei.com>
>=20
> Looks like you added that message in:
>   55192fe168b9 ("bpf: introduce extensible load API")

It was moved from a different file, see above.
Maybe it applied to fewer code paths since they are now all merged.

Anyway it's not really important unless you think it's worth backporting.
Feel free to downgrade or remove this message.
