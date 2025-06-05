Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8F1C5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 18:54:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E8A740150;
	Thu,  5 Jun 2025 20:54:29 +0200 (CEST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
 by mails.dpdk.org (Postfix) with ESMTP id 9056C400EF
 for <dev@dpdk.org>; Thu,  5 Jun 2025 20:54:28 +0200 (CEST)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-70e64b430daso13629087b3.3
 for <dev@dpdk.org>; Thu, 05 Jun 2025 11:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1749149667; x=1749754467; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tYiyU36oycFw3pCqErbFzwEB4ZKAjXeJswFlW1BsthA=;
 b=el++kgbHX3xkqkCy14IS2VGfdG+zkLwT1NjMVfSrqLiREtyDudUgQRHIAGz2b0DRBO
 C9H8k8YnKoQQvjlpwySOl2MiB84ezOrPTEWYKOaORP6eV9vhGoegq+RZl0F9VsHZvOdq
 OFuoOeNX5Vi0WMmlz/99OjpgiQiMrZHOrx0yY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749149667; x=1749754467;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tYiyU36oycFw3pCqErbFzwEB4ZKAjXeJswFlW1BsthA=;
 b=mJAhU1uo90DyqTN6OpNfn9TOhlyd8Q+qO5vVvJtbPJisQHvWwuiElXVRRBY7NLiGZ9
 PFIj5y3EynSpjW5iaCHrlWT6+ByhzrCYcySE3k4pKtnsZO+1MRvSovdua9EJv569LHJ3
 Yuge2v3FnUmTFPXE6g+pzoyBz5yBbu4CNs0kksC874+n2M2TQDF+0750WFpFczAoyGEg
 V0sWRq2JseMP8moTiJbnc+kur5IFaAnFVxhfIaB4X9MyMNw1qAeReXJhTftgiwQTCAF3
 +et7h3QSARdRPEj0644axO946W86mu6f92hompsgpg35nvcx8HYzdbfbhCzNtpjaEYDE
 U5pQ==
X-Gm-Message-State: AOJu0YymcKnGjmJs+cKEq0zWx2vRvrF/FeAUyeu7hk8AEol6WrDoQ06H
 x26JW/G62epxmt3qFh4IR0Yjtv8Gd6N+gROXXMRQHpLh8xvnUgc2f3FZNIOsndoOSVyZY/RdWyb
 k4kAWHQiTT5ufGbP03SkH84Vw2pUiUC9nP0DtAoBG6OFvU+wmOk5L
X-Gm-Gg: ASbGncsFbf/5tskOzLjHktNLJ+ISAqdw/n7sJRIpdKJBQVP3BWS5G354EKX9PEykVu5
 J2OQMcO+MXMKtjz+bpWGI1P3wAKUX6T48Ecf6Ak/+ADEO3bOTctoOWiNcWT/N6p6jSKR1o2n94x
 G0s76jy6w/U1qLg4l0mpfQm+YZT1ZTMMkR2Kd0lJPyjQ2qePgzvK+wFEJ8/5E=
X-Google-Smtp-Source: AGHT+IE+9k7988pk0eEx7syHjIxaLh240uSbZqL4F5Rr98p+HxabESx22elVAgrExgd79ConxRj5n999r8oXJdXCvsE=
X-Received: by 2002:a05:690c:6405:b0:70e:18c0:daba with SMTP id
 00721157ae682-710f7702170mr8219127b3.25.1749149667643; Thu, 05 Jun 2025
 11:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250516202600.632070-2-npratte@iol.unh.edu>
In-Reply-To: <20250516202600.632070-2-npratte@iol.unh.edu>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 5 Jun 2025 14:54:15 -0400
X-Gm-Features: AX0GCFs9Mnx5N6QDK8oX9v9slDQwxlTKONaVYRG5iX-Cg2P4fadFW_pQCPcaNIw
Message-ID: <CABD7UXP_j7R9wPjPw62aPw2Ev40ujNiPBKjuOvUCLNDGzwRf8w@mail.gmail.com>
Subject: Re: [PATCH] doc: elaborate on per test suite configuration dts docs
To: dev@dpdk.org
Cc: luca.vizzarro@arm.com, thomas@monjalon.net, probb@iol.unh.edu, 
 paul.szczepanek@arm.com, Honnappa.Nagarahalli@arm.com, thomas.wilks@arm.com, 
 yoan.picchi@foss.arm.com, stephen@networkplumber.org
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

On Fri, May 16, 2025 at 4:26=E2=80=AFPM Nicholas Pratte <npratte@iol.unh.ed=
u> wrote:
>
> Introduce some additional documentation explaing the per test suite
> configuration component of DTS as the current dts documentation does
> not provide a quick access reference guide or explanation.
>
> Signed-off-by: Nicholas Pratte <npratte@iol.unh.edu>

explaining is misspelled in the commit message

<snip>
> +   Test suites may also be configured individually using a provided conf=
iguration file,
> +   provided at the command line, for custom configuration. The configura=
tion file is a simple
> +   mapping of test suite names to their corresponding configurations.

This part is a little odd, the words configured/configuration and
provided are used a lot. Maybe something like this would be better:
"Test suites may also be configured individually using a file provided
at the command line. This file is a simple mapping of test suite names
to their corresponding configurations."

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
