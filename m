Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E1AC71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 15:20:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2444E41104;
	Tue, 17 Jun 2025 17:20:11 +0200 (CEST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 4AAD441104
 for <dev@dpdk.org>; Tue, 17 Jun 2025 17:20:09 +0200 (CEST)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-7d094d1fd7cso839177785a.3
 for <dev@dpdk.org>; Tue, 17 Jun 2025 08:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750173608;
 x=1750778408; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1zVC3+ndJepJb9H4NjYgzvYv7P6mHlwKV6J4zQZPV6c=;
 b=bOgvfoKzmuO6DSpN7073hTesza0eHhtGK5oVj+ZSVwc3jeOmxM98Fj62uG8kQblaaj
 HVfl5k31/AaOY0C+kVELAbxpvK2LkfFTZb5rowPP7ftf31NxzL7ssgM5bgJ5c0fuqlNM
 vbX44TjYIQd5khd7FOQi/Mk9J2OUIgejfEaBWZoDgV+t0d3Td+1K0ZvfRd2aIXglABo0
 Eml0NvUxxYSd/IJgTtTTZO1f830PYv7wIveTO/GxTV4y/v2A7xY5SBtpHMBLetswoniy
 Jg3rb5MKEHxeOriLaXLFx6JxRwZZ5FNGq/YYZc0rdLbDPKskwRfQM1rx/J3qaUihyFUv
 H3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750173608; x=1750778408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1zVC3+ndJepJb9H4NjYgzvYv7P6mHlwKV6J4zQZPV6c=;
 b=TWdqQq8d9k4FnAEVuSTXCxNzYiiLUNWb9Bm7rxq4Kxb0qY3jEJPOQ/7vzsKKxku/Br
 RaAmJ7pUOfwnNdTkyTGLrbN+wsBDEY52WM5/if7OA2Np5CUU4yYwoeCU/miCxRCbAPts
 TSbVYNOW3PTysNrh+51hLyutrVn6CPNXZfqHh6CSEI3R+61LbdogSE2RyeeDoiCvYEe2
 mCWw6AF/9Pn60oF29lKQUCKOow91gZEzua+WUI9r7NQMS6CQRH3A7AyZZWXE24aD65ys
 kRonXTExF0VgcIII22dXR9E5A5GYYSjuZpPdEaj8ATRncuGMWZZ8NZMRXPSjrTBv5tEN
 8LXA==
X-Gm-Message-State: AOJu0YwD7Mp9Hgsr70Yph1kKdpXlHbqpHcVKgJcwt3XcWAZ/spveGSPy
 6WPXXwWxWlaffhGWRL7Z1AXLGEq22wIQpPWDj5jrdx+ThbC1iqfT4YY14xSzNyk4jGP561ei58u
 AEMVj
X-Gm-Gg: ASbGncv5ATdg1ovtZ/ABrh4QCcY5jFOIzCsX8/Tw2MpdeSNtDG9/vxEvGPV2UtpSNrd
 ybMJg0PdYbxKgW4EzU4Szul2TvwaLlMasZLNYc75zbL53AXNKsBOa0m0oXUjAmRP3Tckli5dU8K
 C24vdX1ivRtPTpPBSG9R6c4CQqY+Y7Q9rzB5rd3zGISM0TMnIPNg0YTsWR1OI2i5SUOZeM3KdvL
 glCwI+bf2yK5EOUINU3vXnh2a58qjo8m6riG2tiQ7MCf1LOo5oeDa0Q6lZQR+NvzV/rLWjJiGcT
 4jXU1ETUsr9AFS0IA/tcVwJr7DuGKqg0+MXEWY7QGzFrLMy0ar6tAKbaP6r5zbKBXJNvPNoQD8P
 SA2mpPPALi36+MZOT+ay1TzyM4lQBHNZwk82btdk=
X-Google-Smtp-Source: AGHT+IFd3/JrRH8dZY5ZHCiVvFr3t6iwqmbahq8ozBF5CDtgPMBq1I+zuclueM03lV6NJxxSkcPZXw==
X-Received: by 2002:a05:620a:44d0:b0:7d3:90ab:804 with SMTP id
 af79cd13be357-7d3c6d124eemr2212782085a.58.1750173608552; 
 Tue, 17 Jun 2025 08:20:08 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d3b8eacbc7sm658702985a.62.2025.06.17.08.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 08:20:08 -0700 (PDT)
Date: Tue, 17 Jun 2025 08:20:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v2 1/5] net/zxdh: fix meson.build issus in compilation
Message-ID: <20250617082005.2977069a@hermes.local>
In-Reply-To: <20250617020503.3554511-1-wang.junlong1@zte.com.cn>
References: <20250607023020.3051575-1-wang.junlong1@zte.com.cn>
 <20250617020503.3554511-1-wang.junlong1@zte.com.cn>
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

On Tue, 17 Jun 2025 10:04:59 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> fix meson.build issus in compilation, which
> caused the inability to compile in the arm64 environment.
> 
> Fixes: 29e89288ff14 ("net/zxdh: add driver skeleton")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Junlong Wang <wang.junlong1@zte.com.cn>
> ---

This series looks much better but please revise the commit message (again).
To help with stable (and user reports) it is better to include more
precise wording of what the problem is. It is clearer if you use the
word "fix" instead of "modify". Also, describe what the bug is.
This applies to several of these patches.
If it is a bug fix it could be marked for stable. Although this driver
is new and experimental so won't get backported.

Instead of:

Subject: net/zxdh: modify some MAC config issues

modify some mac config issues,
which were discovered during the testing process.

Fixes: 1c8f68b64cfc ("net/zxdh: optimize MAC operations")

Signed-off-by: Junlong Wang <wang.junlong1@zte.com.cn>


Something like:

Subject: net/zxdh: fix issues related to MAC configuration

Fix error handling when MAC configuration fails.
This is issue was discovered during internal testing.

Fixes: 1c8f68b64cfc ("net/zxdh: optimize MAC operations")
Cc: stable@dpdk.org

Signed-off-by: Junlong Wang <wang.junlong1@zte.com.cn>
