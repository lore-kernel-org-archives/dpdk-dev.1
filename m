Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841D9F53D65
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 15:24:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B1684025E;
	Mon, 16 Mar 2026 16:24:04 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id A9869400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 16:24:03 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2b0603ee486so4024075ad.0
 for <dev@dpdk.org>; Mon, 16 Mar 2026 08:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773674643;
 x=1774279443; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MdEUZz5g5z6dhD406Jh43NV4AeUIuvYYZKfO7F07zYQ=;
 b=HCa71Tdm6N8+f6s3J4aUjPLsMOC7lzt7FdUNEYr5YyIYuNvo3QX9kHj9WdXvTLPcxW
 hByPyxFF6yrKvJtCsv69nu+Ziix5NBg5K+7rEeBlFxPNabfd1HR7hav5bvjqQtrMhZCM
 +zXmiWMQw2Mr0qIjCQWBTJ4/HAwmmMblBaIIkvEXbfFetDHzDQX5WitxotwXsTydVcT1
 6h9mx+iRfD5UlSdNAX5kY+AG4AIuGYutr5BjNvQ+Ld1vdVouRagVMfi1prqml81F32zZ
 FAajokOA+yQkW7JdEjtTBd7r4cyCxg4t4otlalSS/BY9TYaq4TLp3ri0V2AY7Y2mrkR/
 4RTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773674643; x=1774279443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MdEUZz5g5z6dhD406Jh43NV4AeUIuvYYZKfO7F07zYQ=;
 b=hW0DY5QsPfZAFOU3+51vUpDfVvEVWyt4PXG63kE0OB3yek/5Q0pioRD0xM814aNFO/
 h6VZ7b4DI7YuzE3MOdC90ZZjy1IfjwoPWuCvUUaHTaMs72Xv8PAYO0Awtg8EEDlaAmKL
 cLcvJyNb+ckHKgt2m1YsRWB4IdsvMcsLDwOix+rm1P/AYt1oLuINtNKXUNcwU9J8mbgv
 wfN0GqYwq2kBfE09mDxfqA0x+4XxWKDEYcM0ocHb0NXwIcJtag6szlOtDoKsQ2SG7tZK
 LEV7BoFTLVcsqsUbj9a3SKJW2iLsqQ6bIa0vqMxcMyt6+5/LFfs3ErhPytyPf8sMBmMu
 QEyg==
X-Gm-Message-State: AOJu0YyO3ywu49fPuoSw5gp6N7UoDwjj6G50rCuyf3CctLgsLEEs3Ate
 6r09ro+aYt8zhGXwIfET/ZU5fXVF+bL6bbh7zOBTEBBhytX7g41UirN6aCIZmwi4la30WjdtSf/
 RpO9V
X-Gm-Gg: ATEYQzysffdaN1kPSpGbX42bVNmcKDhcYlIAe3jh0S+YsqAOnBzlkfL3DcszZviqdfv
 X8CHwNmATj1G3sQUpl0JV6VrZAuTAXuVoRFakhUU/n+kqewKBgdRRBM8+FsysqTO6Mbr1AnET1c
 LEXt94vOCkH/Hpub2+HSGfgLaSmESCBpiNHsyR5BUzH018LURCCNhPMSaCxDYCJUbPnkG8s7Z7Q
 Q3+9vaor8lLMc3+BmhnQYvF9UIE6xG4nnhl0xHaW9SA7w1ZBMPMYVLiSBI4iNKocz0AQJFyckaN
 yAibthHicTjn0uOsRPyx2uEq0y32HOJzGoaEx9Z5rouWiJi/3CYYSig13Ijds2M5aPN6J2ogj/D
 92SyVgWtlLv2/A5yD8Zgeic+9ajhY/a+jXg7heDdpvVdzX9RsAWPV056cKOAAS32bNSmoK2Nkfy
 LMWKfCJWox28/RTiq5eMy+ZYCHESOL8p1a8HM=
X-Received: by 2002:a17:903:2412:b0:2ae:5848:bada with SMTP id
 d9443c01a7336-2aeca967d8emr134956995ad.10.1773674642579; 
 Mon, 16 Mar 2026 08:24:02 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece809586sm104720145ad.63.2026.03.16.08.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 08:24:02 -0700 (PDT)
Date: Mon, 16 Mar 2026 08:23:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH v20 17/25] net/pcap: avoid use of volatile
Message-ID: <20260316082355.7fd41066@phoenix.local>
In-Reply-To: <abgUT5fN_mWeW6mZ@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-18-stephen@networkplumber.org>
 <abgUT5fN_mWeW6mZ@bricha3-mobl1.ger.corp.intel.com>
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

On Mon, 16 Mar 2026 14:31:43 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Tue, Mar 10, 2026 at 09:09:55AM -0700, Stephen Hemminger wrote:
> > Using volatile for statistics is not necessary since only one
> > thread is allowed to operate on a queue at a time.
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---  
> 
> Well only one queue is allowed to change them, but other threads could read
> them, so using volatile is correct in that it tells the compiler not to
> cache the values in registers or on the stack. Technically the compiler
> could have the stats stored locally somewhere between updates, but in
> practice I don't think that situation could ever arise for stats. Therefore
> I'm ok with stats being either volatile or not, I doubt the resulting code
> will be any different.
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>


I went back and forth on this. The compiler unless statically linked
with LTO has no chance or seeing across calls.

The other option would be relaxed atomics would also solve
the torn 32 bit counter roll over problem on 32 bit CPU's.
