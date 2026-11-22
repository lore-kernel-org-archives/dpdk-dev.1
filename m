Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B15606A320
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Nov 2026 18:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RIyB4+l7
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C7EC402ED;
	Sun, 22 Nov 2026 19:04:19 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTPS id 4790D402B9
 for <dev@dpdk.org>; Sun, 22 Nov 2026 19:04:17 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2f0481b35c9so12907615ad.0
 for <dev@dpdk.org>; Sun, 22 Nov 2026 10:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795370656;
 x=1795975456; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TgDGKEGoniUMITnmM4+2/SPId7S1LXne/rA7HjrDJAc=;
 b=RIyB4+l7R3o/y0vss70mpbcNrHpzxlHP3ZXvFTiwfeA3vQIZRcGIb4q5UQJA2EVTLs
 Fjfs3PsvorPDGlwSzaGdFkXNS3AZMQaSJ80OjQ4bZK/g8Iifzk2AjXcktk/xXnW3+MUJ
 S6bjDohSJ19VU4JHXQUKYZFVyUBi+M/xO0NJ+Q7/ZYdZy6FaMqM9so0qNf6/wW7+lcfv
 6BbDAg3eO9fo2OY+8NEBnH5z/oGQxAx2/tGemtIjYYvNPRB8urw0UizwdeI+xDKHHQuV
 uz95Y87PVaFE56pDxPMUspEvxvC4SD9OWi7eT4+eLJqzR8Mx6BlSj69Uf1cIMxGIUAVs
 z21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795370656; x=1795975456;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TgDGKEGoniUMITnmM4+2/SPId7S1LXne/rA7HjrDJAc=;
 b=a4jYvmoMFwcaLZPuf12E9Au82DXXagVx7TITKczYHaHl+1dat6bRbqYvV9awt7FPW/
 lxj/t2/acdqHb4gNwQdTi9XC2OUTqIbt1Z+MdCV5Zf2rOwRQcfPsfmmc+dWaurHsmGT0
 KE+5Iaj/kpZmecdcpHxZ1tbKyJdXWIq0MppAhrbnNf59+AlRCe7gvzcAwk2s+XgMQu+P
 oIxUR8LoOs0p3Q+8F3rEfsR2l6w7g3jO2rehAJaFiGDAD3gMJrFSOA00hRGgA76hsbnf
 kqeFh42ulKdtBJeI8ZQCPcIiHUzrfZO3lqpTIPnxR2DepnIXh61w7kUQMQRstEU1A/Fi
 9L4w==
X-Gm-Message-State: APuU4Z/JMIwUYeqV2yFVKbjO9hccY8DiTtQfbPbqL87kRwXAIdjdz9+3
 YsO7NJ9rp2FA7xNlznbYg6eX5eTWdiKxdClm6cJCKFAp8ZdEAaMilFsAmS51K9of/Y68w99H62u
 3gRYR3g8=
X-Gm-Gg: AZFdTZeMT6TSLyGCXNP8641i6DyuT9ef/YVfbE11rsGC+m+qDvx6PJYvVXs4kTyk8JZ
 wI5FrbNJISuZEb3m19NkMdNQ3ndARdRqh14PLXNF/e6TUgwo8V89nlNpo08Dzl4JyY72b6WQza3
 5szeWhlDr+0NXCOT+wFbbdcRf/07j3Bi1MLjrZsZD9FJq5GrkUzP5dqAIqp3jOSN8ifsMGhxk3S
 cgZjUxFzMAYGncl7H9hzjmEZj8EehNmM5wzGpk4dms6xoQ0DR38C9UKvQ9/ID/OeO54S/UxSpYy
 ZwxO17TdAS6N1Xtew7jQGO2ZZfz2JObE6XfL/3n17kMFFr9Q3P/5JIeyGCaTD7s4Noaxc5hBcLr
 ++gWaT48eVWar3b8xcVdHgxuTWJZ12tQByksyRYXe1i/2icg0tec5Nag+OcD/C00T9Mhbffxk0P
 ogxZ3PVIKFwZDQn+ZivhpaEcBlBGISkLpWlBDeu914eQcOzA5+6O7Gxhoc9d2DaUztygkYRiEgN
 aUqogPElNtnt3teL+iQ2u2dcRDsObKZRA8pLA8eFUbk64m+z6pQ1FPgXoHnzuMzKwuBaYi4bpGR
 7KuFKmrpKLbkXP4iAkrrT3ijwDGwokDOMBc1rqS7GKsY7JICm6/p5rSDZJnBF5Zb1Kj6OmEUILD
 G0L7A7iUgcfFOgQi+Zw==
X-Received: by 2002:a17:903:19e7:b0:2df:a4d8:57ad with SMTP id
 d9443c01a7336-2f03f271d6dmr77853655ad.72.1795370655339; 
 Sun, 22 Nov 2026 10:04:15 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f0c1a69sm38587815ad.18.2026.11.22.10.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 10:04:15 -0800 (PST)
Date: Sun, 22 Nov 2026 09:47:08 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Renyong Wan" <wanry@yunsilicon.com>
Cc: <dev@dpdk.org>, <nana@yunsilicon.com>, <qianr@yunsilicon.com>,
 <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>
Subject: Re: [PATCH v5 0/4] net/xsc: fix issues reported by GCC analyzer
Message-ID: <20261122094708.1571e625@phoenix.local>
In-Reply-To: <1795357356.312312@yunsilicon.com>
References: <1795357356.312312@yunsilicon.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 22 Nov 2026 22:22:36 +0800
"Renyong Wan" <wanry@yunsilicon.com> wrote:

> v5:
> - split the second patch in two, one fix per commit, as suggested by Thomas
> - no code change, the resulting tree is the same as v4
> 
> v4:
> - free the jumbo buffer only when the last representor stops the device, it
>   is shared by every port and their Rx queues still point at it
> 
> v3:
> - free the jumbo buffer in xsc_dev_close(), the device removal path does not
>   go through xsc_dev_uninit()
> - drop the redundant parentheses reported by checkpatch, no functional
>   change
> 
> v2:
> - address the AI review of v1: allocate the jumbo buffer once per device,
>   fail the queue setup when there is no IOVA, and free it on device close
> - fix the leak in xsc_dev_init() and the unchecked rte_malloc_socket()
> - rename the jumbo buffer fields, they held the opposite of what their
>   names say

Applied to next-net for 27.03 merge
