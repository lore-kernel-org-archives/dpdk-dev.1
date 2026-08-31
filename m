Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8C8C624A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 15:12:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B31240269;
	Mon, 31 Aug 2026 17:12:50 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id DB8E64025A
 for <dev@dpdk.org>; Mon, 31 Aug 2026 17:12:49 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cc1b838f9b6so4132680a12.3
 for <dev@dpdk.org>; Mon, 31 Aug 2026 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788189169;
 x=1788793969; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=py/oG8ZpCCd31flPByvZW6U6RDuiJ0DnpDvPh7Y8Fz8=;
 b=rJJzrDzpwdNbdq4zpql1GQmgUd2mworii84eZ8avWap9DRUO1NjfuodGLxxTt6oHt+
 F19imj8p7zTHmy/GEAwdKnUjWGDyL1nn2BBIKYLY8rQ9qkhby4avKaxAc72N16jeXwzS
 nWQdSVCkkXAwNyYczzkwoTqCUxwV7JLhJIG6bHM4d8Xur0ZFI91DcjhzUXNBExfXMIY2
 QJjN6gs2BRrYl5YGHIqrf2x3xXIcfzwUNV9u1I10LjXWYg6Y5Gn06dln0IJCw+guWdI0
 49sDhU2ov7m98LX/C6iNLLOZZt6M2MZtfVqhP43CMALsk0zAO4WCWGH6AEeF2k5pi5gt
 hVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788189169; x=1788793969;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=py/oG8ZpCCd31flPByvZW6U6RDuiJ0DnpDvPh7Y8Fz8=;
 b=Rg3PZEYRB3o7ODtlylz9TYOAvpM+vl2sSB8CtoUtG7CmFfkVjERGy4vhwmwWta9DNU
 el2BCrGsqHKUlJi+vafjD8qq6hfPfN5jWJcAHZOLE1n+tDxTmf6LRPWIr+325E2Ala/O
 w6dk/M7Vp29KJcyyYI8f7DmR3WPRC/SBFw6tGI8+tPe6Fq77IygCP9KU00DVpIwNuNua
 Pl0s+ivC1fMGxli7+c6JVzFeUKp0UREZbisOE0t433zNKtzuNP7sDs4AatKwuu46253F
 pg/OyuHHpNP2xjFzKQ9Kx3u/+tObfNYFBW//lLTLnyJS7L6Vcot99eGe7owOWLyJfjEL
 0TUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByOyfR1gXYToX3RD/ZyEOGZ+j1CyiSaUxv11z9Nfm1W7voGb4k1Jc/ogGCb1QflJUla14Y=@dpdk.org
X-Gm-Message-State: AFuF++mVDW0+pi9LG2ELtBRNXhlZViQOfVNtcczNMTf33NT8ILbBYhUe
 WX0HV794JJK5fxEOBvQ2LlLjooqCqniY24bZPYbw2J0yO+rrqYDVF0d7QDXWdpBIXTM=
X-Gm-Gg: AYBFou1i5HIvSWj4G3Q1JInjf1Vk4KcYFhyO6iIZYX18SzgW4cCITj+WIvxm2otBC+7
 zXwjZs0mwm6Jl/pNR88fsSnue7NaXbvF5IbI/y6UtBGuzZ7zBnyMg3qlqRzuQE/9FpkKJscAHZi
 8hfH/XZ5KQ6hFqrZktcvCbqyOSnN3Zr/uJ0GK5RivP05BkFaY44Y9f228XUH7IM2s0Id3T3n5w5
 QXBfRWAZKISiAA5Tq1Vl9ocQLpj0fP4BCSb12csZ6drYRfg7U9ONUnJXj7pAXgWFmIzBRXB8a5p
 E3iI3iDQSjplTYQ0BVuYR2Elco4cqlY0hD6BHePWCJA+Lrj8043KXVFh6HOTJJZaROKbT27aB4y
 sDICvS5TpII79kVoHbkFH1WbHbQOhLEX39o1iTYrRZCL87OrLurV1rV38C0OLkrHnUOS1S+M2H0
 mqU1p53zjGMrZ0EQ6onWrpKWvwLI5bLrSx4n1zcfK63pWI0kEdYi0krW/VmDpHb8pvkrSXMVS9q
 88eELRGyr3GJ9/Td3Lw9SQU/c4hHQ==
X-Received: by 2002:a17:90b:528f:b0:38e:9eb2:9d43 with SMTP id
 98e67ed59e1d1-39907e113f5mr2087960a91.16.1788189168721; 
 Mon, 31 Aug 2026 08:12:48 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0e0e67dsm27226834c88.15.2026.08.31.08.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 08:12:48 -0700 (PDT)
Date: Mon, 31 Aug 2026 08:12:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [PATCH] test/bpf: use unit test suite
Message-ID: <20260831081239.658c078d@phoenix.local>
In-Reply-To: <8ecd0e24395d4a5eb53c6c4355f73cf7@huawei.com>
References: <20260830191349.604934-1-stephen@networkplumber.org>
 <8ecd0e24395d4a5eb53c6c4355f73cf7@huawei.com>
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

On Mon, 31 Aug 2026 08:34:58 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> Hi!
> 
> > The BPF tests registered 23 separate autotests. Collapse them into a
> > single bpf_autotest suite run by unit_test_suite_runner().  
> 
> Some of these tests still don't pass with sanitizer enabled.  With them
> registered individually there was an option to ignore these failures or only
> run the tests that are known to not contain UB. After lumping them in one suite
> running BPF tests under sanitizer is going to become much more difficult.
> 
> There are other reasons why more granular tests are good, like ease of tracking
> or debugging failures. What are the benefits from collapsing them? What is the
>  actual problem we are trying to solve?

The only technical difference is that meson runs individual tests in
parallel and have seen some failures on my machine.

But for me it is more about decluttering the output.

