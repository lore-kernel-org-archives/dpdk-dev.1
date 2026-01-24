Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA8ED715E4
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Jan 2026 19:08:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDF63402B0;
	Sat, 24 Jan 2026 20:08:54 +0100 (CET)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id E4BE340278
 for <dev@dpdk.org>; Sat, 24 Jan 2026 20:08:52 +0100 (CET)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so2103463f8f.2
 for <dev@dpdk.org>; Sat, 24 Jan 2026 11:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769281732;
 x=1769886532; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MGjn37vQoE6Oe/mMuxK+2vdj7zCDugxpao37tw4fn3A=;
 b=LkZ7BWSGUkDifU46sj8g1J6WmAICILNgf4u9FdmYykKL8WCcicChT6gq7XofypiVY7
 p1GbZwckupeBcYylIE7lBCio917p/8+u/ShykCZhe/oubAX+rnCUVJ05ZzO2nd8Stg3m
 Cf0O4vKepAEf7tB4ABX8RQtIabJMu59nGhCFctD9urbUsZ5iKcwH6n+/RZclX7nA2v4A
 uVdpdLHKmUZpsH+Ivnautho9Y152B92RewKb/3vNP4FFQQ7v9qO1lSpqNyJYOOoMb2gn
 G3OGRXHcpqgPc0ml/ZBWzoIPlUa2G79674a3GuWP2O7BBHlr505iNxV1ebZSW0aK9PAD
 LxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769281732; x=1769886532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MGjn37vQoE6Oe/mMuxK+2vdj7zCDugxpao37tw4fn3A=;
 b=IbRt4ghMSJNSGLyCxath/teVSO+VL56bHW+n6JzbU94fHfygHZdIjEuzsiHb23i1+F
 yPIQFG/3jChWGLqj1JlHn8DmxjIBhcQWZvSRsGJITytqGCRyXhqNNkBz/EftIkShg+JU
 6JZnhnsijePuTuWzwYawhjlmyZGCzp7YrtUWPKpfboiL2S47x9X21iRpasjyUHWRgfk+
 iEo2BX7Ued4UnjmVQlKKhxKwbRt5smTyNt+qQdTU9RLu43uMRroy78IT91tMnfiYU9OH
 nveAhD+RMrFL0KcRJa61xU2xMvRYkmzie2lMZBqqQRb1FSJdjiIJQleD/I8S3b6O1F+2
 zcgw==
X-Gm-Message-State: AOJu0YxzfG6MUw7uvgV5BhCXtX41vI3u034yxdxDfxkl3K2nTZpYudJa
 EUMDibgstEgiUTSh6VvhbDQRBXqSUL5gVOoUf2kNFd1AC2aNfnerJfjhkJnkXlstgOrmOxL16yd
 SJ+vJ
X-Gm-Gg: AZuq6aKHbL5htMezWISEEI2wMQVZK5l8wvfExWtsoB25RRRzAWRgSX6FAIRUl9BUPzT
 hb4TMb+O8dp0vzf4B0Fj4/owHntDgoCYs/lZKQBjv8RCscot30IsSKJwUiP7Jrqr6sREXHyQ1X5
 +2ZUVAmKmbLQmI13JiibTzyVHLCOvoG9MitHPviuMq7dx8MUEreKqiqx50EL8icI9fbt/Xq2oIH
 LtvCTaKsn6Jg2j8im+T7JS1AwaVr0NhGO+ljJm4IGdBsYYDBIixiOtvM5gcQcKjZPvHf4mbQ3oF
 Aveh1Qv55tO4C9EgTGmeIwFr++F9lfoDlm/Isc12q4cLbyck8On0cY+innB8KkItSad+MTDRpuI
 xvdJ9qZzu3eYRy3Jjl2KnqBHN+JU1bMAJrYuiaxLs1WIK3quMJDRjx65qBZlpLke9hZD0dNI+Kv
 3qfftMNz9pkqq3HdwNk85R8Yfn2fcNfH76rVgV9lrr6evWOeLx2r3B
X-Received: by 2002:a05:6000:1185:b0:435:bbd7:18e1 with SMTP id
 ffacd0b85a97d-435bbd71a1dmr5434997f8f.9.1769281732380; 
 Sat, 24 Jan 2026 11:08:52 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c30293sm17414938f8f.19.2026.01.24.11.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jan 2026 11:08:52 -0800 (PST)
Date: Sat, 24 Jan 2026 11:08:46 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 0/4] improve NBL memory safety and mailbox reliability
Message-ID: <20260124110846.2ccd33e6@phoenix.local>
In-Reply-To: <20260123031627.151341-1-dimon.zhao@nebula-matrix.com>
References: <20260123031627.151341-1-dimon.zhao@nebula-matrix.com>
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

On Thu, 22 Jan 2026 19:16:23 -0800
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> Includes fixes for mbuf/memzone leaks and mailbox state handling.
> 
> Dimon Zhao (4):
>   net/nbl: fix memzone leak in queue release
>   net/nbl: optimize mbuf headroom usage in packet transmission
>   net/nbl: fix mbuf double-free in queue cleanup
>   net/nbl: improve exception handling for the mailbox
> 
>  drivers/net/nbl/nbl_dev/nbl_dev.c     |   2 +-
>  drivers/net/nbl/nbl_hw/nbl_channel.c  |  94 ++++++++++++++++----
>  drivers/net/nbl/nbl_hw/nbl_channel.h  |  11 ++-
>  drivers/net/nbl/nbl_hw/nbl_resource.h |   2 +
>  drivers/net/nbl/nbl_hw/nbl_txrx.c     | 122 +++++++++++++++++++-------
>  drivers/net/nbl/nbl_hw/nbl_txrx_ops.h |   2 +-
>  6 files changed, 179 insertions(+), 54 deletions(-)
> 

Some of the automated review comments are valid, some are not.
Please resubmit, or I can fix during merge

Fix:
1. Remove unnecessary NULL checks before `rte_free()` and `rte_memzone_free()`
4. Fix grammar in log message ("does not" instead of "do not")

Ok as is, but would be good to change:
2. Add blank lines between variable declarations and statements
5. Use "Tx" instead of "transmission" in commit subject

Ignore:
3. Use explicit NULL comparisons (`!= NULL`) instead of implicit boolean tests
