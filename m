Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF3EE94623
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 00:05:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2529240611;
	Tue, 10 Feb 2026 01:05:29 +0100 (CET)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67]) by mails.dpdk.org (Postfix) with ESMTP id B3513400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 01:05:27 +0100 (CET)
Received: by mail-wm1-f67.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so72940115e9.1
 for <dev@dpdk.org>; Mon, 09 Feb 2026 16:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770681927;
 x=1771286727; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sR2uB3rq7aIUrB9Acr9IKBquTql9Jl8d7EgwEbqkZY4=;
 b=0NzRYnCP6jThCvhT1wuO4nS0D4FgJDGec4GavO1/piqAg1hI++/qcAPaqywBZhZF8G
 K075PWwHdAYmu3KG2VY+Oj9R35wubH0FzioJPYUDmT/wpjH+a46sxOZie54exQs1Oz1N
 Gja07IrRvlr85Lrr6fnYf0S+MoF2aPoDeZUJWj0+zCWzjVu7hXMcLyX5ETNq8/K4+ebX
 oBkVBDERL9MHZwQRUs2NUZaie6D4SqXmHP+0HLooTgkf3Le+tWoruVjyKUkYGHmobnUo
 DRogbOTbYJFYSPc6eEhRyDvgNzLWw7tDX85aO0FBHkGlN6Cf68KMqVwr/fruJ1DC3p3Z
 gxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770681927; x=1771286727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sR2uB3rq7aIUrB9Acr9IKBquTql9Jl8d7EgwEbqkZY4=;
 b=hULFzJqg9TMUWmHgwvkGGEewtuF4m25BTd+ihebMOAA7Ns65jUEZKFly9YstMRfryJ
 zGBnnFTLcoZAhaiz4CYF5GjHnzm9hSc7cP36fyL0MA+KMNTiwcNYizOeleuBBUIrDdjq
 mSYBF5yhaBFtKej4h50eTntZD+y3ulh2RfaLbU+bqnTkAKP/k5POJza4UjIgxQ03mOXj
 cBfzkOszNyQZXRBXuKFxGv/+0ObgkZYcnrpQx+fUG1seTjwkO45AWeAjtgO47Dcqs2uz
 psKPJhJPTfgNie/qCODjlU3tZdWw5gYl4BXMz11dBFjH0JKrLGRTNnjwVMHADa6ilYhH
 Weyw==
X-Gm-Message-State: AOJu0Yzeb14LLuU80gf1qFs7nVAVDYGcxNZNNN0xecK7PUYOKzsDeFio
 wMDRoUXXbfCderb4fPeBgDmjUOSFI5rGNETMJ7rd3RAj7Dknk24xcG1VeQcF+ghZ/qDD+14Zn1v
 Ag5QtnMs=
X-Gm-Gg: AZuq6aKsz9aIOlH2CdsqEFyIuhQrjWKncAANEa7YtH1PBCfQDfk8ky8NjvwF44Q223j
 EV+igTEdMISJs55oto8smsAcbT1BZPcxi33tGJ9IQB9VHEoYfp59pGIuEqlJH7Pf3NQCj5Y4NAX
 f/wgO6wBC5T05xMwfSypZRDGDW3ypNAIIjEBBRmNNFp7T2Luhozp0UIX0d7m6uwmXlpqs48cM5x
 7edGxCqb3a8jCYhymxGqmO6QERCBOA+P7w9f8y577FftJPwN7oxhsvuML6zrNdCstv4bvZbW0Ap
 vyuHjF38ObEBSVoQqX6qpXYGtQJEIVmzckpV9zl4Da0uItyD0qrerONJtXkbMN+KERTQm6FZlHV
 wjo6RxmDb9O/uOVTNXIWtc+uH5J5/aK3Vfhz5sY3xD8DmCx6bzuINNCci87ggWTtKtifyJjlpqe
 OkZ3Hkkkf7nHMxr6hBogO/a5hya4c4Yi/XZmT2Jn8nHbIwYTPxexIww6iaYA6cyZFE
X-Received: by 2002:a05:600c:4e49:b0:477:c478:46d7 with SMTP id
 5b1f17b1804b1-4835081ec5amr4776515e9.22.1770681927245; 
 Mon, 09 Feb 2026 16:05:27 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483203e5b63sm170211655e9.1.2026.02.09.16.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 16:05:27 -0800 (PST)
Date: Mon, 9 Feb 2026 16:05:21 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] doc/guides/nics: split pcap_ring into separate
 documentation files
Message-ID: <20260209160521.50c66fa3@phoenix.local>
In-Reply-To: <20260108202441.173351-1-stephen@networkplumber.org>
References: <20260108202441.173351-1-stephen@networkplumber.org>
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

On Thu,  8 Jan 2026 12:24:41 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The documentation had combined to unrelated drivers together.
> Use AI to split into two separate files:
> pcap.rst for the pcap PMD and ring.rst for the ring PMD.
> 
> Changes to pcap.rst:
> - Use "pcap" consistently instead of mixed "libpcap/pcap/PCAP" naming
> - Remove Linux-specific references; document support for Linux, FreeBSD,
>   and Windows
> - Add reference to upstream libpcap documentation
> - Add multi-queue support section explaining queue count determination
>   and file handle limitations
> - Use ``--vdev=net_pcap0`` format consistently
> - Remove deprecated rte_eth_from_pcaps() API section
> - Improve technical documentation style throughout
> 
> Changes to ring.rst:
> - Use ``--vdev=net_ring0`` format consistently
> - Fix inconsistent "Rings-based/Ring-based" naming
> - Retain rte_eth_from_rings() API section with usage examples
> - Improve technical documentation style throughout
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Queued to next-net
