Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEBECCFA04
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 14:45:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BD4B4065B;
	Tue,  4 Nov 2025 15:45:19 +0100 (CET)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 646A240613
 for <dev@dpdk.org>; Tue,  4 Nov 2025 15:45:18 +0100 (CET)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-34077439166so4943564a91.2
 for <dev@dpdk.org>; Tue, 04 Nov 2025 06:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762267517;
 x=1762872317; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bkUMizyYLaom4AUeBd7ByOlCLKZSNAIFSHfT9rtyz7E=;
 b=kMlKGfyVssrK0Ll6eJOW1wgxFYl5YBI/4XqLGvno7h+ufnZMPygCzeBmp5trncnFcN
 BPYBJeInm3+oqXbuJskf9Hv+ImPI5t0iUzJm6wtTYg/WeVB+3RZ7KxzGl8vUE3dTPXcE
 7he8sf+gNnhOFT5H3KjL5SM8rJF0+i4/V9/YFVIRhGBtYvqsasUCIwZUyIsBb/WyYddY
 Vgb3bU6+zfqmLi6FYyL6yFwGuII0W6X/txdH17jqAh3RRRKHnUGt2pzD5VgwtdUoPVN/
 8vjJILFrYU+w9daD2j7uy7LSF+6dQiEaHNwNMs7WlK0rRJbFxi4WIOzxxIiWr8S6EoJk
 Kn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762267517; x=1762872317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bkUMizyYLaom4AUeBd7ByOlCLKZSNAIFSHfT9rtyz7E=;
 b=YTc6dXN5ZPqxWPGcG5ZFmmODuXCVDgzQZe6z8wgMnCjb34oyqj0LACLt3trM+J/1br
 lEC1g6WCaT/cvIRs8zpdv3KCz9u+QGA1pxe4KQfdPRKFUAh63T+dyUvreF1T6r6dXrUf
 ClSW9Lu2DjoMecvLG5/rTKvsVceFjcwh3nYg1KB5ggr5V6U0qKqF/MVV4Bgh0wHUfcQz
 f+UVo8CXJBku5NU3QmTU1VAi6NwVG5jscQfhwLJFeoOqp52at5y9STz1B6fD3ZfhgiK0
 MtCBr8doQd1WK2Qi62YyGnRzJUd3kroUmXpqiXdmfsJTdNcXnK9mkOGsmhT7LYPaZEN5
 KhOw==
X-Gm-Message-State: AOJu0YxPF+Dp2UWWSfxy6lWaU001yTSsIzuFPf60m3B4bueMSlZ3Evbw
 n1gk/2STI9nhP2pWYK0gP3tNYD9JMWSEroaAD+pOynaaHo7qn9UY/M0LHqAyjMYq8UDPvslyHpH
 iB9dr
X-Gm-Gg: ASbGncvCkyJhnOQoAdpseFR3bY73eqiYZItk2uzNvWg0QNHYuSx7Bbn37fNMu/lxFI8
 RdRqhzcySEioZGmN37FL6Lsac/Jp/Xi8Jahsy+yxFIv/Lrxzpw2x1J78Mzynb0VIein7RcKBoBb
 2sO4OYE1NwzmsQhooTCQsSnhlFBki3QTrJFXf+/j5lBC89uNLeOEBHW+FG/aJIa+FXgT4SZ4auh
 i6GiK0qK7vGcM2BJiENnW/zZpFNjizPADrGpQNzCKQ+UmOF3x37OiCCzLSZJEak91QcqJmeGUUN
 s48JSVZ9fUW5wmltKJLIMs7nqP6V8Mfzwvyxi1unyzvwv585ruIYZrq/EEH/FODBkGlPXRZAptJ
 7OJnNpcVGIgF6YvbY/NG+CLPjpaUB40bHMLb3HlCf0ofYRSGBKev8GmAMCNqxXX2j8nfDcRTyG2
 sP8cVVkL8YJwQue12n2t2iKqzxqZ2dTcklNIbB2kmUEqw6
X-Google-Smtp-Source: AGHT+IGsW7nJBGrbAd5BlHGcGkbpz/2CEbs3Nd/rNTElBI4YRzRkRPIN6ncv5t4IV9beZUt3MbmoYA==
X-Received: by 2002:a17:90b:3504:b0:340:776d:f4ca with SMTP id
 98e67ed59e1d1-3408308a99dmr22588787a91.26.1762267517513; 
 Tue, 04 Nov 2025 06:45:17 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7acd392040csm3181902b3a.19.2025.11.04.06.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 06:45:17 -0800 (PST)
Date: Tue, 4 Nov 2025 06:45:15 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: longli@microsoft.com, stable@dpdk.org, Wei Hu <weh@microsoft.com>
Subject: Re: [PATCH] net/netvsc: fix use after free in cache list cleanup
Message-ID: <20251104064515.41972bf0@phoenix>
In-Reply-To: <20251103163703.100238-1-stephen@networkplumber.org>
References: <20251103163703.100238-1-stephen@networkplumber.org>
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

On Mon,  3 Nov 2025 08:37:03 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The variable cache is referred to by LIST_FOREACH macro
> after was freed. Replace by the standard LIST_FOREACH_SAFE
> from BSD (and other drivers).
> 
> Fixes: 9a9d038c782e ("net/netvsc: cache device parameters for hotplug events")
> Cc: longli@microsoft.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Queued to next-net.
Added Long Li's Ack based on earlier version
