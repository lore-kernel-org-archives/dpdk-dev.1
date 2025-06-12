Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF59C61CE8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 08:43:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57F6D40685;
	Thu, 12 Jun 2025 10:43:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6C0184003C
 for <dev@dpdk.org>; Thu, 12 Jun 2025 10:43:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749717787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9/yzxx6dHH217l7t6BuFOWuYu7iQMXh1XXxlKKwd6sY=;
 b=O0WUH6a2zZ5xMbT9IPB7PDQ7JvWE1BzD3+g5pw8lG7xs90VpqSA9Huyh1tGA60sj9Nl7sr
 sernf1vWRW2BUTvKh8+0wescbhDTJnYU9tQR34bLJZoRDJAx1UlifTP6YTj8i/eOdtLxus
 BM4seAFgwb8gGqd3BZjCAKtSrN4MCQw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-eyyXCEnvPvy8DelAorErng-1; Thu, 12 Jun 2025 04:43:06 -0400
X-MC-Unique: eyyXCEnvPvy8DelAorErng-1
X-Mimecast-MFC-AGG-ID: eyyXCEnvPvy8DelAorErng_1749717785
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-553266b8574so835295e87.1
 for <dev@dpdk.org>; Thu, 12 Jun 2025 01:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749717785; x=1750322585;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/yzxx6dHH217l7t6BuFOWuYu7iQMXh1XXxlKKwd6sY=;
 b=n4WWW02JYAAKJHQsKW8X01CdhN+kZCB3Ll0ZgOyoQEVAGWhGLS/rurCzIyCTvixbTY
 G/qukx4YqPFGM68UsCcXwZDdvhQgxTSG5jVeHL7Z6mKF1LElCl5D38pLB82duewIlA/P
 +WRDbNEmcZAnuHAPs4AoYxbDWeGXAWvy6bjcFWjBzBqENLqcaWDIE9fwTGzIf8Yi0C0I
 tc7yHulzLCCDzsbh0O/9VVFvPV027J+zujKdIaAghj/cd84CNiYEEQO8aiS+UeaxBxyo
 MzZ9hYBtx2M4ceemwGB24kPp4P4a64uA9ZXtHVozpLntGwUeQofrgVLjF9JfcXrD4KOG
 4qmQ==
X-Gm-Message-State: AOJu0YxlLAt/9TiSwbOOTU63MwP5lvw6SLLzxFqKgslsh9y9InAohApk
 ubWKVEUiti+nbX9ZbwtE3Z09DazJXwYxtRzn1V5cax5w7rvhYQWDgDja3XW/x5PHJKZ7Ua7tMBu
 b2kJ/Y062llwo9tgV/MzNuAvR+YC+VS5q3slRNs+9vtW8ZY3wYsPd6y6WnXgNmEAsfvenSSg00P
 BQtZBYo2gSLZT8rwafy1vA9+5yN6qqlQ==
X-Gm-Gg: ASbGnctB4R3kcckwmLz5WrJ2szjSY0vWr+TuRPf6nRpOGzjNbugIwX4MGs/MWOYVSHv
 T9ZWb4LlONw8WbDclQIpTrqTfewL97uEgggz7QchxuDk8JXow7JC2SQdqC9l32KTjwUlEvnos7b
 c496Pm4g==
X-Received: by 2002:a05:6512:118d:b0:553:2912:cfdc with SMTP id
 2adb3069b0e04-553a5435fcemr750762e87.9.1749717785058; 
 Thu, 12 Jun 2025 01:43:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfbbFdGLv5J8zXoaJeC8AJfbgmrZZ3UkiHs8n/k1k6fuEwUEqjB/8m8R1qvPL+qHLFx2ODGhRoM94jeJc5hlc=
X-Received: by 2002:a05:6512:118d:b0:553:2912:cfdc with SMTP id
 2adb3069b0e04-553a5435fcemr750751e87.9.1749717784652; Thu, 12 Jun 2025
 01:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250120095238.7888-1-zaiyuwang@trustnetic.com>
In-Reply-To: <20250120095238.7888-1-zaiyuwang@trustnetic.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 12 Jun 2025 10:42:52 +0200
X-Gm-Features: AX0GCFvDi2X-hh4OzgEkWl_gvbR2G9qOCu71SnLQ3x83Tq5LAAII78zR3ARYOvA
Message-ID: <CAJFAV8wVL0xNWta5zR-T1TDaww5Z_KYbEcAqb8d3w3_K+qfQdA@mail.gmail.com>
Subject: Re: [PATCH] maintainers: update for ngbe/txgbe drivers
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jQtrd3ZX9PEWwfjeyElbk1VmJnF80RPMCyNvHPrl8C4_1749717785
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

On Mon, Jan 20, 2025 at 10:53=E2=80=AFAM Zaiyu Wang <zaiyuwang@trustnetic.c=
om> wrote:
>
> Add myself as co-maintainer for Wangxun drivers.
>
> Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
Acked-by: Jiawen Wu <jiawenwu@trustnetic.com>

Applied, thanks.


--=20
David Marchand

