Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C61C624DE
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 09:15:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B89EA42E56;
	Fri,  4 Sep 2026 11:15:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4142A42E4F
 for <dev@dpdk.org>; Fri,  4 Sep 2026 11:15:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788513341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9QqKZEICn3nM7CoL6I1i4qxOeMYQqZGFzVg+IKX2RCw=;
 b=ifCPbBworr+qknYyCcV9hcHjPHLxbN91ZMhhGqN9nfyzcIdIm38pTvt/+ni2GRiSfKd2H3
 rg036fBFF2+kFZOYg2WIqVzY76Zvf+rpf+qUE9I6V9PIN3265eTsvOwDSGGyoXcblGFv3Z
 JAoUIDvTyPiQpURCWHZSlk5wIvvGXBg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-y7OJbsafPeawX11Ydu5LHw-1; Fri, 04 Sep 2026 05:15:40 -0400
X-MC-Unique: y7OJbsafPeawX11Ydu5LHw-1
X-Mimecast-MFC-AGG-ID: y7OJbsafPeawX11Ydu5LHw_1788513339
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5b667b38b04so105389e87.2
 for <dev@dpdk.org>; Fri, 04 Sep 2026 02:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788513338; x=1789118138;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9QqKZEICn3nM7CoL6I1i4qxOeMYQqZGFzVg+IKX2RCw=;
 b=Oo/q0LfD0zO5srbvon+Hz8qiZK0+DGRHHDSs6SwauI2ex+BMaa/WfE42YGORVnL1Ji
 aRdFklv6+FnktHMBzkjEYzevBKdm41i0nsryqKrfh1SFZ0RqPYs7kMCFjHW7p0eSLK20
 aC+GGeDM/xnp3Gc8ed8JZFhri/iYEuf5Kk+vdoWv6xW5D86q/dP/8UqC6Bhqi+LYD1gK
 St2XEIflxlTouPIGbvP0P4y7uZ2a7hG7txAzq6JJUcirC3LeCTzQVHQ5EPaWJTUUo1hu
 z4QO66UQ9KmAfoK9sdyHpKgsAvsA82hIBOw/lZ9VeZHIY2y9sSo8kVbHJR98SbIR5FKG
 DovQ==
X-Gm-Message-State: AFuF++nVY/o25KCeGUPaPzxiHHpZP+Fwh3x4oVZRhEczjsMQ+WxI7tBk
 R2XwKgb15ve0QmcJ+F6pXfAtazxQrBon94x070ROCE3jWCoYq9Wp4co4Ka3+1hGsRj4TuiVS0+n
 0uC0tT+Xvz/GsESOyekVwk/UFI2eC20iaDnDN+xchbgXZgcOBElCyKpMrcEHI2Yb+6W40WT59Ds
 YBbvWFCat7QkkLRbD9Zx4=
X-Gm-Gg: AYBFou17rrqix8NA66ZeDFpklG+Hl4vNk6L0483jBqjpCoyG/56dwQnou7FfJ5Wq2I3
 bdZetwVlcofGLF5rv/PEHWKw0nBSrzIpbFd5JpXshuVeK52nIdzBOlxF1Kz03+9T+R/TSik2FVS
 w5cVDfSanWFwKa3QhPfKZfc150V93O80SuHE/yfQ/TjMhtRx7OImQEqjzUFKCivPJUmVPL1aYwx
 tkFwowi3SGrZx+YAiCltaMtTDbx5RI1s7sxmLE/b9SpBx3x
X-Received: by 2002:a05:6512:3d90:b0:5ae:aeeb:e902 with SMTP id
 2adb3069b0e04-5b616effb2amr882655e87.13.1788513338532; 
 Fri, 04 Sep 2026 02:15:38 -0700 (PDT)
X-Received: by 2002:a05:6512:3d90:b0:5ae:aeeb:e902 with SMTP id
 2adb3069b0e04-5b616effb2amr882638e87.13.1788513337989; Fri, 04 Sep 2026
 02:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260720080035.673782-1-maxime@leroys.fr>
 <20260720080035.673782-4-maxime@leroys.fr>
In-Reply-To: <20260720080035.673782-4-maxime@leroys.fr>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 4 Sep 2026 11:15:26 +0200
X-Gm-Features: AcwNN1Xjw4Sziqf1GDFoH1c7tNmg3ljkkxX-nEhgtndjwIXSdj1qNVrzqo3WuHY
Message-ID: <CAJFAV8zERn_vy4yM00kddt6HJ5qoX8T7_9_x3ti-HHTxcFmTGg@mail.gmail.com>
Subject: Re: [PATCH 3/6] examples/l3fwd-power: enable Rx interrupt before
 epoll add
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev@dpdk.org, anatoly.burakov@intel.com, sivaprasad.tummala@amd.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MgbUKGMXBAf19dRCBcoW9VY0OeOymCSTUg8yItZwIm8_1788513339
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

Hello Maxime,

On Mon, 20 Jul 2026 at 10:01, Maxime Leroy <maxime@leroys.fr> wrote:
>
> event_register() added each Rx queue interrupt fd to the per-thread epoll
> set before the worker loop, while the queues were still disarmed. This
> works when the fd is assigned at queue setup and stays fixed, as on MSI-X
> NICs.
>
> The dpaa2 PMD delivers Rx interrupts through a per-lcore QBMan portal and
> binds the fd when the interrupt is enabled, not at queue setup. Adding a
> queue to the epoll set before arming it then watches an fd that is not
> bound yet, so the lcore never wakes from rte_epoll_wait().
>
> Register from rx_interrupt_wait(), after the queues are armed, and only
> once: keep the epoll entry installed for the lifetime of the loop. NICs
> with a fixed per-queue fd are unaffected.
>
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> ---
>  examples/l3fwd-power/main.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
> index 70f76d202e..4874a55de1 100644
> --- a/examples/l3fwd-power/main.c
> +++ b/examples/l3fwd-power/main.c
> @@ -945,7 +945,7 @@ static int event_register(struct lcore_conf *qconf)
>  }
>
>  static int
> -rx_interrupt_wait(struct lcore_conf *qconf)
> +rx_interrupt_wait(struct lcore_conf *qconf, int *intr_registered)

On the principle, passing intr_registered is ugly.

intr_registered is an internal state that does not need to be exported
in the caller.
Maybe move this to struct lcore_conf?

This change also drops a log that flagged that Rx interrupts were not
available, please restore it (maybe add a "once" boolean to only raise
the log on the first error).

>  {
>         int ret;
>

-- 
David Marchand

