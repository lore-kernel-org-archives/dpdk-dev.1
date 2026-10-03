Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052CCCA5FDD
	for <dpdk-dev@archiver.kernel.org>; Sat,  3 Oct 2026 09:45:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0DAC4026A;
	Sat,  3 Oct 2026 11:45:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 975B94003C
 for <dev@dpdk.org>; Sat,  3 Oct 2026 11:45:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791020730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2U0QbKnMf9M7YROaXmTl/pPrKlyV3BejiGm4s02Yzpk=;
 b=gij79An2oc0RHcARzSd2jrViMl8KNSgBuIKLREzkLaOd0VQMilwhyJn86u180kl7iTDDcH
 qIg9/7/7lf/3QRThscCd8SMQba8iNM5FzRZb5PDNVnrGxsgk92h4M6sltNy5rKCD3c388O
 0mr0/zWFYwbxzJRVEF7Cz1ZP2oMJsII=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-dZ2SuYiLOFatj5jBbqicig-1; Sat, 03 Oct 2026 05:45:26 -0400
X-MC-Unique: dZ2SuYiLOFatj5jBbqicig-1
X-Mimecast-MFC-AGG-ID: dZ2SuYiLOFatj5jBbqicig_1791020725
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3a1fa5bb969so2795211fa.0
 for <dev@dpdk.org>; Sat, 03 Oct 2026 02:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791020725; x=1791625525;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2U0QbKnMf9M7YROaXmTl/pPrKlyV3BejiGm4s02Yzpk=;
 b=vsShyAKx/flx0jqClgY7cQNqfHNjPfan4w9xyXxR3y0UawA5PlQiCmhwBNP4CMg0AD
 UZX/0RpfFhJbwdhK2LUApmKs6gnzjVQHQsn4GWlXWpz1Fh/n7nAJp3PBq0DR8tY6ifZ/
 EaUh2043249RapJaXBO0z9xe1fnGiuBTRpsERoI45tXPsD6Okf23v+xPj2dhRGDLISX/
 g6HCtjrnz3Z+UY45nJ4t3lgJKC+N83nbMOnGDf6xdBU4ohx+AxjHRvalVp2ihJB5i0XH
 OljEzeHQxr66vb24LTMN5W8qnI3/8ujDXWZMSDxTW9TXmfV6/Qrs4SvqA0v6lCk+POOR
 lVng==
X-Gm-Message-State: AFq9FYIsOZLmdIMDCRSeRd5pRtdOwLFiGObKRlZ+RyYJCUgm3J8fROJ2
 /C7YoCIOO9ctAZPGLl4KjznUz8FWp2vTYOmZ4WdYZcM6AIVI6/+gy72fIvwnzNREbNEUYJD26H1
 Zss1Oe5MNo6eVKkxl7nAe/wHBWjBMI3Fm2HBElEEV5W/UHCcrFszmR8+zUWkRHF7e+VyX5Zc3y4
 SGD1BOJdwS+mkANOTNAI4=
X-Gm-Gg: AYBFou1wNtdXSJaD+O2fTZUeA8FE5THgTB9iiaW5ZlQvvyBE7XxxEgn0mUN2cdYyZzY
 oqQgzOcz0tg9vBtEuuqBUAc1Zlh2D17AcUHDjSk0MuW4iyxq2vcGMSj0jrzi8lz4RFcPJgGYEqz
 vGq+TKLPmuNGYBqGIQ2N/h/38WloNc3IEiF8UfH+kdLru692fHBVQqjt8f43r229DpLrgKgi7HV
 E41PvRzRsQhQtUiSAw3rVhL17KB/gf7A3SU5UgYXdsoVkBi
X-Received: by 2002:a05:6512:1193:b0:5b6:1a7c:aa1f with SMTP id
 2adb3069b0e04-5bcb546d394mr706165e87.55.1791020725042; 
 Sat, 03 Oct 2026 02:45:25 -0700 (PDT)
X-Received: by 2002:a05:6512:1193:b0:5b6:1a7c:aa1f with SMTP id
 2adb3069b0e04-5bcb546d394mr706156e87.55.1791020724631; Sat, 03 Oct 2026
 02:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260930095800.551314-1-maxime.coquelin@redhat.com>
 <20261001090558.1131763-1-david.marchand@redhat.com>
In-Reply-To: <20261001090558.1131763-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Sat, 3 Oct 2026 11:45:13 +0200
X-Gm-Features: AclHuK94x2D_q2Gn72AGdCdULYFog_L53hthQA9F5uAB2d5noDBXssLz2pfToTA
Message-ID: <CAJFAV8xGcpJAvfk1PiDJJDC_ROSCXEs8423faA1N65LRrnqPxg@mail.gmail.com>
Subject: Re: [PATCH v2] uapi: update headers to v6.19
To: maxime.coquelin@redhat.com
Cc: dev@dpdk.org, eperezma@redhat.com, thomas@monjalon.net, 
 stephen@networkplumber.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BSjC0f1fzEhBNQj6-x3RLvVhXL2IzPzwj_uikFoG1pQ_1791020725
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

On Thu, 1 Oct 2026 at 11:06, David Marchand <david.marchand@redhat.com> wrote:
>
> From: Maxime Coquelin <maxime.coquelin@redhat.com>
>
> This patch updates imported UAPI headers to v6.19, in order
> to exercise the new compatibility define for __counted_by.
>
> Since __counted_by is introduced by linux/stddef.h we need to import it,
> and the headers, included by already imported headers, leading to its
> inclusion.
>
> One complication is that linux/types.h contains a guard that must be
> sanitized using the same method as the Linux kernel.
> For this, add a dependency on the unifdef tool.
>
> We also need to fix net/nbl which does not include the VFIO uapi header
> first.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>

Moved error logging to stderr.

Applied, thanks.


-- 
David Marchand

