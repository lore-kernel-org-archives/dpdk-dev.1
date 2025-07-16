Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFC4C83F1B
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 20:31:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BE6B4013F;
	Wed, 16 Jul 2025 22:31:28 +0200 (CEST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id 3D41E400D6
 for <dev@dpdk.org>; Wed, 16 Jul 2025 22:31:27 +0200 (CEST)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-6fd0a91ae98so2341206d6.1
 for <dev@dpdk.org>; Wed, 16 Jul 2025 13:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752697886;
 x=1753302686; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ijQnXaskily2PzUmimRVwCzCUe1A4AahUVpOrTQfJUQ=;
 b=RW+l4qGmMqflSdRm64F9xJwnKI/x2ZU7b8Jn7fYOYwrDOFBKbkoe5o7519VGBxK2/K
 ccuMv1q53B2EWPGJAPpYlcszZHRqmg7bs++53+23TDWii9OTH/MNjz9kNV9MkYDlyx+p
 TRvfWaePJRUWybX3YXV9Na89cGPGyEsNktn6A0HO/3n5YxLZiHo1QXNPm0JigMGXUP4T
 gzWZqda/dKISUSJ2Ok3bSOdOBStHKqQozNr/k9eC8Ux842P8TZ5w1in1i1tdDF2Aj22H
 EpYeGh+l/KVDRkV9l+zTIqvCxfbHuawyTqmeMOojJA9yTJEfLYTRWRQUA9ubFGlbKWAo
 gP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752697886; x=1753302686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ijQnXaskily2PzUmimRVwCzCUe1A4AahUVpOrTQfJUQ=;
 b=JZ/sBzoIJkLoXcMeutosxyPmnc0Rrqe4di7U6WIkqBygoUbbBGCY9q7uQp7ehvZtoS
 NHsEP/SoVbRCEvKRwOcJGXVX0LPMn0hvGU0lBRQGdxUy/Q7+U2D5IFIVLkBeVyCLQMLy
 4h1jLIBVVXt//ablriI7O29hb3NtiXjHYdoDtam9hTTVemBm4qn/BnrQWCIeAnBelNbp
 sqCHuay6dCjZoB85uDez6aiTcTtTjgm9Xidxt8mfOWgY5gHJdIBqa3qZOQP2RcTYI/bZ
 H1nPvtygaenMTSPBh4IrvEccFfKEkrORmkGvdFjE780rOyBGP/ueeWmF6eEzfI/TsEbV
 k87w==
X-Gm-Message-State: AOJu0YwM/HTmJCUXfdyF3tE2Oa17MbDmtBSYiPxgnmRhjJU2VyBG2YoZ
 9VZSYkgg2A7CPrAPfhSOMAx6pp7xjqHPsqqpnDIUjMShQBzcNCQeMOIDdjLq89gVHp3San9/xUg
 NyTIB
X-Gm-Gg: ASbGncstWuGbAjWjJtlkvld82HyvTOotBqGvfXIJ1M+UpB0vLTKIanfFTHO0gVyyBRQ
 WIzqOchp69FqwsjJtpUqUFtZLjhquRqQQYvWKfLC6IBwwCAQBpEtiRTEz6uzkGIiial0rUkqV1w
 2imn24EPgm9CMbyOMf1bL1RMWO9KPHLM98ZpumSsZrMtyhsdeHfIF0A8R8siHKlAtIgFofFhiIQ
 mvhD3RikVadp9yrSlBdyDXDUZTy7Ob5yZ/1nmB1+dIJpbxRQ1s+Sb92FDwLu+QhGD5GZeC2CCQo
 OGOGnAEtkoD9CUSvk5PfeW0t9YhFJ/zO/rExA/A0KvGt3N9qLW6q4wDE5SZUbnAUuPk8umEOhFb
 jTv2ZMe+O5DbSgb/qplwclbgfu+95CtGzXwR6bG4jVwWUqVkcJAKYY168exGTOvsuExPRbM5uah
 4=
X-Google-Smtp-Source: AGHT+IHzL3SDW8s6zYY1JzFTtS8ZZPg1VnfRmo9uYqW7tx//vMVXqiy5TgWPgtQc14Z6w9DSLa0k5Q==
X-Received: by 2002:a05:6214:5d85:b0:704:f94e:b5d6 with SMTP id
 6a1803df08f44-704f94eb9acmr53847226d6.46.1752697886274; 
 Wed, 16 Jul 2025 13:31:26 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7049c0a3629sm70746886d6.61.2025.07.16.13.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 13:31:26 -0700 (PDT)
Date: Wed, 16 Jul 2025 13:31:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 14/14] net/sxe: add Solve compilation problems.
Message-ID: <20250716133123.5112549d@hermes.local>
In-Reply-To: <20250716082930.83026-14-liujie5@linkdatatechnology.com>
References: <20250715034152.7020-14-liujie5@linkdatatechnology.com>
 <20250716082930.83026-1-liujie5@linkdatatechnology.com>
 <20250716082930.83026-14-liujie5@linkdatatechnology.com>
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

On Wed, 16 Jul 2025 04:29:30 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> Add Fix compiling issues.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>

As I said in previous review. This should not be a final "fixup patch"
instead please merge each of these changes into earlier patches.

