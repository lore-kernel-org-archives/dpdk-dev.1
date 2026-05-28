Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603F3CD4F54
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 21:00:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C8504021F;
	Thu, 28 May 2026 23:00:07 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id 401BC4003C
 for <dev@dpdk.org>; Thu, 28 May 2026 23:00:06 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-304cf518c9dso2091410eec.1
 for <dev@dpdk.org>; Thu, 28 May 2026 14:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780002005;
 x=1780606805; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j4JKi0rw8PY6DpcU5ykZKzXpeLgGjXoQ2flaaT237WE=;
 b=safN4JaMReU0N++2s4Z56QqKxIkgY2QTiMdxXnv84mKF2eoD4kH56edrn1qsFpfWet
 AEkuPqpBHPWJ80RjxbuaYehxtc6I5jlpcwwj00Ep7hGrz4FI6es8ml0Y3RpcoOhMbicu
 jdcKevPA9sfdWW+j7Y2WoyrvgDUuUDGLH9tx3+NPZISPIQqAWHOkGjb5OjOtKD9mwYFo
 fK6qeGTIyIaGO1us0khLoCPnXK1yNIMcKxq6c7muUCYYYKoRf2mbu/qHbHzNpF/NtNQ4
 J/cySrzxLI1QOCvlJEFAUs5PUwrZyKNDroJn1c/rlex27v4l/eHo2kwis2mNDu00Ff+P
 3Vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780002005; x=1780606805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j4JKi0rw8PY6DpcU5ykZKzXpeLgGjXoQ2flaaT237WE=;
 b=j8J4oEWgfw9Kntb8DLNxsFRj6DnxGOtmjCW3rEfDFa10J2r/clZIgkzJPqt4dOEsl/
 FphaGHCaSIQrqm7k+tUjyzBk2EVXRDwYWjsXx+jiDB7Zf8RKTmm6NdJQk6ow7RqbfAyM
 6oUzl/pe2y3ucMbuRoHMT0TH7HNdpaTNRR5eG77rqiUcuGpWY0GGMoAJnEGCI41I8Yoq
 iAmzFoke+BUFsoZ8iLFrI6maG4z+1ipnLkyxcwdhVIgZnbbIBAQ4cpC0gasKy7AjZi1F
 N++V+rFfnuPlyhmnrXui9OhFToXiElen1jhidfJCxMN5icpEej3Y9FRhQuLM73qMlolE
 3l+g==
X-Gm-Message-State: AOJu0YyCKAuYfxQAWlS4v/JUjLVO53saz5hsgAJD2iIaKzkyHryDhdmt
 lGRj8hiSEv5bYPDkkp8KWhJlE7D2eTOof+0HhsS5u8kbzaEAzkco10ULRdoY5Q1Ela0=
X-Gm-Gg: Acq92OF84Ul99oRkpqG50ZR2Qvg4qXef/ITVimzEcS39qpoQTFjAOYN7C6gfoGdagUG
 bzPspPjnbVuvVMmoZx7EQ8aZIuJ9GyfMS4GKWA20vYdH4h0sVFjVW9GVyDHcdwAPrk9US75LDei
 Sv38R/Y4KK3ZBwqmmbzFJ0vTFSX2QzBHpAbokYzG1HftbWL2t7tsyGXP82rvWBm+qdfSg8+Gbky
 2OkKFvYpRNO9N3wmBtJZq/NsM8hdXOSSMwacNaLz4IAXwpNk6MWtiE9Obn0UyQp3UIvub7eVRb2
 a8K0ImpOtPedWbNTi5Bedzfgglt/1KHHJmlkbJR1Xaa+k9115KqEcLk+YULdrIk2W90v+Ce5YJH
 CD3GfaXn5UofnAsz14JVxTKXS8Rl2ZbdX1ewTSuXdfJQJMdxGl8rs2OT5Dz0FuKbcVO4joaBir0
 B7auxC/FkE7WPV4pDDM1gBnW378VMAOv9wWQvCfeJVd/g8NNs0wL4ghk6XeNwbHAySBqJ5DpruZ
 7o=
X-Received: by 2002:a05:7300:d706:b0:2d0:239a:23c9 with SMTP id
 5a478bee46e88-304eb17d7f0mr68572eec.16.1780002004905; 
 Thu, 28 May 2026 14:00:04 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304e94e4fc6sm307302eec.5.2026.05.28.14.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 14:00:04 -0700 (PDT)
Date: Thu, 28 May 2026 14:00:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org
Subject: Re: [v6 0/2] net/hinic3: Fix the hinic3 driver issue
Message-ID: <20260528140002.06d04d74@phoenix.local>
In-Reply-To: <20260528130122.1213-1-wff_light@vip.163.com>
References: <20260526121820.1093-2-wff_light@vip.163.com>
 <20260528130122.1213-1-wff_light@vip.163.com>
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

On Thu, 28 May 2026 21:01:18 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> v1: The RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO flag is added to support the VXLAN TSO function
> 
> v2: Modify the commit information issue and supplement the commit information
> 
> v3: Revise review comments. First, deterine whether the hardware supports it, then add the flag bit
> 
> v4: Fix the compilation error caused by leading spaces
> 
> v5: Add fix tag
> 
> v6: MOdify SP230 NIC vf device id
> 
> Feifei Wang (2):
>   net/hinic3: Fix VXLAN TSO issue
>   net/hinic3: Modify SP230 VF device id
> 
>  drivers/net/hinic3/base/hinic3_csr.h | 2 +-
>  drivers/net/hinic3/hinic3_ethdev.c   | 8 ++++++--
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 

Applied to next-net.
Needed to add Fixes, and fix the Signed-off-by mail address on second patch.
