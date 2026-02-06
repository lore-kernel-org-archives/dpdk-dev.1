Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8003BECD9B7
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 01:49:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0B3B402ED;
	Fri,  6 Feb 2026 02:49:57 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id B591A40264
 for <dev@dpdk.org>; Fri,  6 Feb 2026 02:49:55 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4359108fd24so1039524f8f.2
 for <dev@dpdk.org>; Thu, 05 Feb 2026 17:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770342595;
 x=1770947395; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nXlPXY4rbUU3O640j76vFgHpaXcTq5cHRIDKjnHFjP4=;
 b=YcGeH4mVDf9pdu5ziJl7p3n8W/uovXllqPxbniIUQLoL5upkFxJ0hoCq6lxJGuLc5T
 DEBjyYAt+nCdVLRrmXE66aVzzqimrvg7MrkteYf6K2Lnwbf5P1QLep6Ix/1B1IAB01Zn
 XbxHho2eyJ7uAX+COP5EzhHVtR1M72wlUCDXVhRh+gLYjZ3vf3yUSvfugGZ3xizbETVf
 ssXl563c65wCEgnv9sy9Odug0Qe4l8KyJ3vq0lkP8boG+WiDfN4r8e6rJcLFXJ33BW5l
 t8EnSKhtHiWPr2Qor2Zt3H/Q1+k0kHfSaeRYU62jO6uHBbLJFBizC7NlnnkkXgRWxYq+
 rELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770342595; x=1770947395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nXlPXY4rbUU3O640j76vFgHpaXcTq5cHRIDKjnHFjP4=;
 b=EG/IvBlJntvRxbAEk5U7nCRfvHX76SpmahDSZ5HQ2IJXwOUQZuyK7bzv9aFfHBalSi
 1I8gYRqCGwjPygFWrqWClC+HYWs3DOxrw8HqagNkt2idGKlfqLm86kDFWUxa/gtsvdZ+
 iTXBlS7YFHg+ZFTqQWD5NOrSEnxuouQ1GlP9Vwj/0gIvcKS7xdeJ/0BW86R2cjGO4899
 Dl2qHnyYsjE48VgLQPE38dBij+3EQiTb2L4HEdOf5hmWQrNPeh5G14ujvuec3+MU7GnH
 GCHR/tOly1wFkdNWlO+V9hwgNcrmZfqh3j0CJGx/QkfOdQYJArvZE/OkuUcB2U+ChM2k
 RYOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnhudc4EhJvbOyuUMZ2HU93AEnqPx5OutgtnqekhPBYEwDTt/QVylT1LkS8sFXDxXJp5U=@dpdk.org
X-Gm-Message-State: AOJu0YxzGlECVgMf5bR6eDOauRHP6i1Ek078YUhienepnjy14pNXy2+j
 P4sTcaRfELpI3H3w2I7Cj8e0Hru7XC5ZlisZwP81lv1iUZOLUZyCI3zQTaSSWopTXUg=
X-Gm-Gg: AZuq6aJkiiblnFSqLkJDtpBwhZjv2HfR/9LiAX5RsRLHhtlIse+FtmZjjuOAXg0etNc
 WSWP4wH7/iHHcIAGFJ4Zcc62ty/3ik+QZkX+jQvuUdvp5ahwTNMc89PjNO/O5jFbmoh+gIa+640
 I3NLVuTB+6bN/ZIoESM3X0dIHyBvER0HVirmTlATBKhx4tGVBjTls3nEwe7e6Exj4O7jLNZZDcs
 jI/butU2DTsNS+wVDSlXe8l5MU81KktuinpzsgklgXxLU3qwltrvh+2M6Axd02lgOEqkbAtmO+h
 LgYWmzW0GIx3ivpbqviYSy3D0+aP0ASSnVJEkcJFP7sO3wOUjYsSv8Yz+mjjU6ly++PFWMbsb47
 iO8M3v3JOZX9HkD2Mr2B1HHzIsLrXPnqxQTBBNoA41CDD9ZN6/SZvnhQ8vDKbL7oOO1+yxcUbRS
 aUJ7pmDZ+UxgJU2viTdMxMN785Z8R2Rqf1/wfBo+BtcKtRW4Nyl98n
X-Received: by 2002:a05:6000:400a:b0:435:729b:c390 with SMTP id
 ffacd0b85a97d-4362968a6c7mr1502449f8f.47.1770342594827; 
 Thu, 05 Feb 2026 17:49:54 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296b2ed9sm2104988f8f.5.2026.02.05.17.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 17:49:54 -0800 (PST)
Date: Thu, 5 Feb 2026 17:49:49 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
Cc: wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v1] net/zxdh: adjust the log level
Message-ID: <20260205174949.2a5294b5@phoenix.local>
In-Reply-To: <20260205092317.2708097-1-zhang.tianhao2@zte.com.cn>
References: <20260205092317.2708097-1-zhang.tianhao2@zte.com.cn>
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

On Thu,  5 Feb 2026 17:23:17 +0800
Tianhao Zhang <zhang.tianhao2@zte.com.cn> wrote:

> Since some flow tables do not have partner tables, change the log level from error to debug.
> 
> Signed-off-by: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
> ---

Queued this after the other zxdh patches in next-net
