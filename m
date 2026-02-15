Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93F1E63F04
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Feb 2026 17:08:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D48440274;
	Sun, 15 Feb 2026 18:08:16 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 89D7F40269
 for <dev@dpdk.org>; Sun, 15 Feb 2026 18:08:14 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4837f27cf2dso7775095e9.2
 for <dev@dpdk.org>; Sun, 15 Feb 2026 09:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771175294;
 x=1771780094; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJqLPfmRLLq0nBXvi0rmKYRzb7e0KQ+ZRA4TUnKg+Js=;
 b=xTIZXzpOpiNPegO9uwwO0WvXAdAu6iHuq7dOTq+mq1QD4HkVsqQ9WCjkSJNHnH1KaV
 e0b78wKNUZi9o7R++Rf/vfxlwTdzZVD4hm5zETMbIlWKAgKrxdAwnw+OmvkcqgCfH++U
 09RCxwcUL/Q6kYQbMrMhDUo2A/JvgRony8LT9VDAynia5SZ5wVF7BWsEF2D/eqq3aoKR
 npEtYBESH4iKrMd7dhLQmFPcZcYt98GDUPA7k6mU4hJZIxles1ceYmyklkdSFkV3t5J9
 w1GOzBjjYRAwZY7POpwM0MByMFojQataF7ZE5aNfW7lFmoWdKFsU4vBZjBFgUL9Kfg0A
 2PIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771175294; x=1771780094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cJqLPfmRLLq0nBXvi0rmKYRzb7e0KQ+ZRA4TUnKg+Js=;
 b=JPvSV0a1UNv3+SEk/lnsSLjJtcyR/wzdqukdzugWR9YZKD9zDdhOSNUqEOAt3Z0fHv
 O6aqSwUxkpJHL2+nFEoZO+ygExrq4+AvKrSHz/UHav+V9SYUv62Z5biEzMHo81IxXS2j
 fnwi24JS4Jj/33t47jFPJfGajj6jdwoARx/DOuxp07NdAjp+UwZAeuwsS4ogYXuXPGkN
 Qlz+uCz/BQBhL+kXbGV4K0hOeL401GU440oiopFExwf9t8JZPp8XSZXAPLbMNDGY3kMH
 7/OjLWSZXO200Zz9gEbdsUzAzNa0PX71hCgzlOOr7FPW5kxxaBcbt6zkDBHZqO8V3MRb
 E97A==
X-Gm-Message-State: AOJu0YwbWIa15nv3zTftIFoiJleEogHDcjaTIHzHAXMEN36Ex5ch6nYR
 Yg/FI8kOPUg3SdOamOR2Jc3geuOmH8uTmCQmAOo2Rnou3Hz/0R1t3bl1seLytGh1hnLz3zISHUL
 R60fRTZQ=
X-Gm-Gg: AZuq6aK4rdbQq/Eo/Ixm4eAny9ElQC/glnqYl1HB5f6+mvGuXBCmX5SFxXwoqfAY4RM
 J1ixuqYZmY/Z7ocwwFkPmzgjb6GyyHV749G84JetPm3plesJyWd7RHJPf8VVYvT9OvtORx+B87K
 DqWfrPymnVXCjMEQ+jjVvjHFbZ9Q2V7/j483LzGxVZDbDPUxZraAo00NkZD8KuAR5ozZCwuyhfj
 +iwZZ0Xhl6FA3udaUfuTYKC7vx8Jc/Ci05y4pmW4Kaif6JbfbiZgu71++9fBhmW9SpVzeQ8Xp9V
 NTZk28VGKVnB0HX5zuchatrQX5d/iLb3pteUbD9oel9751P+h8NkJtXKQXCzGBhf/vKJY9y7hCQ
 lPjtDU7uXilqeSznUsCsReQstvqN83XMJT/Fe+bAxZ9Uw7xMbRfDJLfqRiFSllbN83r/z/vbVPq
 Nw0GwF68kb1mIzvE7ys0LBsrBTkR95BE0knCpjRPakuXud5tXowbK5XEeaxhMDSIbHF56pD02o7
 H4=
X-Received: by 2002:a05:600c:3b8b:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-4837104307amr179141255e9.3.1771175293396; 
 Sun, 15 Feb 2026 09:08:13 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483740be167sm180832055e9.15.2026.02.15.09.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 09:08:13 -0800 (PST)
Date: Sun, 15 Feb 2026 09:08:08 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v6 00/11] net/rtap: add io_uring based TAP driver
Message-ID: <20260215090808.6a5a5cea@phoenix.local>
In-Reply-To: <f1c3abe8bccc44ae96992945d379447f@huawei.com>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20260214234726.188947-1-stephen@networkplumber.org>
 <f1c3abe8bccc44ae96992945d379447f@huawei.com>
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

On Sun, 15 Feb 2026 08:58:14 +0000
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> > 
> > This driver started as an experiment to determine whether Linux
> > io_uring could deliver better packet I/O performance than the
> > traditional read()/write() system calls used by net_tap.  By posting
> > batches of I/O requests asynchronously, io_uring amortizes system
> > call overhead across multiple packets.  
>  
> Sounds interesting...
> Curious did you make any perf comparisons vs our traditional tap?

That is next step. Trying to get a testbed that is realistic setup.
