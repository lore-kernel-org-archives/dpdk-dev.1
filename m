Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BD7CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:32:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFBBD40652;
	Wed, 15 Oct 2025 09:32:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id BC8C2402C3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:32:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760513547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SSUVJ5t0QQK+yWKhgkmX/8lmieGK1wNpQy64zp57mEQ=;
 b=gmHWSGoa3IsWaTmDrTgxPuCQ0UUEaTtnKx9DjAI7+1dmUq9R3wVgWTkmcVFziJFT/3Rs4E
 i8eHEmGgTggnZzPsIpMP58V/ccL3VoieNX4P5u4MESUs9iUwATlvQiYgIg71h1OX7uSOEw
 YIvd2Hl+XeX4g6K3OHtRju2+n+fu0yc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-KUOMt-yGM4CI8XmhQYb2fg-1; Wed, 15 Oct 2025 03:32:26 -0400
X-MC-Unique: KUOMt-yGM4CI8XmhQYb2fg-1
X-Mimecast-MFC-AGG-ID: KUOMt-yGM4CI8XmhQYb2fg_1760513545
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-57875e2885eso5085517e87.2
 for <dev@dpdk.org>; Wed, 15 Oct 2025 00:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760513544; x=1761118344;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SSUVJ5t0QQK+yWKhgkmX/8lmieGK1wNpQy64zp57mEQ=;
 b=HNZEUbPdUd6WpsFzwzlJedkZT3rhuT7GWxTptvxp9NV/MID8AIW94/2ZIT5/QcJtjm
 vGmo+VXhEHQBQoAM8llptv23uSadyXPwDJYvjIFpU6yHwBSiK9V041EYiuiAzyLVTJUB
 eESIRRmdWhxrkNZmlSgNLpy224KTwZv6UI/H+cR8ICMeTXjNZtPhInUAHmrxqJ9ibPpW
 mYZgOjy7I46KGXjItn8mDywq/M8Pp0QTNbC1m2spjqD+MwUZvXXhSjYHoaQv5fmIIAtf
 T60fz2vP8r56lmzE1XjYta5PG6BYlu4fffY1HvzztsJWW2aQWzNiZYYfOYtjRMllfC29
 2YMQ==
X-Gm-Message-State: AOJu0Yzz+ubiOF01NhcXBiVDssEc2rWkPdgkZfYLgBWs2lbmeHUCYjyd
 4tLyL5FkvZI8FuFbxp56xFaoQyrJBWcPLEVg3xIizrGK7VVw34om3CUDHdBWpnUr5Do799t+GaI
 V/cFee4smCVczenZndWUFtLlw9ttjCu1jzc9dyqilsoA5n9IoNyhCGiZl64Ai34aLXlkNtb3hly
 tZtiCKFxwcdTas9cPL2zU=
X-Gm-Gg: ASbGnctooXoHBu64l7FU8cW+jp6d1u4OXC1z5bE5ON9BXJS69GYj3o4TGIF76IbFrGz
 XkGcRY9LlUDhV7zvqQk2dBsrJDWdTj2v3HIq9BI7Lsp815bBfNd1Qou41LULdgJT3zoqIoYKG0r
 PjLUQ2ljP6XwOwfJSRv6M=
X-Received: by 2002:ac2:5685:0:b0:58a:fa11:b7a1 with SMTP id
 2adb3069b0e04-5906dc16d75mr8377288e87.24.1760513544586; 
 Wed, 15 Oct 2025 00:32:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOAl/yd3V/dLIbqy36BuzlgWinp5tt/hbNRL5ocagLd2ASajxiQ1ucDf9+ocd1MKiCOQmP46P5r/DdWeNvcEQ=
X-Received: by 2002:ac2:5685:0:b0:58a:fa11:b7a1 with SMTP id
 2adb3069b0e04-5906dc16d75mr8377280e87.24.1760513544137; Wed, 15 Oct 2025
 00:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20251008090444.2689652-1-pravin.bathija@dell.com>
 <20251008090444.2689652-2-pravin.bathija@dell.com>
In-Reply-To: <20251008090444.2689652-2-pravin.bathija@dell.com>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Wed, 15 Oct 2025 09:32:12 +0200
X-Gm-Features: AS18NWAz3oeDT-qjhIlro_0xlgr2tn0zKM4ps7WKvUAhh0Q9U0DdEZRKee3kBBs
Message-ID: <CAO55csx8bxi6LDi81XSaN2o1SNHFVBnQG5Emewv-nRcy8yWr0Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] vhost: add define for configure mem slot
To: Pravin M Bathija <pravin.bathija@dell.com>
Cc: dev@dpdk.org, pravin.m.bathija.dev@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V4x3kbF089PiaU_gREhst98lt3xyZ7fAQQpgOCCx7fc_1760513545
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

On Wed, Oct 8, 2025 at 11:05=E2=80=AFAM Pravin M Bathija
<pravin.bathija@dell.com> wrote:
>
> * add user to mailmap file
> * add define for configure memory slots
>
> Signed-off-By: Pravin M Bathija <pravin.bathija@dell.com>
> ---
>  .mailmap              | 1 +
>  lib/vhost/rte_vhost.h | 4 ++++
>  2 files changed, 5 insertions(+)
>

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

