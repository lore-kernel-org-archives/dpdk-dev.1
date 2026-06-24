Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91A0CDE001
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 08:39:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBA2D40150;
	Wed, 24 Jun 2026 10:39:18 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 6CEA7400EF
 for <dev@dpdk.org>; Wed, 24 Jun 2026 10:39:17 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4glb1v24qzzHnGhy;
 Wed, 24 Jun 2026 16:38:43 +0800 (CST)
Received: from frapema500001.china.huawei.com (unknown [7.182.19.243])
 by mail.maildlp.com (Postfix) with ESMTPS id 4169E40569;
 Wed, 24 Jun 2026 16:39:15 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500001.china.huawei.com (7.182.19.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 24 Jun 2026 10:39:15 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 24 Jun 2026 10:39:15 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH v4 7/7] test/bpf: check that bpf_convert can be JIT'd
Thread-Topic: [PATCH v4 7/7] test/bpf: check that bpf_convert can be JIT'd
Thread-Index: AQHdA2eZtA+u2poL0EmityXeAkz+9LZNYptg
Date: Wed, 24 Jun 2026 08:39:14 +0000
Message-ID: <98a77d2714794eb282b966ef96116497@huawei.com>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260623232522.257208-1-stephen@networkplumber.org>
 <20260623232522.257208-8-stephen@networkplumber.org>
In-Reply-To: <20260623232522.257208-8-stephen@networkplumber.org>
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

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Wednesday 24 June 2026 00:23
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Konstantin Ananyev <k=
onstantin.ananyev@huawei.com>;
> Marat Khalili <marat.khalili@huawei.com>
> Subject: [PATCH v4 7/7] test/bpf: check that bpf_convert can be JIT'd
>=20
> Run each converted filter through both the interpreter and the JIT and
> check they agree, catching JIT miscompiles.
>=20
> test_bpf_filter and test_bpf_match did nearly the same thing: compile,
> load and run a filter against the dummy packet. Combine them into
> test_bpf_match, which now builds the packet itself and returns whether
> the filter matched. Callers run it for both load methods.
>=20
> The dummy packet is a UDP packet to a fixed destination MAC, source
> and destination ports, so the filter results are deterministic. None
> of the sample filters should match it, so assert that; a convert or
> JIT bug that flips a result is then caught. The destination MAC and
> source port are chosen so the negative ethernet and port filters do
> not match, and "port not 53 and not arp" is dropped as it matches
> any non-ARP packet that lacks port 53.
>=20
> Reduce log output to make it easier to match which expression might be
> causing issues.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Marat Khalili <marat.khalili@huawei.com>

