Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3141D4899D
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 13:23:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96B4F42E00;
	Fri, 16 Jan 2026 14:23:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D9EB742E00
 for <dev@dpdk.org>; Fri, 16 Jan 2026 14:23:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768569793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wgECKgfDv16SltZ+zPlzRJ5BUSRT3akzzYT5W0RCNoM=;
 b=JO0AcIIYIidiY/f2kHBo0e0sr19WvTlcIdHyuSTlaNYipNEkGLdLvutwf0oCgLk802LBXb
 uEymeowz6GF5pdKD0L54cjfIkGWt578p1MJPR0YWdonGXnh6J4rppdpWDty8GdRI2yxGG0
 +4O1F2jRWE39JLIu1o6p9icvBAREzNg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-VGoWRh0OMTW3ZdeU6rVYKg-1; Fri, 16 Jan 2026 08:23:11 -0500
X-MC-Unique: VGoWRh0OMTW3ZdeU6rVYKg-1
X-Mimecast-MFC-AGG-ID: VGoWRh0OMTW3ZdeU6rVYKg_1768569790
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-38301605df8so14035451fa.2
 for <dev@dpdk.org>; Fri, 16 Jan 2026 05:23:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768569790; x=1769174590;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wgECKgfDv16SltZ+zPlzRJ5BUSRT3akzzYT5W0RCNoM=;
 b=Gq45PxaL0Xwjd3aui00Ne6/6V1r0WbsBxV5wQ3IXA0QjWbDEZ/93oyXvrDmAZjEC1R
 sn2a5iOXch6HizMjjA1PVPc8Lt98UJ86GtSeHIGd4YblwA41CWmmq1kDkTwTSBAMVj2F
 l9CJNfSeCJUiKjJmc7fi7u7gkeDfwIZlBmubI/h6IXZDxdEtQEiRMPxVAcbSE7W+PgNS
 v4GZcYBqUvshpyGhIeoXkB4ZmI74UsD3xq+h76mwM8M//vcn0QHcWCZmfXGYyTbMTxn/
 TpwvO/BJ3Qov/l4zVdisoQEXtn0Kg62oybR1pZPeNzkfFsVn3tkbtgQ+YWH4edb5fING
 PM9g==
X-Gm-Message-State: AOJu0YyLXDi3bOnxr/1VKqe8zh16hGXg3bH9MuF75/t7K/r8pmhHJjBe
 rV8RnAjk7W5fF/JmIPXoLNcrhmL64dE1wEjElYOppSBs2gc3Jws/4TIxYz4HTd2V5GwWNuAA2a/
 ARB8ySALWNj3jOP0cBo0p2ho2esExz6mzjIslNIoBJJHlW4vFjM32v6KSIkUIomwgWz1sM2OlPd
 fQuMEfE5k4JY5FSqn1p5Q=
X-Gm-Gg: AY/fxX6337XgydRNBrIQawl7KyeytpwGeE3SS3FI2iST/NrrwCSQ4X4eGuTYf8pvy5L
 VzreUr5WM/8P8dqsJ4DzzrpahqRyJOoZoF42bvHxrjl5gp5WHBkAbjzs47raWRaKHlzmS0306eZ
 hUdXkvfO6mwP4KS0jXEaCsxaGIO/RwxE8RXcW36Kb6oRTpZQn9uoR321GWfve0q+AayPfj
X-Received: by 2002:a05:6512:1105:b0:59b:6f90:4a2 with SMTP id
 2adb3069b0e04-59bafdb6c43mr843235e87.16.1768569790348; 
 Fri, 16 Jan 2026 05:23:10 -0800 (PST)
X-Received: by 2002:a05:6512:1105:b0:59b:6f90:4a2 with SMTP id
 2adb3069b0e04-59bafdb6c43mr843226e87.16.1768569789910; Fri, 16 Jan 2026
 05:23:09 -0800 (PST)
MIME-Version: 1.0
References: <20251201181024.1583767-1-bruce.richardson@intel.com>
In-Reply-To: <20251201181024.1583767-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 16 Jan 2026 14:22:58 +0100
X-Gm-Features: AZwV_QjRvmM8i_wObn4PATB_50zxyXk9skgGqjrC7pX91TibLUF-Sqola9KfCMc
Message-ID: <CAJFAV8yrXDVMDjhZxE8tJThY8sxnniY_o6ggJ7JQUjMdMcRKsQ@mail.gmail.com>
Subject: Re: [PATCH] app/test: remove use of coremasks
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6IQoSByXAKsAu39_Cnh3W-a8glUlTXSbiJuhcnnQHSw_1768569790
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

On Mon, 1 Dec 2025 at 19:10, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> A number of test cases spawned off secondary processes and used the
> "-c", or coremask, EAL option to do so. This option is deprecated, so
> replace it with "-l" in tests.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.


-- 
David Marchand

