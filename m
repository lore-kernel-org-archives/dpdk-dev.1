Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EC7C7EE2A
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 21:53:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7417406A2;
	Wed, 25 Jun 2025 23:53:19 +0200 (CEST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id 835BA4066E
 for <dev@dpdk.org>; Wed, 25 Jun 2025 23:53:18 +0200 (CEST)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-6f8a87f0c0fso5190976d6.0
 for <dev@dpdk.org>; Wed, 25 Jun 2025 14:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1750888398; x=1751493198; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fzE8umbjOmapp5abNhmUzl1cvjniIfYiqCHh/Nx6UxA=;
 b=nTk/jS0DggAD0dZt0ZfbYQ31l+HTkT3Yxpejisuav1/xheABKi9ZXPkous0YGu/5nz
 tIwOMqfpN2xG01TFA26nq0edfFqYjmEtP6Ubkooi3trlhtGUyC0SLs4boktHpZsSxE2C
 WyVjLaX3+CYTQVeIb+LT+fNkstACkeHYG27L9fNvKznIn/neVAezAqkuSTuaoxzCEpwB
 jhF/mWaYRiMGHgGzpaWPM7ej0Ivq6vnwkaRFNVjUO/gLm7dw/Na5c1LBqC6IO6QsPgEu
 u7E1oLO45n/SQnSQkkwvGeyYvG3N7KHwXqP6n1Ca5GlTdSDWXFRhYWKFvIohNb+poSp4
 mnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750888398; x=1751493198;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fzE8umbjOmapp5abNhmUzl1cvjniIfYiqCHh/Nx6UxA=;
 b=I8xgye1fQSC7mk5diwZe7oRKlpbLGAVcgu4uO1OwrxNXDqmgva8FLJzrCcPOmZ1Zax
 JebBK9iraI8O02Op+5TZIRhIEWAsmPoQWlUFNgRoyxlpdNg/wQtCqMAies8AxKzpNWjm
 XwJW1NZNLoEYitBPWZM+AMH+SaPAvSQGvYL4BMhRiTZzonXzBfBwE69OlpEHUNbLx1Vo
 uLP4PVqzc0ehx8odz7zPEwwo6cUS/0KfJsLimds6wpDJVz+8Mxc1geepcEUjCA9tYPka
 p3JnNCwE530MYbxudJ/twiZ6W1Enqdud43zGI8xgmJAcv6xdV/s4ni/PvXCDcK9xR/nl
 cReQ==
X-Gm-Message-State: AOJu0Yym4A08vUToHSU4sngrDW+kVUbc2/k+hjS6rf1vvnrovytVpYYP
 6rrFeEuGvz0kUghIOBxUB9bbNGFbytDFtadZhl/6ITKjbinCL4vyomRcH0FishDaRo6vqmW4vSm
 uPDToOPLsL48kwUQl2/FPG+AMhJMGa7VvOlxmo/dy
X-Gm-Gg: ASbGncv8DfqAST/j6HUVgCCILACS+xC4mrgYT6vcXMfLjK9LTTzRiGyKI+ciiNfW3kV
 v2uwU31vCazLUk4u/2EBWeCAg5RY7ciPkabPLdWLaoD+Ry8nFxSWItg0adtJCSzfzpyDtOWL+Qs
 p7VublE2wDzI18kyVn0iQGpKtvg7ZzQbqCXzCiUI+DZwMHhbhgdS8qtGZEBz3z28u/DLfUf/Viv
 A==
X-Google-Smtp-Source: AGHT+IETS6PdVD8Dn705ggYLvg9AbODs/61HAgoDOqU2Jst/RH/TbSB+7Wl2Ey2A8+NVjQvOqneytOlizpsGgeoJCKA=
X-Received: by 2002:a05:6214:d0f:b0:6fd:4b21:f2bf with SMTP id
 6a1803df08f44-6fd5ee846a8mr72468476d6.0.1750888397504; Wed, 25 Jun 2025
 14:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250625182751.1936925-1-jtranoleary@google.com>
In-Reply-To: <20250625182751.1936925-1-jtranoleary@google.com>
From: Joshua Washington <joshwash@google.com>
Date: Wed, 25 Jun 2025 14:53:06 -0700
X-Gm-Features: Ac12FXxwU4NflMm9kjr2MUMrJBvNPtbb3po09by4e1YAaZXWUGnnhe-hHmnVTWQ
Message-ID: <CALuQH+VNfMG7cCk7HVpu0+yudNbGaO++CsmEhjjrhPOQ71-iDQ@mail.gmail.com>
Subject: Re: [PATCH] net/gve: support gve driver on FreeBSD
To: "Jasper Tran O'Leary" <jtranoleary@google.com>
Cc: dev@dpdk.org
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

Acked-by: Joshua Washington <joshwash@google.com>
