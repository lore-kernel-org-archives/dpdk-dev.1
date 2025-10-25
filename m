Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BBFCCF9E9
	for <dpdk-dev@archiver.kernel.org>; Sat, 25 Oct 2025 18:35:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA81D40151;
	Sat, 25 Oct 2025 20:35:11 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 45D9D4003C
 for <dev@dpdk.org>; Sat, 25 Oct 2025 20:35:11 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-28e7cd6dbc0so40557385ad.0
 for <dev@dpdk.org>; Sat, 25 Oct 2025 11:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761417310;
 x=1762022110; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EHqhF7KEGC4CguoOeKiKG+AQlr9lD2/+HKMAFLoGsag=;
 b=nRAXP+QaY/8UzD64zKbzmSx2h50iY+Y+o2G0dtseQbCq13kM1YSgLGw60OYVxCZy8x
 /eL4s0Rvs/UYXNgjFo49Ry3YeQOpTj/XfZKSx9qSNQ99FaAR1I7HgE37G8gy+UYbxPlD
 kNI9IpjYkRX3QfrYaQKaB2b19WcrpyHhZuEKyxcT8hDXb8EgSQ6SqWvhEe1u7SLUzG1W
 TA2vIOsCLkkkP842YOOf9NbCIRn2n9l8Joy76c5FuPv//V+LaOJBUnqIXVqLkfJXq7x+
 11KYdBg6p48f5Ayr/HeFEykx1IQqeGCtQ8+g/NnZQMdorgKz7TEEpvtHYAkebXsPQ1xm
 YZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761417310; x=1762022110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EHqhF7KEGC4CguoOeKiKG+AQlr9lD2/+HKMAFLoGsag=;
 b=XeQkW5sKK3zjStG1PAQFHJzYXC2Y8AgOJsRAYqHVIfRi34gKq2mMhxqh1uPr4qJ8uk
 qNNcOoCwOtPgMu/69Esmz8M/a3NgdEgjcOlJuNow6VAQB7bLWAhXX8nXoYsH4aglhhtS
 Ik7TpCh8pobUkPYniRH+wVmj9nQNE+alROX8T3NYyTvenWIZYcrmFdA9PXGzkqe73/Wv
 8AJKgk66PRl15hT6ruz7FZpQ3YocXPemmFLINLsEerlhR59Oqj5i+FV1Cb33hYA8mCdb
 Dv7qeGNqV85FOF3BTR3IHS9fmXIPSDoLQn+BdekiPkkQ5UP5d51ESIG+z+UMxtr4q2NY
 uKxQ==
X-Gm-Message-State: AOJu0YxByfzHrt8+WWiKBSrsV7DSNTi/vezvUGfcc0Ye2CmDb13vh3JR
 muM58RwO6yMl7pUbBltUgk7SHG13IwFH/WRfilQCQQmwQdzVYfEPKQ9ZqvHoXgZr433uCbaVlWl
 38JdT
X-Gm-Gg: ASbGnctnLLyVgaVqDpmgZiXFTBvpUDrJ19coGL/AzPyLY17lPCY6T+rcPfCAxBFcPtx
 mzULWi/bFNmQXKf+qBYaSfVZLZjPjWWMN83xwDDhOBadkDr0hmKpVaLxFxczIIIbkza58cF2hPp
 5b+Ffov5W22NJjzxOt+9qim7jgmnc2XIPRAiNME2nZaR1r8XQk7iAhkdCFN5CBApE0hqsjPogG0
 SirvYtzLc5Nfm3YKZmDN+6Cru3hyWnEasd118fuvsCFoO+jkzRbCDZP66Ble6NnHPNEZnI+VDVX
 uJhxbcHCoLpWVS1rK/uchKFXshptTRXiQImtz/lfTj2sjCgzpiVgwdqNx6/WYeha3jDbfnnD9vi
 uZuFXbIQV08cYU9f/LBElpiMaGS9RSSnZd+acqUQRZFrvwNRDJSApeOjoe3yOwHVXxAQJTFo0PS
 /olEJ6vG8Xa9IYa02Z4B17zTNCtaZieAfE9Q==
X-Google-Smtp-Source: AGHT+IG9ehPIS/IaJATP4Q1WnMjvgqjq2EwMNDXOU86ZkZiBFE0/QWng0qoivyU4Eejzfi7lia3RMA==
X-Received: by 2002:a17:902:d503:b0:275:b1cf:6ddc with SMTP id
 d9443c01a7336-2948b95c714mr79839085ad.5.1761417310377; 
 Sat, 25 Oct 2025 11:35:10 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b7127bf6accsm2721862a12.14.2025.10.25.11.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Oct 2025 11:35:10 -0700 (PDT)
Date: Sat, 25 Oct 2025 11:35:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v12 01/13] net/sxe: add base driver directory and doc
Message-ID: <20251025113508.2826bdb3@phoenix>
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

Drivers need to have all global symbols prefixed consistently to avoid
conflicts when DPDK is statically linked.

This driver has some work left:

.../sxe/build/drivers $ nm librte_net_sxe.a | grep ' [TDB] ' | grep -v ' sxe' | grep -v '__sxe' | grep -v 'rte_pmd_sxe_'
0000000000000000 B g_log_filename
0000000000000108 B is_log_created
00000000000002a0 T is_sxe_supported
0000000000000000 D def_txq_ops
0000000000000000 D mac_regs
0000000000000000 B dump_regs
