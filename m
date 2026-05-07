Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5CCCD343F
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 16:09:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69C014027E;
	Thu,  7 May 2026 18:09:29 +0200 (CEST)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id 8D9BA4026A
 for <dev@dpdk.org>; Thu,  7 May 2026 18:09:27 +0200 (CEST)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-130c9dcbd25so1914692c88.1
 for <dev@dpdk.org>; Thu, 07 May 2026 09:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778170166;
 x=1778774966; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rpkF8qp0/wYVuVUrI+DA5GaSPZHxQj1Hj4uAVKXo3pw=;
 b=T1x6BYnVoweHq3c3nCb8TKfnZzNBb0QcFWibTN6fnJnLLFgnJPoKPhGxKuqzzbbNkh
 C0yIfiHc1xMyvrHji/pCvUD4QfOrsviwBEOTWc2gh7xUII9gdKHrjLEGW9kzr1CIE0MF
 PgS03WCddb9Orv+V6nesBKju1VM5GXPq792Z3VuZ9/d9OGXqHlVuYI4P9WtoChnDDXgn
 L1iAmGc8uB+kiEsZrDLzyMl2/xu15mo5QHYozUaJb/FfZzS77qotAAREuCqYnvAkJgT+
 U/mKrM0BhQ5urQH8eZTP4v5NlHbM4rkPa6/pfjcbdHLhXlfdSP8uRweJZWxU/KPqz1pT
 Uucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778170166; x=1778774966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rpkF8qp0/wYVuVUrI+DA5GaSPZHxQj1Hj4uAVKXo3pw=;
 b=K2M8ZMRgovBUdk/g/E5DY1KzSzvv8FGqA6CdOzAqYbNf9VP3sGSZCJdCKulMJiewws
 N3G1HtbXbQNDgpROAyIujJYXr5IDhZ86P03+65CORSavb2HPTbi1wvOhM4fdimIygPPS
 Lu6uQ4i/nUaB3tmWAvb66RURIHQdQl4gCgCYMq0qFty5V2aeXxuxxeCrMJGqwuT+oOYk
 y54oPeSO2lxf/fduHecGA+VK7f1sVBl3tC0cvd0sMVwHW62lopGMeCHQsL62RQW+IUFG
 Hx05xxt9P+6WNLtyw5KUhXlQKYDZ7yRCYdN11SWeE5a2VPor9/pv1dtoNbaAOElX1zdD
 20XA==
X-Gm-Message-State: AOJu0YwQRF73K9SwDSrgqsp5z6+z5HdH3owsj2LaCWYWmBdrF6EzhbRv
 3BnTl69wfT9P/whUojfT+g5W0Lz8yUkYsvDsWk/8vebB97dgvqAcwBe29/vPJzly61k=
X-Gm-Gg: AeBDiesd/K8jFbHr8RcF7/szE35R18CEo+N2sDAe0J9sEUo0fvYwdQoVubfEisGsREn
 4OE6keGGRvfaXuykexeyeNZQZki+URNUq6tCL+HBMqLYU/rK1y1nL9fZC2pW+4GBBFJf0IC7NQ4
 EYObtQahQl7NwogSWKONHq6xHzdGzOp6WS3jI6paqVdHnxxWi/JfXRvZZlleIyobcvWmCP5Pmnu
 uETXRXYuVW4xdCBKb9GtqHveo7FZqFE9WkpJ5N3Ab1T9E0pzGuz3T0nsQ7EJkr0WsgGb2xGeceg
 dpveWCXEhyfzRzr4jbdNuPmDopswR9gHWLEufmvMygDPxfnOLC7jw8CrC4YEsQX39kdNZH2OIYb
 9rjhgEmSI089yKMAlJ0JJZ8YBB4dip8jJd75nabBQx2STn1Gg1iurs3ISO8W9x2WtLPUPHCkKuw
 tHTgf1MDgVgJNLwIAC3rPYFjGXqyoPRHaPsAU92kKMbJdTMQ==
X-Received: by 2002:a05:7022:618e:b0:12c:11d4:61dd with SMTP id
 a92af1059eb24-1323b0ad346mr1652681c88.18.1778170166158; 
 Thu, 07 May 2026 09:09:26 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13202db27bfsm8408204c88.10.2026.05.07.09.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:09:25 -0700 (PDT)
Date: Thu, 7 May 2026 09:09:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
Subject: Re: [RFC v2 0/4] flow_compile: textual flow rule compiler
Message-ID: <20260507090923.0f8a620f@phoenix.local>
In-Reply-To: <afxJCBfkbui5clep@bricha3-mobl1.ger.corp.intel.com>
References: <20260505183917.370281-1-sismis@dyna-nic.com>
 <20260507001501.608724-1-stephen@networkplumber.org>
 <afxJCBfkbui5clep@bricha3-mobl1.ger.corp.intel.com>
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

On Thu, 7 May 2026 09:10:48 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> > 1. API shape.  pcap_compile-style (one string -> opaque object ->
> >    arrays) versus the three-call attr/pattern/actions form
> >    Sismis's v12 exposes.  What does your application actually
> >    want?
> >   
> 
> For this, I wonder if we also could do with a second API for the creation
> which takes a list of tokens rather than just a single string. Thinking
> about integration with testpmd, or with apps which already have some
> commandline interface which produces a list of tokens, having to re-stitch
> the tokens together into one string seems awkward.
> 
> Also, have you already investigated how this might be integrated into
> testpmd? Do we have the capability to pass multi-token strings via cmdline?

Lex pass does tokenizing in a way that is different than simple string split.
Could have a wrapper that takes list of tokens and quotes them back to
a string.

For testpmd integration.
 - the new compiler may intentionally diverge from existing adhoc
   parsing. The AI code generation already flagged a couple of these
   and put note in documentation.

 - testpmd (and probably cmdline) will need ability to not pass unparsed
   string, may need new cmdline type for "rest of line as string"

 - AI proposed new syntax:
    flow compile <port> "quote rule"
