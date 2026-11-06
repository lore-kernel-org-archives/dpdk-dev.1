Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CD6606A331
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KrrYzyTu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8185942D72;
	Fri,  6 Nov 2026 12:28:33 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id D1765402D1
 for <dev@dpdk.org>; Fri,  6 Nov 2026 12:28:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793964511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Bzf1erqSH7uIb7U7U24Y9hR/QPfYowVmPXoMCkGedc=;
 b=KrrYzyTuJyRd/ucah/1AoO4YmoCxWrymgExDsZQdltZj/Iri+ZBaNJdpWTxRb1y+O2MFG8
 PxKznkikkaOVKLZ8nmQbI9R5h+W+fvb/5HwuWZVG96BDwSS4NuKVIDeITq7NFfQ1aYJmmq
 Oju+yzK+XjBFhSOezzA3Go1NgoZ9w4o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-0rbo5R92OtiDvbgwLBYsWQ-1; Fri, 06 Nov 2026 06:28:29 -0500
X-MC-Unique: 0rbo5R92OtiDvbgwLBYsWQ-1
X-Mimecast-MFC-AGG-ID: 0rbo5R92OtiDvbgwLBYsWQ_1793964508
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a359c7f47bso5437375e9.2
 for <dev@dpdk.org>; Fri, 06 Nov 2026 03:28:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793964508; x=1794569308;
 h=in-reply-to:references:user-agent:to:from:cc:subject:message-id
 :date:content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7Bzf1erqSH7uIb7U7U24Y9hR/QPfYowVmPXoMCkGedc=;
 b=Wpi9X3c2yA+CxKcSI47TrqfTwT71XVemTiB/Illu9Yq4IMP0OXTooE/legxad638Oa
 D2+HKYl4P9cICnmLh1FOHoGFKpW3OKyg1m3uzjExCOqCDl8px5vnvX/ovaYvvoOi9xzy
 FzxJbAngGTFVyFgBaCGwf59ELAlhWp/S5bpV0jUnfHPvbe3pRI3HapOckK4/Vj02T1s8
 5CafAb6yBUf7Ud0WDxc/w/wMG4ux3TAXP5FgMpAj7Zo3oqWoLdZcW5vZE0pYPS1shac4
 Z9g1KLPtYMVGdO5DHcVkCFEI8OHFX0FLFkYN/v2MDQZ30KOU8LLQdt1XyQd1wpPjqEZH
 vW9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBycIoVLElW7Qvu0WXijnW5pNdDQKFZHTFCk5dKY42esVhtxTmYD9R60NxweWPOr4pAKE9I=@dpdk.org
X-Gm-Message-State: APuU4Z/VbcrMlQ4MAn2eZPC4wN3usQDUTVv+os2+eNFmvXlzJlDMgS7C
 4gmsWrfr3B8rG9gn47gYK7WD6nm1yeg0bxrAx7jRw7AqbAbSDcD2B8PEBqbhGgAtZP6XPVJXtju
 fpB6k4mCFeakxaFa+7PwCRVPvcQFq0tCVlgqGnEoYH77p
X-Gm-Gg: AYBFou3ybYhcLqf6UuAUXpkqrXQmJlIGzqyi28kVHUjdXWyE1ci7FrTEMMmVpseFFnY
 X2Xc5sQ6/v613HFvvzJQhUvMuDxK+mOiRYrGVC4TnR9y181vLP1/6ZViZNJ8Ya1Z5woKpZ4ISDc
 ufaE51vcmC8YSDOC+Jdb7wmDng3aGyc8syoGjq1tycW0Fy6A8ApeSHQT84DWuxKmPn3rrdOz/6Z
 VfSCMRonyb4QFps8Kvmw936LPf/2maGfcKtW64JvMvjvgLCxQHc//JJObRW/Um+oFW+QsRGq2os
 AP25n+LmvxtZYyFDsTDnO+majfpYv/i63XYMSuPQPXuXP9YCbIV3vHPVVlaCw9iR64oa9iwAPTk
 4Cc05vn0rRz1W0e791lLZNGvAEPcq3wT9ck3C1EU4pX4JXrLy9NBQDE2DyI2RWUFYYhvJdD2/Am
 y2+IgWfv0dx6UJ9FmWnp3PmmNzWiNBxQ==
X-Received: by 2002:a05:600c:46d1:b0:4a1:df52:3e36 with SMTP id
 5b1f17b1804b1-4b6dfe8f4dfmr38751015e9.27.1793964508347; 
 Fri, 06 Nov 2026 03:28:28 -0800 (PST)
X-Received: by 2002:a05:600c:46d1:b0:4a1:df52:3e36 with SMTP id
 5b1f17b1804b1-4b6dfe8f4dfmr38750585e9.27.1793964507919; 
 Fri, 06 Nov 2026 03:28:27 -0800 (PST)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d6d63b6esm3369906f8f.10.2026.11.06.03.28.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 03:28:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Date: Fri, 06 Nov 2026 12:28:26 +0100
Message-Id: <DMO3CD4MJZFH.1V9HO1S49IQ1T@redhat.com>
Subject: Re: [PATCH v2 1/2] net/tap: fix FD leak on netns change
Cc: <stable@dpdk.org>, "Stephen Hemminger" <stephen@networkplumber.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: "David Marchand" <david.marchand@redhat.com>, <dev@dpdk.org>
User-Agent: aerc/0.22.0-38-gda2e3af216c4
References: <20261103171730.1361878-1-david.marchand@redhat.com>
 <20261106085701.2429186-1-david.marchand@redhat.com>
In-Reply-To: <20261106085701.2429186-1-david.marchand@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q87vYJ7gCLJ2w5xh4hSiZ6EbMtOGpYZwKpNOamxkabM_1793964508
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=flowed
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

David Marchand, Nov 06, 2026 at 09:56:
> When a tap interface moves to another namespace, tap_netns_change()
> calls tap_lsc_intr_handle_set(dev, 1) to recreate the LSC interrupt
> without first tearing down the old one. The previous LSC netlink
> socket fd is never closed.
>
> Defer the full LSC teardown and re-registration to an alarm callback
> which runs in the interrupt thread but outside any active source
> context. The alarm switches to the device's network namespace, tears
> down the old LSC handle, sets up a new one (opening a fresh netlink
> socket in the correct namespace), restores the original namespace,
> and forces carrier state back up.
>
> Extract tap_dev_ns_switch/tap_dev_ns_restore helpers to share the
> namespace switch logic between tap_netns_change and the alarm.
>
> Fixes: aae3a38e9e03 ("net/tap: detect namespace change")
> Cc: stable@dpdk.org
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Reviewed-by: Robin Jarry <rjarry@redhat.com>
> ---
> Changes since v1:
> - moved pmd->if_index clearing before trying to change netns,
> - moved alarm registration after netns changes succeed,
> - added second alarm cancel for unregister race with netns change,
> - ignored ENOENT suggestion from AI review,
> - added error logs to please AI review,
>
> ---
>  drivers/net/tap/rte_eth_tap.c | 99 +++++++++++++++++++++++++----------
>  1 file changed, 72 insertions(+), 27 deletions(-)

Tested-by: Robin Jarry <rjarry@redhat.com>

