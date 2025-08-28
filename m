Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72414CA0EED
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 04:40:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF6764066E;
	Thu, 28 Aug 2025 06:40:52 +0200 (CEST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id A6E6E4027D
 for <dev@dpdk.org>; Thu, 28 Aug 2025 06:40:51 +0200 (CEST)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-3c68ac7e18aso319510f8f.2
 for <dev@dpdk.org>; Wed, 27 Aug 2025 21:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756356051;
 x=1756960851; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rHKIEIpnlMwyPEBpUaORtKs3OGP4tzr50/S2qlcdSAA=;
 b=OatQ6+58R/SXgWKvwYobLZru/IxK4jAJ+2tVrK7q/1lOjFH4KwwzSu6QMlOqpMS9+Y
 LWThmyYcTkopDk2GIKch8CRvsRTRthu7P0IftB8IBMaVVb+d17hRbhwyj4rEDv1vS45b
 25oHUEjOPbV4wHA1ehWndnM3lI+0I6isKDU37GlszojIfknPGq4dcsw82zNlZMCq/qBH
 tOHIxQvUKNrCM7F305jRReGc2szmNKOKYSCdQVbMVy7hJUsGeZM1aC2u8UQlrRSX9DX4
 RZ0asdLrIFfLZ/4YXuhfczZsa2kRD43GrmLpaHH/3odDoEeWSrXznMhEcMjH2esc3oSU
 qdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756356051; x=1756960851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rHKIEIpnlMwyPEBpUaORtKs3OGP4tzr50/S2qlcdSAA=;
 b=QK5a7vYFWkc6scKTIR1eLry1xPUo8kmWlKh82qk+XJ3Fcb2G8WjnNb0gq9eJt18uSS
 txMlAXBxAS2UCE6Tmd0OUIy3P9nBK2A2QO5r1CifYUShUaGJEYknY13ltfaGFqWoEtcK
 bVw2VjMxEVHBXMi402Pi2cCpj5MaaopCCS8BHujYL38Q5nne/WjoVYStlN4AAxh1B3BV
 STD6ZeF+yRPFB8I/d7TJ5rVCFrQklvcPZJjg/D1VXgBPzv6firrzc91dKGj51siQwi/O
 SUWjXIcLf7nsZmlR/iACaD5hU3mybxEVlVNLeaE8vraNmuislBt9HVZgh4Iw0cb7l/6t
 6aXw==
X-Gm-Message-State: AOJu0YwmAW9SExdeheq6kVtMrjL+tTLv++F0aC4fFG0rS/cpbFG4PaSB
 rtvSU8rnjnhlPEnm7ZSKgNVP2bES5dEB73yLee64N7rmCCjhwJjgJoDyw+WYGTqYlYI=
X-Gm-Gg: ASbGncuRyD405wyNvdeDO64hQF3mghkiDTwdeEEHFrooONpQ1IXDD3f38rwfycGHUXg
 BU2wXu9tqyN1ZwVM75hnh/J2ePzPAQxveo4rxfH0rYKPC/1b+ZHapRkqlxCI6YColpvobgqFBE7
 1xQf99jsnEQXzHKIVHZ/hwUIqOqSkDKxeEF87YnQdz39zZKGGnhEQawa85DruK2gp4s+4UlDgwu
 45laRLsBnMCJzubvoE1QmqP3yaL4GBzJQrmCSKKd5K+Mx30N4po55uY9WZ6NirqCrguBtws0Lx+
 bcJl9V48ncku43fLbBynawYi4Y2dG72dHiwWc0aBxSU8WEa/nBRCQ0/Vao1SXWYbLKyokFyAx7J
 nNEkMcZc04nnk3sEsAbO/sEstHaZ6SheWDD3QQQ4+yGeP5PNhNOU/lCf1uYznhg9kUHLWdRoRqf
 bkV3do2K3GvQ==
X-Google-Smtp-Source: AGHT+IEGm1E19K5lmExM3QbP+fG2FwAmLAUmIQ4KDpG0ryKVR5TbzncT2H8G0gj08zpC5Rs4rEH5Kw==
X-Received: by 2002:a05:6000:2dc1:b0:3ca:4b59:2715 with SMTP id
 ffacd0b85a97d-3ca4b592d9amr10422338f8f.20.1756356050970; 
 Wed, 27 Aug 2025 21:40:50 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711212566sm22185661f8f.41.2025.08.27.21.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 21:40:50 -0700 (PDT)
Date: Wed, 27 Aug 2025 21:40:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rongwei Liu <rongweil@nvidia.com>
Cc: <dev@dpdk.org>, <matan@nvidia.com>, <viacheslavo@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <thomas@monjalon.net>,
 <stable@dpdk.org>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>
Subject: Re: [PATCH v1] net/mlx5: fix probe optimization race condition
Message-ID: <20250827214044.16f9baaa@hermes.local>
In-Reply-To: <20250828032134.167999-1-rongweil@nvidia.com>
References: <20250828032134.167999-1-rongweil@nvidia.com>
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

On Thu, 28 Aug 2025 06:21:34 +0300
Rongwei Liu <rongweil@nvidia.com> wrote:

> With dedicated RDMA link monitor, there are two threads
> which can update the IB device port information.
> 
> Add a new flag to avoid the race condition. Update should
> go through RDMA link monitor once ready.
> 
> Fixes: 51fb5c40c826 ("net/mlx5: optimize device probing")
> Cc: rongweil@nvidia.com
> Cc: stable@dpdk.org
> Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
> Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
> ---

If variable is modified (with out locking) on two threads it
needs to atomic or volatile.
