Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7E4ECD6F7
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 00:23:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DCEF4042E;
	Thu, 12 Feb 2026 01:23:51 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id CF1A940268
 for <dev@dpdk.org>; Thu, 12 Feb 2026 01:23:49 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4805ef35864so62673395e9.0
 for <dev@dpdk.org>; Wed, 11 Feb 2026 16:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770855829;
 x=1771460629; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D76xYb8QJPwcYnp3laUtuGqbrij6vpT3oSP6U6dzf+0=;
 b=cgXWGMR/kyE6c0NTgybKE8IHHJ17hYdSvmslsWJAOIjW+T+8MR5v7i38Wz+6SPQf33
 vHUtOeKaU3TJVVTUGJxKQOH2akyCEGlV3wb+MzWrZX9ZbPPSyp5+bMCu6Fq5mnoaNMk7
 S2HuXRjW9oB2gSyg3flbYLfJP+O68P6EOpcGC613VoJbfhoHyJHogoMgeYxpDdsf2DMf
 XCrBDyx0U0sHxL0j+49IuKnJXZ5UnzbMUWABiRX7HYYwJ54QA+RpX7k2FncRIVAudc1c
 V9ogCulo9f78misdHGk8fEnKAKikgLtKTvIJ+iJ93Yx0uwt33+OnqKLnYCwDg4yoqbJ4
 +NjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770855829; x=1771460629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D76xYb8QJPwcYnp3laUtuGqbrij6vpT3oSP6U6dzf+0=;
 b=Uz2vxzvLmI5RBATs2B/Sw29t0hW7yJ0nbXA4cuwvIvktE9Q+swiXUNp48vLCu690pQ
 XkISGehpNiLgDp2xu0xAp7M3EaZtkIquK5c6hv/HObQX3jgjuaQz0XT29c0SP/B2tR46
 67DtVsvOFscVE5Mc6NevVfCuKtPkrKRHyw7MXj4aqC1if43CCKH1gruV26fxbo34tzE0
 0OIFWlFsBPFC9IvZXIkOM7yTBj0fPw0gG9H91kjWs4YumNmZBKEud3k/Apg1QkgVeIL8
 hud49d7X4TWvOXoZ+yQL4X0WHLh0axOuGFj89WI8KkJn5KIX2JrIaWqrF/uXEg2Rpp2+
 pr9w==
X-Gm-Message-State: AOJu0Yx4bmX5PZqdMr+xnFWUeu0hGNeXfMGd4Jh7bwHLrs259Lo6JCtz
 gxerVnFqqNNgSE1kyK1n437JZ9kO5AX/Tc6sM3zNZhnOgt3Nxvi3g0R/cazeAcx2+vcMRvVDXMf
 hfijF
X-Gm-Gg: AZuq6aKquoWgj4oz73zdGBYItCxxonSI8Q5xYkN0cqhwLUyHCw9dTxTWBDQCvTxYmWH
 /ANyovnL+AEMY8BixYl1Gzvbah/ch9s4ggBD5mW4y7Nd3kPGxpRv2w5luN5A+hHD180pCD2wGrU
 D3Ns9rIFwsAOsCi2g8iUpRmHGp9Kw3UI0Jg3fvCuwlywDAIzQwKN34FLWbVhMuL4Quf8tLwbJU1
 IOhtrl0IDNJ9g4EdQ4cg8cuIRXA89idfJat1z9uCjisqaGQzFTTViheJAm3YYOCUmwuUrolHW6d
 YxbBoNoNNFn6wYywi1f/68VovtNaDLxc4hJuN5dPqLw9H0xU3iMgjTCxyy+5e2gHD+svmRyyNw9
 zFemD9OUKDqpqG2vPNbE1C5Ljbca42XjdY7f8hhnFWvslD+JLrEaeS2fYbd3mkMbO+TeTTwn5q4
 cDhLqf1fdMkpVqILeW4AdSiaicLQZTeRfoI9ChDx1/CAw89rfhrPUlQdUmAkTN5trX
X-Received: by 2002:a05:600c:4749:b0:47e:e20e:bb9c with SMTP id
 5b1f17b1804b1-483656ae4b0mr12835765e9.8.1770855829438; 
 Wed, 11 Feb 2026 16:23:49 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d989165sm98309365e9.2.2026.02.11.16.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 16:23:49 -0800 (PST)
Date: Wed, 11 Feb 2026 13:43:26 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Howard Wang <howard_wang@realsil.com.cn>
Cc: <dev@dpdk.org>, <pro_nic_dpdk@realtek.com>
Subject: Re: [PATCH v2 02/12] net/r8169: tune RX desc fetch num for 8126 and
 8127
Message-ID: <20260211134326.61146e31@phoenix.local>
In-Reply-To: <20260210055511.62382-3-howard_wang@realsil.com.cn>
References: <20260210055511.62382-1-howard_wang@realsil.com.cn>
 <20260210055511.62382-3-howard_wang@realsil.com.cn>
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

On Tue, 10 Feb 2026 13:55:01 +0800
Howard Wang <howard_wang@realsil.com.cn> wrote:

> For RTL8126: Tune RX descriptor fetch number to 20.
> For RTL8127: Tune RX descriptor fetch number to 12.
> 
> Signed-off-by: Howard Wang <howard_wang@realsil.com.cn>
> ---

It would be good to have some explanations of these.
Are these the defaults in other OS's?

Even better would be to integrate them into the existing DPDK
rte_eth_thresh values that are passed in via rte_eth_rxconf
and returned with rte_eth_dev_info.
