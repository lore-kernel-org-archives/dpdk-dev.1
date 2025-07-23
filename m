Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CF3C83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 14:20:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E9E340DDB;
	Wed, 23 Jul 2025 16:20:05 +0200 (CEST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id 98CA140B9B
 for <dev@dpdk.org>; Wed, 23 Jul 2025 16:20:03 +0200 (CEST)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-4ab61ecc1e8so50346881cf.1
 for <dev@dpdk.org>; Wed, 23 Jul 2025 07:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753280403;
 x=1753885203; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X++PqkzTwKSCO824UUEqknn/NJxwHF0Yk0Aw9RK0dPU=;
 b=PrmD9LnDuq7bIPeAlbhFcHChvjS6EDt52yHQntOmjfzCLd9ADVXtpH/IVFzTHabjBT
 ErjRXFsrznnlyfaFSO7FF+cdZfyv+EgG00Tty7UGzubWoVHEIoO++0nexr7vcgOlCa/v
 008ZKZeSx8VnjguM1kJ7rsK291GPStMBOKuzMlTYIpImaaDhwoxej9qZ0jfjOPgMxQlN
 mlBti54M4cbnLvfO8ZCM/NgzV0WbrNZG0h8h+YpYNJx3sl18oeMX1jaUETIzpxtbfdXV
 9FwnEcCwopvJv/nJyQglfV8QCogebJhu2AzoCq8GR3kvy4xCti0EJk+s8WwQ8N6zE6QO
 IJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753280403; x=1753885203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X++PqkzTwKSCO824UUEqknn/NJxwHF0Yk0Aw9RK0dPU=;
 b=kn2nohduvlrkjT/HelxFOSayFFNUw5DPv1N0ktxN+7ObU+I9oX17FPsRtgafSGaogH
 R5tXr5RgHZFFFdpYAi71jkrrjQDm8CDLabxAqntQ4PhhYNfKeO2T37fYizTzEEuMiUjR
 na3bNbLHFwm0eVBfj05/AxLoTxJqpOKftY3t4/aHJevrGhWVhM0t5s+x/3qEJ80NsB8w
 grSZuhZgSet5IGZ89HojDmQ621SXS+npJZfiKp7HkkP1hyFRRvAHcdFasmy5u4AnR1p+
 BH9RgDr6WqZG+sTbfasQ8PjVCYhR5zWCX2GCnVzWFbedeHYfC3QM2M1LqxHFIz4Y9Iqx
 bhbQ==
X-Gm-Message-State: AOJu0YyByFBOygTaEmjOkRNqGGGLJyyOIner0rKgxXJJC7t+tp0Qwkrm
 Y+o0qGMSLrxuU4prGVi6+l77zH2BOs1zvTXdjlAbij/dmVy6oyBq6i9bS5qhqjrR/DI=
X-Gm-Gg: ASbGncuCS+VURNvtY5IAqK/tmtZfXKIxJwA6ndUrEDH3lCa6X9JVbcuWANgmlaOFKnZ
 hx3RjM58PbT44p52c1pQ3BiWKBEoW8B+o/DHykJttupRypve2F6onV3RN9z4iAUmemsWbjsiC+E
 g56Sx3C1VH2qQh0xz8U+FSABS5n+qFOSiJkVkxIZKtMhzQvp/WpeUPhXK5Zm9jf6oZD0txIgWpm
 XQFkEE/U4HmtwBa/VohxUD/GMvmxSpR55g0bmzCy5HUjsitVEPNWoALXkA/IHycuh4iUb07s0Mw
 TgopXrBC0iJ48mBbGvnIRvAXGnql2wRQ8jVkardN8Ea+EpbIYtC9ix56usdyv9w8yRr92InTfY0
 WthfhtzzOJj/D1Ot/C9gBw4gZayHwar2MTdda+2isuuH1gEFS5Zm/AYNicL/OMlf3uvGcIPPVio
 w=
X-Google-Smtp-Source: AGHT+IFk7SJLLBOhnLLGQSXWcc1yfUEE4m5/ZP9oEZkpkMXgcslBlPDhqQY0MNbh607QIC6o4zw/2Q==
X-Received: by 2002:a05:622a:306:b0:4ab:609f:d7c3 with SMTP id
 d75a77b69052e-4ae6de2ca75mr39910551cf.1.1753280402736; 
 Wed, 23 Jul 2025 07:20:02 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4abb4b2643dsm65961801cf.53.2025.07.23.07.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 07:20:02 -0700 (PDT)
Date: Wed, 23 Jul 2025 07:19:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: dev@dpdk.org, rasland@nvidia.com, stable@dpdk.org
Subject: Re: [PATCH] net/mlx5: fix crash when secondary queries dev info
 after primary exits
Message-ID: <20250723071959.4deac326@hermes.local>
In-Reply-To: <20250721073851.963141-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250721073851.963141-1-14pwcse1224@uetpeshawar.edu.pk>
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

On Mon, 21 Jul 2025 03:38:51 -0400
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

> When the primary process exits, the shared mlx5 state becomes
> unavailable to secondary processes. If a secondary process attempts
> to query device information (e.g., via testpmd), a NULL dereference
> may occur due to missing shared data.
> 
> This patch adds a check for shared context availability and fails
> gracefully while preventing a crash.
> 
> Fixes: e60fbd5b24fc ("mlx5: add device configure/start/stop")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> ---

How and when is the secondary process monitoring the primary process.
If the secondary does not monitor then it is broken.
