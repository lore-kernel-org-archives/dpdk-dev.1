Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC90C3ABDD
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 13:49:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E4C440666;
	Tue, 20 May 2025 15:49:52 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id 7B5CB402AE
 for <dev@dpdk.org>; Tue, 20 May 2025 15:49:51 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso5370702b3a.2
 for <dev@dpdk.org>; Tue, 20 May 2025 06:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1747748990;
 x=1748353790; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L7UDWp7mF1+0/se5JGlwizdhLWVAsII5ayOqdvXw44w=;
 b=EvX46I79+rtXQQv16S/pOlFpdBfcpb9tSJ7on+uwnLQ/AVQyf1MNHdwP4J/sunStTy
 uMtYu/2Ra9ZDBxWGYyy8OwfCPqJlicztqxTpLp2q+TRa+nKMeUDsjnffVhjkfkzka1WS
 iu4MAvuINbSYUNJcd8Riig4R2H5SrtWqLNZ6xyGL3uKcvwABH+s6GTQ85K6AloXGEXdK
 JJnRPeon47puH7VmZLTON90Xd/HLrDAtFIBDD4Bq5JShXE6fYjh96X0BqVa4Q9ciutGG
 oMVFkpRgVgY5h7XjHtsD2I6vA+GKJSfeAsNoXnk85xSr61IQv0VwljS2yedlVGzQ/qZg
 5Bjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747748990; x=1748353790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L7UDWp7mF1+0/se5JGlwizdhLWVAsII5ayOqdvXw44w=;
 b=t7qZAC28XiZYxYmFzbu7r4saNuWfkutObmx4wxn9WCJDZiyp8g25gxDZIX1pkz+xn1
 WhPXeD68C1jbxblon7KqlimRpeWYMgn2DnAzP7ZcZc5HJQHLbi1RuuU2vBL91oQ66mpu
 gdZ/tRvpqavFcK8zi6YExixB5Uol+6uoo6wSdVkstSGfNwLQQ90tul6e2fi2nnEs1YIp
 AwefzlO2yurkXxUdq1RB7fGjkvTBrjLQDz1L8keKf09OvZmVb+FmS0NtYH/X1vJPEIAU
 Zmh8MpsF7Gw0RT/Oe1iEq6me8ex5Z4D0jydsTWk1dUJFJCzgbM/1VQt0TfO0OegTEzC/
 pl7A==
X-Gm-Message-State: AOJu0Yzdq+hmX6B06fEjP6BBLO/ct1V+jwev6Hj4eU1TRiQ15I8/t9/r
 chEPKUpcq8gYjyRolOmpOPIajgJKPz9wzolTBHoDkI/AAD7g0snpK3Kij3qEULECl+vNK7CFSaR
 XmcEdOOQ=
X-Gm-Gg: ASbGnculS39ZCYot9RYIt/CVjcgxRAA88NfvqaiS6zD30BJmWTbhsbjyIzxM6docadb
 MGmUDx4mQr9GMgBFge3V5Jl2fle3+6VQDXbWebPwz6TXtbUA4kjvZ1LxuaM3lOsjWXWCyKm7msM
 c6FvedEkUs4TseAUH2Pt8jKvfFrYyj21LP/1IqUuo3Wzw1ZF8pOX7hpWjNuVn+rolhjHEPLRzoR
 kr2s1sR0HGEsaBM0Diku9nuPydwPp8M6VCSOuGObvZfNOjuILKmUcD95yArkpgTXT/Vf/jtRBMe
 I0PvYT9isMalOkaPEogXrST3vvDIQatTxf8XfUAK/41eRhK1f64f6B41ymnYdQfkI/K7qZM6LZU
 xeYOoDFu/k/vTIWa61OsxKilQ3Fk=
X-Google-Smtp-Source: AGHT+IFLA7CfH2KI+Mbl1/W0AB+ft+RjhWhtNzk9NFstVnUnKWWVVitXwKbPRYFjldMVDug8fZhchQ==
X-Received: by 2002:a05:6a21:8889:b0:218:17c4:246c with SMTP id
 adf61e73a8af0-21817c42518mr16858621637.14.1747748990354; 
 Tue, 20 May 2025 06:49:50 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a970e29csm7941556b3a.72.2025.05.20.06.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 06:49:50 -0700 (PDT)
Date: Tue, 20 May 2025 06:49:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: nan he <nhe295771@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [Bug Report] KNI Module Causes Loopback Interface to Have
 Incorrect ifindex in Linux 5.4.46
Message-ID: <20250520064947.513b73f9@hermes.local>
In-Reply-To: <CAFohB5uoG8Sx5LXiX8F8QihT=ov2yR5rzgbaVNeodmYedy5S5g@mail.gmail.com>
References: <CAFohB5uoG8Sx5LXiX8F8QihT=ov2yR5rzgbaVNeodmYedy5S5g@mail.gmail.com>
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

On Wed, 23 Apr 2025 13:52:39 +0800
nan he <nhe295771@gmail.com> wrote:

> Dear DPDK Developers,
> 
> I am reporting an issue encountered in an environment running Linux kernel
> version 5.4.46 with DPDK 19.11. When attempting to run Docker containers in
> bridge mode, the container creation fails consistently. The kmsg indicate a
> crash during the initialization of the loopback device within a new
> *net_namespace*, specifically due to the loopback interface not being
> assigned the expected ifindex of 1.

KNI is no longer supported. One of the reasons was that the KNI
kernel module is not upstream and has lots of bugs.
You found one and it is unlikely to be fixed.

Please use other mechanism such as TAP or virtio-user to inject
packets into the kernel.
