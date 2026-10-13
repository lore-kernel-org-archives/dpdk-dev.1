Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8B3CC6B19
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 16:31:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF26640274;
	Tue, 13 Oct 2026 18:31:46 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id 1CCE540272
 for <dev@dpdk.org>; Tue, 13 Oct 2026 18:31:44 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-88bc25fcd0eso2326214b3a.2
 for <dev@dpdk.org>; Tue, 13 Oct 2026 09:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791909104;
 x=1792513904; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BguTl69MeUEJf/mbRvrvkCtpeEbDeEyOmfJg486t14I=;
 b=nRR9v50CKa+TF8uV2Hija/vaXonp5VTFkEXYybRyaDBPdT4V68GGgkR9x9QelIsf2U
 WLYhaNG2lQCcKfLdwgwG1PohOlpMv1uHkDYKTHO0Gvw28ZfmGc11uAXmgKuPMx0T2DEV
 0vEP5FzDG0bXWeLbljOKO50zgK8akg72yXVrC28B0YLwpLN8mAuk+1nFQa8KYXJ3WgNM
 4MhFHZz5wbM9U/s1yTvFUu1GGp0sbY4Ztk1b3CwdukHR35f6xbRVxKHP62g2xrK05fgG
 6TKvOM8lJ3teYt5WUSLRI4G57tKbG+9X4wOO5UGCFDg/Aeh56oCt1di3Vsv3zoWeaBQD
 qDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791909104; x=1792513904;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BguTl69MeUEJf/mbRvrvkCtpeEbDeEyOmfJg486t14I=;
 b=vHC6lEgNcma/b5/tzyCC2dH+g7t/6Dk+CmNUYwTqJPo1vkIDfalP8BOQt/t4nY9U5i
 ceuTq0Jf1r3+bGsFfJXj2Ab9YLY6fOXvDpPVa6p8FEyZ/f3ASCvgnBorqBdUYBwPZuQw
 a8ptR5EAQkvAI4vrVI8Vc3B34gs55Ucna7B6qYLMupIQEMG8M8NzoCXM845oJgLFJdLD
 BUEKjP1MVcPYS4irzg1LcFxwGlnFqd2ROjT/6b4+7iID01043WwlzYRZklDhB5YJBfGz
 2Hdb+7FgQZaMNiBihFBw8QQAsnswFFSBL1SztAgCd7+9DbDtq/9+Q7sObvLEB/7a+ziv
 KPQA==
X-Forwarded-Encrypted: i=1;
 AKwUvByL5ExPZ0O1kqKxdOwD1xmtHSLJZITed2lnhn+F1RmyuzuPjx4azykPe/8lorm9AgZ0wdE=@dpdk.org
X-Gm-Message-State: AFq9FYIuiTLXvVTCjpaUMNNdZ5DFmOg93gWJe0nnHcjxNk0Ab1ZSNSnX
 Fy9460IWccCQtjgc0gAgFKngxvkVYNX/WviOf/jPxIM3+31r2gN2Fkja0zTrMxdyjs4=
X-Gm-Gg: AYBFou3y+7pisqmcXrIlWj2eOCn5D6VKgi5s69n7FFvcFHIQDkRgnyZah0bYQE+jc8o
 LRsBvNWnLYTaTxj0TDGWqs43bfHhsH11pOUFP3qbIU0Qg3od+vcSvQPBc9pofgUfGK9MwUT9BIP
 q9wzdLZAkOkLmyqIypGk/R26aCBFIXx1RH+PL7wQi33+f4Tsp2fXVIsiQP9Clkr0J+JYVtZEl60
 V2Rk73zRpwgy32FnAV7i9boxqZdJPcFRaNi4HQ3JUy8IrYFI7kZo10MkDXdhm34pIclHKKtN4rU
 C1ShELZNYNfGkDFZNCDcj1TLL2c70ZpmOwcmKK5ToLPV73etjo0noP495isv+efv/qDUWvO46aw
 57p+TW2RvktbnH1oCuO7kQYlnvzBvZ0IdGgGTl3sfsZP1bOmkSSt6IboY7MBceEpW4eWGoIeh/M
 k4qtD8pFkFgl/R4vhf067FagXfwR2HlgNqLtf+PInXdRpSIGSatEERwljWUxOrfkeJLd+Xq8ytL
 FqTTpMM6tSFGCHU/uVOXaxlooAJw7co6iWl3Bhr
X-Received: by 2002:a05:6a21:4eac:b0:3dd:a00a:170f with SMTP id
 adf61e73a8af0-3e16be93987mr11879210637.42.1791909103975; 
 Tue, 13 Oct 2026 09:31:43 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd3d9e3dafesm5686955a12.20.2026.10.13.09.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 09:31:43 -0700 (PDT)
Date: Tue, 13 Oct 2026 09:31:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <qm2k21@gmail.com>
Cc: David Marchand <david.marchand@redhat.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, dev@dpdk.org, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v3 01/29] bpf: replace deprecated SMP barriers with C11
 fences
Message-ID: <20261013093140.6b763438@phoenix.local>
In-Reply-To: <31fc3286-242e-4104-9247-330a3d1ce217@gmail.com>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
 <20261008233649.1260843-2-stephen@networkplumber.org>
 <b9d3cb13-e34f-406d-ac18-345fede8bc5b@arm.com>
 <6888e84c-e250-4ed9-ad70-46178014eb15@gmail.com>
 <CAJFAV8zWR0PPrSNzwMyP=2wFFTpjCq4dWFs9X0HSjkCNXVF2mg@mail.gmail.com>
 <31fc3286-242e-4104-9247-330a3d1ce217@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, 13 Oct 2026 17:04:33 +0100
Marat Khalili <qm2k21@gmail.com> wrote:

> On 13/10/2026 08:54, David Marchand wrote:
> > This blocks the SMP barrier removal for rc1.
> >
> > What is your proposal?
> >
> > I think it makes sense to take
> > https://patchwork.dpdk.org/project/dpdk/list/?series=3D39599 first, then
> > resolve the conflict for the patch from this thread.
> > Is this BPF series ready for merge?
> >
> > If it is not ready yet, what should be done on the current patch?
> > Is a s/rte_smp_rmb()/rte_atomic_thread_fence(rte_memory_order_seq_cst)/=
 enough?
> > The commitlog would also need some rewritting. =20
>=20
> I think we should be able to unblock this patchset with the diff below.=20
> Last version contains some additional out-of-scope changes that might=20
> not be helpful in the long run, but I tend to believe Stephen and=20
> Wathsala that they are not breaking anything (I have not checked it=20
> myself). If the version below is ok with Stephen I would prefer it=20
> (consider it acked), otherwise I can withdraw my NAK for the sake of the=
=20
> release, at the cost of some potentially confusing noise in the commit=20
> history in the future.
>=20
> diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
> index f072fdaaed..0d0c37cdc5 100644
> --- a/lib/bpf/bpf_pkt.c
> +++ b/lib/bpf/bpf_pkt.c
> @@ -82,7 +82,7 @@ bpf_eth_cbi_inuse(struct bpf_eth_cbi *cbi)
>  =C2=A0{
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 cbi->use++;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* make sure no store/load reordering could =
happen */
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_smp_mb();
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_atomic_thread_fence(rte_memory_order_seq_=
cst);
>  =C2=A0}
>=20
>  =C2=A0/*
> @@ -92,7 +92,7 @@ static __rte_always_inline void
>  =C2=A0bpf_eth_cbi_unuse(struct bpf_eth_cbi *cbi)
>  =C2=A0{
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* make sure all previous loads are complete=
d */
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_smp_rmb();
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_atomic_thread_fence(rte_memory_order_rele=
ase);
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 cbi->use++;
>  =C2=A0}
>=20
> @@ -105,7 +105,7 @@ bpf_eth_cbi_wait(const struct bpf_eth_cbi *cbi)
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t puse;
>=20
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* make sure all previous loads and stores a=
re completed */
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_smp_mb();
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_atomic_thread_fence(rte_memory_order_seq_=
cst);
>=20
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 puse =3D cbi->use;
>=20
> @@ -439,7 +439,7 @@ bpf_eth_cbi_unload(struct bpf_eth_cbi *bc)
>  =C2=A0{
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* mark this cbi as empty */
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 bc->cb =3D NULL;
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_smp_mb();
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_atomic_thread_fence(rte_memory_order_seq_=
cst);
>=20
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* make sure datapath doesn't use bpf anymor=
e, then destroy bpf */
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 bpf_eth_cbi_wait(bc);
>=20

I am not a language lawyer, but what I read is that C11 atomic fence
is defined to only guarantee ordering of atomic objects. Since the use
counter is not atomic in the original code, the replacement with
rte_atomic_thread_fence() is not the same as original asm.

My patch made these atomic and that is why.

Should have no impact in datapath.

I will respin with better human oriented comments, I have developed
a distaste for AI prose. Reads like a lawyer wrote it.
