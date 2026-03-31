Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D4B10F9303
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 22:45:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6409440275;
	Wed,  1 Apr 2026 00:45:14 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 917B04026F
 for <dev@dpdk.org>; Wed,  1 Apr 2026 00:45:12 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so60168255ad.2
 for <dev@dpdk.org>; Tue, 31 Mar 2026 15:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774997112;
 x=1775601912; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WWYLFKxxEbxauq/Z4aCkG1siKHohwxz4tsWjqIOk+eI=;
 b=slaO/CLjVXt2C0y9/34RqY7MJVCmjnabwIHBT1QKSvRIXr+Y504PDkIykpQrwvf4mU
 geGjsBP1Qvx2FTCTaQVlhhX7o9RHC7pYQJ+78dK+Z16G4DOGh+Fb85rcGS7KvoltlyhL
 HflVInfnodrjl1K8RqZuSNcdvbXHMQ5n5RAnzf//m/Afk1WuDm9M4bsCH4BER/WT8MHq
 m/vtMQG/EmOwEt7fUzOZPwdjxWcKgxA1pc6RJPgL+qwWSjjtipsYoVS1/KOCpreRu1qw
 jnc/C3AdzQGz/uCTsfFdJcJHYktwB3ApZMM5FWfmrW5OtdmnQf5ZxmopODdN6ZSqe/1m
 Rdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774997112; x=1775601912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WWYLFKxxEbxauq/Z4aCkG1siKHohwxz4tsWjqIOk+eI=;
 b=ZQcYVYLhm7hscy+CvFTyTaJCLt/zBuwF0oEoxMMjfL4icod4z5zFVbGwW6BTqS12PG
 Br1QSQTzhNRgtn8PIawzSFQwTTGo/MN3FOyng6bPQkRzeuYKSpwi5cyU3BkESa8VKwmo
 aOdcifpqnBx5L5x51AOk7V30P1CdUyHFMr2tpxiEW4Pnl5tMhJ/NG7/3xbzMcDP6XoTl
 T5EsqLzalsIWtz+UjJmsH7gzKMAJ58oWYWETuFJUIaK2ipaFxXcrcrwTs91Z2z67NUpE
 rqd5mpUVU8ZRs6Wk5BuyV92Ay5qfykFgqm/F29J8r0xqlHVe00hznn3Hrk0kpPRqm7V/
 d0aA==
X-Gm-Message-State: AOJu0YyDRJF6vYEoWPCK9LjxrlcLg1g7M5HWbkOjFgLKYOfZkKgO+Sj3
 ScHLqWZilt3XaTalK+VGV5VeHKqggTCAH/1qTwHEMkNP4xu2BImZpUNSD6UM2HTaqzk=
X-Gm-Gg: ATEYQzw0YW10uk5Q7Cq02GrJecJjpm8x74NB1eSQQ5fM4WydXfKY6BAn1W/x+srOtj7
 BzofvahZy/4KkWrxwhY+YkbXgSgyBMadSuWP9YfAMxN3+UKZUIxKHZJpDE1MMyM/rRFSBC/yhYR
 e3HVPDavA/zEOn4B+UKuqaZf2uLQ3nvvQURvYEdewRde32fKT1K2JotWNFPzK27Duu7RffyvRyu
 33EP4v1Lw3WAZe6qW35Wy3QsVZKZKFYm+LY5tVBDTu0WEmcv489XaxlO1GZ9LRRcRRiwqiX77AW
 5lTVK7QB7iS6BRFPJpkfr7jd9LGWU+gk7Dt35ZigfZHZhx5Axr/mfY+T2zRpR9v5L1bIb+nttC6
 WFT/6T8OQJfRDacNFfShSgLNYS43HDsCv9hr8T4YKNWtKJ9qVsMAkLvV5Ey/y2YqMVZVo7Xc7Mt
 ey3rSy+LYXx2QMVgsxDozyYUAEWgL7kIwWysQ=
X-Received: by 2002:a17:903:90b:b0:2b2:58c7:2cd6 with SMTP id
 d9443c01a7336-2b269adfec5mr9223945ad.5.1774997111674; 
 Tue, 31 Mar 2026 15:45:11 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b24264224esm126151735ad.15.2026.03.31.15.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 15:45:11 -0700 (PDT)
Date: Tue, 31 Mar 2026 15:45:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Nandini Persad <nandinipersad361@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 7/9] doc: reword cmdline section in prog guide
Message-ID: <20260331154505.6f6ce33f@phoenix.local>
In-Reply-To: <20240621023254.4258-7-nandinipersad361@gmail.com>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20240621023254.4258-1-nandinipersad361@gmail.com>
 <20240621023254.4258-7-nandinipersad361@gmail.com>
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

On Thu, 20 Jun 2024 19:32:52 -0700
Nandini Persad <nandinipersad361@gmail.com> wrote:

> Minor syntax edits made to the cmdline section.
> 
> Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
> ---

These changes got folded into https://patchwork.dpdk.org/project/dpdk/patch/20260118191323.241013-6-stephen@networkplumber.org/
