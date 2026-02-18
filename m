Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F364E9A02C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 18:21:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6991540269;
	Wed, 18 Feb 2026 19:21:58 +0100 (CET)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 by mails.dpdk.org (Postfix) with ESMTP id 6ED4D4014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 19:21:57 +0100 (CET)
Received: by mail-oi1-f181.google.com with SMTP id
 5614622812f47-46390d4ac7bso68327b6e.0
 for <dev@dpdk.org>; Wed, 18 Feb 2026 10:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771438917;
 x=1772043717; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LsSS7ddMsRs6+uvbGy3Q5uDI168tG6AKq2tjMS6az9E=;
 b=VXMqad9x9KqP0OGib9apJxDJ1ofSN4zjZ4+CtAsAnRBZOruay09D1h4K0hgtOmQVdE
 D0OlDlI9JmiJWaF8sfRuSaglfofl6/w6cZzF6j6BXEr5xEf12ZU3WOJ/N3Z5uQuVM7gf
 GgzqrawxsIlnlG3fGfpXJF5VjasZW4IXv/cvBtDVhGrb29WEUkHvHDUmK2MnZ2ffsiXw
 0jfcGCcpwf5MX1NdO0isuuPF/vbp8RN3n7o2B4VN043wvrSFbi+jE5+/++eYT1bBgQZc
 vWt4aIVxrO24Q1izZe+couu6fW7jzZ+lhyTjK2/ZGb11ES8XFMObih22dQ/wmg8kby/C
 uvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771438917; x=1772043717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LsSS7ddMsRs6+uvbGy3Q5uDI168tG6AKq2tjMS6az9E=;
 b=w0TdcJQj0KOpx6G9bfeNmAAbOPLR3/GeWYC7KY9Z080IzsnqYiEeBivcP44/BuVP8w
 F0iCU0udVVGZOMKjt1zFn6UhiXbmOKlnol5zCeqmzjGY054F4Q18/INcwtl02+f02Yvf
 6KDYmI9Gfkh5KIa68aBkj9zfuWpc3DYteuSlieUku/b6DDVvvPt1yOvlQY0JARyKqpQs
 oR1EKp6HV9kfUpw5fiT7GuwL9jpgjVIxf8UKmkeiocRteNjy6fQ4PVDl3IvDwGe6NzRm
 VYaiWn1ZTvRThZpDqxAPbF1fzrAA9tdDFIm6i/rPGv+gw0uvMZHGz3iiDCJEq98fgnXt
 NEBQ==
X-Gm-Message-State: AOJu0YwmToBB7CsCrzYxDB6D3tOMDoRGeiGRrbZTmb9xJPu0syk5Ykde
 vkNPC/OmrhuyJ1vLmSgYvcC1vc7d3dZRSFrg7TwIv9fkoY3LaJi3CchEEjMmJEc3BIkrhSgQOWu
 8qxj9
X-Gm-Gg: AZuq6aJvGlHSGzKIsZlYZxbH3tCSLUTJWmehe+cGn3rB0T4Ui0FjHj1WDc0fuO65J/k
 uNv2BaCltaa+mdOBG6IIJHCcP9KY1qPjj1Kk/hIHI899nFFfC0KsvSZvAPD3XNAVyQFEOW/i4Lw
 HDjInSUFqZnl0fA+9eKk5DeX+/PMbttAduNwMniEaVh5e9xgqgsyCoXGw2u9slV5wlrZmX4JEm4
 DD7uoJAIJU3uW7x+G0EdTUZNQMLnlmDX7GHmE0JjhttltY0j8uS4I4bu9GNINCtxIyNoP8Bx4Wq
 DCGrg4LZjzmWpDrPWrNXQk2OCjzEolZbI77h6AePedysQVdt7hZRf2V4MfkBD4FrGq1mzPEnoQ4
 sqJuBX8CxiqLCY7F34AkK6yLrUFft0H37bi0GH+UYwRKuM4n+jZ3k697U09y+6g4W8Jg0QyKIuS
 HmnL5dB+HysaNWOJFEMx2KJIts4Qn/q3YWhBI/k4jYF4RVdlCj8TxZdSPnKtcdVmJJ7fvXf5x11
 t4=
X-Received: by 2002:a05:6808:1205:b0:45c:881c:e0c0 with SMTP id
 5614622812f47-46410d006b2mr1426945b6e.47.1771438916659; 
 Wed, 18 Feb 2026 10:21:56 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-463ee1f67f7sm5118953b6e.12.2026.02.18.10.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 10:21:56 -0800 (PST)
Date: Wed, 18 Feb 2026 10:21:53 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/6] net/nfb: ethernet enhancements
Message-ID: <20260218102153.6d45f4e0@phoenix.local>
In-Reply-To: <20260217110324.3344310-1-spinler@cesnet.cz>
References: <20260206170435.302184-1-spinler@cesnet.cz>
 <20260217110324.3344310-1-spinler@cesnet.cz>
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

On Tue, 17 Feb 2026 12:03:18 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
> 
> This set includes minor enhancements to the Ethernet
> configuration and overall usage.
> 
> ---
> Depends-on: series-37385 ("net/nfb: rework to real multiport")
> 
> v2:
> * P2/7: close MDIO handles in error path of nfb_nc_eth_init
> * P2/7: add bounds check for eth_node population
> * P2/7: add check for nfb_mdio_if_read_pma() return value
>         in nfb_mdio_cl45_pma_get_speed_capa()
> * P2/7: add include guard to nfb_mdio.h
> * P3/7: move nfb_eth_dev_set_link() (PMA configuration)
>         before MAC enable/disable call to avoid inconsistency on failure
> * P4/7: add check for nfb_mdio_if_write_pma() return value
> * P5/7: set dev_info->max_mtu
> * P5/7: add frame_len_max_cap to struct pmd_priv; used in MTU configuration
> * P5/7: extract nfb_mac_read_frame_len_max_cap() from nfb_eth_mtu_set()
> * P5/7: check for MTU overflow
> * P6/7: use direct value for stats->ierrors from rx_cntrs
> * P7/7: remove this patch completely and distribute release notes update
>         to matching patches
> 
> Martin Spinler (6):
>   net/nfb: use MAC address assigned to card
>   net/nfb: get correct link speed
>   net/nfb: support real link-up/down config
>   net/nfb: support setting RS-FEC mode
>   net/nfb: support setting Rx MTU
>   net/nfb: read total stats from macs
> 
>  doc/guides/rel_notes/release_26_03.rst |   3 +-
>  drivers/net/nfb/meson.build            |   1 +
>  drivers/net/nfb/nfb.h                  |   8 +
>  drivers/net/nfb/nfb_ethdev.c           | 247 +++++++++++++++++++++----
>  drivers/net/nfb/nfb_mdio.c             |  44 +++++
>  drivers/net/nfb/nfb_mdio.h             |  39 ++++
>  drivers/net/nfb/nfb_stats.c            |  40 ++--
>  7 files changed, 335 insertions(+), 47 deletions(-)
>  create mode 100644 drivers/net/nfb/nfb_mdio.c
>  create mode 100644 drivers/net/nfb/nfb_mdio.h
> 

Queued all these to next-net with small change to avoid overflow when
computing mtu.
