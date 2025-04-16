Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3267BC369C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 16:38:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4946B40EE7;
	Wed, 16 Apr 2025 18:38:44 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id A844440EDC
 for <dev@dpdk.org>; Wed, 16 Apr 2025 18:38:42 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-22423adf751so66843295ad.2
 for <dev@dpdk.org>; Wed, 16 Apr 2025 09:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744821522;
 x=1745426322; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fzhoibcd7zO5rEv2p1xVaEccGspwUuWM5it1wt2QFxE=;
 b=yTTyK6KizopcZ4V+JS8jkcFqFaCdVrssBv7B49oUuwLMkmong4bw9l2opRZvo1Gho8
 1tuHQuAQAqMgSMnctlOVhZndVMU8nRfsufibeT84YC5MwFN2eC9poTfLuen2MRTh+V1P
 L5GqmBo3yL7jHcU/fTnBhXAWD45TYFAh4aWiDTlLd26PCQ2+bKzXnmEP2RI+yQVfaESr
 ekAa3LRAsWQkkVJJC+QCab0bLocIKtAxwLcqMb9B37TbVPR8ruUnv3RCoQXdPBw9R3eG
 mfimxBK1+rgfu7eEjH8tjoRFhyv+g9AMuonOt7qgS8SmAXEivgsQUJftHBAg4Zmrp086
 AAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744821522; x=1745426322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fzhoibcd7zO5rEv2p1xVaEccGspwUuWM5it1wt2QFxE=;
 b=n0ku5iXOdghfXn1/9uy1kNpeRaTa1UsOa/r7gMUtZNJur96Mk4AOmL0b39/KiQcnO9
 JZqJrKYF9EjJaB30oOI+6RNd/EinQRVeevgrklm1Y5zwKCFkBN8zYTdYSryeLAX8Vz6G
 5196xK2BEK4gCFR86zTSYZuSjUItXLHTxYJbT4jmQbwZZHHKVQQg+Vaj9SO1Gki7jM5t
 0souFKqcIXtB0V7kNRBHVl9ah/J0ylp44Q2cPMTepgIWrMRnMACRLMbEsKT7f8lZ6N4c
 sJEjsvE+sp26jP2MgpMWj3XFnUCWFXGWl7Ij0w+QTkgiBY4Drw1B8ytnhQR1cEUmrLEJ
 hmSg==
X-Gm-Message-State: AOJu0YzLOqRRclCjJdKzAoi6iUD7L+Qge0G5G5MmADlLKEIy0b4jWLAm
 UYxb8opu1yu2xe+1jWBg2PPQMat1lsTxqbGMSpLUcb9eRjwIxleeEetbnCYBks5v0u1pU/bkLFh
 Aajo=
X-Gm-Gg: ASbGnctx6F0TohVnh3AcMdFxn7K/LCl3R7hqwrvd49BeWZB5FYKxGYdLEuufTguVhIs
 aYgHKJz8DLMDH9bQRFJcYPG8vpZmn0QzsQEYa76jAnlhICuG8xk0dJK8oYuJ14rx8DxWrNe43wV
 IIHp0rrklqPLrTIvnz/qYaF05l0lQVQPosZY3l0TKl3C/cWAs0aDXuMjC7Wj6bz8jAjfp6k3w9V
 k640Dsc4kwcZGUpg18IRpyJt2ROqNhV9oGRK+zNU0U/smjrTwAe8tl8zhc48ECqeZ0vPHuLooSG
 jMLEVumKbzdbmPOwqp4TlZCIxJNbBVz+zIi6zIr3HxoCiIUvLTc8ZhnC2UtJI+cDh1QrDzZLOoY
 QCT3OmpwX6rUVl8nP
X-Google-Smtp-Source: AGHT+IHvJMOF7v9vhFJk9kbvSloBwijw9R4Fn/26RUwmE5zqw/s9159cYntWnMeJ7qc1+TdAopRjXg==
X-Received: by 2002:a17:902:e84b:b0:224:24d3:60f4 with SMTP id
 d9443c01a7336-22c358d8889mr40690025ad.15.1744821521812; 
 Wed, 16 Apr 2025 09:38:41 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33f1d414sm16413885ad.56.2025.04.16.09.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 09:38:41 -0700 (PDT)
Date: Wed, 16 Apr 2025 09:35:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liwencheng <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 4/4] net/macb: add necessary docs and update related
 files
Message-ID: <20250416093525.50964d14@hermes.local>
In-Reply-To: <1743577171-119901-1-git-send-email-liwencheng@phytium.com.cn>
References: <1743577171-119901-1-git-send-email-liwencheng@phytium.com.cn>
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

On Wed,  2 Apr 2025 06:59:31 +0000
liwencheng <liwencheng@phytium.com.cn> wrote:

> Added missing documentation in doc/guides/nics,
> mailmap entry, and updated MAINTAINERS file.
> 
> Signed-off-by: liwencheng <liwencheng@phytium.com.cn>

Since driver used devargs those should be described in the
documentation.
