Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6580AC369AB
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 00:10:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F8B340655;
	Wed, 16 Apr 2025 02:10:23 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id 2C7D640289
 for <dev@dpdk.org>; Wed, 16 Apr 2025 02:10:22 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-739525d4e12so5700926b3a.3
 for <dev@dpdk.org>; Tue, 15 Apr 2025 17:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744762221;
 x=1745367021; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vHKOh7YgHZ1w+CaaXogHqiIPh4JdGIhBf5A3VxSchOk=;
 b=rTmtn6gVmVL33H3S1rzBxoCpIgBDxdB7JaYKPY5lPXXhCX7NoW+9BUFNkcKAbAwWpx
 gHjLcnOcB0XV/MoBdG0blSqwTH1sN/VXM8gGQfnaR5pRuUKFWgo6Ud4A6pSEpL4loSEh
 uymzuncg/JOFQQmtApuDftJuiklcsde2C22ucVLagB9wIOXNAevPHZQ8oq8PI16FjJNw
 WhuBsHtZfSEUmYe5Dcm+AiMJi64nBaJ3GEujQJJlU3MTaNRNXLpLbHE8//4zo2thZYEl
 9LOQqwzg1mRG7IxsyZmqShYeJXtOPZzV/l9y9h4K66KgRFbt3VjVb+NM+EbfJ5t9mnRI
 0i3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744762221; x=1745367021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vHKOh7YgHZ1w+CaaXogHqiIPh4JdGIhBf5A3VxSchOk=;
 b=K41V93jxIPLLsApqEJznPvMYh0FfTJexHcOJkYDbM0GId6/gulOiJdr/xm3UAI9e86
 2bJisArxNRCvs57oViAjLOrV7MLbClQw+AoK8r4DLerv8IB6Aw5NinpUjeNlTWYfZYpX
 Atvlkbywa3iumpOd1y9rvFVfUcFMSyN5XKTCnhx2tQI0V23FxP3kZDc3kVSUv2gsX98d
 2+V6PoW/pJX4oelCDCw/NjFOAAJyB0Y2OGPDv3j9ZsKYcB+iJXBda0suaO3JWbLTjqx9
 uzC7edk2YYwlgmm3mjHSzHzg5imELRkZuct4MEG04UwGYmONYDpKJogOijSExb0v2gDd
 B7Ng==
X-Gm-Message-State: AOJu0Ywgtu5oEMlzhJGF0+Qu7/eDQQn1eDsxE3QGfXuNF4mg4vyW8XvF
 u7VdNIa2zbbf6UtEJU3/sB0YQ1d4LVOHJSKd0F3QPZI4RvGOqQx2+CVfbogSR4I=
X-Gm-Gg: ASbGncuu9QmnT6B6OijMQjPS5pYqoTmZxY9zq0VenPfL3PFSqCc4mj61kP+hdaLslou
 GJBZL/6RopXYhoNWVPhWaz/7E3V/e0NqmTAgzfV+Q7THxQw+q+1ndfSukDiLUrnZXkdd64T1fPh
 uBgq73q40XRnxhAHRh4H6CUxyer+9DHKD7ky9M35jM3lUYtnGh93aMNE8QYIkSZ8dIrxMSTlpJp
 6WzAmfd48Qk56AE9kjgCGQrUAxkJm+g8w+TsjIpxTCMWR356tA/uABiavQBC7gnHXlq58FZ0pWD
 DrJ46suJ4bRjlXqngnzASvHdUpXyTx3DVKujb6DBssuiNtBiusiieSk2eXhii7VAWFJ9Thznwgc
 Ryq7XuQrzUSnCDAlI
X-Google-Smtp-Source: AGHT+IHfMtinjhe32Dm0I3RPCtvl4iQvgw9sgXKVlfcgpgDgqUvwdxmpfas4GZQm9Lgy6acCEV9LIg==
X-Received: by 2002:a05:6a21:3295:b0:1f5:8a1d:38fd with SMTP id
 adf61e73a8af0-203adfb16dcmr1652339637.2.1744762221022; 
 Tue, 15 Apr 2025 17:10:21 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0b220ad44dsm133297a12.7.2025.04.15.17.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 17:10:20 -0700 (PDT)
Date: Tue, 15 Apr 2025 17:10:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chaoyong He <chaoyong.he@corigine.com>
Cc: dev@dpdk.org, oss-drivers@corigine.com, stable@dpdk.org, Long Wu
 <long.wu@corigine.com>, Peng Zhang <peng.zhang@corigine.com>
Subject: Re: [PATCH 3/3] net/nfp: standard the data endian of NFDk Tx descritor
Message-ID: <20250415171017.6d9e0df3@hermes.local>
In-Reply-To: <20250415025453.1348238-4-chaoyong.he@corigine.com>
References: <20250415025453.1348238-1-chaoyong.he@corigine.com>
 <20250415025453.1348238-4-chaoyong.he@corigine.com>
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

On Tue, 15 Apr 2025 10:54:53 +0800
Chaoyong He <chaoyong.he@corigine.com> wrote:

> The data endian of NFDk Tx descriptor should be little, and the related
> logic also should modify.
> 
> Fixes: d7f6d9b21ffa ("net/nfp: adjust coding style for NFDk")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Chaoyong He <chaoyong.he@corigine.com>
> Reviewed-by: Long Wu <long.wu@corigine.com>
> Reviewed-by: Peng Zhang <peng.zhang@corigine.com>
> ---

Applied to next-net and fixed the spelling error in commit message
