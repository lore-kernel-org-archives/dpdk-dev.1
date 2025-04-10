Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A12BC369A2
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 15:37:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D4A44067C;
	Thu, 10 Apr 2025 17:37:25 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 09E78402ED
 for <dev@dpdk.org>; Thu, 10 Apr 2025 17:37:24 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2255003f4c6so11626385ad.0
 for <dev@dpdk.org>; Thu, 10 Apr 2025 08:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744299443;
 x=1744904243; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nrbm+C6JiTEr7EUFwwv3ZGjKOrRVwCIVAfhIKZEDgPc=;
 b=ffvYlNYxpvMQCWLwdFktQ0PijhRcDPvoF0+VflaKSLsXHFsb6BTT2ujJxqRwIP/IkK
 POAwlTWgBRPU7Z2t0vPLxO4Jijqq2hG4541vc/nzjqLU9xMefqBcxHgP0wcyd2W6y/ed
 p9raH/FtVrJwVcnX0QOWY/OEmG54vaXNeCe9nTqS3akTBV8ObRGweKOerPWJZBnETUju
 sxgfHLoFlYBBgcRr9d/+uroxN0f1ksrXpAX2gO14YbGwwbiNdCZoyWSz1aT1dUDhX2xq
 DkgIsR1PIDwDphXwRAtc6156mYcc/Xf8hPenvYAVMeLO6YyMoaHVUZsnjrZ4rxOfW6AI
 0eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744299443; x=1744904243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nrbm+C6JiTEr7EUFwwv3ZGjKOrRVwCIVAfhIKZEDgPc=;
 b=EUlZWnzSJmBgdXWY2ELj8EFc15IqnDvqF7ZUfgxhzbIZa8TX22peGW7PMy0xW/HXCN
 XZlT2Y7nDhPefBjzEphyNfAh36sQxTpHMO5G5h6EvKYiY9NJlKfEBUCbOKmyPKA42mZm
 /wwauZiZZlBx3CnJ7l15eJVlE0pOTBozODYQIX5zGwhNrBscNhqrK07wY4NQ0xkNDlX9
 rI1DWo0M3cJavDlGebkT0DUYZXKH84Dw+94iwQEsDxcEjd81spknNtwhRA14kVfqsTMz
 nG9lPbSkRA4Z1MzEvDTl8m0s2jFOTsQPprRt18OinxA5ji9aCzKDshjcNt7jvlw4LxsN
 9RcA==
X-Gm-Message-State: AOJu0YzM3SOJc5F11D5q8TwVCvUZqWL96Yvssq/GHL4KUa97I4kp8D+9
 yp1tHaoMTy/9uHv4/j7S0RoCnb5qo8LWTfspjuBB8QnstmzHrArgjqDiTU2vB+Y=
X-Gm-Gg: ASbGncvJaemKLguEn1+lBGSiJUjeHCoyOhKVlAHAtjviciE5g+gdGbakxaEXEU9k2tR
 Rzo5j+0C2XDwfeLuM64rS6024IWvtUP/xZlXbUePx1fYZCzXKKvM3j1Pfj1OcWEO0g+KlfyIiu1
 QyNYwy59N9nSicEQ36STZZj1Cg6z0U9F8Ki0c13x8a0KjZHpNMCREsRYDEXd5kDxVPsfvMwn0c5
 u3c11ienjN3VcJ9rZ2/LDNJiKzyMq95DDAmOvyf090NuY+nQFVxPJl281/6BLfmf/4tUg/8ARMM
 GWYSDkIFFIfvXxllVeFL1uUHUmyIJACZ2eAhQsuAqgdZ6dixdNRp/gbpi9RkAEH6tApzFnUJIb6
 ICKohT8jMBXMG1YEZ
X-Google-Smtp-Source: AGHT+IFivSy2Ksn9eBApUt8fj9OoioeNUaqypWwhgkNJ4dppHQGSumgKgRVkRzWgEKpz7NEtGJ84PA==
X-Received: by 2002:a17:902:f684:b0:221:78a1:27fb with SMTP id
 d9443c01a7336-22b2edaf06bmr49165025ad.11.1744299443167; 
 Thu, 10 Apr 2025 08:37:23 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c97207sm31945895ad.129.2025.04.10.08.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 08:37:22 -0700 (PDT)
Date: Thu, 10 Apr 2025 08:37:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 00/10] centralise base code handling for drivers
Message-ID: <20250410083720.07b762f5@hermes.local>
In-Reply-To: <20250331161000.9886-1-bruce.richardson@intel.com>
References: <20250331161000.9886-1-bruce.richardson@intel.com>
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

On Mon, 31 Mar 2025 17:09:49 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> Many DPDK drivers use the same pattern for base code handling, having
> a meson.build file in the base code directory which optionally defines
> some custom cflags for the base code build, then builds the code as a
> static library and extracts the objects from it. (The reason behind this
> is that, in meson, cflags apply per-object, so we need to have a
> separate build object for the base code to use custom flags)
> 
> This patchset deduplicates this logic by putting it into the
> drivers/meson.build file, and allowing individual drivers to then just
> specify values for "base_sources" and "base_cflags".
> 
> Depends-on: Series-34946 ("net/intel: clean up base code build")
> 
> Bruce Richardson (10):
>   build: add generic support for base code in drivers
>   common/sfc_efx: use common base code build handling
>   net/hinic: use common base code build handling
>   net/intel: use common base code build handling
>   net/ngbe: use common base code build handling
>   net/octeontx: use common base code build handling
>   net/qede: use common base code build handling
>   net/thunderx: use common base code build handling
>   net/txgbe: use common base code build handling
>   raw/ifpga: use common base code build handling
> 
>  drivers/common/sfc_efx/base/meson.build | 18 +++---------------
>  drivers/common/sfc_efx/meson.build      |  3 ---
>  drivers/meson.build                     | 20 ++++++++++++++++++++
>  drivers/net/hinic/base/meson.build      | 16 +++++-----------
>  drivers/net/hinic/meson.build           |  1 -
>  drivers/net/intel/e1000/meson.build     |  3 ---
>  drivers/net/intel/fm10k/meson.build     |  3 ---
>  drivers/net/intel/i40e/meson.build      |  2 --
>  drivers/net/intel/iavf/meson.build      |  1 -
>  drivers/net/intel/ice/base/meson.build  | 22 +++++++---------------
>  drivers/net/intel/ice/meson.build       |  2 --
>  drivers/net/intel/idpf/meson.build      |  1 -
>  drivers/net/intel/ixgbe/meson.build     |  3 ---
>  drivers/net/ngbe/base/meson.build       | 12 ++----------
>  drivers/net/ngbe/meson.build            |  3 ---
>  drivers/net/octeontx/base/meson.build   | 19 +------------------
>  drivers/net/octeontx/meson.build        |  3 ---
>  drivers/net/qede/base/meson.build       | 17 +++++------------
>  drivers/net/qede/meson.build            |  1 -
>  drivers/net/thunderx/base/meson.build   | 10 +---------
>  drivers/net/thunderx/meson.build        |  3 ---
>  drivers/net/txgbe/base/meson.build      | 18 ++----------------
>  drivers/net/txgbe/meson.build           |  3 ---
>  drivers/raw/ifpga/base/meson.build      | 21 ++-------------------
>  drivers/raw/ifpga/meson.build           | 15 ++++++++++++---
>  25 files changed, 60 insertions(+), 160 deletions(-)


Looks ok to me. Since depends on the Intel part, lets take this through next-intel tree.

Series-Acked-by: Stephen Hemminger <stephen@networkplumber.org>
