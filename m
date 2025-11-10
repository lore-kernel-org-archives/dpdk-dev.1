Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BC7CCFA13
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 17:07:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D3EA4026D;
	Mon, 10 Nov 2025 18:07:37 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 7750E40264
 for <dev@dpdk.org>; Mon, 10 Nov 2025 18:07:35 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-340c39ee02dso2669651a91.1
 for <dev@dpdk.org>; Mon, 10 Nov 2025 09:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762794454;
 x=1763399254; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NRGhyzz6XRd22b0Uml2EKQRiE1w35RWIBIbsvueDhxY=;
 b=Sf1gLz1NpgJS0KtFLkawPvuS4VW3Dbe+Io/28gZHQMbL8M1pYd1IUR3G3heV3tXBmv
 zHtH4JbyTr+pHAmraKsm4CxKvYCyz8Bp+dTuFSPJXv7G81HIQNSqPaOoBFT8qytQtyj0
 2Hm3ldHAyaKm5TdrLsJDuu/Tb/zKqZxC/pmHFpQetEeF4q1kPaK1gRIEKiaA5VNTLguc
 hywdckzztwD5+iC+Ig9jtl+IBTLmC9mrk8keeCKSwvwUOkzuvixwErdOWU0fRU0Bt9na
 V94pKEMvxRTLBTUO5Powvh7Ra06Wk1X5eShWY3p0DwS3k/bcjUXxKpL7PG4ZzwWgAmCk
 +2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762794454; x=1763399254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NRGhyzz6XRd22b0Uml2EKQRiE1w35RWIBIbsvueDhxY=;
 b=wpwBnPSQxqzOcQrnqVdzQH69Xu+1EjIrqe6acwaDraGbTXVe5RwSgCL/BWAPtKrz47
 ZmciZq7hRhI9RlBvAJl/3qX+DiwQ7VmnMjTZa+glxPhcLMClry7pI//gs194xDim9wDm
 izdJ3vwWQPVNBEsGWJXW8Wvc4B4OJakPDuG+rE/FFQ5X65bDGfafFrY2jc8NgzRZF2aD
 P5tpa+WbduOr1a79CL42a2KOEPnaH9/SdiKzzYKrQUIUFT9DKESSJdZgV74oxvcognil
 h5Q6PHnZWBbw5hF+BpcNAbetVqmW2mt7/fTPvoCtNfKay/XQ2Bhe1SvwVErJNM74FxPE
 I6Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYsdZuRknrJagF6TZiLg5gUaoHwuNS/bv3SUf4qVWtCXbznmmex+lVkOFyQAJpH7WiWiE=@dpdk.org
X-Gm-Message-State: AOJu0Yzsxtl5Wv22TuQO0Qlb/3p9l91qeKsMsuWamKA0oUgu6RTL7T5b
 Tl+4lqbBX7IGMWVt58RgUC+16Geo8Lw7CqbgpwB2g+Uo4gKBXjjIZOtGuGVRM5FwKIY=
X-Gm-Gg: ASbGncvSAOkxYY1wi8Hre6rOjplNNgtFso6DnxsSh1ZA9jylp7Vy3Ld7iL6e8fJyCQP
 HMCYeaHQsbJEcD8bZjfxLxTmK9bIqVORucdReqtqX2TqeErZ26jJcytALwZK8zZ152HOfX7owYo
 2sRBs16G5sS8nb7c2HgUZ1UQiStaFpKmJeEwymoMfQISpiXb/7eEmheZ31l5BpfLOXASb3YCNK0
 FY7DEoZM8CekRu6Am8ThfOPpfiIO/jfRfwslEZ5xms7uI89brRZe8PAix6VjfSLqq8xHwJic0KX
 h7+Gil/YZ5rJPyQh4zqLydTrNMjmZf4sFbjtCqsI828T7C1AYMPWnCTJ+Vo7ySWtjemG/0Op4AS
 kGRMzsKDa3JUhAQNG3HkclhFJp24jui/Jf1/ml2xeIhMblI7pT95+7jokEsQaN9GsIiAyTGu6/e
 ps4c/W0epEgk4uqHHsFCSNbGzmhK/Wm1I8/g==
X-Google-Smtp-Source: AGHT+IEc4pBbQP2M/NMXGVz5+LKPd0nwTE47WPUym+YqnfmYneS0c8TJ2OhL13N+/ty6e6kENvLNqw==
X-Received: by 2002:a17:90a:ec84:b0:32b:9506:1780 with SMTP id
 98e67ed59e1d1-3436cb93152mr13127186a91.9.1762794454464; 
 Mon, 10 Nov 2025 09:07:34 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3434c344838sm11550691a91.15.2025.11.10.09.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 09:07:34 -0800 (PST)
Date: Mon, 10 Nov 2025 09:07:30 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [PATCH v5 3/5] bpf: add a test for BPF ELF load
Message-ID: <20251110090730.098cf34f@phoenix>
In-Reply-To: <34f3ae46b0744bcea63bd4031cb8d4a5@huawei.com>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251109200854.45942-1-stephen@networkplumber.org>
 <20251109200854.45942-4-stephen@networkplumber.org>
 <34f3ae46b0744bcea63bd4031cb8d4a5@huawei.com>
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

On Mon, 10 Nov 2025 16:38:08 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> > +xxd = find_program('xxd', required: false)
> > +if not xxd.found()
> > +    message('app/test_bpf: missing xxd required to convert object to array')
> > +    subdir_done()
> > +endif
> > +
> > +# BPF compiler flags
> > +bpf_cflags = [ '-O2', '-target', 'bpf', '-g', '-c']
> > +
> > +# Enable test in test_bpf.c
> > +cflags += '-DTEST_BPF_ELF_LOAD'  
> 
> Sorry for not noticing it earlier, we probably want these tests depend on 
> RTE_LIBRTE_BPF_ELF, otherwise they fail when libelf is not installed.

I tested without elf and it build ok.

> // snip
> 
> > +static int
> > +test_bpf_elf_load(void)
> > +{
> > +	static const char test_section[] = "call1";
> > +	uint8_t tbuf[sizeof(struct dummy_vect8)];  
> 
> I still think alignment may become an issue here.

On x86 alignment doesn't matter. But would be better to use
a union to be safe.
