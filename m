Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF17C5AD2B
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 17:25:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FF9C40612;
	Fri, 20 Feb 2026 18:25:40 +0100 (CET)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id 7B09F4026D
 for <dev@dpdk.org>; Fri, 20 Feb 2026 18:25:38 +0100 (CET)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-8ca01dc7d40so221536185a.1
 for <dev@dpdk.org>; Fri, 20 Feb 2026 09:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771608338;
 x=1772213138; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EBKZFJrzKxmkgzTgPJgraz31CP9UFAoOg3nNt82cmbA=;
 b=js9xfLcjVC23qAt1Yl4mDi9QvM6qlf3skg+fAC6v4BmCG03RtkEyGbS5BY2bThHyhg
 qRYrpRBNJ407+VFJbYzKIpHrUJ8ydv+i2pIb0vE2uFafMFg+mo6UMTqQ/H225KnoK1Mu
 I+74FzBBbOYGk/G4c863WaqbroySonusjtJFKYw3JrT3dpvdQFVxSsVoIVpFHxo9oVcw
 f+5jIbKLRJkppYoSMC98LazQ5alII1guPJN4RrtCOlILVewGvRH9VEnzK5dx6XSTAgm5
 QZn/uCZqmDQC1BdzAKQtBKBjvWMDvTMijYDEDRQhzYxjHQqxpXzMH8CjQBBpOvp8nyik
 TTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771608338; x=1772213138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EBKZFJrzKxmkgzTgPJgraz31CP9UFAoOg3nNt82cmbA=;
 b=G6LnGJa7pRBweEQPfbJiCPYtmUDb0K5YYmhSD3V36uPUk6P14RVIwzl4guciXQG+Ke
 fub5jDsem5z1hgj741n9urXyXg44jmxPZrdQYik8qC3lbfXPGpw4pddY89X+KJXGOagD
 ZPEZCdaF6e4XdCtUbL2WprFTFSsqB00VC87sgL/6flYlip/O2N2L6ZTAlmh0DzOm9WWb
 DtAMyhqN3PQK6JK+xiwsxxKYRsooEImmfOVxgy6L5xPN9qiJtWgz9blBGMqj2ZWypQZY
 R0rbhjIWJunAO+V0DrdrtKORgUTFS5cyJYRjPsuPXpzRTnOQK2dkV7Ro0dmpce/lCBXi
 t02g==
X-Gm-Message-State: AOJu0YyzCg3ypbsBXWkNvOtZethupl6ApH2YjWaVUaZKoEHPKXlQ3ouu
 8yEtZ3IS/+pAFOc3lOifpsYxic/bljTYvz6PqjlNpaQGzbNRQcq8W8XyadTwfoKfqLFaOcmJBx2
 1bfi5
X-Gm-Gg: AZuq6aKgPv4mIx0FpOkxaN8SisfxI6Z05d5FYpHKBUYrgQwswFDYbLbrWNVsds1N1UN
 AwCFghoLfipe01gtHgUHBEX95aox+yyt5hpvFUc2fp7YnkmsTK+PGpjq8/zh6iYGi81oI39ms3f
 pjm/UwV3iNt0Qi+zb83/ba83v+weMlO0QLftz+j2p581U918MJXR+pcuIe3nut2ZL2+3v3wHEM/
 +cqBeeKtw71tO3h8nK/IarQaetM3O3Eu9BPUfUT5fNbTBZXtBDcZMeEu3mstAigPTbfqXrTfzE9
 flO73MG6phhAksKMl6mSXbB3KxnR6WwsfJkbQ8MBvufQQgO4AbH85CxC5UXXojpJLPB0K9EGhBZ
 kWoFe8vyMTVuq9vpXIFgCe804YAYObbeHpOFifd0qzuaQa+nh0ni6q+r8IyTM5WvcmddPmPz3WD
 +AMsLdyiBqePEzTu92TsGpoJ5qZLjR1F0bbBLhqjtIhwH63BV8z35778kp9kO+lWEv
X-Received: by 2002:a05:620a:4729:b0:8c9:eada:f3f with SMTP id
 af79cd13be357-8cb8ca83705mr33338685a.67.1771608337732; 
 Fri, 20 Feb 2026 09:25:37 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb2b218258sm2346567185a.47.2026.02.20.09.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 09:25:37 -0800 (PST)
Date: Fri, 20 Feb 2026 09:25:34 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Harsh raj Singh <singhharshraj215@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] examples/l2fwd_acl: add ACL-based L2 forwarding example
Message-ID: <20260220092534.4c4bbc50@phoenix.local>
In-Reply-To: <CAN33txEUWT_1wJMa2Rz_XNYQZyqGWrQgzkicWJvJEcFVi2+20A@mail.gmail.com>
References: <CAN33txEUWT_1wJMa2Rz_XNYQZyqGWrQgzkicWJvJEcFVi2+20A@mail.gmail.com>
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

On Thu, 19 Feb 2026 14:55:02 +0530
Harsh raj Singh <singhharshraj215@gmail.com> wrote:

> From 9d87abade4e79b4377367bbcbf79a1095beed127 Mon Sep 17 00:00:00 2001
> From: Harsh Raj Singh <harshraj215@gmail.com>
> Date: Thu, 19 Feb 2026 14:16:16 +0530
> Subject: [PATCH] examples/l2fwd_acl: add ACL-based L2 forwarding example
> 
> This example demonstrates usage of the DPDK ACL library
> to classify packets based on:
> 
>   - protocol
>   - source IPv4
>   - destination IPv4
>   - source port
>   - destination port
> 
> Packets matching ACL rules are forwarded,
> others are dropped.
> 
> The example provides a minimal reference
> for developers wanting to integrate ACL
> classification into packet forwarding paths.
> 
> Signed-off-by: Harsh Raj Singh <harshraj215@gmail.com>
> ---
>  examples/l2fwd_acl/README.md   |  18 +++
>  examples/l2fwd_acl/main.c      | 249 +++++++++++++++++++++++++++++++++
>  examples/l2fwd_acl/meson.build |   4 +
>  examples/meson.build           |   1 +
>  4 files changed, 272 insertions(+)
>  create mode 100644 examples/l2fwd_acl/README.md
>  create mode 100644 examples/l2fwd_acl/main.c
>  create mode 100644 examples/l2fwd_acl/meson.build
> 
> diff --git a/examples/l2fwd_acl/README.md b/examples/l2fwd_acl/README.md
> new file mode 100644
> index 0000000000..5b5494e297
> --- /dev/null
> +++ b/examples/l2fwd_acl/README.md
> @@ -0,0 +1,18 @@
> +L2 Forwarding with ACL Example
> +==============================

Patch is corrupt and truncated.
The rest of the patch never got sent in email.

Check your mail client or use git send-email.
