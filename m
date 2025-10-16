Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018F1CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 16:59:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCDB840F16;
	Thu, 16 Oct 2025 18:59:30 +0200 (CEST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id F3D0A4026D
 for <dev@dpdk.org>; Thu, 16 Oct 2025 18:59:29 +0200 (CEST)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-87c1a760df5so14833506d6.1
 for <dev@dpdk.org>; Thu, 16 Oct 2025 09:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760633969;
 x=1761238769; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o+nqn61Ske0zv3fXg7zjr9spBngGI/1aha+cL2x8dMo=;
 b=JNUgWxL/rZ0JoLaM/e6jkxZLo0qnyV0BLIe0OubaEkUOVvoscKnduq13xVdUQue3i1
 DY9imfOds5yOkGOxh02hdg/09orwVKdJqtECrYvSfn8PTz1IvqcZGZCvAWvh/3bj4/kZ
 DRlzW5cHOVIZJETMniDeXndNVkxnCCeIIlSbGNa+ooU3P+YfaMPc37i4buC7dtq5J4r6
 +PzOx5gojN6t/RGrexsJmzLZ/9cnXBeBQ0YZ0cLByVshS1zW8E3kUKQkOTt+w5ew93Q2
 udTeNawD5lyh3RfY/Va2mjFcN+UAUS3oY+v/PMPN/6PD9JGjSOaIq4C8unhriLOyBmz8
 Q09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760633969; x=1761238769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o+nqn61Ske0zv3fXg7zjr9spBngGI/1aha+cL2x8dMo=;
 b=Vs2CXMSCOSDdJZS8v2+XP1UZEzLOS0XRWz0YuQMurIMl43wt4K/tXhw+YoItlnuRcw
 P2xmqJ5kY5hWVr8tLhK8JbEeyf6wZlGxioN7r4A4kW9P65MPvPbRC8e4t8BdPOUzfwq2
 pFDk9FDyom9KznvugIpYQaqu4axbzA4hGYSUJA9zmxSSpxiLWshDUKgV7WQBXVuEAZcT
 GitKugDfqfUQhWyoV9YbXHqyxFN3CilsfsTA910A9BEzIC8m/ayCexemUpzWgs0sw22Z
 cJpL0RMjrsvasvlAf5cfCQq+btNzqCrgVd6xZtETB4SIbB5Y0HiGUJDAbbHCSSHPQYPM
 IXGw==
X-Gm-Message-State: AOJu0YyJE6tWk/0EWChiioqtmyJqR37nhNdaQYCNuAyXK62+Ezs1ccjR
 1G4tWDGBNZvQ11W1/gUpKWdZMXujISMkNaPClig4X4VitZ/FhWYgs0r1jgIR8zAWE5BCxzvCIB1
 +9+XIpP4=
X-Gm-Gg: ASbGncstWpTT/muYBNSNSJ8/W/GSn9GHgbEJGKMrPMA80BlO6uUbFNrO1YvGCbyzG5G
 rUpu/iW/MJ0pOdNPar4C7Y7WTbKXQfbf4hwMQzgcsSqBF3DTSItr8NjORvixaEQ/9cpyM+VkL9m
 3MrhbvKiHASRMbchUqfZ3lizSXbLfrsSLK5r24fy8YlUiWARBrnhGnd5vsjU4qGzMD5EkFR14Q3
 EO3eDPIBh46pnEqh6dG2a7Tk6rx3eqZFmBejevtCvxox5Kx5jNc9DkOqBg45SXYhbQLgsl+anB6
 lKLB6zXWtTqHJoKQV7OKR97BGay7t7xP3mH5uq5T448BQBhUmVMm1EMBEDIXU1T0pPFRgHhAih4
 4B5EB8Xus1BGrV8vcMltv5A0K1OQ2OUqYE15j/yq5C21bf4E5DxsnMIVNe0m6S+g9Fl3W6nIK+O
 LrAyCRLFW+xGd5yEpRo6sChY14/L5Dm0S+yuXHNZbmwztTU460ku5OkfZYTCkm6Uc=
X-Google-Smtp-Source: AGHT+IHhdY237Bw5zm+nWS8XGbXx4Sw7dnPT91PcbJvVp0aFsN1icm51W6RLhZ9/tACXBXQm4BslTw==
X-Received: by 2002:ad4:5cc1:0:b0:851:746c:e6c9 with SMTP id
 6a1803df08f44-87c2062d690mr11547586d6.31.1760633969098; 
 Thu, 16 Oct 2025 09:59:29 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87c0122d19asm42888026d6.29.2025.10.16.09.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 09:59:28 -0700 (PDT)
Date: Thu, 16 Oct 2025 09:59:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 00/21] Wangxun new NIC support
Message-ID: <20251016095925.7490e5f3@hermes.local>
In-Reply-To: <20251016111736.25372-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20251016111736.25372-1-zaiyuwang@trustnetic.com>
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

On Thu, 16 Oct 2025 19:17:14 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> We have released a new NIC series: Amber-Lite, with two models
> supporting 10G/25G and 40G rates. Due to minimal hardware differences
> from existing 10G NICs, it remains supported within the txgbe driver.
> 
> ---
> v5:
>  - update txgbe guides, add more usage instructions
>  - add a short summary into 25.11 release notes
> ---
> 
> Zaiyu Wang (21):
>   net/txgbe: add basic information for Amber-Lite 25G/40G NICs
>   net/txgbe: add new SW-FW mailbox interface
>   net/txgbe: add identification support for new SFP/QSFP modules
>   net/txgbe: rename raptor to sp for Sapphire-specific code
>   net/txgbe: add basic link configuration for Amber-Lite NICs
>   net/txgbe: add support for PHY configuration via SW-FW mailbox
>   net/txgbe: add RX&TX support for Amber-Lite NICs
>   net/txgbe: add hardware reset change for Amber-Lite NICs
>   net/txgbe: add MAC reconfiguration to avoid packet loss
>   net/txgbe: add TX head Write-Back mode for Amber-Lite NICs
>   net/txgbe: add RX desc merge mode for Amber-Lite NICs
>   net/txgbe: add FEC support for Amber-Lite 25G NICs
>   net/txgbe: add GPIO configuration
>   net/txgbe: disable unstable features
>   net/txgbe: add support for TX laser enable/disable
>   net/txgbe: add support for TX queue rate limiting
>   net/txgbe: add support for getting PHY ID
>   net/txgbe: add thermal sensor configuration for Amber-Lite NICs
>   net/txgbe: add RSS for Amber-Lite NICs
>   doc: update for txgbe guides
>   doc: update release notes for Wangxun txgbe driver
> 
>  doc/guides/nics/txgbe.rst                 |  31 +-
>  doc/guides/rel_notes/release_25_11.rst    |   7 +
>  drivers/net/txgbe/base/meson.build        |   2 +
>  drivers/net/txgbe/base/txgbe_aml.c        | 354 ++++++++++++++++++++
>  drivers/net/txgbe/base/txgbe_aml.h        |  22 ++
>  drivers/net/txgbe/base/txgbe_aml40.c      | 160 +++++++++
>  drivers/net/txgbe/base/txgbe_aml40.h      |  20 ++
>  drivers/net/txgbe/base/txgbe_devids.h     |   9 +
>  drivers/net/txgbe/base/txgbe_eeprom.c     |   7 +-
>  drivers/net/txgbe/base/txgbe_eeprom.h     |   2 +
>  drivers/net/txgbe/base/txgbe_hw.c         | 365 ++++++++++++++++----
>  drivers/net/txgbe/base/txgbe_hw.h         |  15 +-
>  drivers/net/txgbe/base/txgbe_mng.c        | 184 +++++++++-
>  drivers/net/txgbe/base/txgbe_mng.h        |  34 +-
>  drivers/net/txgbe/base/txgbe_osdep.h      |   2 +
>  drivers/net/txgbe/base/txgbe_phy.c        | 127 ++++++-
>  drivers/net/txgbe/base/txgbe_phy.h        |  24 ++
>  drivers/net/txgbe/base/txgbe_regs.h       | 103 +++++-
>  drivers/net/txgbe/base/txgbe_type.h       |  70 +++-
>  drivers/net/txgbe/base/txgbe_vf.c         |   2 +-
>  drivers/net/txgbe/txgbe_ethdev.c          | 390 ++++++++++++++++++++--
>  drivers/net/txgbe/txgbe_ethdev.h          |   2 +-
>  drivers/net/txgbe/txgbe_ethdev_vf.c       |   2 +-
>  drivers/net/txgbe/txgbe_flow.c            |   2 +-
>  drivers/net/txgbe/txgbe_rxtx.c            | 203 ++++++++---
>  drivers/net/txgbe/txgbe_rxtx.h            |   3 +
>  drivers/net/txgbe/txgbe_rxtx_vec_common.h |  27 +-
>  27 files changed, 1967 insertions(+), 202 deletions(-)
>  create mode 100644 drivers/net/txgbe/base/txgbe_aml.c
>  create mode 100644 drivers/net/txgbe/base/txgbe_aml.h
>  create mode 100644 drivers/net/txgbe/base/txgbe_aml40.c
>  create mode 100644 drivers/net/txgbe/base/txgbe_aml40.h
> 

Queued to next-net.
I changed the git commit subject to conform to the restrictions
imposed by check-git-log.sh. Max line length of 60 and prefer "Rx" over "RX"
