Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9A0CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Sun,  5 Oct 2025 16:40:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A042402E2;
	Sun,  5 Oct 2025 18:40:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id DA4A8402C1
 for <dev@dpdk.org>; Sun,  5 Oct 2025 18:40:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759682412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RY5CUWdoSmULy2oX3a/g19clMF5wZHDxL/HuRhtGUVA=;
 b=RIFGQMjLFBgacZmpja+L75nt3iYFW4mrfjhAB4Or6YM1I4MgPA10XfrzbvLg+ErMvu8+5T
 BYbpKC4311wyV76Be5wiQEd1BI8IQUCIHHMJwQ/JNnLpcJZwT6ThxQwQf6yy5yuT5r8Qu7
 RQamgus7Ea9DfXYdySBYtiQSAacbbhk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-97Ipf4cyPjmgLXUbLFYtlw-1; Sun, 05 Oct 2025 12:40:10 -0400
X-MC-Unique: 97Ipf4cyPjmgLXUbLFYtlw-1
X-Mimecast-MFC-AGG-ID: 97Ipf4cyPjmgLXUbLFYtlw_1759682409
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3654fd1a668so15471201fa.2
 for <dev@dpdk.org>; Sun, 05 Oct 2025 09:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759682409; x=1760287209;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RY5CUWdoSmULy2oX3a/g19clMF5wZHDxL/HuRhtGUVA=;
 b=FEm/rIA0rWw2NedVUbqVjdFx1JSiUiwEJx+NlBsR7fYEeP9XhdwPJ4iFu8RPjrcofw
 5wUxaLrlA7dWY+oA4LnumlSoBGrlzq1LQr5LMmmc6xxep5swulBFz+OniZ2eiMkKkAOk
 FawKs3Moytm3UP2WO7UPL9GJ/A7twmvIffw5e+dcCnVjyL73OqclaUid2lAJa1bxZQgU
 Z2IlKNXZXB4qoXeB/wFseUtlRc7mfB4Qc7fdptH6wda4EC5FEE7j3T+0rESRNuaBYbRl
 i+Llx5/GElcq0hdKTCC0/mYQy/+b6L/67XZDL2dK9f2ESFLQYN4CAyIumlxgZ18ub6d3
 FuPg==
X-Gm-Message-State: AOJu0YyqOJYx7CnnDuIAArsz8A7J3eOL6BjBJimfNxCcQ0FJtCL02RAi
 Mp6sU00B9tGzYUdWsPVyoRQbcbeqqvexDaLxnxFTXknsEpLVwLszTKewUZftEFeYJ1U1fZZDVnq
 LQSxaVgzYZPABry/ckL9+as9zdO6RzncBMsCSuLtBFL98hQhco7sMKfM7q8otVmCQMyrM/S9lDH
 8TtEyAnYcIhRlElvIDtiA=
X-Gm-Gg: ASbGnctXtFMLwiodARaJAYGVhNVgTQpnBqM42ynso2W+hJcP0M5bBBScT89b5eynSh4
 YIBiQHiSZTe6+trDYSUA9KxAOsFd+LI2kKay1Uy0jjazaTPMBh05AUxx1MrNeJhfuxP3hIpmXIh
 E41AuhW5qEsrJzGUyoDDkUlO94+ZfC
X-Received: by 2002:a05:651c:1b05:b0:356:839:56a with SMTP id
 38308e7fff4ca-374c37ef44emr28727651fa.25.1759682408682; 
 Sun, 05 Oct 2025 09:40:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB7CgArIv0t23ANHG1wiMpwjlW0WMiEKb0DLbNNg8YVaJg6EQGzY/MEeKkn9w2ovnMcGF88uKl4RMeqyfsXbg=
X-Received: by 2002:a05:651c:1b05:b0:356:839:56a with SMTP id
 38308e7fff4ca-374c37ef44emr28727551fa.25.1759682408174; Sun, 05 Oct 2025
 09:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220530134738.488602-1-zhichaox.zeng@intel.com>
 <20220615060154.6905-1-zhichaox.zeng@intel.com>
 <Yr2V/yvgbWB4l6xW@bricha3-MOBL.ger.corp.intel.com>
In-Reply-To: <Yr2V/yvgbWB4l6xW@bricha3-MOBL.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Sun, 5 Oct 2025 18:39:56 +0200
X-Gm-Features: AS18NWD414UwrfKMdsRaZSZywoJQfGnOe_v5_1ZK6C3EgbYyDQt9v6bBCtGlbf0
Message-ID: <CAJFAV8xS3_JMT1tpR=-MXL3zoLgWFg2kH6COxyoxLf8j8bL5eg@mail.gmail.com>
Subject: Re: [PATCH v4] lib/eal: fix segfaults due to thread exit order
To: Bruce Richardson <bruce.richardson@intel.com>, zhichaox.zeng@intel.com
Cc: dev@dpdk.org, stable@dpdk.org, qiming.yang@intel.com, 
 stephen@networkplumber.org, mb@smartsharesystems.com, 
 Harman Kalra <hkalra@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u7cD361U_VPhl47NEAJxK_szeRkoapI3TLAPowkxbLg_1759682409
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 30 Jun 2022 at 14:24, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Wed, Jun 15, 2022 at 02:01:54PM +0800, zhichaox.zeng@intel.com wrote:
> > From: Zhichao Zeng <zhichaox.zeng@intel.com>
> >
> > The eal-intr-thread is not closed before memory cleanup in the
> > process of exiting. There is a small probability that when the
> > eal-intr-thread is about to use some pointers, the memory were
> > just cleaned, which cause the segment fault error caught by ASan.
> >
> > This patch close the eal-intr-thread before memory cleanup when
> > exiting to avoid segment fault. And add some atomic operations
> > to avoid executing rte_eal_cleanup in the child process spawned
> > by fork() in some test cases, e.g. debug_autotest of dpdk-test.
> >
> > Cc: stable@dpdk.org

I am not sure if the issue this patch tried to fix still exists.
However, the problem around usage of fork() in the debug_autotest unit
test is probably addressed with 2b403dd8fb37 ("test/debug: fix crash
with mlx5 devices").


-- 
David Marchand

