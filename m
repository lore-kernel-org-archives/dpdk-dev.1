Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E71C87FCF
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 14:17:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3987140657;
	Wed, 13 Aug 2025 16:17:25 +0200 (CEST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 0523640265
 for <dev@dpdk.org>; Wed, 13 Aug 2025 16:17:23 +0200 (CEST)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-3b8db5e9b35so4137129f8f.1
 for <dev@dpdk.org>; Wed, 13 Aug 2025 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755094643;
 x=1755699443; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KwjhnXB8e+DPl7ba71C4w2tzphIeRNvpfddTLL4mNqQ=;
 b=ohKlouDE1RG+drSZnbNy8aBKQ0hRQQ4Cr+gIoAJgnH3Cbv0dvOIDEkBefYpNijt/eY
 dh9HD/1YOsCCwXGU2IGqtsDB1XVmX5awvChYmGmuOe6W3OOoXDnH+E31+rpB0CZVpvnN
 gJ/EQP69WyrvGMeZn2nKYgXUIUL0I01iKRWRYUm9YuyOmFrfyJfhzhunEyHl7NM5R9Ao
 wxogoktW8gDzRzui7aKaAj3apu/pBp4BRLaY5aYJ5SBj6FWIDL1ljCRfOy9EltQHtO+t
 eSGKpd4R43NVgqb9xCU15+Ny7lNU3w3UWCuJpINsyW2dVx2AaItdgGodMkKH5zwAoWgJ
 6OMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755094643; x=1755699443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KwjhnXB8e+DPl7ba71C4w2tzphIeRNvpfddTLL4mNqQ=;
 b=F8j3wc8NXC1L6TPnnjw3Wdzcc5lQC6IKXUOphJ6ZViXXcx2e72M/7FgMhMjFTvpgPj
 //2KpNwrMhQxNKdlNk4n3V3Rci0LltU7MQSYNC2wW9oqVnLba/G+blM+66EdRNFm0ZNk
 cODTqOmnFWIaLK2ExpktNPhdoVvO76vC/CsFXmCnuT+NAqyk1d5HLG11IDaXfTwP63jR
 wvIxWPyvDXgzlPPaaqnLrcsN4z6l6uki49WKYlmK21xwzYvzk1pR2/lzZzMkjBBzUvx+
 IS6+nWapSsMUAlVCHMsebaywIR7qqMMzhTJYxGY3gjPL5Dpx8pijxBcwoV6SfPTuyAPH
 73zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTmz/YyrkKOkHOd8a2kql0HznxXIwE9LPS2P6SSxGEt6dIS2qZB+PkW73jtPjZjxOBu+o=@dpdk.org
X-Gm-Message-State: AOJu0Yx0+MyiQ1bOCBflr7T/Bs98cmIxdD6XdYIuMu/hkekGY7s2vfci
 w2z9j3FlfqrioaWP9oYc1+DYEE2nJfPHVu/gOt5crwxiVA0ECqGVhg0niDux8I5LQUo=
X-Gm-Gg: ASbGncttYJPQB+T4GAz6ZfJLoTQArCMSxfyHjU5L/Gre4Q0ccNydNMkiZxEv7Zi2ULH
 8Rqb74fK3P4omr/0obJhFLuXwo/7i/5GeEDH9Bn09rckYPYJFeFm8tbZXSTa4zbpPTzx16R+3mB
 3jidPrasMupS4cMqkl4R8d2MbZDXgsvRzPTLPACShXJ1u2Zdz3aO7HPYi+j4sLcxu2dOgwnmo0y
 iuZTobwTx3praBydY1lhQxow0A+YKp9vbl27fnBGD85F0FaXmfKLgbdCidDqt2kQI+5OMhrFEj0
 fqQLGhGNA1agv4WSW6ZvL4I3es4p7zvLY/HGPXEvVaThhrZfXXXWQzs6Qb63tB6Rqbbi4E4La2G
 lo1I5VPvlX/KJgyYPjGXhwG5BgMsO68V8PEOjmHPDDFNHs7yxkTlXXUT+mbTiXq/cHtj/TgiaHu
 c=
X-Google-Smtp-Source: AGHT+IG+BhtM4VslqViQ8gNvpxbrLX/WZW2klCO87Jgkivb5qLVAM7MZLjUoP5Yr8BH2WmypQxELkw==
X-Received: by 2002:a05:6000:401f:b0:3a4:f50b:ca2 with SMTP id
 ffacd0b85a97d-3b917d1ef10mr2659708f8f.8.1755094642836; 
 Wed, 13 Aug 2025 07:17:22 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1a586a7asm3771715e9.15.2025.08.13.07.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 07:17:22 -0700 (PDT)
Date: Wed, 13 Aug 2025 07:17:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: Thomas Monjalon <thomas@monjalon.net>, Sunil Kumar Kori
 <skori@marvell.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 dev@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>, David Marchand
 <david.marchand@redhat.com>, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v3 1/1] ethdev: add support to provide link type
Message-ID: <20250813071718.48c85ea6@hermes.local>
In-Reply-To: <165f84cf-1fd7-527b-bda6-8b2823ac85e9@arknetworks.am>
References: <20250606092904.3145608-1-skori@marvell.com>
 <20250813084508.1446318-1-skori@marvell.com>
 <1975832.6tgchFWduM@thomas>
 <165f84cf-1fd7-527b-bda6-8b2823ac85e9@arknetworks.am>
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

On Wed, 13 Aug 2025 16:16:29 +0400 (+04)
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> >> +#define RTE_ETH_LINK_TYPE_FIBRE    4  /**< Fibre */  
> >
> > In general we use the US word "fiber",
> > but we are not very consistent, so it is not a strong opinion.  
> 
> To me, "fibre" reads more natural. Not a strong opinion either.

What word does IEEE standard use? That is what matters.
