Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2D910F3DEA
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Mar 2026 15:58:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C0BC4021F;
	Sat, 28 Mar 2026 16:58:55 +0100 (CET)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id A0998400D6
 for <dev@dpdk.org>; Sat, 28 Mar 2026 16:58:54 +0100 (CET)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-c74f0c3fc16so1124941a12.2
 for <dev@dpdk.org>; Sat, 28 Mar 2026 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774713533;
 x=1775318333; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QqXtsCloCFv5uWtxRe6RB4vQDp8V2w/XR7X/4wLth/o=;
 b=r3E6cCP0z3iOqryrha3CmZLnx6iUvHPDSFB/87WjB5Bcv8r8KSo45DJ75JgANJZm4p
 qFX+CFPwxZzJ9tF9+4VENCiycJPtYtKNlqt+6ywp+EbIplSALxXoLb5qFS3nhmszxCE+
 nQ5GHpC6u9ukPz2RkA4C4l4VOM2f1ucg+9kbGZAKPnSd483FZ6JF/b+vAPq0rerYOIoS
 nNEdhfSqDEXtl4LeVqIWoaB2aKDapefd3Y0krT0AVG2Lg6ZETUppgF81G89ARtDcfd73
 aFZSAFW0d3iLYC/Qei4jM+Q83gPmFQu9Unqhh3BUoSvCZ+b2Jv933xtGhpkX/flEZ0Av
 fqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774713533; x=1775318333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QqXtsCloCFv5uWtxRe6RB4vQDp8V2w/XR7X/4wLth/o=;
 b=JUmrqkTyPrx80IRU887RrE08bXjapWCLugGMp6t6veHuOq+dxxh/X4K6N7IqRzIv6L
 J0xdZlnfeWK1tHCGFuoxWhP/eue/OT7u3l1SYNfhDMQnn+BTqQCU7XxPBO/FTqjFvFJ5
 kO1z8ih+fSoE8azU75G6M7nzG2BSSplKf6aP7AFvspU9702cfVp6PT0E13WZMN4gqzU6
 7GGR8a/wm1Etaw+hcJhWd1csr3da5X+JrofD4yFA+uIv4bFWhbSJbEc/irNhCC8+kXCY
 NFO+J0034I0N02uDg5IJOLma5rmMKnUE+cgw0qt7/3WCsdOpmocwUrARLN7UK18MaOI2
 rSNA==
X-Gm-Message-State: AOJu0Yzm9j/NjkFENzZvUnsFzD/QWu/rwFYvD98oHboJSd7kVzEPGJea
 26lpGCMFO4626ZRzRE/ZNe2uyNHy4QG3tJ321/okgMfFOTr30W0Mv95ufOZL1Gs9kFg=
X-Gm-Gg: ATEYQzynYGDmJSatNZ8tL5luBSgwBTwEUah9yuFc7Bkcf3nnrdH/rSbYeaZp5IcirWd
 aViFt767HuCa43pNv2M3ieBJVK486YXxcPOJQcVGG+0qZ4Fsb7GLMSkyGAPqwWlF9pDXpNIqJt+
 ueind9AOzK+Zu4cehOTVdenFcRo1ZqeYkRSyZW+gl9DzUIv0adWw85AEuX/dzdIEpsz+uz3OfzX
 8Q6zakXeGNGUlsxdRdgL3mtMH1c8BaKCBpsslfKKRd7LSaq/U+seeIY6lF0TWPL7auOswDnjkLI
 7VsEpNQmaknRcl+Xa6oyrZdByRD7p9R1JlYhjyMYjcIzj2/UkVFHed4LGkxxhvp7VKoVE5G2A7f
 qnI8h7dtUXA3BevnLR08f0Ux6OeU2VCEzS9IvlsjlGydLKiuHJvkL6uQVTHzzIhciUjCwgmhatD
 MmFQlU6jYDmjnmPnlQZ3e8mBNQ379CL5hupX8=
X-Received: by 2002:a05:6a20:72aa:b0:39b:b35f:2eb5 with SMTP id
 adf61e73a8af0-39c87af31b9mr6993109637.41.1774713533581; 
 Sat, 28 Mar 2026 08:58:53 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c769160b165sm1991894a12.0.2026.03.28.08.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 08:58:53 -0700 (PDT)
Date: Sat, 28 Mar 2026 08:58:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yunjian Wang <wangyunjian@huawei.com>
Cc: <dev@dpdk.org>, <chas3@att.com>, <humin29@huawei.com>,
 <jerry.lilijun@huawei.com>
Subject: Re: [PATCH 1/1] net/bonding: support UDPLITE protocol in l34 hashing
Message-ID: <20260328085845.383bdc57@phoenix.local>
In-Reply-To: <1774683142-27684-1-git-send-email-wangyunjian@huawei.com>
References: <1774683142-27684-1-git-send-email-wangyunjian@huawei.com>
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

On Sat, 28 Mar 2026 15:32:22 +0800
Yunjian Wang <wangyunjian@huawei.com> wrote:

> Add support for the UDPLITE protocol in l34 hashing.
> 
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---

Why bother UDPLITE protocol is deprecated and being removed
from the Linux kernel which is the only place it ever got implemented

https://www.phoronix.com/news/Linux-7.1-Retiring-UDP-Lite
