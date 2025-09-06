Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1531CCA1002
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Sep 2025 04:15:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3103E402AF;
	Sat,  6 Sep 2025 06:14:59 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id BFF4B40156
 for <dev@dpdk.org>; Sat,  6 Sep 2025 06:14:57 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-45dd513f4ecso14222225e9.3
 for <dev@dpdk.org>; Fri, 05 Sep 2025 21:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757132097;
 x=1757736897; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BxkegPg9RVlZ5jc+CPIMWbqaNLB1bRVuKTSsevj5pE8=;
 b=ygod0nPtqMt+pzmr57mVCzFD1fFEhsIC8jcK7kLHAhGC6eFQ15U32aNYPCNqjyAbz9
 lAMJ1atyUL9NAtT3mTUEDM8A5s0vd++V+KMt/3dvtvCyMPAGZr0/Q6ctPTtbro/wcBT6
 KnJNAWfPWvJEamVERU45/F7uqFTgnyd4ER0cupAYNIDis1VznLfZmfUEKO/1ctWvwLrZ
 +ewHzy+xzwpkNSFprr1r7HLQC8vxDCqzRIzimFxiY6gLT304e8BJEfwrmd3twM/BlCJH
 hK7dLaUB8lRaX9ZYRMryB8cep29gDVyEzRk/RoNPdHXTdv+WSEOXuDN9hBB/BaNWnRQJ
 ZEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757132097; x=1757736897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BxkegPg9RVlZ5jc+CPIMWbqaNLB1bRVuKTSsevj5pE8=;
 b=phHppnn0A1Uj1nHX5tZQjS4IbbEXRNpFxUJMOIcHbuMbAeDlax7RdJWC5PmFqiEqac
 Oops4wWDeYETgrStoURCPJLc6vHVWncXpcQbQxkf1LNdFdrKk+AsgLHBEfucm8FRLC64
 OLLEroZHtSSlMOi4P4VWX1A8+rqAv76Dhe0Rdd3f9TcfAU5PGalNdBvWxj4o7Qfk0FdF
 QO4sbP7bAAgnivJ2nwYuIlF4vS3R4en0DEgIWo1rLGLKk4s+x5XWncwA1xzin2hD2ATw
 AynE9e7SM9aR5F+XoL8fI0N8acSk9yc4d3lGPNuJcfRXKNEz7ezqwt7mRieGoLqrj86U
 mZ2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDIFKsi0NGkfNR5ALs4qH67iiw0O30FAGrO0NEG8fArrLvcZJGKMb5Cnrd2cThDLLwcEA=@dpdk.org
X-Gm-Message-State: AOJu0Yy/TE5rRwazxREE75oNtoJhBWaDF6oI003F/em4OQ3tz3fi1lpC
 BbKQYZ17w9ZTsIu9G5ahw1jX/1DNqukEgHM+AE7Xu/LS02IVrLFC68o0SJ3OC8EB9S4=
X-Gm-Gg: ASbGncsNFSJPLxMcK+ejXqvJ3Tz/gNlZW6CW07DAtDFxo5mTiXl5EfuHMJcgU3WU1pk
 XAuIVUNia82FAL2aJh2sp/mTT84LHzXK5k4cr4izVDNZrZHFe1JYA5YnYSd4Zx3XnVHOFyLLunT
 J4xuQiNaHtwnk7StOvkLW2XXH3PkmOCgEmy6+/rTFhE6g0sj3yidIJ3ux6OFVO/QPFFlvC5S9mX
 to8t5M/lCLrTAS0Iu53fDFpa2RIUuRtf9MYaZcWEAXU2H0lNdAxipD2bnp8lrvRbRREOxwRfbN3
 W5sC8cNh+DdUtvkT8FMhWJY1/xxbS3Nk5/KbZQGavQ/hIrvB1pBnx+0bStLREY/61esoI1Ue+8s
 k2Y2OKjPjbqsZWyc/3HXFWsmrNPPrzAbDcs6EIO2pzRBwXZtTWijMbju/9YycHq1JzoLohr4QMN
 I=
X-Google-Smtp-Source: AGHT+IGjHSuRxvzoZV+h3eLovC3Nfm0WppKy7fXYKKczi2zAsBvxpAUSq6DdwjsIpsv11kubJfjPyA==
X-Received: by 2002:a05:600c:4f42:b0:458:bc3f:6a7b with SMTP id
 5b1f17b1804b1-45dddecdac1mr7634905e9.18.1757132097409; 
 Fri, 05 Sep 2025 21:14:57 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45c6faad9cfsm169988155e9.0.2025.09.05.21.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 21:14:57 -0700 (PDT)
Date: Fri, 5 Sep 2025 21:14:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <thomas@monjalon.net>, <david.marchand@redhat.com>, <dev@dpdk.org>
Subject: Re: [PATCH v3 2/5] lib: add semicolon when export experimental symbol
Message-ID: <20250905211452.13ef8796@hermes.local>
In-Reply-To: <20250901012149.47887-3-fengchengwen@huawei.com>
References: <20250828025957.30917-1-fengchengwen@huawei.com>
 <20250901012149.47887-1-fengchengwen@huawei.com>
 <20250901012149.47887-3-fengchengwen@huawei.com>
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

On Mon, 1 Sep 2025 09:21:46 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> Currently, the RTE_EXPORT_EXPERIMENTAL_SYMBOL was placed at the
> beginning of APIs, but doesn't end with a semicolon. As a result, some
> IDEs cannot identify the APIs and cannot quickly jump to the definition.
> 
> A semicolon is added to the end of above RTE_EXPORT_EXPERIMENTAL_SYMBOL
> in this commit.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---

This seems like a big change just to workaround some mis-feature of an IDE
which few users use.
