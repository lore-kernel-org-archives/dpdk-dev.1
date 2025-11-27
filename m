Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C32DD116E1
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Nov 2025 00:07:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39BFC4029C;
	Thu, 27 Nov 2025 01:07:22 +0100 (CET)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 5A3FC4013F
 for <dev@dpdk.org>; Thu, 27 Nov 2025 01:07:21 +0100 (CET)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-8b23b6d9f11so23316585a.3
 for <dev@dpdk.org>; Wed, 26 Nov 2025 16:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764202040;
 x=1764806840; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xyzhTCvZU+zu8MPUgTHGBQzYDMap4FnEa4KivFK12kE=;
 b=vgShC2uY1AnbHB+Q/pwbkLqMAoE3SqErZ2eeGrW4isEdeEuU8IKra+0aR48CJcHOQz
 mGYqIgQA4pbuR89ZPhOtz92QWpp95eg9BgGDhhQ2EyYhtO83gMN5lbhFUx481Fl8N0AG
 t/xKvfvLP+p0qD12N11jp2CH8qA72KUtGjxobzgZNoChS1p5mquH8Vz3taoEIZ7Fg7ya
 evhvy7pV6sUWTx1SHeFJUxcHsprl/itUv1KezUpvwRKVX6XQLHUpoGyLUNAy9wceDGlx
 YrA1BtJNbNGy7xpSgmocguvi3W6a4uWMTKwkKlwRfBowVDRIDZ08jOYxbzhMgIUEcjQQ
 HJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764202040; x=1764806840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xyzhTCvZU+zu8MPUgTHGBQzYDMap4FnEa4KivFK12kE=;
 b=FXwUpOipUSB1UblI/fg0hSfq9gPfc4DQcc1JR0rFebq6Wkpp+D+TlyvrfcGf7NbDuU
 q3iewW2NZ6k2moICEIc1R3jrcxn+8l8X+NN3jgj3MsrLz2+J6K+VrMouQXMfn1Rui2wC
 pG1LjYjNeSFcW0JIxyRT0Y2hScVlgDLlCrWUqVMGGVXq5/sBoPGwfbYROkjdem9/Jx/U
 TIpZeCKFGwyDVSkZl7FE+5maMoZY7dc7Lpx8Cv3Ve7c6zEafsARYPggj5ZIOYKt7RPQj
 QWPcC/kliVeBfpSW7lPOZsQWAnwmQVGLpTJsjUeX6xiljviFvf7/EAThYAWIYvaHuqzj
 Dw4w==
X-Gm-Message-State: AOJu0YxhqCrRIg0TsYNM1CEbpWxJvwVOWWGv1cy4pdguXIkth37VHt6z
 GuguYTn9VztXCP0IkImHwZD26fDK5cUeeFg42sYsue0y/2enMKqZbSVowi6djh8Nga/u3KS2lUR
 xpo6o
X-Gm-Gg: ASbGncs/H7EZc/QbjRtEv0w1NCWE0pADbU1j3gy0OOty5jvZlu7RoJLJ99htr9ybrid
 Ybo9CrXa7SfOumBkz8wXbC//XtvZPcuJexv+9k4nmZhd5arKmiFneI0JQSXmXxSKEoeeIeh2dN+
 qikXf1pl+RCaPmd9Je4B31+6G1FWxc+M6TuroamfNQyyymS8pcIFaot/Ur34x0XwSGz0z25e4kW
 IVHqpf61U7LwG3kCN2bsXNj7WW7ctmbXUa3c8yQv9Ma0z4DRLdCpiDDw8MHzWc705XQ4OqcsZ1S
 qaOJ101iPKKRRgvQ4XNgx+QprKAuBivX5CUPLdD0OcuBwuwD9eb59tivrlPVZouoskvmsokRbir
 63Dj+py5FK8+7Ayqk0eLgQ8/B99y28qrVhmoewAWJxrTkJM9IYG4VUDelh6ut8488UshB+bMAIX
 SPKNi3IJNKqIKVdMxkr/z6vwe0V4Vt65/k67odPGiuRp+Pe0Pdy/U6
X-Google-Smtp-Source: AGHT+IFSIrpagn1eJzdKW/poakbo8kkCHg2wWXs1LO565lyexibc19h1kziLrMOiR2MpmxdVovfbeA==
X-Received: by 2002:a05:620a:40c9:b0:8b2:664a:309b with SMTP id
 af79cd13be357-8b33d482768mr2983904385a.84.1764202040419; 
 Wed, 26 Nov 2025 16:07:20 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b529a9c030sm3143885a.21.2025.11.26.16.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 16:07:20 -0800 (PST)
Date: Wed, 26 Nov 2025 16:07:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v1 1/1] net/nbl: fix Rx/Tx stats concurrency
Message-ID: <20251126160713.3943bcef@phoenix.local>
In-Reply-To: <20251126025436.3714568-2-dimon.zhao@nebula-matrix.com>
References: <20251126025436.3714568-1-dimon.zhao@nebula-matrix.com>
 <20251126025436.3714568-2-dimon.zhao@nebula-matrix.com>
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

On Tue, 25 Nov 2025 18:54:36 -0800
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> Queue statistics are being continuously updated in Rx/Tx burst
> routines while handling traffic. In addition to that, statistics
> can be reset (written with zeroes) on statistics reset in other
> threads, causing a race condition, which in turn could result in
> wrong stats.
> 
> The patch provides an approach with reference values, allowing
> the actual counters to be writable within Rx/Tx burst threads
> only, and updating reference values on stats reset.
> 
> Fixes: 661c0ccf2512 ("net/nbl: support statistics")
> 
> Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>

First off, many drivers do the same thing as the current code.
I think virtio is the most commonly used driver with same memset.

They just zero an accumulated buffer.
The SW counters are not meant to super exact (not a good idea to bill
customers based on packet counts).

Your new method using a stashed old copy, still has races.
The old code would race the zero with read/modify/write of the increment.
If the race happened the zero might happen in the middle of the modify
causing the value not to be zeroed.

The new code is less of a problem but assignment is not atomic on
many platforms, especially for structure size objects. Therefore it
could happen to get read of stale data.

If you really want to have reliable statistics in SW, you
would have to use atomic operations, and pay the penalty of the
additional locked operations in the fast path.

PS: FreeBSD has the same problem in many drivers.

