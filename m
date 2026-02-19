Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C998E9A05A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 19:00:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD69E402C6;
	Thu, 19 Feb 2026 20:00:55 +0100 (CET)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 11F72402AC
 for <dev@dpdk.org>; Thu, 19 Feb 2026 20:00:54 +0100 (CET)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-89473dca8aaso15520696d6.0
 for <dev@dpdk.org>; Thu, 19 Feb 2026 11:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771527653;
 x=1772132453; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lf3xeqTbTLVSnxuj84uHoV1/Qpqnz/gJiNyF042g00E=;
 b=cm3xVUGpZa6sBPcyh/OdjbX0mvzEtmE3sNMM3oBQdGyJ5qJf9DyXpbOZwpIeREA1S6
 LcyQGoqTMWTlcSihZefDWnWvCeiKVWTOKkGUyg3H/zkzOBiBc/oxqqV4eUG9iHhyaa6X
 jhOTQ4KmwR6WnE6siAINGsppDv+pmynvDyFjxWS8wI+IsX2FCFuXJdmSJgghP6tqpFTC
 7xcOpw61qE1KH26xzk014LDfrL+1T0aOuNsibUwNoTFPpUeOWcuiuQEZFIF5XOhcvspF
 g8IGxtnH2Hz0dM7/XnXd0MAcaGyQkVvlJLTyibgAaii+oABJHT7XmNvpcMaswlY5WfC/
 9d6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771527653; x=1772132453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lf3xeqTbTLVSnxuj84uHoV1/Qpqnz/gJiNyF042g00E=;
 b=aTGg49VASsqRsypbhmjZngUfHtyirPn1VpFCznWFliD9vXYT0FiFQinLHwj8nkdVy5
 aRlBpeLEYAz1tXgMZ59JXAXfbdX4UxIFb58fpC9qayLJptmCmnpVwpk/iafmYNoY0Fyb
 WMQXY0ZTewH2PkOdNrjyCdkHGTP+P1ek5zHHz6YuvoU2vkLZmJ8r0jfokTDT4OsQ3FAB
 ICix72fnYkQoSADmX/IcIcu9KXQhLtdrZmE7algwFWqSjafRZSIEA91Ed6P+3wOZlyw+
 ne0epUI75735u9VCDdkztpLZuDRDh62eULyaojCKtXGMGdG+JhHd/F87CjIdTe7RnPKl
 F/WQ==
X-Gm-Message-State: AOJu0YwPVLCUHcoNqxDSobl1Ob1hSPlVI/klucZeTS0K2x7pOQELkvYS
 a915Me4veaNF5lf03s55s/Xg9wP5b5+8kNVSQ3nIqjj7c4E7TvznEQptvzB4juviwd9LaxuZbNN
 kG4uc
X-Gm-Gg: AZuq6aLFS2C+srcjxJa59Y726kUiHoxRsTaPw72YKXg7ZjrY4A6NzUT3JdUx5q/tR+E
 3o2Hgn+8Zcsh67Ig//grSEY0WtBF4xQ2tid1Z2R9MVND+r+M2XK8aX30h725862e230xtLF+OFQ
 awqzDOhpwF3M/t1kgazVaqrry874SITIvHnQN8z+FUdL7kWNoiDn66OmVenWoIZxDqTwR03Mkyw
 wtn0/wAKMcarvMonp1Gg0BnAHsDZxk/MW0pUsipHOJTjXn4OOyagINhcsA3VeoVW/3gdFOcBOrD
 wQL2yb0+3dU8wVf5pxhoGXmvTgVLaJU0Jnls6tdB3qe4+YMPKlCLmxbotnJ1ZZwPtis38qCXQm0
 iTs0Pi+n7lbin5qe+Ze63xR2NNpeZdX9A5ajOGuY/LM4s1bLU9YqyzMgCl7ZhN9qlteGiBxuwyR
 vX7n+U6ObgVyRInDxTyJ23zHyd9tP7pp2qzrP9ZuG1NShCUgGLLrkx3USlTViZR7sL
X-Received: by 2002:a05:6214:27c9:b0:890:6331:7e88 with SMTP id
 6a1803df08f44-897404842fcmr292239866d6.44.1771527652941; 
 Thu, 19 Feb 2026 11:00:52 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cd8a5ccsm222611376d6.25.2026.02.19.11.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 11:00:52 -0800 (PST)
Date: Thu, 19 Feb 2026 11:00:49 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v2] ethdev: clarify rte_eth_tx_burst() return value and
 ownership semantics
Message-ID: <20260219110049.60743444@phoenix.local>
In-Reply-To: <20260219004449.114564-1-stephen@networkplumber.org>
References: <20260216180011.393782-1-stephen@networkplumber.org>
 <20260219004449.114564-1-stephen@networkplumber.org>
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

On Wed, 18 Feb 2026 16:44:49 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The documentation for rte_eth_tx_burst() uses the word "sent" to
> describe the return value, which is misleading. Packets returned as
> consumed may not have been transmitted yet; they have been accepted
> by the driver and are no longer the caller's responsibility.
> 
> This matters because the common usage pattern is:
> 
>     n = rte_eth_tx_burst(port, txq, mbufs, nb_pkts);
>     for (i = n; i < nb_pkts; i++)
>         rte_pktmbuf_free(mbufs[i]);
> 
> For this to work correctly, the contract must be:
>  - tx_pkts[0..n-1]: ownership transferred to the driver.
>  - tx_pkts[n..nb_pkts-1]: untouched, still owned by the caller.
> 
> Several drivers (and AI-assisted reviews) misinterpret the current
> wording and treat packets with errors as unconsumed, returning a
> short count. This causes callers to retry those packets indefinitely.
> The correct behavior is that the driver must consume (and free)
> erroneous packets, counting them via oerrors.
> 
> Replace "sent" with "consumed" in the return value description,
> spell out the mbuf ownership contract, clarify the error handling
> expectation, and update the @return block to match.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
> ---

FYI - many, many drivers got this wrong. Only a few seem to get
it right.
