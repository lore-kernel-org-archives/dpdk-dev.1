Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A9DCCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 17:11:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A20B402EE;
	Fri, 24 Oct 2025 19:11:24 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id F2087402E8
 for <dev@dpdk.org>; Fri, 24 Oct 2025 19:11:21 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-7a28c7e3577so501795b3a.1
 for <dev@dpdk.org>; Fri, 24 Oct 2025 10:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761325881;
 x=1761930681; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3oeDxHV95hcq/dNIK9hTYOCiMbj+2NwcXWu5FOhKRb8=;
 b=2w9RDZXzRDrIaG44ONV3GS2cXfcws30vJvhmmDQLqpIcG8CJZ8pu/OOGtN00Ws16g0
 2rFbujqjqa8vvw9W1MeezV+FiT+4ajg/VGBj+0Fq/Ds+S/PHuhT7+wAaEBuircsYbHa8
 zBN1SOh7W41wkAFjrrRE3yYbRI4Gm6pjj3NZ17JCQbdeMiuT3PUbfzbm2CSL6hh3ly34
 CSgdcR0lN2Re2twjWlf3L61E3JG/iMBP3B44MyToKlTfC/a40a9WlxFsAlXsYo3j+MNN
 cRJqUL4Di2zejo2ylPvlNTjS3GOPMIdhOdZPbIc/JMcjIKrDmqrT7UeEbdTcfmd0HIEE
 n7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761325881; x=1761930681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3oeDxHV95hcq/dNIK9hTYOCiMbj+2NwcXWu5FOhKRb8=;
 b=EuOOsQwdt7dZsKrWAfieaqj0z0Yvo/eOESxcCsRYZ/G5jaWSOe0GqyYR3w6MJpVEgr
 MYwjvWqXdHAKaxET4rfzF5Oo8cZShCL3VN0zI9U8f7RSAvhPnycCmRqMhZHZCbq8Njzm
 Ekljjk10FVJY6Ydd+FQXIVueeP/wn3cgy4MNjZHXOuBzekZB1FDjAnsUU2c0qjRPS9zG
 U3gTQmkWJJqcpJnTtF22qqic491L6v+IMtI7omhjKTHR/R2tasT4wvWDYL9Pzu5CVMLC
 ZC5IX+S7blPxLWS+3nJd3F4aK42F8UBUvGHaFUAwLNGD5cgeGLLHhn9LjHT6Dmtfqkjj
 4eUg==
X-Gm-Message-State: AOJu0YzkdzD9hGcyH5+KLj/VGSiFNIJImwhSCd37eeiBaO51v/P8VxhZ
 EWKKcYvd1abXJQh+NkErQB8t1IU5SxKXbMHY3qGYJTUsATKOv+e//k3KHoPK0Yl5ecY=
X-Gm-Gg: ASbGnctwbIRVQ/GmgQX+5ESTtEVLhrbPy/CN+F70w8e1gtZZJ1rzcxyBkt1VOv9kXy4
 LXT4toba2AaqYp6QQgcZHS5ie/ONvLBOUr6DD6MLJedcveLzCmsQfEf3S5Cw6twkqjPYiIIRAez
 se+86ULcZdLq+ao8/my9Mk/CCTKIGRHuFHzNnnAGjQKN5zw0QkIglCX53lzJPH0NKCXBZ5RvpYT
 4gGbspA9gxYL9tyVEEwmlDwIbd8NIaPkif2ZkCmapB4O5TcctCDYKaf4b6/wH4wjaEUfqs8aKAF
 e9Zx2RvzM0h+jTkQScuQMwLb901jBTqsGs5JNHM17uKIibO4NZWBUIVgPKbDpRYy2GYG74V39i7
 haPGfiQlYGCI2cucfqmkUoL3VYc8Qpe9J/l4lgPjScAYzGVN6jmLxN2UU7di0HJy01VFsgtpodB
 EToRUa8jDI5Xr0c7tnLNZ0mZmFWIDFZvhVKfynaWh8h5Ya
X-Google-Smtp-Source: AGHT+IHtnSjNLgSKiKOLP5i7097Us3AgdrHVeYNx5e6YlspwUeGxhtpNH0ACEcSOaISrTKiJrtrU9w==
X-Received: by 2002:a05:6a21:1584:b0:33b:c59f:7d28 with SMTP id
 adf61e73a8af0-33bc5aed957mr11829203637.48.1761325881095; 
 Fri, 24 Oct 2025 10:11:21 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a27d583970sm4669776b3a.51.2025.10.24.10.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 10:11:20 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:49:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v12 01/13] net/sxe: add base driver directory and doc
Message-ID: <20251024094938.0e7e6c54@phoenix>
In-Reply-To: <20250728090517.1811244-1-liujie5@linkdatatechnology.com>
References: <20250725104855.73326-13-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-1-liujie5@linkdatatechnology.com>
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

On Mon, 28 Jul 2025 17:05:05 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> Adding a minimum maintainable directory structure for the
> network driver and request maintenance of the sxe driver.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---
>  MAINTAINERS                         |  6 +++
>  doc/guides/nics/features/sxe.ini    | 55 ++++++++++++++++++++++
>  doc/guides/nics/features/sxe_vf.ini | 37 +++++++++++++++
>  doc/guides/nics/index.rst           |  1 +
>  doc/guides/nics/sxe.rst             | 71 +++++++++++++++++++++++++++++
>  drivers/net/sxe/meson.build         |  9 ++++
>  drivers/net/sxe/pf/sxe_ethdev.c     |  3 ++
>  drivers/net/sxe/pf/sxe_ethdev.h     |  3 ++
>  8 files changed, 185 insertions(+)
>  create mode 100644 doc/guides/nics/features/sxe.ini
>  create mode 100644 doc/guides/nics/features/sxe_vf.ini
>  create mode 100644 doc/guides/nics/sxe.rst
>  create mode 100644 drivers/net/sxe/meson.build
>  create mode 100644 drivers/net/sxe/pf/sxe_ethdev.c
>  create mode 100644 drivers/net/sxe/pf/sxe_ethdev.h

You need to add a release not do doc/guide/rel_notes/release_25_11.rst

PS: if you have trouble using AI to summarize for release notes is easy and fine.
