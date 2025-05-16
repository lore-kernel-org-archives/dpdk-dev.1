Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89587C3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 07:33:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2A72400EF;
	Fri, 16 May 2025 09:33:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id AB6F040041
 for <dev@dpdk.org>; Fri, 16 May 2025 09:33:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747380802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ea9GVmnglbXOO+xBaiX6cWN9+mPiDDFT7r8bBKVbi0=;
 b=GhGPqndOGI9gcuCx27OXllAgsimk0d9kJzurFo0XAZ5CgEK/VjG40ZwofIUw5lddehCrfw
 fEU+14XCYEvZxksbJ1MBnQ5Wa5Dxqhv2tF/6FRfKT9KuJerTbOp5gt60PEx2RABQ1Q70z0
 mT6EGP/4U5QAoLhTofjKNC2Ir2uavPc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-TCnzMhOOPXqhZ1o0lKb8vQ-1; Fri, 16 May 2025 03:33:20 -0400
X-MC-Unique: TCnzMhOOPXqhZ1o0lKb8vQ-1
X-Mimecast-MFC-AGG-ID: TCnzMhOOPXqhZ1o0lKb8vQ_1747380799
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-54fc5370a8eso776140e87.1
 for <dev@dpdk.org>; Fri, 16 May 2025 00:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747380799; x=1747985599;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ea9GVmnglbXOO+xBaiX6cWN9+mPiDDFT7r8bBKVbi0=;
 b=DwhasLVMD+2QF1SCRrdkRsRbtnBvtZnab1A10pAKGOtcdNGnYtI2EQPoiy/iyVeIXo
 Bj/ZtER4IDK7QBWDQVh1UpGuVBIZsybh9rxmcH0qp+9Rg7C+wH9Kbfdyqm7mXvSGQeWU
 ycLIXmYGyvCDGu3fF0F3V1sTuaXiO9LdaKZ7LdT4B54VWFMzBsN9uKg8ZGRRkW/8xGFw
 gIT1+UNUqQsxxACzpZaylwCXlXy3aXkmN3UrSPKeWpYxmYHlLGGH6ltF9WvIKFvQSChD
 8pBPsLw2CfLy+0W2srvvjYQQP2ha2ZmCArU2UfGm5sXsbWLAy+jlKcOibLpUmbD9YNEA
 d3Mw==
X-Gm-Message-State: AOJu0YyIuVa6Igcg7sTrYBJYpgurhWvB7YhAGvOMhT1y1PGkdLx5xqti
 QkB3Y0b5eRIflbL7bRRaTAq9qtPKrRjUbFIeP4DManIczBpgTNxAwytnvYplXu+Up3GhfDpWnBO
 aHGIE2fL2JL7BWThZAX4atNKa6UWT+e1FIA0RRyg5KKQkvR2Zp5Mu7onBIFM5cAMaNvE8UM5OXC
 YmrPlrnyFlpQ8fd3fLcio=
X-Gm-Gg: ASbGncuNDvLYwhAVvVP+ZGvoAcPLLubKYiZauINvubrG+rXaP7/DCS5FjBJlRTlVOeH
 7SUFekXSqFLKmEslujZD1jZl9EpnfztT6ZmorOL337rUiYhRLknojkESWDiQnq2R7A1vI0g4=
X-Received: by 2002:a05:6512:670e:b0:54d:6dcb:ac77 with SMTP id
 2adb3069b0e04-550e72322f8mr723965e87.41.1747380799216; 
 Fri, 16 May 2025 00:33:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiPAa5nIsz+ERuW3u2S2PJyT8uuzHGGRrYGAc/Qlt3vH6Pqmt8ZTfbS1zTx44aiHCHzQEiUQeAvD9JrHrXehM=
X-Received: by 2002:a05:6512:670e:b0:54d:6dcb:ac77 with SMTP id
 2adb3069b0e04-550e72322f8mr723956e87.41.1747380798816; Fri, 16 May 2025
 00:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20241009152417.4028297-1-bruce.richardson@intel.com>
 <20250515134647.932537-1-bruce.richardson@intel.com>
In-Reply-To: <20250515134647.932537-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 16 May 2025 09:33:06 +0200
X-Gm-Features: AX0GCFs4rLN93K5NdUK8mC2e4eNbUxDTxpyGxJGYsOrgJcIHVfEQPL4uUehG0cM
Message-ID: <CAJFAV8ycKdFJgLBXr2RXcmUkHxftKywbrpOCvLtutRh6CMPujA@mail.gmail.com>
Subject: Re: [PATCH v3] build: automatically report minimum meson version
To: Min Zhou <zhoumin@loongson.cn>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, 
 Stephen Hemminger <stephen@networkplumber.org>,
 Patrick Robb <probb@iol.unh.edu>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -_UXUAEZOeRxPX0OXDhSdSkuptjKNNank-8KEor8y0w_1747380799
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

Hello Min Zhou,

On Thu, May 15, 2025 at 3:47=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Add a script to buildtools to report the minimum meson version given in
> our meson.build file. Then use this script in two ways:
>
> 1. in the .ci/linux-setup.sh script, use the auto-determined minimum
>    version to set up the CI, rather than hard-coding it.
> 2. in meson.build call the script to report the version. This serves as
>    a sanity check to ensure that any changes to meson.build file do not
>    break the script.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> Reviewed-by: Patrick Robb <probb@iol.unh.edu>
>
> ---
> v3: update minimum meson to 0.57.2 (from 0.57.0) to fix CI errors
> v2: rebase to latest main

The LoongArch CI reported an error on this patch, but I can't find out
the reason:
https://mails.dpdk.org/archives/test-report/2025-May/877981.html

This is probably related to the meson version in the build env, since
this patch increases the minimum version to 0.57.2.

Can you have a look please?


--=20
David Marchand

