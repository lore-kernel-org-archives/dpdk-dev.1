Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21BBC5B559
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 12:04:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E8D642D80;
	Wed,  4 Jun 2025 14:04:55 +0200 (CEST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47]) by mails.dpdk.org (Postfix) with ESMTP id 68455402D8
 for <dev@dpdk.org>; Wed,  4 Jun 2025 14:04:54 +0200 (CEST)
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-55220699ba8so8496227e87.2
 for <dev@dpdk.org>; Wed, 04 Jun 2025 05:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749038694; x=1749643494; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nJZ5kNYy43GxxXi0M8hKrUg7n7tjyY45W1hgN+6SXkU=;
 b=qJUTliGgZqwHjPVG6TFGpQC0Km9ewJB7bBcUoWVlIVk7YZTYPPTvtybJlfRapnordL
 4z/VbbESRYaKI2b0hqnOAkENyMklI8C86jMyE9zXYRhs0eGNSxTvdwVRt38m+rq+GEAE
 gKzhtjUw8Tb2vPfvIh0956Kr6EnkGUrZjgBf2jhroNRLDu+mXEQp9ajZvyNzMIFdG3yx
 V3zk+TekALCiF2XH9U6cDZKkqq52Q9I2cZt0ikB9Fk5cflubpf+DDevHx63FMbAcBqYD
 ypSFARRUPhR8FMbC7Dnxfb7B4xzQDhJWol0htWd21Bry7+hvI6RqIvmsdRVk2bNBtFGB
 3fxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749038694; x=1749643494;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nJZ5kNYy43GxxXi0M8hKrUg7n7tjyY45W1hgN+6SXkU=;
 b=RQSnEYqPOtHIXvYaT516dHkSaqVk9crFMR0CHDo7y+/69Scnz7c+yVpb6DSrqBzXJs
 Juah4NI+3u6kDv0itdTNbVP/9dx3X1h00s8jseD4OGvbBATPyzE2LIfa5yXTMJtHCWZL
 +gjwiIqUi16MmkhouIhX93rGClasqhTnWxP51Tg9jxjvgYgMPpUc4GKcLi2OFQpB7qDr
 OVrkAexX21CtlarJwjOkJQ6Qzwf8Cr0oG1mldLOdkOtKJcLXELf6L/w8YUt5hA15gRBw
 R4Jy7XBxSnXl5L47dZoj1NAJmJpHghcJ1/fpznC8E7J1780nQQ05wEE9ubS1rB7UqaGJ
 PbJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwXTwxYh3SiwU6UD/dROamqoPvb8kxY2D+VBv62qy3oUCu0u7dYREeKNqE6mCO+2kthlY=@dpdk.org
X-Gm-Message-State: AOJu0YzfZjgXF5hvAr3fS5fPRFuiaqqFddL+44i1g9+ZU5Uclsj8T1Vs
 sVmnliPYRlibf2jkCa04C7RvLJac8M4jhVwrBVIih5m58eXqPYgaZHBJmUky+1CBpBM/l2SlJJL
 8Kl03IgFYOjSYU6ZIbiGvN7xYjMnF9X9UeN3kVm1+EQ==
X-Gm-Gg: ASbGncuP2jViI9cuTEksgt6JxHbO42EzEictXpVnhzyCC3JFSK6ovhc1U+qYL42QChQ
 JtQ3f8gKG1+DBmGJBWFGXzdlwAK05JZvtHS+fWlBVRFSyGLdLoBXdCyafLkjWX6rmib7rlCt5FL
 nQhIs1V2bf3hhEwUkuOpoHfMf3t2Vot2I=
X-Google-Smtp-Source: AGHT+IF7e909RZ737T7oklvAG7+O0hqKWRAzYowNAJjTYZh7/CIymfVkaqM5ixy4nqjo8iMUS5Cc9xWZkEg+aDdW6nQ=
X-Received: by 2002:a05:651c:312b:b0:32a:6026:ec08 with SMTP id
 38308e7fff4ca-32ac7175af2mr6439241fa.18.1749038693741; Wed, 04 Jun 2025
 05:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250508074119.356011-1-zhangfei.gao@linaro.org>
 <CO6PR18MB4484068E26F01A086742F2F4D89EA@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABQgh9E0Kh115U4YbkVPOCR-65cbFb__V-+pRGFdRGoqLVYMtg@mail.gmail.com>
 <CO6PR18MB448446151350E98857F883FFD899A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABQgh9HYQo7FNPggY1-m4-SMga4Sf5G3RV1AU-izZunNJzgqcQ@mail.gmail.com>
 <CO6PR18MB44849D14A16B1B5729F69746D865A@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB44849D14A16B1B5729F69746D865A@CO6PR18MB4484.namprd18.prod.outlook.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 4 Jun 2025 20:04:41 +0800
X-Gm-Features: AX0GCFuoLfHsQ1gj8viJsBwgS6sMq_xs5XWV-gZxGjt6VwRPqXqpgR80AfA2Fwk
Message-ID: <CABQgh9HxKgiMgo4s9r1-PfA8+2Bp8ENduJEP+h6zOgaPKNPozA@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH 0/2] uadk: realize async mode
To: Akhil Goyal <gakhil@marvell.com>
Cc: "Marchand, David" <david.marchand@redhat.com>,
 Aaron Conole <aconole@redhat.com>, 
 Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>, 
 "dev@dpdk.org" <dev@dpdk.org>, 
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
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

On Mon, 26 May 2025 at 14:15, Akhil Goyal <gakhil@marvell.com> wrote:

>
> DPDK deprecation notice need not include API changes in external libraries.
> We just need to notify the users about the version of ZSDA external lib is going to change in next release or so.
> And then we can change the code.
>
> You can refer to intel-ipsec-mb. It manages compatible external library version in dpdk docs.
>

Thanks Akhil

Will add this.
I am waiting for the 2.9 release, which may happen this weekend.

diff --git a/doc/guides/rel_notes/release_25_07.rst
b/doc/guides/rel_notes/release_25_07.rst
index 0c9ec76355..138bfecd61 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -72,6 +72,11 @@ New Features

   * Support matching on IPv6 frag extension header with async flow
template API.

+* **Updated UADK crypto & compress driver.**
+
+  * Update to init2 interface which requires v2.9 of the UADK library.
+  * Update to asynchronous mode for better performance.
+
 * **Updated virtio driver.**

Is this suitable to squash into the last patch together?

Thanks
