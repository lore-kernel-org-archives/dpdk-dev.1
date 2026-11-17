Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65331606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gaE5vF4z
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 254EC402C9;
	Tue, 17 Nov 2026 19:55:43 +0100 (CET)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTPS id 6AD11402BF
 for <dev@dpdk.org>; Tue, 17 Nov 2026 19:55:42 +0100 (CET)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cdac6d19ddaso91167a12.2
 for <dev@dpdk.org>; Tue, 17 Nov 2026 10:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794941741;
 x=1795546541; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KJVxiShJy5KXPYxwcRUwG4Ww2mgDR5m8vTMm2a57Ee4=;
 b=gaE5vF4zjyDCp7BuHAFtREdSBTxYc606KucGc8JSm1+7z8OerudINFpboc3ueKgVpt
 lfwAEvzeGNGGWAKa2Avxs54bae/Sd0MPYPZH/67JkG9C8Ed3yGRAIXnUVSM4WiCqWU8U
 R9JbHJqbcdrFaCPm8ctqGwGqgjEz/UUcRCcFWsoenDP56mSx9naO5m0hU/r+XBcoW3qt
 qqB70FNmqvuvc5AxPNgmck2Ko24oSbVkVV4rCU977epqkhR9MxhCk5W+JpqjG3+mjyLV
 r+dzDnVf3b3QK7B9XZ/2mxO+VHv6GNY3WCyceQK4MCwRyB9lh+jY0VsM/3nR23qJCtT3
 Grnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794941741; x=1795546541;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KJVxiShJy5KXPYxwcRUwG4Ww2mgDR5m8vTMm2a57Ee4=;
 b=vv/7wMq1BKcDwg+E/0iWCLtARSeY/OfzNWS4ZlG9PHjiRBxL0UBukt6aQbPYzSRC2H
 kb01tnUqj9cYcv1UHDo1se9X+AFVfmbFLWUgcmqda7SYYlhirHzuH/eW370vTBLDmsIu
 WKdvBsu3pFuUfZTxS+rvrRcKy5vfC6qDqs25KKHNi1PRykYKptFBtMpu455hYRIL9xy7
 82U1k0TZcIZbBiGwfUwNVTbqWdUvEj+vDBBJQ4Wo+Eq/G6c8u4BTN2FwbMgYWoiEDfJ8
 IV5s47+SLzOPcLYROt1rUfewnRqe1ndJKRE5DAEU73r4VI5TjrMaWv3kpjM6ZgPLacXc
 jzMQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFQBK9PObi/L6EQKnPyhlb7DcZUSMKTa1g606gqeMLzyC8VxFNWuaM0Wg4WQTGTvn0xbYM=@dpdk.org
X-Gm-Message-State: APuU4Z9E0QEBR9Ovi0MxgcUJtPljqfYv2Rmwx8GiWKCLV5ZJknwl8ZB4
 kMfBibxRLztFG4TcT0SD2Vlclg0Nz7FHbGg0Nv7PEnfmj4Ro3zAXmkw+sAGiKOTwvnI=
X-Gm-Gg: AZFdTZcpd3Pp/wwNLlKmsI4nnSQbKxuW/ulSBCayRFKeZW8vwXWIBVctUhEKUgAK5NX
 TpyVJF4yZfF5HT3z7clbCPxdwGjCALKPq4b9nTGpyE+xfAS8DoH5xUpRZBC7de7klESKsni+PlK
 n3Mss0qCPdMMzzFsvAlyMXLCO16QECpjhuvCZFnRlICVxB/f6xZgSFaA1zLTppwmNhDVDkF38M5
 tEqA5hT39+Ut67hSy1vwZRCHoy0hjX7vx9HRwdZnEz+Nj4jqhBlXudyBb+ddQOEYVov3ICCFVkq
 JvojG1tv7cK9z/8e2ELH4a4troNkpa0Iy2N/3enZCEn/ip9LDTdBstvzB7YemfvW/5auVrBUht2
 qm9fogyQ3kOdXKbTlQM8iFmz85TgNnc8o2BAerIHfnMWl3gjija86I71QNaxJCr6AaQ/eFE1cvB
 hgr2bWW3OMx5LX9oopInBteKk33gKqy/H+fGiQmCk0tcpP2nbaRWCqDg9GaKPXIcQ9YRE1yGanl
 Eqv13dKLihgwNzR//w8yPP9BdgNf6osKPyrXKCdTBdbPWUcab0bxlv1hcpIUetT4A01N7t0PVOs
 h1Aow7NwL7KM7wb2HhLjW+hASgAob3Xzfd6n5IkhfeFUUtTbZZwhkHqza9glp7s6URe4KnVFAQ=
 =
X-Received: by 2002:a17:90b:5348:b0:3b1:8300:f48f with SMTP id
 98e67ed59e1d1-3b3d07db942mr293706a91.51.1794941740615; 
 Tue, 17 Nov 2026 10:55:40 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3d1c03e04sm234456a91.15.2026.11.17.10.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 10:55:40 -0800 (PST)
Date: Tue, 17 Nov 2026 10:55:38 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mark Bulatov <ms.bulatov7@gmail.com>
Cc: Chaoyong He <chaoyong.he@corigine.com>, Niklas =?UTF-8?B?U8O2ZGVybHVu?=
 =?UTF-8?B?ZA==?= <niklas.soderlund@corigine.com>, dev@dpdk.org,
 stable@dpdk.org
Subject: Re: [PATCH v2] net/nfp: fix wrong argument order in nfp_encode_basic
Message-ID: <20261117105538.1a1adc56@phoenix.local>
In-Reply-To: <20261116172037.5347-1-ms.bulatov7@gmail.com>
References: <20261116172037.5347-1-ms.bulatov7@gmail.com>
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

On Mon, 16 Nov 2026 20:20:37 +0300
Mark Bulatov <ms.bulatov7@gmail.com> wrote:

> The function nfp_encode_basic_qdr() takes cpp_tgt as its second argument
> and dest_island as its third. However, the implementation of this function
> implies the opposite: dest_island should be the second argument, and
> cpp_tgt the third.
> 
> nfp_encode_basic_qdr() takes dest_island as its second argument and
> cpp_tgt as its third, but all callers in nfp_encode_basic() pass them
> in the opposite order. As a result nfp_decode_basic() gets the island
> ID as the target, and the island check compares against NFP_CPP_TARGET_QDR
> instead of the requested island.
> 
> Fix this by swapping the arguments.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: e6858e7e7cd3 ("net/nfp: move shared target logic to own file")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Mark Bulatov <ms.bulatov7@gmail.com>
> ---

AI complains about the commit message.


[PATCH 2/2] net/nfp: fix wrong argument order in nfp_encode_basic

Warning: the first paragraph of the commit message is wrong and
contradicts the second.
  It says nfp_encode_basic_qdr() takes cpp_tgt second and
  dest_island third. The prototype is (addr, dest_island, cpp_tgt,
  ...), as the second paragraph correctly says. This looks like v1
  text that was left in. Drop the first paragraph:

    nfp_encode_basic_qdr() takes dest_island as its second argument
    and cpp_tgt as its third, but all callers in nfp_encode_basic()
    pass them in the opposite order. As a result nfp_decode_basic()
    gets the island ID as the target, and the island check compares
    against NFP_CPP_TARGET_QDR instead of the requested island.

    Fix this by swapping the arguments.

  The fix matches the Linux nfp driver, where all four callers in
  nfpcore/nfp_target.c already pass (*addr, dest_island, cpp_tgt,
  ...). Saying so in the commit message would help the NFP
  maintainers confirm it.
