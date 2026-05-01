Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC7ECCFA13
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 May 2026 22:57:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27C13402D7;
	Sat,  2 May 2026 00:57:08 +0200 (CEST)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by mails.dpdk.org (Postfix) with ESMTP id 26EAC4026A
 for <dev@dpdk.org>; Sat,  2 May 2026 00:57:07 +0200 (CEST)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-12c637089ccso3797482c88.1
 for <dev@dpdk.org>; Fri, 01 May 2026 15:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777676226;
 x=1778281026; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Shh1UaXxIU++ZxclSDpofiXQXlavkgDUX1akFVqVQvg=;
 b=kd07xPGsLjv82IDPhqnAczbc3JIn5yuAvZK5kd4htgt/GmQWZnPojCTGr/7a+Pc+4+
 w4af58OOtD6AfxuhlnC63gH0SAGdYUsnf0Mj9piXZkEGoksbQcCXYJWylshr8pRwVWHi
 zP3blYL+0uO2QmwOQI9pK6KAJr/HhtkuaWRNQsLsSOwib5HX9Hgx8O7OwqiyMZ7bWito
 i3385L1PhwWcFqnMRwuzu6M1jQEEbGIyDA8N0XFT/FVXr/lwHZwaD568tK68gl52+zvc
 /XhDljlwRQqghS8LEyFEiglfkA1ZOrpsUzEUggSmd1fGaRN72jvdsMwt2XseFm7stm1k
 vffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777676226; x=1778281026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Shh1UaXxIU++ZxclSDpofiXQXlavkgDUX1akFVqVQvg=;
 b=eWNvh6PCSlgslhzv1tOwq5+oL+WJarQ/9Mcrvv9en9uwfcVI300v4GD2/jnsTbs/Zs
 +wDLMq96HqiAKLY6sWfzNWevWZSMtxP4Pt5X63etoMHaktUqQ81MJSjsZDic34wzdqa8
 6FwIwlL/pU1ldj/93qB8XUP+EHzuLtokkRMDF6Rv38TQRqH6mNEbOnBuLWVrb99uvfAI
 P8Rgpl0eKQjtPzuEMBd2hZiOxA+cp7j65qF/Ep6Dd2DhykonA5QbT69DPjQdzr4gEheQ
 uBgnwLFGqhiAkXXkqnK73arX05qSgnAarE6+zTtrPA1unT641XCA++ChZJGFDLIAuZ3+
 mHrg==
X-Gm-Message-State: AOJu0YxgNlqqqPMuiZ6GXYk9DbceozNRWx0at6IyJBHC5tVrIc3435b8
 GkjL0S/nVrj5TcCn/RiR2jN0xCbGX89RoXwKWMBeEDZas6Em46IxI6+B1nBELBeoJio=
X-Gm-Gg: AeBDievw/PYIklSkV7mF7IPMPXMH9gkbeJUH3J0Lz5lbUMPDNxzBLH1Et0gN+Vn/zEt
 +mJaH4zr8NkfXE3+v9SJ/CAb1ob69t4ny3jVhGLWcnyG/R88oyxNX01cCBvqidE86QrUX06lNr9
 sPbalKuVcMz3AKjsdwspSTPt7cuQt+EDa6oG/ORPkHUjqGzGq1YCOQWBUYlk7YvQsM8u9Iixybb
 fVo7mAY1oZVVfhq8KC2rsi+aL4kNMxsMuHeuutHUvkbu12W8BEy9XnHbr7OODux31d4GZi73z1a
 SGJfNZtavKrjR54NzAk2tKDBZ2G2LtIB0lp47uY9ez8jW9kPV8ShzOlpoejzgUDxvNAebNiP87p
 8gWSwtaOx960paqnnq4fzBb1RNZyPEDab4yAMEsS7fxmW1Hcr2Uj8hoS80Eh7cmBamorZbrd0nT
 qy2UPNU22ceWfXaCAKdH0Qnay1sKaCB5F964sjx6VOk2TuQMmgjT30JOIj
X-Received: by 2002:a05:7022:608:b0:11a:4016:44a5 with SMTP id
 a92af1059eb24-12dfd825405mr587329c88.24.1777676225986; 
 Fri, 01 May 2026 15:57:05 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12df8431037sm5088885c88.12.2026.05.01.15.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 15:57:05 -0700 (PDT)
Date: Fri, 1 May 2026 15:57:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Harsh raj Singh <singhharshraj215@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] examples/l2fwd: fix port statistics reset inside loop
Message-ID: <20260501155703.4614956a@phoenix.local>
In-Reply-To: <CAN33txFohZzwnKJ2uTDyMuQ9fWpMvJQ=6BCr-TURU19RV9EY8Q@mail.gmail.com>
References: <CAN33txFohZzwnKJ2uTDyMuQ9fWpMvJQ=6BCr-TURU19RV9EY8Q@mail.gmail.com>
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

On Tue, 31 Mar 2026 10:15:32 +0530
Harsh raj Singh <singhharshraj215@gmail.com> wrote:

> Hi,
> 
> Please find attached my patch for fix port statistics reset inside
> loop in l2fwd example
> 
> Thanks,
> Harsh Raj Singh

What is the problem here. That loop only happens during initialization.

The memset() is redundant and not needed but that is a different reason
to remove it. In current code the port_statistics will start out at all zeros.

If you want, the right fix is to pull the memset entirely.
While your at it look for the same pattern in other variants of l2fwd and l3fwd.
There is a lot of copy/paste here.
