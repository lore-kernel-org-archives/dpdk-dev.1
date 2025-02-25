Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB006C021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 14:42:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DED0A402D2;
	Tue, 25 Feb 2025 15:42:47 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 6CDFB402AE
 for <dev@dpdk.org>; Tue, 25 Feb 2025 15:42:46 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-220ec47991aso79010975ad.1
 for <dev@dpdk.org>; Tue, 25 Feb 2025 06:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740494565;
 x=1741099365; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NV5iaKuh+yGFl6d6Cr2/74o7XdkJ1X/ZKdlpMo3SumY=;
 b=k9wvz0DxOYDOcOCOy2zq03m0gJitrR+yTQr3Eye9cjW712Ds6iAtoKLJBdYgqbzA4p
 zHTJGI+VYUWSgGWESgBp+0FQQGp0fCXiDRPaMEFZtuy058VCVi/lt9NY/WsfGEothtUL
 DzyFo0SbSORTKawsfL1m1QNlm7co/sqNSEg2kKCZBOdVG7LFNhmOnqn/rwhjEDH6yass
 OYNoxCTUDst0S0vwQnrzBMPTl3qm6smoj46FWybAx8Z6eeENDqYW1CWJoZqGT62PriYa
 5a5uW7fir3301tVAHT3AbB7ck/MpOyQiGQ3AIjGvwFLUN3lVsfCnCipKAlLWwYxw46gj
 QN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740494565; x=1741099365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NV5iaKuh+yGFl6d6Cr2/74o7XdkJ1X/ZKdlpMo3SumY=;
 b=filT5XERt1aueNS8bGS0g3IDj3lZCqk7a4YV0t31qP7Iwjz7Uv6XsM9afdLmf8GN9k
 OKLk8zTYHWQlQarwbM5TQbw/lMudm8AgttkhCwHF+LfanOi+eJHaw2Hhrsia84/bh4O6
 z8y90ENFrRvoNSnXZuU9DtJImMNhnKeIn40rsUU1VimkmwpRHPJ6mCGwuZlG4BYPzg+/
 jpljZATgbYsFzlK4t0CuQx5q9oFZ+SEZFCvNgnDkrRl00Y9FgLj3q67q/zj/4ZcZOP/C
 KVU7YNukscGUu+plJ5ioBdDkmNuR40EeCIzLEVXXC9gSWYFWXUR4CvmbF6FeSkKbjCjW
 HGnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG+oEpn331tGeux6FDfE9Pnh8rFgaE47FHrbdBLF+DAwBPN8haDiWEFJI+7tOL6ehb05k=@dpdk.org
X-Gm-Message-State: AOJu0YzEt/jgRkqNI0r+kcztHm5opWXVH9UM75oixuY0/ji7LcnaN7KC
 uqDCvFLiXmcNgWqPiedH9NKr7C0g3ryoSgixPjzCDNduPTyuna8rLKGl073RDPj25c2/OgXrx9p
 0L2c=
X-Gm-Gg: ASbGncvsti/J1DNRfoeWs1wewRK7IhkaollRSQB7cIroAcA+yHPg2vsHjvLSMkZOQtx
 ob8HTpj//lzPG/zyAKTAmmERUpU7YdJHSixrpS0bIzUTRBcQSzWHlMycs9mqzh8H4HfUjED/guP
 Y8DdYFT0350QeHa7iCnZNjeArGI/df18/uZCN1pEgwHfSxVoI4vUtFxwcfydYy79F++oQReXtpo
 D0Ru6iU0Cq36OJvIfZhG/HR8xfhlaIjtnghH4aksOIiLrRK1oURJ3cW6BNDy3E1OUyNJ5gi+aQo
 VjN7y/ILxvEB+dKGqoBgB7bLsTMnjqbYHpSrclSULLjrTxl0WZihCi3eRuJt/juu0S2t/S3Xwz1
 2OWE=
X-Google-Smtp-Source: AGHT+IG6jwEpAizf1rz0h6qA0Fki1UeYhJ15OThHhfsThIh0iLL0T6PbgvnXGtCu0ngU0JmHNP9eqQ==
X-Received: by 2002:a05:6a00:190e:b0:732:13fd:3f1f with SMTP id
 d2e1a72fcca58-73426d96ceamr35091928b3a.24.1740494565468; 
 Tue, 25 Feb 2025 06:42:45 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7347a6ababfsm1613430b3a.19.2025.02.25.06.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 06:42:45 -0800 (PST)
Date: Tue, 25 Feb 2025 06:42:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <thomas@monjalon.net>, <aman.deep.singh@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH 0/4] enhance testpmd DCB command
Message-ID: <20250225064243.1bb9f2c3@hermes.local>
In-Reply-To: <20250225091929.25072-1-fengchengwen@huawei.com>
References: <20250225091929.25072-1-fengchengwen@huawei.com>
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

On Tue, 25 Feb 2025 17:19:25 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> This patchset enhance the testpmd DCB command features:
> 1) remove restrict of number of TCs (currently its 4 or 8)
> 2) support config prio-tc map
> 3) support don't adjust queue num
> 4) support disable DCB
> 
> Chengwen Feng (4):
>   app/testpmd: remove restrict of number of TCs in DCB command
>   app/testpmd: support config prio-tc map in DCB command
>   app/testpmd: support don't adjust queue num in DCB command
>   app/testpmd: support disable DCB command
> 
>  app/test-pmd/cmdline.c                      | 184 ++++++++++++++++++--
>  app/test-pmd/testpmd.c                      |  96 ++++++----
>  app/test-pmd/testpmd.h                      |   5 +-
>  doc/guides/testpmd_app_ug/testpmd_funcs.rst |   6 +-
>  4 files changed, 236 insertions(+), 55 deletions(-)
> 

Will look at this in more detail after 25.03
