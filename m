Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C404C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 18:34:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73D2040270;
	Wed,  5 Feb 2025 19:34:03 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id C0C6840261
 for <dev@dpdk.org>; Wed,  5 Feb 2025 19:34:01 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2ef72924e53so12596391a91.3
 for <dev@dpdk.org>; Wed, 05 Feb 2025 10:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738780441;
 x=1739385241; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WMUH3Rrf3PrhnnNyZKwRlaoN1EcUx4WDcw8Wvpf5XqU=;
 b=eU8RbYxTx3tV3Fudp2szo5PIK88AcJm46NrHFlYrGfZNF9vICf/MD2kP7Qo8siDs/L
 5ruPyOz9DYVFPwMqI/CDhfqH9XiM82G13gsMvgv3n3r9c7dRPlnhYh2sX6q3eZtX/LHo
 ztvdUeeMdGskIGtKm5ixC8ky8gx14b9ybg1PFw3kdx+5CakaO7el+t2qz6Pya/s3fHk+
 amL/EPbqoTPmWn5S7O6jt+cNcdpopaVgk16uRaI4rGR9xMbyn35mVnjfRLa89okqWRI1
 ZVv8D24+e/NlRaPwe70mpTKGdKDYERWTH91JWmp0rs+GKtUFzEGOBrhjP9TqXcgMf6CB
 QJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738780441; x=1739385241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WMUH3Rrf3PrhnnNyZKwRlaoN1EcUx4WDcw8Wvpf5XqU=;
 b=NWR3B9OD5wdt9XEixZxuDozvpqux2SgLT26cWK4nKjYdQf2PJRFY/F7IVecgHbCz0y
 a8Bg4n3RK/ARFH77aQyxTzRfIc8s1la3VOz9F3eJDwHk2MybPRrmH2T0wfVmAMUW3HTO
 CWQlmGWGEu9AT/OlBZcpTyZdRGsf35VajxV6uJcRGoSsm3mSaU2v1znF8CtT9TOKiWDQ
 4JoWrjGmPTgL3Qv3xG0Gx5w7wObjX0KyA6KgpiERoC49LQWaKhebk5YG6mqPoQZMOZtg
 +LT8k6MB5JQSQ3x/c5/8ax1Ju0ZRaKSYDTE5nyNtIoNH5X8+Y6bcxErFaRqysoZjcuGN
 U1iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeTxJQgXxYG3U0W5InU2tL+x5ygjWUlQmumG5qth9oZFnsUyc6kY+i6XzfahPE+qn8aVE=@dpdk.org
X-Gm-Message-State: AOJu0Yx7aLfq2dztp6Dnpgi3K37KnwFM159t+zdxvKjAi0k78qxU5Th1
 Ybvrzpb9fAeLvIOiTSvtWjQ1qe2AvJxRIY1sXFb/2eO2c7b92d6r7Gvb1qXgREyUzwePxVc7wrF
 e
X-Gm-Gg: ASbGncth0/80TNDa4aY1nFHXoT1j0NO9kY4mLMWJPiFsCO02J5ZGAOZTADGSrzG3RaB
 Sunk7EkzkruHFmm2NQCBchQxU+d+6o8mmm5DCFkkSgMCvbUqUR1nDEaoJQciIvvixhOZ/MN6Q0Y
 4huqUWqxtv0k708uoM1fp3IB8bpUGir+zPIt4PjBFhZn8VOe4XHhMsJSZVKay/5HA8cqG13zoYx
 +MsJ/VHrfATxxLySHqXJal73iIT2yB0K2EgIdmPwSHwueYhXBpoIsix74zEpK1kg2DbBam3nrWe
 B1eawfVr3qZbgiqj3El5k9iprA98tZhdJDjAGKIajeNVorCqdK3AKqHZCcerCE3FF6jp
X-Google-Smtp-Source: AGHT+IEu4bJ5+8EdckECSdpZn0nvePEjinnthx/L0pZQ2K2/NFbgzRrDCo61GlPofD+SYzTYBtSI7w==
X-Received: by 2002:a05:6a00:114e:b0:72d:56d6:a7a7 with SMTP id
 d2e1a72fcca58-730351eab7amr4807496b3a.15.1738780439878; 
 Wed, 05 Feb 2025 10:33:59 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe69ce6dfsm12741126b3a.154.2025.02.05.10.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 10:33:59 -0800 (PST)
Date: Wed, 5 Feb 2025 10:33:57 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: anatoly.burakov@intel.com, bruce.richardson@intel.com, dev@dpdk.org,
 dsinghrawat@marvell.com, palok@marvell.com
Subject: Re: [PATCH v2 2/2] drivers/net: add MSVC compiler flag for unused
 variables
Message-ID: <20250205103357.18fb491f@hermes.local>
In-Reply-To: <1736887611-32186-3-git-send-email-andremue@linux.microsoft.com>
References: <1735238504-15597-3-git-send-email-andremue@linux.microsoft.com>
 <1736887611-32186-1-git-send-email-andremue@linux.microsoft.com>
 <1736887611-32186-3-git-send-email-andremue@linux.microsoft.com>
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

On Tue, 14 Jan 2025 12:46:51 -0800
Andre Muezerie <andremue@linux.microsoft.com> wrote:

> Added MSVC specific compiler flag to ignore warnings about unused
> variables, like is being done for other compilers.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

This patch series needs rebase now that Intel drivers got reorganized.
