Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A4AC5AD44
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 17:50:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2ED0C402AA;
	Fri, 20 Feb 2026 18:50:49 +0100 (CET)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42]) by mails.dpdk.org (Postfix) with ESMTP id 210D54026D
 for <dev@dpdk.org>; Fri, 20 Feb 2026 18:50:48 +0100 (CET)
Received: by mail-ot1-f42.google.com with SMTP id
 46e09a7af769-7d4be94eeacso2025535a34.2
 for <dev@dpdk.org>; Fri, 20 Feb 2026 09:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771609847;
 x=1772214647; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=yEnu27qmGLRAlmc6EaWM5ai7c7jr/uh0Q5m88XRPCP0=;
 b=C1SY8LYyi9nsuRCyTzFlT541cZMudweTnc4RcwY5Car+WSAccbKCf7923cTDVPCOMh
 azHyp1a9wsaL8BKcSC9xXUQSCcgDbLL/gOgHCfaGZec3jeRiXqru3sUIMy7ztcGaLTca
 xZCzqm3ubLHpsXuNuva+/1gfCdYY1Lr/b6DWj60UoY2OAk3wkzRu2ZxPkDfh/lpBz3Z0
 9zZPWB7MGIoqDheeZWktmNo18MsjhHOKaPGrll37jj/uQyakOYc4GgRzut4U6/LojbuU
 gCiIEwUKyFPmJjDqsIS+PmF2CrJs6FQBMugJtEZBxZ3aw0Eki5ByrVHzoli5wpPavrKo
 80Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771609847; x=1772214647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yEnu27qmGLRAlmc6EaWM5ai7c7jr/uh0Q5m88XRPCP0=;
 b=bSn9dx+SsNQ1nU7LGwguFgVr8POHoOBdRVmSqGLNrlXjX2avLdNwfy12+8sx+mjV5i
 qDDvjK45UA2GCw/CRm2WIneKthra0KD/ulYAHkJygOeSP8vgcXOPZsjujSXe8qwjtLos
 3feN7GMw+4SGFpo4+sQ/RwQ7btjAUbV7eiFyYhqSrZpgkAJD2JZrpQgQ95LEEGtScdoC
 UtABuBe1G4qMyXCX4BODOP9FpaghdLjXaH0kI9vNWs0NDaaMzd0Ve7R4oUE5x1EKdq6y
 BtzBSduBY8MfxwoxQqimJuLWBli95hjPgyzMNXVq3ENMunHSpCjLxLBvzjgoPCoKUJ+I
 V0KQ==
X-Gm-Message-State: AOJu0YyLBjvTscj1qMGMvy7RvtoRlrW6K6zZmYYKqIKKkOsLFh277Nt4
 5Pj+RiBosh279N+87vh8HFA/MrlLphFUWUTw9jN6Dvp9UlUWiX/3ektLf+gbWAUF/e508wrqRtu
 PSUQc
X-Gm-Gg: AZuq6aL9ZZwnAagipJh0JgMKvw/TGzxYoeqPwnhOMOLkS4Kaa5WqIF5paAY3SroD6YL
 1+CwkwzNaVv5/nNucJ0wnQvYJbTwCjiok8f6okS4gqlHkPqUwM0lkjGwq3a5GHUAnBvUGQxGAOK
 LnuUr+b2+M5bHeTnqjusy+vgFNOBjQ1z+6w69IqcQSN0/XcGOLS1Ywc4FwAs34AkgL/7HWo4fHQ
 9Aj4FZeR9kLslsUJSXJ4yaulcG2Yu9iYG1uI/lgYnL9aqWvgokAxJu6jTGCws+n+GspWiMOZ6hy
 6azZKwRHTSWir2TrT10ltVDr6LWUn38iQxeMrHp6xahvj5BsOPH/mSkPR2NYprMzQGi7rL91BzN
 ZW0nX9+BeUidYGuQhEBt3J7qmz2zHhcdOoXOV2ZCRwEFWkCARj7KhEPaDkjKLCx5N0fApjOfsYh
 JbBs3hhLspyVCVqxXK3LFY2bQsA0K5k4v1b1y52uCMFx1bC6E3fZp7myecXlj+9xPk
X-Received: by 2002:a05:6808:c1bb:b0:45c:7c9e:854f with SMTP id
 5614622812f47-464463fcbb7mr517282b6e.58.1771609847207; 
 Fri, 20 Feb 2026 09:50:47 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4636b0ccfe6sm19352050b6e.20.2026.02.20.09.50.46
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 09:50:46 -0800 (PST)
Date: Fri, 20 Feb 2026 09:50:44 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH 0/4] net/axgbe: fix resource leaks and OOB access
Message-ID: <20260220095044.1b36befb@phoenix.local>
In-Reply-To: <20260218164324.915065-1-stephen@networkplumber.org>
References: <20260218164324.915065-1-stephen@networkplumber.org>
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

On Wed, 18 Feb 2026 08:40:58 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Code review of the axgbe PMD identified several correctness bugs,
> primarily around resource management on error paths in device
> initialization and an out-of-bounds descriptor ring access.
> 
> Patch 1 fixes multiple resource leak paths in eth_axgbe_dev_init():
>   - mac_addrs leaked when hash_mac_addrs allocation fails
>   - hash_mac_addrs leaked when phy_init() fails
>   - rte_intr_callback_register() return value unchecked
>   - DMA reset failure via hw_if.exit() logged but not propagated
> 
> Patch 2 fixes wrapper_rx_desc_init() which only releases the
> current queue on mbuf allocation failure, leaking all mbufs
> from previously initialized queues.
> 
> Patch 3 adds pthread_mutex_destroy() calls in axgbe_dev_close()
> for the four mutexes created during init.
> 
> Patch 4 fixes an out-of-bounds read in both Rx and Tx descriptor
> status functions where desc[idx + offset] can exceed the ring
> size. The offset is now folded into the index before masking.


Waiting for ACK from maintainer. I don't have the hardware.
