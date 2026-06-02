Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8045CD6E5D
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 20:45:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 123A940651;
	Tue,  2 Jun 2026 22:45:28 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 53EDA402A9
 for <dev@dpdk.org>; Tue,  2 Jun 2026 22:45:27 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-304545f5206so16306634eec.0
 for <dev@dpdk.org>; Tue, 02 Jun 2026 13:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780433126;
 x=1781037926; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+52diBrZJUsdGqimJQO1xyawDWICqCK+TQVEs8RDg4=;
 b=ZKZ/htEQ/dT7L/s9X8l1TOCYWt1NavPKcX1AI5Zqh66XfuuoeImiDEJtdwTRoWanTx
 4d4rBeSZ00J26iKTWJiLBQkQjTSx+7TTwctBP2ZgfNpYqZXjtEBpQ64Y/f56SddyAnMJ
 nDv5BAqoEJkgqif0kc3bumSYlrODIv+UxSLPkhCN+72D33JwekeuPGOoE7ZZw7smv4bX
 HXLJpf98uruSA4nlpDdiaMq71g4ztKEmonwVCQCkAsmbauwKszPYoPVrbDSpcDsGFRYH
 uNaNZCbpqo7liqDC/SjMhq4VFY4yx3m52JjySPu4EUjOycWh8LVpzlTJnMvn54aN/EQ/
 uvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780433126; x=1781037926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x+52diBrZJUsdGqimJQO1xyawDWICqCK+TQVEs8RDg4=;
 b=UQgSj7n9f4w7QyXlP6BODe/Eb5fUPka8rZS9bRVDOtQZVgs7C7de69L5AiHU93oK0l
 QpUltCloiFAJea2btIDLhqxuWEqjzFvSElDmc1Gh6cTqhBg5z0BUGzOhMe5JXyL/pjDh
 Ns0c/fySSmpFlICeEYjLObtdfNMDZ83zWBS+UByZysLwx9yUS3q9lpIquGWgt9e0QiFq
 jJY0uscg9oIyPwE3sF4VZgq8Ph92+pgoq9sfcRnyD2KUCN91feU9Ub22bekxfMsatT2C
 um4LWFztbdrd26wXIwAiFycxhLRumQB1s0LC2QPY/7wYorZZOZGZCIqLynm86O3w5hU8
 wgSw==
X-Gm-Message-State: AOJu0YzP6t/e60Xy+PTd30nb+ZHeS/9Y9IVAvSS1bbtGTT+pbSuNZGhZ
 2Fx2jFy8mbFNS9bO1CjZIfdhvH30kI3Wz0LJLdHkANK5gDXVXYYaovw/Enfw05GruMLEZMJqX7W
 KH8LB
X-Gm-Gg: Acq92OEvPzz5Ko7yyR2XzHfzyGOYiy5wVYPe59wdNmdnQEdvIRClJ0s9DlwWmCiJMtT
 Miro4fMT8lqiG5KHgFMcVu15GCU2cSyKPrrpzUrGm+vCVWgPUcjimHDIF36/X6a5qFFFuuKcc/X
 x/76mnZucRCh9PlwN/1lS0nnyfO0n5Eqwpo2QfZ6T1z5oAROIVeCYduymGQwKO+5YdeFwlUH4Q3
 e6uJfDv+HSJBw+inCkrOcvjA0Bhqr0nPgaLiksZFS+Dokulz1xlRzkPiUF5lpwYlsnhB2sC+Vw/
 nKL/JmxcqONvYeo33glBURMjKjYZx1xBmeoXevZKvq9/vEnXIiA85yt2V1q5N2zQ0uGTUjhiJnQ
 8a6foQCOmgXwjzi7fi7M5l/sPoJDQmNawwootw8Ym++QoRBX6A5ffq9AA7GO9XtPjC/M6MzkZtV
 e0V5JRPqz8ZdWELpEpy8Kx7sUcWFJ8jhR6PVE+/2V6Bip+Bm3b6Sym/Eo44wH8VUjrAbSEY9W3B
 m2Zk1EU4zuBqQ==
X-Received: by 2002:a05:7300:3213:b0:304:8364:e95c with SMTP id
 5a478bee46e88-3074fa92c24mr218976eec.15.1780433126289; 
 Tue, 02 Jun 2026 13:45:26 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dea9226sm418985eec.19.2026.06.02.13.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 13:45:26 -0700 (PDT)
Date: Tue, 2 Jun 2026 13:43:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH dpdk v5 2/5] net: support multiple stacked VLAN tags
Message-ID: <20260602134341.5d7cd7fd@phoenix.local>
In-Reply-To: <20260518132712.70913-10-rjarry@redhat.com>
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260518132712.70913-8-rjarry@redhat.com>
 <20260518132712.70913-10-rjarry@redhat.com>
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

On Mon, 18 May 2026 15:27:16 +0200
Robin Jarry <rjarry@redhat.com> wrote:

> The VLAN and QinQ code paths in rte_net_get_ptype handle at most two
> tags with duplicated logic. Replace them with a single loop that
> consumes all consecutive VLAN/QinQ headers regardless of depth.
> 
> Bugzilla ID: 1941
> Suggested-by: David Marchand <david.marchand@redhat.com>
> Signed-off-by: Robin Jarry <rjarry@redhat.com>

Another issue discovered by AI is that hdr_lens->l2_len is too small.

Patch 2/5: net: support multiple stacked VLAN tags

Warning: hdr_lens->l2_len is uint8_t. The previous code capped the tag
count at RTE_NET_VLAN_MAX_DEPTH (8), bounding l2_len to 14 + 8*4 = 46.
The new do/while consumes tags until rte_pktmbuf_read() fails, so the
only bound is packet length. A frame carrying >=61 stacked VLAN/QINQ
tags (>=244 bytes of L2 headers) wraps l2_len around 256. There is no
infinite loop or OOB read (off advances monotonically and the read
terminates at end of data), but the wrapped l2_len is exactly the kind
of bad header-length value this series set out to fix in tap_verify_csum.
Consider keeping a depth cap, or widening/saturating l2_len.
