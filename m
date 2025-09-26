Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6768CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 17:20:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2AD940647;
	Fri, 26 Sep 2025 19:20:54 +0200 (CEST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by mails.dpdk.org (Postfix) with ESMTP id 9086F40262
 for <dev@dpdk.org>; Fri, 26 Sep 2025 19:20:53 +0200 (CEST)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-4b5ed9d7e20so23202491cf.0
 for <dev@dpdk.org>; Fri, 26 Sep 2025 10:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758907253;
 x=1759512053; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=maZOTdhNNJOVyxHaU94FTvI+hhweLFqriFZmDxwmPmo=;
 b=W5YGecEgn1o1JFWAZWYvSVEbUKNWim4onON5jJ6iwDPRl0jGPQfYH+mkmoX7cF2FP7
 zHIOKzKyBZ0MZv/b+3FDK++voM0fZWyHC5uEnkwJi6tXWAsR3yWrc9YxZa33067J10M2
 esNSLvtkRXW6hGxl4R0cVHSvMD44zbcuHh/hggDcc8WquWrEDg39PMPqIjnllHpKcfmc
 wNqP/aelF2yralYqMouYE2dvTC44DiGGxE3lxSj+24to4kVDlajPC3DHC4MPxYfJJMYL
 QA6CY6CW7yhv+eE6h23FX/uC858GVPvBFgCQO1uAqh1iDW13gLOh3TUxcW7hn2brs5tm
 qKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758907253; x=1759512053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=maZOTdhNNJOVyxHaU94FTvI+hhweLFqriFZmDxwmPmo=;
 b=n0jJbPj3xX2yoUD6RjGbY5T3m/inPZhmiR850ENNEHlyDSgVvFEc7i8omN1gXYMpJa
 VD3VBAZ+alN+vURuD8xRBRwFOYmZ0cr5L6P9DQ4p7OlKcCUFJsXJlQvg71BLgyhg+dRv
 5U4legWc7idzB820GGEwC7P3vft87k1QjxcotuNogAJn546BIlFWWBWbCaNqDYFBIg5H
 7QuLwBZ1Qtq/oqjLClRGBLlGWZDFueSMbGb0RzW8JpnSeMKTiEbAHaDH3ndOV7EME8de
 ZOksVaONFmb09wUqbe28zkfy3bcot+ObUMB8BIhv9NYAEzdXC3ukOXD/l8y5tkJOqHpI
 8QbQ==
X-Gm-Message-State: AOJu0YxAT03IPZNH9ISRyiNNhLeQEj+FvyL9kTrPDvexZFRS1o5UHtlN
 pfaHS+ARNY9Wtxgtc4rAvF9DV5HggT/VKlqAAupjYlHdPn09BgbGSAKlvLFeZ9RJVoAoRCzQ8UO
 aVUQZ1AQ=
X-Gm-Gg: ASbGncvenkItGp64+jfuP65RbTxxjeGCeBobgZezvmxdoWH6kNyx93+Z0jpk/W99r7R
 sqaN49YOXwwazEWqHcH3hNIMmt7RyEtRJ2P7haq6asVwe8emMN7OrvE1xqZMG5ODidvnTIr3isc
 SLnbIFM+mfIkPHepgLyJUBoY4IByWeXgrhJsv1vzvgLMyPp0cbnVbBEZ/Jtf23c+s4Vm4TbTHmf
 /BIJfpMR/OskhlIYB0d4RCr0gwRjcg8tnXqz+wVSlplwAgUXj+QHXCfG6aTQaHQipmapCmvaHIm
 wTQpoDafQuWF5z3wpXT1/IUgPQWul2OdW04jtkspjzyfqjoARSbpjMn68uWdOXOjyko8zGhJF78
 nDHgQpXlnRFUekOKqFgkl5iDRMWl2a0DGBEKPs5sIMpLs4c1uj1MSoZz9PkI/ZDMhtS+YyYdjYA
 Y=
X-Google-Smtp-Source: AGHT+IHbw+DRLUT5wgaTKe1g0EURcWwYMy3wB0mcdeSiIHsQxPiPHr+8TKbBIpb9C7/6ty39ZxDX0A==
X-Received: by 2002:a05:622a:507:b0:4b5:e868:ffec with SMTP id
 d75a77b69052e-4da481d8f76mr103246341cf.8.1758907252614; 
 Fri, 26 Sep 2025 10:20:52 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-86042e32249sm180162385a.44.2025.09.26.10.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 10:20:52 -0700 (PDT)
Date: Fri, 26 Sep 2025 10:20:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: longli@microsoft.com, Wei Hu <weh@microsoft.com>
Subject: Re: [PATCH 1/2] net/netvsc: make da_cache_list local
Message-ID: <20250926102048.3fa1837e@hermes.local>
In-Reply-To: <20250926155802.398869-1-stephen@networkplumber.org>
References: <20250926155802.398869-1-stephen@networkplumber.org>
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

On Fri, 26 Sep 2025 08:58:00 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The list of devices is only used in one file and does not follow
> naming prefix convention. Make it local.
> 
> Fixes: 9a9d038c782e ("net/netvsc: cache device parameters for hotplug events")
> Cc: longli@microsoft.com
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Queued to next-net
