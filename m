Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA34D2FED2
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 18:39:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A61E40E21;
	Tue, 27 Jan 2026 19:39:20 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 5AA9740A82
 for <dev@dpdk.org>; Tue, 27 Jan 2026 19:39:19 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-435903c4040so3719734f8f.3
 for <dev@dpdk.org>; Tue, 27 Jan 2026 10:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769539159;
 x=1770143959; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hSqKjq1EblJtG6iBu+7ULzlQsuVCLstrDxQ9P/yuiGo=;
 b=yg0TTVbeFVxAGrMZLTU2Q4EwtfGyUkbXMRAlHRxegDBACKeAnnYUoV2NBnNYb32Mq7
 Hm3GFOty+UDg9fOpIY329mjHbBkattiSnVuSRowJyVxQuJnLwYRMu7c6yMX/VAkDfbie
 1ew1INjXH6Akvp3COPhi7CEdZEVmg9t70B1VZyWstUNnZegA1GS8gcjCNoz6KtR4yaHu
 2pabeh2/ZMew5An3VqNyIMei+qPbEiGEX+DRTXXRsTCKiaGV53YdF8rG6Uh51egaNQER
 5JT+Wb5LS+22m5ZTJRxwk2qpD5DMlMwOF4ghVRZyOr1CT42Vsx9t4olA1nctJDRzQrLi
 +zYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769539159; x=1770143959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hSqKjq1EblJtG6iBu+7ULzlQsuVCLstrDxQ9P/yuiGo=;
 b=WHUMdlnQuLbqDr4jt9IrQrxvP/77tmfprpwp8Rb0o7y3lmLjnqgbL6z3Ev/4oT07wQ
 QVXrW37JvJJVlTE2cFCCW+IjYUisQTdeLvXycD2st9ZSMTu9uddoN7AhaEJR/o4Ep/Ol
 1Jq6nXI7RKRy1uyrf5YlWcEdJ2PYzk888bwSJKs5m+WjPwYzVV7FiFeXXvb3pfkbawaS
 IH4OqVcT09X6zQF9e0nV3b9o6ylQjS8gFqZJFpssE8UvV2yOYHA9QtTvJCJaetBz+czE
 7q1JJyXySsZL/rq9bWMquI9UdMrBgiBU1tFfWqm20zKh5cgEV4SFe/VwEa4gBY2bsHYi
 W2Ew==
X-Gm-Message-State: AOJu0Yz+Dv81eGwNCb2rAG2NuS4c/x8VYhOF+KZqxB6ynLj3UaQk1to4
 CML5QvPmw4kgOTy3brNDrtsQOd6djmdZ6Vucnf8Z/NF3Q6fWqgs5KB8UZjTzzmnnTlY=
X-Gm-Gg: AZuq6aLeIM5PehjlSoO8rwiDm6N22qhX565TL+UaapvYStmgl0eXoKrqrxXfVEiK053
 o0T8rInUMWPDOQuWt6p/GLAY93wgr5TExYwtHd85yxQOQ0EywlSGgQS+1qrYOp7+3PLBJYIHY6R
 tlK6OJD3xicWlKLvNoCeCKdGls6jKcPH3Ty30GrNFKcHAdi6nCfsbIqyVKaqYyuR/VCzIPImUly
 x+tQuWbMQDRxcHssymIvi7QgHTc0XCwt32hZxSBiDW4zY60a/AkNbWYHGfJmr6Wdj1wiK0a/0B4
 v3T4ZxZK27l4am8xEqy6ItWMgl8+OCDu/YlgIahdC5SE7jMpSpdMM5lRxh1IAvYZNQAdBpv5flN
 gl65u8XzDktCi5YMGgKmkBO/4VbCpG7Nc5qCtJcF0hSo3cgWyAsPY2FE+wGOOyzlZ0sgsnab2VY
 6PIk8xCV3YeTlhM4PL47yxjt0eS+X5fsC8WDlF3H8eUWXE0iQ3EZdN
X-Received: by 2002:a05:6000:26c7:b0:435:a135:7772 with SMTP id
 ffacd0b85a97d-435dd029989mr4101525f8f.4.1769539158216; 
 Tue, 27 Jan 2026 10:39:18 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e483asm698286f8f.3.2026.01.27.10.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:39:17 -0800 (PST)
Date: Tue, 27 Jan 2026 10:39:11 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org, linville@tuxdriver.com, stable@dpdk.org
Subject: Re: [PATCH v1 1/3] net/af_packet: fix thread safety and frame
 calculations
Message-ID: <20260127103911.0908b2b4@phoenix.local>
In-Reply-To: <20260127181355.98437-2-scott.k.mitch1@gmail.com>
References: <20260127181355.98437-1-scott.k.mitch1@gmail.com>
 <20260127181355.98437-2-scott.k.mitch1@gmail.com>
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

On Tue, 27 Jan 2026 10:13:53 -0800
scott.k.mitch1@gmail.com wrote:

> From: Scott Mitchell <scott.k.mitch1@gmail.com>
> 
> The AF_PACKET driver had multiple correctness issues that could
> cause data races and memory corruption in multi-threaded environments.
> 
> Thread Safety Issues:
> 
> 1. Statistics counters (rx_pkts, tx_pkts, rx_bytes, tx_bytes, etc.)
>    were declared as 'volatile unsigned long' which provides no
>    atomicity guarantees and can cause torn reads/writes on 32-bit
>    platforms or when the compiler uses multiple instructions.


This is bad idea

Atomic is even more expensive and only one thread should be updating
at a time. If you want to handle 32 bit platforms then something
like the Linux kernel mechanism for stats is needed. It does:
  - on 32 bit platforms does a multiple read look (like seqlock)
  - on 64 bit platforms is just regular operations.

