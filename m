Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470F7103E171
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 12:54:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 564F44026F;
	Wed, 18 Mar 2026 13:54:50 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5911F40150
 for <dev@dpdk.org>; Wed, 18 Mar 2026 13:54:49 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 1415420849;
 Wed, 18 Mar 2026 13:54:49 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] bpf/arm64: support packet data load instructions
Date: Wed, 18 Mar 2026 13:54:47 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6579F@smartserver.smartshare.dk>
In-Reply-To: <b10d0edcdaac4fd9a4f5a0261205670c@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: [PATCH] bpf/arm64: support packet data load instructions
Thread-Index: AQHctXjoFxWXyTh3g0OC9SlGIQcTMrW0I+zwgAAX+/A=
References: <20260310122045.4057836-1-cfontain@redhat.com>
 <b10d0edcdaac4fd9a4f5a0261205670c@huawei.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Marat Khalili" <marat.khalili@huawei.com>,
 "Christophe Fontaine" <cfontain@redhat.com>, <dev@dpdk.org>
Cc: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Wathsala Vithanage" <wathsala.vithanage@arm.com>
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

> > +static void
> > +emit_ld_mbuf(struct a64_jit_ctx *ctx, uint32_t op, uint8_t tmp1,
> uint8_t tmp2,
> > +	uint8_t src, uint32_t imm)
>=20
> Handling immediate as unsigned is questionable, especially in the
> BPF_IND case
> it may produce incorrect results.

In Classic BPF (cBPF), when the immediate "k" is negative (when cast to =
signed integer), it is used for getting packet metadata (e.g. =
SKF_AD_VLAN_TAG gets the VLAN ID); otherwise it is considered unsigned.

>=20
> To make things worse, `__rte_pktmbuf_read` is also buggy when passed
> very large
> lengths (again, technically not ARM eBPF fault).

Are you referring to the potential integer wraparound in the off+len > =
rte_pktmbuf_pkt_len(m) comparison?
[BZ1724]
Or some other bug in __rte_pktmbuf_read()?

[BZ1724]: https://bugs.dpdk.org/show_bug.cgi?id=3D1724

>=20
> > +{
> > +	uint8_t r0 =3D ebpf_to_a64_reg(ctx, EBPF_REG_0);
> > +	uint8_t r6 =3D ebpf_to_a64_reg(ctx, EBPF_REG_6);
> > +	uint32_t mode =3D BPF_MODE(op);
> > +	uint32_t opsz =3D BPF_SIZE(op);
> > +	uint32_t sz =3D bpf_size(opsz);
> > +	int16_t jump_to_epilogue;
> > +
> > +	/* r0 =3D mbuf (R6) */
> > +	emit_mov_64(ctx, A64_R(0), r6);
> > +
> > +	/* r1 =3D off: for ABS use imm, for IND use src + imm */
> > +	if (mode =3D=3D BPF_ABS) {
> > +		emit_mov_imm(ctx, 1, A64_R(1), imm);
> > +	} else {
> > +		emit_mov_imm(ctx, 1, tmp2, imm);
> > +		emit_add(ctx, 1, tmp2, src);
> > +		emit_mov_64(ctx, A64_R(1), tmp2);
> > +	}
> > +
> > +	/* r2 =3D len */
> > +	emit_mov_imm(ctx, 1, A64_R(2), sz);
> > +
> > +	/* r3 =3D buf (SP) */
> > +	emit_mov_64(ctx, A64_R(3), A64_SP);
> > +
> > +	/* call __rte_pktmbuf_read */
> > +	emit_call(ctx, tmp1, __rte_pktmbuf_read);
> > +	/* check return value of __rte_pktmbuf_read */
> > +	emit_cbnz(ctx, 1, A64_R(0), 3);
> > +	emit_mov_imm(ctx, 1, r0, 0);
> > +	jump_to_epilogue =3D (ctx->program_start + ctx->program_sz) - ctx-
> >idx;
> > +	emit_b(ctx, jump_to_epilogue);
>=20
> Could we call emit_return_zero_if_src_zero here instead?
>=20
> > +
> > +	/* r0 points to the data, load 1/2/4 bytes */
> > +	emit_ldr(ctx, opsz, A64_R(0), A64_R(0), A64_ZR);
> > +	if (sz !=3D sizeof(uint8_t))
> > +		emit_be(ctx, A64_R(0), sz * CHAR_BIT);
> > +	emit_mov_64(ctx, r0, A64_R(0));
> > +}
> > +
>=20
> I would also pass final verdict on ARM code to ARM folks. To my
> untrained eye
> it looks correct apart from the signed immediate issue. Optimizations
> are
> possible, but since we're only implementing slow path for now maybe =
not
> worth
> the effort.
