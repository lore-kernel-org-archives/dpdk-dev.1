Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF69F54ACF
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 15:47:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70BCD402BE;
	Tue, 24 Mar 2026 16:47:04 +0100 (CET)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id 5BDA6402BE
 for <dev@dpdk.org>; Tue, 24 Mar 2026 16:47:02 +0100 (CET)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-128ebee22caso4449366c88.0
 for <dev@dpdk.org>; Tue, 24 Mar 2026 08:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774367221;
 x=1774972021; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tDLDaigtF+sSJ7aak+XNsuGHjQ5IdnE/OSO5qPKMHuI=;
 b=BT2pEdL7HGIxVk5VlKMUmiq2G3linwIhTgI7K77mBK9M2NssyrrvE/CC3RMV9FDA8q
 cuF1OrJjhc9nczDLf+E0OoPIpxrIFLtx8VfycjVvB3h3r+tcFi/UGoosYBRyalUubdtD
 pbFjBsYdwI9KLSx8yF3x0/cLdAFzd+kSQRGW9FuDi3fybJJG+OgMjKk5F8+Ycw7I1Dca
 Q81UPnY6qoRG10JJE/WwfwBl2BFI04yp1pJ6830JtA6q5R7gW4bhKWV/quW6xfbiFn3w
 Edw+x9KK35N83N7jzAeRF+8xtNFe4GB++JZMlhj/R6qMdUcyO+jQDFYVUf3JMLp/HZ3J
 nAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774367221; x=1774972021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tDLDaigtF+sSJ7aak+XNsuGHjQ5IdnE/OSO5qPKMHuI=;
 b=OrUym8mVEmAPO/OnEuctrU8XkhtQZrGeK5RHTg/LPKsLCDF0LAUjoaki2662gGxTRR
 GoiDvYsdVkebwjjQxFWsBoC3Ox9mrgajlu9Dh9wb9Cx4yeccZfLSn+20yOcNwYsOkApI
 KoU4xiOc3VXxkmbb2nXwOJb643svnEzNDojQcvuVl2kmq7TKOyLgcqahMFRJpHVPKLBA
 4jNcGXprgumIfjq+8QXJvSMwOeYYplyFp/Brw4m0ixbAQkq+vHuxg5AgvdDLN5dMWBAV
 LxZXm0BDvCUUyfvWidxpUmb6HrPO5puxU+7yWtwfESSFvlLIw873/fNpCdbOuNU/+dtF
 KioA==
X-Gm-Message-State: AOJu0YxDVd7EhelX/NUZcA4TKC1VP5ydcy7dq3lOlOO0k4/0K+iC5Sd8
 nUn1j/ZdN2sOa5/wOYXK4BRtwTnVLwDtjGrwROLS0FEmL6N4OAq+A8vRCw8/UaWXsek=
X-Gm-Gg: ATEYQzwMEIj1b5YMT1weSVWBKXxJjRyeA88zDD6QgzgeplVv2euDfg5GXdepaU0j0Rf
 2mwKWBDptmr8yxlU5P2RDNxtn1QvtFabcMbsTweq+hZTCrM6QDkjfflQddAr/IS0BAq030Lfmnk
 rBseixFFI5JAClaks9cBO36Ylpqvmkz3ASc1HUifz37xBiAkRzufAGUwirtedSPBK+HHANgA21S
 paWt03jns8qYWax2vSAw5Bfflg+TXraAng0bMKwWyInp2VFsGwxL/r7ObGNrvTtygEVlVjEA83W
 EemRdjdpfgL6y32ZO63xKDoRAWNasQ7iilaUl/Wdk1uLCTGgADjKF8zteFHnYYjpI/2n7/y1iXQ
 8+VshdKjm8Wld+gB2Zch8oAhybmrrh5bl1oZeKTbzsOO5CZi/nEUCGes/IkqMOE4DjKa+G0lPTU
 cJR7CeC08uxkz22gdC6XgA5wOzM01rhNql+y8=
X-Received: by 2002:a05:7022:78e:b0:11b:9b9f:426b with SMTP id
 a92af1059eb24-12a96ed357fmr7747c88.20.1774367221199; 
 Tue, 24 Mar 2026 08:47:01 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b17b8f2sm21161888eec.9.2026.03.24.08.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 08:47:01 -0700 (PDT)
Date: Tue, 24 Mar 2026 08:46:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: KAVYA AV <kavyax.a.v@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com,
 vladimir.medvedkin@intel.com, shaiq.wani@intel.com, stable@dpdk.org
Subject: Re: [PATCH v3] app/testpmd: fix DCB queue allocation for VMDq devices
Message-ID: <20260324084655.6d22c7fc@phoenix.local>
In-Reply-To: <20260324100500.2516672-1-kavyax.a.v@intel.com>
References: <20260313101553.1827216-1-kavyax.a.v@intel.com>
 <20260324100500.2516672-1-kavyax.a.v@intel.com>
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

On Tue, 24 Mar 2026 10:05:00 +0000
KAVYA AV <kavyax.a.v@intel.com> wrote:

> When using DCB mode with VT disabled and requesting more queues than
> traffic classes (e.g., rxq=64 with 8 TCs), testpmd crashes with null
> pointer errors because it artificially limits queue allocation to
> num_tcs.
> 
> For VMDq devices, use actual VMDq queue layout (vmdq_queue_num) instead
> of limiting to num_tcs. This allows VMDq devices to utilize their full
> queue capacity while maintaining compatibility with non-VMDq devices.
> 
> Fixes null pointer dereference when queue structures are accessed
> beyond the allocated range.
> 
> Fixes: 2169699b15fc ("app/testpmd: add queue restriction in DCB command")
> Cc: stable@dpdk.org
> 
> Signed-off-by: KAVYA AV <kavyax.a.v@intel.com>
> ---

I can't follow all the stuff here, is rather complex and esoteric case.
So did AI review.

The feedback from AI raised some questions (the I here is AI not me):


The basic idea of using dynamic VMDq queue info instead of limiting
to num_tcs is right -- the current code clearly crashes when more
queues are requested than traffic classes.

However, I'm not convinced vmdq_queue_num is the correct value here.
This code path is DCB-only (VT disabled) on a device with
vmdq_pool_base > 0, which in practice means i40e. In that case
vmdq_queue_num is the total VMDq pool queue count
(vmdq_nb_qps * max_nb_vmdq_vsi), but with VT disabled the PF queues
are what's used for DCB, not the VMDq pool queues. The PF queue count
would be max_rx_queues - vmdq_queue_num. Using the VMDq count here
could over-allocate or misconfigure queues in DCB-only mode.

Can you explain why vmdq_queue_num is the right value rather than
the PF queue count? Or test what happens when this value exceeds
what the hardware supports in DCB-only mode?

Minor: the prose line "Fixes null pointer dereference when queue
structures are accessed beyond the allocated range." reads as a
sentence fragment. Fold it into the preceding paragraph or drop it
since the Fixes tag already identifies what's being fixed.

