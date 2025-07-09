Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB26CC83F0A
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 16:13:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45EC540B8D;
	Wed,  9 Jul 2025 18:13:41 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 9814A4028C
 for <dev@dpdk.org>; Wed,  9 Jul 2025 18:13:40 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-235ef62066eso965625ad.3
 for <dev@dpdk.org>; Wed, 09 Jul 2025 09:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752077620;
 x=1752682420; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MIKgApwVLO3vVFcpPQu3QW2ct2z530G8WTbHNcmsxvw=;
 b=Dm8mkPIxyb0wRdigeL2jca5Yj8ks032TWKgZCJWN4QnXMiJ6CLT1jX4Zr2UAL1l+P8
 N/YjGOoG0wyORxTENnLPfVCqgzSQGNnWhQt+kRUoHtq7hZ5Aqvf3IpOXYq6noBSQJMjF
 VBCxyn4K0TjwOwhVpIzOU4Rig1G9tPpC9DOSb+cC/w/ob+yuvcSNRY2AgsIkl4DW4ozk
 mRoWamw33sCmZX0eJcuDwFhPNHbFvbCDPqu/VlDNCGfVVeMP55Zyts6CZHjD6l4hD4wS
 kxdTZvZ8QwrX8CWAiPX9Aj474KUyZlE1MciEP5rX8pZRfFPjL3teSNPPp/LfBot8XQA9
 ePmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752077620; x=1752682420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MIKgApwVLO3vVFcpPQu3QW2ct2z530G8WTbHNcmsxvw=;
 b=v7vxWsHu/9PhDAxzbNWyiAIdgYr7bHgMhIozmi7VgcGLmr/GPNZ1WlqkkLrGJxzMEy
 vfseJeFfo1n0iYjwZx3OP+8wyrHSEHJP4B1I2Jq2yRXBitmKcNW1cbQtYsxroWQL4twU
 2Lq3gsUqtr1bZy95MkNtGKlb8lqrXtyopkO8Teuau29RWp4E8vBuoWGx+IPLpAMkbd2f
 X7CnNvkZy/pJgRGLpfzYzpJYMU68JAXXPF1Nad88sy7AwkVcug48ToJFwCaTgSWnwKhI
 V4bmclQ0q7loun8nLNEidQ6ETlTo1JK+cCP+dGGdNvX7RazAWRpPeDOPnt8KSHwprj1U
 LKvA==
X-Gm-Message-State: AOJu0YwrA2DNHHp/5TuN10CrS6XuVrByJyA8zpKwcd16Q8fffuIZdKYK
 H/DCatLzpYMcSebfAoFAigIEonA0ugF7ZPuNzsixJkYOTfy7eZdVas4HiXSbcYi3iNYFzA3ujxp
 U634u
X-Gm-Gg: ASbGnct5misaa/RCYL5btG8SYaZ46jivs03ryddJ4vnR9zMfxkNZ9UFXnRbkT0p7Fae
 5OfvSdjE9wYKQEXoF5gOBiRSDMD6TCaanb+g/tW1jPc9LW20y3/q9QHFnSC0nVFa6f0wLmznrfI
 mB/GFg41a1uGyOekGnleW1wEHUggS3lySOMtWJLBURjRzlULOgijesPRnfgy94kYHZu4AEK7Xq8
 E7CuVNDnZUoFVJB4XXgVBbvTrtjQyBN5DuozeGq8nMw6WC4Y5A3WmYM247xHhTBYe0PjeSHwES5
 ATq1sOtNVgQmplgqiVZMifRC1qttZ/blMs/a/6ODUJOHaD2W77d04vMbx/V0my4MUzk/6IyqeuW
 UGpiM/9Kg586LzbstSlr8Q+Q6hucGPQ/qwQ5XvDw=
X-Google-Smtp-Source: AGHT+IEnfqeGocD62FVvN1/ni70fAOXWv4VgEQLRoL+jgCq8lrpC1a/DDdSWh3cpt0gBhzzlkVer+Q==
X-Received: by 2002:a17:903:2443:b0:23c:6cc2:feb9 with SMTP id
 d9443c01a7336-23ddb3137cbmr40740755ad.45.1752077619582; 
 Wed, 09 Jul 2025 09:13:39 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8457b2d9sm139625285ad.161.2025.07.09.09.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 09:13:39 -0700 (PDT)
Date: Wed, 9 Jul 2025 09:11:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 04/14] net/sxe: add link, flow ctrl, mac ops, mtu ops
 function
Message-ID: <20250709091151.1cb4af9c@hermes.local>
In-Reply-To: <20250709084315.9940-4-liujie5@linkdatatechnology.com>
References: <20250707115819.12826-14-liujie5@linkdatatechnology.com>
 <20250709084315.9940-1-liujie5@linkdatatechnology.com>
 <20250709084315.9940-4-liujie5@linkdatatechnology.com>
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

On Wed,  9 Jul 2025 04:43:04 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> +++ b/drivers/net/sxe/pf/sxe_filter.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright (C), 2022, Linkdata Technology Co., Ltd.
> + */
> +
> +#ifndef __SXE_FILTER_H__
> +#define __SXE_FILTER_H__
> +
> +#include <rte_ether.h>
> +#include "sxe_dpdk_version.h"
> +#include <ethdev_driver.h>
> +#include "sxe_types.h"
> +#include "sxe_hw.h"
> +
> +struct sxe_adapter;
> +
> +#define MAC_FMT "%02x:%02x:%02x:%02x:%02x:%02x"

Use RTE_ETHER_ADDR_PRT_FMT or rte_ether_format_addr
