Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11E7C87FC9
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 22:12:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4F44402BD;
	Wed, 30 Jul 2025 00:12:55 +0200 (CEST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 0837D402A7
 for <dev@dpdk.org>; Wed, 30 Jul 2025 00:12:55 +0200 (CEST)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-3b7862bd22bso157806f8f.1
 for <dev@dpdk.org>; Tue, 29 Jul 2025 15:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753827174;
 x=1754431974; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NVukZ7wxKD9P9aMxJ7N8ll4r7VLBAhalrFVmn0KGEU4=;
 b=aXVfUrfh9EzuzjeDDCShMsVovj+QcRGvFQAAMyjMfh5vTN2Nf1lVKoyuzkWbDTAQ5S
 0YtIpIwaqfuAbdO++kXpcHhtTk1ag8+YOG5w6cCe2tWk66La7EZp0v88NldgPlsAil1w
 y0JGYXkiFsGGBK8N7pgZO+LEZdsCb5JeynkflxZ043LX4gIb1kemzHpGR/pCUIQBpAFu
 5idnS4UyykYgbRadg8+toIfhbFlrfPhJVIjR0dapU+omqILDCV4hAMhlc1LlACKluoYD
 xYF8a4u8YaLvDJaukbBqqxMShpP1qfOTBABRFz83te+J3sZSMG/cSHGDCRvy2LAnngMQ
 RK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753827174; x=1754431974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NVukZ7wxKD9P9aMxJ7N8ll4r7VLBAhalrFVmn0KGEU4=;
 b=R+ZIlJxECaENxH5T667VtP8ewNBokVj+HXX5eUGmVOm3imvdq1UT/MlJuHV3ZYDxj/
 +Hh43K/yT8CoeOTy02b5v2uVKti+giE2hyOseUr9ALJlYmk71QJj/8+Rvbe28RFFTeLz
 Y0u5FEpzeXwGFyNXYIb8gW1YAYRFgArXk7OYjgOuXWQwc/7PkJzOBRckavd8aLXLImRY
 THnoXQTxHsL+04SqORziuJIA+GyRoWqsD/JKWrrKyn/yxninFt3ItVkrSBDe9XH2mIpw
 jmXMUCkzyKMKCzpV922xlhQEJWdi06XmdJDvvYZ9OXSo0GGk4ZkarJXlZLI5Lwq8TUZ7
 iqng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLKT7gwUb/16aWb8HKHw5DX08vcSEgulDj5AclFi3CbVQ2O4wYNimNb/0vKFeseO7BwII=@dpdk.org
X-Gm-Message-State: AOJu0YzOpaTt590fPDTQjMSUcpLzK6Ptmr26hvS7UOunxt63gPxsVowz
 CQCSYfd92AYQMnVPt3CcBqbiRQM8Z6AqvKEkLyE9c86OkoL9s5zFtzXIHPcwWWuI7xc=
X-Gm-Gg: ASbGncvn0BxPb8qagZIFJngB22ZxuCo7PHxeYv8LH0iHrIXEFWDqfq+WegzqZdU1lDc
 yn1VzMg2WN7kXMcXHOBzFR4gQfiTz89VjQWrkE25cUkfzDKyZFqaIYaWqbo19ZhE69k8w+/JX5I
 gUmINviW3Sp0/Eloixmvqb8g+E+29ne3F2OVHGWDlErn7P7nzNp1eEx4+1SydleF//D0Yrh1GXj
 UBIHIO23BVNBakan0d43ZZpPCJhUm8bvKFBY8xiSL3y0KYblPwHJcaJZTnOHOUHC19TfaWgPDGh
 YRJy/auszCWuNnTqL5Wb/0bDbDqyJFDU9liJY9M/HiF3RP5RNmfh1hvtne/QhPBpOVnEnrYEd13
 2xs59wZcSuHJGCndQZvgPnMEeaGS6MepmdaxZCrWO1EGKGHNETsGm9r5+Mayb+sbWIDGsibtNRJ
 EFB+Df+dY/5w==
X-Google-Smtp-Source: AGHT+IHRmCqI8JzSanT/i9btRIHVhjf8IE0mxdNOnbdvGKbp4CFGpwfELG3p2EAnJZJAGfpvzVOMtg==
X-Received: by 2002:a05:6000:25ca:b0:3a5:8991:64b7 with SMTP id
 ffacd0b85a97d-3b78e726421mr3990139f8f.26.1753827174619; 
 Tue, 29 Jul 2025 15:12:54 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b792ce46fbsm2834082f8f.0.2025.07.29.15.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 15:12:54 -0700 (PDT)
Date: Tue, 29 Jul 2025 15:12:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ashok Kaladi <ashok.k.kaladi@intel.com>
Cc: 20250723125702.3787183-1-ashok.k.kaladi@intel.com, dev@dpdk.org
Subject: Re: [PATCH v2] net/tap: fix BPF build failure in cross-compilation
 environment
Message-ID: <20250729151250.050b43cc@hermes.local>
In-Reply-To: <20250725054258.48135-1-ashok.k.kaladi@intel.com>
References: <20250725054258.48135-1-ashok.k.kaladi@intel.com>
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

On Fri, 25 Jul 2025 00:42:58 -0500
Ashok Kaladi <ashok.k.kaladi@intel.com> wrote:

> During cross-compilation, BPF build incorrectly includes header files
> from the host system instead of the target sysroot. This leads to
> build failures due to incompatible headers or unavailability of header
> files in the host.
> 
> Fix by using the Meson sysroot property to correctly locate and include
> BPF-related headers from the cross-compilation environment.
> 
> Fixes: d8d065045c4a ("net/tap: rewrite RSS BPF program")
> 
> Signed-off-by: Ashok Kaladi <ashok.k.kaladi@intel.com>
> ---

Queued to next-net
