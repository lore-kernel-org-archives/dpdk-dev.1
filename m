Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF5CC5DF81
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 23:23:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E039402CE;
	Thu, 20 Aug 2026 01:23:47 +0200 (CEST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id 9E0F14013F
 for <dev@dpdk.org>; Thu, 20 Aug 2026 01:23:45 +0200 (CEST)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-84a4d8fd6ecso1579495b3a.1
 for <dev@dpdk.org>; Wed, 19 Aug 2026 16:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787181824;
 x=1787786624; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xvMK82Hh2uDlg3xWCle4FayKYPYlcwB2eEw1gPLhnU0=;
 b=sh+ym65zYQzJxWopUeZRBifjK577GwpeiHxQcX7QqLCOUHHnHyXBMrXsdAGFbFLnCr
 P841bB/DF4pb9OhEuM5wt+lSQB56SCzoFssbPIXOl7QdWgaKlgp/PxOBjRgJaW40lam5
 S+kZTQlZq5eZ5tggG8iVxFWNq/irSNmsZ9BTn6m4vmhLCD0UeNqd7RGIMPib2elonNZC
 qH9LvxIc4uAQHhd5H762K0jpjD9XXkmVUB04aEBcSY7ncQStOZWVY/NGolXJvoX3/noq
 GpD5uO0Aha1vD4N+Zi8NiOcvUxGZcTjn4hggFmnFgu4J3QkAOn8jbbX8E5QxuaV0TrkC
 myuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787181824; x=1787786624;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xvMK82Hh2uDlg3xWCle4FayKYPYlcwB2eEw1gPLhnU0=;
 b=D8oUF5rymHDrr9B8ZlEzkxUi3eIjO6E/h0oLO58aEMdLMGQllr/Cxmv8SthajWLMBU
 ratgarMvkgKDqzFd7DzqN0BbqZo0BUv2q0dWpttUHsSdjelBAVE4aAF8EaUpTQP22Qjg
 xnoumBS0NRv8aBICy8jcV/OKUEEZ3QB9WmG8R+QoBMvJ4nsKH2PnTquOyLTSU4xlmaOt
 jVkVHCKXqLIVplKYhThmVdbyLuruGkKceM9HleUYo2yW+8UPqBKOqUh+qaDsAv+m7q7P
 w6ycb6/cKkZCu5MKQfIsnHv3t+GISAoT8jPVU2kXnhEkTtzFBNIU7e+zED85UCE8jouA
 I0nw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9wcv/m1aifoOW8ZnvoDixxapzDXva5yHEYt3BAD7+PBSK0aS7nTQGyWUhE7WQSJqJsVY=@dpdk.org
X-Gm-Message-State: AOJu0YwUE1Pjs7ndVFJp3jvnC6S2Rx8jzSlxYTDKV8ca9TMLFRV9UD2H
 KZinvfa0kuueAuA6AkJpv9W+JVqdpmsAmeheBJr2S9hxzJXHhk4zJ+i4frkbbRl1oA0=
X-Gm-Gg: AR+sD13MVN1lc62U4gaPpJW3RWYkHTzrlLd5y6lxPJDixfjdlK0BtGrqZmXcauoDoKJ
 dlfkB0LaIsU3NjyHQzt1cUE2r0gZpSkNeG72QXoZgauqfvMCIzBmN/6ZjhzXnPm20VnGZYrveL+
 s0kagDsTaATxpUbs0QdQxd7MTtg8RD+XTFE6jGWCMxFEX1Socx0Fq1JgOqbUh6pQo1m/M73uEvz
 bAnwO1nUPUOtDhubYPp/062aMWp8yjFMX2gHYv0muV765grdDmABL1ZryhWqb0mB8QkBVTgLfkE
 JOWWwKfyA7Gpj4CJxfY9HNqMkV7/Ts5WKmTn6Bn4sju1vZ9UOBsq/x4CtNRZsk5gcv7faTNlL9h
 1VOA/uW7zPG7LscX9cVd83+kpHnJmSwjHMyAD81H/BSMs5c4RWl7ukfxsy5VHuUz1iraAtNVc2N
 MBl7Rpzvr1aQVuHhVngn8s7eW1p6xE3fcjOgyHgI8xN3WG+q10WY0RKAROpMjHLf+Rrm0GlrdlQ
 CRHbhe+M5DnxcRo5tUheNWkkVmrPw==
X-Received: by 2002:a05:6a00:3407:b0:845:dffa:3740 with SMTP id
 d2e1a72fcca58-851d38203aemr13815107b3a.4.1787181824380; 
 Wed, 19 Aug 2026 16:23:44 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d3389fb9sm1116500b3a.17.2026.08.19.16.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 16:23:44 -0700 (PDT)
Date: Wed, 19 Aug 2026 16:23:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
Cc: Thomas Monjalon <thomas@monjalon.net>, Chas Williams <3chas3@gmail.com>,
 "Min Hu (Connor)" <humin29@huawei.com>, Declan Doherty
 <declan.doherty@intel.com>, <dev@dpdk.org>, <stable@dpdk.org>,
 <chas3@att.com>
Subject: Re: [PATCH] net/bonding: fix the log MAC address restore failure
Message-ID: <20260819162331.0261e7eb@phoenix.local>
In-Reply-To: <20260629135841.1181247-1-Evgeny.Sokolov@infotecs.ru>
References: <20260629135841.1181247-1-Evgeny.Sokolov@infotecs.ru>
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

On Mon, 29 Jun 2026 13:58:40 +0000
Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru> wrote:

> Log an error when rte_eth_dev_default_mac_addr_set() fails while
> restoring the default MAC address of a member device removed from a
> bonding device.
> This improves visibility of failures without changing the existing
> behavior.
> 
> Fixes: aa7791ba8de0 ("net/bonding: fix setting slave MAC addresses")
> Cc: chas3@att.com
> 
> Signed-off-by: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
> Cc: stable@dpdk.org

Applied to next-net.
Sorry for the delay getting LF legal feedback.
