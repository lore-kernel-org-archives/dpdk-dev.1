Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E9AE937EA
	for <dpdk-dev@archiver.kernel.org>; Sun, 12 Apr 2026 16:21:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E778F402BD;
	Sun, 12 Apr 2026 18:21:08 +0200 (CEST)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53]) by mails.dpdk.org (Postfix) with ESMTP id 3385E4025A
 for <dev@dpdk.org>; Sun, 12 Apr 2026 18:21:06 +0200 (CEST)
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-7dbe437b072so1971159a34.2
 for <dev@dpdk.org>; Sun, 12 Apr 2026 09:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776010865;
 x=1776615665; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7zwYM93/SmARa8ZQYnN2LZ0eqQz15V02vGHzJbmxOMk=;
 b=UWo8Z5phKxCuAglPk74Kd8IKS+4qK8cHe2CUAJMH2y7SRSxxyD+jv0MLqXR25m3P+Q
 NmYVd9sYAeMIqprPYbl1D3KgRl/4XRT/nlFkgHs16tGYFajKRWSW3gHSL8hJRjxzKTMk
 94E0Ak2ikJQCeXy9o5gCOZc/3VUOLtBd5PZS/JoYSbMOptCLN+mRmSxchV7EiRxOFR7h
 Ji+J7d1fz5JDKjAyVHa1deQkH/7xPr3/Eh+4RcKqQJeOz7s4VviRKOS2FJ/b6m/B4aUw
 r0Tv1ARGhbvinmKC9fyzsel4rnT/9F3LF1+HiLMVYsh0oVqSvt4kxX9J93fIZRUdbMuC
 SN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776010865; x=1776615665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7zwYM93/SmARa8ZQYnN2LZ0eqQz15V02vGHzJbmxOMk=;
 b=R4HNeef8gRInbKEKBMPn/gah9R6TVnj0uGJWohtbcAsB+weYvhZEy0Ww9K5nQC+hkI
 fAe/Fu1rlqAz3JavasVxFbR7qNe1ULBlCaT/KHeKK6pzqTAcZHfj81jea6RioEt4dpWu
 6O3xLlyYz1meBHenI0JsaBms2Ki72V38cdEulyIr2sCfwQicXvIxv4TkEN+T711t1Wb2
 m+5N8a75Nu27gvBqxD3gMSpIrSyQ+3KDsSxEVYgoCpwUrzwZS+uvGYO/BONBFfJpCgOD
 MqsytGU1jF22h3ht9zThQKf3D3jfPnDpcq6v7rm33pVXJ/3w6NSxVRKZqFppnsCH+2yf
 iXoA==
X-Gm-Message-State: AOJu0Yxgq+i607/xwWpsoYHLa0oFasD1X0yVyap1wiP/CUW+aj/4Azpe
 qINJCSaHRflfFSNBSHN8FzDm2EmjLkpXyQyK/pkylLER+Ic+KsttIppHcNQizLi9VmM=
X-Gm-Gg: AeBDieszxAu6UAM8u2cv7KcS6YhDtzGPwXF6Iy3F1D4eKNIqNPyDL6KuphQWtcr4xJg
 iXqUeA2ux2RCUrKpb+nhRed0SzWfvJv0SEK4019CfN8PiU/7elk8iuiiO0jQ7ssu5CPPZb7KiYT
 lIZzl8BGIZs+2fBRT+dZXy8bkTc2+iZqRvvWn9wTeJE+PF5ii5AJ3U5uV+9uY36J+UECo8J+Mm9
 fPvKj1mQ0Ox3YhTl5S3BuhJ5uo8tk7MnvFMn9cSrJK3izFMhhFm46/A5eGWx9VJt26Q9uj4fkCS
 lssqFgNrASh44bpI4fNCezL8woahs0pudst8UmnVbAsnM3gHMwuKWnP073YppZvfQAw1O1PFEAz
 AtKyIK2V7PSxt96w5xHNPsmHNqyLauuPJhSIe1NgoHAJ6kLq/kyR3wK4e9AXGYIN8tIES37QCfW
 q2BZsAQJIk021dGqFWoiTMqEVy05PiRUvVF0M=
X-Received: by 2002:a05:6830:4490:b0:7d9:b10c:c85b with SMTP id
 46e09a7af769-7dc27cbe979mr5987608a34.11.1776010865363; 
 Sun, 12 Apr 2026 09:21:05 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2657335csm6688046a34.5.2026.04.12.09.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 09:21:05 -0700 (PDT)
Date: Sun, 12 Apr 2026 09:21:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Long Li <longli@microsoft.com>
Cc: dev@dpdk.org, Wei Hu <weh@microsoft.com>, stable@dpdk.org
Subject: Re: [PATCH] net/mana: fix RX mempool leak on port stop
Message-ID: <20260412092102.476e85b8@phoenix.local>
In-Reply-To: <20260409015519.350034-1-longli@microsoft.com>
References: <20260409015519.350034-1-longli@microsoft.com>
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

On Wed,  8 Apr 2026 18:55:19 -0700
Long Li <longli@microsoft.com> wrote:

> The RX descriptor ring drain loop in mana_stop_rx_queues() uses
> 'while (tail != head)' to free posted mbufs. The RX ring is likely
> completely full because every consumed WQE is immediately replenished,
> so head == tail when the ring is full. The drain loop never executes,
> leaking all RX mbufs on every port stop.
> 
> Fix by adding a desc_ring_len counter to mana_rxq (matching mana_txq)
> and using 'while (desc_ring_len > 0)' as the drain condition. Apply
> the same change to the TX drain loop for consistency.
> 
> Fixes: 5f705ac26259 ("net/mana: start/stop Rx queues")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Long Li <longli@microsoft.com>

Applied to next-net
