Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD45F33A61
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 13:50:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20D4640A70;
	Thu,  5 Mar 2026 14:50:50 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6825C40A70
 for <dev@dpdk.org>; Thu,  5 Mar 2026 14:50:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772718648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sYuZ0S9/AImaSsulFRRjvpAwShh1ivd7h5CUaN8aJYE=;
 b=UpyRftWZT8U3pF4bYfEm3gxW8tDEYHX1Dy+2v3o5GZtuqvfZTYM8lSyC4BFjGJyH9Tpsf7
 oVX1dolNQxGC6Ze9+r67m0IfDTKzLLYFLEXKTqPeLNoLrusooQ9utn3ocOCDjae7wJRRX5
 XhzKSAEXb/YmH1v8Vje94jt1DE/ukvM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-vsBHVSQlPueNMGLm2x9tgw-1; Thu, 05 Mar 2026 08:50:46 -0500
X-MC-Unique: vsBHVSQlPueNMGLm2x9tgw-1
X-Mimecast-MFC-AGG-ID: vsBHVSQlPueNMGLm2x9tgw_1772718645
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5a1154f41fdso490497e87.1
 for <dev@dpdk.org>; Thu, 05 Mar 2026 05:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772718645; x=1773323445;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sYuZ0S9/AImaSsulFRRjvpAwShh1ivd7h5CUaN8aJYE=;
 b=d+tBR9di6/T95qiTXCWlVzTDsjMtF25zm6Xztqz2zOBeRfnndJ37lG3d3/sR9J8Z//
 YhZKHqHLg3kIBwXbN3AAB+JzSPt81Zlde0WBAlVbHnzHuJ8NaUDxPlm82kJwgzJOGvoB
 IfKK5wGFB/6kMmMdJAjjLrZvpw/zOc3Lcosw2/8InbiXKOCF+97otVObjaZUzhHBx3DK
 rL2qH4POXUCYsX6Cwz5v7KPGt1oD3nyO1GjwywLJIO8tvlQTCEYVCLwNHiopwQnjLuPg
 Z1KaMhuu8fUXn6AVMqoq+E4ITXTty/li5aV6kBrxHkzR69iEaiwkq5exhP710Lw5Q4uk
 UJEw==
X-Gm-Message-State: AOJu0YxFcoojcJo4bneEsYSN4X3DKmTWhhGtuZBpkNbQzo0OzZ+SLyCZ
 ndS1d/0tKbau1Mu8Tdw4teCkPTw8jB6gVZJ8wULrzcES9grA/sg3I2VIQXWOLFgDkZhMZZnOVPh
 jsnoMJZgtKKNTottEq0azlOhw86+ElnDdUogg1+xMD3wRheqwKUeV92B6SQH2Pw8hTBQiF2k4xw
 lnYFXnn1dRt23rIOao/tE=
X-Gm-Gg: ATEYQzyacb417NY8muLfHiSpV+ha6yyeHxjmAH5U2UC6MG/zYTq2zBJSbWioP6TIrbP
 1LZj2YCiC/5XzxtbOi7yJRHjfEXfSwSur9tKkQh2sr/3aQTP6K16eAvuJcaFtRBNzEbcrhTNqxA
 xG8Pq+zY83sDsfZb4Qq2CCftCiPjZAUK5n0y8RcpWKyaVLvr/OcQybcE3mnnMC88uAmf34qzjpX
 pTKuUzpbgDcK1VkSYznplaCbC3w4n5qhBUXfgCSRNZSNrgS11N5GpatiJq9tIxEnaCaVA==
X-Received: by 2002:a05:6512:104a:b0:5a1:19f0:ffc0 with SMTP id
 2adb3069b0e04-5a12c35dfc0mr1061445e87.48.1772718645101; 
 Thu, 05 Mar 2026 05:50:45 -0800 (PST)
X-Received: by 2002:a05:6512:104a:b0:5a1:19f0:ffc0 with SMTP id
 2adb3069b0e04-5a12c35dfc0mr1061436e87.48.1772718644367; Thu, 05 Mar 2026
 05:50:44 -0800 (PST)
MIME-Version: 1.0
References: <20260305091039.1057276-1-alialnu@nvidia.com>
 <20260305105016.1093351-1-alialnu@nvidia.com>
In-Reply-To: <20260305105016.1093351-1-alialnu@nvidia.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 5 Mar 2026 14:50:32 +0100
X-Gm-Features: AaiRm50sm3e55KhdMba5Apr0-UZN-uvpOrtSC-vvAZJ11Fez5Sjf_vmDDffxUKw
Message-ID: <CAJFAV8w6i8gSq=A5SOSRf3BjZnUXP9SwuU27hZau59aEswh-qw@mail.gmail.com>
Subject: Re: [PATCH v2] devtools: fix symbol change check for non-lib patches
To: Ali Alnubani <alialnu@nvidia.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3rpjFP_wSIrPiJ8AYKRPhrnPzXYnY2oLIrcWZokHVNo_1772718645
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

Hello Ali,

Just repeating what we discussed offlist for visibility.


On Thu, 5 Mar 2026 at 11:52, Ali Alnubani <alialnu@nvidia.com> wrote:
>
> Handle patches that do not touch lib/drivers (e.g. doc-only) without
> crashing. Treat every '--- a/' line as the start of a new file: if the
> path is under lib/ or drivers/, set lib and process symbol lines;
> otherwise set lib to None and ignore lines until the next file. This
> avoids both NameError exceptions and misattributing export-like lines
> from doc (or other) files to the previous lib when file order varies.
>
> Fixes: 1a0c104a7fa9 ("build: generate symbol maps")
> Cc: david.marchand@redhat.com
>
> Suggested-by: David Marchand <david.marchand@redhat.com>

No need for a suggested-by, you caught the issue and I am just
reviewing the fix :-).


> Signed-off-by: Ali Alnubani <alialnu@nvidia.com>
> ---
>
> v2:
> Treat every '--- a/' as a new file: set lib only for paths under lib/
> or drivers/, otherwise set lib to None and skip lines until the next
> file, so behavior no longer depends on patch file order.
>
>  devtools/check-symbol-change.py | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/devtools/check-symbol-change.py b/devtools/check-symbol-change.py
> index 1efeb82fcd..a476ceae5e 100755
> --- a/devtools/check-symbol-change.py
> +++ b/devtools/check-symbol-change.py
> @@ -29,17 +29,21 @@
>  symbols = {}
>
>  for file in args.patch:
> +    lib = None
>      for ln in file.readlines():
> -        if file_header_regexp.match(ln):
> -            if file_header_regexp.match(ln).group(2) == "lib":
> -                lib = "/".join(file_header_regexp.match(ln).group(2, 3))
> -            elif file_header_regexp.match(ln).group(3) == "intel":
> -                lib = "/".join(file_header_regexp.match(ln).group(2, 3, 4))
> +        if ln.startswith("--- a/"):

This line above must be updated to also catch +++ b/ or the subsequent
regexp won't be called in the "addition" case.


> +            if file_header_regexp.match(ln):
> +                m = file_header_regexp.match(ln)
> +                if m.group(2) == "lib":
> +                    lib = "/".join(m.group(2, 3))
> +                elif m.group(3) == "intel":
> +                    lib = "/".join(m.group(2, 3, 4))
> +                else:
> +                    lib = "/".join(m.group(2, 3))
> +                if lib not in symbols:
> +                    symbols[lib] = {}
>              else:
> -                lib = "/".join(file_header_regexp.match(ln).group(2, 3))
> -
> -            if lib not in symbols:
> -                symbols[lib] = {}
> +                lib = None
>              continue
>
>          if export_exp_sym_regexp.match(ln):
> @@ -54,6 +58,8 @@
>          else:
>              continue
>
> +        if lib is None:
> +            continue

We can move this check before evaluating all export_* regexps.


>          if symbol not in symbols[lib]:
>              symbols[lib][symbol] = {}
>          added = ln[0] == "+"
> --
> 2.53.0
>


-- 
David Marchand

