Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B5CC19F32
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 03:04:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70BB940612;
	Thu,  6 Mar 2025 04:04:04 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 7A583402A0
 for <dev@dpdk.org>; Thu,  6 Mar 2025 04:04:03 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2ff04f36fd2so362934a91.1
 for <dev@dpdk.org>; Wed, 05 Mar 2025 19:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741230242; x=1741835042; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6lWtZA8l7wZ4TH/IyhNRqdNbQA7qRb8w85taCkIfpaE=;
 b=CpbmQgfTiYmahLIbi+gs/NaPBb1OSErVX45kj8m1GoKpL9zCHmnYCVWAprt5VIzdEF
 uhVYC0qFBkEt8IYcWltCjQfB2VIJD8hbzOW/e1x1WfE83Oz7pYtWXr6K7Jj5EFYCO0QC
 bQbSdKhEwVaDt1jmiiNg5RAwvWv8z/I1RTT0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741230242; x=1741835042;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6lWtZA8l7wZ4TH/IyhNRqdNbQA7qRb8w85taCkIfpaE=;
 b=FfagRRTBF/9YGDXaZNdxoTc8YbvBCvE0ygXnxyC8aHij8Jhhz+aXqCiaMwoardbpD7
 +OhrmuHQLer+iUygIBxyDWYjwsNNXo9fX26UnhEHV+F2MxIGZWFqTuEsZlCZm1mmZ+Dw
 pvYBzlMy2bsJYzPgl6tWKJYos1/k8RH00Q68E+mLZv4M5xdKMFpAifse2pQdoG8XU/fR
 gutc3EiEWKXOLKwtjjJgeEkdTBWE53eiqAX8X12afD8alHWAyWA9vgHOyToBejie2pin
 HDyefhJWpkCQmacEpO3JnTql8tur7LwfKm4/YHlqU4wuElF3bWvO7/tf5N+C6BxyVAlY
 6Ycg==
X-Gm-Message-State: AOJu0Yyy69u+Op3rLyrzaD7pt2p/s9AmxifQr3NRvxfYcelQ/sWw9bQV
 NBGad43+q2d1VedQOwjdt7pua51CmHseFqOTeG1U6pk53Vz6YOUT5/AhYj0nuXPx8NioSkxU6lw
 4wleeLsLYs5oZ2w3ZjL0PTU6nk9hVHEhfqD8Itg==
X-Gm-Gg: ASbGncujrxHdrA96MIJXsIQW4MkBLqj8Q/x5Jc/mdHK/PlzzlsW5kic9A1yCtp0jjAC
 XZVVVrgmltHehRHkpIUCl3876+6C/EQpkex/Y2TyiMnEe3Vp94ZjxMMghOz/VZuvT3Sx0XOs5pY
 FOp3WbjTiB7wpe4x5GE2Dtcs8+PKtkqkmuy4QEmvDNZA==
X-Google-Smtp-Source: AGHT+IEn+265KqK6TJUDp35tLSbnTylORM89cgM7AWoiMvneELTB0twNThxTfcSQLl5KoCyeSQDD3iSJfZoVN0l217w=
X-Received: by 2002:a17:90b:2750:b0:2ee:f19b:86e5 with SMTP id
 98e67ed59e1d1-2ff497358e9mr10356596a91.14.1741230242664; Wed, 05 Mar 2025
 19:04:02 -0800 (PST)
MIME-Version: 1.0
References: <20250305134720.907347-1-bruce.richardson@intel.com>
 <20250305162458.1059282-1-bruce.richardson@intel.com>
In-Reply-To: <20250305162458.1059282-1-bruce.richardson@intel.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 5 Mar 2025 22:00:28 -0500
X-Gm-Features: AQ5f1JqoU8N6b4OnrcOEZ8ZRFGcm8f_6VartGUM-_oodbn6ss3wkVOzjY28e8Cw
Message-ID: <CAJvnSUDnQWnrHitzK1FgvLBwi=OgE3PskmtV6r1RLk4te58JgA@mail.gmail.com>
Subject: Re: [PATCH v2] eal: fix undetected NUMA nodes
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000162e6d062fa3c23b"
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

--000000000000162e6d062fa3c23b
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-intel-Performance

There was an infra failure with the Arm Grace server about 12 hours ago
which caused this failure - sending a retest request.

--000000000000162e6d062fa3c23b
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div>Recheck-request: iol-intel-Performance<br><br></div>There was an infra failure with the Arm Grace server about 12 hours ago which caused this failure - sending a retest request.</div>

--000000000000162e6d062fa3c23b--
