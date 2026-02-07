Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6682EE6B77
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Feb 2026 06:11:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D205D4042E;
	Sat,  7 Feb 2026 07:11:21 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 5F340402A9
 for <dev@dpdk.org>; Sat,  7 Feb 2026 07:11:20 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so29030015e9.1
 for <dev@dpdk.org>; Fri, 06 Feb 2026 22:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770444680;
 x=1771049480; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RDWQmVxi3tme5NvpFZ9N0IEBNk/DFfrxYIN51W4vPFM=;
 b=MS08k983Ld+p1rXOtwU6C7S47A2k3oKeQYELTnmEet+ONzKVNUYhxUV5JCKXljWsxS
 RcWPVWi842wdqMa+1uN/sXQKAcYxaH07w/SDDtJIzEZdrn/MqMxqaPsxTl4yd5y6cwEQ
 5NYZK5I8eaLLTobKDnEUQcAhZjgOdJi0tkma7K7mfpqHlA+nCDtdo1mmfAieFHjGpp3x
 a9BLXRMAG3f5R8q+UfO73PKTdSEUDOKKa0xHIrApH9Sj6csm30xChkNtkzvgijDw3RJP
 8PaSALH+gTPzTFcNUIEZbXmFe4O8Z0Wk3DjvoYw4N85BsAc7SsT5P6QsO86iMEdQvlLS
 YBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770444680; x=1771049480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RDWQmVxi3tme5NvpFZ9N0IEBNk/DFfrxYIN51W4vPFM=;
 b=kWERgWHob8hQ+6PxHsC3DWsEuMOV7FZCMZ9UtBeresBFAEHQrC4i8M3mDMhheEeB6a
 acodWShKTFi9lxx4+t2VcI1jgX1jHyW4gioSB4DgiB+xLxkYoCoT1fzj8VHLzx2Cy32q
 IRnh0+VU0PdDqxc2PUfVkYV6hIdXJ3P1qXflBK1W9L4pfua00OSaYAMsC87t6mT2C2mP
 oqTixFoMjIBDuEbvMpzolPqfTbOJ9BigkkSfOQh+ln/TEFcLUCPcfdjzX2/Vhm8hW2Ha
 7Qixt9STXevGBzBBAlBNtPMh1RCaBXSK7FecUz6JnF0N/dn94vushvRytHtwVm8GywlR
 DAeA==
X-Gm-Message-State: AOJu0YxncZMK1NvoJPEaguG8kL4S0bN4b40hE3rAb2b1GO1n1sjz/SOR
 G9oR/zmChcnzP7fs7qUevtQD2CXDfVmtmiVR5PZ+KErd2GfsMnhPG9xmdnj59vuj9AE=
X-Gm-Gg: AZuq6aJDWnnN2/53lmm2MbVa8ov4ntX98kN8kdHJ34UqP9dOdcJvL9CIoOHJwph0jP+
 SXzx5U+MMdBy9pQvpUMtJHQwNWgZeEapyBKyqmqg0zBm0vzrEBQmQ5LmDTGD2a8BmSLg/ZabWG7
 pc7+6c+lCBSE+IUbjIlPnF5rD1wembl45VIsbrm8dqYGtV74l78hL+m7w4BYgwHo9rUDcn0/7Hc
 DryG67lf954M2PEN/NaiDNh73zXOBFbPpYBvCETrjnJQXcKjqc/tsGIF4ZRoVidBXJCBprpy5F9
 ttdih8L26ZGLt0Vlx9MQNLApZMD2qLOw9POYUEj9y5B6nYd0+P5UsNyR2N6XnDJNTnsJr60S3e4
 cN26pjgkUIN/IAIWCJ3InX0NsxUQ4Qwi9X3Sg0rMC04KqoKx5I+JungK2baOMFsJsxtDqMsaDlZ
 upq3u77UQ7tzaTHPRPbEqC0Pwf22qRS6Z/z2rKREmbnyX8e7itvSz1
X-Received: by 2002:a05:600c:8719:b0:482:eec4:76d with SMTP id
 5b1f17b1804b1-4832021b461mr77837915e9.17.1770444679558; 
 Fri, 06 Feb 2026 22:11:19 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48320719bf4sm94996495e9.10.2026.02.06.22.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 22:11:19 -0800 (PST)
Date: Fri, 6 Feb 2026 22:11:14 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kevin Traynor <ktraynor@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, david.marchand@redhat.com,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, stable@dpdk.org
Subject: Re: [PATCH v2 2/2] eal/linux: handle interrupt epoll events
Message-ID: <20260206221114.423e498f@phoenix.local>
In-Reply-To: <20260206172054.273858-3-ktraynor@redhat.com>
References: <20260128122055.192104-1-ktraynor@redhat.com>
 <20260206172054.273858-1-ktraynor@redhat.com>
 <20260206172054.273858-3-ktraynor@redhat.com>
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

On Fri,  6 Feb 2026 17:20:54 +0000
Kevin Traynor <ktraynor@redhat.com> wrote:

> Add handling for epoll error and disconnect conditions EPOLLERR,
> EPOLLHUP and EPOLLRDHUP.
> 
> These events indicate that the interrupt file descriptor is in
> an error state or there has been a hangup.
> 
> Only do this for interrupts that are read in eal. Interrupts that
> are read outside eal should deal with different interrupt scenarios
> appropriate to their functionality. e.g. virtio interrupt handling
> has reconnect mechanisms for some cases.
> 
> Also, treat no bytes read as an error condition.
> 
> Bugzilla ID: 1873
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>

Minor AI review nits.

Code Review

Errors:

    Lines 295-298: Block comment uses incorrect style Same issue as patch 1 - should use /* not /** for non-documentation comments.

Warnings:

    Line 304: Return value inconsistency The function returns -1 to force rebuild of the wait list, but this happens in the middle of processing multiple events. The existing code had the same pattern for error handling, so this is consistent with the codebase style.
    Line 342: Log level changed from ERR to WARNING For a condition that causes interrupt source removal, WARNING may be too low. Consider if INFO (as used in line 300) might be more appropriate for consistency.

Overall Assessment

Both patches address a real bug (busy-looping on interrupt errors) with reasonable solutions. The main issues are code style violations with comment formatting and a minor semicolon error. The logic appears sound for handling the EAGAIN and epoll error conditions.
