Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40A4C982ED
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 16:39:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FD9440E2B;
	Mon, 21 Sep 2026 18:39:58 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id ADF4240298
 for <dev@dpdk.org>; Mon, 21 Sep 2026 18:39:57 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39b31b4281eso3157879a91.2
 for <dev@dpdk.org>; Mon, 21 Sep 2026 09:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790008797;
 x=1790613597; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YmkHm2uBvfdwf/uaB+IWdoqJb5mlNVket4d9t6k7MD0=;
 b=EI4/sb4zWjaDDKlHqaVb4maFnkif0IE1bLVWKz2w8jdm/lAMNkOIhAI9Kk57YDNDy6
 DqOAXuvnrm4Hkq4XNgQncZsTWPbU4l3CYMjByx7Zm8gwxP03XRuIa7DyR6AhOdNKtjLk
 nEhvw7aN1dfTgaKo9P3Q20k64JW3/HckAL7gR3OMDsPS8ViXx/pJn/UNhB5NL8rIzDYv
 pvEPczzwWybWqgrkD7Uk2X+7omIVKcO1sKQqbqRNAenfGjPXTOPuFUd9zLgX+1qAodra
 dB+6/ap163+mS6ZmOGjPU8HfKa/p4qqU5OGWwzaeEp0YxVaPPf9/vqZG6k03u0ILDgHf
 wP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790008797; x=1790613597;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YmkHm2uBvfdwf/uaB+IWdoqJb5mlNVket4d9t6k7MD0=;
 b=Fl3CMeSkkh/+uxCaXjvOrdLhzPfp2C0t7MNoLqinmhIOnmjNtvO5HZn+/BtxamdKcx
 w36A6xVGVDxsAkIe/M6tZeiXYKm/2A3vj5oMIMalNyYRySk7bghmuWIkbNrXqjT0rdN+
 b2XN+gWiotlYRK9A1wNALqkG30evMTNFQIofHZxb2JB6hx5EsWWsbe95Dh8ArwOR8Htl
 YQMyOhxvA5XD6JT//75IfVC8ghK+dQR4MBUiZXlis2y9g5++TMHZOH4ly2ZILXyuNPgB
 1cRz4APs0avEoFzklW7Vu0DjjAagZyZQRQorEa4/Pxex26mSrMBSQ7ggWMnOiyIn96cr
 dgvA==
X-Gm-Message-State: AFuF++l9UCBc5oT6S4nkaYPwuS+EKxBGrSnt6JWSfZvkvDmWBs5egi+P
 QvDNw++Ugorq1j0+GOzbIccbaThBlTzsVBTMpfpGCs44/cKkAB/oUM19nq5SQqWGZo4=
X-Gm-Gg: AYBFou0mB1q7CcAp6lfeFhMWijZEhENxbA1/nOAj25XbRC/NYlUppjSch2+5crgQdWy
 NtEYNvmulDCbWZKmVLUK8PH4AXmlsSx+vm/F+nuP3PGoZnuRlk1pkgRuJdhLzgc5XBoT0TfK14Y
 kDYXGEghVbxrXWv+v0F+GWlSjyI4rvAA2bUh/HHXCanKr5fTUiGQDiaBsApUit3Swr8Oa2xgIfO
 cr+O5l2JQcj2sBc5Fdg82UUNxX621B9/Zfl+kOHlHGPwam+Yqkx3cmrjAI8OxEOlYgR2dkktP92
 cs+5wyXKkzSbp8nAANRcHiUTbhtn2NL3/z0w8R9R7rWYRg1kpXZOIbs8a4ymPLHl5FJ1V86FHjg
 9wbqQHZKY7qOt6ByoznQFcMJr3BtrpqN8hjx1JVYCHbNjXfLtPuLxfgdFM03KrTZzhz4sm01tsM
 hhS+EvmZ4vyn4NVwkg7LzEgRjqifwe/zPrlXRQFYK9cGyv7M2hbhlPH+ngxz88uqwlfVrDeRDCB
 1wIAtSo8qo9yhyujhX+t/T/4m2WdksSKEjdWfJB
X-Received: by 2002:a17:90b:2584:b0:39e:6c68:c787 with SMTP id
 98e67ed59e1d1-39e6c68ca2emr10436675a91.61.1790008796765; 
 Mon, 21 Sep 2026 09:39:56 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0670b410fsm134148a91.9.2026.09.21.09.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 09:39:56 -0700 (PDT)
Date: Mon, 21 Sep 2026 09:39:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com
Subject: Re: [PATCH v3 6/9] test/vdev: find device with public API
Message-ID: <20260921093922.4b0a3154@phoenix.local>
In-Reply-To: <20260921114737.2334589-7-david.marchand@redhat.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260921114737.2334589-1-david.marchand@redhat.com>
 <20260921114737.2334589-7-david.marchand@redhat.com>
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

On Mon, 21 Sep 2026 13:47:33 +0200
David Marchand <david.marchand@redhat.com> wrote:

> Checking internal API has little sense as users are not supposed to call
> those.
> Use public API to achieve similar coverage.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
Patch 6/9 (test/vdev: find device with public API)
Info:
- get_matching_vdev("") and get_matching_vdev(NULL) previously
  verified "match any vdev" behaviour with an empty/NULL match
  string. find_vdev_by_name() has no equivalent case, so that
  behaviour is no longer exercised.
