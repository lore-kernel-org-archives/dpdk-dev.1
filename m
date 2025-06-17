Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D504C71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 14:16:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F277410F1;
	Tue, 17 Jun 2025 16:16:41 +0200 (CEST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id B8C0640BA4
 for <dev@dpdk.org>; Tue, 17 Jun 2025 16:16:39 +0200 (CEST)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-4a44b0ed780so83843311cf.3
 for <dev@dpdk.org>; Tue, 17 Jun 2025 07:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750169799; x=1750774599; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N1Y2d0QxXIGxyWt/sv7B452g2+SxvV9NJvoqTjE2InQ=;
 b=ce2ZypsBSfgLjSPSm1H6WzKDmsxrg/iKvyouA2F/pXAIXe1OTRt3miZBpLQJRojrSp
 Hne9lwCzNLo02ZCvwAFJLzPz+hIUUrvNT+CzR/tTf+5dwa1WpF58vIJCjTyPlECxHZp1
 Rhj49fhdRVvQQqHpCUnw6rqDk8NIO4P+c3IQ4/WBKOnFgyxy5+dc8vTAJC+yYS77vxJw
 4qxWXjBdZArZx68J71mHO4LvO8Ja0dsf6VInAoKpJ4ST8c7QROBEJ68Z4WTBdvtV8flm
 2uch9ns9yWFy0bdYNuVr6AO+drsW6j2g7KIkcjBaGAyBFcr6GHagdb2OYtJ708iLMwJ0
 E8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750169799; x=1750774599;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N1Y2d0QxXIGxyWt/sv7B452g2+SxvV9NJvoqTjE2InQ=;
 b=w2rlxLh7zRNU/geqHdT7NAecgtICHIyL9ndjf29kkzSR40K2DtECUytgnQ6/gMUeEN
 0Vu0R4C6GCxjke0CVvCMRovWGLCNAhB0JD4RH0ugYh2ePTjz+yBrf801DJhst8pziqek
 ocRd4rxlHi0F4Sy5pK9GYdpo0aK+V0ZTj8gcmGs6RV4NO500XgPCq8/juOGnNVr5lxLh
 YkfkmuO4cy0UyZojVUqvHhQFV/7XaAuWWK9v/kW1cHtoFjyiZ5ETzsBtuZ5ymXA3PNjg
 Pyb5tA4fLt2y5vs7Wh+UTEL7H94KxLIXaGXia6TDic1mUIjklV82vFNhHCKdIR5ho1zV
 W/ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXz6eP4pQ7kPN+XzNgbvwmyOSg832KRkvndHr4H4pmZYo+TFuAoqiLbUknMTF9Af07BLcI=@dpdk.org
X-Gm-Message-State: AOJu0Yzb61Lj5OUXMNpMkUHd5QJUkK0mzp2LSvbZXaWehsrtXUqlP9cF
 ECDPzLbBJPryewHhvE8JZ8IswA5TabVOQjDrhZpUUS+6no7k9MYXPHO/om/Pde+gLEzjx6i6lui
 sxklD4p0/lxq00FNDhqJpmSIZ6sbgX6E=
X-Gm-Gg: ASbGncvYpPrX71BDM9kA9WVV4GxpvOVJ7f8G4zU1F4uLRuZA+6oXQtrh41yQfQateZl
 vUT4DX4tYSgoXf5iYrHqRiwdLfy8DiAkO1FsUAHajnZcz1UUJSllmmhCkQz5Oj+5vCyFFpxAlVZ
 YyXT3rIwX4WEcT9RJnFn0BeV3eLHkNi+ba4ZSWYAGSsQ==
X-Google-Smtp-Source: AGHT+IFjV6W4zwXLwFtsQW0iTNRFceuGtRuOF3+ewUJQ+KYD9IbTDIorI9+4aAf2uURDGjtIwyT6UP9lAbS2CSr50uc=
X-Received: by 2002:a05:622a:2d5:b0:4a2:719b:122e with SMTP id
 d75a77b69052e-4a73c53b18dmr217739911cf.18.1750169798659; Tue, 17 Jun 2025
 07:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250617105209.50526-1-marat.khalili@huawei.com>
 <20250617105209.50526-2-marat.khalili@huawei.com>
 <20250617062716.17e6b86e@hermes.local>
In-Reply-To: <20250617062716.17e6b86e@hermes.local>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 17 Jun 2025 19:46:11 +0530
X-Gm-Features: AX0GCFtUYC5AY88vjJbNXhqIVGUbsiw3p1mrAElNjitS4hYxIr7w-gpcMUrxo2k
Message-ID: <CALBAE1MCqfhVvcfEY2R+m=FiBXpeznoktHnkGKkOVf4G+onjtA@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib/graph: rte_malloc for cache-aligned structs
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Marat Khalili <marat.khalili@huawei.com>, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Zhirun Yan <yanzhirun_163@163.com>, dev@dpdk.org
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

On Tue, Jun 17, 2025 at 7:07=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue, 17 Jun 2025 11:52:08 +0100
> Marat Khalili <marat.khalili@huawei.com> wrote:
>
> > This was flagged by undefined behaviour sanitizer: struct
> > rte_graph_cluster_stats is declared as `__rte_cache_aligned` but was
> > allocated using stdlib realloc which caused misaligned allocation. More
> > than one test needs to be executed in series in order to reproduce the
> > problem using graph_autotest, e.g:
> >
> >     app/dpdk-test --no-huge --no-pci -m128 graph_autotest graph_autotes=
t
> >
> > First sanitizer message  (similar ones follow):
> >
> >     lib/graph/graph_stats.c:209:13: runtime error: member access within
> >     misaligned address 0x606000008ea0 for type 'struct
> >     rte_graph_cluster_stats', which requires 64 byte alignment
> >
> > To fix the issue replace realloc calls with rte_malloc and rte_realloc
> > specifying correct alignment, use rte_free to free the result.
> >
> > Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
>
> There is a way to get aligned memory,
>
>        #include <stdlib.h>
>
>        int posix_memalign(void **memptr, size_t alignment, size_t size);
>        void *aligned_alloc(size_t alignment, size_t size);

There is a need for aligned realloc. I think it is not there in
standard libraries.



>
