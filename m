Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07164C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 14:16:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3750940654;
	Tue, 30 Jun 2026 16:16:03 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id E5E2840648
 for <dev@dpdk.org>; Tue, 30 Jun 2026 16:16:01 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-30bf8b2bd20so8871869eec.0
 for <dev@dpdk.org>; Tue, 30 Jun 2026 07:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782828961;
 x=1783433761; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BBFyftXTb7WIdrGYULvZPf9X+mexElz4YKRv7a9pryM=;
 b=yr0+x1j+DrVvkJQoIMHLiPN6EKfVWTVSXFTTeTqJJebaU5lecbcBSEMT7RToQQBv4x
 f9oGAL5vsHNk5mcEtiIAv/eOHlWcuynnQuW3GqPOB6xDwZgM4pxHTE+foVxcnuDIxYif
 DMZhkGKxNueG6yHEe9BzdqWh+9KyxMc1hSgkuorA3K0DAeu51gfHmgwTX7kpb3LdHf82
 HdmAPj3Oq65Sx00fnxV1UXg5HbJdxOrlhg4nynFi4ICU5Rzy5XEPqdatT+BZZAu/+9PA
 yxiFLS+V9KGQPLY5l09ZdqC8QptthJBB0wu63ZIRGyst96Jz0WU71L7fgjC0hDS21NMk
 dxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782828961; x=1783433761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BBFyftXTb7WIdrGYULvZPf9X+mexElz4YKRv7a9pryM=;
 b=ESHfWkVaSsLO5xeMg9/P+h4LTHY5OJbWFzy1HctdpbTJbxKexaFb1m2bPkklGNDCcy
 VJ/ooU8qmXDq4EYKzVugAChHj8f2bVVkNC7JmfNBOveLIUm+H8kJM9aKRy0zVb/VuBcd
 VcRdECC8W38KjIJALrfSNEtTZuhNewBnMvuw2DzL4ZeBUHe1KpMFNhdIaocN+rV4G01a
 V5fim7e4FNLzMsqPgVAxwBehx4lBCat94e/7/N5epTZunKrt+gDLtfWdS+PbN8ePg/RX
 UNF6S3rvBEjrxOhnERZsXwILYhbWaVsxKUG1JqXKa9w7GoEVL+7lbyBc4CYDbjOtGyKK
 EYDA==
X-Gm-Message-State: AOJu0YwOk+kIPrQjB8O3jYqcVVk2vb2mdU2LWxbH0ZNaP/jSNh/oIfCZ
 KJxnwLJgZK7TR90IdCRVz5T07k143lmLvkvBfd2XpuUX+lmv+xqEMeld2lWWYUJp9Y68DyBHA7L
 onOWK
X-Gm-Gg: AfdE7cmMKca0+mZ0RtpgY3qtZL2EQAR29r3gvw9YE21Iy7NvpBytdx0gBEExoQ1drr6
 Vp1MrFd/fqEIwrCQuEd8JD2375HOZDLgR9ztOxRJtqfqd2Qoez1RIv83kSNImv+Fy3X8OiTlD4k
 Ciz17dzbhbSwsnbM+Lk/dHD1g9u8+NBaZmSYf1+wOKFK9dWfawwDVfFXd8yc3srbynB0Ep2vBMu
 R/lx5PINtDBqpDwC80ifNyWny99LYRrhFeT2TnBtpciEds6JvrHUwt7hXk0xbrmb/u1SY5C2eib
 +RTheD7bk2IFUYHKjKfYW1YhXxcUjU8no9P1gX5lyTk5gBtAGdcFFvU2oeOdU+RxHb6fjt8Vd3a
 MtbttaqtzzZkQ3WqEeEzCbFiOF+eh4a0Hyr8WB3RgT/1SA2uaQMjyYFQMCCNdsHanTpxl1EEHIs
 TuGfdlvgUy6941a5bX1WLtMhfGRUVEnQLOKBejyx9vt3T5fohB7T5rQQ==
X-Received: by 2002:a05:7300:72cd:b0:30b:f5c1:4484 with SMTP id
 5a478bee46e88-30ee13a2040mr2931856eec.35.1782828960546; 
 Tue, 30 Jun 2026 07:16:00 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ef03a6f9asm1920345eec.19.2026.06.30.07.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 07:16:00 -0700 (PDT)
Date: Tue, 30 Jun 2026 07:15:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 0/4] Wangxun fixes and new features
Message-ID: <20260630071555.0b0287b6@phoenix.local>
In-Reply-To: <20260630111608.22196-1-zaiyuwang@trustnetic.com>
References: <20260617105959.10764-1-zaiyuwang@trustnetic.om>
 <20260630111608.22196-1-zaiyuwang@trustnetic.com>
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

On Tue, 30 Jun 2026 19:16:00 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> This patchset introduces three new features and critical fixes for our
> recent release cycle.
> 
> Patches 1-2 add support for UDP Segmentation Offload (USO) to improve
> large-packet transmission performance for UDP workloads.
> 
> Patch 3 enables VFs to sense PF ifconfig down/up events, allowing
> better fault tolerance and fast recovery in virtualized environments.
> 
> Patch 4 adds the missing VF support for the Amber-Lite 40G NICs, which
> was previously omitted in the initial integration.

Applied to net-next. Had to resolve a code merge conflict from earlier
changes in net-next and also release note conflicts.
