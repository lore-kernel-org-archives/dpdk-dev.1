Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D28C36010
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 23:55:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 447AD402B5;
	Wed,  2 Apr 2025 01:55:22 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id BD4AA4029A
 for <dev@dpdk.org>; Wed,  2 Apr 2025 01:55:21 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-22435603572so115383775ad.1
 for <dev@dpdk.org>; Tue, 01 Apr 2025 16:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743551721;
 x=1744156521; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LBNDhAgmIn6jhiXhoquT705iahpBXE3JhAkcmVynUCs=;
 b=jE/20F2Ve3FDvUd1FXgKVmtpyeqtNOVjLnwki3gJ5l+XjI8PivX/tD65RbOt9onsG6
 93k9LUTBRoU+sSFTNLU1NbxlTghG1Aopsm7kqXh9npWGd9z5IAmpAsoP1scMBJ4WjYF7
 JnNBAb9adMlUSUdOWXRnBqd2sOtWebWgyq8e5We/R9GebFTEDyO4w4c9TUxAZHhUIYDj
 SZoAamYlUd2Cj+EcjU8oyBAo4/sQ2GurBN7L3Fz3uXctkj1aFFk486zx/poCcMmWSK4w
 Kb33AyzNF6A7Wu4+e09VzJsdlhPFKTKiWsnm2rknEsuO4WeICqgmb8D81ZYi2KNVkEXM
 gFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743551721; x=1744156521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LBNDhAgmIn6jhiXhoquT705iahpBXE3JhAkcmVynUCs=;
 b=CdKjTaP73gZfjcmrhBwozhFRbFyV+3VgE7GN6/41Vrv5YO6OYKB21CDgln05HPO6Lq
 HRuOR0krAM4iF4yINC4o2hkHwbsP7h7uAJHofl3JczP3SooH5O/ca/MQGeGxGja8i3lR
 TuQ3VCYP/NSKiq2wMo/pU+KX7tAJ56Q54RYH4Ark51U77GDOuGQ9aek3C6u+Up87eWvB
 ekxlTPemAVs1wXUglO29/o6xm/vi+PXlU1uXFFWcyj+RgOPVSA4XWtQzHqT0UNzjBOeP
 2RljhU3v63OjBQz7of4d9Mk+gHTJP+tNmY9CK+cfqDEB+g0FC5N7eaGN7wom/kQe/ohd
 XNvw==
X-Gm-Message-State: AOJu0YxlErCbj6JanmIKIsKrZ8Nriuqz48gR5Re1bs+ztPgOysFga8/n
 /7Od+lyBGsZYuXeGu+8cHSliovAAnK0YKC8QDdRK6qhX6vhQPdeTyv4/ZjdL7xE=
X-Gm-Gg: ASbGncvXCWzUiCCVGug6cDhsu+bKOvomeUFQ2g/W8NHI5JYVEoavQt9QUWiAP6TPLiP
 YGKQ9+C75vd0q+fWw/czokNHoCnC/quwpuMLtzbgEYrjuo6qWICn0k/fbVRDJKfAXHYXN2PtRxU
 StZBI98He+LP+7Q8ZD7mkE//4GfJy+9xTFy7JU2MXgoxiJGeKWD64y1+A6+y8T54vqp2d/AEifE
 m9IzFW03QBXl/XK807+vTRGYQM/8HjBzSXYXQ/U3Bv00hHzyaoKL0uX7hYkWsu54g3fbkE5RLDn
 wLaYRC+5H7GJrQr9xb+9VfMmnzib6LzCYQzeNgirQn2fkOReEXt5QzEbdRUxzcx4uTlsG+fBdKv
 DH46OXFhlDhlNQvOURGL9
X-Google-Smtp-Source: AGHT+IHAdxNghvh1QBNNyvXu1buW6eoaqlfqZAVQvwjwKBAV8cY92NjsIFdDQSxik01mjjFzx+DV4A==
X-Received: by 2002:a05:6a00:2181:b0:739:56c2:b661 with SMTP id
 d2e1a72fcca58-7398038250fmr21214740b3a.12.1743551720595; 
 Tue, 01 Apr 2025 16:55:20 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73970e1f8c1sm9884243b3a.53.2025.04.01.16.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 16:55:20 -0700 (PDT)
Date: Tue, 1 Apr 2025 16:55:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Nandini Persad <nandinipersad361@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] doc: reword contributor's guide for grammar/clarity
Message-ID: <20250401165518.259fc79e@hermes.local>
In-Reply-To: <20250401234545.32515-1-nandinipersad361@gmail.com>
References: <20250401234545.32515-1-nandinipersad361@gmail.com>
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

On Tue,  1 Apr 2025 16:45:45 -0700
Nandini Persad <nandinipersad361@gmail.com> wrote:

> I'm reviewing the Contributor's Guidelines to be more
> clear and concise where necessary.
> 
> Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
> ---
>  doc/guides/contributing/coding_style.rst | 105 +++++++++++------------
>  doc/guides/contributing/design.rst       |   9 +-
>  doc/guides/contributing/new_library.rst  |  31 ++++---
>  3 files changed, 77 insertions(+), 68 deletions(-)
> 
> diff --git a/doc/guides/contributing/coding_style.rst b/doc/guides/contributing/coding_style.rst
> index 1ebc79ca3c..c465bd0f1f 100644
> --- a/doc/guides/contributing/coding_style.rst
> +++ b/doc/guides/contributing/coding_style.rst
> @@ -15,14 +15,13 @@ It is based on the Linux Kernel coding guidelines and the FreeBSD 7.2 Kernel Dev
>  General Guidelines
>  ------------------
>  
> -The rules and guidelines given in this document cannot cover every situation, so the following general guidelines should be used as a fallback:
> +This document's rules and guidelines cannot cover every scenario, so the following general principles
> +should be used as a fallback.
>  
> -* The code style should be consistent within each individual file.
> -* In the case of creating new files, the style should be consistent within each file in a given directory or module.
> -* The primary reason for coding standards is to increase code readability and comprehensibility, therefore always use whatever option will make the code easiest to read.
> -
> -Line length is recommended to be not more than 80 characters, including comments.
> -[Tab stop size should be assumed to be 8-characters wide].
> +* Maintain a consistent coding style within each file.
> +* When creating new files, ensure consistency with other files in the same directory or module.
> +* Prioritize readability and clarity. Choose the style that makes the code easiest to read.
> +* Keep line length within 80 characters, including comments. Assume a tab stop size of 8 characters.

DPDK has updated to allow up to 100 characters (happened in last year or so).
