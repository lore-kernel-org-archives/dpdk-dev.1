Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BEED31A0E
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 06:27:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFF6840662;
	Wed, 14 Jan 2026 07:27:49 +0100 (CET)
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67]) by mails.dpdk.org (Postfix) with ESMTP id 71F1E4028F
 for <dev@dpdk.org>; Wed, 14 Jan 2026 07:27:48 +0100 (CET)
Received: by mail-wr1-f67.google.com with SMTP id
 ffacd0b85a97d-43246af170aso272556f8f.0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 22:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768372068;
 x=1768976868; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DCvsLL1HsFWABjLuKbTjeKfEkNLzvNDE2LFvQcXGiwE=;
 b=t96j7m8I7dRC4e7PGd+MZaBy0rOCGyA2e69NKtghIXukMRtjQo3rixTObrQoIy40rp
 uAI1eYsnB7SMQ9wpiZuobV/l9mEPz5zUTEgpEyLV7Qrff7LhU+R2XoD6kQd8KRxlwZwr
 +rIedUi0zGkGLn7mJ/Sr0JyiCrCBdV5d7w2dcC1fE1zx3LjSEpYwJeGiV2FpRUnrua9e
 ZSrZgAs+jCjqbeD+bxjH/HaRrNCntzOyOdkAK0ztC6U1jb9rCJMnwpUz+ph25Cc1Jy9E
 qkEOnlFqIVYmfo/Y5EHHN/Nbuc4+XAcCqu3UZ2cFE+khypccdo+19FlDiURow5Uwktxr
 lMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768372068; x=1768976868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DCvsLL1HsFWABjLuKbTjeKfEkNLzvNDE2LFvQcXGiwE=;
 b=lNa4olpGWvO8iEU66QbSLuzbZrr3dxFNpvRrbsDTpEF/SjOJsuP7DggmneUTFJYl92
 5lmixeMOzR5MulCk1uOs0KFfRf/PQWPaXSQwp3g6As9ysbb1cr+9aKwuTKBw+4CUNJke
 qNvaeAFCHUSaZNQqFtjLgflEFzGkI/+q7ZsXBcfX6fGHRPc8UKNDxv3GG0J3KhtBQfzA
 cvBl1HjvpPRs5CzqFJQhyZzvodRCOQVOuzx+2ZDNCCpj4tmqkAW8voY4ZKUm479OuPGl
 R8RkroQiSKaLpRpQ4SWX68doJxR6nZl2kZ3Bb3RziWWpT1SGhrjSPSa4HXlQsQ6QrgB0
 oPyA==
X-Gm-Message-State: AOJu0Yy6LOW1LLZT+IrsnbPLFvxHegVXoEPWQHp621SVuy2P4ApYzcyI
 QO45rpIAMSgZ/2HFpS+n2tHqMdR2mMef3w4Xdj0QukWIGaI8v5GFCdtIot4ekmhWoXU=
X-Gm-Gg: AY/fxX6JeWMK1/BU3PKsXAheBSKJLQfwBpegKTxY2/KfcWOT5OHUyE54HhZDJ1M8rcx
 5x0P+6p1dSdcAPfwQtx5+mKPGN20hsNiGJkLLWONcou6cOm8S10jBkZEC2YIK5bByCkpgYtc/sB
 jYN1hbZzBt25YZm6d8aYk21eQVc8qHIibFQm9hCbQBGUcCF4YOkX0AaEuVK02lg0kGFjIvhsmoL
 LwxDcSYuiplQ8NYhxjDuJVISq/UpptC3zPU/+RidtE9P9Wc38se7N7+tCM0sHF2qI+p0gR6/zAD
 FSdBCQ9y16mcBeC7XIVN5Adq6GXJ7xsnqVa+78ttF2JpeR4UNLAcwlz28kwcLULaNkIo9PV0jtF
 CL+fmwuPutVxoRhm7TThFBAjTbsNfYBmxDS1h08lxVi4OmKcsbyqA3MMYr4yDVCC4LlRGvZiuj0
 T/02Tbfj9DRtE9N1iA8MbMYAlHo2E2GaaZqvNtOlMPuWPyRr2yHnqB
X-Received: by 2002:a05:6000:1a8a:b0:430:fdc8:8bd6 with SMTP id
 ffacd0b85a97d-4342c0ff57cmr1832630f8f.31.1768372067930; 
 Tue, 13 Jan 2026 22:27:47 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dacdcsm47613270f8f.1.2026.01.13.22.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 22:27:47 -0800 (PST)
Date: Tue, 13 Jan 2026 22:27:42 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zhichao Zeng <zhichaox.zeng@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Shahaf Shuler <shahafs@nvidia.com>
Subject: Re: [PATCH] examples/ip_reassembly: remove conflicting Tx offload
Message-ID: <20260113222742.0e17c7c4@phoenix.local>
In-Reply-To: <20250919071213.818567-1-zhichaox.zeng@intel.com>
References: <20250919071213.818567-1-zhichaox.zeng@intel.com>
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

On Fri, 19 Sep 2025 15:12:13 +0800
Zhichao Zeng <zhichaox.zeng@intel.com> wrote:

> IP packet reassembly requires the MULTI_SEGS offload to be enabled in order
> to handle fragmented packets across multiple memory segments. However, the
> MBUF_FAST_FREE offload conflicts with MULTI_SEGS and cannot be enabled
> simultaneously.
> 
> Remove the MBUF_FAST_FREE offload to avoid conflicts with MULTI_SEGS.
> 
> Fixes: 9df56e69ee3f ("examples/ip_reassembly: convert to new ethdev offloads API")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Zhichao Zeng <zhichaox.zeng@intel.com>
>

Later Tech Board discussion concluded that fast free and multi segs are not
conflicting flags. Dropping this patch.
