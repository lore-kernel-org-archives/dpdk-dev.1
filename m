Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79122C88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 18:41:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F74C40A7A;
	Mon, 14 Sep 2026 20:41:54 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id 7CAA940A77
 for <dev@dpdk.org>; Mon, 14 Sep 2026 20:41:53 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-86309e1a213so1574916b3a.0
 for <dev@dpdk.org>; Mon, 14 Sep 2026 11:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789411312;
 x=1790016112; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c1Qd1btciL78qTSwhC3L5DNFapHAyLYzlgLsgdWU9b8=;
 b=NYaitXMTk5aEBT0H8qHoayuE3KyIycwXaStSOCnjwG+oeGne2qTHYRRUeS818on3W7
 xzK18OaVOyXUaQhd65LegOQTsUfmzQ9eZCIb4Z5HJXSnoYV8KDW6uBrudRbS5HJ3rOq9
 PwTmGkoxp9wPdqpBmqGHiaVAPjpr+lyTAwWnhMdKB1oYDzOpTErcAkhI1uN3FcGJI1ls
 5XsQ7bWkdgTASkFn4cGrKJDyKRKb4H+FK64x03qox7chCyXJtoAvoiL2BVponwkuP0ra
 1KWzVEpaMC11kRaGvZOCEmabfLfgJSpSZo7LdqgvHtHwcr2DHYqu6Bg8MSV/q3SROD+8
 4Xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789411312; x=1790016112;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c1Qd1btciL78qTSwhC3L5DNFapHAyLYzlgLsgdWU9b8=;
 b=DrjbRg5t4Otv8Gi5UCTiE5Bpd6sISHEeMY6Rz5xJOkJJ5MWGXGJ+v5m8qFusdJ2J5a
 ntbcB3ztBFnYroBeXMt+xQ4KQWrm+yWDaAFMiHVql1G4dQO+/nn+9cNj7UI81YOr0wtr
 HqscrUaU4YuSQTdW0ZZWHSO25AmQCMNqi6FCaL60m2x3Cx/gz0QZC8WvmrtnwhakZXqz
 kDeGPIr5mVFIBEWP8pTntrl601xY61M4ksB626L1aFbOprVrhnhs/rRzInHFPqN8tW45
 tHxVRdpYySDL2Zu2f2EeuaghAuoaOZ7q6M12R+Sd+vmKadL79/eS7LgVjCoReFRw55ZE
 UNJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiXRgFwf4ji7QBe2m8k3/CkC8/ROxN5LO5UxPnmDJhV/9h/agxXbyrI4TiVFgm9grmMuY=@dpdk.org
X-Gm-Message-State: AFuF++lKoi7wB3tbTfeX5RQxoz0Jr/e2EJGhYRbnYbKWiwLVxsvtgdTM
 yYvYR+2i1ZnLOhs1buIEDRQaLwoJ0Qjod/5aH1rIWmdgeCuJPa68q6IL34AYNuIkfko=
X-Gm-Gg: AYBFou3zGZ6IHLJKWjojBybhjurUi5o80kbiTy+0NqniG05FYuWPhfb1ww9hDmiTiEE
 aVRvLLuYDa3e5HgXZXtekpmxo48J6GXPoplgcfZLh2Z/2C9QnP9KCaI0cv4k4Qg534+HLiLa82Z
 KFF+w2MR5P0Nan4gK4KIC0YN9f9VUIPIECHUAVkBrzzorMPIYe2rPTj5gATo/ABQOdrGo94kStB
 9gHXF2qBfb4UUP+X6QRVV2AuX/sWslSs2k2bRuSB1QR+rcmsT0Z5Rr9sTo5FMUQsvK26xQSKH5P
 n02ucQitnxsG7z04kWYWLYzGyRbm8ykPObtISXI1QqaHiZ8ytgAyRH+KFoCRmUsdSZXHnu7XL4F
 wGct9cra+Qd86l1h+i0BQk/GOTZB4Teqj5Deiojzpx96gWZpFwYwfGVv33tdXn75LpJgvq0lAe7
 0wCIWDfJB7Ci5bGpXDX8CpXXXOg7o2EdUdgIBUPJrroUIxIdzgesX61Q/CI1jgnacpYpS8hv85Y
 Njh8zbRmpFbtuHyqj0x141pdj0qCYJ5R9txe9KS
X-Received: by 2002:a05:6a00:6088:b0:869:b8f6:7478 with SMTP id
 d2e1a72fcca58-86f862c4f0bmr8056085b3a.24.1789411312245; 
 Mon, 14 Sep 2026 11:41:52 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b28cd668esm5197161b3a.21.2026.09.14.11.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 11:41:52 -0700 (PDT)
Date: Mon, 14 Sep 2026 11:41:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, <dev@dpdk.org>
Subject: Re: [PATCH v2 7/7] app/validate-bpf: add BPF validation application
Message-ID: <20260914114138.0b0b582d@phoenix.local>
In-Reply-To: <20260914145418.37353-8-marat.khalili@huawei.com>
References: <20260911104006.34364-1-marat.khalili@huawei.com>
 <20260914145418.37353-1-marat.khalili@huawei.com>
 <20260914145418.37353-8-marat.khalili@huawei.com>
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

On Mon, 14 Sep 2026 15:54:17 +0100
Marat Khalili <marat.khalili@huawei.com> wrote:

> Add a new DPDK application, dpdk-validate-bpf, for pre-validating eBPF
> programs for compatibility with the lib/bpf execution context.
> 
> The application allows evaluating eBPF programs against the DPDK verifier
> before loading them into a real application. It includes an interactive
> debugging mode to trace state changes per instruction and understand the
> validator's decisions.
> 
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---

I ran review of all outstanding BPF patches together.
This one had this feedback.


Patch 7/7 (app/validate-bpf: add BPF validation application)
 
  app/validate-bpf/parse_decl.c:
 
    +		arg->value.size *= array_length;
 
  array_length comes from take_number() on the --xsym text with no
  upper bound, and the multiply is not checked for overflow, so a
  large length silently wraps to a small size that is then reported
  to the validator as the object size.  Reproduced:
 
    dpdk-validate-bpf --xsym='uint64_t[2305843009213693953] v' \
        --section=.text prog.o
    Validation succeeded.
 
  8 * 2305843009213693953 wraps to 8, so the tool accepts the
  declaration and describes an 8-byte object.  Clamp array_length,
  or check the product, and reject with the usual text error.
 
