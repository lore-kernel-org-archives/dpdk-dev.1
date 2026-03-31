Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7079510F9303
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 22:47:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B97440275;
	Wed,  1 Apr 2026 00:47:40 +0200 (CEST)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTP id 759C94026F
 for <dev@dpdk.org>; Wed,  1 Apr 2026 00:47:38 +0200 (CEST)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-127380532eeso453854c88.1
 for <dev@dpdk.org>; Tue, 31 Mar 2026 15:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774997257;
 x=1775602057; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1RQaGyjXLj9jzBUJ5ionTzG2UxZmfc7b8VRKGotkkjk=;
 b=GzuhzOJV9NTzunfRAwlmW8eFY84v8zJ7NtpK2jv1K05G8uGfxEhPwJ4pmJgY6UbmWd
 TLY74RFH1em0KWsYX30d1LJmPAMd3VrfjL72qHtlWVEJSBa80LEQ+WidLFkJV6Gf/dOq
 RLOpHOiEUDyrGpLtlUWNAf8GWlb24roNDQ52cQqGwdFr5EkGZOObOAsNt90SQSx/QmO8
 0K9qXNGVulljjM3v40QIvPpDM1cOKoNcJW3oQHa3hgH32hQMXMAJ5EjB2e2Tdhvq2XC0
 4x6f5XAcg34AJiQ4hr9KH/x/gTRVMULUodS6cblrVGmdzTi8eVI031qHvaNZt91PD3BX
 PlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774997257; x=1775602057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1RQaGyjXLj9jzBUJ5ionTzG2UxZmfc7b8VRKGotkkjk=;
 b=J3epoqmYBswaX1SynrH3RnlEWvYs9fTa97V1VBUPd5olvBAc0QbpP5itLcYCjsL6bg
 KmRUp2Y2ndP10LMKbLb6t97ovhq6w+MgDydjtsiL/53t1YQkXivZSa4EEI6r7ZCbNIDs
 NV0Kypk/iKJ1JAjmC3TMceGAjZyjFC49/TQjfJVOO77kCpDVYQZo5k3Hdr3TMtvrhaK7
 Rbxz13h2PtW4z+/BtdcKW2wv+NCJUxv77fi0PbKx7Z3NEzR0Qnpy5sg1xAZX8x+yWyY2
 re4577iSBQZIGC2efZHHPWmRf5141f/PfG+7ljCaSKPAoTK5C/ZUxjFxkd04BqcI+7Wg
 3hSA==
X-Gm-Message-State: AOJu0YyTDy+NrLXtGgvvjJ2AikRXE0roeGWzhLV2O1GwII+i2TmoWVJE
 QsilMnWwUt2whxW6HslHNkc+Uuu6Z99zsZJc7MtJBssWecgAt6KAwS2AEwILDuY8Iuc=
X-Gm-Gg: ATEYQzx3BhrtHCOFdILHqHhgol6sG7WH6Ss2WUXudui6f4Q5XAc0+5IYdz0cHjhz6Q0
 xh8/akunRgsyrp79bKM/ale9mIeogPU4jjpaSxRir/CbpeSx5rQMruldIwKK43siCvbVKcMNk+g
 z4NK9SzWDA4L91bQtck0oTL2VUGsNY4GCmLZAaAgjHm/KwnPbch8MU+eCx+/25uzMxhgiCi+9tY
 pOk1w/CtuvXh0G+JfcKENaTSO6MnLQVPkHZJmdCsm+HFFH9cIQWa2OcxDsPIf1ObopZeRpeXC/C
 Rw7e08RwkgmLo/hgLBFL+CXsWYA3pbBztxQjj2JotvynhzQTXZ53g9RJ7mcUmzQ3Th6K/TxtFPF
 5PQMTmmUxxzNDJaO+XO0/E1Me6zhVTtAsYFRjtayD5ZWRv1mlemaIk6NFoIZIUAjCtwPdRuIGJc
 /H2BlPNCmCxWLNr3DmbwSXeS7tncHFbrpVkAo=
X-Received: by 2002:a05:7022:e19:b0:11b:1c7e:27d0 with SMTP id
 a92af1059eb24-12be630e3bdmr938309c88.0.1774997257319; 
 Tue, 31 Mar 2026 15:47:37 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12ab970da7fsm12337226c88.0.2026.03.31.15.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 15:47:37 -0700 (PDT)
Date: Tue, 31 Mar 2026 15:47:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Nandini Persad <nandinipersad361@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 6/9] doc: reword log library section in prog guide
Message-ID: <20260331154734.5e1c774f@phoenix.local>
In-Reply-To: <20240621023254.4258-6-nandinipersad361@gmail.com>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20240621023254.4258-1-nandinipersad361@gmail.com>
 <20240621023254.4258-6-nandinipersad361@gmail.com>
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

On Thu, 20 Jun 2024 19:32:51 -0700
Nandini Persad <nandinipersad361@gmail.com> wrote:

> Minor changes made for syntax in the log library section and 7.1
> section of the programmer's guide. A couple sentences at the end of the
> trace library section were also edited.
> 
> Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
> ---

Integrated into https://patchwork.dpdk.org/project/dpdk/patch/20260118191323.241013-5-stephen@networkplumber.org/
