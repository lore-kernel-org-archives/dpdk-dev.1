Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A79606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=aZRcozCF
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DBAE40285;
	Mon,  9 Nov 2026 23:13:59 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTPS id 1855840283
 for <dev@dpdk.org>; Mon,  9 Nov 2026 23:13:57 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2e9995ce866so9728365ad.0
 for <dev@dpdk.org>; Mon, 09 Nov 2026 14:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794262436;
 x=1794867236; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5A7ZOE5howS0Wv9sRJ6MkUXQ74ITK0+POO21N9GPAVM=;
 b=aZRcozCFKMwTQ1K/E+J4mVqOCraAKNxrX1kRLJjw2minQ+SXjfU9bN2ANOlB3j/wI6
 zHH40V3wtYvdhCp+K+IIyUNaRpU3zOSb10PLV0vOz/FxU62k5dBzRVvxA+d3BWIrx1bR
 hSUU4JE82LapTrF4g0VNCRslwN/EjwypcRt7uB+VhcWBEjtqG8e9xDBs3yGolphS+V03
 Xn/O8XjsZkUz7doh2qPcqpcGh2DjmWd4XWH+sqvO/eTMJH3dbROlEMHlRcYYzvrp4iZq
 cAKXs7qjqPBKIUOBRJ+O/zMCuo3dfzUwUuX2zrfinBXzeYr1OXsrlc+85IAl2BmOMfOh
 4PKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794262436; x=1794867236;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5A7ZOE5howS0Wv9sRJ6MkUXQ74ITK0+POO21N9GPAVM=;
 b=JVR0Ku88sLd+dTdW3VVfs/tJyqlhuivV/hoffgQdO1vWjMWwBzkCwqXk8WW4ayzPRf
 F/ytZewtO1/rxBjwW8ZP07my6W8ly+jNylqgyfeiIMhVkbe5IgH7JMm4+SW84tqsfRUd
 7s3Dy3+H7UqcKn1vsw7JdL3/T/lUARdsjGzpOFbxTf9Tsd3+aAw/mM9joyJsUFJWq9gX
 yDf86x/IMabHZ66n+VL6ZGF+Fys8lENKLVa3/LijSBey5t9O0Nl+/lTAzVU/GOj8btbG
 v/y4y/zvtQkoTPLDZEGszgEF+tTfaH6hfyz0gnIoNKI00lcxSVzjCEtXWVY2juJA8VV7
 1W2A==
X-Gm-Message-State: APuU4Z+JleP+43WXed0JkBGPLm6s+ivrlAgHsS2QiabsrKQwftj0qDxJ
 NItMo30RZ/Cmaxgvlo3ccozWmC1jGOqgfQgvaQKlnRRFwzuMBI2+AAVdxA2QyVfxFg8=
X-Gm-Gg: AYBFou2p5BR/IUU8PrL8qegNyFEjkM+BZuKghe4STT8ixBflAOc1a+6nWL1psEgeZcd
 BtCpJ51PVbGAVR8WobCTpYc/zwdyu5j01JNEypwQtt5e2jroWOL7+32AT1OqDRsZFrRqP2V9Cho
 GUEVTlzCWPMomOFc+y6yQhbBlSvaO20kowbrMrwbvaNhwm2dyD1r9obZadtnvjtON5NHsnjoKCR
 VsbVQLs0clI4Wv8QoiN4x3bfKGtA84y7S22qmo9Hmujloq7wJ4w1LlHLKNVA1y1Te4n4dOmkMXC
 hqoaeu+zlhcBieGAfw14o+9PuejqtxEG14URPXn3MeFWLxQUFGSB6HAn9f7T6x/Z3bjBU8qVa86
 kSBR8I/LmNpqMes1Y8wOFIUyYPzTkGOk+rDQ/QvzBAImQ8yLp0IxzLU59iVOqqV+sfOBA1DNJGB
 tQIf8tw2KIlYO8AX25GbfbDpUye0kQ6yAybqrd+2Mhq+o6lO9HNyJZz57fo9QClAjD3ZC1XsC2j
 SWbYQxe87RKflDNBlpE2NewNLDM3qjuWYiERH2wR2MDApo/KNE6KpO/8MUJFZRvY2hgGrUduX24
 hG0EFPDJqTWfKqt5sDqPmW5M+RK5rAMCPLJ60lQGbKIj43lJbc9Zolx1rKL+cKkl1dl4ZA==
X-Received: by 2002:a17:903:19c3:b0:2ed:d7b:2f5c with SMTP id
 d9443c01a7336-2edb8fa2f70mr5120865ad.5.1794262436337; 
 Mon, 09 Nov 2026 14:13:56 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edb6a3f730sm2322075ad.5.2026.11.09.14.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:13:56 -0800 (PST)
Date: Mon, 9 Nov 2026 14:13:54 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, Jakub
 Grajciar <jgrajcia@cisco.com>
Subject: Re: [PATCH v2] net/memif: fix use after free on listener socket close
Message-ID: <20261109141354.23e03f2c@phoenix.local>
In-Reply-To: <20261106145730.2561787-1-david.marchand@redhat.com>
References: <20261104164153.1674329-1-david.marchand@redhat.com>
 <20261106145730.2561787-1-david.marchand@redhat.com>
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

On Fri,  6 Nov 2026 15:57:29 +0100
David Marchand <david.marchand@redhat.com> wrote:

> memif_socket_remove_device() calls rte_intr_callback_unregister() on
> the listener socket interrupt handle. If memif_listener_handler() is
> active at that point, the unregister returns -EAGAIN and the code
> proceeds to close and free the handle while the handler is still
> running.
> 
> Use rte_intr_callback_unregister_sync() which retries until the
> handler completes.
> 
> Fixes: 7281511c2cfa ("net/memif: fix some interrupt FD leaks")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
> Changes since v1:
> - added missing _sync in other call,


Applied to next-net but dropped the Fixes line since that commit
is after the last release. Fixes is not necessary during the merge
cycle.
