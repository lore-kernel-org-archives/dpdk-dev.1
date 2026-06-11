Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225EBCD8C9D
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 18:15:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C5D64339A;
	Thu, 11 Jun 2026 20:15:53 +0200 (CEST)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id 9340D43396
 for <dev@dpdk.org>; Thu, 11 Jun 2026 20:15:51 +0200 (CEST)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1383e116edfso283476c88.0
 for <dev@dpdk.org>; Thu, 11 Jun 2026 11:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781201750;
 x=1781806550; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tcrOrG7zOecEomBGpKMKNTcQrjQLK9KrhdZZIK+AEPU=;
 b=R0BeiFnQQa36LM3AIjob/nGjejDSBwBCvchhAg2RPzELV/KZbjXn4l2lpUdKUlj8gh
 ZgeX6HLncfS4m7X+YXBuM5XBQIF/66vUA14fvWwUeVQ9ZF5QfLqmoBGV3FeGDegx4gX9
 e2NmN4HxY1Uo7l14T03ezUAZxjknY9BkapU55FtQI+RyuTZ0igR+QDMKvx9BHbaMi9Uk
 B0SQGj+kSp5tUjZGch5sjVGZlWfqOJlNKfSvK0cuJrT8chTdIdnTgJDRaLLA+c3P1jnQ
 fGv8fmGPUF3UdU8pJEibRZLbvlqpl5Qt0RBifTnMv4jSpzDa1PWVHH4bAwzhP3sIC3sG
 ap+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781201750; x=1781806550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tcrOrG7zOecEomBGpKMKNTcQrjQLK9KrhdZZIK+AEPU=;
 b=ldnRxNHUzkaSZ2s/QCqOvmqLAlbdwAG3XdaqpxS9Qwh71TnMH1rzAR6esl80MdquKa
 hbwQLxU42hU1c2uo7/R1Rdv+GeTn0rAW0DpaTRYcmLeb/Rjm7CL/99kSyoRjRakiPFUv
 UphHf7dkCyA6b/ySnxI+R1PmgM3EAX14NVwL0kMUrDjt3ntI/Khbwl8giQIJgI9jOuxi
 BzpNuEteYBX0VXEHxYinp59udwThgx9mkZMn8dMzMGpXfpkPLEmlwqrmP0s2kyeLEYww
 El4zUBr2w7LtFqlt2LBbys49E+/Y01vqh56fkBboiYRFqSnbTMZ8+twsLHXHBGwbq2Ut
 setg==
X-Gm-Message-State: AOJu0Yz/VIBeNJgo6bpBFC6MXggA/z4LEA4PlpTkTemgkq3P8IdvdcWQ
 6PSOMNRkmnIu5QUqwJR1QAqFl6wJnGRLOe6J/9lx2WUhwsTF2sNksyr7qOwuL+P46fg=
X-Gm-Gg: Acq92OHwJdlpUqAph/6FXV+CYYCC9O8MX8wzOb2vV8RS+pNmP+mu8WdUnlUhEtNoc74
 +Webekk7tMRzLu9I3nQaE/dxlfaxbvnm0K/wr/ml3SZWqYXXzXDC+yp8sGV2BvQJwANyq1NAWuG
 0j2QM/sju1kRwPFTDxMZudjydt5SEBjETB8J28U7wcaWKKRn5O+LYD9981L/sm+pa5BpIx1ujsq
 0vPtiXVv7cQurpZsrD6pw8DNIDnJq0bp6XoHdtpcFFcZ56S0csRKX2LnOjSRYMJDFsciwSr6gL0
 JRHIPk4pO3rkzKHklZhZWC9Ay4zgtf3qtOEwJgu6c8djRidHSg6aP291r5q2r26pRbwzRZE1+C/
 xy9LiRs3Ytzcmotii/ayjz95W+xmZHZLspvtDIYRRUbq8TERn8hj6lJ81RJMbxvwQvjUkx7Qw/q
 4qSJVePZ6Q+WVFAKUlKwW5tS/TWCaEFbWiUxzBSKQe4pXAYADgRfE+2BMPcOHbhO92yRky4iezH
 qI=
X-Received: by 2002:a05:7300:b918:b0:2ea:ed3e:13b7 with SMTP id
 5a478bee46e88-308046071f2mr3208420eec.7.1781201750268; 
 Thu, 11 Jun 2026 11:15:50 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806c47afbsm4338866eec.10.2026.06.11.11.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 11:15:50 -0700 (PDT)
Date: Thu, 11 Jun 2026 11:15:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: James Raphael Tiovalen <jamestiotio@gmail.com>
Cc: dev@dpdk.org, orika@nvidia.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, stable@dpdk.org
Subject: Re: [PATCH v2 0/2] ethdev: fix out-of-bounds writes in rte_flow_conv()
Message-ID: <20260611111547.0d2aadbe@phoenix.local>
In-Reply-To: <20260610113334.277895-1-jamestiotio@gmail.com>
References: <20260610113334.277895-1-jamestiotio@gmail.com>
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

On Wed, 10 Jun 2026 19:33:32 +0800
James Raphael Tiovalen <jamestiotio@gmail.com> wrote:

> rte_flow_conv() is documented to truncate output to the caller-supplied
> buffer size, but two paths handling variable-length trailing data
> ignored that contract and copied the full payload whenever the
> destination pointer was non-NULL. A caller passing a buffer just large
> enough for the fixed-size header had adjacent memory clobbered:
> 
> - GENEVE_OPT: up to option_len * 4 bytes
> - FLEX: up to 4 GiB, since src->length is a uint32_t and the API places
>   no bounds on it
> 
> Patch 1 aligns the GENEVE_OPT guard with the sibling RAW branch, which
> already gates its copy on the remaining buffer size.
> 
> Patch 2 plumbs the remaining buffer size into the flex-item desc_fn
> callback (which previously took no size argument at all) and gates the
> inner rte_memcpy() on it.
> 
> v2 fixes the merge conflict between patch 1 and the main branch.
> 
> James Raphael Tiovalen (2):
>   ethdev: fix out-of-bounds write in GENEVE option conversion
>   ethdev: fix out-of-bounds write in flex item conversion
> 
>  lib/ethdev/rte_flow.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 

Applied to next-net, and added you to .mailmap
