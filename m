Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F2910D1485
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Mar 2026 21:51:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E29F74021F;
	Sat, 28 Mar 2026 22:51:54 +0100 (CET)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id 4F8C9400D6
 for <dev@dpdk.org>; Sat, 28 Mar 2026 22:51:53 +0100 (CET)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-12732165d1eso4785060c88.1
 for <dev@dpdk.org>; Sat, 28 Mar 2026 14:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774734712;
 x=1775339512; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b9eZLTq6gfCHD3O92i4MRe79tOuH89N5JtrVTRdY2eI=;
 b=tzigZKMB6vKv44lLXgjtDS8nylWJBJoxoosbfxQtRPZSNlMYcZtVYBmApF4yy+pHt9
 8AUBdoE+YHK1TXUCsZTsC+sxCkgmSA3wCcr9GqgIWsnGtiEljQljrl3RsHicQwUOO7eN
 VWTkEJ3jvu/q+6yv7WN9cIbpZ6s+UWUKijUBZWSE1nhEqg8c7M1FmzG84uYIZ6N2XEbB
 wJ00WSfesRZnW1NLF62Ta+j25NXBQL4m4/9NrBpZekrqN6WBXjpYosr4N0C6X/REAcqq
 fFWGii680uODzG+570HCjSwlToORaMWKnM0fY0Z8yjHsfePAi1oy+3TwtGKluEzrK5c+
 3l4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774734712; x=1775339512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b9eZLTq6gfCHD3O92i4MRe79tOuH89N5JtrVTRdY2eI=;
 b=EHKiwmx2EahzHfKe3xKZSvgtI8SLHyFkQ2amdaZrQBhXQ1YdDI34lKuf0MVtcG/7h2
 UYtzGvGthgdYtJ1djBpWENRn0KdziblZ/TZJ1mY0tOYbDPAxaulyLKdSCVgTI7xH9blx
 H1YwQp/J5ne/2qolXGGqbtK7xGEJVn57Wz96FdBgERWMJCELXDie/JyN+C7qh5qndtNv
 xypkHnAVHOFsjYwmxK2uPnKCQ85KxTChN75zs4LrD9sGGBYhsaUqgd4VLJdoLKaKSQDW
 R7vXwpzg5NCXoZpGzD3jtFLpMGZoaixDrZktfo1ZnEz/RrQ5qggHS+KxcVGlyqUM4s3o
 arTg==
X-Gm-Message-State: AOJu0Yw3DSBSm6Nv+w1K0AmK2LW2UDEH3OsET4jIP4b+o0Pz+f/pWTqn
 UCMRrXCvL/2JF5iyCfSnbibRMNV/ewEAaYV4nvOZiTjWpLTHWh7Wo+LE9lwmmGOD6ZA=
X-Gm-Gg: ATEYQzwsSX9tNxYmqdgNFzH6ICmjqXZ9Jn5hPqJUIiX69CcEKDVp1aGSEFuAAQLAm2i
 ORsWbhiOTXvujEdivWr/5/p6GKc5r3PGJXT9KtXi0vWQY6ti47llT1GzMktk8VvgE7HKvjJv+pn
 c7ZM0R+TkAlraHesbZgAl1T0ExWyp4Usz0tPUjgaRQlRL3T4x14kDvNZ6k3CjnVR4TH7Z5tl+x2
 J0rvjLeIqdj40Zd+9l6pDohTxR/pNLq7Jlu47+4b9MWiXQSlkOipIeWorl7hEKEOaWNj9DvSCjU
 QX97OP+I8W67B4RBkCatkCWkwOR+Xuvjy9bj2zbVZ7Dwp0JkSWlSNr9MbXjNwdZJBbUNRWQCELJ
 oxSaAGkIMKw5luC8/ZASKfboj9njdkkwuNQey7WEV27IQOviaPxRN7N6QMtW/pY9NIEtF5hEeV+
 8fgSkyJiYP/Miu0cMo28+PeZ5GsBfsdFguWpQ=
X-Received: by 2002:a05:7022:4582:b0:128:df80:1852 with SMTP id
 a92af1059eb24-12ab283c2e2mr4361987c88.9.1774734712009; 
 Sat, 28 Mar 2026 14:51:52 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12ab97efb42sm4353693c88.7.2026.03.28.14.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 14:51:51 -0700 (PDT)
Date: Sat, 28 Mar 2026 14:51:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH] test: parenthesize common macro arguments
Message-ID: <20260328145149.6e2c303e@phoenix.local>
In-Reply-To: <20260326174749.40972-1-marat.khalili@huawei.com>
References: <20260326174749.40972-1-marat.khalili@huawei.com>
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

On Thu, 26 Mar 2026 17:47:49 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> Parenthesize argument substitutions in macros commonly used by tests.
> 
> Without parentheses around arguments macros like TEST_ASSERT_SUCCESS
> could produce incorrect results if passed e.g. a ternary expression.
> 
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---
> Very curious how none of the code-checking tools we have like Coverity
> flagged this trivial issue.
> 
> To highlight non-whitespace changes: git show --word-diff --anchored='/*'

The bigger parts should be converted to functions.
This is test infrastructure no need for multi-line macros.
