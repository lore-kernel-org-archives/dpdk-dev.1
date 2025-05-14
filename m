Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8A7C3ABD9
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 08:43:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15AC340651;
	Wed, 14 May 2025 10:43:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7162240041
 for <dev@dpdk.org>; Wed, 14 May 2025 10:43:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747212223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kPaMgTAp0EXZnY95Xl/yroXsLXRSxLjn0Ks/lG9kuUs=;
 b=e+PVruPNno0bbeJ66ZVjvvnoyyguRnK7uggpwhotW+VX/a6gcK0Cr5d7XdkFuuuaHvjoyV
 X8ey9aC9H4ps6Um46BZJC7m4oiekIzxGEZ2BIz33VQPWRXSgISgRXZvlOicGnzH7H+mkLU
 7KTErKLAllJQ2F+7KD4Fn3RlG0aBIXs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-aVufxOlqOUmya_kxD32MgA-1; Wed, 14 May 2025 04:43:39 -0400
X-MC-Unique: aVufxOlqOUmya_kxD32MgA-1
X-Mimecast-MFC-AGG-ID: aVufxOlqOUmya_kxD32MgA_1747212218
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-54fc8c477fbso2771942e87.0
 for <dev@dpdk.org>; Wed, 14 May 2025 01:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747212218; x=1747817018;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kPaMgTAp0EXZnY95Xl/yroXsLXRSxLjn0Ks/lG9kuUs=;
 b=OBXLKhyuQf79rkTkMVSbcq+cNpuuD+ImIKBfDXw9FnWk3tKhxKwy90MQ+KgPu/WmtF
 MXR8dOioH1n9P37RZDwkrI9poMvU/xiSbX/ZgCs3nDb2+QDRC6Xj9q+6uOdBaeJkLWg7
 KGi6HPCMVRauQf4kAOYDSsN9XrKpLN9naqzn9O6fw8frjmE0Xxt4+7DXjXtzbDm0rEbg
 IaextFsK3IlBYfWmL7ULnbSxhgL0hehxa6pCn5nQqdYx9wZ8vn8kGHB/XxVHLMCnKsZr
 vkgyLC0H+IAyh2Q4cTLNssdaiU5TYGhISkyF0Ok7p3mlERs4j/eTxE2Nqb03K8+ueUyM
 /9qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwrEZJTqGVOSllWFqLO9Wi5lxWmIXCuBGOw3OjVS13j6jOY2DHOtocV/H+YZR1XTo49bs=@dpdk.org
X-Gm-Message-State: AOJu0Yyquiatx3jvfkXmZxabum4fwjsgeNXrCL1C0WvIwOCAmDHhgSC6
 wbs9BAxoYuQBsMT7BTp8Y1ayj0rV8qe9x1uYWtgl32jQiSfTGednxp+rzqtubi6zGwj9ayUKHHU
 Vi4QCSpWINShzDSqqg6ZbAfttsEOoQlISK/zjdoyxwgED5d3PoF+2ZFLY83gOTHMR6JRhsKUXmt
 jXSmjClaqEfOXh8bw=
X-Gm-Gg: ASbGncvWtgGT/jvuKyys6UhMMXeLMCsLGYC1bwfZOJ+IWlkBs+ulp7yd+wk2mnNdYbQ
 /ZLwpk3l74hWj8PLcRtVKfx+ZR6CoHD76uOoU3oC6NMRFyr7D0XDfbDdg+DhtK3j7M9UsXbc=
X-Received: by 2002:a05:6512:6719:b0:54a:cc75:3d81 with SMTP id
 2adb3069b0e04-550d5fac3a8mr773161e87.4.1747212217700; 
 Wed, 14 May 2025 01:43:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9w3gbzfhGybHvXIdZFWwyuE6BsZM7dBzFx3g2MOVHwFwJfq9fJtIUjlwfxQ6YEkodqYx/pnMW7ryc1HX6M2M=
X-Received: by 2002:a05:6512:6719:b0:54a:cc75:3d81 with SMTP id
 2adb3069b0e04-550d5fac3a8mr773151e87.4.1747212217274; Wed, 14 May 2025
 01:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250513235308.2200865-1-joshwash@google.com>
 <CALuQH+XJqOAetnTO0b_t55Wf1Qn38dQSZvgj1rf=pTKja6ozyw@mail.gmail.com>
In-Reply-To: <CALuQH+XJqOAetnTO0b_t55Wf1Qn38dQSZvgj1rf=pTKja6ozyw@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 14 May 2025 10:43:25 +0200
X-Gm-Features: AX0GCFt0FF4nvSEhaNnmYaIFPWGCpXl_4jzfG_SkMtd6k_rgOzLl_Wl1ajbQAmM
Message-ID: <CAJFAV8yubQF_YJPGBQgs2oBzatFn4_D7CBWm92Ubtc=SVqu0-A@mail.gmail.com>
Subject: Re: [PATCH] net/gve: remove gve-specific PCI revision ID macros
To: Joshua Washington <joshwash@google.com>,
 Thomas Monjalon <thomas@monjalon.net>
Cc: Jeroen de Borst <jeroendb@google.com>, dev@dpdk.org, 
 Stephen Hemminger <stephen@networkplumber.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tCgPNfjtLmbm-6675n1BtnMFyb6cMhG54LAeXqPB5eQ_1747212218
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

Hello,

Thanks for the cleanup.

On Wed, May 14, 2025 at 2:46=E2=80=AFAM Joshua Washington <joshwash@google.=
com> wrote:
>
> Patch doesn't apply to the main branch of dpdk-next-net:
> https://mails.dpdk.org/archives/test-report/2025-May/877522.html
>
> It seems like the diffbase patch only exists in the for-main branch.
> When is for-main expected to be merged into main, and should we be
> building against for-main or main? Similarly, what should this
> compilation test build against?

Stephen is out for some time (until next week?).

Thomas may pull next-net soon.
(@Thomas it would be great if this additional change was squashed in
96a1290b6258 ("net/gve: support for gVNIC PCI revision 1 and later")
while pulling.)
But otherwise this cleanup can be merged after.

In any case, for net drivers update, please continue basing your work
on next-net.

Thanks.

--=20
David Marchand

