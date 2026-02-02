Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F14E7FDC1
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 19:45:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21E574027D;
	Mon,  2 Feb 2026 20:45:11 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id A11194026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 20:45:09 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4806d23e9f1so54068275e9.2
 for <dev@dpdk.org>; Mon, 02 Feb 2026 11:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770061509;
 x=1770666309; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sv4hAqkeoCeOwaFjnSWpACNxGHdojEEuplj143abzro=;
 b=Kb34hD2JOFciDOsk4rRnlL6CAN+pOqweNJ73+MKMXdPKqmH1j87nQyJXMnwQhFbVoZ
 /tTTvxHT+cGGy7Ytvf/G7f7LUp6PRe3b3Uvjj5IM0AZIEVSpQt8u71ZEVM8zoDn9E0ic
 moPOzE3NU6Azt3xvSW8JvtifPTjCT8R8wYNyMFdM9v9sdxbJEHW2YPRWzEw3iYJ5G9Pf
 ookcl7oYp9je+apZijYXLZSmTz5WS/Ro0MkaYTJXmG+JF73D6JUUGZucQ/m15GtcjOGI
 vzvXjuskoGIYQ8a91wTCxolCaudi+ftZOQRbeZUE3O/cpNWr0jw3WoJBMJMsVwjWq44M
 dRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770061509; x=1770666309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sv4hAqkeoCeOwaFjnSWpACNxGHdojEEuplj143abzro=;
 b=h/UWC034I0sYg3zpCjBz1vMeBlv8ivrBpu/9AO6XjpBSWxWgUl6dnta1fi129KnPOG
 3rlhOhmqdUIA8Ouvj5IM/cFnS+ahfGXL3In0cZ8d6jvM5Zq55wJRAuVYsG0Jy5p1HlwW
 0jAyCW/Qx6RyjuaJREmr/b4CXi0xb6sR3vJ1ZMxdF36WK4JLwncWrhnup2ArsfmQok+a
 NvjTMuwOHy3XqRU4sSaHLcDIKJqMBByr3MIPGglxGPDXZTtfxzPXIAjO6uhJxELaW0g0
 yUeUbIWsg6JR9ZLtDjtksue2DSLaL0d8dpmdfUdr8/fEo73H3RXLHEJbdJqQoOvUxumw
 EXQw==
X-Gm-Message-State: AOJu0YxdvL72t3ivmPC1TuuecM8UcOtJbFXJluwoqKNfq4nUrRRi3CyM
 aYigA9oLgHZStMgVj0xW6/uA9q/tiGpAqW/n/8DQ9hz0jyJAUPvvjELC1faa3KSckUI=
X-Gm-Gg: AZuq6aLjjw2zM25q8qD9eQYgqpVHo06FcK5V7l5mrfTqTFpqQM/V6RWhXEeVKI5CoII
 EO3GJL2eaF/iNGO/kGby2oRurDevYVcIAkixAUwRI87grGx3eoEtW0Q1cfVn+dMuL1kbxNwJ8dA
 UWmGeb0XyTZ3Ec3/IHkoeONQ59+KjjbDGdfsOga2WXa7bGDFkFGTzLyTkIbmtDCNe7ZhEwvkniW
 3VQpSRmp1TNOhSUJMZTVo+03pGR+udcbSmDrqFJeJWnvUbiSDRhKhcDZje4QTCH5KZkLm7iuyXc
 fsup7ARcqsdqTQGg9UIw84PsJMF+XErZBlbBDG39AXx6nwyuVwvTxE+uBu5Jg1+QolA4XkV/bg8
 wEvaZAXNGEMCkPDZvELzi3+ms/oTQnscbYqJR8yptHXfNMfPWg4QoAr+xza5zkIF3i+8QhyxWFv
 AO1Zzk0EzpOx/yzRKPhyQkHCDnSewljk3Dcv2iw/vIYpWUb/IEHvBy
X-Received: by 2002:a05:600c:8716:b0:47a:80f8:82ab with SMTP id
 5b1f17b1804b1-482db48d4c0mr178480795e9.24.1770061509100; 
 Mon, 02 Feb 2026 11:45:09 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e266fbefsm97258765e9.14.2026.02.02.11.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 11:45:08 -0800 (PST)
Date: Mon, 2 Feb 2026 11:45:04 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 0/5] net/zxdh: add support some new features
Message-ID: <20260202114449.7ca3ad22@phoenix.local>
In-Reply-To: <20260131062208.2445121-1-wang.junlong1@zte.com.cn>
References: <20260105071643.1119116-1-wang.junlong1@zte.com.cn>
 <20260131062208.2445121-1-wang.junlong1@zte.com.cn>
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

On Sat, 31 Jan 2026 14:22:03 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> V3:
>   - modify some issues from AI review.
> 
> V2:
>   - add updated release note and the documentation.
>   - remove unnecessary initialization.
>   - using the compiler builtins(__rte_clz32).
>   - remove C++ style comments.
> 
> V1:
>   - support modifying queue depth.
>   - optimeze alloc queue resources.
>   - support set link speed.
>   - support primary/secondary process.
>   - support GENEVE TSO/chksum,and tunnel packets outer udp chksum.
> 
> Junlong Wang (5):
>   net/zxdh: add support for modifying queue depth
>   net/zxdh: optimize alloc queue resources
>   net/zxdh: add link speed set and autoneg get support
>   net/zxdh: add support for primary/secondary process
>   net/zxdh: add support for GENEVE TSO and Rx outer checksum
> 
>  doc/guides/rel_notes/release_26_03.rst |   7 +
>  drivers/net/zxdh/zxdh_common.c         |  75 ++------
>  drivers/net/zxdh/zxdh_common.h         |   2 +-
>  drivers/net/zxdh/zxdh_ethdev.c         | 239 +++++++++++++++++--------
>  drivers/net/zxdh/zxdh_ethdev.h         |  23 ++-
>  drivers/net/zxdh/zxdh_ethdev_ops.c     | 165 ++++++++++++++---
>  drivers/net/zxdh/zxdh_ethdev_ops.h     |  15 ++
>  drivers/net/zxdh/zxdh_msg.c            |  52 ++++++
>  drivers/net/zxdh/zxdh_msg.h            |  24 ++-
>  drivers/net/zxdh/zxdh_pci.h            |   2 +
>  drivers/net/zxdh/zxdh_queue.c          | 137 +++++++++++---
>  drivers/net/zxdh/zxdh_queue.h          |  12 +-
>  drivers/net/zxdh/zxdh_rxtx.c           | 117 +++++++++---
>  drivers/net/zxdh/zxdh_tables.h         |  12 +-
>  14 files changed, 655 insertions(+), 227 deletions(-)
> 

I put this into next-net but had to do some work:
  - the commit messages were too vague, and lower case.
    I ended up rewriting them with AI help.
  - add missing entry into features matrix for link speed.
  - fix checkpatch warning about using %lx by using PRIx64 instead.

Hope this is alright, please recheck that wording matches what you expect.
