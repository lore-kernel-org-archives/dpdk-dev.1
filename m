Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AECCDB481
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 13:44:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 089E24025E;
	Wed, 24 Jun 2026 15:44:51 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 086E8400EF
 for <dev@dpdk.org>; Wed, 24 Jun 2026 15:44:49 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gljpK1sQSzJ46ZV;
 Wed, 24 Jun 2026 21:44:09 +0800 (CST)
Received: from frapema500001.china.huawei.com (unknown [7.182.19.243])
 by mail.maildlp.com (Postfix) with ESMTPS id EDD3C40575;
 Wed, 24 Jun 2026 21:44:45 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500001.china.huawei.com (7.182.19.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 24 Jun 2026 15:44:45 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 24 Jun 2026 15:44:45 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH v4 3/7] test/bpf: add test for large shift
Thread-Topic: [PATCH v4 3/7] test/bpf: add test for large shift
Thread-Index: AQHdA2eYIEUgsGEG4kaic4WUD8yF/7ZNVaaQgABiFSA=
Date: Wed, 24 Jun 2026 13:44:45 +0000
Message-ID: <2c596e3221bb4d54b0305117902b7575@huawei.com>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260623232522.257208-1-stephen@networkplumber.org>
 <20260623232522.257208-4-stephen@networkplumber.org>
 <8c882f31aaec46d984fc4c689ad92602@huawei.com>
In-Reply-To: <8c882f31aaec46d984fc4c689ad92602@huawei.com>
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

> > +/*
> > + * Shift by an immediate that doesn't fit in a signed byte: the C1 shi=
ft
> > + * group takes a fixed 1-byte immediate, but imm_size() returns 4 for
> > + * counts >=3D 128, so the x86 JIT emits 3 stray bytes and desyncs the
> > + * instruction stream. The shift results are discarded (a count >=3D 6=
4 is
> > + * UB in the interpreter); the test returns a known constant, which th=
e
> > + * corrupted stream fails to produce.
> > + */
> > +static const struct ebpf_insn test_shift_big_imm_prog[] =3D {
> > +	{
> > +		.code =3D (BPF_ALU | EBPF_MOV | BPF_K),
> > +		.dst_reg =3D EBPF_REG_2,
> > +		.imm =3D 0x1,
> > +	},
> > +	{
> > +		.code =3D (EBPF_ALU64 | BPF_LSH | BPF_K),
> > +		.dst_reg =3D EBPF_REG_2,
> > +		.imm =3D 137,
> > +	},
> > +	{
> > +		.code =3D (EBPF_ALU64 | BPF_RSH | BPF_K),
> > +		.dst_reg =3D EBPF_REG_2,
> > +		.imm =3D 200,
> > +	},
> > +	{
> > +		.code =3D (EBPF_ALU64 | EBPF_ARSH | BPF_K),
> > +		.dst_reg =3D EBPF_REG_2,
> > +		.imm =3D 255,
> > +	},
> > +	/* known result; a desynced stream won't reproduce it */
> > +	{
> > +		.code =3D (BPF_ALU | EBPF_MOV | BPF_K),
> > +		.dst_reg =3D EBPF_REG_0,
> > +		.imm =3D 0x55,
> > +	},
> > +	{
> > +		.code =3D (BPF_JMP | EBPF_EXIT),
> > +	},
> > +};
>=20
> // snip the rest
>=20
> Thanks a lot for adding this test. Can we use the shift results though, i=
nstead
> of discarding them, maybe as another test case? If the interpreter is una=
ble to
> reproduce them or triggers sanitizer it needs to be fixed as well. (Apolo=
gies
> for this scope creep but I hope we get to the bottom of it eventually.)

Speaking of scope creep, this currently fails on ARM since emit_lsl (as wel=
l as=20
emit_lsr, emit_asr) does not clear unused immediate bits and thus the value=
=20
does not fit in the encoding.
