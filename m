Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB286CCFA00
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 08:18:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B7AC40270;
	Fri, 31 Oct 2025 09:18:53 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E5CD74026F
 for <dev@dpdk.org>; Fri, 31 Oct 2025 09:18:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761898731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u9dkmZ2GUSwskoiL2i7FBXAdIMJIqX+r8e6jqP3KGpI=;
 b=gwBbZQY21+Y6cq0M0WvB6VHZdmOcoOLh8A/4tQCyNzuaXhFvjkubSEmTFnLtZzhj3u+hji
 5IaXJKc5lPBz+JOCJIYuS/4A0CY/wAp8fkVwvHKHum2H5Rjl4siod5D29y8d5c3i4cUUrS
 RNMVksSUgotZpgfG+s3XTRCRTBHA4hc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-ZmBbnpGNNRSSvb4mhPpWXA-1; Fri, 31 Oct 2025 04:18:45 -0400
X-MC-Unique: ZmBbnpGNNRSSvb4mhPpWXA-1
X-Mimecast-MFC-AGG-ID: ZmBbnpGNNRSSvb4mhPpWXA_1761898724
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-592f38ee5c1so1674623e87.2
 for <dev@dpdk.org>; Fri, 31 Oct 2025 01:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761898724; x=1762503524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u9dkmZ2GUSwskoiL2i7FBXAdIMJIqX+r8e6jqP3KGpI=;
 b=Dl6lDY+NAtc+xGxdBEqHpuyQxU8hfFTm74rrA0Lq5Kh7sW3lUEgnQRlef8imIqyvs0
 fLZhlcR7UjlSGRm2X7cQhTHd8zRQqX5yVOc3po2hWjmI7otDDuEDXtMTmkFw4l+7nqW+
 m5v5H3dJZbt4N9WPLtcYekFD2ULin/Wm4HE6Mm4UGbJzsoWTRZAssoH7nHIAF3FkhbpC
 qZJ1+qExVlS21W1w+RAxqV7X+75mmT7mglcs3GAS1RGhD5NgcOa/wHIHzYLoYZ2wMpTP
 UEvFzSaaCI24knkRccMpx5NJPyfHJdzkl1Qjmlp6oiSvHmuDQ3mJq+iZeGPy2quhzVLU
 mXPQ==
X-Gm-Message-State: AOJu0Yw6jpAi0/0zJYC6hYoX2S8nT9JMtWmxSp92Z5WT1R6tHxxnwGqZ
 6soV10HaCTWctbxkFHy1/29mnjKaZCI9d5U4KtpVOkaao/iNi8flxuSSiEvNgYJn/9jHCRrHyYK
 fzhQiKZ5PTLC+upVj0jf/TH0v/EjmuLZTJTmXSs0rAoDvssnMZxPcbqphgAvVsnjunjRk8MlBNJ
 d6EkfSYeNrLYoX+q5q8Jk=
X-Gm-Gg: ASbGncuq0ULnIVVQE5Rpwn4VvtBrDzcgaMPJe/6yFFveiLBSUO4c0N0gkvYdp/Gj44h
 le3FCXvGlynWfcXwpwJXkjdldHlrrpfECJt4QFASrdt16ovR2lCZT+qaodPsuY+8bmtTWOK8Qk5
 LPFmqFDB4x+ocpgxqtEfB0PDXwcp20oFncMyOJHKpk+30ipBR1w6ZKWO9mIQ==
X-Received: by 2002:a05:6512:2384:b0:57c:2474:372b with SMTP id
 2adb3069b0e04-5941d549e79mr1037547e87.49.1761898723895; 
 Fri, 31 Oct 2025 01:18:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw/umUKDKTSSjiYwmwS8PKkXOWwZ4zQN4NbilrvZy2CiAkQzy348NZ9IEaDqrzPZsz9Nj6fB0RJEHA3BCJQKk=
X-Received: by 2002:a05:6512:2384:b0:57c:2474:372b with SMTP id
 2adb3069b0e04-5941d549e79mr1037540e87.49.1761898723456; Fri, 31 Oct 2025
 01:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20251030175329.4041960-1-thomas@monjalon.net>
 <20251030175329.4041960-3-thomas@monjalon.net>
In-Reply-To: <20251030175329.4041960-3-thomas@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 31 Oct 2025 09:18:31 +0100
X-Gm-Features: AWmQ_bmtBlyRXP76vbUltvc1ncBwQs8Q4vWWWvOdP795mAxkWcto-YfA9m-JNko
Message-ID: <CAJFAV8wFCNPbc=P67dxCkeet4Y5ZAOo=k3OOnbD2wyVo1ShS0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] test/hash: reduce time of functional R/W test
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Yipeng Wang <yipeng1.wang@intel.com>, 
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: giRPx7hOEM1YTM25qeiMkNXXrat_NI1eD6fgZkaKDGU_1761898724
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

On Thu, 30 Oct 2025 at 18:53, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> When running on limited platforms like GitHub Actions,
> the functional unit test "hash_readwrite_func_autotest"
> will hit a timeout, especially when running with UBSan:
>
> 46/102 DPDK:fast-tests / hash_readwrite_func_autotest  TIMEOUT  30.01s
> killed by signal 15 SIGTERM
>
> Similarly to what was done in the
> commit fd368e1982bc ("test/hash: test more corner cases"),
> some constants are decreased.
> In order to keep the performance test as it was,
> a multiplier is kept for performance test case only.
>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Acked-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

