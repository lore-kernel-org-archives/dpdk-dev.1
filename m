Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02507C83F17
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 18:19:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D09A840609;
	Mon, 28 Jul 2025 20:19:02 +0200 (CEST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49]) by mails.dpdk.org (Postfix) with ESMTP id 4AE5640291
 for <dev@dpdk.org>; Mon, 28 Jul 2025 20:19:01 +0200 (CEST)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-6fafdd322d3so46996796d6.3
 for <dev@dpdk.org>; Mon, 28 Jul 2025 11:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753726740;
 x=1754331540; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qX4OqXX7+JrX4yYt807pqm5y5TulO4cJw08nS4l3veA=;
 b=ZpNOz2RYtASuUupm3ggHkedrqCQAHL2ZRH1/ySM9iaX4yp/iIgR9zsgN1NmgATEOM0
 5MrabsDPgPdR1D2ixylwyV8227fP9cWnUSvLLNdgXHTbdOv1ZlaDMoVss6r7Hw83bnaD
 w0Lyr+wA4wgFKMfMkPjiKV5r9kaLlmygvxJZhCnt0ZrHH3DmcdMUBUU81NIAO4FA4EdG
 SQyDbOw5dHcsGyCPoIUS7AHIYG3Ai+DS1HiDQii2mxKsFtjM6T+V2diCCYdfsiA9jT3F
 eXXDTxUl/PdFtgeIWu9Zt0R0uxI+yM/X+08bJhzyZu2xV5v8jFHGQ4v1m9WFNdyqUzqL
 XMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753726740; x=1754331540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qX4OqXX7+JrX4yYt807pqm5y5TulO4cJw08nS4l3veA=;
 b=OQIv9JkR6gPbHYe9iv3YtDjroWLA6ZCaW9ljoXAhARnVTOnWew+D1hTSDkdqdpz+GF
 f9JxqBXEWNXWk4iIgNb9Xd1gh8HjUdeTfSTfH1ki7JuPCgrdNrf7sRP7DrRyS6utLjBc
 fzfDtMLlbeuiYuQYTJqR9t0szltdCFZJR34HBW2S5nfCKhdYN+3TyF39gUQv6RTnqjmM
 nS3+Hl7Y6tsN5NfbpQifzCau45K1YXdEUVwSpYA6OmfdoQiAs5CoyIylLuR1BSPl4Bfw
 EmdpkPzH5TUdDRTnuIH8disPr3/d2lFjp+ZsbgToXVQzmh9dSscf7cpvoMlwfii/hCVs
 81KA==
X-Gm-Message-State: AOJu0YzgHezBmLKiCYjWB6Ysd/6L2vqVu/T34HYGZAORSvHbDDgG1+lZ
 yg+IsofOcDhnyYrhYiDGfdjB5P5qSGXIpm/3qEJAmM+yn57zixgUKrlqVzl/xfMvUsI=
X-Gm-Gg: ASbGncuDvOK+MOx9DZmeBamrqkc+O76geodxd5sCkeQWIv4jnwxO9EcNYfX8KPPnmip
 c4UKeJtDNkyPpyIyIsbStC2Th77E7SzgiBQ0t8E66UhWZ4pnBG8q5DYRHeUYSF3rD9gMLM7tATH
 mIzVpNqVNRcTGWmwdZZZqs9yJ0JEdf5XC5rc4Dy2NSGaROPvYtpou0/2pJ8xll5VJK3/io8AKNx
 U514Sd6K3fbyoa0jqv2swVG/8a6g+1WjMpiKiUoqZNlByFK93rTlPJ6HaQQyA1fgCR9LAiVcM3P
 YEnN1x4vm4IWnCJVLAk1EJiRm0nKVQa/TIFeGoAt8UKwhZThGr3XeBTzXEuk9fcpW3oRPzUaHJ5
 s4oxBwdBySaWBqK2C3kb5CSEG+/zG/Z69qxbS2pS/GyqPl9MIstraTwQokcG7Y7rdwhzEPZML8v
 s=
X-Google-Smtp-Source: AGHT+IEdUPBwXIh6kUb9z/8avwYCPQ0mOvCMNgK5+7giuEI+afmEFzumfJTwnOTnZLBqVdxzJ/8Sxw==
X-Received: by 2002:a05:6214:cc4:b0:707:2628:3cb1 with SMTP id
 6a1803df08f44-70726284170mr192331266d6.28.1753726740538; 
 Mon, 28 Jul 2025 11:19:00 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7074b52ddc7sm12300326d6.77.2025.07.28.11.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 11:19:00 -0700 (PDT)
Date: Mon, 28 Jul 2025 11:18:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, david.marchand@redhat.com
Subject: Re: [PATCH v2] build: remove obsolete compiler checks
Message-ID: <20250728111857.754c5783@hermes.local>
In-Reply-To: <20250725160730.18354-1-bruce.richardson@intel.com>
References: <20250718121402.856265-1-bruce.richardson@intel.com>
 <20250725160730.18354-1-bruce.richardson@intel.com>
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

On Fri, 25 Jul 2025 17:06:28 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> DPDK now recommends compiler versions GCC 8+, and Clang 7+, so remove
> checks and workarounds for versions old than these.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
