Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104D0CCD1BB
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 16:36:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 575DA40262;
	Wed, 22 Oct 2025 18:36:08 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id E75304025E
 for <dev@dpdk.org>; Wed, 22 Oct 2025 18:36:06 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-33badfbbc48so8581090a91.2
 for <dev@dpdk.org>; Wed, 22 Oct 2025 09:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761150966;
 x=1761755766; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bsRn4v/iC/NPy1OA53kGboWqwCr2C+a1W6HFBMKpCLo=;
 b=F91Wus3R7LMBI8lpZxUK+LMuwyHur5eXDlZIo/ZrBNg4BMq2bh5ntztVx9ztt9Qw9P
 kFqenQDYdIdhLhoMK5C5NsU/qeDlf4UaZnrr5fg7YrCAzN4l62p5ugJb8s6iwocZmuDj
 Cn55ZsJE+Pn/6o7ylx7aU/F/clzxe3cJUnTQFJMxWri/8RsRXGZ0LYdcXzpRY0Ysh1MX
 Y8Zrth8aSmJhTSHsr8ytSaDpeK9CluZwgiZLwOnib9CWKBGwDVap6yZRghca/87SClnS
 bPlETdKojLp+nCazmSGktgQDv8vYOvPF5graBgnz//2iOkNnTC21hYyrzDofixF95ZtD
 h14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761150966; x=1761755766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bsRn4v/iC/NPy1OA53kGboWqwCr2C+a1W6HFBMKpCLo=;
 b=h/KCWFT5AfMH1KoGy5vBETq3v2aYFPVeYJ/SQ5Rp2taK57zdMbOA5972ekVVTzNpDd
 qnjbnVclrbfjME0eKPjW3Z9wNoHl3B9x+gle1iT45CeFWex6sfy8lC8TALvUNu3fjzHj
 odcMxuL+izENn9tfUAJc6EXq+OjW+++QSeLzBJpZQIy7+QgMscDem2qcEWijQ1LkDjej
 dHFjhDRX6nEU82E6MuE/J/mIFMK5qJzLqwzgVVJaXkvoNyY5ItGs/2r8zFUVxGZPqbql
 D87gVM46+gs2esIpvlkQHWg0uayv/hTkiyYWlWBJqE8v00sS5UhqKvSBsHWu/nzq35DP
 T6tw==
X-Gm-Message-State: AOJu0Yx7EVT11oNl4HmLxWa226c6/ewtmUNAQAIJwHF3u8Vh7WkRsMjT
 uUnEykMdg7hxP0KPeLj8i9g0n9F1wqCH6i3QKuQ4PV0O/7Ja3M4n9xOa9mciWLJ0Xuw=
X-Gm-Gg: ASbGncvAk1XdP4/YC8ttGaQj6RY1TMo6mgxVuyNTPqeMb3yhADXJh7leHIdilIdM9Wn
 1eae2GRcbKuMFTYrTmoX3hvADUjtT2bgY0VlP/stCEQylnbuZTwEMQUdMiFLiyyhOUvVqdb2Gxy
 4q3GqJIp3FIs/1dN6d/YijoUTFJ+V19saFi8iMwgaT5XzweDNMsZ/R1rO2ddWqGqU2QrXh5Gzju
 VGELEOKaplG4uHDvBe9vQz4tMO4r41UV9thVC7nYTs4AzppVSUi3Q9QrSekHyXIUUs0uF7p3ySG
 aBDYo0A6uTrbiLvs5qsSt3p/2VU9x+BncmpL7AtbyGX6M9qUtCKTOKSms4cbOKNtbdDSeIIGju3
 h0bhLW2/bCxuSdayV2wmIKNMiyHR5N8kr57h3EMFTZbqEkdwDmeeO1xPj6qrlTXN6NYBZ0IyfYE
 BrCHm4Y/je/G00XCiAtmYakkjyiruO1ltVf/s/aREIkxEyYoQiyA==
X-Google-Smtp-Source: AGHT+IHZ/SE2WIof8HcdvWQQhmps9f8H3nVkXrEE56lizL20Fo1ZVmmVwp38r/DlmpSojxZKZyhwrA==
X-Received: by 2002:a17:90b:4a49:b0:330:82b1:ef76 with SMTP id
 98e67ed59e1d1-33bcf914d79mr28558975a91.28.1761150965893; 
 Wed, 22 Oct 2025 09:36:05 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33e223e223esm3046385a91.7.2025.10.22.09.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 09:36:05 -0700 (PDT)
Date: Wed, 22 Oct 2025 09:36:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 00/15] dpaa2: Fixes and enhancements for DPMAC,
 stats, and parser
Message-ID: <20251022093604.43eae5b0@phoenix.lan>
In-Reply-To: <20251016102805.2453687-1-prashant.gupta_3@nxp.com>
References: <20251014064035.1312896-1-prashant.gupta_3@nxp.com>
 <20251016102805.2453687-1-prashant.gupta_3@nxp.com>
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

On Thu, 16 Oct 2025 15:57:50 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> v2: fix checkpatch errors and comment from Hemant
> 
> This patch series introduces a set of improvements and bug fixes for the DPAA2 Ethernet driver. Key highlights include:
> 
> - Fixes for checksum parsing and error queue buffer handling
> - Enhancements to flow rule resizing and parser result prefetching
> - Addition of DPMAC MC header support and Policer statistics per traffic class
> - Support for eCPRI header/message dump and DPMAC counters
> - Upgrade of fslmc base firmware to version 10.39.0
> - Introduction of devargs to drop parse-failed packets in hardware
> 
> These changes improve robustness, observability, and performance of the DPAA2 driver stack.
> 
> 
> Brick Yang (2):
>   net/dpaa2: fix L3/L4 csum results in packet parse
>   net/dpaa2: fix to recv packets with additional parse errors
> 
> Hemant Agrawal (3):
>   drivers: dpaa2 upgrade fslmc base FW to 10.39.0
>   net/dpaa2: replace global variable to driver flag
>   net/dpaa2: add devargs to drop parse packets in HW
> 
> Ioana Ciornei (1):
>   net/dpaa2: setup the speed cap based on the actual MAC
> 
> Jun Yang (4):
>   net/dpaa2: fix error frame dump issue
>   net/dpaa2: fix flow rule's resizing issue
>   net/dpaa2: optimize to prefetch next parser result
>   net/dpaa2: add eCPRI header and message dump
> 
> Prashant Gupta (4):
>   net/dpaa2: fix uninitialized variable issue
>   net/dpaa2: fix to free buffers from error queue
>   net/dpaa2: add dpmac MC header file
>   net/dpaa2: add Policer stats for each TC
> 
> Vanshika Shukla (1):
>   net/dpaa2: support dpmac counters in stats
> 
>  .mailmap                                     |   1 +
>  doc/guides/nics/dpaa2.rst                    |   4 +
>  doc/guides/rel_notes/release_25_11.rst       |   3 +
>  drivers/bus/fslmc/bus_fslmc_driver.h         |   1 +
>  drivers/bus/fslmc/mc/dpbp.c                  |  78 ++-
>  drivers/bus/fslmc/mc/dprc.c                  |   2 +
>  drivers/bus/fslmc/mc/fsl_dpbp.h              |  41 +-
>  drivers/bus/fslmc/mc/fsl_dpmng.h             |   4 +-
>  drivers/bus/fslmc/mc/fsl_dprc.h              |   1 +
>  drivers/net/dpaa2/base/dpaa2_hw_dpni.c       |   3 +-
>  drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h |  10 +-
>  drivers/net/dpaa2/dpaa2_ethdev.c             | 350 +++++++++++-
>  drivers/net/dpaa2/dpaa2_ethdev.h             |  65 ++-
>  drivers/net/dpaa2/dpaa2_flow.c               | 123 ++++-
>  drivers/net/dpaa2/dpaa2_mux.c                |   8 +-
>  drivers/net/dpaa2/dpaa2_parse_dump.h         | 124 +++++
>  drivers/net/dpaa2/dpaa2_rxtx.c               | 123 +++--
>  drivers/net/dpaa2/mc/dpkg.c                  |   7 +-
>  drivers/net/dpaa2/mc/dpni.c                  |  50 +-
>  drivers/net/dpaa2/mc/dprtc.c                 |  38 +-
>  drivers/net/dpaa2/mc/fsl_dpdmux.h            |  13 +-
>  drivers/net/dpaa2/mc/fsl_dpkg.h              |   7 +-
>  drivers/net/dpaa2/mc/fsl_dpmac.h             | 526 +++++++++++++++++++
>  drivers/net/dpaa2/mc/fsl_dpni.h              |  37 +-
>  drivers/net/dpaa2/mc/fsl_dpni_cmd.h          |  15 +-
>  drivers/net/dpaa2/mc/fsl_dprtc.h             |  39 +-
>  drivers/net/dpaa2/mc/fsl_dprtc_cmd.h         |   7 +-
>  27 files changed, 1520 insertions(+), 160 deletions(-)
>  create mode 100644 drivers/net/dpaa2/mc/fsl_dpmac.h
> 

Added ton next-net.
