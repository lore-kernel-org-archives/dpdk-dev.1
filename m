Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75340D61033
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 17:24:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 952FF402C1;
	Thu, 29 Jan 2026 18:24:04 +0100 (CET)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 3CAB64014F
 for <dev@dpdk.org>; Thu, 29 Jan 2026 18:24:03 +0100 (CET)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-432d2c7dd52so1111572f8f.2
 for <dev@dpdk.org>; Thu, 29 Jan 2026 09:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769707443;
 x=1770312243; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9PJA+YMjfZ+Uw6H2r6SgABuzen6KoB+2V5mhS8g/v38=;
 b=KQTx1Uvhte2BlK1i7MfVNRNGOuLj2fdNpBg91DeqnKg9UMwJbDVyohKw3eFqos83nu
 Eyfg9KaM15B9sgkj0v7po501Bea2r1YKXFW1hRIbU+NBSsNVWzxC46I4Jg8pTleB0QIi
 72g1N0A8vZfcDgElvvr084eu/DNgC9FmhABE7Z4j35Z6GyC9OpFn7pwlXr30VpMce7+d
 0Iv8oOBmBe+I9xE01kTaBifWU8OjTTRVuFGUDZOryT7Pyh6qnmfWBsuB1fh+HaqSgWfc
 lAbf/KNJtboJE4GMXTuff6wsY6olCD36WUOt6VpTqXR2EouO9WO7zwyC9pieV3AKEC5k
 rL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769707443; x=1770312243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9PJA+YMjfZ+Uw6H2r6SgABuzen6KoB+2V5mhS8g/v38=;
 b=igiQGXyB+AJ7GNTh/ZqYBzRvWT4fc5jjEu+hrU1D15mjUF9q+Bj1BAqFrFR7Jb1x0p
 K6lBiNFjtBh7f2/M9uKxWtu56cW3u8OE7id2gA2eJgjPhCEwTh1+aKs0lPq2TSQjy6Qp
 8uQtspryPIR7Hxrq8UEjSAPgN3okQdfbYDJNgQXVMCisNEnyW9tQVHpAN0DUhsUYdOdp
 PNk3sYlah2Fbb2gagv+VZ8+cTZDOC3BXe3QMo7hVw/ue1QdTDPNU8aXl9lldJeaIteiA
 RQwRgLwoW1EyN+j/QA5ttvKyQ9v+v8CYaEZ0ruoVEF6Z2dwDMwwTvAswLLcYyyWDCR9G
 K+DA==
X-Gm-Message-State: AOJu0Yzd+F0V9uFSmvHbUoKFDRnyTQ0+qC7d4vdnIKXe5RR/wxHpEd5w
 t4Wno1FaLa6K/mHXVj5vlQAcKNyho0w/qCLxLLbyB8r2tJZbmlgsiCE2/IsFhp7UT+E=
X-Gm-Gg: AZuq6aIuATa27IEbtgIqfIn5llAZ/nLGGKlQKrYiYUq3LJn3Y+JzsHhUFVckUQ2E++N
 YC6jyrd24thZZPDHoQzO1+bJHL+3xOpS2at9mE6n4Sbm9ZKU+ft6v4oaMo/cjEWVFMd/FMlYKc5
 DBp8+TThH76nJKd+R15waZdp3NokMlS0KwhCAPcfH/9LHvpA83YHOdjZCe8em6n7Cm4U8ZUGwnK
 N3h5zAGfW7Nn2JBGntrk9XKdFSE2cyDw7OZUVk2seg8fM6W76mRs4qbaNwMkxCOewE0KeXYrXvn
 HtDGCnD2z0jcDwJjEflAwVWXU4q4nbqegh3o28gbcs+p5STGO05Pq1kGx5uaUMG/Wg8cvmHbM+c
 21ekKoT65JRVOPfQBrGHbMOHoJDfFNF3svW2Osd0bRNBSs4iD9vD14kC5gV5jpkaYKgRf5wknm6
 bZTa7Q/UBhew2nquvmXVd7xjssbpi49xReSTt8qXOYOqndNNVhDKk3
X-Received: by 2002:a5d:584a:0:b0:435:a464:f467 with SMTP id
 ffacd0b85a97d-435f3abc7d7mr474717f8f.50.1769707442369; 
 Thu, 29 Jan 2026 09:24:02 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1323770sm16012830f8f.32.2026.01.29.09.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:24:02 -0800 (PST)
Date: Thu, 29 Jan 2026 09:23:56 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v8 3/6] flow_parser: add shared parser library
Message-ID: <20260129092356.6df61870@phoenix.local>
In-Reply-To: <20260129114202.61185-4-sismis@dyna-nic.com>
References: <20260129114202.61185-1-sismis@dyna-nic.com>
 <20260129114202.61185-4-sismis@dyna-nic.com>
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

On Thu, 29 Jan 2026 12:41:59 +0100
Lukas Sismis <sismis@dyna-nic.com> wrote:

> --- a/doc/guides/rel_notes/release_26_03.rst
> +++ b/doc/guides/rel_notes/release_26_03.rst
> @@ -62,6 +62,16 @@ New Features
>    convert between RSS type names and values. These helpers provide a global
>    RSS type string table via ``struct rte_eth_rss_type_info``.
>  
> +* **Added experimental flow parser library.**
> +
> +  Introduced ``librte_flow_parser`` as an optional, experimental library
> +  exposing the testpmd ``flow`` CLI parser as a reusable component. The API
> +  converts testpmd-style flow strings into ``rte_flow`` patterns/actions and
> +  provides cmdline helpers to wire parsed commands to application callbacks.
> +  Lightweight helpers were added to parse attributes, patterns, or actions
> +  snippets without managing a parser instance.
> +
> +

This is ok, but usually the DPDK release notes try to shorter and more concise
and leave the more detailed explanation to the documentation.
