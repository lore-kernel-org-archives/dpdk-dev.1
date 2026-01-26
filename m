Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDB1D19510
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 19:38:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 913D3402AB;
	Mon, 26 Jan 2026 20:38:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 45F29402A0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 20:38:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769456308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sEo4VfzjeLtsyTytyxMK5eVoLMxdgC3gdQjhLoyXLlI=;
 b=Iz/rrI1VvdrA7jMQnjhvj5sUVgw27FXXYAEe30KnUfbjWeCXMVDzrZjIOIbF6VnH8Ej2Jy
 v/9t+WAnwaq/tS9VUPeMQcCypO/JFL+qFYXXrcbswYD1nrzMx2plqJM9hpBfvqs2ui9jAG
 wB3OuAVXsP+TnxrfNA3/4rAHvEIV4Ug=
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com
 [74.125.82.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-RQ3_KOucPUmeLarJZUlIXQ-1; Mon, 26 Jan 2026 14:38:27 -0500
X-MC-Unique: RQ3_KOucPUmeLarJZUlIXQ-1
X-Mimecast-MFC-AGG-ID: RQ3_KOucPUmeLarJZUlIXQ_1769456307
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12339eea50bso30266835c88.1
 for <dev@dpdk.org>; Mon, 26 Jan 2026 11:38:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769456306; x=1770061106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sEo4VfzjeLtsyTytyxMK5eVoLMxdgC3gdQjhLoyXLlI=;
 b=MJGf0rKbHIy2on++uSM528JIfrd9k8jqU8OMfFSCT0njy46mojM7IGJ8jNrWo2+FRV
 HOaBiFbjMvrFi0NakohZLpzieADiPPe3jVAWFvaQIL2uC+ike4MedwdGGS2C2m4xiyJc
 I3aT+C2lzjlvl0IrdiAbjwW0lPKJ9HCSqJ5s4Po77aLA7HtDMdUSs+hBc/gcHzKOe0oe
 JNDa3GvS3HCvOJQUEhvApVJN09NJKUSGEx/hKif1Il8rECA8PEgFnDufnp/66ApxGmju
 fc8ddfXBcHpN507lLu5plc5IrvRlr0evTd7QhuSMf/enBUIKBLQ39r3BPaUOo7FfEHMw
 lBSg==
X-Gm-Message-State: AOJu0Yylmi5YSRULM9xbumMHN2bFuQETzjgURaY+vN8/7F6GnwopR0mF
 qp2Zr1ijVfQyMtKn9xGw3WKQ/02+bPH8ihtTOIXRc3Lw9X7l5v1FtXLineaTtcSdRQs6vGJvjFb
 1pAJv3VJMj/MYIN3GTwcY60+cVnL+Kk+t+GhXNwaGXYOM7jtEWnucpJ9Y5NtDTYQiDwGhu5kbOg
 mnxgxqxmS1Udpv0UaUGjvyiHqm0zr8fg==
X-Gm-Gg: AZuq6aJW8GVDW6FGGpRonBY4eqL3jVex1jdxEraIRV740WIqP3sAf5o4w4RslRGtdRK
 lykeMakp3Vin2RmvTxBUWwfzn8oLvLbaHG78sefzQV6wg4xxGA11MRFZqlsvduvbxCfNmMmsO2y
 YkQvdk9RyELP4CdBjFR+W5209Llj2kIv9kft4Ej4wxVZxAUQoHZHTCoWlcf2ei3gVe2C1h9cUBY
 I9sll6hJWhHyiuGekcSE9rNFY0jlabv5FZAOkf5wiotNCa2ARZKiA==
X-Received: by 2002:a05:7022:128c:b0:119:e569:f25f with SMTP id
 a92af1059eb24-1248ebd373fmr2666056c88.8.1769456306011; 
 Mon, 26 Jan 2026 11:38:26 -0800 (PST)
X-Received: by 2002:a05:7022:128c:b0:119:e569:f25f with SMTP id
 a92af1059eb24-1248ebd373fmr2666047c88.8.1769456305592; Mon, 26 Jan 2026
 11:38:25 -0800 (PST)
MIME-Version: 1.0
References: <20251222004446.62076-1-stephen@networkplumber.org>
In-Reply-To: <20251222004446.62076-1-stephen@networkplumber.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Mon, 26 Jan 2026 20:38:14 +0100
X-Gm-Features: AZwV_Qi1Cxvu0qbpmKf3k-xbo5n2diOPJG_r9QiNqlv7uVNCSlM0o739SuNEzts
Message-ID: <CAO55csxbeP_=vbEY1otqia73G-C-Q4FEqwYo8GAODijo5nmG_A@mail.gmail.com>
Subject: Re: [RFC] net/virtio: avoid global variable name conflicts
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C_4VbwESSQFv3_x-Ir5aGELnf3HZYutYMSksxKDJ1cQ_1769456307
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

On Mon, Dec 22, 2025 at 1:45=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> If PMD is statically linked, all global variables are visible and
> can clash with application or other drivers and therefore should
> have a consistent prefix.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/virtio/virtio_pci.c                   |  8 ++++----
>  drivers/net/virtio/virtio_pci.h                   |  4 ++--
>  drivers/net/virtio/virtio_pci_ethdev.c            |  4 ++--
>  drivers/net/virtio/virtio_user/vhost_kernel.c     | 14 +++++++-------
>  drivers/net/virtio/virtio_user/vhost_kernel_tap.c | 10 +++++-----
>  drivers/net/virtio/virtio_user/vhost_kernel_tap.h | 10 +++++-----
>  6 files changed, 25 insertions(+), 25 deletions(-)
>

Applied to next-virtio/for-next-net.

Thanks,
Maxime

