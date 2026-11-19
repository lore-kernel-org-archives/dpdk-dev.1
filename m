Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13165606A324
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BlsR5Whe
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B87FB402D6;
	Thu, 19 Nov 2026 14:12:11 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 1557F400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 14:12:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795093929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pmEplym9c9Imh+cjOqhERrqVb9a8b37RrUN/LcAz6Fg=;
 b=BlsR5Wheqm+tlUfKS2ZyJ+Uu4mSWHHHBNmXaDD2oAFs1qr+/HZeYDxHXPkyIRggEPvFriY
 wYn1uwWpP/2hGYtZQRNqz0A/s6RfvgDuaeNq1lLom4f8pQ9hJ+DFzSr8TTcczq/3vWxcZa
 0xVOqAYfCYw9c3lAHQTQ+kFcO7mwUQw=
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com
 [74.125.82.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-NCu-8GBZNtiJwjo-dSZj3g-1; Thu, 19 Nov 2026 08:12:07 -0500
X-MC-Unique: NCu-8GBZNtiJwjo-dSZj3g-1
X-Mimecast-MFC-AGG-ID: NCu-8GBZNtiJwjo-dSZj3g_1795093927
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1b3b63b9665so2035663c88.1
 for <dev@dpdk.org>; Thu, 19 Nov 2026 05:12:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795093927; x=1795698727;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pmEplym9c9Imh+cjOqhERrqVb9a8b37RrUN/LcAz6Fg=;
 b=T6UGGX5ApdBhAQ2UfFz7tZM98WDU3Mz5s46PkMCEgWDFClMBzJLmlAU6d60cHlAWbY
 BqKLyzldb0JW3qER+Lp9a0zf0M1mwvH4hLwFzbjpno8I0uOYXk/6Ih03WaXWp70B6wo8
 U7wl7TSV83YnVwkLrlcPZKUVxOAraQKV/obLnuo1npyw7iUMXRWt5XWccfUgrKs0Rbxk
 q/SEd1F4AVpjwFR+ig2TWQAhHQB27uiQ+otixfQkp/K1yjwVfw5EMQf2/1cDhq3clMbw
 FD4iM9AnBvyJ8wqvKG48jipnI6xlJVEovWc43ds6ckNq5lE6NyPHjDd2j9lO4IAUEl8X
 RC9Q==
X-Gm-Message-State: APuU4Z/Pwo9M2Z/KKITiCo4ffu/bnf36HcxXpS3kPShDjlUrI3peV4Pb
 XZWIlDCSKDynoSEvcx1xmksHcypA9VvFABTD0i2C+A0qOe8hXWVJQDiySjMSrF6oBveHLcyyPGn
 jte9ExTNOackcgyV9tAre/a48yRHuV2m+0wWwEo/3cOIkE7P3LneW1ZMS2CE0aWfl79l1MjsONT
 FexCTJohpuN5JhbzQDSD4=
X-Gm-Gg: AYBFou0qfL+EGVR30m5wLhQFvfXeElDugBfNhax9gvF3qynNcVmaOzQJ6VxT/RI8jux
 kvGU5YU0IBNFP4vK606UWYLd/YTyb8yfufWK0SqxTSdRHqO+KYa8gNaaJabbxMbG4zbZ7mr4XBY
 mBhEFyznLXieITa52ngp1z3E2ZDZbn/fdDJPJ4sn8vu4S+sqJ0+K3Ueul6sRZtUhDOuH+PcsB8g
 49C1knVqgR05RPAoHQP0VL9tds3eq4zbaLrEXg7iTv8uEigXQpbxR024ftIQp5E6swNW9zrdoIm
 EsSvsrP/o4/RrdQkRm2CaWC/9LJDzQd1N0+vG4gNBs0=
X-Received: by 2002:a05:7022:1408:b0:1b2:366a:e7d1 with SMTP id
 a92af1059eb24-1b543d3cc31mr5409573c88.32.1795093926667; 
 Thu, 19 Nov 2026 05:12:06 -0800 (PST)
X-Received: by 2002:a05:7022:1408:b0:1b2:366a:e7d1 with SMTP id
 a92af1059eb24-1b543d3cc31mr5409560c88.32.1795093926098; Thu, 19 Nov 2026
 05:12:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118152945.1404317-1-david.marchand@redhat.com>
In-Reply-To: <20261118152945.1404317-1-david.marchand@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 19 Nov 2026 14:11:54 +0100
X-Gm-Features: AclHuK9F53_JbTNgFSegllPMoBlg21vBa12Q4sr4vget0R0kAkfeOlAh6NMP0bk
Message-ID: <CAO55csyAJqhU2SRsfXqo==TjVUX-nHR4Z5bKgu8RXf93ErJ=3Q@mail.gmail.com>
Subject: Re: [PATCH] eal/linux: revert eventfd leak fix for MSI-X
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, iboukris@gmail.com, thomas@monjalon.net, 
 Harman Kalra <hkalra@marvell.com>, Anatoly Burakov <anatoly.burakov@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 28WPQwjiYaUQkAVQypm3X2akg0L4r1Y-Qi-9pM6ftvA_1795093927
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Nov 18, 2026 at 4:30=E2=80=AFPM David Marchand
<david.marchand@redhat.com> wrote:
>
> The event FDs leak fix looks correct on the principle but it seems it
> was too soon to take it, as it broke net/virtio and may have broken
> other drivers.
>
> Revert this fix until we get a proper fix and acknowledgement that
> other drivers are fine with the change.
>
> Fixes: 3ba6b689893f ("eal/linux: fix eventfd leaks when enabling interrup=
ts")
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  lib/eal/linux/eal_interrupts.c | 46 +++++++++-------------------------
>  1 file changed, 12 insertions(+), 34 deletions(-)
>

Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

