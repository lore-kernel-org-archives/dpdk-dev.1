Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D657DE9A05A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 18:52:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C770D402CA;
	Thu, 19 Feb 2026 19:52:58 +0100 (CET)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3F46D402D5
 for <dev@dpdk.org>; Thu, 19 Feb 2026 19:52:57 +0100 (CET)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-8c710439535so92035185a.1
 for <dev@dpdk.org>; Thu, 19 Feb 2026 10:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771527176;
 x=1772131976; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VG2W0+MTHriylq4hvEMVkdYsB2mUZmwzKo9cdeLWafA=;
 b=EnftCwzAcyTt1XorLv4B/26is5bf+XfOCEe+UytzXFqQGmmjAFsYeyKnY0b9VtFg58
 qYJKmAf5fa70+wyi5wT9/O2ZPbYgQcmnKu+3cTgb6KYmF/TfNiEXv/+wCHIJf37B1tT4
 AN6obsgnVB7/NPTlHW80guomgLELS6QC2sQYPAjNtjcuB2jP3XZa5dF5jE/PY/n+oeF5
 6D8TGpOtzkqzIP6Zg+zFRZpYGEP4PUpHnrDxawFQ+qs4TlKUepxS+7Ap4VZtvdm221KZ
 MtwVv63iHngke6QAmsFgThGUMqbyh86HAIcBzU1sqnwGtFmayMSC2CGE/vinC5sV+FwE
 0Wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771527176; x=1772131976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VG2W0+MTHriylq4hvEMVkdYsB2mUZmwzKo9cdeLWafA=;
 b=DthuHGNZUeLbG6p7z5xO3Qvs5cN9q39wnEHj0w1FMZHXayYlMNJyrZCLF2JqjVuz+d
 Htcfzu2vnBPm1M+LZYK9hqDGgmMldBex0wmzaVL1XBTZ1lP5EuB3WXyyyv7XDG2T25Yr
 y3tcdOwyHzm7p6BzTVdwG7mpGJyfrGK8Lc5PNA2E4t0UL6zVEpbO22r7acR23X9aBwxe
 kMNLny3uYFr6n8D6rYIPFTEKI57VbacGGIztkpR75oHHLepxDe4W4DY+Nv8T5doXfjj+
 q6PfUleXFVg6gFjUnMVHa1S3zgldQvMZmVcEVTUt554rs5jN1xfBMbZKO1ngIVNHrazW
 tY+w==
X-Gm-Message-State: AOJu0Yx4BFIw6YpbETuySvQrWOI/X1I9O0EKRXoc0sRthsWthoX1ZSAM
 p1YydA8S0lYELwOT9L9dPKdpNnX7Qlhe3Pk4kOu1KuI0ITvafi9b3OzHSoRIrk89sdE=
X-Gm-Gg: AZuq6aLkt0ApFCHniOQNaaqQkQqa4PAH4P1rpMCswvGFGh8For0FVO/JEo6VDprFYan
 SlFboOYNBOglGvQWBDgZ211RsxRPzHHMzxp2yAeY991ESZj3UoKPlWzW6WzjlQLr0EtT0txUDcY
 cF6r4TrCF75YOtjVQq9bjDNA3tV3066RFdo/44G8EvRY+Xsc1BFHedv17bz6KiiYTGOEiF4gU/8
 YUGB11Qw+9v4SEkFPHmgFH4mqF7EyTVWT4zGbogn3gX9fxygEms6AKeGdXg4i1TzHjdFEZvLyvS
 5XVpSRl1utSipglWdfi8+CRt7w8dPdJTaFl4SK2IXWfYfkN+mnTZzmDTQsLKNdDxHpLxVnOq+xa
 28BMLTEJivMfzJLcxYR+JdV1y+XOgLZBWtzY8r9AVPkAHb2kTyxIDMEQkz4PdzAxKsFr4zxgjiz
 XElA+72xTWLOqC+aMClAvDAA8Srjcb2LY4IQiFAsi3hALD9uyCDbxrINADDwr0dUtU
X-Received: by 2002:a05:620a:318c:b0:8cb:3870:5c1d with SMTP id
 af79cd13be357-8cb74032920mr747051185a.27.1771527176089; 
 Thu, 19 Feb 2026 10:52:56 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cdc18dcsm222440956d6.47.2026.02.19.10.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 10:52:55 -0800 (PST)
Date: Thu, 19 Feb 2026 10:52:52 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kevin Traynor <ktraynor@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, david.marchand@redhat.com,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, hkalra@marvell.com
Subject: Re: [PATCH v4 0/3] interrupt disconnect/error event handling
Message-ID: <20260219105252.2b807358@phoenix.local>
In-Reply-To: <20260219143852.200722-1-ktraynor@redhat.com>
References: <20260128122055.192104-1-ktraynor@redhat.com>
 <20260219143852.200722-1-ktraynor@redhat.com>
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

On Thu, 19 Feb 2026 14:38:49 +0000
Kevin Traynor <ktraynor@redhat.com> wrote:

> These patches are to fix some issues with epoll event handling for
> EPOLLERR/EPOLLRDHUP/EPOLLHUP.
> 
> 1/3: handles these disconnect/error events for interrupts that are read
> in eal
> 
> 2/3: provides an API for interrupt callbacks to get the interrupt events
> for the active interrupt
> 
> 3/3: deal with the observed issue as reported in
> https://bugs.dpdk.org/show_bug.cgi?id=1873 where mlx5 devx interrupts
> cause a busy-loop and 100% CPU of dpdk-intr thread.
> 
> v4:
> Updated to allow for case where devx interrupt handler may handle
> multiple completions during one interrupt call, leading to no data being
> read in a subsequent call as flagged by Slava.
> 
> - 1/3 No change
> - 2/3 New API rte_intr_active_events() to get interrupt events
> - 3/3 Use new API in mlx5 devx interrupt handler to detect if
>   disconnect/error events and if so unregister the callback
> 
> v3:
> - 1/2 and 2/2 fix some coding nits (Stephen/AI/David)
> - 2/2 Make log level consistant (David)
> 
> v2:
> - Only handle disconnect/error epoll events when the read is done in eal
>   interrupt code. This is to allow interrupt handlers like virtio deal
>   with disconnects in an appropriate
> - Detect if not data is read in the mlx dex interrupt and if so unregister
>   the callback
> 
> Kevin Traynor (3):
>   eal/linux: handle interrupt epoll events
>   eal/interrupt: add interrupt event info
>   net/mlx5: check devx disconnect/error interrupt events
> 
>  drivers/net/mlx5/linux/mlx5_ethdev_os.c |  20 +++++
>  lib/eal/freebsd/eal_interrupts.c        |   7 ++
>  lib/eal/include/rte_interrupts.h        |  23 ++++++
>  lib/eal/linux/eal_interrupts.c          | 103 +++++++++++++++++-------
>  lib/eal/windows/eal_interrupts.c        |   7 ++
>  5 files changed, 133 insertions(+), 27 deletions(-)
> 

Series-Acked-by: Stephen Hemminger <stephen@networkplumber.org>

FYI - AI review gives long winded version of "this is patch is good"
The only worthwhile feedback was that there should be a release note for
a new API.
