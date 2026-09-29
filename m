Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AAFC9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 13:54:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B65FF427CF;
	Tue, 29 Sep 2026 15:54:13 +0200 (CEST)
Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com
 [74.125.228.38]) by mails.dpdk.org (Postfix) with ESMTP id E46FF4026E
 for <dev@dpdk.org>; Tue, 29 Sep 2026 15:54:11 +0200 (CEST)
Received: by mail-pz2-f38.google.com with SMTP id
 d2e1a72fcca58-882c2bcef77so1618651b3a.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 06:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690051;
 x=1791294851; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3sCzALB5s0rf2nxMuQQClDqwf458TzK0On+PP2fuXIc=;
 b=nV6r/veOEVw4n+Ywh96kO5NZfdqHke4SegEQqG7pOm+Cs/4Ww/Z+CMR0uTtj6AfgSS
 AXG5rPBSNdpf1eZOpMZmM+CaGE4/fLut1e0xM26OZyZgHvR995JfMOtYMlEzTJPz8tLr
 fHdkBIrEtml4z31MfwQe9s7ZJWJc8xuyHgHDwX1SBQxyq1/nc1HF3hi88BSUQLVGariB
 c+LrtGQznqtrlC4xi1G+P636+e1J+vJ/diFqqVhJ8RvNzsr/ROaDZ7FU4KfR+0qeLE2f
 ul2S0mDHEwxsmKwP6faG3ZGFamoF/10pEPNCKj61Usdlarv0MOV4u4PBhEEbgD1L1fem
 QJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690051; x=1791294851;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3sCzALB5s0rf2nxMuQQClDqwf458TzK0On+PP2fuXIc=;
 b=Z0jSjsHu+TppzvO7awb/H0Pg5RJScRejOFapiXBJ5RBKPLD8imwPLmyY2i6i67zTNM
 GAbrKcShUDxPz4iiDDP+sS3pP+fU5N0EP9rp0DazklWc575sl5q/vOZKEhlr7Tmdvvt9
 VwPWj0E5DaLgE8M+mxle+dcCglCSWNOp3hceN64mwY12UHrwMN3dBeygEfhPUgBa3hV1
 3N1XZOBYWchmQytl4iVMW1/UyxEnUqobHPHu15o6QfdYkMSrlHTXwRN5uyZlQKBVrHTi
 VB3jE0b4Xs4TL/taf25XaAq4qck1Y7W0gJsYXC175CB9+L5REqV8q2noxnG9qw8+7tn4
 xqBA==
X-Gm-Message-State: AFuF++kMSfdhU0xyI/Us/VGdzAtpKWxDC20yWukT80Ge8v4iTfA40QNo
 Amq/PQA2E1kIAmmrqtOGr7Q5VpEL/xpvI1XajK9alc36zcvf7IXeRQxJvHoJ1lqeAsg=
X-Gm-Gg: AYBFou24+05XqpB1wePh6GYiUp81J8b6024B2dp18yEo2sNYAhoxnLQYDpDQich2PHn
 hC7H02k05fZ9wfjW3mfbUUKVC7QB1W54+VWctgX4PCvg3Tn8MaU3xAqAq0aMWXUS/KgmibecMMh
 XtHFsFxEAAQlVE4TpLbYYMbxtfE+mYow999lFQNckK3G4FEwllB0qC1cRv/o0V1QH1lb4840N3y
 IoIjgY7QaT22Yq8K7mlDalmhSYE68qzSKNTC+Hg97xj7L4TnW9VnWBx9E/J9uR7m8cLv8qrn59X
 vlsv1lqRUytPMcHnMkuLHGszIPp5KGp05Mi5UdU+gv23V7wntS+ayMER66rQ8ZuoXnqWlwa6nO5
 sMvpuLL0cIhFUOs13HANUxN5KTMKeotFxlL6oClVezBfMl5wEHFPwdIuhO3O3+UyduVkuG1/9qP
 GpCQC8D6kaG+9b1yOoeDR0ppCg/p0H99EsoBef40KJIZI2HDluQRvheidm9f4DNbapfpy25AwG5
 ONBMTSPH1eJuvClrJpjdQVIyXE3qcL2ut12U4Ri1pjoI53J4BFG
X-Received: by 2002:a05:6a21:2d04:b0:3da:7154:2ebf with SMTP id
 adf61e73a8af0-3de26c12c5fmr12287108637.9.1790690051094; 
 Tue, 29 Sep 2026 06:54:11 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc7cf5a2f74sm497779a12.10.2026.09.29.06.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 06:54:10 -0700 (PDT)
Date: Tue, 29 Sep 2026 06:54:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Shai Brandes <shaibran@amazon.com>, Evgeny Schemeilin
 <evgenys@amazon.com>, Amit Bernstein <amitbern@amazon.com>, Wajeeh Atrash
 <atrwajee@amazon.com>
Subject: Re: [PATCH v8 04/25] net/ena: replace use of rte_atomicNN
Message-ID: <20260929065408.67ebd9ff@phoenix.local>
In-Reply-To: <CAJFAV8z2m58Oh-b-aTBkCJuW7c7q6iqvHhjfvV4TVVx63cy2qg@mail.gmail.com>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260917201119.2168234-1-stephen@networkplumber.org>
 <20260917201119.2168234-5-stephen@networkplumber.org>
 <CAJFAV8z2m58Oh-b-aTBkCJuW7c7q6iqvHhjfvV4TVVx63cy2qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 29 Sep 2026 10:07:09 +0200
David Marchand <david.marchand@redhat.com> wrote:

> On Thu, 17 Sept 2026 at 22:12, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > Convert the legacy rte_atomicNN operations to stdatomic.
> > * Remove variable ena_alloc_cnt is defined by not used.
> >   It is a leftover from previous memzone naming scheme.
> >
> > * Convert the legacy rte_atomic32_t and rte_atomic32_{inc,dec,set,read}
> >   macros to C11 stdatomic equivalents.
> >   Memory ordering is kept at seq_cst,
> >   matching the implicit ordering of the legacy API.
> >
> > * Do not use rte_atomic for statistics
> >  The DPDK PMD model is that statistics do not have to be exact
> >  in face of contention.  
> 
> AI complains about the change:
> """
> While the DPDK guidelines do accept that statistics may be approximate
> under contention, the problem here is that **concurrent non-atomic
> increments are undefined behavior in C**. Multiple Rx queues (each
> potentially on different lcores) can increment `ierrors`
> simultaneously. A non-atomic `++` involves a read-modify-write
> sequence that is not atomic, leading to:
> - Lost updates (the classic lost-update problem)
> - Potential torn reads/writes on some architectures
> 
> The correct approach would be to use `rte_atomic_fetch_add_explicit()`
> with `rte_memory_order_relaxed`. Relaxed ordering is appropriate for
> statistics counters where approximate values are acceptable, but the
> operation must still be atomic to avoid undefined behavior.
> """
> 

AI wants all DPDK statistics to use atomic, but that is not the
model we use in DPDK. DPDK trades off performance for the potential
for inexact statistics. The commit message says that.

This is a false positive.
