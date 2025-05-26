Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2388C54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 14:44:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4785840608;
	Mon, 26 May 2025 16:44:26 +0200 (CEST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46]) by mails.dpdk.org (Postfix) with ESMTP id 4ADB0402ED
 for <dev@dpdk.org>; Mon, 26 May 2025 16:44:25 +0200 (CEST)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6045e69c9a8so2594999a12.3
 for <dev@dpdk.org>; Mon, 26 May 2025 07:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1748270665;
 x=1748875465; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QnjtM0jyZCPBNzvcDCSxotUjmT8mMXKgHgYzkM66pKs=;
 b=pb7N7Yg43XKxSzveS4M5zd4HeVg7Ms/IiCyUgRX1xm3ASRzCczDoM+j0LX+mYqHY05
 AqQNmi4CXNPK7vU0JIF7CoDNW59tb6Xq98Nhjytc2P8t5KNKUOF4XWY9hKwKmjI28zhU
 mWeMGHfrE+/qNee+8v6Zg6jn06t/7FiNCCsFQatBShoZR9u9EY/9r++s8mzItzQGF4iI
 H0iU/Z8MDccBnpAqkuXtl1dpYnphYk6C3B2HPh6a8hW3SAqyFTDhCDlH5cNf4hld5F0I
 Yl8iUdUlJLoK7DFkZQqW8/e2ta9EleGDlzlEOxWbclZn+CmwXyW5/X3oZon1Cz0e3woQ
 SYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748270665; x=1748875465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QnjtM0jyZCPBNzvcDCSxotUjmT8mMXKgHgYzkM66pKs=;
 b=dvb93tzQUFwQWGJzUQR8Jb5FdNl2DQT6HE9C4ygsCwLt8g/2kUhRInJNF2MmU4QcpK
 BevQeMn4xYT8z0g5Ri1R85E+6TeBOeHYmFiBpWJ/bFn2ZN7kEqF5kXpTspQ1XDzTKTIy
 XXiI2DU3yD16wGIFG8phjKzFvQ4AhcoYKWa+7bguKEmJB3ygKvcV5G3Yu+t2lN+Emc9u
 AfGUFZwB/9dJ0VD42WOmZ/P5uvf4R4UNe5nqJR5H94XPxqLtUg3xQAI8X/2xCkDh3ii/
 JlOyUfUd/NkazqLHlkkrEyjRMQuR5E/aHYwDuzYzKe+GwGkLHDZl3l5T/VXnbv3dsMFY
 958g==
X-Gm-Message-State: AOJu0Yxdoq4Uhz8zjVDf6zVlu06Y5b2bNVa3S4oUt8InYBGTsFlwDUPb
 3DUFgEcQvv+/9W7NSPLP0WELIp2vPeZhPoCTWHXvL2ZI9rPvxThdL5p9yolQihi8Tlg=
X-Gm-Gg: ASbGncvuR0KhRgYgSaE6ZAXUG7b9FT2oQyIsp6qw1T0HUQmUWtO/0ohXNWq6Z+Lqywm
 QkkQ1xXw4A5DlTVTy7DVwtxaaCSBc6Z+stM2XRdmOqBoRuufNV/hxr07DVEMCfTWnisJQNCfLbi
 CLYekBl221ze1OPovLSgAu5tmUM/Yto7QbRLwT0LdwK8AIl3itFx9Izj7u/mxBYKzxlRkGbfecH
 I4znG1+77KtQEcI0cJK588FD1Ao3bfkUNM9c9aw2UeMjgV4SH5kY8sqfxgrHiJV/25YKOXnOPLb
 Pp6NVbvxfbCFqUaVm6NXsisMi0Y0DwUO9SOdtBboI2gAfqMnhkF6YDdLl1SRGq76XrlhXxP66Ld
 5Wa0V1CXLfgCXiVqrpd1TcFG3Vhje
X-Google-Smtp-Source: AGHT+IHnXHr3PeQLdgRkIG1WwO917l6/ms4yeSly8kvi3b1Ut+8B03Ni0gC8ct9RYZlEJmXOiLk+SQ==
X-Received: by 2002:a17:907:8dcb:b0:ad2:5499:7599 with SMTP id
 a640c23a62f3a-ad85b0d2777mr808281566b.18.1748270664567; 
 Mon, 26 May 2025 07:44:24 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4ea8aesm1697628566b.179.2025.05.26.07.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 07:44:24 -0700 (PDT)
Date: Mon, 26 May 2025 07:44:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Brandes, Shai" <shaibran@amazon.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v3 0/7] net/ena: release 2.13.0
Message-ID: <20250526074418.2241b32e@hermes.local>
In-Reply-To: <2dfaa5f5cb1a44d8bbb001d19b72211e@amazon.com>
References: <2dfaa5f5cb1a44d8bbb001d19b72211e@amazon.com>
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

On Mon, 26 May 2025 14:13:27 +0000
"Brandes, Shai" <shaibran@amazon.com> wrote:

> Hi Stephen, and apologies for the multiple patchsets.
> 
> We had a bug in our CI that prevented failed runs from showing up correctly in the report, this has just been identified and fixed.
> While rechecking, we discovered that one of the patches in the latest v3 patchset is currently failing to compile. The problematic line was replaced in a later patch within the same set, so when applied as a whole, the series passed in our directed tests.
> 
> Problematic patch: [v3,4/7] net/ena: support fragment bypass mode https://patches.dpdk.org/project/dpdk/patch/20250522132614.3379-5-shaibran@amazon.com
> Failure on the entire patchset is now visible under https://patches.dpdk.org/project/dpdk/patch/20250522133029.3575-1-shaibran@amazon.com/ 
> 
> Since we aim for each patch to compile independently, we'll need to abandon this patchset.
> Could you please advise whether you'd prefer to abandon it yourself, since it's already marked as *Awaiting Upstream* and it appear on the remote "for-main" branch, or should we just change the state to *Superseded*?
> Thanks again for your time and help!
> 
> Shai

No worries, was relatively easy to update to the correct version.
Yeah, mark the latest correct version as Awaiting Upstream, and other should be Superseded.
