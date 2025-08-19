Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5FDCA0EEB
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 17:46:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BADD402E4;
	Tue, 19 Aug 2025 19:46:13 +0200 (CEST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 7EBD7402C9
 for <dev@dpdk.org>; Tue, 19 Aug 2025 19:46:11 +0200 (CEST)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-45a1b001f55so26387705e9.0
 for <dev@dpdk.org>; Tue, 19 Aug 2025 10:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755625571;
 x=1756230371; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l7ib5sIn5C7N21T4GqhlcXNt8KJCW1kcRyKC2acH1X8=;
 b=aUDzPCYV5AiogasBvPt2gPFUWl6oWlp5Cr/tmSfmUuboCbrrm9z1GQzVQ8ImrQ4NPb
 8Jn1pvz/w7xwpnL6cTcES+CQBLR0/IpYSitGY/i0nHAEsFB31cIgw2op3OpZR8dlHIuu
 aVtIlB3e/y8Q5dwehgXtMf7WRii4ra74gMlvPctt2vJ5efxf1lI+V5mLZPyPW9DbYTts
 9tcRjshQyhy+F/GpYfufBi59wL4Tjknu5GmV0v8mSyXLorPEuvyy4nM//IttX/BYi9nD
 sQlmMIQIeyQdhT4ynETyYcsBMDXeiqsV75SrOh/h4iNrIw4g7eifO54epmDWq792oo+S
 FjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755625571; x=1756230371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l7ib5sIn5C7N21T4GqhlcXNt8KJCW1kcRyKC2acH1X8=;
 b=Iq2eIAp25wuAl7iFw9s4NxNU5C6B34bP09N33m3t84wd358WTEmjdFAImr1Dk6HM2K
 2tFG7tBj/mdqQ5NvQf9eZDyl5mtK7bb2tFmE/qqvO4JBoD3rYbURFOEBbBYwi3s3I+Wf
 s7UfVz8AGrwO7i+HOjJ+qEYgvP5aSGIxBaWdzU50hmJmCNhUntjLn/i0eY5ABOfZjJaj
 RSMybb5+/aPmwII9qm0NsRpSsqkFE7Jb78FCPyJ9XwIPJVGMvo06ToEJoMrd7iEaRaTe
 GVAWCd+aKha6fkKERjh1UHYXbGqOyzWTcVYadrjkLecbkGo7JnD81i7Z9rVc8UxoJb8A
 dFcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm02K+GtNTheN6AkhL/8CrvJEhsfGlum9gG6gPM3AzuMyGissU55Ac41VDgpohxZFYDI8=@dpdk.org
X-Gm-Message-State: AOJu0YzpT8dEISJPgsapr/b4J3Rk8aDPnm5nukZxXpi91CAe8qvePsrV
 TLUmrqP/Km55JlbXAt7mtxhgmRuQxB3vtTzq+/R9Q2CvSz4D8ySpMzPvozPb4N5agj8=
X-Gm-Gg: ASbGncvu4Q7Rs9k7AfnJvucyWx+nxSG1wXriVqq+zEfH6Ou8SeQemJ7n0j30p7G3Swg
 tJ2jtvvqZEp5dw/pugTk9rMvDXcawGeznsB0KXxhWX69G7rq27hqNybUb4OXycaFwTjC/2J21rL
 gYMets5NRZxVkJ1QpKoHqLRgy15aOuEYA0eoWfjsHkGJQWkFSjTB1poDxpEEcHp9v3Sg8hNe2wf
 zPIBpTC/5MWIuF3ZINvZrDQHTuvTcBtuBhATVl3jYKLH3/C+nBXKIFRgz4P16K8B1zDBSJnmFXN
 hFbisoNkSZ1pi1ei33FftjHYCekoLg7Q84YLzZtA4VN0ZabUHAIDIe33Q6TtuoJvQJBV84XcXQi
 UFFe6URrQbAA/9Cg3GntB/j8qiuYSr3YMtnTtBnH2H7y4Qu7r7DeiYw2jogcCId8cNbzQ66bB8G
 Y=
X-Google-Smtp-Source: AGHT+IG0zi/kEL2RUZmTCCg/67cK9burGiZueA31HTxBb1ESPisXUoesMLkTlO3e/Nugku3JehZ4aw==
X-Received: by 2002:a05:600c:3555:b0:458:a850:f857 with SMTP id
 5b1f17b1804b1-45b43e1b711mr30671255e9.31.1755625570961; 
 Tue, 19 Aug 2025 10:46:10 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b42d7c187sm45426055e9.14.2025.08.19.10.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 10:46:10 -0700 (PDT)
Date: Tue, 19 Aug 2025 10:46:06 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, <dev@dpdk.org>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
Subject: Re: [RFC 01/47] eal: add BSD version of queue.h
Message-ID: <20250819104606.05ce3f92@hermes.local>
In-Reply-To: <aKShQNPf9lmRtOnf@bricha3-mobl1.ger.corp.intel.com>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <2598643.Sgy9Pd6rRy@thomas> <20250819082444.66718343@hermes.local>
 <2710899.tIAgqjz4sF@thomas>
 <aKSa7Hjb-UIh-4Ak@bricha3-mobl1.ger.corp.intel.com>
 <20250819090341.0ce15d26@hermes.local>
 <aKShQNPf9lmRtOnf@bricha3-mobl1.ger.corp.intel.com>
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

On Tue, 19 Aug 2025 17:07:28 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> > > I think we should define two defines for our header, and warn if
> > > sys/queue.h is included first.
> > > 
> > > #ifndef _RTE_BSD_QUEUE_H_
> > > #ifdef _SYS_QUEUE_H_
> > > #warning ...
> > > #endif
> > > 
> > > #define _RTE_BSD_QUEUE_H_
> > > #define _SYS_QUEUE_H_
> > > 
> > > ...
> > > 
> > > #endif

Tried that and won't work right since we want to put header
in first patch and not break build of unchanged drivers etc.
It will work after the whole patch series when <sys/queue.h> is gone.
