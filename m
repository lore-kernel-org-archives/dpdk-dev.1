Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50009606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iF1l0VCB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B11840A81;
	Wed,  4 Nov 2026 17:43:04 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id BE36A40281
 for <dev@dpdk.org>; Wed,  4 Nov 2026 17:43:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793810581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uumcbsmM6DQ0tyweerxjaYnbrD4NHjoz6jldCl3vTIQ=;
 b=iF1l0VCBSEcZSc2pceLe37hWSdwt98We920wtNgXvisI/oRNFFH0axH4W5UiCFe12oz9fv
 aNcydmXnF5yygiPMJYkv0KygJ9tK1HhHibmlpdUBWdyDAUfE+7TkwzFsO/Evv8bK9MYUVM
 tJ5BdU5UHD4uYqgb0ZGdQXEvNsKdq8k=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-Hvge3htYOHOHoLV3G3mcVg-1; Wed, 04 Nov 2026 11:43:00 -0500
X-MC-Unique: Hvge3htYOHOHoLV3G3mcVg-1
X-Mimecast-MFC-AGG-ID: Hvge3htYOHOHoLV3G3mcVg_1793810579
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3ab3650ca2cso5538631fa.2
 for <dev@dpdk.org>; Wed, 04 Nov 2026 08:43:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810579; x=1794415379;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uumcbsmM6DQ0tyweerxjaYnbrD4NHjoz6jldCl3vTIQ=;
 b=t/TG4jKMx7rKv3GYjlzzqRjTZ/KjQp+y43xTf0KRxEKLz1ONKkTQ3KHwx6OnSf4931
 apttEnL6wKonIDrZJBvU5cwnqwf7FPoGrJRexe394fhrzdFiU0pcKria1mJ7xNbMkFZ2
 nJ2MPSJigl+Ex9ABZCBN8GDuO0Yf/wpNHarOCaSEweq0vJDPK39YkVFafoPjuSNQ2QyY
 yWL4ivOfiBt9eobGkhZ8gooov5LEt8jtPFARGCeuvWqKIq0DzjsvkwGssyJjE5FSyose
 hjBu4Qgp2O7f/9jzDFCpsP6bFp5kd1SnuNHI513EOJIj7Qql97pnBhwEeWu5egs8BZJ+
 h58A==
X-Gm-Message-State: APuU4Z8GXbqdd14lGAqTUPj+LeOMUtT6NosKjcNwU8TujYVAn5JklUqf
 CpJhjL1WExyI2HRRoxM2Sf7FaShwrF282ERv+NKCq2N3e3CFQvDGsUvy+sbizKXLyVhA5moINNL
 wJW8pq1W+ZO7+dmsvbfdouqahBYQ/NJ589pyD81Z0yMbgHIjBor48QTg62vKRVpRJ8fJG/Hi6rb
 4hZuaG/w9NwVgJlOa3VCo=
X-Gm-Gg: AYBFou3LOQiB72xArUyzg1fxWIbah59wm34TFxvJMCODIxljzqgtmZJb1B9aCvK+Bqz
 z5v4i+kK9LYiL4gQIhQOJdXvhvRija2pASy+Jx6yJPuMdVd9kTHX43iR8esAK2p0QajAu6+SfYC
 bOEy+gUM8qb8byCTQDRZ8/IWNiJl+INiXcFTTUEm0W22BbmBVU2ryYgIfdK0J8UayefqdoW7BGK
 l1R+O/8NDusgMf5C+WfmlophzSrIp6VhBjDc5r4GD0h4k9V
X-Received: by 2002:a05:651c:3605:b0:3a9:811d:3a58 with SMTP id
 38308e7fff4ca-3acb7add60fmr40521111fa.14.1793810578983; 
 Wed, 04 Nov 2026 08:42:58 -0800 (PST)
X-Received: by 2002:a05:651c:3605:b0:3a9:811d:3a58 with SMTP id
 38308e7fff4ca-3acb7add60fmr40521051fa.14.1793810578525; Wed, 04 Nov 2026
 08:42:58 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029100329.3cb8fa14@phoenix.local>
 <20261030102218.3489371-1-sriram.yagnaraman@ericsson.com>
In-Reply-To: <20261030102218.3489371-1-sriram.yagnaraman@ericsson.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 4 Nov 2026 17:42:46 +0100
X-Gm-Features: AclHuK_ZCrKuR0u0QJamiBA3nYJFPGtREgJ6hoxag77MkWPbvU4R5FPnny_XmT0
Message-ID: <CAJFAV8wtffcwSuLdc6Xt3wrBXS4htcctU2q1x87kf5piHCgZzw@mail.gmail.com>
Subject: Re: [PATCH] net/memif: fix race between interrupt thread and stop
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: dev@dpdk.org, Jakub Grajciar <jgrajcia@cisco.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kyLp66CFRvEHestWRiVFvG6u9xPvH-5bOes32uzrhdA_1793810579
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 11:22, Sriram Yagnaraman
<sriram.yagnaraman@ericsson.com> wrote:
>
> The control-channel callback runs on the interrupt thread and calls
> memif_disconnect() when the peer hangs up. Nothing ordered this against
> an application thread stopping and closing the same port. When the peer
> of a loopback pair is stopped first, the callback can still be running
> memif_disconnect() while the port is closed and released, and then
> dereferences dev->data which is NULL. Seen as a SIGSEGV on the interrupt
> thread during memif_pmd_autotest teardown.
>
> Detach the control channel in memif_cc_detach(), called without cc_lock:
>
>   - take pmd->cc under cc_lock so only one caller owns it;
>   - on the interrupt thread (the callback itself) defer the free to the
>     pending-unregister callback, as before;
>   - on an application thread wait for a running callback with
>     rte_intr_callback_unregister_sync() so the device stays valid until
>     it returns, then free.
>
> memif_intr_handler() no longer disconnects a device that has already
> dropped this channel: it stops polling the fd and returns, letting the
> waiting application thread free the channel. Once memif_cc_detach()
> returns the handler cannot run for the device, so the queue and region
> teardown no longer needs cc_lock.
>
> Fixes: 09c7e63a71f9 ("net/memif: introduce memory interface PMD")
> Cc: stable@dpdk.org
>
> Reported-by: Stephen Hemminger <stephen@networkplumber.org>
> Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>

This driver dealing with interrupt handle is really complex (some
logic should probably move elsewhere... like an alarm handler maybe).

If the issue is a race between an application requesting device close,
and the interrupt thread invoking the interrupt handle callback, then
it means that the device close is not properly unregistering the
interrupt handle in the first place.
So my guts tells me that something like this should help:
https://patchwork.dpdk.org/project/dpdk/patch/20261104164153.1674329-1-david.marchand@redhat.com/


-- 
David Marchand

