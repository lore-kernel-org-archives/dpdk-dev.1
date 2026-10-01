Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AB5CA5FD4
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Oct 2026 16:05:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0446B40144;
	Thu,  1 Oct 2026 18:05:12 +0200 (CEST)
Received: from mail-pz2-f18.google.com (mail-pz2-f18.google.com
 [74.125.228.18]) by mails.dpdk.org (Postfix) with ESMTP id 42C7E400D5
 for <dev@dpdk.org>; Thu,  1 Oct 2026 18:05:10 +0200 (CEST)
Received: by mail-pz2-f18.google.com with SMTP id
 41be03b00d2f7-cc4bdf8abaaso3997400a12.2
 for <dev@dpdk.org>; Thu, 01 Oct 2026 09:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790870709;
 x=1791475509; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Cf/E8YaqomectzKq+GNuxDZW0VbIjhB13Ro/qxe6UOI=;
 b=wbhrAFyjcwS9wD6IvMQcYUF/ykYfINE+MFSbIhR8g5KxaME+VeI9Fk24CpTYW+EjTC
 DGFlMjJI0Zb6yxA8AGbQaYOh8ZWd9zx/fwXa8X6Greqk32fz2OWm9uzd4rAY5Rh3+6+Z
 /NChdSv5KYghmJFU2+gt4j/9Pun+Jz28HMQ4J3/DyS7DW5RUmZQzW9ek0sn26dr3ClXP
 BEf72ANGGbKwF3KVYcfwQL0keros8uDToTjdvgzs6+jTCwGfxLj5fmZIqm8LI7YcPp3K
 9Uqjod/cez+eOjoHxutKUjIysVWOmcEV+wAoQp1YEMhNkCAKnwV74UGOYNPdA1SXNlVj
 Z8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790870709; x=1791475509;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Cf/E8YaqomectzKq+GNuxDZW0VbIjhB13Ro/qxe6UOI=;
 b=fuPIRO2ZAs7plDZSMXSqzhQPhyLt7yI+bnO6m80l+AgUWMuqBODHKse5GuOaQHuxWg
 lJDIgsKIAKUOszbxs9/dX4gHGmJdO1Pnk0gBVlffC/9jC8K5CydbJNybRlDHOoFCCsEk
 LmTzREHJ3wL5QkxxvOPnhjAA0LyP0dSxoYgu+EvL+09EetWS9xfw4JXtDVeq7+MWfMJo
 K89O5XOH6SE+6DbOSQz9HfJ6A6T7WWHGBhuRA/RdWFjl5kBo/gJp+iIe148yV6Xdlxin
 sH2Gg/z9EKygdidfxGfb2tS9g35RwiOPfobVAUiq+JqPPvY+Bj47ee+Ky7WtLBgEoLEx
 P5cA==
X-Gm-Message-State: AFq9FYL07bZpDOGFYAjDf9KMl32Hng6NZT/391qRIfeRvMu6XytGNd3k
 DWPPXzzJ3oqYgfjnv+I5mn8OxB26sVVyyA2LXXCbjoxIuXLm2fbOHZen9rjVeMfyeaQ=
X-Gm-Gg: AYBFou2r32/qJHf4PGCYtPIsISPQxxO8gxcJBvgBbofmqfXMQbiuTGVZyk7SxpiPcX5
 tQ35wwXOLZWshXdf8oaIKSDltJ9cRBug6hL0CM5E2Z8tksnuCcm2Bi7hMDMK6F4p+MAWUxIR6yr
 IM93HQNRN7Ra0nVnoSkQC2JdiOYrvg3wvZVugPOxf9GpeNb9mBPFrpqVb+rNWQMQBAIu2Vv/xBO
 eDfd1DF72kjgzRNg42vhcqsF4dZuKjRmbV0Hu8gRXUQSYChA6wxRkV8lK/bc0zn4droNKoM8nnV
 vwRW7Url+WKPyRAnjPsjL+EiQgPYlasd6KFB6+S4OlVRKFUSzjzVK7rUZan/Tr7Y6YI2lohzxzx
 UAkJA6wLMQSc6d27yEQF2LcD8mwWMyLXolaMfRLkjFqehqlupStzvNrbvU0Y30Jb7lFOjq1qKlu
 P3ko9obWR0RhL8AVdPrZF3xmMsXJM6i+q2JSlJQalDi7vjYZkvAaR7hBVfFKOW292gq/5ip0xei
 Ue240RDWDt90s0xkn905X+/c+uYgfCt1Ar8WWFh3swrPSAhqps=
X-Received: by 2002:a17:90b:1c86:b0:3a4:d5c0:f826 with SMTP id
 98e67ed59e1d1-3a6ce9b0fe4mr40565a91.65.1790870708785; 
 Thu, 01 Oct 2026 09:05:08 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6cd5d88e4sm180263a91.13.2026.10.01.09.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 09:05:08 -0700 (PDT)
Date: Thu, 1 Oct 2026 09:05:06 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, eperezma@redhat.com, maxime.coquelin@redhat.com,
 thomas@monjalon.net
Subject: Re: [PATCH v2] uapi: update headers to v6.19
Message-ID: <20261001090506.47b8bc9c@phoenix.local>
In-Reply-To: <20261001090558.1131763-1-david.marchand@redhat.com>
References: <20260930095800.551314-1-maxime.coquelin@redhat.com>
 <20261001090558.1131763-1-david.marchand@redhat.com>
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

On Thu,  1 Oct 2026 11:05:58 +0200
David Marchand <david.marchand@redhat.com> wrote:

> From: Maxime Coquelin <maxime.coquelin@redhat.com>
> 
> This patch updates imported UAPI headers to v6.19, in order
> to exercise the new compatibility define for __counted_by.
> 
> Since __counted_by is introduced by linux/stddef.h we need to import it,
> and the headers, included by already imported headers, leading to its
> inclusion.
> 
> One complication is that linux/types.h contains a guard that must be
> sanitized using the same method as the Linux kernel.
> For this, add a dependency on the unifdef tool.
> 
> We also need to fix net/nbl which does not include the VFIO uapi header
> first.
> 
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Acked-by: Stephen Hemminger <stephen@networkplumber.org>

Can take it through next-net but makes more sense to go through next-virtio
