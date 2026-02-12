Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA47ECD6FC
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 00:23:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 289FA4027A;
	Thu, 12 Feb 2026 01:23:35 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 9497F40268
 for <dev@dpdk.org>; Thu, 12 Feb 2026 01:23:33 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso54465005e9.1
 for <dev@dpdk.org>; Wed, 11 Feb 2026 16:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770855813;
 x=1771460613; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZD/aO6FioFuJrNVS7koz1X7sacA4VlVBNguQJsNlfaw=;
 b=xZ0VvKs9Sir4jtyv4Na4rvRbQjwRxK05HGoXx1lVzUet9RwW21SKSwL6v2MEUZtclr
 FcBlCgRFDKlCn6hqzbYOc98BjBqMgqsGdEH2VdI0kGETLia3GqVRZ0GAApPaHaFZyjyd
 0ZWja2HnnW1pbv8PLMmkgdhcXdET3ngSQJU79DwDPELLlxzNxRy1yAa0S+P6aBTsvNCf
 1eyq+mvT1X2DtDrWHufOA7/Y1Hiuv6QbfdL461DhtTJyHwRsviePlL2AGjkl8g+0BLi4
 rKEJv5Ny8l+X5odnK54bLFUrOo3SP65ezyocPm8+RRB1sefTQbXEktKEYlFLBIxs6DTm
 ZfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770855813; x=1771460613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZD/aO6FioFuJrNVS7koz1X7sacA4VlVBNguQJsNlfaw=;
 b=QVloa3w9NyiSlhGcG1WdHotLlPJ6HIjgGRmrjO9NJDIlHXrTnuWRYihmbCSI2TKaoV
 mU92vKwp3VDfIbXu/3/btlYqzxJ7NeirGa36dq1HDIv2ucvfZ3pLUHxZV3RZosv6lF26
 o2hxLS1Y6XV4K5YHrCSKX7oPlnExm1cGFcoFJURGNVBSAkGUQ+sQPxWf63QTQBDfK/1b
 n8FousbfzAKYRB5MRUM8HDcRJj8GWTiA88HJliJdBOA8hd08T8wiPzpZ8o5V2SEYvEGt
 hy4TvqvRHxTfypLZDOeTqEq/Jcg1tDlcyFNlmEYnTSvUR2Ad9aVKX1BqNyjricDGcJ/y
 GEeg==
X-Gm-Message-State: AOJu0YynHErlFm8Cq2XyY8Ww7OpIeLdgpOiN06GviRFek8YS0V3+PY4n
 TcUrnSvD8311CGGj/j4hMJrvijt/HCxG2fl9AgjCS7+GjGD8vU1iMEk9gUJYDMW0qgA=
X-Gm-Gg: AZuq6aLrqdnzRZejXMa8AxcU8bfWA4hmAwfgodH4TnZi9u4M0DEvukPcMQqCMhYw/Ef
 qbhn5VI5KA8U3fYk0xd5do6sXyfRxzZLkNhFfK+lyHMo4qphA/agJgFuXmY7tQflwkxkJBg5cz+
 bIgazncYWQMKPVsVQk6f0O9jr8RdrzGXZzOz0iMJxfhfupHaXVyuISyiQ9xCjlJbvvuKgx3VE2D
 4GTd/mnwBDlevcQcwD5HOQQUoPfKoluUfFDFIX39rTYqj8fNm/FeZPSUjJXFIVV91l2PU9/kWtA
 Br18Ccc9/X2MC2YbAFHhdFVbn0Ubd4xAzUGRfqfnMSbqjTjur3N0PaZfu0CXeQ4wCs6yIM1uT6O
 duphmjmcErrsLtRtiAssFP4897WMKfY2a0c/0ieRNeZBAp3KJ69gzI/ZJXY0PJk+VnG7Myw8wSx
 BNMF29FAMOtT99DN84iVm3v2GRwMjFD8moZe263mHGkPA/XSMiLu/g4fSceTk6k0i2
X-Received: by 2002:a05:600c:4745:b0:459:db7b:988e with SMTP id
 5b1f17b1804b1-483656c5d3fmr12514255e9.13.1770855813060; 
 Wed, 11 Feb 2026 16:23:33 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd1bsm173017255e9.6.2026.02.11.16.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 16:23:32 -0800 (PST)
Date: Wed, 11 Feb 2026 16:23:25 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kerem Aksu <kerem.aksu@i2i-systems.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3] cmdline: update clear screen behavior
Message-ID: <20260211162325.0d96e524@phoenix.local>
In-Reply-To: <20260116154256.206571-1-kerem.aksu@i2i-systems.com>
References: <20260105113529.65969-1-kerem.aksu@i2i-systems.com>
 <20260116154256.206571-1-kerem.aksu@i2i-systems.com>
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

On Fri, 16 Jan 2026 18:42:56 +0300
Kerem Aksu <kerem.aksu@i2i-systems.com> wrote:

> Control+L should clear screen and redisplay prompt at the top
> line. DPDK rdline library will not change anything on the screen when
> fed with Control+L.  When prompt is lost after too many text written
> to the terminal, users will press Control+L to clear screen and put
> the prompt to the top line. This is expected behavior in bash(1) or
> applications that are using readline(3). Updated to behave as users
> expected.
> 
> Signed-off-by: Kerem Aksu <kerem.aksu@i2i-systems.com>
> ---

Applied to next-net after fixing the release note and rewording the
commit message.
