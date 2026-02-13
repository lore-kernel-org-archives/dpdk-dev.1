Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F88EDF176
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 16:03:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9927B402D8;
	Fri, 13 Feb 2026 17:03:03 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id AA62B402C0
 for <dev@dpdk.org>; Fri, 13 Feb 2026 17:03:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770998582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2MHWCXzXIV0k/5hFQaS8+RjqTfJLPj+gXMI81ckVPjI=;
 b=aRl/2ITusWyYbGLnvudfqsB9LecCpspxTBrSXMMO27B62XbkQ5TImrFofqaozXQyp3r5Dj
 d0uaybuhfwn5YW3Q9hmTIxg7yestojONFMXV9DIhL4QKwrhKuJOkv2b+8Gauvg3T9w9Tnv
 7DW99VkBjYPabzTv9wYt5Txt2PUUvaw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-oiPsaUnGO0C64n_2KERnjg-1; Fri, 13 Feb 2026 11:03:00 -0500
X-MC-Unique: oiPsaUnGO0C64n_2KERnjg-1
X-Mimecast-MFC-AGG-ID: oiPsaUnGO0C64n_2KERnjg_1770998579
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-385c73b50dbso17052661fa.0
 for <dev@dpdk.org>; Fri, 13 Feb 2026 08:03:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770998579; x=1771603379;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MHWCXzXIV0k/5hFQaS8+RjqTfJLPj+gXMI81ckVPjI=;
 b=iHyJlMkkkVbEW1CPH+uS7d79LqCWN2VzRaaxw/GgjHQWgen/WhnbY7S2qeTqa2VjXX
 uJMnoqU5qyozrRxpmY3BNdDYUna1Mu5su4We9p7JHK1SPw/poLDSNEPOjaDYVXecvzp2
 GAydbQiGPy/R/mEQVBV9vFkngaIfO+ikd7ntX1z62gW0769oE/rMpLh7yn9/Q3Kp9f+l
 saImvrsM7c/dbtw0XdTXZKOAhlz4YfbXP8ASjJefA9KpDUH5s3w7vcASFlUP68etQ86A
 NhPwfa9rAxmuw1hdvE/WiHXtVqMcKkq8yu7fA10XntWkawZtlbD5XAv/ht3E7Qh/Zk6x
 IzgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoXiNf7d+zBfMnhpaiNlgrGrsAuTRz/NMoCfWqhAyPZcTcvDLxgBVl1cqKPSXleFzg2VA=@dpdk.org
X-Gm-Message-State: AOJu0YyIsqEeiQm763i/PRRhK40SYyuYkJVBPcIr6V13Ct/ckEH5Zi7M
 A7yPhm6HRm+Lc1lQF1CFTE+StBs5Xg+GwYcO6F4bAcpekXzdcWmgbn56KPav3g/fUd/nHzSYlep
 UjV+hWqlpRsr3gaAX8RoA/88RXL0B79pPx5V1ww0snQLDP7tZTL3+Rrvy2qs3R8QmGJXdDmBexU
 q0ZxAwoRtpICcTa1RS36w=
X-Gm-Gg: AZuq6aKYycYcW6ZnWH7mDUIVp0MJcLnzV3ucwcXD4SLEYyPYhlbWxUPLYJ7BMfkV2C7
 ei0ue938WdWiLqJk6EXW6I+WPE1J2cMMJ7y/BvrysjGAYBfkXHKUSzQS+gs0V5ohMt9fg26I0ok
 sO0HOio3+YpOVfEreVR7IEP6vX3CtfI8fif6vM2yJucnWPD087bQJ2qtkoFpsICS7ZKftMpcW7F
 +Ue/tExiBRvyjIbaY+gme9LVftDxNE35VUco/Sh7aUhJalrYOUU42NFoCG96flKlpVR7w==
X-Received: by 2002:a05:6512:3259:b0:59e:5ef6:edd5 with SMTP id
 2adb3069b0e04-59f6cfe8e54mr116907e87.16.1770998578722; 
 Fri, 13 Feb 2026 08:02:58 -0800 (PST)
X-Received: by 2002:a05:6512:3259:b0:59e:5ef6:edd5 with SMTP id
 2adb3069b0e04-59f6cfe8e54mr116897e87.16.1770998578205; Fri, 13 Feb 2026
 08:02:58 -0800 (PST)
MIME-Version: 1.0
References: <20250814213246.4141803-1-jfree@FreeBSD.org>
 <20260114093140.3256584-1-jfree@FreeBSD.org>
In-Reply-To: <20260114093140.3256584-1-jfree@FreeBSD.org>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 13 Feb 2026 17:02:46 +0100
X-Gm-Features: AZwV_Qg80-YLi7DeRDJ6hhsJE0jrtYxukkGRPuFwpll-jgxaka5b2L-bQcM5cDs
Message-ID: <CAJFAV8wVuC_mJC85Y5JGG5u8O1oUd5z8MNSdWLuLV+tg9ZMjYg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] EAL memory fixes
To: Jake Freeland <jfree@freebsd.org>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>, 
 Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _kmmCWOiKGKrPCtD7ZQNf7Qx5VgmU_wCzzT5haOevlA_1770998579
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 14 Jan 2026 at 10:33, Jake Freeland <jfree@freebsd.org> wrote:
>
> This patchset contains a number of EAL-specific memory fixes that I've
> made over the last year. Two pertain to FreeBSD, one pertains to Linux.
>
> v2:
> * Log messages are no longer split across multiple lines.
> * The patch titled "Do not index out of bounds in memseg list" has been
>   removed since there was no indexing out of bounds happening.
> * A new patch has been added per Anatoly's recommendation that starts
>   searching for memseg entries after the last used entry.
>
> v3:
> * Check if ms_idx is zero to accommodate static analysis tools.
> * Remove redundant start_idx check.
> * Reword hugepage skip message.
>
> Jake Freeland (3):
>   eal/freebsd: do not use prev_ms_idx for hole detection
>   eal/freebsd: avoid claiming memseg holes
>   eal/linux: check hugepage access permissions
>
>  lib/eal/freebsd/eal_memory.c      | 26 +++++++++++++++++++++-----
>  lib/eal/linux/eal_hugepage_info.c |  7 +++++++
>  2 files changed, 28 insertions(+), 5 deletions(-)

Applied the first two fixes for FreeBSD.
Thanks.


-- 
David Marchand

