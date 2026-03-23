Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1BBF483C9
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 16:17:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D285640268;
	Mon, 23 Mar 2026 17:17:31 +0100 (CET)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by mails.dpdk.org (Postfix) with ESMTP id D782C4025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 17:17:29 +0100 (CET)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-128b9b7e3edso6990192c88.0
 for <dev@dpdk.org>; Mon, 23 Mar 2026 09:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774282649;
 x=1774887449; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/m4Vo2YdOdHauqtKKdQjjj2XMo2tiwp/4TsPhVCvXk0=;
 b=p65TBi8BlK/NsiUcRLu0YqmX+eSQM5zF8D1Wf+IdDxbGhkChB2NwG2oUHDhJHAf0cy
 qS4Y5qChcjspp4zyGg1In7+w4WiZeiulHYo6PguodyXAOjx23hRjfupG4sQEXvY3Jo3x
 4JJWR/pu5rHBDAtBoJr8mToBewd8PboCL36pmY/F/ez/nBN1b1TGvOYHFm0W7+s4UP5x
 mO5ulIyfyDnLSB8MLnulzR1VNWJIOGwv2p+aPWGP0+RfzRqss6G7K2w7g3ylqudfxSkz
 apeug+t9tfDdKTJZCTHQboWKdekLBhCTz9YP7Nd4yVwC/lyusvZwM/ZHy5C1VmSXmSMk
 1OcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774282649; x=1774887449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/m4Vo2YdOdHauqtKKdQjjj2XMo2tiwp/4TsPhVCvXk0=;
 b=lzy7lgPMlrXa6lr6lO3LXc/I/A7U29C/E7lDccCFYGDtnaIxvFl1g727zt0VSPqlqG
 iT72BNbWkz/Ie6dHidm+oHTHVj5YjlK1yo5kGbpt3ixkh6nL7lMdIy60YhpKezQNSISl
 in/iGYtumGrY6Oz257TqL4FZ7aQvSflLJsaXzlH1Z/E3juoRgzCkgdZWlhD05HyYFINH
 7T6qgO5NCmENJtpNtgI1v7rFpy8vHTXOkgU376QoC7f/wDOeUsJi4VFpEfE6OEVBjupC
 n4BLFLgTTN2jULOIutj68dDwJOo8W5uy5+bo6JIbOMVY3f7d5ABoPl/Fc21Q23gMrz/h
 VrLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL565/qnJDXtE83QPNu/JHuGoR0k1th1BGZAQ0ZCYKvk7t8G6pLDrUL/kFjRZqWTvmwys=@dpdk.org
X-Gm-Message-State: AOJu0YyaAqaE5kj5mDK8+ijwepei6jm9l6IjLDkN9rgfprRCZkwYLoeX
 NJToS7agVtq4F7kE8LYoqNmjNc6sAFztyhS/nZ1F93kgj0ZuZtPjzFd9gHApBtULTBQ=
X-Gm-Gg: ATEYQzzHPwjSn6UMC3Ravj0gLXgHpOeofVi80/5UO22C+WCYG4ewUsSvCw6P3iomelM
 FpO2LYDCYRk36jO3L51N6vb9QpkC8UYb2mmWRaazQb0xx/eOWstAvBzva3uQLq0MH21tlqxhESV
 UgBiTGI/EF5ml88LNw3QU6GD4Y1ljSADzQpdLnWkr9xFjot+gPNRmEuhzZOtZsxBrb2qXQ0X2U6
 K1PNrRUbZ3XUl7/Lge1H6hrcQ8dvjqA17WXgXXOrQrV3whH0+iLlfEk2/1Ly6OhDyKsXtAxnUbZ
 2IaGNNcD5Q/W7mZTy+/OB4Czu0Wrcrr62YdddMGMMZroR0+fJsDk39sTQqyr45IF74yzvITZd8M
 5Ql3YqL7F5FQwVQEfsb1BlXTtgJVTw2/2bYGclNbXWnl6BH9T3iD7GmE01wA+Gum1RusOS6Mvjk
 ct8dnB/5H+PW9h4CqkNVpYMzAU/KgjL4bcmWE=
X-Received: by 2002:a05:7022:e1e:b0:124:9acd:3b15 with SMTP id
 a92af1059eb24-12a726f86cemr6172620c88.39.1774282648782; 
 Mon, 23 Mar 2026 09:17:28 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b3253d0sm12809102eec.29.2026.03.23.09.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 09:17:28 -0700 (PDT)
Date: Mon, 23 Mar 2026 09:17:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: a.schollmeyer@syseleven.de
Cc: Aman Singh <aman.deep.singh@intel.com>, dev@dpdk.org
Subject: Re: [PATCH] app/testpmd: warn on shared rxq switch mismatch
Message-ID: <20260323091725.3440ad89@phoenix.local>
In-Reply-To: <20251125102207.428661-1-a.schollmeyer@syseleven.de>
References: <20251125102207.428661-1-a.schollmeyer@syseleven.de>
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

On Tue, 25 Nov 2025 11:22:07 +0100
a.schollmeyer@syseleven.de wrote:

> From: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
> 
> Shared Rx queues do not work with every combination of ports. Besides
> requiring the corresponding device capability, shared Rx queues also
> require all ports of one share group and queue ID have the same switch
> domain and Rx domain. When these fields do not match, shared Rx queues
> are not properly set up and queue sharing may fail silently. This can
> happen even in some less intuitive cases like multiple VFs of one
> physical NIC.
> 
> To make debugging issues with shared Rx queue configuration easier, this
> commit introduces simple checks and warning messages for all members of
> a share_group and share_qid to warn whenever there is a mismatch in the
> switch and Rx domain.
> 
> Signed-off-by: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
> ---

Why is this not handled at ethdev or device level?

Testpmd is just a test program. Real applications might make same mistake.
