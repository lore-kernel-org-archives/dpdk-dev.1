Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D479606A32C
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 18:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sIFTHDlV
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BB024027E;
	Mon, 23 Nov 2026 19:57:33 +0100 (CET)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTPS id 5BA5D4027A
 for <dev@dpdk.org>; Mon, 23 Nov 2026 19:57:31 +0100 (CET)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-cddc597d062so2167598a12.3
 for <dev@dpdk.org>; Mon, 23 Nov 2026 10:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795460249;
 x=1796065049; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6t10r0RYfwtcqcscnCEuJlcDD6lJQ++lHRE8kjKffOM=;
 b=sIFTHDlVXgAHxURaG7J1gOr8UaKXJvne+TQYiri89t7QELY0idnBejyj8j1Mabdys6
 juhZ3uSLvf9u0GydF9oD8GvnDMOxXQZUTqYv26rdIsfQN+d9pGmfdWrw0haMZDPpS1Ul
 EZ5EuSWGz3Qmvq9YUbwMIbk3KJjLaoRbymIRT7kRqICxrY5Fq2YeSyjsnXdcq7hbfsN9
 drA064juAXZJTjMW+CbTtsGe1RQDH3RFFyMAfGFU67ACvTtdIZoGvCZihRawsVlcX95K
 AhCHJzOtOLomJBDzV8iu+fCWStirR7bSzHUB5c5Q/j7a3xNXRfbItHpENuP2gsGFTtxY
 w03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795460249; x=1796065049;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6t10r0RYfwtcqcscnCEuJlcDD6lJQ++lHRE8kjKffOM=;
 b=sMfJx134oTT79s0BZpf6TDdAfnLtQ4flYwByisjPxol0EA1hV4DX6bPBQwz0UoqUVt
 38qIGhz9yPHX6x8fbqL4JGjgFEhu7H35T0zSxRFdlN/eqMqG+XxiRzXuTUGOH7KiDMvM
 HkReRYlWT6YwqA8tlaEKr8QhJTfFYNcwGFHxI4nXa0RrZdZJsm+ch3XwO7Z9EY+hBq4V
 O319aaDlQOf9/xTOlHr1M8twjAb2Zqlbm0pFO+KtJkkajn3dwLyZKSx4nrQ2fzB11yRO
 joo136JJMfzRLms1g5PxBeW8TWswNkSRJca697SAUvDAfr4dcuzdTYE2NmesqFsRzkfP
 MLCw==
X-Forwarded-Encrypted: i=1;
 AL+hErHCFnXXryBGBBxESH0XQncYHDf2Ap5zD8K2JGVCbYMkZE3xPhPJKRyOi13bstQzIHL29SM=@dpdk.org
X-Gm-Message-State: APuU4Z+oBW7yO3aiikJYpWtPgiikFYck3TD3wG7zc4GJ1uoxK4lbjme9
 jBaBKGO5YSucRZE5HusdERAOTBun9ter+tePNDVJcOeQOnsIzRFKlaLO/8J8KaENbSQ=
X-Gm-Gg: AZFdTZdeu2UOBHdCz1PLrKv68Ank6fkwmyISC1IiAKIVX0/YckoJ4cfHreOObrl0DP8
 xEl9JhUtcxC6qz6fw/SpSlAAlfHpBkvoRZfUHdEZp7WydKILKtqD9Sj3YxZoHCK+4Vy6AXn14Ni
 lUtKUFmZ9IZC4YsdJl7uPWRjk2dwHRIe6vlmLLNSwfRiDOdXdymU71cdcPPyLhux6C7FirG/4nn
 pRqsqUPiXRXqfNUlpavgts6d3Wmj4yk1q68nJF21eqtkRLjAvUFC94Zwta5SYPw2wuOCvy5BUgw
 Qp3bTdc03xyz8a1mmI9pQvH3fhGq8INb7w/2wewvllkj5a2s0w3WKn6V3Fzc0OHwltJ1onHgplU
 RS505PBkvHqTJQiuRn8pcrFH+WsMyJs1JjltF1F+gryUZba09SQajkGQsCDUuX9J5Y2PSrUeSuU
 7urcF/gf7MJl0gXqz+x4yn5BWIuN6Mt55V1dxTLT7RrYVKwvkOLn7U9EYayzKBzKfFUVRazknwm
 cq8HsmFifQmofF2Fr4IMcmq+PTil37AcKYTpcjHpTrF0GU3rX2JRm9AJftojWdQXjhyXRu9e8iE
 GciTr8QGQCvm+dKj+C8nGO0WtDv8w0fNsB/a66zy1iBhDz1rZAbavN1rTwMlVCExwKAJwJw=
X-Received: by 2002:a17:90b:1b0d:b0:3b4:ab19:ae08 with SMTP id
 98e67ed59e1d1-3b4ab19af42mr2139688a91.57.1795460249304; 
 Mon, 23 Nov 2026 10:57:29 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405ecb486sm21838655a91.16.2026.11.23.10.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 10:57:29 -0800 (PST)
Date: Mon, 23 Nov 2026 10:57:27 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenyu Su <PriceClaptrap@hotmail.com>
Cc: "shaibran@amazon.com" <shaibran@amazon.com>, "evgenys@amazon.com"
 <evgenys@amazon.com>, "amitbern@amazon.com" <amitbern@amazon.com>,
 "atrwajee@amazon.com" <atrwajee@amazon.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "stable@dpdk.org" <stable@dpdk.org>, Jan Medala <jan.medala@outlook.com>
Subject: Re: [PATCH] net/ena: fix out-of-bounds Tx prefetch
Message-ID: <20261123105727.4105ba6b@phoenix.local>
In-Reply-To: <20261122214722.48761-1-priceclaptrap@hotmail.com>
References: <20261122214722.48761-1-priceclaptrap@hotmail.com>
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

On Sun, 22 Nov 2026 21:47:23 +0000
Wenyu Su <PriceClaptrap@hotmail.com> wrote:

> The Tx prefetch uses the descriptor ring mask to index the
> caller-provided packet array. This can read beyond the end of
> the array near the end of a burst.
> 
> Only prefetch when the lookahead index is within the burst.
> 
> Fixes: 1173fca25af9 ("ena: add polling-mode driver")
> Cc: stable@dpdk.org
> Signed-off-by: Wenyu Su <priceclaptrap@hotmail.com>
> ---

Looks right, applied to next-net for 27.03
