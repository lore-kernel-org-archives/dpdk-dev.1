Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0407EC5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:20:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3882240687;
	Tue, 18 Aug 2026 15:20:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2183E40294
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:20:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787059204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mv4P45qIrPIBkVnR4ZosGE3au+IEUbIgNul4RhHp4Uc=;
 b=FpfucZ7uvFyV+4SAqZ+GcU/ZUHKa3UX2LP7I2qd1Nwrn933xFm0P18Nng4tL997Juo+42k
 zR31BaMv2OQ2eZoSE04FbKpYYbdQpZdsnQwPOZUpb4Hu3kAUcmvSnccj9BiDE/a7AV0CL9
 U+CYOuTdPLs+3NgfstQ0mrk1qOle21U=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-Ofe1LZlnNi6oJtB0CD81ng-1; Tue, 18 Aug 2026 09:19:58 -0400
X-MC-Unique: Ofe1LZlnNi6oJtB0CD81ng-1
X-Mimecast-MFC-AGG-ID: Ofe1LZlnNi6oJtB0CD81ng_1787059197
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38dde0df80bso8074875a91.3
 for <dev@dpdk.org>; Tue, 18 Aug 2026 06:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787059197; x=1787663997;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mv4P45qIrPIBkVnR4ZosGE3au+IEUbIgNul4RhHp4Uc=;
 b=qKhrDpVfId/yg9EgnRFfJ90hFMapp5/ptod50n2U8rXuRD885Dp/0X62yQNJCOGQTu
 rXNcP9br8/xjCke7sfhGumiAkT2qoIfF5n3OyFbNsIlRTRLyw0/EEnYY4P3G9YgWaR0+
 Pd9hqGsOohBuNCvx0XrSpIhCG3AwNERftxpkozudyWlcAxtDc+nvYC7ENSXSlXvSW/jU
 Cn2x0JcJ3LvTGtp4tzuMlGqy2RqMGtuPaxWP4biV7oaLTVU8n+V3T3Hsktd/IXLUG/I5
 K4Kv+xNwqn3ltAfWoN526S17ndYI/fEsgNqBOKPYxblaX2FgrH+MVWfkG4xfoxqMV3KO
 vnmQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpI/AiBrCIGZA4COeuOzUDpcfClXEVq/5ZA2z7zL0lFDtakeEuXccBmSZzbikBtC4jnIBA=@dpdk.org
X-Gm-Message-State: AOJu0YxumDuFnH4HX0naVq1KlRVAa2NILHWUMUXWPzPRPaXmsIUCmvjs
 hdNX/3jq0hVkAsjkZUvw54fPGmx+6UnaIDcgopWd9BWwYBqh4/q8b4aHpNPyj9IXtlQSDyKgecZ
 d90UFuwGiebANt7RQJNUOiNcVOxFUbAwQ5YHVj/aMJjc+HIbYRfs7rrga+ndoXhw6rcQH/0jOFT
 iULIxIUTTOuRJh9PPUU+0=
X-Gm-Gg: AR+sD12RMdWmhzfbdUO9Iday8rL9fTJbgA9fJIu61UFfQK3mcPhruYZzgRC5jNtNKE+
 FOguzt0ZArXq26R/4P8nbc3Fh8eJTrPhN975iEa5MWMhphEgu4UINHkPIeWPClu/ToZe1Cvca6d
 k+1t30VgMXYYItACxo4xfkXw1YjRXHaJRxhv26dVtu75iTZfXSBVOeon3uy0vYtglq3sZSmECTI
 WEJLuQPU2x7XVf9qNC+7DwOhjeImnbk640v3mHWzxaxHVZdeqFEKBn8VCrua1bTvjhAqkumyM0R
 Wyi+hLS3GL1Ad0wSgHlUb+cDF2hsD7cG9IHp+3zFFY8=
X-Received: by 2002:a17:90b:3809:b0:38d:fda6:4873 with SMTP id
 98e67ed59e1d1-3955a79c068mr9534375a91.10.1787059197221; 
 Tue, 18 Aug 2026 06:19:57 -0700 (PDT)
X-Received: by 2002:a17:90b:3809:b0:38d:fda6:4873 with SMTP id
 98e67ed59e1d1-3955a79c068mr9534327a91.10.1787059196724; Tue, 18 Aug 2026
 06:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260726170258.8791-1-wpan3636@gmail.com>
In-Reply-To: <20260726170258.8791-1-wpan3636@gmail.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Tue, 18 Aug 2026 15:19:44 +0200
X-Gm-Features: AcwNN1Vu86-2M_EiZ4SOe38BqksjPDr3t7-xV8lN5-RZq2xLjTpHBvFLLN2c3Hw
Message-ID: <CAO55cswY7NzdOkeCgPCVsRsnaFO8HCaZe8ryidWeY+0QQ3wn9A@mail.gmail.com>
Subject: Re: [PATCH] net/vhost: preserve Tx ownership on VLAN failure
To: Weijun Pan <wpan3636@gmail.com>
Cc: Chenbo Xia <chenbox@nvidia.com>, Jan Blunck <jblunck@infradead.org>,
 dev@dpdk.org, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9cFUkzd17sUqECJW9q-5Vgzn-oJdlM4FyvauAr8ugZk_1787059197
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

On Sun, Jul 26, 2026 at 7:03=E2=80=AFPM Weijun Pan <wpan3636@gmail.com> wro=
te:
>
> The Tx path compacts the input mbuf array after software VLAN
> insertion fails. Later packets are moved into the failed packet's
> slot while the failed mbuf is freed.
>
> The returned count then no longer identifies a prefix of the original
> burst. An application freeing the unsent suffix can therefore free
> duplicate or stale mbuf pointers.
>
> Stop preprocessing at the first VLAN insertion failure and leave the
> failed mbuf and the remaining suffix owned by the caller. Count only
> packets prepared for vhost enqueue but not accepted as missed.
>
> Bugzilla ID: 1884
> Fixes: f63d356ee993 ("net/vhost: insert/strip VLAN header in software")
> Cc: stable@dpdk.org
>
> Signed-off-by: Weijun Pan <wpan3636@gmail.com>
> ---
> Cc: Jan Blunck <jblunck@infradead.org>
>
> Tested:
> - Full x86_64 debug build with AddressSanitizer.
> - Two-process net_vhost and virtio-user data-path test.
> - Forced VLAN insertion failure on packet 1 by removing its headroom.
> - rte_eth_tx_burst() returned 1 and preserved the unsent suffix.
> - testpmd received 1 packet with no RX errors or missed packets.
>
>  drivers/net/vhost/rte_eth_vhost.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

