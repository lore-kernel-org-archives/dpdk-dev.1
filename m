Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAE6CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 12:20:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0B8F400EF;
	Tue, 30 Sep 2025 14:20:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 29681400D7
 for <dev@dpdk.org>; Tue, 30 Sep 2025 14:20:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759234838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x5FNc9IUhTDKl5IrvoRRJgsNkaJMeubTqqSxnAKB9BM=;
 b=Ewaz3oeGpi9QeYLwfCTrqJHM2JqimOF1sCC06FgXsFkux+ReNQdq8zT5qSCmrP4sU5QsQV
 FeeNwVWYRPHtMeRW5XppnOln8z3x0fQvDEPcPk90lqXz3TCAosNxd56b8nzo2bUUc8hRWe
 6lI2m9PonsrfJBakkqBEyNE/bKvdtf8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-I-y87Ql_MH2QRQlt8JZgow-1; Tue, 30 Sep 2025 08:20:37 -0400
X-MC-Unique: I-y87Ql_MH2QRQlt8JZgow-1
X-Mimecast-MFC-AGG-ID: I-y87Ql_MH2QRQlt8JZgow_1759234836
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-58af844137aso55493e87.3
 for <dev@dpdk.org>; Tue, 30 Sep 2025 05:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759234836; x=1759839636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x5FNc9IUhTDKl5IrvoRRJgsNkaJMeubTqqSxnAKB9BM=;
 b=hqdTvpTbJu/5jIzxzZhFGerorqgA3Y8XVVQvLEnK/a0qEz5hjL9gSWndgtpfKQQbyt
 CesQ/6J0teqjuUVSaBPjiHKbXMtIaXKvnBlfVpgl7WQbvsonIkOlbqqJZHeMQ2mZyk20
 88vx3L9HMtrzP5aO6jPP8pDFKG3YnodXZrL0FxBMAYPO7hkcOHXP6OyVda2cY6Qux+wY
 F+RaSUwUMMimP/rxGAd6Mo8Q73cNNcrx9NLNfOYtjpzdd2xYMXmlSu+1wx8fJ2iAz8Cj
 z0GR6J6dfK6ykCWeSUuD7vLwzmqcA2ZuZuNxImiIi49sWSjctSThnBgfuzf77aNV8E0n
 bOhA==
X-Gm-Message-State: AOJu0YwCEwdsRCyBzFJXaShG97aS0jjyLTwoH6oaDCIOzpayNVh9/DyH
 Am4hnmSXoVBCzhYvTwAlolvF7mWFn+IDohcX31zvZxyTsqwhJPxTlVa4zSxY0CmCewwCLSWWivB
 eTg+wkZwr8TZ7MFLw/wSS9uxWYUAiO+jdHYcAZZeY+662J03LOd9LiwAXJbAQntGvscg5A+YBqY
 7qKSEjNvw3FNeHhvVx7Ug=
X-Gm-Gg: ASbGncsQ+kydd661kCChmy1asZ2AePbTDgt0S06erwXQwIogHTKAiMmbXpZIhguouTx
 AUtjiwAl9k7aL23z+YhrWmbltZHAa0FxuakEfghn2TWBPtdu2x3w4HC+3lpt6nGPvZaNPvGzt/l
 KW/7aMS1zJ6vdu0MLHAXWYe5h83ahs
X-Received: by 2002:a05:6512:3e27:b0:57c:63a4:f8b5 with SMTP id
 2adb3069b0e04-582d0740b3dmr6357222e87.9.1759234835674; 
 Tue, 30 Sep 2025 05:20:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQxp53v50DoLNBENdYj74slonloa3wINU+stqFpk26+0bTlhxQ9qy0d1rIaftubCv5XCwzjzpou1rd6PuYAVk=
X-Received: by 2002:a05:6512:3e27:b0:57c:63a4:f8b5 with SMTP id
 2adb3069b0e04-582d0740b3dmr6357215e87.9.1759234835254; Tue, 30 Sep 2025
 05:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250723162013.2392-1-bruce.richardson@intel.com>
 <20250723162013.2392-3-bruce.richardson@intel.com>
In-Reply-To: <20250723162013.2392-3-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 30 Sep 2025 14:20:23 +0200
X-Gm-Features: AS18NWDo0-2ocvLO0r6jEdGvrME0PFlgAX9uQ7qKRScJP3rOx76NTftKC0MhWM4
Message-ID: <CAJFAV8w4jh+WZzLAVA+-g18EByGuMhFwU=x42vr_3X7FY8cVDg@mail.gmail.com>
Subject: Re: [PATCH v7 02/13] argparse: export function to print help text for
 object
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GL0QurjkCvFXGgQz-81_uVvuYnl-I_-234af-1UrFBc_1759234836
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

On Wed, 23 Jul 2025 at 18:21, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Make the function to print out the help text for an argparse object a
> public function, which takes as a new parameter the file stream on which
> to print. This can be used in future to allow application to extend
> their own help information.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  lib/argparse/rte_argparse.c | 43 +++++++++++++++++++------------------
>  lib/argparse/rte_argparse.h | 14 ++++++++++++
>  2 files changed, 36 insertions(+), 21 deletions(-)
>

[snip]

>         }
>  }
>
> -static void
> -show_args_help(const struct rte_argparse *obj)
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_argparse_print_help, 25.07)

Small rebase needed here, 25.11.


-- 
David Marchand

