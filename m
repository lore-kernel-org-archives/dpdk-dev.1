Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC91CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Sun, 17 May 2026 23:56:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14304402EA;
	Mon, 18 May 2026 01:56:35 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 4CCD54066E
 for <dev@dpdk.org>; Mon, 18 May 2026 01:56:33 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-3025d725a05so5496950eec.1
 for <dev@dpdk.org>; Sun, 17 May 2026 16:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779062192;
 x=1779666992; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JOa7ycFdst9oz82cYtJjqk6bL73bcsv7Yiwb0MLPV34=;
 b=uaWY16ltebgA5Vm0A2mzg6v85AiNRKY8IG3TFGWmKCYCOHwHQ02wM5zlrjuONoKFq/
 x24Sz9/+1+f48YqPaS5VlUSoRQFaHJRQezBEEX0NPKfG7CqU44FQk5+qcLSOBZzJCg+N
 YpYhwMVKz+MceuCueEZxSEDFRZMH/yrjvvm5+RFaR9+T7jXqw+4eeaOpfLCelLeRetW7
 NP7Mc7jjZMQhhySG/rsXGD1IMOP+J9QnOQZAEn2VlLe4trn4spNqZ7IVf4kDJjp1Nmz4
 cpDIV5vaY3f2q4Mc0ZvaA717jkeru4B0aoIx2/QkNj3KFe6agU+J95Ex+/feVWrbns8T
 AP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779062192; x=1779666992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JOa7ycFdst9oz82cYtJjqk6bL73bcsv7Yiwb0MLPV34=;
 b=e8PsmT9gB5ValaRq/GknpiUQIrNJmPqP706nWsfymsqn25x97wBWvutceife3HUZhY
 MhiV6DcyAvVbKHKY4opUvlOAEir9cQIR9/tlZfAkaV1BWnAMNZ3Jlip8xFEQxl4TzV/1
 Q1AOcUhP7sKaM7xvJSAzbaI/jm+bXlqzyDac7pSEVkfTMBzMNjEwA+b/dMjyh+JZHOVL
 fi5WGGvBoZOQN2YpiR8vGnOGeoHXkZ2zOeKdQDgOW6M95JmW88SzWqNvxToGfrm2CMKL
 T8t2MrQCyl3foIkCJm1oVnNl2rUyDIqvjlnOKb66uHWpz6H6AGEG28LE7w1yKPXD2ZCQ
 n07g==
X-Gm-Message-State: AOJu0YwdJ2ZN7cobQXwArWU7SUrp3l57ha2W5nPb1fQ4XoQwXuh6PTQ6
 Kzrko7JqYvbYAERzdxxXCTcJ0An7X1F34Nen8xkhxadW/m78iVm964kcK62dN32Fm0U=
X-Gm-Gg: Acq92OEDKhD5e7EFFzGXRnxzGIkGDU3vEpBowu5/8D43Rv8rdiJlIq4J5HMaPSrY30V
 5oJwVNjPOi+tbGEjlC508jz/hU+FyuRLxWJ9mFS3U1JorRtEk2gMBcRf1we+0cM+4CPUmC04v49
 u8/U99N9h1cBr7EvZ93RA22+kFs/ZxT4pWd70NuswXgJwA9/OegGBbSVEhC4Y86ZXicQKsEfW2+
 eTX4FiTJ7fcAnQZDTEMpWT1LGfKTHcATyfTBRnqtYJ+3za/b0jCs26qY7YUKNUnLvh2WjCIj4Pl
 pGwAdch62tiO3d17L1shE0/qV9gRNN8R7ZnyI5ihTDRI5gPJw1htUR2myj3C351vO4wpi8dNSyj
 0oHNxRgHEbaBVM57cY5DteJT1900g3Yt1D76pWNC44yhyzZBJkNN+lKjn+t1zf/uAY0Ux6x9xfc
 Zv7NZnZrarOCCVhdhzGL5O0wPPLlkC8inr2CKE7uWYa7I1ag==
X-Received: by 2002:a05:7300:5b88:b0:2d9:b466:5e19 with SMTP id
 5a478bee46e88-303986011c1mr6169673eec.21.1779062192328; 
 Sun, 17 May 2026 16:56:32 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302973bc8ddsm12189379eec.21.2026.05.17.16.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 16:56:32 -0700 (PDT)
Date: Sun, 17 May 2026 16:46:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stable@dpdk.org, Jiawen Wu <jiawenwu@trustnetic.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: Re: [PATCH v4 09/20] net/txgbe: fix link flow control config for
 Sapphire
Message-ID: <20260517164612.4d1c622b@phoenix.local>
In-Reply-To: <20260511103604.19724-10-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-10-zaiyuwang@trustnetic.com>
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

On Mon, 11 May 2026 18:35:51 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> SP chips have a hardware bug preventing XON flow control support,
> so the driver disables it.
> 
> Fixes: 69ce8c8a4ce3 ("net/txgbe: support flow control")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
> ---

Comment vs code mismatch


# Review of Patch 9/20: net/txgbe: fix link flow control config for Sapphire

## Errors

None.

## Warnings

### W1: Conditional logic inverted (line 1042-1043)

The comment states "SP doesn't support xon" but the condition enables XON for `txgbe_mac_aml` and `txgbe_mac_aml40`, which are **not** SP chips based on typical wangxun naming. The logic appears inverted.

**Why this matters**: If SP chips are `txgbe_mac_sp` or similar (not aml/aml40), then XON is being enabled on the wrong hardware, causing the bug the patch claims to fix.

**Suggested fix**: Verify the hardware type constants. If SP chips are a different enum value, the condition should be:
```c
/* SP doesn't support xon */
if (hw->mac.type != txgbe_mac_sp && hw->mac.type != txgbe_mac_sp40)
    fcrtl |= TXGBE_FCWTRLO_XON;
```
Or if the current condition is correct, the comment should read "Only AML supports xon" to match the code.

### W2: Inconsistent capitalization in comment (line 1042)

Comment uses lowercase "xon" while the code uses uppercase `XON` in the macro name `TXGBE_FCWTRLO_XON`.

**Suggested fix**:
```c
/* SP doesn't support XON */
```

## Info

None.

---

**Summary**: The primary concern is the apparent mismatch between the comment and the conditional logic. The patch claims to disable XON for SP chips, but the condition enables it for aml/aml40. This requires verification that either the comment is wrong or the condition should be negated/use different constants.

