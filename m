Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402B710F9964
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 17:18:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7647F40264;
	Wed,  8 Apr 2026 19:18:02 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id AD8AE4014F
 for <dev@dpdk.org>; Wed,  8 Apr 2026 19:18:00 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2aaf59c4f7cso542045ad.1
 for <dev@dpdk.org>; Wed, 08 Apr 2026 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775668680;
 x=1776273480; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YnzZtpo08KONRwyZTd3eQdYgKYUDSgbs3Ho/2eY7KYI=;
 b=lk1NX6Zhx9+7/jHdOSeNcFT/rCNgQKuEzJXZXB9VgPyN/qVr1QJ5GyoYatqYlY9Z2C
 qOyu1Bim3OISznOrYnHYQrsDo21AjwT1Gf8qI3qufV4WHNl9JKfcSDTWw3QQL+WPwnEv
 n/7VQksOcmQ9wmVLFHle0CPvrygfERr5lFtuP8hIECQepbSa7PvMDUa0h4FqB9I0gXJY
 SSrj5QZnUGd0rwDdHWGySIGCHx29pPVBcwWz/kRyOBCAWBLPamgI1ySkX4zYiAPcF5OB
 qVR7/MWHsb8DfSiE33LEBLT50JeFBVNd/icT8frs41I/OnX4p90nOOXCk3+pMBFE91Pt
 k+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775668680; x=1776273480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YnzZtpo08KONRwyZTd3eQdYgKYUDSgbs3Ho/2eY7KYI=;
 b=N7dAJKlo8Ddq2dP5MGbCH3NEWmldcjDAohCkVfHb3pWFjx/VnczSXrpc5s8JF2gWOG
 XwqbiUiwq3K+8CDWIqjWR0YeKacakL/Xwl3LZndynFRrNOefcQEojqkCoWfDdJDzGwDr
 NxNi4g/Of4OqVed0rxD6TQVcbvxBHht0w09CSZvxIgCbw8n1zDZ4vO1nT4iPqNhvDUZG
 pY5cCxrh7D13hpiKPWbBgHSe3rujK9TjVuuT2xvnS6JVb+DBXVUo+fUMmxWCZLFq+UXh
 J1S8VLoIiMnTdJCsd/C8OUUyODJb7KGBz1C1hr61a/g+bp5Koc7YA0hexAJLv4duS45z
 ZU9A==
X-Gm-Message-State: AOJu0YyGwZ5fG97EkC6p57XJrCVNJUJQRqY8TA/qk9Ic4xo5rrWTuti8
 Ov0n5R+hI/jb/Wkr9DzFuFHfPD8UVitiVYdqjfvBbN4TnSnxkibkwDebp64AU0lj3VT17DP/aH5
 k0X0j
X-Gm-Gg: AeBDiesgPueSMfpYarfFvBtp64CVaPe8Y6bZ7xkvfKK8xjD+73GXR04UTAxS9Qj7ZIM
 H5CT0JBiAepC7Jz0niPrTdf6eIhgn8AsXeNI+jpAtZQoXQTI8IYOQbHTCfWFQT6IGHjw1fnur92
 1hMGYZA6yxu15D3COjdti7CUkVysQJlxUaGlvGXl0kKAsS7yyg5yiT95kA/avXDf4Sn/0c1ZeQs
 dxqU5qkLYHL/BdqL1Y/Sip7xFaW6saw7bPcx8yiB32ksn+QHtqiUM6tclIU0ear2V+xgJwax9FP
 76AvHZYgKYTjYMCvYZKq1JeI8M8advigPvtJ4BM+kQs0h5SYhQxdeCdX639AlV6/UUzVjkqBuVv
 u834XLb+ff85U4z/vzntqQaIHW1116aDzGBbX2mrYgGU7lCSkJzUcQfycp32z41B6cDRjqNDHUu
 FJZ5cnHQIDr4FciVsoY8v7Wh79t1uJYNBLm9o=
X-Received: by 2002:a05:7300:fd16:b0:2c1:1588:55e3 with SMTP id
 5a478bee46e88-2cbfa2d2b14mr10032240eec.14.1775668679639; 
 Wed, 08 Apr 2026 10:17:59 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2cef60a435dsm13373827eec.10.2026.04.08.10.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 10:17:59 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:17:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Jeroen de Borst <jeroendb@google.com>, Joshua Washington
 <joshwash@google.com>
Subject: Re: [PATCH] net/gve: enable comma warnings
Message-ID: <20260408101756.163d5d6c@phoenix.local>
In-Reply-To: <20260408170402.452672-1-stephen@networkplumber.org>
References: <20260408170402.452672-1-stephen@networkplumber.org>
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

On Wed,  8 Apr 2026 10:04:02 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> This driver has no misuse of comma operator in current version.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

I squashed this change in with the previous patch that fixed the warning.
