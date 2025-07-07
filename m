Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA45C83F07
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 15:56:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98D6640287;
	Mon,  7 Jul 2025 17:56:57 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id ABADF4025D
 for <dev@dpdk.org>; Mon,  7 Jul 2025 17:56:55 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-7d402c901cbso301751485a.3
 for <dev@dpdk.org>; Mon, 07 Jul 2025 08:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751903815;
 x=1752508615; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LX1KuZKb4DSvdPXNfzloFzdNrnrOnMnXgY/s/LV/NmI=;
 b=F2KBOD1M3Piy85U4cYgnq9DJsfxpkHuwbLdtZLX89k9FpMxNN2MHGYlC0ObxbGmB4+
 yQPxAwsZxOddPHPgmcreQTZQzCCWQv3O9dCKHRV+jWftGZOi5j+QYmINpokIxS3LgVVx
 5vFMq0yIMRdo13W/PSOMYujek8w9edyS/vVRInKrLRbecFJbOfX6+rf+4k9POKyDlVcd
 GZwghkuN4l9hkDyJYppTJu1UijSR1W20Oz90Qoo55zMA3CTOQXXrb7IQvtwyzDyPVG+r
 bCyivjrctxAY6YnS9lec3W6U6XFHWPYUmfE3EQermiTo0JuMXb8Rnaf3bGKMMUIB1GO9
 07MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751903815; x=1752508615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LX1KuZKb4DSvdPXNfzloFzdNrnrOnMnXgY/s/LV/NmI=;
 b=LZW908XHOlwIvYwAImHn+RR+IsBIgwtu58DaLbrbQuihSl8sCf9LwNjERd81HErWCu
 HXk6tjn9as6oKxC4DqNTYknJRYB/b2J2XSxBwHKGtsNAcnnmYNtsetT5NYW28tTSDW+i
 jhaB9Xgd6HZXaEsmjLN4DUI8j0m9pc1T/D0BYlpoTZviw7DeSgEmDYYP7RRC2KEoF84Q
 lk+eLKB5Y+Xb3TZuJg8ooCHTChEDkAQQWtLB5uAXBWm2VtvgmJzfPIj7w1J9T2HtjQUk
 A2itb27Oq0Y8yTpcR5wGRm2GxoB9dimSUcv7uHLzlrCoG9BN9XvG/d2DxOOpzyd7lwEF
 LXtQ==
X-Gm-Message-State: AOJu0YyOjEsDEabL+ZuX0AkfFOPhMSbMTwDMC6Ks3/C58CIWFDAoZasA
 Y0DWN8YOE5mjEMf2iI8SPwV3t7W4OjRvzuJiFsQMx48HuVMp5izTcSr24OfvWLVlpppZicE31ww
 NpSoD
X-Gm-Gg: ASbGncusxqvAsN7q6C1Q3l3Qrk2RmO2rLC8KfEI6gV68AqyFpxrDVWHuJIeud30hI8m
 CCLhBsGNYQEhM64rxCthsg4rzZyASyI1X4KF5R2adzbH67CYhBy2XH8+8sWtbNCrY5/tXk8XeQy
 bcKLvbkRs2ZYHbEtTLgZCZ2WPzBoLCd5o3NBGTY43VjqG2Smrs2r+hEGoZ322DHch6ix2OYunPs
 QaZl7zxAwXYpJ3xOgL1LO7tMIIl0H/csC5KVsw13ZnmEslGYBeP/H/8ie0JMMj8upzfbKaZAH51
 qH2DyOFE7VF49suhbnJF6TtnqGQ0M1ATLvPB5pCV+AqOTQ3nfRx29f4QrX5UDq0Du8XYIGRavEO
 xlNafLuRdwtBj9hrnU8Pg0xfzFvxUblSevYIPEAev8hjuqdjdtg==
X-Google-Smtp-Source: AGHT+IGFAAGbfEOJQJbUVMfY2OiecTycJd9fYgkG/tZsMjYppc26Eqp9qk9M51XdR/uZM0IyvTw6Vw==
X-Received: by 2002:a05:620a:a807:b0:7d7:71e:5283 with SMTP id
 af79cd13be357-7d7071e52b6mr855267985a.43.1751903814727; 
 Mon, 07 Jul 2025 08:56:54 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d5dbdc4623sm622292985a.50.2025.07.07.08.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 08:56:54 -0700 (PDT)
Date: Mon, 7 Jul 2025 08:56:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 14/14] net/sxe: add Solve compilation problems.
Message-ID: <20250707085652.6d863cc3@hermes.local>
In-Reply-To: <20250707115819.12826-14-liujie5@linkdatatechnology.com>
References: <20250704025401.301617-1-liujie5@linkdatatechnology.com>
 <20250707115819.12826-1-liujie5@linkdatatechnology.com>
 <20250707115819.12826-14-liujie5@linkdatatechnology.com>
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

On Mon,  7 Jul 2025 07:58:19 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> Add Fix compiling issues.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---

The patch series is not build in CI.
Please fix each patch so that it builds on Linux with GCC and Clang.
The overall patch set needs to build on all supported platforms before review.
If driver doesn't support windows, that should be handled via meson.build

