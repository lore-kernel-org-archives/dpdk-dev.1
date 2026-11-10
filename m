Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19BB60A3826
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=SqVH2vCX
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30EAB40285;
	Tue, 10 Nov 2026 16:05:06 +0100 (CET)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTPS id CAC7A40281
 for <dev@dpdk.org>; Tue, 10 Nov 2026 16:05:05 +0100 (CET)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-cd8ba7c2694so850107a12.1
 for <dev@dpdk.org>; Tue, 10 Nov 2026 07:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794323104;
 x=1794927904; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PlFYccxjbku6et8cEbL+3mG/hiWY3dm/kX4DTsehw7E=;
 b=SqVH2vCX2QQJ9/YG/wKrQSPdSZRRoGJ9iKl4LGa7hymMq3xSElMJnqw0+UrUU1uH1d
 OZzPEK+PmKkYpSuBWNlwRQDDAWCkyJ0JY97BYd/DLqs88Xe9XJOiQ+6NIY6MuyKrDbdL
 LSC5Dgk4r+ww8DkcdAvVDyVqLSZ/I5Tgt7B+h5JrZXGojy40dUUjwDJB19WUx1b6BxAn
 CRhyIt0uF1gGJgZPGqfYFDfRTbla+JKcFCzcdP0Acmy9BpZzm1mBHSlMmYS4VBWmlO5a
 JGc12Y5lburaWrqFiOiQe5U8xYkV/5qUBz/BetM3SK6F+geQJ8Ef4pfDTirGeRPe3gZ+
 2pwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794323104; x=1794927904;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PlFYccxjbku6et8cEbL+3mG/hiWY3dm/kX4DTsehw7E=;
 b=xbvZkL5YCWSmRvbWrEeD5VIqktY0JwsGeQaFYGbniaoIZl1NFh5nkGlUTwjvC3hwIb
 jjk+mZ7BUU9qRPrUdjumLFeRt/SvIwESeMvrgTP5MwC24hTkPtURLVioFuNSEfGgUKuJ
 WtqDoMjXfDJM0B1ZmwSsAC8vrcj8FPJ9yCXB0m6mxywYOrFmeA2ZhSqe38XS3uhdlGw8
 65FXQVEX1I1D43SqVZGhkhLIQyVmt+/gxZhZc/Se8zkOnCqcNSzokJiv0e2Uov3otONm
 NTrUOwqo5CbofBaJ3uHuYPdK1Gypou5+TUN2BclrId+waeQSmpBEmDsVCCEkav5d46NN
 I9Sw==
X-Gm-Message-State: APuU4Z9uujBgKai4cvQVoYn8dMVcNsknL3owlTPobeVMHVc10DgxLj8r
 0+8FnBjkey/Koeid8bzf3owHGPg/hZy1USCwZJ8WEnKVD9+K9NbXw4W8wEXq6PImQxk=
X-Gm-Gg: AYBFou1aX1RYe4Z7rbFV+NdUkRI4U4ew75JiEUQHtU0cKSiB90xWiYnHwwy6gzUfjBF
 dhtwx2/KnDqUQEXTtLUtkHoMz4HHwEzjauuYYeVZY/62BLRvNPGpnrL+ij+vWEzMwBrTkh1iVj7
 2ZC841UMyNZhl+LZTTLaotqGMsy9WR05F/YuxENUF/b4RO9Q3dBuOQU4sYtuUCA/OKyZNxYomQa
 /aCrucOls8HK+MztgYCkf4YqO2NFyZEXniV1SFFm/Mo1FfQvjku0c1n3BwXCHiQvwyxscrwxcho
 r2tXBLOkit2mg2dmJrMRwXFcIP/RlLaQP5rymx3VFg4LQpSu21GTFyQw4ds9CVbr9X2fBsgCDL5
 n/S63QTomitwJSpz+G99pk/k3/3X1dw2ty042zEZeG9N7pQbSLHTSBcqNGDSMRAZDu4iYFr8eTv
 n6zbvVp2DtVW/BIjsFobdgVzh1H654iOZnnnfl+Xys5tSGXJLscepUTBEUBbWIlgaWHxWb3G35j
 xMBHjazciKL7mA8jb4SX5nrX0geVC50f9GosIURz3rOU00jpJ/2n8SYMdlnzQ3FzMFrZxPiglxm
 GZdGiJB1i+nYpFEDWM+s18vhXe39HWiaHYI7JxwV7FCGMS7IXH05lE4wULqauI7w2MoYwbM=
X-Received: by 2002:a05:6a21:2d8b:b0:3e2:4bd9:683e with SMTP id
 adf61e73a8af0-3f190878fb5mr2583830637.73.1794323103946; 
 Tue, 10 Nov 2026 07:05:03 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baa506bca4sm1037843b3a.0.2026.11.10.07.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 07:05:03 -0800 (PST)
Date: Tue, 10 Nov 2026 07:04:58 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zhang Tengfei <zhtfdev@gmail.com>
Cc: dev@dpdk.org, jiawenwu@trustnetic.com, zaiyuwang@trustnetic.com
Subject: Re: [PATCH] net/txgbe: store flow rules without wrappers
Message-ID: <20261110070458.0be83f1a@phoenix.local>
In-Reply-To: <20261110132200.12673-1-zhtfdev@gmail.com>
References: <20261110132200.12673-1-zhtfdev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 10 Nov 2026 21:22:00 +0800
Zhang Tengfei <zhtfdev@gmail.com> wrote:

> The flow rule wrappers each held one filter structure after their
> list links were removed. Store the filter structure directly in
> rte_flow. RSS still goes through txgbe_rss_conf_init() so the saved
> key and queue pointers refer to that stored copy.
> 
> Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
> ---
 
Looks good, AI review did have some observations to consider for later releases

[PATCH] net/txgbe: store flow rules without wrappers

Mechanical change; the conversion is correct. Allocation sizes match
the copied types, every flow->rule consumer is updated, and the RSS
path still goes through txgbe_rss_conf_init() so conf.key and
conf.queue point into the stored copy rather than the parse-time
stack buffer. txgbe_config_rss_filter(..., FALSE) and
txgbe_action_rss_same() therefore still see valid pointers on
destroy.

Info

flow->rule is void *, so the casts on the lines being touched in
txgbe_flow_destroy() are unnecessary. Since those lines are being
rewritten anyway, plain struct assignment is simpler than
rte_memcpy() in the control path:

	case RTE_ETH_FILTER_NTUPLE:
		ntuple_filter_ptr = pmd_flow->rule;
		ntuple_filter = *ntuple_filter_ptr;
		ret = txgbe_add_del_ntuple_filter(dev, &ntuple_filter, FALSE);

Same for the ethertype, syn, fdir and l2_tunnel cases.

Not introduced here, but worth a follow-up: these rule copies are
CPU-only bookkeeping and do not need hugepage memory; malloc()/free()
would do.

