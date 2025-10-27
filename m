Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5339DCCF9EB
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 16:17:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F04B4028E;
	Mon, 27 Oct 2025 17:17:30 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2DAD14028B
 for <dev@dpdk.org>; Mon, 27 Oct 2025 17:17:29 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-29470bc80ceso53129535ad.1
 for <dev@dpdk.org>; Mon, 27 Oct 2025 09:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761581848; x=1762186648; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VuHHqw52oduNb9de6Yy54rS4FeYOZ0SYIQHdHTQ+6f0=;
 b=a4LCbvVjvvoph2u/Lcz7V4jTwTZam/zlqW2+7C+SeQoj+ulYmyJOjSUr9fpJZ2c4kh
 suL5WJvaHfPwPum0skdFMKYMmFyvYgPlT5q+XWBccSCxnzS1kDuu31mWJcvAPDI9Hkg2
 B599kUHlJySaW6k+DnPaYcSpQHxeR0qDsWqAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761581848; x=1762186648;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VuHHqw52oduNb9de6Yy54rS4FeYOZ0SYIQHdHTQ+6f0=;
 b=rnlYd0FoaP8cC6UX4LxbX6JjFWlR5YZFpOFlgAjaHEM0sdelp/8Y6WSTfqsuPy1K6K
 HSFrGQB4OJFYa/+6geKvV5cD3g/izIgQU0hkNdLc86ZalG0foI/LSt/+uRilGHUQ6sh1
 eyEXWZeFP+JqZcauaagrJ7Cyua8miRMJDlHZOp/6xJZU9TRtDaLkwZFYmd67HjiOzr5L
 utQBqAvX0Ce9Yz0tCDrF00MnReMUVfP3Q8Sw0rYdycXkXPQ4AsM7KwfqJ9Lkop/Ni/BB
 U6m+eFhJOppSPjdRLXpH5Pb2hCDR4bZszltwkAGFjdHbB4EBAZYcakOBEp5JK8GRRgeU
 4fAw==
X-Gm-Message-State: AOJu0YwNp/1d5RiwRxl06HozY0GqJjPKfmgUA2dCSZvJwVGieUtFycw6
 fNxtK1Wpg6f1/GGYbUtcHqUhPw7sVc8UDFqUgRxDsd9j70yLoozFTBIEMzPjNkon75UR4eG1aPn
 89YpBbyVc/snFlvt7f3OKin1s9eV5AB8VPQOl1nRfBw==
X-Gm-Gg: ASbGnct/pvWVHfN9UqGVvq6vBWB50e4SFyZylL/cY0LES6eBGxzS+sgDuu249UELHuc
 QPEDBSVhAGTtRNxq3KtisbuW+LCipFf4cJ0boAi/HkaZNFvi2s945BcLlSUqQ88PFW6f5ATDkQl
 5NPT0iO6YqfVvju5ZbvqLi0t/qVNPtykdAKR2DcsSBy5gX0l+srUtct/3wGXBQYqau1D8TtCYYO
 aTM2LNGFCn90w0THhW3QdgonjuxS8wrqB3IiBeS2v/FMUPfccwKN6z/BUi8o3VdXFVC8LbXtRBK
 HSMVFKzKnX3QsGWEck89vbZLeY3R
X-Google-Smtp-Source: AGHT+IEWO/wy9uvI279tBY6xuzLEY63aVKt6ad1zzlP1gUlrdboY+Wj0fjEqxkoPAHaXU6IdNVYDTAOCC6Y4LlnZt4U=
X-Received: by 2002:a17:902:d60d:b0:269:7840:de24 with SMTP id
 d9443c01a7336-294cc753d2dmr43185ad.21.1761581848296; Mon, 27 Oct 2025
 09:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20251027130215.95444-1-abailey@iol.unh.edu>
 <20251027130215.95444-2-abailey@iol.unh.edu>
In-Reply-To: <20251027130215.95444-2-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 27 Oct 2025 12:16:31 -0400
X-Gm-Features: AWmQ_bl3RWU513ojguz2PRPZJej7EFuaZUZeHuv9vISoHVP411s4r0_nHX8S2q0
Message-ID: <CAJvnSUB-fVOxTNLa9+71vtUA0YU2GX=rrWF=58n45=xtFtu8ww@mail.gmail.com>
Subject: Re: [PATCH v10 1/3] dts: allow mbuf fast free to be set with testpmd
 shell
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, luca.vizzarro@arm.com
Content-Type: multipart/alternative; boundary="0000000000004f916c0642263cbf"
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

--0000000000004f916c0642263cbf
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--0000000000004f916c0642263cbf
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Reviewed-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div>

--0000000000004f916c0642263cbf--
