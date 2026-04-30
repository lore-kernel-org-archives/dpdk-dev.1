Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F570FF8873
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 17:36:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 452D64021F;
	Thu, 30 Apr 2026 19:36:21 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 61E32400D6
 for <dev@dpdk.org>; Thu, 30 Apr 2026 19:36:19 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2ecf9e398f4so930065eec.1
 for <dev@dpdk.org>; Thu, 30 Apr 2026 10:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777570578;
 x=1778175378; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=3Y5UEQz8XWRiuPP2sKah1DZYQWMG+cUyuCD1oiLe6wg=;
 b=habVvZPA+iU2tfm+2mEuh1YLTQK6LU5PxmQwJ/o4otOLjNRkndGg+HFi4h9pFprZej
 Qw+4WeNHwYnnX8cxdkCUxdHlhMGsVGMLlfJG56gZSx90R/+Mu3vSlSdQ4PjQBYVIZVFI
 wY5COBatusbTcMwnH5MdExQPuUOOvwoEcDTYI2fii+pj49WWzlY7XTbyGgD/wy5ggB+I
 Lb8B5V5nfMp1ksM6joiN6lntbz8fOtfahG5WL6B3lT7qvp/MkQJF3Bd3CP2H44K2wpMW
 p62Mhu5P8u+E5JMDrj7yX16Kibg7tDythEjbVHAIexpGXG9J0XbbWuWxYrd8WbUaKPuR
 8fDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777570578; x=1778175378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3Y5UEQz8XWRiuPP2sKah1DZYQWMG+cUyuCD1oiLe6wg=;
 b=ki0G2FeJexri7MMUwnomylxNyFg5UtwA9WOlZv/WI7PLya7MfPdh3SmddLl3n2qZv6
 4EQdTxBgq95GQ17FNfxPJE6v9QHhhVWtpRD+hNQGe69+vfeMBdPJ507WohQG39rmzORw
 pDpxsLiX1T5G1ByYf7VulnRaT5wROQau3VCwfI0nU/90gUqodPjJYtWQ2K0UREu7yYhu
 7hgHueyNjF6Oj6wtMlHFZLp1CE9dYcguQC6ZTILzUphK1JUa4QxTUv+2k9oi7r3OyqRq
 rP8xkDy6WqkNtQmMXse7uA6PnkJzxB0MBJ2/wA+Bx5osGuOfYUvQP/X8icoOEFanzIFb
 ieEg==
X-Gm-Message-State: AOJu0Yzw8+FK3lJ//uvxKvAYMaeC3F7SkGclG1KTMMy3satWYkWRzoQ7
 ftFt3oAHR0aMNhrI3IkGHF9+ZEu2LSs4FKNUsWKhm5luufUEt+a7mX9HR9F+rwcN3NUDihZylvn
 pTetA
X-Gm-Gg: AeBDievYFjzgS/oljGhefg73DIqkPY5YmGZwPv7Y2eDhsZ1k+mX7SP6flZvItXszfZx
 IwwLnt6kzFdjy6ZbW8lJ1EXNHDOcAClDa5RIsEeD89HGFX3crHm01BDos3GIUmLcc+05W9vdhxo
 djlvxK3YoFWbTyT6qXVhGOzRkV66eGjr4p9BzSCZRsRLFuzYM8uvP32FOCMSG34/+2ODvVPlebs
 NClGg3V3zFAm9OGInpO4iGiWbi6UKVsSvFG/yNvpIe5VkbWTYkBI8N+LDuJrHb1gphBLp6NGuE3
 6IduoqDLhSYnbHtf3/Xo2sYCtf5rkbbfoDRg2j6D74MjcUkb5+KRpyoxHb7hREqFaooFwOAKTZ3
 GDOUN7VFUEjks0XPoHUw983nN/s/b8RmakTfOTaQLWPFgg3EyvGj7RX3tpm1Z9tDKQvWKEsstgp
 o3JLH0JTlQTQMRLYLEF5hTocmoszDjBjJhjHAFNutLbV+m6w==
X-Received: by 2002:a05:7301:1905:b0:2e6:e504:5431 with SMTP id
 5a478bee46e88-2ed3d8bba29mr2122525eec.22.1777570578125; 
 Thu, 30 Apr 2026 10:36:18 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3b29b11fsm730959eec.19.2026.04.30.10.36.17
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:36:17 -0700 (PDT)
Date: Thu, 30 Apr 2026 10:36:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH v3 0/7] fix use of pthread mutex between processes
Message-ID: <20260430103615.47270705@phoenix.local>
In-Reply-To: <20260429184739.706250-1-stephen@networkplumber.org>
References: <20260413171836.123467-1-stephen@networkplumber.org>
 <20260429184739.706250-1-stephen@networkplumber.org>
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

On Wed, 29 Apr 2026 11:46:37 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Several drivers and the ethdev layer initialize pthread mutexes
> in shared memory with default (process-private) attributes.
> This is undefined behavior when secondary processes use them.
> 
> This series adds PTHREAD_PROCESS_SHARED to all affected mutexes.
> All are on control paths (firmware mailbox, hotplug, flow ops,
> PHY negotiation) where sleeping is acceptable.
> 
> See POSIX spec:
> https://pubs.opengroup.org/onlinepubs/009696899/functions/pthread_mutexattr_getpshared.html
> 
> 
> Stephen Hemminger (7):
>   eal: add helper to initialize process-shared mutex
>   ethdev: fix flow_ops_mutex for multi-process
>   net/failsafe: fix hotplug_mutex for multi-process
>   net/atlantic: fix mbox_mutex for multi-process
>   net/axgbe: fix mutexes for multi-process
>   net/bnxt: fix mutexes for multi-process
>   net/hinic: fix mutexes for multi-process


Applied to next-net
