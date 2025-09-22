Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242BDCA100F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 22:12:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2930C402B3;
	Tue, 23 Sep 2025 00:12:15 +0200 (CEST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id 333C84021F
 for <dev@dpdk.org>; Tue, 23 Sep 2025 00:12:14 +0200 (CEST)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-7a97ed209cfso21369756d6.1
 for <dev@dpdk.org>; Mon, 22 Sep 2025 15:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758579133;
 x=1759183933; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IIkrnNIU/1Iq1Oj8DDeQuRbhW4DhWB+kPQPaJTzqkcs=;
 b=v954QrapeIC0A7xf6/OZnmwGzczXtVGA8CjWx1gp1kPypy5+4skvEKvIRSjegKTY1P
 WjCMg1A7lJ4ArCAey4DOxaaTTUsHwFR7vGtn+PGHetiVcXAVVvJ3qh+MFeYa80HATPy4
 tUnl9Emir1/W8lmgKts+QszjQVsApIdLuj9Hk4S5zT6iYMzgD3KXCK4AaEIO2W2jmlQk
 won7J3o68IJUyzbSk9iqvF5V24Zlweq6kRtMnaXc8+eRy9S4SgigUnc+R3dMy5dedkik
 lEAm0x0Fz34MeOvg0882WDk0yZ5Qi01mUCzngTgBjq+PVcB9AO0hEcxdw8gnzA05WzeD
 SymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758579133; x=1759183933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IIkrnNIU/1Iq1Oj8DDeQuRbhW4DhWB+kPQPaJTzqkcs=;
 b=W2+4RYADZHyX4Plzgp52PWnUNCqMVrh+t98eBMWgzR6bCHI4m2AokP9CvjbDTi75Ba
 KC6P7peg/uV1lrs2R9w1drvYuVbcShnbpx001nhaRThyTbgzw+s9/EIdsaYKBBX6020U
 kRRtEfwlkgEz48/NQwL2wsY7Bd+VcbLRMBRHZVDXCDjpiy2nXg3k7k+IVjQaJdRiU7fT
 PWDySRFwMlTGP2pd+pgCD73cFVKhL23NyyG8pKjm7KbkAuahKCGYAMJwMCPIGqBV0Xh2
 h3pqahd2Q6PMFhctN2j7XmHyCUGDT4EuTeRVJkeTUiGIIEqHD0o9VhPX2E3RiabELGRU
 EGQw==
X-Gm-Message-State: AOJu0YzoVwKTwWBPhBwNsYsKkVqIuhXvR0eniAI5hmPc2jsQ17TUqsFm
 bKlaEBnAqNRNMGJz3slaJ0nBWJgaqZYyvfv+UGio3iO2kYE73uiZTZN3lq72FATAFJM=
X-Gm-Gg: ASbGncvq9j1MktbArzJxKbH00mSHl+GPowE6/eWEw90YDjXJmPR/gmCL0sfGVTHAaLq
 upUykRere75nX2z9xfH0etbV8Fjk/dIOcRbt422iv10HZXbwZ6CKU7wjIKgE9sp2gQgCPWqLP2J
 NH5uomGTP/Kgh4RvhJMd1M+osgSfZmzyhj5+rK4e4qURP4LTomPNIHi59WZaTAe7+Quo7D7jhef
 0IVZufsjG3btO6s9sXOoksijpe6SMYfzvDgeVxwBi8y4kYJ9jcKSy7ejl4O+ViJ9sIp5l5on6pL
 0OkiaENBSVrnibsqf3u4T/xJQZ2pRf5Du8EyruQcz0Ul+01kq7iCYPXqMxWgRy94LqB9WRJN326
 xcbKKhwXzrm6sb4lIO4Qe7oeKMVBzH/Z65rI2aDvt2N9d17Cjm2bdi6IGii6F6jJxo8MRFezerk
 s=
X-Google-Smtp-Source: AGHT+IGzTmS4BPEJa+m0JAtnoxaqcBv7yCXGP2poyRGUKifWcNFsaKFhAuNhCL+Y3gogpRv7gTDP+A==
X-Received: by 2002:a05:6214:2aad:b0:78f:48ef:d8c with SMTP id
 6a1803df08f44-7e7b463da65mr3406456d6.22.1758579133279; 
 Mon, 22 Sep 2025 15:12:13 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7b0c0934e27sm40740506d6.64.2025.09.22.15.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 15:12:13 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:12:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, alialnu@nvidia.com, stable@dpdk.org
Subject: Re: [PATCH] net/tap: fix build with LTO
Message-ID: <20250922151209.2ce1a474@hermes.local>
In-Reply-To: <20250922073043.2394557-1-david.marchand@redhat.com>
References: <20250922073043.2394557-1-david.marchand@redhat.com>
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

On Mon, 22 Sep 2025 09:30:43 +0200
David Marchand <david.marchand@redhat.com> wrote:

> The compiler has trouble understanding that the code is actually pointing
> at the data in the message past the nh struct.
> 
> Update the tap_nlattr_add* helpers and the NLMSG_TAIL macro passing a
> pointer to msg.
> 
> Bugzilla ID: 1511
> Fixes: 7c25284e30c2 ("net/tap: add netlink back-end for flow API")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
