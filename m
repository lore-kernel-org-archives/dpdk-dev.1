Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50542C369CB
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Apr 2025 16:17:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 967A040156;
	Sat, 26 Apr 2025 18:17:12 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id F0A43400D7
 for <dev@dpdk.org>; Sat, 26 Apr 2025 18:17:10 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-7369ce5d323so2679779b3a.1
 for <dev@dpdk.org>; Sat, 26 Apr 2025 09:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745684230;
 x=1746289030; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/14rGpKhW8WAaKi5CD4Fwq/3zhu+4wkAV233j9E3wHk=;
 b=2cmhOA64OqhNNT+kJAPcsmEe9B8PtULzuggjEzGT+44CAD4/Fn1xmQk1/b9t0g/dnr
 ikB1Upr7EEgISuG/K0nWVLpjvpuEFYwVymCB3ily+S4wHKAoX/gQNeC7C8p6kYwb7kEJ
 XLloZkpzF30M6io6UeX15zH0n2aJaFDgz9ihpyNI6F/+SBptVAcHo1FwGEIowd7XcSCH
 jaR2F9CJmBP6WQ+AjsBlZYk3F4bsoHuH1VeZr3cd5X4lc2iQRWJPoGnWDPMxdh+3vsIr
 x6ms32cPH/ZeoIFzFAPobn19YUQcqzYHr4OIViDBrQzXqxdtjyKhKjWmICOHPPXKNbqS
 Ja+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745684230; x=1746289030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/14rGpKhW8WAaKi5CD4Fwq/3zhu+4wkAV233j9E3wHk=;
 b=tQpzYdhsFK0u6+9G/zb6x6s+wFqtQNui4uQf70xVNAwDkYD1B5LEH3VVmZppr+JlTI
 cDSkOGuQt+lpgXL+gcFhCnSVoo4x/zXo100iGFUV99rsNmwvBDZ1C4HJfrCbPn2ouMKV
 3VlKIW5GNE+eMW+SM9kbP7ttRHlY2DWXBls8ZZ3JklCGSAPzg9zEcc5SPpspdF3HW+Qm
 dIntFwDS/2yJEjcolvp7UUy7PYWkqGqgeKfQOHkKR6wOW9dnur3t9UA3tM6JZsQPFkyH
 RME1oG0OjZjvYKH61e/NHmagh35h/OVt7+6NjoNGnrfNfv3j4qCyI4Siz4BDsjoSvn55
 r7pA==
X-Gm-Message-State: AOJu0YzCnfhzGmtKn4T95s0VOkJBVciAxA/dY8IAi0qeZ1RMoKemBxyt
 ayLUjeOt0uE1IBuhGMBdegavdSb36N9dWXGS8Npo1gsBo13oA81n7rWxnaUESVk=
X-Gm-Gg: ASbGncvTUl1E+fmsg5K29IDmGvULKm1fg6ln+MaujhKYL/9TKUO/1UlixQMGXRh426t
 blUFp422jNeDm7hTJbm9CkmkToPOvU0Vk38sNu8NxqSir3gx0fH8Nnb7hOG2Ubis+68nZji6TR/
 lsKXNyCd5t9r4xXvBQ4Q3imjdJ3fu156JvK0qyp40oBdAg/4lSfV+yAaFIGzOyB0QkbH/ck3iWD
 kOw4bmRE4GDvFaTVxCEXuYNCKpgK054Qkc8p5dk9MpCjVr4JNiTz9XfUTVK4dGL5hXAvh7dWGFV
 URN4JiaU5Ogv7z1+4dx7CumcPkyja5Rvfp1uj5g1s+60F8cRC1o+CGOHX0iVXNPDBztGgn4/zoP
 tb9WwCvdhm3/Hx+UN
X-Google-Smtp-Source: AGHT+IEydIbjbyJgoLG7dSbcfpT9B8yANtfX3caQBxwAGWG+P3BBmOrBLCDVDsxxmwAQiEvUKGX8Dw==
X-Received: by 2002:a05:6a20:43a8:b0:1f5:a3e8:64c1 with SMTP id
 adf61e73a8af0-2045b42a884mr8563086637.0.1745684229719; 
 Sat, 26 Apr 2025 09:17:09 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25acc600sm5143724b3a.173.2025.04.26.09.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Apr 2025 09:17:09 -0700 (PDT)
Date: Sat, 26 Apr 2025 09:17:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 02/13] net/sxe: add ethdev probe and remove
Message-ID: <20250426091707.633deed1@hermes.local>
In-Reply-To: <20250425023652.37368-2-liujie5@linkdatatechnology.com>
References: <20250425023652.37368-1-liujie5@linkdatatechnology.com>
 <20250425023652.37368-2-liujie5@linkdatatechnology.com>
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

On Thu, 24 Apr 2025 19:36:41 -0700
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> diff --git a/drivers/net/meson.build b/drivers/net/meson.build
> index 460eb69e5b..429e6b17eb 100644
> --- a/drivers/net/meson.build
> +++ b/drivers/net/meson.build
> @@ -64,6 +64,7 @@ drivers = [
>          'vmxnet3',
>          'xsc',
>          'zxdh',
> +	'sxe',
>  ]

Put new drivers in with same indentation and keep list in alpha order.
