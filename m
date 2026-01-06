Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F5ACE9D7D
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 16:35:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFB8D4069F;
	Tue,  6 Jan 2026 17:35:34 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 79797402DC
 for <dev@dpdk.org>; Tue,  6 Jan 2026 17:35:33 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so12162195e9.2
 for <dev@dpdk.org>; Tue, 06 Jan 2026 08:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767717333;
 x=1768322133; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dx7VIc1AWUkRyVY/jweZzA57nBz0HuM0O8on0wW8JL0=;
 b=vA2uyHjrCJKC/4wDvT9jwAYy8gznTF0yMfpM6lAXmDTPxJwbrrCTw9eBFi+ItSKfh6
 ppaNn4RP91XKpB/J2ajChUlvFPhsznfAQF8DNjEMcdt2ZgwLEbnvDlLG1QC9KiZbRWmf
 FlpB7497s+GW5RKnRuqY+mZ94KBdK7ytcUwxtmQWxtVP3aZMUwXVWjpwCQIG15QT500h
 27gB/HlJIbaRlfSUsogFb0aTrQyZyJKPKea53YBgwLu/iKGmX9dZ/mcKvfY4mzdptMwC
 46Sm7FreXHDNPyWmJw13xhdGkdRNMAnMOOMt038YAOyaRzryDgaLdJgDnhnaUF45rkus
 A0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767717333; x=1768322133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dx7VIc1AWUkRyVY/jweZzA57nBz0HuM0O8on0wW8JL0=;
 b=kpOYG0W9CbZpJPd+bHPavgnqd5JVpQbYh5Mp4ljPFJCn7Ax9j1EUTFXwR81Lha51KB
 c6rWkqw/jn7uXsRw3v2D87BlwI4zSUvw5bVa/eHcm325E89Yxb/kR2pv7cNGcvMuTT/u
 QKfDBQVX1yKqIb73SX49uiDY3MfURSlhfFLntmcYDYUQpggP6JeAKIhHJ3490Dk/ifDA
 Cm90c1QI/7Jlv6YkYsSowl1DsSd9OHQPK68eLvlqDrZUTgT0YIp7Nnf6G8GHQh5vTHW5
 OTDVDEtAhs6xP9Q4kPidiNYeOWLGURj9B2HC8gGAMWMrthaWhhQPah2VQoReSTWokpLn
 MOeA==
X-Gm-Message-State: AOJu0Ywz26kkiZnnx0Y72pECBE1+gsZZk9ReiMJaKJ//W/lEEoJgTpcu
 HTd9lkIR2G63p9RWJD0N30lQ2cvjolC41hedgwxwbWdW2QdYwJ4CHB9D0P9W0/MySI8=
X-Gm-Gg: AY/fxX4XoeBoMiOA977DRXX6SIy3MsgD5QDAOa+Xnv3NCof7gZSoZNKcyyHyXjaiw1D
 I3T9V+gKQIZnEp6JqyYyXS5UPmTEmnjzchIXeHzKiGdkQTXaPdMuDSUAc5cByujfX3rFY2qlMkb
 Et2T3WwzqvxsAW/dSeglKzu4SOB4iQ4xGw8l3ICKVY6VN3a73Fi4JT/0qvG6fiK5PFBONSHJR7N
 bWItwabMCxug49fQfyKW1BTTxly3dOOOmHAK6Da/JOyqsewecwz99HLFyyuJeaUojm3v6e5X1ml
 gAZs4GT69cbN86g5OabPkJ520tY/OVNfdQTVJXf+CDS8SAKcSKcM6XqtWJ/u9979KvWjzg7jY7/
 lQfMQuPMC+9QibsnzHGpnW8eW4uLMQqUDGPo2R0oGcNYCc+5+e3OTDTu1gx8W1yU1u3ocu2lCSH
 7hEtd4Hh/sqpW/r7feJB03+tLenDp78jDaZxj6trg+aL4qNfqM4S8S
X-Google-Smtp-Source: AGHT+IFCmUDSysgi+c1BdGsWbfsI58JW0D0tbA+gW1YhiF2Uw0LprlZxELhJh5fDsFj4rHwA6FAvvA==
X-Received: by 2002:a05:600c:154e:b0:477:9cdb:e32e with SMTP id
 5b1f17b1804b1-47d7f0732c1mr40504345e9.9.1767717333029; 
 Tue, 06 Jan 2026 08:35:33 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7fb357absm20684145e9.12.2026.01.06.08.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 08:35:32 -0800 (PST)
Date: Tue, 6 Jan 2026 08:35:26 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 1/5] flow_parser: add shared parser library
Message-ID: <20260106083526.03e9c258@phoenix.local>
In-Reply-To: <20260105213025.749383-2-sismis@dyna-nic.com>
References: <20260105213025.749383-1-sismis@dyna-nic.com>
 <20260105213025.749383-2-sismis@dyna-nic.com>
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

On Mon,  5 Jan 2026 22:30:19 +0100
Lukas Sismis <sismis@dyna-nic.com> wrote:

> Introduce librte_flow_parser as an optional, experimental library
> exposing the testpmd flow CLI parser as a reusable component.
> 
> The library provides:
> - rte_flow_parser_init(): Initialize parser with operation callbacks
> - rte_flow_parser_parse(): Parse flow command strings into output
> - rte_flow_parser_run(): Parse and execute via registered callbacks
> - Helper functions for parsing pattern/action/attribute strings
> 
> The parser uses a single global instance design for simplicity.
> All parsing state is internal to the library. Callbacks are invoked
> for flow create, destroy, validate, query and other flow operations.
> 
> This enables applications to reuse testpmd's well-tested flow syntax
> without duplicating the parser implementation.
> 
> Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>
> ---

Any new feature like this is required to add a new standalone test
to the functional tests.
