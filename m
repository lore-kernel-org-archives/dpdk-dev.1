Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD36CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 21:52:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FD7F4026D;
	Mon, 10 Nov 2025 22:52:13 +0100 (CET)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 53BC34026A
 for <dev@dpdk.org>; Mon, 10 Nov 2025 22:52:11 +0100 (CET)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-34374226699so1767647a91.0
 for <dev@dpdk.org>; Mon, 10 Nov 2025 13:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762811530;
 x=1763416330; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZawVfkfplKS68kg2uoRdipmorHHxkuDu8cln/08npeo=;
 b=S1P+0M1Q3jYwkSDbOygDhXte6ACCA6YxcNy5Eq0OmJBBFJWkjgXA9AgDvfET5FYur5
 24+DwtuWQtzSbNPzWfUJG+AxezakjGBENbWCN/3bhYIr8Wu8YCpn/T7p7oZ5+6ruyB9z
 YUjh8eIGqTss/Hv+jro6Zljgd/AsgyFBxg7mqM+cGxiarGROlCTK274EtXHZ1RexL2o8
 WKNzyVIcQuofwieH/bH4fvFPI0g4pjgpLcOkbvCne9fvuGlYN6Rbjn8h5h8bUnV/jr+c
 20Tu6J6XIB13YJY3j6KvrBDCVLRZquGWFTbJuxhtMtOg3cZg86xxu9ncwGujuYK6fKXC
 lrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762811530; x=1763416330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZawVfkfplKS68kg2uoRdipmorHHxkuDu8cln/08npeo=;
 b=NAGaVv4RJOGdkKIUMz7eRok+ttibkwnflmrmVFCrh1bVepPtlS/wgohD4oywY4b4kP
 KXeP026u35MtJ7K4Tl9U9fvY3ML3WG3sESF88W4aG+IqrZtpEj82NFmvvWS2nmcdBBOc
 fAqficfESyoGLwyMS9gU4dT5ae5+C1xadVZQo9UYf1zGKWyfppO3+IPf1ZUEcCs5Im40
 900mVBKIm8RCKdx3JBeHAntruDW3YA8b8Yesn7WQkBPQ9rxJMcX7i3e0jnyRk8idsP9R
 l05wmToro9rpACy0o4GQYxrNW0eBUoZZjs3mbVB8WSN2NsCji0Mi/AXe63vBF4LukNeU
 hdEQ==
X-Gm-Message-State: AOJu0YzP0p1lP+3WmFS0GEc3xx4LRCzYAjlH9WELyoj1fiRiXBlQXA2G
 KY/L09XXbzdfxDmBgENzOTzNslFE+Obq0GZD6C0yIjVGx+xM2kfzuXSlfCRE7X4BH7Y=
X-Gm-Gg: ASbGnctQMl0MDhdI+rvpxx3U2l8nb4RSr8U6q2EPPmJlkIe/vGeoQBrefiem1B2DOBn
 pGMeWsMP6NXaf9odti7w/oUyDTRQhRJQDTqd3V549wE99h2ZNKyJ6OalfiPi5vqTes00ABC0ia/
 iuuvyYsdIXsmSrNpBQszPQ2H02oE+4K7VtxuIZeHZQWgCpZMCDGPd3v7v/dssEZmzfGt7JQV6Ci
 rlXryWK+/VdL20ljbJxP1obV8rf5YnBDGu819P1+2Prc2qRWg7e3C7oMMV9XxTg1oAHYHuUBwMr
 cBLFNsUxzVqLNvstTH8Abpk+BuapRtN7FV2j1VGjO3skaFtu8EGQmiSzzR3tP1yNvkNk8z+Nu1g
 UfVCQhycmiGh20tfwdBTdmkkKmvNcGfKI7CqWlBNuYqaNdE1EtjZdipRUMrDhKFL429sN7ezsK0
 RxFth6bIFFEGf9RmK+Dj/dpTEHd4yHOTx2LA==
X-Google-Smtp-Source: AGHT+IGZB54wJfF4PtpLeSCEwf6iVo40Vmlo7PkQy8whUyw2UvsHUCBrN6+UruKJ4u+MWtkQ7O+HhQ==
X-Received: by 2002:a17:90b:564c:b0:32e:3830:65d5 with SMTP id
 98e67ed59e1d1-3436cd0ef06mr12900732a91.36.1762811530234; 
 Mon, 10 Nov 2025 13:52:10 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3434c344838sm12020114a91.15.2025.11.10.13.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 13:52:10 -0800 (PST)
Date: Mon, 10 Nov 2025 13:52:06 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Manish Kurup <manish.kurup@broadcom.com>
Cc: dev@dpdk.org, ajit.khaparde@broadcom.com, Kishore Padmanabha
 <kishore.padmanabha@broadcom.com>, Michael Baucom
 <michael.baucom@broadcom.com>, Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: Re: [PATCH v5 19/57] net/bnxt/tf_ulp: hot upgrade support
Message-ID: <20251110135206.03f1a0be@phoenix>
In-Reply-To: <20251029160712.58519-20-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
 <20251029160712.58519-20-manish.kurup@broadcom.com>
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

On Wed, 29 Oct 2025 12:06:34 -0400
Manish Kurup <manish.kurup@broadcom.com> wrote:

> From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
> 
> Add support for hot upgrade for a generic application.  An
> application can start a backup application and add the same flows
> that has been offloaded in primary application and secondary
> application can take over primary application.
> 
> Update the hwrm version to the correct version number, the
> corresponding code version for hot upgrade api got changed.
> 
> Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
> Reviewed-by: Michael Baucom <michael.baucom@broadcom.com>
> Reviewed-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
> ---

After merge to main the build fails because of this patch

$ meson setup build
...
Has header "bpf/bpf.h" : YES
Checking for function "xsk_socket__create_shared" with dependencies libxdp, libbpf: YES
Checking for function "bpf_object__next_program" with dependency libbpf: YES
Checking for function "bpf_xdp_attach" with dependency libbpf: YES
Checking for function "xsk_socket__update_xskmap" with dependencies libxdp, libbpf: YES
Message: drivers/net/af_xdp: Defining dependency "net_af_xdp"
Message: drivers/net/ark: Defining dependency "net_ark"
Message: drivers/net/atlantic: Defining dependency "net_atlantic"
Message: drivers/net/avp: Defining dependency "net_avp"
Message: drivers/net/axgbe: Defining dependency "net_axgbe"
Run-time dependency zlib found: YES 1.3.1
Message: drivers/net/bnx2x: Defining dependency "net_bnx2x"
Compiler for C supports arguments -DSUPPORT_CFA_HW_P70=1: YES
drivers/net/bnxt/tf_ulp/meson.build:41:3: ERROR: Option bnxt_tf_template does not exist.
A full log can be found at /home/shemminger/DPDK/main/build/meson-logs/meson-log.txt
