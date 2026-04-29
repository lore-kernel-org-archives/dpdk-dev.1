Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2A4FF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 14:26:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 028574065E;
	Wed, 29 Apr 2026 16:26:16 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id 0EDE140151
 for <dev@dpdk.org>; Wed, 29 Apr 2026 16:26:15 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12c8ccc7755so13834665c88.0
 for <dev@dpdk.org>; Wed, 29 Apr 2026 07:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777472774;
 x=1778077574; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OYgVZB17MNLmk2paCRzAVX8szfH7PPjapdbl4hw/9M0=;
 b=Q2eoyHOlbeix9IvZ/YnZq2ucEYKLlOVslnhxb28MAPSSwRxPW1LG6Rnvc3dpjzMIHv
 IKTwUMPot3M5UoKfvfECQNLvMipTGn6x+eJI3oOFYtbWRjy7ED9Kge0EidO5ULdR9pga
 BwXvSRrDzxH4twsUEDgtcN1CtCex0b6PJ4xb1mqff6sxuOmuU4prMw2u9fQWq6Q3TxTR
 UZASxOhlz7ULfLOFe+x7rrgvM0GKkdfUFdgN0xmwyPGItyM+7VxqLLHepFpNaf1hXRub
 J3a6CZW36qNkLALiNqhdvgc6u0K1zp7vDZQ6+odpQ4GjPosUstyw3/IXOVg+F47zUqZN
 7ibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777472774; x=1778077574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OYgVZB17MNLmk2paCRzAVX8szfH7PPjapdbl4hw/9M0=;
 b=lBmLnNNIHqBuYo32ixv8qm9wtG6AMr4OiCXExG7YRfRlmwnnhbpm5diJYrYQ2HtvZQ
 pQo+Doyqm1+Q03KiHNuwVdtJHYTknOl+kuOGSK1eELcB2E63G/KGC5T4tetF0tLFhU+z
 phyglUs4QP8O0Biyn5Xpqcvm/bS9+Dsf36vLddfrovRffq9tn4sDJNVNPTUWVUNHIjmN
 8+f4kj5JvkUrjYOZAdqQa8kGCK1OgvvCxX24NjiPhpONXeucqv/A+CO3SaR2GKVHN/bz
 orDYhk1w/Q/7+evkdXAz3jWtMVUoDCX+ykCtlsJA6fxkqYNCAx9R97Eg5FsVdXZDpBP2
 HmFA==
X-Gm-Message-State: AOJu0YwzibGQooWtocVv91iZ/plRxVhV+TgJQC4VW8jnLRUfgubGVH+6
 dnbtknspBJlZeCym4ZkQePxswhHaNFDlHTxeEvo/bBOaeRLzNj/vVh0sOa1mbqVYpSM=
X-Gm-Gg: AeBDieu6VjutYFJ1ZOiP1eCYGp+OrsN0GP/2efsmohK0+POOw+YSnqpeZ+tq2IhUjMx
 5ElIHHJ5JXZbcKgjVcm0i68y1pI3oUK8istym20eXgJsktj+u9foML55VKbiFix0mHlG8OKo39i
 tafyWshBIWvXsnK2ttJdLYEVaOohu+jP6tWDHlQkU7g7t/CRi1/bCC5+PQywd2EKjuKgNVD9NXu
 U8Pl6c1dL37zqtAi0qLau4GMbVFFXdH2gCbcyfkKWV4T8NkkWv6eLcJK6MZHOsG7KPBMRNdbfb+
 D6mRxqRt2deWVTTHcaZSdKJFQehlx7EQSwMqwjqwxunjUJrnqWMjKCe5LMLLinkLmf3KYZ/iWOR
 tMrZAcA3ydzKWwbbTtTDE5bu8DHIzmbs8J5YVOrmgqAjXvLx1eekW7TTb5d8qVDeiP6B7fOe/xJ
 lbeqWdSeJVrdxVY3uJuE43ahdXARrTntDKDTWS26DgGslGwB6wlAAPY2GR
X-Received: by 2002:a05:7022:b90:b0:128:d3de:c9e4 with SMTP id
 a92af1059eb24-12ddd9a5c6cmr3321031c88.30.1777472773789; 
 Wed, 29 Apr 2026 07:26:13 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de3261596sm2618556c88.11.2026.04.29.07.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:26:13 -0700 (PDT)
Date: Wed, 29 Apr 2026 07:26:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Weijun Pan <wpan3636@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2] test: parenthesize assertion macro parameters
Message-ID: <20260429072610.1f87ad78@phoenix.local>
In-Reply-To: <20260427171714.9887-1-wpan3636@gmail.com>
References: <20260419164818.20609-1-wpan36@wisc.edu>
 <20260427171714.9887-1-wpan3636@gmail.com>
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

On Mon, 27 Apr 2026 12:17:13 -0500
Weijun Pan <wpan3636@gmail.com> wrote:

> Some test assertion macros use parameters directly in expressions,
> which can lead to unexpected evaluation due to operator precedence
> after macro substitution.
> 
> Fix this by parenthesizing macro parameters and the resulting
> expressions in rte_test.h and app/test/test.h.
> 
> This is a test macro robustness fix and does not fix a runtime issue
> in DPDK, so no Fixes or stable tags are added.
> 
> Bugzilla ID: 1925
> 
> Signed-off-by: Weijun Pan <wpan3636@gmail.com>

This is not critical path code, and there is secondary problem
of arguements being evaluated multiple times. Perhaps use helper
functions instead. 

For test.h do this. The rte_test.h part is correct.

Let me split them and send a followup



