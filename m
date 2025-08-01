Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A1EC87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 Aug 2025 22:37:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F86B40298;
	Sat,  2 Aug 2025 00:37:56 +0200 (CEST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id B591A4028F
 for <dev@dpdk.org>; Sat,  2 Aug 2025 00:37:54 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-45619d70c72so27722495e9.0
 for <dev@dpdk.org>; Fri, 01 Aug 2025 15:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754087874;
 x=1754692674; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1IlPS4Hxa/FKc1ogjS4G+IaSE2j67FjDKV3UPhuI7+g=;
 b=Nkgk7XrIjJM+FV+J1iMa9+i0Vs0/rulhVToi8N1vPK8lWkEKmWiyfHZdSnzNAEqsTu
 bxpBGhP+aiEDwNmszhRPxy+rXwtOx7RY5t6rTZ+lapHcjSFV8A8ftjmyI+cV4hLXO9sL
 2bYhbj/yU6ePbRnkQVvmUoHgcgM2HRw5nBy7NpFN6THk0sHQ94v3GW06MFh7Xgk1Bt24
 mvoGJqR2M7zdeEA9HxJsZBPdjp2k6370njcNeyzgLCgw/ZfFF57ZiGe9xNL1Guhd5jvS
 NXzY5qXMt2XvyQznJg9dXEeLJN1i189m5zCzdDZmolYvJ7HJKfEjZoboMbbTApqXdPqm
 VfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754087874; x=1754692674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1IlPS4Hxa/FKc1ogjS4G+IaSE2j67FjDKV3UPhuI7+g=;
 b=ejiITxLEDnYPdac0eSA4QFNwHFuFG9XWSpbN9V6Mx4azTwfp+OptVyo9uGqsi8NYMu
 cJ7zYF2HIAL5CJWO5iqMQA14U+wD0sQQqaMmhI/WehWl14cbk6hDN5oLj12qY/krTCAj
 xAnKdArCr+tIyXmPKdRQw7pE2bX1nqWslsr6Y0jsUx9YD84lyi6BEcj1ywAlOsFHcMBc
 nDqWM2gRXi38hBXrKS1sRYJQMgJtQLmsaRPxqqayVZoJwPxMrqXiC7JwoMCscIh/b0yg
 z2y84JvItgMcqOq3z/3tNEMITSAk6tBYGwM/Cy2/1D2m1unfLwGEIwxzV148nXRphkkC
 sA4A==
X-Gm-Message-State: AOJu0YycaFqb3fnGa+JKbzhRhgcnD0vI12n4Nk53VZDbTOg9HB0gyhp3
 iYV2C8NNrTahqFl46yZNpidy1lXW25sdDFk2hwPZuBgksP1yXBr+JDpl/NOcWvVp7rU=
X-Gm-Gg: ASbGncvLsWRXseB7iu2NhubBdWlLZ/p+Ywd5rCc6EoglD39PAcUogRe74eDjPjVsW+F
 LxTI1Iki8Tz6xN4720eK7qWuZTwDCdZL6UZ0TKoZpD0dAZdB65jI4K3KUAD+0tcMl/wDYRd1Iw3
 0Xng2X+m9jsOzqxPvYQFrmgeA1ZUGEH2gOEwu96qwvHchuQAamz7CePo322PYai+l5j5pGRqaqA
 97sZJd/yLsKa7W332WrOyDqxlfPKSrp/f3vpTJCQ9SUj5H10Kujy5BpyQJ6JHR+34UTwGGzlc8K
 heyAVbdk5QX2YCDctESNA5iCA6z2wmvxAK4llDu8/pU5tN7j5SCwaKJ1uRFtYkDMEiDvEWAeUl8
 Rz+NaU1iPgVPMt7wQHdYIoZCqxL3RAPE7W3sYnaaRn/Al5vTBxWNhBoOgOEcIcRLDwx6VYL76UD
 4=
X-Google-Smtp-Source: AGHT+IFPyvXRQSJgUcR+J6A0wS1+iJkcX/dsCMezpy+/T8zL4deoooA0HSywjcMrDZhlc+ZFpw+mTA==
X-Received: by 2002:a05:6000:188c:b0:3a5:8977:e0fd with SMTP id
 ffacd0b85a97d-3b79d1f809bmr6279950f8f.0.1754087874084; 
 Fri, 01 Aug 2025 15:37:54 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c485444sm7328297f8f.66.2025.08.01.15.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 15:37:53 -0700 (PDT)
Date: Fri, 1 Aug 2025 15:37:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shivaji Kant <shivajikant@google.com>
Cc: dev@dpdk.org, Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan
 <mtahhan@redhat.com>
Subject: Re: [PATCH v5] net/af_xdp: enable AF_XDP program attachment mode
Message-ID: <20250801153748.6743d48b@hermes.local>
In-Reply-To: <20250730114122.1200641-1-shivajikant@google.com>
References: <20250729161747.894377-1-shivajikant@google.com>
 <20250730114122.1200641-1-shivajikant@google.com>
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

On Wed, 30 Jul 2025 11:41:21 +0000
Shivaji Kant <shivajikant@google.com> wrote:

> Currently, the AF_XDP PMD attaches its XDP program using a fixed
> set of flags, defaulting to `XDP_FLAGS_UPDATE_IF_NOEXIST`. This lacks
> flexibility for users who might need to explicitly control the XDP
> mode based on their specific hardware capabilities or performance
> requirements.
> 
> This patch introduces a new vdev argument, `mode`, for the `net_af_xdp`
> PMD. This argument allows users to explicitly specify the desired
> XDP program attachment mode:
> `drv` (XDP_FLAGS_DRV_MODE),
> `skb` (XDP_FLAGS_SKB_MODE),
> `hw` (XDP_FLAGS_HW_MODE).
> (If needed more can be added)
> 
> This change provides greater control and flexibility for users to
> fine-tune AF_XDP behavior, enabling them to leverage native driver
> or hardware offload capabilities when available, or fall back to
> generic SKB mode for broader compatibility.
> 
> Signed-off-by: Shivaji Kant <shivajikant@google.com>


Queued to next-net for 25.11. Thanks
