Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22068CA0FF2
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 04:34:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF0B84027D;
	Thu, 28 Aug 2025 06:34:37 +0200 (CEST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id B477F40263
 for <dev@dpdk.org>; Thu, 28 Aug 2025 06:34:36 +0200 (CEST)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-3cb9268511bso300996f8f.0
 for <dev@dpdk.org>; Wed, 27 Aug 2025 21:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756355676;
 x=1756960476; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:subject:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=LVK+KrcZr7a4JdjYm9MnKuz/6pdIXb3Qf6dNXOeGb7Q=;
 b=i/zCUxfApLIZmOF9kxchwcLI/GxZCdu28o66ykLnPBcQc8t8do1UwCNsnlAf3nOF6j
 +lL5baP1oLHVJgVSTozAcwwuixg5sob5WxyBUV4RlK/YIEyJIxkuuYnuA5e2Zb0VCMrD
 qmw50NLKz3hUWUursMr2crVUHMEzESMJBPhYMHpmB+e6y6WdnPIG2pmUPUyhy5SZVq7W
 loE8HHMEggJNokd38A6cebPGWy6NPfZ+gNPReT0R0LnwUIEkzIVsj20pdSq9plubCbJY
 9OSFfHhdSEHjagh3rJJvnAUqLjhR4bZQ+r8S1Tg9qSqhaZQsVNb/RtNHo7F+ib0lriWs
 Dgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756355676; x=1756960476;
 h=content-transfer-encoding:mime-version:message-id:subject:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LVK+KrcZr7a4JdjYm9MnKuz/6pdIXb3Qf6dNXOeGb7Q=;
 b=XotrKXHvI24cG89rQYlEDrCqgfCB/R1+rPxAv7z8J8RIu3ARVUFe2nwRmNPuYEhdAv
 /R5VjOYr9KMkGtTF0rEVApgUacAPv2bXirRb7rekNwgasP9Jad4FAvp7BV6ws4YKLh/k
 T9S81ClIy4lHFABIGEnM/WahmlTEkwO+qPC9WnmVuSfVyh9mh/Baa12fTpJhaeI/zywM
 vqcaZ6fAarhtDOM8A15rE08BLGtMAQvecA4Tg/Hx2mkReryZ3IbDGR+e/hKzFso925Z3
 dqxIPrJaRY9uTCA2Z6vp+MYqJHFYcmj5Dj+oGuNy5Ym2yxLnz5ISgzcv0UlStHZo8w4B
 jz3Q==
X-Gm-Message-State: AOJu0Yy4ZY9Rjtrl5mF+pjKwnuyIUmmmyxBnVn4gb8yoHGpFAF7mfjQo
 28hJfvSa76p67nOwnKSN6fYaTP2OyYErCcaTb3q2D669snKhULX5xIpvLsb6cs3sUujrHRFQ/r0
 JV6ES
X-Gm-Gg: ASbGnctzqiZh8gu+4j6U1nqFRnVYVLatFSY9cYtn6I47lzoTXR44VO6jh17x9hTaJsi
 o9WAt+vBRX57sLA+BYI5JI2OtoJ9J5tUIhb2Xn4uviodtaaBGUERp7G6d9CRul+b6lcgJse4jb/
 /ZsHkzlYi8IiAPg1q1DlUG8LMMGNYieH4l2U22zf1/6tDEG6Wa6WDgOy18shq/JdDUtux3jXUXi
 cFb8IuTPU+lqIzVFcYlH6OOIV3jvXDyprHiCbQf3UB/XOu6GNFS49ezaTKKpJkNiOE7/nXezPKa
 9l9qb3IQQgNrevo6OVAOFnDqZ01pnqyifXCQQtZkKmQCGo3YpS8mHTNMQlqjYsi0XMqe96hvVcq
 G93A/7r5yCOpd9AsWHH9Qo1hqL9opIYuhYgywGmdAw8h8iMUGe+CpU6iWSXpYu6xSSIC20V3+Dv
 HV6VyvvtMccNxRwz+wl06E
X-Google-Smtp-Source: AGHT+IF3AiWDYBVdb+nAASmrEVQ9KL18ZpyVsEzij6vNQo/Re6Y81v8hsjlzPWXn3GEw9LyaCo8uyQ==
X-Received: by 2002:a05:6000:2405:b0:3cb:2049:c743 with SMTP id
 ffacd0b85a97d-3cb2049c948mr6551942f8f.52.1756355675837; 
 Wed, 27 Aug 2025 21:34:35 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b66a64023sm50763705e9.1.2025.08.27.21.34.34
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 21:34:35 -0700 (PDT)
Date: Wed, 27 Aug 2025 21:34:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Ubuntu 20.04 EOL
Message-ID: <20250827213430.41806a48@hermes.local>
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

Looks like Ubuntu 20.04 LTS (Focal Fossa) reached the end of standard support.
Should we drop it for DTS?

Asking because the recent patch to handle shadow warnings doesn't work on
compilers like Gcc 9.4 which don't know what -Wshadow is.
