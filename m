Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58842FD45F1
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 23:19:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F0094021F;
	Thu, 26 Feb 2026 00:19:04 +0100 (CET)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id 5D0E4400D6
 for <dev@dpdk.org>; Thu, 26 Feb 2026 00:19:03 +0100 (CET)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-8cb20bcff5aso14592585a.3
 for <dev@dpdk.org>; Wed, 25 Feb 2026 15:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772061542;
 x=1772666342; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=r3kQSMov78rpK08r5pzut/uKIrlsraMyHEJEFFZ3ie0=;
 b=b/y4DmxIG5hsmUzlSAU8/oF5kQW/w2umdntUJQzW9ulNua9jln+dBGFUW5Qm2DOtbF
 fOiAItkjU4Brc6DyNUC5m0gv5C7TU/ehaYIa0W6ww5gONmVta31WnhwlF5JCbFbvVNGl
 y5ixgWIBppHoBPuuUoQ/tPZ1tT1DR/rhEnzI7efMvptz9tf+BviOoGZdPbeaSUjc5i1a
 BePTgFlrZV3EIpeP1LfbsOFeypdEBBGeNex5ijrI+WVzIyIvzJ3bZI31qnbTxF7miQ9E
 XZBMf3FMoOhrxZQ5tAXIsJ3YW8jHe2mdjL6pRmdZU9eEoSiWjBREpMYGJz+vQ9yQhTnK
 UojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061542; x=1772666342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=r3kQSMov78rpK08r5pzut/uKIrlsraMyHEJEFFZ3ie0=;
 b=fRLX6jz55ojjINEtNrOv8JPDLIgL0O8Uw/j3+h0nph/ClYnsI75Ney6+wpxOHXyOYJ
 8W1RqgkNnTVM+qkvv+DuNgh14auHLB42WFafRoo4RD5fkRKIuOMDxmQf9Hl8wtXSGcJX
 nqv+JLRbFT2J8Cy1vRg6Ida3Xywv20YtOdCiWvd+ZI/w0bz/x9VYLpsLMq6XeBE27mlF
 wclt/wGbwH7Q9KDfI2zZW9/9gnpyji5g3vEEtiTPxF9VYt9zX8oXaJAymrobKnxSyWfp
 QImSOJ7ih8iK68zdIdqknjNrYKQk23g2T7yJ3ws0TjwD2U7bBZkd0Gx7GGQx/cmjX7yr
 5g4w==
X-Gm-Message-State: AOJu0YznFhVb/eDeu1dRFx0FDlpR+/Pxpoasxh37was+HrJCsltq9VPv
 gaRDp9JM+YR1LgRVU+/F2a6TkqHxH2ld0C+7LgK7DxtteHqZFC1zwj0C+Yk3Mi6yY/h8fkLm3Gh
 kCD1t3fM=
X-Gm-Gg: ATEYQzxSGpcEt8Gdjagl6d46t9zwmfeqP6e+XVXnHNG+sYgVBLcazxBL4eNsJIujdES
 gcSOe4PLbu2DVM9LG6uIf47awUemIsfo95siBLqmB9PRai5k3L07qdsqAIL0qG91rrsiluM9O5H
 cA6PoUI+9kATytIWQFZmwSphErxdEQnO692mY+pQXNA2LAg12Te74BBGQwx3AIFitG7MG+YnF5N
 EqtWWXJDJz2Dh3AWg8R4aoPu6LhGuamtTw4oG/EULVcmeqW64BNWpR2DKNVcC6flwkVaOg106Wj
 /AZ9JIf5LHBOcDZMpEQ355EdW8hN+OCa6x5Uf9we4RbppyKhBy96Zui0c4I5mnJzDsA47lh6ouk
 7qsfrzor+HQJTkQAf17RMfVu0Uj0+Oh8zrJHPeFuESygvDeAlbKtNdCELzsfLDQBK9rQGBOK5D7
 bT1lqa0TXH+jkvwnjGKkYUHQJjrClqmR7DIx3UfJDZGoM+WVsG9Ram8M7mODCfuNpZ
X-Received: by 2002:a05:620a:4505:b0:8c7:1106:1a44 with SMTP id
 af79cd13be357-8cb8ca92db1mr2257037885a.79.1772061542347; 
 Wed, 25 Feb 2026 15:19:02 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf6f926csm49050485a.32.2026.02.25.15.19.01
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 15:19:02 -0800 (PST)
Date: Wed, 25 Feb 2026 15:18:58 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH v5 00/19] net/tap: cleanups, bug fixes, and VLA removal
Message-ID: <20260225151858.4ad951fe@phoenix.local>
In-Reply-To: <20260222173225.522754-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260222173225.522754-1-stephen@networkplumber.org>
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

On Sun, 22 Feb 2026 09:30:35 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Patches 1-2 are documentation and bug fixes that stand alone: update
> the features matrix to match current driver capabilities, and fix
> queue statistics to count all queues regardless of the queue stat
> counter limit.
> 
> Patch 3 fixes interface name buffers to use IFNAMSIZ instead of
> RTE_ETH_NAME_MAX_LEN, since these are Linux kernel interface names
> not DPDK device names.
> 
> Patches 4-6 are minor cleanups: replace the runtime speed capability
> function with a compile-time constant (TAP is always 10G), clarify
> TUN/TAP flag operator precedence with parentheses, and extend the
> fixed MAC index to 16 bits to avoid duplicates after 256 hot-plug
> cycles.
> 
> Patches 7-12 fix bugs tagged for stable: a bounds check to prevent
> an out-of-bounds read on truncated L4 headers; resource leaks in
> the primary and secondary process probe error paths; a missing free
> of the IPC reply buffer on queue count mismatch; a use-after-free
> with an orphaned kernel TC rule when remote flow creation fails; and
> a leaked remote_flow allocation on EEXIST from an implicit rule.
> 
> Patches 13-18 restructure the driver internals: dynamically allocate
> queue structures instead of embedding fixed-size arrays in
> pmd_internals; replace the pointer-to-VLA iovec with a flexible
> array member sized from MTU and mbuf geometry; replace the Tx
> per-packet VLA with a fixed-size stack array capped at 128 segments;
> remove the VLA in flow item validation; consolidate per-queue
> statistics into a common structure; and enable -Wvla warnings.
> 
> Patch 19 adds a unit test suite for the TAP PMD covering
> configuration, link, stats, MTU, MAC, promisc, allmulti, queue
> start/stop, link up/down, stop/start, and multi-queue.
> 
> v5 - use IFNAMSIZ for interface name buffers
>    - dynamically allocate queue structures
>    - compute Rx scatter segments from MTU instead of nb_rx_desc
>    - use flex array for Rx iovecs, fixed stack array for Tx
>    - consolidate queue statistics
> 
> 
> Stephen Hemminger (19):
>   net/tap: fix handling of queue stats
>   doc: update tap features
>   net/tap: use correct length for interface names
>   net/tap: replace runtime speed capability with constant
>   net/tap: clarify TUN/TAP flag assignment
>   net/tap: extend fixed MAC range to 16 bits
>   net/tap: skip checksum on truncated L4 headers
>   net/tap: fix resource leaks in tap create error path
>   net/tap: fix resource leaks in secondary process probe
>   net/tap: free IPC reply buffer on queue count mismatch
>   net/tap: fix use-after-free on remote flow creation failure
>   net/tap: free remote flow when implicit rule already exists
>   net/tap: dynamically allocate queue structures
>   net/tap: remove VLA in flow item validation
>   net/tap: fix Rx descriptor vs scatter segment confusion
>   net/tap: replace use of VLA in transmit burst
>   net/tap: consolidate queue statistics
>   net/tap: enable VLA warnings
>   test: add unit tests for TAP PMD
> 
>  app/test/meson.build             |    1 +
>  app/test/test_pmd_tap.c          | 1143 ++++++++++++++++++++++++++++++
>  doc/guides/nics/features/tap.ini |   14 +-
>  drivers/net/tap/meson.build      |    1 -
>  drivers/net/tap/rte_eth_tap.c    |  411 ++++++-----
>  drivers/net/tap/rte_eth_tap.h    |   28 +-
>  drivers/net/tap/tap_flow.c       |   36 +-
>  7 files changed, 1424 insertions(+), 210 deletions(-)
>  create mode 100644 app/test/test_pmd_tap.c
> 

Applied to next-net.
