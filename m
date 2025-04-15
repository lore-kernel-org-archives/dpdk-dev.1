Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29103C369B5
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 00:19:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE0E4402A1;
	Tue, 15 Apr 2025 02:19:46 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 0BDDF40289
 for <dev@dpdk.org>; Tue, 15 Apr 2025 02:19:45 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-224019ad9edso63870195ad.1
 for <dev@dpdk.org>; Mon, 14 Apr 2025 17:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744676385;
 x=1745281185; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4+uHoXxIuggrw+bitzfRTPFvhaB6rBiF4IkysosnIw=;
 b=Whxt/b7YmvFzx0DZogZLKTWta82YBxbP9QTd9UupicdKNCpSeAPkCx+x0Q3lDkzWYa
 qPhO2guNiZ3uSPMuJL1SoI6u8s2koib+/WWhlF0Gao1op9PlGWFAC4cfl9gfR0WvWmbH
 yyqlpRG94pzjf2ymCPRLT8RxeqcD+ZwFIJw5cEDWHV1IV4bvSCrP5iU5Dq2cNhtMBcit
 j+HvFtN/3r4f7k+Og+x8QsbPQEmdXJ2XH7PVbC3DwfUv8joTrl8zxpqGexuDiKOZHCCh
 /mKGiVLFvVu4QuEbFxDFEPuNGAw5CiDGnsYFHeKEK9kmUecQWLTUU55kUKycPzP2UOWB
 tDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744676385; x=1745281185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h4+uHoXxIuggrw+bitzfRTPFvhaB6rBiF4IkysosnIw=;
 b=ZYu6sP2c+Q9WjoT7LQdAKkP6giw1x1zJrOlMpWHzLBkgH4W7//I9EPYan95tBYgzYu
 oAcT3rLzkXH+l65qwQ+tVNlBriWQZGKHzpT6qTtVbex4PNxsFIdzzlML2K6YOIsJOuxN
 6PNWLqzOWxRUcytyjUj5eSUdtBfJzHZx3YHA8iJYYi4mE2DLAQjIm0z7+sA9V5/w6AzS
 xpA9Yv7cfm0Jbj7BxOz0TAd/Sciuiwv4NRvA6cc91eSQjBEycJcSYm/DIudpwuG4XIS5
 HCnck3cEFCDLOAZ06gcJ/tPnlUqXKX2UfkJYlpGmRDf7lG8zYBBrDeFqvgwn3zKUYBUV
 e1pg==
X-Gm-Message-State: AOJu0YzTT9B3sjhHoonsaAehxL/30rp7zk/LX0GtNG3vGVtT4tBoGCzt
 mmP+6yWb+vY3DBRR1h+Tk9K1Nd90BUYsZYJJnlmwSyuWZe8d6RqAWd7wqkVe1EoTrHMpuy+NYFR
 Wr9o=
X-Gm-Gg: ASbGncuphgEE/tl3i7bYlUZExg+D/Q8n3Fof9p8/Rc/+DLsCnF0fmvqnoZfjfzYKeY7
 xag+zjAiCwUTOMyC9jNholSTGCBaK/lJ5px0TdsJ9SGRHiTtIqFxPOMVID5o850Vm/j0fnGQrKY
 gAUZrocNRuMXxhHAoz90hiY8vk+VGGhUCF9vbrKreA6zJoUL646d+5oMfkWFnpHpZXDe6ZxpyV+
 u+nAk/Bnf/UicX5x6vXjkx1xrpb3o1vhUerM9jQiVxr3hn5Jw1OPYEwsofXmOnA1TNQ7jXaTU02
 +04dM6QZ5kZFyDq9Xq8QnE/ixbRwukLgDASj8HBoPyWF9//ZiC+y7bhwK4AQ7zAFEPVMLI/Hdvr
 051GmqkrFrCSJW1d0Q5Wg/5OKZ88=
X-Google-Smtp-Source: AGHT+IGOPs1BrAlh8QfNjx5WL4fbjpjKGFHTGar78Ll1JkovcqsYtXIRxv+xfBvGUIXKt0EntlYmug==
X-Received: by 2002:a17:902:d4cd:b0:224:1609:a747 with SMTP id
 d9443c01a7336-22bea4bd2c0mr185767705ad.31.1744676384703; 
 Mon, 14 Apr 2025 17:19:44 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7b654a2sm106030755ad.49.2025.04.14.17.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 17:19:44 -0700 (PDT)
Date: Mon, 14 Apr 2025 17:19:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit
 <ferruh.yigit@amd.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [RFC 02/13] ethdev: allow start/stop from secondary process
Message-ID: <20250414171941.77636d94@hermes.local>
In-Reply-To: <20250411234927.114568-3-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250411234927.114568-3-stephen@networkplumber.org>
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

On Fri, 11 Apr 2025 16:44:39 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Before this patch if secondary process called start/stop
> it would only impact the secondary process, the ethdev on the
> primary process will still not be started.
> 
> With this patch, when start/stop is called from secondary,
> it calls the primary and does the operation there. The design
> is generic, and we can later add queue and other operations
> as needed.
> 
> Bugzilla ID: 73
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Wanted to expand this to other functions like rte_eth_dev_configure()
but the structure rte_eth_conf has grown quite large
According to pahole
        /* size: 2280, cachelines: 36, members: 8 */
	/* sum members: 2268, holes: 2, sum holes: 8 */
	/* padding: 4 */
	/* member types with holes: 3, total: 4, bit holes: 1, total: 1, bit paddings: 1, total: 29 bits */
 The biggest offender
there is DCB and VMDQ both of which are features I doubt anyone ever uses,
but unlikely to get that fixed.

Because it is so large, it is impossible to pass rte_eth_conf over the mp
primary/secondary API.
