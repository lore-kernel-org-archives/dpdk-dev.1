Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B10CCF9FE
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 14:41:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CE50402D8;
	Mon,  3 Nov 2025 15:41:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B192A40285
 for <dev@dpdk.org>; Mon,  3 Nov 2025 15:41:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762180897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fZ+BBlwQ1ovhJVwVHIGqIRhajYObYQGdp6ze8jTj44I=;
 b=Q36CqqAcKi56s8ECgNDdeYxsOaecwm5okRAhFemsrlczQVJzwAZeTI3e7ReTpDalInLMYs
 MIFwpG8a6qGiq3+9MxIZX+qW4TpLzlM7sTaBriLNllwFkY2wqE6FzIUrPXNdc+1k8DzXi9
 X/edTL5HPcdCs0nLnl3oET+K2ovV8NA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-Z9KXvtRSNz6_oh3kRH8-5w-1; Mon, 03 Nov 2025 09:41:33 -0500
X-MC-Unique: Z9KXvtRSNz6_oh3kRH8-5w-1
X-Mimecast-MFC-AGG-ID: Z9KXvtRSNz6_oh3kRH8-5w_1762180892
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-37a2ca2cfe4so6893831fa.1
 for <dev@dpdk.org>; Mon, 03 Nov 2025 06:41:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762180892; x=1762785692;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fZ+BBlwQ1ovhJVwVHIGqIRhajYObYQGdp6ze8jTj44I=;
 b=hfespqsnyr82EEQMK95kBdb23Vv5Sk3GH+sgpBZZ42F6amUhHH2kguAkyiEjPXA4N3
 iE3oNZglV7cXZ0wt5izaZzAW89GTsL29H2O+sJbFAWpx4GLvJjRaWAMzZYR0iBu+GvSd
 +Pqjj9KumOXdOHITNT74nenjDsfvuU4KSGGIYJRb6vSmqmp+iKUyW/URjTcMedRAvCx/
 iZ4lYtEG3AYvTiwEX4utOlA8rKJogzuS/HKlFO06FYB/AaliyTsAfN7ilzs6A5+9bsde
 APYKdhJru+ZP6V3ImDOY+Wv7I/uEbgRlVe0tbF0FUyAL7LgCbvAO6uUKt1UHYN67IrdE
 H49Q==
X-Gm-Message-State: AOJu0YwhRA9QVMZLqA63xoQlivw5io5m/mBFsBLSW56U17Wo67UETmP3
 WqyX8CO7y4a44fY7AvL668PE9biKQ1GduX45urWgyhFjklASOFDN0CrPuGtdYLmOQRg1ZnGiw+H
 iuflTe/Pvfs9josRMrj5LtuL9rEoFHMIaiZDj2bwUZJPdxr36xXTKnxn6GBLdwKU5fTMZutKt4v
 VWgGzSiHmWNAvyB3zR2VE=
X-Gm-Gg: ASbGncvWdaiZo39xEQ/JYy/VlRDECG8dMVlxv6t1s6MJ4woPhFXqOrTMvDwu2lrjP2U
 BMlfWni9OR+8p/1v4SvdtQ2fjSEG3jpag4pnoWex9KzO63M6HDGvGG8wE8AXnHtiT4WAKVBJut8
 4TRH2fpJIdV7/Qsr1z+w89Us4fhCINTbueuvlsethYxyo4GSFxgDeatw==
X-Received: by 2002:a05:651c:19a6:b0:378:e673:cff0 with SMTP id
 38308e7fff4ca-37a18da4d4fmr40910311fa.5.1762180891701; 
 Mon, 03 Nov 2025 06:41:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMp+NPk4duMWGVcEJmnbxDhtImogIkaXvwPM6TU6ZEDDebMMQrap2jAHOVjrqBTHxBI4QPqvHd+vsts4wLLzY=
X-Received: by 2002:a05:651c:19a6:b0:378:e673:cff0 with SMTP id
 38308e7fff4ca-37a18da4d4fmr40910211fa.5.1762180891285; Mon, 03 Nov 2025
 06:41:31 -0800 (PST)
MIME-Version: 1.0
References: <20251028123453.4127525-1-david.marchand@redhat.com>
In-Reply-To: <20251028123453.4127525-1-david.marchand@redhat.com>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Mon, 3 Nov 2025 15:41:19 +0100
X-Gm-Features: AWmQ_bn9z0zFT4AXXbP5b4N8SoDzY8BWt-aql5F7XthQrPy1HXYUkrwNgvFUxeA
Message-ID: <CAO55csxyg9ca23VmoonjxukV93KKydWRgkGL2Y_Dz4k7oUVA8g@mail.gmail.com>
Subject: Re: [PATCH] vhost: fix external buffer in VDUSE
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, jmeng@redhat.com, stable@dpdk.org, 
 Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3tLT6CWMhF9ykiFpgDPvK6ouVrn-D3iCr2pZ6CGCKSY_1762180892
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

On Tue, Oct 28, 2025 at 1:35=E2=80=AFPM David Marchand
<david.marchand@redhat.com> wrote:
>
> extbuf and linearbuf features are required for (enhanced) TSO support
> in OVS.
>
> VDUSE ports were generating multi-segments mbufs in case of "TSO"
> buffers which resulted in OVS generating wrong packets after tunnel
> encapsulation.
>
> Enable the missing datapath features.
>
> Fixes: 0adb8eccc6a6 ("vhost: add VDUSE device creation and destruction")
> Cc: stable@dpdk.org
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  lib/vhost/socket.c | 3 ++-
>  lib/vhost/vduse.c  | 8 +++++++-
>  lib/vhost/vduse.h  | 2 +-
>  3 files changed, 10 insertions(+), 3 deletions(-)
>

Applied to next-virtio/for-net-next.

Thanks,
Maxime

