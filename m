Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53D8C9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:02:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9FEB41132;
	Tue, 29 Sep 2026 18:02:34 +0200 (CEST)
Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com
 [74.125.227.168])
 by mails.dpdk.org (Postfix) with ESMTP id 4D8C840E0A
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:02:33 +0200 (CEST)
Received: by mail-pj2-f40.google.com with SMTP id
 98e67ed59e1d1-3a2adb9bc3cso1502590a91.2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790697752;
 x=1791302552; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J3VYneiRjtNFN7hciI+YR3B6n51LMgEIZu1pdBO0fYs=;
 b=Vb+5lC8h2OjUwPAWterZf30Sz9wBMmoRlk1MlREPqlvXZVGH5n4j27WDr54aEUagGK
 V6FNldpDWjIDLKorGXGgIPPBczwdn+T/GI6eMPVLdUZmJvPXTJ2y0xG4I78pPnvhU5v3
 HfPaxuHjTf7yBPtoSn7vjdxSr4f0PWbzdo02ZEd7qWmmCZxRYrfKXdRJABHxC+Ps4Ho5
 igkZdauf3oz6mSe7UjUCZgGgp+VxBz4bT54G9DrU0FR31NK2I/fO5TggRcuKTqEOZz/T
 gJx1A9MPkr/fjTauiN6fA0DUHiskMKr9SI8UqGL4OQxcBfoj8Ru1Xtz2ofnytmRZ7wHj
 8plQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790697752; x=1791302552;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J3VYneiRjtNFN7hciI+YR3B6n51LMgEIZu1pdBO0fYs=;
 b=gAikEATXGrWmpev+VtFV2++lU9uZcLEe9IEm+kId3Sm3rOHPNf5LjRokrH4PLkxLVJ
 udt5/yEz6siq+Iyi5VcUOK1dV2W6hI+Z2IOI1gE8OHO/qTlDgB+30luUxx5W7pvwOcmU
 Uc1hbKh07EW8oPaaVSaPDQAgJzcjVpYaQjGSouZuh7p3o6wHJdBBC3jDPVViPuscQxB7
 oPxHgk+wIwNiOgRKR158Uz77aFvMIaYKrVZ8Y3WNF6DDmRpBcWuhSatlwm3Sjk8Scuaw
 QJLUwfzbC/VvA7aJdONXwMsBjlj99i/dK1T8znQp7wAY2FHKyHgItxs+mzQkBRQV0Vqp
 Z8Rg==
X-Gm-Message-State: AFq9FYLOvMrJc/Tv0FU22TTbfbppFL4cC6eCQQiVnwZtinrcRdUj+GEZ
 wppIGASS7yQJB2NUIA5eUdtWgeFeRAvkL4xo8rmxhyUYmT4ZFduJaOgUYdtSnjXjfsU=
X-Gm-Gg: AYBFou3MqikVjlxdCzOBchc9iZyWnMJN0jhqeLTSpT3o3qU34aSKyIMxHzTlkWZJ6dU
 74SYnN8UWVwhOipxOFSIdb2QkIVxnBM0oyEBU93qn1750alhP6kh33wQ8DIBH5+EpFfeLBYvuEK
 AYa3wAO3aWLQV0PgBs8QPKqRxQbtl7jDJeyj0rGPBujyVlS4asmHNPuAq/z/2ZZT6rnW97VFBah
 +2g9Fc1xbQ+PLKBoruefzNRXbwClMekIhdFNDV9PPUUsnb7Npjg+f7iGka2t0WW0cbZ2ULM0hSu
 +NRHY3U0axQpeFPqpTT11aMeqwc0cqdvjysxFxL04oeH9WKDElO8BoZlgkBuDe61tFgZNdnaOdR
 EffaPJDWybPpujgjrNkgJef959sDENMmbqpZxJnTFPPnooRJPaXCc8SI3K5kqH2RleffEdLPr/G
 EAhQWNlVhvraSJTGJukeGlD9PTe+MkwCdb083mK+blp4aueAkwIpqrz+yDTr2hnnyWp5zeoJ/Bq
 umIydP4x2sca6LCfs8SUl4Y9+92IdMMke+HH9o5
X-Received: by 2002:a17:90b:4f8a:b0:39d:f08e:e6e7 with SMTP id
 98e67ed59e1d1-3a0985bc6d9mr10663948a91.9.1790697752222; 
 Tue, 29 Sep 2026 09:02:32 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a497e90180sm7059408a91.2.2026.09.29.09.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:02:31 -0700 (PDT)
Date: Tue, 29 Sep 2026 09:02:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Roman Khromenok <roma55592@yandex.ru>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v3 0/6] ethdev: add API to decode module EEPROM
Message-ID: <20260929090227.3f940886@phoenix.local>
In-Reply-To: <20260929070734.1106134-1-roma55592@yandex.ru>
References: <20260927112041.775972-1-roma55592@yandex.ru>
 <20260929070734.1106134-1-roma55592@yandex.ru>
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

On Tue, 29 Sep 2026 09:07:28 +0200
Roman Khromenok <roma55592@yandex.ru> wrote:

> Since 22.07, ethdev contains SFF-8079, SFF-8472 and SFF-8636 decoders
> for pluggable module EEPROM (SFP, QSFP), ported from ethtool.
> They are reachable only through the telemetry command
> /ethdev/module_eeprom, which reads the EEPROM of a DPDK port
> and returns the result as a telemetry dictionary.


Applied to net-next with one addition. sff_telemetry.h and rte_telemetry.h
are include in rte_ethdev.c but no longer used.

AI also saw something you should look at:


Pre-existing, not for this series: sff_8472_calibration() applies
SFF-8472 external RX power calibration as
 
  RX_PWR(0) + x * (RX_PWR(1) + RX_PWR(2) + RX_PWR(3))
 
The spec formula is
 
  RX_PWR(4)*x^4 + RX_PWR(3)*x^3 + RX_PWR(2)*x^2 + RX_PWR(1)*x
  + RX_PWR(0)
 
SFF_A2_CAL_RXPWR4 is defined but never used. The code was carried
over from ethtool's sfpdiag.c, which has the same formula. The new
test only sets RX_PWR(1), so it does not hit this. A separate fix
would carry:
