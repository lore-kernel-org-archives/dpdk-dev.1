Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212EDC369D1
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Apr 2025 16:16:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86C674060C;
	Sat, 26 Apr 2025 18:16:01 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 46295400D7
 for <dev@dpdk.org>; Sat, 26 Apr 2025 18:16:00 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso2756365b3a.1
 for <dev@dpdk.org>; Sat, 26 Apr 2025 09:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745684159;
 x=1746288959; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vyzh6AVMgN8HKw2WeBfZpTbxDY+muS5iLZt+b/kR3cw=;
 b=g88nqSB7r6j1XUBRILjmIYpaf9/ZM5Gr4NtOIUNPeWvqLnG90yw6krWGgvD5aTxq5a
 XKO6Otf3M8psRTpYS4s3v97zvJWNQP09DBF8GA27h7IHPZBTNuFSFC/7hYw1JcCG0FuN
 ckk6viIQmczR5phpIVU2I4aDX7ckqt60bHjwfTICUyPDSDOLPGDnJrp3hLmCww5ZIQAf
 CLAJpKxkFcp5ndw65IaGMM3yf8ycXv4r32wajAZtFVunfHW5hXHRArZZZtP/JaGJDJJ1
 E93Z2mm874n0XdhfqRRiqdddtQVwiF6avVD7kKkCcFbNaBiQmDarrgW7Tmv9eGHoO2A4
 KvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745684159; x=1746288959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vyzh6AVMgN8HKw2WeBfZpTbxDY+muS5iLZt+b/kR3cw=;
 b=FLE9tXhk12vd8mmMd9sb9xqY5N/D6LFPhcITf0MBonTHlw0ppMispiX22j5+R7E2/0
 mDdgUoVlGMcuNUO9gujdSoisPaTL90h3ONih3FJ+QKUh4B/8Q5ImlZRB8xBIEsAyY/Kn
 MeEyy+n+sJ/DIhP6l/r/YvNmNGZwD8ggBQbAv7jqJu10uAEcrajoHaT3MJ1pPhCrWmvF
 pUdtiHEo2/LRo8Hm1BVT+AliOsR9NpBh7+ascSACWCCzcKy60zqZIcvbCBdLNWJF3+0i
 sH4nAfGOZkqkrXS52B/g0HBYVjTOWhNO5yn2aD0vj+GsHbW0j/r/6/bY8S+AZa662LCo
 K3gQ==
X-Gm-Message-State: AOJu0YzIDLSZIfY9p7c2JdB+u/MgCrlEj60QUKULpDia+GFd7+q2ENH2
 G/95LJ7DhAIdZJ6zdRT05XkeaQUaeRm12Yi6vEEHCJPfPgLikEPsBsqlaKGjFDo=
X-Gm-Gg: ASbGncsf7MRBWNYbIUQL//4cH5z/owHHDR1zWxZxDTvhNbCjvTWKkIoBWappBrQif0r
 kRjGHtdOEEKUzgrKTjwEPvan125Wu+fUZN7q6MnK7tJgaj0Z96ipN/X3WCKCCMe2eRH6LaD+zn7
 2bj/I8X1/6cjJQQVB53KaGW+Y/v9Cl8wmKGjfgFawVHxN31/wIbpEnSJNKLEHFTCa0Rn1/Wh9Gr
 o2Kv+jbT2DuzvctQP/K5YXqPOHm6BI+wyVbtzI1q11U0PSW3bQGrhmL7UtgYmOZ2ZldmPB9/6TS
 cvjNGmxt0FRVenXNWvIOjdsnLHaGE6rtYrUxikEBNqE63L3UTtHKPsD/6rsnuZ9huquOD3KXwVe
 A9UB96CivuFo/Z+xx
X-Google-Smtp-Source: AGHT+IGHHR3z6NCHjyX+XiOKl/kWdTtfqLBERiOZmIaurHsXvTd55vBVSDRbXWSH5jeIbwqHeiu2mA==
X-Received: by 2002:a05:6a00:e1b:b0:736:b3cb:5db with SMTP id
 d2e1a72fcca58-73e268ee7b6mr16526720b3a.11.1745684159410; 
 Sat, 26 Apr 2025 09:15:59 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912a93sm5174743b3a.16.2025.04.26.09.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Apr 2025 09:15:59 -0700 (PDT)
Date: Sat, 26 Apr 2025 09:11:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 02/13] net/sxe: add ethdev probe and remove
Message-ID: <20250426091156.2b31d841@hermes.local>
In-Reply-To: <20250425023652.37368-2-liujie5@linkdatatechnology.com>
References: <20250425023652.37368-1-liujie5@linkdatatechnology.com>
 <20250425023652.37368-2-liujie5@linkdatatechnology.com>
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

On Thu, 24 Apr 2025 19:36:41 -0700
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> diff --git a/drivers/net/sxe/Makefile b/drivers/net/sxe/Makefile
> new file mode 100644
> index 0000000000..3d4e6f0a1c
> --- /dev/null
> +++ b/drivers/net/sxe/Makefile
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2010-2016 Intel Corporation
> +
> +include $(RTE_SDK)/mk/rte.vars.mk
> +
> +#
> +# library name
> +#
> +LIB = librte_pmd_sxe.a
> +
> +CFLAGS += -DALLOW_EXPERIMENTAL_API
> +CFLAGS += -DSXE_DPDK
> +CFLAGS += -DSXE_HOST_DRIVER
> +CFLAGS += -O3
> +CFLAGS += $(WERROR_FLAGS)
> +
> +EXPORT_MAP := rte_pmd_sxe_version.map
> +

NAK
No Makefile's in current DPDK
