Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CB0C83F26
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 21:46:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DE9F40693;
	Mon, 28 Jul 2025 23:46:03 +0200 (CEST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id 9F93E4066F
 for <dev@dpdk.org>; Mon, 28 Jul 2025 23:46:01 +0200 (CEST)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-6f8aa9e6ffdso44913246d6.3
 for <dev@dpdk.org>; Mon, 28 Jul 2025 14:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753739161;
 x=1754343961; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gI+wpg9UXR3ub4H9KijptGv1RosZdVpkFhL5TD8teqw=;
 b=Ul/yU1gWXL4N+QiDEeoiNQAywYhxCjeRF4t9HIekwnWcT6Plyp3v6FGKPf9QrSXV72
 mqV7elYOR3vz3m4YenqXYk7jGhGjfy71QGkH/mntkfbJDuP8Hb3vRHXA91Ir0GrFBE7q
 Q+bw+1RI+LUqGyZHWcesR7LUGOCzMuWR4f8lpc8O65tbMHbcBFpiQYH1+5UyR5YY57Fq
 Y5WMoSMLmIqvDmTvPmZH/sypKfP3EtR+9AHPGGIkrzmz0hYoMNBAXJbBFjAClLScDCaR
 zhw1QT3ld9MxVY+0oIwuV1wgziQV5X+A71fnkybG/eyopd4OEtqlV3qhCKFpG1ttQbAp
 FvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753739161; x=1754343961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gI+wpg9UXR3ub4H9KijptGv1RosZdVpkFhL5TD8teqw=;
 b=RHjjLOhkKKW/M+wZro0zeU/0x8yIME96Wa/c+eerxqO2iKV25+5dz28/yCj7dwbepl
 n81OSjrDkI0uslR8ztTm3lraAkOI/THMPHMfhkjEVl/II3bZYP0q3kgr/mKkj3McZI3e
 p1GukaqYtZpKQghpniwQ2RVApuINy1gh9b3LkPJCXbFk1L7usw0FGUwTsCZGAmEUuYGK
 R8cuydJjUaz5TSsxPoNQ7AqcMwghZgeY/CczFE1yjQOq1IcSjA1U7F9R9b2aCnUaLqiy
 ++/fXDxhca2tU1jZ1VC843xcEcbWJ/u/zgDr5seg13zzY7uDG2EGMFWeMYr2A0KQOkx3
 SqMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjQe0psENH5Dg4FYFj5tsuYl41po0gWPCVIPtai8hCvMEaR8Qpm/4lRACF+7zZQwDfOZg=@dpdk.org
X-Gm-Message-State: AOJu0Yxp8Ul1HmQtu3iQQ+IeyLx2yaP0scD43rFM9nBJwZ2F9LLlzP94
 iliYSRj9YaXVy1gE2GpbtIASWOXEvLBYhwCq3AyDe1y5pv6ljLR0GVTJIzHIU8w7EFPx76MUODT
 YnCii
X-Gm-Gg: ASbGncsB3Q3UTSc5aHJsSd9aOAocu/d8+a1n4JE2D9erPwzA6Ut1OyPES0d7vp3gUjr
 6lOwwWJbakX5Q6lWF5XV3pwP2bFNT58fWW1GaCtvv03O0KlrSEcyyoXcMKfhteoEfV9IpT9+Ti7
 wyCQjGUYvvPFk9Rc8YyIe81awVFq8ev4jUh7JSXNJFk4ZEomnVaRkNNgPFcO2UPA/zFKiihvqhd
 IF1HNymNmDqQaT8Pigpa/hCj6NTqYaRFtm0tbeQ7ilmaMli9r6xb9n+RZ3OA3TxrqFpEnwplOB9
 C+p2PCLkdSjq9+eRSRJg1e6ehWnzMDs/2SyCAlnC1rlwpgjdm0dqMpozOAo6eKGmF1Db+pbfBun
 M3g5/FTwJFJyUfriID8jAhcr/5zpV4HLMc+uDrLM+zflru+vlpX9Je5aA2UGH34mTlaCJdVGxFe
 o=
X-Google-Smtp-Source: AGHT+IEwpJu6z7jEVPjsB8aOkhB1Kt2D9oECYgd8ubeuys0YVMCJwdo5rAo4nrFwbGie/yDU8yg/dg==
X-Received: by 2002:a05:6214:2689:b0:704:f7d8:edfc with SMTP id
 6a1803df08f44-7072060236emr177412916d6.49.1753739160874; 
 Mon, 28 Jul 2025 14:46:00 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70729c15a4bsm36685576d6.60.2025.07.28.14.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 14:46:00 -0700 (PDT)
Date: Mon, 28 Jul 2025 14:45:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] [PATCH v4] lib/ethdev: fix segfault in secondary
 process by validating dev_private pointer
Message-ID: <20250728144552.361c17e4@hermes.local>
In-Reply-To: <20250725125526.2340233-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250723131049.1703172-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250725125526.2340233-1-14pwcse1224@uetpeshawar.edu.pk>
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

On Fri, 25 Jul 2025 08:55:26 -0400
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

> In secondary processes, directly accessing 'dev->data->dev_private' can
> cause a segmentation fault if the primary process has exited or if the
> shared memory is no longer accessible.
> 
> The secondary process not only crashes on device close but also segfaults
> when executing commands like "show device info all" after the primary has
> exited.
> 
> This patch adds a mechanism in testpmd to monitor the primary process from the
> secondary using `rte_eal_primary_proc_alive()`, and introduces safety
> checks before dereferencing 'dev_private'. The `rte_mem_virt2phy()` call
> is also guarded to avoid access to invalid memory regions, with
> `unlikely()` hints to minimize impact in the fast path.
> 
> Fixes: bdad90d12ec8 ("ethdev: change device info get callback to return int")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> ---
>  app/test-pmd/testpmd.c  | 56 ++++++++++++++++++++++++++++++++++++++---
>  lib/ethdev/rte_ethdev.c | 15 ++++++++++-
>  2 files changed, 66 insertions(+), 5 deletions(-)


The test-pmd monitoring is good, and should have done back when secondary
support was added. Please submit just that part of the patch and add a Fixes tag.
You can use the f_quit flag like the signal handler.

The use of volatile and standard atomic overlap.
Testpmd is older code so just uses volatile so you don't need to use
rte_atomic there. Just set f_quit in the alarm handler and avoid restarting alarm
if primary exits.

In future, want to add something like:
	rte_eal_primary_proc_notifier(void (*cb)(void *), void *);
and use some variation of pidfd or inotify to call the function when primary
dies either by termination or abort.

The ethdev part is not necessary, and really won't address the race; leave it out.
