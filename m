Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F855CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 03:57:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB03740671;
	Tue, 23 Sep 2025 05:57:13 +0200 (CEST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id 3C19C40615
 for <dev@dpdk.org>; Tue, 23 Sep 2025 05:57:12 +0200 (CEST)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-4ca049e90b8so15249041cf.0
 for <dev@dpdk.org>; Mon, 22 Sep 2025 20:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758599831;
 x=1759204631; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5rAu7lPYWi5zU6vE3MfDSYGXFJzObGao431ouWnZg7w=;
 b=EIdVido7h2Hi1J81HjAQX50MDeMkeizayF8icLeygM8G2T69r/tNmKhGopmfuwH4j+
 44nfOsNnD0Q21ZJDIX/Wke1Orii0xxCpZNayYuVvTS8hLZeEx+1WUSbAlCQt2VhFHEtl
 lLBHcZRacT7K5CoKC8QTUrOlzVdN6HTwsgxJ0eaDr6b0TKW9sWkJWVnN8SAb+vjLt+t6
 tQYnJ+dILktFd/7nPqYIBNQNaodqc9oqjfpEkJlnXbFRb+aMK6bKsgTRrms9YpCeZXG3
 HpPMSAQ1GQn5dGY42cfAMaU9/pXHAdbvKEdO+ssqMXllmyv32ShQrkDTyq5vhn0LKLAH
 g8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758599831; x=1759204631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5rAu7lPYWi5zU6vE3MfDSYGXFJzObGao431ouWnZg7w=;
 b=HMHnZgzJMbUfySzvQz+K2qhnhGG2otMp50k+jN4sH55Ji9f3pz+bEqyRf3s7bXmGGq
 g+//80kzrhw4C/sxlikOfiCpBRMujgbcbcjqI1lQhDRttma8zIJYpDVNK8SGUtcDUG8n
 NJZPFH6NJZ6/8U0lZ9Uac6Hp+mF696Av9IYsUNiLlnZIi8YeDjfWqWa/mcu/APFzCeos
 X2KUVhbjYcItC+AnRQ9oqSAj6oCETKtDaOo4sk36TTL2+kvbvuCPjonMkDOQ0MQ+uqFW
 Xfl6em7vL/oV9gMcL172OfxaUNuBXcIlGDKlo2tcF8FcSLNQ6MXzSpsPCZpJ/tithy5p
 hNMQ==
X-Gm-Message-State: AOJu0YwVoBmMy5fihCbfJJuYUkoun8teKk3d6iLv1qR3nKI0twaGomhV
 jRMywkDdgeq1hYf4uEM5urdIqTfGCwSp1GJNFhHla9Cxfd2nzcR4zsldzKYJaiDLJVk=
X-Gm-Gg: ASbGncuN1jfVmwTxNjPbMllM7otSrf0dHdJPcfEscNRupZO1tAEmlEQRnjDvTOyo3ld
 AYLNlUTNuiXRkquBjOpCXFfRVeKp8mIzqlR0MF8NJ9BRyDyeAyMXNazMVnIifiM2OxntmHdXW3G
 2DAqMVud+f1sEKn9sm+xQGfbp6U/WNfBXyZcI1sRkJMUXmbKXLvcNl0B8peGNTWkXqVFLnfwbQJ
 inygODbdBPY2PzCrdfm4CReG0mx15YWuEtlIrkyZT0lNEzcigk9fvuUpEEo07JKVO8rayDbDrXd
 Njqbmfmv/WB3hVw13ZrttLmCyc4IYTpY8SU300BGMbUntlK7sBGWg4LsSkFUJfS/7g6KQ8K3sKb
 CbK3ZzZ0j5hG/NOcFm1Jkv9N2mHqGP/8fo26gMM5Xo2AAUQsedXyVdTpLtfZ/2YmqLbB2fGslhV
 U=
X-Google-Smtp-Source: AGHT+IEO+48s/O0wx/wKojQwt5872c/Al8hmmYXZV8ubTh6v3AnjJibSJUuIbsrmWVYri2yPNYicFQ==
X-Received: by 2002:a05:622a:1186:b0:4d1:20f2:50c with SMTP id
 d75a77b69052e-4d390cfc262mr12117861cf.14.1758599831385; 
 Mon, 22 Sep 2025 20:57:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4bda15f5796sm80700031cf.11.2025.09.22.20.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 20:57:11 -0700 (PDT)
Date: Mon, 22 Sep 2025 20:57:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, alialnu@nvidia.com, stable@dpdk.org
Subject: Re: [PATCH] net/tap: fix build with LTO
Message-ID: <20250922205707.5beb72e5@hermes.local>
In-Reply-To: <20250922073043.2394557-1-david.marchand@redhat.com>
References: <20250922073043.2394557-1-david.marchand@redhat.com>
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

On Mon, 22 Sep 2025 09:30:43 +0200
David Marchand <david.marchand@redhat.com> wrote:

> The compiler has trouble understanding that the code is actually pointing
> at the data in the message past the nh struct.
> 
> Update the tap_nlattr_add* helpers and the NLMSG_TAIL macro passing a
> pointer to msg.
> 
> Bugzilla ID: 1511
> Fixes: 7c25284e30c2 ("net/tap: add netlink back-end for flow API")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Queued to next-net.

Other drivers that still have outstanding LTO issues
are: mlx5, cnxk, bnxt

