Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A1AC88E6F
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 17:08:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CC4140A7F;
	Mon, 14 Sep 2026 19:08:45 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 6453E40A75
 for <dev@dpdk.org>; Mon, 14 Sep 2026 19:08:44 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2dd76b1361dso145845ad.1
 for <dev@dpdk.org>; Mon, 14 Sep 2026 10:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789405723;
 x=1790010523; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o4uLywBkp/yLe8EVv5qmAYka5XkLLd5Vxuy6Y6qC2Hs=;
 b=zMvks8poDdCrqomH98nQL2kZmGg1MDIx+ew3cG07Pg2hAGkylWikQmwJ6Diqo64pAy
 wdTWmS4EqkX0KYKBnIdXg2g4SYL7K/U0jhkzn4Hqqt1bSziYM9YBZJCChnfZfDtrgV1q
 jKtfbkGdl/j0VvOhKq9WIcFk/tPBph8bcC3bbmBRFOtCX3cTnM5xnO4dy3Uu1L8ydABp
 xuLTtHTeDQHU6URgo3YUOxBUOioKgPCHSTpYgye9G++8vkYWljX6DiNQz6qrD6Ph6sAH
 Nu+OU6PeRaq68KzDi3ivpuWbIrWtAGF3Q8viiIRW7GEUli/+YaQwAOhCb/sM3TmDOUqG
 aWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789405723; x=1790010523;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o4uLywBkp/yLe8EVv5qmAYka5XkLLd5Vxuy6Y6qC2Hs=;
 b=bxdl95cCWtKgawpoU0mybgb0TUrJ9nINzCmPOro1zkANf4ZcHFx23Tj6EnEWChxwhO
 eiDbFP7EPIP/WwTJQ6uXXkLDOs5vO0xK1qFHNCq/oDsaOg1UwTYceA5Oc7Ux2LNglGeL
 Eva4zJUARemCb+fTp9Bsk2wVihqJCrPu5iMjd1ZUPU7r1r8/OokK6vri8F5wNTZMHDOV
 McY7szpSf7TOQyvAba+6ZRKihqe+wS9ZDWUA4AbIYHXfzRLL+NMqq7S+fwsGO1IFN3qs
 ynQR6LDUgnxqtnK3VZAbxvQ4DM67F/v/Bo41H906dqUa9/eOi9xtj063Hvv1ewLn69Ho
 5mSg==
X-Gm-Message-State: AFuF++kiofBR5LBGZr/pOQCoNeo4NY1F9x1L7B3VbowuNoZUCEu/jHRb
 FGMwbetq8BayFMqyvgDqt0yI3hcwIPcjIWr3BEiPh7JP4Pshzzr3nsOY9H8UyiBFZdQ=
X-Gm-Gg: AYBFou2XBaPnE988Nq3idF31NH7oKWxrSLRnk3YInZr+RJvvlMEcY69yX0PQWCWOQVS
 hF9hxcYDUMqK8fYqfdZZpeoBz16G8t4IrCo0kCeq0pr5DDgQGIL6oiDU6VXj6ndQdINi7twx6S5
 Lc2fvx94/sSniBiIUjxxY7i3ttUskZkA8CdVuY1GhIXRxjMrTNptm2KA1D82gOjjgWJzfHgJGmq
 0y/ZRldAocPR3A/UoK8vzQQ2tKou4QJi0s45K4m2TY5lyLGtV5Ba3HCl9rJgfUTJv+TfLfBbS63
 W1V5PDJeKhY3dApZ1en5caVNU2U4uI1gegRwc2gK4OQpwvfv/2LQaj1psHoUqHPXGEeaoG8GHco
 vt4rpTxUSrW0VPD92P8a6dXBdJvHHDujwyxnVv+WpltjbyV1/pM+LBNzfIo5rwBloHyacorK3+x
 K/KH8IR6B3iiOCS8DciaypYvkwjCZnvTY9lwr9n3JexFi5LIDb/ylbAdA1nIvts8IgLmy3GDfWx
 eGtcVE0qoYRYiz2KOe/aHIRg2/7qFKaxoZvC1Bg
X-Received: by 2002:a17:90b:1d82:b0:398:a2a3:b631 with SMTP id
 98e67ed59e1d1-39dec0be84amr6669407a91.19.1789405723238; 
 Mon, 14 Sep 2026 10:08:43 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfda249efsm427964a91.6.2026.09.14.10.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 10:08:42 -0700 (PDT)
Date: Mon, 14 Sep 2026 10:08:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH] devtools: allow patch to multiple groups for the same
 driver
Message-ID: <20260914100834.25389d03@phoenix.local>
In-Reply-To: <20230420121240.28035-1-viacheslavo@nvidia.com>
References: <20230420121240.28035-1-viacheslavo@nvidia.com>
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

On Thu, 20 Apr 2023 15:12:40 +0300
Viacheslav Ovsiienko <viacheslavo@nvidia.com> wrote:

> The PMD's source code resides in the ./drivers folder of the
> DPDK project and split into the several groups depending on the
> PMD class (common, net, regex, etc.).
> 
> For some vendors the drivers of different classes operate over
> the same hardware, for example Nvidia PMDs operate over ConnectX
> NIC series. It often happens the same minor fixes should be applied
> to the multiple drivers of the same vendor in the different classes.
> 
> The check-git-log.sh script checks the consistence of patch
> affected files and patch commit message headline and prevents
> updating multiple drivers in single commit.
> 
> This patch mitigates this strict check and allows to update
> multiple drivers in different classes for the single vendor.
> 
> Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
> ---
This patch has sat for years now with no response.
As a maintainer, using check-git-log is just advice and it doesn't need to be exact.

So marking this as Rejected due to lack of ack's
