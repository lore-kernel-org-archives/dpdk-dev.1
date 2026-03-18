Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9151088E50
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 23:14:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A04A402AC;
	Thu, 19 Mar 2026 00:14:00 +0100 (CET)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com
 [209.85.222.41]) by mails.dpdk.org (Postfix) with ESMTP id 2A2C0402A7
 for <dev@dpdk.org>; Thu, 19 Mar 2026 00:13:59 +0100 (CET)
Received: by mail-ua1-f41.google.com with SMTP id
 a1e0cc1a2514c-950c26b6b05so202172241.1
 for <dev@dpdk.org>; Wed, 18 Mar 2026 16:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773875638; cv=none;
 d=google.com; s=arc-20240605;
 b=lpyb+w3c4XPb9uk6I7P4Pq5a1UQBTbTZ2gRwDlWXm4HEIe9jXW9b+Rk2o8GaCGE/o9
 jFBgRAnAsNUeTzLdoiJa8FNlmtk3FQiDh/fq0F7GqSBU3VtKscCfAJIVn7yWBVMQg7Og
 Po5XeLecC6jNGjUqLIR2aX8i0Ruw5rqd5Ym+xAwNYwQQfjz342OT9ZWaSli7+TCBVx8k
 oA3KlfR6vPdqMbFJ8H7zKpWDL9rF8a+j6hLPm5CLftYgarWdT0aE+GG4gpclZwMWcMJy
 hpWfnHD2XMkdJsi1fRChrytn6U42jRu8zOTSJ4j1Q6E6bn9pTnjatOFA6gAU18dO063v
 eUgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=w7kwEQWFIfYCReLfeQjPVGbB1o+5ycyY/lYMPHbz6jM=;
 fh=D6svFMTzF3omGjREYzV5/2Oi1zXV6b//bUPExxTKeeE=;
 b=R9A2Xn8jPo23ffqEnvJYFtKCSB8vY1/64PLySRg3AX9sZozV4PcnR48FnNu03KYO/j
 n0fdZZw56swqPJZ+11Rl3iVv0nSIEZEvli4AtDJ3ihezqaS/2GCE9VCQxX7/UrkZ2Xzu
 pk/xRG7xc6sfLCG6ZwwMKm+qBdmYf/ImuCGJlzR0EOL+IfSBqJhF3AfVBf9q1tHKdMwv
 5Vjh90W1fwZA2fK7I2lQbAVfKYrEzumx2nHZXNdQ3zalXH6xUqsEATGHo+nABqghG86b
 /f0OPhRVIknwUdJsrWRJBXa855iyVw2yCZRJQj1SgonmJej6epdcHD76bRdOaWeJe1u4
 3QBg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773875638;
 x=1774480438; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w7kwEQWFIfYCReLfeQjPVGbB1o+5ycyY/lYMPHbz6jM=;
 b=eB4Ec6+qg+e/8kNCAAiIvmHlSyS4euT2fr1szymlcsvBrObw8+36W1sI/ciev9I94p
 jRZVticZaMjafSng1iixx/4LH1xtsHcieqkjgAHfUihfBvESCcd95UkdklNX0o3tvzF3
 W4mBhkswCqELmgFPX4truEsch0TprjTnUU47sTVK9SHUvokfSI9Nv8zm2ZzX0kueXoc5
 XyoEISj2vMUrYqVahshsc+9egq9OjWQ+HipKNfWMyo2AiOo5ZixuONVO4eNk/DZpozco
 CrKIGEe4ZMbdsxtaF/BY0GfPNF9ClE4lkYUs9NTzQoO6754ryw+MyXoK0wPYrPlYUZ7V
 Gcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773875638; x=1774480438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7kwEQWFIfYCReLfeQjPVGbB1o+5ycyY/lYMPHbz6jM=;
 b=r8sBsNyr8QvM7XctA/Rlr6U1PmkLSCuVgqE7tB75VW4uuzSeEa0nTEjzC+wiO+wOS5
 MFO0mCqFE6Q7b4C7M+mUCaPEdN5YuamV2qgQ77k0aXNrPjQuFvDy6v2eV1Og2gaBbLSf
 22vCHWL1Edxm9ayO97HYDwg/L47knmsClr8pLGFJNv34r2GyQY7tK0xNfhPfXv7deEg8
 S6ejG055Ty/enW/er8NlILu8y076KkNhEhUYwccelbnlrIA/ex+Og+10+DGoG1DSSsXl
 8WSMQi3KXLQk4ttDbL4UFlH+Kb6a8vrdFtYb+qqGZHnUt5SDjG69jU7gMwJkdtsdL1q1
 bg8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEFtKjeRwusQCmE03wcPDs2eGrDMGgTOHPpTLASuiVmvA0EYGny2KTd0PwaIxqTqr6Shw=@dpdk.org
X-Gm-Message-State: AOJu0YwgCu1BotTx/n+45So+CFM81scYIwDNNGZZwU0OtVIOyDF6deaL
 XXSj20oJxX8pHV2cr76u67z9KiYWAm9AoJZtT9V7dO/FNLByqxoAKef8YKHaFAkfLuiexnYSgX3
 P3kvJKKRy1Uesu1OF2ADecIbHwtnOsEW18ruOI2q+xA==
X-Gm-Gg: ATEYQzxt61JbZQcUX79OfyfW1MI+NU/F+k2J/t2AcwurVLtun74/rTwpVaGRyxuER/F
 zisnlDyzHFQnp1zb+pvUQRNVNa//HS+WBicD9j23/MRnZgnwEecGLcafZxpamUdJZzvn92jKFjd
 QbJkZp1BtonkB71KdWU9H7SHPOcPA9D004xBRmrQ363rPJgBc6AiecRj/EDgFP1mgqzRJ6KkZxf
 mU+pspV8ZOkQqSrdbLGkzFBq487r6VOUUTLImlXem41BiQNnQzzZ3jJAuoZB4figDZrNaPliVg3
 cEWiJfY=
X-Received: by 2002:a05:6102:4b89:b0:602:79ed:e5c5 with SMTP id
 ada2fe7eead31-60295f7ebf1mr715886137.15.1773875638181; Wed, 18 Mar 2026
 16:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260310122045.4057836-1-cfontain@redhat.com>
 <b10d0edcdaac4fd9a4f5a0261205670c@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6579F@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6579F@smartserver.smartshare.dk>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Wed, 18 Mar 2026 16:13:47 -0700
X-Gm-Features: AaiRm50VKb-9FGUNMJpNCmbQB7BUQNQXpTtu2pncsfKtox9pbDgxmWfKPdhDPO4
Message-ID: <CAOaVG142M=OfvUH8_-c9aHn7D_4-0KgyWVxyuHjDq8ttiga2Hw@mail.gmail.com>
Subject: Re: [PATCH] bpf/arm64: support packet data load instructions
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: Marat Khalili <marat.khalili@huawei.com>,
 Christophe Fontaine <cfontain@redhat.com>, dev <dev@dpdk.org>, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>, 
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Content-Type: multipart/alternative; boundary="0000000000004a2cf8064d549b6a"
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

--0000000000004a2cf8064d549b6a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dpdk doesn't yet support these negative offsets.
But it is not worth doing until upstream libpcap is fixed.
Right now, libpcap hard codes knowledge about the destination being a live
linux capture into pcap_ compile. Filed a bug on that several years ago but
no real fix came. Maybe time to send AI into libpcap

On Wed, Mar 18, 2026, 5:54 AM Morten Br=C3=B8rup <mb@smartsharesystems.com>
wrote:

> > > +static void
> > > +emit_ld_mbuf(struct a64_jit_ctx *ctx, uint32_t op, uint8_t tmp1,
> > uint8_t tmp2,
> > > +   uint8_t src, uint32_t imm)
> >
> > Handling immediate as unsigned is questionable, especially in the
> > BPF_IND case
> > it may produce incorrect results.
>
> In Classic BPF (cBPF), when the immediate "k" is negative (when cast to
> signed integer), it is used for getting packet metadata (e.g.
> SKF_AD_VLAN_TAG gets the VLAN ID); otherwise it is considered unsigned.
>
> >
> > To make things worse, `__rte_pktmbuf_read` is also buggy when passed
> > very large
> > lengths (again, technically not ARM eBPF fault).
>
> Are you referring to the potential integer wraparound in the off+len >
> rte_pktmbuf_pkt_len(m) comparison?
> [BZ1724]
> Or some other bug in __rte_pktmbuf_read()?
>
> [BZ1724]: https://bugs.dpdk.org/show_bug.cgi?id=3D1724
>
> >
> > > +{
> > > +   uint8_t r0 =3D ebpf_to_a64_reg(ctx, EBPF_REG_0);
> > > +   uint8_t r6 =3D ebpf_to_a64_reg(ctx, EBPF_REG_6);
> > > +   uint32_t mode =3D BPF_MODE(op);
> > > +   uint32_t opsz =3D BPF_SIZE(op);
> > > +   uint32_t sz =3D bpf_size(opsz);
> > > +   int16_t jump_to_epilogue;
> > > +
> > > +   /* r0 =3D mbuf (R6) */
> > > +   emit_mov_64(ctx, A64_R(0), r6);
> > > +
> > > +   /* r1 =3D off: for ABS use imm, for IND use src + imm */
> > > +   if (mode =3D=3D BPF_ABS) {
> > > +           emit_mov_imm(ctx, 1, A64_R(1), imm);
> > > +   } else {
> > > +           emit_mov_imm(ctx, 1, tmp2, imm);
> > > +           emit_add(ctx, 1, tmp2, src);
> > > +           emit_mov_64(ctx, A64_R(1), tmp2);
> > > +   }
> > > +
> > > +   /* r2 =3D len */
> > > +   emit_mov_imm(ctx, 1, A64_R(2), sz);
> > > +
> > > +   /* r3 =3D buf (SP) */
> > > +   emit_mov_64(ctx, A64_R(3), A64_SP);
> > > +
> > > +   /* call __rte_pktmbuf_read */
> > > +   emit_call(ctx, tmp1, __rte_pktmbuf_read);
> > > +   /* check return value of __rte_pktmbuf_read */
> > > +   emit_cbnz(ctx, 1, A64_R(0), 3);
> > > +   emit_mov_imm(ctx, 1, r0, 0);
> > > +   jump_to_epilogue =3D (ctx->program_start + ctx->program_sz) - ctx=
-
> > >idx;
> > > +   emit_b(ctx, jump_to_epilogue);
> >
> > Could we call emit_return_zero_if_src_zero here instead?
> >
> > > +
> > > +   /* r0 points to the data, load 1/2/4 bytes */
> > > +   emit_ldr(ctx, opsz, A64_R(0), A64_R(0), A64_ZR);
> > > +   if (sz !=3D sizeof(uint8_t))
> > > +           emit_be(ctx, A64_R(0), sz * CHAR_BIT);
> > > +   emit_mov_64(ctx, r0, A64_R(0));
> > > +}
> > > +
> >
> > I would also pass final verdict on ARM code to ARM folks. To my
> > untrained eye
> > it looks correct apart from the signed immediate issue. Optimizations
> > are
> > possible, but since we're only implementing slow path for now maybe not
> > worth
> > the effort.
>

--0000000000004a2cf8064d549b6a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Dpdk doesn&#39;t yet support these negative offsets.=C2=
=A0<div dir=3D"auto">But it is not worth doing until upstream libpcap is fi=
xed.</div><div dir=3D"auto">Right now, libpcap hard codes knowledge about t=
he destination being a live linux capture into pcap_ compile. Filed a bug o=
n that several years ago but no real fix came. Maybe time to send AI into l=
ibpcap</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 18, 2026, 5:54 AM Morten Br=
=C3=B8rup &lt;<a href=3D"mailto:mb@smartsharesystems.com">mb@smartsharesyst=
ems.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">&gt; &gt; +static void<br>
&gt; &gt; +emit_ld_mbuf(struct a64_jit_ctx *ctx, uint32_t op, uint8_t tmp1,=
<br>
&gt; uint8_t tmp2,<br>
&gt; &gt; +=C2=A0 =C2=A0uint8_t src, uint32_t imm)<br>
&gt; <br>
&gt; Handling immediate as unsigned is questionable, especially in the<br>
&gt; BPF_IND case<br>
&gt; it may produce incorrect results.<br>
<br>
In Classic BPF (cBPF), when the immediate &quot;k&quot; is negative (when c=
ast to signed integer), it is used for getting packet metadata (e.g. SKF_AD=
_VLAN_TAG gets the VLAN ID); otherwise it is considered unsigned.<br>
<br>
&gt; <br>
&gt; To make things worse, `__rte_pktmbuf_read` is also buggy when passed<b=
r>
&gt; very large<br>
&gt; lengths (again, technically not ARM eBPF fault).<br>
<br>
Are you referring to the potential integer wraparound in the off+len &gt; r=
te_pktmbuf_pkt_len(m) comparison?<br>
[BZ1724]<br>
Or some other bug in __rte_pktmbuf_read()?<br>
<br>
[BZ1724]: <a href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1724" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://bugs.dpdk.org/show_bug.cgi?=
id=3D1724</a><br>
<br>
&gt; <br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0uint8_t r0 =3D ebpf_to_a64_reg(ctx, EBPF_REG_0);<br=
>
&gt; &gt; +=C2=A0 =C2=A0uint8_t r6 =3D ebpf_to_a64_reg(ctx, EBPF_REG_6);<br=
>
&gt; &gt; +=C2=A0 =C2=A0uint32_t mode =3D BPF_MODE(op);<br>
&gt; &gt; +=C2=A0 =C2=A0uint32_t opsz =3D BPF_SIZE(op);<br>
&gt; &gt; +=C2=A0 =C2=A0uint32_t sz =3D bpf_size(opsz);<br>
&gt; &gt; +=C2=A0 =C2=A0int16_t jump_to_epilogue;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0/* r0 =3D mbuf (R6) */<br>
&gt; &gt; +=C2=A0 =C2=A0emit_mov_64(ctx, A64_R(0), r6);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0/* r1 =3D off: for ABS use imm, for IND use src + i=
mm */<br>
&gt; &gt; +=C2=A0 =C2=A0if (mode =3D=3D BPF_ABS) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0emit_mov_imm(ctx, 1, A6=
4_R(1), imm);<br>
&gt; &gt; +=C2=A0 =C2=A0} else {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0emit_mov_imm(ctx, 1, tm=
p2, imm);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0emit_add(ctx, 1, tmp2, =
src);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0emit_mov_64(ctx, A64_R(=
1), tmp2);<br>
&gt; &gt; +=C2=A0 =C2=A0}<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0/* r2 =3D len */<br>
&gt; &gt; +=C2=A0 =C2=A0emit_mov_imm(ctx, 1, A64_R(2), sz);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0/* r3 =3D buf (SP) */<br>
&gt; &gt; +=C2=A0 =C2=A0emit_mov_64(ctx, A64_R(3), A64_SP);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0/* call __rte_pktmbuf_read */<br>
&gt; &gt; +=C2=A0 =C2=A0emit_call(ctx, tmp1, __rte_pktmbuf_read);<br>
&gt; &gt; +=C2=A0 =C2=A0/* check return value of __rte_pktmbuf_read */<br>
&gt; &gt; +=C2=A0 =C2=A0emit_cbnz(ctx, 1, A64_R(0), 3);<br>
&gt; &gt; +=C2=A0 =C2=A0emit_mov_imm(ctx, 1, r0, 0);<br>
&gt; &gt; +=C2=A0 =C2=A0jump_to_epilogue =3D (ctx-&gt;program_start + ctx-&=
gt;program_sz) - ctx-<br>
&gt; &gt;idx;<br>
&gt; &gt; +=C2=A0 =C2=A0emit_b(ctx, jump_to_epilogue);<br>
&gt; <br>
&gt; Could we call emit_return_zero_if_src_zero here instead?<br>
&gt; <br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0/* r0 points to the data, load 1/2/4 bytes */<br>
&gt; &gt; +=C2=A0 =C2=A0emit_ldr(ctx, opsz, A64_R(0), A64_R(0), A64_ZR);<br=
>
&gt; &gt; +=C2=A0 =C2=A0if (sz !=3D sizeof(uint8_t))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0emit_be(ctx, A64_R(0), =
sz * CHAR_BIT);<br>
&gt; &gt; +=C2=A0 =C2=A0emit_mov_64(ctx, r0, A64_R(0));<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; <br>
&gt; I would also pass final verdict on ARM code to ARM folks. To my<br>
&gt; untrained eye<br>
&gt; it looks correct apart from the signed immediate issue. Optimizations<=
br>
&gt; are<br>
&gt; possible, but since we&#39;re only implementing slow path for now mayb=
e not<br>
&gt; worth<br>
&gt; the effort.<br>
</blockquote></div>

--0000000000004a2cf8064d549b6a--
