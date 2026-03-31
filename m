Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D3B10F9303
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 22:35:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38C5240275;
	Wed,  1 Apr 2026 00:35:52 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 91C214026F
 for <dev@dpdk.org>; Wed,  1 Apr 2026 00:35:51 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-82c28f0a4ecso4338746b3a.3
 for <dev@dpdk.org>; Tue, 31 Mar 2026 15:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774996551;
 x=1775601351; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WlyQ36RkMt8EhhuiEOGlsii+IvSlyZ9L/nOGI+LaKMc=;
 b=yJpxcJM5OvLtXlJKsuL+pamvFNlZWdDSUpWjnBgJjeBmWLyIlE0sbv0+wIYGg+bvGh
 9EyAtlwhA1DRku8LqGcqnE04hkNxaiM7mOOU2wA9w69ch6VG2qkGvNRhyHByKSKpIKPF
 96xzePLGWF5U3onBq5iU+iVW9uF+c8eitH+mDl7ozOByl5t/A/30sWvrfxHw2Xlhco7g
 zJ8zojCrGiysD14mB5l0lozEL1gtqGbZWjsye0yoRnRU0xIhDqj6tPtbHEyNJoIeL0lt
 AelA9zy1Q/qSZSUx5AZulqPRMkcjxw63NAvaeYo9YkPUj7li2WUT0Zm1tXkmiCRHz11W
 V/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774996551; x=1775601351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WlyQ36RkMt8EhhuiEOGlsii+IvSlyZ9L/nOGI+LaKMc=;
 b=LibKneoWWnJPtw3i5D85dSalLBdRoxQp+l25LgZ6X1f1w/y/XS43vI/xTHNp0O9fAI
 z/+pka57wK8u9CKxhKJ5JOqc9uOpuSptSYlwipl4OFY14yrRSTPI2/fdtQkcvGQG8CNx
 Zm9Se91PZL5faqAAO08W3dxopuqAiPJxhwJAyfni+Pu4l3DDygqsgg9KBUwdx50igZbs
 QsKPRaNixTxqySBPP9AWqWFDcjeJrssf9R2jv6eB4RTAlL1DpJsTOuszgODpTuTLb+OZ
 ykCi7SRJLFaiKRC8665eWDEoixm4d+gCgYs1jjnyN5XKH4f6r9PhQACWehmJ0vu2nhRw
 6KnA==
X-Gm-Message-State: AOJu0Ywh7/BwcE8RGfWuq4v/dX6zYTIBgAgR0krHdaQ63454l7vH6sLr
 gwLyfTCOr1+35Q7p/38PxZa1big3p71OBJPy87yDldAShBOr1fFB/fSCgcePcnyCxV4=
X-Gm-Gg: ATEYQzw2S436Fai+JDpUh5wp0x5X4c1gyrTb0XFLNQw5k/svekg9+34qcDqK9inwpEW
 Ts3pp/8eQQxDBLB82cd27cdbGlOxCuH4wqb3m6uFFVrpNRcHlJpECZSDOVLb/quNHFC1DfPtbfD
 SQijNcV6DAyla15pKzgWdOE9kaG4j9TIbHjxNEZheUoVF88DWaxw9J7H99zMTeAFl+8sMfeyR6o
 kDLum2LdKx159KrwEPJLWpt1yJeiv9hhPo/Cubai+EUJFRFp0Wk8XO91zpRsKij/UvUO7S95j8b
 lWMQbVqpfMPsrjW0iMCZys8iDLYkZNFiDp18vuMpqL7en1/4QPQSt45WqdVCCe+SZ8gIRXzO5a4
 vSgAOlF+vdbZlS8LQXptCWrHCpnjrHmi8wQ5vEiVvwkNhsLge8hwFCrVp5i/bp6cHTmpUZTnV/T
 b0hmPDWdCUt/ZJwRkkj6ToTyM+TqpNdCDLelh7Y+h/Zw008Q==
X-Received: by 2002:a05:6a00:b87:b0:81f:5037:a317 with SMTP id
 d2e1a72fcca58-82ce88d321amr1285243b3a.11.1774996550690; 
 Tue, 31 Mar 2026 15:35:50 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cec9c4cfcsm250034b3a.5.2026.03.31.15.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 15:35:50 -0700 (PDT)
Date: Tue, 31 Mar 2026 15:35:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Nandini Persad <nandinipersad361@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 9/9] doc: reword rcu library section in prog guide
Message-ID: <20260331153544.4e5109ed@phoenix.local>
In-Reply-To: <20240621023254.4258-9-nandinipersad361@gmail.com>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20240621023254.4258-1-nandinipersad361@gmail.com>
 <20240621023254.4258-9-nandinipersad361@gmail.com>
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

On Thu, 20 Jun 2024 19:32:54 -0700
Nandini Persad <nandinipersad361@gmail.com> wrote:

> Simple syntax changes made to the rcu library section in programmer's guide.
> 
> Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
> ---

These changes were integrated into https://patchwork.dpdk.org/project/dpdk/patch/20260118191323.241013-9-stephen@networkplumber.org/
