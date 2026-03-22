Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDD4FC72CB
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Mar 2026 16:43:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1748D402EE;
	Sun, 22 Mar 2026 17:43:52 +0100 (CET)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id ED29B402CC
 for <dev@dpdk.org>; Sun, 22 Mar 2026 17:43:50 +0100 (CET)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2c0c482e069so1593442eec.0
 for <dev@dpdk.org>; Sun, 22 Mar 2026 09:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774197830;
 x=1774802630; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4q+9lyTVektNKgbsZSnHSjcwR5iNWFgRNJdcBlS/4tI=;
 b=qNTlrek0v0ooFgmAbNkznD5Q0lhSSmKr4qipqJknTjVlTlI5rZai4mko7cDv5BpIJR
 DkE56kTyW/QqDHE8EImR7e9IoKL+90Yys9dwhrQjOH//iIErCtpaWAHDS4o2xchvVywx
 kxfXMhENzxUg6PaEGSXGf/IFYO6ax7m7X3Z8oTXc7Zg7C9udUa54/2z9RR3kulFLRtwn
 KPCBUh5/SvHouecwFb+lWuDhV4mph6HhiBJuZY9EDF7Nbbi9+jjMeD8i8hIK0VrWQF2Q
 +fCjl+wqzdFglhGfn5zYY0cNCbKKDvcbvzW5uEXZu45QzK7hsq7OlswO1UbIGDPVRl5q
 8fTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774197830; x=1774802630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4q+9lyTVektNKgbsZSnHSjcwR5iNWFgRNJdcBlS/4tI=;
 b=aaZEi3w3T/y4kR4sdRSBy+Tt5lU1BI7H1qIMCFgynnq6xAeBmXvs+1ccG9474Fb681
 5+O5d1RhF4qBQKRFHopXl2ZgblCfMUrAJZqK2Irnr/1tYXAoK1gOaA12na7wGUZnUB/W
 O01meiw34sYdnJRGyI8YKJOiYsyIe6ynf4jxW2ZL+CR3UZsfFnh3CjrUm5B8VqpC3uga
 ZGwtHV6a1V5f/wU1P1+bQ/J4Hh6S1pZU2r2DqOLrRJpEXBn8amwK0/YFvZmyWvNhp4gq
 YGuIhnVcmIam2b2nIjL9DsU54SpVQ2zCbYjVjJbjNWC4ZP2ok7zBnd2ISRDoPUuXpnnc
 pNmg==
X-Gm-Message-State: AOJu0Ywr7Hr3YqZ7VA5mYgrXyq6D/393goljSaYZ0P839mnI0GN2w5uH
 Tz9GLF2SEQM5QEIj27dWeigDZhcVtU1fsBLm607vsE+AU7nxwwc+GqyHFdaOA1p539Q=
X-Gm-Gg: ATEYQzwquQ/HDt3qyiDXloVexiPFgFinn4t95KUi9Ww5vUmwoe7Ln4KPWAKIGKwGA2S
 1yKd4lNKRBPp5AxYC9MBd+g3XaMmgfbepTyD/kwqYdM+eBUztDxOofxmolRDjhHec/JLYcHAnRn
 3ZOJdFITG8usLC6xDpnCxvKC9hS4BKAxXPyOu4o4ZHuFkkkdEDsMY8QTG0xpkXUkePqeiX2fHLZ
 26avsHg+k4EGXN6XkAdkoTtHQc7xc7z15ZzoPDvPmj+Jee4vi2yuGzEafN6vJBOd626xO+Vs0Ew
 2NMRUKbWNCdJs+KnndWN9rrQrNn1DQHzJn9AzA8PPB8SE0ZOTJv6aEuJO1/0kLjb8MgFYRL3//n
 aeNX4JCV2MraAPj6YVDb/9l91yill5aT3/Tw8bWiJPXRSn9oKP0gyJSIfmXJNIRqPqUhVmh+iNX
 eJ6aP8UOtqLry0sCBe4qc2wdTymAchOktymj8=
X-Received: by 2002:a05:7301:1486:b0:2ba:68d6:47ae with SMTP id
 5a478bee46e88-2c1097ab4a5mr4021127eec.34.1774197829896; 
 Sun, 22 Mar 2026 09:43:49 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b14cadbsm12300045eec.3.2026.03.22.09.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 09:43:49 -0700 (PDT)
Date: Sun, 22 Mar 2026 09:43:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org, rjarry@redhat.com, nsaxena16@gmail.com,
 mb@smartsharesystems.com, adwivedi@marvell.com, jerinjacobk@gmail.com
Subject: Re: [RFC PATCH 0/4] VRF support in FIB library
Message-ID: <20260322094346.52a87b29@phoenix.local>
In-Reply-To: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
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

On Sun, 22 Mar 2026 15:42:11 +0000
Vladimir Medvedkin <vladimir.medvedkin@intel.com> wrote:

> This series adds multi-VRF support to both IPv4 and IPv6 FIB paths by
> allowing a single FIB instance to host multiple isolated routing domains.
> 
> Currently FIB instance represents one routing instance. For workloads that
> need multiple VRFs, the only option is to create multiple FIB objects. In a
> burst oriented datapath, packets in the same batch can belong to different VRFs, so
> the application either does per-packet lookup in different FIB instances or
> regroups packets by VRF before lookup. Both approaches are expensive.
> 
> To remove that cost, this series keeps all VRFs inside one FIB instance and
> extends lookup input with per-packet VRF IDs.
> 
> The design follows the existing fast-path structure for both families. IPv4 and
> IPv6 use multi-ary trees with a 2^24 associativity on a first level (tbl24). The
> first-level table scales per configured VRF. This increases memory usage, but
> keeps performance and lookup complexity on par with non-VRF implementation.
> 
> Vladimir Medvedkin (4):
>   fib: add multi-VRF support
>   fib: add VRF functional and unit tests
>   fib6: add multi-VRF support
>   fib6: add VRF functional and unit tests
> 
>  app/test-fib/main.c      | 257 ++++++++++++++++++++++--
>  app/test/test_fib.c      | 298 +++++++++++++++++++++++++++
>  app/test/test_fib6.c     | 319 ++++++++++++++++++++++++++++-
>  lib/fib/dir24_8.c        | 241 ++++++++++++++++------
>  lib/fib/dir24_8.h        | 255 ++++++++++++++++--------
>  lib/fib/dir24_8_avx512.c | 420 +++++++++++++++++++++++++++++++--------
>  lib/fib/dir24_8_avx512.h |  80 +++++++-
>  lib/fib/rte_fib.c        | 158 ++++++++++++---
>  lib/fib/rte_fib.h        |  94 ++++++++-
>  lib/fib/rte_fib6.c       | 166 +++++++++++++---
>  lib/fib/rte_fib6.h       |  88 +++++++-
>  lib/fib/trie.c           | 158 +++++++++++----
>  lib/fib/trie.h           |  51 +++--
>  lib/fib/trie_avx512.c    | 225 +++++++++++++++++++--
>  lib/fib/trie_avx512.h    |  39 +++-
>  15 files changed, 2453 insertions(+), 396 deletions(-)


Not sure at all if this the right way to do VRF.
There are multiple ways to do VRF, the Linux way, the Cisco way, ...



This needs way more documentation and also an example.
Like an option to l3fwd. And also an implementation in testpmd.
