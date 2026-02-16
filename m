Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EA8E63F21
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 00:53:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 938D740296;
	Mon, 16 Feb 2026 01:53:56 +0100 (CET)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50]) by mails.dpdk.org (Postfix) with ESMTP id 42C9840289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 01:53:55 +0100 (CET)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b8fbb24a9a9so292091766b.0
 for <dev@dpdk.org>; Sun, 15 Feb 2026 16:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771203235;
 x=1771808035; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=Ah/RjwRoqZjQ21vLrJcNC8LBzzZPoUeftVHNxkPALxk=;
 b=jqEm51/S86kIEWeXY0TiHbrbpgsS7cB8/EgGug/t22STznZFp+t+osfuOM0/3+x36Q
 bTu6d7eD6ce/Z9IRSN96dmCnaG4AlAsFVGPV4Mt8yiK0GhZ3qEYHPiHkkUuN4/aJ81BP
 PKtu8mC3PJW190I8dWDvU+CtJjcCIiDsSfd1uGcI00sPXgkCYenRrwQQyjLCfsB2J3iy
 h9+C1dgyka4rqiHsJI0JF8OSiS2c2jstHBG5HqJyqXnRIeCXOcXWFCZ7hDXIofckk5ul
 kSfPFsBc1yak3XmSStLbqPXSbwhfENpiT24IDODokFC+veKMTZAMyV+ht76eYu+bF3XF
 iPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771203235; x=1771808035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ah/RjwRoqZjQ21vLrJcNC8LBzzZPoUeftVHNxkPALxk=;
 b=N01P3GjaN2d2dBl/u3+MdQ+EZpKts/W2Tv3XN9xyD4uZ3hcDq+z/9EoHFEOV++GNzL
 J5ip01/jmrtDABsSSIXYQBrkGj+MR2BAb6J+1JqLJA/kzZPUrefy1HfHrQ2gxE93Cmek
 cWqsoSDNIz9GpuoUE6u0BUMO8pNJqo2c3qNAKMNuygtt/REOlq89r5JwcUVMaFuL9F4w
 HBNxe20M5Xwuf8cCi9rymtb++qv7PR5dTpSCnX4xzVNZjs9dcWhvGhv5Du+NNy4h7cg/
 6h0hehi+cAQVPALsyLSdYFBjcttMl/89/0Fh6aSPLahWoA1ayCzzJy4c8HKVUDf8XJmI
 htUg==
X-Gm-Message-State: AOJu0Yz3Ojc5hgvD+Q5UzQGVn3LzXPM67NBrtJi/JyyiVHpP4tVscYMJ
 vJc8WHXblYS2OYEx9r4B25on5Gj6jLc/9SpOTRz39yp9it2culcvGvggs/57G/K/kE6ZDFkH58t
 Vv1nT71w=
X-Gm-Gg: AZuq6aLiWsfvK9vY0pSEIm3B301EPvUOsLQCiWHe0oQfixnimYZ21lWqN9+Y3KxKbo4
 UcOmxmfPIXDw9jhzHyoB27ByNsa/b4EeOuxofCtUBQ8WoQqs3OLBOY5unCRqiAg/U1hKm3IVPao
 oMWZyOBNOrE6uUO9BAbqu9TdKdauPg84jxY625b4lokuOIElb8AGuABK3hngP/GJh2uGrtVhc36
 FJWr8XuApEwLjaeBiMXIOWu0HfOkgq9XY/rpfU8YvIFku/Pqzzy2jfWCfY9U53cO6C9uEYPiKOj
 fq5gCaebFJzMBZIovtfPhfv9hriNzUJ9beD2ONu0wpCu/M7sRN1kJBgK/uPVcfSDEoYwevgfLc7
 Kjd6nS9znN0pjV6sG5oZsZ1ixM4xvbo1ASD1ejIT7kLT5U5TSPsjqwxqxBe1KoK3BqRZwuQ9FHE
 G6cgfIuQFgTVBeDKwGjdSyzkVIk0+COBjbo+0deAVabDswNfGf/bhXkp79NJKczRTGs/25NA35z
 X8=
X-Received: by 2002:a05:600c:4753:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-48378d9cc6dmr136106415e9.11.1771202792409; 
 Sun, 15 Feb 2026 16:46:32 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48370a3ecadsm87886345e9.3.2026.02.15.16.46.31
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 16:46:32 -0800 (PST)
Date: Sun, 15 Feb 2026 16:46:22 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH 01/10] test: add unit tests for TAP PMD
Message-ID: <20260215164622.28f59064@phoenix.local>
In-Reply-To: <20260215195348.557945-2-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260215195348.557945-2-stephen@networkplumber.org>
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

On Sun, 15 Feb 2026 11:52:19 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> +++ b/app/test/test_pmd_tap.c
> @@ -0,0 +1,896 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2024 Intel Corporation
> + */

Should be Intel copyright ;-)
