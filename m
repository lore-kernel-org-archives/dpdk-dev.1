Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0F3F54AD8
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:25:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C53440A87;
	Tue, 24 Mar 2026 17:25:47 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 591D740A76
 for <dev@dpdk.org>; Tue, 24 Mar 2026 17:25:45 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so408605ad.0
 for <dev@dpdk.org>; Tue, 24 Mar 2026 09:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774369544;
 x=1774974344; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tq23WTMUM029NyFJAkJEf8j3qXvO/1wW7E8rle+6MeI=;
 b=rWJkDdmDWNY/se8m8quJFMtsbGu38fMRibllE/OZYnmKXNVqd5sLUuGcnEEYgNwwG/
 LygF61BvtMHloq+CRmlTj5W386UEBBaBrQVQTL0YPIAyM6qRUVHOXIWYIQfjokJscpwh
 7WCgIUPJguBSITJGj2W2R6YsOlBvmMpEkgQSuQE2dAPkXIcg+YGF1JXXvsmQ2FJQkUom
 cvvWDVenU9XouMwkGn3U/tQRRjkl+2jZipEhvV0La4D0ACn9KajBlphGStyOPysz0Utc
 gXdZedb9kz9ocfBM5Kj3v508G0DynWzKerlTH5eu1O/ZfnJuiMGOFV4vG9ojWdc8xyq0
 2c1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774369544; x=1774974344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tq23WTMUM029NyFJAkJEf8j3qXvO/1wW7E8rle+6MeI=;
 b=BNDTBYldo2SqEcL5LRCYxB10duOE6REQIHSNsxFXQJgupebu9lYdUVUWb5yVwdtcyt
 rHOVbPiWzUhokq4Qqo36kZ4m4bG0+fhV80CVsSLH7RHQzVI1nkIXzg5y9zcaw2hTL/K6
 UyDBCBooS9pSmku+cjlXiY5l4IcrEo0Dh0IytMD5FeU5dBhVoqcgGvfxJVU9T6qoU/zm
 +2MLjSp2tFzAVCzxqiJ5bSddPYvuJjw+ps34EnmqL2AhwtKpACsx+ibOP9frSTmYYlHg
 nnBnA/XBzEjTIf6H6iGGlNKHyJHI5Aoa7U+mt8hRDmiiSEMhmXZhinvwwrF9iXeDZgja
 oiTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPzb1HP8xhnqpdo0ORaxbJZyoYmhHVqGRrUmAdOWZ9gqjhE19Nmzrt/6GRQgiJIU4Ipvk=@dpdk.org
X-Gm-Message-State: AOJu0YyRUU/qz32PcyyULyebo35CgnbUDC0cXliuKwWQFtevkC1q3WjM
 qt4/jdIg4V8VDCPBb+MQa3Q/21WHvNdEjeMMzlToKqcos+Ag0UkhXqPCzftx0caLeSA4F8WChdk
 XNNlt
X-Gm-Gg: ATEYQzwVew00nnwSD7LjIsa7ffnLg8TpGb4W4iF4qrJW1HemVkZBopELTRigltZ1cS9
 inzSWrbI97HhYyJR/Emowfqsj04PXE/WzU5ngN6NLQ9hdRxtPaClFRNpecvSj9P4Rx76Jd3AMZB
 qPh55qMcbPE8yX9zoh9Lz7s+edJ9h8E6ErGFr5XdHDU3DL78AMHJW/l2AH26IL7gIDIKwArlFge
 qcxIIL/t81QxfGDzlvtCSZZZXBsc90anoclJwkrFAHcvIAHillp852gxnC4R6fc3K47OIwtIVy1
 3rVujdHafMzAhnZmUAZzBhw6Nsk7XmbZcrNl36NRz0nZjrI0YWx+nr04FEweczCWUbpdZAcRTBK
 KykAkSqhr76EA6CrT9/UwvRkQLBvsM2nRLeJ564WYR9OXkQ9bB4JTGWVVSlVKy4T/mj2xNbNcci
 1R9gbWUMy6e2hOboy3d5lH6WX2qguuwI2C4MSEzC4ZX/C+6g==
X-Received: by 2002:a17:902:db0e:b0:2b0:5a4c:726f with SMTP id
 d9443c01a7336-2b0a4e0f962mr38486175ad.15.1774369544247; 
 Tue, 24 Mar 2026 09:25:44 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b08368ea1bsm185869185ad.68.2026.03.24.09.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 09:25:44 -0700 (PDT)
Date: Tue, 24 Mar 2026 09:25:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: <jgrajcia@cisco.com>, <dev@dpdk.org>, <stable@dpdk.org>, <bly454@gmail.com>
Subject: Re: [PATCH v2] net/memif: fix multi-segment Rx corruption
Message-ID: <20260324092503.69899293@phoenix.local>
In-Reply-To: <20260324161436.2816927-1-sriram.yagnaraman@ericsson.com>
References: <20260316155918.3756017-1-sriram.yagnaraman@ericsson.com>
 <20260324161436.2816927-1-sriram.yagnaraman@ericsson.com>
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

On Tue, 24 Mar 2026 17:14:36 +0100
Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> wrote:

> Fix dst_off being reset per-descriptor instead of per-packet in the Rx
> slow path. When processing chained descriptors (MEMIF_DESC_FLAG_NEXT),
> goto next_slot2 reset dst_off to 0, overwriting the beginning of the
> current mbuf with data from subsequent descriptors. Move dst_off
> initialization before the next_slot2 label so it is only reset once
> per packet.
> 
> Add boundary check in both Rx paths before processing next segment.
> If MEMIF_DESC_FLAG_NEXT is set but n_slots is 0, free the incomplete
> mbuf chain and exit gracefully to prevent reading beyond available
> descriptors.
> 
> Bugzilla ID: 1609
> Fixes: aa17df860891 ("net/memif: add a Rx fast path")
> Cc: stable@dpdk.org
> 
> Reported-by: Mike Bly <bly454@gmail.com>
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
> ---

This version go clean review from AI.
Applied to next-net
