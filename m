Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DB3E87834
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 14:06:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52EFF402BE;
	Tue,  3 Feb 2026 15:06:50 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E54BA402A3
 for <dev@dpdk.org>; Tue,  3 Feb 2026 15:06:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770127608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JXe56owwZ/wwmjyOx1nvXPApxbBJiq7N5+P+hm67178=;
 b=MCcGADwjDH6o8z3DKEUpuwwcV3Xh3S+4DHfGytSL6L/FTnt5syAxS9Nd20WwGuxJJkOFPa
 fFQZGHKOYny39xD61lCaWfFDTLlBncZNf8p02AbOOZmd8RUdtl9QwrlBuF8JJ2D8lJQSeL
 W2LkbanYImVoP9EUfDimr3cyrknm+v0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-FJjXmDZ1NrKpOhDkMdIHyw-1; Tue, 03 Feb 2026 09:06:47 -0500
X-MC-Unique: FJjXmDZ1NrKpOhDkMdIHyw-1
X-Mimecast-MFC-AGG-ID: FJjXmDZ1NrKpOhDkMdIHyw_1770127606
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-382f5ff8a1eso37262331fa.0
 for <dev@dpdk.org>; Tue, 03 Feb 2026 06:06:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770127605; x=1770732405;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JXe56owwZ/wwmjyOx1nvXPApxbBJiq7N5+P+hm67178=;
 b=WGSsTm/GpzmnOr+NTkjzXaxZ51V780+CBV0FcI+HkehGBvUm/3Dfmim3f34gdyYEgB
 6gIKtT6J7p6gq3WiyBe3MyZ58DF9XqAKB13K0L8OanzmG8maRISgu34/MlQ++brsqhHB
 JHIBGhCQXblMLNooJKBgBx5wYYPJHIK0PSJxuOJACuJ5AsC9eOHwtoMjx9SMoViEpF5i
 44cZ9wD99izlyvXij6pSbVvI0kNaUp/LkRywIipQpFsxUkCVZ+/RBq7vyTzACRtTUXE+
 +vdUA8VwRh4emm2wSO96MRLbbi5+NV0KSaP9kY/zihujQgWCG5mNqtBiMO5L31xdAcIn
 akpA==
X-Gm-Message-State: AOJu0Yz+RFeqseYKEsCachzNsDOfaYBD6MsNEFagdkplj8+zgNzArGBe
 C8Dit2VheDeCu/UrYzlK6ca92ublHTHURivrpTRBIeoceWguORQzi9p/JESjneWX8s79kGqledS
 3rTfP7IjXRGXN/rLOfQnuDzIl6PdL96skMvc/NaqEpM4Xn650gX8reAny2+IVC4uHFosEUsn2W4
 aOPHfMbOxba3nLt9AsTbyHizWMBtk=
X-Gm-Gg: AZuq6aIjt6Jj9R83AbDBVTX/fAXMQ7ri+BxWKu8uIrcCr+VfYWuCo4EhKu/LQ5ilciz
 b2y1EAOS7VRwOdShKG7Uk6H2STsF2I3gP9j7ckTKVucCFcVpEwZNCuWe4sf33+mBpHqmW95CIC1
 B+QxqepCLl1o8aqMpORaS089C7OyaypVBglpVV2nPaR7e68fIEjY9/SudB08ocg/O+mE6D3jW5D
 XRz8uSWGj8gh2itjkiXPvOA+6/LXaWOCEZiF/zIozw3EUIKTlfh7GGgQQ==
X-Received: by 2002:a2e:b8d2:0:b0:386:7cfd:55fe with SMTP id
 38308e7fff4ca-3867cfd56a2mr19644351fa.33.1770127605508; 
 Tue, 03 Feb 2026 06:06:45 -0800 (PST)
X-Received: by 2002:a2e:b8d2:0:b0:386:7cfd:55fe with SMTP id
 38308e7fff4ca-3867cfd56a2mr19644181fa.33.1770127604989; Tue, 03 Feb 2026
 06:06:44 -0800 (PST)
MIME-Version: 1.0
References: <20251228201649.555898-1-stephen@networkplumber.org>
In-Reply-To: <20251228201649.555898-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 3 Feb 2026 15:06:32 +0100
X-Gm-Features: AZwV_QgNIYaAj97_yDhMMoMVp6Y-dCfp0D2omnCvS1mbpD7znWoadP254b_fzU0
Message-ID: <CAJFAV8yiq+nH7LBQ4ea8vdTHqgtSpgt9JYdACWMMWpd=iERLUA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Avoid using perror
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2OYN4JZifxf5NZQwNLx6dLdhxSWdz28g_yIrMNATFeM_1770127606
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

On Sun, 28 Dec 2025 at 21:17, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> The DPDK uses its own logging library exclusively and drivers
> and libraries should not be printing directly. One function that
> was missed was perror() and some code was using it.
>
> This series adds a checkpatch warning and fixes the
> places that were using it.
>
> Stephen Hemminger (4):
>   checkpatches: warn if perror is used
>   bus/dpaa: replace perror with log
>   telemetry: replace perror with log
>   common/dpaax: replace use of perror with log
>
>  devtools/checkpatches.sh              | 2 +-
>  drivers/bus/dpaa/base/qbman/process.c | 8 ++++----
>  drivers/common/dpaax/dpaa_of.c        | 2 +-
>  lib/telemetry/telemetry.c             | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)

Series applied, thanks.


-- 
David Marchand

