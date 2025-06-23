Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61943C7115B
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 12:08:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56A914060C;
	Mon, 23 Jun 2025 14:07:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2C39A40151
 for <dev@dpdk.org>; Mon, 23 Jun 2025 14:07:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750680475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/K0JvZFEk68Hby6mFVixAhCWFXyZV7FDOhKO/EGWmts=;
 b=UjrX/Pg8HCrU2KP0c6Q5mUWjQOUAts55nRRL59sweUn9+TZ7+Lp29zmeboHU4KNIssYl8v
 pLOTp6T3JxgWJHQb/sj1wv/Vtzzm+qJE9sR09tFTn9PRRXDdUwGc7YuPYmHt37ObIft6l8
 LRSSIoMF++6PYr394J/H/Yg3BICnZQA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-eDMYx-s9NAqxxaaVUPOWcw-1; Mon, 23 Jun 2025 08:07:54 -0400
X-MC-Unique: eDMYx-s9NAqxxaaVUPOWcw-1
X-Mimecast-MFC-AGG-ID: eDMYx-s9NAqxxaaVUPOWcw_1750680473
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-553cff91724so2231896e87.2
 for <dev@dpdk.org>; Mon, 23 Jun 2025 05:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680473; x=1751285273;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/K0JvZFEk68Hby6mFVixAhCWFXyZV7FDOhKO/EGWmts=;
 b=XKedFU1cj0QxANjXGyX/vSenMYXeXZN65AdQAS/jV/739pImnwK4rB96+QUsfGRgY7
 t0sTmj6p4Ek/DBXkONRt4lNZsU8breKXlJqFAtXN/x+wJkzqJdIPHA5Rh1LFQyn4jj+c
 9OytGmFvNwdck/tBFNjOpih62VmsyvwW0jeId+Nte1oFcAZioPabUpZ0EGaLtRU875S6
 joUAlpL5tWywSV8NwrPuz4T6eQw6Oij2cGlVCccYoTRbwj3jrZYbT8TnGY2CXi+smpec
 verS0GePOQ5hMeLGnbH24hg2cYHaBUekxY5AYlbXIIqOkz8+RGdwimli+rGM7p7tdbJJ
 OotA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/HoEm2wTShf5SAAmTbWVOoKwL794f/S4FLY+QUp1nyOi/sD2iPGQhC1wlz7oYU579Scs=@dpdk.org
X-Gm-Message-State: AOJu0YxLBH7MUAYu/m1IZ35spv6+Z9+QxLbMA7jXD8HwehObBCZs4K0C
 71kATNHx8DegEKIxImYAZyR5Ssu7HhFD3HtrmpfN3KD6U2i007/HSRKhYEPUAxU6CX7ngDsZi3z
 E5C64VfCdD8DtVtedbKPtqLD/t0PgNllRsrAcKLBccN/YLt+9JUtXV7k0i6sAjqkaB1DJJgB6HE
 I9oVshuaOrf/1tRiy21q4=
X-Gm-Gg: ASbGncu565rOqg24Rxqr7Vjm6bWnYFWlET2VHZzvMQZiu0qQLdH6NCGp4YShNUSakvo
 mVh0/zflxjKjpwZhBfeJgLv4XsnFSLwGGTLa8sxWHuzxzC5Ye/46+4S4KshMSQ4vYoEqgQYG9SU
 HAx8rQPg==
X-Received: by 2002:a05:6512:3ca1:b0:553:2f27:e96b with SMTP id
 2adb3069b0e04-553e3b9af09mr3384899e87.2.1750680472855; 
 Mon, 23 Jun 2025 05:07:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy/g5bGtPo3d0H7hkJG+Zl5bbtdZCs3/KtbC4K+L5kpH1rpKafVvhXRtvg7fdDx26MPP0sNnVWlJWJaamFPPA=
X-Received: by 2002:a05:6512:3ca1:b0:553:2f27:e96b with SMTP id
 2adb3069b0e04-553e3b9af09mr3384883e87.2.1750680472449; Mon, 23 Jun 2025
 05:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250617151339.28794-1-marat.khalili@huawei.com>
 <20250617151339.28794-2-marat.khalili@huawei.com>
 <CALBAE1M2Ux9Kr2GvS7BjNLn8nM_DvjWnkhp2pwdESKq-WJeRiw@mail.gmail.com>
 <df33e20237384492bd1fafbdd2e71c56@huawei.com>
 <CALBAE1Mggs++Wi34uxFU_hp8fOhn9=Nfuy+dAOTU83JucsWTdA@mail.gmail.com>
 <f09fa980a01443ebaec61ad7fbe5f436@huawei.com>
 <5f12c8f250084fa3bb40c994cf8ea095@huawei.com>
In-Reply-To: <5f12c8f250084fa3bb40c994cf8ea095@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 23 Jun 2025 14:07:39 +0200
X-Gm-Features: AX0GCFudL79yZe1pvJtSlBPwtjqzK9SbRDBjkcAo45d4Jb_aWQGJOyBd3jTRWsA
Message-ID: <CAJFAV8y9WPa8xGFSPaAzhSvD-Fb8fr8QgFyQSGV2zDT=Bzgc7Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] lib/graph: default-align rte_graph_cluster_stats
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Jerin Jacob <jerinjacobk@gmail.com>, Jerin Jacob <jerinj@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Zhirun Yan <yanzhirun_163@163.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>,
 "dev@dpdk.org" <dev@dpdk.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AOxN2YkmM6HCpw1XAN3nx8h881jRbVo_aTzOJZtlzLg_1750680473
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

On Mon, Jun 23, 2025 at 10:53=E2=80=AFAM Marat Khalili <marat.khalili@huawe=
i.com> wrote:
>
> Gently reminding about this issue, I still hope to see graph tests passin=
g under sanitizer.

Thanks for trying to fix this, but without coverage on the topic, it
is likely we will have new errors in the future.

Now that the trace framework has been fixed (856aef55de95 ("trace: fix
undefined behavior in register")), enabling UBSan in the CI has become
easier.
Could you spend some time on reviewing patches on the topic?
Like for example: https://patchwork.dpdk.org/project/dpdk/list/?series=3D35=
509


>
> We cannot just remove __rte_cache_aligned from rte_graph_cluster_stats wi=
thout removing it from rte_graph_cluster_node_stats because of how C works.=
 But we can perhaps use rte_malloc to align our allocations in a way that m=
atches the declaration. Would it be an ok solution?

rte_malloc is not required.
I have a fix in an branch of mine, that makes use of aligned_alloc
(which is C11), you need to manually copy data in stats_mem_populate.


--=20
David Marchand

