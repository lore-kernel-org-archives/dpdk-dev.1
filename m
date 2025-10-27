Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D18CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 16:51:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A7964028C;
	Mon, 27 Oct 2025 17:51:13 +0100 (CET)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 63C804021E
 for <dev@dpdk.org>; Mon, 27 Oct 2025 17:51:12 +0100 (CET)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-7a28c7e3577so2421354b3a.1
 for <dev@dpdk.org>; Mon, 27 Oct 2025 09:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761583871;
 x=1762188671; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3a+TcLlA9KLPx/KXuD2v7/r92Nu37iqkajyp4En15+E=;
 b=HFiheDjDYCF9YcPke/NdtweZSlH2KDUZkwN/j9/XvA/GYmbxl8+ofrgg7iuh5rQ9fE
 xiN2BCYiwi8oAr2ocZtrrVXRQt4ddxB5fHVL2UIS7VsbC3tbAXjfy1rjEUffkUqgX++u
 p9E+AobTKri62kp762JD5+xGIqmJVSjZ/rqff7/OryOJPuLiVrEsOiKB9uBMM6OPpElD
 1rzPXVuHRwMfXMyc2uvy0el3jeoll+DuIo1RccIDCeXT76xARVoGlLhOcQzMlGS0WGTI
 hlMoIJIdx/rU5Iz26mHN8RVQrUrO/khe4Wz36MYS/RsePd+aXnpJKNUAG1TZzHg5uRIi
 01eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761583871; x=1762188671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3a+TcLlA9KLPx/KXuD2v7/r92Nu37iqkajyp4En15+E=;
 b=YJToi6QAX2V1UPjm7QAXzcPPpsRso1pMUr8zxdfc3brEv0SBKQod2B9owPX7wr2fWR
 HlLXe0mZvkVwsLwfg7iLWeUCG4+ndusLxiv0Mjlv8DL+v+fZ1lomIYhhFb1TRu56zXQO
 dYtV51IRH+OiSlsWm17zb8IVzkirIWsVsF8dDiiprd00BAEA6cREcKN02Mb/PAxZz7si
 0rYeD7YpPNpadkc3TRG48lZ84TyfFptgi/XS44ViEYKe7R7+UxYDNRK7X6cAOwmUbo0R
 1zdPwL0uKk3DDv6B8t+nuQjTJQHg7o9CKubm1mWj3tHX/G9cBryr5sy8VZGnU6j6Gm7c
 2GCg==
X-Gm-Message-State: AOJu0YxoMQp6IBNwdb1CatuqCU39/CIrazYnuBbyUdarrtcjE1qMpnp4
 nT8juPPF8c7uc5zl6LS0XIdan1qwEabIO8HZVTEF8n2ILgVa9BZQFag/G96hIWxXeOCHyGpc5Jk
 SpJ+c2OA=
X-Gm-Gg: ASbGncuBY8qqoueAhyoNTMDmIrhTDiS/31DxhgA800socWQ5Nur/WAKhH/ZeWcIR5fN
 vxxKhdAVnc06RusQkaBWzIxDM90slcKiGx3XURZcSiOdBGTp/91CKD73vKoTIh3zVY/SkhushGr
 VLMzkzuSEyUqG168J7lLznyn19emL+DO2umrnMxhOumM4T3OeCaxsKjvZPVGzJ7uIWdxzZ0hY/X
 Wnq4iOBKmcvsOLDKdC+fpUbT2INgn2QzEUnrAGHJtXD8Mp+TbRsUWMFwRMOkzzhT1mLgdIsz7pK
 6lUFXXq9iQkKkTg5jgL0x/EKrAcdm+588KRnGIjSmylLwFQ0tWuCH6DISdZaP8rLkC8hl/9iqFa
 Ow1W43QAbZ3CWiMdvbzFBgDAnkHBA3c371v2tpq7EFVzvmI8gKswjY13ToU6oxiq0juPoJz6VCF
 7XRvG0rDhcwvOHeXZw9OHkXQ1V2NJfabvncF+zrazSIqj8
X-Google-Smtp-Source: AGHT+IE0h4jLFmzWSWZlhI20a0ABYWJE2i7bb3OGm9I5VCD1X5lqapR85cSXpIC6nXTKOxyBtFK2rg==
X-Received: by 2002:a05:6a20:6a08:b0:306:2a14:d0d4 with SMTP id
 adf61e73a8af0-344d441f94dmr353742637.43.1761583871244; 
 Mon, 27 Oct 2025 09:51:11 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33fed7d27b2sm9137871a91.4.2025.10.27.09.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 09:51:11 -0700 (PDT)
Date: Mon, 27 Oct 2025 09:51:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: dev@dpdk.org, zaiyuwang@trustnetic.com
Subject: Re: [PATCH 00/19] Wangxun Fixes
Message-ID: <20251027095109.3740e7f5@phoenix>
In-Reply-To: <20251027031542.10512-1-jiawenwu@trustnetic.com>
References: <20251027031542.10512-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 27 Oct 2025 11:15:23 +0800
Jiawen Wu <jiawenwu@trustnetic.com> wrote:

> Fix some usage issues.
> 
> Jiawen Wu (19):
>   net/txgbe: fix hardware statistic rx_l3_l4_xsum_error
>   net/ngbe: fix hardware statistic rx_l3_l4_xsum_error
>   net/txgbe: reduce memory size of ring descriptors
>   net/ngbe: reduce memory size of ring descriptors
>   net/txgbe: fix VF Rx buffer size in config register
>   net/ngbe: fix VF Rx buffer size in config register
>   net/txgbe: remove duplicate txq assignment
>   net/txgbe: add device arguments for FDIR
>   net/txgbe: fix the maxinum number of FDIR filter
>   net/txgbe: fix FDIR mode is not be cleared
>   net/txgbe: fix FDIR drop action for L4 match packets
>   net/txgbe: fix to create FDIR filter for tunnel SCTP packet
>   net/txgbe: filter FDIR match flex bytes for tunnel packets
>   net/txgbe: fix FDIR rule raw relative for L3 packets
>   net/txgbe: fix FDIR input mask
>   net/txgbe: switch to use FDIR when ntuple filter is full
>   net/txgbe: fix VF-PF message for ntuple flow filter
>   net/txgbe: switch to use FDIR on VF
>   net/txgbe: remove unsupported flow action mark

Queued to next-net
