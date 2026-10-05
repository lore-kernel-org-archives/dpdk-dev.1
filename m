Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890B1CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 21:05:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92A6740DD7;
	Mon,  5 Oct 2026 23:05:10 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 10D5540A76
 for <dev@dpdk.org>; Mon,  5 Oct 2026 23:05:09 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-3a494638445so1237573a91.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 14:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791234308;
 x=1791839108; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9TzXaYRKvWccQVeW2N0P6t91XtAGUHWqy3DtX+Xmxbs=;
 b=iFgDvzLm6yCb9xUedQSD/vbSk5p+nrudUZuH9W6p1hhcgk304CZjbyxNWG1WKjeeFV
 fdjHBBl4N369XOruLeqwYUN50SP1p5G6MM0jNQfT6UnaygutrQBr3RYg+OUHcJ8uJyIH
 ftlxRi/Y45GewFgyDOHu2kOdXDQaSAltDYEVMaGq8jEaRLWhOjzXz/meZzTMlltBcHxn
 3ROiglirPWqw0AHp//TZgJsUi7o4Hp1dcpO/oK9JOx0h/RHBRrOyRnL+dJGyi1RkUHNj
 2IbNcGTeZwXHrYPQEnn71oXItZ8IcmmSvtO/4eodQB7BDob760lt2KFzwmWjDs+mOVBA
 o+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791234308; x=1791839108;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9TzXaYRKvWccQVeW2N0P6t91XtAGUHWqy3DtX+Xmxbs=;
 b=CO8rFGCaRMgZhFSjk3SXKG3UF3yCbxr+Ghk1lnQFaqQ/czsTBYyMvEzj8m0p44Tf8I
 7VUqUVuxXdyK6ypzMLn2694fx7IPIB9OwHtghbkWyYmRbLMgbQGaFTkRj0uud38O/VF5
 BL3/Cm/J0mt9lwxDI4qCABgmg7tCkhnelcylE82whqn6s3M7DvKrb+C5FGIMqFebYbG/
 21xw/VglpzAqj0wBjQwJwliQWOm2j3ntflNXlahg5gkc2K1TOtkW7YDzo32XYQDZgAEf
 nqkIYbELGV8vIm4UAk0bvvjm3V5QW7LgELvj7h8cRF8yrEGoSTDLapDR0y32D0bSsc2j
 mrlw==
X-Gm-Message-State: AFq9FYIWnA1AbBQEWvt44Nws08ayO+vW6qtntNqBWHI8P3q/Fk8q7bye
 3AJBpCa/5z/go1Ug5no9l18vnkcHStJyg4MEo7r/cayIrWeiCZhd88awbYUmafPL+7c=
X-Gm-Gg: AYBFou1r9HCbFtTm7HjZwIM8Ee2inIcavSNtNtdAsTt6535STJCUB5bJoJkV/ryoXrK
 uQ59XY7Vph4fhj6FWP8/rEJXsjZFjx2MNkX2ZN7EZC7DPltrBgJ/UyEgXLYYpguNkN6aRNnLpaE
 H2yQabJ1I5tH6CdBsKEJQV92y8g+4ltw4R0uDlieE5E5+ETwPp6q81H70T1fQ1ST3DcPCm3Wd4y
 1MXA/SMitGJxNSGw0S/zgh6GRU3Gv68cvyJO3JSxiOWfXdLUoFD9vFFH2yKG4gW5VuBphwCYbLc
 F2WWI6GJfFhHHxOJtY0hMMimxow/5WJcW13QjOs4Xw7Kl6KXHvjd/5q2mK3Qg85a146zkJLs6i6
 fuw9Mbr58K680EDAjjW72p2D71IteQUaQZOsguHwuc0Av5WumvJhy/TS8CUUjIS3MYi4jCvIX+j
 VtPvt2L10CRjkS4JT3OKxaJSqzd5YyL3ZuxQjKGKU07jIjHnDVF08gsIZCZpNJ3xnuPiRfG1oru
 TS3KDAbbKSplBba3II57xetRhHwAk5MHm5L9nEB
X-Received: by 2002:a17:90a:d886:b0:3a2:b038:c931 with SMTP id
 98e67ed59e1d1-3a6cec70e78mr4417127a91.40.1791234308107; 
 Mon, 05 Oct 2026 14:05:08 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a8533abe0asm1267748a91.1.2026.10.05.14.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 14:05:07 -0700 (PDT)
Date: Mon, 5 Oct 2026 14:05:06 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Manish Kurup <manish.kurup@broadcom.com>
Cc: dev@dpdk.org, kishore.padmanabha@broadcom.com, stable@dpdk.org
Subject: Re: [PATCH] net/bnxt: fix hash seeding and hot-upgrade lock handling
Message-ID: <20261005140506.325710d7@phoenix.local>
In-Reply-To: <20261005202519.17873-1-manish.kurup@broadcom.com>
References: <20261005202519.17873-1-manish.kurup@broadcom.com>
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

On Mon,  5 Oct 2026 15:25:19 -0500
Manish Kurup <manish.kurup@broadcom.com> wrote:

> +
> +	/* Random per-table seed so the CRC hash cannot be predicted offline
> +	 * from attacker-controlled flow match fields.
> +	 */
> +	hash_tbl->hash_seed = (uint32_t)rte_rand();
> +

No, the current rte_rand() is poor choice for anything hackers would want to know.
Need to use getentropy here. There is a patch series to make rte_rand() better but
if you are trying to prevent DoS then need to use something stronger.
