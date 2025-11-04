Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D201CCFA00
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 10:20:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED06B402EE;
	Tue,  4 Nov 2025 11:20:26 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id EBCE34028C
 for <dev@dpdk.org>; Tue,  4 Nov 2025 11:20:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762251625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IqJ7bx9Btu0z4ePX/yqlF/lOFK9g6eB5IjDN4GQo6qY=;
 b=QnwzS1ECiwBiGBuf8sbqyxZ6T28KxfQVEM9kD55e+IHGl8Oe9yLVyyGLOD0MgBIQMcLeRv
 LfItO95UzPk/VOyAj1/R3G36PbqGfublvZXDOQpxybWEPMbpVGNknnbBFtGIz5onQ+6AmP
 9aPBmn/UTqQAIiUlRHNyr76MMriH2iU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-sa1fhBgWPwivP3WpLzYSWQ-1; Tue, 04 Nov 2025 05:20:24 -0500
X-MC-Unique: sa1fhBgWPwivP3WpLzYSWQ-1
X-Mimecast-MFC-AGG-ID: sa1fhBgWPwivP3WpLzYSWQ_1762251623
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-37a2ca2cfe4so11971571fa.1
 for <dev@dpdk.org>; Tue, 04 Nov 2025 02:20:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762251623; x=1762856423;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IqJ7bx9Btu0z4ePX/yqlF/lOFK9g6eB5IjDN4GQo6qY=;
 b=B8C0w1Y5tjmHVL7rqGQhBzoiXExXICZPvgzO7/arUCVJ4RHFBFE9aaRaSPzGe6Ggx5
 meOfCwzX40IoufB6gqL8ZM7+BbZ1D6vNuyavU4skEloM2jJsokr2MYt0qilEo3ukbYKD
 B9iAgmUlLX86cqWCVYBnJqPbqiLbnT/qSvg8XGpZEfk8XqDFIwpCMeWmRL3/wPeLaiW2
 ko2+dQpHT2ZDDQEW5EBHV7i6pN+tvD74wOolnfHf6cPsJKFyUULxxgONu0AiQtik8KL3
 O9JFXeTbSQNmj5dFomqyODwEAmXYRlZYTEN/+WpdJ2EoQjkUTgFU/gId1668oYjZq/q7
 h10g==
X-Gm-Message-State: AOJu0Yzpb2YDeNvE7+xk4Q1yksl/Xkx2QbAug97e5yG7tbwREi6WzTZO
 LfA/WFGI3tN2NB7l3O5PrMwYBjGtuOOUZQc/6CXrjpbWKDsyif10Q+vCEai+MKoZ2axSzzJx40b
 nEQoRQeGBETx4rOuy0JctLweyHo9QtiRl0icIVhDbhZShHl1XlUBEorBfefG+Y1gessW+FfkcAI
 3JPuAdQTMZA3X+HPR1yrM=
X-Gm-Gg: ASbGncvw9+AwwIjNRIO/5Kky/Vo3FqGXJcjLzc9Za7XB0K0iUuVTVXjQcWY0gAPMrQo
 /Ph1AHQ94GYaIbgmSATCCvUhkyCrer5tZY0uTtPpP2c1drM/wB7ZXmpFcWl2XPSQfJvFj/TMcsM
 TZNQoWFAk68cnw7oVzaww1/lKqkuDHEnVM7YU+EUe589Oop/BEL2jOKJMzXg==
X-Received: by 2002:a05:651c:513:b0:378:d69f:af4a with SMTP id
 38308e7fff4ca-37a18da4e6amr45513141fa.3.1762251622696; 
 Tue, 04 Nov 2025 02:20:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIxb6BVDIu89ul6FBnxCumBxyJW8VVkE2SkLVmmDsWMQNnB2DOPdFbQrONZCaC5WTWWWB3ymha4s4AftTzkgI=
X-Received: by 2002:a05:651c:513:b0:378:d69f:af4a with SMTP id
 38308e7fff4ca-37a18da4e6amr45512991fa.3.1762251622263; Tue, 04 Nov 2025
 02:20:22 -0800 (PST)
MIME-Version: 1.0
References: <7e4985db2bbf29515f8cd6a4ab510d71f8a636a3.1761299581.git.anatoly.burakov@intel.com>
 <05ecc81aefbbe2073416c0e78aed926ec9ad54b5.1761299581.git.anatoly.burakov@intel.com>
In-Reply-To: <05ecc81aefbbe2073416c0e78aed926ec9ad54b5.1761299581.git.anatoly.burakov@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 4 Nov 2025 11:20:10 +0100
X-Gm-Features: AWmQ_bl0JFix6WGsE_NgKTcGlrVVjDx3N-XMBEPB5TzQoeorvNWQHXpArQdhttY
Message-ID: <CAJFAV8y_xS_nZ9g5hbTWBm4D1t1kfuX57ryLKqY+iNnSXyKwwg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] bus/cdx: fix incorrect device release on error
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Nipun Gupta <nipun.gupta@amd.com>, 
 Nikhil Agarwal <nikhil.agarwal@amd.com>, Ferruh Yigit <ferruh.yigit@amd.com>,
 stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rin76P2w80a_4_4zxhxnB9qiYhRRZPC5mvjLE5C-du4_1762251623
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

On Fri, 24 Oct 2025 at 11:53, Anatoly Burakov <anatoly.burakov@intel.com> wrote:
>
> The variable cdx_addr is a stack-allocated zero-initialized char array, but
> it is never used anywhere except in an error handler to stand it as a
> device bus address for a VFIO device release call. This is incorrect, as it
> should have been actual device address, so fix the code to reflect that.
>
> Fixes: 45ef232af515 ("bus/cdx: introduce AMD CDX bus")
> Cc: nipun.gupta@amd.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>

Series applied, thanks.


-- 
David Marchand

