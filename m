Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFCE606A335
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fz4Zezx0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 076AB402D6;
	Thu, 19 Nov 2026 13:43:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 8F5E7400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 13:43:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795092226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lz5cNmjKARGaWkBDyWJgCvT+/pZfpAp15Nud8k4kPQY=;
 b=fz4Zezx0NLcs03PqCASXNiabbOe5mIWwUwOZhHQDaDmkcFiulB5DYJMxjqWuesfRT/HMjs
 b98yto9jAyuAMgaY8uMmauPVG3TyEpAGm5PtwhuLNLW5+TpZQFtqffHHc8oCnX3UfeLmf2
 FvVfbkZopL2470epR7NsZDDMpkJaO7Y=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-vAwbCnZUMNOIaebYHnA2zg-1; Thu, 19 Nov 2026 07:43:45 -0500
X-MC-Unique: vAwbCnZUMNOIaebYHnA2zg-1
X-Mimecast-MFC-AGG-ID: vAwbCnZUMNOIaebYHnA2zg_1795092224
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5c157e38aedso124015e87.0
 for <dev@dpdk.org>; Thu, 19 Nov 2026 04:43:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795092224; x=1795697024;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Lz5cNmjKARGaWkBDyWJgCvT+/pZfpAp15Nud8k4kPQY=;
 b=vMu3tmVeP9tqnvC+0+Li7n+G9/dOIFYnvAzkW+2luYeTcKJK57kau+ynjJeAdhwij3
 5TODF67HTW86M6WKsd8JLe2C7gnxwJzGdX8s6x3byZ2zTgPpWOWWe8yJVKomy69BTiMx
 Ptv4JrFHFuAe7TvICyU41cKz6X5oc9tHgznoyowPbHTtoj6SJ2MyiqlPAtGRWVY2kPbT
 2Kc+DdcEyw7OOhON4aVttXEYRZoDCm8gcu+SV4TGkjc0qBaTjAeve2t86TII7+i+jkFr
 yOaxpOG+fKhWmwXOfA1a4e4y7S713A3lWthEAufuLiJW7iCT2/AYCJy8+d4MSdEh9HdP
 EGjg==
X-Gm-Message-State: APuU4Z+bfOr2KvqS18+WMPrxkW+kCF3U2WON7MkxYSLX93Mqs55OqoO8
 8pd9Ze1BxmypvgZ5se/ejgWaVc1z/rTq2gxlHHtfaOp3mKK30CIvOPeUPIrY++HgrCPzpdSxI1C
 FkfRNGilYf6mO8BdJGnom0/Tph4DKK0RPOE7jaky3V2+WP404xYDv/61fRmNF9SBhqL38J4Aea1
 obPrzmXykYepp1d8yHm3g=
X-Gm-Gg: AYBFou0z2dk78iXJOZXcKFI92zbBdKAz0UMYrPfz7y+7h/s9SAq1OxZOhP5MJe14Coc
 Pd/3109lclEwzPK3ggQksasZ4t+cmzRizmA09LFxkIIwBQbv5Z/q2wYNJywFU211oIxOv4KtiYu
 norDWlgMXlyAdpm9n96Q1ugPkjY83DqNCOd/9ydTy99SdiHe8HulYRopZDnVvhQDIGYLEx1r18y
 0FonhI1rAxxhxzUF2HH8iDt/f6NIuwhf8oh3RXYl5UbbLvj
X-Received: by 2002:a05:6512:1582:b0:5ba:3e27:6a32 with SMTP id
 2adb3069b0e04-5c1b7c48c8amr368921e87.29.1795092223680; 
 Thu, 19 Nov 2026 04:43:43 -0800 (PST)
X-Received: by 2002:a05:6512:1582:b0:5ba:3e27:6a32 with SMTP id
 2adb3069b0e04-5c1b7c48c8amr368915e87.29.1795092223176; Thu, 19 Nov 2026
 04:43:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103140411.484629-1-roma55592@yandex.ru>
In-Reply-To: <20261103140411.484629-1-roma55592@yandex.ru>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 19 Nov 2026 13:43:30 +0100
X-Gm-Features: AclHuK9epK98yPGTTM-ebGaroZu2OtGIi_w5rSv-d6xiICo5VjmgNYxXwQRUasA
Message-ID: <CAJFAV8z=k0qGP4n8VivS=JQySjyZW2=jG-QOLSSwGb_uOgDEKw@mail.gmail.com>
Subject: Re: [PATCH] devtools: ignore context lines in check-symbol-change.py
To: Roman Khromenok <roma55592@yandex.ru>
Cc: dev@dpdk.org, thomas@monjalon.net, stephen@networkplumber.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3WM3nFbst0wddUNKHx2SBRwjGiu06N49_xQQLRM6rCI_1795092224
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

On Tue, 3 Nov 2026 at 15:04, Roman Khromenok <roma55592@yandex.ru> wrote:
>
> The export regexps match any first character, so a context line
> starting with a space, like the export macro next to a removed
> function, is recorded as a symbol removal.
>
> It makes the script report a false positive, for example removing
> an experimental function while rte_eth_dev_get_dcb_info() is kept
> a few lines below prints:
>     INFO: rte_eth_dev_get_dcb_info in lib/ethdev has been
>     removed from stable ABI.

I guess you hit this issue for the change committed as 38fed193891e
("ethdev: add API to decode module EEPROM").
It would have been more clear to mention it.
I was a bit skeptical when reading the commitlog too quickly
("removing rte_eth_dev_get_dcb_info ??" ;-)), at first.

> Match only added and removed diff lines, starting with + or -.

Yes makes sense.

Fixes: 1a0c104a7fa9 ("build: generate symbol maps")

> Signed-off-by: Roman Khromenok <roma55592@yandex.ru>


Acked-by: David Marchand <david.marchand@redhat.com>

Applied, thanks for the fix.

-- 
David Marchand

