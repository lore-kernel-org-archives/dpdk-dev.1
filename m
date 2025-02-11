Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648ECC0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 22:09:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B322440E0C;
	Tue, 11 Feb 2025 23:09:55 +0100 (CET)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 826314027C
 for <dev@dpdk.org>; Tue, 11 Feb 2025 23:09:54 +0100 (CET)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2fbf77b2b64so220031a91.2
 for <dev@dpdk.org>; Tue, 11 Feb 2025 14:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739311793;
 x=1739916593; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0dhlmdcuJUjFn8gdDRMgYhDQWHgUB7SRhCobGYjrKK0=;
 b=pTe/8eNCHUQuA1ZE2Q7rYYfBoLPF2JFaF2qtclkjYvilCk0jze2ZbQdYSVDa7h03dm
 Wd5dIRrTI/NyS/OJa28pdtYhYMKHiU/bTbGT8sZOBCnTiFkQMTgToh7/OadLuzkW9Mvj
 L7kKtb6SALyjM6wiSZMcLsi9OaA6DxHJOLYCnguo+najLpibMO7Qr+sQcw0n8aY5yWLU
 fV5pf1HYmmLMDyxVhjszx65rVPx9zFbD5DH/I36/hwXcvA1JmDE7H0VBWPHCiFd3ujHy
 A3JaZ+skF59hf7g3VvJjmbc3E4Nli1xu4LF2Vf53K8HAGFG1eP4I9urSNQTG2R4pMklA
 dDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739311793; x=1739916593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0dhlmdcuJUjFn8gdDRMgYhDQWHgUB7SRhCobGYjrKK0=;
 b=PQNGZ2dSWLRhKQ/HUpJePqfwzZ2xnkUvz5waE9ZVR1+o5aVHj0QS4KbOStGeQx+klK
 m3l8x4bpA8+nRrmkxvd1zEPbFlaoDToqBoGI4S9oujs60MZhtCU8nu9VchXilMTmcs/l
 KM7M/I889xx+VMsa9h7bfdZwPEIOW+foCPZO5w/HEgP4h0CTVx8lGTEwRIdEGk/ZKjr3
 CoZiyv4HkGXqwmUMOCSDsguaxg8yPWPAug+IQu3f5W5VqybJpSnMEahCKqE0lDvtHR2q
 7DIe0BH6psWVDuX48602yyOdJ2J8wIGObwWOiKKvDekNh8C9NcDo4Tfs07MTxrbzuez/
 tikA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNoMSDpqeEocDj8qC++7mJAijBUjo9oxOjHwAl4yO+oqJxJzpnzHLh9V+irs1VoPgnnZA=@dpdk.org
X-Gm-Message-State: AOJu0YzZeDQThpefBf+wlHMmy6XHGRx04vc7nl+RQ1fxjwygvuab6a+D
 3G833Ob9QhFJwFATj4ZZ3BML2SsjlHXmMR0A7hqv1jIQO4nvi6eQLXbRwnnKvSM=
X-Gm-Gg: ASbGncviwsDSVO9pZD4v0Sq3tseoS9BcdtGjEfgD7baXzTvHnvW9Sb3mjcimrbCxz8W
 BuCoePDbpu0V/qB6IISAQhQLpDBP2/NEfhDMqaOpRzGrwXsfWXmBVZZ5KPTNDku+xRqzL15p3jb
 gI2YoFP2KRJ1G3Qe6H0R1P1xP8omw5K9P5aefdiocVXwrLsOtVog2L+yqxzj+tO1yhqqgXlXH0u
 kvIH3SAHcV+N8om6fDclBScsL7UNzV/mJKa3hJnsQGyngEwbotD6QZsQZFzAYIihW6Hz4s8TV07
 8lSld+DbBaRUgLBiDUHloU/292Ud04m34NmFqDtsoGuKq/icK1uS4PORkH0h+SSLadgq
X-Google-Smtp-Source: AGHT+IF/Tz6kgeq0o6fZIq+jG4/Dq+7dZsc5HMicpP/uzizBwAXe0evXDabrCAXb9gag51mWAZpu4A==
X-Received: by 2002:a17:90b:2742:b0:2f4:4003:f3d4 with SMTP id
 98e67ed59e1d1-2fbf5c6f935mr1152812a91.30.1739311793431; 
 Tue, 11 Feb 2025 14:09:53 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f368da40asm101647165ad.257.2025.02.11.14.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 14:09:53 -0800 (PST)
Date: Tue, 11 Feb 2025 14:09:48 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Tyler Retzlaff <roretzla@linux.microsoft.com>, dev@dpdk.org
Subject: Re: [PATCH 01/10] eal: add workaround for __builtin_constant_p
Message-ID: <20250211140948.3588f7bd@hermes.local>
In-Reply-To: <1739311325-14425-2-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739311325-14425-2-git-send-email-andremue@linux.microsoft.com>
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

On Tue, 11 Feb 2025 14:01:57 -0800
Andre Muezerie <andremue@linux.microsoft.com> wrote:

> There's no MSVC equivalent for compiler extension __builtin_constant_p.
> EAL already had __rte_constant which was used as a first attempt to
> workaround __builtin_constant_p when using MSVC. However, there are
> pieces of code that would benefit from being able to provide a default
> value to be used instead of it being always 0 like how it was done by
> __rte_constant.
> 
> A new macro is added here allowing such default to be provided by the
> caller.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

There is a hack way of determining if expression is constant using sizeof
tricks, maybe that would be ideal solution?
