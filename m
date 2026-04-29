Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCB0CCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 15:13:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1C8A40695;
	Wed, 29 Apr 2026 17:13:09 +0200 (CEST)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com
 [209.85.160.54]) by mails.dpdk.org (Postfix) with ESMTP id 681004065A
 for <dev@dpdk.org>; Wed, 29 Apr 2026 17:13:08 +0200 (CEST)
Received: by mail-oa1-f54.google.com with SMTP id
 586e51a60fabf-40f0e14b9f9so7327796fac.1
 for <dev@dpdk.org>; Wed, 29 Apr 2026 08:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777475588;
 x=1778080388; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CcY3ie65BG//ZRhouuUcGJk6JvhEHhS0m2wQqHOuZ+E=;
 b=Y8EAzo5/ikG6XMCnmbg7glUQDNJ5gFOLlwOsavtgIiVv8h5A/3qsgU4LIwP1lZpczx
 jTVL8P5kWJW45DMa3dy3IrAWvYXr41zkNHdcMjnV7E1oLGup96gjZR22m5Jy7Vv3YR4q
 IBdGP2MX/2W4uwOH7dWJpLolSnxMOX7BqMyFcGuueSbFZOhWSkU6Yi996atqzwvzW/XT
 rIC2JAJu0jlvAqJBJqJ5QEPooHIjbLB+z2RBKtJeKySzo/+HPZETWmC9HqxAoBAWgN20
 iSPDFzMx/tuLJ+ZzfISDScsUH/X8mQ7HWOGvaV1Yb7hRA2eMVNAyVsEvGQI9tcFkFZ0u
 4dVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777475588; x=1778080388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CcY3ie65BG//ZRhouuUcGJk6JvhEHhS0m2wQqHOuZ+E=;
 b=QRf8uW1020nCpd7cDlUjq0nYbRDKuLxCY3uwiwwCH/77Vmj4e4ob4+NEHzfRnDc4Jv
 vmGrwlIh2OUTFSjfY/8K9ESza139EukOyoOu/wPBd5gKcVyhgXvDK8FMJ5tZNz9nAflj
 50RPMSGpqsVQo7k5ABxOKcOpjxSsld1sW1Cl+zRKYgvELtV15Aw+/Mb8EgKTLlc5PRXr
 W2nq4O75tU4urt/eqHL30b2x6E+K9qavyr0UnWlFKzNRc/dnYmm/EdASLJdLl7/Xpv+L
 l/Z9bAWE7KLt5DwVe2ra0nDRKjwzoAj39RGeUIvqjkyHwzUWHwqAhP9pNayXvZwEmKLq
 3YGg==
X-Gm-Message-State: AOJu0Yz8Z50g9GnePsO7GTtebnTq9FyS64mtnKr1NqzpGg5BGc0t+O0w
 /nQeGRpj61WuFLd1UYvRE5FkQ/0JiCUzGNJG4aRFbsFg24hCK2781VfevYa+ybZKGIFgw4j1Jj1
 DPImZ
X-Gm-Gg: AeBDievgBVBkwNNpf3tXycTDsZWHuC4LuI46sEG0lg1oAURoEgXlOgIdjftX46yB1XC
 Gf++mvaaPXGpCQ8tymy01Y4MHMOzoJMNne7apbu/GamnWY/ECVn7OTQuksni71E0C9d9o327YPY
 LFD8LhzL6cKLUMpn8eh8hf8a8VAT0xUKOwR3hhBZ9Y804eRK20uSvFyQCPVxy2Jhe3aGr6jgauA
 x0VwHA+mBHk7R9b3/GH+NiVJKTiJ9oFaYhSfqya+eL6fIR69HrU8SDco9/w8qxvhLW47Jwty7tO
 A56njRwwXxYLDOW53jcrxLhiL+2wQIcXaoKFlDEUtgvkaCbRbIOF92GeEJSSzXbXX2gSeqRDuFl
 PTrKuNXkI3scESqwoyT81DlwBRC0sTZEzHU7Oz8XWsu5ziQ5H/EKJFc2Uw4Deh0pCYTKgt5/K4O
 5WBzZO779eJZiZbEf7fdFILPJYqz2a1tx3cCw4HH2hsgGBAQ==
X-Received: by 2002:a05:6870:510:b0:41c:b538:e19c with SMTP id
 586e51a60fabf-4340ac25cbcmr2396726fac.38.1777475587579; 
 Wed, 29 Apr 2026 08:13:07 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4340e981839sm2161537fac.13.2026.04.29.08.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 08:13:07 -0700 (PDT)
Date: Wed, 29 Apr 2026 08:11:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stable@dpdk.org, Jiawen Wu <jiawenwu@trustnetic.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: Re: [PATCH v2 11/20] net/txgbe: fix traffic class priority
 configuration
Message-ID: <20260429081136.3defdeba@phoenix.local>
In-Reply-To: <20260429102515.58880-12-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260429102515.58880-1-zaiyuwang@trustnetic.com>
 <20260429102515.58880-12-zaiyuwang@trustnetic.com>
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

On Wed, 29 Apr 2026 18:25:05 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> After applying the following testpmd command, 802.1Q packets with specific
> priorities were not properly directed to the corresponding traffic classes:
>     port config 0 dcb vt off 4 pfc off
> 
> The old driver had two issues:
> 1. The hardware uses a 4-bit mapping register per traffic class for
>    priority-to-TC mapping, but the driver incorrectly configured it
>    as 3 bits.
> 2. The DCB TX configuration mistakenly wrote to the RX register.
> 
> Fix both issues, ensuring that tc-prio mapping works as expected.
> 
> Fixes: 8bdc7882f376 ("net/txgbe: support DCB")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
> ---

AI review spotted issues:

Error: The fix is incomplete. The same priority-to-TC layout is also written in drivers/net/txgbe/txgbe_rxtx.c around line 3380 in txgbe_vmdq_dcb_configure():
for (i = 0; i < RTE_ETH_DCB_NUM_USER_PRIORITIES; i++)
	/*
	 * mapping is done with 3 bits per priority,
	 * so shift by i*3 each time
	 */
	queue_mapping |= ((cfg->dcb_tc[i] & 0x07) << (i * 3));

wr32(hw, TXGBE_RPUP2TC, queue_mapping);
This writes the same TXGBE_RPUP2TC register (0x019008) the patch is fixing, using a hardcoded i*3 shift and a comment claiming 3 bits per priority. After this patch, txgbe_dcb_config_rx_arbiter_raptor() encodes priorities at 4-bit positions (via the updated TXGBE_RPUP2TC_UP_SHIFT=4), but txgbe_vmdq_dcb_configure() still uses 3-bit positions. The VMDQ+DCB path will produce a wrong tc-prio mapping. txgbe_vmdq_dcb_configure() needs the same fix (use TXGBE_RPUP2TC_UP_SHIFT and update the comment).
Warning: TXGBE_DCBUP2TC_DEC and TXGBE_DCBUP2TC_MAP are now inconsistent. After this patch:
#define TXGBE_DCBUP2TC_MAP(tc, v)     LS(v, 4 * (tc), 0x7)
#define TXGBE_DCBUP2TC_DEC(tc, r)     RS(r, 3 * (tc), 0x7)
DEC will not decode what MAP encoded for any tc > 0. TXGBE_DCBUP2TC_DEC isn't currently used in tree, so this is not a runtime bug, but it's a latent trap. Either update DEC to also use 4*(tc), or remove DEC since it has no callers.
