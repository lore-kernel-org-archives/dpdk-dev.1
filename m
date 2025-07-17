Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44E0C83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 16:39:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD0614028D;
	Thu, 17 Jul 2025 18:39:43 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 11290400EF
 for <dev@dpdk.org>; Thu, 17 Jul 2025 18:39:41 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-234f17910d8so11104765ad.3
 for <dev@dpdk.org>; Thu, 17 Jul 2025 09:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752770381;
 x=1753375181; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=khwoKZLmQExcgcAYbp0LS3Zg6nfKX6VmAXfeOsurAms=;
 b=pvQ/IwItFynT4IoQ2dm0jnzSTO08ermfkaHrg747Ksq/VCsrm901y9rnDegXrAtO7b
 1HE4m9uMnu7pUwJL1oNg5W092x+UpNcypkSjE/QHZXrgsWtdlPbfSmUJhTy8MUZFw3Jd
 P4BZ/z+wnd9MemAk1NveUwP+3vK+MpnVbjH2Unb8p0Cm9tWyeQyfsM5jJpfYQZ7t/M3u
 9ASaAAW9j3qCIyh9bvnnVIbvpCJ4bYh9DIfWd7ZYBQdl5cDPvKRiw7RC8Vh3WLYmidCN
 uM5mvYQWimsHkfBqViP4aoZoVu1wjKiRSfi+SYPrmMqf4sFwV4QivL5kMDfLk7s1inlH
 YaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752770381; x=1753375181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=khwoKZLmQExcgcAYbp0LS3Zg6nfKX6VmAXfeOsurAms=;
 b=fjuwI9raZvwdtmBb2UTB/s+qOwLjlT8mUdVO1b1Tt9gnvxzgVJxL1xAAIKbSJ/Olss
 wUNEhinIBpJdaM21yz+qSAdETJeg9sag/KJhDHaSWP9c4m/rXxEwB6MuJKMCNBteV/ZB
 GT+i7e2jyuRXwV6LRFDigwf9wuEjTDh+wq/+/4hJl5y9Ndw/1FVJ9tCZ9w59JSfjm0+l
 XjLBMdgFL7UAd3kLzZ3KTULdyn/Q7XGvIqsMZvEYvVhdGGupaB0q/xQZlNhj79YaYH+B
 NZow8NKroSIBB0VOGR+S6ZV8dE6k+/4dEk9hHABcrMYnOV2ez9lPLM8rYp9RR5prZhk+
 WM7A==
X-Gm-Message-State: AOJu0YwmsMBm4GRziXh1Gpr+4nBXlrOYI/YD155cIHY8fz0TL1tjnEDP
 T9g0FyzcMt+5W0VdaFFL6FEUWyxVe+Uf6zH0bLIKPSeT7SqFsVuOY5w2x2+McJ2kIHNjqUrUey7
 xwwB8
X-Gm-Gg: ASbGncu8nI0uwmBRSzUQoJFQH0G7XyR5iffAz77JO4ot/teCNI65ybshBA2ECEk9TPk
 Zs9Xb2W1p+p9fIlto8xknrpLO1sH7uBNasmUO6qDEJaP7Y6l/1JFmFwwgR4NpVSDJ8HUMGh0lcf
 28AH8hMWYkWt/ofVbFFhkqdAX7FeeC3r9JICGLklykDbqfv7bdQxnw1CBVige2VsdBSE3B3wc6O
 ugzKWwYe2C0CMu8/2cWRBcPIk2Fv7CfYnYYcPI3l/BMDe6u6ju9AEjCwRhFuZS9lmZaaAacwL9X
 bTQySYzLtSEvmblHTyj+Nu+55HLDfgsJkuKmV8v1T2UeL4cFV8t4AfV8xzc00FmUWmq0fCiEO7L
 VlpZj6Hsb2P/6jASeNhCOcz34foLfZX9aWExQMebLUS/XF8hVsR9ugW0dPm60+yhE4ItL1pMWVK
 o=
X-Google-Smtp-Source: AGHT+IHqWfTBHLvzWb1eb1T1HJCpaX2Yozzmuc8tqchcPeFxYwoe10h+sNz8w4PCLuzlxEP4pryixg==
X-Received: by 2002:a17:903:18d:b0:22f:c19c:810c with SMTP id
 d9443c01a7336-23e24f74ee7mr97167115ad.51.1752770380980; 
 Thu, 17 Jul 2025 09:39:40 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de435b75fsm144971775ad.214.2025.07.17.09.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 09:39:40 -0700 (PDT)
Date: Thu, 17 Jul 2025 09:39:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 08/14] net/sxe: add dcb function
Message-ID: <20250717093938.41329ab4@hermes.local>
In-Reply-To: <20250716082930.83026-8-liujie5@linkdatatechnology.com>
References: <20250715034152.7020-14-liujie5@linkdatatechnology.com>
 <20250716082930.83026-1-liujie5@linkdatatechnology.com>
 <20250716082930.83026-8-liujie5@linkdatatechnology.com>
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

On Wed, 16 Jul 2025 04:29:24 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> diff --git a/drivers/net/sxe/rte_pmd_sxe_version.map b/drivers/net/sxe/rte_pmd_sxe_version.map
> index 1a25862ca2..4b871872d6 100644
> --- a/drivers/net/sxe/rte_pmd_sxe_version.map
> +++ b/drivers/net/sxe/rte_pmd_sxe_version.map
> @@ -1,5 +1,6 @@
>  EXPERIMENTAL {
>      global:
>      rte_pmd_sxe_tx_loopback_set;
> +    rte_pmd_sxe_tc_bw_set;
>      local: *;
>  };
> -- 

Version 25.07 onwards of DPDK does not use version map
