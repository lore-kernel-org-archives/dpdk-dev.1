Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A95CCFA00
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 16:37:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B7674028D;
	Fri, 31 Oct 2025 17:37:16 +0100 (CET)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 9E53F40150
 for <dev@dpdk.org>; Fri, 31 Oct 2025 17:37:14 +0100 (CET)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-7a2754a7f6aso3268142b3a.1
 for <dev@dpdk.org>; Fri, 31 Oct 2025 09:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761928633;
 x=1762533433; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=En4BIQ7FJYM6JqiJcJMxih33DkYp9y4t5a1GSCQnqkE=;
 b=EOQsq+NSUzbJ2ZtW39NDGtOUYSM0kzmaZ75yxV0GYnf5T6wJqxvp5XAoY3K8vur443
 quhWQsDIQHHonDEHKQkkz4rtomrOJD3OiVeMF4pzOSRhWuEP50H2cW3+swdURLYp8e6I
 FJZyEfwDT6LXe56ltiZ+WugWJIBnV5dlTLAO2Q6G3M/DXNjGv0Soiza8Z8lsETKzaqbS
 1K5MzZENfCe0CdES+myY5cfM/lcOJGxj5jphFi/cdc4Veye6jaQJDnGS1kGPvPPtwSCh
 GrmLmPKOWsy0IvYbMpBWIV1iIIEjwWXiV2NrAKi5AJXRu0KwyPFhrdGncTRmmbpZnkF4
 IUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761928633; x=1762533433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=En4BIQ7FJYM6JqiJcJMxih33DkYp9y4t5a1GSCQnqkE=;
 b=QTECrzDFfN68jjRjnoF6/CoqdhGiVQGEGb4/VgzVIgQmG7dy26S5By4GxjrfKIt9O7
 vFi6LPwiFm67Hq1hAQt/KrsUwNj7+I4LkDqmcEpPBm+fbvFMs56pXLNCXvK/dpZ3qRZJ
 1rB4kbk+NW5gtjL3OmPmNdEqCERzWbb9aenvS83to90KB/Et1Ek3+1V972Gk5WktjiiS
 f3CG9XqE6UBJUAYRXdGSoDB5OPoqRkEP4kDia8h3Cs7fAF9jpkQCFk0KNfN6PQfljjvK
 Jbid1fByVVbLn2LWW6iQGmEPvpwfJWJYvp2IjZT2w1Ws71pW+LxDApMuDUalVLQeVN7R
 G5Fw==
X-Gm-Message-State: AOJu0YyKTgAPwBEu7xGEd5SOBA879+1I4nJBuk2OllhWgZgDQQUkMEjM
 X6c5KIIlnqc4rCjFFgTkZsACpiaPDs8SU1s1MvjeV60huBYK/H8vQqCzzLOdiKOSHmyPqaoKGx6
 bNSo5
X-Gm-Gg: ASbGncs6OlKqUsXFB0aFSje1Ei7Zkf0jTbJpVSOeo+5Bu4HqiaWWt0jPystX/Z1NxmP
 HvNwQgImNbF0/41a7AZNYetBcXeOT+R0EMwnhG+nzGXMTb3+lFidCSmFPC7KX9gjEXq8I2kuhlO
 20BqKS6qHhF7sJ41L8TMoB5mWIqilSU8GqUYfl4EPoTxv59QRYcRzbd4cgsM/Fa0D/dQtl8Rf25
 TVSBUaPZ/ZZ63gxs3vWxKx3nxWopiDySD6Bfkrvql7yKjtXP6ql3au8ufnKXCRI8qx62NRDlJUN
 VzWGREWEefQ2/zulpNul4LLw5WgaZI0BlZmUxnWN9NEP4R4B1zpyszhtP/yEkuTpVpcQ7qoNffa
 EPao64k/jB+WO78sGhNZyTFR9Ox5mTYNkcD4FH5hB2iBEFlzfOAod3TZP301xtGbFJ9L+IpPQII
 USnRicKqGLYWEcS4loqqA1EY184VvQbT4PzR2LiANJf7He2ahGol4sosA=
X-Google-Smtp-Source: AGHT+IFu5cflznSX7iyYLpA0QZkyew6IHMm16PfYiF5ASOum7Zywl1hLslDsYGJ4+2nh2CLfb4dEhg==
X-Received: by 2002:a17:902:d2cc:b0:294:fd3c:6de2 with SMTP id
 d9443c01a7336-2951a39059cmr52561385ad.12.1761928633405; 
 Fri, 31 Oct 2025 09:37:13 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-295268b5522sm28761485ad.37.2025.10.31.09.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 09:37:13 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:37:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH 0/5] bpf enhancements
Message-ID: <20251031093708.238779c0@phoenix>
In-Reply-To: <c3c399ee3970498a87526af848920df0@huawei.com>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <c3c399ee3970498a87526af848920df0@huawei.com>
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

On Fri, 31 Oct 2025 11:39:54 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> > -----Original Message-----
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > Sent: Thursday 30 October 2025 17:34
> > To: dev@dpdk.org
> > Cc: Stephen Hemminger <stephen@networkplumber.org>
> > Subject: [PATCH 0/5] bpf enhancements
> > 
> > This is a series of fixes and tests for BPF functionality.
> > The new tests for Tx and Rx filtering require the infrastructure
> > to build a bpf program (clang) and the tool to convert object
> > file to header (xxd). If missing the test will get skipped.  
> 
> Thank you for doing this, I will try to have a look next week.
> 
> About the overall approach to getting the BPF object file, I understand the clang part, but do we really need to convert object files to headers and then write them back? Could we just pass these object files around as test resources instead? Not that xxd was not present in most systems, but looks like extra work and complexity.

The problem is that it is hard to determine file location paths when functional test is run.
The test needs to not reference the build directory structure. And installing objects somewhere in build
requires more steps in meson. This was the easiest way which is what the cfgfiles test was already doing.
