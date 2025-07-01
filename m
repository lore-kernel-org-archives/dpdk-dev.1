Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E270DC8302F
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 07:56:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0A3840269;
	Tue,  1 Jul 2025 09:56:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 434F9400D7
 for <dev@dpdk.org>; Tue,  1 Jul 2025 09:56:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751356578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cqKVe0zEqKcAnOj2xrFrRDuPK9dNJoAXOtMjAns2dvw=;
 b=Gdc56TTtQaD5vBKXTvMKb8trexMDe3ceY9PVwwNjCnNldDLBeLOiQUGi08DuyuclisjtM+
 1c65QeC1mbwIaPu4ZS7V7BJ6dGTJaW6/uVZ5AbYKfQ8PBIgdiMlC3JaLTyha32Mg7Ryk+Q
 8Rhebxfxz9a8fRbexZ5RR20BJ4PHwmw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-E3TOpaKWOyy8UCjTuYiFGQ-1; Tue, 01 Jul 2025 03:56:17 -0400
X-MC-Unique: E3TOpaKWOyy8UCjTuYiFGQ-1
X-Mimecast-MFC-AGG-ID: E3TOpaKWOyy8UCjTuYiFGQ_1751356576
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-32b8579063bso19422871fa.2
 for <dev@dpdk.org>; Tue, 01 Jul 2025 00:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751356576; x=1751961376;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cqKVe0zEqKcAnOj2xrFrRDuPK9dNJoAXOtMjAns2dvw=;
 b=evSy9jjEs2n5y9heZnouFo7V4NSaW/CDq8ttHajIvpBJreDvI6vsZRUJN7Nf6/LlF3
 nOPGddyeE7D4kGMdZzVbIgoW+mwMr5/Ayla396pREI86BOV379efGXU13KfKYrY/R8FP
 Cok7C9JmKrkjC0VgG5scvgYsluCpGeiBqUSyK9CJNsJIADTad0SEw1i76R6aDkLdbiW9
 9KMaxpTfow+nY3HifVuZKYdySRPpDtqy6nKA34zshQUt7EJVzHyelbl6GvBft/0jZjaG
 jeQnJoUD+TlLHAYXz5AeXMnTHEKqC1eM69W1DS/nXLEqChCBash0dxzK65/LEz2ibcwQ
 9RVg==
X-Gm-Message-State: AOJu0Yy2keoxxeyuLKRx3Miu52DUR04/huOwP8yrIArw9V4aakBmIfzJ
 +0jrQA340VADnxPas201wZ2Y+rrW8ihLCZROGjrBDUYoy2ccmxeFYMwTVdeTj1E2KZxbkvv7SPe
 e4SrjiEsTDrjYCdnnic4Bvw6CZohvr9o7339DV3rT02jY4/Zgl7SS6c46/ScMRkNKBGq6+mkbvH
 SYW6s/p5btzi0r5Ar6pc0=
X-Gm-Gg: ASbGncvm6xa8FVxd1UFChKqElsv0qnwBFqwGZ9sN0AjyTcUYvF4UPzaYCuDsDuFg7+B
 DSNA4jAC87M409NDNxHNb1wpcgbSFZ2z1OfmYFqkxi+f5Gqzp408uFQ3CwFzp/w49YGY1YAaTnD
 x1OLskbg==
X-Received: by 2002:a05:651c:325a:b0:32b:3879:ce7f with SMTP id
 38308e7fff4ca-32cdc324937mr56275271fa.0.1751356575777; 
 Tue, 01 Jul 2025 00:56:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmN5cwN1a1KiNAG0Q8OTCgk0iktaKB0zSYw1CTkhf8XjmeDBRSOLgJ7DsViTd0mC8eemKgwVldHRMPa4310z8=
X-Received: by 2002:a05:651c:325a:b0:32b:3879:ce7f with SMTP id
 38308e7fff4ca-32cdc324937mr56275161fa.0.1751356575378; Tue, 01 Jul 2025
 00:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <1747957021-2581-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1747957021-2581-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 1 Jul 2025 09:56:04 +0200
X-Gm-Features: Ac12FXxn54_-WRt1BFhIy6Fxlj3C6GUKyJlZUHp_a8czQgFDwYc2RhT2BlkgENg
Message-ID: <CAJFAV8xTnMtPXuG8Tu3YXLOUQPiYjtbKD4NGf1OBmLEiAKbkmg@mail.gmail.com>
Subject: Re: [PATCH] rcu: add deprecation notice about limit on defer queue
 element size
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Bruce Richardson <bruce.richards@intel.com>, 
 Honnappa Nagarahalli <Honnappa.Nagarahalli@arm.com>, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: isu6Muyb8v-rnRKDPF4eGFGK45hT6Ze9p8ZM5wMzyAM_1751356576
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

On Fri, May 23, 2025 at 1:37=E2=80=AFAM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> The functions rte_rcu_qsbr_dq_create and rte_rcu_qsbr_dq_reclaim establis=
h
> no limit on the size of each element in the defer queue. With DPDK 25.11 =
a
> hard limit will be set (``RTE_QSBR_ESIZE_MAX``). This will allow fixed
> C arrays to be used in the functions' implementations, avoiding VLAs and
> use of alloca().
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Acked-by: David Marchand <david.marchand@redhat.com>


--=20
David Marchand

