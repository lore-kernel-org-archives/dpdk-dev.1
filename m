Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B1BC71155
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 10:50:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52BCF42EC7;
	Fri, 20 Jun 2025 12:50:38 +0200 (CEST)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by mails.dpdk.org (Postfix) with ESMTP id 1F55242EC5;
 Fri, 20 Jun 2025 12:50:37 +0200 (CEST)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-4a52d82adcaso23021481cf.0; 
 Fri, 20 Jun 2025 03:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750416636; x=1751021436; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xNvd4K7Nr9kTZ+qLzy6SGTRbNoRDRufVJoPOpdJNl0o=;
 b=OGlSER+8yOzNfIERg5qU9NP+9kunMbwnZFuT0k4CXLkiyTYsnRWoioO54lH6SKwK3U
 LX10Fjm7wo0/vmiHsNoloB1LFd8SMVn9IA28WNKv8pxpg5a5cg6PyXokEozWM58rCFu5
 AKmPPrwL8K7KgLN/hY5iQm4yI27cPI4Xwi+7Efv/SPEE6uG72/ipLMSX9xpYcdyzkVHH
 2d71bOKhsp2acwiZ07m1WyGsY/hJBJpNLaGWDI5T6EOZJN2EcWfKj/jr0aNqFgDRJaA1
 wrohpI/FjUjP9YeRp7R5kewpYMcOuLBtjzyYjCgZgbuNexX33B6PMbcNX0Tt0/wiymiF
 +qGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750416636; x=1751021436;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xNvd4K7Nr9kTZ+qLzy6SGTRbNoRDRufVJoPOpdJNl0o=;
 b=w40Ht5y2DfxIKbVRMsBwaOefZV64YTTi1xM+DBVd561t8+t+bnEcazgnUD6j8I3AjV
 JeZnCxvSuyfD4WVg8kc5SifGpuZqhY14PK5GEHzVUnDnQEMqx7YodYhsrW1wShs/LPsk
 M/QLEvIS/mI364VzgR5p4i5+ucn9iaA1D0gdggdZ6zUBpus8NoS69WHJgQwtOSkEBsL8
 W40nZvoPmSHw/25w4JP7rzUNx5xFPrjY2CcIXKJhSD9FCE/tD5tyz292Az05s2IImJJ5
 4yc7Ew7sy9TJ4GQbk3f2/BKiSs/q20VhK9Yk8KxdprbjOJn8XXbIRrtXHD0x1iKqtRlG
 bxQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm9G8OveCKNQ9cLVXsXJPSqy68JEPmhot5aS27m5Pjc9SivUQFuyp4MZ+QFfXCA8GRt5AmXdg=@dpdk.org
X-Gm-Message-State: AOJu0YxegB2jS4UhO769Aiv8B6nqDyQbWb9BtfMNlOLf+dIrCErxmJz0
 /caayAAId7qXmUmUluIqsYxlz/kmtyIdptGkyES9yMSgrtrXduftQaNdSe+cBxrZWpiBO034zBI
 pMYRmmb8rtI1p4X+WvrKa6329Iuks3PY=
X-Gm-Gg: ASbGncvmloWEUzl208SxCEgSYpaQ8fEprjeEXG00WXjvY/anNd0e4y2wXfxYiJ9Vz9k
 JD00j0+5EIztYgYsHhOoLG5Iq9+wqwZXpGvACJ56UKVS+bUbBaKvoqUu+4PAYaLkS9LX5NbdnDh
 cfzEE6FYtxFNWjyEGS2qscuhyxQAxzC+OkmKE4AK0oew==
X-Google-Smtp-Source: AGHT+IHA6Gh/0Wcmalw/s40rPukjigow4zCUEzZ7XXYtQm87dmJAx2Rjlr6gKUY8nKL8fuONqaaZDag7qaAfTW2drlE=
X-Received: by 2002:a05:622a:180b:b0:4a6:f416:48c8 with SMTP id
 d75a77b69052e-4a77a21e7a6mr36424781cf.23.1750416636196; Fri, 20 Jun 2025
 03:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250619223150.346724-1-pravin.pathak@intel.com>
In-Reply-To: <20250619223150.346724-1-pravin.pathak@intel.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Fri, 20 Jun 2025 16:20:10 +0530
X-Gm-Features: AX0GCFufEn_LFBc68CzJkjPrIk67nAgbsRpUR-Eme6sNrKq_WUwHZlV3ckuPkQM
Message-ID: <CALBAE1NY6LbE6FQ_279nFeo2v=LG88f5pjhA+hf3u1cKuUBG7Q@mail.gmail.com>
Subject: Re: [PATCH v1] event/dlb2: fixes names of DLB2 token pop enums
To: Pravin Pathak <pravin.pathak@intel.com>
Cc: dev@dpdk.org, jerinj@marvell.com, mike.ximing.chen@intel.com, 
 bruce.richardson@intel.com, thomas@monjalon.net, david.marchand@redhat.com, 
 nipun.gupta@amd.com, chenbox@nvidia.com, tirthendu.sarkar@intel.com, 
 stable@dpdk.org
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

On Fri, Jun 20, 2025 at 4:07=E2=80=AFAM Pravin Pathak <pravin.pathak@intel.=
com> wrote:
>
> added RTE_PMD_DLB2_ prefix to dlb2 token pop mode enmus
> to avoid name comflict. These enums are passed to public
> API rte_pmd_dlb2_set_token_pop_mode().
>
> Fixes: c667583d82f4 ("event/dlb2: add token pop API")
> Cc: stable@dpdk.org
>
> Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>

Updated the git commit as follows and applied to
dpdk-next-net-eventdev/for-main. Thanks


    event/dlb2: fix public symbol name space

    Added RTE_PMD_DLB2_ prefix to dlb2 token pop mode enums
    to avoid namespace conflict. These enums are passed to public
    API rte_pmd_dlb2_set_token_pop_mode().

    Fixes: c667583d82f4 ("event/dlb2: add token pop API")
    Cc: stable@dpdk.org

    Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
