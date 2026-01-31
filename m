Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BD7E7C6E6
	for <dpdk-dev@archiver.kernel.org>; Sat, 31 Jan 2026 20:28:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DC21402AF;
	Sat, 31 Jan 2026 21:28:55 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 8002640274
 for <dev@dpdk.org>; Sat, 31 Jan 2026 21:28:54 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4359249bbacso2509431f8f.0
 for <dev@dpdk.org>; Sat, 31 Jan 2026 12:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769891334;
 x=1770496134; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=jlXOST5z5m7E3RxDzvpOdzH8Mqoea0yQYIoDTKiuMfQ=;
 b=jJbdMpIFsbs0joHYbbrxaD0ZZvv8NxUfugqBJZF/mbhaIyLj9Bg9XSJ6QFPd9uJ1td
 u1ZRgrTW7VkRlxHYGolnoHffwSR1AOmtVo5cBeEcgwO6/V2sINXKz9EU8obWnJz1ile9
 pzihWgp+uYQ5cDuCi+zRg4k9MV6wCdZoIFZsJKUvqSYdebn0Uf8v9WrYykCgO/RclnIL
 OSTiriCxKZPxRaYTlYM+eR4L6f3fCAHvtwn1pMGxADHdEcfpm/sUlPfpRBElqVovh4oq
 Tm29565j4b1M2qTsDjZG80IMBeUlUEE6txCFEGUiHflYrwNzUO9FUxdR7aCcwnYJgLR6
 mm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769891334; x=1770496134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jlXOST5z5m7E3RxDzvpOdzH8Mqoea0yQYIoDTKiuMfQ=;
 b=JsJGpUShQMARqVIrtP7bd2+MKysjIJLIG82HRPC6fF++I5Y6UKvuz814uQVJAsOC6i
 vZcVoV3XL13qTR2WfTcvkdSSBIfyiiIWMt9CxVY1L6Bnm354lC7/570uc8qpXzkkl/dn
 Ry1JbAhUtYdRrdKF3Czc7hJPpYDLPotRWPWzefW/J6GPTcE9RKQnXLcszc/Rn8JQ9HYE
 mS+ltXY4UeBZ11nJQpqbzV4XlbpvX7x1r7P+vi01IvOsFWvgV6N2Wf9ezaPYa+eE9d3S
 ub+YWVpNJY7SlINY37+3mPF14/pi3IaQNA9Z3U3QEpReWtzrwjly7ZNSC8yPl6xLKr73
 tEBA==
X-Gm-Message-State: AOJu0Yzf3ldLsszH6GRuFThKxjjBIkOXUq61JJTg+8+MW69epWWMPTMW
 z8ha69C5GmdLm9ibN4irYzZ8gzPPsKhK7dnUiWGocNR8dyxqHRZe+8vyW9ANujHyVYn4a5B5mM0
 HB/8X
X-Gm-Gg: AZuq6aLPmah/jkSdbPxNnIM6sEuDm4/mC6QEByq+L5XBy4qIvD4bW1t2zhgwWQCg/VY
 qQmYVJiCHg/yOfALpowd5hTF7G6sK1lG22ayykUiv77979OH0tUKgmJd6P1nffKQaWzzGDRITiA
 ovMd3YtbFiTenY5WXxaBdPGPniQLbfOjam+P2SGSJwSy55vnxEm0AEhduiMo7sl7Rz5N9HHjpRk
 64r4AsRkZl04kKG8/xAcMPu9jBqSHtrT0g4XG/87iSf3Qea9Nn1ZlEIjHHEoQr+YP9oBkrLFTHe
 ckoKUZvmXDH1GGCw0F/2tq60GPOJofQf5lUL+0g+q0Po3hW5iCkuxqPHcfYVK63rpxQGhmp1OnG
 +HEpitehQ1oa5zQgIHcmcKgpawBfB4LjhVjlxDS7A/T0dvap20ofa7nb82y06sn4ELUtCr4kzRW
 dwt1BPVQlAAnpwvfDA25z7R4MTYHM+Y4/fgv7fwpUNlAVCN4a09hFz
X-Received: by 2002:adf:f3c4:0:b0:436:4ba:59a8 with SMTP id
 ffacd0b85a97d-43604ba5ccamr43694f8f.3.1769891333833; 
 Sat, 31 Jan 2026 12:28:53 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e48a6sm31076048f8f.8.2026.01.31.12.28.52
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Jan 2026 12:28:53 -0800 (PST)
Date: Sat, 31 Jan 2026 12:28:49 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [REVIEW] vfio: introduce cdev mode
Message-ID: <20260131122849.4b78ce82@phoenix.local>
In-Reply-To: <20260131201354.26947-1-stephen@networkplumber.org>
References: <20260131201354.26947-1-stephen@networkplumber.org>
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

On Sat, 31 Jan 2026 12:13:54 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> AI-generated review of bundle-1718-vfio-cdev.mbox
> Reviewed using Claude (claude-opus-4-5-20251101) on 2026-01-31
> 
> This is an automated review. Please verify all suggestions.
> 
> ---

Not all these comments are valid, but there are certainly enough
things that a new version is needed.
