Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B616ACD5BB1
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 19:22:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C8F4402AC;
	Tue, 26 May 2026 21:22:24 +0200 (CEST)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id 0864F4021F
 for <dev@dpdk.org>; Tue, 26 May 2026 21:22:23 +0200 (CEST)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-1370417c01cso2385335c88.1
 for <dev@dpdk.org>; Tue, 26 May 2026 12:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779823342;
 x=1780428142; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+SBsmI4WkHom1x8sPvgp5VuKGYf07MhA7gQpayyWKOw=;
 b=cqeiu+hTAul6f6P9btHC62cPxgJJrGIorWJhdVOhOI7uNR6IlE6ZqK25eknTXr7fnQ
 4sKutzo4VTXY7wUKok32z6t3wkRkpZg/BlbknPTNT56lSf6hu2HpBlI7MMYa7ii5zAUt
 3uRpqOi+TgNSM7HIbZsSr+zFLEqlNBLaaS2htvCc4mZ+4pXH95D6QSciWad4vfv8pZQ6
 BKJUx2ntjmPD6ZjKxoff2NA5Y5fumA7fxXNwUs0D/GSj4VNW5n4nJrtudNlGTJYD5+zX
 CteAieb7KvMpDff1UGaT5AcET96Lo/d/tODyIL2i+s+2O2zCll3nRCTNefgpbH5zWSQ5
 5i5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779823342; x=1780428142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+SBsmI4WkHom1x8sPvgp5VuKGYf07MhA7gQpayyWKOw=;
 b=rLKeYTrqTVaZEvLMFfZ6teh3rftlHICa6ElAzFJXfNrMbccwXWJzvxjTFID0vc/rY7
 ITgK9yPUMQKvrKLn+2E0VFv8ycXHcqm+rV7v6AzcaE8XTf3Kip2rgalaMhQmxdz5w1A6
 KLeB171+HhG0nB+oxVs1FhOiP+s7ewI0moBNznZSVznrisdnXyi776GtHaOHn8JPJOCu
 09KgBt+xtgfje7FHAiz+gsVMzG7fRRMzSxsfq+eN+o4LlRY5KB+3+7oJG4G559Tt8ASg
 9LK7sW4oShoGNwf+9SjUXpYQW7S3Yus6kywUZYX62koqIiaKCbC7AiuOSZwoqgNGVLWF
 JIkw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/P9fUQplw6JD5FXfwKArw2zmfd4DhBtMd/lcuFfc7dI1/lTDgwVEd6wKGdZJWei8UcScg=@dpdk.org
X-Gm-Message-State: AOJu0YzjLLWGvwOIAedMPUVEHTAU4R1kuKzoYUVh2j0bMXGOjLH27RZo
 Iv4vV4Wmm6g1WbRUl+SmeDUuO387SpRWriQcMGGQPLii55UW9iDW7IV+Y4yivz1Pt6E=
X-Gm-Gg: Acq92OFHAKNZ+z0Av9YoMUW+bCzLieKhNy27XQ+va7uxPbW63fw9CeD0K7gMerdO9g5
 7MHm8Z39KlgcNRpXJjNlHkugWNL03cKRMdVnhB2CYSTvzp8sa0+54IwNFcZcLyzbXhcK9ZV+311
 UAlt2Wg52y8VZwiTYXPFOmDG4339wpTI8u9ZHOQc69Qik5NcEmdCdQ0NJbbzhBbRaRQAxUQsmcU
 cJqklcBxT1LBlwmBfoiyJcUpe9GagRLlIKfiHfki5njGlRfDtsIt57xRtXF0IkTL7yB9VE1hjs3
 WvvgKLq3nZMq9IX2nZkJUdsoqJLnD42FEBqeXSqXBRl82no+WDGN7UvbIVuYTIMx7M6x+N6+/hF
 /oQrwjkknbGz6aFTlKD7Ot532tBZkWQzwC52gSkyCpbser0Tyy+u5dtizCVOsTkpbUDeOHtai61
 lORnfkSROxhuViU8aOMaYL3DHEI2AS4xYn9xlElKaYtaSfKyJHjVgzHWwT1YS2sBfr
X-Received: by 2002:a05:7301:678c:b0:2dd:6937:79cb with SMTP id
 5a478bee46e88-30448f91fbdmr8681802eec.12.1779823341755; 
 Tue, 26 May 2026 12:22:21 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452259de0sm10002710eec.22.2026.05.26.12.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 12:22:21 -0700 (PDT)
Date: Tue, 26 May 2026 12:22:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Megha Ajmera <megha.ajmera@intel.com>
Cc: bruce.richardson@intel.com, cristian.dumitrescu@intel.com,
 praveen.shetty@intel.com, dev@dpdk.org
Subject: Re: [PATCH v2] app/test-pmd: add generic PROG action parser support
Message-ID: <20260526122218.1c29d917@phoenix.local>
In-Reply-To: <20260521101354.726240-1-megha.ajmera@intel.com>
References: <20260521055612.508916-1-megha.ajmera@intel.com>
 <20260521101354.726240-1-megha.ajmera@intel.com>
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

On Thu, 21 May 2026 15:43:54 +0530
Megha Ajmera <megha.ajmera@intel.com> wrote:

> Add parser support for a generic PROG flow action in testpmd.
> 
> The update adds CLI tokens and parsing logic for program name and
> argument tuples (name, size, value), enabling programmable action
> configuration through the flow command interface.
> 
> Example flow rule:
>   flow create 0 ingress pattern eth / end actions prog name my_prog
>   argument name arg0 size 4 value 10 / end
> 
> Signed-off-by: Megha Ajmera <megha.ajmera@intel.com>
> Signed-off-by: Praveen Shetty <praveen.shetty@intel.com>
> ---

This looks like a third attempt to parse text into rte_flow.
Not sure how this fits in and why it would be useful?
