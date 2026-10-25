Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D125606A320
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Oct 2026 02:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WMiHESV6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A130A402B9;
	Sun, 25 Oct 2026 03:18:11 +0100 (CET)
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
 by mails.dpdk.org (Postfix) with ESMTPS id DD1AC402B0
 for <dev@dpdk.org>; Sun, 25 Oct 2026 03:18:10 +0100 (CET)
Received: by mail-dy2-f5.google.com with SMTP id
 5a478bee46e88-3535a54c09bso2236800eec.0
 for <dev@dpdk.org>; Sat, 24 Oct 2026 19:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792894689; x=1793499489; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/DDFLn/U9bkEtz0uOH1gH3W2bcnRO9dTV6NSnhvViwk=;
 b=WMiHESV63F8YYC24+8LRGx7dpD7FuRxjevPDrLHnNdB470hC1uFMFnrgegK+eGPRO1
 r+AAfeC5vbIBCya1eFLX2XGB6itGJGFgtAf5ndhMFO/UMzsyPzQilp4ZuQzzDiSQnLVu
 V8Yf9dvVWf49qJPKkrF3cJahLBC49V4ZuaNsbU+hNtHzziQ1bqdcuwB4kxULtvj17zTF
 YbVEGwh2qQVJy40XWOKoyLv8K2QkdUaLDaFzPERo1nsqoU4Tp8n73oOOOhxh9fHKegX4
 UbwYWrCJQcon0k6kQJj/3rw4tKzd2WpSZW141WetnDkzwmE/aTIPz+prYdPJDmX9jbhL
 xL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792894689; x=1793499489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/DDFLn/U9bkEtz0uOH1gH3W2bcnRO9dTV6NSnhvViwk=;
 b=FAu2F/HKc/mr3ug1Ya1whBRS18YAL88yzSru4sWntpHVLn/pWZjPF1FHSb/GPZfQcs
 EHPR0T0tPm8Qn46+X3Fpizit2UguCjjS3uTt580ZO/ryEuN3BmGELpMO0/e1CrbvS+4B
 GQ5WsrSIQItalVX8t38XutWMOI6FKwnsYE8njEuYoyY/hR63251xmrahdOlx0QDyhh1O
 l1+EBHlqCg7QN6CcqIxUFukLYcXxVS4F0LnXrx3AD6JcJhXFDlw7MVWVFNQXQS4CaDnq
 XuQLaU7f1LwWUD9asSrUnA7pfdio4sA7L11KDpqwjI4Xq26cowf5y3La7iMKX2RXg3I3
 il2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwAW524Wp8Na1s1sUhdyYROrjTY/YUtEUydV6I4EqK8VzpjtKYTPHBHGLw6Ya1TtKZLww=@dpdk.org
X-Gm-Message-State: AFq9FYJiw0bjs8TLNsJWENyK5FfYJoRg4aGN/Fv/Ghlv+yd/fNb/tsBR
 FfXKcI2b6nTjiti4iA5Vv5oAsF32ICcWOpMfejuGGvGooEbokMS9i4Qs
X-Gm-Gg: AYBFou0xeoIB6kW7+0mmUTLOxjaqdklmmqX5WAK9nUleIK+Fz1fapIUiiTEx3swZfA6
 C8XaXkNqijfErCATf6KGOTvB1+ZY1mE8SspYo2IdQnHoCYG/IMYyTWlMGULeT2AqjJjXlwEov6n
 jimx8V38ViCtDugCXYMxyyyZr7IhiiXmx8QzxEkl5cn3OZCArz6pEkb9IrvG08zfXCGWoUA0eVP
 XSCW6xXxTC9BgY3nBB7R6TupEpUuEAK/4n8cq+lmN9Y5jjaX9QI4Bu0WHC8+U2i0qb+gMru+9iM
 6dEbO9fTpcpTWDMdWxcdGe9f++uuAjM74L+sy+1ziSeP8u/2/WcXdUOBgLQMd0gICmpc9THqlag
 BLrGAHEBPJvIKTcN834I0LAytt2UWQvm+A8OHSxgjc50KtyP0sL17wKEvkuGL8iv8+khdZ8ZDYA
 51yVQIvxoodd5a9TID38Fi7sIquLBD83XGGup/VsanMWxnciAb9gzb/N+LAvB10cI/kGPx8I47k
 DMU8ZaDG0QDC59C5Af4OyPDs0zirr+/CZfno2lk7C0e/lhwYYSiV6wcH0gDjwIz41Z+7Jlxqro=
X-Received: by 2002:a05:7022:e888:b0:15e:3a65:5b97 with SMTP id
 a92af1059eb24-1993505df58mr4985718c88.16.1792894686584; 
 Sat, 24 Oct 2026 19:18:06 -0700 (PDT)
Received: from eloq.. (ik1-206-76773.vs.sakura.ne.jp. [153.120.7.27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8db7e73sm11714157eec.20.2026.10.24.19.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 19:18:06 -0700 (PDT)
From: Chen Zhao <ch3nzhao@gmail.com>
To: weh@microsoft.com
Cc: thomas@monjalon.net, stephen@networkplumber.org, dev@dpdk.org,
 stable@dpdk.org, dpdklab@iol.unh.edu
Subject: Re: [PATCH] net/netvsc: fix event buffer leak on realloc failure
Date: Sun, 25 Oct 2026 02:18:02 +0000
Message-ID: <20261025021802.3343047-1-ch3nzhao@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261025014634.3295418-1-ch3nzhao@gmail.com>
References: <20261025014634.3295418-1-ch3nzhao@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

The AI review reports a double-free and a dangling event_buf:
https://mails.dpdk.org/archives/test-report/2026-October/1069492.html

Both findings are false positives:

1. On successful reallocation, goto retry skips rte_free(old_buf).
   The retry label is outside the ENOBUFS block. Each subsequent entry
   into that block reinitializes old_buf from the current event_buf,
   so a later allocation failure frees the current allocation, not an
   address retained from a previous successful reallocation.

2. On failure, rte_realloc() returns NULL without freeing the old buffer.
   That NULL return value has already been assigned to rxq->event_buf
   before rte_free(old_buf) is reached. Thus event_buf is already NULL;
   no additional NULL assignment is needed.

The patch preserves the existing reset-and-retry behavior while freeing
the old allocation on failure.

Thanks,
Chen
