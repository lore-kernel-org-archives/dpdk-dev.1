Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145AECD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 22:50:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6EDC4027A;
	Wed, 17 Jun 2026 00:50:48 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 8364F4026F
 for <dev@dpdk.org>; Wed, 17 Jun 2026 00:50:47 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-30bbe98c3f0so1423388eec.0
 for <dev@dpdk.org>; Tue, 16 Jun 2026 15:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781650246;
 x=1782255046; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:subject:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=W6delSQZybHoG7xYR/E3sXUGIE3wq5ArHAYfd4Vwc7s=;
 b=KM6diUI/ndRSjoZdc3w5prF5xqVjB6jmlmzIFhF0GRGqUwa0PGHwuKWpAqtvEhuFqJ
 ATey3qHXIBMlylVf8JiZLZ6ZW004Yz5doyUtTa2cl43oeYZSkHoKyNHPf7aj7MGzSR54
 PqyWIAYZqzRiC034gl5bA8l1RKno2g/qSR6dOGS3xKrZ8rxJVTXtUCMWb5VYdXy/eukg
 yDkXqRjNFC4RUcr2NJ05h4c+qkJCVTcoyMP9B/iiF1G1OFn3wvr2BXC7Qdez/jpEOzeb
 fm/nA2Zdj80i6n+Bo2DNCaknpR8Frr//SMP8xRRtQTl+XA+sh78febDB+xt4oqg5OxDc
 LHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781650246; x=1782255046;
 h=content-transfer-encoding:mime-version:message-id:subject:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W6delSQZybHoG7xYR/E3sXUGIE3wq5ArHAYfd4Vwc7s=;
 b=GmsMjAfb8es2a+aGyT3f+7eUdG73BQVKLTp5ieZr1NJ/fYxxWwyjL40eN8zp0Lk0x7
 2Qxvt11XYzj3GxGZPeFVvbsUutnawv98qlvPJPy9ICjn20k5iFmFDHVg6WXtc108zRp0
 sTbX2ArQl3ecJpH7JHQJ6K1E6TPDAlTgIeTTaFP+nE88zQaPWtAcFHDjnQkpN1HnsPA5
 /Mq3vlOSmWSvqiSBHeUJ7a1UTQNj08gE5rpK2uILZiv13AOPCWuKjEaSsKgtPjxh1ziy
 suXBLYPdxq8fm+WgjHRu3BGvkhse7RMrlO1ZwWKBeGrzyGh+R003BEi5sXt+QkXRKvmF
 Qhzw==
X-Gm-Message-State: AOJu0Yx8VmdVTr5IBYuTEt5jq54CB/D/Un1f36Tr82Vm3w9F2wHEFfqO
 EiV6isLGRIj6c3OqCDc1nsVYmWX7RgcVCPMnIZNDpt1QCHyIN+SsDmCLVcb0e6OyRvTEainObmU
 HHYFV
X-Gm-Gg: AfdE7cmwg862+lyLXVMg/XmRo63J8IiRQAIXGnUbqNp2Y3zn5npPC4P8RQ3VoTMKPhv
 2D+SMrmlHOwUJxUOAAHOoOqObwrZaNS5pkTWUz6XrDgGa6gkZztYCOVXiE86xd5WHQL7DrMfNfN
 jNXYHpJTUGz1DnpXnElDw/vYNJJGFvzYoTIBhRs1MTSFFpJIxFfkzfdOgaVCordIMcpa/xEwQjg
 gELwpVMl1piiYHeKw4BSQEKft9vKCQbuvh4ll3L+AEnTkEOIYg1wLWNjgh7/EHscEWpT12B32rE
 MAQLHcqIbvOvT8DdBxJ42PhW+osmGuzt+aXClBayuNMTNcvHzi1mXWIsQWoZyTA56X3tnYcXSdD
 LCaBs5wMnA4DxpNP5OyA5lQ4xJbP4V5/L43Je1nKM7wKyp8nT42TGRDUakcAUw/ZQdLxlAv6c1r
 Wig638Rj18HoAm6cXemDZhiQMVDswfJH2uo37lRcccp19ryV0EO6zXaAtiN0EUPhSM
X-Received: by 2002:a05:7301:1985:b0:307:2e1c:17f1 with SMTP id
 5a478bee46e88-30bca0cebb2mr704127eec.25.1781650246458; 
 Tue, 16 Jun 2026 15:50:46 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e48e412sm22251888eec.4.2026.06.16.15.50.45
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 15:50:45 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:50:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: DPDK next-net will closed for summer holidays in July
Message-ID: <20260616155043.6eaa668e@phoenix.local>
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

I will not be doing any active review, merging, or contributing
to DPDK from July 4th - July 21st. If your patch is in patchwork
will get back to it after holiday (on pause); just don't panic if
no review or merge happens.

