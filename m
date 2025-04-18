Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F95C369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 18:31:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DE4A40430;
	Fri, 18 Apr 2025 20:31:20 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id 42A28402D3
 for <dev@dpdk.org>; Fri, 18 Apr 2025 20:31:19 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-b07d607dc83so1641343a12.1
 for <dev@dpdk.org>; Fri, 18 Apr 2025 11:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745001078;
 x=1745605878; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1WoPv5sgYCmVtlv7mOg5JZ/5ZKVqAkfEW6zmiXj9rUg=;
 b=eDqnihpOV/zcI9kjPkDpjZa4QoPvIr1T9A+kUDltKX1DTfnisoeEM64kXBAVWg93RO
 9bxCJVq/OPon7Rodcfb9++D3/qvIIoD5gnf4HyFHTFCqJwB1ZTUQnVZmxIGb86KxsOU4
 bVziobfX3Af1oasLHCD7T03t5ADqdHtxM3e1OOUYogEyPv+oOk2c2VL4x3Xzhm+8+ZCT
 6B1wrINogUXKrf5TNvQ7J60ccKZETFT0qSpxd2aBPqHCSpvt/Kx+zLjDLFSAzAT4jaXd
 VhxprVUzptG3S1SEAQB4lZCeglS+hCP4lY/QMQOupc8fRT5VReLUC7O9uTQZSKYPv92a
 F7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745001078; x=1745605878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1WoPv5sgYCmVtlv7mOg5JZ/5ZKVqAkfEW6zmiXj9rUg=;
 b=sQdMFYNJdwvdJuUgPL2IL7tW1HQdWjiF9rScnhgwScij3EKM6h78mmE0jcfxT3zjFF
 MBH89R7wQFBBt/fjWQYlcDCT/FbB5VVnWOVfxLpAOCVdhWPy2hnuG6cKO9yOjMzY04Ry
 tLohLQNrR3pmilptpOumn4im19uC1a6tUTQV9YXm5+EP1CkHjAPMgyZQDDWPPHCMS9Db
 UQcnvHKCA1frS1fUaXKovquFyPhXUcUNvsVjh6D2NZQ+RZcmQ9bHv7YsgDVbXEbzFcYi
 qyOd+Ca/Xn8+xytGwhg6ooOa5Hr6pV+300UexDENJiaAINfAcbQfL/wplbWbLVRrKe8t
 ZNtA==
X-Gm-Message-State: AOJu0YwFhCcDqF09dzqvN/M7d/JSANhlg3ytYg+lOgHCpaqE91HEGzd/
 fgnzO70mR1ys0qb9VLo8COuHXkhRAmHw7ttV1KpNO5JZp9rslB6Xnt1qb9YmkbXnZirC/BokDdL
 +
X-Gm-Gg: ASbGnctaHvXqE77XX3z+VEPmwEbdx66Y5J8i64fCpysKTh9WQ+nGtThfJTEay5Zr431
 5mdwksy7NSBMdZg2N25+t4XNjOpbMEjkjxMIyDeZwzGK7h52n8VB2UUPNES4acD7GnXRISiDb/s
 ryKpyRZW9euSXLTdrJnYdtSC+xA+BMImUdzTscHzH2ylDInMMQXLwUYpxS8f7wWPQA0a2CQ4RIk
 xCR53Egd9YbM+rAD8bXYpFl/i/wFpUV5mxC9Iqz09xf/FnbjdJ8bNYd1ZA26T37ijI6hydtEous
 EfSihM0K8iKW5JRWDoWPXQiSTeu74bsBvzz0QS1pEyBMeNXut+KeIwLuw1GUpGXsMND1855g3bG
 1vTw0Cqr46mPL/7/cUILArT385RM=
X-Google-Smtp-Source: AGHT+IHqjA0FqMxW0BgG+nxBodlcwojsYdFGeMgkFxqa8GrFzl9gG4vCt7Z3zc6DWhb1Sbzg3TSpUA==
X-Received: by 2002:a17:90b:5184:b0:2ff:618c:a1e9 with SMTP id
 98e67ed59e1d1-3087bbbb8a0mr4809822a91.23.1745001078431; 
 Fri, 18 Apr 2025 11:31:18 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df1cc9asm1554745a91.22.2025.04.18.11.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 11:31:18 -0700 (PDT)
Date: Fri, 18 Apr 2025 11:28:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Yi Chen <chenyi221@huawei.com>, Xin Wang
 <wangxin679@h-partners.com>, Feifei Wang <wangfeifei40@huawei.com>
Subject: Re: [RFC 17/18] net/hinic3: add FDIR flow control module
Message-ID: <20250418112804.51c698ce@hermes.local>
In-Reply-To: <20250418090621.9638-18-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250418090621.9638-18-wff_light@vip.163.com>
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

On Fri, 18 Apr 2025 17:06:03 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> From: Yi Chen <chenyi221@huawei.com>
> 
> Added support for flow director filters, including ethertype, IPv4,
> IPv6, and tunnel VXLAN. In addition, user can add or delete filters.
> 
> Signed-off-by: Yi Chen <chenyi221@huawei.com>
> Reviewed-by: Xin Wang <wangxin679@h-partners.com>
> Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>

Flow director is deprecated in DPDK and planned for removal.
Pleas support rte_flow instead.
