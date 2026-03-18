Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AA7103E198
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 15:34:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80F58402A0;
	Wed, 18 Mar 2026 16:34:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id EBFAD4026F
 for <dev@dpdk.org>; Wed, 18 Mar 2026 16:34:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773848087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a+irwc+NbgcDJi64PcmWJtqi/ugJ+CTAZwDfgkdH4Js=;
 b=d7zeJZpBucXBUfVYl2ThEhmgRAVgn7XaZYpayd1476zAnol9oDTIEHxYMmxCvRMYUxa3pj
 ZrE4xEa0qGCxqzNL8svyBtBXberkpuUKbnikLyqjAjYbDDrprjrITbWT9f0rVNQgAmRw1u
 /Fn7UtVJAIjUpc9e7je78Ug4+rbDsyI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-Lf67fN-KNN-CATV8td4VQA-1; Wed, 18 Mar 2026 11:34:44 -0400
X-MC-Unique: Lf67fN-KNN-CATV8td4VQA-1
X-Mimecast-MFC-AGG-ID: Lf67fN-KNN-CATV8td4VQA_1773848082
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-38ad32615dbso73301fa.2
 for <dev@dpdk.org>; Wed, 18 Mar 2026 08:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773848082; x=1774452882;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a+irwc+NbgcDJi64PcmWJtqi/ugJ+CTAZwDfgkdH4Js=;
 b=Lxr8/kng28oQOzUUTu0OaJmiLPBOjlQFCmDTL4Y6JG37cF/zryqAaOTKIsLFciE6KN
 jcdCY06r/8FY4wtVHfsc4IJz/gCAHc/oclMx/eGHIbRVe/zqmIOW3Rs1FWO66ryzUXrL
 CBpTdWeQ6/1P4xXdUssVTpRO/B7lylpyxnwg3ioQCcySCkC8KDWTbi0hboMtJxI4N7/m
 +GzkAO8wb6xneql0wZ4Up5wyghBJYFJyJY6YT8Zu5L7abXc9tto7zfZY+QHnDXxh2P4B
 wraq7Fn2wlAGXYtJGXncDHX5aoXUxIqYRoNqjtFyQkOStjSao78lJ2W+bfDFkDhmkQsn
 xyZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUfdOvUE+Zk13rq+mNsxL0CfgKSCOVWRqM1Up0uejeMWeSP5BNL6kt3XvWN2CYgsP8tDs=@dpdk.org
X-Gm-Message-State: AOJu0Yw8poTIbLVT5gjSY8IeKAdunxAtr06LSZiBGMu7bQ5nEBXS+Q1c
 FuZj0/7FDyonowaYMwZVAFPAGuFNBC8DbIaLO4Pex/mhiFH0xvVVD0L0OaQcj1awD0f/qNby1+J
 5k3I6L9G5XX9+L10ePp2MRKcgcibFj6pZJe15NogSCL/jjn/rD2WrMmkqs9ma8sz4ALMSk9kQms
 ukvChveOByK9uopmLYTJs=
X-Gm-Gg: ATEYQzxtt2WzYw/AvT88E6VXSVt8XnoWLAim8JCs2ur0xa4xRe3cJs81mFVIPOWaY49
 /s1jMwmU6JJCBJ3TTB7bRuR2XENLpcdbN2tmfMYw2Gv/Nqo+Xd0iRzAm2Ak56ZHDmwY76DAJWCO
 2ty4n15Na9YjMvFgyDlGNCJjQFqECGaiuMQ441oS6POi+ISLvTdHp0sVWinCWIGwic8+h9iEgI6
 JgqypHDGyG8SAmpGxAPWGX+RLgvcYPKoQmfhw2w
X-Received: by 2002:a05:651c:2554:20b0:38a:2719:81f2 with SMTP id
 38308e7fff4ca-38bd59bf8c3mr12870321fa.37.1773848082287; 
 Wed, 18 Mar 2026 08:34:42 -0700 (PDT)
X-Received: by 2002:a05:651c:2554:20b0:38a:2719:81f2 with SMTP id
 38308e7fff4ca-38bd59bf8c3mr12870151fa.37.1773848081748; Wed, 18 Mar 2026
 08:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260310122045.4057836-1-cfontain@redhat.com>
 <b10d0edcdaac4fd9a4f5a0261205670c@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6579F@smartserver.smartshare.dk>
 <4942136acefe4fc3b5157191749fe3d5@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657A0@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F657A0@smartserver.smartshare.dk>
From: Christophe Fontaine <cfontain@redhat.com>
Date: Wed, 18 Mar 2026 16:34:30 +0100
X-Gm-Features: AaiRm50L3yO9wGBQbNxpAjULiblUtJuwKdCH2dgPdFsxTjHVjQ7tIVNiP9XojJk
Message-ID: <CAHVr2NmXSAhKO6EGjh_DDvdaUShPTWH-Eb1y1VrriQBAVnay4w@mail.gmail.com>
Subject: Re: [PATCH] bpf/arm64: support packet data load instructions
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: Marat Khalili <marat.khalili@huawei.com>, dev@dpdk.org, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>, 
 Wathsala Vithanage <wathsala.vithanage@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fpIUmQMIZvn2pU4k3cRqZdiCAEfKlNeKKY_9kMkSmz4_1773848082
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Mar 18, 2026 at 2:39=E2=80=AFPM Morten Br=C3=B8rup <mb@smartsharesy=
stems.com> wrote:
>
> > From: Marat Khalili [mailto:marat.khalili@huawei.com]
> > Sent: Wednesday, 18 March 2026 14.07
> >
> > > > Handling immediate as unsigned is questionable, especially in the
> > > > BPF_IND case
> > > > it may produce incorrect results.
> > >
> > > In Classic BPF (cBPF), when the immediate "k" is negative (when cast
> > to signed integer), it is used
> > > for getting packet metadata (e.g. SKF_AD_VLAN_TAG gets the VLAN ID);
> > otherwise it is considered
> > > unsigned.
> >
> > Yes. Since we don't support it, we should probably consider these
> > offsets invalid.
>
> +1
>
> >
> > And in the BPF_IND case one might be tempted to load end of some packet
> > area in
> > the register and use negative offsets, we probably should handle it
> > correctly.
>
> In Classic BPF, negative "k" has special meaning for both BPF_ABS and BPF=
_IND.
> So we should consider it invalid for both cases.
>
> That prevents applications from using it the way you describe.
> And it will allow us to add BPF library support for Linux-compatible spec=
ial meanings later, without breaking the ABI.
>

Aren't these invalid offsets already taken care during the syntax
check when we validate the BPF program ?
in bpf_validate.c +1499:
        /* load absolute instructions */
        [(BPF_LD | BPF_ABS | BPF_B)] =3D {
                .mask =3D {. dreg =3D ZERO_REG, .sreg =3D ZERO_REG},
                .off =3D { .min =3D 0, .max =3D 0},
                .imm =3D { .min =3D 0, .max =3D INT32_MAX},
                .eval =3D eval_ld_mbuf,
        },

IIUC, as __rte_bpf_validate fails when we cal rte_bpf_load ( in
bpf_load.c +113), we can't even interpret the cBPF program.

> >
> > > > To make things worse, `__rte_pktmbuf_read` is also buggy when
> > passed
> > > > very large
> > > > lengths (again, technically not ARM eBPF fault).
> > >
> > > Are you referring to the potential integer wraparound in the off+len
> > > rte_pktmbuf_pkt_len(m)
> > > comparison?
> > > [BZ1724]
> > > Or some other bug in __rte_pktmbuf_read()?
> > >
> > > [BZ1724]: https://bugs.dpdk.org/show_bug.cgi?id=3D1724
> >
> > Technically that one manifested itself in rte_pktmbuf_read (without
> > underscores), but essentially the root cause is the same. In the eBPF
> > BPF_ABS
> > case we could potentially rely on `__rte_pktmbuf_read` for refusing to
> > accept
> > negative values converted to large integers, but due to overflows we
> > cannot.
>
> Agree.
>
> The off+len wraparound in rte_pktmbuf_read() and __rte_pktmbuf_read() is =
clearly a bug, and not intentional.
> Reading the function documentation supports the conclusion that the wrapa=
round is a bug; the off and len parameters are unsigned, and the documentat=
ion says nothing about an ability to make them behave as signed.
>

