Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8211DCA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 17:45:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA28A4029E;
	Wed, 27 Aug 2025 19:45:54 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 02C8140292
 for <dev@dpdk.org>; Wed, 27 Aug 2025 19:45:52 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-45a1b05a59fso510105e9.1
 for <dev@dpdk.org>; Wed, 27 Aug 2025 10:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756316752;
 x=1756921552; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXM+tpOmb3Q/17YgnYDyFK/IGcYunRuRSC1UUzfp+jQ=;
 b=Wm41fwCu8N94ac49kUrBIR4mwRiEI5ta69k7Xt7fv+GpmINj5vTsVExRbFLBEW/B2d
 tFFqv8Rk/vBuBrXlsXSBeLuJH7o4IQ7r5CwfBXru7DVq85tR916rYNmAB89B3uL+bGjf
 3txjdtlnxVCKxirN45h/iDe+Bc2GXlH0MAmEa6KUQH60b0OguKcHuHhP3sMZjkpJSCw4
 GYdAfGLb+8wtJiDr8xG/dwtzQPO1gg0EtjIes2vc3ULyARo8BWs7YD0sTBe3RXmVxyF3
 r6ID0nqbNgNNJvfrGoRytBmCr9vn/5rwoMVqJxopSo8eiCIZRAZXXhBNfYyZoYejL3+X
 BzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756316752; x=1756921552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kXM+tpOmb3Q/17YgnYDyFK/IGcYunRuRSC1UUzfp+jQ=;
 b=hvqIXEM1t9LcwDVBuKXJqAOGqOfDJIAyFXRBieO+qBh4k3ihBDu2v1V4Pa//tsKDcM
 7NLId485loNJWx/OPNKPMjDExvjWsSBzRQ3rqv6WtcgTJO+UflAz/pNIVfjWd3vdBSNS
 5FT6c8lXQzE7pvLNEvqmLyfxyYAxQR6JeGdhegBCPdmuzlysiv4/79zQEZTfrqHmQlpS
 eNatXHygsztMNfGQq47/vb/AWxFrHMwzGVt97FxDw2KdjOg9iFc7PMW0VfUHRuXhI0Vo
 hgfTc1P9FaDb5GHicVm0GbbE9EcKRcP4TccS8dBZKDPpRHZ922dm70dw/8Shhafn0uLn
 sv5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHu1Iv0GXyLdvVaoSs7qnWf6f9COl0Hb2l2y03K6FiN5bR+Uql01AEwfWDzW9FMDoTBi8=@dpdk.org
X-Gm-Message-State: AOJu0YwHgSsiWG+x4dosvMAQRwYnqYIFxeJtQ8PMG81ftd0fSTxbH4kp
 qPTU5Sd/Rscj5mi9mKQCWHIo6U+vdP0bXgynlnATYQUrCXNmXeA2a9Sd0wUCaJLqH80=
X-Gm-Gg: ASbGncsCVWHAeDgCvqG2LZR8zJHlW5SiP6KgX4oUW0SZEXqzwGNgf1p+xMIMbvJBES5
 pbBpgWywOCg+1PCWV5DZc/Xc+UIVUtD1Gqr7C3lnBOwCu7nH63zzPwZMfcxDvNeWJn4m79lt2oN
 xBusU/kwzWJf9yyEYFx3Nl16kyA5m6WBZtr7rVnQdvW+OheT9OX+CZM8cckFq5r9NJmcVdf/4d8
 30GeEQjtj9GIsBaONl3YYGs7fYbYuuBA96Y0Jyixp4hp5wQd3Kyb0+uZMQufM6Wr+SRmjdilhPz
 nODzgNC05vBdD2Z4TzZOHquCpTjm/h+1zu2AJH2Mhx5iCO623BOXGIDOKQ7SN9F8Mpi+4UWKW9+
 JqHXGCmH/Z1/dNJ9//llTnlZea1mUpy/vf/hbgEDeR9fx+wTy83FcpInvQ+NP+hOIuqveTuVAs1
 I=
X-Google-Smtp-Source: AGHT+IFAAc543r92RkbQPvLDFg8UeCvz/uxk7J12T/osz7PY5T8PM9/F9KxMQY6QmPas6PDlFK2kWg==
X-Received: by 2002:a05:600c:45cd:b0:45b:72da:e622 with SMTP id
 5b1f17b1804b1-45b72dae8a9mr19608645e9.28.1756316752302; 
 Wed, 27 Aug 2025 10:45:52 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f30fe02sm37710545e9.18.2025.08.27.10.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 10:45:52 -0700 (PDT)
Date: Wed, 27 Aug 2025 10:45:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linuxonhyperv.com
Cc: longli@microsoft.com, Wei Hu <weh@microsoft.com>, dev@dpdk.org
Subject: Re: [Patch v2] net/netvsc: cache device parameters for hot plug events
Message-ID: <20250827104547.3a6907d8@hermes.local>
In-Reply-To: <1756232132-20348-1-git-send-email-longli@linuxonhyperv.com>
References: <1756232132-20348-1-git-send-email-longli@linuxonhyperv.com>
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

On Tue, 26 Aug 2025 11:15:32 -0700
longli@linuxonhyperv.com wrote:

> From: Long Li <longli@microsoft.com>
> 
> If a device is hot removed and hot plugged, it needs the same driver
> parameters that are passed to EAL. However, during device removal, all
> EAL driver parameters are freed as part of the cleanup.
> 
> Cache those driver parameters for future hot plug events. Because we don't
> know which device will show up, cache all the PCI driver parameters.
> 
> Signed-off-by: Long Li <longli@microsoft.com>

Queued to next-net
