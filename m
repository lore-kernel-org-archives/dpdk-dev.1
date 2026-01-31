Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC338D73EB3
	for <dpdk-dev@archiver.kernel.org>; Sat, 31 Jan 2026 18:12:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A05BA402AF;
	Sat, 31 Jan 2026 19:12:05 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 838DB40274
 for <dev@dpdk.org>; Sat, 31 Jan 2026 19:12:04 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-48068ed1eccso28571975e9.2
 for <dev@dpdk.org>; Sat, 31 Jan 2026 10:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769883124;
 x=1770487924; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yOsEmFEyG/+JsSwHUpNCLQqej1Ob2knNViSxk6huaDA=;
 b=hUZ8N8Kjlee2vxFNKqojjK+HqwhgT6hyQWe4ZKTZfqV+umtAf9krycfoXyCkNgJBvb
 H9YkPC4eHMvkrlaxSlwYY0+O9XyFivHyyJYLz/ApBCDKcz/66A8QJ0UJg1PJ/6QJq8yQ
 F0WbtQbcjM09izrzHTCLBWvRi595qF4m+uH6Z6gGFuRFMFsob8ilHbN3b1OC6b8uTBOM
 TxupKzqcd6WUWHf8Ezr0oDokxjEOpq5ffmjBFf9f4/7BEsT2HBIgL+sjZ9aDJBp2zQ62
 EcU2ZXNdYu2mD3mlEpxRfdM8waxDgbKSFwJ3jqgfUy1vHl6HQwU9nHUiavHUn9Ed4dbL
 0Bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769883124; x=1770487924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yOsEmFEyG/+JsSwHUpNCLQqej1Ob2knNViSxk6huaDA=;
 b=fPMmJOa1WD9RuXFsObHPbejQrg0YNzGku1nZGEQokBEbdj4pEmgMUtgttpobmPznsm
 OKdTtLQ8UJbjVpQuplnot0/S30vHULm+AMn82fFaBweSR6nKJGVDd/xXvEa7QIgdX/O6
 TRFcGN+gQ2uIU9+Yn4BkVNQgaaJ+S9g+GTMG8n3EOvBjpdW9g+d6pff2ajQNrSQb7C69
 PKUWviUCLuz3+IxfeuSNTCeNAB8xaR+LSMVmJZF7M7jIz3UfpdwERsGiiQHcEVAZ4pUa
 HNnkI/yBrA3Xi7Hdd80u+TX2o9rYYxOTauj+2tiOd5NtvYFGJkPjZjc9Ij3fJDZZu608
 tS8w==
X-Gm-Message-State: AOJu0Yy0b/dnZX9EyJcK7hwhhIiJ5I8JLIDtHaI91SngnHia6piWlMah
 WG0RhGB0RRu/cbSol505zDXO4GNH1RwsSy+G806gb9Kfw9xP4PsNci33gvelwPPjKdk=
X-Gm-Gg: AZuq6aLdL/GaNVc2oNB6jzsOdoEDjZUp/taqFFDVwUYSAglvgs9vP+8ikhDTouFOCah
 etXLRT80/rnqsD1tQ4hsajH8pueinCTnHBFuE+fbtYnGpqsND8UG2kQ524SK48pmIqdWTkvRV3G
 BtGBjkuAYSYHzIK1WQPcakOKlym3opyEZfMUAGMHgGlhow4uRIWj4FU4CTMyC9pfVA1umVtVt6V
 Jq9Ayhjw6e5z8qiDl+zg/4pkK7uK0JYDbMluciRLQD5YBuaorAnxPdmpXHXaX6rAqLFluTyLL1c
 X9J8/R/zjqGHVCq9CRZYu3QB/9af8hIYwiIr20YQegz84Ko21kYFyQAdb6unxSfP6uzlz8VXSUp
 58MqHag3RU7qroug63ZadVHNGqqSfUsgKaHEjdF52tr1yBxluc3U5C38bC4xwGrKWqixhCb/4Nj
 G2Gl2C3DzNacvho4O/GvfPPT9AsQ4lqrKXRp20arv7NuA3Xjffwtr8
X-Received: by 2002:a05:600c:474a:b0:46e:35a0:3587 with SMTP id
 5b1f17b1804b1-482db48e828mr83999925e9.27.1769883123755; 
 Sat, 31 Jan 2026 10:12:03 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066aaf235sm328662865e9.0.2026.01.31.10.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Jan 2026 10:12:03 -0800 (PST)
Date: Sat, 31 Jan 2026 10:11:57 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 0/5] net/zxdh: add support some new features
Message-ID: <20260131101157.4700d0e9@phoenix.local>
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

This looks much better, there a couple of AI review complaints about
commit message style. I will address those during the merge.

For example, the AI generated commit message for the second patch
would be:

net/zxdh: optimize queue resource allocation with hardware locking

This patch refactors the queue resource allocation mechanism to improve
performance and reduce complexity by moving the allocation operation
inside the hardware lock critical section.

Key changes:
- Remove the complex zxdh_common_table_write() function and its
  associated messaging infrastructure
- Simplify zxdh_datach_set() to directly write PCIe ID to hardware
  registers using BAR0 memory mapping
- Move queue resource allocation (zxdh_datach_set) inside the hardware
  lock critical section in zxdh_get_available_channel()
- Remove the separate zxdh_datach_set() call from zxdh_reconfig_queues()
  since it's now handled during channel allocation
- Add new PCIe ID address and size definitions for direct register access

This optimization eliminates the overhead of complex message passing for
queue setup operations while ensuring atomic allocation of queue resources
under hardware lock protection.

Signed-off-by: Junlong Wang <wang.junlong1@zte.com.cn>
