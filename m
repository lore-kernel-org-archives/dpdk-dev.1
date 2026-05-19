Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF22CD4F54
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 19:43:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E067402EA;
	Tue, 19 May 2026 21:43:37 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 4615D402E9
 for <dev@dpdk.org>; Tue, 19 May 2026 21:43:36 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-30246cfd41aso973330eec.1
 for <dev@dpdk.org>; Tue, 19 May 2026 12:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779219815;
 x=1779824615; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GwGghUdB1lFXLxWYwQUD0Vomxof2AtAWQgO7lKBHIdI=;
 b=oUmYbPMN2mal4DbcjRhwGinbLEvop532uHTiq/Kj7ycRB4nDv9AtfvBhEXuzZsifxt
 JUTTJtRjRbIrX+9Rl1lxdFCP7sgVclzqL4FFsTUQAHNp2E8tKPh9mtc8xyxJTo+E77K5
 4+RMOoeln2KIsER4ZXrpEWfkR+nST5NtnmyCfg1Qddd4e012450Z7hxqneCeZ+IjqS0e
 W3O3sUVlzstPHJt1ZzK8ljBO1vfSkbqzjN8V1H1pRk5dYr1bRanXXi/bCKuPAY4aCzpA
 JgxpfPzdapOtL4Y5DMj2K8jW1ZNPEPjziEHUwjQvgOVeOzia3q3LxUIUyFilplNgalFc
 D/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779219815; x=1779824615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GwGghUdB1lFXLxWYwQUD0Vomxof2AtAWQgO7lKBHIdI=;
 b=AXX25eLBYvx2fETJjLH1hgCfO3TQ3wvTo3NF0FlzjHdgUvS7Aqapj3pnuuxbJMcbU+
 dvsB3bboLF1xI75zwfQvpQsDCsU79XQfp/q8AVclM7ThKDZSY4i7kJlioiVM+12nrDEt
 OMw6z7BjPQANWloEfS0AhwzU/0LEGLniQkdtN2eCF5rL5Qn36qs4AFHQZeC0LYeJksj3
 SB9mcB6dybYcQ+ZWLKpU6JiunGYMyyp7tM9F9+0+OKaNtqHA11hFQPPOQUDV+9vNiRBx
 yN3oSCxhLcSRH1gtRN98IYl52dc379TNoGh3U5U08tgk+P6XyL5e+5DkwG2Y9VvW8+o3
 FN6w==
X-Gm-Message-State: AOJu0Yxa668MoZjEJqR4q4LSuA9pC2I8qX47z67R2qUE3AWfhllK76vp
 nEHKxJnOziFw2G7XOw8tHoAObdcb+0Ed/J+XaVtYBu5lnzPxfDNZ7jkjZuR5htIIBkg=
X-Gm-Gg: Acq92OGiM5zzOtc9aUBbagPuECHBuWQkz56zAIgyRtBF0lFcOKIzz3oZ2P6WonvhbR5
 TqGqKOJALtjGVaQHOSZuFTTXTFO7o99jQotgfx2XC17/kn8vGPobFXBc3rPcxPfdkQizd3WmSrO
 yTa0oAm4H39e08EJwg557Se60GGHdEAsZMJ2CLdV0XxdWy3nrHVuXEjI4+rTtpdaltQzcVl2uYI
 rzVTYQS9q+BrS111lWQug8W0eQhlS5JHyt+GdrKf00MT8QCMQGjv5OlIgQASpohL4fbjB9A3b3x
 utPdDGju78DjEKCthwCg1qpOV3Qm34cZF6OSaQAnDjKhs7ENUanYhBmmsMwY7cwCE2L40cUAzvl
 zc0z9eUJ4/u6Yxk70eEhQX8YNyopCmDWcMrYOGCmIyAZRdL9Esss08Y8ziv6QIDzjTqeU//5iJr
 ZgahWCFpzOc7YeV1ESRgadwljM5U7/QYt367QlKyLIEFNDsNvkrjQru/UFTAPa5jxG
X-Received: by 2002:a05:7301:2f85:b0:2e0:4edd:64e4 with SMTP id
 5a478bee46e88-30398699c66mr10902938eec.26.1779219815172; 
 Tue, 19 May 2026 12:43:35 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302947e917dsm16785598eec.12.2026.05.19.12.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 12:43:34 -0700 (PDT)
Date: Tue, 19 May 2026 12:43:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [RFC PATCH 0/8] remove use of rte_memcpy from net/intel
Message-ID: <20260519124332.5e68fd8f@phoenix.local>
In-Reply-To: <20260519160823.1004973-1-bruce.richardson@intel.com>
References: <20260519160823.1004973-1-bruce.richardson@intel.com>
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

On Tue, 19 May 2026 16:05:57 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> This RFC proposed to replace all instances of rte_memcpy in Intel
> (and former-Intel) net drivers with just regular memcpy. This is
> done on the basis that the memcpy use is not datapath, but is used
> for flow configuration, virt-channel (to firmware or PF) messaging
> and other control path functions.

Makes sense. You might also want to look for where structure
assignment can be used instead of memcpy. Keeping data types
is a good thing.
