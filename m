Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7855EE6529E
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Feb 2026 18:59:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3228C402F0;
	Sun,  1 Feb 2026 19:59:13 +0100 (CET)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id 57E2940150
 for <dev@dpdk.org>; Sun,  1 Feb 2026 19:59:11 +0100 (CET)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-435903c4040so2479279f8f.3
 for <dev@dpdk.org>; Sun, 01 Feb 2026 10:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769972351;
 x=1770577151; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t6b4EVSmZBzKA7FLbEhQ1hKIoMmRDLNH1moxCq0kUR4=;
 b=VWopD3x4PjZlR2I0NHh7O1Lv2idLl+nukKZBu5l+bZJBR20/KqMIgKw+0a6P9ewNJc
 Pb1CaJJ67WfxbyOJLYZC+O8+nuH000C0ETw1aiPSBIzU9Pr+P1+WOmYjZRe7qVouCRm/
 8i0qknp4rT34do66UEmVCuCEb6WivEALsifUp6ahuXXdHNxkF7nnJGrTAOK8wL8MCeGA
 dXZwWOax+fULxbK+SC9dw/F6/rSMo5e/KSRYcRTGRKISxQNrtiFhPavv/8ldleHBWfQU
 K7sf2+/PvCVZWiwL+nb+ehiq4Hb8UCj877hNe3/D1zPItUHWpS+Ud+Qwn2aDHRTwVJS4
 W5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769972351; x=1770577151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t6b4EVSmZBzKA7FLbEhQ1hKIoMmRDLNH1moxCq0kUR4=;
 b=eXzfVsZYI1D6STsOxIX9yKF5mvaenYidKit4I6ryi23Wl9jSxKDOHhvIg5Gcd1e3ET
 e4iyYS2cPz7NeGGiu/DNYKAHRYo59TS+WZFd8ERKW1qTppvGqi1f+NUvA99po5JOudf8
 LyNq4Ei4TTFLd4Q9cunmEwg2NdW1QsRpwrUUELSziRxdVC62JU//3DWvQ4fuC1IKhlV9
 dWo9mP5kYqtpRYxe6jqYebHh0/KUCUnmtQuG8TLKV2vZ6reTH7dd6WQnwc4M9bLHJT7V
 yDpEdMT1GyxpR+fMWi4Cs21S/E434iBQi4rpz42VusARM56AwXX4xaaEVdX8aaOtgtG0
 05iw==
X-Gm-Message-State: AOJu0YxDydgADmqZx24wq3MQQficfpINuoMXExlj/kBLEoKObk/J9Dys
 zu4IsBcMYW3oKM8S9gPPEsnjmbX57yufiLmWbIQGSP3n1lJgul9Y9uiumMZx//vviGeM7iDIHc3
 Bj8CF
X-Gm-Gg: AZuq6aJVhPQhIzeii/7jjHbB+eLURtuZtX8yLpx96aqAyOQF7GGgqMoH0xChy2vFg+8
 xzwB47ikuH4Pwf2jZRlzw5aJW0szqkBlxdQvK02UXIvsqUU017wgX8z5scCcHuvIbVonaINkvVW
 HGPsxupODqWxlGZj8EyGWrHwihe0Ku54bdq6Zi7m/TghDwxUf4OcFL13bWC29ZI/cHyKTjCZduB
 91qKZDD8SAOh4ua/ZmlJB/0DRcURyj9TyUHUUwu9ZETbznYulj4tNyzagxHFKex1U6yksUok33f
 rS1r+YzvO1tlNtlV/sDiLAT1nbbQQpc2dqkt8nNqmTOJuZt+h9Zlu0B3hsYwuE1nPdaRStGgVC5
 UOEdYGANfWd6OZHlLfJLDJ3e0/2OyrtCyHNImm+MOICU/4ncVlozotcy8eAK6yHg9u4KgFCgIaM
 YGolcK9D3ZdbfhlcGuKv5y6MVtOU24HrsC5KMs8q4SrckxYrSBl5Yb
X-Received: by 2002:a05:6000:26c9:b0:435:7154:2a7 with SMTP id
 ffacd0b85a97d-435f3a7b3fdmr12222265f8f.6.1769972350715; 
 Sun, 01 Feb 2026 10:59:10 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1353ac2sm40501892f8f.38.2026.02.01.10.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 10:59:10 -0800 (PST)
Date: Sat, 31 Jan 2026 13:24:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v8 3/6] flow_parser: add shared parser library
Message-ID: <20260131132413.634427ca@phoenix.local>
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

> +Internal API (testpmd only)
> +---------------------------
> +
> +The internal header ``rte_flow_parser_private.h`` provides additional
> +functionality used by testpmd and DPDK test applications:
> +
> +* Full command parsing (``rte_flow_parser_parse()``, ``rte_flow_parser_run()``)
> +* Callback model with ``struct rte_flow_parser_ops`` for query and command hooks
> +* Cmdline integration (``rte_flow_parser_cmdline_register()``, token callbacks)
> +* Encapsulation configuration accessors (``rte_flow_parser_*_conf()`` functions)
> +* Parser state reset (``rte_flow_parser_reset_defaults()``)
> +

Git complains when applying because you added blank line at the end.

Applying: flow_parser: add shared parser library
/home/shemminger/DPDK/main/.git/worktrees/flow-parse/rebase-apply/patch:174: new blank line at EOF.
+
warning: 1 line adds whitespace errors.
