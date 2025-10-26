Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE2ACCF9E5
	for <dpdk-dev@archiver.kernel.org>; Sun, 26 Oct 2025 18:17:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D75A40151;
	Sun, 26 Oct 2025 19:17:35 +0100 (CET)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id 620CA4003C
 for <dev@dpdk.org>; Sun, 26 Oct 2025 19:17:34 +0100 (CET)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-78af3fe5b17so2826219b3a.2
 for <dev@dpdk.org>; Sun, 26 Oct 2025 11:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761502653;
 x=1762107453; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4DfK3ifVa0Zh3ADMceUG3KyQp3xqagH765ngnlSNsIg=;
 b=GgmXegqKkcl2xrN2pwA+DioPdR/n5jVGCkaBidM0HT5FSn7a41v9u2BIZkjAcQi1NB
 QuUvNvfgJk8m5Jz5h10M3oT4QmxMWrC4tpaFFUKany3RArrM9Z2B8qrEGWEzUq8UWd6a
 RKvhup/OvkDGtF9RE4cFilBmrbvNpRR4LOtuu/+eVhSywFhAZnV5q1CWpc9o7pOGA3uk
 xENqgYa3qRRbUvsb7msds0v37tUcvJFvhaPuUG6x+4gN+1LhRvdwfJCR0tKzqFjZVk8u
 ItwhpYGEiRiXCipSShAhKgXI8l51XJyNbLTAD/90YPxZlRt+L20jG7YgOvuX4uexVaXF
 ByEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761502653; x=1762107453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4DfK3ifVa0Zh3ADMceUG3KyQp3xqagH765ngnlSNsIg=;
 b=G15PRf2Rv0WPlmrAByX/L6ZKjEwePTz5j6gLP7XY6KR9ZLkHoArPwgTYmlsJN3n8Wh
 9HCvBP4XBK6NgnZK6P8ZZzUaZ9i0sYEotL8AHyyJW49yBz5vEpvUj1h9ioAnMLW4Cq3b
 UTyXf8wFVgG4ciUBfgXdgiqDLjvytgZ+xTVwuTxdLSO+JgojncNBT4CAlpO5J63yhhKi
 vNmCGJN/OfF8D4S4ZUV2dGpsoNV+zcWZ13y6/OETRwJdhOLc9eEVmwMz12wjtij8nqeb
 2+LV69554qjQgbno+mc82SdnTOdXYxAtW1188jMGPpUrrzIXnJSlCkd4rbOZVifisaxK
 4iSg==
X-Gm-Message-State: AOJu0YyiJst4GhhE8z36KBtSFGnG0AmpNPE1RZ6f1aGz8fu7SVo+64l0
 eoc4ImDFWSHdFyosKmu5X2nhim5aqNH95dvpwEDvlE8+m9QhnSOQODnHh5hztl6o7nN/yuDSkXr
 BvvQm
X-Gm-Gg: ASbGncsZziSG8ZG15cyWCDUZ0GdtSxgmkVPhSllj81HGouUcRRWxYqpC4vYpaJ06att
 gwahLUHGoLWMhRFELbUTTGNbu5aEyaXuzhsopNsQ7zE7vv4QkToIzfcZMJUMsymHbuAHq2x/IOw
 Z8rG3JCHIucv4kabvXfmAVvEFqsWIuNpB76xZrXua8atHqd+C0qUXnXB/R0XNTfgrtddEwNAcRn
 wDnowQ/maBZ2AyzKNntfpykJ5ldnb2IEkZULIo3EAvUXilmIw3dTrNizClrA+J5rqTmu9Zltd6j
 v2K6jdfFHK+woeDv7Ex2W1smsnldi0qZ9LTVsVOHoJoWGVr9wWsDOV1PF0QdkEufKb248MJcdkp
 Z9w79g7aRJ/AfpYoTnouwb5aPt6qGB+5eP7xhMVtvkT75NEyfyh9aNdUjFkLiNKZMO4TSxm0UYp
 GcdKgtqnu6AtQzyt39wJQhPx2PGEDxXXRvwA==
X-Google-Smtp-Source: AGHT+IG+hpNoCetwHplmY5ydIEOWxNbA9/dmQ4m0670l/rLMy38CW4HIf1Ty02WrttaghDukDwoWFg==
X-Received: by 2002:a05:6a21:b92:b0:334:9f00:3af2 with SMTP id
 adf61e73a8af0-334a862573emr45679409637.46.1761502653373; 
 Sun, 26 Oct 2025 11:17:33 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b712d024aaasm5093919a12.26.2025.10.26.11.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Oct 2025 11:17:33 -0700 (PDT)
Date: Sun, 26 Oct 2025 11:17:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liwencheng <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 3/4] net/macb: add NEON vectorized Rx/Tx
Message-ID: <20251026111731.66acce34@phoenix>
In-Reply-To: <1743577152-119846-1-git-send-email-liwencheng@phytium.com.cn>
References: <1743577152-119846-1-git-send-email-liwencheng@phytium.com.cn>
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

On Wed,  2 Apr 2025 06:59:12 +0000
liwencheng <liwencheng@phytium.com.cn> wrote:

> +static inline uint8x8_t macb_mbuf_initializer(struct macb_rx_queue *rxq)
> +{
> +	volatile struct rte_mbuf mbuf = {.buf_addr = 0}; /* zeroed mbuf */

There is no way an on stack variable could be volatile. What it looks like
your are doing is trying to workaround misunderstanding of atomic.

> +	uint64x1_t mbuf_initializer;
> +	uint8x8_t rearm_data_vec;
> +
> +	mbuf.data_off = RTE_PKTMBUF_HEADROOM + MACB_RX_DATA_OFFSET;
> +	mbuf.nb_segs = 1;
> +	mbuf.port = rxq->port_id;

Why not just put these into the initializer?

> +	rte_mbuf_refcnt_set((struct rte_mbuf *)&mbuf, 1);
> +
> +	/* prevent compiler reordering: rearm_data covers previous fields */
> +	rte_compiler_barrier();

You would be better off doing an atomic store with the right type of memory
order, rather than weak + barrier.  But would have to handle case where 
refcounts are compiled out.

> +	mbuf_initializer =
> +		vset_lane_u64(*(uint64_t *)(&mbuf.rearm_data), mbuf_initializer, 0);

Take the volatile of mbuf and you won't have compiler warning.


> +	rearm_data_vec = vld1_u8((uint8_t *)&mbuf_initializer);
> +	return rearm_data_vec;
> +}
