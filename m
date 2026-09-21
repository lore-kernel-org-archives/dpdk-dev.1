Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FFAC982ED
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 15:42:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71E3B427BE;
	Mon, 21 Sep 2026 17:42:17 +0200 (CEST)
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41]) by mails.dpdk.org (Postfix) with ESMTP id 48949402B0
 for <dev@dpdk.org>; Mon, 21 Sep 2026 17:42:16 +0200 (CEST)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85469e2254dso465505b3a.1
 for <dev@dpdk.org>; Mon, 21 Sep 2026 08:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790005335;
 x=1790610135; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VbpeDc5IN8qZlCd+h41ryCCtJywrDoVKTEBGpGJbbm0=;
 b=WigQS21tnIQ6klcPq61Bn+6GS2e+kDHk3lI8RkCCnLTG+3emQ6qQqCpKu2MByAX6cu
 6LmHGKj4ltPYCYl7+WpiKY/3a0PW1FeuPVzldVOBpAtF6efBjHU2heEw7wnOI+xmlDs4
 4TiPETABgwtr4QqNwCCkNVx3s5F8wwtMRFjfT2hmbyKQfnl+zA83hKuslM53pPZqQbpF
 DUU8EQ2MYko1/W+BPXuwLNOQa5we5Qsg6fvwxygtCeN3cje+pxqRUtAh5DMn30O0rlRm
 hnmx8nBnuC6OCGC4rn4Wy+1Bs5PrqxZphyKBoy35foDHDmFqxUXbNCxAX6TObKlyfR+w
 7jDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790005335; x=1790610135;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VbpeDc5IN8qZlCd+h41ryCCtJywrDoVKTEBGpGJbbm0=;
 b=PTW1sI50s4CfMn1XYWdrwcA9Pq5H12t7H9ID+DO2pR8XJUBsykKHlF1VilI7LJzGdo
 sXUyOrKRTahQc/nmWOJCXqkuxQA6ndVfROIwFUvAMoRwh4NLb9t0hWJT/a4FaK9CLNJh
 cOo1o5Xqi0Dt4Y98JlpFAw3fOlvgzS6hhQnhBwQ+ozeWgIzF/iQhCZ2GowThUGBpnSh7
 IJ2IYZApmlXsOVOlJuVajW19Q+4PeE25IKUq27SWo/Hlyc6Nh9w5NxClAseugWEG4qgQ
 GvhRd+tcDIt8oEbVt/PHCl5VQbc2GJdVYwziPjUmf9b7AOd0+4jxKWtp1nm6mksq2osf
 Nthg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJzW+SDaY8ftBk4SyQwKSKAQ25JpJWgeFT8M4gr+z0NQ+BpnD46QMQUY57iOhNOOEmZd8=@dpdk.org
X-Gm-Message-State: AFuF++l2ZLc0fyycpU5JhGnjmUkCerj5tVDYiyHZpgtq3HvjIE+t85f9
 6FHi1VA6uSEz23RjGnSW5NBsjXs+lYb44s4z6efbmXmWC29UUkdQlmu9nfwCMp7KRsI=
X-Gm-Gg: AYBFou0rH2nJUSqSGVasOvg8D+tWDegsq09yonOw9nyNRiC/+9TXYvf3tP1T9wq3BPf
 KHWuppU//6V5o39FEsrKyySvR0O2oy1UTfO7H2yup991FYKVNlxDpfYqlwoa445fe0WDg8WirwO
 fJFO1rncPj59nxs3+2fhGTaahvsnnO/ri8que+Vee7/wkxE1+BlWYxYD2eedYxlNd570ngvyacp
 OcOQDGKhu+X8FKx1tA5NXepNeR4xs34558BYLf9/KKzgw/xriTq0SFEHFGlDXpHI3wo+DRPkYPn
 FW56cwCrusCMu27CUGrDZiAvoJVgrCjL/8ELdlUKrP5Pw89QIq1fyd0UGB7Oad5bL/yrqHnQYG5
 7gJYfSZiUpoCBa7aQCm7be4SSiw/hzYXHJ1ckWf5erWhOMeNlGJTNYQHRMKCQB98mUeiEy9CBqH
 ZXQgyqOJf9xHn45TQPXI9yN/EafHs1WGwdqBiJyzA8sD6vQxxDyvGtss/Ocwsfb/F86sR3NpWeq
 yG/jQI2Ro46GaJdylwDhlCnLrydAl+x5+EfSJ/7
X-Received: by 2002:a05:6a00:4196:b0:857:72f8:dca7 with SMTP id
 d2e1a72fcca58-87bc026712amr14602b3a.13.1790005335168; 
 Mon, 21 Sep 2026 08:42:15 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-877a6ae6f56sm3523480b3a.6.2026.09.21.08.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 08:42:14 -0700 (PDT)
Date: Mon, 21 Sep 2026 08:42:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Md Rayhanul Islam <r97yhan@gmail.com>, <dev@dpdk.org>, Chuanyu Xue
 <chuanyu.xue@uconn.edu>, Song Han <song.han@uconn.edu>, Md Rayhanul Islam
 <md_rayhanul.islam@uconn.edu>
Subject: Re: [PATCH 0/2] make PCIe DMA work on Broadcom BCM2711
Message-ID: <20260921084211.4f78c451@phoenix.local>
In-Reply-To: <arDxMec8YX7KDdAX@bricha3-mobl1.ger.corp.intel.com>
References: <20260918225045.177125-1-r97yhan@gmail.com>
 <20260919140549.1f5f3c0b@phoenix.local>
 <arDxMec8YX7KDdAX@bricha3-mobl1.ger.corp.intel.com>
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

On Mon, 21 Sep 2026 09:56:17 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> > 
> > Short observations:
> >   1. Too much AI generated slop, extra docs, comments on everything.
> >      New code should look like the surrounding code.
> >      This looks like AI wasn't quite sure and left lots of docs for future self.  
> 
> I really don't view this as a bad thing. A little too much detail in the
> comments is better for the future than too little. Given these patches
> touch areas outside the usual behaviour we expect from DPDK platforms,
> having extra comments is definitely useful.
> 
> 
> /Bruce

There is a fine line between a couple of sentences and three paragraphs
