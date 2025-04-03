Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC23C36014
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 01:45:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AAEA4029A;
	Thu,  3 Apr 2025 03:45:52 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id D1A704014F
 for <dev@dpdk.org>; Thu,  3 Apr 2025 03:45:51 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-226185948ffso4338895ad.0
 for <dev@dpdk.org>; Wed, 02 Apr 2025 18:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743644751;
 x=1744249551; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rxSYwPWCChD8iqLe9dwjRSpBANIJSeZyYFsKE8tfdFA=;
 b=DZZQDaRxXTTYjjtB/1pW8kiqECtkheSLIuPLNsXlbpGJQGzsdTN8yivWGOF5ZcUM46
 4a735CqS9j+jMH5zVtyj8FXJfhTHwvBNR9ay2+3C9ZvScuWtrp8bknpXpEAlgEmF62ck
 fVKXEyj2cyNyD0+vkCtml87OEtcmebJER3V0RiC2h9Qv+8AqxHy4/1M0ZSGFPDKpjqV3
 EILeNN8YByOxBpjvcAa48sCp6SRaLNhulqp26al+S9KXFn/zITKI5uNuBeey1wjoIoXW
 kMb0Ech9xioRmoVrtOFy89+wtC744WiSbZSzSdmWqStJGnYYm9qiVQd1W7AY+5WVGdOs
 feeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743644751; x=1744249551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rxSYwPWCChD8iqLe9dwjRSpBANIJSeZyYFsKE8tfdFA=;
 b=DBye7qKe1jNKubNKySBsqR8ioFGqKuhW6PTEkTinh+jz991HD9jrzvlCQ1D3txSrKG
 g86qBovO3T8WHaYQ/bBBldxXENfVUww+rntr7IlAG+PYb2WImiMCcD1jV8bAZEX8gn3t
 9yEHmXNchaMBa6jx8c4iSURQ9hyWeDUz8j0s9cxgmStl2ZHBlq4/MnewXJ7RMa/vZsQN
 Wr6D/HSOg5WQdiV4m05VtQjBMbJ+356zUz4FV780P+Xsn7Ow7pcFu54gACFTCz3GWiQC
 OiAkRFsBe/w6M/6YKDtg59EKMstAZ0ZHapA5VcFty2aJjVb2TMwoY2P2ZU0KitQ7dE1V
 y48Q==
X-Gm-Message-State: AOJu0YwKuSRKNqQQ59FtAMZFRz9oZ8OddrMsKK6s21CGQdKuw/qlH5BZ
 9Spjf1ugU1XEVdvfEydyUggc4mSaD5hGRIK6jrod4rS+4fhrjhVSxyX7oGmhurw=
X-Gm-Gg: ASbGncvxfm2vW7SF5nGcLcI5qT1w1aDsrVovqnanL8r8Wi8p1y7lx/cVrSVAFUN3BQ1
 o+U5rjS8KGtBlrfwGvfOYD4zqaLcy0G2zWFEmomJ298cQoq/wT2xRNHkbk8iWSsA879oBHmODKJ
 fk1jmqZp+yfPW06IdfVhv0LqzPomBeCx1Z77gsqIq7hOO41FRrhx/nvDdmXZeGlfpgBXZKUftKj
 CrqaWILzyy+1aF8Pa4C9UAK0+/DnqN/xpDsTszhGpjx9Eeu3r0ejegC3i+/3pmPUY3+S+Iflqtd
 yYlkvucVBbiuN4o3uzWMcJ3v3QOr0w86YGmDD8wDufsqrVqrNGvgKFvi1A/Hlxk7k0tz7khm4XF
 Cl3IaVQ2g9dFcoZ8OyPv7
X-Google-Smtp-Source: AGHT+IHKOhdtV+65JoU3inS2Jlns22AGDyIL0lrVDzy3rq1DNLdCOGb36+CwK7iCEY19/p/SfT93uQ==
X-Received: by 2002:a17:902:d484:b0:224:c46:d167 with SMTP id
 d9443c01a7336-2296c65fd70mr57989315ad.16.1743644750906; 
 Wed, 02 Apr 2025 18:45:50 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297866e612sm2625315ad.200.2025.04.02.18.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 18:45:50 -0700 (PDT)
Date: Wed, 2 Apr 2025 18:45:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liwencheng <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 2/4] net/macb: add new poll mode driver
Message-ID: <20250402184531.2b90d0bf@hermes.local>
In-Reply-To: <1743577136-119797-1-git-send-email-liwencheng@phytium.com.cn>
References: <1743577136-119797-1-git-send-email-liwencheng@phytium.com.cn>
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

On Wed,  2 Apr 2025 06:58:56 +0000
liwencheng <liwencheng@phytium.com.cn> wrote:

> add Phytium NIC MACB ethdev PMD driver.
> 
> v4:
> * Changed functions that always return 0 and whose return value
> is unused to void type, improving code simplicity and readability.
> * Fixed the implicit conversion issues in the
> macb_usxgmii_pcs_check_for_link and
> macb_usxgmii_pcs_check_for_link functions.
> * Added the missing SPDX license tags.
> * Fix tab errors in meson.build file.
> * Use RTE_LOG_LINE instead of rte_log.
> * Replace %l with %PRI*64.
> * Replace rte_smp_[r/w]mb with rte_[r/w]mb.
> * Do not use variadic arguments in macros.
> * Do not use variable-length array pkts[nb_bufs].
> * Use __rte_cache_aligned only for struct or union types alignment.
> * Support hardware Rx/Tx checksum offload.
> * Fixed some code style issues.
> 
> Signed-off-by: liwencheng <liwencheng@phytium.com.cn>
> ---
>  drivers/net/macb/base/generic_phy.c |  271 +++++
>  drivers/net/macb/base/generic_phy.h |  202 ++++
>  drivers/net/macb/base/macb_common.c |  670 +++++++++++++
>  drivers/net/macb/base/macb_common.h |  254 +++++
>  drivers/net/macb/base/macb_errno.h  |   58 ++
>  drivers/net/macb/base/macb_hw.h     | 1138 +++++++++++++++++++++
>  drivers/net/macb/base/macb_type.h   |   23 +
>  drivers/net/macb/base/macb_uio.c    |  351 +++++++
>  drivers/net/macb/base/macb_uio.h    |   50 +
>  drivers/net/macb/base/meson.build   |   26 +
>  drivers/net/macb/base/motorcomm.c   |  645 ++++++++++++
>  drivers/net/macb/base/motorcomm.h   |   85 ++
>  drivers/net/macb/macb_ethdev.c      | 1866 +++++++++++++++++++++++++++++++++++
>  drivers/net/macb/macb_ethdev.h      |   96 ++
>  drivers/net/macb/macb_log.h         |   19 +
>  drivers/net/macb/macb_rxtx.c        | 1391 ++++++++++++++++++++++++++
>  drivers/net/macb/macb_rxtx.h        |  325 ++++++
>  drivers/net/macb/meson.build        |   18 +
>  drivers/net/meson.build             |    1 +
>  19 files changed, 7489 insertions(+)
>  create mode 100644 drivers/net/macb/base/generic_phy.c
>  create mode 100644 drivers/net/macb/base/generic_phy.h
>  create mode 100644 drivers/net/macb/base/macb_common.c
>  create mode 100644 drivers/net/macb/base/macb_common.h
>  create mode 100644 drivers/net/macb/base/macb_errno.h
>  create mode 100644 drivers/net/macb/base/macb_hw.h
>  create mode 100644 drivers/net/macb/base/macb_type.h
>  create mode 100644 drivers/net/macb/base/macb_uio.c
>  create mode 100644 drivers/net/macb/base/macb_uio.h
>  create mode 100644 drivers/net/macb/base/meson.build
>  create mode 100644 drivers/net/macb/base/motorcomm.c
>  create mode 100644 drivers/net/macb/base/motorcomm.h

File missing requires SPDX tag.
$ ./devtools/check-spdx-tag.sh 
drivers/net/macb/base/motorcomm.h
total: 1 missing SPDX, 0 license errors, 0 warnings
