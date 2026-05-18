Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF48ACD4F49
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 14:54:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA3DC4060A;
	Mon, 18 May 2026 16:54:26 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 1E98F402D9
 for <dev@dpdk.org>; Mon, 18 May 2026 16:54:26 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2f68f3b075fso9213489eec.0
 for <dev@dpdk.org>; Mon, 18 May 2026 07:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779116065;
 x=1779720865; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LG8cj0+riXv2NiRg+j0y73voXKtoJjkn/r1RRhqQJZg=;
 b=j1QXfuI2NrpYsDO1irYfhcnfsrNXJ/sRfHaDpvZDPvL2jrQkKyG9kNp2GgwbVZpC3R
 MZlEx3avWszb7MVTja2+GXvGVlFSSVGfIIKsyXS00HqXBn7PoeKdYp7a7SRIOJ95kUib
 a675aS2sVXvm2T3vgaVmnFXGgMNR7XlvuT7Db68zHcpWkjO6N2rUq/wIFPUg7EWPnobS
 2WXjHO1L/t7T9tUHdlagHwTTu1cOjLrVPKa09UUf2dYFpWrPKL82qg7X2BLhtMheS3z8
 AvPXj6dvxALB5Lf8mc8VjNrQ4Gb6wXwIkKbBXFYMaeUzg4I/lGOA5luqb0zcyZU7aqFu
 o1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779116065; x=1779720865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LG8cj0+riXv2NiRg+j0y73voXKtoJjkn/r1RRhqQJZg=;
 b=PNW9lWwCISOr9ToCWVa3Rt1js2/4CFab5VM0yJAhB9upHzBh4DVA40tFFxnzf9570w
 djmbvBC1eNBRJxbDfuLXsJl2k7J97jY2hzu6ySKt/RtDPAQ0G+/4zD1G382etitVMn35
 4z/g/K0t4T2A1rMTKfDRp8tnI/FNkyxFtz/jkcaBpbKLf1AV9C4Pi+Jz3RjRfGFnrfNP
 jEJEcv7ozXhW5TP//V2q5YR6X+EpWMe8KjNWRzGm8S4C1Jd3mzSheEfh0VTGf/mHvl1t
 1urSv6QLBCn0G1ZgejS6JIxONBT3eVPDTX2HhKOF11mcAv5IwB6DniSeHKVVfTRblGvk
 pVPA==
X-Gm-Message-State: AOJu0YySAQxO2FvJ6XzUZJEbfeer4fDemWWWHKK3KMzFrLrmDHOOSLqW
 bagbZG+wFU0xHGcWQC3b0kC5JiB3DtYHEfttRDxn1N3jMFStXbQ/0X9yuLOgyaPkVWZBeXh8/lh
 r3WnK
X-Gm-Gg: Acq92OHw9i9oWTXEX+g83wZb7JQp9kZqZa3uJEOvVTAjC9lCVGxmbvL2dOz1pms1KXv
 g9CkvGPGm+3XotQv3Ar2PfqY+RMgAkuUg91YAbUcZYTqnMSI091A7k2KkKod5ymSS9NW3f3K9P9
 cdL0QKMG8DFQsv/uue+UceU0EE3XyGTyNCNjyV7/xS9y3JwqaGagzFSjOk9euJeMtArcQWH1ij/
 d/y7ympc6iazQVEecNAY9ookOeHHn0KNGrnkadMLRjYe0S0VeiY+gGvWqgCbCxuYiaK5zGxKDdg
 JiZoWNJtUX8Trus5uEfwFBAmCgP9HuUkUFfPYj8h9zUkhq3AFgPiZRgLqVfR1yJ1fP3Z0i/spTS
 DfL9Br1yNw+IoIlc3cHfCF2J4x/Z97ECIwwcmVW4EXFs5185qYTT6e0IN7uTsELmVVL9WZkSk/5
 ePAcMnIfEadgn9q+gj6sv1EJY3wCP9B1TqqMzZ2ZVZS+ShkA==
X-Received: by 2002:a05:7300:8184:b0:2ca:8099:ffc0 with SMTP id
 5a478bee46e88-3039813d598mr6723130eec.7.1779116064851; 
 Mon, 18 May 2026 07:54:24 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbcb93f3sm21057696c88.3.2026.05.18.07.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 07:54:24 -0700 (PDT)
Date: Mon, 18 May 2026 07:54:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 00/20] Wangxun Fixes
Message-ID: <20260518075422.4d1adf2f@phoenix.local>
In-Reply-To: <20260511103604.19724-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-1-zaiyuwang@trustnetic.com>
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

On Mon, 11 May 2026 18:35:42 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> This series fixes several issues found on Wangxun Emerald, Sapphire and
> Amber-lite NICs, with a focus on link-related problems.
> ---

Since these are fixes, they mostly standalone.
If you want I can cherrypick the ones that review cleanly; and you can
then address the ones that have review feedback.
