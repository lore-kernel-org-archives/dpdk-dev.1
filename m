Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47437D3CC82
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 23:00:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 297A9402C3;
	Thu, 15 Jan 2026 00:00:46 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 281B1402A3
 for <dev@dpdk.org>; Thu, 15 Jan 2026 00:00:44 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-430f2ee2f00so179506f8f.3
 for <dev@dpdk.org>; Wed, 14 Jan 2026 15:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768431644;
 x=1769036444; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8aCvP3l4feZOozxHpNx3Zlzto48KirI9YXvkqYW14mw=;
 b=ktfMiGDzid0/qXhyuXI4jXlggkEO++faVrNRF4+cyg0IoUQYjc2kDR9P6yvyDCVw8g
 PQADjy9c9uBcz00KztWVZ8qn6ISNdOL85PN3l4EVTJPcVzwHeX4mcmAQIlRWb4bhxa/F
 brQc3shHSaqQrUPmj7PbH86HEztRujdeJJoiD42ajmVDSz66tedEe4QVelECr7vJWW58
 vPwsfaLISBxGYGXDaY2Ts4fclZL5XZjaGbbG0YJxsthrrUgtrCz92QZEzE40tyFUXh8K
 B+G9SEFeMOkpa3pPLS3VD+mE+BdWp8ODB1EsyIpYDQxwx3jx7YuJ2M+hdUJB3GJk+Gxr
 gYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768431644; x=1769036444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8aCvP3l4feZOozxHpNx3Zlzto48KirI9YXvkqYW14mw=;
 b=rECzzdvrUaDZeIHNBLZk2svd5WNAm6SJ32fED1zJ9NeSYMvYN4/YRfY9xGOHn1ruzW
 C8/HZ3NsjsKRaLMLpBFyRl86xOYB97FnaPdsmjIrkAAMqJ2LrEJNXNqi9wEVIyvmCv57
 q6t2L6RCCEkIO2jUKuDt9W7Qa1xpWoXdyQuHUMbtlcB9GXh+I/obFNsM6LOW/p1DciM2
 UKCjMvybFaezfNq72td9ciOg29jrc5IW2NbYb16sXBVQtkXamrivGpEDxMk+lmdQK6CR
 B/wEZ2P6n8eqP4h7cXXdfOzvcw1Lyr/TiuIawr0e01iqGbmRa2R1CQ/HPUHbnd8mIcHz
 LDDw==
X-Gm-Message-State: AOJu0YyrFJPmNyBSggtHsulZ+TknO4/sEWhYz/QBC/TK4LQ45o2StD+0
 myVfMnlwa2UqTnea4MnJP+/a0VIggz8xO5hJqPINoKkYG72ZS1kSP9okEc4DI8AetiCv9UCFC83
 9V4tu
X-Gm-Gg: AY/fxX4+z5p03Ds7u/t6jO8+Uu2WlfJGu9in/qYhKoaaWBuHVt6ZNHKQ0pkLAVyV85O
 96h6VHC11jwisqRSwl3NJxPC1vdmd4ITlUn3HW2y0bWn7ecaSvGlHdsKA0PwALI90EgsXQdVG0P
 sO0NfDnhA/Roy2ZXZSbjStShEX5TgY/ReYQC0T2328qbrTwIgtuKSDHwUNGKsAGnUI9RFdf1r3V
 RxiwQwfn2e4UEVYaiHv/Fp2EDXX6KXHxtrp/7dHjiBG/rHwf4Dyu/TDP4LjZcCP7ctFUB8NYEhB
 ymK27Ng/TMLlYcbvRRiCcYAOSjvEqH+cpybxOEWxex/Pwk2/9EBbPAwpVuUZbdPjFrYznjvq8wd
 rzkR9BfWWc+cMrcEp2COTk13TS4hZtJgAOipric1K1uk5Stnzv7KG5tseYjR2GZV6WMvnjqtWG7
 f/3cM6wrwuL8p6FtRDc2pza4vBPESj332f/nUMkgpWPxm/9K6HANNrsxfK81FxA9U=
X-Received: by 2002:a05:6000:2385:b0:431:3a5:d9ae with SMTP id
 ffacd0b85a97d-4342c3ed51cmr5157051f8f.4.1768431643776; 
 Wed, 14 Jan 2026 15:00:43 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af6b29cfsm1865278f8f.27.2026.01.14.15.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 15:00:42 -0800 (PST)
Date: Wed, 14 Jan 2026 15:00:38 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>
Subject: Re: [PATCH 28/29] fix ipsec gw
Message-ID: <20260114150038.71c05e9d@phoenix.local>
In-Reply-To: <20260114222458.87119-29-stephen@networkplumber.org>
References: <20260114222458.87119-1-stephen@networkplumber.org>
 <20260114222458.87119-29-stephen@networkplumber.org>
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

On Wed, 14 Jan 2026 14:22:09 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> ---
>  doc/guides/sample_app_ug/ipsec_secgw.rst | 183 ++++++++++++-----------
>  1 file changed, 94 insertions(+), 89 deletions(-)


This should have been squashed for merge. NVM
