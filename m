Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6606E7E0D5
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 19:44:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7A0C402F2;
	Mon,  9 Feb 2026 20:44:25 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id C93D9402DB
 for <dev@dpdk.org>; Mon,  9 Feb 2026 20:44:24 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-43590777e22so2064413f8f.3
 for <dev@dpdk.org>; Mon, 09 Feb 2026 11:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770666264;
 x=1771271064; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wv7ZGx4ReWcEXj6ge1UsRsGkQF4Wcx6U7WE5BwweGyc=;
 b=nsM3JxnBVa7/0Q0fXX/QKKcSmr4JAQNENU/+jy2xChaLTvy/PCtCG4ygYfjWjxnjDZ
 MYwcxkrKGna9LUG3gcIYqVqvTqDpc4IlNewZiNA+Z33s04tiSir1hs1RajpSxS/DUC7W
 OaxN5t84SmMdntXwtjD5xqvEx73bfszdp4Y8C1n3S3RmyFcMrXSGkotd5E4Nuv6+raq6
 S2/dlsXIFY1uqRtepRvB3ZoE/hkniEayI87iyOHE0PXpTOvEiqiAFIBK/g2m8Asnl17R
 4A8kgkwDdGvRHYtajJMrR+qM42Xh1eEzQy+zRQCaclT1VK29v69PmiNkSD/b6+0xq86R
 892Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770666264; x=1771271064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wv7ZGx4ReWcEXj6ge1UsRsGkQF4Wcx6U7WE5BwweGyc=;
 b=SVmLsVFrte3RQdZnMIrYc1TGKr5+s8XCrvO15X/lK6R+MQVbd7NTV75WUTcmTKlI8M
 e+sK0kIWdWvhRhpYZ7vvBFLkO7hiBH8PUKHjWpiC87pX0/Xjmz4FbNfp19fCUzWyKp2O
 RAprC8q1KMviME/nUKybIBl8j0rL837IEfC3vaWlwotZBM+ikoHoBi20LoUCxSTWYw2R
 UJz/irAcVOaZBkQ16IdDi/hxb15rYyp9nS4O2mdka+GKOya4GFvojG0oGCSmnAX/94kC
 1plGgnocUBPHtGtVgrI0fXOzFUD9g+JN1gGbeChSLG2EL7H/1okgoBj6OCNbMgmvLc2z
 BCXg==
X-Gm-Message-State: AOJu0Yys4/RjG30CDXGOSGUSjya7hmHQSjLuJNaYPhF6y2eP2AwwzMV9
 ebRmV4iPepdRgTi0QWVGJthoR1qo6MbTbcnfDQAeVVfD+ICXE2PtPs62yDdozowWmg4=
X-Gm-Gg: AZuq6aJ8sOcSPDKSVo/J+R5qKLH2gnN0uYMjTZJ5cMXPlBzvvWgQ/rXorLgdmnmjxbM
 2vKcen+yJAXKsi8/pfFglrfAbL4qGnj4en0BJpOMU4FcPGUBqYD+lFiNvmq7NVL5UnxP4/vceTp
 et8cFyUiIBGYf4FdTrRHR501U7AGGEI9l8wdWM0F8ELLII3Cx3sCGTQ69m1XBNNj4zsE60rwQEh
 rfLkAZ0BjEKIt7N3Z2LQqem/LVd6z8a+StEzd0qKcbtFd9+MclJS0+ZOLPGFrRuuNQSQEgRXDP9
 hnCKDggh2mzee6NOePyrA9RoYPdzGtKktmuaR1G25OsIDA18kKeU0bc7e3HK30NQ5KCk2dNCvTG
 eRgFkw7Gc858q8iyliB1gLs5jlBfQPTJ6Z7q05TT9NWKFFP4a8G/CnJbXp9ozDkkihEop2GKxNU
 9vi2RFC2TyscenueyONXYyQetDyFVMJ3SSY3nSyLLNJeZf7kpFoiuL
X-Received: by 2002:a05:6000:4285:b0:437:6e63:915f with SMTP id
 ffacd0b85a97d-4376e63966amr8503570f8f.53.1770666264333; 
 Mon, 09 Feb 2026 11:44:24 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362972fc26sm26745762f8f.22.2026.02.09.11.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 11:44:24 -0800 (PST)
Date: Mon, 9 Feb 2026 11:44:19 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Howard Wang <howard_wang@realsil.com.cn>
Cc: <dev@dpdk.org>, <pro_nic_dpdk@realtek.com>
Subject: Re: [PATCH v1 00/12] net/r8169: update driver with new HW support
 and fixes
Message-ID: <20260209114419.1e39d0de@phoenix.local>
In-Reply-To: <20260209085502.26722-1-howard_wang@realsil.com.cn>
References: <20260209085502.26722-1-howard_wang@realsil.com.cn>
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

On Mon, 9 Feb 2026 16:54:50 +0800
Howard Wang <howard_wang@realsil.com.cn> wrote:

> This patch set updates the r8169 pmd driver to include support for new
> Realtek hardware revisions and provides several bug fixes and improvements.
> 
> The main changes include:
> 
> 1. New Hardware Support:
>    - Add support for RTL8125K, RTL9151 and RTL8168KD.
> 
> 2. Bug Fixes:
>    - Fix a bug related to RTL8168KB.
>    - Fix a potential NULL pointer dereference in rtl8168fp_ops.
>    - Fix the incorrect link status reported when binding the PMD after
>      the NIC has been initialized by the vendor driver.
> 
> 3. Configuration & Optimization:
>    - Update hardware configurations for 8125, 8126, and 8127 series.
>    - Adjust jumbo frame size limits for non-1G cards.
>    - Tune RX descriptor fetch number for 8126 and 8127 to improve performance.
>    - Remove support for legacy CFG_METHOD_69.

Please resubmit with fixes as needed.
