Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D36CA0FF0
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 13:46:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E32AC40263;
	Fri, 29 Aug 2025 15:46:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C6BD34025A
 for <dev@dpdk.org>; Fri, 29 Aug 2025 15:46:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756475217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hU8gOCILGdeeFbUHIoM8/yLEPEhbCK/LJEZnafzsRi0=;
 b=cIQqsmoOiZbKTM6bJCOKWElBn3/t8zLtqzxH5W7pAHYAS3Sw+0OLbNkw9px3cDLDhCyL3j
 hHsbNk8zch2Qc5c/Un5KUmZ2uKVKJPpU1+jCSoMqrk+j7Ksysls8qpyvqTw/S/Twvsqv13
 9xueNAz1/cCGnHi8diaIenqqoSuX7k8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-43P86TZrPvet7g1dEXGLWA-1; Fri, 29 Aug 2025 09:46:55 -0400
X-MC-Unique: 43P86TZrPvet7g1dEXGLWA-1
X-Mimecast-MFC-AGG-ID: 43P86TZrPvet7g1dEXGLWA_1756475214
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-55f41e1848dso913897e87.3
 for <dev@dpdk.org>; Fri, 29 Aug 2025 06:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756475214; x=1757080014;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hU8gOCILGdeeFbUHIoM8/yLEPEhbCK/LJEZnafzsRi0=;
 b=Tvh5iP0tRINa2Zq4l2GwCKt++xKA/Q97R+d50/XY5Gr29hTTO/VNHgXdMBJijNoack
 lDQyUnUz1JEbg4B4D1fGQe0yB8LunWuivnfMSJ8GzJyHtwRqP7eTBBkUCqH5ZAC0W7Xe
 PqHxJ2kVaml0SX+V74lLwkl0H2fybUECD+MyLieMBpXud2ybcEO2dnwCBRu8hIvMxBot
 vOMJIr1VViHKjO0uKsxeCvvIiRUtVBBdsiWdzfmvXR3CfCYQ0LvsO2i46rqGWsYqxMAY
 X+wq6t7YITUwSpOWp2wOp1wu844pufOigE3XtRAhceJaDXFOK4PVwASBVBC4pbcOjJn5
 yeCA==
X-Gm-Message-State: AOJu0YwcRvV9XUlaY6l7801IEv8Cx4EsC3hY2RKXApH9QI9Fn/KE0hh7
 qX5lgtZFr5WcB2SwK50mbaIrGDVqYQ1e4zd13wAg9j8bjMhr7+kOa3kM6+OJaFwX1Ns7lAiEyR2
 kHQyxEXI49VSCntyVKs5DLuUVR0tA/oIxem1FS+2TEUBUwtT6LTehdkgY6zLeepoGQa24TnDzY1
 087N9i1e/1REodfZhs4Ec=
X-Gm-Gg: ASbGnctjSqrQjL2Pzype3+4Ym/D1pJniRlhYDGwUCWhv8x2AvCantW1Wnk737Nqoujd
 xW2f7qCOmOuhiKeNCL982JPfLiRBB6OuM/R1xNURZjrwuorq5V1FIkK7lJCe+QtC1W5ElSgp9g7
 jIJmRb41AbPs2ZscwOO0T6QJ8=
X-Received: by 2002:a05:6512:3b29:b0:55f:46cd:2c79 with SMTP id
 2adb3069b0e04-55f46cd2fb3mr5240314e87.9.1756475214164; 
 Fri, 29 Aug 2025 06:46:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExG6TweIqc3+gZPWvCq4Mn5d4u2vs60z2CJ60Qn+ff5fFkxpJmpf9Mo+KfuvznNIgQ/cVcdNmn1EnpKeLWIjY=
X-Received: by 2002:a05:6512:3b29:b0:55f:46cd:2c79 with SMTP id
 2adb3069b0e04-55f46cd2fb3mr5240307e87.9.1756475213694; Fri, 29 Aug 2025
 06:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250718121402.856265-1-bruce.richardson@intel.com>
 <20250819112521.1608207-1-bruce.richardson@intel.com>
In-Reply-To: <20250819112521.1608207-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 29 Aug 2025 15:46:39 +0200
X-Gm-Features: Ac12FXwa-GjxVYIVPtiQrll-BwQh1aOJNzEpml7-9Kg6TgiEg5VGY-P3Wpa4LtM
Message-ID: <CAJFAV8yExTzJMD+FZDbEfUopT9vRmbymGenXDbiqRn9EGeydMg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] build: remove obsolete compiler checks
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NVtTWewChLKi44W5LTjQxHJSA8wCzya7-jnd-4TaDnw_1756475214
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

On Tue, 19 Aug 2025 at 13:25, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> DPDK now recommends compiler versions GCC 8+, and Clang 7+, so remove
> checks and workarounds for versions old than these.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> Reviewed-by: David Marchand <david.marchand@redhat.com>

Series applied, thanks Bruce.


-- 
David Marchand

