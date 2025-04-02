Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FCFC28B20
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 14:28:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9135140273;
	Wed,  2 Apr 2025 16:28:42 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id CD36840261
 for <dev@dpdk.org>; Wed,  2 Apr 2025 16:28:41 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-7359aca7ef2so317330b3a.2
 for <dev@dpdk.org>; Wed, 02 Apr 2025 07:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743604121;
 x=1744208921; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O8GeR7as/yPeZlRQuOyubh6QlVvR+mCQ60YZKpE9jxM=;
 b=ffLTggIsjq5scwxTP8j0jYq+kFv/x/YF5UzK+/Pe9FtWCHpp2IqY9olipYseSKHKlO
 tNNtYYvKyTTxMrr3ta3UhCTuePXgrzQrht5GgEDvApoYn0l78/NXluKSNFmuj87EElXR
 AHRMAlmxQlGdjSzANi7tbzarxHNLelcuRFvBrkfayBvolLQvrIbGPRqCvh7f9Edhqky6
 cfULWo1KaPGKxQGTCMGql7n5q9bBWCSGOhhMQttpILQxne9JIwdaZUv8ykOddZYaVeii
 KWt4snXlcdSagRsPUTRfiLgKUQn15MDLxWIjb6CWtf0ykE0QLYa1WB8/QFdZWPXqO8Lq
 Tekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743604121; x=1744208921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O8GeR7as/yPeZlRQuOyubh6QlVvR+mCQ60YZKpE9jxM=;
 b=rCn+N94JE0G4CvCp+YDywsBMnn0sqrUKrVVsRCcuADO/D5CNTE4Frk4fwRi7k40oUH
 KvCwGBWUpNqvuheYQv7fSv8t2yf5eYT8+/pqmiz/ZAVO31zqNt80owEI0sH2bD+Ud8Fs
 HiDJkI3/OqLd6kjsWpz6UXWkpvRlxe05kw9aLH+Wkt/x9YdYyD4l3JsTBOlTULFx7Dp5
 nhJPjL1RhfTjA5hCA8Tb6Sz9V/5q7k5NfyPwo7SKbr4L1fFRtBcxjdeFE6Ic8rrRNTQc
 WWJBDXiyytjMeHII61o/pCw1LOrgfK1EV5oTZFoNmSf4dzPFMBuGb8Y0SaiIHxiB5Ar3
 m80A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd3s6mCS1Xo3mbwHl72yh4312jEqhxvgzF7dKZ3KHjCNYACba1c0he3JwR28he4lD5zp8=@dpdk.org
X-Gm-Message-State: AOJu0YykoBZOUYeXjpaJwJAUXb2qJRISmMFVv1VSru3J05oZ21+2rebE
 Loci+6O2PIZcaU/bLmuu7Bq6PeTmMEsRggViMvsPzkvHNiNDtOp2yZgA1sSGjh8=
X-Gm-Gg: ASbGncuHzCeatk+sFlxMHzylH7V9wpvu11tiHX5ozf4lrMUQh5zHsQ1shqs7L29KdXc
 88T/wKn4RoChlLCtO6gVbkK00QcQcFZOjHzhNcCMQoz6TbS7i0uQyJ5j8GWF6EqmULOGasJ8HwD
 8to5/g2safla7QXq1BhKcZo4Z4nrZNxP3P/FOldG4EfzKM0Pv10mPL0zbAPDT4YNm0CbMosG97I
 9kuBTGfpAFaq9oatbrB8jWvbmblNirWprQCnasCjSJ8LoMsIsbVrGFOkozMHVatYWEZBAxXS9Gf
 Ve/d8940TQtItps0duxdSgSqZBUmAPCYDR3hXiijk164ToCUKr7SH9ovwyB9ip/hWszoQNroYdk
 qBD2UQobX+r0hVnzsk4ho
X-Google-Smtp-Source: AGHT+IGGis8JX6vkpJI082ujC9pYF7OexGc5i7ifJ3pAJQyblAAlT9uORI9OeOiaNBVr0SGF5S6EmQ==
X-Received: by 2002:a05:6a20:c78e:b0:1f5:837b:186a with SMTP id
 adf61e73a8af0-2009f5ba6b5mr29678899637.6.1743604120969; 
 Wed, 02 Apr 2025 07:28:40 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73970e1d922sm11059985b3a.37.2025.04.02.07.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 07:28:40 -0700 (PDT)
Date: Wed, 2 Apr 2025 07:28:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Nandini Persad <nandinipersad361@gmail.com>
Cc: Ori Kam <orika@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 Ferruh Yigit <ferruh.yigit@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org
Subject: Re: [PATCH] doc: reword flow offload and api docs
Message-ID: <20250402072838.6479484c@hermes.local>
In-Reply-To: <20250331214036.17295-1-nandinipersad361@gmail.com>
References: <20250331214036.17295-1-nandinipersad361@gmail.com>
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

On Mon, 31 Mar 2025 14:40:36 -0700
Nandini Persad <nandinipersad361@gmail.com> wrote:

> I removed low level details of the code and simplified the
> Flow Offload section of Programmer's Guide to be more about the
> general usage of the APIs. The specifics were moved to API docs if
> the details did not already exist there.
> 
> Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
> ---

Looks good, fix the spelling errors and resubmit please.

WARNING:TYPO_SPELLING: 'wih' may be misspelled - perhaps 'with'?
#3558: FILE: doc/guides/prog_guide/ethdev/flow_offload.rst:579:
+- Flush: The function ``rte_flow_flush`` destroys all flow rules associated wih a port.

WARNING:TYPO_SPELLING: 'behvaior' may be misspelled - perhaps 'behaviour'?
#4142: FILE: lib/ethdev/rte_flow.h:4403:
+ * is missing at the specified index, then the behvaior is undefined and

total: 0 errors, 2 warnings, 4087 lines checked
