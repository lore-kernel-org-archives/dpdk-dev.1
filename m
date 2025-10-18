Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A28CCD195
	for <dpdk-dev@archiver.kernel.org>; Sat, 18 Oct 2025 16:17:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55418406BC;
	Sat, 18 Oct 2025 18:17:16 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3D7424013F
 for <dev@dpdk.org>; Sat, 18 Oct 2025 18:17:14 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-782bfd0a977so2255329b3a.3
 for <dev@dpdk.org>; Sat, 18 Oct 2025 09:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760804233;
 x=1761409033; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2YmYIIRuAtmFwrKDlRO8kHmbeooaQicWysrXtWS3zDs=;
 b=t6KPGA9qaR5Jr7g0VTEy1c4SsGFJmoL2gmfnoDXhXmmm/Ugs6vXn9cuACT7K/iB5hE
 KDW6dSNKHDjQxhyfI1hmgpc7ACUPgt7IedIkzAehfyHFdaNeSwc0myXn8SqUpccFvQai
 8LHC2FhXpxGTHZFkSycudHJejpqnWHBvzgdhK1zvvPSVWUkDc/nPoKdGorV6DJDbsrUN
 X69HKSu3NXUU1tUti+c6mSkLBqxk8AdaVZ0sSDdNuBzWr/We3lagTjmwl7XJYaAID11t
 VnZh8u/26cc8BKh3jEUlv8EyiGas51h+xYI7T8oVkoPZr8Halk8VSs/RBGn8163hlWwh
 U/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760804233; x=1761409033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2YmYIIRuAtmFwrKDlRO8kHmbeooaQicWysrXtWS3zDs=;
 b=VYxlt3c9tIpFdq7fgFTbHf20rPf2VqPKSEcuuXJHzkGGW9k32UW/x90G1wZFVI5SWa
 0oo+wUPxiAyPmWFFBIQCvSg84bEvlfJ49gmJnmCH5hdaRQvjFOiPOI195wqsUQmfaaND
 /ajm4833F7qihl/SSbibS+VL0hiE+a4TEh2CxuDhZU/ZGVv15JvA2e2d8hA4v2Vpv9vA
 UFfrTXbdux8BKlSqAxLb1sMAJY6EJzOXMkej2YYotBPeBtY4IifIoOCu1ORf3nqqxeZp
 wHTdX0iBG2YI6X+rITDi+ylkgBrzegZtlUaFRmP2P77pIiCvqEA/drZ0XTn8VyDfSEc5
 cASQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF3jx9rSd9hnPrm+HCgcVi1SPQNdbIA9jmAcKbRW9NuKDb1w2LRIDS3dgrdZR6uKoi2GI=@dpdk.org
X-Gm-Message-State: AOJu0Yx16ZQxfSQOCAhsCTY/9QXzMLfHkMFasFu5wO12pfPpyPdqUG4/
 XTKgxrsKYSVBgpxPUGLQyJsJZ54wXNJW46fDWmqQUzYVTZHJduuU1I7KVwVm/jDo1MM=
X-Gm-Gg: ASbGncugy07y7ulMNFlJ2xZgd6CfTe2mAX9fCI4ae+P/KYF4vjyWC+oMtn7Dx1UHoRh
 eGsbFM+CHlRUzFLEDmc7OX9ORPQ9pkbuHSB6Wl9+i25raLhrC9FMyqSyHt0eKlqV9AJ+qzSZp1Z
 z+iwanG4uOd8CYpFgjh5zv387lt5kAN73N2esvuiYFj7EbtY3uqAG8fG7fXLSbxJqxRSW3QsddR
 gKCjGZo1GzwIA1ptY0Lo3kNPUTADqGAwaWxN3BghKEraA31Nx5QlwHxCdLGDBk/LYRO7Vp6ZIDw
 WidbsCn32djz0yAvuLvuzGD3QkzHdAjl2ZP/t5AE9uLJHKiYcgsBpI2kHIFrSxumrdvuHVGDjgE
 vLNNDwluQPjkAUyAxim477d6GqGWYdTu3bYDYlmgI+X9g2fl2ILwKpvpjJe76w5afSrASVpLJzG
 V1aUxglVWaW8GwPdQE/8r4V4gRqJqkuZ+Z/mROGY5eRO6m9e6uwv8jf0zfrgNc
X-Google-Smtp-Source: AGHT+IEAuEJXseVvWpFtJ+Pu9GvkB8Hb81dzlJHdZPRg23YMsfWxiWMRBek4WdASHcOAsPQY/yDWTw==
X-Received: by 2002:a05:6a20:4311:b0:246:d43a:3856 with SMTP id
 adf61e73a8af0-334a857d6f3mr9158986637.22.1760804233209; 
 Sat, 18 Oct 2025 09:17:13 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6a7668fb57sm3098326a12.17.2025.10.18.09.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Oct 2025 09:17:12 -0700 (PDT)
Date: Sat, 18 Oct 2025 09:17:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
Cc: wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v1] net/zxdh: support multiple PF process flow table
Message-ID: <20251018091710.230a15c8@phoenix.lan>
In-Reply-To: <20250924082331.39962-1-zhang.tianhao2@zte.com.cn>
References: <20250924082331.39962-1-zhang.tianhao2@zte.com.cn>
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

On Wed, 24 Sep 2025 16:23:31 +0800
Tianhao Zhang <zhang.tianhao2@zte.com.cn> wrote:

> Support multiple PF process flow table.
> 
> Signed-off-by: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
> ---

Queued in next-net
