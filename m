Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859FD606A320
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Nov 2026 18:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jAlo6cgz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8DAE402CC;
	Sun, 22 Nov 2026 19:04:01 +0100 (CET)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTPS id 00E67402B9
 for <dev@dpdk.org>; Sun, 22 Nov 2026 19:04:00 +0100 (CET)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-cde1479f76fso1586785a12.0
 for <dev@dpdk.org>; Sun, 22 Nov 2026 10:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795370639;
 x=1795975439; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dGOt4GFQEcxne5vqNzJa5GQPDtS+qM21tFv3RPb/Y30=;
 b=jAlo6cgzlmowz2bZMjzg9azgqFytuUQmaoo6jAnxPmi0S/vNDR7ds6t8EPmhwZXi+L
 kWXHX7zgnSW1qdM5bmrUVyNtpFZ5PFMUQYaqnZX0aPXTuNvkPUwCpCe5vPlAzylkeNSu
 XaBm3UXL7IeDmssHB0HuR/Yt74TSDEXJHJlYy2COMdQcPBl/3eD/rdIoYh+S7NjGBhZ8
 Gc2OlEvIEJQBDMCKpUnZHhWTkRm9Kt0GVQReFpIfaVPfNp2TvPthHalbGlMdFCfTxDWM
 RagLBUVjQDkTup81fJZq7m5SywlM1CZXxBnGd2gIUAg2ooFGNgJvpPqyFQTMZt+SqJ2g
 5OIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795370639; x=1795975439;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dGOt4GFQEcxne5vqNzJa5GQPDtS+qM21tFv3RPb/Y30=;
 b=uYIxWAFTj5Z8vCXZzBXr94ic5pGWv6kAbT58KpFHyssOYJZUdpFODzu2nhMu20LoCz
 yrWB1c51yj4yVKaISMB2az6ASsgP/0+gmvP/Dpq9zIRUC0/FEoxlfq3laIyJcsvHOWEh
 9FNSb6206sWeUp6OhCvDwhHjZSDbO+Pln9vTK/uN2rzxYFfNYNujIUgnc66GvSscXGn5
 Xm2sr62r1BS3Vyfr3DSRlLMAGnxOvKrLYvVk91n0FwxCg4TtoZ4k0827/uhcbkUJ0qLh
 yt3Sd4NvGMw8TC+s/QPWNnpt0NWOiQWwtNUXHAkg8W2C/kMXZ2VAfgoYUyyiiNxy1+Mh
 8OWw==
X-Gm-Message-State: APuU4Z80+3jpb47yeI1JgAWYDVTvSaZn5fOFREUbVvfcd2pceELyPtTY
 /5Es+sKuUaueqjccGiPYhRa3cCx+nNkuqCgNRpM7iFJAuN9d8f1cZBbtWmOnQ1cWGnxEGec7fCa
 8Ew3VM+k=
X-Gm-Gg: AZFdTZdWMeMA2RxfQ1K5zJdDajtYsOrNK8p/HXbCfeu4p0hNK5x8phiLM+tD8pKEpom
 4rv7AEYvJahdLMhtFM11aPUp/JjC3DM3IlL6FzQbbqs4TRuBPNW17k/xwaLnj3vUjwTrKdybK4s
 U2rEe/iU8roRxAzNIApjzO32oH6djht2L3eW3L2ZJjqvRcUwAvg8xRrhMlVeJsBnjkr9w00jNGk
 qyMSebqa+aNGE9ojpsxJR86F10mjAaS0lsVkiq5e5jOMC2ew81klEiUjTp3nztw1w43KOaR71aI
 93cOaiT/7zfCCjHTQc/nf+R8FnF5SQZLowHn9mLLC9xsmR0Wsb2eB8Wrqr/7a6y2SivwhVAbpuB
 mWhBidzuOPHsH2VMyNMBlvHN/8072LQKQFJzqIp5mT7/limlXVo95F2BmLAg/P/kt5Qk9V1fUSm
 pvUXHy523waKir3ChQ0u0mUkth1jYIKWyNGXo8chPTZg6/zt6FF+lzfOCQH4EOWRabM3V1U1yfV
 NRTwcb/1HnYyZAW9T9zHA6slPZ2X4DY68uZ0pBvZjuok/OSYVZcel3tUcGI7yIsbhMX6nRfRI/A
 k85x1t0xSvQfG+amLSyUdIMuwL6mFlDmGBmGmdfvSCBIcWcirmHTCFVNwxtWic0K4Un8eCY=
X-Received: by 2002:a05:6a20:9183:b0:3e2:2021:89c with SMTP id
 adf61e73a8af0-40148dca737mr10609482637.5.1795370639360; 
 Sun, 22 Nov 2026 10:03:59 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c872e4aca2sm4096751b3a.32.2026.11.22.10.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 10:03:59 -0800 (PST)
Date: Sun, 22 Nov 2026 10:03:57 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiacheng Ye <yejiacheng4@h-partners.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>, Thomas Monjalon
 <thomas@monjalon.net>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH v8 08/28] net/hinic3: fix per-queue start/stop on
 non-HTN devices
Message-ID: <20261122100357.5861f6ff@phoenix.local>
In-Reply-To: <20261120163454.1159-9-yejiacheng4@h-partners.com>
References: <20261117155711.1048-1-yejiacheng4@h-partners.com>
 <20261120163454.1159-1-yejiacheng4@h-partners.com>
 <20261120163454.1159-9-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 21 Nov 2026 00:34:33 +0800
Jiacheng Ye <yejiacheng4@h-partners.com> wrote:

> On a device without HTN FDIR, rx_queue_start() and rx_queue_stop() return
> -EINVAL whenever the queue has no TCAM rule:
> hinic3_enable_rxq_fdir_filter() reports -EINVAL in that case and both
> callers treat it as fatal. Such a queue has nothing to update, so return
> success.
> 
> hinic3_start_rq() gates the RQ enable command on NIC_F_FDIR, but the
> intended flag is NIC_F_HTN_FDIR, as the stop path already uses. Fix the
> check so an STN device is not sent a command it rejects.
> 
> Fixes: b247199927a1 ("net/hinic3: fix return value of FDIR enabling")
> Fixes: b20dc78b286a ("net/hinic3: support Compact CQE in Rx")
> Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
> ---

Should any of these be backported to stable (ie 26.11)?
