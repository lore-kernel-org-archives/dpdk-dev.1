Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EF5FD3773
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 16:52:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D46114027F;
	Wed, 25 Feb 2026 17:52:56 +0100 (CET)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id F2FF9400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 17:52:55 +0100 (CET)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-127423bea4bso2788593c88.0
 for <dev@dpdk.org>; Wed, 25 Feb 2026 08:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772038375;
 x=1772643175; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D7pgqG5eTqAxImIBcjslfBDu9JXLMjcXIsg6xttTDKI=;
 b=xPeKQfooII/l6LOZDGLlulEKInePXQmjBO7q7RngFRm+4EGkf/GG/By+8R7HHPZiQ+
 2aiVVU4OxCUga312TUQK7wCNHX/j52SmDxVbtxc3NwBri9ja9FBpwIOQ0YaZZDb7rbh6
 vFc6wPSWs18x2LgLZjvlqxwkd0zrgVtE/G/5lT82oNHmlyfcrWFKZNTI7Y1MDAb8Ys9W
 mE6WLRdVsuWVeOcwe8mBMrirqAzXYpylODSRMefBPNVGut9XzZ87QeJC8XUQSO9GNT0p
 QjB5l/pM8zxNoUZ0Zt1NguO+2i4eicgCplb1HHt44y5SSpDe5u6LMoD75M/WxmgmHWVH
 Omow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772038375; x=1772643175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D7pgqG5eTqAxImIBcjslfBDu9JXLMjcXIsg6xttTDKI=;
 b=xPqEkJq+0cfHH7SPihNWUTllKXQA1QUu5AlQHzILtwgvCaZ6YqH0jFaRF0vLfzL0Wx
 RKRZTJdWoqcDvh8fcpnoA4NkZW+qG7n8cJduwOMiKXodJp5v4P9Wuli/ex/xapM2he5g
 9gHxTJC6J9os4wycDfEFPtrrmYSC9jTjt4me/DITLv3dBPuYPPreRd9Zg9Eo2HXnbw9h
 kA+QEmWY/+NloGqhJM/7EUZgcFn2IOYZNqLXS3Aarywo33zKfi8rEeVJBPtROus2ecOd
 YfTIANSD40bkA4mI1xZGYs10uvbRi6pDN3Zej1QDEggtzR5UTkzgw8+S5atC3NAR1dAl
 FlRA==
X-Gm-Message-State: AOJu0YxBw8aMiyuVISi/y/yJfucMPLqI5wpwPN8Nwxzf4YAI8wp2YHML
 R8nj8c4E+wCwirrtZ08IeJX9zW/hb+QGm5beIAIClXJqrvZrldCKNu7ekGQ3GPUU5INHT4JMsw3
 Qg2+LKOw=
X-Gm-Gg: ATEYQzyd5P5HZ36u0HJgdln7Av8lSRp1/ESLLfomFeI0xcQmsbwgRLmWQH1PF9VJ5SK
 p/5lvFzVdQshW9tmodXStRE3INJ630Ds9RKUzfxziWnRYOlDrlBc3/bHfUR2fZafsWdysSfpt9H
 qxpA89WEXlxHb1FMvUcE95aFlwFn9y4Hugp45yJCPSr0sjbF+b24SjZhjOXbC61LjKsbnHTF566
 aCYko+cUhnGkbR8FnkYIT8kHWNwFnIjlY0Nhg4fsLQxKePo6wVBUYK2uida1Zbi7ojlDDSM1smC
 niChDAKm9KOT+PzeYFGoBoAocxWW1X1479Qpprs6ExmpIHHL/h2q81HhjcvdtwV2D8tihWHZ5GP
 E/G5X0jj6JVMUGYQhopUZh2bWSvCnolLyjFQITKw94w+7oKsYIjEnjbgLfaxMBWWfvewCKDyUtV
 olSvyo4k68nK4huQ5hAtDx3Ot35zFs4gi6kSeZeswAlnShhrrmlHlmsfMdjr+/4Q6Q
X-Received: by 2002:a05:7022:4397:b0:123:2c98:f6ac with SMTP id
 a92af1059eb24-1276acb8b30mr7255555c88.12.1772038374662; 
 Wed, 25 Feb 2026 08:52:54 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1276af2ea06sm16320024c88.7.2026.02.25.08.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 08:52:54 -0800 (PST)
Date: Wed, 25 Feb 2026 08:52:51 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Selwin Sebastian <selwin.sebastian@amd.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/4] net/axgbe: fix resource leaks and OOB access
Message-ID: <20260225085251.2bc82809@phoenix.local>
In-Reply-To: <20260218164324.915065-1-stephen@networkplumber.org>
References: <20260218164324.915065-1-stephen@networkplumber.org>
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

On Wed, 18 Feb 2026 08:40:58 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Code review of the axgbe PMD identified several correctness bugs,
> primarily around resource management on error paths in device
> initialization and an out-of-bounds descriptor ring access.
> 
> Patch 1 fixes multiple resource leak paths in eth_axgbe_dev_init():
>   - mac_addrs leaked when hash_mac_addrs allocation fails
>   - hash_mac_addrs leaked when phy_init() fails
>   - rte_intr_callback_register() return value unchecked
>   - DMA reset failure via hw_if.exit() logged but not propagated
> 
> Patch 2 fixes wrapper_rx_desc_init() which only releases the
> current queue on mbuf allocation failure, leaking all mbufs
> from previously initialized queues.
> 
> Patch 3 adds pthread_mutex_destroy() calls in axgbe_dev_close()
> for the four mutexes created during init.
> 
> Patch 4 fixes an out-of-bounds read in both Rx and Tx descriptor
> status functions where desc[idx + offset] can exceed the ring
> size. The offset is now folded into the index before masking.
> 
> 
> Stephen Hemminger (4):
>   net/axgbe: fix resource leaks in device init error paths
>   net/axgbe: fix Rx queue leak on descriptor init failure
>   net/axgbe: destroy mutexes on device close
>   net/axgbe: fix descriptor status out-of-bounds access
> 
>  drivers/net/axgbe/axgbe_dev.c    |  5 ++++-
>  drivers/net/axgbe/axgbe_ethdev.c | 26 ++++++++++++++++++++++++--
>  drivers/net/axgbe/axgbe_rxtx.c   |  8 ++++----
>  3 files changed, 32 insertions(+), 7 deletions(-)
> 

Could I get a review of this, and test on real hardware please.
