Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3593ACD37AC
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 May 2026 20:56:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17CCB402B6;
	Wed, 13 May 2026 22:56:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E86404025E
 for <dev@dpdk.org>; Wed, 13 May 2026 22:56:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778705798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cysCL0f1toLrOPTeUSOTePy9/M6fmH95m3fpRhHMBDM=;
 b=SaQTDk4dLMcytD2pc8R1QVdxZMCiyqyfpYx+jIMOrpv4cXn9Laytcs3B0ZS9aysj3hieaP
 8Cqzm/F6JuQMQNkxB6zSQbjULQt4MDAER258Lfoo5ZkcZp0iEu3ICx7s5rqQwFDuEBDF6K
 NMetYy387I7HccN/JmJS+VebZubQdRA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-jzWkQ72JNvi4_6hmHfOqHw-1; Wed, 13 May 2026 16:56:34 -0400
X-MC-Unique: jzWkQ72JNvi4_6hmHfOqHw-1
X-Mimecast-MFC-AGG-ID: jzWkQ72JNvi4_6hmHfOqHw_1778705794
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45dbbbf8d57so147781f8f.3
 for <dev@dpdk.org>; Wed, 13 May 2026 13:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778705793; x=1779310593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cysCL0f1toLrOPTeUSOTePy9/M6fmH95m3fpRhHMBDM=;
 b=RvfTcz2hOAUSt4nFi6A1P5IjzD8gppVlpdP/aDFXWF2aNgoQUr1kFk7gLKBOTHsZMw
 6HeA4+heXqmIWXhg+jdGy8ovVq6iFSEM/d/5N6pnvY+rnVTW7v+PKdVJN2ZKEAs7hwgy
 5h/dVIesRx6qwcgVaeyqHnAKWpGN+/ZUCCSfK2EmJ86Odgplv7JGddP/iwYhSuQgot/x
 i1vCkp1PjA13qTDxzX+4SMeDu8OqdEx0LCazXa4NOa4JO/fnLce9o6Fu35jdVH/FIejO
 xyVeVGL2oGvNMppaQaSn+eXuHTQ+bi3BRHlQo1cK9/MEftioDtDWC2ZiE8aJV31L28LB
 /5TA==
X-Gm-Message-State: AOJu0Yy0KFsbCpmsUJB+Rp9PdK0dFczg5zNfscEccgGqzc//a/S+a9Ry
 FNZnDNASQRFsYS77gr7jOPLlZ7V/Ta91VmjqrVIAu2D/xR0L8vQjnsmDbmjfy6O3Mn98wCKns3+
 OHdnHB6H/hthPPBxCaK+i8/J50UXZjpGX6jVWnQYG1nnOGn5CSHBGzRGjZFImXIwl5uNp31wSuI
 vIVwaAgjy16ppOT2Wkh6Q=
X-Gm-Gg: Acq92OESa1nF7uMbTQnkB/DokUOndZdBxZ+INeA6V1WIJfHpA+GsM5+cW6xjUG46nhm
 Tc0ffGeeD/GJsccHwgEXrhL3Av6wJ1iUUelAxrxhaTw0dgKjfQ61W+z4enuOHFlAqX0oqIiZrav
 qSTqkXBa+Dhz9DtS6vibVfuXssh2bYd1XgXKdDzfnjR86vz/8f0hgXVLoLpIJgAgPMSILFC14+h
 akpMWL5EW51Se2eNYIT/3RSacRJzEqyVgy8E0RUW1Txey4peQ==
X-Received: by 2002:a05:600c:5303:b0:48e:526e:101a with SMTP id
 5b1f17b1804b1-48fc9a1026amr88016645e9.12.1778705793565; 
 Wed, 13 May 2026 13:56:33 -0700 (PDT)
X-Received: by 2002:a05:600c:5303:b0:48e:526e:101a with SMTP id
 5b1f17b1804b1-48fc9a1026amr88016465e9.12.1778705793233; Wed, 13 May 2026
 13:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260310122045.4057836-1-cfontain@redhat.com>
 <20260319114500.9757-1-cfontain@redhat.com>
 <20260319114500.9757-3-cfontain@redhat.com>
 <CAHVr2N=DR9G8Wixv9sgov9Ks_DZkxbRHovn4ng0uME6GX8RboA@mail.gmail.com>
 <35f96fed-29d4-4a0b-b3a1-0f2c9fc6b60e@arm.com>
In-Reply-To: <35f96fed-29d4-4a0b-b3a1-0f2c9fc6b60e@arm.com>
From: Christophe Fontaine <cfontain@redhat.com>
Date: Wed, 13 May 2026 16:56:21 -0400
X-Gm-Features: AVHnY4J4yNAHIkGtRFRuAB96JmKxhMVhGWNpxy1Wj_VtpDy5xzAWwpuEH3xdMNM
Message-ID: <CAHVr2NmGRJNJW_CxFOv6u7+4LRJkKNf__FQqZyZe3Y7fEmJ1_A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] bpf/arm64: support packet data load instructions
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.ananyev@huawei.com>, 
 Marat Khalili <marat.khalili@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LV3fzRGRSHYFblpEqud9iNZ86hFQun1AnwEUxWnC04Y_1778705794
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

On Thu, Apr 9, 2026 at 7:24=E2=80=AFPM Wathsala Vithanage
<wathsala.vithanage@arm.com> wrote:
>
> Hi Christophe,
>
> Thanks for doing this work. I saw that you intend to submit a v3 due to
> failure in Ubuntu. Please, see my comment regarding emit_b below.
>
> >> +       /* A64_R(0) =3D mbuf->buf_addr */
> >> +       emit_mov_imm(ctx, 1, tmp1, offsetof(struct rte_mbuf, buf_addr)=
);
> >> +       emit_ldr(ctx, EBPF_DW, A64_R(0), r6, tmp1);
> >> +       /* tmp2 =3D * mbuf->data_off */
> >> +       emit_mov_imm(ctx, 1, tmp2, offsetof(struct rte_mbuf, data_off)=
);
> >> +       emit_ldr(ctx, BPF_H, tmp2, r6, tmp2);
> >> +
> >> +       /* A64_R(0) +=3D data_off + off */
> >> +       emit_add(ctx, 1, A64_R(0), tmp2);
> >> +       emit_add(ctx, 1, A64_R(0), A64_R(1));
> >> +
> >> +       /* End of Fast Path, skip slow path */
> >> +       emit_b(ctx, 4);
> >> +
> Followed by emit_b() above there is an emit_call(). It invokes
> emit_mov_imm() which could possibly generate different number of movk
> instructions depending on the address of the __rte_pktmbuf_read. So,
> emit_b(ctx, 4), may not  necessarily land at the intended location
> because there could be more than 4 instructions emitted by emit_call.

Hi
Very good point, this was probably the cause of the error on Ubuntu.
Sorry for the delay in responding to this patch, but I'm about to send
a new version, fixing (hopefully!) all the previous comments.
I'll add you in CC for the new version as well.

Christophe

> >> +       /* slow path, call __rte_pktmbuf_read */
> >> +       emit_call(ctx, tmp1, __rte_pktmbuf_read);
> >> +       /* check return value of __rte_pktmbuf_read */
> >> +       emit_return_zero_if_src_zero(ctx, 1, A64_R(0));
> >> +
> >> +       /* A64_R(0) points to the data, load 1/2/4 bytes into r0*/
> >> +       emit_ldr(ctx, opsz, r0, A64_R(0), A64_ZR);
> >> +       if (sz !=3D sizeof(uint8_t))
> >> +               emit_be(ctx, r0, sz * CHAR_BIT);
> >> +}
> >> +
> >>
>
> --wathsala
>
>

