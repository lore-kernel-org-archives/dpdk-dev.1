Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5436CC282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 21:43:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 125DD40674;
	Mon, 10 Mar 2025 22:43:17 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 37F5940664
 for <dev@dpdk.org>; Mon, 10 Mar 2025 22:43:14 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2fea8d8c322so9394400a91.2
 for <dev@dpdk.org>; Mon, 10 Mar 2025 14:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741642993;
 x=1742247793; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KpQK7iA5KgGoS0LfAIZmFEWI+EGA9LdApxU7RC1UHUE=;
 b=tzaPIekkzsajRw/4tGKTwC6+0GlDPGeOrISExtP+GcgK27x9HhrvYsXf9FC5tddf/f
 0UKGUNbLM0swdAKGMFF3pHTfll2BSyvoQQmsAaMwGtOXW8L3UO1b3r9vPp3axcGuUgr9
 u8i9Y661kK+sAogrGNqfYrMjCzybUF+uz+ddKpHE5daDDZUT3zp4ufEqCSiMHedKROE7
 h4CuE9WHH8N7jL+qe8uC4jW5psAztOM28ExKOlQ3Ajzs9ylT5HmYBqOi14A2s0hAZbjA
 jWlOkuzmz92ztYT9TLG0700ZqkjIEnTLcHFmJDK6QePV4RA9tL3GOQ65oZY7QxGIkaVh
 rk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741642993; x=1742247793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KpQK7iA5KgGoS0LfAIZmFEWI+EGA9LdApxU7RC1UHUE=;
 b=DBwPkPVMcQZg6yMcUuModn3HLsJV4v/pKr1D5B6q3XKmhyynKdGQ7iFL2C7rkVcKn3
 X21A3igoIUAwILvdbKP6+kh5pjukPsjQOPtQIERojynxG5vi2VA480jESR4cWcSb3JFk
 aMF+aaNsR3vb3k1ZsxHiT/16KcSOAA9K17edJAtCTrjiGDFsmi7bIbh06biBOqVxzCIm
 HV7RghmVE+wf0o0JSm3VArYufIw05pIkiddIGTpyB8d5GSa4vzO+aMDfK+wCtB5cWTE1
 maTL1vt1v9/auz62l6TztTfJXysb9rYNiW/ZFP3G/kwe1970N1vjHo44lbhzjaDp9qp2
 v68A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXe5GA2BBmaXFV2Yyk56lPgk9ty0IwmTYgURpAVnd0SglADmKj+FwpeJfcC6pjPQw3zUk=@dpdk.org
X-Gm-Message-State: AOJu0Yx8NV56+791/snrmRwgdroD4o+CRXQw30jbxJGGzIxGM4YBs5RR
 TJGaaoirDwPU816V4nOrD+uvJP6ft+2DtlN1pNmvNRxZNWBUrI0McvlV6iTriDo=
X-Gm-Gg: ASbGncsa8saQzucwId6r3L5AR+gcmknAhXRRlgJ1xv8L6t4DD403LcgGimbWh5zjx8o
 fYsrzkNGZAJeGKEKTT3OTT7eQCRHktzwy+Y/YenL3nvdQ2c+bLMsIPgac/L7vGGg/lZkURAdIBj
 PO/hXpYZFybnAbNIaBM/dvidumdV2T9y++nJ9MBUOSCcywFDPZEkBwpsQjN6aiMOw8wuEGk/Yw0
 0+kbPuy1EnYzNucdvzsnRTsSj1RO2nu8c1TcbSgI95JkhU2kQjZf9rAGS5aWRTE0lhSax9DM/ep
 PVHDW1g0Y65DvNaEiaf+MLCClwc+ZgJarA+owZ4BwasVcBlilE/etdDijtobLv9rpfGGFKqTE1n
 BFpe4BeoDcW5cQRAV8CzPZg==
X-Google-Smtp-Source: AGHT+IGF/Z+aH7uHTQ9ZfmMW+JeubutBhZFJ69MOCmcFkwO8/MLQBktvRzZ+CizaWB+oRrDoflZlYQ==
X-Received: by 2002:a17:90b:2fc5:b0:2ee:fa0c:cebc with SMTP id
 98e67ed59e1d1-2ff7ce949d2mr23928600a91.20.1741642993271; 
 Mon, 10 Mar 2025 14:43:13 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109de24asm83496645ad.30.2025.03.10.14.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 14:43:13 -0700 (PDT)
Date: Mon, 10 Mar 2025 14:43:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yang Ming <ming.1.yang@nokia-sbell.com>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] eal/linux: enhance ASLR verification
Message-ID: <20250310144310.70ba71e6@hermes.local>
In-Reply-To: <20250228094405.1437-1-ming.1.yang@nokia-sbell.com>
References: <20250228094405.1437-1-ming.1.yang@nokia-sbell.com>
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

On Fri, 28 Feb 2025 17:44:04 +0800
Yang Ming <ming.1.yang@nokia-sbell.com> wrote:

> This change ensures that the current process is checked for
> being run with 'setarch' before verifying the value of
> '/proc/sys/kernel/randomize_va_space'. The '-R' or
> '--addr-no-randomize' parameter of the 'setarch' command is used
> to disable the randomization of the virtual address space.
> 
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>

Looks good, I wonder if the personality() check can supersede the need
to reference sysfs here?
