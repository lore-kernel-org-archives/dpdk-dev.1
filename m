Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E198BCDE008
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 10:35:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B5C840265;
	Fri, 26 Jun 2026 12:35:55 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 306FF40264
 for <dev@dpdk.org>; Fri, 26 Jun 2026 12:35:53 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gmsWM5p5FzHnH55;
 Fri, 26 Jun 2026 18:35:11 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id E087040569;
 Fri, 26 Jun 2026 18:35:47 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 26 Jun 2026 12:35:47 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 26 Jun 2026 12:35:47 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v6 0/9] bpf: JIT related bug fixes
Thread-Topic: [PATCH v6 0/9] bpf: JIT related bug fixes
Thread-Index: AQHdBMivmFTxyeVss0CLqiAqVyp+uLZQpSsg
Date: Fri, 26 Jun 2026 10:35:47 +0000
Message-ID: <cf0e1f65fc574f2a9ffebd5fac7ca60c@huawei.com>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260625173231.216074-1-stephen@networkplumber.org>
In-Reply-To: <20260625173231.216074-1-stephen@networkplumber.org>
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

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Thursday 25 June 2026 18:30
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Subject: [PATCH v6 0/9] bpf: JIT related bug fixes
>=20
> While implementing JIT for packet capture ran into several issues:
>   1. x86 JIT had a pre-existing bug which would crash.
>   2. The arm64 JIT was missing the packet-access instructions, found
>      previously [1].
>   3. Shift counts were not masked to the operand width as RFC 9669
>      requires: undefined behavior in the interpreter and an encoding
>      failure in the arm64 JIT.
>   4. Tests related to JIT were not being run or were missing coverage.
>=20
> Fixed all of these. Patches are ordered with the most urgent fix (the
> x86 crash) first, each fix followed by the test that exercises it. The
> arm64 packet-load support is kept ahead of the "check JIT was generated"
> patch so the series bisects cleanly on arm64.
>=20
> The arm64 epilogue branch fix (patch 6) was originally posted by
> Christophe Fontaine [1]; that series stalled, so it is carried here with
> his authorship.
>=20
> [1] https://inbox.dpdk.org/dev/20260319114500.9757-2-cfontain@redhat.com/
>=20
> v6:
>  - address Marat's review ARM64 JIT of LD IND instructions
>    need to handle offsets outside of 32 bit range.
>=20
>=20
> Christophe Fontaine (1):
>   bpf/arm64: fix offset type to allow a negative jump
>=20
> Stephen Hemminger (8):
>   bpf/x86: fix JIT encoding of fixed-width immediates
>   test/bpf: add JSET test with small immediate
>   bpf: mask shift count in interpreter per RFC 9669
>   bpf/arm64: mask shift count per RFC 9669
>   test/bpf: add test for large shift
>   bpf/arm64: add BPF_ABS/BPF_IND packet load support
>   test/bpf: check that JIT was generated
>   test/bpf: check that bpf_convert can be JIT'd
>=20
>  app/test/test_bpf.c     | 320 +++++++++++++++++++++++++++++++---------
>  lib/bpf/bpf_exec.c      |  31 ++--
>  lib/bpf/bpf_jit_arm64.c | 185 ++++++++++++++++++++++-
>  lib/bpf/bpf_jit_x86.c   |   6 +-
>  lib/bpf/meson.build     |   2 +
>  5 files changed, 456 insertions(+), 88 deletions(-)
>=20
> --
> 2.53.0

Series-tested-by: Marat Khalili <marat.khalili@huawei.com>

(Maybe it actually deserves a release note at this point?)
