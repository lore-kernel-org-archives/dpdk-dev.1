Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B2CEDA693
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 16:13:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C98D40E8A;
	Tue,  3 Mar 2026 17:13:52 +0100 (CET)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id 33507402AA
 for <dev@dpdk.org>; Tue,  3 Mar 2026 17:13:50 +0100 (CET)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-12776bebe9fso2359770c88.1
 for <dev@dpdk.org>; Tue, 03 Mar 2026 08:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772554429;
 x=1773159229; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kSxXd3cEOt9gIzWXcRm9Rvz7hf7//BPDYLeuuY47XK0=;
 b=MxRvzDPeQ6N76foJNmHTe6Suahm+u07lmI4ctKNG+Elh6KZuvmyeXAMiv50ShmJkKI
 Z/z/WVu0DY25XDe+aeeAykuia8eKjsphjmMMQQNUSXi+kztUbfv7brEWzcWbH1z/ts9i
 27vZbLwsgR4OMMpIZSgX+SfoJqL/1HVBhy7t4K1/qPLwEsWlN00hSjWNXOs7TaEXhG2u
 g+x84g23CVGDaNedOKheLfaV5Wkl7lol8hAhgQcvjb6UezGMoNjQayS9ovDwFLj7dnfl
 yXM/Qk1x7syGFNY4Uadz/sC/jJs/Ms022/KGqwAb9XoxEd8KKPM3TahdkSx1nxohB2wU
 pLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772554429; x=1773159229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kSxXd3cEOt9gIzWXcRm9Rvz7hf7//BPDYLeuuY47XK0=;
 b=egMuegArl6KQpQgoPBauXKbiHIw200m4lmjdwkd1jcwzybcuSaPYNTcQQ12aUX1s/2
 0/kaw9UqU/6cSm9bz7sT/FtwXzWARyz7U/+ANQwvPKCB5b4mDCYLx1D+4gWqMPbo91i6
 nxt8L2sKJ0hgKRZtxEx5cbizdtUEgg5RXWCbNCiBEOtCEysLxqp8Xhcq5FhnC2NNtGPr
 Uw+kj/c10vkEyWHGfviq7TwtoZANc3mUsrAV/8FwGb9e0Ir4Oqs68fr3fdYLOMqBcdSj
 DZbii5WBqQj0ESPz4ilXAQgSx4PnXqRypRhJBCRvYsLcUl0lGiEIuNuqFZLmFp8KkiTi
 I5xg==
X-Gm-Message-State: AOJu0YyNsrrviXkHQ0Z6hlsoks7uB5KAXHoPepIMHA8r7G2Ykdq4jFQh
 kyylPLLtChRrdPi+fDtFMcVjhVLIYLXvVNHBVVM16/eGNLSamSwTX+VPHiPsARThs8w=
X-Gm-Gg: ATEYQzxEPObQUT5J12scOcuR7EEOQ0z8/NO4mv3fDw1SRk626JDiVtrn1vmvD0PpIJa
 XRzm38ViM2unl0Zc0tpZDXAQCnP1VR2ChrHVePHgnvmUftLjTyvC1JIB+fBSxnPPJxoZiAhF4yx
 +ZkAOqZFqZ5j2UALotSUX9ANojypIXsZzVDtQOfPxXFnkDIkd5lqIyTC+YZpv6PxXIoXezrGQzX
 OBAetRvCfVSyiW01EZx7gE8BIUiaSffnr1oiWe2U2yfSKvr5LfV/vqCDgE7It1SxOtHigPvG3px
 JrTtTOiJuQuLPzL7M2RRQs7ImszmgvtswvGgtGN+essWHDc+QhCwjwYYueSFuS/H6p2S21yiIMc
 Zz1L5mKGfgpptByLKoncZGFIaXalXnc8gOnq1Juqi/h37O1Amam9Pr1mfPbe99YHG0fyGgdfqbs
 FSKAPqaVCJR7acDWuUIt6cDdFZiwO+sRjfHGXrUcCjfSsgRWed5POmMzljU7UgySqE
X-Received: by 2002:a05:7301:129a:b0:2bd:b961:7e8b with SMTP id
 5a478bee46e88-2bde1cbde50mr7223039eec.24.1772554428845; 
 Tue, 03 Mar 2026 08:13:48 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be12805b93sm6118155eec.15.2026.03.03.08.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 08:13:48 -0800 (PST)
Date: Tue, 3 Mar 2026 08:13:46 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: <dev@dpdk.org>, <jgrajcia@cisco.com>, <ferruh.yigit@amd.com>,
 <stable@dpdk.org>, <mattias.ronnblom@ericsson.com>,
 <heng.wang@ericsson.com>, <ravi.kumar.chennaparapu@ericsson.com>
Subject: Re: [PATCH] net/memif: fix descriptor flags corruption in
 multi-segment TX
Message-ID: <20260303081346.1e6ceb05@phoenix.local>
In-Reply-To: <20260303110152.276344-1-sriram.yagnaraman@ericsson.com>
References: <20260303110152.276344-1-sriram.yagnaraman@ericsson.com>
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

On Tue, 3 Mar 2026 12:01:52 +0100
Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> wrote:

> The memif TX path was using |= to set descriptor flags, which could
> leave stale flag bits from previous ring iterations. This caused
> descriptor corruption when the ring wrapped around, leading to
> malformed packet chains and RX failures.
> 
> Initialize d0->flags to 0 before setting MEMIF_DESC_FLAG_NEXT to
> ensure clean descriptor state on each transmission.
> 
> Fixes: 43b815d88188 ("net/memif: support zero-copy slave")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
> ---

Applied to next-net
