Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05797CA601E
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 18:23:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0007140274;
	Fri,  9 Oct 2026 20:23:03 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 4D8C94026A
 for <dev@dpdk.org>; Fri,  9 Oct 2026 20:23:03 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso4829213a91.3
 for <dev@dpdk.org>; Fri, 09 Oct 2026 11:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791570182;
 x=1792174982; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wnSjDFipuK9MxWX2VX7EMR9+ghlzghDqF6Xe9PoXYII=;
 b=cFknZdTv3DZTuzHqLn/uyGvQblCHOxlpazIgZb0TaWAcMC8ssuKnqHYyk1xP3GFHLW
 rN8E1NsG6INRZOGXL7WalLOKoTq2CLPR3Z9pA2a8oonOTqlgtUY3p9wvQI9qhW/zY/91
 K/UIC92tDcXQffBx+Bv43eamwsf1KvBT5DOiexlAyTuxw4G6D51k82VcJep5QTG5Ood8
 5OlidW9G6iJi7Che7CQutbiZKZglSYdfg4/X56MUBL8cE9dTvh3YCQj7MlMJKomY8k54
 2Fy1xx3kr1BUIL5mdkXVHkqgEvehwdIz5c2UbaSPeO2hiWbNkbr5U+OZBZt1hXKHrBoS
 LBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791570182; x=1792174982;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wnSjDFipuK9MxWX2VX7EMR9+ghlzghDqF6Xe9PoXYII=;
 b=eBndbEr7eOSYIiIC9BRYtHbvuK7ZkoW3yptYOnpjf1gzw6DfC0Nh2EAzN/UX1MetKH
 yFArVXgU0nzSm17EEBgnxcavD3lTZyXg12fayyZxpnxSUN9Xlhs2u7GmJSEQG1QiMo/R
 ijJ/ZY/wjMf3SQsbacnPoAhiel3Y8N+P/6rmg3Ayj4AglTZne2BSiwd9l7ZVZ9PCdljG
 5n1y+TJ2fgZazTbI4+FlmySN7CP+tJjZSygbTNZB/E4Vh5/GP6szflMmTJzKtUhcvoI/
 6wSU2NGskvJCjp/xO0n2vuZrIUJN6jYPbu4ohlDMyZGvecz/5SkV81NQvyNUZZANsizG
 kIxw==
X-Gm-Message-State: AFq9FYIlNAN1L2VhVgW3EqEuChDxiHf75aZBLRxORZOIOMg6Uh/UhwPP
 69We1+ErwTcluTv6mv3uK8JDSTNJ/2plqDIoTdFJuRVoEVFcr6MUaQfeIp3JfQRLJgU=
X-Gm-Gg: AYBFou1V9MP5cY6fC0LEJveIcfZg5AOe/mfvzWpjRiUG0NtDwb08rtuhq0Tl1xxpYif
 WzL95W/AY9Da8anHxhkXQpeO4wYkGbOoPPv7bszUk0g+d0jOUOYb39oLmqZeyxtoVh8HtCGaCgv
 ye2QAunPorvnnpUA/MbCJ70xk027z/nMuB8lmCBQ74ce1zrgFVY06t9zUqNppd8O6Lr7EY5slEj
 1i6c2t4TaryflQ2JJyyS1gJ99HlO6FgaCVpq9XXfkVmy4ruQvWFJhWkVuam85T2ix3ZebGjb1i3
 RnCSgdc45fIEUF0JH5RGgU4ed2GmLUPELphyVJl7iky1TB4Yfbc/VBNAo9yv3X/lpx1GY0M304x
 t2J1eVZG2jr3sPqh++lrxksBtc564Y9Cyr+nZan8j5b4dWETT6PwGj3xCxleKFGgiEZV4OZm/WL
 07kp8mMXTOb5fwpixok5YhVhIR02KFWsh53xqvanjVZG+DizoP9h887s4/TCGttOCGL+1iJUZ2u
 fXaV5eKCdMfIhjHOP23LlwjFZ2iSrR/bOa4DWd5
X-Received: by 2002:a17:90b:3b52:b0:3ab:1481:2fbb with SMTP id
 98e67ed59e1d1-3ab3ae439dfmr2515328a91.59.1791570182044; 
 Fri, 09 Oct 2026 11:23:02 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab38fc9e52sm4509496a91.13.2026.10.09.11.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 11:23:01 -0700 (PDT)
Date: Fri, 9 Oct 2026 11:22:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Roman Khromenok <roma55592@yandex.ru>
Cc: dev@dpdk.org, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru
Subject: Re: [PATCH v2 0/4] ethdev: report module signal status flags
Message-ID: <20261009112259.2bd9debc@phoenix.local>
In-Reply-To: <cover.1791482259.git.roma55592@yandex.ru>
References: <cover.1791447600.git.roma55592@yandex.ru>
 <cover.1791482259.git.roma55592@yandex.ru>
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

On Thu,  8 Oct 2026 20:02:34 +0200
Roman Khromenok <roma55592@yandex.ru> wrote:

> The module EEPROM decoder shows the identity and the digital
> diagnostics of a module, but not the signal status, which is
> usually the first thing to check when a link does not come up.
> 
> Patches 1-2 report the SFF-8636 per-lane loss of signal,
> CDR loss of lock and Tx fault flags, as ethtool does since
> commit 045d8db ("sff-8636: report LOL / LOS / Tx Fault").
> The code is written for DPDK, not copied from ethtool.
> 
> Patches 3-4 report the SFF-8472 Rx_LOS and TX_FAULT state
> from page A2h byte 110. ethtool does not show it, so it is
> split out and can be dropped independently of patches 1-2.
> 
> The SFF-8636 flags are latched and cleared on read,
> so they report the events since the previous read;
> the SFF-8472 bits are the current state of the pins.
> 
> The series depends on the module EEPROM decode API series and on
> the testpmd decode command, which are in next-net but not in main
> yet. It is based on next-net/for-main with patch 170851 applied,
> so the release notes entry no longer conflicts.
> 
> Depends-on: series-39436 ("ethdev: add API to decode module EEPROM")
> Depends-on: series-39455 ("ethdev: fix SFF-8472 external Rx power calibration")
> Depends-on: series-39480 ("ethdev: fix SFF-8472 calibration overflow")
> Depends-on: patch-170851 ("app/testpmd: add command to decode module EEPROM")


Applied to next-net.

I wonder if the eeprom really belongs in its on library, really it is not
part of standard ethdev.
