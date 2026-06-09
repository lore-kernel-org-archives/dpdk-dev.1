Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC99CD6E79
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 09:05:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AC12402BE;
	Tue,  9 Jun 2026 11:05:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 804ED4025E
 for <dev@dpdk.org>; Tue,  9 Jun 2026 11:05:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780995942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r6SSusA9Ffx7sOjtXR50R6AAUYIPa2IoGY4FVEymtFU=;
 b=HO7s+mUmJA2VRAILBdRd82MKAEPucpucGssW2T6eAd/FJu2C+ajLC9UiMVKXgb8CiztLqu
 uWZnfospCKES81+lSsGTi0peIYd4VT/e73xWb6fWoy+jq4gSwA8LdkiyrEBYMEuBrBKcu8
 uGXOHTCGbJw0t6GABRYr7nB/qIWqsl8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-jKGpJMFsPXel-ai9seZOCw-1; Tue, 09 Jun 2026 05:05:40 -0400
X-MC-Unique: jKGpJMFsPXel-ai9seZOCw-1
X-Mimecast-MFC-AGG-ID: jKGpJMFsPXel-ai9seZOCw_1780995939
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5aa68d9308bso3396470e87.1
 for <dev@dpdk.org>; Tue, 09 Jun 2026 02:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780995939; x=1781600739;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r6SSusA9Ffx7sOjtXR50R6AAUYIPa2IoGY4FVEymtFU=;
 b=bc/QxMk2yqKqqe24agdLb25HoelMWtCCBDeHkUj7dyNNkq8lai8q7Su5HzKO3Z2Zxn
 Sj5xfNdW06SY/X7rs05mmWlj4sw2Tt/33iZmgiC/UbjULn+VwBrckoMECeCrqZV7Cmvh
 Sitxhqv8t7f5OC1sGi+ih8C860CF8RmBAKxZ3VUaeD7rMZ3RS9Tf+vIL3Z0GG0m0EQXl
 GDRpDxlMLr5bNCUVpHKsC2ucpxeHn+Co4+yWOsHTBEQW6rSYpTK5QGsy2vwMG051Jwl4
 akQC6X2HvkXlc3i5p4ILXgnxmNYZYYOfDurDmIzZyJeVLLLn1+rcH3/GGXVATIwwBeXx
 KLDA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+RBhvzO9z1MDFDWA+MCgTfqteDJVGXP13VIzG+N582PW9V4r+aWUAmwPhkkXyZb2wlrM8=@dpdk.org
X-Gm-Message-State: AOJu0Ywn8tyBB+1F8OUG0kex/r6RkoMYfnwYNhsJdHogUb5+ZbKciLwd
 XsD/A7+oMEOkxKvjlP3t6gIFRdZnjvKIesqYX4W1wv5KD3940Afr2hrLtLoEMfSyEW4D6YbxaQr
 pmfoy6Dq7dcymidKM2zxREAzHn3hUFKZikYBS+rLVbXLgLkT/qX7fEMA92dyyXuZzD5CGOy48/Y
 ML/wwp++Krrul4NS4WZDM=
X-Gm-Gg: Acq92OHuK4hIJsNIRc8vB0MW4rQIbVQG3BN0o2HuAD35/UGVdLg4v5ZiArQNGIF9XYF
 9J7l+nOpRVdb2XMHJljfSoCv2VHeF0Ths1oNqULdZGkIpe8JBQ94yrir5BYCjUHvGOWsww8/Cmq
 FzXQiEK9iXwDL0NT24PRBG07qixzBVnl8FHSX48SdNnCqusGD1PgyYajQPZPEi8I91XnWKhx3cu
 mA+Yw074xutFFQO/TGdbd01J+Zfdu8JqmzwGI+/qYoE5kl/ZRiwP54UktsapP0VYThyQHCcycaW
 YXMD
X-Received: by 2002:a05:6512:3e1b:b0:5aa:8824:156b with SMTP id
 2adb3069b0e04-5aa88241622mr5299904e87.47.1780995938784; 
 Tue, 09 Jun 2026 02:05:38 -0700 (PDT)
X-Received: by 2002:a05:6512:3e1b:b0:5aa:8824:156b with SMTP id
 2adb3069b0e04-5aa88241622mr5299879e87.47.1780995938206; Tue, 09 Jun 2026
 02:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260407143656.9960-1-wpan36@wisc.edu>
 <20260410162826.15485-1-wpan36@wisc.edu>
In-Reply-To: <20260410162826.15485-1-wpan36@wisc.edu>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 9 Jun 2026 11:05:25 +0200
X-Gm-Features: AVVi8Cdj0Q49JN5DDqKPsxsrfgOXmfUvFyy-g5CM8ozBZF07ZDtoV8_Uvw_O-Rc
Message-ID: <CAJFAV8w6tyRyJbhLLcdooQaOGoBOWk-1--3tiN4OrLwWCVhX2A@mail.gmail.com>
Subject: Re: [PATCH v3] raw/ifpga: replace printf calls with logging
To: Weijun Pan <wpan3636@gmail.com>
Cc: Rosen Xu <rosen.xu@altera.com>, dev@dpdk.org, Weijun Pan <wpan36@wisc.edu>,
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i5LtMTXl7GFpZcvrQPigdZCD82yCRpBHLOW4Bf_8fGE_1780995939
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

On Sat, 11 Apr 2026 at 15:58, Weijun Pan <wpan3636@gmail.com> wrote:
>
> The ifpga rawdev driver uses printf() directly for runtime messages.
> DPDK drivers should use the logging framework instead of printing
> to standard output.
>
> Replace the remaining direct printf() calls in ifpga_rawdev.c with
> the driver logging macros.
>
> Signed-off-by: Weijun Pan <wpan36@wisc.edu>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.


-- 
David Marchand

