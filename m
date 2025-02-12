Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065FFC02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 15:37:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AC8C42707;
	Wed, 12 Feb 2025 16:37:48 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 806EA40658
 for <dev@dpdk.org>; Wed, 12 Feb 2025 16:37:46 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-21f4af4f9ddso84287955ad.1
 for <dev@dpdk.org>; Wed, 12 Feb 2025 07:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739374666;
 x=1739979466; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQ79Y5YbaoKNl02BcGVT1+MzDGuQXNZNmaOqKjbfs9M=;
 b=ZWkeSYpEOjXGFFqfq2r2LZmbyrN7ZYikPM4o2nJ2MZTbkfgMdwx0JT9gH77wpmBF1+
 q8wG9+WadDuVEBH2EL83pUkETWMpPmRsDSJoviI6l1eCFyuPo3t+CC0KXv5bMMPej6az
 c0wXxDHWHVdKD9+8bB978kH0blXoWwd1VLjAMtmLfqd4dOJ72MQJwlP1b4YSLMXyMqHi
 lur4HqxwbtBN6eUeAmyaC4wbIX1POA0eK3TJ/JBKoHDvSvzWDjfMYe3GFxCZBkYCExrr
 R7H3hfQt/RfYc/F+PTCuEoeFCxl95UIeW5J//Zvhj8KRGr4EsK5fBSWH64DJcIRs/kqp
 hQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739374666; x=1739979466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQ79Y5YbaoKNl02BcGVT1+MzDGuQXNZNmaOqKjbfs9M=;
 b=uixLUKfW/a6e2sIrvf2rCGG9pQSKkmYzcy92ccvevWYwbCOm7ozFq+j9Bil9BiheCc
 QPtXdnDk6zU/UqtLnQ5fAxMZSziWQiNBiGjwfxoBP44zNoXFXG2p1BshGNAm48Gb/+PJ
 ywURkHjS9dj8oi5n7GvcMqGY3SHTBIIM4KHfcOjCCK+Oq/3ewx2tdgil7WR8lnXKrfma
 QQ14DFKP1Di1hOt3kGhhti75pzjeJhj0bNHxN9gsODGH3C6I+BVXx2780pl3Pdp8uy+F
 cBA4tU87r5HaK5GaEO5xdKvK5SXb/gMcvE61Abt3UAY3hElvNLIvv3l5pWT+uBCpzVJF
 FWWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnqkzi65hwl3+wJydGdApHRW7piUE/aK6T3g9P+EXpi4Wc3FgAMKjPzN2xWKWEwk4NPv4=@dpdk.org
X-Gm-Message-State: AOJu0YxM5OlueWnjhYnPwmVX82LZ0xHjBnNu8KqHhMwP5UGqvr8zlgAr
 F0ko2upKQ5xbSeUYZxuFcrBA092DG3sEaZQBmy20PhR4y1rlnGYU2mz0iucg1vE=
X-Gm-Gg: ASbGncsQJF3+vXygK48R/GJNiK3pNkx4wcUjv58ejpbCNHuzniCCOwkwUcqC633OFfF
 SA/IOS2+ampfK2yboCOEQsH1D7XiS4bdOlNVx/Xmxg5gDp9Nm2sYnpGqW+IzPOPxzPsFs54/NH9
 5gRJ1gei6xiQ2VUyHpeEt/8eR9rFEeTueQ7jU2014XeoGkq3wW4ccCCFvadPK9Nw0+mOQGgS9cb
 WKnTWdWr+kJ68A+GfkHwIFv+f2CBfh7WSNAv754EKKWvXFW34ueaX8GP83xdB5LJpyopaRAOhf5
 Dwt/kB4hrvdfegLAM3oH5mu/9WvYLtxzvf3r/iO0nrUPMPdCl+VXInJhK794D++BkWw1
X-Google-Smtp-Source: AGHT+IEpVZVLsoIsM/aejU5vYCHjAg1ln/gSog/OcKPeXWaMFCUafvAzdF61ylclYKSuSztpLLS5YA==
X-Received: by 2002:a17:902:dac1:b0:216:1543:1962 with SMTP id
 d9443c01a7336-220bbb45e0amr53312645ad.23.1739374665699; 
 Wed, 12 Feb 2025 07:37:45 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad53aa4678bsm6747794a12.28.2025.02.12.07.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 07:37:45 -0800 (PST)
Date: Wed, 12 Feb 2025 07:37:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "11" <caowenbo@mucse.com>
Cc: <thomas@monjalon.net>, <dev@dpdk.org>, <ferruh.yigit@amd.com>,
 <andrew.rybchenko@oktetlabs.ru>, <yaojun@mucse.com>
Subject: Re: [PATCH v9 12/28] net/rnp: add support link update operations
Message-ID: <20250212073743.7fdd6d53@hermes.local>
In-Reply-To: <89E4C0CDD2F99463+001a01db7cfd$4210f7e0$c632e7a0$@mucse.com>
References: <1739263818-59770-1-git-send-email-caowenbo@mucse.com>
 <1739263818-59770-13-git-send-email-caowenbo@mucse.com>
 <20250211073503.78f084ff@hermes.local>
 <89E4C0CDD2F99463+001a01db7cfd$4210f7e0$c632e7a0$@mucse.com>
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

On Wed, 12 Feb 2025 11:21:49 +0800
"11" <caowenbo@mucse.com> wrote:

> Hi Stephen,
> For memcpy what ever base code or other code all used memcpy not rte_memcpy
> ?
> Even the memory is malloc from rte_malloc/zmalloc ?
> 
> Regards Wenbo.


The documentation doesn't make it clear but rte_memcpy is the same as memcpy.
It only exists because for some cases (like older versions of Gcc and differences
in alignment assumptions) when running micro benchmarks rte_memcpy was faster.

All new code should only use memcpy() unless there is a benchmark test
that shows a noticable difference. The reason is that tools like Coverity, Gcc,
Clang, and PVS studio all treat memcpy specially and can do checks for
access outside of range.
