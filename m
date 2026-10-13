Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C522CC6B03
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 10:12:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42386402F0;
	Tue, 13 Oct 2026 12:12:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 430FE402EA
 for <dev@dpdk.org>; Tue, 13 Oct 2026 12:12:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791886346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SvPtVyPhOCsFaCciMRuwi/NaNzYskMwUBhhb8WsPZUs=;
 b=K5VTC12QTiqEQ7Kpb8DiKVMmDPCzlEO3Al8VVEYq0lfcQdvyR9PQXE9FUOYJl4KvgNjkMf
 AZE+RcUyaY5EHqhaSEwZ3/to43neu/U2KH+yBSxZGEVy1knrlFD6+PO1KmI0fXkLYFkUan
 nV3A03UJbqEl+szWmIuVCdJIu+jvDfE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-F3onXxAhPPaj4ZDozBG1eQ-1; Tue, 13 Oct 2026 10:12:25 +0000
X-MC-Unique: F3onXxAhPPaj4ZDozBG1eQ-1
X-Mimecast-MFC-AGG-ID: F3onXxAhPPaj4ZDozBG1eQ_1791886344
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3a77d27eb6cso14101631fa.3
 for <dev@dpdk.org>; Tue, 13 Oct 2026 03:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791886344; x=1792491144;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SvPtVyPhOCsFaCciMRuwi/NaNzYskMwUBhhb8WsPZUs=;
 b=E9Vqu/hBbHMC7yPh7QzkisDsUajrMxxZ5hSYN29yd4kl1zXlZej49xkqFeoBI7dPtA
 XTJMMHDwFrVGH0nXCg4Pu3nTJYdu823sJ299ecZYOuJ6145jFKM1g95XpUg+z9JjulBr
 YKS0VKPsaBk9YRDotoVmiITZEl2jZcNgSjZ/ywqilorG6myl7qxPPNt9G2EGj1Zmn6st
 Q/ENd4CAZaFA2PzLHDr0ugVCcEAGOdTKx5JzHu+eiXyTxUXOBqtYOr81WAMzFfFylR60
 IJUaiEnjEAXwGOR5nfJetFZXs7x/t9EufWBvI8h0iCF89axGrs9qDOrOBtw0i+sycOJa
 tHrQ==
X-Gm-Message-State: AFq9FYJZljYQJXfVObq3HmCeJnnwGALGru/zY39BYnmmX8229N8bvMdq
 Rd0OAHo3nG8QxnkiNOgAuQO2lJ22dq0Pm5EBcBw/l8iXiJkN7XdaP5XLTyUD+gDsEojsZ1wbH+/
 unVlCpF9Jh8fXD21+ECYRQFzawDINS6svtevdzcazss52foz374ktO9t3Is03SjR2viNGAaJGJy
 bFaMihroDMt+fjN4HYuQk=
X-Gm-Gg: AYBFou3/eUFapI2400OnwVPD1vU9K+YvD51j70yKcTSjIlH6Fqh83ziuJwofxCJy7N0
 R3/8uYfNPrOtWA7+9nH4EH1vxK7TpeytW/2WxdLqcz3IgXm7bOZKraipJRaV9jRZCyj0sES5hDt
 uwRLATzoGAj4989mhiZANO0HFvpYiGJPJPJcM/p9UNd8G/tvDkagzxYf6hCgq0Aob4x2I3RwiBg
 eKXzEqeCHqO7hQGJ1zJ4DCl4YhCl45J+wduKgYb/dDtz+js
X-Received: by 2002:a2e:be0d:0:b0:3a7:60f3:40ab with SMTP id
 38308e7fff4ca-3a9c5398e36mr25088531fa.8.1791886343856; 
 Tue, 13 Oct 2026 03:12:23 -0700 (PDT)
X-Received: by 2002:a2e:be0d:0:b0:3a7:60f3:40ab with SMTP id
 38308e7fff4ca-3a9c5398e36mr25088371fa.8.1791886343081; Tue, 13 Oct 2026
 03:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260811104933.3843522-1-g.singh@nxp.com>
 <20260812092929.563973-1-g.singh@nxp.com>
 <20260812092929.563973-2-g.singh@nxp.com>
 <CAJFAV8zOOvdFpwmCvJbV8Qj3TDmM4zR-CRcVupC1bovAyv0AwA@mail.gmail.com>
 <CAJFAV8z9c94-C39rrDHLeHTEd9pOG1n_HSkDEbpkOHDkNdcrxQ@mail.gmail.com>
In-Reply-To: <CAJFAV8z9c94-C39rrDHLeHTEd9pOG1n_HSkDEbpkOHDkNdcrxQ@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 13 Oct 2026 12:12:11 +0200
X-Gm-Features: AclHuK8N55lBq7M_Bo1oTxdQO4kbGNDVPaHbEnD2qR7P3J_DwjcoSlSnHUzE28c
Message-ID: <CAJFAV8xXp-NcXTUY__6LwWS9g+M-ym-7423QCx6tpBk3Q=GXyA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] bus/platform: match device by devicetree
 compatible string
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com, 
 Tomasz Duszynski <tduszynski@marvell.com>,
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TJePF4hGCJUh3Yl-DhbqaMZxkkJmXJ1C-n8AZ8tQyNE_1791886344
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 9 Oct 2026 at 09:31, David Marchand <david.marchand@redhat.com> wrote:
> > > -/** Helper for setting platform driver alias. */
> > > +/**
> > > + * Helper for setting platform driver alias.
> > > + *
> > > + * Note: this macro uses RTE_STR() to stringify the alias argument, so it
> > > + * cannot express strings that contain a comma. For such aliases,
> > > + * set .driver.alias directly in the rte_platform_driver initializer instead.
> > > + */
> > >  #define RTE_PMD_REGISTER_ALIAS(nm, alias) \
> > >  static const char *pdrvinit_ ## nm ## _alias = RTE_STR(alias)
>
> I just sent a patch on this topic.
> Have a look please.
>
> https://patchwork.dpdk.org/project/dpdk/patch/20261009072535.3039944-1-david.marchand@redhat.com/

Merged.
Please rebase.


-- 
David Marchand

